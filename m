Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317452AbSFRPif>; Tue, 18 Jun 2002 11:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317453AbSFRPie>; Tue, 18 Jun 2002 11:38:34 -0400
Received: from adsl-66-127-87-238.dsl.sntc01.pacbell.net ([66.127.87.238]:11684
	"HELO Developer.ChaoticDreams.ORG") by vger.kernel.org with SMTP
	id <S317452AbSFRPie>; Tue, 18 Jun 2002 11:38:34 -0400
Date: Tue, 18 Jun 2002 08:38:29 -0700
From: Paul Mundt <lethal@ChaoticDreams.ORG>
To: Martin Diehl <lists@mdiehl.de>
Cc: linux-kernel@vger.kernel.org, jsimmons@transvirtual.com
Subject: Re: 2.5.22: FB_VESA - early crash in fbcon_cursor()
Message-ID: <20020618083829.A316@ChaoticDreams.ORG>
References: <Pine.LNX.4.21.0206181001300.1798-100000@notebook.diehl.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.LNX.4.21.0206181001300.1798-100000@notebook.diehl.home>; from lists@mdiehl.de on Tue, Jun 18, 2002 at 12:31:29PM +0200
Organization: Chaotic Dreams Development Team
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Tue, Jun 18, 2002 at 12:31:29PM +0200, Martin Diehl wrote:
> no luck here getting 2.5.22 to boot on my ob800 with vesafb enabled.
> Same with 2.5.21. Last one working was 2.5.16 but I haven't tried 17-20.
> Box oopses due to NULL-pointer dereference during inital fbdev setup.
>=20
> config, dmesg + decoded dump from serial console below.
>=20
<snip>

> Code: 8b 40 18 85 c0 74 4a 66 8b 7f 2c 89 ea 66 89 bb e4 00 00 00=20
> Error (Oops_bfd_perror): set_section_contents Bad value
>=20
> >>EIP; c0192baf <fbcon_cursor+6f/200>   <=3D=3D=3D=3D=3D
> Trace; c0177281 <hide_cursor+81/90>
> Trace; c017a79c <vt_console_print+8c/310>
<snip>

Looks like the dispsw isn't being set and you're running into the NULL
dereference in fbcon_cursor() upon trying to dereference it.. it looks like
fbgen.c is the culprit here, as it never sets display->dispsw if we aren't =
in
24-bpp or have FBCON_HAS_ACCEL set..

James, what's the point of th FBCON_HAS_ACCEL ifdef? It looks like all the
accel wrapper code does is provide a wrapper to the fillrect, imageblit, and
copyarea routines -- if the driver doesn't have accelerated ones to provide
for itself, it just uses the cfb_fillrect/imageblit/copyarea as a fallback,
thus it should _always_ be safe to call them.

If that's not the case, we'll have to re-introduce the FBON_CAS_CFBx
brain-damage in gen_set_disp() to keep dispsw happy.

Regards,

--=20
Paul Mundt <lethal@chaoticdreams.org>

--- linux-fbdev-2.5/drivers/video/fbgen.c	Tue Jun 18 11:37:46 2002
+++ linux-fbdev-2.5/drivers/video/fbgen.c	Tue Jun 18 11:37:59 2002
@@ -452,10 +452,9 @@
 #endif
 	}
=20
-#ifdef FBCON_HAS_ACCEL
 	display->scrollmode =3D SCROLL_YNOMOVE;
 	display->dispsw =3D &fbcon_accel;
-#endif
+
 	return;
 }
=20

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj0PU/MACgkQYLvqhoOEA4F/qgCfesR45maibrDygMKT7c+h2FFZ
XesAn2PDQcm61kQlO61rjXLfRfic9UyE
=9bAd
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
