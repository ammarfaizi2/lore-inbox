Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbWHJTgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbWHJTgf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbWHJTge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:51179 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932628AbWHJTg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:29 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [72/145] i386: initialize end-of-memory variables as early as possible
Message-Id: <20060810193628.625A213C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:28 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: "Jan Beulich" <jbeulich@novell.com>
Move initialization of all memory end variables to as early as
possible, so that dependent code doesn't need to check whether these
variables have already been set.

Change the range check in kunmap_atomic to actually make use of this
so that the no-mapping-estabished path (under CONFIG_DEBUG_HIGHMEM)
gets used only when the address is inside the lowmem area (and BUG()
otherwise).

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/setup.c |    8 ++++++++
 arch/i386/mm/discontig.c |    5 +++++
 arch/i386/mm/highmem.c   |    2 +-
 arch/i386/mm/init.c      |   20 --------------------
 4 files changed, 14 insertions(+), 21 deletions(-)

Index: linux/arch/i386/kernel/setup.c
===================================================================
--- linux.orig/arch/i386/kernel/setup.c
+++ linux/arch/i386/kernel/setup.c
@@ -1170,6 +1170,14 @@ static unsigned long __init setup_memory
 	}
 	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
 		pages_to_mb(highend_pfn - highstart_pfn));
+	num_physpages = highend_pfn;
+	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
+#else
+	num_physpages = max_low_pfn;
+	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
+#endif
+#ifdef CONFIG_FLATMEM
+	max_mapnr = num_physpages;
 #endif
 	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
 			pages_to_mb(max_low_pfn));
Index: linux/arch/i386/mm/discontig.c
===================================================================
--- linux.orig/arch/i386/mm/discontig.c
+++ linux/arch/i386/mm/discontig.c
@@ -313,6 +313,11 @@ unsigned long __init setup_memory(void)
 		highstart_pfn = system_max_low_pfn;
 	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
 	       pages_to_mb(highend_pfn - highstart_pfn));
+	num_physpages = highend_pfn;
+	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
+#else
+	num_physpages = system_max_low_pfn;
+	high_memory = (void *) __va(system_max_low_pfn * PAGE_SIZE - 1) + 1;
 #endif
 	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
 			pages_to_mb(system_max_low_pfn));
Index: linux/arch/i386/mm/highmem.c
===================================================================
--- linux.orig/arch/i386/mm/highmem.c
+++ linux/arch/i386/mm/highmem.c
@@ -54,7 +54,7 @@ void kunmap_atomic(void *kvaddr, enum km
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
 
-	if (vaddr < FIXADDR_START) { // FIXME
+	if (vaddr >= PAGE_OFFSET && vaddr < (unsigned long)high_memory) {
 		dec_preempt_count();
 		preempt_check_resched();
 		return;
Index: linux/arch/i386/mm/init.c
===================================================================
--- linux.orig/arch/i386/mm/init.c
+++ linux/arch/i386/mm/init.c
@@ -552,18 +552,6 @@ static void __init test_wp_bit(void)
 	}
 }
 
-static void __init set_max_mapnr_init(void)
-{
-#ifdef CONFIG_HIGHMEM
-	num_physpages = highend_pfn;
-#else
-	num_physpages = max_low_pfn;
-#endif
-#ifdef CONFIG_FLATMEM
-	max_mapnr = num_physpages;
-#endif
-}
-
 static struct kcore_list kcore_mem, kcore_vmalloc; 
 
 void __init mem_init(void)
@@ -590,14 +578,6 @@ void __init mem_init(void)
 	}
 #endif
  
-	set_max_mapnr_init();
-
-#ifdef CONFIG_HIGHMEM
-	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
-#else
-	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
-#endif
-
 	/* this will put all low memory onto the freelists */
 	totalram_pages += free_all_bootmem();
 
