Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263225AbRFGVWl>; Thu, 7 Jun 2001 17:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263219AbRFGVWb>; Thu, 7 Jun 2001 17:22:31 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:14095 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263213AbRFGVWU>; Thu, 7 Jun 2001 17:22:20 -0400
Date: Thu, 7 Jun 2001 14:22:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>, Patrick Mochel <mochel@transmeta.com>
cc: Alan Cox <alan@redhat.com>, "David S. Miller" <davem@redhat.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>, Richard Henderson <rth@cygnus.com>,
        Kanoj Sarcar <kanoj@google.engr.sgi.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 32-bit dma memory zone
In-Reply-To: <20010607153119.H1522@suse.de>
Message-ID: <Pine.LNX.4.21.0106071402480.6604-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Jun 2001, Jens Axboe wrote:
> 
> I'd like to push this patch from the block highmem patch set, to prune
> it down and make it easier to include it later on :-)
> 
> This patch implements a new memory zone, ZONE_DMA32. It holds highmem
> pages that are below 4GB, as we can do I/O on those directly. Also if we
> do need to bounce a > 4GB page, we can use pages from this zone and not
> always resort to < 960MB pages.

Patrick Mochel has another patch that adds another zone on x86: the "low
memory" zone for the 0-1MB area, which is special for some things, notably
real mode bootstrapping (ie the SMP stuff could use it instead of the
current special-case allocations, and Pat needs it for allocating low
memory pags for suspend/resumt).

I'd like to see what these two look like together.

But even more I'd like to see a more dynamic zone setup: we already have
people talking about adding memory dynamically at run-time on some of the
server machines, which implies that we might want to add zones at a later
time, along with binding those zones to different zonelists.

This is also an issue for different architectures: some of these zones do
not make any _sense_ on other architectures. For example, what's the
difference between ZONE_HIGHMEM and ZONE_NORMAL on a sane 64-bit
architecture (right now I _think_ the 64-bit architectures actually make
ZONE_NORMAL be what we call ZONE_DMA32 on x86, because they already need
to be able to distinguish between memory that can be PCI-DMA'd to, and
memory that needs bounce-buffers. Or maybe it's ZONE_DMA that they use for
the DMA32 stuff?).

Anyway, what I'm saying is that "GFP_HIGHMEM" already traverses three
zones, and with ZONE_1M and ZONE_DMA32, you'd have a list of five of them.
Of which only _two_ would actually be meaningful on some architectures.

So should we not try to have some nicer interface like

	create_zone(&zone, offset, end);

	add_zone(&zone, zonelist);

and then we could on x86 have

	create_zone(zone+0, 0, 1M);
	create_zone(zone+1, 1M, 16M);
	create_zone(zone+2, 16M, 896M);
	create_zone(zone+3, 896M, 4G);
	create_zone(zone+4, 4G, 64G);

	.. populate the zones ..

	add_zone(zone+4, GFP_HIGHMEM);

	add_zone(zone+3, GFP_HIGHMEM);
	add_zone(zone+3, GFP_DMA32);

	add_zone(zone+2, GFP_HIGHMEM);
	add_zone(zone+2, GFP_DMA32);
	add_zone(zone+2, GFP_NORMAL);

	/* the 1M-16M zone is usable for just about everything */
	add_zone(zone+1, GFP_HIGHMEM);
	add_zone(zone+1, GFP_DMA32);
	add_zone(zone+1, GFP_NORMAL);
	add_zone(zone+1, GFP_DMA);

	/* The low 1M can be used for everything */
	add_zone(zone+0, GFP_HIGHMEM);
	add_zone(zone+0, GFP_DMA32);
	add_zone(zone+0, GFP_NORMAL);
	add_zone(zone+0, GFP_DMA);
	add_zone(zone+0, GFP_LOWMEM);

and eventually, when we get hot-plug memory, the hotplug event would be
just something like

	zone = kmalloc(sizeof(struct zone), GFP_KERNEL);
	create_zone(zone, start, end);

	.. populate it with the newly added memory ..

	/*
	 * Add it to all the appropriate zones (I suspect hotplug will
	 * only occur in high memory, but who knows? 
	 */
	add_zone(zone, GFP_HIGHMEM);
	...

(Note how this might also be part of the equation of how you add nodes
dynamically in a NuMA environment).

And see how the above would mean that something like sparc64 wouldn't need
to see five zones when it reall yonly needs two of them.

		Linus

