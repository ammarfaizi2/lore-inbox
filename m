Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUDHUOj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbUDHUEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 16:04:23 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:32742 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262413AbUDHTuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:50:50 -0400
Date: Thu, 8 Apr 2004 12:48:54 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 5/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408124854.0b6252ac.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P5.bitmap_extensions - Optimize and extend bitmap.

        This bitmap improvements make it a suitable basis for
        fully supporting cpumask_t and nodemask_t.  Inline macros
        with compile-time checks enable generating tight code on
        both small and large systems (large meaning cpumask_t
        requires more than one unsigned long's worth of bits).

        The existing bitmap_<op> macros in lib/bitmap.c
        are renamed to __bitmap_<op>, and wrappers for each
        bitmap_<op> are exposed in include/linux/bitmap.h

	This patch _includes_ Bill Irwins rewrite of the
	bitmap_shift operators to not require a fixed length
	intermediate bitmap.

	Improved comments list each available operator for easy
	browsing.

Index: 2.6.5.bitmap/include/linux/bitmap.h
===================================================================
--- 2.6.5.bitmap.orig/include/linux/bitmap.h	2004-04-07 21:22:32.000000000 -0700
+++ 2.6.5.bitmap/include/linux/bitmap.h	2004-04-07 21:23:52.000000000 -0700
@@ -1,59 +1,250 @@
-#ifndef __LINUX_BITMAP_H
-#define __LINUX_BITMAP_H
+#ifndef __LINUX__bitmap_H
+#define __LINUX__bitmap_H
 
 #ifndef __ASSEMBLY__
 
-#include <linux/config.h>
-#include <linux/compiler.h>
 #include <linux/types.h>
-#include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/string.h>
 
-int bitmap_empty(const unsigned long *bitmap, int bits);
-int bitmap_full(const unsigned long *bitmap, int bits);
-int bitmap_equal(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, int bits);
-void bitmap_complement(unsigned long *dst, const unsigned long *src, int bits);
+/*
+ * bitmaps provide bit arrays that consume one or more unsigned
+ * longs.  The bitmap interface and available operations are listed
+ * here, in bitmap.h
+ *
+ * Function implementations generic to all architectures are in
+ * lib/bitmap.c.  Functions implementations that are architecture
+ * specific are in various include/asm-<arch>/bitops.h headers
+ * and other arch/<arch> specific files.
+ * 
+ * See lib/bitmap.c for more details.
+ */
+
+/*
+ * The available bitmap operations and their rough meaning in the
+ * case that the bitmap is a single unsigned long are thus:
+ *
+ * bitmap_clear(dst, nbits)			*dst = 0UL
+ * bitmap_fill(dst, nbits)			*dst = ~0UL
+ * bitmap_copy(dst, src, nbits)			*dst = *src
+ * bitmap_and(dst, src1, src2, nbits)		*dst = *src1 & *src2
+ * bitmap_or(dst, src1, src2, nbits)		*dst = *src1 | *src2
+ * bitmap_xor(dst, src1, src2, nbits)		*dst = *src1 ^ *src2
+ * bitmap_andnot(dst, src1, src2, nbits)	*dst = *src1 & ~(*src2)
+ * bitmap_complement(dst, src, nbits)		*dst = ~(*src)
+ * bitmap_equal(src1, src2, nbits)		Are *src1 and *src2 equal?
+ * bitmap_intersects(src1, src2, nbits) 	Do *src1 and *src2 overlap?
+ * bitmap_subset(src1, src2, nbits)		Is *src1 a subset of *src2?
+ * bitmap_empty(src, nbits)			Are all bits zero in *src?
+ * bitmap_full(src, nbits)			Are all bits set in *src?
+ * bitmap_weight(src, nbits)			Hamming Weight: number set bits
+ * bitmap_shift_right(dst, src, n, nbits)	*dst = *src >> n
+ * bitmap_shift_left(dst, src, n, nbits)	*dst = *src << n
+ * bitmap_scnprintf(buf, len, src, nbits)	Print bitmap src to buf
+ * bitmap_parse(ubuf, ulen, dst, nbits)		Parse bitmap dst from buf
+ */
+
+/*
+ * Also the following operations in asm/bitops.h apply to bitmaps.
+ *
+ * set_bit(bit, addr)			*addr |= bit
+ * clear_bit(bit, addr)			*addr &= ~bit
+ * change_bit(bit, 			*addr ^= bit
+ * test_bit(bit, addr)			Is bit set in *addr?
+ * test_and_set_bit(bit, addr)		Set bit and return old value
+ * test_and_clear_bit(bit, addr)	Clear bit and return old value
+ * test_and_change_bit(bit, addr)	Change bit and return old value
+ * find_first_zero_bit(addr, nbits)	Position first zero bit in *addr
+ * find_first_bit(addr, nbits)		Position first set bit in *addr
+ * find_next_zero_bit(addr, nbits, bit)	Position next zero bit in *addr >= bit
+ * find_next_bit(addr, nbits, bit)	Position next set bit in *addr >= bit
+ */
+
+/*
+ * The DECLARE_BITMAP(name,bits) macro, in linux/types.h, can be used
+ * to declare an array named 'name' of just enough unsigned longs to
+ * contain all bit positions from 0 to 'bits' - 1.
+ */
+
+/*
+ * lib/bitmap.c provides these functions:
+ */
+
+extern int __bitmap_empty(const unsigned long *bitmap, int bits);
+extern int __bitmap_full(const unsigned long *bitmap, int bits);
+extern int __bitmap_equal(const unsigned long *bitmap1,
+                	const unsigned long *bitmap2, int bits);
+extern void __bitmap_complement(unsigned long *dst, const unsigned long *src,
+			int bits);
+extern void __bitmap_shift_right(unsigned long *dst,
+                        const unsigned long *src, int shift, int bits);
+extern void __bitmap_shift_left(unsigned long *dst,
+                        const unsigned long *src, int shift, int bits);
+extern void __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
+extern void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
+extern void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
+extern void __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
+extern int __bitmap_intersects(const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
+extern int __bitmap_subset(const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
+extern int __bitmap_weight(const unsigned long *bitmap, int bits);
+
+extern int bitmap_scnprintf(char *buf, unsigned int len,
+			const unsigned long *src, int nbits);
+extern int bitmap_parse(const char __user *ubuf, unsigned int ulen,
+			unsigned long *dst, int nbits);
+
+#define BITMAP_LAST_WORD_MASK(nbits)					\
+(									\
+	((nbits) % BITS_PER_LONG) ?					\
+		(1UL<<((nbits) % BITS_PER_LONG))-1 : ~0UL		\
+)				
 
-static inline void bitmap_clear(unsigned long *bitmap, int bits)
+static inline void bitmap_clear(unsigned long *dst, int nbits)
 {
-	CLEAR_BITMAP((unsigned long *)bitmap, bits);
+	if (nbits <= BITS_PER_LONG)
+		*dst = 0UL;
+	else
+		CLEAR_BITMAP(dst, nbits);
 }
 
-static inline void bitmap_fill(unsigned long *bitmap, int bits)
+static inline void bitmap_fill(unsigned long *dst, int nbits)
 {
-	memset(bitmap, 0xff, BITS_TO_LONGS(bits)*sizeof(unsigned long));
+	size_t nlongs = BITS_TO_LONGS(nbits);
+	if (nlongs > 1) {
+		int len = (nlongs - 1) * sizeof(unsigned long);
+		memset(dst, 0xff,  len);
+	}
+	dst[nlongs - 1] = BITMAP_LAST_WORD_MASK(nbits);
 }
 
-static inline void bitmap_copy(unsigned long *dst,
-			const unsigned long *src, int bits)
+static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
+			int nbits)
 {
-	memcpy(dst, src, BITS_TO_LONGS(bits)*sizeof(unsigned long));
+	if (nbits <= BITS_PER_LONG)
+		*dst = *src;
+	else {
+		int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+		memcpy(dst, src, len);
+	}
 }
 
-void bitmap_shift_right(unsigned long *dst,
-			const unsigned long *src, int shift, int bits);
-void bitmap_shift_left(unsigned long *dst,
-			const unsigned long *src, int shift, int bits);
-void bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
-			const unsigned long *bitmap2, int bits);
-void bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
-			const unsigned long *bitmap2, int bits);
-void bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
-			const unsigned long *bitmap2, int bits);
-void bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
-			const unsigned long *bitmap2, int bits);
-int bitmap_intersects(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, int bits);
-int bitmap_subset(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, int bits);
-int bitmap_weight(const unsigned long *bitmap, int bits);
-int bitmap_scnprintf(char *buf, unsigned int buflen,
-			const unsigned long *maskp, int bits);
-int bitmap_parse(const char __user *ubuf, unsigned int ubuflen,
-			unsigned long *maskp, int bits);
+static inline void bitmap_and(unsigned long *dst, const unsigned long *src1,
+			const unsigned long *src2, int nbits)
+{
+	if (nbits <= BITS_PER_LONG)
+		*dst = *src1 & *src2;
+	else
+		__bitmap_and(dst, src1, src2, nbits);
+}
+
+static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
+			const unsigned long *src2, int nbits)
+{
+	if (nbits <= BITS_PER_LONG)
+		*dst = *src1 | *src2;
+	else
+		__bitmap_or(dst, src1, src2, nbits);
+}
+
+static inline void bitmap_xor(unsigned long *dst, const unsigned long *src1,
+			const unsigned long *src2, int nbits)
+{
+	if (nbits <= BITS_PER_LONG)
+		*dst = *src1 ^ *src2;
+	else
+		__bitmap_xor(dst, src1, src2, nbits);
+}
+
+static inline void bitmap_andnot(unsigned long *dst, const unsigned long *src1,
+			const unsigned long *src2, int nbits)
+{
+	if (nbits <= BITS_PER_LONG)
+		*dst = *src1 & ~(*src2);
+	else
+		__bitmap_andnot(dst, src1, src2, nbits);
+}
+
+static inline void bitmap_complement(unsigned long *dst, const unsigned long *src,
+			int nbits)
+{
+	if (nbits <= BITS_PER_LONG)
+		*dst = ~(*src) & BITMAP_LAST_WORD_MASK(nbits);
+	else
+		__bitmap_complement(dst, src, nbits);
+}
+
+static inline int bitmap_equal(const unsigned long *src1,
+			const unsigned long *src2, int nbits)
+{
+	if (nbits <= BITS_PER_LONG)
+		return ! ((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
+	else
+		return __bitmap_equal(src1, src2, nbits);
+}
+
+static inline int bitmap_intersects(const unsigned long *src1,
+			const unsigned long *src2, int nbits)
+{
+	if (nbits <= BITS_PER_LONG)
+		return ((*src1 & *src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
+	else
+		return __bitmap_intersects(src1, src2, nbits);
+}
+
+static inline int bitmap_subset(const unsigned long *src1,
+			const unsigned long *src2, int nbits)
+{
+	if (nbits <= BITS_PER_LONG)
+		return ! ((*src1 & ~(*src2)) & BITMAP_LAST_WORD_MASK(nbits));
+	else
+		return __bitmap_subset(src1, src2, nbits);
+}
+
+static inline int bitmap_empty(const unsigned long *src, int nbits)
+{
+	if (nbits <= BITS_PER_LONG)
+		return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
+	else
+		return __bitmap_empty(src, nbits);
+}
+
+static inline int bitmap_full(const unsigned long *src, int nbits)
+{
+	if (nbits <= BITS_PER_LONG)
+		return ! (~(*src) & BITMAP_LAST_WORD_MASK(nbits));
+	else
+		return __bitmap_full(src, nbits);
+}
+
+static inline int bitmap_weight(const unsigned long *src, int nbits)
+{
+	return __bitmap_weight(src, nbits);
+}
+
+static inline void bitmap_shift_right(unsigned long *dst,
+			const unsigned long *src, int n, int nbits)
+{
+	if (nbits <= BITS_PER_LONG)
+		*dst = *src >> n;
+	else
+		__bitmap_shift_right(dst, src, n, nbits);
+}
+
+static inline void bitmap_shift_left(unsigned long *dst,
+			const unsigned long *src, int n, int nbits)
+{
+	if (nbits <= BITS_PER_LONG)
+		*dst = (*src << n) & BITMAP_LAST_WORD_MASK(nbits);
+	else
+		__bitmap_shift_left(dst, src, n, nbits);
+}
 
 #endif /* __ASSEMBLY__ */
 
-#endif /* __LINUX_BITMAP_H */
+#endif /* __LINUX__bitmap_H */
Index: 2.6.5.bitmap/lib/bitmap.c
===================================================================
--- 2.6.5.bitmap.orig/lib/bitmap.c	2004-04-07 21:22:32.000000000 -0700
+++ 2.6.5.bitmap/lib/bitmap.c	2004-04-07 21:23:52.000000000 -0700
@@ -15,7 +15,8 @@
 /*
  * bitmaps provide an array of bits, implemented using an an
  * array of unsigned longs.  The number of valid bits in a
- * given bitmap need not be an exact multiple of BITS_PER_LONG.
+ * given bitmap does _not_ need to be an exact multiple of
+ * BITS_PER_LONG.
  *
  * The possible unused bits in the last, partially used word
  * of a bitmap are 'don't care'.  The implementation makes
@@ -30,11 +31,14 @@
  * if you don't input any bitmaps to these ops that have some
  * unused bits set, then they won't output any set unused bits
  * in output bitmaps.
+ *
+ * The byte ordering of bitmaps is more natural on little
+ * endian architectures.  See the big-endian headers
+ * include/asm-ppc64/bitops.h and include/asm-s390/bitops.h
+ * for the best explanations of this ordering.
  */
 
-#define MAX_BITMAP_BITS	512U	/* for ia64 NR_CPUS maximum */
-
-int bitmap_empty(const unsigned long *bitmap, int bits)
+int __bitmap_empty(const unsigned long *bitmap, int bits)
 {
 	int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
@@ -42,14 +46,14 @@
 			return 0;
 
 	if (bits % BITS_PER_LONG)
-		if (bitmap[k] & ((1UL << (bits % BITS_PER_LONG)) - 1))
+		if (bitmap[k] & BITMAP_LAST_WORD_MASK(bits))
 			return 0;
 
 	return 1;
 }
-EXPORT_SYMBOL(bitmap_empty);
+EXPORT_SYMBOL(__bitmap_empty);
 
-int bitmap_full(const unsigned long *bitmap, int bits)
+int __bitmap_full(const unsigned long *bitmap, int bits)
 {
 	int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
@@ -57,14 +61,14 @@
 			return 0;
 
 	if (bits % BITS_PER_LONG)
-		if (~bitmap[k] & ((1UL << (bits % BITS_PER_LONG)) - 1))
+		if (~bitmap[k] & BITMAP_LAST_WORD_MASK(bits))
 			return 0;
 
 	return 1;
 }
-EXPORT_SYMBOL(bitmap_full);
+EXPORT_SYMBOL(__bitmap_full);
 
-int bitmap_equal(const unsigned long *bitmap1,
+int __bitmap_equal(const unsigned long *bitmap1,
 		const unsigned long *bitmap2, int bits)
 {
 	int k, lim = bits/BITS_PER_LONG;
@@ -73,56 +77,85 @@
 			return 0;
 
 	if (bits % BITS_PER_LONG)
-		if ((bitmap1[k] ^ bitmap2[k]) &
-				((1UL << (bits % BITS_PER_LONG)) - 1))
+		if ((bitmap1[k] ^ bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
 			return 0;
 
 	return 1;
 }
-EXPORT_SYMBOL(bitmap_equal);
+EXPORT_SYMBOL(__bitmap_equal);
 
-void bitmap_complement(unsigned long *dst, const unsigned long *src, int bits)
+void __bitmap_complement(unsigned long *dst, const unsigned long *src, int bits)
 {
 	int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		dst[k] = ~src[k];
 
 	if (bits % BITS_PER_LONG)
-		dst[k] = ~src[k] & ((1UL << (bits % BITS_PER_LONG)) - 1);
+		dst[k] = ~src[k] & BITMAP_LAST_WORD_MASK(bits);
 }
-EXPORT_SYMBOL(bitmap_complement);
+EXPORT_SYMBOL(__bitmap_complement);
 
-void bitmap_shift_right(unsigned long *dst,
+void __bitmap_shift_right(unsigned long *dst,
 			const unsigned long *src, int shift, int bits)
 {
-	int k;
-	DECLARE_BITMAP(__shr_tmp, MAX_BITMAP_BITS);
-
-	BUG_ON(bits > MAX_BITMAP_BITS);
-	bitmap_clear(__shr_tmp, bits);
-	for (k = 0; k < bits - shift; ++k)
-		if (test_bit(k + shift, src))
-			set_bit(k, __shr_tmp);
-	bitmap_copy(dst, __shr_tmp, bits);
+	int k, lim = BITS_TO_LONGS(bits), left = bits % BITS_PER_LONG;
+	int off = shift/BITS_PER_LONG, rem = shift % BITS_PER_LONG;
+	unsigned long mask = (1UL << left) - 1;
+	for (k = 0; off + k < lim; ++k) {
+		unsigned long upper, lower;
+
+		/*
+		 * If shift is not word aligned, take lower rem bits of
+		 * word above and make them the top rem bits of result.
+		 */
+		if (!rem || off + k + 1 >= lim)
+			upper = 0;
+		else {
+			upper = src[off + k + 1];
+			if (off + k + 1 == lim - 1 && left)
+				upper &= mask;
+		}
+		lower = src[off + k];
+		if (left && off + k == lim - 1)
+			lower &= mask;
+		dst[k] = upper << (BITS_PER_LONG - rem) | lower >> rem;
+		if (left && k == lim - 1)
+			dst[k] &= mask;
+	}
+	if (off)
+		memset(&dst[lim - off], 0, off*sizeof(unsigned long));
 }
-EXPORT_SYMBOL(bitmap_shift_right);
+EXPORT_SYMBOL(__bitmap_shift_right);
 
-void bitmap_shift_left(unsigned long *dst,
+void __bitmap_shift_left(unsigned long *dst,
 			const unsigned long *src, int shift, int bits)
 {
-	int k;
-	DECLARE_BITMAP(__shl_tmp, MAX_BITMAP_BITS);
-
-	BUG_ON(bits > MAX_BITMAP_BITS);
-	bitmap_clear(__shl_tmp, bits);
-	for (k = bits; k >= shift; --k)
-		if (test_bit(k - shift, src))
-			set_bit(k, __shl_tmp);
-	bitmap_copy(dst, __shl_tmp, bits);
+	int k, lim = BITS_TO_LONGS(bits), left = bits % BITS_PER_LONG;
+	int off = shift/BITS_PER_LONG, rem = shift % BITS_PER_LONG;
+	for (k = lim - off - 1; k >= 0; --k) {
+		unsigned long upper, lower;
+
+		/*
+		 * If shift is not word aligned, take upper rem bits of
+		 * word below and make them the bottom rem bits of result.
+		 */
+		if (rem && k > 0)
+			lower = src[k - 1];
+		else
+			lower = 0;
+		upper = src[k];
+		if (left && k == lim - 1)
+			upper &= (1UL << left) - 1;
+		dst[k + off] = lower  >> (BITS_PER_LONG - rem) | upper << rem;
+		if (left && k + off == lim - 1)
+			dst[k + off] &= (1UL << left) - 1;
+	}
+	if (off)
+		memset(dst, 0, off*sizeof(unsigned long));
 }
-EXPORT_SYMBOL(bitmap_shift_left);
+EXPORT_SYMBOL(__bitmap_shift_left);
 
-void bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
+void __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 				const unsigned long *bitmap2, int bits)
 {
 	int k;
@@ -131,9 +164,9 @@
 	for (k = 0; k < nr; k++)
 		dst[k] = bitmap1[k] & bitmap2[k];
 }
-EXPORT_SYMBOL(bitmap_and);
+EXPORT_SYMBOL(__bitmap_and);
 
-void bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
+void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 				const unsigned long *bitmap2, int bits)
 {
 	int k;
@@ -142,9 +175,9 @@
 	for (k = 0; k < nr; k++)
 		dst[k] = bitmap1[k] | bitmap2[k];
 }
-EXPORT_SYMBOL(bitmap_or);
+EXPORT_SYMBOL(__bitmap_or);
 
-void bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
+void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
 				const unsigned long *bitmap2, int bits)
 {
 	int k;
@@ -153,9 +186,9 @@
 	for (k = 0; k < nr; k++)
 		dst[k] = bitmap1[k] ^ bitmap2[k];
 }
-EXPORT_SYMBOL(bitmap_xor);
+EXPORT_SYMBOL(__bitmap_xor);
 
-void bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+void __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 				const unsigned long *bitmap2, int bits)
 {
 	int k;
@@ -164,9 +197,9 @@
 	for (k = 0; k < nr; k++)
 		dst[k] = bitmap1[k] & ~bitmap2[k];
 }
-EXPORT_SYMBOL(bitmap_andnot);
+EXPORT_SYMBOL(__bitmap_andnot);
 
-int bitmap_intersects(const unsigned long *bitmap1,
+int __bitmap_intersects(const unsigned long *bitmap1,
 				const unsigned long *bitmap2, int bits)
 {
 	int k, lim = bits/BITS_PER_LONG;
@@ -175,14 +208,13 @@
 			return 1;
 
 	if (bits % BITS_PER_LONG)
-		if ((bitmap1[k] & bitmap2[k]) &
-				((1UL << (bits % BITS_PER_LONG)) - 1))
+		if ((bitmap1[k] & bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
 			return 1;
 	return 0;
 }
-EXPORT_SYMBOL(bitmap_intersects);
+EXPORT_SYMBOL(__bitmap_intersects);
 
-int bitmap_subset(const unsigned long *bitmap1,
+int __bitmap_subset(const unsigned long *bitmap1,
 				const unsigned long *bitmap2, int bits)
 {
 	int k, lim = bits/BITS_PER_LONG;
@@ -191,15 +223,14 @@
 			return 0;
 
 	if (bits % BITS_PER_LONG)
-		if ((bitmap1[k] & ~bitmap2[k]) &
-				((1UL << (bits % BITS_PER_LONG)) - 1))
+		if ((bitmap1[k] & ~bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
 			return 0;
 	return 1;
 }
-EXPORT_SYMBOL(bitmap_subset);
+EXPORT_SYMBOL(__bitmap_subset);
 
 #if BITS_PER_LONG == 32
-int bitmap_weight(const unsigned long *bitmap, int bits)
+int __bitmap_weight(const unsigned long *bitmap, int bits)
 {
 	int k, w = 0, lim = bits/BITS_PER_LONG;
 
@@ -207,13 +238,12 @@
 		w += hweight32(bitmap[k]);
 
 	if (bits % BITS_PER_LONG)
-		w += hweight32(bitmap[k] &
-				((1UL << (bits % BITS_PER_LONG)) - 1));
+		w += hweight32(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
 
 	return w;
 }
 #else
-int bitmap_weight(const unsigned long *bitmap, int bits)
+int __bitmap_weight(const unsigned long *bitmap, int bits)
 {
 	int k, w = 0, lim = bits/BITS_PER_LONG;
 
@@ -221,13 +251,12 @@
 		w += hweight64(bitmap[k]);
 
 	if (bits % BITS_PER_LONG)
-		w += hweight64(bitmap[k] &
-				((1UL << (bits % BITS_PER_LONG)) - 1));
+		w += hweight64(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
 
 	return w;
 }
 #endif
-EXPORT_SYMBOL(bitmap_weight);
+EXPORT_SYMBOL(__bitmap_weight);
 
 /*
  * Bitmap printing & parsing functions: first version by Bill Irwin,
@@ -344,7 +373,7 @@
 		if (nchunks == 0 && chunk == 0)
 			continue;
 
-		bitmap_shift_right(maskp, maskp, CHUNKSZ, nmaskbits);
+		__bitmap_shift_right(maskp, maskp, CHUNKSZ, nmaskbits);
 		*maskp |= chunk;
 		nchunks++;
 		nbits += (nchunks == 1) ? nbits_to_hold_value(chunk) : CHUNKSZ;


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
