Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUAHRan (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265686AbUAHRan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:30:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:30611 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265682AbUAHRa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:30:26 -0500
Date: Thu, 8 Jan 2004 18:31:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] fix runqueue corruption, 2.6.1-rc3-A0
Message-ID: <20040108173111.GA28875@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


the attached patch fixes a nasty, few-instructions race that can result
in a corrupted runqueue at thread/process-creation time. The bug is this
code in do_fork():

                p->state = TASK_STOPPED;
                if (!(clone_flags & CLONE_STOPPED))
                        wake_up_forked_process(p);      /* do this last */

when we do copy_process(), the task ends up on the tasklist and is
pid-hashed, and is thus accessible as a signal-wakeup target. But it's
in TASK_UNINTERRUPTIBLE state so wakeups cannot happen. But:

    void wake_up_forked_process(task_t * p)
    {
            unsigned long flags;
            runqueue_t *rq = task_rq_lock(current, &flags);

            BUG_ON(p->state != TASK_UNINTERRUPTIBLE);
            p->state = TASK_RUNNING;

so the task can be woken up from the place we do the TASK_STOPPED
change, to the task_rq_lock(). This window is very small, but not
impossible to trigger. The window is more likely to trigger on
hyperthreading systems and when CONFIG_PREEMPT is enabled. (in fact we
have a number of bugreports that i suspect are related to this race.) 
The bug was introduced 6 months ago.

The effect of the bug was quite hard to debug: it results in a corrupted
runqueue due to the double list_add() - this causes lockups next time
this area of the runqueue is used, far away from the buggy code itself.

the fix is to set it to TASK_STOPPED only if we dont call
wake_up_forked_process(). (Also, to avoid this bug in the future i've
added an assert to catch illegal uses of wake_up_forked_process().)

please apply.

	Ingo

--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -1209,9 +1209,16 @@ long do_fork(unsigned long clone_flags,
 			set_tsk_thread_flag(p, TIF_SIGPENDING);
 		}
 
-		p->state = TASK_STOPPED;
+		/*
+		 * the task is in TASK_UNINTERRUPTIBLE right now, no-one
+		 * can wake it up. Either wake it up as a child, which
+		 * makes it TASK_RUNNING - or make it TASK_STOPPED, after
+		 * which signals can wake the child up.
+		 */
 		if (!(clone_flags & CLONE_STOPPED))
 			wake_up_forked_process(p);	/* do this last */
+		else
+			set_task_state(p, TASK_STOPPED);
 		++total_forks;
 
 		if (unlikely (trace)) {
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -684,6 +684,7 @@ void wake_up_forked_process(task_t * p)
 	unsigned long flags;
 	runqueue_t *rq = task_rq_lock(current, &flags);
 
+	BUG_ON(p->state != TASK_UNINTERRUPTIBLE);
 	p->state = TASK_RUNNING;
 	/*
 	 * We decrease the sleep average of forking parents
@@ -2832,6 +2833,7 @@ void __init sched_init(void)
 	rq = this_rq();
 	rq->curr = current;
 	rq->idle = current;
+	current->state = TASK_UNINTERRUPTIBLE;
 	set_task_cpu(current, smp_processor_id());
 	wake_up_forked_process(current);
 
