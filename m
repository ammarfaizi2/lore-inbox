Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUBKGSE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 01:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUBKGSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 01:18:04 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:7382 "EHLO fed1mtao05.cox.net")
	by vger.kernel.org with ESMTP id S263646AbUBKGSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 01:18:00 -0500
Date: Tue, 10 Feb 2004 23:17:53 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Martin Diehl <lists@mdiehl.de>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] dma_sync_to_device
Message-ID: <20040211061753.GA22167@plexity.net>
Reply-To: dsaxena@plexity.net
References: <Pine.LNX.4.44.0402101815550.2349-100000@notebook.home.mdiehl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402101815550.2349-100000@notebook.home.mdiehl.de>
User-Agent: Mutt/1.3.28i
Organization: Plexity Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 10 2004, at 18:31, Martin Diehl was caught saying:
[snip]
> --- linux-2.6.0-test8/Documentation/DMA-mapping.txt	Wed Oct  8 21:24:06 2003
> +++ v2.6.0-test8-md/Documentation/DMA-mapping.txt	Tue Oct 21 11:27:17 2003
> @@ -543,8 +543,11 @@
>  all bus addresses.
>  
>  If you need to use the same streaming DMA region multiple times and touch
> -the data in between the DMA transfers, just map it with
> -pci_map_{single,sg}, and after each DMA transfer call either:
> +the data in between the DMA transfers, the buffer needs to be synced
> +depending on the transfer direction.
> +
> +When reading from the device, just map it with pci_map_{single,sg},
> +and after each DMA transfer call either:
>  
>  	pci_dma_sync_single(dev, dma_handle, size, direction);
>  
> @@ -553,6 +556,20 @@
>  	pci_dma_sync_sg(dev, sglist, nents, direction);
>  
>  as appropriate.
> +
> +When writing to the mapped the buffer, prepare the data and
> +then before giving the buffer to the hardware call either:
> +
> +	pci_dma_sync_to_device_single(dev, dma_handle, size, direction);
> +
> +or:
> +
> +	pci_dma_sync_to_device_sg(dev, sglist, nents, direction);

Maybe I am missunderstanding something, but how is this
any different than simply doing:

	pci_dma_sync_single(dev, dma_handle, size, DMA_TO_DEVICE);

My understanding of the API is that I can map a buffer
as DMA_BIDIRECTIONAL and then specify the direction. An
existing working example is in the eepro100 driver 
in speedo_init_rx_ring():

   sp->rx_ring_dma[i] = pci_map_single(sp->pdev, rxf, 
              PKT_BUF_SZ + sizeof(struct RxFD), PCI_DMA_BIDIRECTIONAL);

later in the same function:
   
   pci_dma_sync_single(sp->pdev, sp->rx_ring_dma[i],
              sizeof(struct RxFD), PCI_DMA_TODEVICE);

If this is not allowed, then the docs and this driver
(along with any others using it) need to be updated.
If this acceptable, why add an existing function to
achieve the same goal?

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/
