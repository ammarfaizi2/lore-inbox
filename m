Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbTGFRBt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 13:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTGFRBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 13:01:49 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:15798 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262636AbTGFRBk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 13:01:40 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O3int interactivity for 2.5.74-mm2
Date: Mon, 7 Jul 2003 03:16:55 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HmFC/W16EoWpU+y"
Message-Id: <200307070317.11246.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_HmFC/W16EoWpU+y
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Attached is an incremental patch against 2.5.74-mm2 with more interactivity=
=20
work. Audio should be quite resistant to skips with this, and it should not=
=20
induce further unfairness.

Changes:
The sleep_avg buffer was not needed with the improved semantics in O2int so=
 it=20
has been removed entirely as it created regressions in O2int.

A small change to the idle detection code to only make tasks with enough=20
accumulated sleep_avg become idle.

Minor cleanups and clarified code.


Other issues:
Jerky mouse with heavy page rendering in web browsers remains. This is a=20
different issue to the audio and will need some more thought.

The patch is also available for download here:
http://kernel.kolivas.org/2.5

Note for those who wish to get smooth X desktop feel now for their own use,=
=20
the granularity patch on that website will do wonders on top of O3int, but =
a=20
different approach will be needed for mainstream consumption.

Con
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/CFmHF6dfvkL3i1gRAkqTAKCjE3lRwBWomZbn/asWtv+OWiFovQCfZo0P
UfqOKVgv88faks6+vPq5BGM=3D
=3DZR4Y
=2D----END PGP SIGNATURE-----

--Boundary-00=_HmFC/W16EoWpU+y
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O3int-0307070226"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-O3int-0307070226"

--- linux-2.5.74/kernel/sched.c	2003-07-07 02:13:57.000000000 +1000
+++ linux-2.5.74-test/kernel/sched.c	2003-07-07 02:58:47.000000000 +1000
@@ -77,6 +77,7 @@
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
+#define MAX_BONUS		((MAX_USER_PRIO - MAX_RT_PRIO) * PRIO_BONUS_RATIO / 100)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -306,7 +307,7 @@ static inline void normalise_sleep(task_
 {
 	unsigned long old_avg_time = jiffies - p->avg_start;
 
-	if (old_avg_time < MIN_SLEEP_AVG)
+	if (unlikely(old_avg_time < MIN_SLEEP_AVG))
 		return;
 
 	if (p->sleep_avg > MAX_SLEEP_AVG)
@@ -406,21 +407,16 @@ static inline void activate_task(task_t 
 		 */
 		if (runtime < MAX_SLEEP_AVG)
 			p->sleep_avg += (runtime - p->sleep_avg) * (MAX_SLEEP_AVG - runtime) *
-				(10 - INTERACTIVE_DELTA) / 10 / MAX_SLEEP_AVG;
+				(MAX_BONUS - INTERACTIVE_DELTA) / MAX_BONUS / MAX_SLEEP_AVG;
 
-		/*
-		 * Keep a buffer of 10% sleep_avg
-		 * to prevent short bursts of cpu activity from making
-		 * interactive tasks lose their bonus
-		 */
-		if (p->sleep_avg > MAX_SLEEP_AVG * 11/10)
-			p->sleep_avg = MAX_SLEEP_AVG * 11/10;
+		if (p->sleep_avg > MAX_SLEEP_AVG)
+			p->sleep_avg = MAX_SLEEP_AVG;
 
 		/*
 		 * Tasks that sleep a long time are categorised as idle and
 		 * get their static priority only
 		 */
-		if (sleep_time > MIN_SLEEP_AVG)
+		if ((sleep_time > MIN_SLEEP_AVG) && (p->sleep_avg > runtime / 2))
 			p->sleep_avg = runtime / 2;
 
 		if (unlikely(p->avg_start > jiffies)){

--Boundary-00=_HmFC/W16EoWpU+y--

