Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUBKQjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 11:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265919AbUBKQjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 11:39:18 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:21216 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S265897AbUBKQjK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 11:39:10 -0500
Date: Wed, 11 Feb 2004 09:39:01 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Martin Diehl <lists@mdiehl.de>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] dma_sync_to_device
Message-ID: <20040211163901.GA24446@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040211061753.GA22167@plexity.net> <Pine.LNX.4.44.0402110729510.2349-100000@notebook.home.mdiehl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402110729510.2349-100000@notebook.home.mdiehl.de>
User-Agent: Mutt/1.3.28i
Organization: Plexity Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 11 2004, at 07:51, Martin Diehl was caught saying:
> On Tue, 10 Feb 2004, Deepak Saxena wrote:
> 
> > > +	pci_dma_sync_to_device_single(dev, dma_handle, size, direction);
> > 
> > Maybe I am missunderstanding something, but how is this
> > any different than simply doing:
> > 
> > 	pci_dma_sync_single(dev, dma_handle, size, DMA_TO_DEVICE);
> 
> For i386 you are right: the implementation of pci_dma_sync_single and 
> pci_dma_sync_to_device_single happen to be identical. This is because this 
> arch is cache-coherent so all we have to do to achieve consistency is 
> flushing the buffers. However, for other arch's there might be significant 
> dependency on the direction.
> 
> The existing pci_dma_sync_single was meant for the FROM_DEVICE direction 
> only. I agree it's not entirely obvious currently. But making it 
> BIDIRECTIONAL would be pretty expensive on some none cache-coherent archs 
> and the whole point of having separate streaming mappings with dedicated 
> TO or FROM direction would be void.

If pci_dma_sync_single is for FROM_DEVICE only, than the direction
parameter should go away from it and the from
pci_dma_sync_to_device_single().

> > My understanding of the API is that I can map a buffer
> > as DMA_BIDIRECTIONAL and then specify the direction. An
> > existing working example is in the eepro100 driver 
> > in speedo_init_rx_ring():
> > 
> >    sp->rx_ring_dma[i] = pci_map_single(sp->pdev, rxf, 
> >               PKT_BUF_SZ + sizeof(struct RxFD), PCI_DMA_BIDIRECTIONAL);
> 
> For an rx_ring I tend to say this should be FROM_DEVICE but would work 
> anyway, probably with some unneded overhead when syncing.
> 
> > later in the same function:
> >    
> >    pci_dma_sync_single(sp->pdev, sp->rx_ring_dma[i],
> >               sizeof(struct RxFD), PCI_DMA_TODEVICE);
> 
> IMHO that's an bug. It happens to work on i386, but currently there's no 
> dma-api call to resync the outgoing streaming maps. So if the drivers 
> has modified rx_ring_dma and wants to sync so the device will see the 
> changes consistently, this might fail on other archs.

It works on ARM also, which has no cache coherency at all. This driver
has been in use for years on many architectures, so I think everyone has 
interpreted the mapping API as allowing the above scenario. 

> And I'm wondering why this driver syncs the rx_ring with direction 
> TODDEVICE in the first place - the direction-parameter indicates the 
> direction of the dma transfer, not the act of giving buffer ownership to 
> the hardware. Is this hardware reading from the rx_ring buffer? Sorry if I 
> missunderstood what the rx_ring_dma[] is in this case - if this are just 
> the ring descriptors (in contrast to the actual buffers) I believe the 
> whole mapping should just be consistent, not streaming.

rx_ring_dma is the buffers + descriptors. The eepro100 driver allocates
them both into a skb via  dev_alloc_skb(PKT_BUF_SZ + sizeof(struct RxFD))
and after filling in the RxFD portion (the descriptor), it is syncing
it to the device (cache writeback on ARM) b/c the device will be DMAing.
Consistent mapping wont work b/c they are skbs. Later on, after the
data has arrived, the driver does a sync FROM_DEVICE (cache invalidate
on ARM).

So in this situtation the whole drive would have to be re-architcted
and the RxFD taken out of the skb so that it can be sync'd to the device
and the buffer?  (Not that anyone probably still uses the eepro100 driver,
but a good example of the level of work required).

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/
