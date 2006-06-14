Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWFNBIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWFNBIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWFNBDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:03:54 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:9957 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964845AbWFNBDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:03:47 -0400
Date: Tue, 13 Jun 2006 18:03:40 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>, Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010340.859.71131.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 12/21] Conversion of nr_pagetables to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: zoned vm counters: conversion of nr_pagetable to per zone counter
From: Christoph Lameter <clameter@sgi.com>

Conversion of nr_page_table_pages to a per zone counter

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/arch/i386/mm/pgtable.c	2006-06-13 17:13:31.758785575 -0700
+++ linux-2.6.17-rc6-cl/arch/i386/mm/pgtable.c	2006-06-13 17:14:25.000611421 -0700
@@ -63,7 +63,8 @@ void show_mem(void)
 	printk(KERN_INFO "%lu pages writeback\n", ps.nr_writeback);
 	printk(KERN_INFO "%lu pages mapped\n", global_page_state(NR_MAPPED));
 	printk(KERN_INFO "%lu pages slab\n", global_page_state(NR_SLAB));
-	printk(KERN_INFO "%lu pages pagetables\n", ps.nr_page_table_pages);
+	printk(KERN_INFO "%lu pages pagetables\n",
+					global_page_state(NR_PAGETABLE));
 }
 
 /*
Index: linux-2.6.17-rc6-cl/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/proc/proc_misc.c	2006-06-13 17:13:31.760738580 -0700
+++ linux-2.6.17-rc6-cl/fs/proc/proc_misc.c	2006-06-13 17:14:05.949054797 -0700
@@ -171,9 +171,9 @@ static int meminfo_read_proc(char *page,
 		"Anonymous:    %8lu kB\n"
 		"Mapped:       %8lu kB\n"
 		"Slab:         %8lu kB\n"
+		"PageTables:   %8lu kB\n"
 		"CommitLimit:  %8lu kB\n"
 		"Committed_AS: %8lu kB\n"
-		"PageTables:   %8lu kB\n"
 		"VmallocTotal: %8lu kB\n"
 		"VmallocUsed:  %8lu kB\n"
 		"VmallocChunk: %8lu kB\n",
@@ -195,9 +195,9 @@ static int meminfo_read_proc(char *page,
 		K(global_page_state(NR_ANON)),
 		K(global_page_state(NR_MAPPED)),
 		K(global_page_state(NR_SLAB)),
+		K(global_page_state(NR_PAGETABLE)),
 		K(allowed),
 		K(committed),
-		K(ps.nr_page_table_pages),
 		(unsigned long)VMALLOC_TOTAL >> 10,
 		vmi.used >> 10,
 		vmi.largest_chunk >> 10
Index: linux-2.6.17-rc6-cl/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-13 17:13:31.761715082 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-13 17:14:05.950031299 -0700
@@ -52,6 +52,7 @@ enum zone_stat_item {
 			   only modified from process context */
 	NR_PAGECACHE,
 	NR_SLAB,	/* Pages used by slab allocator */
+	NR_PAGETABLE,	/* used for pagetables */
 	NR_VM_ZONE_STAT_ITEMS };
 
 struct per_cpu_pages {
Index: linux-2.6.17-rc6-cl/mm/memory.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/memory.c	2006-06-12 12:42:52.030113494 -0700
+++ linux-2.6.17-rc6-cl/mm/memory.c	2006-06-13 17:14:05.951984303 -0700
@@ -127,7 +127,7 @@ static void free_pte_range(struct mmu_ga
 	pmd_clear(pmd);
 	pte_lock_deinit(page);
 	pte_free_tlb(tlb, page);
-	dec_page_state(nr_page_table_pages);
+	dec_zone_page_state(page, NR_PAGETABLE);
 	tlb->mm->nr_ptes--;
 }
 
@@ -312,7 +312,7 @@ int __pte_alloc(struct mm_struct *mm, pm
 		pte_free(new);
 	} else {
 		mm->nr_ptes++;
-		inc_page_state(nr_page_table_pages);
+		inc_zone_page_state(new, NR_PAGETABLE);
 		pmd_populate(mm, pmd, new);
 	}
 	spin_unlock(&mm->page_table_lock);
Index: linux-2.6.17-rc6-cl/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page_alloc.c	2006-06-13 17:13:31.773433107 -0700
+++ linux-2.6.17-rc6-cl/mm/page_alloc.c	2006-06-13 17:14:05.952960805 -0700
@@ -1410,7 +1410,7 @@ void show_free_areas(void)
 		nr_free_pages(),
 		global_page_state(NR_SLAB),
 		global_page_state(NR_MAPPED),
-		ps.nr_page_table_pages);
+		global_page_state(NR_PAGETABLE));
 
 	for_each_zone(zone) {
 		int i;
Index: linux-2.6.17-rc6-cl/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/drivers/base/node.c	2006-06-13 17:13:31.759762077 -0700
+++ linux-2.6.17-rc6-cl/drivers/base/node.c	2006-06-13 17:14:05.953937307 -0700
@@ -70,6 +70,7 @@ static ssize_t node_read_meminfo(struct 
 		       "Node %d PageCache:    %8lu kB\n"
 		       "Node %d Mapped:       %8lu kB\n"
 		       "Node %d Anonymous:    %8lu kB\n"
+		       "Node %d PageTables:   %8lu kB\n"
 		       "Node %d Slab:         %8lu kB\n",
 		       nid, K(i.totalram),
 		       nid, K(i.freeram),
@@ -85,6 +86,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(node_page_state(nid, NR_PAGECACHE)),
 		       nid, K(node_page_state(nid, NR_MAPPED)),
 		       nid, K(node_page_state(nid, NR_ANON)),
+		       nid, K(node_page_state(nid, NR_PAGETABLE)),
 		       nid, K(node_page_state(nid, NR_SLAB)));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
Index: linux-2.6.17-rc6-cl/arch/um/kernel/skas/mmu.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/arch/um/kernel/skas/mmu.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-cl/arch/um/kernel/skas/mmu.c	2006-06-13 17:14:05.954913809 -0700
@@ -152,7 +152,7 @@ void destroy_context_skas(struct mm_stru
 		free_page(mmu->id.stack);
 		pte_lock_deinit(virt_to_page(mmu->last_page_table));
 		pte_free_kernel((pte_t *) mmu->last_page_table);
-                dec_page_state(nr_page_table_pages);
+		dec_zone_page_state(virt_to_page(mmu->last_page_table), NR_PAGETABLE);
 #ifdef CONFIG_3_LEVEL_PGTABLES
 		pmd_free((pmd_t *) mmu->last_pmd);
 #endif
Index: linux-2.6.17-rc6-cl/arch/arm/mm/mm-armv.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/arch/arm/mm/mm-armv.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-cl/arch/arm/mm/mm-armv.c	2006-06-13 17:14:05.955890311 -0700
@@ -227,7 +227,7 @@ void free_pgd_slow(pgd_t *pgd)
 
 	pte = pmd_page(*pmd);
 	pmd_clear(pmd);
-	dec_page_state(nr_page_table_pages);
+	dec_zone_page_state(virt_to_page((unsigned long *)pgd), NR_PAGETABLE);
 	pte_lock_deinit(pte);
 	pte_free(pte);
 	pmd_free(pmd);
Index: linux-2.6.17-rc6-cl/mm/vmstat.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmstat.c	2006-06-13 17:13:31.777339116 -0700
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-13 17:14:05.955890311 -0700
@@ -461,12 +461,12 @@ static char *vmstat_text[] = {
 	"nr_mapped",
 	"nr_pagecache",
 	"nr_slab",
+	"nr_page_table_pages",
 
 	/* Page state */
 	"nr_dirty",
 	"nr_writeback",
 	"nr_unstable",
-	"nr_page_table_pages",
 
 	"pgpgin",
 	"pgpgout",
