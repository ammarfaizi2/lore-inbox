Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278769AbRJ3Xmc>; Tue, 30 Oct 2001 18:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278771AbRJ3XmX>; Tue, 30 Oct 2001 18:42:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18960 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278769AbRJ3XmJ>; Tue, 30 Oct 2001 18:42:09 -0500
Date: Tue, 30 Oct 2001 15:40:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, <andrea@suse.de>
Subject: Re: pre5 VM livelock
In-Reply-To: <3BDF1999.CAF5D101@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0110301527521.1188-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More detailed look at your numbers..

On Tue, 30 Oct 2001, Jeff Garzik wrote:
>
> free pages: 2560 kb (0kb highmem)

Ok, the above is just the "pages_low" for your machine, it refuses to use
them except for atomic allocations and such (which is why "ping" still
works).

> ( active 2422 inactive 38578 free 320 )

As mentioned, you have about 300MB of pages in the inactive list, and
about 20M in the active list.

> swap cache: add 850670  delete 850666 find 323063/440091 race 1+0
> free swap: 0kb

You obviously _do_ have a swapfile, but it's now gone. I suspect it's
clearly smaller than your RAM (you seem to have 384MB in your machine, I
have no idea what your swap size is)

> 49074 pages of ram
> 786 free pages

The free page calculation is wrong, as it doesn't understand about
multi-page allocations. You really only have 320 free pages (see above),
but because there are multi-page allocations the low-level stuff thinks
the later pages are free.

> 1299 reserved pages
> 2683 pages shared

The "shared" count is the number of pages with page_count() > 1
(actually, the sum of the page_counts), so it's likely that these are the
mapped pages that are shared due to fork(). Notably it's a much smaller
number than your "inactive pages", which implies that the inactive pages
mostly have a count of 1. Whcih is consistent with them being dirty
and mapped, but nonfreeable due to being out of swap-space.

> 4 pages swap cached

That's basically zero, you probably have a few pages on the active list
that were swapped in and haven't been thrown away (or the livelock is
continually throwing them away and re-loading them).

> 4 pages in page table cache
> buffer memory: 168kb

That's 21 pages of buffer cache, most likely pinned by the filesystem
(ext2 will pin down a number of buffers just to keep track of bitmaps
etc).

In short, everything is very consistent with a out-of-memory condition.
We'll need to tweak the oom killer to just kill whatever offending process
it is that uses everything up.

I just want confirmation that you actually did something that could result
in this, ie you were testing big processes?

		Linus

