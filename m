Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVCADvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVCADvm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 22:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVCADvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 22:51:42 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:20124
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S261227AbVCADvj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 22:51:39 -0500
Date: Mon, 28 Feb 2005 19:51:31 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Mel Gorman <mel@csn.ul.ie>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/2 Prezeroing large blocks of pages during allocation
In-Reply-To: <20050227134316.2D0F1ECE4@skynet.csn.ul.ie>
Message-ID: <Pine.LNX.4.58.0502281859400.8523@server.graphe.net>
References: <20050227134316.2D0F1ECE4@skynet.csn.ul.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2005, Mel Gorman wrote:

> The patch also counts how many blocks of each order were zeroed. This gives
> a rough indicator if large blocks are frequently zeroed or not.  I found
> that order-0 are the most frequent zeroed block because of the per-cpu
> caches. This means we rarely win with zeroing in the allocator but the
> accounting mechanisms are still handy for the scrubber daemon.

Thanks for your efforts in integrating zeroing into your patches to reduce
fragmentation. It is true that you do not win with zeroing pages in the
allocator. However, you may avoid additional zeroing by zeroing higher
order pages and then breaking them into lower order pages (but this will
then lead to additional fragmentation).

> This patch seriously regresses how well fragmentation is handled making it
> perform almost as badly as the standard allocator. It is because the fallback
> ordering for USERZERO has a tendency to clobber the reserved lists because
> of the mix of allocation types that need to be zeroed.

Having pages of multiple orders in zeroed and not zeroed state invariably
leads to more fragmentation. I have also observed that with my patches
under many configurations. Seems that the only solution is to
intentionally either zero all free pages (which means you can coalesce
them all but you are zeroing lots of pages that did not need zeroing
after all) or you disregard the zeroed state during coalescing, either
insure that  both are zeroed or mark the results as unzeroed... both
solutions introduce additional overhead.

My favorite solution has been so far to try to zero all
pages from the  highest order downward but only when the system is idle
(or there is some hardware that does zeroing for us). And maybe we better
drop the zeroed status if a zeroed and an unzeroed page can be coalesced
to a higher order page? However, there will still be lots of unnecessary
zeroing.

Since most of the request for zeroed pages are order-0 requests, we could
do a similar thing to that M$ Windows does
(http://www.windowsitpro.com/Articles/Index.cfm?ArticleID=3774&pg=2): Keep
a list of zeroed order 0 pages around, only put things on that list if
the system is truly idle and pick pages up for order 0 zeroed accesses.

These zero lists would needed to be managed more like cpu hotlists and
not like we do currently as buddy allocator freelists.
