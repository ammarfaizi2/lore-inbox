Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVFAOrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVFAOrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVFAOrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:47:12 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:2720 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261397AbVFAOq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:46:56 -0400
From: Con Kolivas <kernel@kolivas.org>
To: steve.rotolo@ccur.com
Subject: Re: SD_SHARE_CPUPOWER breaks scheduler fairness
Date: Thu, 2 Jun 2005 00:47:14 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, bugsy@ccur.com
References: <1117561608.1439.168.camel@whiz> <200506011249.47655.kernel@kolivas.org> <1117636171.22879.29.camel@bonefish>
In-Reply-To: <1117636171.22879.29.camel@bonefish>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3669222.aoazkmzZEY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506020047.16752.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3669222.aoazkmzZEY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 2 Jun 2005 00:29, Steve Rotolo wrote:
> On Tue, 2005-05-31 at 22:49, Con Kolivas wrote:
> > Sort of yes and yes. The idea that the sibling gets put to sleep if a
> > real time task is running is a workaround for the fact that you do share
> > cpu power (as you've correctly understood) and a real time task will sl=
ow
> > down if a SCHED_NORMAL task is running on its sibling which it should
> > not.  The limitation is that, yes, for all intents you only have N
> > hyperthreaded cpus for spinning N rt tasks before nothing else runs, but
> > you can actually run N*2 rt tasks in this setting which you would not be
> > able to if hyperthreading was disabled.
> >
> > For some time I've been thinking about changing the balance between the
> > siblings slightly to allow SCHED_NORMAL tasks to run a small proportion
> > of time when rt tasks are running on the sibling. The tricky part is th=
at
> > SCHED_FIFO tasks have no timeslice so we can't proportion cpu out
> > according to the difference in size of the timeslices, which is current=
ly
> > how we proportion out cpu across siblings with SCHED_NORMAL, and this
> > maintains cpu distribution very similarly to how 'nice' does on the same
> > cpu.
>
> Thanks for responding, Con.  But I want to make sure that an important
> point doesn't escape your attention.  It appears that tasks get trapped
> on the stalled sibling, even when they could run on some other cpu.  The
> load-balancer does not understand that the sibling is temporarily out of
> service so it actually balances tasks to it.  And since it's idle, it
> may attract tasks to it more than other cpus (thanks to SD_WAKE_IDLE).
> I think this is a serious bug.

I didn't miss the point, but I guess I should have made that clear too.

The number of tasks seen running on that sibling is still the same even if =
the=20
queue is forced to be idle (witness by top thinking the load is 1 on that=20
sibling even if it also shows quite a lot of idle time). It should therefor=
e=20
not attract any more tasks to itself.=20

The task that is there will be trapped based on the fact that there is only=
=20
one task _only_ if the other sibling is indefinitely running real time task=
s,=20
and _if_ there are other physical cpus we can use we should try to schedule=
=20
the trapped task away. If we have N physical cpus (and N*2 logical), and we=
=20
are running N real time threads I don't think we should expect to run=20
SCHED_NORMAL tasks as well. If we have <N real time tasks (where N > 1) the=
n=20
we should still be able to run SCHED_NORMAL tasks, I agree. I'm a little=20
reluctant to tackle this at this stage with the number of SMP balancing=20
things already queued for -mm, but making a sibling appear more heavily lad=
en=20
when "pegged" (nr_running + 1) should suffice.

Cheers,
Con

--nextPart3669222.aoazkmzZEY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCncp0ZUg7+tp6mRURAvCjAJ47JZcaYREDLVDJLChBZlRPHk2F4ACcD0m4
RBz4a1B+P4VlVsmAS0qjPSU=
=P/CE
-----END PGP SIGNATURE-----

--nextPart3669222.aoazkmzZEY--
