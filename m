Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275409AbTHIUlQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 16:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275414AbTHIUlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 16:41:16 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:39869 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S275409AbTHIUlI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 16:41:08 -0400
Date: Sat, 9 Aug 2003 23:40:58 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Muli Ben-Yehuda <mulix@mulix.org>
Subject: [PATCH] fix trident.c lockup on module load 2.6.0-test2
Message-ID: <20030809204058.GN12446@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hdhkc9EpVJoq6PQ6"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hdhkc9EpVJoq6PQ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,=20

This patch fixes a kernel lockup with 2.6.0-test2 when the trident.c
OSS driver is loaded and the driver attempts to initialize the
card. The problem is that in ali_ac97_get() we lock the card->lock
spinlock, but never release it on the good path, only on the error
path. This patch adds the missing spin_unlock_irqrestore().=20

This bug snuck in in a 2.4 sync from Alan, and 2.4 appears to suffer
=66rom the same problem. Patch will be send to Marcelo momentarily. =20

Patch is against 2.6.0-test2-cvs, tested and works, and fixes a pretty
severe lockup bug. Please apply.=20

Cheers,=20
Muli.=20

Index: sound/oss/trident.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux-2.5/sound/oss/trident.c,v
retrieving revision 1.27
diff -u -r1.27 trident.c
--- sound/oss/trident.c	1 Aug 2003 19:02:34 -0000	1.27
+++ sound/oss/trident.c	9 Aug 2003 18:53:08 -0000
@@ -3017,6 +3017,8 @@
 	}
 =09
 	data =3D inl(TRID_REG(card, address));
+
+	spin_unlock_irqrestore(&card->lock, flags);=20
 =09
 	return ((u16) (data >> 16));
=20

--hdhkc9EpVJoq6PQ6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/NVxZKRs727/VN8sRAs7OAKCNanLQXa7/v3WyFI7JfqDHaz1KcgCdFXj8
itiYHjY8rQ7y46rBxMgU9sE=
=SceF
-----END PGP SIGNATURE-----

--hdhkc9EpVJoq6PQ6--
