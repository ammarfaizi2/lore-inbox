Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTKOQKg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 11:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbTKOQKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 11:10:35 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:8628
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261797AbTKOQKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 11:10:22 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Hyper-thread aware batch scheduling 2.6.0-test9
Date: Sun, 16 Nov 2003 03:10:18 +1100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_q/kt/xgwrYlGJOs"
Message-Id: <200311160310.18294.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_q/kt/xgwrYlGJOs
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch is a combination of two complementary patches I worked on for my 
own use that you might find useful.


ht-2 has some very simple hyper-thread enhancements designed to balance 
hyper-thread siblings with cache-warm tasks if possible. 


batch-3 contains an improved version of the batch scheduling I posted a while 
ago. 
changes:
The main improvement in this is it is hyper-thread aware. How it does this is 
it will try not to schedule a batch task on a logical cpu if it's 
hyper-thread sibling is running a normal task. This makes a massive 
difference if you try to run batch tasks on a HT box with an SMP kernel.
It now does it's accounting for batch cpu time as idle time.
Other minor touch ups.

Batch scheduling allows you to specify tasks to be as lightweight as possible, 
using only idle cpu time when it's available instead of a small proportion of 
cpu time that the most niced tasks would in normal scheduling.


Both patches are available separately at this url, but batch-3 depends on the 
ht-2 patch.
http://ck.kolivas.org/patches/2.6/2.6.0-test9

The attached patch is the merged ht2-batch3 patch.

Con

--Boundary-00=_q/kt/xgwrYlGJOs
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-test9-ht2-batch3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-test9-ht2-batch3"

--- linux-2.6.0-test9-base/include/linux/sched.h	2003-10-18 15:20:19.000000000 +1000
+++ linux-2.6.0-test9/include/linux/sched.h	2003-11-16 01:56:01.000000000 +1100
@@ -126,6 +126,7 @@ extern unsigned long nr_iowait(void);
 #define SCHED_NORMAL		0
 #define SCHED_FIFO		1
 #define SCHED_RR		2
+#define SCHED_BATCH		3
 
 struct sched_param {
 	int sched_priority;
@@ -285,6 +286,7 @@ struct signal_struct {
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
 
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
+#define batch_task(p)		((p)->policy == SCHED_BATCH)
 
 /*
  * Some day this will be a full-fledged user tracking system..
--- linux-2.6.0-test9-base/kernel/sched.c	2003-10-26 07:52:58.000000000 +1100
+++ linux-2.6.0-test9/kernel/sched.c	2003-11-16 02:32:44.869274749 +1100
@@ -141,7 +141,7 @@
 		INTERACTIVE_DELTA)
 
 #define TASK_INTERACTIVE(p) \
-	((p)->prio <= (p)->static_prio - DELTA(p))
+	((p)->prio <= (p)->static_prio - DELTA(p) && !batch_task(p))
 
 #define JUST_INTERACTIVE_SLEEP(p) \
 	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
@@ -153,8 +153,13 @@
 #define LOW_CREDIT(p) \
 	((p)->interactive_credit < -CREDIT_LIMIT)
 
+/*
+ * Batch tasks are preempted by any priority normal tasks and never
+ * preempt other tasks.
+ */
 #define TASK_PREEMPTS_CURR(p, rq) \
-	((p)->prio < (rq)->curr->prio)
+	((((p)->prio < (rq)->curr->prio) || (batch_task((rq)->curr))) && \
+		(!batch_task(p)))
 
 /*
  * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
@@ -172,6 +177,13 @@
 
 static inline unsigned int task_timeslice(task_t *p)
 {
+	/*
+	 * Batch tasks get much longer timeslices to optimise cpu throughput.
+	 * Since they yield to any other tasks this is not a problem.
+	 */
+	if (unlikely(batch_task(p)))
+		return BASE_TIMESLICE(p) * 10;
+
 	return BASE_TIMESLICE(p);
 }
 
@@ -199,11 +211,12 @@ struct prio_array {
 struct runqueue {
 	spinlock_t lock;
 	unsigned long nr_running, nr_switches, expired_timestamp,
-			nr_uninterruptible;
+			nr_uninterruptible, nr_batch;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
-	prio_array_t *active, *expired, arrays[2];
+	prio_array_t *active, *expired, *batch, arrays[3];
 	int prev_cpu_load[NR_CPUS];
+	int cpu;
 #ifdef CONFIG_NUMA
 	atomic_t *node_nr_running;
 	int prev_node_load[MAX_NUMNODES];
@@ -221,6 +234,9 @@ static DEFINE_PER_CPU(struct runqueue, r
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 
+#define ht_siblings(cpu1, cpu2)	(cpu_has_ht && smp_num_siblings > 1 && \
+	cpu_sibling_map[(cpu1)] == (cpu2))
+
 /*
  * Default context-switch locking:
  */
@@ -269,9 +285,11 @@ __init void node_nr_running_init(void)
 
 #else /* !CONFIG_NUMA */
 
-# define nr_running_init(rq)   do { } while (0)
-# define nr_running_inc(rq)    do { (rq)->nr_running++; } while (0)
-# define nr_running_dec(rq)    do { (rq)->nr_running--; } while (0)
+# define nr_running_init(rq)	do { } while (0)
+# define nr_running_inc(rq)	do { (rq)->nr_running++; } while (0)
+# define nr_running_dec(rq)	do { (rq)->nr_running--; } while (0)
+# define nr_batch_inc(rq)	do { (rq)->nr_batch++; } while (0)
+# define nr_batch_dec(rq)	do { (rq)->nr_batch--; } while (0)
 
 #endif /* CONFIG_NUMA */
 
@@ -354,12 +372,13 @@ static inline void enqueue_task(struct t
  */
 static int effective_prio(task_t *p)
 {
-	int bonus, prio;
+	int prio, bonus = 0;
 
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
+	if (likely(!batch_task(p)))
+		bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
 	if (prio < MAX_RT_PRIO)
@@ -374,7 +393,12 @@ static int effective_prio(task_t *p)
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task(p, rq->active);
+	if (unlikely(batch_task(p))){
+		enqueue_task(p, rq->batch);
+		nr_batch_inc(rq);
+	} else
+		enqueue_task(p, rq->active);
+
 	nr_running_inc(rq);
 }
 
@@ -498,6 +522,8 @@ static inline void activate_task(task_t 
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
 	nr_running_dec(rq);
+	if (unlikely(batch_task(p)))
+		nr_batch_dec(rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -688,10 +714,20 @@ void wake_up_forked_process(task_t * p)
 	else {
 		p->prio = current->prio;
 		list_add_tail(&p->run_list, &current->run_list);
-		p->array = current->array;
-		p->array->nr_active++;
+		if (unlikely(batch_task(p))){
+			p->array = task_rq(current)->batch;
+			p->array->nr_active++;
+			nr_batch_inc(rq);
+		} else {
+			p->array = current->array;
+			p->array->nr_active++;
+		}
 		nr_running_inc(rq);
 	}
+
+	if (unlikely(batch_task(current) && !batch_task(p)))
+		resched_task(current);
+
 	task_rq_unlock(rq, &flags);
 }
 
@@ -1119,7 +1155,12 @@ static inline void pull_task(runqueue_t 
 	nr_running_dec(src_rq);
 	set_task_cpu(p, this_cpu);
 	nr_running_inc(this_rq);
-	enqueue_task(p, this_rq->active);
+	if (unlikely(batch_task(p))){
+		nr_batch_dec(src_rq);
+		nr_batch_inc(this_rq);
+		enqueue_task(p, this_rq->batch);
+	} else
+		enqueue_task(p, this_rq->active);
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
@@ -1142,8 +1183,9 @@ can_migrate_task(task_t *tsk, runqueue_t
 {
 	unsigned long delta = sched_clock() - tsk->timestamp;
 
-	if (!idle && (delta <= JIFFIES_TO_NS(cache_decay_ticks)))
-		return 0;
+	if (!idle && (delta <= JIFFIES_TO_NS(cache_decay_ticks)) &&
+		!ht_siblings(this_cpu, task_cpu(tsk)))
+			return 0;
 	if (task_running(rq, tsk))
 		return 0;
 	if (!cpu_isset(this_cpu, tsk->cpus_allowed))
@@ -1178,15 +1220,23 @@ static void load_balance(runqueue_t *thi
 	imbalance /= 2;
 
 	/*
+	 * For hyperthread siblings take tasks from the active array
+	 * to get cache-warm tasks since they share caches.
+	 */
+	if (ht_siblings(this_cpu, busiest->cpu))
+		array = busiest->active;
+	/*
 	 * We first consider expired tasks. Those will likely not be
 	 * executed in the near future, and they are most likely to
 	 * be cache-cold, thus switching CPUs has the least effect
 	 * on them.
 	 */
-	if (busiest->expired->nr_active)
-		array = busiest->expired;
-	else
-		array = busiest->active;
+	else {
+		if (busiest->expired->nr_active)
+			array = busiest->expired;
+		else
+			array = busiest->active;
+	}
 
 new_array:
 	/* Start searching at priority 0: */
@@ -1197,9 +1247,16 @@ skip_bitmap:
 	else
 		idx = find_next_bit(array->bitmap, MAX_PRIO, idx);
 	if (idx >= MAX_PRIO) {
-		if (array == busiest->expired) {
-			array = busiest->active;
-			goto new_array;
+		if (ht_siblings(this_cpu, busiest->cpu)){
+			if (array == busiest->active) {
+				array = busiest->expired;
+				goto new_array;
+			}
+		} else {
+			if (array == busiest->expired) {
+				array = busiest->active;
+				goto new_array;
+			}
 		}
 		goto out_unlock;
 	}
@@ -1363,13 +1420,37 @@ void scheduler_tick(int user_ticks, int 
 			cpustat->iowait += sys_ticks;
 		else
 			cpustat->idle += sys_ticks;
+
+		if (rq->nr_batch) {
+			resched_task(p);
+			goto out;
+		}
 		rebalance_tick(rq, 1);
 		return;
 	}
-	if (TASK_NICE(p) > 0)
-		cpustat->nice += user_ticks;
-	else
-		cpustat->user += user_ticks;
+
+	if (unlikely(batch_task(p))){
+		cpustat->idle += user_ticks;
+#ifdef CONFIG_SMP
+		/*
+		 * Check to see if a hyper-threaded sibling is running a
+		 * non batch task and resched the batch task if it is.
+		 */
+		if (cpu_has_ht && smp_num_siblings > 1){
+			runqueue_t *htrq;
+			htrq = cpu_rq(cpu_sibling_map[(rq->cpu)]);
+			if (htrq->nr_running > htrq->nr_batch){
+				resched_task(p);
+				goto out;
+			}
+		}
+#endif
+	} else {
+		if (TASK_NICE(p) > 0)
+			cpustat->nice += user_ticks;
+		else
+			cpustat->user += user_ticks;
+	}
 	cpustat->system += sys_ticks;
 
 	/* Task might have expired already, but not scheduled off yet */
@@ -1408,12 +1489,17 @@ void scheduler_tick(int user_ticks, int 
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 
-		if (!rq->expired_timestamp)
+		if (!rq->expired_timestamp && !batch_task(p))
 			rq->expired_timestamp = jiffies;
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			enqueue_task(p, rq->expired);
-		} else
-			enqueue_task(p, rq->active);
+
+		if (unlikely(batch_task(p)))
+			enqueue_task(p, rq->batch);
+		else {
+			if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq))
+				enqueue_task(p, rq->expired);
+			else
+				enqueue_task(p, rq->active);
+		}
 	} else {
 		/*
 		 * Prevent a too long timeslice allowing a task to monopolize
@@ -1534,16 +1620,55 @@ pick_next_task:
 		/*
 		 * Switch the active and expired arrays.
 		 */
-		rq->active = rq->expired;
-		rq->expired = array;
+		if (likely(rq->expired->nr_active)){
+			rq->active = rq->expired;
+			rq->expired = array;
+			rq->expired_timestamp = 0;
+		} else {
+			/*
+			 * Switch to the batch array if there are no
+			 * normal tasks left waiting.
+			 */
+			rq->active = rq->batch;
+			rq->batch = array;
+		}
+
 		array = rq->active;
-		rq->expired_timestamp = 0;
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
+	/*
+	 * If a batch process is on the active array and normal processes
+	 * are still running move the batch process to the batch
+	 * array.
+	 */
+	if (unlikely(batch_task(next))){
+		if (rq->nr_running > rq->nr_batch){
+			dequeue_task(next, array);
+			enqueue_task(next, rq->batch);
+			goto pick_next_task;
+		}
+#ifdef CONFIG_SMP
+		/*
+		 * Check for hyper-threading and do not schedule a batch task
+		 * if the sibling is running a normal task.
+		 */
+		if (cpu_has_ht && smp_num_siblings > 1){
+			runqueue_t *htrq;
+			htrq = cpu_rq(cpu_sibling_map[(rq->cpu)]);
+			if (htrq->nr_running > htrq->nr_batch){
+				dequeue_task(next, array);
+				enqueue_task(next, rq->batch);
+				next = rq->idle;
+				goto switch_tasks;
+			}
+		}
+#endif
+	}
+
 	if (next->activated > 0) {
 		unsigned long long delta = now - next->timestamp;
 
@@ -1865,10 +1990,11 @@ void set_user_nice(task_t *p, long nice)
 		enqueue_task(p, array);
 		/*
 		 * If the task increased its priority or is running and
-		 * lowered its priority, then reschedule its CPU:
+		 * lowered its priority or is batch, then reschedule its CPU:
 		 */
-		if (delta < 0 || (delta > 0 && task_running(rq, p)))
-			resched_task(rq->curr);
+		if (delta < 0 || ((delta > 0 || batch_task(p)) &&
+			task_running(rq, p)))
+				resched_task(rq->curr);
 	}
 out_unlock:
 	task_rq_unlock(rq, &flags);
@@ -2015,8 +2141,8 @@ static int setscheduler(pid_t pid, int p
 	else {
 		retval = -EINVAL;
 		if (policy != SCHED_FIFO && policy != SCHED_RR &&
-				policy != SCHED_NORMAL)
-			goto out_unlock;
+			policy != SCHED_NORMAL && policy !=SCHED_BATCH)
+				goto out_unlock;
 	}
 
 	/*
@@ -2026,8 +2152,9 @@ static int setscheduler(pid_t pid, int p
 	retval = -EINVAL;
 	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
 		goto out_unlock;
-	if ((policy == SCHED_NORMAL) != (lp.sched_priority == 0))
-		goto out_unlock;
+	if ((policy == SCHED_NORMAL || policy == SCHED_BATCH) !=
+		(lp.sched_priority == 0))
+			goto out_unlock;
 
 	retval = -EPERM;
 	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
@@ -2048,7 +2175,7 @@ static int setscheduler(pid_t pid, int p
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
 	oldprio = p->prio;
-	if (policy != SCHED_NORMAL)
+	if (policy != SCHED_NORMAL && policy != SCHED_BATCH)
 		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
@@ -2060,9 +2187,9 @@ static int setscheduler(pid_t pid, int p
 		 * this runqueue and our priority is higher than the current's
 		 */
 		if (rq->curr == p) {
-			if (p->prio > oldprio)
+			if (p->prio > oldprio || batch_task(p))
 				resched_task(rq->curr);
-		} else if (p->prio < rq->curr->prio)
+		} else if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
 	}
 
@@ -2268,7 +2395,10 @@ asmlinkage long sys_sched_yield(void)
 	 */
 	if (likely(!rt_task(current))) {
 		dequeue_task(current, array);
-		enqueue_task(current, rq->expired);
+		if (unlikely(batch_task(current)))
+			enqueue_task(current, rq->batch);
+		else
+			enqueue_task(current, rq->expired);
 	} else {
 		list_del(&current->run_list);
 		list_add_tail(&current->run_list, array->queue + current->prio);
@@ -2353,6 +2483,7 @@ asmlinkage long sys_sched_get_priority_m
 		ret = MAX_USER_RT_PRIO-1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_BATCH:
 		ret = 0;
 		break;
 	}
@@ -2376,6 +2507,7 @@ asmlinkage long sys_sched_get_priority_m
 		ret = 1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_BATCH:
 		ret = 0;
 	}
 	return ret;
@@ -2806,14 +2938,16 @@ void __init sched_init(void)
 		prio_array_t *array;
 
 		rq = cpu_rq(i);
+		rq->cpu = i;
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
+		rq->batch = rq->arrays + 2;
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		atomic_set(&rq->nr_iowait, 0);
 		nr_running_init(rq);
 
-		for (j = 0; j < 2; j++) {
+		for (j = 0; j < 3; j++) {
 			array = rq->arrays + j;
 			for (k = 0; k < MAX_PRIO; k++) {
 				INIT_LIST_HEAD(array->queue + k);

--Boundary-00=_q/kt/xgwrYlGJOs--

