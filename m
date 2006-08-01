Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWHAJdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWHAJdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbWHAJdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:33:14 -0400
Received: from kagl.donpac.ru ([80.254.111.32]:48099 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S932550AbWHAJdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:33:13 -0400
Date: Tue, 1 Aug 2006 13:33:14 +0400
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org
Subject: Re: [PATCH 1/3] add-imacfb-docu-and-detection.patch
Message-ID: <20060801093314.GB15168@pazke.donpac.ru>
Mail-Followup-To: Edgar Hucek <hostmaster@ed-soft.at>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org
References: <44CDBE5D.8020504@ed-soft.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <44CDBE5D.8020504@ed-soft.at>
X-Uname: Linux 2.6.8-12-amd64-k8 x86_64
User-Agent: Mutt/1.5.12-2006-07-14
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 212, 07 31, 2006 at 10:25:01AM +0200, Edgar Hucek wrote:
> This Patch add basic Machine detection to imacfb and
> some Ducumentation bits for imacfb.
>=20
> Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>
>=20
>=20
> diff -uNr linux-2.6.18-rc2/Documentation/fb/imacfb.txt linux-2.6.18-rc2.m=
actel/Documentation/fb/imacfb.txt
> --- linux-2.6.18-rc2/Documentation/fb/imacfb.txt	1970-01-01 01:00:00.0000=
00000 +0100
> +++ linux-2.6.18-rc2.mactel/Documentation/fb/imacfb.txt	2006-07-26 20:54:=
07.000000000 +0200
> @@ -0,0 +1,31 @@
> +
> +What is imacfb?
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This is a generic EFI platform driver for Intel based Apple computers.
> +Imacfb is only for EFI booted Intel Macs.
> +
> +Supported Hardware
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +iMac 17"/20"
> +Macbook
> +Macbook Pro 15"/17"
> +MacMini
> +
> +How to use it?
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Imacfb does not have any kind of autodetection of your machine.
> +You have to add the fillowing kernel parameters in your elilo.conf:
> +	Macbook :
> +		video=3Dimacfb:macbook
> +	MacMini :
> +		video=3Dimacfb:mini
> +	Macbook Pro 15", iMac 17" :
> +		video=3Dimacfb:i17
> +	Macbook Pro 17", iMac 20" :
> +		video=3Dimacfb:i20
> +
> +--
> +Edgar Hucek <gimli@dark-green.com>
> diff -uNr linux-2.6.18-rc2/drivers/video/imacfb.c linux-2.6.18-rc2.mactel=
/drivers/video/imacfb.c
> --- linux-2.6.18-rc2/drivers/video/imacfb.c	2006-07-16 10:38:27.000000000=
 +0200
> +++ linux-2.6.18-rc2.mactel/drivers/video/imacfb.c	2006-07-25 13:53:35.00=
0000000 +0200
> @@ -18,6 +18,8 @@
>  #include <linux/screen_info.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/dmi.h>
> +#include <linux/efi.h>
> =20
>  #include <asm/io.h>
> =20
> @@ -28,7 +30,7 @@
>  	M_I20,
>  	M_MINI,
>  	M_MACBOOK,
> -	M_NEW
> +	M_UNKNOWN
>  } MAC_TYPE;
> =20
>  /* ---------------------------------------------------------------------=
 */
> @@ -52,10 +54,36 @@
>  };
> =20
>  static int inverse;
> -static int model		=3D M_NEW;
> +static int model		=3D M_UNKNOWN;
>  static int manual_height;
>  static int manual_width;
> =20
> +static int set_system(struct dmi_system_id *id)

Missing __init ?

> +{
> +	printk(KERN_INFO "imacfb: %s detected - set system to %ld\n",
> +		id->ident, (long)id->driver_data);
> +=09
> +	model =3D (long)id->driver_data;
> +=09
> +	return 0;
> +}
> +
> +static struct dmi_system_id __initdata dmi_system_table[] =3D {
> +	{ set_system, "iMac4,1", {
> +	  DMI_MATCH(DMI_BIOS_VENDOR,"Apple Computer, Inc."),
> +	  DMI_MATCH(DMI_BIOS_VERSION,"iMac4,1") }, (void*)M_I17},
> +	{ set_system, "MacBookPro1,1", {
> +	  DMI_MATCH(DMI_BIOS_VENDOR,"Apple Computer, Inc."),
> +	  DMI_MATCH(DMI_BIOS_VERSION,"MacBookPro1,1") }, (void*)M_I17},
> +	{ set_system, "MacBook1,1", {
> +	  DMI_MATCH(DMI_BIOS_VENDOR,"Apple Computer, Inc."),
> +	  DMI_MATCH(DMI_PRODUCT_NAME,"MacBook1,1")}, (void *)M_MACBOOK},
> +	{ set_system, "Macmini1,1", {
> +	  DMI_MATCH(DMI_BIOS_VENDOR,"Apple Computer, Inc."),
> +	  DMI_MATCH(DMI_PRODUCT_NAME,"Macmini1,1")}, (void *)M_MINI},
> +	{},
> +};
> +
>  #define	DEFAULT_FB_MEM	1024*1024*16
> =20
>  /* ---------------------------------------------------------------------=
 */
> @@ -149,7 +177,6 @@
>  		screen_info.lfb_linelength =3D 1472 * 4;
>  		screen_info.lfb_base =3D 0x80010000;
>  		break;
> -	case M_NEW:
>  	case M_I20:
>  		screen_info.lfb_width =3D 1680;
>  		screen_info.lfb_height =3D 1050;
> @@ -207,6 +234,10 @@
>  		size_remap =3D size_total;
>  	imacfb_fix.smem_len =3D size_remap;
> =20
> +#ifndef __i386__
> +	screen_info.imacpm_seg =3D 0;
> +#endif
> +
>  	if (!request_mem_region(imacfb_fix.smem_start, size_total, "imacfb")) {
>  		printk(KERN_WARNING
>  		       "imacfb: cannot reserve video memory at 0x%lx\n",
> @@ -324,8 +355,16 @@
>  	int ret;
>  	char *option =3D NULL;
> =20
> -	/* ignore error return of fb_get_options */
> -	fb_get_options("imacfb", &option);
> +	if (!efi_enabled)
> +		return -ENODEV;
> +	if (!dmi_check_system(dmi_system_table))
> +		return -ENODEV;
> +	if (model =3D=3D M_UNKNOWN)
> +		return -ENODEV;
> +
> +	if (fb_get_options("imacfb", &option))
> +		return -ENODEV;
> +
>  	imacfb_setup(option);
>  	ret =3D platform_driver_register(&imacfb_driver);
> =20
> diff -uNr linux-2.6.18-rc2/drivers/video/Kconfig linux-2.6.18-rc2.mactel/=
drivers/video/Kconfig
> --- linux-2.6.18-rc2/drivers/video/Kconfig	2006-07-16 10:38:27.000000000 =
+0200
> +++ linux-2.6.18-rc2.mactel/drivers/video/Kconfig	2006-07-25 13:30:55.000=
000000 +0200
> @@ -552,7 +552,7 @@
> =20
>  config FB_IMAC
>  	bool "Intel-based Macintosh Framebuffer Support"
> -	depends on (FB =3D y) && X86
> +	depends on (FB =3D y) && X86 && EFI
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEzx/aPjHNUy6paxMRAvK0AJ9H7Kd4a1v2p1oKdJJj2kmhONEE0ACeLIxZ
XVaL7LAgNfACMZDs/WfVKpc=
=DeuI
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
