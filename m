Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWJXBvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWJXBvb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 21:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWJXBvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 21:51:31 -0400
Received: from ozlabs.org ([203.10.76.45]:27597 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964914AbWJXBva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 21:51:30 -0400
Subject: Re: [RFC/PATCH 3/7] Powerpc MSI ops layer
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc-dev@ozlabs.org, "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <1159912492.4997.257.camel@goblue>
References: <20060928215339.D911C67BFA@ozlabs.org>
	 <1159912492.4997.257.camel@goblue>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+Xa4a5mGvbKTEIPuXDjT"
Date: Tue, 24 Oct 2006 11:51:28 +1000
Message-Id: <1161654688.2149.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+Xa4a5mGvbKTEIPuXDjT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-03 at 16:54 -0500, Jake Moilanen wrote:
> On Fri, 2006-09-29 at 07:53 +1000, Michael Ellerman wrote:
> > Powerpc MSI ops layer.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > ---
> >=20
> >  arch/powerpc/kernel/msi.c        |  347 ++++++++++++++++++++++++++++++=
+++++++++
> >  include/asm-powerpc/machdep.h    |    6=20
> >  include/asm-powerpc/msi.h        |  175 +++++++++++++++++++
> >  include/asm-powerpc/pci-bridge.h |    4=20
> >  4 files changed, 532 insertions(+)
> >=20
> > Index: to-merge/arch/powerpc/kernel/msi.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- /dev/null
> > +++ to-merge/arch/powerpc/kernel/msi.c
> > @@ -0,0 +1,347 @@
> > +/*
> > + * Copyright 2006 (C), Michael Ellerman, IBM Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#undef DEBUG
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <asm/msi.h>
> > +#include <asm/machdep.h>
> > +
> > +static struct ppc_msi_ops *get_msi_ops(struct pci_dev *pdev)
> > +{
> > +	if (ppc_md.get_msi_ops)
> > +		return ppc_md.get_msi_ops(pdev);
> > +	return NULL;
> > +}
> > +
> > +/* Activated by pci=3Dnomsi on the command line. */
> > +static int no_msi;
> > +
> > +void pci_no_msi(void)
> > +{
> > +	no_msi =3D 1;
> > +}
> > +
> > +
> > +/* msi_info helpers */
> > +
> > +static struct pci_dn *get_pdn(struct pci_dev *pdev)
> > +{
> > +	struct device_node *dn;
> > +	struct pci_dn *pdn;
> > +
> > +	dn =3D pci_device_to_OF_node(pdev);
> > +	if (!dn) {
> > +		pr_debug("get_pdn: no dn found for %s\n", pci_name(pdev));
> > +		return NULL;
> > +	}
> > +
> > +	pdn =3D PCI_DN(dn);
> > +	if (!pdn) {
> > +		pr_debug("get_pdn: no pci_dn found for %s\n", pci_name(pdev));
> > +		return NULL;
> > +	}
> > +
> > +	return pdn;
> > +}
> > +
> > +static int alloc_msi_info(struct pci_dev *pdev, int num,
> > +			struct msix_entry *entries, int type)
> > +{
> > +	struct msi_info *info;
> > +	unsigned int entries_size;
> > +	struct pci_dn *pdn;
> > +
> > +	entries_size =3D sizeof(struct msix_entry) * num;
> > +
> > +	info =3D kzalloc(sizeof(struct msi_info) + entries_size, GFP_KERNEL);
>=20
> Shouldn't you do a second kzalloc for info->entries, and not just add on
> the size to the end?

We could, but I don't see why it's better. It's a little sneaky to tack
the entries on the end but I don't see a problem with it?

There is a bug in there that I don't set the entries pointer before
doing the memcpy, but I've fixed that - or is that what you meant ? :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-+Xa4a5mGvbKTEIPuXDjT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFPXGgdSjSd0sB4dIRAqnsAKCN7M8/MmS6Fcm4uaMUJI4NmPTdFwCeJA5q
fnFaEJu9+KYvZ3EYoJdfxHU=
=nxUS
-----END PGP SIGNATURE-----

--=-+Xa4a5mGvbKTEIPuXDjT--

