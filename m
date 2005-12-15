Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbVLOAd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbVLOAd0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbVLOAdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:33:24 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58002 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932660AbVLOAcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:32:55 -0500
Date: Wed, 14 Dec 2005 16:32:55 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>
Message-Id: <20051215003253.31788.21991.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051215003151.31788.8755.sendpatchset@schroedinger.engr.sgi.com>
References: <20051215003151.31788.8755.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC3 12/14] Convert nr_unstable
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per zone unstable pages

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm2/mm/swap_prefetch.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/swap_prefetch.c	2005-12-14 15:35:38.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/swap_prefetch.c	2005-12-14 15:37:43.000000000 -0800
@@ -319,7 +319,7 @@ static int prefetch_suitable(void)
 		goto out;
 
 	/* Delay prefetching if we have significant amounts of dirty data */
-	pending_writes = global_page_state(NR_DIRTY) + ps.nr_unstable;
+	pending_writes = global_page_state(NR_DIRTY) + global_page_state(NR_UNSTABLE);
 	if (pending_writes > SWAP_CLUSTER_MAX)
 		goto out;
 
Index: linux-2.6.15-rc5-mm2/fs/fs-writeback.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/fs/fs-writeback.c	2005-12-14 15:34:57.000000000 -0800
+++ linux-2.6.15-rc5-mm2/fs/fs-writeback.c	2005-12-14 15:37:43.000000000 -0800
@@ -471,7 +471,7 @@ void sync_inodes_sb(struct super_block *
 		.sync_mode	= wait ? WB_SYNC_ALL : WB_SYNC_HOLD,
 	};
 	unsigned long nr_dirty = global_page_state(NR_DIRTY);
-	unsigned long nr_unstable = read_page_state(nr_unstable);
+	unsigned long nr_unstable = global_page_state(NR_UNSTABLE);
 
 	wbc.nr_to_write = nr_dirty + nr_unstable +
 			(inodes_stat.nr_inodes - inodes_stat.nr_unused) +
Index: linux-2.6.15-rc5-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/page_alloc.c	2005-12-14 15:37:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/page_alloc.c	2005-12-14 15:37:54.000000000 -0800
@@ -597,7 +597,8 @@ static int rmqueue_bulk(struct zone *zon
 }
 
 char *stat_item_descr[NR_STAT_ITEMS] = {
-	"mapped","pagecache", "slab", "pagetable", "dirty", "writeback"
+	"mapped","pagecache", "slab", "pagetable", "dirty", "writeback",
+	"unstable"
 };
 
 /*
@@ -1781,7 +1782,7 @@ void show_free_areas(void)
 		inactive,
 		global_page_state(NR_DIRTY),
 		global_page_state(NR_WRITEBACK),
-		ps.nr_unstable,
+		global_page_state(NR_UNSTABLE),
 		nr_free_pages(),
 		global_page_state(NR_SLAB),
 		global_page_state(NR_MAPPED),
Index: linux-2.6.15-rc5-mm2/fs/nfs/write.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/fs/nfs/write.c	2005-12-14 15:34:57.000000000 -0800
+++ linux-2.6.15-rc5-mm2/fs/nfs/write.c	2005-12-14 15:37:43.000000000 -0800
@@ -474,7 +474,7 @@ nfs_mark_request_commit(struct nfs_page 
 	nfs_list_add_request(req, &nfsi->commit);
 	nfsi->ncommit++;
 	spin_unlock(&nfsi->req_lock);
-	inc_page_state(nr_unstable);
+	inc_zone_page_state(req->wb_page, NR_UNSTABLE);
 	mark_inode_dirty(inode);
 }
 #endif
@@ -1272,7 +1272,6 @@ void nfs_commit_done(struct rpc_task *ta
 {
 	struct nfs_write_data	*data = calldata;
 	struct nfs_page		*req;
-	int res = 0;
 
         dprintk("NFS: %4d nfs_commit_done (status %d)\n",
                                 task->tk_pid, task->tk_status);
@@ -1306,9 +1305,8 @@ void nfs_commit_done(struct rpc_task *ta
 		nfs_mark_request_dirty(req);
 	next:
 		nfs_clear_page_writeback(req);
-		res++;
+		dec_zone_page_state(req->wb_page, NR_UNSTABLE);
 	}
-	sub_page_state(nr_unstable,res);
 }
 #endif
 
Index: linux-2.6.15-rc5-mm2/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/page-flags.h	2005-12-14 15:35:38.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/page-flags.h	2005-12-14 15:37:43.000000000 -0800
@@ -82,8 +82,7 @@
  * allowed.
  */
 struct page_state {
-	unsigned long nr_unstable;	/* NFS unstable pages */
-#define GET_PAGE_STATE_LAST nr_unstable
+#define GET_PAGE_STATE_LAST xxx
 
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
Index: linux-2.6.15-rc5-mm2/mm/page-writeback.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/page-writeback.c	2005-12-14 15:35:38.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/page-writeback.c	2005-12-14 15:37:43.000000000 -0800
@@ -110,7 +110,7 @@ struct writeback_state
 static void get_writeback_state(struct writeback_state *wbs)
 {
 	wbs->nr_dirty = global_page_state(NR_DIRTY);
-	wbs->nr_unstable = read_page_state(nr_unstable);
+	wbs->nr_unstable = global_page_state(NR_UNSTABLE);
 	wbs->nr_mapped = global_page_state(NR_MAPPED);
 	wbs->nr_writeback = global_page_state(NR_WRITEBACK);
 }
Index: linux-2.6.15-rc5-mm2/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/mmzone.h	2005-12-14 15:35:38.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/mmzone.h	2005-12-14 15:37:43.000000000 -0800
@@ -44,8 +44,8 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
-enum zone_stat_item { NR_MAPPED, NR_PAGECACHE, NR_SLAB, NR_PAGETABLE, NR_DIRTY, NR_WRITEBACK };
-#define NR_STAT_ITEMS 6
+enum zone_stat_item { NR_MAPPED, NR_PAGECACHE, NR_SLAB, NR_PAGETABLE, NR_DIRTY, NR_WRITEBACK, NR_UNSTABLE };
+#define NR_STAT_ITEMS 7
 
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
