Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWACVN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWACVN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWACVNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:13:25 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42127 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932555AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 36/50] arm26: task_pt_regs()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNb-0008Rc-1K@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/arm26/kernel/process.c     |    3 +--
 arch/arm26/kernel/ptrace.c      |   25 +++++--------------------
 include/asm-arm26/thread_info.h |    2 +-
 3 files changed, 7 insertions(+), 23 deletions(-)

3a29d6c513c9d69686d33c4baa67120116a0ea6b
diff --git a/arch/arm26/kernel/process.c b/arch/arm26/kernel/process.c
index 159f84a..3863056 100644
--- a/arch/arm26/kernel/process.c
+++ b/arch/arm26/kernel/process.c
@@ -278,9 +278,8 @@ copy_thread(int nr, unsigned long clone_
 	    unsigned long unused, struct task_struct *p, struct pt_regs *regs)
 {
 	struct thread_info *thread = task_thread_info(p);
-	struct pt_regs *childregs;
+	struct pt_regs *childregs = task_pt_regs(p);
 
-	childregs = __get_user_regs(thread);
 	*childregs = *regs;
 	childregs->ARM_r0 = 0;
 	childregs->ARM_sp = stack_start;
diff --git a/arch/arm26/kernel/ptrace.c b/arch/arm26/kernel/ptrace.c
index 56afe1f..3c3371d 100644
--- a/arch/arm26/kernel/ptrace.c
+++ b/arch/arm26/kernel/ptrace.c
@@ -40,21 +40,6 @@
 #define BREAKINST_ARM	0xef9f0001
 
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
-	return __get_user_regs(task->thread_info);
-}
-
-/*
  * this routine will get a word off of the processes privileged stack.
  * the offset is how far from the base addr as stored in the THREAD.
  * this routine assumes that all the privileged stacks are in our
@@ -62,7 +47,7 @@ get_user_regs(struct task_struct *task)
  */
 static inline long get_user_reg(struct task_struct *task, int offset)
 {
-	return get_user_regs(task)->uregs[offset];
+	return task_pt_regs(task)->uregs[offset];
 }
 
 /*
@@ -74,7 +59,7 @@ static inline long get_user_reg(struct t
 static inline int
 put_user_reg(struct task_struct *task, int offset, long data)
 {
-	struct pt_regs newregs, *regs = get_user_regs(task);
+	struct pt_regs newregs, *regs = task_pt_regs(task);
 	int ret = -EINVAL;
 
 	newregs = *regs;
@@ -377,7 +362,7 @@ void ptrace_set_bpt(struct task_struct *
 	u32 insn;
 	int res;
 
-	regs = get_user_regs(child);
+	regs = task_pt_regs(child);
 	pc = instruction_pointer(regs);
 
 	res = read_instr(child, pc, &insn);
@@ -500,7 +485,7 @@ static int ptrace_write_user(struct task
  */
 static int ptrace_getregs(struct task_struct *tsk, void *uregs)
 {
-	struct pt_regs *regs = get_user_regs(tsk);
+	struct pt_regs *regs = task_pt_regs(tsk);
 
 	return copy_to_user(uregs, regs, sizeof(struct pt_regs)) ? -EFAULT : 0;
 }
@@ -515,7 +500,7 @@ static int ptrace_setregs(struct task_st
 
 	ret = -EFAULT;
 	if (copy_from_user(&newregs, uregs, sizeof(struct pt_regs)) == 0) {
-		struct pt_regs *regs = get_user_regs(tsk);
+		struct pt_regs *regs = task_pt_regs(tsk);
 
 		ret = -EINVAL;
 		if (valid_user_regs(&newregs)) {
diff --git a/include/asm-arm26/thread_info.h b/include/asm-arm26/thread_info.h
index 909c88d..f332b40 100644
--- a/include/asm-arm26/thread_info.h
+++ b/include/asm-arm26/thread_info.h
@@ -82,7 +82,7 @@ static inline struct thread_info *curren
 
 /* FIXME - PAGE_SIZE < 32K */
 #define THREAD_SIZE		(8*32768) // FIXME - this needs attention (see kernel/fork.c which gets a nice div by zero if this is lower than 8*32768
-#define __get_user_regs(x) (((struct pt_regs *)((unsigned long)(x) + THREAD_SIZE - 8)) - 1)
+#define task_pt_regs(task) ((struct pt_regs *)((unsigned long)(task)->thread_info + THREAD_SIZE - 8) - 1)
 
 extern struct thread_info *alloc_thread_info(struct task_struct *task);
 extern void free_thread_info(struct thread_info *);
-- 
0.99.9.GIT

