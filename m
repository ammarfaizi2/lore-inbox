Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWA0OFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWA0OFi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWA0OFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:05:38 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:47060 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751136AbWA0OFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:05:37 -0500
Date: Fri, 27 Jan 2006 16:05:29 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       James Bottomley <James.Bottomley@SteelEye.com>, tony@atomide.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] bitmap: region cleanup
Message-ID: <20060127140529.GB29632@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
	James Bottomley <James.Bottomley@SteelEye.com>, tony@atomide.com,
	linux-kernel@vger.kernel.org
References: <20060127140457.GA29632@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127140457.GA29632@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Some code cleanup on the lib/bitmap.c bitmap_*_region() routines:

 * spacing
 * variable names
 * comments

Has no change to code function.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 include/linux/bitmap.h |    3 ++
 lib/bitmap.c           |   64 +++++++++++++++++++++++++++++-------------------
 2 files changed, 41 insertions(+), 26 deletions(-)

947165471de98d54de695d4de20a7dfe49b37490
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 7d8ff97..d9ed279 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -46,6 +46,9 @@
  * bitmap_parse(ubuf, ulen, dst, nbits)		Parse bitmap dst from user buf
  * bitmap_scnlistprintf(buf, len, src, nbits)	Print bitmap src as list to buf
  * bitmap_parselist(buf, dst, nbits)		Parse bitmap dst from list
+ * bitmap_find_free_region(bitmap, bits, order)	Find and allocate bit region
+ * bitmap_release_region(bitmap, pos, order)	Free specified bit region
+ * bitmap_allocate_region(bitmap, pos, order)	Allocate specified bit region
  */
 
 /*
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 48e7083..3fab1ce 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -677,39 +677,38 @@ int bitmap_bitremap(int oldbit, const un
 EXPORT_SYMBOL(bitmap_bitremap);
 
 /**
- *	bitmap_find_free_region - find a contiguous aligned mem region
+ * bitmap_find_free_region - find a contiguous aligned mem region
  *	@bitmap: an array of unsigned longs corresponding to the bitmap
  *	@bits: number of bits in the bitmap
  *	@order: region size to find (size is actually 1<<order)
  *
- * This is used to allocate a memory region from a bitmap.  The idea is
- * that the region has to be 1<<order sized and 1<<order aligned (this
- * makes the search algorithm much faster).
+ * Find a sequence of free (zero) bits in a bitmap and allocate
+ * them (set them to one).  Only consider sequences of length a
+ * power ('order') of two, aligned to that power of two, which
+ * makes the search algorithm much faster.
  *
- * The region is marked as set bits in the bitmap if a free one is
- * found.
- *
- * Returns either beginning of region or negative error
+ * Return the bit offset in bitmap of the allocated sequence,
+ * or -errno on failure.
  */
 int bitmap_find_free_region(unsigned long *bitmap, int bits, int order)
 {
 	unsigned long mask;
-	int pages = 1 << order;
+	int nbits = 1 << order;
 	int i;
 
-	if(pages > BITS_PER_LONG)
+	if (nbits > BITS_PER_LONG)
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
-		if((bitmap[index] & (mask << offset)) == 0) {
-			/* set region in bimap */
+		if ((bitmap[index] & (mask << offset)) == 0) {
+			/* set region in bitmap */
 			bitmap[index] |= (mask << offset);
 			return i;
 		}
@@ -719,7 +718,7 @@ int bitmap_find_free_region(unsigned lon
 EXPORT_SYMBOL(bitmap_find_free_region);
 
 /**
- *	bitmap_release_region - release allocated bitmap region
+ * bitmap_release_region - release allocated bitmap region
  *	@bitmap: a pointer to the bitmap
  *	@pos: the beginning of the region
  *	@order: the order of the bits to release (number is 1<<order)
@@ -729,27 +728,40 @@ EXPORT_SYMBOL(bitmap_find_free_region);
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
+ * bitmap_allocate_region - allocate bitmap region
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
