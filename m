Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUGQXHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUGQXHZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 19:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUGQXFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 19:05:34 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:54460 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S262730AbUGQXCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 19:02:10 -0400
Date: Sun, 18 Jul 2004 01:02:04 +0200
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] partitions and unusual block sizes
Message-ID: <20040717230204.GW27770@os.inf.tu-dresden.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been working on a block driver with a block size != 512 bytes, by
using blk_queue_hardsect_size(q, 1024). The msdos partitioning code
modifies the sectors according to the block size of the underlying
device. As all blocks are 512 bytes internally, modifying the
partitioning data looks wrong. The following patch fixes this for me.


Signed-off-by: Adam Lackorzynski <adam@os.inf.tu-dresden.de>

diff -urN linux-2.6.8-rc1/fs/partitions/msdos.c linux-2.6.8-rc1.m/fs/partitions/msdos.c
--- linux-2.6.8-rc1/fs/partitions/msdos.c	2004-07-18 00:24:17.000000000 +0200
+++ linux-2.6.8-rc1.m/fs/partitions/msdos.c	2004-07-18 00:29:37.000000000 +0200
@@ -78,7 +78,6 @@
 	Sector sect;
 	unsigned char *data;
 	u32 this_sector, this_size;
-	int sector_size = bdev_hardsect_size(bdev) / 512;
 	int loopct = 0;		/* number of links followed
 				   without finding a data partition */
 	int i;
@@ -119,8 +118,8 @@
 
 			/* Check the 3rd and 4th entries -
 			   these sometimes contain random garbage */
-			offs = START_SECT(p)*sector_size;
-			size = NR_SECTS(p)*sector_size;
+			offs = START_SECT(p);
+			size = NR_SECTS(p);
 			next = this_sector + offs;
 			if (i >= 2) {
 				if (offs + size > this_size)
@@ -152,8 +151,8 @@
 		if (i == 4)
 			goto done;	 /* nothing left to do */
 
-		this_sector = first_sector + START_SECT(p) * sector_size;
-		this_size = NR_SECTS(p) * sector_size;
+		this_sector = first_sector + START_SECT(p);
+		this_size = NR_SECTS(p);
 		put_dev_sector(sect);
 	}
 done:
@@ -376,7 +375,6 @@
  
 int msdos_partition(struct parsed_partitions *state, struct block_device *bdev)
 {
-	int sector_size = bdev_hardsect_size(bdev) / 512;
 	Sector sect;
 	unsigned char *data;
 	struct partition *p;
@@ -424,8 +422,8 @@
 
 	state->next = 5;
 	for (slot = 1 ; slot <= 4 ; slot++, p++) {
-		u32 start = START_SECT(p)*sector_size;
-		u32 size = NR_SECTS(p)*sector_size;
+		u32 start = START_SECT(p);
+		u32 size = NR_SECTS(p);
 		if (!size)
 			continue;
 		if (is_extended_partition(p)) {
@@ -462,8 +460,8 @@
 
 		if (!subtypes[n].parse)
 			continue;
-		subtypes[n].parse(state, bdev, START_SECT(p)*sector_size,
-						NR_SECTS(p)*sector_size, slot);
+		subtypes[n].parse(state, bdev,
+		                  START_SECT(p), NR_SECTS(p), slot);
 	}
 	put_dev_sector(sect);
 	return 1;




Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://os.inf.tu-dresden.de/~adam/
