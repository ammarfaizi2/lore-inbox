Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270709AbTG0KAh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 06:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270711AbTG0KAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 06:00:37 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:61076
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270709AbTG0KA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 06:00:27 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Sun, 27 Jul 2003 20:19:48 +1000
User-Agent: KMail/1.5.2
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307271158390.10340-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0307271158390.10340-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307272019.48429.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003 20:02, Ingo Molnar wrote:
> Con,
>
> would you mind to explain the reasoning behind the avg_start,
> MIN_SLEEP_AVG and normalise_sleep() logic in your patch?
>
> [for reference i've attached your patches in a single unified patch up to
> O8int, against 2.6.0-test1.]

Unfortunately that was my older approach so none of that work is valid, and 
MIN_SLEEP_AVG and normalise_sleep() have been killed off. In essence 
the most essential difference is the way the sleep avg is incremented.

				p->sleep_avg = (p->sleep_avg * MAX_BONUS /
						MAX_SLEEP_AVG + 1) *
						MAX_SLEEP_AVG / MAX_BONUS;

where 

#define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)

...
basically any task that sleeps >= 2 milliseconds gets elevated by
one bonus each time, and the tuning to go with that to prevent starvation
and maintain fairness. I have some more tuning in the works as well.

Here is a full current O9int against 2.6.0-test1 for clarity.

--- linux-2.6.0-test1/kernel/sched.c	2003-07-23 21:03:43.000000000 +1000
+++ linux-2.6.0-test1-O9/kernel/sched.c	2003-07-27 12:19:30.000000000 +1000
@@ -68,14 +68,16 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
-#define CHILD_PENALTY		50
+#define TIMESLICE_GRANULARITY	(HZ / 20 ?: 1)
+#define CHILD_PENALTY		90
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(10*HZ)
-#define STARVATION_LIMIT	(10*HZ)
+#define MAX_SLEEP_AVG		(HZ)
+#define STARVATION_LIMIT	(HZ)
 #define NODE_THRESHOLD		125
+#define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -347,34 +349,38 @@ static inline void __activate_task(task_
  */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	long sleep_time = jiffies - p->last_run - 1;
+	if (likely(p->last_run)){
+		long sleep_time = jiffies - p->last_run - 1;
 
-	if (sleep_time > 0) {
-		int sleep_avg;
+		if (sleep_time > 0) {
+			/*
+			 * User tasks that sleep a long time are categorised as
+			 * idle and will get just under interactive status to
+			 * prevent them suddenly becoming cpu hogs and starving
+			 * other processes.
+			 */
+			if (p->mm && sleep_time > HZ)
+				p->sleep_avg = MAX_SLEEP_AVG *
+						(MAX_BONUS - 1) / MAX_BONUS - 1;
+			else {
 
-		/*
-		 * This code gives a bonus to interactive tasks.
-		 *
-		 * The boost works by updating the 'average sleep time'
-		 * value here, based on ->last_run. The more time a task
-		 * spends sleeping, the higher the average gets - and the
-		 * higher the priority boost gets as well.
-		 */
-		sleep_avg = p->sleep_avg + sleep_time;
+				/*
+				 * Processes that sleep get pushed to one higher
+				 * priority each time they sleep greater than
+				 * one tick. -ck
+				 */
+				p->sleep_avg = (p->sleep_avg * MAX_BONUS /
+						MAX_SLEEP_AVG + 1) *
+						MAX_SLEEP_AVG / MAX_BONUS;
 
-		/*
-		 * 'Overflow' bonus ticks go to the waker as well, so the
-		 * ticks are not lost. This has the effect of further
-		 * boosting tasks that are related to maximum-interactive
-		 * tasks.
-		 */
-		if (sleep_avg > MAX_SLEEP_AVG)
-			sleep_avg = MAX_SLEEP_AVG;
-		if (p->sleep_avg != sleep_avg) {
-			p->sleep_avg = sleep_avg;
-			p->prio = effective_prio(p);
+				if (p->sleep_avg > MAX_SLEEP_AVG)
+					p->sleep_avg = MAX_SLEEP_AVG;
+			}
 		}
-	}
+	} else
+		p->last_run = jiffies;
+
+	p->prio = effective_prio(p);
 	__activate_task(p, rq);
 }
 
@@ -553,6 +559,7 @@ void wake_up_forked_process(task_t * p)
 	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 	p->prio = effective_prio(p);
+	p->last_run = 0;
 	set_task_cpu(p, smp_processor_id());
 
 	if (unlikely(!current->array))
@@ -1244,6 +1251,16 @@ void scheduler_tick(int user_ticks, int 
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
+	} else if (!((task_timeslice(p) - p->time_slice) %
+		TIMESLICE_GRANULARITY) && (p->time_slice > MIN_TIMESLICE)) {
+		/*
+		 * Running user tasks get requeued with their remaining
+		 * timeslice after TIMESLICE_GRANULARITY provided they have at
+		 * least MIN_TIMESLICE to go.
+		 */
+		dequeue_task(p, rq->active);
+		set_tsk_need_resched(p);
+		enqueue_task(p, rq->active);
 	}
 out_unlock:
 	spin_unlock(&rq->lock);

