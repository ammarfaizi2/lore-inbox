Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271408AbTHHPoQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271414AbTHHPoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:44:16 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:15570
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271408AbTHHPoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:44:07 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH]O14int
Date: Sat, 9 Aug 2003 01:49:25 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Cliff White <cliffw@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308090149.25688.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More duck tape interactivity tweaks

Changes

Put some bounds on the interactive_credit and specified a size beyond which a 
task is considered highly interactive or not.

Moved the uninterruptible sleep limiting to within recalc_task_prio removing 
one call of the sched_clock() and being more careful about the limits.

Wli pointed out an error in the nanosecond to jiffy conversion which may have 
been causing too easy to migrate tasks on smp (? performance change).

Put greater limitation on the requeuing code; now it only requeues interactive 
tasks thereby letting cpu hogs run their full timeslice unabated which should 
improve cpu intensive task performance.

Made highly interactive tasks earn all their waiting time on the runqueue
during requeuing as sleep_avg.

Patch applies onto 2.6.0-test2-mm5

http://kernel.kolivas.org/2.5
has the patch and a full patch against 2.6.0-test2

Patch O13.1-O14int:

--- linux-2.6.0-test2-mm5-O13.1/kernel/sched.c	2003-08-08 22:47:08.000000000 +1000
+++ linux-2.6.0-test2-mm5/kernel/sched.c	2003-08-09 01:27:47.000000000 +1000
@@ -130,6 +130,15 @@
 #define JUST_INTERACTIVE_SLEEP(p) \
 	(MAX_SLEEP_AVG - (DELTA(p) * AVG_TIMESLICE))
 
+#define HIGH_CREDIT(p) \
+	((p)->interactive_credit > MAX_SLEEP_AVG)
+
+#define LOW_CREDIT(p) \
+	((p)->interactive_credit < -MAX_SLEEP_AVG)
+
+#define VARYING_CREDIT(p) \
+	(!(HIGH_CREDIT(p) || LOW_CREDIT(p)))
+
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio || \
 		((p)->prio == (rq)->curr->prio && \
@@ -364,7 +373,7 @@ static void recalc_task_prio(task_t *p, 
 	unsigned long long __sleep_time = now - p->timestamp;
 	unsigned long sleep_time;
 
-	if (!p->sleep_avg)
+	if (!p->sleep_avg && VARYING_CREDIT(p))
 		p->interactive_credit--;
 
 	if (__sleep_time > NS_MAX_SLEEP_AVG)
@@ -373,7 +382,6 @@ static void recalc_task_prio(task_t *p, 
 		sleep_time = (unsigned long)__sleep_time;
 
 	if (likely(sleep_time > 0)) {
-
 		/*
 		 * User tasks that sleep a long time are categorised as
 		 * idle and will get just interactive status to stay active &
@@ -387,20 +395,38 @@ static void recalc_task_prio(task_t *p, 
 		else {
 			/*
 			 * The lower the sleep avg a task has the more
-			 * rapidly it will rise with sleep time. Tasks
-			 * without interactive_credit are limited to
-			 * one timeslice worth of sleep avg bonus.
+			 * rapidly it will rise with sleep time.
 			 */
 			sleep_time *= (MAX_BONUS + 1 -
 					(NS_TO_JIFFIES(p->sleep_avg) *
 					MAX_BONUS / MAX_SLEEP_AVG));
 
-			if (p->interactive_credit < 0 &&
+			/*
+			 * Tasks with low interactive_credit are limited to
+			 * one timeslice worth of sleep avg bonus.
+			 */
+			if (LOW_CREDIT(p) &&
 				sleep_time > JIFFIES_TO_NS(task_timeslice(p)))
 					sleep_time =
 						JIFFIES_TO_NS(task_timeslice(p));
 
 			/*
+			 * Non high_credit tasks waking from uninterruptible
+			 * sleep are limited in their sleep_avg rise
+			 */
+			if (!HIGH_CREDIT(p) && p->activated == -1){
+				if (p->sleep_avg >=
+					JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p)))
+						sleep_time = 0;
+				else if (p->sleep_avg + sleep_time >=
+					JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p))){
+						p->sleep_avg =
+							JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p));
+						sleep_time = 0;
+					}
+			}
+
+			/*
 			 * This code gives a bonus to interactive tasks.
 			 *
 			 * The boost works by updating the 'average sleep time'
@@ -418,7 +444,7 @@ static void recalc_task_prio(task_t *p, 
 			 */
 			if (p->sleep_avg > NS_MAX_SLEEP_AVG){
 				p->sleep_avg = NS_MAX_SLEEP_AVG;
-				p->interactive_credit++;
+				p->interactive_credit += VARYING_CREDIT(p);
 			}
 		}
 	}
@@ -588,11 +614,7 @@ repeat_lock_task:
 				 * Tasks on involuntary sleep don't earn
 				 * sleep_avg beyond just interactive state.
 				 */
-				if (NS_TO_JIFFIES(p->sleep_avg) >=
-					JUST_INTERACTIVE_SLEEP(p)){
-						p->timestamp = sched_clock();
-						p->activated = -1;
-				}
+				p->activated = -1;
 			}
 			if (sync)
 				__activate_task(p, rq);
@@ -1156,9 +1178,9 @@ skip_queue:
 	 * 3) are cache-hot on their current CPU.
 	 */
 
-#define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
-	((!idle || (((now - (p)->timestamp)>>10) > cache_decay_ticks)) &&\
-		!task_running(rq, p) &&					\
+#define CAN_MIGRATE_TASK(p,rq,this_cpu)	\
+	((!idle || (NS_TO_JIFFIES(now - (p)->timestamp) > \
+		cache_decay_ticks)) && !task_running(rq, p) && \
 			cpu_isset(this_cpu, (p)->cpus_allowed))
 
 	curr = curr->prev;
@@ -1366,13 +1388,23 @@ void scheduler_tick(int user_ticks, int 
 		 * requeue this task to the end of the list on this priority
 		 * level, which is in essence a round-robin of tasks with
 		 * equal priority.
+		 *
+		 * This only applies to user tasks in the interactive
+		 * delta range with at least MIN_TIMESLICE left.
 		 */
-		if (p->mm && !((task_timeslice(p) - p->time_slice) %
-			TIMESLICE_GRANULARITY) && (p->time_slice > MIN_TIMESLICE) &&
+		if (p->mm && TASK_INTERACTIVE(p) && !((task_timeslice(p) -
+			p->time_slice) % TIMESLICE_GRANULARITY) &&
+			(p->time_slice > MIN_TIMESLICE) &&
 			(p->array == rq->active)) {
 
 			dequeue_task(p, rq->active);
 			set_tsk_need_resched(p);
+			/*
+			 * Tasks with interactive credit get all their
+			 * time waiting on the run queue credited as sleep
+			 */
+			if (HIGH_CREDIT(p))
+				p->activated = 2;
 			enqueue_task(p, rq->active);
 		}
 	}
@@ -1426,7 +1458,7 @@ need_resched:
 	 * as their sleep_avg decreases to slow them losing their
 	 * priority bonus
 	 */
-	if (prev->interactive_credit > 0)
+	if (HIGH_CREDIT(prev))
 		run_time /= (MAX_BONUS + 1 -
 			(NS_TO_JIFFIES(prev->sleep_avg) * MAX_BONUS /
 			MAX_SLEEP_AVG));
@@ -1484,12 +1516,12 @@ pick_next_task:
 		if (next->activated == 1)
 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
 
-		next->activated = 0;
 		array = next->array;
 		dequeue_task(next, array);
 		recalc_task_prio(next, next->timestamp + delta);
 		enqueue_task(next, array);
 	}
+	next->activated = 0;
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);

