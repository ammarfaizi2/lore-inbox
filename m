Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268330AbUIGPxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268330AbUIGPxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268184AbUIGPv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:51:57 -0400
Received: from mail.math.TU-Berlin.DE ([130.149.12.212]:22761 "EHLO
	mail.math.TU-Berlin.DE") by vger.kernel.org with ESMTP
	id S268446AbUIGPrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:47:55 -0400
From: Thomas Richter <thor@math.TU-Berlin.DE>
Message-Id: <200409071547.RAA03166@cleopatra.math.tu-berlin.de>
Subject: [PATCH] Amiga partition fix
To: linux-kernel@vger.kernel.org
Date: Tue, 7 Sep 2004 17:47:53 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

what happened to Joanne Dow's patch to fix the recognition of
Amiga RDSK blocks? In case that got lost, here's the patch again:

/* snip */

--- amiga.c	2004-08-09 08:52:07.268123677 -0700
+++ amiga.c.orig	2004-08-09 08:51:31.527104456 -0700
@@ -31,7 +31,6 @@ amiga_partition(struct parsed_partitions
 	struct RigidDiskBlock *rdb;
 	struct PartitionBlock *pb;
 	int start_sect, nr_sects, blk, part, res = 0;
-	int blksize = 1;	/* Multiplier for disk block size */
 	int slot = 1;
 	char b[BDEVNAME_SIZE];
 
@@ -66,14 +65,10 @@ amiga_partition(struct parsed_partitions
 			       bdevname(bdev, b), blk);
 	}
 
-        /* blksize is blocks per 512 byte standard block */
-        blksize = be32_to_cpu( rdb->rdb_BlockBytes ) / 512;
-
-	printk(" RDSK (%d)", blksize * 512);	/* Be more informative */
+	printk(" RDSK");
 	blk = be32_to_cpu(rdb->rdb_PartitionList);
 	put_dev_sector(sect);
 	for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
-		blk *= blksize;	/* Read in terms partition table understands */
 		data = read_dev_sector(bdev, blk, &sect);
 		if (!data) {
 			if (warn_no_part)
@@ -93,32 +88,13 @@ amiga_partition(struct parsed_partitions
 		nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
 			    be32_to_cpu(pb->pb_Environment[9])) *
 			   be32_to_cpu(pb->pb_Environment[3]) *
-			   be32_to_cpu(pb->pb_Environment[5]) *
-			   blksize;
+			   be32_to_cpu(pb->pb_Environment[5]);
 		if (!nr_sects)
 			continue;
 		start_sect = be32_to_cpu(pb->pb_Environment[9]) *
 			     be32_to_cpu(pb->pb_Environment[3]) *
-			     be32_to_cpu(pb->pb_Environment[5]) *
-			     blksize;
+			     be32_to_cpu(pb->pb_Environment[5]);
 		put_partition(state,slot++,start_sect,nr_sects);
-		{
-			/* Be even more informative to aid mounting */
-			char dostype[ 4 ];
-			u32 *dt = (u32*) dostype;
-			*dt = pb->pb_Environment[ 16 ];
-			if ( dostype[ 3 ] < ' ')
-				printk( " (%c%c%c^%c)",
-					dostype[ 0 ], dostype[ 1 ],
-					dostype[ 2 ], dostype[ 3 ] + '@' );
-			else
-				printk( " (%c%c%c%c)",
-					dostype[ 0 ], dostype[ 1 ],
-					dostype[ 2 ], dostype[ 3 ]);
-			printk( "(res %d spb %d)",
-				be32_to_cpu( pb->pb_Environment[ 6 ]),
-				be32_to_cpu( pb->pb_Environment[ 4 ]));
-		}
 		res = 1;
 	}
 	printk("\n");

/* snip */

So long,
	Thomas

