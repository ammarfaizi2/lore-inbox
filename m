Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbUC2Ncb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbUC2MRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:17:21 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:57782 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262849AbUC2MNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:13:55 -0500
Date: Mon, 29 Mar 2004 04:12:49 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT: bitmap and bitop tweaks [1/22]
Message-Id: <20040329041249.65d365a1.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_1_of_22 - Underlying bitmap/bitop details, added ops
	Add a couple of 'const' qualifiers
	Add intersects, subset, xor and andnot operators.
	Fix some unused bits in bitmap_complement
	Change bitmap_complement to take two operands.

diffstat Patch_1_of_22:
 include/asm-generic/bitops.h        |    2 -
 include/asm-generic/cpumask_array.h |    2 -
 include/asm-i386/mpspec.h           |    2 -
 include/asm-x86_64/mpspec.h         |    2 -
 include/linux/bitmap.h              |   12 +++++-
 lib/bitmap.c                        |   67 ++++++++++++++++++++++++++++++++----
 6 files changed, 75 insertions(+), 12 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1706  -> 1.1707 
#	include/asm-i386/mpspec.h	1.17    -> 1.18   
#	include/asm-x86_64/mpspec.h	1.8     -> 1.9    
#	include/asm-generic/cpumask_array.h	1.3     -> 1.4    
#	include/asm-generic/bitops.h	1.2     -> 1.3    
#	        lib/bitmap.c	1.6     -> 1.7    
#	include/linux/bitmap.h	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/28	pj@sgi.com	1.1707
# Change bitmap_complement() from inplace to separate dest and source args.
# Add bitmap xor, andnot, intersects and subset operators.
# Mark 2nd bitmap_equal() argument as 'const'
# Refine bitmap_complement to ignore unused bits in last word.
# Mark 2nd test_bit() argument as 'const'.
# --------------------------------------------
#
diff -Nru a/include/asm-generic/bitops.h b/include/asm-generic/bitops.h
--- a/include/asm-generic/bitops.h	Mon Mar 29 01:03:26 2004
+++ b/include/asm-generic/bitops.h	Mon Mar 29 01:03:26 2004
@@ -42,7 +42,7 @@
 	return retval;
 }
 
-extern __inline__ int test_bit(int nr, long * addr)
+extern __inline__ int test_bit(int nr, const unsigned long * addr)
 {
 	int	mask;
 
diff -Nru a/include/asm-generic/cpumask_array.h b/include/asm-generic/cpumask_array.h
--- a/include/asm-generic/cpumask_array.h	Mon Mar 29 01:03:26 2004
+++ b/include/asm-generic/cpumask_array.h	Mon Mar 29 01:03:26 2004
@@ -17,7 +17,7 @@
 #define cpus_and(dst,src1,src2)	bitmap_and((dst).mask,(src1).mask, (src2).mask, NR_CPUS)
 #define cpus_or(dst,src1,src2)	bitmap_or((dst).mask, (src1).mask, (src2).mask, NR_CPUS)
 #define cpus_clear(map)		bitmap_clear((map).mask, NR_CPUS)
-#define cpus_complement(map)	bitmap_complement((map).mask, NR_CPUS)
+#define cpus_complement(map)	bitmap_complement((map).mask, (map).mask, NR_CPUS)
 #define cpus_equal(map1, map2)	bitmap_equal((map1).mask, (map2).mask, NR_CPUS)
 #define cpus_empty(map)		bitmap_empty(map.mask, NR_CPUS)
 #define cpus_addr(map)		((map).mask)
diff -Nru a/include/asm-i386/mpspec.h b/include/asm-i386/mpspec.h
--- a/include/asm-i386/mpspec.h	Mon Mar 29 01:03:26 2004
+++ b/include/asm-i386/mpspec.h	Mon Mar 29 01:03:26 2004
@@ -60,7 +60,7 @@
 #define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_clear(map)			bitmap_clear((map).mask, MAX_APICS)
-#define physids_complement(map)			bitmap_complement((map).mask, MAX_APICS)
+#define physids_complement(map)			bitmap_complement((map).mask, (map).mask, MAX_APICS)
 #define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
 #define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
 #define physids_weight(map)			bitmap_weight((map).mask, MAX_APICS)
diff -Nru a/include/asm-x86_64/mpspec.h b/include/asm-x86_64/mpspec.h
--- a/include/asm-x86_64/mpspec.h	Mon Mar 29 01:03:26 2004
+++ b/include/asm-x86_64/mpspec.h	Mon Mar 29 01:03:26 2004
@@ -214,7 +214,7 @@
 #define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_clear(map)			bitmap_clear((map).mask, MAX_APICS)
-#define physids_complement(map)			bitmap_complement((map).mask, MAX_APICS)
+#define physids_complement(map)			bitmap_complement((map).mask, (map).mask, MAX_APICS)
 #define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
 #define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
 #define physids_weight(map)			bitmap_weight((map).mask, MAX_APICS)
diff -Nru a/include/linux/bitmap.h b/include/linux/bitmap.h
--- a/include/linux/bitmap.h	Mon Mar 29 01:03:26 2004
+++ b/include/linux/bitmap.h	Mon Mar 29 01:03:26 2004
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
@@ -39,6 +39,14 @@
 void bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 			const unsigned long *bitmap2, int bits);
 void bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
+void bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
+void bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
+int bitmap_intersects(const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
+int bitmap_subset(const unsigned long *bitmap1,
 			const unsigned long *bitmap2, int bits);
 int bitmap_weight(const unsigned long *bitmap, int bits);
 int bitmap_scnprintf(char *buf, unsigned int buflen,
diff -Nru a/lib/bitmap.c b/lib/bitmap.c
--- a/lib/bitmap.c	Mon Mar 29 01:03:26 2004
+++ b/lib/bitmap.c	Mon Mar 29 01:03:26 2004
@@ -45,7 +45,7 @@
 EXPORT_SYMBOL(bitmap_full);
 
 int bitmap_equal(const unsigned long *bitmap1,
-		unsigned long *bitmap2, int bits)
+		const unsigned long *bitmap2, int bits)
 {
 	int k, lim = bits/BITS_PER_LONG;;
 	for (k = 0; k < lim; ++k)
@@ -61,13 +61,14 @@
 }
 EXPORT_SYMBOL(bitmap_equal);
 
-void bitmap_complement(unsigned long *bitmap, int bits)
+void bitmap_complement(unsigned long *dst, const unsigned long *src, int bits)
 {
-	int k;
-	int nr = BITS_TO_LONGS(bits);
+	int k, lim = bits/BITS_PER_LONG;;
+	for (k = 0; k < lim; ++k)
+		dst[k] = ~src[k];
 
-	for (k = 0; k < nr; ++k)
-		bitmap[k] = ~bitmap[k];
+	if (bits % BITS_PER_LONG)
+		dst[k] = ~src[k] & ((1UL << (bits % BITS_PER_LONG)) - 1);
 }
 EXPORT_SYMBOL(bitmap_complement);
 
@@ -122,6 +123,60 @@
 		dst[k] = bitmap1[k] | bitmap2[k];
 }
 EXPORT_SYMBOL(bitmap_or);
+
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
+	int k, lim = bits/BITS_PER_LONG;;
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
+	int k, lim = bits/BITS_PER_LONG;;
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
 
 #if BITS_PER_LONG == 32
 int bitmap_weight(const unsigned long *bitmap, int bits)


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
