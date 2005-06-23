Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVFWAET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVFWAET (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVFWAET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:04:19 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:21642 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261838AbVFWADs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:03:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] fix SMT scheduler latency bug
Date: Thu, 23 Jun 2005 10:03:28 +1000
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       William Weston <weston@sysex.net>
References: <20050622102541.GA10043@elte.hu> <200506230903.56351.kernel@kolivas.org> <20050622233254.GA11486@elte.hu>
In-Reply-To: <20050622233254.GA11486@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2513205.T9SgmNIfP2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506231003.31084.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2513205.T9SgmNIfP2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 23 Jun 2005 09:32, Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> > > task_timeslice(p) is indeed constant over time, but
> > > smt_curr->time_slice is not. So this condition opens up the possibili=
ty
> > > of a lower prio thread accumulating a larger ->time_slice and thus
> > > reversing the priority equation.
> >
> > I'm not clear on how the value of ->time_slice can ever grow to larger
> > than task_timeslice(p). It starts at task_timeslice(p) and decrements
> > till it gets to 0 when it refills again.
>
> I was thinking abut sched_exit(), there we let unused child timeslices
> 'flow back' into the parent thread, if the child thread was shortlived.
> The check there does:
>
>         if (p->first_time_slice) {
>                 p->parent->time_slice +=3D p->time_slice;
>                 if (unlikely(p->parent->time_slice > task_timeslice(p)))
>                         p->parent->time_slice =3D task_timeslice(p);
>         }
>
> notice that we check parent->time_slice against the child's
> task_timeslice(p), not against task_timeslice(p->parent). So if the
> child thread got reniced, it could cause a higher-than-normal amount of
> timeslices. But this should be a rare scenario, and the above code is
> more of a bug than a feature (will send a patch for it tomorrow), and it
> should not affect the workloads i was testing.

Agreed.

> lets take a look at the second condition again:
>
>                 if ((p->time_slice * (100 - sd->per_cpu_gain) / 100) >
>                         task_timeslice(smt_curr))
>                                 resched_task(smt_curr);
>
> if this condition is true then we trigger a preemption at smt_curr. Now
> in the bug scenario, 'p' is a highprio task and smt_curr is a lowprio
> task. If p->time_slice (which fluctuates between task_timeslice(p) and
> 0) happens to be low enough, preemption wont be triggered and we lose a
> wakeup in essence - 'p', despite being the highest-prio task around,
> wont be run until some CPU runs schedule() voluntarily. Ok?

In dependent_sleeper() we return 1 only to prevent p from scheduling. This=
=20
second condition does not return 1 from dependent_sleeper() so p will still=
=20
go ahead and schedule. This second condition only affects the scheduling on=
=20
the smt sibling.

About the only scenario I can envision a high priority task being delayed w=
ith=20
the code as it currently is in 2.6.12-mm1 is with a high priority task bein=
g=20
on the expired array and a low priority task being delayed on the active=20
array. This still should not create large latencies unless array swapping i=
s=20
significantly delayed. I considered adding a check for this originally but =
it=20
seemed to be unnecessary extra complexity since an expired task by design i=
s=20
expected to be delayed more anyway.

Cheers,
Con


Cheers,
Con

--nextPart2513205.T9SgmNIfP2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCufxTZUg7+tp6mRURAsV4AJsFvTqJDfNnuukAQr8WQfQJjKT6CACghHHG
9yHJ0EGn8TMgJV4L/pvPNIA=
=a9VI
-----END PGP SIGNATURE-----

--nextPart2513205.T9SgmNIfP2--
