Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUCRXGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbUCRXGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:06:34 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:39408 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261389AbUCRXFO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:05:14 -0500
Subject: [PATCH] nodemask_t definitions [1/7]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com
Content-Type: multipart/mixed; boundary="=-DzINul5xTtIy1p+jrWll"
Organization: IBM LTC
Message-Id: <1079651068.8149.160.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 18 Mar 2004 15:04:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DzINul5xTtIy1p+jrWll
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

nodemask_t-01-definitions.patch - The basic definitions of the
nodemask_t type: include/linux/nodemask.h,
include/asm-generic/{nodemask.h, nodemask_arith.h, nodemask_array.h,
nodemask_const_reference.h, nodemask_const_value.h, nodemask_nonuma.h},
and some small changes to include/linux/mmzone.h (removing extistant
definition of node_online_map and helper functions).

--=-DzINul5xTtIy1p+jrWll
Content-Disposition: attachment; filename=nodemask_t-01-definitions.patch
Content-Type: text/x-patch; name=nodemask_t-01-definitions.patch; charset=
Content-Transfer-Encoding: 7bit

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/asm-generic/nodemask.h linux-2.6.4-nodemask_t-definitions/include/asm-generic/nodemask.h
--- linux-2.6.4-vanilla/include/asm-generic/nodemask.h	Wed Dec 31 16:00:00 1969
+++ linux-2.6.4-nodemask_t-definitions/include/asm-generic/nodemask.h	Thu Mar 11 11:57:34 2004
@@ -0,0 +1,44 @@
+#ifndef __ASM_GENERIC_NODEMASK_H
+#define __ASM_GENERIC_NODEMASK_H
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/numa.h>
+#include <linux/types.h>
+#include <linux/bitmap.h>
+
+
+#if MAX_NUMNODES > BITS_PER_LONG
+
+#define NODE_ARRAY_SIZE		BITS_TO_LONGS(MAX_NUMNODES)
+struct nodemask
+{
+	unsigned long mask[NODE_ARRAY_SIZE];
+};
+typedef struct nodemask nodemask_t;
+
+#else /* MAX_NUMNODES <= BITS_PER_LONG */
+typedef unsigned long nodemask_t;
+#endif
+
+
+#ifdef CONFIG_NUMA
+
+#if MAX_NUMNODES > BITS_PER_LONG
+#include <asm-generic/nodemask_array.h>
+#else
+#include <asm-generic/nodemask_arith.h>
+#endif
+
+#else /* !CONFIG_NUMA */
+#include <asm-generic/nodemask_nonuma.h>
+#endif /* CONFIG_NUMA */
+
+
+#if MAX_NUMNODES <= 4*BITS_PER_LONG
+#include <asm-generic/nodemask_const_value.h>
+#else
+#include <asm-generic/nodemask_const_reference.h>
+#endif
+
+#endif /* __ASM_GENERIC_NODEMASK_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/asm-generic/nodemask_arith.h linux-2.6.4-nodemask_t-definitions/include/asm-generic/nodemask_arith.h
--- linux-2.6.4-vanilla/include/asm-generic/nodemask_arith.h	Wed Dec 31 16:00:00 1969
+++ linux-2.6.4-nodemask_t-definitions/include/asm-generic/nodemask_arith.h	Thu Mar 11 11:57:34 2004
@@ -0,0 +1,48 @@
+#ifndef __ASM_GENERIC_NODEMASK_ARITH_H
+#define __ASM_GENERIC_NODEMASK_ARITH_H
+
+/*
+ * Arithmetic-based node bitmaps. A single unsigned long is used to contain the
+ * whole node bitmap.
+ */
+
+#define node_set(node, map)		set_bit(node, &(map))
+#define node_clear(node, map)		clear_bit(node, &(map))
+#define node_isset(node, map)		test_bit(node, &(map))
+#define node_test_and_set(node, map)	test_and_set_bit(node, &(map))
+
+#define nodes_and(d, s1, s2)		do { d = (s1) & (s2); } while (0)
+#define nodes_or(d, s1, s2)		do { d = (s1) | (s2); } while (0)
+#define nodes_clear(map)		do { map = 0UL; } while (0)
+#define nodes_complement(map)		do { map = ~(map); } while (0)
+#define nodes_equal(map1, map2)		((map1) == (map2))
+#define nodes_empty(map)		((map) == 0UL)
+#define nodes_addr(map)			(&(map))
+
+#if BITS_PER_LONG == 32
+#define nodes_weight(map)		hweight32(map)
+#elif BITS_PER_LONG == 64
+#define nodes_weight(map)		hweight64(map)
+#endif
+
+#define nodes_shift_right(d, s, n)	do { d = (s) >> (n); } while (0)
+#define nodes_shift_left(d, s, n)	do { d = (s) << (n); } while (0)
+
+#define first_node(map)			__ffs(map)
+#define next_node(node, map)		find_next_bit(&(map), MAX_NUMNODES, node + 1)
+#define any_online_node(map)					\
+({								\
+	nodemask_t __tmp__;					\
+	nodes_and(__tmp__, map, node_online_map);		\
+	__tmp__ ? first_node(__tmp__) : MAX_NUMNODES;		\
+})
+#define nodemask_of_node(node)		({ ((nodemask_t)1) << (node); })
+
+/* only ever use this for things that are _never_ used on large boxen */
+#define nodes_coerce(map)		((unsigned long)(map))
+#define nodes_promote(map)		({ map; })
+
+#define NODE_MASK_ALL	(~((nodemask_t)0) >> (8*sizeof(nodemask_t) - MAX_NUMNODES))
+#define NODE_MASK_NONE	((nodemask_t)0)
+
+#endif /* __ASM_GENERIC_NODEMASK_ARITH_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/asm-generic/nodemask_array.h linux-2.6.4-nodemask_t-definitions/include/asm-generic/nodemask_array.h
--- linux-2.6.4-vanilla/include/asm-generic/nodemask_array.h	Wed Dec 31 16:00:00 1969
+++ linux-2.6.4-nodemask_t-definitions/include/asm-generic/nodemask_array.h	Thu Mar 11 11:57:34 2004
@@ -0,0 +1,51 @@
+#ifndef __ASM_GENERIC_NODEMASK_ARRAY_H
+#define __ASM_GENERIC_NODEMASK_ARRAY_H
+
+/*
+ * Array-based node bitmaps. An array of unsigned longs is used to contain
+ * the bitmap, and then contained in a structure so it may be passed by value.
+ */
+
+#define node_set(node, map)	set_bit(node, (map).mask)
+#define node_clear(node, map)	clear_bit(node, (map).mask)
+#define node_isset(node, map)	test_bit(node, (map).mask)
+#define node_test_and_set(node, map) test_and_set_bit(node, (map).mask)
+
+#define nodes_and(d,s1,s2)	bitmap_and((d).mask,(s1).mask, (s2).mask, MAX_NUMNODES)
+#define nodes_or(d,s1,s2)	bitmap_or((d).mask, (s1).mask, (s2).mask, MAX_NUMNODES)
+#define nodes_clear(map)	bitmap_clear((map).mask, MAX_NUMNODES)
+#define nodes_complement(map)	bitmap_complement((map).mask, MAX_NUMNODES)
+#define nodes_equal(map1, map2)	bitmap_equal((map1).mask, (map2).mask, MAX_NUMNODES)
+#define nodes_empty(map)	bitmap_empty((map).mask, MAX_NUMNODES)
+#define nodes_addr(map)		((map).mask)
+
+#define nodes_weight(map)	bitmap_weight((map).mask, MAX_NUMNODES)
+
+#define nodes_shift_right(d, s, n) bitmap_shift_right((d).mask, (s).mask, n, MAX_NUMNODES)
+#define nodes_shift_left(d, s, n)   bitmap_shift_left((d).mask, (s).mask, n, MAX_NUMNODES)
+
+#define first_node(map)		find_first_bit((map).mask, MAX_NUMNODES)
+#define next_node(node, map)	find_next_bit((map).mask, MAX_NUMNODES, node + 1)
+#define any_online_node(map)	({ nodemask_t __tmp__;				\
+				   nodes_and(__tmp__, map, node_online_map);	\
+				   find_first_bit(__tmp__.mask, MAX_NUMNODES);	\
+				})
+#define nodemask_of_node(node)	({ nodemask_t __node_mask = NODE_MASK_NONE;	\
+				   node_set(node, __node_mask);			\
+				   __node_mask;					\
+				})
+
+/* only ever use this for things that are _never_ used on large boxen */
+#define nodes_coerce(map)	((map).mask[0])
+#define nodes_promote(map)	({ nodemask_t __node_mask = NODE_MASK_NONE;	\
+				   __node_mask.mask[0] = map;			\
+				   __node_mask;					\
+				})
+
+/*
+ * um, these need to be usable as static initializers
+ */
+#define NODE_MASK_ALL	{ {[0 ... NODE_ARRAY_SIZE-1] = ~0UL} }
+#define NODE_MASK_NONE	{ {[0 ... NODE_ARRAY_SIZE-1] =  0UL} }
+
+#endif /* __ASM_GENERIC_NODEMASK_ARRAY_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/asm-generic/nodemask_const_reference.h linux-2.6.4-nodemask_t-definitions/include/asm-generic/nodemask_const_reference.h
--- linux-2.6.4-vanilla/include/asm-generic/nodemask_const_reference.h	Wed Dec 31 16:00:00 1969
+++ linux-2.6.4-nodemask_t-definitions/include/asm-generic/nodemask_const_reference.h	Thu Mar 11 11:57:34 2004
@@ -0,0 +1,27 @@
+#ifndef __ASM_GENERIC_NODEMASK_CONST_REFERENCE_H
+#define __ASM_GENERIC_NODEMASK_CONST_REFERENCE_H
+
+struct nodemask_ref {
+	const nodemask_t *val;
+};
+
+typedef const struct nodemask_ref nodemask_const_t;
+
+#define mk_nodemask_const(map)		((nodemask_const_t){ &(map) })
+#define node_isset_const(node, map)	node_isset(node, *(map).val)
+
+#define nodes_and_const(dst,src1,src2)	nodes_and(dst,*(src1).val,*(src2).val)
+#define nodes_or_const(dst,src1,src2)	nodes_or(dst,*(src1).val,*(src2).val)
+#define nodes_equal_const(map1, map2)	nodes_equal(*(map1).val, *(map2).val)
+#define nodes_copy_const(map1, map2)	bitmap_copy((map1).mask, (map2).val->mask, MAX_NUMNODES)
+
+#define nodes_empty_const(map)		nodes_empty(*(map).val)
+#define nodes_weight_const(map)		nodes_weight(*(map).val)
+#define first_node_const(map)		first_node(*(map).val)
+#define next_node_const(node, map)	next_node(node, *(map).val)
+
+/* only ever use this for things that are _never_ used on large boxen */
+#define nodes_coerce_const(map)		nodes_coerce(*(map).val)
+#define any_online_node_const(map)	any_online_node(*(map).val)
+
+#endif /* __ASM_GENERIC_NODEMASK_CONST_REFERENCE_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/asm-generic/nodemask_const_value.h linux-2.6.4-nodemask_t-definitions/include/asm-generic/nodemask_const_value.h
--- linux-2.6.4-vanilla/include/asm-generic/nodemask_const_value.h	Wed Dec 31 16:00:00 1969
+++ linux-2.6.4-nodemask_t-definitions/include/asm-generic/nodemask_const_value.h	Thu Mar 11 11:57:34 2004
@@ -0,0 +1,21 @@
+#ifndef __ASM_GENERIC_NODEMASK_CONST_VALUE_H
+#define __ASM_GENERIC_NODEMASK_CONST_VALUE_H
+
+typedef const nodemask_t nodemask_const_t;
+
+#define mk_nodemask_const(map)		(map)
+#define node_isset_const(node, map)	node_isset(node, map)
+#define nodes_and_const(dst,src1,src2)	nodes_and(dst, src1, src2)
+#define nodes_or_const(dst,src1,src2)	nodes_or(dst, src1, src2)
+#define nodes_equal_const(map1, map2)	nodes_equal(map1, map2)
+#define nodes_empty_const(map)		nodes_empty(map)
+#define nodes_copy_const(map1, map2)	do { map1 = (nodemask_t)map2; } while (0)
+#define nodes_weight_const(map)		nodes_weight(map)
+#define first_node_const(map)		first_node(map)
+#define next_node_const(node, map)	next_node(node, map)
+
+/* only ever use this for things that are _never_ used on large boxen */
+#define nodes_coerce_const(map)		nodes_coerce(map)
+#define any_online_node_const(map)	any_online_node(map)
+
+#endif /* __ASM_GENERIC_NODEMASK_CONST_VALUE_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/asm-generic/nodemask_nonuma.h linux-2.6.4-nodemask_t-definitions/include/asm-generic/nodemask_nonuma.h
--- linux-2.6.4-vanilla/include/asm-generic/nodemask_nonuma.h	Wed Dec 31 16:00:00 1969
+++ linux-2.6.4-nodemask_t-definitions/include/asm-generic/nodemask_nonuma.h	Thu Mar 11 11:57:34 2004
@@ -0,0 +1,47 @@
+#ifndef __ASM_GENERIC_NODEMASK_NONUMA_H
+#define __ASM_GENERIC_NODEMASK_NONUMA_H
+
+/*
+ * Arithmetic-based node bitmaps for non-NUMA systems. A single unsigned long
+ * is used, but only the first bit is ever set/cleared.
+ */
+
+#define node_set(node, map)		do { if ((node) == 0) map = 1UL; } while (0)
+#define node_clear(node, map)		do { if ((node) == 0) map = 0UL; } while (0)
+#define node_isset(node, map)		((node) == 0 && (map) != 0UL)
+#define node_test_and_set(node, map)	((node) == 0 ? test_and_set_bit(0, &(map)) : 0)
+
+#define nodes_and(d, s1, s2)		do { d = (s1) & (s2); } while (0)
+#define nodes_or(d, s1, s2)		do { d = (s1) | (s2); } while (0)
+#define nodes_clear(map)		do { map = 0UL; } while (0)
+#define nodes_complement(map)		do { map = !(map); } while (0)
+#define nodes_equal(map1, map2)		((map1) == (map2))
+#define nodes_empty(map)		((map) == 0UL)
+#define nodes_addr(map)			(&(map))
+
+#define nodes_weight(map)		((map) != 0UL ? 1 : 0)
+
+#define nodes_shift_right(d, s, n)	do { d = (n) == 0 ? (s) : 0UL; } while (0)
+#define nodes_shift_left(d, s, n)	do { d = (n) == 0 ? (s) : 0UL; } while (0)
+
+#define first_node(map)			(nodes_empty(map) ? MAX_NUMNODES : 0)
+#define next_node(node, map)		(MAX_NUMNODES)
+#define any_online_node(map)		(first_node(map))
+#define nodemask_of_node(node)		((node) == 0 ? 1UL : 0UL)
+
+/* only ever use this for things that are _never_ used on large boxen */
+#define nodes_coerce(map)		((unsigned long)(map))
+#define nodes_promote(map)					\
+	({							\
+		nodemask_t __tmp__;				\
+		nodes_coerce(__tmp__) = map;			\
+		__tmp__;					\
+	})
+
+/*
+ * um, these need to be usable as static initializers
+ */
+#define NODE_MASK_ALL	1UL
+#define NODE_MASK_NONE	0UL
+
+#endif /* __ASM_GENERIC_NODEMASK_NONUMA_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/linux/mmzone.h linux-2.6.4-nodemask_t-definitions/include/linux/mmzone.h
--- linux-2.6.4-vanilla/include/linux/mmzone.h	Wed Mar 10 18:55:28 2004
+++ linux-2.6.4-nodemask_t-definitions/include/linux/mmzone.h	Mon Mar 15 16:57:21 2004
@@ -11,6 +11,7 @@
 #include <linux/cache.h>
 #include <linux/threads.h>
 #include <linux/numa.h>
+#include <linux/nodemask.h>
 #include <asm/atomic.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -218,7 +219,6 @@ typedef struct pglist_data {
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
 #define node_spanned_pages(nid)	(NODE_DATA(nid)->node_spanned_pages)
 
-extern int numnodes;
 extern struct pglist_data *pgdat_list;
 
 void get_zone_counts(unsigned long *active, unsigned long *inactive,
@@ -336,35 +336,6 @@ extern struct pglist_data contig_page_da
 #error ZONES_SHIFT > MAX_ZONES_SHIFT
 #endif
 
-extern DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
-
-#if defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_NUMA)
-
-#define node_online(node)	test_bit(node, node_online_map)
-#define node_set_online(node)	set_bit(node, node_online_map)
-#define node_set_offline(node)	clear_bit(node, node_online_map)
-static inline unsigned int num_online_nodes(void)
-{
-	int i, num = 0;
-
-	for(i = 0; i < MAX_NUMNODES; i++){
-		if (node_online(i))
-			num++;
-	}
-	return num;
-}
-
-#else /* !CONFIG_DISCONTIGMEM && !CONFIG_NUMA */
-
-#define node_online(node) \
-	({ BUG_ON((node) != 0); test_bit(node, node_online_map); })
-#define node_set_online(node) \
-	({ BUG_ON((node) != 0); set_bit(node, node_online_map); })
-#define node_set_offline(node) \
-	({ BUG_ON((node) != 0); clear_bit(node, node_online_map); })
-#define num_online_nodes()	1
-
-#endif /* CONFIG_DISCONTIGMEM || CONFIG_NUMA */
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MMZONE_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/linux/nodemask.h linux-2.6.4-nodemask_t-definitions/include/linux/nodemask.h
--- linux-2.6.4-vanilla/include/linux/nodemask.h	Wed Dec 31 16:00:00 1969
+++ linux-2.6.4-nodemask_t-definitions/include/linux/nodemask.h	Tue Mar 16 15:52:04 2004
@@ -0,0 +1,44 @@
+#ifndef __LINUX_NODEMASK_H
+#define __LINUX_NODEMASK_H
+
+#include <linux/numa.h>
+#include <linux/bitmap.h>
+#include <asm-generic/nodemask.h>
+#include <asm/bug.h>
+
+extern nodemask_t node_online_map;
+extern nodemask_t node_possible_map;
+
+#ifdef CONFIG_NUMA
+
+#define num_online_nodes()		nodes_weight(node_online_map)
+#define node_online(node)		node_isset(node, node_online_map)
+#define node_possible(node)		node_isset(node, node_possible_map)
+#define node_set_online(node)		node_set(node, node_online_map)
+#define node_set_offline(node)		node_clear(node, node_online_map)
+
+#else /* !CONFIG_NUMA */
+
+#define num_online_nodes()		(1)
+#define node_online(node)		({ BUG_ON((node) != 0); 1; })
+#define node_possible(node)		({ BUG_ON((node) != 0); 1; })
+#define node_set_online(node)		({ BUG_ON((node) != 0); })
+#define node_set_offline(node)		({ BUG(); })
+
+#endif /* CONFIG_NUMA */
+
+#define for_each_node_mask(node, mask)					\
+	for (node = first_node_const(mk_nodemask_const(mask));		\
+		node < MAX_NUMNODES;					\
+		node = next_node_const(node, mk_nodemask_const(mask)))
+
+#define for_each_node(node) 		for_each_node_mask(node, node_possible_map)
+#define for_each_online_node(node)	for_each_node_mask(node, node_online_map)
+
+#define nodemask_snprintf(buf, buflen, map)				\
+	bitmap_snprintf(buf, buflen, nodes_addr(map), MAX_NUMNODES)
+
+#define nodemask_parse(buf, buflen, map)				\
+	bitmap_parse(buf, buflen, nodes_addr(map), MAX_NUMNODES)
+
+#endif /* __LINUX_NODEMASK_H */

--=-DzINul5xTtIy1p+jrWll--

