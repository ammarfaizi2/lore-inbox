Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754298AbWKHFX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298AbWKHFX6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 00:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbWKHFX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 00:23:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:5292 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1754291AbWKHFX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 00:23:57 -0500
Subject: Re: DMA APIs gumble grumble
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       paulus@samba.org, anton@samba.org, greg@kroah.com
In-Reply-To: <20061107.204653.44098205.davem@davemloft.net>
References: <1162950877.28571.623.camel@localhost.localdomain>
	 <20061107.204653.44098205.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 16:23:40 +1100
Message-Id: <1162963420.28571.700.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There aren't many sane alternatives.  We created even a special set of
> DAC interfaces to the PCI DMA API for when "you really really want DAC
> addressing."
> 
> The only time you really must have it is for things that want to
> map all of memory, such as PCI clustering cards like the ones made
> by Dolphin.  For those things, the limitations of what the IOMMU can
> map at once is unacceptable and thus using DAC is mandatory even if
> it is slower.
> 
> Using DAC cycles on sparc64, when they aren't necessary and SAC works
> fine, is a matter of 5 to 10 times worse performance.  Absolutely no
> caching and prefetching can be performed by the PCI controllers on
> sparc64 if you use DAC addresses.

Ok. That makes sense.

> It's great that the generic DMA api creators decided to do something
> different then never bother to suggest adjusting the PCI DMA
> interfaces to suit.  You cannot blame me for that. :-)

I haven't blamed you, did I ? :-) I did indeed suspect that this new API
came up afterward. I'm mostly asking if it would fit your needs and if I
should add "fixing drivers to use new API" on my list of things to do.

> > So should we define a pci_* version of it and change the doc to use that
> > instead ? What about drivers (there's a few) using the construct
> > documented above instead of that ? how long should we "support" the old
> > way if we decide to go that route ?
> 
> For this very reason I think we have to keep the PCI DMA interfaces
> in this area as they are.  You aren't going to be able to rewrite
> all the drivers out there already using this stuff, and it took long
> enough to get people to use the current scheme properly :)

Well, we can proceed slowly... like defining a pci_* variant of this new
API, making sure it's properly wired up, and slowly converting drivers
as we meet them. That shouldn't cause any problem.

Then, maybe 6 month, maybe 1 year later, we can change archs that use
the "alternate" semantic like sparc64 to no longer fail
pci_set_dma_mask(64bits).

In fact, the only breakage here would be for those archs to have some
drivers start going slowly, though we could expect drivers to have been
fixed by then.... (And we can delay that second part of the change as
long as deemed necessary).

The important thing is that if we agree that the "new" API is
preferrable, then we at least make sure that new code uses it and we
document it, instead of the previous trick.

> > Also, in general, the whole thing is a mess in the sense that some of
> > the routines are implemented as pci_* in the PCI core with an ifdef so
> > arch can replace them, and we have a generic header that archs can use
> > to implement dma_* on top of pci_*.
> 
> That very header does not work at all, it should be deleted because
> it causes bugs.

I'm all about deleting that one (see by list of things below).

> One such problem that "dma_* in terms of pci_*" header causes is that
> it ignored the gfp_t arguments to several routines.  This results in
> massive memory corruption with the sound/ layer which passes GFP_COMP
> down to dma_alloc_consistent() and friends.
> 
> I had to fix this on sparc64. :-)

Yup, but you didn't fix sparc32 :-) I suppose I can try to do it and ask
Anton for help if things go wrong, though I can't be bothered building a
cross toolchain or getting a box on ebay so I'll rely on your for
testing :-)

> > We also have a header for archs like
> > powerpc or x86 that implement the base DMA API to define the PCI one on
> > top of that, but it doesn't expose that call
> 
> I'm gone away from this direction because the &pci_bus_type comparison
> that code does it just rediculious overhead for what should be very
> simple and straightforward :-)

Looking at your code, basically, a typical DMA API implentation for
sparc64 is:

        BUG_ON(dev->bus != &pci_bus_type);

        return pci_iommu_ops->xxxx(to_pci_dev(dev),...);

And the PCI version is:

	return pci_iommu_ops->xxxx(pdev, ...);

I don't really have a problem with you open coding both versions as long
as they stay in sync.

On powerpc, I need to support DMA for other bus types (of_platform among
others) and thus I'm taking a different approach which boils down to put
the "ops" callbacks in the struct device. I'm defining that device
extension thingy (that i'd like to have flat in struct device to avoid a
pointer indirection but right now it's a pointer) and it gets filled
with DMA ops for busses where they make sense.

> Something else I didn't personally create.  You will notice the
> parts I actually designed and implemented are documented accurately.

I admit I haven't followed precisely who did what but I will trust you
there. One thing is we should probably merge the 2 documentations. That
is, there is no point in keeping 2 documentations for 2 sets of
functions that are supposed to haev the exact same semantics. In fact,
the documentation for the "generic" API also documents the PCI ones, but
is much less complete than the PCI documentation.

I suppose that means one more item to add to my todo list... merging
those docs.

> > Now, the question is how to get out of that situation. First:
> > 
> >  - Do we agree that everybody should implement the dma_* API and that
> > the pci_ one should just be a wrapper on top of the former that takes
> > pci_dev's as argument ? A quick grep shows that the arch using
> > asm-generic/dma-mapping.h (that is implementing the dma_* ones on top of
> > the pci_* ones) are:
> > 
> > 	- m68knommu
> > 	- sparc
> > 	- v850
> 
> sparc64 used to, but as stated above it was so buggy that I no longer
> could do so.

Ok.

> I think what I did for sparc64 is what I would do to make sparc 32-bit
> no longer use asm-generic/dma-mapping.h
> 
> Really, on both sparc platforms, I have zero reason to implement
> the generic DMA API to support anything other than PCI. :-)

I see, yup !

> Maybe we can put a void * pointer there for "sysdata" like we do
> in the pci_dev struct and friends.  But there are many many people
> who are sensitive to the size of struct device, so expect some
> resistence :-)

Well, maybe we can, as I proposed that a while ago in a mail that never
got a reply :-) However, the reason I much prefer being able to just
define a structure that 'expands' in struct device directly is that I
want to avoid yet another pointer indirection in the hot path of DMA
mappings (the ops structure is already two, I don't want three, in fact,
I may even put the ops "flat" in there if I can deal with include
dependencies nightmare and reduce that to one indirection).

Also, look at what we have in there that we could get rid off that way:

        void            *platform_data; /* Platform specific data, device
                                           core doesn't touch it */
        void            *firmware_data; /* Firmware specific data (e.g. ACPI,
                                           BIOS data),reserved for device core*/
        struct dma_coherent_mem *dma_mem; /* internal for coherent mem

In that list, we have:

	- plaform_data	: this is used by platform and isa drivers and should
			  probably be moved in those structures. There might
			  be a couple of places abusing that field, but easy
			  enough to fix. In fact, because it's used by the
			  above, it cannot be used by the platform/arch at
			  will as one would imagine.
		
	- firmware_data : last I grepped, that was an ACPI thingy. I'm
			  currently hijacking it for my device extension but
			  if my idea is accepted, then APCI-using archs can
			  just put their ACPI bits in their device extension
			  and that field is gone.

	- dma_mem :	  this seem to be an arch specific data structure for
			  use by the few archs that implement the separate
			  dma coherent thing. It would naturally fit in the
			  device extension for those archs.

Thus, that is 3 pointers gone for archs who don't use these, and the ability
to put things like your dma ops in every struct device.

> >  - port m68knommu, sparc and v850 to implement the dma_* API instead of
> > the pci_* one
> 
> Please just mirror what I did on sparc64 for sparc32, see changeset
> 42f142371e48fbc44956d57b4e506bb6ce673cd7, with followup bug fixes
> in 36321426e320c2c6bc2f8a1587d6f4d695fca84c and
> 7233589d77fdb593b482a8b7ee867e901f54b593.

Will do.

Thanks for your comments,

Cheers,
Ben.

