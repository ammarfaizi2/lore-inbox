Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268161AbTBYTHw>; Tue, 25 Feb 2003 14:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268222AbTBYTHw>; Tue, 25 Feb 2003 14:07:52 -0500
Received: from [195.223.140.107] ([195.223.140.107]:56454 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268161AbTBYTHr>;
	Tue, 25 Feb 2003 14:07:47 -0500
Date: Tue, 25 Feb 2003 20:18:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225191817.GT29467@dualathlon.random>
References: <96700000.1045871294@w-hlinder> <20030222192424.6ba7e859.akpm@digeo.com> <20030225171727.GN29467@dualathlon.random> <20030225174359.GA10411@holomorphy.com> <20030225175928.GP29467@dualathlon.random> <20030225185008.GF10396@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225185008.GF10396@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 10:50:08AM -0800, William Lee Irwin III wrote:
> On Tue, Feb 25, 2003 at 09:43:59AM -0800, William Lee Irwin III wrote:
> >> The pagetable cache is gone in 2.5, so pte_alloc_one() takes the
> >> bitblitting hit for pagetables.
> 
> On Tue, Feb 25, 2003 at 06:59:28PM +0100, Andrea Arcangeli wrote:
> > I'm talking about do_anonymous_page, do_wp_page, do_no_page fork and all
> > the other places that introduces spinlocks (per-page) and allocations of
> > 2 pieces of ram rather than just 1 (and in turn potentially global
> > spinlocks too if the cpu-caches are empty). Just grep for
> > pte_chain_alloc or page_add_rmap in mm/memory.c, that's what I mean, I'm
> > not talking about pagetables.
> 
> Okay, fished out the profiles (w/Dave's optimization):
> 
> 00000000 total                                    158601   0.0869
> c0106ed8 poll_idle                                 99878 1189.0238
> c01172e0 do_page_fault                              8788   7.7496
> c013adb4 do_wp_page                                 6712   8.4322
> c013f70c page_remove_rmap                           3132   6.2640
> c0139eac copy_page_range                            2994   3.5643
> c013f5c0 page_add_rmap                              2776   8.3614
> c013a1f4 zap_pte_range                              2616   4.8806
> c0137240 release_pages                              1828   6.4366
> c0108d14 system_call                                1116  25.3636
> c013ba00 handle_mm_fault                            1098   4.6525
> c015b59c d_lookup                                   1096   3.2619
> c013b788 do_no_page                                 1044   1.6519
> c013b56c do_anonymous_page                           954   1.7667
> c011718c pte_alloc_one                               910   6.5000
> c0139ba0 clear_page_tables                           841   2.4735
> c011450c flush_tlb_page                              725   6.4732
> c0207130 __copy_to_user_ll                           687   6.6058
> c01333dc free_hot_cold_page                          641   2.7629
> c013042c find_get_page                               601  10.7321
> 
> Just taking the exception dwarfs anything written in C.
> 
> page_add_rmap() absorbs hits from all of the fault routines and
> copy_page_range(). page_remove_rmap() absorbs hits from zap_pte_range().
> do_wp_page() is huge because it's doing bitblitting in-line.

"absorbing" is a nice word for it.  The way I see it, page_add_rmap and
page_remove_rmap are even more expensive than the pagtable zapping.
They're even more expensive than copy_page_range.  Also focus on the
numbers on the right that are even more interesting to find what is
worth to optimize away first IMHO


> 
> These things aren't cheap with or without rmap. Trimming down

lots of things aren't cheap, but this isn't a good reason to make them
twice more expensive, especially if they were as cheap as possible and
they're critical hot paths.

> accounting overhead could raise search problems elsewhere.

this is the point indeed, but at least in 2.4 I don't see any cpu saving
advantage during swapping because during swapping the cpu is always idle
anyways.

Infact I had to drop the lru_cache_add too from the anonymous page fault
path because it was wasting way too much cpu to get peak performance (of
course you're using per-page spinlocks by hand with rmap, and
lru_cache_add needs a global spinlock, so at least rmap shouldn't
introduce very big scalability issue unlike the lru_cache_add)

> Whether avoiding the search problem is worth the accounting overhead
> could probably use some more investigation, like actually trying the
> anonymous page handling rework needed to use vma-based ptov resolution.

the only solution is to do rmap lazily, i.e. to start building the rmap
during swapping by walking the pagetables, basically exactly like I
refill the lru with anonymous pages only after I start to need this
information recently in my 2.4 tree, so if you never need to pageout
heavily several giga of ram (like most of very high end numa servers),
you'll never waste a single cycle in locking or whatever other worthless
accounting overhead that hurts performance of all common workloads

Andrea
