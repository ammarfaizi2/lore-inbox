Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTDUJzR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 05:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTDUJzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 05:55:17 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:5322 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263805AbTDUJzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 05:55:16 -0400
Date: Mon, 21 Apr 2003 13:07:12 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [TRIDENT] teach trident_interrupt() about irqreturn_t
Message-ID: <20030421100712.GA2188@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,=20

This patch updates trident_interrupt() to return
IRQ_HANDLED and cleans it up a little while I'm at it. Compiles, boots
and plays mp3s fine. Patch is against 2.5.68-cvs, please apply.

Index: sound/oss/trident.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux-2.5/sound/oss/trident.c,v
retrieving revision 1.20
diff -u -r1.20 trident.c
--- sound/oss/trident.c	8 Apr 2003 16:46:36 -0000	1.20
+++ sound/oss/trident.c	21 Apr 2003 09:02:01 -0000
@@ -1728,7 +1728,7 @@
 	}
 }
=20
-static void trident_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t trident_interrupt(int irq, void *dev_id, struct pt_regs=
 *regs)
 {
 	struct trident_card *card =3D (struct trident_card *)dev_id;
 	u32 event;
@@ -1753,15 +1753,18 @@
 				ali_queue_task(card, gpio&0x07);
 		}
 		event =3D inl(TRID_REG(card, T4D_MISCINT));
-		outl(event | (ST_TARGET_REACHED | MIXER_OVERFLOW | MIXER_UNDERFLOW), TRI=
D_REG(card, T4D_MISCINT));
-		spin_unlock(&card->lock);
-		return;
+		event |=3D (ST_TARGET_REACHED | MIXER_OVERFLOW | MIXER_UNDERFLOW);=20
+		outl(event, TRID_REG(card, T4D_MISCINT));
+		goto done;=20
 	}
=20
 	/* manually clear interrupt status, bad hardware design, blame T^2 */
 	outl((ST_TARGET_REACHED | MIXER_OVERFLOW | MIXER_UNDERFLOW),
 	     TRID_REG(card, T4D_MISCINT));
+
+done:=20
 	spin_unlock(&card->lock);
+	return IRQ_HANDLED;
 }
=20
 /* in this loop, dmabuf.count signifies the amount of data that is waiting=
 to be copied to

--=20
Muli Ben-Yehuda
http://www.mulix.org


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+o8LQKRs727/VN8sRAr3uAKCHu1wiIZhQJCjAAGlChgVoEP7gQgCcCXOP
1uLIc4t2K7Waiflo4PQPes8=
=wuVJ
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
