Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272339AbTGYVBo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272374AbTGYVAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 17:00:11 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:26043 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272339AbTGYU6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:58:19 -0400
Date: Fri, 25 Jul 2003 23:13:14 +0200
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.6.0-test1-G3
Message-ID: <20030725231314.A1073@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0307252146550.16235-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0307252146550.16235-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Jul 25, 2003 at 09:59:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> [snip] The patch should also cleanly apply to 2.6.0-test1-bk2.

Actually, it does not, due to the cpumask_t -> unsigned long change. This one
applies.

Rudo.

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sched-2.6.0-test1-bk2-G3"

--- linux/arch/i386/kernel/timers/timer_tsc.c.orig	
+++ linux/arch/i386/kernel/timers/timer_tsc.c	
@@ -116,6 +117,24 @@ static unsigned long long monotonic_cloc
 	return base + cycles_2_ns(this_offset - last_offset);
 }
 
+/*
+ * Scheduler clock - returns current time in nanosec units.
+ */
+unsigned long long sched_clock(void)
+{
+	unsigned long long this_offset;
+
+	if (unlikely(!cpu_has_tsc))
+		return (unsigned long long)jiffies * (1000000000 / HZ);
+
+	/* Read the Time Stamp Counter */
+	rdtscll(this_offset);
+
+	/* return the value in ns */
+	return cycles_2_ns(this_offset);
+}
+
+
 static void mark_offset_tsc(void)
 {
 	unsigned long lost,delay;
--- linux/arch/i386/kernel/smpboot.c.orig	
+++ linux/arch/i386/kernel/smpboot.c	
@@ -915,13 +915,13 @@ static void smp_tune_scheduling (void)
 		cacheflush_time = (cpu_khz>>10) * (cachesize<<10) / bandwidth;
 	}
 
-	cache_decay_ticks = (long)cacheflush_time/cpu_khz * HZ / 1000;
+	cache_decay_ticks = (long)cacheflush_time/cpu_khz + 1;
 
 	printk("per-CPU timeslice cutoff: %ld.%02ld usecs.\n",
 		(long)cacheflush_time/(cpu_khz/1000),
 		((long)cacheflush_time*100/(cpu_khz/1000)) % 100);
 	printk("task migration cache decay timeout: %ld msecs.\n",
-		(cache_decay_ticks + 1) * 1000 / HZ);
+		cache_decay_ticks);
 }
 
 /*
--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -341,7 +341,8 @@ struct task_struct {
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
-	unsigned long last_run;
+	unsigned long long timestamp;
+	int activated;
 
 	unsigned long policy;
 	unsigned long cpus_allowed;
@@ -511,6 +512,8 @@ static inline int set_cpus_allowed(task_
 }
 #endif
 
+extern unsigned long long sched_clock(void);
+
 #ifdef CONFIG_NUMA
 extern void sched_balance_exec(void);
 extern void node_nr_running_init(void);
--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -924,7 +924,7 @@ struct task_struct *copy_process(unsigne
 	 */
 	p->first_time_slice = 1;
 	current->time_slice >>= 1;
-	p->last_run = jiffies;
+	p->timestamp = sched_clock();
 	if (!current->time_slice) {
 		/*
 	 	 * This case is rare, it happens when the parent has only
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -68,12 +68,13 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
+#define TIMESLICE_GRANULARITY	(HZ/20 ?: 1)
 #define CHILD_PENALTY		50
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(10*HZ)
+#define MAX_SLEEP_AVG		(2*1000000000)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
 
@@ -115,6 +116,11 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
+#define TASK_PREEMPTS_CURR(p, rq) \
+	((p)->prio < (rq)->curr->prio || \
+		((p)->prio == (rq)->curr->prio && \
+			(p)->time_slice > (rq)->curr->time_slice * 2))
+
 /*
  * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
  * to time slice values.
@@ -319,8 +325,8 @@ static int effective_prio(task_t *p)
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
-			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
+	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*(p->sleep_avg/1024)/(MAX_SLEEP_AVG/1024)/100;
+	bonus -= MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
 	prio = p->static_prio - bonus;
 	if (prio < MAX_RT_PRIO)
@@ -339,24 +345,24 @@ static inline void __activate_task(task_
 	nr_running_inc(rq);
 }
 
-/*
- * activate_task - move a task to the runqueue and do priority recalculation
- *
- * Update all the scheduling statistics stuff. (sleep average
- * calculation, priority modifiers, etc.)
- */
-static inline void activate_task(task_t *p, runqueue_t *rq)
+static void recalc_task_prio(task_t *p, unsigned long long now)
 {
-	long sleep_time = jiffies - p->last_run - 1;
+	unsigned long long __sleep_time = now - p->timestamp;
+	unsigned long sleep_time;
+
+	if (__sleep_time > MAX_SLEEP_AVG)
+		sleep_time = MAX_SLEEP_AVG;
+	else
+		sleep_time = (unsigned long)__sleep_time;
 
 	if (sleep_time > 0) {
-		int sleep_avg;
+		unsigned long long sleep_avg;
 
 		/*
 		 * This code gives a bonus to interactive tasks.
 		 *
 		 * The boost works by updating the 'average sleep time'
-		 * value here, based on ->last_run. The more time a task
+		 * value here, based on ->timestamp. The more time a task
 		 * spends sleeping, the higher the average gets - and the
 		 * higher the priority boost gets as well.
 		 */
@@ -375,6 +381,23 @@ static inline void activate_task(task_t 
 			p->prio = effective_prio(p);
 		}
 	}
+}
+
+/*
+ * activate_task - move a task to the runqueue and do priority recalculation
+ *
+ * Update all the scheduling statistics stuff. (sleep average
+ * calculation, priority modifiers, etc.)
+ */
+static inline void activate_task(task_t *p, runqueue_t *rq)
+{
+	unsigned long long now = sched_clock();
+
+	recalc_task_prio(p, now);
+
+	p->activated = 1;
+	p->timestamp = now;
+
 	__activate_task(p, rq);
 }
 
@@ -501,7 +524,7 @@ repeat_lock_task:
 				__activate_task(p, rq);
 			else {
 				activate_task(p, rq);
-				if (p->prio < rq->curr->prio)
+				if (TASK_PREEMPTS_CURR(p, rq))
 					resched_task(rq->curr);
 			}
 			success = 1;
@@ -550,8 +573,8 @@ void wake_up_forked_process(task_t * p)
 	 * and children as well, to keep max-interactive tasks
 	 * from forking tasks that are max-interactive.
 	 */
-	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
-	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
+	current->sleep_avg = current->sleep_avg / 100 * PARENT_PENALTY;
+	p->sleep_avg = p->sleep_avg / 100 * CHILD_PENALTY;
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
 
@@ -592,8 +615,7 @@ void sched_exit(task_t * p)
 	 * the sleep_avg of the parent as well.
 	 */
 	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = (p->parent->sleep_avg * EXIT_WEIGHT +
-			p->sleep_avg) / (EXIT_WEIGHT + 1);
+		p->parent->sleep_avg = p->parent->sleep_avg / (EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg / (EXIT_WEIGHT + 1);
 }
 
 /**
@@ -978,13 +1000,8 @@ static inline void pull_task(runqueue_t 
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
 }
 
 /*
@@ -1001,12 +1018,14 @@ static void load_balance(runqueue_t *thi
 	runqueue_t *busiest;
 	prio_array_t *array;
 	struct list_head *head, *curr;
+	unsigned long long now;
 	task_t *tmp;
 
 	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance, cpumask);
 	if (!busiest)
 		goto out;
 
+	now = sched_clock();
 	/*
 	 * We first consider expired tasks. Those will likely not be
 	 * executed in the near future, and they are most likely to
@@ -1052,8 +1071,9 @@ skip_queue:
 	 * 3) are cache-hot on their current CPU.
 	 */
 
+#warning fixme
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
-	((!idle || (jiffies - (p)->last_run > cache_decay_ticks)) &&	\
+	((!idle || (((now - (p)->timestamp)>>10) > cache_decay_ticks)) &&\
 		!task_running(rq, p) &&					\
 			((p)->cpus_allowed & (1UL << (this_cpu))))
 
@@ -1213,14 +1233,11 @@ void scheduler_tick(int user_ticks, int 
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
+	 * timeslice. This makes it possible for interactive tasks
+	 * to use up their timeslices at their highest priority levels.
 	 */
-	if (p->sleep_avg)
-		p->sleep_avg--;
 	if (unlikely(rt_task(p))) {
 		/*
 		 * RR tasks need a special form of timeslice management.
@@ -1244,12 +1261,33 @@ void scheduler_tick(int user_ticks, int 
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq) || 0) {
 			if (!rq->expired_timestamp)
 				rq->expired_timestamp = jiffies;
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
+	} else {
+		/*
+		 * Prevent a too long timeslice allowing a task to monopolize
+		 * the CPU. We do this by splitting up the timeslice into
+		 * smaller pieces.
+		 *
+		 * Note: this does not mean the task's timeslices expire or
+		 * get lost in any way, they just might be preempted by
+		 * another task of equal priority. (one with higher
+		 * priority would have preempted this task already.) We
+		 * requeue this task to the end of the list on this priority
+		 * level, which is in essence a round-robin of tasks with
+		 * equal priority.
+		 */
+		if (!(p->time_slice % TIMESLICE_GRANULARITY) &&
+			       		(p->array == rq->active)) {
+			dequeue_task(p, rq->active);
+			set_tsk_need_resched(p);
+			p->prio = effective_prio(p);
+			enqueue_task(p, rq->active);
+		}
 	}
 out_unlock:
 	spin_unlock(&rq->lock);
@@ -1268,6 +1306,8 @@ asmlinkage void schedule(void)
 	runqueue_t *rq;
 	prio_array_t *array;
 	struct list_head *queue;
+	unsigned long long now;
+	unsigned long run_time;
 	int idx;
 
 	/*
@@ -1288,7 +1328,11 @@ need_resched:
 	rq = this_rq();
 
 	release_kernel_lock(prev);
-	prev->last_run = jiffies;
+	now = sched_clock();
+	if (likely(now - prev->timestamp < MAX_SLEEP_AVG))
+		run_time = now - prev->timestamp;
+	else
+		run_time = MAX_SLEEP_AVG;
 	spin_lock_irq(&rq->lock);
 
 	/*
@@ -1336,12 +1380,25 @@ pick_next_task:
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
+	if (next->activated) {
+		next->activated = 0;
+		array = next->array;
+		dequeue_task(next, array);
+		recalc_task_prio(next, now);
+		enqueue_task(next, array);
+	}
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
 	RCU_qsctr(task_cpu(prev))++;
 
+	prev->sleep_avg -= run_time;
+	if ((long)prev->sleep_avg < 0)
+		prev->sleep_avg = 0;
+	prev->timestamp = now;
+
 	if (likely(prev != next)) {
+		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
 
@@ -2362,6 +2419,12 @@ static void move_task_away(struct task_s
 	local_irq_restore(flags);
 }
 
+typedef struct {
+	int cpu;
+	struct completion startup_done;
+	task_t *task;
+} migration_startup_t;
+
 /*
  * migration_thread - this is a highprio system thread that performs
  * thread migration by bumping thread off CPU then 'pushing' onto
@@ -2371,20 +2434,21 @@ static int migration_thread(void * data)
 {
 	/* Marking "param" __user is ok, since we do a set_fs(KERNEL_DS); */
 	struct sched_param __user param = { .sched_priority = MAX_RT_PRIO-1 };
-	int cpu = (long) data;
+	migration_startup_t *startup = data;
+	int cpu = startup->cpu;
 	runqueue_t *rq;
 	int ret;
 
+	startup->task = current;
+	complete(&startup->startup_done);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule();
+
+	BUG_ON(smp_processor_id() != cpu);
+
 	daemonize("migration/%d", cpu);
 	set_fs(KERNEL_DS);
 
-	/*
-	 * Either we are running on the right CPU, or there's a a
-	 * migration thread on this CPU, guaranteed (we're started
-	 * serially).
-	 */
-	set_cpus_allowed(current, 1UL << cpu);
-
 	ret = setscheduler(0, SCHED_FIFO, &param);
 
 	rq = this_rq();
@@ -2420,13 +2484,30 @@ static int migration_call(struct notifie
 			  unsigned long action,
 			  void *hcpu)
 {
+	long cpu = (long) hcpu;
+	migration_startup_t startup;
+
 	switch (action) {
 	case CPU_ONLINE:
-		printk("Starting migration thread for cpu %li\n",
-		       (long)hcpu);
-		kernel_thread(migration_thread, hcpu, CLONE_KERNEL);
-		while (!cpu_rq((long)hcpu)->migration_thread)
+
+		printk("Starting migration thread for cpu %li\n", cpu);
+
+		startup.cpu = cpu;
+		startup.task = NULL;
+		init_completion(&startup.startup_done);
+
+		kernel_thread(migration_thread, &startup, CLONE_KERNEL);
+		wait_for_completion(&startup.startup_done);
+		wait_task_inactive(startup.task);
+
+		startup.task->thread_info->cpu = cpu;
+		startup.task->cpus_allowed = cpumask_of_cpu(cpu);
+
+		wake_up_process(startup.task);
+
+		while (!cpu_rq(cpu)->migration_thread)
 			yield();
+
 		break;
 	}
 	return NOTIFY_OK;

--DocE+STaALJfprDB--
