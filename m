Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268032AbTBYUBK>; Tue, 25 Feb 2003 15:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267845AbTBYUBK>; Tue, 25 Feb 2003 15:01:10 -0500
Received: from holomorphy.com ([66.224.33.161]:26807 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268032AbTBYUBI>;
	Tue, 25 Feb 2003 15:01:08 -0500
Date: Tue, 25 Feb 2003 12:10:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, Hanna Linder <hannal@us.ibm.com>,
       lse-tech@lists.sf.et, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225201023.GG10396@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
	linux-kernel@vger.kernel.org
References: <96700000.1045871294@w-hlinder> <20030222192424.6ba7e859.akpm@digeo.com> <20030225171727.GN29467@dualathlon.random> <20030225174359.GA10411@holomorphy.com> <20030225175928.GP29467@dualathlon.random> <20030225185008.GF10396@holomorphy.com> <20030225191817.GT29467@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225191817.GT29467@dualathlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 10:50:08AM -0800, William Lee Irwin III wrote:
>> Just taking the exception dwarfs anything written in C.
>> page_add_rmap() absorbs hits from all of the fault routines and
>> copy_page_range(). page_remove_rmap() absorbs hits from zap_pte_range().
>> do_wp_page() is huge because it's doing bitblitting in-line.

On Tue, Feb 25, 2003 at 08:18:17PM +0100, Andrea Arcangeli wrote:
> "absorbing" is a nice word for it.  The way I see it, page_add_rmap and
> page_remove_rmap are even more expensive than the pagtable zapping.
> They're even more expensive than copy_page_range.  Also focus on the
> numbers on the right that are even more interesting to find what is
> worth to optimize away first IMHO

Those just divide the number of hits by the size of the function IIRC,
which is useless for some codepath spinning hard in the middle of a
large function or in the presence of over-inlining. It's also greatly
disturbed by spinlock section hackery (as are most profilers).


On Tue, Feb 25, 2003 at 10:50:08AM -0800, William Lee Irwin III wrote:
>> These things aren't cheap with or without rmap. Trimming down

On Tue, Feb 25, 2003 at 08:18:17PM +0100, Andrea Arcangeli wrote:
> lots of things aren't cheap, but this isn't a good reason to make them
> twice more expensive, especially if they were as cheap as possible and
> they're critical hot paths.

They weren't as cheap as possible and it's a bad idea to make them so.
SVR4 proved there are limits to the usefulness of lazy evaluation wrt.
pagetable copying and the like.

You're also looking at sampling hits, not end-to-end timings.

After all these disclaimers, trimming down cpu cost is a good idea.


On Tue, Feb 25, 2003 at 10:50:08AM -0800, William Lee Irwin III wrote:
>> accounting overhead could raise search problems elsewhere.

On Tue, Feb 25, 2003 at 08:18:17PM +0100, Andrea Arcangeli wrote:
> this is the point indeed, but at least in 2.4 I don't see any cpu saving
> advantage during swapping because during swapping the cpu is always idle
> anyways.

It's probably not swapping that matters, but high turnover of clean data.
No one can really make a concrete assertion without some implementations
of the alternatives, which is why I think they need to be done soon.

Once one or more are there we're set. I'm personally in favor of the
anonymous handling rework as the alternative to pursue, since that
actually retains the locality of reference as opposed to wild pagetable
scanning over random processes, which is highly unpredictable with
respect to locality and even worse with respect to cpu consumption.


On Tue, Feb 25, 2003 at 08:18:17PM +0100, Andrea Arcangeli wrote:
> Infact I had to drop the lru_cache_add too from the anonymous page fault
> path because it was wasting way too much cpu to get peak performance (of
> course you're using per-page spinlocks by hand with rmap, and
> lru_cache_add needs a global spinlock, so at least rmap shouldn't
> introduce very big scalability issue unlike the lru_cache_add)

The high arrival rates to LRU lists in do_anonymous_page() etc. were
dealt with by the pagevec batching infrastructure in 2.5.x, which is
the primary method by which pagemap_lru_lock contention was addressed.
The "breakup" so to speak is primarily for locality of reference.
Which reminds me, my node-local pgdat allocation patch is pending...


On Tue, Feb 25, 2003 at 10:50:08AM -0800, William Lee Irwin III wrote:
>> Whether avoiding the search problem is worth the accounting overhead
>> could probably use some more investigation, like actually trying the
>> anonymous page handling rework needed to use vma-based ptov resolution.

On Tue, Feb 25, 2003 at 08:18:17PM +0100, Andrea Arcangeli wrote:
> the only solution is to do rmap lazily, i.e. to start building the rmap
> during swapping by walking the pagetables, basically exactly like I
> refill the lru with anonymous pages only after I start to need this
> information recently in my 2.4 tree, so if you never need to pageout
> heavily several giga of ram (like most of very high end numa servers),
> you'll never waste a single cycle in locking or whatever other worthless
> accounting overhead that hurts performance of all common workloads

I'd just bite the bullet and do the anonymous rework. Building
pte_chains lazily raises the issue of needing to allocate in order to
free, which is relatively thorny. Maintaining any level of accuracy of
the things with lazy buildup is also problematic. That and the whole
space issue wrt. pte_chains is blown away by the anonymous rework,
which is a significant advantage.


-- wli
