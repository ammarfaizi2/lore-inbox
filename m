Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTLXNKT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 08:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbTLXNKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 08:10:19 -0500
Received: from holomorphy.com ([199.26.172.102]:9383 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263600AbTLXNJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 08:09:52 -0500
Date: Wed, 24 Dec 2003 05:09:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-mm1
Message-ID: <20031224130942.GL22443@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031222211131.70a963fb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222211131.70a963fb.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 09:11:31PM -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test11/2.6.0-mm1/
> Quite a lot of new material here.  It would be appreciated if people who have
> significant patches in -mm could retest please.

ptecache refresh. Includes the shrink_slab() and smp_local_irq_*
suggestions as well as a fix for IPI recursion found while running
hackbench on -wli, moving the "don't shrink lowmem slabs if gfp_mask
wants highmem" logic into the shrinkers themselves, and converting
shrink_pagetable_cache() to use on_each_cpu().

How's this look?


-- wli


diff -prauN mm1-2.6.0-1/arch/i386/mm/init.c mm1-2.6.0-2/arch/i386/mm/init.c
--- mm1-2.6.0-1/arch/i386/mm/init.c	2003-12-24 04:02:51.000000000 -0800
+++ mm1-2.6.0-2/arch/i386/mm/init.c	2003-12-24 04:06:34.000000000 -0800
@@ -465,7 +465,7 @@ void __init mem_init(void)
 
 	/* this will put all low memory onto the freelists */
 	totalram_pages += __free_all_bootmem();
-
+	tlb_init();
 	reservedpages = 0;
 	for (tmp = 0; tmp < max_low_pfn; tmp++)
 		/*
diff -prauN mm1-2.6.0-1/arch/i386/mm/pgtable.c mm1-2.6.0-2/arch/i386/mm/pgtable.c
--- mm1-2.6.0-1/arch/i386/mm/pgtable.c	2003-12-24 04:02:51.000000000 -0800
+++ mm1-2.6.0-2/arch/i386/mm/pgtable.c	2003-12-24 04:40:50.000000000 -0800
@@ -1,5 +1,6 @@
 /*
  *  linux/arch/i386/mm/pgtable.c
+ *  highpte-compatible pte caching, William Irwin, IBM, June 2003
  */
 
 #include <linux/config.h>
@@ -13,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -139,18 +141,70 @@ pte_t *pte_alloc_one_kernel(struct mm_st
 	return pte;
 }
 
-struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+void tlb_init(void)
 {
-	struct page *pte;
+	int cpu;
+	for (cpu = 0; cpu < NR_CPUS; ++cpu) {
+		int zone;
+		struct mmu_gather *tlb = &per_cpu(mmu_gathers, cpu);
+		for (zone = 0; zone < MAX_ZONE_ID; ++zone) {
+			INIT_LIST_HEAD(&tlb->active_list[zone]);
+			INIT_LIST_HEAD(&tlb->ready_list[zone]);
+		}
+	}
+}
 
-#ifdef CONFIG_HIGHPTE
-	pte = alloc_pages(GFP_KERNEL|__GFP_HIGHMEM|__GFP_REPEAT, 0);
-#else
-	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
-#endif
-	if (pte)
-		clear_highpage(pte);
-	return pte;
+static inline struct page *pte_alloc_fresh(int gfp_mask)
+{
+	struct page *page = alloc_page(gfp_mask);
+	if (page) {
+		clear_highpage(page);
+		if (TestSetPagePTE(page))
+			BUG();
+	}
+	return page;
+}
+
+static inline int zone_high(struct zone *zone)
+{
+	if (!zone)
+		return 1;
+	else
+		return zone - zone->zone_pgdat->node_zones >= ZONE_HIGHMEM;
+}
+
+static inline struct page *pte_alloc_ready(int gfp_flags)
+{
+	struct mmu_gather *tlb = &per_cpu(mmu_gathers, get_cpu());
+	unsigned long flags;
+	struct page *page = NULL;
+
+	local_irq_save(flags);
+	if (tlb->nr_pte_ready) {
+		int z;
+		for (z = MAX_ZONE_ID - 1; z >= 0; --z) {
+			struct zone *zone = zone_table[z];
+			if (!(gfp_flags & __GFP_HIGHMEM) && zone_high(zone))
+				continue;
+			if (!list_empty(&tlb->ready_list[z]))
+				break;
+		}
+		page = list_entry(tlb->ready_list[z].next, struct page, list);
+		if (TestSetPagePTE(page))
+			BUG();
+		list_del(&page->list);
+		tlb->ready_count[z]--;
+		tlb->nr_pte_ready--;
+	}
+	local_irq_restore(flags);
+	put_cpu();
+	return page;
+}
+
+struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	struct page *page = pte_alloc_ready(GFP_PTE);
+	return page ? page : pte_alloc_fresh(GFP_PTE);
 }
 
 void pmd_ctor(void *pmd, kmem_cache_t *cache, unsigned long flags)
@@ -320,3 +374,45 @@ out_free:
 	kmem_cache_free(pgd_cache, pgd);
 }
 
+static void shrink_cpu_pagetable_cache(void *__gfp_mask)
+{
+	int zone, high, gfp_mask = (int)__gfp_mask;
+	unsigned long flags;
+	struct mmu_gather *tlb = &per_cpu(mmu_gathers, get_cpu());
+
+	high = !!(gfp_mask & __GFP_HIGHMEM);
+	local_irq_save(flags);
+	if (!tlb->nr_pte_ready)
+		goto out;
+
+	for (zone = 0; zone < MAX_ZONE_ID; ++zone) {
+		if (list_empty(&tlb->ready_list[zone]))
+			continue;
+		if (!high && zone_high(zone_table[zone]))
+			continue;
+
+		free_pages_bulk(zone_table[zone],
+				tlb->ready_count[zone],
+				&tlb->ready_list[zone],
+				0);
+		tlb->nr_pte_ready -= tlb->ready_count[zone];
+		tlb->ready_count[zone] = 0;
+	}
+out:
+	local_irq_restore(flags);
+	put_cpu();
+}
+
+static int shrink_pagetable_cache(int nr_to_scan, unsigned int gfp_mask)
+{
+	on_each_cpu(shrink_cpu_pagetable_cache, (void *)gfp_mask, 1, 1);
+	return 1;
+}
+
+static __init int init_pagetable_cache_shrinker(void)
+{
+	set_shrinker(1, shrink_pagetable_cache);
+	return 0;
+}
+
+__initcall(init_pagetable_cache_shrinker);
diff -prauN mm1-2.6.0-1/fs/dcache.c mm1-2.6.0-2/fs/dcache.c
--- mm1-2.6.0-1/fs/dcache.c	2003-12-24 04:02:53.000000000 -0800
+++ mm1-2.6.0-2/fs/dcache.c	2003-12-24 04:15:28.000000000 -0800
@@ -642,6 +642,9 @@ void shrink_dcache_anon(struct hlist_hea
  */
 static int shrink_dcache_memory(int nr, unsigned int gfp_mask)
 {
+	if (gfp_mask & __GFP_HIGHMEM)
+		return 0;
+
 	if (nr) {
 		/*
 		 * Nasty deadlock avoidance.
diff -prauN mm1-2.6.0-1/fs/dquot.c mm1-2.6.0-2/fs/dquot.c
--- mm1-2.6.0-1/fs/dquot.c	2003-12-24 04:02:53.000000000 -0800
+++ mm1-2.6.0-2/fs/dquot.c	2003-12-24 04:15:47.000000000 -0800
@@ -391,6 +391,9 @@ static int shrink_dqcache_memory(int nr,
 {
 	int ret;
 
+	if (gfp_mask & __GFP_HIGHMEM)
+		return 0;
+
 	spin_lock(&dq_list_lock);
 	if (nr)
 		prune_dqcache(nr);
diff -prauN mm1-2.6.0-1/fs/inode.c mm1-2.6.0-2/fs/inode.c
--- mm1-2.6.0-1/fs/inode.c	2003-12-24 04:02:53.000000000 -0800
+++ mm1-2.6.0-2/fs/inode.c	2003-12-24 04:16:14.000000000 -0800
@@ -468,6 +468,9 @@ static void prune_icache(int nr_to_scan)
  */
 static int shrink_icache_memory(int nr, unsigned int gfp_mask)
 {
+	if (gfp_mask & __GFP_HIGHMEM)
+		return 0;
+
 	if (nr) {
 		/*
 		 * Nasty deadlock avoidance.  We may hold various FS locks,
diff -prauN mm1-2.6.0-1/fs/mbcache.c mm1-2.6.0-2/fs/mbcache.c
--- mm1-2.6.0-1/fs/mbcache.c	2003-12-17 18:59:53.000000000 -0800
+++ mm1-2.6.0-2/fs/mbcache.c	2003-12-24 04:16:50.000000000 -0800
@@ -176,6 +176,9 @@ mb_cache_shrink_fn(int nr_to_scan, unsig
 	struct list_head *l, *ltmp;
 	int count = 0;
 
+	if (gfp_mask & __GFP_HIGHMEM)
+		return 0;
+
 	spin_lock(&mb_cache_spinlock);
 	list_for_each(l, &mb_cache_list) {
 		struct mb_cache *cache =
diff -prauN mm1-2.6.0-1/fs/xfs/quota/xfs_qm.c mm1-2.6.0-2/fs/xfs/quota/xfs_qm.c
--- mm1-2.6.0-1/fs/xfs/quota/xfs_qm.c	2003-12-17 18:58:05.000000000 -0800
+++ mm1-2.6.0-2/fs/xfs/quota/xfs_qm.c	2003-12-24 04:17:50.000000000 -0800
@@ -2208,6 +2208,8 @@ xfs_qm_shake(int nr_to_scan, unsigned in
 
 	if (!(gfp_mask & __GFP_WAIT))
 		return 0;
+	if (gfp_mask & __GFP_HIGHMEM)
+		return 0;
 	if (!xfs_Gqm)
 		return 0;
 
diff -prauN mm1-2.6.0-1/include/asm-i386/pgalloc.h mm1-2.6.0-2/include/asm-i386/pgalloc.h
--- mm1-2.6.0-1/include/asm-i386/pgalloc.h	2003-12-17 18:58:07.000000000 -0800
+++ mm1-2.6.0-2/include/asm-i386/pgalloc.h	2003-12-24 04:06:34.000000000 -0800
@@ -31,14 +31,6 @@ static inline void pte_free_kernel(pte_t
 	free_page((unsigned long)pte);
 }
 
-static inline void pte_free(struct page *pte)
-{
-	__free_page(pte);
-}
-
-
-#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
-
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
  * inside the pgd, so has no extra memory associated with it.
@@ -47,9 +39,26 @@ static inline void pte_free(struct page 
 
 #define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *)2); })
 #define pmd_free(x)			do { } while (0)
-#define __pmd_free_tlb(tlb,x)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)	BUG()
 
 #define check_pgt_cache()	do { } while (0)
 
+#include <asm/tlb.h>
+
+static inline void pte_free(struct page *page)
+{
+	struct mmu_gather *tlb = &per_cpu(mmu_gathers, get_cpu());
+	tlb_remove_page(tlb, page);
+	put_cpu();
+}
+
+static inline void pte_free_tlb(struct mmu_gather *tlb, struct page *page)
+{
+	tlb_remove_page(tlb, page);
+}
+
+static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
+{
+}
+
 #endif /* _I386_PGALLOC_H */
diff -prauN mm1-2.6.0-1/include/asm-i386/tlb.h mm1-2.6.0-2/include/asm-i386/tlb.h
--- mm1-2.6.0-1/include/asm-i386/tlb.h	2003-12-17 18:58:38.000000000 -0800
+++ mm1-2.6.0-2/include/asm-i386/tlb.h	2003-12-24 04:41:00.000000000 -0800
@@ -1,10 +1,52 @@
 #ifndef _I386_TLB_H
 #define _I386_TLB_H
+/*
+ * include/asm-i386/tlb.h
+ * (C) June 2003 William Irwin, IBM
+ * Routines for pagetable caching and release.
+ */
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/gfp.h>
+#include <linux/list.h>
+#include <linux/percpu.h>
+#include <asm/tlbflush.h>
+
+#ifdef CONFIG_HIGHPTE
+#define GFP_PTE			(GFP_KERNEL|__GFP_REPEAT|__GFP_HIGHMEM)
+#else
+#define GFP_PTE			(GFP_KERNEL|__GFP_REPEAT)
+#endif
+
+#define	PG_PTE			PG_arch_1
+#define NR_PTE			128
+#define FREE_PTE_NR		NR_PTE
+#define NR_NONPTE		512
+#define MAX_ZONE_ID		(MAX_NUMNODES * MAX_NR_ZONES)
+
+#define PagePTE(page)		test_bit(PG_PTE, &(page)->flags)
+#define SetPagePTE(page)	set_bit(PG_PTE, &(page)->flags)
+#define ClearPagePTE(page)	clear_bit(PG_PTE, &(page)->flags)
+#define TestSetPagePTE(page)	test_and_set_bit(PG_PTE, &(page)->flags)
+#define TestClearPagePTE(page)	test_and_clear_bit(PG_PTE, &(page)->flags)
+#define PageZoneID(page)	((page)->flags >> ZONE_SHIFT)
 
 /*
- * x86 doesn't need any special per-pte or
- * per-vma handling..
+ * vmscan.c does smp_call_function() to shoot down cached pagetables under
+ * memory pressure.
  */
+struct mmu_gather {
+	struct mm_struct *mm;
+	int nr_pte_active, nr_pte_ready, nr_nonpte, need_flush, fullmm, freed;
+	struct list_head active_list[MAX_ZONE_ID], ready_list[MAX_ZONE_ID];
+	int active_count[MAX_ZONE_ID], ready_count[MAX_ZONE_ID];
+	struct page *nonpte[NR_NONPTE];
+};
+
+DECLARE_PER_CPU(struct mmu_gather, mmu_gathers);
+
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
 #define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
@@ -15,6 +57,119 @@
  */
 #define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
 
-#include <asm-generic/tlb.h>
+void tlb_init(void);
 
-#endif
+static inline
+struct mmu_gather *tlb_gather_mmu(struct mm_struct *mm, unsigned int flush)
+{
+	struct mmu_gather *tlb = &per_cpu(mmu_gathers, get_cpu());
+	tlb->mm = mm;
+	tlb->fullmm = flush;
+	tlb->freed = 0;
+	put_cpu();
+	return tlb;
+}
+
+static inline
+void tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *pte, unsigned long addr)
+{
+	tlb->need_flush = 1;
+}
+
+static inline
+void tlb_flush_ready(struct mmu_gather *tlb)
+{
+	int zone;
+
+	for (zone = 0; tlb->nr_pte_ready >= NR_PTE && zone < MAX_ZONE_ID; ++zone) {
+		if (!tlb->ready_count[zone])
+			continue;
+
+		free_pages_bulk(zone_table[zone],
+				tlb->ready_count[zone],
+				&tlb->ready_list[zone],
+				0);
+		tlb->nr_pte_ready -= tlb->ready_count[zone];
+		tlb->ready_count[zone] = 0;
+	}
+}
+
+static inline
+void tlb_flush_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
+{
+	int zone;
+	unsigned long flags;
+
+	if (!tlb->need_flush && tlb->nr_nonpte < NR_NONPTE)
+		return;
+
+	tlb->need_flush = 0;
+	tlb_flush(tlb);
+
+	local_irq_save(flags);
+
+	if (tlb->nr_nonpte) {
+		free_pages_and_swap_cache(tlb->nonpte, tlb->nr_nonpte);
+		tlb->nr_nonpte = 0;
+	}
+
+	for (zone = 0; zone < MAX_ZONE_ID; ++zone) {
+		if (!tlb->active_count[zone])
+			continue;
+
+		list_splice_init(&tlb->active_list[zone], &tlb->ready_list[zone]);
+		tlb->ready_count[zone] += tlb->active_count[zone];
+		tlb->active_count[zone] = 0;
+	}
+	tlb->nr_pte_ready += tlb->nr_pte_active;
+	tlb->nr_pte_active = 0;
+	if (tlb->nr_pte_ready >= NR_PTE)
+		tlb_flush_ready(tlb);
+
+	local_irq_restore(flags);
+}
+
+static inline
+void tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
+{
+	if (tlb->mm->rss >= tlb->freed)
+		tlb->mm->rss -= tlb->freed;
+	else
+		tlb->mm->rss = 0;
+	tlb_flush_mmu(tlb, start, end);
+}
+
+static inline
+void tlb_remove_nonpte_page(struct mmu_gather *tlb, struct page *page)
+{
+	tlb->nonpte[tlb->nr_nonpte] = page;
+	tlb->nr_nonpte++;
+	if (tlb->nr_nonpte >= NR_NONPTE)
+		tlb_flush_mmu(tlb, 0, 0);
+}
+
+static inline
+void tlb_remove_pte_page(struct mmu_gather *tlb, struct page *page)
+{
+	int zone = PageZoneID(page);
+	ClearPagePTE(page);
+	tlb->nr_pte_active++;
+	tlb->active_count[zone]++;
+	list_add(&page->list, &tlb->active_list[zone]);
+}
+
+static inline
+void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	tlb->need_flush = 1;
+	if (PagePTE(page))
+		tlb_remove_pte_page(tlb, page);
+	else
+		tlb_remove_nonpte_page(tlb, page);
+	local_irq_restore(flags);
+}
+
+#endif /* _I386_TLB_H */
diff -prauN mm1-2.6.0-1/include/linux/gfp.h mm1-2.6.0-2/include/linux/gfp.h
--- mm1-2.6.0-1/include/linux/gfp.h	2003-12-17 18:58:28.000000000 -0800
+++ mm1-2.6.0-2/include/linux/gfp.h	2003-12-24 04:06:34.000000000 -0800
@@ -79,6 +79,7 @@ static inline struct page * alloc_pages_
 
 extern unsigned long FASTCALL(__get_free_pages(unsigned int gfp_mask, unsigned int order));
 extern unsigned long FASTCALL(get_zeroed_page(unsigned int gfp_mask));
+int free_pages_bulk(struct zone *zone, int count, struct list_head *list, unsigned int order);
 
 #define __get_free_page(gfp_mask) \
 		__get_free_pages((gfp_mask),0)
diff -prauN mm1-2.6.0-1/mm/page_alloc.c mm1-2.6.0-2/mm/page_alloc.c
--- mm1-2.6.0-1/mm/page_alloc.c	2003-12-24 04:02:53.000000000 -0800
+++ mm1-2.6.0-2/mm/page_alloc.c	2003-12-24 04:06:34.000000000 -0800
@@ -238,8 +238,7 @@ static inline void free_pages_check(cons
  * And clear the zone's pages_scanned counter, to hold off the "all pages are
  * pinned" detection logic.
  */
-static int
-free_pages_bulk(struct zone *zone, int count,
+int free_pages_bulk(struct zone *zone, int count,
 		struct list_head *list, unsigned int order)
 {
 	unsigned long mask, flags;
diff -prauN mm1-2.6.0-1/mm/vmscan.c mm1-2.6.0-2/mm/vmscan.c
--- mm1-2.6.0-1/mm/vmscan.c	2003-12-24 04:02:53.000000000 -0800
+++ mm1-2.6.0-2/mm/vmscan.c	2003-12-24 04:24:29.000000000 -0800
@@ -891,12 +891,10 @@ int try_to_free_pages(struct zone **zone
 
 		/* Take a nap, wait for some writeback to complete */
 		blk_congestion_wait(WRITE, HZ/10);
-		if (zones[0] - zones[0]->zone_pgdat->node_zones < ZONE_HIGHMEM) {
-			shrink_slab(total_scanned, gfp_mask);
-			if (reclaim_state) {
-				nr_reclaimed += reclaim_state->reclaimed_slab;
-				reclaim_state->reclaimed_slab = 0;
-			}
+		shrink_slab(total_scanned, gfp_mask);
+		if (reclaim_state) {
+			nr_reclaimed += reclaim_state->reclaimed_slab;
+			reclaim_state->reclaimed_slab = 0;
 		}
 	}
 	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
@@ -968,11 +966,12 @@ static int balance_pgdat(pg_data_t *pgda
 				max_scan = SWAP_CLUSTER_MAX;
 			to_free -= shrink_zone(zone, max_scan, GFP_KERNEL,
 					to_reclaim, &nr_mapped, ps, priority);
-			if (i < ZONE_HIGHMEM) {
-				reclaim_state->reclaimed_slab = 0;
+			reclaim_state->reclaimed_slab = 0;
+			if (i < ZONE_HIGHMEM)
 				shrink_slab(max_scan + nr_mapped, GFP_KERNEL);
-				to_free -= reclaim_state->reclaimed_slab;
-			}
+			else
+				shrink_slab(max_scan + nr_mapped, GFP_HIGHUSER);
+			to_free -= reclaim_state->reclaimed_slab;
 			if (zone->all_unreclaimable)
 				continue;
 			if (zone->pages_scanned > zone->present_pages * 2)
