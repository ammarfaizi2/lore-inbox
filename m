Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262327AbTCKAUM>; Mon, 10 Mar 2003 19:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbTCKAUM>; Mon, 10 Mar 2003 19:20:12 -0500
Received: from h00e098094f32.ne.client2.attbi.com ([24.60.234.83]:51584 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S262327AbTCKAT7>;
	Mon, 10 Mar 2003 19:19:59 -0500
Date: Mon, 10 Mar 2003 19:30:54 -0500
Message-Id: <200303110030.h2B0UsR00844@linux.local>
From: Jim Houston <jim.houston@attbi.com>
To: linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: [PATCH] self tuning scheduler
Reply-to: jim.houston@attbi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone,

I wish I had been paying attention when the recent "HT scehduler" thread
started.  I have been playing with some scheduler changes which are
relevant to this discussion.  The attached patch (against linux-2.5.64-bk4)
makes the scheduler's dynamic priority scheme more consistent.
The patch should improve the system's interactive feel by not giving long
time slices to processes with favorable priorities.  Under a heavy load
the system should slow down rather than get jerky.

The scheduler currently mixes a priority based approach with a round
robin behavior which keeps processes from starving.  With my changes, the
scheduler always runs in a priority based mode.  It measures the cpu time
that the process receives and uses this value with the static_prio value to
control the process's priority.  It uses a feedback approach.  The more
cpu time a process uses, the lower its priority.  A lower priority means that
the process competes less effectively with the other processes.  It gets
less cpu time, and its priority improves.

This scheme also means that comparing priorities between processors is
more meaningful.  With the current scheduler, you could have two processors
both running priority 39 processes.  One process might be a "nice -19"
process, but you can't tell that from the priority.  I have added a 
rq->prio_avg value which is an average of the priority at which the 
processor has been running.  I believe that this should be useful input
for load balancing.

The patch adds a p->run_avg which is a running average of the process's
cpu use.  Typically these averages are done by multiplying the old value
by a fraction and adding in the current value.  If you do this at some
constant frequency, then the ratio of old vs. new is constant.  I only 
want to deal with this average in the same places that the current 
sleep_avg is calculated so I need to calculate an appropriate fraction.
Here is what I want:
	value *= exp((ln(0.5)/half_life) * delta_time);
This gets ugly when you only have integer math and have to avoid overflows.


To make this pure priority based scheme work, I need occasionally to
update the priority of processes which are in the run queue but are
not at a priority which allows them to run.  I added a linked list
of processes in the run queue in least recently run order.  I added code
to scheduler_tick to examine these forgotten processes re-evaluating their
run average value and dynamic priority.  

The existing scheduler implements nice(2) by giving processes time
slices based on their nice value (static_prio).  A normal process would
have a 150 millisecond time slice while a "nice -19" process gets 
10 milliseconds.  There is a trade off here.  If you have a shorter
time slice, processes will spend more time reloading data into the
processor cache, but longer time slices may impact the system's interactive
feel.  

The patch uses feedback based on the run_avg to implement nice.  This 
allows more creative use for the time slice.  If the process is running
at a favorable interactive priority, it is given a short time slice.
This allows the priority to be re-evaluated if the process decides
to go compute bound.  Processes which are running at lower priorities
are rewarded by giving them longer time slices.

I tried several functions for the effective_prio calculation to make
nice(2) work properly.  Eventually I realized that log() was the right
answer.  Consider:

	prio = static_prio + C*log(run_avg)

If two processes competing for the cpu with different static_prio values,
they will reach equilibrium at some dynamic priority when:

	prio = static_prio1 + C*log(run_avg1) = static_prio2 + C*log(run_avg2)

	static_prio1 - static_prio2 = C*log(run_avg1) - C*log(run_avg2);

	static_prio1 - static_prio2 = C*log(run_avg1/run_avg2)

	run_avg1/run_avg2 = exp((static_prio1-static_prio2)/C)

We can pick the constant C so that nice has the desired effect.  If 
a "nice -19" process competes with a "nice --20" process, it might
get 1/50 of the cpu.  This would give:

	C = (static_prio1-static_prio2)/log(run_avg1/run_avg2)
	C = (40)/log(50)

Try clipping this into gnuplot

	set xrange [0:1]
	f(x) = nice + C*log(x)
	C=10
	plot nice=30, f(x) title "nice -10", nice=20, f(x) title "normal"

I had to expand the range of dynamic priorities.  The range is now
from 0-79.  Normally interactive processes will have priorities around
30 and compute bound processes will find an equilibrium value which
depends on the number of processes sharing the cpu.  Is there any reason
not to let this new range be user visible?  Both ps and top seem happy
with the new range.

When I posted a similar patch last fallaa, Albert Cahalan suggested making
the run average value available in the /proc/stat for display as %CPU
in ps.  The patch actually adds both the run_avg and sleep_avg values.
I found this useful while debugging.

The patch implements the log() for effective_prio() and the exp() for 
decay_value() using integer math and only a few multiplies.  

The patch currently adds two blocks of new code and makes several
small changes to call the new functions.  The patch obsoletes the
array switch logic, but I have not removed the obsolete code yet.
This makes the  patch easier to read and easier to merge with other
scheduler work which may be in progress.

Initially I tried replacing the sleep_avg with the run_avg.  The run_avg
gives a good priority boost to programs that use very little cpu.  It
does not do a good job of separating processes which sometimes sleep
from compute bound processes.  The current patch uses the existing 
2.5.64-bk4 sleep_avg logic.  The variable sleep_avg_nice controls the
amount of boost that interactive tasks receive.  I default this to 
10 which should give an interactive task the equivalent of a nice +10.

Jim Houston - Concurrent Computer Corp.

--

diff -urN -X dontdiff linux-2.5.64-bk4.orig/fs/proc/array.c linux-2.5.64-bk4/fs/proc/array.c
--- linux-2.5.64-bk4.orig/fs/proc/array.c	Fri Mar  7 11:57:27 2003
+++ linux-2.5.64-bk4/fs/proc/array.c	Sun Mar  9 16:47:18 2003
@@ -336,7 +336,7 @@
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %llu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %lu %lu\n",
 		task->pid,
 		task->comm,
 		state,
@@ -382,7 +382,9 @@
 		task->exit_signal,
 		task_cpu(task),
 		task->rt_priority,
-		task->policy);
+		task->policy,
+		task->run_avg,
+		task->sleep_avg);
 	if(mm)
 		mmput(mm);
 	return res;
diff -urN -X dontdiff linux-2.5.64-bk4.orig/include/asm-i386/bitops.h linux-2.5.64-bk4/include/asm-i386/bitops.h
--- linux-2.5.64-bk4.orig/include/asm-i386/bitops.h	Fri Mar  7 11:55:26 2003
+++ linux-2.5.64-bk4/include/asm-i386/bitops.h	Sun Mar  9 16:47:18 2003
@@ -426,8 +426,8 @@
 
 /*
  * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
+ * way of searching a 180-bit bitmap where the first 100 bits are
+ * unlikely to be set. It's guaranteed that at least one of the 180
  * bits is cleared.
  */
 static inline int sched_find_first_bit(unsigned long *b)
@@ -440,7 +440,9 @@
 		return __ffs(b[2]) + 64;
 	if (b[3])
 		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
+	if (b[4])
+		return __ffs(b[4]) + 128;
+	return __ffs(b[5]) + 160;
 }
 
 /**
diff -urN -X dontdiff linux-2.5.64-bk4.orig/include/linux/sched.h linux-2.5.64-bk4/include/linux/sched.h
--- linux-2.5.64-bk4.orig/include/linux/sched.h	Mon Mar 10 11:51:52 2003
+++ linux-2.5.64-bk4/include/linux/sched.h	Sun Mar  9 16:51:39 2003
@@ -267,7 +267,7 @@
 #define MAX_USER_RT_PRIO	100
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
 
-#define MAX_PRIO		(MAX_RT_PRIO + 40)
+#define MAX_PRIO		(MAX_RT_PRIO + 80)
  
 /*
  * Some day this will be a full-fledged user tracking system..
@@ -326,6 +326,10 @@
 	int prio, static_prio;
 	struct list_head run_list;
 	prio_array_t *array;
+  
+	struct list_head run_list_lru;
+	unsigned long run_avg;
+	unsigned long run_avg_timestamp;
 
 	unsigned long sleep_avg;
 	unsigned long last_run;
diff -urN -X dontdiff linux-2.5.64-bk4.orig/kernel/sched.c linux-2.5.64-bk4/kernel/sched.c
--- linux-2.5.64-bk4.orig/kernel/sched.c	Mon Mar 10 11:51:52 2003
+++ linux-2.5.64-bk4/kernel/sched.c	Mon Mar 10 17:34:28 2003
@@ -14,6 +14,9 @@
  *		an array-switch method of distributing timeslices
  *		and per-CPU runqueues.  Cleanups and useful suggestions
  *		by Davide Libenzi, preemptible kernel bits by Robert Love.
+ *  2003-03-08	Modified by Jim Houston - Concurrent Computer Corp.
+ *		Experimental changes to base effective_prio() calculation
+ *		on an exponentially decaying run average.
  */
 
 #include <linux/mm.h>
@@ -39,13 +42,80 @@
 #define cpu_to_node_mask(cpu) (cpu_online_map)
 #endif
 
+#define MAX_RUN_AVG	(256*1024)
+#define MIN_RUN_AVG	(4)
+#define SF_PRIO_AVG	(1024)
+#define MAX_PRIO_AVG	((MAX_PRIO-MAX_RT_PRIO)*SF_PRIO_AVG)
+
+/*
+ * These constants control the effect of nice(2).  See the comment for
+ * effective_prio() for the details.  This value results in a
+ * a "nice -19" task competing with a "nice +20" receiving 2% (1/50)
+ * of the cpu.  The 40 below is the priority difference and the 
+ * 3.912 is the natural log of 50.
+ *
+ * It should be safe to use floating point in constants used to 
+ * create an integer initializer.
+ */
+#define SCALE_FACTOR	0x10000 
+static const int nice_const = (int)((3.912/40.0)*(float)SCALE_FACTOR);
+static const int exp_nice_const = (int)(1.10274*(float)SCALE_FACTOR);
+
+static const int prio_offset = 5;
+/*
+ * The following half-life time constants control the period over which
+ * the p->run_avg value is averaged.  As always its a compromise.  A
+ * smaller value would let a compute bound process sink to an appropriate
+ * priority quickly.  A larger value makes the scheduler more forgiving 
+ * when an normally interactive process decides it wants the cpu for
+ * a few seconds.
+ *
+ * Changing these values may require adjusting scale factor (sf) used
+ * in decay_value().
+ */
+static const int run_avg_halflife = 5*HZ;
+
+/*
+ * The rq->prio_avg is used to estimate how busy the processor has been
+ * recently. It is used to pick an initial priority for new processes.  The
+ * following time constant is the half life for this exponentially decaying
+ * average.
+ */
+static const int prio_avg_halflife = 2*HZ;
+ 
+static const int log_2 = (int)(0.69314718*(float)SCALE_FACTOR);
+
+/*
+ * Interactive processes (larger p->sleep_avg) are given a
+ * priority boost.  sleep_avg_nice is the maximum bonus value.
+ */
+int sleep_avg_nice = 10;
+
+typedef struct runqueue runqueue_t;
+extern unsigned int task_timeslice(task_t *p);
+extern void update_run_avg_sleeping(task_t *p, unsigned long delta_time);
+extern void update_run_avg_runable( task_t *p);
+extern void update_run_avg_running(task_t *p);
+extern void update_prio_avg(runqueue_t *rq, task_t *p);
+extern int effective_prio(task_t *p);
+extern int estimate_run_avg(int prio_diff, const int max);
+extern void fairness_update(runqueue_t *rq);
+/*
+ * fairness_update() is called from scheduler_tick() to adjust the
+ * priority of processes which are in the runqueue but which never
+ * get to run.  This parameter controls the interval for these 
+ * adjustments.
+ */
+#define FAIRNESS_TICKS	(HZ/8 ?: 1)
+#define FAIRNESS_MIN	4
+
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
  * and back.
  */
-#define NICE_TO_PRIO(nice)	(MAX_RT_PRIO + (nice) + 20)
-#define PRIO_TO_NICE(prio)	((prio) - MAX_RT_PRIO - 20)
+#define NICE_TO_PRIO(nice)	((MAX_PRIO-20) + (nice))
+#define PRIO_TO_NICE(prio)	((prio) - (MAX_PRIO-20))
 #define TASK_NICE(p)		PRIO_TO_NICE((p)->static_prio)
 
 /*
@@ -75,6 +145,7 @@
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
 
+#if 0
 /*
  * If a task is 'interactive' then we reinsert it in the active
  * array after it has expired its current timeslice. (it will not
@@ -131,6 +202,7 @@
 {
 	return BASE_TIMESLICE(p);
 }
+#endif
 
 /*
  * These are the runqueue data structures:
@@ -138,10 +210,13 @@
 
 #define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
 
+#if 0
 typedef struct runqueue runqueue_t;
+#endif
 
 struct prio_array {
 	int nr_active;
+	struct list_head lru_list;
 	unsigned long bitmap[BITMAP_SIZE];
 	struct list_head queue[MAX_PRIO];
 };
@@ -157,6 +232,7 @@
 	spinlock_t lock;
 	unsigned long nr_running, nr_switches, expired_timestamp,
 			nr_uninterruptible;
+	unsigned long prio_avg;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
@@ -281,6 +357,8 @@
 {
 	array->nr_active--;
 	list_del(&p->run_list);
+	if (!rt_task(p))
+		list_del(&p->run_list_lru);
 	if (list_empty(array->queue + p->prio))
 		__clear_bit(p->prio, array->bitmap);
 }
@@ -288,11 +366,14 @@
 static inline void enqueue_task(struct task_struct *p, prio_array_t *array)
 {
 	list_add_tail(&p->run_list, array->queue + p->prio);
+	if (!rt_task(p))
+		list_add_tail(&p->run_list_lru, &array->lru_list);
 	__set_bit(p->prio, array->bitmap);
 	array->nr_active++;
 	p->array = array;
 }
 
+#if 0
 /*
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
@@ -324,6 +405,7 @@
 		prio = MAX_PRIO-1;
 	return prio;
 }
+#endif
 
 /*
  * __activate_task - move a task to the runqueue.
@@ -342,12 +424,14 @@
  */
 static inline int activate_task(task_t *p, runqueue_t *rq)
 {
-	unsigned long sleep_time = jiffies - p->last_run;
+	unsigned long sleep_time = jiffies - p->run_avg_timestamp;
 	int requeue_waker = 0;
+	int time_slice;
 
 	if (sleep_time) {
 		int sleep_avg;
 
+		p->run_avg_timestamp = jiffies;
 		/*
 		 * This code gives a bonus to interactive tasks.
 		 *
@@ -377,9 +461,17 @@
 			}
 			sleep_avg = MAX_SLEEP_AVG;
 		}
-		if (p->sleep_avg != sleep_avg) {
-			p->sleep_avg = sleep_avg;
+		p->sleep_avg = sleep_avg;
+		if (!rt_task(p)) {
+			update_run_avg_sleeping(p, sleep_time);
 			p->prio = effective_prio(p);
+			/*
+			 * Make sure the timeslice is appropriate
+			 * for the new priority.
+			 */
+			time_slice = task_timeslice(p);
+			if (p->time_slice > time_slice)
+				p->time_slice = time_slice;
 		}
 	}
 	__activate_task(p, rq);
@@ -572,6 +664,7 @@
 {
 	unsigned long flags;
 	runqueue_t *rq = task_rq_lock(current, &flags);
+	int i;
 
 	p->state = TASK_RUNNING;
 	/*
@@ -581,6 +674,18 @@
 	 */
 	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
+	/*
+	 * We want the new process to have a reasonable change to
+	 * run.  The rq->prio_avg is a good estimate of the priority
+	 * at which the system has been running.  Since the p->run_avg
+	 * is a basis for the priority calculate a run_avg value
+	 * which corresponds to the prio_avg.
+	 */
+	i = rq->prio_avg/SF_PRIO_AVG;
+	i -= (MAX_PRIO - p->static_prio - prio_offset);
+	/* Set sleep_avg for minimum bonus. */
+	p->run_avg = estimate_run_avg(i, MAX_RUN_AVG);
+	p->run_avg_timestamp = jiffies;
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
 
@@ -589,6 +694,8 @@
 	else {
 		p->prio = current->prio;
 		list_add_tail(&p->run_list, &current->run_list);
+		if (!rt_task(p))
+			list_add_tail(&p->run_list_lru, &rq->active->lru_list);
 		p->array = current->array;
 		p->array->nr_active++;
 		nr_running_inc(rq);
@@ -1197,6 +1304,9 @@
  	if (rcu_pending(cpu))
  		rcu_check_callbacks(cpu, user_ticks);
 
+	/* update rq->prio_avg */
+	update_prio_avg(rq, p);
+
 	if (p == rq->idle) {
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
@@ -1222,7 +1332,7 @@
 	spin_lock(&rq->lock);
 	/*
 	 * The task was running during this tick - update the
-	 * time slice counter and the sleep average. Note: we
+	 * time slice counter and the sleep and run averages. Note: we
 	 * do not update a thread's priority until it either
 	 * goes to sleep or uses up its timeslice. This makes
 	 * it possible for interactive tasks to use up their
@@ -1230,6 +1340,7 @@
 	 */
 	if (p->sleep_avg)
 		p->sleep_avg--;
+	update_run_avg_running(p);
 	if (unlikely(rt_task(p))) {
 		/*
 		 * RR tasks need a special form of timeslice management.
@@ -1252,15 +1363,11 @@
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
-
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			if (!rq->expired_timestamp)
-				rq->expired_timestamp = jiffies;
-			enqueue_task(p, rq->expired);
-		} else
-			enqueue_task(p, rq->active);
+		enqueue_task(p, rq->active);
 	}
 out:
+	if (!(jiffies % FAIRNESS_TICKS))
+		fairness_update(rq);
 	spin_unlock(&rq->lock);
 	rebalance_tick(rq, 0);
 }
@@ -2006,7 +2113,16 @@
 	 */
 	if (likely(!rt_task(current))) {
 		dequeue_task(current, array);
-		enqueue_task(current, rq->expired);
+#if 0
+		if (current->prio < MAX_PRIO-1)
+			current->prio++;
+#else
+		current->prio = MAX_PRIO-1;
+		current->run_avg += current->run_avg/4;
+		if (current->run_avg > MAX_RUN_AVG)
+			current->run_avg = MAX_RUN_AVG;
+#endif
+		enqueue_task(current, array);
 	} else {
 		list_del(&current->run_list);
 		list_add_tail(&current->run_list, array->queue + current->prio);
@@ -2521,6 +2637,7 @@
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;
+			INIT_LIST_HEAD(&array->lru_list);
 			for (k = 0; k < MAX_PRIO; k++) {
 				INIT_LIST_HEAD(array->queue + k);
 				__clear_bit(k, array->bitmap);
@@ -2608,3 +2725,334 @@
 	} while (!_raw_write_trylock(lock));
 }
 #endif
+
+
+/*
+ * Processes trade a less favorable priority for a longer time slice.  The
+ * higher a processes priority the more often we want to re-evaluate its 
+ * dynamic priority.
+ */
+unsigned int task_timeslice(task_t *p)
+{
+	if (unlikely(p->policy == SCHED_RR)) {
+		/*
+		 * nice is overloaded to control timeslice for SCHED_RR
+		 */
+		return(MIN_TIMESLICE + ((MAX_TIMESLICE - MIN_TIMESLICE) *
+			(MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)));
+	}
+	if (p->prio >= p->static_prio)
+		return(HZ/2  ?: 1);
+	if (p->prio > p->static_prio-8)
+		return(HZ/8  ?: 1);
+	if (p->prio > p->static_prio-16)
+		return(HZ/50  ?: 1);
+	if (p->prio > p->static_prio-24)
+		return(HZ/100  ?: 1);
+	if (p->prio > p->static_prio-32)
+		return(HZ/200  ?: 1);
+	if (p->prio > p->static_prio-40)
+		return(HZ/500  ?: 1);
+	return(1);
+}
+
+/*
+ * Exponentially decay a value for a running average.  The half_life
+ * is the period of time where the value should decay to half of its
+ * original value.  Here is a simpler version of what it does:
+ *
+ *	while (delta_time > half_life) {
+ *		delta_time -= half_life;
+ * 		value /= 2;
+ *	}
+ *	value *= exp((ln(0.5)/half_life) * delta_time);
+ *
+ * The exp() is approximated using the first 3 terms of:
+ *	exp(x) = 1 + x/1! + x^2/2! + x^3/3! ...
+ * The value is a fraction represented as a number ranging from 0 - max.
+ */
+
+static inline int decay_value(int value, int delta_time,
+	const int half_life)
+{
+	const int sf = 0x10000;
+	const int as = (-log_2 / (SCALE_FACTOR/sf))/half_life;
+	static const int ov = MAX_RUN_AVG/(INT_MAX/sf);
+	int i, j;
+
+	if (unlikely(delta_time > half_life)) {
+		/*
+		 * value >>= delta_time/half_life
+		 * This could be simplified if we picked a half_life
+		 * which was a power of 2.
+		 */
+		if (delta_time >= 16*half_life)
+			return(MIN_RUN_AVG);
+		if (delta_time > 8*half_life) {
+			value >>= 8;
+			delta_time -= 8*half_life;
+		}
+		if (delta_time > 4*half_life) {
+			value >>= 4;
+			delta_time -= 4*half_life;
+		}
+		if (delta_time > 2*half_life) {
+			value >>= 2;
+			delta_time -= 2*half_life;
+		}
+		if (delta_time > half_life) {
+			value >>= 1;
+			delta_time -= half_life;
+		}
+	}
+	if (value < MIN_RUN_AVG)
+		return(MIN_RUN_AVG);
+	i = delta_time * as;
+	/*
+	 * This approximates value * exp(i/sf).  Where i is in the range
+	 * [sf*log(0.5):0]. (log(0.5) = -0.6931)
+	 *
+	 * I checked this out using gnuplot with:
+	 * 	set xrange [log(.5):0]
+	 * 	my_exp(x) = 1  + (x>-.125 ? 7*x/8 : x + x*x*3/8)
+	 * 	plot my_exp(x) , exp(x)
+	 * 	plot my_exp(x) - exp(x)
+	 * The error is about 1%
+	 */ 
+	if (i > -sf/8)
+		j = i - i/8;
+	else
+		j =  i + (i/4)*(i/4)*3/(sf/2);
+	/*
+	 * exp(i/sf) = (1 + j/sf) 
+	 * multiply by value without overflow.
+	 */
+	if (j > -(INT_MAX/MAX_RUN_AVG)) {
+		value += (value * j)/sf;
+	} else if (value < INT_MAX/sf) {
+		value = (value * (sf + j))/sf;
+	} else {
+		value = (value * ((sf + j)/ov))/(sf/ov);
+	}
+	return value;
+}
+
+void update_run_avg_sleeping(task_t *p, unsigned long delta_time)
+{
+
+	p->run_avg = decay_value(p->run_avg, delta_time, run_avg_halflife);
+}
+
+void update_run_avg_runable( task_t *p)
+{
+	unsigned long delta_time;
+	int run_avg;
+
+	delta_time = jiffies - p->run_avg_timestamp;
+	p->run_avg_timestamp = jiffies;
+	run_avg = decay_value(p->run_avg,delta_time, run_avg_halflife);
+	p->run_avg = run_avg;
+}
+
+/*
+ * If a process is constantly running we want the run_avg to reach an
+ * equilibrium value of MAX_RUN_AVG.  Calculate the value to add on each
+ * cycle to balance the fraction lost through the exponential decay above.
+ */
+static inline int get_increment(const int half_life, const int max)
+{
+	const int sf=64*1024;
+	const int as = (-log_2 / (SCALE_FACTOR/sf))/half_life;
+	return((max * -as)/sf);
+}
+
+
+void update_run_avg_running(task_t *p)
+{
+	unsigned long delta_time;
+	int run_avg;
+
+	delta_time = jiffies - p->run_avg_timestamp;
+	p->run_avg_timestamp = jiffies;
+	run_avg = decay_value(p->run_avg, delta_time, run_avg_halflife);
+	run_avg += get_increment(run_avg_halflife, MAX_RUN_AVG);
+	if (run_avg > MAX_RUN_AVG)
+		run_avg = MAX_RUN_AVG;
+	p->run_avg = run_avg;
+}
+
+/*
+ * prio_avg is a filtered average of the prio values of the running
+ * processes.  This value is used to choose a fair priority for new
+ * processes.  It may also be useful as measure of the cpu load for
+ * load balancing.
+ */
+void update_prio_avg(runqueue_t *rq, task_t *p)
+{
+	int prio;
+	int i;
+
+	i = get_increment(prio_avg_halflife, MAX_PRIO_AVG);
+	prio = MAX_PRIO - p->prio;
+	if (prio > MAX_USER_PRIO)
+		prio = MAX_USER_PRIO;
+	rq->prio_avg -= (rq->prio_avg * i)/MAX_PRIO_AVG;
+	rq->prio_avg +=  i*prio/MAX_USER_PRIO;
+}
+
+/*
+ * effective_prio - Determine the dynamic priority for a process
+ * based on the run_avg and the static priority.  This logic 
+ * is the basis for the feedback loop which makes nice work.
+ * When a process gets to run its run_avg increases and this logic
+ * will decrease it's priority.
+ *
+ * I spent hours drawing little graphs trying to figure out how
+ * to make nice work.  Eventually I realized that what I needed
+ * was a logarithm.  Consider:
+ *
+ *	dynamic_prio = static_prio + prio_offset + log(run_avg/MAX_RUN_AVG)/c
+ *	c = log(50)/40
+ *
+ * If two processes are competing and reach an equilibrium at a 
+ * particular priority then their run averages are related as follows:
+ *
+ * static_prio1 + log(run_avg1)/c = static_prio2 + log(run_avg2)/c
+ *
+ * Since log(a)-log(b) = log(a/b) this means that the ratio of the 
+ * run_avg values will be a factor which is a function of the difference
+ * in the nice values.
+ *
+ * The constant c determines how much effect nice has.  The current
+ * value will give a "nice -19" task 2% of the cpu when it competes 
+ * with a "nice --20" task.
+ */
+
+int effective_prio(task_t *p)
+{
+	int exponent, mantissa, log, run_avg, prio;
+	const int sf = 0x800;
+	const int c = (const int)(sf*SCALE_FACTOR/nice_const);
+
+	run_avg = p->run_avg;
+	if (likely(p->run_avg)) {
+		run_avg = p->run_avg;
+		if (run_avg > MAX_RUN_AVG)
+			run_avg = MAX_RUN_AVG;
+		/*
+		 * Convert the run_avg/MAX_RUN_AVG to a normalized
+		 * binary fraction and an exponent.  
+		 * This could be optimized using __ilog2().
+		 */
+		for (exponent = 0; !(MAX_RUN_AVG & run_avg); exponent--)
+			run_avg <<= 1;
+		exponent++;
+		mantissa = run_avg / (2*MAX_RUN_AVG/sf);
+		/*
+		 * log(run_avg) = log(mantissa) + log(2) * exponent
+		 * The linear approximation 
+		 * 	log(x) = 2*log(2)*(1-x)
+		 * Has about 6% error over the range [0.5:1].
+		 * This should be ok.
+		 */
+		log = (log_2*2/(SCALE_FACTOR/sf))*(mantissa-sf)/sf;
+		log += log_2*exponent/(SCALE_FACTOR/sf);
+		prio = p->static_prio + prio_offset + c*log/(sf*sf);
+		/*
+		 * Give processes which sleep an priority boost.
+		 */
+		prio -= (sleep_avg_nice *  p->sleep_avg)/MAX_SLEEP_AVG;
+	} else {
+		prio = p->static_prio;
+	}
+	if (prio < MAX_RT_PRIO)
+		prio = MAX_RT_PRIO;
+	if (prio > MAX_PRIO-1)
+		prio = MAX_PRIO-1;  
+	return prio;
+}
+
+/*
+ * In wake_up_forked_process() we need to pick a run_avg value for the
+ * new process.  I want a value which will give the process a reasonable
+ * chance to run without jumping to the head of the queue.  The prio_avg
+ * is a reasonable estimate of a priority which will allow a process
+ * to run.  We can run the effective_prio() calculation backwards to
+ * convert this to a run_avg value.
+ *    run_avg = exp((prio - static_prio - prio_offset)/c)
+ *    run_avg = exp(1/c) ^ (prio - static_prio - prio_offset)
+ *
+ * Its less mind bending to deal with positive exponents so I calculate:
+ *    run_avg = exp(c) ^ (prio_diff)
+ *
+ * Yes a table lookup would make sense here.
+ */
+
+int estimate_run_avg(int prio_diff, const int max)
+{
+	const int sf = 0x4000;
+	const int prio_half = sf * log_2 / nice_const;
+	const int ratio = sf * SCALE_FACTOR / exp_nice_const; 
+	int shift, val;
+
+	prio_diff *= sf;
+	
+	shift = 0;
+	while (prio_diff > prio_half) {
+		prio_diff -= prio_half;
+		shift++;
+	}
+	prio_diff /= sf;
+	val = sf;
+	for ( ; prio_diff > 0 ; prio_diff--)
+		val = val * ratio / sf;
+	val *= max/sf;
+	val >>= shift;
+	return(val);
+}
+
+/*
+ * Processes which have been in the runqueue but not running need
+ * an occasional priority adjustment.  This is needed to preserve
+ * fairness.  The run_list_lru keeps a list of tasks sorted by 
+ * age. This allows us to find just these forgotten tasks. 
+ *
+ * Yes I know this is O(n).  The n in this case are processes which
+ * have not been able to get any cpu time in FAIRNESS_TICKS.  I limit
+ * the loop to only consider 1/8 of the processes in the run queue.
+ */
+
+void fairness_update(runqueue_t *rq)
+{ 
+	struct list_head *head, *curr;
+	task_t *p;
+	int prio;
+	int limit;
+
+	limit = rq->active->nr_active/8;
+	if (limit < FAIRNESS_MIN)
+		limit = FAIRNESS_MIN;
+	head = &rq->active->lru_list;
+	for (curr = head->next ; limit > 0 && curr != head; limit--) {
+		p = list_entry(curr, task_t, run_list_lru);
+		/* Real time processes should not be in this list. */
+		BUG_ON(rt_task(p));
+		if ((jiffies - p->run_avg_timestamp) < FAIRNESS_TICKS)
+			break;
+		update_run_avg_runable(p);
+		prio = effective_prio(p);
+
+		/*
+		 * The dequeue/enqueue re-order the list so 
+		 * pickup the next pointer here.
+		 */
+		curr = curr->next;
+		if (prio != p->prio) {
+			dequeue_task(p, rq->active);
+			p->prio = prio;
+			enqueue_task(p, rq->active);
+		}
+		if (prio < current->prio)
+			set_tsk_need_resched(current);
+	}
+}
