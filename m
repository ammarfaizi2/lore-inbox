Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWACVVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWACVVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWACVUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:20:22 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41103 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932566AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 32/50] arm: task_pt_regs()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008R1-VL@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/arm/kernel/process.c   |    5 ++---
 arch/arm/kernel/ptrace.c    |   27 +++++----------------------
 include/asm-arm/processor.h |    8 +++++---
 3 files changed, 12 insertions(+), 28 deletions(-)

5ca51a6d11309abee363a9ae63556573fa8efd23
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index ca0febd..6c82d6b 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -356,10 +356,9 @@ int
 copy_thread(int nr, unsigned long clone_flags, unsigned long stack_start,
 	    unsigned long stk_sz, struct task_struct *p, struct pt_regs *regs)
 {
-	struct thread_info *thread = p->thread_info;
-	struct pt_regs *childregs;
+	struct thread_info *thread = task_thread_info(p);
+	struct pt_regs *childregs = task_pt_regs(p);
 
-	childregs = (void *)thread + THREAD_START_SP - sizeof(*regs);
 	*childregs = *regs;
 	childregs->ARM_r0 = 0;
 	childregs->ARM_sp = stack_start;
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index f003062..e591f72 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -55,23 +55,6 @@
 #endif
 
 /*
- * Get the address of the live pt_regs for the specified task.
- * These are saved onto the top kernel stack when the process
- * is not running.
- *
- * Note: if a user thread is execve'd from kernel space, the
- * kernel stack will not be empty on entry to the kernel, so
- * ptracing these tasks will fail.
- */
-static inline struct pt_regs *
-get_user_regs(struct task_struct *task)
-{
-	return (struct pt_regs *)
-		((unsigned long)task->thread_info + THREAD_SIZE -
-				 8 - sizeof(struct pt_regs));
-}
-
-/*
  * this routine will get a word off of the processes privileged stack.
  * the offset is how far from the base addr as stored in the THREAD.
  * this routine assumes that all the privileged stacks are in our
@@ -79,7 +62,7 @@ get_user_regs(struct task_struct *task)
  */
 static inline long get_user_reg(struct task_struct *task, int offset)
 {
-	return get_user_regs(task)->uregs[offset];
+	return task_pt_regs(task)->uregs[offset];
 }
 
 /*
@@ -91,7 +74,7 @@ static inline long get_user_reg(struct t
 static inline int
 put_user_reg(struct task_struct *task, int offset, long data)
 {
-	struct pt_regs newregs, *regs = get_user_regs(task);
+	struct pt_regs newregs, *regs = task_pt_regs(task);
 	int ret = -EINVAL;
 
 	newregs = *regs;
@@ -421,7 +404,7 @@ void ptrace_set_bpt(struct task_struct *
 	u32 insn;
 	int res;
 
-	regs = get_user_regs(child);
+	regs = task_pt_regs(child);
 	pc = instruction_pointer(regs);
 
 	if (thumb_mode(regs)) {
@@ -572,7 +555,7 @@ static int ptrace_write_user(struct task
  */
 static int ptrace_getregs(struct task_struct *tsk, void __user *uregs)
 {
-	struct pt_regs *regs = get_user_regs(tsk);
+	struct pt_regs *regs = task_pt_regs(tsk);
 
 	return copy_to_user(uregs, regs, sizeof(struct pt_regs)) ? -EFAULT : 0;
 }
@@ -587,7 +570,7 @@ static int ptrace_setregs(struct task_st
 
 	ret = -EFAULT;
 	if (copy_from_user(&newregs, uregs, sizeof(struct pt_regs)) == 0) {
-		struct pt_regs *regs = get_user_regs(tsk);
+		struct pt_regs *regs = task_pt_regs(tsk);
 
 		ret = -EINVAL;
 		if (valid_user_regs(&newregs)) {
diff --git a/include/asm-arm/processor.h b/include/asm-arm/processor.h
index 7d4118e..fb5877e 100644
--- a/include/asm-arm/processor.h
+++ b/include/asm-arm/processor.h
@@ -85,9 +85,11 @@ unsigned long get_wchan(struct task_stru
  */
 extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 
-#define KSTK_REGS(tsk)	(((struct pt_regs *)(THREAD_START_SP + (unsigned long)(tsk)->thread_info)) - 1)
-#define KSTK_EIP(tsk)	KSTK_REGS(tsk)->ARM_pc
-#define KSTK_ESP(tsk)	KSTK_REGS(tsk)->ARM_sp
+#define task_pt_regs(p) \
+	((struct pt_regs *)(THREAD_START_SP + (void *)(p)->thread_info) - 1)
+
+#define KSTK_EIP(tsk)	task_pt_regs(tsk)->ARM_pc
+#define KSTK_ESP(tsk)	task_pt_regs(tsk)->ARM_sp
 
 /*
  * Prefetching support - only ARMv5.
-- 
0.99.9.GIT

