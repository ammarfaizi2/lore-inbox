Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbVIPGNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbVIPGNr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 02:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbVIPGNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 02:13:47 -0400
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:1604 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1161040AbVIPGNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 02:13:46 -0400
Message-ID: <432A6297.8060406@bigpond.net.au>
Date: Fri, 16 Sep 2005 16:13:43 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH, RFC] sched: Modified nice support for SMP load balancing
Content-Type: multipart/mixed;
 boundary="------------050106010100000409000705"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 16 Sep 2005 06:13:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050106010100000409000705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch is a modified version of Con Kolivas's patch to add 
"nice" support to load balancing across physical CPUs on SMP systems.

The principal modifications to the Con's mechanism are changing 
move_tasks() so that it endeavours to move a specified amount of biased 
load rather than a specified number of tasks, changing 
find_busiest_group() so that the value returned in "imbalance" is in 
terms of biased load rather than number of tasks and changing 
rebalance_tick() to calculate "cpu_load" for each run queue as biased 
load rather than plain load.  To be more precise, because of the special 
case of active_load_balance() wanting to move exactly 1 task, 
move_tasks() actually moves up to a given number of tasks or up to a 
given amount of biased load.

Because these changes mean that tasks' biased prio is evaluated much 
more often than in the original implementation a "bias_prio" field has 
been added to the task structure to hold its value meaning that it only 
needs to be calculated when the task's nice or scheduling class is 
changed.  This change facilitates considerable simplification of much of 
the code.

Signed-off-by: Peter Williams <pwil3058@bigpond.net.au>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------050106010100000409000705
Content-Type: text/plain;
 name="sched-modified-nice-support-across-physical-cpus-on-smp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-modified-nice-support-across-physical-cpus-on-smp"

Index: Linux-2.6.X/include/linux/sched.h
===================================================================
--- Linux-2.6.X.orig/include/linux/sched.h	2005-09-16 09:56:22.000000000 +1000
+++ Linux-2.6.X/include/linux/sched.h	2005-09-16 10:18:04.000000000 +1000
@@ -640,6 +640,9 @@ struct task_struct {
 	int oncpu;
 #endif
 	int prio, static_prio;
+#ifdef CONFIG_SMP
+	int bias_prio;
+#endif
 	struct list_head run_list;
 	prio_array_t *array;
 
Index: Linux-2.6.X/kernel/sched.c
===================================================================
--- Linux-2.6.X.orig/kernel/sched.c	2005-09-16 09:56:26.000000000 +1000
+++ Linux-2.6.X/kernel/sched.c	2005-09-16 14:44:34.000000000 +1000
@@ -60,6 +60,16 @@
 #define PRIO_TO_NICE(prio)	((prio) - MAX_RT_PRIO - 20)
 #define TASK_NICE(p)		PRIO_TO_NICE((p)->static_prio)
 
+#ifdef CONFIG_SMP
+/*
+ * Priority bias for load balancing ranges from 1 (nice==19) to 139 (RT
+ * priority of 100).
+ */
+#define NICE_TO_BIAS_PRIO(nice)	(20 - (nice))
+#define PRIO_TO_BIAS_PRIO(prio)	NICE_TO_BIAS_PRIO(PRIO_TO_NICE(prio))
+#define RTPRIO_TO_BIAS_PRIO(rp)	(40 + (rp))
+#endif
+
 /*
  * 'User priority' is the nice value converted to something we
  * can work with better when scaling various scheduler parameters,
@@ -206,6 +216,7 @@ struct runqueue {
 	 */
 	unsigned long nr_running;
 #ifdef CONFIG_SMP
+	unsigned long prio_bias;
 	unsigned long cpu_load[3];
 #endif
 	unsigned long long nr_switches;
@@ -659,13 +670,75 @@ static int effective_prio(task_t *p)
 	return prio;
 }
 
+#ifdef CONFIG_SMP
+static inline void set_bias_prio(task_t *p)
+{
+	if (rt_task(p)) {
+		if (p == task_rq(p)->migration_thread)
+			/*
+			 * The migration thread does the actual balancing. Do
+			 * not bias by its priority as the ultra high priority
+			 * will skew balancing adversely.
+			 */
+			p->bias_prio = 0;
+		else
+			p->bias_prio = RTPRIO_TO_BIAS_PRIO(p->rt_priority);
+	} else
+		p->bias_prio = PRIO_TO_BIAS_PRIO(p->static_prio);
+}
+
+static inline void inc_prio_bias(runqueue_t *rq, const task_t *p)
+{
+	rq->prio_bias += p->bias_prio;
+}
+
+static inline void dec_prio_bias(runqueue_t *rq, const task_t *p)
+{
+	rq->prio_bias -= p->bias_prio;
+}
+
+static inline void inc_nr_running(task_t *p, runqueue_t *rq)
+{
+	rq->nr_running++;
+	inc_prio_bias(rq, p);
+}
+
+static inline void dec_nr_running(task_t *p, runqueue_t *rq)
+{
+	rq->nr_running--;
+	dec_prio_bias(rq, p);
+}
+#else
+static inline void set_bias_prio(task_t *p)
+{
+}
+
+static inline void inc_prio_bias(runqueue_t *rq, const task_t *p)
+{
+}
+
+static inline void dec_prio_bias(runqueue_t *rq, const task_t *p)
+{
+}
+
+static inline void inc_nr_running(task_t *p, runqueue_t *rq)
+{
+	rq->nr_running++;
+}
+
+static inline void dec_nr_running(task_t *p, runqueue_t *rq)
+{
+	rq->nr_running--;
+}
+#endif
+
 /*
  * __activate_task - move a task to the runqueue.
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task(p, rq->active);
-	rq->nr_running++;
+	inc_nr_running(p, rq);
 }
 
 /*
@@ -674,7 +747,7 @@ static inline void __activate_task(task_
 static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task_head(p, rq->active);
-	rq->nr_running++;
+	inc_nr_running(p, rq);
 }
 
 static int recalc_task_prio(task_t *p, unsigned long long now)
@@ -793,7 +866,7 @@ static void activate_task(task_t *p, run
  */
 static void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	rq->nr_running--;
+	dec_nr_running(p, rq);
 	dequeue_task(p, p->array);
 	p->array = NULL;
 }
@@ -933,7 +1006,8 @@ void kick_process(task_t *p)
 static inline unsigned long source_load(int cpu, int type)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long load_now = rq->nr_running * SCHED_LOAD_SCALE;
+	unsigned long load_now = rq->prio_bias * SCHED_LOAD_SCALE;
+
 	if (type == 0)
 		return load_now;
 
@@ -946,7 +1020,8 @@ static inline unsigned long source_load(
 static inline unsigned long target_load(int cpu, int type)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long load_now = rq->nr_running * SCHED_LOAD_SCALE;
+	unsigned long load_now = rq->prio_bias * SCHED_LOAD_SCALE;
+
 	if (type == 0)
 		return load_now;
 
@@ -1208,7 +1283,7 @@ static int try_to_wake_up(task_t *p, uns
 			 * of the current CPU:
 			 */
 			if (sync)
-				tl -= SCHED_LOAD_SCALE;
+				tl -= p->bias_prio * SCHED_LOAD_SCALE;
 
 			if ((tl <= load &&
 				tl + target_load(cpu, idx) <= SCHED_LOAD_SCALE) ||
@@ -1411,7 +1486,7 @@ void fastcall wake_up_new_task(task_t *p
 				list_add_tail(&p->run_list, &current->run_list);
 				p->array = current->array;
 				p->array->nr_active++;
-				rq->nr_running++;
+				inc_nr_running(p, rq);
 			}
 			set_need_resched();
 		} else
@@ -1756,9 +1831,9 @@ void pull_task(runqueue_t *src_rq, prio_
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
@@ -1813,15 +1888,16 @@ int can_migrate_task(task_t *p, runqueue
  * Called with both runqueues locked.
  */
 static int move_tasks(runqueue_t *this_rq, int this_cpu, runqueue_t *busiest,
-		      unsigned long max_nr_move, struct sched_domain *sd,
-		      enum idle_type idle, int *all_pinned)
+		      unsigned long max_nr_move, long max_bias_move,
+		      struct sched_domain *sd, enum idle_type idle,
+		      int *all_pinned)
 {
 	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
 	int idx, pulled = 0, pinned = 0;
 	task_t *tmp;
 
-	if (max_nr_move == 0)
+	if (max_nr_move == 0 || max_bias_move == 0)
 		goto out;
 
 	pinned = 1;
@@ -1864,7 +1940,8 @@ skip_queue:
 
 	curr = curr->prev;
 
-	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
+	if (tmp->bias_prio > max_bias_move ||
+	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -1878,9 +1955,13 @@ skip_queue:
 
 	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
 	pulled++;
+	max_bias_move -= tmp->bias_prio;
 
-	/* We only want to steal up to the prescribed number of tasks. */
-	if (pulled < max_nr_move) {
+	/*
+	 * We only want to steal up to the prescribed number of tasks
+	 * and the prescribed amount of biased load.
+	 */
+	if (pulled < max_nr_move && max_bias_move > 0) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -1901,7 +1982,7 @@ out:
 
 /*
  * find_busiest_group finds and returns the busiest CPU group within the
- * domain. It calculates and returns the number of tasks which should be
+ * domain. It calculates and returns the amount of biased load which should be
  * moved to restore balance via the imbalance parameter.
  */
 static struct sched_group *
@@ -1994,7 +2075,7 @@ find_busiest_group(struct sched_domain *
 		unsigned long tmp;
 
 		if (max_load - this_load >= SCHED_LOAD_SCALE*2) {
-			*imbalance = 1;
+			*imbalance = NICE_TO_BIAS_PRIO(0);
 			return busiest;
 		}
 
@@ -2027,7 +2108,7 @@ find_busiest_group(struct sched_domain *
 		if (pwr_move <= pwr_now)
 			goto out_balanced;
 
-		*imbalance = 1;
+		*imbalance = NICE_TO_BIAS_PRIO(0);
 		return busiest;
 	}
 
@@ -2068,6 +2149,7 @@ static runqueue_t *find_busiest_queue(st
  */
 #define MAX_PINNED_INTERVAL	512
 
+#define minus_1_or_zero(n) ((n) > 0 ? (n) - 1 : 0)
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -2115,6 +2197,7 @@ static int load_balance(int this_cpu, ru
 		 */
 		double_rq_lock(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
+					minus_1_or_zero(busiest->nr_running),
 					imbalance, sd, idle, &all_pinned);
 		double_rq_unlock(this_rq, busiest);
 
@@ -2233,6 +2316,7 @@ static int load_balance_newidle(int this
 		/* Attempt to move tasks */
 		double_lock_balance(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
+					minus_1_or_zero(busiest->nr_running),
 					imbalance, sd, NEWLY_IDLE, NULL);
 		spin_unlock(&busiest->lock);
 	}
@@ -2313,7 +2397,8 @@ static void active_load_balance(runqueue
 
 	schedstat_inc(sd, alb_cnt);
 
-	if (move_tasks(target_rq, target_cpu, busiest_rq, 1, sd, SCHED_IDLE, NULL))
+	if (move_tasks(target_rq, target_cpu, busiest_rq, 1,
+			RTPRIO_TO_BIAS_PRIO(100), sd, SCHED_IDLE, NULL))
 		schedstat_inc(sd, alb_pushed);
 	else
 		schedstat_inc(sd, alb_failed);
@@ -2341,7 +2426,7 @@ static void rebalance_tick(int this_cpu,
 	struct sched_domain *sd;
 	int i;
 
-	this_load = this_rq->nr_running * SCHED_LOAD_SCALE;
+	this_load = this_rq->prio_bias * SCHED_LOAD_SCALE;
 	/* Update our load */
 	for (i = 0; i < 3; i++) {
 		unsigned long new_load = this_load;
@@ -3453,17 +3538,21 @@ void set_user_nice(task_t *p, long nice)
 		goto out_unlock;
 	}
 	array = p->array;
-	if (array)
+	if (array) {
 		dequeue_task(p, array);
+		dec_prio_bias(rq, p);
+	}
 
 	old_prio = p->prio;
 	new_prio = NICE_TO_PRIO(nice);
 	delta = new_prio - old_prio;
 	p->static_prio = NICE_TO_PRIO(nice);
+	set_bias_prio(p);
 	p->prio += delta;
 
 	if (array) {
 		enqueue_task(p, array);
+		inc_prio_bias(rq, p);
 		/*
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
@@ -3595,6 +3684,7 @@ static void __setscheduler(struct task_s
 		p->prio = MAX_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
+	set_bias_prio(p);
 }
 
 /**
@@ -5535,6 +5625,7 @@ void __init sched_init(void)
 		}
 	}
 
+	set_bias_prio(&init_task);
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
 	 */

--------------050106010100000409000705--
