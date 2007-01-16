Return-Path: <linux-kernel-owner+w=401wt.eu-S932378AbXAPFr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbXAPFr5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 00:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbXAPFr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 00:47:57 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58767 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932386AbXAPFrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 00:47:55 -0500
Date: Mon, 15 Jan 2007 21:47:48 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Paul Menage <menage@google.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>, Christoph Lameter <clameter@sgi.com>
Message-Id: <20070116054748.15358.31856.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 1/8] Convert higest_possible_node_id() into nr_node_ids
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace highest_possible_node_id() with nr_node_ids

highest_possible_node_id() is used to calculate the last possible node id
so that the network subsystem can figure out how to size per node arrays.

I think having the ability to determine the maximum amount of nodes in
a system at runtime is useful but then we should name this entry
correspondingly and also only calculate the value once on bootup.

This patch introduces nr_node_ids and replaces the use of
highest_possible_node_id(). nr_node_ids is calculated on bootup when
the page allocators pagesets are initialized.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.20-rc4-mm1/include/linux/nodemask.h
===================================================================
--- linux-2.6.20-rc4-mm1.orig/include/linux/nodemask.h	2007-01-06 21:45:51.000000000 -0800
+++ linux-2.6.20-rc4-mm1/include/linux/nodemask.h	2007-01-12 12:59:50.000000000 -0800
@@ -352,7 +352,7 @@
 #define node_possible(node)	node_isset((node), node_possible_map)
 #define first_online_node	first_node(node_online_map)
 #define next_online_node(nid)	next_node((nid), node_online_map)
-int highest_possible_node_id(void);
+extern int nr_node_ids;
 #else
 #define num_online_nodes()	1
 #define num_possible_nodes()	1
@@ -360,7 +360,7 @@
 #define node_possible(node)	((node) == 0)
 #define first_online_node	0
 #define next_online_node(nid)	(MAX_NUMNODES)
-#define highest_possible_node_id()	0
+#define nr_node_ids		1
 #endif
 
 #define any_online_node(mask)			\
Index: linux-2.6.20-rc4-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/mm/page_alloc.c	2007-01-12 12:58:26.000000000 -0800
+++ linux-2.6.20-rc4-mm1/mm/page_alloc.c	2007-01-12 12:59:50.000000000 -0800
@@ -679,6 +679,26 @@
 	return i;
 }
 
+#if MAX_NUMNODES > 1
+int nr_node_ids __read_mostly;
+EXPORT_SYMBOL(nr_node_ids);
+
+/*
+ * Figure out the number of possible node ids.
+ */
+static void __init setup_nr_node_ids(void)
+{
+	unsigned int node;
+	unsigned int highest = 0;
+
+	for_each_node_mask(node, node_possible_map)
+		highest = node;
+	nr_node_ids = highest + 1;
+}
+#else
+static void __init setup_nr_node_ids(void) {}
+#endif
+
 #ifdef CONFIG_NUMA
 /*
  * Called from the slab reaper to drain pagesets on a particular node that
@@ -3318,6 +3338,7 @@
 		min_free_kbytes = 65536;
 	setup_per_zone_pages_min();
 	setup_per_zone_lowmem_reserve();
+	setup_nr_node_ids();
 	return 0;
 }
 module_init(init_per_zone_pages_min)
@@ -3519,18 +3540,4 @@
 EXPORT_SYMBOL(page_to_pfn);
 #endif /* CONFIG_OUT_OF_LINE_PFN_TO_PAGE */
 
-#if MAX_NUMNODES > 1
-/*
- * Find the highest possible node id.
- */
-int highest_possible_node_id(void)
-{
-	unsigned int node;
-	unsigned int highest = 0;
 
-	for_each_node_mask(node, node_possible_map)
-		highest = node;
-	return highest;
-}
-EXPORT_SYMBOL(highest_possible_node_id);
-#endif
Index: linux-2.6.20-rc4-mm1/net/sunrpc/svc.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/net/sunrpc/svc.c	2007-01-06 21:45:51.000000000 -0800
+++ linux-2.6.20-rc4-mm1/net/sunrpc/svc.c	2007-01-12 12:59:50.000000000 -0800
@@ -116,7 +116,7 @@
 static int
 svc_pool_map_init_percpu(struct svc_pool_map *m)
 {
-	unsigned int maxpools = highest_possible_processor_id()+1;
+	unsigned int maxpools = nr_node_ids;
 	unsigned int pidx = 0;
 	unsigned int cpu;
 	int err;
@@ -144,7 +144,7 @@
 static int
 svc_pool_map_init_pernode(struct svc_pool_map *m)
 {
-	unsigned int maxpools = highest_possible_node_id()+1;
+	unsigned int maxpools = nr_node_ids;
 	unsigned int pidx = 0;
 	unsigned int node;
 	int err;
