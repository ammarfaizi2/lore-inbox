Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288566AbSADJVL>; Fri, 4 Jan 2002 04:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288561AbSADJUw>; Fri, 4 Jan 2002 04:20:52 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:29128 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S288562AbSADJUl>; Fri, 4 Jan 2002 04:20:41 -0500
Date: Fri, 4 Jan 2002 01:20:39 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: tim@cyberelk.net, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: PATCH: linux-2.5.2-pre7/drivers/block/paride/ kdev_t compilation fixes
Message-ID: <20020104012039.A15742@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch updates some files in
linux-2.5.2-pre7/drivers/block/paride/ so that they compile with
the new kdev_t scheme.  I have not actually tested the changes
in any way.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="paride.diffs"

Only in linux/drivers/block/paride: CVS
diff -u linux-2.5.2-pre7/drivers/block/paride/pcd.c linux/drivers/block/paride/pcd.c
--- linux-2.5.2-pre7/drivers/block/paride/pcd.c	Wed Dec 12 13:51:57 2001
+++ linux/drivers/block/paride/pcd.c	Fri Jan  4 01:17:14 2002
@@ -182,7 +182,7 @@
 #define MAJOR_NR	major
 #define DEVICE_NAME "PCD"
 #define DEVICE_REQUEST do_pcd_request
-#define DEVICE_NR(device) (MINOR(device))
+#define DEVICE_NR(device) (minor(device))
 #define DEVICE_ON(device)
 #define DEVICE_OFF(device)
 
@@ -325,7 +325,7 @@
 
 		PCD.info.ops = &pcd_dops;
 		PCD.info.handle = NULL;
-		PCD.info.dev = MKDEV(major,unit);
+		PCD.info.dev = mk_kdev(major,unit);
 		PCD.info.speed = 0;
 		PCD.info.capacity = 1;
 		PCD.info.mask = 0;
@@ -771,7 +771,7 @@
 	    if (QUEUE_EMPTY || (CURRENT->rq_status == RQ_INACTIVE)) return;
 	    INIT_REQUEST;
 	    if (rq_data_dir(CURRENT) == READ) {
-		unit = MINOR(CURRENT->rq_dev);
+		unit = minor(CURRENT->rq_dev);
 		if (unit != pcd_unit) {
 			pcd_bufblk = -1;
 			pcd_unit = unit;
diff -u linux-2.5.2-pre7/drivers/block/paride/pd.c linux/drivers/block/paride/pd.c
--- linux-2.5.2-pre7/drivers/block/paride/pd.c	Thu Jan  3 19:52:01 2002
+++ linux/drivers/block/paride/pd.c	Fri Jan  4 01:17:14 2002
@@ -206,7 +206,7 @@
 #define MAJOR_NR   major
 #define DEVICE_NAME "PD"
 #define DEVICE_REQUEST do_pd_request
-#define DEVICE_NR(device) (MINOR(device)>>PD_BITS)
+#define DEVICE_NR(device) (minor(device)>>PD_BITS)
 #define DEVICE_ON(device)
 #define DEVICE_OFF(device)
 
@@ -445,7 +445,7 @@
 	struct hd_geometry *geo = (struct hd_geometry *) arg;
 	int err, unit;
 
-	if (!inode || !inode->i_rdev)
+	if (!inode || kdev_none(inode->i_rdev))
 		return -EINVAL;
 	unit = DEVICE_NR(inode->i_rdev);
 	if (!PD.present)
@@ -814,7 +814,7 @@
                 } else pi_release(PI);
             }
 	for (unit=0;unit<PD_UNITS;unit++)
-		register_disk(&pd_gendisk,MKDEV(MAJOR_NR,unit<<PD_BITS),
+		register_disk(&pd_gendisk,mk_kdev(MAJOR_NR,unit<<PD_BITS),
 				PD_PARTNS,&pd_fops,
 				PD.present?PD.capacity:0);
 
@@ -847,7 +847,7 @@
         if (QUEUE_EMPTY || (CURRENT->rq_status == RQ_INACTIVE)) return;
         INIT_REQUEST;
 
-        pd_dev = MINOR(CURRENT->rq_dev);
+        pd_dev = minor(CURRENT->rq_dev);
 	pd_unit = unit = DEVICE_NR(CURRENT->rq_dev);
         pd_block = CURRENT->sector;
         pd_run = CURRENT->nr_sectors;
@@ -886,7 +886,7 @@
 
 	if (QUEUE_EMPTY ||
 	    (rq_data_dir(CURRENT) != pd_cmd) ||
-	    (MINOR(CURRENT->rq_dev) != pd_dev) ||
+	    (minor(CURRENT->rq_dev) != pd_dev) ||
 	    (CURRENT->rq_status == RQ_INACTIVE) ||
 	    (CURRENT->sector != pd_block)) 
 		printk("%s: OUCH: request list changed unexpectedly\n",
diff -u linux-2.5.2-pre7/drivers/block/paride/pf.c linux/drivers/block/paride/pf.c
--- linux-2.5.2-pre7/drivers/block/paride/pf.c	Sun Dec 16 12:20:20 2001
+++ linux/drivers/block/paride/pf.c	Fri Jan  4 01:17:14 2002
@@ -202,7 +202,7 @@
 #define MAJOR_NR   major
 #define DEVICE_NAME "PF"
 #define DEVICE_REQUEST do_pf_request
-#define DEVICE_NR(device) MINOR(device)
+#define DEVICE_NR(device) minor(device)
 #define DEVICE_ON(device)
 #define DEVICE_OFF(device)
 
@@ -368,7 +368,7 @@
 	for (i=0;i<PF_UNITS;i++) pf_blocksizes[i] = 1024;
 	blksize_size[MAJOR_NR] = pf_blocksizes;
 	for (i=0;i<PF_UNITS;i++)
-		register_disk(NULL, MKDEV(MAJOR_NR, i), 1, &pf_fops, 0);
+		register_disk(NULL, mk_kdev(MAJOR_NR, i), 1, &pf_fops, 0);
 
         return 0;
 }
@@ -399,7 +399,7 @@
 {       int err, unit;
 	struct hd_geometry *geo = (struct hd_geometry *) arg;
 
-        if ((!inode) || (!inode->i_rdev)) return -EINVAL;
+        if ((!inode) || kdev_none(inode->i_rdev)) return -EINVAL;
         unit = DEVICE_NR(inode->i_rdev);
         if (unit >= PF_UNITS) return -EINVAL;
         if (!PF.present) return -ENODEV;
diff -u linux-2.5.2-pre7/drivers/block/paride/pg.c linux/drivers/block/paride/pg.c
--- linux-2.5.2-pre7/drivers/block/paride/pg.c	Fri Nov 30 08:26:04 2001
+++ linux/drivers/block/paride/pg.c	Fri Jan  4 01:17:14 2002
@@ -565,7 +565,7 @@
 	return -1;
 }
 
-#define DEVICE_NR(dev)	(MINOR(dev) % 128)
+#define DEVICE_NR(dev)	(minor(dev) & 0x7F)
 
 static int pg_open (struct inode *inode, struct file *file)
 
diff -u linux-2.5.2-pre7/drivers/block/paride/pt.c linux/drivers/block/paride/pt.c
--- linux-2.5.2-pre7/drivers/block/paride/pt.c	Fri Nov 30 08:26:04 2001
+++ linux/drivers/block/paride/pt.c	Fri Jan  4 01:17:14 2002
@@ -688,7 +688,7 @@
 	return -1;
 }
 
-#define DEVICE_NR(dev)	(MINOR(dev) % 128)
+#define DEVICE_NR(dev)	(minor(dev) & 0x7F)
 
 static int pt_open (struct inode *inode, struct file *file)
 
@@ -713,7 +713,7 @@
 		return -EROFS;
 		}
 
-	if (!(MINOR(inode->i_rdev) & 128))
+	if (!(minor(inode->i_rdev) & 128))
 		PT.flags |= PT_REWIND;
 
 	PT.bufptr = kmalloc(PT_BUFSIZE,GFP_KERNEL);
@@ -732,7 +732,7 @@
 	int unit;
 	struct mtop mtop;
 
-        if (!inode || !inode->i_rdev)
+        if (!inode || kdev_none(inode->i_rdev))
 		return -EINVAL;
         unit = DEVICE_NR(inode->i_rdev);
         if (unit >= PT_UNITS)

--lrZ03NoBR/3+SXJZ--
