Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266339AbUFYOkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266339AbUFYOkN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 10:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUFYOkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 10:40:13 -0400
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:2743 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266747AbUFYOih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 10:38:37 -0400
Message-ID: <40DC38D0.9070905@kolivas.org>
Date: Sat, 26 Jun 2004 00:38:08 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Pauli Virtanen <pauli.virtanen@hut.fi>
Subject: [PATCH] Staircase scheduler v7.4
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7587CBED03E36A8A59A66B24"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7587CBED03E36A8A59A66B24
Content-Type: multipart/mixed;
 boundary="------------040904020404060004020307"

This is a multi-part message in MIME format.
--------------040904020404060004020307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is a scheduler policy rewrite designed to be interactive by design 
without tweaks or tuning and be lean and extensible for all sorts of 
settings. (see previous announcements for more detail).

Patches (including incrementals from previous versions) against 2.6.7 
and 2.6.7-mm2 can be downloaded from:
http://ck.kolivas.org/patches/2.6/

At this point all known bugs that have come up from testers have been 
addressed. For testers of this patch please note that renicing tasks to 
-ve values will not improve the behaviour of games and the like (usually 
it worsens it). Users will be rewarded by judicious use of +nice values 
as nice has profound effects with this scheduler.

Note, for multiuser machines and servers I recommend disabling 
interactive mode:
echo 0 > /proc/sys/kernel/interactive


Changes since v7.3

A very difficult to track (and reproduce) bug was finally sorted out 
where a task that forked repeated cpu bound tasks for just the right 
duration before they stopped would be able to DoS other tasks. Basically 
since every time the parent would go to sleep it would wake up back at 
it's best priority it meant the children would run only for as long as 
needed to stay at that same priority thus hogging all cpu resources. 
This was addressed using the existing infrastructure already in place in 
staircase. It deals with ultra short running tasks by making each next 
wakeup actually continue as though they are still running their first 
timeslice. Thus their priority drops over time in spite of repeated 
wakeups. Great thanks to Pauli Virtanen for his testing and help in 
nailing this.

The other change involves a design issue with the behaviour of the O(1) 
scheduler. If task a is preempted by a higher priority task b, task a 
gets requeued to run after all tasks of the same priority as itself. 
Preempted tasks are now flagged as having that happen and will go ahead 
of other tasks getting to continue where it left off. This tends to 
smooth out the jitter of things like X and audio somewhat, and because 
they may run again if task b runs only briefly it helps preserve cache. 
Thus on preliminary benchmarks I've found a slight improvement in 
throughput under heavy load.

Attached is the patch against 2.6.7.

Regards,
Con

--------------040904020404060004020307
Content-Type: text/x-troff-man;
 name="from_2.6.7_to_staircase7.4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="from_2.6.7_to_staircase7.4"

Index: linux-2.6.7-staircase/fs/proc/array.c
===================================================================
--- linux-2.6.7-staircase.orig/fs/proc/array.c	2004-06-25 02:24:28.106117207 +1000
+++ linux-2.6.7-staircase/fs/proc/array.c	2004-06-25 02:24:33.881209658 +1000
@@ -155,7 +155,7 @@
 	read_lock(&tasklist_lock);
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
-		"SleepAVG:\t%lu%%\n"
+		"Burst:\t%d\n"
 		"Tgid:\t%d\n"
 		"Pid:\t%d\n"
 		"PPid:\t%d\n"
@@ -163,7 +163,7 @@
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
-		(p->sleep_avg/1024)*100/(1020000000/1024),
+		p->burst,
 	       	p->tgid,
 		p->pid, p->pid ? p->real_parent->pid : 0,
 		p->pid && p->ptrace ? p->parent->pid : 0,
Index: linux-2.6.7-staircase/include/linux/sched.h
===================================================================
--- linux-2.6.7-staircase.orig/include/linux/sched.h	2004-06-25 02:24:28.113116107 +1000
+++ linux-2.6.7-staircase/include/linux/sched.h	2004-06-25 02:24:34.720077833 +1000
@@ -164,6 +164,7 @@
 
 void io_schedule(void);
 long io_schedule_timeout(long timeout);
+extern int interactive, compute;
 
 extern void cpu_init (void);
 extern void trap_init(void);
@@ -325,7 +326,6 @@
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
 
-typedef struct prio_array prio_array_t;
 struct backing_dev_info;
 struct reclaim_state;
 
@@ -392,16 +392,13 @@
 
 	int prio, static_prio;
 	struct list_head run_list;
-	prio_array_t *array;
-
-	unsigned long sleep_avg;
-	long interactive_credit;
 	unsigned long long timestamp;
-	int activated;
+	unsigned long runtime, totalrun;
+	unsigned int burst;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
-	unsigned int time_slice, first_time_slice;
+	unsigned int slice, time_slice;
 
 	struct list_head tasks;
 	struct list_head ptrace_children;
@@ -549,6 +546,8 @@
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
+#define PF_FORKED	0x00400000	/* I have just forked */
+#define PF_PREEMPTED	0x00800000	/* I have just been preempted */
 
 #ifdef CONFIG_SMP
 #define SCHED_LOAD_SCALE	128UL	/* increase resolution of load */
@@ -742,7 +741,6 @@
  }
 #endif
 extern void FASTCALL(sched_fork(task_t * p));
-extern void FASTCALL(sched_exit(task_t * p));
 
 extern int in_group_p(gid_t);
 extern int in_egroup_p(gid_t);
Index: linux-2.6.7-staircase/include/linux/sysctl.h
===================================================================
--- linux-2.6.7-staircase.orig/include/linux/sysctl.h	2004-06-25 02:24:28.113116107 +1000
+++ linux-2.6.7-staircase/include/linux/sysctl.h	2004-06-25 02:24:33.884209187 +1000
@@ -133,6 +133,8 @@
 	KERN_NGROUPS_MAX=63,	/* int: NGROUPS_MAX */
 	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
+	KERN_INTERACTIVE=66,	/* interactive tasks can have cpu bursts */
+	KERN_COMPUTE=67,	/* adjust timeslices for a compute server */
 };
 
 
Index: linux-2.6.7-staircase/init/main.c
===================================================================
--- linux-2.6.7-staircase.orig/init/main.c	2004-06-25 02:24:28.108116892 +1000
+++ linux-2.6.7-staircase/init/main.c	2004-06-25 02:24:33.885209030 +1000
@@ -314,8 +314,15 @@
 #define smp_init()	do { } while (0)
 #endif
 
+unsigned long cache_decay_ticks;
 static inline void setup_per_cpu_areas(void) { }
-static inline void smp_prepare_cpus(unsigned int maxcpus) { }
+static void smp_prepare_cpus(unsigned int maxcpus)
+{
+	// Generic 2 tick cache_decay for uniprocessor
+	cache_decay_ticks = 2;
+	printk("Generic cache decay timeout: %ld msecs.\n",
+		(cache_decay_ticks * 1000 / HZ));
+}
 
 #else
 
Index: linux-2.6.7-staircase/kernel/exit.c
===================================================================
--- linux-2.6.7-staircase.orig/kernel/exit.c	2004-06-25 02:24:28.111116421 +1000
+++ linux-2.6.7-staircase/kernel/exit.c	2004-06-25 02:24:33.887208715 +1000
@@ -96,7 +96,6 @@
 	p->parent->cmaj_flt += p->maj_flt + p->cmaj_flt;
 	p->parent->cnvcsw += p->nvcsw + p->cnvcsw;
 	p->parent->cnivcsw += p->nivcsw + p->cnivcsw;
-	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
 	proc_pid_flush(proc_dentry);
Index: linux-2.6.7-staircase/kernel/sched.c
===================================================================
--- linux-2.6.7-staircase.orig/kernel/sched.c	2004-06-25 02:24:28.110116578 +1000
+++ linux-2.6.7-staircase/kernel/sched.c	2004-06-25 02:24:34.722077519 +1000
@@ -16,6 +16,8 @@
  *		by Davide Libenzi, preemptible kernel bits by Robert Love.
  *  2003-09-03	Interactivity tuning by Con Kolivas.
  *  2004-04-02	Scheduler domains code by Nick Piggin
+ *  2004-06-11	New staircase scheduling policy by Con Kolivas with help
+ *		from William Lee Irwin III, Zwane Mwaikambo & Peter Williams.
  */
 
 #include <linux/mm.h>
@@ -43,12 +45,6 @@
 
 #include <asm/unistd.h>
 
-#ifdef CONFIG_NUMA
-#define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
-#else
-#define cpu_to_node_mask(cpu) (cpu_online_map)
-#endif
-
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
@@ -66,118 +62,20 @@
 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
-#define AVG_TIMESLICE	(MIN_TIMESLICE + ((MAX_TIMESLICE - MIN_TIMESLICE) *\
-			(MAX_PRIO-1-NICE_TO_PRIO(0))/(MAX_USER_PRIO - 1)))
 
 /*
  * Some helpers for converting nanosecond timing to jiffy resolution
  */
 #define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
-#define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
-
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
-
-#define TASK_PREEMPTS_CURR(p, rq) \
-	((p)->prio < (rq)->curr->prio)
-
-/*
- * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
- * to time slice values.
- *
- * The higher a thread's priority, the bigger timeslices
- * it gets during one round of execution. But even the lowest
- * priority thread gets MIN_TIMESLICE worth of execution time.
- *
- * task_timeslice() is the interface that is used by the scheduler.
+int compute = 0;
+/* 
+ *This is the time all tasks within the same priority round robin.
+ *compute setting is reserved for dedicated computational scheduling
+ *and has ten times larger intervals.
  */
-
-#define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
-		((MAX_TIMESLICE - MIN_TIMESLICE) * \
-			(MAX_PRIO-1 - (p)->static_prio) / (MAX_USER_PRIO-1)))
-
-static unsigned int task_timeslice(task_t *p)
-{
-	return BASE_TIMESLICE(p);
-}
+#define _RR_INTERVAL		((10 * HZ / 1000) ? : 1)
+#define RR_INTERVAL		(_RR_INTERVAL * (1 + 9 * compute))
 
 #define task_hot(p, now, sd) ((now) - (p)->timestamp < (sd)->cache_hot_time)
 
@@ -185,16 +83,8 @@
  * These are the runqueue data structures:
  */
 
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
@@ -214,12 +104,13 @@
 	unsigned long cpu_load;
 #endif
 	unsigned long long nr_switches;
-	unsigned long expired_timestamp, nr_uninterruptible;
+	unsigned long nr_uninterruptible;
 	unsigned long long timestamp_last_tick;
+	unsigned int cache_ticks, preempted;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
-	prio_array_t *active, *expired, arrays[2];
-	int best_expired_prio;
+	unsigned long bitmap[BITS_TO_LONGS(MAX_PRIO+1)];
+	struct list_head queue[MAX_PRIO + 1];
 	atomic_t nr_iowait;
 
 #ifdef CONFIG_SMP
@@ -297,67 +188,53 @@
 	spin_unlock_irq(&rq->lock);
 }
 
-/*
- * Adding/removing a task to/from a priority array:
- */
-static void dequeue_task(struct task_struct *p, prio_array_t *array)
+static int task_preempts_curr(struct task_struct *p, runqueue_t *rq)
 {
-	array->nr_active--;
-	list_del(&p->run_list);
-	if (list_empty(array->queue + p->prio))
-		__clear_bit(p->prio, array->bitmap);
+	if (p->prio >= rq->curr->prio)
+		return 0;
+	if (!compute || rq->cache_ticks >= cache_decay_ticks ||
+		rt_task(p) || !p->mm || rq->curr == rq->idle) {
+			rq->curr->flags |= PF_PREEMPTED;
+			return 1;
+	}
+	rq->preempted = 1;
+		return 0;
 }
 
-static void enqueue_task(struct task_struct *p, prio_array_t *array)
+static inline int task_queued(task_t *task)
 {
-	list_add_tail(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
-	array->nr_active++;
-	p->array = array;
+	return !list_empty(&task->run_list);
 }
 
 /*
- * Used by the migration code - we pull tasks from the head of the
- * remote queue so we want these tasks to show up at the head of the
- * local queue:
+ * Adding/removing a task to/from a runqueue:
  */
-static inline void enqueue_task_head(struct task_struct *p, prio_array_t *array)
+static void dequeue_task(struct task_struct *p, runqueue_t *rq)
 {
-	list_add(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
-	array->nr_active++;
-	p->array = array;
+	list_del_init(&p->run_list);
+	if (list_empty(rq->queue + p->prio))
+		__clear_bit(p->prio, rq->bitmap);
+}
+
+static void enqueue_task(struct task_struct *p, runqueue_t *rq)
+{
+	if (rq->curr->flags & PF_PREEMPTED) {
+		rq->curr->flags &= ~PF_PREEMPTED;
+		list_add(&p->run_list, rq->queue + p->prio);
+	} else
+		list_add_tail(&p->run_list, rq->queue + p->prio);
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
+ * Used by the migration code - we pull tasks from the head of the
+ * remote queue so we want these tasks to show up at the head of the
+ * local queue:
  */
-static int effective_prio(task_t *p)
+static inline void enqueue_task_head(struct task_struct *p, runqueue_t *rq)
 {
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
+	list_add(&p->run_list, rq->queue + p->prio);
+	__set_bit(p->prio, rq->bitmap);
 }
 
 /*
@@ -365,7 +242,7 @@
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task(p, rq->active);
+	enqueue_task(p, rq);
 	rq->nr_running++;
 }
 
@@ -374,95 +251,109 @@
  */
 static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task_head(p, rq->active);
+	enqueue_task_head(p, rq);
 	rq->nr_running++;
 }
 
-static void recalc_task_prio(task_t *p, unsigned long long now)
+// burst - extra intervals an interactive task can run for at best priority
+static unsigned int burst(task_t *p)
 {
-	unsigned long long __sleep_time = now - p->timestamp;
-	unsigned long sleep_time;
-
-	if (__sleep_time > NS_MAX_SLEEP_AVG)
-		sleep_time = NS_MAX_SLEEP_AVG;
+	unsigned int task_user_prio;
+	if (rt_task(p))
+		return p->burst;
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
+static void inc_burst(task_t *p)
+{
+	unsigned int best_burst;
+	best_burst = burst(p);
+	if (p->burst < best_burst)
+		p->burst++;
+}
 
-			/*
-			 * Tasks with low interactive_credit are limited to
-			 * one timeslice worth of sleep avg bonus.
-			 */
-			if (LOW_CREDIT(p) &&
-			    sleep_time > JIFFIES_TO_NS(task_timeslice(p)))
-				sleep_time = JIFFIES_TO_NS(task_timeslice(p));
+static void dec_burst(task_t *p)
+{
+	if (p->burst)
+		p->burst--;
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
+// slice - the duration a task runs before losing burst
+static unsigned int slice(task_t *p)
+{
+	unsigned int slice = RR_INTERVAL;
+	if (!rt_task(p))
+		slice += burst(p) * RR_INTERVAL;
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
+/*
+ * effective_prio - dynamic priority dependent on burst.
+ * The priority normally decreases by one each RR_INTERVAL.
+ * As the burst increases the priority stays at the top "stair" or
+ * priority for longer.
+ */
+static int effective_prio(task_t *p)
+{
+	int prio;
+	unsigned int full_slice, used_slice, first_slice;
+	unsigned int best_burst;
+	if (rt_task(p))
+		return p->prio;
+
+	best_burst = burst(p);
+	full_slice = slice(p);
+	used_slice = full_slice - p->slice;
+	if (p->burst > best_burst)
+		p->burst = best_burst;
+	first_slice = RR_INTERVAL;
+	if (interactive && !compute)
+		first_slice *= (p->burst + 1);
+	prio = MAX_PRIO - 1 - best_burst;
+
+	if (used_slice < first_slice)
+		return prio;
+	prio += 1 + (used_slice - first_slice) / RR_INTERVAL;
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
+	if ((!run_time && NS_TO_JIFFIES(p->runtime + sleep_time) <
+		RR_INTERVAL) || p->flags & PF_FORKED) {
+			p->flags &= ~PF_FORKED;
+			if (p->slice - total_run < 1) {
+				p->totalrun = 0;
+				dec_burst(p);
+			} else {
+				p->totalrun += p->runtime;
+				p->slice -= NS_TO_JIFFIES(p->totalrun);
 			}
-		}
+	} else {
+		inc_burst(p);
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
@@ -471,33 +362,11 @@
 			+ rq->timestamp_last_tick;
 	}
 #endif
-
+	p->slice = slice(p);
 	recalc_task_prio(p, now);
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
+	p->prio = effective_prio(p);
+	p->time_slice = RR_INTERVAL;
 	p->timestamp = now;
-
 	__activate_task(p, rq);
 }
 
@@ -509,8 +378,7 @@
 	rq->nr_running--;
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
-	dequeue_task(p, p->array);
-	p->array = NULL;
+	dequeue_task(p, rq);
 }
 
 /*
@@ -583,7 +451,7 @@
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
 	 */
-	if (!p->array && !task_running(rq, p)) {
+	if (!task_queued(p) && !task_running(rq, p)) {
 		set_task_cpu(p, dest_cpu);
 		return 0;
 	}
@@ -614,7 +482,7 @@
 repeat:
 	rq = task_rq_lock(p, &flags);
 	/* Must be off runqueue entirely, not preempted. */
-	if (unlikely(p->array)) {
+	if (unlikely(task_queued(p))) {
 		/* If it's preempted, we yield.  It could be a while. */
 		preempted = !task_running(rq, p);
 		task_rq_unlock(rq, &flags);
@@ -744,7 +612,7 @@
 	if (!(old_state & state))
 		goto out;
 
-	if (p->array)
+	if (task_queued(p))
 		goto out_running;
 
 	cpu = task_cpu(p);
@@ -811,7 +679,7 @@
 		old_state = p->state;
 		if (!(old_state & state))
 			goto out;
-		if (p->array)
+		if (task_queued(p))
 			goto out_running;
 
 		this_cpu = smp_processor_id();
@@ -820,14 +688,8 @@
 
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
@@ -839,7 +701,7 @@
 	 */
 	activate_task(p, rq, cpu == this_cpu);
 	if (!sync || cpu != this_cpu) {
-		if (TASK_PREEMPTS_CURR(p, rq))
+		if (task_preempts_curr(p, rq))
 			resched_task(rq->curr);
 	}
 	success = 1;
@@ -879,7 +741,6 @@
 	 */
 	p->state = TASK_RUNNING;
 	INIT_LIST_HEAD(&p->run_list);
-	p->array = NULL;
 	spin_lock_init(&p->switch_lock);
 #ifdef CONFIG_PREEMPT
 	/*
@@ -890,33 +751,6 @@
 	 */
 	p->thread_info->preempt_count = 1;
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
-	if (!current->time_slice) {
-		/*
-		 * This case is rare, it happens when the parent has only
-		 * a single jiffy left from its timeslice. Taking the
-		 * runqueue lock is not a problem.
-		 */
-		current->time_slice = 1;
-		preempt_disable();
-		scheduler_tick(0, 0);
-		local_irq_enable();
-		preempt_enable();
-	} else
-		local_irq_enable();
 }
 
 /*
@@ -930,66 +764,14 @@
 	unsigned long flags;
 	runqueue_t *rq = task_rq_lock(current, &flags);
 
+	//Forked process gets no burst to prevent fork bombs.
+	p->burst = 0;
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
-	task_rq_unlock(rq, &flags);
-}
-
-/*
- * Potentially available exiting-child timeslices are
- * retrieved here - this way the parent does not get
- * penalized for creating too many threads.
- *
- * (this cannot be used to 'generate' timeslices
- * artificially, because any timeslice recovered here
- * was given away by the parent in the first place.)
- */
-void fastcall sched_exit(task_t * p)
-{
-	unsigned long flags;
-	runqueue_t *rq;
-
-	local_irq_save(flags);
-	if (p->first_time_slice) {
-		p->parent->time_slice += p->time_slice;
-		if (unlikely(p->parent->time_slice > MAX_TIMESLICE))
-			p->parent->time_slice = MAX_TIMESLICE;
-	}
-	local_irq_restore(flags);
-	/*
-	 * If the child was a (relative-) CPU hog then decrease
-	 * the sleep_avg of the parent as well.
-	 */
-	rq = task_rq_lock(p->parent, &flags);
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = p->parent->sleep_avg /
-		(EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg /
-		(EXIT_WEIGHT + 1);
+	__activate_task(p, rq);
+	current->flags |= PF_FORKED;
 	task_rq_unlock(rq, &flags);
 }
 
@@ -1253,30 +1035,16 @@
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
 
 	if (cpu == this_cpu) {
-		if (unlikely(!current->array))
+		if (unlikely(!task_queued(current)))
 			__activate_task(p, rq);
 		else {
 			p->prio = current->prio;
 			list_add_tail(&p->run_list, &current->run_list);
-			p->array = current->array;
-			p->array->nr_active++;
 			rq->nr_running++;
 		}
 	} else {
@@ -1284,7 +1052,7 @@
 		p->timestamp = (p->timestamp - this_rq->timestamp_last_tick)
 					+ rq->timestamp_last_tick;
 		__activate_task(p, rq);
-		if (TASK_PREEMPTS_CURR(p, rq))
+		if (task_preempts_curr(p, rq))
 			resched_task(rq->curr);
 	}
 
@@ -1376,22 +1144,22 @@
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
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
 	 */
-	if (TASK_PREEMPTS_CURR(p, this_rq))
+	if (task_preempts_curr(p, this_rq))
 		resched_task(this_rq->curr);
 }
 
@@ -1434,7 +1202,6 @@
 		      unsigned long max_nr_move, struct sched_domain *sd,
 		      enum idle_type idle)
 {
-	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
 	int idx, pulled = 0;
 	task_t *tmp;
@@ -1442,38 +1209,17 @@
 	if (max_nr_move <= 0 || busiest->nr_running <= 1)
 		goto out;
 
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
@@ -1486,7 +1232,7 @@
 		idx++;
 		goto skip_bitmap;
 	}
-	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
+	pull_task(busiest, tmp, this_rq, this_cpu);
 	pulled++;
 
 	/* We only want to steal up to the prescribed number of tasks. */
@@ -1956,22 +1702,6 @@
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
@@ -2015,78 +1745,36 @@
 		cpustat->user += user_ticks;
 	cpustat->system += sys_ticks;
 
-	/* Task might have expired already, but not scheduled off yet */
-	if (p->array != rq->active) {
+	spin_lock(&rq->lock);
+	// SCHED_FIFO tasks never run out of timeslice.
+	if (unlikely(p->policy == SCHED_FIFO))
+		goto out_unlock;
+	rq->cache_ticks++;
+	// Tasks lose burst each time they use up a full slice().
+	if (!--p->slice) {
 		set_tsk_need_resched(p);
-		goto out;
+		dequeue_task(p, rq);
+		dec_burst(p);
+		p->slice = slice(p);
+		p->prio = effective_prio(p);
+		p->time_slice = RR_INTERVAL;
+		enqueue_task(p, rq);
+		goto out_unlock;
 	}
-	spin_lock(&rq->lock);
 	/*
-	 * The task was running during this tick - update the
-	 * time slice counter. Note: we do not update a thread's
-	 * priority until it either goes to sleep or uses up its
-	 * timeslice. This makes it possible for interactive tasks
-	 * to use up their timeslices at their highest priority levels.
+	 * Tasks that run out of time_slice but still have slice left get
+	 * requeued with a lower priority && RR_INTERVAL time_slice.
 	 */
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
-		goto out_unlock;
-	}
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
+	if (rq->preempted && rq->cache_ticks >= cache_decay_ticks)
+		set_tsk_need_resched(p);
 out_unlock:
 	spin_unlock(&rq->lock);
 out:
@@ -2149,8 +1837,8 @@
 		 * task from using an unfair proportion of the
 		 * physical cpu's resources. -ck
 		 */
-		if (((smt_curr->time_slice * (100 - sd->per_cpu_gain) / 100) >
-			task_timeslice(p) || rt_task(smt_curr)) &&
+		if (((smt_curr->slice * (100 - sd->per_cpu_gain) / 100) >
+			slice(p) || rt_task(smt_curr)) &&
 			p->mm && smt_curr->mm && !rt_task(p))
 				ret = 1;
 
@@ -2159,8 +1847,8 @@
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
@@ -2186,10 +1874,8 @@
 	long *switch_count;
 	task_t *prev, *next;
 	runqueue_t *rq;
-	prio_array_t *array;
 	struct list_head *queue;
 	unsigned long long now;
-	unsigned long run_time;
 	int cpu, idx;
 
 	/*
@@ -2211,19 +1897,8 @@
 
 	release_kernel_lock(prev);
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
@@ -2245,59 +1920,26 @@
 		idle_balance(cpu, rq);
 		if (!rq->nr_running) {
 			next = rq->idle;
-			rq->expired_timestamp = 0;
 			wake_sleeping_dependent(cpu, rq);
 			goto switch_tasks;
 		}
 	}
 
-	array = rq->active;
-	if (unlikely(!array->nr_active)) {
-		/*
-		 * Switch the active and expired arrays.
-		 */
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
-
-	prev->sleep_avg -= run_time;
-	if ((long)prev->sleep_avg <= 0) {
-		prev->sleep_avg = 0;
-		if (!(HIGH_CREDIT(prev) || LOW_CREDIT(prev)))
-			prev->interactive_credit--;
-	}
 	prev->timestamp = now;
 
 	if (likely(prev != next)) {
+		rq->preempted = 0;
+		rq->cache_ticks = 0;
 		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
@@ -2560,9 +2202,8 @@
 void set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
-	prio_array_t *array;
 	runqueue_t *rq;
-	int old_prio, new_prio, delta;
+	int queued, old_prio, new_prio, delta;
 
 	if (TASK_NICE(p) == nice || nice < -20 || nice > 19)
 		return;
@@ -2581,9 +2222,8 @@
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
@@ -2591,8 +2231,8 @@
 	p->static_prio = NICE_TO_PRIO(nice);
 	p->prio += delta;
 
-	if (array) {
-		enqueue_task(p, array);
+	if (queued) {
+		enqueue_task(p, rq);
 		/*
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
@@ -2697,7 +2337,7 @@
 /* Actually do priority change: must hold rq lock. */
 static void __setscheduler(struct task_struct *p, int policy, int prio)
 {
-	BUG_ON(p->array);
+	BUG_ON(task_queued(p));
 	p->policy = policy;
 	p->rt_priority = prio;
 	if (policy != SCHED_NORMAL)
@@ -2713,8 +2353,7 @@
 {
 	struct sched_param lp;
 	int retval = -EINVAL;
-	int oldprio;
-	prio_array_t *array;
+	int queued, oldprio;
 	unsigned long flags;
 	runqueue_t *rq;
 	task_t *p;
@@ -2774,13 +2413,12 @@
 	if (retval)
 		goto out_unlock;
 
-	array = p->array;
-	if (array)
+	if ((queued = task_queued(p)))
 		deactivate_task(p, task_rq(p));
 	retval = 0;
 	oldprio = p->prio;
 	__setscheduler(p, policy, lp.sched_priority);
-	if (array) {
+	if (queued) {
 		__activate_task(p, task_rq(p));
 		/*
 		 * Reschedule if we are currently running on this runqueue and
@@ -2790,7 +2428,7 @@
 		if (task_running(rq, p)) {
 			if (p->prio > oldprio)
 				resched_task(rq->curr);
-		} else if (TASK_PREEMPTS_CURR(p, rq))
+		} else if (task_preempts_curr(p, rq))
 			resched_task(rq->curr);
 	}
 
@@ -2983,28 +2621,19 @@
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
-
-	/*
-	 * We implement yielding by moving the task into the expired
-	 * queue.
-	 *
-	 * (special rule: RT tasks will just roundrobin in the active
-	 *  array.)
-	 */
-	if (unlikely(rt_task(current)))
-		target = rq->active;
 
-	dequeue_task(current, array);
-	enqueue_task(current, target);
+	dequeue_task(current, rq);
+ 	current->slice = slice(current);
+ 	current->time_slice = RR_INTERVAL;
+	if (!rt_task(current))
+		current->prio = MAX_PRIO - 1;
+	current->burst = 0;
+	enqueue_task(current, rq);
 
 	/*
 	 * Since we are going to call schedule() anyway, there's
@@ -3143,7 +2772,7 @@
 		goto out_unlock;
 
 	jiffies_to_timespec(p->policy & SCHED_FIFO ?
-				0 : task_timeslice(p), &t);
+				0 : slice(p), &t);
 	read_unlock(&tasklist_lock);
 	retval = copy_to_user(interval, &t, sizeof(t)) ? -EFAULT : 0;
 out_nounlock:
@@ -3261,9 +2890,9 @@
 
 	idle_rq->curr = idle_rq->idle = idle;
 	deactivate_task(idle, rq);
-	idle->array = NULL;
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
+	idle->burst = 0;
 	set_task_cpu(idle, cpu);
 	double_rq_unlock(idle_rq, rq);
 	set_tsk_need_resched(idle);
@@ -3372,7 +3001,7 @@
 		goto out;
 
 	set_task_cpu(p, dest_cpu);
-	if (p->array) {
+	if (task_queued(p)) {
 		/*
 		 * Sync timestamp with rq_dest's before activating.
 		 * The same thing could be achieved by doing this step
@@ -3383,7 +3012,7 @@
 				+ rq_dest->timestamp_last_tick;
 		deactivate_task(p, rq_src);
 		activate_task(p, rq_dest, 0);
-		if (TASK_PREEMPTS_CURR(p, rq_dest))
+		if (task_preempts_curr(p, rq_dest))
 			resched_task(rq_dest->curr);
 	}
 
@@ -3896,7 +3525,7 @@
 void __init sched_init(void)
 {
 	runqueue_t *rq;
-	int i, j, k;
+	int i, j;
 
 #ifdef CONFIG_SMP
 	/* Set up an initial dummy domain for early boot */
@@ -3917,13 +3546,11 @@
 #endif
 
 	for (i = 0; i < NR_CPUS; i++) {
-		prio_array_t *array;
-
 		rq = cpu_rq(i);
 		spin_lock_init(&rq->lock);
-		rq->active = rq->arrays;
-		rq->expired = rq->arrays + 1;
-		rq->best_expired_prio = MAX_PRIO;
+		
+		rq->cache_ticks = 0;
+		rq->preempted = 0;
 
 #ifdef CONFIG_SMP
 		rq->sd = &sched_domain_init;
@@ -3934,16 +3561,11 @@
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
+		for (j = 0; j <= MAX_PRIO; j++)
+			INIT_LIST_HEAD(&rq->queue[j]);
+		memset(rq->bitmap, 0, BITS_TO_LONGS(MAX_PRIO+1)*sizeof(long));
+		// delimiter for bitsearch
+		__set_bit(MAX_PRIO, rq->bitmap);
 	}
 	/*
 	 * We have to do a little magic to get the first
Index: linux-2.6.7-staircase/kernel/sysctl.c
===================================================================
--- linux-2.6.7-staircase.orig/kernel/sysctl.c	2004-06-25 02:24:28.112116264 +1000
+++ linux-2.6.7-staircase/kernel/sysctl.c	2004-06-25 02:24:33.895207459 +1000
@@ -636,6 +636,22 @@
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
 

--------------040904020404060004020307--

--------------enig7587CBED03E36A8A59A66B24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA3DjQZUg7+tp6mRURAjCgAJ9Rb2kNsll34UvEwpzRcbGBATHm+QCeOWPo
mKtSoLPcc3dEbWEDssqZaR4=
=3UgR
-----END PGP SIGNATURE-----

--------------enig7587CBED03E36A8A59A66B24--
