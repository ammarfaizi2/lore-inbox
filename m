Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTKWXQb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 18:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbTKWXQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 18:16:31 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:29886
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263486AbTKWXQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 18:16:13 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Demo patch - no interactivity 2.6
Date: Mon, 24 Nov 2003 10:16:08 +1100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4+Tw/AzDosIoym1"
Message-Id: <200311241016.08990.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_4+Tw/AzDosIoym1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I created this patch for demonstration purposes.

People have raised concerns about the overhead of the interactivity estimator 
in 2.6 and it's effect on throughput. Some anecdotes report wild accusations 
of 20% loss (without hard data). While others believe there is no need for 
interactivity estimation in the kernel with modern cpus.  

The work put in by myself to fine tune the estimator was carefully checked to 
ensure there were no regressions to performance and there have actually been 
minor improvements along the way. Beyond this is the interactivity estimator 
infrastructure already in place.

The estimator should not somehow make your cpu 20% slower unless something is 
horribly wrong. It simply reorders which tasks go first, and if they do get 
to go first they round robin more frequently. Overall within a larger 
timespace the amount of time taken to do the work is the same (or slightly 
better in some settings). Delaying the cpu bound tasks and then letting them 
run for a longer timeslice when there is a larger cpu window allows them to 
benefit more from cpu cache. While the code looks complicated, the overhead 
is miniscule.

So to demonstrate this more clearly, here is a patch that removes the 
interactivity estimator entirely, leaving the scheduler mechanism otherwise 
unchanged. No tasks get dynamic priority changes, and all tasks are allowed 
to run out their full timeslice and will then expire. There is no selective 
reinsertion into the active array. This deletes about 350 lines of code.

I have benchmarked this patch in a range of different benchmarks, and tried 
using it in real world settings.  There is no demonstrable performance 
benefit to this patch. Cpu throughput is the same in my testing (up to 16x). 
Not surprisingly, interactivity of this is also quite appalling. At rest it 
is fine, but as any load is placed on the system, X stutters and jerks. Audio 
is not too bad actually as a consequence of the fact that audio threads go to 
sleep before they expire so they always wake up in the active array and will 
not have too long a scheduling latency from there.

I do not recommend you use this patch in any real world setting as it is 
mildly DOS exploitable by repeated waking tasks, but otherwise works fine. I 
guess there are some embedded devices or specific one-use settings for the 
kernel where this would be ok to use. The only other setting I could think of 
is as a base patch for re-writing a new interactivity estimator from scratch.

Con

--Boundary-00=_4+Tw/AzDosIoym1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-test9-noint"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-test9-noint"

diff -Naurp linux-2.6.0-test9/arch/i386/kernel/timers/timer_tsc.c linux-2.6.0-test9-noint/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.0-test9/arch/i386/kernel/timers/timer_tsc.c	2003-10-18 15:20:14.000000000 +1000
+++ linux-2.6.0-test9-noint/arch/i386/kernel/timers/timer_tsc.c	2003-11-23 02:41:16.000000000 +1100
@@ -127,30 +127,6 @@ static unsigned long long monotonic_cloc
 	return base + cycles_2_ns(this_offset - last_offset);
 }
 
-/*
- * Scheduler clock - returns current time in nanosec units.
- */
-unsigned long long sched_clock(void)
-{
-	unsigned long long this_offset;
-
-	/*
-	 * In the NUMA case we dont use the TSC as they are not
-	 * synchronized across all CPUs.
-	 */
-#ifndef CONFIG_NUMA
-	if (unlikely(!cpu_has_tsc))
-#endif
-		return (unsigned long long)jiffies * (1000000000 / HZ);
-
-	/* Read the Time Stamp Counter */
-	rdtscll(this_offset);
-
-	/* return the value in ns */
-	return cycles_2_ns(this_offset);
-}
-
-
 static void mark_offset_tsc(void)
 {
 	unsigned long lost,delay;
diff -Naurp linux-2.6.0-test9/fs/proc/array.c linux-2.6.0-test9-noint/fs/proc/array.c
--- linux-2.6.0-test9/fs/proc/array.c	2003-10-18 15:20:17.000000000 +1000
+++ linux-2.6.0-test9-noint/fs/proc/array.c	2003-11-23 02:41:16.000000000 +1100
@@ -154,7 +154,6 @@ static inline char * task_state(struct t
 	read_lock(&tasklist_lock);
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
-		"SleepAVG:\t%lu%%\n"
 		"Tgid:\t%d\n"
 		"Pid:\t%d\n"
 		"PPid:\t%d\n"
@@ -162,7 +161,6 @@ static inline char * task_state(struct t
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
-		(p->sleep_avg/1024)*100/(1000000000/1024),
 	       	p->tgid,
 		p->pid, p->pid ? p->real_parent->pid : 0,
 		p->pid && p->ptrace ? p->parent->pid : 0,
diff -Naurp linux-2.6.0-test9/include/linux/sched.h linux-2.6.0-test9-noint/include/linux/sched.h
--- linux-2.6.0-test9/include/linux/sched.h	2003-10-18 15:20:19.000000000 +1000
+++ linux-2.6.0-test9-noint/include/linux/sched.h	2003-11-23 02:41:16.000000000 +1100
@@ -343,11 +343,6 @@ struct task_struct {
 	struct list_head run_list;
 	prio_array_t *array;
 
-	unsigned long sleep_avg;
-	long interactive_credit;
-	unsigned long long timestamp;
-	int activated;
-
 	unsigned long policy;
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
diff -Naurp linux-2.6.0-test9/kernel/fork.c linux-2.6.0-test9-noint/kernel/fork.c
--- linux-2.6.0-test9/kernel/fork.c	2003-10-18 15:20:19.000000000 +1000
+++ linux-2.6.0-test9-noint/kernel/fork.c	2003-11-23 02:41:16.000000000 +1100
@@ -960,7 +960,6 @@ struct task_struct *copy_process(unsigne
 	 */
 	p->first_time_slice = 1;
 	current->time_slice >>= 1;
-	p->timestamp = sched_clock();
 	if (!current->time_slice) {
 		/*
 	 	 * This case is rare, it happens when the parent has only
diff -Naurp linux-2.6.0-test9/kernel/sched.c linux-2.6.0-test9-noint/kernel/sched.c
--- linux-2.6.0-test9/kernel/sched.c	2003-10-26 07:52:58.000000000 +1100
+++ linux-2.6.0-test9-noint/kernel/sched.c	2003-11-23 18:37:44.555365678 +1100
@@ -61,14 +61,6 @@
 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
-#define AVG_TIMESLICE	(MIN_TIMESLICE + ((MAX_TIMESLICE - MIN_TIMESLICE) *\
-			(MAX_PRIO-1-NICE_TO_PRIO(0))/(MAX_USER_PRIO - 1)))
-
-/*
- * Some helpers for converting nanosecond timing to jiffy resolution
- */
-#define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
-#define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
 
 /*
  * These are the 'tuning knobs' of the scheduler:
@@ -79,79 +71,7 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
-#define ON_RUNQUEUE_WEIGHT	30
-#define CHILD_PENALTY		95
-#define PARENT_PENALTY		100
-#define EXIT_WEIGHT		3
-#define PRIO_BONUS_RATIO	25
-#define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
-#define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(AVG_TIMESLICE * MAX_BONUS)
-#define STARVATION_LIMIT	(MAX_SLEEP_AVG)
-#define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
 #define NODE_THRESHOLD		125
-#define CREDIT_LIMIT		100
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
-
-#define CURRENT_BONUS(p) \
-	(NS_TO_JIFFIES((p)->sleep_avg) * MAX_BONUS / \
-		MAX_SLEEP_AVG)
-
-#ifdef CONFIG_SMP
-#define TIMESLICE_GRANULARITY(p)	(MIN_TIMESLICE * \
-		(1 << (((MAX_BONUS - CURRENT_BONUS(p)) ? : 1) - 1)) * \
-			num_online_cpus())
-#else
-#define TIMESLICE_GRANULARITY(p)	(MIN_TIMESLICE * \
-		(1 << (((MAX_BONUS - CURRENT_BONUS(p)) ? : 1) - 1)))
-#endif
-
-#define SCALE(v1,v1_max,v2_max) \
-	(v1) * (v2_max) / (v1_max)
-
-#define DELTA(p) \
-	(SCALE(TASK_NICE(p), 40, MAX_USER_PRIO*PRIO_BONUS_RATIO/100) + \
-		INTERACTIVE_DELTA)
-
-#define TASK_INTERACTIVE(p) \
-	((p)->prio <= (p)->static_prio - DELTA(p))
-
-#define JUST_INTERACTIVE_SLEEP(p) \
-	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
-		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
-
-#define HIGH_CREDIT(p) \
-	((p)->interactive_credit > CREDIT_LIMIT)
-
-#define LOW_CREDIT(p) \
-	((p)->interactive_credit < -CREDIT_LIMIT)
 
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
@@ -198,12 +118,14 @@ struct prio_array {
  */
 struct runqueue {
 	spinlock_t lock;
-	unsigned long nr_running, nr_switches, expired_timestamp,
-			nr_uninterruptible;
+	unsigned long nr_running, nr_switches, nr_uninterruptible;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_cpu_load[NR_CPUS];
+#ifdef CONFIG_SMP
+	unsigned int cache_decay;
+#endif
 #ifdef CONFIG_NUMA
 	atomic_t *node_nr_running;
 	int prev_node_load[MAX_NUMNODES];
@@ -338,158 +260,20 @@ static inline void enqueue_task(struct t
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
 static int effective_prio(task_t *p)
 {
-	int bonus, prio;
-
 	if (rt_task(p))
 		return p->prio;
-
-	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
-
-	prio = p->static_prio - bonus;
-	if (prio < MAX_RT_PRIO)
-		prio = MAX_RT_PRIO;
-	if (prio > MAX_PRIO-1)
-		prio = MAX_PRIO-1;
-	return prio;
-}
-
-/*
- * __activate_task - move a task to the runqueue.
- */
-static inline void __activate_task(task_t *p, runqueue_t *rq)
-{
-	enqueue_task(p, rq->active);
-	nr_running_inc(rq);
-}
-
-static void recalc_task_prio(task_t *p, unsigned long long now)
-{
-	unsigned long long __sleep_time = now - p->timestamp;
-	unsigned long sleep_time;
-
-	if (__sleep_time > NS_MAX_SLEEP_AVG)
-		sleep_time = NS_MAX_SLEEP_AVG;
-	else
-		sleep_time = (unsigned long)__sleep_time;
-
-	if (likely(sleep_time > 0)) {
-		/*
-		 * User tasks that sleep a long time are categorised as
-		 * idle and will get just interactive status to stay active &
-		 * prevent them suddenly becoming cpu hogs and starving
-		 * other processes.
-		 */
-		if (p->mm && p->activated != -1 &&
-			sleep_time > JUST_INTERACTIVE_SLEEP(p)){
-				p->sleep_avg = JIFFIES_TO_NS(MAX_SLEEP_AVG -
-						AVG_TIMESLICE);
-				if (!HIGH_CREDIT(p))
-					p->interactive_credit++;
-		} else {
-			/*
-			 * The lower the sleep avg a task has the more
-			 * rapidly it will rise with sleep time.
-			 */
-			sleep_time *= (MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
-
-			/*
-			 * Tasks with low interactive_credit are limited to
-			 * one timeslice worth of sleep avg bonus.
-			 */
-			if (LOW_CREDIT(p) &&
-				sleep_time > JIFFIES_TO_NS(task_timeslice(p)))
-					sleep_time =
-						JIFFIES_TO_NS(task_timeslice(p));
-
-			/*
-			 * Non high_credit tasks waking from uninterruptible
-			 * sleep are limited in their sleep_avg rise as they
-			 * are likely to be cpu hogs waiting on I/O
-			 */
-			if (p->activated == -1 && !HIGH_CREDIT(p) && p->mm){
-				if (p->sleep_avg >= JUST_INTERACTIVE_SLEEP(p))
-					sleep_time = 0;
-				else if (p->sleep_avg + sleep_time >=
-					JUST_INTERACTIVE_SLEEP(p)){
-						p->sleep_avg =
-							JUST_INTERACTIVE_SLEEP(p);
-						sleep_time = 0;
-					}
-			}
-
-			/*
-			 * This code gives a bonus to interactive tasks.
-			 *
-			 * The boost works by updating the 'average sleep time'
-			 * value here, based on ->timestamp. The more time a task
-			 * spends sleeping, the higher the average gets - and the
-			 * higher the priority boost gets as well.
-			 */
-			p->sleep_avg += sleep_time;
-
-			if (p->sleep_avg > NS_MAX_SLEEP_AVG){
-				p->sleep_avg = NS_MAX_SLEEP_AVG;
-				if (!HIGH_CREDIT(p))
-					p->interactive_credit++;
-			}
-		}
-	}
-
-	p->prio = effective_prio(p);
+	return p->static_prio;
 }
 
 /*
  * activate_task - move a task to the runqueue and do priority recalculation
- *
- * Update all the scheduling statistics stuff. (sleep average
- * calculation, priority modifiers, etc.)
  */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	unsigned long long now = sched_clock();
-
-	recalc_task_prio(p, now);
-
-	/*
-	 * This checks to make sure it's not an uninterruptible task
-	 * that is now waking up.
-	 */
-	if (!p->activated){
-		/*
-		 * Tasks which were woken up by interrupts (ie. hw events)
-		 * are most likely of interactive nature. So we give them
-		 * the credit of extending their sleep time to the period
-		 * of time they spend on the runqueue, waiting for execution
-		 * on a CPU, first time around:
-		 */
-		if (in_interrupt())
-			p->activated = 2;
-		else
-		/*
-		 * Normal first-time wakeups get a credit too for on-runqueue
-		 * time, but it will be weighted down:
-		 */
-			p->activated = 1;
-		}
-	p->timestamp = now;
-
-	__activate_task(p, rq);
+	enqueue_task(p, rq->active);
+	nr_running_inc(rq);
 }
 
 /*
@@ -609,21 +393,11 @@ repeat_lock_task:
 				task_rq_unlock(rq, &flags);
 				goto repeat_lock_task;
 			}
-			if (old_state == TASK_UNINTERRUPTIBLE){
+			if (old_state == TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible--;
-				/*
-				 * Tasks on involuntary sleep don't earn
-				 * sleep_avg beyond just interactive state.
-				 */
-				p->activated = -1;
-			}
-			if (sync)
-				__activate_task(p, rq);
-			else {
-				activate_task(p, rq);
-				if (TASK_PREEMPTS_CURR(p, rq))
-					resched_task(rq->curr);
-			}
+			activate_task(p, rq);
+			if (!sync && TASK_PREEMPTS_CURR(p, rq))
+				resched_task(rq->curr);
 			success = 1;
 		}
 #ifdef CONFIG_SMP
@@ -667,24 +441,12 @@ void wake_up_forked_process(task_t * p)
 	runqueue_t *rq = task_rq_lock(current, &flags);
 
 	p->state = TASK_RUNNING;
-	/*
-	 * We decrease the sleep average of forking parents
-	 * and children as well, to keep max-interactive tasks
-	 * from forking tasks that are max-interactive.
-	 */
-	current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
-		PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
-
-	p->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
-		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
-
-	p->interactive_credit = 0;
 
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
 
 	if (unlikely(!current->array))
-		__activate_task(p, rq);
+		activate_task(p, rq);
 	else {
 		p->prio = current->prio;
 		list_add_tail(&p->run_list, &current->run_list);
@@ -715,14 +477,6 @@ void sched_exit(task_t * p)
 			p->parent->time_slice = MAX_TIMESLICE;
 	}
 	local_irq_restore(flags);
-	/*
-	 * If the child was a (relative-) CPU hog then decrease
-	 * the sleep_avg of the parent as well.
-	 */
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = p->parent->sleep_avg /
-		(EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg /
-		(EXIT_WEIGHT + 1);
 }
 
 /**
@@ -1128,21 +882,10 @@ static inline void pull_task(runqueue_t 
 		set_need_resched();
 }
 
-/*
- * Previously:
- *
- * #define CAN_MIGRATE_TASK(p,rq,this_cpu)	\
- *	((!idle || (NS_TO_JIFFIES(now - (p)->timestamp) > \
- *		cache_decay_ticks)) && !task_running(rq, p) && \
- *			cpu_isset(this_cpu, (p)->cpus_allowed))
- */
-
 static inline int
 can_migrate_task(task_t *tsk, runqueue_t *rq, int this_cpu, int idle)
 {
-	unsigned long delta = sched_clock() - tsk->timestamp;
-
-	if (!idle && (delta <= JIFFIES_TO_NS(cache_decay_ticks)))
+	if ((rq)->cache_decay)
 		return 0;
 	if (task_running(rq, tsk))
 		return 0;
@@ -1346,6 +1089,11 @@ void scheduler_tick(int user_ticks, int 
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 
+#ifdef CONFIG_SMP
+	if (rq->cache_decay)
+		rq->cache_decay--;
+#endif
+
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
 
@@ -1404,43 +1152,10 @@ void scheduler_tick(int user_ticks, int 
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
-		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 
-		if (!rq->expired_timestamp)
-			rq->expired_timestamp = jiffies;
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			enqueue_task(p, rq->expired);
-		} else
-			enqueue_task(p, rq->active);
-	} else {
-		/*
-		 * Prevent a too long timeslice allowing a task to monopolize
-		 * the CPU. We do this by splitting up the timeslice into
-		 * smaller pieces.
-		 *
-		 * Note: this does not mean the task's timeslices expire or
-		 * get lost in any way, they just might be preempted by
-		 * another task of equal priority. (one with higher
-		 * priority would have preempted this task already.) We
-		 * requeue this task to the end of the list on this priority
-		 * level, which is in essence a round-robin of tasks with
-		 * equal priority.
-		 *
-		 * This only applies to tasks in the interactive
-		 * delta range with at least TIMESLICE_GRANULARITY to requeue.
-		 */
-		if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
-			p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
-			(p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
-			(p->array == rq->active)) {
-
-			dequeue_task(p, rq->active);
-			set_tsk_need_resched(p);
-			p->prio = effective_prio(p);
-			enqueue_task(p, rq->active);
-		}
+		enqueue_task(p, rq->expired);
 	}
 out_unlock:
 	spin_unlock(&rq->lock);
@@ -1459,8 +1174,6 @@ asmlinkage void schedule(void)
 	runqueue_t *rq;
 	prio_array_t *array;
 	struct list_head *queue;
-	unsigned long long now;
-	unsigned long run_time;
 	int idx;
 
 	/*
@@ -1481,19 +1194,6 @@ need_resched:
 	rq = this_rq();
 
 	release_kernel_lock(prev);
-	now = sched_clock();
-	if (likely(now - prev->timestamp < NS_MAX_SLEEP_AVG))
-		run_time = now - prev->timestamp;
-	else
-		run_time = NS_MAX_SLEEP_AVG;
-
-	/*
-	 * Tasks with interactive credits get charged less run_time
-	 * at high sleep_avg to delay them losing their interactive
-	 * status
-	 */
-	if (HIGH_CREDIT(prev))
-		run_time /= (CURRENT_BONUS(prev) ? : 1);
 
 	spin_lock_irq(&rq->lock);
 
@@ -1525,7 +1225,6 @@ pick_next_task:
 			goto pick_next_task;
 #endif
 		next = rq->idle;
-		rq->expired_timestamp = 0;
 		goto switch_tasks;
 	}
 
@@ -1537,43 +1236,26 @@ pick_next_task:
 		rq->active = rq->expired;
 		rq->expired = array;
 		array = rq->active;
-		rq->expired_timestamp = 0;
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
-	if (next->activated > 0) {
-		unsigned long long delta = now - next->timestamp;
-
-		if (next->activated == 1)
-			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
-
-		array = next->array;
-		dequeue_task(next, array);
-		recalc_task_prio(next, next->timestamp + delta);
-		enqueue_task(next, array);
-	}
-	next->activated = 0;
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
 	RCU_qsctr(task_cpu(prev))++;
 
-	prev->sleep_avg -= run_time;
-	if ((long)prev->sleep_avg <= 0){
-		prev->sleep_avg = 0;
-		if (!(HIGH_CREDIT(prev) || LOW_CREDIT(prev)))
-			prev->interactive_credit--;
-	}
-	prev->timestamp = now;
 
 	if (likely(prev != next)) {
-		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
 
+#ifdef CONFIG_SMP
+		if (next != rq->idle)
+			rq->cache_decay = cache_decay_ticks;
+#endif
 		prepare_arch_switch(rq, next);
 		prev = context_switch(rq, prev, next);
 		barrier();
@@ -2053,7 +1735,7 @@ static int setscheduler(pid_t pid, int p
 	else
 		p->prio = p->static_prio;
 	if (array) {
-		__activate_task(p, task_rq(p));
+		activate_task(p, task_rq(p));
 		/*
 		 * Reschedule if we are currently running on this runqueue and
 		 * our priority decreased, or if we are not currently running on

--Boundary-00=_4+Tw/AzDosIoym1--

