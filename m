Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTLTT4b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 14:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTLTT4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 14:56:31 -0500
Received: from mx1.elte.hu ([157.181.1.137]:20951 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261270AbTLTT4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 14:56:23 -0500
Date: Sat, 20 Dec 2003 20:55:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] 2.6.0 sched fork cleanup
Message-ID: <20031220195542.GA32320@elte.hu>
References: <3FE46885.2030905@cyberone.com.au> <3FE468BF.9000102@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <3FE468BF.9000102@cyberone.com.au>
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


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Nick Piggin <piggin@cyberone.com.au> wrote:

> Move some fork related scheduler policy from fork.c to sched.c where
> it belongs.

this only makes sense if all the other fork-time initializations are
done in sched.c too - these are scattered all around copy_process(). 
The attached patch (it compiles & boots) does this. All the lowlevel
scheduler logic (that was done in fork.c) is now in sched.c - fork.c
only sees the higher level primitives. I've also updated a couple of
comments that relate to the affected code.

	Ingo

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sched-cleanup-2.6.0-A1"

--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -580,6 +580,7 @@ extern int FASTCALL(wake_up_process(stru
  static inline void kick_process(struct task_struct *tsk) { }
 #endif
 extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
+extern void FASTCALL(sched_fork(task_t * p));
 extern void FASTCALL(sched_exit(task_t * p));
 
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);
--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -876,15 +876,7 @@ struct task_struct *copy_process(unsigne
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
-	p->state = TASK_UNINTERRUPTIBLE;
 
 	copy_flags(clone_flags, p);
 	if (clone_flags & CLONE_IDLETASK)
@@ -901,15 +893,12 @@ struct task_struct *copy_process(unsigne
 
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
@@ -924,7 +913,6 @@ struct task_struct *copy_process(unsigne
 	p->tty_old_pgrp = 0;
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
-	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
@@ -973,38 +961,12 @@ struct task_struct *copy_process(unsigne
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
@@ -674,6 +674,54 @@ int wake_up_state(task_t *p, unsigned in
 }
 
 /*
+ * Perform scheduler related setup for a newly forked process p.
+ * p is forked by current.
+ */
+void sched_fork(task_t *p)
+{
+	p->state = TASK_UNINTERRUPTIBLE;
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
+        p->time_slice = (current->time_slice + 1) >> 1;
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
  * wake_up_forked_process - wake up a freshly forked process.
  *
  * This function will do some initial scheduler statistics housekeeping

--rwEMma7ioTxnRzrJ--
