Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWGXSLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWGXSLn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 14:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWGXSLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 14:11:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17645 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932267AbWGXSLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 14:11:41 -0400
Date: Mon, 24 Jul 2006 11:11:21 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Rik van Riel <riel@redhat.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: inactive-clean list
In-Reply-To: <44C30E33.2090402@redhat.com>
Message-ID: <Pine.LNX.4.64.0607241109190.25634@schroedinger.engr.sgi.com>
References: <1153167857.31891.78.camel@lappy> <44C30E33.2090402@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2006, Rik van Riel wrote:

> This patch makes it possible to implement Martin Schwidefsky's
> hypervisor-based fast page reclaiming for architectures without
> millicode - ie. Xen, UML and all other non-s390 architectures.
> 
> That could be a big help in heavily loaded virtualized environments.
> 
> The fact that it helps prevent the iSCSI memory deadlock is a
> huge bonus too, of course :)

I think there may be a way with less changes to the way the VM functions 
to get there:


Add NR_MAPPED_DIRTY and functions to determine easily reclaimable pages.

This patch adds a new counter NR_MAPPED_DIRTY. It tracks the number of
dirty mapped pages. With such a counter we can determine
the number of unmapped clean file backed pages and possibly
use that knowledge to enforce limits in the VM.

Add some new functions:

global_dirty()		= Amount of dirty pages in the system as a whole
zone_dirty(zone)	= Amount of dirty pages in a specific zone

global_easily_reclaimable() = Amount of clean unmapped pages
			(for now. We may want to add other categories later
			if we can track more page categories).

zone_easily_reclaimable(zone) = Amount of clean unmapped pages in a zone.


I plan to add later:

global_reclaimable()/zone_reclaimable(zone)

This would be the number of pages that are reclaimable at all regardless
of the effort to be expended:

So this would be

NR_MAPPED + NR_ANON - NR_UNSTABLE_NFS - <mlocked pages> - <pinned pages>


Patch under development. This is just the basis for a discussion.

Other patches could add /proc limits after this one to guarantee
that a certain number of pages is easily reclaimable and so on.


Index: linux-2.6.18-rc1/drivers/base/node.c
===================================================================
--- linux-2.6.18-rc1.orig/drivers/base/node.c	2006-07-05 21:09:49.000000000 -0700
+++ linux-2.6.18-rc1/drivers/base/node.c	2006-07-24 10:54:41.667670873 -0700
@@ -58,10 +58,11 @@ static ssize_t node_read_meminfo(struct 
 		       "Node %d HighFree:     %8lu kB\n"
 		       "Node %d LowTotal:     %8lu kB\n"
 		       "Node %d LowFree:      %8lu kB\n"
-		       "Node %d Dirty:        %8lu kB\n"
 		       "Node %d Writeback:    %8lu kB\n"
 		       "Node %d FilePages:    %8lu kB\n"
+		       "Node %d Dirty:        %8lu kB\n"
 		       "Node %d Mapped:       %8lu kB\n"
+		       "Node %d DirtyMapped:  %8lu kB\n"
 		       "Node %d AnonPages:    %8lu kB\n"
 		       "Node %d PageTables:   %8lu kB\n"
 		       "Node %d NFS Unstable: %8lu kB\n"
@@ -76,10 +77,11 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.freehigh),
 		       nid, K(i.totalram - i.totalhigh),
 		       nid, K(i.freeram - i.freehigh),
-		       nid, K(node_page_state(nid, NR_FILE_DIRTY)),
 		       nid, K(node_page_state(nid, NR_WRITEBACK)),
 		       nid, K(node_page_state(nid, NR_FILE_PAGES)),
+		       nid, K(node_page_state(nid, NR_FILE_DIRTY)),
 		       nid, K(node_page_state(nid, NR_FILE_MAPPED)),
+		       nid, K(node_page_state(nid, NR_FILE_MAPPED_DIRTY)),
 		       nid, K(node_page_state(nid, NR_ANON_PAGES)),
 		       nid, K(node_page_state(nid, NR_PAGETABLE)),
 		       nid, K(node_page_state(nid, NR_UNSTABLE_NFS)),
Index: linux-2.6.18-rc1/mm/vmstat.c
===================================================================
--- linux-2.6.18-rc1.orig/mm/vmstat.c	2006-07-05 21:09:49.000000000 -0700
+++ linux-2.6.18-rc1/mm/vmstat.c	2006-07-24 10:47:12.662278615 -0700
@@ -389,6 +389,7 @@ static char *vmstat_text[] = {
 	"nr_slab",
 	"nr_page_table_pages",
 	"nr_dirty",
+	"nr_mapped_dirty",
 	"nr_writeback",
 	"nr_unstable",
 	"nr_bounce",
Index: linux-2.6.18-rc1/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.18-rc1.orig/fs/proc/proc_misc.c	2006-07-05 21:09:49.000000000 -0700
+++ linux-2.6.18-rc1/fs/proc/proc_misc.c	2006-07-24 10:55:12.832732717 -0700
@@ -167,6 +167,7 @@ static int meminfo_read_proc(char *page,
 		"Writeback:    %8lu kB\n"
 		"AnonPages:    %8lu kB\n"
 		"Mapped:       %8lu kB\n"
+		"DirtyMapped:  %8lu kB\n"
 		"Slab:         %8lu kB\n"
 		"PageTables:   %8lu kB\n"
 		"NFS Unstable: %8lu kB\n"
@@ -193,6 +194,7 @@ static int meminfo_read_proc(char *page,
 		K(global_page_state(NR_WRITEBACK)),
 		K(global_page_state(NR_ANON_PAGES)),
 		K(global_page_state(NR_FILE_MAPPED)),
+		K(global_page_state(NR_FILE_MAPPED_DIRTY)),
 		K(global_page_state(NR_SLAB)),
 		K(global_page_state(NR_PAGETABLE)),
 		K(global_page_state(NR_UNSTABLE_NFS)),
Index: linux-2.6.18-rc1/include/linux/vmstat.h
===================================================================
--- linux-2.6.18-rc1.orig/include/linux/vmstat.h	2006-07-05 21:09:49.000000000 -0700
+++ linux-2.6.18-rc1/include/linux/vmstat.h	2006-07-24 10:56:44.912966808 -0700
@@ -212,4 +212,61 @@ static inline void refresh_cpu_vm_stats(
 static inline void refresh_vm_stats(void) { }
 #endif
 
+static inline void inc_zone_page_dirty(struct page *page)
+{
+	inc_zone_page_state(page, NR_FILE_DIRTY);
+	if (page_mapped(page))
+		inc_zone_page_state(page, NR_FILE_MAPPED_DIRTY);
+}
+
+static inline void dec_zone_page_dirty(struct page *page)
+{
+	dec_zone_page_state(page, NR_FILE_DIRTY);
+	if (page_mapped(page))
+		dec_zone_page_state(page, NR_FILE_MAPPED_DIRTY);
+}
+
+static inline void __inc_zone_page_dirty(struct page *page)
+{
+	__inc_zone_page_state(page, NR_FILE_DIRTY);
+	if (page_mapped(page))
+		__inc_zone_page_state(page, NR_FILE_MAPPED_DIRTY);
+}
+
+static inline void __dec_zone_page_dirty(struct page *page)
+{
+	__dec_zone_page_state(page, NR_FILE_DIRTY);
+	if (page_mapped(page))
+		__dec_zone_page_state(page, NR_FILE_MAPPED_DIRTY);
+}
+
+static inline unsigned long global_dirty(void)
+{
+	return global_page_state(NR_UNSTABLE_NFS) +
+		global_page_state(NR_FILE_DIRTY);
+}
+
+static inline unsigned long zone_dirty(struct zone *z)
+{
+	return zone_page_state(z, NR_UNSTABLE_NFS) +
+		zone_page_state(z, NR_FILE_DIRTY);
+}
+
+static inline unsigned long global_easily_reclaimable(void)
+{
+	return (global_page_state(NR_FILE_PAGES) -
+		global_page_state(NR_FILE_MAPPED))
+		/* Unmapped */ - /* Unmapped dirty */
+		(global_page_state(NR_FILE_DIRTY) -
+		global_page_state(NR_FILE_MAPPED_DIRTY));
+}
+
+static inline unsigned long zone_easily_reclaimable(struct zone *z)
+{
+	return (zone_page_state(z, NR_FILE_PAGES) -
+		zone_page_state(z, NR_FILE_MAPPED))
+		/* Unmapped */	- /* Unmapped dirty */
+		(zone_page_state(z, NR_FILE_DIRTY) -
+		zone_page_state(z, NR_FILE_MAPPED_DIRTY));
+}
 #endif /* _LINUX_VMSTAT_H */
Index: linux-2.6.18-rc1/mm/page-writeback.c
===================================================================
--- linux-2.6.18-rc1.orig/mm/page-writeback.c	2006-07-05 21:09:49.000000000 -0700
+++ linux-2.6.18-rc1/mm/page-writeback.c	2006-07-24 10:47:12.666184623 -0700
@@ -191,8 +191,7 @@ static void balance_dirty_pages(struct a
 		};
 
 		get_dirty_limits(&background_thresh, &dirty_thresh, mapping);
-		nr_reclaimable = global_page_state(NR_FILE_DIRTY) +
-					global_page_state(NR_UNSTABLE_NFS);
+		nr_reclaimable = global_dirty();
 		if (nr_reclaimable + global_page_state(NR_WRITEBACK) <=
 			dirty_thresh)
 				break;
@@ -210,8 +209,7 @@ static void balance_dirty_pages(struct a
 			writeback_inodes(&wbc);
 			get_dirty_limits(&background_thresh,
 					 	&dirty_thresh, mapping);
-			nr_reclaimable = global_page_state(NR_FILE_DIRTY) +
-					global_page_state(NR_UNSTABLE_NFS);
+			nr_reclaimable = global_dirty();
 			if (nr_reclaimable +
 				global_page_state(NR_WRITEBACK)
 					<= dirty_thresh)
@@ -328,9 +326,7 @@ static void background_writeout(unsigned
 		long dirty_thresh;
 
 		get_dirty_limits(&background_thresh, &dirty_thresh, NULL);
-		if (global_page_state(NR_FILE_DIRTY) +
-			global_page_state(NR_UNSTABLE_NFS) < background_thresh
-				&& min_pages <= 0)
+		if (global_dirty() < background_thresh && min_pages <= 0)
 			break;
 		wbc.encountered_congestion = 0;
 		wbc.nr_to_write = MAX_WRITEBACK_PAGES;
@@ -354,8 +350,7 @@ static void background_writeout(unsigned
 int wakeup_pdflush(long nr_pages)
 {
 	if (nr_pages == 0)
-		nr_pages = global_page_state(NR_FILE_DIRTY) +
-				global_page_state(NR_UNSTABLE_NFS);
+		nr_pages = global_dirty();
 	return pdflush_operation(background_writeout, nr_pages);
 }
 
@@ -401,8 +396,7 @@ static void wb_kupdate(unsigned long arg
 	oldest_jif = jiffies - dirty_expire_interval;
 	start_jif = jiffies;
 	next_jif = start_jif + dirty_writeback_interval;
-	nr_to_write = global_page_state(NR_FILE_DIRTY) +
-			global_page_state(NR_UNSTABLE_NFS) +
+	nr_to_write = global_dirty() +
 			(inodes_stat.nr_inodes - inodes_stat.nr_unused);
 	while (nr_to_write > 0) {
 		wbc.encountered_congestion = 0;
@@ -624,8 +618,7 @@ int __set_page_dirty_nobuffers(struct pa
 			if (mapping2) { /* Race with truncate? */
 				BUG_ON(mapping2 != mapping);
 				if (mapping_cap_account_dirty(mapping))
-					__inc_zone_page_state(page,
-								NR_FILE_DIRTY);
+					__inc_zone_page_dirty(page);
 				radix_tree_tag_set(&mapping->page_tree,
 					page_index(page), PAGECACHE_TAG_DIRTY);
 			}
@@ -713,7 +706,7 @@ int test_clear_page_dirty(struct page *p
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
 			if (mapping_cap_account_dirty(mapping))
-				__dec_zone_page_state(page, NR_FILE_DIRTY);
+				__dec_zone_page_dirty(page);
 			write_unlock_irqrestore(&mapping->tree_lock, flags);
 			return 1;
 		}
@@ -745,7 +738,7 @@ int clear_page_dirty_for_io(struct page 
 	if (mapping) {
 		if (TestClearPageDirty(page)) {
 			if (mapping_cap_account_dirty(mapping))
-				dec_zone_page_state(page, NR_FILE_DIRTY);
+				dec_zone_page_dirty(page);
 			return 1;
 		}
 		return 0;
Index: linux-2.6.18-rc1/include/linux/mmzone.h
===================================================================
--- linux-2.6.18-rc1.orig/include/linux/mmzone.h	2006-07-05 21:09:49.000000000 -0700
+++ linux-2.6.18-rc1/include/linux/mmzone.h	2006-07-24 10:47:12.667161125 -0700
@@ -54,6 +54,7 @@ enum zone_stat_item {
 	NR_SLAB,	/* Pages used by slab allocator */
 	NR_PAGETABLE,	/* used for pagetables */
 	NR_FILE_DIRTY,
+	NR_FILE_MAPPED_DIRTY,
 	NR_WRITEBACK,
 	NR_UNSTABLE_NFS,	/* NFS unstable pages */
 	NR_BOUNCE,
Index: linux-2.6.18-rc1/mm/vmscan.c
===================================================================
--- linux-2.6.18-rc1.orig/mm/vmscan.c	2006-07-05 21:09:49.000000000 -0700
+++ linux-2.6.18-rc1/mm/vmscan.c	2006-07-24 10:47:12.668137627 -0700
@@ -1600,8 +1600,7 @@ int zone_reclaim(struct zone *zone, gfp_
 	 * if less than a specified percentage of the zone is used by
 	 * unmapped file backed pages.
 	 */
-	if (zone_page_state(zone, NR_FILE_PAGES) -
-	    zone_page_state(zone, NR_FILE_MAPPED) <= zone->min_unmapped_ratio)
+	if (zone_easily_reclaimable(zone) <= zone->min_unmapped_ratio)
 		return 0;
 
 	/*
Index: linux-2.6.18-rc1/fs/fs-writeback.c
===================================================================
--- linux-2.6.18-rc1.orig/fs/fs-writeback.c	2006-07-05 21:09:49.000000000 -0700
+++ linux-2.6.18-rc1/fs/fs-writeback.c	2006-07-24 10:47:12.669114129 -0700
@@ -464,12 +464,9 @@ void sync_inodes_sb(struct super_block *
 		.range_start	= 0,
 		.range_end	= LLONG_MAX,
 	};
-	unsigned long nr_dirty = global_page_state(NR_FILE_DIRTY);
-	unsigned long nr_unstable = global_page_state(NR_UNSTABLE_NFS);
 
-	wbc.nr_to_write = nr_dirty + nr_unstable +
-			(inodes_stat.nr_inodes - inodes_stat.nr_unused) +
-			nr_dirty + nr_unstable;
+	wbc.nr_to_write = 2 * global_dirty() +
+			(inodes_stat.nr_inodes - inodes_stat.nr_unused);
 	wbc.nr_to_write += wbc.nr_to_write / 2;		/* Bit more for luck */
 	spin_lock(&inode_lock);
 	sync_sb_inodes(sb, &wbc);
Index: linux-2.6.18-rc1/fs/buffer.c
===================================================================
--- linux-2.6.18-rc1.orig/fs/buffer.c	2006-07-05 21:09:49.000000000 -0700
+++ linux-2.6.18-rc1/fs/buffer.c	2006-07-24 10:47:12.671067133 -0700
@@ -851,7 +851,7 @@ int __set_page_dirty_buffers(struct page
 		write_lock_irq(&mapping->tree_lock);
 		if (page->mapping) {	/* Race with truncate? */
 			if (mapping_cap_account_dirty(mapping))
-				__inc_zone_page_state(page, NR_FILE_DIRTY);
+				__inc_zone_page_dirty(page);
 			radix_tree_tag_set(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
Index: linux-2.6.18-rc1/fs/nfs/write.c
===================================================================
--- linux-2.6.18-rc1.orig/fs/nfs/write.c	2006-07-05 21:09:49.000000000 -0700
+++ linux-2.6.18-rc1/fs/nfs/write.c	2006-07-24 10:47:12.673020137 -0700
@@ -496,7 +496,7 @@ nfs_mark_request_dirty(struct nfs_page *
 	nfs_list_add_request(req, &nfsi->dirty);
 	nfsi->ndirty++;
 	spin_unlock(&nfsi->req_lock);
-	inc_zone_page_state(req->wb_page, NR_FILE_DIRTY);
+	inc_zone_page_dirty(req->wb_page);
 	mark_inode_dirty(inode);
 }
 
Index: linux-2.6.18-rc1/fs/nfs/pagelist.c
===================================================================
--- linux-2.6.18-rc1.orig/fs/nfs/pagelist.c	2006-07-05 21:09:49.000000000 -0700
+++ linux-2.6.18-rc1/fs/nfs/pagelist.c	2006-07-24 10:47:12.673020137 -0700
@@ -314,7 +314,7 @@ nfs_scan_lock_dirty(struct nfs_inode *nf
 						req->wb_index, NFS_PAGE_TAG_DIRTY);
 				nfs_list_remove_request(req);
 				nfs_list_add_request(req, dst);
-				dec_zone_page_state(req->wb_page, NR_FILE_DIRTY);
+				dec_zone_page_dirty(req->wb_page);
 				res++;
 			}
 		}
Index: linux-2.6.18-rc1/mm/rmap.c
===================================================================
--- linux-2.6.18-rc1.orig/mm/rmap.c	2006-07-05 21:09:49.000000000 -0700
+++ linux-2.6.18-rc1/mm/rmap.c	2006-07-24 10:48:49.418980973 -0700
@@ -498,8 +498,11 @@ void page_add_new_anon_rmap(struct page 
  */
 void page_add_file_rmap(struct page *page)
 {
-	if (atomic_inc_and_test(&page->_mapcount))
+	if (atomic_inc_and_test(&page->_mapcount)) {
 		__inc_zone_page_state(page, NR_FILE_MAPPED);
+		if (PageDirty(page))
+			__inc_zone_page_state(page, NR_FILE_MAPPED_DIRTY);
+	}
 }
 
 /**
@@ -520,6 +523,7 @@ void page_remove_rmap(struct page *page)
 		}
 #endif
 		BUG_ON(page_mapcount(page) < 0);
+
 		/*
 		 * It would be tidy to reset the PageAnon mapping here,
 		 * but that might overwrite a racing page_add_anon_rmap
@@ -529,10 +533,12 @@ void page_remove_rmap(struct page *page)
 		 * Leaving it set also helps swapoff to reinstate ptes
 		 * faster for those pages still in swapcache.
 		 */
-		if (page_test_and_clear_dirty(page))
+		if (page_test_and_clear_dirty(page)) {
+			__dec_zone_page_state(page, NR_FILE_MAPPED_DIRTY);
 			set_page_dirty(page);
+		}
 		__dec_zone_page_state(page,
-				PageAnon(page) ? NR_ANON_PAGES : NR_FILE_MAPPED);
+			PageAnon(page) ? NR_ANON_PAGES : NR_FILE_MAPPED);
 	}
 }
 
