Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263012AbVALHDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbVALHDF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 02:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbVALHDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 02:03:04 -0500
Received: from mail.suse.de ([195.135.220.2]:5298 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263012AbVALHBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 02:01:31 -0500
Date: Wed, 12 Jan 2005 08:01:30 +0100
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org, akpm@osdl.org, discuss@x86-64.org, vandrove@vc.cvut.cz,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] x86_64: Fix ACPI NUMA parsing
Message-ID: <20050112070130.GB532@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix SRAT NUMA parsing

Fix fallout from the recent nodemask_t changes. The node ids assigned 
in the SRAT parser were off by one.

I added a new first_unset_node() function to nodemask.h to allocate
IDs sanely.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/mm/srat.c
===================================================================
--- linux.orig/arch/x86_64/mm/srat.c	2005-01-09 18:19:17.%N +0100
+++ linux/arch/x86_64/mm/srat.c	2005-01-12 04:15:43.%N +0100
@@ -20,17 +20,20 @@
 
 static struct acpi_table_slit *acpi_slit;
 
-static DECLARE_BITMAP(nodes_parsed, MAX_NUMNODES) __initdata;
+static nodemask_t nodes_parsed __initdata;
+static nodemask_t nodes_found __initdata;
 static struct node nodes[MAX_NUMNODES] __initdata;
 static __u8  pxm2node[256] __initdata = { [0 ... 255] = 0xff };
 
 static __init int setup_node(int pxm)
 {
-	if (pxm2node[pxm] == 0xff) {
-		if (num_online_nodes() >= MAX_NUMNODES)
+	unsigned node = pxm2node[pxm];
+	if (node == 0xff) {
+		if (nodes_weight(nodes_found) >= MAX_NUMNODES)
 			return -1;
-		pxm2node[pxm] = num_online_nodes();
-		node_set_online(num_online_nodes());
+		node = first_unset_node(nodes_found); 
+		node_set(node, nodes_found);
+		pxm2node[pxm] = node;
 	}
 	return pxm2node[pxm];
 }
@@ -140,7 +143,7 @@
 		return;
 	}
 	nd = &nodes[node];
-	if (!test_and_set_bit(node, &nodes_parsed)) {
+	if (!node_test_and_set(node, nodes_parsed)) {
 		nd->start = start;
 		nd->end = end;
 	} else {
@@ -171,7 +174,7 @@
 		return -1;
 	}
 	for (i = 0; i < MAX_NUMNODES; i++) {
-		if (!test_bit(i, &nodes_parsed))
+		if (!node_isset(i, nodes_parsed))
 			continue;
 		cutoff_node(i, start, end);
 		if (nodes[i].start == nodes[i].end)
Index: linux/include/linux/nodemask.h
===================================================================
--- linux.orig/include/linux/nodemask.h	2005-01-12 02:43:49.%N +0100
+++ linux/include/linux/nodemask.h	2005-01-12 04:15:43.%N +0100
@@ -38,6 +38,8 @@
  *
  * int first_node(mask)			Number lowest set bit, or MAX_NUMNODES
  * int next_node(node, mask)		Next node past 'node', or MAX_NUMNODES
+ * int first_unset_node(mask)		First node not set in mask, or 
+ *					MAX_NUMNODES.
  *
  * nodemask_t nodemask_of_node(node)	Return nodemask with bit 'node' set
  * NODE_MASK_ALL			Initializer - all bits set
@@ -238,6 +240,13 @@
 	m;								\
 })
 
+#define first_unset_node(mask) __first_unset_node(&(mask))
+static inline int __first_unset_node(const nodemask_t *maskp)
+{
+	return min_t(int,MAX_NUMNODES,
+			find_first_zero_bit(maskp->bits, MAX_NUMNODES));
+}
+
 #define NODE_MASK_LAST_WORD BITMAP_LAST_WORD_MASK(MAX_NUMNODES)
 
 #if MAX_NUMNODES <= BITS_PER_LONG
