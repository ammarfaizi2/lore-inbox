Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263541AbTLDVBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 16:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263543AbTLDVBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 16:01:22 -0500
Received: from holomorphy.com ([199.26.172.102]:36305 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263541AbTLDVBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 16:01:04 -0500
Date: Thu, 4 Dec 2003 13:01:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-wli-1
Message-ID: <20031204210101.GZ8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031204200120.GL19856@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204200120.GL19856@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 12:01:20PM -0800, William Lee Irwin III wrote:
> was doing for them. I also need to find a coherent way to incorporate
> the cleanups for pte caching suggested by akpm without bloating the
> pte cache on lowmem boxen


Maybe the pte caching cleanups should go something like this:


diff -prauN wli-2.6.0-test11-30/arch/i386/mm/pgtable.c wli-2.6.0-test11-31/arch/i386/mm/pgtable.c
--- wli-2.6.0-test11-30/arch/i386/mm/pgtable.c	2003-12-04 07:36:00.000000000 -0800
+++ wli-2.6.0-test11-31/arch/i386/mm/pgtable.c	2003-12-04 12:57:16.000000000 -0800
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
@@ -176,7 +178,7 @@ static inline struct page *pte_alloc_rea
 	unsigned long flags;
 	struct page *page = NULL;
 
-	smp_local_irq_save(flags);
+	local_irq_save(flags);
 	if (tlb->nr_pte_ready) {
 		int z;
 		for (z = MAX_ZONE_ID - 1; z >= 0; --z) {
@@ -193,7 +195,7 @@ static inline struct page *pte_alloc_rea
 		tlb->ready_count[z]--;
 		tlb->nr_pte_ready--;
 	}
-	smp_local_irq_restore(flags);
+	local_irq_restore(flags);
 	put_cpu();
 	return page;
 }
@@ -305,7 +307,7 @@ static void shrink_cpu_pagetable_cache(v
 	high = !!(gfp_mask & __GFP_HIGHMEM);
 	cpu = get_cpu();
 	tlb = &per_cpu(mmu_gathers, cpu);
-	smp_local_irq_save(flags);
+	local_irq_save(flags);
 
 	if (tlb->nr_pte_active || tlb->nr_nonpte)
 		tlb_flush(tlb);
@@ -342,11 +344,11 @@ static void shrink_cpu_pagetable_cache(v
 		free_pages_bulk(zone_table[zone], head, 0);
 	}
 
-	smp_local_irq_restore(flags);
+	local_irq_restore(flags);
 	put_cpu();
 }
 
-void shrink_pagetable_cache(int gfp_mask)
+static int shrink_pagetable_cache(int nr_to_scan, unsigned int gfp_mask)
 {
 	BUG_ON(irqs_disabled());
 
@@ -357,8 +359,17 @@ void shrink_pagetable_cache(int gfp_mask
 
 	smp_call_function(shrink_cpu_pagetable_cache, (void *)gfp_mask, 1, 1);
 	preempt_enable();
+	return 1;
 }
 
+static __init int init_pagetable_cache_shrinker(void)
+{
+	set_shrinker(1, shrink_pagetable_cache);
+	return 0;
+}
+
+__initcall(init_pagetable_cache_shrinker);
+
 #define GLIBC_BUFFER	(32*1024*1024)
 
 /*
diff -prauN wli-2.6.0-test11-30/fs/dcache.c wli-2.6.0-test11-31/fs/dcache.c
--- wli-2.6.0-test11-30/fs/dcache.c	2003-12-04 08:30:37.000000000 -0800
+++ wli-2.6.0-test11-31/fs/dcache.c	2003-12-04 12:39:07.000000000 -0800
@@ -657,6 +657,9 @@ static int shrink_dcache_memory(int nr, 
 	int nr_unused;
 	const int unused_ratio = 1;
 
+	if (gfp_mask & __GFP_HIGHMEM)
+		return 0;
+
 	if (nr) {
 		/*
 		 * Nasty deadlock avoidance.
diff -prauN wli-2.6.0-test11-30/fs/dquot.c wli-2.6.0-test11-31/fs/dquot.c
--- wli-2.6.0-test11-30/fs/dquot.c	2003-11-26 12:44:45.000000000 -0800
+++ wli-2.6.0-test11-31/fs/dquot.c	2003-12-04 12:39:42.000000000 -0800
@@ -386,6 +386,9 @@ static int shrink_dqcache_memory(int nr,
 {
 	int ret;
 
+	if (gfp_mask & __GFP_HIGHMEM)
+		return 0;
+
 	spin_lock(&dq_list_lock);
 	if (nr)
 		prune_dqcache(nr);
diff -prauN wli-2.6.0-test11-30/fs/inode.c wli-2.6.0-test11-31/fs/inode.c
--- wli-2.6.0-test11-30/fs/inode.c	2003-12-04 08:20:27.000000000 -0800
+++ wli-2.6.0-test11-31/fs/inode.c	2003-12-04 12:41:30.000000000 -0800
@@ -467,6 +467,9 @@ static void prune_icache(int nr_to_scan)
  */
 static int shrink_icache_memory(int nr, unsigned int gfp_mask)
 {
+	if (gfp_mask & __GFP_HIGHMEM)
+		return 0;
+
 	if (nr) {
 		/*
 		 * Nasty deadlock avoidance.  We may hold various FS locks,
diff -prauN wli-2.6.0-test11-30/fs/mbcache.c wli-2.6.0-test11-31/fs/mbcache.c
--- wli-2.6.0-test11-30/fs/mbcache.c	2003-11-26 12:45:49.000000000 -0800
+++ wli-2.6.0-test11-31/fs/mbcache.c	2003-12-04 12:40:57.000000000 -0800
@@ -176,6 +176,9 @@ mb_cache_shrink_fn(int nr_to_scan, unsig
 	struct list_head *l, *ltmp;
 	int count = 0;
 
+	if (gfp_mask & __GFP_HIGHMEM)
+		return 0;
+
 	spin_lock(&mb_cache_spinlock);
 	list_for_each(l, &mb_cache_list) {
 		struct mb_cache *cache =
diff -prauN wli-2.6.0-test11-30/fs/xfs/quota/xfs_qm.c wli-2.6.0-test11-31/fs/xfs/quota/xfs_qm.c
--- wli-2.6.0-test11-30/fs/xfs/quota/xfs_qm.c	2003-11-26 12:42:54.000000000 -0800
+++ wli-2.6.0-test11-31/fs/xfs/quota/xfs_qm.c	2003-12-04 12:38:37.000000000 -0800
@@ -2206,6 +2206,8 @@ xfs_qm_shake(int nr_to_scan, unsigned in
 {
 	int	ndqused, nfree, n;
 
+	if (gfp_mask & __GFP_HIGHMEM)
+		return 0;
 	if (!(gfp_mask & __GFP_WAIT))
 		return 0;
 	if (!xfs_Gqm)
diff -prauN wli-2.6.0-test11-30/include/asm-i386/pgtable.h wli-2.6.0-test11-31/include/asm-i386/pgtable.h
--- wli-2.6.0-test11-30/include/asm-i386/pgtable.h	2003-12-04 08:30:37.000000000 -0800
+++ wli-2.6.0-test11-31/include/asm-i386/pgtable.h	2003-12-04 12:52:58.000000000 -0800
@@ -45,9 +45,6 @@ void pgd_dtor(void *, kmem_cache_t *, un
 void pgtable_cache_init(void);
 void paging_init(void);
 
-#define HAVE_ARCH_PAGETABLE_CACHE
-void shrink_pagetable_cache(int gfp_mask);
-
 #endif /* !__ASSEMBLY__ */
 
 /*
diff -prauN wli-2.6.0-test11-30/include/asm-i386/system.h wli-2.6.0-test11-31/include/asm-i386/system.h
--- wli-2.6.0-test11-30/include/asm-i386/system.h	2003-12-03 18:30:38.000000000 -0800
+++ wli-2.6.0-test11-31/include/asm-i386/system.h	2003-12-04 12:50:45.000000000 -0800
@@ -461,18 +461,6 @@ struct alt_instr { 
 /* For spinlocks etc */
 #define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
 
-#ifdef CONFIG_SMP
-#define smp_local_irq_save(x)		local_irq_save(x)
-#define smp_local_irq_restore(x)	local_irq_restore(x)
-#define smp_local_irq_disable()		local_irq_disable()
-#define smp_local_irq_enable()		local_irq_enable()
-#else
-#define smp_local_irq_save(x)		do { (void)(x); } while (0)
-#define smp_local_irq_restore(x)	do { (void)(x); } while (0)
-#define smp_local_irq_disable()		do { } while (0)
-#define smp_local_irq_enable()		do { } while (0)
-#endif /* CONFIG_SMP */
-
 /*
  * disable hlt during certain critical i/o operations
  */
diff -prauN wli-2.6.0-test11-30/include/asm-i386/tlb.h wli-2.6.0-test11-31/include/asm-i386/tlb.h
--- wli-2.6.0-test11-30/include/asm-i386/tlb.h	2003-12-03 18:30:38.000000000 -0800
+++ wli-2.6.0-test11-31/include/asm-i386/tlb.h	2003-12-04 12:50:45.000000000 -0800
@@ -115,7 +115,7 @@ void tlb_flush_mmu(struct mmu_gather *tl
 	tlb->need_flush = 0;
 	tlb_flush(tlb);
 
-	smp_local_irq_save(flags);
+	local_irq_save(flags);
 
 	if (tlb->nr_nonpte) {
 		free_pages_and_swap_cache(tlb->nonpte, tlb->nr_nonpte);
@@ -135,7 +135,7 @@ void tlb_flush_mmu(struct mmu_gather *tl
 	if (tlb->nr_pte_ready >= NR_PTE)
 		tlb_flush_ready(tlb);
 
-	smp_local_irq_restore(flags);
+	local_irq_restore(flags);
 }
 
 static inline
@@ -172,13 +172,13 @@ void tlb_remove_page(struct mmu_gather *
 {
 	unsigned long flags;
 
-	smp_local_irq_save(flags);
+	local_irq_save(flags);
 	tlb->need_flush = 1;
 	if (PagePTE(page))
 		tlb_remove_pte_page(tlb, page);
 	else
 		tlb_remove_nonpte_page(tlb, page);
-	smp_local_irq_restore(flags);
+	local_irq_restore(flags);
 }
 
 #endif /* _I386_TLB_H */
diff -prauN wli-2.6.0-test11-30/mm/vmscan.c wli-2.6.0-test11-31/mm/vmscan.c
--- wli-2.6.0-test11-30/mm/vmscan.c	2003-12-04 07:13:42.000000000 -0800
+++ wli-2.6.0-test11-31/mm/vmscan.c	2003-12-04 12:52:58.000000000 -0800
@@ -845,10 +845,6 @@ shrink_caches(struct zone *classzone, in
 	return ret;
 }
 
-#ifndef HAVE_ARCH_PAGETABLE_CACHE
-#define shrink_pagetable_cache(gfp_mask)		do { } while (0)
-#endif
- 
 /*
  * This is the main entry point to direct page reclaim.
  *
@@ -901,17 +897,12 @@ int try_to_free_pages(struct zone *cz,
 		 */
 		wakeup_bdflush(total_scanned);
 
-		/* shoot down some pagetable caches before napping */
-		shrink_pagetable_cache(gfp_mask);
-
 		/* Take a nap, wait for some writeback to complete */
 		blk_congestion_wait(WRITE, HZ/10);
-		if (cz - cz->zone_pgdat->node_zones < ZONE_HIGHMEM) {
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
@@ -958,11 +949,12 @@ static int balance_pgdat(pg_data_t *pgda
 	for (priority = DEF_PRIORITY; priority; priority--) {
 		int all_zones_ok = 1;
 
-		for (i = 0; i < pgdat->nr_zones; i++) {
+		for (i = pgdat->nr_zones - 1; i >= 0; i--) {
 			struct zone *zone = pgdat->node_zones + i;
 			int nr_mapped = 0;
 			int max_scan;
 			int to_reclaim;
+			int gfp_mask;
 
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
@@ -981,13 +973,20 @@ static int balance_pgdat(pg_data_t *pgda
 				max_scan = to_reclaim * 2;
 			if (max_scan < SWAP_CLUSTER_MAX)
 				max_scan = SWAP_CLUSTER_MAX;
-			to_free -= shrink_zone(zone, max_scan, GFP_KERNEL,
+
+			if (i < ZONE_HIGHMEM)
+				gfp_mask = GFP_KERNEL;
+			else
+				gfp_mask = GFP_HIGHUSER;
+
+
+			to_free -= shrink_zone(zone, max_scan, gfp_mask,
 					to_reclaim, &nr_mapped, ps, priority);
-			if (i < ZONE_HIGHMEM) {
-				reclaim_state->reclaimed_slab = 0;
-				shrink_slab(max_scan + nr_mapped, GFP_KERNEL);
-				to_free -= reclaim_state->reclaimed_slab;
-			}
+
+			reclaim_state->reclaimed_slab = 0;
+			shrink_slab(max_scan + nr_mapped, gfp_mask);
+			to_free -= reclaim_state->reclaimed_slab;
+
 			if (zone->all_unreclaimable)
 				continue;
 			if (zone->pages_scanned > zone->present_pages * 2)
@@ -995,10 +994,8 @@ static int balance_pgdat(pg_data_t *pgda
 		}
 		if (all_zones_ok)
 			break;
-		if (to_free > 0) {
-			shrink_pagetable_cache(GFP_HIGHUSER);
+		if (to_free > 0)
 			blk_congestion_wait(WRITE, HZ/10);
-		}
 	}
 
 	for (i = 0; i < pgdat->nr_zones; i++) {
