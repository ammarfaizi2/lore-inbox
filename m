Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVACTQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVACTQz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVACTOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:14:19 -0500
Received: from holomorphy.com ([207.189.100.168]:35229 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261526AbVACTNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:13:31 -0500
Date: Mon, 3 Jan 2005 11:13:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: jbarnes@engr.sgi.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [bootfix] pass used_node_mask by reference in 2.6.10-mm1
Message-ID: <20050103191319.GO29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without passing this parameter by reference, the changes to used_node_mask
are meaningless and do not affect the caller's copy.

This leads to boot-time failure. This proposed fix passes it by reference.


-- wli

Signed-off-by: William Irwin <wli@holomorphy.com>


Index: mm1-2.6.10/mm/page_alloc.c
===================================================================
--- mm1-2.6.10.orig/mm/page_alloc.c	2005-01-03 10:37:58.000000000 -0800
+++ mm1-2.6.10/mm/page_alloc.c	2005-01-03 10:44:01.000000000 -0800
@@ -1377,7 +1377,7 @@
  * on them otherwise.
  * It returns -1 if no node is found.
  */
-static int __init find_next_best_node(int node, nodemask_t used_node_mask)
+static int __init find_next_best_node(int node, nodemask_t *used_node_mask)
 {
 	int i, n, val;
 	int min_val = INT_MAX;
@@ -1390,11 +1390,11 @@
 		n = (node+i) % num_online_nodes();
 
 		/* Don't want a node to appear more than once */
-		if (node_isset(n, used_node_mask))
+		if (node_isset(n, *used_node_mask))
 			continue;
 
 		/* Use the local node if we haven't already */
-		if (!node_isset(node, used_node_mask)) {
+		if (!node_isset(node, *used_node_mask)) {
 			best_node = node;
 			break;
 		}
@@ -1418,7 +1418,7 @@
 	}
 
 	if (best_node >= 0)
-		node_set(best_node, used_node_mask);
+		node_set(best_node, *used_node_mask);
 
 	return best_node;
 }
@@ -1442,7 +1442,7 @@
 	load = num_online_nodes();
 	prev_node = local_node;
 	nodes_clear(used_mask);
-	while ((node = find_next_best_node(local_node, used_mask)) >= 0) {
+	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
 		/*
 		 * We don't want to pressure a particular node.
 		 * So adding penalty to the first node in same
