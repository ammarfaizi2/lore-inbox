Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266248AbUGPBS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266248AbUGPBS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 21:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUGPBS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 21:18:29 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:21685 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266248AbUGPBRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 21:17:54 -0400
Subject: [PATCH] Create nodemask_t
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-9LRmCH+WYzasotudewlu"
Organization: IBM LTC
Message-Id: <1089940642.27314.210.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 15 Jul 2004 18:17:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9LRmCH+WYzasotudewlu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Late, but not forgotten, here's the somewhat anticipated nodemask_t
patch.

The idea behind this patch is to create a nodemask_t as a node analog of
cpumask_t.  As NUMA machines become more common, the need for a
standard, cross-platform bitmap of both online & possible nodes becomes
more apparent.  We believe we've worked out most of the kinks of the
variable length bitmap types with the recent cpumask_t patches. 
Nodemasks are also currently far less widespread than cpumasks. 
Further, inclusion at this point in the kernel would mean consistency in
node handling between 2.6 and 2.7.

Future goals would be to get rid of the 'numnodes' variable used to
count the number of online nodes, and replace with node_online_map. 
This would allow arbitrary node numbering and facilitate node
hotplugging.

With that, I would like to submit the following patch for discussion,
and eventually, inclusion.

Thanks!

-Matt

--=-9LRmCH+WYzasotudewlu
Content-Disposition: attachment; filename=nodemask_t.patch
Content-Type: text/x-patch; name=nodemask_t.patch; charset=
Content-Transfer-Encoding: 7bit

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/arch/i386/kernel/numaq.c linux-2.6.7-mm7+nodemask_t/arch/i386/kernel/numaq.c
--- linux-2.6.7-mm7/arch/i386/kernel/numaq.c	2004-07-12 10:39:03.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/arch/i386/kernel/numaq.c	2004-07-13 14:40:03.000000000 -0700
@@ -28,6 +28,7 @@
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
 #include <linux/module.h>
+#include <linux/nodemask.h>
 #include <asm/numaq.h>
 
 /* These are needed before the pgdat's are created */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/arch/i386/kernel/srat.c linux-2.6.7-mm7+nodemask_t/arch/i386/kernel/srat.c
--- linux-2.6.7-mm7/arch/i386/kernel/srat.c	2004-07-12 10:39:03.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/arch/i386/kernel/srat.c	2004-07-13 14:40:03.000000000 -0700
@@ -28,6 +28,7 @@
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
 #include <linux/acpi.h>
+#include <linux/nodemask.h>
 #include <asm/srat.h>
 
 /*
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/arch/i386/mach-default/topology.c linux-2.6.7-mm7+nodemask_t/arch/i386/mach-default/topology.c
--- linux-2.6.7-mm7/arch/i386/mach-default/topology.c	2004-06-15 22:19:52.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/arch/i386/mach-default/topology.c	2004-07-13 14:40:03.000000000 -0700
@@ -27,6 +27,7 @@
  */
 #include <linux/init.h>
 #include <linux/smp.h>
+#include <linux/nodemask.h>
 #include <asm/cpu.h>
 
 struct i386_cpu cpu_devices[NR_CPUS];
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/arch/i386/mm/discontig.c linux-2.6.7-mm7+nodemask_t/arch/i386/mm/discontig.c
--- linux-2.6.7-mm7/arch/i386/mm/discontig.c	2004-07-12 10:39:04.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/arch/i386/mm/discontig.c	2004-07-13 14:40:03.000000000 -0700
@@ -28,6 +28,7 @@
 #include <linux/mmzone.h>
 #include <linux/highmem.h>
 #include <linux/initrd.h>
+#include <linux/nodemask.h>
 #include <asm/e820.h>
 #include <asm/setup.h>
 #include <asm/mmzone.h>
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/arch/ia64/kernel/acpi.c linux-2.6.7-mm7+nodemask_t/arch/ia64/kernel/acpi.c
--- linux-2.6.7-mm7/arch/ia64/kernel/acpi.c	2004-07-12 10:39:04.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/arch/ia64/kernel/acpi.c	2004-07-13 14:40:03.000000000 -0700
@@ -43,6 +43,7 @@
 #include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/mmzone.h>
+#include <linux/nodemask.h>
 #include <asm/io.h>
 #include <asm/iosapic.h>
 #include <asm/machvec.h>
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/arch/ia64/mm/discontig.c linux-2.6.7-mm7+nodemask_t/arch/ia64/mm/discontig.c
--- linux-2.6.7-mm7/arch/ia64/mm/discontig.c	2004-07-12 10:39:05.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/arch/ia64/mm/discontig.c	2004-07-13 14:40:03.000000000 -0700
@@ -16,6 +16,7 @@
 #include <linux/bootmem.h>
 #include <linux/acpi.h>
 #include <linux/efi.h>
+#include <linux/nodemask.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/meminit.h>
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/arch/ppc64/kernel/sysfs.c linux-2.6.7-mm7+nodemask_t/arch/ppc64/kernel/sysfs.c
--- linux-2.6.7-mm7/arch/ppc64/kernel/sysfs.c	2004-07-12 10:39:07.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/arch/ppc64/kernel/sysfs.c	2004-07-13 14:40:03.000000000 -0700
@@ -5,6 +5,7 @@
 #include <linux/percpu.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/nodemask.h>
 #include <asm/current.h>
 #include <asm/processor.h>
 #include <asm/cputable.h>
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/arch/ppc64/mm/numa.c linux-2.6.7-mm7+nodemask_t/arch/ppc64/mm/numa.c
--- linux-2.6.7-mm7/arch/ppc64/mm/numa.c	2004-07-12 10:39:07.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/arch/ppc64/mm/numa.c	2004-07-13 14:40:03.000000000 -0700
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/module.h>
+#include <linux/nodemask.h>
 #include <asm/lmb.h>
 #include <asm/machdep.h>
 #include <asm/abs_addr.h>
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/arch/x86_64/mm/k8topology.c linux-2.6.7-mm7+nodemask_t/arch/x86_64/mm/k8topology.c
--- linux-2.6.7-mm7/arch/x86_64/mm/k8topology.c	2004-06-15 22:20:21.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/arch/x86_64/mm/k8topology.c	2004-07-13 14:40:03.000000000 -0700
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/module.h>
+#include <linux/nodemask.h>
 #include <asm/io.h>
 #include <linux/pci_ids.h>
 #include <asm/types.h>
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/arch/x86_64/mm/numa.c linux-2.6.7-mm7+nodemask_t/arch/x86_64/mm/numa.c
--- linux-2.6.7-mm7/arch/x86_64/mm/numa.c	2004-07-12 10:39:11.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/arch/x86_64/mm/numa.c	2004-07-13 14:40:03.000000000 -0700
@@ -10,6 +10,7 @@
 #include <linux/mmzone.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
+#include <linux/nodemask.h>
 #include <asm/e820.h>
 #include <asm/proto.h>
 #include <asm/dma.h>
@@ -151,9 +152,9 @@ void __init numa_init_array(void)
 	for (i = 0; i < MAXNODE; i++) {
 		if (node_online(i))
 			continue;
-		rr = find_next_bit(node_online_map, MAX_NUMNODES, rr);
+		rr = next_node(rr, node_online_map);
 		if (rr == MAX_NUMNODES)
-			rr = find_first_bit(node_online_map, MAX_NUMNODES);
+			rr = first_node(node_online_map);
 		node_data[i] = node_data[rr];
 		cpu_to_node[i] = rr;
 		rr++; 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/include/asm-i386/cpu.h linux-2.6.7-mm7+nodemask_t/include/asm-i386/cpu.h
--- linux-2.6.7-mm7/include/asm-i386/cpu.h	2004-06-15 22:19:42.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/include/asm-i386/cpu.h	2004-07-13 14:40:03.000000000 -0700
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/cpu.h>
 #include <linux/topology.h>
+#include <linux/nodemask.h>
 
 #include <asm/node.h>
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/include/asm-i386/node.h linux-2.6.7-mm7+nodemask_t/include/asm-i386/node.h
--- linux-2.6.7-mm7/include/asm-i386/node.h	2004-06-15 22:19:02.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/include/asm-i386/node.h	2004-07-13 14:40:03.000000000 -0700
@@ -5,6 +5,7 @@
 #include <linux/mmzone.h>
 #include <linux/node.h>
 #include <linux/topology.h>
+#include <linux/nodemask.h>
 
 struct i386_node {
 	struct node node;
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/include/asm-x86_64/numa.h linux-2.6.7-mm7+nodemask_t/include/asm-x86_64/numa.h
--- linux-2.6.7-mm7/include/asm-x86_64/numa.h	2004-06-15 22:18:52.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/include/asm-x86_64/numa.h	2004-07-13 14:40:03.000000000 -0700
@@ -1,6 +1,8 @@
 #ifndef _ASM_X8664_NUMA_H 
 #define _ASM_X8664_NUMA_H 1
 
+#include <linux/nodemask.h>
+
 #define MAXNODE 8 
 #define NODEMASK 0xff
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/include/linux/mmzone.h linux-2.6.7-mm7+nodemask_t/include/linux/mmzone.h
--- linux-2.6.7-mm7/include/linux/mmzone.h	2004-07-12 10:39:40.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/include/linux/mmzone.h	2004-07-13 14:40:03.000000000 -0700
@@ -411,35 +411,6 @@ extern struct pglist_data contig_page_da
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
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/include/linux/nodemask.h linux-2.6.7-mm7+nodemask_t/include/linux/nodemask.h
--- linux-2.6.7-mm7/include/linux/nodemask.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.7-mm7+nodemask_t/include/linux/nodemask.h	2004-07-15 13:55:36.000000000 -0700
@@ -0,0 +1,328 @@
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
+ * int nodes_weight(mask)		Hamming weight - number of set bits
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
+ * for_each_node_mask(node, mask)	for-loop node over mask
+ *
+ * int num_online_nodes()		Number of online Nodes
+ * int num_possible_nodes()		Number of all possible Nodes
+ *
+ * int node_online(node)		Is some node online?
+ * int node_possible(node)		Is some node possible?
+ *
+ * int any_online_node(mask)		First online node in mask
+ *
+ * node_set_online(node)		set bit 'node' in node_online_map
+ * node_set_offline(node)		clear bit 'node' in node_online_map
+ *
+ * for_each_node(node)			for-loop node over node_possible_map
+ * for_each_online_node(node)		for-loop node over node_online_map
+ *
+ * Subtlety:
+ * 1) The 'type-checked' form of node_isset() causes gcc (3.3.2, anyway)
+ *    to generate slightly worse code.  Note for example the additional
+ *    40 lines of assembly code compiling the "for each possible node"
+ *    loops buried in the disk_stat_read() macros calls when compiling
+ *    drivers/block/genhd.c (arch i386, CONFIG_SMP=y).  So use a simple
+ *    one-line #define for node_isset(), instead of wrapping an inline
+ *    inside a macro, the way we do the other calls.
+ */
+
+#include <linux/threads.h>
+#include <linux/bitmap.h>
+#include <linux/numa.h>
+#include <asm/bug.h>
+
+typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
+extern nodemask_t _unused_nodemask_arg_;
+
+#define node_set(node, dst) __node_set((node), &(dst))
+static inline void __node_set(int node, volatile nodemask_t *dstp)
+{
+	set_bit(node, dstp->bits);
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
+	bitmap_zero(dstp->bits, nbits);
+}
+
+/* No static inline type checking - see Subtlety (1) above. */
+#define node_isset(node, nodemask) test_bit((node), (nodemask).bits)
+
+#define node_test_and_set(node, nodemask) \
+			__node_test_and_set((node), &(nodemask))
+static inline int __node_test_and_set(int node, nodemask_t *addr)
+{
+	return test_and_set_bit(node, addr->bits);
+}
+
+#define nodes_and(dst, src1, src2) \
+			__nodes_and(&(dst), &(src1), &(src2), MAX_NUMNODES)
+static inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
+					const nodemask_t *src2p, int nbits)
+{
+	bitmap_and(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_or(dst, src1, src2) \
+			__nodes_or(&(dst), &(src1), &(src2), MAX_NUMNODES)
+static inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
+					const nodemask_t *src2p, int nbits)
+{
+	bitmap_or(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_xor(dst, src1, src2) \
+			__nodes_xor(&(dst), &(src1), &(src2), MAX_NUMNODES)
+static inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
+					const nodemask_t *src2p, int nbits)
+{
+	bitmap_xor(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_andnot(dst, src1, src2) \
+			__nodes_andnot(&(dst), &(src1), &(src2), MAX_NUMNODES)
+static inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
+					const nodemask_t *src2p, int nbits)
+{
+	bitmap_andnot(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_complement(dst, src) \
+			__nodes_complement(&(dst), &(src), MAX_NUMNODES)
+static inline void __nodes_complement(nodemask_t *dstp,
+					const nodemask_t *srcp, int nbits)
+{
+	bitmap_complement(dstp->bits, srcp->bits, nbits);
+}
+
+#define nodes_equal(src1, src2) \
+			__nodes_equal(&(src1), &(src2), MAX_NUMNODES)
+static inline int __nodes_equal(const nodemask_t *src1p,
+					const nodemask_t *src2p, int nbits)
+{
+	return bitmap_equal(src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_intersects(src1, src2) \
+			__nodes_intersects(&(src1), &(src2), MAX_NUMNODES)
+static inline int __nodes_intersects(const nodemask_t *src1p,
+					const nodemask_t *src2p, int nbits)
+{
+	return bitmap_intersects(src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_subset(src1, src2) \
+			__nodes_subset(&(src1), &(src2), MAX_NUMNODES)
+static inline int __nodes_subset(const nodemask_t *src1p,
+					const nodemask_t *src2p, int nbits)
+{
+	return bitmap_subset(src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
+static inline int __nodes_empty(const nodemask_t *srcp, int nbits)
+{
+	return bitmap_empty(srcp->bits, nbits);
+}
+
+#define nodes_full(nodemask) __nodes_full(&(nodemask), MAX_NUMNODES)
+static inline int __nodes_full(const nodemask_t *srcp, int nbits)
+{
+	return bitmap_full(srcp->bits, nbits);
+}
+
+#define nodes_weight(nodemask) __nodes_weight(&(nodemask), MAX_NUMNODES)
+static inline int __nodes_weight(const nodemask_t *srcp, int nbits)
+{
+	return bitmap_weight(srcp->bits, nbits);
+}
+
+#define nodes_shift_right(dst, src, n) \
+			__nodes_shift_right(&(dst), &(src), (n), MAX_NUMNODES)
+static inline void __nodes_shift_right(nodemask_t *dstp,
+					const nodemask_t *srcp, int n, int nbits)
+{
+	bitmap_shift_right(dstp->bits, srcp->bits, n, nbits);
+}
+
+#define nodes_shift_left(dst, src, n) \
+			__nodes_shift_left(&(dst), &(src), (n), MAX_NUMNODES)
+static inline void __nodes_shift_left(nodemask_t *dstp,
+					const nodemask_t *srcp, int n, int nbits)
+{
+	bitmap_shift_left(dstp->bits, srcp->bits, n, nbits);
+}
+
+#define first_node(src) __first_node(&(src), MAX_NUMNODES)
+static inline int __first_node(const nodemask_t *srcp, int nbits)
+{
+	return find_first_bit(srcp->bits, nbits);
+}
+
+#define next_node(n, src) __next_node((n), &(src), MAX_NUMNODES)
+static inline int __next_node(int n, const nodemask_t *srcp, int nbits)
+{
+	return find_next_bit(srcp->bits, nbits, n+1);
+}
+
+#define nodemask_of_node(node)						\
+({									\
+	typeof(_unused_nodemask_arg_) m;				\
+	if (sizeof(m) == sizeof(unsigned long)) {			\
+		m.bits[0] = 1UL<<(node);				\
+	} else {							\
+		nodes_clear(m);						\
+		node_set((node), m);					\
+	}								\
+	m;								\
+})
+
+#define NODE_MASK_LAST_WORD BITMAP_LAST_WORD_MASK(MAX_NUMNODES)
+
+#if MAX_NUMNODES <= BITS_PER_LONG
+
+#define NODE_MASK_ALL							\
+((nodemask_t) { {							\
+	[BITS_TO_LONGS(MAX_NUMNODES)-1] = NODE_MASK_LAST_WORD		\
+} })
+
+#else
+
+#define NODE_MASK_ALL							\
+((nodemask_t) { {							\
+	[0 ... BITS_TO_LONGS(MAX_NUMNODES)-2] = ~0UL,			\
+	[BITS_TO_LONGS(MAX_NUMNODES)-1] = NODE_MASK_LAST_WORD		\
+} })
+
+#endif
+
+#define NODE_MASK_NONE							\
+((nodemask_t) { {							\
+	[0 ... BITS_TO_LONGS(MAX_NUMNODES)-1] =  0UL			\
+} })
+
+#define nodes_addr(src) ((src).bits)
+
+#define nodemask_scnprintf(buf, len, src) \
+			__nodemask_scnprintf((buf), (len), &(src), MAX_NUMNODES)
+static inline int __nodemask_scnprintf(char *buf, int len,
+					const nodemask_t *srcp, int nbits)
+{
+	return bitmap_scnprintf(buf, len, srcp->bits, nbits);
+}
+
+#define nodemask_parse(ubuf, ulen, src) \
+			__nodemask_parse((ubuf), (ulen), &(src), MAX_NUMNODES)
+static inline int __nodemask_parse(const char __user *buf, int len,
+					nodemask_t *dstp, int nbits)
+{
+	return bitmap_parse(buf, len, dstp->bits, nbits);
+}
+
+#if MAX_NUMNODES > 1
+#define for_each_node_mask(node, mask)			\
+	for ((node) = first_node(mask);			\
+		(node) < MAX_NUMNODES;			\
+		(node) = next_node((node), (mask)))
+#else /* MAX_NUMNODES == 1 */
+#define for_each_node_mask(node, mask)			\
+	if (!nodes_empty(mask))				\
+		for ((node) = 0; (node) < 1; (node)++)
+#endif /* MAX_NUMNODES */
+
+/*
+ * The following particular system nodemasks and operations
+ * on them manage all possible and online nodes.
+ */
+
+extern nodemask_t node_online_map;
+extern nodemask_t node_possible_map;
+
+#if MAX_NUMNODES > 1
+#define num_online_nodes()	nodes_weight(node_online_map)
+#define num_possible_nodes()	nodes_weight(node_possible_map)
+#define node_online(node)	node_isset((node), node_online_map)
+#define node_possible(node)	node_isset((node), node_possible_map)
+#else
+#define num_online_nodes()	1
+#define num_possible_nodes()	1
+#define node_online(node)	((node) == 0)
+#define node_possible(node)	((node) == 0)
+#endif
+
+#define any_online_node(mask)			\
+({						\
+	int node;				\
+	for_each_node_mask(node, (mask))	\
+		if (node_online(node))		\
+			break;			\
+	node;					\
+})
+
+#define node_set_online(node)	   set_bit((node), node_online_map.bits)
+#define node_set_offline(node)	   clear_bit((node), node_online_map.bits)
+
+#define for_each_node(node)	   for_each_node_mask((node), node_possible_map)
+#define for_each_online_node(node) for_each_node_mask((node), node_online_map)
+
+#endif /* __LINUX_NODEMASK_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/mm/mempolicy.c linux-2.6.7-mm7+nodemask_t/mm/mempolicy.c
--- linux-2.6.7-mm7/mm/mempolicy.c	2004-07-12 10:39:42.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/mm/mempolicy.c	2004-07-13 15:57:51.000000000 -0700
@@ -66,6 +66,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/nodemask.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -95,7 +96,7 @@ static int nodes_online(unsigned long *n
 {
 	DECLARE_BITMAP(online2, MAX_NUMNODES);
 
-	bitmap_copy(online2, node_online_map, MAX_NUMNODES);
+	bitmap_copy(online2, nodes_addr(node_online_map), MAX_NUMNODES);
 	if (bitmap_empty(online2, MAX_NUMNODES))
 		set_bit(0, online2);
 	if (!bitmap_subset(nodes, online2, MAX_NUMNODES))
@@ -422,7 +423,7 @@ static void get_zonemask(struct mempolic
 	case MPOL_PREFERRED:
 		/* or use current node instead of online map? */
 		if (p->v.preferred_node < 0)
-			bitmap_copy(nodes, node_online_map, MAX_NUMNODES);
+			bitmap_copy(nodes, nodes_addr(node_online_map), MAX_NUMNODES);
 		else
 			__set_bit(p->v.preferred_node, nodes);
 		break;
@@ -628,7 +629,7 @@ static struct page *alloc_page_interleav
 	struct zonelist *zl;
 	struct page *page;
 
-	BUG_ON(!test_bit(nid, node_online_map));
+	BUG_ON(!node_online(nid));
 	zl = NODE_DATA(nid)->node_zonelists + (gfp & GFP_ZONEMASK);
 	page = __alloc_pages(gfp, order, zl);
 	if (page && page_zone(page) == zl->zones[0]) {
@@ -1017,7 +1018,8 @@ void __init numa_policy_init(void)
 	/* Set interleaving policy for system init. This way not all
 	   the data structures allocated at system boot end up in node zero. */
 
-	if (sys_set_mempolicy(MPOL_INTERLEAVE, node_online_map, MAX_NUMNODES) < 0)
+	if (sys_set_mempolicy(MPOL_INTERLEAVE, nodes_addr(node_online_map),
+							MAX_NUMNODES) < 0)
 		printk("numa_policy_init: interleaving failed\n");
 }
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/mm/page_alloc.c linux-2.6.7-mm7+nodemask_t/mm/page_alloc.c
--- linux-2.6.7-mm7/mm/page_alloc.c	2004-07-12 10:39:42.000000000 -0700
+++ linux-2.6.7-mm7+nodemask_t/mm/page_alloc.c	2004-07-13 14:40:03.000000000 -0700
@@ -31,10 +31,12 @@
 #include <linux/topology.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
+#include <linux/nodemask.h>
 
 #include <asm/tlbflush.h>
 
-DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
+nodemask_t node_online_map = NODE_MASK_NONE;
+nodemask_t node_possible_map = NODE_MASK_ALL;
 struct pglist_data *pgdat_list;
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;

--=-9LRmCH+WYzasotudewlu--

