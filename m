Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932667AbVLOAdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbVLOAdV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbVLOAcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:32:54 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:29621 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932660AbVLOAct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:32:49 -0500
Date: Wed, 14 Dec 2005 16:32:48 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>
Message-Id: <20051215003248.31788.8200.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051215003151.31788.8755.sendpatchset@schroedinger.engr.sgi.com>
References: <20051215003151.31788.8755.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC3 11/14] Convert nr_writeback
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per zone page writeback counts

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm2/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/drivers/base/node.c	2005-12-14 15:34:57.000000000 -0800
+++ linux-2.6.15-rc5-mm2/drivers/base/node.c	2005-12-14 15:35:38.000000000 -0800
@@ -52,9 +52,6 @@ static ssize_t node_read_meminfo(struct 
 	for (j = 0; j < NR_STAT_ITEMS; j++)
 		nr[j] = node_page_state(nid, j);
 
-	/* Check for negative values in these approximate counters */
-	if ((long)ps.nr_writeback < 0)
-		ps.nr_writeback = 0;
 
 	n = sprintf(buf, "\n"
 		       "Node %d MemTotal:     %8lu kB\n"
@@ -81,7 +78,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.totalram - i.totalhigh),
 		       nid, K(i.freeram - i.freehigh),
 		       nid, K(nr[NR_DIRTY]),
-		       nid, K(ps.nr_writeback),
+		       nid, K(nr[NR_WRITEBACK]),
 		       nid, K(nr[NR_MAPPED]),
 		       nid, K(nr[NR_PAGECACHE]),
 		       nid, K(nr[NR_SLAB]));
Index: linux-2.6.15-rc5-mm2/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/fs/proc/proc_misc.c	2005-12-14 15:34:57.000000000 -0800
+++ linux-2.6.15-rc5-mm2/fs/proc/proc_misc.c	2005-12-14 15:35:38.000000000 -0800
@@ -189,7 +189,7 @@ static int meminfo_read_proc(char *page,
 		K(i.totalswap),
 		K(i.freeswap),
 		K(global_page_state(NR_DIRTY)),
-		K(ps.nr_writeback),
+		K(global_page_state(NR_WRITEBACK)),
 		K(global_page_state(NR_MAPPED)),
 		K(global_page_state(NR_SLAB)),
 		K(allowed),
Index: linux-2.6.15-rc5-mm2/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/i386/mm/pgtable.c	2005-12-14 15:34:57.000000000 -0800
+++ linux-2.6.15-rc5-mm2/arch/i386/mm/pgtable.c	2005-12-14 15:35:38.000000000 -0800
@@ -60,7 +60,7 @@ void show_mem(void)
 
 	get_page_state(&ps);
 	printk(KERN_INFO "%lu pages dirty\n", global_page_state(NR_DIRTY));
-	printk(KERN_INFO "%lu pages writeback\n", ps.nr_writeback);
+	printk(KERN_INFO "%lu pages writeback\n", global_page_state(NR_WRITEBACK));
 	printk(KERN_INFO "%lu pages mapped\n", ps.nr_mapped);
 	printk(KERN_INFO "%lu pages slab\n", ps.nr_slab);
 	printk(KERN_INFO "%lu pages pagetables\n", ps.nr_page_table_pages);
Index: linux-2.6.15-rc5-mm2/mm/swap_prefetch.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/swap_prefetch.c	2005-12-14 15:34:57.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/swap_prefetch.c	2005-12-14 15:35:38.000000000 -0800
@@ -315,7 +315,7 @@ static int prefetch_suitable(void)
 	get_page_state(&ps);
 
 	/* We shouldn't prefetch when we are doing writeback */
-	if (ps.nr_writeback)
+	if (global_page_state(NR_WRITEBACK))
 		goto out;
 
 	/* Delay prefetching if we have significant amounts of dirty data */
Index: linux-2.6.15-rc5-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/page_alloc.c	2005-12-14 15:35:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/page_alloc.c	2005-12-14 15:37:34.000000000 -0800
@@ -597,7 +597,7 @@ static int rmqueue_bulk(struct zone *zon
 }
 
 char *stat_item_descr[NR_STAT_ITEMS] = {
-	"mapped","pagecache", "slab", "pagetable", "dirty"
+	"mapped","pagecache", "slab", "pagetable", "dirty", "writeback"
 };
 
 /*
@@ -1780,7 +1780,7 @@ void show_free_areas(void)
 		active,
 		inactive,
 		global_page_state(NR_DIRTY),
-		ps.nr_writeback,
+		global_page_state(NR_WRITEBACK),
 		ps.nr_unstable,
 		nr_free_pages(),
 		global_page_state(NR_SLAB),
Index: linux-2.6.15-rc5-mm2/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/page-flags.h	2005-12-14 15:34:57.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/page-flags.h	2005-12-14 15:35:38.000000000 -0800
@@ -82,7 +82,6 @@
  * allowed.
  */
 struct page_state {
-	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
 #define GET_PAGE_STATE_LAST nr_unstable
 
@@ -291,7 +290,7 @@ void dec_zone_page_state(const struct pa
 	do {								\
 		if (!test_and_set_bit(PG_writeback,			\
 				&(page)->flags))			\
-			inc_page_state(nr_writeback);			\
+			inc_zone_page_state(page, NR_WRITEBACK);	\
 	} while (0)
 #define TestSetPageWriteback(page)					\
 	({								\
@@ -299,14 +298,14 @@ void dec_zone_page_state(const struct pa
 		ret = test_and_set_bit(PG_writeback,			\
 					&(page)->flags);		\
 		if (!ret)						\
-			inc_page_state(nr_writeback);			\
+			inc_zone_page_state(page, NR_WRITEBACK);	\
 		ret;							\
 	})
 #define ClearPageWriteback(page)					\
 	do {								\
 		if (test_and_clear_bit(PG_writeback,			\
 				&(page)->flags))			\
-			dec_page_state(nr_writeback);			\
+			dec_zone_page_state(page, NR_WRITEBACK);	\
 	} while (0)
 #define TestClearPageWriteback(page)					\
 	({								\
@@ -314,7 +313,7 @@ void dec_zone_page_state(const struct pa
 		ret = test_and_clear_bit(PG_writeback,			\
 				&(page)->flags);			\
 		if (ret)						\
-			dec_page_state(nr_writeback);			\
+			dec_zone_page_state(page, NR_WRITEBACK);	\
 		ret;							\
 	})
 
Index: linux-2.6.15-rc5-mm2/mm/page-writeback.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/page-writeback.c	2005-12-14 15:34:57.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/page-writeback.c	2005-12-14 15:35:38.000000000 -0800
@@ -112,7 +112,7 @@ static void get_writeback_state(struct w
 	wbs->nr_dirty = global_page_state(NR_DIRTY);
 	wbs->nr_unstable = read_page_state(nr_unstable);
 	wbs->nr_mapped = global_page_state(NR_MAPPED);
-	wbs->nr_writeback = read_page_state(nr_writeback);
+	wbs->nr_writeback = global_page_state(NR_WRITEBACK);
 }
 
 /*
Index: linux-2.6.15-rc5-mm2/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/mmzone.h	2005-12-14 15:34:57.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/mmzone.h	2005-12-14 15:35:38.000000000 -0800
@@ -44,8 +44,8 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
-enum zone_stat_item { NR_MAPPED, NR_PAGECACHE, NR_SLAB, NR_PAGETABLE, NR_DIRTY };
-#define NR_STAT_ITEMS 5
+enum zone_stat_item { NR_MAPPED, NR_PAGECACHE, NR_SLAB, NR_PAGETABLE, NR_DIRTY, NR_WRITEBACK };
+#define NR_STAT_ITEMS 6
 
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
