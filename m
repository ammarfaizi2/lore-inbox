Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWELLIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWELLIL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWELLIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:08:11 -0400
Received: from mivlgu.ru ([81.18.140.87]:34475 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751205AbWELLIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:08:10 -0400
Date: Fri, 12 May 2006 15:08:07 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Michael Buesch <mb@bu3sch.de>
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/9] Add Intel HW RNG driver
Message-ID: <20060512110807.GB19254@master.mivlgu.local>
References: <20060512103522.898597000@bu3sch.de> <20060512103647.777856000@bu3sch.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <20060512103647.777856000@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2006 at 12:35:25PM +0200, Michael Buesch wrote:
> Index: hwrng/drivers/char/hw_random/intel-rng.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ hwrng/drivers/char/hw_random/intel-rng.c	2006-05-08 00:11:35.00000000=
0 +0200
> @@ -0,0 +1,198 @@
> +/*
> + * RNG driver for Intel RNGs
> + *
> + * Copyright 2005 (c) MontaVista Software, Inc.
> + *
> + * with the majority of the code coming from:
> + *
> + * Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
> + * (c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
> + *
> + * derived from
> + *
> + * Hardware driver for the AMD 768 Random Number Generator (RNG)
> + * (c) Copyright 2001 Red Hat Inc <alan@redhat.com>
> + *
> + * derived from
> + *
> + * Hardware driver for Intel i810 Random Number Generator (RNG)
> + * Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
> + * Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
> + *
> + * This file is licensed under  the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/hw_random.h>
> +#include <asm/io.h>
> +
> +
> +#define PFX	KBUILD_MODNAME ": "
> +
> +/*
> + * RNG registers
> + */
> +#define INTEL_RNG_HW_STATUS			0
> +#define         INTEL_RNG_PRESENT		0x40
> +#define         INTEL_RNG_ENABLED		0x01
> +#define INTEL_RNG_STATUS			1
> +#define         INTEL_RNG_DATA_PRESENT		0x01
> +#define INTEL_RNG_DATA				2
> +
> +/*
> + * Magic address at which Intel PCI bridges locate the RNG
> + */
> +#define INTEL_RNG_ADDR				0xFFBC015F
> +#define INTEL_RNG_ADDR_LEN			3
> +
> +/*
> + * Data for PCI driver interface
> + *
> + * This data only exists for exporting the supported
> + * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
> + * register a pci_driver, because someone else might one day
> + * want to register another driver on the same PCI id.
> + */
> +static struct pci_device_id pci_tbl[] =3D {

Should be const.

> +	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
> +	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
> +	{ 0x8086, 0x2430, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
> +	{ 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
> +	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
> +	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
> +	{ 0, },	/* terminate list */
> +};
> +MODULE_DEVICE_TABLE(pci, pci_tbl);
> +
> +
> +static inline u8 hwstatus_get(void __iomem *mem)
> +{
> +	return readb(mem + INTEL_RNG_HW_STATUS);
> +}
> +
> +static inline u8 hwstatus_set(void __iomem *mem,
> +			      u8 hw_status)
> +{
> +	writeb(hw_status, mem + INTEL_RNG_HW_STATUS);
> +	return hwstatus_get(mem);
> +}
> +
> +static int intel_rng_data_present(struct hwrng *rng)
> +{
> +	void __iomem *mem =3D (void __iomem *)rng->priv;
> +
> +	return !!(readb(mem + INTEL_RNG_STATUS) & INTEL_RNG_DATA_PRESENT);
> +}
> +
> +static int intel_rng_data_read(struct hwrng *rng, u32 *data)
> +{
> +	void __iomem *mem =3D (void __iomem *)rng->priv;
> +
> +	*data =3D readb(mem + INTEL_RNG_DATA);
> +
> +	return 1;
> +}
> +
> +static int intel_rng_init(struct hwrng *rng)
> +{
> +	void __iomem *mem =3D (void __iomem *)rng->priv;
> +	u8 hw_status;
> +	int err =3D -EIO;
> +
> +	hw_status =3D hwstatus_get(mem);
> +	/* turn RNG h/w on, if it's off */
> +	if ((hw_status & INTEL_RNG_ENABLED) =3D=3D 0)
> +		hw_status =3D hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
> +	if ((hw_status & INTEL_RNG_ENABLED) =3D=3D 0) {
> +		printk(KERN_ERR PFX "cannot enable RNG, aborting\n");
> +		goto out;
> +	}
> +	err =3D 0;
> +out:
> +	return err;
> +}
> +
> +static void intel_rng_cleanup(struct hwrng *rng)
> +{
> +	void __iomem *mem =3D (void __iomem *)rng->priv;
> +	u8 hw_status;
> +
> +	hw_status =3D hwstatus_get(mem);
> +	if (hw_status & INTEL_RNG_ENABLED)
> +		hwstatus_set(mem, hw_status & ~INTEL_RNG_ENABLED);
> +	else
> +		printk(KERN_WARNING PFX "unusual: RNG already disabled\n");
> +}
> +
> +
> +static struct hwrng intel_rng =3D {
> +	.name		=3D "intel",
> +	.init		=3D intel_rng_init,
> +	.cleanup	=3D intel_rng_cleanup,
> +	.data_present	=3D intel_rng_data_present,
> +	.data_read	=3D intel_rng_data_read,
> +};
> +
> +
> +static int __init mod_init(void)
> +{
> +	int err =3D -ENODEV;
> +	struct pci_dev *pdev =3D NULL;
> +	const struct pci_device_id *ent;
> +	void __iomem *mem;
> +	u8 hw_status;
> +
> +	for_each_pci_dev(pdev) {
> +		ent =3D pci_match_id(pci_tbl, pdev);
> +		if (ent)
> +			goto found;
> +	}
> +	/* Device not found. */
> +	goto out;

	if (!pci_dev_present(pci_tbl))
		goto out;

> +
> +found:
> +	err =3D -ENOMEM;
> +	mem =3D ioremap(INTEL_RNG_ADDR, INTEL_RNG_ADDR_LEN);
> +	if (!mem)
> +		goto out;
> +	intel_rng.priv =3D (unsigned long)mem;
> +
> +	/* Check for Intel 82802 */
> +	err =3D -ENODEV;
> +	hw_status =3D hwstatus_get(mem);
> +	if ((hw_status & INTEL_RNG_PRESENT) =3D=3D 0)
> +		goto err_unmap;
> +
> +	printk(KERN_INFO "Intel 82802 RNG detected\n");
> +	err =3D hwrng_register(&intel_rng);
> +	if (err) {
> +		printk(KERN_ERR PFX "RNG registering failed (%d)\n",
> +		       err);
> +		goto out;

		goto err_unmap;

> +	}
> +out:
> +	return err;
> +
> +err_unmap:
> +	iounmap(mem);
> +	goto out;
> +}
> +
> +static void __exit mod_exit(void)
> +{
> +	void __iomem *mem =3D (void __iomem *)intel_rng.priv;
> +
> +	hwrng_unregister(&intel_rng);
> +	iounmap(mem);
> +}
> +
> +subsys_initcall(mod_init);
> +module_exit(mod_exit);
> +
> +MODULE_AUTHOR("The Linux Kernel team");
> +MODULE_DESCRIPTION("H/W RNG driver for Intel chipsets");
> +MODULE_LICENSE("GPL");
>=20
> --

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEZGyXW82GfkQfsqIRAgNEAJsHiT3YdB3NgJOEZRzZi4Zj4WKxlgCfYDAp
7yL9kmumoUI7BDVA09FSzsM=
=jvRx
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
