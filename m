Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282983AbRLIEnJ>; Sat, 8 Dec 2001 23:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282979AbRLIEnA>; Sat, 8 Dec 2001 23:43:00 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:17883 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S282976AbRLIEmm>; Sat, 8 Dec 2001 23:42:42 -0500
Date: Sat, 8 Dec 2001 20:42:25 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, axboe@suse.de, pat@it.com.au, tfries@umr.edu,
        ankry@mif.pg.gda.pl, torvalds@transmeta.com
Subject: PATCH: linux-2.5.1-pre7/drivers/block/xd.c compilation fix (version 2)
Message-ID: <20011208204225.A7213@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Per the advice of Jens Axboe, I have added one line to my
previous fix to make linux-2.5.1-pre7/drivers/block/xd.c compile
(the "&& (CURRENT->flags & REQ_CMD)" line).  Here is the diff
against pristine linux-2.5.1-pre7/drivers/block/xd.c.

	There is no maintainer for xd.c listed in linux/MAINTAINERS,
although I am and have been mailing to the email addresses that appear
in xd.c.

	Linus, if nobody says otherwise, I recommend that you apply
this patch.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="xd.patch"

--- linux-2.5.1-pre7/drivers/block/xd.c	Fri Dec  7 19:37:41 2001
+++ linux/drivers/block/xd.c	Sat Dec  8 20:28:14 2001
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
@@ -289,16 +287,17 @@
 		INIT_REQUEST;	/* do some checking on the request structure */
 
 		if (CURRENT_DEV < xd_drives
+		    && (CURRENT->flags & REQ_CMD)
 		    && CURRENT->sector + CURRENT->nr_sectors
 		         <= xd_struct[MINOR(CURRENT->rq_dev)].nr_sects) {
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

--XsQoSWH+UP9D9v3l--
