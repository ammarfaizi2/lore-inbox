Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbUKSNlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbUKSNlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 08:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbUKSNkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 08:40:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15283 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261411AbUKSNiQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 08:38:16 -0500
Date: Thu, 18 Nov 2004 09:12:36 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Cc: Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: linux-2.4.28 released
Message-ID: <20041118111235.GA26216@logos.cnet>
References: <BF571719A4041A478005EF3F08EA6DF05EB481@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF571719A4041A478005EF3F08EA6DF05EB481@pcsmail03.pcs.pc.ome.toshiba.co.jp>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 06:50:03PM +0900, Tomita, Haruo wrote:
> Hi,
> 
> It seems that combined mode does not work at linux-2.4.28 about
> the ata_piix driver of the Intel 82801EB/82801ER SATA controller
> of Intel 82801EB/82801ER. In using combined mode, 
> I think that the following patches are required. Is this right?

Yes, I think so? Jeff is the man.

I dislike the ____request_resource() hack, it has been rejected and 
Jeff agreed with me here.

> diff -urN linux-2.4.28.orig/drivers/ide/pci/piix.c linux-2.4.28/drivers/ide/pci/piix.c
> --- linux-2.4.28.orig/drivers/ide/pci/piix.c	2004-11-17 20:54:21.000000000 +0900
> +++ linux-2.4.28/drivers/ide/pci/piix.c	2004-11-18 16:40:10.000000000 +0900
> @@ -143,6 +143,7 @@
>  		p += sprintf(p, "\n                                Intel ");
>  		switch(dev->device) {
>  			case PCI_DEVICE_ID_INTEL_82801EB_1:
> +			case PCI_DEVICE_ID_INTEL_ESB_3:
>  				p += sprintf(p, "PIIX4 SATA 150 ");
>  				break;
>  			case PCI_DEVICE_ID_INTEL_82801BA_8:
> @@ -281,6 +282,7 @@
>  
>  	switch(dev->device) {
>  		case PCI_DEVICE_ID_INTEL_82801EB_1:
> +		case PCI_DEVICE_ID_INTEL_ESB_3:
>  			mode = 3;
>  			break;
>  		/* UDMA 100 capable */
> @@ -881,7 +883,10 @@
>   	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18},
>  #endif
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19},
> -	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
> +#ifdef CONFIG_BLK_DEV_IDE_SATA
> +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
> +#endif
> +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 21},
>  	{ 0, },
>  };
>  
> diff -urN linux-2.4.28.orig/drivers/ide/pci/piix.h linux-2.4.28/drivers/ide/pci/piix.h
> --- linux-2.4.28.orig/drivers/ide/pci/piix.h	2004-04-14 22:05:30.000000000 +0900
> +++ linux-2.4.28/drivers/ide/pci/piix.h	2004-11-18 16:40:10.000000000 +0900
> @@ -321,6 +321,20 @@
>  		.extra		= 0,
>  	},{	/* 20 */
>  		.vendor		= PCI_VENDOR_ID_INTEL,
> +		.device		= PCI_DEVICE_ID_INTEL_ESB_3,
> +		.name		= "ICH5-SATA",
> +		.init_setup	= init_setup_piix,
> +		.init_chipset	= init_chipset_piix,
> +		.init_iops	= NULL,
> +		.init_hwif	= init_hwif_piix,
> +		.init_dma	= init_dma_piix,
> +		.channels	= 2,
> +		.autodma	= AUTODMA,
> +		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
> +		.bootable	= ON_BOARD,
> +		.extra		= 0,
> +	},{	/* 21 */
> +		.vendor		= PCI_VENDOR_ID_INTEL,
>  		.device		= PCI_DEVICE_ID_INTEL_ICH6_2,
>  		.name		= "ICH6",
>  		.init_setup	= init_setup_piix,
> diff -urN linux-2.4.28.orig/drivers/pci/quirks.c linux-2.4.28/drivers/pci/quirks.c
> --- linux-2.4.28.orig/drivers/pci/quirks.c	2004-11-17 20:54:21.000000000 +0900
> +++ linux-2.4.28/drivers/pci/quirks.c	2004-11-18 16:34:48.000000000 +0900
> @@ -719,6 +719,79 @@
>  	}
>  }
>  
> +#ifdef CONFIG_SCSI_SATA
> +static void __init quirk_intel_ide_combined(struct pci_dev *pdev)
> +{
> +	u8 prog, comb, tmp;
> +	int ich = 0;
> +
> +	/*
> +	 * Narrow down to Intel SATA PCI devices.
> +	 */
> +	switch (pdev->device) {
> +	/* PCI ids taken from drivers/scsi/ata_piix.c */
> +	case 0x24d1:
> +	case 0x24df:
> +	case 0x25a3:
> +	case 0x25b0:
> +		ich = 5;
> +		break;
> +	case 0x2651:
> +	case 0x2652:
> +	case 0x2653:
> +		ich = 6;
> +		break;
> +	default:
> +		/* we do not handle this PCI device */
> +		return;
> +	}
> +
> +	/*
> +	 * Read combined mode register.
> +	 */
> +	pci_read_config_byte(pdev, 0x90, &tmp);	/* combined mode reg */
> +
> +	if (ich == 5) {
> +		tmp &= 0x6;  /* interesting bits 2:1, PATA primary/secondary */
> +		if (tmp == 0x4)		/* bits 10x */
> +			comb = (1 << 0);	/* SATA port 0, PATA port 1 */
> +		else if (tmp == 0x6)	/* bits 11x */
> +			comb = (1 << 2);	/* PATA port 0, SATA port 1 */
> +		else
> +			return;			/* not in combined mode */
> +	} else {
> +		WARN_ON(ich != 6);
> +		tmp &= 0x3;  /* interesting bits 1:0 */
> +		if (tmp & (1 << 0))
> +			comb = (1 << 2);	/* PATA port 0, SATA port 1 */
> +		else if (tmp & (1 << 1))
> +			comb = (1 << 0);	/* SATA port 0, PATA port 1 */
> +		else
> +			return;			/* not in combined mode */
> +	}
> +
> +	/*
> +	 * Read programming interface register.
> +	 * (Tells us if it's legacy or native mode)
> +	 */
> +	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
> +
> +	/* if SATA port is in native mode, we're ok. */
> +	if (prog & comb)
> +		return;
> +
> +	/* SATA port is in legacy mode.  Reserve port so that
> +	 * IDE driver does not attempt to use it.  If request_region
> +	 * fails, it will be obvious at boot time, so we don't bother
> +	 * checking return values.
> +	 */
> +	if (comb == (1 << 0))
> +		request_region(0x1f0, 8, "libata");	/* port 0 */
> +	else
> +		request_region(0x170, 8, "libata");	/* port 1 */
> +}
> +#endif /* CONFIG_SCSI_SATA */
> +
>  /*
>   *  The main table of quirks.
>   */
> @@ -808,6 +881,14 @@
>  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc },
>  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc },
>  
> +#ifdef CONFIG_SCSI_SATA
> +	/* Fixup BIOSes that configure Parallel ATA (PATA / IDE) and
> +	 * Serial ATA (SATA) into the same PCI ID.
> +	 */
> +	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,
> +	  quirk_intel_ide_combined },
> +#endif /* CONFIG_SCSI_SATA */
> +
>  	{ 0 }
>  };
>  
> diff -urN linux-2.4.28.orig/drivers/scsi/ata_piix.c linux-2.4.28/drivers/scsi/ata_piix.c
> --- linux-2.4.28.orig/drivers/scsi/ata_piix.c	2004-11-17 20:54:21.000000000 +0900
> +++ linux-2.4.28/drivers/scsi/ata_piix.c	2004-11-18 16:23:45.000000000 +0900
> @@ -622,8 +622,7 @@
>  		port_info[pata_chan] = &piix_port_info[ich5_pata];
>  		n_ports++;
>  
> -		printk(KERN_ERR DRV_NAME ": combined mode not supported\n");
> -		return -ENODEV;
> +		printk(KERN_WARNING DRV_NAME ": combined mode detected\n");
>  	}
>  
>  	return ata_pci_init_one(pdev, port_info, n_ports);
> diff -urN linux-2.4.28.orig/drivers/scsi/libata-core.c linux-2.4.28/drivers/scsi/libata-core.c
> --- linux-2.4.28.orig/drivers/scsi/libata-core.c	2004-11-17 20:54:21.000000000 +0900
> +++ linux-2.4.28/drivers/scsi/libata-core.c	2004-11-18 15:48:49.000000000 +0900
> @@ -3457,14 +3457,28 @@
>  		goto err_out;
>  
>  	if (legacy_mode) {
> -		if (!request_region(0x1f0, 8, "libata"))
> -			printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n");
> -		else
> +		if (!request_region(0x1f0, 8, "libata")) {
> +			struct resource *conflict, res;
> +			res.start = 0x1f0;
> +			res.end = 0x1f0 + 8 - 1;
> +			conflict = ____request_resource(&ioport_resource, &res);
> +			if (!strcmp(conflict->name, "libata"))
> +				legacy_mode |= (1 << 0);
> +			else
> +				printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n");
> +		} else
>  			legacy_mode |= (1 << 0);
>  
> -		if (!request_region(0x170, 8, "libata"))
> -			printk(KERN_WARNING "ata: 0x170 IDE port busy\n");
> -		else
> +		if (!request_region(0x170, 8, "libata")) {
> +			struct resource *conflict, res;
> +			res.start = 0x170;
> +			res.end = 0x170 + 8 - 1;
> +			conflict = ____request_resource(&ioport_resource, &res);
> +			if (!strcmp(conflict->name, "libata"))
> +				legacy_mode |= (1 << 1);
> +			else
> +				printk(KERN_WARNING "ata: 0x170 IDE port busy\n");
> +		} else
>  			legacy_mode |= (1 << 1);
>  	}
>  
> diff -urN linux-2.4.28.orig/include/linux/ioport.h linux-2.4.28/include/linux/ioport.h
> --- linux-2.4.28.orig/include/linux/ioport.h	2003-11-29 03:26:21.000000000 +0900
> +++ linux-2.4.28/include/linux/ioport.h	2004-11-18 15:50:45.000000000 +0900
> @@ -85,6 +85,7 @@
>  
>  extern int check_resource(struct resource *root, unsigned long, unsigned long);
>  extern int request_resource(struct resource *root, struct resource *new);
> +extern struct resource * ____request_resource(struct resource *root, struct resource *new);
>  extern int release_resource(struct resource *new);
>  extern int allocate_resource(struct resource *root, struct resource *new,
>  			     unsigned long size,
> diff -urN linux-2.4.28.orig/kernel/ksyms.c linux-2.4.28/kernel/ksyms.c
> --- linux-2.4.28.orig/kernel/ksyms.c	2004-02-18 22:36:32.000000000 +0900
> +++ linux-2.4.28/kernel/ksyms.c	2004-11-18 15:53:19.000000000 +0900
> @@ -448,6 +448,7 @@
>  #endif
>  
>  /* resource handling */
> +EXPORT_SYMBOL_GPL(____request_resource); /* may disappear in a few months */
>  EXPORT_SYMBOL(request_resource);
>  EXPORT_SYMBOL(release_resource);
>  EXPORT_SYMBOL(allocate_resource);
> diff -urN linux-2.4.28.orig/kernel/resource.c linux-2.4.28/kernel/resource.c
> --- linux-2.4.28.orig/kernel/resource.c	2003-11-29 03:26:21.000000000 +0900
> +++ linux-2.4.28/kernel/resource.c	2004-11-18 15:53:55.000000000 +0900
> @@ -166,6 +166,16 @@
>  	return conflict ? -EBUSY : 0;
>  }
>  
> +struct resource *____request_resource(struct resource *root, struct resource *new)
> +{
> +	struct resource *conflict;
> +
> +	write_lock(&resource_lock);
> +	conflict = __request_resource(root, new);
> +	write_unlock(&resource_lock);
> +	return conflict;
> +}
> +
>  int release_resource(struct resource *old)
>  {
>  	int retval;
