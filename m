Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268163AbUHQIoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268163AbUHQIoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268164AbUHQIoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:44:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42146 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268163AbUHQIoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:44:07 -0400
Date: Tue, 17 Aug 2004 10:45:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Nathan Lynch <nathanl@austin.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: [patch] new-task-fix.patch, 2.6.8.1-mm1
Message-ID: <20040817084510.GA6958@elte.hu>
References: <20040816143710.1cd0bd2c.akpm@osdl.org> <1092722342.3081.68.camel@booger> <1092727147.27274.109.camel@bach>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <1092727147.27274.109.camel@bach>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> Looking through 2.6.8.1-mm1, I see this code which doesn't make sense:

> So, first off, the statements under "if (unlikely(cpu != this_cpu))"
> can be folded into the previous block, since that's under the same
> test.  Secondly, why is sleep_avg being set twice to the same thing,
> and why are we happy to adjust it the first time without holding the
> rq lock for current, but the second time we make sure we are holding
> the rq lock? [...]

agreed, this is a bug - the code has rotten somewhat. The attached patch
fixes it. I've also cleaned up the locking and added this_rq, to make
clear when and how we are hopping from one runqueue to another. (this
cleanup would have made the original bug more obvious as well.)

This comes after sched-nonlinear-timeslicespatch.patch in 2.6.8.1-mm1. 
Tested on x86.

> [...]  recalc_task_prio seems happy to adjust a tasks ->sleep_avg
> without holding any lock at all...

this is not true - we always update ->avg_sleep while holding the lock. 
recalc_task_prio() is stricly called with p's runqueue lock held.

	Ingo

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="new-task-fix.patch"


Rusty noticed that we update the parent ->avg_sleep without holding the
runqueue lock. Also the code needed cleanups.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -1344,7 +1344,7 @@ void fastcall wake_up_new_task(task_t * 
 {
 	unsigned long flags;
 	int this_cpu, cpu;
-	runqueue_t *rq;
+	runqueue_t *rq, *this_rq;
 
 	rq = task_rq_lock(p, &flags);
 	cpu = task_cpu(p);
@@ -1386,8 +1386,15 @@ void fastcall wake_up_new_task(task_t * 
 		} else
 			/* Run child last */
 			__activate_task(p, rq);
+		/*
+		 * We skip the following code due to cpu == this_cpu
+	 	 *
+		 *   task_rq_unlock(rq, &flags);
+		 *   this_rq = task_rq_lock(current, &flags);
+		 */
+		this_rq = rq;
 	} else {
-		runqueue_t *this_rq = cpu_rq(this_cpu);
+		this_rq = cpu_rq(this_cpu);
 
 		/*
 		 * Not the local CPU - must adjust timestamp. This should
@@ -1399,18 +1406,17 @@ void fastcall wake_up_new_task(task_t * 
 		if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
 
-		current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
-			PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
 		schedstat_inc(rq, wunt_moved);
-	}
-
-	if (unlikely(cpu != this_cpu)) {
+		/*
+		 * Parent and child are on different CPUs, now get the
+		 * parent runqueue to update the parent's ->sleep_avg:
+		 */
 		task_rq_unlock(rq, &flags);
-		rq = task_rq_lock(current, &flags);
+		this_rq = task_rq_lock(current, &flags);
 	}
 	current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
 		PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
-	task_rq_unlock(rq, &flags);
+	task_rq_unlock(this_rq, &flags);
 }
 
 /*

--gKMricLos+KVdGMg--
