Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbTFYPxt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbTFYPxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:53:49 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:51107 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264609AbTFYPxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:53:39 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: patch O1int for 2.5.73 - interactivity work
Date: Thu, 26 Jun 2003 02:09:45 +1000
User-Agent: KMail/1.5.2
Cc: Mike Galbraith <efault@gmx.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Jlc++r0OLA+mdWD"
Message-Id: <200306260209.45020.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Jlc++r0OLA+mdWD
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all 

I've used the corner cases described that cause a lot of the interactivity 
problems to develop this patch. What it does different to default (without 
nasty hacks) is the following:

The interactivity is based on the max sleep avg (10s) as previously, unless 
the thread has been running for less than 10s. In that case it is based on 
the duration it has been running, with a minimum of 10 jiffies to estimate 
the interactivity (perhaps more might be appropriate here). This should 
minimise tasks taking ages to be categorised as interactive.

If tasks sleep for a long time (>1s) they are no longer classified as 
interactive, but idle - meaning they receive their static priority. However, 
since they _may_ become interactive, the period over which the interactivity 
is estimated is decreased (1sec, perhaps can be reduced) so they may become 
interactive rapidly again. This should minimise idle tasks (like BASH) that 
suddenly become cpu hungry from stalling everything.

I'm still working on something for the "xmms stalls if started during very 
heavy load" as a different corner case.

This is only a compile tested patch (need sleep bad) but has been tested in 
2.4 form and works nicely at avoiding those corner test cases.

Please comment and test if you can.

Con

--Boundary-00=_Jlc++r0OLA+mdWD
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O1int-0306260145"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-O1int-0306260145"

diff -Naurp linux-2.5.73/include/linux/sched.h linux-2.5.73-test/include/linux/sched.h
--- linux-2.5.73/include/linux/sched.h	2003-06-26 01:30:42.000000000 +1000
+++ linux-2.5.73-test/include/linux/sched.h	2003-06-26 01:32:34.000000000 +1000
@@ -336,6 +336,7 @@ struct task_struct {
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
+	unsigned long avg_start;
 	unsigned long last_run;
 
 	unsigned long policy;
diff -Naurp linux-2.5.73/kernel/fork.c linux-2.5.73-test/kernel/fork.c
--- linux-2.5.73/kernel/fork.c	2003-06-26 01:30:42.000000000 +1000
+++ linux-2.5.73-test/kernel/fork.c	2003-06-26 01:33:31.000000000 +1000
@@ -863,6 +863,7 @@ struct task_struct *copy_process(unsigne
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
+	p->avg_start = jiffies;
 	p->security = NULL;
 
 	retval = -ENOMEM;
diff -Naurp linux-2.5.73/kernel/sched.c linux-2.5.73-test/kernel/sched.c
--- linux-2.5.73/kernel/sched.c	2003-06-26 01:30:42.000000000 +1000
+++ linux-2.5.73-test/kernel/sched.c	2003-06-26 01:44:49.000000000 +1000
@@ -313,12 +313,19 @@ static inline void enqueue_task(struct t
  */
 static int effective_prio(task_t *p)
 {
-	int bonus, prio;
+	int bonus, prio, sleep_period;
 
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
+	sleep_period = jiffies - p->avg_start;
+
+	if (sleep_period > MAX_SLEEP_AVG)
+		sleep_period = MAX_SLEEP_AVG;
+	else if (sleep_period < 10)
+		return p->static_prio;
+
+	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/sleep_period/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
 	prio = p->static_prio - bonus;
@@ -349,8 +356,12 @@ static inline void activate_task(task_t 
 	long sleep_time = jiffies - p->last_run - 1;
 
 	if (sleep_time > 0) {
-		int sleep_avg;
 
+		if (sleep_time > HZ){
+			p->avg_start = jiffies - HZ;
+			p->sleep_avg = HZ / 2;
+		}
+		else {
 		/*
 		 * This code gives a bonus to interactive tasks.
 		 *
@@ -359,7 +370,7 @@ static inline void activate_task(task_t 
 		 * spends sleeping, the higher the average gets - and the
 		 * higher the priority boost gets as well.
 		 */
-		sleep_avg = p->sleep_avg + sleep_time;
+			p->sleep_avg += sleep_time;
 
 		/*
 		 * 'Overflow' bonus ticks go to the waker as well, so the
@@ -367,12 +378,10 @@ static inline void activate_task(task_t 
 		 * boosting tasks that are related to maximum-interactive
 		 * tasks.
 		 */
-		if (sleep_avg > MAX_SLEEP_AVG)
-			sleep_avg = MAX_SLEEP_AVG;
-		if (p->sleep_avg != sleep_avg) {
-			p->sleep_avg = sleep_avg;
-			p->prio = effective_prio(p);
+			if (p->sleep_avg > MAX_SLEEP_AVG)
+				p->sleep_avg = MAX_SLEEP_AVG;
 		}
+		p->prio = effective_prio(p);
 	}
 	__activate_task(p, rq);
 }
@@ -549,8 +558,6 @@ void wake_up_forked_process(task_t * p)
 	 * and children as well, to keep max-interactive tasks
 	 * from forking tasks that are max-interactive.
 	 */
-	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
-	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());

@@ -586,13 +593,6 @@ void sched_exit(task_t * p)
 			p->parent->time_slice = MAX_TIMESLICE;
 	}
 	local_irq_restore(flags);
-	/*
-	 * If the child was a (relative-) CPU hog then decrease
-	 * the sleep_avg of the parent as well.
-	 */
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = (p->parent->sleep_avg * EXIT_WEIGHT +
-			p->sleep_avg) / (EXIT_WEIGHT + 1);
 }
 
 /**

--Boundary-00=_Jlc++r0OLA+mdWD--

