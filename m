Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbVHYFW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVHYFW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbVHYFW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:22:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8396 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964825AbVHYFWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:22:01 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (17/22) task_thread_info - part 1/4
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8AEc-0005eH-M7@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:25:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

new helper - task_thread_info(task).  On platforms that have thread_info 
allocated separately (i.e. in default case) it simply returns
task->thread_info m68k wants (and for good reasons) to embed its thread_info
into task_struct.  So it will (in later patch) have task_thread_info() of
its own.  For now we just add a macro for generic case and convert existing
instances of its body in core kernel to uses of new macro.  Obviously safe -
all normal architectures get the same preprocessor output they used to get.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-mac-fonts/include/linux/sched.h RC13-rc7-task_thread_info/include/linux/sched.h
--- RC13-rc7-mac-fonts/include/linux/sched.h	2005-08-10 10:37:54.000000000 -0400
+++ RC13-rc7-task_thread_info/include/linux/sched.h	2005-08-25 00:54:17.000000000 -0400
@@ -1136,32 +1136,34 @@
 	spin_unlock(&p->alloc_lock);
 }
 
+#define task_thread_info(task) (task)->thread_info
+
 /* set thread flags in other task's structures
  * - see asm/thread_info.h for TIF_xxxx flags available
  */
 static inline void set_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
-	set_ti_thread_flag(tsk->thread_info,flag);
+	set_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
 static inline void clear_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
-	clear_ti_thread_flag(tsk->thread_info,flag);
+	clear_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
 static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
-	return test_and_set_ti_thread_flag(tsk->thread_info,flag);
+	return test_and_set_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
 static inline int test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
-	return test_and_clear_ti_thread_flag(tsk->thread_info,flag);
+	return test_and_clear_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
 static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
-	return test_ti_thread_flag(tsk->thread_info,flag);
+	return test_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
 static inline void set_tsk_need_resched(struct task_struct *tsk)
@@ -1232,12 +1234,12 @@
 
 static inline unsigned int task_cpu(const struct task_struct *p)
 {
-	return p->thread_info->cpu;
+	return task_thread_info(p)->cpu;
 }
 
 static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
 {
-	p->thread_info->cpu = cpu;
+	task_thread_info(p)->cpu = cpu;
 }
 
 #else
diff -urN RC13-rc7-mac-fonts/kernel/exit.c RC13-rc7-task_thread_info/kernel/exit.c
--- RC13-rc7-mac-fonts/kernel/exit.c	2005-08-10 10:37:54.000000000 -0400
+++ RC13-rc7-task_thread_info/kernel/exit.c	2005-08-25 00:54:17.000000000 -0400
@@ -846,7 +846,7 @@
 	if (group_dead && tsk->signal->leader)
 		disassociate_ctty(1);
 
-	module_put(tsk->thread_info->exec_domain->module);
+	module_put(task_thread_info(tsk)->exec_domain->module);
 	if (tsk->binfmt)
 		module_put(tsk->binfmt->module);
 
diff -urN RC13-rc7-mac-fonts/kernel/fork.c RC13-rc7-task_thread_info/kernel/fork.c
--- RC13-rc7-mac-fonts/kernel/fork.c	2005-08-10 10:37:54.000000000 -0400
+++ RC13-rc7-task_thread_info/kernel/fork.c	2005-08-25 00:54:17.000000000 -0400
@@ -898,7 +898,7 @@
 	if (nr_threads >= max_threads)
 		goto bad_fork_cleanup_count;
 
-	if (!try_module_get(p->thread_info->exec_domain->module))
+	if (!try_module_get(task_thread_info(p)->exec_domain->module))
 		goto bad_fork_cleanup_count;
 
 	if (p->binfmt && !try_module_get(p->binfmt->module))
@@ -1151,7 +1151,7 @@
 	if (p->binfmt)
 		module_put(p->binfmt->module);
 bad_fork_cleanup_put_domain:
-	module_put(p->thread_info->exec_domain->module);
+	module_put(task_thread_info(p)->exec_domain->module);
 bad_fork_cleanup_count:
 	put_group_info(p->group_info);
 	atomic_dec(&p->user->processes);
diff -urN RC13-rc7-mac-fonts/kernel/sched.c RC13-rc7-task_thread_info/kernel/sched.c
--- RC13-rc7-mac-fonts/kernel/sched.c	2005-08-21 13:12:57.000000000 -0400
+++ RC13-rc7-task_thread_info/kernel/sched.c	2005-08-25 00:54:17.000000000 -0400
@@ -1317,7 +1317,7 @@
 #endif
 #ifdef CONFIG_PREEMPT
 	/* Want to start with kernel preemption disabled. */
-	p->thread_info->preempt_count = 1;
+	task_thread_info(p)->preempt_count = 1;
 #endif
 	/*
 	 * Share the timeslice between parent and child, thus the
@@ -4204,9 +4204,9 @@
 
 	/* Set the preempt count _outside_ the spinlocks! */
 #if defined(CONFIG_PREEMPT) && !defined(CONFIG_PREEMPT_BKL)
-	idle->thread_info->preempt_count = (idle->lock_depth >= 0);
+	task_thread_info(idle)->preempt_count = (idle->lock_depth >= 0);
 #else
-	idle->thread_info->preempt_count = 0;
+	task_thread_info(idle)->preempt_count = 0;
 #endif
 }
 
