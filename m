Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbTLMB1L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 20:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTLMB1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 20:27:11 -0500
Received: from holomorphy.com ([199.26.172.102]:17900 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262760AbTLMB1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 20:27:06 -0500
Date: Fri, 12 Dec 2003 17:27:03 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: 2.6.0-test11-wli-2
Message-ID: <20031213012703.GR19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
References: <20031211052929.GN19856@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031211052929.GN19856@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 09:29:29PM -0800, William Lee Irwin III wrote:
> Successfully tested on a Thinkpad T21 and 32GB NUMA-Q. Any feedback
> regarding performance would be very helpful. Desktop users should
> notice top(1) is faster, kernel hackers that kernel compiles are faster,
> and highmem users should see much less per-process lowmem overhead

shrink_pagetable_cache() can't really do a TLB shootdown like it would
want to (at least not in the IPI handler!), and there isn't really a
good way to sync them all so they've flushed their TLB's before any of
them proceeds. So trim only the ready list. Also clean up some excess
whitespace and a bad gfp_mask initializer in shrink_cpu_pagetable_cache().
Maybe gcc should add a _useful_ warning for once and complain about
recursive initialization without any indirection. There's also no
reason to wait for the things to finish; we don't return a meaningful
status as it stands, though at some point it may be worthwhile to
change that if it matters how much we freed.


-- wli


diff -prauN wli-2.6.0-test11-33-A/arch/i386/mm/pgtable.c wli-2.6.0-test11-numaq-33-A/arch/i386/mm/pgtable.c
--- wli-2.6.0-test11-33-A/arch/i386/mm/pgtable.c	2003-12-04 07:36:00.000000000 -0800
+++ wli-2.6.0-test11-numaq-33-A/arch/i386/mm/pgtable.c	2003-12-12 16:33:34.000000000 -0800
@@ -298,32 +298,18 @@ void pgd_free(pgd_t *pgd)
 
 static void shrink_cpu_pagetable_cache(void *__gfp_mask)
 {
-	int cpu, zone, high, gfp_mask = (int)gfp_mask;
+	int cpu, zone, high, gfp_mask = (int)__gfp_mask;
 	unsigned long flags;
 	struct mmu_gather *tlb;
 
 	high = !!(gfp_mask & __GFP_HIGHMEM);
 	cpu = get_cpu();
 	tlb = &per_cpu(mmu_gathers, cpu);
-	smp_local_irq_save(flags);
 
-	if (tlb->nr_pte_active || tlb->nr_nonpte)
-		tlb_flush(tlb);
+	smp_local_irq_save(flags);
 
-	if (tlb->nr_pte_active) {
-		for (zone = 0; zone < MAX_ZONE_ID; ++zone) {
-			if (!high && zone_high(zone_table[zone]))
-				continue;
-			if (!tlb->active_count[zone])
-				continue;
-
-			list_splice_init(&tlb->active_list[zone], &tlb->ready_list[zone]);
-			tlb->ready_count[zone] += tlb->active_count[zone];
-			tlb->active_count[zone] = 0;
-		}
-		tlb->nr_pte_ready += tlb->nr_pte_active;
-		tlb->nr_pte_active = 0;
-	}
+	if (!tlb->nr_pte_ready)
+		goto out;
 
 	for (zone = 0; zone < MAX_ZONE_ID; ++zone) {
 		struct page *head;
@@ -341,7 +327,7 @@ static void shrink_cpu_pagetable_cache(v
 		tlb->ready_count[zone] = 0;
 		free_pages_bulk(zone_table[zone], head, 0);
 	}
-
+out:
 	smp_local_irq_restore(flags);
 	put_cpu();
 }
@@ -349,13 +335,9 @@ static void shrink_cpu_pagetable_cache(v
 void shrink_pagetable_cache(int gfp_mask)
 {
 	BUG_ON(irqs_disabled());
-
 	preempt_disable();
-
-	/* disables interrupts appropriately internally */
+	smp_call_function(shrink_cpu_pagetable_cache, (void *)gfp_mask, 0, 0);
 	shrink_cpu_pagetable_cache((void *)gfp_mask);
-
-	smp_call_function(shrink_cpu_pagetable_cache, (void *)gfp_mask, 1, 1);
 	preempt_enable();
 }
 
