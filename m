Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315300AbSFEKog>; Wed, 5 Jun 2002 06:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSFEKog>; Wed, 5 Jun 2002 06:44:36 -0400
Received: from h-64-105-34-84.SNVACAID.covad.net ([64.105.34.84]:16335 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315300AbSFEKoe>; Wed, 5 Jun 2002 06:44:34 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 5 Jun 2002 03:44:28 -0700
Message-Id: <200206051044.DAA02529@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch??: linux-2.5.20/fs/bio.c - ll_rw_kio could generate bio's bigger than queue could handle
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I may very well be misunderstanding something, but it looks
to like ll_rw_kio can generate bio's that have more segments or
more sectors than their queues declare that they can handle.

	As an extreme example, I could write a driver for a
block device that has max_hw_segments == 1, max_phys_segments == 1,
max_sectors == 1.  Right?

	The intermediate bio merging code in drivers/block/ll_rw_blk.c
obeys these constraints when it comes to merging requests that
also are all within these constraints already, but it does break
up bio's that are to big for the underlying queue.  As far as I
can tell, it seems to be the responsibility of anything that
calls submit_bio or generic_make_request to ensure that the
bio that is submitted is within the request_queue_t's limits
if the driver that pulls requests off of the queue is going to
be able to use max_hw_segments, max_phys_segments and max_sectors
as guarantees.  Right?

	If I got both of those statements correct, I would
appreciate comments on the following untested patch (I have
to go to sleep now, and I think it's more likely that I just
misunderstanding something).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--- linux-2.5.20/fs/bio.c	2002-06-02 18:44:40.000000000 -0700
+++ linux/fs/bio.c	2002-06-05 03:27:19.000000000 -0700
@@ -339,12 +339,14 @@
 void ll_rw_kio(int rw, struct kiobuf *kio, struct block_device *bdev, sector_t sector)
 {
 	int i, offset, size, err, map_i, total_nr_pages, nr_pages;
 	struct bio_vec *bvec;
 	struct bio *bio;
 	kdev_t dev = to_kdev_t(bdev->bd_dev);
+	request_queue_t *q = bdev->bd_queue;
+	int max_pages;
 
 	err = 0;
 	if ((rw & WRITE) && is_read_only(dev)) {
 		printk("ll_rw_bio: WRITE to ro device %s\n", kdevname(dev));
 		err = -EPERM;
 		goto out;
@@ -364,14 +366,20 @@
 	size = kio->length;
 
 	atomic_set(&kio->io_count, 1);
 
 	map_i = 0;
 
+	max_pages = q->max_sectors >> (PAGE_SHIFT - 9);
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
 
 	atomic_inc(&kio->io_count);
 
 	/*
