Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTLMAiq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 19:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTLMAiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 19:38:46 -0500
Received: from [38.119.218.103] ([38.119.218.103]:32411 "HELO
	mail.bytehosting.com") by vger.kernel.org with SMTP id S262564AbTLMAin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 19:38:43 -0500
X-Qmail-Scanner-Mail-From: drunk@conwaycorp.net via digital.bytehosting.com
X-Qmail-Scanner: 1.20rc3 (Clear:RC:1:. Processed in 0.046612 secs)
Date: Fri, 12 Dec 2003 18:38:41 -0600
From: Nathan Poznick <kraken@drunkmonkey.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Handle R_ALPHA_REFLONG relocation on Alpha (2.6.0-test11)
Message-ID: <20031213003841.GA5213@wang-fu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


First off, I'm not positive that this patch is correct or not, but I'd
like to pick the brains of people in the know, to find if I'm
approaching this in the right way.

I've been unable to use modules on my Alpha with 2.6.0-test*.  modprobe
(from module-init-tools 0.9.15-pre3) would claim an invalid module
format, and the kernel would tell me "Unknown relocation: 1"  Relocation
1 on Alpha is R_ALPHA_REFLONG, and sure enough, readelf -r on one of the
modules showed many, many uses of it.  From looking at
arch/alpha/kernel/module.c, it appeared that while R_ALPHA_REFQUAD was
handled, R_ALPHA_REFLONG was not.  R_ALPHA_REFQUAD's handling looked
simple enough, so I made the change which is inlined below.

Is this the proper way to handle this?  After making this change, I've
been able to use modules without any problems.


--- linux-2.6.0-test11/arch/alpha/kernel/module.c 2003-12-12 18:19:27.00000=
0000 -0600
+++ linux-2.6.0-test11.new/arch/alpha/kernel/module.c 2003-12-12 18:32:51.0=
00000000 -0600
@@ -198,6 +198,9 @@
    switch (r_type) {
    case R_ALPHA_NONE:
      break;
+   case R_ALPHA_REFLONG:
+     *(u32 *)location =3D value;
+     break;
    case R_ALPHA_REFQUAD:
      /* BUG() can produce misaligned relocations. */
      ((u32 *)location)[0] =3D value;



--=20
Nathan Poznick <kraken@drunkmonkey.org>

"So many times you've given me comfort and forgetfulness." --Frank
Herbert, Dune


--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/2l+RYOn9JTETs+URAjVjAJ9aBQ6PPDHLd9Ud+Zob3mi6Mc3qQwCfUudR
kqy5KbZCPR3QliCoM2q0Xug=
=rV6A
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
