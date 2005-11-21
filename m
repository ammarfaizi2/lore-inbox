Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVKUMHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVKUMHD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 07:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVKUMHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 07:07:01 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:45965 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932277AbVKUMHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 07:07:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=zw7PQo5yrmBfFXS81V3oCq37MOaATD2waupHDcwSMKpiJv18l65E/DMEI2O1u9tCvMAK+UviW4WOsWb/vjdRHBZ3laqbkkZuIZrtE6zNLM4/3LIgiS68lKZPZVTLYzsETm4olIFw+XQKO18HlPR4ziwygGjrmIvXkg6aDFyQqfE=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051121124235.14370.92215.sendpatchset@didi.local0.net>
In-Reply-To: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
Subject: [patch 9/12] mm: page_state opt
Date: Mon, 21 Nov 2005 07:07:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Optimise page_state manipulations by introducing interrupt unsafe accessors
to page_state fields. Callers must provide their own locking (either disable
interrupts or not update from interrupt context).

Switch over the hot callsites that can easily be moved under interrupts
off sections.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -136,31 +136,52 @@ struct page_state {
 extern void get_page_state(struct page_state *ret);
 extern void get_page_state_node(struct page_state *ret, int node);
 extern void get_full_page_state(struct page_state *ret);
-extern unsigned long __read_page_state(unsigned long offset);
-extern void __mod_page_state(unsigned long offset, unsigned long delta);
+extern unsigned long read_page_state_offset(unsigned long offset);
+extern void mod_page_state_offset(unsigned long offset, unsigned long delta);
+extern void __mod_page_state_offset(unsigned long offset, unsigned long delta);
 
 #define read_page_state(member) \
-	__read_page_state(offsetof(struct page_state, member))
+	read_page_state_offset(offsetof(struct page_state, member))
 
 #define mod_page_state(member, delta)	\
-	__mod_page_state(offsetof(struct page_state, member), (delta))
+	mod_page_state_offset(offsetof(struct page_state, member), (delta))
 
-#define inc_page_state(member)	mod_page_state(member, 1UL)
-#define dec_page_state(member)	mod_page_state(member, 0UL - 1)
-#define add_page_state(member,delta) mod_page_state(member, (delta))
-#define sub_page_state(member,delta) mod_page_state(member, 0UL - (delta))
-
-#define mod_page_state_zone(zone, member, delta)				\
-	do {									\
-		unsigned offset;						\
-		if (is_highmem(zone))						\
-			offset = offsetof(struct page_state, member##_high);	\
-		else if (is_normal(zone))					\
-			offset = offsetof(struct page_state, member##_normal);	\
-		else								\
-			offset = offsetof(struct page_state, member##_dma);	\
-		__mod_page_state(offset, (delta));				\
-	} while (0)
+#define __mod_page_state(member, delta)	\
+	__mod_page_state_offset(offsetof(struct page_state, member), (delta))
+
+#define inc_page_state(member)		mod_page_state(member, 1UL)
+#define dec_page_state(member)		mod_page_state(member, 0UL - 1)
+#define add_page_state(member,delta)	mod_page_state(member, (delta))
+#define sub_page_state(member,delta)	mod_page_state(member, 0UL - (delta))
+
+#define __inc_page_state(member)	__mod_page_state(member, 1UL)
+#define __dec_page_state(member)	__mod_page_state(member, 0UL - 1)
+#define __add_page_state(member,delta)	__mod_page_state(member, (delta))
+#define __sub_page_state(member,delta)	__mod_page_state(member, 0UL - (delta))
+
+#define page_state(member) (*__page_state(offsetof(struct page_state, member)))
+
+#define state_zone_offset(zone, member)					\
+({									\
+	unsigned offset;						\
+	if (is_highmem(zone))						\
+		offset = offsetof(struct page_state, member##_high);	\
+	else if (is_normal(zone))					\
+		offset = offsetof(struct page_state, member##_normal);	\
+	else								\
+		offset = offsetof(struct page_state, member##_dma);	\
+	offset;								\
+})
+
+#define __mod_page_state_zone(zone, member, delta)			\
+ do {									\
+	__mod_page_state_offset(state_zone_offset(zone, member), (delta)); \
+ } while (0)
+
+#define mod_page_state_zone(zone, member, delta)			\
+ do {									\
+	mod_page_state_offset(state_zone_offset(zone, member), (delta)); \
+ } while (0)
 
 /*
  * Manipulation of page state flags
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -407,8 +407,6 @@ void __free_pages_ok(struct page *page, 
 
 	arch_free_page(page, order);
 
-	mod_page_state(pgfree, 1 << order);
-
 #ifndef CONFIG_MMU
 	if (order > 0)
 		for (i = 1 ; i < (1 << order) ; ++i)
@@ -420,6 +418,7 @@ void __free_pages_ok(struct page *page, 
 	list_add(&page->lru, &list);
 	kernel_map_pages(page, 1<<order, 0);
 	local_irq_save(flags);
+	__mod_page_state(pgfree, 1 << order);
 	free_pages_bulk(page_zone(page), 1, &list, order);
 	local_irq_restore(flags);
 }
@@ -630,18 +629,14 @@ void drain_local_pages(void)
 }
 #endif /* CONFIG_PM */
 
-static void zone_statistics(struct zonelist *zonelist, struct zone *z)
+static void zone_statistics(struct zonelist *zonelist, struct zone *z, int cpu)
 {
 #ifdef CONFIG_NUMA
-	unsigned long flags;
-	int cpu;
 	pg_data_t *pg = z->zone_pgdat;
 	pg_data_t *orig = zonelist->zones[0]->zone_pgdat;
 	struct per_cpu_pageset *p;
 
-	local_irq_save(flags);
-	cpu = smp_processor_id();
-	p = zone_pcp(z,cpu);
+	p = zone_pcp(z, cpu);
 	if (pg == orig) {
 		p->numa_hit++;
 	} else {
@@ -652,7 +647,6 @@ static void zone_statistics(struct zonel
 		p->local_node++;
 	else
 		p->other_node++;
-	local_irq_restore(flags);
 #endif
 }
 
@@ -669,12 +663,12 @@ static void fastcall free_hot_cold_page(
 	arch_free_page(page, 0);
 
 	kernel_map_pages(page, 1, 0);
-	inc_page_state(pgfree);
 	if (PageAnon(page))
 		page->mapping = NULL;
 	free_pages_check(page);
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 	local_irq_save(flags);
+	__inc_page_state(pgfree);
 	list_add(&page->lru, &pcp->list);
 	pcp->count++;
 	if (pcp->count >= pcp->high)
@@ -707,46 +701,55 @@ static inline void prep_zero_page(struct
  * we cheat by calling it from here, in the order > 0 path.  Saves a branch
  * or two.
  */
-static struct page *
-buffered_rmqueue(struct zone *zone, int order, gfp_t gfp_flags)
+static struct page *buffered_rmqueue(struct zonelist *zonelist,
+			struct zone *zone, int order, gfp_t gfp_flags)
 {
 	unsigned long flags;
-	struct page *page = NULL;
+	struct page *page;
 	int cold = !!(gfp_flags & __GFP_COLD);
+	int cpu = get_cpu();
 
 	if (order == 0) {
 		struct per_cpu_pages *pcp;
 
-		pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
+		pcp = &zone_pcp(zone, cpu)->pcp[cold];
 		local_irq_save(flags);
-		if (!pcp->count)
+		if (!pcp->count) {
 			pcp->count += rmqueue_bulk(zone, 0,
 						pcp->batch, &pcp->list);
-		if (likely(pcp->count)) {
-			page = list_entry(pcp->list.next, struct page, lru);
-			list_del(&page->lru);
-			pcp->count--;
+			if (unlikely(!pcp->count))
+				goto failed;
 		}
-		local_irq_restore(flags);
-		put_cpu();
+		page = list_entry(pcp->list.next, struct page, lru);
+		list_del(&page->lru);
+		pcp->count--;
 	} else {
 		spin_lock_irqsave(&zone->lock, flags);
 		page = __rmqueue(zone, order);
-		spin_unlock_irqrestore(&zone->lock, flags);
+		spin_unlock(&zone->lock);
+		if (!page)
+			goto failed;
 	}
 
-	if (page != NULL) {
-		BUG_ON(bad_range(zone, page));
-		mod_page_state_zone(zone, pgalloc, 1 << order);
-		prep_new_page(page, order);
+	__mod_page_state_zone(zone, pgalloc, 1 << order);
+	zone_statistics(zonelist, zone, cpu);
+	local_irq_restore(flags);
+	put_cpu();
 
-		if (gfp_flags & __GFP_ZERO)
-			prep_zero_page(page, order, gfp_flags);
+	BUG_ON(bad_range(zone, page));
+	prep_new_page(page, order);
 
-		if (order && (gfp_flags & __GFP_COMP))
-			prep_compound_page(page, order);
-	}
+	if (gfp_flags & __GFP_ZERO)
+		prep_zero_page(page, order, gfp_flags);
+
+	if (order && (gfp_flags & __GFP_COMP))
+		prep_compound_page(page, order);
 	return page;
+
+failed:
+	local_irq_restore(flags);
+	put_cpu();
+	return NULL;
 }
 
 #define ALLOC_NO_WATERMARKS	0x01 /* don't check watermarks at all */
@@ -812,9 +815,8 @@ get_page_from_freelist(gfp_t gfp_mask, u
 				continue;
 		}
 
-		page = buffered_rmqueue(*z, order, gfp_mask);
+		page = buffered_rmqueue(zonelist, *z, order, gfp_mask);
 		if (page) {
-			zone_statistics(zonelist, *z);
 			break;
 		}
 	} while (*(++z) != NULL);
@@ -1191,7 +1193,7 @@ void get_full_page_state(struct page_sta
 	__get_page_state(ret, sizeof(*ret) / sizeof(unsigned long), &mask);
 }
 
-unsigned long __read_page_state(unsigned long offset)
+unsigned long read_page_state_offset(unsigned long offset)
 {
 	unsigned long ret = 0;
 	int cpu;
@@ -1205,18 +1207,26 @@ unsigned long __read_page_state(unsigned
 	return ret;
 }
 
-void __mod_page_state(unsigned long offset, unsigned long delta)
+void __mod_page_state_offset(unsigned long offset, unsigned long delta)
+{
+	void *ptr;
+
+	ptr = &__get_cpu_var(page_states);
+	*(unsigned long *)(ptr + offset) += delta;
+}
+EXPORT_SYMBOL(__mod_page_state_offset);
+
+void mod_page_state_offset(unsigned long offset, unsigned long delta)
 {
 	unsigned long flags;
-	void* ptr;
+	void *ptr;
 
-	local_irq_save(flags);
 	ptr = &__get_cpu_var(page_states);
-	*(unsigned long*)(ptr + offset) += delta;
+	local_irq_save(flags);
+	*(unsigned long *)(ptr + offset) += delta;
 	local_irq_restore(flags);
 }
-
-EXPORT_SYMBOL(__mod_page_state);
+EXPORT_SYMBOL(mod_page_state_offset);
 
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free, struct pglist_data *pgdat)
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -641,17 +641,18 @@ static void shrink_cache(struct zone *zo
 			goto done;
 
 		max_scan -= nr_scan;
-		if (current_is_kswapd())
-			mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
-		else
-			mod_page_state_zone(zone, pgscan_direct, nr_scan);
 		nr_freed = shrink_list(&page_list, sc);
-		if (current_is_kswapd())
-			mod_page_state(kswapd_steal, nr_freed);
-		mod_page_state_zone(zone, pgsteal, nr_freed);
 		sc->nr_to_reclaim -= nr_freed;
 
-		spin_lock_irq(&zone->lru_lock);
+		local_irq_disable();
+		if (current_is_kswapd()) {
+			__mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
+			__mod_page_state(kswapd_steal, nr_freed);
+		} else
+			__mod_page_state_zone(zone, pgscan_direct, nr_scan);
+		__mod_page_state_zone(zone, pgsteal, nr_freed);
+
+		spin_lock(&zone->lru_lock);
 		/*
 		 * Put back any unfreeable pages.
 		 */
@@ -813,11 +814,13 @@ refill_inactive_zone(struct zone *zone, 
 		}
 	}
 	zone->nr_active += pgmoved;
-	spin_unlock_irq(&zone->lru_lock);
-	pagevec_release(&pvec);
+	spin_unlock(&zone->lru_lock);
+
+	__mod_page_state_zone(zone, pgrefill, pgscanned);
+	__mod_page_state(pgdeactivate, pgdeactivate);
+	local_irq_enable();
 
-	mod_page_state_zone(zone, pgrefill, pgscanned);
-	mod_page_state(pgdeactivate, pgdeactivate);
+	pagevec_release(&pvec);
 }
 
 /*
Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c
+++ linux-2.6/mm/rmap.c
@@ -459,7 +459,11 @@ void page_add_anon_rmap(struct page *pag
 
 		page->index = linear_page_index(vma, address);
 
-		inc_page_state(nr_mapped);
+		/*
+		 * nr_mapped state can be updated without turning off
+		 * interrupts because it is not modified via interrupt.
+		 */
+		__inc_page_state(nr_mapped);
 	}
 	/* else checking page index and mapping is racy */
 }
@@ -476,7 +480,7 @@ void page_add_file_rmap(struct page *pag
 	BUG_ON(!pfn_valid(page_to_pfn(page)));
 
 	if (atomic_inc_and_test(&page->_mapcount))
-		inc_page_state(nr_mapped);
+		__inc_page_state(nr_mapped);
 }
 
 /**
@@ -500,7 +504,7 @@ void page_remove_rmap(struct page *page)
 		 */
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
-		dec_page_state(nr_mapped);
+		__dec_page_state(nr_mapped);
 	}
 }
 
Send instant messages to your online friends http://au.messenger.yahoo.com 
