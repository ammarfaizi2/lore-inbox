Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVKINks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVKINks (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 08:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVKINks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 08:40:48 -0500
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:6105 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750754AbVKINkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 08:40:47 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Staircase cpu scheduler v13
Date: Thu, 10 Nov 2005 00:40:35 +1100
User-Agent: KMail/1.8.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3991322.Rrb8fSSz5k";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511100040.37788.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3991322.Rrb8fSSz5k
Content-Type: multipart/mixed;
  boundary="Boundary-01=_UxfcDEZKQs7HSzd"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_UxfcDEZKQs7HSzd
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Brief summary:

A complete cpu process scheduler policy rewrite based on the current O(1)=20
scheduler.

It uses a single priority array in a modified foreground-background design.

Each task starts at a dynamic priority dependant initially on the nice leve=
l=20
it is started at and then drops by one dynamic priority after one round-rob=
in=20
interval (currently set to 5ms). Once it reaches lowest dynamic priority an=
d=20
completes an RR there it is elevated back to its best dynamic prority.



The problem till now in current scheduler policies - nice was a determinant=
 of=20
cpu% and hard intrinsic latency. There was no way relatively niced tasks=20
could get low latency no matter how little cpu they used in the presence of=
 a=20
less niced task.


Changes in staircase v13

Based on the percentage of time sleeping compared to the time running (and=
=20
therefore the %cpu) accurately measured with the tsc clock in nanosecond=20
resolution, the highest dynamic priority is determined.=20

Any nice level can run at every possible internal dynamic priority from 0 t=
o=20
39.=20

Nice -20 tasks always start at 0 and drop by one every rr interval till the=
y=20
reach 39.=20

Nice 0 tasks start initially at dynamic priority 20 and drop till they reac=
h=20
39. If they use less than 50% cpu (sleep 40 vs 20) they can start at dynami=
c=20
priority 0

Nice 19 tasks start at 39. If they use less than 2.5% cpu (sleep 40 vs 1) t=
hen=20
can start at dynamic priority 0.


Latest patch available here:
http://ck.kolivas.org/patches/staircase

and attached below is a full patch against 2.6.14.

Cheers,
Con

--Boundary-01=_UxfcDEZKQs7HSzd
Content-Type: text/x-diff;
  charset="utf-8";
  name="sched-staircase13.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="sched-staircase13.patch"

 fs/proc/array.c        |    4
 include/linux/sched.h  |   14
 include/linux/sysctl.h |    2
 kernel/exit.c          |    1
 kernel/sched.c         | 1005 +++++++++++++++++++-------------------------=
=2D----
 kernel/sysctl.c        |   16
 6 files changed, 425 insertions(+), 617 deletions(-)

Index: linux-2.6.14-s13/fs/proc/array.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.14-s13.orig/fs/proc/array.c	2005-10-28 20:22:00.000000000 +=
1000
+++ linux-2.6.14-s13/fs/proc/array.c	2005-11-09 23:58:01.000000000 +1100
@@ -165,7 +165,7 @@ static inline char * task_state(struct t
 	read_lock(&tasklist_lock);
 	buffer +=3D sprintf(buffer,
 		"State:\t%s\n"
=2D		"SleepAVG:\t%lu%%\n"
+		"Bonus:\t%d\n"
 		"Tgid:\t%d\n"
 		"Pid:\t%d\n"
 		"PPid:\t%d\n"
@@ -173,7 +173,7 @@ static inline char * task_state(struct t
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
=2D		(p->sleep_avg/1024)*100/(1020000000/1024),
+		p->bonus,
 	       	p->tgid,
 		p->pid, pid_alive(p) ? p->group_leader->real_parent->tgid : 0,
 		pid_alive(p) && p->ptrace ? p->parent->pid : 0,
Index: linux-2.6.14-s13/include/linux/sched.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.14-s13.orig/include/linux/sched.h	2005-10-28 20:22:02.00000=
0000 +1000
+++ linux-2.6.14-s13/include/linux/sched.h	2005-11-09 23:58:01.000000000 +1=
100
@@ -196,6 +196,7 @@ extern void show_stack(struct task_struc
=20
 void io_schedule(void);
 long io_schedule_timeout(long timeout);
+extern int sched_interactive, sched_compute;
=20
 extern void cpu_init (void);
 extern void trap_init(void);
@@ -478,7 +479,6 @@ extern struct user_struct *find_user(uid
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
=20
=2Dtypedef struct prio_array prio_array_t;
 struct backing_dev_info;
 struct reclaim_state;
=20
@@ -653,18 +653,17 @@ struct task_struct {
 #endif
 	int prio, static_prio;
 	struct list_head run_list;
=2D	prio_array_t *array;
=20
 	unsigned short ioprio;
=20
=2D	unsigned long sleep_avg;
=2D	unsigned long long timestamp, last_ran;
+	unsigned long long timestamp;
+	unsigned long runtime, totalrun, ns_debit;
+	unsigned int bonus;
+	unsigned int slice, time_slice;
 	unsigned long long sched_time; /* sched_clock time spent running */
=2D	int activated;
=20
 	unsigned long policy;
 	cpumask_t cpus_allowed;
=2D	unsigned int time_slice, first_time_slice;
=20
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
@@ -864,6 +863,8 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
+#define PF_NONSLEEP	0x01000000	/* Waiting on in kernel activity */
+#define PF_YIELDED	0x02000000	/* I have just yielded */
=20
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
@@ -985,7 +986,6 @@ extern void FASTCALL(wake_up_new_task(st
  static inline void kick_process(struct task_struct *tsk) { }
 #endif
 extern void FASTCALL(sched_fork(task_t * p, int clone_flags));
=2Dextern void FASTCALL(sched_exit(task_t * p));
=20
 extern int in_group_p(gid_t);
 extern int in_egroup_p(gid_t);
Index: linux-2.6.14-s13/include/linux/sysctl.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.14-s13.orig/include/linux/sysctl.h	2005-10-28 20:22:02.0000=
00000 +1000
+++ linux-2.6.14-s13/include/linux/sysctl.h	2005-11-09 23:57:56.000000000 +=
1100
@@ -146,6 +146,8 @@ enum
 	KERN_RANDOMIZE=3D68, /* int: randomize virtual address space */
 	KERN_SETUID_DUMPABLE=3D69, /* int: behaviour of dumps for setuid core */
 	KERN_SPIN_RETRY=3D70,	/* int: number of spinlock retries */
+	KERN_INTERACTIVE=3D71,	/* interactive tasks can have cpu bursts */
+	KERN_COMPUTE=3D72,	/* adjust timeslices for a compute server */
 };
=20
=20
Index: linux-2.6.14-s13/kernel/exit.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.14-s13.orig/kernel/exit.c	2005-10-28 20:22:02.000000000 +10=
00
+++ linux-2.6.14-s13/kernel/exit.c	2005-11-09 23:57:56.000000000 +1100
@@ -100,7 +100,6 @@ repeat:=20
 		zap_leader =3D (leader->exit_signal =3D=3D -1);
 	}
=20
=2D	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
 	proc_pid_flush(proc_dentry);
Index: linux-2.6.14-s13/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.14-s13.orig/kernel/sched.c	2005-10-28 20:22:02.000000000 +1=
000
+++ linux-2.6.14-s13/kernel/sched.c	2005-11-09 23:59:17.000000000 +1100
@@ -16,6 +16,9 @@
  *		by Davide Libenzi, preemptible kernel bits by Robert Love.
  *  2003-09-03	Interactivity tuning by Con Kolivas.
  *  2004-04-02	Scheduler domains code by Nick Piggin
+ *  2005-11-08	New staircase scheduling policy by Con Kolivas with help
+ *		from William Lee Irwin III, Zwane Mwaikambo & Peter Williams.
+ *		Staircase v13
  */
=20
 #include <linux/mm.h>
@@ -74,122 +77,30 @@
  */
 #define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
 #define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
=2D
=2D/*
=2D * These are the 'tuning knobs' of the scheduler:
=2D *
=2D * Minimum timeslice is 5 msecs (or 1 jiffy, whichever is larger),
=2D * default timeslice is 100 msecs, maximum timeslice is 800 msecs.
=2D * Timeslices get refilled after they expire.
=2D */
=2D#define MIN_TIMESLICE		max(5 * HZ / 1000, 1)
=2D#define DEF_TIMESLICE		(100 * HZ / 1000)
=2D#define ON_RUNQUEUE_WEIGHT	 30
=2D#define CHILD_PENALTY		 95
=2D#define PARENT_PENALTY		100
=2D#define EXIT_WEIGHT		  3
=2D#define PRIO_BONUS_RATIO	 25
=2D#define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
=2D#define INTERACTIVE_DELTA	  2
=2D#define MAX_SLEEP_AVG		(DEF_TIMESLICE * MAX_BONUS)
=2D#define STARVATION_LIMIT	(MAX_SLEEP_AVG)
=2D#define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
=2D
=2D/*
=2D * If a task is 'interactive' then we reinsert it in the active
=2D * array after it has expired its current timeslice. (it will not
=2D * continue to run immediately, it will still roundrobin with
=2D * other interactive tasks.)
=2D *
=2D * This part scales the interactivity limit depending on niceness.
=2D *
=2D * We scale it linearly, offset by the INTERACTIVE_DELTA delta.
=2D * Here are a few examples of different nice levels:
=2D *
=2D *  TASK_INTERACTIVE(-20): [1,1,1,1,1,1,1,1,1,0,0]
=2D *  TASK_INTERACTIVE(-10): [1,1,1,1,1,1,1,0,0,0,0]
=2D *  TASK_INTERACTIVE(  0): [1,1,1,1,0,0,0,0,0,0,0]
=2D *  TASK_INTERACTIVE( 10): [1,1,0,0,0,0,0,0,0,0,0]
=2D *  TASK_INTERACTIVE( 19): [0,0,0,0,0,0,0,0,0,0,0]
=2D *
=2D * (the X axis represents the possible -5 ... 0 ... +5 dynamic
=2D *  priority range a task can explore, a value of '1' means the
=2D *  task is rated interactive.)
=2D *
=2D * Ie. nice +19 tasks can never get 'interactive' enough to be
=2D * reinserted into the active array. And only heavily CPU-hog nice -20
=2D * tasks will be expired. Default nice 0 tasks are somewhere between,
=2D * it takes some effort for them to get interactive, but it's not
=2D * too hard.
=2D */
=2D
=2D#define CURRENT_BONUS(p) \
=2D	(NS_TO_JIFFIES((p)->sleep_avg) * MAX_BONUS / \
=2D		MAX_SLEEP_AVG)
=2D
=2D#define GRANULARITY	(10 * HZ / 1000 ? : 1)
=2D
=2D#ifdef CONFIG_SMP
=2D#define TIMESLICE_GRANULARITY(p)	(GRANULARITY * \
=2D		(1 << (((MAX_BONUS - CURRENT_BONUS(p)) ? : 1) - 1)) * \
=2D			num_online_cpus())
=2D#else
=2D#define TIMESLICE_GRANULARITY(p)	(GRANULARITY * \
=2D		(1 << (((MAX_BONUS - CURRENT_BONUS(p)) ? : 1) - 1)))
=2D#endif
=2D
=2D#define SCALE(v1,v1_max,v2_max) \
=2D	(v1) * (v2_max) / (v1_max)
=2D
=2D#define DELTA(p) \
=2D	(SCALE(TASK_NICE(p), 40, MAX_BONUS) + INTERACTIVE_DELTA)
=2D
=2D#define TASK_INTERACTIVE(p) \
=2D	((p)->prio <=3D (p)->static_prio - DELTA(p))
=2D
=2D#define INTERACTIVE_SLEEP(p) \
=2D	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
=2D		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
+#define NSJIFFY			(1000000000 / HZ)	/* One jiffy in ns */
=20
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
=20
=2D/*
=2D * task_timeslice() scales user-nice values [ -20 ... 0 ... 19 ]
=2D * to time slice values: [800ms ... 100ms ... 5ms]
=2D *
=2D * The higher a thread's priority, the bigger timeslices
=2D * it gets during one round of execution. But even the lowest
=2D * priority thread gets MIN_TIMESLICE worth of execution time.
=2D */
=2D
=2D#define SCALE_PRIO(x, prio) \
=2D	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO/2), MIN_TIMESLICE)
+int sched_compute =3D 0;
+/*=20
+ *This is the time all tasks within the same priority round robin.
+ *compute setting is reserved for dedicated computational scheduling
+ *and has twenty times larger intervals. Set to a minimum of 5ms.
+ */
+#define _RR_INTERVAL		((5 * HZ / 1001) + 1)
+#define RR_INTERVAL()		(_RR_INTERVAL * (1 + 19 * sched_compute))
+#define DEF_TIMESLICE		(RR_INTERVAL() * 19)
=20
=2Dstatic unsigned int task_timeslice(task_t *p)
=2D{
=2D	if (p->static_prio < NICE_TO_PRIO(0))
=2D		return SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
=2D	else
=2D		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
=2D}
=2D#define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
+#define task_hot(p, now, sd) ((long long) ((now) - (p)->timestamp)	\
 				< (long long) (sd)->cache_hot_time)
=20
 /*
  * These are the runqueue data structures:
  */
=20
=2D#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
=2D
 typedef struct runqueue runqueue_t;
=20
=2Dstruct prio_array {
=2D	unsigned int nr_active;
=2D	unsigned long bitmap[BITMAP_SIZE];
=2D	struct list_head queue[MAX_PRIO];
=2D};
=2D
 /*
  * This is the main, per-CPU runqueue data structure.
  *
@@ -218,12 +129,12 @@ struct runqueue {
 	 */
 	unsigned long nr_uninterruptible;
=20
=2D	unsigned long expired_timestamp;
 	unsigned long long timestamp_last_tick;
+	unsigned int cache_ticks, preempted;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
=2D	prio_array_t *active, *expired, arrays[2];
=2D	int best_expired_prio;
+	unsigned long bitmap[BITS_TO_LONGS(MAX_PRIO + 1)];
+	struct list_head queue[MAX_PRIO];
 	atomic_t nr_iowait;
=20
 #ifdef CONFIG_SMP
@@ -592,79 +503,67 @@ static inline void sched_info_switch(tas
 #endif /* CONFIG_SCHEDSTATS */
=20
 /*
=2D * Adding/removing a task to/from a priority array:
+ * Get nanosecond clock difference without overflowing unsigned long.
  */
=2Dstatic void dequeue_task(struct task_struct *p, prio_array_t *array)
+static inline unsigned long ns_diff(unsigned long long v1, unsigned long l=
ong v2)
 {
=2D	array->nr_active--;
=2D	list_del(&p->run_list);
=2D	if (list_empty(array->queue + p->prio))
=2D		__clear_bit(p->prio, array->bitmap);
+	unsigned long long vdiff;
+	if (likely(v1 > v2)) {
+		vdiff =3D v1 - v2;
+		if (vdiff > (1 << 31))
+			vdiff =3D 1 << 31;
+	} else
+		/*
+		 * Rarely the clock appears to go backwards. There should
+		 * always be a positive difference so return 1.
+		 */
+		vdiff =3D 1;
+	return (unsigned long)vdiff;
 }
=20
=2Dstatic void enqueue_task(struct task_struct *p, prio_array_t *array)
+static inline int task_queued(task_t *task)
 {
=2D	sched_info_queued(p);
=2D	list_add_tail(&p->run_list, array->queue + p->prio);
=2D	__set_bit(p->prio, array->bitmap);
=2D	array->nr_active++;
=2D	p->array =3D array;
+	return !list_empty(&task->run_list);
 }
=20
 /*
=2D * Put task to the end of the run list without the overhead of dequeue
=2D * followed by enqueue.
+ * Adding/removing a task to/from a runqueue:
  */
=2Dstatic void requeue_task(struct task_struct *p, prio_array_t *array)
+static inline void dequeue_task(struct task_struct *p, runqueue_t *rq)
 {
=2D	list_move_tail(&p->run_list, array->queue + p->prio);
+	list_del_init(&p->run_list);
+	if (list_empty(rq->queue + p->prio))
+		__clear_bit(p->prio, rq->bitmap);
+	p->ns_debit =3D 0;
 }
=20
=2Dstatic inline void enqueue_task_head(struct task_struct *p, prio_array_t=
 *array)
+static void enqueue_task(struct task_struct *p, runqueue_t *rq)
 {
=2D	list_add(&p->run_list, array->queue + p->prio);
=2D	__set_bit(p->prio, array->bitmap);
=2D	array->nr_active++;
=2D	p->array =3D array;
+	list_add_tail(&p->run_list, rq->queue + p->prio);
+	__set_bit(p->prio, rq->bitmap);
 }
=20
 /*
=2D * effective_prio - return the priority that is based on the static
=2D * priority but is modified by bonuses/penalties.
=2D *
=2D * We scale the actual sleep average [0 .... MAX_SLEEP_AVG]
=2D * into the -5 ... 0 ... +5 bonus/penalty range.
=2D *
=2D * We use 25% of the full 0...39 priority range so that:
=2D *
=2D * 1) nice +19 interactive tasks do not preempt nice 0 CPU hogs.
=2D * 2) nice -20 CPU hogs do not get preempted by nice 0 tasks.
=2D *
=2D * Both properties are important to certain workloads.
+ * Put task to the end of the run list without the overhead of dequeue
+ * followed by enqueue.
  */
=2Dstatic int effective_prio(task_t *p)
+static inline void requeue_task(struct task_struct *p, runqueue_t *rq)
 {
=2D	int bonus, prio;
=2D
=2D	if (rt_task(p))
=2D		return p->prio;
=2D
=2D	bonus =3D CURRENT_BONUS(p) - MAX_BONUS / 2;
+	list_move_tail(&p->run_list, rq->queue + p->prio);
+}
=20
=2D	prio =3D p->static_prio - bonus;
=2D	if (prio < MAX_RT_PRIO)
=2D		prio =3D MAX_RT_PRIO;
=2D	if (prio > MAX_PRIO-1)
=2D		prio =3D MAX_PRIO-1;
=2D	return prio;
+static inline void enqueue_task_head(struct task_struct *p, runqueue_t *rq)
+{
+	list_add(&p->run_list, rq->queue + p->prio);
+	__set_bit(p->prio, rq->bitmap);
 }
=20
 /*
  * __activate_task - move a task to the runqueue.
  */
=2Dstatic inline void __activate_task(task_t *p, runqueue_t *rq)
+static void __activate_task(task_t *p, runqueue_t *rq)
 {
=2D	enqueue_task(p, rq->active);
+	enqueue_task(p, rq);
 	rq->nr_running++;
 }
=20
@@ -673,70 +572,169 @@ static inline void __activate_task(task_
  */
 static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
 {
=2D	enqueue_task_head(p, rq->active);
+	enqueue_task_head(p, rq);
 	rq->nr_running++;
 }
=20
=2Dstatic int recalc_task_prio(task_t *p, unsigned long long now)
+/*
+ * Bonus - How much higher than its base priority an interactive task can =
run.
+ */
+static inline unsigned int bonus(task_t *p)
 {
=2D	/* Caller must always ensure 'now >=3D p->timestamp' */
=2D	unsigned long long __sleep_time =3D now - p->timestamp;
=2D	unsigned long sleep_time;
+	return TASK_USER_PRIO(p);
+}
=20
=2D	if (__sleep_time > NS_MAX_SLEEP_AVG)
=2D		sleep_time =3D NS_MAX_SLEEP_AVG;
=2D	else
=2D		sleep_time =3D (unsigned long)__sleep_time;
+static inline unsigned int rr_interval(task_t * p)
+{
+	unsigned int rr_interval =3D RR_INTERVAL();
+	int nice =3D TASK_NICE(p);
=20
=2D	if (likely(sleep_time > 0)) {
=2D		/*
=2D		 * User tasks that sleep a long time are categorised as
=2D		 * idle and will get just interactive status to stay active &
=2D		 * prevent them suddenly becoming cpu hogs and starving
=2D		 * other processes.
=2D		 */
=2D		if (p->mm && p->activated !=3D -1 &&
=2D			sleep_time > INTERACTIVE_SLEEP(p)) {
=2D				p->sleep_avg =3D JIFFIES_TO_NS(MAX_SLEEP_AVG -
=2D						DEF_TIMESLICE);
=2D		} else {
=2D			/*
=2D			 * The lower the sleep avg a task has the more
=2D			 * rapidly it will rise with sleep time.
=2D			 */
=2D			sleep_time *=3D (MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
+	if (nice < 0 && !rt_task(p))
+		rr_interval +=3D -(nice);
+	return rr_interval;
+}
=20
=2D			/*
=2D			 * Tasks waking from uninterruptible sleep are
=2D			 * limited in their sleep_avg rise as they
=2D			 * are likely to be waiting on I/O
=2D			 */
=2D			if (p->activated =3D=3D -1 && p->mm) {
=2D				if (p->sleep_avg >=3D INTERACTIVE_SLEEP(p))
=2D					sleep_time =3D 0;
=2D				else if (p->sleep_avg + sleep_time >=3D
=2D						INTERACTIVE_SLEEP(p)) {
=2D					p->sleep_avg =3D INTERACTIVE_SLEEP(p);
=2D					sleep_time =3D 0;
=2D				}
=2D			}
+/*
+ * slice - the duration a task runs before getting requeued at its best
+ * priority and has its bonus decremented.
+ */
+static inline unsigned int slice(task_t *p)
+{
+	unsigned int slice, rr;
=20
=2D			/*
=2D			 * This code gives a bonus to interactive tasks.
=2D			 *
=2D			 * The boost works by updating the 'average sleep time'
=2D			 * value here, based on ->timestamp. The more time a
=2D			 * task spends sleeping, the higher the average gets -
=2D			 * and the higher the priority boost gets as well.
=2D			 */
=2D			p->sleep_avg +=3D sleep_time;
+	slice =3D rr =3D rr_interval(p);
+	if (likely(!rt_task(p)))
+		slice +=3D (39 - TASK_USER_PRIO(p)) * rr;
+	return slice;
+}
=20
=2D			if (p->sleep_avg > NS_MAX_SLEEP_AVG)
=2D				p->sleep_avg =3D NS_MAX_SLEEP_AVG;
=2D		}
+/*
+ * We increase our bonus by sleeping more than the time we ran.
+ * The ratio of sleep to run gives us the cpu% that we last ran and determ=
ines
+ * the maximum bonus we can acquire.
+ */
+static void inc_bonus(task_t *p, unsigned long totalrun, unsigned long sle=
ep)
+{
+	unsigned int best_bonus;
+
+	best_bonus =3D sleep / (totalrun + 1);
+	if (p->bonus >=3D best_bonus)
+		return;
+
+	p->bonus++;
+	best_bonus =3D bonus(p);
+	if (p->bonus > best_bonus)
+		p->bonus =3D best_bonus;
+}
+
+static void dec_bonus(task_t *p)
+{
+	if (p->bonus)
+		p->bonus--;
+}
+
+/*
+ * sched_interactive - sysctl which allows interactive tasks to have bonus
+ * raise its priority.
+ */
+int sched_interactive =3D 1;
+
+/*
+ * effective_prio - dynamic priority dependent on bonus.
+ * The priority normally decreases by one each RR_INTERVAL.
+ * As the bonus increases the initial priority starts at a higher "stair" =
or
+ * priority for longer.
+ */
+static int effective_prio(task_t *p)
+{
+	int prio;
+	unsigned int full_slice, used_slice =3D 0;
+	unsigned int best_bonus, rr;
+
+	if (rt_task(p))
+		return p->prio;
+
+	full_slice =3D slice(p);
+	if (full_slice > p->slice)
+		used_slice =3D full_slice - p->slice;
+
+	best_bonus =3D bonus(p);
+	prio =3D MAX_RT_PRIO + best_bonus;
+	if (sched_interactive && !sched_compute)
+		prio -=3D p->bonus;
+
+	rr =3D rr_interval(p);
+	prio +=3D used_slice / rr;
+	if (prio >=3D MAX_PRIO - 1)
+		prio =3D MAX_PRIO - 1;
+	return prio;
+}
+
+static void continue_slice(task_t *p)
+{
+	unsigned long total_run =3D NS_TO_JIFFIES(p->totalrun);
+
+	if (total_run >=3D p->slice) {
+		p->totalrun -=3D JIFFIES_TO_NS(p->slice);
+		dec_bonus(p);
+	} else {
+		unsigned int remainder;
+		p->slice -=3D total_run;
+		remainder =3D p->slice % rr_interval(p);
+		if (remainder)
+			p->time_slice =3D remainder;
+	}
+}
+
+/*
+ * recalc_task_prio - this checks for tasks that run ultra short timeslices
+ * or have just forked a thread/process and make them continue their old
+ * slice instead of starting a new one at high priority.
+ */
+static inline void recalc_task_prio(task_t *p, unsigned long long now,
+	unsigned long rq_running)
+{
+	unsigned long sleep_time =3D ns_diff(now, p->timestamp);
+
+	/*
+	 * Priority is elevated back to best by amount of sleep_time.
+	 */
+
+	p->totalrun +=3D p->runtime;
+	if (NS_TO_JIFFIES(p->totalrun) >=3D p->slice &&
+		NS_TO_JIFFIES(sleep_time) < p->slice) {
+			p->flags &=3D ~PF_NONSLEEP;
+			dec_bonus(p);
+			p->totalrun -=3D JIFFIES_TO_NS(p->slice);
+			if (sleep_time > p->totalrun)
+				p->totalrun =3D 0;
+			else
+				p->totalrun -=3D sleep_time;
+			goto out;
+	}
+
+	if (p->flags & PF_NONSLEEP) {
+		continue_slice(p);
+		p->flags &=3D ~PF_NONSLEEP;
+		goto out;
 	}
=20
=2D	return effective_prio(p);
+	if (sched_compute) {
+		continue_slice(p);
+		goto out;
+	}
+
+	if (sleep_time >=3D p->totalrun) {
+		if (!(p->flags & PF_NONSLEEP))
+			inc_bonus(p, p->totalrun, sleep_time);
+		p->totalrun =3D 0;
+		goto out;
+	}
+
+	p->totalrun -=3D sleep_time;
+	continue_slice(p);
+out:
+	return;
 }
=20
 /*
@@ -747,9 +745,9 @@ static int recalc_task_prio(task_t *p, u
  */
 static void activate_task(task_t *p, runqueue_t *rq, int local)
 {
=2D	unsigned long long now;
+	unsigned long long now =3D sched_clock();
+	unsigned long rr =3D rr_interval(p);
=20
=2D	now =3D sched_clock();
 #ifdef CONFIG_SMP
 	if (!local) {
 		/* Compensate for drifting sched_clock */
@@ -758,44 +756,22 @@ static void activate_task(task_t *p, run
 			+ rq->timestamp_last_tick;
 	}
 #endif
=2D
=2D	p->prio =3D recalc_task_prio(p, now);
=2D
=2D	/*
=2D	 * This checks to make sure it's not an uninterruptible task
=2D	 * that is now waking up.
=2D	 */
=2D	if (!p->activated) {
=2D		/*
=2D		 * Tasks which were woken up by interrupts (ie. hw events)
=2D		 * are most likely of interactive nature. So we give them
=2D		 * the credit of extending their sleep time to the period
=2D		 * of time they spend on the runqueue, waiting for execution
=2D		 * on a CPU, first time around:
=2D		 */
=2D		if (in_interrupt())
=2D			p->activated =3D 2;
=2D		else {
=2D			/*
=2D			 * Normal first-time wakeups get a credit too for
=2D			 * on-runqueue time, but it will be weighted down:
=2D			 */
=2D			p->activated =3D 1;
=2D		}
=2D	}
+	p->slice =3D slice(p);
+	p->time_slice =3D p->slice % rr ? : rr;
+	recalc_task_prio(p, now, rq->nr_running);
+	p->flags &=3D ~PF_NONSLEEP;
+	p->prio =3D effective_prio(p);
 	p->timestamp =3D now;
=2D
 	__activate_task(p, rq);
 }
=20
 /*
  * deactivate_task - remove a task from the runqueue.
  */
=2Dstatic void deactivate_task(struct task_struct *p, runqueue_t *rq)
+static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
 	rq->nr_running--;
=2D	dequeue_task(p, p->array);
=2D	p->array =3D NULL;
+	dequeue_task(p, rq);
 }
=20
 /*
@@ -858,7 +834,7 @@ static int migrate_task(task_t *p, int d
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
 	 */
=2D	if (!p->array && !task_running(rq, p)) {
+	if (!task_queued(p) && !task_running(rq, p)) {
 		set_task_cpu(p, dest_cpu);
 		return 0;
 	}
@@ -888,7 +864,7 @@ void wait_task_inactive(task_t *p)
 repeat:
 	rq =3D task_rq_lock(p, &flags);
 	/* Must be off runqueue entirely, not preempted. */
=2D	if (unlikely(p->array || task_running(rq, p))) {
+	if (unlikely(task_queued(p) || task_running(rq, p))) {
 		/* If it's preempted, we yield.  It could be a while. */
 		preempted =3D !task_running(rq, p);
 		task_rq_unlock(rq, &flags);
@@ -957,7 +933,7 @@ static inline unsigned long target_load(
  * find_idlest_group finds and returns the least busy CPU group within the
  * domain.
  */
=2Dstatic struct sched_group *
+static inline struct sched_group *
 find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this=
_cpu)
 {
 	struct sched_group *idlest =3D NULL, *this =3D NULL, *group =3D sd->group=
s;
@@ -1097,7 +1073,7 @@ nextlevel:
  * Returns the CPU we should wake onto.
  */
 #if defined(ARCH_HAS_SCHED_WAKE_IDLE)
=2Dstatic int wake_idle(int cpu, task_t *p)
+static inline int wake_idle(int cpu, task_t *p)
 {
 	cpumask_t tmp;
 	struct sched_domain *sd;
@@ -1126,6 +1102,26 @@ static inline int wake_idle(int cpu, tas
 }
 #endif
=20
+/*
+ * cache_delay is the time preemption is delayed in sched_compute mode
+ * and is set to a nominal 10ms.
+ */
+static int cache_delay =3D 10 * HZ / 1001 + 1;
+
+/*
+ * Check to see if p preempts rq->curr and resched if it does. In compute
+ * mode we do not preempt for at least cache_delay and set rq->preempted.
+ */
+static void preempt(task_t *p, runqueue_t *rq)
+{
+	if (p->prio >=3D rq->curr->prio)
+		return;
+	if (!sched_compute || rq->cache_ticks >=3D cache_delay ||
+		!p->mm || rt_task(p))
+			resched_task(rq->curr);
+	rq->preempted =3D 1;
+}
+
 /***
  * try_to_wake_up - wake up a thread
  * @p: the to-be-woken-up thread
@@ -1157,7 +1153,7 @@ static int try_to_wake_up(task_t *p, uns
 	if (!(old_state & state))
 		goto out;
=20
=2D	if (p->array)
+	if (task_queued(p))
 		goto out_running;
=20
 	cpu =3D task_cpu(p);
@@ -1246,7 +1242,7 @@ out_set_cpu:
 		old_state =3D p->state;
 		if (!(old_state & state))
 			goto out;
=2D		if (p->array)
+		if (task_queued(p))
 			goto out_running;
=20
 		this_cpu =3D smp_processor_id();
@@ -1255,25 +1251,16 @@ out_set_cpu:
=20
 out_activate:
 #endif /* CONFIG_SMP */
=2D	if (old_state =3D=3D TASK_UNINTERRUPTIBLE) {
+	if (old_state =3D=3D TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible--;
=2D		/*
=2D		 * Tasks on involuntary sleep don't earn
=2D		 * sleep_avg beyond just interactive state.
=2D		 */
=2D		p->activated =3D -1;
=2D	}
=20
 	/*
 	 * Tasks that have marked their sleep as noninteractive get
=2D	 * woken up without updating their sleep average. (i.e. their
=2D	 * sleep is handled in a priority-neutral manner, no priority
=2D	 * boost and no penalty.)
+	 * woken up without their sleep counting.
 	 */
 	if (old_state & TASK_NONINTERACTIVE)
=2D		__activate_task(p, rq);
=2D	else
=2D		activate_task(p, rq, cpu =3D=3D this_cpu);
+		p->flags |=3D PF_NONSLEEP;
+
 	/*
 	 * Sync wakeups (i.e. those types of wakeups where the waker
 	 * has indicated that it will leave the CPU in short order)
@@ -1282,10 +1269,9 @@ out_activate:
 	 * the waker guarantees that the freshly woken up task is going
 	 * to be considered on this CPU.)
 	 */
=2D	if (!sync || cpu !=3D this_cpu) {
=2D		if (TASK_PREEMPTS_CURR(p, rq))
=2D			resched_task(rq->curr);
=2D	}
+	activate_task(p, rq, cpu =3D=3D this_cpu);
+	if (!sync || cpu !=3D this_cpu)
+		preempt(p, rq);
 	success =3D 1;
=20
 out_running:
@@ -1330,7 +1316,6 @@ void fastcall sched_fork(task_t *p, int=20
 	 */
 	p->state =3D TASK_RUNNING;
 	INIT_LIST_HEAD(&p->run_list);
=2D	p->array =3D NULL;
 #ifdef CONFIG_SCHEDSTATS
 	memset(&p->sched_info, 0, sizeof(p->sched_info));
 #endif
@@ -1341,30 +1326,6 @@ void fastcall sched_fork(task_t *p, int=20
 	/* Want to start with kernel preemption disabled. */
 	p->thread_info->preempt_count =3D 1;
 #endif
=2D	/*
=2D	 * Share the timeslice between parent and child, thus the
=2D	 * total amount of pending timeslices in the system doesn't change,
=2D	 * resulting in more scheduling fairness.
=2D	 */
=2D	local_irq_disable();
=2D	p->time_slice =3D (current->time_slice + 1) >> 1;
=2D	/*
=2D	 * The remainder of the first timeslice might be recovered by
=2D	 * the parent if the child exits early enough.
=2D	 */
=2D	p->first_time_slice =3D 1;
=2D	current->time_slice >>=3D 1;
=2D	p->timestamp =3D sched_clock();
=2D	if (unlikely(!current->time_slice)) {
=2D		/*
=2D		 * This case is rare, it happens when the parent has only
=2D		 * a single jiffy left from its timeslice. Taking the
=2D		 * runqueue lock is not a problem.
=2D		 */
=2D		current->time_slice =3D 1;
=2D		scheduler_tick();
=2D	}
=2D	local_irq_enable();
 	put_cpu();
 }
=20
@@ -1387,36 +1348,20 @@ void fastcall wake_up_new_task(task_t *p
 	cpu =3D task_cpu(p);
=20
 	/*
=2D	 * We decrease the sleep average of forking parents
=2D	 * and children as well, to keep max-interactive tasks
=2D	 * from forking tasks that are max-interactive. The parent
=2D	 * (current) is done further down, under its lock.
+	 * Forked process gets no bonus to prevent fork bombs.
 	 */
=2D	p->sleep_avg =3D JIFFIES_TO_NS(CURRENT_BONUS(p) *
=2D		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
=2D
=2D	p->prio =3D effective_prio(p);
+	p->bonus =3D 0;
=20
 	if (likely(cpu =3D=3D this_cpu)) {
=2D		if (!(clone_flags & CLONE_VM)) {
+		current->flags |=3D PF_NONSLEEP;
+		activate_task(p, rq, 1);
+		if (!(clone_flags & CLONE_VM))
 			/*
 			 * The VM isn't cloned, so we're in a good position to
 			 * do child-runs-first in anticipation of an exec. This
 			 * usually avoids a lot of COW overhead.
 			 */
=2D			if (unlikely(!current->array))
=2D				__activate_task(p, rq);
=2D			else {
=2D				p->prio =3D current->prio;
=2D				list_add_tail(&p->run_list, &current->run_list);
=2D				p->array =3D current->array;
=2D				p->array->nr_active++;
=2D				rq->nr_running++;
=2D			}
 			set_need_resched();
=2D		} else
=2D			/* Run child last */
=2D			__activate_task(p, rq);
 		/*
 		 * We skip the following code due to cpu =3D=3D this_cpu
 	 	 *
@@ -1433,53 +1378,20 @@ void fastcall wake_up_new_task(task_t *p
 		 */
 		p->timestamp =3D (p->timestamp - this_rq->timestamp_last_tick)
 					+ rq->timestamp_last_tick;
=2D		__activate_task(p, rq);
=2D		if (TASK_PREEMPTS_CURR(p, rq))
=2D			resched_task(rq->curr);
+		activate_task(p, rq, 0);
+		preempt(p, rq);
=20
 		/*
 		 * Parent and child are on different CPUs, now get the
=2D		 * parent runqueue to update the parent's ->sleep_avg:
+		 * parent runqueue to update the parent's ->flags:
 		 */
 		task_rq_unlock(rq, &flags);
 		this_rq =3D task_rq_lock(current, &flags);
+		current->flags |=3D PF_NONSLEEP;
 	}
=2D	current->sleep_avg =3D JIFFIES_TO_NS(CURRENT_BONUS(current) *
=2D		PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
 	task_rq_unlock(this_rq, &flags);
 }
=20
=2D/*
=2D * Potentially available exiting-child timeslices are
=2D * retrieved here - this way the parent does not get
=2D * penalized for creating too many threads.
=2D *
=2D * (this cannot be used to 'generate' timeslices
=2D * artificially, because any timeslice recovered here
=2D * was given away by the parent in the first place.)
=2D */
=2Dvoid fastcall sched_exit(task_t *p)
=2D{
=2D	unsigned long flags;
=2D	runqueue_t *rq;
=2D
=2D	/*
=2D	 * If the child was a (relative-) CPU hog then decrease
=2D	 * the sleep_avg of the parent as well.
=2D	 */
=2D	rq =3D task_rq_lock(p->parent, &flags);
=2D	if (p->first_time_slice) {
=2D		p->parent->time_slice +=3D p->time_slice;
=2D		if (unlikely(p->parent->time_slice > task_timeslice(p)))
=2D			p->parent->time_slice =3D task_timeslice(p);
=2D	}
=2D	if (p->sleep_avg < p->parent->sleep_avg)
=2D		p->parent->sleep_avg =3D p->parent->sleep_avg /
=2D		(EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg /
=2D		(EXIT_WEIGHT + 1);
=2D	task_rq_unlock(rq, &flags);
=2D}
=2D
 /**
  * prepare_task_switch - prepare to switch tasks
  * @rq: the runqueue preparing to switch
@@ -1708,7 +1620,7 @@ static void double_lock_balance(runqueue
  * allow dest_cpu, which will force the cpu onto dest_cpu.  Then
  * the cpu_allowed mask is restored.
  */
=2Dstatic void sched_migrate_task(task_t *p, int dest_cpu)
+static inline void sched_migrate_task(task_t *p, int dest_cpu)
 {
 	migration_req_t req;
 	runqueue_t *rq;
@@ -1751,32 +1663,28 @@ void sched_exec(void)
  * pull_task - move a task from a remote runqueue to the local runqueue.
  * Both runqueues must be locked.
  */
=2Dstatic inline
=2Dvoid pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p,
=2D	       runqueue_t *this_rq, prio_array_t *this_array, int this_cpu)
+static inline void pull_task(runqueue_t *src_rq, task_t *p,
+		runqueue_t *this_rq, int this_cpu)
 {
=2D	dequeue_task(p, src_array);
+	dequeue_task(p, src_rq);
 	src_rq->nr_running--;
 	set_task_cpu(p, this_cpu);
 	this_rq->nr_running++;
=2D	enqueue_task(p, this_array);
+	enqueue_task(p, this_rq);
 	p->timestamp =3D (p->timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
 	 */
=2D	if (TASK_PREEMPTS_CURR(p, this_rq))
=2D		resched_task(this_rq->curr);
+	preempt(p, this_rq);
 }
=20
+static inline int can_migrate_task(task_t *p, runqueue_t *rq, int this_cpu,
+		struct sched_domain *sd, enum idle_type idle, int *all_pinned)
 /*
  * can_migrate_task - may task p from runqueue rq be migrated to this_cpu?
  */
=2Dstatic inline
=2Dint can_migrate_task(task_t *p, runqueue_t *rq, int this_cpu,
=2D		     struct sched_domain *sd, enum idle_type idle,
=2D		     int *all_pinned)
 {
 	/*
 	 * We do not migrate tasks that are:
@@ -1813,10 +1721,9 @@ int can_migrate_task(task_t *p, runqueue
  * Called with both runqueues locked.
  */
 static int move_tasks(runqueue_t *this_rq, int this_cpu, runqueue_t *busie=
st,
=2D		      unsigned long max_nr_move, struct sched_domain *sd,
=2D		      enum idle_type idle, int *all_pinned)
+		unsigned long max_nr_move, struct sched_domain *sd,
+		enum idle_type idle, int *all_pinned)
 {
=2D	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
 	int idx, pulled =3D 0, pinned =3D 0;
 	task_t *tmp;
@@ -1826,38 +1733,17 @@ static int move_tasks(runqueue_t *this_r
=20
 	pinned =3D 1;
=20
=2D	/*
=2D	 * We first consider expired tasks. Those will likely not be
=2D	 * executed in the near future, and they are most likely to
=2D	 * be cache-cold, thus switching CPUs has the least effect
=2D	 * on them.
=2D	 */
=2D	if (busiest->expired->nr_active) {
=2D		array =3D busiest->expired;
=2D		dst_array =3D this_rq->expired;
=2D	} else {
=2D		array =3D busiest->active;
=2D		dst_array =3D this_rq->active;
=2D	}
=2D
=2Dnew_array:
 	/* Start searching at priority 0: */
 	idx =3D 0;
 skip_bitmap:
 	if (!idx)
=2D		idx =3D sched_find_first_bit(array->bitmap);
+		idx =3D sched_find_first_bit(busiest->bitmap);
 	else
=2D		idx =3D find_next_bit(array->bitmap, MAX_PRIO, idx);
=2D	if (idx >=3D MAX_PRIO) {
=2D		if (array =3D=3D busiest->expired && busiest->active->nr_active) {
=2D			array =3D busiest->active;
=2D			dst_array =3D this_rq->active;
=2D			goto new_array;
=2D		}
+		idx =3D find_next_bit(busiest->bitmap, MAX_PRIO, idx);
+	if (idx >=3D MAX_PRIO)=20
 		goto out;
=2D	}
=20
=2D	head =3D array->queue + idx;
+	head =3D busiest->queue + idx;
 	curr =3D head->prev;
 skip_queue:
 	tmp =3D list_entry(curr, task_t, run_list);
@@ -1876,7 +1762,7 @@ skip_queue:
 		schedstat_inc(sd, lb_hot_gained[idle]);
 #endif
=20
=2D	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
+	pull_task(busiest, tmp, this_rq, this_cpu);
 	pulled++;
=20
 	/* We only want to steal up to the prescribed number of tasks. */
@@ -2074,7 +1960,7 @@ static runqueue_t *find_busiest_queue(st
  *
  * Called with this_rq unlocked.
  */
=2Dstatic int load_balance(int this_cpu, runqueue_t *this_rq,
+static inline int load_balance(int this_cpu, runqueue_t *this_rq,
 			struct sched_domain *sd, enum idle_type idle)
 {
 	struct sched_group *group;
@@ -2199,7 +2085,7 @@ out_one_pinned:
  * Called from schedule when this_rq is about to become idle (NEWLY_IDLE).
  * this_rq is locked.
  */
=2Dstatic int load_balance_newidle(int this_cpu, runqueue_t *this_rq,
+static inline int load_balance_newidle(int this_cpu, runqueue_t *this_rq,
 				struct sched_domain *sd)
 {
 	struct sched_group *group;
@@ -2280,7 +2166,7 @@ static inline void idle_balance(int this
  *
  * Called with busiest_rq locked.
  */
=2Dstatic void active_load_balance(runqueue_t *busiest_rq, int busiest_cpu)
+static inline void active_load_balance(runqueue_t *busiest_rq, int busiest=
_cpu)
 {
 	struct sched_domain *sd;
 	runqueue_t *target_rq;
@@ -2364,15 +2250,13 @@ static void rebalance_tick(int this_cpu,
 			continue;
=20
 		interval =3D sd->balance_interval;
=2D		if (idle !=3D SCHED_IDLE)
=2D			interval *=3D sd->busy_factor;
=20
 		/* scale ms to jiffies */
 		interval =3D msecs_to_jiffies(interval);
 		if (unlikely(!interval))
 			interval =3D 1;
=20
=2D		if (j - sd->last_balance >=3D interval) {
+		if (idle !=3D SCHED_IDLE || j - sd->last_balance >=3D interval) {
 			if (load_balance(this_cpu, this_rq, sd, idle)) {
 				/*
 				 * We've pulled tasks over so either we're no
@@ -2446,22 +2330,6 @@ unsigned long long current_sched_time(co
 }
=20
 /*
=2D * We place interactive tasks back into the active array, if possible.
=2D *
=2D * To guarantee that this does not starve expired tasks we ignore the
=2D * interactivity of a task if the first expired task had to wait more
=2D * than a 'reasonable' amount of time. This deadline timeout is
=2D * load-dependent, as the frequency of array switched decreases with
=2D * increasing number of running tasks. We also ignore the interactivity
=2D * if a better static_prio task has expired:
=2D */
=2D#define EXPIRED_STARVING(rq) \
=2D	((STARVATION_LIMIT && ((rq)->expired_timestamp && \
=2D		(jiffies - (rq)->expired_timestamp >=3D \
=2D			STARVATION_LIMIT * ((rq)->nr_running) + 1))) || \
=2D			((rq)->curr->static_prio > (rq)->best_expired_prio))
=2D
=2D/*
  * Account user cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @hardirq_offset: the offset to subtract from hardirq_count()
@@ -2509,6 +2377,7 @@ void account_system_time(struct task_str
 		cpustat->iowait =3D cputime64_add(cpustat->iowait, tmp);
 	else
 		cpustat->idle =3D cputime64_add(cpustat->idle, tmp);
+
 	/* Account for system time used */
 	acct_update_integrals(p);
 	/* Update rss highwater mark */
@@ -2536,18 +2405,25 @@ void account_steal_time(struct task_stru
 		cpustat->steal =3D cputime64_add(cpustat->steal, tmp);
 }
=20
+static void time_slice_expired(task_t *p, runqueue_t *rq)
+{
+	set_tsk_need_resched(p);
+	dequeue_task(p, rq);
+	p->prio =3D effective_prio(p);
+	p->time_slice =3D rr_interval(p);
+	enqueue_task(p, rq);
+}
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
=2D *
=2D * It also gets called by the fork code, when changing the parent's
=2D * timeslices.
  */
 void scheduler_tick(void)
 {
 	int cpu =3D smp_processor_id();
 	runqueue_t *rq =3D this_rq();
 	task_t *p =3D current;
+	unsigned long debit, expired_balance =3D rq->nr_running;
 	unsigned long long now =3D sched_clock();
=20
 	update_cpu_clock(p, rq, now);
@@ -2562,78 +2438,53 @@ void scheduler_tick(void)
 	}
=20
 	/* Task might have expired already, but not scheduled off yet */
=2D	if (p->array !=3D rq->active) {
+	if (unlikely(!task_queued(p))) {
 		set_tsk_need_resched(p);
 		goto out;
 	}
=2D	spin_lock(&rq->lock);
 	/*
=2D	 * The task was running during this tick - update the
=2D	 * time slice counter. Note: we do not update a thread's
=2D	 * priority until it either goes to sleep or uses up its
=2D	 * timeslice. This makes it possible for interactive tasks
=2D	 * to use up their timeslices at their highest priority levels.
+	 * SCHED_FIFO tasks never run out of timeslice.
 	 */
=2D	if (rt_task(p)) {
=2D		/*
=2D		 * RR tasks need a special form of timeslice management.
=2D		 * FIFO tasks have no timeslices.
=2D		 */
=2D		if ((p->policy =3D=3D SCHED_RR) && !--p->time_slice) {
=2D			p->time_slice =3D task_timeslice(p);
=2D			p->first_time_slice =3D 0;
=2D			set_tsk_need_resched(p);
+	if (unlikely(p->policy =3D=3D SCHED_FIFO)) {
+		expired_balance =3D 0;
+		goto out;
+	}
=20
=2D			/* put it at the end of the queue: */
=2D			requeue_task(p, rq->active);
=2D		}
+	spin_lock(&rq->lock);
+	debit =3D ns_diff(rq->timestamp_last_tick, p->timestamp);
+	p->ns_debit +=3D debit;
+	if (p->ns_debit < NSJIFFY)
+		goto out_unlock;
+	p->ns_debit %=3D NSJIFFY;
+	/*
+	 * Tasks lose bonus each time they use up a full slice().
+	 */
+	if (!--p->slice) {
+		dec_bonus(p);
+		p->slice =3D slice(p);
+		time_slice_expired(p, rq);
+		p->totalrun =3D 0;
 		goto out_unlock;
 	}
+	/*
+	 * Tasks that run out of time_slice but still have slice left get
+	 * requeued with a lower priority && RR_INTERVAL time_slice.
+	 */
 	if (!--p->time_slice) {
=2D		dequeue_task(p, rq->active);
+		time_slice_expired(p, rq);
+		goto out_unlock;
+	}
+	rq->cache_ticks++;
+	if (rq->preempted && rq->cache_ticks >=3D cache_delay) {
 		set_tsk_need_resched(p);
=2D		p->prio =3D effective_prio(p);
=2D		p->time_slice =3D task_timeslice(p);
=2D		p->first_time_slice =3D 0;
=2D
=2D		if (!rq->expired_timestamp)
=2D			rq->expired_timestamp =3D jiffies;
=2D		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
=2D			enqueue_task(p, rq->expired);
=2D			if (p->static_prio < rq->best_expired_prio)
=2D				rq->best_expired_prio =3D p->static_prio;
=2D		} else
=2D			enqueue_task(p, rq->active);
=2D	} else {
=2D		/*
=2D		 * Prevent a too long timeslice allowing a task to monopolize
=2D		 * the CPU. We do this by splitting up the timeslice into
=2D		 * smaller pieces.
=2D		 *
=2D		 * Note: this does not mean the task's timeslices expire or
=2D		 * get lost in any way, they just might be preempted by
=2D		 * another task of equal priority. (one with higher
=2D		 * priority would have preempted this task already.) We
=2D		 * requeue this task to the end of the list on this priority
=2D		 * level, which is in essence a round-robin of tasks with
=2D		 * equal priority.
=2D		 *
=2D		 * This only applies to tasks in the interactive
=2D		 * delta range with at least TIMESLICE_GRANULARITY to requeue.
=2D		 */
=2D		if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
=2D			p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
=2D			(p->time_slice >=3D TIMESLICE_GRANULARITY(p)) &&
=2D			(p->array =3D=3D rq->active)) {
=2D
=2D			requeue_task(p, rq->active);
=2D			set_tsk_need_resched(p);
=2D		}
+		goto out_unlock;
 	}
+	expired_balance =3D 0;
 out_unlock:
 	spin_unlock(&rq->lock);
 out:
=2D	rebalance_tick(cpu, rq, NOT_IDLE);
+	if (expired_balance > 1)
+		rebalance_tick(cpu, rq, NOT_IDLE);
 }
=20
 #ifdef CONFIG_SCHED_SMT
@@ -2690,19 +2541,18 @@ static inline void wake_sleeping_depende
=20
 /*
  * number of 'lost' timeslices this task wont be able to fully
=2D * utilize, if another task runs on a sibling. This models the
+ * utilise, if another task runs on a sibling. This models the
  * slowdown effect of other tasks running on siblings:
  */
 static inline unsigned long smt_slice(task_t *p, struct sched_domain *sd)
 {
=2D	return p->time_slice * (100 - sd->per_cpu_gain) / 100;
+	return p->slice * (100 - sd->per_cpu_gain) / 100;
 }
=20
 static inline int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
 {
 	struct sched_domain *tmp, *sd =3D NULL;
 	cpumask_t sibling_map;
=2D	prio_array_t *array;
 	int ret =3D 0, i;
 	task_t *p;
=20
@@ -2729,12 +2579,8 @@ static inline int dependent_sleeper(int=20
 	 */
 	if (!this_rq->nr_running)
 		goto out_unlock;
=2D	array =3D this_rq->active;
=2D	if (!array->nr_active)
=2D		array =3D this_rq->expired;
=2D	BUG_ON(!array->nr_active);
=20
=2D	p =3D list_entry(array->queue[sched_find_first_bit(array->bitmap)].next,
+	p =3D list_entry(this_rq->queue[sched_find_first_bit(this_rq->bitmap)].ne=
xt,
 		task_t, run_list);
=20
 	for_each_cpu_mask(i, sibling_map) {
@@ -2764,7 +2610,7 @@ static inline int dependent_sleeper(int=20
 		} else
 			if (smt_curr->static_prio < p->static_prio &&
 				!TASK_PREEMPTS_CURR(p, smt_rq) &&
=2D				smt_slice(smt_curr, sd) > task_timeslice(p))
+				smt_slice(smt_curr, sd) > slice(p))
 					ret =3D 1;
=20
 check_smt_task:
@@ -2787,7 +2633,7 @@ check_smt_task:
 					resched_task(smt_curr);
 		} else {
 			if (TASK_PREEMPTS_CURR(p, smt_rq) &&
=2D				smt_slice(p, sd) > task_timeslice(smt_curr))
+				smt_slice(p, sd) > slice(smt_curr))
 					resched_task(smt_curr);
 			else
 				wakeup_busy_runqueue(smt_rq);
@@ -2849,11 +2695,10 @@ asmlinkage void __sched schedule(void)
 	long *switch_count;
 	task_t *prev, *next;
 	runqueue_t *rq;
=2D	prio_array_t *array;
 	struct list_head *queue;
 	unsigned long long now;
=2D	unsigned long run_time;
=2D	int cpu, idx, new_prio;
+	unsigned long debit;
+	int cpu, idx;
=20
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
@@ -2888,20 +2733,11 @@ need_resched_nonpreemptible:
=20
 	schedstat_inc(rq, sched_cnt);
 	now =3D sched_clock();
=2D	if (likely((long long)(now - prev->timestamp) < NS_MAX_SLEEP_AVG)) {
=2D		run_time =3D now - prev->timestamp;
=2D		if (unlikely((long long)(now - prev->timestamp) < 0))
=2D			run_time =3D 0;
=2D	} else
=2D		run_time =3D NS_MAX_SLEEP_AVG;
=2D
=2D	/*
=2D	 * Tasks charged proportionately less run_time at high sleep_avg to
=2D	 * delay them losing their interactive status
=2D	 */
=2D	run_time /=3D (CURRENT_BONUS(prev) ? : 1);
=20
 	spin_lock_irq(&rq->lock);
+	prev->runtime =3D ns_diff(now, prev->timestamp);
+	debit =3D ns_diff(now, rq->timestamp_last_tick) % NSJIFFY;
+	prev->ns_debit +=3D debit;
=20
 	if (unlikely(prev->flags & PF_DEAD))
 		prev->state =3D EXIT_DEAD;
@@ -2913,8 +2749,10 @@ need_resched_nonpreemptible:
 				unlikely(signal_pending(prev))))
 			prev->state =3D TASK_RUNNING;
 		else {
=2D			if (prev->state =3D=3D TASK_UNINTERRUPTIBLE)
+			if (prev->state =3D=3D TASK_UNINTERRUPTIBLE) {
+				prev->flags |=3D PF_NONSLEEP;
 				rq->nr_uninterruptible++;
+			}
 			deactivate_task(prev, rq);
 		}
 	}
@@ -2925,7 +2763,6 @@ go_idle:
 		idle_balance(cpu, rq);
 		if (!rq->nr_running) {
 			next =3D rq->idle;
=2D			rq->expired_timestamp =3D 0;
 			wake_sleeping_dependent(cpu, rq);
 			/*
 			 * wake_sleeping_dependent() might have released
@@ -2949,45 +2786,27 @@ go_idle:
 			goto go_idle;
 	}
=20
=2D	array =3D rq->active;
=2D	if (unlikely(!array->nr_active)) {
=2D		/*
=2D		 * Switch the active and expired arrays.
=2D		 */
=2D		schedstat_inc(rq, sched_switch);
=2D		rq->active =3D rq->expired;
=2D		rq->expired =3D array;
=2D		array =3D rq->active;
=2D		rq->expired_timestamp =3D 0;
=2D		rq->best_expired_prio =3D MAX_PRIO;
=2D	}
=2D
=2D	idx =3D sched_find_first_bit(array->bitmap);
=2D	queue =3D array->queue + idx;
+	idx =3D sched_find_first_bit(rq->bitmap);
+	queue =3D rq->queue + idx;
 	next =3D list_entry(queue->next, task_t, run_list);
=20
=2D	if (!rt_task(next) && next->activated > 0) {
=2D		unsigned long long delta =3D now - next->timestamp;
=2D		if (unlikely((long long)(now - next->timestamp) < 0))
=2D			delta =3D 0;
=2D
=2D		if (next->activated =3D=3D 1)
=2D			delta =3D delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
=2D
=2D		array =3D next->array;
=2D		new_prio =3D recalc_task_prio(next, next->timestamp + delta);
=2D
=2D		if (unlikely(next->prio !=3D new_prio)) {
=2D			dequeue_task(next, array);
=2D			next->prio =3D new_prio;
=2D			enqueue_task(next, array);
=2D		} else
=2D			requeue_task(next, array);
=2D	}
=2D	next->activated =3D 0;
 switch_tasks:
 	if (next =3D=3D rq->idle)
 		schedstat_inc(rq, sched_goidle);
+	prev->timestamp =3D now;
+	if (unlikely(next->flags & PF_YIELDED)) {
+		/*
+		 * Tasks that have yield()ed get requeued at normal priority
+		 */
+		int newprio =3D effective_prio(next);
+		next->flags &=3D ~PF_YIELDED;
+		if (newprio !=3D next->prio) {
+			dequeue_task(next, rq);
+			next->prio =3D newprio;
+			enqueue_task(next, rq);
+		}
+	}
+
 	prefetch(next);
 	prefetch_stack(next);
 	clear_tsk_need_resched(prev);
@@ -2995,13 +2814,10 @@ switch_tasks:
=20
 	update_cpu_clock(prev, rq, now);
=20
=2D	prev->sleep_avg -=3D run_time;
=2D	if ((long)prev->sleep_avg <=3D 0)
=2D		prev->sleep_avg =3D 0;
=2D	prev->timestamp =3D prev->last_ran =3D now;
=2D
 	sched_info_switch(prev, next);
 	if (likely(prev !=3D next)) {
+		rq->preempted =3D 0;
+		rq->cache_ticks =3D 0;
 		next->timestamp =3D now;
 		rq->nr_switches++;
 		rq->curr =3D next;
@@ -3431,9 +3247,8 @@ EXPORT_SYMBOL(sleep_on_timeout);
 void set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
=2D	prio_array_t *array;
 	runqueue_t *rq;
=2D	int old_prio, new_prio, delta;
+	int queued, old_prio, new_prio, delta;
=20
 	if (TASK_NICE(p) =3D=3D nice || nice < -20 || nice > 19)
 		return;
@@ -3452,18 +3267,19 @@ void set_user_nice(task_t *p, long nice)
 		p->static_prio =3D NICE_TO_PRIO(nice);
 		goto out_unlock;
 	}
=2D	array =3D p->array;
=2D	if (array)
=2D		dequeue_task(p, array);
+	if ((queued =3D task_queued(p)))
+		dequeue_task(p, rq);
=20
 	old_prio =3D p->prio;
 	new_prio =3D NICE_TO_PRIO(nice);
 	delta =3D new_prio - old_prio;
 	p->static_prio =3D NICE_TO_PRIO(nice);
 	p->prio +=3D delta;
+	if (p->bonus > bonus(p))
+		p->bonus=3D bonus(p);
=20
=2D	if (array) {
=2D		enqueue_task(p, array);
+	if (queued) {
+		enqueue_task(p, rq);
 		/*
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
@@ -3588,7 +3404,7 @@ static inline task_t *find_process_by_pi
 /* Actually do priority change: must hold rq lock. */
 static void __setscheduler(struct task_struct *p, int policy, int prio)
 {
=2D	BUG_ON(p->array);
+	BUG_ON(task_queued(p));
 	p->policy =3D policy;
 	p->rt_priority =3D prio;
 	if (policy !=3D SCHED_NORMAL)
@@ -3608,8 +3424,7 @@ int sched_setscheduler(struct task_struc
 		       struct sched_param *param)
 {
 	int retval;
=2D	int oldprio, oldpolicy =3D -1;
=2D	prio_array_t *array;
+	int queued, oldprio, oldpolicy =3D -1;
 	unsigned long flags;
 	runqueue_t *rq;
=20
@@ -3665,12 +3480,11 @@ recheck:
 		task_rq_unlock(rq, &flags);
 		goto recheck;
 	}
=2D	array =3D p->array;
=2D	if (array)
+	if ((queued =3D task_queued(p)))
 		deactivate_task(p, rq);
 	oldprio =3D p->prio;
 	__setscheduler(p, policy, param->sched_priority);
=2D	if (array) {
+	if (queued) {
 		__activate_task(p, rq);
 		/*
 		 * Reschedule if we are currently running on this runqueue and
@@ -3680,8 +3494,8 @@ recheck:
 		if (task_running(rq, p)) {
 			if (p->prio > oldprio)
 				resched_task(rq->curr);
=2D		} else if (TASK_PREEMPTS_CURR(p, rq))
=2D			resched_task(rq->curr);
+		} else=20
+			preempt(p, rq);
 	}
 	task_rq_unlock(rq, &flags);
 	return 0;
@@ -3837,7 +3651,7 @@ out_unlock:
 	return retval;
 }
=20
=2Dstatic int get_user_cpu_mask(unsigned long __user *user_mask_ptr, unsign=
ed len,
+static inline int get_user_cpu_mask(unsigned long __user *user_mask_ptr, u=
nsigned len,
 			     cpumask_t *new_mask)
 {
 	if (len < sizeof(cpumask_t)) {
@@ -3935,43 +3749,29 @@ asmlinkage long sys_sched_getaffinity(pi
=20
 /**
  * sys_sched_yield - yield the current processor to other threads.
=2D *
=2D * this function yields the current CPU by moving the calling thread
=2D * to the expired array. If there are no other threads running on this
=2D * CPU then this function will return.
+ * This function yields the current CPU by dropping the priority of current
+ * to the lowest priority and setting the PF_YIELDED flag.
  */
 asmlinkage long sys_sched_yield(void)
 {
+	int newprio;
 	runqueue_t *rq =3D this_rq_lock();
=2D	prio_array_t *array =3D current->array;
=2D	prio_array_t *target =3D rq->expired;
=20
+	newprio =3D current->prio;
 	schedstat_inc(rq, yld_cnt);
=2D	/*
=2D	 * We implement yielding by moving the task into the expired
=2D	 * queue.
=2D	 *
=2D	 * (special rule: RT tasks will just roundrobin in the active
=2D	 *  array.)
=2D	 */
=2D	if (rt_task(current))
=2D		target =3D rq->active;
=2D
=2D	if (array->nr_active =3D=3D 1) {
=2D		schedstat_inc(rq, yld_act_empty);
=2D		if (!rq->expired->nr_active)
=2D			schedstat_inc(rq, yld_both_empty);
=2D	} else if (!rq->expired->nr_active)
=2D		schedstat_inc(rq, yld_exp_empty);
=2D
=2D	if (array !=3D target) {
=2D		dequeue_task(current, array);
=2D		enqueue_task(current, target);
+	current->slice =3D slice(current);
+	current->time_slice =3D rr_interval(current);
+	if (likely(!rt_task(current))) {
+		current->flags |=3D PF_YIELDED;
+		newprio =3D MAX_PRIO - 1;
+	}
+
+	if (newprio !=3D current->prio) {
+		dequeue_task(current, rq);
+		current->prio =3D newprio;
+		enqueue_task(current, rq);
 	} else
=2D		/*
=2D		 * requeue_task is cheaper so perform that if possible.
=2D		 */
=2D		requeue_task(current, array);
+		requeue_task(current, rq);
=20
 	/*
 	 * Since we are going to call schedule() anyway, there's
@@ -4176,7 +3976,7 @@ long sys_sched_rr_get_interval(pid_t pid
 		goto out_unlock;
=20
 	jiffies_to_timespec(p->policy & SCHED_FIFO ?
=2D				0 : task_timeslice(p), &t);
+				0 : slice(p), &t);
 	read_unlock(&tasklist_lock);
 	retval =3D copy_to_user(interval, &t, sizeof(t)) ? -EFAULT : 0;
 out_nounlock:
@@ -4204,7 +4004,7 @@ static inline struct task_struct *younge
 	return list_entry(p->sibling.next,struct task_struct,sibling);
 }
=20
=2Dstatic void show_task(task_t *p)
+static inline void show_task(task_t *p)
 {
 	task_t *relative;
 	unsigned state;
@@ -4297,8 +4097,6 @@ void __devinit init_idle(task_t *idle, i
 	runqueue_t *rq =3D cpu_rq(cpu);
 	unsigned long flags;
=20
=2D	idle->sleep_avg =3D 0;
=2D	idle->array =3D NULL;
 	idle->prio =3D MAX_PRIO;
 	idle->state =3D TASK_RUNNING;
 	idle->cpus_allowed =3D cpumask_of_cpu(cpu);
@@ -4415,7 +4213,7 @@ static void __migrate_task(struct task_s
 		goto out;
=20
 	set_task_cpu(p, dest_cpu);
=2D	if (p->array) {
+	if (task_queued(p)) {
 		/*
 		 * Sync timestamp with rq_dest's before activating.
 		 * The same thing could be achieved by doing this step
@@ -4426,8 +4224,7 @@ static void __migrate_task(struct task_s
 				+ rq_dest->timestamp_last_tick;
 		deactivate_task(p, rq_src);
 		activate_task(p, rq_dest, 0);
=2D		if (TASK_PREEMPTS_CURR(p, rq_dest))
=2D			resched_task(rq_dest->curr);
+		preempt(p, rq_dest);
 	}
=20
 out:
@@ -4641,7 +4438,7 @@ static void migrate_dead_tasks(unsigned=20
=20
 	for (arr =3D 0; arr < 2; arr++) {
 		for (i =3D 0; i < MAX_PRIO; i++) {
=2D			struct list_head *list =3D &rq->arrays[arr].queue[i];
+			struct list_head *list =3D &rq->queue[i];
 			while (!list_empty(list))
 				migrate_dead(dead_cpu,
 					     list_entry(list->next, task_t,
@@ -5502,17 +5299,15 @@ int in_sched_functions(unsigned long add
 void __init sched_init(void)
 {
 	runqueue_t *rq;
=2D	int i, j, k;
+	int i, j;
=20
 	for (i =3D 0; i < NR_CPUS; i++) {
=2D		prio_array_t *array;
=20
 		rq =3D cpu_rq(i);
 		spin_lock_init(&rq->lock);
 		rq->nr_running =3D 0;
=2D		rq->active =3D rq->arrays;
=2D		rq->expired =3D rq->arrays + 1;
=2D		rq->best_expired_prio =3D MAX_PRIO;
+		rq->cache_ticks =3D 0;
+		rq->preempted =3D 0;
=20
 #ifdef CONFIG_SMP
 		rq->sd =3D NULL;
@@ -5524,16 +5319,13 @@ void __init sched_init(void)
 		INIT_LIST_HEAD(&rq->migration_queue);
 #endif
 		atomic_set(&rq->nr_iowait, 0);
=2D
=2D		for (j =3D 0; j < 2; j++) {
=2D			array =3D rq->arrays + j;
=2D			for (k =3D 0; k < MAX_PRIO; k++) {
=2D				INIT_LIST_HEAD(array->queue + k);
=2D				__clear_bit(k, array->bitmap);
=2D			}
=2D			// delimiter for bitsearch
=2D			__set_bit(MAX_PRIO, array->bitmap);
=2D		}
+		for (j =3D 0; j < MAX_PRIO; j++)
+			INIT_LIST_HEAD(&rq->queue[j]);
+		memset(rq->bitmap, 0, BITS_TO_LONGS(MAX_PRIO)*sizeof(long));
+		/*
+		 * delimiter for bitsearch
+		 */
+		__set_bit(MAX_PRIO, rq->bitmap);
 	}
=20
 	/*
@@ -5577,9 +5369,9 @@ EXPORT_SYMBOL(__might_sleep);
 void normalize_rt_tasks(void)
 {
 	struct task_struct *p;
=2D	prio_array_t *array;
 	unsigned long flags;
 	runqueue_t *rq;
+	int queued;
=20
 	read_lock_irq(&tasklist_lock);
 	for_each_process (p) {
@@ -5588,11 +5380,10 @@ void normalize_rt_tasks(void)
=20
 		rq =3D task_rq_lock(p, &flags);
=20
=2D		array =3D p->array;
=2D		if (array)
+		if ((queued =3D task_queued(p)))
 			deactivate_task(p, task_rq(p));
 		__setscheduler(p, SCHED_NORMAL, 0);
=2D		if (array) {
+		if (queued) {
 			__activate_task(p, task_rq(p));
 			resched_task(rq->curr);
 		}
Index: linux-2.6.14-s13/kernel/sysctl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.14-s13.orig/kernel/sysctl.c	2005-10-28 20:22:02.000000000 +=
1000
+++ linux-2.6.14-s13/kernel/sysctl.c	2005-11-09 23:57:56.000000000 +1100
@@ -618,6 +618,22 @@ static ctl_table kern_table[] =3D {
 		.mode		=3D 0444,
 		.proc_handler	=3D &proc_dointvec,
 	},
+	{
+		.ctl_name	=3D KERN_INTERACTIVE,
+		.procname	=3D "interactive",
+		.data		=3D &sched_interactive,
+		.maxlen		=3D sizeof (int),
+		.mode		=3D 0644,
+		.proc_handler	=3D &proc_dointvec,
+	},
+	{
+		.ctl_name	=3D KERN_COMPUTE,
+		.procname	=3D "compute",
+		.data		=3D &sched_compute,
+		.maxlen		=3D sizeof (int),
+		.mode		=3D 0644,
+		.proc_handler	=3D &proc_dointvec,
+	},
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 	{
 		.ctl_name       =3D KERN_UNKNOWN_NMI_PANIC,

--Boundary-01=_UxfcDEZKQs7HSzd--

--nextPart3991322.Rrb8fSSz5k
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDcfxVZUg7+tp6mRURAij7AKCPLDClnrwz5utYOlksPsOYfi4MngCghTUL
uKWgWpvqHJMvnl2FK5lYyXc=
=Hd2h
-----END PGP SIGNATURE-----

--nextPart3991322.Rrb8fSSz5k--
