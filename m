Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291306AbSCMA33>; Tue, 12 Mar 2002 19:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291333AbSCMA3N>; Tue, 12 Mar 2002 19:29:13 -0500
Received: from [208.252.96.195] ([208.252.96.195]:14135 "EHLO
	LOCKBOX.plaza.ds.adp.com") by vger.kernel.org with ESMTP
	id <S291306AbSCMA2t>; Tue, 12 Mar 2002 19:28:49 -0500
Date: Tue, 12 Mar 2002 16:28:41 -0800
From: "Seth D. Alford" <setha@plaza.ds.adp.com>
To: linux-kernel@vger.kernel.org
Cc: "Seth D. Alford" <setha@plaza.ds.adp.com>
Subject: Re: LDT_ENTRIES in ldt.h: why 8192?
Message-Id: <20020312162841.A8545@mallard.plaza.ds.adp.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020213121848.A31469@mallard.plaza.ds.adp.com> <E16b6JZ-0006NL-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E16b6JZ-0006NL-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 13, 2002 at 08:47:41PM +0000
X-OriginalArrivalTime: 13 Mar 2002 00:28:41.0744 (UTC) FILETIME=[06F60900:01C1CA26]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

About a month ago, I asked about changing the size of LDT_ENTRIES:

On Wed, Feb 13, 2002 at 08:47:41PM +0000, Alan Cox wrote:
> > wondering about an alternate solution.  What would happen if LDT_ENTRIES was
> > reduced, to, say, 4096, or 512, instead of 8192?
> 
> Some apps using LDT will stop working. Very little actually uses LDT's - the
> main ones being wine and the sco 286 emulation software. Its also used by
....

I decided to back-port Manfred's LDT patch from 2.5.1 to 2.4.12.  For what it's
worth, my modification of the patch is below.

It seems to work for us, but I have no idea if it will work for anyone else.

This software is offered with NO WARRANTY and NO SUPPORT of any kind.

--Seth Alford
setha@plaza.ds.adp.com

----2.4.12 version of Manfred's Spraul's 2.5.1 LDT patch follows----
diff -Naur linux-2.4.12.orig/arch/i386/kernel/ldt.c linux-2.4.12/arch/i386/kernel/ldt.c
--- linux-2.4.12.orig/arch/i386/kernel/ldt.c	Thu Jul 26 13:29:45 2001
+++ linux-2.4.12/arch/i386/kernel/ldt.c	Wed Feb 13 16:54:59 2002
@@ -12,36 +12,155 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/vmalloc.h>
+#include <linux/slab.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/ldt.h>
 #include <asm/desc.h>
 
+#ifdef CONFIG_SMP /* avoids "defined but not used" warnig */
+static void flush_ldt(void *mm)
+{
+       if (current->mm)
+               load_LDT(&current->mm->context);
+}
+#endif
+
+static int alloc_ldt(mm_context_t *pc, int mincount, int reload)
+{
+       void *oldldt;
+       void *newldt;
+       int oldsize;
+
+       if (mincount <= pc->size)
+               return 0;
+       oldsize = pc->size;
+       mincount = (mincount+511)&(~511);
+       if (mincount*LDT_ENTRY_SIZE > PAGE_SIZE)
+               newldt = vmalloc(mincount*LDT_ENTRY_SIZE);
+       else
+               newldt = kmalloc(mincount*LDT_ENTRY_SIZE, GFP_KERNEL);
+
+       if (!newldt)
+               return -ENOMEM;
+
+       if (oldsize)
+               memcpy(newldt, pc->ldt, oldsize*LDT_ENTRY_SIZE);
+       oldldt = pc->ldt;
+       memset(newldt+oldsize*LDT_ENTRY_SIZE, 0, (mincount-oldsize)*LDT_ENTRY_SIZE);
+       wmb();
+       pc->ldt = newldt;
+       pc->size = mincount;
+       if (reload) {
+               load_LDT(pc);
+#ifdef CONFIG_SMP
+               if (current->mm->cpu_vm_mask != (1<<smp_processor_id()))
+                       smp_call_function(flush_ldt, 0, 1, 1);
+#endif
+       }
+       wmb();
+       if (oldsize) {
+               if (oldsize*LDT_ENTRY_SIZE > PAGE_SIZE)
+                       vfree(oldldt);
+               else
+                       kfree(oldldt);
+       }
+       return 0;
+}
+
+static inline int copy_ldt(mm_context_t *new, mm_context_t *old)
+{
+       int err = alloc_ldt(new, old->size, 0);
+       if (err < 0) {
+               printk(KERN_WARNING "ldt allocation failed\n");
+               new->size = 0;
+               return err;
+       }
+       memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
+       return 0;
+}
+
 /*
- * read_ldt() is not really atomic - this is not a problem since
- * synchronization of reads and writes done to the LDT has to be
- * assured by user-space anyway. Writes are atomic, to protect
- * the security checks done on new descriptors.
+ * we do not have to muck with descriptors here, that is
+ * done in switch_mm() as needed.
  */
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+       struct mm_struct * old_mm;
+       int retval = 0;
+
+       init_MUTEX(&mm->context.sem);
+       mm->context.size = 0;
+       old_mm = current->mm;
+       if (old_mm && old_mm->context.size > 0) {
+               down(&old_mm->context.sem);
+               retval = copy_ldt(&mm->context, &old_mm->context);
+               up(&old_mm->context.sem);
+       }
+       return retval;
+}
+
+/*
+ * No need to lock the MM as we are the last user
+ */
+void release_segments(struct mm_struct *mm)
+{
+       if (mm->context.size) {
+               clear_LDT();
+               if (mm->context.size*LDT_ENTRY_SIZE > PAGE_SIZE)
+                       vfree(mm->context.ldt);
+               else
+                       kfree(mm->context.ldt);
+               mm->context.size = 0;
+       }
+}
+
 static int read_ldt(void * ptr, unsigned long bytecount)
 {
 	int err;
 	unsigned long size;
 	struct mm_struct * mm = current->mm;
 
-	err = 0;
-	if (!mm->context.segments)
-		goto out;
+       if (!mm->context.size)
+               return 0;
+       if (bytecount > LDT_ENTRY_SIZE*LDT_ENTRIES)
+               bytecount = LDT_ENTRY_SIZE*LDT_ENTRIES;
 
-	size = LDT_ENTRIES*LDT_ENTRY_SIZE;
+       down(&mm->context.sem);
+       size = mm->context.size*LDT_ENTRY_SIZE;
+	if (size > bytecount)
+		size = bytecount;
+
+       err = 0;
+       if (copy_to_user(ptr, mm->context.ldt, size))
+		err = -EFAULT;
+       up(&mm->context.sem);
+       if (err < 0)
+               return err;
+       if (size != bytecount) {
+               /* zero-fill the rest */
+               clear_user(ptr+size, bytecount-size);
+       }
+       return bytecount;
+}
+
+static int read_default_ldt(void * ptr, unsigned long bytecount)
+{
+	int err;
+	unsigned long size;
+	void *address;
+
+	err = 0;
+	address = &default_ldt[0];
+       size = 5*sizeof(struct desc_struct);
 	if (size > bytecount)
 		size = bytecount;
 
 	err = size;
-	if (copy_to_user(ptr, mm->context.segments, size))
+	if (copy_to_user(ptr, address, size))
 		err = -EFAULT;
-out:
+
 	return err;
 }
 
@@ -69,24 +188,14 @@
 			goto out;
 	}
 
-	/*
-	 * the GDT index of the LDT is allocated dynamically, and is
-	 * limited by MAX_LDT_DESCRIPTORS.
-	 */
-	down_write(&mm->mmap_sem);
-	if (!mm->context.segments) {
-		void * segments = vmalloc(LDT_ENTRIES*LDT_ENTRY_SIZE);
-		error = -ENOMEM;
-		if (!segments)
+       down(&mm->context.sem);
+       if (ldt_info.entry_number >= mm->context.size) {
+               error = alloc_ldt(&current->mm->context, ldt_info.entry_number+1, 1);
+               if (error < 0)
 			goto out_unlock;
-		memset(segments, 0, LDT_ENTRIES*LDT_ENTRY_SIZE);
-		wmb();
-		mm->context.segments = segments;
-		mm->context.cpuvalid = 1UL << smp_processor_id();
-		load_LDT(mm);
 	}
 
-	lp = (__u32 *) ((ldt_info.entry_number << 3) + (char *) mm->context.segments);
+       lp = (__u32 *) ((ldt_info.entry_number << 3) + (char *) mm->context.ldt);
 
    	/* Allow LDTs to be cleared by the user. */
    	if (ldt_info.base_addr == 0 && ldt_info.limit == 0) {
@@ -124,7 +233,7 @@
 	error = 0;
 
 out_unlock:
-	up_write(&mm->mmap_sem);
+       up(&mm->context.sem);
 out:
 	return error;
 }
@@ -140,6 +249,9 @@
 	case 1:
 		ret = write_ldt(ptr, bytecount, 1);
 		break;
+	case 2:
+		ret = read_default_ldt(ptr, bytecount);
+		break;
 	case 0x11:
 		ret = write_ldt(ptr, bytecount, 0);
 		break;
diff -Naur linux-2.4.12.orig/arch/i386/kernel/process.c linux-2.4.12/arch/i386/kernel/process.c
--- linux-2.4.12.orig/arch/i386/kernel/process.c	Thu Oct  4 18:42:54 2001
+++ linux-2.4.12/arch/i386/kernel/process.c	Wed Feb 13 16:11:16 2002
@@ -465,23 +465,6 @@
 }
 
 /*
- * No need to lock the MM as we are the last user
- */
-void release_segments(struct mm_struct *mm)
-{
-	void * ldt = mm->context.segments;
-
-	/*
-	 * free the LDT
-	 */
-	if (ldt) {
-		mm->context.segments = NULL;
-		clear_LDT();
-		vfree(ldt);
-	}
-}
-
-/*
  * Create a kernel thread
  */
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
@@ -533,43 +516,18 @@
 void release_thread(struct task_struct *dead_task)
 {
 	if (dead_task->mm) {
-		void * ldt = dead_task->mm->context.segments;
-
 		// temporary debugging check
-		if (ldt) {
-			printk("WARNING: dead process %8s still has LDT? <%p>\n",
-					dead_task->comm, ldt);
+               if (dead_task->mm->context.size) {
+                       printk("WARNING: dead process %8s still has LDT? <%p/%d>\n",
+                                       dead_task->comm,
+                                       dead_task->mm->context.ldt,
+                                       dead_task->mm->context.size);
 			BUG();
 		}
 	}
 }
 
 /*
- * we do not have to muck with descriptors here, that is
- * done in switch_mm() as needed.
- */
-void copy_segments(struct task_struct *p, struct mm_struct *new_mm)
-{
-	struct mm_struct * old_mm;
-	void *old_ldt, *ldt;
-
-	ldt = NULL;
-	old_mm = current->mm;
-	if (old_mm && (old_ldt = old_mm->context.segments) != NULL) {
-		/*
-		 * Completely new LDT, we initialize it from the parent:
-		 */
-		ldt = vmalloc(LDT_ENTRIES*LDT_ENTRY_SIZE);
-		if (!ldt)
-			printk(KERN_WARNING "ldt allocation failed\n");
-		else
-			memcpy(ldt, old_ldt, LDT_ENTRIES*LDT_ENTRY_SIZE);
-	}
-	new_mm->context.segments = ldt;
-	new_mm->context.cpuvalid = ~0UL;	/* valid on all CPU's - they can't have stale data */
-}
-
-/*
  * Save a segment.
  */
 #define savesegment(seg,value) \
diff -Naur linux-2.4.12.orig/include/asm-i386/desc.h linux-2.4.12/include/asm-i386/desc.h
--- linux-2.4.12.orig/include/asm-i386/desc.h	Thu Jul 26 13:40:32 2001
+++ linux-2.4.12/include/asm-i386/desc.h	Wed Feb 13 16:11:16 2002
@@ -79,13 +79,13 @@
 /*
  * load one particular LDT into the current CPU
  */
-static inline void load_LDT (struct mm_struct *mm)
+static inline void load_LDT (mm_context_t *pc)
 {
 	int cpu = smp_processor_id();
-	void *segments = mm->context.segments;
-	int count = LDT_ENTRIES;
+       void *segments = pc->ldt;
+       int count = pc->size;
 
-	if (!segments) {
+       if (!count) {
 		segments = &default_ldt[0];
 		count = 5;
 	}
diff -Naur linux-2.4.12.orig/include/asm-i386/mmu.h linux-2.4.12/include/asm-i386/mmu.h
--- linux-2.4.12.orig/include/asm-i386/mmu.h	Wed Jul 25 18:03:04 2001
+++ linux-2.4.12/include/asm-i386/mmu.h	Wed Feb 13 16:11:16 2002
@@ -4,10 +4,13 @@
 /*
  * The i386 doesn't have a mmu context, but
  * we put the segment information here.
+ *
+ * cpu_vm_mask is used to optimize ldt flushing.
  */
 typedef struct { 
-	void *segments;
-	unsigned long cpuvalid;
+       int size;
+       struct semaphore sem;
+       void *  ldt;
 } mm_context_t;
 
 #endif
diff -Naur linux-2.4.12.orig/include/asm-i386/mmu_context.h linux-2.4.12/include/asm-i386/mmu_context.h
--- linux-2.4.12.orig/include/asm-i386/mmu_context.h	Wed Oct 10 23:44:34 2001
+++ linux-2.4.12/include/asm-i386/mmu_context.h	Wed Feb 13 16:11:16 2002
@@ -10,7 +10,7 @@
  * possibly do the LDT unload here?
  */
 #define destroy_context(mm)		do { } while(0)
-#define init_new_context(tsk,mm)	0
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 
 #ifdef CONFIG_SMP
 
@@ -30,19 +30,19 @@
 	if (prev != next) {
 		/* stop flush ipis for the previous mm */
 		clear_bit(cpu, &prev->cpu_vm_mask);
-		/*
-		 * Re-load LDT if necessary
-		 */
-		if (prev->context.segments != next->context.segments)
-			load_LDT(next);
 #ifdef CONFIG_SMP
 		cpu_tlbstate[cpu].state = TLBSTATE_OK;
 		cpu_tlbstate[cpu].active_mm = next;
 #endif
 		set_bit(cpu, &next->cpu_vm_mask);
-		set_bit(cpu, &next->context.cpuvalid);
+
 		/* Re-load page tables */
 		asm volatile("movl %0,%%cr3": :"r" (__pa(next->pgd)));
+               /* load_LDT, if either the previous or next thread
+                * has a non-default LDT.
+                */
+               if (next->context.size+prev->context.size)
+                       load_LDT(&next->context);
 	}
 #ifdef CONFIG_SMP
 	else {
@@ -54,9 +54,8 @@
 			 * tlb flush IPI delivery. We must flush our tlb.
 			 */
 			local_flush_tlb();
+                       load_LDT(&next->context);
 		}
-		if (!test_and_set_bit(cpu, &next->context.cpuvalid))
-			load_LDT(next);
 	}
 #endif
 }
diff -Naur linux-2.4.12.orig/include/asm-i386/processor.h linux-2.4.12/include/asm-i386/processor.h
--- linux-2.4.12.orig/include/asm-i386/processor.h	Wed Oct 10 23:44:33 2001
+++ linux-2.4.12/include/asm-i386/processor.h	Wed Feb 13 16:11:16 2002
@@ -431,8 +431,7 @@
  */
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-/* Copy and release all segment info associated with a VM */
-extern void copy_segments(struct task_struct *p, struct mm_struct * mm);
+/* Release all segment info associated with a VM */
 extern void release_segments(struct mm_struct * mm);
 
 /*
diff -Naur linux-2.4.12.orig/kernel/fork.c linux-2.4.12/kernel/fork.c
--- linux-2.4.12.orig/kernel/fork.c	Mon Sep 17 21:46:04 2001
+++ linux-2.4.12/kernel/fork.c	Wed Feb 13 16:11:16 2002
@@ -340,11 +340,6 @@
 	if (retval)
 		goto free_pt;
 
-	/*
-	 * child gets a private LDT (if there was an LDT in the parent)
-	 */
-	copy_segments(tsk, mm);
-
 	if (init_new_context(tsk,mm))
 		goto free_pt;
 

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="manfred_2.4.12.patch"

diff -Naur linux-2.4.12.orig/arch/i386/kernel/ldt.c linux-2.4.12/arch/i386/kernel/ldt.c
--- linux-2.4.12.orig/arch/i386/kernel/ldt.c	Thu Jul 26 13:29:45 2001
+++ linux-2.4.12/arch/i386/kernel/ldt.c	Wed Feb 13 16:54:59 2002
@@ -12,36 +12,155 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/vmalloc.h>
+#include <linux/slab.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/ldt.h>
 #include <asm/desc.h>
 
+#ifdef CONFIG_SMP /* avoids "defined but not used" warnig */
+static void flush_ldt(void *mm)
+{
+       if (current->mm)
+               load_LDT(&current->mm->context);
+}
+#endif
+
+static int alloc_ldt(mm_context_t *pc, int mincount, int reload)
+{
+       void *oldldt;
+       void *newldt;
+       int oldsize;
+
+       if (mincount <= pc->size)
+               return 0;
+       oldsize = pc->size;
+       mincount = (mincount+511)&(~511);
+       if (mincount*LDT_ENTRY_SIZE > PAGE_SIZE)
+               newldt = vmalloc(mincount*LDT_ENTRY_SIZE);
+       else
+               newldt = kmalloc(mincount*LDT_ENTRY_SIZE, GFP_KERNEL);
+
+       if (!newldt)
+               return -ENOMEM;
+
+       if (oldsize)
+               memcpy(newldt, pc->ldt, oldsize*LDT_ENTRY_SIZE);
+       oldldt = pc->ldt;
+       memset(newldt+oldsize*LDT_ENTRY_SIZE, 0, (mincount-oldsize)*LDT_ENTRY_SIZE);
+       wmb();
+       pc->ldt = newldt;
+       pc->size = mincount;
+       if (reload) {
+               load_LDT(pc);
+#ifdef CONFIG_SMP
+               if (current->mm->cpu_vm_mask != (1<<smp_processor_id()))
+                       smp_call_function(flush_ldt, 0, 1, 1);
+#endif
+       }
+       wmb();
+       if (oldsize) {
+               if (oldsize*LDT_ENTRY_SIZE > PAGE_SIZE)
+                       vfree(oldldt);
+               else
+                       kfree(oldldt);
+       }
+       return 0;
+}
+
+static inline int copy_ldt(mm_context_t *new, mm_context_t *old)
+{
+       int err = alloc_ldt(new, old->size, 0);
+       if (err < 0) {
+               printk(KERN_WARNING "ldt allocation failed\n");
+               new->size = 0;
+               return err;
+       }
+       memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
+       return 0;
+}
+
 /*
- * read_ldt() is not really atomic - this is not a problem since
- * synchronization of reads and writes done to the LDT has to be
- * assured by user-space anyway. Writes are atomic, to protect
- * the security checks done on new descriptors.
+ * we do not have to muck with descriptors here, that is
+ * done in switch_mm() as needed.
  */
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+       struct mm_struct * old_mm;
+       int retval = 0;
+
+       init_MUTEX(&mm->context.sem);
+       mm->context.size = 0;
+       old_mm = current->mm;
+       if (old_mm && old_mm->context.size > 0) {
+               down(&old_mm->context.sem);
+               retval = copy_ldt(&mm->context, &old_mm->context);
+               up(&old_mm->context.sem);
+       }
+       return retval;
+}
+
+/*
+ * No need to lock the MM as we are the last user
+ */
+void release_segments(struct mm_struct *mm)
+{
+       if (mm->context.size) {
+               clear_LDT();
+               if (mm->context.size*LDT_ENTRY_SIZE > PAGE_SIZE)
+                       vfree(mm->context.ldt);
+               else
+                       kfree(mm->context.ldt);
+               mm->context.size = 0;
+       }
+}
+
 static int read_ldt(void * ptr, unsigned long bytecount)
 {
 	int err;
 	unsigned long size;
 	struct mm_struct * mm = current->mm;
 
-	err = 0;
-	if (!mm->context.segments)
-		goto out;
+       if (!mm->context.size)
+               return 0;
+       if (bytecount > LDT_ENTRY_SIZE*LDT_ENTRIES)
+               bytecount = LDT_ENTRY_SIZE*LDT_ENTRIES;
 
-	size = LDT_ENTRIES*LDT_ENTRY_SIZE;
+       down(&mm->context.sem);
+       size = mm->context.size*LDT_ENTRY_SIZE;
+	if (size > bytecount)
+		size = bytecount;
+
+       err = 0;
+       if (copy_to_user(ptr, mm->context.ldt, size))
+		err = -EFAULT;
+       up(&mm->context.sem);
+       if (err < 0)
+               return err;
+       if (size != bytecount) {
+               /* zero-fill the rest */
+               clear_user(ptr+size, bytecount-size);
+       }
+       return bytecount;
+}
+
+static int read_default_ldt(void * ptr, unsigned long bytecount)
+{
+	int err;
+	unsigned long size;
+	void *address;
+
+	err = 0;
+	address = &default_ldt[0];
+       size = 5*sizeof(struct desc_struct);
 	if (size > bytecount)
 		size = bytecount;
 
 	err = size;
-	if (copy_to_user(ptr, mm->context.segments, size))
+	if (copy_to_user(ptr, address, size))
 		err = -EFAULT;
-out:
+
 	return err;
 }
 
@@ -69,24 +188,14 @@
 			goto out;
 	}
 
-	/*
-	 * the GDT index of the LDT is allocated dynamically, and is
-	 * limited by MAX_LDT_DESCRIPTORS.
-	 */
-	down_write(&mm->mmap_sem);
-	if (!mm->context.segments) {
-		void * segments = vmalloc(LDT_ENTRIES*LDT_ENTRY_SIZE);
-		error = -ENOMEM;
-		if (!segments)
+       down(&mm->context.sem);
+       if (ldt_info.entry_number >= mm->context.size) {
+               error = alloc_ldt(&current->mm->context, ldt_info.entry_number+1, 1);
+               if (error < 0)
 			goto out_unlock;
-		memset(segments, 0, LDT_ENTRIES*LDT_ENTRY_SIZE);
-		wmb();
-		mm->context.segments = segments;
-		mm->context.cpuvalid = 1UL << smp_processor_id();
-		load_LDT(mm);
 	}
 
-	lp = (__u32 *) ((ldt_info.entry_number << 3) + (char *) mm->context.segments);
+       lp = (__u32 *) ((ldt_info.entry_number << 3) + (char *) mm->context.ldt);
 
    	/* Allow LDTs to be cleared by the user. */
    	if (ldt_info.base_addr == 0 && ldt_info.limit == 0) {
@@ -124,7 +233,7 @@
 	error = 0;
 
 out_unlock:
-	up_write(&mm->mmap_sem);
+       up(&mm->context.sem);
 out:
 	return error;
 }
@@ -140,6 +249,9 @@
 	case 1:
 		ret = write_ldt(ptr, bytecount, 1);
 		break;
+	case 2:
+		ret = read_default_ldt(ptr, bytecount);
+		break;
 	case 0x11:
 		ret = write_ldt(ptr, bytecount, 0);
 		break;
diff -Naur linux-2.4.12.orig/arch/i386/kernel/process.c linux-2.4.12/arch/i386/kernel/process.c
--- linux-2.4.12.orig/arch/i386/kernel/process.c	Thu Oct  4 18:42:54 2001
+++ linux-2.4.12/arch/i386/kernel/process.c	Wed Feb 13 16:11:16 2002
@@ -465,23 +465,6 @@
 }
 
 /*
- * No need to lock the MM as we are the last user
- */
-void release_segments(struct mm_struct *mm)
-{
-	void * ldt = mm->context.segments;
-
-	/*
-	 * free the LDT
-	 */
-	if (ldt) {
-		mm->context.segments = NULL;
-		clear_LDT();
-		vfree(ldt);
-	}
-}
-
-/*
  * Create a kernel thread
  */
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
@@ -533,43 +516,18 @@
 void release_thread(struct task_struct *dead_task)
 {
 	if (dead_task->mm) {
-		void * ldt = dead_task->mm->context.segments;
-
 		// temporary debugging check
-		if (ldt) {
-			printk("WARNING: dead process %8s still has LDT? <%p>\n",
-					dead_task->comm, ldt);
+               if (dead_task->mm->context.size) {
+                       printk("WARNING: dead process %8s still has LDT? <%p/%d>\n",
+                                       dead_task->comm,
+                                       dead_task->mm->context.ldt,
+                                       dead_task->mm->context.size);
 			BUG();
 		}
 	}
 }
 
 /*
- * we do not have to muck with descriptors here, that is
- * done in switch_mm() as needed.
- */
-void copy_segments(struct task_struct *p, struct mm_struct *new_mm)
-{
-	struct mm_struct * old_mm;
-	void *old_ldt, *ldt;
-
-	ldt = NULL;
-	old_mm = current->mm;
-	if (old_mm && (old_ldt = old_mm->context.segments) != NULL) {
-		/*
-		 * Completely new LDT, we initialize it from the parent:
-		 */
-		ldt = vmalloc(LDT_ENTRIES*LDT_ENTRY_SIZE);
-		if (!ldt)
-			printk(KERN_WARNING "ldt allocation failed\n");
-		else
-			memcpy(ldt, old_ldt, LDT_ENTRIES*LDT_ENTRY_SIZE);
-	}
-	new_mm->context.segments = ldt;
-	new_mm->context.cpuvalid = ~0UL;	/* valid on all CPU's - they can't have stale data */
-}
-
-/*
  * Save a segment.
  */
 #define savesegment(seg,value) \
diff -Naur linux-2.4.12.orig/include/asm-i386/desc.h linux-2.4.12/include/asm-i386/desc.h
--- linux-2.4.12.orig/include/asm-i386/desc.h	Thu Jul 26 13:40:32 2001
+++ linux-2.4.12/include/asm-i386/desc.h	Wed Feb 13 16:11:16 2002
@@ -79,13 +79,13 @@
 /*
  * load one particular LDT into the current CPU
  */
-static inline void load_LDT (struct mm_struct *mm)
+static inline void load_LDT (mm_context_t *pc)
 {
 	int cpu = smp_processor_id();
-	void *segments = mm->context.segments;
-	int count = LDT_ENTRIES;
+       void *segments = pc->ldt;
+       int count = pc->size;
 
-	if (!segments) {
+       if (!count) {
 		segments = &default_ldt[0];
 		count = 5;
 	}
diff -Naur linux-2.4.12.orig/include/asm-i386/mmu.h linux-2.4.12/include/asm-i386/mmu.h
--- linux-2.4.12.orig/include/asm-i386/mmu.h	Wed Jul 25 18:03:04 2001
+++ linux-2.4.12/include/asm-i386/mmu.h	Wed Feb 13 16:11:16 2002
@@ -4,10 +4,13 @@
 /*
  * The i386 doesn't have a mmu context, but
  * we put the segment information here.
+ *
+ * cpu_vm_mask is used to optimize ldt flushing.
  */
 typedef struct { 
-	void *segments;
-	unsigned long cpuvalid;
+       int size;
+       struct semaphore sem;
+       void *  ldt;
 } mm_context_t;
 
 #endif
diff -Naur linux-2.4.12.orig/include/asm-i386/mmu_context.h linux-2.4.12/include/asm-i386/mmu_context.h
--- linux-2.4.12.orig/include/asm-i386/mmu_context.h	Wed Oct 10 23:44:34 2001
+++ linux-2.4.12/include/asm-i386/mmu_context.h	Wed Feb 13 16:11:16 2002
@@ -10,7 +10,7 @@
  * possibly do the LDT unload here?
  */
 #define destroy_context(mm)		do { } while(0)
-#define init_new_context(tsk,mm)	0
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 
 #ifdef CONFIG_SMP
 
@@ -30,19 +30,19 @@
 	if (prev != next) {
 		/* stop flush ipis for the previous mm */
 		clear_bit(cpu, &prev->cpu_vm_mask);
-		/*
-		 * Re-load LDT if necessary
-		 */
-		if (prev->context.segments != next->context.segments)
-			load_LDT(next);
 #ifdef CONFIG_SMP
 		cpu_tlbstate[cpu].state = TLBSTATE_OK;
 		cpu_tlbstate[cpu].active_mm = next;
 #endif
 		set_bit(cpu, &next->cpu_vm_mask);
-		set_bit(cpu, &next->context.cpuvalid);
+
 		/* Re-load page tables */
 		asm volatile("movl %0,%%cr3": :"r" (__pa(next->pgd)));
+               /* load_LDT, if either the previous or next thread
+                * has a non-default LDT.
+                */
+               if (next->context.size+prev->context.size)
+                       load_LDT(&next->context);
 	}
 #ifdef CONFIG_SMP
 	else {
@@ -54,9 +54,8 @@
 			 * tlb flush IPI delivery. We must flush our tlb.
 			 */
 			local_flush_tlb();
+                       load_LDT(&next->context);
 		}
-		if (!test_and_set_bit(cpu, &next->context.cpuvalid))
-			load_LDT(next);
 	}
 #endif
 }
diff -Naur linux-2.4.12.orig/include/asm-i386/processor.h linux-2.4.12/include/asm-i386/processor.h
--- linux-2.4.12.orig/include/asm-i386/processor.h	Wed Oct 10 23:44:33 2001
+++ linux-2.4.12/include/asm-i386/processor.h	Wed Feb 13 16:11:16 2002
@@ -431,8 +431,7 @@
  */
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-/* Copy and release all segment info associated with a VM */
-extern void copy_segments(struct task_struct *p, struct mm_struct * mm);
+/* Release all segment info associated with a VM */
 extern void release_segments(struct mm_struct * mm);
 
 /*
diff -Naur linux-2.4.12.orig/kernel/fork.c linux-2.4.12/kernel/fork.c
--- linux-2.4.12.orig/kernel/fork.c	Mon Sep 17 21:46:04 2001
+++ linux-2.4.12/kernel/fork.c	Wed Feb 13 16:11:16 2002
@@ -340,11 +340,6 @@
 	if (retval)
 		goto free_pt;
 
-	/*
-	 * child gets a private LDT (if there was an LDT in the parent)
-	 */
-	copy_segments(tsk, mm);
-
 	if (init_new_context(tsk,mm))
 		goto free_pt;
 

