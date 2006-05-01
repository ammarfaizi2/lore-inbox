Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWEAFbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWEAFbJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 01:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWEAFbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 01:31:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:39344 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750953AbWEAFa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 01:30:59 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 1 May 2006 15:30:54 +1000
Message-Id: <1060501053054.23009@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 009 of 11] md: Support stripe/offset mode in raid10
References: <20060501152229.18367.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The "industry standard" DDF format allows for a stripe/offset layout
where data is duplicated on different stripes. e.g.

  A  B  C  D
  D  A  B  C
  E  F  G  H
  H  E  F  G

(columns are drives, rows are stripes, LETTERS are chunks of data).

This is similar to raid10's 'far' mode, but not quite the same.  So
enhance 'far' mode with a 'far/offset' option which follows the layout
of DDFs stripe/offset.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid10.c         |   64 ++++++++++++++++++++++++++++--------------
 ./include/linux/raid/raid10.h |    7 +++-
 2 files changed, 49 insertions(+), 22 deletions(-)

diff ./drivers/md/raid10.c~current~ ./drivers/md/raid10.c
--- ./drivers/md/raid10.c~current~	2006-05-01 15:12:34.000000000 +1000
+++ ./drivers/md/raid10.c	2006-05-01 15:13:22.000000000 +1000
@@ -29,6 +29,7 @@
  *    raid_disks
  *    near_copies (stored in low byte of layout)
  *    far_copies (stored in second byte of layout)
+ *    far_offset (stored in bit 16 of layout )
  *
  * The data to be stored is divided into chunks using chunksize.
  * Each device is divided into far_copies sections.
@@ -36,10 +37,14 @@
  * near_copies copies of each chunk is stored (each on a different drive).
  * The starting device for each section is offset near_copies from the starting
  * device of the previous section.
- * Thus there are (near_copies*far_copies) of each chunk, and each is on a different
+ * Thus they are (near_copies*far_copies) of each chunk, and each is on a different
  * drive.
  * near_copies and far_copies must be at least one, and their product is at most
  * raid_disks.
+ *
+ * If far_offset is true, then the far_copies are handled a bit differently.
+ * The copies are still in different stripes, but instead of be very far apart
+ * on disk, there are adjacent stripes.
  */
 
 /*
@@ -357,8 +362,7 @@ static int raid10_end_write_request(stru
  * With this layout, and block is never stored twice on the one device.
  *
  * raid10_find_phys finds the sector offset of a given virtual sector
- * on each device that it is on. If a block isn't on a device,
- * that entry in the array is set to MaxSector.
+ * on each device that it is on.
  *
  * raid10_find_virt does the reverse mapping, from a device and a
  * sector offset to a virtual address
@@ -381,6 +385,8 @@ static void raid10_find_phys(conf_t *con
 	chunk *= conf->near_copies;
 	stripe = chunk;
 	dev = sector_div(stripe, conf->raid_disks);
+	if (conf->far_offset)
+		stripe *= conf->far_copies;
 
 	sector += stripe << conf->chunk_shift;
 
@@ -414,16 +420,24 @@ static sector_t raid10_find_virt(conf_t 
 {
 	sector_t offset, chunk, vchunk;
 
-	while (sector > conf->stride) {
-		sector -= conf->stride;
-		if (dev < conf->near_copies)
-			dev += conf->raid_disks - conf->near_copies;
-		else
-			dev -= conf->near_copies;
-	}
-
 	offset = sector & conf->chunk_mask;
-	chunk = sector >> conf->chunk_shift;
+	if (conf->far_offset) {
+		int fc;
+		chunk = sector >> conf->chunk_shift;
+		fc = sector_div(chunk, conf->far_copies);
+		dev -= fc * conf->near_copies;
+		if (dev < 0)
+			dev += conf->raid_disks;
+	} else {
+		while (sector > conf->stride) {
+			sector -= conf->stride;
+			if (dev < conf->near_copies)
+				dev += conf->raid_disks - conf->near_copies;
+			else
+				dev -= conf->near_copies;
+		}
+		chunk = sector >> conf->chunk_shift;
+	}
 	vchunk = chunk * conf->raid_disks + dev;
 	sector_div(vchunk, conf->near_copies);
 	return (vchunk << conf->chunk_shift) + offset;
@@ -900,9 +914,12 @@ static void status(struct seq_file *seq,
 		seq_printf(seq, " %dK chunks", mddev->chunk_size/1024);
 	if (conf->near_copies > 1)
 		seq_printf(seq, " %d near-copies", conf->near_copies);
-	if (conf->far_copies > 1)
-		seq_printf(seq, " %d far-copies", conf->far_copies);
-
+	if (conf->far_copies > 1) {
+		if (conf->far_offset)
+			seq_printf(seq, " %d offset-copies", conf->far_copies);
+		else
+			seq_printf(seq, " %d far-copies", conf->far_copies);
+	}
 	seq_printf(seq, " [%d/%d] [", conf->raid_disks,
 						conf->working_disks);
 	for (i = 0; i < conf->raid_disks; i++)
@@ -1915,7 +1932,7 @@ static int run(mddev_t *mddev)
 	mirror_info_t *disk;
 	mdk_rdev_t *rdev;
 	struct list_head *tmp;
-	int nc, fc;
+	int nc, fc, fo;
 	sector_t stride, size;
 
 	if (mddev->chunk_size == 0) {
@@ -1925,8 +1942,9 @@ static int run(mddev_t *mddev)
 
 	nc = mddev->layout & 255;
 	fc = (mddev->layout >> 8) & 255;
+	fo = mddev->layout & (1<<16);
 	if ((nc*fc) <2 || (nc*fc) > mddev->raid_disks ||
-	    (mddev->layout >> 16)) {
+	    (mddev->layout >> 17)) {
 		printk(KERN_ERR "raid10: %s: unsupported raid10 layout: 0x%8x\n",
 		       mdname(mddev), mddev->layout);
 		goto out;
@@ -1958,12 +1976,16 @@ static int run(mddev_t *mddev)
 	conf->near_copies = nc;
 	conf->far_copies = fc;
 	conf->copies = nc*fc;
+	conf->far_offset = fo;
 	conf->chunk_mask = (sector_t)(mddev->chunk_size>>9)-1;
 	conf->chunk_shift = ffz(~mddev->chunk_size) - 9;
-	stride = mddev->size >> (conf->chunk_shift-1);
-	sector_div(stride, fc);
-	conf->stride = stride << conf->chunk_shift;
-
+	if (fo)
+		conf->stride = 1 << conf->chunk_shift;
+	else {
+		stride = mddev->size >> (conf->chunk_shift-1);
+		sector_div(stride, fc);
+		conf->stride = stride << conf->chunk_shift;
+	}
 	conf->r10bio_pool = mempool_create(NR_RAID10_BIOS, r10bio_pool_alloc,
 						r10bio_pool_free, conf);
 	if (!conf->r10bio_pool) {

diff ./include/linux/raid/raid10.h~current~ ./include/linux/raid/raid10.h
--- ./include/linux/raid/raid10.h~current~	2006-05-01 15:09:20.000000000 +1000
+++ ./include/linux/raid/raid10.h	2006-05-01 15:13:22.000000000 +1000
@@ -24,11 +24,16 @@ struct r10_private_data_s {
 	int 			far_copies;   /* number of copies layed out
 					       * at large strides across drives
 					       */
+	int			far_offset;   /* far_copies are offset by 1 stripe
+					       * instead of many
+					       */
 	int			copies;	      /* near_copies * far_copies.
 					       * must be <= raid_disks
 					       */
 	sector_t		stride;	      /* distance between far copies.
-					       * This is size / far_copies
+					       * This is size / far_copies unless
+					       * far_offset, in which case it is
+					       * 1 stripe.
 					       */
 
 	int chunk_shift; /* shift from chunks to sectors */
