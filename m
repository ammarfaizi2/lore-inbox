Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262065AbSI3QEy>; Mon, 30 Sep 2002 12:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262077AbSI3QEy>; Mon, 30 Sep 2002 12:04:54 -0400
Received: from [195.223.140.120] ([195.223.140.120]:38706 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262065AbSI3QEs>; Mon, 30 Sep 2002 12:04:48 -0400
Date: Mon, 30 Sep 2002 18:10:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jim Houston <jim.houston@attbi.com>
Cc: linux-kernel@vger.kernel.org, jim.houston@ccur.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: O(1) Scheduler (tuning problem/live-lock)
Message-ID: <20020930161019.GH1235@dualathlon.random>
References: <200209061844.g86IiF701825@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209061844.g86IiF701825@linux.local>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 02:44:15PM -0400, Jim Houston wrote:
> 
>    The current O(1) scheduler heuristics for calculating sleep_avg
>    and assigning process priorities allows a parent and a small group of 
>    compute bound child processes to live-lock the system.  
>    We found this problem running a stress test including the LTP
>    test suite.  In particular the waitpid06 test in the LTP triggered
>    this problem.  We are working with a 2.4.18 kernel with a backport of
>    the O(1) scheduler, but this problem is present in Linux-2.5.32.
> 
> How it happens.
> 
>    The waitpid06 test forks off 8 child processes.  Each child enters
>    an infinite loop waiting for a signal from the parent.  Yes, it's
>    a stupid test program.  The parent (if it gets to run) immediately sends
>    a signal to each child process and then does a wait() call for each child.
>    
>    The parent process spends all of its time in wait().  When a child
>    exits, the parents sleep_avg is adjusted twice.  
>    
>    In sched_exit():
> 	parent->sleep_avg = ((3*parent->sleep_avg) + child->sleep_avg)/4;
> 
>    In activate_task():
> 	p->sleep_avg += sleep_time;
> 	if (p->sleep_avg > MAX_SLEEP_AVG)
> 		p->sleep_avg = MAX_SLEEP_AVG;
>   
>    The child->sleep_avg is set initially to 95% of the parent->sleep_avg.
>    The child->sleep_avg for the running child is decremented in
>    scheduler_tick().  If you have fewer processors than child processes,
>    child->sleep_avg will,  on average, decrease less than 1 each tick.
>    
>    The effect is that the parent sleep_avg will approach MAX_SLEEP_AVG giving
>    it and its children a favorable interactive priority.  
>    Since these processes are judged interactive they go back into the active
>    array when they use up their time slice but still with a favorable priority
>    and a new time quantum.
>    
>    The problem is easy to reproduce with the waitpid06 test.  It provides
>    options so that you can loop repeating the test and also run multiple
>    copies at once.  I have been using:
> 
> 	waitpid06 -c 8 -i 10000
> 
>    This runs 8 copies of the test (64 unruly child processes) and loops
>    10,000 times.  I also run a top(1) and a:
> 	  while true ; do date; sleep 1; done
>    loop so I can tell if the system has locked up.  This sometimes takes
>    a few minutes.
> 
> 
> How do we fix this?
> 
>    I'm just getting started playing with the code.  When I tried changing the 
>    EXIT_WEIGHT to 1, the problem still happened.  I tried changing 
>    sched_exit to give the parent the minimum of the two sleep_avg values.
>    This seems to fix the problem.  I suspect that this is really a symptom
>    of a larger problem, that the system can be over-commited with processes
>    which are all judged interactive never putting processes in the expired
>    array and so never triggering the EXPIRED_STARVING case.
> 
> Please CC: me on answers/comments since I read the archives.

can you try this patch?

I dropeed the starvation logic, it could reinsert into the active queue
any interactive task. Problem is that as you say all these tasks will
look as interactive just because they have to stay out of the cpu for
long because there are many more tasks than cpus. there was an anti
starvation logic as well that limits the effect of the starvation logic
to 2 seconds, but there was a 2 second window for these tasks to be
starved at every roll of the expired/active queues.

Furthmore we are just unfair with the wakenup tasks by putting them
always in the active queue, the non immediatly wakenup tasks shouldn't
have a backdoor to go back into the active after the timeslice has
expired.

The child penalty as well was too high, we cannot predict if our child
will be interactive or not. 50% sounds much better number. The
sleep information tells us how much a task is interactive, and a child
of an interactive task doesn't need to be interactive at all. It maybe,
like in a gui starting a new browser or similar, but it may not. So a 50%
looks good compromise, we just don't know. 50% also guaranetees that the
dynamic prio goes down to its miniumum quickly under a fast
fork/fork/fork cycle. Reclaiming the sleep information from child to
parent was completely broken too. The parent has no relationship at all
with the child in terms of interactivity. Giving 50% of sleep time to
the child may be ok at the light of the past history of a common parent,
but the future of the child has no relationship with the future of the
parent.  so the exit part had to be dropped.

The child-run-first was as well not working, this is fixed now, by using
the same prio of the parent at the first child-schedule, by putting the
child into the array in fifo order (rather than the usual lifo) and by
setting need_resched. Now that I think about it, it would be a bit
better to put the child just in front of the parent, doing a
list_add_tail on the parent rather than on the head of the queue, but it
won't chance much the behaviour for your test. I will make this
further modification shortly. In the meantime I'd be interested to know
if this fixes your livelock problem. I cannot reproduce lockups here
with your waitpid testcase (on a 4-way if that matters).

Last but not the least the idle prio for secondary cpus was set to an
out of bounds value that would randomly corrupt memory if anybody made
any use of it (it wasn't the case before these modifications, this is
why such bug is been apparently harmless so far).

This is part of 2.4.20pre8aa1, porting to any other o1 based kernel
should be trivial, if unsure you can try to test your workload on
2.4.20pre8aa1 and we'll know if you can still reproduce the livelock.

thanks,

--- 2.4.20pre7aa1/include/linux/sched_runqueue.h.~1~	Sat Sep 21 16:50:02 2002
+++ 2.4.20pre7aa1/include/linux/sched_runqueue.h	Wed Sep 25 20:01:36 2002
@@ -57,7 +57,7 @@ struct prio_array {
  */
 struct runqueue {
 	spinlock_t lock;
-	unsigned long nr_running, nr_switches, expired_timestamp;
+	unsigned long nr_running, nr_switches;
 	long quiescent; /* RCU */
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
--- 2.4.20pre7aa1/kernel/sched.c.~1~	Fri Sep 20 12:43:34 2002
+++ 2.4.20pre7aa1/kernel/sched.c	Wed Sep 25 20:02:48 2002
@@ -54,51 +54,10 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(300 * HZ / 1000)
-#define CHILD_PENALTY		95
+#define CHILD_PENALTY		50
 #define PARENT_PENALTY		100
-#define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
-#define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(2*HZ)
-#define STARVATION_LIMIT	(2*HZ)
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
-#define SCALE(v1,v1_max,v2_max) \
-	(v1) * (v2_max) / (v1_max)
-
-#define DELTA(p) \
-	(SCALE(TASK_NICE(p), 40, MAX_USER_PRIO*PRIO_BONUS_RATIO/100) + \
-		INTERACTIVE_DELTA)
-
-#define TASK_INTERACTIVE(p) \
-	((p)->prio <= (p)->static_prio - DELTA(p))
 
 /*
  * TASK_TIMESLICE scales user-nice values [ -20 ... 19 ]
@@ -157,9 +116,13 @@ static inline void dequeue_task(struct t
 		__clear_bit(p->prio, array->bitmap);
 }
 
-static inline void enqueue_task(struct task_struct *p, prio_array_t *array)
+#define enqueue_task(p, array) __enqueue_task(p, array, 0)
+static inline void __enqueue_task(struct task_struct *p, prio_array_t *array, int forked_child)
 {
-	list_add_tail(&p->run_list, array->queue + p->prio);
+	if (!forked_child)
+		list_add_tail(&p->run_list, array->queue + p->prio);
+	else
+		list_add(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
 	array->nr_active++;
 	p->array = array;
@@ -191,12 +154,14 @@ static inline int effective_prio(task_t 
 	return prio;
 }
 
-static inline void activate_task(task_t *p, runqueue_t *rq)
+#define activate_task(p, rq) __activate_task(p, rq, 0)
+#define activate_forked_task(p, rq) __activate_task(p, rq, 1)
+static inline void __activate_task(task_t *p, runqueue_t *rq, int forked_child)
 {
 	unsigned long sleep_time = jiffies - p->sleep_timestamp;
 	prio_array_t *array = rq->active;
 
-	if (!rt_task(p) && sleep_time) {
+	if (!forked_child && !rt_task(p) && sleep_time) {
 		/*
 		 * This code gives a bonus to interactive tasks. We update
 		 * an 'average sleep time' value here, based on
@@ -204,12 +169,13 @@ static inline void activate_task(task_t 
 		 * the higher the average gets - and the higher the priority
 		 * boost gets as well.
 		 */
+		p->sleep_timestamp = jiffies;
 		p->sleep_avg += sleep_time;
 		if (p->sleep_avg > MAX_SLEEP_AVG)
 			p->sleep_avg = MAX_SLEEP_AVG;
 		p->prio = effective_prio(p);
 	}
-	enqueue_task(p, array);
+	__enqueue_task(p, array, forked_child);
 	rq->nr_running++;
 }
 
@@ -335,16 +301,35 @@ void wake_up_forked_process(task_t * p)
 	p->state = TASK_RUNNING;
 	if (!rt_task(p)) {
 		/*
-		 * We decrease the sleep average of forking parents
-		 * and children as well, to keep max-interactive tasks
+		 * We decrease the sleep average of forked
+		 * children, to keep max-interactive tasks
 		 * from forking tasks that are max-interactive.
+		 * CHILD_PENALTY is set to 50% since we have
+		 * no clue if this is still an interactive
+		 * task like the parent or if this will be a
+		 * cpu bound task. The parent isn't touched
+		 * as we don't make assumption about the parent
+		 * changing behaviour after the child is forked.
 		 */
 		current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
 		p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
-		p->prio = effective_prio(p);
+
+		/*
+		 * For its first schedule keep the child at the same
+		 * priority (i.e. in the same list) of the parent,
+		 * activate_forked_task() will take care to put the child
+		 * in front of the parent (lifo) to guarantee a
+		 * schedule-child-first behaviour after fork.
+		 */
+		p->prio == current->prio;
+		BUG_ON(p->prio < MAX_RT_PRIO);
+		BUG_ON(p->prio > MAX_PRIO - 1);
+
+		/* reschedule the child while returning from fork() */
+		set_tsk_need_resched(p);
 	}
 	p->cpu = smp_processor_id();
-	activate_task(p, rq);
+	activate_forked_task(p, rq);
 	spin_unlock_irq(&rq->lock);
 }
 
@@ -367,12 +352,10 @@ void sched_exit(task_t * p)
 	}
 	__sti();
 	/*
-	 * If the child was a (relative-) CPU hog then decrease
-	 * the sleep_avg of the parent as well.
+	 * Don't touch sleep_avg here, we cannot make any assumption
+	 * that the parent will change runtime behaviour, in function
+	 * of the historic runtime behaviour of the child.
 	 */
-	if (p->sleep_avg < current->sleep_avg)
-		current->sleep_avg = (current->sleep_avg * EXIT_WEIGHT +
-			p->sleep_avg) / (EXIT_WEIGHT + 1);
 }
 
 #if CONFIG_SMP
@@ -658,20 +641,6 @@ static inline void idle_tick(void)
 #endif
 
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
-		((rq)->expired_timestamp && \
-		(jiffies - (rq)->expired_timestamp >= \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1))
-
-/*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  */
@@ -734,12 +703,7 @@ void scheduler_tick(int user_tick, int s
 		p->time_slice = TASK_TIMESLICE(p);
 		p->first_time_slice = 0;
 
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			if (!rq->expired_timestamp)
-				rq->expired_timestamp = jiffies;
-			enqueue_task(p, rq->expired);
-		} else
-			enqueue_task(p, rq->active);
+		enqueue_task(p, rq->expired);
 	}
 out:
 #if CONFIG_SMP
@@ -794,7 +758,6 @@ pick_next_task:
 			goto pick_next_task;
 #endif
 		next = rq->idle;
-		rq->expired_timestamp = 0;
 		goto switch_tasks;
 	}
 
@@ -806,7 +769,6 @@ pick_next_task:
 		rq->active = rq->expired;
 		rq->expired = array;
 		array = rq->active;
-		rq->expired_timestamp = 0;
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
@@ -1049,10 +1011,9 @@ void set_user_nice(task_t *p, long nice)
 	if (array) {
 		enqueue_task(p, array);
 		/*
-		 * If the task is running and lowered its priority,
-		 * or increased its priority then reschedule its CPU:
+		 * If the task is running reschedule its CPU:
 		 */
-		if ((NICE_TO_PRIO(nice) < p->static_prio) || (p == rq->curr))
+		if (p == rq->curr)
 			resched_task(rq->curr);
 	}
 out_unlock:
@@ -1608,7 +1569,7 @@ void __init init_idle(task_t *idle, int 
 	idle_rq->curr = idle_rq->idle = idle;
 	deactivate_task(idle, rq);
 	idle->array = NULL;
-	idle->prio = MAX_PRIO;
+	idle->prio = MAX_PRIO - 20;
 	idle->state = TASK_RUNNING;
 	idle->cpu = cpu;
 	double_rq_unlock(idle_rq, rq);

Andrea
