Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271574AbRHPMqA>; Thu, 16 Aug 2001 08:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271566AbRHPMpu>; Thu, 16 Aug 2001 08:45:50 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:18692 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S271574AbRHPMpf>; Thu, 16 Aug 2001 08:45:35 -0400
Date: Thu, 16 Aug 2001 14:48:09 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] zero-bounce highmem I/O
Message-ID: <20010816144809.A4352@suse.de>
In-Reply-To: <20010816135150.X4352@suse.de> <20010816.045642.116348743.davem@redhat.com> <20010816140317.Y4352@suse.de> <20010816.052727.68039859.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010816.052727.68039859.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16 2001, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Thu, 16 Aug 2001 14:03:17 +0200
> 
>    > That is why PCI_MAX_DMA32, or whatever you would like to name it, does
>    > not make any sense.  It can be a shorthand for drivers themselves, but
>    > that is it and personally I'd rather they just put the bits there
>    > explicitly.
>    
>    Drivers, right. THe block stuff used it in _one_ place -- the
>    BLK_BOUNCE_4G define, to indicated the need to bounce anything above 4G.
>    But no problem, I can just define that to 0xffffffff myself.
> 
> How can "the block stuff" (ie. generic code) make legal use of this

Block stuff is a crappy name, the block layer :-)

> value?  Which physical bits it may address, this is a device specific
> attribute and has nothing to with with 4GB and highmem and PCI
> standard specifications. :-)

It didn't make use of this value, it merely provided it for _drivers_ to
use. Driver passes in a max dma address, block layer translates that
into a page address. As for 4GB, see below.

> In fact, this is not only a device specific attribute, it also has
> things to do with elements of the platform.
> 
> This is why we have things like pci_dma_supported() and friends.
> Let me give an example, for most PCI controllers on Sparc64 if your
> device can address the upper 2GB of 32-bit PCI space, one may DMA
> to any physical memory location via the IOMMU these controllers have.
> 
> There may easily be HIGHMEM platforms which operate this way.  So the
> result is that CONFIG_HIGHMEM does _not_ mean ">=4GB memory must be
> bounced".
> 
> Really, 0xffffffff is a meaningless value.  You have to test against
> device indicated capabilities for bouncing decisions.

Ok, I see where we are not seeing eye to eye. Really, I meant for the
PCI_MAX_DMA32 value to be 'Max address below 4GB' and not 'Max address
we can DMA to with 32-bit PCI'. Does that make sense? Maybe my
explanations weren't quite clear, and of course it didn't really help
that I shoved it in pci.h :-)

> You do not even know how "addressable bits" translates into "range of
> physical memory that may be DMA'd to/from by device".  If an IOMMU is
> present on the platform, these two things have no relationship
> whatsoever.  These two things happen to have a direct relationship
> on x86, but that is as far as it goes.

That's why I need you to sanity check the cross-platform stuff like
that :-). I see what you mean, point taken. Clearly I need to change the
blk_queue_bounce_limit stuff to check with the PCI capabilities.

> Enough babbling on my part, I'll have a look at your bounce patch
> later today. :-)

Thanks!

-- 
Jens Axboe

