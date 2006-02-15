Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423038AbWBOImj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423038AbWBOImj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 03:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423039AbWBOImj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 03:42:39 -0500
Received: from mail.gmx.de ([213.165.64.21]:39079 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423038AbWBOImj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 03:42:39 -0500
X-Authenticated: #2308221
Date: Wed, 15 Feb 2006 09:42:35 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, adaplas@pol.net,
       linux-fbdev-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 24/24] neofb: avoid resetting display config on unblank
Message-ID: <20060215084235.GA10220@zeus.uziel.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20060214215943.37902fc4.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

first of all, my apologies for this mess. Finally, I got things right
wrt. the driver, now let me see if I can submit the patch properly, for
once : /


On Tue, Feb 14, 2006 at 09:59:43PM -0800, Andrew Morton wrote:
> The earlier patch has already been merged.  Please check that the version
> which I merged into -mm still makes sense.
>=20
> The above isn't a very good changelog entry.  It doesn't tell us what
> problem the patch fixes and it doesn't tell us how it fixes it.

Thanks for the slap. Here goes:

Actually, there were two mistakes in the register-read-on-(un)blank
approach.

- First, without proper register (un)locking the value read back will
  always be zero, and this is what I missed entirely until just now. Due
  to this, the logic could not be verified at all and I tried some bogus
  checks which are completely stupid.

- Second, the LCD status bit will always be set to zero when the
  backlight has been turned off. Reading the value back during unblank
  will disable the LCD unconditionally, regardless of the state it is
  supposed to be in, since we set it to zero beforehand.


So this is what we do now:

- create a new variable in struct neofb_par, and use that to determine
  whether to read back registers (initialized to true)

- before actually blanking the screen, read back the register to sense
  any possible change made through Fn key combo

- use proper neoUnlock() / neoLock() to actually read something

- every call to neofb_blank() determines if we read back next time:
  blanking disables readback, unblanking (FB_BLANK_UNBLANK) enables it


This should give us a nice and clean state machine. Has been thoroughly
tested on a Dell Latitude CPiA / NM220 Chip docked to a C/Dock2 with
attached CRT in all possible combinations of LCD/CRT on/off. I changed
the config via Fn key, let the console blank, unblanked by keypress -
works flawlessly.


Below patch applies against what should currently be in Linus' tree, as
my previous error-prone attempt has already been merged. I'd call this
neofb-read-display-config-properly.patch as it applies on top of my
previous already-merged mess.

Andrew, please discard any other patches of mine still in -mm, this
would be the solution to this issue unless somebody else finds a
problem.

The only problem left wrt. neofb AFAICS would be the initialization of
CRT-only resulting in no signal being received by the monitor. This is
in no way changed by any of my patches.=20


> "Signed-off-by:", please.

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
--- a/drivers/video/neofb.c	2006-02-15 06:27:58.000000000 +0100
+++ b/drivers/video/neofb.c	2006-02-15 08:56:14.295858976 +0100
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
@@ -1334,12 +1337,16 @@
 	struct neofb_par *par =3D (struct neofb_par *)info->par;
 	int seqflags, lcdflags, dpmsflags, reg;
=20
-	/*
-	 * Reload the value stored in the register, might have been changed via
-	 * FN keystroke
-	 */
-	par->PanelDispCntlReg1 =3D vga_rgfx(NULL, 0x20) & 0x03;
=20
+	/* Reload the value stored in the register, if sensible. It might have
+	 * been changed via FN keystroke. */
+	if (par->PanelDispCntlRegRead) {
+		neoUnlock();
+		par->PanelDispCntlReg1 =3D vga_rgfx(NULL, 0x20) & 0x03;
+		neoLock(&par->state);
+	}
+	par->PanelDispCntlRegRead =3D !blank_mode;
+=09
 	switch (blank_mode) {
 	case FB_BLANK_POWERDOWN:	/* powerdown - both sync lines down */
 		seqflags =3D VGA_SR01_SCREEN_OFF; /* Disable sequencer */

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ/Lpel2m8MprmeOlAQJwvRAAuhmIeEDlQ+xuNN2kBay3Ujd7T4v2t86e
PlTJNFsb1Q8ve0xnHdYZT6/2YT0EyR4HofHVbw1KP+lJpcwHjHG3ckL5wIrPMABJ
cZNugIsUFdV7awvolgIOIUbCTmNf//+Z7ECksH5Xefn58ZkqIkNr272yLj7cu72e
ddFC33iszA0VhFwm/86Ya+L/nF+68E1lxAM31Yp4qn9m5wn22QYgNbUrn92S6EB+
ZMJTm0SLYJPSCoRODKSetbskuAckp5MpiB1xRSeIM2HztnIfHqUNut+q4KexrGiD
FQOUGCvvdQyDhEvgiM/RU13rJSrNZWs4vgWmSuYnRBERjisToDhb4AJbqTALCmBb
Vfza9dDZ2m1mM8XPbrLqHNnsn2y83sC3DfO+PdyyE2t8xQRf73inBs4uaFLFDHL9
VNk5Y7pMSfh2KGhKg2sQDhmaZh/ZW2dfIjhpT+xZaOcK1Hiz+jxd2yUUOF+tc35l
UDzA6KFTURxGbib3Bsp34dxkpD3FbjMrr8HXoUg1iD1H42vsDFXX1nBUrVHhZUuM
r1mbNEOE6OT7LV9Av/GBa9gCiVReI5kx/IFy+vCkka4lvf16mxLAmdaQsvqYFflt
x/3nDfLhPz9tLp5DehRWiLv5IDorxBQHrOzYzAWSMmoJcgwsbJn26joixSfaWz+w
M2WXmwlVMMA=
=ECgo
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

