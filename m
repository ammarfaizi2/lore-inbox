Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbSLEAh0>; Wed, 4 Dec 2002 19:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267161AbSLEAhZ>; Wed, 4 Dec 2002 19:37:25 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:55941 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267160AbSLEAhS>; Wed, 4 Dec 2002 19:37:18 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 4 Dec 2002 16:43:11 -0800
Message-Id: <200212050043.QAA03207@adam.yggdrasil.com>
To: James.Bottomley@SteelEye.com
Subject: Re: [RFC] generic device DMA implementation
Cc: davem@redhat.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       miles@gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-12-04, James Bottomley wrote:

>Now that we have the generic device model, it should be equally possible to 
>rephrase the entire [DMA] API for generic devices instead of pci_devs.

	Yes.  This issue has come up repeatedly.  I'd really like to
see a change like yours integrated soon to stop the spread of fake PCI
devices (including the pcidev==NULL convention) and other contortions
being used to work around this.  Also, such a change would enable
consolidation of certain memory allocations and their often buggy
error branches from hundred of drivers into a few places.

	As you know, I posted a similar patch that created a new field
in struct bus_type, as Miles Bader suggested just now, although only
for {alloc,free}_consistent.  if the bus-specific variation can be
confined to some smaller part of these routines or eliminated, then
I'm all in favor of skipping the extra indirection and going with your
approach.  It will be interesting to see if your model allows most of
the sbus_ and pci_ DMA mapping routines in sparc to be merged.  I
suspect that you will have to adopt some kind of convention, such as
that device->parent->driver_private will have a common meaning for pci
and sbus device on that platform.


>The new DMA API allows a driver to advertise its level of consistent memory 
>compliance to dma_alloc_consistent.  There are essentially two levels:
>
>- I only work with consistent memory, fail if I cannot get it, or
>- I can work with inconsistent memory, try consistent first but return 
>inconsistent if it's not available.

	If these routines can allocate non-consistent memory, then how
about renaming them to something less misleading, like dma_{malloc,free}?

	Can you please define the "consistency" argument to these
two routines as a bit mask?  There are probably other kinds of memory
inconsistency a driver might be able to accomodate in the future (CPU
read caching, CPU writeback, incosistency across mulitple CPU's if the
driver knows that it is only going to run on one CPU).  I think 0
should be the "most consistent" kind of memory.  That way, DMA memory
allocators could ignore bits that they don't know about, as those bits
would only advertise extra capabilities of a driver.  I think this
extensibility is more useful than the debugging value of
DMA_CONFORMANCE_NONE.


>The idea is that the memory type can be coded into dma_addr_t which the 
>subsequent memory sync operations can use to determine whether 
>wback/invalidate should be a nop or not.

	Your patch does not have to wait for this, but I would like
macros like {r,w}mb_maybe(dma_addr, len) that would compile to nothing
on machines where dma_malloc always returned consistent memory,
compile to your proposed range checking versions on machines that
could return consistent or inconsistent memory, and compile to
dma_cache_wback and rmb(?) on machines that always returned
inconsistent memory.  The existing dma_cache_wback routines would
still never do the range checks, because they would continue to be
used only in cases where the need for flushing is known at compile
time (they would always compile to either the barrier code or nothing).

	Also something that could be added later is a
bus_type.mem_mapped flag so that these DMA routines could do:

		BUG_ON(!dev->bus.mem_mapped);

	...to catch attempts to allocate memory for devices that are
not mapped.  Alternatively, we could have a struct mem_device that
embeds a struct device and represents only those types of devices
that can be mapped into memory.

	It is also possible that we might want to add a field to
struct device identifying the memory mapped "parent" of a
non-memory-mapped device, such as the PCI-based USB host adapter of a
USB network device so that mapping of network packets for transmission
could be centralized.  That's probably a separate patch though.

	P.S., Did you miss a patch for include/linux/device.h adding
device.dma_mask, or is that change already queued for 2.5.51?

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
