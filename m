Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287471AbRLaF1i>; Mon, 31 Dec 2001 00:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287470AbRLaF12>; Mon, 31 Dec 2001 00:27:28 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:11788 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S287453AbRLaF1M>; Mon, 31 Dec 2001 00:27:12 -0500
Date: Sun, 30 Dec 2001 21:27:00 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Jens Axboe <axboe@suse.de>
Cc: Peter Osterlund <petero2@telia.com>, Greg KH <greg@kroah.com>,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: "sr: unaligned transfer" in 2.5.2-pre1
Message-ID: <20011230212700.B652@one-eyed-alien.net>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Peter Osterlund <petero2@telia.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain> <20011223112249.B4493@kroah.com> <m23d1trr4w.fsf@pengo.localdomain> <20011230122756.L1821@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011230122756.L1821@suse.de>; from axboe@suse.de on Sun, Dec 30, 2001 at 12:27:56PM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If it shouldn't be used, it should be removed from the structure to force
people to change.

This is probably why usb-storage broke, and it wasn't obvious to me what
went wrong.

So now I guess I need to either (a) compute the address for the USB layer,
or (b) figure out how to pass the memory parameters directly, so we can use
highmem.

Matt

On Sun, Dec 30, 2001 at 12:27:56PM +0100, Jens Axboe wrote:
> On Sun, Dec 30 2001, Peter Osterlund wrote:
> > Greg KH <greg@kroah.com> writes:
> >=20
> > > On Sun, Dec 23, 2001 at 06:44:43PM +0100, Peter Osterlund wrote:
> > > >=20
> > > > So, what changes are needed to make CD support work?
> > >=20
> > > The usb-storage driver needs some changes to get it to work properly =
in
> > > the 2.5.1 kernel due to the changes in the SCSI and bio layer.  I've
> > > gotten a few other reports of problems, so you aren't alone :)
> > >=20
> > > As for when the changes will be done, any volunteers?
> >=20
> > This patch seems to work for me. I hope it is correct. The ide-scsi
> > driver is basically doing the same thing already.
> >=20
> > --- linux-2.5-packet/drivers/usb/storage/scsiglue.c.old	Sun Dec 30 02:1=
0:01 2001
> > +++ linux-2.5-packet/drivers/usb/storage/scsiglue.c	Sun Dec 30 02:09:05=
 2001
> > @@ -145,9 +145,19 @@
> >  static int queuecommand( Scsi_Cmnd *srb , void (*done)(Scsi_Cmnd *))
> >  {
> >  	struct us_data *us =3D (struct us_data *)srb->host->hostdata[0];
> > +	struct scatterlist *sg;
> > +	int i;
> > =20
> >  	US_DEBUGP("queuecommand() called\n");
> >  	srb->host_scribble =3D (unsigned char *)us;
> > +
> > +	/* Set up address field in the scatterlist. HighMem pages have
> > +	 * already been bounced at this point. */
> > +	sg =3D (struct scatterlist *) srb->request_buffer;
> > +	for (i =3D 0; i < srb->use_sg; i++) {
> > +		BUG_ON(PageHighMem(sg[i].page));
> > +		sg[i].address =3D page_address(sg[i].page) + sg[i].offset;
> > +	}
> > =20
> >  	/* get exclusive access to the structures we want */
> >  	down(&(us->queue_exclusion));
>=20
> That's not right, you shouldn't be using .address at all.
>=20
> --=20
> Jens Axboe

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

C:  Why are you upgrading to NT?
AJ: It must be the sick, sadistic streak that runs through me.
					-- Chief and A.J.
User Friendly, 5/12/1998

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8L/ckz64nssGU+ykRAgM7AJoCIneNWPImXasGfz4y2ktvqMYhLwCgiier
kWn0gSFbXlBsUzwjMonTHnU=
=zndf
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
