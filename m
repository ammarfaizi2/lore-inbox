Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTKSKe1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 05:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbTKSKe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 05:34:27 -0500
Received: from holomorphy.com ([199.26.172.102]:61096 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263985AbTKSKeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 05:34:24 -0500
Date: Wed, 19 Nov 2003 02:34:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm4
Message-ID: <20031119103419.GR22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031118225120.1d213db2.akpm@osdl.org> <20031119090223.GO22764@holomorphy.com> <20031119011951.66300f0d.akpm@osdl.org> <20031119093340.GP22764@holomorphy.com> <20031119101322.GQ22764@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119101322.GQ22764@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 01:33:40AM -0800, William Lee Irwin III wrote:
>> This was a micro-optimization for UP; the SMP case needs to protect
>> against reentry via interrupts due to smp_call_function(). UP can
>> just disable preemption. In principle, the two cases could be made
>> uniform at the cost of disabling interrupts unnecessarily on UP.

On Wed, Nov 19, 2003 at 02:13:22AM -0800, William Lee Irwin III wrote:
> The following, incremental atop the first, removes the smp_local_irq_*()
> macros.

The following, incremental atop the smp_local_irq_*() removal, turns
shrink_pagetable_cache() into a set_shrinker()-registered shrinker_t.

I'm not entirely sure how good an idea this is given my prior remarks
about the vmscan.c code skipping shrink_slab() under highmem pressure.
Maybe the proper solution is teaching true slab shrinkers to honor
the gfp_mask argument?

This is also untested (apart from compiletesting).


-- wli


diff -prauN mm4-2.6.0-test9-3/arch/i386/mm/pgtable.c mm4-2.6.0-test9-4/arch/i386/mm/pgtable.c
--- mm4-2.6.0-test9-3/arch/i386/mm/pgtable.c	2003-11-19 02:07:13.000000000 -0800
+++ mm4-2.6.0-test9-4/arch/i386/mm/pgtable.c	2003-11-19 02:26:04.000000000 -0800
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -421,7 +422,7 @@ static void shrink_cpu_pagetable_cache(v
 	put_cpu();
 }
 
-void shrink_pagetable_cache(int gfp_mask)
+static int shrink_pagetable_cache(int nr_to_scan, unsigned int gfp_mask)
 {
 	BUG_ON(irqs_disabled());
 
@@ -432,4 +433,13 @@ void shrink_pagetable_cache(int gfp_mask
 
 	smp_call_function(shrink_cpu_pagetable_cache, (void *)gfp_mask, 1, 1);
 	preempt_enable();
+	return 1;
 }
+
+static __init int init_pagetable_cache_shrinker(void)
+{
+	set_shrinker(1, shrink_pagetable_cache);
+	return 0;
+}
+
+__initcall(init_pagetable_cache_shrinker);
diff -prauN mm4-2.6.0-test9-3/include/asm-i386/pgtable.h mm4-2.6.0-test9-4/include/asm-i386/pgtable.h
--- mm4-2.6.0-test9-3/include/asm-i386/pgtable.h	2003-11-19 00:09:43.000000000 -0800
+++ mm4-2.6.0-test9-4/include/asm-i386/pgtable.h	2003-11-19 02:24:14.000000000 -0800
@@ -44,9 +44,6 @@ void pgtable_cache_init(void);
 void paging_init(void);
 void setup_identity_mappings(pgd_t *pgd_base, unsigned long start, unsigned long end);
 
-#define HAVE_ARCH_PAGETABLE_CACHE
-void shrink_pagetable_cache(int gfp_mask);
-
 #endif /* !__ASSEMBLY__ */
 
 /*
diff -prauN mm4-2.6.0-test9-3/mm/vmscan.c mm4-2.6.0-test9-4/mm/vmscan.c
--- mm4-2.6.0-test9-3/mm/vmscan.c	2003-11-19 00:09:43.000000000 -0800
+++ mm4-2.6.0-test9-4/mm/vmscan.c	2003-11-19 02:15:43.000000000 -0800
@@ -838,10 +838,6 @@ shrink_caches(struct zone *classzone, in
 	return ret;
 }
 
-#ifndef HAVE_ARCH_PAGETABLE_CACHE
-#define shrink_pagetable_cache(gfp_mask)		do { } while (0)
-#endif
- 
 /*
  * This is the main entry point to direct page reclaim.
  *
@@ -894,9 +890,6 @@ int try_to_free_pages(struct zone *cz,
 		 */
 		wakeup_bdflush(total_scanned);
 
-		/* shoot down some pagetable caches before napping */
-		shrink_pagetable_cache(gfp_mask);
-
 		/* Take a nap, wait for some writeback to complete */
 		blk_congestion_wait(WRITE, HZ/10);
 		if (cz - cz->zone_pgdat->node_zones < ZONE_HIGHMEM) {
@@ -988,10 +981,8 @@ static int balance_pgdat(pg_data_t *pgda
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
