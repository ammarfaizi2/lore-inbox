Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268508AbTANCTi>; Mon, 13 Jan 2003 21:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268511AbTANCTi>; Mon, 13 Jan 2003 21:19:38 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:9988
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S268508AbTANCTd>; Mon, 13 Jan 2003 21:19:33 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH] PnP update - drivers
Date: Mon, 13 Jan 2003 21:30:27 -0500
User-Agent: KMail/1.6
References: <Pine.LNX.4.33.0301122025520.611-100000@pnote.perex-int.cz> <20030113173906.GA605@neo.rr.com>
In-Reply-To: <20030113173906.GA605@neo.rr.com>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200301132130.27649.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Agreed, Some of those improvements will help us fix old ISA devices that are 
misbehaving.

On Monday 13 January 2003 12:39 pm, Adam Belay wrote:
> On Sun, Jan 12, 2003 at 08:30:57PM +0100, Jaroslav Kysela wrote:
> > Hi,
> >
> > 	this patch must be applied after PnP patch v0.94. It contains my
> > small cleanups of PnP code and I tried to rewrite almost all ISA PnP
> > drivers to new PnP subsystem except sound drivers (ALSA & OSS). Please,
> > apply to get away compilation problems.
> >
> > 						Jaroslav
>
> Hi Jaroslav,
>
> Next time send pnp related changes to me directly.  I would have been happy
> to include your work after I carefully reviewed it.  I was planning to
> merge a very large resource algorithm improvement soon, but now because of
> these changes, that I do not even necessarily agree with, I will be unable
> to include this major improvement and bug fix for a while.  Furthermore
> many people of whom are counting on me to merge thier patches will now be
> dissappointed to hear that their changes, many of which are critical for
> certain pnp hardware configurations will be delayed.
>
> Although I am glad to see the drivers converted, this has been done in a
> way that is not desirable.  They use compat.c which was intended as a
> temporary solution.  In fact I may even remove compat.c all together.  This
> has been clearly stated in both the file compat.c and pnp.txt
> documentation. Attached is a copy of Zwane's ide conversion patch against
> 2.5.56. It can be used as an example of a correct driver conversion. 
> Notice how it is fully integrated into the driver model as all drivers
> should be.
>
> I'm now unhappy with the current pnp code and will most likely revert all
> pnp changes between 2.5.56 and 2.5.57 to avoid a merging nightmare.  I will
> then carefully remerge what I feel is acceptable.
>
> Once again, I'm sorry to those who will be unable to use thier systems due
> to this major set back.  All pnp changes should be sent to me and me only. 
> I believe these pnp change conflicts can easily be worked out with better
> communication.  I intend to make a better effort in the future to explain
> my goals and I hope that you will do the same.  I appreciate your work with
> the pnp layer.
>
> Sincerely,
>
> Adam Belay
> Linux Plug and Play Maintainer
>
>
>
>
>
> ===================================================================
> PnP IDE Conversion from Zwane Mwaikambo
>
>
>
> Index: linux-2.5.56/drivers/ide/ide-pnp.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.5.56/drivers/ide/ide-pnp.c,v
> retrieving revision 1.1.1.1
> diff -u -r1.1.1.1 ide-pnp.c
> --- linux-2.5.56/drivers/ide/ide-pnp.c	16 Dec 2002 05:16:23 -0000	1.1.1.1
> +++ linux-2.5.56/drivers/ide/ide-pnp.c	16 Dec 2002 08:30:39 -0000
> @@ -18,13 +18,11 @@
>
>  #include <linux/ide.h>
>  #include <linux/init.h>
> -
> -#include <linux/isapnp.h>
> +#include <linux/pnp.h>
>
>  #define DEV_IO(dev, index) (dev->resource[index].start)
>  #define DEV_IRQ(dev, index) (dev->irq_resource[index].start)
> -
> -#define DEV_NAME(dev) (dev->bus->name ? dev->bus->name : "ISA PnP")
> +#define DEV_NAME(dev) (dev->protocol->name ? dev->protocol->name : "ISA
> PnP")
>
>  #define GENERIC_HD_DATA		0
>  #define GENERIC_HD_ERROR	1
> @@ -35,125 +33,125 @@
>  #define GENERIC_HD_SELECT	6
>  #define GENERIC_HD_STATUS	7
>
> -static int generic_ide_offsets[IDE_NR_PORTS] __initdata = {
> +static int generic_ide_offsets[IDE_NR_PORTS] = {
>  	GENERIC_HD_DATA, GENERIC_HD_ERROR, GENERIC_HD_NSECTOR,
>  	GENERIC_HD_SECTOR, GENERIC_HD_LCYL, GENERIC_HD_HCYL,
>  	GENERIC_HD_SELECT, GENERIC_HD_STATUS, -1, -1
>  };
>
>  /* ISA PnP device table entry */
> -struct pnp_dev_t {
> -	unsigned short card_vendor, card_device, vendor, device;
> -	int (*init_fn)(struct pci_dev *dev, int enable);
> +struct idepnp_private {
> +	struct pnp_dev *dev;
> +	struct pci_dev pci_dev; /* we need this for the upper layers */
> +	int (*init_fn)(struct idepnp_private *device, int enable);
>  };
>
> -/* Generic initialisation function for ISA PnP IDE interface */
> +/* Barf bags at the ready! Enough to satisfy IDE core */
> +static void pnp_to_pci(struct pnp_dev *pnp_dev, struct pci_dev *pci_dev)
> +{
> +	pci_dev->dev = pnp_dev->dev;
> +	pci_set_drvdata(pci_dev, pnp_get_drvdata(pnp_dev));
> +	pci_dev->irq = DEV_IRQ(pnp_dev, 0);
> +	pci_set_dma_mask(pci_dev, 0x00ffffff);
> +}
>
> -static int __init pnpide_generic_init(struct pci_dev *dev, int enable)
> +/* Generic initialisation function for ISA PnP IDE interface */
> +static int pnpide_generic_init(struct idepnp_private *device, int enable)
>  {
>  	hw_regs_t hw;
>  	ide_hwif_t *hwif;
>  	int index;
> +	struct pnp_dev *dev = device->dev;
>
> -	if (!enable)
> +	if (!enable) {
> +		/* nothing to do for now */
>  		return 0;
> +	}
>
>  	if (!(DEV_IO(dev, 0) && DEV_IO(dev, 1) && DEV_IRQ(dev, 0)))
> -		return 1;
> +		return -EINVAL;
>
>  	ide_setup_ports(&hw, (ide_ioreg_t) DEV_IO(dev, 0),
>  			generic_ide_offsets,
>  			(ide_ioreg_t) DEV_IO(dev, 1),
>  			0, NULL,
> -//			generic_pnp_ide_iops,
> +			/* generic_pnp_ide_iops, */
>  			DEV_IRQ(dev, 0));
>
>  	index = ide_register_hw(&hw, &hwif);
>
>  	if (index != -1) {
>  	    	printk(KERN_INFO "ide%d: %s IDE interface\n", index, DEV_NAME(dev));
> -		hwif->pci_dev = dev;
> +		hwif->pci_dev = &device->pci_dev;
>  		return 0;
>  	}
>
> -	return 1;
> +	return -ENODEV;
>  }
>
>  /* Add your devices here :)) */
> -struct pnp_dev_t idepnp_devices[] __initdata = {
> -  	/* Generic ESDI/IDE/ATA compatible hard disk controller */
> -	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
> -		ISAPNP_VENDOR('P', 'N', 'P'), ISAPNP_DEVICE(0x0600),
> -		pnpide_generic_init },
> -	{	0 }
> +#define IDEPNP_GENERIC_INIT	0
> +static const struct pnp_device_id pnp_ide_devs[] = {
> +	/* Generic ESDI/IDE/ATA compatible hard disk controller */
> +	{"PNP0600", IDEPNP_GENERIC_INIT},
> +	{"", 0}
>  };
>
>  #define NR_PNP_DEVICES 8
> -struct pnp_dev_inst {
> -	struct pci_dev *dev;
> -	struct pnp_dev_t *dev_type;
> -};
> -static struct pnp_dev_inst devices[NR_PNP_DEVICES];
> -static int pnp_ide_dev_idx = 0;
> +/* Nb. pnpide_generic_init is indexed as IDEPNP_GENERIC_INIT */
> +static int (*init_functions[])(struct idepnp_private *device, int enable)
> = {pnpide_generic_init}; +static struct idepnp_private
> devices[NR_PNP_DEVICES];
> +static int pnp_ide_dev_idx;
>
>  /*
>   * Probe for ISA PnP IDE interfaces.
>   */
> -
> -void __init pnpide_init(int enable)
> +static int pnp_ide_probe(struct pnp_dev *pdev, const struct pnp_device_id
> *dev_id) {
> -	struct pci_dev *dev = NULL;
> -	struct pnp_dev_t *dev_type;
> +	int ret;
> +	struct idepnp_private *p;
>
> -	if (!isapnp_present())
> -		return;
> +	/*
> +	 * Register device in the array to
> +	 * deactivate it on a module unload.
> +	 */
> +	if (pnp_ide_dev_idx >= NR_PNP_DEVICES)
> +		return -ENOSPC;
> +
> +	p = &devices[pnp_ide_dev_idx];
> +	p->init_fn = init_functions[dev_id->driver_data];
> +	p->dev = pdev;
> +	pnp_set_drvdata(pdev, p);
> +	pnp_to_pci(p->dev, &p->pci_dev);
> +	ret = p->init_fn(p, 1);
> +	if (!ret)
> +		pnp_ide_dev_idx++;
> +
> +	return ret;
> +}
>
> -	/* Module unload, deactivate all registered devices. */
> -	if (!enable) {
> -		int i;
> -		for (i = 0; i < pnp_ide_dev_idx; i++) {
> -			dev = devices[i].dev;
> -			devices[i].dev_type->init_fn(dev, 0);
> -			if (dev->deactivate)
> -				dev->deactivate(dev);
> -		}
> -		return;
> -	}
> +static void pnp_ide_remove(struct pnp_dev *dev)
> +{
> +	struct idepnp_private *p = pnp_get_drvdata(dev);
> +
> +	/* if p is null you have a bug elsewhere */
> +	p->init_fn(p, 0);
> +	pnp_ide_dev_idx--;
> +	return;
> +}
>
> -	for (dev_type = idepnp_devices; dev_type->vendor; dev_type++) {
> -		while ((dev = isapnp_find_dev(NULL, dev_type->vendor,
> -			dev_type->device, dev))) {
> -
> -			if (dev->active)
> -				continue;
> -
> -       			if (dev->prepare && dev->prepare(dev) < 0) {
> -				printk(KERN_ERR"ide-pnp: %s prepare failed\n", DEV_NAME(dev));
> -				continue;
> -			}
> -
> -			if (dev->activate && dev->activate(dev) < 0) {
> -				printk(KERN_ERR"ide: %s activate failed\n", DEV_NAME(dev));
> -				continue;
> -			}
> -
> -			/* Call device initialization function */
> -			if (dev_type->init_fn(dev, 1)) {
> -				if (dev->deactivate(dev))
> -					dev->deactivate(dev);
> -			} else {
> -#ifdef MODULE
> -				/*
> -				 * Register device in the array to
> -				 * deactivate it on a module unload.
> -				 */
> -				if (pnp_ide_dev_idx >= NR_PNP_DEVICES)
> -					return;
> -				devices[pnp_ide_dev_idx].dev = dev;
> -				devices[pnp_ide_dev_idx].dev_type = dev_type;
> -				pnp_ide_dev_idx++;
> -#endif
> -			}
> -		}
> -	}
> +static struct pnp_driver idepnp_driver = {
> +	.name		= "ide-pnp",
> +	.id_table	= pnp_ide_devs,
> +	.probe		= pnp_ide_probe,
> +	.remove		= pnp_ide_remove
> +};
> +
> +void pnpide_init(int enable)
> +{
> +	if (enable)
> +		pnp_register_driver(&idepnp_driver);
> +	else
> +		pnp_unregister_driver(&idepnp_driver);
>  }
> +
> Index: linux-2.5.56/drivers/ide/ide.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.5.56/drivers/ide/ide.c,v
> retrieving revision 1.1.1.1
> diff -u -r1.1.1.1 ide.c
> --- linux-2.5.56/drivers/ide/ide.c	16 Dec 2002 05:16:22 -0000	1.1.1.1
> +++ linux-2.5.56/drivers/ide/ide.c	16 Dec 2002 08:52:17 -0000
> @@ -2080,7 +2080,7 @@
>  		buddha_init();
>  	}
>  #endif /* CONFIG_BLK_DEV_BUDDHA */
> -#if defined(CONFIG_BLK_DEV_ISAPNP) && defined(CONFIG_ISAPNP)
> +#if defined(CONFIG_BLK_DEV_ISAPNP) && defined(CONFIG_PNP)
>  	{
>  		extern void pnpide_init(int enable);
>  		pnpide_init(1);
> @@ -2256,7 +2256,7 @@
>  		spin_unlock_irqrestore(&ide_lock, flags);
>  		return 1;
>  	}
> -#if defined(CONFIG_BLK_DEV_ISAPNP) && defined(CONFIG_ISAPNP) &&
> defined(MODULE) +#if defined(CONFIG_BLK_DEV_ISAPNP) && defined(CONFIG_PNP)
> && defined(MODULE) pnpide_init(0);
>  #endif /* CONFIG_BLK_DEV_ISAPNP */
>  #ifdef CONFIG_PROC_FS

