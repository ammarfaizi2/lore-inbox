Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268213AbUG2QBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268213AbUG2QBO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268203AbUG2P4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:56:04 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:14808 "EHLO
	websrv.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S267608AbUG2Puv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:50:51 -0400
Subject: Re: [PATCH] Delete cryptoloop
From: Christophe Saout <christophe@saout.de>
To: James Morris <jmorris@redhat.com>
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Xine.LNX.4.44.0407282025440.12996-100000@dhcp83-76.boston.redhat.com>
References: <Xine.LNX.4.44.0407282025440.12996-100000@dhcp83-76.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-y9B1DMJNEBF3y1snMl3E"
Date: Thu, 29 Jul 2004 17:50:39 +0200
Message-Id: <1091116240.12054.9.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y9B1DMJNEBF3y1snMl3E
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 28.07.2004, 20:27 -0400 schrieb James Morris:

> > James Morris  wrote:
> > >It would be good if we could get some further review on the issue by a=
n=20
> > >independent, well known cryptographer.
> >=20
> > I'd be glad to review it if someone can point me to a clear, concise
> > description of the scheme (trying to extract the spec from the code
> > is too much work for me).
>=20
> That would be great.  It would be best to do this review for dm-crypt. =20
>=20
> Christophe, is there a detailed description of the existing scheme?

I can explain it here, it's pretty simple:

IV =3D sector number (little endian, 32 bits), pad with zeroes

The actual content is then encoded using the selected cipher and key in
CBC mode.

For those who don't know what exactly that means:

C[0] =3D E(IV     xor P[0])
C[1] =3D E(C[0]   xor P[1])
...
C[n] =3D E(C[n-1] xor P[n])

C is the encrypted data, P the plaintext data. The block size is given
by the cipher (usually 128 bit or something like that). E is the
encryption using cipher and key.

This is done for every sector.

The weakness is that the IV is known. You can write specially crafted
blocks on the disk and have a known plaintext for the first block.

Also see: http://clemens.endorphin.org/OnTheProblemsOfCryptoloop

One simple way to avoid this would be to compute the IV in a different
way, something based on key and sector number.


--=-y9B1DMJNEBF3y1snMl3E
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBCRzPZCYBcts5dM0RArEyAKCLw1Z3PrXDfDsxP+vaSQYKk5OfEgCdEb1f
Z9C7SLaqvf5tZ3GnE/uF9iM=
=nyjS
-----END PGP SIGNATURE-----

--=-y9B1DMJNEBF3y1snMl3E--

