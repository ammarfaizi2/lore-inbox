Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272042AbTG3Aea (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 20:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272411AbTG3Aea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 20:34:30 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:8371
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272042AbTG3AeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 20:34:25 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O11int for interactivity
Date: Wed, 30 Jul 2003 10:38:49 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307301038.49869.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update to the interactivity patches. Not a massive improvement but
more smoothing of the corners.

Changes:
Obviously interactive tasks are now flagged as such by the interactive
credit. This allows them to be treated differently.

Tasks with credit are now the only ones that get rapid elevation of their
sleep avg with any sleep. The rest get their sleep time added, with a
limit of their timeslice as the maximum bonus - this has the effect of not
allowing non-interactive tasks to elevate priority rapidly, and the 
limitation on bonus indirectly affects how nice affects their rise.

Tasks that accumulate >MAX_SLEEP_AVG start earning interactive
credits.

Removed the detection of first time activation code - new changes make it
unecessary.

The main function of interactive credits is to make it harder for these tasks
to fall onto the expired array. These tasks can use up their entire 
sleep_avg before being expired, and even when they do they are put at the
head of the expired array. This prevents them from starving non
interactive processes that would otherwise happen if their priority remained
elevated or they got put back on the active array indefinitely (I tried all
sorts of unfair combinations). The effect of all this is that interactive tasks
take a lot longer to expire during global heavy load when they are also 
cpu hungry - ie X takes longer to stutter under heavy load and stutters for 
less.

The requeuing was modified to exclude kernel threads (just in case...)

_All_ testing and comments are desired and appreciated.

Con

A full patch against 2.6.0-test2 is available on my website.

patch-O11int-0307300018 against 2.6.0-test2-mm1 is available
here:

http://kernel.kolivas.org/2.5

and here:

--- linux-2.6.0-test2-mm1/include/linux/sched.h	2003-07-28 20:48:22.000000000 +1000
+++ linux-2.6.0-test2mm1O11/include/linux/sched.h	2003-07-28 21:55:10.000000000 +1000
@@ -342,6 +342,7 @@ struct task_struct {
 
 	unsigned long sleep_avg;
 	unsigned long last_run;
+	unsigned long interactive_credit;
 	int activated;
 
 	unsigned long policy;
--- linux-2.6.0-test2-mm1/kernel/sched.c	2003-07-28 20:48:22.000000000 +1000
+++ linux-2.6.0-test2mm1O11/kernel/sched.c	2003-07-30 00:17:55.000000000 +1000
@@ -119,6 +119,9 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
+#define JUST_INTERACTIVE_SLEEP(p) \
+	(MAX_SLEEP_AVG - (DELTA(p) * AVG_TIMESLICE))
+
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio || \
 		((p)->prio == (rq)->curr->prio && \
@@ -307,6 +310,14 @@ static inline void enqueue_task(struct t
 	p->array = array;
 }
 
+static inline void enqueue_head_task(struct task_struct *p, prio_array_t *array)
+{
+	list_add(&p->run_list, array->queue + p->prio);
+	__set_bit(p->prio, array->bitmap);
+	array->nr_active++;
+	p->array = array;
+}
+
 /*
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
@@ -357,33 +368,45 @@ static void recalc_task_prio(task_t *p)
 
 		/*
 		 * User tasks that sleep a long time are categorised as
-		 * idle and will get just under interactive status to
+		 * idle and will get just interactive status to stay active &
 		 * prevent them suddenly becoming cpu hogs and starving
 		 * other processes.
 		 */
 		if (p->mm && sleep_time > HZ)
-			p->sleep_avg = MAX_SLEEP_AVG *
-					(MAX_BONUS - 1) / MAX_BONUS - 1;
+			p->sleep_avg = JUST_INTERACTIVE_SLEEP(p);
 		else {
-
 			/*
-			 * Processes that sleep get pushed to one higher
+			 * Processes with credit get pushed to one higher
 			 * priority each time they sleep greater than
 			 * one tick. -ck
 			 */
-			p->sleep_avg = (p->sleep_avg * MAX_BONUS /
+			if (p->interactive_credit)
+				p->sleep_avg = (p->sleep_avg * MAX_BONUS /
 					MAX_SLEEP_AVG + 1) *
 					MAX_SLEEP_AVG / MAX_BONUS;
+			else {
+			/*
+			 * The rest earn sleep_avg according to their sleep
+			 * time up to a maximum of their timeslice size.
+			 */
+				if (sleep_time > task_timeslice(p))
+					sleep_time = task_timeslice(p);
+				p->sleep_avg += sleep_time;
+			}
 
-			if (p->sleep_avg > MAX_SLEEP_AVG)
+			/*
+			 * Fully interactive tasks gain interactive credits
+			 * to cash in when needed.
+			 */
+			if (p->sleep_avg > MAX_SLEEP_AVG){
 				p->sleep_avg = MAX_SLEEP_AVG;
+				p->interactive_credit++;
+			}
 		}
 	}
 	p->prio = effective_prio(p);
-
 }
 
-
 /*
  * activate_task - move a task to the runqueue and do priority recalculation
  *
@@ -392,11 +415,8 @@ static void recalc_task_prio(task_t *p)
  */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	if (likely(p->last_run)){
-		p->activated = 1;
-		recalc_task_prio(p);
-	} else
-		p->last_run = jiffies;
+	p->activated = 1;
+	recalc_task_prio(p);
 
 	__activate_task(p, rq);
 }
@@ -579,7 +599,8 @@ void wake_up_forked_process(task_t * p)
 	p->sleep_avg = p->sleep_avg * MAX_BONUS / MAX_SLEEP_AVG *
 			CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS;
 	p->prio = effective_prio(p);
-	p->last_run = 0;
+	p->last_run = jiffies;
+	p->interactive_credit = 0;
 	set_task_cpu(p, smp_processor_id());
 
 	if (unlikely(!current->array))
@@ -1268,14 +1289,33 @@ void scheduler_tick(int user_ticks, int 
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
+		/*
+		 * This drop in interactive_credit is really just a
+		 * sanity check to make sure tasks that only slept once
+		 * for long enough dont act like interactive tasks
+		 */
+		if (p->interactive_credit)
+			p->interactive_credit--;
 
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			if (!rq->expired_timestamp)
 				rq->expired_timestamp = jiffies;
-			enqueue_task(p, rq->expired);
+			/*
+			 * Long term interactive tasks need to completely
+			 * run out of sleep_avg to be expired, and when they
+			 * do they are put at the start of the expired array
+			 */
+			if (unlikely(p->interactive_credit)){
+				if (p->sleep_avg){
+					enqueue_task(p, rq->active);
+					goto out_unlock;
+				}
+				enqueue_head_task(p, rq->expired);
+			} else
+				enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
-	} else if (!((task_timeslice(p) - p->time_slice) %
+	} else if (p->mm && !((task_timeslice(p) - p->time_slice) %
 		TIMESLICE_GRANULARITY) && (p->time_slice > MIN_TIMESLICE) &&
 		(p->array == rq->active)) {
 		/*

