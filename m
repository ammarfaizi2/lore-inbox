Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTAEAhG>; Sat, 4 Jan 2003 19:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261506AbTAEAhG>; Sat, 4 Jan 2003 19:37:06 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:48903 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S261486AbTAEAhB>; Sat, 4 Jan 2003 19:37:01 -0500
Date: Sat, 4 Jan 2003 16:45:31 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: inquiry in scsi_scan.c
Message-ID: <20030104164531.B27421@one-eyed-alien.net>
Mail-Followup-To: Patrick Mansfield <patmans@us.ibm.com>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <UTC200301040021.h040LB128544.aeb@smtp.cwi.nl> <20030103170404.D4315@one-eyed-alien.net> <20030103184458.A19314@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030103184458.A19314@beaverton.ibm.com>; from patmans@us.ibm.com on Fri, Jan 03, 2003 at 06:44:58PM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Actually, we ask for 36 and get 36, but the field in the response which is
supposed to tell us how much there is total is zeroed out, instead of
having a real value.

All we need to do is recognize when that field indicates less than 36
bytes, and then stop asking for anything else.  Either (a) the device is
lying, in which case our original INQUIRY is fine, or (b) the device really
has less than 36 bytes, which means that we already have all the data.

Matt

On Fri, Jan 03, 2003 at 06:44:58PM -0800, Patrick Mansfield wrote:
> On Fri, Jan 03, 2003 at 05:04:04PM -0800, Matthew Dharm wrote:
> > Actually, 5 isn't minimal... it's sub-minimal.  That's an error in the
> > INQUIRY data.  The minimum (by spec) is 36 bytes.
> >=20
> > There should probably be a sanity check to never ask for INQUIRY less t=
han
> > 36 bytes.  I thought there used to be such a thing....
> >=20
> > Matt
>=20
> Well we do ask for 36, but in Andries case only got back 5.
>=20
> The zero fill is a good solution and matches what the device should do if=
 it
> can't get all of the INQUIRY data.
>=20
> There should be a warning output, in case other bad things happen, and so
> people know they have a borken device, and maybe a comment like:
>=20
>         /*
>          * If the response length is less than 36 the rest of the INQUIRY
> 	 * is zero filled.
> 	 *
> 	 * etc.
>          */
>=20
> >=20
> > On Sat, Jan 04, 2003 at 01:21:11AM +0100, Andries.Brouwer@cwi.nl wrote:
> > > Got a new USB device and noticed some scsi silliness while playing wi=
th it.
> > >=20
> > > A bug in scsi_scan.c is
> > >=20
> > >         sdev->inquiry =3D kmalloc(sdev->inquiry_len, GFP_ATOMIC);
> > >         memcpy(sdev->inquiry, inq_result, sdev->inquiry_len);
> > >         sdev->vendor =3D (char *) (sdev->inquiry + 8);
> > >         sdev->model =3D (char *) (sdev->inquiry + 16);
> > >         sdev->rev =3D (char *) (sdev->inquiry + 32);
> > >=20
> > > since it happens that inquiry_len is short (in my case it is 5)
> > > and the vendor/model/rev pointers are wild.
> > > Catting /proc/scsi/scsi now yields random garbage.
>=20
> > > I made a patch but hesitated between a small patch and a larger one.
> > > Why do we have this malloced inquiry field? As far as I can see
> > > nobody uses it. And the comment in scsi_add_lun() advises us
> > > not to save the inquiry, precisely what we did until recently.
> > > So, should this change from 2.5.11 be reverted?
>=20
> The INQUIRY was saved so that users could avoid sending a long INQUIRY to
> a borken device and hang it, and just send an ioctl to retrieve it, but no
> ioctl was ever added.
>=20
> Rather than not saving it, we should just get the INQUIRY again (and
> implicitly overwrite vendor/model/rev) after spin up or if we get a unit
> attention with additional sense code of INQUIRY DATA HAS CHANGED; this
> would probably break somehow for some devices (changing the INQUIRY after
> a spin up is not out of spec), and is hard to handle with our current
> scanning (scsi_scan.c sends the INQUIRY, but sd.c has the spin up code),
> as per comments in scsi_probe_lun.
>=20
> -- Patrick Mansfield
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+F4ArIjReC7bSPZARAhvBAJ0RuF2le/aXz1Ux/DHoyrK9NWKGEQCfVmFM
i2lRyiFeFccp+kP1kG0jPF0=
=FBSE
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
