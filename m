Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWFLVSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWFLVSJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWFLVOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:14:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59311 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932290AbWFLVOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:14:00 -0400
Date: Mon, 12 Jun 2006 14:13:52 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060612211352.20862.13019.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 13/21] Conversion of nr_dirty to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: zoned vm counters: conversion of nr_dirty to per zone counter
From: Christoph Lameter <clameter@sgi.com>

This makes nr_dirty a per zone counter.  Looping over all processors is
avoided during writeback state determination.

The counter aggregation for nr_dirty had to be undone in the NFS layer since
we summed up the page counts from multiple zones.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/arch/i386/mm/pgtable.c	2006-06-12 13:02:33.254836674 -0700
+++ linux-2.6.17-rc6-cl/arch/i386/mm/pgtable.c	2006-06-12 13:02:52.201905469 -0700
@@ -59,7 +59,7 @@ void show_mem(void)
 	printk(KERN_INFO "%d pages swap cached\n", cached);
 
 	get_page_state(&ps);
-	printk(KERN_INFO "%lu pages dirty\n", ps.nr_dirty);
+	printk(KERN_INFO "%lu pages dirty\n", global_page_state(NR_DIRTY));
 	printk(KERN_INFO "%lu pages writeback\n", ps.nr_writeback);
 	printk(KERN_INFO "%lu pages mapped\n", global_page_state(NR_MAPPED));
 	printk(KERN_INFO "%lu pages slab\n", global_page_state(NR_SLAB));
Index: linux-2.6.17-rc6-cl/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/drivers/base/node.c	2006-06-12 13:02:33.261672188 -0700
+++ linux-2.6.17-rc6-cl/drivers/base/node.c	2006-06-12 13:02:52.202881971 -0700
@@ -50,8 +50,6 @@ static ssize_t node_read_meminfo(struct 
 	__get_zone_counts(&active, &inactive, &free, NODE_DATA(nid));
 
 	/* Check for negative values in these approximate counters */
-	if ((long)ps.nr_dirty < 0)
-		ps.nr_dirty = 0;
 	if ((long)ps.nr_writeback < 0)
 		ps.nr_writeback = 0;
 
@@ -81,7 +79,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.freehigh),
 		       nid, K(i.totalram - i.totalhigh),
 		       nid, K(i.freeram - i.freehigh),
-		       nid, K(ps.nr_dirty),
+		       nid, K(node_page_state(nid, NR_DIRTY)),
 		       nid, K(ps.nr_writeback),
 		       nid, K(node_page_state(nid, NR_PAGECACHE)),
 		       nid, K(node_page_state(nid, NR_MAPPED)),
Index: linux-2.6.17-rc6-cl/fs/buffer.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/buffer.c	2006-06-12 12:42:47.348762564 -0700
+++ linux-2.6.17-rc6-cl/fs/buffer.c	2006-06-12 13:02:52.204834975 -0700
@@ -854,7 +854,7 @@ int __set_page_dirty_buffers(struct page
 		write_lock_irq(&mapping->tree_lock);
 		if (page->mapping) {	/* Race with truncate? */
 			if (mapping_cap_account_dirty(mapping))
-				inc_page_state(nr_dirty);
+				__inc_zone_page_state(page, NR_DIRTY);
 			radix_tree_tag_set(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
Index: linux-2.6.17-rc6-cl/fs/fs-writeback.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/fs-writeback.c	2006-06-12 12:42:47.502073390 -0700
+++ linux-2.6.17-rc6-cl/fs/fs-writeback.c	2006-06-12 13:02:52.204834975 -0700
@@ -472,7 +472,7 @@ void sync_inodes_sb(struct super_block *
 		.range_start	= 0,
 		.range_end	= LLONG_MAX,
 	};
-	unsigned long nr_dirty = read_page_state(nr_dirty);
+	unsigned long nr_dirty = global_page_state(NR_DIRTY);
 	unsigned long nr_unstable = read_page_state(nr_unstable);
 
 	wbc.nr_to_write = nr_dirty + nr_unstable +
Index: linux-2.6.17-rc6-cl/fs/nfs/pagelist.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/nfs/pagelist.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-cl/fs/nfs/pagelist.c	2006-06-12 13:02:52.205811477 -0700
@@ -315,6 +315,7 @@ nfs_scan_lock_dirty(struct nfs_inode *nf
 						req->wb_index, NFS_PAGE_TAG_DIRTY);
 				nfs_list_remove_request(req);
 				nfs_list_add_request(req, dst);
+				inc_zone_page_state(req->wb_page, NR_DIRTY);
 				res++;
 			}
 		}
Index: linux-2.6.17-rc6-cl/fs/nfs/write.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/nfs/write.c	2006-06-12 12:42:48.111410682 -0700
+++ linux-2.6.17-rc6-cl/fs/nfs/write.c	2006-06-12 13:02:52.206787979 -0700
@@ -497,7 +497,7 @@ nfs_mark_request_dirty(struct nfs_page *
 	nfs_list_add_request(req, &nfsi->dirty);
 	nfsi->ndirty++;
 	spin_unlock(&nfsi->req_lock);
-	inc_page_state(nr_dirty);
+	inc_zone_page_state(req->wb_page, NR_DIRTY);
 	mark_inode_dirty(inode);
 }
 
@@ -598,7 +598,6 @@ nfs_scan_dirty(struct inode *inode, stru
 	if (nfsi->ndirty != 0) {
 		res = nfs_scan_lock_dirty(nfsi, dst, idx_start, npages);
 		nfsi->ndirty -= res;
-		sub_page_state(nr_dirty,res);
 		if ((nfsi->ndirty == 0) != list_empty(&nfsi->dirty))
 			printk(KERN_ERR "NFS: desynchronized value of nfs_i.ndirty.\n");
 	}
Index: linux-2.6.17-rc6-cl/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/proc/proc_misc.c	2006-06-12 13:02:33.256789678 -0700
+++ linux-2.6.17-rc6-cl/fs/proc/proc_misc.c	2006-06-12 13:02:52.207764481 -0700
@@ -190,7 +190,7 @@ static int meminfo_read_proc(char *page,
 		K(i.freeram-i.freehigh),
 		K(i.totalswap),
 		K(i.freeswap),
-		K(ps.nr_dirty),
+		K(global_page_state(NR_DIRTY)),
 		K(ps.nr_writeback),
 		K(global_page_state(NR_ANON)),
 		K(global_page_state(NR_MAPPED)),
Index: linux-2.6.17-rc6-cl/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-12 13:02:33.257766180 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-12 13:02:52.209717485 -0700
@@ -53,6 +53,7 @@ enum zone_stat_item {
 	NR_PAGECACHE,
 	NR_SLAB,	/* Pages used by slab allocator */
 	NR_PAGETABLE,	/* used for pagetables */
+	NR_DIRTY,
 	NR_STAT_ITEMS };
 
 struct per_cpu_pages {
Index: linux-2.6.17-rc6-cl/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page_alloc.c	2006-06-12 13:02:33.260695686 -0700
+++ linux-2.6.17-rc6-cl/mm/page_alloc.c	2006-06-12 13:02:52.210693987 -0700
@@ -1404,7 +1404,7 @@ void show_free_areas(void)
 		"unstable:%lu free:%u slab:%lu mapped:%lu pagetables:%lu\n",
 		active,
 		inactive,
-		ps.nr_dirty,
+		global_page_state(NR_DIRTY),
 		ps.nr_writeback,
 		ps.nr_unstable,
 		nr_free_pages(),
Index: linux-2.6.17-rc6-cl/mm/page-writeback.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page-writeback.c	2006-06-12 13:01:30.625902765 -0700
+++ linux-2.6.17-rc6-cl/mm/page-writeback.c	2006-06-12 13:02:52.211670489 -0700
@@ -109,7 +109,7 @@ struct writeback_state
 
 static void get_writeback_state(struct writeback_state *wbs)
 {
-	wbs->nr_dirty = read_page_state(nr_dirty);
+	wbs->nr_dirty = global_page_state(NR_DIRTY);
 	wbs->nr_unstable = read_page_state(nr_unstable);
 	wbs->nr_mapped = global_page_state(NR_MAPPED) +
 				global_page_state(NR_ANON);
@@ -641,7 +641,7 @@ int __set_page_dirty_nobuffers(struct pa
 			if (mapping2) { /* Race with truncate? */
 				BUG_ON(mapping2 != mapping);
 				if (mapping_cap_account_dirty(mapping))
-					inc_page_state(nr_dirty);
+					__inc_zone_page_state(page, NR_DIRTY);
 				radix_tree_tag_set(&mapping->page_tree,
 					page_index(page), PAGECACHE_TAG_DIRTY);
 			}
@@ -728,9 +728,9 @@ int test_clear_page_dirty(struct page *p
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
-			write_unlock_irqrestore(&mapping->tree_lock, flags);
 			if (mapping_cap_account_dirty(mapping))
-				dec_page_state(nr_dirty);
+				__dec_zone_page_state(page, NR_DIRTY);
+			write_unlock_irqrestore(&mapping->tree_lock, flags);
 			return 1;
 		}
 		write_unlock_irqrestore(&mapping->tree_lock, flags);
@@ -761,7 +761,7 @@ int clear_page_dirty_for_io(struct page 
 	if (mapping) {
 		if (TestClearPageDirty(page)) {
 			if (mapping_cap_account_dirty(mapping))
-				dec_page_state(nr_dirty);
+				dec_zone_page_state(page, NR_DIRTY);
 			return 1;
 		}
 		return 0;
Index: linux-2.6.17-rc6-cl/mm/vmstat.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmstat.c	2006-06-12 13:02:46.391718420 -0700
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-12 13:02:58.922192406 -0700
@@ -468,9 +468,9 @@ static char *vmstat_text[] = {
 	"nr_anon",
 	"nr_slab",
 	"nr_page_table_pages",
+	"nr_dirty",
 
 	/* Page state */
-	"nr_dirty",
 	"nr_writeback",
 	"nr_unstable",
 
