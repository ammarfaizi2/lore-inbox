Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVFKABB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVFKABB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 20:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVFKABA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 20:01:00 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:7099 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261476AbVFKAAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 20:00:19 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc6-mm1
Date: Sat, 11 Jun 2005 09:59:50 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
References: <20050607170853.3f81007a.akpm@osdl.org> <200506110019.13204.kernel@kolivas.org> <1118445260l.7785l.0l@werewolf.able.es>
In-Reply-To: <1118445260l.7785l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3328366.qT8rxlv15R";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506110959.53614.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3328366.qT8rxlv15R
Content-Type: multipart/mixed;
  boundary="Boundary-01=_3liqC2QwhfY0J5e"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_3liqC2QwhfY0J5e
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, 11 Jun 2005 09:14, J.A. Magallon wrote:
> On 06.10, Con Kolivas wrote:
> > The priority biasing was off by mutliplying the total load by the total
> > priority bias and this ruins the ratio of loads between runqueues. This
> > patch should correct the ratios of loads between runqueues to be
> > proportional to overall load.
>
> 2.6.12-rc6-mm1 + this patch just oopses nicely on boot.
> I did not had a digital camera handy, but the first oops that fit in the
> screen was this call chain:
>
> kernel_thread_helper
> init
> init
> do:base_setup
> usermodehelper_init
> __create_workqueue
> EIP in try_to_wake_up
>
> After this, there was another with some do_div_error calls...
>
> Something looks un-initialized the first time, or the integer arithmetic
> is wrong. I really dont like a*(b/c), I really prefer (a*b)/c. It is more
> common b/c =3D=3D 0 (because b<c), than the possibility of overflowing (a=
*b).
>
> So I tried both. With this, it boots again:

Doh Doh DOH DOH!
I need a real swift kick up the bum. The point of the patch was to show wha=
t=20
was wrong with the math, and I shouldn't have posted it without actually=20
trying it.

> -		unsigned long prio_bias =3D rq->prio_bias / rq->nr_running;

rq->nr_running can often be 0 and rq->prio_bias by definition has to be lar=
ger=20
than or equal to rq->nr_running.

> Perhaps this:
>
> 	if (idle =3D=3D NOT_IDLE || rq->nr_running > 1)
>
> should be
>
> 	if (idle =3D=3D NOT_IDLE && rq->nr_running > 1)

No, testing for rq->nr_running > 1 is only needed if we are balancing in an=
=20
idle balance.

> Hope this helps, thanks.

Yes it does :\

Here is what the patch _should_ have been. (*same warnings with this patch=
=20
about math demonstration and untested as should have been posted with the=20
earlier one*)

Con

--Boundary-01=_3liqC2QwhfY0J5e
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
to overall load. -2nd attempt.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.12-rc6-mm1/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.12-rc6-mm1.orig/kernel/sched.c	2005-06-10 23:56:56.00000000=
0 +1000
+++ linux-2.6.12-rc6-mm1/kernel/sched.c	2005-06-11 09:55:56.000000000 +1000
@@ -978,7 +978,8 @@ static inline unsigned long __source_loa
 	else
 		source_load =3D min(cpu_load, load_now);
=20
=2D	if (idle =3D=3D NOT_IDLE || rq->nr_running > 1)
+	if (idle =3D=3D NOT_IDLE || rq->nr_running > 1) {
+		unsigned long prio_bias =3D 1;
 		/*
 		 * If we are busy rebalancing the load is biased by
 		 * priority to create 'nice' support across cpus. When
@@ -987,7 +988,10 @@ static inline unsigned long __source_loa
 		 * prevent idle rebalance from trying to pull tasks from a
 		 * queue with only one running task.
 		 */
=2D		source_load *=3D rq->prio_bias;
+		if (rq->nr_running)
+			prio_bias =3D rq->prio_bias / rq->nr_running;
+		source_load *=3D prio_bias;
+	}
=20
 	return source_load;
 }
@@ -1011,8 +1015,13 @@ static inline unsigned long __target_loa
 	else
 		target_load =3D max(cpu_load, load_now);
=20
=2D	if (idle =3D=3D NOT_IDLE || rq->nr_running > 1)
=2D		target_load *=3D rq->prio_bias;
+	if (idle =3D=3D NOT_IDLE || rq->nr_running > 1) {
+		unsigned long prio_bias =3D 1;
+
+		if (rq->nr_running)
+			prio_bias =3D rq->prio_bias / rq->nr_running;
+		target_load *=3D prio_bias;
+	}
=20
 	return target_load;
 }

--Boundary-01=_3liqC2QwhfY0J5e--

--nextPart3328366.qT8rxlv15R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCqil5ZUg7+tp6mRURAqyaAJ4/RBlrpDrcYG1fOkD6zIOGenIu/QCfZxiK
H/oWKk3+BEnzsqi994hEKNU=
=NZx5
-----END PGP SIGNATURE-----

--nextPart3328366.qT8rxlv15R--
