Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVBJJuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVBJJuw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 04:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVBJJuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 04:50:50 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:65035 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S262084AbVBJJuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 04:50:14 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       michal@logix.cz, "David S. Miller" <davem@davemloft.net>,
       "Adam J. Richter" <adam@yggdrasil.com>
In-Reply-To: <Xine.LNX.4.44.0502092036200.6541-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0502092036200.6541-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0/AqMHEMcWbkYwYLJIDC"
Date: Thu, 10 Feb 2005 10:50:05 +0100
Message-Id: <1108029005.14335.45.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0/AqMHEMcWbkYwYLJIDC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-09 at 20:42 -0500, James Morris wrote:
> On Thu, 10 Feb 2005, Fruhwirth Clemens wrote:
>=20
> > Because a tweak is different from an IV. There can be an arbitrary
> > number of tweaks. For instance, EME takes 1 tweak per 512 bytes. If you
> > have a 4k page to encrypt, you have to process 8 tweaks of whatever
> > size.=20
> >  Therefore, you need 3 scatterlists: src, dst and the running along
> > tweak.
>=20
> The purpose of the scatterlists is to be able to process discontigous dat=
a=20
> at the page level.
>=20
> The tweak, as I understand it, is something which you generate, and it is=
=20
> not inherently likely to be page-level clumps of data.  It does not ever=20
> need to be kmapped.

For LRW, the tweak is exactly as large as the bulk data itself, so
tweaksize =3D blocksize. Yes, it is usually generated and sequential, but
that may not be the case. I like to put the generation of the tweaks at
the client side, because it knows best where the tweaks come from and if
it likes fragmented tweaks or not.

Further, this interface is more naturally to any other tweakable cipher
mode. In contrast to a regular cipher:

E: {0,1}^k  x  {0,1}^n -> {0,1}^n

a tweakable cipher is:

E: {0,1}^k  x  {0,1}^t  x  {0,1}^n -> {0,1}^n

where k is key size, n block size and t is tweak size.
( http://www.cs.berkeley.edu/%7Edaw/papers/tweak-crypto02.ps )

In the special case of LRW, it would be possible to squeeze it into an
IV styled interface, which does auto-incrementation. But that's flawed.
It would put functionality, where it does not belong. Witha  tweakable
mode, the blocks are independent and are not linked in any way. The
interface should reflect this.

> What you really need to do is use an array for the tweak (or possibly a
> structure which maintains state about it if needed).

The LRW cipher mode is stateless. There is context information, but this
only a cache. Same applies for EME, and it's fellows.

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-0/AqMHEMcWbkYwYLJIDC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCCy5NbjN8iSMYtrsRArV4AJ91h2JJrZvblYnQOesawnllMs0+dgCcDb6o
EqrbwqVWwmRND8H5lb+EiMw=
=P/rj
-----END PGP SIGNATURE-----

--=-0/AqMHEMcWbkYwYLJIDC--
