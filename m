Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSHGUM1>; Wed, 7 Aug 2002 16:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSHGUM1>; Wed, 7 Aug 2002 16:12:27 -0400
Received: from dsl-213-023-022-051.arcor-ip.net ([213.23.22.51]:31659 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313113AbSHGUMZ>;
	Wed, 7 Aug 2002 16:12:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] Rmap speedup
Date: Wed, 7 Aug 2002 22:17:31 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com,
       Rik van Riel <riel@conectiva.com.br>
References: <E17aiJv-0007cr-00@starship> <E17cW1O-0003Tm-00@starship> <3D5177CB.D8CA77C2@zip.com.au>
In-Reply-To: <3D5177CB.D8CA77C2@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17cXFM-0004si-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 August 2002 21:40, Andrew Morton wrote:
> Daniel Phillips wrote:
> > What stands out for me is that rmap is now apparently at parity with
> > (virtual scanning) 2.4.19 for a real application, i.e., parallel make.
> > I'm sure we'll still see the raw setup/teardown overhead if we make a
> > point of going looking for it, but it would be weird if we didn't.
> > 
> > So can we tentatively declare victory of the execution overhead issue?
> 
> err, no.  It's still adding half a millisecond or so to each fork/exec/exit
> cycle.  And that is arising from, apparently, an extra two cache misses
> per page.  Doubt if we can take this much further.

But that overhead did not show up in the kernel build timings you posted, 
which do a realistic amount of forking.  So what is the worry, exactly?

> > ...
> > Vectoring up the pte chain nodes as
> > you do here doesn't help much because the internal fragmentation
> > roughly equals the reduction in link fields.
> 
> Are you sure about that?  The vectoring is only a loss for very low
> sharing levels, at which the space consumption isn't a problem anyway.
> At high levels of sharing it's almost a halving.

Your vector will only be half full on average.

> > So coalescing is the next big evil problem to tackle.  It occurs to me
> > that defragging pte chain node pages is actually easy and local.
> 
> If we are forced to actively defragment pte_chain pages then 
> it's all just getting too much, surely.

The algorithm I showed is pretty simple.  Active defragmentation is just
something we should be doing, where we can.  Fragmentation does happen,
and there are too many places where we're just trying to pretend that it
doesn't, or fiddling with allocation policy in the hopes it will magically
go away, which it never does.

> > Rmap is clearly going to help a lot with swapout on heavily shared
> > pages by giving us active unmapping, so we don't have to leave large
> > numbers of pages sitting around half in memory and half in swap.  But
> > rmap doesn't help a bit with that same nasty behaviour on swapin; we
> > still have to wait patiently for every sharer to get around to
> > faulting in the page, and in my mind, that makes it very easy to
> > construct a test case that turns all of swap into a useless appendage,
> > full of half swapped-in pages.
> 
> Is it useful to instantiate the swapped-in page into everyone's
> pagetables, save some minor faults?

That's what I was thinking, then we just have to figure out how to find
all those swapped-out ptes efficiently.

> > So I'd suggest just forgetting about the collapse-to-direct feature.  With
> > pte chain coalescing we'll eventually get the memory back.
> 
> I implemented Rik's suggestion.  The collapse back to direct representation
> happens in page_referenced().  So it happens only in response to page reclaim
> activity, when the system needs memory.  Nice, yes?

Yes, nice.

-- 
Daniel
