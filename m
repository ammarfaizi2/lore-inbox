Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263145AbSJBPXB>; Wed, 2 Oct 2002 11:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263147AbSJBPXB>; Wed, 2 Oct 2002 11:23:01 -0400
Received: from [195.223.140.120] ([195.223.140.120]:25956 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263145AbSJBPWy>; Wed, 2 Oct 2002 11:22:54 -0400
Date: Wed, 2 Oct 2002 08:45:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jim Houston <jim.houston@ccur.com>
Cc: Jim Houston <jim.houston@attbi.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: O(1) Scheduler (tuning problem/live-lock)
Message-ID: <20021002064559.GB1158@dualathlon.random>
References: <200209061844.g86IiF701825@linux.local> <20020930161019.GH1235@dualathlon.random> <3D994CD9.3FDFA09F@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D994CD9.3FDFA09F@ccur.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 03:20:57AM -0400, Jim Houston wrote:
> Hi Andrea, Ingo,
> 
> Andrea I tried your patch and it does solve the live-lock
> in the LTP waitpid06 test.  The mouse movement gets a bit
> jerky but atleast it doesn't lock up.

it's probably because I screwed the wakeup logic here:

	if (p->prio < rq->curr->prio)
		resched_task(rq->curr);

I didn't realize the idle task ->prio MAX_PRIO out of bounds value was a
feature and not a bug. the last comment about the MAX_PRIO setting of
idle tasks in the previous email was wrong too.

> I guess the next question is how does it do on normal work loads?
> 
> I like the idea of making the child processes start with a smaller
> sleep_avg value.  Maybe it should just be a constant rather than a
> fraction of the parents sleep_avg?  Its really the child processes
> inheriting the favorable sleep_avg that caused the problem with
> waitpid06.

I think constant isn't as good as 50%, the history may be significant
for the child (like in a GUI), and going down of 50% each fork should be
enough to guarantee good fariness.

> I liked the idea of giving interactive tasks special treatment. 
> Andrea please don't remove this.  Always putting processes
> (which have used up there time slice) into the rq->expired array
> makes all processes round robin at the same priority.  It makes
> sense to do this to fail gracefully if the system is overloaded
> but not all the time.

yes, when the system isn't overloaded that makes sense, I was just
thinking at the overloaded case where the expired tasks would be
penalized for two more seconds. But maybe it doesn't matter much, as
said I resurrected it so you can test.

> I hope this make sense.  I'm falling asleep writing it:-)

;)

Here the new patch only slightly tested so far. This does the
run-child-first right too (if the parent expired at the time of the
fork() they will both wait for a reschedule and they will be run
serially, that should be the best for throughput, certainly we can't put
the parent back in the active queue so it worth to execute the child
right before the parent to maximize possible cache effects) You can
easily see the effect with this proggy:

main()
{
	if (fork())
		printf("p\n");
	else
		printf("c\n");
}

Could you test this new one too? thanks,

--- 2.4.20pre8aa2/kernel/sched.c.~1~	Wed Oct  2 00:25:58 2002
+++ 2.4.20pre8aa2/kernel/sched.c	Wed Oct  2 06:27:28 2002
@@ -54,9 +54,8 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(300 * HZ / 1000)
-#define CHILD_PENALTY		95
+#define CHILD_PENALTY		50
 #define PARENT_PENALTY		100
-#define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(2*HZ)
@@ -157,12 +156,19 @@ static inline void dequeue_task(struct t
 		__clear_bit(p->prio, array->bitmap);
 }
 
-static inline void enqueue_task(struct task_struct *p, prio_array_t *array)
+#define enqueue_task(p, array) __enqueue_task(p, array, NULL)
+static inline void __enqueue_task(struct task_struct *p, prio_array_t *array, task_t * parent)
 {
-	list_add_tail(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
+	if (!parent) {
+		list_add_tail(&p->run_list, array->queue + p->prio);
+		__set_bit(p->prio, array->bitmap);
+		p->array = array;
+		__set_bit(p->prio, array->bitmap);
+	} else {
+		list_add_tail(&p->run_list, &parent->run_list);
+		array = p->array = parent->array;
+	}
 	array->nr_active++;
-	p->array = array;
 }
 
 static inline int effective_prio(task_t *p)
@@ -191,12 +197,13 @@ static inline int effective_prio(task_t 
 	return prio;
 }
 
-static inline void activate_task(task_t *p, runqueue_t *rq)
+#define activate_task(p, rq) __activate_task(p, rq, NULL)
+static inline void __activate_task(task_t *p, runqueue_t *rq, task_t * parent)
 {
 	unsigned long sleep_time = jiffies - p->sleep_timestamp;
 	prio_array_t *array = rq->active;
 
-	if (!rt_task(p) && sleep_time) {
+	if (!parent && !rt_task(p) && sleep_time) {
 		/*
 		 * This code gives a bonus to interactive tasks. We update
 		 * an 'average sleep time' value here, based on
@@ -204,12 +211,13 @@ static inline void activate_task(task_t 
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
+	__enqueue_task(p, array, parent);
 	rq->nr_running++;
 }
 
@@ -328,23 +336,47 @@ int wake_up_process(task_t * p)
 void wake_up_forked_process(task_t * p)
 {
 	runqueue_t *rq;
+	task_t * parent = current;
 
 	rq = this_rq();
 	spin_lock_irq(&rq->lock);
 
 	p->state = TASK_RUNNING;
-	if (!rt_task(p)) {
+	if (likely(!rt_task(p) && parent->array)) {
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
-		current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
+		parent->sleep_avg = parent->sleep_avg * PARENT_PENALTY / 100;
 		p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
+
+		/*
+		 * For its first schedule keep the child at the same
+		 * priority (i.e. in the same list) of the parent,
+		 * activate_forked_task() will take care to put the
+		 * child in front of the parent (lifo) to guarantee a
+		 * schedule-child-first behaviour after fork.
+		 */
+		p->prio = parent->prio;
+		set_tsk_need_resched(parent);
+	} else {
+		/*
+		 * Take the usual wakeup path if it's RT or if
+		 * it's a child of the first idle task (during boot
+		 * only).
+		 */
 		p->prio = effective_prio(p);
+		parent = NULL;
 	}
-	p->cpu = smp_processor_id();
-	activate_task(p, rq);
+
+	__activate_task(p, rq, parent);
 	spin_unlock_irq(&rq->lock);
 }
 
@@ -366,13 +398,6 @@ void sched_exit(task_t * p)
 			current->time_slice = MAX_TIMESLICE;
 	}
 	__sti();
-	/*
-	 * If the child was a (relative-) CPU hog then decrease
-	 * the sleep_avg of the parent as well.
-	 */
-	if (p->sleep_avg < current->sleep_avg)
-		current->sleep_avg = (current->sleep_avg * EXIT_WEIGHT +
-			p->sleep_avg) / (EXIT_WEIGHT + 1);
 }
 
 #if CONFIG_SMP
@@ -1027,7 +1052,7 @@ void set_user_nice(task_t *p, long nice)
 		 * If the task is running and lowered its priority,
 		 * or increased its priority then reschedule its CPU:
 		 */
-		if ((NICE_TO_PRIO(nice) < p->static_prio) || (p == rq->curr))
+		if (p == rq->curr)
 			resched_task(rq->curr);
 	}
 out_unlock:
--- 2.4.20pre8aa2/kernel/fork.c.~1~	Wed Oct  2 00:25:23 2002
+++ 2.4.20pre8aa2/kernel/fork.c	Wed Oct  2 06:02:13 2002
@@ -690,8 +690,6 @@ int do_fork(unsigned long clone_flags, u
 	if (p->pid < 0) /* valid pids are >= 0 */
 		goto bad_fork_cleanup;
 
-	INIT_LIST_HEAD(&p->run_list);
-
 	p->p_cptr = NULL;
 	init_waitqueue_head(&p->wait_chldexit);
 	p->vfork_done = NULL;
@@ -725,7 +723,6 @@ int do_fork(unsigned long clone_flags, u
 		spin_lock_init(&p->sigmask_lock);
 	}
 #endif
-	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = jiffies;
 

Andrea
