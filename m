Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbTIGRNt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbTIGRNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:13:49 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:27662
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263359AbTIGRNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:13:17 -0400
Message-ID: <3F5B6727.2010201@cyberone.com.au>
Date: Mon, 08 Sep 2003 03:13:11 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: David Nielsen <Lovechild@foolclan.com>
Subject: [PATCH] Nick's scheduler policy v13
References: <1062938059.3485.2.camel@pilot.stavtrup-st.dk>
In-Reply-To: <1062938059.3485.2.camel@pilot.stavtrup-st.dk>
Content-Type: multipart/mixed;
 boundary="------------010601000504010602030100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010601000504010602030100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

A random priority / nice fixes noticed by Greg Wolledge. Due to bigger
priority range. A few other random things.

I apologise for continually posting this patch. I have taken on a number
of other scheduler improvements (mostly SMP/NUMA balancing), so the rollup
is growing. I'll refrain from posting it again till I find some webspace
to put it up.


--------------010601000504010602030100
Content-Type: text/plain;
 name="sched-policy-13b"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-policy-13b"

 linux-2.6-npiggin/fs/proc/array.c           |    7 
 linux-2.6-npiggin/include/linux/init_task.h |    4 
 linux-2.6-npiggin/include/linux/sched.h     |   10 
 linux-2.6-npiggin/kernel/fork.c             |   30 -
 linux-2.6-npiggin/kernel/sched.c            |  568 ++++++++++++++++------------
 5 files changed, 359 insertions(+), 260 deletions(-)

diff -puN include/linux/sched.h~rollup include/linux/sched.h
--- linux-2.6/include/linux/sched.h~rollup	2003-09-08 03:04:16.000000000 +1000
+++ linux-2.6-npiggin/include/linux/sched.h	2003-09-08 03:05:07.000000000 +1000
@@ -280,7 +280,7 @@ struct signal_struct {
 #define MAX_USER_RT_PRIO	100
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
 
-#define MAX_PRIO		(MAX_RT_PRIO + 40)
+#define MAX_PRIO		(MAX_RT_PRIO + 60)
  
 /*
  * Some day this will be a full-fledged user tracking system..
@@ -339,12 +339,17 @@ struct task_struct {
 	struct list_head run_list;
 	prio_array_t *array;
 
+	/* Scheduler variables follow. kernel/sched.c */
+	unsigned long array_sequence;
+	unsigned long timestamp;
+
+	unsigned long total_time, sleep_time;
 	unsigned long sleep_avg;
-	unsigned long last_run;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
+	unsigned int used_slice;
 
 	struct list_head tasks;
 	struct list_head ptrace_children;
@@ -552,6 +557,7 @@ extern int FASTCALL(wake_up_state(struct
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
 extern int FASTCALL(wake_up_process_kick(struct task_struct * tsk));
 extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
+extern void FASTCALL(sched_fork(task_t * p));
 extern void FASTCALL(sched_exit(task_t * p));
 
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);
diff -puN include/linux/init_task.h~rollup include/linux/init_task.h
--- linux-2.6/include/linux/init_task.h~rollup	2003-09-08 03:04:29.000000000 +1000
+++ linux-2.6-npiggin/include/linux/init_task.h	2003-09-08 03:05:07.000000000 +1000
@@ -67,8 +67,8 @@
 	.usage		= ATOMIC_INIT(2),				\
 	.flags		= 0,						\
 	.lock_depth	= -1,						\
-	.prio		= MAX_PRIO-20,					\
-	.static_prio	= MAX_PRIO-20,					\
+	.prio		= MAX_PRIO-30,					\
+	.static_prio	= MAX_PRIO-30,					\
 	.policy		= SCHED_NORMAL,					\
 	.cpus_allowed	= CPU_MASK_ALL,					\
 	.mm		= NULL,						\
diff -puN fs/proc/array.c~rollup fs/proc/array.c
--- linux-2.6/fs/proc/array.c~rollup	2003-09-08 03:04:49.000000000 +1000
+++ linux-2.6-npiggin/fs/proc/array.c	2003-09-08 03:05:07.000000000 +1000
@@ -154,13 +154,18 @@ static inline char * task_state(struct t
 	read_lock(&tasklist_lock);
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
+		"sleep_avg:\t%lu\n"
+		"sleep_time:\t%lu\n"
+		"total_time:\t%lu\n"
 		"Tgid:\t%d\n"
 		"Pid:\t%d\n"
 		"PPid:\t%d\n"
 		"TracerPid:\t%d\n"
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
-		get_task_state(p), p->tgid,
+		get_task_state(p),
+		p->sleep_avg, p->sleep_time, p->total_time,
+		p->tgid,
 		p->pid, p->pid ? p->real_parent->pid : 0,
 		p->pid && p->ptrace ? p->parent->pid : 0,
 		p->uid, p->euid, p->suid, p->fsuid,
diff -puN kernel/fork.c~rollup kernel/fork.c
--- linux-2.6/kernel/fork.c~rollup	2003-09-08 03:04:54.000000000 +1000
+++ linux-2.6-npiggin/kernel/fork.c	2003-09-08 03:05:07.000000000 +1000
@@ -911,33 +911,9 @@ struct task_struct *copy_process(unsigne
 	p->exit_signal = (clone_flags & CLONE_THREAD) ? -1 : (clone_flags & CSIGNAL);
 	p->pdeath_signal = 0;
 
-	/*
-	 * Share the timeslice between parent and child, thus the
-	 * total amount of pending timeslices in the system doesn't change,
-	 * resulting in more scheduling fairness.
-	 */
-	local_irq_disable();
-        p->time_slice = (current->time_slice + 1) >> 1;
-	/*
-	 * The remainder of the first timeslice might be recovered by
-	 * the parent if the child exits early enough.
-	 */
-	p->first_time_slice = 1;
-	current->time_slice >>= 1;
-	p->last_run = jiffies;
-	if (!current->time_slice) {
-		/*
-	 	 * This case is rare, it happens when the parent has only
-	 	 * a single jiffy left from its timeslice. Taking the
-		 * runqueue lock is not a problem.
-		 */
-		current->time_slice = 1;
-		preempt_disable();
-		scheduler_tick(0, 0);
-		local_irq_enable();
-		preempt_enable();
-	} else
-		local_irq_enable();
+	/* Perform scheduler related accounting */
+	sched_fork(p);
+
 	/*
 	 * Ok, add it to the run-queues and make it
 	 * visible to the rest of the system.
diff -puN kernel/sched.c~rollup kernel/sched.c
--- linux-2.6/kernel/sched.c~rollup	2003-09-08 03:04:56.000000000 +1000
+++ linux-2.6-npiggin/kernel/sched.c	2003-09-08 03:05:07.000000000 +1000
@@ -46,8 +46,8 @@
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
  * and back.
  */
-#define NICE_TO_PRIO(nice)	(MAX_RT_PRIO + (nice) + 20)
-#define PRIO_TO_NICE(prio)	((prio) - MAX_RT_PRIO - 20)
+#define NICE_TO_PRIO(nice)	(MAX_RT_PRIO + (nice) + 30)
+#define PRIO_TO_NICE(prio)	((prio) - MAX_RT_PRIO - 30)
 #define TASK_NICE(p)		PRIO_TO_NICE((p)->static_prio)
 
 /*
@@ -60,85 +60,56 @@
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
 
 /*
- * These are the 'tuning knobs' of the scheduler:
- *
- * Minimum timeslice is 10 msecs, default timeslice is 100 msecs,
- * maximum timeslice is 200 msecs. Timeslices get refilled after
- * they expire.
- */
-#define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(200 * HZ / 1000)
-#define CHILD_PENALTY		50
-#define PARENT_PENALTY		100
-#define EXIT_WEIGHT		3
-#define PRIO_BONUS_RATIO	25
-#define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(10*HZ)
-#define STARVATION_LIMIT	(10*HZ)
-#define NODE_THRESHOLD		125
+ * MIN_TIMESLICE is the timeslice that a minimum priority process gets if there
+ * is a maximum priority process runnable. MAX_TIMESLICE is derived from the
+ * formula in task_timeslice. It cannot be changed here. It is the timesilce
+ * that the maximum priority process will get. Larger timeslices are attainable
+ * by low priority processes however.
+ */
+#define MIN_TIMESLICE		((1 * HZ / 1000) ? 1 * HZ / 1000 : 1)
+#define MAX_TIMESLICE		(60 * MIN_TIMESLICE) /* do not change */
+
+/* Maximum amount of history that will be used to calculate priority */
+#define MAX_SLEEP		(HZ)
 
 /*
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
+ * Maximum effect that 1 block of activity (run/sleep/etc) can have. This is
+ * will moderate dicard freak events (eg. SIGSTOP)
  */
+#define MAX_SLEEP_AFFECT	(MAX_SLEEP/4)
+#define MAX_RUN_AFFECT		(MAX_SLEEP/4)
+#define MAX_WAIT_AFFECT		(MAX_RUN_AFFECT/4)
 
-#define SCALE(v1,v1_max,v2_max) \
-	(v1) * (v2_max) / (v1_max)
+/*
+ * The amount of history can be decreased (on fork for example). This puts a
+ * lower bound on it.
+ */
+#define MIN_HISTORY		(MAX_SLEEP/2)
 
-#define DELTA(p) \
-	(SCALE(TASK_NICE(p), 40, MAX_USER_PRIO*PRIO_BONUS_RATIO/100) + \
-		INTERACTIVE_DELTA)
+/*
+ * SLEEP_FACTOR is a fixed point factor used to scale history tracking things.
+ * In particular: total_time, sleep_time, sleep_avg.
+ */
+#define SLEEP_FACTOR		(1024)
 
-#define TASK_INTERACTIVE(p) \
-	((p)->prio <= (p)->static_prio - DELTA(p))
+#define NODE_THRESHOLD		125
 
 /*
- * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
- * to time slice values.
- *
- * The higher a thread's priority, the bigger timeslices
- * it gets during one round of execution. But even the lowest
- * priority thread gets MIN_TIMESLICE worth of execution time.
- *
- * task_timeslice() is the interface that is used by the scheduler.
+ * The scheduler classifies a process as performing one of the following
+ * activities
  */
+#define STIME_SLEEP		1	/* Sleeping */
+#define STIME_RUN		2	/* Using CPU */
+#define STIME_WAIT		3	/* Waiting for CPU */
 
-#define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
-	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
-
-static inline unsigned int task_timeslice(task_t *p)
-{
-	return BASE_TIMESLICE(p);
-}
+#define TASK_PREEMPTS_CURR(p, rq)			\
+	( (p)->prio < (rq)->curr->prio )
 
 /*
  * These are the runqueue data structures:
  */
 
-#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
+#define BITMAP_SIZE ((((MAX_PRIO+7)/8)+sizeof(long)-1)/sizeof(long))
 
 typedef struct runqueue runqueue_t;
 
@@ -157,7 +128,8 @@ struct prio_array {
  */
 struct runqueue {
 	spinlock_t lock;
-	unsigned long nr_running, nr_switches, expired_timestamp,
+	unsigned long array_sequence;
+	unsigned long nr_running, nr_switches,
 			nr_uninterruptible;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
@@ -299,34 +271,102 @@ static inline void enqueue_task(struct t
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
+ * add_task_time updates a task @p after @time of doing the specified @type
+ * of activity. See STIME_*. This is used for priority calculation.
+ */
+static void add_task_time(task_t *p, unsigned long time, unsigned long type)
+{
+	unsigned long r;
+	unsigned long max_affect;
+
+	if (time == 0)
+		return;
+
+	if (type == STIME_SLEEP)
+		max_affect = MAX_SLEEP_AFFECT;
+	else if (type == STIME_RUN)
+		max_affect = MAX_RUN_AFFECT;
+	else
+		max_affect = MAX_WAIT_AFFECT;
+
+	if (time > max_affect)
+		time = max_affect;
+
+	r = MAX_SLEEP - time;
+	p->total_time = (r*p->total_time + MAX_SLEEP/2) / MAX_SLEEP;
+	p->sleep_time = (r*p->sleep_time + MAX_SLEEP/2) / MAX_SLEEP;
+
+	if (type != STIME_WAIT) {
+		p->total_time += SLEEP_FACTOR * time;
+		if (type == STIME_SLEEP)
+			p->sleep_time += SLEEP_FACTOR * time;
+
+		p->sleep_avg = (SLEEP_FACTOR * p->sleep_time) / p->total_time;
+	}
+
+	if (p->total_time < SLEEP_FACTOR * MIN_HISTORY) {
+		p->total_time = SLEEP_FACTOR * MIN_HISTORY;
+		p->sleep_time = p->total_time * p->sleep_avg / SLEEP_FACTOR;
+	}
+}
+
+/*
+ * The higher a thread's priority, the bigger timeslices
+ * it gets during one round of execution. But even the lowest
+ * priority thread gets MIN_TIMESLICE worth of execution time.
  *
- * Both properties are important to certain workloads.
+ * Timeslices are scaled, so if only low priority processes are running,
+ * they will all get long timeslices.
+ */
+static unsigned int task_timeslice(task_t *p, runqueue_t *rq)
+{
+	int idx, delta;
+	unsigned int base, timeslice;
+
+	if (rt_task(p))
+		return MAX_TIMESLICE;
+
+	idx = min(find_next_bit(rq->active->bitmap, MAX_PRIO, MAX_RT_PRIO),
+		find_next_bit(rq->expired->bitmap, MAX_PRIO, MAX_RT_PRIO));
+	idx = min(idx, p->prio);
+	delta = p->prio - idx;
+
+	/*
+	 * This is a bit subtle. The first line establishes a timeslice based
+	 * on how far this task is from being the highest priority runnable.
+	 * The second line scales this result so low priority tasks will get
+	 * big timeslices if higher priority ones are not running.
+	 */
+	base = MIN_TIMESLICE * (MAX_USER_PRIO + 1) / (delta + 2);
+	timeslice = base * (USER_PRIO(idx) + 8) / 24;
+
+	if (timeslice <= 0)
+		timeslice = 1;
+
+	return timeslice;
+}
+
+/*
+ * task_priority: calculates a task's priority based on previous running
+ * history (see add_task_time). The priority is just a simple linear function
+ * based on sleep_avg and static_prio.
  */
-static int effective_prio(task_t *p)
+static unsigned long task_priority(task_t *p)
 {
 	int bonus, prio;
 
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
-			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
+	bonus = ((MAX_USER_PRIO / 3) * p->sleep_avg + (SLEEP_FACTOR / 2)) / SLEEP_FACTOR;
+	prio = USER_PRIO(p->static_prio) + 10;
 
-	prio = p->static_prio - bonus;
+	prio = MAX_RT_PRIO + prio - bonus;
 	if (prio < MAX_RT_PRIO)
 		prio = MAX_RT_PRIO;
 	if (prio > MAX_PRIO-1)
 		prio = MAX_PRIO-1;
+
 	return prio;
 }
 
@@ -347,34 +387,21 @@ static inline void __activate_task(task_
  */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	long sleep_time = jiffies - p->last_run - 1;
+	unsigned long now = jiffies;
+	unsigned long sleep = now - p->timestamp;
+	p->timestamp = now;
 
-	if (sleep_time > 0) {
-		int sleep_avg;
+	add_task_time(p, sleep, STIME_SLEEP);
 
-		/*
-		 * This code gives a bonus to interactive tasks.
-		 *
-		 * The boost works by updating the 'average sleep time'
-		 * value here, based on ->last_run. The more time a task
-		 * spends sleeping, the higher the average gets - and the
-		 * higher the priority boost gets as well.
-		 */
-		sleep_avg = p->sleep_avg + sleep_time;
+	p->prio = task_priority(p);
+
+	/*
+	 * If we have slept through an active/expired array switch, restart
+	 * our timeslice too.
+	 */
+	if (rq->array_sequence != p->array_sequence)
+		p->used_slice = 0;
 
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
-	}
 	__activate_task(p, rq);
 }
 
@@ -383,6 +410,7 @@ static inline void activate_task(task_t 
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
+	p->array_sequence = rq->array_sequence;
 	nr_running_dec(rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
@@ -426,7 +454,7 @@ static inline void resched_task(task_t *
  * be called with interrupts off, or it may introduce deadlock with
  * smp_call_function() if an IPI is sent by the same process we are
  * waiting to become inactive.
- */
+ n*/
 void wait_task_inactive(task_t * p)
 {
 	unsigned long flags;
@@ -497,11 +525,9 @@ repeat_lock_task:
 			}
 			if (old_state == TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible--;
-			if (sync)
-				__activate_task(p, rq);
-			else {
-				activate_task(p, rq);
-				if (p->prio < rq->curr->prio)
+			activate_task(p, rq);
+			if (!sync) {
+				if (TASK_PREEMPTS_CURR(p, rq))
 					resched_task(rq->curr);
 			}
 			success = 1;
@@ -534,36 +560,90 @@ int wake_up_state(task_t *p, unsigned in
 }
 
 /*
+ * Perform scheduler related accounting for a newly forked process @p.
+ * @p is forked by current.
+ */
+void sched_fork(task_t *p)
+{
+	unsigned long ts;
+	unsigned long flags;
+	runqueue_t *rq;
+
+	/*
+	 * Share the timeslice between parent and child, thus the
+	 * total amount of pending timeslices in the system doesn't change,
+	 * resulting in more scheduling fairness.
+	 */
+	local_irq_disable();
+	p->timestamp = jiffies;
+	rq = task_rq_lock(current, &flags);
+	ts = task_timeslice(current, rq);
+	task_rq_unlock(rq, &flags);
+
+	/*
+	 * Share half our timeslice with the child.
+	 */
+	p->used_slice = current->used_slice + (ts - current->used_slice) / 2;
+	current->used_slice += (ts - current->used_slice + 1) / 2;
+
+	/*
+	 * The remainder of the first timeslice might be recovered by
+	 * the parent if the child exits early enough.
+	 */
+	p->first_time_slice = 1;
+	if (current->used_slice >= ts) {
+		/*
+	 	 * This case is rare, it happens when the parent has only
+	 	 * a single jiffy left from its timeslice. Taking the
+		 * runqueue lock is not a problem.
+		 */
+		current->used_slice = ts - 1;
+		preempt_disable();
+		scheduler_tick(0, 0);
+		local_irq_enable();
+		preempt_enable();
+	} else
+		local_irq_enable();
+}
+
+/*
  * wake_up_forked_process - wake up a freshly forked process.
  *
  * This function will do some initial scheduler statistics housekeeping
  * that must be done for every newly created process.
  */
-void wake_up_forked_process(task_t * p)
+void wake_up_forked_process(task_t *p)
 {
 	unsigned long flags;
 	runqueue_t *rq = task_rq_lock(current, &flags);
 
 	p->state = TASK_RUNNING;
-	/*
-	 * We decrease the sleep average of forking parents
-	 * and children as well, to keep max-interactive tasks
-	 * from forking tasks that are max-interactive.
-	 */
-	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
-	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
-	p->prio = effective_prio(p);
+
 	set_task_cpu(p, smp_processor_id());
 
-	if (unlikely(!current->array))
-		__activate_task(p, rq);
-	else {
-		p->prio = current->prio;
-		list_add_tail(&p->run_list, &current->run_list);
-		p->array = current->array;
-		p->array->nr_active++;
-		nr_running_inc(rq);
+	/*
+	 * Get only 1/10th of the parents history. Limited by MIN_HISTORY.
+	 */
+	p->total_time = current->total_time / 4;
+	p->sleep_time = current->sleep_time / 4;
+	p->sleep_avg = current->sleep_avg;
+
+	if (p->total_time < SLEEP_FACTOR * MIN_HISTORY) {
+		p->total_time = SLEEP_FACTOR * MIN_HISTORY;
+		p->sleep_time = p->total_time * p->sleep_avg / SLEEP_FACTOR;
 	}
+
+	/*
+	 * Lose 1/4 sleep_time for forking.
+	 */
+	current->sleep_time = 3 * current->sleep_time / 4;
+	if (current->total_time != 0)
+		current->sleep_avg = (SLEEP_FACTOR * current->sleep_time)
+						/ current->total_time;
+
+	p->prio = task_priority(p);
+	__activate_task(p, rq);
+
 	task_rq_unlock(rq, &flags);
 }
 
@@ -581,19 +661,25 @@ void sched_exit(task_t * p)
 	unsigned long flags;
 
 	local_irq_save(flags);
+
+	/* Regain the unused timeslice given to @p by its parent */
 	if (p->first_time_slice) {
-		p->parent->time_slice += p->time_slice;
-		if (unlikely(p->parent->time_slice > MAX_TIMESLICE))
-			p->parent->time_slice = MAX_TIMESLICE;
+		unsigned long flags;
+		runqueue_t *rq;
+		rq = task_rq_lock(p, &flags);
+		p->parent->used_slice -= task_timeslice(p, rq) - p->used_slice;
+		task_rq_unlock(rq, &flags);
+	}
+
+	/* Apply some penalty to @p's parent if @p used a lot of CPU */
+	if (p->sleep_avg < p->parent->sleep_avg) {
+		add_task_time(p->parent,
+			MAX_SLEEP * (p->parent->sleep_avg - p->sleep_avg)
+			/ SLEEP_FACTOR / 2,
+			STIME_RUN);
 	}
+
 	local_irq_restore(flags);
-	/*
-	 * If the child was a (relative-) CPU hog then decrease
-	 * the sleep_avg of the parent as well.
-	 */
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = (p->parent->sleep_avg * EXIT_WEIGHT +
-			p->sleep_avg) / (EXIT_WEIGHT + 1);
 }
 
 /**
@@ -793,29 +879,33 @@ static void sched_migrate_task(task_t *p
  */
 static int sched_best_cpu(struct task_struct *p)
 {
-	int i, minload, load, best_cpu, node = 0;
+ int i, minload, load, best_cpu, node, pnode;
 	cpumask_t cpumask;
 
 	best_cpu = task_cpu(p);
 	if (cpu_rq(best_cpu)->nr_running <= 2)
 		return best_cpu;
 
-	minload = 10000000;
+ minload = INT_MAX;
+ node = pnode = cpu_to_node(best_cpu);
 	for_each_node_with_cpus(i) {
 		/*
 		 * Node load is always divided by nr_cpus_node to normalise 
 		 * load values in case cpu count differs from node to node.
-		 * We first multiply node_nr_running by 10 to get a little
-		 * better resolution.   
+   * If node != our node we add the load of the migrating task;
+   * we only want to migrate if:
+   *  load(other node) + 1 < load(our node) - 1
+   * The + 1 and - 1 denote the migration.
+   * We multiply by NR_CPUS for best resolution.
 		 */
-		load = 10 * atomic_read(&node_nr_running[i]) / nr_cpus_node(i);
+  load = NR_CPUS * (atomic_read(&node_nr_running[i]) + ((i != pnode) << 1)) / nr_cpus_node(i);
 		if (load < minload) {
 			minload = load;
 			node = i;
 		}
 	}
 
-	minload = 10000000;
+ minload = INT_MAX;
 	cpumask = node_to_cpumask(node);
 	for (i = 0; i < NR_CPUS; ++i) {
 		if (!cpu_isset(i, cpumask))
@@ -845,7 +935,7 @@ void sched_balance_exec(void)
  *      load_{t} = load_{t-1}/2 + nr_node_running_{t}
  * This way sudden load peaks are flattened out a bit.
  * Node load is divided by nr_cpus_node() in order to compare nodes
- * of different cpu count but also [first] multiplied by 10 to 
+ * of different cpu count but also [first] multiplied by NR_CPUS to
  * provide better resolution.
  */
 static int find_busiest_node(int this_node)
@@ -855,14 +945,14 @@ static int find_busiest_node(int this_no
 	if (!nr_cpus_node(this_node))
 		return node;
 	this_load = maxload = (this_rq()->prev_node_load[this_node] >> 1)
-		+ (10 * atomic_read(&node_nr_running[this_node])
+  + (NR_CPUS * atomic_read(&node_nr_running[this_node])
 		/ nr_cpus_node(this_node));
 	this_rq()->prev_node_load[this_node] = this_load;
 	for_each_node_with_cpus(i) {
 		if (i == this_node)
 			continue;
 		load = (this_rq()->prev_node_load[i] >> 1)
-			+ (10 * atomic_read(&node_nr_running[i])
+   + (NR_CPUS * atomic_read(&node_nr_running[i])
 			/ nr_cpus_node(i));
 		this_rq()->prev_node_load[i] = load;
 		if (load > maxload && (100*load > NODE_THRESHOLD*this_load)) {
@@ -959,10 +1049,10 @@ static inline runqueue_t *find_busiest_q
 	if (likely(!busiest))
 		goto out;
 
-	*imbalance = (max_load - nr_running) / 2;
+	*imbalance = max_load - nr_running;
 
 	/* It needs an at least ~25% imbalance to trigger balancing. */
-	if (!idle && (*imbalance < (max_load + 3)/4)) {
+	if (!idle && ((*imbalance)*4 < max_load)) {
 		busiest = NULL;
 		goto out;
 	}
@@ -972,7 +1062,7 @@ static inline runqueue_t *find_busiest_q
 	 * Make sure nothing changed since we checked the
 	 * runqueue length.
 	 */
-	if (busiest->nr_running <= nr_running + 1) {
+	if (busiest->nr_running <= nr_running) {
 		spin_unlock(&busiest->lock);
 		busiest = NULL;
 	}
@@ -995,13 +1085,40 @@ static inline void pull_task(runqueue_t 
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
 	 */
-	if (p->prio < this_rq->curr->prio)
+	if (TASK_PREEMPTS_CURR(p, this_rq))
 		set_need_resched();
-	else {
-		if (p->prio == this_rq->curr->prio &&
-				p->time_slice > this_rq->curr->time_slice)
-			set_need_resched();
-	}
+}
+
+/*
+ * can_migrate_task
+ * May task @p from runqueue @rq be migrated to @this_cpu?
+ * @idle: Is this_cpu idle
+ * Returns: 1 if @p may be migrated, 0 otherwise.
+ */
+static inline int
+can_migrate_task(task_t *p, runqueue_t *rq, int this_cpu, int idle)
+{
+	unsigned long delta;
+
+	/*
+	 * We do not migrate tasks that are:
+	 * 1) running (obviously), or
+	 * 2) cannot be migrated to this CPU due to cpus_allowed, or
+	 * 3) are cache-hot on their current CPU.
+	 */
+
+	if (task_running(rq, p))
+		return 0;
+
+	if (!cpu_isset(this_cpu, p->cpus_allowed))
+		return 0;
+
+	/* Aggressive migration if we're idle */
+	delta = jiffies - p->timestamp;
+	if (!idle && (delta <= cache_decay_ticks))
+		return 0;
+
+	return 1;
 }
 
 /*
@@ -1025,6 +1142,12 @@ static void load_balance(runqueue_t *thi
 		goto out;
 
 	/*
+	 * We only want to steal a number of tasks equal to 1/2 the imbalance,
+	 * otherwise we'll just shift the imbalance to the new queue:
+	 */
+	imbalance /= 2;
+
+	/*
 	 * We first consider expired tasks. Those will likely not be
 	 * executed in the near future, and they are most likely to
 	 * be cache-cold, thus switching CPUs has the least effect
@@ -1056,27 +1179,17 @@ skip_bitmap:
 skip_queue:
 	tmp = list_entry(curr, task_t, run_list);
 
-	/*
-	 * We do not migrate tasks that are:
-	 * 1) running (obviously), or
-	 * 2) cannot be migrated to this CPU due to cpus_allowed, or
-	 * 3) are cache-hot on their current CPU.
-	 */
-
-#define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
-	((!idle || (jiffies - (p)->last_run > cache_decay_ticks)) &&	\
-		!task_running(rq, p) &&					\
-			cpu_isset(this_cpu, (p)->cpus_allowed))
-
 	curr = curr->prev;
 
-	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
+	if (!can_migrate_task(tmp, busiest, this_cpu, idle)) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
 		goto skip_bitmap;
 	}
 	pull_task(busiest, array, tmp, this_rq, this_cpu);
+
+	/* Only migrate 1 task if we're idle */
 	if (!idle && --imbalance) {
 		if (curr != head)
 			goto skip_queue;
@@ -1171,20 +1284,6 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
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
@@ -1201,17 +1300,11 @@ void scheduler_tick(int user_ticks, int 
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
 
-	/* note: this timer irq context must be accounted for as well */
-	if (hardirq_count() - HARDIRQ_OFFSET) {
-		cpustat->irq += sys_ticks;
-		sys_ticks = 0;
-	} else if (softirq_count()) {
-		cpustat->softirq += sys_ticks;
-		sys_ticks = 0;
-	}
-
 	if (p == rq->idle) {
-		if (atomic_read(&rq->nr_iowait) > 0)
+		/* note: this timer irq context must be accounted for as well */
+		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
+			cpustat->system += sys_ticks;
+		else if (atomic_read(&rq->nr_iowait) > 0)
 			cpustat->iowait += sys_ticks;
 		else
 			cpustat->idle += sys_ticks;
@@ -1232,43 +1325,39 @@ void scheduler_tick(int user_ticks, int 
 	spin_lock(&rq->lock);
 	/*
 	 * The task was running during this tick - update the
-	 * time slice counter and the sleep average. Note: we
-	 * do not update a thread's priority until it either
-	 * goes to sleep or uses up its timeslice. This makes
-	 * it possible for interactive tasks to use up their
-	 * timeslices at their highest priority levels.
+	 * time slice counter. Note: we do not update a thread's
+	 * priority until it either goes to sleep or uses up its
+	 * timeslice.
 	 */
-	if (p->sleep_avg)
-		p->sleep_avg--;
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
+			if (p->used_slice >= task_timeslice(p, rq)) {
+				p->used_slice = 0;
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
+	if (p->used_slice >= task_timeslice(p, rq)) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
-		p->prio = effective_prio(p);
-		p->time_slice = task_timeslice(p);
+		p->prio = task_priority(p);
+		p->used_slice = 0;
 		p->first_time_slice = 0;
 
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			if (!rq->expired_timestamp)
-				rq->expired_timestamp = jiffies;
-			enqueue_task(p, rq->expired);
-		} else
-			enqueue_task(p, rq->active);
+		enqueue_task(p, rq->expired);
 	}
 out_unlock:
 	spin_unlock(&rq->lock);
@@ -1287,6 +1376,8 @@ asmlinkage void schedule(void)
 	runqueue_t *rq;
 	prio_array_t *array;
 	struct list_head *queue;
+	unsigned long now;
+	unsigned long run_time;
 	int idx;
 
 	/*
@@ -1307,7 +1398,11 @@ need_resched:
 	rq = this_rq();
 
 	release_kernel_lock(prev);
-	prev->last_run = jiffies;
+	now = jiffies;
+	run_time = now - prev->timestamp;
+
+	add_task_time(prev, run_time, STIME_RUN);
+
 	spin_lock_irq(&rq->lock);
 
 	/*
@@ -1336,7 +1431,6 @@ pick_next_task:
 			goto pick_next_task;
 #endif
 		next = rq->idle;
-		rq->expired_timestamp = 0;
 		goto switch_tasks;
 	}
 
@@ -1345,10 +1439,10 @@ pick_next_task:
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
@@ -1360,7 +1454,10 @@ switch_tasks:
 	clear_tsk_need_resched(prev);
 	RCU_qsctr(task_cpu(prev))++;
 
+	prev->timestamp = now;
 	if (likely(prev != next)) {
+		add_task_time(next, now - next->timestamp, STIME_WAIT);
+		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
 
@@ -1600,6 +1697,7 @@ void set_user_nice(task_t *p, long nice)
 	unsigned long flags;
 	prio_array_t *array;
 	runqueue_t *rq;
+	int old_prio, new_prio, delta;
 
 	if (TASK_NICE(p) == nice || nice < -20 || nice > 19)
 		return;
@@ -1608,6 +1706,12 @@ void set_user_nice(task_t *p, long nice)
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
 	rq = task_rq_lock(p, &flags);
+	/*
+	 * The RT priorities are set via setscheduler(), but we still
+	 * allow the 'normal' nice value to be set - but as expected
+	 * it wont have any effect on scheduling until the task is
+	 * not SCHED_NORMAL:
+	 */
 	if (rt_task(p)) {
 		p->static_prio = NICE_TO_PRIO(nice);
 		goto out_unlock;
@@ -1615,16 +1719,20 @@ void set_user_nice(task_t *p, long nice)
 	array = p->array;
 	if (array)
 		dequeue_task(p, array);
+
+	old_prio = p->prio;
+	new_prio = NICE_TO_PRIO(nice);
+	delta = new_prio - old_prio;
 	p->static_prio = NICE_TO_PRIO(nice);
-	p->prio = NICE_TO_PRIO(nice);
+	p->prio += delta;
+
 	if (array) {
 		enqueue_task(p, array);
 		/*
-		 * If the task is running and lowered its priority,
-		 * or increased its priority then reschedule its CPU:
+		 * If the task increased its priority or is running and
+		 * lowered its priority, then reschedule its CPU:
 		 */
-		if ((NICE_TO_PRIO(nice) < p->static_prio) ||
-							task_running(rq, p))
+		if (delta < 0 || (delta > 0 && task_running(rq, p)))
 			resched_task(rq->curr);
 	}
 out_unlock:
@@ -2139,6 +2247,8 @@ asmlinkage long sys_sched_rr_get_interva
 	int retval = -EINVAL;
 	struct timespec t;
 	task_t *p;
+	unsigned long flags;
+	runqueue_t *rq;
 
 	if (pid < 0)
 		goto out_nounlock;
@@ -2153,8 +2263,10 @@ asmlinkage long sys_sched_rr_get_interva
 	if (retval)
 		goto out_unlock;
 
+	rq = task_rq_lock(p, &flags);
 	jiffies_to_timespec(p->policy & SCHED_FIFO ?
-				0 : task_timeslice(p), &t);
+				0 : task_timeslice(p, rq), &t);
+	task_rq_unlock(rq, &flags);
 	read_unlock(&tasklist_lock);
 	retval = copy_to_user(interval, &t, sizeof(t)) ? -EFAULT : 0;
 out_nounlock:

_

--------------010601000504010602030100--

