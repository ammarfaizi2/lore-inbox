Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316295AbSEVRZZ>; Wed, 22 May 2002 13:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSEVRZY>; Wed, 22 May 2002 13:25:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21280 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316295AbSEVRZU>; Wed, 22 May 2002 13:25:20 -0400
Date: Wed, 22 May 2002 19:21:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org,
        riel@surriel.com, torvalds@transmeta.com, akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <20020522172157.GK21164@dualathlon.random>
In-Reply-To: <20020522160731.GC14918@holomorphy.com> <1406543793.1022060194@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 09:36:35AM -0700, Martin J. Bligh wrote:
> > pte-highmem isn't enough. On an 8GB machine it's already dead. Sharing
> > is required just to avoid running out of space period. IIRC Dave
> > McCracken has been working on daniel's original pte sharing patch.
> 
> Depends on the workload, but yes.

well, at least that problem can be dominated till a certain degree (say
32G of ram) by throwing more money into the hardware, so it's somehow a
secondary problem compared to the lack of pte-highmem feature.

> 
> >> 5. kmap
> >> 	Persistent kmap sucks, and the global systemwide TLB flushes
> >> 	scale as O(1/N^2) with the number of CPUs. Enlarging the kmap 
> >> 	area helps a little, but really we need to stop doing this to
> >> 	ourselves. I will have a patch (hopefully within a week) to do 
> >> 	per-task kmap, based on the	UKVA patch that Dave McCracken has
> >> 	already implemented.
> > 
> > O(1/N^2)? wouldn't that get progressively better as the number of cpu's

1/N^2 is less than O(1), no-way.

> > grows without bound?
> 
> Cost of TLB flush on 1 cpu = 1. Number of CPUs = N. Cost of systemwide
> TLB flush = N. Assuming we actually use those CPUs in a comparable way, 
> we do N times as many global tlbflushes per second with N cpus. This N^2.
> Or that's my reckoning, anyway.

I think you're right, if you go to some billion CPU it becomes a
quadratic complexity in the tlb flush. OTOH in current kernels NR_CPUS
is #define set to 32, so it's O(1) in pure math terms (but pure math
terms doesn't matter here, they overlook completly the different cost
spent in the tlb flushes with 1 CPUs or 32 CPUs).

Anyways this is only a matter of implementing the
persistent-and-atomic-kmap, I'm pretty sure they're the right solution
for this problem, then the whole pool in highmem.c will go away and even
the pagecache will stop blocking on the kmaps.

Note though that this decision is SMP oriented, on UP the pool that
caches the page->virtual may be more efficient, but the bottleneck of
the pool is a showstopper for SMP and the overhead of the atomic kmap
compared to the cached page->virtual pool is not noticeable if
something, so I've no doubt this is the right direction to take.

I look forward to see the patch (just the kmap-atomic-and-persistent,
not the constnatly mapped pte that is more likely to be a regression
than current linux way IMHO), so we can possibly cleanup and then
integrate it in 2.5 :).

Other things like managing 63G of highmem with only 850M of direct
mapping they're almost unsolvable in a generic manner, however
configuration options and arch-ifdefs can be used here. If the
computation always stays in kernel or always in usersapce then 4G KVA is
a solution (as slow as 2.0, the first bigmem for 2.2 and PTX I guess).
But if you runs syscalls all the time it will be as bad as 2.0, and in
such case current 2.4 way will be much better. But if you need lots of
normal memory you may prefer CONFIG_2G to avoid running out of
inodes/dcache/files/buffercache [limited to normal zone]/vmas/bh, vmas
and bh for rawio/O_DIRECT probably being one of the most problematics
because they cannot shrink dynamically and those bigs machines will do
lots of mappings.  But even CONFG_2G may not be ok if you want 1.7G of
shm constnatly mapped in all tasks. So at the end the closest to a
generic solution may be to rewrite the whole kernel MM API to use pfn
instead of page structures and to kmap the mem_map to get the struct
page, so you don't shrink the user address space, you move the huge
mem_map to highmem and the slowdown ""should"" be minor than the 4G KVA
probably (not obvious though), but that's an huge work just before we
finally switch to 64bit computing and with an uncertain performance
result...  so it's hard for me not to think 64bit when the other option
is to rewrite the whole kernel MM internal API that affects 99% of the
.c file in the tree :).

Andrea
