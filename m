Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965381AbVKHEmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965381AbVKHEmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbVKHEmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:42:11 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:43268 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030299AbVKHEmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:42:10 -0500
Date: Mon, 7 Nov 2005 20:42:02 -0800
Message-Id: <200511080442.jA84g2vH009964@zach-dev.vmware.com>
Subject: [PATCH 21/21] i386 Ldt context inline
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
X-OriginalArrivalTime: 08 Nov 2005 04:42:02.0967 (UTC) FILETIME=[C37A9670:01C5E41E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was also able to get the LDT switching functionality out of the
critical path in switch_mm, which reduces the number of function calls,
potential TLB misses and code size.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/include/asm-i386/desc.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/desc.h	2005-11-05 02:30:35.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/desc.h	2005-11-05 02:32:51.000000000 -0800
@@ -271,6 +271,9 @@ static inline void restore_bios_segments
 	put_cpu();
 }
 
+extern void destroy_ldt(mm_context_t *pc);
+extern int copy_ldt(mm_context_t *new, mm_context_t *old);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif
Index: linux-2.6.14-zach-work/include/asm-i386/mmu_context.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/mmu_context.h	2005-11-05 02:30:35.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/mmu_context.h	2005-11-05 02:32:51.000000000 -0800
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
+	memset(&mm->context, 0, sizeof(mm->context));
+	init_MUTEX(&mm->context.sem);
+	old_mm = current->mm;
+	if (old_mm && unlikely(old_mm->context.ldt)) {
+		retval = copy_ldt(&mm->context, &old_mm->context);
+	}
+	return retval;
+}
 
+/*
+ * No need to lock the MM as we are the last user
+ */
+static inline void destroy_context(struct mm_struct *mm)
+{
+	if (unlikely(mm->context.ldt))
+		destroy_ldt(&mm->context);
+}
 
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
Index: linux-2.6.14-zach-work/arch/i386/kernel/ldt.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/ldt.c	2005-11-05 02:32:28.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/ldt.c	2005-11-05 02:33:24.000000000 -0800
@@ -103,29 +103,6 @@ void destroy_ldt(mm_context_t *pc)
 	pc->ldt = NULL;
 }
 
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
-{
-	struct mm_struct * old_mm;
-	int retval = 0;
-
-	memset(&mm->context, 0, sizeof(mm->context));
-	init_MUTEX(&mm->context.sem);
-	old_mm = current->mm;
-	if (old_mm && unlikely(old_mm->context.ldt)) {
-		retval = copy_ldt(&mm->context, &old_mm->context);
-	}
-	return retval;
-}
-
-/*
- * No need to lock the MM as we are the last user
- */
-void destroy_context(struct mm_struct *mm)
-{
-	if (unlikely(mm->context.ldt))
-		destroy_ldt(&mm->context);
-}
-
 static int read_ldt(void __user * ptr, unsigned long bytecount)
 {
 	int err;
