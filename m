Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbTIHPlC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbTIHPlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:41:02 -0400
Received: from horus.unipg.it ([141.250.1.230]:28288 "HELO horus.unipg.it")
	by vger.kernel.org with SMTP id S263106AbTIHPjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:39:07 -0400
From: Francesco Sportolari <francesco@unipg.it>
Organization: University of Perugia - ITALY
To: linux-kernel@vger.kernel.org
Subject: [PATCH] yet another scheduler patch
Date: Mon, 8 Sep 2003 17:40:03 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TLKX/e/VWJQRKLz"
Message-Id: <200309081740.03835.francesco@unipg.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_TLKX/e/VWJQRKLz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Yes.... This is another patch for the scheduler interactivity game...  :)

This one is based on the scoring algorithm of the ULE scheduler included in 
the latest freeBSD. Every process descriptor includes two new variables: 
sleeptime (the time the process spend in voluntary sleep) and runtime 
(incremented in scheduler_tick function).

These variable are scaled by the sleeptime_runtime_update() function in such 
way that their sum doesn't exceed the SLEEP_RUN_MAX value when the effective 
priority is needed.

The interactive score for each process is calculated with the 
interactive_score() function (take a look at the patch). If the process int 
score is less than the INTERACTIVE_THRESHOLD value, the process itself is 
considered interactive and it get a MIN_TIMESLICE time slice.
All the other processes get a time slice proportional to their effective 
priorities.

I've tried the patch only on a ppc UP machine and it behaves quite well. I've 
made some tests with volanomark under different loads (eg. listening a song 
with xmms, playing a movie with xine) and all the results are better than 
results of the same tests over a vanilla kernel.

Soon as possible i'll set up a web page with the results.

Also the audio-skip problem in xmms is solved. The window-shaking test has 
been passed :).

If someone wants to give a try he's welcome.

Ciao,
-- Francesco

--Boundary-00=_TLKX/e/VWJQRKLz
Content-Type: text/x-diff;
  charset="us-ascii";
  name="francesco_sched_patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="francesco_sched_patch.diff"

diff -urN linux-2.6.0-test4/fs/proc/array.c linux-2.6.0-test4-francesco/fs/proc/array.c
--- linux-2.6.0-test4/fs/proc/array.c	2003-08-23 01:57:05.000000000 +0200
+++ linux-2.6.0-test4-francesco/fs/proc/array.c	2003-09-01 13:23:46.000000000 +0200
@@ -154,13 +154,22 @@
 	read_lock(&tasklist_lock);
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
+		"sleeptime:\t%d\n"
+		"runtime:\t%d\n"
+		"prio:\t%d\n"
+		"static_prio:\t%d\n"
 		"Tgid:\t%d\n"
 		"Pid:\t%d\n"
 		"PPid:\t%d\n"
 		"TracerPid:\t%d\n"
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
-		get_task_state(p), p->tgid,
+		get_task_state(p),
+		p->sleeptime,
+		p->runtime,
+		p->prio,
+		p->static_prio,
+		p->tgid,
 		p->pid, p->pid ? p->real_parent->pid : 0,
 		p->pid && p->ptrace ? p->parent->pid : 0,
 		p->uid, p->euid, p->suid, p->fsuid,
diff -urN linux-2.6.0-test4/include/asm-ppc/bitops.h linux-2.6.0-test4-francesco/include/asm-ppc/bitops.h
--- linux-2.6.0-test4/include/asm-ppc/bitops.h	2003-08-23 01:56:12.000000000 +0200
+++ linux-2.6.0-test4-francesco/include/asm-ppc/bitops.h	2003-09-03 16:00:00.000000000 +0200
@@ -284,9 +284,13 @@
 		return __ffs(b[1]) + 32;
 	if (unlikely(b[2]))
 		return __ffs(b[2]) + 64;
-	if (b[3])
+	if (unlikely(b[3]))
 		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
+	if (unlikely(b[4]))
+		return __ffs(b[4]) + 128;
+	if (b[5])
+		return __ffs(b[5]) + 160;
+	return __ffs(b[6]) + 192;
 }
 
 /**
diff -urN linux-2.6.0-test4/include/linux/init_task.h linux-2.6.0-test4-francesco/include/linux/init_task.h
--- linux-2.6.0-test4/include/linux/init_task.h	2003-08-23 01:52:10.000000000 +0200
+++ linux-2.6.0-test4-francesco/include/linux/init_task.h	2003-09-03 16:00:00.000000000 +0200
@@ -68,7 +68,7 @@
 	.flags		= 0,						\
 	.lock_depth	= -1,						\
 	.prio		= MAX_PRIO-20,					\
-	.static_prio	= MAX_PRIO-20,					\
+	.static_prio	= MAX_PRIO-100,					\
 	.policy		= SCHED_NORMAL,					\
 	.cpus_allowed	= CPU_MASK_ALL,					\
 	.mm		= NULL,						\
diff -urN linux-2.6.0-test4/include/linux/sched.h linux-2.6.0-test4-francesco/include/linux/sched.h
--- linux-2.6.0-test4/include/linux/sched.h	2003-08-23 01:52:12.000000000 +0200
+++ linux-2.6.0-test4-francesco/include/linux/sched.h	2003-09-05 18:24:55.000000000 +0200
@@ -280,7 +280,7 @@
 #define MAX_USER_RT_PRIO	100
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
 
-#define MAX_PRIO		(MAX_RT_PRIO + 40)
+#define MAX_PRIO		(MAX_RT_PRIO + 120)
  
 /*
  * Some day this will be a full-fledged user tracking system..
@@ -339,8 +339,11 @@
 	struct list_head run_list;
 	prio_array_t *array;
 
-	unsigned long sleep_avg;
 	unsigned long last_run;
+	unsigned long go_to_sleep;
+	unsigned runtime;
+	unsigned sleeptime;
+	int interactive_score;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
diff -urN linux-2.6.0-test4/kernel/sched.c linux-2.6.0-test4-francesco/kernel/sched.c
--- linux-2.6.0-test4/kernel/sched.c	2003-08-23 01:58:43.000000000 +0200
+++ linux-2.6.0-test4-francesco/kernel/sched.c	2003-09-08 17:15:51.000000000 +0200
@@ -41,9 +41,10 @@
 #define cpu_to_node_mask(cpu) (cpu_online_map)
 #endif
 
+#define MAX(x,y)	((x > y) ? x : y)
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
- * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
+ * to static priority [ MAX_RT_PRIO..139 ],
  * and back.
  */
 #define NICE_TO_PRIO(nice)	(MAX_RT_PRIO + (nice) + 20)
@@ -53,7 +54,7 @@
 /*
  * 'User priority' is the nice value converted to something we
  * can work with better when scaling various scheduler parameters,
- * it's a [ 0 ... 39 ] range.
+ * it's a [ 0 ... 120 ] range.
  */
 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
@@ -62,18 +63,17 @@
 /*
  * These are the 'tuning knobs' of the scheduler:
  *
- * Minimum timeslice is 10 msecs, default timeslice is 100 msecs,
- * maximum timeslice is 200 msecs. Timeslices get refilled after
- * they expire.
+ * Minimum timeslice is 10 msecs, maximum timeslice is 140 msecs. 
+ * Timeslices get refilled after they expire.
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(200 * HZ / 1000)
-#define CHILD_PENALTY		50
-#define PARENT_PENALTY		100
+#define MAX_TIMESLICE		(140 * HZ / 1000)
+#define SLEEP_RUN_MAX		(10*HZ)
+#define SLEEP_RUN_THROTTLE	80
+#define INTERACTIVE_SCORE_MAX	80
+#define INTERACTIVE_SCORE_HALF	(INTERACTIVE_SCORE_MAX / 2)
+#define INTERACTIVE_THRESHOLD   16 	
 #define EXIT_WEIGHT		3
-#define PRIO_BONUS_RATIO	25
-#define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
 
@@ -83,54 +83,30 @@
  * continue to run immediately, it will still roundrobin with
  * other interactive tasks.)
  *
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
+ * If the interactive_score of the process is less than
+ * INTERACTIVE_THRESHOLD, we have an interactive thread.
+ * 
+ */
 
 #define TASK_INTERACTIVE(p) \
-	((p)->prio <= (p)->static_prio - DELTA(p))
+	(p->interactive_score <= INTERACTIVE_THRESHOLD)
 
 /*
- * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
+ * BASE_TIMESLICE scales effective priority values
  * to time slice values.
  *
- * The higher a thread's priority, the bigger timeslices
- * it gets during one round of execution. But even the lowest
- * priority thread gets MIN_TIMESLICE worth of execution time.
- *
- * task_timeslice() is the interface that is used by the scheduler.
+ * The higher a thread's priority, the smaller timeslices
+ * it gets during one round of execution. Interactive threads
+ * always get a MIN_TIMESLICE slice.
  */
 
-#define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
-	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
+#define BASE_TIMESLICE(p) ((((MAX_TIMESLICE - MIN_TIMESLICE) * (p)->prio)/(MAX_USER_PRIO - 1)) + MIN_TIMESLICE)
 
 static inline unsigned int task_timeslice(task_t *p)
 {
+	if (TASK_INTERACTIVE(p))
+		return MIN_TIMESLICE;
+
 	return BASE_TIMESLICE(p);
 }
 
@@ -298,35 +274,56 @@
 	p->array = array;
 }
 
+static void sleeptime_runtime_update(task_t *p)
+{
+	while ((p->runtime + p->sleeptime) > SLEEP_RUN_MAX) {
+		p->runtime = (p->runtime / 5) * 4;
+		p->sleeptime = (p->sleeptime / 5) * 4;
+	}
+}
+
+static int interactive_score(task_t *p)
+{
+	int div, score;
+
+	if (p->runtime > p->sleeptime) {
+		div = MAX(1, p->runtime / INTERACTIVE_SCORE_HALF);
+		score = (INTERACTIVE_SCORE_HALF + 
+		        (INTERACTIVE_SCORE_HALF - (p->sleeptime / div)));
+	} 
+	else if (p->sleeptime > p->runtime) {
+		div = MAX(1, p->sleeptime / INTERACTIVE_SCORE_HALF);
+		score = (p->runtime / div);
+	}
+	else
+		score = 0;
+
+	return score;
+}
+
 /*
- * effective_prio - return the priority that is based on the static
- * priority but is modified by bonuses/penalties.
- *
- * We scale the actual sleep average [0 .... MAX_SLEEP_AVG]
- * into the -5 ... 0 ... +5 bonus/penalty range.
+ * effective_prio - return the priority that is the static priority
+ * plus the interactive score of the process.
  *
- * We use 25% of the full 0...39 priority range so that:
+ * The interactive score is in the 0 ... +80 range.
  *
- * 1) nice +19 interactive tasks do not preempt nice 0 CPU hogs.
- * 2) nice -20 CPU hogs do not get preempted by nice 0 tasks.
- *
- * Both properties are important to certain workloads.
  */
-static int effective_prio(task_t *p)
+
+static inline int effective_prio(task_t *p)
 {
-	int bonus, prio;
+	int prio;
 
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
-			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
-
-	prio = p->static_prio - bonus;
+	p->interactive_score = interactive_score(p);
+	prio = p->static_prio + p->interactive_score;
+	
 	if (prio < MAX_RT_PRIO)
 		prio = MAX_RT_PRIO;
 	if (prio > MAX_PRIO-1)
 		prio = MAX_PRIO-1;
+
 	return prio;
 }
 
@@ -342,38 +339,17 @@
 /*
  * activate_task - move a task to the runqueue and do priority recalculation
  *
- * Update all the scheduling statistics stuff. (sleep average
- * calculation, priority modifiers, etc.)
+ * Update the sleeptime amount of the process and scale (if necessary) the
+ * sleeptime/runtime values
  */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	long sleep_time = jiffies - p->last_run - 1;
+	long sleep_time = jiffies - p->go_to_sleep;
 
 	if (sleep_time > 0) {
-		int sleep_avg;
-
-		/*
-		 * This code gives a bonus to interactive tasks.
-		 *
-		 * The boost works by updating the 'average sleep time'
-		 * value here, based on ->last_run. The more time a task
-		 * spends sleeping, the higher the average gets - and the
-		 * higher the priority boost gets as well.
-		 */
-		sleep_avg = p->sleep_avg + sleep_time;
-
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
+		p->sleeptime += sleep_time;
+		sleeptime_runtime_update(p);
+		p->prio = effective_prio(p);
 	}
 	__activate_task(p, rq);
 }
@@ -384,6 +360,7 @@
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
 	nr_running_dec(rq);
+	p->go_to_sleep = jiffies;
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -539,7 +516,7 @@
  * This function will do some initial scheduler statistics housekeeping
  * that must be done for every newly created process.
  */
-void wake_up_forked_process(task_t * p)
+void wake_up_forked_process(task_t *p)
 {
 	unsigned long flags;
 	runqueue_t *rq = task_rq_lock(current, &flags);
@@ -550,15 +527,21 @@
 	 * and children as well, to keep max-interactive tasks
 	 * from forking tasks that are max-interactive.
 	 */
-	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
-	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
-	p->prio = effective_prio(p);
+
+	p->prio = current->prio;
+	p->static_prio = current->static_prio;
+	p->sleeptime = current->sleeptime / SLEEP_RUN_THROTTLE;
+	p->runtime = current->runtime / SLEEP_RUN_THROTTLE;
+	p->runtime++;
+	p->time_slice = MIN_TIMESLICE;
+	sleeptime_runtime_update(p);
+
 	set_task_cpu(p, smp_processor_id());
 
-	if (unlikely(!current->array))
+	if (unlikely(!current->array)) {
+		p->prio = effective_prio(p);
 		__activate_task(p, rq);
-	else {
-		p->prio = current->prio;
+	} else {
 		list_add_tail(&p->run_list, &current->run_list);
 		p->array = current->array;
 		p->array->nr_active++;
@@ -591,9 +574,14 @@
 	 * If the child was a (relative-) CPU hog then decrease
 	 * the sleep_avg of the parent as well.
 	 */
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = (p->parent->sleep_avg * EXIT_WEIGHT +
-			p->sleep_avg) / (EXIT_WEIGHT + 1);
+	if (p->runtime > p->parent->runtime)
+		p->parent->runtime = (p->parent->runtime * EXIT_WEIGHT +
+			p->runtime) / (EXIT_WEIGHT + 1);
+	if (p->sleeptime > p->parent->sleeptime)
+		p->parent->sleeptime = (p->parent->sleeptime * EXIT_WEIGHT +
+			p->sleeptime) / (EXIT_WEIGHT + 1);
+
+	sleeptime_runtime_update(p->parent);
 }
 
 /**
@@ -1238,8 +1226,9 @@
 	 * it possible for interactive tasks to use up their
 	 * timeslices at their highest priority levels.
 	 */
-	if (p->sleep_avg)
-		p->sleep_avg--;
+	p->runtime++;
+	sleeptime_runtime_update(p);
+
 	if (unlikely(rt_task(p))) {
 		/*
 		 * RR tasks need a special form of timeslice management.
@@ -1259,6 +1248,7 @@
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
+		sleeptime_runtime_update(p);
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
@@ -1559,7 +1549,7 @@
 long interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
-
+	
 	current->state = TASK_INTERRUPTIBLE;
 
 	SLEEP_ON_HEAD
@@ -2153,6 +2143,7 @@
 	if (retval)
 		goto out_unlock;
 
+	sleeptime_runtime_update(p);
 	jiffies_to_timespec(p->policy & SCHED_FIFO ?
 				0 : task_timeslice(p), &t);
 	read_unlock(&tasklist_lock);

--Boundary-00=_TLKX/e/VWJQRKLz--

