Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263819AbTKSJCx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 04:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTKSJCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 04:02:53 -0500
Received: from holomorphy.com ([199.26.172.102]:51368 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263819AbTKSJC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 04:02:29 -0500
Date: Wed, 19 Nov 2003 01:02:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm4
Message-ID: <20031119090223.GO22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031118225120.1d213db2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031118225120.1d213db2.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 18, 2003 at 10:51:20PM -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/
> . Several fixes against patches which are only in -mm at present.
> . Minor fixes which we'll queue for post-2.6.0.
> . The interactivity problems which the ACPI PM timer patch showed up
>   should be fixed here - please sing out if not.

I'm not sure if this is within the scope of current efforts, but I
gave it a shot just to see how bad untangling it from highpmd and
O(1) buffered_rmqueue() was. It turns out it wasn't that hard.

The codebase (so to speak) has been in regular use since June, though
the port to -mm only lightly tested (basically testbooted on a laptop).

There is some minor core impact.

--

This patch utilizes the tlb.h hooks to perform highpte-compatible pte
cacheing. The a priori benefits are cache conservation, and the motive
(of course) redressing an apparent regression in functionality and/or
performance vs. 2.4.

vs. 2.6.0-test9-mm4


-- wli


diff -prauN mm4-2.6.0-test9-1/arch/i386/mm/init.c mm4-2.6.0-test9-2/arch/i386/mm/init.c
--- mm4-2.6.0-test9-1/arch/i386/mm/init.c	2003-11-19 00:07:03.000000000 -0800
+++ mm4-2.6.0-test9-2/arch/i386/mm/init.c	2003-11-19 00:09:43.000000000 -0800
@@ -465,7 +465,7 @@ void __init mem_init(void)
 
 	/* this will put all low memory onto the freelists */
 	totalram_pages += __free_all_bootmem();
-
+	tlb_init();
 	reservedpages = 0;
 	for (tmp = 0; tmp < max_low_pfn; tmp++)
 		/*
diff -prauN mm4-2.6.0-test9-1/arch/i386/mm/pgtable.c mm4-2.6.0-test9-2/arch/i386/mm/pgtable.c
--- mm4-2.6.0-test9-1/arch/i386/mm/pgtable.c	2003-11-19 00:07:03.000000000 -0800
+++ mm4-2.6.0-test9-2/arch/i386/mm/pgtable.c	2003-11-19 00:22:54.000000000 -0800
@@ -139,18 +139,70 @@ pte_t *pte_alloc_one_kernel(struct mm_st
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
+	smp_local_irq_save(flags);
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
+	smp_local_irq_restore(flags);
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
@@ -320,3 +372,64 @@ out_free:
 	kmem_cache_free(pgd_cache, pgd);
 }
 
+static void shrink_cpu_pagetable_cache(void *__gfp_mask)
+{
+	int cpu, zone, high, gfp_mask = (int)gfp_mask;
+	unsigned long flags;
+	struct mmu_gather *tlb;
+
+	high = !!(gfp_mask & __GFP_HIGHMEM);
+	cpu = get_cpu();
+	tlb = &per_cpu(mmu_gathers, cpu);
+	smp_local_irq_save(flags);
+
+	if (tlb->nr_pte_active)
+		tlb_flush(tlb);
+
+	/* Can't flush nonpte from interrupt context */
+
+	if (tlb->nr_pte_active) {
+		for (zone = 0; zone < MAX_ZONE_ID; ++zone) {
+			if (!high && zone_high(zone_table[zone]))
+				continue;
+			if (!tlb->active_count[zone])
+				continue;
+
+			list_splice_init(&tlb->active_list[zone], &tlb->ready_list[zone]);
+			tlb->ready_count[zone] += tlb->active_count[zone];
+			tlb->active_count[zone] = 0;
+		}
+		tlb->nr_pte_ready += tlb->nr_pte_active;
+		tlb->nr_pte_active = 0;
+	}
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
+
+	smp_local_irq_restore(flags);
+	put_cpu();
+}
+
+void shrink_pagetable_cache(int gfp_mask)
+{
+	BUG_ON(irqs_disabled());
+
+	preempt_disable();
+
+	/* disables interrupts appropriately internally */
+	shrink_cpu_pagetable_cache((void *)gfp_mask);
+
+	smp_call_function(shrink_cpu_pagetable_cache, (void *)gfp_mask, 1, 1);
+	preempt_enable();
+}
diff -prauN mm4-2.6.0-test9-1/include/asm-i386/pgalloc.h mm4-2.6.0-test9-2/include/asm-i386/pgalloc.h
--- mm4-2.6.0-test9-1/include/asm-i386/pgalloc.h	2003-10-25 11:42:51.000000000 -0700
+++ mm4-2.6.0-test9-2/include/asm-i386/pgalloc.h	2003-11-19 00:26:00.000000000 -0800
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
diff -prauN mm4-2.6.0-test9-1/include/asm-i386/pgtable.h mm4-2.6.0-test9-2/include/asm-i386/pgtable.h
--- mm4-2.6.0-test9-1/include/asm-i386/pgtable.h	2003-11-19 00:07:12.000000000 -0800
+++ mm4-2.6.0-test9-2/include/asm-i386/pgtable.h	2003-11-19 00:09:43.000000000 -0800
@@ -44,6 +44,9 @@ void pgtable_cache_init(void);
 void paging_init(void);
 void setup_identity_mappings(pgd_t *pgd_base, unsigned long start, unsigned long end);
 
+#define HAVE_ARCH_PAGETABLE_CACHE
+void shrink_pagetable_cache(int gfp_mask);
+
 #endif /* !__ASSEMBLY__ */
 
 /*
diff -prauN mm4-2.6.0-test9-1/include/asm-i386/system.h mm4-2.6.0-test9-2/include/asm-i386/system.h
--- mm4-2.6.0-test9-1/include/asm-i386/system.h	2003-10-25 11:42:45.000000000 -0700
+++ mm4-2.6.0-test9-2/include/asm-i386/system.h	2003-11-19 00:09:43.000000000 -0800
@@ -461,6 +461,18 @@ struct alt_instr { 
 /* For spinlocks etc */
 #define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
 
+#ifdef CONFIG_SMP
+#define smp_local_irq_save(x)		local_irq_save(x)
+#define smp_local_irq_restore(x)	local_irq_restore(x)
+#define smp_local_irq_disable()		local_irq_disable()
+#define smp_local_irq_enable()		local_irq_enable()
+#else
+#define smp_local_irq_save(x)		do { (void)(x); } while (0)
+#define smp_local_irq_restore(x)	do { (void)(x); } while (0)
+#define smp_local_irq_disable()		do { } while (0)
+#define smp_local_irq_enable()		do { } while (0)
+#endif /* CONFIG_SMP */
+
 /*
  * disable hlt during certain critical i/o operations
  */
diff -prauN mm4-2.6.0-test9-1/include/asm-i386/tlb.h mm4-2.6.0-test9-2/include/asm-i386/tlb.h
--- mm4-2.6.0-test9-1/include/asm-i386/tlb.h	2003-10-25 11:43:17.000000000 -0700
+++ mm4-2.6.0-test9-2/include/asm-i386/tlb.h	2003-11-19 00:23:35.000000000 -0800
@@ -1,10 +1,52 @@
 #ifndef _I386_TLB_H
 #define _I386_TLB_H
+/*
+ * include/asm-i386/tlb.h
+ * (C) June 2003 William Irwin, IBM
+ * Routines for pagetable cacheing and release.
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
+	smp_local_irq_save(flags);
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
+	smp_local_irq_restore(flags);
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
+	smp_local_irq_save(flags);
+	tlb->need_flush = 1;
+	if (PagePTE(page))
+		tlb_remove_pte_page(tlb, page);
+	else
+		tlb_remove_nonpte_page(tlb, page);
+	smp_local_irq_restore(flags);
+}
+
+#endif /* _I386_TLB_H */
diff -prauN mm4-2.6.0-test9-1/include/linux/gfp.h mm4-2.6.0-test9-2/include/linux/gfp.h
--- mm4-2.6.0-test9-1/include/linux/gfp.h	2003-10-25 11:43:12.000000000 -0700
+++ mm4-2.6.0-test9-2/include/linux/gfp.h	2003-11-19 00:14:24.000000000 -0800
@@ -79,6 +79,7 @@ static inline struct page * alloc_pages_
 
 extern unsigned long FASTCALL(__get_free_pages(unsigned int gfp_mask, unsigned int order));
 extern unsigned long FASTCALL(get_zeroed_page(unsigned int gfp_mask));
+int free_pages_bulk(struct zone *zone, int count, struct list_head *list, unsigned int order);
 
 #define __get_free_page(gfp_mask) \
 		__get_free_pages((gfp_mask),0)
diff -prauN mm4-2.6.0-test9-1/mm/page_alloc.c mm4-2.6.0-test9-2/mm/page_alloc.c
--- mm4-2.6.0-test9-1/mm/page_alloc.c	2003-11-19 00:07:15.000000000 -0800
+++ mm4-2.6.0-test9-2/mm/page_alloc.c	2003-11-19 00:13:11.000000000 -0800
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
diff -prauN mm4-2.6.0-test9-1/mm/vmscan.c mm4-2.6.0-test9-2/mm/vmscan.c
--- mm4-2.6.0-test9-1/mm/vmscan.c	2003-11-19 00:07:15.000000000 -0800
+++ mm4-2.6.0-test9-2/mm/vmscan.c	2003-11-19 00:09:43.000000000 -0800
@@ -837,6 +837,10 @@ shrink_caches(struct zone *classzone, in
 	}
 	return ret;
 }
+
+#ifndef HAVE_ARCH_PAGETABLE_CACHE
+#define shrink_pagetable_cache(gfp_mask)		do { } while (0)
+#endif
  
 /*
  * This is the main entry point to direct page reclaim.
@@ -890,6 +894,9 @@ int try_to_free_pages(struct zone *cz,
 		 */
 		wakeup_bdflush(total_scanned);
 
+		/* shoot down some pagetable caches before napping */
+		shrink_pagetable_cache(gfp_mask);
+
 		/* Take a nap, wait for some writeback to complete */
 		blk_congestion_wait(WRITE, HZ/10);
 		if (cz - cz->zone_pgdat->node_zones < ZONE_HIGHMEM) {
@@ -981,8 +988,10 @@ static int balance_pgdat(pg_data_t *pgda
 		}
 		if (all_zones_ok)
 			break;
-		if (to_free > 0)
+		if (to_free > 0) {
+			shrink_pagetable_cache(GFP_HIGHUSER);
 			blk_congestion_wait(WRITE, HZ/10);
+		}
 	}
 
 	for (i = 0; i < pgdat->nr_zones; i++) {
