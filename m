Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262750AbSJWG7x>; Wed, 23 Oct 2002 02:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262888AbSJWG7x>; Wed, 23 Oct 2002 02:59:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:4014 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262750AbSJWG7w>;
	Wed, 23 Oct 2002 02:59:52 -0400
Date: Wed, 23 Oct 2002 09:19:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@zip.com.au>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [patch] generic nonlinear mappings, 2.5.44-mm2-D0
In-Reply-To: <20021023020534.GJ11242@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0210230851170.2360-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Oct 2002, Andrea Arcangeli wrote:

> > protection bits. It has been clearly established in the past few years
> > empirically that the vma tree approach itself sucks performance-wise for
> > applications that have many different mappings.
> 
> if you're talking about get_unmapped_area showing up heavy on the
> profiling then you're on the wrong track with this, [...]

algorithmic overhead is just one aspect of the 'thousands of vmas'
problem, the real killer issue for some applications is RAM overhead,
because a single vma takes up roughly 3 cachelines _per process_, which
means 1 MB unswappable lowmem overhead per 10 thousand vmas. I know about
valid applications (and i'm not counting electric fence here) with
hundreds of thousands of vmas per process.

Even a O(log(N)) algorithm means ~15 tree walking steps in a perfectly
balanced tree (which ours arent), which means 0.5 KB of cache touched per
lookup with 32 byte cacheline size, and 2KB of cache touched per lookup,
with 128 byte cacheline size - which is far from cheap. While it's _much_
better than a O(N) algorithm in this case, the approach i'm working on
solves the more fundamental problem, instead of working it around.

> (while I know several cases where the lack of O(log(N)) in
> get_unmapped_area is a showstopper, [...]

Exactly which applications do you have in mind, most of the ones i can
think of are helped by the file-pte/swap-pte work.

do you still claim this to be the case once i've extended file-ptes (and
anon-swap pte's) with protection bits? That will enable the following
important things: mprotect() does not break up vmas(), neighboring
anonymous areas can _always_ be merged.

> [...] the GUI as well suffers badly with the hundred of librarians but
> the guis are otherwise idle so it doesn't matter much for them if the
> cpu is wasted but they will get a bit lower latency).

the GUI cases should be helped quite significantly by the simple approach
i added. The NPTL testcase that triggered the get_unmapped_area()  
regression is fixed by the mmap-speedup patch as well, get_unmapped_area()  
completely vanished from the kernel profile. But sure, its simplicity
makes it still an O(N) algorithm conceptually, but the typical statistical
behavior should be much better.

but the thing i'm working on is a much better than O(log(N)) improvement,
because i'm trying to fix the real and fundamental problem: the
artificially high number of vmas. That is not possible in every case
though (eg. the KDE libraries case we do have roughly 100 vmas from
different libraries), so your O(log(N)) patch will definitely be worth a
review.

in any case, if you have followed the mmap-speedup discussion then you
must know all the arguments already. Sure, O(log(N)) would be nice in
theory (and i raised that possibility in the discussion), but i'd like to
see your patch first, because yet another vma tree is quite some
complexity and it further increases the size of the vma, which is not
quite a no-cost approach.

	Ingo

