Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422734AbWATCIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422734AbWATCIi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWATCIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:08:37 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:56012 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422732AbWATCIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:08:16 -0500
Date: Thu, 19 Jan 2006 18:08:08 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: Paul Mundt <lethal@linux-sh.org>
Cc: akpm@osdl.org, James Bottomley <James.Bottomley@steeleye.com>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20060120020808.19584.3859.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060120020757.19584.33756.sendpatchset@jackhammer.engr.sgi.com>
References: <20060120020757.19584.33756.sendpatchset@jackhammer.engr.sgi.com>
Subject: [TEST PATCH 3/3] lib bitmap region restructure
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Paul Jackson <pj@sgi.com>

Restructure the bitmap_*_region() operations, to avoid code
duplication.

Also reduces binary text size by about 100 bytes (ia64 arch).
The original Bottomley bitmap_*_region patch added about 1000
bytes of compiled kernel text (ia64).  The Mundt multiword
extension added another 600 bytes, and this restructuring patch
gets back about 100 bytes.

But the real motivation was the reduced amount of duplicated
code.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

This compiles, but has not been tested past that.
Be more careful of this patch -- unlike the previous
two in this set, this patch reworks quite a bit of
the logic, so is at higher risk of being broken.

 lib/bitmap.c |  199 ++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 102 insertions(+), 97 deletions(-)

--- 2.6.15-mm2.orig/lib/bitmap.c	2006-01-19 16:45:52.421764533 -0800
+++ 2.6.15-mm2/lib/bitmap.c	2006-01-19 17:50:21.692255714 -0800
@@ -676,138 +676,143 @@ int bitmap_bitremap(int oldbit, const un
 }
 EXPORT_SYMBOL(bitmap_bitremap);
 
-/**
- *	bitmap_find_free_region - find a contiguous aligned mem region
- *	@bitmap: an array of unsigned longs corresponding to the bitmap
- *	@bits: number of bits in the bitmap
- *	@order: region size to find (size is actually 1<<order)
+/*
+ * Common code for bitmap_*_region() routines.
+ *	bitmap: array of unsigned longs corresponding to the bitmap
+ *	pos: the beginning of the region
+ *	order: region size (log base 2 of number of bits)
+ *	reg_op: operation(s) to perform on that region of bitmap
  *
- * Find a sequence of free (zero) bits in a bitmap and allocate
- * them (set them to one).  Only consider sequences of length a
- * power ('order') of two, alligned to that power of two, which
- * makes the search algorithm much faster.
+ * Can set, verify and/or release a region of bits in a bitmap,
+ * depending on which combination of REG_OP_* flag bits is set.
  *
- * Return the bit offset in bitmap of the allocated sequence,
- * or -errno on failure.
+ * A region of a bitmap is a sequence of bits in the bitmap, of
+ * some size '1 << order' (a power of two), alligned to that same
+ * '1 << order' power of two.
+ *
+ * Returns 1 if REG_OP_ISFREE succeeds (region is all zero bits).
+ * Returns 0 in all other cases and reg_ops.
  */
-int bitmap_find_free_region(unsigned long *bitmap, int bits, int order)
+
+enum {
+	REG_OP_ISFREE,		/* true if region is all zero bits */
+	REG_OP_ALLOC,		/* set all bits in region */
+	REG_OP_RELEASE,		/* clear all bits in region */
+};
+
+static int __reg_op(unsigned long *bitmap, int pos, int order, int reg_op)
 {
-	int nbits;		/* number of bits in region */
-	int nlongs;		/* num longs spanned by region in bitmap */
+	int nbits_reg;		/* number of bits in region */
+	int index;		/* index first long of region in bitmap */
+	int offset;		/* bit offset region in bitmap[index] */
+	int nlongs_reg;		/* num longs spanned by region in bitmap */
 	int nbitsinlong;	/* num bits of region in each spanned long */
-	unsigned long mask;	/* bitmask of bits [0 .. nbitsinlong-1] */
+	unsigned long mask;	/* bitmask for one long of region */
 	int i;			/* scans bitmap by longs */
+	int ret = 0;		/* return value */
 
-	nbits = 1 << order;
-	nlongs = (nbits + (BITS_PER_LONG - 1)) / BITS_PER_LONG;
-	nbitsinlong = nbits;
-	if(nbitsinlong > BITS_PER_LONG)
-		nbitsinlong = BITS_PER_LONG;
+	/*
+	 * Either nlongs_reg == 1 (for small orders that fit in one long)
+	 * or (offset == 0 && mask == ~0UL) (for larger multiword orders.)
+	 */
+	nbits_reg = 1 << order;
+	index = pos / BITS_PER_LONG;
+	offset = pos - (index * BITS_PER_LONG);
+	nlongs_reg = BITS_TO_LONGS(nbits_reg);
+	nbitsinlong = min(nbits_reg,  BITS_PER_LONG);
 
-	/* make a mask of the order */
+	/*
+	 * Can't do "mask = (1UL << nbitsinlong) - 1", as that
+	 * overflows if nbitsinlong == BITS_PER_LONG.
+	 */
 	mask = (1UL << (nbitsinlong - 1));
 	mask += mask - 1;
+	mask <<= offset;
 
-	/* run up the bitmap nbitsinlong at a time */
-	for (i = 0; i < bits; i += nbitsinlong) {
-		int index = i / BITS_PER_LONG;
-		int offset = i - (index * BITS_PER_LONG);
-		int j, space = 1;
-
-		/* find space in the bitmap */
-		for (j = 0; j < nlongs; j++)
-			if ((bitmap[index + j] & (mask << offset))) {
-				space = 0;
-				break;
-			}
-
-		/* keep looking */
-		if (unlikely(!space))
-			continue;
-
-		for (j = 0; j < nlongs; j++)
-			/* set region in bitmap */
-			bitmap[index + j] |= (mask << offset);
-
-		return i;
+	switch (reg_op) {
+	case REG_OP_ISFREE:
+		for (i = 0; i < nlongs_reg; i++) {
+			if (bitmap[index + i] & mask)
+				goto done;
+		}
+		ret = 1;	/* all bits in region free (zero) */
+		break;
+
+	case REG_OP_ALLOC:
+		for (i = 0; i < nlongs_reg; i++)
+			bitmap[index + i] |= mask;
+		break;
+
+	case REG_OP_RELEASE:
+		for (i = 0; i < nlongs_reg; i++)
+			bitmap[index + i] &= ~mask;
+		break;
 	}
-	return -ENOMEM;
+done:
+	return ret;
+}
+
+/**
+ *	bitmap_find_free_region - find a contiguous aligned mem region
+ *	@bitmap: array of unsigned longs corresponding to the bitmap
+ *	@bits: number of bits in the bitmap
+ *	@order: region size (log base 2 of number of bits) to find
+ *
+ * Find a region of free (zero) bits in a @bitmap of @bits bits and
+ * allocate them (set them to one).  Only consider regions of length
+ * a power (@order) of two, alligned to that power of two, which
+ * makes the search algorithm much faster.
+ *
+ * Return the bit offset in bitmap of the allocated region,
+ * or -errno on failure.
+ */
+int bitmap_find_free_region(unsigned long *bitmap, int bits, int order)
+{
+	int pos;		/* scans bitmap by regions of size order */
+
+	for (pos = 0; pos < bits; pos += (1 << order))
+		if (__reg_op(bitmap, pos, order, REG_OP_ISFREE))
+			break;
+	if (pos == bits)
+		return -ENOMEM;
+	__reg_op(bitmap, pos, order, REG_OP_ALLOC);
+	return pos;
 }
 EXPORT_SYMBOL(bitmap_find_free_region);
 
 /**
  *	bitmap_release_region - release allocated bitmap region
- *	@bitmap: a pointer to the bitmap
- *	@pos: the beginning of the region
- *	@order: the order of the bits to release (number is 1<<order)
+ *	@bitmap: array of unsigned longs corresponding to the bitmap
+ *	@pos: beginning of bit region to release
+ *	@order: region size (log base 2 of number of bits) to release
  *
  * This is the complement to __bitmap_find_free_region and releases
  * the found region (by clearing it in the bitmap).
+ *
+ * No return value.
  */
 void bitmap_release_region(unsigned long *bitmap, int pos, int order)
 {
-	int nbits;		/* number of bits in region */
-	int nlongs;		/* num longs spanned by region in bitmap */
-	int index;		/* index first long of region in bitmap */
-	int offset;		/* bit offset region in bitmap[index] */
-	int nbitsinlong;	/* num bits of region in each spanned long */
-	unsigned long mask;	/* bitmask of bits [0 .. nbitsinlong-1] */
-	int i;			/* scans bitmap by longs */
-
-	nbits = 1 << order;
-	nlongs = (nbits + (BITS_PER_LONG - 1)) / BITS_PER_LONG;
-	index = pos / BITS_PER_LONG;
-	offset = pos - (index * BITS_PER_LONG);
-
-	nbitsinlong = nbits;
-	if (nbitsinlong > BITS_PER_LONG)
-		nbitsinlong = BITS_PER_LONG;
-
-	mask = (1UL << (nbitsinlong - 1));
-	mask += mask - 1;
-
-	for (i = 0; i < nlongs; i++)
-		bitmap[index + i] &= ~(mask << offset);
+	__reg_op(bitmap, pos, order, REG_OP_RELEASE);
 }
 EXPORT_SYMBOL(bitmap_release_region);
 
 /**
  *	bitmap_allocate_region - allocate bitmap region
- *	@bitmap: a pointer to the bitmap
- *	@pos: the beginning of the region
- *	@order: the order of the bits to allocate (number is 1<<order)
+ *	@bitmap: array of unsigned longs corresponding to the bitmap
+ *	@pos: beginning of bit region to allocate
+ *	@order: region size (log base 2 of number of bits) to allocate
  *
  * Allocate (set bits in) a specified region of a bitmap.
+ *
  * Return 0 on success, or -EBUSY if specified region wasn't
  * free (not all bits were zero).
  */
 int bitmap_allocate_region(unsigned long *bitmap, int pos, int order)
 {
-	int nbits;		/* number of bits in region */
-	int nlongs;		/* num longs spanned by region in bitmap */
-	int index;		/* index first long of region in bitmap */
-	int offset;		/* bit offset region in bitmap[index] */
-	int nbitsinlong;	/* num bits of region in each spanned long */
-	unsigned long mask;	/* bitmask of bits [0 .. nbitsinlong-1] */
-	int i;			/* scans bitmap by longs */
-
-	nbits = 1 << order;
-	nlongs = (nbits + (BITS_PER_LONG - 1)) / BITS_PER_LONG;
-	index = pos / BITS_PER_LONG;
-	offset = pos - (index * BITS_PER_LONG);
-
-	nbitsinlong = nbits;
-	if (nbitsinlong > BITS_PER_LONG)
-		nbitsinlong = BITS_PER_LONG;
-
-	mask = (1UL << (nbitsinlong - 1));
-	mask += mask - 1;
-
-	for (i = 0; i < nlongs; i++)
-		if (bitmap[index + i] & (mask << offset))
-			return -EBUSY;
-	for (i = 0; i < nlongs; i++)
-		bitmap[index + i] |= (mask << offset);
+	if (! __reg_op(bitmap, pos, order, REG_OP_ISFREE))
+		return -EBUSY;
+	__reg_op(bitmap, pos, order, REG_OP_ALLOC);
 	return 0;
 }
 EXPORT_SYMBOL(bitmap_allocate_region);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
