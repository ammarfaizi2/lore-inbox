Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267376AbSLEUXh>; Thu, 5 Dec 2002 15:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267387AbSLEUXh>; Thu, 5 Dec 2002 15:23:37 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:2014 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267376AbSLEUXg>; Thu, 5 Dec 2002 15:23:36 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 5 Dec 2002 12:27:50 -0800
Message-Id: <200212052027.MAA05100@adam.yggdrasil.com>
To: rmk@arm.linux.org.uk
Subject: Re: [RFC] generic device DMA implementation
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
>On Thu, Dec 05, 2002 at 04:21:01AM -0800, Adam J. Richter wrote:
>> Russell King wrote:
>> [An excellent explanation of why you sometimes may need consistent
>> memory.]
>> >In other words, you _will_ loose information in this case, guaranteed.
>> >I'd rather keep our existing pci_* API than be forced into this crap
>> >again.
>> 
>> 	All of the proposed API variants that we have discussed in
>> this thread for pci_alloc_consistent / dma_malloc give you consistent
>> memory (or fail) unless you specifically tell it that returning
>> inconsistent memory is OK.

>How does a driver writer determine if his driver can cope with inconsistent
>memory?  If their view is a 32-byte cache line, and their descriptors are
>32 bytes long, they could well say "we can cope with inconsistent memory".
>When 64 byte cache lines are the norm, the driver magically breaks.
>
>I think we actually want to pass the minimum granularity the driver can
>cope with if we're going to allocate inconsistent memory.  A driver
>writer does not have enough information to determine on their own
>whether inconsistent memory is going to be usable on any architecture.

	I agree with James that dma_malloc should round its allocation
sizes up to a multiple of cache line size (at least if it is returning
inconsistent writeback cached memory), and I would extend that
statement to the pool allocator (currently PCI specific, and an API
that I'd like to change slightly, but that's another matter).  For
dma_malloc, this would currently just be a documentation change, as it
currently always allocates entire pages.  For the pool allocator,
might requiring adding a few lines of code.

	There may be still be other cache size issues, and how to deal
with them will be a driver-specific question.  I think most drivers
will not this problem because hardware programming and data structures
are designed so that at any given time either the IO device or the CPU
has an implicit write lock on the data structure and there is a
specific protocol for handing ownership from one to the other (for
example, the CPU sets up the data structures, flushes its write cache,
then writes sets the "go" bit and does not do further writes until it
sees that the IO device has set the "done" bit).

	However, not all data strucutres and protocols are amenable to
such techniques.  For example, OHCI USB controllers have a 16 byte
Endpoint Descriptor which contains a NextTD (next transfer descriptor)
field designed to be writable by the controller and a EndTD (end
transfer descriptor designed to be writable by the controller) so that
the device driver can add more transfers to an endpoint while that
endpoint descriptor is still hot as long as the architecture supports
32-bit atomic writes, instead of waiting for that endpoint's queue to
empty before adding new requests.  I think that the Linux OHCI
controller currently only queues one request per bulk or control
endpoint, so I don't think it uses this feature, if it were to, it
would have to check that it really did have consistent memory or that
the cache line size was 8 bytes or less (not 4 bytes, because of where
these registers are located).  These checks would evaluate to compile
time constant on most or all architectures.

	For other devices, it may be necessary to use other workarounds
or to fail initialization.  It may also depend on how inconsistent the
memory is.  For example, read cache write through memory may suffice
given read barriers (and it would be interesting to find out if this
kind of memory is available on the inconsistent parisc machines).

	I think the question of whether it would actually simplify
things to embed this test in dma_malloc would depend on how common the
case is where you really want the device driver to fail.  I suspet
that it would be simpler to create a symbol like SMP_CACHE_BYTES or
L1_CACHE_BYTES that the affected drivers could examine.  Also, if the
need really is that common, maybe it could be put in struct
device_driver so that it could appear once instead of in the typically
two or three times in the drivers (and you could even teach depmod to
read, although I don't know if that would be useful).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
