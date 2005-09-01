Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbVIAV6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbVIAV6r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbVIAV6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:58:47 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57735 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030425AbVIAV6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:58:46 -0400
Date: Thu, 1 Sep 2005 23:58:42 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 1/10] m68k: introduce task_thread_info()
Message-ID: <Pine.LNX.4.61.0509012357300.9700@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

new helper - task_thread_info(task).  On platforms that have thread_info
allocated separately (i.e. in default case) it simply returns
task->thread_info. m68k wants (and for good reasons) to embed its
thread_info into task_struct.  So it will (in later patch) have
task_thread_info() of its own.  For now we just add a macro for generic
case and convert existing instances of its body in core kernel to uses
of new macro.  Obviously safe - all normal architectures get the same
preprocessor output they used to get.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/sched.h |   16 +++++++++-------
 kernel/exit.c         |    2 +-
 kernel/fork.c         |    4 ++--
 kernel/sched.c        |    6 +++---
 4 files changed, 15 insertions(+), 13 deletions(-)

Index: linux-2.6-mm/include/linux/sched.h
===================================================================
--- linux-2.6-mm.orig/include/linux/sched.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/linux/sched.h	2005-09-01 21:04:03.762273052 +0200
@@ -1209,32 +1209,34 @@ static inline void task_unlock(struct ta
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
@@ -1305,12 +1307,12 @@ extern void signal_wake_up(struct task_s
 
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
Index: linux-2.6-mm/kernel/exit.c
===================================================================
--- linux-2.6-mm.orig/kernel/exit.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/kernel/exit.c	2005-09-01 21:04:03.808265149 +0200
@@ -855,7 +855,7 @@ fastcall NORET_TYPE void do_exit(long co
 	if (group_dead && tsk->signal->leader)
 		disassociate_ctty(1);
 
-	module_put(tsk->thread_info->exec_domain->module);
+	module_put(task_thread_info(tsk)->exec_domain->module);
 	if (tsk->binfmt)
 		module_put(tsk->binfmt->module);
 
Index: linux-2.6-mm/kernel/fork.c
===================================================================
--- linux-2.6-mm.orig/kernel/fork.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/kernel/fork.c	2005-09-01 21:04:03.861256043 +0200
@@ -927,7 +927,7 @@ static task_t *copy_process(unsigned lon
 	if (nr_threads >= max_threads)
 		goto bad_fork_cleanup_count;
 
-	if (!try_module_get(p->thread_info->exec_domain->module))
+	if (!try_module_get(task_thread_info(p)->exec_domain->module))
 		goto bad_fork_cleanup_count;
 
 	if (p->binfmt && !try_module_get(p->binfmt->module))
@@ -1183,7 +1183,7 @@ bad_fork_cleanup:
 	if (p->binfmt)
 		module_put(p->binfmt->module);
 bad_fork_cleanup_put_domain:
-	module_put(p->thread_info->exec_domain->module);
+	module_put(task_thread_info(p)->exec_domain->module);
 bad_fork_cleanup_count:
 	put_group_info(p->group_info);
 	atomic_dec(&p->user->processes);
Index: linux-2.6-mm/kernel/sched.c
===================================================================
--- linux-2.6-mm.orig/kernel/sched.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/kernel/sched.c	2005-09-01 21:04:03.896250029 +0200
@@ -1434,7 +1434,7 @@ void fastcall sched_fork(task_t *p, int 
 #endif
 #ifdef CONFIG_PREEMPT
 	/* Want to start with kernel preemption disabled. */
-	p->thread_info->preempt_count = 1;
+	task_thread_info(p)->preempt_count = 1;
 #endif
 	/*
 	 * Share the timeslice between parent and child, thus the
@@ -4414,9 +4414,9 @@ void __devinit init_idle(task_t *idle, i
 
 	/* Set the preempt count _outside_ the spinlocks! */
 #if defined(CONFIG_PREEMPT) && !defined(CONFIG_PREEMPT_BKL)
-	idle->thread_info->preempt_count = (idle->lock_depth >= 0);
+	task_thread_info(idle)->preempt_count = (idle->lock_depth >= 0);
 #else
-	idle->thread_info->preempt_count = 0;
+	task_thread_info(idle)->preempt_count = 0;
 #endif
 }
 
