Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUBKGuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 01:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbUBKGuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 01:50:00 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:12307 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263927AbUBKGsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 01:48:01 -0500
Date: Wed, 11 Feb 2004 07:51:48 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Deepak Saxena <dsaxena@plexity.net>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] dma_sync_to_device
In-Reply-To: <20040211061753.GA22167@plexity.net>
Message-ID: <Pine.LNX.4.44.0402110729510.2349-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004, Deepak Saxena wrote:

> > +	pci_dma_sync_to_device_single(dev, dma_handle, size, direction);
> 
> Maybe I am missunderstanding something, but how is this
> any different than simply doing:
> 
> 	pci_dma_sync_single(dev, dma_handle, size, DMA_TO_DEVICE);

For i386 you are right: the implementation of pci_dma_sync_single and 
pci_dma_sync_to_device_single happen to be identical. This is because this 
arch is cache-coherent so all we have to do to achieve consistency is 
flushing the buffers. However, for other arch's there might be significant 
dependency on the direction.

The existing pci_dma_sync_single was meant for the FROM_DEVICE direction 
only. I agree it's not entirely obvious currently. But making it 
BIDIRECTIONAL would be pretty expensive on some none cache-coherent archs 
and the whole point of having separate streaming mappings with dedicated 
TO or FROM direction would be void.

> My understanding of the API is that I can map a buffer
> as DMA_BIDIRECTIONAL and then specify the direction. An
> existing working example is in the eepro100 driver 
> in speedo_init_rx_ring():
> 
>    sp->rx_ring_dma[i] = pci_map_single(sp->pdev, rxf, 
>               PKT_BUF_SZ + sizeof(struct RxFD), PCI_DMA_BIDIRECTIONAL);

For an rx_ring I tend to say this should be FROM_DEVICE but would work 
anyway, probably with some unneded overhead when syncing.

> later in the same function:
>    
>    pci_dma_sync_single(sp->pdev, sp->rx_ring_dma[i],
>               sizeof(struct RxFD), PCI_DMA_TODEVICE);

IMHO that's an bug. It happens to work on i386, but currently there's no 
dma-api call to resync the outgoing streaming maps. So if the drivers 
has modified rx_ring_dma and wants to sync so the device will see the 
changes consistently, this might fail on other archs.

And I'm wondering why this driver syncs the rx_ring with direction 
TODDEVICE in the first place - the direction-parameter indicates the 
direction of the dma transfer, not the act of giving buffer ownership to 
the hardware. Is this hardware reading from the rx_ring buffer? Sorry if I 
missunderstood what the rx_ring_dma[] is in this case - if this are just 
the ring descriptors (in contrast to the actual buffers) I believe the 
whole mapping should just be consistent, not streaming.

> If this is not allowed, then the docs and this driver
> (along with any others using it) need to be updated.
> If this acceptable, why add an existing function to
> achieve the same goal?

That's why my patch updates Documentation/DMA-mapping.txt ;-)

Martin

