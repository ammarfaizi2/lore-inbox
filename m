Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVCGAgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVCGAgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVCGAgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:36:25 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:13232 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261581AbVCGAf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 19:35:59 -0500
Date: Mon, 7 Mar 2005 00:35:56 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/2 Prezeroing large blocks of pages during allocation
In-Reply-To: <Pine.LNX.4.58.0502281859400.8523@server.graphe.net>
Message-ID: <Pine.LNX.4.58.0503070014300.21439@skynet>
References: <20050227134316.2D0F1ECE4@skynet.csn.ul.ie>
 <Pine.LNX.4.58.0502281859400.8523@server.graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2005, Christoph Lameter wrote:

> On Sun, 27 Feb 2005, Mel Gorman wrote:
>
> > The patch also counts how many blocks of each order were zeroed. This gives
> > a rough indicator if large blocks are frequently zeroed or not.  I found
> > that order-0 are the most frequent zeroed block because of the per-cpu
> > caches. This means we rarely win with zeroing in the allocator but the
> > accounting mechanisms are still handy for the scrubber daemon.
>
> Thanks for your efforts in integrating zeroing into your patches to reduce
> fragmentation.

No problem.

> It is true that you do not win with zeroing pages in the
> allocator. However, you may avoid additional zeroing by zeroing higher
> order pages and then breaking them into lower order pages (but this will
> then lead to additional fragmentation).
>

I got around the fragmentation problem by having a userzero and kernzero
pool. I also taught rmqueue_bulk() to allocate memory in as large as
chunks as possible and break it up into appropriate sizes. This means that
when the per-cpu caches are allocating 16 pages, we can now allocate this
as one 2**4 allocation rather than 16 2**0 allocations (which is possibly
a win in general, not just the prezeroing case, but I have not measured
it).  The zeroblock counts after a stress test now look something like
this;

Zeroblock count   96968  145994  125787   75329   32553     110      11       73      26       5     175

That is a big improvement as we are not zeroing order-0 pages nearly as
often as we were. It is no longer regressing in terms of fragmentation
either which is important. I need to test the patch more but hope to post
a new version by tomorrow evening. It will also need careful reviewing to
make sure I did not miss something with the per-cpu caches.

> > This patch seriously regresses how well fragmentation is handled making it
> > perform almost as badly as the standard allocator. It is because the fallback
> > ordering for USERZERO has a tendency to clobber the reserved lists because
> > of the mix of allocation types that need to be zeroed.
>
> Having pages of multiple orders in zeroed and not zeroed state invariably
> leads to more fragmentation. I have also observed that with my patches
> under many configurations. Seems that the only solution is to
> intentionally either zero all free pages (which means you can coalesce
> them all but you are zeroing lots of pages that did not need zeroing
> after all) or you disregard the zeroed state during coalescing, either
> insure that  both are zeroed or mark the results as unzeroed... both
> solutions introduce additional overhead.
>

My approach is to ignore zero pages during free/coalescing and to treat
kernel allocations for zero pages differently to userspace allocations for
zero pages.

> My favorite solution has been so far to try to zero all
> pages from the  highest order downward but only when the system is idle
> (or there is some hardware that does zeroing for us). And maybe we better
> drop the zeroed status if a zeroed and an unzeroed page can be coalesced
> to a higher order page? However, there will still be lots of unnecessary
> zeroing.
>

When splitting, I zero the largest possible block on the assumption it
makes sense to zero larger blocks. During coalesing, I ignore the zero
state altogether as I could not think of a fast way of determining if a
page was zeroed or not.

> Since most of the request for zeroed pages are order-0 requests, we could
> do a similar thing to that M$ Windows does
> (http://www.windowsitpro.com/Articles/Index.cfm?ArticleID=3774&pg=2): Keep
> a list of zeroed order 0 pages around, only put things on that list if
> the system is truly idle and pick pages up for order 0 zeroed accesses.
>
> These zero lists would needed to be managed more like cpu hotlists and
> not like we do currently as buddy allocator freelists.
>

I went with a variation of this approach. In my latest tree, I have
pageset and pageset_zero to represent a per-CPU cache of normal pages and
of zeroed pages. I have the buddy free lists to zero pages that are only
filled when splitting up a large block of pages for a zero page
allocation.

-- 
Mel Gorman
