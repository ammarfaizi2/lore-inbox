Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317945AbSHGTjh>; Wed, 7 Aug 2002 15:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319286AbSHGTjg>; Wed, 7 Aug 2002 15:39:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55559 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317945AbSHGTje>;
	Wed, 7 Aug 2002 15:39:34 -0400
Message-ID: <3D5177CB.D8CA77C2@zip.com.au>
Date: Wed, 07 Aug 2002 12:40:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: linux-kernel@vger.kernel.org, wli@holomorphy.com,
       Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] Rmap speedup
References: <E17aiJv-0007cr-00@starship> <3D4DB9E4.E785184E@zip.com.au> <3D4E23C4.F746CF3D@zip.com.au> <E17cW1O-0003Tm-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ...
> > This patch _has_ to help, even if not on my box.  Plus it's gorgeous ;)  See
> > how it minimises internal fragmentation and cache misses at the same time.
> 
> It is very nice, and short.  It would be a shame if it didn't actually
> accomplish anything.  Have you got any more data on that?

Nope.  Just warm and fuzzies.

> What stands out for me is that rmap is now apparently at parity with
> (virtual scanning) 2.4.19 for a real application, i.e., parallel make.
> I'm sure we'll still see the raw setup/teardown overhead if we make a
> point of going looking for it, but it would be weird if we didn't.
> 
> So can we tentatively declare victory of the execution overhead issue?

err, no.  It's still adding half a millisecond or so to each fork/exec/exit
cycle.  And that is arising from, apparently, an extra two cache misses
per page.  Doubt if we can take this much further.

> ...
> Vectoring up the pte chain nodes as
> you do here doesn't help much because the internal fragmentation
> roughly equals the reduction in link fields.

Are you sure about that?  The vectoring is only a loss for very low
sharing levels, at which the space consumption isn't a problem anyway.
At high levels of sharing it's almost a halving.

> So coalescing is the next big evil problem to tackle.  It occurs to me
> that defragging pte chain node pages is actually easy and local.

If we are forced to actively defragment pte_chain pages then 
it's all just getting too much, surely.

> ...
> 
> Anyway, I think we are within sight of running out of serious issues
> and now is the time to start testing the thing that rmap is supposed
> to improve, namely swap performance.
> 
> Rmap is clearly going to help a lot with swapout on heavily shared
> pages by giving us active unmapping, so we don't have to leave large
> numbers of pages sitting around half in memory and half in swap.  But
> rmap doesn't help a bit with that same nasty behaviour on swapin; we
> still have to wait patiently for every sharer to get around to
> faulting in the page, and in my mind, that makes it very easy to
> construct a test case that turns all of swap into a useless appendage,
> full of half swapped-in pages.

Is it useful to instantiate the swapped-in page into everyone's
pagetables, save some minor faults?


> > Should we count PageDirect rmaps in /proc/meminfo:ReverseMaps?
> > I chose not to, so we can compare that number with the slabinfo
> > for pte_chains and see how much memory is being wasted.  Plus the
> > PageDirect rmaps aren't very interesting, because they don't consume
> > any resources.
> 
> Agreed.  It would be nice to have a stat for total ptes mapped, and we
> can see how total pte chain nodes compares to that.  These two stats
> will allow users to form an accurate impression of just how much memory
> is being eaten by pte chains.

This can be determined from a bit of math on
/proc/meminfo:ReverseMaps and /proc/slabinfo:pte_chains
 
> ...
> > [...]
> >
> > + * - If a page has a pte_chain list then it is shared by at least two processes,
> > + *   because a single sharing uses PageDirect. (Well, this isn't true yet,
> > + *   coz this code doesn't collapse singletons back to PageDirect on the remove
> > + *   path).
> 
> That's not necessarily such a bad thing.  Consider what happens with bash:
> first a bunch of do_no_page events cause the direct links to be created as
> bash faults in the various mmaps it uses, then it forks to exec a command,
> causing all the direct links to turn into pte chain nodes, then the command
> execs.  If you collapse all the pte chain nodes back to direct links at
> this point they're just going to be created again on the next fork/exec,
> in other words, lots of extra churning.

Yes.
 
> So I'd suggest just forgetting about the collapse-to-direct feature.  With
> pte chain coalescing we'll eventually get the memory back.

I implemented Rik's suggestion.  The collapse back to direct representation
happens in page_referenced().  So it happens only in response to page reclaim
activity, when the system needs memory.  Nice, yes?

> > [...]
> >
> > + * - Insertion into the pte_chain puts a pte pointer in the last free slot of
> > + *   the head member.
> 
> I don't know why you decided to fill in from top to bottom but I suppose it
> scarcely makes a difference.  You might want to run this one backwards and
> take an early exit on null:
> 
> > +                     for (i = 0; i < NRPTE; i++) {
> > +                             pte_t *p = pc->ptes[i];
> > +                             if (p && ptep_test_and_clear_young(p))
> > +                                     referenced++;
> > +                     }

Thanks, did that.

> >
> > [...]
> >
> > + * - Removal from a pte chain moves the head pte of the head member onto the
> > + *   victim pte and frees the head member if it became empty.
> 
> Thus randomizing the order and losing the pushdown effect, oh well.
> 

Only a little, I expect.  If the access pattern is mostly LIFO then we'll
still get good locality at the head of the chain.
