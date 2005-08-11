Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVHKE6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVHKE6G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVHKE6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:58:05 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:51206 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932265AbVHKE6C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:58:02 -0400
Date: Wed, 10 Aug 2005 21:58:01 -0700
From: zach@vmware.com
Message-Id: <200508110458.j7B4w1NU019619@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwane@arm.linux.org.uk
Subject: [PATCH 12/14] i386 / Move context switch inline
X-OriginalArrivalTime: 11 Aug 2005 04:58:14.0452 (UTC) FILETIME=[47C3AF40:01C59E31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By moving init_new_context and destroy_context inline into mmu_context.h,
we can avoid extra functions calls, which are only needed for the unlikely
case that the process context has an LDT to deal with.

Now the code in ldt.c is called only when actually dealing with LDT
creation or destruction.  Careful analysis of alloc_ldt function showed
that by using two const parameters, huge amounts of dead code would be
eliminated, allowing it to inline into copy_ldt.  This results in just
better assembly code everywhere, and saves 118 bytes of space in my
compilation - even with a lesser gcc (3.2.2).

Less importantly, it puts the context code in mmu_context.h, which is
just cleaner and helps make some later hypervisor diffs more readable.

Patch-against: 2.6.13-rc5-mm1
Patch-keys: i386 ldt mmu optimize cleanup
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/kernel/ldt.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/ldt.c	2005-08-10 17:04:59.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/ldt.c	2005-08-10 20:40:16.000000000 -0700
@@ -19,7 +19,7 @@
 #include <asm/ldt.h>
 #include <asm/desc.h>
 
-#ifdef CONFIG_SMP /* avoids "defined but not used" warnig */
+#ifdef CONFIG_SMP /* avoids "defined but not used" warning */
 static void flush_ldt(void *null)
 {
 	if (current->active_mm)
@@ -27,15 +27,11 @@
 }
 #endif
 
-static int alloc_ldt(mm_context_t *pc, int mincount, int reload)
+static inline int alloc_ldt(mm_context_t *pc, const int oldsize, int mincount, const int reload)
 {
 	void *oldldt;
 	void *newldt;
-	int oldsize;
 
-	if (mincount <= pc->size)
-		return 0;
-	oldsize = pc->size;
 	mincount = (mincount+511)&(~511);
 	if (mincount*LDT_ENTRY_SIZE > PAGE_SIZE)
 		newldt = vmalloc(mincount*LDT_ENTRY_SIZE);
@@ -48,12 +44,17 @@
 	if (oldsize)
 		memcpy(newldt, pc->ldt, oldsize*LDT_ENTRY_SIZE);
 	oldldt = pc->ldt;
-	memset(newldt+oldsize*LDT_ENTRY_SIZE, 0, (mincount-oldsize)*LDT_ENTRY_SIZE);
+	if (reload)
+		memset(newldt+oldsize*LDT_ENTRY_SIZE, 0, (mincount-oldsize)*LDT_ENTRY_SIZE);
 	pc->ldt = newldt;
 	wmb();
 	pc->size = mincount;
 	wmb();
 
+	/*
+	 * If updating an active LDT, must reload LDT on all processors
+	 * where it could be active.
+	 */
 	if (reload) {
 #ifdef CONFIG_SMP
 		cpumask_t mask;
@@ -76,49 +77,27 @@
 	return 0;
 }
 
-static inline int copy_ldt(mm_context_t *new, mm_context_t *old)
+int copy_ldt(mm_context_t *new, mm_context_t *old)
 {
-	int err = alloc_ldt(new, old->size, 0);
-	if (err < 0)
-		return err;
-	memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
-	return 0;
+	int err;
+
+	down(&old->sem);
+	err = alloc_ldt(new, 0, old->size, 0);
+	if (!err)
+		memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
+	up(&old->sem);
+	return err;
 }
 
-/*
- * we do not have to muck with descriptors here, that is
- * done in switch_mm() as needed.
- */
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+void destroy_ldt(struct mm_struct *mm)
 {
-	struct mm_struct * old_mm;
-	int retval = 0;
-
-	init_MUTEX(&mm->context.sem);
+	if (mm == current->active_mm)
+		clear_LDT();
+	if (mm->context.size*LDT_ENTRY_SIZE > PAGE_SIZE)
+		vfree(mm->context.ldt);
+	else
+		kfree(mm->context.ldt);
 	mm->context.size = 0;
-	old_mm = current->mm;
-	if (old_mm && old_mm->context.size > 0) {
-		down(&old_mm->context.sem);
-		retval = copy_ldt(&mm->context, &old_mm->context);
-		up(&old_mm->context.sem);
-	}
-	return retval;
-}
-
-/*
- * No need to lock the MM as we are the last user
- */
-void destroy_context(struct mm_struct *mm)
-{
-	if (mm->context.size) {
-		if (mm == current->active_mm)
-			clear_LDT();
-		if (mm->context.size*LDT_ENTRY_SIZE > PAGE_SIZE)
-			vfree(mm->context.ldt);
-		else
-			kfree(mm->context.ldt);
-		mm->context.size = 0;
-	}
 }
 
 static int read_ldt(void __user * ptr, unsigned long bytecount)
@@ -200,7 +179,8 @@
 
 	down(&mm->context.sem);
 	if (ldt_info.entry_number >= mm->context.size) {
-		error = alloc_ldt(&current->mm->context, ldt_info.entry_number+1, 1);
+		error = alloc_ldt(&current->mm->context, mm->context.size,
+					ldt_info.entry_number+1, 1);
 		if (error < 0)
 			goto out_unlock;
 	}
Index: linux-2.6.13/include/asm-i386/mmu_context.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mmu_context.h	2005-08-10 17:04:59.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mmu_context.h	2005-08-10 20:39:57.000000000 -0700
@@ -10,9 +10,28 @@
 /*
  * Used for LDT copy/destruction.
  */
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
-void destroy_context(struct mm_struct *mm);
+static inline int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	struct mm_struct * old_mm;
+	int retval = 0;
+
+	init_MUTEX(&mm->context.sem);
+	mm->context.size = 0;
+	old_mm = current->mm;
+	if (old_mm && unlikely(old_mm->context.size > 0)) {
+		retval = copy_ldt(&mm->context, &old_mm->context);
+	}
+	return retval;
+}
 
+/*
+ * No need to lock the MM as we are the last user
+ */
+static inline void destroy_context(struct mm_struct *mm)
+{
+	if (unlikely(mm->context.size))
+		destroy_ldt(mm);
+}
 
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
Index: linux-2.6.13/include/asm-i386/desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/desc.h	2005-08-10 17:04:59.000000000 -0700
+++ linux-2.6.13/include/asm-i386/desc.h	2005-08-10 17:06:52.000000000 -0700
@@ -189,5 +189,8 @@
 	put_cpu();
 }
 
+extern void destroy_ldt(struct mm_struct *mm);
+extern int copy_ldt(mm_context_t *new, mm_context_t *old);
+
 #endif /* !__ASSEMBLY__ */
 #endif
