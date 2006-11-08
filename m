Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753833AbWKHByw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbWKHByw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 20:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbWKHByw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 20:54:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:59594 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1753833AbWKHByv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 20:54:51 -0500
Subject: DMA APIs gumble grumble
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Greg KH <greg@kroah.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 12:54:37 +1100
Message-Id: <1162950877.28571.623.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While looking into some bugs in the powerpc DMA implementation
(regarding DMA masks) I had a hard time figuring out what was the
"right" thing to do in a couple of places...

In fact, I found out that what I though was it didn't seem to match some
bits we have in Documentation/ and in drivers, and I'm starting to
wonder what I missed there ;-)

In addition, it seems that the "PCI" API and the generic "DMA" API have
been diverging in several areas.

So let me first describe my understanding and point out where it seems
to diverge from what is in there:

 [ Sorry if the rant is a bit long, near the end I do propose
   a few things, mostly asking if people agree it's ok, I'll
   happily work on patches if the answers are yes
 ]

* First the very basic: the DMA good old mask

A driver calls dma_set_mask() providing a mask that represents the range
of addresses the device is capable of addressing for DMA. That means
that the implementation for this function should succeed if it can
guarantee that returned dma addresses from the consistent alloc and
dma_map_* APIs will always fit within that mask.

So far, that's good and that's documented that way.

However, the PCI documentation then adds:

<<<<
Another common scenario is a 64-bit capable device.  The approach
here is to try for 64-bit DAC addressing, but back down to a
32-bit mask should that fail.  The PCI platform code may fail the
64-bit mask not because the platform is not capable of 64-bit
addressing.  Rather, it may fail in this case simply because
32-bit SAC addressing is done more efficiently than DAC addressing.
Sparc64 is one platform which behaves in this way.

Here is how you would handle a 64-bit capable device which can drive
all 64-bits when accessing streaming DMA:

	int using_dac;

	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
		using_dac = 1;
	} else if (!pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
		using_dac = 0;
	} else {
		printk(KERN_WARNING
		       "mydev: No suitable DMA available.\n");
		goto ignore_this_device;
	}
>>>>

So on one side, the platform should fail if the device mask is too
small, on the other side, it should fail of the device mask is too
big...

I'm sorry Dave, but I really don't like that... it's smells like you
added something unrelated to the semantics of pci_set_dma_mask() which
is basically what your platform would prefer doing. That mixes two
different semantics in one call and I find that confusing at best, but
then, I'm a bit lame so :)

Also, it's not documented that way in the non-PCI "DMA" API
documentation which, however, has this additional call:

<<<<
u64 dma_get_required_mask(struct device *dev)

After setting the mask with dma_set_mask(), this API returns the
actual mask (within that already set) that the platform actually
requires to operate efficiently.  Usually this means the returned mask
is the minimum required to cover all of memory.  Examining the
required mask gives drivers with variable descriptor sizes the
opportunity to use smaller descriptors as necessary.
>>>>

Which seems to do exactly what your want ... There's a default
implementation in drivers/base/platform.c (yeah, I wouldn't have found
it without grep, what the heck is it doing there ?) but it can be
overriden by the arch.

So should we define a pci_* version of it and change the doc to use that
instead ? What about drivers (there's a few) using the construct
documented above instead of that ? how long should we "support" the old
way if we decide to go that route ?

Also, in general, the whole thing is a mess in the sense that some of
the routines are implemented as pci_* in the PCI core with an ifdef so
arch can replace them, and we have a generic header that archs can use
to implement dma_* on top of pci_*. We also have a header for archs like
powerpc or x86 that implement the base DMA API to define the PCI one on
top of that, but it doesn't expose that call

So now, this new call is done the other way around ... and in a file
that doesn't seem to have anything to do with DMA mappings whatsoever.

Which means that we are in a situation where some calls are implemented
a pci_* in the PCI core (with ugly ifdefs to allow replacing them) and
some are implemented as dma_* in some unrelated files, and there seem to
be no attempt at consistency here.

* Now the new kid in town: The coherent DMA mask

So that's new and for some reason, I missed it's introduction. My fault.
The basic idea looks interesting enough and might even be useful for
embedded powerpc's where coherent memory has to be allocated out of a
special non-cacheable pool.

But first, a problem ! This is only every documented in the PCI DMA API
document, there is no mention of it in the "generic" DMA API. This
second example of divergence between those is annoying especially since
on powerpc, the PCI DMA API is just a wrapper on the DMA API. It's also
not implemented in any of the generic DMA API implementation I've seen
unless I missed something nor by any of the helper headers we have to
implement one of them based on the other. Unless I mised it ...

It's especially non-sensical since the infrastructure to handle that
coherent/consistent DMA mask (pick your preferred terminology, we mix
both in the kernel) is in ... struct device, and thus directly available
to the generic DMA API and in no way PCI specific.

I suppose that's easy to fix and I'll implement it as a generic DMA API
call on powerpc and possibly fix the documentation, and I can even fix
asm-generic/dma-mapping.h for the platforms who implement the generic
DMA API on top of the PCI one (yeah, it sucks).

Now, there are still a few weird things with the implementation there:

First, dma_mask is a pointer in struct device (for some historical
reason that i never understood btw... Why didn't just move the field
there ?) while the coherent mask is directly in the struct device (which
is funny since only a PCI API is exposed for it)

Then we have just added other things like dma_coherent_mem in struct
device, though it's an arch specific data structure. I've been wanting
to have DMA specific bits in there for ages and been hijacking
firmware_data lately, if I only knew I could just add an arch specific
bit there and nobody would complain...

Anyway, we now have this thing and 3 archs making use of it (x86, v32
and frv) though I haven't found where frv actually defines the structure
(and the two others defining it to the exact same thing).

I could go on and on ... It seems to be that we created an absolute
mightmare of a mess here.

Now, the question is how to get out of that situation. First:

 - Do we agree that everybody should implement the dma_* API and that
the pci_ one should just be a wrapper on top of the former that takes
pci_dev's as argument ? A quick grep shows that the arch using
asm-generic/dma-mapping.h (that is implementing the dma_* ones on top of
the pci_* ones) are:

	- m68knommu
	- sparc
	- v850

Which looks to me like a ... vast minority :-) Should be easy enough to
fix them unless there is something blocking. Dave, is it ok for sparc ? 

I can start making patches I suppose some time next week, maybe earlier.

 - Do we agree that dma_mask should be fully moved to struct device once
for all instead of being a pointer in there ?

 - If we agree for both things above, then we can remove
pci_set_dma_mask() and pci_set_consistent_dma_mask() from the PCI code
and have them done as dma_*. We can provide default implementations of
them along with dma_get_required_mask() (sitll with an #ifdef mecanism
for overriding them, though I think it's cleaner to use the function
name as a #define rather than some ARCH_HAVE_* thingy) and all of that
be put in drivers/base/dma.c. Fixing up archs that still define their
own pci_* should be fairly easy.

 - For platforms like powerpc where I can have multiple busses on
different IOMMU's and with possibly different DMA ops, I really need to
have a per-device data structure for use by the DMA ops (in fact, in my
case, containing the DMA ops themselves). Right now, I defined a notion
of "device extension" (struct device_ext) that my current implementation
puts in device->firmware_data (don't look for it upstream, it's all
patches queuing up for 2.6.20 and about to go into powerpc.git), but
that I'd like to have flat in struct device instead. Would it be agreed
that linux/device.h includes itself an asm/device.h which contains a
definition for a struct device_ext that is within struct device ? That
would also avoid a pointer indirection which is a good thing for DMA
operations

 - Since that dma_coherent_mem structure seems to want to be platform
specific, them that struct device_ext I described above would be the
natural place to put it in.

So let me know if you agree with the proposals above, and I'll start
doing patches that, in order, will:

 - port m68knommu, sparc and v850 to implement the dma_* API instead of
the pci_* one

 - once that's done, rm include/asm-generic/dma-mapping.h (the header
used to implement the dma_* API based on the pci_* one).

 - move dma_get_required_mask to a new drivers/base/dma.c and define a
pci_* version in pci-dma-compat.h

 - remove pci_set_consistent_dma_mask() and replace it with a dma_*
version in drivers/base/dma.c and update pci-dma-compat.h to define the
pci_* version based on the dma_* version.

 - mask dma_mask a normal member of struct device instead of a pointer,
remove pci_set_dma_mask(), make a generic dma_set_dma_mask() in
drivers/base/dma.c that can be replaced by the arch. Fixup all code that
relied on the old bits

 - Add a asm/device.h that defines a "struct device_ext" (or device_arch
or whatever other name you guys might prefer. I used "device_ext" on
powerpc but I could change that easily enough. Define it as an empty
structure for all archs except powerpc which has some bits waiting for
it and archs that use the dma_coherent_mem data structure which I'll
them move in there. (and fix up the code accordingly)

Does that look good ?

Cheers,
Ben.
 

