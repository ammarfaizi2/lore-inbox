Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268554AbUGXMlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268554AbUGXMlz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 08:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268555AbUGXMlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 08:41:55 -0400
Received: from irulan.endorphin.org ([212.13.208.107]:6673 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S268554AbUGXMlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 08:41:51 -0400
Subject: Re: [PATCH] Delete cryptoloop
To: James Morris <jmorris@redhat.com>, Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-jqrxE1SwFcGkXaqOXAvh"
Message-Id: <1090672906.8587.66.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 24 Jul 2004 14:41:46 +0200
From: Fruhwirth Clemens <clemens-dated-1091536908.31f8@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jqrxE1SwFcGkXaqOXAvh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-07-21 at 22:16, James Morris wrote:
> This patch deletes cryptoloop, which is buggy, unmaintained, and
> reportedly has mutliple security weaknesses. Dropping cryptoloop should
> also help dm-crypt receive more testing and review.

Short version:
Remove cryptoloop || mark as deprecated.

Long version:
First, dm-crypt and cryptoloop share the same on-disk format. There is
absolutely no security gain by switching to dm-crypt.

Second, modern ciphers like Twofish || AES are designed to resist
known-plaintext attacks. This is basically the FUD spread by Jari Rusuu.
But, due to a recent discussion on sci.crypt, I have been convinced that
there is in fact a security gain by obscuring the IV. To be precise, if
an attacker is able to find two identical cipher blocks on disk, he will
be able to deduce the plain text difference. The chance p that two
blocks are equal is p=3D1/2^128 for 128 bit block ciphers. If one of these
blocks happens to be zero this is quite bad. The chance that there are
no identical cipher blocks on a disk is given by p^(n(n-1)/2) with n =3D
numbers of sectors on disk. Anyone with a little bit math intuition can
see this terms will approach 0 quite quick. So it is likely that some
information is revealed.=20

This situation will not be cured by switching to dm-crypt, since
dm-crypt suffers from the same kind of problem. Although personally, I
neglect this security threat.=20

However, I do recommend that cryptoloop is removed from the kernel || is
declared deprecated for the following reasons:

- There is no suitable user space tool ready to use it. util-linux has
been broken ever since. My patch key-trunc-fix patch has to be applied
to make any use of losetup. Further I'm not going to submit patches to
this project to fix user space problems (see below)

- I'm not going to submit patches to cure the security problems of
cryptoloop pointed out in the first few paragraphs,

- dm-crypt is a stable alternative and can be easily immigrated to with
the help of my little lotracker tool:
http://clemens.endorphin.org/lo-tracker

So much for cryptoloop.

I'd like to point out that in the most cases the key deduction scheme is
more likely the weakest component in a hard disk encryption setup. For
those interested: http://clemens.endorphin.org/TKS1-draft.pdf points to
the problems connect with HD encryption. This paper is the groundwork
for my Linux Unified Key Setup project http://clemens.endorphin.org/LUKS
. Here, you will find patches for cryptsetup (the losetup equivalent to
losetup). I'm working with Christophe Saout to integrate LUKS into
cryptsetup in the near future.

Regards,
--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-jqrxE1SwFcGkXaqOXAvh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBAlkJW7sr9DEJLk4RAuRtAJ46VxkaK5NIHHjP28xcbvZN3jrPGwCghHzL
Igc6dJkvyytYtcYPX9YhSgQ=
=DgXW
-----END PGP SIGNATURE-----

--=-jqrxE1SwFcGkXaqOXAvh--
