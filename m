Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWCDKvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWCDKvu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 05:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWCDKvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 05:51:50 -0500
Received: from mail.gmx.de ([213.165.64.20]:34027 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750712AbWCDKvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 05:51:49 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-rc5-mm2]  sched_cleanup-V17 - task throttling
	patch 1 of 2
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: lkml <linux-kernel@vger.kernel.org>, mingo@elte.hu, kernel@kolivas.org,
       nickpiggin@yahoo.com.au, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1141449654.7703.36.camel@homer>
References: <1140183903.14128.77.camel@homer>
	 <1140812981.8713.35.camel@homer>  <20060224141505.41b1a627.akpm@osdl.org>
	 <1140834190.7641.25.camel@homer> <1141382609.8768.57.camel@homer>
	 <4408FC8B.4050802@bigpond.net.au>  <1141449654.7703.36.camel@homer>
Content-Type: text/plain
Date: Sat, 04 Mar 2006 11:53:40 +0100
Message-Id: <1141469620.13593.10.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-04 at 06:21 +0100, Mike Galbraith wrote:

> I need to reconsider the nanosecond tracking a bit anyway.  I was too
> quick on the draw with the granularity change.  It doesn't do what the
> original does, and won't work at all when interrupts become tasks.
> 
> To do this properly, I need to maintain separate tick hit count (a.k.a.
> time_slice;) and run_time.  If I had slice_info in the first patch, I
> could store granularity there and not have to add anything to the task
> struct, but alas...

Ala the below.  Leave the ticked timeslice available for those places
where nanoseconds are useless, and do precise counting only where that
is useful.  I need to come up with a better name that slice_ticks, and
time_slice is already taken.

	-Mike

--- linux-2.6.16-rc5-mm2/include/linux/sched.h.org	2006-03-01 15:06:22.000000000 +0100
+++ linux-2.6.16-rc5-mm2/include/linux/sched.h	2006-03-02 08:33:12.000000000 +0100
@@ -720,7 +720,8 @@
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
-	unsigned int time_slice, first_time_slice;
+	int time_slice;
+	unsigned int slice_ticks, first_time_slice;
 
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
--- linux-2.6.16-rc5-mm2/kernel/sched.c.org	2006-03-01 15:05:56.000000000 +0100
+++ linux-2.6.16-rc5-mm2/kernel/sched.c	2006-03-02 10:05:47.000000000 +0100
@@ -99,6 +99,10 @@
 #define MAX_SLEEP_AVG		(DEF_TIMESLICE * MAX_BONUS)
 #define STARVATION_LIMIT	(MAX_SLEEP_AVG)
 #define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
+#define NS_MAX_SLEEP_AVG_PCNT	(NS_MAX_SLEEP_AVG / 100)
+#define PCNT_PER_DYNPRIO	(100 / MAX_BONUS)
+#define NS_PER_DYNPRIO		(PCNT_PER_DYNPRIO * NS_MAX_SLEEP_AVG_PCNT)
+#define NS_TICK			(JIFFIES_TO_NS(1))
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -153,9 +157,25 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
-#define INTERACTIVE_SLEEP(p) \
-	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
-		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
+#define SLEEP_AVG_DIVISOR(p) (1 + CURRENT_BONUS(p))
+
+#define INTERACTIVE_SLEEP_AVG(p) \
+	(min(JIFFIES_TO_NS(MAX_SLEEP_AVG * (MAX_BONUS / 2 + DELTA(p)) / \
+	MAX_BONUS), NS_MAX_SLEEP_AVG))
+
+/*
+ * Returns whether a task has been asleep long enough to be considered idle.
+ * The metric is whether this quantity of sleep would promote the task more
+ * than one priority beyond marginally interactive.
+ */
+static int task_interactive_idle(task_t *p, unsigned long sleep_time)
+{
+	unsigned long ceiling = (CURRENT_BONUS(p) + 2) * NS_PER_DYNPRIO;
+
+	if (p->sleep_avg + sleep_time < ceiling)
+		return 0;
+	return p->sleep_avg + sleep_time >= INTERACTIVE_SLEEP_AVG(p);
+}
 
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
@@ -182,7 +202,7 @@
 
 static inline unsigned int task_timeslice(task_t *p)
 {
-	return static_prio_timeslice(p->static_prio);
+	return JIFFIES_TO_NS(static_prio_timeslice(p->static_prio));
 }
 
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
@@ -777,6 +797,9 @@
 	unsigned long long __sleep_time = now - p->timestamp;
 	unsigned long sleep_time;
 
+	if (unlikely(now < p->timestamp))
+		__sleep_time = 0ULL;
+
 	if (unlikely(p->policy == SCHED_BATCH))
 		sleep_time = 0;
 	else {
@@ -788,32 +811,32 @@
 
 	if (likely(sleep_time > 0)) {
 		/*
-		 * User tasks that sleep a long time are categorised as
-		 * idle. They will only have their sleep_avg increased to a
+		 * Tasks that sleep a long time are categorised as idle.
+		 * They will only have their sleep_avg increased to a
 		 * level that makes them just interactive priority to stay
 		 * active yet prevent them suddenly becoming cpu hogs and
 		 * starving other processes.
 		 */
-		if (p->mm && sleep_time > INTERACTIVE_SLEEP(p)) {
-				unsigned long ceiling;
-
-				ceiling = JIFFIES_TO_NS(MAX_SLEEP_AVG -
-					DEF_TIMESLICE);
-				if (p->sleep_avg < ceiling)
-					p->sleep_avg = ceiling;
-		} else {
+		if (task_interactive_idle(p, sleep_time)) {
+			unsigned long ceiling = INTERACTIVE_SLEEP_AVG(p);
 
 			/*
-			 * The lower the sleep avg a task has the more
-			 * rapidly it will rise with sleep time. This enables
-			 * tasks to rapidly recover to a low latency priority.
-			 * If a task was sleeping with the noninteractive
-			 * label do not apply this non-linear boost
+			 * Promote previously interactive task.
 			 */
-			if (p->sleep_type != SLEEP_NONINTERACTIVE || !p->mm)
-				sleep_time *=
-					(MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
+			if (p->sleep_avg > ceiling) {
+				ceiling = p->sleep_avg / NS_PER_DYNPRIO;
+				if (ceiling < MAX_BONUS)
+					ceiling++;
+				ceiling *= NS_PER_DYNPRIO;
+			} else {
+				ceiling += p->time_slice >> 2;
+				if (ceiling > NS_MAX_SLEEP_AVG)
+					ceiling = NS_MAX_SLEEP_AVG;
+			}
 
+			if (p->sleep_avg < ceiling)
+				p->sleep_avg = ceiling;
+		} else {
 			/*
 			 * This code gives a bonus to interactive tasks.
 			 *
@@ -1367,7 +1390,8 @@
 
 out_activate:
 #endif /* CONFIG_SMP */
-	if (old_state == TASK_UNINTERRUPTIBLE) {
+
+	if (old_state & TASK_UNINTERRUPTIBLE) {
 		rq->nr_uninterruptible--;
 		/*
 		 * Tasks waking from uninterruptible sleep are likely
@@ -1461,6 +1485,8 @@
 	 */
 	local_irq_disable();
 	p->time_slice = (current->time_slice + 1) >> 1;
+	if (unlikely(p->time_slice < NS_TICK))
+		p->time_slice = NS_TICK;
 	/*
 	 * The remainder of the first timeslice might be recovered by
 	 * the parent if the child exits early enough.
@@ -1468,13 +1494,12 @@
 	p->first_time_slice = 1;
 	current->time_slice >>= 1;
 	p->timestamp = sched_clock();
-	if (unlikely(!current->time_slice)) {
+	if (unlikely(current->time_slice < NS_TICK)) {
 		/*
 		 * This case is rare, it happens when the parent has only
 		 * a single jiffy left from its timeslice. Taking the
 		 * runqueue lock is not a problem.
 		 */
-		current->time_slice = 1;
 		scheduler_tick();
 	}
 	local_irq_enable();
@@ -2586,6 +2611,7 @@
 {
 	unsigned long long last = max(p->timestamp, rq->timestamp_last_tick);
 	p->sched_time += now - last;
+	p->time_slice -= now - last;
 }
 
 /*
@@ -2730,13 +2756,16 @@
 	 * timeslice. This makes it possible for interactive tasks
 	 * to use up their timeslices at their highest priority levels.
 	 */
+	if (p->slice_ticks > 1)
+		p->slice_ticks--;
 	if (rt_task(p)) {
 		/*
 		 * RR tasks need a special form of timeslice management.
 		 * FIFO tasks have no timeslices.
 		 */
-		if ((p->policy == SCHED_RR) && !--p->time_slice) {
-			p->time_slice = task_timeslice(p);
+		if ((p->policy == SCHED_RR) && p->time_slice < NS_TICK) {
+			p->time_slice += task_timeslice(p);
+			p->slice_ticks = NS_TO_JIFFIES(p->time_slice);
 			p->first_time_slice = 0;
 			set_tsk_need_resched(p);
 
@@ -2745,11 +2774,22 @@
 		}
 		goto out_unlock;
 	}
-	if (!--p->time_slice) {
+	if (p->time_slice < NS_TICK) {
+		unsigned int time_slice = task_timeslice(p);
+		int run_time = time_slice - p->time_slice;
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
+		p->time_slice += time_slice;
+		p->slice_ticks = NS_TO_JIFFIES(p->time_slice);
+		/*
+		 * Tasks are charged proportionately less run_time at high
+		 * sleep_avg to delay them losing their interactive status
+		 */
+		run_time /= SLEEP_AVG_DIVISOR(p);
+		p->sleep_avg -= run_time;
+		if ((long)p->sleep_avg < 0)
+			p->sleep_avg = 0;
 		p->prio = effective_prio(p);
-		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 
 		if (!rq->expired_timestamp)
@@ -2777,13 +2817,12 @@
 		 * This only applies to tasks in the interactive
 		 * delta range with at least TIMESLICE_GRANULARITY to requeue.
 		 */
-		if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
-			p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
-			(p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
+		if (TASK_INTERACTIVE(p) && !((NS_TO_JIFFIES(task_timeslice(p)) -
+			p->slice_ticks) % TIMESLICE_GRANULARITY(p)) &&
+			(p->slice_ticks >= TIMESLICE_GRANULARITY(p)) &&
 			(p->array == rq->active)) {
-
-			requeue_task(p, rq->active);
-			set_tsk_need_resched(p);
+				requeue_task(p, rq->active);
+				set_tsk_need_resched(p);
 		}
 	}
 out_unlock:
@@ -2851,7 +2890,7 @@
  */
 static inline unsigned long smt_slice(task_t *p, struct sched_domain *sd)
 {
-	return p->time_slice * (100 - sd->per_cpu_gain) / 100;
+	return p->slice_ticks * (100 - sd->per_cpu_gain) / 100;
 }
 
 static int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
@@ -3014,7 +3053,6 @@
 	prio_array_t *array;
 	struct list_head *queue;
 	unsigned long long now;
-	unsigned long run_time;
 	int cpu, idx, new_prio;
 
 	/*
@@ -3050,19 +3088,6 @@
 
 	schedstat_inc(rq, sched_cnt);
 	now = sched_clock();
-	if (likely((long long)(now - prev->timestamp) < NS_MAX_SLEEP_AVG)) {
-		run_time = now - prev->timestamp;
-		if (unlikely((long long)(now - prev->timestamp) < 0))
-			run_time = 0;
-	} else
-		run_time = NS_MAX_SLEEP_AVG;
-
-	/*
-	 * Tasks charged proportionately less run_time at high sleep_avg to
-	 * delay them losing their interactive status
-	 */
-	run_time /= (CURRENT_BONUS(prev) ? : 1);
-
 	spin_lock_irq(&rq->lock);
 
 	if (unlikely(prev->flags & PF_DEAD))
@@ -3075,7 +3100,7 @@
 				unlikely(signal_pending(prev))))
 			prev->state = TASK_RUNNING;
 		else {
-			if (prev->state == TASK_UNINTERRUPTIBLE)
+			if (prev->state & TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible++;
 			deactivate_task(prev, rq);
 		}
@@ -3136,7 +3161,6 @@
 		if (next->sleep_type == SLEEP_INTERACTIVE)
 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
 
-		array = next->array;
 		new_prio = recalc_task_prio(next, next->timestamp + delta);
 
 		if (unlikely(next->prio != new_prio)) {
@@ -3156,9 +3180,6 @@
 
 	update_cpu_clock(prev, rq, now);
 
-	prev->sleep_avg -= run_time;
-	if ((long)prev->sleep_avg <= 0)
-		prev->sleep_avg = 0;
 	prev->timestamp = prev->last_ran = now;
 
 	sched_info_switch(prev, next);


