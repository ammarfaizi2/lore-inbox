Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbUDHUII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUDHUGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 16:06:38 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:23526 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262448AbUDHTuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:50:46 -0400
Date: Thu, 8 Apr 2004 12:50:08 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 16/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408125008.3d13cbf6.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P16.new_nodemask.h - New nodemask_t, based on bitmap.
	New nodemask_t type, based on bitmap/bitop,
	suitable for use with Matthew Dobson's nodemask
	patch series.  Closely resembles cpumask.h.

Index: 2.6.5.bitmap/include/linux/nodemask.h
===================================================================
--- 2.6.5.bitmap.orig/include/linux/nodemask.h	2004-04-08 04:25:24.000000000 -0700
+++ 2.6.5.bitmap/include/linux/nodemask.h	2004-04-08 04:52:56.000000000 -0700
@@ -0,0 +1,323 @@
+#ifndef __LINUX_NODEMASK_H
+#define __LINUX_NODEMASK_H
+
+/*
+ * Nodemasks provide a bitmap suitable for representing the
+ * set of Node's in a system, one bit position per Node number.
+ *
+ * See detailed comments in the file linux/bitmap.h describing the
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
+ * int num_online_nodes()		Number of online Nodes
+ * int num_possible_nodes()		Number of all possible Nodes
+ * int node_online(node)		Is some node online?
+ * int node_possible(node)		Is some node possible?
+ * void node_set_online(node)		set node in node_online_map
+ * void node_set_offline(node)		clear node in node_online_map
+ * int any_online_node(mask)		First online node in mask
+ *
+ * for_each_node_mask(node, mask)	for-loop node over mask
+ * for_each_node(node)			for-loop node over node_possible_map
+ * for_each_online_node(node)		for-loop node over node_online_map
+ */
+
+#include <linux/threads.h>
+#include <linux/bitmap.h>
+#include <asm/bug.h>
+
+typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
+extern nodemask_t _unused_nodemask_arg_;
+
+#define node_set(node, dst) __node_set((node), &(dst))
+static inline void __node_set(int node, volatile nodemask_t *dstp)
+{
+	if (node < MAX_NUMNODES)
+		set_bit(node, dstp->bits);
+}
+
+#define node_clear(node, dst) __node_clear((node), &(dst))
+static inline void __node_clear(int node, volatile nodemask_t *dstp)
+{
+	clear_bit(node, dstp->bits);
+}
+
+#define nodes_setall(dst) __nodes_setall(&(dst), MAX_NUMNODES)
+static inline void __nodes_setall(nodemask_t *dstp, int nbits)
+{
+	bitmap_fill(dstp->bits, nbits);
+}
+
+#define nodes_clear(dst) __nodes_clear(&(dst), MAX_NUMNODES)
+static inline void __nodes_clear(nodemask_t *dstp, int nbits)
+{
+	bitmap_clear(dstp->bits, nbits);
+}
+
+#define node_isset(node, nodemask) __node_isset((node), &(nodemask))
+static inline int __node_isset(int node, const volatile nodemask_t *addr)
+{
+	return test_bit(node, addr->bits);
+}
+
+#define node_test_and_set(node, nodemask) __node_test_and_set((node), &(nodemask))
+static inline int __node_test_and_set(int node, nodemask_t *addr)
+{
+	if (node < MAX_NUMNODES)
+		return test_and_set_bit(node, addr->bits);
+	else
+		return 0;
+}
+
+#define nodes_and(dst, src1, src2) \
+			__nodes_and(&(dst), &(src1), &(src2), MAX_NUMNODES)
+static inline void __nodes_and(nodemask_t *dstp, nodemask_t *src1p,
+					nodemask_t *src2p, int nbits)
+{
+	bitmap_and(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_or(dst, src1, src2) \
+			__nodes_or(&(dst), &(src1), &(src2), MAX_NUMNODES)
+static inline void __nodes_or(nodemask_t *dstp, nodemask_t *src1p,
+					nodemask_t *src2p, int nbits)
+{
+	bitmap_or(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_xor(dst, src1, src2) \
+			__nodes_xor(&(dst), &(src1), &(src2), MAX_NUMNODES)
+static inline void __nodes_xor(nodemask_t *dstp, nodemask_t *src1p,
+					nodemask_t *src2p, int nbits)
+{
+	bitmap_xor(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_andnot(dst, src1, src2) \
+			__nodes_andnot(&(dst), &(src1), &(src2), MAX_NUMNODES)
+static inline void __nodes_andnot(nodemask_t *dstp, nodemask_t *src1p,
+					nodemask_t *src2p, int nbits)
+{
+	bitmap_andnot(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_complement(dst, src) \
+			__nodes_complement(&(dst), &(src), MAX_NUMNODES)
+static inline void __nodes_complement(nodemask_t *dstp,
+					nodemask_t *srcp, int nbits)
+{
+	bitmap_complement(dstp->bits, srcp->bits, nbits);
+}
+
+#define nodes_equal(src1, src2) __nodes_equal(&(src1), &(src2), MAX_NUMNODES)
+static inline int __nodes_equal(nodemask_t *src1p,
+					nodemask_t *src2p, int nbits)
+{
+	return bitmap_equal(src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_intersects(src1, src2) \
+			__nodes_intersects(&(src1), &(src2), MAX_NUMNODES)
+static inline int __nodes_intersects(nodemask_t *src1p,
+					nodemask_t *src2p, int nbits)
+{
+	return bitmap_intersects(src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_subset(src1, src2) __nodes_subset(&(src1), &(src2), MAX_NUMNODES)
+static inline int __nodes_subset(nodemask_t *src1p,
+					nodemask_t *src2p, int nbits)
+{
+	return bitmap_subset(src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
+static inline int __nodes_empty(nodemask_t *srcp, int nbits)
+{
+	return bitmap_empty(srcp->bits, nbits);
+}
+
+#define nodes_full(nodemask) __nodes_full(&(nodemask), MAX_NUMNODES)
+static inline int __nodes_full(nodemask_t *srcp, int nbits)
+{
+	return bitmap_full(srcp->bits, nbits);
+}
+
+#define nodes_weight(nodemask) __nodes_weight(&(nodemask), MAX_NUMNODES)
+static inline int __nodes_weight(nodemask_t *srcp, int nbits)
+{
+	return bitmap_weight(srcp->bits, nbits);
+}
+
+#define nodes_shift_right(dst, src, n) \
+			__nodes_shift_right(&(dst), &(src), (n), MAX_NUMNODES)
+static inline void __nodes_shift_right(nodemask_t *dstp,
+					nodemask_t *srcp, int n, int nbits)
+{
+	bitmap_shift_right(dstp->bits, srcp->bits, n, nbits);
+}
+
+#define nodes_shift_left(dst, src, n) \
+			__nodes_shift_left(&(dst), &(src), (n), MAX_NUMNODES)
+static inline void __nodes_shift_left(nodemask_t *dstp,
+					nodemask_t *srcp, int n, int nbits)
+{
+	bitmap_shift_left(dstp->bits, srcp->bits, n, nbits);
+}
+
+#define first_node(src) __first_node(&(src), MAX_NUMNODES)
+static inline int __first_node(nodemask_t *srcp, int nbits)
+{
+	return find_first_bit(srcp->bits, nbits);
+}
+
+#define next_node(n, src) __next_node((n), &(src), MAX_NUMNODES)
+static inline int __next_node(int n, nodemask_t *srcp, int nbits)
+{
+	return find_next_bit(srcp->bits, nbits, n+1);
+}
+
+#define nodemask_of_node(node)						\
+({									\
+	typeof(_unused_nodemask_arg_) m;				\
+	int c = node;							\
+	if (sizeof(m) == sizeof(unsigned long)) {			\
+		if (c < MAX_NUMNODES)					\
+			m.bits[0] = 1UL<<c;				\
+	} else {							\
+		nodes_clear(m);						\
+		node_set(c, m);						\
+	}								\
+	m;								\
+})
+
+#define NODEMASK_LAST_WORD BITMAP_LAST_WORD_MASK(MAX_NUMNODES)
+
+#if MAX_NUMNODES <= BITS_PER_LONG
+
+#define NODE_MASK_ALL							\
+{ {									\
+	[BITS_TO_LONGS(MAX_NUMNODES)-1] = NODEMASK_LAST_WORD		\
+} }
+
+#else
+
+#define NODE_MASK_ALL							\
+{ {									\
+	[0 ... BITS_TO_LONGS(MAX_NUMNODES)-2] = ~0UL,			\
+	[BITS_TO_LONGS(MAX_NUMNODES)-1] = NODEMASK_LAST_WORD		\
+} }
+
+#endif
+
+#define NODE_MASK_NONE							\
+{ {									\
+	[0 ... BITS_TO_LONGS(MAX_NUMNODES)-1] =  0UL			\
+} }
+
+#define nodes_addr(src) ((src).bits)
+
+#define nodemask_scnprintf(buf, len, src) \
+			__nodemask_scnprintf((buf), (len), &(src), MAX_NUMNODES)
+static inline int __nodemask_scnprintf(char *buf, int len,
+					nodemask_t *srcp, int nbits)
+{
+	return bitmap_scnprintf(buf, len, srcp->bits, nbits);
+}
+
+#define nodemask_parse(ubuf, ulen, src) \
+			__nodemask_parse((ubuf), (ulen), &(src), MAX_NUMNODES)
+static inline int __nodemask_parse(const char __user *buf, int len,
+					nodemask_t *srcp, int nbits)
+{
+	return bitmap_parse(buf, len, srcp->bits, nbits);
+}
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
+#define num_online_nodes()	     nodes_weight(node_online_map)
+#define num_possible_nodes()	     nodes_weight(node_possible_map)
+#define node_online(node)	     node_isset((node), node_online_map)
+#define node_possible(node)	     node_isset((node), node_possible_map)
+#define node_set_online(node)	     node_set((node), node_online_map)
+#define node_set_offline(node)	     node_clear((node), node_online_map)
+
+#define any_online_node(mask)			\
+({						\
+	nodemask_t m;				\
+	nodes_and(m, mask, node_online_map);	\
+	first_node(m);				\
+})
+
+#define for_each_node_mask(node, mask)		\
+	for (node = first_node(mask);		\
+		node < MAX_NUMNODES;		\
+		node = next_node(node, mask))
+
+#else /* !CONFIG_NUMA */
+
+#define num_online_nodes()	     1
+#define num_possible_nodes()	     1
+#define node_online(node)	     ({ BUG_ON((node) != 0); 1; })
+#define node_possible(node)	     ({ BUG_ON((node) != 0); 1; })
+#define node_set_online(node)	     ({ BUG_ON((node) != 0); })
+#define node_set_offline(node)	     ({ BUG(); })
+
+#define any_online_node(mask)	     0
+
+#define for_each_node_mask(node, mask) for (node = 0; node < 1; node++)
+
+#endif /* CONFIG_NUMA */
+
+#define for_each_node(node)	     \
+			for_each_node_mask(node, node_possible_map)
+#define for_each_online_node(node)     \
+			for_each_node_mask(node, node_online_map)
+
+#endif /* __LINUX_NODEMASK_H */


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
