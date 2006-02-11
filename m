Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWBKKnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWBKKnB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 05:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWBKKnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 05:43:01 -0500
Received: from mail.gmx.net ([213.165.64.21]:43656 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751330AbWBKKnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 05:43:00 -0500
X-Authenticated: #2308221
Date: Sat, 11 Feb 2006 11:42:54 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] neofb: add more logic to determine sensibility of register readback
Message-ID: <20060211104253.GA13789@hermes.uziel.local>
References: <20060208202207.GA26682@zeus.uziel.local> <20060210113616.GA17482@hermes.uziel.local> <43EC7EA7.5030105@gmail.com> <632EF49A-33EB-4FAE-B2E2-F36446F9C8B6@mac.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <632EF49A-33EB-4FAE-B2E2-F36446F9C8B6@mac.com>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2006 at 11:41:34AM -0500, Kyle Moffett wrote:
> On Feb 10, 2006, at 06:53, Antonino A. Daplas wrote:
> >Christian Trefzer wrote:
> >>+		par->PanelDispCntlRegRead =3D 0;
> >>+		par->PanelDispCntlRegRead =3D 0;
> >>+		par->PanelDispCntlRegRead =3D 0;
> >>+		par->PanelDispCntlRegRead =3D 0;
> >>+		par->PanelDispCntlRegRead =3D 1;
> >
> >You can save a few lines by
> >
> >par->PanelDispCntlRegRead =3D (blank_mode) ? 0 : 1;
>=20
> How about the really simple so-obvious-its-impossible-to-misread =20
> solution?
>=20
> par->PanelDispCntlRegRead =3D !blank_mode;

Where is my mind..?

Sure, why not. Guess I had my head too much in the smoke clouds of not
knowing why a dead-sure-to-work implementation still would not do the
right thing, I already thought I got the C representation of true and
false wrong. Even Tony's hint would be clearer than my code, but that
can in turn be condensed into something really obvious. It's just a
negation, after all. Silly me.

Changed patch below. Should be the final one now, right?

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
+	par->PanelDispCntlRegRead =3D !blank_mode;
 =09
 	switch (blank_mode) {
 	case FB_BLANK_POWERDOWN:	/* powerdown - both sync lines down */

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ+2/rF2m8MprmeOlAQJo1BAAp7KWrA3POTybpf28Dv7KkS17pnKecYKU
3eh7PHYIJInkMpRrolIf/6k9aFGo9E//Czi7JLUvfNzz8BM5X2J2ByAaM2uHzPad
BRWmHwus8fetLFX+CPSh0cx4nRVxAvxcSL7bWAnwpIOZ/kFF4MBPLTMG8TP2w09a
bNMA1v1GHUPx6FU4ReWpt4L0ruaBc4ywGtDeHe6QGp4JofEvY9ZdXp7RlEiLKdni
u1Gc3algEf7AlgArSWYxofijZ1oaOZDJYHaOmFOJ5LUAyYOtapR/O+2fnxM34B4C
1K2RQelhYJIWnKGtsqH9sXvaoHKk57Rh+v2OrRZgfQn6d4NL+RdohsgGizHDoCpW
QiSZuIpx+PyZvCq4DMdNgW7kL4mRolJwMlTudvfPUPbEgqq/Q1/vOWCZzgwtmk3Z
uPv57eLuSH4qt/mD8DDd7oBoLnWzTiFA5vRAEJQBX2OgLmx/dNwcMYZXAEApbLOs
62syGOLHShCmjIK3rORbOAZW55Z4sal3XAOQ/X81MQqu0CUQvyaU776CG2JKIT3s
IZ6BhtnPxbX+fcw5PUROori6XKuhiRnBJzh4aOA+UqQ5hEtfYO1zF68hBwyk2OCg
6P+tRmuF1pwaJvCa6vJQjjlgemCVVzt79XRzeZ85IL6wqr8AG9Uvil0IUd7isQOM
7qQnfXMu4ng=
=+nuc
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

