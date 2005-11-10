Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVKJVzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVKJVzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVKJVzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:55:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:26811 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932105AbVKJVzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:55:11 -0500
Date: Thu, 10 Nov 2005 13:55:01 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
cc: Con Kolivas <kernel@kolivas.org>, alokk@calsoftinc.com
Subject: [RFC, PATCH] Slab counter troubles with swap prefetch?
Message-ID: <Pine.LNX.4.62.0511101351120.16380@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the slab allocator uses a page_state counter called nr_slab.
The VM swap prefetch code assumes that this describes the number of pages
used on a node by the slab allocator. However, that is not really true.

Currently nr_slab is the number of total pages allocated which may
be local or remote pages. Remote allocations may artificially inflate
nr_slab and therefore disable swap prefetching.

This patch splits the counter into the nr_local_slab which reflects
slab pages allocated from the local zones (and this number is useful
at least as a guidance for the VM) and the remotely allocated pages. 

However, there is currently no counter reflecting the number of pages
used in a zone/node for the slab although the proc statistics give
an impression otherwise.

We cannot update counters from other nodes since these counters are per cpu.
A counter could be put into struct zone however that would require to
take a spinlock for each update.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm1/mm/slab.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/slab.c	2005-11-10 12:59:49.000000000 -0800
+++ linux-2.6.14-mm1/mm/slab.c	2005-11-10 13:00:11.000000000 -0800
@@ -1201,7 +1201,12 @@ static void *kmem_getpages(kmem_cache_t 
 	i = (1 << cachep->gfporder);
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
 		atomic_add(i, &slab_reclaim_pages);
-	add_page_state(nr_slab, i);
+
+	if (page_to_nid(page) == numa_node_id())
+		add_page_state(nr_local_slab, i);
+	else
+		add_page_state(nr_remote_slab, i);
+
 	while (i--) {
 		SetPageSlab(page);
 		page++;
@@ -1223,7 +1228,10 @@ static void kmem_freepages(kmem_cache_t 
 			BUG();
 		page++;
 	}
-	sub_page_state(nr_slab, nr_freed);
+	if (page_to_nid(page) == numa_node_id())
+		sub_page_state(nr_local_slab, nr_freed);
+	else
+		sub_page_state(nr_remote_slab, nr_freed);
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += nr_freed;
 	free_pages((unsigned long)addr, cachep->gfporder);
Index: linux-2.6.14-mm1/drivers/base/node.c
===================================================================
--- linux-2.6.14-mm1.orig/drivers/base/node.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-mm1/drivers/base/node.c	2005-11-10 13:00:11.000000000 -0800
@@ -55,8 +55,10 @@ static ssize_t node_read_meminfo(struct 
 		ps.nr_writeback = 0;
 	if ((long)ps.nr_mapped < 0)
 		ps.nr_mapped = 0;
-	if ((long)ps.nr_slab < 0)
-		ps.nr_slab = 0;
+	if ((long)ps.nr_local_slab < 0)
+		ps.nr_local_slab = 0;
+	if ((long)ps.nr_remote_slab < 0)
+		ps.nr_remote_slab = 0;
 
 	n = sprintf(buf, "\n"
 		       "Node %d MemTotal:     %8lu kB\n"
@@ -71,7 +73,8 @@ static ssize_t node_read_meminfo(struct 
 		       "Node %d Dirty:        %8lu kB\n"
 		       "Node %d Writeback:    %8lu kB\n"
 		       "Node %d Mapped:       %8lu kB\n"
-		       "Node %d Slab:         %8lu kB\n",
+		       "Node %d LocalSlab:    %8lu kB\n"
+		       "Node %d RemoteSlab:   %8lu kB\n",
 		       nid, K(i.totalram),
 		       nid, K(i.freeram),
 		       nid, K(i.totalram - i.freeram),
@@ -84,7 +87,8 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(ps.nr_dirty),
 		       nid, K(ps.nr_writeback),
 		       nid, K(ps.nr_mapped),
-		       nid, K(ps.nr_slab));
+		       nid, K(ps.nr_local_slab),
+		       nid, K(ps.nr_remote_slab));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
 }
Index: linux-2.6.14-mm1/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.14-mm1.orig/fs/proc/proc_misc.c	2005-11-09 10:47:35.000000000 -0800
+++ linux-2.6.14-mm1/fs/proc/proc_misc.c	2005-11-10 13:00:11.000000000 -0800
@@ -168,7 +168,8 @@ static int meminfo_read_proc(char *page,
 		"Dirty:        %8lu kB\n"
 		"Writeback:    %8lu kB\n"
 		"Mapped:       %8lu kB\n"
-		"Slab:         %8lu kB\n"
+		"LocalSlab:    %8lu kB\n"
+		"RemoteSlab:   %8lu kB\n"
 		"CommitLimit:  %8lu kB\n"
 		"Committed_AS: %8lu kB\n"
 		"PageTables:   %8lu kB\n"
@@ -191,7 +192,8 @@ static int meminfo_read_proc(char *page,
 		K(ps.nr_dirty),
 		K(ps.nr_writeback),
 		K(ps.nr_mapped),
-		K(ps.nr_slab),
+		K(ps.nr_local_slab),
+		K(ps.nr_remote_slab),
 		K(allowed),
 		K(committed),
 		K(ps.nr_page_table_pages),
Index: linux-2.6.14-mm1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/swap_prefetch.c	2005-11-10 11:33:03.000000000 -0800
+++ linux-2.6.14-mm1/mm/swap_prefetch.c	2005-11-10 13:00:11.000000000 -0800
@@ -327,7 +327,7 @@ static int prefetch_suitable(void)
 	 * >2/3 of the ram is mapped or swapcache, we need some free for
 	 * pagecache
 	 */
-	limit = ps.nr_mapped + ps.nr_slab + pending_writes +
+	limit = ps.nr_mapped + ps.nr_local_slab + pending_writes +
 		total_swapcache_pages;
 	if (limit > mapped_limit)
 		goto out;
Index: linux-2.6.14-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/page_alloc.c	2005-11-09 10:47:37.000000000 -0800
+++ linux-2.6.14-mm1/mm/page_alloc.c	2005-11-10 13:00:11.000000000 -0800
@@ -1423,14 +1423,15 @@ void show_free_areas(void)
 		K(nr_free_highpages()));
 
 	printk("Active:%lu inactive:%lu dirty:%lu writeback:%lu "
-		"unstable:%lu free:%u slab:%lu mapped:%lu pagetables:%lu\n",
+		"unstable:%lu free:%u localslab:%lu remoteslab:%lu mapped:%lu pagetables:%lu\n",
 		active,
 		inactive,
 		ps.nr_dirty,
 		ps.nr_writeback,
 		ps.nr_unstable,
 		nr_free_pages(),
-		ps.nr_slab,
+		ps.nr_local_slab,
+		ps.nr_remote_slab,
 		ps.nr_mapped,
 		ps.nr_page_table_pages);
 
@@ -2312,7 +2313,8 @@ static char *vmstat_text[] = {
 	"nr_unstable",
 	"nr_page_table_pages",
 	"nr_mapped",
-	"nr_slab",
+	"nr_local_slab",
+	"nr_remote_slab",
 
 	"pgpgin",
 	"pgpgout",
Index: linux-2.6.14-mm1/include/linux/page-flags.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/page-flags.h	2005-11-09 10:47:29.000000000 -0800
+++ linux-2.6.14-mm1/include/linux/page-flags.h	2005-11-10 13:00:11.000000000 -0800
@@ -87,8 +87,9 @@ struct page_state {
 	unsigned long nr_unstable;	/* NFS unstable pages */
 	unsigned long nr_page_table_pages;/* Pages used for pagetables */
 	unsigned long nr_mapped;	/* mapped into pagetables */
-	unsigned long nr_slab;		/* In slab */
-#define GET_PAGE_STATE_LAST nr_slab
+	unsigned long nr_local_slab;	/* local slab pages */
+	unsigned long nr_remote_slab;	/* remote slab pages */
+#define GET_PAGE_STATE_LAST nr_remote_slab
 
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
