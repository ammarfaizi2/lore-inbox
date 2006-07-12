Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWGLUgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWGLUgZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 16:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWGLUgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 16:36:25 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:59864 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751183AbWGLUgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 16:36:24 -0400
Message-ID: <44B55D45.9000708@garzik.org>
Date: Wed, 12 Jul 2006 16:36:21 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jeremy Higdon <jeremy@sgi.com>, John Keller <jpk@sgi.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/1] - sgiioc4: fixup use of mmio ops
References: <20060712175714.16943.10799.sendpatchset@attica.americas.sgi.com> <20060712195248.GB740565@sgi.com>
In-Reply-To: <20060712195248.GB740565@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Higdon wrote:
>> @@ -381,7 +381,7 @@ ide_dma_sgiioc4(ide_hwif_t * hwif, unsig
>>  		goto dma_alloc_failure;
>>  	}
>>  
>> -	hwif->dma_base = dma_base;
>> +	hwif->dma_base = (unsigned long) ioremap(dma_base, num_ports);
>>  	hwif->dmatable_cpu = pci_alloc_consistent(hwif->pci_dev,
>>  					  IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
>>  					  &hwif->dmatable_dma);

adding a bug:  must check for NULL ioremap return value


>> @@ -607,18 +607,14 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
>>  	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
>>  	hwif->ide_dma_timeout = &__ide_dma_timeout;
>>  
>> -	/*
>> -	 * The IOC4 uses MMIO rather than Port IO.
>> -	 * It also needs special workarounds for INB.
>> -	 */
>> -	default_hwif_mmiops(hwif);
>>  	hwif->INB = &sgiioc4_INB;
>>  }
>>  
>>  static int __devinit
>>  sgiioc4_ide_setup_pci_device(struct pci_dev *dev, ide_pci_device_t * d)
>>  {
>> -	unsigned long base, ctl, dma_base, irqport;
>> +	unsigned long ctl, dma_base, irqport;
>> +	unsigned long bar0, cmd_base, cmd_phys_base, virt_base;

New code should use 'void __iomem *' for ioremap return values, wherever 
possible.


>>  	ide_hwif_t *hwif;
>>  	int h;
>>  
>> @@ -636,23 +632,27 @@ sgiioc4_ide_setup_pci_device(struct pci_
>>  	}
>>  
>>  	/*  Get the CmdBlk and CtrlBlk Base Registers */
>> -	base = pci_resource_start(dev, 0) + IOC4_CMD_OFFSET;
>> -	ctl = pci_resource_start(dev, 0) + IOC4_CTRL_OFFSET;
>> -	irqport = pci_resource_start(dev, 0) + IOC4_INTR_OFFSET;
>> +	bar0 = pci_resource_start(dev, 0);
>> +	virt_base = (unsigned long) ioremap(bar0, pci_resource_len(dev, 0));
>> +	cmd_base = virt_base + IOC4_CMD_OFFSET;
>> +	ctl = virt_base + IOC4_CTRL_OFFSET;
>> +	irqport = virt_base + IOC4_INTR_OFFSET;
>>  	dma_base = pci_resource_start(dev, 0) + IOC4_DMA_OFFSET;

ditto:  new bug here too


>> -	if (!request_region(base, IOC4_CMD_CTL_BLK_SIZE, hwif->name)) {
>> +	cmd_phys_base = bar0 + IOC4_CMD_OFFSET;
>> +	if (!request_mem_region(cmd_phys_base, IOC4_CMD_CTL_BLK_SIZE,
>> +	    hwif->name)) {
>>  		printk(KERN_ERR
>> -			"%s : %s -- ERROR, Port Addresses "
>> +			"%s : %s -- ERROR, Addresses "
>>  			"0x%p to 0x%p ALREADY in use\n",
>> -		       __FUNCTION__, hwif->name, (void *) base,
>> -		       (void *) base + IOC4_CMD_CTL_BLK_SIZE);
>> +		       __FUNCTION__, hwif->name, (void *) cmd_phys_base,
>> +		       (void *) cmd_phys_base + IOC4_CMD_CTL_BLK_SIZE);

If 'void __iomem *' were used, no casts would be needed here


