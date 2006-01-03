Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWACVLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWACVLJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWACVHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:45967 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932546AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 40/50] powerpc: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNb-0008Rk-5l@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/powerpc/kernel/process.c |   10 ++++------
 arch/ppc/kernel/process.c     |    8 ++++----
 2 files changed, 8 insertions(+), 10 deletions(-)

1cf48f33ad88078b946ddf907f87ec1f313432c7
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index bc03526..1f816f0 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -503,7 +503,7 @@ int copy_thread(int nr, unsigned long cl
 {
 	struct pt_regs *childregs, *kregs;
 	extern void ret_from_fork(void);
-	unsigned long sp = (unsigned long)p->thread_info + THREAD_SIZE;
+	unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
 
 	CHECK_FULL_REGS(regs);
 	/* Copy registers */
@@ -588,10 +588,8 @@ void start_thread(struct pt_regs *regs, 
 	 * set.  Do it now.
 	 */
 	if (!current->thread.regs) {
-		unsigned long childregs = (unsigned long)current->thread_info +
-						THREAD_SIZE;
-		childregs -= sizeof(struct pt_regs);
-		current->thread.regs = (struct pt_regs *)childregs;
+		struct pt_regs *regs = task_stack_page(current) + THREAD_SIZE;
+		current->thread.regs = regs - 1;
 	}
 
 	memset(regs->gpr, 0, sizeof(regs->gpr));
@@ -767,7 +765,7 @@ out:
 static int validate_sp(unsigned long sp, struct task_struct *p,
 		       unsigned long nbytes)
 {
-	unsigned long stack_page = (unsigned long)p->thread_info;
+	unsigned long stack_page = (unsigned long)task_stack_page(p);
 
 	if (sp >= stack_page + sizeof(struct thread_struct)
 	    && sp <= stack_page + THREAD_SIZE - nbytes)
diff --git a/arch/ppc/kernel/process.c b/arch/ppc/kernel/process.c
index c3555a8..a76b504 100644
--- a/arch/ppc/kernel/process.c
+++ b/arch/ppc/kernel/process.c
@@ -482,7 +482,7 @@ copy_thread(int nr, unsigned long clone_
 {
 	struct pt_regs *childregs, *kregs;
 	extern void ret_from_fork(void);
-	unsigned long sp = (unsigned long)p->thread_info + THREAD_SIZE;
+	unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
 	unsigned long childframe;
 
 	CHECK_FULL_REGS(regs);
@@ -702,8 +702,8 @@ void show_stack(struct task_struct *tsk,
 			sp = tsk->thread.ksp;
 	}
 
-	prev_sp = (unsigned long) (tsk->thread_info + 1);
-	stack_top = (unsigned long) tsk->thread_info + THREAD_SIZE;
+	prev_sp = (unsigned long) end_of_stack(tsk);
+	stack_top = (unsigned long) task_stack_page(tsk) + THREAD_SIZE;
 	while (count < 16 && sp > prev_sp && sp < stack_top && (sp & 3) == 0) {
 		if (count == 0) {
 			printk("Call trace:");
@@ -832,7 +832,7 @@ void __init ll_puts(const char *s)
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long ip, sp;
-	unsigned long stack_page = (unsigned long) p->thread_info;
+	unsigned long stack_page = (unsigned long) task_stack_page(p);
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
-- 
0.99.9.GIT

