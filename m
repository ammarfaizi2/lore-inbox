Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTKFU2U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 15:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbTKFU2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 15:28:20 -0500
Received: from wblv-224-88.telkomadsl.co.za ([165.165.224.88]:60555 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S263800AbTKFU2R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 15:28:17 -0500
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
	defined (trivial)
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: "David S. Miller" <davem@redhat.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20031106120548.097ccc7c.davem@redhat.com>
References: <1068140199.12287.246.camel@nosferatu.lan>
	 <20031106093746.5cc8066e.davem@redhat.com>
	 <1068143563.12287.264.camel@nosferatu.lan>
	 <1068144179.12287.283.camel@nosferatu.lan>
	 <20031106113716.7382e5d2.davem@redhat.com>
	 <1068149368.12287.331.camel@nosferatu.lan>
	 <20031106120548.097ccc7c.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IkxrgYtfxVzPVxKgY45g"
Message-Id: <1068150552.12287.349.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 22:29:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IkxrgYtfxVzPVxKgY45g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-11-06 at 22:05, David S. Miller wrote:
> On Thu, 06 Nov 2003 22:09:29 +0200
> Martin Schlemmer <azarah@gentoo.org> wrote:
>=20
> > On Thu, 2003-11-06 at 21:37, David S. Miller wrote:
> > > Let's say that you end up using some inline function
> > > that takes u32 arguments, and internally it uses
> > > u64 types to speed up the calculation or make it more
> > > accurate or something like that.
> >=20
> > So basically only in cases where the stuff in byteorder.h
> > was not inlined ... ?
>=20
> No, exactly in the cases where it _IS_ inlined.  Imagine
> this:
>=20
> static inline u32 swab_foo(u32 a, u32 b)
> {
> 	u64 tmp =3D ((u64)a<<32) | ((u64)b);
> 	u32 retval;
>=20
> 	retval =3D compute(tmp);
>=20
> 	return retval;
> }
>=20
> If that's in a kernel header somewhere, and you build with -ansi,
> you lose.

If you look at asm/types.h, u64 is kernel only namespace, so in
theory that code will not be in userspace.  Also, the whole idea
of this patch (the first one that touched byteorder.h, and not the
second that touched types.h), was to encase everything that used
__u64 that _is_ in userspace in __STRICT_ANSI__.  If there thus
was another place that did use __u64 outside a ifdef __STRICT_ANSI__,
the compile would anyhow stop with -ansi.

Your above example would thus look more like:

--
#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
static inline __u32 swab_foo(__u32 a, __u32 b)
{
	__u64 tmp =3D ((__u64)a<<32) | ((__u64)b);
	__u32 retval;

	retval =3D compute(tmp);

	return retval;
}
#else
<code without __u64>
..
#endif
--

which in theory should not have an issue.


Thanks,

--=20

Martin Schlemmer




--=-IkxrgYtfxVzPVxKgY45g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/qq8YqburzKaJYLYRAt9jAJ4pKmwoiGbERtmtciYj1Cmsh2ybCACdGMlh
Az4tRgMmZkZO0EE7Y23Q8NM=
=4Mtl
-----END PGP SIGNATURE-----

--=-IkxrgYtfxVzPVxKgY45g--

