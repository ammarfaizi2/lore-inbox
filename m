Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271515AbRIBBuR>; Sat, 1 Sep 2001 21:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271518AbRIBBuI>; Sat, 1 Sep 2001 21:50:08 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:6664 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271515AbRIBBuE>; Sat, 1 Sep 2001 21:50:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Date: Sun, 2 Sep 2001 03:57:10 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20010901202823.303eb0eb.skraw@ithnet.com>
In-Reply-To: <20010901202823.303eb0eb.skraw@ithnet.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010902015023Z16303-32383+2910@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 1, 2001 08:28 pm, Stephan von Krawczynski wrote:
> On Fri, 31 Aug 2001 21:03:22 +0200
> Daniel Phillips <phillips@bonn-fries.net> wrote:
> 
> > > >  		/* XXX: is pages_min/4 a good amount to reserve for this? */
> > > > +		if (z->free_pages < z->pages_min / 3 && (gfp_mask & __GFP_WAIT) &&
> > > > +				!(current->flags & PF_MEMALLOC))
> > > > +			continue;
> > > Hello Daniel,
> > > 
> > > I tried this patch and it makes _no_ difference. Failures show up in same 
> > > situation and amount. Do you need traces? They look the same
> > 
> > OK, first would you confirm that the frequency of 0 order failures has
> > stayed the same?
> 
> Hello Daniel (and the rest),
> 
> I redid the test and have the following results, based on a 2.4.10-pre2 with
> above patch:
> [...]
>
> And the traces:
> 83 mostly identical errors showed up, all looking like
> 
> Sep  1 15:17:53 admin kernel: cdda2wav: __alloc_pages: 3-order allocation
> failed (gfp=0x20/0).
> [...]
> Trace; fdcf80f5 <[sg]sg_build_reserve+25/48>
> Trace; fdcf6589 <[sg]sg_ioctl+6c5/ae4>
> Trace; fdcf76bd <[sg]sg_build_indi+55/1a8>
> 
> So, there are no 0-order allocs failing in this setup.
> 
> Are you content with having no 0-order failures?

It's a start.  The important thing is to have supported my theory of what is
going on here.  What I did there is probably a good thing, it seems quite
effective for combatting 0 order atomic failures.  In this case you have a
driver that uses a fallback allocation strategy, starting with a 3 order
allocation attempt and dropping down top the next lower size on failure.  If
0 order allocation fails the whole operation fails, and maybe you will lose
a packet.  So 0 order allocations are important, we really want them to
succeed.

The next part of the theory says that the higher order allocations are
failing because of fragmentation.  I put considerable thought into this
today while wandering around in a dungeon in Berlin watching bats (really)
and I will post an article to lkml tomorrow with my findings.  To summarize
briefly here: a Linux system in steady state operation *is* going to show
physical fragmentation so that the chance of a higher order allocation
succeeding becomes very small.  The chance of failure increases
exponentially (or worse) with a) the allocation order and b) the ratio of
allocated to free memory.  The second of these you can control: the higher
you set zone->pages_min the better chance your higher order allocations
will have to succeed.  Do you want a patch for that, to see if this works
in practice?

Of course it would be much better if we had some positive mechanism for
defragging physical memory instead of just relying on chance and hoping
for the best the way we do now.  IMHO, such a mechanism can be built
practically and I'm willing to give it a try.  Basically, kswapd would try
to restore a depleted zone order list by scanning mem_map to find buddy
partners for free blocks of the next lower order.  This strategy, together
with the one used in the patch above, could largly eliminate atomic
allocation failures.  (Although as I mentioned some time ago, getting rid
of them entirely is an impossible problem.)

The question remains why we suddenly started seeing more atomic allocation
failures in the recent Linus trees.  I'll guess that the changes in
scanning strategy have caused the system to spend more time close to the
zone->pages_min amount of free memory.  This idea seems to be supported by
your memstat listings.  In some sense, it's been good to have the issue
forced so that we must come up with ways to make atomic and higher order
allocations less fragile.

--
Daniel
