Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270429AbTGZQsq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270496AbTGZQsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 12:48:46 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:40330
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270429AbTGZQr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 12:47:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O9int for interactivity
Date: Sun, 27 Jul 2003 03:06:47 +1000
User-Agent: KMail/1.5.2
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200307270306.47363.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the evolution of the orthogonal interactivity patches. These patches 
will not benefit from the extra resolution of nanosecond timing in Ingo's 
patch G3 so I'm not going to try and merge the two fully.  Also it avoids
the extra overhead in that timing.

O8+ should be resistant to irman2 and should cope ok with reniced X if
that's your flavour.

Changes:
Tweaking of the numbers to improve startup time of applications, 
hopefully without sacrificing interactivity elsewhere.

Newly forked processes dont get any interactivity bonus on their first 
activation.

Tasks are requeued according to Ingo's TIMESLICE_GRANULARITY rules, with some 
adjustments. Tasks do not change priority during requeuing and must have at 
least MIN_TIMESLICE left to requeue.

Patch applies on top of 2.6.0-test1-mm2 + O8int. A patch against vanilla
2.6.0-test1 is also available on my website.

Con

Patch available here:
http://kernel.kolivas.org/2.5

and here:

--- linux-2.6.0-test1-mm2/kernel/sched.c	2003-07-24 10:31:41.000000000 +1000
+++ linux-2.6.0-test1ck2/kernel/sched.c	2003-07-27 01:39:07.000000000 +1000
@@ -68,7 +68,8 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
-#define CHILD_PENALTY		60
+#define TIMESLICE_GRANULARITY	(HZ / 20 ?: 1)
+#define CHILD_PENALTY		90
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
@@ -348,28 +349,32 @@ static inline void __activate_task(task_
  */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	long sleep_time = jiffies - p->last_run - 1;
-
-	if (sleep_time > 0) {
-		/*
-		 * User tasks that sleep a long time are categorised as idle and
-		 * will get just under interactive status to prevent them suddenly
-		 * becoming cpu hogs and starving other processes.
-		 */
-		if (p->mm && sleep_time > HZ)
-			p->sleep_avg = MAX_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 2) / 
MAX_BONUS;
-		else {
+	if (likely(p->last_run)){
+		long sleep_time = jiffies - p->last_run - 1;
 
+		if (sleep_time > 0) {
 			/*
-			 * Processes that sleep get pushed to one higher priority
-			 * each time they sleep greater than one tick. -ck
+			 * User tasks that sleep a long time are categorised as idle and
+			 * will get just under interactive status to prevent them suddenly
+			 * becoming cpu hogs and starving other processes.
 			 */
-			p->sleep_avg = (p->sleep_avg * MAX_BONUS / MAX_SLEEP_AVG + 1) * 
MAX_SLEEP_AVG / MAX_BONUS;
+			if (p->mm && sleep_time > HZ)
+				p->sleep_avg = MAX_SLEEP_AVG * (MAX_BONUS - 1) / MAX_BONUS - 1;
+			else {
+
+				/*
+				 * Processes that sleep get pushed to one higher priority
+				 * each time they sleep greater than one tick. -ck
+				 */
+				p->sleep_avg = (p->sleep_avg * MAX_BONUS / MAX_SLEEP_AVG + 1) * 
MAX_SLEEP_AVG / MAX_BONUS;
 
-			if (p->sleep_avg > MAX_SLEEP_AVG)
-				p->sleep_avg = MAX_SLEEP_AVG;
+				if (p->sleep_avg > MAX_SLEEP_AVG)
+					p->sleep_avg = MAX_SLEEP_AVG;
+			}
 		}
-	}
+	} else
+		p->last_run = jiffies;
+
 	p->prio = effective_prio(p);
 	__activate_task(p, rq);
 }
@@ -549,6 +554,7 @@ void wake_up_forked_process(task_t * p)
 	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 	p->prio = effective_prio(p);
+	p->last_run = 0;
 	set_task_cpu(p, smp_processor_id());
 
 	if (unlikely(!current->array))
@@ -1242,16 +1248,15 @@ void scheduler_tick(int user_ticks, int 
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
-	} else if (p->mm && !((task_timeslice(p) - p->time_slice) %
-		 (MIN_TIMESLICE * (MAX_BONUS + 1 - p->sleep_avg * MAX_BONUS / 
MAX_SLEEP_AVG)))){
+	} else if (!((task_timeslice(p) - p->time_slice) % TIMESLICE_GRANULARITY) &&
+		(p->time_slice > MIN_TIMESLICE)){
 		/*
 		 * Running user tasks get requeued with their remaining timeslice
-		 * after a period proportional to how cpu intensive they are to
-		 * minimise the duration one interactive task can starve another
+		 * after TIMESLICE_GRANULARITY provided they have at least
+		 * MIN_TIMESLICE to go.
 		 */
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
-		p->prio = effective_prio(p);
 		enqueue_task(p, rq->active);
 	}
 out_unlock:

