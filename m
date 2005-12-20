Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVLTWGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVLTWGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVLTWGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:06:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:29928 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932165AbVLTWCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:02:37 -0500
Date: Tue, 20 Dec 2005 14:02:32 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20051220220232.30326.40091.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
References: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
Subject: Zoned counters V1 [ 8/14]: Convert nr_page_table
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert nr_page_table_pages

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm3/mm/memory.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/memory.c	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/memory.c	2005-12-20 12:58:31.000000000 -0800
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
Index: linux-2.6.15-rc5-mm3/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/page_alloc.c	2005-12-20 12:58:17.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/page_alloc.c	2005-12-20 12:58:47.000000000 -0800
@@ -597,7 +597,7 @@ static int rmqueue_bulk(struct zone *zon
 	return i;
 }
 
-char *stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache", "slab" };
+char *stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache", "slab", "pagetable" };
 
 /*
  * Manage combined zone based / global counters
@@ -1786,7 +1786,7 @@ void show_free_areas(void)
 		nr_free_pages(),
 		global_page_state(NR_SLAB),
 		global_page_state(NR_MAPPED),
-		ps.nr_page_table_pages);
+		global_page_state(NR_PAGETABLE));
 
 	for_each_zone(zone) {
 		int i;
@@ -2678,12 +2678,12 @@ static char *vmstat_text[] = {
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
Index: linux-2.6.15-rc5-mm3/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/page-flags.h	2005-12-20 12:58:02.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/page-flags.h	2005-12-20 12:58:31.000000000 -0800
@@ -94,8 +94,7 @@ struct page_state {
 	unsigned long nr_dirty;		/* Dirty writeable pages */
 	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
-	unsigned long nr_page_table_pages;/* Pages used for pagetables */
-#define GET_PAGE_STATE_LAST nr_page_table_pages
+#define GET_PAGE_STATE_LAST nr_unstable
 
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
Index: linux-2.6.15-rc5-mm3/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/mmzone.h	2005-12-20 12:58:02.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/mmzone.h	2005-12-20 12:58:31.000000000 -0800
@@ -49,6 +49,7 @@ enum zone_stat_item {
 			   only modified from process context */
 	NR_PAGECACHE,	/* file backed pages */
 	NR_SLAB,	/* used by slab allocator */
+	NR_PAGETABLE,	/* used for pagetables */
 	NR_STAT_ITEMS };
 
 #ifdef CONFIG_SMP
Index: linux-2.6.15-rc5-mm3/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/fs/proc/proc_misc.c	2005-12-20 12:58:02.000000000 -0800
+++ linux-2.6.15-rc5-mm3/fs/proc/proc_misc.c	2005-12-20 12:58:31.000000000 -0800
@@ -194,7 +194,7 @@ static int meminfo_read_proc(char *page,
 		K(global_page_state(NR_SLAB)),
 		K(allowed),
 		K(committed),
-		K(ps.nr_page_table_pages),
+		K(global_page_state(NR_PAGETABLE)),
 		(unsigned long)VMALLOC_TOTAL >> 10,
 		vmi.used >> 10,
 		vmi.largest_chunk >> 10
Index: linux-2.6.15-rc5-mm3/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/drivers/base/node.c	2005-12-20 12:58:02.000000000 -0800
+++ linux-2.6.15-rc5-mm3/drivers/base/node.c	2005-12-20 12:58:31.000000000 -0800
@@ -57,8 +57,6 @@ static ssize_t node_read_meminfo(struct 
 		ps.nr_dirty = 0;
 	if ((long)ps.nr_writeback < 0)
 		ps.nr_writeback = 0;
-	if ((long)ps.nr_slab < 0)
-		ps.nr_slab = 0;
 
 	n = sprintf(buf, "\n"
 		       "Node %d MemTotal:     %8lu kB\n"
