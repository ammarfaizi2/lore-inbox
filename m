Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270587AbTGNMdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270616AbTGNMcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:32:11 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:40661 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S270596AbTGNMPP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:15:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O5int for interactivity
Date: Mon, 14 Jul 2003 22:32:05 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Daniel Phillips <phillips@arcor.de>, Mike Galbraith <efault@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307142232.05782.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More interactivity work for audio and X smoothness. I have fixed all my test
 cases and need feedback about others to develop beyond this.

Changes
The idle code now gives just under interactive state based on the runtime
 instead of min_sleep_avg - minor startup speed improvement.

Tasks that drop their priority while running are now put to the end of the
 queue to continue their timeslice. Fixes a little flutter when tasks are
cpu hogs for short periods (eg mozilla).

Tasks that are complete cpu hogs are put on the expired array every time they
 run out of timeslice.

Con

Patch against 2.5.75-mm1 available here:
http://kernel.kolivas.org/2.5

and here:

diff -Naurp linux-2.5.75-mm1/kernel/sched.c linux-2.5.75-test/kernel/sched.c
--- linux-2.5.75-mm1/kernel/sched.c	2003-07-13 00:21:30.000000000 +1000
+++ linux-2.5.75-test/kernel/sched.c	2003-07-14 22:13:51.000000000 +1000
@@ -388,19 +388,19 @@ static inline void __activate_task(task_
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
 	long sleep_time = jiffies - p->last_run - 1;
+	long runtime = jiffies - p->avg_start;
 
 	if (sleep_time > 0) {
-		unsigned long runtime = jiffies - p->avg_start;
-
 		/*
 		 * Tasks that sleep a long time are categorised as idle and
-		 * will get just under interactive status with a small runtime
-		 * to allow them to become interactive or non-interactive rapidly
+		 * will get just under interactive status
 		 */
 		if (sleep_time > MIN_SLEEP_AVG){
-			p->avg_start = jiffies - MIN_SLEEP_AVG;
-			p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 1) /
-				MAX_BONUS;
+			if (runtime > MAX_SLEEP_AVG){
+				runtime = MAX_SLEEP_AVG;
+				p->avg_start = jiffies - runtime;
+			}
+			p->sleep_avg = runtime * (MAX_BONUS - INTERACTIVE_DELTA - 1) / MAX_BONUS;
 		} else {
 			/*
 			 * This code gives a bonus to interactive tasks.
@@ -1278,11 +1278,7 @@ void scheduler_tick(int user_ticks, int
 	spin_lock(&rq->lock);
 	/*
 	 * The task was running during this tick - update the
-	 * time slice counter and the sleep average. Note: we
-	 * do not update a thread's priority until it either
-	 * goes to sleep or uses up its timeslice. This makes
-	 * it possible for interactive tasks to use up their
-	 * timeslices at their highest priority levels.
+	 * time slice counter and the sleep average.
 	 */
 	if (p->sleep_avg)
 		p->sleep_avg--;
@@ -1309,12 +1305,21 @@ void scheduler_tick(int user_ticks, int 
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq) || !p->sleep_avg) {
 			if (!rq->expired_timestamp)
 				rq->expired_timestamp = jiffies;
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
+	} else if (unlikely(p->prio < effective_prio(p))){
+		/*
+		 * Tasks that have lowered their priority are put to the end
+		 * of the active array with their remaining timeslice
+		 */
+		dequeue_task(p, rq->active);
+		set_tsk_need_resched(p);
+		p->prio = effective_prio(p);
+		enqueue_task(p, rq->active);
 	}
 out_unlock:
 	spin_unlock(&rq->lock);

