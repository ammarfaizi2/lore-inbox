Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWATH3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWATH3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 02:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWATH3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 02:29:07 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:50643 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1750826AbWATH3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 02:29:05 -0500
Date: Fri, 20 Jan 2006 09:28:51 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       an Molton <spyro@f2s.com>, tony@atomide.com, jamey.hicks@hp.com,
       joshua@joshuawise.com, david-b@pacbell.net,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] bitmap: Support for pages > BITS_PER_LONG.
Message-ID: <20060120072851.GA3918@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, an Molton <spyro@f2s.com>, tony@atomide.com,
	jamey.hicks@hp.com, joshua@joshuawise.com, david-b@pacbell.net,
	Russell King <rmk@arm.linux.org.uk>
References: <20060119014812.GB18181@linux-sh.org> <20060118191157.f653b09d.pj@sgi.com> <1137727710.3571.51.camel@mulgrave>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <1137727710.3571.51.camel@mulgrave>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2006 at 09:28:30PM -0600, James Bottomley wrote:
> On Wed, 2006-01-18 at 19:11 -0800, Paul Jackson wrote:
> > Could you look Mundt's patch, and see if it looks ok?
>=20
> Not being on lkml, this was harder than it sounds, but I eventually
> found the actual patch on marc.  However, no, it doesn't look right.
>=20
> This:
>=20
> > +		/* find space in the bitmap */
> > +		for (j =3D 0; j < span; j++)
> > +			if ((bitmap[index + j] & (mask << offset))) {
>=20
>=20
> Is wrong.  You're looking for an unset span of order bits at a given
> offset.  So you get the byte offset for the first, then all the
> following bitmap[n] need to be zero until you need to do an offset in
> reverse for the last bit.  i.e. (assuming BITS_PER_LONG=3D32) for a span
> of 126 at offset 1, you check
>=20
> bitmap[0] & 0xfffffffe =3D=3D 0
> bitmap[1] & 0xffffffff =3D=3D 0
> bitmap[2] & 0xffffffff =3D=3D 0
> bitmap[3] & 0x7fffffff =3D=3D 0
>=20
> and so on.
>=20
This code operates on the assumption that offset is always 0 for the
pages =3D=3D BITS_PER_LONG case. It's calculated in this order:

        unsigned int pages =3D 1 << order;
        int i;
        int span =3D (pages + (BITS_PER_LONG - 1)) / BITS_PER_LONG;

        if (pages > BITS_PER_LONG)
                pages =3D BITS_PER_LONG;

=2E..
        for (i =3D 0; i < bits; i +=3D pages) {
                int index =3D i/BITS_PER_LONG;
                int offset =3D i - (index * BITS_PER_LONG);
=2E..

So in the case of pages >=3D BITS_PER_LONG the mask will be 0xffffffff, and
offset will be 0, and the span will define how many adjacent words we
need to set. Unless I'm missing something, I don't see how your case
would happen. I did test this quite a bit mixing both tiny and large
orders.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0JEz1K+teJFxZ9wRAgaVAJ97f2+9R9Z2lOHC5lEbRLlnrczCgwCeMe7y
pp++ScxdBwIPM6jhJQSi5BY=
=F9DK
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
