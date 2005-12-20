Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVLTPw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVLTPw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVLTPw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:52:29 -0500
Received: from mivlgu.ru ([81.18.140.87]:918 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751104AbVLTPw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:52:28 -0500
Date: Tue, 20 Dec 2005 18:52:16 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Ricardo Cerqueira <v4l@cerqueira.org>,
       mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
Message-ID: <20051220155216.GA19797@master.mivlgu.local>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051220131810.GB6789@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20051220131810.GB6789@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2005 at 02:18:10PM +0100, Adrian Bunk wrote:
> 2.6.15-rc6 doesn't boot on my computer with an Oops that has=20
> drivers/media/video/saa7134/saa7134-alsa.c prominently in it's trace.
>=20
> A picture of the Oops is at [1] (I won't get a price for the best=20
> picture for it, but it's readable...).

saa7134-alsa is trying to initialize before the ALSA core has initialized.
Probably no one has tested CONFIG_VIDEO_SAA7134=3Dy.

There is some more brokenness there:

1) With CONFIG_VIDEO_SAA7134=3Dy, both saa7134-alsa.o and saa7134-oss.o will
be built into the kernel, but only the first of them has any chance to be
used - the second will stay as dead code.

2) Both saa7134-alsa and saa7134-oss set dmasound_init and dmasound_exit
function pointers to their functions (for handling of saa7134 cards
hotplugged later), but they do not reset these pointers on unload -
therefore if you load one of these modules, then unload it, then try to
hotplug a saa7134-based card (apparently there are CardBus
implementation), you will get oopses.  These assignments in saa7134-alsa
and saa7134-oss also stomp on each other.

> Kernels up to 2.6.14.4 boot fine, 2.6.15-rc1 is the one that introduced=
=20
> the problem.
>=20
> I must give saa7134.card=3D6 at the lilo prompt for getting my card=20
> working.

-ECHEAPHARDWARE (sadly, boards without EEPROM are too common).

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDqCiwW82GfkQfsqIRAh5uAJ9mIExZsyqvZjDg0npmkflzZdXVkACeMwXJ
DQxOeDQT568GbbuNYB9/PcU=
=US1j
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
