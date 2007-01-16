Return-Path: <linux-kernel-owner+w=401wt.eu-S932404AbXAPFtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbXAPFtc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 00:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbXAPFtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 00:49:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58785 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932402AbXAPFs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 00:48:27 -0500
Date: Mon, 15 Jan 2007 21:48:19 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Paul Menage <menage@google.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>, Christoph Lameter <clameter@sgi.com>
Message-Id: <20070116054819.15358.37282.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 7/8] Exclude unreclaimable pages from dirty ration calculation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Consider unreclaimable pages during dirty limit calculation

Tracking unreclaimable pages helps us to calculate the dirty ratio
the right way. If a large number of unreclaimable pages are allocated
(through the slab or through huge pages) then write throttling will
no longer work since the limit cannot be reached anymore.

So we simply subtract the number of unreclaimable pages from the pages
considered for writeout threshold calculation.

Other code that allocates significant amounts of memory for device
drivers etc could also be modified to take advantage of this functionality.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.20-rc5/include/linux/mmzone.h
===================================================================
--- linux-2.6.20-rc5.orig/include/linux/mmzone.h	2007-01-12 12:54:26.000000000 -0600
+++ linux-2.6.20-rc5/include/linux/mmzone.h	2007-01-15 21:37:37.579950696 -0600
@@ -53,6 +53,7 @@ enum zone_stat_item {
 	NR_FILE_PAGES,
 	NR_SLAB_RECLAIMABLE,
 	NR_SLAB_UNRECLAIMABLE,
+	NR_UNRECLAIMABLE,
 	NR_PAGETABLE,	/* used for pagetables */
 	NR_FILE_DIRTY,
 	NR_WRITEBACK,
Index: linux-2.6.20-rc5/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.20-rc5.orig/fs/proc/proc_misc.c	2007-01-12 12:54:26.000000000 -0600
+++ linux-2.6.20-rc5/fs/proc/proc_misc.c	2007-01-15 21:37:37.641479580 -0600
@@ -174,6 +174,7 @@ static int meminfo_read_proc(char *page,
 		"Slab:         %8lu kB\n"
 		"SReclaimable: %8lu kB\n"
 		"SUnreclaim:   %8lu kB\n"
+		"Unreclaimabl: %8lu kB\n"
 		"PageTables:   %8lu kB\n"
 		"NFS_Unstable: %8lu kB\n"
 		"Bounce:       %8lu kB\n"
@@ -205,6 +206,7 @@ static int meminfo_read_proc(char *page,
 				global_page_state(NR_SLAB_UNRECLAIMABLE)),
 		K(global_page_state(NR_SLAB_RECLAIMABLE)),
 		K(global_page_state(NR_SLAB_UNRECLAIMABLE)),
+		K(global_page_state(NR_UNRECLAIMABLE)),
 		K(global_page_state(NR_PAGETABLE)),
 		K(global_page_state(NR_UNSTABLE_NFS)),
 		K(global_page_state(NR_BOUNCE)),
Index: linux-2.6.20-rc5/mm/hugetlb.c
===================================================================
--- linux-2.6.20-rc5.orig/mm/hugetlb.c	2007-01-12 12:54:26.000000000 -0600
+++ linux-2.6.20-rc5/mm/hugetlb.c	2007-01-15 21:37:37.664919155 -0600
@@ -115,6 +115,8 @@ static int alloc_fresh_huge_page(void)
 		nr_huge_pages_node[page_to_nid(page)]++;
 		spin_unlock(&hugetlb_lock);
 		put_page(page); /* free it into the hugepage allocator */
+		mod_zone_page_state(page_zone(page), NR_UNRECLAIMABLE,
+					HPAGE_SIZE / PAGE_SIZE);
 		return 1;
 	}
 	return 0;
@@ -183,6 +185,8 @@ static void update_and_free_page(struct 
 				1 << PG_dirty | 1 << PG_active | 1 << PG_reserved |
 				1 << PG_private | 1<< PG_writeback);
 	}
+	mod_zone_page_state(page_zone(page), NR_UNRECLAIMABLE,
+					- (HPAGE_SIZE / PAGE_SIZE));
 	page[1].lru.next = NULL;
 	set_page_refcounted(page);
 	__free_pages(page, HUGETLB_PAGE_ORDER);
Index: linux-2.6.20-rc5/mm/vmstat.c
===================================================================
--- linux-2.6.20-rc5.orig/mm/vmstat.c	2007-01-12 12:54:26.000000000 -0600
+++ linux-2.6.20-rc5/mm/vmstat.c	2007-01-15 21:37:37.686405431 -0600
@@ -459,6 +459,7 @@ static const char * const vmstat_text[] 
 	"nr_file_pages",
 	"nr_slab_reclaimable",
 	"nr_slab_unreclaimable",
+	"nr_unreclaimable",
 	"nr_page_table_pages",
 	"nr_dirty",
 	"nr_writeback",
Index: linux-2.6.20-rc5/mm/page-writeback.c
===================================================================
--- linux-2.6.20-rc5.orig/mm/page-writeback.c	2007-01-15 21:37:33.302228293 -0600
+++ linux-2.6.20-rc5/mm/page-writeback.c	2007-01-15 21:37:37.697148570 -0600
@@ -165,7 +165,9 @@ get_dirty_limits(struct dirty_limits *dl
 			dl->nr_writeback +=
 				node_page_state(node, NR_WRITEBACK);
 			available_memory +=
-				NODE_DATA(node)->node_present_pages;
+				NODE_DATA(node)->node_present_pages
+				- node_page_state(node, NR_UNRECLAIMABLE)
+				- node_page_state(node, NR_SLAB_UNRECLAIMABLE);
 #ifdef CONFIG_HIGHMEM
 			high_memory += NODE_DATA(node)
 				->node_zones[ZONE_HIGHMEM]->present_pages;
@@ -180,7 +182,9 @@ get_dirty_limits(struct dirty_limits *dl
 		dl->nr_dirty = global_page_state(NR_FILE_DIRTY);
 		dl->nr_unstable = global_page_state(NR_UNSTABLE_NFS);
 		dl->nr_writeback = global_page_state(NR_WRITEBACK);
-		available_memory = vm_total_pages;
+		available_memory = vm_total_pages
+				- global_page_state(NR_UNRECLAIMABLE)
+				- global_page_state(NR_SLAB_UNRECLAIMABLE);
 		high_memory = totalhigh_pages;
 		nr_mapped = global_page_state(NR_FILE_MAPPED) +
 				global_page_state(NR_ANON_PAGES);
Index: linux-2.6.20-rc5/drivers/base/node.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/base/node.c	2007-01-12 12:54:26.000000000 -0600
+++ linux-2.6.20-rc5/drivers/base/node.c	2007-01-15 21:37:37.759654103 -0600
@@ -70,7 +70,8 @@ static ssize_t node_read_meminfo(struct 
 		       "Node %d Bounce:       %8lu kB\n"
 		       "Node %d Slab:         %8lu kB\n"
 		       "Node %d SReclaimable: %8lu kB\n"
-		       "Node %d SUnreclaim:   %8lu kB\n",
+		       "Node %d SUnreclaim:   %8lu kB\n"
+		       "Node %d Unreclaimabl: %8lu kB\n",
 		       nid, K(i.totalram),
 		       nid, K(i.freeram),
 		       nid, K(i.totalram - i.freeram),
@@ -93,7 +94,8 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(node_page_state(nid, NR_SLAB_RECLAIMABLE) +
 				node_page_state(nid, NR_SLAB_UNRECLAIMABLE)),
 		       nid, K(node_page_state(nid, NR_SLAB_RECLAIMABLE)),
-		       nid, K(node_page_state(nid, NR_SLAB_UNRECLAIMABLE)));
+		       nid, K(node_page_state(nid, NR_SLAB_UNRECLAIMABLE)),
+		       nid, K(node_page_state(nid, NR_UNRECLAIMABLE)));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
 }
