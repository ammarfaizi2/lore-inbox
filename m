Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbWFCHnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbWFCHnq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 03:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbWFCHnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 03:43:46 -0400
Received: from mga03.intel.com ([143.182.124.21]:604 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751317AbWFCHnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 03:43:45 -0400
X-IronPort-AV: i="4.05,205,1146466800"; 
   d="scan'208"; a="45444915:sNHT45729607"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Chris Mason'" <mason@suse.com>, "'Con Kolivas'" <kernel@kolivas.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: [patch] fix smt nice lock contention and optimization
Date: Sat, 3 Jun 2006 00:43:45 -0700
Message-ID: <000701c686e1$71f2f7f0$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaG4XFuj5vOta9IRZWhIpfSyp31rA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, final rolled up patch with everyone's changes. I fixed one bug
introduced by Con's earlier patch that there is an unpaired
spin_trylock/spin_unlock in the for loop of dependent_sleeper().
Chris, Con, Nick - please review and provide your signed-off-by line.
Andrew - please consider for -mm inclusion.  Thanks.


[patch] fix smt nice lock contention and optimization

Initial report and lock contention fix from Chris Mason:

Recent benchmarks showed some performance regressions between 2.6.16 and 
2.6.5.  We tracked down one of the regressions to lock contention in schedule 
heavy workloads (~70,000 context switches per second)

kernel/sched.c:dependent_sleeper() was responsible for most of the lock 
contention, hammering on the run queue locks.  The patch below is more of 
a discussion point than a suggested fix (although it does reduce lock 
contention significantly).  The dependent_sleeper code looks very expensive 
to me, especially for using a spinlock to bounce control between two different 
siblings in the same cpu.

It is further optimized:

* perform dependent_sleeper check after next task is determined
* convert wake_sleeping_dependent to use trylock
* skip smt runqueue check if trylock fails
* optimize double_rq_lock now that smt nice is converted to trylock
* early exit in searching first SD_SHARE_CPUPOWER domain
* speedup fast path of dependent_sleeper


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
---

 sched.c |  168 ++++++++++++++++++----------------------------------------------
 1 files changed, 48 insertions(+), 120 deletions(-)

diff -Nurp 2.6.17-rc5-mm2/kernel/sched.c ken/kernel/sched.c
--- 2.6.17-rc5-mm2/kernel/sched.c	2006-06-02 22:34:04.000000000 -0700
+++ ken/kernel/sched.c	2006-06-02 22:52:28.000000000 -0700
@@ -248,7 +248,6 @@ struct runqueue {
 
 	task_t *migration_thread;
 	struct list_head migration_queue;
-	int cpu;
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
@@ -1887,9 +1886,6 @@ unsigned long nr_active(void)
 /*
  * double_rq_lock - safely lock two runqueues
  *
- * We must take them in cpu order to match code in
- * dependent_sleeper and wake_dependent_sleeper.
- *
  * Note this does not disable interrupts like task_rq_lock,
  * you need to do so manually before calling.
  */
@@ -1901,7 +1897,7 @@ static void double_rq_lock(runqueue_t *r
 		spin_lock(&rq1->lock);
 		__acquire(rq2->lock);	/* Fake it out ;) */
 	} else {
-		if (rq1->cpu < rq2->cpu) {
+		if (rq1 < rq2) {
 			spin_lock(&rq1->lock);
 			spin_lock(&rq2->lock);
 		} else {
@@ -1937,7 +1933,7 @@ static void double_lock_balance(runqueue
 	__acquires(this_rq->lock)
 {
 	if (unlikely(!spin_trylock(&busiest->lock))) {
-		if (busiest->cpu < this_rq->cpu) {
+		if (busiest < this_rq) {
 			spin_unlock_non_nested(&this_rq->lock);
 			spin_lock(&busiest->lock);
 			spin_lock(&this_rq->lock);
@@ -2969,48 +2965,33 @@ static inline void wakeup_busy_runqueue(
 		resched_task(rq->idle);
 }
 
-static void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
+/*
+ * Called with interrupt disabled and this_rq's runqueue locked.
+ */
+static void wake_sleeping_dependent(int this_cpu)
 {
 	struct sched_domain *tmp, *sd = NULL;
-	cpumask_t sibling_map;
 	int i;
 
 	for_each_domain(this_cpu, tmp)
-		if (tmp->flags & SD_SHARE_CPUPOWER)
+		if (tmp->flags & SD_SHARE_CPUPOWER) {
 			sd = tmp;
-
+			break;
+		}
 	if (!sd)
 		return;
 
-	/*
-	 * Unlock the current runqueue because we have to lock in
-	 * CPU order to avoid deadlocks. Caller knows that we might
-	 * unlock. We keep IRQs disabled.
-	 */
-	spin_unlock(&this_rq->lock);
-
-	sibling_map = sd->span;
-
-	for_each_cpu_mask(i, sibling_map)
-		spin_lock(&cpu_rq(i)->lock);
-	/*
-	 * We clear this CPU from the mask. This both simplifies the
-	 * inner loop and keps this_rq locked when we exit:
-	 */
-	cpu_clear(this_cpu, sibling_map);
-
-	for_each_cpu_mask(i, sibling_map) {
+	for_each_cpu_mask(i, sd->span) {
 		runqueue_t *smt_rq = cpu_rq(i);
 
+		if (i == this_cpu)
+			continue;
+		if (unlikely(!spin_trylock(&smt_rq->lock)))
+			continue;
+
 		wakeup_busy_runqueue(smt_rq);
+		spin_unlock(&smt_rq->lock);
 	}
-
-	for_each_cpu_mask(i, sibling_map)
-		spin_unlock_non_nested(&cpu_rq(i)->lock);
-	/*
-	 * We exit with this_cpu's rq still held and IRQs
-	 * still disabled:
-	 */
 }
 
 /*
@@ -3023,52 +3004,44 @@ static inline unsigned long smt_slice(ta
 	return p->time_slice * (100 - sd->per_cpu_gain) / 100;
 }
 
-static int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
+/*
+ * To minimise lock contention and not have to drop this_rq's runlock we only
+ * trylock the sibling runqueues and bypass those runqueues if we fail to
+ * acquire their lock. As we only trylock the normal locking order does not
+ * need to be obeyed.
+ */
+static int dependent_sleeper(int this_cpu, runqueue_t *this_rq, task_t *p)
 {
 	struct sched_domain *tmp, *sd = NULL;
-	cpumask_t sibling_map;
-	prio_array_t *array;
 	int ret = 0, i;
-	task_t *p;
+
+	/* kernel/rt threads do not participate in dependent sleeping */
+	if (!p->mm || rt_task(p))
+		return 0;
 
 	for_each_domain(this_cpu, tmp)
-		if (tmp->flags & SD_SHARE_CPUPOWER)
+		if (tmp->flags & SD_SHARE_CPUPOWER) {
 			sd = tmp;
-
+			break;
+		}
 	if (!sd)
 		return 0;
 
-	/*
-	 * The same locking rules and details apply as for
-	 * wake_sleeping_dependent():
-	 */
-	spin_unlock_non_nested(&this_rq->lock);
-	sibling_map = sd->span;
-	for_each_cpu_mask(i, sibling_map)
-		spin_lock(&cpu_rq(i)->lock);
-	cpu_clear(this_cpu, sibling_map);
+	for_each_cpu_mask(i, sd->span) {
+		runqueue_t *smt_rq;
+		task_t *smt_curr;
 
-	/*
-	 * Establish next task to be run - it might have gone away because
-	 * we released the runqueue lock above:
-	 */
-	if (!this_rq->nr_running)
-		goto out_unlock;
-	array = this_rq->active;
-	if (!array->nr_active)
-		array = this_rq->expired;
-	BUG_ON(!array->nr_active);
+		if (i == this_cpu)
+			continue;
 
-	p = list_entry(array->queue[sched_find_first_bit(array->bitmap)].next,
-		task_t, run_list);
+		smt_rq = cpu_rq(i);
+		if (unlikely(!spin_trylock(&smt_rq->lock)))
+			continue;
 
-	for_each_cpu_mask(i, sibling_map) {
-		runqueue_t *smt_rq = cpu_rq(i);
-		task_t *smt_curr = smt_rq->curr;
+		smt_curr = smt_rq->curr;
 
-		/* Kernel threads do not participate in dependent sleeping */
-		if (!p->mm || !smt_curr->mm || rt_task(p))
-			goto check_smt_task;
+		if (!smt_curr->mm)
+			goto unlock;
 
 		/*
 		 * If a user task with lower static priority than the
@@ -3091,44 +3064,17 @@ static int dependent_sleeper(int this_cp
 				!TASK_PREEMPTS_CURR(p, smt_rq) &&
 				smt_slice(smt_curr, sd) > task_timeslice(p))
 					ret = 1;
-
-check_smt_task:
-		if ((!smt_curr->mm && smt_curr != smt_rq->idle) ||
-			rt_task(smt_curr))
-				continue;
-		if (!p->mm) {
-			wakeup_busy_runqueue(smt_rq);
-			continue;
-		}
-
-		/*
-		 * Reschedule a lower priority task on the SMT sibling for
-		 * it to be put to sleep, or wake it up if it has been put to
-		 * sleep for priority reasons to see if it should run now.
-		 */
-		if (rt_task(p)) {
-			if ((jiffies % DEF_TIMESLICE) >
-				(sd->per_cpu_gain * DEF_TIMESLICE / 100))
-					resched_task(smt_curr);
-		} else {
-			if (TASK_PREEMPTS_CURR(p, smt_rq) &&
-				smt_slice(p, sd) > task_timeslice(smt_curr))
-					resched_task(smt_curr);
-			else
-				wakeup_busy_runqueue(smt_rq);
-		}
+unlock:
+		spin_unlock(&smt_rq->lock);
 	}
-out_unlock:
-	for_each_cpu_mask(i, sibling_map)
-		spin_unlock_non_nested(&cpu_rq(i)->lock);
 	return ret;
 }
 #else
-static inline void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
+static inline void wake_sleeping_dependent(int this_cpu)
 {
 }
 
-static inline int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
+static inline int dependent_sleeper(int this_cpu, runqueue_t *this_rq, task_t *p)
 {
 	return 0;
 }
@@ -3255,32 +3201,13 @@ need_resched_nonpreemptible:
 
 	cpu = smp_processor_id();
 	if (unlikely(!rq->nr_running)) {
-go_idle:
 		idle_balance(cpu, rq);
 		if (!rq->nr_running) {
 			next = rq->idle;
 			rq->expired_timestamp = 0;
-			wake_sleeping_dependent(cpu, rq);
-			/*
-			 * wake_sleeping_dependent() might have released
-			 * the runqueue, so break out if we got new
-			 * tasks meanwhile:
-			 */
-			if (!rq->nr_running)
-				goto switch_tasks;
-		}
-	} else {
-		if (dependent_sleeper(cpu, rq)) {
-			next = rq->idle;
+			wake_sleeping_dependent(cpu);
 			goto switch_tasks;
 		}
-		/*
-		 * dependent_sleeper() releases and reacquires the runqueue
-		 * lock, hence go into the idle loop if the rq went
-		 * empty meanwhile:
-		 */
-		if (unlikely(!rq->nr_running))
-			goto go_idle;
 	}
 
 	array = rq->active;
@@ -3318,6 +3245,8 @@ go_idle:
 		}
 	}
 	next->sleep_type = SLEEP_NORMAL;
+	if (dependent_sleeper(cpu, rq, next))
+		next = rq->idle;
 switch_tasks:
 	if (next == rq->idle)
 		schedstat_inc(rq, sched_goidle);
@@ -6666,7 +6595,6 @@ void __init sched_init(void)
 		rq->push_cpu = 0;
 		rq->migration_thread = NULL;
 		INIT_LIST_HEAD(&rq->migration_queue);
-		rq->cpu = i;
 #endif
 		atomic_set(&rq->nr_iowait, 0);
 
