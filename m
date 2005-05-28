Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVE1Fez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVE1Fez (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 01:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVE1Fez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 01:34:55 -0400
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:26060 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261939AbVE1Fec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 01:34:32 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] SCHED: smp nice bias busy queues on idle rebalance
Date: Sat, 28 May 2005 15:34:47 +1000
User-Agent: KMail/1.8
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2021741.cz7dUxsXy2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505281534.50651.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2021741.cz7dUxsXy2
Content-Type: multipart/mixed;
  boundary="Boundary-01=_4LAmCjPQ4eR8wai"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_4LAmCjPQ4eR8wai
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

SMP nice support tweaks.

Con
---


--Boundary-01=_4LAmCjPQ4eR8wai
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sched-smp_nice_bias_busy_queues_on_idle_rebalance.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="sched-smp_nice_bias_busy_queues_on_idle_rebalance.diff"

To intensify the 'nice' support across physical cpus on SMP we can bias the
loads on idle rebalancing. To prevent idle rebalance from trying to pull ta=
sks
from queues that appear heavily loaded we only bias the load if there is mo=
re
than one task running.=20

Add some minor micro-optimisations and have only one return from __source_l=
oad
and __target_load functions.

=46ix the fact that target_load was not biased by priority when type=3D=3D0.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.12-rc5-mm1/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.12-rc5-mm1.orig/kernel/sched.c	2005-05-28 15:08:08.00000000=
0 +1000
+++ linux-2.6.12-rc5-mm1/kernel/sched.c	2005-05-28 15:20:12.000000000 +1000
@@ -970,22 +970,26 @@ void kick_process(task_t *p)
 static inline unsigned long __source_load(int cpu, int type, enum idle_typ=
e idle)
 {
 	runqueue_t *rq =3D cpu_rq(cpu);
=2D	unsigned long cpu_load =3D rq->cpu_load[type-1],
+	unsigned long source_load, cpu_load =3D rq->cpu_load[type-1],
 		load_now =3D rq->nr_running * SCHED_LOAD_SCALE;
=20
=2D	if (idle =3D=3D NOT_IDLE) {
+	if (type =3D=3D 0)
+		source_load =3D load_now;
+	else
+		source_load =3D min(cpu_load, load_now);
+
+	if (idle =3D=3D NOT_IDLE || rq->nr_running > 1)
 		/*
=2D		 * If we are balancing busy runqueues the load is biased by
=2D		 * priority to create 'nice' support across cpus.
+		 * If we are busy rebalancing the load is biased by
+		 * priority to create 'nice' support across cpus. When
+		 * idle rebalancing we should only bias the source_load if
+		 * there is more than one task running on that queue to
+		 * prevent idle rebalance from trying to pull tasks from a
+		 * queue with only one running task.
 		 */
=2D		cpu_load *=3D rq->prio_bias;
=2D		load_now *=3D rq->prio_bias;
=2D	}
+		source_load *=3D rq->prio_bias;
=20
=2D	if (type =3D=3D 0)
=2D		return load_now;
=2D
=2D	return min(cpu_load, load_now);
+	return source_load;
 }
=20
 static inline unsigned long source_load(int cpu, int type)
@@ -999,17 +1003,18 @@ static inline unsigned long source_load(
 static inline unsigned long __target_load(int cpu, int type, enum idle_typ=
e idle)
 {
 	runqueue_t *rq =3D cpu_rq(cpu);
=2D	unsigned long cpu_load =3D rq->cpu_load[type-1],
+	unsigned long target_load, cpu_load =3D rq->cpu_load[type-1],
 		load_now =3D rq->nr_running * SCHED_LOAD_SCALE;
=20
 	if (type =3D=3D 0)
=2D		return load_now;
+		target_load =3D load_now;
+	else
+		target_load =3D max(cpu_load, load_now);
=20
=2D	if (idle =3D=3D NOT_IDLE) {
=2D		cpu_load *=3D rq->prio_bias;
=2D		load_now *=3D rq->prio_bias;
=2D	}
=2D	return max(cpu_load, load_now);
+	if (idle =3D=3D NOT_IDLE || rq->nr_running > 1)
+		target_load *=3D rq->prio_bias;
+
+	return target_load;
 }
=20
 static inline unsigned long target_load(int cpu, int type)

--Boundary-01=_4LAmCjPQ4eR8wai--

--nextPart2021741.cz7dUxsXy2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCmAL6ZUg7+tp6mRURAqCiAJ91BPvj2e5k1m1d3IAO8hdGUU9fcACfYiOS
QOmFM1+DRfeYIpgqebpreiY=
=VNRF
-----END PGP SIGNATURE-----

--nextPart2021741.cz7dUxsXy2--
