Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWACVLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWACVLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWACVHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33167 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932563AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 14/50] sh: task_pt_regs()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Pi-Ai@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/sh/kernel/process.c |   42 ++++++------------------------------------
 arch/sh/kernel/ptrace.c  |   14 ++------------
 include/asm-sh/ptrace.h  |   10 ++++++++++
 3 files changed, 18 insertions(+), 48 deletions(-)

dbd2b9937d425d621ab6eba3c3db67638090d0b9
diff --git a/arch/sh/kernel/process.c b/arch/sh/kernel/process.c
index fd4f240..6a86fe3 100644
--- a/arch/sh/kernel/process.c
+++ b/arch/sh/kernel/process.c
@@ -191,13 +191,8 @@ void flush_thread(void)
 {
 #if defined(CONFIG_SH_FPU)
 	struct task_struct *tsk = current;
-	struct pt_regs *regs = (struct pt_regs *)
-				((unsigned long)tsk->thread_info
-				 + THREAD_SIZE - sizeof(struct pt_regs)
-				 - sizeof(unsigned long));
-
 	/* Forget lazy FPU state */
-	clear_fpu(tsk, regs);
+	clear_fpu(tsk, task_pt_regs(tsk));
 	clear_used_math();
 #endif
 }
@@ -232,13 +227,7 @@ int dump_task_regs(struct task_struct *t
 {
 	struct pt_regs ptregs;
 	
-	ptregs = *(struct pt_regs *)
-		((unsigned long)tsk->thread_info + THREAD_SIZE
-		 - sizeof(struct pt_regs)
-#ifdef CONFIG_SH_DSP
-		 - sizeof(struct pt_dspregs)
-#endif
-		 - sizeof(unsigned long));
+	ptregs = *task_pt_regs(tsk);
 	elf_core_copy_regs(regs, &ptregs);
 
 	return 1;
@@ -252,11 +241,7 @@ dump_task_fpu (struct task_struct *tsk, 
 #if defined(CONFIG_SH_FPU)
 	fpvalid = !!tsk_used_math(tsk);
 	if (fpvalid) {
-		struct pt_regs *regs = (struct pt_regs *)
-					((unsigned long)tsk->thread_info
-					 + THREAD_SIZE - sizeof(struct pt_regs)
-					 - sizeof(unsigned long));
-		unlazy_fpu(tsk, regs);
+		unlazy_fpu(tsk, task_pt_regs(tsk));
 		memcpy(fpu, &tsk->thread.fpu.hard, sizeof(*fpu));
 	}
 #endif
@@ -279,12 +264,7 @@ int copy_thread(int nr, unsigned long cl
 	copy_to_stopped_child_used_math(p);
 #endif
 
-	childregs = ((struct pt_regs *)
-		(THREAD_SIZE + (unsigned long) p->thread_info)
-#ifdef CONFIG_SH_DSP
-		- sizeof(struct pt_dspregs)
-#endif
-		- sizeof(unsigned long)) - 1;
+	childregs = task_pt_regs(p);
 	*childregs = *regs;
 
 	if (user_mode(regs)) {
@@ -353,11 +333,7 @@ ubc_set_tracing(int asid, unsigned long 
 struct task_struct *__switch_to(struct task_struct *prev, struct task_struct *next)
 {
 #if defined(CONFIG_SH_FPU)
-	struct pt_regs *regs = (struct pt_regs *)
-				((unsigned long)prev->thread_info
-				 + THREAD_SIZE - sizeof(struct pt_regs)
-				 - sizeof(unsigned long));
-	unlazy_fpu(prev, regs);
+	unlazy_fpu(prev, task_pt_regs(prev));
 #endif
 
 #ifdef CONFIG_PREEMPT
@@ -366,13 +342,7 @@ struct task_struct *__switch_to(struct t
 		struct pt_regs *regs;
 
 		local_irq_save(flags);
-		regs = (struct pt_regs *)
-			((unsigned long)prev->thread_info
-			 + THREAD_SIZE - sizeof(struct pt_regs)
-#ifdef CONFIG_SH_DSP
-			 - sizeof(struct pt_dspregs)
-#endif
-			 - sizeof(unsigned long));
+		regs = task_pt_regs(prev);
 		if (user_mode(regs) && regs->regs[15] >= 0xc0000000) {
 			int offset = (int)regs->regs[15];
 
diff --git a/arch/sh/kernel/ptrace.c b/arch/sh/kernel/ptrace.c
index 1a8be06..3887b4f 100644
--- a/arch/sh/kernel/ptrace.c
+++ b/arch/sh/kernel/ptrace.c
@@ -41,12 +41,7 @@ static inline int get_stack_long(struct 
 {
 	unsigned char *stack;
 
-	stack = (unsigned char *)
-		task->thread_info + THREAD_SIZE	- sizeof(struct pt_regs)
-#ifdef CONFIG_SH_DSP
-		- sizeof(struct pt_dspregs)
-#endif
-		- sizeof(unsigned long);
+	stack = (unsigned char *)task_pt_regs(task);
 	stack += offset;
 	return (*((int *)stack));
 }
@@ -59,12 +54,7 @@ static inline int put_stack_long(struct 
 {
 	unsigned char *stack;
 
-	stack = (unsigned char *)
-		task->thread_info + THREAD_SIZE - sizeof(struct pt_regs)
-#ifdef CONFIG_SH_DSP
-		- sizeof(struct pt_dspregs)
-#endif
-		- sizeof(unsigned long);
+	stack = (unsigned char *)task_pt_regs(task);
 	stack += offset;
 	*(unsigned long *) stack = data;
 	return 0;
diff --git a/include/asm-sh/ptrace.h b/include/asm-sh/ptrace.h
index 0f75e16..85aa0f4 100644
--- a/include/asm-sh/ptrace.h
+++ b/include/asm-sh/ptrace.h
@@ -91,6 +91,16 @@ struct pt_dspregs {
 #define instruction_pointer(regs) ((regs)->pc)
 extern void show_regs(struct pt_regs *);
 
+#ifdef CONFIG_SH_DSP
+#define task_pt_regs(task) \
+	((struct pt_regs *) ((unsigned long)(task)->thread_info + THREAD_SIZE \
+		 - sizeof(struct pt_dspregs) - sizeof(unsigned long)) - 1)
+#else
+#define task_pt_regs(task) \
+	((struct pt_regs *) ((unsigned long)(task)->thread_info + THREAD_SIZE \
+		 - sizeof(unsigned long)) - 1)
+#endif
+
 static inline unsigned long profile_pc(struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
-- 
0.99.9.GIT

