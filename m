Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbUKCB02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbUKCB02 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbUKCB01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:26:27 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:13190 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261228AbUKCB0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 20:26:11 -0500
Date: Wed, 3 Nov 2004 02:26:07 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <20041103012607.GB3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random> <20041102022122.GJ3571@dualathlon.random> <11900000.1099410137@[10.10.2.4]> <20041102195007.GP3571@dualathlon.random> <235520000.1099435272@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <235520000.1099435272@flay>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 02:41:12PM -0800, Martin J. Bligh wrote:
> it's really one list. However, I'd like to stop the cold list stealing
> from the hot, so I think it's easier to *implement* it as two lists,
> because there's nothing in the standard list code to add a magic marker
> on one element in the middle (though maybe you can think of a trick way


sure if we want to stop cold allocations to get hot pages we need two
lists.

> Yes, it's certainly faster to do that one operation - no dispute from me.
> However, the question is whether it's worth trading off against the
> cache-warmth of pages ... that's why we wrote it that way originally, to
> preserve that.

my argument is very simple. A random content cold page is worthless.

When somebody allocates a free page, it will either:

1) write to it with the cpu to write some useful data into it, so the
page has a value (not the case since it used __GFP_COLD and we assume it
was not using __GFP_COLD by mistake)
2) use DMA to write something useful into the page

Now after 2) unless it's readahead, it will also _read_ or modify the
contents of the page. And writing into a _cold_ page with the cpu, isn't
very different from doing DMA into an hot page. At least this is my
theory, I'm not an hardware designer but there should be some cache
snooping during the invalidates that shouldn't be very different from
the cache recycling. Note that we've no clue if the cache is hot in the
other cpus as well, this is all per-cpu stuff.

Probably the only way to know if retaining the separated hot/cold list
is worthwhile is benchmarking.

I'm pretty sure __GFP_COLD makes huge difference for the freeing of ram,
but I doubt it does for the allocation of ram. Everybody who is
allocating memory is going to write to it and touch it with the cpu
eventually.

While freed ram may remain cold forever, so to me __GFP_COLD looks more
a freeing-ram allocation.

There's not such thing as allocating ram and never going to touch it
with the CPU anytime soon.

> Probably easier to make it a per-arch option to define, but yes, if one
> arch works better one way, and others the other, we can make it optional
> fairly easily in lots of ways. <insert traditional disagreement with
> "new" vs "old" connotations here ...>

yep ;).

> Well, remember that the lists only contain a very small amount of memory
> relative to the machine size anyway, so I'm not really worried about us
> triggering early OOMs or whatever.

I'm a bit worried for the many cpu systems. Since I'm also not limiting
the per-cpu size in function of the total ram of the machine, one could
have a configuration that doesn't even boot if it has too many cpus,
probably thousand of them (I doubt any system like that exists, it's
only a theoretical issue). But the closer you get to the non-booting
system, the more likely allocations will fail with oom due the
reservation.

especially order > 0 allocations will fail way very soon, but for those
dropping the reservation won't help, so they're an unfixable thing,
that asks to use the per-cpu resources as efficiently as possible.
