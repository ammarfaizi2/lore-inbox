Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264404AbTEJPlL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 11:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbTEJPlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 11:41:11 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:38823 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S264404AbTEJPlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 11:41:09 -0400
Date: Sat, 10 May 2003 18:53:42 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Olivier Dragon <dragon@shadnet.shad.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linking error in sounddrivers.o (2.4.20)
Message-ID: <20030510155341.GA304@actcom.co.il>
References: <20030510012805.GA1037@dragon.homelinux.org> <20030510075220.GC31003@actcom.co.il> <20030510133029.GA10023@dragon.homelinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20030510133029.GA10023@dragon.homelinux.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2003 at 09:30:29AM -0400, Olivier Dragon wrote:
> On Sat, May 10, 2003 at 10:52:20AM +0300, Muli Ben-Yehuda wrote:
> > Does it still happen with 2.4.21-rc2? Also, could you please send me
> > in private the .config? I get a 504 gateway error when trying to wget
> > it.=20
> > That's a fairly experimental kernel for compiling kernels. You might
> > want to stick with 2.95 for the time being.=20
>=20
> Ok, I've compiled 2.4.21-rc2 (make dep; make bzImage) with 2.95 and I
> got rid of the compilation error (most likely gcc bug) but I still get
> the same linking error as previously mentioned. See below:

The linking error happens because you have=20

CONFIG_SOUND_TRIDENT=3Dy
and=20
CONFIG_INPUT_PCIGAME=3Dm=20

trident.c will call pcigame_attach(), which is either defined or a
nop, depending on whether CONFIG_INPUT_PCIGAME is defined or not. In
your .config it's defined, but as a module. So the call to
pcigame_attach() is trident is defined. But trident is built in, so
when the linker tries to link everything together, it fails because it
cannot find the code for pcigame_attach. It can't find it, since it's
compiled as a module, and thus not linked into the bzImage.=20

As a quick fix, you can either make trident a module, or make pcigame
built in, or remove pcigame, if you don't have a joystick
attached. This fairly ugly untested patch against 2.4.21-rc2 should
enforce the dependencies between trident and pcigame.=20

diff -Naur 2.4.21-rc2.vanilla/drivers/sound/Config.in 2.4.21-rc2.mx/drivers=
/sound/Config.in
--- 2.4.21-rc2.vanilla/drivers/sound/Config.in	2003-05-10 18:44:54.00000000=
0 +0300
+++ 2.4.21-rc2.mx/drivers/sound/Config.in	2003-05-10 18:40:15.000000000 +03=
00
@@ -70,7 +70,14 @@
     dep_tristate '  Au1000 Sound' CONFIG_SOUND_AU1000 $CONFIG_SOUND
 fi
=20
-dep_tristate '  Trident 4DWave DX/NX, SiS 7018 or ALi 5451 PCI Audio Core'=
 CONFIG_SOUND_TRIDENT $CONFIG_SOUND $CONFIG_PCI $CONFIG_INPUT_PCIGAME
+# This is fairly ugly. If pcigame is off, we have no dependency on it.=20
+# However, if it's on and modular, we need to be modular too=20
+if [ "$CONFIG_INPUT_PCIGAME" =3D "n" ]; then=20
+    dep_tristate '  Trident 4DWave DX/NX, SiS 7018 or ALi 5451 PCI Audio C=
ore' CONFIG_SOUND_TRIDENT $CONFIG_SOUND $CONFIG_PCI
+else=20
+    dep_tristate '  Trident 4DWave DX/NX, SiS 7018 or ALi 5451 PCI Audio C=
ore' CONFIG_SOUND_TRIDENT $CONFIG_SOUND $CONFIG_PCI $CONFIG_INPUT_PCIGAME
+fi=20
+
=20
 dep_tristate '  Support for Turtle Beach MultiSound Classic, Tahiti, Monte=
rey' CONFIG_SOUND_MSNDCLAS $CONFIG_SOUND
 if [ "$CONFIG_SOUND_MSNDCLAS" =3D "y" -o "$CONFIG_SOUND_MSNDCLAS" =3D "m" =
]; then
--=20
Muli Ben-Yehuda
http://www.mulix.org


--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+vSCFKRs727/VN8sRAtX9AJwL2FXgAJZHwujZFjf7nHM2I123dgCdGaHh
e1w5A7R1L4doobLq2MBlySY=
=xUeG
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
