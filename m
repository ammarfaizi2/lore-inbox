Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315571AbSECGeR>; Fri, 3 May 2002 02:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315572AbSECGeR>; Fri, 3 May 2002 02:34:17 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:19873 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S315571AbSECGeN>; Fri, 3 May 2002 02:34:13 -0400
Date: Thu, 02 May 2002 23:33:43 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>,
        William Lee Irwin III <wli@holomorphy.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <4023859403.1020382422@[10.10.2.3]>
In-Reply-To: <20020503080433.R11414@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, whilst we've mentioned NUMA-Q in these arguments, much of this
is generic to any 32 bit NUMA machine, the new x440 for example.

> I don't think it make sense to attempt breaking GFP_KERNEL semantics in
> 2.4 but for 2.5 we can change stuff so that all non-DMA users can ask
> for ZONE_NORMAL that will be backed by physical memory over 4G (that's
> fine for all inodes,dcache,files,bufferheader,kiobuf,vma and many other
> in-core data structures never accessed by hardware via DMA, it's ok even
> for the buffer cache because the lowlevel layer has the bounce buffer
> layer that is smart enough to understand when bounce buffers are needed
> on top of the physical address space pagecache).

Sounds good. Hopefully we can kill off ZONE_DMA for the old ISA stuff
at the same time except as a backwards compatibility config option that
you'd have to explicitly enable ...
 
> Again note that nonlinear can do nothing to help you there, the
> limitation you deal with is pci32 and the GFP API, not at all about
> discontigmem or nonlinear. we basically changed topic from here.

There are several different problems we seem to be discussing here:

1. Cleaning up discontig mem alloc for UMA machines.
2. Having a non-contiguous ZONE_NORMAL across NUMA nodes.
3. DMA addressibility of memory.

(and probably others I've missed). Nonlinear is more about the
first two, and not the third, at least to my mind.

> Personally I always had the hope to never need to see a 64G 32bit
> machine 8). I mean, even if you manage to solve the pci32bit problem
> with GFP_KERNEL, then you still have to share 800M across 16 nodes with
> 4G each. So by striping zone_normal over all the nodes to have numa-local
> data structures with fast slab allocations will get at most 50mbyte per
> node of which around 90% of this 50M will be eat by the mem_map array
> for those 50M plus the other 4G-50M. 

You're assuming we're always going to globally map every struct page
into kernel address space for ever. That's a fundamental scalability
problem for a 32 bit machine, and I think we need to fix it. If we
map only the pages the process is using into the user-kernel address
space area, rather than the global KVA, we get rid of some of these
problems. Not that that plan doesn't have its own problems, but ... ;-)

Bear in mind that we've sucessfully used 64Gb of ram in a 32 bit 
virtual addr space a long time ago with Dynix/PTX.

> So at the end you'll be left with
> only say 5/10M per node of zone_normal that will be filled immediatly as
> soon as you start reading some directory from disk. a few hundred mbyte
> of vfs cache is the minimum for those machines, this doesn't even take
> into account bh headers for the pagecache, physical address space
> pagecache for the buffercache, kiobufs, vma, etc... 

Bufferheads are another huge problem right now. For a P4 machine, they
round off to 128 bytes per data structure. I was just looking at a 16Gb
machine that had completely wedged itself by filling ZONE_NORMAL with 
unfreeable overhead - 440Mb of bufferheads alone. Globally mapping the
bufferheads is probably another thing that'll have to go.

> It's just that 1G of
> virtual address space reserved for kernel is too low to handle
> efficiently 64G of physical ram, this is a fact and you can't 
> workaround it. 

Death to global mappings! ;-)

I'd agree that a 64 bit vaddr space makes much more sense, but we're
stuck with the chips we've got for a little while yet. AMD were a few
years too late for the bleeding edge Intel arch people amongst us.

M.
