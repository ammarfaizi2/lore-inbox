Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWC3KTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWC3KTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWC3KTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:19:44 -0500
Received: from mail.gmx.de ([213.165.64.20]:4818 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751339AbWC3KTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:19:43 -0500
X-Authenticated: #14349625
Subject: [rfc][patch] improved interactive starvation patch against 2.6.16
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Willy Tarreau <willy@w.ods.org>,
       Con Kolivas <kernel@kolivas.org>
Content-Type: multipart/mixed; boundary="=-9aLHyHATMae8jBiG4Kbc"
Date: Thu, 30 Mar 2006 12:19:57 +0200
Message-Id: <1143713997.9381.28.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9aLHyHATMae8jBiG4Kbc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Greetings,

The patch below alone makes virgin 2.6.16 usable in the busy apache
server scenario, and should help quite a bit with other situations as
well.

The original version helps a lot, but not enough, and the latency of
being awakened in the expired array can be needlessly painful.  Ergo,
speed up the array switch, and instead of unconditionally plunking all
awakening tasks (including rt tasks, oops) into the expired array, check
to see if the task has run since the last array switch first.  This
leaves a theoretical hole for a stream of one-time waking tasks to
starve the expired array indefinitely, but it deals with the real
problem pretty nicely I think. 

For the one or two folks on the planet testing my anti-starvation
patches, I've attached an incremental to my 2.6.16 test release.
 
	-Mike

--- linux-2.6.16/kernel/sched.c.org	2006-03-30 11:05:31.000000000 +0200
+++ linux-2.6.16/kernel/sched.c	2006-03-30 11:10:02.000000000 +0200
@@ -77,6 +77,20 @@
 #define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
 #define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
 
+#if (BITS_PER_LONG < 64)
+#define JIFFIES_TO_NS64(TIME) \
+	((unsigned long long)(TIME) * ((unsigned long) (1000000000 / HZ)))
+
+#define NS64_TO_JIFFIES(TIME) \
+	((((unsigned long long)((TIME)) >> BITS_PER_LONG) * \
+	(1 + NS_TO_JIFFIES(~0UL))) + NS_TO_JIFFIES((unsigned long)(TIME)))
+#else /* BITS_PER_LONG < 64 */
+
+#define NS64_TO_JIFFIES(TIME) NS_TO_JIFFIES(TIME)
+#define JIFFIES_TO_NS64(TIME) JIFFIES_TO_NS(TIME)
+
+#endif /* BITS_PER_LONG < 64 */
+
 /*
  * These are the 'tuning knobs' of the scheduler:
  *
@@ -220,7 +234,7 @@
 	 */
 	unsigned long nr_uninterruptible;
 
-	unsigned long expired_timestamp;
+	unsigned long long expired_timestamp;
 	unsigned long long timestamp_last_tick;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
@@ -662,11 +676,60 @@
 }
 
 /*
+ * We place interactive tasks back into the active array, if possible.
+ *
+ * To guarantee that this does not starve expired tasks we ignore the
+ * interactivity of a task if the first expired task had to wait more
+ * than a 'reasonable' amount of time. This deadline timeout is
+ * load-dependent, as the frequency of array switched decreases with
+ * increasing number of running tasks. We also ignore the interactivity
+ * if a better static_prio task has expired, and switch periodically
+ * regardless, to ensure that highly interactive tasks do not starve
+ * the less fortunate for unreasonably long periods.
+ */
+static inline int expired_starving(runqueue_t *rq)
+{
+	int limit;
+
+	/*
+	 * Arrays were recently switched, all is well.
+	 */
+	if (!rq->expired_timestamp)
+		return 0;
+
+	limit = STARVATION_LIMIT * rq->nr_running;
+
+	/*
+	 * It's time to switch arrays.
+	 */
+	if (jiffies - NS64_TO_JIFFIES(rq->expired_timestamp) >= limit)
+		return 1;
+
+	/*
+	 * There's a better selection in the expired array.
+	 */
+	if (rq->curr->static_prio > rq->best_expired_prio)
+		return 1;
+
+	/*
+	 * All is well.
+	 */
+	return 0;
+}
+
+/*
  * __activate_task - move a task to the runqueue.
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task(p, rq->active);
+	prio_array_t *array = rq->active;
+	if (unlikely(expired_starving(rq) && !rt_task(p) &&
+			p->last_ran > rq->expired_timestamp)) {
+		array = rq->expired;
+		if (p->prio < rq->best_expired_prio)
+			rq->best_expired_prio = p->prio;
+	}
+	enqueue_task(p, array);
 	rq->nr_running++;
 }
 
@@ -2461,22 +2524,6 @@
 }
 
 /*
- * We place interactive tasks back into the active array, if possible.
- *
- * To guarantee that this does not starve expired tasks we ignore the
- * interactivity of a task if the first expired task had to wait more
- * than a 'reasonable' amount of time. This deadline timeout is
- * load-dependent, as the frequency of array switched decreases with
- * increasing number of running tasks. We also ignore the interactivity
- * if a better static_prio task has expired:
- */
-#define EXPIRED_STARVING(rq) \
-	((STARVATION_LIMIT && ((rq)->expired_timestamp && \
-		(jiffies - (rq)->expired_timestamp >= \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1))) || \
-			((rq)->curr->static_prio > (rq)->best_expired_prio))
-
-/*
  * Account user cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @hardirq_offset: the offset to subtract from hardirq_count()
@@ -2574,12 +2621,12 @@
 		return;
 	}
 
+	spin_lock(&rq->lock);
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array != rq->active) {
 		set_tsk_need_resched(p);
-		goto out;
+		goto out_unlock;
 	}
-	spin_lock(&rq->lock);
 	/*
 	 * The task was running during this tick - update the
 	 * time slice counter. Note: we do not update a thread's
@@ -2610,15 +2657,38 @@
 		p->first_time_slice = 0;
 
 		if (!rq->expired_timestamp)
-			rq->expired_timestamp = jiffies;
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+			rq->expired_timestamp = now;
+		if (!TASK_INTERACTIVE(p) || expired_starving(rq)) {
 			enqueue_task(p, rq->expired);
-			if (p->static_prio < rq->best_expired_prio)
-				rq->best_expired_prio = p->static_prio;
+			if (p->prio < rq->best_expired_prio)
+				rq->best_expired_prio = p->prio;
 		} else
 			enqueue_task(p, rq->active);
 	} else {
 		/*
+		 * If tasks in the expired array are starving, increase the
+		 * speed of the array switch.  If we do not, tasks which are
+		 * awakened on the expired array may suffer severe latency
+		 * due to cpu hogs using their full slice.  We don't want to
+		 * switch too fast however, because it may well be these very
+		 * tasks which were causing starvation to begin with.
+		 */
+		if (expired_starving(rq)) {
+			int limit = MIN_TIMESLICE + CURRENT_BONUS(p);
+			int runtime = now - p->timestamp;
+
+			runtime = NS_TO_JIFFIES(runtime);
+			if (runtime >= limit && p->time_slice >= limit) {
+
+				dequeue_task(p, rq->active);
+				enqueue_task(p, rq->expired);
+				set_tsk_need_resched(p);
+				if (p->prio < rq->best_expired_prio)
+					rq->best_expired_prio = p->prio;
+			}
+		}
+
+		/*
 		 * Prevent a too long timeslice allowing a task to monopolize
 		 * the CPU. We do this by splitting up the timeslice into
 		 * smaller pieces.
@@ -2634,10 +2704,9 @@
 		 * This only applies to tasks in the interactive
 		 * delta range with at least TIMESLICE_GRANULARITY to requeue.
 		 */
-		if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
+		else if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
 			p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
-			(p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
-			(p->array == rq->active)) {
+			(p->time_slice >= TIMESLICE_GRANULARITY(p))) {
 
 			requeue_task(p, rq->active);
 			set_tsk_need_resched(p);


--=-9aLHyHATMae8jBiG4Kbc
Content-Disposition: attachment; filename=sched_8_interactive_starvation2.diff
Content-Type: text/x-patch; name=sched_8_interactive_starvation2.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.16/kernel/sched.c-7.interactive_starvation	2006-03-27 06:11:01.000000000 +0200
+++ linux-2.6.16/kernel/sched.c	2006-03-30 10:50:46.000000000 +0200
@@ -371,7 +371,7 @@
 	 */
 	unsigned long nr_uninterruptible;
 
-	unsigned long expired_timestamp;
+	unsigned long long expired_timestamp;
 	unsigned long long timestamp_last_tick;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
@@ -839,7 +839,7 @@
 	/*
 	 * It's time to switch arrays.
 	 */
-	if (jiffies - rq->expired_timestamp >= limit)
+	if (jiffies - NS64_TO_JIFFIES(rq->expired_timestamp) >= limit)
 		return 1;
 
 	/*
@@ -860,8 +860,12 @@
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
 	prio_array_t *array = rq->active;
-	if (unlikely(expired_starving(rq)))
+	if (unlikely(expired_starving(rq) && !rt_task(p) &&
+			p->last_ran > rq->expired_timestamp)) {
 		array = rq->expired;
+		if (p->prio < rq->best_expired_prio)
+			rq->best_expired_prio = p->prio;
+	}
 	enqueue_task(p, array);
 	rq->nr_running++;
 }
@@ -2880,12 +2884,12 @@
 		return;
 	}
 
+	spin_lock(&rq->lock);
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array != rq->active) {
 		set_tsk_need_resched(p);
-		goto out;
+		goto out_unlock;
 	}
-	spin_lock(&rq->lock);
 	/*
 	 * The task was running during this tick - update the
 	 * time slice counter. Note: we do not update a thread's
@@ -2921,15 +2925,38 @@
 		p->prio = effective_prio(p);
 
 		if (!rq->expired_timestamp)
-			rq->expired_timestamp = jiffies;
+			rq->expired_timestamp = now;
 		if (!TASK_INTERACTIVE(p) || expired_starving(rq)) {
 			enqueue_task(p, rq->expired);
-			if (p->static_prio < rq->best_expired_prio)
-				rq->best_expired_prio = p->static_prio;
+			if (p->prio < rq->best_expired_prio)
+				rq->best_expired_prio = p->prio;
 		} else
 			enqueue_task(p, rq->active);
 	} else {
 		/*
+		 * If tasks in the expired array are starving, increase the
+		 * speed of the array switch.  If we do not, tasks which are
+		 * awakened on the expired array may suffer severe latency
+		 * due to cpu hogs using their full slice.  We don't want to
+		 * switch too fast however, because it may well be these very
+		 * tasks which were causing starvation to begin with.
+		 */
+		if (expired_starving(rq)) {
+			int limit = MIN_TIMESLICE + CURRENT_BONUS(p);
+			int runtime = now - p->timestamp;
+
+			runtime = NS_TO_JIFFIES(runtime);
+			if (runtime >= limit && p->time_slice >= limit) {
+
+				dequeue_task(p, rq->active);
+				enqueue_task(p, rq->expired);
+				set_tsk_need_resched(p);
+				if (p->prio < rq->best_expired_prio)
+					rq->best_expired_prio = p->prio;
+			}
+		}
+
+		/*
 		 * Prevent a too long timeslice allowing a task to monopolize
 		 * the CPU. We do this by splitting up the timeslice into
 		 * smaller pieces.
@@ -2945,10 +2972,9 @@
 		 * This only applies to tasks in the interactive
 		 * delta range with at least TIMESLICE_GRANULARITY to requeue.
 		 */
-		if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
+		else if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
 			p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
-			(p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
-			(p->array == rq->active)) {
+			(p->time_slice >= TIMESLICE_GRANULARITY(p))) {
 
 			requeue_task(p, rq->active);
 			set_tsk_need_resched(p);

--=-9aLHyHATMae8jBiG4Kbc--

