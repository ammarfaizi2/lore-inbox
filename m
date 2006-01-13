Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161541AbWAMKXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161541AbWAMKXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161544AbWAMKXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:23:43 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:24452 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161541AbWAMKXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:23:36 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] sched-make_task_noninteractive_use_sleep_type.patch
Date: Fri, 13 Jan 2006 21:23:20 +1100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
X-Length: 2557
Content-Type: multipart/signed;
  boundary="nextPart1381888.ZcvehCUDp2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601132123.22681.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1381888.ZcvehCUDp2
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alterations to the pipe code in the kernel made it possible for relative
starvation to occur with tasks that slept waiting on a pipe getting
unfair priority bonuses even if they were otherwise fully cpu bound so the
TASK_NONINTERACTIVE flag was introduced which prevented any change to
sleep_avg while sleeping waiting on a pipe. This change also leads to the
converse though, preventing any priority boost from occurring in truly
interactive tasks that wait on pipes.

Convert the TASK_NONINTERACTIVE flag to set sleep_type to
SLEEP_NONINTERACTIVE which will allow a linear bonus to priority based on
sleep time thus allowing interactive tasks to get high priority if they
sleep enough.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 kernel/sched.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6.15/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15.orig/kernel/sched.c
+++ linux-2.6.15/kernel/sched.c
@@ -1348,18 +1348,18 @@ out_activate:
 		 * cpu bound so label them as noninteractive.
 		 */
 		p->sleep_type =3D SLEEP_NONINTERACTIVE;
=2D	}
+	} else
=20
 	/*
 	 * Tasks that have marked their sleep as noninteractive get
=2D	 * woken up without updating their sleep average. (i.e. their
=2D	 * sleep is handled in a priority-neutral manner, no priority
=2D	 * boost and no penalty.)
+	 * woken up with their sleep average not weighted in an
+	 * interactive way.
 	 */
=2D	if (old_state & TASK_NONINTERACTIVE)
=2D		__activate_task(p, rq);
=2D	else
=2D		activate_task(p, rq, cpu =3D=3D this_cpu);
+		if (old_state & TASK_NONINTERACTIVE)
+			p->sleep_type =3D SLEEP_NONINTERACTIVE;
+
+
+	activate_task(p, rq, cpu =3D=3D this_cpu);
 	/*
 	 * Sync wakeups (i.e. those types of wakeups where the waker
 	 * has indicated that it will leave the CPU in short order)

--nextPart1381888.ZcvehCUDp2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDx3+aZUg7+tp6mRURApuNAJ9sAlS/jA2bnISPVeTuaj2w3S1VfACcDZeN
cQlo8GzdX/bURH2CngRiSc4=
=OM6S
-----END PGP SIGNATURE-----

--nextPart1381888.ZcvehCUDp2--
