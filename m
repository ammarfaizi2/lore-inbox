Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269050AbTGJHOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 03:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbTGJHOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 03:14:45 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:10214 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S269057AbTGJHG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 03:06:57 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O4int interactivity
Date: Thu, 10 Jul 2003 17:23:13 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hRRD/0LJFG3I9wW"
Message-Id: <200307101723.24615.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_hRRD/0LJFG3I9wW
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is a diff against the O3int patch in 2.5.74-mm3 trying to decrease aud=
io=20
skips and improve X smoothness.

It is easier to become interactive with this one to try and decrease=20
application startup and wakeup time, while hopefully still preventing cpu=20
hogs from starving the machine.

Changes:
Child penalty increased to 95 as in early 2.5 O(1) implementations. This fi=
xes=20
the "parent spinning madly waiting for child to spawn and in the process it=
=20
is the parent that starves the child"; 80 wasn't enough.

The sleep buffer has returned much smaller currently set at 50ms which=20
prevents fully interactive tasks from dropping down a priority for short=20
bursts of cpu activity (eg X).

Idle tasks now get a small priority boost so they "rest" at a dynamic prior=
ity=20
just below interactive. They now wake up to an interactive state more=20
rapidly, and spawn more interactive children.

The variable boost when a process has been running less than MAX_SLEEP_AVG =
has=20
been tweaked and consequently is more aggressive.

Slight code rearrangement to have one less if.. branch.

Also available for download here:
http://kernel.kolivas.org/2.5

Con
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/DRRhF6dfvkL3i1gRAgxQAJ9GAe3YSbu+WHO+G6axYVxhPAOfSwCglJFd
waidp26mha2+CwZ+oPOzuFI=3D
=3Dq1rz
=2D----END PGP SIGNATURE-----

--Boundary-00=_hRRD/0LJFG3I9wW
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O4int-0307101041"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-O4int-0307101041"

--- linux-2.5.74-mm3/kernel/sched.c	2003-07-10 10:23:14.000000000 +1000
+++ linux-2.5.74-test/kernel/sched.c	2003-07-10 10:41:57.000000000 +1000
@@ -68,7 +68,7 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
-#define CHILD_PENALTY		80
+#define CHILD_PENALTY		95
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
@@ -76,6 +76,7 @@
 #define MIN_SLEEP_AVG		(HZ)
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
+#define SLEEP_BUFFER		(HZ/20)
 #define NODE_THRESHOLD		125
 #define MAX_BONUS		((MAX_USER_PRIO - MAX_RT_PRIO) * PRIO_BONUS_RATIO / 100)
 
@@ -392,33 +393,42 @@ static inline void activate_task(task_t 
 		unsigned long runtime = jiffies - p->avg_start;
 
 		/*
-		 * This code gives a bonus to interactive tasks.
-		 *
-		 * The boost works by updating the 'average sleep time'
-		 * value here, based on ->last_run. The more time a task
-		 * spends sleeping, the higher the average gets - and the
-		 * higher the priority boost gets as well.
-		 */
-		p->sleep_avg += sleep_time;
-		/*
-		 * Give a bonus to tasks that wake early on to prevent
-		 * the problem of the denominator in the bonus equation
-		 * from continually getting larger.
-		 */
-		if (runtime < MAX_SLEEP_AVG)
-			p->sleep_avg += (runtime - p->sleep_avg) * (MAX_SLEEP_AVG - runtime) *
-				(MAX_BONUS - INTERACTIVE_DELTA) / MAX_BONUS / MAX_SLEEP_AVG;
-
-		if (p->sleep_avg > MAX_SLEEP_AVG)
-			p->sleep_avg = MAX_SLEEP_AVG;
-
-		/*
 		 * Tasks that sleep a long time are categorised as idle and
-		 * get their static priority only
+		 * will get just under interactive status with a small runtime
+		 * to allow them to become interactive or non-interactive rapidly
 		 */
 		if (sleep_time > MIN_SLEEP_AVG){
 			p->avg_start = jiffies - MIN_SLEEP_AVG;
-			p->sleep_avg = MIN_SLEEP_AVG / 2;
+			p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 1) /
+				MAX_BONUS;
+		} else {
+			/*
+			 * This code gives a bonus to interactive tasks.
+			 *
+			 * The boost works by updating the 'average sleep time'
+			 * value here, based on ->last_run. The more time a task
+			 * spends sleeping, the higher the average gets - and the
+			 * higher the priority boost gets as well.
+			 */
+			p->sleep_avg += sleep_time;
+
+			/*
+			 * Give a bonus to tasks that wake early on to prevent
+			 * the problem of the denominator in the bonus equation
+			 * from continually getting larger.
+			 */
+			if ((runtime - MIN_SLEEP_AVG) < MAX_SLEEP_AVG)
+				p->sleep_avg += (runtime - p->sleep_avg) *
+					(MAX_SLEEP_AVG + MIN_SLEEP_AVG - runtime) *
+					(MAX_BONUS - INTERACTIVE_DELTA) / MAX_BONUS / MAX_SLEEP_AVG;
+
+			/*
+			 * Keep a small buffer of SLEEP_BUFFER sleep_avg to
+			 * prevent fully interactive tasks from becoming
+			 * lower priority with small bursts of cpu usage.
+			 */
+			if (p->sleep_avg > (MAX_SLEEP_AVG + SLEEP_BUFFER))
+				p->sleep_avg = MAX_SLEEP_AVG + SLEEP_BUFFER;
 		}
 
 		if (unlikely(p->avg_start > jiffies)){

--Boundary-00=_hRRD/0LJFG3I9wW--

