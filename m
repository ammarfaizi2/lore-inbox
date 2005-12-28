Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVL1GZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVL1GZG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 01:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVL1GZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 01:25:06 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:60029 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751150AbVL1GZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 01:25:01 -0500
Message-ID: <43B22FBA.5040008@bigpond.net.au>
Date: Wed, 28 Dec 2005 17:24:58 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>
Subject: [RFC] CPU scheduler: Simplified interactive bonus mechanism
Content-Type: multipart/mixed;
 boundary="------------070409010506040101090403"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 28 Dec 2005 06:24:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070409010506040101090403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch implements a prototype version of a simplified interactive
bonus mechanism.  The mechanism does not attempt to identify interactive
tasks and give them a bonus (like the current mechanism does) but
instead attacks the problem that the bonuses are supposed to fix,
unacceptable interactive latency, directly.

It does this by measuring every interactive latency and using a Kalman
filter to estimate a running average of each tasks' interactive latency.
   This average is then compared to an "unacceptable interactive latency"
value and if it is above this the task's interactive bonus is increased
and otherwise it is compared to an "acceptable interactive latency"
value and if it is above this value the task's interactive bonus is
decreased.  This results in the the task's tending to stabilize at a
value that keeps its interactive latency between the two limits.

As a first approximation this mechanism assumes that all uninterruptible 
sleeps are not interactive and that all interruptible sleeps are unless 
they are tagged with the TASK_NONINTERACTIVE flag.

Advantages:

1. Simple and (arguably) easy to understand mechanism.
2. Tasks only get interactive bonuses when they need them and this
should reduce the amount of preemption that occurs which in turn should
reduce the context switching rate.
3.  It seems to work (at least for me).

Problems addressed:

1. If a task that has acquired an interactive bonus suddenly becomes CPU
bound and interactive bonuses are only assessed at wake up they will
retain their bonus.  This problem is addressed by decrementing all tasks
interactive bonuses at the end of their time slice.

Problems not addressed:

1. Like the current mechanism, this mechanism is sub optimal if non
interactive sleeps are identified as interactive.  This problem be fixed
with more widespread (but judicious) use of TASK_INTERACTIVE.

Things that could be better:

1. The mechanism for decreasing interactive bonuses for CPU bound tasks
could be better targetted.

Possible Modifications:

1. Increase the maximum available interactive bonus to 19.
2. Do not award interactive bonuses to tasks with nice values greater
than zero on the assumption that this is a declaration that interactive
latency is not an issue for these tasks.
3. Move the smoothing from the interactive latency to the interactive
bonus.  I.e. use the raw interactive latency to decide whether the
current bonus is increased, decreased or left alone but use a Kalman
filter to smooth the bonus value.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

---

Your comments on this proposal are requested.

---
   fs/proc/array.c       |    4
   include/linux/sched.h |   19 ++
   kernel/sched.c        |  259 +++++++++++-----------------------------
   3 files changed, 90 insertions(+), 192 deletions(-)

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
   -- Ambrose Bierce


--------------070409010506040101090403
Content-Type: text/plain;
 name="new-ia-bonus-mechanism"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="new-ia-bonus-mechanism"

Index: GIT_lial/fs/proc/array.c
===================================================================
--- GIT_lial.orig/fs/proc/array.c	2005-12-28 12:09:25.000000000 +1100
+++ GIT_lial/fs/proc/array.c	2005-12-28 15:07:50.000000000 +1100
@@ -165,7 +165,7 @@ static inline char * task_state(struct t
 	read_lock(&tasklist_lock);
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
-		"SleepAVG:\t%lu%%\n"
+		"IALatencyAVG:\t%llu nsec\n"
 		"Tgid:\t%d\n"
 		"Pid:\t%d\n"
 		"PPid:\t%d\n"
@@ -173,7 +173,7 @@ static inline char * task_state(struct t
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
-		(p->sleep_avg/1024)*100/(1020000000/1024),
+		IAL_AVG_RND(p->avg_ia_latency),
 	       	p->tgid,
 		p->pid, pid_alive(p) ? p->group_leader->real_parent->tgid : 0,
 		pid_alive(p) && p->ptrace ? p->parent->pid : 0,
Index: GIT_lial/include/linux/sched.h
===================================================================
--- GIT_lial.orig/include/linux/sched.h	2005-12-28 12:09:26.000000000 +1100
+++ GIT_lial/include/linux/sched.h	2005-12-28 15:11:14.000000000 +1100
@@ -683,6 +683,19 @@ static inline void prefetch_stack(struct
 struct audit_context;		/* See audit.c */
 struct mempolicy;
 
+/*
+ * Fixed denominator rational numbers for use estimating task's average
+ * interactive latency
+ */
+#define IAL_AVG_OFFSET 4
+/*
+ * Get the rounded integer value of a scheduling statistic average field
+ * Needs to be public for printing average interactive latency in
+ * fs/proc/array.c
+ */
+#define IAL_AVG_RND(x) \
+	(((x) + (1 << (IAL_AVG_OFFSET - 1))) >> (IAL_AVG_OFFSET))
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -695,16 +708,15 @@ struct task_struct {
 #if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
 	int oncpu;
 #endif
-	int prio, static_prio;
+	int prio, static_prio, ia_bonus;
 	struct list_head run_list;
 	prio_array_t *array;
 
 	unsigned short ioprio;
 
-	unsigned long sleep_avg;
+	unsigned long long avg_ia_latency;
 	unsigned long long timestamp, last_ran;
 	unsigned long long sched_time; /* sched_clock time spent running */
-	int activated;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
@@ -908,6 +920,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
+#define PF_IA_WAKE_UP   0x01000000      /* just woken from an interactive sleep */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: GIT_lial/kernel/sched.c
===================================================================
--- GIT_lial.orig/kernel/sched.c	2005-12-28 12:09:27.000000000 +1100
+++ GIT_lial/kernel/sched.c	2005-12-28 15:11:18.000000000 +1100
@@ -84,16 +84,10 @@
  */
 #define MIN_TIMESLICE		max(5 * HZ / 1000, 1)
 #define DEF_TIMESLICE		(100 * HZ / 1000)
-#define ON_RUNQUEUE_WEIGHT	 30
-#define CHILD_PENALTY		 95
-#define PARENT_PENALTY		100
-#define EXIT_WEIGHT		  3
 #define PRIO_BONUS_RATIO	 25
 #define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
 #define INTERACTIVE_DELTA	  2
-#define MAX_SLEEP_AVG		(DEF_TIMESLICE * MAX_BONUS)
-#define STARVATION_LIMIT	(MAX_SLEEP_AVG)
-#define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
+#define STARVATION_LIMIT       	(DEF_TIMESLICE * MAX_BONUS)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -123,9 +117,7 @@
  * too hard.
  */
 
-#define CURRENT_BONUS(p) \
-	(NS_TO_JIFFIES((p)->sleep_avg) * MAX_BONUS / \
-		MAX_SLEEP_AVG)
+#define CURRENT_BONUS(p) ((p)->ia_bonus)
 
 #define GRANULARITY	(10 * HZ / 1000 ? : 1)
 
@@ -147,13 +139,50 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
-#define INTERACTIVE_SLEEP(p) \
-	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
-		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
-
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
 
+#define IAL_AVG_REAL(a) ((a) << IAL_AVG_OFFSET)
+#define IAL_AVG_ALPHA ((1 << IAL_AVG_OFFSET) - 1)
+
+/* The range of acceptable interactive latencies in nanosecs */
+#define UNACCEPTABLE_IA_LATENCY IAL_AVG_REAL(800000UL)
+#define ACCEPTABLE_IA_LATENCY (UNACCEPTABLE_IA_LATENCY >> 8)
+
+static inline void incr_ia_bonus(task_t *p)
+{
+	if (p->ia_bonus < MAX_BONUS)
+		++p->ia_bonus;
+}
+
+static inline void decr_ia_bonus(task_t *p)
+{
+	if (p->ia_bonus > 0)
+		--p->ia_bonus;
+}
+
+static void update_avg_ia_latency(task_t *p, unsigned long long now)
+{
+	long long delta = now - p->timestamp;
+
+	p->flags &= ~PF_IA_WAKE_UP;
+	p->avg_ia_latency *= IAL_AVG_ALPHA;
+	p->avg_ia_latency >>= IAL_AVG_OFFSET;
+	/* make allowance for sched_clock() not being monotonic */
+	if (unlikely(delta > 0))
+		p->avg_ia_latency += delta;
+
+	if (p->avg_ia_latency > UNACCEPTABLE_IA_LATENCY)
+		incr_ia_bonus(p);
+	else if (p->avg_ia_latency < ACCEPTABLE_IA_LATENCY)
+		decr_ia_bonus(p);
+}
+
+static inline int just_woken_from_ia_sleep(task_t *p)
+{
+	return p->flags & PF_IA_WAKE_UP;
+}
+
 /*
  * task_timeslice() scales user-nice values [ -20 ... 0 ... 19 ]
  * to time slice values: [800ms ... 100ms ... 5ms]
@@ -633,9 +662,6 @@ static inline void enqueue_task_head(str
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
  *
- * We scale the actual sleep average [0 .... MAX_SLEEP_AVG]
- * into the -5 ... 0 ... +5 bonus/penalty range.
- *
  * We use 25% of the full 0...39 priority range so that:
  *
  * 1) nice +19 interactive tasks do not preempt nice 0 CPU hogs.
@@ -733,68 +759,6 @@ static inline void __activate_idle_task(
 	inc_nr_running(p, rq);
 }
 
-static int recalc_task_prio(task_t *p, unsigned long long now)
-{
-	/* Caller must always ensure 'now >= p->timestamp' */
-	unsigned long long __sleep_time = now - p->timestamp;
-	unsigned long sleep_time;
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
-
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
-
-			/*
-			 * This code gives a bonus to interactive tasks.
-			 *
-			 * The boost works by updating the 'average sleep time'
-			 * value here, based on ->timestamp. The more time a
-			 * task spends sleeping, the higher the average gets -
-			 * and the higher the priority boost gets as well.
-			 */
-			p->sleep_avg += sleep_time;
-
-			if (p->sleep_avg > NS_MAX_SLEEP_AVG)
-				p->sleep_avg = NS_MAX_SLEEP_AVG;
-		}
-	}
-
-	return effective_prio(p);
-}
-
 /*
  * activate_task - move a task to the runqueue and do priority recalculation
  *
@@ -816,30 +780,8 @@ static void activate_task(task_t *p, run
 #endif
 
 	if (!rt_task(p))
-		p->prio = recalc_task_prio(p, now);
+		p->prio = effective_prio(p);
 
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
 	p->timestamp = now;
 
 	__activate_task(p, rq);
@@ -1353,25 +1295,19 @@ out_set_cpu:
 
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
-
 	/*
-	 * Tasks that have marked their sleep as noninteractive get
-	 * woken up without updating their sleep average. (i.e. their
-	 * sleep is handled in a priority-neutral manner, no priority
-	 * boost and no penalty.)
+	 * uninterruptible sleeps are assumed to be non interactive.
+	 * interruptible sleeps are assumed to be interactive unless
+	 * tagged with the TASK_NONINTERACTIVE flag.
 	 */
-	if (old_state & TASK_NONINTERACTIVE)
-		__activate_task(p, rq);
+	if (old_state == TASK_INTERRUPTIBLE)
+		p->flags |= PF_IA_WAKE_UP;
 	else
-		activate_task(p, rq, cpu == this_cpu);
+		p->flags &= ~PF_IA_WAKE_UP;
+
+	activate_task(p, rq, cpu == this_cpu);
 	/*
 	 * Sync wakeups (i.e. those types of wakeups where the waker
 	 * has indicated that it will leave the CPU in short order)
@@ -1421,6 +1357,15 @@ void fastcall sched_fork(task_t *p, int 
 	set_task_cpu(p, cpu);
 
 	/*
+	 * if this is a thread leave its bonus and average latency the
+	 * same as the parent.  Otherwise reset tehm to zero.
+	 */
+	if (p->pid == p->tgid) {
+		p->ia_bonus = 0;
+		p->avg_ia_latency = 0;
+	}
+
+	/*
 	 * We mark the process as running here, but have not actually
 	 * inserted it onto the runqueue yet. This guarantees that
 	 * nobody will actually run it, and a signal or other external
@@ -1477,22 +1422,13 @@ void fastcall wake_up_new_task(task_t *p
 {
 	unsigned long flags;
 	int this_cpu, cpu;
-	runqueue_t *rq, *this_rq;
+	runqueue_t *rq;
 
 	rq = task_rq_lock(p, &flags);
 	BUG_ON(p->state != TASK_RUNNING);
 	this_cpu = smp_processor_id();
 	cpu = task_cpu(p);
 
-	/*
-	 * We decrease the sleep average of forking parents
-	 * and children as well, to keep max-interactive tasks
-	 * from forking tasks that are max-interactive. The parent
-	 * (current) is done further down, under its lock.
-	 */
-	p->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
-		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
-
 	p->prio = effective_prio(p);
 
 	if (likely(cpu == this_cpu)) {
@@ -1515,15 +1451,8 @@ void fastcall wake_up_new_task(task_t *p
 		} else
 			/* Run child last */
 			__activate_task(p, rq);
-		/*
-		 * We skip the following code due to cpu == this_cpu
-	 	 *
-		 *   task_rq_unlock(rq, &flags);
-		 *   this_rq = task_rq_lock(current, &flags);
-		 */
-		this_rq = rq;
 	} else {
-		this_rq = cpu_rq(this_cpu);
+		runqueue_t *this_rq = cpu_rq(this_cpu);
 
 		/*
 		 * Not the local CPU - must adjust timestamp. This should
@@ -1534,17 +1463,8 @@ void fastcall wake_up_new_task(task_t *p
 		__activate_task(p, rq);
 		if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
-
-		/*
-		 * Parent and child are on different CPUs, now get the
-		 * parent runqueue to update the parent's ->sleep_avg:
-		 */
-		task_rq_unlock(rq, &flags);
-		this_rq = task_rq_lock(current, &flags);
 	}
-	current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
-		PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
-	task_rq_unlock(this_rq, &flags);
+	task_rq_unlock(rq, &flags);
 }
 
 /*
@@ -1571,10 +1491,6 @@ void fastcall sched_exit(task_t *p)
 		if (unlikely(p->parent->time_slice > task_timeslice(p)))
 			p->parent->time_slice = task_timeslice(p);
 	}
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = p->parent->sleep_avg /
-		(EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg /
-		(EXIT_WEIGHT + 1);
 	task_rq_unlock(rq, &flags);
 }
 
@@ -2689,6 +2605,10 @@ void scheduler_tick(void)
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
+		/* make sure that tasks that obtain an ia_bonus but then
+		 * become CPU bound eventually lose the bonus.
+		 */
+		decr_ia_bonus(p);
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
@@ -2949,8 +2869,7 @@ asmlinkage void __sched schedule(void)
 	prio_array_t *array;
 	struct list_head *queue;
 	unsigned long long now;
-	unsigned long run_time;
-	int cpu, idx, new_prio;
+	int cpu, idx;
 
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
@@ -2985,18 +2904,6 @@ need_resched_nonpreemptible:
 
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
 
@@ -3063,25 +2970,6 @@ go_idle:
 	queue = array->queue + idx;
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
@@ -3091,14 +2979,12 @@ switch_tasks:
 	rcu_qsctr_inc(task_cpu(prev));
 
 	update_cpu_clock(prev, rq, now);
-
-	prev->sleep_avg -= run_time;
-	if ((long)prev->sleep_avg <= 0)
-		prev->sleep_avg = 0;
 	prev->timestamp = prev->last_ran = now;
 
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
+		if (just_woken_from_ia_sleep(next))
+			update_avg_ia_latency(next, now);
 		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
@@ -4394,7 +4280,6 @@ void __devinit init_idle(task_t *idle, i
 	runqueue_t *rq = cpu_rq(cpu);
 	unsigned long flags;
 
-	idle->sleep_avg = 0;
 	idle->array = NULL;
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;


--------------070409010506040101090403--
