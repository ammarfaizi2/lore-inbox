Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbUDAVMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUDAVMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:12:16 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:52017 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263176AbUDAVME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:12:04 -0500
Date: Thu, 1 Apr 2004 13:11:15 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [Patch 3/23] mask v2 - New bitmap operators
Message-Id: <20040401131115.3c3ad873.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_3_of_23 - New bitmap operators and two op complement
	Add intersects, subset, xor and andnot operators.
	Change bitmap_complement to take two operands.

Diffstat Patch_3_of_23:
 include/asm-generic/cpumask_array.h |    2 -
 include/asm-i386/mpspec.h           |    2 -
 include/asm-x86_64/mpspec.h         |    2 -
 include/linux/bitmap.h              |   12 ++++++-
 lib/bitmap.c                        |   60 ++++++++++++++++++++++++++++++++++--
 5 files changed, 70 insertions(+), 8 deletions(-)

===================================================================
--- 2.6.4.orig/include/asm-generic/cpumask_array.h	2004-03-31 22:04:17.000000000 -0800
+++ 2.6.4/include/asm-generic/cpumask_array.h	2004-04-01 01:43:33.000000000 -0800
@@ -17,7 +17,7 @@
 #define cpus_and(dst,src1,src2)	bitmap_and((dst).mask,(src1).mask, (src2).mask, NR_CPUS)
 #define cpus_or(dst,src1,src2)	bitmap_or((dst).mask, (src1).mask, (src2).mask, NR_CPUS)
 #define cpus_clear(map)		bitmap_clear((map).mask, NR_CPUS)
-#define cpus_complement(map)	bitmap_complement((map).mask, NR_CPUS)
+#define cpus_complement(map)	bitmap_complement((map).mask, (map).mask, NR_CPUS)
 #define cpus_equal(map1, map2)	bitmap_equal((map1).mask, (map2).mask, NR_CPUS)
 #define cpus_empty(map)		bitmap_empty(map.mask, NR_CPUS)
 #define cpus_addr(map)		((map).mask)
===================================================================
--- 2.6.4.orig/include/asm-i386/mpspec.h	2004-03-31 22:04:17.000000000 -0800
+++ 2.6.4/include/asm-i386/mpspec.h	2004-04-01 01:46:05.000000000 -0800
@@ -60,7 +60,7 @@
 #define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_clear(map)			bitmap_clear((map).mask, MAX_APICS)
-#define physids_complement(map)			bitmap_complement((map).mask, MAX_APICS)
+#define physids_complement(map)			bitmap_complement((map).mask, (map).mask, MAX_APICS)
 #define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
 #define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
 #define physids_weight(map)			bitmap_weight((map).mask, MAX_APICS)
===================================================================
--- 2.6.4.orig/include/asm-x86_64/mpspec.h	2004-03-31 22:04:17.000000000 -0800
+++ 2.6.4/include/asm-x86_64/mpspec.h	2004-04-01 01:46:13.000000000 -0800
@@ -214,7 +214,7 @@
 #define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_clear(map)			bitmap_clear((map).mask, MAX_APICS)
-#define physids_complement(map)			bitmap_complement((map).mask, MAX_APICS)
+#define physids_complement(map)			bitmap_complement((map).mask, (map).mask, MAX_APICS)
 #define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
 #define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
 #define physids_weight(map)			bitmap_weight((map).mask, MAX_APICS)
===================================================================
--- 2.6.4.orig/include/linux/bitmap.h	2004-03-31 22:04:17.000000000 -0800
+++ 2.6.4/include/linux/bitmap.h	2004-03-31 22:07:07.000000000 -0800
@@ -13,8 +13,8 @@
 int bitmap_empty(const unsigned long *bitmap, int bits);
 int bitmap_full(const unsigned long *bitmap, int bits);
 int bitmap_equal(const unsigned long *bitmap1,
-			unsigned long *bitmap2, int bits);
-void bitmap_complement(unsigned long *bitmap, int bits);
+			const unsigned long *bitmap2, int bits);
+void bitmap_complement(unsigned long *dst, const unsigned long *src, int bits);
 
 static inline void bitmap_clear(unsigned long *bitmap, int bits)
 {
@@ -40,6 +40,14 @@
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
===================================================================
--- 2.6.4.orig/lib/bitmap.c	2004-03-31 22:06:58.000000000 -0800
+++ 2.6.4/lib/bitmap.c	2004-04-01 01:43:33.000000000 -0800
@@ -108,14 +108,14 @@
 }
 EXPORT_SYMBOL(bitmap_equal);
 
-void bitmap_complement(unsigned long *bitmap, int bits)
+void bitmap_complement(unsigned long *dst, const unsigned long *src, int bits)
 {
 	int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
-		bitmap[k] = ~bitmap[k];
+		dst[k] = ~src[k];
 
 	if (bits % BITS_PER_LONG)
-		bitmap[k] = ~bitmap[k] & ((1UL << (bits % BITS_PER_LONG)) - 1);
+		dst[k] = ~src[k] & ((1UL << (bits % BITS_PER_LONG)) - 1);
 }
 EXPORT_SYMBOL(bitmap_complement);
 
@@ -171,6 +171,60 @@
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

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
