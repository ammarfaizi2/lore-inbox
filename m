Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSBZXAl>; Tue, 26 Feb 2002 18:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287149AbSBZXAh>; Tue, 26 Feb 2002 18:00:37 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:49897 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S286825AbSBZXA0>; Tue, 26 Feb 2002 18:00:26 -0500
Date: Tue, 26 Feb 2002 18:00:10 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@zip.com.au>
Subject: Re: 3c59x and cardbus
Message-ID: <20020226230010.GI803@ufies.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20020226173038.GD803@ufies.org> <3C7BC897.8D607D08@zip.com.au> <20020226175819.GE803@ufies.org> <20020226181510.GF803@ufies.org> <3C7BD91C.3B758704@zip.com.au> <20020226185907.GG803@ufies.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0NB0lE7sNnW8+0qW"
Content-Disposition: inline
In-Reply-To: <20020226185907.GG803@ufies.org>
User-Agent: Mutt/1.3.27i
X-Operating-System: debian SID Gnu/Linux 2.4.18 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0NB0lE7sNnW8+0qW
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Now that the forget_option bug is solved I have the following :

Each time I suspend, the card resume in a bad state but return in a good
state after that :

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0ee0 media 8800 dma 000000a0.
  Flags; bus-master 1, dirty 20(4) current 36(4)
  Transmit list 00af8300 vs. c0af8300.
  0: @c0af8200  length 80000062 status 00000062
  1: @c0af8240  length 80000062 status 00000062
  2: @c0af8280  length 80000062 status 80000062
  3: @c0af82c0  length 80000062 status 80000062
  4: @c0af8300  length 80000062 status 00000062
  5: @c0af8340  length 8000003c status 0000003c
  6: @c0af8380  length 80000062 status 00000062
  7: @c0af83c0  length 80000062 status 00000062
  8: @c0af8400  length 8000003c status 0000003c
  9: @c0af8440  length 80000062 status 00000062
  10: @c0af8480  length 80000062 status 00000062
  11: @c0af84c0  length 80000036 status 00000036
  12: @c0af8500  length 80000062 status 00000062
  13: @c0af8540  length 80000062 status 00000062
  14: @c0af8580  length 80000062 status 00000062
  15: @c0af85c0  length 80000062 status 00000062
eth0: Resetting the Tx ring pointer.

The tx ring seems to be in a good state, no ?

Christophe

On Tue, Feb 26, 2002 at 01:59:07PM -0500, christophe barb=E9 wrote:
> Thank you, I have done something similar and that solve it in my case at
> least. This driver was clearly not designed for cardbus.
>=20
> I am still looking for my resume/suspend problem.
> Hope to find the solution soon.
>=20
> Christophe
>=20
> On Tue, Feb 26, 2002 at 10:51:08AM -0800, Andrew Morton wrote:
> > christophe barb=E9 wrote:
> > >=20
> > > Ok I have found why.
> > > When I resinsert the card, the driver give it a new id (this driver
> > > supports multiple cards) and the option as I set it is only defined f=
or
> > > the card #0. I would expect that the driver give the same id back.
> > >=20
> >=20
> > hrm.  OK, hotplugging and slot-positional module parameters weren't
> > designed to live together.
> >=20
> > This should fix it for single cards.   For multiple cards, you'll
> > have to make sure you eject them in reverse scan order :)
> >=20
> > Index: drivers/net/3c59x.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > RCS file: /opt/cvs/lk/drivers/net/3c59x.c,v
> > retrieving revision 1.74.2.7
> > diff -u -r1.74.2.7 3c59x.c
> > --- drivers/net/3c59x.c	2002/02/13 21:03:03	1.74.2.7
> > +++ drivers/net/3c59x.c	2002/02/26 18:49:24
> > @@ -2898,6 +2898,9 @@
> >  		BUG();
> >  	}
> > =20
> > +	if (vp->card_idx =3D=3D vortex_cards_found)
> > +		vortex_cards_found--;
> > +
> >  	vp =3D dev->priv;
> > =20
> >  	/* AKPM: FIXME: we should have
> >=20
> >=20
> > -
>=20
> --=20
> Christophe Barb=E9 <christophe.barbe@ufies.org>
> GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E
>=20
> Imagination is more important than knowledge.
>    Albert Einstein, On Science



--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Imagination is more important than knowledge.
   Albert Einstein, On Science

--0NB0lE7sNnW8+0qW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8fBN6j0UvHtcstB4RAi9aAJ9iqGUJ5/QhQaHi5hIlyXu9CPTfVgCeO1P2
ys3l0xN6h38qEZBC6EJveGk=
=VwnT
-----END PGP SIGNATURE-----

--0NB0lE7sNnW8+0qW--
