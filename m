Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262588AbREZEWr>; Sat, 26 May 2001 00:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262589AbREZEW1>; Sat, 26 May 2001 00:22:27 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:42507 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262588AbREZEWJ>; Sat, 26 May 2001 00:22:09 -0400
Date: Fri, 25 May 2001 21:22:05 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526051156.S9634@athlon.random>
Message-ID: <Pine.LNX.4.21.0105252107010.1520-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 May 2001, Andrea Arcangeli wrote:
>
> On Fri, May 25, 2001 at 10:49:38PM -0400, Ben LaHaise wrote:
> > Highmem.  0 free pages in ZONE_NORMAL.  Now try to allocate a buffer_head.
> 
> That's a longstanding deadlock, it was there the first time I read
> fs/buffer.c, nothing related to highmem, we have it in 2.2 too. Also
> getblk is deadlock prone in a smiliar manner.

Indeed. 

This is why we always leave a few pages free, exactly to allow nested page
allocators to steal the reserved pages that we keep around. If that
deadlocks, then that's a separate issue altogether.

If people are able to trigger the "we run out of reserved pages" behaviour
under any load, that indicates that we either have too few reserved pages
per zone, or that we have a real thinko somewhere that allows eating up
the reserves we're supposed to have.

And yes, things like spraying the box really hard with network packets can
temporarily eat up the reserves, but that's why kswapd and friends exist,
to get them back. But I could easily imagine that there are more schedule
points missing that could cause user mode to not get to run much. Andrea
fixed one, I think.

If there are more situations like this, please get a stack trace on the
deadlock (fairly easy these days with ctrl-scrolllock), and let's think
about what make for the nasty pattern in the first place instead of trying
to add more "reserved" pages.

For example, maybe we can use HIGHMEM pages more aggressively in some
places, to avoid the case where we're only freeing HIGHMEM pages and
making the non-HIGHMEM case just worse. 

For example, we used to have logic in swapout_process to _not_ swap out
zones that don't need it. We changed swapout to happen in
"page_launder()", but that logic got lost. It's entirely possible that we
should just say "don't bother writing out dirty pages that are in zones
that have no memory pressure", so that we don't use up pages from the
_precious_ zones to free pages in zones that don't need freeing.

So don't try to paper over this by making up new rules. We should think
about WHY the problem happens in the first place, not about trying to fix
it once it has happened (and see the above as an example of why it might
be happening).

But sometimes the right solution is just to have more reserves.

		Linus

