Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270703AbTG0Jst (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 05:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270707AbTG0Jst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 05:48:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55733 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270703AbTG0Jsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 05:48:43 -0400
Date: Sun, 27 Jul 2003 12:02:36 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
In-Reply-To: <200307271957.01597.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.44.0307271158390.10340-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Con,

would you mind to explain the reasoning behind the avg_start,
MIN_SLEEP_AVG and normalise_sleep() logic in your patch?

[for reference i've attached your patches in a single unified patch up to
O8int, against 2.6.0-test1.]

	Ingo

--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -341,6 +341,7 @@ struct task_struct {
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
+	unsigned long avg_start;
 	unsigned long last_run;
 
 	unsigned long policy;
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -68,14 +68,16 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
-#define CHILD_PENALTY		50
+#define CHILD_PENALTY		95
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
+#define MIN_SLEEP_AVG		(HZ)
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
+#define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -297,6 +299,26 @@ static inline void enqueue_task(struct t
 	array->nr_active++;
 	p->array = array;
 }
+/*
+ * normalise_sleep converts a task's sleep_avg to
+ * an appropriate proportion of MIN_SLEEP_AVG.
+ */
+static inline void normalise_sleep(task_t *p)
+{
+	unsigned long old_avg_time = jiffies - p->avg_start;
+
+	if (unlikely(old_avg_time < MIN_SLEEP_AVG))
+		return;
+
+	if (p->sleep_avg > MAX_SLEEP_AVG)
+		p->sleep_avg = MAX_SLEEP_AVG;
+
+	if (old_avg_time > MAX_SLEEP_AVG)
+		old_avg_time = MAX_SLEEP_AVG;
+
+	p->sleep_avg = p->sleep_avg * MIN_SLEEP_AVG / old_avg_time;
+	p->avg_start = jiffies - MIN_SLEEP_AVG;
+}
 
 /*
  * effective_prio - return the priority that is based on the static
@@ -315,11 +337,28 @@ static inline void enqueue_task(struct t
 static int effective_prio(task_t *p)
 {
 	int bonus, prio;
+	unsigned long sleep_period;
 
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
+	sleep_period = jiffies - p->avg_start;
+
+	if (unlikely(!sleep_period))
+		return p->static_prio;
+
+	if (sleep_period > MAX_SLEEP_AVG)
+		sleep_period = MAX_SLEEP_AVG;
+
+	if (p->sleep_avg > sleep_period)
+		sleep_period = p->sleep_avg;
+
+	/*
+	 * The bonus is determined according to the accumulated
+	 * sleep avg over the duration the task has been running
+	 * until it reaches MAX_SLEEP_AVG. -ck
+	 */
+	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/sleep_period/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
 	prio = p->static_prio - bonus;
@@ -350,31 +389,47 @@ static inline void activate_task(task_t 
 	long sleep_time = jiffies - p->last_run - 1;
 
 	if (sleep_time > 0) {
-		int sleep_avg;
-
 		/*
-		 * This code gives a bonus to interactive tasks.
-		 *
-		 * The boost works by updating the 'average sleep time'
-		 * value here, based on ->last_run. The more time a task
-		 * spends sleeping, the higher the average gets - and the
-		 * higher the priority boost gets as well.
+		 * User tasks that sleep a long time are categorised as idle and
+		 * will get just under interactive status with a small runtime
+		 * to allow them to become interactive or non-interactive rapidly
 		 */
-		sleep_avg = p->sleep_avg + sleep_time;
+		if (sleep_time > MIN_SLEEP_AVG && p->mm){
+			p->avg_start = jiffies - MIN_SLEEP_AVG;
+			p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 2) /
+				MAX_BONUS;
+		} else {
+			unsigned long runtime = jiffies - p->avg_start;
 
-		/*
-		 * 'Overflow' bonus ticks go to the waker as well, so the
-		 * ticks are not lost. This has the effect of further
-		 * boosting tasks that are related to maximum-interactive
-		 * tasks.
-		 */
-		if (sleep_avg > MAX_SLEEP_AVG)
-			sleep_avg = MAX_SLEEP_AVG;
-		if (p->sleep_avg != sleep_avg) {
-			p->sleep_avg = sleep_avg;
-			p->prio = effective_prio(p);
+			if (runtime > MAX_SLEEP_AVG)
+				runtime = MAX_SLEEP_AVG;
+
+			/*
+			 * This code gives a bonus to interactive tasks.
+			 *
+			 * The boost works by updating the 'average sleep time'
+			 * value here, based on ->last_run. The more time a task
+			 * spends sleeping, the higher the average gets - and the
+			 * higher the priority boost gets as well.
+			 */
+			p->sleep_avg += sleep_time;
+
+			/*
+			 * Processes that sleep get pushed to a higher priority
+			 * each time they sleep
+			 */
+			p->sleep_avg = (p->sleep_avg * MAX_BONUS / runtime + 1) * runtime / MAX_BONUS;
+
+			if (p->sleep_avg > MAX_SLEEP_AVG)
+				p->sleep_avg = MAX_SLEEP_AVG;
+		}
+
+		if (unlikely(p->avg_start > jiffies)){
+			p->avg_start = jiffies;
+			p->sleep_avg = 0;
 		}
 	}
+	p->prio = effective_prio(p);
 	__activate_task(p, rq);
 }
 
@@ -551,6 +606,7 @@ void wake_up_forked_process(task_t * p)
 	 * from forking tasks that are max-interactive.
 	 */
 	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
+	normalise_sleep(p);
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
@@ -591,6 +647,8 @@ void sched_exit(task_t * p)
 	 * If the child was a (relative-) CPU hog then decrease
 	 * the sleep_avg of the parent as well.
 	 */
+	normalise_sleep(p);
+	normalise_sleep(p->parent);
 	if (p->sleep_avg < p->parent->sleep_avg)
 		p->parent->sleep_avg = (p->parent->sleep_avg * EXIT_WEIGHT +
 			p->sleep_avg) / (EXIT_WEIGHT + 1);
@@ -1213,11 +1271,7 @@ void scheduler_tick(int user_ticks, int 
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
@@ -1250,6 +1304,17 @@ void scheduler_tick(int user_ticks, int 
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
+	} else if (p->mm && !((task_timeslice(p) - p->time_slice) %
+		 (MIN_TIMESLICE * (MAX_BONUS + 1 - p->sleep_avg * MAX_BONUS / MAX_SLEEP_AVG)))){
+		/*
+		 * Running user tasks get requeued with their remaining timeslice
+		 * after a period proportional to how cpu intensive they are to
+		 * minimise the duration one interactive task can starve another
+		 */
+		dequeue_task(p, rq->active);
+		set_tsk_need_resched(p);
+		p->prio = effective_prio(p);
+		enqueue_task(p, rq->active);
 	}
 out_unlock:
 	spin_unlock(&rq->lock);

