Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWBHUWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWBHUWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWBHUWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:22:36 -0500
Received: from mxout01.versatel.de ([212.7.152.117]:34457 "EHLO
	mxout01.versatel.de") by vger.kernel.org with ESMTP
	id S1751140AbWBHUWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:22:34 -0500
Date: Wed, 8 Feb 2006 21:22:07 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] neofb: avoid resetting display config on unblank
Message-ID: <20060208202207.GA26682@zeus.uziel.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch fixes issues with the NeoMagic framebuffer driver.

It nicely complements my previous fix already in linus' tree. The only
thing missing now is that the external CRT will not be activated at
neofb init when external-only is selected, either by register read or
module/kernel parameter.

Testing was done on a Dell Latitude CPi-A/NM2200 chip.


Previous behaviour:
- before booting linux, set the preferred display config X via FN+F8

- boot linux, neofb stores the register values in a private
  variable
 =20
- change the display config to Y via keystroke

- leave the machine in peace until display is blanked

- touching any key will result in display config X being restored

- booting up, the BIOS will acknowledge config Y, though...


Current behaviour:
At the time of unblanking, config Y is honoured because we now read back
register contents instead of just overwriting them with outdated values.

Signed-off by: Christian Trefzer <ctrefzer@gmx.de>

---

--- linux-2.6.15-ct3/drivers/video/neofb.c.orig	2006-02-08 19:59:39.1877938=
48 +0100
+++ linux-2.6.15-ct3/drivers/video/neofb.c	2006-02-08 20:52:28.174719064 +0=
100
@@ -1334,6 +1334,9 @@
 	struct neofb_par *par =3D (struct neofb_par *)info->par;
 	int seqflags, lcdflags, dpmsflags, reg;
=20
+	/* Reload the value stored in the register, might have been changed via F=
N keystroke */
+	par->PanelDispCntlReg1 =3D vga_rgfx(NULL, 0x20) & 0x03;
+=09
 	switch (blank_mode) {
 	case FB_BLANK_POWERDOWN:	/* powerdown - both sync lines down */
 		seqflags =3D VGA_SR01_SCREEN_OFF; /* Disable sequencer */
@@ -1366,7 +1369,7 @@
 	case FB_BLANK_NORMAL:		/* just blank screen (backlight stays on) */
 		seqflags =3D VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
 		lcdflags =3D par->PanelDispCntlReg1 & 0x02; /* LCD normal */
-		dpmsflags =3D 0;			/* no hsync/vsync suppression */
+		dpmsflags =3D 0x00;	/* no hsync/vsync suppression */
 		break;
 	case FB_BLANK_UNBLANK:		/* unblank */
 		seqflags =3D 0;			/* Enable sequencer */

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ+pS712m8MprmeOlAQIiMQ/8CXoy08yqGGb3uoYLS+JccNQ37iOMgIDo
Cv+zCJCnZLieLsJLXsHrYKf2RAW4d3AQcdtLamuk6Tp5semCj8Q7df5HMe2NBuXN
QWX5CjeMOcdzXzDO9vCgNzG72fMbPdewqXKCsEYDavS5G1Uz2h3P7zyYXyMC3+Xd
Uiu/H5ZHk8FAeJ4Rj6CzxCuSW7RhBDKJcbRwXZHrdrmCRgtvzRo4uuBx+ubLLmFm
FPXxsDgNGisk3uyo68wjuPuUwZk8pIGhtZsCdvmE+5uzajrq0oVlCT/WUB+FhKrz
0goQW+inr2/6b0SxRkOCMYDL51TOwFH7xho4UeTin/VDT3RKjunAQgeDk2e4qZhT
VBr19jQlOyuqa1t+Hm49KZJVXuIbjpRRu5rmzR1B7IUW+1cf4twxw1eizGZtVNcT
cwJEIPnFdfGpdQ3P8oGCilPY1RKRhr9U3cPdSXayrqcSLbRbDCH2pV7yXm2NqI/u
gOqTy3U8624F84Z3TEHoqn3VJXLa05fZz3vsteVCwhpr9zOJV1QAX1NYXljGtJaf
H46R1YCyqeF6fa0CZ8ol5R0UW5vM82Rn/XXSPgeIIL7d8IEgOXNfUb7iu+b/EOul
RA9GwuAM2GlWd2jAE0WXb8qYujnl5fHZ3sM9rSKOEKzEA6XuQSCnoeJ4DuDDEYWD
bc9kGJRx9Zc=
=Rs+X
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

