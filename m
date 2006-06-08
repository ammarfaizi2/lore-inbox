Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWFHXEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWFHXEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWFHXEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:04:22 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:59873 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965067AbWFHXDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:03:54 -0400
Date: Thu, 8 Jun 2006 16:03:41 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060608230341.25121.73807.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 12/14] Remove unused get_page_stat functions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove get_page_state functions / structures

We can remove all the get_page_state related functions after all the basic
page state variables have been moved to the zone based scheme.

The last patch broke the compile. This fixed it.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/page-flags.h	2006-06-08 15:48:25.563475234 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/page-flags.h	2006-06-08 15:48:28.536923923 -0700
@@ -119,8 +119,6 @@
  * commented here.
  */
 struct page_state {
-#define GET_PAGE_STATE_LAST xxx
-
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
 	 * to add up all these.
@@ -173,8 +171,6 @@ struct page_state {
 	unsigned long nr_bounce;	/* pages for bounce buffers */
 };
 
-extern void get_page_state(struct page_state *ret);
-extern void get_page_state_node(struct page_state *ret, int node);
 extern void get_full_page_state(struct page_state *ret);
 extern unsigned long read_page_state_offset(unsigned long offset);
 extern void mod_page_state_offset(unsigned long offset, unsigned long delta);
Index: linux-2.6.17-rc6-mm1/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/drivers/base/node.c	2006-06-08 15:48:25.565428238 -0700
+++ linux-2.6.17-rc6-mm1/drivers/base/node.c	2006-06-08 15:48:28.537900425 -0700
@@ -40,7 +40,6 @@ static ssize_t node_read_meminfo(struct 
 	int n;
 	int nid = dev->id;
 	struct sysinfo i;
-	struct page_state ps;
 	unsigned long inactive;
 	unsigned long active;
 	unsigned long free;
@@ -48,7 +47,6 @@ static ssize_t node_read_meminfo(struct 
 	unsigned long nr[NR_STAT_ITEMS];
 
 	si_meminfo_node(&i, nid);
-	get_page_state_node(&ps, nid);
 	__get_zone_counts(&active, &inactive, &free, NODE_DATA(nid));
 	for (j = 0; j < NR_STAT_ITEMS; j++)
 		nr[j] = node_page_state(nid, j);
Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-08 15:48:25.561522230 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-08 15:48:28.540829931 -0700
@@ -1613,28 +1613,6 @@ static void __get_page_state(struct page
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
@@ -1766,7 +1744,6 @@ void si_meminfo_node(struct sysinfo *val
  */
 void show_free_areas(void)
 {
-	struct page_state ps;
 	int cpu, temperature;
 	unsigned long active;
 	unsigned long inactive;
@@ -1798,7 +1775,6 @@ void show_free_areas(void)
 		}
 	}
 
-	get_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
 
 	printk("Free pages: %11ukB (%ukB HighMem)\n",
Index: linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/fs/proc/proc_misc.c	2006-06-08 15:48:16.932173769 -0700
+++ linux-2.6.17-rc6-mm1/fs/proc/proc_misc.c	2006-06-08 15:48:28.541806433 -0700
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
Index: linux-2.6.17-rc6-mm1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/swap_prefetch.c	2006-06-08 15:48:25.566404740 -0700
+++ linux-2.6.17-rc6-mm1/mm/swap_prefetch.c	2006-06-08 15:48:28.541806433 -0700
@@ -357,7 +357,6 @@ static int prefetch_suitable(void)
 	 */
 	for_each_node_mask(node, sp_stat.prefetch_nodes) {
 		struct node_stats *ns = &sp_stat.node[node];
-		struct page_state ps;
 
 		/*
 		 * We check to see that pages are not being allocated
@@ -378,8 +377,6 @@ static int prefetch_suitable(void)
 		if (!test_pagestate)
 			continue;
 
-		get_page_state_node(&ps, node);
-
 		/* We shouldn't prefetch when we are doing writeback */
 		if (global_page_state(NR_WRITEBACK)) {
 			node_clear(node, sp_stat.prefetch_nodes);
