Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbUDAVR0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUDAVPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:15:50 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:2100 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263186AbUDAVNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:13:14 -0500
Date: Thu, 1 Apr 2004 13:12:07 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [Patch 11/23] mask v2 - Add new nodemasks.h file
Message-Id: <20040401131207.37fe8bdc.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_11_of_23 - Add new nodemasks.h file.
	Provide a nodemasks_t type, using the mask.h ADT.

Diffstat Patch_11_of_23:
 nodemask.h                     |  152 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 152 insertions(+)

===================================================================
--- 2.6.4.orig/include/linux/nodemask.h	1969-12-31 16:00:00.000000000 -0800
+++ 2.6.4/include/linux/nodemask.h	2004-04-01 09:42:21.000000000 -0800
@@ -0,0 +1,156 @@
+#ifndef __LINUX_NODEMASK_H
+#define __LINUX_NODEMASK_H
+
+/*
+ * Nodemasks provide a bit mask suitable for representing the
+ * set of Node's in a system, one bit position per Node number.
+ *
+ * See detailed comments in the file linux/mask.h describing the
+ * data type on which these nodemasks are based.
+ *
+ * For details of nodemask_scnprintf() and nodemask_parse(),
+ * see bitmap_scnprintf() and bitmap_parse() in lib/bitmap.c.
+ *
+ * The available nodemask operations are:
+ *
+ * void node_set(node, mask)		turn on bit 'node' in mask
+ * void node_clear(node, mask)		turn off bit 'node' in mask
+ * void nodes_setall(mask)		set all bits
+ * void nodes_clear(mask)		clear all bits
+ * int node_isset(node, mask)		true iff bit 'node' set in mask
+ * int node_test_and_set(node, mask)	test and set bit 'node' in mask
+ *
+ * void nodes_and(dst, src1, src2)	dst = src1 & src2  [intersection]
+ * void nodes_or(dst, src1, src2)	dst = src1 | src2  [union]
+ * void nodes_xor(dst, src1, src2)	dst = src1 ^ src2
+ * void nodes_andnot(dst, src1, src2)	dst = src1 & ~src2
+ * void nodes_complement(dst, src)	dst = ~src
+ *
+ * int nodes_equal(mask1, mask2)	Does mask1 == mask2?
+ * int nodes_intersects(mask1, mask2)	Do mask1 and mask2 intersect?
+ * int nodes_subset(mask1, mask2)	Is mask1 a subset of mask2?
+ * int nodes_empty(mask)		Is mask empty (no bits sets)?
+ * int nodes_full(mask)			Is mask full (all bits sets)?
+ * int nodes_weight(mask)		Hamming weigh - number of set bits
+ *
+ * void nodes_shift_right(dst, src, n)	Shift right
+ * void nodes_shift_left(dst, src, n)	Shift left
+ *
+ * int first_node(mask)			Number lowest set bit, or MAX_NUMNODES
+ * int next_node(node, mask)		Next node past 'node', or MAX_NUMNODES
+ *
+ * nodemask_t nodemask_of_node(node)	Return nodemask with bit 'node' set
+ * NODE_MASK_ALL			Initializer - all bits set
+ * NODE_MASK_NONE			Initializer - no bits set
+ * unsigned long *nodes_addr(mask)	Array of unsigned long's in mask
+ *
+ * int nodemask_scnprintf(buf, len, mask) Format nodemask for printing
+ * int nodemask_parse(ubuf, ulen, mask)	Parse ascii string as nodemask
+ *
+ * int num_online_nodes()		Number of online nodes
+ * int num_possible_nodes()		Number of all possible nodes
+ * int node_online(node)		Is some node < MAX_NUMNODES online?
+ * int node_possible(node)		Is some node < MAX_NUMNODES possible? 
+ * void node_set_online(node)		set node in node_online_map
+ * void node_set_offline(node)		clear node in node_online_map
+ * int any_online_node(mask)		First online node in mask
+ *
+ * for_each_node_mask(node, mask)	for-loop node over mask
+ * for_each_node(node)			for-loop node over node_possible_map
+ * for_each_online_node(node)		for-loop node over node_online_map
+ */
+
+#include <linux/numa.h>
+#include <linux/mask.h>
+#include <asm/bug.h>
+
+typedef __mask(MAX_NUMNODES) nodemask_t;
+extern nodemask_t _unused_nodemask_arg_;
+
+#define node_set(node, mask)		mask_setbit((node), (mask))
+#define node_clear(node, mask)		mask_clearbit((node), (mask))
+#define nodes_setall(mask)		mask_setall((mask), MAX_NUMNODES)
+#define nodes_clear(mask)		mask_clearall((mask), MAX_NUMNODES)
+#define node_isset(node, mask)		mask_isset((node), (mask))
+#define node_test_and_set(node, mask)	mask_test_and_set((node), (mask))
+#define nodes_and(dst, src1, src2)	mask_and((dst), (src1), (src2), MAX_NUMNODES)
+#define nodes_or(dst, src1, src2)	mask_or((dst), (src1), (src2), MAX_NUMNODES)
+#define nodes_xor(dst, src1, src2)	mask_xor((dst), (src1), (src2), MAX_NUMNODES)
+#define nodes_andnot(dst, src1, src2)	mask_andnot((dst), (src1), (src2), MAX_NUMNODES)
+#define nodes_complement(dst, src)	mask_complement((dst), (src), MAX_NUMNODES)
+#define nodes_equal(mask1, mask2)	mask_equal((mask1), (mask2), MAX_NUMNODES)
+#define nodes_intersects(mask1, mask2)	mask_intersects((mask1), (mask2), MAX_NUMNODES)
+#define nodes_subset(mask1, mask2)	mask_subset((mask1), (mask2), MAX_NUMNODES)
+#define nodes_empty(mask)		mask_empty((mask), MAX_NUMNODES)
+#define nodes_full(mask)		mask_full((mask), MAX_NUMNODES)
+#define nodes_weight(mask)		mask_weight((mask), MAX_NUMNODES)
+#define nodes_shift_right(dst, src, n)	\
+			mask_shift_right((dst), (src), (n), MAX_NUMNODES)
+#define nodes_shift_left(dst, src, n)	\
+			mask_shift_left((dst), (src), (n), MAX_NUMNODES)
+#define first_node(mask)		mask_first((mask), MAX_NUMNODES)
+#define next_node(node, mask)		mask_next((node), (mask), MAX_NUMNODES)
+#define nodemask_of_node(node)		\
+			mask_of_bit((node), _unused_nodemask_arg_)
+#if MAX_NUMNODES <= BITS_PER_LONG
+#define NODE_MASK_ALL			MASK_ALL1(MAX_NUMNODES)
+#else
+#define NODE_MASK_ALL			MASK_ALL2(MAX_NUMNODES)
+#endif
+#define NODE_MASK_NONE			MASK_NONE(MAX_NUMNODES)
+#define nodes_addr(mask)			mask_addr(mask)
+#define nodemask_scnprintf(buf, len, mask) \
+			mask_scnprintf((buf), (len), (mask), MAX_NUMNODES)
+#define nodemask_parse(ubuf, ulen, mask) \
+			mask_parse((ubuf), (ulen), (mask), MAX_NUMNODES)
+
+/*
+ * The following particular system nodemasks and operations
+ * on them manage all (possible) and online nodes.
+ */
+
+extern nodemask_t node_online_map;
+extern nodemask_t node_possible_map;
+
+#ifdef CONFIG_NUMA
+
+#define num_online_nodes()		nodes_weight(node_online_map)
+#define num_possible_nodes()		nodes_weight(node_possible_map)
+#define node_online(node)		node_isset((node), node_online_map)
+#define node_possible(node) 		node_isset((node), node_possible_map)
+#define node_set_online(node)		node_set((node), node_online_map)
+#define node_set_offline(node)		node_clear((node), node_online_map)
+
+#define any_online_node(mask)			\
+({						\
+        nodemask_t n;				\
+        nodes_and(n, mask, node_online_map);	\
+        first_node(n);				\
+})
+
+#define for_each_node_mask(node, mask)		\
+	for (node = first_node(mask);		\
+		node < MAX_NUMNODES;		\
+		node = next_node(node, mask))
+
+#else /* !CONFIG_NUMA */
+
+#define num_online_nodes()		1
+#define num_possible_nodes()		1
+#define node_online(node)		({ BUG_ON((node) != 0); 1; })
+#define node_possible(node)		({ BUG_ON((node) != 0); 1; })
+#define node_set_online(node)		({ BUG_ON((node) != 0); })
+#define node_set_offline(node)		({ BUG(); })
+
+#define any_online_node(mask)		0
+
+#define for_each_node_mask(node, mask)	for (node = 0; node < 1; node++)
+
+#endif /* CONFIG_NUMA */
+
+#define for_each_node(node)		\
+			for_each_node_mask(node, node_possible_map)
+#define for_each_online_node(node)	\
+			for_each_node_mask(node, node_online_map)
+
+#endif /* __LINUX_NODEMASK_H */


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
