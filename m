Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTAEAcq>; Sat, 4 Jan 2003 19:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbTAEAcq>; Sat, 4 Jan 2003 19:32:46 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:45831 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S261836AbTAEAcm>; Sat, 4 Jan 2003 19:32:42 -0500
Date: Sat, 4 Jan 2003 16:41:13 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: inquiry in scsi_scan.c
Message-ID: <20030104164113.A27421@one-eyed-alien.net>
Mail-Followup-To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <UTC200301040307.h0437pY06513.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200301040307.h0437pY06513.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Sat, Jan 04, 2003 at 04:07:51AM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Instead of fixing this in usb-storage, I think I would rather make
scsi_scan.c just assume a minimum of 36.

Or, put another way, if the first request indicates less than 36, why
should we do a second request?  We already have all the data...

Matt

On Sat, Jan 04, 2003 at 04:07:51AM +0100, Andries.Brouwer@cwi.nl wrote:
> Matthew Dharm writes:
>=20
> > There should probably be a sanity check to never ask for INQUIRY
> > less than 36 bytes.  I thought there used to be such a thing....
>=20
> As Doug also points out, we ask for 36, but there is no
> guarantee that we get what we ask for.
>=20
> > Actually, 5 isn't minimal... it's sub-minimal.
> > That's an error in the INQUIRY data/
> > The minimum (by spec) is 36 bytes.
>=20
> No. Quoting:
>=20
> "The INQUIRY data (Table 7-9) contains a five byte header,
> followed by the vendor unique parameters, if any."
> (SCSI-1 standard)
>=20
> So, as long as we are willing to support SCSI-1 devices,
> we must accept that the INQUIRY data can be as short as this.
> And in fact all our other code is careful - look at
> print_inquiry() how before looking at a byte we check
> whether it really there.
>=20
>=20
> On the other hand, my case was not an ancient SCSI-1 device,
> it was a brand new USB device. So, I have the SCSI host in hand.
> Looking at what happens:
>=20
> usb-storage: usb_stor_bulk_transfer_buf(): xfer 36 bytes
>  00 80 00 00 00 00 00 00 4F 45 49 2D 55 53 42 20
>  53 6D 61 72 74 4D 65 64 69 61 20 20 20 20 20 20
>  32 2E 30 35
> usb-storage: Status code 0; transferred 36/36
> usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
> usb-storage: Fixing INQUIRY data to show length 36 - was 0
>=20
> and all is fine.
>=20
> Instead of the old garbage I now see:
> % cat /proc/scsi/scsi
> ...
> Host: scsi2 Channel: 00 Id: 00 Lun: 00
>   Vendor: OEI-USB  Model: SmartMedia       Rev: 2.05
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> ...
>=20
>=20
> Conclusion:
> (i) scsi_scan.c has to be careful about INQUIRY lengths,
> and some patch is required for devices that return a short length.
> (ii) usb-storage knows the transport length, and can fix it
> in case it is (5+)0. For example, in protocol.c:fix_inquiry_data():
>=20
> static void fix_inquiry_data(Scsi_Cmnd *srb)
> {
>         unsigned char *data_ptr;
>=20
>         /* verify that it's an INQUIRY command */
>         if (srb->cmnd[0] !=3D INQUIRY)
>                 return;
>=20
>         data_ptr =3D find_data_location(srb);
>=20
>         if ((data_ptr[2] & 7) !=3D 2) {
>                 US_DEBUGP("Fixing INQUIRY data to show SCSI rev 2 - was %=
d\n",
>                           data_ptr[2] & 7);
>=20
>                 /* Change the SCSI revision number */
>                 data_ptr[2] =3D (data_ptr[2] & ~7) | 2;
>         }
>=20
>         if (data_ptr[4] =3D=3D 0) {
>                 US_DEBUGP("Fixing INQUIRY data to show length 36 - was 0\=
n");
>                 data_ptr[4] =3D 36 - 5;
>         }
> }
>=20
> Andries

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+F38oIjReC7bSPZARAj1aAKCc2LKTC4nMrbdwbOSfhGsZRlrIigCeOjY0
YvwqPvuKLkSvjVufE0mqsbE=
=WpOo
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
