Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266067AbUGEMzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266067AbUGEMzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 08:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266065AbUGEMzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 08:55:39 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:22729 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S266067AbUGEMzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 08:55:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: watchdog infrastructure
Date: Mon, 5 Jul 2004 14:54:44 +0200
User-Agent: KMail/1.6.2
References: <200407011923.45226.arnd@arndb.de> <20040705093800.GB5726@infomag.infomag.iguana.be>
In-Reply-To: <20040705093800.GB5726@infomag.infomag.iguana.be>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_Y+U6A0LQOv0XuXh";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407051454.48340.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_Y+U6A0LQOv0XuXh
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Montag, 5. Juli 2004 11:38, you wrote:
> Did you have a look allready at the different watchdog operations in=20
> include/linux/watchdog.h ?

Yes, I already have a working driver, which does not use the
experimental infrastructure code. I'm just not allowed to
publish it until the hardware is available.

There are a couple of things I noticed about your new code:

=2D Is there any reason having an alloc_watchdogdev function in the
  common code? Simply statically allocating the structure in each
  device driver should be a lot simpler.
=2D Keeping watchdog_ops out of watchdog_device will simplify=20
  the lifetime rules. Just put them in the same structure, add an
  owner field and get rid of the *private field.
=2D watchdog_is_open_sem can just be an atomic_t, you never
  actually down() it.
=2D You need to get the module reference count before calling any
  watchdog operation, the best place for this is probably the
  open() fop.
=2D Maybe its easier to always register the misc devices when
  watchdog.ko is loaded, and then deny opening them when no
  actual watchdog driver is registered to it.
=2D Why do you need seperate operations for start and keepalive?
=2D the reboot notifier and the nowayout parameter are probably
  common enough to be put into the generic module.

	Arnd <><

--Boundary-02=_Y+U6A0LQOv0XuXh
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA6U+X5t5GS2LDRf4RAvKjAJ9ycehpPek7kr9Ru9ShZDcJb7LYqQCcCp73
gRqmMRvcCzeAedHiii0oR1g=
=Fmor
-----END PGP SIGNATURE-----

--Boundary-02=_Y+U6A0LQOv0XuXh--
