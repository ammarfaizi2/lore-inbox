Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbTCGTV4>; Fri, 7 Mar 2003 14:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261734AbTCGTV4>; Fri, 7 Mar 2003 14:21:56 -0500
Received: from mx1.elte.hu ([157.181.1.137]:7647 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261732AbTCGTVt>;
	Fri, 7 Mar 2003 14:21:49 -0500
Date: Fri, 7 Mar 2003 20:31:55 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "interactivity changes", sched-2.5.64-B2
In-Reply-To: <Pine.LNX.4.44.0303071104210.2521-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303072024220.17370-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against your tree) fixes the SMP locking bug. The
patch also includes some other stuff i already added to my tree by that
time:

 - only update the priority and do a requeueing if the sleep average has
   changed. (this does not happen for pure CPU hogs or pure interactive
   tasks, so no need to requeue/recalc-prio in that case.) [All the 
   necessary values are available at that point already, so gcc should
   have an easy job making this branch really cheap.]

 - do not do a full task activation in the migration-thread path - that is
   supposed to be near-atomic anyway.

 - fix up comments

i solved the SMP locking bug by moving the requeueing outside of
try_to_wake_up(). It does not matter that the priority update is not
atomically done now, since the current process wont do anything inbetween.  
(well, it could get preempted in a preemptible kernel, but even that wont
do any harm.)

did a quick testcompile & testboot on an SMP box, appears to work.

	Ingo

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -321,10 +321,7 @@ static int effective_prio(task_t *p)
 }
 
 /*
- * activate_task - move a task to the runqueue.
-
- * Also update all the scheduling statistics stuff. (sleep average
- * calculation, priority modifiers, etc.)
+ * __activate_task - move a task to the runqueue.
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
@@ -332,9 +329,16 @@ static inline void __activate_task(task_
 	nr_running_inc(rq);
 }
 
-static inline void activate_task(task_t *p, runqueue_t *rq)
+/*
+ * activate_task - move a task to the runqueue and do priority recalculation
+ *
+ * Update all the scheduling statistics stuff. (sleep average
+ * calculation, priority modifiers, etc.)
+ */
+static inline int activate_task(task_t *p, runqueue_t *rq)
 {
 	unsigned long sleep_time = jiffies - p->last_run;
+	int requeue_waker = 0;
 
 	if (sleep_time) {
 		int sleep_avg;
@@ -357,23 +361,25 @@ static inline void activate_task(task_t 
 		 */
 		if (sleep_avg > MAX_SLEEP_AVG) {
 			if (!in_interrupt()) {
-				prio_array_t *array = current->array;
-				BUG_ON(!array);
 				sleep_avg += current->sleep_avg - MAX_SLEEP_AVG;
 				if (sleep_avg > MAX_SLEEP_AVG)
 					sleep_avg = MAX_SLEEP_AVG;
 
-				current->sleep_avg = sleep_avg;
-				dequeue_task(current, array);
-				current->prio = effective_prio(current);
-				enqueue_task(current, array);
+				if (current->sleep_avg != sleep_avg) {
+					current->sleep_avg = sleep_avg;
+					requeue_waker = 1;
+				}
 			}
 			sleep_avg = MAX_SLEEP_AVG;
 		}
-		p->sleep_avg = sleep_avg;
-		p->prio = effective_prio(p);
+		if (p->sleep_avg != sleep_avg) {
+			p->sleep_avg = sleep_avg;
+			p->prio = effective_prio(p);
+		}
 	}
 	__activate_task(p, rq);
+
+	return requeue_waker;
 }
 
 /*
@@ -486,8 +492,8 @@ void kick_if_running(task_t * p)
  */
 static int try_to_wake_up(task_t * p, unsigned int state, int sync)
 {
+	int success = 0, requeue_waker = 0;
 	unsigned long flags;
-	int success = 0;
 	long old_state;
 	runqueue_t *rq;
 
@@ -513,7 +519,7 @@ repeat_lock_task:
 			if (sync)
 				__activate_task(p, rq);
 			else {
-				activate_task(p, rq);
+				requeue_waker = activate_task(p, rq);
 				if (p->prio < rq->curr->prio)
 					resched_task(rq->curr);
 			}
@@ -523,6 +529,21 @@ repeat_lock_task:
 	}
 	task_rq_unlock(rq, &flags);
 
+	/*
+	 * We have to do this outside the other spinlock, the two
+	 * runqueues might be different:
+	 */
+	if (requeue_waker) {
+		prio_array_t *array;
+
+		rq = task_rq_lock(current, &flags);
+		array = current->array;
+		dequeue_task(current, array);
+		current->prio = effective_prio(current);
+		enqueue_task(current, array);
+		task_rq_unlock(rq, &flags);
+	}
+
 	return success;
 }
 
@@ -2360,7 +2381,7 @@ repeat:
 			set_task_cpu(p, cpu_dest);
 			if (p->array) {
 				deactivate_task(p, rq_src);
-				activate_task(p, rq_dest);
+				__activate_task(p, rq_dest);
 				if (p->prio < rq_dest->curr->prio)
 					resched_task(rq_dest->curr);
 			}

