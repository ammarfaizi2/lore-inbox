Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbTICOpp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263839AbTICOpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:45:45 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:59318
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263840AbTICOpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:45:40 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH]O20int
Date: Thu, 4 Sep 2003 00:53:10 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WBgV/Xlb1thw4xB"
Message-Id: <200309040053.22155.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_WBgV/Xlb1thw4xB
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

=46ine tuning mainly.

Smaller timeslice granularity for most interactive tasks and larger for les=
s=20
interactive. Smaller for each extra cpu.

Smaller bounds on interactive credit.

Idle tasks can gain interactive credits; Idle tasks get more interactivity;=
=20
Uninterruptible sleep wakers are not seen as idle.

Kernel threads participate in timeslice granularity requeuing.

This patch is incremental on top of O19int which is included in=20
2.6.0-test4-mm4. It will not apply onto mm5 which has all my stuff backed=20
out. This patch and a full patch against 2.6.0-test4 can be found here:

http://kernel.kolivas.org/2.5

Con
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/VgBaZUg7+tp6mRURAtvgAJoClT078T9wLLlEq8+pct3Yigrq3wCgja4P
HjXKw3YJSey4DWpA2I+Tyi4=3D
=3DnvCB
=2D----END PGP SIGNATURE-----

--Boundary-00=_WBgV/Xlb1thw4xB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O19-O20int"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="patch-O19-O20int"

--- linux-2.6.0-test4-mm4-O19/kernel/sched.c	2003-08-31 19:33:09.000000000 +1000
+++ linux-2.6.0-test4-mm4/kernel/sched.c	2003-09-04 00:12:25.000000000 +1000
@@ -76,7 +76,6 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
-#define TIMESLICE_GRANULARITY	(HZ/40 ?: 1)
 #define ON_RUNQUEUE_WEIGHT	30
 #define CHILD_PENALTY		95
 #define PARENT_PENALTY		100
@@ -88,6 +87,7 @@
 #define STARVATION_LIMIT	(MAX_SLEEP_AVG)
 #define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
 #define NODE_THRESHOLD		125
+#define CREDIT_LIMIT		100
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -121,6 +121,15 @@
 	(NS_TO_JIFFIES((p)->sleep_avg) * MAX_BONUS / \
 		MAX_SLEEP_AVG)
 
+#ifdef CONFIG_SMP
+#define TIMESLICE_GRANULARITY(p) \
+	(MIN_TIMESLICE * (1 << (MAX_BONUS - CURRENT_BONUS(p))) * \
+		num_online_cpus())
+#else
+#define TIMESLICE_GRANULARITY(p) \
+	(MIN_TIMESLICE * (1 << (MAX_BONUS - CURRENT_BONUS(p))))
+#endif
+
 #define SCALE(v1,v1_max,v2_max) \
 	(v1) * (v2_max) / (v1_max)
 
@@ -136,10 +145,10 @@
 		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
 
 #define HIGH_CREDIT(p) \
-	((p)->interactive_credit > MAX_SLEEP_AVG)
+	((p)->interactive_credit > CREDIT_LIMIT)
 
 #define LOW_CREDIT(p) \
-	((p)->interactive_credit < -MAX_SLEEP_AVG)
+	((p)->interactive_credit < -CREDIT_LIMIT)
 
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
@@ -383,9 +392,13 @@ static void recalc_task_prio(task_t *p, 
 		 * prevent them suddenly becoming cpu hogs and starving
 		 * other processes.
 		 */
-		if (p->mm && sleep_time >JUST_INTERACTIVE_SLEEP(p))
-			p->sleep_avg = JUST_INTERACTIVE_SLEEP(p) + 1;
-		else {
+		if (p->mm && p->activated != -1 &&
+			sleep_time > JUST_INTERACTIVE_SLEEP(p)){
+				p->sleep_avg = JIFFIES_TO_NS(MAX_SLEEP_AVG -
+						AVG_TIMESLICE);
+				if (!HIGH_CREDIT(p))
+					p->interactive_credit++;
+		} else {
 			/*
 			 * The lower the sleep avg a task has the more
 			 * rapidly it will rise with sleep time.
@@ -1411,12 +1424,12 @@ void scheduler_tick(int user_ticks, int 
 		 * level, which is in essence a round-robin of tasks with
 		 * equal priority.
 		 *
-		 * This only applies to user tasks in the interactive
-		 * delta range with at least MIN_TIMESLICE left.
+		 * This only applies to tasks in the interactive
+		 * delta range with at least MIN_TIMESLICE to requeue.
 		 */
-		if (p->mm && TASK_INTERACTIVE(p) && !((task_timeslice(p) -
-			p->time_slice) % TIMESLICE_GRANULARITY) &&
-			(p->time_slice > MIN_TIMESLICE) &&
+		if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
+			p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
+			(p->time_slice >= (MIN_TIMESLICE * 2)) &&
 			(p->array == rq->active)) {
 
 			dequeue_task(p, rq->active);

--Boundary-00=_WBgV/Xlb1thw4xB--

