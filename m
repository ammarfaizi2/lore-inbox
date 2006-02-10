Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWBJN5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWBJN5q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWBJN5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:57:46 -0500
Received: from mail.gmx.de ([213.165.64.21]:20123 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932083AbWBJN5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:57:46 -0500
X-Authenticated: #2308221
Date: Fri, 10 Feb 2006 14:57:39 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] neofb: add more logic to determine sensibility of register readback
Message-ID: <20060210135737.GA15197@hermes.uziel.local>
References: <20060208202207.GA26682@zeus.uziel.local> <20060210113616.GA17482@hermes.uziel.local> <43EC7EA7.5030105@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <43EC7EA7.5030105@gmail.com>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Fri, Feb 10, 2006 at 07:53:11PM +0800, Antonino A. Daplas wrote:
> You can save a few lines by
>=20
> par->PanelDispCntlRegRead =3D (blank_mode) ? 0 : 1;
>=20
> Tony
>=20

That's just beautiful. I'm a bloody n00b when it comes to C, so I lack
the feeling for such subtleties : ) Thanks a bunch! Reworked patch
below, also adding proper initialization which got missing during
back-and-forth testing.

Signed-off-by: Christian Trefzer <ctrefzer@gmx.de>


--- a/include/video/neomagic.h	2006-01-03 04:21:10.000000000 +0100
+++ b/include/video/neomagic.h	2006-02-09 20:59:20.164839408 +0100
@@ -159,6 +159,7 @@
 	unsigned char PanelDispCntlReg1;
 	unsigned char PanelDispCntlReg2;
 	unsigned char PanelDispCntlReg3;
+	unsigned char PanelDispCntlRegRead;
 	unsigned char PanelVertCenterReg1;
 	unsigned char PanelVertCenterReg2;
 	unsigned char PanelVertCenterReg3;
--- a/drivers/video/neofb.c	2006-02-08 21:24:05.000000000 +0100
+++ b/drivers/video/neofb.c	2006-02-10 14:54:17.312841824 +0100
@@ -843,6 +843,9 @@
=20
 	par->SysIfaceCntl2 =3D 0xc0;	/* VESA Bios sets this to 0x80! */
=20
+	/* Initialize: by default, we want display config register to be read */
+	par->PanelDispCntlRegRead =3D 1;
+
 	/* Enable any user specified display devices. */
 	par->PanelDispCntlReg1 =3D 0x00;
 	if (par->internal_display)
@@ -1334,8 +1337,12 @@
 	struct neofb_par *par =3D (struct neofb_par *)info->par;
 	int seqflags, lcdflags, dpmsflags, reg;
=20
-	/* Reload the value stored in the register, might have been changed via F=
N keystroke */
-	par->PanelDispCntlReg1 =3D vga_rgfx(NULL, 0x20) & 0x03;
+	/* Reload the value stored in the register, if sensible. It might have be=
en
+	 * changed via FN keystroke. */
+	if (par->PanelDispCntlRegRead && !blank_mode) {
+		par->PanelDispCntlReg1 =3D vga_rgfx(NULL, 0x20) & 0x03;
+	}
+	par->PanelDispCntlRegRead =3D (blank_mode) ? 0 : 1;
 =09
 	switch (blank_mode) {
 	case FB_BLANK_POWERDOWN:	/* powerdown - both sync lines down */

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ+yb0F2m8MprmeOlAQLgYg/+KDuDI2d91clyFmcGotyMDO8crZVxOOEs
CM9LoJs5uSY27UwFhi1lpYM9q2C/huJ9gBZSG4ppiyM5J8LiDJ4BVrDv5xVm1ELU
bBEXd68Vb29YUkg0FRdahfFXaNZLry+EHfLQdnjynfvxQ1UVp8pbLDOHvgHG0EV8
hjJgAMTYNv9Yw4GiexLjZedg5V6k8iAiMFkWMjp+i4J/KsaD99zIhZIjjWulB53K
5ecfmdkgbZcAP8SH1QYWJfue7/J6xDR1tD1TeGNbMhtWZ3pdIsm2bTizNHlciNAQ
kG37ieskU753uoLLXS73LYGAzZQud33t7cWJHImRJq0VYXmvRPpU4JBuGt5jyIby
XoY0fxqXTVR9JJ8igNP/Bi50ZyVjPQB7s2Bv4eTZgprMxYEnRKo3dwaNMC+Rj008
T2HJ792pPWI5vtM2j7JzIgu3SiJcQYcNyvAwyaqwBouHpAynXyYTQdpzGptggxwj
5ylYPvcjEBrtKtLYL9+JmdrR9lWh8NjJXaoq0ZLXwOXMoqjJQcL1fl95ZHL11/5x
CWN2P1IXs7xm5uWJ7DPCJXpvt9Dnc5yRaw/n95nn3BUKXLl0qrfcXSn7FxScLPYw
6E31O5t3e/AzVX/+lkVL1m6uV38H/+fn+tJ5DFys87D6b/4sI6RqatgVbKUKtRDG
WOlQCNfZCDs=
=O1zR
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--

