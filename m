Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbUDBCAq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbUDBCAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:00:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:50071
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263531AbUDBCAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:00:24 -0500
Date: Fri, 2 Apr 2004 04:00:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040402020022.GN18585@dualathlon.random>
References: <20040402001535.GG18585@dualathlon.random> <Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain> <20040402011627.GK18585@dualathlon.random> <20040401173649.22f734cd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401173649.22f734cd.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 05:36:49PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > > it isn't doing anything useful for rw_swap_page_sync, just getting you
> > > into memory allocation difficulties.  No need for add_to_page_cache or
> > > add_to_swap_cache there at all.  As I say, I haven't tested this path,
> > 
> > I wouldn't need to call add_to_page_cache either, it's just Andrew
> > prefers it.
> 
> Well all of this is to avoid a fairly arbitrary BUG_ON in the radix-tree
> code.  If I hadn't added that, we'd all be happy.
> 
> The code is well-tested and has been thrashed to death in the userspace
> radix-tree test harness.
> (http://www.zip.com.au/~akpm/linux/patches/stuff/rtth.tar.gz).  Let's
> remove the BUG_ON.

the point of the BUG_ON is not to debug the radix tree, it's to debug
the callers.

I don't like to remove the BUG_ON... it's very cool to get a BUG when
somebody tag or delete entries that are never been present in the
radix-tree. That's been useful to me so far and I like to retain that
feature since I believe it's not hurting performance at all.

I now fixed up the whole compound thing, it made no sense to keep
compound off with HUGETLBSF=N, that's a generic setup for all order > 0
not just for hugetlbfs, so it has to be enabled always or never, or it's
just asking for troubles. I can very well imagine drivers touching
page[1]->mapping and crashing with HUGETLBFS=Y and working fine with
HUGETLBFS=N, for something that has nothing to do with hugetlbfs in the
first place. At the same time the CONFIG_MMU assuming HUGETLBFS=N and
setting the count for all the secondary pages as well looks wrong, the
MMU isn't related to the page[1-N].count setting at all, the layout we
return pages via alloc_pages must be the same w/ or w/o MMU.

So I cleaned up the code and also allowed drivers to alloc multipages
not compounded, so that they can do stuff like rw_swap_page_sync on
them (doing the refcount on MMU=y too). The thing works fine here and I
can finally suspend fine. The bug is definitely fixed now. I'm checking
this in CVS so the swapsuspend people will finally be able to suspend,
and and unless anybody has objections I'll merge it in next -aa.

--- x/include/linux/gfp.h.~1~	2003-08-31 02:38:26.000000000 +0200
+++ x/include/linux/gfp.h	2004-04-02 02:49:21.241968968 +0200
@@ -32,6 +32,7 @@
 #define __GFP_NOFAIL	0x800	/* Retry for ever.  Cannot fail */
 #define __GFP_NORETRY	0x1000	/* Do not retry.  Might fail */
 #define __GFP_NO_GROW	0x2000	/* Slab internal usage */
+#define __GFP_NO_COMP	0x4000	/* Return non compound pages if order > 0 */
 
 #define __GFP_BITS_SHIFT 16	/* Room for 16 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
--- x/include/linux/mm.h.~1~	2004-04-01 18:32:55.000000000 +0200
+++ x/include/linux/mm.h	2004-04-02 03:39:40.884913464 +0200
@@ -445,8 +445,6 @@ struct page {
 
 extern void FASTCALL(__page_cache_release(struct page *));
 
-#ifdef CONFIG_HUGETLB_PAGE
-
 static inline int page_count(struct page *p)
 {
 	if (PageCompound(p))
@@ -478,23 +476,6 @@ static inline void put_page(struct page 
 		__page_cache_release(page);
 }
 
-#else		/* CONFIG_HUGETLB_PAGE */
-
-#define page_count(p)		atomic_read(&(p)->count)
-
-static inline void get_page(struct page *page)
-{
-	atomic_inc(&page->count);
-}
-
-static inline void put_page(struct page *page)
-{
-	if (!PageReserved(page) && put_page_testzero(page))
-		__page_cache_release(page);
-}
-
-#endif		/* CONFIG_HUGETLB_PAGE */
-
 /*
  * Multiple processes may "see" the same page. E.g. for untouched
  * mappings of /dev/null, all processes see the same page full of
--- x/kernel/power/pmdisk.c.~1~	2004-03-11 08:27:47.000000000 +0100
+++ x/kernel/power/pmdisk.c	2004-04-02 02:51:09.000000000 +0200
@@ -531,7 +531,7 @@ static void calc_order(void)
 static int alloc_pagedir(void)
 {
 	calc_order();
-	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, 
+	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD | __GFP_NO_COMP, 
 							     pagedir_order);
 	if(!pagedir_save)
 		return -ENOMEM;
--- x/kernel/power/swsusp.c.~1~	2004-03-11 08:27:47.000000000 +0100
+++ x/kernel/power/swsusp.c	2004-04-02 03:03:03.327992896 +0200
@@ -442,7 +442,7 @@ static suspend_pagedir_t *create_suspend
 
 	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 
-	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, pagedir_order);
+	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD | __GFP_NO_COMP, pagedir_order);
 	if(!pagedir)
 		return NULL;
 
--- x/mm/page_alloc.c.~1~	2004-04-01 18:32:54.000000000 +0200
+++ x/mm/page_alloc.c	2004-04-02 03:53:33.897276336 +0200
@@ -93,10 +93,6 @@ static void bad_page(const char *functio
 	page->mapcount = 0;
 }
 
-#ifndef CONFIG_HUGETLB_PAGE
-#define prep_compound_page(page, order) do { } while (0)
-#define destroy_compound_page(page, order) do { } while (0)
-#else
 /*
  * Higher-order pages are called "compound pages".  They are structured thusly:
  *
@@ -147,7 +143,6 @@ static void destroy_compound_page(struct
 		ClearPageCompound(p);
 	}
 }
-#endif		/* CONFIG_HUGETLB_PAGE */
 
 /*
  * Freeing function for a buddy system allocator.
@@ -178,7 +173,7 @@ static inline void __free_pages_bulk (st
 {
 	unsigned long page_idx, index;
 
-	if (order)
+	if (PageCompound(page))
 		destroy_compound_page(page, order);
 	page_idx = page - base;
 	if (page_idx & ~mask)
@@ -306,47 +301,37 @@ expand(struct zone *zone, struct page *p
 	return page;
 }
 
-static inline void set_page_refs(struct page *page, int order)
-{
-#ifdef CONFIG_MMU
-	set_page_count(page, 1);
-#else
-	int i;
-
-	/*
-	 * We need to reference all the pages for this order, otherwise if
-	 * anyone accesses one of the pages with (get/put) it will be freed.
-	 */
-	for (i = 0; i < (1 << order); i++)
-		set_page_count(page+i, 1);
-#endif /* CONFIG_MMU */
-}
-
 /*
  * This page is about to be returned from the page allocator
  */
-static void prep_new_page(struct page *page, int order)
+static void prep_new_page(struct page * _page, int order)
 {
-	if (page->mapping ||
-	    page->mapcount ||
-	    (page->flags & (
-			1 << PG_private	|
-			1 << PG_locked	|
-			1 << PG_lru	|
-			1 << PG_active	|
-			1 << PG_dirty	|
-			1 << PG_reclaim	|
-			1 << PG_anon	|
-			1 << PG_maplock	|
-			1 << PG_swapcache	|
-			1 << PG_writeback )))
-		bad_page(__FUNCTION__, page);
+	int i;
+
+	for (i = 0; i < (1 << order); i++) {
+		struct page * page = _page + i;
 
-	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
-			1 << PG_referenced | 1 << PG_arch_1 |
-			1 << PG_checked | 1 << PG_mappedtodisk);
-	page->private = 0;
-	set_page_refs(page, order);
+		if (page->mapping ||
+		    page->mapcount ||
+		    (page->flags & (
+				    1 << PG_private	|
+				    1 << PG_locked	|
+				    1 << PG_lru	|
+				    1 << PG_active	|
+				    1 << PG_dirty	|
+				    1 << PG_reclaim	|
+				    1 << PG_anon	|
+				    1 << PG_maplock	|
+				    1 << PG_swapcache	|
+				    1 << PG_writeback )))
+			bad_page(__FUNCTION__, page);
+
+		page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
+				 1 << PG_referenced | 1 << PG_arch_1 |
+				 1 << PG_checked | 1 << PG_mappedtodisk);
+		page->private = 0;
+		set_page_count(page, 1);
+	}
 }
 
 /* 
@@ -498,10 +483,11 @@ void fastcall free_cold_page(struct page
  * or two.
  */
 
-static struct page *buffered_rmqueue(struct zone *zone, int order, int cold)
+static struct page *buffered_rmqueue(struct zone *zone, int order, int cold_compound)
 {
 	unsigned long flags;
 	struct page *page = NULL;
+	int cold = !!(cold_compound & __GFP_COLD);
 
 	if (order == 0) {
 		struct per_cpu_pages *pcp;
@@ -530,7 +516,7 @@ static struct page *buffered_rmqueue(str
 		BUG_ON(bad_range(zone, page));
 		mod_page_state_zone(zone, pgalloc, 1 << order);
 		prep_new_page(page, order);
-		if (order)
+		if (unlikely(order) && !(cold_compound & __GFP_NO_COMP))
 			prep_compound_page(page, order);
 	}
 	return page;
@@ -570,7 +556,9 @@ __alloc_pages(unsigned int gfp_mask, uns
 
 	cold = 0;
 	if (gfp_mask & __GFP_COLD)
-		cold = 1;
+		cold = __GFP_COLD;
+	if (gfp_mask & __GFP_NO_COMP)
+		cold |= __GFP_NO_COMP;
 
 	zones = zonelist->zones;  /* the list of zones suitable for gfp_mask */
 	if (zones[0] == NULL)     /* no zones in the zonelist */
