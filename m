Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUKCBKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUKCBKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbUKCBKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:10:24 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:25573 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261186AbUKCBKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 20:10:10 -0500
Date: Wed, 3 Nov 2004 02:09:52 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, Andrew Morton <akpm@digeo.com>,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <20041103010952.GA3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random> <20041102022122.GJ3571@dualathlon.random> <11900000.1099410137@[10.10.2.4]> <20041102130910.3e779d32.akpm@osdl.org> <20041102215651.GU3571@dualathlon.random> <235610000.1099435275@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <235610000.1099435275@flay>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 02:41:15PM -0800, Martin J. Bligh wrote:
> eh? I don't see how that matters at all. After the DMA transfer, all the 
> cache lines will have to be invalidated in every CPUs cache anyway, so
> it's guaranteed to be stone-dead zero-degrees-kelvin cold. I don't see how
> however hot it becomes afterwards is relevant? 

if the cold page becomes hot, it means the hot pages in the hot
quicklist will become colder. The cache size is limited, so if something
becomes hot, something will become cold.

The only difference is that the hot pages will become cold during the
dma if we return an hot page, or the hot pages will become cold while
the cpu touches the data of the previously cold page, if we return a
cold page. Or are you worried that the cache snooping is measurable?

I believe the hot-cold thing, is mostly important for the hot
allocations not for the cold one. So that the hot allocations are served
in a strict LIFO order, that truly matters but the cold allocations are
a grey area.

What kind of slowdown can you measure if you drop __GFP_COLD enterely?

Don't get me wrong, __GFP_COLD makes perfect sense since it's so little
cost to do it that it most certainly worth the branch in the
allocator, but I don't think the hot pages worth a _reservation_ since
they'll become cold anwyays after the I/O has completed, so then we
could have returned an hot page in the first place without slowing down
in the buddy to get it.

> If the DMA is to pages that are hot in the CPUs cache - it's WORSE ... we
> have more work to do in terms of cacheline invalidates. Mmm ... in terms
> of DMAs, we're talking about disk reads (ie a new page allocates) - we're
> both on the same page there, right?

the DMA snoops the cache for the cacheline invalidate but I didn't think
it's measurable.

I would really like to see the performance difference of disabling the
__GFP_COLD thing for the allocations and to force picking from the head
of the list (and to always free the cold pages a the tail), I doubt you
will measure anything.

NOTE: I'm not talking about the freeing of cold pages. the freeing of
cold pages definitely must not free at the head, this way hot
allocations will keep going fast. But reserving hot pages during cold
allocations I doubt it's measurable. I wonder if you've any measurement
that collides with my theory. I could be wrong of course.

I can change my patch to reserve hot pages during cold allocations, no
problem, but I'd really like to have any measurement data before doing
that, since I feel I'd be wasting some tons of memory on a many-cpu
lots-of-ram box for a worthless cause.
