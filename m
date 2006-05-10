Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWEJL2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWEJL2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 07:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWEJL2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 07:28:55 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:46312 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S964905AbWEJL2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 07:28:55 -0400
Date: Wed, 10 May 2006 13:28:52 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@odsl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] [Cardman 40x0] Fix udev device creation
Message-ID: <20060510112852.GC21864@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Please apply this fix for the cm40x0 device drivers.  It's obvious, clean,
affects only those two devices, so I hope it'll make it in 2.6.17-final.

Thanks!

[Cardman 40x0] Fix udev device creation

This patch corrects the order of the calls to register_chrdev() and
pcmcia_register_driver().  Now udev correctly creates userspace device
files /dev/cmmN and /dev/cmxN respectively.

Based on an earlier patch by Jan Niehusmann <jan@gondor.com>.

Signed-off-by: Harald Welte <laforge@netfilter.org>

---
commit 3599bbbe2873942dcc68bc50dec7a91868373654
tree 7523c29329841e6375943ef50d23c74179ff85d2
parent 33f85f1beef2ebbcacaec5518ec3ed7c42d44508
author Harald Welte <laforge@netfilter.org> Wed, 12 Apr 2006 17:41:01 +0200
committer Harald Welte <laforge@netfilter.org> Wed, 12 Apr 2006 17:41:01 +0=
200

 drivers/char/pcmcia/cm4000_cs.c |   10 ++++++----
 drivers/char/pcmcia/cm4040_cs.c |   11 +++++++----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_c=
s.c
index 02114a0..128b263 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1981,10 +1981,6 @@ static int __init cmm_init(void)
 	if (!cmm_class)
 		return -1;
=20
-	rc =3D pcmcia_register_driver(&cm4000_driver);
-	if (rc < 0)
-		return rc;
-
 	major =3D register_chrdev(0, DEVICE_NAME, &cm4000_fops);
 	if (major < 0) {
 		printk(KERN_WARNING MODULE_NAME
@@ -1992,6 +1988,12 @@ static int __init cmm_init(void)
 		return -1;
 	}
=20
+	rc =3D pcmcia_register_driver(&cm4000_driver);
+	if (rc < 0) {
+		unregister_chrdev(major, DEVICE_NAME);
+		return rc;
+	}
+
 	return 0;
 }
=20
diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_c=
s.c
index 29efa64..47a8465 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -724,16 +724,19 @@ static int __init cm4040_init(void)
 	if (!cmx_class)
 		return -1;
=20
-	rc =3D pcmcia_register_driver(&reader_driver);
-	if (rc < 0)
-		return rc;
-
 	major =3D register_chrdev(0, DEVICE_NAME, &reader_fops);
 	if (major < 0) {
 		printk(KERN_WARNING MODULE_NAME
 			": could not get major number\n");
 		return -1;
 	}
+
+	rc =3D pcmcia_register_driver(&reader_driver);
+	if (rc < 0) {
+		unregister_chrdev(major, DEVICE_NAME);
+		return rc;
+	}
+
 	return 0;
 }
=20
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEYc50XaXGVTD0i/8RAqFnAJ9XAVvRCMzKNDh8oHwyBFTWpUOhmQCfaBSi
V6Yg24eB0UqeZ8V4xHPvwdY=
=nZFV
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
