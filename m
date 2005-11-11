Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVKKC7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVKKC7O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 21:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVKKC7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 21:59:14 -0500
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:60107 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932291AbVKKC7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 21:59:13 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: [PATCH] Staircase v13 for plugsched 6.1.3
Date: Fri, 11 Nov 2005 14:00:23 +1100
User-Agent: KMail/1.8.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
References: <434F01EA.6060709@bigpond.net.au>
In-Reply-To: <434F01EA.6060709@bigpond.net.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HlAdDHooqIH+TMd"
Message-Id: <200511111400.23886.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_HlAdDHooqIH+TMd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Peter et al

Here is an update to bring plugsched in line with the current version of 
staircase.

Cheers,
Con

--Boundary-00=_HlAdDHooqIH+TMd
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="plugsched-staircase11.6_13.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="plugsched-staircase11.6_13.patch"

Update plugsched v6.1.3 to staircase version 13

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 include/linux/sched_task.h |    2
 kernel/staircase.c         |  107 +++++++++++++++++++++++----------------------
 2 files changed, 57 insertions(+), 52 deletions(-)

Index: linux-2.6.14-plugsched/include/linux/sched_task.h
===================================================================
--- linux-2.6.14-plugsched.orig/include/linux/sched_task.h	2005-11-11 12:38:57.000000000 +1100
+++ linux-2.6.14-plugsched/include/linux/sched_task.h	2005-11-11 13:10:30.000000000 +1100
@@ -29,7 +29,7 @@ struct ingo_sched_drv_task {
 struct staircase_sched_drv_task {
 	unsigned long sflags;
 	unsigned long runtime, totalrun, ns_debit;
-	unsigned int burst;
+	unsigned int bonus;
 	unsigned int slice, time_slice;
 };
 #endif
Index: linux-2.6.14-plugsched/kernel/staircase.c
===================================================================
--- linux-2.6.14-plugsched.orig/kernel/staircase.c	2005-11-11 13:26:32.000000000 +1100
+++ linux-2.6.14-plugsched/kernel/staircase.c	2005-11-11 13:53:11.000000000 +1100
@@ -2,8 +2,8 @@
  *  kernel/staircase.c
  *  Copyright (C) 1991-2005  Linus Torvalds
  *
- * 2005-08-20 Staircase scheduler by Con Kolivas
- *            Staircase v11.6
+ * 2005-11-11 Staircase scheduler by Con Kolivas <kernel@kolivas.org>
+ *            Staircase v13
  */
 #include <linux/sched.h>
 #include <linux/init.h>
@@ -148,30 +148,36 @@ static inline void __activate_idle_task(
 #endif
 
 /*
- * burst - extra intervals an interactive task can run for at best priority
- * instead of descending priorities.
+ * Bonus - How much higher than its base priority an interactive task can run.
  */
-static inline unsigned int burst(const task_t *p)
+static inline unsigned int bonus(const task_t *p)
 {
-	if (likely(!rt_task(p))) {
-		unsigned int task_user_prio = TASK_USER_PRIO(p);
-		return 39 - task_user_prio;
-	} else
-		return p->sdu.staircase.burst;
+	return TASK_USER_PRIO(p);
 }
 
-static void inc_burst(task_t *p)
+/*
+ * We increase our bonus by sleeping more than the time we ran.
+ * The ratio of sleep to run gives us the cpu% that we last ran and determines
+ * the maximum bonus we can acquire.
+ */
+static void inc_bonus(task_t *p, unsigned long totalrun, unsigned long sleep)
 {
-	unsigned int best_burst;
-	best_burst = burst(p);
-	if (p->sdu.staircase.burst < best_burst)
-		p->sdu.staircase.burst++;
+	unsigned int best_bonus;
+
+	best_bonus = sleep / (totalrun + 1);
+	if (p->sdu.staircase.bonus >= best_bonus)
+		return;
+
+	p->sdu.staircase.bonus++;
+	best_bonus = bonus(p);
+	if (p->sdu.staircase.bonus > best_bonus)
+		p->sdu.staircase.bonus = best_bonus;
 }
 
-static void dec_burst(task_t *p)
+static void dec_bonus(task_t *p)
 {
-	if (p->sdu.staircase.burst)
-		p->sdu.staircase.burst--;
+	if (p->sdu.staircase.bonus)
+		p->sdu.staircase.bonus--;
 }
 
 static inline unsigned int rr_interval(const task_t * p)
@@ -187,7 +193,7 @@ static inline unsigned int rr_interval(c
 
 /*
  * slice - the duration a task runs before getting requeued at its best
- * priority and has its burst decremented.
+ * priority and has its bonus decremented.
  */
 static inline unsigned int slice(const task_t *p)
 {
@@ -195,44 +201,42 @@ static inline unsigned int slice(const t
 
 	slice = rr = rr_interval(p);
 	if (likely(!rt_task(p)))
-		slice += burst(p) * rr;
+		slice += bonus(p) * rr;
 
 	return slice;
 }
 
 /*
- * sched_interactive - sysctl which allows interactive tasks to have bursts
+ * sched_interactive - sysctl which allows interactive tasks to have bonuss
  */
 int sched_interactive = 1;
 
 /*
- * effective_prio - dynamic priority dependent on burst.
+ * effective_prio - dynamic priority dependent on bonus.
  * The priority normally decreases by one each RR_INTERVAL.
- * As the burst increases the priority stays at the top "stair" or
+ * As the bonus increases the initial priority starts at a higher "stair" or
  * priority for longer.
  */
 static int effective_prio(task_t *p)
 {
 	int prio;
-	unsigned int full_slice, used_slice, first_slice;
-	unsigned int best_burst, rr;
+	unsigned int full_slice, used_slice = 0;
+	unsigned int best_bonus, rr;
+
 	if (rt_task(p))
 		return p->prio;
 
-	best_burst = burst(p);
 	full_slice = slice(p);
+	if (full_slice > p->sdu.staircase.slice)
+		used_slice = full_slice - p->sdu.staircase.slice;
+
+	best_bonus = bonus(p);
+	prio = MAX_RT_PRIO + best_bonus;
+	if (sched_interactive && !sched_compute)
+		prio -= p->sdu.staircase.bonus;
+
 	rr = rr_interval(p);
-	used_slice = full_slice - p->sdu.staircase.slice;
-	if (p->sdu.staircase.burst > best_burst)
-		p->sdu.staircase.burst = best_burst;
-	first_slice = rr;
-	if (sched_interactive && !sched_compute && p->mm)
-		first_slice *= (p->sdu.staircase.burst + 1);
-	prio = STAIRCASE_MAX_PRIO - 1 - best_burst;
-
-	if (used_slice < first_slice)
-		return prio;
-	prio += 1 + (used_slice - first_slice) / rr;
+	prio += used_slice / rr;
 	if (prio > STAIRCASE_MAX_PRIO - 1)
 		prio = STAIRCASE_MAX_PRIO - 1;
 
@@ -246,7 +250,7 @@ static void continue_slice(task_t *p)
 	if (total_run >= p->sdu.staircase.slice) {
  		p->sdu.staircase.totalrun -=
  			JIFFIES_TO_NS(p->sdu.staircase.slice);
-		dec_burst(p);
+		dec_bonus(p);
 	} else {
 		unsigned int remainder;
 		p->sdu.staircase.slice -= total_run;
@@ -268,19 +272,20 @@ static inline void recalc_task_prio(task
 
 	/*
 	 * Priority is elevated back to best by amount of sleep_time.
-	 * sleep_time is scaled down by number of tasks currently running.
 	 */
-	if (rq_running > 1)
-		sleep_time /= rq_running;
 
 	p->sdu.staircase.totalrun += p->sdu.staircase.runtime;
 	if (NS_TO_JIFFIES(p->sdu.staircase.totalrun) >=
 		p->sdu.staircase.slice && NS_TO_JIFFIES(sleep_time) <
 		p->sdu.staircase.slice) {
 			p->sdu.staircase.sflags &= ~SF_NONSLEEP;
-			dec_burst(p);
-			p->sdu.staircase.totalrun += sleep_time -
+			dec_bonus(p);
+			p->sdu.staircase.totalrun -=
 				JIFFIES_TO_NS(p->sdu.staircase.slice);
+			if (sleep_time > p->sdu.staircase.totalrun)
+				p->sdu.staircase.totalrun = 0;
+			else
+				p->sdu.staircase.totalrun -= sleep_time;
 			goto out;
 	}
 
@@ -297,7 +302,7 @@ static inline void recalc_task_prio(task
 
 	if (sleep_time >= p->sdu.staircase.totalrun) {
 		if (!(p->sdu.staircase.sflags & SF_NONSLEEP))
-			inc_burst(p);
+			inc_bonus(p, p->sdu.staircase.totalrun, sleep_time);
 		p->sdu.staircase.totalrun = 0;
 		goto out;
 	}
@@ -316,9 +321,9 @@ out:
  */
 static void activate_task(task_t *p, runqueue_t *rq, int local)
 {
-	unsigned long long now;
+	unsigned long long now = sched_clock();
+	unsigned long rr = rr_interval(p);
 
-	now = sched_clock();
 #ifdef CONFIG_SMP
 	if (!local) {
 		/* Compensate for drifting sched_clock */
@@ -328,7 +333,7 @@ static void activate_task(task_t *p, run
 	}
 #endif
 	p->sdu.staircase.slice = slice(p);
-	p->sdu.staircase.time_slice = rr_interval(p);
+	p->sdu.staircase.time_slice = p->sdu.staircase.slice % rr ? : rr;
 	recalc_task_prio(p, now, rq->nr_running);
 	p->sdu.staircase.sflags &= ~SF_NONSLEEP;
 	p->prio = effective_prio(p);
@@ -432,9 +437,9 @@ static void staircase_wake_up_new_task(t
 	BUG_ON(p->state != TASK_RUNNING);
 
 	/*
-	 * Forked process gets no burst to prevent fork bombs.
+	 * Forked process gets no bonus to prevent fork bombs.
 	 */
-	p->sdu.staircase.burst = 0;
+	p->sdu.staircase.bonus = 0;
 
 	if (likely(cpu == this_cpu)) {
 		current->sdu.staircase.sflags |= SF_NONSLEEP;
@@ -637,10 +642,10 @@ static void staircase_tick(struct task_s
 		goto out_unlock;
 	p->sdu.staircase.ns_debit %= NSJIFFY;
 	/*
-	 * Tasks lose burst each time they use up a full slice().
+	 * Tasks lose bonus each time they use up a full slice().
 	 */
 	if (!--p->sdu.staircase.slice) {
-		dec_burst(p);
+		dec_bonus(p);
 		p->sdu.staircase.slice = slice(p);
 		time_slice_expired(p, rq);
 		p->sdu.staircase.totalrun = 0;

--Boundary-00=_HlAdDHooqIH+TMd--
