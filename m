Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWJXBq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWJXBq1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 21:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWJXBq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 21:46:26 -0400
Received: from ozlabs.org ([203.10.76.45]:51146 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964867AbWJXBq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 21:46:26 -0400
Subject: Re: [PATCH] Preliminary MPIC MSI backend
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <65FA7A1D-5D74-4ABA-9985-2DB78ABC8685@kernel.crashing.org>
References: <20060929001657.6EFE667B8F@ozlabs.org>
	 <65FA7A1D-5D74-4ABA-9985-2DB78ABC8685@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-F0rf0l2IqjRtx99NSmVK"
Date: Tue, 24 Oct 2006 11:46:23 +1000
Message-Id: <1161654383.2149.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-F0rf0l2IqjRtx99NSmVK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-09-30 at 10:43 +0200, Segher Boessenkool wrote:
> > A pretty hackish MPIC backend, just enough to flesh out the design.
> > Based on code from Segher.
>=20
> It's pretty alright, and very hackish ;-)  I'll sign off on it,
> but some comments...
>=20
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> > +static int msi_mpic_check(struct pci_dev *pdev, int num,
> > +			struct msix_entry *entries, int type)
> > +{
> > +	/* The irq allocator needs more work to support MSI-X/multi-MSI */
> > +	if (type =3D=3D PCI_CAP_ID_MSIX || num !=3D 1)
> > +		return 1;
>=20
> I never tested any MSI-X, so maybe keep MSI-X disabled completely
> for now?

Yeah it is, that's an ||.

> > +static int msi_mpic_alloc(struct pci_dev *pdev, int num,
> > +			struct msix_entry *entries, int type)
> > +{
> > +	irq_hw_number_t hwirq;
> > +	unsigned int virq;
> > +
> > +	/* We need a smarter allocator for MSI-X/multi-MSI */
> > +	hwirq =3D irq_map[pdev->irq].hwirq;
> > +	hwirq +=3D 100;
>=20
> Yep, that's the main problem with this code.  A sanity check to
> make sure the number isn't >=3D 120 would be good, too.

Talking to Ben, we decided for the moment we'll just reuse the currently
assigned irq, in the medium term we'll come up with some way to find the
unassigned irqs on mpic and write an allocator.

> > +	set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
>=20
> I also had some code to show MSI IRQs as "MSI" instead of "EDGE"
> in /proc/interrupts, maybe you want to add a generic version of
> that?  Or maybe you have, and I judt didn't see it.

I lost that along the way somewhere, I'll try and find it and resurrect
it.

> > +static int msi_mpic_setup_msi_msg(struct pci_dev *pdev,
> > +		struct msix_entry *entry, struct msi_msg *msg, int type)
> > +{
> > +	msg->address_lo =3D 0xfee00000;	/* XXX What is this value? */
> > +	msg->address_hi =3D 0;
> > +	msg->data =3D pdev->irq | 0x8000;
>=20
> Lose the | 0x8000 part, that was an old experiment to work around
> U3/U4 MPIC brokenness (and it didn't work).

OK.

> > +static int msi_mpic_init(void)
> > +{
> > +	/* XXX Do this in mpic_init ? */
> > +	pr_debug("mpic_msi_init: Registering MPIC MSI ops.\n");
> > +	ppc_md.get_msi_ops =3D mpic_get_msi_ops;
>=20
> It's best to do this in the platform code I think.

Yeah probably, I'll leave that up to Ben.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-F0rf0l2IqjRtx99NSmVK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFPXBvdSjSd0sB4dIRAlPjAJ9WWDdTAMfxfoKYoK+AR7TgadtF5QCeMac6
rZEhyfmFNRKorDXb7SmtrBE=
=33E2
-----END PGP SIGNATURE-----

--=-F0rf0l2IqjRtx99NSmVK--

