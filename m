Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbTAZXVQ>; Sun, 26 Jan 2003 18:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbTAZXVP>; Sun, 26 Jan 2003 18:21:15 -0500
Received: from smtp01.web.de ([217.72.192.180]:49427 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S267052AbTAZXVF>;
	Sun, 26 Jan 2003 18:21:05 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Andrew Morton <akpm@digeo.com>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Subject: Re: [PATCH] to support hookable flush_tlb* functions
Date: Mon, 27 Jan 2003 00:30:15 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       schulz@uni-mannheim.de
References: <1043418252.3e314c8d0278a@rumms.uni-mannheim.de> <20030124132136.765a420d.akpm@digeo.com>
In-Reply-To: <20030124132136.765a420d.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_FAHCGUQP8H0RJLO6327D"
Message-Id: <200301270030.15864.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_FAHCGUQP8H0RJLO6327D
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

24. Jan. 2003 22:21, Andrew Morton wrote:
> A few coding-style nits:
>
> 	+typedef struct tlb_hook_struct {
> 	+...
> 	+} tlb_hook_t;
>
> typedefs are unpopular.  Please just use
>
> 	struct tlb_hook {
> 		...
> 	};
>
> +static inline void flush_tlb_hook( void )
>
> extraneous whitespace - Linus style is flush_tlb_hook(void)
>
> +	while( hook )
>
> 	while (hook)
>
> +	{
> +		if( hook->flush_tlb )
>
> 		if (hook->flush_tlb)
>
> +			hook->flush_tlb( );
>
> 			hook->flush_tlb();
>
> etc...

Thanks for these nits, they should be fixed in the new attached version of the 
patches...

> The unregister_hook implementation is racy - the hook could be in use on
> another CPU.  That's OK - we have the RCU infrastructure which will allow
> hooks to be torn down safely.  And nice people who can help others who are
> using that code.

I do not know what you ment with the RCU infrastructure, but the 
unregister-race should be fixed in the new patches, I hope...

> > The i386 patch also includes some cleanups by renaming __flush_tlb_* to
> > local_flush_tlb_*.
>
> That makes plenty of sense.

Fine... ;-)

> > I hope some time this patches will make it into the kernel sources.
> > (perhaps even into 2.6.x ?)
>
> Well the big questions are: where are the drivers for these devices?  When
> can we expect to see significant demand for these devices?  Will there be
> significant demand across the lifetime of the 2.6 kernel?

Well, I cannot say this for sure as we just do universitary research, but I 
really think this may be interesting even for companies which already create 
their own kernel patches for existing products...

> BTW, when you say "low latency NICs that will implement direct user space
> DMA transfers to not pinned user pages", what do you mean by "not pinned"?

Well, with "not pinned" I mean the users memory pages need not to be pinned 
before the transfer begins...

If the pages are not present they have to be swapped in by the kernel and be 
pinned for the transfer, else the NIC may pin the page itself and start the 
transfer.

The address translation may be performed directly from the network device or 
via an interrupt in the kernel. The translation is then stored in the devices 
TLB which may be flushed when the page is unpinned (then this patch is not 
neccessary) or just if the translation is invalidated from the kernel (then 
this patch is neccessary).

The second approach has the advantage that the TLB hit ratio can be improved 
without having many user-pages pinned, and so removed from the memory pool, 
for a long time...

Regards
  Thomas Schlichter
--------------Boundary-00=_FAHCGUQP8H0RJLO6327D
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="tlbhook_generic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="tlbhook_generic.patch"

diff -urP linux-2.5.59/include/linux/tlbhook.h linux-2.5.59_patched/include/linux/tlbhook.h
--- linux-2.5.59/include/linux/tlbhook.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.59_patched/include/linux/tlbhook.h	Sat Jan 25 10:33:51 2003
@@ -0,0 +1,151 @@
+#ifndef _LINUX_TLBHOOK_H
+#define _LINUX_TLBHOOK_H
+
+#include <linux/mm.h>
+
+struct tlb_hook_struct {
+	void (*flush_tlb)(void);
+	void (*flush_tlb_all)(void);
+	void (*flush_tlb_mm)(struct mm_struct *mm);
+	void (*flush_tlb_page)(struct vm_area_struct *vma,
+				unsigned long addr);
+	void (*flush_tlb_range)(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end);
+	void (*flush_tlb_kernel_range)(unsigned long start,
+				unsigned long end);
+	void (*flush_tlb_pgtables)(struct mm_struct *mm,
+				unsigned long start, unsigned long end);
+
+	struct tlb_hook_struct *next;
+	struct tlb_hook_struct *last;
+        volatile int used;
+};
+
+extern struct tlb_hook_struct *tlb_hook_root;
+
+extern int register_tlb_hook(struct tlb_hook_struct *hook);
+extern int unregister_tlb_hook(struct tlb_hook_struct *hook);
+
+static inline void flush_tlb_hook(void)
+{
+	struct tlb_hook_struct *hook = tlb_hook_root;
+
+	while(hook)
+	{
+		if(hook->flush_tlb)
+		{
+			hook->used = 1;
+			hook->flush_tlb();
+			hook->used = 0;
+		}
+		hook = hook->next;
+	}
+}
+
+
+static inline void flush_tlb_all_hook(void)
+{
+	struct tlb_hook_struct *hook = tlb_hook_root;
+
+	while(hook)
+	{
+		if(hook->flush_tlb_all)
+		{
+			hook->used = 1;
+			hook->flush_tlb_all();
+			hook->used = 0;
+		}
+		hook = hook->next;
+	}
+}
+
+
+static inline void flush_tlb_mm_hook(struct mm_struct *mm)
+{
+	struct tlb_hook_struct *hook = tlb_hook_root;
+
+	while(hook)
+	{
+		if(hook->flush_tlb_mm)
+		{
+			hook->used = 1;
+			hook->flush_tlb_mm(mm);
+			hook->used = 0;
+		}
+		hook = hook->next;
+	}
+}
+
+
+static inline void flush_tlb_page_hook(struct vm_area_struct *vma,
+				unsigned long addr)
+{
+	struct tlb_hook_struct *hook = tlb_hook_root;
+
+	while(hook)
+	{
+		if(hook->flush_tlb_page)
+		{
+			hook->used = 1;
+			hook->flush_tlb_page(vma, addr);
+			hook->used = 0;
+		}
+		hook = hook->next;
+	}
+}
+
+
+static inline void flush_tlb_range_hook(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end)
+{
+	struct tlb_hook_struct *hook = tlb_hook_root;
+
+	while(hook)
+	{
+		if(hook->flush_tlb_range)
+		{
+			hook->used = 1;
+			hook->flush_tlb_range(vma, start, end);
+			hook->used = 0;
+		}
+		hook = hook->next;
+	}
+}
+
+
+static inline void flush_tlb_kernel_range_hook(unsigned long start,
+				unsigned long end)
+{
+	struct tlb_hook_struct *hook = tlb_hook_root;
+
+	while(hook)
+	{
+		if(hook->flush_tlb_kernel_range)
+		{
+			hook->used = 1;
+			hook->flush_tlb_kernel_range(start, end);
+			hook->used = 0;
+		}
+		hook = hook->next;
+	}
+}
+
+
+static inline void flush_tlb_pgtables_hook(struct mm_struct *mm,
+				unsigned long start, unsigned long end)
+{
+	struct tlb_hook_struct *hook = tlb_hook_root;
+
+	while(hook)
+	{
+		if(hook->flush_tlb_pgtables)
+		{
+			hook->used = 1;
+			hook->flush_tlb_pgtables(mm, start, end);
+			hook->used = 0;
+		}
+		hook = hook->next;
+	}
+}
+
+#endif /* _LINUX_TLBHOOK_H */
diff -urP linux-2.5.59/mm/Makefile linux-2.5.59_patched/mm/Makefile
--- linux-2.5.59/mm/Makefile	Fri Jan 17 03:22:20 2003
+++ linux-2.5.59_patched/mm/Makefile	Sat Jan 25 03:45:01 2003
@@ -2,7 +2,8 @@
 # Makefile for the linux memory manager.
 #
 
-export-objs := shmem.o filemap.o mempool.o page_alloc.o page-writeback.o
+export-objs 		:= shmem.o filemap.o mempool.o page_alloc.o page-writeback.o \
+			   tlbhook.o
 
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= fremap.o highmem.o madvise.o memory.o mincore.o \
@@ -11,6 +12,6 @@
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o \
 			   page_alloc.o page-writeback.o pdflush.o readahead.o \
-			   slab.o swap.o truncate.o vcache.o vmscan.o $(mmu-y)
+			   slab.o swap.o tlbhook.o truncate.o vcache.o vmscan.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
diff -urP linux-2.5.59/mm/tlbhook.c linux-2.5.59_patched/mm/tlbhook.c
--- linux-2.5.59/mm/tlbhook.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.59_patched/mm/tlbhook.c	Sat Jan 25 10:43:33 2003
@@ -0,0 +1,68 @@
+#include <linux/module.h>
+#include <linux/tlbhook.h>
+
+static spinlock_t tlb_hook_lock = SPIN_LOCK_UNLOCKED;
+
+struct tlb_hook_struct *tlb_hook_root = NULL;
+
+
+/* register hooks for the flush_tlb* functions */
+int register_tlb_hook(struct tlb_hook_struct *hook)
+{
+	if(!hook)
+		return -EINVAL;
+
+	hook->last = NULL;
+	hook->used = 0;
+
+	// lock the tlb_hook_struct to avoid race conditions
+	spin_lock(&tlb_hook_lock);
+
+	hook->next = tlb_hook_root;
+	if(tlb_hook_root)
+	{
+		tlb_hook_root->last = hook;
+	}
+	tlb_hook_root = hook;
+
+	spin_unlock(&tlb_hook_lock);
+
+	return 0;
+}
+
+
+/* unregister hooks for the flush_tlb* functions */
+int unregister_tlb_hook(struct tlb_hook_struct *hook)
+{
+	if(!hook)
+		return -EINVAL;
+
+	// lock the tlb_hook_struct to avoid race conditions
+	spin_lock(&tlb_hook_lock);
+
+	if(hook->last)
+	{
+		hook->last->next = hook->next;
+	} else {
+		tlb_hook_root = hook->next;
+	}
+
+	if(hook->next)
+	{
+		hook->next->last = hook->last;
+	}
+
+	spin_unlock(&tlb_hook_lock);
+
+	// wait until hook is unused
+	while(hook->used)
+	{
+		cpu_relax();
+	}
+
+	return 0;
+}
+
+
+EXPORT_SYMBOL(register_tlb_hook);
+EXPORT_SYMBOL(unregister_tlb_hook);

--------------Boundary-00=_FAHCGUQP8H0RJLO6327D
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="tlbhook_i386.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="tlbhook_i386.patch"

diff -urP linux-2.5.59/arch/i386/kernel/smp.c linux-2.5.59_patched/arch/i386/kernel/smp.c
--- linux-2.5.59/arch/i386/kernel/smp.c	Fri Jan 17 03:21:38 2003
+++ linux-2.5.59_patched/arch/i386/kernel/smp.c	Sun Jan 26 21:02:22 2003
@@ -327,7 +327,7 @@
 			if (flush_va == FLUSH_ALL)
 				local_flush_tlb();
 			else
-				__flush_tlb_one(flush_va);
+				local_flush_tlb_one(flush_va);
 		} else
 			leave_mm(cpu);
 	}
@@ -382,7 +382,7 @@
 	spin_unlock(&tlbstate_lock);
 }
 	
-void flush_tlb_current_task(void)
+void smp_flush_tlb(void)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long cpu_mask;
@@ -396,7 +396,7 @@
 	preempt_enable();
 }
 
-void flush_tlb_mm (struct mm_struct * mm)
+void smp_flush_tlb_mm(struct mm_struct * mm)
 {
 	unsigned long cpu_mask;
 
@@ -415,7 +415,7 @@
 	preempt_enable();
 }
 
-void flush_tlb_page(struct vm_area_struct * vma, unsigned long va)
+void smp_flush_tlb_page(struct vm_area_struct * vma, unsigned long va)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long cpu_mask;
@@ -425,7 +425,7 @@
 
 	if (current->active_mm == mm) {
 		if(current->mm)
-			__flush_tlb_one(va);
+			local_flush_tlb_one(va);
 		 else
 		 	leave_mm(smp_processor_id());
 	}
@@ -440,7 +440,7 @@
 {
 	unsigned long cpu = smp_processor_id();
 
-	__flush_tlb_all();
+	local_flush_tlb_all();
 	if (cpu_tlbstate[cpu].state == TLBSTATE_LAZY)
 		leave_mm(cpu);
 }
@@ -450,7 +450,7 @@
 	do_flush_tlb_all_local();
 }
 
-void flush_tlb_all(void)
+void smp_flush_tlb_all(void)
 {
 	smp_call_function (flush_tlb_all_ipi,0,1,1);
 
diff -urP linux-2.5.59/arch/i386/mach-voyager/voyager_smp.c linux-2.5.59_patched/arch/i386/mach-voyager/voyager_smp.c
--- linux-2.5.59/arch/i386/mach-voyager/voyager_smp.c	Fri Jan 17 03:22:02 2003
+++ linux-2.5.59_patched/arch/i386/mach-voyager/voyager_smp.c	Sun Jan 26 21:02:22 2003
@@ -892,7 +892,7 @@
 			if (flush_va == FLUSH_ALL)
 				local_flush_tlb();
 			else
-				__flush_tlb_one(flush_va);
+				local_flush_tlb_one(flush_va);
 		} else
 			leave_mm(cpu);
 	}
@@ -948,7 +948,7 @@
 }
 
 void
-flush_tlb_current_task(void)
+smp_flush_tlb(void)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long cpu_mask;
@@ -965,7 +965,7 @@
 
 
 void
-flush_tlb_mm (struct mm_struct * mm)
+smp_flush_tlb_mm(struct mm_struct * mm)
 {
 	unsigned long cpu_mask;
 
@@ -985,7 +985,7 @@
 	preempt_enable();
 }
 
-void flush_tlb_page(struct vm_area_struct * vma, unsigned long va)
+void smp_flush_tlb_page(struct vm_area_struct * vma, unsigned long va)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long cpu_mask;
@@ -995,7 +995,7 @@
 	cpu_mask = mm->cpu_vm_mask & ~(1 << smp_processor_id());
 	if (current->active_mm == mm) {
 		if(current->mm)
-			__flush_tlb_one(va);
+			local_flush_tlb_one(va);
 		 else
 		 	leave_mm(smp_processor_id());
 	}
@@ -1217,7 +1217,7 @@
 {
 	unsigned long cpu = smp_processor_id();
 
-	__flush_tlb_all();
+	local_flush_tlb_all();
 	if (cpu_tlbstate[cpu].state == TLBSTATE_LAZY)
 		leave_mm(cpu);
 }
@@ -1231,7 +1231,7 @@
 
 /* flush the TLB of every active CPU in the system */
 void
-flush_tlb_all(void)
+smp_flush_tlb_all(void)
 {
 	smp_call_function (flush_tlb_all_function, 0, 1, 1);
 
diff -urP linux-2.5.59/arch/i386/mm/highmem.c linux-2.5.59_patched/arch/i386/mm/highmem.c
--- linux-2.5.59/arch/i386/mm/highmem.c	Fri Jan 17 03:22:14 2003
+++ linux-2.5.59_patched/arch/i386/mm/highmem.c	Sun Jan 26 21:02:22 2003
@@ -42,7 +42,7 @@
 		BUG();
 #endif
 	set_pte(kmap_pte-idx, mk_pte(page, kmap_prot));
-	__flush_tlb_one(vaddr);
+	local_flush_tlb_one(vaddr);
 
 	return (void*) vaddr;
 }
@@ -66,7 +66,7 @@
 	 * this pte without first remap it
 	 */
 	pte_clear(kmap_pte-idx);
-	__flush_tlb_one(vaddr);
+	local_flush_tlb_one(vaddr);
 #endif
 
 	dec_preempt_count();
diff -urP linux-2.5.59/arch/i386/mm/init.c linux-2.5.59_patched/arch/i386/mm/init.c
--- linux-2.5.59/arch/i386/mm/init.c	Fri Jan 17 03:22:27 2003
+++ linux-2.5.59_patched/arch/i386/mm/init.c	Sun Jan 26 21:02:22 2003
@@ -369,7 +369,7 @@
 	if (cpu_has_pae)
 		set_in_cr4(X86_CR4_PAE);
 #endif
-	__flush_tlb_all();
+	local_flush_tlb_all();
 
 	kmap_init();
 	zone_sizes_init();
diff -urP linux-2.5.59/arch/i386/mm/pageattr.c linux-2.5.59_patched/arch/i386/mm/pageattr.c
--- linux-2.5.59/arch/i386/mm/pageattr.c	Fri Jan 17 03:22:04 2003
+++ linux-2.5.59_patched/arch/i386/mm/pageattr.c	Sun Jan 26 21:02:22 2003
@@ -53,7 +53,7 @@
 	/* Flush all to work around Errata in early athlons regarding 
 	 * large page flushing. 
 	 */
-	__flush_tlb_all(); 	
+	local_flush_tlb_all(); 	
 }
 
 static void set_pmd_pte(pte_t *kpte, unsigned long address, pte_t pte) 
diff -urP linux-2.5.59/arch/i386/mm/pgtable.c linux-2.5.59_patched/arch/i386/mm/pgtable.c
--- linux-2.5.59/arch/i386/mm/pgtable.c	Fri Jan 17 03:23:01 2003
+++ linux-2.5.59_patched/arch/i386/mm/pgtable.c	Sun Jan 26 21:02:22 2003
@@ -81,7 +81,7 @@
 	 * It's enough to flush this one mapping.
 	 * (PGE mappings get flushed as well)
 	 */
-	__flush_tlb_one(vaddr);
+	local_flush_tlb_one(vaddr);
 }
 
 /*
@@ -114,7 +114,7 @@
 	 * It's enough to flush this one mapping.
 	 * (PGE mappings get flushed as well)
 	 */
-	__flush_tlb_one(vaddr);
+	local_flush_tlb_one(vaddr);
 }
 
 void __set_fixmap (enum fixed_addresses idx, unsigned long phys, pgprot_t flags)
diff -urP linux-2.5.59/include/asm-i386/tlbflush.h linux-2.5.59_patched/include/asm-i386/tlbflush.h
--- linux-2.5.59/include/asm-i386/tlbflush.h	Fri Jan 17 03:22:49 2003
+++ linux-2.5.59_patched/include/asm-i386/tlbflush.h	Sun Jan 26 21:02:22 2003
@@ -2,10 +2,10 @@
 #define _I386_TLBFLUSH_H
 
 #include <linux/config.h>
-#include <linux/mm.h>
+#include <linux/tlbhook.h>
 #include <asm/processor.h>
 
-#define __flush_tlb()							\
+#define local_flush_tlb()						\
 	do {								\
 		unsigned int tmpreg;					\
 									\
@@ -37,12 +37,12 @@
 
 extern unsigned long pgkern_mask;
 
-# define __flush_tlb_all()						\
+# define local_flush_tlb_all()						\
 	do {								\
 		if (cpu_has_pge)					\
 			__flush_tlb_global();				\
 		else							\
-			__flush_tlb();					\
+			local_flush_tlb();				\
 	} while (0)
 
 #define cpu_has_invlpg	(boot_cpu_data.x86 > 3)
@@ -51,14 +51,14 @@
 	__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
 
 #ifdef CONFIG_X86_INVLPG
-# define __flush_tlb_one(addr) __flush_tlb_single(addr)
+# define local_flush_tlb_one(addr) __flush_tlb_single(addr)
 #else
-# define __flush_tlb_one(addr)						\
+# define local_flush_tlb_one(addr)					\
 	do {								\
 		if (cpu_has_invlpg)					\
 			__flush_tlb_single(addr);			\
 		else							\
-			__flush_tlb();					\
+			local_flush_tlb();				\
 	} while (0)
 #endif
 
@@ -79,47 +79,94 @@
 
 #ifndef CONFIG_SMP
 
-#define flush_tlb() __flush_tlb()
-#define flush_tlb_all() __flush_tlb_all()
-#define local_flush_tlb() __flush_tlb()
+static inline void flush_tlb(void)
+{
+	flush_tlb_hook();
+	local_flush_tlb();
+}
+
+static inline void flush_tlb_all(void)
+{
+	flush_tlb_all_hook();
+	local_flush_tlb_all();
+}
 
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
+	flush_tlb_mm_hook(mm);
 	if (mm == current->active_mm)
-		__flush_tlb();
+		local_flush_tlb();
 }
 
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 	unsigned long addr)
 {
+	flush_tlb_page_hook(vma, addr);
 	if (vma->vm_mm == current->active_mm)
-		__flush_tlb_one(addr);
+		local_flush_tlb_one(addr);
 }
 
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end)
 {
+	flush_tlb_range_hook(vma, start, end);
 	if (vma->vm_mm == current->active_mm)
-		__flush_tlb();
+		local_flush_tlb();
+}
+
+static inline void flush_tlb_kernel_range(unsigned long start,
+	unsigned long end)
+{
+	flush_tlb_kernel_range_hook(start, end);
+	local_flush_tlb_all();
 }
 
 #else
 
 #include <asm/smp.h>
 
-#define local_flush_tlb() \
-	__flush_tlb()
+extern void smp_flush_tlb(void);
+extern void smp_flush_tlb_all(void);
+extern void smp_flush_tlb_mm(struct mm_struct *);
+extern void smp_flush_tlb_page(struct vm_area_struct *, unsigned long);
+
+static inline void flush_tlb(void)
+{
+	flush_tlb_hook();
+	smp_flush_tlb();
+}
+
+static inline void flush_tlb_all(void)
+{
+	flush_tlb_all_hook();
+	smp_flush_tlb_all();
+}
+
+static inline void flush_tlb_mm(struct mm_struct *mm)
+{
+	flush_tlb_mm_hook(mm);
+	smp_flush_tlb_mm(mm);
+}
 
-extern void flush_tlb_all(void);
-extern void flush_tlb_current_task(void);
-extern void flush_tlb_mm(struct mm_struct *);
-extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
+static inline void flush_tlb_page(struct vm_area_struct *vma,
+	unsigned long addr)
+{
+	flush_tlb_page_hook(vma, addr);
+	smp_flush_tlb_page(vma, addr);
+}
 
-#define flush_tlb()	flush_tlb_current_task()
+static inline void flush_tlb_range(struct vm_area_struct * vma,
+	unsigned long start, unsigned long end)
+{
+	flush_tlb_range_hook(vma, start, end);
+	smp_flush_tlb_mm(vma->vm_mm);
+}
 
-static inline void flush_tlb_range(struct vm_area_struct * vma, unsigned long start, unsigned long end)
+static inline void flush_tlb_kernel_range(unsigned long start,
+	unsigned long end)
 {
-	flush_tlb_mm(vma->vm_mm);
+	flush_tlb_kernel_range_hook(start, end);
+	smp_flush_tlb_all();
 }
 
 #define TLBSTATE_OK	1
@@ -136,11 +183,10 @@
 
 #endif
 
-#define flush_tlb_kernel_range(start, end) flush_tlb_all()
-
 static inline void flush_tlb_pgtables(struct mm_struct *mm,
 				      unsigned long start, unsigned long end)
 {
+	flush_tlb_pgtables_hook(mm, start, end);
 	/* i386 does not keep any page table caches in TLB */
 }
 

--------------Boundary-00=_FAHCGUQP8H0RJLO6327D--

