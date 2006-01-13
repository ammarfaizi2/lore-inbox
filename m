Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423087AbWAMXAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423087AbWAMXAE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 18:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423086AbWAMW7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:59:39 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:31071 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1423085AbWAMW7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:59:31 -0500
Message-ID: <43C830D0.5060707@bigpond.net.au>
Date: Sat, 14 Jan 2006 09:59:28 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Con Kolivas <kernel@kolivas.org>, Martin Bligh <mbligh@google.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C4A3E9.1040301@google.com> <43C4F8EE.50208@bigpond.net.au> <200601120129.16315.kernel@kolivas.org> <43C58117.9080706@bigpond.net.au> <43C5A8C6.1040305@bigpond.net.au> <43C6A24E.9080901@google.com> <43C6B60E.2000003@bigpond.net.au> <43C6D636.8000105@bigpond.net.au> <43C75178.80809@bigpond.net.au> <43C7D4D1.10200@shadowen.org> <43C7E96D.7000003@shadowen.org>
In-Reply-To: <43C7E96D.7000003@shadowen.org>
Content-Type: multipart/mixed;
 boundary="------------030002060501080003080602"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 13 Jan 2006 22:59:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030002060501080003080602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andy Whitcroft wrote:
> Andy Whitcroft wrote:
> 
>>Peter Williams wrote:
>>
>>
>>
>>>Attached is a new patch to fix the excessive idle problem.  This patch
>>>takes a new approach to the problem as it was becoming obvious that
>>>trying to alter the load balancing code to cope with biased load was
>>>harder than it seemed.
>>
>>
>>Ok.  Tried testing different-approach-to-smp-nice-problem against the
>>transition release 2.6.14-rc2-mm1 but it doesn't apply.  Am testing
>>against 2.6.15-mm3 right now.  Will let you know.
> 
> 
> Doesn't appear to help if I am analysing the graphs right.  Martin?
> 
> Also tried to back out the original patch against the 2.6.15-mm3 tree
> but that also won't apply (2 rejects).  Peter?

Attached is a patch to back the original patch out of 2.6.15-mm3.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------030002060501080003080602
Content-Type: text/plain;
 name="remove-smp-nice-imp-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove-smp-nice-imp-patch"

Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2006-01-13 18:09:49.000000000 +1100
+++ MM-2.6.X/kernel/sched.c	2006-01-13 18:21:38.000000000 +1100
@@ -63,16 +63,6 @@
 #define PRIO_TO_NICE(prio)	((prio) - MAX_RT_PRIO - 20)
 #define TASK_NICE(p)		PRIO_TO_NICE((p)->static_prio)
 
-#ifdef CONFIG_SMP
-/*
- * Priority bias for load balancing ranges from 1 (nice==19) to 139 (RT
- * priority of 100).
- */
-#define NICE_TO_BIAS_PRIO(nice)	(20 - (nice))
-#define PRIO_TO_BIAS_PRIO(prio)	NICE_TO_BIAS_PRIO(PRIO_TO_NICE(prio))
-#define RTPRIO_TO_BIAS_PRIO(rp)	(40 + (rp))
-#endif
-
 /*
  * 'User priority' is the nice value converted to something we
  * can work with better when scaling various scheduler parameters,
@@ -695,53 +685,46 @@ static int effective_prio(task_t *p)
 }
 
 #ifdef CONFIG_SMP
-static inline void set_bias_prio(task_t *p)
-{
-	if (rt_task(p)) {
-		if (p == task_rq(p)->migration_thread)
-			/*
-			 * The migration thread does the actual balancing. Do
-			 * not bias by its priority as the ultra high priority
-			 * will skew balancing adversely.
-			 */
-			p->bias_prio = 0;
-		else
-			p->bias_prio = RTPRIO_TO_BIAS_PRIO(p->rt_priority);
-	} else
-		p->bias_prio = PRIO_TO_BIAS_PRIO(p->static_prio);
-}
-
-static inline void inc_prio_bias(runqueue_t *rq, const task_t *p)
+static inline void inc_prio_bias(runqueue_t *rq, int prio)
 {
-	rq->prio_bias += p->bias_prio;
+	rq->prio_bias += MAX_PRIO - prio;
 }
 
-static inline void dec_prio_bias(runqueue_t *rq, const task_t *p)
+static inline void dec_prio_bias(runqueue_t *rq, int prio)
 {
-	rq->prio_bias -= p->bias_prio;
+	rq->prio_bias -= MAX_PRIO - prio;
 }
 
 static inline void inc_nr_running(task_t *p, runqueue_t *rq)
 {
 	rq->nr_running++;
-	inc_prio_bias(rq, p);
+	if (rt_task(p)) {
+		if (p != rq->migration_thread)
+			/*
+			 * The migration thread does the actual balancing. Do
+			 * not bias by its priority as the ultra high priority
+			 * will skew balancing adversely.
+			 */
+			inc_prio_bias(rq, p->prio);
+	} else
+		inc_prio_bias(rq, p->static_prio);
 }
 
 static inline void dec_nr_running(task_t *p, runqueue_t *rq)
 {
 	rq->nr_running--;
-	dec_prio_bias(rq, p);
+	if (rt_task(p)) {
+		if (p != rq->migration_thread)
+			dec_prio_bias(rq, p->prio);
+	} else
+		dec_prio_bias(rq, p->static_prio);
 }
 #else
-static inline void set_bias_prio(task_t *p)
-{
-}
-
-static inline void inc_prio_bias(runqueue_t *rq, const task_t *p)
+static inline void inc_prio_bias(runqueue_t *rq, int prio)
 {
 }
 
-static inline void dec_prio_bias(runqueue_t *rq, const task_t *p)
+static inline void dec_prio_bias(runqueue_t *rq, int prio)
 {
 }
 
@@ -1039,29 +1022,61 @@ void kick_process(task_t *p)
  * We want to under-estimate the load of migration sources, to
  * balance conservatively.
  */
-static unsigned long source_load(int cpu, int type)
+static inline unsigned long __source_load(int cpu, int type, enum idle_type idle)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long load_now = rq->prio_bias * SCHED_LOAD_SCALE;
+	unsigned long running = rq->nr_running;
+	unsigned long source_load, cpu_load = rq->cpu_load[type-1],
+		load_now = running * SCHED_LOAD_SCALE;
 
 	if (type == 0)
-		return load_now;
+		source_load = load_now;
+	else
+		source_load = min(cpu_load, load_now);
+
+	if (running > 1 || (idle == NOT_IDLE && running))
+		/*
+		 * If we are busy rebalancing the load is biased by
+		 * priority to create 'nice' support across cpus. When
+		 * idle rebalancing we should only bias the source_load if
+		 * there is more than one task running on that queue to
+		 * prevent idle rebalance from trying to pull tasks from a
+		 * queue with only one running task.
+		 */
+		source_load = source_load * rq->prio_bias / running;
+
+	return source_load;
+}
 
-	return min(rq->cpu_load[type-1], load_now);
+static inline unsigned long source_load(int cpu, int type)
+{
+	return __source_load(cpu, type, NOT_IDLE);
 }
 
 /*
  * Return a high guess at the load of a migration-target cpu
  */
-static inline unsigned long target_load(int cpu, int type)
+static inline unsigned long __target_load(int cpu, int type, enum idle_type idle)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long load_now = rq->prio_bias * SCHED_LOAD_SCALE;
+	unsigned long running = rq->nr_running;
+	unsigned long target_load, cpu_load = rq->cpu_load[type-1],
+		load_now = running * SCHED_LOAD_SCALE;
 
 	if (type == 0)
-		return load_now;
+		target_load = load_now;
+	else
+		target_load = max(cpu_load, load_now);
+
+	if (running > 1 || (idle == NOT_IDLE && running))
+		target_load = target_load * rq->prio_bias / running;
+
+	return target_load;
+}
 
-	return max(rq->cpu_load[type-1], load_now);
+static inline unsigned long target_load(int cpu, int type)
+{
+	return __target_load(cpu, type, NOT_IDLE);
 }
 
 /*
@@ -1322,7 +1337,7 @@ static int try_to_wake_up(task_t *p, uns
 			 * of the current CPU:
 			 */
 			if (sync)
-				tl -= p->bias_prio * SCHED_LOAD_SCALE;
+				tl -= SCHED_LOAD_SCALE;
 
 			if ((tl <= load &&
 				tl + target_load(cpu, idx) <= SCHED_LOAD_SCALE) ||
@@ -1934,16 +1949,15 @@ int can_migrate_task(task_t *p, runqueue
  * Called with both runqueues locked.
  */
 static int move_tasks(runqueue_t *this_rq, int this_cpu, runqueue_t *busiest,
-		      unsigned long max_nr_move, long max_bias_move,
-		      struct sched_domain *sd, enum idle_type idle,
-		      int *all_pinned)
+		      unsigned long max_nr_move, struct sched_domain *sd,
+		      enum idle_type idle, int *all_pinned)
 {
 	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
 	int idx, pulled = 0, pinned = 0;
 	task_t *tmp;
 
-	if (max_nr_move == 0 || max_bias_move == 0)
+	if (max_nr_move == 0)
 		goto out;
 
 	pinned = 1;
@@ -1986,8 +2000,7 @@ skip_queue:
 
 	curr = curr->prev;
 
-	if (tmp->bias_prio > max_bias_move ||
-	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
+	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -2001,13 +2014,9 @@ skip_queue:
 
 	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
 	pulled++;
-	max_bias_move -= tmp->bias_prio;
 
-	/*
-	 * We only want to steal up to the prescribed number of tasks
-	 * and the prescribed amount of biased load.
-	 */
-	if (pulled < max_nr_move && max_bias_move > 0) {
+	/* We only want to steal up to the prescribed number of tasks. */
+	if (pulled < max_nr_move) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -2028,7 +2037,7 @@ out:
 
 /*
  * find_busiest_group finds and returns the busiest CPU group within the
- * domain. It calculates and returns the amount of biased load which should be
+ * domain. It calculates and returns the number of tasks which should be
  * moved to restore balance via the imbalance parameter.
  */
 static struct sched_group *
@@ -2064,9 +2073,9 @@ find_busiest_group(struct sched_domain *
 
 			/* Bias balancing toward cpus of our domain */
 			if (local_group)
-				load = target_load(i, load_idx);
+				load = __target_load(i, load_idx, idle);
 			else
-				load = source_load(i, load_idx);
+				load = __source_load(i, load_idx, idle);
 
 			avg_load += load;
 		}
@@ -2121,7 +2130,7 @@ find_busiest_group(struct sched_domain *
 		unsigned long tmp;
 
 		if (max_load - this_load >= SCHED_LOAD_SCALE*2) {
-			*imbalance = NICE_TO_BIAS_PRIO(0);
+			*imbalance = 1;
 			return busiest;
 		}
 
@@ -2154,7 +2163,7 @@ find_busiest_group(struct sched_domain *
 		if (pwr_move <= pwr_now)
 			goto out_balanced;
 
-		*imbalance = NICE_TO_BIAS_PRIO(0);
+		*imbalance = 1;
 		return busiest;
 	}
 
@@ -2171,14 +2180,15 @@ out_balanced:
 /*
  * find_busiest_queue - find the busiest runqueue among the cpus in group.
  */
-static runqueue_t *find_busiest_queue(struct sched_group *group)
+static runqueue_t *find_busiest_queue(struct sched_group *group,
+	enum idle_type idle)
 {
 	unsigned long load, max_load = 0;
 	runqueue_t *busiest = NULL;
 	int i;
 
 	for_each_cpu_mask(i, group->cpumask) {
-		load = source_load(i, 0);
+		load = __source_load(i, 0, idle);
 
 		if (load > max_load) {
 			max_load = load;
@@ -2195,7 +2205,6 @@ static runqueue_t *find_busiest_queue(st
  */
 #define MAX_PINNED_INTERVAL	512
 
-#define minus_1_or_zero(n) ((n) > 0 ? (n) - 1 : 0)
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -2223,7 +2232,7 @@ static int load_balance(int this_cpu, ru
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group);
+	busiest = find_busiest_queue(group, idle);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[idle]);
 		goto out_balanced;
@@ -2243,7 +2252,6 @@ static int load_balance(int this_cpu, ru
 		 */
 		double_rq_lock(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
-					minus_1_or_zero(busiest->nr_running),
 					imbalance, sd, idle, &all_pinned);
 		double_rq_unlock(this_rq, busiest);
 
@@ -2347,7 +2355,7 @@ static int load_balance_newidle(int this
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group);
+	busiest = find_busiest_queue(group, NEWLY_IDLE);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
 		goto out_balanced;
@@ -2362,7 +2370,6 @@ static int load_balance_newidle(int this
 		/* Attempt to move tasks */
 		double_lock_balance(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
-					minus_1_or_zero(busiest->nr_running),
 					imbalance, sd, NEWLY_IDLE, NULL);
 		spin_unlock(&busiest->lock);
 	}
@@ -2443,8 +2450,7 @@ static void active_load_balance(runqueue
 
 	schedstat_inc(sd, alb_cnt);
 
-	if (move_tasks(target_rq, target_cpu, busiest_rq, 1,
-			RTPRIO_TO_BIAS_PRIO(100), sd, SCHED_IDLE, NULL))
+	if (move_tasks(target_rq, target_cpu, busiest_rq, 1, sd, SCHED_IDLE, NULL))
 		schedstat_inc(sd, alb_pushed);
 	else
 		schedstat_inc(sd, alb_failed);
@@ -2472,7 +2478,7 @@ static void rebalance_tick(int this_cpu,
 	struct sched_domain *sd;
 	int i;
 
-	this_load = this_rq->prio_bias * SCHED_LOAD_SCALE;
+	this_load = this_rq->nr_running * SCHED_LOAD_SCALE;
 	/* Update our load */
 	for (i = 0; i < 3; i++) {
 		unsigned long new_load = this_load;
@@ -3612,19 +3618,18 @@ void set_user_nice(task_t *p, long nice)
 	array = p->array;
 	if (array) {
 		dequeue_task(p, array);
-		dec_prio_bias(rq, p);
+		dec_prio_bias(rq, p->static_prio);
 	}
 
 	old_prio = p->prio;
 	new_prio = NICE_TO_PRIO(nice);
 	delta = new_prio - old_prio;
 	p->static_prio = NICE_TO_PRIO(nice);
-	set_bias_prio(p);
 	p->prio += delta;
 
 	if (array) {
 		enqueue_task(p, array);
-		inc_prio_bias(rq, p);
+		inc_prio_bias(rq, p->static_prio);
 		/*
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
@@ -3767,7 +3772,6 @@ static void __setscheduler(struct task_s
 		if (policy == SCHED_BATCH)
 			p->sleep_avg = 0;
 	}
-	set_bias_prio(p);
 }
 
 /**
@@ -6309,7 +6313,6 @@ void __init sched_init(void)
 		}
 	}
 
-	set_bias_prio(&init_task);
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
 	 */

--------------030002060501080003080602--
