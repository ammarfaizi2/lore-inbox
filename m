Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWFRH1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWFRH1M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWFRH1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:27:12 -0400
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:50145 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932112AbWFRH1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:27:10 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][1/29] sched-implement-smpnice-2.6.17
Date: Sun, 18 Jun 2006 17:27:06 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 24151
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181727.06932.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To aid in avoiding the subversion of "niceness" due to uneven distribution
of tasks with abnormal "nice" values across CPUs the contribution that
each task makes to its run queue's load is weighted according to its
scheduling class and "nice" value.  For SCHED_NORMAL tasks this is just a
scaled version of the new time slice allocation that they receive on time
slice expiry etc.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 include/linux/sched.h |    8 -
 kernel/sched.c        |  313 +++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 253 insertions(+), 68 deletions(-)

Index: linux-ck-dev/include/linux/sched.h
===================================================================
--- linux-ck-dev.orig/include/linux/sched.h	2006-06-18 15:20:15.000000000 +1000
+++ linux-ck-dev/include/linux/sched.h	2006-06-18 15:21:31.000000000 +1000
@@ -102,6 +102,7 @@ extern unsigned long nr_running(void);
 extern unsigned long nr_uninterruptible(void);
 extern unsigned long nr_active(void);
 extern unsigned long nr_iowait(void);
+extern unsigned long weighted_cpuload(const int cpu);
 
 #include <linux/time.h>
 #include <linux/param.h>
@@ -547,9 +548,9 @@ enum idle_type
 /*
  * sched-domains (multiprocessor balancing) declarations:
  */
-#ifdef CONFIG_SMP
 #define SCHED_LOAD_SCALE	128UL	/* increase resolution of load */
 
+#ifdef CONFIG_SMP
 #define SD_LOAD_BALANCE		1	/* Do load balancing on this domain. */
 #define SD_BALANCE_NEWIDLE	2	/* Balance when about to become idle */
 #define SD_BALANCE_EXEC		4	/* Balance on exec */
@@ -702,9 +703,12 @@ struct task_struct {
 
 	int lock_depth;		/* BKL lock depth */
 
-#if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
+#ifdef CONFIG_SMP
+#ifdef __ARCH_WANT_UNLOCKED_CTXSW
 	int oncpu;
 #endif
+#endif
+	int load_weight;	/* for niceness load balancing purposes */
 	int prio, static_prio;
 	struct list_head run_list;
 	prio_array_t *array;
Index: linux-ck-dev/kernel/sched.c
===================================================================
--- linux-ck-dev.orig/kernel/sched.c	2006-06-18 15:20:15.000000000 +1000
+++ linux-ck-dev/kernel/sched.c	2006-06-18 15:21:31.000000000 +1000
@@ -168,15 +168,21 @@
  */
 
 #define SCALE_PRIO(x, prio) \
-	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO/2), MIN_TIMESLICE)
+	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO / 2), MIN_TIMESLICE)
 
-static unsigned int task_timeslice(task_t *p)
+static unsigned int static_prio_timeslice(int static_prio)
 {
-	if (p->static_prio < NICE_TO_PRIO(0))
-		return SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
+	if (static_prio < NICE_TO_PRIO(0))
+		return SCALE_PRIO(DEF_TIMESLICE * 4, static_prio);
 	else
-		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
+		return SCALE_PRIO(DEF_TIMESLICE, static_prio);
 }
+
+static inline unsigned int task_timeslice(task_t *p)
+{
+	return static_prio_timeslice(p->static_prio);
+}
+
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
 
@@ -209,6 +215,7 @@ struct runqueue {
 	 * remote CPUs use both these fields when doing load calculation.
 	 */
 	unsigned long nr_running;
+	unsigned long raw_weighted_load;
 #ifdef CONFIG_SMP
 	unsigned long cpu_load[3];
 #endif
@@ -665,6 +672,68 @@ static int effective_prio(task_t *p)
 }
 
 /*
+ * To aid in avoiding the subversion of "niceness" due to uneven distribution
+ * of tasks with abnormal "nice" values across CPUs the contribution that
+ * each task makes to its run queue's load is weighted according to its
+ * scheduling class and "nice" value.  For SCHED_NORMAL tasks this is just a
+ * scaled version of the new time slice allocation that they receive on time
+ * slice expiry etc.
+ */
+
+/*
+ * Assume: static_prio_timeslice(NICE_TO_PRIO(0)) == DEF_TIMESLICE
+ * If static_prio_timeslice() is ever changed to break this assumption then
+ * this code will need modification
+ */
+#define TIME_SLICE_NICE_ZERO DEF_TIMESLICE
+#define LOAD_WEIGHT(lp) \
+	(((lp) * SCHED_LOAD_SCALE) / TIME_SLICE_NICE_ZERO)
+#define PRIO_TO_LOAD_WEIGHT(prio) \
+	LOAD_WEIGHT(static_prio_timeslice(prio))
+#define RTPRIO_TO_LOAD_WEIGHT(rp) \
+	(PRIO_TO_LOAD_WEIGHT(MAX_RT_PRIO) + LOAD_WEIGHT(rp))
+
+static void set_load_weight(task_t *p)
+{
+	if (rt_task(p)) {
+#ifdef CONFIG_SMP
+		if (p == task_rq(p)->migration_thread)
+			/*
+			 * The migration thread does the actual balancing.
+			 * Giving its load any weight will skew balancing
+			 * adversely.
+			 */
+			p->load_weight = 0;
+		else
+#endif
+			p->load_weight = RTPRIO_TO_LOAD_WEIGHT(p->rt_priority);
+	} else
+		p->load_weight = PRIO_TO_LOAD_WEIGHT(p->static_prio);
+}
+
+static inline void inc_raw_weighted_load(runqueue_t *rq, const task_t *p)
+{
+	rq->raw_weighted_load += p->load_weight;
+}
+
+static inline void dec_raw_weighted_load(runqueue_t *rq, const task_t *p)
+{
+	rq->raw_weighted_load -= p->load_weight;
+}
+
+static inline void inc_nr_running(task_t *p, runqueue_t *rq)
+{
+	rq->nr_running++;
+	inc_raw_weighted_load(rq, p);
+}
+
+static inline void dec_nr_running(task_t *p, runqueue_t *rq)
+{
+	rq->nr_running--;
+	dec_raw_weighted_load(rq, p);
+}
+
+/*
  * __activate_task - move a task to the runqueue.
  */
 static void __activate_task(task_t *p, runqueue_t *rq)
@@ -674,7 +743,7 @@ static void __activate_task(task_t *p, r
 	if (batch_task(p))
 		target = rq->expired;
 	enqueue_task(p, target);
-	rq->nr_running++;
+	inc_nr_running(p, rq);
 }
 
 /*
@@ -683,7 +752,7 @@ static void __activate_task(task_t *p, r
 static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task_head(p, rq->active);
-	rq->nr_running++;
+	inc_nr_running(p, rq);
 }
 
 static int recalc_task_prio(task_t *p, unsigned long long now)
@@ -805,7 +874,7 @@ static void activate_task(task_t *p, run
  */
 static void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	rq->nr_running--;
+	dec_nr_running(p, rq);
 	dequeue_task(p, p->array);
 	p->array = NULL;
 }
@@ -855,6 +924,12 @@ inline int task_curr(const task_t *p)
 	return cpu_curr(task_cpu(p)) == p;
 }
 
+/* Used instead of source_load when we know the type == 0 */
+unsigned long weighted_cpuload(const int cpu)
+{
+	return cpu_rq(cpu)->raw_weighted_load;
+}
+
 #ifdef CONFIG_SMP
 typedef struct {
 	struct list_head list;
@@ -944,7 +1019,8 @@ void kick_process(task_t *p)
 }
 
 /*
- * Return a low guess at the load of a migration-source cpu.
+ * Return a low guess at the load of a migration-source cpu weighted
+ * according to the scheduling class and "nice" value.
  *
  * We want to under-estimate the load of migration sources, to
  * balance conservatively.
@@ -952,24 +1028,36 @@ void kick_process(task_t *p)
 static inline unsigned long source_load(int cpu, int type)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long load_now = rq->nr_running * SCHED_LOAD_SCALE;
+
 	if (type == 0)
-		return load_now;
+		return rq->raw_weighted_load;
 
-	return min(rq->cpu_load[type-1], load_now);
+	return min(rq->cpu_load[type-1], rq->raw_weighted_load);
 }
 
 /*
- * Return a high guess at the load of a migration-target cpu
+ * Return a high guess at the load of a migration-target cpu weighted
+ * according to the scheduling class and "nice" value.
  */
 static inline unsigned long target_load(int cpu, int type)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long load_now = rq->nr_running * SCHED_LOAD_SCALE;
+
 	if (type == 0)
-		return load_now;
+		return rq->raw_weighted_load;
+
+	return max(rq->cpu_load[type-1], rq->raw_weighted_load);
+}
+
+/*
+ * Return the average load per task on the cpu's run queue
+ */
+static inline unsigned long cpu_avg_load_per_task(int cpu)
+{
+	runqueue_t *rq = cpu_rq(cpu);
+	unsigned long n = rq->nr_running;
 
-	return max(rq->cpu_load[type-1], load_now);
+	return n ?  rq->raw_weighted_load / n : SCHED_LOAD_SCALE;
 }
 
 /*
@@ -1042,7 +1130,7 @@ find_idlest_cpu(struct sched_group *grou
 	cpus_and(tmp, group->cpumask, p->cpus_allowed);
 
 	for_each_cpu_mask(i, tmp) {
-		load = source_load(i, 0);
+		load = weighted_cpuload(i);
 
 		if (load < min_load || (load == min_load && i == this_cpu)) {
 			min_load = load;
@@ -1221,17 +1309,19 @@ static int try_to_wake_up(task_t *p, uns
 
 		if (this_sd->flags & SD_WAKE_AFFINE) {
 			unsigned long tl = this_load;
+			unsigned long tl_per_task = cpu_avg_load_per_task(this_cpu);
+
 			/*
 			 * If sync wakeup then subtract the (maximum possible)
 			 * effect of the currently running task from the load
 			 * of the current CPU:
 			 */
 			if (sync)
-				tl -= SCHED_LOAD_SCALE;
+				tl -= current->load_weight;
 
 			if ((tl <= load &&
-				tl + target_load(cpu, idx) <= SCHED_LOAD_SCALE) ||
-				100*(tl + SCHED_LOAD_SCALE) <= imbalance*load) {
+				tl + target_load(cpu, idx) <= tl_per_task) ||
+				100*(tl + p->load_weight) <= imbalance*load) {
 				/*
 				 * This domain has SD_WAKE_AFFINE and
 				 * p is cache cold in this domain, and
@@ -1430,7 +1520,7 @@ void fastcall wake_up_new_task(task_t *p
 				list_add_tail(&p->run_list, &current->run_list);
 				p->array = current->array;
 				p->array->nr_active++;
-				rq->nr_running++;
+				inc_nr_running(p, rq);
 			}
 			set_need_resched();
 		} else
@@ -1799,9 +1889,9 @@ void pull_task(runqueue_t *src_rq, prio_
 	       runqueue_t *this_rq, prio_array_t *this_array, int this_cpu)
 {
 	dequeue_task(p, src_array);
-	src_rq->nr_running--;
+	dec_nr_running(p, src_rq);
 	set_task_cpu(p, this_cpu);
-	this_rq->nr_running++;
+	inc_nr_running(p, this_rq);
 	enqueue_task(p, this_array);
 	p->timestamp = (p->timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;
@@ -1848,26 +1938,42 @@ int can_migrate_task(task_t *p, runqueue
 	return 1;
 }
 
+#define rq_best_prio(rq) min((rq)->curr->prio, (rq)->best_expired_prio)
 /*
- * move_tasks tries to move up to max_nr_move tasks from busiest to this_rq,
- * as part of a balancing operation within "domain". Returns the number of
- * tasks moved.
+ * move_tasks tries to move up to max_nr_move tasks and max_load_move weighted
+ * load from busiest to this_rq, as part of a balancing operation within
+ * "domain". Returns the number of tasks moved.
  *
  * Called with both runqueues locked.
  */
 static int move_tasks(runqueue_t *this_rq, int this_cpu, runqueue_t *busiest,
-		      unsigned long max_nr_move, struct sched_domain *sd,
-		      enum idle_type idle, int *all_pinned)
+		      unsigned long max_nr_move, unsigned long max_load_move,
+		      struct sched_domain *sd, enum idle_type idle,
+		      int *all_pinned)
 {
 	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
-	int idx, pulled = 0, pinned = 0;
+	int idx, pulled = 0, pinned = 0, this_best_prio, busiest_best_prio;
+	int busiest_best_prio_seen;
+	int skip_for_load; /* skip the task based on weighted load issues */
+	long rem_load_move;
 	task_t *tmp;
 
-	if (max_nr_move == 0)
+	if (max_nr_move == 0 || max_load_move == 0)
 		goto out;
 
+	rem_load_move = max_load_move;
 	pinned = 1;
+	this_best_prio = rq_best_prio(this_rq);
+	busiest_best_prio = rq_best_prio(busiest);
+	/*
+	 * Enable handling of the case where there is more than one task
+	 * with the best priority.   If the current running task is one
+	 * of those with prio==busiest_best_prio we know it won't be moved
+	 * and therefore it's safe to override the skip (based on load) of
+	 * any task we find with that prio.
+	 */
+	busiest_best_prio_seen = busiest_best_prio == busiest->curr->prio;
 
 	/*
 	 * We first consider expired tasks. Those will likely not be
@@ -1907,7 +2013,17 @@ skip_queue:
 
 	curr = curr->prev;
 
-	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
+	/*
+	 * To help distribute high priority tasks accross CPUs we don't
+	 * skip a task if it will be the highest priority task (i.e. smallest
+	 * prio value) on its new queue regardless of its load weight
+	 */
+	skip_for_load = tmp->load_weight > rem_load_move;
+	if (skip_for_load && idx < this_best_prio)
+		skip_for_load = !busiest_best_prio_seen && idx == busiest_best_prio;
+	if (skip_for_load ||
+	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
+		busiest_best_prio_seen |= idx == busiest_best_prio;
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -1921,9 +2037,15 @@ skip_queue:
 
 	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
 	pulled++;
+	rem_load_move -= tmp->load_weight;
 
-	/* We only want to steal up to the prescribed number of tasks. */
-	if (pulled < max_nr_move) {
+	/*
+	 * We only want to steal up to the prescribed number of tasks
+	 * and the prescribed amount of weighted load.
+	 */
+	if (pulled < max_nr_move && rem_load_move > 0) {
+		if (idx < this_best_prio)
+			this_best_prio = idx;
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -1944,7 +2066,7 @@ out:
 
 /*
  * find_busiest_group finds and returns the busiest CPU group within the
- * domain. It calculates and returns the number of tasks which should be
+ * domain. It calculates and returns the amount of weighted load which should be
  * moved to restore balance via the imbalance parameter.
  */
 static struct sched_group *
@@ -1954,9 +2076,13 @@ find_busiest_group(struct sched_domain *
 	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
 	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
 	unsigned long max_pull;
+	unsigned long busiest_load_per_task, busiest_nr_running;
+	unsigned long this_load_per_task, this_nr_running;
 	int load_idx;
 
 	max_load = this_load = total_load = total_pwr = 0;
+	busiest_load_per_task = busiest_nr_running = 0;
+	this_load_per_task = this_nr_running = 0;
 	if (idle == NOT_IDLE)
 		load_idx = sd->busy_idx;
 	else if (idle == NEWLY_IDLE)
@@ -1968,13 +2094,17 @@ find_busiest_group(struct sched_domain *
 		unsigned long load;
 		int local_group;
 		int i;
+		unsigned long sum_nr_running, sum_weighted_load;
+		unsigned int nr_loaded_cpus = 0; /* where nr_running > 1 */
 
 		local_group = cpu_isset(this_cpu, group->cpumask);
 
 		/* Tally up the load of all CPUs in the group */
-		avg_load = 0;
+		sum_weighted_load = sum_nr_running = avg_load = 0;
 
 		for_each_cpu_mask(i, group->cpumask) {
+			runqueue_t *rq = cpu_rq(i);
+
 			if (*sd_idle && !idle_cpu(i))
 				*sd_idle = 0;
 
@@ -1985,6 +2115,10 @@ find_busiest_group(struct sched_domain *
 				load = source_load(i, load_idx);
 
 			avg_load += load;
+			sum_nr_running += rq->nr_running;
+			if (rq->nr_running > 1)
+				++nr_loaded_cpus;
+			sum_weighted_load += rq->raw_weighted_load;
 		}
 
 		total_load += avg_load;
@@ -1996,14 +2130,19 @@ find_busiest_group(struct sched_domain *
 		if (local_group) {
 			this_load = avg_load;
 			this = group;
-		} else if (avg_load > max_load) {
+			this_nr_running = sum_nr_running;
+			this_load_per_task = sum_weighted_load;
+		} else if (avg_load > max_load &&
+			   sum_nr_running > group->cpu_power / SCHED_LOAD_SCALE) {
 			max_load = avg_load;
 			busiest = group;
+			busiest_nr_running = sum_nr_running;
+			busiest_load_per_task = sum_weighted_load;
 		}
 		group = group->next;
 	} while (group != sd->groups);
 
-	if (!busiest || this_load >= max_load || max_load <= SCHED_LOAD_SCALE)
+	if (!busiest || this_load >= max_load || busiest_nr_running == 0)
 		goto out_balanced;
 
 	avg_load = (SCHED_LOAD_SCALE * total_load) / total_pwr;
@@ -2012,6 +2151,7 @@ find_busiest_group(struct sched_domain *
 			100*max_load <= sd->imbalance_pct*this_load)
 		goto out_balanced;
 
+	busiest_load_per_task /= busiest_nr_running;
 	/*
 	 * We're trying to get all the cpus to the average_load, so we don't
 	 * want to push ourselves above the average load, nor do we wish to
@@ -2023,21 +2163,50 @@ find_busiest_group(struct sched_domain *
 	 * by pulling tasks to us.  Be careful of negative numbers as they'll
 	 * appear as very large values with unsigned longs.
 	 */
+	if (max_load <= busiest_load_per_task)
+		goto out_balanced;
+
+	/*
+	 * In the presence of smp nice balancing, certain scenarios can have
+	 * max load less than avg load(as we skip the groups at or below
+	 * its cpu_power, while calculating max_load..)
+	 */
+	if (max_load < avg_load) {
+		*imbalance = 0;
+		goto small_imbalance;
+	}
 
 	/* Don't want to pull so many tasks that a group would go idle */
-	max_pull = min(max_load - avg_load, max_load - SCHED_LOAD_SCALE);
+	max_pull = min(max_load - avg_load, max_load - busiest_load_per_task);
 
 	/* How much load to actually move to equalise the imbalance */
 	*imbalance = min(max_pull * busiest->cpu_power,
 				(avg_load - this_load) * this->cpu_power)
 			/ SCHED_LOAD_SCALE;
 
-	if (*imbalance < SCHED_LOAD_SCALE) {
-		unsigned long pwr_now = 0, pwr_move = 0;
+	/*
+	 * if *imbalance is less than the average load per runnable task
+	 * there is no gaurantee that any tasks will be moved so we'll have
+	 * a think about bumping its value to force at least one task to be
+	 * moved
+	 */
+	if (*imbalance < busiest_load_per_task) {
+		unsigned long pwr_now, pwr_move;
 		unsigned long tmp;
+		unsigned int imbn;
 
-		if (max_load - this_load >= SCHED_LOAD_SCALE*2) {
-			*imbalance = 1;
+small_imbalance:
+		pwr_move = pwr_now = 0;
+		imbn = 2;
+		if (this_nr_running) {
+			this_load_per_task /= this_nr_running;
+			if (busiest_load_per_task > this_load_per_task)
+				imbn = 1;
+		} else
+			this_load_per_task = SCHED_LOAD_SCALE;
+
+		if (max_load - this_load >= busiest_load_per_task * imbn) {
+			*imbalance = busiest_load_per_task;
 			return busiest;
 		}
 
@@ -2047,35 +2216,34 @@ find_busiest_group(struct sched_domain *
 		 * moving them.
 		 */
 
-		pwr_now += busiest->cpu_power*min(SCHED_LOAD_SCALE, max_load);
-		pwr_now += this->cpu_power*min(SCHED_LOAD_SCALE, this_load);
+		pwr_now += busiest->cpu_power *
+			min(busiest_load_per_task, max_load);
+		pwr_now += this->cpu_power *
+			min(this_load_per_task, this_load);
 		pwr_now /= SCHED_LOAD_SCALE;
 
 		/* Amount of load we'd subtract */
-		tmp = SCHED_LOAD_SCALE*SCHED_LOAD_SCALE/busiest->cpu_power;
+		tmp = busiest_load_per_task*SCHED_LOAD_SCALE/busiest->cpu_power;
 		if (max_load > tmp)
-			pwr_move += busiest->cpu_power*min(SCHED_LOAD_SCALE,
-							max_load - tmp);
+			pwr_move += busiest->cpu_power *
+				min(busiest_load_per_task, max_load - tmp);
 
 		/* Amount of load we'd add */
 		if (max_load*busiest->cpu_power <
-				SCHED_LOAD_SCALE*SCHED_LOAD_SCALE)
+				busiest_load_per_task*SCHED_LOAD_SCALE)
 			tmp = max_load*busiest->cpu_power/this->cpu_power;
 		else
-			tmp = SCHED_LOAD_SCALE*SCHED_LOAD_SCALE/this->cpu_power;
-		pwr_move += this->cpu_power*min(SCHED_LOAD_SCALE, this_load + tmp);
+			tmp = busiest_load_per_task*SCHED_LOAD_SCALE/this->cpu_power;
+		pwr_move += this->cpu_power*min(this_load_per_task, this_load + tmp);
 		pwr_move /= SCHED_LOAD_SCALE;
 
 		/* Move if we gain throughput */
 		if (pwr_move <= pwr_now)
 			goto out_balanced;
 
-		*imbalance = 1;
-		return busiest;
+		*imbalance = busiest_load_per_task;
 	}
 
-	/* Get rid of the scaling factor, rounding down as we divide */
-	*imbalance = *imbalance / SCHED_LOAD_SCALE;
 	return busiest;
 
 out_balanced:
@@ -2088,18 +2256,21 @@ out_balanced:
  * find_busiest_queue - find the busiest runqueue among the cpus in group.
  */
 static runqueue_t *find_busiest_queue(struct sched_group *group,
-	enum idle_type idle)
+	enum idle_type idle, unsigned long imbalance)
 {
-	unsigned long load, max_load = 0;
-	runqueue_t *busiest = NULL;
+	unsigned long max_load = 0;
+	runqueue_t *busiest = NULL, *rqi;
 	int i;
 
 	for_each_cpu_mask(i, group->cpumask) {
-		load = source_load(i, 0);
+		rqi = cpu_rq(i);
+
+		if (rqi->nr_running == 1 && rqi->raw_weighted_load > imbalance)
+			continue;
 
-		if (load > max_load) {
-			max_load = load;
-			busiest = cpu_rq(i);
+		if (rqi->raw_weighted_load > max_load) {
+			max_load = rqi->raw_weighted_load;
+			busiest = rqi;
 		}
 	}
 
@@ -2112,6 +2283,7 @@ static runqueue_t *find_busiest_queue(st
  */
 #define MAX_PINNED_INTERVAL	512
 
+#define minus_1_or_zero(n) ((n) > 0 ? (n) - 1 : 0)
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -2139,7 +2311,7 @@ static int load_balance(int this_cpu, ru
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group, idle);
+	busiest = find_busiest_queue(group, idle, imbalance);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[idle]);
 		goto out_balanced;
@@ -2159,6 +2331,7 @@ static int load_balance(int this_cpu, ru
 		 */
 		double_rq_lock(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
+					minus_1_or_zero(busiest->nr_running),
 					imbalance, sd, idle, &all_pinned);
 		double_rq_unlock(this_rq, busiest);
 
@@ -2262,7 +2435,7 @@ static int load_balance_newidle(int this
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group, NEWLY_IDLE);
+	busiest = find_busiest_queue(group, NEWLY_IDLE, imbalance);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
 		goto out_balanced;
@@ -2277,6 +2450,7 @@ static int load_balance_newidle(int this
 		/* Attempt to move tasks */
 		double_lock_balance(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
+					minus_1_or_zero(busiest->nr_running),
 					imbalance, sd, NEWLY_IDLE, NULL);
 		spin_unlock(&busiest->lock);
 	}
@@ -2357,7 +2531,8 @@ static void active_load_balance(runqueue
 
 	schedstat_inc(sd, alb_cnt);
 
-	if (move_tasks(target_rq, target_cpu, busiest_rq, 1, sd, SCHED_IDLE, NULL))
+	if (move_tasks(target_rq, target_cpu, busiest_rq, 1,
+			RTPRIO_TO_LOAD_WEIGHT(100), sd, SCHED_IDLE, NULL))
 		schedstat_inc(sd, alb_pushed);
 	else
 		schedstat_inc(sd, alb_failed);
@@ -2385,7 +2560,7 @@ static void rebalance_tick(int this_cpu,
 	struct sched_domain *sd;
 	int i;
 
-	this_load = this_rq->nr_running * SCHED_LOAD_SCALE;
+	this_load = this_rq->raw_weighted_load;
 	/* Update our load */
 	for (i = 0; i < 3; i++) {
 		unsigned long new_load = this_load;
@@ -3498,17 +3673,21 @@ void set_user_nice(task_t *p, long nice)
 		goto out_unlock;
 	}
 	array = p->array;
-	if (array)
+	if (array) {
 		dequeue_task(p, array);
+		dec_raw_weighted_load(rq, p);
+	}
 
 	old_prio = p->prio;
 	new_prio = NICE_TO_PRIO(nice);
 	delta = new_prio - old_prio;
 	p->static_prio = NICE_TO_PRIO(nice);
+	set_load_weight(p);
 	p->prio += delta;
 
 	if (array) {
 		enqueue_task(p, array);
+		inc_raw_weighted_load(rq, p);
 		/*
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
@@ -3644,6 +3823,7 @@ static void __setscheduler(struct task_s
 		if (policy == SCHED_BATCH)
 			p->sleep_avg = 0;
 	}
+	set_load_weight(p);
 }
 
 /**
@@ -6141,6 +6321,7 @@ void __init sched_init(void)
 		}
 	}
 
+	set_load_weight(&init_task);
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
 	 */

-- 
-ck
