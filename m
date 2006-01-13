Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161544AbWAMKXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161544AbWAMKXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161545AbWAMKXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:23:54 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:21439 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161542AbWAMKXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:23:46 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] sched-dont_decrease_idle_sleep_avg.patch
Date: Fri, 13 Jan 2006 21:23:29 +1100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
X-Length: 2231
Content-Type: multipart/signed;
  boundary="nextPart5014657.GqRn1B6URG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601132123.31402.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5014657.GqRn1B6URG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

We watch for tasks that sleep extended periods and don't allow one single
prolonged sleep period from elevating priority to maximum bonus to prevent
cpu bound tasks from getting high priority with single long sleeps. There
is a bug in the current code that also penalises tasks that already have
high priority. Correct that bug.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 kernel/sched.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

Index: linux-2.6.15/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15.orig/kernel/sched.c
+++ linux-2.6.15/kernel/sched.c
@@ -747,14 +747,19 @@ static int recalc_task_prio(task_t *p, u
 	if (likely(sleep_time > 0)) {
 		/*
 		 * User tasks that sleep a long time are categorised as
=2D		 * idle and will get just interactive status to stay active &
=2D		 * prevent them suddenly becoming cpu hogs and starving
=2D		 * other processes.
+		 * idle. They will only have their sleep_avg increased to a
+		 * level that makes them just interactive priority to stay
+		 * active yet prevent them suddenly becoming cpu hogs and
+		 * starving other processes.
 		 */
 		if (p->mm && p->sleep_type !=3D SLEEP_NONINTERACTIVE &&
 			sleep_time > INTERACTIVE_SLEEP(p)) {
=2D				p->sleep_avg =3D JIFFIES_TO_NS(MAX_SLEEP_AVG -
=2D						DEF_TIMESLICE);
+				unsigned long ceiling;
+
+				ceiling =3D JIFFIES_TO_NS(MAX_SLEEP_AVG -
+					DEF_TIMESLICE);
+				if (p->sleep_avg < ceiling)
+					p->sleep_avg =3D ceiling;
 		} else {
=20
 			/*

--nextPart5014657.GqRn1B6URG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDx3+jZUg7+tp6mRURAph7AJoDuoOrkTCTfg1yu2t/xWnAZgydkACfXRag
EFkU+bpmXmi5D7OJ7sWEr68=
=oE5y
-----END PGP SIGNATURE-----

--nextPart5014657.GqRn1B6URG--
