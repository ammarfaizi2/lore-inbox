Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265915AbUAHTcW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUAHTcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:32:21 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4264 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265915AbUAHTaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:30:24 -0500
Date: Thu, 8 Jan 2004 20:31:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix runqueue corruption, 2.6.1-rc3-A0
Message-ID: <20040108193105.GA32647@elte.hu>
References: <20040108173111.GA28875@elte.hu> <Pine.LNX.4.58.0401081045570.2158@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401081045570.2158@home.osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Linus Torvalds <torvalds@osdl.org> wrote:

> The bug is more than that - we don't do the proper accountign setup
> for the CLONE_STOPPED case. Look at all the interactive bias stuff
> that doesn't get run at all..

yep, agreed, this is another bug. It is fixed by an existing scheduler
patch (queued for 2.6.2, sched-cleanup-2.6.0-A2) but we might want to do
it in 2.6.1. I've attached the patch, merged relative to 2.6.1-rc3 +
your version of the threading fix. The changelog:

- separate out the scheduler-state initializations from the fork path
  and push them into sched.c.

- this also fixes a bug: CLONE_STOPPED tasks were not fully set up.

> or, preferably to get rid of the TASK_UNINTERRUPTIBLE special case
> altogether, and just say "this function has to be called for something
> that is already marked as being running".

yep, agreed, your patch is cleaner. (i've test-booted it on SMP, it
works fine. I've also test-booted the sched-cleanup patch.)

	Ingo

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sched-cleanup-2.6.1-rc3-A1"


- separate out the scheduler-state initializations from the fork path
  and push them into sched.c.

- this also fixes a bug: CLONE_STOPPED tasks were not full set up.

--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -579,6 +579,7 @@ extern int FASTCALL(wake_up_process(stru
  static inline void kick_process(struct task_struct *tsk) { }
 #endif
 extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
+extern void FASTCALL(sched_fork(task_t * p));
 extern void FASTCALL(sched_exit(task_t * p));
 
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);
--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -910,15 +910,7 @@ struct task_struct *copy_process(unsigne
 	if (p->binfmt && !try_module_get(p->binfmt->module))
 		goto bad_fork_cleanup_put_domain;
 
-#ifdef CONFIG_PREEMPT
-	/*
-	 * schedule_tail drops this_rq()->lock so we compensate with a count
-	 * of 1.  Also, we want to start with kernel preemption disabled.
-	 */
-	p->thread_info->preempt_count = 1;
-#endif
 	p->did_exec = 0;
-	p->state = TASK_RUNNING;
 
 	copy_flags(clone_flags, p);
 	if (clone_flags & CLONE_IDLETASK)
@@ -935,15 +927,12 @@ struct task_struct *copy_process(unsigne
 
 	p->proc_dentry = NULL;
 
-	INIT_LIST_HEAD(&p->run_list);
-
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
 	INIT_LIST_HEAD(&p->posix_timers);
 	init_waitqueue_head(&p->wait_chldexit);
 	p->vfork_done = NULL;
 	spin_lock_init(&p->alloc_lock);
-	spin_lock_init(&p->switch_lock);
 	spin_lock_init(&p->proc_lock);
 
 	clear_tsk_thread_flag(p, TIF_SIGPENDING);
@@ -958,7 +947,6 @@ struct task_struct *copy_process(unsigne
 	p->tty_old_pgrp = 0;
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
-	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
@@ -1007,38 +995,12 @@ struct task_struct *copy_process(unsigne
 	p->exit_signal = (clone_flags & CLONE_THREAD) ? -1 : (clone_flags & CSIGNAL);
 	p->pdeath_signal = 0;
 
+	/* Perform scheduler related setup */
+	sched_fork(p);
+
 	/*
-	 * Share the timeslice between parent and child, thus the
-	 * total amount of pending timeslices in the system doesn't change,
-	 * resulting in more scheduling fairness.
-	 */
-	local_irq_disable();
-        p->time_slice = (current->time_slice + 1) >> 1;
-	/*
-	 * The remainder of the first timeslice might be recovered by
-	 * the parent if the child exits early enough.
-	 */
-	p->first_time_slice = 1;
-	current->time_slice >>= 1;
-	p->timestamp = sched_clock();
-	if (!current->time_slice) {
-		/*
-	 	 * This case is rare, it happens when the parent has only
-	 	 * a single jiffy left from its timeslice. Taking the
-		 * runqueue lock is not a problem.
-		 */
-		current->time_slice = 1;
-		preempt_disable();
-		scheduler_tick(0, 0);
-		local_irq_enable();
-		preempt_enable();
-	} else
-		local_irq_enable();
-	/*
-	 * Ok, add it to the run-queues and make it
-	 * visible to the rest of the system.
-	 *
-	 * Let it rip!
+	 * Ok, make it visible to the rest of the system.
+	 * We dont wake it up yet.
 	 */
 	p->tgid = p->pid;
 	p->group_leader = p;
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -674,17 +674,32 @@ int wake_up_state(task_t *p, unsigned in
 }
 
 /*
- * wake_up_forked_process - wake up a freshly forked process.
- *
- * This function will do some initial scheduler statistics housekeeping
- * that must be done for every newly created process.
+ * Perform scheduler related setup for a newly forked process p.
+ * p is forked by current.
  */
-void wake_up_forked_process(task_t * p)
+void sched_fork(task_t *p)
 {
-	unsigned long flags;
-	runqueue_t *rq = task_rq_lock(current, &flags);
+	p->state = TASK_RUNNING;
+	INIT_LIST_HEAD(&p->run_list);
+	p->array = NULL;
+	spin_lock_init(&p->switch_lock);
+#ifdef CONFIG_PREEMPT
+	/*
+	 * During context-switch we hold precisely one spinlock, which
+	 * schedule_tail drops. (in the common case it's this_rq()->lock,
+	 * but it also can be p->switch_lock.) So we compensate with a count
+	 * of 1. Also, we want to start with kernel preemption disabled.
+	 */
+	p->thread_info->preempt_count = 1;
+#endif
+	/*
+	 * Share the timeslice between parent and child, thus the
+	 * total amount of pending timeslices in the system doesn't change,
+	 * resulting in more scheduling fairness.
+	 */
+	local_irq_disable();
 
-	BUG_ON(p->state != TASK_RUNNING);
+        p->time_slice = (current->time_slice + 1) >> 1;
 
 	/*
 	 * We decrease the sleep average of forking parents
@@ -699,12 +714,47 @@ void wake_up_forked_process(task_t * p)
 
 	p->interactive_credit = 0;
 
-	p->prio = effective_prio(p);
+	/*
+	 * The remainder of the first timeslice might be recovered by
+	 * the parent if the child exits early enough.
+	 */
+	p->first_time_slice = 1;
+	current->time_slice >>= 1;
+	p->timestamp = sched_clock();
+	if (!current->time_slice) {
+		/*
+	 	 * This case is rare, it happens when the parent has only
+	 	 * a single jiffy left from its timeslice. Taking the
+		 * runqueue lock is not a problem.
+		 */
+		current->time_slice = 1;
+		preempt_disable();
+		scheduler_tick(0, 0);
+		local_irq_enable();
+		preempt_enable();
+	} else
+		local_irq_enable();
+}
+
+/*
+ * wake_up_forked_process - wake up a freshly forked process.
+ *
+ * (This function implements child-runs-first logic, that's why
+ * do_fork() cannot just use wake_up_process().)
+ */
+void wake_up_forked_process(task_t * p)
+{
+	unsigned long flags;
+	runqueue_t *rq = task_rq_lock(current, &flags);
+
+	BUG_ON(p->state != TASK_RUNNING);
+
 	set_task_cpu(p, smp_processor_id());
 
-	if (unlikely(!current->array))
+	if (unlikely(!current->array)) {
+		p->prio = effective_prio(p);
 		__activate_task(p, rq);
-	else {
+	} else {
 		p->prio = current->prio;
 		list_add_tail(&p->run_list, &current->run_list);
 		p->array = current->array;

--/04w6evG8XlLl3ft--
