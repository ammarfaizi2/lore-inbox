Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSFRRns>; Tue, 18 Jun 2002 13:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317520AbSFRRnr>; Tue, 18 Jun 2002 13:43:47 -0400
Received: from adsl-66-127-87-238.dsl.sntc01.pacbell.net ([66.127.87.238]:2214
	"HELO Developer.ChaoticDreams.ORG") by vger.kernel.org with SMTP
	id <S317517AbSFRRnp>; Tue, 18 Jun 2002 13:43:45 -0400
Date: Tue, 18 Jun 2002 10:43:40 -0700
From: Paul Mundt <lethal@ChaoticDreams.ORG>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Martin Diehl <lists@mdiehl.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.22: FB_VESA - early crash in fbcon_cursor()
Message-ID: <20020618104340.A1671@ChaoticDreams.ORG>
References: <20020618083829.A316@ChaoticDreams.ORG> <Pine.LNX.4.44.0206181009580.5510-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.LNX.4.44.0206181009580.5510-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Tue, Jun 18, 2002 at 10:15:08AM -0700
Organization: Chaotic Dreams Development Team
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2002 at 10:15:08AM -0700, James Simmons wrote:
> Your right. Alot of people have been bitten by that. Especially since
> people are so use to manually setting the CFB stuff. Patch applied to BK
> tree.
>=20
Looks like I was a bit hasty with the patch .. fbcon_accel won't resolve if
fbcon-accel.c isn't linked in, which in turn won't happen unless
CONFIG_FBCON_ACCEL is set. Can we just do something like the attached inste=
ad
(in addition to killing the ifdef in fbgen.c..)?

Regards,

--=20
Paul Mundt <lethal@chaoticdreams.org>

--- linux-fbdev-2.5/drivers/video/Config.in	Tue Jun 18 13:39:49 2002
+++ linux-fbdev-2.5/drivers/video/Config.in	Tue Jun 18 13:40:51 2002
@@ -220,7 +220,6 @@
       tristate '    16 bpp packed pixels support' CONFIG_FBCON_CFB16
       tristate '    24 bpp packed pixels support' CONFIG_FBCON_CFB24
       tristate '    32 bpp packed pixels support' CONFIG_FBCON_CFB32
-      tristate '    Hardware acceleration support' CONFIG_FBCON_ACCEL
       tristate '    Amiga bitplanes support' CONFIG_FBCON_AFB
       tristate '    Amiga interleaved bitplanes support' CONFIG_FBCON_ILBM
       tristate '    Atari interleaved bitplanes (2 planes) support' CONFIG=
_FBCON_IPLAN2P2
@@ -363,22 +362,6 @@
 	    define_tristate CONFIG_FBCON_CFB32 m
 	 fi
       fi
-      if [ "$CONFIG_FB_NEOMAGIC" =3D "y" -o "$CONFIG_FB_VESA" =3D "y" -o \
-	   "$CONFIG_FB_FM2" =3D "y" -o "$CONFIG_FB_HIT" =3D "y" -o \
-	   "$CONFIG_FB_HP300" =3D "y" -o "$CONFIG_FB_Q40" =3D "y" -o \
-	   "$CONFIG_FB_ANAKIN" =3D "y" -o "$CONFIG_FB_G364" =3D "y" -o \
-	   "$CONFIG_FB_VIRTUAL" =3D "y" -o "$CONFIG_FB_CLPS711X" =3D "y" -o \
-	   "$CONFIG_FB_PMAG_BA" =3D "y" -o "$CONFIG_FB_PMAGB_B" =3D "y" -o \
-	   "$CONFIG_FB_3DFX" =3D "y" -o "$CONFIG_FB_TX3912" =3D "y" -o \
-	   "$CONFIG_FB_MAXINE" =3D "y" -o "$CONFIG_FB_APOLLO" =3D "y" ]; then
-	 define_tristate CONFIG_FBCON_ACCEL y
-      else
-	 if [ "$CONFIG_FB_NEOMAGIC" =3D "m" -o "$CONFIG_FB_HIT" =3D "m" -o \
-	      "$CONFIG_FB_G364" =3D "m" -o "$CONFIG_FB_VIRTUAL" =3D "m" -o \
-	      "$CONFIG_FB_CLPS711X" =3D "m" -o "$CONFIG_FB_3DFX" =3D "m" ]; then=
=20
-	    define_tristate CONFIG_FBCON_ACCEL m
-         fi      =20
-      fi
       if [ "$CONFIG_FB_AMIGA" =3D "y" ]; then
 	 define_tristate CONFIG_FBCON_AFB y
 	 define_tristate CONFIG_FBCON_ILBM y
--- linux-fbdev-2.5/drivers/video/Makefile	Tue Jun 18 13:39:45 2002
+++ linux-fbdev-2.5/drivers/video/Makefile	Tue Jun 18 13:40:13 2002
@@ -33,7 +33,7 @@
 obj-$(CONFIG_FONT_ACORN_8x8)      +=3D font_acorn_8x8.o
=20
 # Add fbmon.o back into obj-$(CONFIG_FB) in 2.5.x
-obj-$(CONFIG_FB)                  +=3D fbmem.o fbcmap.o modedb.o fbcon.o f=
onts.o fbgen.o
+obj-$(CONFIG_FB)                  +=3D fbmem.o fbcmap.o modedb.o fbcon.o f=
onts.o fbgen.o fbcon-accel.o
 # Only include macmodes.o if we have FB support and are PPC
 ifeq ($(CONFIG_FB),y)
 obj-$(CONFIG_PPC)                 +=3D macmodes.o
@@ -122,7 +122,6 @@
 obj-$(CONFIG_FBCON_VGA)           +=3D fbcon-vga.o
 obj-$(CONFIG_FBCON_HGA)           +=3D fbcon-hga.o
 obj-$(CONFIG_FBCON_STI)           +=3D fbcon-sti.o
-obj-$(CONFIG_FBCON_ACCEL)	  +=3D fbcon-accel.o
=20
 include $(TOPDIR)/Rules.make
=20
--- linux-fbdev-2.5/drivers/video/fbcon-accel.h	Tue Jun 18 13:41:56 2002
+++ linux-fbdev-2.5/drivers/video/fbcon-accel.h	Tue Jun 18 13:42:10 2002
@@ -5,18 +5,6 @@
 #ifndef _VIDEO_FBCON_ACCEL_H
 #define _VIDEO_FBCON_ACCEL_H
=20
-#include <linux/config.h>
-
-#ifdef MODULE
-#if defined(CONFIG_FBCON_ACCEL) || defined(CONFIG_FBCON_ACCEL_MODULE)
-#define FBCON_HAS_ACCEL
-#endif
-#else
-#if defined(CONFIG_FBCON_ACCEL)
-#define FBCON_HAS_ACCEL
-#endif
-#endif
-
 extern struct display_switch fbcon_accel;
 extern void fbcon_accel_setup(struct display *p);
 extern void fbcon_accel_bmove(struct display *p, int sy, int sx, int dy,

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj0PcUsACgkQYLvqhoOEA4EFQQCfZy1IXyKIGg5W2KAw4cXib9Gl
cewAn1UrNr/yCSCQZlEqksOts7sRz/dm
=95vW
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
