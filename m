Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290668AbSAYMm7>; Fri, 25 Jan 2002 07:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290670AbSAYMmv>; Fri, 25 Jan 2002 07:42:51 -0500
Received: from mx2.elte.hu ([157.181.151.9]:40858 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290668AbSAYMmp>;
	Fri, 25 Jan 2002 07:42:45 -0500
Date: Fri, 25 Jan 2002 15:40:15 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] interactiveness updates to -J4, 2.5.3-pre3
Message-ID: <Pine.LNX.4.33.0201251528520.7457-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch updates the interactiveness code to the -J4 version,
which was found to be better than -J2 by most people. (remaining issues
are still being worked on.)

besides tuning, the patch does the following things:

 - it moves all the scheduler constants into sched.h and makes their usage
   more conform, and to make tuning patches more compact and easier to
   compare.

 - introduces two new tunables for places that influence interactiveness.
   We now have the following tunables:

    #define MIN_TIMESLICE          ( 10 * HZ / 1000)
    #define MAX_TIMESLICE          (300 * HZ / 1000)
    #define CHILD_FORK_PENALTY     95
    #define PARENT_FORK_PENALTY    100
    #define EXIT_WEIGHT            3
    #define PRIO_INTERACTIVE_RATIO 20
    #define PRIO_CPU_HOG_RATIO     60
    #define PRIO_BONUS_RATIO       70
    #define INTERACTIVE_DELTA      3
    #define MAX_SLEEP_AVG          (2*HZ)
    #define STARVATION_LIMIT       (2*HZ)

   Some current values of the tunables (such as PARENT_FORK_PENALTY's 100%
   value) has no effect currently, but i've added it nevertheless to
   increase tuning flexibility. They can be removed once we decide that
   things are cast into stone.

 - introduces rq->expired_timestamp to guarantee a certain level of
   fairness even to CPU hogs. expired_timestamp is not touched in any of
   the hotpaths, it's only used/set in the timer interrupt and in the idle
   thread branch of schedule(). This fairness guarantee does work as
   intended, and it does not disturb interactivity in any noticeable way
   even under higher load. It's mostly protection against intentional or
   unintended abuse.

this patch depends on the fork-fix patch. All other previous patches are
otherwise independent from each other. I've tested all 9 patches together
on both UP and SMP systems, and they equivalent with the -J6 patch
correctness-wise, and with the -J4 patch tuning-wise.

	Ingo

--- linux/kernel/exit.c.orig	Fri Jan 25 10:44:18 2002
+++ linux/kernel/exit.c	Fri Jan 25 12:06:36 2002
@@ -59,6 +59,8 @@
 	current->time_slice += p->time_slice;
 	if (current->time_slice > MAX_TIMESLICE)
 		current->time_slice = MAX_TIMESLICE;
+	current->sleep_avg = (current->sleep_avg*EXIT_WEIGHT + p->sleep_avg) /
+					(EXIT_WEIGHT + 1);
 	__restore_flags(flags);

 	p->pid = 0;
--- linux/kernel/sched.c.orig	Fri Jan 25 10:44:18 2002
+++ linux/kernel/sched.c	Fri Jan 25 12:06:36 2002
@@ -41,7 +41,7 @@
  */
 struct runqueue {
 	spinlock_t lock;
-	unsigned long nr_running, nr_switches;
+	unsigned long nr_running, nr_switches, expired_timestamp;
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
@@ -109,12 +108,30 @@
  * being a CPU hog.
  *
  */
-#define PRIO_INTERACTIVE	(MAX_RT_PRIO + MAX_USER_PRIO/4)
-#define PRIO_CPU_HOG		(MAX_RT_PRIO + MAX_USER_PRIO*3/4)

-#define TASK_INTERACTIVE(p) (((p)->prio <= PRIO_INTERACTIVE) ||		\
-	(((p)->prio < PRIO_CPU_HOG) &&					\
-		((p)->prio <= NICE_TO_PRIO((p)->__nice)-3)))
+#define PRIO_INTERACTIVE \
+		(MAX_RT_PRIO + MAX_USER_PRIO*PRIO_INTERACTIVE_RATIO/100)
+#define PRIO_CPU_HOG \
+		(MAX_RT_PRIO + MAX_USER_PRIO*PRIO_CPU_HOG_RATIO/100)
+
+#define TASK_INTERACTIVE(p) \
+	(((p)->prio <= PRIO_INTERACTIVE) || \
+	(((p)->prio < PRIO_CPU_HOG) && \
+		((p)->prio <= NICE_TO_PRIO((p)->__nice) - INTERACTIVE_DELTA)))
+
+/*
+ * We place interactive tasks back into the active array, if possible.
+ *
+ * To guarantee that this does not starve expired tasks we ignore the
+ * interactivity of a task if the first expired task had to wait more
+ * than a 'reasonable' amount of time. This deadline timeout is
+ * load-dependent, as the frequency of array switched decreases with
+ * increasing number of running tasks:
+ */
+#define EXPIRED_STARVING(rq) \
+		((rq)->expired_timestamp && \
+		(jiffies - (rq)->expired_timestamp >= \
+			STARVATION_LIMIT * ((rq)->nr_running) + 1))

 static inline int effective_prio(task_t *p)
 {
@@ -122,18 +139,19 @@

 	/*
 	 * Here we scale the actual sleep average [0 .... MAX_SLEEP_AVG]
-	 * into the 19 ... -18 bonus/penalty range.
+	 * into the -14 ... +14 bonus/penalty range.
 	 *
-	 * We take off the 10% from the full 0...39 priority range so that:
+	 * We use 70% of the full 0...39 priority range so that:
 	 *
-	 * 1) nice +19 CPU hogs do not preempt nice 0 CPU hogs just yet.
+	 * 1) nice +19 CPU hogs do not preempt nice 0 CPU hogs.
 	 * 2) nice -20 interactive tasks do not get preempted by
 	 *    nice 0 interactive tasks.
 	 *
-	 * Both properties are important to certain applications.
+	 * Both properties are important to certain workloads.
 	 */
-	bonus = MAX_USER_PRIO*9/10 * p->sleep_avg / MAX_SLEEP_AVG -
-							MAX_USER_PRIO*9/10/2;
+	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
+			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
+
 	prio = NICE_TO_PRIO(p->__nice) - bonus;
 	if (prio < MAX_RT_PRIO)
 		prio = MAX_RT_PRIO;
@@ -275,8 +293,10 @@

 	p->state = TASK_RUNNING;
 	if (!rt_task(p)) {
-		p->sleep_avg = (p->sleep_avg * 4) / 5;
+		p->sleep_avg = p->sleep_avg * CHILD_FORK_PENALTY / 100;
 		p->prio = effective_prio(p);
+
+		current->sleep_avg = current->sleep_avg * PARENT_FORK_PENALTY / 100;
 	}
 	spin_lock_irq(&rq->lock);
	p->cpu = smp_processor_id();
@@ -562,7 +587,13 @@
 		p->need_resched = 1;
 		p->prio = effective_prio(p);
 		p->time_slice = NICE_TO_TIMESLICE(p->__nice);
-		enqueue_task(p, TASK_INTERACTIVE(p) ? rq->active : rq->expired);
+
+		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+			if (!rq->expired_timestamp)
+				rq->expired_timestamp = jiffies;
+			enqueue_task(p, rq->expired);
+		} else
+			enqueue_task(p, rq->active);
 	}
 out:
 	if (!(now % BUSY_REBALANCE_TICK))
@@ -604,6 +636,7 @@
 		if (rq->nr_running)
 			goto pick_next_task;
 		next = rq->idle;
+		rq->expired_timestamp = 0;
 		goto switch_tasks;
 	}

@@ -615,6 +648,7 @@
 		rq->active = rq->expired;
 		rq->expired = array;
 		array = rq->active;
+		rq->expired_timestamp = 0;
 	}

 	idx = sched_find_first_zero_bit(array->bitmap);
--- linux/include/linux/sched.h.orig	Fri Jan 25 10:44:18 2002
+++ linux/include/linux/sched.h	Fri Jan 25 12:06:36 2002
@@ -256,7 +256,6 @@

 	unsigned int time_slice;

-	#define MAX_SLEEP_AVG (2*HZ)
 	unsigned long sleep_avg;
 	unsigned long sleep_timestamp;

@@ -418,11 +417,22 @@
 #define DEF_USER_NICE		0

 /*
- * Default timeslice is 90 msecs, maximum is 180 msecs.
+ * Default timeslice is 150 msecs, maximum is 300 msecs.
  * Minimum timeslice is 10 msecs.
+ *
+ * These are the 'tuning knobs' of the scheduler:
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(180 * HZ / 1000)
+#define MAX_TIMESLICE		(300 * HZ / 1000)
+#define CHILD_FORK_PENALTY	95
+#define PARENT_FORK_PENALTY	100
+#define EXIT_WEIGHT		3
+#define PRIO_INTERACTIVE_RATIO	20
+#define PRIO_CPU_HOG_RATIO	60
+#define PRIO_BONUS_RATIO	70
+#define INTERACTIVE_DELTA	3
+#define MAX_SLEEP_AVG		(2*HZ)
+#define STARVATION_LIMIT	(2*HZ)

 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
--- linux/include/linux/init_task.h.orig	Fri Jan 25 10:44:18 2002
+++ linux/include/linux/init_task.h	Fri Jan 25 12:06:36 2002
@@ -53,7 +53,7 @@
     mm:			NULL,						\
     active_mm:		&init_mm,					\
     run_list:		LIST_HEAD_INIT(tsk.run_list),			\
-    time_slice:		NICE_TO_TIMESLICE(DEF_USER_NICE),		\
+    time_slice:		HZ,						\
     next_task:		&tsk,						\
     prev_task:		&tsk,						\
     p_opptr:		&tsk,						\


