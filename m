Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWCGHXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWCGHXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 02:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWCGHXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 02:23:40 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:2565 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932434AbWCGHXj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 02:23:39 -0500
Date: Tue, 7 Mar 2006 08:23:21 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Horst Hummel <horst.hummel@de.ibm.com>
Subject: [patch 3/3] s390: dasd partition detection
Message-ID: <20060307072321.GC9329@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

DASD allows to open a device as soon as gendisk is registered, which means
the device is a fake device (capacity=0) and we do know nothing about
blocksize and partitions at that point of time.
In case the device is opened by someone, the bdev and inode creation is done
with the fake device info and the following partition detection code is just
using the wrong data.

To avoid this modify the DASD state machine to make sure that the open is
rejected until the device analysis is either finished or an unformatted
device was detected.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/block/dasd.c       |   38 +++++++++++++++++++++++++++++---------
 drivers/s390/block/dasd_genhd.c |    2 --
 drivers/s390/block/dasd_int.h   |    7 ++++---
 drivers/s390/block/dasd_proc.c  |    3 +++
 fs/partitions/ibm.c             |   16 ++++++++++------
 5 files changed, 46 insertions(+), 20 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-03-07 07:59:08.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-03-07 07:59:26.000000000 +0100
@@ -215,9 +215,10 @@ dasd_state_basic_to_known(struct dasd_de
  * interrupt for this detection ccw uses the kernel event daemon to
  * trigger the call to dasd_change_state. All this is done in the
  * discipline code, see dasd_eckd.c.
- * After the analysis ccw is done (do_analysis returned 0 or error)
- * the block device is setup. Either a fake disk is added to allow
- * formatting or a proper device request queue is created.
+ * After the analysis ccw is done (do_analysis returned 0) the block
+ * device is setup.
+ * In case the analysis returns an error, the device setup is stopped
+ * (a fake disk was already added to allow formatting).
  */
 static inline int
 dasd_state_basic_to_ready(struct dasd_device * device)
@@ -227,13 +228,19 @@ dasd_state_basic_to_ready(struct dasd_de
 	rc = 0;
 	if (device->discipline->do_analysis != NULL)
 		rc = device->discipline->do_analysis(device);
-	if (rc)
+	if (rc) {
+		if (rc != -EAGAIN)
+			device->state = DASD_STATE_UNFMT;
 		return rc;
+	}
+	/* make disk known with correct capacity */
 	dasd_setup_queue(device);
+	set_capacity(device->gdp, device->blocks << device->s2b_shift);
 	device->state = DASD_STATE_READY;
-	if (dasd_scan_partitions(device) != 0)
+	rc = dasd_scan_partitions(device);
+	if (rc)
 		device->state = DASD_STATE_BASIC;
-	return 0;
+	return rc;
 }
 
 /*
@@ -254,6 +261,15 @@ dasd_state_ready_to_basic(struct dasd_de
 }
 
 /*
+ * Back to basic.
+ */
+static inline void
+dasd_state_unfmt_to_basic(struct dasd_device * device)
+{
+	device->state = DASD_STATE_BASIC;
+}
+
+/*
  * Make the device online and schedule the bottom half to start
  * the requeueing of requests from the linux request queue to the
  * ccw queue.
@@ -319,8 +335,12 @@ dasd_decrease_state(struct dasd_device *
 	if (device->state == DASD_STATE_READY &&
 	    device->target <= DASD_STATE_BASIC)
 		dasd_state_ready_to_basic(device);
-	
-	if (device->state == DASD_STATE_BASIC && 
+
+	if (device->state == DASD_STATE_UNFMT &&
+	    device->target <= DASD_STATE_BASIC)
+		dasd_state_unfmt_to_basic(device);
+
+	if (device->state == DASD_STATE_BASIC &&
 	    device->target <= DASD_STATE_KNOWN)
 		dasd_state_basic_to_known(device);
 	
@@ -1722,7 +1742,7 @@ dasd_open(struct inode *inp, struct file
 		goto out;
 	}
 
-	if (device->state < DASD_STATE_BASIC) {
+	if (device->state <= DASD_STATE_BASIC) {
 		DBF_DEV_EVENT(DBF_ERR, device, " %s",
 			      " Cannot open unrecognized device");
 		rc = -ENODEV;
diff -urpN linux-2.6/drivers/s390/block/dasd_genhd.c linux-2.6-patched/drivers/s390/block/dasd_genhd.c
--- linux-2.6/drivers/s390/block/dasd_genhd.c	2006-03-07 07:59:08.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_genhd.c	2006-03-07 07:59:26.000000000 +0100
@@ -100,8 +100,6 @@ dasd_scan_partitions(struct dasd_device 
 {
 	struct block_device *bdev;
 
-	/* Make the disk known. */
-	set_capacity(device->gdp, device->blocks << device->s2b_shift);
 	bdev = bdget_disk(device->gdp, 0);
 	if (!bdev || blkdev_get(bdev, FMODE_READ, 1) < 0)
 		return -ENODEV;
diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2006-03-07 07:59:08.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2006-03-07 07:59:26.000000000 +0100
@@ -26,7 +26,7 @@
  *   new: the dasd_device structure is allocated.
  *   known: the discipline for the device is identified.
  *   basic: the device can do basic i/o.
- *   accept: the device is analysed (format is known).
+ *   unfmt: the device could not be analyzed (format is unknown).
  *   ready: partition detection is done and the device is can do block io.
  *   online: the device accepts requests from the block device queue.
  *
@@ -47,8 +47,9 @@
 #define DASD_STATE_NEW	  0
 #define DASD_STATE_KNOWN  1
 #define DASD_STATE_BASIC  2
-#define DASD_STATE_READY  3
-#define DASD_STATE_ONLINE 4
+#define DASD_STATE_UNFMT  3
+#define DASD_STATE_READY  4
+#define DASD_STATE_ONLINE 5
 
 #include <linux/module.h>
 #include <linux/wait.h>
diff -urpN linux-2.6/drivers/s390/block/dasd_proc.c linux-2.6-patched/drivers/s390/block/dasd_proc.c
--- linux-2.6/drivers/s390/block/dasd_proc.c	2006-03-07 07:59:08.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_proc.c	2006-03-07 07:59:26.000000000 +0100
@@ -93,6 +93,9 @@ dasd_devices_show(struct seq_file *m, vo
 	case DASD_STATE_BASIC:
 		seq_printf(m, "basic");
 		break;
+	case DASD_STATE_UNFMT:
+		seq_printf(m, "unnformatted");
+		break;
 	case DASD_STATE_READY:
 	case DASD_STATE_ONLINE:
 		seq_printf(m, "active ");
diff -urpN linux-2.6/fs/partitions/ibm.c linux-2.6-patched/fs/partitions/ibm.c
--- linux-2.6/fs/partitions/ibm.c	2006-03-07 07:59:11.000000000 +0100
+++ linux-2.6-patched/fs/partitions/ibm.c	2006-03-07 07:59:26.000000000 +0100
@@ -52,6 +52,7 @@ int 
 ibm_partition(struct parsed_partitions *state, struct block_device *bdev)
 {
 	int blocksize, offset, size;
+	loff_t i_size;
 	dasd_information_t *info;
 	struct hd_geometry *geo;
 	char type[5] = {0,};
@@ -63,6 +64,13 @@ ibm_partition(struct parsed_partitions *
 	unsigned char *data;
 	Sector sect;
 
+	blocksize = bdev_hardsect_size(bdev);
+	if (blocksize <= 0)
+		return 0;
+	i_size = i_size_read(bdev->bd_inode);
+	if (i_size == 0)
+		return 0;
+
 	if ((info = kmalloc(sizeof(dasd_information_t), GFP_KERNEL)) == NULL)
 		goto out_noinfo;
 	if ((geo = kmalloc(sizeof(struct hd_geometry), GFP_KERNEL)) == NULL)
@@ -73,9 +81,6 @@ ibm_partition(struct parsed_partitions *
 	if (ioctl_by_bdev(bdev, BIODASDINFO, (unsigned long)info) != 0 ||
 	    ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
 		goto out_noioctl;
-	
-	if ((blocksize = bdev_hardsect_size(bdev)) <= 0)
-		goto out_badsect;
 
 	/*
 	 * Get volume label, extract name and type.
@@ -111,7 +116,7 @@ ibm_partition(struct parsed_partitions *
 		} else {
 			printk("CMS1/%8s:", name);
 			offset = (info->label_block + 1);
-			size = bdev->bd_inode->i_size >> 9;
+			size = i_size >> 9;
 		}
 		put_partition(state, 1, offset*(blocksize >> 9),
 				 size-offset*(blocksize >> 9));
@@ -168,7 +173,7 @@ ibm_partition(struct parsed_partitions *
 		else
 			printk("(nonl)/%8s:", name);
 		offset = (info->label_block + 1);
-		size = (bdev->bd_inode->i_size >> 9);
+		size = i_size >> 9;
 		put_partition(state, 1, offset*(blocksize >> 9),
 				 size-offset*(blocksize >> 9));
 	}
@@ -180,7 +185,6 @@ ibm_partition(struct parsed_partitions *
 	return 1;
 	
 out_readerr:
-out_badsect:
 out_noioctl:
 	kfree(label);
 out_nolab:
