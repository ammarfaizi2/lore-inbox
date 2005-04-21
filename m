Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVDURjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVDURjt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVDURjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:39:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24556 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261569AbVDURjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:39:01 -0400
Date: Thu, 21 Apr 2005 18:39:08 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jan Dittmer <jdittmer@ppp0.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050421173908.GZ13052@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <42676B76.4010903@ppp0.net> <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be> <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	thread_info, part 1:

new helper - task_thread_info(task).  On platforms that have thread_info
allocated separately (i.e. in default case) it simply returns task->thread_info.
m68k wants (and for good reasons) to embed its thread_info into task_struct.
So it will (in later patch) have task_thread_info() of its own.

For now we just add a macro for generic case and convert existing users in
core kernel to its user.  Obviously safe - all normal architectures get
the same preprocessor output they used to get.

diff -urN RC12-rc3-delta23/include/linux/sched.h RC12-rc3-task_thread_info/include/linux/sched.h
--- RC12-rc3-delta23/include/linux/sched.h	Wed Apr 20 21:25:54 2005
+++ RC12-rc3-task_thread_info/include/linux/sched.h	Wed Apr 20 22:51:13 2005
@@ -1102,32 +1102,34 @@
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
@@ -1198,12 +1200,12 @@
 
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
diff -urN RC12-rc3-delta23/kernel/exit.c RC12-rc3-task_thread_info/kernel/exit.c
--- RC12-rc3-delta23/kernel/exit.c	Wed Apr 20 21:25:54 2005
+++ RC12-rc3-task_thread_info/kernel/exit.c	Wed Apr 20 22:51:13 2005
@@ -827,7 +827,7 @@
 	if (group_dead && tsk->signal->leader)
 		disassociate_ctty(1);
 
-	module_put(tsk->thread_info->exec_domain->module);
+	module_put(task_thread_info(tsk)->exec_domain->module);
 	if (tsk->binfmt)
 		module_put(tsk->binfmt->module);
 
diff -urN RC12-rc3-delta23/kernel/fork.c RC12-rc3-task_thread_info/kernel/fork.c
--- RC12-rc3-delta23/kernel/fork.c	Wed Apr 20 21:25:54 2005
+++ RC12-rc3-task_thread_info/kernel/fork.c	Wed Apr 20 22:51:13 2005
@@ -893,7 +893,7 @@
 	if (nr_threads >= max_threads)
 		goto bad_fork_cleanup_count;
 
-	if (!try_module_get(p->thread_info->exec_domain->module))
+	if (!try_module_get(task_thread_info(p)->exec_domain->module))
 		goto bad_fork_cleanup_count;
 
 	if (p->binfmt && !try_module_get(p->binfmt->module))
@@ -1138,7 +1138,7 @@
 	if (p->binfmt)
 		module_put(p->binfmt->module);
 bad_fork_cleanup_put_domain:
-	module_put(p->thread_info->exec_domain->module);
+	module_put(task_thread_info(p)->exec_domain->module);
 bad_fork_cleanup_count:
 	put_group_info(p->group_info);
 	atomic_dec(&p->user->processes);
diff -urN RC12-rc3-delta23/kernel/sched.c RC12-rc3-task_thread_info/kernel/sched.c
--- RC12-rc3-delta23/kernel/sched.c	Wed Apr 20 21:25:55 2005
+++ RC12-rc3-task_thread_info/kernel/sched.c	Wed Apr 20 22:51:13 2005
@@ -1151,7 +1151,7 @@
 	 * but it also can be p->switch_lock.) So we compensate with a count
 	 * of 1. Also, we want to start with kernel preemption disabled.
 	 */
-	p->thread_info->preempt_count = 1;
+	task_thread_info(p)->preempt_count = 1;
 #endif
 	/*
 	 * Share the timeslice between parent and child, thus the
@@ -4018,9 +4018,9 @@
 
 	/* Set the preempt count _outside_ the spinlocks! */
 #if defined(CONFIG_PREEMPT) && !defined(CONFIG_PREEMPT_BKL)
-	idle->thread_info->preempt_count = (idle->lock_depth >= 0);
+	task_thread_info(idle)->preempt_count = (idle->lock_depth >= 0);
 #else
-	idle->thread_info->preempt_count = 0;
+	task_thread_info(idle)->preempt_count = 0;
 #endif
 }
 
