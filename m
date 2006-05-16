Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWEPBdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWEPBdl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 21:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWEPBdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 21:33:41 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:5808 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750999AbWEPBdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 21:33:40 -0400
Date: Tue, 16 May 2006 10:34:15 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: apw@shadowen.org, akpm@osdl.org, mel@csn.ul.ie, davej@codemonkey.org.uk,
       tony.luck@intel.com, linux-kernel@vger.kernel.org, bob.picco@hp.com,
       ak@suse.de, linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6] Have ia64 use add_active_range() and
 free_area_init_nodes
Message-Id: <20060516103415.ad964bdf.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <44691D7C.5060208@yahoo.com.au>
References: <20060508141030.26912.93090.sendpatchset@skynet>
	<20060508141211.26912.48278.sendpatchset@skynet>
	<20060514203158.216a966e.akpm@osdl.org>
	<44683A09.2060404@shadowen.org>
	<44685123.7040501@yahoo.com.au>
	<446855AF.1090100@shadowen.org>
	<20060515192918.c3e2e895.kamezawa.hiroyu@jp.fujitsu.com>
	<44691D7C.5060208@yahoo.com.au>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006 10:31:56 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >But clean-up/speed-up codes vanished these checks. (I don't know when this occurs)
> >Sorry for misses these things.
> >
> 
> I think if anything they should be moved into page_is_buddy, however 
> page_to_pfn
> is expensive on some architectures, so it is something we want to be 
> able to opt
> out of if we do the correct alignment.
> 

yes. It's expensive.
I received following e-Mail from Dave Hansen in past.
==
There are some ppc64 machines which have memory laid out like this:

  0-100 MB Node0
100-200 MB Node1
200-300 MB Node0
==
I didn't imagine above (strange) configration.
So, simple range check will not work for all configration anyway.
(above example is aligned and has no problem.  Moreover, ppc uses SPARSEMEM.)

Andy's page_zone(page) == page_zone(buddy) check is good, I think.

Making alignment is a difficult problem, I think. It complecates many things.
We can avoid above check only when memory layout is ideal.

BTW, How about following patch ?
I don't want to  say "Oh, you have to re-compile your kernel with 
CONFIG_UNALIGNED_ZONE on your new machine. you are unlucky." to users.

==

Index: linux-2.6.17-rc4-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc4-mm1.orig/mm/page_alloc.c
+++ linux-2.6.17-rc4-mm1/mm/page_alloc.c
@@ -58,6 +58,7 @@ unsigned long totalhigh_pages __read_mos
 unsigned long totalreserve_pages __read_mostly;
 long nr_swap_pages;
 int percpu_pagelist_fraction;
+int unaligned_zone;
 
 static void __free_pages_ok(struct page *page, unsigned int order);
 
@@ -296,12 +297,12 @@ static inline void rmv_page_order(struct
  *
  * Assumption: *_mem_map is contigious at least up to MAX_ORDER
  */
-static inline struct page *
+static inline long *
 __page_find_buddy(struct page *page, unsigned long page_idx, unsigned int order)
 {
 	unsigned long buddy_idx = page_idx ^ (1 << order);
 
-	return page + (buddy_idx - page_idx);
+	return (buddy_idx - page_idx);
 }
 
 static inline unsigned long
@@ -310,6 +311,23 @@ __find_combined_index(unsigned long page
 	return (page_idx & ~(1 << order));
 }
 
+static inline struct page *
+buddy_in_range(struct zone *zone, struct page *page, long buddy_idx)
+{
+	unsigned long pfn;
+	struct page *buddy;
+	if (!unaligned_zone)
+		return page + buddy_idx;
+	pfn = page_to_pfn(page);
+	if (!pfn_valid(pfn + buddy_idx))
+		return NULL;
+	buddy = page + buddy_idx;
+	if (page_zone_id(page) != page_zone_id(buddy))
+		return NULL;
+	return buddy;
+}
+
+
 /*
  * This function checks whether a page is free && is the buddy
  * we can do coalesce a page and its buddy if
@@ -326,15 +344,10 @@ __find_combined_index(unsigned long page
 static inline int page_is_buddy(struct page *page, struct page *buddy,
 								int order)
 {
-#ifdef CONFIG_HOLES_IN_ZONE
+#if defined(CONFIG_HOLES_IN_ZONE)
 	if (!pfn_valid(page_to_pfn(buddy)))
 		return 0;
 #endif
-#ifdef CONFIG_UNALIGNED_ZONE_BOUNDRIES
-	if (page_zone_id(page) != page_zone_id(buddy))
-		return 0;
-#endif
-
 	if (PageBuddy(buddy) && page_order(buddy) == order) {
 		BUG_ON(page_count(buddy) != 0);
 		return 1;
@@ -383,10 +396,14 @@ static inline void __free_one_page(struc
 	zone->free_pages += order_size;
 	while (order < MAX_ORDER-1) {
 		unsigned long combined_idx;
+		long buddy_idx;
 		struct free_area *area;
 		struct page *buddy;
 
-		buddy = __page_find_buddy(page, page_idx, order);
+		buddy_idx = __page_find_buddy(page, page_idx, order);
+		buddy = buddy_in_zone(zone, page, buddy_idx);
+		if (unlikely(!buddy))
+			break;
 		if (!page_is_buddy(page, buddy, order))
 			break;		/* Move the buddy up one level. */
 
@@ -2434,10 +2451,9 @@ static void __meminit free_area_init_cor
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, realsize;
 
-		if (zone_boundary_align_pfn(zone_start_pfn) != zone_start_pfn)
-			printk(KERN_CRIT "node %d zone %s missaligned "
-				"start pfn, enable UNALIGNED_ZONE_BOUNDRIES\n",
-							nid, zone_names[j]);
+		if (zone_boundary_align_pfn(zone_start_pfn) != zone_start_pfn) {
+			unaligned_zone = 1;
+		}
 
 		size = zone_present_pages_in_node(nid, j, zones_size);
 		realsize = size - zone_absent_pages_in_node(nid, j,
Index: linux-2.6.17-rc4-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc4-mm1.orig/include/linux/mmzone.h
+++ linux-2.6.17-rc4-mm1/include/linux/mmzone.h
@@ -399,11 +399,7 @@ static inline int is_dma(struct zone *zo
 
 static inline unsigned long zone_boundary_align_pfn(unsigned long pfn)
 {
-#ifdef CONFIG_UNALIGNED_ZONE_BOUNDRIES
-	return pfn;
-#else
 	return pfn & ~((1 << MAX_ORDER) - 1);
-#endif
 }
 
 /* These two functions are used to setup the per zone pages min values */



