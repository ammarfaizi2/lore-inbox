Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270835AbTG0OxI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 10:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270846AbTG0OxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 10:53:08 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:51866
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270835AbTG0Oww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 10:52:52 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O10int for interactivity
Date: Mon, 28 Jul 2003 01:12:16 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200307280112.16043.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a fairly rapid evolution of the O*int patches for interactivity thanks
to Ingo's involvement.

Changes:
I've put in some defines to clarify where the numbers for MAX_SLEEP_AVG come 
from now, rather than the number being magic. In the process it increases MSA 
every so slightly so that an average task that runs a full timeslice (102ms) 
will drop exactly one priority in that time.

I've incorporated Ingo's fix for scheduling latency in a form that works for 
my patch, along with the other minor tweaks.

The parent and child sleep avg on forking is set to just on the priority bonus 
value with each fork thus keeping their bonus the same but making them very 
easy to tip to a lower priority.

A tiny addition to ensure any task that runs gets charged one tick of 
sleep_avg.

This patch is against 2.6.0-test1-mm2 patched up to O9int. An updated
O9int with layout corrections was posted on my website. A full O10int patch
against 2.6.0-test1 is available on my website.

Con

http://kernel.kolivas.org/2.5

patch-O10int-0307280030 :

--- linux-2.6.0-test1-mm2/kernel/sched.c	2003-07-27 14:03:16.000000000 +1000
+++ linux-2.6.0-test1ck2/kernel/sched.c	2003-07-28 00:31:39.000000000 +1000
@@ -58,6 +58,8 @@
 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
+#define AVG_TIMESLICE	(MIN_TIMESLICE + ((MAX_TIMESLICE - MIN_TIMESLICE) *\
+			(MAX_PRIO-1-NICE_TO_PRIO(0))/(MAX_USER_PRIO - 1)))
 
 /*
  * These are the 'tuning knobs' of the scheduler:
@@ -68,16 +70,16 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
-#define TIMESLICE_GRANULARITY	(HZ / 20 ?: 1)
+#define TIMESLICE_GRANULARITY	(HZ/40 ?: 1)
 #define CHILD_PENALTY		90
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
+#define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
 #define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(HZ)
-#define STARVATION_LIMIT	(HZ)
+#define MAX_SLEEP_AVG		(AVG_TIMESLICE * MAX_BONUS)
+#define STARVATION_LIMIT	(MAX_SLEEP_AVG)
 #define NODE_THRESHOLD		125
-#define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -117,6 +119,11 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
+#define TASK_PREEMPTS_CURR(p, rq) \
+	((p)->prio < (rq)->curr->prio || \
+		((p)->prio == (rq)->curr->prio && \
+			(p)->time_slice > (rq)->curr->time_slice * 2))
+
 /*
  * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
  * to time slice values.
@@ -341,6 +348,42 @@ static inline void __activate_task(task_
 	nr_running_inc(rq);
 }
 
+static void recalc_task_prio(task_t *p)
+{
+	long sleep_time = jiffies - p->last_run - 1;
+
+	if (sleep_time > 0) {
+		p->activated = 0;
+
+		/*
+		 * User tasks that sleep a long time are categorised as
+		 * idle and will get just under interactive status to
+		 * prevent them suddenly becoming cpu hogs and starving
+		 * other processes.
+		 */
+		if (p->mm && sleep_time > HZ)
+			p->sleep_avg = MAX_SLEEP_AVG *
+					(MAX_BONUS - 1) / MAX_BONUS - 1;
+		else {
+
+			/*
+			 * Processes that sleep get pushed to one higher
+			 * priority each time they sleep greater than
+			 * one tick. -ck
+			 */
+			p->sleep_avg = (p->sleep_avg * MAX_BONUS /
+					MAX_SLEEP_AVG + 1) *
+					MAX_SLEEP_AVG / MAX_BONUS;
+
+			if (p->sleep_avg > MAX_SLEEP_AVG)
+				p->sleep_avg = MAX_SLEEP_AVG;
+		}
+	}
+	p->prio = effective_prio(p);
+
+}
+
+
 /*
  * activate_task - move a task to the runqueue and do priority recalculation
  *
@@ -350,37 +393,11 @@ static inline void __activate_task(task_
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
 	if (likely(p->last_run)){
-		long sleep_time = jiffies - p->last_run - 1;
-
-		if (sleep_time > 0) {
-			/*
-			 * User tasks that sleep a long time are categorised as
-			 * idle and will get just under interactive status to
-			 * prevent them suddenly becoming cpu hogs and starving
-			 * other processes.
-			 */
-			if (p->mm && sleep_time > HZ)
-				p->sleep_avg = MAX_SLEEP_AVG *
-						(MAX_BONUS - 1) / MAX_BONUS - 1;
-			else {
-
-				/*
-				 * Processes that sleep get pushed to one higher
-				 * priority each time they sleep greater than
-				 * one tick. -ck
-				 */
-				p->sleep_avg = (p->sleep_avg * MAX_BONUS /
-						MAX_SLEEP_AVG + 1) *
-						MAX_SLEEP_AVG / MAX_BONUS;
-
-				if (p->sleep_avg > MAX_SLEEP_AVG)
-					p->sleep_avg = MAX_SLEEP_AVG;
-			}
-		}
+		p->activated = 1;
+		recalc_task_prio(p);
 	} else
 		p->last_run = jiffies;
 
-	p->prio = effective_prio(p);
 	__activate_task(p, rq);
 }
 
@@ -507,7 +524,7 @@ repeat_lock_task:
 				__activate_task(p, rq);
 			else {
 				activate_task(p, rq);
-				if (p->prio < rq->curr->prio)
+				if (TASK_PREEMPTS_CURR(p, rq))
 					resched_task(rq->curr);
 			}
 			success = 1;
@@ -556,8 +573,11 @@ void wake_up_forked_process(task_t * p)
 	 * and children as well, to keep max-interactive tasks
 	 * from forking tasks that are max-interactive.
 	 */
-	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
-	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
+	current->sleep_avg = current->sleep_avg * MAX_BONUS / MAX_SLEEP_AVG *
+				PARENT_PENALTY / 100 * MAX_SLEEP_AVG /
+				MAX_BONUS;
+	p->sleep_avg = p->sleep_avg * MAX_BONUS / MAX_SLEEP_AVG *
+			CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS;
 	p->prio = effective_prio(p);
 	p->last_run = 0;
 	set_task_cpu(p, smp_processor_id());
@@ -1254,7 +1274,8 @@ void scheduler_tick(int user_ticks, int 
 		} else
 			enqueue_task(p, rq->active);
 	} else if (!((task_timeslice(p) - p->time_slice) %
-		TIMESLICE_GRANULARITY) && (p->time_slice > MIN_TIMESLICE)) {
+		TIMESLICE_GRANULARITY) && (p->time_slice > MIN_TIMESLICE) &&
+		(p->array == rq->active)) {
 		/*
 		 * Running user tasks get requeued with their remaining
 		 * timeslice after TIMESLICE_GRANULARITY provided they have at
@@ -1302,6 +1323,13 @@ need_resched:
 
 	release_kernel_lock(prev);
 	prev->last_run = jiffies;
+	/*
+	 * If a task has run less than one tick make sure it is still
+	 * charged one sleep_avg for running.
+	 */
+	if (unlikely((task_timeslice(prev) == prev->time_slice) &&
+		prev->sleep_avg))
+			prev->sleep_avg--;
 	spin_lock_irq(&rq->lock);
 
 	/*
@@ -1349,6 +1377,13 @@ pick_next_task:
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
+	if (next->activated) {
+		next->activated = 0;
+		array = next->array;
+		dequeue_task(next, array);
+		recalc_task_prio(next);
+		enqueue_task(next, array);
+	}
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
--- linux-2.6.0-test1-mm2/include/linux/sched.h	2003-07-24 10:31:41.000000000 +1000
+++ linux-2.6.0-test1ck2/include/linux/sched.h	2003-07-27 20:09:04.000000000 +1000
@@ -342,6 +342,7 @@ struct task_struct {
 
 	unsigned long sleep_avg;
 	unsigned long last_run;
+	int activated;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;

