Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbULFQW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbULFQW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 11:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbULFQW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 11:22:28 -0500
Received: from lug-owl.de ([195.71.106.12]:9433 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261551AbULFQVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 11:21:54 -0500
Date: Mon, 6 Dec 2004 17:21:53 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
Message-ID: <20041206162153.GH16958@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <87acsrqval.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a58rN+WbXIGauCK9"
Content-Disposition: inline
In-Reply-To: <87acsrqval.fsf@coraid.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a58rN+WbXIGauCK9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-12-06 10:51:46 -0500, Ed L Cashin <ecashin@coraid.com>
wrote in message <87acsrqval.fsf@coraid.com>:
> The included patch allows the Linux kernel to use the ATA over
> Ethernet (AoE) network protocol to communicate with any block device
> that handles the AoE protocol.  The Coraid EtherDrive (R) Storage
> Blade is the first hardware using AoE.
>=20
> Like IP, AoE is an ethernet-level network protocol, registered with
> the IEEE.  Unlike IP, AoE is not routable.

So AoE is out of scope for many uses...

However, some comments:

> diff -urpN linux-2.6.9/drivers/block/Kconfig linux-2.6.9-aoe/drivers/bloc=
k/Kconfig
> --- linux-2.6.9/drivers/block/Kconfig	2004-11-30 08:22:33.000000000 -0500
> +++ linux-2.6.9-aoe/drivers/block/Kconfig	2004-12-06 10:40:00.000000000 -=
0500
> @@ -357,5 +357,6 @@ config LBD
>  	  bigger than 2TB.  Otherwise say N.
> =20
>  source "drivers/s390/block/Kconfig"
> +source "drivers/block/aoe/Kconfig"
> =20
>  endmenu
> diff -urpN linux-2.6.9/drivers/block/aoe/Kconfig linux-2.6.9-aoe/drivers/=
block/aoe/Kconfig
> --- linux-2.6.9/drivers/block/aoe/Kconfig	1969-12-31 19:00:00.000000000 -=
0500
> +++ linux-2.6.9-aoe/drivers/block/aoe/Kconfig	2004-12-06 10:40:00.0000000=
00 -0500
> @@ -0,0 +1,10 @@
> +#
> +# ATA over Ethernet configuration
> +#
> +config ATA_OVER_ETH
> +	tristate "ATA over Ethernet support"
> +	depends on NET
> +	default m
> +	help
> +	This driver provides Support for ATA over Ethernet block
> +	devices like the Coraid EtherDrive (R) Storage Blade.

Since your config only contains a single element, just put it into the
block device Kconfig.

> diff -urpN linux-2.6.9/drivers/block/aoe/all.h linux-2.6.9-aoe/drivers/bl=
ock/aoe/all.h
> --- linux-2.6.9/drivers/block/aoe/all.h	1969-12-31 19:00:00.000000000 -05=
00
> +++ linux-2.6.9-aoe/drivers/block/aoe/all.h	2004-12-06 10:40:00.000000000=
 -0500
[...]
> +#define nil NULL

It's not April 1st today :)

> +#define nelem(A) (sizeof (A) / sizeof (A)[0])

Just use ARRAY_SIZE()

> +#define AOE_MAJOR 152
> +#define ROOT_PATH "/dev/etherd/"
> +#define PATHLEN (strlen(ROOT_PATH) + 8)

Looks strangely hardcoded...

[many typedefs deleted]

Typedefs tend to make the code harder to read and understand. Why don't
you just use the struct xxx notation?

> diff -urpN linux-2.6.9/drivers/block/aoe/aoeblk.c linux-2.6.9-aoe/drivers=
/block/aoe/aoeblk.c
> --- linux-2.6.9/drivers/block/aoe/aoeblk.c	1969-12-31 19:00:00.000000000 =
-0500
> +++ linux-2.6.9-aoe/drivers/block/aoe/aoeblk.c	2004-12-06 10:40:00.000000=
000 -0500

> +static struct block_device_operations aoe_bdops =3D {
> +	open:			aoeblk_open,
> +	release:		aoeblk_release,
> +	ioctl:			aoeblk_ioctl,
> +	owner:			THIS_MODULE,
> +};

Please use C99 syntax:

	.open =3D aoeblk_open,

etc.


> +void
> +aoeblk_gdalloc(void *vp)
> +{
> +	if (gd =3D=3D nil) {

Could be shorter like "if (!gd) {"

> +void
> +aoeblk_exit(void)
> +{
> +	unregister_blkdev(AOE_MAJOR, DEVICE_NAME);
> +}
> +
> +int
> +aoeblk_init(void)
> +{
> +	int n;
> +
> +	n =3D register_blkdev(AOE_MAJOR, DEVICE_NAME);
> +	if (n < 0) {
> +		printk(KERN_ERR "aoe: aoeblk_init: can't register major\n");
> +		return n;
> +	}
> +	return 0;
> +}

__exit and __init are missing here.

> diff -urpN linux-2.6.9/drivers/block/aoe/aoechr.c linux-2.6.9-aoe/drivers=
/block/aoe/aoechr.c
> --- linux-2.6.9/drivers/block/aoe/aoechr.c	1969-12-31 19:00:00.000000000 =
-0500
> +++ linux-2.6.9-aoe/drivers/block/aoe/aoechr.c	2004-12-06 10:40:00.000000=
000 -0500
> +struct file_operations aoe_fops =3D {
> +	write:		aoechr_write,
> +	read: 		aoechr_read,
> +	open:		aoechr_open,
> +	release:  	aoechr_rel,
> +	owner:		THIS_MODULE,
> +};

C99

> +u16
> +nhget16(uchar *p)
> +{
> +	u16 n;
> +
> +	n =3D p[0];
> +	n <<=3D 8;
> +	return n |=3D p[1];
> +}
> +
> +u32
> +nhget32(uchar *p)
> +{
> +	u32 n;
> +
> +	n =3D nhget16(p);
> +	n <<=3D 16;
> +	return n |=3D nhget16(p+2);
> +}
> +
> +void
> +hnput16(uchar *p, u16 n)
> +{
> +	p[1] =3D n;
> +	p[0] =3D n >>=3D 8;
> +}
> +
> +void
> +hnput32(uchar *p, u32 n)
> +{
> +	hnput16(p+2, n);
> +	hnput16(p, n >>=3D 16);
> +}
> +
> +u16
> +lhget16(uchar *p)
> +{
> +	u16 n;
> +
> +	n =3D p[1];
> +	n <<=3D 8;
> +	return n |=3D p[0];
> +}
> +
> +u32
> +lhget32(uchar *p)
> +{
> +	u32 n;
> +
> +	n =3D lhget16(p+2);
> +	n <<=3D 16;
> +	return n |=3D lhget16(p);
> +}
> +
> +u64
> +lhget64(uchar *p)
> +{
> +	u64 n;
> +
> +	n =3D lhget32(p+4);
> +	n <<=3D 32;
> +	return n |=3D lhget32(p);
> +}

There are function available for this, look at the endianess header
files.


After all, especially keeping in mind that AoE isn't routeable, my
thinking is that this had better written as a (E)NBD server process
running in userspace. This way, you'd use the in-kernel NBD driver (or
the ENBD which isn't in the kernel) and you the the routing stuff for
free :)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--a58rN+WbXIGauCK9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBtIchHb1edYOZ4bsRAqZwAKCSYiYBkidFS+tWirm2G2FXbYQxWQCgiVFs
reglP0+YruRJNfWoh0Ac8lk=
=O4w7
-----END PGP SIGNATURE-----

--a58rN+WbXIGauCK9--
