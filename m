Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422981AbWBOFxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422981AbWBOFxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 00:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422983AbWBOFxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 00:53:52 -0500
Received: from mail.gmx.net ([213.165.64.21]:27008 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422981AbWBOFxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 00:53:51 -0500
X-Authenticated: #2308221
Date: Wed, 15 Feb 2006 06:53:47 +0100
From: ctrefzer@gmx.de
To: akpm@osdl.org
Cc: adaplas@pol.net, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [-mm PATCH] neofb: enable LCD properly on unblank
Message-ID: <20060215055347.GA10941@zeus.uziel.local>
References: <200602150417.k1F4HSKX011435@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <200602150417.k1F4HSKX011435@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Feb 14, 2006 at 08:16:29PM -0800, akpm@osdl.org wrote:
> The patch titled
>=20
>      neofb: avoid resetting display config on unblank
>=20
> has been removed from the -mm tree.  Its filename is
>=20
>      neofb-avoid-resetting-display-config-on-unblank.patch
>=20
> This patch was probably dropped from -mm because
> it has now been merged into a subsystem tree or
> into Linus's tree, or because it was folded into
> its parent patch in the -mm tree.

seems like I was running late with my patch to handle the LCD properly
after blanking the screen.

We definitely need the patch below to get the LCD's backlight to a sane
state after unblanking. Otherwise, it is disabled unconditionally,
because the LCD is turned of literally in the registers during blank.
Reading those again on unblank will simply not reactivate the LCD, yet
DPMS was handled properly, leading me to wrong conclusions.

This adds a new variable to struct neo_par for storing a boolean whether
to read the register values next time we (un)blank. For some reason it
was not sufficient to check against !blank_mode while reading registers
in the beginning of neofb_blank().

Reworked patch against neofb.c having
neofb-avoid-resetting-display-config-on-unblank.patch applied.

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
+++ b/drivers/video/neofb.c	2006-02-11 11:39:39.346365480 +0100
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
@@ -1334,12 +1337,13 @@
 	struct neofb_par *par =3D (struct neofb_par *)info->par;
 	int seqflags, lcdflags, dpmsflags, reg;
=20
-	/*
-	 * Reload the value stored in the register, might have been changed via
-	 * FN keystroke
-	 */
-	par->PanelDispCntlReg1 =3D vga_rgfx(NULL, 0x20) & 0x03;
-
+	/* Reload the value stored in the register, if sensible. It might have be=
en
+	 * changed via FN keystroke. */
+	if (par->PanelDispCntlRegRead && !blank_mode) {
+		par->PanelDispCntlReg1 =3D vga_rgfx(NULL, 0x20) & 0x03;
+	}
+	par->PanelDispCntlRegRead =3D !blank_mode;
+=09
 	switch (blank_mode) {
 	case FB_BLANK_POWERDOWN:	/* powerdown - both sync lines down */
 		seqflags =3D VGA_SR01_SCREEN_OFF; /* Disable sequencer */

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ/LB612m8MprmeOlAQKqGw/+Onf/d85BnGV1jBs27k8/bCWxOAW0QVyl
AReeIuIhiOO0MgEG6LVmHVkAuFO4BhAuqccP5bxkWyuvPXwMpPP2ZaoivAN1Wtc0
odKOQRzPZeO9Yv4lryv2REAq9DIMm728O4oAGK8fYquP+k23qWJSvb2l+Hbq62DL
LXJHIHlymLmIlZic8w07Hm/oYD7Ac4+6taZ68If8wARFTV5d3jbc0O5YQZgu83qg
lQZbMZLKkbfo0isusILC7OLW3f8aGGjSEteynrxRgQGCVsX3M5t5WJz/OtgTw6MJ
HoOhWbl0Ry5ehJclEg5WdLWIRIvSk02cGVDEMVPeMLoK6fFcYIE3cA8xybE6v9j/
6P8P2Ah4SQEtqPBaR7pjVDNr2DUeW0DAK+EsMxLJXvCVFX90T3a+DRMSjxnJwl2g
6L9MXqW8Pcr4pGZ5hVg+Odxumh0BB2lrScZjN4YrKFWGorgb8TgevUmKGAlqKVDY
Qf1AeIeWteU6JELPLcaPP+ipUqcg815TeG2ItssdkIVGxPHF+12ZesrIjcdHJYAd
/6ZEaX96ohNQU/QAJiNHZLYrcYLfpagWCGhUGKr4tDJ2qJDjtJG25fUPT/Fa8/DF
ZxASgb3KsLpFBxxhRbf/dgHyJ28yWqd0iv/zqT/xPfBlWp7UAEbq/H2Ts7Wm8V0J
S4pdnmWkb/8=
=bDg6
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

