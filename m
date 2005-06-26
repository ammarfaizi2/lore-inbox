Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVFZI1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVFZI1s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 04:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVFZI1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 04:27:47 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:35228 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261503AbVFZIZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 04:25:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: consider migration thread with smp nice
Date: Sun, 26 Jun 2005 18:25:16 +1000
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@aracnet.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1434534.BAFI97bJtD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506261825.19740.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1434534.BAFI97bJtD
Content-Type: multipart/mixed;
  boundary="Boundary-01=_tZmvC98yY70b5rb"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_tZmvC98yY70b5rb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch improves throughput with the smp nice balancing code. Many thank=
s=20
to Martin Bligh for the usage of his regression testing bed to confirm the=
=20
effectiveness of various patches.

Con
=2D--



--Boundary-01=_tZmvC98yY70b5rb
Content-Type: text/x-diff;
  charset="us-ascii";
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

--Boundary-01=_tZmvC98yY70b5rb--

--nextPart1434534.BAFI97bJtD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCvmZvZUg7+tp6mRURAkUGAJ9035oe9cEQ6hbIAs0PR5eJnojTYACdFoDe
OWOUmuhpcBMnG2HUeIFcfyc=
=9vjf
-----END PGP SIGNATURE-----

--nextPart1434534.BAFI97bJtD--
