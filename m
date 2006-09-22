Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWIVUXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWIVUXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWIVUXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:23:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59878 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964891AbWIVUXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:23:53 -0400
Date: Fri, 22 Sep 2006 13:23:35 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Martin Bligh <mbligh@mbligh.org>
cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@google.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
Subject: Re: [RFC] Initial alpha-0 for new page allocator API
In-Reply-To: <4514441E.70207@mbligh.org>
Message-ID: <Pine.LNX.4.64.0609221321280.9181@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com>
 <200609222110.25118.ak@suse.de> <1158955850.24572.37.camel@localhost.localdomain>
 <200609222202.41692.ak@suse.de> <4514441E.70207@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an iniitial patch of alloc_pages_range (untested, compiles). 
Directed reclaim missing. Feedback wanted. There are some comments in the 
patch where I am at the boundary of my knowledge and it would be good if 
someone could supply the info needed.

Index: linux-2.6.18-rc7-mm1/arch/i386/kernel/pci-dma.c
===================================================================
--- linux-2.6.18-rc7-mm1.orig/arch/i386/kernel/pci-dma.c	2006-09-22 15:10:42.246731179 -0500
+++ linux-2.6.18-rc7-mm1/arch/i386/kernel/pci-dma.c	2006-09-22 15:11:10.449709078 -0500
@@ -26,6 +26,8 @@ void *dma_alloc_coherent(struct device *
 			   dma_addr_t *dma_handle, gfp_t gfp)
 {
 	void *ret;
+	unsigned long low = 0L;
+	unsigned long high = 0xffffffff;
 	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
 	int order = get_order(size);
 	/* ignore region specifiers */
@@ -44,10 +46,14 @@ void *dma_alloc_coherent(struct device *
 			return NULL;
 	}
 
-	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
-		gfp |= GFP_DMA;
+	if (dev == NULL)
+		/* Apply safe ISA LIMITS */
+		high = 16*1024*1024L;
+	else
+	if (dev->coherent_dma_mask < 0xffffffff)
+		high = dev->coherent_dma_mask;
 
-	ret = (void *)__get_free_pages(gfp, order);
+	ret = page_address(alloc_pages_range(low, high, gfp, order));
 
 	if (ret != NULL) {
 		memset(ret, 0, size);
Index: linux-2.6.18-rc7-mm1/include/linux/gfp.h
===================================================================
--- linux-2.6.18-rc7-mm1.orig/include/linux/gfp.h	2006-09-22 15:10:42.235994626 -0500
+++ linux-2.6.18-rc7-mm1/include/linux/gfp.h	2006-09-22 15:11:10.462397735 -0500
@@ -136,6 +136,9 @@ static inline struct page *alloc_pages_n
 		NODE_DATA(nid)->node_zonelists + gfp_zone(gfp_mask));
 }
 
+extern struct page *alloc_pages_range(unsigned long low, unsigned long high,
+			int nid, gfp_t gfp_mask, unsigned int order);
+
 #ifdef CONFIG_NUMA
 extern struct page *alloc_pages_current(gfp_t gfp_mask, unsigned order);
 
Index: linux-2.6.18-rc7-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.18-rc7-mm1.orig/mm/page_alloc.c	2006-09-22 15:10:53.973976539 -0500
+++ linux-2.6.18-rc7-mm1/mm/page_alloc.c	2006-09-22 15:19:59.996440889 -0500
@@ -1195,9 +1195,119 @@ got_pg:
 #endif
 	return page;
 }
-
 EXPORT_SYMBOL(__alloc_pages);
 
+static struct page *rmqueue_range(unsigned long low, unsigned long high,
+				struct zone *zone, unsigned int order)
+{
+	struct free_area * area;
+	unsigned int current_order;
+	struct page *page;
+
+	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
+		area = zone->free_area + current_order;
+		if (list_empty(&area->free_list))
+			continue;
+
+		list_for_each_entry(page, &area->free_list, lru) {
+			unsigned long addr = (unsigned long)page_address(page);
+
+			if (addr >= low ||
+				addr < high - (PAGE_SIZE << order))
+					goto found_match;
+		}
+		continue;
+found_match:
+		list_del(&page->lru);
+		rmv_page_order(page);
+		area->nr_free--;
+		zone->free_pages -= 1UL << order;
+		expand(zone, page, order, current_order, area);
+		return page;
+	}
+	return NULL;
+}
+
+struct page *alloc_pages_range(unsigned long low, unsigned long high, int node,
+						gfp_t gfp_flags, unsigned int order)
+{
+	const gfp_t wait = gfp_flags & __GFP_WAIT;
+	struct zonelist *zl;
+	struct zone **z;
+	struct page *page;
+
+#ifdef CONFIG_ZONE_DMA
+	if (high < MAX_DMA_ADDRESS)
+		return alloc_pages(gfp_flags | __GFP_DMA, order);
+#endif
+#ifdef CONFIG_ZONE_DMA32
+	if (high < MAX_DMA32_ADDRESS)
+		return alloc_pages(gfp_flags | __GFP_DMA32, order);
+#endif
+	/*
+	 * Is there an upper/lower limit of installed memory that we could
+	 * check against instead of -1 ? The less memory installed the less
+	 * the chance that we would have to do the expensive range search.
+	 */
+	if (high == -1L && low == 0L)
+		return alloc_pages(gfp_flags, order);
+
+	if (node == -1)
+		node = numa_node_id();
+
+	/*
+	 * Scan in the page allocator for memory.
+	 * We skip all the niceties of the page allocator since this is
+	 * used for device allocations that require memory from a limited
+	 * address range.
+	 */
+
+	might_sleep_if(wait);
+
+	zl = &NODE_DATA(node)->node_zonelists[gfp_zone(gfp_flags)];
+
+	z = zl->zones;
+
+	if (unlikely(*z == NULL))
+		/* Should this ever happen?? */
+		return NULL;
+
+	do {
+		struct zone *zone = *z;
+		unsigned long flags;
+
+		spin_lock_irqsave(&zone->lock, flags);
+		page = rmqueue_range(low, high, zone, order);
+		spin_unlock(&zone->lock);
+		if (!page) {
+			local_irq_restore(flags);
+			put_cpu();
+			continue;
+		}
+		__count_zone_vm_events(PGALLOC, zone, 1 << order);
+		zone_statistics(zl, zone);
+		local_irq_restore(flags);
+		put_cpu();
+
+		VM_BUG_ON(bad_range(zone, page));
+		if (!prep_new_page(page, order, gfp_flags))
+			goto got_pg;
+
+	} while (*(++z) != NULL);
+
+	/*
+	 * For now just give up. In the future we need something like
+	 * directed reclaim here.
+	 */
+	page = NULL;
+got_pg:
+#ifdef CONFIG_PAGE_OWNER
+	if (page)
+		set_page_owner(page, order, gfp_flags);
+#endif
+	return page;
+}
+
 /*
  * Common helper functions.
  */
