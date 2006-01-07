Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWAGAb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWAGAb0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbWAGAbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:31:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59623 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932296AbWAGAbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:31:21 -0500
Date: Fri, 6 Jan 2006 16:33:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] use local_t for page statistics
Message-Id: <20060106163313.38c08e37.akpm@osdl.org>
In-Reply-To: <20060106215332.GH8979@kvack.org>
References: <20060106215332.GH8979@kvack.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> wrote:
>
> The patch below converts the mm page_states counters to use local_t.  
> mod_page_state shows up in a few profiles on x86 and x86-64 due to the 
> disable/enable interrupts operations touching the flags register.  On 
> both my laptop (Pentium M) and P4 test box this results in about 10 
> additional /bin/bash -c exit 0 executions per second (P4 went from ~759/s 
> to ~771/s).  Tested on x86 and x86-64.  Oh, also add a pgcow statistic 
> for the number of COW page faults.

Bah.  I think this is a better approach than the just-merged
mm-page_state-opt.patch, so I should revert that patch first?


From: Nick Piggin <nickpiggin@yahoo.com.au>

Optimise page_state manipulations by introducing interrupt unsafe accessors
to page_state fields.  Callers must provide their own locking (either
disable interrupts or not update from interrupt context).

Switch over the hot callsites that can easily be moved under interrupts off
sections.

Signed-off-by: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/page-flags.h |   43 ++++++++++++----
 mm/page_alloc.c            |   89 +++++++++++++++++++----------------
 mm/rmap.c                  |   10 ++-
 mm/vmscan.c                |   27 +++++-----
 4 files changed, 104 insertions(+), 65 deletions(-)

diff -puN include/linux/page-flags.h~mm-page_state-opt include/linux/page-flags.h
--- devel/include/linux/page-flags.h~mm-page_state-opt	2006-01-06 00:04:15.000000000 -0800
+++ devel-akpm/include/linux/page-flags.h	2006-01-06 00:06:48.000000000 -0800
@@ -144,22 +144,33 @@ struct page_state {
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
+#define __mod_page_state(member, delta)	\
+	__mod_page_state_offset(offsetof(struct page_state, member), (delta))
 
-#define mod_page_state_zone(zone, member, delta)			\
- do {									\
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
 	unsigned offset;						\
 	if (is_highmem(zone))						\
 		offset = offsetof(struct page_state, member##_high);	\
@@ -169,7 +180,17 @@ extern void __mod_page_state(unsigned lo
 		offset = offsetof(struct page_state, member##_dma32);	\
 	else								\
 		offset = offsetof(struct page_state, member##_dma);	\
-	__mod_page_state(offset, (delta));				\
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
  } while (0)
 
 /*
diff -puN mm/page_alloc.c~mm-page_state-opt mm/page_alloc.c
--- devel/mm/page_alloc.c~mm-page_state-opt	2006-01-06 00:04:15.000000000 -0800
+++ devel-akpm/mm/page_alloc.c	2006-01-06 00:04:54.000000000 -0800
@@ -424,9 +424,9 @@ void __free_pages_ok(struct page *page, 
 		return;
 
 	list_add(&page->lru, &list);
-	mod_page_state(pgfree, 1 << order);
 	kernel_map_pages(page, 1<<order, 0);
 	local_irq_save(flags);
+	__mod_page_state(pgfree, 1 << order);
 	free_pages_bulk(page_zone(page), 1, &list, order);
 	local_irq_restore(flags);
 }
@@ -674,18 +674,14 @@ void drain_local_pages(void)
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
@@ -696,7 +692,6 @@ static void zone_statistics(struct zonel
 		p->local_node++;
 	else
 		p->other_node++;
-	local_irq_restore(flags);
 #endif
 }
 
@@ -716,11 +711,11 @@ static void fastcall free_hot_cold_page(
 	if (free_pages_check(page))
 		return;
 
-	inc_page_state(pgfree);
 	kernel_map_pages(page, 1, 0);
 
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 	local_irq_save(flags);
+	__inc_page_state(pgfree);
 	list_add(&page->lru, &pcp->list);
 	pcp->count++;
 	if (pcp->count >= pcp->high)
@@ -753,49 +748,58 @@ static inline void prep_zero_page(struct
  * we cheat by calling it from here, in the order > 0 path.  Saves a branch
  * or two.
  */
-static struct page *
-buffered_rmqueue(struct zone *zone, int order, gfp_t gfp_flags)
+static struct page *buffered_rmqueue(struct zonelist *zonelist,
+			struct zone *zone, int order, gfp_t gfp_flags)
 {
 	unsigned long flags;
 	struct page *page;
 	int cold = !!(gfp_flags & __GFP_COLD);
+	int cpu;
 
 again:
+	cpu  = get_cpu();
 	if (order == 0) {
 		struct per_cpu_pages *pcp;
 
-		page = NULL;
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
-		if (prep_new_page(page, order))
-			goto again;
+	__mod_page_state_zone(zone, pgalloc, 1 << order);
+	zone_statistics(zonelist, zone, cpu);
+	local_irq_restore(flags);
+	put_cpu();
 
-		if (gfp_flags & __GFP_ZERO)
-			prep_zero_page(page, order, gfp_flags);
+	BUG_ON(bad_range(zone, page));
+	if (prep_new_page(page, order))
+		goto again;
 
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
@@ -871,9 +875,8 @@ get_page_from_freelist(gfp_t gfp_mask, u
 				continue;
 		}
 
-		page = buffered_rmqueue(*z, order, gfp_mask);
+		page = buffered_rmqueue(zonelist, *z, order, gfp_mask);
 		if (page) {
-			zone_statistics(zonelist, *z);
 			break;
 		}
 	} while (*(++z) != NULL);
@@ -1249,7 +1252,7 @@ void get_full_page_state(struct page_sta
 	__get_page_state(ret, sizeof(*ret) / sizeof(unsigned long), &mask);
 }
 
-unsigned long __read_page_state(unsigned long offset)
+unsigned long read_page_state_offset(unsigned long offset)
 {
 	unsigned long ret = 0;
 	int cpu;
@@ -1263,18 +1266,26 @@ unsigned long __read_page_state(unsigned
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
 
 	local_irq_save(flags);
 	ptr = &__get_cpu_var(page_states);
-	*(unsigned long*)(ptr + offset) += delta;
+	*(unsigned long *)(ptr + offset) += delta;
 	local_irq_restore(flags);
 }
-
-EXPORT_SYMBOL(__mod_page_state);
+EXPORT_SYMBOL(mod_page_state_offset);
 
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free, struct pglist_data *pgdat)
diff -puN mm/rmap.c~mm-page_state-opt mm/rmap.c
--- devel/mm/rmap.c~mm-page_state-opt	2006-01-06 00:04:15.000000000 -0800
+++ devel-akpm/mm/rmap.c	2006-01-06 00:04:15.000000000 -0800
@@ -451,7 +451,11 @@ static void __page_set_anon_rmap(struct 
 
 	page->index = linear_page_index(vma, address);
 
-	inc_page_state(nr_mapped);
+	/*
+	 * nr_mapped state can be updated without turning off
+	 * interrupts because it is not modified via interrupt.
+	 */
+	__inc_page_state(nr_mapped);
 }
 
 /**
@@ -498,7 +502,7 @@ void page_add_file_rmap(struct page *pag
 	BUG_ON(!pfn_valid(page_to_pfn(page)));
 
 	if (atomic_inc_and_test(&page->_mapcount))
-		inc_page_state(nr_mapped);
+		__inc_page_state(nr_mapped);
 }
 
 /**
@@ -522,7 +526,7 @@ void page_remove_rmap(struct page *page)
 		 */
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
-		dec_page_state(nr_mapped);
+		__dec_page_state(nr_mapped);
 	}
 }
 
diff -puN mm/vmscan.c~mm-page_state-opt mm/vmscan.c
--- devel/mm/vmscan.c~mm-page_state-opt	2006-01-06 00:04:15.000000000 -0800
+++ devel-akpm/mm/vmscan.c	2006-01-06 00:04:15.000000000 -0800
@@ -645,16 +645,17 @@ static void shrink_cache(struct zone *zo
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
@@ -816,11 +817,13 @@ refill_inactive_zone(struct zone *zone, 
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
_

