Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWGMNyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWGMNyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWGMNyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:54:47 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:59327 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751053AbWGMNyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:54:46 -0400
From: John Keller <jpk@sgi.com>
Message-Id: <200607131354.k6DDsaqe064559@fcbayern.americas.sgi.com>
Subject: Re: [PATCH 1/1] - sgiioc4: fixup use of mmio ops
To: jeff@garzik.org (Jeff Garzik)
Date: Thu, 13 Jul 2006 08:54:36 -0500 (CDT)
Cc: jeremy@sgi.com (Jeremy Higdon), jpk@sgi.com (John Keller),
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <44B55D45.9000708@garzik.org> from "Jeff Garzik" at Jul 12, 2006 04:36:21 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Jeremy Higdon wrote:
> >> @@ -381,7 +381,7 @@ ide_dma_sgiioc4(ide_hwif_t * hwif, unsig
> >>  		goto dma_alloc_failure;
> >>  	}
> >>  
> >> -	hwif->dma_base = dma_base;
> >> +	hwif->dma_base = (unsigned long) ioremap(dma_base, num_ports);
> >>  	hwif->dmatable_cpu = pci_alloc_consistent(hwif->pci_dev,
> >>  					  IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
> >>  					  &hwif->dmatable_dma);
> 
> adding a bug:  must check for NULL ioremap return value

Shall do.


> 
> 
> >> @@ -607,18 +607,14 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
> >>  	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
> >>  	hwif->ide_dma_timeout = &__ide_dma_timeout;
> >>  
> >> -	/*
> >> -	 * The IOC4 uses MMIO rather than Port IO.
> >> -	 * It also needs special workarounds for INB.
> >> -	 */
> >> -	default_hwif_mmiops(hwif);
> >>  	hwif->INB = &sgiioc4_INB;
> >>  }
> >>  
> >>  static int __devinit
> >>  sgiioc4_ide_setup_pci_device(struct pci_dev *dev, ide_pci_device_t * d)
> >>  {
> >> -	unsigned long base, ctl, dma_base, irqport;
> >> +	unsigned long ctl, dma_base, irqport;
> >> +	unsigned long bar0, cmd_base, cmd_phys_base, virt_base;
> 
> New code should use 'void __iomem *' for ioremap return values, wherever 
> possible.

OK.


> 
> 
> >>  	ide_hwif_t *hwif;
> >>  	int h;
> >>  
> >> @@ -636,23 +632,27 @@ sgiioc4_ide_setup_pci_device(struct pci_
> >>  	}
> >>  
> >>  	/*  Get the CmdBlk and CtrlBlk Base Registers */
> >> -	base = pci_resource_start(dev, 0) + IOC4_CMD_OFFSET;
> >> -	ctl = pci_resource_start(dev, 0) + IOC4_CTRL_OFFSET;
> >> -	irqport = pci_resource_start(dev, 0) + IOC4_INTR_OFFSET;
> >> +	bar0 = pci_resource_start(dev, 0);
> >> +	virt_base = (unsigned long) ioremap(bar0, pci_resource_len(dev, 0));
> >> +	cmd_base = virt_base + IOC4_CMD_OFFSET;
> >> +	ctl = virt_base + IOC4_CTRL_OFFSET;
> >> +	irqport = virt_base + IOC4_INTR_OFFSET;
> >>  	dma_base = pci_resource_start(dev, 0) + IOC4_DMA_OFFSET;
> 
> ditto:  new bug here too

I'll add the check.


> 
> 
> >> -	if (!request_region(base, IOC4_CMD_CTL_BLK_SIZE, hwif->name)) {
> >> +	cmd_phys_base = bar0 + IOC4_CMD_OFFSET;
> >> +	if (!request_mem_region(cmd_phys_base, IOC4_CMD_CTL_BLK_SIZE,
> >> +	    hwif->name)) {
> >>  		printk(KERN_ERR
> >> -			"%s : %s -- ERROR, Port Addresses "
> >> +			"%s : %s -- ERROR, Addresses "
> >>  			"0x%p to 0x%p ALREADY in use\n",
> >> -		       __FUNCTION__, hwif->name, (void *) base,
> >> -		       (void *) base + IOC4_CMD_CTL_BLK_SIZE);
> >> +		       __FUNCTION__, hwif->name, (void *) cmd_phys_base,
> >> +		       (void *) cmd_phys_base + IOC4_CMD_CTL_BLK_SIZE);
> 
> If 'void __iomem *' were used, no casts would be needed here

So, 'void __iomem *' should also be used for physical (non-mapped)
addresses, as in this case?

John
