Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271123AbTHCKJm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 06:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271125AbTHCKJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 06:09:42 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:58246
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271123AbTHCKJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 06:09:03 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] O12.2int for interactivity
Date: Sun, 3 Aug 2003 20:14:00 +1000
User-Agent: KMail/1.5.3
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308032014.00986.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've continued development on the interactivity patches against Ingo's new 
infrastructure changes. 

This is a complete resync of the work so far with changes to suit the 
nanosecond timing.

Rather than just a changelog, here is a complete list of what this patch
does on top of Ingo's :

Interactivity credit determines whether a task is interactive or not and 
treats them differently during priority changing.

Some #defines are used to help conversion from ns to jiffies, and the tuning 
knobs have been altered slightly to work with these changes.

Tasks do not earn sleep_avg on their initial wakeup.

User tasks sleeping for a long period get just interactive sleep_avg to stay 
on the active queue but be unable to starve if they turn into cpu hogs.

Tasks with interactive credit elevate their sleep avg proportionately more as 
their priority bonus starts dropping off.

Tasks without interactive credit are limited to one timeslice worth of sleep 
avg as a bonus.

Accumulated sleep_avg of over MAX_SLEEP_AVG starts earning tasks interactive 
credits.

Run out of sleep_avg makes you lose interactive credits.

On their very first wakeup new forks don't get any sleep_avg bonus.

Only tasks with interactive_credits gain sleep_avg for time waiting on the 
runqueue.

New forks get the lowest value of sleep_avg compatible with the dynamic 
priority they will wake up with.

Reverted Ingo's EXPIRED_STARVING definition; it was making interactive tasks 
expire faster as cpu load increased.

Only user tasks get requeued after TIMESLICE_GRANULARITY, and only if they 
have at least MIN_TIMESLICE remaining.

Tasks with interactive credit lose proportionately less sleep_avg as their 
dynamic priority drops.

Using up a full timeslice makes you lose interactive credits.

The patch patch-A3-O12.2int is available against 2.6.0-test2-mm3 here:

http://kernel.kolivas.org/2.5

Ingo's patch-test2-A3 patch against 2.6.0-test2 is also available there, and a 
patch-test2-A3-O12.2  to go on top of that is also available.

Please note if you do test the interactivity it would be most valuable if you 
test Ingo's A3 patch first looking for improvements and problems compared to 
vanilla _first_, and then test my O12.2 patch on top of it. Hopefully there
has been no regression and only improvement in going to Ingo's new
infrastructure.

Con

patch-A3-O12.2int against 2.6.0-test2-mm3:

--- linux-2.6.0-test2-mm3/include/linux/sched.h	2003-08-03 09:51:49.000000000 +1000
+++ linux-2.6.0-test2-mm3-O12.2/include/linux/sched.h	2003-08-03 09:53:32.000000000 +1000
@@ -341,6 +341,7 @@ struct task_struct {
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
+	long interactive_credit;
 	unsigned long long timestamp;
 	int activated;
 
--- linux-2.6.0-test2-mm3/kernel/sched.c	2003-08-03 09:51:49.000000000 +1000
+++ linux-2.6.0-test2-mm3-O12.2/kernel/sched.c	2003-08-03 10:19:22.000000000 +1000
@@ -58,6 +58,14 @@
 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
+#define AVG_TIMESLICE	(MIN_TIMESLICE + ((MAX_TIMESLICE - MIN_TIMESLICE) *\
+			(MAX_PRIO-1-NICE_TO_PRIO(0))/(MAX_USER_PRIO - 1)))
+
+/*
+ * Some helpers for converting nanosecond timing to jiffy resolution
+ */
+#define NS_TO_JIFFIES(TIME)	(TIME / (1000000000 / HZ))
+#define JIFFIES_TO_NS(TIME)	(TIME * (1000000000 / HZ))
 
 /*
  * These are the 'tuning knobs' of the scheduler:
@@ -70,13 +78,15 @@
 #define MAX_TIMESLICE		(200 * HZ / 1000)
 #define TIMESLICE_GRANULARITY	(HZ/40 ?: 1)
 #define ON_RUNQUEUE_WEIGHT	30
-#define CHILD_PENALTY		95
+#define CHILD_PENALTY		90
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
+#define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
 #define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(1*1000000000)
-#define STARVATION_LIMIT	HZ
+#define MAX_SLEEP_AVG		(AVG_TIMESLICE * MAX_BONUS)
+#define STARVATION_LIMIT	(MAX_SLEEP_AVG)
+#define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
 #define NODE_THRESHOLD		125
 
 /*
@@ -117,6 +127,9 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
+#define JUST_INTERACTIVE_SLEEP(p) \
+	(MAX_SLEEP_AVG - (DELTA(p) * AVG_TIMESLICE))
+
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio || \
 		((p)->prio == (rq)->curr->prio && \
@@ -326,8 +339,9 @@ static int effective_prio(task_t *p)
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*(p->sleep_avg/1024)/(MAX_SLEEP_AVG/1024)/100;
-	bonus -= MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
+	bonus = MAX_USER_PRIO * PRIO_BONUS_RATIO *
+		NS_TO_JIFFIES(p->sleep_avg) / MAX_SLEEP_AVG / 100;
+	bonus -= MAX_USER_PRIO * PRIO_BONUS_RATIO / 100 / 2;
 
 	prio = p->static_prio - bonus;
 	if (prio < MAX_RT_PRIO)
@@ -351,37 +365,65 @@ static void recalc_task_prio(task_t *p, 
 	unsigned long long __sleep_time = now - p->timestamp;
 	unsigned long sleep_time;
 
-	if (__sleep_time > MAX_SLEEP_AVG)
-		sleep_time = MAX_SLEEP_AVG;
+	if (unlikely(!p->timestamp))
+		__sleep_time = 0;
+
+	if (__sleep_time > NS_MAX_SLEEP_AVG)
+		sleep_time = NS_MAX_SLEEP_AVG;
 	else
 		sleep_time = (unsigned long)__sleep_time;
 
-	if (sleep_time > 0) {
-		unsigned long long sleep_avg;
+	if (likely(sleep_time > 0)) {
 
 		/*
-		 * This code gives a bonus to interactive tasks.
-		 *
-		 * The boost works by updating the 'average sleep time'
-		 * value here, based on ->timestamp. The more time a task
-		 * spends sleeping, the higher the average gets - and the
-		 * higher the priority boost gets as well.
+		 * User tasks that sleep a long time are categorised as
+		 * idle and will get just interactive status to stay active &
+		 * prevent them suddenly becoming cpu hogs and starving
+		 * other processes.
 		 */
-		sleep_avg = p->sleep_avg + sleep_time;
+		if (p->mm && sleep_time >
+			JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p)))
+				p->sleep_avg =
+					JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p));
+		else {
+			/*
+			 * Tasks with interactive credits get boosted more
+			 * rapidly if their bonus has dropped off. Other
+			 * tasks are limited to one timeslice worth of
+			 * sleep avg.
+			 */
+			if (p->interactive_credit > 0)
+				sleep_time *= (MAX_BONUS + 1 -
+					(NS_TO_JIFFIES(p->sleep_avg) *
+					MAX_BONUS / MAX_SLEEP_AVG));
+			else if (sleep_time > JIFFIES_TO_NS(task_timeslice(p)))
+				sleep_time = JIFFIES_TO_NS(task_timeslice(p));
 
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
+			/*
+			 * This code gives a bonus to interactive tasks.
+			 *
+			 * The boost works by updating the 'average sleep time'
+			 * value here, based on ->timestamp. The more time a task
+			 * spends sleeping, the higher the average gets - and the
+			 * higher the priority boost gets as well.
+			 */
+			p->sleep_avg += sleep_time;
+
+			/*
+			 * 'Overflow' bonus ticks go to the waker as well, so the
+			 * ticks are not lost. This has the effect of further
+			 * boosting tasks that are related to maximum-interactive
+			 * tasks.
+			 */
+			if (p->sleep_avg > NS_MAX_SLEEP_AVG){
+				p->sleep_avg = NS_MAX_SLEEP_AVG;
+				p->interactive_credit++;
+			}
 		}
-	}
+	} else if (!p->sleep_avg)
+		p->interactive_credit--;
+
+	p->prio = effective_prio(p);
 }
 
 /*
@@ -411,6 +453,10 @@ static inline void activate_task(task_t 
 	 * but it will be weighted down:
 	 */
 		p->activated = 1;
+
+	if (unlikely(!p->timestamp))
+		p->activated = 0;
+
 	p->timestamp = now;
 
 	__activate_task(p, rq);
@@ -579,7 +625,7 @@ int wake_up_state(task_t *p, unsigned in
  */
 void wake_up_forked_process(task_t * p)
 {
-	unsigned long flags;
+	unsigned long flags, sleep_avg;
 	runqueue_t *rq = task_rq_lock(current, &flags);
 
 	p->state = TASK_RUNNING;
@@ -588,8 +634,18 @@ void wake_up_forked_process(task_t * p)
 	 * and children as well, to keep max-interactive tasks
 	 * from forking tasks that are max-interactive.
 	 */
-	current->sleep_avg = current->sleep_avg / 100 * PARENT_PENALTY;
-	p->sleep_avg = p->sleep_avg / 100 * CHILD_PENALTY;
+	sleep_avg = NS_TO_JIFFIES(current->sleep_avg) * MAX_BONUS /
+			MAX_SLEEP_AVG * PARENT_PENALTY / 100 *
+			MAX_SLEEP_AVG / MAX_BONUS;
+	current->sleep_avg = JIFFIES_TO_NS(sleep_avg);
+
+	sleep_avg = NS_TO_JIFFIES(p->sleep_avg) * MAX_BONUS / MAX_SLEEP_AVG *
+			CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS;
+	p->sleep_avg = JIFFIES_TO_NS(sleep_avg);
+
+	p->interactive_credit = 0;
+	p->timestamp = 0;
+
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
 
@@ -630,7 +686,9 @@ void sched_exit(task_t * p)
 	 * the sleep_avg of the parent as well.
 	 */
 	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = p->parent->sleep_avg / (EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg / (EXIT_WEIGHT + 1);
+		p->parent->sleep_avg = p->parent->sleep_avg /
+		(EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg /
+		(EXIT_WEIGHT + 1);
 }
 
 /**
@@ -1204,7 +1262,8 @@ EXPORT_PER_CPU_SYMBOL(kstat);
  */
 #define EXPIRED_STARVING(rq) \
 		(STARVATION_LIMIT && ((rq)->expired_timestamp && \
-		(jiffies - (rq)->expired_timestamp >= STARVATION_LIMIT)))
+		(jiffies - (rq)->expired_timestamp >= \
+			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
 
 /*
  * This function gets called by the timer code, with HZ frequency.
@@ -1275,6 +1334,7 @@ void scheduler_tick(int user_ticks, int 
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
+		p->interactive_credit--;
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
@@ -1296,11 +1356,12 @@ void scheduler_tick(int user_ticks, int 
 		 * level, which is in essence a round-robin of tasks with
 		 * equal priority.
 		 */
-		if (!((task_timeslice(p) - p->time_slice) % TIMESLICE_GRANULARITY) &&
-			       		(p->array == rq->active)) {
+		if (p->mm && !((task_timeslice(p) - p->time_slice) %
+			TIMESLICE_GRANULARITY) && (p->time_slice > MIN_TIMESLICE) &&
+			(p->array == rq->active)) {
+
 			dequeue_task(p, rq->active);
 			set_tsk_need_resched(p);
-			p->prio = effective_prio(p);
 			enqueue_task(p, rq->active);
 		}
 	}
@@ -1344,10 +1405,21 @@ need_resched:
 
 	release_kernel_lock(prev);
 	now = sched_clock();
-	if (likely(now - prev->timestamp < MAX_SLEEP_AVG))
+	if (likely(now - prev->timestamp < NS_MAX_SLEEP_AVG))
 		run_time = now - prev->timestamp;
 	else
-		run_time = MAX_SLEEP_AVG;
+		run_time = NS_MAX_SLEEP_AVG;
+
+	/*
+	 * Tasks with interactive credits get charged less run_time
+	 * as their sleep_avg decreases to slow them losing their
+	 * priority bonus
+	 */
+	if (prev->interactive_credit > 0)
+		run_time /= (MAX_BONUS + 1 -
+			(NS_TO_JIFFIES(prev->sleep_avg) * MAX_BONUS /
+			MAX_SLEEP_AVG));
+
 	spin_lock_irq(&rq->lock);
 
 	/*
@@ -1395,7 +1467,7 @@ pick_next_task:
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
-	if (next->activated) {
+	if (next->activated && next->interactive_credit > 0) {
 		unsigned long long delta = now - next->timestamp;
 
 		if (next->activated == 1)

