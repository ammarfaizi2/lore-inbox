Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbRBVJMg>; Thu, 22 Feb 2001 04:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbRBVJM0>; Thu, 22 Feb 2001 04:12:26 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:21252 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S129627AbRBVJMO>; Thu, 22 Feb 2001 04:12:14 -0500
Date: Thu, 22 Feb 2001 12:11:51 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/sunhme.c, unbalanced and unchecked ioremap()
Message-ID: <20010222121151.A13350@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Hi all,

I found that sunhme.c doesn't check ioremap() return value and doesn't
call iounmap() on module unload. Attached patch (for 2.4.1-ac20) should fix=
 it,=20
compiles clearly, but untested (I have no such hardware).

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ioremap-sunhme
Content-Transfer-Encoding: quoted-printable

diff -ur linux.vanilla/drivers/net/sunhme.c linux/drivers/net/sunhme.c
--- linux.vanilla/drivers/net/sunhme.c	Thu Feb 22 20:50:00 2001
+++ linux/drivers/net/sunhme.c	Thu Feb 22 22:00:43 2001
@@ -2856,7 +2856,10 @@
 		printk(KERN_ERR "happymeal(PCI): Cannot find proper PCI device base addr=
ess.\n");
 		return -ENODEV;
 	}
-	hpreg_base =3D (unsigned long) ioremap(hpreg_base, 0x8000);
+	if ((hpreg_base =3D (unsigned long) ioremap(hpreg_base, 0x8000)) =3D=3D 0=
) {
+		printk(KERN_ERR "happymeal(PCI): Unable to remap card memory.\n");
+		return -ENODEV;
+	}
=20
 	for (i =3D 0; i < 6; i++) {
 		if (macaddr[i] !=3D 0)
@@ -3071,6 +3074,7 @@
 					    PAGE_SIZE,
 					    hp->happy_block,
 					    hp->hblock_dvma);
+			iounmap((void *)hp->gregs);
 		}
 #endif
 		unregister_netdev(hp->dev);

--SLDf9lqlvOQaIe6s--

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6lNfXBm4rlNOo3YgRAkpjAJ9IgcGQll6/IKdGmqi9FQo6fySbxACgkFlU
HKnqi/GZIl6Erw7NBRyUfcY=
=p082
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
