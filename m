Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbVLOARi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbVLOARi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbVLOARL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:17:11 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:21168 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932647AbVLOAPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:15:36 -0500
Date: Wed, 14 Dec 2005 16:15:22 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051215001522.31405.50841.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051215001415.31405.24898.sendpatchset@schroedinger.engr.sgi.com>
References: <20051215001415.31405.24898.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC3 13/14] Remove get_page_state functions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove obsolate page_state functions

We can remove all the get_page_state related functions after all the basic
page state variables have been moved to the zone based scheme.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm2/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/page-flags.h	2005-12-14 15:37:43.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/page-flags.h	2005-12-14 15:39:22.000000000 -0800
@@ -82,8 +82,6 @@
  * allowed.
  */
 struct page_state {
-#define GET_PAGE_STATE_LAST xxx
-
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
 	 * to add up all these.
@@ -136,8 +134,6 @@ struct page_state {
 	unsigned long nr_bounce;	/* pages for bounce buffers */
 };
 
-extern void get_page_state(struct page_state *ret);
-extern void get_page_state_node(struct page_state *ret, int node);
 extern void get_full_page_state(struct page_state *ret);
 extern unsigned long __read_page_state(unsigned long offset);
 extern void __mod_page_state(unsigned long offset, unsigned long delta);
Index: linux-2.6.15-rc5-mm2/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/drivers/base/node.c	2005-12-14 15:35:38.000000000 -0800
+++ linux-2.6.15-rc5-mm2/drivers/base/node.c	2005-12-14 15:39:22.000000000 -0800
@@ -39,7 +39,6 @@ static ssize_t node_read_meminfo(struct 
 	int n;
 	int nid = dev->id;
 	struct sysinfo i;
-	struct page_state ps;
 	unsigned long inactive;
 	unsigned long active;
 	unsigned long free;
@@ -47,7 +46,6 @@ static ssize_t node_read_meminfo(struct 
 	unsigned long nr[NR_STAT_ITEMS];
 
 	si_meminfo_node(&i, nid);
-	get_page_state_node(&ps, nid);
 	__get_zone_counts(&active, &inactive, &free, NODE_DATA(nid));
 	for (j = 0; j < NR_STAT_ITEMS; j++)
 		nr[j] = node_page_state(nid, j);
Index: linux-2.6.15-rc5-mm2/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/i386/mm/pgtable.c	2005-12-14 15:35:38.000000000 -0800
+++ linux-2.6.15-rc5-mm2/arch/i386/mm/pgtable.c	2005-12-14 15:39:22.000000000 -0800
@@ -30,7 +30,6 @@ void show_mem(void)
 	struct page *page;
 	pg_data_t *pgdat;
 	unsigned long i;
-	struct page_state ps;
 	unsigned long flags;
 
 	printk(KERN_INFO "Mem-info:\n");
@@ -58,7 +57,6 @@ void show_mem(void)
 	printk(KERN_INFO "%d pages shared\n", shared);
 	printk(KERN_INFO "%d pages swap cached\n", cached);
 
-	get_page_state(&ps);
 	printk(KERN_INFO "%lu pages dirty\n", global_page_state(NR_DIRTY));
 	printk(KERN_INFO "%lu pages writeback\n", global_page_state(NR_WRITEBACK));
 	printk(KERN_INFO "%lu pages mapped\n", ps.nr_mapped);
Index: linux-2.6.15-rc5-mm2/mm/swap_prefetch.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/swap_prefetch.c	2005-12-14 15:37:43.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/swap_prefetch.c	2005-12-14 15:39:22.000000000 -0800
@@ -274,7 +274,6 @@ static inline unsigned long prefetch_pag
  */
 static int prefetch_suitable(void)
 {
-	struct page_state ps;
 	unsigned long pending_writes, limit;
 	struct zone *z;
 	int ret = 0;
@@ -312,8 +311,6 @@ static int prefetch_suitable(void)
 	} else
 		last_free = temp_free;
 
-	get_page_state(&ps);
-
 	/* We shouldn't prefetch when we are doing writeback */
 	if (global_page_state(NR_WRITEBACK))
 		goto out;
Index: linux-2.6.15-rc5-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/page_alloc.c	2005-12-14 15:37:54.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/page_alloc.c	2005-12-14 15:39:22.000000000 -0800
@@ -1608,28 +1608,6 @@ static void __get_page_state(struct page
 	}
 }
 
-void get_page_state_node(struct page_state *ret, int node)
-{
-	int nr;
-	cpumask_t mask = node_to_cpumask(node);
-
-	nr = offsetof(struct page_state, GET_PAGE_STATE_LAST);
-	nr /= sizeof(unsigned long);
-
-	__get_page_state(ret, nr+1, &mask);
-}
-
-void get_page_state(struct page_state *ret)
-{
-	int nr;
-	cpumask_t mask = CPU_MASK_ALL;
-
-	nr = offsetof(struct page_state, GET_PAGE_STATE_LAST);
-	nr /= sizeof(unsigned long);
-
-	__get_page_state(ret, nr + 1, &mask);
-}
-
 void get_full_page_state(struct page_state *ret)
 {
 	cpumask_t mask = CPU_MASK_ALL;
@@ -1737,7 +1715,6 @@ void si_meminfo_node(struct sysinfo *val
  */
 void show_free_areas(void)
 {
-	struct page_state ps;
 	int cpu, temperature;
 	unsigned long active;
 	unsigned long inactive;
@@ -1769,7 +1746,6 @@ void show_free_areas(void)
 		}
 	}
 
-	get_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
 
 	printk("Free pages: %11ukB (%ukB HighMem)\n",
Index: linux-2.6.15-rc5-mm2/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/fs/proc/proc_misc.c	2005-12-14 15:35:38.000000000 -0800
+++ linux-2.6.15-rc5-mm2/fs/proc/proc_misc.c	2005-12-14 15:39:22.000000000 -0800
@@ -120,7 +120,6 @@ static int meminfo_read_proc(char *page,
 {
 	struct sysinfo i;
 	int len;
-	struct page_state ps;
 	unsigned long inactive;
 	unsigned long active;
 	unsigned long free;
@@ -129,7 +128,6 @@ static int meminfo_read_proc(char *page,
 	struct vmalloc_info vmi;
 	long cached;
 
-	get_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
 
 /*
