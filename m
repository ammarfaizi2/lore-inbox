Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270159AbTGZPyq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 11:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269559AbTGZPw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 11:52:56 -0400
Received: from nice-1-a7-62-147-78-228.dial.proxad.net ([62.147.78.228]:37381
	"EHLO monpc") by vger.kernel.org with ESMTP id S269641AbTGZPv1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 11:51:27 -0400
From: Guillaume Chazarain <gfc@altern.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Davide Libenzi <davidel@xmailserver.org>, Mike Galbraith <efault@gmx.de>,
       linux-kernel@vger.kernel.org
Date: Sat, 26 Jul 2003 18:09:27 +0200
X-Priority: 3 (Normal)
Message-Id: <VRC7KGZX0573CW1TPN65C3Y312IC.3f22a7b7@monpc>
Subject: Re: [patch] sched-2.6.0-test1-G3, interactivity changes, audio latency
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
X-Mailer: Opera 6.06 build 1145
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> - cycle accuracy (nanosec resolution) timekeeping within the scheduler. 
>   This fixes a number of audio artifacts (skipping) i've reproduced. I
>   dont think we can get away without going cycle accuracy - reading the
>   cycle counter adds some overhead, but it's acceptable. The first
>   nanosec-accuracy patch was done by Mike Galbraith - this patch is
>   different but similar in nature. I went further in also changing the
>   sleep_avg to be of nanosec resolution.

I'd like to have your opinion on this, in 2.6.0-test1 we have:

static inline void activate_task(task_t *p, runqueue_t *rq)
{
        long sleep_time = jiffies - p->last_run - 1;

I'd like to have it back to jiffies - p->last_run. See why:
suppose jiffies - p->last_run == 1, here are the extremum timescales
possible for this: (S: sleep, W: wake up)

             p->last_run     jiffies
time:      |-------------|------------->
longest:    S                         W   => sleep_time = 2
shortest:               S W               => sleep_time = 0

That is, when jiffies - p->last_run == 1, all we know is that sleep_time
is between 0 and 2.  And currently we take 0 for sleep_time in this case.
Wouldn't it be more accurate to take 1 as a better approximation for something
between 0 and 2?  This is a sensible thing to me, because it makes mplayer
move from max CPU hog to max interactive.  When I see that mplayer uses only
10% of the cpu, it makes some sense.
BTW, with your nanosecond resolution, mplayer is also max interactive.
Don't you find it strange to need a nanosecond resolution to evaluate a simple
integer in a [-5, 5] range?

> - more finegrained timeslices: there's now a timeslice 'sub unit' of 50 
>   usecs (TIMESLICE_GRANULARITY) - CPU hogs on the same priority level 
>   will roundrobin with this unit. This change is intended to make gaming
>   latencies shorter.

Strange that no one complained about the throughput.  Anyway I don't care too.

> - include scheduling latency in sleep bonus calculation. This change 
>
>   extends the sleep-average calculation to the period of time a task
>   spends on the runqueue but doesnt get scheduled yet, right after
>   wakeup. Note that tasks that were preempted (ie. not woken up) and are 
>   still on the runqueue do not get this benefit. This change closes one 
>   of the last hole in the dynamic priority estimation, it should result 
>   in interactive tasks getting more priority under heavy load. This
>   change also fixes the test-starve.c testcase from David Mosberger.

Right, it solves test-starve.c, but not irman2.c.  With sched-G4, when irman2
is launched, a kernel compile could take ages, I tried it.  After 3 hours it
was still with the first file (scripts/fixdep.c), it produced no .o file.
With the patch at the end a kernel compile takes one hour (with -j1 and -j16)
versus five minutes when nothing else runs (config: allnoconfig).

The idea in the patch is to keep a list of the tasks on the runqueue, without
the one currently running, and sorted by insertion date.  Before reinserting an
interactive task in the active array, we check that no task has waited too
long on this list.  Davide, does it implement the interactivity throttle you had
in mind?

It's very similar to EXPIRED_STARVING(), but it has the advantage of considering
all tasks, not only the expired. It seems that with irman2, tasks don't even
have the time to expire.


Regards,
Guillaume




--- linux-2.6.0-test1/include/linux/sched.h
+++ linux-2.6.0-test1-gfc/include/linux/sched.h
@@ -335,6 +335,8 @@
 
 	int prio, static_prio;
 	struct list_head run_list;
+	unsigned long activated_timestamp;
+	struct list_head activated_list;
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
--- linux-2.6.0-test1/kernel/fork.c
+++ linux-2.6.0-test1-gfc/kernel/fork.c
@@ -839,6 +839,7 @@
 	p->proc_dentry = NULL;
 
 	INIT_LIST_HEAD(&p->run_list);
+	INIT_LIST_HEAD(&p->activated_list);
 
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
--- linux-2.6.0-test1/kernel/sched.c
+++ linux-2.6.0-test1-gfc/kernel/sched.c
@@ -74,14 +74,14 @@
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(10*HZ)
-#define STARVATION_LIMIT	(10*HZ)
+#define STARVATION_LIMIT	MAX_TIMESLICE
 #define NODE_THRESHOLD		125
 
 /*
- * If a task is 'interactive' then we reinsert it in the active
- * array after it has expired its current timeslice. (it will not
- * continue to run immediately, it will still roundrobin with
- * other interactive tasks.)
+ * If a task is 'interactive' and there is no starvation, then we
+ * reinsert it in the active array after it has expired its current
+ * timeslice. (it will not continue to run immediately, it will still
+ * roundrobin with other interactive tasks.)
  *
  * This part scales the interactivity limit depending on niceness.
  *
@@ -157,11 +157,11 @@
  */
 struct runqueue {
 	spinlock_t lock;
-	unsigned long nr_running, nr_switches, expired_timestamp,
-			nr_uninterruptible;
+	unsigned long nr_running, nr_switches, nr_uninterruptible;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
+	struct list_head activated_list;
 	int prev_cpu_load[NR_CPUS];
 #ifdef CONFIG_NUMA
 	atomic_t *node_nr_running;
@@ -330,6 +330,17 @@
 	return prio;
 }
 
+static inline void activated_task(task_t *p, runqueue_t *rq)
+{
+	if (likely(p != rq->idle) &&
+	    likely(!rt_task(p)) && 
+	    likely(!p->activated_list.next)) {
+
+		list_add_tail(&p->activated_list, &rq->activated_list);
+		p->activated_timestamp = jiffies;
+	}
+}
+
 /*
  * __activate_task - move a task to the runqueue.
  */
@@ -337,6 +348,7 @@
 {
 	enqueue_task(p, rq->active);
 	nr_running_inc(rq);
+	activated_task(p, rq);
 }
 
 /*
@@ -563,6 +575,7 @@
 		p->array = current->array;
 		p->array->nr_active++;
 		nr_running_inc(rq);
+		activated_task(p, rq);
 	}
 	task_rq_unlock(rq, &flags);
 }
@@ -1155,15 +1168,34 @@
  * We place interactive tasks back into the active array, if possible.
  *
  * To guarantee that this does not starve expired tasks we ignore the
- * interactivity of a task if the first expired task had to wait more
- * than a 'reasonable' amount of time. This deadline timeout is
- * load-dependent, as the frequency of array switched decreases with
- * increasing number of running tasks:
- */
-#define EXPIRED_STARVING(rq) \
-		(STARVATION_LIMIT && ((rq)->expired_timestamp && \
-		(jiffies - (rq)->expired_timestamp >= \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
+ * interactivity of a task if a task had to wait more than a 'reasonable'
+ * amount of time. This deadline timeout is load-dependent, as the frequency
+ * of array switched decreases with increasing number of running tasks:
+ */
+static inline int runqueue_starvation(runqueue_t *rq)
+{
+	struct task_struct *first;
+	unsigned long delay;
+
+	if (list_empty(&rq->activated_list))
+		return 0;
+
+	first = list_entry(rq->activated_list.next, task_t, activated_list);
+	delay = jiffies - first->activated_timestamp;
+
+	if (unlikely(delay > rq->nr_running * STARVATION_LIMIT)) {
+		list_del(&first->run_list);
+		list_add(&first->run_list, first->array->queue + first->prio);
+
+		/* DEBUG */
+		printk("%d (%s) is starved (%lu ms) ", first->pid,
+		       first->comm, delay - rq->nr_running * MAX_TIMESLICE);
+		printk("punishing %d (%s)\n", current->pid, current->comm);
+		return 1;
+	}
+
+	return 0;
+}
 
 /*
  * This function gets called by the timer code, with HZ frequency.
@@ -1238,11 +1270,9 @@
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			if (!rq->expired_timestamp)
-				rq->expired_timestamp = jiffies;
+		if (!TASK_INTERACTIVE(p) || unlikely(runqueue_starvation(rq)))
 			enqueue_task(p, rq->expired);
-		} else
+		else
 			enqueue_task(p, rq->active);
 	}
 out_unlock:
@@ -1251,6 +1281,28 @@
 	rebalance_tick(rq, 0);
 }
 
+static inline void prepare_switch(runqueue_t *rq, task_t *prev, task_t *next)
+{
+	/* prev has been preempted. */
+	if (prev->state == TASK_RUNNING ||
+	    unlikely(preempt_count() & PREEMPT_ACTIVE))
+		activated_task(prev, rq);
+
+	/* next is no more waiting for being scheduled. */
+	if (likely(next != rq->idle) &&
+	    likely(!rt_task(next))) {
+		if (likely(next->activated_list.next != NULL)) {
+			list_del(&next->activated_list);
+			next->activated_list.next = NULL;
+		} else {
+			/* DEBUG */
+			dump_stack();
+			printk("not activated: %d (%s)\n", next->pid,
+			next->comm);
+		}
+	}
+}
+
 void scheduling_functions_start_here(void) { }
 
 /*
@@ -1311,7 +1363,6 @@
 			goto pick_next_task;
 #endif
 		next = rq->idle;
-		rq->expired_timestamp = 0;
 		goto switch_tasks;
 	}
 
@@ -1323,7 +1374,6 @@
 		rq->active = rq->expired;
 		rq->expired = array;
 		array = rq->active;
-		rq->expired_timestamp = 0;
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
@@ -1336,6 +1386,8 @@
 	RCU_qsctr(task_cpu(prev))++;
 
 	if (likely(prev != next)) {
+		prepare_switch(rq, prev, next);
+
 		rq->nr_switches++;
 		rq->curr = next;
 
@@ -2497,6 +2549,7 @@
 		rq = cpu_rq(i);
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
+		INIT_LIST_HEAD(&rq->activated_list);
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		atomic_set(&rq->nr_iowait, 0);




