Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbTCGJxD>; Fri, 7 Mar 2003 04:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261467AbTCGJxD>; Fri, 7 Mar 2003 04:53:03 -0500
Received: from mx1.elte.hu ([157.181.1.137]:60577 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261464AbTCGJw4>;
	Fri, 7 Mar 2003 04:52:56 -0500
Date: Fri, 7 Mar 2003 11:03:02 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: [patch] "interactivity changes", sched-2.5.64-B2
In-Reply-To: <5.2.0.9.2.20030307103430.00c87df8@pop.gmx.net>
Message-ID: <Pine.LNX.4.44.0303071049500.7326-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've attached the -B2 patch (against vanilla 2.5.64), which, with its
default settings, should be equivalent to what -B0 was supposed to be.
(ie. the only change is that the priority backboost is immediately
propagated into current's priority.)

-B2 also has all scheduler tunables exported into /proc/sys/kernel/, for
testing/development purposes only. The following values are now tunable:  
MIN_TIMESLICE, MAX_TIMESLICE, CHILD_PENALTY, PARENT_PENALTY, EXIT_WEIGHT,
PRIO_BONUS_RATIO, PRIO_BONUS_RATIO, INTERACTIVE_DELTA, WAKER_BONUS_RATIO,
MAX_SLEEP_AVG, STARVATION_LIMIT, NODE_THRESHOLD.

NOTE: you really have to know which value means what, some combinations
might cause a broken scheduler & cause crashes. Eg. dont even attempt to
set a smaller min timeslice than max timeslice, and dont set any of them
to 0.

NOTE2: when setting these tunables, always make sure to reach an 'idle'
scheduling state first. While it's safe to change these values on the fly,
it makes little sense to eg. set them while a kernel compile is ongoing -
the make processes might have accumulated dynamic priority already. The
recommended way to set these tunables is to stop everything in the system,
(X can stay around, it should just be mostly idle) and wait 10 seconds (or
the timeout you use for MAX_SLEEP_AVG), so that all the sleep-averages get
back to an 'idle' state. Then start whatever workload you do to test
interactivity, from scratch.

i've also implemented a new tunable, WAKER_BONUS_RATIO, which implements
Linus' idea of sharing the boost between waker and wakee in a more
immediate way. It defaults to 0 currently, but you might want to try to
set it to 50%, or 25%, or even 75%.

The -B2 patch has the following changes over -A6 (BK-curr):

 - fix a (now-) bug in kernel/softirq.c, it did a wakeup outside any
   atomic regions, which falsely identified random processes as a
   non-atomic wakeup, and which causes random priority boost to be
   distributed.

 - reset the initial idle thread's priority back to PRIO_MAX after doing
   the wakeup_forked_process() - correct preemption relies on this.

 - introduce WAKER_BONUS_RATIO

 - update current->prio immediately after a backboost.

 - clean up effective_prio() & sleep_avg calculations so that there are
   fewer RT-task special cases. This, besides resulting in a much cleaner
   WAKER_BONUS_RATIO code, also has the advantage of the sleep_avg being
   maintained even for RT tasks - this could be advantegous for tasks that
   briefly enter/exit RT mode.

	Ingo

--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -328,7 +328,7 @@ struct task_struct {
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
-	unsigned long sleep_timestamp;
+	unsigned long last_run;
 
 	unsigned long policy;
 	unsigned long cpus_allowed;
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -54,20 +54,21 @@
 /*
  * These are the 'tuning knobs' of the scheduler:
  *
- * Minimum timeslice is 10 msecs, default timeslice is 150 msecs,
- * maximum timeslice is 300 msecs. Timeslices get refilled after
+ * Minimum timeslice is 10 msecs, default timeslice is 100 msecs,
+ * maximum timeslice is 200 msecs. Timeslices get refilled after
  * they expire.
  */
-#define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(300 * HZ / 1000)
-#define CHILD_PENALTY		95
-#define PARENT_PENALTY		100
-#define EXIT_WEIGHT		3
-#define PRIO_BONUS_RATIO	25
-#define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(2*HZ)
-#define STARVATION_LIMIT	(2*HZ)
-#define NODE_THRESHOLD          125
+unsigned int MIN_TIMESLICE =		( 10 * HZ / 1000);
+unsigned int MAX_TIMESLICE =		(200 * HZ / 1000);
+unsigned int CHILD_PENALTY =		50;
+unsigned int PARENT_PENALTY =		100;
+unsigned int EXIT_WEIGHT =		3;
+unsigned int PRIO_BONUS_RATIO =		25;
+unsigned int INTERACTIVE_DELTA =	2;
+unsigned int WAKER_BONUS_RATIO =	0;
+unsigned int MAX_SLEEP_AVG =		(10*HZ);
+unsigned int STARVATION_LIMIT =		(10*HZ);
+unsigned int NODE_THRESHOLD =		125;
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -302,10 +303,13 @@ static inline void enqueue_task(struct t
  *
  * Both properties are important to certain workloads.
  */
-static inline int effective_prio(task_t *p)
+static int effective_prio(task_t *p)
 {
 	int bonus, prio;
 
+	if (rt_task(p))
+		return p->prio;
+
 	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
@@ -323,26 +327,61 @@ static inline int effective_prio(task_t 
  * Also update all the scheduling statistics stuff. (sleep average
  * calculation, priority modifiers, etc.)
  */
+static inline void __activate_task(task_t *p, runqueue_t *rq)
+{
+	enqueue_task(p, rq->active);
+	rq->nr_running++;
+}
+
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	unsigned long sleep_time = jiffies - p->sleep_timestamp;
-	prio_array_t *array = rq->active;
+	unsigned long sleep_time = jiffies - p->last_run;
 
-	if (!rt_task(p) && sleep_time) {
+	if (sleep_time) {
+		int waker_bonus = 0;
 		/*
-		 * This code gives a bonus to interactive tasks. We update
-		 * an 'average sleep time' value here, based on
-		 * sleep_timestamp. The more time a task spends sleeping,
-		 * the higher the average gets - and the higher the priority
-		 * boost gets as well.
+		 * This code gives a bonus to interactive tasks. For
+		 * asynchronous wakeups all the bonus goes to the woken up
+		 * task. For non-atomic-context wakeups, the bonus is
+		 * shared between the waker and the woken up task. Via
+		 * this we recognize the waker as being related to the
+		 * 'interactiveness' of the woken up task.
+		 *
+		 * The boost works by updating the 'average sleep time'
+		 * value here, based on ->last_run. The more time a task
+		 * spends sleeping, the higher the average gets - and the
+		 * higher the priority boost gets as well.
 		 */
-		p->sleep_avg += sleep_time;
-		if (p->sleep_avg > MAX_SLEEP_AVG)
+		if (!in_interrupt())
+			waker_bonus = sleep_time * WAKER_BONUS_RATIO / 100;
+
+		p->sleep_avg += sleep_time - waker_bonus;
+
+		/*
+		 * 'Overflow' bonus ticks go to the waker as well, so the
+		 * ticks are not lost. This has the effect of further
+		 * boosting tasks that are related to maximum-interactive
+		 * tasks.
+		 */
+		if (p->sleep_avg > MAX_SLEEP_AVG) {
+			waker_bonus += p->sleep_avg - MAX_SLEEP_AVG;
 			p->sleep_avg = MAX_SLEEP_AVG;
-		p->prio = effective_prio(p);
+		}
+ 		p->prio = effective_prio(p);
+
+		if (!in_interrupt()) {
+			prio_array_t *array = current->array;
+			BUG_ON(!array);
+
+			current->sleep_avg += waker_bonus;
+			if (current->sleep_avg > MAX_SLEEP_AVG)
+				current->sleep_avg = MAX_SLEEP_AVG;
+			dequeue_task(current, array);
+			current->prio = effective_prio(current);
+			enqueue_task(current, array);
+		}
 	}
-	enqueue_task(p, array);
-	nr_running_inc(rq);
+	__activate_task(p, rq);
 }
 
 /*
@@ -479,10 +518,13 @@ repeat_lock_task:
 			}
 			if (old_state == TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible--;
-			activate_task(p, rq);
-	
-			if (p->prio < rq->curr->prio)
-				resched_task(rq->curr);
+			if (sync)
+				__activate_task(p, rq);
+			else {
+				activate_task(p, rq);
+				if (p->prio < rq->curr->prio)
+					resched_task(rq->curr);
+			}
 			success = 1;
 		}
 		p->state = TASK_RUNNING;
@@ -514,19 +556,25 @@ void wake_up_forked_process(task_t * p)
 	runqueue_t *rq = task_rq_lock(current, &flags);
 
 	p->state = TASK_RUNNING;
-	if (!rt_task(p)) {
-		/*
-		 * We decrease the sleep average of forking parents
-		 * and children as well, to keep max-interactive tasks
-		 * from forking tasks that are max-interactive.
-		 */
-		current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
-		p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
-		p->prio = effective_prio(p);
-	}
+	/*
+	 * We decrease the sleep average of forking parents
+	 * and children as well, to keep max-interactive tasks
+	 * from forking tasks that are max-interactive.
+	 */
+	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
+	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
+	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
-	activate_task(p, rq);
 
+	if (unlikely(!current->array))
+		__activate_task(p, rq);
+	else {
+		p->prio = current->prio;
+		list_add_tail(&p->run_list, &current->run_list);
+		p->array = current->array;
+		p->array->nr_active++;
+		rq->nr_running++;
+	}
 	task_rq_unlock(rq, &flags);
 }
 
@@ -953,6 +1001,11 @@ static inline void pull_task(runqueue_t 
 	 */
 	if (p->prio < this_rq->curr->prio)
 		set_need_resched();
+	else {
+		if (p->prio == this_rq->curr->prio &&
+				p->time_slice > this_rq->curr->time_slice)
+			set_need_resched();
+	}
 }
 
 /*
@@ -1016,7 +1069,7 @@ skip_queue:
 	 */
 
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
-	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
+	((jiffies - (p)->last_run > cache_decay_ticks) &&	\
 		!task_running(rq, p) &&					\
 			((p)->cpus_allowed & (1UL << (this_cpu))))
 
@@ -1076,9 +1129,9 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
  * increasing number of running tasks:
  */
 #define EXPIRED_STARVING(rq) \
-		((rq)->expired_timestamp && \
+		(STARVATION_LIMIT && ((rq)->expired_timestamp && \
 		(jiffies - (rq)->expired_timestamp >= \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1))
+			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
 
 /*
  * This function gets called by the timer code, with HZ frequency.
@@ -1121,6 +1174,16 @@ void scheduler_tick(int user_ticks, int 
 		return;
 	}
 	spin_lock(&rq->lock);
+	/*
+	 * The task was running during this tick - update the
+	 * time slice counter and the sleep average. Note: we
+	 * do not update a thread's priority until it either
+	 * goes to sleep or uses up its timeslice. This makes
+	 * it possible for interactive tasks to use up their
+	 * timeslices at their highest priority levels.
+	 */
+	if (p->sleep_avg)
+		p->sleep_avg--;
 	if (unlikely(rt_task(p))) {
 		/*
 		 * RR tasks need a special form of timeslice management.
@@ -1137,16 +1200,6 @@ void scheduler_tick(int user_ticks, int 
 		}
 		goto out;
 	}
-	/*
-	 * The task was running during this tick - update the
-	 * time slice counter and the sleep average. Note: we
-	 * do not update a thread's priority until it either
-	 * goes to sleep or uses up its timeslice. This makes
-	 * it possible for interactive tasks to use up their
-	 * timeslices at their highest priority levels.
-	 */
-	if (p->sleep_avg)
-		p->sleep_avg--;
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
@@ -1201,7 +1254,7 @@ need_resched:
 	rq = this_rq();
 
 	release_kernel_lock(prev);
-	prev->sleep_timestamp = jiffies;
+	prev->last_run = jiffies;
 	spin_lock_irq(&rq->lock);
 
 	/*
@@ -1701,7 +1754,7 @@ static int setscheduler(pid_t pid, int p
 	else
 		p->prio = p->static_prio;
 	if (array)
-		activate_task(p, task_rq(p));
+		__activate_task(p, task_rq(p));
 
 out_unlock:
 	task_rq_unlock(rq, &flags);
@@ -2442,6 +2495,7 @@ void __init sched_init(void)
 	rq->idle = current;
 	set_task_cpu(current, smp_processor_id());
 	wake_up_forked_process(current);
+	current->prio = MAX_PRIO;
 
 	init_timers();
 
--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -916,7 +916,7 @@ static struct task_struct *copy_process(
 	 */
 	p->first_time_slice = 1;
 	current->time_slice >>= 1;
-	p->sleep_timestamp = jiffies;
+	p->last_run = jiffies;
 	if (!current->time_slice) {
 		/*
 	 	 * This case is rare, it happens when the parent has only
--- linux/kernel/sysctl.c.orig	
+++ linux/kernel/sysctl.c	
@@ -43,6 +43,7 @@
 
 /* External variables not in a header file. */
 extern int panic_timeout;
+extern unsigned int MIN_TIMESLICE, MAX_TIMESLICE, CHILD_PENALTY, PARENT_PENALTY, EXIT_WEIGHT, PRIO_BONUS_RATIO, PRIO_BONUS_RATIO, INTERACTIVE_DELTA, WAKER_BONUS_RATIO, MAX_SLEEP_AVG, STARVATION_LIMIT, NODE_THRESHOLD;
 extern int C_A_D;
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
@@ -172,6 +173,28 @@ static ctl_table kern_table[] = {
 	 0644, NULL, &proc_doutsstring, &sysctl_string},
 	{KERN_PANIC, "panic", &panic_timeout, sizeof(int),
 	 0644, NULL, &proc_dointvec},
+	{KERN_PANIC, "MIN_TIMESLICE", &MIN_TIMESLICE, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_PANIC, "MAX_TIMESLICE", &MAX_TIMESLICE, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_PANIC, "CHILD_PENALTY", &CHILD_PENALTY, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_PANIC, "PARENT_PENALTY", &PARENT_PENALTY, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_PANIC, "EXIT_WEIGHT", &EXIT_WEIGHT, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_PANIC, "PRIO_BONUS_RATIO", &PRIO_BONUS_RATIO, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_PANIC, "INTERACTIVE_DELTA", &INTERACTIVE_DELTA, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_PANIC, "WAKER_BONUS_RATIO", &WAKER_BONUS_RATIO, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_PANIC, "MAX_SLEEP_AVG", &MAX_SLEEP_AVG, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_PANIC, "STARVATION_LIMIT", &STARVATION_LIMIT, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_PANIC, "NODE_THRESHOLD", &NODE_THRESHOLD, sizeof(int),
+	 0644, NULL, &proc_dointvec},
 	{KERN_CORE_USES_PID, "core_uses_pid", &core_uses_pid, sizeof(int),
 	 0644, NULL, &proc_dointvec},
 	{KERN_CORE_PATTERN, "core_pattern", core_pattern, 64,
--- linux/kernel/softirq.c.orig	
+++ linux/kernel/softirq.c	
@@ -92,10 +92,9 @@ restart:
 			mask &= ~pending;
 			goto restart;
 		}
-		__local_bh_enable();
-
 		if (pending)
 			wakeup_softirqd(cpu);
+		__local_bh_enable();
 	}
 
 	local_irq_restore(flags);

