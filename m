Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbUAPF1X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 00:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbUAPF1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 00:27:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:8386 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263244AbUAPF07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 00:26:59 -0500
Date: Thu, 15 Jan 2004 21:26:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: joe.korty@ccur.com, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040115212613.3e345518.akpm@osdl.org>
In-Reply-To: <20040115211402.04c5c2c4.pj@sgi.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
	<16381.61618.275775.487768@cargo.ozlabs.ibm.com>
	<20040114150331.02220d4d.pj@sgi.com>
	<20040115002703.GA20971@tsunami.ccur.com>
	<20040114204009.3dc4c225.pj@sgi.com>
	<20040115081533.63c61d7f.akpm@osdl.org>
	<20040115181525.GA31086@tsunami.ccur.com>
	<20040115211402.04c5c2c4.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>   Should any of the other inline routines in include/bitmap.h
>    be moved to your new file lib/bitmap.c?

Yup.   The below patch will be in 2.6.1-mm4:



uninline bitmap functions

- A couple of them are using alloca (via DECLARE_BITMAP) and this generates
  a cannot-inline warning with -Winline.

- These functions are too big to inline anwyay.



---

 include/linux/bitmap.h |  140 ++++---------------------------------------------
 lib/Makefile           |    3 -
 lib/bitmap.c           |  140 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+), 127 deletions(-)

diff -puN /dev/null lib/bitmap.c
--- /dev/null	2002-08-30 16:31:37.000000000 -0700
+++ 25-akpm/lib/bitmap.c	2004-01-14 02:52:02.000000000 -0800
@@ -0,0 +1,140 @@
+#include <linux/bitmap.h>
+#include <linux/module.h>
+
+int bitmap_empty(const unsigned long *bitmap, int bits)
+{
+	int k, lim = bits/BITS_PER_LONG;
+	for (k = 0; k < lim; ++k)
+		if (bitmap[k])
+			return 0;
+
+	if (bits % BITS_PER_LONG)
+		if (bitmap[k] & ((1UL << (bits % BITS_PER_LONG)) - 1))
+			return 0;
+
+	return 1;
+}
+EXPORT_SYMBOL(bitmap_empty);
+
+int bitmap_full(const unsigned long *bitmap, int bits)
+{
+	int k, lim = bits/BITS_PER_LONG;
+	for (k = 0; k < lim; ++k)
+		if (~bitmap[k])
+			return 0;
+
+	if (bits % BITS_PER_LONG)
+		if (~bitmap[k] & ((1UL << (bits % BITS_PER_LONG)) - 1))
+			return 0;
+
+	return 1;
+}
+EXPORT_SYMBOL(bitmap_full);
+
+int bitmap_equal(const unsigned long *bitmap1,
+		unsigned long *bitmap2, int bits)
+{
+	int k, lim = bits/BITS_PER_LONG;;
+	for (k = 0; k < lim; ++k)
+		if (bitmap1[k] != bitmap2[k])
+			return 0;
+
+	if (bits % BITS_PER_LONG)
+		if ((bitmap1[k] ^ bitmap2[k]) &
+				((1UL << (bits % BITS_PER_LONG)) - 1))
+			return 0;
+
+	return 1;
+}
+EXPORT_SYMBOL(bitmap_equal);
+
+void bitmap_complement(unsigned long *bitmap, int bits)
+{
+	int k;
+
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
+		bitmap[k] = ~bitmap[k];
+}
+EXPORT_SYMBOL(bitmap_complement);
+
+void bitmap_shift_right(unsigned long *dst,
+			const unsigned long *src, int shift, int bits)
+{
+	int k;
+	DECLARE_BITMAP(__shr_tmp, bits);
+
+	bitmap_clear(__shr_tmp, bits);
+	for (k = 0; k < bits - shift; ++k)
+		if (test_bit(k + shift, src))
+			set_bit(k, __shr_tmp);
+	bitmap_copy(dst, __shr_tmp, bits);
+}
+EXPORT_SYMBOL(bitmap_shift_right);
+
+void bitmap_shift_left(unsigned long *dst,
+			const unsigned long *src, int shift, int bits)
+{
+	int k;
+	DECLARE_BITMAP(__shl_tmp, bits);
+
+	bitmap_clear(__shl_tmp, bits);
+	for (k = bits; k >= shift; --k)
+		if (test_bit(k - shift, src))
+			set_bit(k, __shl_tmp);
+	bitmap_copy(dst, __shl_tmp, bits);
+}
+EXPORT_SYMBOL(bitmap_shift_left);
+
+void bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
+				const unsigned long *bitmap2, int bits)
+{
+	int k;
+	int nr = BITS_TO_LONGS(bits);
+
+	for (k = 0; k < nr; k++)
+		dst[k] = bitmap1[k] & bitmap2[k];
+}
+EXPORT_SYMBOL(bitmap_and);
+
+void bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
+				const unsigned long *bitmap2, int bits)
+{
+	int k;
+	int nr = BITS_TO_LONGS(bits);
+
+	for (k = 0; k < nr; k++)
+		dst[k] = bitmap1[k] | bitmap2[k];
+}
+EXPORT_SYMBOL(bitmap_or);
+
+#if BITS_PER_LONG == 32
+int bitmap_weight(const unsigned long *bitmap, int bits)
+{
+	int k, w = 0, lim = bits/BITS_PER_LONG;
+
+	for (k = 0; k < lim; k++)
+		w += hweight32(bitmap[k]);
+
+	if (bits % BITS_PER_LONG)
+		w += hweight32(bitmap[k] &
+				((1UL << (bits % BITS_PER_LONG)) - 1));
+
+	return w;
+}
+#else
+int bitmap_weight(const unsigned long *bitmap, int bits)
+{
+	int k, w = 0, lim = bits/BITS_PER_LONG;
+
+	for (k = 0; k < lim; k++)
+		w += hweight64(bitmap[k]);
+
+	if (bits % BITS_PER_LONG)
+		w += hweight64(bitmap[k] &
+				((1UL << (bits % BITS_PER_LONG)) - 1));
+
+	return w;
+}
+#endif
+EXPORT_SYMBOL(bitmap_weight);
+
diff -puN include/linux/bitmap.h~uninline-bitmap-functions include/linux/bitmap.h
--- 25/include/linux/bitmap.h~uninline-bitmap-functions	2004-01-14 02:36:26.000000000 -0800
+++ 25-akpm/include/linux/bitmap.h	2004-01-14 02:36:26.000000000 -0800
@@ -10,57 +10,11 @@
 #include <linux/bitops.h>
 #include <linux/string.h>
 
-static inline int bitmap_empty(const unsigned long *bitmap, int bits)
-{
-	int k, lim = bits/BITS_PER_LONG;
-	for (k = 0; k < lim; ++k)
-		if (bitmap[k])
-			return 0;
-
-	if (bits % BITS_PER_LONG)
-		if (bitmap[k] & ((1UL << (bits % BITS_PER_LONG)) - 1))
-			return 0;
-
-	return 1;
-}
-
-static inline int bitmap_full(const unsigned long *bitmap, int bits)
-{
-	int k, lim = bits/BITS_PER_LONG;
-	for (k = 0; k < lim; ++k)
-		if (~bitmap[k])
-			return 0;
-
-	if (bits % BITS_PER_LONG)
-		if (~bitmap[k] & ((1UL << (bits % BITS_PER_LONG)) - 1))
-			return 0;
-
-	return 1;
-}
-
-static inline int bitmap_equal(const unsigned long *bitmap1,
-				unsigned long *bitmap2, int bits)
-{
-	int k, lim = bits/BITS_PER_LONG;;
-	for (k = 0; k < lim; ++k)
-		if (bitmap1[k] != bitmap2[k])
-			return 0;
-
-	if (bits % BITS_PER_LONG)
-		if ((bitmap1[k] ^ bitmap2[k]) &
-				((1UL << (bits % BITS_PER_LONG)) - 1))
-			return 0;
-
-	return 1;
-}
-
-static inline void bitmap_complement(unsigned long *bitmap, int bits)
-{
-	int k;
-
-	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
-		bitmap[k] = ~bitmap[k];
-}
+int bitmap_empty(const unsigned long *bitmap, int bits);
+int bitmap_full(const unsigned long *bitmap, int bits);
+int bitmap_equal(const unsigned long *bitmap1,
+			unsigned long *bitmap2, int bits);
+void bitmap_complement(unsigned long *bitmap, int bits);
 
 static inline void bitmap_clear(unsigned long *bitmap, int bits)
 {
@@ -78,81 +32,15 @@ static inline void bitmap_copy(unsigned 
 	memcpy(dst, src, BITS_TO_LONGS(bits)*sizeof(unsigned long));
 }
 
-static inline void bitmap_shift_right(unsigned long *dst,
-				const unsigned long *src, int shift, int bits)
-{
-	int k;
-	DECLARE_BITMAP(__shr_tmp, bits);
-
-	bitmap_clear(__shr_tmp, bits);
-	for (k = 0; k < bits - shift; ++k)
-		if (test_bit(k + shift, src))
-			set_bit(k, __shr_tmp);
-	bitmap_copy(dst, __shr_tmp, bits);
-}
-
-static inline void bitmap_shift_left(unsigned long *dst,
-				const unsigned long *src, int shift, int bits)
-{
-	int k;
-	DECLARE_BITMAP(__shl_tmp, bits);
-
-	bitmap_clear(__shl_tmp, bits);
-	for (k = bits; k >= shift; --k)
-		if (test_bit(k - shift, src))
-			set_bit(k, __shl_tmp);
-	bitmap_copy(dst, __shl_tmp, bits);
-}
-
-static inline void bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
-				const unsigned long *bitmap2, int bits)
-{
-	int k;
-	int nr = BITS_TO_LONGS(bits);
-
-	for (k = 0; k < nr; k++)
-		dst[k] = bitmap1[k] & bitmap2[k];
-}
-
-static inline void bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
-				const unsigned long *bitmap2, int bits)
-{
-	int k;
-	int nr = BITS_TO_LONGS(bits);
-
-	for (k = 0; k < nr; k++)
-		dst[k] = bitmap1[k] | bitmap2[k];
-}
-
-#if BITS_PER_LONG == 32
-static inline int bitmap_weight(const unsigned long *bitmap, int bits)
-{
-	int k, w = 0, lim = bits/BITS_PER_LONG;
-
-	for (k = 0; k < lim; k++)
-		w += hweight32(bitmap[k]);
-
-	if (bits % BITS_PER_LONG)
-		w += hweight32(bitmap[k] &
-				((1UL << (bits % BITS_PER_LONG)) - 1));
-
-	return w;
-}
-#else
-static inline int bitmap_weight(const unsigned long *bitmap, int bits)
-{
-	int k, w = 0, lim = bits/BITS_PER_LONG;
-
-	for (k = 0; k < lim; k++)
-		w += hweight64(bitmap[k]);
-
-	if (bits % BITS_PER_LONG)
-		w += hweight64(bitmap[k] &
-				((1UL << (bits % BITS_PER_LONG)) - 1));
-
-	return w;
-}
-#endif
+void bitmap_shift_right(unsigned long *dst,
+			const unsigned long *src, int shift, int bits);
+void bitmap_shift_left(unsigned long *dst,
+			const unsigned long *src, int shift, int bits);
+void bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
+void bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
+			const unsigned long *bitmap2, int bits);
+int bitmap_weight(const unsigned long *bitmap, int bits);
 
 #endif /* __ASSEMBLY__ */
 
diff -puN lib/Makefile~uninline-bitmap-functions lib/Makefile
--- 25/lib/Makefile~uninline-bitmap-functions	2004-01-14 02:36:26.000000000 -0800
+++ 25-akpm/lib/Makefile	2004-01-14 02:36:26.000000000 -0800
@@ -5,7 +5,8 @@
 
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
-	 kobject.o idr.o div64.o parser.o int_sqrt.o mask.o
+	 kobject.o idr.o div64.o parser.o int_sqrt.o mask.o \
+	 bitmap.o
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o

_

