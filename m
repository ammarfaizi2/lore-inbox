Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273796AbRJQBc5>; Tue, 16 Oct 2001 21:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273648AbRJQBci>; Tue, 16 Oct 2001 21:32:38 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:44562
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S273619AbRJQBcR>; Tue, 16 Oct 2001 21:32:17 -0400
Date: Tue, 16 Oct 2001 18:32:43 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Jan Niehusmann <jan@gondor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Oops in usb-storage.c
Message-ID: <20011016183243.B18541@one-eyed-alien.net>
Mail-Followup-To: Jan Niehusmann <jan@gondor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011017005822.A2161@gondor.com> <20011016175640.A18541@one-eyed-alien.net> <20011017031113.A3072@gondor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011017031113.A3072@gondor.com>; from jan@gondor.com on Wed, Oct 17, 2001 at 03:11:13AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

No, I think something different is best.

Your first change to push the US_FL_FIX_INQUIRY code down after the test
for pusb_dev is good.. but, in the case where that pointer is bad, we need
to cook up something totally fake, like INQUIRY data that says
"DISCONNECTED" "USB-STORAGE DEVICE" or somesuch.....

Matt

On Wed, Oct 17, 2001 at 03:11:13AM +0200, Jan Niehusmann wrote:
> On Tue, Oct 16, 2001 at 05:56:40PM -0700, Matthew Dharm wrote:
> > Actually, this is a side-effect of another problem, which is that INQUI=
RY
> > is legal for a device at any time (at least, to SCSI).  What we really =
need
> > to do is fake an INQURIY response for detached devices, separate from a=
lso
> > those devices which need a faked-inquiry all the time.
>=20
> Ok, then the fix could look like the following, I think. The INQUIRY
> response in the disconnected case is a little bit different, as the
> information from pusb_dev is not available, but the INQUIRY works and
> the oops is fixed.
>=20
> Jan
>=20
>=20
> --- linux-2.4.12-ac3/drivers/usb/storage/usb.c.orig	Mon Oct  1 12:15:29 2=
001
> +++ linux-2.4.12-ac3/drivers/usb/storage/usb.c	Wed Oct 17 03:04:32 2001
> @@ -268,10 +268,12 @@
>  	memcpy(data+16, us->unusual_dev->productName,=20
>  		strlen(us->unusual_dev->productName) > 16 ? 16 :
>  		strlen(us->unusual_dev->productName));
> -	data[32] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>12) & 0x0F);
> -	data[33] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>8) & 0x0F);
> -	data[34] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>4) & 0x0F);
> -	data[35] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice) & 0x0F);
> +	if(us->pusb_dev) {
> +		data[32] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>12) & 0x0F);
> +		data[33] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>8) & 0x0F);
> +		data[34] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>4) & 0x0F);
> +		data[35] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice) & 0x0F);
> +	}
> =20
>  	if (us->srb->use_sg) {
>  		sg =3D (struct scatterlist *)us->srb->request_buffer;
>=20
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It's not that hard.  No matter what the problem is, tell the customer=20
to reinstall Windows.
					-- Nurse
User Friendly, 3/22/1998

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7zN+7z64nssGU+ykRAoVyAJ9Ws1HXGj2xFM5ZRJbTukdXZxbBvgCdFng4
Pvp/JI3nBRT8F0W6tP6HZyQ=
=c1t0
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
