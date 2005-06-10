Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbVFJOUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbVFJOUQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 10:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVFJOUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 10:20:16 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:57578 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262550AbVFJOTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 10:19:52 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
Date: Sat, 11 Jun 2005 00:19:10 +1000
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
References: <20050607170853.3f81007a.akpm@osdl.org> <20050610070214.GA31323@elte.hu> <200506102203.15909.kernel@kolivas.org>
In-Reply-To: <200506102203.15909.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2076837.1ro9eiF1GH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506110019.13204.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2076837.1ro9eiF1GH
Content-Type: multipart/mixed;
  boundary="Boundary-01=_fFaqCAaj3soaRO7"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_fFaqCAaj3soaRO7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 10 Jun 2005 22:03, Con Kolivas wrote:
> On Fri, 10 Jun 2005 17:02, Ingo Molnar wrote:
> > * Martin J. Bligh <mbligh@mbligh.org> wrote:
> > > > I'm assuming it was the CPU scheduler patches.  There are 36 of them
> > > > ;)

> > So the=20
> > candidates for the regression are:
> >
> >  sched-implement-nice-support-across-physical-cpus-on-smp.patch
> >  sched-change_prio_bias_only_if_queued.patch
> >  sched-account_rt_tasks_in_prio_bias.patch
> >  consolidate-preempt-options-into-kernel-kconfigpreempt.patch
> >  enable-preempt_bkl-on-preemptsmp-too.patch
> >  sched-tweak-idle-thread-setup-semantics.patch
> >  sched-voluntary-kernel-preemption.patch
> >  sched-smp-nice-bias-busy-queues-on-idle-rebalance.patch
> >  sched-task_noninteractive.patch
> >  sched-run-sched_normal-tasks-with-real-time-tasks-on-smt-siblings.patch

> These tend to run together so just try adding my four patches together. In
> retrospect I guess they're likely candidates because they also change the
> _ratio_ of balance which they should not so they are buggy as a group
> currently. Easy enough to fix but it will make it easy to pinpoint the
> problem if they're responsible.
>
> sched-implement-nice-support-across-physical-cpus-on-smp.patch
> sched-change_prio_bias_only_if_queued.patch
> sched-account_rt_tasks_in_prio_bias.patch
> sched-smp-nice-bias-busy-queues-on-idle-rebalance.patch

By the way it has already been decided to remove these patches from -mm=20
pending the completion of current scheduler work. If they turn out to be=20
responsible for this regression I apologise profusely :-|.=20

It is clearer to me now that I have made a mistake with the priority biasin=
g,=20
and the following patch corrects it to the planned behaviour. This is=20
academic at this stage as we won't be looking at this particular feature=20
again in earnest until the other 32 scheduler patches (and any followups) g=
o=20
upstream.=20

It's already known that schedstats data will be off without further code to=
=20
understand smp nice as well (thanks Nick for pointing out the data)... more=
=20
academic stuff but obviously something to consider when/if we get there.

Cheers,
Con

--Boundary-01=_fFaqCAaj3soaRO7
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="sched-correct_smp_nice_bias.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="sched-correct_smp_nice_bias.patch"

The priority biasing was off by mutliplying the total load by the total=20
priority bias and this ruins the ratio of loads between runqueues. This
patch should correct the ratios of loads between runqueues to be proportion=
al
to overall load.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.12-rc6-mm1/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.12-rc6-mm1.orig/kernel/sched.c	2005-06-10 23:56:56.00000000=
0 +1000
+++ linux-2.6.12-rc6-mm1/kernel/sched.c	2005-06-10 23:59:57.000000000 +1000
@@ -978,7 +978,7 @@ static inline unsigned long __source_loa
 	else
 		source_load =3D min(cpu_load, load_now);
=20
=2D	if (idle =3D=3D NOT_IDLE || rq->nr_running > 1)
+	if (idle =3D=3D NOT_IDLE || rq->nr_running > 1) {
 		/*
 		 * If we are busy rebalancing the load is biased by
 		 * priority to create 'nice' support across cpus. When
@@ -987,7 +987,10 @@ static inline unsigned long __source_loa
 		 * prevent idle rebalance from trying to pull tasks from a
 		 * queue with only one running task.
 		 */
=2D		source_load *=3D rq->prio_bias;
+		unsigned long prio_bias =3D rq->prio_bias / rq->nr_running;
+
+		source_load *=3D prio_bias;
+	}
=20
 	return source_load;
 }
@@ -1011,8 +1014,11 @@ static inline unsigned long __target_loa
 	else
 		target_load =3D max(cpu_load, load_now);
=20
=2D	if (idle =3D=3D NOT_IDLE || rq->nr_running > 1)
=2D		target_load *=3D rq->prio_bias;
+	if (idle =3D=3D NOT_IDLE || rq->nr_running > 1) {
+		unsigned long prio_bias =3D rq->prio_bias / rq->nr_running;
+
+		target_load *=3D prio_bias;
+	}
=20
 	return target_load;
 }

--Boundary-01=_fFaqCAaj3soaRO7--

--nextPart2076837.1ro9eiF1GH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCqaFhZUg7+tp6mRURAiffAJ9EEqfKWLqCyP4m3KWlrRJGF0AkPgCgjdKt
wv70+cASTYtiRfYLjOkBnXY=
=N/pE
-----END PGP SIGNATURE-----

--nextPart2076837.1ro9eiF1GH--
