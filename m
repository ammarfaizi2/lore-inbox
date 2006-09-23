Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWIWAvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWIWAvW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWIWAvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:51:22 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10443 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964959AbWIWAvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:51:21 -0400
Date: Fri, 22 Sep 2006 17:51:03 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: akpm@google.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Martin Bligh <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org,
       Jesse Barnes <jesse.barnes@intel.com>
Subject: alloc_pages_range V1: Allocate memory from a specified range of
 addresses
Message-ID: <Pine.LNX.4.64.0609221744360.10692@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current ZONE_DMA scheme is limited to only a single boundary. I.e. one 
can only allocate memory under 16M or above. alloc_pages_range() allows 
one to specify what the allowed memory range is. Allocate_pages_range() 
will check the system for available zones and then perform the fastest 
allocation possible. If there is no suitable zone then it will perform a 
search through the possible zones for pages that fit the allocation 
criteria. This search is not fast but it is likely sufficient for 
supporting legacy devices and devices with issues.

It is interesting to do this since the DMA subsystem has the ability to communicate
which addresses allowable. Only the page allocator cannot satisfy request
for memory for a specific memory range. With this patch the arch specific
dma_alloc_coherent() function can be modified to call alloc_pages_range() and then
the DMA subsystem will be able to exploit all available memory that a 
DMA device that only supports 30 bits or so has. In the future we will 
likely see additional brokenness in the 40 bits range as the memory sizes 
grow. These will all be supportable with this function.

Once this mechanism is in place and if one has dealt with all relevant GFP_DMA
references (all current uses must be changed to call alloc_pages_range()!)
for an arch then one can disable ZONE_DMA and enjoy the benefits
of a single zone while still being able to use the old floppy driver should
the need arise.

- Only i386 supported.

- Reclaim when not falling back to regular allocs may not be that efficient.

- Only checked by booting it on my desktop system (i386). So far I have 
  not been able to find my old floppy drive that must be somewhere on the 
  attic or in the garage.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc7-mm1/arch/i386/kernel/pci-dma.c
===================================================================
--- linux-2.6.18-rc7-mm1.orig/arch/i386/kernel/pci-dma.c	2006-09-12 18:41:36.000000000 -0700
+++ linux-2.6.18-rc7-mm1/arch/i386/kernel/pci-dma.c	2006-09-22 16:15:54.000000000 -0700
@@ -44,10 +44,10 @@
 			return NULL;
 	}
 
-	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
-		gfp |= GFP_DMA;
-
-	ret = (void *)__get_free_pages(gfp, order);
+	ret = page_address(alloc_pages_range(0L,
+		dev ? dev->coherent_dma_mask : 16*1024*1024,
+		pcibus_to_node(dev),
+		gfp, order));
 
 	if (ret != NULL) {
 		memset(ret, 0, size);
Index: linux-2.6.18-rc7-mm1/include/linux/gfp.h
===================================================================
--- linux-2.6.18-rc7-mm1.orig/include/linux/gfp.h	2006-09-22 16:15:50.000000000 -0700
+++ linux-2.6.18-rc7-mm1/include/linux/gfp.h	2006-09-22 16:15:54.000000000 -0700
@@ -136,6 +136,9 @@
 		NODE_DATA(nid)->node_zonelists + gfp_zone(gfp_mask));
 }
 
+extern struct page *alloc_pages_range(unsigned long low, unsigned long high,
+			int node, gfp_t gfp_mask, unsigned int order);
+
 #ifdef CONFIG_NUMA
 extern struct page *alloc_pages_current(gfp_t gfp_mask, unsigned order);
 
Index: linux-2.6.18-rc7-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.18-rc7-mm1.orig/mm/page_alloc.c	2006-09-22 16:15:50.000000000 -0700
+++ linux-2.6.18-rc7-mm1/mm/page_alloc.c	2006-09-22 17:33:55.000000000 -0700
@@ -1195,9 +1195,199 @@
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
+			if (addr >= low &&
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
+/*
+ * Special allocation functions to get memory in a specified area of memory
+ * like necessary for allocations for DMA devices that are unable to address
+ * all of memory.
+ *
+ * This function attempt to fall back as much as possible to the regular allocator
+ * calls in order to avoid more expensive processing that comes with having to
+ * look through each page on the freelists to check if its suitable for the
+ * allocation.
+ */
+struct page *alloc_pages_range(unsigned long low, unsigned long high,
+			int node, gfp_t gfp_flags, unsigned int order)
+{
+	const gfp_t wait = gfp_flags & __GFP_WAIT;
+	struct page *page = NULL;
+	struct reclaim_state reclaim_state;
+	struct task_struct *p = current;
+	int do_retry;
+	int suitable_zones = 0;
+	int did_some_progress;
+	struct zonelist *zl;
+	struct zone **z;
+
+	BUG_ON(gfp_flags & __GFP_HIGHMEM);
+
+#ifdef CONFIG_ZONE_DMA
+	if (high < MAX_DMA_ADDRESS)
+		return alloc_pages(gfp_flags | __GFP_DMA, order);
+#endif
+#ifdef CONFIG_ZONE_DMA32
+	if (high < MAX_DMA32_ADDRESS)
+		return alloc_pages(gfp_flags | __GFP_DMA32, order);
+#endif
+
+	/*
+	 * This check assumes that increasing node numbers go
+	 * along with increasing addresses!
+	 */
+	if ((void *)high >= pfn_to_kaddr(max_pfn) &&
+		(void *)low <= pfn_to_kaddr(NODE_DATA(0)->node_start_pfn))
+			return alloc_pages(gfp_flags, order);
+
+	/*
+	 * We skip all the niceties of the page allocator since this is
+	 * used for device allocations that require memory from a limited
+	 * address range.
+	 */
+	might_sleep_if(wait);
+
+retry:
+	zl = NODE_DATA(node)->node_zonelists + gfp_zone(gfp_flags);
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
+		struct pglist_data *pgdat = zone->zone_pgdat;
+
+		/*
+		 * Check if the node has an address space where we
+		 * would have a chance of finding suitable memory.
+		 */
+		if ((void *)low > pfn_to_kaddr(pgdat->node_start_pfn +
+				pgdat->node_spanned_pages))
+			continue;
+
+		if ((void *)high < pfn_to_kaddr(pgdat->node_start_pfn))
+			continue;
+
+		suitable_zones++;
+		spin_lock_irqsave(&zone->lock, flags);
+		page = rmqueue_range(low, high, zone, order);
+		spin_unlock(&zone->lock);
+		if (!page) {
+			local_irq_restore(flags);
+			wakeup_kswapd(zone, order);
+			continue;
+		}
+		__count_zone_vm_events(PGALLOC, zone, 1 << order);
+		zone_statistics(zl, zone);
+		local_irq_restore(flags);
+
+		VM_BUG_ON(bad_range(zone, page));
+		if (!prep_new_page(page, order, gfp_flags)) {
+#ifdef CONFIG_PAGE_OWNER
+			if (page)
+				set_page_owner(page, order, gfp_flags);
+#endif
+			return page;
+		}
+	} while (*(++z) != NULL);
+
+	/*
+	 * If we will never be able to get memory in the desired address range
+	 * or we are not allowed to wait then give up early.
+	 */
+	if (!suitable_zones || !wait)
+		goto nopage;
+
+	/*
+	 * Synchrononous reclaim. This is a broad shot and not targeted.
+	 * What would be better is to first of all restrict the reclaim
+	 * to only the zones that we could possibly get the right memory
+	 * from and second of all it may be better to only try to reclaim
+	 * those pages in the zone that are actually within range.
+	 *
+	 * However, doing so would lead to a lot of additional code. Maybe
+	 * someone else has a bright idea on how to do this in a simple way.
+	 */
+	cond_resched();
+
+	p->flags |= PF_MEMALLOC;
+	reclaim_state.reclaimed_slab = 0;
+	p->reclaim_state = &reclaim_state;
+
+	did_some_progress = try_to_free_pages(zl->zones, gfp_flags);
+
+	p->reclaim_state = NULL;
+	p->flags &= ~PF_MEMALLOC;
+
+	cond_resched();
+
+	if (!did_some_progress)
+		goto nopage;
+
+	/*
+	 * Don't let big-order allocations loop unless the caller explicitly
+	 * requests that.  Wait for some write requests to complete then retry.
+	 *
+	 * In this implementation, __GFP_REPEAT means __GFP_NOFAIL for order
+	 * <= 3, but that may not be true in other implementations.
+	 */
+	do_retry = 0;
+	if (!(gfp_flags & __GFP_NORETRY)) {
+		if ((order <= 3) || (gfp_flags & __GFP_REPEAT))
+			do_retry = 1;
+		if (gfp_flags & __GFP_NOFAIL)
+			do_retry = 1;
+	}
+	if (do_retry) {
+		blk_congestion_wait(WRITE, HZ/50);
+		goto retry;
+	}
+
+nopage:
+	if (!(gfp_flags & __GFP_NOWARN) && printk_ratelimit()) {
+		printk(KERN_WARNING "%s: page range (%lx - %lx) allocation failure."
+			" order:%d, mode:0x%x\n",
+			p->comm, low, high, order, gfp_flags);
+		dump_stack();
+		show_mem();
+	}
+	return NULL;
+}
+
 /*
  * Common helper functions.
  */
