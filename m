Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVDGITU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVDGITU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVDGISd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:18:33 -0400
Received: from dea.vocord.ru ([217.67.177.50]:18626 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262251AbVDGIRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:17:20 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: guillaume.thouvenin@bull.net, greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050407005852.36a1264b.akpm@osdl.org>
References: <1112859412.18360.31.camel@frecb000711.frec.bull.fr>
	 <1112860419.28858.76.camel@uganda>  <20050407005852.36a1264b.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QiTo/QZuF6gEWvXS+Sa3"
Organization: MIPT
Date: Thu, 07 Apr 2005 12:23:52 +0400
Message-Id: <1112862232.28858.102.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 07 Apr 2005 12:17:01 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QiTo/QZuF6gEWvXS+Sa3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-07 at 00:58 -0700, Andrew Morton wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> > > > >  I don't see the connector directory in the 2.6.12-rc2-mm1 tree. =
So it
> > > > > seems that you removed the connector?
> > > >=20
> > > > Greg dropped it for some reason.  I think that's best because it ne=
eded a
> > > > significant amount of rework.  I'd like to see it resubitted in tot=
ality so
> > > > we can take another look at it.
> >=20
> > Hmm, what exactly do you think _must_ be changed?
>=20
> The stuff we discussed.
>=20
> Plus, I'm still quite unsettled about the whole object lifecycle
> management, refcounting and locking in there.  The fact that the code is
> littered with peculiar barriers says "something weird is happening here",
> and it remains unobvious to me why such a very common kernel pattern was
> implemented in such an unusual manner.
>=20
> So.  I'd like to see the whole thing reexplained and resubmitted so we ca=
n
> think about it all again.

All those barriers can be replaced with atomic_dec_and_test(),=20
i.e. with something that returns the value.
Methods that return value requires explicit barriers.

Actually there are quite many places where we have:

cpu0                             cpu1
use object
atomic_dec()
                                 if atomic_read/atomic_dec_and_test =3D=3D =
0
                                    free object.

With explicit barriers about use object we can
not catch atomic vs. non atomic reordering.
There still _may_ exist other types of races,=20
but as we discussed, in connector case they=20
were my faults [flush on connector removal].

> > Most of your comments are addressed in 4 patches I sent to you and Greg=
.
>=20
> Which comments were not addressed?

CBUS code comments [I did not get ack on CBUS itself], and two below
issues.

> > Others [mostly atomic allocation] are API extensions and will be added.
>=20
> I would like to see that code before committing to merging anything.

Ok.

> > There also not included flush on callback removal.
> >
> > > > It's a new piece of core kernel infrastructure and the barriers for=
 that
> > > > are necessarily high.
> > > >=20
> > > > > Will you include it again in futur
> > > > > release? At the same time, will you include the fork connector?
> > > >=20
> > > > I could put the fork connector into -mm, but would like to be convi=
nced
> > > > that it's acceptable to and useful for all system accounting requir=
ements,
> > > > not just the one project.  That means code, please.
> >=20
> > SuperIO and kobject_uevent are also dropped as far as I can see.
> >=20
> > Acrypto is being reviewed but it also depends on it, although=20
> > it takes to much time, probably will be dropped too.
> >=20
> > Proper w1 notification also requires connector.
>=20
> Guillaume was referring to "fork connector", not to "connector".

fork connector depends on the dropped connector/CBUS.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-QiTo/QZuF6gEWvXS+Sa3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVO4YIKTPhE+8wY0RAlpXAJ0Swmj4qsAeZ4YXuFkelU/h35eeOACfRpu6
A8Ty/yk6Bw+lSvzq7hqQv8o=
=3Rbj
-----END PGP SIGNATURE-----

--=-QiTo/QZuF6gEWvXS+Sa3--

