Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbVLJA4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbVLJA4H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 19:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbVLJAzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 19:55:42 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:39645 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932589AbVLJAzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 19:55:16 -0500
Date: Fri, 9 Dec 2005 16:55:12 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210005511.3887.82080.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com>
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 6/6] Make nr_pagecache a per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The nr_page_table_pages counter is currently implemented as a counter
split per cpu. nr_page_table_pages has therefore currently meaning as a
counter of the page table pages in the system as a whole.

This patch switches the counter to use a zone based couter. It is then
possible to determine how many pages in a zone are used for page tables.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5/mm/memory.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/memory.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/mm/memory.c	2005-12-09 16:33:00.000000000 -0800
@@ -116,7 +116,7 @@ static void free_pte_range(struct mmu_ga
 	pmd_clear(pmd);
 	pte_lock_deinit(page);
 	pte_free_tlb(tlb, page);
-	dec_page_state(nr_page_table_pages);
+	dec_zone_page_state(page_zone(page), NR_PAGETABLE);
 	tlb->mm->nr_ptes--;
 }
 
@@ -302,7 +302,7 @@ int __pte_alloc(struct mm_struct *mm, pm
 		pte_free(new);
 	} else {
 		mm->nr_ptes++;
-		inc_page_state(nr_page_table_pages);
+		inc_zone_page_state(page_zone(new), NR_PAGETABLE);
 		pmd_populate(mm, pmd, new);
 	}
 	spin_unlock(&mm->page_table_lock);
Index: linux-2.6.15-rc5/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/page_alloc.c	2005-12-09 16:32:57.000000000 -0800
+++ linux-2.6.15-rc5/mm/page_alloc.c	2005-12-09 16:33:00.000000000 -0800
@@ -556,7 +556,7 @@ static int rmqueue_bulk(struct zone *zon
 	return allocated;
 }
 
-char *stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache", "slab" };
+char *stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache", "slab", "pagetable" };
 
 /*
  * Manage combined zone based / global counters
@@ -1432,7 +1432,7 @@ void show_free_areas(void)
 		nr_free_pages(),
 		global_page_state(NR_SLAB),
 		global_page_state(NR_MAPPED),
-		ps.nr_page_table_pages);
+		global_page_state(NR_PAGETABLE));
 
 	for_each_zone(zone) {
 		int i;
Index: linux-2.6.15-rc5/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/page-flags.h	2005-12-09 16:32:57.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/page-flags.h	2005-12-09 16:33:00.000000000 -0800
@@ -84,8 +84,7 @@ struct page_state {
 	unsigned long nr_dirty;		/* Dirty writeable pages */
 	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
-	unsigned long nr_page_table_pages;/* Pages used for pagetables */
-#define GET_PAGE_STATE_LAST nr_page_table_pages
+#define GET_PAGE_STATE_LAST nr_unstable
 
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
Index: linux-2.6.15-rc5/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/mmzone.h	2005-12-09 16:32:57.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/mmzone.h	2005-12-09 16:33:00.000000000 -0800
@@ -44,8 +44,8 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
-enum zone_stat_item { NR_MAPPED, NR_PAGECACHE, NR_SLAB };
-#define NR_STAT_ITEMS 3
+enum zone_stat_item { NR_MAPPED, NR_PAGECACHE, NR_SLAB, NR_PAGETABLE };
+#define NR_STAT_ITEMS 4
 
 /*
  * A hacky way of defining atomic long. Remove when
Index: linux-2.6.15-rc5/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/proc/proc_misc.c	2005-12-09 16:32:57.000000000 -0800
+++ linux-2.6.15-rc5/fs/proc/proc_misc.c	2005-12-09 16:33:00.000000000 -0800
@@ -194,7 +194,7 @@ static int meminfo_read_proc(char *page,
 		K(global_page_state(NR_SLAB)),
 		K(allowed),
 		K(committed),
-		K(ps.nr_page_table_pages),
+		K(global_page_state(NR_PAGETABLE)),
 		(unsigned long)VMALLOC_TOTAL >> 10,
 		vmi.used >> 10,
 		vmi.largest_chunk >> 10
Index: linux-2.6.15-rc5/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/base/node.c	2005-12-09 16:32:57.000000000 -0800
+++ linux-2.6.15-rc5/drivers/base/node.c	2005-12-09 16:33:00.000000000 -0800
@@ -57,8 +57,6 @@ static ssize_t node_read_meminfo(struct 
 		ps.nr_dirty = 0;
 	if ((long)ps.nr_writeback < 0)
 		ps.nr_writeback = 0;
-	if ((long)ps.nr_slab < 0)
-		ps.nr_slab = 0;
 
 	n = sprintf(buf, "\n"
 		       "Node %d MemTotal:     %8lu kB\n"
