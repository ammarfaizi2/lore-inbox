Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbUANT2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264423AbUANT2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:28:24 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:61592 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264258AbUANTZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:25:30 -0500
Message-ID: <4005972B.9040801@colorfullife.com>
Date: Wed, 14 Jan 2004 20:23:23 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH, BACKPORT] ldt optimization
Content-Type: multipart/mixed;
 boundary="------------020106000301020409020002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020106000301020409020002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

linuxthreads uses the ldt to identify the threads in a process. This 
results in a modify_ldt call, which causes a 64kB vmalloc call, for 
every process that is linked against libpthread. vmalloc space is often 
tight, which limits the number of processes that can run concurrently. I 
remember one report of failures with 80 users on a multiuser kde x-server.
The attached patch changes the ldt allocation to try to use kmalloc if 
possible, and to limit the initial allocation size to 2 kB. 
Additionally, the patch adds proper failure returns. The curent code 
just prinkt's the error and continues the fork() syscall [and silently 
drops the ldt].

2.6 contains a similar patch, and it was (is?) in several distro and ac 
kernels.

Marcelo, could you add it to your tree?

--
    Manfred


--------------020106000301020409020002
Content-Type: text/plain;
 name="patch-ldt-24"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ldt-24"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 20
//  EXTRAVERSION = -pre4
--- 2.4/arch/i386/kernel/process.c	Sun Aug 25 03:08:10 2002
+++ build-2.4/arch/i386/kernel/process.c	Sun Aug 25 03:08:03 2002
@@ -466,23 +466,6 @@
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
@@ -534,45 +517,19 @@
 void release_thread(struct task_struct *dead_task)
 {
 	if (dead_task->mm) {
-		void * ldt = dead_task->mm->context.segments;
-
 		// temporary debugging check
-		if (ldt) {
-			printk("WARNING: dead process %8s still has LDT? <%p>\n",
-					dead_task->comm, ldt);
+		if (dead_task->mm->context.size) {
+			printk("WARNING: dead process %8s still has LDT? <%p/%d>\n",
+					dead_task->comm,
+					dead_task->mm->context.ldt,
+					dead_task->mm->context.size);
 			BUG();
 		}
 	}
-
 	release_x86_irqs(dead_task);
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
--- 2.4/arch/i386/kernel/ldt.c	Sun Aug 25 03:08:10 2002
+++ build-2.4/arch/i386/kernel/ldt.c	Sun Aug 25 03:24:26 2002
@@ -12,37 +12,139 @@
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
+	if (current->active_mm)
+		load_LDT(&current->active_mm->context);
+}
+#endif
+
+static int alloc_ldt(mm_context_t *pc, int mincount, int reload)
+{
+	void *oldldt;
+	void *newldt;
+	int oldsize;
+
+	if (mincount <= pc->size)
+		return 0;
+	oldsize = pc->size;
+	mincount = (mincount+511)&(~511);
+	if (mincount*LDT_ENTRY_SIZE > PAGE_SIZE)
+		newldt = vmalloc(mincount*LDT_ENTRY_SIZE);
+	else
+		newldt = kmalloc(mincount*LDT_ENTRY_SIZE, GFP_KERNEL);
+
+	if (!newldt)
+		return -ENOMEM;
+
+	if (oldsize)
+		memcpy(newldt, pc->ldt, oldsize*LDT_ENTRY_SIZE);
+
+	oldldt = pc->ldt;
+	memset(newldt+oldsize*LDT_ENTRY_SIZE, 0, (mincount-oldsize)*LDT_ENTRY_SIZE);
+	wmb();
+	pc->ldt = newldt;
+	pc->size = mincount;
+	if (reload) {
+		load_LDT(pc);
+#ifdef CONFIG_SMP
+		if (current->mm->cpu_vm_mask != (1<<smp_processor_id()))
+			smp_call_function(flush_ldt, 0, 1, 1);
+#endif
+	}
+	wmb();
+	if (oldsize) {
+		if (oldsize*LDT_ENTRY_SIZE > PAGE_SIZE)
+			vfree(oldldt);
+		else
+			kfree(oldldt);
+	}
+	return 0;
+}
+
+static inline int copy_ldt(mm_context_t *new, mm_context_t *old)
+{
+	int err = alloc_ldt(new, old->size, 0);
+	if (err < 0) {
+		printk(KERN_WARNING "ldt allocation failed\n");
+		new->size = 0;
+		return err;
+	}
+	memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
+	return 0;
+}
+
+/*
+ * we do not have to muck with descriptors here, that is
+ * done in switch_mm() as needed.
+ */
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	struct mm_struct * old_mm;
+	int retval = 0;
+
+	init_MUTEX(&mm->context.sem);
+	mm->context.size = 0;
+	old_mm = current->mm;
+	if (old_mm && old_mm->context.size > 0) {
+		down(&old_mm->context.sem);
+		retval = copy_ldt(&mm->context, &old_mm->context);
+		up(&old_mm->context.sem);
+	}
+	return retval;
+}
+
 /*
- * read_ldt() is not really atomic - this is not a problem since
- * synchronization of reads and writes done to the LDT has to be
- * assured by user-space anyway. Writes are atomic, to protect
- * the security checks done on new descriptors.
+ * No need to lock the MM as we are the last user
+ * Do not touch the ldt register, we are already
+ * in the next thread.
  */
+void destroy_context(struct mm_struct *mm)
+{
+	if (mm->context.size) {
+		if (mm->context.size*LDT_ENTRY_SIZE > PAGE_SIZE)
+			vfree(mm->context.ldt);
+		else
+			kfree(mm->context.ldt);
+		mm->context.size = 0;
+	}
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
+	if (!mm->context.size)
+		return 0;
+	if (bytecount > LDT_ENTRY_SIZE*LDT_ENTRIES)
+		bytecount = LDT_ENTRY_SIZE*LDT_ENTRIES;
 
-	size = LDT_ENTRIES*LDT_ENTRY_SIZE;
+	down(&mm->context.sem);
+	size = mm->context.size*LDT_ENTRY_SIZE;
 	if (size > bytecount)
 		size = bytecount;
 
-	err = size;
-	if (copy_to_user(ptr, mm->context.segments, size))
+	err = 0;
+	if (copy_to_user(ptr, mm->context.ldt, size))
 		err = -EFAULT;
-out:
-	return err;
+	up(&mm->context.sem);
+	if (err < 0)
+		return err;
+	if (size != bytecount) {
+		/* zero-fill the rest */
+		clear_user(ptr+size, bytecount-size);
+	}
+	return bytecount;
 }
 
 static int read_default_ldt(void * ptr, unsigned long bytecount)
@@ -53,7 +155,7 @@
 
 	err = 0;
 	address = &default_ldt[0];
-	size = sizeof(struct desc_struct);
+	size = 5*sizeof(struct desc_struct);
 	if (size > bytecount)
 		size = bytecount;
 
@@ -88,24 +190,14 @@
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
+	down(&mm->context.sem);
+	if (ldt_info.entry_number >= mm->context.size) {
+		error = alloc_ldt(&current->mm->context, ldt_info.entry_number+1, 1);
+		if (error < 0)
 			goto out_unlock;
-		memset(segments, 0, LDT_ENTRIES*LDT_ENTRY_SIZE);
-		wmb();
-		mm->context.segments = segments;
-		mm->context.cpuvalid = 1UL << smp_processor_id();
-		load_LDT(mm);
 	}
 
-	lp = (__u32 *) ((ldt_info.entry_number << 3) + (char *) mm->context.segments);
+	lp = (__u32 *) ((ldt_info.entry_number << 3) + (char *) mm->context.ldt);
 
    	/* Allow LDTs to be cleared by the user. */
    	if (ldt_info.base_addr == 0 && ldt_info.limit == 0) {
@@ -143,7 +235,7 @@
 	error = 0;
 
 out_unlock:
-	up_write(&mm->mmap_sem);
+	up(&mm->context.sem);
 out:
 	return error;
 }
--- 2.4/include/asm-i386/mmu.h	Sun Aug 25 03:08:10 2002
+++ build-2.4/include/asm-i386/mmu.h	Sat Aug 24 22:16:00 2002
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
+	int size;
+	struct semaphore sem;
+	void *	ldt;
 } mm_context_t;
 
 #endif
--- 2.4/include/asm-i386/desc.h	Sun Aug 25 03:08:10 2002
+++ build-2.4/include/asm-i386/desc.h	Sat Aug 24 22:16:00 2002
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
+	void *segments = pc->ldt;
+	int count = pc->size;
 
-	if (!segments) {
+	if (!count) {
 		segments = &default_ldt[0];
 		count = 5;
 	}
--- 2.4/include/asm-i386/mmu_context.h	Sun Aug 25 03:08:10 2002
+++ build-2.4/include/asm-i386/mmu_context.h	Sun Aug 25 03:11:23 2002
@@ -7,10 +7,12 @@
 #include <asm/pgalloc.h>
 
 /*
- * possibly do the LDT unload here?
+ * hooks to add arch specific data into the mm struct.
+ * Note that destroy_context is called even if init_new_context
+ * fails.
  */
-#define destroy_context(mm)		do { } while(0)
-#define init_new_context(tsk,mm)	0
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+void destroy_context(struct mm_struct *mm);
 
 #ifdef CONFIG_SMP
 
@@ -30,19 +32,18 @@
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
 		/* Re-load page tables */
 		load_cr3(next->pgd);
+	 	/* load_LDT, if either the previous or next thread
+		 * has a non-default LDT.
+		 */
+		if (next->context.size+prev->context.size)
+			load_LDT(&next->context);
 	}
 #ifdef CONFIG_SMP
 	else {
@@ -54,9 +55,8 @@
 			 * tlb flush IPI delivery. We must reload %cr3.
 			 */
 			load_cr3(next->pgd);
+			load_LDT(&next->context);
 		}
-		if (!test_and_set_bit(cpu, &next->context.cpuvalid))
-			load_LDT(next);
 	}
 #endif
 }
--- 2.4/include/asm-i386/processor.h	Sun Aug 25 03:08:10 2002
+++ build-2.4/include/asm-i386/processor.h	Sun Aug 25 03:10:31 2002
@@ -435,9 +435,12 @@
  */
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-/* Copy and release all segment info associated with a VM */
-extern void copy_segments(struct task_struct *p, struct mm_struct * mm);
-extern void release_segments(struct mm_struct * mm);
+/* Copy and release all segment info associated with a VM
+ * Unusable due to lack of error handling, use {init_new,destroy}_context
+ * instead.
+ */
+static inline void copy_segments(struct task_struct *p, struct mm_struct * mm) { }
+static inline void release_segments(struct mm_struct * mm) { }
 
 /*
  * Return saved PC of a blocked thread.
--- 2.4/arch/i386/math-emu/fpu_system.h	Sun Aug 25 03:08:10 2002
+++ build-2.4/arch/i386/math-emu/fpu_system.h	Sat Aug 24 22:16:00 2002
@@ -20,7 +20,7 @@
    of the stack frame of math_emulate() */
 #define SETUP_DATA_AREA(arg)	FPU_info = (struct info *) &arg
 
-#define LDT_DESCRIPTOR(s)	(((struct desc_struct *)current->mm->context.segments)[(s) >> 3])
+#define LDT_DESCRIPTOR(s)	(((struct desc_struct *)current->mm->context.ldt)[(s) >> 3])
 #define SEG_D_SIZE(x)		((x).b & (3 << 21))
 #define SEG_G_BIT(x)		((x).b & (1 << 23))
 #define SEG_GRANULARITY(x)	(((x).b & (1 << 23)) ? 4096 : 1)


--------------020106000301020409020002--

