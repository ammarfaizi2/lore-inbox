Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVFVXMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVFVXMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVFVXIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 19:08:34 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:20936 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262572AbVFVXEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 19:04:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] fix SMT scheduler latency bug
Date: Thu, 23 Jun 2005 09:03:53 +1000
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       William Weston <weston@sysex.net>
References: <20050622102541.GA10043@elte.hu> <200506230040.58846.kernel@kolivas.org> <20050622160458.GA28020@elte.hu>
In-Reply-To: <20050622160458.GA28020@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1207353.pv0Nb4BruO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506230903.56351.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1207353.pv0Nb4BruO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 23 Jun 2005 02:04, Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> > > [...]
> > >                         if (((smt_curr->time_slice * (100 -
> > > sd->per_cpu_gain) / 100) > task_timeslice(p)))
> > >                                         ret =3D 1;
> > >
> > > note that in contrast to the comment above, we dont actually do the
> > > check based on static priority, we do the check based on timeslices.
> > > But timeslices go up and down, and even highprio tasks can randomly
> > > have very low timeslices (just before their next refill) and can thus
> > > be judged as 'lowprio' by the above piece of code.
> >
> > I don't see it like that. task_timeslice(p) will always return the
> > same value based purely on static priority and smt_curr->time_slice
> > cannot ever be larger than task_timeslice(p) unless there is a
> > significant enough 'nice' difference. [...]
>
> task_timeslice(p) is indeed constant over time, but smt_curr->time_slice
> is not. So this condition opens up the possibility of a lower prio
> thread accumulating a larger ->time_slice and thus reversing the
> priority equation.

I'm not clear on how the value of ->time_slice can ever grow to larger than=
=20
task_timeslice(p). It starts at task_timeslice(p) and decrements till it ge=
ts=20
to 0 when it refills again.=20

I only recall three times that the value of p->time_slice is increased:
New timeslice where it is refilled with task_timeslice(p)
At fork() where if it has one tick left it is increased back to one tick
Reaping a child where it collects its child's time_slice up to a maximum of=
=20
task_timeslice(p).

I must be missing something but I can't see how p->time_slice can ever be=20
larger than task_timeslice(p).

Please correct me :|

Cheers,
Con

--nextPart1207353.pv0Nb4BruO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCue5cZUg7+tp6mRURAtArAJ9mpx4sWSyi4HqKSKmFIaPB1jV7QQCeMeee
y9Xk2D38Z/BSfbtKRLYHshg=
=5qhV
-----END PGP SIGNATURE-----

--nextPart1207353.pv0Nb4BruO--
