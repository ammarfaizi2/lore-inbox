Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbUCOXBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbUCOW6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:58:51 -0500
Received: from ns.suse.de ([195.135.220.2]:8116 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262776AbUCOWzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:55:05 -0500
Date: Mon, 15 Mar 2004 23:54:59 +0100
From: Kurt Garloff <garloff@suse.de>
To: Con Kolivas <kernel@kolivas.org>, Nick Piggin <piggin@cyberone.com.au>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: bonus inheritance
Message-ID: <20040315225459.GY4452@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Con Kolivas <kernel@kolivas.org>,
	Nick Piggin <piggin@cyberone.com.au>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8BV0TfTmv8nl9Pc"
Content-Disposition: inline
X-Operating-System: Linux 2.6.4-1-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8BV0TfTmv8nl9Pc
Content-Type: multipart/mixed; boundary="GOYT2+aw+EAigp19"
Content-Disposition: inline


--GOYT2+aw+EAigp19
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nick, Con,

in 2.4, the interactivity bonus in the O(1) scheduler was not inherited=20
well.

Imagine an idle shell with max bonus (say 200), then forking twice
would lead to the follwing situation:
bash(200) -> script.py(100) -> ls( 50)

In 2.6, this is partially fixed, as the penalty is set to 95.

I believe however, that the mistake of the penalty concept is drawing
the value to 0 instead of the average (100 on HZ=3D100 systems).

The fix is obvious: Draw to the center and have some inheritance.
This is what the first part of the 2.4 patch does, with inheritance
set to 50.
bash(200) -> script.py(150) -> ls(125)

The second hunk of the 2.4 patch makes the bonus non-linear.
The problem is that with the old behaviour processes tend to be stuck
at either the minimum or the maximum, as those are the only stable
values. With the non-linear formula, you give a higher penalty if
the bonus is higher. The algorithm has several stable points, depending
on CPU consumption.

The patch was written with the goal to improve interactive behaviour.
It did achieve this. Processes freshly started had a higher bonus thatn
the background kernel compile processes and thus get woken up.

The amazing thing is that the patch gave a few percent in SpecJBB and
Volanomark on a 8 way box.

I believe we need something similar in 2.6.
The first part is attached: The bonus inheritance is implemented as
inheritance, daring the value to the center instead of the minimum.
I put inheritance to 80 to more closely resemble current 2.6.

For the second part, I'm unsure. The current tweaks in the scheduler
may already have the non-linear property that I believe we need.
I'll need to reread the code to fully understand it though.

Ideas, comments?
--=20
Kurt Garloff                   <kurt@garloff.de>             [Koeln, DE]
Physics:Plasma modeling <garloff@plasimo.phys.tue.nl> [TU Eindhoven, NL]
Linux: SUSE Labs (Head)        <garloff@suse.de>    [SUSE Nuernberg, DE]

--GOYT2+aw+EAigp19
Content-Type: text/plain; charset=us-ascii
Content-Description: fork-interactive-balance-26.diff
Content-Disposition: attachment; filename=fork-interactive-balance
Content-Transfer-Encoding: quoted-printable

diff -uNrp linux-2.6.4.sched/kernel/sched.c linux-2.6.4.sched2/kernel/sched=
=2Ec
--- linux-2.6.4.sched/kernel/sched.c	2004-03-11 21:22:55.475136648 +0100
+++ linux-2.6.4.sched2/kernel/sched.c	2004-03-11 21:58:57.992384056 +0100
@@ -93,7 +93,7 @@ int max_timeslice =3D __MAX_TIMESLICE, min
 #define MIN_TIMESLICE ((min_timeslice * HZ + 999999) / 1000000)
=20
 #define ON_RUNQUEUE_WEIGHT	 30
-#define CHILD_PENALTY		 95
+#define CHILD_INHERITANCE	 80
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		  3
 #define PRIO_BONUS_RATIO	 25
@@ -761,8 +761,9 @@ void fastcall wake_up_forked_process(tas
 	current->sleep_avg =3D JIFFIES_TO_NS(CURRENT_BONUS(current) *
 		PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
=20
-	p->sleep_avg =3D JIFFIES_TO_NS(CURRENT_BONUS(p) *
-		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
+	p->sleep_avg =3D JIFFIES_TO_NS((CURRENT_BONUS(p)
+		* MAX_SLEEP_AVG / MAX_BONUS * CHILD_INHERITANCE / 100
+		+ (100-CHILD_INHERITANCE) * MAX_SLEEP_AVG / 200));
=20
 	p->interactive_credit =3D 0;
=20

--GOYT2+aw+EAigp19
Content-Type: text/plain; charset=us-ascii
Content-Description: fork-interactive-balance-24.diff
Content-Disposition: attachment; filename=sched-o1-fork-interactive-balance
Content-Transfer-Encoding: quoted-printable

--- linux-2.4.21/kernel/sched.c	2003-08-27 17:06:44.000000000 +0200
+++ linux-2.4.21.x86_64/kernel/sched.c	2003-08-27 21:47:39.000000000 +0200
@@ -60,7 +60,7 @@
 #define MAX_TIMESLICE (max_timeslice * HZ / 1000000)
 #define MIN_TIMESLICE (min_timeslice * HZ / 1000000)
=20
-#define CHILD_PENALTY		50
+#define CHILD_INHERITANCE	50
 #define PARENT_PENALTY		100
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
@@ -393,7 +393,7 @@
 		 * We decrease the sleep average of forked
 		 * children, to keep max-interactive tasks
 		 * from forking tasks that are max-interactive.
-		 * CHILD_PENALTY is set to 50% since we have
+		 * CHILD_INHERITANCE is set to 50% since we have
 		 * no clue if this is still an interactive
 		 * task like the parent or if this will be a
 		 * cpu bound task. The parent isn't touched
@@ -401,7 +401,8 @@
 		 * changing behaviour after the child is forked.
 		 */
 		parent->sleep_avg =3D parent->sleep_avg * PARENT_PENALTY / 100;
-		p->sleep_avg =3D p->sleep_avg * CHILD_PENALTY / 100;
+		p->sleep_avg =3D p->sleep_avg * CHILD_INHERITANCE / 100
+				+ (100-CHILD_INHERITANCE) * MAX_SLEEP_AVG / 200;
=20
 		/*
 		 * For its first schedule keep the child at the same
@@ -850,8 +851,7 @@
 	 * it possible for interactive tasks to use up their
 	 * timeslices at their highest priority levels.
 	 */
-	if (p->sleep_avg)
-		p->sleep_avg--;
+	p->sleep_avg =3D p->sleep_avg * (MAX_SLEEP_AVG-3) / MAX_SLEEP_AVG;
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);

--GOYT2+aw+EAigp19--

--n8BV0TfTmv8nl9Pc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAVjRCxmLh6hyYd04RAmz4AKDVHmHcJzugB34ChX4b3Cxf314nAgCgxb1/
+Jn9eYOmB/CCfV7Ee1BUPcU=
=Jr2j
-----END PGP SIGNATURE-----

--n8BV0TfTmv8nl9Pc--
