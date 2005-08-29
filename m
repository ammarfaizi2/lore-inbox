Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbVH2Ryh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVH2Ryh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVH2Ryh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:54:37 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:12192 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751189AbVH2Ryg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:54:36 -0400
Date: Mon, 29 Aug 2005 19:54:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, horst.hummel@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 3/10] s390: deadlock in dasd_devmap.
Message-ID: <20050829175431.GC6796@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/10] s390: deadlock in dasd_devmap.

From: Horst Hummel <horst.hummel@de.ibm.com>

Reintroduce a read-only copy of the devmap features in the
device struct. This is necessary to solve a deadlock on
the dasd_devmap_lock which is acquired by dasd_get_features
called from the dasd tasklet. The current implementation of
devmap doesn't allow to call any devmap function from
interrupt or softirq context.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/block/dasd.c        |   19 ++++++-------------
 drivers/s390/block/dasd_devmap.c |    8 ++++++--
 drivers/s390/block/dasd_genhd.c  |   10 +++-------
 drivers/s390/block/dasd_int.h    |    3 ++-
 drivers/s390/block/dasd_ioctl.c  |   17 +++++------------
 drivers/s390/block/dasd_proc.c   |    8 ++------
 6 files changed, 24 insertions(+), 41 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2005-08-29 19:18:06.000000000 +0200
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.165 $
+ * $Revision: 1.167 $
  */
 
 #include <linux/config.h>
@@ -1131,17 +1131,13 @@ __dasd_process_blk_queue(struct dasd_dev
 	request_queue_t *queue;
 	struct request *req;
 	struct dasd_ccw_req *cqr;
-	int nr_queued, feature_ro;
+	int nr_queued;
 
 	queue = device->request_queue;
 	/* No queue ? Then there is nothing to do. */
 	if (queue == NULL)
 		return;
 
-	feature_ro = dasd_get_feature(device->cdev, DASD_FEATURE_READONLY);
-	if (feature_ro < 0) 	/* no devmap */
-		return;
-
 	/*
 	 * We requeue request from the block device queue to the ccw
 	 * queue only in two states. In state DASD_STATE_READY the
@@ -1162,7 +1158,8 @@ __dasd_process_blk_queue(struct dasd_dev
 		nr_queued < DASD_CHANQ_MAX_SIZE) {
 		req = elv_next_request(queue);
 
-		if (feature_ro && rq_data_dir(req) == WRITE) {
+		if (device->features & DASD_FEATURE_READONLY &&
+		    rq_data_dir(req) == WRITE) {
 			DBF_DEV_EVENT(DBF_ERR, device,
 				      "Rejecting write request %p",
 				      req);
@@ -1814,17 +1811,13 @@ dasd_generic_set_online (struct ccw_devi
 
 {
 	struct dasd_device *device;
-	int feature_diag, rc;
+	int rc;
 
 	device = dasd_create_device(cdev);
 	if (IS_ERR(device))
 		return PTR_ERR(device);
 
-	feature_diag = dasd_get_feature(cdev, DASD_FEATURE_USEDIAG);
-	if (feature_diag < 0)
-		return feature_diag;
-
-	if (feature_diag) {
+	if (device->features & DASD_FEATURE_USEDIAG) {
 	  	if (!dasd_diag_discipline_pointer) {
 		        printk (KERN_WARNING
 				"dasd_generic couldn't online device %s "
diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2005-08-29 19:18:06.000000000 +0200
@@ -11,7 +11,7 @@
  * functions may not be called from interrupt context. In particular
  * dasd_get_device is a no-no from interrupt context.
  *
- * $Revision: 1.40 $
+ * $Revision: 1.43 $
  */
 
 #include <linux/config.h>
@@ -513,6 +513,7 @@ dasd_create_device(struct ccw_device *cd
 	if (!devmap->device) {
 		devmap->device = device;
 		device->devindex = devmap->devindex;
+		device->features = devmap->features;
 		get_device(&cdev->dev);
 		device->cdev = cdev;
 		rc = 0;
@@ -643,6 +644,8 @@ dasd_ro_store(struct device *dev, struct
 		devmap->features |= DASD_FEATURE_READONLY;
 	else
 		devmap->features &= ~DASD_FEATURE_READONLY;
+	if (devmap->device)
+		devmap->device->features = devmap->features;
 	if (devmap->device && devmap->device->gdp)
 		set_disk_ro(devmap->device->gdp, ro_flag);
 	spin_unlock(&dasd_devmap_lock);
@@ -758,7 +761,8 @@ dasd_set_feature(struct ccw_device *cdev
 		devmap->features |= feature;
 	else
 		devmap->features &= ~feature;
-
+	if (devmap->device)
+		devmap->device->features = devmap->features;
 	spin_unlock(&dasd_devmap_lock);
 	return 0;
 }
diff -urpN linux-2.6/drivers/s390/block/dasd_genhd.c linux-2.6-patched/drivers/s390/block/dasd_genhd.c
--- linux-2.6/drivers/s390/block/dasd_genhd.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_genhd.c	2005-08-29 19:18:06.000000000 +0200
@@ -9,7 +9,7 @@
  *
  * gendisk related functions for the dasd driver.
  *
- * $Revision: 1.50 $
+ * $Revision: 1.51 $
  */
 
 #include <linux/config.h>
@@ -31,16 +31,12 @@ int
 dasd_gendisk_alloc(struct dasd_device *device)
 {
 	struct gendisk *gdp;
-	int len, feature_ro;
+	int len;
 
 	/* Make sure the minor for this device exists. */
 	if (device->devindex >= DASD_PER_MAJOR)
 		return -EBUSY;
 
-	feature_ro = dasd_get_feature(device->cdev, DASD_FEATURE_READONLY);
-	if (feature_ro < 0)
-		return feature_ro;
-
 	gdp = alloc_disk(1 << DASD_PARTN_BITS);
 	if (!gdp)
 		return -ENOMEM;
@@ -75,7 +71,7 @@ dasd_gendisk_alloc(struct dasd_device *d
 
  	sprintf(gdp->devfs_name, "dasd/%s", device->cdev->dev.bus_id);
 
-	if (feature_ro)
+	if (device->features & DASD_FEATURE_READONLY)
 		set_disk_ro(gdp, 1);
 	gdp->private_data = device;
 	gdp->queue = device->request_queue;
diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2005-08-29 19:18:06.000000000 +0200
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.64 $
+ * $Revision: 1.65 $
  */
 
 #ifndef DASD_INT_H
@@ -286,6 +286,7 @@ struct dasd_device {
 	unsigned int bp_block;		/* bytes per block */
 	unsigned int s2b_shift;		/* log2 (bp_block/512) */
 	unsigned long flags;		/* per device flags */
+	unsigned short features;        /* copy of devmap-features (read-only!) */
 
 	/* Device discipline stuff. */
 	struct dasd_discipline *discipline;
diff -urpN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-patched/drivers/s390/block/dasd_ioctl.c
--- linux-2.6/drivers/s390/block/dasd_ioctl.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_ioctl.c	2005-08-29 19:18:06.000000000 +0200
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.45 $
+ * $Revision: 1.47 $
  *
  * i/o controls for the dasd driver.
  */
@@ -296,7 +296,6 @@ dasd_ioctl_format(struct block_device *b
 {
 	struct dasd_device *device;
 	struct format_data_t fdata;
-	int feature_ro;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -308,10 +307,7 @@ dasd_ioctl_format(struct block_device *b
 	if (device == NULL)
 		return -ENODEV;
 
-	feature_ro = dasd_get_feature(device->cdev, DASD_FEATURE_READONLY);
-	if (feature_ro < 0)
-		return feature_ro;
-	if (feature_ro)
+	if (device->features & DASD_FEATURE_READONLY)
 		return -EROFS;
 	if (copy_from_user(&fdata, (void __user *) args,
 			   sizeof (struct format_data_t)))
@@ -384,7 +380,7 @@ dasd_ioctl_information(struct block_devi
 	struct dasd_device *device;
 	struct dasd_information2_t *dasd_info;
 	unsigned long flags;
-	int rc, feature_ro;
+	int rc;
 	struct ccw_device *cdev;
 
 	device = bdev->bd_disk->private_data;
@@ -394,10 +390,6 @@ dasd_ioctl_information(struct block_devi
 	if (!device->discipline->fill_info)
 		return -EINVAL;
 
-	feature_ro = dasd_get_feature(device->cdev, DASD_FEATURE_READONLY);
-	if (feature_ro < 0)
-		return feature_ro;
-
 	dasd_info = kmalloc(sizeof(struct dasd_information2_t), GFP_KERNEL);
 	if (dasd_info == NULL)
 		return -ENOMEM;
@@ -427,7 +419,8 @@ dasd_ioctl_information(struct block_devi
 	    (dasd_check_blocksize(device->bp_block)))
 		dasd_info->format = DASD_FORMAT_NONE;
 
-	dasd_info->features |= feature_ro;
+	dasd_info->features |=
+		((device->features & DASD_FEATURE_READONLY) != 0);
 
 	if (device->discipline)
 		memcpy(dasd_info->type, device->discipline->name, 4);
diff -urpN linux-2.6/drivers/s390/block/dasd_proc.c linux-2.6-patched/drivers/s390/block/dasd_proc.c
--- linux-2.6/drivers/s390/block/dasd_proc.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_proc.c	2005-08-29 19:18:06.000000000 +0200
@@ -9,7 +9,7 @@
  *
  * /proc interface for the dasd driver.
  *
- * $Revision: 1.32 $
+ * $Revision: 1.33 $
  */
 
 #include <linux/config.h>
@@ -55,7 +55,6 @@ dasd_devices_show(struct seq_file *m, vo
 {
 	struct dasd_device *device;
 	char *substr;
-	int feature;
 
 	device = dasd_device_from_devindex((unsigned long) v - 1);
 	if (IS_ERR(device))
@@ -79,10 +78,7 @@ dasd_devices_show(struct seq_file *m, vo
 	else
 		seq_printf(m, " is ????????");
 	/* Print devices features. */
-	feature = dasd_get_feature(device->cdev, DASD_FEATURE_READONLY);
-	if (feature < 0)
-		return 0;
-	substr = feature ? "(ro)" : " ";
+	substr = (device->features & DASD_FEATURE_READONLY) ? "(ro)" : " ";
 	seq_printf(m, "%4s: ", substr);
 	/* Print device status information. */
 	switch ((device != NULL) ? device->state : -1) {
