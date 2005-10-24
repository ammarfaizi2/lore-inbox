Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVJXH17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVJXH17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 03:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVJXH17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 03:27:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:441 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750734AbVJXH15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 03:27:57 -0400
Date: Mon, 24 Oct 2005 00:27:44 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051024072744.10390.35722.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 01/02] cpuset bitmap and mask remap operators
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the forthcoming task migration support, a key calculation will be
mapping cpu and node numbers from the old set to the new set while
preserving cpuset-relative offset.

For example, if a task and its pages on nodes 8-11 are being migrated
to nodes 24-27, then pages on node 9 (the 2nd node in the old set)
should be moved to node 25 (the 2nd node in the new set.)

As with other bitmap operations, the proper way to code this is
to provide the underlying calculation in lib/bitmap.c, and then to
provide the usual cpumask and nodemask wrappers.

This patch provides that.  These operations are termed 'remap'
operations.  Both remapping a single bit and a set of bits is
supported.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/linux/bitmap.h   |    6 +
 include/linux/cpumask.h  |   20 +++++
 include/linux/nodemask.h |   20 +++++
 lib/bitmap.c             |  166 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 212 insertions(+)

--- 2.6.14-rc4-mm1-cpuset-patches.orig/include/linux/bitmap.h	2005-10-23 18:43:58.257209273 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/include/linux/bitmap.h	2005-10-23 18:44:01.304116059 -0700
@@ -40,6 +40,8 @@
  * bitmap_weight(src, nbits)			Hamming Weight: number set bits
  * bitmap_shift_right(dst, src, n, nbits)	*dst = *src >> n
  * bitmap_shift_left(dst, src, n, nbits)	*dst = *src << n
+ * bitmap_remap(dst, src, old, new, nbits)	*dst = map(old, new)(src)
+ * bitmap_bitremap(oldbit, old, new, nbits)	newbit = map(old, new)(oldbit)
  * bitmap_scnprintf(buf, len, src, nbits)	Print bitmap src to buf
  * bitmap_parse(ubuf, ulen, dst, nbits)		Parse bitmap dst from user buf
  * bitmap_scnlistprintf(buf, len, src, nbits)	Print bitmap src as list to buf
@@ -104,6 +106,10 @@ extern int bitmap_scnlistprintf(char *bu
 			const unsigned long *src, int nbits);
 extern int bitmap_parselist(const char *buf, unsigned long *maskp,
 			int nmaskbits);
+extern void bitmap_remap(const unsigned long *dst, unsigned long *src,
+		const unsigned long *old, const unsigned long *new, int bits);
+extern int bitmap_bitremap(int oldbit,
+		const unsigned long *old, const unsigned long *new, int bits);
 extern int bitmap_find_free_region(unsigned long *bitmap, int bits, int order);
 extern void bitmap_release_region(unsigned long *bitmap, int pos, int order);
 extern int bitmap_allocate_region(unsigned long *bitmap, int pos, int order);
--- 2.6.14-rc4-mm1-cpuset-patches.orig/include/linux/cpumask.h	2005-10-23 18:43:58.258185846 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/include/linux/cpumask.h	2005-10-23 18:44:01.305092631 -0700
@@ -12,6 +12,8 @@
  * see bitmap_scnprintf() and bitmap_parse() in lib/bitmap.c.
  * For details of cpulist_scnprintf() and cpulist_parse(), see
  * bitmap_scnlistprintf() and bitmap_parselist(), also in bitmap.c.
+ * For details of cpu_remap(), see bitmap_bitremap in lib/bitmap.c
+ * For details of cpus_remap(), see bitmap_remap in lib/bitmap.c.
  *
  * The available cpumask operations are:
  *
@@ -50,6 +52,8 @@
  * int cpumask_parse(ubuf, ulen, mask)	Parse ascii string as cpumask
  * int cpulist_scnprintf(buf, len, mask) Format cpumask as list for printing
  * int cpulist_parse(buf, map)		Parse ascii string as cpulist
+ * int cpu_remap(oldbit, old, new)	newbit = map(old, new)(oldbit)
+ * int cpus_remap(dst, src, old, new)	*dst = map(old, new)(src)
  *
  * for_each_cpu_mask(cpu, mask)		for-loop cpu over mask
  *
@@ -294,6 +298,22 @@ static inline int __cpulist_parse(const 
 	return bitmap_parselist(buf, dstp->bits, nbits);
 }
 
+#define cpu_remap(oldbit, old, new) \
+		__cpu_remap((oldbit), &(old), &(new), NR_CPUS)
+static inline int __cpu_remap(int oldbit,
+		const cpumask_t *oldp, const cpumask_t *newp, int nbits)
+{
+	return bitmap_bitremap(oldbit, oldp->bits, newp->bits, nbits);
+}
+
+#define cpus_remap(dst, src, old, new) \
+		__cpus_remap(&(dst), &(src), &(old), &(new), NR_CPUS)
+static inline void __cpus_remap(const cpumask_t *dstp, cpumask_t *srcp,
+		const cpumask_t *oldp, const cpumask_t *newp, int nbits)
+{
+	bitmap_remap(dstp->bits, srcp->bits, oldp->bits, newp->bits, nbits);
+}
+
 #if NR_CPUS > 1
 #define for_each_cpu_mask(cpu, mask)		\
 	for ((cpu) = first_cpu(mask);		\
--- 2.6.14-rc4-mm1-cpuset-patches.orig/include/linux/nodemask.h	2005-10-23 18:43:58.282600163 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/include/linux/nodemask.h	2005-10-23 18:44:01.306069204 -0700
@@ -12,6 +12,8 @@
  * see bitmap_scnprintf() and bitmap_parse() in lib/bitmap.c.
  * For details of nodelist_scnprintf() and nodelist_parse(), see
  * bitmap_scnlistprintf() and bitmap_parselist(), also in bitmap.c.
+ * For details of node_remap(), see bitmap_bitremap in lib/bitmap.c.
+ * For details of nodes_remap(), see bitmap_remap in lib/bitmap.c.
  *
  * The available nodemask operations are:
  *
@@ -52,6 +54,8 @@
  * int nodemask_parse(ubuf, ulen, mask)	Parse ascii string as nodemask
  * int nodelist_scnprintf(buf, len, mask) Format nodemask as list for printing
  * int nodelist_parse(buf, map)		Parse ascii string as nodelist
+ * int node_remap(oldbit, old, new)	newbit = map(old, new)(oldbit)
+ * int nodes_remap(dst, src, old, new)	*dst = map(old, new)(dst)
  *
  * for_each_node_mask(node, mask)	for-loop node over mask
  *
@@ -307,6 +311,22 @@ static inline int __nodelist_parse(const
 	return bitmap_parselist(buf, dstp->bits, nbits);
 }
 
+#define node_remap(oldbit, old, new) \
+		__node_remap((oldbit), &(old), &(new), MAX_NUMNODES)
+static inline int __node_remap(int oldbit,
+		const nodemask_t *oldp, const nodemask_t *newp, int nbits)
+{
+	return bitmap_bitremap(oldbit, oldp->bits, newp->bits, nbits);
+}
+
+#define nodes_remap(dst, src, old, new) \
+		__nodes_remap(&(dst), &(src), &(old), &(new), MAX_NUMNODES)
+static inline void __nodes_remap(const nodemask_t *dstp, nodemask_t *srcp,
+		const nodemask_t *oldp, const nodemask_t *newp, int nbits)
+{
+	bitmap_remap(dstp->bits, srcp->bits, oldp->bits, newp->bits, nbits);
+}
+
 #if MAX_NUMNODES > 1
 #define for_each_node_mask(node, mask)			\
 	for ((node) = first_node(mask);			\
--- 2.6.14-rc4-mm1-cpuset-patches.orig/lib/bitmap.c	2005-10-23 18:43:58.289436172 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/lib/bitmap.c	2005-10-23 18:49:18.271292080 -0700
@@ -511,6 +511,172 @@ int bitmap_parselist(const char *bp, uns
 }
 EXPORT_SYMBOL(bitmap_parselist);
 
+/*
+ * bitmap_pos_to_ord(buf, pos, bits)
+ *	@buf: pointer to a bitmap
+ *	@pos: a bit position in @buf (0 <= @pos < @bits)
+ *	@bits: number of valid bit positions in @buf
+ *
+ * Map the bit at position @pos in @buf (of length @bits) to the
+ * ordinal of which set bit it is.  If it is not set or if @pos
+ * is not a valid bit position, map to zero (0).
+ *
+ * If for example, just bits 4 through 7 are set in @buf, then @pos
+ * values 4 through 7 will get mapped to 0 through 3, respectively,
+ * and other @pos values will get mapped to 0.  When @pos value 7
+ * gets mapped to (returns) @ord value 3 in this example, that means
+ * that bit 7 is the 3rd (starting with 0th) set bit in @buf.
+ *
+ * The bit positions 0 through @bits are valid positions in @buf.
+ */
+static int bitmap_pos_to_ord(const unsigned long *buf, int pos, int bits)
+{
+	int ord = 0;
+
+	if (pos >= 0 && pos < bits) {
+		int i;
+
+		for (i = find_first_bit(buf, bits);
+		     i < pos;
+		     i = find_next_bit(buf, bits, i + 1))
+	     		ord++;
+		if (i > pos)
+			ord = 0;
+	}
+	return ord;
+}
+
+/**
+ * bitmap_ord_to_pos(buf, ord, bits)
+ *	@buf: pointer to bitmap
+ *	@ord: ordinal bit position (n-th set bit, n >= 0)
+ *	@bits: number of valid bit positions in @buf
+ *
+ * Map the ordinal offset of bit @ord in @buf to its position in @buf.
+ * If @ord is not the ordinal offset of a set bit in @buf, map to zero (0).
+ *
+ * If for example, just bits 4 through 7 are set in @buf, then @ord
+ * values 0 through 3 will get mapped to 4 through 7, respectively,
+ * and all other @ord valuds will get mapped to 0.  When @ord value 3
+ * gets mapped to (returns) @pos value 7 in this example, that means
+ * that the 3rd set bit (starting with 0th) is at position 7 in @buf.
+ *
+ * The bit positions 0 through @bits are valid positions in @buf.
+ */
+static int bitmap_ord_to_pos(const unsigned long *buf, int ord, int bits)
+{
+	int pos = 0;
+
+	if (ord >= 0 && ord < bits) {
+		int i;
+
+		for (i = find_first_bit(buf, bits);
+		     i < bits && ord > 0;
+		     i = find_next_bit(buf, bits, i + 1))
+	     		ord--;
+		if (i < bits && ord == 0)
+			pos = i;
+	}
+
+	return pos;
+}
+
+/**
+ * bitmap_remap - Apply map defined by a pair of bitmaps to another bitmap
+ *	@src: subset to be remapped
+ *	@dst: remapped result
+ *	@old: defines domain of map
+ *	@new: defines range of map
+ *	@bits: number of bits in each of these bitmaps
+ *
+ * Let @old and @new define a mapping of bit positions, such that
+ * whatever position is held by the n-th set bit in @old is mapped
+ * to the n-th set bit in @new.  In the more general case, allowing
+ * for the possibility that the weight 'w' of @new is less than the
+ * weight of @old, map the position of the n-th set bit in @old to
+ * the position of the m-th set bit in @new, where m == n % w.
+ *
+ * If either of the @old and @new bitmaps are empty, or if@src and @dst
+ * point to the same location, then this routine does nothing.
+ *
+ * The positions of unset bits in @old are mapped to the position of
+ * the first set bit in @new.
+ *
+ * Apply the above specified mapping to @src, placing the result in
+ * @dst, clearing any bits previously set in @dst.
+ *
+ * The resulting value of @dst will have either the same weight as
+ * @src, or less weight in the general case that the mapping wasn't
+ * injective due to the weight of @new being less than that of @old.
+ * The resulting value of @dst will never have greater weight than
+ * that of @src, except perhaps in the case that one of the above
+ * conditions was not met and this routine just returned.
+ *
+ * For example, lets say that @old has bits 4 through 7 set, and
+ * @new has bits 12 through 15 set.  This defines the mapping of bit
+ * position 4 to 12, 5 to 13, 6 to 14 and 7 to 15, and of all other
+ * bit positions to 12 (the first set bit in @new.  So if say @src
+ * comes into this routine with bits 1, 5 and 7 set, then @dst should
+ * leave with bits 12, 13 and 15 set.
+ */
+void bitmap_remap(const unsigned long *dst, unsigned long *src,
+		const unsigned long *old, const unsigned long *new,
+		int bits)
+{
+	int s;
+
+	if (bitmap_weight(old, bits) == 0)
+		return;
+	if (bitmap_weight(new, bits) == 0)
+		return;
+	if (dst == src)		/* following doesn't handle inplace remaps */
+		return;
+
+	bitmap_zero(dst, bits);
+	for (s = find_first_bit(src, bits);
+	     s < bits;
+	     s = find_next_bit(src, bits, s + 1)) {
+	     	int x = bitmap_pos_to_ord(old, s, bits);
+		int y = bitmap_ord_to_pos(new, x, bits);
+		set_bit(y, dst);
+	}
+}
+EXPORT_SYMBOL(bitmap_remap);
+
+/**
+ * bitmap_bitremap - Apply map defined by a pair of bitmaps to a single bit
+ *	@oldbit - bit position to be mapped
+ *      @old: defines domain of map
+ *      @new: defines range of map
+ *      @bits: number of bits in each of these bitmaps
+ *
+ * Let @old and @new define a mapping of bit positions, such that
+ * whatever position is held by the n-th set bit in @old is mapped
+ * to the n-th set bit in @new.  In the more general case, allowing
+ * for the possibility that the weight 'w' of @new is less than the
+ * weight of @old, map the position of the n-th set bit in @old to
+ * the position of the m-th set bit in @new, where m == n % w.
+ *
+ * The positions of unset bits in @old are mapped to the position of
+ * the first set bit in @new.
+ *
+ * Apply the above specified mapping to bit position @oldbit, returning
+ * the new bit position.
+ *
+ * For example, lets say that @old has bits 4 through 7 set, and
+ * @new has bits 12 through 15 set.  This defines the mapping of bit
+ * position 4 to 12, 5 to 13, 6 to 14 and 7 to 15, and of all other
+ * bit positions to 12 (the first set bit in @new.  So if say @oldbit
+ * is 5, then this routine returns 13.
+ */
+int bitmap_bitremap(int oldbit, const unsigned long *old,
+				const unsigned long *new, int bits)
+{
+	int x = bitmap_pos_to_ord(old, oldbit, bits);
+	return bitmap_ord_to_pos(new, x, bits);
+}
+EXPORT_SYMBOL(bitmap_bitremap);
+
 /**
  *	bitmap_find_free_region - find a contiguous aligned mem region
  *	@bitmap: an array of unsigned longs corresponding to the bitmap

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
