Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265709AbUAKAXU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 19:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265710AbUAKAXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 19:23:20 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:64689 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S265709AbUAKAXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 19:23:17 -0500
Date: Sat, 10 Jan 2004 16:23:04 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: USB hangs
Message-ID: <20040111002304.GE16484@one-eyed-alien.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	USB Developers <linux-usb-devel@lists.sourceforge.net>,
	Greg KH <greg@kroah.com>
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Where is USB kmalloc'ing with GFP_KERNEL?  I thought we tracked all those
down and eliminated them.

Matt

On Sun, Jan 11, 2004 at 12:07:17AM +0000, Alan Cox wrote:
> With the various fixes people had been posting USB storage
> writing was still hanging repeatedly when doing a 20Gb rsync
> to usb-storage disks with a low memory system. Doing things
> like while(true) sync() made it hang even more often.
>=20
> After a bit of digging the following seems to fix it
>=20
> Not sure if 2.6 needs this as well.
>=20
> The failure path seems to be
>=20
> 	->scsi_done in the USB storage thread
> 	issues a new command
> 	causes USB to kmalloc GFP_KERNEL
> 	causes a page out
> 	queues a page out to the USB storage thread
> 	Deadlock.
>=20
> Setting PF_MEMALLOC should stop the storage thread ever causing pageout
> itself so deadlocking.
>=20

> --- drivers/usb/storage/usb.c~	2004-01-09 02:06:35.000000000 +0000
> +++ drivers/usb/storage/usb.c	2004-01-09 02:06:35.000000000 +0000
> @@ -332,6 +332,8 @@
> =20
>  	/* set our name for identification purposes */
>  	sprintf(current->comm, "usb-storage-%d", us->host_number);
> +=09
> +	current->flags |=3D PF_MEMALLOC;
> =20
>  	unlock_kernel();
> =20


--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Your lips are twitching.  You're playing Quake aren't you.
					-- Stef to Greg
User Friendly, 8/11/1998

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAAJdoIjReC7bSPZARAqr8AJ4kYJGXA260qSADWEpDMso9IjfbhgCeMeAq
sk6nY1YtO0rNtpzvF7FJzLE=
=JIS1
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
