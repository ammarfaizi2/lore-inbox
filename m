Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVFCAtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVFCAtV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 20:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVFCAtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 20:49:20 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:51843 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261464AbVFCAtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 20:49:01 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] SCHED: run SCHED_NORMAL tasks with real time tasks on SMT siblings
Date: Fri, 3 Jun 2005 10:43:13 +1000
User-Agent: KMail/1.8.1
Cc: Steve Rotolo <steve.rotolo@ccur.com>, joe.korty@ccur.com,
       linux-kernel@vger.kernel.org, bugsy@ccur.com,
       Ingo Molnar <mingo@elte.hu>, ck@vds.kolivas.org,
       Peter Williams <pwil3058@bigpond.net.au>
References: <1117561608.1439.168.camel@whiz> <200506022334.31430.kernel@kolivas.org> <1117727326.1436.73.camel@whiz>
In-Reply-To: <1117727326.1436.73.camel@whiz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2850934.6p72KmRQLn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506031043.16502.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2850934.6p72KmRQLn
Content-Type: multipart/mixed;
  boundary="Boundary-01=_ie6nCKWuYivLTT/"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_ie6nCKWuYivLTT/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 3 Jun 2005 01:48, Steve Rotolo wrote:
> And BTW, your patch works great with my=20
> HT test case.  Thanks -- good job.

Thanks. Cleaned up the patch comments a little.=20

Andrew can you queue this up in -mm please? This patch does not depend on a=
ny=20
other patches in -mm and should have only a short test cycle before being=20
pushed into mainline.

Con
=2D---



--Boundary-01=_ie6nCKWuYivLTT/
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="sched-run_normal_with_rt_on_sibling.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="sched-run_normal_with_rt_on_sibling.diff"

The hyperthread aware nice handling currently puts to sleep any non real ti=
me
task when a real time task is running on its sibling cpu. This can lead to
prolonged starvation by having the non real time task pegged to the cpu with
load balancing not pulling that task away.

Currently we force lower priority hyperthread tasks to run a percentage of
time difference based on timeslice differences which is meaningless when
comparing real time tasks to SCHED_NORMAL tasks. We can allow non real time=
=20
tasks to run with real time tasks on the sibling up to per_cpu_gain% if we =
use
jiffies as a counter.

Cleanups and micro-optimisations to the relevant code section should make it
more understandable as well.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.12-rc5-mm2/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.12-rc5-mm2.orig/kernel/sched.c	2005-06-03 10:10:37.00000000=
0 +1000
+++ linux-2.6.12-rc5-mm2/kernel/sched.c	2005-06-03 10:25:19.000000000 +1000
@@ -2656,6 +2656,13 @@ out:
 }
=20
 #ifdef CONFIG_SCHED_SMT
+static inline void wakeup_busy_runqueue(runqueue_t *rq)
+{
+	/* If an SMT runqueue is sleeping due to priority reasons wake it up */
+	if (rq->curr =3D=3D rq->idle && rq->nr_running)
+		resched_task(rq->idle);
+}
+
 static inline void wake_sleeping_dependent(int this_cpu, runqueue_t *this_=
rq)
 {
 	struct sched_domain *tmp, *sd =3D NULL;
@@ -2689,12 +2696,7 @@ static inline void wake_sleeping_depende
 	for_each_cpu_mask(i, sibling_map) {
 		runqueue_t *smt_rq =3D cpu_rq(i);
=20
=2D		/*
=2D		 * If an SMT sibling task is sleeping due to priority
=2D		 * reasons wake it up now.
=2D		 */
=2D		if (smt_rq->curr =3D=3D smt_rq->idle && smt_rq->nr_running)
=2D			resched_task(smt_rq->idle);
+		wakeup_busy_runqueue(smt_rq);
 	}
=20
 	for_each_cpu_mask(i, sibling_map)
@@ -2748,6 +2750,10 @@ static inline int dependent_sleeper(int=20
 		runqueue_t *smt_rq =3D cpu_rq(i);
 		task_t *smt_curr =3D smt_rq->curr;
=20
+		/* Kernel threads do not participate in dependent sleeping */
+		if (!p->mm || !smt_curr->mm || rt_task(p))
+			goto check_smt_task;
+
 		/*
 		 * If a user task with lower static priority than the
 		 * running task on the SMT sibling is trying to schedule,
@@ -2756,21 +2762,44 @@ static inline int dependent_sleeper(int=20
 		 * task from using an unfair proportion of the
 		 * physical cpu's resources. -ck
 		 */
=2D		if (((smt_curr->time_slice * (100 - sd->per_cpu_gain) / 100) >
=2D			task_timeslice(p) || rt_task(smt_curr)) &&
=2D			p->mm && smt_curr->mm && !rt_task(p))
=2D				ret =3D 1;
+		if (rt_task(smt_curr)) {
+			/*
+			 * With real time tasks we run non-rt tasks only
+			 * per_cpu_gain% of the time.
+			 */
+			if ((jiffies % DEF_TIMESLICE) >
+				(sd->per_cpu_gain * DEF_TIMESLICE / 100))
+					ret =3D 1;
+		} else
+			if (((smt_curr->time_slice * (100 - sd->per_cpu_gain) /
+				100) > task_timeslice(p)))
+					ret =3D 1;
+
+check_smt_task:
+		if ((!smt_curr->mm && smt_curr !=3D smt_rq->idle) ||
+			rt_task(smt_curr))
+				continue;
+		if (!p->mm) {
+			wakeup_busy_runqueue(smt_rq);
+			continue;
+		}
=20
 		/*
=2D		 * Reschedule a lower priority task on the SMT sibling,
=2D		 * or wake it up if it has been put to sleep for priority
=2D		 * reasons.
+		 * Reschedule a lower priority task on the SMT sibling for
+		 * it to be put to sleep, or wake it up if it has been put to
+		 * sleep for priority reasons to see if it should run now.
 		 */
=2D		if ((((p->time_slice * (100 - sd->per_cpu_gain) / 100) >
=2D			task_timeslice(smt_curr) || rt_task(p)) &&
=2D			smt_curr->mm && p->mm && !rt_task(smt_curr)) ||
=2D			(smt_curr =3D=3D smt_rq->idle && smt_rq->nr_running))
=2D				resched_task(smt_curr);
+		if (rt_task(p)) {
+			if ((jiffies % DEF_TIMESLICE) >
+				(sd->per_cpu_gain * DEF_TIMESLICE / 100))
+					resched_task(smt_curr);
+		} else {
+			if ((p->time_slice * (100 - sd->per_cpu_gain) / 100) >
+				task_timeslice(smt_curr))
+					resched_task(smt_curr);
+			else
+				wakeup_busy_runqueue(smt_rq);
+		}
 	}
 out_unlock:
 	for_each_cpu_mask(i, sibling_map)

--Boundary-01=_ie6nCKWuYivLTT/--

--nextPart2850934.6p72KmRQLn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCn6ekZUg7+tp6mRURArClAJ42iNlA1JqSk7xqUxHrJC9yYab/9wCggF0d
wx9Fby1TsR5+5EIYo/Jj/Sw=
=Yiiy
-----END PGP SIGNATURE-----

--nextPart2850934.6p72KmRQLn--
