Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbTHWLyx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 07:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbTHWLyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 07:54:53 -0400
Received: from dyn-ctb-210-9-245-87.webone.com.au ([210.9.245.87]:12805 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263758AbTHWLx4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 07:53:56 -0400
Message-ID: <3F4755CD.6060307@cyberone.com.au>
Date: Sat, 23 Aug 2003 21:53:49 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.0-test4 scheduler policy
Content-Type: multipart/mixed;
 boundary="------------020307080306010008080406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020307080306010008080406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linux kernel,
Please find attached my CPU scheduler changes against test4. A few
bugs have been fixed up. The known problems are test-starve.c, bad
for compute intensive loads, bad priority distribution (eg. may cause
xmms to skip. must be a bug somewhere).

This is mainly a sync with Linus' tree.


--------------020307080306010008080406
Content-Type: text/plain;
 name="sched-policy-4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-policy-4"

--- linux-2.6/include/linux/sched.h.orig	2003-08-23 19:35:43.000000000 +1000
+++ linux-2.6/include/linux/sched.h	2003-08-23 19:50:28.000000000 +1000
@@ -281,7 +281,9 @@ struct signal_struct {
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
 
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
- 
+
+#define rt_task(p)		((p)->prio < MAX_RT_PRIO)
+
 /*
  * Some day this will be a full-fledged user tracking system..
  */
@@ -339,12 +341,15 @@ struct task_struct {
 	struct list_head run_list;
 	prio_array_t *array;
 
+	unsigned long array_sequence;
+	unsigned long timestamp;
+
 	unsigned long sleep_avg;
-	unsigned long last_run;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
+	unsigned int used_slice;
 
 	struct list_head tasks;
 	struct list_head ptrace_children;
--- linux-2.6/kernel/fork.c.orig	2003-08-23 19:35:36.000000000 +1000
+++ linux-2.6/kernel/fork.c	2003-08-23 19:50:28.000000000 +1000
@@ -917,14 +917,14 @@ struct task_struct *copy_process(unsigne
 	 * resulting in more scheduling fairness.
 	 */
 	local_irq_disable();
-        p->time_slice = (current->time_slice + 1) >> 1;
+	p->timestamp = jiffies; 
+        p->time_slice = (current->time_slice + 2) / 3;
 	/*
 	 * The remainder of the first timeslice might be recovered by
 	 * the parent if the child exits early enough.
 	 */
 	p->first_time_slice = 1;
-	current->time_slice >>= 1;
-	p->last_run = jiffies;
+	current->time_slice = 2 * current->time_slice / 3;
 	if (!current->time_slice) {
 		/*
 	 	 * This case is rare, it happens when the parent has only
--- linux-2.6/kernel/sched.c.orig	2003-08-23 19:35:32.000000000 +1000
+++ linux-2.6/kernel/sched.c	2003-08-23 21:40:34.000000000 +1000
@@ -60,78 +60,52 @@
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
 
 /*
+ * Some helpers for converting nanosecond timing to jiffy resolution
+ */
+#define NS_TO_JIFFIES(TIME)	(TIME / (1000000000 / HZ))
+#define JIFFIES_TO_NS(TIME)	(TIME * (1000000000 / HZ))
+
+#define US_TO_JIFFIES(TIME)	(TIME / (1000000 / HZ))
+#define JIFFIES_TO_US(TIME)	(TIME * (1000000 / HZ))
+
+#define NS_TO_US(TIME)		(TIME / 1000)
+#define US_TO_NS(TIME)		(TIME * 1000)
+
+/*
  * These are the 'tuning knobs' of the scheduler:
  *
  * Minimum timeslice is 10 msecs, default timeslice is 100 msecs,
  * maximum timeslice is 200 msecs. Timeslices get refilled after
  * they expire.
  */
-#define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(200 * HZ / 1000)
-#define CHILD_PENALTY		50
-#define PARENT_PENALTY		100
-#define EXIT_WEIGHT		3
-#define PRIO_BONUS_RATIO	25
-#define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(10*HZ)
-#define STARVATION_LIMIT	(10*HZ)
-#define NODE_THRESHOLD		125
-
-/*
- * If a task is 'interactive' then we reinsert it in the active
- * array after it has expired its current timeslice. (it will not
- * continue to run immediately, it will still roundrobin with
- * other interactive tasks.)
- *
- * This part scales the interactivity limit depending on niceness.
- *
- * We scale it linearly, offset by the INTERACTIVE_DELTA delta.
- * Here are a few examples of different nice levels:
- *
- *  TASK_INTERACTIVE(-20): [1,1,1,1,1,1,1,1,1,0,0]
- *  TASK_INTERACTIVE(-10): [1,1,1,1,1,1,1,0,0,0,0]
- *  TASK_INTERACTIVE(  0): [1,1,1,1,0,0,0,0,0,0,0]
- *  TASK_INTERACTIVE( 10): [1,1,0,0,0,0,0,0,0,0,0]
- *  TASK_INTERACTIVE( 19): [0,0,0,0,0,0,0,0,0,0,0]
- *
- * (the X axis represents the possible -5 ... 0 ... +5 dynamic
- *  priority range a task can explore, a value of '1' means the
- *  task is rated interactive.)
- *
- * Ie. nice +19 tasks can never get 'interactive' enough to be
- * reinserted into the active array. And only heavily CPU-hog nice -20
- * tasks will be expired. Default nice 0 tasks are somewhere between,
- * it takes some effort for them to get interactive, but it's not
- * too hard.
- */
+#define MIN_TIMESLICE		(10 * HZ / 1000)
+#define MAX_TIMESLICE		(100 * HZ / 1000)
 
-#define SCALE(v1,v1_max,v2_max) \
-	(v1) * (v2_max) / (v1_max)
+#define MAX_SLEEP_AVG		(HZ)
 
-#define DELTA(p) \
-	(SCALE(TASK_NICE(p), 40, MAX_USER_PRIO*PRIO_BONUS_RATIO/100) + \
-		INTERACTIVE_DELTA)
+#define NODE_THRESHOLD		125
 
-#define TASK_INTERACTIVE(p) \
-	((p)->prio <= (p)->static_prio - DELTA(p))
+#define TASK_PREEMPTS_CURR(p, rq) \
+	((p)->prio < (rq)->curr->prio)
 
 /*
- * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
- * to time slice values.
- *
  * The higher a thread's priority, the bigger timeslices
  * it gets during one round of execution. But even the lowest
  * priority thread gets MIN_TIMESLICE worth of execution time.
- *
- * task_timeslice() is the interface that is used by the scheduler.
  */
-
-#define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
-	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
-
 static inline unsigned int task_timeslice(task_t *p)
 {
-	return BASE_TIMESLICE(p);
+	unsigned int timeslice = MIN_TIMESLICE +
+		( (MAX_USER_PRIO - USER_PRIO(p->prio))
+		* (MAX_TIMESLICE - MIN_TIMESLICE) )
+		/ MAX_USER_PRIO;
+
+	if (timeslice < MIN_TIMESLICE)
+		timeslice = MIN_TIMESLICE;
+	if (timeslice > MAX_TIMESLICE)
+		timeslice = MAX_TIMESLICE;
+
+	return timeslice;
 }
 
 /*
@@ -157,7 +131,8 @@ struct prio_array {
  */
 struct runqueue {
 	spinlock_t lock;
-	unsigned long nr_running, nr_switches, expired_timestamp,
+	unsigned long array_sequence;
+	unsigned long nr_running, nr_switches,
 			nr_uninterruptible;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
@@ -179,7 +154,6 @@ static DEFINE_PER_CPU(struct runqueue, r
 #define this_rq()		(&__get_cpu_var(runqueues))
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
-#define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
 /*
  * Default context-switch locking:
@@ -298,35 +272,22 @@ static inline void enqueue_task(struct t
 	p->array = array;
 }
 
-/*
- * effective_prio - return the priority that is based on the static
- * priority but is modified by bonuses/penalties.
- *
- * We scale the actual sleep average [0 .... MAX_SLEEP_AVG]
- * into the -5 ... 0 ... +5 bonus/penalty range.
- *
- * We use 25% of the full 0...39 priority range so that:
- *
- * 1) nice +19 interactive tasks do not preempt nice 0 CPU hogs.
- * 2) nice -20 CPU hogs do not get preempted by nice 0 tasks.
- *
- * Both properties are important to certain workloads.
- */
-static int effective_prio(task_t *p)
+static unsigned long task_priority(task_t *p)
 {
 	int bonus, prio;
 
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
-			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
+	bonus = (MAX_USER_PRIO * p->sleep_avg) / MAX_SLEEP_AVG / 2;
+	prio = USER_PRIO(p->static_prio) + (MAX_USER_PRIO / 4);
 
-	prio = p->static_prio - bonus;
+	prio = MAX_RT_PRIO + prio - bonus;
 	if (prio < MAX_RT_PRIO)
 		prio = MAX_RT_PRIO;
 	if (prio > MAX_PRIO-1)
 		prio = MAX_PRIO-1;
+
 	return prio;
 }
 
@@ -347,34 +308,39 @@ static inline void __activate_task(task_
  */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	long sleep_time = jiffies - p->last_run - 1;
+	unsigned long now = jiffies;
+	unsigned long s = now - p->timestamp;
 
-	if (sleep_time > 0) {
-		int sleep_avg;
+	if (s > MAX_SLEEP_AVG)
+		s = MAX_SLEEP_AVG;
 
-		/*
-		 * This code gives a bonus to interactive tasks.
-		 *
-		 * The boost works by updating the 'average sleep time'
-		 * value here, based on ->last_run. The more time a task
-		 * spends sleeping, the higher the average gets - and the
-		 * higher the priority boost gets as well.
-		 */
-		sleep_avg = p->sleep_avg + sleep_time;
+	if (!in_interrupt() && current->mm) {
+		unsigned long boost = s/2;
+		if (current->sleep_avg + boost > MAX_SLEEP_AVG)
+			boost = MAX_SLEEP_AVG - current->sleep_avg;
+		current->sleep_avg += boost;
+		p->sleep_avg += s - boost;
+	} else
+		p->sleep_avg += s;
 
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
-		}
+	if (p->sleep_avg > MAX_SLEEP_AVG)
+		p->sleep_avg = MAX_SLEEP_AVG;
+
+	p->prio = task_priority(p);
+
+	if (rq->array_sequence != p->array_sequence) {
+		p->used_slice = 0;
+		p->time_slice = task_timeslice(p);
+	}
+
+	if (!in_interrupt() && current->mm) {
+		unsigned long steal;
+		steal = min((unsigned int)s / 2,
+				(p->time_slice - p->used_slice) / 2);
+		p->time_slice -= steal;
+		current->time_slice += steal;
 	}
+
 	__activate_task(p, rq);
 }
 
@@ -383,10 +349,12 @@ static inline void activate_task(task_t 
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
+	p->array_sequence = rq->array_sequence;
 	nr_running_dec(rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
+	p->timestamp = jiffies;
 	p->array = NULL;
 }
 
@@ -426,7 +394,7 @@ static inline void resched_task(task_t *
  * be called with interrupts off, or it may introduce deadlock with
  * smp_call_function() if an IPI is sent by the same process we are
  * waiting to become inactive.
- */
+ n*/
 void wait_task_inactive(task_t * p)
 {
 	unsigned long flags;
@@ -497,11 +465,9 @@ repeat_lock_task:
 			}
 			if (old_state == TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible--;
-			if (sync)
-				__activate_task(p, rq);
-			else {
-				activate_task(p, rq);
-				if (p->prio < rq->curr->prio)
+			activate_task(p, rq);
+			if (!sync) {
+				if (TASK_PREEMPTS_CURR(p, rq))
 					resched_task(rq->curr);
 			}
 			success = 1;
@@ -539,31 +505,30 @@ int wake_up_state(task_t *p, unsigned in
  * This function will do some initial scheduler statistics housekeeping
  * that must be done for every newly created process.
  */
-void wake_up_forked_process(task_t * p)
+void wake_up_forked_process(task_t *p)
 {
 	unsigned long flags;
 	runqueue_t *rq = task_rq_lock(current, &flags);
 
 	p->state = TASK_RUNNING;
-	/*
-	 * We decrease the sleep average of forking parents
-	 * and children as well, to keep max-interactive tasks
-	 * from forking tasks that are max-interactive.
-	 */
-	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
-	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
-	p->prio = effective_prio(p);
+
 	set_task_cpu(p, smp_processor_id());
 
-	if (unlikely(!current->array))
-		__activate_task(p, rq);
-	else {
-		p->prio = current->prio;
-		list_add_tail(&p->run_list, &current->run_list);
-		p->array = current->array;
-		p->array->nr_active++;
-		nr_running_inc(rq);
-	}
+#if 0
+	current->sleep_time = 3 * (current->sleep_time) / 4;
+	if (current->total_time != 0)
+		current->sleep_avg = (100 * current->sleep_time)
+						/ current->total_time;
+	p->sleep_time = current->sleep_time / 4;
+	p->total_time = current->total_time / 4;
+	p->sleep_avg = current->sleep_avg;
+#endif
+	p->sleep_avg = 4 * current->sleep_avg / 5;
+	current->sleep_avg = 3 * current->sleep_avg / 4;
+
+	p->prio = task_priority(p);
+	__activate_task(p, rq);
+
 	task_rq_unlock(rq, &flags);
 }
 
@@ -581,19 +546,9 @@ void sched_exit(task_t * p)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	if (p->first_time_slice) {
-		p->parent->time_slice += p->time_slice;
-		if (unlikely(p->parent->time_slice > MAX_TIMESLICE))
-			p->parent->time_slice = MAX_TIMESLICE;
-	}
+	if (p->first_time_slice)
+		p->parent->time_slice += p->time_slice - p->used_slice;
 	local_irq_restore(flags);
-	/*
-	 * If the child was a (relative-) CPU hog then decrease
-	 * the sleep_avg of the parent as well.
-	 */
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = (p->parent->sleep_avg * EXIT_WEIGHT +
-			p->sleep_avg) / (EXIT_WEIGHT + 1);
 }
 
 /**
@@ -995,13 +950,29 @@ static inline void pull_task(runqueue_t 
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
 	 */
-	if (p->prio < this_rq->curr->prio)
+	if (TASK_PREEMPTS_CURR(p, this_rq))
 		set_need_resched();
-	else {
-		if (p->prio == this_rq->curr->prio &&
-				p->time_slice > this_rq->curr->time_slice)
-			set_need_resched();
-	}
+}
+
+/*
+ * comment me
+ */
+
+static inline int
+can_migrate_task(task_t *tsk, runqueue_t *rq, int this_cpu, int idle)
+{
+	unsigned long delta;
+
+	if (task_running(rq, tsk))
+		return 0;
+	if (!cpu_isset(this_cpu, tsk->cpus_allowed))
+		return 0;
+
+	delta = jiffies - tsk->timestamp;
+	if (idle && (delta <= cache_decay_ticks))
+		return 0;
+
+	return 1;
 }
 
 /*
@@ -1063,14 +1034,9 @@ skip_queue:
 	 * 3) are cache-hot on their current CPU.
 	 */
 
-#define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
-	((!idle || (jiffies - (p)->last_run > cache_decay_ticks)) &&	\
-		!task_running(rq, p) &&					\
-			cpu_isset(this_cpu, (p)->cpus_allowed))
-
 	curr = curr->prev;
 
-	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
+	if (!can_migrate_task(tmp, busiest, this_cpu, idle)) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -1171,20 +1137,6 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
 EXPORT_PER_CPU_SYMBOL(kstat);
 
 /*
- * We place interactive tasks back into the active array, if possible.
- *
- * To guarantee that this does not starve expired tasks we ignore the
- * interactivity of a task if the first expired task had to wait more
- * than a 'reasonable' amount of time. This deadline timeout is
- * load-dependent, as the frequency of array switched decreases with
- * increasing number of running tasks:
- */
-#define EXPIRED_STARVING(rq) \
-		(STARVATION_LIMIT && ((rq)->expired_timestamp && \
-		(jiffies - (rq)->expired_timestamp >= \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
-
-/*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  *
@@ -1201,17 +1153,11 @@ void scheduler_tick(int user_ticks, int 
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
 
-	/* note: this timer irq context must be accounted for as well */
-	if (hardirq_count() - HARDIRQ_OFFSET) {
-		cpustat->irq += sys_ticks;
-		sys_ticks = 0;
-	} else if (softirq_count()) {
-		cpustat->softirq += sys_ticks;
-		sys_ticks = 0;
-	}
-
 	if (p == rq->idle) {
-		if (atomic_read(&rq->nr_iowait) > 0)
+		/* note: this timer irq context must be accounted for as well */
+		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
+			cpustat->system += sys_ticks;
+		else if (atomic_read(&rq->nr_iowait) > 0)
 			cpustat->iowait += sys_ticks;
 		else
 			cpustat->idle += sys_ticks;
@@ -1232,43 +1178,41 @@ void scheduler_tick(int user_ticks, int 
 	spin_lock(&rq->lock);
 	/*
 	 * The task was running during this tick - update the
-	 * time slice counter and the sleep average. Note: we
-	 * do not update a thread's priority until it either
-	 * goes to sleep or uses up its timeslice. This makes
-	 * it possible for interactive tasks to use up their
-	 * timeslices at their highest priority levels.
+	 * time slice counter. Note: we do not update a thread's
+	 * priority until it either goes to sleep or uses up its
+	 * timeslice.
 	 */
-	if (p->sleep_avg)
-		p->sleep_avg--;
 	if (unlikely(rt_task(p))) {
 		/*
 		 * RR tasks need a special form of timeslice management.
 		 * FIFO tasks have no timeslices.
 		 */
-		if ((p->policy == SCHED_RR) && !--p->time_slice) {
-			p->time_slice = task_timeslice(p);
-			p->first_time_slice = 0;
-			set_tsk_need_resched(p);
-
-			/* put it at the end of the queue: */
-			dequeue_task(p, rq->active);
-			enqueue_task(p, rq->active);
+		if (p->policy == SCHED_RR) {
+			p->used_slice++;
+			if (p->used_slice >= p->time_slice) {
+				p->used_slice = 0;
+				p->time_slice = task_timeslice(p);
+				p->first_time_slice = 0;
+				set_tsk_need_resched(p);
+
+				/* put it at the end of the queue: */
+				dequeue_task(p, rq->active);
+				enqueue_task(p, rq->active);
+			}
 		}
 		goto out_unlock;
 	}
-	if (!--p->time_slice) {
+
+	p->used_slice++;
+	if (p->used_slice >= p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
-		p->prio = effective_prio(p);
+		p->prio = task_priority(p);
 		p->time_slice = task_timeslice(p);
+		p->used_slice = 0;
 		p->first_time_slice = 0;
 
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			if (!rq->expired_timestamp)
-				rq->expired_timestamp = jiffies;
-			enqueue_task(p, rq->expired);
-		} else
-			enqueue_task(p, rq->active);
+		enqueue_task(p, rq->expired);
 	}
 out_unlock:
 	spin_unlock(&rq->lock);
@@ -1287,6 +1231,8 @@ asmlinkage void schedule(void)
 	runqueue_t *rq;
 	prio_array_t *array;
 	struct list_head *queue;
+	unsigned long now;
+	unsigned long run_time;
 	int idx;
 
 	/*
@@ -1307,7 +1253,13 @@ need_resched:
 	rq = this_rq();
 
 	release_kernel_lock(prev);
-	prev->last_run = jiffies;
+	now = jiffies;
+	run_time = now - prev->timestamp;
+	if (prev->sleep_avg <= run_time)
+		prev->sleep_avg = 0;
+	else
+		prev->sleep_avg -= run_time;
+
 	spin_lock_irq(&rq->lock);
 
 	/*
@@ -1336,7 +1288,6 @@ pick_next_task:
 			goto pick_next_task;
 #endif
 		next = rq->idle;
-		rq->expired_timestamp = 0;
 		goto switch_tasks;
 	}
 
@@ -1345,10 +1296,10 @@ pick_next_task:
 		/*
 		 * Switch the active and expired arrays.
 		 */
+		rq->array_sequence++;
 		rq->active = rq->expired;
 		rq->expired = array;
 		array = rq->active;
-		rq->expired_timestamp = 0;
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
@@ -1361,6 +1312,7 @@ switch_tasks:
 	RCU_qsctr(task_cpu(prev))++;
 
 	if (likely(prev != next)) {
+		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
 
@@ -1600,6 +1552,7 @@ void set_user_nice(task_t *p, long nice)
 	unsigned long flags;
 	prio_array_t *array;
 	runqueue_t *rq;
+	int old_prio, new_prio, delta;
 
 	if (TASK_NICE(p) == nice || nice < -20 || nice > 19)
 		return;
@@ -1608,6 +1561,12 @@ void set_user_nice(task_t *p, long nice)
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
 	rq = task_rq_lock(p, &flags);
+	/*
+	 * The RT priorities are set via setscheduler(), but we still
+	 * allow the 'normal' nice value to be set - but as expected
+	 * it wont have any effect on scheduling until the task is
+	 * not SCHED_NORMAL:
+	 */
 	if (rt_task(p)) {
 		p->static_prio = NICE_TO_PRIO(nice);
 		goto out_unlock;
@@ -1615,16 +1574,20 @@ void set_user_nice(task_t *p, long nice)
 	array = p->array;
 	if (array)
 		dequeue_task(p, array);
+
+	old_prio = p->prio;
+	new_prio = NICE_TO_PRIO(nice);
+	delta = new_prio - old_prio;
 	p->static_prio = NICE_TO_PRIO(nice);
-	p->prio = NICE_TO_PRIO(nice);
+	p->prio += delta;
+
 	if (array) {
 		enqueue_task(p, array);
 		/*
-		 * If the task is running and lowered its priority,
-		 * or increased its priority then reschedule its CPU:
+		 * If the task increased its priority or is running and
+		 * lowered its priority, then reschedule its CPU:
 		 */
-		if ((NICE_TO_PRIO(nice) < p->static_prio) ||
-							task_running(rq, p))
+		if (delta < 0 || (delta > 0 && task_running(rq, p)))
 			resched_task(rq->curr);
 	}
 out_unlock:

--------------020307080306010008080406--

