Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTH0R4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 13:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbTH0R4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 13:56:46 -0400
Received: from holomorphy.com ([66.224.33.161]:23737 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261754AbTH0R4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 13:56:44 -0400
Date: Wed, 27 Aug 2003 10:57:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
Message-ID: <20030827175743.GF4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>,
	Peter Chubb <peterc@gelato.unsw.edu.au>, akpm@digeo.com,
	linux-kernel@vger.kernel.org
References: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au> <20030827065435.GV4306@holomorphy.com> <20030827155246.GA23609@work.bitmover.com> <20030827160133.GD4306@holomorphy.com> <20030827160939.GA29987@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030827160939.GA29987@work.bitmover.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 09:09:39AM -0700, Larry McVoy wrote:
> This is the classic response that I get whenever I raise this sort of
> concern.  I got it at Sun, I got it at SGI.  Everyone says "my change
> made no difference".  And they are right from one point of view: you
> run some micro benchmark and you can't see any difference.
> Of course you can't see any difference, in the microbenchmark everything
> is in the cache.  But you did increase the amount of cache usage.
> Consider a real world case where the application and the kernel now
> just exactly fit in the caches for the critical loop.  Adding one
> extra cache line will hurt that application but would never be seen in
> a microbenchmark.

I used a macrobenchmark for this measurement with instruction-level
profiling on cache misses, TLB misses, and cpu cycles.

An unusual result of this was that with respect to cpu cycles, the
most costly operation in the entire kernel after bitblitting userspace
memory was rounding the stack pointer to find current_thread_info();
that is, it was #3, behind only copy_to_user_ll()/copy_from_user_ll().


On Wed, Aug 27, 2003 at 09:09:39AM -0700, Larry McVoy wrote:
> The only way to really measure this is with real work loads and a cache
> miss counter.  And even that won't always show up because if the work load
> you choose happened to only use 1/2 of the data cache (for instance) you
> need to add enough more than 1/2 of the cache lines to show up in the 
> results.

I already used the cache miss counter. Seeing mm->rss take numerous
cache misses in the loop of copy_page_range() (in mainline!) seemed
unusual. A vaguely plausible explanation (guesswork is required without
an ITP/ICE or a sufficiently useful simulator) is that the pagetable
bitblitting evicted it from the cache, despite my _very_ intense
efforts to reduce the amount of pagetable bitblitting via cacheing.
An alternative explanation is that the off-node access to slab memory
took such large remote access penalties when it did have cache misses
that even a low miss rate elevated it to the the top of the profile.


On Wed, Aug 27, 2003 at 09:09:39AM -0700, Larry McVoy wrote:
> Think of it this way: we can add N extra cache lines and see no
> difference.  Then we add the Nth+1 and all of a sudden things get slow.
> Is that the fault of the Nth+1 guy?  Nope.  It's the fault of all N,
> the Nth+1 guy just had bad timing, he should have gotten his change
> in earlier.
> I realize that I'm being extreme here but if I can get this point across
> that's a good thing.  I'm convinced that it was a lack of understanding
> of this point that lead to the bloated commercial operating systems.
> Linux needs to stay fast.  Processors have cycle times of a third of a
> nanosecond yet memory is still ~130ns away.

This is not lost on me (and I'm in fact pushing other cache preservation
code very hard; c.f. pagetable cacheing discussions and the soon to be
sent bottom-level pagetable cacheing code in -wli). The fact of the
matter is that we lose a cacheline at a time, and if we've already lost
one to mm->rss, we should utilize the rest of it for whatever other
counters are prudent instead of wasting the rest of it.

A number of the rest of these counters are very infrequently updated;
IMHO such things as nswaps (whenever we get load control, which we seem
to be getting various complaints about lacking) and signal counts are
updated rarely enough to ignore the effects of.


-- wli
