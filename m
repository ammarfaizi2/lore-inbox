Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVLDNfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVLDNfN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 08:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVLDNfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 08:35:13 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:30366 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932223AbVLDNfM (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 4 Dec 2005 08:35:12 -0500
Date: Sun, 4 Dec 2005 21:48:18 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH 01/16] mm: delayed page activation
Message-ID: <20051204134818.GA4305@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nikita Danilov <nikita@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
References: <20051203071444.260068000@localhost.localdomain> <20051203071609.755741000@localhost.localdomain> <17298.56560.78408.693927@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17298.56560.78408.693927@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 03:11:28PM +0300, Nikita Danilov wrote:
> Wu Fengguang writes:
>  > When a page is referenced the second time in inactive_list, mark it with
>  > PG_activate instead of moving it into active_list immediately. The actual
>  > moving work is delayed to vmscan time.
>  > 
>  > This implies two essential changes:
>  > - keeps the adjecency of pages in lru;
> 
> But this change destroys LRU ordering: at the time when shrink_list()
> inspects PG_activate bit, information about order in which
> mark_page_accessed() was called against pages is lost. E.g., suppose

Thanks.
But this order of re-access time may be pointless. In fact the original
mark_page_accessed() is doing another inversion: inversion of page lifetime.
In the word of CLOCK-Pro, a page first being re-accessed has lower
inter-reference distance, and therefore should be better protected(if ignore
possible read-ahead effects). If we move re-accessed pages immediately into
active_list, we are pushing them closer to danger of eviction.

btw, the current vmscan code clears PG_referenced flag when moving pages to
active_list. I followed the convention by doing this in the patch:

--- linux-2.6.15-rc2-mm1.orig/mm/vmscan.c
+++ linux-2.6.15-rc2-mm1/mm/vmscan.c
@@ -454,6 +454,12 @@ static int shrink_list(struct list_head
                if (PageWriteback(page))
                        goto keep_locked;

+               if (PageActivate(page)) {
+                       ClearPageActivate(page);
+                       ClearPageReferenced(page);
+                       goto activate_locked;
+               }
+
                referenced = page_referenced(page, 1, sc->priority <= 0);
                /* In active use or really unfreeable?  Activate it. */
                if (referenced && page_mapping_inuse(page))

Though I have a strong feeling that with the extra PG_activate bit, the
+                       ClearPageReferenced(page);
line should be removed. That is, let the extra reference record live through it.
The point is to smooth out the inter-reference distance. Imagine the following
situation:

-      +            -   +           +   -                   -   +              -
1                   2                   3                   4                  5
        +: reference time
        -: shrink_list time

One page have an average inter-reference distance that is smaller than the
inter-scan distance. But the distances vary a bit. Here we'd better let the
reference count accumulate, or at the 3rd shrink_list time it will be evicted.
Though it has a side effect of favoriting non-mmaped file a bit more than
before, and I was not quite sure about it.

> inactive list initially contained pages
> 
>      /* head */ (P1, P2, P3) /* tail */
> 
> all of them referenced. Then mark_page_accessed(), is called against P1,
> P2, and P3 (in that order). With the old code active list would end up 
> 
>      /* head */ (P3, P2, P1) /* tail */
> 
> which corresponds to LRU. With delayed page activation, pages are moved
> to head of the active list in the order they are analyzed by
> shrink_list(), which gives
> 
>      /* head */ (P1, P2, P3) /* tail */
> 
> on the active list, that is _inverse_ LRU order.

Thanks,
Wu
