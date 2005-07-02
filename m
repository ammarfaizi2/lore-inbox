Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263333AbVGBAWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263333AbVGBAWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 20:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbVGBAWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 20:22:48 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:59046 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263333AbVGBAWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 20:22:40 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sched: consider migration thread with smp nice
Date: Sat, 2 Jul 2005 10:22:29 +1000
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>
References: <20050701044018.281b1ebd.akpm@osdl.org>
In-Reply-To: <20050701044018.281b1ebd.akpm@osdl.org>
MIME-Version: 1.0
X-Length: 3420
Content-Type: multipart/signed;
  boundary="nextPart20373517.hsKLUKJpss";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507021022.31933.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart20373517.hsKLUKJpss
Content-Type: multipart/mixed;
  boundary="Boundary-01=_F5dxC3yMNCJ732g"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_F5dxC3yMNCJ732g
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 1 Jul 2005 21:40, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc1/=
2.
>6.13-rc1-mm1/

Hi akpm

With your 4 bazillion patches I guess this got missed. It's an add-on=20
to the smp-nice series.

Cheers,
Con
=2D--



--Boundary-01=_F5dxC3yMNCJ732g
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="sched-consider_migration_thread_smp_nice.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="sched-consider_migration_thread_smp_nice.patch"

The intermittent scheduling of the migration thread at ultra high priority
makes the smp nice handling see that runqueue as being heavily loaded. The
migration thread itself actually handles the balancing so its influence on
priority balancing should be ignored.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.12-mm1/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.12-mm1.orig/kernel/sched.c	2005-06-26 17:59:10.000000000 +1=
000
+++ linux-2.6.12-mm1/kernel/sched.c	2005-06-26 18:02:01.000000000 +1000
@@ -669,6 +669,31 @@ static inline void dec_prio_bias(runqueu
 {
 	rq->prio_bias -=3D MAX_PRIO - prio;
 }
+
+static inline void inc_nr_running(task_t *p, runqueue_t *rq)
+{
+	rq->nr_running++;
+	if (rt_task(p)) {
+		if (p !=3D rq->migration_thread)
+			/*
+			 * The migration thread does the actual balancing. Do
+			 * not bias by its priority as the ultra high priority
+			 * will skew balancing adversely.
+			 */
+			inc_prio_bias(rq, p->prio);
+	} else
+		inc_prio_bias(rq, p->static_prio);
+}
+
+static inline void dec_nr_running(task_t *p, runqueue_t *rq)
+{
+	rq->nr_running--;
+	if (rt_task(p)) {
+		if (p !=3D rq->migration_thread)
+			dec_prio_bias(rq, p->prio);
+	} else
+		dec_prio_bias(rq, p->static_prio);
+}
 #else
 static inline void inc_prio_bias(runqueue_t *rq, int prio)
 {
@@ -677,25 +702,17 @@ static inline void inc_prio_bias(runqueu
 static inline void dec_prio_bias(runqueue_t *rq, int prio)
 {
 }
=2D#endif
=20
 static inline void inc_nr_running(task_t *p, runqueue_t *rq)
 {
 	rq->nr_running++;
=2D	if (rt_task(p))
=2D		inc_prio_bias(rq, p->prio);
=2D	else
=2D		inc_prio_bias(rq, p->static_prio);
 }
=20
 static inline void dec_nr_running(task_t *p, runqueue_t *rq)
 {
 	rq->nr_running--;
=2D	if (rt_task(p))
=2D		dec_prio_bias(rq, p->prio);
=2D	else
=2D		dec_prio_bias(rq, p->static_prio);
 }
+#endif
=20
 /*
  * __activate_task - move a task to the runqueue.

--Boundary-01=_F5dxC3yMNCJ732g--

--nextPart20373517.hsKLUKJpss
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCxd5HZUg7+tp6mRURArISAJ9XBdnpRUWH8DMeXyhhFgESm9ZTYwCaAx3l
3qXYEnLWT3quP86K09ho18k=
=qRzW
-----END PGP SIGNATURE-----

--nextPart20373517.hsKLUKJpss--
