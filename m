Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319189AbSHGSyN>; Wed, 7 Aug 2002 14:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319192AbSHGSyE>; Wed, 7 Aug 2002 14:54:04 -0400
Received: from dsl-213-023-022-051.arcor-ip.net ([213.23.22.51]:45482 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319191AbSHGSx6>;
	Wed, 7 Aug 2002 14:53:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rmap speedup
Date: Wed, 7 Aug 2002 20:59:02 +0200
X-Mailer: KMail [version 1.3.2]
References: <E17aiJv-0007cr-00@starship> <3D4DB9E4.E785184E@zip.com.au> <3D4E23C4.F746CF3D@zip.com.au>
In-Reply-To: <3D4E23C4.F746CF3D@zip.com.au>
Cc: wli@holomorphy.com, Rik van Riel <riel@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17cW1O-0003Tm-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 August 2002 09:05, Andrew Morton wrote:
> Tomorrow came early.
> 
> It makes basically no difference at all.  Maybe pulled back 10 of the lost
> 50%.  The kernel is still spending much time in the pte_chain walk in
> page_remove_rmap().
> 
> Despite the fact that the number of pte_chain references in page_add/remove_rmap
> now just averages two in that test.  So I'm rather stumped.  It seems that
> adding any misses at all to the copy_page_range/zap_page_range path hurts.
> 
> This patch _has_ to help, even if not on my box.  Plus it's gorgeous ;)  See
> how it minimises internal fragmentation and cache misses at the same time.

It is very nice, and short.  It would be a shame if it didn't actually
accomplish anything.  Have you got any more data on that?

> Let's look at `make -j6 bzImage':
> 
> [...]
>
> Not much stands out there, except that the increase in HZ hurts
> more than rmap.

What stands out for me is that rmap is now apparently at parity with
(virtual scanning) 2.4.19 for a real application, i.e., parallel make.
I'm sure we'll still see the raw setup/teardown overhead if we make a
point of going looking for it, but it would be weird if we didn't.

So can we tentatively declare victory of the execution overhead issue?
This is looking very good:

> 2.5.26:
> make -j6 bzImage  395.35s user 31.21s system 377% cpu 1:52.94 total
> 2.5.30:
> make -j6 bzImage  395.55s user 33.00s system 375% cpu 1:54.19 total
> 2.5.30+everything
> make -j6 bzImage  395.76s user 32.97s system 382% cpu 1:52.00 total
> 2.4.19
> make -j6 bzImage  397.74s user 28.27s system 373% cpu 1:53.91 total
> 2.5.30+everything+HZ=100
> make -j6 bzImage  393.60s user 28.91s system 373% cpu 1:53.06 total

There's still the memory consumption issue, and indeed, we can
construct a case where pte chain overhead is twice that of page tables
themselves, so I have to apologize to Martin Bligh for claiming a few
weeks ago that that can't happen.  Vectoring up the pte chain nodes as
you do here doesn't help much because the internal fragmentation
roughly equals the reduction in link fields.

So coalescing is the next big evil problem to tackle.  It occurs to me
that defragging pte chain node pages is actually easy and local.  A
reasonable algorithm goes something like this:

  Take the pte chain lock
  For each allocated pte chain node on the page
     Pick any referenced pte on it, get the reference page and take
     the rmap lock

     If the page's rmap list doesn't include this pte chain node
     any more, repeat the above steps until it does

     Copy the contents of the pte chain node onto a newly allocated
     pte chain node, and substitute the new node for the old one

     Free the old pte chain node
  Release the pte chain lock

It's actually more important to be able to coalesce pte chain nodes as
needed than it is to save space, since for the average case we should
be using mostly direct pointers anyway.

Anyway, I think we are within sight of running out of serious issues
and now is the time to start testing the thing that rmap is supposed
to improve, namely swap performance.

Rmap is clearly going to help a lot with swapout on heavily shared
pages by giving us active unmapping, so we don't have to leave large
numbers of pages sitting around half in memory and half in swap.  But
rmap doesn't help a bit with that same nasty behaviour on swapin; we
still have to wait patiently for every sharer to get around to
faulting in the page, and in my mind, that makes it very easy to
construct a test case that turns all of swap into a useless appendage,
full of half swapped-in pages.  In other words, swapping is going to
continue to suck until we do something about that, and now is a good 
time to start kicking ideas around.

Now is also the time to think about making active defragmentation
happen.  In my mind, active defragmentation is the only way that
any of the large page patches are going to be halfway useful instead
of just a great source of deadly corner cases.

I'll propose an approach to get the ball rolling.  We have two new
lru lists, a GPF_Defrag allocation flag and a new ZONE_LARGE.  A page
allocation with GPF_Defrag means the caller promises not to pin the
unit for long periods, and the (n order) unit is allocated
preferentially in ZONE_LARGE.  This zone has two lrus: one has
complete LARGE_PAGE_ORDER allocation units on it, the other has
various allocation orders mixed together, but the lru list is still
organized in LARGE_PAGE_ORDER units.  So the second lru list will
naturally organize itself with good defragmentation candidates
towards the cold end of the list.  When we detect a deficit of
large pages, we start from the cold end of the list and proceed to
unmap and copy in-use pages off somewhere else (glossing over the
exact definition of 'somewhere else' for the moment).  The condition
for being able to move a page is exactly the same as being able to
unmap it, and naturally, the unmapping attempt may fail because
somebody has taken a temporary use count on the page.  We hope
that that doesn't happen too often, and punting such aunit to the 
hot end of the list might well be the right thing to do.

In short, we will always be able to create a good supply of
LARGE_PAGE_ORDER pages in ZONE_LARGE, unless somebody is lying to
us about pinning pages.  Um, memlock, we still have to worry about
that, but that's an orthogonal issue.

> Should we count PageDirect rmaps in /proc/meminfo:ReverseMaps?
> I chose not to, so we can compare that number with the slabinfo
> for pte_chains and see how much memory is being wasted.  Plus the
> PageDirect rmaps aren't very interesting, because they don't consume
> any resources.

Agreed.  It would be nice to have a stat for total ptes mapped, and we
can see how total pte chain nodes compares to that.  These two stats 
will allow users to form an accurate impression of just how much memory 
is being eaten by pte chains.

As I mentioned earlier, I do have one more major optimization waiting in
the wings if we need it, which allows pte chain nodes to be shared.  But
since you pointed out so delicately that there are other projects needing
attention, I'd be just as happy to put that one away until we're sure 
it's needed, or until somebody has too much time on their hands.

> [...]
>
> + * - If a page has a pte_chain list then it is shared by at least two processes,
> + *   because a single sharing uses PageDirect. (Well, this isn't true yet,
> + *   coz this code doesn't collapse singletons back to PageDirect on the remove
> + *   path).

That's not necessarily such a bad thing.  Consider what happens with bash: 
first a bunch of do_no_page events cause the direct links to be created as
bash faults in the various mmaps it uses, then it forks to exec a command,
causing all the direct links to turn into pte chain nodes, then the command
execs.  If you collapse all the pte chain nodes back to direct links at
this point they're just going to be created again on the next fork/exec,
in other words, lots of extra churning.

So I'd suggest just forgetting about the collapse-to-direct feature.  With
pte chain coalescing we'll eventually get the memory back.

> [...]
>
> + * - Insertion into the pte_chain puts a pte pointer in the last free slot of
> + *   the head member.

I don't know why you decided to fill in from top to bottom but I suppose it
scarcely makes a difference.  You might want to run this one backwards and
take an early exit on null:

> +			for (i = 0; i < NRPTE; i++) {
> +				pte_t *p = pc->ptes[i];
> +				if (p && ptep_test_and_clear_young(p))
> +					referenced++;
> +			}
>
> [...]
>
> + * - Removal from a pte chain moves the head pte of the head member onto the
> + *   victim pte and frees the head member if it became empty.

Thus randomizing the order and losing the pushdown effect, oh well.

-- 
Daniel
