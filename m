Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbWFNXhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWFNXhu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbWFNXhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:37:50 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:62674 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965037AbWFNXht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:37:49 -0400
Message-ID: <44909DCB.8070300@garzik.org>
Date: Wed, 14 Jun 2006 19:37:47 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Mike Miller <mike.miller@hp.com>, iss_storagedev@hp.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/7] CCISS: announce cciss%d devices with PCI address/IRQ/DAC
 info
References: <200606141707.27404.bjorn.helgaas@hp.com> <200606141710.12182.bjorn.helgaas@hp.com>
In-Reply-To: <200606141710.12182.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> We already print "cciss: using DAC cycles" or similar for every
> adapter found: why not just identify the device we're talking
> about and include other useful information?
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Index: rc6-mm2/drivers/block/cciss.c
> ===================================================================
> --- rc6-mm2.orig/drivers/block/cciss.c	2006-06-14 16:18:20.000000000 -0600
> +++ rc6-mm2/drivers/block/cciss.c	2006-06-14 16:18:29.000000000 -0600
> @@ -3086,11 +3086,8 @@
>  	int i;
>  	int j;
>  	int rc;
> +	int dac;
>  
> -	printk(KERN_DEBUG "cciss: Device 0x%x has been found at"
> -			" bus %d dev %d func %d\n",
> -		pdev->device, pdev->bus->number, PCI_SLOT(pdev->devfn),
> -			PCI_FUNC(pdev->devfn));
>  	i = alloc_cciss_hba();
>  	if(i < 0)
>  		return (-1);
> @@ -3106,11 +3103,11 @@
>  
>  	/* configure PCI DMA stuff */
>  	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK))
> -		printk("cciss: using DAC cycles\n");
> +		dac = 1;
>  	else if (!pci_set_dma_mask(pdev, DMA_32BIT_MASK))
> -		printk("cciss: not using DAC cycles\n");
> +		dac = 0;
>  	else {
> -		printk("cciss: no suitable DMA available\n");
> +		printk(KERN_ERR "cciss: no suitable DMA available\n");
>  		goto clean1;
>  	}
>  
> @@ -3141,6 +3138,11 @@
>  			hba[i]->intr[SIMPLE_MODE_INT], hba[i]->devname);
>  		goto clean2;
>  	}
> +
> +	printk(KERN_INFO "%s: <0x%x> at PCI %s IRQ %d%s using DAC\n",
> +		hba[i]->devname, pdev->device, pci_name(pdev),
> +		hba[i]->intr[SIMPLE_MODE_INT], dac ? "" : " not");

Although this patch is correct, I would consider using dev_printk() 
rather than referencing pci_name() in printk() arguments.

	Jeff



