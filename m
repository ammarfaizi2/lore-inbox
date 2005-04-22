Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVDVPHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVDVPHi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVDVPGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:06:09 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:25754 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261967AbVDVPBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:01:25 -0400
Date: Fri, 22 Apr 2005 17:00:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 7/12] s390: dasd readonly attribute.
Message-ID: <20050422150052.GG17508@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 7/12] s390: dasd readonly attribute.

From: Horst Hummel <horst.hummel@de.ibm.com>

The independent read-only flags in devmap, dasd_device and gendisk
are not kept in sync. Use one bit per feature in the dasd driver and
keep that bit in sync with the gendisk bit.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/block/dasd.c        |   20 +++++++++----
 drivers/s390/block/dasd_devmap.c |   59 +++++++++++++++++++++++++++------------
 drivers/s390/block/dasd_genhd.c  |   10 ++++--
 drivers/s390/block/dasd_int.h    |    7 ++--
 drivers/s390/block/dasd_ioctl.c  |   31 +++++++++++++-------
 drivers/s390/block/dasd_proc.c   |    8 +++--
 6 files changed, 93 insertions(+), 42 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2005-04-22 15:44:48.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2005-04-22 15:45:04.000000000 +0200
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.158 $
+ * $Revision: 1.161 $
  */
 
 #include <linux/config.h>
@@ -1131,13 +1131,17 @@ __dasd_process_blk_queue(struct dasd_dev
 	request_queue_t *queue;
 	struct request *req;
 	struct dasd_ccw_req *cqr;
-	int nr_queued;
+	int nr_queued, feature_ro;
 
 	queue = device->request_queue;
 	/* No queue ? Then there is nothing to do. */
 	if (queue == NULL)
 		return;
 
+	feature_ro = dasd_get_feature(device->cdev, DASD_FEATURE_READONLY);
+	if (feature_ro < 0) 	/* no devmap */
+		return;
+
 	/*
 	 * We requeue request from the block device queue to the ccw
 	 * queue only in two states. In state DASD_STATE_READY the
@@ -1157,8 +1161,8 @@ __dasd_process_blk_queue(struct dasd_dev
 	       elv_next_request(queue) &&
 		nr_queued < DASD_CHANQ_MAX_SIZE) {
 		req = elv_next_request(queue);
-		if (test_bit(DASD_FLAG_RO, &device->flags) &&
-		    rq_data_dir(req) == WRITE) {
+
+		if (feature_ro && rq_data_dir(req) == WRITE) {
 			DBF_DEV_EVENT(DBF_ERR, device,
 				      "Rejecting write request %p",
 				      req);
@@ -1803,13 +1807,17 @@ dasd_generic_set_online (struct ccw_devi
 
 {
 	struct dasd_device *device;
-	int rc;
+	int feature_diag, rc;
+
+	feature_diag = dasd_get_feature(cdev, DASD_FEATURE_USEDIAG);
+	if (feature_diag < 0)
+		return feature_diag;
 
 	device = dasd_create_device(cdev);
 	if (IS_ERR(device))
 		return PTR_ERR(device);
 
-	if (test_bit(DASD_FLAG_USE_DIAG, &device->flags)) {
+	if (feature_diag) {
 	  	if (!dasd_diag_discipline_pointer) {
 		        printk (KERN_WARNING
 				"dasd_generic couldn't online device %s "
diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2005-04-22 15:45:04.000000000 +0200
@@ -11,7 +11,7 @@
  * functions may not be called from interrupt context. In particular
  * dasd_get_device is a no-no from interrupt context.
  *
- * $Revision: 1.37 $
+ * $Revision: 1.40 $
  */
 
 #include <linux/config.h>
@@ -513,14 +513,6 @@ dasd_create_device(struct ccw_device *cd
 	if (!devmap->device) {
 		devmap->device = device;
 		device->devindex = devmap->devindex;
-		if (devmap->features & DASD_FEATURE_READONLY)
-			set_bit(DASD_FLAG_RO, &device->flags);
-		else
-			clear_bit(DASD_FLAG_RO, &device->flags);
-		if (devmap->features & DASD_FEATURE_USEDIAG)
-			set_bit(DASD_FLAG_USE_DIAG, &device->flags);
-		else
-			clear_bit(DASD_FLAG_USE_DIAG, &device->flags);
 		get_device(&cdev->dev);
 		device->cdev = cdev;
 		rc = 0;
@@ -651,14 +643,8 @@ dasd_ro_store(struct device *dev, const 
 		devmap->features |= DASD_FEATURE_READONLY;
 	else
 		devmap->features &= ~DASD_FEATURE_READONLY;
-	if (devmap->device) {
-		if (devmap->device->gdp)
-			set_disk_ro(devmap->device->gdp, ro_flag);
-		if (ro_flag)
-			set_bit(DASD_FLAG_RO, &devmap->device->flags);
-		else
-			clear_bit(DASD_FLAG_RO, &devmap->device->flags);
-	}
+	if (devmap->device && devmap->device->gdp)
+		set_disk_ro(devmap->device->gdp, ro_flag);
 	spin_unlock(&dasd_devmap_lock);
 	return count;
 }
@@ -739,6 +725,45 @@ static struct attribute_group dasd_attr_
 	.attrs = dasd_attrs,
 };
 
+/*
+ * Return value of the specified feature.
+ */
+int
+dasd_get_feature(struct ccw_device *cdev, int feature)
+{
+	struct dasd_devmap *devmap;
+
+	devmap = dasd_find_busid(cdev->dev.bus_id);
+	if (IS_ERR(devmap))
+		return (int) PTR_ERR(devmap);
+
+	return ((devmap->features & feature) != 0);
+}
+
+/*
+ * Set / reset given feature.
+ * Flag indicates wether to set (!=0) or the reset (=0) the feature.
+ */
+int
+dasd_set_feature(struct ccw_device *cdev, int feature, int flag)
+{
+	struct dasd_devmap *devmap;
+
+	devmap = dasd_find_busid(cdev->dev.bus_id);
+	if (IS_ERR(devmap))
+		return (int) PTR_ERR(devmap);
+
+	spin_lock(&dasd_devmap_lock);
+	if (flag)
+		devmap->features |= feature;
+	else
+		devmap->features &= ~feature;
+
+	spin_unlock(&dasd_devmap_lock);
+	return 0;
+}
+
+
 int
 dasd_add_sysfs_files(struct ccw_device *cdev)
 {
diff -urpN linux-2.6/drivers/s390/block/dasd_genhd.c linux-2.6-patched/drivers/s390/block/dasd_genhd.c
--- linux-2.6/drivers/s390/block/dasd_genhd.c	2005-03-02 08:38:17.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_genhd.c	2005-04-22 15:45:04.000000000 +0200
@@ -9,7 +9,7 @@
  *
  * gendisk related functions for the dasd driver.
  *
- * $Revision: 1.48 $
+ * $Revision: 1.50 $
  */
 
 #include <linux/config.h>
@@ -31,12 +31,16 @@ int
 dasd_gendisk_alloc(struct dasd_device *device)
 {
 	struct gendisk *gdp;
-	int len;
+	int len, feature_ro;
 
 	/* Make sure the minor for this device exists. */
 	if (device->devindex >= DASD_PER_MAJOR)
 		return -EBUSY;
 
+	feature_ro = dasd_get_feature(device->cdev, DASD_FEATURE_READONLY);
+	if (feature_ro < 0)
+		return feature_ro;
+
 	gdp = alloc_disk(1 << DASD_PARTN_BITS);
 	if (!gdp)
 		return -ENOMEM;
@@ -71,7 +75,7 @@ dasd_gendisk_alloc(struct dasd_device *d
 
  	sprintf(gdp->devfs_name, "dasd/%s", device->cdev->dev.bus_id);
 
-	if (test_bit(DASD_FLAG_RO, &device->flags))
+	if (feature_ro)
 		set_disk_ro(gdp, 1);
 	gdp->private_data = device;
 	gdp->queue = device->request_queue;
diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2005-04-22 15:45:04.000000000 +0200
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.63 $
+ * $Revision: 1.64 $
  */
 
 #ifndef DASD_INT_H
@@ -329,8 +329,6 @@ struct dasd_device {
 #define DASD_STOPPED_DC_EIO  16        /* disconnected, return -EIO */
 
 /* per device flags */
-#define DASD_FLAG_RO		0	/* device is read-only */
-#define DASD_FLAG_USE_DIAG	1	/* use diag disciplnie */
 #define DASD_FLAG_DSC_ERROR	2	/* return -EIO when disconnected */
 #define DASD_FLAG_OFFLINE	3	/* device is in offline processing */
 
@@ -501,6 +499,9 @@ void dasd_devmap_exit(void);
 struct dasd_device *dasd_create_device(struct ccw_device *);
 void dasd_delete_device(struct dasd_device *);
 
+int dasd_get_feature(struct ccw_device *, int);
+int dasd_set_feature(struct ccw_device *, int, int);
+
 int dasd_add_sysfs_files(struct ccw_device *);
 void dasd_remove_sysfs_files(struct ccw_device *);
 
diff -urpN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-patched/drivers/s390/block/dasd_ioctl.c
--- linux-2.6/drivers/s390/block/dasd_ioctl.c	2005-03-02 08:38:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_ioctl.c	2005-04-22 15:45:04.000000000 +0200
@@ -7,6 +7,8 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
+ * $Revision: 1.45 $
+ *
  * i/o controls for the dasd driver.
  */
 #include <linux/config.h>
@@ -294,6 +296,7 @@ dasd_ioctl_format(struct block_device *b
 {
 	struct dasd_device *device;
 	struct format_data_t fdata;
+	int feature_ro;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -304,7 +307,11 @@ dasd_ioctl_format(struct block_device *b
 
 	if (device == NULL)
 		return -ENODEV;
-	if (test_bit(DASD_FLAG_RO, &device->flags))
+
+	feature_ro = dasd_get_feature(device->cdev, DASD_FEATURE_READONLY);
+	if (feature_ro < 0)
+		return feature_ro;
+	if (feature_ro)
 		return -EROFS;
 	if (copy_from_user(&fdata, (void __user *) args,
 			   sizeof (struct format_data_t)))
@@ -377,7 +384,7 @@ dasd_ioctl_information(struct block_devi
 	struct dasd_device *device;
 	struct dasd_information2_t *dasd_info;
 	unsigned long flags;
-	int rc;
+	int rc, feature_ro;
 	struct ccw_device *cdev;
 
 	device = bdev->bd_disk->private_data;
@@ -387,6 +394,10 @@ dasd_ioctl_information(struct block_devi
 	if (!device->discipline->fill_info)
 		return -EINVAL;
 
+	feature_ro = dasd_get_feature(device->cdev, DASD_FEATURE_READONLY);
+	if (feature_ro < 0)
+		return feature_ro;
+
 	dasd_info = kmalloc(sizeof(struct dasd_information2_t), GFP_KERNEL);
 	if (dasd_info == NULL)
 		return -ENOMEM;
@@ -415,9 +426,8 @@ dasd_ioctl_information(struct block_devi
 	if ((device->state < DASD_STATE_READY) ||
 	    (dasd_check_blocksize(device->bp_block)))
 		dasd_info->format = DASD_FORMAT_NONE;
-	
-	dasd_info->features |= test_bit(DASD_FLAG_RO, &device->flags) ?
-		DASD_FEATURE_READONLY : DASD_FEATURE_DEFAULT;
+
+	dasd_info->features |= feature_ro;
 
 	if (device->discipline)
 		memcpy(dasd_info->type, device->discipline->name, 4);
@@ -460,7 +470,7 @@ static int
 dasd_ioctl_set_ro(struct block_device *bdev, int no, long args)
 {
 	struct dasd_device *device;
-	int intval;
+	int intval, rc;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -472,12 +482,11 @@ dasd_ioctl_set_ro(struct block_device *b
 	device =  bdev->bd_disk->private_data;
 	if (device == NULL)
 		return -ENODEV;
+
 	set_disk_ro(bdev->bd_disk, intval);
-	if (intval)
-		set_bit(DASD_FLAG_RO, &device->flags);
-	else
-		clear_bit(DASD_FLAG_RO, &device->flags);
-	return 0;
+	rc = dasd_set_feature(device->cdev, DASD_FEATURE_READONLY, intval);
+
+	return rc;
 }
 
 /*
diff -urpN linux-2.6/drivers/s390/block/dasd_proc.c linux-2.6-patched/drivers/s390/block/dasd_proc.c
--- linux-2.6/drivers/s390/block/dasd_proc.c	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_proc.c	2005-04-22 15:45:04.000000000 +0200
@@ -9,7 +9,7 @@
  *
  * /proc interface for the dasd driver.
  *
- * $Revision: 1.30 $
+ * $Revision: 1.31 $
  */
 
 #include <linux/config.h>
@@ -54,6 +54,7 @@ dasd_devices_show(struct seq_file *m, vo
 {
 	struct dasd_device *device;
 	char *substr;
+	int feature;
 
 	device = dasd_device_from_devindex((unsigned long) v - 1);
 	if (IS_ERR(device))
@@ -77,7 +78,10 @@ dasd_devices_show(struct seq_file *m, vo
 	else
 		seq_printf(m, " is ????????");
 	/* Print devices features. */
-	substr = test_bit(DASD_FLAG_RO, &device->flags) ? "(ro)" : " ";
+	feature = dasd_get_feature(device->cdev, DASD_FEATURE_READONLY);
+	if (feature < 0)
+		return 0;
+	substr = feature ? "(ro)" : " ";
 	seq_printf(m, "%4s: ", substr);
 	/* Print device status information. */
 	switch ((device != NULL) ? device->state : -1) {
