Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbTI1X3r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTI1X3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:29:13 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:36803 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262766AbTI1X1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:27:31 -0400
Date: Mon, 29 Sep 2003 02:27:19 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, rwhron@earthlink.net,
       Jaroslav Kysela <perex@suse.cz>
Subject: Re: [2.6.0-test6] ALSA: Trident (sis7018) depends on gameport?
Message-ID: <20030928232719.GT729@actcom.co.il>
References: <1064778653.1466.7.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cbvl/UgeRTPlujdB"
Content-Disposition: inline
In-Reply-To: <1064778653.1466.7.camel@paragon.slim>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Cbvl/UgeRTPlujdB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2003 at 09:50:53PM +0200, Jurgen Kramer wrote:

> I've just tried 2.6.0-test6 on my SIS630 based PIII-M laptop. I was
> unable to select the trident ALSA driver for my sis7018 built in sound.
> Further investigation revealed it now all of a sudden depends on the
> game port being selected as well. My laptop doesn't have a game port at
> all so I never built game port drivers.

Looks like the change that broke it for you is the last change in
sound/pci/Kconfig, from a dependency on SOUND_GAMEPORT to a dependency
on GAMEPORT.=20

CONFIG_SOUND_GAMEPORT is an odd beast. I think it exists because of
the the following situation:=20

If gameport is N, it provides empty dummy functions for a sound driver
using it, which compiles and links fine, both builtin and as a
module.=20

If gameport is Y, it provides real functions for the code using it,
regardless of whether that code is builtin or a module.=20

But - if gameport is M, and our sound driver is builtin, you will get
unresolved dependencies when linking the sound driver into the kernel,
because the sound driver needs the function definitions from gameport
in order to compile.

CONFIG_GAMEPORT_SOUND is meant to handle that situation. It is defined
in drivers/sound/gameport/Kconfig as=20

config SOUND_GAMEPORT
       tristate
       default y if GAMEPORT!=3Dm
       default m if GAMEPORT=3Dm

So if you choose GAMEPORT=3Dm, SOUND_GAMEPORT will be m as well, and
then the sound driver that depends on SOUND_GAMEPORT will be forced to
m as well.

ALSA, and specifically snd_trident, handles the problem
differently. Instead of using the build system dependencies, the code
that uses the gameport interface has=20

#if defined(CONFIG_GAMEPORT) || (defined(MODULE) &&
defined(CONFIG_GAMEPORT_MODULE))

which achieved the same purpose, but is uglier, IMHO.=20

> Is the trident driver really dependable om the gameport? What can be a
> solution here?

I don't think it is, due to the #defines above. Try this: =20

Index: sound/pci/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux-2.5/sound/pci/Kconfig,v
retrieving revision 1.8
diff -u -u -r1.8 Kconfig
--- sound/pci/Kconfig	26 Sep 2003 00:23:18 -0000	1.8
+++ sound/pci/Kconfig	28 Sep 2003 21:37:52 -0000
@@ -83,7 +83,7 @@
=20
 config SND_TRIDENT
 	tristate "Trident 4D-Wave DX/NX; SiS 7018"
-	depends on SND && GAMEPORT
+	depends on SND
 	help
 	  Say 'Y' or 'M' to include support for Trident 4D-Wave DX/NX and
 	  SiS 7018 soundcards.
--=20
Muli Ben-Yehuda
http://www.mulix.org


--Cbvl/UgeRTPlujdB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/d25XKRs727/VN8sRAjuaAJ0f4kgPYG4KJjUryEtEP8MeS5fISwCfUJN2
9t5mcWxh6NffDUtQJ8zOsnM=
=wo62
-----END PGP SIGNATURE-----

--Cbvl/UgeRTPlujdB--
