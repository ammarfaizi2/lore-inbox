Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUJWLDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUJWLDR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 07:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267283AbUJWLDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 07:03:16 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:46260 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S267285AbUJWLCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 07:02:34 -0400
Date: Sat, 23 Oct 2004 13:03:34 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-ID: <20041023110334.GS14325@dualathlon.random>
References: <20041020213622.77afdd4a.akpm@osdl.org> <417837A7.8010908@yahoo.com.au> <20041021224533.GB8756@dualathlon.random> <41785585.6030809@yahoo.com.au> <20041022011057.GC14325@dualathlon.random> <41787840.3060807@yahoo.com.au> <20041022165809.GH14325@dualathlon.random> <4179DF23.4030402@yahoo.com.au> <20041023095955.GR14325@dualathlon.random> <417A30EE.1030205@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417A30EE.1030205@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 08:22:38PM +1000, Nick Piggin wrote:
> It is an unlikely scenario, but it is definitely good for robustness.
> Especially on small memory systems where the amount allocated doesn't
> have to be that large.
> 
> Let's say a 16MB system pages_low ~= 64K, so we'll also say we've

btw, thinking the watermarks linear with the amount of memory isn't
correct. the watermarks for zone normal against zone normal (i.e. the
current pages_xx of 2.6) should have an high and low limit indipendent
on the memory size of the machine. the low limit is what the machine
needs to avoid locking up in the PF_MEMALLOC paths. So it obviously has
absolutely nothing to do with the amount of ram in the machine.

64k sounds way too low even for a PDA that doesn't swap, still there are
PF_MEMALLOC paths in the dcache and fs methods.

but this is just a side note, let's assume 64k would be sane in this
workload (a page size smaller than 4k that in turn requires less ram to
execute method on each page object would make it sane for example).

> currently got 64K free. Someone then wants to do an order 4 allocation
> OK they succeed (assuming memory isn't fragmented) and there's 0K free.
> 
> Which is bad because you can now get deadlocks when trying to free
> memory.

I got what you mean, I misread that code sorry, you're perfectly right
about order being needed in that code.

In 2.4 I had to implement it too of course, it's just much cleaner than
2.6.

static inline unsigned long zone_free_pages(zone_t * zone, unsigned int order)
{
	long free = zone->free_pages - (1UL << order);
	return free >= 0 ? free : 0;
}


	for (;;) {
		zone_t *z = *(zone++);
		if (!z)
			break;

		if (zone_free_pages(z, order) > z->watermarks[class_idx].low) {
			page = rmqueue(z, order);
			if (page)
				return page;
		}
	}


this compares with your 2.6 code:

	for (i = 0; (z = zones[i]) != NULL; i++) {
		min = z->pages_min;
		if (gfp_mask & __GFP_HIGH)
			min /= 2;
		if (can_try_harder)
			min -= min / 4;
		min += (1<<order) + z->protection[alloc_type];

		if (z->free_pages < min)
			continue;

		page = buffered_rmqueue(z, order, gfp_mask);
		if (page)
			goto got_pg;
	}

When I was reading "z->free_pages < min" in your code, I was really
reading like my code here "zone_free_pages(z, order) > z->watermarks[class_idx].low"
I was taking for given the free_pages - 1UL<<order was already accounted
in z->free_pages, because I hidden that calculation in a method so I'm
not used to think about it while reading alloc_pages (I assumed that
thing was already accounted for in a different function like in 2.4).

Sorry if I'm biased but I read and modified 2.4 many more times than
2.6.

> Oh if you've still got the three watermarks then that may work -
> I thought you meant getting rid of one of the *completely*.
> 
> But I'm still not sure what advantage you see in moving from
> pages_xxx + protection to a single watermark.

then what advantage you get to compute pages_xx + protection at runtime
when reading a pages_xx that already contains the protection would be
enough? I avoid computations at runtime and I keep the localized in the
watermark generation. I doubt it makes much difference but this is the
way I did in 2.4 and it looks cleaner to me, plus this avoids me to
reinvent the wheel.
