Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTGBIFu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 04:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTGBIFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 04:05:50 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:19601 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S263632AbTGBIFr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 04:05:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O1int 0307021808 for interactivity
Date: Wed, 2 Jul 2003 18:23:56 +1000
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_capA/EyBZKljIsD"
Message-Id: <200307021823.56904.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_capA/EyBZKljIsD
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This latest patch I'm formally announcing has the base O1int changes so far 
but includes new semantics for freshly started applications so they can 
become interactive very rapidly even during heavy load. This addresses the 
"slow to start new apps" evident in O1int so far.

Please test this one and note given just how rapidly things can become 
interactive it may have regressions in other settings.

This performs better in all settings than any previous one I've posted in my 
testing, but hardware differs substantially!

The latest should always be found:
http://kernel.kolivas.org/2.5

Con

--Boundary-00=_capA/EyBZKljIsD
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O1int-0307021808"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-O1int-0307021808"

--- linux-2.5.73/include/linux/sched.h	2003-06-30 10:06:40.000000000 +1000
+++ linux-2.5.73-test/include/linux/sched.h	2003-07-01 11:56:08.000000000 +1000
@@ -336,6 +336,7 @@ struct task_struct {
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
+	unsigned long avg_start;
 	unsigned long last_run;
 
 	unsigned long policy;
--- linux-2.5.73/kernel/sched.c	2003-06-30 10:06:40.000000000 +1000
+++ linux-2.5.73-test/kernel/sched.c	2003-07-02 17:57:04.000000000 +1000
@@ -72,6 +72,7 @@
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
+#define MIN_SLEEP_AVG		(HZ)
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
@@ -297,6 +298,21 @@ static inline void enqueue_task(struct t
 	p->array = array;
 }
 
+static inline void normalise_sleep(task_t *p)
+{
+	int old_avg_time, new_avg_time;
+	new_avg_time = MIN_SLEEP_AVG;
+	old_avg_time = jiffies - p->avg_start;
+	if (old_avg_time < new_avg_time) return;
+
+	if (p->sleep_avg > MAX_SLEEP_AVG)
+		p->sleep_avg = MAX_SLEEP_AVG;
+	if (old_avg_time > MAX_SLEEP_AVG)
+		old_avg_time = MAX_SLEEP_AVG;
+	p->sleep_avg = p->sleep_avg * new_avg_time / old_avg_time;
+	p->avg_start = jiffies - new_avg_time;
+}
+
 /*
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
@@ -314,11 +330,23 @@ static inline void enqueue_task(struct t
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
@@ -349,7 +377,7 @@ static inline void activate_task(task_t 
 	long sleep_time = jiffies - p->last_run - 1;
 
 	if (sleep_time > 0) {
-		int sleep_avg;
+		int runtime = jiffies - p->avg_start;
 
 		/*
 		 * This code gives a bonus to interactive tasks.
@@ -359,7 +387,10 @@ static inline void activate_task(task_t 
 		 * spends sleeping, the higher the average gets - and the
 		 * higher the priority boost gets as well.
 		 */
-		sleep_avg = p->sleep_avg + sleep_time;
+		p->sleep_avg += sleep_time;
+		if (runtime < MAX_SLEEP_AVG)
+			p->sleep_avg += (runtime - p->sleep_avg) * (MAX_SLEEP_AVG - runtime)/MAX_SLEEP_AVG;
+
 
 		/*
 		 * 'Overflow' bonus ticks go to the waker as well, so the
@@ -367,12 +398,17 @@ static inline void activate_task(task_t 
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
+		if (sleep_time > MIN_SLEEP_AVG){
+			p->avg_start = jiffies - MIN_SLEEP_AVG;
+			p->sleep_avg = MIN_SLEEP_AVG / 2;
 		}
+		if (unlikely(p->avg_start > jiffies)){
+			p->avg_start = jiffies;
+			p->sleep_avg = 0;
+		}
+		p->prio = effective_prio(p);
 	}
 	__activate_task(p, rq);
 }
@@ -550,6 +586,8 @@ void wake_up_forked_process(task_t * p)
 	 * from forking tasks that are max-interactive.
 	 */
 	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
+	p->avg_start = current->avg_start;
+	normalise_sleep(p);
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());

--Boundary-00=_capA/EyBZKljIsD--

