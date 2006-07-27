Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWG0LXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWG0LXW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 07:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWG0LXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 07:23:22 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:63070
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751297AbWG0LXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 07:23:21 -0400
Message-Id: <44C8BE8F.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 27 Jul 2006 12:24:31 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: initialize end-of-memory variables as early as
	possible
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move initialization of all memory end variables to as early as
possible, so that dependent code doesn't need to check whether these
variables have already been set.

Change the range check in kunmap_atomic to actually make use of this
so that the no-mapping-estabished path (under CONFIG_DEBUG_HIGHMEM)
gets used only when the address is inside the lowmem area (and BUG()
otherwise).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- /home/jbeulich/tmp/linux-2.6.18-rc2/arch/i386/kernel/setup.c	2006-07-27 08:50:01.000000000 +0200
+++ 2.6.18-rc2-i386-early-mem-vars/arch/i386/kernel/setup.c	2006-07-19 14:52:48.000000000 +0200
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
--- /home/jbeulich/tmp/linux-2.6.18-rc2/arch/i386/mm/discontig.c	2006-07-27 08:50:01.000000000 +0200
+++ 2.6.18-rc2-i386-early-mem-vars/arch/i386/mm/discontig.c	2006-07-27 12:31:09.457856288 +0200
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
--- /home/jbeulich/tmp/linux-2.6.18-rc2/arch/i386/mm/highmem.c	2006-06-18 03:49:35.000000000 +0200
+++ 2.6.18-rc2-i386-early-mem-vars/arch/i386/mm/highmem.c	2006-06-30 10:07:14.000000000 +0200
@@ -54,7 +54,7 @@ void kunmap_atomic(void *kvaddr, enum km
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
 
-	if (vaddr < FIXADDR_START) { // FIXME
+	if (vaddr >= PAGE_OFFSET && vaddr < (unsigned long)high_memory) {
 		dec_preempt_count();
 		preempt_check_resched();
 		return;
--- /home/jbeulich/tmp/linux-2.6.18-rc2/arch/i386/mm/init.c	2006-07-27 08:50:01.000000000 +0200
+++ 2.6.18-rc2-i386-early-mem-vars/arch/i386/mm/init.c	2006-07-19 14:52:48.000000000 +0200
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
 


