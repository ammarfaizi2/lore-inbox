Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTF3X1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 19:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTF3X1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 19:27:13 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:26349 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262942AbTF3X1F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 19:27:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O1int 0307010922 for 2.5.73 interactivity 
Date: Tue, 1 Jul 2003 09:44:46 +1000
User-Agent: KMail/1.5.2
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mike Galbraith <efault@gmx.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_utMA/SUwSstQGcA"
Message-Id: <200307010944.46971.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_utMA/SUwSstQGcA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is an evolution of the O1int design to minimise audio skips/smooth X. 
I've been forced to work with even less sleep than usual because of this but 
I'm getting quite happy with it now.

Changes:
Reintroduction of the child penalty set at 95, but normalised to work for a 2 
second average to work with the new system.
Long sleepers classified as idle again like previous incarnations instead of 
being reset, but over a 2 second average.

This should impact on a lot of the corner cases.

More thrashing please. I know these had been coming out frequently but I 
needed to assess every small increment. I hope not to need to do too much 
from here.

Con

--Boundary-00=_utMA/SUwSstQGcA
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O1int-0307010922"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-O1int-0307010922"

--- linux-2.5.73/include/linux/sched.h	2003-06-30 10:06:40.000000000 +1000
+++ linux-2.5.73-test/include/linux/sched.h	2003-07-01 08:51:26.000000000 +1000
@@ -336,6 +336,7 @@ struct task_struct {
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
+	unsigned long avg_start;
 	unsigned long last_run;
 
 	unsigned long policy;
--- linux-2.5.73/kernel/sched.c	2003-06-30 10:06:40.000000000 +1000
+++ linux-2.5.73-test/kernel/sched.c	2003-07-01 09:22:01.000000000 +1000
@@ -67,12 +67,13 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
-#define CHILD_PENALTY		50
+#define CHILD_PENALTY		95
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(10*HZ)
+#define SLEEP_TAU		(MAX_SLEEP_AVG / 5)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
 
@@ -297,6 +298,17 @@ static inline void enqueue_task(struct t
 	p->array = array;
 }
 
+static inline void normalise_sleep(task_t *p)
+{
+	int old_avg_time, new_avg_time;
+	new_avg_time = SLEEP_TAU;
+	old_avg_time = jiffies - p->avg_start;
+
+	if (!old_avg_time) return;
+	p->sleep_avg = p->sleep_avg * new_avg_time / old_avg_time;
+	p->avg_start = jiffies - new_avg_time;
+}
+
 /*
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
@@ -314,11 +326,23 @@ static inline void enqueue_task(struct t
 static int effective_prio(task_t *p)
 {
 	int bonus, prio;
+	long sleep_period;
 
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
+	sleep_period = jiffies - p->avg_start;
+
+	if (!sleep_period)
+		return p->static_prio;
+
+	if (sleep_period > MAX_SLEEP_AVG)
+		sleep_period = MAX_SLEEP_AVG;
+
+	if (p->sleep_avg > sleep_period)
+		sleep_period = p->sleep_avg;
+
+	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/sleep_period/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
 	prio = p->static_prio - bonus;
@@ -349,7 +373,6 @@ static inline void activate_task(task_t 
 	long sleep_time = jiffies - p->last_run - 1;
 
 	if (sleep_time > 0) {
-		int sleep_avg;
 
 		/*
 		 * This code gives a bonus to interactive tasks.
@@ -359,7 +382,7 @@ static inline void activate_task(task_t 
 		 * spends sleeping, the higher the average gets - and the
 		 * higher the priority boost gets as well.
 		 */
-		sleep_avg = p->sleep_avg + sleep_time;
+		p->sleep_avg += sleep_time;
 
 		/*
 		 * 'Overflow' bonus ticks go to the waker as well, so the
@@ -367,12 +390,17 @@ static inline void activate_task(task_t 
 		 * boosting tasks that are related to maximum-interactive
 		 * tasks.
 		 */
-		if (sleep_avg > MAX_SLEEP_AVG)
-			sleep_avg = MAX_SLEEP_AVG;
-		if (p->sleep_avg != sleep_avg) {
-			p->sleep_avg = sleep_avg;
-			p->prio = effective_prio(p);
+		if (p->sleep_avg > MAX_SLEEP_AVG * 12/10)
+			p->sleep_avg = MAX_SLEEP_AVG * 11/10;
+		if (sleep_time > SLEEP_TAU / 2){
+			p->avg_start = jiffies - SLEEP_TAU;
+			p->sleep_avg = SLEEP_TAU / 2;
 		}
+		if (unlikely(p->avg_start > jiffies)){
+			p->avg_start = jiffies;
+			p->sleep_avg = 0;
+		}
+		p->prio = effective_prio(p);
 	}
 	__activate_task(p, rq);
 }
@@ -551,6 +579,10 @@ void wake_up_forked_process(task_t * p)
 	 */
 	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
+	p->avg_start = current->avg_start;
+	if (p->avg_start > MAX_SLEEP_AVG)
+		p->avg_start = MAX_SLEEP_AVG;
+	normalise_sleep(p);
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
 

--Boundary-00=_utMA/SUwSstQGcA--

