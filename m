Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWJXCtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWJXCtb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 22:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWJXCta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 22:49:30 -0400
Received: from ozlabs.org ([203.10.76.45]:45528 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750968AbWJXCta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 22:49:30 -0400
Subject: Re: [RFC/PATCH 6/7] RTAS MSI implementation
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc-dev@ozlabs.org, "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <1159912408.4997.255.camel@goblue>
References: <20060928215346.CE92067C6D@ozlabs.org>
	 <1159912408.4997.255.camel@goblue>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pDEacQvNP/NKjY1gpWsd"
Date: Tue, 24 Oct 2006 12:49:27 +1000
Message-Id: <1161658168.2149.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pDEacQvNP/NKjY1gpWsd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-03 at 16:53 -0500, Jake Moilanen wrote:
> On Fri, 2006-09-29 at 07:53 +1000, Michael Ellerman wrote:
> > Powerpc MSI support via RTAS. Based on Jake's code.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > ---
> >=20
> >  arch/powerpc/kernel/Makefile   |    1=20
> >  arch/powerpc/kernel/msi-rtas.c |  246 ++++++++++++++++++++++++++++++++=
+++++++++
> >  2 files changed, 247 insertions(+)
> >=20
> > Index: to-merge/arch/powerpc/kernel/Makefile
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- to-merge.orig/arch/powerpc/kernel/Makefile
> > +++ to-merge/arch/powerpc/kernel/Makefile
> > @@ -69,6 +69,7 @@ pci32-$(CONFIG_PPC32)		:=3D pci_32.o
> >  obj-$(CONFIG_PCI)		+=3D $(pci64-y) $(pci32-y)
> > =20
> >  msiobj-y			:=3D msi.o
> > +msiobj-$(CONFIG_PPC_PSERIES)	+=3D msi-rtas.o
> >  obj-$(CONFIG_PCI_MSI)		+=3D $(msiobj-y)
> > =20
> >  kexec-$(CONFIG_PPC64)		:=3D machine_kexec_64.o
> > Index: to-merge/arch/powerpc/kernel/msi-rtas.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- /dev/null
> > +++ to-merge/arch/powerpc/kernel/msi-rtas.c
> > @@ -0,0 +1,246 @@
> > +/*
> > + * Copyright (C) 2006 Jake Moilanen <moilanen@austin.ibm.com>, IBM Cor=
p.
> > + * Copyright (C) 2006 Michael Ellerman, IBM Corp.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; version 2 of the
> > + * License.
> > + *
> > + */
> > +
> > +#define DEBUG 1
> > +
> > +#include <linux/irq.h>
> > +#include <asm/msi.h>
> > +#include <asm/rtas.h>
> > +#include <asm/hw_irq.h>
> > +#include <asm/ppc-pci.h>
> > +
> > +static int query_token, change_token;
> > +
> > +#define RTAS_QUERY_MSI_FN	0
> > +#define RTAS_CHANGE_MSI_FN	1
> > +#define RTAS_RESET_MSI_FN	2
> > +
> > +
> > +/* RTAS Helpers */
> > +
> > +static int rtas_change_msi(struct pci_dn *pdn, u32 function, u32 num_i=
rqs)
> > +{
> > +	u32 addr, seq_num, rtas_ret[2];
> > +	unsigned long buid;
> > +	int rc;
> > +
> > +	addr =3D rtas_config_addr(pdn->busno, pdn->devfn, 0);
> > +	buid =3D pdn->phb->buid;
> > +
> > +	seq_num =3D 1;
> > +	do {
> > +		rc =3D rtas_call(change_token, 6, 3, rtas_ret, addr,
> > +				BUID_HI(buid), BUID_LO(buid),
> > +				function, num_irqs, seq_num);
>=20
> This call is still currently broken in firmware.  Hopefully we'll have a
> resolution soon.

Any word on that?

> > +
> > +		seq_num =3D rtas_ret[1];
> > +	} while (rtas_busy_delay(rc));
> > +
> > +	if (rc) {
> > +		printk(KERN_WARNING "Error[%d]: getting the number of"
> > +			" MSI interrupts for %s\n", rc, pci_name(pdn->pcidev));
> > +		return rc;
> > +	}
> > +
> > +	return rtas_ret[0];
> > +}
> > +
> > +static int rtas_query_irq_number(struct pci_dn *pdn, int offset)
> > +{
> > +	u32 addr, rtas_ret[2];
> > +	unsigned long buid;
> > +	int rc;
> > +
> > +	addr =3D rtas_config_addr(pdn->busno, pdn->devfn, 0);
> > +	buid =3D pdn->phb->buid;
> > +
> > +	do {
> > +		rc =3D rtas_call(query_token, 4, 3, rtas_ret, addr,
> > +			       BUID_HI(buid), BUID_LO(buid), offset);
> > +	} while (rtas_busy_delay(rc));
> > +
> > +	if (rc) {
> > +		printk(KERN_WARNING "Error[%d]: Querying irq source number "
> > +				"for %s\n", rc, pci_name(pdn->pcidev));
> > +		return rc;
> > +	}
> > +
> > +	return rtas_ret[0];
> > +}
> > +
> > +/*
> > + * The spec gives firmware the option to enable either MSI or MSI-X,
> > + * this doesn't wash with the Linux API. For the time beinging, we
> > + * kludge around that by checking ourselves the right type is enabled.
> > + */
> > +static int check_msi_type(struct pci_dev *pdev, int type)
> > +{
> > +	int pos, msi_enabled, msix_enabled;
> > +	u16 reg;
> > +
> > +	pos =3D pci_find_capability(pdev, PCI_CAP_ID_MSI);
> > +	if (!pos)
> > +		return -1;
> > +
> > +	pci_read_config_word(pdev, pos + PCI_MSI_FLAGS, &reg);
> > +
> > +	msi_enabled =3D msix_enabled =3D 0;
> > +
> > +	if (reg & PCI_MSI_FLAGS_ENABLE)
> > +		msi_enabled =3D 1;
> > +
>=20
> This is not being set correctly by firmware either. I have them looking
> into the problem.

Are you sure? I don't see how MSI could possibly work if they don't
enable it on the device itself. Or is it completely broken at the
moment?

>=20
> > +	if (reg & PCI_MSIX_FLAGS_ENABLE)
> > +		msix_enabled =3D 1;
> > +
> > +	if (type =3D=3D PCI_CAP_ID_MSI && (msix_enabled || !msi_enabled)) {
> > +		pr_debug("check_msi_type: Expected MSI but got %s.\n",
> > +			msix_enabled ? "MSI-X" : "none");
> > +		return -1;
> > +	}
> > +
> > +	if (type =3D=3D PCI_CAP_ID_MSIX && (msi_enabled || !msix_enabled)) {
> > +		pr_debug("check_msi_type: Expected MSI-X but got %s.\n",
> > +			msi_enabled ? "MSI" : "none");
> > +		return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void msi_rtas_free(struct pci_dev *pdev, int num,
> > +			struct msix_entry *entries, int type)
> > +{
> > +	struct device_node *dn;
> > +	struct pci_dn *pdn;
> > +	int i;
> > +
> > +	dn =3D pci_device_to_OF_node(pdev);
> > +	if (!dn) {
> > +		pr_debug("msi_rtas_free: No OF device node for %s\n",
> > +				pci_name(pdev));
> > +		return;
> > +	}
> > +
> > +	pdn =3D PCI_DN(dn);
> > +	if (!pdn) {
> > +		pr_debug("msi_rtas_free: No PCI DN for %s\n",
> > +				pci_name(pdev));
> > +		return;
> > +	}
> > +
> > +	for (i =3D 0; i < num; i++) {
> > +		irq_dispose_mapping(entries[i].vector);
> > +	}
> > +
> > +	/* XXX can we do anything sane if this fails? */
> > +	rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, 0);
> > +}
> > +
> > +static int msi_rtas_check(struct pci_dev *pdev, int num,
> > +			struct msix_entry *entries, int type)
> > +{
> > +	struct device_node *dn;
> > +	int i;
> > +
> > +	dn =3D pci_device_to_OF_node(pdev);
> > +
> > +	if (!of_find_property(dn, "ibm,req#msi", NULL)) {
> > +		pr_debug("msi_rtas_check: No ibm,req#msi for %s\n",
> > +				pci_name(pdev));
> > +		return -1;
> > +	}
> > +
> > +	/*
> > +	 * Firmware gives us no control over which entries are allocated
> > +	 * for MSI-X, it seems to assume we want 0 - n. For now just insist
> > +	 * that the entries array entry members are 0 - n.
> > +	 */
> > +	for (i =3D 0; i < num; i++) {
> > +		if (entries[i].entry !=3D i) {
> > +			pr_debug("msi_rtas_check: entries[i].entry !=3D i\n");
> > +			return -1;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int msi_rtas_alloc(struct pci_dev *pdev, int num,
> > +			struct msix_entry *entries, int type)
> > +{
> > +	struct pci_dn *pdn;
> > +	int hwirq, virq, i;
> > +
> > +	pdn =3D PCI_DN(pci_device_to_OF_node(pdev));
> > +
> > +	/*
> > +	 * In the case of an error it's not clear whether the device is left
> > +	 * with MSI enabled or not, I think we should explicitly disable.
> > +	 */
> > +	if (rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, num) !=3D num)
> > +		goto out_free;
> > +
> > +	if (check_msi_type(pdev, type))
> > +		goto out_free;
> > +
> > +	for (i =3D 0; i < num; i++) {
> > +		hwirq =3D rtas_query_irq_number(pdn, i);
> > +		if (hwirq < 0)
> > +			goto out_free;
> > +
> > +		virq =3D irq_create_mapping(NULL, hwirq);
> > +
> > +		if (virq =3D=3D NO_IRQ) {
> > +			pr_debug("msi_rtas_alloc: Failed mapping hwirq %d\n",
> > +				hwirq);
> > +			goto out_free;
> > +		}
> > +
> > +		entries[i].vector =3D virq;
> > +	}
> > +
> > +	return 0;
> > +
> > + out_free:
> > +	msi_rtas_free(pdev, num, entries, type);
>=20
> Shouldn't this be:
>=20
> 	msi_rtas_free(pdev, i,.......
>=20
> Otherwise you'll try freeing unallocated entries.

Yeah maybe. I think I was intending that free be written in such a way
that it could cope with tearing down a partial setup, but I never got
round to writing the patch for irq_dispose_mapping() to make that work -
I should do that.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-pDEacQvNP/NKjY1gpWsd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFPX83dSjSd0sB4dIRAkCSAKCQ72CX7b77km7Pr/n6wMgvHQJO2ACfYpuQ
PClLg1VdawMKJo5wWFAmXjI=
=Pe/Z
-----END PGP SIGNATURE-----

--=-pDEacQvNP/NKjY1gpWsd--

