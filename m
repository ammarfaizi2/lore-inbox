Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWJFJvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWJFJvk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 05:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWJFJvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 05:51:40 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:34715 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751401AbWJFJvi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 05:51:38 -0400
Date: Fri, 6 Oct 2006 10:51:35 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       johannes@sipsolutions.net, Andreas Schwab <schwab@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use symbolic names instead of indices for zone initialisation
Message-ID: <20061006095135.GA9881@skynet.ie>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <20061005042816.GD16812@stusta.de> <1160023503.22232.10.camel@localhost.localdomain> <jevemyv77c.fsf@sykes.suse.de> <20061005211506.GB28161@skynet.ie> <jek63euw97.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <jek63euw97.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Arch-independent zone-sizing is using indices instead of symbolic names
to offset within an array related to zones (max_zone_pfns). The unintended
impact is that ZONE_DMA and ZONE_NORMAL is initialised on powerpc instead
of ZONE_DMA and ZONE_HIGHMEM when CONFIG_HIGHMEM is set. As a result, the
the machine fails to boot but will boot with CONFIG_HIGHMEM turned off.

The following patch properly initialises the max_zone_pfns[] array and uses
symbolic names instead of indices in each architecture using arch-independent
zone-sizing. Two users have successfully booted their powerpcs with it
(one an ibook G4). It has also been boot tested on x86, x86_64, ppc64 and
ia64. Please merge for 2.6.19-rc2.

Credit to Benjamin Herrenschmidt for identifying the bug and rolling the
first fix. Additional credit to Johannes Berg and Andreas Schwab for reporting
the problem and testing on powerpc.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/i386/kernel/setup.c linux-2.6.18-git19-use_zone_symbolic_names/arch/i386/kernel/setup.c
--- linux-2.6.18-git19-clean/arch/i386/kernel/setup.c	2006-10-03 09:12:56.000000000 +0100
+++ linux-2.6.18-git19-use_zone_symbolic_names/arch/i386/kernel/setup.c	2006-10-03 11:15:59.000000000 +0100
@@ -1083,16 +1083,15 @@ static unsigned long __init setup_memory
 
 void __init zone_sizes_init(void)
 {
+	unsigned long max_zone_pfns[MAX_NR_ZONES];
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
+	max_zone_pfns[ZONE_DMA] =
+		virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 #ifdef CONFIG_HIGHMEM
-	unsigned long max_zone_pfns[MAX_NR_ZONES] = {
-			virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT,
-			max_low_pfn,
-			highend_pfn};
+	max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;
 	add_active_range(0, 0, highend_pfn);
 #else
-	unsigned long max_zone_pfns[MAX_NR_ZONES] = {
-			virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT,
-			max_low_pfn};
 	add_active_range(0, 0, max_low_pfn);
 #endif
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/i386/mm/discontig.c linux-2.6.18-git19-use_zone_symbolic_names/arch/i386/mm/discontig.c
--- linux-2.6.18-git19-clean/arch/i386/mm/discontig.c	2006-10-03 09:12:56.000000000 +0100
+++ linux-2.6.18-git19-use_zone_symbolic_names/arch/i386/mm/discontig.c	2006-10-03 11:17:27.000000000 +0100
@@ -357,11 +357,12 @@ void __init numa_kva_reserve(void)
 void __init zone_sizes_init(void)
 {
 	int nid;
-	unsigned long max_zone_pfns[MAX_NR_ZONES] = {
-		virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT,
-		max_low_pfn,
-		highend_pfn
-	};
+	unsigned long max_zone_pfns[MAX_NR_ZONES];
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
+	max_zone_pfns[ZONE_DMA] =
+		virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
+	max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;
 
 	/* If SRAT has not registered memory, register it now */
 	if (find_max_pfn_with_active_regions() == 0) {
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/ia64/mm/contig.c linux-2.6.18-git19-use_zone_symbolic_names/arch/ia64/mm/contig.c
--- linux-2.6.18-git19-clean/arch/ia64/mm/contig.c	2006-10-03 09:12:56.000000000 +0100
+++ linux-2.6.18-git19-use_zone_symbolic_names/arch/ia64/mm/contig.c	2006-10-03 11:21:09.000000000 +0100
@@ -233,6 +233,7 @@ paging_init (void)
 	efi_memmap_walk(count_pages, &num_physpages);
 
 	max_dma = virt_to_phys((void *) MAX_DMA_ADDRESS) >> PAGE_SHIFT;
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
 	max_zone_pfns[ZONE_DMA] = max_dma;
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/ia64/mm/discontig.c linux-2.6.18-git19-use_zone_symbolic_names/arch/ia64/mm/discontig.c
--- linux-2.6.18-git19-clean/arch/ia64/mm/discontig.c	2006-10-03 09:12:56.000000000 +0100
+++ linux-2.6.18-git19-use_zone_symbolic_names/arch/ia64/mm/discontig.c	2006-10-03 11:21:54.000000000 +0100
@@ -709,6 +709,7 @@ void __init paging_init(void)
 			max_pfn = mem_data[node].max_pfn;
 	}
 
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
 	max_zone_pfns[ZONE_DMA] = max_dma;
 	max_zone_pfns[ZONE_NORMAL] = max_pfn;
 	free_area_init_nodes(max_zone_pfns);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/powerpc/mm/mem.c linux-2.6.18-git19-use_zone_symbolic_names/arch/powerpc/mm/mem.c
--- linux-2.6.18-git19-clean/arch/powerpc/mm/mem.c	2006-10-03 09:12:56.000000000 +0100
+++ linux-2.6.18-git19-use_zone_symbolic_names/arch/powerpc/mm/mem.c	2006-10-03 11:10:57.000000000 +0100
@@ -307,11 +307,12 @@ void __init paging_init(void)
 	       top_of_ram, total_ram);
 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
 	       (top_of_ram - total_ram) >> 20);
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
 #ifdef CONFIG_HIGHMEM
-	max_zone_pfns[0] = total_lowmem >> PAGE_SHIFT;
-	max_zone_pfns[1] = top_of_ram >> PAGE_SHIFT;
+	max_zone_pfns[ZONE_DMA] = total_lowmem >> PAGE_SHIFT;
+	max_zone_pfns[ZONE_HIGHMEM] = top_of_ram >> PAGE_SHIFT;
 #else
-	max_zone_pfns[0] = top_of_ram >> PAGE_SHIFT;
+	max_zone_pfns[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
 #endif
 	free_area_init_nodes(max_zone_pfns);
 }
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/powerpc/mm/numa.c linux-2.6.18-git19-use_zone_symbolic_names/arch/powerpc/mm/numa.c
--- linux-2.6.18-git19-clean/arch/powerpc/mm/numa.c	2006-10-03 09:12:56.000000000 +0100
+++ linux-2.6.18-git19-use_zone_symbolic_names/arch/powerpc/mm/numa.c	2006-10-03 11:12:01.000000000 +0100
@@ -617,9 +617,9 @@ void __init do_init_bootmem(void)
 
 void __init paging_init(void)
 {
-	unsigned long max_zone_pfns[MAX_NR_ZONES] = {
-				lmb_end_of_DRAM() >> PAGE_SHIFT
-	};
+	unsigned long max_zone_pfns[MAX_NR_ZONES];
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
+	max_zone_pfns[ZONE_DMA] = lmb_end_of_DRAM() >> PAGE_SHIFT;
 	free_area_init_nodes(max_zone_pfns);
 }
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/ppc/mm/init.c linux-2.6.18-git19-use_zone_symbolic_names/arch/ppc/mm/init.c
--- linux-2.6.18-git19-clean/arch/ppc/mm/init.c	2006-10-03 09:12:56.000000000 +0100
+++ linux-2.6.18-git19-use_zone_symbolic_names/arch/ppc/mm/init.c	2006-10-03 11:13:46.000000000 +0100
@@ -374,11 +374,12 @@ void __init paging_init(void)
 	end_pfn = start_pfn + (total_memory >> PAGE_SHIFT);
 	add_active_range(0, start_pfn, end_pfn);
 
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
 #ifdef CONFIG_HIGHMEM
-	max_zone_pfns[0] = total_lowmem >> PAGE_SHIFT;
-	max_zone_pfns[1] = total_memory >> PAGE_SHIFT;
+	max_zone_pfns[ZONE_DMA] = total_lowmem >> PAGE_SHIFT;
+	max_zone_pfns[ZONE_HIGHMEM] = total_memory >> PAGE_SHIFT;
 #else
-	max_zone_pfns[0] = total_memory >> PAGE_SHIFT;
+	max_zone_pfns[ZONE_DMA] = total_memory >> PAGE_SHIFT;
 #endif /* CONFIG_HIGHMEM */
 	free_area_init_nodes(max_zone_pfns);
 }
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/x86_64/mm/init.c linux-2.6.18-git19-use_zone_symbolic_names/arch/x86_64/mm/init.c
--- linux-2.6.18-git19-clean/arch/x86_64/mm/init.c	2006-10-03 09:12:56.000000000 +0100
+++ linux-2.6.18-git19-use_zone_symbolic_names/arch/x86_64/mm/init.c	2006-10-03 11:18:54.000000000 +0100
@@ -406,9 +406,12 @@ void __cpuinit zap_low_mappings(int cpu)
 #ifndef CONFIG_NUMA
 void __init paging_init(void)
 {
-	unsigned long max_zone_pfns[MAX_NR_ZONES] = {MAX_DMA_PFN,
-							MAX_DMA32_PFN,
-							end_pfn};
+	unsigned long max_zone_pfns[MAX_NR_ZONES];
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
+	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
+	max_zone_pfns[ZONE_DMA32] = MAX_DMA32_PFN;
+	max_zone_pfns[ZONE_NORMAL] = end_pfn;
+
 	memory_present(0, 0, end_pfn);
 	sparse_init();
 	free_area_init_nodes(max_zone_pfns);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/x86_64/mm/numa.c linux-2.6.18-git19-use_zone_symbolic_names/arch/x86_64/mm/numa.c
--- linux-2.6.18-git19-clean/arch/x86_64/mm/numa.c	2006-10-03 09:12:56.000000000 +0100
+++ linux-2.6.18-git19-use_zone_symbolic_names/arch/x86_64/mm/numa.c	2006-10-03 11:19:47.000000000 +0100
@@ -338,9 +338,11 @@ static void __init arch_sparse_init(void
 void __init paging_init(void)
 { 
 	int i;
-	unsigned long max_zone_pfns[MAX_NR_ZONES] = { MAX_DMA_PFN,
-		MAX_DMA32_PFN,
-		end_pfn};
+	unsigned long max_zone_pfns[MAX_NR_ZONES];
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
+	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
+	max_zone_pfns[ZONE_DMA32] = MAX_DMA32_PFN;
+	max_zone_pfns[ZONE_NORMAL] = end_pfn;
 
 	arch_sparse_init();
 
