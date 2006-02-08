Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbWBHMhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWBHMhS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbWBHMhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:37:18 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:61457 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030388AbWBHMhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:37:16 -0500
Date: Wed, 8 Feb 2006 13:37:09 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Horst Hummel <horst.hummel@de.ibm.com>,
       Stefan Weinhuber <wein@de.ibm.com>, hch@lst.de
Subject: [patch 05/10] s390: add missing validation for dasd discipline specific ioctls
Message-ID: <20060208123709.GF1656@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

Because of missing discipline validition dasd ioctls calls may not return
when called on a device handled by a different discipline.
(e.g calling ECKD specific BIODASDGATTR on an FBA device).
This addresses one of the issues Christoph has with the dasd driver.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/block/dasd.c      |    8 ++++-
 drivers/s390/block/dasd_eckd.c |   59 ++++++++++++++++++++++++++++-------------
 drivers/s390/block/dasd_eer.c  |   39 +++++++++++++++++++++------
 3 files changed, 78 insertions(+), 28 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-02-08 10:48:22.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-02-08 10:48:45.000000000 +0100
@@ -670,8 +670,10 @@ dasd_term_IO(struct dasd_ccw_req * cqr)
 
 	/* Check the cqr */
 	rc = dasd_check_cqr(cqr);
-	if (rc)
+	if (rc) {
+		cqr->status = DASD_CQR_FAILED;
 		return rc;
+	}
 	retries = 0;
 	device = (struct dasd_device *) cqr->device;
 	while ((retries < 5) && (cqr->status == DASD_CQR_IN_IO)) {
@@ -724,8 +726,10 @@ dasd_start_IO(struct dasd_ccw_req * cqr)
 
 	/* Check the cqr */
 	rc = dasd_check_cqr(cqr);
-	if (rc)
+	if (rc) {
+		cqr->status = DASD_CQR_FAILED;
 		return rc;
+	}
 	device = (struct dasd_device *) cqr->device;
 	if (cqr->retries < 0) {
 		DEV_MESSAGE(KERN_DEBUG, device,
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-patched/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	2006-02-08 10:48:22.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.c	2006-02-08 10:48:45.000000000 +0100
@@ -224,6 +224,28 @@ check_XRC (struct ccw1         *de_ccw,
 
 } /* end check_XRC */
 
+/*
+ * Check if called ioctl is valid on this device type.
+ * Returns device if anything is fine, ERR_PTR otherwise.
+ */
+static inline struct dasd_device *
+dasd_eckd_validate_ioctl(struct block_device *bdev, int no)
+{
+	struct dasd_device *device;
+
+	device = bdev->bd_disk->private_data;
+	if (device == NULL)
+		return ERR_PTR(-ENODEV);
+
+	if (strncmp((char *)&device->discipline->name, "ECKD", 4)) {
+		DEV_MESSAGE(KERN_WARNING, device,
+			    "ioctl (%x) not supported for %.4s device.",
+			    no, (char *)&device->discipline->name);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+	return device;
+}
+
 static inline void
 define_extent(struct ccw1 * ccw, struct DE_eckd_data * data, int trk,
 	      int totrk, int cmd, struct dasd_device * device)
@@ -1236,9 +1258,9 @@ dasd_eckd_release(struct block_device *b
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
+	device = dasd_eckd_validate_ioctl(bdev, no);
+	if (IS_ERR(device))
+		return PTR_ERR(device);
 
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
 				   1, 32, device);
@@ -1281,9 +1303,9 @@ dasd_eckd_reserve(struct block_device *b
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
+	device = dasd_eckd_validate_ioctl(bdev, no);
+	if (IS_ERR(device))
+		return PTR_ERR(device);
 
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
 				   1, 32, device);
@@ -1325,9 +1347,9 @@ dasd_eckd_steal_lock(struct block_device
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
+	device = dasd_eckd_validate_ioctl(bdev, no);
+	if (IS_ERR(device))
+		return PTR_ERR(device);
 
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
 				   1, 32, device);
@@ -1367,9 +1389,9 @@ dasd_eckd_performance(struct block_devic
 	struct ccw1 *ccw;
 	int rc;
 
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
+	device = dasd_eckd_validate_ioctl(bdev, no);
+	if (IS_ERR(device))
+		return PTR_ERR(device);
 
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
 				   1 /* PSF */  + 1 /* RSSD */ ,
@@ -1438,9 +1460,9 @@ dasd_eckd_get_attrib (struct block_devic
         if (!args)
                 return -EINVAL;
 
-        device = bdev->bd_disk->private_data;
-        if (device == NULL)
-                return -ENODEV;
+	device = dasd_eckd_validate_ioctl(bdev, no);
+	if (IS_ERR(device))
+		return PTR_ERR(device);
 
         private = (struct dasd_eckd_private *) device->private;
         attrib = private->attrib;
@@ -1467,9 +1489,10 @@ dasd_eckd_set_attrib(struct block_device
 	if (!args)
 		return -EINVAL;
 
-	device = bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
+
+	device = dasd_eckd_validate_ioctl(bdev, no);
+	if (IS_ERR(device))
+		return PTR_ERR(device);
 
 	if (copy_from_user(&attrib, (void __user *) args,
 			   sizeof (struct attrib_data_t))) {
diff -urpN linux-2.6/drivers/s390/block/dasd_eer.c linux-2.6-patched/drivers/s390/block/dasd_eer.c
--- linux-2.6/drivers/s390/block/dasd_eer.c	2006-02-08 10:48:22.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_eer.c	2006-02-08 10:48:45.000000000 +0100
@@ -109,6 +109,28 @@ static spinlock_t bufferlock = SPIN_LOCK
 DECLARE_WAIT_QUEUE_HEAD(dasd_eer_read_wait_queue);
 
 /*
+ * Check if called ioctl is valid on this device type.
+ * Returns device if anything is fine, ERR_PTR otherwise.
+ */
+static inline struct dasd_device *
+dasd_eer_validate_ioctl(struct block_device *bdev, int no)
+{
+	struct dasd_device *device;
+
+	device = bdev->bd_disk->private_data;
+	if (device == NULL)
+		return ERR_PTR(-ENODEV);
+
+	if (strncmp((char *)&device->discipline->name, "ECKD", 4)) {
+		DEV_MESSAGE(KERN_WARNING, device,
+			    "ioctl (%x) not supported for %.4s device.",
+			    no, (char *)&device->discipline->name);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+	return device;
+}
+
+/*
  * How many free bytes are available on the buffer.
  * needs to be called with bufferlock held
  */
@@ -523,8 +545,7 @@ static int
 dasd_eer_enable_on_device(struct dasd_device *device)
 {
 	void *eer;
-	if (!device)
-		return -ENODEV;
+
 	if (device->eer)
 		return 0;
 	if (!try_module_get(THIS_MODULE)) {
@@ -575,9 +596,10 @@ dasd_ioctl_set_eer(struct block_device *
 		return -EINVAL;
 	if (get_user(intval, (int __user *) args))
 		return -EFAULT;
-	device =  bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
+
+	device = dasd_eer_validate_ioctl(bdev, no);
+	if (IS_ERR(device))
+		return PTR_ERR(device);
 
 	intval = (intval != 0);
 	DEV_MESSAGE (KERN_DEBUG, device,
@@ -597,9 +619,10 @@ dasd_ioctl_get_eer(struct block_device *
 {
 	struct dasd_device *device;
 
-	device =  bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
+	device = dasd_eer_validate_ioctl(bdev, no);
+	if (IS_ERR(device))
+		return PTR_ERR(device);
+
 	return put_user((device->eer != NULL), (int __user *) args);
 }
 
