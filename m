Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUDGIX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 04:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUDGIX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 04:23:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28562 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261375AbUDGIXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 04:23:52 -0400
Date: Wed, 7 Apr 2004 10:23:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040407082350.GB32140@elte.hu>
References: <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu> <20040406202548.GI2234@dualathlon.random> <20040407060330.GB26888@dualathlon.random> <20040407064629.GA31338@elte.hu> <20040407072349.GC26888@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407072349.GC26888@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> > That area of the curve is quite suspect at first sight. With a TLB flush
> 
> the cache size of the l2 is 512k, that's the point where slowing down
> walking pagetables out of l2 hurt most. It made perfect sense to me.
> Likely on a 1M cache machine you'll get the same huge slowdown at 1M
> working set and so on with bigger cache sizes in more expensive x86
> big iron cpus.

ah! i assumed a 1MB cache.

yes, there could be caching effects around the cache size, but the
magnitude still looks _way_ off. Here are a number of independent
calculations and measurements to support this point:

64 dTLBs means 64 pages. Even assuming the most spread out layout in PAE
mode, a single pagetable walk needs to access the pte and the pmd
pointers, which, if each pagewalk-path lies on separate cachelines
(worst-case), it means 2x64 == 128 bytes footprint per page. [64 byte L2
cacheline size on your box.] This means 128x64 == 8K footprint in the L2
cache for the TLBs.

this is only 1.5% of the L2 cache, so it should not make such a huge
difference. Even considering P4's habit of fetching two cachelines on a
miss, the footprint could at most be 3%.

the real pagetable footprint is likely much lower - there's likely a
fair amount of sharing at the pmd pointer level.

so the theory that it's the pagetable falling out of the cache that
makes the difference doesnt seem plausible.

> > every 1 msec [*], for a 'double digit' slowdown to happen it means the
> > effect of the TLB flush has to be on the order of 100-200 usecs. This is
> > near impossible, the dTLB+iTLB on your CPU is only 64+64. This means
> > that a simple mmap() or a context-switch done by a number-cruncher
> > (which does a TLB flush too) would have a 100-200 usecs secondary cost -
> > this has never been seen or reported before!
> 
> note that it's not only the tlb flush having the cost, the cost is the
> later code going slow due the tlb misses. [...]

this is what i called the 'secondary' cost of the TLB flush.

> [...] So if you rdstc around the mmap syscall it'll return quick just
> like the irq returns quick to userspace. the cost of the tlb misses
> causing pte walkings of ptes out of l2 cache isn't easily measurable
> in other ways than I did.

i know that it's not measurable directly, but a 100-200 usecs slowdown
due to a TLB flush would be easily noticeable as a slowdown in userspace
performance.

lets assume all of the userspace pagetable cachelines fall out of the L2
cache during the 1 msec slice, and lets assume the worst-case spread of
the pagetables, necessiating 128 cachemisses. With 300 cycles per L2
cachemiss, this makes for 38400 cycles - 15 usecs on your 2.5 GHz Xeon. 
This is the very-worst-case, and it's still an order of magnitude
smaller than the 100-200 usecs.

I've attached tlb2.c which measures cold-cache miss costs with a
randomized access pattern over a memory range of 512 MB, using 131072
separate pages as a TLB-miss target. (you should run it as root, it uses
cli.) So this cost combines the data-cache miss cost and the TLB-miss
costs.

This should give the worst-case cost of TLB misses. According to these
measurements the worst-case for 64 dTLB misses is ~25000 cycles, or 10
usecs on your box - well below the conservative calculation above. This
is the very worst-case TLB-trashing example i could create, and note
that it still over-estimates the TLB-miss cost because the data-cache
miss factors in too. (and the data-cache miss cannot be done in parallel
to the TLB miss, because without knowing the TLB the CPU cannot know
which page to fetch.) [the TLB miss is two cachemisses, the data-cache
fetch is one cachemiss. The two TLB related pte and pmd cachemisses are
linearized too, because the pmd value is needed for the pte fetching.]
So the real cost for the TLB misses would be around 6 usecs, way below
the 100-200 usecs effect you measured.

> > to eliminate layout effects, could you do another curve? Plain -aa4 (no
> 
> with page layout effects you mean different page coloring I assume,
> but it's well proven that page coloring has no significant effect on
> those multi associative x86 caches [...]

E.g. the P4 has associativity constraints in the VM-linear space too
(!). Just try to access 10 cachelines spaced exactly 128 KB away from
each other (in virtual space).

> > 4:4 patch) but a __flush_tlb() added before and after do_IRQ(), in
> > arch/i386/kernel/irq.c? This should simulate much of the TLB flushing
> > effect of 4:4 on -aa4, without any of the other layout changes in the
> > kernel. [it's not a full simulation of all effects of 4:4, but it should
> > simulate the TLB flush effect quite well.]
> 
> sure I can try it (though not right now, but I'll try before the
> weekend).

thanks for the testing! It will be interesting to see.

	Ingo
