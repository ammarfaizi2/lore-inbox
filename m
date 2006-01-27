Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWA0OGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWA0OGE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWA0OGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:06:04 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:63144 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751147AbWA0OGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:06:01 -0500
Date: Fri, 27 Jan 2006 16:06:00 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       James Bottomley <James.Bottomley@SteelEye.com>, tony@atomide.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] bitmap: region multiword spanning support
Message-ID: <20060127140600.GC29632@linux-sh.org>
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

Add support to the lib/bitmap.c bitmap_*_region() routines

for bitmap regions larger than one word (nbits > BITS_PER_LONG).
This removes a BUG_ON() in lib bitmap.

I have an updated store queue API for SH that is currently using this
with relative success, and at first glance, it seems like this could be
useful for x86 (arch/i386/kernel/pci-dma.c) as well. Particularly for
anything using dma_declare_coherent_memory() on large areas and that
attempts to allocate large buffers from that space.

This applies on top of the previous bitmap region cleanup work done by
Paul Jackson, who also did some cleanup to this patch.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 lib/bitmap.c |  108 ++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 75 insertions(+), 33 deletions(-)

963100ab9721a76326a5479685e03d76dec25cf0
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 3fab1ce..f49eabe 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -692,26 +692,44 @@ EXPORT_SYMBOL(bitmap_bitremap);
  */
 int bitmap_find_free_region(unsigned long *bitmap, int bits, int order)
 {
-	unsigned long mask;
-	int nbits = 1 << order;
-	int i;
-
-	if (nbits > BITS_PER_LONG)
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
+	if (nbitsinlong > BITS_PER_LONG)
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
-		if ((bitmap[index] & (mask << offset)) == 0) {
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
@@ -728,13 +746,28 @@ EXPORT_SYMBOL(bitmap_find_free_region);
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
 
@@ -750,22 +783,31 @@ EXPORT_SYMBOL(bitmap_release_region);
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
