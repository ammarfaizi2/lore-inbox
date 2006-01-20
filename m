Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422730AbWATCIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422730AbWATCIN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422732AbWATCIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:08:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52940 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422730AbWATCIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:08:12 -0500
Date: Thu, 19 Jan 2006 18:07:57 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: Paul Mundt <lethal@linux-sh.org>
Cc: akpm@osdl.org, James Bottomley <James.Bottomley@steeleye.com>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20060120020757.19584.33756.sendpatchset@jackhammer.engr.sgi.com>
Subject: [TEST PATCH 1/3] lib bitmap region cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Paul Jackson <pj@sgi.com>

Some code cleanup on the lib/bitmap.c bitmap_*_region() routines:
 * spacing
 * variable names
 * comments

Has no change to code function.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

This compiles, but has not been tested past that.
I am hoping that Paul Mundt will be able to test.

 include/linux/bitmap.h |    3 ++
 lib/bitmap.c           |   57 ++++++++++++++++++++++++++++++-------------------
 2 files changed, 38 insertions(+), 22 deletions(-)

--- 2.6.15-mm2.orig/include/linux/bitmap.h	2006-01-18 23:31:05.859645986 -0800
+++ 2.6.15-mm2/include/linux/bitmap.h	2006-01-18 23:39:53.505381843 -0800
@@ -46,6 +46,9 @@
  * bitmap_parse(ubuf, ulen, dst, nbits)		Parse bitmap dst from user buf
  * bitmap_scnlistprintf(buf, len, src, nbits)	Print bitmap src as list to buf
  * bitmap_parselist(buf, dst, nbits)		Parse bitmap dst from list
+ * bitmap_find_free_region(bitmap, bits, order)	Find and allocate bit region
+ * bitmap_release_region(bitmap, pos, order)	Free specified bit region
+ * bitmap_allocate_region(bitmap, pos, order)	Allocate specified bit region
  */
 
 /*
--- 2.6.15-mm2.orig/lib/bitmap.c	2006-01-18 23:39:46.282642389 -0800
+++ 2.6.15-mm2/lib/bitmap.c	2006-01-18 23:40:23.342639589 -0800
@@ -682,34 +682,34 @@ EXPORT_SYMBOL(bitmap_bitremap);
  *	@bits: number of bits in the bitmap
  *	@order: region size to find (size is actually 1<<order)
  *
- * This is used to allocate a memory region from a bitmap.  The idea is
- * that the region has to be 1<<order sized and 1<<order aligned (this
- * makes the search algorithm much faster).
+ * Find a sequence of free (zero) bits in a bitmap and allocate
+ * them (set them to one).  Only consider sequences of length a
+ * power ('order') of two, alligned to that power of two, which
+ * makes the search algorithm much faster.
  *
- * The region is marked as set bits in the bitmap if a free one is
- * found.
+ * Return the bit offset in bitmap of the allocated sequence,
+ * or -errno on failure.
  *
- * Returns either beginning of region or negative error
  */
 int bitmap_find_free_region(unsigned long *bitmap, int bits, int order)
 {
 	unsigned long mask;
-	int pages = 1 << order;
+	int nbits = 1 << order;
 	int i;
 
-	if(pages > BITS_PER_LONG)
+	if(nbits > BITS_PER_LONG)
 		return -EINVAL;
 
 	/* make a mask of the order */
-	mask = (1ul << (pages - 1));
+	mask = (1UL << (nbits - 1));
 	mask += mask - 1;
 
-	/* run up the bitmap pages bits at a time */
-	for (i = 0; i < bits; i += pages) {
-		int index = i/BITS_PER_LONG;
+	/* run up the bitmap nbits at a time */
+	for (i = 0; i < bits; i += nbits) {
+		int index = i / BITS_PER_LONG;
 		int offset = i - (index * BITS_PER_LONG);
 		if((bitmap[index] & (mask << offset)) == 0) {
-			/* set region in bimap */
+			/* set region in bitmap */
 			bitmap[index] |= (mask << offset);
 			return i;
 		}
@@ -729,27 +729,40 @@ EXPORT_SYMBOL(bitmap_find_free_region);
  */
 void bitmap_release_region(unsigned long *bitmap, int pos, int order)
 {
-	int pages = 1 << order;
-	unsigned long mask = (1ul << (pages - 1));
-	int index = pos/BITS_PER_LONG;
+	int nbits = 1 << order;
+	unsigned long mask = (1UL << (nbits - 1));
+	int index = pos / BITS_PER_LONG;
 	int offset = pos - (index * BITS_PER_LONG);
+
 	mask += mask - 1;
 	bitmap[index] &= ~(mask << offset);
 }
 EXPORT_SYMBOL(bitmap_release_region);
 
+/**
+ *	bitmap_allocate_region - allocate bitmap region
+ *	@bitmap: a pointer to the bitmap
+ *	@pos: the beginning of the region
+ *	@order: the order of the bits to allocate (number is 1<<order)
+ *
+ * Allocate (set bits in) a specified region of a bitmap.
+ * Return 0 on success, or -EBUSY if specified region wasn't
+ * free (not all bits were zero).
+ */
 int bitmap_allocate_region(unsigned long *bitmap, int pos, int order)
 {
-	int pages = 1 << order;
-	unsigned long mask = (1ul << (pages - 1));
-	int index = pos/BITS_PER_LONG;
+	int nbits = 1 << order;
+	unsigned long mask = (1UL << (nbits - 1));
+	int index = pos / BITS_PER_LONG;
 	int offset = pos - (index * BITS_PER_LONG);
 
-	/* We don't do regions of pages > BITS_PER_LONG.  The
+	/*
+	 * We don't do regions of nbits > BITS_PER_LONG.  The
 	 * algorithm would be a simple look for multiple zeros in the
 	 * array, but there's no driver today that needs this.  If you
-	 * trip this BUG(), you get to code it... */
-	BUG_ON(pages > BITS_PER_LONG);
+	 * trip this BUG(), you get to code it...
+	 */
+	BUG_ON(nbits > BITS_PER_LONG);
 	mask += mask - 1;
 	if (bitmap[index] & (mask << offset))
 		return -EBUSY;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
