Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267682AbUBRSDD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 13:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267681AbUBRSDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 13:03:03 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:29914 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267643AbUBRSCu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 13:02:50 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com
Subject: Re: [2.6 PATCH] Altix update
Date: Wed, 18 Feb 2004 19:08:57 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <200402181441.i1IEfIWX024531@fsgi900.americas.sgi.com>
In-Reply-To: <200402181441.i1IEfIWX024531@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402181908.57797.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ just a random nitpicking :-) ]

> +/*
> + * sn_alloc_pci_sysdata() - This routine allocates a pci controller
> + *	which is expected as the pci_dev and pci_bus sysdata by the Linux
> + *      PCI infrastructure.
> + */
> +struct pci_controller *
> +sn_alloc_pci_sysdata(void)

this can be static

> +	pci_sysdata = sn_alloc_pci_sysdata();
> +	if  (!pci_sysdata) {
> +		printk(KERN_WARNING "sn_pci_fixup_bus(): Unable to "
> +			       "allocate memory for pci_sysdata\n");
> +		return -ENOMEM;
> +	}
> +	widget_sysdata = kmalloc(sizeof(struct sn_widget_sysdata),
> +				 GFP_KERNEL);
> +	if (!widget_sysdata) {
> +		printk(KERN_WARNING "sn_pci_fixup_bus(): Unable to "
> +			       "allocate memory for widget_sysdata\n");
> +		return -ENOMEM;
> +	}

in case of -ENOMEM pci_sysdata is leaked

> +	/* Allocate a controller structure */
> +	pci_sysdata = sn_alloc_pci_sysdata();
> +	if (!pci_sysdata) {
> +		printk(KERN_WARNING "sn_pci_fixup_slot: Unable to "
> +			       "allocate memory for pci_sysdata\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Set the device vertex */
> +	device_sysdata = kmalloc(sizeof(struct sn_device_sysdata), GFP_KERNEL);
> +	if (!device_sysdata) {
> +		printk(KERN_WARNING "sn_pci_fixup_slot: Unable to "
> +			       "allocate memory for device_sysdata\n");
> +		return -ENOMEM;
> +	}

same pci_sysdata leak on error

> +	/* Allocate the IORESOURCE_IO space first */
> +        for (idx = 0; idx < PCI_ROM_RESOURCE; idx++) {
> +                unsigned long start, end, addr;
> +
> +		device_sysdata->pio_map[idx] = NULL;
> +
> +                if (!(dev->resource[idx].flags & IORESOURCE_IO))
> +                        continue;
> +
> +                start = dev->resource[idx].start;
> +                end = dev->resource[idx].end;
> +                size = end - start;
> +                if (!size)
> +                        continue;
> +
> +                addr = (unsigned long)pciio_pio_addr(vhdl, 0,
> +                                PCIIO_SPACE_WIN(idx), 0, size,
> +				&device_sysdata->pio_map[idx], 0);
> +
> +                if (!addr) {
> +                        dev->resource[idx].start = 0;
> +                        dev->resource[idx].end = 0;
> +                        printk("sn_pci_fixup(): pio map failure for "
> +                            "%s bar%d\n", dev->slot_name, idx);
> +                } else {
> +                        addr |= __IA64_UNCACHED_OFFSET;
> +                        dev->resource[idx].start = addr;
> +                        dev->resource[idx].end = addr + size;
> +                }
> +
> +                if (dev->resource[idx].flags & IORESOURCE_IO)
> +                        cmd |= PCI_COMMAND_IO;
> +        }

Can dev->resource[idx].flags be modified by pciio_pio_addr()?
If not the last if() is redundant.

> +        /* Allocate the IORESOURCE_MEM space next */
> +        for (idx = 0; idx < PCI_ROM_RESOURCE; idx++) {
> +                unsigned long start, end, addr;
> +
> +                if ((dev->resource[idx].flags & IORESOURCE_IO))
> +                        continue;
> +
> +                start = dev->resource[idx].start;
> +                end = dev->resource[idx].end;
> +                size = end - start;
> +                if (!size)
> +                        continue;
> +
> +                addr = (unsigned long)pciio_pio_addr(vhdl, 0,
> +                                PCIIO_SPACE_WIN(idx), 0, size,
> +				&device_sysdata->pio_map[idx], 0);
> +
> +                if (!addr) {
> +                        dev->resource[idx].start = 0;
> +                        dev->resource[idx].end = 0;
> +                        printk("sn_pci_fixup(): pio map failure for "
> +                            "%s bar%d\n", dev->slot_name, idx);
> +                } else {
> +                        addr |= __IA64_UNCACHED_OFFSET;
> +                        dev->resource[idx].start = addr;
> +                        dev->resource[idx].end = addr + size;
> +                }
> +
> +                if (dev->resource[idx].flags & IORESOURCE_MEM)
> +                        cmd |= PCI_COMMAND_MEMORY;
> +	}

whitespaces damage and spaces vs tabs (there is more in the patch)

IORESOURCE_IO and IORESOURCE_MEM cases beg for common helper function,
static int sn_pci_set_resource(struct pci_dev *dev, unsigned long flag)?

> +	/*
> +	 * Update the Command Word on the Card.
> +	 */
> +	cmd |= PCI_COMMAND_MASTER; /* If the device doesn't support */
> +				   /* bit gets dropped .. no harm */
> +	pci_write_config_word(dev, PCI_COMMAND, cmd);
> +
> +	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, (unsigned char *)&lines);
> +	device_vertex = device_sysdata->vhdl;
> +	pci_provider = device_sysdata->pci_provider;
> +	device_sysdata->intr_handle = NULL;
> +
> +	if (!lines)
> +		return 0;
> +
> +	irqpdaindr->curr = dev;
> +
> +	intr_handle = (pci_provider->intr_alloc)(device_vertex, NULL, lines,
> device_vertex); +	if (intr_handle == NULL) {
> +		printk(KERN_WARNING "sn_pci_fixup:  pcibr_intr_alloc() failed\n");
> +		return -ENOMEM;
> +	}

pci_sysdata and device_sysdata leak on error

Cheers,
--bart

