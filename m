Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVEWKHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVEWKHv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 06:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVEWKHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 06:07:51 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:15822 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261870AbVEWKH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 06:07:29 -0400
From: Con Kolivas <kernel@kolivas.org>
To: AndrewMorton <akpm@osdl.org>
Subject: [PATCH] SCHED: account_rt_tasks_in_prio_bias
Date: Mon, 23 May 2005 20:07:13 +1000
User-Agent: KMail/1.8
Cc: Ingo Molnar <mingo@elte.hu>, ck@vds.kolivas.org,
       Markus =?iso-8859-1?q?T=F6rnqvist?= <mjt@nysv.org>,
       Carlos Carvalho <carlos@fisica.ufpr.br>, linux-kernel@vger.kernel.org,
       Peter Williams <pwil3058@bigpond.net.au>
References: <20050509112446.GZ1399@nysv.org> <200505211500.42527.kernel@kolivas.org> <200505231928.13168.kernel@kolivas.org>
In-Reply-To: <200505231928.13168.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1427074.N8y5rlxlOv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505232007.16908.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1427074.N8y5rlxlOv
Content-Type: multipart/mixed;
  boundary="Boundary-01=_StakCNjpkDeW/oW"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_StakCNjpkDeW/oW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, 23 May 2005 19:28, Con Kolivas wrote:
> On Sat, 21 May 2005 15:00, Con Kolivas wrote:
> > Ok I've respun the smp nice support for the cpu scheduler modifications
> > that are in current -mm. Tested on 2.6.12-rc4-mm2 on 4x and seems to wo=
rk
> > fine.
>
> Thanks to Peter Williams for noting I should only change the prio_bias if
> the task is queued in set_user_nice.

And for completeness the effect of real time tasks' real time priority leve=
l=20
should be considered in prio_bias instead of their nice level.

Con
=2D--


--Boundary-01=_StakCNjpkDeW/oW
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="account_rt_tasks_in_prio_bias.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="account_rt_tasks_in_prio_bias.diff"

Real time tasks' effect on prio_bias should be based on their real time
priority level instead of their static_prio which is based on nice.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.12-rc4-mm2/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.12-rc4-mm2.orig/kernel/sched.c	2005-05-23 19:23:10.00000000=
0 +1000
+++ linux-2.6.12-rc4-mm2/kernel/sched.c	2005-05-23 19:59:45.000000000 +1000
@@ -659,21 +659,21 @@ static int effective_prio(task_t *p)
 }
=20
 #ifdef CONFIG_SMP
=2Dstatic inline void inc_prio_bias(runqueue_t *rq, int static_prio)
+static inline void inc_prio_bias(runqueue_t *rq, int prio)
 {
=2D	rq->prio_bias +=3D MAX_PRIO - static_prio;
+	rq->prio_bias +=3D MAX_PRIO - prio;
 }
=20
=2Dstatic inline void dec_prio_bias(runqueue_t *rq, int static_prio)
+static inline void dec_prio_bias(runqueue_t *rq, int prio)
 {
=2D	rq->prio_bias -=3D MAX_PRIO - static_prio;
+	rq->prio_bias -=3D MAX_PRIO - prio;
 }
 #else
=2Dstatic inline void inc_prio_bias(runqueue_t *rq, int static_prio)
+static inline void inc_prio_bias(runqueue_t *rq, int prio)
 {
 }
=20
=2Dstatic inline void dec_prio_bias(runqueue_t *rq, int static_prio)
+static inline void dec_prio_bias(runqueue_t *rq, int prio)
 {
 }
 #endif
@@ -681,13 +681,19 @@ static inline void dec_prio_bias(runqueu
 static inline void inc_nr_running(task_t *p, runqueue_t *rq)
 {
 	rq->nr_running++;
=2D	inc_prio_bias(rq, p->static_prio);
+	if (rt_task(p))
+		inc_prio_bias(rq, p->prio);
+	else
+		inc_prio_bias(rq, p->static_prio);
 }
=20
 static inline void dec_nr_running(task_t *p, runqueue_t *rq)
 {
 	rq->nr_running--;
=2D	dec_prio_bias(rq, p->static_prio);
+	if (rt_task(p))
+		dec_prio_bias(rq, p->prio);
+	else
+		dec_prio_bias(rq, p->static_prio);
 }
=20
 /*

--Boundary-01=_StakCNjpkDeW/oW--

--nextPart1427074.N8y5rlxlOv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCkatUZUg7+tp6mRURAgf3AJ9X48LE+2oiRtdIdYB96Q7Yzr6BGwCePHE5
L3Rm3GUH25TWdmZ+6nMzTno=
=OvPW
-----END PGP SIGNATURE-----

--nextPart1427074.N8y5rlxlOv--
