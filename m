Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291618AbSBNNK7>; Thu, 14 Feb 2002 08:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291619AbSBNNKt>; Thu, 14 Feb 2002 08:10:49 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32848 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S291618AbSBNNKi>; Thu, 14 Feb 2002 08:10:38 -0500
Date: Thu, 14 Feb 2002 14:10:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <akpm@zip.com.au>, Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>,
        Benjamin LaHaise <bcrl@redhat.com>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
Message-ID: <20020214141028.M7940@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0202131652050.20915-100000@freak.distro.conectiva> <Pine.LNX.4.21.0202141045250.1722-100000@localhost.localdomain> <20020214121037.A6194@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020214121037.A6194@bytesex.org>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 12:10:37PM +0100, Gerd Knorr wrote:
> > However: that is the only unambiguous example I've seen, and you
> > may argue that his bttv 0.8 driver is not in the current 2.4 tree,
> > is experimental, and even wrong in that area (we now know it also
> > vfrees there).
> 
> I've recently changed the code to make it *not* call unmap_kiobuf/vfree
> from irq context.  Instead bttv 0.8.x doesn't allow you to close the
> device with DMA xfers in flight.  If you try this the release() fops
> handler will block until the transfer is done, then unmap_kiobuf from
> process context, then return.

perfect, that's the right fix for 2.4 (waiting DMA to complete at
->release looks also much saner). unmap_kiobuf wasn't supposed to be run
from irq handlers. Everything dealing with userspace mappings cannot run
from irq handlers, tlb flushes, VM, swapping etc...  everything must run
from normal kernel context. If you obey this rule, my previous email to
this thread will still apply. I wasn't aware of bttv running
unmap_kiobuf from irq.

With aio in 2.5 we may want to change this property for the unpinning
stage that would be better run asynchronously from irq handlers, but I
wouldn't change that for 2.4 (at least until we're forced to ship aio in
production on top 2.4, that cannot happen until a final user<->kernel API is
registered somewhere).

I think the foundamental design mistake that leads to __free_pages to
fail from irq, is that we allow an anonymous page to reach count 0 and to be
still in the LRU (the count == 0 check in shrink_cache is the other side
of the hack too). That's the real BUG, that breaks subtly the freelist
semantics, and then we need to make horrible hacks like last Hugh's
patch to work around such magic case (or even worse Rik's proposal for a
spin_lock_irqed list that would hurt in all the vm fast paths). As far
as clean design and orthogonality of subsystem is concerned, the right
fix for 2.5 is to bump the page->count by the time the anonymous page is
added to the lru (think and guess why we're doing that for the
pagecache, and why the pagecache is obviously safe even for aio and
unmap_kiobuf from irq).  Then we need to keep it into account during
COWs (page count == 2 for an anonymous page will mean "exclusive")
etc... the MM will need to be changed a little more heavily than with
the hack approch, but I think that's the clean design in the long run.
No special cases for those magic anonymous pages, everything goes in
pagecache, with the difference the anonymous pages aren't hashed (until
they becomes swapcache at least). The semantics of __free_pages will
remain that if you own a page you can __free_pages it anytime you want
without running into BUGS(). If the page also owned by some other
subsystem (the VM), such subsystem will need to take care of bumping the
refernece count and to free the page later lazily. No collisions.

As said this should be a matter only for 2.5, now that Gerd recalls
unmap_kiobuf from normal kernel context.

Andrea
