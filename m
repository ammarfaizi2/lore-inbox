Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVBVRgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVBVRgZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 12:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVBVRgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 12:36:25 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:32206 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261201AbVBVRgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 12:36:09 -0500
Subject: Re: idr_remove
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: russell@coker.com.au
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Jim Houston <jim.houston@ccur.com>, selinux@tycho.nsa.gov
In-Reply-To: <200502192332.54815.russell@coker.com.au>
References: <200502192332.54815.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mnQyRH4xa5eZV2sIl8Pg"
Date: Tue, 22 Feb 2005 18:35:40 +0100
Message-Id: <1109093740.4100.128.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mnQyRH4xa5eZV2sIl8Pg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El s=E1b, 19-02-2005 a las 23:32 +1100, Russell Coker escribi=F3:
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D109838483518162&w=3D2
>=20
> I am getting messages "idr_remove called for id=3D0 which is not allocate=
d" when=20
> SE Linux denies search access to /dev/pts.
>=20
> The attached file has some klogd output showing the situation, triggered =
in=20
> this case by installing a new kernel package on a SE Debian system.  The=20
> above URL references Jim Houston's message with the patch to add this=20
> warning.

The problem seems to be in a call back from idr_remove() to
sub_remove()@/lib/idr.c:284 which leads to calling idr_remove_warning(),
doing the weird stack dump, when some logics don't work as expected.

Jan 17 13:45:43 lyta kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jan 17 13:45:43 lyta kernel:  [sub_remove+233/240] sub_remove+0xe9/0xf0
Jan 17 13:45:43 lyta kernel:  [idr_remove+35/144] idr_remove+0x23/0x90

The spurious function called by sub_remove() (leads to the
dump_stack+0x17/0x20):

+static void idr_remove_warning(int id)
+{
+	printk("idr_remove called for id=3D%d which is not allocated.\n", id);
+	dump_stack();
+}
+

The changes that lead to such warning and stack dump

@sub_remove
+	n =3D id & IDR_MASK;
+	if (likely(p !=3D NULL && test_bit(n, &p->bitmap))){
(...etc...)

idr_remove() is called, among other places, within the Device Mapper
(DM) code that I suppose you are using, right?

I don't have time to make further checking, but seems to be somewhat
type of devices handling and IDR minor numbers allocation tracking
black magic, someone could have a further a look at it?

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-mnQyRH4xa5eZV2sIl8Pg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCG21sDcEopW8rLewRAvvqAKChvC3JM2QuK0MyiVsH+Y568p9QWACdEyTG
wBNliiMtsQSdRpx3fWblJ7E=
=wm34
-----END PGP SIGNATURE-----

--=-mnQyRH4xa5eZV2sIl8Pg--

