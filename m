Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267660AbSLFXmr>; Fri, 6 Dec 2002 18:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267662AbSLFXmr>; Fri, 6 Dec 2002 18:42:47 -0500
Received: from [195.223.140.107] ([195.223.140.107]:22914 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267660AbSLFXmp>;
	Fri, 6 Dec 2002 18:42:45 -0500
Date: Sat, 7 Dec 2002 00:50:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206235032.GR4335@dualathlon.random>
References: <20021206111326.B7232@turing.une.edu.au> <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <20021206222852.GF4335@dualathlon.random> <20021206232125.GR9882@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206232125.GR9882@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 03:21:25PM -0800, William Lee Irwin III wrote:
> On Thu, Dec 05, 2002 at 06:41:40PM -0800, William Lee Irwin III wrote:
> >> No idea why there's not more support behind or interest in page
> >> clustering. It's an optimization (not required) for 64-bit/saner arches.
> 
> On Fri, Dec 06, 2002 at 11:28:52PM +0100, Andrea Arcangeli wrote:
> > softpagesize sounds a good idea to try for archs with a page size < 8k
> > indeed, modulo a few places where the 4k pagesize is part of the
> > userspace abi, for that reason on x86-64 Andi recently suggested to
> > changed the abi to assume a bigger page size and I suggested to assume
> > it to be 2M and not a smaller thing as originally suggested, that way we
> > waste some more virtual space (not an issue on 64bit) and some cache
> > color (not a big deal either, those caches are multiway associative even
> > if not fully associative), so eventually in theory we could even switch
> > the page size to 2M ;)
> 
> The patch I'm talking about introduces a distinction between the size
> of an area mapped by a PTE or TLB entry (MMUPAGE_SIZE) and the kernel's
> internal allocation unit (PAGE_SIZE), and does (AFAICT) properly
> vectored PTE operations in the VM to support the system's native page
> size, and does a whole kernel audit of drivers/ and fs/ PAGE_SIZE usage
> so that the distinction between PAGE_SIZE and MMUPAGE_SIZE is understood.

My point is that making any distinction will lead to inevitable
fragmentation of memory.

Going to an higher kernel wide PAGE_SIZE and avoiding the distinction
will even fix the 8k fragmentation issue with the kernel stack ;) Not to
tell allowing more workloads to be able to use all ram of the 32bit 64G
boxes.

> On Fri, Dec 06, 2002 at 11:28:52PM +0100, Andrea Arcangeli wrote:
> > however don't mistake softpagesize with the PAGE_CACHE_SIZE (the latter
> > I think was completed some time ago by Hugh). I think PAGE_CACHE_SIZE
> > is a broken idea (i'm talking about the PAGE_CACHE_SIZE at large, not
> > about the implementation that may even be fine with Hugh's patch
> > applied).
> 
> PAGE_CACHE_SIZE is mostly an fs thing, so there's not much danger of
> confusion, at least not in my mind.

ok, I thought MMUPAGE_SIZE and PAGE_CACHE_SIZE were related, but of
course they don't need to.

> On Fri, Dec 06, 2002 at 11:28:52PM +0100, Andrea Arcangeli wrote:
> > PAGE_CACHE_SIZE will never work well due the fragmentation problems it
> > introduces. So I definitely vote for dropping PAGE_CACHE_SIZE and to
> > experiment with a soft PAGE_SIZE, multiple of the hardware PAGE_SIZE.
> > That means the allocator minimal granularity will return 8k. on x86 that
> > breaks a bit the ABI. on x86-64 the softpagesize would breaks only the 32bit
> > compatibilty mode abi a little so it would be even less severe. And I
> > think the softpagesize should be a config option so it can be
> > experimented without breaking the default config even on x86.
> 
> Hmm, from the appearances of the patch (my ability to test the patch
> is severely hampered by its age) it should actually maintain hardware
> pagesize mmap() granularity, ABI compatibility, etc.

If it only implements the MMUPAGE_SIZE, yes, it can.

You break the ABI as soon as you change the kernel wide PAGE_SIZE. it is
allowed only on 64bit binaries running on a x86-64 kernel.  The 32bit
binaries running in compatibility mode as said would suffer a bit, but
most things should run and we can make hacks like using anon mappings if
the files are small just for the sake of running some app 32bit (like we
use anon mappings for a.out binaries needing 1k offsets today).

Said that even the MMUPAGE_SIZE alone would be useful, but I'd prefer if
the kernel wide PAGE_SIZE would be increased (with the disavantage of
breaking the ABI, but it would be a config option, even the 2G/3.5G/1G
split has the chance of breaking some app despite I wouldn't classify it
as an ABI violation for the reason explained in one of the last emails).

> On Fri, Dec 06, 2002 at 11:28:52PM +0100, Andrea Arcangeli wrote:
> > the soft PAGE_SIZE will also decrease of an order of magnitude the page
> > fault rate, the number of pte will be the same but we'll cluster the pte
> > refills all served from the same I/O anyways (readhaead usually loads
> > the next pages too anyways). So it's a kind of quite obvious design
> > optimization to experiment with (maybe for 2.7?).
> 
> Sounds like the right timing for me.
> 
> A 16KB or 64KB kernel allocation unit would then annihilate
> sizeof(mem_map) concerns on 3/1 splits. 720MB -> 180MB or 45MB.
>
> Or on my home machine (768MB PC) 6MB -> 1.5MB or 384KB, which
> is a substantial reduction in cache footprint and outright
> memory footprint.

Yep.

> 
> I think this is a perfect example of how the increased awareness of
> space consumption highmem gives us helps us optimize all boxen.

In this case funnily it has a chance to help some 64bit boxes too ;).

Andrea
