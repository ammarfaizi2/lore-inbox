Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbUC3ILv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 03:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbUC3ILv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 03:11:51 -0500
Received: from holomorphy.com ([207.189.100.168]:8352 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263366AbUC3ILp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 03:11:45 -0500
Date: Tue, 30 Mar 2004 00:11:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: remove bitmap_shift_*() bitmap length limits
Message-ID: <20040330081142.GL791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040330065152.GJ791@holomorphy.com> <20040330073604.GK791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330073604.GK791@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 11:36:04PM -0800, William Lee Irwin III wrote:
> An updated userspace test harness properly more demonstrating the
> zeroed tail preconditions/postconditions properties is included as a
> MIME attachment. The bitmap code requires no changes. This is merely a
> more adequate testcase.

The new testcase found issues with unaligned bitmap lengths. Fixed patch
below;


Index: mm5-2.6.5-rc2/lib/bitmap.c
===================================================================
--- mm5-2.6.5-rc2.orig/lib/bitmap.c	2004-03-29 17:44:14.000000000 -0800
+++ mm5-2.6.5-rc2/lib/bitmap.c	2004-03-30 00:09:21.000000000 -0800
@@ -12,8 +12,6 @@
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
-#define MAX_BITMAP_BITS	512U	/* for ia64 NR_CPUS maximum */
-
 int bitmap_empty(const unsigned long *bitmap, int bits)
 {
 	int k, lim = bits/BITS_PER_LONG;
@@ -72,7 +70,7 @@
 EXPORT_SYMBOL(bitmap_complement);
 
 /*
- * bitmap_shift_write - logical right shift of the bits in a bitmap
+ * bitmap_shift_right - logical right shift of the bits in a bitmap
  *   @dst - destination bitmap
  *   @src - source bitmap
  *   @nbits - shift by this many bits
@@ -85,15 +83,32 @@
 void bitmap_shift_right(unsigned long *dst,
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
 EXPORT_SYMBOL(bitmap_shift_right);
 
@@ -111,15 +126,28 @@
 void bitmap_shift_left(unsigned long *dst,
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
 EXPORT_SYMBOL(bitmap_shift_left);
 
