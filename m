Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbUEFSy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUEFSy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 14:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUEFSxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 14:53:47 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:30797 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262009AbUEFStU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 14:49:20 -0400
Date: Thu, 6 May 2004 11:48:40 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Joe Korty <joe.korty@ccur.com>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: [PATCH mask 7/15] mask1-bitmap-cleanup-prep
Message-Id: <20040506114840.533b783a.pj@sgi.com>
In-Reply-To: <20040506111814.62d1f537.pj@sgi.com>
References: <20040506111814.62d1f537.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mask1-bitmap-cleanup-prep
	Document the bitmap bit model and handling of unused bits.

        Tighten up bitmap so it does not generate nonzero bits
        in the unused tail if it is not given any on input.

        Add intersects, subset, xor and andnot operators.
        Change bitmap_complement to take two operands.

        Add a couple of missing 'const' qualifiers on
        bitops test_bit and bitmap_equal args.

Index: 2.6.6-rc3-mm2-bitmapv5/arch/x86_64/kernel/smpboot.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/arch/x86_64/kernel/smpboot.c	2004-05-05 08:07:06.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/arch/x86_64/kernel/smpboot.c	2004-05-05 08:08:57.000000000 -0700
@@ -827,7 +827,7 @@
 		if (apicid == boot_cpu_id || (apicid == BAD_APICID))
 			continue;
 
-		if (!cpu_isset(apicid, phys_cpu_present_map))
+		if (!physid_isset(apicid, phys_cpu_present_map))
 			continue;
 		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
 			continue;
Index: 2.6.6-rc3-mm2-bitmapv5/include/asm-generic/bitops.h
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/include/asm-generic/bitops.h	2004-05-05 08:07:06.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/include/asm-generic/bitops.h	2004-05-05 08:08:57.000000000 -0700
@@ -42,7 +42,7 @@
 	return retval;
 }
 
-extern __inline__ int test_bit(int nr, long * addr)
+extern __inline__ int test_bit(int nr, const unsigned long * addr)
 {
 	int	mask;
 
Index: 2.6.6-rc3-mm2-bitmapv5/include/asm-generic/cpumask_array.h
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/include/asm-generic/cpumask_array.h	2004-05-05 08:07:06.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/include/asm-generic/cpumask_array.h	2004-05-05 08:08:57.000000000 -0700
@@ -17,7 +17,7 @@
 #define cpus_and(dst,src1,src2)	bitmap_and((dst).mask,(src1).mask, (src2).mask, NR_CPUS)
 #define cpus_or(dst,src1,src2)	bitmap_or((dst).mask, (src1).mask, (src2).mask, NR_CPUS)
 #define cpus_clear(map)		bitmap_zero((map).mask, NR_CPUS)
-#define cpus_complement(map)	bitmap_complement((map).mask, NR_CPUS)
+#define cpus_complement(map)	bitmap_complement((map).mask, (map).mask, NR_CPUS)
 #define cpus_equal(map1, map2)	bitmap_equal((map1).mask, (map2).mask, NR_CPUS)
 #define cpus_empty(map)		bitmap_empty(map.mask, NR_CPUS)
 #define cpus_addr(map)		((map).mask)
Index: 2.6.6-rc3-mm2-bitmapv5/include/asm-i386/mpspec.h
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/include/asm-i386/mpspec.h	2004-05-05 08:07:06.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/include/asm-i386/mpspec.h	2004-05-05 08:08:57.000000000 -0700
@@ -53,7 +53,7 @@
 #define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_clear(map)			bitmap_zero((map).mask, MAX_APICS)
-#define physids_complement(map)			bitmap_complement((map).mask, MAX_APICS)
+#define physids_complement(map)			bitmap_complement((map).mask, (map).mask, MAX_APICS)
 #define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
 #define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
 #define physids_weight(map)			bitmap_weight((map).mask, MAX_APICS)
Index: 2.6.6-rc3-mm2-bitmapv5/include/asm-x86_64/mpspec.h
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/include/asm-x86_64/mpspec.h	2004-05-05 08:07:06.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/include/asm-x86_64/mpspec.h	2004-05-05 08:08:57.000000000 -0700
@@ -212,7 +212,7 @@
 #define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_clear(map)			bitmap_zero((map).mask, MAX_APICS)
-#define physids_complement(map)			bitmap_complement((map).mask, MAX_APICS)
+#define physids_complement(map)			bitmap_complement((map).mask, (map).mask, MAX_APICS)
 #define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
 #define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
 #define physids_weight(map)			bitmap_weight((map).mask, MAX_APICS)
Index: 2.6.6-rc3-mm2-bitmapv5/include/linux/bitmap.h
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/include/linux/bitmap.h	2004-05-05 08:07:06.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/include/linux/bitmap.h	2004-05-05 08:08:57.000000000 -0700
@@ -13,8 +13,8 @@
 int bitmap_empty(const unsigned long *bitmap, int bits);
 int bitmap_full(const unsigned long *bitmap, int bits);
 int bitmap_equal(const unsigned long *bitmap1,
-			unsigned long *bitmap2, int bits);
-void bitmap_complement(unsigned long *bitmap, int bits);
+			const unsigned long *bitmap2, int bits);
+void bitmap_complement(unsigned long *dst, const unsigned long *src, int bits);
 
 static inline void bitmap_zero(unsigned long *bitmap, int bits)
 {
@@ -41,6 +41,14 @@
 			const unsigned long *bitmap2, int bits);
 void bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 			const unsigned long *bitmap2, int bits);
+void bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
+void bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
+int bitmap_intersects(const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
+int bitmap_subset(const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
 int bitmap_weight(const unsigned long *bitmap, int bits);
 int bitmap_scnprintf(char *buf, unsigned int buflen,
 			const unsigned long *maskp, int bits);
Index: 2.6.6-rc3-mm2-bitmapv5/lib/bitmap.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/lib/bitmap.c	2004-05-05 08:07:06.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/lib/bitmap.c	2004-05-05 08:08:57.000000000 -0700
@@ -12,6 +12,26 @@
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
+/*
+ * bitmaps provide an array of bits, implemented using an an
+ * array of unsigned longs.  The number of valid bits in a
+ * given bitmap need not be an exact multiple of BITS_PER_LONG.
+ *
+ * The possible unused bits in the last, partially used word
+ * of a bitmap are 'don't care'.  The implementation makes
+ * no particular effort to keep them zero.  It ensures that
+ * their value will not affect the results of any operation.
+ * The bitmap operations that return Boolean (bitmap_empty,
+ * for example) or scalar (bitmap_weight, for example) results
+ * carefully filter out these unused bits from impacting their
+ * results.
+ *
+ * These operations actually hold to a slightly stronger rule:
+ * if you don't input any bitmaps to these ops that have some
+ * unused bits set, then they won't output any set unused bits
+ * in output bitmaps.
+ */
+
 int bitmap_empty(const unsigned long *bitmap, int bits)
 {
 	int k, lim = bits/BITS_PER_LONG;
@@ -43,7 +63,7 @@
 EXPORT_SYMBOL(bitmap_full);
 
 int bitmap_equal(const unsigned long *bitmap1,
-		unsigned long *bitmap2, int bits)
+		const unsigned long *bitmap2, int bits)
 {
 	int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
@@ -59,13 +79,14 @@
 }
 EXPORT_SYMBOL(bitmap_equal);
 
-void bitmap_complement(unsigned long *bitmap, int bits)
+void bitmap_complement(unsigned long *dst, const unsigned long *src, int bits)
 {
-	int k;
-	int nr = BITS_TO_LONGS(bits);
+	int k, lim = bits/BITS_PER_LONG;
+	for (k = 0; k < lim; ++k)
+		dst[k] = ~src[k];
 
-	for (k = 0; k < nr; ++k)
-		bitmap[k] = ~bitmap[k];
+	if (bits % BITS_PER_LONG)
+		dst[k] = ~src[k] & ((1UL << (bits % BITS_PER_LONG)) - 1);
 }
 EXPORT_SYMBOL(bitmap_complement);
 
@@ -173,6 +194,60 @@
 }
 EXPORT_SYMBOL(bitmap_or);
 
+void bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
+				const unsigned long *bitmap2, int bits)
+{
+	int k;
+	int nr = BITS_TO_LONGS(bits);
+
+	for (k = 0; k < nr; k++)
+		dst[k] = bitmap1[k] ^ bitmap2[k];
+}
+EXPORT_SYMBOL(bitmap_xor);
+
+void bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+				const unsigned long *bitmap2, int bits)
+{
+	int k;
+	int nr = BITS_TO_LONGS(bits);
+
+	for (k = 0; k < nr; k++)
+		dst[k] = bitmap1[k] & ~bitmap2[k];
+}
+EXPORT_SYMBOL(bitmap_andnot);
+
+int bitmap_intersects(const unsigned long *bitmap1,
+				const unsigned long *bitmap2, int bits)
+{
+	int k, lim = bits/BITS_PER_LONG;
+	for (k = 0; k < lim; ++k)
+		if (bitmap1[k] & bitmap2[k])
+			return 1;
+
+	if (bits % BITS_PER_LONG)
+		if ((bitmap1[k] & bitmap2[k]) &
+				((1UL << (bits % BITS_PER_LONG)) - 1))
+			return 1;
+	return 0;
+}
+EXPORT_SYMBOL(bitmap_intersects);
+
+int bitmap_subset(const unsigned long *bitmap1,
+				const unsigned long *bitmap2, int bits)
+{
+	int k, lim = bits/BITS_PER_LONG;
+	for (k = 0; k < lim; ++k)
+		if (bitmap1[k] & ~bitmap2[k])
+			return 0;
+
+	if (bits % BITS_PER_LONG)
+		if ((bitmap1[k] & ~bitmap2[k]) &
+				((1UL << (bits % BITS_PER_LONG)) - 1))
+			return 0;
+	return 1;
+}
+EXPORT_SYMBOL(bitmap_subset);
+
 #if BITS_PER_LONG == 32
 int bitmap_weight(const unsigned long *bitmap, int bits)
 {
Index: 2.6.6-rc3-mm2-bitmapv5/mm/mempolicy.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/mm/mempolicy.c	2004-05-05 08:08:43.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/mm/mempolicy.c	2004-05-05 08:09:40.000000000 -0700
@@ -92,14 +92,12 @@
 /* Check if all specified nodes are online */
 static int nodes_online(unsigned long *nodes)
 {
-	DECLARE_BITMAP(offline, MAX_NUMNODES);
+	DECLARE_BITMAP(online2, MAX_NUMNODES);
 
-	bitmap_copy(offline, node_online_map, MAX_NUMNODES);
-	if (bitmap_empty(offline, MAX_NUMNODES))
-		set_bit(0, offline);
-	bitmap_complement(offline, MAX_NUMNODES);
-	bitmap_and(offline, offline, nodes, MAX_NUMNODES);
-	if (!bitmap_empty(offline, MAX_NUMNODES))
+	bitmap_copy(online2, node_online_map, MAX_NUMNODES);
+	if (bitmap_empty(online2, MAX_NUMNODES))
+		set_bit(0, online2);
+	if (!bitmap_subset(nodes, online2, MAX_NUMNODES))
 		return -EINVAL;
 	return 0;
 }


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
