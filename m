Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266002AbUHFIVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266002AbUHFIVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 04:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbUHFIVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 04:21:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:19440 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267558AbUHFIQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 04:16:21 -0400
Message-Id: <200408060816.i768FxL06596@owlet.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, mbligh@aracnet.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: [PATCH] schedstats and staircase scheduler
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_352894620"
Date: Fri, 06 Aug 2004 01:15:59 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_352894620
Content-Type: text/plain; charset=us-ascii

Andrew wrote:

> My current rollup (which is pretty much rc3-mm1 with only that change) is
> at http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2.  Additional
> scheduler work should be against that tree, please.

First, thanks, Ingo, for the schedstat changes.

Ok Andrew, I've attached two patches (which should be applied in order to 
apply cleanly).  They are separate because they address two different issues.  
The first, sstat-nosmp, fixes a problem with schedstats when CONFIG_SMP is not 
defined.

The second should restore the staircase scheduler so that we can figure out 
why it's good and whether it can be even better.

Rick



--==_Exmh_352894620
Content-Type: text/plain ; name="rc3-mm1x.100-sstat-nosmp"; charset=us-ascii
Content-Description: rc3-mm1x.100-sstat-nosmp
Content-Disposition: attachment; filename="rc3-mm1x.100-sstat-nosmp"

SMP fix --
    for_each_domain() is not defined if not CONFIG_SMP, so show_schedstat
    needed a couple of extra ifdefs.

This should be applied against 2.6.8-rc3-mmcurrent.

Signed-off-by: Rick Lindsley <ricklind@us.ibm.com>

diff -rup linux-2.6.8-rc3-mm1x/Documentation/sched-stats.txt linux-2.6.8-rc3-mm1x-ss/Documentation/sched-stats.txt
--- linux-2.6.8-rc3-mm1x/Documentation/sched-stats.txt	Thu Aug  5 14:37:52 2004
+++ linux-2.6.8-rc3-mm1x-ss/Documentation/sched-stats.txt	Thu Aug  5 14:34:23 2004
@@ -1,6 +1,8 @@
 Version 10 of schedstats includes support for sched_domains, which
 hit the mainline kernel in 2.6.7.  Some counters make more sense to be
-per-runqueue; other to be per-domain.
+per-runqueue; other to be per-domain.  Note that domains (and their associated
+information) will only be pertinent and available on machines utilizing
+CONFIG_SMP.
 
 In version 10 of schedstat, there is at least one level of domain
 statistics for each cpu listed, and there may well be more than one
@@ -83,7 +85,9 @@ The last six are statistics dealing with
 
 Domain statistics
 -----------------
-One of these is produced per domain for each cpu described.
+One of these is produced per domain for each cpu described. (Note that if
+CONFIG_SMP is not defined, *no* domains are utilized and these lines
+will not appear in the output.)
 
 domain<N> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
 
diff -rup linux-2.6.8-rc3-mm1x/kernel/sched.c linux-2.6.8-rc3-mm1x-ss/kernel/sched.c
--- linux-2.6.8-rc3-mm1x/kernel/sched.c	Thu Aug  5 14:38:44 2004
+++ linux-2.6.8-rc3-mm1x-ss/kernel/sched.c	Thu Aug  5 14:35:27 2004
@@ -486,8 +486,10 @@ static int show_schedstat(struct seq_fil
 	seq_printf(seq, "timestamp %lu\n", jiffies);
 	for_each_online_cpu(cpu) {
 		runqueue_t *rq = cpu_rq(cpu);
+#ifdef CONFIG_SMP
 		struct sched_domain *sd;
 		int dcnt = 0;
+#endif
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
@@ -509,6 +511,7 @@ static int show_schedstat(struct seq_fil
 						    rq->pt_lost[itype]);
 		seq_printf(seq, "\n");
 
+#ifdef CONFIG_SMP
 		/* domain-specific stats */
 		for_each_domain(cpu, sd) {
 			char mask_str[NR_CPUS];
@@ -527,6 +530,7 @@ static int show_schedstat(struct seq_fil
 			    sd->sbe_pushed, sd->sbe_attempts,
 			    sd->ttwu_wake_affine, sd->ttwu_wake_balance);
 		}
+#endif
 	}
 	return 0;
 }

--==_Exmh_352894620
Content-Type: text/plain ; name="rc3-mm1x.200-scase"; charset=us-ascii
Content-Description: rc3-mm1x.200-scase
Content-Disposition: attachment; filename="rc3-mm1x.200-scase"

Restores Con Kolivas' staircase scheduler code.  Patch burps were,
    in general, caused by schedstat code appearing in functions and
    causing context diffs to fail.  Functionally, nothing's changed.

This should be applied against 2.6.8-rc3-mmcurrent.

Signed-off-by: Rick Lindsley <ricklind@us.ibm.com>

diff -rupN linux-2.6.8-rc3-mm1x/fs/proc/array.c linux-2.6.8-rc3-mm1x-A/fs/proc/array.c
--- linux-2.6.8-rc3-mm1x/fs/proc/array.c	Tue Aug  3 14:28:02 2004
+++ linux-2.6.8-rc3-mm1x-A/fs/proc/array.c	Thu Aug  5 15:09:29 2004
@@ -155,7 +155,7 @@ static inline char * task_state(struct t
 	read_lock(&tasklist_lock);
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
-		"SleepAVG:\t%lu%%\n"
+		"Burst:\t%d\n"
 		"Tgid:\t%d\n"
 		"Pid:\t%d\n"
 		"PPid:\t%d\n"
@@ -163,7 +163,7 @@ static inline char * task_state(struct t
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
-		(p->sleep_avg/1024)*100/(1020000000/1024),
+		p->burst,
 	       	p->tgid,
 		p->pid, p->pid ? p->real_parent->pid : 0,
 		p->pid && p->ptrace ? p->parent->pid : 0,
diff -rupN linux-2.6.8-rc3-mm1x/include/linux/sched.h linux-2.6.8-rc3-mm1x-A/include/linux/sched.h
--- linux-2.6.8-rc3-mm1x/include/linux/sched.h	Thu Aug  5 15:00:45 2004
+++ linux-2.6.8-rc3-mm1x-A/include/linux/sched.h	Thu Aug  5 15:09:30 2004
@@ -164,6 +164,7 @@ extern void show_stack(struct task_struc
 
 void io_schedule(void);
 long io_schedule_timeout(long timeout);
+extern int sched_interactive, sched_compute;
 
 extern void cpu_init (void);
 extern void trap_init(void);
@@ -344,7 +345,6 @@ extern struct user_struct *find_user(uid
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
 
-typedef struct prio_array prio_array_t;
 struct backing_dev_info;
 struct reclaim_state;
 
@@ -433,16 +433,13 @@ struct task_struct {
 
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
 
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
@@ -615,6 +612,9 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
+#define PF_FORKED	0x00400000	/* I have just forked */
+#define PF_YIELDED	0x00800000	/* I have just yielded */
+#define PF_UISLEEP	0x01000000	/* Uninterruptible sleep */
 
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
@@ -698,7 +698,6 @@ extern void FASTCALL(wake_up_new_task(st
  static inline void kick_process(struct task_struct *tsk) { }
 #endif
 extern void FASTCALL(sched_fork(task_t * p));
-extern void FASTCALL(sched_exit(task_t * p));
 
 extern int in_group_p(gid_t);
 extern int in_egroup_p(gid_t);
diff -rupN linux-2.6.8-rc3-mm1x/include/linux/sysctl.h linux-2.6.8-rc3-mm1x-A/include/linux/sysctl.h
--- linux-2.6.8-rc3-mm1x/include/linux/sysctl.h	Thu Aug  5 15:00:45 2004
+++ linux-2.6.8-rc3-mm1x-A/include/linux/sysctl.h	Thu Aug  5 15:09:30 2004
@@ -134,6 +134,8 @@ enum
 	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
 	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
+	KERN_INTERACTIVE=67,	/* interactive tasks can have cpu bursts */
+	KERN_COMPUTE=68,	/* adjust timeslices for a compute server */
 };
 
 
diff -rupN linux-2.6.8-rc3-mm1x/init/main.c linux-2.6.8-rc3-mm1x-A/init/main.c
--- linux-2.6.8-rc3-mm1x/init/main.c	Thu Aug  5 15:00:45 2004
+++ linux-2.6.8-rc3-mm1x-A/init/main.c	Thu Aug  5 15:09:30 2004
@@ -683,6 +683,7 @@ static inline void fixup_cpu_present_map
 static int init(void * unused)
 {
 	lock_kernel();
+	current->prio = MAX_PRIO - 1;
 	/*
 	 * Tell the world that we're going to be the grim
 	 * reaper of innocent orphaned children.
diff -rupN linux-2.6.8-rc3-mm1x/kernel/exit.c linux-2.6.8-rc3-mm1x-A/kernel/exit.c
--- linux-2.6.8-rc3-mm1x/kernel/exit.c	Thu Aug  5 15:00:45 2004
+++ linux-2.6.8-rc3-mm1x-A/kernel/exit.c	Thu Aug  5 15:09:30 2004
@@ -96,7 +96,6 @@ repeat: 
 	p->parent->cnvcsw += p->nvcsw + p->cnvcsw;
 	p->parent->cnivcsw += p->nivcsw + p->cnivcsw;
 	perfctr_release_task(p);
-	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
 	proc_pid_flush(proc_dentry);
diff -rupN linux-2.6.8-rc3-mm1x/kernel/sched.c linux-2.6.8-rc3-mm1x-A/kernel/sched.c
--- linux-2.6.8-rc3-mm1x/kernel/sched.c	Thu Aug  5 15:04:21 2004
+++ linux-2.6.8-rc3-mm1x-A/kernel/sched.c	Thu Aug  5 15:34:24 2004
@@ -16,6 +16,8 @@
  *		by Davide Libenzi, preemptible kernel bits by Robert Love.
  *  2003-09-03	Interactivity tuning by Con Kolivas.
  *  2004-04-02	Scheduler domains code by Nick Piggin
+ *  2004-07-07	New staircase scheduling policy by Con Kolivas with help
+ *		from William Lee Irwin III, Zwane Mwaikambo & Peter Williams.
  */
 
 #include <linux/mm.h>
@@ -49,12 +51,6 @@
 
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
@@ -79,111 +75,15 @@
  * Some helpers for converting nanosecond timing to jiffy resolution
  */
 #define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
-#define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
 
+int sched_compute = 0;
 /*
- * These are the 'tuning knobs' of the scheduler:
- *
- * Minimum timeslice is 5 msecs (or 1 jiffy, whichever is larger),
- * default timeslice is 100 msecs, maximum timeslice is 200 msecs.
- * Timeslices get refilled after they expire.
- */
-#define MIN_TIMESLICE		max(5 * HZ / 1000, 1)
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
+ *This is the time all tasks within the same priority round robin.
+ *compute setting is reserved for dedicated computational scheduling
+ *and has ten times larger intervals.
  */
-
-#define BASE_TIMESLICE(p) \
-	max(MAX_TIMESLICE * (MAX_PRIO - (p)->static_prio) / (MAX_USER_PRIO), \
-		MIN_TIMESLICE)
-
-static unsigned int task_timeslice(task_t *p)
-{
-	return BASE_TIMESLICE(p);
-}
+#define _RR_INTERVAL		((10 * HZ / 1000) ? : 1)
+#define RR_INTERVAL()		(_RR_INTERVAL * (1 + 9 * sched_compute))
 
 #define task_hot(p, now, sd) ((now) - (p)->timestamp < (sd)->cache_hot_time)
 
@@ -201,16 +101,8 @@ struct sched_domain;
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
@@ -230,12 +122,13 @@ struct runqueue {
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
@@ -693,24 +586,26 @@ static inline void sched_info_switch(tas
 #define sched_info_switch(t, next)	do { } while (0)
 #endif /* CONFIG_SCHEDSTATS */
 
+static inline int task_queued(task_t *task)
+{
+	return !list_empty(&task->run_list);
+}
+
 /*
- * Adding/removing a task to/from a priority array:
+ * Adding/removing a task to/from a runqueue:
  */
-static void dequeue_task(struct task_struct *p, prio_array_t *array)
+static void dequeue_task(struct task_struct *p, runqueue_t *rq)
 {
-	array->nr_active--;
-	list_del(&p->run_list);
-	if (list_empty(array->queue + p->prio))
-		__clear_bit(p->prio, array->bitmap);
+	list_del_init(&p->run_list);
+	if (list_empty(rq->queue + p->prio))
+		__clear_bit(p->prio, rq->bitmap);
 }
 
-static void enqueue_task(struct task_struct *p, prio_array_t *array)
+static void enqueue_task(struct task_struct *p, runqueue_t *rq)
 {
 	sched_info_queued(p);
-	list_add_tail(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
-	array->nr_active++;
-	p->array = array;
+	list_add_tail(&p->run_list, rq->queue + p->prio);
+	__set_bit(p->prio, rq->bitmap);
 }
 
 /*
@@ -718,43 +613,10 @@ static void enqueue_task(struct task_str
  * remote queue so we want these tasks to show up at the head of the
  * local queue:
  */
-static inline void enqueue_task_head(struct task_struct *p, prio_array_t *array)
+static inline void enqueue_task_head(struct task_struct *p, runqueue_t *rq)
 {
-	list_add(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
-	array->nr_active++;
-	p->array = array;
-}
-
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
+	list_add(&p->run_list, rq->queue + p->prio);
+	__set_bit(p->prio, rq->bitmap);
 }
 
 /*
@@ -762,7 +624,7 @@ static int effective_prio(task_t *p)
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task(p, rq->active);
+	enqueue_task(p, rq);
 	rq->nr_running++;
 }
 
@@ -771,95 +633,121 @@ static inline void __activate_task(task_
  */
 static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task_head(p, rq->active);
+	enqueue_task_head(p, rq);
 	rq->nr_running++;
 }
 
-static void recalc_task_prio(task_t *p, unsigned long long now)
+/*
+ * burst - extra intervals an interactive task can run for at best priority
+ * instead of descending priorities.
+ */
+static unsigned int burst(task_t *p)
 {
-	unsigned long long __sleep_time = now - p->timestamp;
-	unsigned long sleep_time;
+	if (likely(!rt_task(p))) {
+		unsigned int task_user_prio = TASK_USER_PRIO(p);
+		return 39 - task_user_prio;
+	} else
+		return p->burst;
+}
 
-	if (__sleep_time > NS_MAX_SLEEP_AVG)
-		sleep_time = NS_MAX_SLEEP_AVG;
-	else
-		sleep_time = (unsigned long)__sleep_time;
+static void inc_burst(task_t *p)
+{
+	unsigned int best_burst;
+	best_burst = burst(p);
+	if (p->burst < best_burst)
+		p->burst++;
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
+static void dec_burst(task_t *p)
+{
+	if (p->burst)
+		p->burst--;
+}
 
-			/*
-			 * Tasks with low interactive_credit are limited to
-			 * one timeslice worth of sleep avg bonus.
-			 */
-			if (LOW_CREDIT(p) &&
-			    sleep_time > JIFFIES_TO_NS(task_timeslice(p)))
-				sleep_time = JIFFIES_TO_NS(task_timeslice(p));
+/*
+ * slice - the duration a task runs before getting requeued at it's best
+ * priority and has it's burst decremented.
+ */
+static unsigned int slice(task_t *p)
+{
+	unsigned int slice = RR_INTERVAL();
+	if (likely(!rt_task(p)))
+		slice += burst(p) * RR_INTERVAL();
+	return slice;
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
+/*
+ * sched_interactive - sysctl which allows interactive tasks to have bursts
+ */
+int sched_interactive = 1;
 
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
 
-			if (p->sleep_avg > NS_MAX_SLEEP_AVG) {
-				p->sleep_avg = NS_MAX_SLEEP_AVG;
-				if (!HIGH_CREDIT(p))
-					p->interactive_credit++;
+	best_burst = burst(p);
+	full_slice = slice(p);
+	used_slice = full_slice - p->slice;
+	if (p->burst > best_burst)
+		p->burst = best_burst;
+	first_slice = RR_INTERVAL();
+	if (sched_interactive && !sched_compute)
+		first_slice *= (p->burst + 1);
+	prio = MAX_PRIO - 1 - best_burst;
+
+	if (used_slice < first_slice)
+		return prio;
+	prio += 1 + (used_slice - first_slice) / RR_INTERVAL();
+	if (prio > MAX_PRIO - 1)
+		prio = MAX_PRIO - 1;
+	return prio;
+}
+
+/*
+ * recalc_task_prio - this checks for tasks that run ultra short timeslices
+ * or have just forked a thread/process and make them continue their old
+ * slice instead of starting a new one at high priority.
+ */
+static void recalc_task_prio(task_t *p, unsigned long long now)
+{
+	unsigned long sleep_time = now - p->timestamp;
+	unsigned long ns_totalrun = p->totalrun + p->runtime;
+	unsigned long total_run = NS_TO_JIFFIES(ns_totalrun);
+	if (p->flags & PF_FORKED || ((!(NS_TO_JIFFIES(p->runtime)) ||
+		!sched_interactive || sched_compute) &&
+		NS_TO_JIFFIES(p->runtime + sleep_time) < RR_INTERVAL())) {
+			p->flags &= ~PF_FORKED;
+			if (p->slice - total_run < 1) {
+				p->totalrun = 0;
+				dec_burst(p);
+			} else {
+				p->totalrun = ns_totalrun;
+				p->slice -= total_run;
 			}
-		}
+	} else {
+		if (!(p->flags & PF_UISLEEP))
+			inc_burst(p);
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
@@ -868,33 +756,12 @@ static void activate_task(task_t *p, run
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
+	p->flags &= ~PF_UISLEEP;
+	p->prio = effective_prio(p);
+	p->time_slice = RR_INTERVAL();
 	p->timestamp = now;
-
 	__activate_task(p, rq);
 }
 
@@ -904,10 +771,11 @@ static void activate_task(task_t *p, run
 static void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
 	rq->nr_running--;
-	if (p->state == TASK_UNINTERRUPTIBLE)
+	if (p->state == TASK_UNINTERRUPTIBLE) {
+		p->flags |= PF_UISLEEP;
 		rq->nr_uninterruptible++;
-	dequeue_task(p, p->array);
-	p->array = NULL;
+	}
+	dequeue_task(p, rq);
 }
 
 /*
@@ -980,7 +848,7 @@ static int migrate_task(task_t *p, int d
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
 	 */
-	if (!p->array && !task_running(rq, p)) {
+	if (!task_queued(p) && !task_running(rq, p)) {
 		set_task_cpu(p, dest_cpu);
 		return 0;
 	}
@@ -1011,7 +879,7 @@ void wait_task_inactive(task_t * p)
 repeat:
 	rq = task_rq_lock(p, &flags);
 	/* Must be off runqueue entirely, not preempted. */
-	if (unlikely(p->array)) {
+	if (unlikely(task_queued(p))) {
 		/* If it's preempted, we yield.  It could be a while. */
 		preempted = !task_running(rq, p);
 		task_rq_unlock(rq, &flags);
@@ -1109,6 +977,27 @@ static inline int wake_idle(int cpu, tas
 }
 #endif
 
+/*
+ * cache_delay is the time preemption is delayed in sched_compute mode
+ * and is set to 5*cache_decay_ticks
+ */
+static int cache_delay = 10 * HZ / 1000;
+
+static int task_preempts_curr(struct task_struct *p, runqueue_t *rq)
+{
+	if (p->prio > rq->curr->prio)
+		return 0;
+	if (p->prio == rq->curr->prio && (p->slice < slice(p) ||
+		p->time_slice <= rq->curr->time_slice ||
+		rt_task(rq->curr)))
+			return 0;
+	if (!sched_compute || rq->cache_ticks >= cache_delay ||
+		!p->mm || rt_task(p))
+			return 1;
+	rq->preempted = 1;
+		return 0;
+}
+
 /***
  * try_to_wake_up - wake up a thread
  * @p: the to-be-woken-up thread
@@ -1141,7 +1030,7 @@ static int try_to_wake_up(task_t * p, un
 	if (!(old_state & state))
 		goto out;
 
-	if (p->array)
+	if (task_queued(p))
 		goto out_running;
 
 	cpu = task_cpu(p);
@@ -1220,7 +1109,7 @@ out_set_cpu:
 		old_state = p->state;
 		if (!(old_state & state))
 			goto out;
-		if (p->array)
+		if (task_queued(p))
 			goto out_running;
 
 		this_cpu = smp_processor_id();
@@ -1229,14 +1118,8 @@ out_set_cpu:
 
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
@@ -1248,7 +1131,7 @@ out_activate:
 	 */
 	activate_task(p, rq, cpu == this_cpu);
 	if (!sync || cpu != this_cpu) {
-		if (TASK_PREEMPTS_CURR(p, rq))
+		if (task_preempts_curr(p, rq))
 			resched_task(rq->curr);
 	}
 	success = 1;
@@ -1293,7 +1176,6 @@ void fastcall sched_fork(task_t *p)
 	 */
 	p->state = TASK_RUNNING;
 	INIT_LIST_HEAD(&p->run_list);
-	p->array = NULL;
 	spin_lock_init(&p->switch_lock);
 #ifdef CONFIG_SCHEDSTATS
 	memset(&p->sched_info, 0, sizeof(p->sched_info));
@@ -1307,33 +1189,6 @@ void fastcall sched_fork(task_t *p)
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
-	if (unlikely(!current->time_slice)) {
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
@@ -1356,39 +1211,15 @@ void fastcall wake_up_new_task(task_t * 
 	BUG_ON(p->state != TASK_RUNNING);
 
 	schedstat_inc(rq, wunt_cnt);
+
 	/*
-	 * We decrease the sleep average of forking parents
-	 * and children as well, to keep max-interactive tasks
-	 * from forking tasks that are max-interactive. The parent
-	 * (current) is done further down, under its lock.
+	 * Forked process gets no burst to prevent fork bombs.
 	 */
-	p->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
-		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
-
-	p->interactive_credit = 0;
-
-	p->prio = effective_prio(p);
+	p->burst = 0;
+	current->flags |= PF_FORKED;
 
 	if (likely(cpu == this_cpu)) {
-		if (!(clone_flags & CLONE_VM)) {
-			/*
-			 * The VM isn't cloned, so we're in a good position to
-			 * do child-runs-first in anticipation of an exec. This
-			 * usually avoids a lot of COW overhead.
-			 */
-			if (unlikely(!current->array))
-				__activate_task(p, rq);
-			else {
-				p->prio = current->prio;
-				list_add_tail(&p->run_list, &current->run_list);
-				p->array = current->array;
-				p->array->nr_active++;
-				rq->nr_running++;
-			}
-			set_need_resched();
-		} else
-			/* Run child last */
-			__activate_task(p, rq);
+		__activate_task(p, rq);
 	} else {
 		runqueue_t *this_rq = cpu_rq(this_cpu);
 
@@ -1399,51 +1230,12 @@ void fastcall wake_up_new_task(task_t * 
 		p->timestamp = (p->timestamp - this_rq->timestamp_last_tick)
 					+ rq->timestamp_last_tick;
 		__activate_task(p, rq);
-		if (TASK_PREEMPTS_CURR(p, rq))
+		if (task_preempts_curr(p, rq))
 			resched_task(rq->curr);
 
-		current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
-			PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
-		schedstat_inc(rq, wunt_moved);
-	}
-
-	if (unlikely(cpu != this_cpu)) {
 		task_rq_unlock(rq, &flags);
 		rq = task_rq_lock(current, &flags);
 	}
-	current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
-		PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
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
-	/*
-	 * If the child was a (relative-) CPU hog then decrease
-	 * the sleep_avg of the parent as well.
-	 */
-	rq = task_rq_lock(p->parent, &flags);
-	if (p->first_time_slice) {
-		p->parent->time_slice += p->time_slice;
-		if (unlikely(p->parent->time_slice > MAX_TIMESLICE))
-			p->parent->time_slice = MAX_TIMESLICE;
-	}
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = p->parent->sleep_avg /
-		(EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg /
-		(EXIT_WEIGHT + 1);
 	task_rq_unlock(rq, &flags);
 }
 
@@ -1745,21 +1537,21 @@ out:
  * Both runqueues must be locked.
  */
 static inline
-void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p,
-	       runqueue_t *this_rq, prio_array_t *this_array, int this_cpu)
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
 
@@ -1802,7 +1594,6 @@ static int move_tasks(runqueue_t *this_r
 		      unsigned long max_nr_move, struct sched_domain *sd,
 		      enum idle_type idle)
 {
-	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
 	int idx, pulled = 0;
 	task_t *tmp;
@@ -1810,38 +1601,17 @@ static int move_tasks(runqueue_t *this_r
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
@@ -1863,7 +1633,7 @@ skip_queue:
 	schedstat_inc(this_rq, pt_gained[idle]);
 	schedstat_inc(busiest, pt_lost[idle]);
 
-	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
+	pull_task(busiest, tmp, this_rq, this_cpu);
 	pulled++;
 
 	/* We only want to steal up to the prescribed number of tasks. */
@@ -2356,22 +2126,6 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
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
@@ -2414,79 +2168,41 @@ void scheduler_tick(int user_ticks, int 
 	else
 		cpustat->user += user_ticks;
 	cpustat->system += sys_ticks;
-
-	/* Task might have expired already, but not scheduled off yet */
-	if (p->array != rq->active) {
-		set_tsk_need_resched(p);
+	/*
+	 * SCHED_FIFO tasks never run out of timeslice.
+	 */
+	if (unlikely(p->policy == SCHED_FIFO))
 		goto out;
-	}
+
 	spin_lock(&rq->lock);
+	rq->cache_ticks++;
 	/*
-	 * The task was running during this tick - update the
-	 * time slice counter. Note: we do not update a thread's
-	 * priority until it either goes to sleep or uses up its
-	 * timeslice. This makes it possible for interactive tasks
-	 * to use up their timeslices at their highest priority levels.
+	 * Tasks lose burst each time they use up a full slice().
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
-
-			/* put it at the end of the queue: */
-			dequeue_task(p, rq->active);
-			enqueue_task(p, rq->active);
-		}
+	if (!--p->slice) {
+		set_tsk_need_resched(p);
+		dequeue_task(p, rq);
+		dec_burst(p);
+		p->slice = slice(p);
+		p->prio = effective_prio(p);
+		p->time_slice = RR_INTERVAL();
+		enqueue_task(p, rq);
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
+		p->time_slice = RR_INTERVAL();
+		enqueue_task(p, rq);
+		goto out_unlock;
 	}
+	if (rq->preempted && rq->cache_ticks >= cache_delay)
+		set_tsk_need_resched(p);
 out_unlock:
 	spin_unlock(&rq->lock);
 out:
@@ -2549,8 +2265,8 @@ static inline int dependent_sleeper(int 
 		 * task from using an unfair proportion of the
 		 * physical cpu's resources. -ck
 		 */
-		if (((smt_curr->time_slice * (100 - sd->per_cpu_gain) / 100) >
-			task_timeslice(p) || rt_task(smt_curr)) &&
+		if (((smt_curr->slice * (100 - sd->per_cpu_gain) / 100) >
+			slice(p) || rt_task(smt_curr)) &&
 			p->mm && smt_curr->mm && !rt_task(p))
 				ret = 1;
 
@@ -2559,8 +2275,8 @@ static inline int dependent_sleeper(int 
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
@@ -2586,10 +2302,8 @@ asmlinkage void __sched schedule(void)
 	long *switch_count;
 	task_t *prev, *next;
 	runqueue_t *rq;
-	prio_array_t *array;
 	struct list_head *queue;
 	unsigned long long now;
-	unsigned long run_time;
 	int cpu, idx;
 
 	/*
@@ -2610,30 +2324,10 @@ need_resched:
 	prev = current;
 	rq = this_rq();
 
-	/*
-	 * The idle thread is not allowed to schedule!
-	 * Remove this check after it has been exercised a bit.
-	 */
-	if (unlikely(current == rq->idle) && current->state != TASK_RUNNING) {
-		printk(KERN_ERR "bad: scheduling from the idle thread!\n");
-		dump_stack();
-	}
-
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
 
@@ -2656,64 +2350,38 @@ need_resched:
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
-		schedstat_inc(rq, sched_switch);
-		rq->active = rq->expired;
-		rq->expired = array;
-		array = rq->active;
-		rq->expired_timestamp = 0;
-		rq->best_expired_prio = MAX_PRIO;
-	} else
-		schedstat_inc(rq, sched_noswitch);
-
-	idx = sched_find_first_bit(array->bitmap);
-	queue = array->queue + idx;
+	idx = sched_find_first_bit(rq->bitmap);
+	queue = rq->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
 	if (dependent_sleeper(cpu, rq, next)) {
 		schedstat_inc(rq, sched_goidle);
 		next = rq->idle;
-		goto switch_tasks;
 	}
 
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
 
-	prev->sleep_avg -= run_time;
-	if ((long)prev->sleep_avg <= 0) {
-		prev->sleep_avg = 0;
-		if (!(HIGH_CREDIT(prev) || LOW_CREDIT(prev)))
-			prev->interactive_credit--;
-	}
 	prev->timestamp = now;
+	if (next->flags & PF_YIELDED) {
+		next->flags &= ~PF_YIELDED;
+		dequeue_task(next, rq);
+		next->prio = effective_prio(next);
+		enqueue_task_head(next, rq);
+	}
 
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
 		next->timestamp = now;
+		rq->preempted = 0;
+		rq->cache_ticks = 0;
 		rq->nr_switches++;
 		rq->curr = next;
 		++*switch_count;
@@ -2975,9 +2643,8 @@ EXPORT_SYMBOL(sleep_on_timeout);
 void set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
-	prio_array_t *array;
 	runqueue_t *rq;
-	int old_prio, new_prio, delta;
+	int queued, old_prio, new_prio, delta;
 
 	if (TASK_NICE(p) == nice || nice < -20 || nice > 19)
 		return;
@@ -2996,9 +2663,8 @@ void set_user_nice(task_t *p, long nice)
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
@@ -3006,8 +2672,8 @@ void set_user_nice(task_t *p, long nice)
 	p->static_prio = NICE_TO_PRIO(nice);
 	p->prio += delta;
 
-	if (array) {
-		enqueue_task(p, array);
+	if (queued) {
+		enqueue_task(p, rq);
 		/*
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
@@ -3119,7 +2785,7 @@ static inline task_t *find_process_by_pi
 /* Actually do priority change: must hold rq lock. */
 static void __setscheduler(struct task_struct *p, int policy, int prio)
 {
-	BUG_ON(p->array);
+	BUG_ON(task_queued(p));
 	p->policy = policy;
 	p->rt_priority = prio;
 	if (policy != SCHED_NORMAL)
@@ -3135,8 +2801,7 @@ static int setscheduler(pid_t pid, int p
 {
 	struct sched_param lp;
 	int retval = -EINVAL;
-	int oldprio;
-	prio_array_t *array;
+	int queued, oldprio;
 	unsigned long flags;
 	runqueue_t *rq;
 	task_t *p;
@@ -3196,13 +2861,12 @@ static int setscheduler(pid_t pid, int p
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
@@ -3212,7 +2876,7 @@ static int setscheduler(pid_t pid, int p
 		if (task_running(rq, p)) {
 			if (p->prio > oldprio)
 				resched_task(rq->curr);
-		} else if (TASK_PREEMPTS_CURR(p, rq))
+		} else if (task_preempts_curr(p, rq))
 			resched_task(rq->curr);
 	}
 
@@ -3419,37 +3083,22 @@ out_unlock:
 
 /**
  * sys_sched_yield - yield the current processor to other threads.
- *
- * this function yields the current CPU by moving the calling thread
- * to the expired array. If there are no other threads running on this
- * CPU then this function will return.
  */
 asmlinkage long sys_sched_yield(void)
 {
 	runqueue_t *rq = this_rq_lock();
-	prio_array_t *array = current->array;
-	prio_array_t *target = rq->expired;
 
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
-	if (current->array->nr_active == 1) {
-		schedstat_inc(rq, yld_act_empty);
-		if (!rq->expired->nr_active)
-			schedstat_inc(rq, yld_both_empty);
-	} else if (!rq->expired->nr_active)
-		schedstat_inc(rq, yld_exp_empty);
 
-	dequeue_task(current, array);
-	enqueue_task(current, target);
+	dequeue_task(current, rq);
+	current->slice = slice(current);
+	current->time_slice = RR_INTERVAL();
+	if (likely(!rt_task(current))) {
+		current->flags |= PF_YIELDED;
+		current->prio = MAX_PRIO - 1;
+	}
+	current->burst = 0;
+	enqueue_task(current, rq);
 
 	/*
 	 * Since we are going to call schedule() anyway, there's
@@ -3588,7 +3237,7 @@ long sys_sched_rr_get_interval(pid_t pid
 		goto out_unlock;
 
 	jiffies_to_timespec(p->policy & SCHED_FIFO ?
-				0 : task_timeslice(p), &t);
+				0 : slice(p), &t);
 	read_unlock(&tasklist_lock);
 	retval = copy_to_user(interval, &t, sizeof(t)) ? -EFAULT : 0;
 out_nounlock:
@@ -3701,11 +3350,9 @@ void __devinit init_idle(task_t *idle, i
 	runqueue_t *rq = cpu_rq(cpu);
 	unsigned long flags;
 
-	idle->sleep_avg = 0;
-	idle->interactive_credit = 0;
-	idle->array = NULL;
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
+	idle->burst = 0;
 	set_task_cpu(idle, cpu);
 
 	spin_lock_irqsave(&rq->lock, flags);
@@ -3819,7 +3466,7 @@ static void __migrate_task(struct task_s
 		goto out;
 
 	set_task_cpu(p, dest_cpu);
-	if (p->array) {
+	if (task_queued(p)) {
 		/*
 		 * Sync timestamp with rq_dest's before activating.
 		 * The same thing could be achieved by doing this step
@@ -3830,7 +3477,7 @@ static void __migrate_task(struct task_s
 				+ rq_dest->timestamp_last_tick;
 		deactivate_task(p, rq_src);
 		activate_task(p, rq_dest, 0);
-		if (TASK_PREEMPTS_CURR(p, rq_dest))
+		if (task_preempts_curr(p, rq_dest))
 			resched_task(rq_dest->curr);
 	}
 
@@ -4487,7 +4134,7 @@ int in_sched_functions(unsigned long add
 void __init sched_init(void)
 {
 	runqueue_t *rq;
-	int i, j, k;
+	int i, j;
 
 #ifdef CONFIG_SMP
 	/* Set up an initial dummy domain for early boot */
@@ -4505,16 +4152,16 @@ void __init sched_init(void)
 	sched_group_init.cpumask = CPU_MASK_ALL;
 	sched_group_init.next = &sched_group_init;
 	sched_group_init.cpu_power = SCHED_LOAD_SCALE;
+
+	cache_delay = cache_decay_ticks * 5;
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
@@ -4525,16 +4172,13 @@ void __init sched_init(void)
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
+		/*
+		 * delimiter for bitsearch
+		 */
+		__set_bit(MAX_PRIO, rq->bitmap);
 	}
 
 	/*
diff -rupN linux-2.6.8-rc3-mm1x/kernel/sysctl.c linux-2.6.8-rc3-mm1x-A/kernel/sysctl.c
--- linux-2.6.8-rc3-mm1x/kernel/sysctl.c	Thu Aug  5 15:00:45 2004
+++ linux-2.6.8-rc3-mm1x-A/kernel/sysctl.c	Thu Aug  5 15:09:30 2004
@@ -932,6 +932,22 @@ static ctl_table fs_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= KERN_INTERACTIVE,
+		.procname	= "interactive",
+		.data		= &sched_interactive,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_COMPUTE,
+		.procname	= "compute",
+		.data		= &sched_compute,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 
--==_Exmh_352894620--


