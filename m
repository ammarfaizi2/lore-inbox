Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUCPOrI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbUCPOqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:46:35 -0500
Received: from ns.suse.de ([195.135.220.2]:21995 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262011AbUCPOaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:30:06 -0500
Date: Tue, 16 Mar 2004 15:29:57 +0100
From: Kurt Garloff <garloff@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: dynamic sched timeslices
Message-ID: <20040316142957.GX4452@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
	hch@infradead.org, Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040315224201.GX4452@tpkurt.garloff.de> <20040315154042.40c58c5b.akpm@osdl.org> <20040316113615.GK4452@tpkurt.garloff.de> <200403170013.38140.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4rh8KwHgidtw24lr"
Content-Disposition: inline
In-Reply-To: <200403170013.38140.kernel@kolivas.org>
X-Operating-System: Linux 2.6.4-1-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4rh8KwHgidtw24lr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Con,

On Wed, Mar 17, 2004 at 12:13:37AM +1100, Con Kolivas wrote:
> 2.4 O(1) effects do not directly apply with 2.6
>=20
> Dropping Hz will save you performance for sure on 2.6.
>=20
> Changing the timeslices in 2.6 will be disappointing, though. Although th=
e=20
> apparent timeslice of nice 0 tasks is 102ms, interactive tasks round robi=
n at=20
> 10ms. If you drop the timeslice to 10ms you will not improve the interact=
ive=20
> feel but you will speed up expiration instead which will almost certainly=
=20
> worsen interactive feel.=20

If you have a system with an easy workload (say one clear CPU hog and
one interactive job), things are easy. The fact that you preempt the
not-yet expired CPU hog is enough.
That's easy, and that worked with 2.4 O(1) (if tweaked a bit to estimate
interactiveness better, see other patch) and it works with 2.6.

Things start to get difficult if you have something like a calculation
program with a non-multithreaded GUI. It will look like a CPU hog and
still you'd like to see it responsive. Now add a second CPU hog.

The kernel can not fix this problem, but it can limit the damage by=20
not having too long timeslices.

There are other scenarios where the preemption will not solve all
problems.
Think two interactive processes, one playing audio, another one being
your shell. The audio player may take the CPU for extended periods of
times occasionally to decode the next N ogg frames. You still want the
shell to react promptly, but it can't ... Thus you wish the timeslice
not being too long.

Thus you'll set them not too long for desktop kind of machines to
not have to rely completely on the interactiveness estimator.

> If you drop timeslices below 10ms you will get=20
> significant cache trashing and drop in performance (which your 2.4 result=
s=20
> confirm).

No doubt. Don't overdo it. It's a tradeoff. If you impact throughput too
much, you'll not enjoy the short latency ;-)

> Increasing timeslices does benefit pure number crunching workloads. The=
=20
> benchmarking I've done using cache intensive workloads (which are the mos=
t=20
> likely to benefit) show you are chasing diminishing returns, though. You =
can=20
> mathematically model them based on the fact that keeping a task bound to =
a=20
> cpu instead of shifting it to another cpu on SMP saves about 2ms processi=
ng=20
> time on P4. Suffice to say the benefit is only worth it if you do nothing=
 but=20
> cpu intensive things, and becomes virtually insignificant beyond 200ms. O=
n=20
> other architecture with longer cache decays you will benefit more;=20
> arch/i386/mach-voyager seems the longest at 20ms.

That's why I think we should offer the tunables.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>             [Koeln, DE]
Physics:Plasma modeling <garloff@plasimo.phys.tue.nl> [TU Eindhoven, NL]
Linux: SUSE Labs (Head)        <garloff@suse.de>    [SUSE Nuernberg, DE]

--4rh8KwHgidtw24lr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAVw9lxmLh6hyYd04RAg58AJ9VB18C51hlyjQEizoy5iHBRS0K1gCfV9kM
xFHIBfiMBMN8PWzMNAwCYNE=
=/R7v
-----END PGP SIGNATURE-----

--4rh8KwHgidtw24lr--
