Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbUJ0C2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbUJ0C2w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbUJ0C2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:28:52 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:36531 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261578AbUJ0C2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:28:25 -0400
Date: Wed, 27 Oct 2004 04:29:20 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-ID: <20041027022920.GS14325@dualathlon.random>
References: <417DCFDD.50606@yahoo.com.au> <Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com> <20041027005425.GO14325@dualathlon.random> <417F025F.5080001@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417F025F.5080001@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 12:05:19PM +1000, Nick Piggin wrote:
> Andrea Arcangeli wrote:
> 
> >the per-classzone kswapd treshold was very well taken care of in 2.4,
> >thanks the watermarks embedding the low/min/high and the classzone being
> >passed up to the kswapd wakeup function.
> >
> 
> Kswapd actually should take care of this properly: see the
> initial loop before the real scanning loop.

I don't see how it can take care of it, if it doesn't even get a wakeup?
kswapd just sleeps.

kswapd is just an optimization, we try provide async allocation if the
kswapd watermarks can it keep up between low and high (and we hang
synchronosly while hitting the wall at min), so it's not fatal that
kswapd sleeps, but it can be fixed easily with the patch I just posted
some minute ago.

> I thought this was a bit subtle, but it seems to work fine,
> and Andrew likes it.
>
> I have a patch to explicitly have kswapd use the lower zone
> protection watermarks but I haven't really demonstrated it is
> better than what is currently there (other than being simpler).

how can it ever wakeup if nobody ever calls
wake_up_interruptible(&zone->zone_pgdat->kswapd_wait)?


Now the patch I posted fixes the wakeup side, but I'm not sure that the
"stop" is properly done yet. Peraphs that's what you mean, that the
kswapd-stop decision already works despite not being aware of the
low memory ram reservation?

Following the code I see nr_pages is 0 in balance_pgdat when invoked
from kswapd. nr_pages then goes here:

		if (nr_pages == 0) {
			/*
			 * Scan in the highmem->dma direction for the
			 * highest
			 * zone which needs scanning
			 */
			for (i = pgdat->nr_zones - 1; i >= 0; i--) {
				struct zone *zone = pgdat->node_zones + i;

				if (zone->all_unreclaimable &&
						priority != DEF_PRIORITY)
					continue;

				if (zone->free_pages <= zone->pages_high) {
					end_zone = i;
					goto scan;
				}
			}
			goto out;


shouldn't we take the full watermarks into account in the above too?
I think so, otherwise we wakeup but it goes back to sleep, i.e.
overscheduling but nothing done still, so I'm going to fixup the stop as
well.
