Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270328AbRHHFR2>; Wed, 8 Aug 2001 01:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270329AbRHHFRW>; Wed, 8 Aug 2001 01:17:22 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:20230
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S270328AbRHHFRM>; Wed, 8 Aug 2001 01:17:12 -0400
Date: Tue, 7 Aug 2001 22:17:08 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Keith Owens <kaos@ocs.com.au>,
        Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: using mount from SUID scripts?
Message-ID: <20010807221708.C31439@one-eyed-alien.net>
Mail-Followup-To: Jesse Pollard <jesse@cats-chateau.net>,
	Keith Owens <kaos@ocs.com.au>,
	Kernel Developer List <linux-kernel@vger.kernel.org>
In-Reply-To: <27034.997233173@kao2.melbourne.sgi.com> <01080721385400.15022@tabby>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01080721385400.15022@tabby>; from jesse@cats-chateau.net on Tue, Aug 07, 2001 at 09:29:07PM -0500
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Actually, a strace of mount shows that mount asks for the UID and the EUID,
and seems to exit of it's own accord when they differ.

Tho, if I can force the UID to the EUID, this may work also.

Unfortunately, the snippit of code here doesn't do the job... after the
first two lines, the UID is unchanged, while the EUID is still 0 (root).  I
used system "/usr/bin/id" to verify this.  /bin/mount is still complaining.

Oh, wait... $> is effective and $< is real.  So that first line should be
($r, $e) =3D ($<, $>); -- this makes everything happy!

Thanks tons, folks!

Matt Dharm

On Tue, Aug 07, 2001 at 09:29:07PM -0500, Jesse Pollard wrote:
> On Tue, 07 Aug 2001, Keith Owens wrote:
> >On Tue, 7 Aug 2001 16:29:39 -0700,=20
> >Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
> >>I've got an SUID perl script (yes, it's EUID is really 0) which I'd lik=
e to
> >>use mount from to mount a file via loopback...
> >>
> >>Unfortunately, it looks like mount refuses to actually mount anything if
> >>the EUID and UID aren't the same....
> >
> >Are you sure the problem is mount?  Some versions of bash drop euid(0)
> >when they execute scripts from setuid programs.
> >
>=20
> not mount, and likely not the shell - the thing is that perl doesn't like=
 it
> when the  effective uid is not equal to the real uid. Perl is very good at
> limiting the damange an unsuspecting script does. This is to prevent pass=
ing
> a "confused" environment to the shell.
>=20
> The following can work around this:
>=20
> 	($r,$e) =3D ( $>, $< );	# save real and effective uid's
> 	$< =3D $e;		# force real uid to the effective
> 	`/bin/mount ....`
> 	($>, $<) =3D ($r,$e);	# restore mixed state
>=20
> Remember, the options to mount should come from a fixed table with user
> selected input used to select which table entry to use... or a strictly
> fixed mount command.
>=20
> Otherwise you have an even bigger security hole.
>=20
> --=20
> -------------------------------------------------------------------------
> Jesse I Pollard, II
> Email: jesse@cats-chateau.net
>=20
> Any opinions expressed are solely my own.

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

You suck Stef.
					-- Greg=20
User Friendly, 11/29/97

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7cMtUz64nssGU+ykRAjCvAKDezBbgZfi+PDa7iX0bn7lD9+IUZQCg0Anl
i7/7R2BqwhovBCYmjsFB89Q=
=uK9b
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
