Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVLTWFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVLTWFL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbVLTWDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:03:04 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:8131 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932176AbVLTWC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:02:58 -0500
Date: Tue, 20 Dec 2005 14:02:53 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20051220220253.30326.67968.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
References: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
Subject: Zoned counters V1 [12/14]: Convert nr_bounce
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per zone unstable pages

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm3/fs/fs-writeback.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/fs/fs-writeback.c	2005-12-20 12:58:54.000000000 -0800
+++ linux-2.6.15-rc5-mm3/fs/fs-writeback.c	2005-12-20 12:59:17.000000000 -0800
@@ -471,7 +471,7 @@ void sync_inodes_sb(struct super_block *
 		.sync_mode	= wait ? WB_SYNC_ALL : WB_SYNC_HOLD,
 	};
 	unsigned long nr_dirty = global_page_state(NR_DIRTY);
-	unsigned long nr_unstable = read_page_state(nr_unstable);
+	unsigned long nr_unstable = global_page_state(NR_UNSTABLE);
 
 	wbc.nr_to_write = nr_dirty + nr_unstable +
 			(inodes_stat.nr_inodes - inodes_stat.nr_unused) +
Index: linux-2.6.15-rc5-mm3/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/page_alloc.c	2005-12-20 12:59:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/page_alloc.c	2005-12-20 12:59:40.000000000 -0800
@@ -598,7 +598,8 @@ static int rmqueue_bulk(struct zone *zon
 }
 
 char *stat_item_descr[NR_STAT_ITEMS] = {
-	"mapped","pagecache", "slab", "pagetable", "dirty", "writeback"
+	"mapped","pagecache", "slab", "pagetable", "dirty", "writeback",
+	"unstable"
 };
 
 /*
@@ -1784,7 +1785,7 @@ void show_free_areas(void)
 		inactive,
 		global_page_state(NR_DIRTY),
 		global_page_state(NR_WRITEBACK),
-		ps.nr_unstable,
+		global_page_state(NR_UNSTABLE),
 		nr_free_pages(),
 		global_page_state(NR_SLAB),
 		global_page_state(NR_MAPPED),
@@ -2683,10 +2684,9 @@ static char *vmstat_text[] = {
 	"nr_page_table_pages",
 	"nr_dirty",
 	"nr_writeback",
-
-	/* Page state */
 	"nr_unstable",
 
+	/* Page state */
 	"pgpgin",
 	"pgpgout",
 	"pswpin",
Index: linux-2.6.15-rc5-mm3/fs/nfs/write.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/fs/nfs/write.c	2005-12-20 12:58:54.000000000 -0800
+++ linux-2.6.15-rc5-mm3/fs/nfs/write.c	2005-12-20 12:59:17.000000000 -0800
@@ -489,7 +489,7 @@ nfs_mark_request_commit(struct nfs_page 
 	nfs_list_add_request(req, &nfsi->commit);
 	nfsi->ncommit++;
 	spin_unlock(&nfsi->req_lock);
-	inc_page_state(nr_unstable);
+	inc_zone_page_state(req->wb_page, NR_UNSTABLE);
 	mark_inode_dirty(inode);
 }
 #endif
@@ -1287,7 +1287,6 @@ void nfs_commit_done(struct rpc_task *ta
 {
 	struct nfs_write_data	*data = calldata;
 	struct nfs_page		*req;
-	int res = 0;
 
         dprintk("NFS: %4d nfs_commit_done (status %d)\n",
                                 task->tk_pid, task->tk_status);
@@ -1321,9 +1320,8 @@ void nfs_commit_done(struct rpc_task *ta
 		nfs_mark_request_dirty(req);
 	next:
 		nfs_clear_page_writeback(req);
-		res++;
+		dec_zone_page_state(req->wb_page, NR_UNSTABLE);
 	}
-	sub_page_state(nr_unstable,res);
 }
 #endif
 
Index: linux-2.6.15-rc5-mm3/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/page-flags.h	2005-12-20 12:59:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/page-flags.h	2005-12-20 12:59:17.000000000 -0800
@@ -91,8 +91,7 @@
  * In this case, the field should be commented here.
  */
 struct page_state {
-	unsigned long nr_unstable;	/* NFS unstable pages */
-#define GET_PAGE_STATE_LAST nr_unstable
+#define GET_PAGE_STATE_LAST xxx
 
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
Index: linux-2.6.15-rc5-mm3/mm/page-writeback.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/page-writeback.c	2005-12-20 12:59:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/page-writeback.c	2005-12-20 12:59:17.000000000 -0800
@@ -110,7 +110,7 @@ struct writeback_state
 static void get_writeback_state(struct writeback_state *wbs)
 {
 	wbs->nr_dirty = global_page_state(NR_DIRTY);
-	wbs->nr_unstable = read_page_state(nr_unstable);
+	wbs->nr_unstable = global_page_state(NR_UNSTABLE);
 	wbs->nr_mapped = global_page_state(NR_MAPPED);
 	wbs->nr_writeback = global_page_state(NR_WRITEBACK);
 }
Index: linux-2.6.15-rc5-mm3/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/mmzone.h	2005-12-20 12:59:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/mmzone.h	2005-12-20 12:59:17.000000000 -0800
@@ -52,6 +52,7 @@ enum zone_stat_item {
 	NR_PAGETABLE,	/* used for pagetables */
 	NR_DIRTY,
 	NR_WRITEBACK,
+	NR_UNSTABLE,	/* NFS unstable pages */
 	NR_STAT_ITEMS };
 
 #ifdef CONFIG_SMP
Index: linux-2.6.15-rc5-mm3/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/drivers/base/node.c	2005-12-20 12:59:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/drivers/base/node.c	2005-12-20 12:59:17.000000000 -0800
@@ -65,6 +65,7 @@ static ssize_t node_read_meminfo(struct 
 		       "Node %d LowFree:      %8lu kB\n"
 		       "Node %d Dirty:        %8lu kB\n"
 		       "Node %d Writeback:    %8lu kB\n"
+		       "Node %d Unstable:     %8lu kB\n"
 		       "Node %d Mapped:       %8lu kB\n"
 		       "Node %d Pagecache:    %8lu kB\n"
 		       "Node %d Slab:         %8lu kB\n",
@@ -79,6 +80,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.freeram - i.freehigh),
 		       nid, K(nr[NR_DIRTY]),
 		       nid, K(nr[NR_WRITEBACK]),
+		       nid, K(nr[NR_UNSTABLE]),
 		       nid, K(nr[NR_MAPPED]),
 		       nid, K(nr[NR_PAGECACHE]),
 		       nid, K(nr[NR_SLAB]));
