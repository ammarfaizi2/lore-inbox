Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311938AbSCTSlS>; Wed, 20 Mar 2002 13:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311937AbSCTSlI>; Wed, 20 Mar 2002 13:41:08 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:12864 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311935AbSCTSlC>; Wed, 20 Mar 2002 13:41:02 -0500
Date: Wed, 20 Mar 2002 19:40:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scalability problem (kmap_lock) with -aa kernels
Message-ID: <20020320194051.I4268@dualathlon.random>
In-Reply-To: <257350410.1016612071@[10.10.2.3]> <20020320173959.F4268@dualathlon.random> <122510000.1016648204@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 10:16:44AM -0800, Martin J. Bligh wrote:
> --On Wednesday, March 20, 2002 17:39:59 +0100 Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > On Wed, Mar 20, 2002 at 08:14:31AM -0800, Martin J. Bligh wrote:
> >> I don't believe that kmap_high is really O(N) on the size of the pool.
> > 
> > It is O(N), that's the worst case. Of course assuming that the number of
> > entries in the pool is N and that it is variable, for us it is variable
> > at compile time.
> > ...
> > and if we didn't find anything we call flush_all_zero_pkmaps that does a
> > whole O(N) scan on the pool to try to release the entries that aren't
> > pinned and then we try again. In short if we increase the pool size, we
> > linearly increase the time we spend on it (actually more than linearly
> > because we'll run out of l1/l2/l3 while the pool size increases)
> 
> Worst case I agree is about is O(N), though you're forgetting the cost of
> the global tlb_flush_all. Average case isn't by a long way, it's more like
> O(1).

Common case is O(1) of course, but "average" it's a mean between "worst"
and "best/common". I'm not missing anything about the global flush
either.

It _enterely_ depends on the timings.

If the global flush takes 1 hour, and the O(N) pass takes 1usec, you'd
better increase N.

If the O(N) pass takes 1 hour, and the flush takes 1usec, you'd better
drecrease N.

This is always been clear, it's just that I _didn't_ know the exact
timings of your hardware before this thread, so I couldn't calculate
with math what was the best balance between the two (plus there's also
the fact of the process sleeping and the page->virtual cache size that
changes as well and that are other variables that you overlooked in your
below equation, that are non nearly not possible to evaluate with an
exact math formula as well).

2048 looked a fair enough balance, 8M of mapped cache, not an excessive
virtual space wasted, and not too high frequency of the flushes (that
probably are very costly on a 16way). Thanks to Hugh's hold-counter now
the kmaps can also be shared across the higher user. so the 8m of cache
are used at best for both pagecache and pagetables.

> N = size of pool - number of permanent maps (makes the math readable)
> F = cost of global tlbflush.
> 
> cost without flush = 1, which happens every time we do an alloc.
> cost of flush = N + F (N to go through flush_all_pkmaps, zeroing)
> 
> => average cost = 1/N + (N+F)/N = (1+F+N)/N = 1 + (1+F)/N
> 
> So the cost (on average) actually gets cheaper as the pool size increases.
> Yes, I've simpilified things a little by ignoring the case of stepping over
> the permanently allocated maps (this get less frequent as pool size is
> increased, thus this actually helps), and by ignoring the cache effects
> you mention, but I'm sure you see my point.
> 
> If you wanted to fix the worst case for latency issues, I would think it
> would be possible to split the pool in half - we could still allocate out
> of one half whilst we flush the other half (release the lock during a
> half-flush, but mark in a current_half variable (protected by the lock) 
> where newcomers should be currently allocating from). I haven't really
> thought this last bit through, so it might be totally bogus.
> 
> But all this is moot, as what's killing me is really the global lock ;-)

Quite a lot yes. Furthmore the global tlb flush is slow and it has to be
run atomically to avoid people to start using entries still cached in
the tlb with corrupted values. so it doesn't matter much the size of the
pool, the flush_pkmap pass still is slow due the global flush and the
other cpus stalls into the lock.

> >> If you could give me a patch to do that, I'd be happy to try it out.
> > 
> > I will do that in the next -aa. I've quite a lot of stuff pending
> 
> Cool - thanks.
>  
> > The only brainer problem with the total removal of the persistent kmaps
> > are the copy-users, what's your idea about it? (and of course I'm not
> > going to change that anyways in 2.4, it's not a showstopper)
> 
> Writing that up now ...

I outlined a possible way to do that too in the previous email, not sure
if there are possibility to make it completly scalar per-cpu, I hope so
because the pinning of the task doesn't look very appealing from a
scheduler standpoint.

Andrea
