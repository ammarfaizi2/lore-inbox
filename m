Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUCFDwX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 22:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUCFDwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 22:52:22 -0500
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:16811 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261580AbUCFDwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 22:52:19 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] smt-nice-opt 2.6.4-rc1-mm2
Date: Sat, 6 Mar 2004 14:51:58 +1100
User-Agent: KMail/1.6
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_erUSAzvuwnyTl4k"
Message-Id: <200403061452.03118.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_erUSAzvuwnyTl4k
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch optimises the smt-nice branch points

The first hunk removes one unnecessary if() and rearranges the order from=20
least to most likely.

The second hunk improves the "reschedule sibling task" logic substantially =
by=20
only rescheduling it if it is supposed to be put to sleep as well. This=20
causes far less context switching of low priority tasks.


Consequently the benchmark results are substantial:

up is uniprocessor
mm1 is before the smt nice patch
sn is with smt nice patch
opt is with this optimise patch

Time is in seconds

Concurrent kernel compiles, one make, the other nice +19 make
		Nice0	Nice19
up		183	235
mm1		208	211
sn		180	237
opt		178	222

As can be seen the original patch simply changed the performance to that of=
=20
running in uniprocessor when there was a nice difference. With this patch t=
he=20
overall throughput is improved compared to up as is desired by smt=20
processing.

Con
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFASUreZUg7+tp6mRURArj2AJ43WSCKOoKTjgXThNmizm1u2+bbGgCfXSWQ
25D55s+73IVd1/ap0QmayZk=3D
=3D5rc/
=2D----END PGP SIGNATURE-----

--Boundary-00=_erUSAzvuwnyTl4k
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sched-smt-nice-opt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="sched-smt-nice-opt.patch"

--- linux-2.6.4-rc1-mm2/kernel/sched.c	2004-03-06 02:17:25.000000000 +1100
+++ linux-2.6.4-rc1-mm2-so/kernel/sched.c	2004-03-06 14:28:10.094227754 +1100
@@ -2002,11 +2002,9 @@ static inline int dependent_sleeper(runq
 		 * task from using an unfair proportion of the
 		 * physical cpu's resources. -ck
 		 */
-		if (p->mm && smt_curr->mm && !rt_task(p) &&
-			((p->static_prio > smt_curr->static_prio &&
-			(smt_curr->time_slice * (100 - sd->per_cpu_gain) /
-			100) > task_timeslice(p)) ||
-			rt_task(smt_curr)))
+		if (((smt_curr->time_slice * (100 - sd->per_cpu_gain) / 100) >
+			task_timeslice(p) || rt_task(smt_curr)) &&
+			p->mm && smt_curr->mm && !rt_task(p))
 				ret |= 1;
 
 		/*
@@ -2014,9 +2012,9 @@ static inline int dependent_sleeper(runq
 		 * or wake it up if it has been put to sleep for priority
 		 * reasons.
 		 */
-		if ((smt_curr != smt_rq->idle &&
-			smt_curr->static_prio > p->static_prio) ||
-			(rt_task(p) && !rt_task(smt_curr)) ||
+		if ((((p->time_slice * (100 - sd->per_cpu_gain) / 100) > 
+			task_timeslice(smt_curr) || rt_task(p)) && 
+			smt_curr->mm && p->mm && !rt_task(smt_curr)) ||
 			(smt_curr == smt_rq->idle && smt_rq->nr_running))
 				resched_task(smt_curr);
 	}

--Boundary-00=_erUSAzvuwnyTl4k--
