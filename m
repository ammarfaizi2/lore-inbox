Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUDABMl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 20:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUDABMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 20:12:41 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:44200 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261803AbUDABM1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 20:12:27 -0500
Subject: Re: [PATCH] mask ADT: new nodemask_t implementation [9/22]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20040329041318.57b87f0a.pj@sgi.com>
References: <20040329041318.57b87f0a.pj@sgi.com>
Content-Type: multipart/mixed; boundary="=-TyTmwqOk+1CUNUEYffyE"
Organization: IBM LTC
Message-Id: <1080781549.9787.57.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 31 Mar 2004 17:11:25 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TyTmwqOk+1CUNUEYffyE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-03-29 at 04:13, Paul Jackson wrote:
> Patch_9_of_22 - Add new nodemasks.h file.
> 	Provide a nodemasks_t type, using the mask.h ADT.

Paul,
	Some changes to include/linux/nodemask.h:

1) You didn't provide a num_possible_nodes() macro.

2) Dropped #include <linux/config.h>.  The very next include
(linux/numa.h) includes this file.

3) Dropped #include <linux/threads.h>.  Nothing in this file appeared to
be using anything from that file.

4) Indented all the node_* and nodes_* macros.  Massively more readable.

5) Made sure any macro call with more than 1 argument had its arguments
wrapped in parens.  It seemed like you were a bit inconsistent as to
whether or not the arguments to macros got parens.

6) Moved any_online_node() definition inside the #ifdef CONFIG_NUMA. 
There is an easy version of this macro for non-NUMA.  Plus it matches up
with cpumask.h.

Cheers!

-Matt

--=-TyTmwqOk+1CUNUEYffyE
Content-Disposition: attachment; filename=nodemask_h-mcd.patch
Content-Type: text/x-patch; name=nodemask_h-mcd.patch; charset=
Content-Transfer-Encoding: 7bit

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-pj_nodemask/include/linux/nodemask.h linux-2.6.4-nodemask_h-mcd/include/linux/nodemask.h
--- linux-2.6.4-pj_nodemask/include/linux/nodemask.h	Tue Mar 30 17:04:27 2004
+++ linux-2.6.4-nodemask_h-mcd/include/linux/nodemask.h	Wed Mar 31 16:21:56 2004
@@ -48,6 +48,7 @@
  * int nodemask_parse(ubuf, ulen, mask)	Parse ascii string as nodemask
  *
  * int num_online_nodes()		Number of online nodes
+ * int num_possible_nodes()		Number of all possible nodes
  * int node_online(node)		Is some node < MAX_NUMNODES online?
  * int node_possible(node)		Is some node < MAX_NUMNODES possible? 
  * void node_set_online(node)		set node in node_online_map
@@ -59,46 +60,44 @@
  * for_each_online_node(node)		for-loop node over node_online_map
  */
 
-#include <linux/config.h>
 #include <linux/numa.h>
 #include <linux/mask.h>
-#include <linux/threads.h>
 #include <asm/bug.h>
 
 typedef __mask(MAX_NUMNODES) nodemask_t;
 extern nodemask_t _unused_nodemask_arg_;
 
-#define node_set(node, mask) mask_setbit((node), (mask))
-#define node_clear(node, mask) mask_clearbit((node), (mask))
-#define nodes_setall(mask) mask_setall(mask, MAX_NUMNODES)
-#define nodes_clear(mask) mask_clearall(mask)
-#define node_isset(node, mask) mask_isset((node), (mask))
-#define node_test_and_set(node, mask) mask_test_and_set((node), (mask))
-#define nodes_and(dst, src1, src2) mask_and((dst), (src1), (src2))
-#define nodes_or(dst, src1, src2) mask_or((dst), (src1), (src2))
-#define nodes_xor(dst, src1, src2) mask_xor((dst), (src1), (src2))
-#define nodes_andnot(dst, src1, src2) mask_andnot((dst), (src1), (src2))
-#define nodes_complement(dst, src) mask_complement((dst), (src), MAX_NUMNODES)
-#define nodes_equal(mask1, mask2) mask_equal((mask1), (mask2))
-#define nodes_intersects(mask1, mask2) mask_intersects(mask1, mask2)
-#define nodes_subset(mask1, mask2) mask_subset(mask1, mask2)
-#define nodes_empty(mask) mask_empty(mask)
-#define nodes_full(mask) mask_full(mask, MAX_NUMNODES)
-#define nodes_weight(mask) mask_weight(mask, MAX_NUMNODES)
-#define nodes_shift_right(dst, src, n) \
+#define node_set(node, mask)		mask_setbit((node), (mask))
+#define node_clear(node, mask)		mask_clearbit((node), (mask))
+#define nodes_setall(mask)		mask_setall((mask), MAX_NUMNODES)
+#define nodes_clear(mask)		mask_clearall(mask)
+#define node_isset(node, mask)		mask_isset((node), (mask))
+#define node_test_and_set(node, mask)	mask_test_and_set((node), (mask))
+#define nodes_and(dst, src1, src2)	mask_and((dst), (src1), (src2))
+#define nodes_or(dst, src1, src2)	mask_or((dst), (src1), (src2))
+#define nodes_xor(dst, src1, src2)	mask_xor((dst), (src1), (src2))
+#define nodes_andnot(dst, src1, src2)	mask_andnot((dst), (src1), (src2))
+#define nodes_complement(dst, src)	mask_complement((dst), (src), MAX_NUMNODES)
+#define nodes_equal(mask1, mask2)	mask_equal((mask1), (mask2))
+#define nodes_intersects(mask1, mask2)	mask_intersects((mask1), (mask2))
+#define nodes_subset(mask1, mask2)	mask_subset((mask1), (mask2))
+#define nodes_empty(mask)		mask_empty(mask)
+#define nodes_full(mask)		mask_full((mask), MAX_NUMNODES)
+#define nodes_weight(mask)		mask_weight((mask), MAX_NUMNODES)
+#define nodes_shift_right(dst, src, n)	\
 			mask_shift_right((dst), (src), (n), MAX_NUMNODES)
-#define nodes_shift_left(dst, src, n) \
+#define nodes_shift_left(dst, src, n)	\
 			mask_shift_left((dst), (src), (n), MAX_NUMNODES)
-#define first_node(mask) mask_first(mask, MAX_NUMNODES)
-#define next_node(node, mask) mask_next(node, mask, MAX_NUMNODES)
-#define nodemask_of_node(node) mask_of_bit((node), _unused_nodemask_arg_)
-#define NODE_MASK_ALL MASK_ALL(MAX_NUMNODES)
-#define NODE_MASK_NONE MASK_NONE(MAX_NUMNODES)
-#define nodes_raw(mask) mask_raw(mask)
+#define first_node(mask)		mask_first((mask), MAX_NUMNODES)
+#define next_node(node, mask)		mask_next((node), (mask), MAX_NUMNODES)
+#define nodemask_of_node(node)		mask_of_bit((node), _unused_nodemask_arg_)
+#define NODE_MASK_ALL			MASK_ALL(MAX_NUMNODES)
+#define NODE_MASK_NONE			MASK_NONE(MAX_NUMNODES)
+#define nodes_raw(mask)			mask_raw(mask)
 #define nodemask_scnprintf(buf, len, mask) \
-			mask_scnprintf(buf, len, mask, MAX_NUMNODES)
+			mask_scnprintf((buf), (len), (mask), MAX_NUMNODES)
 #define nodemask_parse(ubuf, ulen, mask) \
-			mask_parse(ubuf, ulen, mask, MAX_NUMNODES)
+			mask_parse((ubuf), (ulen), (mask), MAX_NUMNODES)
 
 /*
  * The following particular system nodemasks and operations
@@ -111,10 +110,18 @@ extern nodemask_t node_possible_map;
 #ifdef CONFIG_NUMA
 
 #define num_online_nodes()		nodes_weight(node_online_map)
-#define node_online(node)		node_isset(node, node_online_map)
-#define node_possible(node) 		node_isset(node, node_possible_map)
-#define node_set_online(node)		node_set(node, node_online_map)
-#define node_set_offline(node)		node_clear(node, node_online_map)
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
 
 #define for_each_node_mask(node, mask)		\
 	for (node = first_node(mask);		\
@@ -124,23 +131,21 @@ extern nodemask_t node_possible_map;
 #else /* !CONFIG_NUMA */
 
 #define num_online_nodes()		1
+#define num_possible_nodes()		1
 #define node_online(node)		({ BUG_ON((node) != 0); 1; })
 #define node_possible(node)		({ BUG_ON((node) != 0); 1; })
 #define node_set_online(node)		({ BUG_ON((node) != 0); })
 #define node_set_offline(node)		({ BUG(); })
 
+#define any_online_node(mask)		0
+
 #define for_each_node_mask(node, mask)	for (node = 0; node < 1; node++)
 
 #endif /* CONFIG_NUMA */
 
-#define for_each_node(node) for_each_node_mask(node, node_possible_map)
-#define for_each_online_node(node) for_each_node_mask(node, node_online_map)
-
-#define any_online_node(mask)			\
-({						\
-        nodemask_t n;				\
-        nodes_and(n, mask, node_online_map);	\
-        first_node(n);				\
-})
+#define for_each_node(node)		\
+			for_each_node_mask(node, node_possible_map)
+#define for_each_online_node(node)	\
+			for_each_node_mask(node, node_online_map)
 
 #endif /* __LINUX_NODEMASK_H */

--=-TyTmwqOk+1CUNUEYffyE--

