Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267968AbTCFJ6B>; Thu, 6 Mar 2003 04:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267974AbTCFJ6B>; Thu, 6 Mar 2003 04:58:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:42988 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267968AbTCFJ5z>;
	Thu, 6 Mar 2003 04:57:55 -0500
Date: Thu, 6 Mar 2003 11:07:58 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@digeo.com>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] "interactivity changes", sched-2.5.64-A5
In-Reply-To: <20030306020044.549df2a4.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303061105040.7333-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Andrew Morton wrote:

> Overall, yep, good patch and we should run with it. [...]

great - here it is -A5 which is -A4 in a cleaned up form:

 - make SMART_WAKE_CHILD and SYNC_WAKEUPS unconditional.
 - remove a mis-merge of a TASK_ZOMBIE assert.

(without the last_run rename the patch becomes even smaller, do a
':s/last_run/sleep_timestamp/g' on it in vi.)

	Ingo

--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -328,7 +328,7 @@ struct task_struct {
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
-	unsigned long sleep_timestamp;
+	unsigned long last_run;
 
 	unsigned long policy;
 	unsigned long cpus_allowed;
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -54,20 +54,19 @@
 /*
  * These are the 'tuning knobs' of the scheduler:
  *
- * Minimum timeslice is 10 msecs, default timeslice is 150 msecs,
- * maximum timeslice is 300 msecs. Timeslices get refilled after
+ * Minimum timeslice is 10 msecs, default timeslice is 100 msecs,
+ * maximum timeslice is 200 msecs. Timeslices get refilled after
  * they expire.
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(300 * HZ / 1000)
-#define CHILD_PENALTY		95
+#define MAX_TIMESLICE		(200 * HZ / 1000)
+#define CHILD_PENALTY		50
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(2*HZ)
-#define STARVATION_LIMIT	(2*HZ)
-#define NODE_THRESHOLD          125
+#define MAX_SLEEP_AVG		(10*HZ)
+#define STARVATION_LIMIT	(10*HZ)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -323,16 +322,21 @@ static inline int effective_prio(task_t 
  * Also update all the scheduling statistics stuff. (sleep average
  * calculation, priority modifiers, etc.)
  */
+static inline void __activate_task(task_t *p, runqueue_t *rq)
+{
+	enqueue_task(p, rq->active);
+	rq->nr_running++;
+}
+
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	unsigned long sleep_time = jiffies - p->sleep_timestamp;
-	prio_array_t *array = rq->active;
+	unsigned long sleep_time = jiffies - p->last_run;
 
 	if (!rt_task(p) && sleep_time) {
 		/*
 		 * This code gives a bonus to interactive tasks. We update
 		 * an 'average sleep time' value here, based on
-		 * sleep_timestamp. The more time a task spends sleeping,
+		 * ->last_run. The more time a task spends sleeping,
 		 * the higher the average gets - and the higher the priority
 		 * boost gets as well.
 		 */
@@ -341,8 +345,7 @@ static inline void activate_task(task_t 
 			p->sleep_avg = MAX_SLEEP_AVG;
 		p->prio = effective_prio(p);
 	}
-	enqueue_task(p, array);
-	nr_running_inc(rq);
+	__activate_task(p, rq);
 }
 
 /*
@@ -479,10 +482,13 @@ repeat_lock_task:
 			}
 			if (old_state == TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible--;
-			activate_task(p, rq);
-	
-			if (p->prio < rq->curr->prio)
-				resched_task(rq->curr);
+			if (sync)
+				__activate_task(p, rq);
+			else {
+				activate_task(p, rq);
+				if (p->prio < rq->curr->prio)
+					resched_task(rq->curr);
+			}
 			success = 1;
 		}
 		p->state = TASK_RUNNING;
@@ -525,8 +531,16 @@ void wake_up_forked_process(task_t * p)
 		p->prio = effective_prio(p);
 	}
 	set_task_cpu(p, smp_processor_id());
-	activate_task(p, rq);
 
+	if (unlikely(!current->array))
+		__activate_task(p, rq);
+	else {
+		p->prio = current->prio;
+		list_add_tail(&p->run_list, &current->run_list);
+		p->array = current->array;
+		p->array->nr_active++;
+		rq->nr_running++;
+	}
 	task_rq_unlock(rq, &flags);
 }
 
@@ -953,6 +967,11 @@ static inline void pull_task(runqueue_t 
 	 */
 	if (p->prio < this_rq->curr->prio)
 		set_need_resched();
+	else {
+		if (p->prio == this_rq->curr->prio &&
+				p->time_slice > this_rq->curr->time_slice)
+			set_need_resched();
+	}
 }
 
 /*
@@ -1016,7 +1035,7 @@ skip_queue:
 	 */
 
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
-	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
+	((jiffies - (p)->last_run > cache_decay_ticks) &&	\
 		!task_running(rq, p) &&					\
 			((p)->cpus_allowed & (1UL << (this_cpu))))
 
@@ -1076,9 +1095,9 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
  * increasing number of running tasks:
  */
 #define EXPIRED_STARVING(rq) \
-		((rq)->expired_timestamp && \
+		(STARVATION_LIMIT && ((rq)->expired_timestamp && \
 		(jiffies - (rq)->expired_timestamp >= \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1))
+			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
 
 /*
  * This function gets called by the timer code, with HZ frequency.
@@ -1201,7 +1220,7 @@ need_resched:
 	rq = this_rq();
 
 	release_kernel_lock(prev);
-	prev->sleep_timestamp = jiffies;
+	prev->last_run = jiffies;
 	spin_lock_irq(&rq->lock);
 
 	/*
@@ -1701,7 +1720,7 @@ static int setscheduler(pid_t pid, int p
 	else
 		p->prio = p->static_prio;
 	if (array)
-		activate_task(p, task_rq(p));
+		__activate_task(p, task_rq(p));
 
 out_unlock:
 	task_rq_unlock(rq, &flags);
--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -916,7 +916,7 @@ static struct task_struct *copy_process(
 	 */
 	p->first_time_slice = 1;
 	current->time_slice >>= 1;
-	p->sleep_timestamp = jiffies;
+	p->last_run = jiffies;
 	if (!current->time_slice) {
 		/*
 	 	 * This case is rare, it happens when the parent has only

