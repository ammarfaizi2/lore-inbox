Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288553AbSADIr6>; Fri, 4 Jan 2002 03:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288555AbSADIrj>; Fri, 4 Jan 2002 03:47:39 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:30913 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S288553AbSADIrU>; Fri, 4 Jan 2002 03:47:20 -0500
Date: Fri, 4 Jan 2002 00:47:19 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: linux-2.5.2-pre7/drivers/block/xd.c kdev_t fix
Message-ID: <20020104004719.A13489@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch fixes some kdev_t compilation problems
in linux-2.5.2-pre7/drivers/block/xd.c.

	I have not gotten pre7 to build, so this is untested.  On
the other hand, as Linus mentioned the last time I posted a patch
to this file, there may not be any Linux users running XT
hard disks.  So, whether this patch works or not may not matter. :-)

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="xd.diff"

--- linux-2.5.2-pre7/drivers/block/xd.c	Thu Jan  3 19:52:01 2002
+++ linux/drivers/block/xd.c	Fri Jan  4 00:39:48 2002
@@ -249,7 +249,8 @@
 
 	for (i = 0; i < xd_drives; i++) {
 		xd_valid[i] = 1;
-		register_disk(&xd_gendisk, MKDEV(MAJOR_NR,i<<6), 1<<6, &xd_fops,
+		register_disk(&xd_gendisk, mk_kdev(MAJOR_NR,i<<6), 1<<6,
+				&xd_fops,
 				xd_info[i].heads * xd_info[i].cylinders *
 				xd_info[i].sectors);
 	}
@@ -287,8 +288,9 @@
 		INIT_REQUEST;	/* do some checking on the request structure */
 
 		if (CURRENT_DEV < xd_drives
+		    && (CURRENT->flags & REQ_CMD)
 		    && CURRENT->sector + CURRENT->nr_sectors
-		         <= xd_struct[MINOR(CURRENT->rq_dev)].nr_sects) {
+		         <= xd_struct[minor(CURRENT->rq_dev)].nr_sects) {
 			block = CURRENT->sector;
 			count = CURRENT->nr_sectors;
 
@@ -312,7 +314,7 @@
 {
 	int dev;
 
-	if ((!inode) || !(inode->i_rdev))
+	if ((!inode) || kdev_none(inode->i_rdev))
 		return -EINVAL;
  	dev = DEVICE_NR(inode->i_rdev);
 

--pWyiEgJYm5f9v55/--
