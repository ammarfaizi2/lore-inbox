Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTKSKNa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 05:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTKSKNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 05:13:30 -0500
Received: from holomorphy.com ([199.26.172.102]:58024 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263969AbTKSKN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 05:13:26 -0500
Date: Wed, 19 Nov 2003 02:13:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm4
Message-ID: <20031119101322.GQ22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031118225120.1d213db2.akpm@osdl.org> <20031119090223.GO22764@holomorphy.com> <20031119011951.66300f0d.akpm@osdl.org> <20031119093340.GP22764@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119093340.GP22764@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>>> +#ifdef CONFIG_SMP
>>> +#define smp_local_irq_save(x)		local_irq_save(x)
>>> +#define smp_local_irq_restore(x)	local_irq_restore(x)
>>> +#define smp_local_irq_disable()		local_irq_disable()
>>> +#define smp_local_irq_enable()		local_irq_enable()
>>> +#else
[...]

On Wed, Nov 19, 2003 at 01:19:51AM -0800, Andrew Morton wrote:
>> Interesting.

On Wed, Nov 19, 2003 at 01:33:40AM -0800, William Lee Irwin III wrote:
> This was a micro-optimization for UP; the SMP case needs to protect
> against reentry via interrupts due to smp_call_function(). UP can
> just disable preemption. In principle, the two cases could be made
> uniform at the cost of disabling interrupts unnecessarily on UP.

The following, incremental atop the first, removes the smp_local_irq_*()
macros.


-- wli


diff -prauN mm4-2.6.0-test9-2/arch/i386/mm/pgtable.c mm4-2.6.0-test9-3/arch/i386/mm/pgtable.c
--- mm4-2.6.0-test9-2/arch/i386/mm/pgtable.c	2003-11-19 00:22:54.000000000 -0800
+++ mm4-2.6.0-test9-3/arch/i386/mm/pgtable.c	2003-11-19 02:07:13.000000000 -0800
@@ -177,7 +177,7 @@ static inline struct page *pte_alloc_rea
 	unsigned long flags;
 	struct page *page = NULL;
 
-	smp_local_irq_save(flags);
+	local_irq_save(flags);
 	if (tlb->nr_pte_ready) {
 		int z;
 		for (z = MAX_ZONE_ID - 1; z >= 0; --z) {
@@ -194,7 +194,7 @@ static inline struct page *pte_alloc_rea
 		tlb->ready_count[z]--;
 		tlb->nr_pte_ready--;
 	}
-	smp_local_irq_restore(flags);
+	local_irq_restore(flags);
 	put_cpu();
 	return page;
 }
@@ -381,7 +381,7 @@ static void shrink_cpu_pagetable_cache(v
 	high = !!(gfp_mask & __GFP_HIGHMEM);
 	cpu = get_cpu();
 	tlb = &per_cpu(mmu_gathers, cpu);
-	smp_local_irq_save(flags);
+	local_irq_save(flags);
 
 	if (tlb->nr_pte_active)
 		tlb_flush(tlb);
@@ -417,7 +417,7 @@ static void shrink_cpu_pagetable_cache(v
 		tlb->ready_count[zone] = 0;
 	}
 
-	smp_local_irq_restore(flags);
+	local_irq_restore(flags);
 	put_cpu();
 }
 
diff -prauN mm4-2.6.0-test9-2/include/asm-i386/system.h mm4-2.6.0-test9-3/include/asm-i386/system.h
--- mm4-2.6.0-test9-2/include/asm-i386/system.h	2003-11-19 00:09:43.000000000 -0800
+++ mm4-2.6.0-test9-3/include/asm-i386/system.h	2003-11-19 02:06:11.000000000 -0800
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
diff -prauN mm4-2.6.0-test9-2/include/asm-i386/tlb.h mm4-2.6.0-test9-3/include/asm-i386/tlb.h
--- mm4-2.6.0-test9-2/include/asm-i386/tlb.h	2003-11-19 00:23:35.000000000 -0800
+++ mm4-2.6.0-test9-3/include/asm-i386/tlb.h	2003-11-19 02:06:58.000000000 -0800
@@ -106,7 +106,7 @@ void tlb_flush_mmu(struct mmu_gather *tl
 	tlb->need_flush = 0;
 	tlb_flush(tlb);
 
-	smp_local_irq_save(flags);
+	local_irq_save(flags);
 
 	if (tlb->nr_nonpte) {
 		free_pages_and_swap_cache(tlb->nonpte, tlb->nr_nonpte);
@@ -126,7 +126,7 @@ void tlb_flush_mmu(struct mmu_gather *tl
 	if (tlb->nr_pte_ready >= NR_PTE)
 		tlb_flush_ready(tlb);
 
-	smp_local_irq_restore(flags);
+	local_irq_restore(flags);
 }
 
 static inline
@@ -163,13 +163,13 @@ void tlb_remove_page(struct mmu_gather *
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
