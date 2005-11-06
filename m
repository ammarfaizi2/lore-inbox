Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVKFIXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVKFIXc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVKFIXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:23:32 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:4963 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932323AbVKFIXa (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:23:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=LqfzQQS1JQhJVPlEUQJvY27ULaN53GzxNCSddqRhkJ7MORn0EA8vYkE6WWHclsqLfoG329dgM0IJLcpl42q8OSusJPqxEwLRUz/XfZemMCTBLi/4V0y5LTMHAM/K1TNYOFaei8TPrWCklq85WxgMZm2Z9AnAWXxp2o2+NMk1+Bc=  ;
Message-ID: <436DBE03.90009@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:25:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch 9/14] mm: page_state opt
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au> <436DBD31.8060801@yahoo.com.au> <436DBD82.2070500@yahoo.com.au> <436DBDA9.2040908@yahoo.com.au> <436DBDC8.5090308@yahoo.com.au> <436DBDE5.2010405@yahoo.com.au>
In-Reply-To: <436DBDE5.2010405@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------060201040109090108090205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060201040109090108090205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

9/14

-- 
SUSE Labs, Novell Inc.


--------------060201040109090108090205
Content-Type: text/plain;
 name="mm-page_state-opt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-page_state-opt.patch"

Optimise page_state manipulations by introducing a direct accessor
to page_state fields without disabling interrupts, in which case
the callers must provide their own locking (either disable interrupts
or not update from interrupt context).

Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -138,6 +138,7 @@ extern void get_page_state_node(struct p
 extern void get_full_page_state(struct page_state *ret);
 extern unsigned long __read_page_state(unsigned long offset);
 extern void __mod_page_state(unsigned long offset, unsigned long delta);
+extern unsigned long *__page_state(unsigned long offset);
 
 #define read_page_state(member) \
 	__read_page_state(offsetof(struct page_state, member))
@@ -150,16 +151,26 @@ extern void __mod_page_state(unsigned lo
 #define add_page_state(member,delta) mod_page_state(member, (delta))
 #define sub_page_state(member,delta) mod_page_state(member, 0UL - (delta))
 
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
+#define page_state_zone(zone, member)					\
+	(*__page_state(state_zone_offset(zone, member)))
+
+#define mod_page_state_zone(zone, member, delta)			\
+	do {								\
+		__mod_page_state(state_zone_offset(zone, member), (delta)); \
 	} while (0)
 
 /*
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -400,8 +400,6 @@ void __free_pages_ok(struct page *page, 
 
 	arch_free_page(page, order);
 
-	mod_page_state(pgfree, 1 << order);
-
 #ifndef CONFIG_MMU
 	if (order > 0)
 		for (i = 1 ; i < (1 << order) ; ++i)
@@ -413,6 +411,7 @@ void __free_pages_ok(struct page *page, 
 	list_add(&page->lru, &list);
 	kernel_map_pages(page, 1<<order, 0);
 	local_irq_save(flags);
+	page_state(pgfree) += 1 << order;
 	free_pages_bulk(page_zone(page), 1, &list, order);
 	local_irq_restore(flags);
 }
@@ -662,12 +661,12 @@ static void fastcall free_hot_cold_page(
 	arch_free_page(page, 0);
 
 	kernel_map_pages(page, 1, 0);
-	inc_page_state(pgfree);
 	if (PageAnon(page))
 		page->mapping = NULL;
 	free_pages_check(page);
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 	local_irq_save(flags);
+	page_state(pgfree)++;
 	list_add(&page->lru, &pcp->list);
 	pcp->count++;
 	if (pcp->count >= pcp->high)
@@ -704,42 +703,50 @@ static struct page *
 buffered_rmqueue(struct zone *zone, int order, gfp_t gfp_flags)
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
+	page_state_zone(zone, pgalloc) += 1 << order;
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
 
 /*
@@ -1215,6 +1222,15 @@ unsigned long __read_page_state(unsigned
 	return ret;
 }
 
+unsigned long *__page_state(unsigned long offset)
+{
+	void* ptr;
+	ptr = &__get_cpu_var(page_states);
+	return (unsigned long*)(ptr + offset);
+}
+
+EXPORT_SYMBOL(__page_state);
+
 void __mod_page_state(unsigned long offset, unsigned long delta)
 {
 	unsigned long flags;
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
+			page_state_zone(zone, pgscan_kswapd) += nr_scan;
+			page_state(kswapd_steal) += nr_freed;
+		} else
+			page_state_zone(zone, pgscan_direct) += nr_scan;
+		page_state_zone(zone, pgsteal) += nr_freed;
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
+	page_state_zone(zone, pgrefill) += pgscanned;
+	page_state(pgdeactivate) += pgdeactivate;
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
@@ -456,7 +456,11 @@ static void __page_set_anon_rmap(struct 
 
 	page->index = linear_page_index(vma, address);
 
-	inc_page_state(nr_mapped);
+	/*
+	 * nr_mapped state can be updated without turning off
+	 * interrupts because it is not modified via interrupt.
+	 */
+	page_state(nr_mapped)++;
 }
 
 /**
@@ -503,7 +507,7 @@ void page_add_file_rmap(struct page *pag
 	BUG_ON(!pfn_valid(page_to_pfn(page)));
 
 	if (atomic_inc_and_test(&page->_mapcount))
-		inc_page_state(nr_mapped);
+		page_state(nr_mapped)++;
 }
 
 /**
@@ -535,7 +539,7 @@ void page_remove_rmap(struct page *page)
 	 * Leaving it set also helps swapoff to reinstate ptes
 	 * faster for those pages still in swapcache.
 	 */
-	dec_page_state(nr_mapped);
+	page_state(nr_mapped)--;
 }
 
 /*

--------------060201040109090108090205--
Send instant messages to your online friends http://au.messenger.yahoo.com 
