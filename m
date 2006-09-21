Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWIUSbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWIUSbF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWIUSbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:31:05 -0400
Received: from master.altlinux.org ([62.118.250.235]:60433 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751348AbWIUSbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:31:02 -0400
Date: Thu, 21 Sep 2006 22:30:35 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: iSteve <isteve@rulez.cz>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: broken modules.alias entries for some USB devices
Message-Id: <20060921223035.c5fda02d.vsu@altlinux.ru>
In-Reply-To: <20060921165424.139138e5@silver>
References: <20060920185301.21dcf9bc@silver>
	<20060920102248.ebb55960.rdunlap@xenotime.net>
	<20060921165424.139138e5@silver>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.10.2; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__21_Sep_2006_22_30_35_+0400_QJgnhOoTe6Z6Qjl8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__21_Sep_2006_22_30_35_+0400_QJgnhOoTe6Z6Qjl8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Sep 2006 16:54:24 +0200 iSteve wrote:

> I've got one more question, this time regarding modules.usbmap.
>=20
> -modules.usbmap:
> ibmcam 0x000f 0x0545 0x8080 0x0002 0x0002 0x00 0x00 0x00 0x00 0x00 0x00 0=
x0
> ibmcam 0x000f 0x0545 0x8080 0x030a 0x030a 0x00 0x00 0x00 0x00 0x00 0x00 0=
x0
> ibmcam 0x000f 0x0545 0x8080 0x0301 0x0301 0x00 0x00 0x00 0x00 0x00 0x00 0=
x0
> ibmcam 0x000f 0x0545 0x8002 0x030a 0x030a 0x00 0x00 0x00 0x00 0x00 0x00 0=
x0
> ibmcam 0x000f 0x0545 0x800c 0x030a 0x030a 0x00 0x00 0x00 0x00 0x00 0x00 0=
x0
> ibmcam 0x000f 0x0545 0x800d 0x030a 0x030a 0x00 0x00 0x00 0x00 0x00 0x00 0=
x0
> -EOF
>=20
> -With corresponding aliases:
> alias usb:v0545p8080d0002dc*dsc*dp*ic*isc*ip* ibmcam
> alias usb:v0545p8080d030[10-9]dc*dsc*dp*ic*isc*ip* ibmcam
> alias usb:v0545p8080d0301dc*dsc*dp*ic*isc*ip* ibmcam
> alias usb:v0545p8002d030[10-9]dc*dsc*dp*ic*isc*ip* ibmcam
> alias usb:v0545p800Cd030[10-9]dc*dsc*dp*ic*isc*ip* ibmcam
> alias usb:v0545p800Dd030[10-9]dc*dsc*dp*ic*isc*ip* ibmcam
> -EOF
>=20
> I absolutely do not understand the d030[10-9], where fields bcdDevice_lo =
and
> bcdDevice_hi are 0x030a...

This surely looks like a bug.

> Looking at drivers/usb/core/usb.c, it'd seem that the MODALIAS sent upon =
device
> event doesn't have anything like this -- it would have "[...]d030A[...]".=
 So I
> wonder, how it got generated?

scripts/mod/file2alias.c generates these lines from the ID tables.

> -The relevant items in ibmcam.c:
> static struct usb_device_id id_table[] =3D {
>         { USB_DEVICE_VER(IBMCAM_VENDOR_ID, IBMCAM_PRODUCT_ID, 0x0002, 0x0=
002) },
>         { USB_DEVICE_VER(IBMCAM_VENDOR_ID, IBMCAM_PRODUCT_ID, 0x030a, 0x0=
30a) },
>         { USB_DEVICE_VER(IBMCAM_VENDOR_ID, IBMCAM_PRODUCT_ID, 0x0301, 0x0=
301) },
>         { USB_DEVICE_VER(IBMCAM_VENDOR_ID, NETCAM_PRODUCT_ID, 0x030a, 0x0=
30a) },
>         { USB_DEVICE_VER(IBMCAM_VENDOR_ID, VEO_800C_PRODUCT_ID, 0x030a, 0=
x030a) },
>         { USB_DEVICE_VER(IBMCAM_VENDOR_ID, VEO_800D_PRODUCT_ID, 0x030a, 0=
x030a) },

The problem is that the bcdDevice field is supposed to be BCD - i.e.,
its hex representation should contain only decimal digits 0..9.
Therefore a proper USB device cannot have bcdDevice =3D=3D 0x030a.
Apparently some ibmcam devices violate this and use the bcdDevice field
as if it was binary.

>         { }
> };
> -EOF
>=20
> -And the resulting alias part of modinfo:
> alias: usb:v0545p8080d0002dc*dsc*dp*ic*isc*ip*
> alias: usb:v0545p8080d030[10-9]dc*dsc*dp*ic*isc*ip*
> alias: usb:v0545p8080d0301dc*dsc*dp*ic*isc*ip*
> alias: usb:v0545p8002d030[10-9]dc*dsc*dp*ic*isc*ip*
> alias: usb:v0545p800Cd030[10-9]dc*dsc*dp*ic*isc*ip*
> alias: usb:v0545p800Dd030[10-9]dc*dsc*dp*ic*isc*ip*

The code in scripts/mod/file2alias.c assumes that the bcdDevice_lo and
bcdDevice_hi field contain proper BCD data.  Seems that, thanks to buggy
hardware, this assumption is incorrect, and the code needs to support
any hex numbers there.

--Signature=_Thu__21_Sep_2006_22_30_35_+0400_QJgnhOoTe6Z6Qjl8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFEtpPW82GfkQfsqIRAtprAJ4+X1HEFtIhDQZcE/QodVOox+YQ6gCbBa3v
pe3OAKDbrNyMPMeIKPsIZRQ=
=0tLI
-----END PGP SIGNATURE-----

--Signature=_Thu__21_Sep_2006_22_30_35_+0400_QJgnhOoTe6Z6Qjl8--
