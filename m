Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVFVOnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVFVOnw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVFVOnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:43:50 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:16011 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261497AbVFVOlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:41:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] fix SMT scheduler latency bug
Date: Thu, 23 Jun 2005 00:40:55 +1000
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       William Weston <weston@sysex.net>
References: <20050622102541.GA10043@elte.hu>
In-Reply-To: <20050622102541.GA10043@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1664757.Vt8IERZCmk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506230040.58846.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1664757.Vt8IERZCmk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

On Wed, 22 Jun 2005 20:25, Ingo Molnar wrote:
> William Weston reported unusually high scheduling latencies on his x86
> HT box, on the -RT kernel. I managed to reproduce it on my HT box and
> the latency tracer shows the incident in action:

Thanks for picking this up. I've had a long hard look at the code and your=
=20
patch.

> the reason for this anomaly is the following code in dependent_sleeper():
>
>                 /*
>                  * If a user task with lower static priority than the
>                  * running task on the SMT sibling is trying to schedule,
>                  * delay it till there is proportionately less timeslice
>                  * left of the sibling task to prevent a lower priority
>                  * task from using an unfair proportion of the
>                  * physical cpu's resources. -ck
>                  */
> [...]
>                         if (((smt_curr->time_slice * (100 -
> sd->per_cpu_gain) / 100) > task_timeslice(p)))
>                                         ret =3D 1;
>
> note that in contrast to the comment above, we dont actually do the
> check based on static priority, we do the check based on timeslices. But
> timeslices go up and down, and even highprio tasks can randomly have
> very low timeslices (just before their next refill) and can thus be
> judged as 'lowprio' by the above piece of code.=20

I don't see it like that. task_timeslice(p) will always return the same val=
ue=20
based purely on static priority and smt_curr->time_slice cannot ever be=20
larger than task_timeslice(p) unless there is a significant enough 'nice'=20
difference. It is not smt_curr that is rescheduled as a result of this test=
,=20
it is p that is not scheduled and we look at p's task_timeslice which does=
=20
not alter. The task that is delayed in either case is dependant on its stat=
ic=20
priority which will determine its task_timeslice() vs the current value of=
=20
=2D>time_slice on the sibling which is emptied as that task runs, and it is=
=20
expected to fluctuate.

> This condition is=20
> clearly buggy. The correct test is to check for static_prio _and_ to
> check for the preemption priority. Even on different static priority
> levels, a higher-prio interactive task should not be delayed due to a
> higher-static-prio CPU hog.

> -			if (((smt_curr->time_slice * (100 - sd->per_cpu_gain) /
> -				100) > task_timeslice(p)))
> +			if (smt_curr->static_prio < p->static_prio &&
> +				!TASK_PREEMPTS_CURR(p, smt_rq) &&
> +				smt_slice(smt_curr, sd) > task_timeslice(p))

Checking for smt_curr->static_prio < p->static_prio appears redundant to me=
=20
because the condition can only be met if there is a significant difference =
in=20
the different timeslice case as I mentioned above.

> +			if (TASK_PREEMPTS_CURR(p, smt_rq) &&

Is this check necessary? The proportion is supposed to be distributed=20
according to static priority only.

If this code is causing large latencies then I believe it can only occur wi=
th=20
different nice levels running on siblings and high priority tasks starting=
=20
new timeslices repeatedly and never getting to the last per_cpu_gain% of=20
their timeslice. Ingo do you think this might be what is being seen? If thi=
s=20
truly can happen then this code will have to move to a jiffy based proporti=
on=20
as the real time code is to prevent this problem.=20

Cheers,
Con

--nextPart1664757.Vt8IERZCmk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCuXh6ZUg7+tp6mRURAg4+AJ4ytXCcw23RnSk9p99YPsOO5WqQqACfZjhh
31iwOikh8pjt45hUoNsJo3M=
=8mxl
-----END PGP SIGNATURE-----

--nextPart1664757.Vt8IERZCmk--
