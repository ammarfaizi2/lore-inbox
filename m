Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273622AbRJQBBX>; Tue, 16 Oct 2001 21:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273619AbRJQBBO>; Tue, 16 Oct 2001 21:01:14 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:38162
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S273345AbRJQBBA>; Tue, 16 Oct 2001 21:01:00 -0400
Date: Tue, 16 Oct 2001 17:56:40 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Jan Niehusmann <jan@gondor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Oops in usb-storage.c
Message-ID: <20011016175640.A18541@one-eyed-alien.net>
Mail-Followup-To: Jan Niehusmann <jan@gondor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011017005822.A2161@gondor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011017005822.A2161@gondor.com>; from jan@gondor.com on Wed, Oct 17, 2001 at 12:58:22AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Actually, this is a side-effect of another problem, which is that INQUIRY
is legal for a device at any time (at least, to SCSI).  What we really need
to do is fake an INQURIY response for detached devices, separate from also
those devices which need a faked-inquiry all the time.

Matt

On Wed, Oct 17, 2001 at 12:58:22AM +0200, Jan Niehusmann wrote:
> Hi,
>=20
> usb-storage.c oopses in fill_inquiry_response if I send an INQUIRY
> to device which is currently disconnected from the USB bus.
>=20
> This happens because fill_inquiry_response is called outside a
> check for us->pusb_dev. Moving the special case into the if()=20
> block, the oops is fixed.
>=20
> (For reference, the oops is below the patch)
>=20
> Jan
>=20
> --- linux-2.4.12-ac3/drivers/usb/storage/usb.c.orig	Mon Oct  1 12:15:29 2=
001
> +++ linux-2.4.12-ac3/drivers/usb/storage/usb.c	Wed Oct 17 00:33:22 2001
> @@ -389,24 +389,6 @@
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
> @@ -423,15 +405,30 @@
>  					       sizeof(usb_stor_sense_notready));
>  					us->srb->result =3D GOOD << 1;
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
>=20
>=20
>=20
>=20
> Oct 16 21:07:28 sirith kernel: Oops: 0000
> Oct 16 21:07:28 sirith kernel: CPU:    0
> Oct 16 21:07:28 sirith kernel: EIP:    0010:[<e4951766>]    Tainted: P=20
> Oct 16 21:07:28 sirith kernel: EFLAGS: 00010246
> Oct 16 21:07:28 sirith kernel: eax: 00000000   ebx: dc636600   ecx: 00000=
000   edx: 00000010
> Oct 16 21:07:28 sirith kernel: esi: e495d460   edi: d9f09fcc   ebp: e495d=
450   esp: d9f09f7c
> Oct 16 21:07:28 sirith kernel: ds: 0018   es: 0018   ss: 0018
> Oct 16 21:07:28 sirith kernel: Process usb-storage-0 (pid: 766, stackpage=
=3Dd9f09000)
> Oct 16 21:07:28 sirith kernel: Stack: d9f08000 e495da91 d9f09ff0 dc636600=
 c0116373 c02955a7 00000005 c01162c4=20
> Oct 16 21:07:28 sirith kernel:        d9f08000 e4951b44 dc636600 d9f09fcc=
 00000024 e495daa0 00000100 da003dcc=20
> Oct 16 21:07:28 sirith kernel:        dc636600 dc636600 dc636604 00000001=
 02028000 0000001f 69736143 0000006f=20
> Oct 16 21:07:28 sirith kernel: Call Trace: [<e495da91>] [release_console_=
sem+115/128] [printk+260/272] [<e4951b44>] [<e495daa0>]=20
> Oct 16 21:07:28 sirith kernel: Code: 0f b7 80 cc 00 00 00 66 c1 e8 0c 0c =
30 88 47 20 8b 43 18 8a=20
>=20
> >>EIP; e4951766 <[usb-storage]fill_inquiry_response+116/2f0>   <=3D=3D=3D=
=3D=3D
> Trace; e495da90 <[usb-storage]__module_usb_device_size+670/81be>
> Code;  e4951766 <[usb-storage]fill_inquiry_response+116/2f0>
> 00000000 <_EIP>:
> Code;  e4951766 <[usb-storage]fill_inquiry_response+116/2f0>   <=3D=3D=3D=
=3D=3D
>    0:   0f b7 80 cc 00 00 00      movzwl 0xcc(%eax),%eax   <=3D=3D=3D=3D=
=3D
> Code;  e495176c <[usb-storage]fill_inquiry_response+11c/2f0>
>    7:   66 c1 e8 0c               shr    $0xc,%ax
> Code;  e4951770 <[usb-storage]fill_inquiry_response+120/2f0>
>    b:   0c 30                     or     $0x30,%al
> Code;  e4951772 <[usb-storage]fill_inquiry_response+122/2f0>
>    d:   88 47 20                  mov    %al,0x20(%edi)
> Code;  e4951776 <[usb-storage]fill_inquiry_response+126/2f0>
>   10:   8b 43 18                  mov    0x18(%ebx),%eax
> Code;  e4951778 <[usb-storage]fill_inquiry_response+128/2f0>
>   13:   8a 00                     mov    (%eax),%al

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Sir, for the hundreth time, we do NOT carry 600-round boxes of belt-fed=20
suction darts!
					-- Salesperson to Greg
User Friendly, 12/30/1997

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7zNdIz64nssGU+ykRAivoAKDB1ne1VR7BvPSkgBSs/f0d//FRuACg6eWf
TR75OMkwZpKAAkd4uoXkoio=
=kABT
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
