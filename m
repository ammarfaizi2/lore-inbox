Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbUKCCF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbUKCCF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 21:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbUKCCF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 21:05:58 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:23274 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261328AbUKCCFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 21:05:47 -0500
Date: Wed, 3 Nov 2004 03:05:35 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <20041103020535.GG3571@dualathlon.random>
References: <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random> <20041102022122.GJ3571@dualathlon.random> <11900000.1099410137@[10.10.2.4]> <20041102130910.3e779d32.akpm@osdl.org> <20041102215651.GU3571@dualathlon.random> <235610000.1099435275@flay> <20041103010952.GA3571@dualathlon.random> <41883300.8060707@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41883300.8060707@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 12:23:12PM +1100, Nick Piggin wrote:
> I see what you mean. You could be correct that it would model cache
> behaviour better to just have the last N freed "hot" pages in LIFO
> order on the list, and allocate cold pages from the other end of it.

I believe this is the more efficient way to use the per-cpu resources to
still provide hot/cold behaviour, we should verify it though.

Plus I provide hot-cold info to the zerolist too the same way.

with the current model I'd need 4 per-cpu lists.

> You still don't want cold freeing to pollute this list, *but* you do
> want to still batch up cold freeing to amortise the buddy's lock
> aquisition.
> 
> You could do that with just one list, if you gave cold pages a small
> extra allowance to batch freeing if the list is full.

Once the list is full, I free a "batch" from the other end of it. And
then I put the new page into the list.

I agree that if I've to fallback into the buddy allocator to free pages
because the list is full, then if it's a __GFP_COLD freeing, I should
put the cold page into the buddy first. While I'm putting the cold page
into the list instead. So I'm basically off-by one potentially hot page.

I doubt it makes any difference (this only matters when the list is
completely full of only hot pages [unlikely since the list size is
bigger than l2 size and cache isn't only allocated on the freed pages,
but also on the still allocated pages]), but I think I can easily change
it to put the page at the end first, and then to batch the freeing. This
will fix this minor performance issue in my code (theoretically it's
more efficient the way you suggested ;). It's more an implementation bug
than anything I did intentionally ;).

> I think you want to still take them off the cold end. Taking a

yes, there is no doubt I want to take cold pages from the other end. But
if no improvement can be measured by picking always hot pages, then of
course picking them from the cold end isn't going to payoff much... ;)

> really cache hot page and having it invalidated is worse than
> having some cachelines out of your combined pool of hot pages
> pushed out when you heat the cold page.

how much worse? I do understand the snooping has a cost, but that dma is
pretty slow anyways.

Or you mean it's because the hot pages won't be guaranteed to be
completely cold but just a few cacheline cold? I prefer the next hot page to
be guaranteed to be still hot even after dma completes than to avoid
snooping and clobber the cache randomly.

If you invalidate the cache of an hot page, you're guaranteed you won't
affect the next hot page, the next hot page is guaranteed to be still
hot even after dma has completed.

I'm not sure what's more important but I don't feel reserving is right.

With the PG_zero-2-no-zerolist-reserve-1 I went as far as un-reserving
zero pages during non-zero allocations. despite they're in different
lists ;). I need them in different lists to provide PG_zero efficiently
and to track hot-cold info  into the zerolist too. But I stopped all
reservations even if they're already zero. This way the 200% boost in
the microbench isn't guaranteed anymore but it very often happens.
