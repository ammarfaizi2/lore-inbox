Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270085AbTGWLhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 07:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270190AbTGWLhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 07:37:16 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:61637
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270085AbTGWLhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 07:37:12 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Date: Wed, 23 Jul 2003 21:55:27 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Davide Libenzi <davidel@xmailserver.org>,
       Mike Fedyk <mfedyk@matchmail.com>, Wiktor Wodecki <wodecki@gmx.net>,
       Eugene Teo <eugene.teo@eugeneteo.net>,
       Danek Duvall <duvall@emufarm.org>,
       William Lee Irwin III <wli@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [PATCH] O8int for interactivity
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200307232155.27107.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an addon to the interactivity work so far. As the ability to become 
interactive was made much faster and easier in O6*, I was able to remove a lot 
of extra code uneeded in this latest patch, and remove a lot of the noticable 
unfairness in the code. This is closer to the original scheduler code after 
all these patches than any of my previous patches. All of O8int is aimed
at fixing unfairness in my interactivity patches.

Changes:
Removed the entire two tier MIN_SLEEP_AVG -> MAX_SLEEP_AVG code I started 
with. All code that goes with it was removed. The MAX_SLEEP_AVG can be very 
small now as even if applications (like X) have periods of cpu hogness, they 
can become interactive very rapidly again. Growth of sleep_avg is now purely
based on number of wakeups longer than one tick.

Changed MAX_SLEEP_AVG and STARVATION_LIMIT to 1 second to benefit from the 
above changes. This fixes a heck of a lot of the nasty corner cases (eg 
launching acrobat reader from within mozilla etc.)

CHILD_PENALTY is now set to 60%; this means fully interactive tasks can only 
spawn just under interactive tasks now (the same as idle tasks), but they can 
climb rapidly anyway. Although buggy applications are busy on wait with this, 
because the parents now drop interactive state faster it will be less 
noticable, and is fairer. As previous threads stated, the buggy applications 
should be fixed rather than have a scheduler that works around them.

Tiny optimisation and documentation changes to correspond to changes.

This patch applies on top of 2.6.0-test1-mm2 or an O7int patched kernel.

Con

Patch available here:
http://kernel.kolivas.org/2.5

and here:

diff -Naurp linux-2.6.0-test1-mm2/kernel/sched.c linux-2.6.0-test1ck2/kernel/sched.c
--- linux-2.6.0-test1-mm2/kernel/sched.c	2003-07-23 21:05:34.000000000 +1000
+++ linux-2.6.0-test1ck2/kernel/sched.c	2003-07-23 21:07:39.000000000 +1000
@@ -68,14 +68,13 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
-#define CHILD_PENALTY		95
+#define CHILD_PENALTY		60
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
-#define MIN_SLEEP_AVG		(HZ)
-#define MAX_SLEEP_AVG		(10*HZ)
-#define STARVATION_LIMIT	(10*HZ)
+#define MAX_SLEEP_AVG		(HZ)
+#define STARVATION_LIMIT	(HZ)
 #define NODE_THRESHOLD		125
 #define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
 
@@ -299,26 +298,6 @@ static inline void enqueue_task(struct t
 	array->nr_active++;
 	p->array = array;
 }
-/*
- * normalise_sleep converts a task's sleep_avg to
- * an appropriate proportion of MIN_SLEEP_AVG.
- */
-static inline void normalise_sleep(task_t *p)
-{
-	unsigned long old_avg_time = jiffies - p->avg_start;
-
-	if (unlikely(old_avg_time < MIN_SLEEP_AVG))
-		return;
-
-	if (p->sleep_avg > MAX_SLEEP_AVG)
-		p->sleep_avg = MAX_SLEEP_AVG;
-
-	if (old_avg_time > MAX_SLEEP_AVG)
-		old_avg_time = MAX_SLEEP_AVG;
-
-	p->sleep_avg = p->sleep_avg * MIN_SLEEP_AVG / old_avg_time;
-	p->avg_start = jiffies - MIN_SLEEP_AVG;
-}
 
 /*
  * effective_prio - return the priority that is based on the static
@@ -337,28 +316,11 @@ static inline void normalise_sleep(task_
 static int effective_prio(task_t *p)
 {
 	int bonus, prio;
-	unsigned long sleep_period;
 
 	if (rt_task(p))
 		return p->prio;
 
-	sleep_period = jiffies - p->avg_start;
-
-	if (unlikely(!sleep_period))
-		return p->static_prio;
-
-	if (sleep_period > MAX_SLEEP_AVG)
-		sleep_period = MAX_SLEEP_AVG;
-
-	if (p->sleep_avg > sleep_period)
-		sleep_period = p->sleep_avg;
-
-	/*
-	 * The bonus is determined according to the accumulated
-	 * sleep avg over the duration the task has been running
-	 * until it reaches MAX_SLEEP_AVG. -ck
-	 */
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/sleep_period/100 -
+	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
 	prio = p->static_prio - bonus;
@@ -391,43 +353,22 @@ static inline void activate_task(task_t 
 	if (sleep_time > 0) {
 		/*
 		 * User tasks that sleep a long time are categorised as idle and
-		 * will get just under interactive status with a small runtime
-		 * to allow them to become interactive or non-interactive rapidly
+		 * will get just under interactive status to prevent them suddenly
+		 * becoming cpu hogs and starving other processes.
 		 */
-		if (sleep_time > MIN_SLEEP_AVG && p->mm){
-			p->avg_start = jiffies - MIN_SLEEP_AVG;
-			p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 2) /
-				MAX_BONUS;
-		} else {
-			unsigned long runtime = jiffies - p->avg_start;
-
-			if (runtime > MAX_SLEEP_AVG)
-				runtime = MAX_SLEEP_AVG;
+		if (p->mm && sleep_time > HZ)
+			p->sleep_avg = MAX_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 2) / MAX_BONUS;
+		else {
 
 			/*
-			 * This code gives a bonus to interactive tasks.
-			 *
-			 * The boost works by updating the 'average sleep time'
-			 * value here, based on ->last_run. The more time a task
-			 * spends sleeping, the higher the average gets - and the
-			 * higher the priority boost gets as well.
+			 * Processes that sleep get pushed to one higher priority
+			 * each time they sleep greater than one tick. -ck
 			 */
-			p->sleep_avg += sleep_time;
-
-			/*
-			 * Processes that sleep get pushed to a higher priority
-			 * each time they sleep
-			 */
-			p->sleep_avg = (p->sleep_avg * MAX_BONUS / runtime + 1) * runtime / MAX_BONUS;
+			p->sleep_avg = (p->sleep_avg * MAX_BONUS / MAX_SLEEP_AVG + 1) * MAX_SLEEP_AVG / MAX_BONUS;
 
 			if (p->sleep_avg > MAX_SLEEP_AVG)
 				p->sleep_avg = MAX_SLEEP_AVG;
 		}
-
-		if (unlikely(p->avg_start > jiffies)){
-			p->avg_start = jiffies;
-			p->sleep_avg = 0;
-		}
 	}
 	p->prio = effective_prio(p);
 	__activate_task(p, rq);
@@ -606,7 +547,6 @@ void wake_up_forked_process(task_t * p)
 	 * from forking tasks that are max-interactive.
 	 */
 	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
-	normalise_sleep(p);
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
@@ -647,8 +587,6 @@ void sched_exit(task_t * p)
 	 * If the child was a (relative-) CPU hog then decrease
 	 * the sleep_avg of the parent as well.
 	 */
-	normalise_sleep(p);
-	normalise_sleep(p->parent);
 	if (p->sleep_avg < p->parent->sleep_avg)
 		p->parent->sleep_avg = (p->parent->sleep_avg * EXIT_WEIGHT +
 			p->sleep_avg) / (EXIT_WEIGHT + 1);
--- linux-2.6.0-test1-mm2/include/linux/sched.h	2003-07-23 21:05:34.000000000 +1000
+++ linux-2.6.0-test1ck2/include/linux/sched.h	2003-07-23 21:07:39.000000000 +1000
@@ -341,7 +341,6 @@ struct task_struct {
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
-	unsigned long avg_start;
 	unsigned long last_run;
 
 	unsigned long policy;

