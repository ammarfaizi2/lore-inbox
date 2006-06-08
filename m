Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWFHXDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWFHXDw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWFHXDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:03:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56251 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965060AbWFHXD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:03:29 -0400
Date: Thu, 8 Jun 2006 16:03:21 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060608230321.25121.18057.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 08/14] Conversion of nr_pagetable to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion of nr_page_table_pages to a per zone counter

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/mm/memory.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/memory.c	2006-06-08 15:20:11.539443944 -0700
+++ linux-2.6.17-rc6-mm1/mm/memory.c	2006-06-08 15:46:10.307202214 -0700
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
Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-08 15:45:44.043203549 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-08 15:46:10.309155218 -0700
@@ -628,7 +628,7 @@ static int rmqueue_bulk(struct zone *zon
 	return i;
 }
 
-char *vm_stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache", "slab" };
+char *vm_stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache", "slab", "pagetable" };
 
 /*
  * Manage combined zone based / global counters
@@ -1812,7 +1812,7 @@ void show_free_areas(void)
 		nr_free_pages(),
 		global_page_state(NR_SLAB),
 		global_page_state(NR_MAPPED),
-		ps.nr_page_table_pages);
+		global_page_state(NR_PAGETABLE));
 
 	for_each_zone(zone) {
 		int i;
@@ -2805,12 +2805,12 @@ static char *vmstat_text[] = {
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
Index: linux-2.6.17-rc6-mm1/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/page-flags.h	2006-06-08 15:45:44.047109557 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/page-flags.h	2006-06-08 15:46:10.309155218 -0700
@@ -122,8 +122,7 @@ struct page_state {
 	unsigned long nr_dirty;		/* Dirty writeable pages */
 	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
-	unsigned long nr_page_table_pages;/* Pages used for pagetables */
-#define GET_PAGE_STATE_LAST nr_page_table_pages
+#define GET_PAGE_STATE_LAST nr_unstable
 
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
Index: linux-2.6.17-rc6-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/mmzone.h	2006-06-08 15:45:44.046133055 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/mmzone.h	2006-06-08 15:46:10.310131720 -0700
@@ -51,6 +51,7 @@ enum zone_stat_item {
 			   only modified from process context */
 	NR_PAGECACHE,	/* file backed pages */
 	NR_SLAB,	/* used by slab allocator */
+	NR_PAGETABLE,	/* used for pagetables */
 	NR_STAT_ITEMS };
 
 #ifdef CONFIG_SMP
Index: linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/proc/proc_misc.c	2006-06-08 15:45:44.041250545 -0700
+++ linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c	2006-06-08 15:46:10.311108222 -0700
@@ -194,7 +194,7 @@ static int meminfo_read_proc(char *page,
 		K(global_page_state(NR_SLAB)),
 		K(allowed),
 		K(committed),
-		K(ps.nr_page_table_pages),
+		K(global_page_state(NR_PAGETABLE)),
 		(unsigned long)VMALLOC_TOTAL >> 10,
 		vmi.used >> 10,
 		vmi.largest_chunk >> 10
Index: linux-2.6.17-rc6-mm1/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/arch/i386/mm/pgtable.c	2006-06-08 15:46:08.094448609 -0700
+++ linux-2.6.17-rc6-mm1/arch/i386/mm/pgtable.c	2006-06-08 15:46:34.925794955 -0700
@@ -63,7 +63,7 @@ void show_mem(void)
 	printk(KERN_INFO "%lu pages writeback\n", ps.nr_writeback);
 	printk(KERN_INFO "%lu pages mapped\n", global_page_state(NR_MAPPED));
 	printk(KERN_INFO "%lu pages slab\n", global_page_state(NR_SLAB));
-	printk(KERN_INFO "%lu pages pagetables\n", ps.nr_page_table_pages);
+	printk(KERN_INFO "%lu pages pagetables\n", global_page_state(NR_PAGETABLE));
 }
 
 /*
