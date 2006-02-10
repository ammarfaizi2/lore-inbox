Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWBJF0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWBJF0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWBJF0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:26:36 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:61153 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751110AbWBJF0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:26:35 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v23
Date: Fri, 10 Feb 2006 16:26:12 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org, ck@vds.kolivas.org,
       pj@sgi.com, linux-kernel@vger.kernel.org
References: <200602101355.41421.kernel@kolivas.org> <20060209205559.409c0290.akpm@osdl.org> <43EC1E0E.6060702@yahoo.com.au>
In-Reply-To: <43EC1E0E.6060702@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101626.12824.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 16:01, Nick Piggin wrote:
> Andrew Morton wrote:
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >>Andrew Morton wrote:
> >>>Con Kolivas <kernel@kolivas.org> wrote:
> >>>>Ok I see. We don't have a way to add to the tail of that list though?
> >>>
> >>>del_page_from_lru() + (new) add_page_to_inactive_list_tail().
> >>>
> >>>>Is that
> >>>>a worthwhile addition to this (ever growing) project? That would
> >>>> definitely have an impact on the other code if not all done within
> >>>> swap_prefetch.c.. which would also be quite a large open coded
> >>>> something.
> >>>
> >>>Do both of the above in a new function in swap.c.
> >>
> >>That'll require the caller to do lru locking.
> >>
> >>I'd add an lru_cache_add_tail, use it instead of the current
> >> lru_cache_add that Con's got now, and just implement it in a simple
> >> manner, without pagevecs.
> >
> > umm, that's what I said ;)
>
> You said del_page_from_lru(), which doesn't belong in a function
> called lru_cache_add_tail.

Just so it's clear I understand, is this what you (both) had in mind?
Inline so it's not built for !CONFIG_SWAP_PREFETCH

Cheers,
Con
---
Index: linux-2.6.16-rc2-ck1/include/linux/mm_inline.h
===================================================================
--- linux-2.6.16-rc2-ck1.orig/include/linux/mm_inline.h	2006-02-04 09:55:14.000000000 +1100
+++ linux-2.6.16-rc2-ck1/include/linux/mm_inline.h	2006-02-10 16:21:20.000000000 +1100
@@ -14,6 +14,13 @@ add_page_to_inactive_list(struct zone *z
 }
 
 static inline void
+add_page_to_inactive_list_tail(struct zone *zone, struct page *page)
+{
+	list_add_tail(&page->lru, &zone->inactive_list);
+	zone->nr_inactive++;
+}
+
+static inline void
 del_page_from_active_list(struct zone *zone, struct page *page)
 {
 	list_del(&page->lru);
Index: linux-2.6.16-rc2-ck1/include/linux/swap.h
===================================================================
--- linux-2.6.16-rc2-ck1.orig/include/linux/swap.h	2006-02-10 16:16:05.000000000 +1100
+++ linux-2.6.16-rc2-ck1/include/linux/swap.h	2006-02-10 16:16:16.000000000 +1100
@@ -216,6 +216,9 @@ extern int shmem_unuse(swp_entry_t entry
 extern void swap_unplug_io_fn(struct backing_dev_info *, struct page *);
 
 #ifdef CONFIG_SWAP_PREFETCH
+/* mm/swap.c */
+extern void lru_cache_add_tail(struct page *page);
+
 /*	mm/swap_prefetch.c */
 extern int swap_prefetch;
 struct swapped_entry {
Index: linux-2.6.16-rc2-ck1/mm/swap.c
===================================================================
--- linux-2.6.16-rc2-ck1.orig/mm/swap.c	2006-02-09 21:53:37.000000000 +1100
+++ linux-2.6.16-rc2-ck1/mm/swap.c	2006-02-10 16:22:45.000000000 +1100
@@ -156,6 +156,13 @@ void fastcall lru_cache_add_active(struc
 	put_cpu_var(lru_add_active_pvecs);
 }
 
+inline void lru_cache_add_tail(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+
+	add_page_to_inactive_list_tail(zone, page);
+}
+
 static void __lru_add_drain(int cpu)
 {
 	struct pagevec *pvec = &per_cpu(lru_add_pvecs, cpu);
Index: linux-2.6.16-rc2-ck1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.16-rc2-ck1.orig/mm/swap_prefetch.c	2006-02-10 12:14:25.000000000 +1100
+++ linux-2.6.16-rc2-ck1/mm/swap_prefetch.c	2006-02-10 16:11:45.000000000 +1100
@@ -196,7 +196,7 @@ static enum trickle_return trickle_swap_
 		goto out_release;
 	}
 
-	lru_cache_add(page);
+	lru_cache_add_tail(page);
 	if (unlikely(swap_readpage(NULL, page))) {
 		ret = TRICKLE_DELAY;
 		goto out_release;
