Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUFCRsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUFCRsG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbUFCR1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:27:33 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:4574 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264853AbUFCRLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:11:19 -0400
Date: Thu, 3 Jun 2004 10:09:39 -0700
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Ashok Raj <ashok.raj@intel.com>,
       Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Joe Korty <joe.korty@ccur.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Paul Jackson <pj@sgi.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Simon Derr <Simon.Derr@bull.net>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH] cpumask 3/10 bitmap inlining and optimizations
Message-Id: <20040603100939.6a1c709d.pj@sgi.com>
In-Reply-To: <20040603094339.03ddfd42.pj@sgi.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask 3/10 bitmap inlining and optimizations

        These bitmap improvements make it a suitable basis for
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

 include/linux/bitmap.h |  266 ++++++++++++++++++++++----
 lib/bitmap.c           |   91 ++++----
 2 files changed, 276 insertions(+), 81 deletions(-)

Signed-off-by: Paul Jackson <pj@sgi.com>


Index: 2.6.7-rc2-mm2/include/linux/bitmap.h
===================================================================
--- 2.6.7-rc2-mm2.orig/include/linux/bitmap.h	2004-06-03 05:56:31.000000000 -0700
+++ 2.6.7-rc2-mm2/include/linux/bitmap.h	2004-06-03 05:57:06.000000000 -0700
@@ -3,57 +3,249 @@
 
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
+ * bitmap_zero(dst, nbits)			*dst = 0UL
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
+ * change_bit(bit, addr)		*addr ^= bit
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
 
-static inline void bitmap_zero(unsigned long *bitmap, int bits)
+static inline void bitmap_zero(unsigned long *dst, int nbits)
 {
-	memset(bitmap, 0, BITS_TO_LONGS(bits)*sizeof(unsigned long));
+	if (nbits <= BITS_PER_LONG)
+		*dst = 0UL;
+	else {
+		int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+		memset(dst, 0, len);
+	}
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
-	int len = BITS_TO_LONGS(bits)*sizeof(unsigned long);
-	memcpy(dst, src, len);
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
 
Index: 2.6.7-rc2-mm2/lib/bitmap.c
===================================================================
--- 2.6.7-rc2-mm2.orig/lib/bitmap.c	2004-06-03 05:56:31.000000000 -0700
+++ 2.6.7-rc2-mm2/lib/bitmap.c	2004-06-03 05:57:06.000000000 -0700
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
@@ -30,9 +31,14 @@
  * if you don't input any bitmaps to these ops that have some
  * unused bits set, then they won't output any set unused bits
  * in output bitmaps.
+ *
+ * The byte ordering of bitmaps is more natural on little
+ * endian architectures.  See the big-endian headers
+ * include/asm-ppc64/bitops.h and include/asm-s390/bitops.h
+ * for the best explanations of this ordering.
  */
 
-int bitmap_empty(const unsigned long *bitmap, int bits)
+int __bitmap_empty(const unsigned long *bitmap, int bits)
 {
 	int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
@@ -40,14 +46,14 @@
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
@@ -55,14 +61,14 @@
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
@@ -71,27 +77,26 @@
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
 
 /*
- * bitmap_shift_right - logical right shift of the bits in a bitmap
+ * __bitmap_shift_right - logical right shift of the bits in a bitmap
  *   @dst - destination bitmap
  *   @src - source bitmap
  *   @nbits - shift by this many bits
@@ -101,7 +106,7 @@
  * direction.  Zeros are fed into the vacated MS positions and the
  * LS bits shifted off the bottom are lost.
  */
-void bitmap_shift_right(unsigned long *dst,
+void __bitmap_shift_right(unsigned long *dst,
 			const unsigned long *src, int shift, int bits)
 {
 	int k, lim = BITS_TO_LONGS(bits), left = bits % BITS_PER_LONG;
@@ -131,10 +136,11 @@
 	if (off)
 		memset(&dst[lim - off], 0, off*sizeof(unsigned long));
 }
-EXPORT_SYMBOL(bitmap_shift_right);
+EXPORT_SYMBOL(__bitmap_shift_right);
+
 
 /*
- * bitmap_shift_left - logical left shift of the bits in a bitmap
+ * __bitmap_shift_left - logical left shift of the bits in a bitmap
  *   @dst - destination bitmap
  *   @src - source bitmap
  *   @nbits - shift by this many bits
@@ -144,7 +150,8 @@
  * direction.  Zeros are fed into the vacated LS bit positions
  * and those MS bits shifted off the top are lost.
  */
-void bitmap_shift_left(unsigned long *dst,
+
+void __bitmap_shift_left(unsigned long *dst,
 			const unsigned long *src, int shift, int bits)
 {
 	int k, lim = BITS_TO_LONGS(bits), left = bits % BITS_PER_LONG;
@@ -170,9 +177,9 @@
 	if (off)
 		memset(dst, 0, off*sizeof(unsigned long));
 }
-EXPORT_SYMBOL(bitmap_shift_left);
+EXPORT_SYMBOL(__bitmap_shift_left);
 
-void bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
+void __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 				const unsigned long *bitmap2, int bits)
 {
 	int k;
@@ -181,9 +188,9 @@
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
@@ -192,9 +199,9 @@
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
@@ -203,9 +210,9 @@
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
@@ -214,9 +221,9 @@
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
@@ -225,14 +232,13 @@
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
@@ -241,15 +247,14 @@
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
 
@@ -257,13 +262,12 @@
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
 
@@ -271,13 +275,12 @@
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
@@ -394,7 +397,7 @@
 		if (nchunks == 0 && chunk == 0)
 			continue;
 
-		bitmap_shift_left(maskp, maskp, CHUNKSZ, nmaskbits);
+		__bitmap_shift_left(maskp, maskp, CHUNKSZ, nmaskbits);
 		*maskp |= chunk;
 		nchunks++;
 		nbits += (nchunks == 1) ? nbits_to_hold_value(chunk) : CHUNKSZ;


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
