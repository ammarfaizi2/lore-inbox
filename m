Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271182AbRHONJR>; Wed, 15 Aug 2001 09:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271183AbRHONJI>; Wed, 15 Aug 2001 09:09:08 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:4105 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S271182AbRHONIr>; Wed, 15 Aug 2001 09:08:47 -0400
Date: Wed, 15 Aug 2001 15:10:52 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] zero-bounce highmem I/O
Message-ID: <20010815151052.C4352@suse.de>
In-Reply-To: <20010815131335.H545@suse.de> <20010815.044757.112624116.davem@redhat.com> <20010815140740.A4352@suse.de> <20010815.053524.48804759.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010815.053524.48804759.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15 2001, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Wed, 15 Aug 2001 14:07:40 +0200
> 
>    Ok so you just want to turn scatterlist into what I call sg_list in 2.5
>    time, fine with me too. Depends on whether we want to keep the
>    pci_map_sg and struct scatterlist interface intact, or just break it and
>    tell driver authors they must fix their stuff regardless of whether they
>    want to support highmem. As I write this sentence, it's clear to me
>    which way is the superior :-)
>    
> pci_map_sg is pci_map_sg, if the internal representation of
> scatterlist is changed such that address/alt_address no longer exist,
> it will work on pages only.  Right?  The compatibility mode in

Yes, the pci_* was not my worry. It's the *address case you list below,
but I think you are right that it' not a big issue at that.

> 2.4.x is the "if (address != NULL) virt_to_bus(address);" stuff.

Yes, aka the horrible hack.

> Understand that the pci64_{map,unmap}_sg is created for a seperate
> purpose, independant of whether scatterlist has the backwards
> compatability stuff or not.  (There have been threads here about this,
> I can describe it quickly for you in quiet if you want to know).

I've read these now, been behind on traffic lately.

> Two more things to consider:
> 
> 1) There is nobody who cannot be search&replace converted from
>    	sg->address = ptr
>    into
> 	sg->page = virt_to_page(ptr)
> 	sg->offset = ((unsigned long)ptr & ~PAGE_MASK);
> 
>    The only truly problematic area is the alt_address thing.
>    It is would be a nice thing to rip this eyesore out of the scsi
>    layer anyways.

The SCSI issue was exactly what was on my mind, and is indeed the reason
why I didn't go all the way and did a complete conversion there. The
SCSI layer is _not_ very clean in this regard, didn't exactly enjoy this
part of the work...

> 2) I want to put scatterlist in to replace skb_frag_struct in skbuff.h
>    and then have a zerocopy network driver do something like:
> 
>    	header_dma = pci_map_single(pdev, skb->data, skb->len, PCI_DMA_TODEVICE);
> 	data_nents = pci_map_sg(pdev, skb_shinfo(skb)->frag_list,
> 				skb_shinfo(skb)->nr_frags,
> 				PCI_DMA_TODEVICE);
> 
> See? :-)

Yep, I see where you are going :)

>    Yep. Want me to add in the x86 parts of your patch?
> 
> Please let me finish up my prototype with sparc64 building and
> working, then I'll send you what I have ok?

Fine

-- 
Jens Axboe

