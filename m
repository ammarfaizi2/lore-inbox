Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTLTVd3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 16:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTLTVd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 16:33:29 -0500
Received: from mx1.elte.hu ([157.181.1.137]:9858 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261506AbTLTVd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 16:33:26 -0500
Date: Sat, 20 Dec 2003 22:32:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] 2.6.0 fix preempt ctx switch accounting
Message-ID: <20031220213241.GA2753@elte.hu>
References: <3FE46885.2030905@cyberone.com.au> <20031220192238.GA30970@elte.hu> <Pine.LNX.4.58.0312201140320.29271@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312201140320.29271@home.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> That patch still gets several cases wrong: we don't update any
> counters at all for the case where we were TASK_INTERRUPTIBLE and we
> got made TASK_RUNNING because of having a signal pending.
> 
> Also, we shouldn't update the context switch counter just because we
> entered the scheduler. If we don't actually end up switching to
> anything else, it shouldn't count as a context switch.
> 
> So how about something like this?
> 
> Totally untested. Comments?

looks good. The indirect pointer nicely gets rid of complexity. I've
done some additional cleanups: fixed a compilation warning on UP and
cleaned up the goto pick_next_task code. Moved the 'unlikely' to the
test as a whole. I've test-booted this patch and the context-switch
stats look OK. Updated patch attached.

	Ingo

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -1477,6 +1477,7 @@ void scheduling_functions_start_here(voi
  */
 asmlinkage void schedule(void)
 {
+	long *switch_count;
 	task_t *prev, *next;
 	runqueue_t *rq;
 	prio_array_t *array;
@@ -1523,32 +1524,25 @@ need_resched:
 	 * if entering off of a kernel preemption go straight
 	 * to picking the next task.
 	 */
-	if (unlikely(preempt_count() & PREEMPT_ACTIVE))
-		goto pick_next_task;
-
-	switch (prev->state) {
-	case TASK_INTERRUPTIBLE:
-		if (unlikely(signal_pending(prev))) {
+	switch_count = &prev->nivcsw;
+	if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
+		switch_count = &prev->nvcsw;
+		if (unlikely((prev->state & TASK_INTERRUPTIBLE) &&
+				unlikely(signal_pending(prev))))
 			prev->state = TASK_RUNNING;
-			break;
-		}
-	default:
-		deactivate_task(prev, rq);
-		prev->nvcsw++;
-		break;
-	case TASK_RUNNING:
-		prev->nivcsw++;
+		else
+			deactivate_task(prev, rq);
 	}
-pick_next_task:
+
 	if (unlikely(!rq->nr_running)) {
 #ifdef CONFIG_SMP
 		load_balance(rq, 1, cpu_to_node_mask(smp_processor_id()));
-		if (rq->nr_running)
-			goto pick_next_task;
 #endif
-		next = rq->idle;
-		rq->expired_timestamp = 0;
-		goto switch_tasks;
+		if (!rq->nr_running) {
+			next = rq->idle;
+			rq->expired_timestamp = 0;
+			goto switch_tasks;
+		}
 	}
 
 	array = rq->active;
@@ -1596,6 +1590,7 @@ switch_tasks:
 		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
+		++*switch_count;
 
 		prepare_arch_switch(rq, next);
 		prev = context_switch(rq, prev, next);
