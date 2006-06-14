Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWFNBEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWFNBEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWFNBEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:04:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19144 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964839AbWFNBEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:04:11 -0400
Date: Tue, 13 Jun 2006 18:04:01 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010401.859.54406.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 16/21] Conversion of nr_writeback to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: zoned vm counters: conversion of nr_writeback to per zone counter
From: Christoph Lameter <clameter@sgi.com>

Conversion of nr_writeback to per zone counter.

This removes the last page_state counter from arch/i386/mm/pgtable.c
so we drop the page_state from there.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/arch/i386/mm/pgtable.c	2006-06-13 17:14:28.824593774 -0700
+++ linux-2.6.17-rc6-cl/arch/i386/mm/pgtable.c	2006-06-13 17:16:31.238901014 -0700
@@ -30,7 +30,6 @@ void show_mem(void)
 	struct page *page;
 	pg_data_t *pgdat;
 	unsigned long i;
-	struct page_state ps;
 	unsigned long flags;
 
 	printk(KERN_INFO "Mem-info:\n");
@@ -58,9 +57,9 @@ void show_mem(void)
 	printk(KERN_INFO "%d pages shared\n", shared);
 	printk(KERN_INFO "%d pages swap cached\n", cached);
 
-	get_page_state(&ps);
 	printk(KERN_INFO "%lu pages dirty\n", global_page_state(NR_DIRTY));
-	printk(KERN_INFO "%lu pages writeback\n", ps.nr_writeback);
+	printk(KERN_INFO "%lu pages writeback\n",
+					global_page_state(NR_WRITEBACK));
 	printk(KERN_INFO "%lu pages mapped\n", global_page_state(NR_MAPPED));
 	printk(KERN_INFO "%lu pages slab\n", global_page_state(NR_SLAB));
 	printk(KERN_INFO "%lu pages pagetables\n",
Index: linux-2.6.17-rc6-cl/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/drivers/base/node.c	2006-06-13 17:14:28.825570276 -0700
+++ linux-2.6.17-rc6-cl/drivers/base/node.c	2006-06-13 17:15:25.970475071 -0700
@@ -49,9 +49,6 @@ static ssize_t node_read_meminfo(struct 
 	get_page_state_node(&ps, nid);
 	__get_zone_counts(&active, &inactive, &free, NODE_DATA(nid));
 
-	/* Check for negative values in these approximate counters */
-	if ((long)ps.nr_writeback < 0)
-		ps.nr_writeback = 0;
 
 	n = sprintf(buf, "\n"
 		       "Node %d MemTotal:     %8lu kB\n"
@@ -80,7 +77,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.totalram - i.totalhigh),
 		       nid, K(i.freeram - i.freehigh),
 		       nid, K(node_page_state(nid, NR_DIRTY)),
-		       nid, K(ps.nr_writeback),
+		       nid, K(node_page_state(nid, NR_WRITEBACK)),
 		       nid, K(node_page_state(nid, NR_PAGECACHE)),
 		       nid, K(node_page_state(nid, NR_MAPPED)),
 		       nid, K(node_page_state(nid, NR_ANON)),
Index: linux-2.6.17-rc6-cl/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/proc/proc_misc.c	2006-06-13 17:14:28.830452787 -0700
+++ linux-2.6.17-rc6-cl/fs/proc/proc_misc.c	2006-06-13 17:15:25.971451573 -0700
@@ -191,7 +191,7 @@ static int meminfo_read_proc(char *page,
 		K(i.totalswap),
 		K(i.freeswap),
 		K(global_page_state(NR_DIRTY)),
-		K(ps.nr_writeback),
+		K(global_page_state(NR_WRITEBACK)),
 		K(global_page_state(NR_ANON)),
 		K(global_page_state(NR_MAPPED)),
 		K(global_page_state(NR_SLAB)),
Index: linux-2.6.17-rc6-cl/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-13 17:14:28.831429289 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-13 17:15:25.971451573 -0700
@@ -54,6 +54,7 @@ enum zone_stat_item {
 	NR_SLAB,	/* Pages used by slab allocator */
 	NR_PAGETABLE,	/* used for pagetables */
 	NR_DIRTY,
+	NR_WRITEBACK,
 	NR_VM_ZONE_STAT_ITEMS };
 
 struct per_cpu_pages {
Index: linux-2.6.17-rc6-cl/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/page-flags.h	2006-06-13 17:10:38.160141749 -0700
+++ linux-2.6.17-rc6-cl/include/linux/page-flags.h	2006-06-13 17:15:25.972428075 -0700
@@ -176,7 +176,7 @@
 	do {								\
 		if (!test_and_set_bit(PG_writeback,			\
 				&(page)->flags))			\
-			inc_page_state(nr_writeback);			\
+			inc_zone_page_state(page, NR_WRITEBACK);	\
 	} while (0)
 #define TestSetPageWriteback(page)					\
 	({								\
@@ -184,14 +184,14 @@
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
@@ -199,7 +199,7 @@
 		ret = test_and_clear_bit(PG_writeback,			\
 				&(page)->flags);			\
 		if (ret)						\
-			dec_page_state(nr_writeback);			\
+			dec_zone_page_state(page, NR_WRITEBACK);	\
 		ret;							\
 	})
 
Index: linux-2.6.17-rc6-cl/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page_alloc.c	2006-06-13 17:14:28.833382294 -0700
+++ linux-2.6.17-rc6-cl/mm/page_alloc.c	2006-06-13 17:15:25.974381079 -0700
@@ -1405,7 +1405,7 @@ void show_free_areas(void)
 		active,
 		inactive,
 		global_page_state(NR_DIRTY),
-		ps.nr_writeback,
+		global_page_state(NR_WRITEBACK),
 		ps.nr_unstable,
 		nr_free_pages(),
 		global_page_state(NR_SLAB),
Index: linux-2.6.17-rc6-cl/mm/page-writeback.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page-writeback.c	2006-06-13 17:14:28.833382294 -0700
+++ linux-2.6.17-rc6-cl/mm/page-writeback.c	2006-06-13 17:15:25.974381079 -0700
@@ -113,7 +113,7 @@ static void get_writeback_state(struct w
 	wbs->nr_unstable = read_page_state(nr_unstable);
 	wbs->nr_mapped = global_page_state(NR_MAPPED) +
 				global_page_state(NR_ANON);
-	wbs->nr_writeback = read_page_state(nr_writeback);
+	wbs->nr_writeback = global_page_state(NR_WRITEBACK);
 }
 
 /*
Index: linux-2.6.17-rc6-cl/mm/vmstat.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmstat.c	2006-06-13 17:14:28.834358796 -0700
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-13 17:15:25.975357582 -0700
@@ -463,9 +463,9 @@ static char *vmstat_text[] = {
 	"nr_slab",
 	"nr_page_table_pages",
 	"nr_dirty",
+	"nr_writeback",
 
 	/* Page state */
-	"nr_writeback",
 	"nr_unstable",
 
 	"pgpgin",
