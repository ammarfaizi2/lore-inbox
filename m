Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267669AbUG3NNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267669AbUG3NNv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 09:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267673AbUG3NNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 09:13:51 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:20910 "EHLO
	websrv.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S267669AbUG3NNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 09:13:48 -0400
Subject: Re: [PATCH] Delete cryptoloop
From: Christophe Saout <christophe@saout.de>
To: David Wagner <daw@cs.berkeley.edu>
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200407292115.i6TLFTpo017213@taverner.CS.Berkeley.EDU>
References: <200407292115.i6TLFTpo017213@taverner.CS.Berkeley.EDU>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-M84b06RkQfHou5oIfWzf"
Date: Fri, 30 Jul 2004 15:13:39 +0200
Message-Id: <1091193219.11944.17.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M84b06RkQfHou5oIfWzf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 29.07.2004, 14:15 -0700 schrieb David Wagner:

> > IV =3D sector number (little endian, 32 bits), pad with zeroes
> > The actual content is then encoded using the selected cipher and key in
> > CBC mode.
> > C[0] =3D E(IV     xor P[0])
> > C[1] =3D E(C[0]   xor P[1])
> > ...
>=20
> Ok, that's what I thought.  The above is pretty good, but does have some
> weaknesses due to the IV selection.  CBC mode needs uniformly random IVs
> for security; using a counter can cause occasional information leakage.

Yes, we already identified this problem.

> You can see that the information leakage is typically modest and limited;
> in many cases, there might be no leakage at all.  Nonetheless, this is
> not an ideal situation.  As a cryptographer, one would usually consider
> this a flawed design (primarily because it is so easy to do better).
> There are known ways to prevent this attack; for instance, IV =3D E(secto=
r
> number) or IV =3D HMAC(sector number) should be much better.

Exactly.

But we identified more problems (I don't if these are all real issues).

Assuming the attacker has access to both plaintext and the encrypted
disk. (shared storage, user account on the machine or something)

A simple one is if you set a sector to all zeroes, due to CBC you get
tons of plaintext-encrypted pairs on the encrypted disk.

One problem would be that if he modifies a sector only the rest of that
sector changes, starting from the block he changed.
Since CBC uses C[n] =3D E(C[n-1] xor P[n]) he could set P[n] =3D C[n-1] and
then has C[n] =3D E(0) which could be precomputed.

This can't happen if the IV also depends on the sector content, like IV
=3D HMAC(sector number, P[1 .. n-1])

Or if the attacker can copy around sectors on the encrypted side (shared
storage) from one location to another location where he has read access
on the machine that can decrypt the data, he can simply read the data
except for the first block (if secured by an "random" IV). This can't be
avoided when using CBC and a single key for every sector.


--=-M84b06RkQfHou5oIfWzf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBCkmDZCYBcts5dM0RAsTAAJkBBS3PK9sNTDBFUOvvW6177JEkBACfU/ot
gh5jQITIiiKhrCLqBBmAM9M=
=v+3t
-----END PGP SIGNATURE-----

--=-M84b06RkQfHou5oIfWzf--

