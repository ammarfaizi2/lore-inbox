Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbWFUTey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWFUTey (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbWFUTey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:34:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15268 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932690AbWFUTew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:34:52 -0400
Date: Wed, 21 Jun 2006 20:34:41 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Kevin Corry <kevcorry@us.ibm.com>
Subject: [PATCH 05/15] dm mirror log: sector size fix
Message-ID: <20060621193441.GT4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Kevin Corry <kevcorry@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Corry <kevcorry@us.ibm.com>

On-disk logs for dm-mirror devices are currently hard-coded to use 512 byte
hard-sector-sizes. This patch fixes dm-log so it will work with devices
with non-512-byte hard-sector-sizes.

To maintain full compatibility, instead of moving the clean-bits bitset to a
different location, this patch removes the separate buffer used for the
bitset, and enlarges the disk-header buffer to encompass both the header and
the bitset. The I/O routines for the bitset are removed, and the I/O routines
for the disk-header now also read/write the bitset.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/drivers/md/dm-log.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-log.c	2006-06-21 16:19:38.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-log.c	2006-06-21 17:17:49.000000000 +0100
@@ -155,8 +155,6 @@ struct log_c {
 
 	struct io_region header_location;
 	struct log_header *disk_header;
-
-	struct io_region bits_location;
 };
 
 /*
@@ -241,29 +239,6 @@ static inline int write_header(struct lo
 }
 
 /*----------------------------------------------------------------
- * Bits IO
- *--------------------------------------------------------------*/
-static int read_bits(struct log_c *log)
-{
-	int r;
-	unsigned long ebits;
-
-	r = dm_io_sync_vm(1, &log->bits_location, READ,
-			  log->clean_bits, &ebits);
-	if (r)
-		return r;
-
-	return 0;
-}
-
-static int write_bits(struct log_c *log)
-{
-	unsigned long ebits;
-	return dm_io_sync_vm(1, &log->bits_location, WRITE,
-			     log->clean_bits, &ebits);
-}
-
-/*----------------------------------------------------------------
  * core log constructor/destructor
  *
  * argv contains region_size followed optionally by [no]sync
@@ -373,9 +348,10 @@ static int disk_ctr(struct dirty_log *lo
 		    unsigned int argc, char **argv)
 {
 	int r;
-	size_t size;
+	size_t size, bitset_size;
 	struct log_c *lc;
 	struct dm_dev *dev;
+	uint32_t *clean_bits;
 
 	if (argc < 2 || argc > 3) {
 		DMWARN("wrong number of arguments to disk mirror log");
@@ -399,23 +375,26 @@ static int disk_ctr(struct dirty_log *lo
 	/* setup the disk header fields */
 	lc->header_location.bdev = lc->log_dev->bdev;
 	lc->header_location.sector = 0;
-	lc->header_location.count = 1;
 
-	/*
-	 * We can't read less than this amount, even though we'll
-	 * not be using most of this space.
-	 */
-	lc->disk_header = vmalloc(1 << SECTOR_SHIFT);
+	/* Include both the header and the bitset in one buffer. */
+	bitset_size = lc->bitset_uint32_count * sizeof(uint32_t);
+	size = dm_round_up((LOG_OFFSET << SECTOR_SHIFT) + bitset_size,
+			   ti->limits.hardsect_size);
+	lc->header_location.count = size >> SECTOR_SHIFT;
+
+	lc->disk_header = vmalloc(size);
 	if (!lc->disk_header)
 		goto bad;
 
-	/* setup the disk bitset fields */
-	lc->bits_location.bdev = lc->log_dev->bdev;
-	lc->bits_location.sector = LOG_OFFSET;
-
-	size = dm_round_up(lc->bitset_uint32_count * sizeof(uint32_t),
-			   1 << SECTOR_SHIFT);
-	lc->bits_location.count = size >> SECTOR_SHIFT;
+	/*
+	 * Deallocate the clean_bits buffer that was allocated in core_ctr()
+	 * and point it at the appropriate place in the disk_header buffer.
+	 */
+	clean_bits = lc->clean_bits;
+	lc->clean_bits = (void *)lc->disk_header + (LOG_OFFSET << SECTOR_SHIFT);
+	memcpy(lc->clean_bits, clean_bits, bitset_size);
+	vfree(clean_bits);
+
 	return 0;
 
  bad:
@@ -429,6 +408,7 @@ static void disk_dtr(struct dirty_log *l
 	struct log_c *lc = (struct log_c *) log->context;
 	dm_put_device(lc->ti, lc->log_dev);
 	vfree(lc->disk_header);
+	lc->clean_bits = NULL;
 	core_dtr(log);
 }
 
@@ -454,11 +434,6 @@ static int disk_resume(struct dirty_log 
 	if (r)
 		return r;
 
-	/* read the bits */
-	r = read_bits(lc);
-	if (r)
-		return r;
-
 	/* set or clear any new bits */
 	if (lc->sync == NOSYNC)
 		for (i = lc->header.nr_regions; i < lc->region_count; i++)
@@ -473,11 +448,6 @@ static int disk_resume(struct dirty_log 
 	memcpy(lc->sync_bits, lc->clean_bits, size);
 	lc->sync_count = count_bits32(lc->clean_bits, lc->bitset_uint32_count);
 
-	/* write the bits */
-	r = write_bits(lc);
-	if (r)
-		return r;
-
 	/* set the correct number of regions in the header */
 	lc->header.nr_regions = lc->region_count;
 
@@ -518,7 +488,7 @@ static int disk_flush(struct dirty_log *
 	if (!lc->touched)
 		return 0;
 
-	r = write_bits(lc);
+	r = write_header(lc);
 	if (!r)
 		lc->touched = 0;
 
Index: linux-2.6.17/drivers/md/dm-raid1.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-raid1.c	2006-06-21 16:19:38.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-raid1.c	2006-06-21 17:17:49.000000000 +0100
@@ -1222,7 +1222,7 @@ static int mirror_status(struct dm_targe
 
 static struct target_type mirror_target = {
 	.name	 = "mirror",
-	.version = {1, 0, 1},
+	.version = {1, 0, 2},
 	.module	 = THIS_MODULE,
 	.ctr	 = mirror_ctr,
 	.dtr	 = mirror_dtr,
