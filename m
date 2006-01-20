Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422731AbWATCIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422731AbWATCIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422732AbWATCIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:08:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:53196 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422731AbWATCIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:08:12 -0500
Date: Thu, 19 Jan 2006 18:08:03 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: Paul Mundt <lethal@linux-sh.org>
Cc: akpm@osdl.org, James Bottomley <James.Bottomley@steeleye.com>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20060120020803.19584.59388.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060120020757.19584.33756.sendpatchset@jackhammer.engr.sgi.com>
References: <20060120020757.19584.33756.sendpatchset@jackhammer.engr.sgi.com>
Subject: [TEST PATCH 2/3] lib bitmap region multiword
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Paul Mundt <lethal@linux-sh.org>

Add support to the lib/bitmap.c bitmap_*_region() routines
for bitmap regions larger than one word (nbits > BITS_PER_LONG).
This removes a BUG_ON() in lib bitmap.

I have an updated store queue API for SH that is currently using this
with relative success, and at first glance, it seems like this could be
useful for x86 (arch/i386/kernel/pci-dma.c) as well. Particularly for
anything using dma_declare_coherent_memory() on large areas and that
attempts to allocate large buffers from that space.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Paul Jackson <pj@sgi.com>

---

This is Mundt's patch, rediffed against a bitmap region cleanup
by myself (pj), with a little tweaking of a variable name.

This compiles, but has never been tested past that.
I am hoping that Paul Mundt will be able to test.

 lib/bitmap.c |  109 ++++++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 75 insertions(+), 34 deletions(-)

--- 2.6.15-mm2.orig/lib/bitmap.c	2006-01-19 11:46:38.962860359 -0800
+++ 2.6.15-mm2/lib/bitmap.c	2006-01-19 11:47:34.411717879 -0800
@@ -689,30 +689,47 @@ EXPORT_SYMBOL(bitmap_bitremap);
  *
  * Return the bit offset in bitmap of the allocated sequence,
  * or -errno on failure.
- *
  */
 int bitmap_find_free_region(unsigned long *bitmap, int bits, int order)
 {
-	unsigned long mask;
-	int nbits = 1 << order;
-	int i;
-
-	if(nbits > BITS_PER_LONG)
-		return -EINVAL;
+	int nbits;		/* number of bits in region */
+	int nlongs;		/* num longs spanned by region in bitmap */
+	int nbitsinlong;	/* num bits of region in each spanned long */
+	unsigned long mask;	/* bitmask of bits [0 .. nbitsinlong-1] */
+	int i;			/* scans bitmap by longs */
+
+	nbits = 1 << order;
+	nlongs = (nbits + (BITS_PER_LONG - 1)) / BITS_PER_LONG;
+	nbitsinlong = nbits;
+	if(nbitsinlong > BITS_PER_LONG)
+		nbitsinlong = BITS_PER_LONG;
 
 	/* make a mask of the order */
-	mask = (1UL << (nbits - 1));
+	mask = (1UL << (nbitsinlong - 1));
 	mask += mask - 1;
 
-	/* run up the bitmap nbits at a time */
-	for (i = 0; i < bits; i += nbits) {
+	/* run up the bitmap nbitsinlong at a time */
+	for (i = 0; i < bits; i += nbitsinlong) {
 		int index = i / BITS_PER_LONG;
 		int offset = i - (index * BITS_PER_LONG);
-		if((bitmap[index] & (mask << offset)) == 0) {
+		int j, space = 1;
+
+		/* find space in the bitmap */
+		for (j = 0; j < nlongs; j++)
+			if ((bitmap[index + j] & (mask << offset))) {
+				space = 0;
+				break;
+			}
+
+		/* keep looking */
+		if (unlikely(!space))
+			continue;
+
+		for (j = 0; j < nlongs; j++)
 			/* set region in bitmap */
-			bitmap[index] |= (mask << offset);
-			return i;
-		}
+			bitmap[index + j] |= (mask << offset);
+
+		return i;
 	}
 	return -ENOMEM;
 }
@@ -729,13 +746,28 @@ EXPORT_SYMBOL(bitmap_find_free_region);
  */
 void bitmap_release_region(unsigned long *bitmap, int pos, int order)
 {
-	int nbits = 1 << order;
-	unsigned long mask = (1UL << (nbits - 1));
-	int index = pos / BITS_PER_LONG;
-	int offset = pos - (index * BITS_PER_LONG);
+	int nbits;		/* number of bits in region */
+	int nlongs;		/* num longs spanned by region in bitmap */
+	int index;		/* index first long of region in bitmap */
+	int offset;		/* bit offset region in bitmap[index] */
+	int nbitsinlong;	/* num bits of region in each spanned long */
+	unsigned long mask;	/* bitmask of bits [0 .. nbitsinlong-1] */
+	int i;			/* scans bitmap by longs */
+
+	nbits = 1 << order;
+	nlongs = (nbits + (BITS_PER_LONG - 1)) / BITS_PER_LONG;
+	index = pos / BITS_PER_LONG;
+	offset = pos - (index * BITS_PER_LONG);
+
+	nbitsinlong = nbits;
+	if (nbitsinlong > BITS_PER_LONG)
+		nbitsinlong = BITS_PER_LONG;
 
+	mask = (1UL << (nbitsinlong - 1));
 	mask += mask - 1;
-	bitmap[index] &= ~(mask << offset);
+
+	for (i = 0; i < nlongs; i++)
+		bitmap[index + i] &= ~(mask << offset);
 }
 EXPORT_SYMBOL(bitmap_release_region);
 
@@ -751,22 +783,31 @@ EXPORT_SYMBOL(bitmap_release_region);
  */
 int bitmap_allocate_region(unsigned long *bitmap, int pos, int order)
 {
-	int nbits = 1 << order;
-	unsigned long mask = (1UL << (nbits - 1));
-	int index = pos / BITS_PER_LONG;
-	int offset = pos - (index * BITS_PER_LONG);
-
-	/*
-	 * We don't do regions of nbits > BITS_PER_LONG.  The
-	 * algorithm would be a simple look for multiple zeros in the
-	 * array, but there's no driver today that needs this.  If you
-	 * trip this BUG(), you get to code it...
-	 */
-	BUG_ON(nbits > BITS_PER_LONG);
+	int nbits;		/* number of bits in region */
+	int nlongs;		/* num longs spanned by region in bitmap */
+	int index;		/* index first long of region in bitmap */
+	int offset;		/* bit offset region in bitmap[index] */
+	int nbitsinlong;	/* num bits of region in each spanned long */
+	unsigned long mask;	/* bitmask of bits [0 .. nbitsinlong-1] */
+	int i;			/* scans bitmap by longs */
+
+	nbits = 1 << order;
+	nlongs = (nbits + (BITS_PER_LONG - 1)) / BITS_PER_LONG;
+	index = pos / BITS_PER_LONG;
+	offset = pos - (index * BITS_PER_LONG);
+
+	nbitsinlong = nbits;
+	if (nbitsinlong > BITS_PER_LONG)
+		nbitsinlong = BITS_PER_LONG;
+
+	mask = (1UL << (nbitsinlong - 1));
 	mask += mask - 1;
-	if (bitmap[index] & (mask << offset))
-		return -EBUSY;
-	bitmap[index] |= (mask << offset);
+
+	for (i = 0; i < nlongs; i++)
+		if (bitmap[index + i] & (mask << offset))
+			return -EBUSY;
+	for (i = 0; i < nlongs; i++)
+		bitmap[index + i] |= (mask << offset);
 	return 0;
 }
 EXPORT_SYMBOL(bitmap_allocate_region);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
