Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316571AbSFFAEh>; Wed, 5 Jun 2002 20:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316572AbSFFAEg>; Wed, 5 Jun 2002 20:04:36 -0400
Received: from h-64-105-34-84.SNVACAID.covad.net ([64.105.34.84]:2753 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316571AbSFFAEf>; Wed, 5 Jun 2002 20:04:35 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 5 Jun 2002 17:04:28 -0700
Message-Id: <200206060004.RAA00496@baldur.yggdrasil.com>
To: akpm@zip.com.au, axboe@suse.de
Subject: Re: Patch: linux-2.5.20/fs/bio.c - ll_rw_kio made incorrect assumptions about queue handler's capabilities
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arg!  I forgot to attach the patch.  Here it is.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux-2.5.20/fs/bio.c	2002-06-02 18:44:40.000000000 -0700
+++ linux/fs/bio.c	2002-06-05 15:46:16.000000000 -0700
@@ -338,10 +338,12 @@
  **/
 void ll_rw_kio(int rw, struct kiobuf *kio, struct block_device *bdev, sector_t sector)
 {
-	int i, offset, size, err, map_i, total_nr_pages, nr_pages;
+	int offset, size, err, map_i, total_nr_pages, nr_pages;
 	struct bio_vec *bvec;
 	struct bio *bio;
 	kdev_t dev = to_kdev_t(bdev->bd_dev);
+	request_queue_t *q = bdev->bd_queue;
+	int max_bytes, max_pages;
 
 	err = 0;
 	if ((rw & WRITE) && is_read_only(dev)) {
@@ -355,6 +357,7 @@
 		goto out;
 	}
 
+	max_bytes = q->max_sectors << 9;
 	/*
 	 * maybe kio is bigger than the max we can easily map into a bio.
 	 * if so, split it up in appropriately sized chunks.
@@ -367,8 +370,14 @@
 
 	map_i = 0;
 
+	max_pages = (max_bytes + PAGE_MASK) >> PAGE_SHIFT;
+	if (max_pages > q->max_phys_segments)
+		max_pages = q->max_phys_segments;
+	if (max_pages > q->max_hw_segments)
+		max_pages = q->max_hw_segments;
+
 next_chunk:
-	nr_pages = BIO_MAX_SECTORS >> (PAGE_SHIFT - 9);
+	nr_pages = max_pages;
 	if (nr_pages > total_nr_pages)
 		nr_pages = total_nr_pages;
 
@@ -389,15 +398,17 @@
 	bio->bi_private = kio;
 
 	bvec = bio->bi_io_vec;
-	for (i = 0; i < nr_pages; i++, bvec++, map_i++) {
+	for (;total_nr_pages > 0; bvec++) {
 		int nbytes = PAGE_SIZE - offset;
 
 		if (nbytes > size)
 			nbytes = size;
+		if (nbytes > max_bytes)
+			nbytes = max_bytes;
 
 		BUG_ON(kio->maplist[map_i] == NULL);
 
-		if (bio->bi_size + nbytes > (BIO_MAX_SECTORS << 9))
+		if (bio->bi_size + nbytes > max_bytes)
 			goto queue_io;
 
 		bio->bi_vcnt++;
@@ -407,14 +418,14 @@
 		bvec->bv_len = nbytes;
 		bvec->bv_offset = offset;
 
-		/*
-		 * kiobuf only has an offset into the first page
-		 */
-		offset = 0;
+		offset = (offset + nbytes) & PAGE_MASK;
+		if (offset == 0) {
+			total_nr_pages--;
+			map_i++;
+		}
 
 		sector += nbytes >> 9;
 		size -= nbytes;
-		total_nr_pages--;
 		kio->offset += nbytes;
 	}
 
