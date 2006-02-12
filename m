Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWBLROX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWBLROX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWBLROX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:14:23 -0500
Received: from master.altlinux.org ([62.118.250.235]:4623 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751207AbWBLROW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:14:22 -0500
Date: Sun, 12 Feb 2006 20:14:07 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 2/2] [MMC] Secure Digital Host Controller Interface
 driver
Message-Id: <20060212201407.70761172.vsu@altlinux.ru>
In-Reply-To: <20060211001525.10315.30769.stgit@poseidon.drzeus.cx>
References: <20060211001523.10315.34499.stgit@poseidon.drzeus.cx>
	<20060211001525.10315.30769.stgit@poseidon.drzeus.cx>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__12_Feb_2006_20_14_07_+0300_gFC.FF3NN9cYMut7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__12_Feb_2006_20_14_07_+0300_gFC.FF3NN9cYMut7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Feb 2006 01:15:26 +0100 Pierre Ossman wrote:

> +static int __devinit sdhci_probe_slot(struct pci_dev *pdev, int slot)
> +{
> +	int ret;
> +	struct sdhci_chip *chip;
> +	struct mmc_host *mmc;
> +	struct sdhci_host *host;
> +
> +	u8 first_bar;
> +	unsigned int caps;
> +
> +	chip =3D pci_get_drvdata(pdev);
> +	BUG_ON(!chip);
> +
> +	ret =3D pci_read_config_byte(pdev, PCI_SLOT_INFO, &first_bar);
> +	if (ret)
> +		return ret;
> +
> +	first_bar &=3D PCI_SLOT_INFO_FIRST_BAR_MASK;
> +
> +	mmc =3D mmc_alloc_host(sizeof(struct sdhci_host), &pdev->dev);
> +	if (!mmc)
> +		return -ENOMEM;
> +
> +	host =3D mmc_priv(mmc);
> +	host->mmc =3D mmc;
> +
> +	host->bar =3D first_bar + slot;
> +
> +	host->addr =3D pci_resource_start(pdev, host->bar);
> +	host->irq =3D pdev->irq;
> +
> +	DBG("slot %d at 0x%08lx, irq %d\n", slot, host->addr, host->irq);
> +
> +	BUG_ON(!(pci_resource_flags(pdev, first_bar + slot) & IORESOURCE_MEM));

Oopsing the kernel when a broken device is found does not look nice.
Especially when we are not really sure that the device is broken
(because we don't have the official SDHCI spec).

Also, it would be good to sanity check all parameters you fetch from the
device - e.g., host->bar must be <=3D 5, pci_resource_len() of it must be
at least 0x100 - just to be safe in case we don't know about some thing
which exists in the official spec, but is not used by devices
encountered while writing and testing the driver.

> +
> +	snprintf(host->slot_descr, 20, "sdhci:slot%d", slot);
> +
> +	ret =3D pci_request_region(pdev, host->bar, host->slot_descr);
> +	if (ret)
> +		goto free;
> +
> +	host->ioaddr =3D ioremap_nocache(host->addr,
> +		pci_resource_len(pdev, host->bar));
> +	if (!host->ioaddr) {
> +		ret =3D -ENOMEM;
> +		goto release;
> +	}
> +
> +	ret =3D request_irq(host->irq, sdhci_irq, SA_SHIRQ,
> +		host->slot_descr, host);

The interrupt handler can be called immediately after request_irq()
completes (even if you are sure that the device itself cannot generate
interrupts at this point, the interrupt line can be shared).  And
host->lock is not yet initialized - oops...

> +	if (ret)
> +		goto unmap;
> +
> +	caps =3D readl(host->ioaddr + SDHCI_CAPABILITIES);
> +
> +	if ((caps & SDHCI_CAN_DO_DMA) && ((pdev->class & 0x0000FF) =3D=3D 0x01))
> +		host->flags |=3D SDHCI_USE_DMA;
> +
> +	if (host->flags & SDHCI_USE_DMA) {
> +		if (pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
> +			printk(KERN_WARNING "%s: No suitable DMA available. "
> +				"Falling back to PIO.\n", host->slot_descr);
> +			host->flags &=3D ~SDHCI_USE_DMA;
> +		}
> +	}
> +
> +	if (host->flags & SDHCI_USE_DMA)
> +		pci_set_master(pdev);
> +	else /* XXX: Hack to get MMC layer to avoid highmem */
> +		pdev->dma_mask =3D 0;
> +
> +	host->max_clk =3D (caps & SDHCI_CLOCK_BASE_MASK) >> SDHCI_CLOCK_BASE_SH=
IFT;
> +	host->max_clk *=3D 1000000;
> +
> +	/*
> +	 * Set host parameters.
> +	 */
> +	mmc->ops =3D &sdhci_ops;
> +	mmc->f_min =3D host->max_clk / 256;
> +	mmc->f_max =3D host->max_clk;
> +	mmc->ocr_avail =3D MMC_VDD_32_33|MMC_VDD_33_34;
> +	mmc->caps =3D MMC_CAP_4_BIT_DATA;
> +
> +	spin_lock_init(&host->lock);
> +
> +	/*
> +	 * Maximum number of segments. Hardware cannot do scatter lists.
> +	 */
> +	if (host->flags & SDHCI_USE_DMA)
> +		mmc->max_hw_segs =3D 1;
> +	else
> +		mmc->max_hw_segs =3D 16;
> +	mmc->max_phys_segs =3D 16;
> +
> +	/*
> +	 * Maximum number of sectors in one transfer. Limited by sector
> +	 * count register.
> +	 */
> +	mmc->max_sectors =3D 0x3FFF;
> +
> +	/*
> +	 * Maximum segment size. Could be one segment with the maximum number
> +	 * of sectors.
> +	 */
> +	mmc->max_seg_size =3D mmc->max_sectors * 512;
> +
> +	/*
> +	 * Init tasklets.
> +	 */
> +	tasklet_init(&host->card_tasklet,
> +		sdhci_tasklet_card, (unsigned long)host);
> +	tasklet_init(&host->finish_tasklet,
> +		sdhci_tasklet_finish, (unsigned long)host);
> +
> +	init_timer(&host->timer);
> +	host->timer.data =3D (unsigned long)host;
> +	host->timer.function =3D sdhci_timeout_timer;
> +
> +	sdhci_init(host);
> +
> +#ifdef CONFIG_MMC_DEBUG
> +	sdhci_dumpregs(host);
> +#endif
> +
> +	host->chip =3D chip;
> +	chip->hosts[slot] =3D host;
> +
> +	mmc_add_host(mmc);
> +
> +	printk(KERN_INFO "%s: SDHCI at 0x%08lx irq %d %s\n", mmc_hostname(mmc),
> +		host->addr, host->irq,
> +		(host->flags & SDHCI_USE_DMA)?"DMA":"PIO");
> +
> +	return 0;
> +
> +unmap:
> +	iounmap(host->ioaddr);
> +release:
> +	pci_release_region(pdev, host->bar);
> +free:
> +	mmc_free_host(mmc);
> +
> +	return ret;
> +}
> +
> +static void sdhci_remove_slot(struct pci_dev *pdev, int slot)
> +{
> +	struct sdhci_chip *chip;
> +	struct mmc_host *mmc;
> +	struct sdhci_host *host;
> +
> +	chip =3D pci_get_drvdata(pdev);
> +	host =3D chip->hosts[slot];
> +	mmc =3D host->mmc;
> +
> +	chip->hosts[slot] =3D NULL;
> +
> +	mmc_remove_host(mmc);
> +
> +	del_timer_sync(&host->timer);
> +
> +	sdhci_reset(host, SDHCI_RESET_ALL);
> +
> +	tasklet_kill(&host->card_tasklet);
> +	tasklet_kill(&host->finish_tasklet);
> +
> +	iounmap(host->ioaddr);
> +
> +	pci_release_region(pdev, host->bar);
> +
> +	free_irq(host->irq, host);

The same problem as with request_irq(), just from the other side - until
free_irq() returns, you may still get calls to your interrupt handler,
and host->ioaddr is already unmapped - oops again.

> +
> +	mmc_free_host(mmc);
> +}
> +
> +static int __devinit sdhci_probe(struct pci_dev *pdev,
> +	const struct pci_device_id *ent)
> +{
> +	int ret, i;
> +	u8 slots;
> +	struct sdhci_chip *chip;
> +
> +	BUG_ON(pdev =3D=3D NULL);
> +	BUG_ON(ent =3D=3D NULL);

IMHO these BUG_ON() calls are overkill.

[...]
> +typedef struct sdhci_host *sdhci_host_p;

The general policy seems to be "typedefs are evil"...

--Signature=_Sun__12_Feb_2006_20_14_07_+0300_gFC.FF3NN9cYMut7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFD72ziW82GfkQfsqIRAiGTAJ4raTNQ+Km3Z66b1VCxuYWi6jPxJwCdFVs0
Hnmb+hd1SDYIhxc9QDB7jwM=
=Nkt/
-----END PGP SIGNATURE-----

--Signature=_Sun__12_Feb_2006_20_14_07_+0300_gFC.FF3NN9cYMut7--
