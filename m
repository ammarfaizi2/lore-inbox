Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTJKQTl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 12:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTJKQTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 12:19:41 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:26778 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S263166AbTJKQTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 12:19:39 -0400
Message-ID: <3F882F20.5090903@pacbell.net>
Date: Sat, 11 Oct 2003 09:26:08 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: mru@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: USB and DMA on Alpha with 2.6.0-test7
References: <3F86E9D7.9020104@pacbell.net> <3F870BDC.8090806@pacbell.net> <20031011172700.A16499@jurassic.park.msu.ru>
In-Reply-To: <20031011172700.A16499@jurassic.park.msu.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> On Fri, Oct 10, 2003 at 12:43:24PM -0700, David Brownell wrote:
> 
>> static inline int
>> dma_supported(struct device *dev, u64 mask)
>> {
>>-	BUG_ON(dev->bus != &pci_bus_type);
>>-
>>-	return pci_dma_supported(to_pci_dev(dev), mask);
>>+	/* device can dma, using those address bits */
>>+	return dev->dma_mask
>>+		&& (mask & *dev->dma_mask) == *dev->dma_mask;
>> }
> 
> 
> This doesn't work. You will always return success if mask = ~0ULL.

Only if *dma_mask == ~0ULL too ... meaning that device supports
64 bit DMA addressing, in which case the test should certainly
return TRUE since that's what the caller wanted to check.

Not in cases like *dma_mask == 0xffffffff (32 bit DMA only)
or 0x00ffffff (ISA dma only) ... if the proposed mask has even
just one address bit that is NOT set in the "these bits work"
mask, that second test returns FALSE.

(That test is basically what sparc64 does.  Most implementations
of the dma "mask" checking don't actually use them as masks; so
I expected that more-correct check to get second looks!)


> But more important thing is that dma_supported() must not expect
> valid *dev->dma_mask, as it's called from dma_set_mask().

It doesn't make sense to me that the dma mask _ever_ be invalid
after its "struct device" is initialized (and registered).

The bus setup code must establish initial values for DMA masks,
based on bus capabilities:  64bit, normal 32bit, 24bit ISA, etc.
So from then on dma_set_mask() will be usable.  All USB devices
inherit that mask from the Host Controller Driver (HCD) which
they happen to be using; usually for 32bit DMA, sometimes 64bit.

Some device drivers can add restrictions, with dma_set_mask(),
based on actual device capabilities:  certain address bits
are always zero, etc.   That call is illegal for USB device
drivers to use -- only HCD initialization could know enough
about that hardware to change the initial value.


Some of the confusion here is surely because historically
drivers have been told to call pci_dma_set_mask() directly,
to achieve what dma_supported() achieves:  testing whether
a given class of DMA addresses will work.  Which is clearly
the wrong model, except for hardware that's less capable
than the bus it's running on ... it'd also be broken for a
"generic" model, since it can't work for drivers that only
work through a HAL (like all USB device drivers).


> That is, your usage of dma_supported() is buggy regardless of
> DMA API implementation.

The facts I see don't support that claim.

- Dave



