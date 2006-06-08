Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbWFHXF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWFHXF5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbWFHXF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:05:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62139 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965063AbWFHXDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:03:46 -0400
Date: Thu, 8 Jun 2006 16:03:36 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060608230336.25121.13494.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 11/14] Conversion of nr_unstable to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion of nr_unstable to a per zone counter

Avoids looping over processor to establish writeback state.

This converts the last critical page state for the VM and therefore
GET_PAGE_STATE_LAST becomes invalid. The next patch is needed to
make the kernel compile again.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/fs/fs-writeback.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/fs-writeback.c	2006-06-08 15:46:37.440287688 -0700
+++ linux-2.6.17-rc6-mm1/fs/fs-writeback.c	2006-06-08 15:47:46.620574179 -0700
@@ -473,7 +473,7 @@ void sync_inodes_sb(struct super_block *
 		.range_end	= LLONG_MAX,
 	};
 	unsigned long nr_dirty = global_page_state(NR_DIRTY);
-	unsigned long nr_unstable = read_page_state(nr_unstable);
+	unsigned long nr_unstable = global_page_state(NR_UNSTABLE);
 
 	wbc.nr_to_write = nr_dirty + nr_unstable +
 			(inodes_stat.nr_inodes - inodes_stat.nr_unused) +
Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-08 15:46:56.905879204 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-08 15:47:46.622527183 -0700
@@ -629,7 +629,8 @@ static int rmqueue_bulk(struct zone *zon
 }
 
 char *vm_stat_item_descr[NR_STAT_ITEMS] = {
-	 "mapped", "pagecache", "slab", "pagetable", "dirty", "writeback"
+	"mapped", "pagecache", "slab", "pagetable", "dirty", "writeback",
+	"unstable"
 };
 
 /*
@@ -1810,7 +1811,7 @@ void show_free_areas(void)
 		inactive,
 		global_page_state(NR_DIRTY),
 		global_page_state(NR_WRITEBACK),
-		ps.nr_unstable,
+		global_page_state(NR_UNSTABLE),
 		nr_free_pages(),
 		global_page_state(NR_SLAB),
 		global_page_state(NR_MAPPED),
@@ -2810,10 +2811,9 @@ static char *vmstat_text[] = {
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
Index: linux-2.6.17-rc6-mm1/fs/nfs/write.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/nfs/write.c	2006-06-08 15:46:37.445170199 -0700
+++ linux-2.6.17-rc6-mm1/fs/nfs/write.c	2006-06-08 15:47:46.624480187 -0700
@@ -525,7 +525,7 @@ nfs_mark_request_commit(struct nfs_page 
 	nfs_list_add_request(req, &nfsi->commit);
 	nfsi->ncommit++;
 	spin_unlock(&nfsi->req_lock);
-	inc_page_state(nr_unstable);
+	inc_zone_page_state(req->wb_page, NR_UNSTABLE);
 	mark_inode_dirty(inode);
 }
 #endif
@@ -1382,7 +1382,6 @@ static void nfs_commit_done(struct rpc_t
 {
 	struct nfs_write_data	*data = calldata;
 	struct nfs_page		*req;
-	int res = 0;
 
         dprintk("NFS: %4d nfs_commit_done (status %d)\n",
                                 task->tk_pid, task->tk_status);
@@ -1420,9 +1419,8 @@ static void nfs_commit_done(struct rpc_t
 		nfs_mark_request_dirty(req);
 	next:
 		nfs_clear_page_writeback(req);
-		res++;
+		dec_zone_page_state(req->wb_page, NR_UNSTABLE);
 	}
-	sub_page_state(nr_unstable,res);
 }
 
 static const struct rpc_call_ops nfs_commit_ops = {
Index: linux-2.6.17-rc6-mm1/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/page-flags.h	2006-06-08 15:46:56.906855706 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/page-flags.h	2006-06-08 15:47:46.624480187 -0700
@@ -119,8 +119,7 @@
  * commented here.
  */
 struct page_state {
-	unsigned long nr_unstable;	/* NFS unstable pages */
-#define GET_PAGE_STATE_LAST nr_unstable
+#define GET_PAGE_STATE_LAST xxx
 
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
Index: linux-2.6.17-rc6-mm1/mm/page-writeback.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page-writeback.c	2006-06-08 15:46:56.907832208 -0700
+++ linux-2.6.17-rc6-mm1/mm/page-writeback.c	2006-06-08 15:47:46.625456689 -0700
@@ -110,7 +110,7 @@ struct writeback_state
 static void get_writeback_state(struct writeback_state *wbs)
 {
 	wbs->nr_dirty = global_page_state(NR_DIRTY);
-	wbs->nr_unstable = read_page_state(nr_unstable);
+	wbs->nr_unstable = global_page_state(NR_UNSTABLE);
 	wbs->nr_mapped = global_page_state(NR_MAPPED);
 	wbs->nr_writeback = global_page_state(NR_WRITEBACK);
 }
Index: linux-2.6.17-rc6-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/mmzone.h	2006-06-08 15:46:56.908808710 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/mmzone.h	2006-06-08 15:47:46.626433191 -0700
@@ -54,6 +54,7 @@ enum zone_stat_item {
 	NR_PAGETABLE,	/* used for pagetables */
 	NR_DIRTY,
 	NR_WRITEBACK,
+	NR_UNSTABLE,	/* NFS unstable pages */
 	NR_STAT_ITEMS };
 
 #ifdef CONFIG_SMP
Index: linux-2.6.17-rc6-mm1/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/drivers/base/node.c	2006-06-08 15:46:56.901973196 -0700
+++ linux-2.6.17-rc6-mm1/drivers/base/node.c	2006-06-08 15:47:46.627409693 -0700
@@ -66,6 +66,7 @@ static ssize_t node_read_meminfo(struct 
 		       "Node %d LowFree:      %8lu kB\n"
 		       "Node %d Dirty:        %8lu kB\n"
 		       "Node %d Writeback:    %8lu kB\n"
+		       "Node %d Unstable:     %8lu kB\n"
 		       "Node %d Mapped:       %8lu kB\n"
 		       "Node %d Pagecache:    %8lu kB\n"
 		       "Node %d Slab:         %8lu kB\n",
@@ -80,6 +81,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.freeram - i.freehigh),
 		       nid, K(nr[NR_DIRTY]),
 		       nid, K(nr[NR_WRITEBACK]),
+		       nid, K(nr[NR_UNSTABLE]),
 		       nid, K(nr[NR_MAPPED]),
 		       nid, K(nr[NR_PAGECACHE]),
 		       nid, K(nr[NR_SLAB]));
Index: linux-2.6.17-rc6-mm1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/swap_prefetch.c	2006-06-08 15:46:56.908808710 -0700
+++ linux-2.6.17-rc6-mm1/mm/swap_prefetch.c	2006-06-08 15:47:46.627409693 -0700
@@ -397,7 +397,8 @@ static int prefetch_suitable(void)
 		limit = global_page_state(NR_MAPPED) +
 			global_page_state(NR_SLAB) +
 			global_page_state(NR_DIRTY) +
-			ps.nr_unstable + total_swapcache_pages;
+			global_page_state(NR_UNSTABLE) +
+			total_swapcache_pages;
 		if (limit > ns->prefetch_watermark) {
 			node_clear(node, sp_stat.prefetch_nodes);
 			continue;
