Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVLTRNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVLTRNM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 12:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVLTRNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 12:13:11 -0500
Received: from fmr17.intel.com ([134.134.136.16]:18880 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750778AbVLTRNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 12:13:10 -0500
Subject: Re: IOAT comments
From: Chris Leech <christopher.leech@intel.com>
To: dsaxena@plexity.net
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051220101128.GA28938@plexity.net>
References: <20051220101128.GA28938@plexity.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Dec 2005 09:13:01 -0800
Message-Id: <1135098781.4177.27.camel@cleech-mobl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
X-OriginalArrivalTime: 20 Dec 2005 17:13:04.0518 (UTC) FILETIME=[A39B1A60:01C60588]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 02:11 -0800, Deepak Saxena wrote:
> 
> Andy & Chris,
> 
> Sorry for the very very delayed response on your patch. Some comments
> below.

Thanks for the feedback. I'm working on fixing up a few things and
getting an updated set of patches out, so your timing's not bad at all.

> What I would ideally like to see is an API that allows me to allocate
> a DMA channel between system memory and a device struct:
> 
> dma_client_alloc_chan(struct dma_client client*, struct device *dev);

I had something similar in my initial design, the I/OAT DMA engine can
operate on any memory mapped region "downstream" from the PCI device.
That's easy enough to add to the API, and then flush out the device
matching code in the ioatdma driver later.

> Make the various copy functions static inlines since they are just
> doing an extra function pointer dereference.

OK

> - The API currently supports only 1 client per DMA channel. I think a
>   client should be able to ask for exclusive or non-exclusive usage of
>   a DMA channel and the core can mark channels as unvailable when
>   exclusive use is required. This could be useful in systems with just
>   1 DMA channel but multiple applications wanting to use it.

We were trying to not share them for simplicity.  But with the way we
ended up using the DMA engine for TCP, we needed to get the locking
right for requests from multiple threads anyway.  Shared channel use
shouldn't be hard to add, I'll look into it.

> - Add an interface that takes scatter gather lists as both source and
>   destination.

OK

> - DMA engine buffer alignment requirements? I've seen engines that
>   handle any source/destination alignment and ones that handle
>   only 32-bit or 64-bit aligned buffers. In the case of a transfer
>   that is != alignment requirement of DMA engine, does the DMA device
>   driver handle this or does the DMA core handle this?

Any ideas of what this would look like?

> - Can we get rid of the "async" in the various function names? I don't
>   know of any HW that implements a synchronous DMA engine! It would
> sort of defeat the purpose. :)

We tossed the async in after an early comment that the dma namespace
wasn't unique enough, especially with the DMA mapping APIs already in
place.  Maybe hwdma?  I'm open to suggestions.

> - The user_dma code should be generic, not in net/ but in kernel/ or
>   in drivers/dma as other subsystems and applications can probably
>   make use of this funcionality.

You're right.  That file started out with dma_skb_copy_datagram_iovec,
and dma_memcpy_[pg_]toiovec were created to support that.  Anything not
specifically tied to sk_buffs should be moved.

-Chris
