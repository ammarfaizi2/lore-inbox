Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161538AbWAMKX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161538AbWAMKX3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161541AbWAMKX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:23:28 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:33737 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161538AbWAMKX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:23:27 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] sched-alter_uninterruptible_sleep_interactivity.patch
Date: Fri, 13 Jan 2006 21:23:08 +1100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
X-Length: 4088
Content-Type: multipart/signed;
  boundary="nextPart1493609.BisPe4bOj0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601132123.12844.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1493609.BisPe4bOj0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The interactivity estimator special cases tasks that are waking up from
uninterruptible sleep based on the fact that most uninterruptible sleep
represents a task waiting on disk I/O and is not truly interactive. The
current system uses a ceiling to the priority bonus said tasks can receive.
The problem with that system is that if there are enough interactive tasks
at high bonus levels it can lead to I/O starvation.

In order to remove the ceiling but still maintain some special case treatme=
nt
of uninterruptible sleep, we can make any sleep_avg incrementing to be pure=
ly
based on sleep time instead of being biased in the non-linear fashion that
interactive tasks are.

This will lead to a detriment in interactive behaviour under disk I/O howev=
er
the current system unfairly biases against them and leads to a loss of disk
throughput. This change should restore a better balance between disk
throughput and interactivity.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 kernel/sched.c |   36 ++++++++++++------------------------
 1 files changed, 12 insertions(+), 24 deletions(-)

Index: linux-2.6.15/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15.orig/kernel/sched.c
+++ linux-2.6.15/kernel/sched.c
@@ -756,26 +756,17 @@ static int recalc_task_prio(task_t *p, u
 				p->sleep_avg =3D JIFFIES_TO_NS(MAX_SLEEP_AVG -
 						DEF_TIMESLICE);
 		} else {
=2D			/*
=2D			 * The lower the sleep avg a task has the more
=2D			 * rapidly it will rise with sleep time.
=2D			 */
=2D			sleep_time *=3D (MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
=20
 			/*
=2D			 * Tasks waking from uninterruptible sleep are
=2D			 * limited in their sleep_avg rise as they
=2D			 * are likely to be waiting on I/O
+			 * The lower the sleep avg a task has the more
+			 * rapidly it will rise with sleep time. This enables
+			 * tasks to rapidly recover to a low latency priority.
+			 * If a task was sleeping with the noninteractive
+			 * label do not apply this non-linear boost
 			 */
=2D			if (p->sleep_type =3D=3D SLEEP_NONINTERACTIVE && p->mm) {
=2D				if (p->sleep_avg >=3D INTERACTIVE_SLEEP(p))
=2D					sleep_time =3D 0;
=2D				else if (p->sleep_avg + sleep_time >=3D
=2D						INTERACTIVE_SLEEP(p)) {
=2D					p->sleep_avg =3D INTERACTIVE_SLEEP(p);
=2D					sleep_time =3D 0;
=2D				}
=2D			}
+			if (p->sleep_type !=3D SLEEP_NONINTERACTIVE || p->mm)
+				sleep_time *=3D
+					(MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
=20
 			/*
 			 * This code gives a bonus to interactive tasks.
@@ -818,11 +809,7 @@ static void activate_task(task_t *p, run
 	if (!rt_task(p))
 		p->prio =3D recalc_task_prio(p, now);
=20
=2D	/*
=2D	 * This checks to make sure it's not an uninterruptible task
=2D	 * that is now waking up.
=2D	 */
=2D	if (p->sleep_type =3D=3D SLEEP_NORMAL) {
+	if (p->sleep_type !=3D SLEEP_NONINTERACTIVE) {
 		/*
 		 * Tasks which were woken up by interrupts (ie. hw events)
 		 * are most likely of interactive nature. So we give them
@@ -1356,8 +1343,9 @@ out_activate:
 	if (old_state =3D=3D TASK_UNINTERRUPTIBLE) {
 		rq->nr_uninterruptible--;
 		/*
=2D		 * Tasks on involuntary sleep don't earn
=2D		 * sleep_avg beyond just interactive state.
+		 * Tasks waking from uninterruptible sleep are likely
+		 * to be sleeping involuntarily on I/O and are otherwise
+		 * cpu bound so label them as noninteractive.
 		 */
 		p->sleep_type =3D SLEEP_NONINTERACTIVE;
 	}

--nextPart1493609.BisPe4bOj0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDx3+QZUg7+tp6mRURAqvwAKCTXIM1TmTZN6q1Nf2uwkuER30W7wCfYT5B
AoCXgNU2dNXtkzg+RIFyxzU=
=45G9
-----END PGP SIGNATURE-----

--nextPart1493609.BisPe4bOj0--
