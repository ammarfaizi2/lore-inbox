Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285841AbRLHGKS>; Sat, 8 Dec 2001 01:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285843AbRLHGKI>; Sat, 8 Dec 2001 01:10:08 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:25230 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S285841AbRLHGJ7>; Sat, 8 Dec 2001 01:09:59 -0500
Date: Fri, 7 Dec 2001 22:08:08 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, pat@it.com.au, tfries@umr.edu,
        ankry@mif.pg.gda.pl
Cc: torvalds@transmeta.com
Subject: Patch?: linux-2.5.1-pre7/drivers/block/xd.c compilation fixes
Message-ID: <20011207220808.A6037@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	I do not know the whole new block IO interface, but here
is my attempt at making linux-2.4.17-pre7/drivers/block/xd.c compile.
If I got any of this wrong, I would appreciate someone telling me,
because I may start tring to fix some of the other 90+ drivers that
do not compile in 2.4.1-pre7 later this weekend.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="xd.patch"

--- linux-2.5.1-pre7/drivers/block/xd.c	Fri Dec  7 19:37:41 2001
+++ linux/drivers/block/xd.c	Fri Dec  7 21:11:11 2001
@@ -121,7 +121,6 @@
 static struct hd_struct xd_struct[XD_MAXDRIVES << 6];
 static int xd_sizes[XD_MAXDRIVES << 6], xd_access[XD_MAXDRIVES];
 static int xd_blocksizes[XD_MAXDRIVES << 6];
-static int xd_maxsect[XD_MAXDRIVES << 6];
 
 extern struct block_device_operations xd_fops;
 
@@ -246,8 +245,7 @@
 	}
 
 	/* xd_maxsectors depends on controller - so set after detection */
-	for(i=0; i<(XD_MAXDRIVES << 6); i++) xd_maxsect[i] = xd_maxsectors;
-	max_sectors[MAJOR_NR] = xd_maxsect;
+	blk_queue_max_sectors(BLK_DEFAULT_QUEUE(MAJOR_NR), xd_maxsectors);
 
 	for (i = 0; i < xd_drives; i++) {
 		xd_valid[i] = 1;
@@ -294,11 +292,11 @@
 			block = CURRENT->sector;
 			count = CURRENT->nr_sectors;
 
-			switch (CURRENT->cmd) {
+			switch (rq_data_dir(CURRENT)) {
 				case READ:
 				case WRITE:
 					for (retry = 0; (retry < XD_RETRIES) && !code; retry++)
-						code = xd_readwrite(CURRENT->cmd,CURRENT_DEV,CURRENT->buffer,block,count);
+						code = xd_readwrite(rq_data_dir(CURRENT),CURRENT_DEV,CURRENT->buffer,block,count);
 					break;
 				default:
 					printk("do_xd_request: unknown request\n");

--sm4nu43k4a2Rpi4c--
