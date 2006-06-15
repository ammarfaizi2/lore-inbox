Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWFOMLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWFOMLm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWFOMLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:11:42 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:35544 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030289AbWFOMLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:11:41 -0400
Date: Thu, 15 Jun 2006 20:11:43 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>
Cc: Roland McGrath <roland@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] run_posix_cpu_timers: remove a bogus BUG_ON()
Message-ID: <20060615161143.GA21460@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_exit() clears ->it_##clock##_expires, but nothing prevents
another cpu to attach the timer to exiting process after that.
arm_timer() tries to protect against this race, but the check
is racy.

After exit_notify() does 'write_unlock_irq(&tasklist_lock)' and
before do_exit() calls 'schedule() local timer interrupt can find
tsk->exit_state != 0. If that state was EXIT_DEAD (or another cpu
does sys_wait4) interrupted task has ->signal == NULL.

At this moment exiting task has no pending cpu timers, they were
cleanuped in __exit_signal()->posix_cpu_timers_exit{,_group}(),
so we can just return from irq.

John Stultz recently confirmed this bug, see

	http://marc.theaimsgroup.com/?l=linux-kernel&m=115015841413687

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.17-rc6/kernel/exit.c~2_BUG	2006-06-15 17:59:26.000000000 +0400
+++ 2.6.17-rc6/kernel/exit.c	2006-06-15 18:46:00.000000000 +0400
@@ -881,14 +881,6 @@ fastcall NORET_TYPE void do_exit(long co
 
 	tsk->flags |= PF_EXITING;
 
-	/*
-	 * Make sure we don't try to process any timer firings
-	 * while we are already exiting.
-	 */
- 	tsk->it_virt_expires = cputime_zero;
- 	tsk->it_prof_expires = cputime_zero;
-	tsk->it_sched_expires = 0;
-
 	if (unlikely(in_atomic()))
 		printk(KERN_INFO "note: %s[%d] exited with preempt_count %d\n",
 				current->comm, current->pid,
--- 2.6.17-rc6/kernel/posix-cpu-timers.c~2_BUG	2006-06-15 18:01:57.000000000 +0400
+++ 2.6.17-rc6/kernel/posix-cpu-timers.c	2006-06-15 18:46:00.000000000 +0400
@@ -1288,30 +1288,30 @@ void run_posix_cpu_timers(struct task_st
 
 #undef	UNEXPIRED
 
-	BUG_ON(tsk->exit_state);
-
 	/*
 	 * Double-check with locks held.
 	 */
 	read_lock(&tasklist_lock);
-	spin_lock(&tsk->sighand->siglock);
+	if (likely(tsk->signal != NULL)) {
+		spin_lock(&tsk->sighand->siglock);
 
-	/*
-	 * Here we take off tsk->cpu_timers[N] and tsk->signal->cpu_timers[N]
-	 * all the timers that are firing, and put them on the firing list.
-	 */
-	check_thread_timers(tsk, &firing);
-	check_process_timers(tsk, &firing);
+		/*
+		 * Here we take off tsk->cpu_timers[N] and tsk->signal->cpu_timers[N]
+		 * all the timers that are firing, and put them on the firing list.
+		 */
+		check_thread_timers(tsk, &firing);
+		check_process_timers(tsk, &firing);
 
-	/*
-	 * We must release these locks before taking any timer's lock.
-	 * There is a potential race with timer deletion here, as the
-	 * siglock now protects our private firing list.  We have set
-	 * the firing flag in each timer, so that a deletion attempt
-	 * that gets the timer lock before we do will give it up and
-	 * spin until we've taken care of that timer below.
-	 */
-	spin_unlock(&tsk->sighand->siglock);
+		/*
+		 * We must release these locks before taking any timer's lock.
+		 * There is a potential race with timer deletion here, as the
+		 * siglock now protects our private firing list.  We have set
+		 * the firing flag in each timer, so that a deletion attempt
+		 * that gets the timer lock before we do will give it up and
+		 * spin until we've taken care of that timer below.
+		 */
+		spin_unlock(&tsk->sighand->siglock);
+	}
 	read_unlock(&tasklist_lock);
 
 	/*

