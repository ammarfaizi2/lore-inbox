Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275294AbTHSBxl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275301AbTHSBxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:53:41 -0400
Received: from dyn-ctb-203-221-74-179.webone.com.au ([203.221.74.179]:10756
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S275294AbTHSBxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:53:07 -0400
Message-ID: <3F4182FD.3040900@cyberone.com.au>
Date: Tue, 19 Aug 2003 11:53:01 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [CFT][PATCH] new scheduler policy
Content-Type: multipart/mixed;
 boundary="------------020302050203070401040508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020302050203070401040508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone,

As per the latest trend these days, I've done some tinkering with
the cpu scheduler. I have gone in the opposite direction of most
of the recent stuff and come out with something that can be nearly
as good interactivity wise (for me).

I haven't run many tests on it - my mind blanked when I tried to
remember the scores of scheduler "exploits" thrown around. So if
anyone would like to suggest some, or better still, run some,
please do so. And be nice, this isn't my type of scheduler :P

It still does have a few things that need fixing but I thought
I'd get my first hack a bit of exercise.

Its against 2.6.0-test3-mm1

Best regards,
Nick


--------------020302050203070401040508
Content-Type: text/plain;
 name="sched-policy"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-policy"

diff -Nrup -X dontdiff archs/linux-2.6/fs/proc/array.c linux-2.6/fs/proc/array.c
--- archs/linux-2.6/fs/proc/array.c	2003-08-19 01:45:49.000000000 +1000
+++ linux-2.6/fs/proc/array.c	2003-08-18 16:55:23.000000000 +1000
@@ -162,7 +162,7 @@ static inline char * task_state(struct t
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
-		(p->sleep_avg/1024)*100/(1000000000/1024),
+		p->sleep_avg,
 	       	p->tgid,
 		p->pid, p->pid ? p->real_parent->pid : 0,
 		p->pid && p->ptrace ? p->parent->pid : 0,
diff -Nrup -X dontdiff archs/linux-2.6/include/linux/sched.h linux-2.6/include/linux/sched.h
--- archs/linux-2.6/include/linux/sched.h	2003-08-19 01:45:50.000000000 +1000
+++ linux-2.6/include/linux/sched.h	2003-08-18 22:03:49.000000000 +1000
@@ -342,14 +342,17 @@ struct task_struct {
 	struct list_head run_list;
 	prio_array_t *array;
 
+	unsigned long array_sequence;
+	unsigned long timestamp;
+
+	unsigned long sleep_time;
+	unsigned long total_time;
 	unsigned long sleep_avg;
-	long interactive_credit;
-	unsigned long long timestamp;
-	int activated;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
+	unsigned int used_slice;
 
 	struct list_head tasks;
 	struct list_head ptrace_children;
diff -Nrup -X dontdiff archs/linux-2.6/kernel/sched.c linux-2.6/kernel/sched.c
--- archs/linux-2.6/kernel/sched.c	2003-08-19 01:45:50.000000000 +1000
+++ linux-2.6/kernel/sched.c	2003-08-19 11:20:19.000000000 +1000
@@ -58,8 +58,6 @@
 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
-#define AVG_TIMESLICE	(MIN_TIMESLICE + ((MAX_TIMESLICE - MIN_TIMESLICE) *\
-			(MAX_PRIO-1-NICE_TO_PRIO(0))/(MAX_USER_PRIO - 1)))
 
 /*
  * Some helpers for converting nanosecond timing to jiffy resolution
@@ -67,6 +65,12 @@
 #define NS_TO_JIFFIES(TIME)	(TIME / (1000000000 / HZ))
 #define JIFFIES_TO_NS(TIME)	(TIME * (1000000000 / HZ))
 
+#define US_TO_JIFFIES(TIME)	(TIME / (1000000 / HZ))
+#define JIFFIES_TO_US(TIME)	(TIME * (1000000 / HZ))
+
+#define NS_TO_US(TIME)		(TIME / 1000)
+#define US_TO_NS(TIME)		(TIME * 1000)
+
 /*
  * These are the 'tuning knobs' of the scheduler:
  *
@@ -74,93 +78,32 @@
  * maximum timeslice is 200 msecs. Timeslices get refilled after
  * they expire.
  */
-#define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(200 * HZ / 1000)
-#define TIMESLICE_GRANULARITY	(HZ/40 ?: 1)
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
-	(MAX_SLEEP_AVG - (DELTA(p) * AVG_TIMESLICE))
+#define MIN_TIMESLICE		(10 * HZ / 1000)
+#define MAX_TIMESLICE		(100 * HZ / 1000)
 
-#define HIGH_CREDIT(p) \
-	((p)->interactive_credit > MAX_SLEEP_AVG)
-
-#define LOW_CREDIT(p) \
-	((p)->interactive_credit < -MAX_SLEEP_AVG)
-
-#define VARYING_CREDIT(p) \
-	(!(HIGH_CREDIT(p) || LOW_CREDIT(p)))
+#define NODE_THRESHOLD		125
 
 #define TASK_PREEMPTS_CURR(p, rq) \
-	((p)->prio < (rq)->curr->prio || \
-		((p)->prio == (rq)->curr->prio && \
-			(p)->time_slice > (rq)->curr->time_slice * 2))
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
@@ -186,7 +129,8 @@ struct prio_array {
  */
 struct runqueue {
 	spinlock_t lock;
-	unsigned long nr_running, nr_switches, expired_timestamp,
+	unsigned long array_sequence;
+	unsigned long nr_running, nr_switches,
 			nr_uninterruptible;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
@@ -326,39 +270,50 @@ static inline void enqueue_task(struct t
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
 
-	bonus = MAX_USER_PRIO * PRIO_BONUS_RATIO *
-		NS_TO_JIFFIES(p->sleep_avg) / MAX_SLEEP_AVG / 100;
-	bonus -= MAX_USER_PRIO * PRIO_BONUS_RATIO / 100 / 2;
+	bonus = (MAX_USER_PRIO * p->sleep_avg) / 100 / 2;
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
 
+static void add_task_time(task_t *p, unsigned long time,
+					int sleep)
+{
+	const unsigned long tmax = HZ;
+	
+	if (time == 0)
+		return;
+	
+	if (time > tmax) {
+		time = tmax;
+		p->total_time = 0;
+		p->sleep_time = 0;
+	} else {
+		p->total_time = ((tmax - time) * p->total_time) / tmax;
+		p->sleep_time = ((tmax - time) * p->sleep_time) / tmax;
+	}
+
+	p->total_time += time;
+	if (sleep)
+		p->sleep_time += time;
+
+	if (p->total_time != 0)
+		p->sleep_avg = (100 * p->sleep_time) / p->total_time;
+}
+
 /*
  * __activate_task - move a task to the runqueue.
  */
@@ -368,90 +323,6 @@ static inline void __activate_task(task_
 	nr_running_inc(rq);
 }
 
-static void recalc_task_prio(task_t *p, unsigned long long now)
-{
-	unsigned long long __sleep_time = now - p->timestamp;
-	unsigned long sleep_time;
-
-	if (!p->sleep_avg && VARYING_CREDIT(p))
-		p->interactive_credit--;
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
-		if (p->mm && sleep_time >
-			JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p)))
-				p->sleep_avg =
-					JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p));
-		else {
-			/*
-			 * The lower the sleep avg a task has the more
-			 * rapidly it will rise with sleep time.
-			 */
-			sleep_time *= (MAX_BONUS + 1 -
-					(NS_TO_JIFFIES(p->sleep_avg) *
-					MAX_BONUS / MAX_SLEEP_AVG));
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
-			 * sleep are limited in their sleep_avg rise
-			 */
-			if (!HIGH_CREDIT(p) && p->activated == -1){
-				if (p->sleep_avg >=
-					JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p)))
-						sleep_time = 0;
-				else if (p->sleep_avg + sleep_time >=
-					JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p))){
-						p->sleep_avg =
-							JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p));
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
-			/*
-			 * 'Overflow' bonus ticks go to the waker as well, so the
-			 * ticks are not lost. This has the effect of further
-			 * boosting tasks that are related to maximum-interactive
-			 * tasks.
-			 */
-			if (p->sleep_avg > NS_MAX_SLEEP_AVG){
-				p->sleep_avg = NS_MAX_SLEEP_AVG;
-				p->interactive_credit += VARYING_CREDIT(p);
-			}
-		}
-	}
-
-	p->prio = effective_prio(p);
-}
-
 /*
  * activate_task - move a task to the runqueue and do priority recalculation
  *
@@ -460,33 +331,33 @@ static void recalc_task_prio(task_t *p, 
  */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	unsigned long long now = sched_clock();
+	unsigned long now = jiffies;
+	unsigned long s = now - p->timestamp;
+	unsigned long tmax = HZ;
+
+	if (s > tmax)
+		s = tmax;
+
+	if (!in_interrupt() && current->mm) {
+		add_task_time(p, s / 2, 1);
+		add_task_time(current, s / 2, 1);
+	} else
+		add_task_time(p, s, 1);
 
-	recalc_task_prio(p, now);
+	p->prio = task_priority(p);
 
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
+	if (rq->array_sequence != p->array_sequence) {
+		p->used_slice = 0;
+		p->time_slice = task_timeslice(p);
 	}
 
-	p->timestamp = now;
+	if (!in_interrupt() && current->mm) {
+		unsigned long steal = s / 2;
+		steal = min((unsigned int)s,
+				(p->time_slice - p->used_slice) / 2);
+		p->time_slice -= steal;
+		current->time_slice += steal;
+	}
 
 	__activate_task(p, rq);
 }
@@ -496,6 +367,7 @@ static inline void activate_task(task_t 
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
+	p->array_sequence = rq->array_sequence;
 	nr_running_dec(rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
@@ -539,7 +411,7 @@ static inline void resched_task(task_t *
  * be called with interrupts off, or it may introduce deadlock with
  * smp_call_function() if an IPI is sent by the same process we are
  * waiting to become inactive.
- */
+ n*/
 void wait_task_inactive(task_t * p)
 {
 	unsigned long flags;
@@ -608,18 +480,10 @@ repeat_lock_task:
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
+			activate_task(p, rq);
+			if (!sync) {
 				if (TASK_PREEMPTS_CURR(p, rq))
 					resched_task(rq->curr);
 			}
@@ -658,40 +522,26 @@ int wake_up_state(task_t *p, unsigned in
  * This function will do some initial scheduler statistics housekeeping
  * that must be done for every newly created process.
  */
-void wake_up_forked_process(task_t * p)
+void wake_up_forked_process(task_t *p)
 {
-	unsigned long flags, sleep_avg;
+	unsigned long flags;
 	runqueue_t *rq = task_rq_lock(current, &flags);
 
 	p->state = TASK_RUNNING;
-	/*
-	 * We decrease the sleep average of forking parents
-	 * and children as well, to keep max-interactive tasks
-	 * from forking tasks that are max-interactive.
-	 */
-	sleep_avg = NS_TO_JIFFIES(current->sleep_avg) * MAX_BONUS /
-			MAX_SLEEP_AVG * PARENT_PENALTY / 100 *
-			MAX_SLEEP_AVG / MAX_BONUS;
-	current->sleep_avg = JIFFIES_TO_NS(sleep_avg);
-
-	sleep_avg = NS_TO_JIFFIES(p->sleep_avg) * MAX_BONUS / MAX_SLEEP_AVG *
-			CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS;
-	p->sleep_avg = JIFFIES_TO_NS(sleep_avg);
 
-	p->interactive_credit = 0;
-
-	p->prio = effective_prio(p);
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
+	p->sleep_time = current->sleep_time / 3;
+	p->total_time = current->total_time / 3;
+	p->sleep_avg = current->sleep_avg;
+
+	current->sleep_time = (current->sleep_time*2) / 3;
+	if (current->total_time != 0)
+		current->sleep_avg = (100 * current->sleep_time) / current->total_time;
+
+	p->prio = task_priority(p);
+	__activate_task(p, rq);
+
 	task_rq_unlock(rq, &flags);
 }
 
@@ -710,19 +560,11 @@ void sched_exit(task_t * p)
 
 	local_irq_save(flags);
 	if (p->first_time_slice) {
-		p->parent->time_slice += p->time_slice;
+		p->parent->time_slice += p->time_slice - p->used_slice;
 		if (unlikely(p->parent->time_slice > MAX_TIMESLICE))
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
@@ -1129,25 +971,23 @@ static inline void pull_task(runqueue_t 
 }
 
 /*
- * Previously:
- *
- * #define CAN_MIGRATE_TASK(p,rq,this_cpu)	\
- *	((!idle || (NS_TO_JIFFIES(now - (p)->timestamp) > \
- *		cache_decay_ticks)) && !task_running(rq, p) && \
- *			cpu_isset(this_cpu, (p)->cpus_allowed))
+ * comment me
  */
 
 static inline int
 can_migrate_task(task_t *tsk, runqueue_t *rq, int this_cpu, int idle)
 {
-	unsigned long delta = sched_clock() - tsk->timestamp;
+	unsigned long delta;
 
-	if (idle && (delta <= JIFFIES_TO_NS(cache_decay_ticks)))
-		return 0;
 	if (task_running(rq, tsk))
 		return 0;
 	if (!cpu_isset(this_cpu, tsk->cpus_allowed))
 		return 0;
+
+	delta = jiffies - tsk->timestamp;
+	if (idle && (delta <= cache_decay_ticks))
+		return 0;
+
 	return 1;
 }
 
@@ -1319,20 +1159,6 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
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
@@ -1376,71 +1202,39 @@ void scheduler_tick(int user_ticks, int 
 	 * The task was running during this tick - update the
 	 * time slice counter. Note: we do not update a thread's
 	 * priority until it either goes to sleep or uses up its
-	 * timeslice. This makes it possible for interactive tasks
-	 * to use up their timeslices at their highest priority levels.
+	 * timeslice.
 	 */
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
-		 * This only applies to user tasks in the interactive
-		 * delta range with at least MIN_TIMESLICE left.
-		 */
-		if (p->mm && TASK_INTERACTIVE(p) && !((task_timeslice(p) -
-			p->time_slice) % TIMESLICE_GRANULARITY) &&
-			(p->time_slice > MIN_TIMESLICE) &&
-			(p->array == rq->active)) {
-
-			dequeue_task(p, rq->active);
-			set_tsk_need_resched(p);
-			/*
-			 * Tasks with interactive credit get all their
-			 * time waiting on the run queue credited as sleep
-			 */
-			if (HIGH_CREDIT(p))
-				p->activated = 2;
-			p->prio = effective_prio(p);
-			enqueue_task(p, rq->active);
-		}
+		enqueue_task(p, rq->expired);
 	}
 out_unlock:
 	spin_unlock(&rq->lock);
@@ -1459,7 +1253,7 @@ asmlinkage void schedule(void)
 	runqueue_t *rq;
 	prio_array_t *array;
 	struct list_head *queue;
-	unsigned long long now;
+	unsigned long now;
 	unsigned long run_time;
 	int idx;
 
@@ -1481,21 +1275,9 @@ need_resched:
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
-	 * as their sleep_avg decreases to slow them losing their
-	 * priority bonus
-	 */
-	if (HIGH_CREDIT(prev))
-		run_time /= (MAX_BONUS + 1 -
-			(NS_TO_JIFFIES(prev->sleep_avg) * MAX_BONUS /
-			MAX_SLEEP_AVG));
+	now = jiffies;
+	run_time = now - prev->timestamp;
+	add_task_time(prev, run_time, 0);
 
 	spin_lock_irq(&rq->lock);
 
@@ -1525,7 +1307,6 @@ pick_next_task:
 			goto pick_next_task;
 #endif
 		next = rq->idle;
-		rq->expired_timestamp = 0;
 		goto switch_tasks;
 	}
 
@@ -1534,36 +1315,21 @@ pick_next_task:
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
-	if ((long)prev->sleep_avg < 0)
-		prev->sleep_avg = 0;
 	prev->timestamp = now;
 
 	if (likely(prev != next)) {
@@ -2762,6 +2528,7 @@ void __init sched_init(void)
 		prio_array_t *array;
 
 		rq = cpu_rq(i);
+		rq->array_sequence = 0;
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);

--------------020302050203070401040508--

