Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbULFXSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbULFXSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 18:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbULFXSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 18:18:05 -0500
Received: from mout0.freenet.de ([194.97.50.131]:24296 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S261691AbULFXMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 18:12:09 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: [PATCH, RFC] protect call to set_tsk_need_resched() by the rq-lock
Date: Mon, 6 Dec 2004 23:39:47 +0100
User-Agent: KMail/1.7.1
Cc: kernel@kolivas.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2239313.a1LyMQ2jx9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412062339.52695.mbuesch@freenet.de>
X-Warning: freenet.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2239313.a1LyMQ2jx9
Content-Type: multipart/mixed;
  boundary="Boundary-01=_z+NtBkhis+ONoqI"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_z+NtBkhis+ONoqI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

The two attached patches (one against vanilla kernel and one
against ck patchset) moves the rq-lock a few lines up in
scheduler_tick() to also protect set_tsk_need_resched().

Is that neccessary?
If yes, please apply.

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]



--Boundary-01=_z+NtBkhis+ONoqI
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mainline_sched-rqlock.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mainline_sched-rqlock.diff"

Index: linux-2.5/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/mb/develop/linux/rsync/linux-2.5/kernel/sched.c,v
retrieving revision 1.382
diff -u -p -r1.382 sched.c
=2D-- linux-2.5/kernel/sched.c	19 Nov 2004 22:51:35 -0000	1.382
+++ linux-2.5/kernel/sched.c	6 Dec 2004 22:32:09 -0000
@@ -2318,12 +2318,12 @@ void scheduler_tick(int user_ticks, int=20
 		cpustat->user +=3D user_ticks;
 	cpustat->system +=3D sys_ticks;
=20
+	spin_lock(&rq->lock);
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array !=3D rq->active) {
 		set_tsk_need_resched(p);
=2D		goto out;
+		goto out_unlock;
 	}
=2D	spin_lock(&rq->lock);
 	/*
 	 * The task was running during this tick - update the
 	 * time slice counter. Note: we do not update a thread's

--Boundary-01=_z+NtBkhis+ONoqI
Content-Type: text/x-diff;
  charset="us-ascii";
  name="staircase_sched-rqlock.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="staircase_sched-rqlock.diff"

=2D-- linux-2.6.10-rc3-ck1-nozeroram/kernel/sched.c.orig	2004-12-05 01:55:0=
8.000000000 +0100
+++ linux-2.6.10-rc3-ck1-nozeroram/kernel/sched.c	2004-12-06 23:27:41.00000=
0000 +0100
@@ -2147,18 +2147,18 @@
 		cpustat->user +=3D user_ticks;
 	cpustat->system +=3D sys_ticks;
=20
+	spin_lock(&rq->lock);
 	/* Task might have expired already, but not scheduled off yet */
 	if (unlikely(!task_queued(p))) {
 		set_tsk_need_resched(p);
=2D		goto out;
+		goto out_unlock;
 	}
 	/*
 	 * SCHED_FIFO tasks never run out of timeslice.
 	 */
 	if (unlikely(p->policy =3D=3D SCHED_FIFO))
=2D		goto out;
+		goto out_unlock;
=20
=2D	spin_lock(&rq->lock);
 	debit =3D ns_diff(rq->timestamp_last_tick, p->timestamp);
 	p->ns_debit +=3D debit;
 	if (p->ns_debit < NSJIFFY)

--Boundary-01=_z+NtBkhis+ONoqI--

--nextPart2239313.a1LyMQ2jx9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBtN+4FGK1OIvVOP4RAswKAKCTbT/wSAjM9qVWHQ7xN+VhTtGzVQCg1oDJ
j0IwEuZB/Gl/3K3X5pt/v/U=
=VKtR
-----END PGP SIGNATURE-----

--nextPart2239313.a1LyMQ2jx9--
