Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbTH2FnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 01:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264053AbTH2FnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 01:43:20 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:50572
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264356AbTH2FnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 01:43:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH]O19int
Date: Fri, 29 Aug 2003 15:50:22 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Voluspa <lista1@comhem.se>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_emuT/ouFQcBbh8j"
Message-Id: <200308291550.28159.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_emuT/ouFQcBbh8j
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Small error in the just interactive logic has been corrected.

Idle tasks get one higher priority than just interactive so they don't get=
=20
swamped under heavy load.

Cosmetic cleanup.

Patch against 2.6.0-test4-mm2

Con
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/TumgZUg7+tp6mRURAtkkAJwJKjY1DmvuNR+eyphU07svVP7uWQCeMHgv
pcYhT1dX+iaFq6F1Son8pGc=3D
=3Drxj9
=2D----END PGP SIGNATURE-----

--Boundary-00=_emuT/ouFQcBbh8j
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O18.1-O19int"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="patch-O18.1-O19int"

--- linux-2.6.0-test4-mm2/kernel/sched.c	2003-08-28 22:57:49.000000000 +1000
+++ linux-2.6.0-test4-mm2-O19/kernel/sched.c	2003-08-29 15:37:06.000000000 +1000
@@ -64,8 +64,8 @@
 /*
  * Some helpers for converting nanosecond timing to jiffy resolution
  */
-#define NS_TO_JIFFIES(TIME)	(TIME / (1000000000 / HZ))
-#define JIFFIES_TO_NS(TIME)	(TIME * (1000000000 / HZ))
+#define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
+#define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
 
 /*
  * These are the 'tuning knobs' of the scheduler:
@@ -132,7 +132,8 @@
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
 #define JUST_INTERACTIVE_SLEEP(p) \
-	(MAX_SLEEP_AVG - (DELTA(p) * AVG_TIMESLICE))
+	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
+		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
 
 #define HIGH_CREDIT(p) \
 	((p)->interactive_credit > MAX_SLEEP_AVG)
@@ -382,10 +383,8 @@ static void recalc_task_prio(task_t *p, 
 		 * prevent them suddenly becoming cpu hogs and starving
 		 * other processes.
 		 */
-		if (p->mm && sleep_time >
-			JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p)))
-				p->sleep_avg =
-					JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p));
+		if (p->mm && sleep_time >JUST_INTERACTIVE_SLEEP(p))
+			p->sleep_avg = JUST_INTERACTIVE_SLEEP(p) + 1;
 		else {
 			/*
 			 * The lower the sleep avg a task has the more
@@ -405,16 +404,15 @@ static void recalc_task_prio(task_t *p, 
 			/*
 			 * Non high_credit tasks waking from uninterruptible
 			 * sleep are limited in their sleep_avg rise as they
-			 * are likely to be waiting on I/O
+			 * are likely to be cpu hogs waiting on I/O
 			 */
 			if (p->activated == -1 && !HIGH_CREDIT(p) && p->mm){
-				if (p->sleep_avg >=
-					JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p)))
-						sleep_time = 0;
+				if (p->sleep_avg >= JUST_INTERACTIVE_SLEEP(p))
+					sleep_time = 0;
 				else if (p->sleep_avg + sleep_time >=
-					JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p))){
+					JUST_INTERACTIVE_SLEEP(p)){
 						p->sleep_avg =
-							JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p));
+							JUST_INTERACTIVE_SLEEP(p);
 						sleep_time = 0;
 					}
 			}
@@ -431,7 +429,8 @@ static void recalc_task_prio(task_t *p, 
 
 			if (p->sleep_avg > NS_MAX_SLEEP_AVG){
 				p->sleep_avg = NS_MAX_SLEEP_AVG;
-				p->interactive_credit += !(HIGH_CREDIT(p));
+				if (!HIGH_CREDIT(p))
+					p->interactive_credit++;
 			}
 		}
 	}
@@ -1547,8 +1546,8 @@ switch_tasks:
 	prev->sleep_avg -= run_time;
 	if ((long)prev->sleep_avg <= 0){
 		prev->sleep_avg = 0;
-		prev->interactive_credit -=
-			!(HIGH_CREDIT(prev) || LOW_CREDIT(prev));
+		if (!(HIGH_CREDIT(prev) || LOW_CREDIT(prev)))
+			prev->interactive_credit--;
 	}
 	prev->timestamp = now;
 

--Boundary-00=_emuT/ouFQcBbh8j--

