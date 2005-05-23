Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVEWJ2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVEWJ2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 05:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVEWJ2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 05:28:35 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:8910 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261870AbVEWJ2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 05:28:23 -0400
From: Con Kolivas <kernel@kolivas.org>
To: AndrewMorton <akpm@osdl.org>
Subject: [PATCH] SCHED: change_prio_bias_only_if_queued
Date: Mon, 23 May 2005 19:28:10 +1000
User-Agent: KMail/1.8
Cc: Ingo Molnar <mingo@elte.hu>, ck@vds.kolivas.org,
       Markus =?iso-8859-1?q?T=F6rnqvist?= <mjt@nysv.org>,
       Carlos Carvalho <carlos@fisica.ufpr.br>, linux-kernel@vger.kernel.org,
       Peter Williams <pwil3058@bigpond.net.au>
References: <20050509112446.GZ1399@nysv.org> <200505182345.22614.kernel@kolivas.org> <200505211500.42527.kernel@kolivas.org>
In-Reply-To: <200505211500.42527.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1441460.9sy2ZOJDo3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505231928.13168.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1441460.9sy2ZOJDo3
Content-Type: multipart/mixed;
  boundary="Boundary-01=_rIakCGHdVQKSZg3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_rIakCGHdVQKSZg3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, 21 May 2005 15:00, Con Kolivas wrote:
> Ok I've respun the smp nice support for the cpu scheduler modifications
> that are in current -mm. Tested on 2.6.12-rc4-mm2 on 4x and seems to work
> fine.

Thanks to Peter Williams for noting I should only change the prio_bias if t=
he=20
task is queued in set_user_nice.

Con
=2D--


--Boundary-01=_rIakCGHdVQKSZg3
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="change_prio_bias_only_if_queued.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="change_prio_bias_only_if_queued.diff"

prio_bias should only be adjusted in set_user_nice if p is actually current=
ly
queued.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.12-rc4-mm2/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.12-rc4-mm2.orig/kernel/sched.c	2005-05-21 14:25:07.00000000=
0 +1000
+++ linux-2.6.12-rc4-mm2/kernel/sched.c	2005-05-23 19:23:10.000000000 +1000
@@ -3399,25 +3399,24 @@ void set_user_nice(task_t *p, long nice)
 	 * not SCHED_NORMAL:
 	 */
 	if (rt_task(p)) {
=2D		dec_prio_bias(rq, p->static_prio);
 		p->static_prio =3D NICE_TO_PRIO(nice);
=2D		inc_prio_bias(rq, p->static_prio);
 		goto out_unlock;
 	}
 	array =3D p->array;
=2D	if (array)
+	if (array) {
 		dequeue_task(p, array);
+		dec_prio_bias(rq, p->static_prio);
+	}
=20
 	old_prio =3D p->prio;
 	new_prio =3D NICE_TO_PRIO(nice);
 	delta =3D new_prio - old_prio;
=2D	dec_prio_bias(rq, p->static_prio);
 	p->static_prio =3D NICE_TO_PRIO(nice);
=2D	inc_prio_bias(rq, p->static_prio);
 	p->prio +=3D delta;
=20
 	if (array) {
 		enqueue_task(p, array);
+		inc_prio_bias(rq, p->static_prio);
 		/*
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:

--Boundary-01=_rIakCGHdVQKSZg3--

--nextPart1441460.9sy2ZOJDo3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCkaItZUg7+tp6mRURAqBdAKCRcN/3iLXhQ1bpAB80nhD3QVpTHwCbBntF
hlyJiOxyTTwCtVSPelKoMO8=
=mBYM
-----END PGP SIGNATURE-----

--nextPart1441460.9sy2ZOJDo3--
