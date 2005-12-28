Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbVL1Igh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVL1Igh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 03:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVL1Igh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 03:36:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:7377 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932507AbVL1Igg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 03:36:36 -0500
Date: Wed, 28 Dec 2005 09:36:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] CPU scheduler: Simplified interactive bonus mechanism
Message-ID: <20051228083615.GA12180@elte.hu>
References: <43B22FBA.5040008@bigpond.net.au> <20051228080029.GA5641@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228080029.GA5641@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
> > This patch implements a prototype version of a simplified interactive 
> > bonus mechanism.  The mechanism does not attempt to identify 
> > interactive tasks and give them a bonus (like the current mechanism 
> > does) but instead attacks the problem that the bonuses are supposed to 
> > fix, unacceptable interactive latency, directly.
> 
> i think we could give this one a workout in -mm, to see the actual 
> effects. Would you mind to merge this to -mm's scheduler queue, to right 
> after sched-add-sched_batch-policy.patch?

i have done this for latest -mm, see the patch below (i also merged your 
patch to the SCHED_BATCH patch's effects), but the resulting kernel has 
really bad interactivity: e.g. simply starting 4 CPU hogs on a 2-CPU 
system slows down shell commands like 'ls' noticeably. So NACK for the 
time being.

	Ingo

--------
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
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 fs/proc/array.c       |    4 
 include/linux/sched.h |   20 +++
 kernel/sched.c        |  273 ++++++++++++++------------------------------------
 3 files changed, 99 insertions(+), 198 deletions(-)

Index: linux/fs/proc/array.c
===================================================================
--- linux.orig/fs/proc/array.c
+++ linux/fs/proc/array.c
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
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -688,6 +688,19 @@ static inline void prefetch_stack(struct
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
@@ -703,7 +716,7 @@ struct task_struct {
 	int oncpu;
 #endif
 #endif
-	int prio, static_prio;
+	int prio, static_prio, ia_bonus;
 #ifdef CONFIG_SMP
 	int bias_prio;
 #endif
@@ -712,10 +725,9 @@ struct task_struct {
 
 	unsigned short ioprio;
 
-	unsigned long sleep_avg;
+	unsigned long long avg_ia_latency;
 	unsigned long long timestamp, last_ran;
 	unsigned long long sched_time; /* sched_clock time spent running */
-	int activated;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
@@ -929,6 +941,8 @@ static inline void put_task_struct(struc
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
 #define PF_SWAPWRITE	0x01000000	/* Allowed to write to swap */
+#define PF_IA_WAKE_UP	0x02000000	/* just woken from an interactive sleep */
+
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -95,16 +95,10 @@
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
@@ -134,9 +128,7 @@
  * too hard.
  */
 
-#define CURRENT_BONUS(p) \
-	(NS_TO_JIFFIES((p)->sleep_avg) * MAX_BONUS / \
-		MAX_SLEEP_AVG)
+#define CURRENT_BONUS(p) ((p)->ia_bonus)
 
 #define GRANULARITY	(10 * HZ / 1000 ? : 1)
 
@@ -158,13 +150,54 @@
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
+	long long delta;
+
+	if (p->policy == SCHED_BATCH)
+		return;
+
+	delta = now - p->timestamp;
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
@@ -651,9 +684,6 @@ static inline void enqueue_task_head(str
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
  *
- * We scale the actual sleep average [0 .... MAX_SLEEP_AVG]
- * into the -5 ... 0 ... +5 bonus/penalty range.
- *
  * We use 25% of the full 0...39 priority range so that:
  *
  * 1) nice +19 interactive tasks do not preempt nice 0 CPU hogs.
@@ -758,72 +788,6 @@ static inline void __activate_idle_task(
 	inc_nr_running(p, rq);
 }
 
-static int recalc_task_prio(task_t *p, unsigned long long now)
-{
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
@@ -845,30 +809,8 @@ static void activate_task(task_t *p, run
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
@@ -1355,25 +1297,19 @@ out_set_cpu:
 
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
@@ -1423,6 +1359,15 @@ void fastcall sched_fork(task_t *p, int 
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
@@ -1482,22 +1427,13 @@ void fastcall wake_up_new_task(task_t *p
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
@@ -1520,15 +1456,8 @@ void fastcall wake_up_new_task(task_t *p
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
@@ -1539,17 +1468,8 @@ void fastcall wake_up_new_task(task_t *p
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
@@ -1576,10 +1496,6 @@ void fastcall sched_exit(task_t *p)
 		if (unlikely(p->parent->time_slice > task_timeslice(p)))
 			p->parent->time_slice = task_timeslice(p);
 	}
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = p->parent->sleep_avg /
-		(EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg /
-		(EXIT_WEIGHT + 1);
 	task_rq_unlock(rq, &flags);
 }
 
@@ -2703,6 +2619,10 @@ void scheduler_tick(void)
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
@@ -2963,8 +2883,7 @@ asmlinkage void __sched schedule(void)
 	prio_array_t *array;
 	struct list_head *queue;
 	unsigned long long now;
-	unsigned long run_time;
-	int cpu, idx, new_prio;
+	int cpu, idx;
 
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
@@ -2999,18 +2918,6 @@ need_resched_nonpreemptible:
 
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
 
@@ -3077,25 +2984,6 @@ go_idle:
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
@@ -3105,14 +2993,12 @@ switch_tasks:
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
@@ -3718,8 +3604,10 @@ static void __setscheduler(struct task_s
 		/*
 		 * SCHED_BATCH tasks are treated as perpetual CPU hogs:
 		 */
-		if (policy == SCHED_BATCH)
-			p->sleep_avg = 0;
+		if (policy == SCHED_BATCH) {
+			p->avg_ia_latency = 0;
+			p->ia_bonus = 0;
+		}
 	}
 	set_bias_prio(p);
 }
@@ -4431,7 +4319,6 @@ void __devinit init_idle(task_t *idle, i
 	runqueue_t *rq = cpu_rq(cpu);
 	unsigned long flags;
 
-	idle->sleep_avg = 0;
 	idle->array = NULL;
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
