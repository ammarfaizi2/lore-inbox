Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264122AbUCZSYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264120AbUCZSX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:23:57 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:55285 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S264121AbUCZSUK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:20:10 -0500
Date: Fri, 26 Mar 2004 19:19:55 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (2/7): dasd driver.
Message-ID: <20040326181955.GC2523@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dasd device driver changes:
 - After a state change interrupt restart all running i/o on queue
   and reset device timer.
 - Improve some debug messages.
 - Lower timeout of reserve/release/steal_lock to 2 seconds.
 - Fix BIODASDPSRD ioctl.
 - Replace ro_flag, use_diag_flag and disconnect_error_flag words by bits.
 - Use BLKPG_DEL_PARTITION ioctl instead of a call to delete_partition because
   delete_partition is not an exported function. Since dasd_destroy_partitions
   can't do blkdev_get because dasd_open would fail, keep the block device
   open as long as partitions exist. This in turn requires a different
   approach to the open vs. offline race.

diffstat:
 drivers/s390/block/dasd.c          |  108 +++++++++++++++++++++----------------
 drivers/s390/block/dasd_3990_erp.c |   22 ++++---
 drivers/s390/block/dasd_devmap.c   |   19 ++++--
 drivers/s390/block/dasd_eckd.c     |    9 +--
 drivers/s390/block/dasd_genhd.c    |   62 +++++++++++++++------
 drivers/s390/block/dasd_int.h      |   15 +++--
 drivers/s390/block/dasd_ioctl.c    |   11 ++-
 drivers/s390/block/dasd_proc.c     |    4 -
 8 files changed, 158 insertions(+), 92 deletions(-)

diff -urN linux-2.6/drivers/s390/block/dasd.c linux-2.6-s390/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	Fri Mar 26 18:24:55 2004
+++ linux-2.6-s390/drivers/s390/block/dasd.c	Fri Mar 26 18:25:13 2004
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.133 $
+ * $Revision: 1.136 $
  */
 
 #include <linux/config.h>
@@ -224,7 +224,8 @@
 		return rc;
 	dasd_setup_queue(device);
 	device->state = DASD_STATE_READY;
-	dasd_scan_partitions(device);
+	if (dasd_scan_partitions(device) != 0)
+		device->state = DASD_STATE_BASIC;
 	return 0;
 }
 
@@ -687,7 +688,10 @@
 		rc = ccw_device_clear(device->cdev, (long) cqr);
 		switch (rc) {
 		case 0:	/* termination successful */
-			cqr->status = DASD_CQR_FAILED;
+			if (cqr->retries > 0) 
+				cqr->status = DASD_CQR_QUEUED;
+			else 
+				cqr->status = DASD_CQR_FAILED;
 			cqr->stopclk = get_clock();
 			break;
 		case -ENODEV:
@@ -779,7 +783,7 @@
 
 	device = (struct dasd_device *) ptr;
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
-	/* re-activate first request in queue */
+	/* re-activate request queue */
         device->stopped &= ~DASD_STOPPED_PENDING;
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 	dasd_schedule_bh(device);
@@ -827,12 +831,25 @@
 		struct dasd_device *device;
 	} *p;
 	struct dasd_device *device;
+	struct dasd_ccw_req *cqr;
+	struct list_head *l, *n;
+	unsigned long flags;
 
 	p = data;
 	device = p->device;
 	DBF_EVENT(DBF_NOTICE, "State change Interrupt for bus_id %s",
 		  device->cdev->dev.bus_id);
 	device->stopped &= ~DASD_STOPPED_PENDING;
+
+        /* restart all 'running' IO on queue */
+	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
+	list_for_each_safe(l, n, &device->ccw_queue) {
+		cqr = list_entry(l, struct dasd_ccw_req, list);
+                if (cqr->status == DASD_CQR_IN_IO) 
+                        cqr->status = DASD_CQR_QUEUED;
+        }
+	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+	dasd_set_timer (device, 0);
 	dasd_schedule_bh(device);
 	dasd_put_device(device);
 	kfree(p);
@@ -847,7 +864,8 @@
 	cqr = (struct dasd_ccw_req *) intparm;
 	if (cqr->status != DASD_CQR_IN_IO) {
 		MESSAGE(KERN_DEBUG,
-			"invalid status: bus_id %s, status %02x",
+			"invalid status in handle_killed_request: "
+			"bus_id %s, status %02x",
 			cdev->dev.bus_id, cqr->status);
 		return;
 	}
@@ -1142,7 +1160,8 @@
 	       elv_next_request(queue) &&
 		nr_queued < DASD_CHANQ_MAX_SIZE) {
 		req = elv_next_request(queue);
-		if (device->ro_flag && rq_data_dir(req) == WRITE) {
+		if (test_bit(DASD_FLAG_RO, &device->flags) &&
+		    rq_data_dir(req) == WRITE) {
 			DBF_EVENT(DBF_ERR,
 				  "(%s) Rejecting write request %p",
 				  device->cdev->dev.bus_id,
@@ -1186,13 +1205,11 @@
 __dasd_check_expire(struct dasd_device * device)
 {
 	struct dasd_ccw_req *cqr;
-	unsigned long long now;
 
 	if (list_empty(&device->ccw_queue))
 		return;
 	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
 	if (cqr->status == DASD_CQR_IN_IO && cqr->expires != 0) {
-		now = get_clock();
 		if (time_after_eq(jiffies, cqr->expires + cqr->starttime)) {
 			if (device->discipline->term_IO(cqr) != 0)
 				/* Hmpf, try again in 1/100 sec */
@@ -1517,7 +1534,8 @@
  * terminated if it is currently in i/o.
  * Returns 1 if the request has been terminated.
  */
-int dasd_cancel_req(struct dasd_ccw_req *cqr)
+int 
+dasd_cancel_req(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device = cqr->device;
 	unsigned long flags;
@@ -1655,18 +1673,13 @@
 {
 	struct gendisk *disk = inp->i_bdev->bd_disk;
 	struct dasd_device *device = disk->private_data;
-	int old_count, rc;
+	int rc;
 
-	/*
-	 * We use a negative value in open_count to indicate that
-	 * the device must not be used.
-	 */
-	do {
-		old_count = atomic_read(&device->open_count);
-		if (old_count < 0)
-			return -ENODEV;
-	} while (atomic_compare_and_swap(old_count, old_count + 1,
-					 &device->open_count));
+        atomic_inc(&device->open_count);
+	if (test_bit(DASD_FLAG_OFFLINE, &device->flags)) {
+		rc = -ENODEV;
+		goto unlock;
+	}
 
 	if (!try_module_get(device->discipline->owner)) {
 		rc = -EINVAL;
@@ -1681,7 +1694,6 @@
 		goto out;
 	}
 
-	rc = -ENODEV;
 	if (device->state < DASD_STATE_BASIC) {
 		DBF_DEV_EVENT(DBF_ERR, device, " %s",
 			      " Cannot open unrecognized device");
@@ -1704,12 +1716,6 @@
 	struct gendisk *disk = inp->i_bdev->bd_disk;
 	struct dasd_device *device = disk->private_data;
 
-	if (device->state < DASD_STATE_BASIC) {
-		DBF_DEV_EVENT(DBF_ERR, device, " %s",
-			      " Cannot release unrecognized device");
-		return -EINVAL;
-	}
-
 	atomic_dec(&device->open_count);
 	module_put(device->discipline->owner);
 	return 0;
@@ -1773,17 +1779,21 @@
 
 	dasd_remove_sysfs_files(cdev);
 	device = dasd_device_from_cdev(cdev);
-	if (!IS_ERR(device)) {
-		/*
-		 * This device is removed unconditionally. Set open_count
-		 * to -1 to prevent dasd_open from opening it while it is
-		 * no quite down yet.
-		 */
-		atomic_set(&device->open_count,-1);
-		dasd_set_target_state(device, DASD_STATE_NEW);
-		/* dasd_delete_device destroys the device reference. */
-		dasd_delete_device(device);
+	if (IS_ERR(device))
+		return;
+	if (test_and_set_bit(DASD_FLAG_OFFLINE, &device->flags)) {
+		/* Already doing offline processing */
+		dasd_put_device(device);
+		return;
 	}
+	/*
+	 * This device is removed unconditionally. Set offline
+	 * flag to prevent dasd_open from opening it while it is
+	 * no quite down yet.
+	 */
+	dasd_set_target_state(device, DASD_STATE_NEW);
+	/* dasd_delete_device destroys the device reference. */
+	dasd_delete_device(device);
 }
 
 /* activate a device. This is called from dasd_{eckd,fba}_probe() when either
@@ -1801,7 +1811,7 @@
 	if (IS_ERR(device))
 		return PTR_ERR(device);
 
-	if (device->use_diag_flag) {
+	if (test_bit(DASD_FLAG_USE_DIAG, &device->flags)) {
 	  	if (!dasd_diag_discipline_pointer) {
 		        printk (KERN_WARNING
 				"dasd_generic couldn't online device %s "
@@ -1849,18 +1859,28 @@
 dasd_generic_set_offline (struct ccw_device *cdev)
 {
 	struct dasd_device *device;
+	int max_count;
 
 	device = dasd_device_from_cdev(cdev);
+	if (IS_ERR(device))
+		return PTR_ERR(device);
+	if (test_and_set_bit(DASD_FLAG_OFFLINE, &device->flags)) {
+		/* Already doing offline processing */
+		dasd_put_device(device);
+		return 0;
+	}
 	/*
-	 * We must make sure that this device is currently not in use
-	 * (current open_count == 0 ). We set open_count to -1 to indicate
-	 * that from now on set_offline is in progress and the device must
-	 * not be used otherwise.
+	 * We must make sure that this device is currently not in use.
+	 * The open_count is increased for every opener, that includes
+	 * the blkdev_get in dasd_scan_partitions. We are only interested
+	 * in the other openers.
 	 */
-	if (atomic_compare_and_swap(0, -1, &device->open_count)) {
+	max_count = device->bdev ? 1 : 0;
+	if (atomic_read(&device->open_count) > max_count) {
 		printk (KERN_WARNING "Can't offline dasd device with open"
 			" count = %i.\n",
 			atomic_read(&device->open_count));
+		clear_bit(DASD_FLAG_OFFLINE, &device->flags);
 		dasd_put_device(device);
 		return -EBUSY;
 	}
@@ -1890,7 +1910,7 @@
 		if (device->state < DASD_STATE_BASIC)
 			break;
 		/* Device is active. We want to keep it. */
-		if (device->disconnect_error_flag) {
+		if (test_bit(DASD_FLAG_DSC_ERROR, &device->flags)) {
 			list_for_each_entry(cqr, &device->ccw_queue, list)
 				if (cqr->status == DASD_CQR_IN_IO)
 					cqr->status = DASD_CQR_FAILED;
diff -urN linux-2.6/drivers/s390/block/dasd_3990_erp.c linux-2.6-s390/drivers/s390/block/dasd_3990_erp.c
--- linux-2.6/drivers/s390/block/dasd_3990_erp.c	Thu Mar 11 03:55:43 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_3990_erp.c	Fri Mar 26 18:25:13 2004
@@ -5,7 +5,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000, 2001
  *
- * $Revision: 1.27 $
+ * $Revision: 1.28 $
  */
 
 #include <linux/timer.h>
@@ -229,7 +229,7 @@
 	struct dasd_device *device = erp->device;
 
 	DEV_MESSAGE(KERN_INFO, device,
-		    "blocking request queue for %is", expires);
+		    "blocking request queue for %is", expires/HZ);
 
 	device->stopped |= DASD_STOPPED_PENDING;
 	erp->status = DASD_CQR_QUEUED;
@@ -2623,7 +2623,7 @@
 
 #ifdef ERP_DEBUG
 	/* print current erp_chain */
-	DEV_MESSAGE(KERN_DEBUG, device, "%s",
+	DEV_MESSAGE(KERN_ERR, device, "%s",
 		    "ERP chain at BEGINNING of ERP-ACTION");
 	{
 		struct dasd_ccw_req *temp_erp = NULL;
@@ -2631,9 +2631,10 @@
 		for (temp_erp = cqr;
 		     temp_erp != NULL; temp_erp = temp_erp->refers) {
 
-			DEV_MESSAGE(KERN_DEBUG, device,
-				    "	   erp %p refers to %p",
-				    temp_erp, temp_erp->refers);
+			DEV_MESSAGE(KERN_ERR, device,
+				    "   erp %p (%02x) refers to %p",
+				    temp_erp, temp_erp->status, 
+				    temp_erp->refers);
 		}
 	}
 #endif				/* ERP_DEBUG */
@@ -2675,15 +2676,16 @@
 
 #ifdef ERP_DEBUG
 	/* print current erp_chain */
-	DEV_MESSAGE(KERN_DEBUG, device, "%s", "ERP chain at END of ERP-ACTION");
+	DEV_MESSAGE(KERN_ERR, device, "%s", "ERP chain at END of ERP-ACTION");
 	{
 		struct dasd_ccw_req *temp_erp = NULL;
 		for (temp_erp = erp;
 		     temp_erp != NULL; temp_erp = temp_erp->refers) {
 
-			DEV_MESSAGE(KERN_DEBUG, device,
-				    "	   erp %p refers to %p",
-				    temp_erp, temp_erp->refers);
+			DEV_MESSAGE(KERN_ERR, device,
+				    "   erp %p (%02x) refers to %p",
+				    temp_erp, temp_erp->status, 
+				    temp_erp->refers);
 		}
 	}
 #endif				/* ERP_DEBUG */
diff -urN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-s390/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	Fri Mar 26 18:24:55 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_devmap.c	Fri Mar 26 18:25:13 2004
@@ -11,7 +11,7 @@
  * functions may not be called from interrupt context. In particular
  * dasd_get_device is a no-no from interrupt context.
  *
- * $Revision: 1.26 $
+ * $Revision: 1.27 $
  */
 
 #include <linux/config.h>
@@ -466,10 +466,14 @@
 	if (!devmap->device) {
 		devmap->device = device;
 		device->devindex = devmap->devindex;
-		device->ro_flag = 
-			(devmap->features & DASD_FEATURE_READONLY) != 0;
-		device->use_diag_flag = 
-			(devmap->features & DASD_FEATURE_USEDIAG) != 0;
+		if (devmap->features & DASD_FEATURE_READONLY)
+			set_bit(DASD_FLAG_RO, &device->flags);
+		else
+			clear_bit(DASD_FLAG_RO, &device->flags);
+		if (devmap->features & DASD_FEATURE_USEDIAG)
+			set_bit(DASD_FLAG_USE_DIAG, &device->flags);
+		else
+			clear_bit(DASD_FLAG_USE_DIAG, &device->flags);
 		get_device(&cdev->dev);
 		device->cdev = cdev;
 		rc = 0;
@@ -596,7 +600,10 @@
 	if (devmap->device) {
 		if (devmap->device->gdp)
 			set_disk_ro(devmap->device->gdp, ro_flag);
-		devmap->device->ro_flag = ro_flag;
+		if (ro_flag)
+			set_bit(DASD_FLAG_RO, &devmap->device->flags);
+		else
+			clear_bit(DASD_FLAG_RO, &devmap->device->flags);
 	}
 	spin_unlock(&dasd_devmap_lock);
 	return count;
diff -urN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	Thu Mar 11 03:55:20 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_eckd.c	Fri Mar 26 18:25:13 2004
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.51 $
+ * $Revision: 1.53 $
  */
 
 #include <linux/config.h>
@@ -1131,7 +1131,7 @@
 	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
 	cqr->device = device;
 	cqr->retries = 0;
-	cqr->expires = 10 * HZ;
+	cqr->expires = 2 * HZ;
 	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
 
@@ -1174,7 +1174,7 @@
 	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
 	cqr->device = device;
 	cqr->retries = 0;
-	cqr->expires = 10 * HZ;
+	cqr->expires = 2 * HZ;
 	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
 
@@ -1216,7 +1216,7 @@
 	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
 	cqr->device = device;
 	cqr->retries = 0;
-	cqr->expires = 10 * HZ;
+	cqr->expires = 2 * HZ;
 	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
 
@@ -1274,6 +1274,7 @@
 	stats = (struct dasd_rssd_perf_stats_t *) (prssdp + 1);
 	memset(stats, 0, sizeof (struct dasd_rssd_perf_stats_t));
 
+	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof (struct dasd_rssd_perf_stats_t);
 	ccw->cda = (__u32)(addr_t) stats;
diff -urN linux-2.6/drivers/s390/block/dasd_genhd.c linux-2.6-s390/drivers/s390/block/dasd_genhd.c
--- linux-2.6/drivers/s390/block/dasd_genhd.c	Thu Mar 11 03:55:37 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_genhd.c	Fri Mar 26 18:25:46 2004
@@ -9,7 +9,7 @@
  *
  * gendisk related functions for the dasd driver.
  *
- * $Revision: 1.44 $
+ * $Revision: 1.46 $
  */
 
 #include <linux/config.h>
@@ -71,7 +71,7 @@
 
  	sprintf(gdp->devfs_name, "dasd/%s", device->cdev->dev.bus_id);
 
-	if (device->ro_flag)
+	if (test_bit(DASD_FLAG_RO, &device->flags))
 		set_disk_ro(gdp, 1);
 	gdp->private_data = device;
 	gdp->queue = device->request_queue;
@@ -96,22 +96,33 @@
 /*
  * Trigger a partition detection.
  */
-void
+int
 dasd_scan_partitions(struct dasd_device * device)
 {
 	struct block_device *bdev;
 
 	/* Make the disk known. */
 	set_capacity(device->gdp, device->blocks << device->s2b_shift);
-	/* See fs/partition/check.c:register_disk,rescan_partitions */
 	bdev = bdget_disk(device->gdp, 0);
-	if (bdev) {
-		if (blkdev_get(bdev, FMODE_READ, 1) >= 0) {
-			/* Can't call rescan_partitions directly. Use ioctl. */
-			ioctl_by_bdev(bdev, BLKRRPART, 0);
-			blkdev_put(bdev);
-		}
-	}
+	if (!bdev || blkdev_get(bdev, FMODE_READ, 1) < 0)
+		return -ENODEV;
+	/*
+	 * See fs/partition/check.c:register_disk,rescan_partitions
+	 * Can't call rescan_partitions directly. Use ioctl. 
+	 */
+	ioctl_by_bdev(bdev, BLKRRPART, 0);
+	/*
+	 * Since the matching blkdev_put call to the blkdev_get in
+	 * this function is not called before dasd_destroy_partitions
+	 * the offline open_count limit needs to be increased from
+	 * 0 to 1. This is done by setting device->bdev (see 
+	 * dasd_generic_set_offline). As long as the partition
+	 * detection is running no offline should be allowed. That
+	 * is why the assignment to device->bdev is done AFTER
+	 * the BLKRRPART ioctl.
+	 */
+	device->bdev = bdev;
+	return 0;
 }
 
 /*
@@ -121,13 +132,32 @@
 void
 dasd_destroy_partitions(struct dasd_device * device)
 {
-	int p;
+	/* The two structs have 168/176 byte on 31/64 bit. */
+	struct blkpg_partition bpart;
+	struct blkpg_ioctl_arg barg;
+	struct block_device *bdev;
+
+	/*
+	 * Get the bdev pointer from the device structure and clear
+	 * device->bdev to lower the offline open_count limit again.
+	 */
+	bdev = device->bdev;
+	device->bdev = 0;
+
+	/*
+	 * See fs/partition/check.c:delete_partition
+	 * Can't call delete_partitions directly. Use ioctl.
+	 * The ioctl also does locking and invalidation.
+	 */
+	memset(&bpart, sizeof(struct blkpg_partition), 0);
+	memset(&barg, sizeof(struct blkpg_ioctl_arg), 0);
+	barg.data = &bpart;
+	for (bpart.pno = device->gdp->minors - 1; bpart.pno > 0; bpart.pno--)
+		ioctl_by_bdev(bdev, BLKPG_DEL_PARTITION, (unsigned long) &barg);
 
-	for (p = device->gdp->minors - 1; p > 0; p--) {
-		invalidate_partition(device->gdp, p);
-		delete_partition(device->gdp, p);
-	}
 	invalidate_partition(device->gdp, 0);
+	/* Matching blkdev_put to the blkdev_get in dasd_scan_partitions. */
+	blkdev_put(bdev);
 	set_capacity(device->gdp, 0);
 }
 
diff -urN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-s390/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	Fri Mar 26 18:24:55 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_int.h	Fri Mar 26 18:25:13 2004
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.55 $
+ * $Revision: 1.56 $
  */
 
 #ifndef DASD_INT_H
@@ -268,14 +268,12 @@
 	struct gendisk *gdp;
 	request_queue_t *request_queue;
 	spinlock_t request_queue_lock;
+	struct block_device *bdev;
         unsigned int devindex;
 	unsigned long blocks;		/* size of volume in blocks */
 	unsigned int bp_block;		/* bytes per block */
 	unsigned int s2b_shift;		/* log2 (bp_block/512) */
-	int ro_flag;			/* read-only flag */
-	int use_diag_flag;		/* diag allowed flag */
-	int disconnect_error_flag;	/* return -EIO when disconnected */
-
+	unsigned long flags;		/* per device flags */
 
 	/* Device discipline stuff. */
 	struct dasd_discipline *discipline;
@@ -318,6 +316,11 @@
 #define DASD_STOPPED_DC_WAIT 8         /* disconnected, wait */
 #define DASD_STOPPED_DC_EIO  16        /* disconnected, return -EIO */
 
+/* per device flags */
+#define DASD_FLAG_RO		0	/* device is read-only */
+#define DASD_FLAG_USE_DIAG	1	/* use diag disciplnie */
+#define DASD_FLAG_DSC_ERROR	2	/* return -EIO when disconnected */
+#define DASD_FLAG_OFFLINE	3	/* device is in offline processing */
 
 void dasd_put_device_wake(struct dasd_device *);
 
@@ -498,7 +501,7 @@
 void dasd_gendisk_exit(void);
 int dasd_gendisk_alloc(struct dasd_device *);
 void dasd_gendisk_free(struct dasd_device *);
-void dasd_scan_partitions(struct dasd_device *);
+int dasd_scan_partitions(struct dasd_device *);
 void dasd_destroy_partitions(struct dasd_device *);
 
 /* externals in dasd_ioctl.c */
diff -urN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-s390/drivers/s390/block/dasd_ioctl.c
--- linux-2.6/drivers/s390/block/dasd_ioctl.c	Thu Mar 11 03:55:29 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_ioctl.c	Fri Mar 26 18:25:13 2004
@@ -303,7 +303,7 @@
 
 	if (device == NULL)
 		return -ENODEV;
-	if (device->ro_flag)
+	if (test_bit(DASD_FLAG_RO, &device->flags))
 		return -EROFS;
 	if (copy_from_user(&fdata, (void *) args,
 			   sizeof (struct format_data_t)))
@@ -415,8 +415,8 @@
 	    (dasd_check_blocksize(device->bp_block)))
 		dasd_info->format = DASD_FORMAT_NONE;
 	
-	dasd_info->features |= device->ro_flag ? DASD_FEATURE_READONLY
-					       : DASD_FEATURE_DEFAULT;
+	dasd_info->features |= test_bit(DASD_FLAG_RO, &device->flags) ?
+		DASD_FEATURE_READONLY : DASD_FEATURE_DEFAULT;
 
 	if (device->discipline)
 		memcpy(dasd_info->type, device->discipline->name, 4);
@@ -472,7 +472,10 @@
 	if (device == NULL)
 		return -ENODEV;
 	set_disk_ro(bdev->bd_disk, intval);
-	device->ro_flag = intval;
+	if (intval)
+		set_bit(DASD_FLAG_RO, &device->flags);
+	else
+		clear_bit(DASD_FLAG_RO, &device->flags);
 	return 0;
 }
 
diff -urN linux-2.6/drivers/s390/block/dasd_proc.c linux-2.6-s390/drivers/s390/block/dasd_proc.c
--- linux-2.6/drivers/s390/block/dasd_proc.c	Thu Mar 11 03:55:23 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_proc.c	Fri Mar 26 18:25:13 2004
@@ -9,7 +9,7 @@
  *
  * /proc interface for the dasd driver.
  *
- * $Revision: 1.26 $
+ * $Revision: 1.27 $
  */
 
 #include <linux/config.h>
@@ -77,7 +77,7 @@
 	else
 		seq_printf(m, " is ????????");
 	/* Print devices features. */
-	substr = device->ro_flag ? "(ro)" : " ";
+	substr = test_bit(DASD_FLAG_RO, &device->flags) ? "(ro)" : " ";
 	seq_printf(m, "%4s: ", substr);
 	/* Print device status information. */
 	switch ((device != NULL) ? device->state : -1) {
