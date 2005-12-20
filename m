Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVLTWDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVLTWDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVLTWDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:03:06 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:54916 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932173AbVLTWCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:02:53 -0500
Date: Tue, 20 Dec 2005 14:02:42 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051220220242.30326.8459.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
References: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
Subject: Zoned counters V1 [10/14]: Convert nr_writeback
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert nr_writeback

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm3/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/drivers/base/node.c	2005-12-20 12:58:54.000000000 -0800
+++ linux-2.6.15-rc5-mm3/drivers/base/node.c	2005-12-20 12:59:09.000000000 -0800
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
Index: linux-2.6.15-rc5-mm3/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/fs/proc/proc_misc.c	2005-12-20 12:58:54.000000000 -0800
+++ linux-2.6.15-rc5-mm3/fs/proc/proc_misc.c	2005-12-20 12:59:09.000000000 -0800
@@ -189,7 +189,7 @@ static int meminfo_read_proc(char *page,
 		K(i.totalswap),
 		K(i.freeswap),
 		K(global_page_state(NR_DIRTY)),
-		K(ps.nr_writeback),
+		K(global_page_state(NR_WRITEBACK)),
 		K(global_page_state(NR_MAPPED)),
 		K(global_page_state(NR_SLAB)),
 		K(allowed),
Index: linux-2.6.15-rc5-mm3/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/arch/i386/mm/pgtable.c	2005-12-20 12:58:54.000000000 -0800
+++ linux-2.6.15-rc5-mm3/arch/i386/mm/pgtable.c	2005-12-20 12:59:09.000000000 -0800
@@ -60,7 +60,7 @@ void show_mem(void)
 
 	get_page_state(&ps);
 	printk(KERN_INFO "%lu pages dirty\n", global_page_state(NR_DIRTY));
-	printk(KERN_INFO "%lu pages writeback\n", ps.nr_writeback);
+	printk(KERN_INFO "%lu pages writeback\n", global_page_state(NR_WRITEBACK));
 	printk(KERN_INFO "%lu pages mapped\n", ps.nr_mapped);
 	printk(KERN_INFO "%lu pages slab\n", ps.nr_slab);
 	printk(KERN_INFO "%lu pages pagetables\n", ps.nr_page_table_pages);
Index: linux-2.6.15-rc5-mm3/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/page_alloc.c	2005-12-20 12:58:54.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/page_alloc.c	2005-12-20 12:59:09.000000000 -0800
@@ -598,7 +598,7 @@ static int rmqueue_bulk(struct zone *zon
 }
 
 char *stat_item_descr[NR_STAT_ITEMS] = {
-	"mapped","pagecache", "slab", "pagetable", "dirty"
+	"mapped","pagecache", "slab", "pagetable", "dirty", "writeback"
 };
 
 /*
@@ -1783,7 +1783,7 @@ void show_free_areas(void)
 		active,
 		inactive,
 		global_page_state(NR_DIRTY),
-		ps.nr_writeback,
+		global_page_state(NR_WRITEBACK),
 		ps.nr_unstable,
 		nr_free_pages(),
 		global_page_state(NR_SLAB),
@@ -2682,9 +2682,9 @@ static char *vmstat_text[] = {
 	"nr_slab",
 	"nr_page_table_pages",
 	"nr_dirty",
+	"nr_writeback",
 
 	/* Page state */
-	"nr_writeback",
 	"nr_unstable",
 
 	"pgpgin",
Index: linux-2.6.15-rc5-mm3/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/page-flags.h	2005-12-20 12:58:54.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/page-flags.h	2005-12-20 12:59:09.000000000 -0800
@@ -91,7 +91,6 @@
  * In this case, the field should be commented here.
  */
 struct page_state {
-	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
 #define GET_PAGE_STATE_LAST nr_unstable
 
@@ -322,7 +321,7 @@ void dec_zone_page_state(const struct pa
 	do {								\
 		if (!test_and_set_bit(PG_writeback,			\
 				&(page)->flags))			\
-			inc_page_state(nr_writeback);			\
+			inc_zone_page_state(page, NR_WRITEBACK);	\
 	} while (0)
 #define TestSetPageWriteback(page)					\
 	({								\
@@ -330,14 +329,14 @@ void dec_zone_page_state(const struct pa
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
@@ -345,7 +344,7 @@ void dec_zone_page_state(const struct pa
 		ret = test_and_clear_bit(PG_writeback,			\
 				&(page)->flags);			\
 		if (ret)						\
-			dec_page_state(nr_writeback);			\
+			dec_zone_page_state(page, NR_WRITEBACK);	\
 		ret;							\
 	})
 
Index: linux-2.6.15-rc5-mm3/mm/page-writeback.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/page-writeback.c	2005-12-20 12:58:54.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/page-writeback.c	2005-12-20 12:59:09.000000000 -0800
@@ -112,7 +112,7 @@ static void get_writeback_state(struct w
 	wbs->nr_dirty = global_page_state(NR_DIRTY);
 	wbs->nr_unstable = read_page_state(nr_unstable);
 	wbs->nr_mapped = global_page_state(NR_MAPPED);
-	wbs->nr_writeback = read_page_state(nr_writeback);
+	wbs->nr_writeback = global_page_state(NR_WRITEBACK);
 }
 
 /*
Index: linux-2.6.15-rc5-mm3/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/mmzone.h	2005-12-20 12:58:54.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/mmzone.h	2005-12-20 12:59:09.000000000 -0800
@@ -51,6 +51,7 @@ enum zone_stat_item {
 	NR_SLAB,	/* used by slab allocator */
 	NR_PAGETABLE,	/* used for pagetables */
 	NR_DIRTY,
+	NR_WRITEBACK,
 	NR_STAT_ITEMS };
 
 #ifdef CONFIG_SMP
