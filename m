Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbVKHEmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbVKHEmK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbVKHEmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:42:09 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:40196 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030299AbVKHEmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:42:07 -0500
Date: Mon, 7 Nov 2005 20:40:53 -0800
Message-Id: <200511080440.jA84er9k009958@zach-dev.vmware.com>
Subject: [PATCH 20/21] i386 Ldt cleanups 3
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 08 Nov 2005 04:40:53.0777 (UTC) FILETIME=[9A3D0810:01C5E41E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Big cleanup of LDT code.  This code has very little type checking and is
not frequently used, so I audited the code, added type checking and size
optimizations to generate smaller assembly code.  I changed the ldt count
to be in pages, and converted the char * ldt into a desc_struct. 

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/arch/i386/kernel/ldt.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/ldt.c	2005-11-05 00:28:03.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/ldt.c	2005-11-05 02:32:28.000000000 -0800
@@ -19,7 +19,7 @@
 #include <asm/ldt.h>
 #include <asm/desc.h>
 
-#ifdef CONFIG_SMP /* avoids "defined but not used" warnig */
+#ifdef CONFIG_SMP /* avoids "defined but not used" warning */
 static void flush_ldt(void *null)
 {
 	if (current->active_mm)
@@ -27,33 +27,33 @@ static void flush_ldt(void *null)
 }
 #endif
 
-static int alloc_ldt(mm_context_t *pc, int mincount, int reload)
+static inline int alloc_ldt(mm_context_t *pc, const int old_pages, int new_pages, const int reload)
 {
-	void *oldldt;
-	void *newldt;
-	int oldsize;
+	struct desc_struct *oldldt;
+	struct desc_struct *newldt;
 
-	if (mincount <= pc->size)
-		return 0;
-	oldsize = pc->size;
-	mincount = (mincount+511)&(~511);
-	if (mincount*LDT_ENTRY_SIZE > PAGE_SIZE)
-		newldt = vmalloc(mincount*LDT_ENTRY_SIZE);
+	if (new_pages > 1)
+		newldt = vmalloc(new_pages*PAGE_SIZE);
 	else
-		newldt = kmalloc(mincount*LDT_ENTRY_SIZE, GFP_KERNEL);
+		newldt = kmalloc(PAGE_SIZE, GFP_KERNEL);
 
 	if (!newldt)
 		return -ENOMEM;
 
-	if (oldsize)
-		memcpy(newldt, pc->ldt, oldsize*LDT_ENTRY_SIZE);
+	if (old_pages)
+		memcpy(newldt, pc->ldt, old_pages*PAGE_SIZE);
 	oldldt = pc->ldt;
-	memset(newldt+oldsize*LDT_ENTRY_SIZE, 0, (mincount-oldsize)*LDT_ENTRY_SIZE);
+	if (reload)
+		memset(newldt+old_pages*LDT_ENTRIES_PER_PAGE, 0, (new_pages-old_pages)*PAGE_SIZE);
 	pc->ldt = newldt;
 	wmb();
-	pc->size = mincount;
+	pc->ldt_pages = new_pages;
 	wmb();
 
+	/*
+	 * If updating an active LDT, must reload LDT on all processors
+	 * where it could be active.
+	 */
 	if (reload) {
 #ifdef CONFIG_SMP
 		cpumask_t mask;
@@ -67,8 +67,8 @@ static int alloc_ldt(mm_context_t *pc, i
 		load_LDT(pc);
 #endif
 	}
-	if (oldsize) {
-		if (oldsize*LDT_ENTRY_SIZE > PAGE_SIZE)
+	if (old_pages) {
+		if (old_pages > 1)
 			vfree(oldldt);
 		else
 			kfree(oldldt);
@@ -76,31 +76,43 @@ static int alloc_ldt(mm_context_t *pc, i
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
+	err = alloc_ldt(new, 0, old->ldt_pages, 0);
+	if (!err)
+		memcpy(new->ldt, old->ldt, old->ldt_pages*PAGE_SIZE);
+	up(&old->sem);
+	return err;
+}
+
+void destroy_ldt(mm_context_t *pc)
+{
+	int pages = pc->ldt_pages;
+	struct desc_struct *ldt = pc->ldt;
+
+	if (pc == &current->active_mm->context)
+		clear_LDT();
+	if (pages > 1)
+		vfree(ldt);
+	else
+		kfree(ldt);
+	pc->ldt_pages = 0;
+	pc->ldt = NULL;
 }
 
-/*
- * we do not have to muck with descriptors here, that is
- * done in switch_mm() as needed.
- */
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	struct mm_struct * old_mm;
 	int retval = 0;
 
+	memset(&mm->context, 0, sizeof(mm->context));
 	init_MUTEX(&mm->context.sem);
-	mm->context.size = 0;
 	old_mm = current->mm;
-	if (old_mm && old_mm->context.size > 0) {
-		down(&old_mm->context.sem);
+	if (old_mm && unlikely(old_mm->context.ldt)) {
 		retval = copy_ldt(&mm->context, &old_mm->context);
-		up(&old_mm->context.sem);
 	}
 	return retval;
 }
@@ -110,37 +122,30 @@ int init_new_context(struct task_struct 
  */
 void destroy_context(struct mm_struct *mm)
 {
-	if (mm->context.size) {
-		if (mm == current->active_mm)
-			clear_LDT();
-		if (mm->context.size*LDT_ENTRY_SIZE > PAGE_SIZE)
-			vfree(mm->context.ldt);
-		else
-			kfree(mm->context.ldt);
-		mm->context.size = 0;
-	}
+	if (unlikely(mm->context.ldt))
+		destroy_ldt(&mm->context);
 }
 
 static int read_ldt(void __user * ptr, unsigned long bytecount)
 {
 	int err;
 	unsigned long size;
-	struct mm_struct * mm = current->mm;
+	mm_context_t *pc = &current->mm->context;
 
-	if (!mm->context.size)
+	if (!pc->ldt_pages)
 		return 0;
 	if (bytecount > LDT_ENTRY_SIZE*LDT_ENTRIES)
 		bytecount = LDT_ENTRY_SIZE*LDT_ENTRIES;
 
-	down(&mm->context.sem);
-	size = mm->context.size*LDT_ENTRY_SIZE;
+	down(&pc->sem);
+	size = pc->ldt_pages*PAGE_SIZE;
 	if (size > bytecount)
 		size = bytecount;
 
 	err = 0;
-	if (copy_to_user(ptr, mm->context.ldt, size))
+	if (copy_to_user(ptr, pc->ldt, size))
 		err = -EFAULT;
-	up(&mm->context.sem);
+	up(&pc->sem);
 	if (err < 0)
 		goto error_return;
 	if (size != bytecount) {
@@ -176,10 +181,11 @@ static int read_default_ldt(void __user 
 
 static int write_ldt(void __user * ptr, unsigned long bytecount, int oldmode)
 {
-	struct mm_struct * mm = current->mm;
+	mm_context_t *pc = &current->mm->context;
 	__u32 entry_1, entry_2;
 	int error;
 	struct user_desc ldt_info;
+	int page_number;
 
 	error = -EINVAL;
 	if (bytecount != sizeof(ldt_info))
@@ -198,9 +204,11 @@ static int write_ldt(void __user * ptr, 
 			goto out;
 	}
 
-	down(&mm->context.sem);
-	if (ldt_info.entry_number >= mm->context.size) {
-		error = alloc_ldt(&current->mm->context, ldt_info.entry_number+1, 1);
+	page_number = ldt_info.entry_number / LDT_ENTRIES_PER_PAGE;
+	down(&pc->sem);
+	if (page_number >= pc->ldt_pages) {
+		error = alloc_ldt(pc, pc->ldt_pages, 
+				  page_number+1, 1);
 		if (error < 0)
 			goto out_unlock;
 	}
@@ -221,11 +229,11 @@ static int write_ldt(void __user * ptr, 
 
 	/* Install the new entry ...  */
 install:
-	write_ldt_entry(mm->context.ldt, ldt_info.entry_number, entry_1, entry_2);
+	write_ldt_entry(pc->ldt, ldt_info.entry_number, entry_1, entry_2);
 	error = 0;
 
 out_unlock:
-	up(&mm->context.sem);
+	up(&pc->sem);
 out:
 	return error;
 }
Index: linux-2.6.14-zach-work/include/asm-i386/desc.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/desc.h	2005-11-05 01:26:46.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/desc.h	2005-11-05 02:30:35.000000000 -0800
@@ -218,7 +218,7 @@ static inline void clear_LDT(void)
 static inline void load_LDT_nolock(mm_context_t *pc, int cpu)
 {
 	void *segments = pc->ldt;
-	int count = pc->size;
+	int count = pc->ldt_pages * LDT_ENTRIES_PER_PAGE;
 
 	if (likely(!count)) {
 		segments = &default_ldt[0];
Index: linux-2.6.14-zach-work/include/asm-i386/mmu.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/mmu.h	2005-11-05 00:28:03.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/mmu.h	2005-11-05 01:34:31.000000000 -0800
@@ -9,9 +9,9 @@
  * cpu_vm_mask is used to optimize ldt flushing.
  */
 typedef struct { 
-	int size;
 	struct semaphore sem;
-	void *ldt;
+	struct desc_struct *ldt;
+	int ldt_pages;
 } mm_context_t;
 
 #endif
