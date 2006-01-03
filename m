Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWACVMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWACVMf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWACVHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39567 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932553AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 31/50] arm: task_thread_info()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Qz-TC@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/arm/kernel/process.c     |    4 ++--
 arch/arm/kernel/ptrace.c      |   10 +++++-----
 include/asm-arm/system.h      |    2 +-
 include/asm-arm/thread_info.h |    4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

c7ac2c8f297bf79b4e036bd41a7d3152065c6d28
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 30494aa..ca0febd 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -343,10 +343,10 @@ void flush_thread(void)
 void release_thread(struct task_struct *dead_task)
 {
 #if defined(CONFIG_VFP)
-	vfp_release_thread(&dead_task->thread_info->vfpstate);
+	vfp_release_thread(&task_thread_info(dead_task)->vfpstate);
 #endif
 #if defined(CONFIG_IWMMXT)
-	iwmmxt_task_release(dead_task->thread_info);
+	iwmmxt_task_release(task_thread_info(dead_task));
 #endif
 }
 
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 2b84f78..f003062 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -604,7 +604,7 @@ static int ptrace_setregs(struct task_st
  */
 static int ptrace_getfpregs(struct task_struct *tsk, void __user *ufp)
 {
-	return copy_to_user(ufp, &tsk->thread_info->fpstate,
+	return copy_to_user(ufp, &task_thread_info(tsk)->fpstate,
 			    sizeof(struct user_fp)) ? -EFAULT : 0;
 }
 
@@ -613,7 +613,7 @@ static int ptrace_getfpregs(struct task_
  */
 static int ptrace_setfpregs(struct task_struct *tsk, void __user *ufp)
 {
-	struct thread_info *thread = tsk->thread_info;
+	struct thread_info *thread = task_thread_info(tsk);
 	thread->used_cp[1] = thread->used_cp[2] = 1;
 	return copy_from_user(&thread->fpstate, ufp,
 			      sizeof(struct user_fp)) ? -EFAULT : 0;
@@ -626,7 +626,7 @@ static int ptrace_setfpregs(struct task_
  */
 static int ptrace_getwmmxregs(struct task_struct *tsk, void __user *ufp)
 {
-	struct thread_info *thread = tsk->thread_info;
+	struct thread_info *thread = task_thread_info(tsk);
 	void *ptr = &thread->fpstate;
 
 	if (!test_ti_thread_flag(thread, TIF_USING_IWMMXT))
@@ -643,7 +643,7 @@ static int ptrace_getwmmxregs(struct tas
  */
 static int ptrace_setwmmxregs(struct task_struct *tsk, void __user *ufp)
 {
-	struct thread_info *thread = tsk->thread_info;
+	struct thread_info *thread = task_thread_info(tsk);
 	void *ptr = &thread->fpstate;
 
 	if (!test_ti_thread_flag(thread, TIF_USING_IWMMXT))
@@ -779,7 +779,7 @@ long arch_ptrace(struct task_struct *chi
 #endif
 
 		case PTRACE_GET_THREAD_AREA:
-			ret = put_user(child->thread_info->tp_value,
+			ret = put_user(task_thread_info(child)->tp_value,
 				       (unsigned long __user *) data);
 			break;
 
diff --git a/include/asm-arm/system.h b/include/asm-arm/system.h
index 5621d61..a7da094 100644
--- a/include/asm-arm/system.h
+++ b/include/asm-arm/system.h
@@ -168,7 +168,7 @@ extern struct task_struct *__switch_to(s
 
 #define switch_to(prev,next,last)					\
 do {									\
-	last = __switch_to(prev,prev->thread_info,next->thread_info);	\
+	last = __switch_to(prev,task_thread_info(prev), task_thread_info(next));	\
 } while (0)
 
 /*
diff --git a/include/asm-arm/thread_info.h b/include/asm-arm/thread_info.h
index 7c98557..46a4e98 100644
--- a/include/asm-arm/thread_info.h
+++ b/include/asm-arm/thread_info.h
@@ -100,9 +100,9 @@ extern void free_thread_info(struct thre
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 
 #define thread_saved_pc(tsk)	\
-	((unsigned long)(pc_pointer((tsk)->thread_info->cpu_context.pc)))
+	((unsigned long)(pc_pointer(task_thread_info(tsk)->cpu_context.pc)))
 #define thread_saved_fp(tsk)	\
-	((unsigned long)((tsk)->thread_info->cpu_context.fp))
+	((unsigned long)(task_thread_info(tsk)->cpu_context.fp))
 
 extern void iwmmxt_task_disable(struct thread_info *);
 extern void iwmmxt_task_copy(struct thread_info *, void *);
-- 
0.99.9.GIT

