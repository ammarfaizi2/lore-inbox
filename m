Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWFHXF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWFHXF6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWFHXDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:03:45 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:57057 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965064AbWFHXDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:03:41 -0400
Date: Thu, 8 Jun 2006 16:03:26 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060608230326.25121.49895.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 09/14] Conversion of nr_dirty to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion of nr_dirty to a per zone counter

This makes nr_dirty a per zone counter. Looping over all processors
is avoided during writeback state determination.

The counter aggregation for nr_dirty had to be undone in the NFS layer
since it summed up the page counts from multiple zones.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-08 14:41:12.656973943 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-08 14:41:29.656898506 -0700
@@ -628,7 +628,9 @@ static int rmqueue_bulk(struct zone *zon
 	return i;
 }
 
-char *vm_stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache", "slab", "pagetable" };
+char *vm_stat_item_descr[NR_STAT_ITEMS] = {
+	 "mapped", "pagecache", "slab", "pagetable", "dirty"
+};
 
 /*
  * Manage combined zone based / global counters
@@ -1806,7 +1808,7 @@ void show_free_areas(void)
 		"unstable:%lu free:%u slab:%lu mapped:%lu pagetables:%lu\n",
 		active,
 		inactive,
-		ps.nr_dirty,
+		global_page_state(NR_DIRTY),
 		ps.nr_writeback,
 		ps.nr_unstable,
 		nr_free_pages(),
@@ -2806,9 +2808,9 @@ static char *vmstat_text[] = {
 	"nr_pagecache",
 	"nr_slab",
 	"nr_page_table_pages",
+	"nr_dirty",
 
 	/* Page state */
-	"nr_dirty",
 	"nr_writeback",
 	"nr_unstable",
 
Index: linux-2.6.17-rc6-mm1/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/page-flags.h	2006-06-08 14:41:12.657950445 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/page-flags.h	2006-06-08 14:41:13.609063463 -0700
@@ -119,7 +119,6 @@
  * commented here.
  */
 struct page_state {
-	unsigned long nr_dirty;		/* Dirty writeable pages */
 	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
 #define GET_PAGE_STATE_LAST nr_unstable
Index: linux-2.6.17-rc6-mm1/mm/page-writeback.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page-writeback.c	2006-06-08 14:29:45.935862744 -0700
+++ linux-2.6.17-rc6-mm1/mm/page-writeback.c	2006-06-08 14:41:13.609063463 -0700
@@ -109,7 +109,7 @@ struct writeback_state
 
 static void get_writeback_state(struct writeback_state *wbs)
 {
-	wbs->nr_dirty = read_page_state(nr_dirty);
+	wbs->nr_dirty = global_page_state(NR_DIRTY);
 	wbs->nr_unstable = read_page_state(nr_unstable);
 	wbs->nr_mapped = global_page_state(NR_MAPPED);
 	wbs->nr_writeback = read_page_state(nr_writeback);
@@ -640,7 +640,7 @@ int __set_page_dirty_nobuffers(struct pa
 			if (mapping2) { /* Race with truncate? */
 				BUG_ON(mapping2 != mapping);
 				if (mapping_cap_account_dirty(mapping))
-					inc_page_state(nr_dirty);
+					__inc_zone_page_state(page, NR_DIRTY);
 				radix_tree_tag_set(&mapping->page_tree,
 					page_index(page), PAGECACHE_TAG_DIRTY);
 			}
@@ -727,9 +727,9 @@ int test_clear_page_dirty(struct page *p
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
@@ -760,7 +760,7 @@ int clear_page_dirty_for_io(struct page 
 	if (mapping) {
 		if (TestClearPageDirty(page)) {
 			if (mapping_cap_account_dirty(mapping))
-				dec_page_state(nr_dirty);
+				dec_zone_page_state(page, NR_DIRTY);
 			return 1;
 		}
 		return 0;
Index: linux-2.6.17-rc6-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/mmzone.h	2006-06-08 14:41:12.658926947 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/mmzone.h	2006-06-08 14:41:13.610039965 -0700
@@ -52,6 +52,7 @@ enum zone_stat_item {
 	NR_PAGECACHE,	/* file backed pages */
 	NR_SLAB,	/* used by slab allocator */
 	NR_PAGETABLE,	/* used for pagetables */
+	NR_DIRTY,
 	NR_STAT_ITEMS };
 
 #ifdef CONFIG_SMP
Index: linux-2.6.17-rc6-mm1/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/drivers/base/node.c	2006-06-08 14:41:11.901161340 -0700
+++ linux-2.6.17-rc6-mm1/drivers/base/node.c	2006-06-08 14:41:13.611016467 -0700
@@ -54,8 +54,6 @@ static ssize_t node_read_meminfo(struct 
 		nr[j] = node_page_state(nid, j);
 
 	/* Check for negative values in these approximate counters */
-	if ((long)ps.nr_dirty < 0)
-		ps.nr_dirty = 0;
 	if ((long)ps.nr_writeback < 0)
 		ps.nr_writeback = 0;
 
@@ -83,7 +81,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.freehigh),
 		       nid, K(i.totalram - i.totalhigh),
 		       nid, K(i.freeram - i.freehigh),
-		       nid, K(ps.nr_dirty),
+		       nid, K(nr[NR_DIRTY]),
 		       nid, K(ps.nr_writeback),
 		       nid, K(nr[NR_MAPPED]),
 		       nid, K(nr[NR_PAGECACHE]),
Index: linux-2.6.17-rc6-mm1/fs/fs-writeback.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/fs-writeback.c	2006-06-08 13:03:36.220727022 -0700
+++ linux-2.6.17-rc6-mm1/fs/fs-writeback.c	2006-06-08 14:41:13.611992969 -0700
@@ -472,7 +472,7 @@ void sync_inodes_sb(struct super_block *
 		.range_start	= 0,
 		.range_end	= LLONG_MAX,
 	};
-	unsigned long nr_dirty = read_page_state(nr_dirty);
+	unsigned long nr_dirty = global_page_state(NR_DIRTY);
 	unsigned long nr_unstable = read_page_state(nr_unstable);
 
 	wbc.nr_to_write = nr_dirty + nr_unstable +
Index: linux-2.6.17-rc6-mm1/fs/buffer.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/buffer.c	2006-06-08 13:03:36.036168121 -0700
+++ linux-2.6.17-rc6-mm1/fs/buffer.c	2006-06-08 14:41:13.612969471 -0700
@@ -854,7 +854,7 @@ int __set_page_dirty_buffers(struct page
 		write_lock_irq(&mapping->tree_lock);
 		if (page->mapping) {	/* Race with truncate? */
 			if (mapping_cap_account_dirty(mapping))
-				inc_page_state(nr_dirty);
+				__inc_zone_page_state(page, NR_DIRTY);
 			radix_tree_tag_set(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
Index: linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/proc/proc_misc.c	2006-06-08 14:41:12.659903449 -0700
+++ linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c	2006-06-08 14:41:13.613945973 -0700
@@ -188,7 +188,7 @@ static int meminfo_read_proc(char *page,
 		K(i.freeram-i.freehigh),
 		K(i.totalswap),
 		K(i.freeswap),
-		K(ps.nr_dirty),
+		K(global_page_state(NR_DIRTY)),
 		K(ps.nr_writeback),
 		K(global_page_state(NR_MAPPED)),
 		K(global_page_state(NR_SLAB)),
Index: linux-2.6.17-rc6-mm1/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/arch/i386/mm/pgtable.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-mm1/arch/i386/mm/pgtable.c	2006-06-08 14:41:13.614922475 -0700
@@ -59,7 +59,7 @@ void show_mem(void)
 	printk(KERN_INFO "%d pages swap cached\n", cached);
 
 	get_page_state(&ps);
-	printk(KERN_INFO "%lu pages dirty\n", ps.nr_dirty);
+	printk(KERN_INFO "%lu pages dirty\n", global_page_state(NR_DIRTY));
 	printk(KERN_INFO "%lu pages writeback\n", ps.nr_writeback);
 	printk(KERN_INFO "%lu pages mapped\n", ps.nr_mapped);
 	printk(KERN_INFO "%lu pages slab\n", ps.nr_slab);
Index: linux-2.6.17-rc6-mm1/fs/reiser4/page_cache.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/reiser4/page_cache.c	2006-06-08 13:03:36.616210382 -0700
+++ linux-2.6.17-rc6-mm1/fs/reiser4/page_cache.c	2006-06-08 14:41:13.615898977 -0700
@@ -464,7 +464,7 @@ int set_page_dirty_internal(struct page 
 
 	if (!TestSetPageDirty(page)) {
 		if (mapping_cap_account_dirty(mapping))
-			inc_page_state(nr_dirty);
+			inc_zone_page_state(page, NR_DIRTY);
 
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
Index: linux-2.6.17-rc6-mm1/fs/nfs/write.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/nfs/write.c	2006-06-08 13:03:36.484382596 -0700
+++ linux-2.6.17-rc6-mm1/fs/nfs/write.c	2006-06-08 14:41:13.616875479 -0700
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
Index: linux-2.6.17-rc6-mm1/fs/reiser4/as_ops.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/reiser4/as_ops.c	2006-06-08 13:03:36.524419183 -0700
+++ linux-2.6.17-rc6-mm1/fs/reiser4/as_ops.c	2006-06-08 14:41:13.616875479 -0700
@@ -83,7 +83,7 @@ int reiser4_set_page_dirty(struct page *
 			if (page->mapping) {
 				assert("vs-1652", page->mapping == mapping);
 				if (mapping_cap_account_dirty(mapping))
-					inc_page_state(nr_dirty);
+					__inc_zone_page_state(page, NR_DIRTY);
 				radix_tree_tag_set(&mapping->page_tree,
 						   page->index,
 						   PAGECACHE_TAG_REISER4_MOVED);
Index: linux-2.6.17-rc6-mm1/fs/nfs/pagelist.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/nfs/pagelist.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-mm1/fs/nfs/pagelist.c	2006-06-08 14:41:13.617851982 -0700
@@ -315,6 +315,7 @@ nfs_scan_lock_dirty(struct nfs_inode *nf
 						req->wb_index, NFS_PAGE_TAG_DIRTY);
 				nfs_list_remove_request(req);
 				nfs_list_add_request(req, dst);
+				inc_zone_page_state(req->wb_page, NR_DIRTY);
 				res++;
 			}
 		}
Index: linux-2.6.17-rc6-mm1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/swap_prefetch.c	2006-06-08 14:41:11.908973356 -0700
+++ linux-2.6.17-rc6-mm1/mm/swap_prefetch.c	2006-06-08 14:41:13.617851982 -0700
@@ -396,7 +396,7 @@ static int prefetch_suitable(void)
 		 */
 		limit = global_page_state(NR_MAPPED) +
 			global_page_state(NR_SLAB) +
-			ps.nr_dirty +
+			global_page_state(NR_DIRTY) +
 			ps.nr_unstable + total_swapcache_pages;
 		if (limit > ns->prefetch_watermark) {
 			node_clear(node, sp_stat.prefetch_nodes);
