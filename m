Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291773AbSBNQ3D>; Thu, 14 Feb 2002 11:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291774AbSBNQ2x>; Thu, 14 Feb 2002 11:28:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65291 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291773AbSBNQ2q>; Thu, 14 Feb 2002 11:28:46 -0500
Date: Thu, 14 Feb 2002 08:27:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Gerd Knorr <kraxel@bytesex.org>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>, Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>,
        Benjamin LaHaise <bcrl@redhat.com>, Dave Jones <davej@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <20020214141028.M7940@athlon.random>
Message-ID: <Pine.LNX.4.33.0202140824200.12749-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Feb 2002, Andrea Arcangeli wrote:
> >
> > I've recently changed the code to make it *not* call unmap_kiobuf/vfree
> > from irq context.  Instead bttv 0.8.x doesn't allow you to close the
> > device with DMA xfers in flight.  If you try this the release() fops
> > handler will block until the transfer is done, then unmap_kiobuf from
> > process context, then return.
>
> perfect, that's the right fix for 2.4 (waiting DMA to complete at
> ->release looks also much saner).

I think it's the right fix regardless. We should do as little as possible
from irq contexts, and that holds _doubly_ true if it mucks with things
like the page cache.

> With aio in 2.5 we may want to change this property for the unpinning
> stage that would be better run asynchronously from irq handlers, but I
> wouldn't change that for 2.4 (at least until we're forced to ship aio in
> production on top 2.4, that cannot happen until a final user<->kernel API is
> registered somewhere).

I'd really really hate to have the IO make pages go away from irq context
in 2.5.x too. I think async IO should always be started and cleaned up in
a user context - there simply isn't any reason not to (the notion of doing
an exit() or execve() with IO still pending to now-dead-memory is rather
horrible in itself).

> I think the foundamental design mistake that leads to __free_pages to
> fail from irq, is that we allow an anonymous page to reach count 0 and to be
> still in the LRU (the count == 0 check in shrink_cache is the other side
> of the hack too). That's the real BUG, that breaks subtly the freelist
> semantics

Agreed. We should NEVER free the pages from the irq.

		Linus

