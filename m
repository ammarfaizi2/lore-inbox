Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSHJA5j>; Fri, 9 Aug 2002 20:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316519AbSHJA4f>; Fri, 9 Aug 2002 20:56:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21266 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316491AbSHJAzl>;
	Fri, 9 Aug 2002 20:55:41 -0400
Message-ID: <3D5464E3.74ED07CC@zip.com.au>
Date: Fri, 09 Aug 2002 17:57:07 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 6/12] hold atomic kmaps across generic_file_read
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch allows the kernel to hold atomic kmaps across copy_*_user. 
>From an idea by Linus and/or Martin Bligh and/or Andrea.

The basic idea is: when the kernel takes an atomic kmap via the new
kmap_copy_user() function it records state about that kmap in
current->copy_user_state.  If a pagefault is taken then the page fault
handler will fix up the copy_*_user state prior to returning to
copy_*_user.

An optimisation to this (Andrea) is to use a sequence number to detect
whether the copy_*_user's fixmap slot was reused during the processing
of the pagefault.  If not, and we're on the same CPU then no fixup is
needed.

The fixup code in the pagefault path will rewrite the CPU's ESI or EDI
register to point at the fixed up kmap.  This means that the caller of
kmap_copy_user() MUST be using a copy function which uses ESI or EDI in
the normal manner.

The interfaces are designed so that non-x86 architectures which are
using highmem can implement the same trick.

If a different copy_*_user implementation is written then new fixup
code will be needed.

The only new copy_*_user implementation of which I am aware is the
"efficient copy_*_user routines" from Mala Anand and colleagues.  They
use ESI/EDI as well - this code has been successfully tested against
those patches.

This patch uses kmap_copy_user() in file_read_actor().

This patch breaks the ramdisk driver when it is used as a module,
unless you've applied Rusty's patch which exports __per_cpu_data.



 arch/i386/kernel/i386_ksyms.c   |    5 ++
 arch/i386/lib/usercopy.c        |   10 +++++
 arch/i386/mm/fault.c            |   71 +++++++++++++++++++++++++++++++++++
 include/asm-i386/highmem.h      |    5 ++
 include/asm-i386/kmap_types.h   |    3 +
 include/asm-i386/processor.h    |    2 +
 include/asm-ppc/kmap_types.h    |    1 
 include/asm-sparc/kmap_types.h  |    1 
 include/asm-x86_64/kmap_types.h |    1 
 include/linux/highmem.h         |   80 ++++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h           |    5 ++
 mm/filemap.c                    |   11 +++--
 12 files changed, 189 insertions, 6 deletions

--- 2.5.30/arch/i386/kernel/i386_ksyms.c~kmap_atomic_reads	Fri Aug  9 17:36:42 2002
+++ 2.5.30-akpm/arch/i386/kernel/i386_ksyms.c	Fri Aug  9 17:36:42 2002
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/tty.h>
+#include <linux/highmem.h>
 
 #include <asm/semaphore.h>
 #include <asm/processor.h>
@@ -74,6 +75,10 @@ EXPORT_SYMBOL(pm_idle);
 EXPORT_SYMBOL(pm_power_off);
 EXPORT_SYMBOL(get_cmos_time);
 EXPORT_SYMBOL(apm_info);
+
+#ifdef CONFIG_HIGHMEM
+EXPORT_SYMBOL(kmap_atomic_seq);
+#endif
 
 #ifdef CONFIG_DEBUG_IOVIRT
 EXPORT_SYMBOL(__io_virt_debug);
--- 2.5.30/arch/i386/lib/usercopy.c~kmap_atomic_reads	Fri Aug  9 17:36:42 2002
+++ 2.5.30-akpm/arch/i386/lib/usercopy.c	Fri Aug  9 17:36:42 2002
@@ -11,6 +11,16 @@
 
 #ifdef CONFIG_X86_USE_3DNOW_AND_WORKS
 
+/*
+ * We cannot use the mmx functions here with the kmap_atomic fixup
+ * code.
+ *
+ * But CONFIG_X86_USE_3DNOW_AND_WORKS never gets defined anywhere.
+ * Maybe kill this code?
+ */
+
+#error this will not work
+
 unsigned long
 __generic_copy_to_user(void *to, const void *from, unsigned long n)
 {
--- 2.5.30/arch/i386/mm/fault.c~kmap_atomic_reads	Fri Aug  9 17:36:42 2002
+++ 2.5.30-akpm/arch/i386/mm/fault.c	Fri Aug  9 17:36:42 2002
@@ -13,6 +13,7 @@
 #include <linux/ptrace.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
@@ -129,6 +130,70 @@ void bust_spinlocks(int yes)
 	console_loglevel = loglevel_save;
 }
 
+#ifdef CONFIG_HIGHMEM
+
+/*
+ * per-cpu, per-atomic-kmap sequence numbers.  Incremented in kmap_atomic.
+ * If these change, we know that an atomic kmap slot has been reused.
+ */
+int kmap_atomic_seq[KM_TYPE_NR] __per_cpu_data = {0};
+
+/*
+ * Note the CPU ID and the currently-held atomic kmap's sequence number
+ */
+static inline void note_atomic_kmap(struct pt_regs *regs)
+{
+	struct copy_user_state *cus = current->copy_user_state;
+
+	if (cus) {
+		cus->cpu = smp_processor_id();
+		cus->seq = this_cpu(kmap_atomic_seq[cus->type]);
+	}
+}
+
+/*
+ * After processing the fault, look to see whether we have switched CPUs
+ * or whether the fault handler has used the same kmap slot (it must have
+ * scheduled to another task).  If so, drop the kmap and get a new one.
+ * And then fix up the machine register which copy_*_user() is using so
+ * that it gets the correct address relative to the the new kmap.
+ */
+static void
+__check_atomic_kmap(struct copy_user_state *cus, struct pt_regs *regs)
+{
+	const int cpu = smp_processor_id();
+
+	if (cus->seq != per_cpu(kmap_atomic_seq[cus->type], cpu) ||
+				cus->cpu != cpu) {
+		long *reg;
+		unsigned offset;
+
+		kunmap_atomic(cus->kaddr, cus->type);
+		cus->kaddr = kmap_atomic(cus->page, cus->type);
+		if (cus->src)
+			reg = &regs->esi;
+		else
+			reg = &regs->edi;
+		offset = *reg & (PAGE_SIZE - 1);
+		*reg = ((long)cus->kaddr) | offset;
+	}
+}
+
+static inline void check_atomic_kmap(struct pt_regs *regs)
+{
+	struct copy_user_state *cus = current->copy_user_state;
+
+	if (cus)
+		__check_atomic_kmap(cus, regs);
+}
+	
+#else
+static inline void note_atomic_kmap(struct pt_regs *regs)
+{}
+static inline void check_atomic_kmap(struct pt_regs *regs)
+{}
+#endif
+
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
 
 /*
@@ -187,6 +252,8 @@ asmlinkage void do_page_fault(struct pt_
 	if (in_interrupt() || !mm)
 		goto no_context;
 
+	note_atomic_kmap(regs);
+
 	down_read(&mm->mmap_sem);
 
 	vma = find_vma(mm, address);
@@ -248,8 +315,10 @@ good_area:
 			tsk->maj_flt++;
 			break;
 		case VM_FAULT_SIGBUS:
+			check_atomic_kmap(regs);
 			goto do_sigbus;
 		case VM_FAULT_OOM:
+			check_atomic_kmap(regs);
 			goto out_of_memory;
 		default:
 			BUG();
@@ -264,6 +333,7 @@ good_area:
 			tsk->thread.screen_bitmap |= 1 << bit;
 	}
 	up_read(&mm->mmap_sem);
+	check_atomic_kmap(regs);
 	return;
 
 /*
@@ -272,6 +342,7 @@ good_area:
  */
 bad_area:
 	up_read(&mm->mmap_sem);
+	check_atomic_kmap(regs);
 
 	/* User mode accesses just cause a SIGSEGV */
 	if (error_code & 4) {
--- 2.5.30/include/asm-i386/highmem.h~kmap_atomic_reads	Fri Aug  9 17:36:42 2002
+++ 2.5.30-akpm/include/asm-i386/highmem.h	Fri Aug  9 17:36:42 2002
@@ -22,6 +22,7 @@
 
 #include <linux/config.h>
 #include <linux/interrupt.h>
+#include <linux/percpu.h>
 #include <asm/kmap_types.h>
 #include <asm/tlbflush.h>
 
@@ -76,6 +77,8 @@ static inline void kunmap(struct page *p
  * be used in IRQ contexts, so in some (very limited) cases we need
  * it.
  */
+extern int kmap_atomic_seq[KM_TYPE_NR] __per_cpu_data;
+
 static inline void *kmap_atomic(struct page *page, enum km_type type)
 {
 	enum fixed_addresses idx;
@@ -93,7 +96,7 @@ static inline void *kmap_atomic(struct p
 #endif
 	set_pte(kmap_pte-idx, mk_pte(page, kmap_prot));
 	__flush_tlb_one(vaddr);
-
+	this_cpu(kmap_atomic_seq[type])++;
 	return (void*) vaddr;
 }
 
--- 2.5.30/include/asm-i386/kmap_types.h~kmap_atomic_reads	Fri Aug  9 17:36:42 2002
+++ 2.5.30-akpm/include/asm-i386/kmap_types.h	Fri Aug  9 17:36:42 2002
@@ -19,7 +19,8 @@ D(5)	KM_BIO_SRC_IRQ,
 D(6)	KM_BIO_DST_IRQ,
 D(7)	KM_PTE0,
 D(8)	KM_PTE1,
-D(9)	KM_TYPE_NR
+D(9)	KM_FILEMAP,
+D(10)	KM_TYPE_NR
 };
 
 #undef D
--- 2.5.30/include/asm-i386/processor.h~kmap_atomic_reads	Fri Aug  9 17:36:42 2002
+++ 2.5.30-akpm/include/asm-i386/processor.h	Fri Aug  9 17:36:42 2002
@@ -488,4 +488,6 @@ extern inline void prefetchw(const void 
 
 #endif
 
+#define ARCH_HAS_KMAP_FIXUP
+
 #endif /* __ASM_I386_PROCESSOR_H */
--- 2.5.30/include/asm-ppc/kmap_types.h~kmap_atomic_reads	Fri Aug  9 17:36:42 2002
+++ 2.5.30-akpm/include/asm-ppc/kmap_types.h	Fri Aug  9 17:36:42 2002
@@ -15,6 +15,7 @@ enum km_type {
 	KM_BIO_DST_IRQ,
 	KM_PTE0,
 	KM_PTE1,
+	KM_FILEMAP,
 	KM_TYPE_NR
 };
 
--- 2.5.30/include/asm-sparc/kmap_types.h~kmap_atomic_reads	Fri Aug  9 17:36:42 2002
+++ 2.5.30-akpm/include/asm-sparc/kmap_types.h	Fri Aug  9 17:36:42 2002
@@ -9,6 +9,7 @@ enum km_type {
 	KM_USER1,
 	KM_BIO_SRC_IRQ,
 	KM_BIO_DST_IRQ,
+	KM_FILEMAP,
 	KM_TYPE_NR
 };
 
--- 2.5.30/include/asm-x86_64/kmap_types.h~kmap_atomic_reads	Fri Aug  9 17:36:42 2002
+++ 2.5.30-akpm/include/asm-x86_64/kmap_types.h	Fri Aug  9 17:36:42 2002
@@ -9,6 +9,7 @@ enum km_type {
 	KM_USER1,
 	KM_BIO_SRC_IRQ,
 	KM_BIO_DST_IRQ,
+	KM_FILEMAP,
 	KM_TYPE_NR
 };
 
--- 2.5.30/include/linux/highmem.h~kmap_atomic_reads	Fri Aug  9 17:36:42 2002
+++ 2.5.30-akpm/include/linux/highmem.h	Fri Aug  9 17:36:42 2002
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/fs.h>
+#include <asm/processor.h>
 #include <asm/cacheflush.h>
 
 #ifdef CONFIG_HIGHMEM
@@ -10,6 +11,7 @@
 extern struct page *highmem_start_page;
 
 #include <asm/highmem.h>
+#include <asm/kmap_types.h>
 
 /* declarations for linux/mm/highmem.c */
 unsigned int nr_free_highpages(void);
@@ -71,5 +73,83 @@ static inline void copy_user_highpage(st
 	kunmap_atomic(vfrom, KM_USER0);
 	kunmap_atomic(vto, KM_USER1);
 }
+
+#if defined(CONFIG_HIGHMEM) && defined(ARCH_HAS_KMAP_FIXUP)
+/*
+ * Used when performing a copy_*_user while holding an atomic kmap
+ */
+struct copy_user_state {
+	struct page *page;	/* The page which is kmap_atomiced */
+	void *kaddr;		/* Its mapping */
+	enum km_type type;	/* Its offset */
+	int src;		/* 1: fixup ESI.  0: Fixup EDI */
+	int cpu;		/* CPU which the kmap was taken on */
+	int seq;		/* The kmap's sequence number */
+};
+
+/*
+ * `src' is true if the kmap_atomic virtual address is the source of the copy.
+ */
+static inline void *
+kmap_copy_user(struct copy_user_state *cus, struct page *page,
+			enum km_type type, int src)
+{
+	cus->page = page;
+	cus->kaddr = kmap_atomic(page, type);
+	if (PageHighMem(page)) {
+		cus->type = type;
+		cus->src = src;
+		BUG_ON(current->copy_user_state != NULL);
+		current->copy_user_state = cus;
+	}
+	return cus->kaddr;
+}
+
+static inline void kunmap_copy_user(struct copy_user_state *cus)
+{
+	if (PageHighMem(cus->page)) {
+		BUG_ON(current->copy_user_state != cus);
+		kunmap_atomic(cus->kaddr, cus->type);
+		current->copy_user_state = NULL;
+		cus->page = NULL;	/* debug */
+	}
+}
+
+/*
+ * After a copy_*_user, the kernel virtual address may be different.  So
+ * use kmap_copy_user_addr() to get the new value.
+ */
+static inline void *kmap_copy_user_addr(struct copy_user_state *cus)
+{
+	return cus->kaddr;
+}
+
+#else
+
+struct copy_user_state {
+	struct page *page;
+};
+
+/*
+ * This must be a macro because `type' may be undefined
+ */
+
+#define kmap_copy_user(cus, page, type, src)	\
+	({					\
+		(cus)->page = (page);		\
+		kmap(page);			\
+	})
+
+static inline void kunmap_copy_user(struct copy_user_state *cus)
+{
+	kunmap(cus->page);
+}
+
+static inline void *kmap_copy_user_addr(struct copy_user_state *cus)
+{
+	return page_address(cus->page);
+}
+
+#endif
 
 #endif /* _LINUX_HIGHMEM_H */
--- 2.5.30/include/linux/sched.h~kmap_atomic_reads	Fri Aug  9 17:36:42 2002
+++ 2.5.30-akpm/include/linux/sched.h	Fri Aug  9 17:36:42 2002
@@ -245,6 +245,8 @@ extern struct user_struct root_user;
 
 typedef struct prio_array prio_array_t;
 
+struct copy_user_state;
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -366,6 +368,9 @@ struct task_struct {
 /* journalling filesystem info */
 	void *journal_info;
 	struct dentry *proc_dentry;
+#ifdef CONFIG_HIGHMEM
+	struct copy_user_state *copy_user_state;
+#endif
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
--- 2.5.30/mm/filemap.c~kmap_atomic_reads	Fri Aug  9 17:36:42 2002
+++ 2.5.30-akpm/mm/filemap.c	Fri Aug  9 17:37:02 2002
@@ -16,6 +16,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
 #include <linux/iobuf.h>
@@ -1020,18 +1021,20 @@ no_cached_page:
 	UPDATE_ATIME(inode);
 }
 
-int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
+int file_read_actor(read_descriptor_t *desc, struct page *page,
+			unsigned long offset, unsigned long size)
 {
 	char *kaddr;
+	struct copy_user_state copy_user_state;
 	unsigned long left, count = desc->count;
 
 	if (size > count)
 		size = count;
 
-	kaddr = kmap(page);
+	kaddr = kmap_copy_user(&copy_user_state, page, KM_FILEMAP, 1);
 	left = __copy_to_user(desc->buf, kaddr + offset, size);
-	kunmap(page);
-	
+	kunmap_copy_user(&copy_user_state);
+
 	if (left) {
 		size -= left;
 		desc->error = -EFAULT;

.
