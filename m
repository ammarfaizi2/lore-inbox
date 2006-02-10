Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWBJLgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWBJLgX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 06:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWBJLgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 06:36:23 -0500
Received: from mail.gmx.net ([213.165.64.21]:39370 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750995AbWBJLgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 06:36:23 -0500
X-Authenticated: #2308221
Date: Fri, 10 Feb 2006 12:36:16 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] neofb: add more logic to determine sensibility of register readback
Message-ID: <20060210113616.GA17482@hermes.uziel.local>
References: <20060208202207.GA26682@zeus.uziel.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20060208202207.GA26682@zeus.uziel.local>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello everyone,

testing my latest patches through productive use I noticed that we
require a bit of a logic for the register read to not cause trouble at
the time of unblanking. Thing is, blanking is implemented through
deactivation of the LCD activation bit, so if we read back the register,
the LCD backlight won't come back on until the LID is shut and reopened,
effectively pushing the work to the BIOS.

The following patch is on top of my previous one, adding a variable to
struct neofb_par to remember if we want to read the respective register
values next time we (un)blank.

Logic depends on the assumption that we won't change display config in a
blanked state, as a keypress should already be answered by unblanking.
Essentially, we should read back the register values to variable on
blank, and ignore them on unblank. Unfortunately, only checking for
!blank_mode won't avoid the backlight remaining off, hence the
additional checks.=20

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
+++ b/drivers/video/neofb.c	2006-02-09 23:21:33.489914472 +0100
@@ -1334,8 +1334,11 @@
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
 =09
 	switch (blank_mode) {
 	case FB_BLANK_POWERDOWN:	/* powerdown - both sync lines down */
@@ -1355,21 +1358,25 @@
 			tosh_smm(&regs);
 		}
 #endif
+		par->PanelDispCntlRegRead =3D 0;
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:		/* hsync off */
 		seqflags =3D VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
 		lcdflags =3D 0;			/* LCD off */
 		dpmsflags =3D NEO_GR01_SUPPRESS_HSYNC;
+		par->PanelDispCntlRegRead =3D 0;
 		break;
 	case FB_BLANK_VSYNC_SUSPEND:		/* vsync off */
 		seqflags =3D VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
 		lcdflags =3D 0;			/* LCD off */
 		dpmsflags =3D NEO_GR01_SUPPRESS_VSYNC;
+		par->PanelDispCntlRegRead =3D 0;
 		break;
 	case FB_BLANK_NORMAL:		/* just blank screen (backlight stays on) */
 		seqflags =3D VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
 		lcdflags =3D par->PanelDispCntlReg1 & 0x02; /* LCD normal */
 		dpmsflags =3D 0x00;	/* no hsync/vsync suppression */
+		par->PanelDispCntlRegRead =3D 0;
 		break;
 	case FB_BLANK_UNBLANK:		/* unblank */
 		seqflags =3D 0;			/* Enable sequencer */
@@ -1387,6 +1394,7 @@
 			tosh_smm(&regs);
 		}
 #endif
+		par->PanelDispCntlRegRead =3D 1;
 		break;
 	default:	/* Anything else we don't understand; return 1 to tell
 			 * fb_blank we didn't aactually do anything */

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ+x6rl2m8MprmeOlAQJ2YRAAsXBISwrpCXcPud+zGjpSVGSTFA78Zc/M
RQkO7uwGpbSWKgidNxA6vzXbghTjRUYAwek97iDfDl49vTRyWowel2r2M6HX4/Cl
9Lj93jwLoR4E8pFBUKJ3S+fdcnfT4y83SFbC0ZTp46/qC7sywLRH4n3aGjpfH2Xv
NIdfdIeXI7snwqx9armRYdtv3JytKsyVLYdst1iwyG1QF9BQNjjb5xLqHN1C8l3o
sQyD8e3+0oc6MkXGnzVEEYNwKZXo7KNI3BVmzngKEz0u7Pr7yw274Ao/uAglU1ZT
z9fvZAplghHsD5jTHH2dON0/bUNoEo1SDq3MNvLNmeY84/tqUeyHdfe/xbd+2s97
vwOfAU7xkTCu3+vD9dt92DQU5lpxwxJs3uZvTOdXtpymlSygbjRlhk+vMRT2WPnC
48oRl3D8tHx15TOzuitncINAu2eVGP8sqkEn83vq7sGafktwxxYiZaXoGut+4eGb
qQ6gmtyJpqNPk2LkFtIG9v5LkQUj1UUSBfFnb95q+K/j8VMaTr0yGPLz2rhdHaxo
SHHB6wnBHyfEsUNsLVncemaOaln+jxU3xLzxHBXAWWEhh3CZnavI7/Oq+Co/KDXu
/gzXHLkT+OhttV2oFw8TdXEXRQDfvL+tv+/BGYXysbiGfwMizsy+Iql99HASItQ3
9jQKJE3iU7U=
=2RNM
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

