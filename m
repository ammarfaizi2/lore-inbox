Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbTIKR1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbTIKR1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:27:20 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:37303 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261426AbTIKRSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:18:04 -0400
Date: Thu, 11 Sep 2003 19:17:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (5/7): dasd driver.
Message-ID: <20030911171720.GF5637@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Do add_disk even for unformatted devices to be able to format them.
- Remove initialization of device.name.
- Export some functions.

diffstat:
 drivers/s390/block/dasd.c        |  162 +++++++++++++++++----------------------
 drivers/s390/block/dasd_devmap.c |    7 -
 drivers/s390/block/dasd_eckd.c   |   12 --
 drivers/s390/block/dasd_genhd.c  |   97 +++++++++++++----------
 drivers/s390/block/dasd_int.h    |   28 +++---
 drivers/s390/block/dasd_ioctl.c  |    7 +
 drivers/s390/block/dasd_proc.c   |   17 ++--
 7 files changed, 164 insertions(+), 166 deletions(-)

diff -urN linux-2.6/drivers/s390/block/dasd.c linux-2.6-s390/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	Mon Sep  8 21:50:03 2003
+++ linux-2.6-s390/drivers/s390/block/dasd.c	Thu Sep 11 19:21:26 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.101 $
+ * $Revision: 1.109 $
  */
 
 #include <linux/config.h>
@@ -49,8 +49,9 @@
 /*
  * SECTION: prototypes for static functions of dasd.c
  */
-static int  dasd_setup_blkdev(struct dasd_device * device);
-static void dasd_disable_blkdev(struct dasd_device * device);
+static int  dasd_alloc_queue(struct dasd_device * device);
+static void dasd_setup_queue(struct dasd_device * device);
+static void dasd_free_queue(struct dasd_device * device);
 static void dasd_flush_request_queue(struct dasd_device *);
 static void dasd_int_handler(struct ccw_device *, unsigned long, struct irb *);
 static void dasd_flush_ccw_queue(struct dasd_device *, int);
@@ -67,10 +68,9 @@
  * Allocate memory for a new device structure.
  */
 struct dasd_device *
-dasd_alloc_device(unsigned int devindex)
+dasd_alloc_device(void)
 {
 	struct dasd_device *device;
-	struct gendisk *gdp;
 
 	device = kmalloc(sizeof (struct dasd_device), GFP_ATOMIC);
 	if (device == NULL)
@@ -91,17 +91,6 @@
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* Allocate gendisk structure for device. */
-	gdp = dasd_gendisk_alloc(devindex);
-	if (IS_ERR(gdp)) {
-		free_page((unsigned long) device->erp_mem);
-		free_pages((unsigned long) device->ccw_mem, 1);
-		kfree(device);
-		return (struct dasd_device *) gdp;
-	}
-	gdp->private_data = device;
-	device->gdp = gdp;
-
 	dasd_init_chunklist(&device->ccw_chunks, device->ccw_mem, PAGE_SIZE*2);
 	dasd_init_chunklist(&device->erp_chunks, device->erp_mem, PAGE_SIZE);
 	spin_lock_init(&device->request_queue_lock);
@@ -128,7 +117,6 @@
 		kfree(device->private);
 	free_page((unsigned long) device->erp_mem);
 	free_pages((unsigned long) device->ccw_mem, 1);
-	put_disk(device->gdp);
 	kfree(device);
 }
 
@@ -138,14 +126,19 @@
 static inline int
 dasd_state_new_to_known(struct dasd_device *device)
 {
+	int rc;
+
 	/*
 	 * As long as the device is not in state DASD_STATE_NEW we want to 
 	 * keep the reference count > 0.
 	 */
 	dasd_get_device(device);
 
- 	sprintf(device->gdp->devfs_name, "dasd/%04x",
-		_ccw_device_get_device_number(device->cdev));
+	rc = dasd_alloc_queue(device);
+	if (rc) {
+		dasd_put_device(device);
+		return rc;
+	}
 
 	device->state = DASD_STATE_KNOWN;
 	return 0;
@@ -161,6 +154,8 @@
 	device->discipline = NULL;
 	device->state = DASD_STATE_NEW;
 
+	dasd_free_queue(device);
+
 	/* Give up reference we took in dasd_state_new_to_known. */
 	dasd_put_device(device);
 }
@@ -171,8 +166,15 @@
 static inline int
 dasd_state_known_to_basic(struct dasd_device * device)
 {
+	int rc;
+
+	/* Allocate and register gendisk structure. */
+	rc = dasd_gendisk_alloc(device);
+	if (rc)
+		return rc;
+
 	/* register 'device' debug area, used for all DBF_DEV_XXX calls */
-	device->debug_area = debug_register(device->gdp->disk_name, 0, 2,
+	device->debug_area = debug_register(device->cdev->dev.bus_id, 0, 2,
 					    8 * sizeof (long));
 	debug_register_view(device->debug_area, &debug_sprintf_view);
 	debug_set_level(device->debug_area, DBF_ERR);
@@ -188,6 +190,7 @@
 static inline void
 dasd_state_basic_to_known(struct dasd_device * device)
 {
+	dasd_gendisk_free(device);
 	dasd_flush_ccw_queue(device, 1);
 	DBF_DEV_EVENT(DBF_EMERG, device, "%p debug area deleted", device);
 	if (device->debug_area != NULL) {
@@ -206,59 +209,41 @@
  * interrupt for this detection ccw uses the kernel event daemon to
  * trigger the call to dasd_change_state. All this is done in the
  * discipline code, see dasd_eckd.c.
+ * After the analysis ccw is done (do_analysis returned 0 or error)
+ * the block device is setup. Either a fake disk is added to allow
+ * formatting or a proper device request queue is created.
  */
 static inline int
-dasd_state_basic_to_accept(struct dasd_device * device)
+dasd_state_basic_to_ready(struct dasd_device * device)
 {
 	int rc;
 
 	rc = 0;
 	if (device->discipline->do_analysis != NULL)
 		rc = device->discipline->do_analysis(device);
-	if (rc == 0)
-		device->state = DASD_STATE_ACCEPT;
-	return rc;
-}
-
-/*
- * Forget everything the initial analysis found out.
- */
-static inline void
-dasd_state_accept_to_basic(struct dasd_device * device)
-{
-	device->blocks = 0;
-	device->bp_block = 0;
-	device->s2b_shift = 0;
-	device->state = DASD_STATE_BASIC;
-}
-
-/*
- * Setup block device.
- */
-static inline int
-dasd_state_accept_to_ready(struct dasd_device * device)
-{
-	int rc;
-
-	rc = dasd_setup_blkdev(device);
-	if (rc == 0) {
-		dasd_setup_partitions(device);
-		device->state = DASD_STATE_READY;
-	}
-	return rc;
+	if (rc)
+		return rc;
+	dasd_setup_queue(device);
+	device->state = DASD_STATE_READY;
+	dasd_scan_partitions(device);
+	return 0;
 }
 
 /*
  * Remove device from block device layer. Destroy dirty buffers.
+ * Forget format information. Check if the target level is basic
+ * and if it is create fake disk for formatting.
  */
 static inline void
-dasd_state_ready_to_accept(struct dasd_device * device)
+dasd_state_ready_to_basic(struct dasd_device * device)
 {
 	dasd_flush_ccw_queue(device, 0);
 	dasd_destroy_partitions(device);
 	dasd_flush_request_queue(device);
-	dasd_disable_blkdev(device);
-	device->state = DASD_STATE_ACCEPT;
+	device->blocks = 0;
+	device->bp_block = 0;
+	device->s2b_shift = 0;
+	device->state = DASD_STATE_BASIC;
 }
 
 /*
@@ -303,13 +288,8 @@
 
 	if (!rc &&
 	    device->state == DASD_STATE_BASIC &&
-	    device->target >= DASD_STATE_ACCEPT)
-		rc = dasd_state_basic_to_accept(device);
-
-	if (!rc &&
-	    device->state == DASD_STATE_ACCEPT &&
 	    device->target >= DASD_STATE_READY)
-		rc = dasd_state_accept_to_ready(device);
+		rc = dasd_state_basic_to_ready(device);
 
 	if (!rc &&
 	    device->state == DASD_STATE_READY &&
@@ -330,12 +310,8 @@
 		dasd_state_online_to_ready(device);
 	
 	if (device->state == DASD_STATE_READY &&
-	    device->target <= DASD_STATE_ACCEPT)
-		dasd_state_ready_to_accept(device);
-	
-	if (device->state == DASD_STATE_ACCEPT && 
 	    device->target <= DASD_STATE_BASIC)
-		dasd_state_accept_to_basic(device);
+		dasd_state_ready_to_basic(device);
 	
 	if (device->state == DASD_STATE_BASIC && 
 	    device->target <= DASD_STATE_KNOWN)
@@ -363,13 +339,8 @@
 		rc = dasd_increase_state(device);
 	else
 		rc = dasd_decrease_state(device);
-        if (rc && rc != -EAGAIN) {
-		if (rc != -ENODEV)
-			MESSAGE (KERN_INFO, "giving up on dasd device with "
-				 "devno %04x",
-				 _ccw_device_get_device_number(device->cdev));
+        if (rc && rc != -EAGAIN)
                 device->target = device->state;
-        }
 
 	if (device->state == device->target)
 		wake_up(&dasd_init_waitq);
@@ -406,12 +377,12 @@
 void
 dasd_set_target_state(struct dasd_device *device, int target)
 {
-	/* If we are in probeonly mode stop at DASD_STATE_ACCEPT. */
-	if (dasd_probeonly && target > DASD_STATE_ACCEPT)
-		target = DASD_STATE_ACCEPT;
+	/* If we are in probeonly mode stop at DASD_STATE_READY. */
+	if (dasd_probeonly && target > DASD_STATE_READY)
+		target = DASD_STATE_READY;
 	if (device->target != target) {
                 if (device->state == target)
-                        wake_up(&dasd_init_waitq);
+			wake_up(&dasd_init_waitq);
 		device->target = target;
 	}
 	if (device->state != device->target)
@@ -427,7 +398,6 @@
 	return (device->state == device->target);
 }
 
-// FIXME: if called from dasd_devices_write discpline is not set -> oops.
 void
 dasd_enable_device(struct dasd_device *device)
 {
@@ -1153,12 +1123,12 @@
 
 	/*
 	 * We requeue request from the block device queue to the ccw
-	 * queue only in two states. In state DASD_STATE_ACCEPT the
+	 * queue only in two states. In state DASD_STATE_READY the
 	 * partition detection is done and we need to requeue requests
 	 * for that. State DASD_STATE_ONLINE is normal block device
 	 * operation.
 	 */
-	if (device->state != DASD_STATE_ACCEPT &&
+	if (device->state != DASD_STATE_READY &&
 	    device->state != DASD_STATE_ONLINE)
 		return;
 	nr_queued = 0;
@@ -1599,14 +1569,13 @@
 }
 
 /*
- * Allocate request queue and initialize gendisk info for device.
+ * Allocate and initialize request queue.
  */
 static int
-dasd_setup_blkdev(struct dasd_device * device)
+dasd_alloc_queue(struct dasd_device * device)
 {
-	int max, rc;
-
-	device->request_queue = blk_init_queue(do_dasd_request, &device->request_queue_lock);
+	device->request_queue = blk_init_queue(do_dasd_request,
+					       &device->request_queue_lock);
 	if (device->request_queue == NULL)
 		return -ENOMEM;
 
@@ -1619,6 +1588,17 @@
 		return rc;
 	}
 #endif
+	return 0;
+}
+
+/*
+ * Allocate and initialize request queue.
+ */
+static void
+dasd_setup_queue(struct dasd_device * device)
+{
+	int max;
+
 	blk_queue_hardsect_size(device->request_queue, device->bp_block);
 	max = device->discipline->max_blocks << device->s2b_shift;
 	blk_queue_max_sectors(device->request_queue, max);
@@ -1626,14 +1606,13 @@
 	blk_queue_max_hw_segments(device->request_queue, -1L);
 	blk_queue_max_segment_size(device->request_queue, -1L);
 	blk_queue_segment_boundary(device->request_queue, -1L);
-	return 0;
 }
 
 /*
  * Deactivate and free request queue.
  */
 static void
-dasd_disable_blkdev(struct dasd_device * device)
+dasd_free_queue(struct dasd_device * device)
 {
 	if (device->request_queue) {
 		blk_cleanup_queue(device->request_queue);
@@ -1703,7 +1682,7 @@
 	struct gendisk *disk = inp->i_bdev->bd_disk;
 	struct dasd_device *device = disk->private_data;
 
-	if (device->state < DASD_STATE_ACCEPT) {
+	if (device->state < DASD_STATE_BASIC) {
 		DBF_DEV_EVENT(DBF_ERR, device, " %s",
 			      " Cannot release unrecognized device");
 		return -EINVAL;
@@ -1752,9 +1731,6 @@
 	int devno;
 	int ret = 0;
 
-	snprintf(cdev->dev.name, DEVICE_NAME_SIZE,
-		 "Direct Access Storage Device");
-
 	devno = _ccw_device_get_device_number(cdev);
 	if (dasd_autodetect
 	    && (ret = dasd_add_range(devno, devno, DASD_FEATURE_DEFAULT))) {
@@ -2083,6 +2059,12 @@
 EXPORT_SYMBOL(dasd_start_IO);
 EXPORT_SYMBOL(dasd_term_IO);
 
+EXPORT_SYMBOL_GPL(dasd_generic_probe);
+EXPORT_SYMBOL_GPL(dasd_generic_remove);
+EXPORT_SYMBOL_GPL(dasd_generic_set_online);
+EXPORT_SYMBOL_GPL(dasd_generic_set_offline);
+EXPORT_SYMBOL_GPL(dasd_generic_auto_online);
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
diff -urN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-s390/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	Mon Sep  8 21:50:06 2003
+++ linux-2.6-s390/drivers/s390/block/dasd_devmap.c	Thu Sep 11 19:21:26 2003
@@ -11,7 +11,7 @@
  * functions may not be called from interrupt context. In particular
  * dasd_get_device is a no-no from interrupt context.
  *
- * $Revision: 1.15 $
+ * $Revision: 1.17 $
  */
 
 #include <linux/config.h>
@@ -424,10 +424,11 @@
 	if (!(devmap = dasd_devmap_from_devno (devno)))
 		return ERR_PTR(-ENODEV);
 
-	device = dasd_alloc_device(devmap->devindex);
+	device = dasd_alloc_device();
 	if (IS_ERR(device))
 		return device;
 	atomic_set(&device->ref_count, 1);
+	device->devindex = devmap->devindex;
 	device->ro_flag = (devmap->features & DASD_FEATURE_READONLY) ? 1 : 0;
 	device->use_diag_flag = 1;
 
@@ -435,7 +436,6 @@
 	if (cdev->dev.driver_data == NULL) {
 		get_device(&cdev->dev);
 		cdev->dev.driver_data = device;
-		device->gdp->driverfs_dev = &cdev->dev;
 		device->cdev = cdev;
 		rc = 0;
 	} else
@@ -483,7 +483,6 @@
 	/* Disconnect dasd_device structure from ccw_device structure. */
 	cdev = device->cdev;
 	device->cdev = NULL;
-	device->gdp->driverfs_dev = NULL;
 	cdev->dev.driver_data = NULL;
 
 	/* Put ccw_device structure. */
diff -urN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	Mon Sep  8 21:49:51 2003
+++ linux-2.6-s390/drivers/s390/block/dasd_eckd.c	Thu Sep 11 19:21:26 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.46 $
+ * $Revision: 1.47 $
  */
 
 #include <linux/config.h>
@@ -503,12 +503,6 @@
 	memcpy(&private->conf_data, conf_data,
 	       sizeof (struct dasd_eckd_confdata));
 
-	DEV_MESSAGE(KERN_INFO, device,
-		    "%04X/%02X(CU:%04X/%02X): Configuration data read",
-		    private->rdc_data.dev_type,
-		    private->rdc_data.dev_model,
-		    private->rdc_data.cu_type,
-		    private->rdc_data.cu_model.model);
 	return 0;
 }
 
@@ -843,8 +837,9 @@
 		ccw->flags = CCW_FLAG_SLI;
 		ccw->count = 8;
 		ccw->cda = (__u32)(addr_t) ect;
+		ccw++;
 	}
-	if (fdata->intensity & 0x04) {	/* erase track */
+	if ((fdata->intensity & ~0x08) & 0x04) {	/* erase track */
 		ect = (struct eckd_count *) data;
 		data += sizeof(struct eckd_count);
 		ect->cyl = cyl;
@@ -884,6 +879,7 @@
 			ccw->flags = CCW_FLAG_SLI;
 			ccw->count = 8;
 			ccw->cda = (__u32)(addr_t) ect;
+			ccw++;
 		}
 	}
 	fcp->device = device;
diff -urN linux-2.6/drivers/s390/block/dasd_genhd.c linux-2.6-s390/drivers/s390/block/dasd_genhd.c
--- linux-2.6/drivers/s390/block/dasd_genhd.c	Mon Sep  8 21:50:21 2003
+++ linux-2.6-s390/drivers/s390/block/dasd_genhd.c	Thu Sep 11 19:21:26 2003
@@ -9,7 +9,7 @@
  *
  * Dealing with devices registered to multiple major numbers.
  *
- * $Revision: 1.31 $
+ * $Revision: 1.37 $
  */
 
 #include <linux/config.h>
@@ -99,10 +99,10 @@
 }
 
 /*
- * Allocate gendisk structure for devindex.
+ * Allocate and register gendisk structure for device.
  */
-struct gendisk *
-dasd_gendisk_alloc(int devindex)
+int
+dasd_gendisk_alloc(struct dasd_device *device)
 {
 	struct major_info *mi;
 	struct gendisk *gdp;
@@ -112,7 +112,7 @@
 	mi = NULL;
 	while (1) {
 		spin_lock(&dasd_major_lock);
-		index = devindex;
+		index = device->devindex;
 		list_for_each_entry(mi, &dasd_major_info, list) {
 			if (index < DASD_PER_MAJOR)
 				break;
@@ -124,18 +124,19 @@
 		rc = dasd_register_major(0);
 		if (rc) {
 			DBF_EXC(DBF_ALERT, "%s", "out of major numbers!");
-			return ERR_PTR(rc);
+			return rc;
 		}
 	}
 	
 	gdp = alloc_disk(1 << DASD_PARTN_BITS);
 	if (!gdp)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	/* Initialize gendisk structure. */
 	gdp->major = mi->major;
 	gdp->first_minor = index << DASD_PARTN_BITS;
 	gdp->fops = &dasd_device_operations;
+	gdp->driverfs_dev = &device->cdev->dev;
 
 	/*
 	 * Set device name.
@@ -144,61 +145,75 @@
 	 *   dasdaaa - dasdzzz : 17576 devices, added up = 18278
 	 */
 	len = sprintf(gdp->disk_name, "dasd");
-	if (devindex > 25) {
-		if (devindex > 701)
+	if (device->devindex > 25) {
+		if (device->devindex > 701)
 			len += sprintf(gdp->disk_name + len, "%c",
-				       'a' + (((devindex - 702) / 676) % 26));
+				       'a'+(((device->devindex-702)/676)%26));
 		len += sprintf(gdp->disk_name + len, "%c",
-			       'a' + (((devindex - 26) / 26) % 26));
+			       'a'+(((device->devindex-26)/26)%26));
 	}
-	len += sprintf(gdp->disk_name + len, "%c", 'a' + (devindex % 26));
+	len += sprintf(gdp->disk_name + len, "%c", 'a'+(device->devindex%26));
 
-	return gdp;
+ 	sprintf(gdp->devfs_name, "dasd/%04x",
+		_ccw_device_get_device_number(device->cdev));
+
+	if (device->ro_flag)
+		set_disk_ro(gdp, 1);
+	gdp->private_data = device;
+	gdp->queue = device->request_queue;
+	device->gdp = gdp;
+	set_capacity(device->gdp, 0);
+	add_disk(device->gdp);
+	return 0;
 }
 
 /*
- * Return major number for device with device index devindex.
+ * Unregister and free gendisk structure for device.
  */
-int dasd_gendisk_index_major(int devindex)
+void
+dasd_gendisk_free(struct dasd_device *device)
 {
-	struct major_info *mi;
-	int rc;
-
-	spin_lock(&dasd_major_lock);
-	rc = -ENODEV;
-	list_for_each_entry(mi, &dasd_major_info, list) {
-		if (devindex < DASD_PER_MAJOR) {
-			rc = mi->major;
-			break;
-		}
-		devindex -= DASD_PER_MAJOR;
-	}
-	spin_unlock(&dasd_major_lock);
-	return rc;
+	del_gendisk(device->gdp);
+	put_disk(device->gdp);
+	device->gdp = 0;
 }
 
 /*
- * Register disk to genhd. This will trigger a partition detection.
+ * Trigger a partition detection.
  */
 void
-dasd_setup_partitions(struct dasd_device * device)
+dasd_scan_partitions(struct dasd_device * device)
 {
+	struct block_device *bdev;
+
 	/* Make the disk known. */
 	set_capacity(device->gdp, device->blocks << device->s2b_shift);
-	device->gdp->queue = device->request_queue;
-	if (device->ro_flag)
-		set_disk_ro(device->gdp, 1);
-	add_disk(device->gdp);
+	/* See fs/partition/check.c:register_disk,rescan_partitions */
+	bdev = bdget_disk(device->gdp, 0);
+	if (bdev) {
+		if (blkdev_get(bdev, FMODE_READ, 1, BDEV_RAW) >= 0) {
+			/* Can't call rescan_partitions directly. Use ioctl. */
+			ioctl_by_bdev(bdev, BLKRRPART, 0);
+			blkdev_put(bdev, BDEV_RAW);
+		}
+	}
 }
 
 /*
- * Remove all inodes in the system for a device and make the
- * partitions unusable by setting their size to zero.
+ * Remove all inodes in the system for a device, delete the
+ * partitions and make device unusable by setting its size to zero.
  */
 void
 dasd_destroy_partitions(struct dasd_device * device)
 {
-	del_gendisk(device->gdp);
+	int p;
+
+	for (p = device->gdp->minors - 1; p > 0; p--) {
+		invalidate_partition(device->gdp, p);
+		delete_partition(device->gdp, p);
+	}
+	invalidate_partition(device->gdp, 0);
+	set_capacity(device->gdp, 0);
 }
 
 int
@@ -208,11 +223,13 @@
 
 	/* Register to static dasd major 94 */
 	rc = dasd_register_major(DASD_MAJOR);
-	if (rc != 0)
+	if (rc != 0) {
 		MESSAGE(KERN_WARNING,
 			"Couldn't register successfully to "
 			"major no %d", DASD_MAJOR);
-	return rc;
+		return rc;
+	}
+	return 0;
 }
 
 void
diff -urN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-s390/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	Mon Sep  8 21:50:18 2003
+++ linux-2.6-s390/drivers/s390/block/dasd_int.h	Thu Sep 11 19:21:26 2003
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.42 $
+ * $Revision: 1.44 $
  */
 
 #ifndef DASD_INT_H
@@ -29,14 +29,13 @@
  * Things to do for startup state transitions:
  *   new -> known: find discipline for the device and create devfs entries.
  *   known -> basic: request irq line for the device.
- *   basic -> accept: do the initial analysis, e.g. format detection.
- *   accept-> ready: do block device setup and detect partitions.
+ *   basic -> ready: do the initial analysis, e.g. format detection,
+ *                   do block device setup and detect partitions.
  *   ready -> online: schedule the device tasklet.
  * Things to do for shutdown state transitions:
  *   online -> ready: just set the new device state.
- *   ready -> accept: flush requests from the block device layer and
- *                    clear partition information.
- *   accept -> basic: reset format information.
+ *   ready -> basic: flush requests from the block device layer, clear
+ *                   partition information and reset format information.
  *   basic -> known: terminate all requests and free irq.
  *   known -> new: remove devfs entries and forget discipline.
  */
@@ -44,9 +43,8 @@
 #define DASD_STATE_NEW	  0
 #define DASD_STATE_KNOWN  1
 #define DASD_STATE_BASIC  2
-#define DASD_STATE_ACCEPT 3
-#define DASD_STATE_READY  4
-#define DASD_STATE_ONLINE 5
+#define DASD_STATE_READY  3
+#define DASD_STATE_ONLINE 4
 
 #include <linux/module.h>
 #include <linux/version.h>
@@ -137,8 +135,7 @@
 /* messages to be written via klogd and dbf */
 #define DEV_MESSAGE(d_loglevel,d_device,d_string,d_args...)\
 do { \
-	printk(d_loglevel PRINTK_HEADER " %s,%s: " \
-	       d_string "\n", d_device->gdp->disk_name, \
+	printk(d_loglevel PRINTK_HEADER " %s: " d_string "\n", \
 	       d_device->cdev->dev.bus_id, d_args); \
 	DBF_DEV_EVENT(DBF_ALERT, d_device, d_string, d_args); \
 } while(0)
@@ -265,6 +262,7 @@
 	struct gendisk *gdp;
 	request_queue_t *request_queue;
 	spinlock_t request_queue_lock;
+        unsigned int devindex;
 	unsigned long blocks;		/* size of volume in blocks */
 	unsigned int bp_block;		/* bytes per block */
 	unsigned int s2b_shift;		/* log2 (bp_block/512) */
@@ -441,7 +439,7 @@
 	return set_normalized_cda(ccw, cda);
 }
 
-struct dasd_device *dasd_alloc_device(unsigned int devindex);
+struct dasd_device *dasd_alloc_device(void);
 void dasd_free_device(struct dasd_device *);
 
 void dasd_enable_device(struct dasd_device *);
@@ -485,9 +483,9 @@
 /* externals in dasd_gendisk.c */
 int  dasd_gendisk_init(void);
 void dasd_gendisk_exit(void);
-int  dasd_gendisk_index_major(int);
-struct gendisk *dasd_gendisk_alloc(int);
-void dasd_setup_partitions(struct dasd_device *);
+int dasd_gendisk_alloc(struct dasd_device *);
+void dasd_gendisk_free(struct dasd_device *);
+void dasd_scan_partitions(struct dasd_device *);
 void dasd_destroy_partitions(struct dasd_device *);
 
 /* externals in dasd_ioctl.c */
diff -urN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-s390/drivers/s390/block/dasd_ioctl.c
--- linux-2.6/drivers/s390/block/dasd_ioctl.c	Mon Sep  8 21:50:07 2003
+++ linux-2.6-s390/drivers/s390/block/dasd_ioctl.c	Thu Sep 11 19:21:26 2003
@@ -125,8 +125,7 @@
 
 /*
  * Enable device.
- * FIXME: how can we get here if the device is not already enabled?
- * 	-arnd
+ * used by dasdfmt after BIODASDDISABLE to retrigger blocksize detection
  */
 static int
 dasd_ioctl_enable(struct block_device *bdev, int no, long args)
@@ -139,6 +138,10 @@
 	if (device == NULL)
 		return -ENODEV;
 	dasd_enable_device(device);
+	/* Formatting the dasd device can change the capacity. */
+	down(&bdev->bd_sem);
+	i_size_write(bdev->bd_inode, (loff_t)get_capacity(device->gdp) << 9);
+	up(&bdev->bd_sem);
 	return 0;
 }
 
diff -urN linux-2.6/drivers/s390/block/dasd_proc.c linux-2.6-s390/drivers/s390/block/dasd_proc.c
--- linux-2.6/drivers/s390/block/dasd_proc.c	Mon Sep  8 21:49:57 2003
+++ linux-2.6-s390/drivers/s390/block/dasd_proc.c	Thu Sep 11 19:21:26 2003
@@ -9,7 +9,7 @@
  *
  * /proc interface for the dasd driver.
  *
- * $Revision: 1.21 $
+ * $Revision: 1.22 $
  */
 
 #include <linux/config.h>
@@ -66,10 +66,16 @@
 	else
 		seq_printf(m, "(none)");
 	/* Print kdev. */
-	seq_printf(m, " at (%3d:%3d)",
-		   device->gdp->major, device->gdp->first_minor);
+	if (device->gdp)
+		seq_printf(m, " at (%3d:%3d)",
+			   device->gdp->major, device->gdp->first_minor);
+	else
+		seq_printf(m, "  at (???:???)");
 	/* Print device name. */
-	seq_printf(m, " is %-7s", device->gdp->disk_name);
+	if (device->gdp)
+		seq_printf(m, " is %-7s", device->gdp->disk_name);
+	else
+		seq_printf(m, " is ???????");
 	/* Print devices features. */
 	substr = device->ro_flag ? "(ro)" : " ";
 	seq_printf(m, "%4s: ", substr);
@@ -87,9 +93,6 @@
 	case DASD_STATE_BASIC:
 		seq_printf(m, "basic");
 		break;
-	case DASD_STATE_ACCEPT:
-		seq_printf(m, "accepted");
-		break;
 	case DASD_STATE_READY:
 	case DASD_STATE_ONLINE:
 		seq_printf(m, "active ");
