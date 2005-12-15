Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbVLOAej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbVLOAej (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbVLOAcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:32:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:49554 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932649AbVLOAcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:32:39 -0500
Date: Wed, 14 Dec 2005 16:32:38 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>
Message-Id: <20051215003238.31788.86913.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051215003151.31788.8755.sendpatchset@schroedinger.engr.sgi.com>
References: <20051215003151.31788.8755.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC3 09/14] Convert nr_page_table
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The nr_page_table_pages counter is currently implemented as a counter
split per cpu. nr_page_table_pages has therefore currently meaning as a
counter of the page table pages in the system as a whole.

This patch switches the counter to use a zone based couter. It is then
possible to determine how many pages in a zone are used for page tables.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm2/mm/memory.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/memory.c	2005-12-13 15:46:52.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/memory.c	2005-12-14 15:29:46.000000000 -0800
@@ -116,7 +116,7 @@ static void free_pte_range(struct mmu_ga
 	pmd_clear(pmd);
 	pte_lock_deinit(page);
 	pte_free_tlb(tlb, page);
-	dec_page_state(nr_page_table_pages);
+	dec_zone_page_state(page, NR_PAGETABLE);
 	tlb->mm->nr_ptes--;
 }
 
@@ -302,7 +302,7 @@ int __pte_alloc(struct mm_struct *mm, pm
 		pte_free(new);
 	} else {
 		mm->nr_ptes++;
-		inc_page_state(nr_page_table_pages);
+		inc_zone_page_state(new, NR_PAGETABLE);
 		pmd_populate(mm, pmd, new);
 	}
 	spin_unlock(&mm->page_table_lock);
Index: linux-2.6.15-rc5-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/page_alloc.c	2005-12-14 15:29:13.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/page_alloc.c	2005-12-14 15:29:46.000000000 -0800
@@ -596,7 +596,7 @@ static int rmqueue_bulk(struct zone *zon
 	return i;
 }
 
-char *stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache", "slab" };
+char *stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache", "slab", "pagetable" };
 
 /*
  * Manage combined zone based / global counters
@@ -1783,7 +1783,7 @@ void show_free_areas(void)
 		nr_free_pages(),
 		global_page_state(NR_SLAB),
 		global_page_state(NR_MAPPED),
-		ps.nr_page_table_pages);
+		global_page_state(NR_PAGETABLE));
 
 	for_each_zone(zone) {
 		int i;
Index: linux-2.6.15-rc5-mm2/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/page-flags.h	2005-12-14 15:29:13.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/page-flags.h	2005-12-14 15:29:46.000000000 -0800
@@ -85,8 +85,7 @@ struct page_state {
 	unsigned long nr_dirty;		/* Dirty writeable pages */
 	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
-	unsigned long nr_page_table_pages;/* Pages used for pagetables */
-#define GET_PAGE_STATE_LAST nr_page_table_pages
+#define GET_PAGE_STATE_LAST nr_unstable
 
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
Index: linux-2.6.15-rc5-mm2/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/mmzone.h	2005-12-14 15:29:13.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/mmzone.h	2005-12-14 15:29:46.000000000 -0800
@@ -44,8 +44,8 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
-enum zone_stat_item { NR_MAPPED, NR_PAGECACHE, NR_SLAB };
-#define NR_STAT_ITEMS 3
+enum zone_stat_item { NR_MAPPED, NR_PAGECACHE, NR_SLAB, NR_PAGETABLE };
+#define NR_STAT_ITEMS 4
 
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
Index: linux-2.6.15-rc5-mm2/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/fs/proc/proc_misc.c	2005-12-14 15:29:13.000000000 -0800
+++ linux-2.6.15-rc5-mm2/fs/proc/proc_misc.c	2005-12-14 15:29:46.000000000 -0800
@@ -194,7 +194,7 @@ static int meminfo_read_proc(char *page,
 		K(global_page_state(NR_SLAB)),
 		K(allowed),
 		K(committed),
-		K(ps.nr_page_table_pages),
+		K(global_page_state(NR_PAGETABLE)),
 		(unsigned long)VMALLOC_TOTAL >> 10,
 		vmi.used >> 10,
 		vmi.largest_chunk >> 10
Index: linux-2.6.15-rc5-mm2/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/drivers/base/node.c	2005-12-14 15:29:13.000000000 -0800
+++ linux-2.6.15-rc5-mm2/drivers/base/node.c	2005-12-14 15:29:46.000000000 -0800
@@ -57,8 +57,6 @@ static ssize_t node_read_meminfo(struct 
 		ps.nr_dirty = 0;
 	if ((long)ps.nr_writeback < 0)
 		ps.nr_writeback = 0;
-	if ((long)ps.nr_slab < 0)
-		ps.nr_slab = 0;
 
 	n = sprintf(buf, "\n"
 		       "Node %d MemTotal:     %8lu kB\n"
