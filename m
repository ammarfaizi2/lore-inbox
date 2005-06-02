Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVFBOLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVFBOLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 10:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVFBOLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 10:11:00 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:17306 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261298AbVFBOKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 10:10:45 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Steve Rotolo <steve.rotolo@ccur.com>
Subject: Re: SD_SHARE_CPUPOWER breaks scheduler fairness
Date: Thu, 2 Jun 2005 23:34:29 +1000
User-Agent: KMail/1.8.1
Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org, bugsy@ccur.com
References: <1117561608.1439.168.camel@whiz> <200506020925.26320.kernel@kolivas.org> <1117719021.1436.56.camel@whiz>
In-Reply-To: <1117719021.1436.56.camel@whiz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9642273.fUpBtDNae9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506022334.31430.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9642273.fUpBtDNae9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 2 Jun 2005 23:30, Steve Rotolo wrote:
> > > Wild thought: how about doing this for the sibling ...
> > >
> > > 	rp->nr_running +=3D SOME_BIG_NUMBER
> > >
> > > when a SCHED_FIFO task starts running on some cpu, and
> > > undo the above when the cpu is released.   This fools
> > > the load balancer into _gradually_ moving tasks off the
> > > sibling, when the cpu is hogged by some SCHED_FIFO task,
> > > but should have little effect if a SCHED_FIFO task takes
> > > little cpu time.
> >
> > A good thought, and one I had considered. SOME_BIG_NUMBER needs to be
> > meaninful for this to work. Ideally what we do is add the effective load
> > from the sibling cpu to the pegged cpu. However that's not as useful as
> > it sounds because we need to ensure both sibling runqueues are locked
> > every time we check the load value of one runqueue, and the last thing I
> > want is to introduce yet more locking. Also the value will vary wildly
> > depending on whether the task is pegged or not, and this changes in
> > mainline many times in less than .1s which means it would throw load
> > balancing way off as the value will effectively become meaningless.
>
> Just a few more thoughts on this....
>
> I can't help but wonder if a similar problem exists even without HT.
> What if the load-balancer decides to keep a sched_normal task on a cpu
> that is being dominated by a sched_fifo task.  The sched_normal task
> should really be "balanced" to a different cpu but because nr_running is
> the only balancing criteria that may not happen.  Runqueue business
> ought to be weighted by the amount of time that sched_fifo tasks on that
> runqueue have recently used.  So, load =3D rq->nr_running +
> rq->recent_fifo_run_time.  I think this would make load-balancing more
> correct.

=46unny you should mention this. Check the latest -mm code and you'll see A=
ndrew=20
has merged my smp nice code which takes into account "nice" values and alte=
rs=20
balancing according to nice values and heavily biases them when real time=20
tasks are running. So you are correct, and it is a problem common to any=20
per-cpu runqueue designed scheduler (which interestingly there is evidence=
=20
that windows went to in about 2003 because it exhibited this very problem).=
=20
However my code should make this behave better now.

Cheers,
Con

--nextPart9642273.fUpBtDNae9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCnwrnZUg7+tp6mRURAgZaAJ9qa9GXwAklKx0DiWhy1aeoPs/figCfTIbk
1wlZPv3EOJeRkKnojTopVDQ=
=DI/k
-----END PGP SIGNATURE-----

--nextPart9642273.fUpBtDNae9--
