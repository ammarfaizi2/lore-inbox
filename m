Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277065AbRJQTPg>; Wed, 17 Oct 2001 15:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277071AbRJQTP1>; Wed, 17 Oct 2001 15:15:27 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:15881
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S277065AbRJQTPM>; Wed, 17 Oct 2001 15:15:12 -0400
Date: Wed, 17 Oct 2001 12:15:40 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Jan Niehusmann <jan@gondor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Oops in usb-storage.c
Message-ID: <20011017121540.A32020@one-eyed-alien.net>
Mail-Followup-To: Jan Niehusmann <jan@gondor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011017005822.A2161@gondor.com> <20011016175640.A18541@one-eyed-alien.net> <20011017031113.A3072@gondor.com> <20011016183243.B18541@one-eyed-alien.net> <20011017034410.A3722@gondor.com> <20011016232452.A22978@one-eyed-alien.net> <20011017124249.A1505@gondor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011017124249.A1505@gondor.com>; from jan@gondor.com on Wed, Oct 17, 2001 at 12:42:49PM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This looks better... but you have a dangerous memset() in an else clause --
the request buffer pointer could be pointing to a scatter-gather list, so
you can't just memset on it.

Matt

On Wed, Oct 17, 2001 at 12:42:49PM +0200, Jan Niehusmann wrote:
> On Tue, Oct 16, 2001 at 11:24:52PM -0700, Matthew Dharm wrote:
> > Technically, as long as the system believes that the target exists (i.e.
> > you haven't unloaded your SCSI driver module), the target is required to
> > respond to an INQUIRY command.  So, if you boot with the scanner on, and
> > then turn it off, you've got a problem.
>=20
> Ok. I looked at the SCSI-2 standard and found a possibly sensible answer
> for such an INQUIRY to a disconnected device.
> First, there is a special peripheral qualifier for disconnected
> physical devices:
>=20
> 001b	The target is capable of supporting the specified peripheral
> 	device type on this logical unit;  however, the physical device=20
> 	is not currently connected to this logical unit.  =20
>=20
> Second, the devices is not required to give a complete answer:
>=20
>   NOTES
>   65 The INQUIRY command is typically used by the initiator after a reset
>   or power-up condition to determine the device types for system
>   configuration. To minimize delays after a reset or power-up condition,
>   the standard INQUIRY data should be available without incurring any
>   media access delays. If the target does store some of the INQUIRY data
>   on the device, it may return zeros or ASCII spaces (20h) in those fields
>   until the data is available from the device.
>=20
> While this permission to set some fields to zero is included in the
> standard for other purposes, it makes clear that you must expect to
> get incomplete answers from an INQUIRY command.
>=20
> So, what about the following patch?
>=20
> Jan
>=20
>=20
> =09
> --- linux-2.4.12-ac3/drivers/usb/storage/usb.c.orig	Mon Oct  1 12:15:29 2=
001
> +++ linux-2.4.12-ac3/drivers/usb/storage/usb.c	Wed Oct 17 12:33:40 2001
> @@ -262,16 +262,28 @@
>  	if (data_len<36) // You lose.
>  		return;
> =20
> -	memcpy(data+8, us->unusual_dev->vendorName,=20
> -		strlen(us->unusual_dev->vendorName) > 8 ? 8 :
> -		strlen(us->unusual_dev->vendorName));
> -	memcpy(data+16, us->unusual_dev->productName,=20
> -		strlen(us->unusual_dev->productName) > 16 ? 16 :
> -		strlen(us->unusual_dev->productName));
> -	data[32] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>12) & 0x0F);
> -	data[33] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>8) & 0x0F);
> -	data[34] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>4) & 0x0F);
> -	data[35] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice) & 0x0F);
> +	if(data[0]&0x20) { /* USB device currently not connected. Return
> +			      peripheral qualifier 001b ("...however, the
> +			      physical device is not currently connected
> +			      to this logical unit") and leave vendor and
> +			      product identification empty. ("If the target
> +			      does store some of the INQUIRY data on the
> +			      device, it may return zeros or ASCII spaces=20
> +			      (20h) in those fields until the data is
> +			      available from the device."). */
> +		memset(data+8,0,28);
> +	} else {
> +		memcpy(data+8, us->unusual_dev->vendorName,=20
> +			strlen(us->unusual_dev->vendorName) > 8 ? 8 :
> +			strlen(us->unusual_dev->vendorName));
> +		memcpy(data+16, us->unusual_dev->productName,=20
> +			strlen(us->unusual_dev->productName) > 16 ? 16 :
> +			strlen(us->unusual_dev->productName));
> +		data[32] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>12) & 0x0F);
> +		data[33] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>8) & 0x0F);
> +		data[34] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>4) & 0x0F);
> +		data[35] =3D 0x30 + ((us->pusb_dev->descriptor.bcdDevice) & 0x0F);
> +	}
> =20
>  	if (us->srb->use_sg) {
>  		sg =3D (struct scatterlist *)us->srb->request_buffer;
> @@ -389,24 +401,6 @@
>  				break;
>  			}
> =20
> -			/* Handle those devices which need us to fake their
> -			 * inquiry data */
> -			if ((us->srb->cmnd[0] =3D=3D INQUIRY) &&
> -			    (us->flags & US_FL_FIX_INQUIRY)) {
> -			    	unsigned char data_ptr[36] =3D {
> -				    0x00, 0x80, 0x02, 0x02,
> -				    0x1F, 0x00, 0x00, 0x00};
> -
> -			    	US_DEBUGP("Faking INQUIRY command\n");
> -				fill_inquiry_response(us, data_ptr, 36);
> -				us->srb->result =3D GOOD << 1;
> -
> -				set_current_state(TASK_INTERRUPTIBLE);
> -				us->srb->scsi_done(us->srb);
> -				us->srb =3D NULL;
> -				break;
> -			}
> -
>  			/* lock the device pointers */
>  			down(&(us->dev_semaphore));
> =20
> @@ -422,16 +416,38 @@
>  					       usb_stor_sense_notready,=20
>  					       sizeof(usb_stor_sense_notready));
>  					us->srb->result =3D GOOD << 1;
> +				} else if(us->srb->cmnd[0] =3D=3D INQUIRY) {
> +					unsigned char data_ptr[36] =3D {
> +					    0x20, 0x80, 0x02, 0x02,
> +					    0x1F, 0x00, 0x00, 0x00};
> +					US_DEBUGP("Faking INQUIRY command for disconnected device\n");
> +					fill_inquiry_response(us, data_ptr, 36);
> +					us->srb->result =3D GOOD << 1;
>  				} else {
> +					memset(us->srb->request_buffer, 0, us->srb->request_bufflen);
>  					memcpy(us->srb->sense_buffer,=20
>  					       usb_stor_sense_notready,=20
>  					       sizeof(usb_stor_sense_notready));
>  					us->srb->result =3D CHECK_CONDITION << 1;
>  				}
>  			} else { /* !us->pusb_dev */
> -				/* we've got a command, let's do it! */
> -				US_DEBUG(usb_stor_show_command(us->srb));
> -				us->proto_handler(us->srb, us);
> +
> +				/* Handle those devices which need us to fake=20
> +				 * their inquiry data */
> +				if ((us->srb->cmnd[0] =3D=3D INQUIRY) &&
> +				    (us->flags & US_FL_FIX_INQUIRY)) {
> +					unsigned char data_ptr[36] =3D {
> +					    0x00, 0x80, 0x02, 0x02,
> +					    0x1F, 0x00, 0x00, 0x00};
> +
> +					US_DEBUGP("Faking INQUIRY command\n");
> +					fill_inquiry_response(us, data_ptr, 36);
> +					us->srb->result =3D GOOD << 1;
> +				} else {
> +					/* we've got a command, let's do it! */
> +					US_DEBUG(usb_stor_show_command(us->srb));
> +					us->proto_handler(us->srb, us);
> +				}
>  			}
> =20
>  			/* unlock the device pointers */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Dudes! May the Open Source be with you.
					-- Eric S. Raymond
User Friendly, 12/3/1998

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7zdjcz64nssGU+ykRAlKrAKCF1MZIoHnXZEf6i5fL3f3jBPV4YgCeOTGP
EcEw9ND1rjb/bfubwEmPg7g=
=wsZ5
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
