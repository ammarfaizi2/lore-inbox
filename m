Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275411AbTHIVZU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 17:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275413AbTHIVZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 17:25:20 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:27361 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S275411AbTHIVZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 17:25:15 -0400
Date: Sun, 10 Aug 2003 00:25:03 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Muli Ben-Yehuda <mulix@mulix.org>
Subject: [PATCH] fix trident.c lockup on module load 2.4.22-rc1
Message-ID: <20030809212502.GQ12446@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BuBclajtnfx5hylj"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BuBclajtnfx5hylj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,=20

This patch fixes a kernel lockup with 2.4.22-rc1 when the trident.c
driver is loaded and the driver attempts to initialize the card. The
problem is that in ali_ac97_get() we lock the card->lock spinlock, but
never release it on the good path, only on the error path. This patch
adds the missing spin_unlock_irqrestore().

Patch is against 2.4.22-rc1-cvs, tested and works, and fixes a pretty
severe lockup bug. Please apply.=20

Cheers,=20
Muli.=20

Index: drivers/sound/trident.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux-2.4/drivers/sound/trident.c,v
retrieving revision 1.29
diff -u -r1.29 trident.c
--- drivers/sound/trident.c	2 Jul 2003 21:42:15 -0000	1.29
+++ drivers/sound/trident.c	9 Aug 2003 19:54:58 -0000
@@ -3014,6 +3014,8 @@
 	}
 =09
 	data =3D inl(TRID_REG(card, address));
+
+	spin_unlock_irqrestore(&card->lock, flags);=20
 =09
 	return ((u16) (data >> 16));
=20

--BuBclajtnfx5hylj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/NWauKRs727/VN8sRArVqAJ4oiaSKI5PuywWBZD8qLkn4r01YbACgveB7
xqbz3w708HLLZxhFQCyBcHA=
=E3fO
-----END PGP SIGNATURE-----

--BuBclajtnfx5hylj--
