Return-Path: <linux-kernel-owner+willy=40w.ods.org-S317642AbUKBEKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S317642AbUKBEKu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 23:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S317778AbUKBEKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 23:10:49 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:62445 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S317642AbUKBEHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 23:07:04 -0500
Message-ID: <418707CD.1080903@kolivas.org>
Date: Tue, 02 Nov 2004 15:06:37 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] remove interactive credit
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3E78296A2C48E1EEB8AE0E83"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3E78296A2C48E1EEB8AE0E83
Content-Type: multipart/mixed;
 boundary="------------040903040004090002040101"

This is a multi-part message in MIME format.
--------------040903040004090002040101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

remove interactive credit



--------------040903040004090002040101
Content-Type: text/x-patch;
 name="sched-remove_interactive_credit.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-remove_interactive_credit.diff"

Special casing tasks by interactive credit was helpful for preventing fully
cpu bound tasks from easily rising to interactive status. 

However it did not select out tasks that had periods of being fully cpu bound
and then sleeping while waiting on pipes, signals etc. This led to a more
disproportionate share of cpu time.

Backing this out will no longer special case only fully cpu bound tasks, and
prevents the variable behaviour that occurs at startup before tasks declare
themseleves interactive or not, and speeds up application startup slightly
under certain circumstances. It does cost in interactivity slightly as load
rises but it is worth it for the fairness gains.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc1-mm2.orig/include/linux/sched.h	2004-11-02 13:19:19.000000000 +1100
+++ linux-2.6.10-rc1-mm2/include/linux/sched.h	2004-11-02 13:20:03.000000000 +1100
@@ -527,7 +527,6 @@ struct task_struct {
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
-	long interactive_credit;
 	unsigned long long timestamp, last_ran;
 	int activated;
 
Index: linux-2.6.10-rc1-mm2/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2.orig/kernel/sched.c	2004-11-02 13:19:19.000000000 +1100
+++ linux-2.6.10-rc1-mm2/kernel/sched.c	2004-11-02 13:51:39.000000000 +1100
@@ -100,7 +100,6 @@
 #define MAX_SLEEP_AVG		(DEF_TIMESLICE * MAX_BONUS)
 #define STARVATION_LIMIT	(MAX_SLEEP_AVG)
 #define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
-#define CREDIT_LIMIT		100
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -156,12 +155,6 @@
 	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
 		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
 
-#define HIGH_CREDIT(p) \
-	((p)->interactive_credit > CREDIT_LIMIT)
-
-#define LOW_CREDIT(p) \
-	((p)->interactive_credit < -CREDIT_LIMIT)
-
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
 
@@ -669,8 +662,6 @@ static void recalc_task_prio(task_t *p, 
 			sleep_time > INTERACTIVE_SLEEP(p)) {
 				p->sleep_avg = JIFFIES_TO_NS(MAX_SLEEP_AVG -
 						DEF_TIMESLICE);
-				if (!HIGH_CREDIT(p))
-					p->interactive_credit++;
 		} else {
 			/*
 			 * The lower the sleep avg a task has the more
@@ -679,19 +670,18 @@ static void recalc_task_prio(task_t *p, 
 			sleep_time *= (MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
 
 			/*
-			 * Tasks with low interactive_credit are limited to
-			 * one timeslice worth of sleep avg bonus.
+			 * Tasks are limited to one timeslice worth of
+			 * sleep avg bonus.
 			 */
-			if (LOW_CREDIT(p) &&
-			    sleep_time > JIFFIES_TO_NS(task_timeslice(p)))
+			if (sleep_time > JIFFIES_TO_NS(task_timeslice(p)))
 				sleep_time = JIFFIES_TO_NS(task_timeslice(p));
 
 			/*
-			 * Non high_credit tasks waking from uninterruptible
-			 * sleep are limited in their sleep_avg rise as they
-			 * are likely to be cpu hogs waiting on I/O
+			 * Tasks waking from uninterruptible sleep are 
+			 * limited in their sleep_avg rise as they
+			 * are likely to be waiting on I/O
 			 */
-			if (p->activated == -1 && !HIGH_CREDIT(p) && p->mm) {
+			if (p->activated == -1 && p->mm) {
 				if (p->sleep_avg >= INTERACTIVE_SLEEP(p))
 					sleep_time = 0;
 				else if (p->sleep_avg + sleep_time >=
@@ -711,11 +701,8 @@ static void recalc_task_prio(task_t *p, 
 			 */
 			p->sleep_avg += sleep_time;
 
-			if (p->sleep_avg > NS_MAX_SLEEP_AVG) {
+			if (p->sleep_avg > NS_MAX_SLEEP_AVG)
 				p->sleep_avg = NS_MAX_SLEEP_AVG;
-				if (!HIGH_CREDIT(p))
-					p->interactive_credit++;
-			}
 		}
 	}
 
@@ -1235,8 +1222,6 @@ void fastcall wake_up_new_task(task_t * 
 	p->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
 		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
 
-	p->interactive_credit = 0;
-
 	p->prio = effective_prio(p);
 
 	if (likely(cpu == this_cpu)) {
@@ -2702,12 +2687,10 @@ need_resched_nonpreemptible:
 		run_time = NS_MAX_SLEEP_AVG;
 
 	/*
-	 * Tasks with interactive credits get charged less run_time
-	 * at high sleep_avg to delay them losing their interactive
-	 * status
+	 * Tasks charged proportionately less run_time at high sleep_avg to
+	 * delay them losing their interactive status
 	 */
-	if (HIGH_CREDIT(prev))
-		run_time /= (CURRENT_BONUS(prev) ? : 1);
+	run_time /= (CURRENT_BONUS(prev) ? : 1);
 
 	spin_lock_irq(&rq->lock);
 
@@ -2795,11 +2778,8 @@ switch_tasks:
 	rcu_qsctr_inc(task_cpu(prev));
 
 	prev->sleep_avg -= run_time;
-	if ((long)prev->sleep_avg <= 0) {
+	if ((long)prev->sleep_avg <= 0)
 		prev->sleep_avg = 0;
-		if (!(HIGH_CREDIT(prev) || LOW_CREDIT(prev)))
-			prev->interactive_credit--;
-	}
 	prev->timestamp = prev->last_ran = now;
 
 	sched_info_switch(prev, next);
@@ -3899,7 +3879,6 @@ void __devinit init_idle(task_t *idle, i
 	unsigned long flags;
 
 	idle->sleep_avg = 0;
-	idle->interactive_credit = 0;
 	idle->array = NULL;
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;


--------------040903040004090002040101--

--------------enig3E78296A2C48E1EEB8AE0E83
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBhwfTZUg7+tp6mRURApIAAJ9sko06APEiCF1FlXMGnPA+KaeQXgCeJlzm
zokUNP0oE+NBDtndiEYY4SQ=
=HGvW
-----END PGP SIGNATURE-----

--------------enig3E78296A2C48E1EEB8AE0E83--
