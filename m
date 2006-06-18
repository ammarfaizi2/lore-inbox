Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWFRH2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWFRH2b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWFRH2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:28:31 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:30620 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932114AbWFRH2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:28:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][2/29] sched-revise_smt_nice_locking
Date: Sun, 18 Jun 2006 17:28:27 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 10153
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181728.27706.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Con Kolivas <kernel@kolivas.org>
Signed-off-by: Nick Piggin <npiggin@suse.de>
Signed-off-by: Chris Mason <mason@suse.com>

---
 kernel/sched.c |  175 ++++++++++++++++++---------------------------------------
 1 files changed, 57 insertions(+), 118 deletions(-)

Index: linux-ck-dev/kernel/sched.c
===================================================================
--- linux-ck-dev.orig/kernel/sched.c	2006-06-18 15:21:31.000000000 +1000
+++ linux-ck-dev/kernel/sched.c	2006-06-18 15:21:45.000000000 +1000
@@ -1157,9 +1157,10 @@ static int sched_balance_self(int cpu, i
 	struct task_struct *t = current;
 	struct sched_domain *tmp, *sd = NULL;
 
-	for_each_domain(cpu, tmp)
+	for_each_domain(cpu, tmp) {
 		if (tmp->flags & flag)
 			sd = tmp;
+	}
 
 	while (sd) {
 		cpumask_t span;
@@ -1790,7 +1791,7 @@ static void double_rq_lock(runqueue_t *r
 		spin_lock(&rq1->lock);
 		__acquire(rq2->lock);	/* Fake it out ;) */
 	} else {
-		if (rq1->cpu < rq2->cpu) {
+		if (rq1 < rq2) {
 			spin_lock(&rq1->lock);
 			spin_lock(&rq2->lock);
 		} else {
@@ -1826,7 +1827,7 @@ static void double_lock_balance(runqueue
 	__acquires(this_rq->lock)
 {
 	if (unlikely(!spin_trylock(&busiest->lock))) {
-		if (busiest->cpu < this_rq->cpu) {
+		if (busiest < this_rq) {
 			spin_unlock(&this_rq->lock);
 			spin_lock(&busiest->lock);
 			spin_lock(&this_rq->lock);
@@ -2521,10 +2522,11 @@ static void active_load_balance(runqueue
 	double_lock_balance(busiest_rq, target_rq);
 
 	/* Search for an sd spanning us and the target CPU. */
-	for_each_domain(target_cpu, sd)
+	for_each_domain(target_cpu, sd) {
 		if ((sd->flags & SD_LOAD_BALANCE) &&
 			cpu_isset(busiest_cpu, sd->span))
 				break;
+	}
 
 	if (unlikely(sd == NULL))
 		goto out;
@@ -2861,48 +2863,35 @@ static inline void wakeup_busy_runqueue(
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
 
-	for_each_domain(this_cpu, tmp)
-		if (tmp->flags & SD_SHARE_CPUPOWER)
+	for_each_domain(this_cpu, tmp) {
+		if (tmp->flags & SD_SHARE_CPUPOWER) {
 			sd = tmp;
+			break;
+		}
+	}
 
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
-		spin_unlock(&cpu_rq(i)->lock);
-	/*
-	 * We exit with this_cpu's rq still held and IRQs
-	 * still disabled:
-	 */
 }
 
 /*
@@ -2915,52 +2904,46 @@ static inline unsigned long smt_slice(ta
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
 
-	for_each_domain(this_cpu, tmp)
-		if (tmp->flags & SD_SHARE_CPUPOWER)
+	/* kernel/rt threads do not participate in dependent sleeping */
+	if (!p->mm || rt_task(p))
+		return 0;
+
+	for_each_domain(this_cpu, tmp) {
+		if (tmp->flags & SD_SHARE_CPUPOWER) {
 			sd = tmp;
+			break;
+		}
+	}
 
 	if (!sd)
 		return 0;
 
-	/*
-	 * The same locking rules and details apply as for
-	 * wake_sleeping_dependent():
-	 */
-	spin_unlock(&this_rq->lock);
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
@@ -2984,43 +2967,17 @@ static int dependent_sleeper(int this_cp
 				smt_slice(smt_curr, sd) > task_timeslice(p))
 					ret = 1;
 
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
-		spin_unlock(&cpu_rq(i)->lock);
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
@@ -3142,32 +3099,13 @@ need_resched_nonpreemptible:
 
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
@@ -3205,6 +3143,8 @@ go_idle:
 		}
 	}
 	next->sleep_type = SLEEP_NORMAL;
+	if (dependent_sleeper(cpu, rq, next))
+		next = rq->idle;
 switch_tasks:
 	if (next == rq->idle)
 		schedstat_inc(rq, sched_goidle);
@@ -6306,7 +6246,6 @@ void __init sched_init(void)
 		rq->push_cpu = 0;
 		rq->migration_thread = NULL;
 		INIT_LIST_HEAD(&rq->migration_queue);
-		rq->cpu = i;
 #endif
 		atomic_set(&rq->nr_iowait, 0);
 
@@ -6368,7 +6307,7 @@ void normalize_rt_tasks(void)
 	runqueue_t *rq;
 
 	read_lock_irq(&tasklist_lock);
-	for_each_process (p) {
+	for_each_process(p) {
 		if (!rt_task(p))
 			continue;
 

-- 
-ck
