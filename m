Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132072AbRDDT5k>; Wed, 4 Apr 2001 15:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132109AbRDDT5a>; Wed, 4 Apr 2001 15:57:30 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:61572 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S132072AbRDDT5X>; Wed, 4 Apr 2001 15:57:23 -0400
Date: Wed, 4 Apr 2001 20:06:04 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: kapish@ureach.com, linux-kernel@vger.kernel.org
Subject: Re: nfs performance at high loads
In-Reply-To: <E14ks8G-0002Uk-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0104041901220.12350-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I believe David Miller's latest zero-copy patches might help here.
  In his patch, the pull-up buffer is now allocated near the top of stack
(in the sunrpc code), so it can be a blocking allocation.
  This doesn't fix the core VM problems, but does relieve the pressure
_slightly_ on the VM (I assume, haven't tried David's patch yet).

  One of the core problems is that the VM keeps no measure of
page fragmentation in the free page pool.  The system reaches the state of
having plenty of free single pages (so kswapd and friends aren't kicked
- or if they are, they do no or little word), and very few buddied pages
(which you need for some of the NFS requests).

  Unfortunately, even with keeping a mesaure of fragmentation, and
insuring work is done when it is reached, doesn't solve the next problem.

  When a large order request comes in, the inactive_clean page list is
reaped.  As reclaim_page() simply selects the "oldest" page it can, with
no regard as to whether it will buddy (now, or 'possibily in the near
future), this list is quickly shrunk by a large order request - far too
quickly for a well behaved system.

  An NFS write request, with an 8K block size, needs an order-2 (16K) pull
up buffer (we shouldn't really be pulling the header into the same buffer
as the data - perhaps we aren't any more?).  On a well used system, an
order-2 _blocking_ allocation ends up populating the order-0 and order-1
with quite a few pages from the inactive_clean.

  This then triggers another problem. :(

  As large (non-zero) order requests are always from the NORMAL or DMA
zones, these zones tend to have a lot of free-pages (put there by the
blind reclaim_page() - well, once you can do a blocking allocation they
are, or when the fragmentation kicking is working).
  New allocations for pages for the page-cache often ignore the HIGHMEM
zone (it reaches a steady state), and so is passed over by the loop at the
head of __alloc_pages()).
  However, NORMAL and DMA zones tend to be above pages_low (due to the
reason above), and so new page-cache pages came from these zones.  On a
HIGHMEM system this leads to thrashing of the NORMAL zone, while the
HIGHMEM zone stays (relatively) quiet.
  Note: To make matters even worse under this condition, pulling pages out
of the NORMAL zone is exactly what you don't want to happen!  It would be
much better if they could be left alone for a (short) while to give them
chance to buddy - Linux (at present) doesn't care about the budding of
pages in the HIGHMEM zone (no non-zero allocations come from there).

  I was working on these problems (and some others) a few months back, and
will to return to them shortly.  Unfortunately, the changes started to
look too large for 2.4....
  Also, for NFS, the best solution now might be to give the nfsd threads a
receive buffer.  With David's patches, the pull-up occurs in the context
of a thread, making this possible.
  This doesn't solve the problem for other subsystems which do non-zero
order page allocations, but (perhaps) they have a low enough frequency not
to be of real issue.


Kapish,

  Note: Ensure you put a "sync" in your /etc/exports - the default
behaviour was "async" (not legal for a valid SpecFS run).

Mark


On Wed, 4 Apr 2001, Alan Cox wrote:

> > 	We have been seeing some problems with running nfs benchmarks
> > at very high loads and were wondering if somebody could show
> > some pointers to where the problem lies.
> > 	The system is a 2.4.0 kernel on a 6.2 Red at distribution ( so
> 
> Use 2.2.19. The 2.4 VM is currently too broken to survive high I/O benchmark
> tests without going silly
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 





