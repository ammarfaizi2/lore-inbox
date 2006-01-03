Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWACVUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWACVUT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWACVUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:20:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:43407 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932554AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 41/50] cris: task_pt_regs()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNb-0008Rm-63@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/cris/arch-v10/kernel/process.c |    4 ++--
 arch/cris/arch-v10/kernel/ptrace.c  |    4 ++--
 arch/cris/arch-v32/kernel/process.c |    4 ++--
 arch/cris/arch-v32/kernel/ptrace.c  |    6 +++---
 include/asm-cris/processor.h        |    3 ++-
 5 files changed, 11 insertions(+), 10 deletions(-)

affad4ed8fe3848f72408d3441c8991ccf7042be
diff --git a/arch/cris/arch-v10/kernel/process.c b/arch/cris/arch-v10/kernel/process.c
index 69e28b4..1fec580 100644
--- a/arch/cris/arch-v10/kernel/process.c
+++ b/arch/cris/arch-v10/kernel/process.c
@@ -79,7 +79,7 @@ void hard_reset_now (void)
  */
 unsigned long thread_saved_pc(struct task_struct *t)
 {
-	return (unsigned long)user_regs(t->thread_info)->irp;
+	return task_pt_regs(t)->irp;
 }
 
 static void kernel_thread_helper(void* dummy, int (*fn)(void *), void * arg)
@@ -128,7 +128,7 @@ int copy_thread(int nr, unsigned long cl
 	 * remember that the task_struct doubles as the kernel stack for the task
 	 */
 
-	childregs = user_regs(p->thread_info);        
+	childregs = task_pt_regs(p);        
         
 	*childregs = *regs;  /* struct copy of pt_regs */
         
diff --git a/arch/cris/arch-v10/kernel/ptrace.c b/arch/cris/arch-v10/kernel/ptrace.c
index 6cbd34a..f214f74 100644
--- a/arch/cris/arch-v10/kernel/ptrace.c
+++ b/arch/cris/arch-v10/kernel/ptrace.c
@@ -37,7 +37,7 @@ inline long get_reg(struct task_struct *
 	if (regno == PT_USP)
 		return task->thread.usp;
 	else if (regno < PT_MAX)
-		return ((unsigned long *)user_regs(task->thread_info))[regno];
+		return ((unsigned long *)task_pt_regs(task))[regno];
 	else
 		return 0;
 }
@@ -51,7 +51,7 @@ inline int put_reg(struct task_struct *t
 	if (regno == PT_USP)
 		task->thread.usp = data;
 	else if (regno < PT_MAX)
-		((unsigned long *)user_regs(task->thread_info))[regno] = data;
+		((unsigned long *)task_pt_regs(task))[regno] = data;
 	else
 		return -1;
 	return 0;
diff --git a/arch/cris/arch-v32/kernel/process.c b/arch/cris/arch-v32/kernel/process.c
index 882be42..e88b13b 100644
--- a/arch/cris/arch-v32/kernel/process.c
+++ b/arch/cris/arch-v32/kernel/process.c
@@ -96,7 +96,7 @@ hard_reset_now(void)
  */
 unsigned long thread_saved_pc(struct task_struct *t)
 {
-	return (unsigned long)user_regs(t->thread_info)->erp;
+	return task_pt_regs(t)->erp;
 }
 
 static void
@@ -148,7 +148,7 @@ copy_thread(int nr, unsigned long clone_
 	 * fix it up. Note: the task_struct doubles as the kernel stack for the
 	 * task.
 	 */
-	childregs = user_regs(p->thread_info);
+	childregs = task_pt_regs(p);
 	*childregs = *regs;	/* Struct copy of pt_regs. */
         p->set_child_tid = p->clear_child_tid = NULL;
         childregs->r10 = 0;	/* Child returns 0 after a fork/clone. */
diff --git a/arch/cris/arch-v32/kernel/ptrace.c b/arch/cris/arch-v32/kernel/ptrace.c
index 5528b83..82cf2e3 100644
--- a/arch/cris/arch-v32/kernel/ptrace.c
+++ b/arch/cris/arch-v32/kernel/ptrace.c
@@ -46,7 +46,7 @@ long get_reg(struct task_struct *task, u
 	unsigned long ret;
 
 	if (regno <= PT_EDA)
-		ret = ((unsigned long *)user_regs(task->thread_info))[regno];
+		ret = ((unsigned long *)task_pt_regs(task))[regno];
 	else if (regno == PT_USP)
 		ret = task->thread.usp;
 	else if (regno == PT_PPC)
@@ -65,13 +65,13 @@ long get_reg(struct task_struct *task, u
 int put_reg(struct task_struct *task, unsigned int regno, unsigned long data)
 {
 	if (regno <= PT_EDA)
-		((unsigned long *)user_regs(task->thread_info))[regno] = data;
+		((unsigned long *)task_pt_regs(task))[regno] = data;
 	else if (regno == PT_USP)
 		task->thread.usp = data;
 	else if (regno == PT_PPC) {
 		/* Write pseudo-PC to ERP only if changed. */
 		if (data != get_pseudo_pc(task))
-			((unsigned long *)user_regs(task->thread_info))[PT_ERP] = data;
+			task_pt_regs(task)->erp = data;
 	} else if (regno <= PT_MAX)
 		return put_debugreg(task->pid, regno, data);
 	else
diff --git a/include/asm-cris/processor.h b/include/asm-cris/processor.h
index dce4100..961e2bc 100644
--- a/include/asm-cris/processor.h
+++ b/include/asm-cris/processor.h
@@ -45,7 +45,8 @@ struct task_struct;
  * Dito but for the currently running task
  */
 
-#define current_regs() user_regs(current->thread_info)
+#define task_pt_regs(task) user_regs(task_thread_info(task))
+#define current_regs() task_pt_regs(current)
 
 static inline void prepare_to_copy(struct task_struct *tsk)
 {
-- 
0.99.9.GIT

