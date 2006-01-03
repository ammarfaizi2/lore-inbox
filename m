Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWACVTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWACVTW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWACVRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:17:40 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:44687 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932574AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 35/50] arm26: task_thread_info()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNb-0008Ra-0r@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/arm26/kernel/process.c     |    2 +-
 arch/arm26/kernel/ptrace.c      |    4 ++--
 include/asm-arm26/system.h      |    2 +-
 include/asm-arm26/thread_info.h |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

2063057940198f124b138337a48a6a0b87406eb6
diff --git a/arch/arm26/kernel/process.c b/arch/arm26/kernel/process.c
index 15833a0..159f84a 100644
--- a/arch/arm26/kernel/process.c
+++ b/arch/arm26/kernel/process.c
@@ -277,7 +277,7 @@ int
 copy_thread(int nr, unsigned long clone_flags, unsigned long stack_start,
 	    unsigned long unused, struct task_struct *p, struct pt_regs *regs)
 {
-	struct thread_info *thread = p->thread_info;
+	struct thread_info *thread = task_thread_info(p);
 	struct pt_regs *childregs;
 
 	childregs = __get_user_regs(thread);
diff --git a/arch/arm26/kernel/ptrace.c b/arch/arm26/kernel/ptrace.c
index 4e6b735..56afe1f 100644
--- a/arch/arm26/kernel/ptrace.c
+++ b/arch/arm26/kernel/ptrace.c
@@ -532,7 +532,7 @@ static int ptrace_setregs(struct task_st
  */
 static int ptrace_getfpregs(struct task_struct *tsk, void *ufp)
 {
-	return copy_to_user(ufp, &tsk->thread_info->fpstate,
+	return copy_to_user(ufp, &task_thread_info(tsk)->fpstate,
 			    sizeof(struct user_fp)) ? -EFAULT : 0;
 }
 
@@ -542,7 +542,7 @@ static int ptrace_getfpregs(struct task_
 static int ptrace_setfpregs(struct task_struct *tsk, void *ufp)
 {
 	set_stopped_child_used_math(tsk);
-	return copy_from_user(&tsk->thread_info->fpstate, ufp,
+	return copy_from_user(&task_threas_info(tsk)->fpstate, ufp,
 			      sizeof(struct user_fp)) ? -EFAULT : 0;
 }
 
diff --git a/include/asm-arm26/system.h b/include/asm-arm26/system.h
index f23fac1..ada34eb 100644
--- a/include/asm-arm26/system.h
+++ b/include/asm-arm26/system.h
@@ -111,7 +111,7 @@ extern struct task_struct *__switch_to(s
 
 #define switch_to(prev,next,last)					\
 do {									\
-	last = __switch_to(prev,prev->thread_info,next->thread_info);	\
+	last = __switch_to(prev,task_thread_info(prev),task_thread_info(next));	\
 } while (0)
 
 /*
diff --git a/include/asm-arm26/thread_info.h b/include/asm-arm26/thread_info.h
index aff3e56..909c88d 100644
--- a/include/asm-arm26/thread_info.h
+++ b/include/asm-arm26/thread_info.h
@@ -91,9 +91,9 @@ extern void free_thread_info(struct thre
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 
 #define thread_saved_pc(tsk)	\
-	((unsigned long)(pc_pointer((tsk)->thread_info->cpu_context.pc)))
+	((unsigned long)(pc_pointer(task_thread_info(tsk)->cpu_context.pc)))
 #define thread_saved_fp(tsk)	\
-	((unsigned long)((tsk)->thread_info->cpu_context.fp))
+	((unsigned long)(task_thread_info(tsk)->cpu_context.fp))
 
 #else /* !__ASSEMBLY__ */
 
-- 
0.99.9.GIT

