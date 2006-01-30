Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWA3Vk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWA3Vk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWA3Vk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:40:26 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:5316 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S1030197AbWA3VkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:40:25 -0500
Date: Mon, 30 Jan 2006 13:40:05 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Ren Rebe <rene@exactcode.de>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, "Louis C. Kouvaris" <louisk@comcast.net>,
       wilford smith <wilford_smith_2@hotmail.com>
Subject: Re: [linux-usb-devel] Re: [PATCH] Adaptec USBXchange and USB2Xchange support
Message-ID: <20060130214005.GB20739@one-eyed-alien.net>
Mail-Followup-To: Ren Rebe <rene@exactcode.de>,
	Oliver Neukum <oliver@neukum.org>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	"Louis C. Kouvaris" <louisk@comcast.net>,
	wilford smith <wilford_smith_2@hotmail.com>
References: <200509132253.53960.rene@exactcode.de> <200601301422.40500.rene@exactcode.de> <200601301622.19998.oliver@neukum.org> <200601301904.15207.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <200601301904.15207.rene@exactcode.de>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2006 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

So how do you address a multi-LUN target if you don't encode the LUN?

Matt

On Mon, Jan 30, 2006 at 07:04:15PM +0100, Ren? Rebe wrote:
> Hi,
>=20
> finally - I got multi target (that is a SCSI device other than ID =3D 0 a=
nd more than than one) working
> with the USB2Xchange. But it needs two ugly changes in transport.c:
>=20
> The first one is only encoding the ID, no LUN:
>=20
> --- ../linux-2.6.15/drivers/usb/storage/transport.c	2006-01-03 04:21:10.0=
00000000 +0100
> +++ drivers/usb/storage/transport.c	2006-01-30 18:49:25.172317000 +0100
> @@ -983,7 +983,7 @@
>  	bcb->Tag =3D ++us->tag;
>  	bcb->Lun =3D srb->device->lun;
>  	if (us->flags & US_FL_SCM_MULT_TARG)
> -		bcb->Lun |=3D srb->device->id << 4;
> +		bcb->Lun =3D srb->device->id;
>  	bcb->Length =3D srb->cmd_len;
> =20
>  	/* copy the command payload */
>=20
> Would it be ok when special case that one only for the Adaptec device, fo=
r now?
> Or define a whole new 2nd MULTI_TARG(2) quirk?
>=20
> And furthermore the device does not respond to request other than the att=
ached targets,
> this might be needed:
>=20
> @@ -1069,6 +1069,19 @@
>  	US_DEBUGP("Bulk Status S 0x%x T 0x%x R %u Stat 0x%x\n",
>  			le32_to_cpu(bcs->Signature), bcs->Tag,=20
>  			residue, bcs->Status);
> +
> +	if (bcs->Status > US_BULK_STAT_FAIL) {
> +		/* Adaptec USB2XCHANGE */
> +		if (us->pusb_dev->descriptor.idVendor =3D=3D 0x03f3 &&
> +		    us->pusb_dev->descriptor.idProduct =3D=3D 0x2003) {
> +
> +			/* This device will send bcs->Status =3D=3D 0x8a for unused targets a=
nd
> +			   =3D=3D 0x02 for SRB's that require SENSE. */
> +			bcs->Status =3D US_BULK_STAT_OK;
> +			fake_sense =3D 1;
> +			US_DEBUGP("Patched Bulk status to %d.\n", bcs->Status);
> +		}
> +	}
>  	if (bcs->Tag !=3D us->tag || bcs->Status > US_BULK_STAT_PHASE) {
>  		US_DEBUGP("Bulk logical error\n");
>  		return USB_STOR_TRANSPORT_ERROR;
>=20
> Yours,
>=20
> --=20
> Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
>             http://www.exactcode.de | http://www.t2-project.org
>             +49 (0)30  255 897 45
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd______________________________________=
_________
> linux-usb-devel@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

A female who groks UNIX?  My universe is collapsing.
					-- Mike
User Friendly, 10/11/1998

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD3oe1HL9iwnUZqnkRAkx3AJ4yIZrtEcr7pBfnh7tHr8slVZ6+MQCeMqk1
SqSYj+u1x0s6upmOApA+7ck=
=0e+N
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
