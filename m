Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbULMQn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbULMQn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbULMQn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:43:56 -0500
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.42]:41769 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261270AbULMQnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:43:51 -0500
Date: Mon, 13 Dec 2004 11:43:25 -0500
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: IO Priorities
In-reply-to: <20041213143809.GO3033@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, nickpiggin@yahoo.com.au
Message-id: <20041213164325.GA26031@optonline.net>
MIME-version: 1.0
Content-type: multipart/signed; boundary=Qxx1br4bt0+wmkIi;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040907i
References: <20041213142217.GA22853@optonline.net>
 <20041213143809.GO3033@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 13, 2004 at 03:38:10PM +0100, Jens Axboe wrote:
> On Mon, Dec 13 2004, Jeff Sipek wrote:
> > Hello all,
> > 	About a week ago, I said I would try to implement IO priorities.
> > I tried. I got the whole thing done, but there is one major problem - it
>=20
> I did too, did you see my patch?

I did after I sent mine. I was reading it and I noticed:

"Disable TCQ in the hardware/driver by default. Can be changed (as
always) with the max_depth setting. If you do that, don't expect
fairness or priorities to work as well."

Would this cause my problem?

> > doesn't work the way it is supposed to. For example, I wrote a little
> > shell script that calls:
> >=20
> > time dd if=3D/dev/zero of=3Ddump bs=3D4096 count=3D200000
> >=20
> > It calls it twice, once as the highest priority (0) and once as the
> > lowest priority (39). The only difference (besides the output file) is
> > the io priority. Nice values are _not_ connected with io prio (at least
> > not yet.) The only thing that the io_prio affects is the coefficient in
> > front of the cfq time slice length (see patch). The interesting thing
> > that happens is that sometimes the lower priority process finishes befo=
re
> > the higher priority one - even though the time slices are WAY way diffe=
rent
> > in size (1ms and 223ms). Con Kolivas told me that he experienced the sa=
me
> > odd behaviour when he implemented io priorities on top of deadline.
>=20
> Well, for this specific case, I'd suggest you check out how much of the
> write out actually happens in context of that process. Often you end up
> with pdflush(es) doing the process dirty work, and the io priorities
> aren't inherited across that boundary.

Hmm....will do.

> > -static int cfq_slice_sync =3D HZ / 10;
> > -static int cfq_slice_async =3D HZ / 25;
> > +static int cfq_slice_sync =3D HZ / 1000;
> > +static int cfq_slice_async =3D HZ / 1000;
> >  static int cfq_slice_async_rq =3D 16;
> > -static int cfq_slice_idle =3D HZ / 249;
> > +static int cfq_slice_idle =3D HZ / 1000;
>=20
> You need to be careful, on archs with HZ =3D=3D 100 you just set every ti=
me
> slice to 0.

Yes, I was trying to get to work on my box first.

> > +/* the slice scaling factors */
> > +static int cfq_prio_scale[] =3D {223, 194, 169, 147, 128,		/* 0..4 */
> > +			       111,  97,  84,  73,  64,		/* 5..9 */
> > +			        56,  49,  42,  36,  32,		/* 10..14 */
> > +			        28,  24,  21,  18,  16,		/* 15..19 */
> > +			        14,  12,  11,   9,   8,		/* 20..24 */
> > +			         7,   6,   5,   5,   4,		/* 25..29 */
> > +			         3,   3,   2,   2,   2,		/* 30..34 */
> > +			         1,   1,   1,   1,   1};	/* 35..39 */
>=20
> I think it's pointless to scale it so fine grained (see my earlier
> postings).

I guess 40 priorities is a little too much. Now that I am thinking about
it more, 40 levels is way too much. I'll change it later.

> Additionally, you don't do anything with the priorities internally.

Sure I do, I multiply the slice by cfq_prio_scale[ioprio]. It did seem
too simple. :-) Looking at your code right now, I kind of see some code
that should have been in my implementation as well. Back to coding...
:-)

Jeff.

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBvcatwFP0+seVj/4RAr/IAJ0QzRo3JZVEOKYG0FbnXedE+vmHpgCgpzZC
1wsH8DngzUa/FFMcnjRzQjM=
=5XSm
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
