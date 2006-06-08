Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbWFHXFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWFHXFy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbWFHXDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:03:47 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:56545 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965061AbWFHXDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:03:40 -0400
Date: Thu, 8 Jun 2006 16:03:31 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060608230331.25121.14255.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 10/14] Conversion of nr_writeback to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion of nr_writeback to per zone counter

Avoids per processor loop during writeback state determination.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/drivers/base/node.c	2006-06-08 15:46:37.439311186 -0700
+++ linux-2.6.17-rc6-mm1/drivers/base/node.c	2006-06-08 15:46:56.901973196 -0700
@@ -53,9 +53,6 @@ static ssize_t node_read_meminfo(struct 
 	for (j = 0; j < NR_STAT_ITEMS; j++)
 		nr[j] = node_page_state(nid, j);
 
-	/* Check for negative values in these approximate counters */
-	if ((long)ps.nr_writeback < 0)
-		ps.nr_writeback = 0;
 
 	n = sprintf(buf, "\n"
 		       "Node %d MemTotal:     %8lu kB\n"
@@ -82,7 +79,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.totalram - i.totalhigh),
 		       nid, K(i.freeram - i.freehigh),
 		       nid, K(nr[NR_DIRTY]),
-		       nid, K(ps.nr_writeback),
+		       nid, K(nr[NR_WRITEBACK]),
 		       nid, K(nr[NR_MAPPED]),
 		       nid, K(nr[NR_PAGECACHE]),
 		       nid, K(nr[NR_SLAB]));
Index: linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/proc/proc_misc.c	2006-06-08 15:46:37.442240692 -0700
+++ linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c	2006-06-08 15:46:56.902949698 -0700
@@ -189,7 +189,7 @@ static int meminfo_read_proc(char *page,
 		K(i.totalswap),
 		K(i.freeswap),
 		K(global_page_state(NR_DIRTY)),
-		K(ps.nr_writeback),
+		K(global_page_state(NR_WRITEBACK)),
 		K(global_page_state(NR_MAPPED)),
 		K(global_page_state(NR_SLAB)),
 		K(allowed),
Index: linux-2.6.17-rc6-mm1/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/arch/i386/mm/pgtable.c	2006-06-08 15:46:48.173998029 -0700
+++ linux-2.6.17-rc6-mm1/arch/i386/mm/pgtable.c	2006-06-08 15:47:41.868915289 -0700
@@ -30,7 +30,6 @@ void show_mem(void)
 	struct page *page;
 	pg_data_t *pgdat;
 	unsigned long i;
-	struct page_state ps;
 	unsigned long flags;
 
 	printk(KERN_INFO "Mem-info:\n");
@@ -58,9 +57,8 @@ void show_mem(void)
 	printk(KERN_INFO "%d pages shared\n", shared);
 	printk(KERN_INFO "%d pages swap cached\n", cached);
 
-	get_page_state(&ps);
 	printk(KERN_INFO "%lu pages dirty\n", global_page_state(NR_DIRTY));
-	printk(KERN_INFO "%lu pages writeback\n", ps.nr_writeback);
+	printk(KERN_INFO "%lu pages writeback\n", global_page_state(NR_WRITEBACK));
 	printk(KERN_INFO "%lu pages mapped\n", global_page_state(NR_MAPPED));
 	printk(KERN_INFO "%lu pages slab\n", global_page_state(NR_SLAB));
 	printk(KERN_INFO "%lu pages pagetables\n", global_page_state(NR_PAGETABLE));
Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-08 15:46:37.436381680 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-08 15:46:56.905879204 -0700
@@ -629,7 +629,7 @@ static int rmqueue_bulk(struct zone *zon
 }
 
 char *vm_stat_item_descr[NR_STAT_ITEMS] = {
-	 "mapped", "pagecache", "slab", "pagetable", "dirty"
+	 "mapped", "pagecache", "slab", "pagetable", "dirty", "writeback"
 };
 
 /*
@@ -1809,7 +1809,7 @@ void show_free_areas(void)
 		active,
 		inactive,
 		global_page_state(NR_DIRTY),
-		ps.nr_writeback,
+		global_page_state(NR_WRITEBACK),
 		ps.nr_unstable,
 		nr_free_pages(),
 		global_page_state(NR_SLAB),
@@ -2809,9 +2809,9 @@ static char *vmstat_text[] = {
 	"nr_slab",
 	"nr_page_table_pages",
 	"nr_dirty",
+	"nr_writeback",
 
 	/* Page state */
-	"nr_writeback",
 	"nr_unstable",
 
 	"pgpgin",
Index: linux-2.6.17-rc6-mm1/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/page-flags.h	2006-06-08 15:46:37.437358182 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/page-flags.h	2006-06-08 15:46:56.906855706 -0700
@@ -119,7 +119,6 @@
  * commented here.
  */
 struct page_state {
-	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_unstable;	/* NFS unstable pages */
 #define GET_PAGE_STATE_LAST nr_unstable
 
@@ -349,7 +348,7 @@ void dec_zone_page_state(struct page *, 
 	do {								\
 		if (!test_and_set_bit(PG_writeback,			\
 				&(page)->flags))			\
-			inc_page_state(nr_writeback);			\
+			inc_zone_page_state(page, NR_WRITEBACK);	\
 	} while (0)
 #define TestSetPageWriteback(page)					\
 	({								\
@@ -357,14 +356,14 @@ void dec_zone_page_state(struct page *, 
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
@@ -372,7 +371,7 @@ void dec_zone_page_state(struct page *, 
 		ret = test_and_clear_bit(PG_writeback,			\
 				&(page)->flags);			\
 		if (ret)						\
-			dec_page_state(nr_writeback);			\
+			dec_zone_page_state(page, NR_WRITEBACK);	\
 		ret;							\
 	})
 
Index: linux-2.6.17-rc6-mm1/mm/page-writeback.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page-writeback.c	2006-06-08 15:46:37.438334684 -0700
+++ linux-2.6.17-rc6-mm1/mm/page-writeback.c	2006-06-08 15:46:56.907832208 -0700
@@ -112,7 +112,7 @@ static void get_writeback_state(struct w
 	wbs->nr_dirty = global_page_state(NR_DIRTY);
 	wbs->nr_unstable = read_page_state(nr_unstable);
 	wbs->nr_mapped = global_page_state(NR_MAPPED);
-	wbs->nr_writeback = read_page_state(nr_writeback);
+	wbs->nr_writeback = global_page_state(NR_WRITEBACK);
 }
 
 /*
Index: linux-2.6.17-rc6-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/mmzone.h	2006-06-08 15:46:37.438334684 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/mmzone.h	2006-06-08 15:46:56.908808710 -0700
@@ -53,6 +53,7 @@ enum zone_stat_item {
 	NR_SLAB,	/* used by slab allocator */
 	NR_PAGETABLE,	/* used for pagetables */
 	NR_DIRTY,
+	NR_WRITEBACK,
 	NR_STAT_ITEMS };
 
 #ifdef CONFIG_SMP
Index: linux-2.6.17-rc6-mm1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/swap_prefetch.c	2006-06-08 15:46:37.447123203 -0700
+++ linux-2.6.17-rc6-mm1/mm/swap_prefetch.c	2006-06-08 15:46:56.908808710 -0700
@@ -381,7 +381,7 @@ static int prefetch_suitable(void)
 		get_page_state_node(&ps, node);
 
 		/* We shouldn't prefetch when we are doing writeback */
-		if (ps.nr_writeback) {
+		if (global_page_state(NR_WRITEBACK)) {
 			node_clear(node, sp_stat.prefetch_nodes);
 			continue;
 		}
