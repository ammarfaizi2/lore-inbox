Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314500AbSEHP6Q>; Wed, 8 May 2002 11:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314502AbSEHP6P>; Wed, 8 May 2002 11:58:15 -0400
Received: from dsl-213-023-043-141.arcor-ip.net ([213.23.43.141]:60632 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314500AbSEHP6P>;
	Wed, 8 May 2002 11:58:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Wed, 8 May 2002 17:57:50 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0205062053050.32715-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E175Tp9-0003ny-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 May 2002 21:07, Roman Zippel wrote:
> Hi,
> 
> On Mon, 6 May 2002, Daniel Phillips wrote:
> 
> > I don't, I observed that in all known instances of config_discontigmem, 
> > that linear relationship is preserved.
> 
> That's true, but m68k isn't using config_discontigmem. :)

Right.  In fact, your two way, phys_to_virt and virt_to_phys mapping makes it 
more like config_nonlinear.  You don't define the contiguous logical memory 
space though, and perhaps that's the reason you need the free_area_init 
changes in the patch below.

Your patch preserves a linear relationship between physical and virtual 
memory, because you do both the ptov and vtop lookup in the same array.  As
such, you don't provide the functionality I provide of being able to fit a
large amount of physical memory into a small amount of virtual memory, and
you can't join all your separate pgdat's into one, as I do.  (The latter is 
desireable because it allows the memory manager to allocate from one 
homogeneous space, reducing the likelihood of zone balancing problems.)

We could, if we want, implement your variable sized memory chunk system with
config_nonlinear. You'd just have to replace the

    ulong psection[MAX_SECTIONS]

with:

    struct { ulong base; ulong size; } pchunk[MAX_CHUNKS];

and replace the four direct table lookup with loops.  Highmem does not need
to be a special case, by the way.  Another by the way: you've accidently
repeated the last four lines of mm_vtop.  Finally, it looks like your 
ZTWO_VADDR hack in mm_ptov would also cease to be a special case, at least,
the special case part would move to the initialization instead of every __va
operation.  So you would end up with *zero* special cases in the page 
translation functions of page.h.

> ...you only have to take care, that you don't iterate
> with the physical address over a pgdat, this is what the patch below
> fixes, the rest can be hidden in the arch macros and no special config
> options is needed.

You do have a config option, it's CONFIG_SINGLE_MEMORY_CHUNK.  You just didn't
attempt to create the contiguous logical address space as I did, so you 
didn't need to go outside your arch.

The generic part of config_nonlinear is tiny anyway - only 200 lines, and 
might grow to 400 by the time all device driver usage of __pa is reclassified 
as either virt_to_phys or virt_to_logical - the latter being a rather nice 
distinction to make, even if the mapping is the same don't you think?  I.e, 
it's like the distinction between pointer and integer: if it's a physical 
address you can pass it to dma hardware, for example and if it's logical 
you're just using it for accounting.

Whenever it's possible to elevate a per-arch feature to the generic level
without compromising functionality, it should be done, modulo programmer 
time, and of course, assuming functionality isn't compromised.  At 
the generic level, it's easier to document, we get cross-pollination from 
improvements developed on different arches, and it's easier to build on.  
Going the other way and allowing design features to fray across architectures 
takes us in the direction of unmaintainable bloat.

-- 
Daniel
