Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292957AbSDPKOl>; Tue, 16 Apr 2002 06:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293060AbSDPKOk>; Tue, 16 Apr 2002 06:14:40 -0400
Received: from ip77-36.sjsbc.org ([209.66.77.36]:57263 "EHLO tbdnetworks.com.")
	by vger.kernel.org with ESMTP id <S292957AbSDPKOj>;
	Tue, 16 Apr 2002 06:14:39 -0400
Subject: Re: [PATCH] 2.5.8 IDE 36
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CBBDF0E.4050605@evision-ventures.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-FltqiAxeA5BtsaRLgcDk"
X-Mailer: Ximian Evolution 1.0.3 
Date: 16 Apr 2002 03:06:54 -0700
Message-Id: <1018951616.12352.38.camel@voyager>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FltqiAxeA5BtsaRLgcDk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-04-16 at 01:21, Martin Dalecki wrote:
> Norbert Kiesel wrote:
> > Hi,
> >=20
> > while trying to understand recent kernel changes I stumbled over
> > the following patch to
> > =20
> > diff -urN linux-2.5.8/drivers/ide/ide.c linux/drivers/ide/ide.c
> > --- linux-2.5.8/drivers/ide/ide.c	Tue Apr 16 06:01:07 2002
> > +++ linux/drivers/ide/ide.c	Tue Apr 16 05:38:37 2002
> >=20
> > ...
> >  while (i > 0) {
> > -		u32 buffer[16];
> > -		unsigned int wcount =3D (i > 16) ? 16 : i;
> > -		i -=3D wcount;
> > -		ata_input_data (drive, buffer, wcount);
> > +		u32 buffer[SECTOR_WORDS];
> > +		unsigned int count =3D (i > 1) ? 1 : i;
> > +
> > +		ata_read(drive, buffer, count * SECTOR_WORDS);
> > +		i -=3D count;
> >  	}
> >  }
> > ...
> >=20
> > While the old code called ata_input_read() with [0:16] as last param,
> > the new code calls the (renamed) ata_read() with either 0 or 16. Also,
> > the new code loops "i" times while the old code looped "i/16+1" times.
> > Was this intended or should the patch better read like:
> >=20
> > ...
> >  while (i > 0) {
> > -               u32 buffer[16];
> > -               unsigned int wcount =3D (i > 16) ? 16 : i;
> > -               i -=3D wcount;
> > -               ata_input_data (drive, buffer, wcount);
> > +               u32 buffer[SECTOR_WORDS];
> > +               unsigned int count =3D max(i, SECTOR_WORDS);
> > +
> > +               ata_read(drive, buffer, count);
> > +               i -=3D count;
> >         }
> >  }
> > ...
> >=20
> > so long
>=20
> It's fine as it is I think. Please look up at the initialization of i.
> I have just divded the SECTROT_WORDS (=3D=3D 16) factor out
> of all the places above ata_read.
>

You are right (assuming SECTOR_WORDS =3D=3D 16. I was looking it up in
2.4.18 where SECTOR_WORDS is 512/4 =3D=3D 128).  However, the new code look=
s
overly complicated (at least for me, easily proven by my wrong first
email :-), given that count is now always =3D=3D 1.  Would the following no=
t
be nicer?

	int i;

	if (drive->type !=3D ATA_DISK)
		return;

	for (i =3D min(drive->mult_count, 1); i > 0; i--) {
		u32 buffer[SECTOR_WORDS];

		ata_read(drive, buffer, SECTOR_WORDS);
	}

(This of course assumes that drive->mult_count is always non-negative)

--nk

=20
--=20
Key fingerprint =3D 6C58 F18D 4747 3295 F2DB  15C1 3882 4302 F8B4 C11C

--=-FltqiAxeA5BtsaRLgcDk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8u/e9OIJDAvi0wRwRAlRaAJ4/pLuRIbaWFtHD1iqYzsjn1Na34gCeOS1w
QBRDhXBYtk8Le5lJmxCmNYQ=
=SFUv
-----END PGP SIGNATURE-----

--=-FltqiAxeA5BtsaRLgcDk--

