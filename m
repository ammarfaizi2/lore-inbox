Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbUFFRDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUFFRDJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUFFRDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:03:09 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:27014 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S263824AbUFFRAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:00:16 -0400
From: Jan Killius <jkillius@arcor.de>
Reply-To: jkillius@arcor.de
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
Date: Sun, 6 Jun 2004 18:59:31 +0200
User-Agent: KMail/1.6.52
References: <200406070139.38433.kernel@kolivas.org>
In-Reply-To: <200406070139.38433.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Y20wAlz5rFjfg/x"
Message-Id: <200406061900.08824.jkillius@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Y20wAlz5rFjfg/x
Content-Type: text/plain;
  charset="iso-8859-1";
  boundary=""
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 06 June 2004 17:39, you wrote:
> This is an update of the scheduler policy mechanism rewrite using the
> infrastructure of the current O(1) scheduler. Slight changes from the
> original design require a detailed description. The change to the original
> design has enabled all known corner cases to be abolished and cpu
> distribution to be much better maintained. It has proven to be stable in my
> testing and is ready for more widespread public testing now.
>
>
> Aims:
>  - Interactive by design rather than have interactivity bolted on.
>  - Good scalability.
>  - Simple predictable design.
>  - Maintain appropriate cpu distribution and fairness.
>  - Low scheduling latency for normal policy tasks.
>  - Low overhead.
>  - Making renicing processes actually matter for CPU distribution (nice 0
> gets 20 times what nice +20 gets)
>  - Resistant to priority inversion
>  - More forgiving of poor locking
>  - Tunable for a server workload or computational tasks
>
>
> Description:
>  - All tasks start at a dynamic priority based on their nice value. They
> run for one RR_INTERVAL (nominally set to 10ms) and then drop one stair
> (priority). If they sleep before running again they get to run for 2
> intervals before being demoted a priority and so on until they get all
> their intervals at their best priority: 20 intervals for nice 0; 1 interval
> for nice +19.
>
>
> - The staircase elevation mechanism can be disabled and all tasks can
> simply descend stairs using the sysctl:
>
> echo 0 > /proc/sys/kernel/interactive
>
> this has the effect of maintaining cpu distribution much more strictly
> according to nice whereas the default mechanism allows bursts of cpu by
> interactive tasks before settling to appropriate cpu distribution.
>
>
> - The time tasks are cpu bound can be increased by using the sysctl:
>
> echo 1 > /proc/sys/kernel/compute
>
> which extends the RR_INTERVAL to 100ms and disables the staircase elevation
> improving conditions for pure computational tasks by optimising cache
> benefits and decreasing context switching (gains another 1.5% on
> kernbench).
>
>
> Performance:
> - All cpu throughput benchmarks show equivalent or better performance than
> mainline. Note that disabling the interactive setting actually _worsens_
> some benchmarks because of their dependence on yield() so I don't recommend
> disabling it unless you do a comparison first.
> - Interactivity is approximately equivalent to mainline 2.6 but with faster
> application startup and no known behavioural quirks.
>
>
> Comments and testing welcome.
>
>  fs/proc/array.c        |    2
>  include/linux/sched.h  |    8
>  include/linux/sysctl.h |    2
>  kernel/sched.c         |  676
> +++++++++++++------------------------------------
>  kernel/sysctl.c        |   16 +
>  5 files changed, 212 insertions(+), 492 deletions(-)
>
> Can be downloaded here:
> http://ck.kolivas.org/patches/2.6/2.6.7-rc2/patch-2.6.7-rc2-s6.3
>
> and below
> Con
The same patch modified to apply clean on 2.6-7-rc2-mm2.
-- 
        Jan

--Boundary-00=_Y20wAlz5rFjfg/x
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-2.6.7-rc2-mm2-s6.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-2.6.7-rc2-mm2-s6.3"

diff -Naurp linux-2.6.7-rc2-mm2/fs/proc/array.c linux-2.6.7-rc2-mm2-s6.3/fs/proc/array.c
--- linux-2.6.7-rc2-mm2/fs/proc/array.c	2004-06-06 18:51:52.000000000 +0200
+++ linux-2.6.7-rc2-mm2-s6.3/fs/proc/array.c	2004-06-06 18:27:58.343412208 +0200
@@ -155,7 +155,6 @@ static inline char * task_state(struct t
 	read_lock(&tasklist_lock);
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
-		"SleepAVG:\t%lu%%\n"
 		"Tgid:\t%d\n"
 		"Pid:\t%d\n"
 		"PPid:\t%d\n"
@@ -163,7 +162,6 @@ static inline char * task_state(struct t
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
-		(p->sleep_avg/1024)*100/(1020000000/1024),
 	       	p->tgid,
 		p->pid, p->pid ? p->real_parent->pid : 0,
 		p->pid && p->ptrace ? p->parent->pid : 0,
diff -Naurp linux-2.6.7-rc2-mm2/include/linux/sched.h linux-2.6.7-rc2-mm2-s6.3/include/linux/sched.h
--- linux-2.6.7-rc2-mm2/include/linux/sched.h	2004-06-06 18:51:52.000000000 +0200
+++ linux-2.6.7-rc2-mm2-s6.3/include/linux/sched.h	2004-06-06 18:27:58.343412208 +0200
@@ -172,6 +172,7 @@ extern void show_stack(struct task_struc
 
 void io_schedule(void);
 long io_schedule_timeout(long timeout);
+extern int interactive, compute;
 
 extern void cpu_init (void);
 extern void trap_init(void);
@@ -410,14 +411,13 @@ struct task_struct {
 	struct list_head run_list;
 	prio_array_t *array;
 
-	unsigned long sleep_avg;
-	long interactive_credit;
 	unsigned long long timestamp;
-	int activated;
+	unsigned long runtime, totalrun;
+	unsigned int deadline;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
-	unsigned int time_slice, first_time_slice;
+	unsigned int slice, time_slice, first_time_slice;
 
 	struct list_head tasks;
 	struct list_head ptrace_children;
diff -Naurp linux-2.6.7-rc2-mm2/include/linux/sysctl.h linux-2.6.7-rc2-mm2-s6.3/include/linux/sysctl.h
--- linux-2.6.7-rc2-mm2/include/linux/sysctl.h	2004-06-06 18:51:52.000000000 +0200
+++ linux-2.6.7-rc2-mm2-s6.3/include/linux/sysctl.h	2004-06-06 18:27:58.345411904 +0200
@@ -133,6 +133,8 @@ enum
 	KERN_NGROUPS_MAX=63,	/* int: NGROUPS_MAX */
 	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
+	KERN_INTERACTIVE=66,	/* interactive tasks to have cpu bursts */
+	KERN_COMPUTE=67,	/* adjust timeslices for a compute server */
 };
 
 
diff -Naurp linux-2.6.7-rc2-mm2/kernel/sched.c linux-2.6.7-rc2-mm2-s6.3/kernel/sched.c
--- linux-2.6.7-rc2-mm2/kernel/sched.c	2004-06-06 18:51:52.000000000 +0200
+++ linux-2.6.7-rc2-mm2-s6.3/kernel/sched.c	2004-06-06 18:33:49.541022056 +0200
@@ -16,7 +16,10 @@
  *		by Davide Libenzi, preemptible kernel bits by Robert Love.
  *  2003-09-03	Interactivity tuning by Con Kolivas.
  *  2004-04-02	Scheduler domains code by Nick Piggin
- */
+ *  2004-03-19.	New staircase scheduling policy by Con Kolivas with help
+ *		from Zwane Mwaikambo and useful suggestions by 
+ *		William Lee Irwin III. 
+*/
 
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -70,8 +73,6 @@
 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
-#define AVG_TIMESLICE	(MIN_TIMESLICE + ((MAX_TIMESLICE - MIN_TIMESLICE) *\
-			(MAX_PRIO-1-NICE_TO_PRIO(0))/(MAX_USER_PRIO - 1)))
 
 /*
  * Some helpers for converting nanosecond timing to jiffy resolution
@@ -79,110 +80,18 @@
 #define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
 #define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
 
-/*
- * These are the 'tuning knobs' of the scheduler:
- *
- * Minimum timeslice is 10 msecs, default timeslice is 100 msecs,
- * maximum timeslice is 200 msecs. Timeslices get refilled after
- * they expire.
- */
-#define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(200 * HZ / 1000)
-#define ON_RUNQUEUE_WEIGHT	 30
-#define CHILD_PENALTY		 95
-#define PARENT_PENALTY		100
-#define EXIT_WEIGHT		  3
-#define PRIO_BONUS_RATIO	 25
-#define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
-#define INTERACTIVE_DELTA	  2
-#define MAX_SLEEP_AVG		(AVG_TIMESLICE * MAX_BONUS)
-#define STARVATION_LIMIT	(MAX_SLEEP_AVG)
-#define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
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
-	(SCALE(TASK_NICE(p), 40, MAX_BONUS) + INTERACTIVE_DELTA)
-
-#define TASK_INTERACTIVE(p) \
-	((p)->prio <= (p)->static_prio - DELTA(p))
-
-#define INTERACTIVE_SLEEP(p) \
-	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
-		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
-
-#define HIGH_CREDIT(p) \
-	((p)->interactive_credit > CREDIT_LIMIT)
-
-#define LOW_CREDIT(p) \
-	((p)->interactive_credit < -CREDIT_LIMIT)
+int compute = 0;
+/* 
+ *This is the time all tasks within the same priority round robin.
+ *compute setting is reserved for dedicated computational scheduling
+ *and has ten times larger intervals.
+ */
+#define _RR_INTERVAL		((10 * HZ / 1000) ? : 1)
+#define RR_INTERVAL		(_RR_INTERVAL * (1 + 9 * compute))
 
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
 
-/*
- * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
- * to time slice values.
- *
- * The higher a thread's priority, the bigger timeslices
- * it gets during one round of execution. But even the lowest
- * priority thread gets MIN_TIMESLICE worth of execution time.
- *
- * task_timeslice() is the interface that is used by the scheduler.
- */
-
-#define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
-		((MAX_TIMESLICE - MIN_TIMESLICE) * \
-			(MAX_PRIO-1 - (p)->static_prio) / (MAX_USER_PRIO-1)))
-
-static unsigned int task_timeslice(task_t *p)
-{
-	return BASE_TIMESLICE(p);
-}
-
 #define task_hot(p, now, sd) ((now) - (p)->timestamp < (sd)->cache_hot_time)
 
 /*
@@ -196,7 +105,7 @@ typedef struct runqueue runqueue_t;
 struct prio_array {
 	unsigned int nr_active;
 	unsigned long bitmap[BITMAP_SIZE];
-	struct list_head queue[MAX_PRIO];
+	struct list_head queue[MAX_PRIO + 1];
 };
 
 /*
@@ -218,13 +127,12 @@ struct runqueue {
 	unsigned long cpu_load;
 #endif
 	unsigned long long nr_switches;
-	unsigned long expired_timestamp, nr_uninterruptible;
+	unsigned long nr_uninterruptible;
 	unsigned long long timestamp_last_tick;
 	task_t *curr, *idle;
 
 	struct mm_struct *prev_mm;
-	prio_array_t *active, *expired, arrays[2];
-	int best_expired_prio;
+	prio_array_t array;
 	atomic_t nr_iowait;
 
 #ifdef CONFIG_SMP
@@ -406,16 +314,18 @@ static inline void rq_unlock(runqueue_t 
 /*
  * Adding/removing a task to/from a priority array:
  */
-static void dequeue_task(struct task_struct *p, prio_array_t *array)
+static void dequeue_task(struct task_struct *p, runqueue_t *rq)
 {
+	prio_array_t* array = &rq->array;
 	array->nr_active--;
 	list_del(&p->run_list);
 	if (list_empty(array->queue + p->prio))
 		__clear_bit(p->prio, array->bitmap);
 }
 
-static void enqueue_task(struct task_struct *p, prio_array_t *array)
+static void enqueue_task(struct task_struct *p, runqueue_t *rq)
 {
+	prio_array_t* array = &rq->array;
 	list_add_tail(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
 	array->nr_active++;
@@ -427,8 +337,9 @@ static void enqueue_task(struct task_str
  * remote queue so we want these tasks to show up at the head of the
  * local queue:
  */
-static inline void enqueue_task_head(struct task_struct *p, prio_array_t *array)
+static inline void enqueue_task_head(struct task_struct *p, runqueue_t *rq)
 {
+	prio_array_t* array = &rq->array;
 	list_add(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
 	array->nr_active++;
@@ -436,42 +347,11 @@ static inline void enqueue_task_head(str
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
- */
-static int effective_prio(task_t *p)
-{
-	int bonus, prio;
-
-	if (rt_task(p))
-		return p->prio;
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
  * __activate_task - move a task to the runqueue.
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task(p, rq->active);
+	enqueue_task(p, rq);
 	rq->nr_running++;
 }
 
@@ -480,95 +360,112 @@ static inline void __activate_task(task_
  */
 static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task_head(p, rq->active);
+	enqueue_task_head(p, rq);
 	rq->nr_running++;
 }
 
-static void recalc_task_prio(task_t *p, unsigned long long now)
+// deadline - the best deadline rank a task can have.
+static unsigned int deadline(task_t *p)
 {
-	unsigned long long __sleep_time = now - p->timestamp;
-	unsigned long sleep_time;
-
-	if (__sleep_time > NS_MAX_SLEEP_AVG)
-		sleep_time = NS_MAX_SLEEP_AVG;
+	unsigned int task_user_prio;
+	if (rt_task(p))
+		return p->deadline;
+	task_user_prio = TASK_USER_PRIO(p);
+	if (likely(task_user_prio < 40))
+		return 39 - task_user_prio;
 	else
-		sleep_time = (unsigned long)__sleep_time;
+		return 0;
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
-						AVG_TIMESLICE);
-				if (!HIGH_CREDIT(p))
-					p->interactive_credit++;
-		} else {
-			/*
-			 * The lower the sleep avg a task has the more
-			 * rapidly it will rise with sleep time.
-			 */
-			sleep_time *= (MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
+static void inc_deadline(task_t *p)
+{
+	unsigned int best_deadline;
+	best_deadline = deadline(p);
+	if (!p->mm || rt_task(p) || !best_deadline)
+		return;
+	if (p->deadline < best_deadline)
+		p->deadline++;
+}
 
-			/*
-			 * Tasks with low interactive_credit are limited to
-			 * one timeslice worth of sleep avg bonus.
-			 */
-			if (LOW_CREDIT(p) &&
-			    sleep_time > JIFFIES_TO_NS(task_timeslice(p)))
-				sleep_time = JIFFIES_TO_NS(task_timeslice(p));
+static void dec_deadline(task_t *p)
+{
+	if (!p->mm || rt_task(p))
+		return;
+	if (p->deadline)
+		p->deadline--;
+}
 
-			/*
-			 * Non high_credit tasks waking from uninterruptible
-			 * sleep are limited in their sleep_avg rise as they
-			 * are likely to be cpu hogs waiting on I/O
-			 */
-			if (p->activated == -1 && !HIGH_CREDIT(p) && p->mm) {
-				if (p->sleep_avg >= INTERACTIVE_SLEEP(p))
-					sleep_time = 0;
-				else if (p->sleep_avg + sleep_time >=
-						INTERACTIVE_SLEEP(p)) {
-					p->sleep_avg = INTERACTIVE_SLEEP(p);
-					sleep_time = 0;
-				}
-			}
+// slice - the duration a task runs before losing a deadline rank.
+static unsigned int slice(task_t *p)
+{
+	unsigned int slice = RR_INTERVAL;
+	if (!rt_task(p))
+		slice += deadline(p) * RR_INTERVAL;
+	return slice;
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
+// interactive - interactive tasks get longer intervals at best priority
+int interactive = 1;
 
-			if (p->sleep_avg > NS_MAX_SLEEP_AVG) {
-				p->sleep_avg = NS_MAX_SLEEP_AVG;
-				if (!HIGH_CREDIT(p))
-					p->interactive_credit++;
-			}
+/*
+ * effective_prio - dynamic priority dependent on deadline rank.
+ * With 0 deadline ranks the priority decreases by one each RR_INTERVAL.
+ * As the deadline rank increases the priority stays at the top "stair" or
+ * value for longer.
+ */
+static int effective_prio(task_t *p)
+{
+	int prio;
+	unsigned int full_slice, used_slice, first_slice;
+	unsigned int best_deadline;
+	if (rt_task(p))
+		return p->prio;
+
+	best_deadline = deadline(p);
+	full_slice = slice(p);
+	used_slice = full_slice - p->slice;
+	if (p->deadline > best_deadline || !p->mm)
+		p->deadline = best_deadline;
+	first_slice = RR_INTERVAL;
+	if (interactive && !compute)
+		first_slice *= (p->deadline + 1);
+	prio = MAX_PRIO - 1 - best_deadline;
+
+	if (used_slice < first_slice)
+		return prio;
+	if (p->mm)
+		prio += 1 + (used_slice - first_slice) / RR_INTERVAL;
+	if (prio > MAX_PRIO - 1)
+		prio = MAX_PRIO - 1;
+	return prio;
+}
+
+static void recalc_task_prio(task_t *p, unsigned long long now)
+{
+	unsigned long sleep_time = now - p->timestamp;
+	unsigned long run_time = NS_TO_JIFFIES(p->runtime);
+	unsigned long total_run = NS_TO_JIFFIES(p->totalrun) + run_time;
+	if (!run_time && NS_TO_JIFFIES(p->runtime + sleep_time) < RR_INTERVAL) {
+		if (p->slice - total_run < 1) {
+			p->totalrun = 0;
+			dec_deadline(p);
+		} else {
+			p->totalrun += p->runtime;
+			p->slice -= NS_TO_JIFFIES(p->totalrun);
 		}
+	} else {
+		inc_deadline(p);
+		p->runtime = 0;
+		p->totalrun = 0;
 	}
-
-	p->prio = effective_prio(p);
 }
 
 /*
  * activate_task - move a task to the runqueue and do priority recalculation
- *
- * Update all the scheduling statistics stuff. (sleep average
- * calculation, priority modifiers, etc.)
  */
 static void activate_task(task_t *p, runqueue_t *rq, int local)
 {
-	unsigned long long now;
-
-	now = sched_clock();
+	unsigned long long now = sched_clock();
 #ifdef CONFIG_SMP
 	if (!local) {
 		/* Compensate for drifting sched_clock */
@@ -577,33 +474,14 @@ static void activate_task(task_t *p, run
 			+ rq->timestamp_last_tick;
 	}
 #endif
-
-	recalc_task_prio(p, now);
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
-	}
+	p->slice = slice(p);
+	if (!rt_task(p) && p->mm)
+		recalc_task_prio(p, now);
+	else
+		inc_deadline(p);
+	p->prio = effective_prio(p);
+	p->time_slice = RR_INTERVAL;
 	p->timestamp = now;
-
 	__activate_task(p, rq);
 }
 
@@ -613,9 +491,12 @@ static void activate_task(task_t *p, run
 static void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
 	rq->nr_running--;
-	if (p->state == TASK_UNINTERRUPTIBLE)
+	if (p->state == TASK_UNINTERRUPTIBLE) {
 		rq->nr_uninterruptible++;
-	dequeue_task(p, p->array);
+		if (p->deadline > (deadline(p) - 2) && p->deadline && p->mm)
+			p->deadline--;
+	}
+	dequeue_task(p, rq);
 	p->array = NULL;
 }
 
@@ -946,14 +827,8 @@ out_set_cpu:
 
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
 	 * Sync wakeups (i.e. those types of wakeups where the waker
@@ -1023,12 +898,14 @@ void fastcall sched_fork(task_t *p)
 	 */
 	local_irq_disable();
 	p->time_slice = (current->time_slice + 1) >> 1;
+	p->slice = (current->slice + 1) >> 1;
 	/*
 	 * The remainder of the first timeslice might be recovered by
 	 * the parent if the child exits early enough.
 	 */
 	p->first_time_slice = 1;
 	current->time_slice >>= 1;
+	current->slice >>= 1;
 	p->timestamp = sched_clock();
 	if (!current->time_slice) {
 		/*
@@ -1056,33 +933,14 @@ void fastcall wake_up_forked_process(tas
 	unsigned long flags;
 	runqueue_t *rq = task_rq_lock(current, &flags);
 
+	// Forked process gets a lower deadline rank to prevent fork bombs.
+	p->deadline = 0;
 	BUG_ON(p->state != TASK_RUNNING);
 
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
-		rq->nr_running++;
-	}
+	p->prio = effective_prio(p);
+	__activate_task(p, rq);
 	task_rq_unlock(rq, &flags);
 }
 
@@ -1103,19 +961,11 @@ void fastcall sched_exit(task_t * p)
 	local_irq_save(flags);
 	if (p->first_time_slice) {
 		p->parent->time_slice += p->time_slice;
-		if (unlikely(p->parent->time_slice > MAX_TIMESLICE))
-			p->parent->time_slice = MAX_TIMESLICE;
+		if (unlikely(p->parent->time_slice > slice(p->parent)))
+			p->parent->time_slice = slice(p->parent);
 	}
 	local_irq_restore(flags);
-	/*
-	 * If the child was a (relative-) CPU hog then decrease
-	 * the sleep_avg of the parent as well.
-	 */
 	rq = task_rq_lock(p->parent, &flags);
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = p->parent->sleep_avg /
-		(EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg /
-		(EXIT_WEIGHT + 1);
 	task_rq_unlock(rq, &flags);
 }
 
@@ -1379,18 +1229,6 @@ lock_again:
 		double_rq_unlock(this_rq, rq);
 		goto lock_again;
 	}
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
 	set_task_cpu(p, cpu);
@@ -1505,15 +1343,15 @@ static void double_lock_balance(runqueue
  * pull_task - move a task from a remote runqueue to the local runqueue.
  * Both runqueues must be locked.
  */
-static inline
-void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p,
-	       runqueue_t *this_rq, prio_array_t *this_array, int this_cpu)
+static inline 
+void pull_task(runqueue_t *src_rq, task_t *p, 
+		runqueue_t *this_rq, int this_cpu)
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
@@ -1570,29 +1408,16 @@ static int move_tasks(runqueue_t *this_r
 		      unsigned long max_nr_move, struct sched_domain *sd,
 		      enum idle_type idle)
 {
-	prio_array_t *array, *dst_array;
+	prio_array_t* array, *dst_array;
 	struct list_head *head, *curr;
 	int idx, pulled = 0;
 	task_t *tmp;
 
 	if (max_nr_move <= 0 || busiest->nr_running <= 1)
 		goto out;
+	array = &busiest->array;
+	dst_array = &this_rq->array;
 
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
@@ -1600,14 +1425,8 @@ skip_bitmap:
 		idx = sched_find_first_bit(array->bitmap);
 	else
 		idx = find_next_bit(array->bitmap, MAX_PRIO, idx);
-	if (idx >= MAX_PRIO) {
-		if (array == busiest->expired && busiest->active->nr_active) {
-			array = busiest->active;
-			dst_array = this_rq->active;
-			goto new_array;
-		}
+	if (idx >= MAX_PRIO) 
 		goto out;
-	}
 
 	head = array->queue + idx;
 	curr = head->prev;
@@ -1622,7 +1441,7 @@ skip_queue:
 		idx++;
 		goto skip_bitmap;
 	}
-	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
+	pull_task(busiest, tmp, this_rq, this_cpu);
 	pulled++;
 
 	/* We only want to steal up to the prescribed number of tasks. */
@@ -2114,22 +1933,6 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
 EXPORT_PER_CPU_SYMBOL(kstat);
 
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
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  *
@@ -2174,76 +1977,38 @@ void scheduler_tick(int user_ticks, int 
 	cpustat->system += sys_ticks;
 
 	/* Task might have expired already, but not scheduled off yet */
-	if (p->array != rq->active) {
+	if (p->array != &rq->array) {
 		set_tsk_need_resched(p);
 		goto out;
 	}
 	spin_lock(&rq->lock);
-	/*
-	 * The task was running during this tick - update the
-	 * time slice counter. Note: we do not update a thread's
-	 * priority until it either goes to sleep or uses up its
-	 * timeslice. This makes it possible for interactive tasks
-	 * to use up their timeslices at their highest priority levels.
-	 */
-	if (unlikely(rt_task(p))) {
-		/*
-		 * RR tasks need a special form of timeslice management.
-		 * FIFO tasks have no timeslices.
-		 */
-		if ((p->policy == SCHED_RR) && !--p->time_slice) {
-			p->time_slice = task_timeslice(p);
-			p->first_time_slice = 0;
-			set_tsk_need_resched(p);
-
-			/* put it at the end of the queue: */
-			dequeue_task(p, rq->active);
-			enqueue_task(p, rq->active);
-		}
+	
+	// SCHED_FIFO tasks never run out of timeslice.
+	if (unlikely(p->policy == SCHED_FIFO))
+		goto out_unlock;
+	// Tasks lose a deadline rank each time they use up a full slice().
+	if (!--p->slice) {
+		set_tsk_need_resched(p);
+		dequeue_task(p, rq);
+		dec_deadline(p);
+		p->slice = slice(p);
+		p->prio = effective_prio(p);
+		p->time_slice = RR_INTERVAL;
+		enqueue_task(p, rq);
+		p->first_time_slice = 0;
 		goto out_unlock;
 	}
+	/*
+	 * Tasks that run out of time_slice but still have slice left get
+	 * requeued with a lower priority && RR_INTERVAL time_slice.
+	 */
 	if (!--p->time_slice) {
-		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
+		dequeue_task(p, rq);
 		p->prio = effective_prio(p);
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
-			dequeue_task(p, rq->active);
-			set_tsk_need_resched(p);
-			p->prio = effective_prio(p);
-			enqueue_task(p, rq->active);
-		}
+		p->time_slice = RR_INTERVAL;
+		enqueue_task(p, rq);
+		goto out_unlock;
 	}
 out_unlock:
 	spin_unlock(&rq->lock);
@@ -2307,8 +2072,8 @@ static inline int dependent_sleeper(int 
 		 * task from using an unfair proportion of the
 		 * physical cpu's resources. -ck
 		 */
-		if (((smt_curr->time_slice * (100 - sd->per_cpu_gain) / 100) >
-			task_timeslice(p) || rt_task(smt_curr)) &&
+		if (((smt_curr->slice * (100 - sd->per_cpu_gain) / 100) >
+			slice(p) || rt_task(smt_curr)) &&
 			p->mm && smt_curr->mm && !rt_task(p))
 				ret = 1;
 
@@ -2317,8 +2082,8 @@ static inline int dependent_sleeper(int 
 		 * or wake it up if it has been put to sleep for priority
 		 * reasons.
 		 */
-		if ((((p->time_slice * (100 - sd->per_cpu_gain) / 100) >
-			task_timeslice(smt_curr) || rt_task(p)) &&
+		if ((((p->slice * (100 - sd->per_cpu_gain) / 100) > 
+			slice(smt_curr) || rt_task(p)) && 
 			smt_curr->mm && p->mm && !rt_task(smt_curr)) ||
 			(smt_curr == smt_rq->idle && smt_rq->nr_running))
 				resched_task(smt_curr);
@@ -2344,10 +2109,9 @@ asmlinkage void __sched schedule(void)
 	long *switch_count;
 	task_t *prev, *next;
 	runqueue_t *rq;
-	prio_array_t *array;
+	prio_array_t* array;
 	struct list_head *queue;
 	unsigned long long now;
-	unsigned long run_time;
 	int cpu, idx;
 
 	/*
@@ -2370,19 +2134,8 @@ need_resched:
 	release_kernel_lock(prev);
  	schedstat_inc(rq, sched_cnt);
 	now = sched_clock();
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
 
+	prev->runtime = now - prev->timestamp;
 	spin_lock_irq(&rq->lock);
 
 	/*
@@ -2404,58 +2157,24 @@ need_resched:
 		idle_balance(cpu, rq);
 		if (!rq->nr_running) {
 			next = rq->idle;
-			rq->expired_timestamp = 0;
 			wake_sleeping_dependent(cpu, rq);
  			schedstat_inc(rq, sched_idle);
 			goto switch_tasks;
 		}
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
+	array = &rq->array;
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
-
-	if (dependent_sleeper(cpu, rq, next)) {
+	if (dependent_sleeper(cpu, rq, next))
 		next = rq->idle;
-		goto switch_tasks;
-	}
-
-	if (!rt_task(next) && next->activated > 0) {
-		unsigned long long delta = now - next->timestamp;
-
-		if (next->activated == 1)
-			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
 
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
-	if ((long)prev->sleep_avg <= 0) {
-		prev->sleep_avg = 0;
-		if (!(HIGH_CREDIT(prev) || LOW_CREDIT(prev)))
-			prev->interactive_credit--;
-	}
 	prev->timestamp = now;
 
 	if (likely(prev != next)) {
@@ -2721,7 +2440,7 @@ EXPORT_SYMBOL(sleep_on_timeout);
 void set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
-	prio_array_t *array;
+	prio_array_t* array;
 	runqueue_t *rq;
 	int old_prio, new_prio, delta;
 
@@ -2744,7 +2463,7 @@ void set_user_nice(task_t *p, long nice)
 	}
 	array = p->array;
 	if (array)
-		dequeue_task(p, array);
+		dequeue_task(p, rq);
 
 	old_prio = p->prio;
 	new_prio = NICE_TO_PRIO(nice);
@@ -2753,7 +2472,7 @@ void set_user_nice(task_t *p, long nice)
 	p->prio += delta;
 
 	if (array) {
-		enqueue_task(p, array);
+		enqueue_task(p, rq);
 		/*
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
@@ -2882,7 +2601,7 @@ static int setscheduler(pid_t pid, int p
 	struct sched_param lp;
 	int retval = -EINVAL;
 	int oldprio;
-	prio_array_t *array;
+	prio_array_t* array;
 	unsigned long flags;
 	runqueue_t *rq;
 	task_t *p;
@@ -3151,29 +2870,17 @@ out_unlock:
 /**
  * sys_sched_yield - yield the current processor to other threads.
  *
- * this function yields the current CPU by moving the calling thread
- * to the expired array. If there are no other threads running on this
  * CPU then this function will return.
  */
 asmlinkage long sys_sched_yield(void)
 {
 	runqueue_t *rq = this_rq_lock();
-	prio_array_t *array = current->array;
-	prio_array_t *target = rq->expired;
 
-	schedstat_inc(rq, yld_cnt);
-	/*
-	 * We implement yielding by moving the task into the expired
-	 * queue.
-	 *
-	 * (special rule: RT tasks will just roundrobin in the active
-	 *  array.)
-	 */
-	if (unlikely(rt_task(current)))
-		target = rq->active;
-
-	dequeue_task(current, array);
-	enqueue_task(current, target);
+	dequeue_task(current, rq);
+	current->slice = slice(current);
+	current->time_slice = current->slice;
+	current->prio = effective_prio(current);
+	enqueue_task(current, rq);
 
 	/*
 	 * Since we are going to call schedule() anyway, there's
@@ -3312,7 +3019,7 @@ long sys_sched_rr_get_interval(pid_t pid
 		goto out_unlock;
 
 	jiffies_to_timespec(p->policy & SCHED_FIFO ?
-				0 : task_timeslice(p), &t);
+				0 : slice(p), &t);
 	read_unlock(&tasklist_lock);
 	retval = copy_to_user(interval, &t, sizeof(t)) ? -EFAULT : 0;
 out_nounlock:
@@ -3433,6 +3140,7 @@ void __devinit init_idle(task_t *idle, i
 	idle->array = NULL;
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
+	idle->deadline = 0;
 	set_task_cpu(idle, cpu);
 	double_rq_unlock(idle_rq, rq);
 	set_tsk_need_resched(idle);
@@ -4068,7 +3776,7 @@ int in_sched_functions(unsigned long add
 void __init sched_init(void)
 {
 	runqueue_t *rq;
-	int i, j, k;
+	int i, j;
 
 #ifdef CONFIG_SMP
 	/* Set up an initial dummy domain for early boot */
@@ -4089,13 +3797,10 @@ void __init sched_init(void)
 #endif
 
 	for (i = 0; i < NR_CPUS; i++) {
-		prio_array_t *array;
+		prio_array_t* array;
 
 		rq = cpu_rq(i);
 		spin_lock_init(&rq->lock);
-		rq->active = rq->arrays;
-		rq->expired = rq->arrays + 1;
-		rq->best_expired_prio = MAX_PRIO;
 
 #ifdef CONFIG_SMP
 		rq->sd = &sched_domain_init;
@@ -4106,16 +3811,14 @@ void __init sched_init(void)
 		INIT_LIST_HEAD(&rq->migration_queue);
 #endif
 		atomic_set(&rq->nr_iowait, 0);
+		array = &rq->array;
 
-		for (j = 0; j < 2; j++) {
-			array = rq->arrays + j;
-			for (k = 0; k < MAX_PRIO; k++) {
-				INIT_LIST_HEAD(array->queue + k);
-				__clear_bit(k, array->bitmap);
-			}
-			// delimiter for bitsearch
-			__set_bit(MAX_PRIO, array->bitmap);
+		for (j = 0; j <= MAX_PRIO; j++) {
+			INIT_LIST_HEAD(array->queue + j);
+			__clear_bit(j, array->bitmap);
 		}
+		// delimiter for bitsearch
+		__set_bit(MAX_PRIO, array->bitmap);
 	}
 	/*
 	 * We have to do a little magic to get the first
diff -Naurp linux-2.6.7-rc2-mm2/kernel/sysctl.c linux-2.6.7-rc2-mm2-s6.3/kernel/sysctl.c
--- linux-2.6.7-rc2-mm2/kernel/sysctl.c	2004-06-06 18:51:52.000000000 +0200
+++ linux-2.6.7-rc2-mm2-s6.3/kernel/sysctl.c	2004-06-06 18:27:58.359409776 +0200
@@ -618,6 +618,22 @@ static ctl_table kern_table[] = {
 		.mode		= 0444,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= KERN_INTERACTIVE,
+		.procname	= "interactive",
+		.data		= &interactive,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_COMPUTE,
+		.procname	= "compute",
+		.data		= &compute,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 

--Boundary-00=_Y20wAlz5rFjfg/x--
