Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbVLOASK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbVLOASK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbVLOAP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:15:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:45193 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932641AbVLOAPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:15:21 -0500
Date: Wed, 14 Dec 2005 16:15:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051215001507.31405.66859.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051215001415.31405.24898.sendpatchset@schroedinger.engr.sgi.com>
References: <20051215001415.31405.24898.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC3 10/14] Convert nr_dirty
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert nr_dirty to zoned counter

This makes nr_dirty a per zone counter, so that we can determine the number of
dirty pages per node etc.

The counter aggregation for nr_dirty had to be undone in the NFS layer since
it summed up the pages from multiple zones.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/page_alloc.c	2005-12-14 15:29:46.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/page_alloc.c	2005-12-14 15:35:34.000000000 -0800
@@ -596,7 +596,9 @@ static int rmqueue_bulk(struct zone *zon
 	return i;
 }
 
-char *stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache", "slab", "pagetable" };
+char *stat_item_descr[NR_STAT_ITEMS] = {
+	"mapped","pagecache", "slab", "pagetable", "dirty"
+};
 
 /*
  * Manage combined zone based / global counters
@@ -1777,7 +1779,7 @@ void show_free_areas(void)
 		"unstable:%lu free:%u slab:%lu mapped:%lu pagetables:%lu\n",
 		active,
 		inactive,
-		ps.nr_dirty,
+		global_page_state(NR_DIRTY),
 		ps.nr_writeback,
 		ps.nr_unstable,
 		nr_free_pages(),
Index: linux-2.6.15-rc5-mm2/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/page-flags.h	2005-12-14 15:29:46.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/page-flags.h	2005-12-14 15:34:57.000000000 -0800
@@ -82,7 +82,6 @@
  * allowed.
  */
 struct page_state {
-	unsigned long nr_dirty;		/* Dirty writeable pages */
 	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
 #define GET_PAGE_STATE_LAST nr_unstable
Index: linux-2.6.15-rc5-mm2/mm/page-writeback.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/page-writeback.c	2005-12-14 14:57:29.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/page-writeback.c	2005-12-14 15:34:57.000000000 -0800
@@ -109,7 +109,7 @@ struct writeback_state
 
 static void get_writeback_state(struct writeback_state *wbs)
 {
-	wbs->nr_dirty = read_page_state(nr_dirty);
+	wbs->nr_dirty = global_page_state(NR_DIRTY);
 	wbs->nr_unstable = read_page_state(nr_unstable);
 	wbs->nr_mapped = global_page_state(NR_MAPPED);
 	wbs->nr_writeback = read_page_state(nr_writeback);
@@ -632,7 +632,7 @@ int __set_page_dirty_nobuffers(struct pa
 			if (mapping2) { /* Race with truncate? */
 				BUG_ON(mapping2 != mapping);
 				if (mapping_cap_account_dirty(mapping))
-					inc_page_state(nr_dirty);
+					__inc_zone_page_state(page, NR_DIRTY);
 				radix_tree_tag_set(&mapping->page_tree,
 					page_index(page), PAGECACHE_TAG_DIRTY);
 			}
@@ -716,9 +716,9 @@ int test_clear_page_dirty(struct page *p
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
@@ -749,7 +749,7 @@ int clear_page_dirty_for_io(struct page 
 	if (mapping) {
 		if (TestClearPageDirty(page)) {
 			if (mapping_cap_account_dirty(mapping))
-				dec_page_state(nr_dirty);
+				dec_zone_page_state(page, NR_DIRTY);
 			return 1;
 		}
 		return 0;
Index: linux-2.6.15-rc5-mm2/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/mmzone.h	2005-12-14 15:29:46.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/mmzone.h	2005-12-14 15:34:57.000000000 -0800
@@ -44,8 +44,8 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
-enum zone_stat_item { NR_MAPPED, NR_PAGECACHE, NR_SLAB, NR_PAGETABLE };
-#define NR_STAT_ITEMS 4
+enum zone_stat_item { NR_MAPPED, NR_PAGECACHE, NR_SLAB, NR_PAGETABLE, NR_DIRTY };
+#define NR_STAT_ITEMS 5
 
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
Index: linux-2.6.15-rc5-mm2/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/drivers/base/node.c	2005-12-14 15:29:46.000000000 -0800
+++ linux-2.6.15-rc5-mm2/drivers/base/node.c	2005-12-14 15:34:57.000000000 -0800
@@ -53,8 +53,6 @@ static ssize_t node_read_meminfo(struct 
 		nr[j] = node_page_state(nid, j);
 
 	/* Check for negative values in these approximate counters */
-	if ((long)ps.nr_dirty < 0)
-		ps.nr_dirty = 0;
 	if ((long)ps.nr_writeback < 0)
 		ps.nr_writeback = 0;
 
@@ -82,7 +80,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.freehigh),
 		       nid, K(i.totalram - i.totalhigh),
 		       nid, K(i.freeram - i.freehigh),
-		       nid, K(ps.nr_dirty),
+		       nid, K(nr[NR_DIRTY]),
 		       nid, K(ps.nr_writeback),
 		       nid, K(nr[NR_MAPPED]),
 		       nid, K(nr[NR_PAGECACHE]),
Index: linux-2.6.15-rc5-mm2/fs/fs-writeback.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/fs/fs-writeback.c	2005-12-12 09:10:33.000000000 -0800
+++ linux-2.6.15-rc5-mm2/fs/fs-writeback.c	2005-12-14 15:34:57.000000000 -0800
@@ -470,7 +470,7 @@ void sync_inodes_sb(struct super_block *
 	struct writeback_control wbc = {
 		.sync_mode	= wait ? WB_SYNC_ALL : WB_SYNC_HOLD,
 	};
-	unsigned long nr_dirty = read_page_state(nr_dirty);
+	unsigned long nr_dirty = global_page_state(NR_DIRTY);
 	unsigned long nr_unstable = read_page_state(nr_unstable);
 
 	wbc.nr_to_write = nr_dirty + nr_unstable +
Index: linux-2.6.15-rc5-mm2/fs/buffer.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/fs/buffer.c	2005-12-13 20:41:05.000000000 -0800
+++ linux-2.6.15-rc5-mm2/fs/buffer.c	2005-12-14 15:34:57.000000000 -0800
@@ -857,7 +857,7 @@ int __set_page_dirty_buffers(struct page
 		write_lock_irq(&mapping->tree_lock);
 		if (page->mapping) {	/* Race with truncate? */
 			if (mapping_cap_account_dirty(mapping))
-				inc_page_state(nr_dirty);
+				__inc_zone_page_state(page, NR_DIRTY);
 			radix_tree_tag_set(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
Index: linux-2.6.15-rc5-mm2/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/fs/proc/proc_misc.c	2005-12-14 15:29:46.000000000 -0800
+++ linux-2.6.15-rc5-mm2/fs/proc/proc_misc.c	2005-12-14 15:34:57.000000000 -0800
@@ -188,7 +188,7 @@ static int meminfo_read_proc(char *page,
 		K(i.freeram-i.freehigh),
 		K(i.totalswap),
 		K(i.freeswap),
-		K(ps.nr_dirty),
+		K(global_page_state(NR_DIRTY)),
 		K(ps.nr_writeback),
 		K(global_page_state(NR_MAPPED)),
 		K(global_page_state(NR_SLAB)),
Index: linux-2.6.15-rc5-mm2/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/i386/mm/pgtable.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5-mm2/arch/i386/mm/pgtable.c	2005-12-14 15:34:57.000000000 -0800
@@ -59,7 +59,7 @@ void show_mem(void)
 	printk(KERN_INFO "%d pages swap cached\n", cached);
 
 	get_page_state(&ps);
-	printk(KERN_INFO "%lu pages dirty\n", ps.nr_dirty);
+	printk(KERN_INFO "%lu pages dirty\n", global_page_state(NR_DIRTY));
 	printk(KERN_INFO "%lu pages writeback\n", ps.nr_writeback);
 	printk(KERN_INFO "%lu pages mapped\n", ps.nr_mapped);
 	printk(KERN_INFO "%lu pages slab\n", ps.nr_slab);
Index: linux-2.6.15-rc5-mm2/fs/reiser4/page_cache.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/fs/reiser4/page_cache.c	2005-12-12 09:10:33.000000000 -0800
+++ linux-2.6.15-rc5-mm2/fs/reiser4/page_cache.c	2005-12-14 15:34:57.000000000 -0800
@@ -470,7 +470,7 @@ int set_page_dirty_internal(struct page 
 
 	if (!TestSetPageDirty(page)) {
 		if (mapping_cap_account_dirty(mapping))
-			inc_page_state(nr_dirty);
+			inc_zone_page_state(page, NR_DIRTY);
 
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
Index: linux-2.6.15-rc5-mm2/fs/nfs/write.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/fs/nfs/write.c	2005-12-12 09:10:33.000000000 -0800
+++ linux-2.6.15-rc5-mm2/fs/nfs/write.c	2005-12-14 15:34:57.000000000 -0800
@@ -446,7 +446,7 @@ nfs_mark_request_dirty(struct nfs_page *
 	nfs_list_add_request(req, &nfsi->dirty);
 	nfsi->ndirty++;
 	spin_unlock(&nfsi->req_lock);
-	inc_page_state(nr_dirty);
+	inc_zone_page_state(req->wb_page, NR_DIRTY);
 	mark_inode_dirty(inode);
 }
 
@@ -539,7 +539,6 @@ nfs_scan_dirty(struct inode *inode, stru
 	if (nfsi->ndirty != 0) {
 		res = nfs_scan_lock_dirty(nfsi, dst, idx_start, npages);
 		nfsi->ndirty -= res;
-		sub_page_state(nr_dirty,res);
 		if ((nfsi->ndirty == 0) != list_empty(&nfsi->dirty))
 			printk(KERN_ERR "NFS: desynchronized value of nfs_i.ndirty.\n");
 	}
Index: linux-2.6.15-rc5-mm2/fs/reiser4/emergency_flush.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/fs/reiser4/emergency_flush.c	2005-12-12 09:10:33.000000000 -0800
+++ linux-2.6.15-rc5-mm2/fs/reiser4/emergency_flush.c	2005-12-14 15:34:57.000000000 -0800
@@ -740,7 +740,7 @@ void eflush_del(jnode * node, int page_l
 	if (!TestSetPageDirty(page)) {
 		BUG_ON(jnode_get_mapping(node) != page->mapping);
 		if (mapping_cap_account_dirty(page->mapping))
-			inc_page_state(nr_dirty);
+			inc_zone_page_state(page, NR_DIRTY);
 	}
 
 	assert("nikita-2766", atomic_read(&node->x_count) > 1);
Index: linux-2.6.15-rc5-mm2/fs/reiser4/as_ops.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/fs/reiser4/as_ops.c	2005-12-12 09:10:33.000000000 -0800
+++ linux-2.6.15-rc5-mm2/fs/reiser4/as_ops.c	2005-12-14 15:34:57.000000000 -0800
@@ -84,7 +84,7 @@ int reiser4_set_page_dirty(struct page *
 			if (page->mapping) {
 				assert("vs-1652", page->mapping == mapping);
 				if (mapping_cap_account_dirty(mapping))
-					inc_page_state(nr_dirty);
+					__inc_zone_page_state(page, NR_DIRTY);
 				radix_tree_tag_set(&mapping->page_tree,
 						   page->index,
 						   PAGECACHE_TAG_REISER4_MOVED);
Index: linux-2.6.15-rc5-mm2/mm/swap_prefetch.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/swap_prefetch.c	2005-12-14 15:29:13.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/swap_prefetch.c	2005-12-14 15:34:57.000000000 -0800
@@ -319,7 +319,7 @@ static int prefetch_suitable(void)
 		goto out;
 
 	/* Delay prefetching if we have significant amounts of dirty data */
-	pending_writes = ps.nr_dirty + ps.nr_unstable;
+	pending_writes = global_page_state(NR_DIRTY) + ps.nr_unstable;
 	if (pending_writes > SWAP_CLUSTER_MAX)
 		goto out;
 
Index: linux-2.6.15-rc5-mm2/fs/nfs/pagelist.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/fs/nfs/pagelist.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5-mm2/fs/nfs/pagelist.c	2005-12-14 15:34:57.000000000 -0800
@@ -309,6 +309,7 @@ nfs_scan_lock_dirty(struct nfs_inode *nf
 						req->wb_index, NFS_PAGE_TAG_DIRTY);
 				nfs_list_remove_request(req);
 				nfs_list_add_request(req, dst);
+				inc_zone_page_state(req->wb_page, NR_DIRTY);
 				res++;
 			}
 		}
