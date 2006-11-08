Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754197AbWKHEqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbWKHEqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 23:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754206AbWKHEqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 23:46:53 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15312
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1754197AbWKHEqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 23:46:52 -0500
Date: Tue, 07 Nov 2006 20:46:53 -0800 (PST)
Message-Id: <20061107.204653.44098205.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       paulus@samba.org, anton@samba.org, greg@kroah.com
Subject: Re: DMA APIs gumble grumble
From: David Miller <davem@davemloft.net>
In-Reply-To: <1162950877.28571.623.camel@localhost.localdomain>
References: <1162950877.28571.623.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 08 Nov 2006 12:54:37 +1100

> However, the PCI documentation then adds:
> 
> <<<<
> Another common scenario is a 64-bit capable device.  The approach
> here is to try for 64-bit DAC addressing, but back down to a
> 32-bit mask should that fail.  The PCI platform code may fail the
> 64-bit mask not because the platform is not capable of 64-bit
> addressing.  Rather, it may fail in this case simply because
> 32-bit SAC addressing is done more efficiently than DAC addressing.
> Sparc64 is one platform which behaves in this way.
> 
> Here is how you would handle a 64-bit capable device which can drive
> all 64-bits when accessing streaming DMA:
> 
> 	int using_dac;
> 
> 	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
> 		using_dac = 1;
> 	} else if (!pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
> 		using_dac = 0;
> 	} else {
> 		printk(KERN_WARNING
> 		       "mydev: No suitable DMA available.\n");
> 		goto ignore_this_device;
> 	}
> >>>>
> 
> So on one side, the platform should fail if the device mask is too
> small, on the other side, it should fail of the device mask is too
> big...
> 
> I'm sorry Dave, but I really don't like that... it's smells like you
> added something unrelated to the semantics of pci_set_dma_mask() which
> is basically what your platform would prefer doing. That mixes two
> different semantics in one call and I find that confusing at best, but
> then, I'm a bit lame so :)

There aren't many sane alternatives.  We created even a special set of
DAC interfaces to the PCI DMA API for when "you really really want DAC
addressing."

The only time you really must have it is for things that want to
map all of memory, such as PCI clustering cards like the ones made
by Dolphin.  For those things, the limitations of what the IOMMU can
map at once is unacceptable and thus using DAC is mandatory even if
it is slower.

Using DAC cycles on sparc64, when they aren't necessary and SAC works
fine, is a matter of 5 to 10 times worse performance.  Absolutely no
caching and prefetching can be performed by the PCI controllers on
sparc64 if you use DAC addresses.

> Also, it's not documented that way in the non-PCI "DMA" API
> documentation which, however, has this additional call:
> 
> <<<<
> u64 dma_get_required_mask(struct device *dev)
> 
> After setting the mask with dma_set_mask(), this API returns the
> actual mask (within that already set) that the platform actually
> requires to operate efficiently.  Usually this means the returned mask
> is the minimum required to cover all of memory.  Examining the
> required mask gives drivers with variable descriptor sizes the
> opportunity to use smaller descriptors as necessary.
> >>>>
> 
> Which seems to do exactly what your want ... There's a default
> implementation in drivers/base/platform.c (yeah, I wouldn't have found
> it without grep, what the heck is it doing there ?) but it can be
> overriden by the arch.

It's great that the generic DMA api creators decided to do something
different then never bother to suggest adjusting the PCI DMA
interfaces to suit.  You cannot blame me for that. :-)

> So should we define a pci_* version of it and change the doc to use that
> instead ? What about drivers (there's a few) using the construct
> documented above instead of that ? how long should we "support" the old
> way if we decide to go that route ?

For this very reason I think we have to keep the PCI DMA interfaces
in this area as they are.  You aren't going to be able to rewrite
all the drivers out there already using this stuff, and it took long
enough to get people to use the current scheme properly :)

> Also, in general, the whole thing is a mess in the sense that some of
> the routines are implemented as pci_* in the PCI core with an ifdef so
> arch can replace them, and we have a generic header that archs can use
> to implement dma_* on top of pci_*.

That very header does not work at all, it should be deleted because
it causes bugs.

One such problem that "dma_* in terms of pci_*" header causes is that
it ignored the gfp_t arguments to several routines.  This results in
massive memory corruption with the sound/ layer which passes GFP_COMP
down to dma_alloc_consistent() and friends.

I had to fix this on sparc64. :-)

> We also have a header for archs like
> powerpc or x86 that implement the base DMA API to define the PCI one on
> top of that, but it doesn't expose that call

I'm gone away from this direction because the &pci_bus_type comparison
that code does it just rediculious overhead for what should be very
simple and straightforward :-)

> * Now the new kid in town: The coherent DMA mask
> 
> So that's new and for some reason, I missed it's introduction. My fault.
> The basic idea looks interesting enough and might even be useful for
> embedded powerpc's where coherent memory has to be allocated out of a
> special non-cacheable pool.
> 
> But first, a problem ! This is only every documented in the PCI DMA API
> document, there is no mention of it in the "generic" DMA API.

Something else I didn't personally create.  You will notice the
parts I actually designed and implemented are documented accurately.


> Now, the question is how to get out of that situation. First:
> 
>  - Do we agree that everybody should implement the dma_* API and that
> the pci_ one should just be a wrapper on top of the former that takes
> pci_dev's as argument ? A quick grep shows that the arch using
> asm-generic/dma-mapping.h (that is implementing the dma_* ones on top of
> the pci_* ones) are:
> 
> 	- m68knommu
> 	- sparc
> 	- v850

sparc64 used to, but as stated above it was so buggy that I no longer
could do so.

I think what I did for sparc64 is what I would do to make sparc 32-bit
no longer use asm-generic/dma-mapping.h

Really, on both sparc platforms, I have zero reason to implement
the generic DMA API to support anything other than PCI. :-)

>  - For platforms like powerpc where I can have multiple busses on
> different IOMMU's and with possibly different DMA ops, I really need to
> have a per-device data structure for use by the DMA ops (in fact, in my
> case, containing the DMA ops themselves). Right now, I defined a notion
> of "device extension" (struct device_ext) that my current implementation
> puts in device->firmware_data (don't look for it upstream, it's all
> patches queuing up for 2.6.20 and about to go into powerpc.git), but
> that I'd like to have flat in struct device instead. Would it be agreed
> that linux/device.h includes itself an asm/device.h which contains a
> definition for a struct device_ext that is within struct device ? That
> would also avoid a pointer indirection which is a good thing for DMA
> operations

Maybe we can put a void * pointer there for "sysdata" like we do
in the pci_dev struct and friends.  But there are many many people
who are sensitive to the size of struct device, so expect some
resistence :-)

>  - port m68knommu, sparc and v850 to implement the dma_* API instead of
> the pci_* one

Please just mirror what I did on sparc64 for sparc32, see changeset
42f142371e48fbc44956d57b4e506bb6ce673cd7, with followup bug fixes
in 36321426e320c2c6bc2f8a1587d6f4d695fca84c and
7233589d77fdb593b482a8b7ee867e901f54b593.

Thanks.
