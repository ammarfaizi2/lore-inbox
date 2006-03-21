Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWCUXyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWCUXyX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWCUXyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:54:22 -0500
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:62926 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751218AbWCUXyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:54:21 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Staircase cpu scheduler v14.2
Date: Wed, 22 Mar 2006 10:54:55 +1100
User-Agent: KMail/1.8.3
Cc: ck@vds.kolivas.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221054.55686.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just as a reminder, the staircase cpu scheduler is still in active 
development. While included in the -ck patchset, the standalone patch
can be downloaded here:
http://ck.kolivas.org/patches/staircase/

Here is the current base staircase patch for 2.6.16

Cheers,
Con
---
 fs/proc/array.c       |    4 
 include/linux/sched.h |   12 
 kernel/exit.c         |    1 
 kernel/sched.c        |  966 +++++++++++++++++---------------------------------
 4 files changed, 349 insertions(+), 634 deletions(-)

Index: linux-2.6.16-staircase/fs/proc/array.c
===================================================================
--- linux-2.6.16-staircase.orig/fs/proc/array.c	2006-03-21 15:09:37.000000000 +1100
+++ linux-2.6.16-staircase/fs/proc/array.c	2006-03-22 08:52:26.000000000 +1100
@@ -165,7 +165,7 @@ static inline char * task_state(struct t
 	read_lock(&tasklist_lock);
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
-		"SleepAVG:\t%lu%%\n"
+		"Bonus:\t%d\n"
 		"Tgid:\t%d\n"
 		"Pid:\t%d\n"
 		"PPid:\t%d\n"
@@ -173,7 +173,7 @@ static inline char * task_state(struct t
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
-		(p->sleep_avg/1024)*100/(1020000000/1024),
+		p->bonus,
 	       	p->tgid,
 		p->pid, pid_alive(p) ? p->group_leader->real_parent->tgid : 0,
 		pid_alive(p) && p->ptrace ? p->parent->pid : 0,
Index: linux-2.6.16-staircase/include/linux/sched.h
===================================================================
--- linux-2.6.16-staircase.orig/include/linux/sched.h	2006-03-21 15:09:38.000000000 +1100
+++ linux-2.6.16-staircase/include/linux/sched.h	2006-03-22 09:14:18.000000000 +1100
@@ -521,7 +521,6 @@ extern struct user_struct *find_user(uid
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
 
-typedef struct prio_array prio_array_t;
 struct backing_dev_info;
 struct reclaim_state;
 
@@ -703,18 +702,17 @@ struct task_struct {
 #endif
 	int prio, static_prio;
 	struct list_head run_list;
-	prio_array_t *array;
 
 	unsigned short ioprio;
 
-	unsigned long sleep_avg;
-	unsigned long long timestamp, last_ran;
+	unsigned long long timestamp;
+	unsigned long runtime, totalrun, ns_debit;
+	unsigned int bonus;
+	unsigned int slice, time_slice;
 	unsigned long long sched_time; /* sched_clock time spent running */
-	int activated;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
-	unsigned int time_slice, first_time_slice;
 
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
@@ -928,6 +926,7 @@ static inline void put_task_struct(struc
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
 #define PF_SWAPWRITE	0x01000000	/* Allowed to write to swap */
+#define PF_NONSLEEP	0x02000000	/* Waiting on in kernel activity */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
@@ -1049,7 +1048,6 @@ extern void FASTCALL(wake_up_new_task(st
  static inline void kick_process(struct task_struct *tsk) { }
 #endif
 extern void FASTCALL(sched_fork(task_t * p, int clone_flags));
-extern void FASTCALL(sched_exit(task_t * p));
 
 extern int in_group_p(gid_t);
 extern int in_egroup_p(gid_t);
Index: linux-2.6.16-staircase/kernel/exit.c
===================================================================
--- linux-2.6.16-staircase.orig/kernel/exit.c	2006-03-21 15:09:38.000000000 +1100
+++ linux-2.6.16-staircase/kernel/exit.c	2006-03-22 08:52:26.000000000 +1100
@@ -102,7 +102,6 @@ repeat: 
 		zap_leader = (leader->exit_signal == -1);
 	}
 
-	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
 	proc_pid_flush(proc_dentry);
Index: linux-2.6.16-staircase/kernel/sched.c
===================================================================
--- linux-2.6.16-staircase.orig/kernel/sched.c	2006-03-21 15:09:38.000000000 +1100
+++ linux-2.6.16-staircase/kernel/sched.c	2006-03-22 10:41:38.000000000 +1100
@@ -16,6 +16,9 @@
  *		by Davide Libenzi, preemptible kernel bits by Robert Love.
  *  2003-09-03	Interactivity tuning by Con Kolivas.
  *  2004-04-02	Scheduler domains code by Nick Piggin
+ *  2006-03-16	New staircase scheduling policy by Con Kolivas with help
+ *		from William Lee Irwin III, Zwane Mwaikambo & Peter Williams.
+ *		Staircase v14.2
  */
 
 #include <linux/mm.h>
@@ -76,122 +79,26 @@
  */
 #define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
 #define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
-
-/*
- * These are the 'tuning knobs' of the scheduler:
- *
- * Minimum timeslice is 5 msecs (or 1 jiffy, whichever is larger),
- * default timeslice is 100 msecs, maximum timeslice is 800 msecs.
- * Timeslices get refilled after they expire.
- */
-#define MIN_TIMESLICE		max(5 * HZ / 1000, 1)
-#define DEF_TIMESLICE		(100 * HZ / 1000)
-#define ON_RUNQUEUE_WEIGHT	 30
-#define CHILD_PENALTY		 95
-#define PARENT_PENALTY		100
-#define EXIT_WEIGHT		  3
-#define PRIO_BONUS_RATIO	 25
-#define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
-#define INTERACTIVE_DELTA	  2
-#define MAX_SLEEP_AVG		(DEF_TIMESLICE * MAX_BONUS)
-#define STARVATION_LIMIT	(MAX_SLEEP_AVG)
-#define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
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
-#define GRANULARITY	(10 * HZ / 1000 ? : 1)
-
-#ifdef CONFIG_SMP
-#define TIMESLICE_GRANULARITY(p)	(GRANULARITY * \
-		(1 << (((MAX_BONUS - CURRENT_BONUS(p)) ? : 1) - 1)) * \
-			num_online_cpus())
-#else
-#define TIMESLICE_GRANULARITY(p)	(GRANULARITY * \
-		(1 << (((MAX_BONUS - CURRENT_BONUS(p)) ? : 1) - 1)))
-#endif
-
-#define SCALE(v1,v1_max,v2_max) \
-	(v1) * (v2_max) / (v1_max)
-
-#define DELTA(p) \
-	(SCALE(TASK_NICE(p), 40, MAX_BONUS) + INTERACTIVE_DELTA)
-
-#define TASK_INTERACTIVE(p) \
-	((p)->prio <= (p)->static_prio - DELTA(p))
-
-#define INTERACTIVE_SLEEP(p) \
-	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
-		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
+#define NSJIFFY			(1000000000 / HZ)	/* One jiffy in ns */
 
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
 
 /*
- * task_timeslice() scales user-nice values [ -20 ... 0 ... 19 ]
- * to time slice values: [800ms ... 100ms ... 5ms]
- *
- * The higher a thread's priority, the bigger timeslices
- * it gets during one round of execution. But even the lowest
- * priority thread gets MIN_TIMESLICE worth of execution time.
+ * This is the time all tasks within the same priority round robin.
+ * Set to a minimum of 6ms.
  */
+#define RR_INTERVAL		((6 * HZ / 1001) + 1)
+#define DEF_TIMESLICE		(RR_INTERVAL * 19)
 
-#define SCALE_PRIO(x, prio) \
-	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO/2), MIN_TIMESLICE)
-
-static unsigned int task_timeslice(task_t *p)
-{
-	if (p->static_prio < NICE_TO_PRIO(0))
-		return SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
-	else
-		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
-}
-#define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
+#define task_hot(p, now, sd) ((long long) ((now) - (p)->timestamp)	\
 				< (long long) (sd)->cache_hot_time)
 
 /*
  * These are the runqueue data structures:
  */
-
-#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
-
 typedef struct runqueue runqueue_t;
 
-struct prio_array {
-	unsigned int nr_active;
-	unsigned long bitmap[BITMAP_SIZE];
-	struct list_head queue[MAX_PRIO];
-};
-
 /*
  * This is the main, per-CPU runqueue data structure.
  *
@@ -220,12 +127,11 @@ struct runqueue {
 	 */
 	unsigned long nr_uninterruptible;
 
-	unsigned long expired_timestamp;
 	unsigned long long timestamp_last_tick;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
-	prio_array_t *active, *expired, arrays[2];
-	int best_expired_prio;
+	unsigned long bitmap[BITS_TO_LONGS(MAX_PRIO + 1)];
+	struct list_head queue[MAX_PRIO];
 	atomic_t nr_iowait;
 
 #ifdef CONFIG_SMP
@@ -489,13 +395,7 @@ static inline runqueue_t *this_rq_lock(v
 
 #ifdef CONFIG_SCHEDSTATS
 /*
- * Called when a process is dequeued from the active array and given
- * the cpu.  We should note that with the exception of interactive
- * tasks, the expired queue will become the active queue after the active
- * queue is empty, without explicitly dequeuing and requeuing tasks in the
- * expired queue.  (Interactive tasks may be requeued directly to the
- * active queue, thus delaying tasks in the expired queue from running;
- * see scheduler_tick()).
+ * Called when a process is dequeued and given the cpu.
  *
  * This function is only called from sched_info_arrive(), rather than
  * dequeue_task(). Even though a task may be queued and dequeued multiple
@@ -533,13 +433,11 @@ static void sched_info_arrive(task_t *t)
 }
 
 /*
- * Called when a process is queued into either the active or expired
- * array.  The time is noted and later used to determine how long we
- * had to wait for us to reach the cpu.  Since the expired queue will
- * become the active queue after active queue is empty, without dequeuing
- * and requeuing any tasks, we are interested in queuing to either. It
- * is unusual but not impossible for tasks to be dequeued and immediately
- * requeued in the same or another array: this can happen in sched_yield(),
+ * Called when a process is queued
+ * The time is noted and later used to determine how long we had to wait for
+ * us to reach the cpu.
+ * It is unusual but not impossible for tasks to be dequeued and immediately
+ * requeued: this can happen in sched_yield(),
  * set_user_nice(), and even load_balance() as it moves tasks from runqueue
  * to runqueue.
  *
@@ -594,79 +492,72 @@ static inline void sched_info_switch(tas
 #endif /* CONFIG_SCHEDSTATS */
 
 /*
- * Adding/removing a task to/from a priority array:
+ * Get nanosecond clock difference without overflowing unsigned long.
  */
-static void dequeue_task(struct task_struct *p, prio_array_t *array)
+static unsigned long ns_diff(const unsigned long long v1,
+	const unsigned long long v2)
 {
-	array->nr_active--;
-	list_del(&p->run_list);
-	if (list_empty(array->queue + p->prio))
-		__clear_bit(p->prio, array->bitmap);
+	unsigned long long vdiff;
+	if (likely(v1 > v2)) {
+		vdiff = v1 - v2;
+#if BITS_PER_LONG < 64
+		if (vdiff > (1 << 31))
+			vdiff = 1 << 31;
+#endif
+	} else {
+		/*
+		 * Rarely the clock appears to go backwards. There should
+		 * always be a positive difference so return 1.
+		 */
+		vdiff = 1;
+	}
+	return (unsigned long)vdiff;
 }
 
-static void enqueue_task(struct task_struct *p, prio_array_t *array)
+static inline int task_queued(const task_t *task)
 {
-	sched_info_queued(p);
-	list_add_tail(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
-	array->nr_active++;
-	p->array = array;
+	return !list_empty(&task->run_list);
 }
 
 /*
- * Put task to the end of the run list without the overhead of dequeue
- * followed by enqueue.
+ * Adding/removing a task to/from a runqueue:
  */
-static void requeue_task(struct task_struct *p, prio_array_t *array)
+static void fastcall dequeue_task(task_t *p, runqueue_t *rq)
 {
-	list_move_tail(&p->run_list, array->queue + p->prio);
+	list_del_init(&p->run_list);
+	if (list_empty(rq->queue + p->prio))
+		__clear_bit(p->prio, rq->bitmap);
+	p->ns_debit = 0;
 }
 
-static inline void enqueue_task_head(struct task_struct *p, prio_array_t *array)
+static void fastcall enqueue_task(task_t *p, runqueue_t *rq)
 {
-	list_add(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
-	array->nr_active++;
-	p->array = array;
+	list_add_tail(&p->run_list, rq->queue + p->prio);
+	__set_bit(p->prio, rq->bitmap);
 }
 
 /*
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
+ * Put task to the end of the run list without the overhead of dequeue
+ * followed by enqueue.
  */
-static int effective_prio(task_t *p)
+static void requeue_task(task_t *p, runqueue_t *rq)
 {
-	int bonus, prio;
-
-	if (rt_task(p))
-		return p->prio;
-
-	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
+	list_move_tail(&p->run_list, rq->queue + p->prio);
+}
 
-	prio = p->static_prio - bonus;
-	if (prio < MAX_RT_PRIO)
-		prio = MAX_RT_PRIO;
-	if (prio > MAX_PRIO-1)
-		prio = MAX_PRIO-1;
-	return prio;
+static inline void enqueue_task_head(task_t *p, runqueue_t *rq)
+{
+	list_add(&p->run_list, rq->queue + p->prio);
+	__set_bit(p->prio, rq->bitmap);
 }
 
+
 /*
  * __activate_task - move a task to the runqueue.
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task(p, rq->active);
+	enqueue_task(p, rq);
 	rq->nr_running++;
 }
 
@@ -675,87 +566,164 @@ static inline void __activate_task(task_
  */
 static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task_head(p, rq->active);
+	enqueue_task_head(p, rq);
 	rq->nr_running++;
 }
 
-static int recalc_task_prio(task_t *p, unsigned long long now)
+/*
+ * Bonus - How much higher than its base priority an interactive task can run.
+ */
+static inline unsigned int bonus(const task_t *p)
 {
-	/* Caller must always ensure 'now >= p->timestamp' */
-	unsigned long long __sleep_time = now - p->timestamp;
-	unsigned long sleep_time;
-
-	if (unlikely(p->policy == SCHED_BATCH))
-		sleep_time = 0;
-	else {
-		if (__sleep_time > NS_MAX_SLEEP_AVG)
-			sleep_time = NS_MAX_SLEEP_AVG;
-		else
-			sleep_time = (unsigned long)__sleep_time;
-	}
+	return TASK_USER_PRIO(p);
+}
 
-	if (likely(sleep_time > 0)) {
-		/*
-		 * User tasks that sleep a long time are categorised as
-		 * idle and will get just interactive status to stay active &
-		 * prevent them suddenly becoming cpu hogs and starving
-		 * other processes.
-		 */
-		if (p->mm && p->activated != -1 &&
-			sleep_time > INTERACTIVE_SLEEP(p)) {
-				p->sleep_avg = JIFFIES_TO_NS(MAX_SLEEP_AVG -
-						DEF_TIMESLICE);
-		} else {
-			/*
-			 * The lower the sleep avg a task has the more
-			 * rapidly it will rise with sleep time.
-			 */
-			sleep_time *= (MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
+static unsigned int fastcall rr_interval(const task_t *p)
+{
+	int nice = TASK_NICE(p);
 
-			/*
-			 * Tasks waking from uninterruptible sleep are
-			 * limited in their sleep_avg rise as they
-			 * are likely to be waiting on I/O
-			 */
-			if (p->activated == -1 && p->mm) {
-				if (p->sleep_avg >= INTERACTIVE_SLEEP(p))
-					sleep_time = 0;
-				else if (p->sleep_avg + sleep_time >=
-						INTERACTIVE_SLEEP(p)) {
-					p->sleep_avg = INTERACTIVE_SLEEP(p);
-					sleep_time = 0;
-				}
-			}
+	if (nice < 0 && !rt_task(p))
+		return RR_INTERVAL * (20 - nice) / 20;
+	return RR_INTERVAL;
+}
 
-			/*
-			 * This code gives a bonus to interactive tasks.
-			 *
-			 * The boost works by updating the 'average sleep time'
-			 * value here, based on ->timestamp. The more time a
-			 * task spends sleeping, the higher the average gets -
-			 * and the higher the priority boost gets as well.
-			 */
-			p->sleep_avg += sleep_time;
+/*
+ * slice - the duration a task runs before getting requeued at its best
+ * priority and has its bonus decremented.
+ */
+static unsigned int fastcall slice(const task_t *p)
+{
+	unsigned int slice, rr;
 
-			if (p->sleep_avg > NS_MAX_SLEEP_AVG)
-				p->sleep_avg = NS_MAX_SLEEP_AVG;
-		}
+	slice = rr = rr_interval(p);
+	if (likely(!rt_task(p)))
+		slice += (39 - TASK_USER_PRIO(p)) * rr;
+	return slice;
+}
+
+/*
+ * We increase our bonus by sleeping more than the time we ran.
+ * The ratio of sleep to run gives us the cpu% that we last ran and determines
+ * the maximum bonus we can acquire.
+ */
+static void fastcall inc_bonus(task_t *p, const unsigned long totalrun,
+	const unsigned long sleep)
+{
+	unsigned int best_bonus;
+
+	best_bonus = sleep / (totalrun + 1);
+	if (p->bonus >= best_bonus)
+		return;
+
+	p->bonus++;
+	best_bonus = bonus(p);
+	if (p->bonus > best_bonus)
+		p->bonus = best_bonus;
+}
+
+static void dec_bonus(task_t *p)
+{
+	if (p->bonus)
+		p->bonus--;
+}
+
+/*
+ * effective_prio - dynamic priority dependent on bonus.
+ * The priority normally decreases by one each RR_INTERVAL.
+ * As the bonus increases the initial priority starts at a higher "stair" or
+ * priority for longer.
+ */
+static int effective_prio(const task_t *p)
+{
+	int prio;
+	unsigned int full_slice, used_slice = 0;
+	unsigned int best_bonus, rr;
+
+	if (rt_task(p))
+		return p->prio;
+
+	full_slice = slice(p);
+	if (full_slice > p->slice)
+		used_slice = full_slice - p->slice;
+
+	best_bonus = bonus(p);
+	prio = MAX_RT_PRIO + best_bonus;
+	if (likely(p->policy != SCHED_BATCH))
+		prio -= p->bonus;
+
+	rr = rr_interval(p);
+	prio += used_slice / rr;
+	if (prio > MAX_PRIO - 1)
+		prio = MAX_PRIO - 1;
+	return prio;
+}
+
+static inline void continue_slice(task_t *p)
+{
+	unsigned long total_run = NS_TO_JIFFIES(p->totalrun);
+
+	if (total_run >= p->slice) {
+		p->totalrun -= JIFFIES_TO_NS(p->slice);
+		dec_bonus(p);
+	} else {
+		unsigned int remainder;
+
+		p->slice -= total_run;
+		remainder = p->slice % rr_interval(p);
+		if (remainder)
+			p->time_slice = remainder;
 	}
+}
+
+/*
+ * recalc_task_prio - this checks for tasks that run ultra short timeslices
+ * or have just forked a thread/process and make them continue their old
+ * slice instead of starting a new one at high priority.
+ */
+static inline void recalc_task_prio(task_t *p, const unsigned long long now)
+{
+	unsigned long sleep_time = ns_diff(now, p->timestamp);
 
-	return effective_prio(p);
+	/*
+	 * Add the total for this last scheduled run (p->runtime) to the
+	 * running total so far used (p->totalrun).
+	 */
+	p->totalrun += p->runtime;
+
+	/*
+	 * If we sleep longer than our running total and have not set the
+	 * PF_NONSLEEP flag we gain a bonus.
+	 */
+	if (sleep_time >= p->totalrun && !(p->flags & PF_NONSLEEP)) {
+		inc_bonus(p, p->totalrun, sleep_time);
+		p->totalrun = 0;
+		return;
+	}
+
+	/*
+	 * If we have not set the PF_NONSLEEP flag we elevate priority by the
+	 * amount of time we slept.
+	 */
+	if (p->flags & PF_NONSLEEP)
+		p->flags &= ~PF_NONSLEEP;
+	else
+		p->totalrun -= sleep_time;
+
+	continue_slice(p);
 }
 
+
 /*
  * activate_task - move a task to the runqueue and do priority recalculation
  *
  * Update all the scheduling statistics stuff. (sleep average
  * calculation, priority modifiers, etc.)
  */
-static void activate_task(task_t *p, runqueue_t *rq, int local)
+static void activate_task(task_t *p, runqueue_t *rq, const int local)
 {
-	unsigned long long now;
+	unsigned long long now = sched_clock();
+	unsigned long rr = rr_interval(p);
 
-	now = sched_clock();
 #ifdef CONFIG_SMP
 	if (!local) {
 		/* Compensate for drifting sched_clock */
@@ -764,45 +732,24 @@ static void activate_task(task_t *p, run
 			+ rq->timestamp_last_tick;
 	}
 #endif
-
-	if (!rt_task(p))
-		p->prio = recalc_task_prio(p, now);
-
-	/*
-	 * This checks to make sure it's not an uninterruptible task
-	 * that is now waking up.
-	 */
-	if (!p->activated) {
-		/*
-		 * Tasks which were woken up by interrupts (ie. hw events)
-		 * are most likely of interactive nature. So we give them
-		 * the credit of extending their sleep time to the period
-		 * of time they spend on the runqueue, waiting for execution
-		 * on a CPU, first time around:
-		 */
-		if (in_interrupt())
-			p->activated = 2;
-		else {
-			/*
-			 * Normal first-time wakeups get a credit too for
-			 * on-runqueue time, but it will be weighted down:
-			 */
-			p->activated = 1;
-		}
+	p->slice = slice(p);
+	p->time_slice = p->slice % rr ? : rr;
+	if (!rt_task(p)) {
+		recalc_task_prio(p, now);
+		p->flags &= ~PF_NONSLEEP;
+		p->prio = effective_prio(p);
 	}
 	p->timestamp = now;
-
 	__activate_task(p, rq);
 }
 
 /*
  * deactivate_task - remove a task from the runqueue.
  */
-static void deactivate_task(struct task_struct *p, runqueue_t *rq)
+static void fastcall deactivate_task(task_t *p, runqueue_t *rq)
 {
 	rq->nr_running--;
-	dequeue_task(p, p->array);
-	p->array = NULL;
+	dequeue_task(p, rq);
 }
 
 /*
@@ -872,7 +819,7 @@ static int migrate_task(task_t *p, int d
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
 	 */
-	if (!p->array && !task_running(rq, p)) {
+	if (!task_queued(p) && !task_running(rq, p)) {
 		set_task_cpu(p, dest_cpu);
 		return 0;
 	}
@@ -902,7 +849,7 @@ void wait_task_inactive(task_t *p)
 repeat:
 	rq = task_rq_lock(p, &flags);
 	/* Must be off runqueue entirely, not preempted. */
-	if (unlikely(p->array || task_running(rq, p))) {
+	if (unlikely(task_queued(p) || task_running(rq, p))) {
 		/* If it's preempted, we yield.  It could be a while. */
 		preempted = !task_running(rq, p);
 		task_rq_unlock(rq, &flags);
@@ -1140,6 +1087,15 @@ static inline int wake_idle(int cpu, tas
 }
 #endif
 
+/*
+ * Check to see if p preempts rq->curr and resched if it does.
+ */
+static inline void preempt(const task_t *p, runqueue_t *rq)
+{
+	if (p->prio < rq->curr->prio)
+		resched_task(rq->curr);
+}
+
 /***
  * try_to_wake_up - wake up a thread
  * @p: the to-be-woken-up thread
@@ -1171,7 +1127,7 @@ static int try_to_wake_up(task_t *p, uns
 	if (!(old_state & state))
 		goto out;
 
-	if (p->array)
+	if (task_queued(p))
 		goto out_running;
 
 	cpu = task_cpu(p);
@@ -1260,7 +1216,7 @@ out_set_cpu:
 		old_state = p->state;
 		if (!(old_state & state))
 			goto out;
-		if (p->array)
+		if (task_queued(p))
 			goto out_running;
 
 		this_cpu = smp_processor_id();
@@ -1269,26 +1225,10 @@ out_set_cpu:
 
 out_activate:
 #endif /* CONFIG_SMP */
-	if (old_state == TASK_UNINTERRUPTIBLE) {
+	if (old_state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible--;
-		/*
-		 * Tasks on involuntary sleep don't earn
-		 * sleep_avg beyond just interactive state.
-		 */
-		p->activated = -1;
-	}
 
 	/*
-	 * Tasks that have marked their sleep as noninteractive get
-	 * woken up without updating their sleep average. (i.e. their
-	 * sleep is handled in a priority-neutral manner, no priority
-	 * boost and no penalty.)
-	 */
-	if (old_state & TASK_NONINTERACTIVE)
-		__activate_task(p, rq);
-	else
-		activate_task(p, rq, cpu == this_cpu);
-	/*
 	 * Sync wakeups (i.e. those types of wakeups where the waker
 	 * has indicated that it will leave the CPU in short order)
 	 * don't trigger a preemption, if the woken up task will run on
@@ -1296,10 +1236,9 @@ out_activate:
 	 * the waker guarantees that the freshly woken up task is going
 	 * to be considered on this CPU.)
 	 */
-	if (!sync || cpu != this_cpu) {
-		if (TASK_PREEMPTS_CURR(p, rq))
-			resched_task(rq->curr);
-	}
+	activate_task(p, rq, cpu == this_cpu);
+	if (!sync || cpu != this_cpu)
+		preempt(p, rq);
 	success = 1;
 
 out_running:
@@ -1344,7 +1283,6 @@ void fastcall sched_fork(task_t *p, int 
 	 */
 	p->state = TASK_RUNNING;
 	INIT_LIST_HEAD(&p->run_list);
-	p->array = NULL;
 #ifdef CONFIG_SCHEDSTATS
 	memset(&p->sched_info, 0, sizeof(p->sched_info));
 #endif
@@ -1355,30 +1293,6 @@ void fastcall sched_fork(task_t *p, int 
 	/* Want to start with kernel preemption disabled. */
 	task_thread_info(p)->preempt_count = 1;
 #endif
-	/*
-	 * Share the timeslice between parent and child, thus the
-	 * total amount of pending timeslices in the system doesn't change,
-	 * resulting in more scheduling fairness.
-	 */
-	local_irq_disable();
-	p->time_slice = (current->time_slice + 1) >> 1;
-	/*
-	 * The remainder of the first timeslice might be recovered by
-	 * the parent if the child exits early enough.
-	 */
-	p->first_time_slice = 1;
-	current->time_slice >>= 1;
-	p->timestamp = sched_clock();
-	if (unlikely(!current->time_slice)) {
-		/*
-		 * This case is rare, it happens when the parent has only
-		 * a single jiffy left from its timeslice. Taking the
-		 * runqueue lock is not a problem.
-		 */
-		current->time_slice = 1;
-		scheduler_tick();
-	}
-	local_irq_enable();
 	put_cpu();
 }
 
@@ -1401,36 +1315,20 @@ void fastcall wake_up_new_task(task_t *p
 	cpu = task_cpu(p);
 
 	/*
-	 * We decrease the sleep average of forking parents
-	 * and children as well, to keep max-interactive tasks
-	 * from forking tasks that are max-interactive. The parent
-	 * (current) is done further down, under its lock.
+	 * Forked process gets no bonus to prevent fork bombs.
 	 */
-	p->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
-		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
-
-	p->prio = effective_prio(p);
+	p->bonus = 0;
 
 	if (likely(cpu == this_cpu)) {
-		if (!(clone_flags & CLONE_VM)) {
+		current->flags |= PF_NONSLEEP;
+		activate_task(p, rq, 1);
+		if (!(clone_flags & CLONE_VM))
 			/*
 			 * The VM isn't cloned, so we're in a good position to
 			 * do child-runs-first in anticipation of an exec. This
 			 * usually avoids a lot of COW overhead.
 			 */
-			if (unlikely(!current->array))
-				__activate_task(p, rq);
-			else {
-				p->prio = current->prio;
-				list_add_tail(&p->run_list, &current->run_list);
-				p->array = current->array;
-				p->array->nr_active++;
-				rq->nr_running++;
-			}
 			set_need_resched();
-		} else
-			/* Run child last */
-			__activate_task(p, rq);
 		/*
 		 * We skip the following code due to cpu == this_cpu
 	 	 *
@@ -1447,53 +1345,20 @@ void fastcall wake_up_new_task(task_t *p
 		 */
 		p->timestamp = (p->timestamp - this_rq->timestamp_last_tick)
 					+ rq->timestamp_last_tick;
-		__activate_task(p, rq);
-		if (TASK_PREEMPTS_CURR(p, rq))
-			resched_task(rq->curr);
+		activate_task(p, rq, 0);
+		preempt(p, rq);
 
 		/*
 		 * Parent and child are on different CPUs, now get the
-		 * parent runqueue to update the parent's ->sleep_avg:
+		 * parent runqueue to update the parent's ->flags:
 		 */
 		task_rq_unlock(rq, &flags);
 		this_rq = task_rq_lock(current, &flags);
+		current->flags |= PF_NONSLEEP;
 	}
-	current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
-		PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
 	task_rq_unlock(this_rq, &flags);
 }
 
-/*
- * Potentially available exiting-child timeslices are
- * retrieved here - this way the parent does not get
- * penalized for creating too many threads.
- *
- * (this cannot be used to 'generate' timeslices
- * artificially, because any timeslice recovered here
- * was given away by the parent in the first place.)
- */
-void fastcall sched_exit(task_t *p)
-{
-	unsigned long flags;
-	runqueue_t *rq;
-
-	/*
-	 * If the child was a (relative-) CPU hog then decrease
-	 * the sleep_avg of the parent as well.
-	 */
-	rq = task_rq_lock(p->parent, &flags);
-	if (p->first_time_slice && task_cpu(p) == task_cpu(p->parent)) {
-		p->parent->time_slice += p->time_slice;
-		if (unlikely(p->parent->time_slice > task_timeslice(p)))
-			p->parent->time_slice = task_timeslice(p);
-	}
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = p->parent->sleep_avg /
-		(EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg /
-		(EXIT_WEIGHT + 1);
-	task_rq_unlock(rq, &flags);
-}
-
 /**
  * prepare_task_switch - prepare to switch tasks
  * @rq: the runqueue preparing to switch
@@ -1765,23 +1630,21 @@ void sched_exec(void)
  * pull_task - move a task from a remote runqueue to the local runqueue.
  * Both runqueues must be locked.
  */
-static
-void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p,
-	       runqueue_t *this_rq, prio_array_t *this_array, int this_cpu)
+static void pull_task(runqueue_t *src_rq, task_t *p, runqueue_t *this_rq,
+	const int this_cpu)
 {
-	dequeue_task(p, src_array);
+	dequeue_task(p, src_rq);
 	src_rq->nr_running--;
 	set_task_cpu(p, this_cpu);
 	this_rq->nr_running++;
-	enqueue_task(p, this_array);
+	enqueue_task(p, this_rq);
 	p->timestamp = (p->timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
 	 */
-	if (TASK_PREEMPTS_CURR(p, this_rq))
-		resched_task(this_rq->curr);
+	preempt(p, this_rq);
 }
 
 /*
@@ -1830,7 +1693,6 @@ static int move_tasks(runqueue_t *this_r
 		      unsigned long max_nr_move, struct sched_domain *sd,
 		      enum idle_type idle, int *all_pinned)
 {
-	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
 	int idx, pulled = 0, pinned = 0;
 	task_t *tmp;
@@ -1840,38 +1702,17 @@ static int move_tasks(runqueue_t *this_r
 
 	pinned = 1;
 
-	/*
-	 * We first consider expired tasks. Those will likely not be
-	 * executed in the near future, and they are most likely to
-	 * be cache-cold, thus switching CPUs has the least effect
-	 * on them.
-	 */
-	if (busiest->expired->nr_active) {
-		array = busiest->expired;
-		dst_array = this_rq->expired;
-	} else {
-		array = busiest->active;
-		dst_array = this_rq->active;
-	}
-
-new_array:
 	/* Start searching at priority 0: */
 	idx = 0;
 skip_bitmap:
 	if (!idx)
-		idx = sched_find_first_bit(array->bitmap);
+		idx = sched_find_first_bit(busiest->bitmap);
 	else
-		idx = find_next_bit(array->bitmap, MAX_PRIO, idx);
-	if (idx >= MAX_PRIO) {
-		if (array == busiest->expired && busiest->active->nr_active) {
-			array = busiest->active;
-			dst_array = this_rq->active;
-			goto new_array;
-		}
+		idx = find_next_bit(busiest->bitmap, MAX_PRIO, idx);
+	if (idx >= MAX_PRIO)
 		goto out;
-	}
 
-	head = array->queue + idx;
+	head = busiest->queue + idx;
 	curr = head->prev;
 skip_queue:
 	tmp = list_entry(curr, task_t, run_list);
@@ -1890,7 +1731,7 @@ skip_queue:
 		schedstat_inc(sd, lb_hot_gained[idle]);
 #endif
 
-	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
+	pull_task(busiest, tmp, this_rq, this_cpu);
 	pulled++;
 
 	/* We only want to steal up to the prescribed number of tasks. */
@@ -2379,15 +2220,13 @@ static void rebalance_tick(int this_cpu,
 			continue;
 
 		interval = sd->balance_interval;
-		if (idle != SCHED_IDLE)
-			interval *= sd->busy_factor;
 
 		/* scale ms to jiffies */
 		interval = msecs_to_jiffies(interval);
 		if (unlikely(!interval))
 			interval = 1;
 
-		if (j - sd->last_balance >= interval) {
+		if (idle != SCHED_IDLE || j - sd->last_balance >= interval) {
 			if (load_balance(this_cpu, this_rq, sd, idle)) {
 				/*
 				 * We've pulled tasks over so either we're no
@@ -2461,22 +2300,6 @@ unsigned long long current_sched_time(co
 }
 
 /*
- * We place interactive tasks back into the active array, if possible.
- *
- * To guarantee that this does not starve expired tasks we ignore the
- * interactivity of a task if the first expired task had to wait more
- * than a 'reasonable' amount of time. This deadline timeout is
- * load-dependent, as the frequency of array switched decreases with
- * increasing number of running tasks. We also ignore the interactivity
- * if a better static_prio task has expired:
- */
-#define EXPIRED_STARVING(rq) \
-	((STARVATION_LIMIT && ((rq)->expired_timestamp && \
-		(jiffies - (rq)->expired_timestamp >= \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1))) || \
-			((rq)->curr->static_prio > (rq)->best_expired_prio))
-
-/*
  * Account user cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @hardirq_offset: the offset to subtract from hardirq_count()
@@ -2524,6 +2347,7 @@ void account_system_time(struct task_str
 		cpustat->iowait = cputime64_add(cpustat->iowait, tmp);
 	else
 		cpustat->idle = cputime64_add(cpustat->idle, tmp);
+
 	/* Account for system time used */
 	acct_update_integrals(p);
 }
@@ -2549,18 +2373,25 @@ void account_steal_time(struct task_stru
 		cpustat->steal = cputime64_add(cpustat->steal, tmp);
 }
 
+static void time_slice_expired(task_t *p, runqueue_t *rq)
+{
+	set_tsk_need_resched(p);
+	dequeue_task(p, rq);
+	p->prio = effective_prio(p);
+	p->time_slice = rr_interval(p);
+	enqueue_task(p, rq);
+}
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
- *
- * It also gets called by the fork code, when changing the parent's
- * timeslices.
  */
 void scheduler_tick(void)
 {
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
+	unsigned long debit, expired_balance = rq->nr_running;
 	unsigned long long now = sched_clock();
 
 	update_cpu_clock(p, rq, now);
@@ -2575,78 +2406,48 @@ void scheduler_tick(void)
 	}
 
 	/* Task might have expired already, but not scheduled off yet */
-	if (p->array != rq->active) {
+	if (unlikely(!task_queued(p))) {
 		set_tsk_need_resched(p);
 		goto out;
 	}
-	spin_lock(&rq->lock);
 	/*
-	 * The task was running during this tick - update the
-	 * time slice counter. Note: we do not update a thread's
-	 * priority until it either goes to sleep or uses up its
-	 * timeslice. This makes it possible for interactive tasks
-	 * to use up their timeslices at their highest priority levels.
+	 * SCHED_FIFO tasks never run out of timeslice.
 	 */
-	if (rt_task(p)) {
-		/*
-		 * RR tasks need a special form of timeslice management.
-		 * FIFO tasks have no timeslices.
-		 */
-		if ((p->policy == SCHED_RR) && !--p->time_slice) {
-			p->time_slice = task_timeslice(p);
-			p->first_time_slice = 0;
-			set_tsk_need_resched(p);
+	if (unlikely(p->policy == SCHED_FIFO)) {
+		expired_balance = 0;
+		goto out;
+	}
 
-			/* put it at the end of the queue: */
-			requeue_task(p, rq->active);
-		}
+	spin_lock(&rq->lock);
+	debit = ns_diff(rq->timestamp_last_tick, p->timestamp);
+	p->ns_debit += debit;
+	if (p->ns_debit < NSJIFFY)
+		goto out_unlock;
+	p->ns_debit %= NSJIFFY;
+	/*
+	 * Tasks lose bonus each time they use up a full slice().
+	 */
+	if (!--p->slice) {
+		dec_bonus(p);
+		p->slice = slice(p);
+		time_slice_expired(p, rq);
+		p->totalrun = 0;
 		goto out_unlock;
 	}
+	/*
+	 * Tasks that run out of time_slice but still have slice left get
+	 * requeued with a lower priority && RR_INTERVAL time_slice.
+	 */
 	if (!--p->time_slice) {
-		dequeue_task(p, rq->active);
-		set_tsk_need_resched(p);
-		p->prio = effective_prio(p);
-		p->time_slice = task_timeslice(p);
-		p->first_time_slice = 0;
-
-		if (!rq->expired_timestamp)
-			rq->expired_timestamp = jiffies;
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			enqueue_task(p, rq->expired);
-			if (p->static_prio < rq->best_expired_prio)
-				rq->best_expired_prio = p->static_prio;
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
-			requeue_task(p, rq->active);
-			set_tsk_need_resched(p);
-		}
+		time_slice_expired(p, rq);
+		goto out_unlock;
 	}
+	expired_balance = 0;
 out_unlock:
 	spin_unlock(&rq->lock);
 out:
-	rebalance_tick(cpu, rq, NOT_IDLE);
+	if (expired_balance > 1)
+		rebalance_tick(cpu, rq, NOT_IDLE);
 }
 
 #ifdef CONFIG_SCHED_SMT
@@ -2703,19 +2504,19 @@ static void wake_sleeping_dependent(int 
 
 /*
  * number of 'lost' timeslices this task wont be able to fully
- * utilize, if another task runs on a sibling. This models the
+ * utilise, if another task runs on a sibling. This models the
  * slowdown effect of other tasks running on siblings:
  */
-static inline unsigned long smt_slice(task_t *p, struct sched_domain *sd)
+static inline unsigned long smt_slice(const task_t *p,
+	const struct sched_domain *sd)
 {
-	return p->time_slice * (100 - sd->per_cpu_gain) / 100;
+	return p->slice * (100 - sd->per_cpu_gain) / 100;
 }
 
 static int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
 {
 	struct sched_domain *tmp, *sd = NULL;
 	cpumask_t sibling_map;
-	prio_array_t *array;
 	int ret = 0, i;
 	task_t *p;
 
@@ -2742,12 +2543,8 @@ static int dependent_sleeper(int this_cp
 	 */
 	if (!this_rq->nr_running)
 		goto out_unlock;
-	array = this_rq->active;
-	if (!array->nr_active)
-		array = this_rq->expired;
-	BUG_ON(!array->nr_active);
 
-	p = list_entry(array->queue[sched_find_first_bit(array->bitmap)].next,
+	p = list_entry(this_rq->queue[sched_find_first_bit(this_rq->bitmap)].next,
 		task_t, run_list);
 
 	for_each_cpu_mask(i, sibling_map) {
@@ -2777,7 +2574,7 @@ static int dependent_sleeper(int this_cp
 		} else
 			if (smt_curr->static_prio < p->static_prio &&
 				!TASK_PREEMPTS_CURR(p, smt_rq) &&
-				smt_slice(smt_curr, sd) > task_timeslice(p))
+				smt_slice(smt_curr, sd) > slice(p))
 					ret = 1;
 
 check_smt_task:
@@ -2800,7 +2597,7 @@ check_smt_task:
 					resched_task(smt_curr);
 		} else {
 			if (TASK_PREEMPTS_CURR(p, smt_rq) &&
-				smt_slice(p, sd) > task_timeslice(smt_curr))
+				smt_slice(p, sd) > slice(smt_curr))
 					resched_task(smt_curr);
 			else
 				wakeup_busy_runqueue(smt_rq);
@@ -2862,11 +2659,10 @@ asmlinkage void __sched schedule(void)
 	long *switch_count;
 	task_t *prev, *next;
 	runqueue_t *rq;
-	prio_array_t *array;
 	struct list_head *queue;
 	unsigned long long now;
-	unsigned long run_time;
-	int cpu, idx, new_prio;
+	unsigned long debit;
+	int cpu, idx;
 
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
@@ -2901,20 +2697,11 @@ need_resched_nonpreemptible:
 
 	schedstat_inc(rq, sched_cnt);
 	now = sched_clock();
-	if (likely((long long)(now - prev->timestamp) < NS_MAX_SLEEP_AVG)) {
-		run_time = now - prev->timestamp;
-		if (unlikely((long long)(now - prev->timestamp) < 0))
-			run_time = 0;
-	} else
-		run_time = NS_MAX_SLEEP_AVG;
-
-	/*
-	 * Tasks charged proportionately less run_time at high sleep_avg to
-	 * delay them losing their interactive status
-	 */
-	run_time /= (CURRENT_BONUS(prev) ? : 1);
 
 	spin_lock_irq(&rq->lock);
+	prev->runtime = ns_diff(now, prev->timestamp);
+	debit = ns_diff(now, rq->timestamp_last_tick) % NSJIFFY;
+	prev->ns_debit += debit;
 
 	if (unlikely(prev->flags & PF_DEAD))
 		prev->state = EXIT_DEAD;
@@ -2926,8 +2713,10 @@ need_resched_nonpreemptible:
 				unlikely(signal_pending(prev))))
 			prev->state = TASK_RUNNING;
 		else {
-			if (prev->state == TASK_UNINTERRUPTIBLE)
+			if (prev->state == TASK_UNINTERRUPTIBLE) {
+				prev->flags |= PF_NONSLEEP;
 				rq->nr_uninterruptible++;
+			}
 			deactivate_task(prev, rq);
 		}
 	}
@@ -2938,7 +2727,6 @@ go_idle:
 		idle_balance(cpu, rq);
 		if (!rq->nr_running) {
 			next = rq->idle;
-			rq->expired_timestamp = 0;
 			wake_sleeping_dependent(cpu, rq);
 			/*
 			 * wake_sleeping_dependent() might have released
@@ -2962,45 +2750,15 @@ go_idle:
 			goto go_idle;
 	}
 
-	array = rq->active;
-	if (unlikely(!array->nr_active)) {
-		/*
-		 * Switch the active and expired arrays.
-		 */
-		schedstat_inc(rq, sched_switch);
-		rq->active = rq->expired;
-		rq->expired = array;
-		array = rq->active;
-		rq->expired_timestamp = 0;
-		rq->best_expired_prio = MAX_PRIO;
-	}
-
-	idx = sched_find_first_bit(array->bitmap);
-	queue = array->queue + idx;
+	idx = sched_find_first_bit(rq->bitmap);
+	queue = rq->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
-	if (!rt_task(next) && next->activated > 0) {
-		unsigned long long delta = now - next->timestamp;
-		if (unlikely((long long)(now - next->timestamp) < 0))
-			delta = 0;
-
-		if (next->activated == 1)
-			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
-
-		array = next->array;
-		new_prio = recalc_task_prio(next, next->timestamp + delta);
-
-		if (unlikely(next->prio != new_prio)) {
-			dequeue_task(next, array);
-			next->prio = new_prio;
-			enqueue_task(next, array);
-		} else
-			requeue_task(next, array);
-	}
-	next->activated = 0;
 switch_tasks:
 	if (next == rq->idle)
 		schedstat_inc(rq, sched_goidle);
+	prev->timestamp = now;
+
 	prefetch(next);
 	prefetch_stack(next);
 	clear_tsk_need_resched(prev);
@@ -3008,11 +2766,6 @@ switch_tasks:
 
 	update_cpu_clock(prev, rq, now);
 
-	prev->sleep_avg -= run_time;
-	if ((long)prev->sleep_avg <= 0)
-		prev->sleep_avg = 0;
-	prev->timestamp = prev->last_ran = now;
-
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
 		next->timestamp = now;
@@ -3444,9 +3197,8 @@ EXPORT_SYMBOL(sleep_on_timeout);
 void set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
-	prio_array_t *array;
 	runqueue_t *rq;
-	int old_prio, new_prio, delta;
+	int queued, old_prio, new_prio, delta;
 
 	if (TASK_NICE(p) == nice || nice < -20 || nice > 19)
 		return;
@@ -3465,18 +3217,19 @@ void set_user_nice(task_t *p, long nice)
 		p->static_prio = NICE_TO_PRIO(nice);
 		goto out_unlock;
 	}
-	array = p->array;
-	if (array)
-		dequeue_task(p, array);
+	if ((queued = task_queued(p)))
+		dequeue_task(p, rq);
 
 	old_prio = p->prio;
 	new_prio = NICE_TO_PRIO(nice);
 	delta = new_prio - old_prio;
 	p->static_prio = NICE_TO_PRIO(nice);
 	p->prio += delta;
+	if (p->bonus > bonus(p))
+		p->bonus= bonus(p);
 
-	if (array) {
-		enqueue_task(p, array);
+	if (queued) {
+		enqueue_task(p, rq);
 		/*
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
@@ -3599,19 +3352,13 @@ static inline task_t *find_process_by_pi
 /* Actually do priority change: must hold rq lock. */
 static void __setscheduler(struct task_struct *p, int policy, int prio)
 {
-	BUG_ON(p->array);
+	BUG_ON(task_queued(p));
 	p->policy = policy;
 	p->rt_priority = prio;
 	if (policy != SCHED_NORMAL && policy != SCHED_BATCH) {
 		p->prio = MAX_RT_PRIO-1 - p->rt_priority;
-	} else {
+	} else
 		p->prio = p->static_prio;
-		/*
-		 * SCHED_BATCH tasks are treated as perpetual CPU hogs:
-		 */
-		if (policy == SCHED_BATCH)
-			p->sleep_avg = 0;
-	}
 }
 
 /**
@@ -3625,8 +3372,7 @@ int sched_setscheduler(struct task_struc
 		       struct sched_param *param)
 {
 	int retval;
-	int oldprio, oldpolicy = -1;
-	prio_array_t *array;
+	int queued, oldprio, oldpolicy = -1;
 	unsigned long flags;
 	runqueue_t *rq;
 
@@ -3688,12 +3434,11 @@ recheck:
 		task_rq_unlock(rq, &flags);
 		goto recheck;
 	}
-	array = p->array;
-	if (array)
+	if ((queued = task_queued(p)))
 		deactivate_task(p, rq);
 	oldprio = p->prio;
 	__setscheduler(p, policy, param->sched_priority);
-	if (array) {
+	if (queued) {
 		__activate_task(p, rq);
 		/*
 		 * Reschedule if we are currently running on this runqueue and
@@ -3703,8 +3448,8 @@ recheck:
 		if (task_running(rq, p)) {
 			if (p->prio > oldprio)
 				resched_task(rq->curr);
-		} else if (TASK_PREEMPTS_CURR(p, rq))
-			resched_task(rq->curr);
+		} else
+			preempt(p, rq);
 	}
 	task_rq_unlock(rq, &flags);
 	return 0;
@@ -3961,43 +3706,27 @@ asmlinkage long sys_sched_getaffinity(pi
 
 /**
  * sys_sched_yield - yield the current processor to other threads.
- *
- * this function yields the current CPU by moving the calling thread
- * to the expired array. If there are no other threads running on this
- * CPU then this function will return.
+ * This function yields the current CPU by dropping the priority of current
+ * to the lowest priority.
  */
 asmlinkage long sys_sched_yield(void)
 {
+	int newprio;
 	runqueue_t *rq = this_rq_lock();
-	prio_array_t *array = current->array;
-	prio_array_t *target = rq->expired;
 
+	newprio = current->prio;
 	schedstat_inc(rq, yld_cnt);
-	/*
-	 * We implement yielding by moving the task into the expired
-	 * queue.
-	 *
-	 * (special rule: RT tasks will just roundrobin in the active
-	 *  array.)
-	 */
-	if (rt_task(current))
-		target = rq->active;
-
-	if (array->nr_active == 1) {
-		schedstat_inc(rq, yld_act_empty);
-		if (!rq->expired->nr_active)
-			schedstat_inc(rq, yld_both_empty);
-	} else if (!rq->expired->nr_active)
-		schedstat_inc(rq, yld_exp_empty);
-
-	if (array != target) {
-		dequeue_task(current, array);
-		enqueue_task(current, target);
+	current->slice = slice(current);
+	current->time_slice = rr_interval(current);
+	if (likely(!rt_task(current)))
+		newprio = MAX_PRIO - 1;
+
+	if (newprio != current->prio) {
+		dequeue_task(current, rq);
+		current->prio = newprio;
+		enqueue_task(current, rq);
 	} else
-		/*
-		 * requeue_task is cheaper so perform that if possible.
-		 */
-		requeue_task(current, array);
+		requeue_task(current, rq);
 
 	/*
 	 * Since we are going to call schedule() anyway, there's
@@ -4206,7 +3935,7 @@ long sys_sched_rr_get_interval(pid_t pid
 		goto out_unlock;
 
 	jiffies_to_timespec(p->policy & SCHED_FIFO ?
-				0 : task_timeslice(p), &t);
+				0 : slice(p), &t);
 	read_unlock(&tasklist_lock);
 	retval = copy_to_user(interval, &t, sizeof(t)) ? -EFAULT : 0;
 out_nounlock:
@@ -4329,8 +4058,6 @@ void __devinit init_idle(task_t *idle, i
 	unsigned long flags;
 
 	idle->timestamp = sched_clock();
-	idle->sleep_avg = 0;
-	idle->array = NULL;
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
 	idle->cpus_allowed = cpumask_of_cpu(cpu);
@@ -4447,7 +4174,7 @@ static void __migrate_task(struct task_s
 		goto out;
 
 	set_task_cpu(p, dest_cpu);
-	if (p->array) {
+	if (task_queued(p)) {
 		/*
 		 * Sync timestamp with rq_dest's before activating.
 		 * The same thing could be achieved by doing this step
@@ -4458,8 +4185,7 @@ static void __migrate_task(struct task_s
 				+ rq_dest->timestamp_last_tick;
 		deactivate_task(p, rq_src);
 		activate_task(p, rq_dest, 0);
-		if (TASK_PREEMPTS_CURR(p, rq_dest))
-			resched_task(rq_dest->curr);
+		preempt(p, rq_dest);
 	}
 
 out:
@@ -4673,7 +4399,7 @@ static void migrate_dead_tasks(unsigned 
 
 	for (arr = 0; arr < 2; arr++) {
 		for (i = 0; i < MAX_PRIO; i++) {
-			struct list_head *list = &rq->arrays[arr].queue[i];
+			struct list_head *list = &rq->queue[i];
 			while (!list_empty(list))
 				migrate_dead(dead_cpu,
 					     list_entry(list->next, task_t,
@@ -6015,17 +5741,13 @@ int in_sched_functions(unsigned long add
 void __init sched_init(void)
 {
 	runqueue_t *rq;
-	int i, j, k;
+	int i, j;
 
 	for_each_cpu(i) {
-		prio_array_t *array;
 
 		rq = cpu_rq(i);
 		spin_lock_init(&rq->lock);
 		rq->nr_running = 0;
-		rq->active = rq->arrays;
-		rq->expired = rq->arrays + 1;
-		rq->best_expired_prio = MAX_PRIO;
 
 #ifdef CONFIG_SMP
 		rq->sd = NULL;
@@ -6037,16 +5759,13 @@ void __init sched_init(void)
 		INIT_LIST_HEAD(&rq->migration_queue);
 #endif
 		atomic_set(&rq->nr_iowait, 0);
-
-		for (j = 0; j < 2; j++) {
-			array = rq->arrays + j;
-			for (k = 0; k < MAX_PRIO; k++) {
-				INIT_LIST_HEAD(array->queue + k);
-				__clear_bit(k, array->bitmap);
-			}
-			// delimiter for bitsearch
-			__set_bit(MAX_PRIO, array->bitmap);
-		}
+		for (j = 0; j < MAX_PRIO; j++)
+			INIT_LIST_HEAD(&rq->queue[j]);
+		memset(rq->bitmap, 0, BITS_TO_LONGS(MAX_PRIO)*sizeof(long));
+		/*
+		 * delimiter for bitsearch
+		 */
+		__set_bit(MAX_PRIO, rq->bitmap);
 	}
 
 	/*
@@ -6090,9 +5809,9 @@ EXPORT_SYMBOL(__might_sleep);
 void normalize_rt_tasks(void)
 {
 	struct task_struct *p;
-	prio_array_t *array;
 	unsigned long flags;
 	runqueue_t *rq;
+	int queued;
 
 	read_lock_irq(&tasklist_lock);
 	for_each_process (p) {
@@ -6101,11 +5820,10 @@ void normalize_rt_tasks(void)
 
 		rq = task_rq_lock(p, &flags);
 
-		array = p->array;
-		if (array)
+		if ((queued = task_queued(p)))
 			deactivate_task(p, task_rq(p));
 		__setscheduler(p, SCHED_NORMAL, 0);
-		if (array) {
+		if (queued) {
 			__activate_task(p, task_rq(p));
 			resched_task(rq->curr);
 		}
