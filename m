Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261717AbTCZPMi>; Wed, 26 Mar 2003 10:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261738AbTCZPM1>; Wed, 26 Mar 2003 10:12:27 -0500
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:17577 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261717AbTCZPHu> convert rfc822-to-8bit; Wed, 26 Mar 2003 10:07:50 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 update (8/9): dasd driver reference counting.
Date: Wed, 26 Mar 2003 16:14:33 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303261614.33967.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Improve reference counting.
* Remove devno from struct dasd_device.
* Remove unnecessary bdget/bdput calls.

diffstat:
 dasd.c        |  148 +++++++++++++++------------------------------
 dasd_devmap.c |  188 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 dasd_diag.c   |   10 +--
 dasd_genhd.c  |    9 --
 dasd_int.h    |   51 +++++++--------
 dasd_ioctl.c  |    2 
 dasd_proc.c   |   11 +--
 7 files changed, 244 insertions(+), 175 deletions(-)

diff -urN linux-2.5.66/drivers/s390/block/dasd.c linux-2.5.66-s390/drivers/s390/block/dasd.c
--- linux-2.5.66/drivers/s390/block/dasd.c	Wed Mar 26 15:45:19 2003
+++ linux-2.5.66-s390/drivers/s390/block/dasd.c	Wed Mar 26 15:45:19 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.81 $
+ * $Revision: 1.82 $
  *
  * History of changes (starts July 2000)
  * 11/09/00 complete redesign after code review
@@ -101,7 +101,7 @@
  * Allocate memory for a new device structure.
  */
 dasd_device_t *
-dasd_alloc_device(dasd_devmap_t *devmap)
+dasd_alloc_device(unsigned int devindex)
 {
 	dasd_device_t *device;
 	struct gendisk *gdp;
@@ -111,8 +111,6 @@
 		return ERR_PTR(-ENOMEM);
 	memset(device, 0, sizeof (dasd_device_t));
 
-	device->devno = devmap->devno;
-
 	/* Get two pages for normal block device operations. */
 	device->ccw_mem = (void *) __get_free_pages(GFP_ATOMIC | GFP_DMA, 1);
 	if (device->ccw_mem == NULL) {
@@ -128,7 +126,7 @@
 	}
 
 	/* Allocate gendisk structure for device. */
-	gdp = dasd_gendisk_alloc(devmap->devindex);
+	gdp = dasd_gendisk_alloc(devindex);
 	if (IS_ERR(gdp)) {
 		free_page((unsigned long) device->erp_mem);
 		free_pages((unsigned long) device->ccw_mem, 1);
@@ -147,7 +145,7 @@
 		     (unsigned long) device);
 	INIT_LIST_HEAD(&device->ccw_queue);
 	init_timer(&device->timer);
-	INIT_WORK(&device->kick_work, do_kick_device, (void *) (addr_t) device->devno);
+	INIT_WORK(&device->kick_work, do_kick_device, device);
 	device->state = DASD_STATE_NEW;
 	device->target = DASD_STATE_NEW;
 
@@ -174,22 +172,19 @@
 static inline int
 dasd_state_new_to_known(dasd_device_t *device)
 {
-	dasd_devmap_t *devmap;
 	umode_t devfs_perm;
-	int major, minor;
+	kdev_t kdev;
 	char buf[20];
 
-	/* Increase reference count of bdev. */
-	if (bdget(MKDEV(device->gdp->major, device->gdp->first_minor)) == NULL)
+	kdev = dasd_get_kdev(device);
+	if (kdev_none(kdev))
 		return -ENODEV;
 
-	devmap = dasd_devmap_from_devno(device->devno);
-	if (devmap == NULL)
-		return -ENODEV;
-	major = dasd_gendisk_index_major(devmap->devindex);
-	if (major < 0)
-		return -ENODEV;
-	minor = devmap->devindex % DASD_PER_MAJOR;
+	/*
+	 * As long as the device is not in state DASD_STATE_NEW we want to 
+	 * keep the reference count > 0.
+	 */
+	dasd_get_device(device);
 
 #ifdef CONFIG_DEVFS_FS
 	/* Add a proc directory and the dasd device entry to devfs. */
@@ -201,9 +196,11 @@
 	else
 		devfs_perm = S_IFBLK | S_IRUSR | S_IWUSR;
 
-	snprintf(buf, sizeof(buf), "dasd/%04x/device", device->devno);
+	snprintf(buf, sizeof(buf), "dasd/%04x/device",
+		 _ccw_device_get_device_number(device->cdev));
 	device->devfs_entry = devfs_register(NULL, buf, 0,
-					     major, minor << DASD_PARTN_BITS,
+					     major(kdev),
+					     minor(kdev) << DASD_PARTN_BITS,
 					     devfs_perm,
 					     &dasd_device_operations, NULL);
 	device->state = DASD_STATE_KNOWN;
@@ -216,8 +213,6 @@
 static inline void
 dasd_state_known_to_new(dasd_device_t * device)
 {
-	struct block_device *bdev;
-
 	/* Remove device entry and devfs directory. */
 	devfs_unregister(device->devfs_entry);
 	devfs_unregister(device->gdp->de);
@@ -226,10 +221,8 @@
 	device->discipline = NULL;
 	device->state = DASD_STATE_NEW;
 
-	/* Decrease reference count of bdev. */
-	bdev = bdget(MKDEV(device->gdp->major, device->gdp->first_minor));
-	bdput(bdev);
-	bdput(bdev);
+	/* Give up reference we took in dasd_state_new_to_known. */
+	dasd_put_device(device);
 }
 
 /*
@@ -429,7 +422,8 @@
         if (rc && rc != -EAGAIN) {
 		if (rc != -ENODEV)
 			MESSAGE (KERN_INFO, "giving up on dasd device with "
-				 "devno %04x", device->devno);
+				 "devno %04x",
+				 _ccw_device_get_device_number(device->cdev));
                 device->target = device->state;
         }
 
@@ -446,26 +440,18 @@
 static void
 do_kick_device(void *data)
 {
-	int devno;
-	dasd_devmap_t *devmap;
 	dasd_device_t *device;
 
-	devno = (long) data;
-	devmap = dasd_devmap_from_devno(devno);
-	device = (devmap != NULL) ?
-		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
-	if (IS_ERR(device))
-		return;
-	atomic_dec(&device->ref_count);
+	device = (dasd_device_t *) data;
 	dasd_change_state(device);
 	dasd_schedule_bh(device);
-	dasd_put_device(devmap);
+	dasd_put_device(device);
 }
 
 void
 dasd_kick_device(dasd_device_t *device)
 {
-	atomic_inc(&device->ref_count);
+	dasd_get_device(device);
 	/* queue call to dasd_kick_device to the kernel event daemon. */
 	schedule_work(&device->kick_work);
 }
@@ -647,7 +633,7 @@
 	}
 	strncpy((char *) &cqr->magic, magic, 4);
 	ASCEBC((char *) &cqr->magic, 4);
-	atomic_inc(&device->ref_count);
+	dasd_get_device(device);
 	return cqr;
 }
 
@@ -694,7 +680,7 @@
 	}
 	strncpy((char *) &cqr->magic, magic, 4);
 	ASCEBC((char *) &cqr->magic, 4);
-	atomic_inc(&device->ref_count);
+	dasd_get_device(device);
 	return cqr;
 }
 
@@ -724,7 +710,7 @@
 	if (cqr->data != NULL)
 		kfree(cqr->data);
 	kfree(cqr);
-	atomic_dec(&device->ref_count);
+	dasd_put_device(device);
 }
 
 void
@@ -739,7 +725,7 @@
 	spin_lock_irqsave(&device->mem_lock, flags);
 	dasd_free_chunk(&device->ccw_chunks, cqr);
 	spin_unlock_irqrestore(&device->mem_lock, flags);
-	atomic_dec(&device->ref_count);
+	dasd_put_device(device);
 }
 
 /*
@@ -937,19 +923,14 @@
 		struct work_struct work;
 		dasd_device_t *device;
 	} *p;
-	dasd_devmap_t *devmap;
 	dasd_device_t *device;
 	dasd_ccw_req_t *cqr;
-	int devno;
 
 	p = data;
 	device = p->device;
 	DBF_EVENT(DBF_NOTICE, "State change Interrupt for bus_id %s",
 		  device->cdev->dev.bus_id);
 
-	// FIXME: get rid of devmap.
-	devno = _ccw_device_get_device_number(device->cdev);
-	devmap = dasd_devmap_from_devno(devno);
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	/* re-activate first request in queue */
 	if (!list_empty(&device->ccw_queue)) {
@@ -966,7 +947,7 @@
 	}
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	dasd_schedule_bh(device);
-	dasd_put_device(devmap);
+	dasd_put_device(device);
 	kfree(p);
 }
 
@@ -1014,8 +995,7 @@
 		return;
 	INIT_WORK(&p->work, (void *) do_state_change_pending, p);
 	p->device = device;
-	atomic_inc(&device->ref_count);
-	/* queue call to do_state_change_pending to the kernel event daemon. */
+	dasd_get_device(device);
 	schedule_work(&p->work);
 }
 
@@ -1143,7 +1123,6 @@
 		BUG();
 	add_disk_randomness(req->rq_disk);
 	end_that_request_last(req);
-	return;
 }
 
 /*
@@ -1226,7 +1205,6 @@
 __dasd_process_blk_queue(dasd_device_t * device)
 {
 	request_queue_t *queue;
-	struct list_head *l;
 	struct request *req;
 	dasd_ccw_req_t *cqr;
 	int nr_queued;
@@ -1248,11 +1226,9 @@
 		return;
 	nr_queued = 0;
 	/* Now we try to fetch requests from the request queue */
-	list_for_each(l, &device->ccw_queue) {
-		cqr = list_entry(l, dasd_ccw_req_t, list);
+	list_for_each_entry(cqr, &device->ccw_queue, list)
 		if (cqr->status == DASD_CQR_QUEUED)
 			nr_queued++;
-	}
 	while (!blk_queue_plugged(queue) &&
 	       !blk_queue_empty(queue) &&
 		nr_queued < DASD_CHANQ_MAX_SIZE) {
@@ -1260,7 +1236,8 @@
 		if (device->ro_flag && rq_data_dir(req) == WRITE) {
 			DBF_EVENT(DBF_ERR,
 				  "(%04x) Rejecting write request %p",
-				  device->devno, req);
+				  _ccw_device_get_device_number(device->cdev),
+				  req);
 			blkdev_dequeue_request(req);
 			dasd_end_request(req, 0);
 			continue;
@@ -1271,7 +1248,8 @@
 				break;	/* terminate request queue loop */
 			DBF_EVENT(DBF_ERR,
 				  "(%04x) CCW creation failed on request %p",
-				  device->devno, req);
+				  _ccw_device_get_device_number(device->cdev),
+				  req);
 			blkdev_dequeue_request(req);
 			dasd_end_request(req, 0);
 			continue;
@@ -1408,8 +1386,7 @@
 	__dasd_start_head(device);
 	spin_unlock(get_ccwdev_lock(device->cdev));
 	spin_unlock_irq(&device->request_queue_lock);
-	/* FIXME: what if ref_count == 0 && state == DASD_STATE_NEW ?? */
-	atomic_dec(&device->ref_count);
+	dasd_put_device(device);
 }
 
 /*
@@ -1421,7 +1398,7 @@
 	/* Protect against rescheduling. */
 	if (atomic_compare_and_swap (0, 1, &device->tasklet_scheduled))
 		return;
-	atomic_inc(&device->ref_count);
+	dasd_get_device(device);
 	tasklet_hi_schedule(&device->tasklet);
 }
 
@@ -1803,8 +1780,8 @@
 	return 0;
 }
 
-struct
-block_device_operations dasd_device_operations = {
+struct block_device_operations
+dasd_device_operations = {
 	.owner		= THIS_MODULE,
 	.open		= dasd_open,
 	.release	= dasd_release,
@@ -1885,30 +1862,12 @@
 			 dasd_discipline_t *discipline)
 
 {
-	int devno;
-	dasd_devmap_t *devmap;
 	dasd_device_t *device;
 	int rc;
 
-	if (cdev->dev.driver_data != NULL) /* already enabled */
-		return 0;
-
-	devno = _ccw_device_get_device_number(cdev);
-	rc = dasd_add_range(devno, devno, DASD_FEATURE_DEFAULT);
-	if (rc)
-		return rc;
-
-	if (!(devmap = dasd_devmap_from_devno (devno)))
-		return 0; /* device is still disabled -> ignore it */
-
-	if (IS_ERR(device = dasd_get_device(devmap))) {
-		printk (KERN_WARNING "dasd_generic could not get %s\n",
-				cdev->dev.bus_id);
+	device = dasd_create_device(cdev);
+	if (IS_ERR(device))
 		return PTR_ERR(device);
-	}
-
-	device->gdp->driverfs_dev = &cdev->dev;
-	device->cdev = cdev;
 
 	if (device->use_diag_flag)
 		device->discipline = dasd_diag_discipline_pointer;
@@ -1929,7 +1888,7 @@
 	if (rc) {
 		printk (KERN_WARNING "dasd_generic found a bad device %s\n", 
 			cdev->dev.bus_id);
-		dasd_put_device(devmap);
+		dasd_delete_device(device);
 		return rc;
 	}
 
@@ -1940,16 +1899,17 @@
 			cdev->dev.bus_id);
 		rc = -ENODEV;
 		dasd_set_target_state(device, DASD_STATE_NEW);
+		dasd_delete_device(device);
 	} else {
 		pr_debug("dasd_generic device %s found\n",
 				cdev->dev.bus_id);
 		cdev->dev.driver_data = device;
 	}
 
-	dasd_put_device(devmap);
 	/* FIXME: we have to wait for the root device but we don't want
 	 * to wait for each single device but for all at once. */
 	wait_event(dasd_init_waitq, _wait_for_device(device));
+
 	return rc;
 }
 
@@ -1957,21 +1917,16 @@
 dasd_generic_set_offline (struct ccw_device *cdev)
 {
 	dasd_device_t *device;
-	dasd_devmap_t *devmap;
-	int devno;
 
-	devno = _ccw_device_get_device_number(cdev);
 	device = cdev->dev.driver_data;
-	devmap = dasd_devmap_from_devno(devno);
-	if (device == NULL || devmap == NULL)
-		return -ENODEV;
-
-	device = dasd_get_device(devmap);
-	if (IS_ERR(device))
-		return PTR_ERR(device);
-
+	if (atomic_read(&device->open_count) > 0) {
+		printk (KERN_WARNING "Can't offline dasd device with open"
+			" count = %i.\n",
+			atomic_read(&device->open_count));
+		return -EBUSY;
+	}
 	dasd_set_target_state(device, DASD_STATE_NEW);
-	dasd_put_device(devmap);
+	dasd_delete_device(device);
 	
 	return 0;
 }
@@ -1999,8 +1954,7 @@
 			continue;
 		cdev = to_ccwdev(dev);
 		devno = _ccw_device_get_device_number(cdev);
-		if (dasd_autodetect ||
-		    dasd_devmap_from_devno(devno) != 0)
+		if (dasd_autodetect || dasd_devno_in_range(devno) == 0)
 			ccw_device_set_online(cdev);
 		put_device(dev);
 	}
diff -urN linux-2.5.66/drivers/s390/block/dasd_devmap.c linux-2.5.66-s390/drivers/s390/block/dasd_devmap.c
--- linux-2.5.66/drivers/s390/block/dasd_devmap.c	Mon Mar 24 23:00:40 2003
+++ linux-2.5.66-s390/drivers/s390/block/dasd_devmap.c	Wed Mar 26 15:45:19 2003
@@ -11,7 +11,7 @@
  * functions may not be called from interrupt context. In particular
  * dasd_get_device is a no-no from interrupt context.
  *
- * $Revision: 1.11 $
+ * $Revision: 1.12 $
  *
  * History of changes 
  * 05/04/02 split from dasd.c, code restructuring.
@@ -31,6 +31,25 @@
 #include "dasd_int.h"
 
 /*
+ * dasd_devmap_t is used to store the features and the relation
+ * between device number and device index. To find a dasd_devmap_t
+ * that corresponds to a device number of a device index each
+ * dasd_devmap_t is added to two linked lists, one to search by
+ * the device number and one to search by the device index. As
+ * soon as big minor numbers are available the device index list
+ * can be removed since the device number will then be identical
+ * to the device index.
+ */
+typedef struct {
+	struct list_head devindex_list;
+	struct list_head devno_list;
+        unsigned int devindex;
+        unsigned short devno;
+        unsigned short features;
+	dasd_device_t *device;
+} dasd_devmap_t;
+
+/*
  * Parameter parsing functions for dasd= parameter. The syntax is:
  *   <devno>		: (0x)?[0-9a-fA-F]+
  *   <feature>		: ro
@@ -279,6 +298,29 @@
 }
 
 /*
+ * Check if devno has been added to the list of dasd ranges.
+ */
+int
+dasd_devno_in_range(int devno)
+{
+	struct list_head *l;
+	int ret;
+		
+	ret = -ENOENT;
+	spin_lock(&dasd_devmap_lock);
+	/* Find devmap for device with device number devno */
+	list_for_each(l, &dasd_devno_hashlists[devno&255]) {
+		if (list_entry(l, dasd_devmap_t, devno_list)->devno == devno) {
+			/* Found the device. */
+			ret = 0;
+			break;
+		}
+	}
+	spin_unlock(&dasd_devmap_lock);
+	return ret;
+}
+
+/*
  * Forget all about the device numbers added so far.
  * This may only be called at module unload or system shutdown.
  */
@@ -307,7 +349,7 @@
  * Find the devmap structure from a devno. Can be removed as soon
  * as big minors are available.
  */
-dasd_devmap_t *
+static dasd_devmap_t *
 dasd_devmap_from_devno(int devno)
 {
 	struct list_head *l;
@@ -332,7 +374,7 @@
  * Find the devmap for a device by its device index. Can be removed
  * as soon as big minors are available.
  */
-dasd_devmap_t *
+static dasd_devmap_t *
 dasd_devmap_from_devindex(int devindex)
 {
 	struct list_head *l;
@@ -353,60 +395,140 @@
 	return devmap;
 }
 
-/*
- * Find the device structure for device number devno. If it does not
- * exists yet, allocate it. Increase the reference counter in the device
- * structure and return a pointer to it.
- */
 dasd_device_t *
-dasd_get_device(dasd_devmap_t *devmap)
+dasd_device_from_devindex(int devindex)
 {
+	dasd_devmap_t *devmap;
 	dasd_device_t *device;
 
+	devmap = dasd_devmap_from_devindex(devindex);
 	spin_lock(&dasd_devmap_lock);
 	device = devmap->device;
-	if (device != NULL)
-		atomic_inc(&device->ref_count);
+	if (device)
+		dasd_get_device(device);
+	else
+		device = ERR_PTR(-ENODEV);
 	spin_unlock(&dasd_devmap_lock);
-	if (device != NULL)
-		return device;
+	return device;
+}
 
-	device = dasd_alloc_device(devmap);
+/*
+ * Return kdev for a dasd device.
+ */
+kdev_t
+dasd_get_kdev(dasd_device_t *device)
+{
+	dasd_devmap_t *devmap;
+	int major, minor;
+	int devno;
+
+	devno = _ccw_device_get_device_number(device->cdev);
+	devmap = dasd_devmap_from_devno(devno);
+	if (devmap == NULL)
+		return NODEV;
+	major = dasd_gendisk_index_major(devmap->devindex);
+	if (major < 0)
+		return NODEV;
+	minor = devmap->devindex % DASD_PER_MAJOR;
+	return mk_kdev(major, minor);
+}
+
+/*
+ * Create a dasd device structure for cdev.
+ */
+dasd_device_t *
+dasd_create_device(struct ccw_device *cdev)
+{
+	dasd_devmap_t *devmap;
+	dasd_device_t *device;
+	int devno;
+	int rc;
+
+	devno = _ccw_device_get_device_number(cdev);
+	rc = dasd_add_range(devno, devno, DASD_FEATURE_DEFAULT);
+	if (rc)
+		return ERR_PTR(rc);
+
+	if (!(devmap = dasd_devmap_from_devno (devno)))
+		return ERR_PTR(-ENODEV);
+
+	device = dasd_alloc_device(devmap->devindex);
 	if (IS_ERR(device))
 		return device;
+	atomic_set(&device->ref_count, 1);
+	device->ro_flag = (devmap->features & DASD_FEATURE_READONLY) ? 1 : 0;
+	device->use_diag_flag = 1;
 
-	spin_lock(&dasd_devmap_lock);
-	if (devmap->device != NULL) {
+	spin_lock_irq(get_ccwdev_lock(cdev));
+	if (cdev->dev.driver_data == NULL) {
+		get_device(&cdev->dev);
+		cdev->dev.driver_data = device;
+		device->gdp->driverfs_dev = &cdev->dev;
+		device->cdev = cdev;
+		rc = 0;
+	} else
 		/* Someone else was faster. */
+		rc = -EBUSY;
+	spin_unlock_irq(get_ccwdev_lock(cdev));
+	if (rc) {
 		dasd_free_device(device);
-		device = devmap->device;
-	} else
-		devmap->device = device;
-	atomic_inc(&device->ref_count);
-	device->ro_flag = (devmap->features & DASD_FEATURE_READONLY) ? 1 : 0;
-	device->use_diag_flag = 1;
+		return ERR_PTR(rc);
+	}
+	/* Device created successfully. Make it known via devmap. */
+	spin_lock(&dasd_devmap_lock);
+	devmap->device = device;
 	spin_unlock(&dasd_devmap_lock);
+
 	return device;
 }
 
 /*
- * Decrease the reference counter of a devices structure. If the
- * reference counter reaches zero and the device status is
- * DASD_STATE_NEW the device structure is freed. 
+ * Wait queue for dasd_delete_device waits.
+ */
+static DECLARE_WAIT_QUEUE_HEAD(dasd_delete_wq);
+
+/*
+ * Remove a dasd device structure.
  */
 void
-dasd_put_device(dasd_devmap_t *devmap)
+dasd_delete_device(dasd_device_t *device)
 {
-	dasd_device_t *device;
+	struct ccw_device *cdev;
+	dasd_devmap_t *devmap;
+	int devno;
 
+	/* First remove device pointer from devmap. */
+	devno = _ccw_device_get_device_number(device->cdev);
+	devmap = dasd_devmap_from_devno (devno);
 	spin_lock(&dasd_devmap_lock);
-	device = devmap->device;
-	if (atomic_dec_return(&device->ref_count) == 0 &&
-	    device->state == DASD_STATE_NEW) {
-		devmap->device = NULL;
-		dasd_free_device(device);
-	}
+	devmap->device = NULL;
 	spin_unlock(&dasd_devmap_lock);
+
+	/* Wait for reference counter to drop to zero. */
+	atomic_dec(&device->ref_count);
+	wait_event(dasd_delete_wq, atomic_read(&device->ref_count) == 0);
+
+	/* Disconnect dasd_device structure from ccw_device structure. */
+	cdev = device->cdev;
+	device->cdev = NULL;
+	device->gdp->driverfs_dev = NULL;
+	cdev->dev.driver_data = NULL;
+
+	/* Put ccw_device structure. */
+	put_device(&cdev->dev);
+
+	/* Now the device structure can be freed. */
+	dasd_free_device(device);
+}
+
+/*
+ * Reference counter dropped to zero. Wake up waiter
+ * in dasd_delete_device.
+ */
+void
+dasd_put_device_wake(dasd_device_t *device)
+{
+	wake_up(&dasd_delete_wq);
 }
 
 int
diff -urN linux-2.5.66/drivers/s390/block/dasd_diag.c linux-2.5.66-s390/drivers/s390/block/dasd_diag.c
--- linux-2.5.66/drivers/s390/block/dasd_diag.c	Mon Mar 24 22:59:54 2003
+++ linux-2.5.66-s390/drivers/s390/block/dasd_diag.c	Wed Mar 26 15:45:19 2003
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.27 $
+ * $Revision: 1.28 $
  *
  * History of changes
  * 07/13/00 Added fixup sections for diagnoses ans saved some registers
@@ -96,7 +96,7 @@
 	iib = &private->iib;
 	memset(iib, 0, sizeof (diag_init_io_t));
 
-	iib->dev_nr = device->devno;
+	iib->dev_nr = _ccw_device_get_device_number(device->cdev);
 	iib->block_size = blocksize;
 	iib->offset = offset;
 	iib->start_block = 0;
@@ -117,7 +117,7 @@
 	private = (dasd_diag_private_t *) device->private;
 	iib = &private->iib;
 	memset(iib, 0, sizeof (diag_init_io_t));
-	iib->dev_nr = device->devno;
+	iib->dev_nr = _ccw_device_get_device_number(device->cdev);
 	rc = dia250(iib, TERM_BIO);
 	return rc & 3;
 }
@@ -134,7 +134,7 @@
 	private = (dasd_diag_private_t *) device->private;
 	dreq = (dasd_diag_req_t *) cqr->data;
 
-	private->iob.dev_nr = device->devno;
+	private->iob.dev_nr = _ccw_device_get_device_number(device->cdev);
 	private->iob.key = 0;
 	private->iob.flags = 2;	/* do asynchronous io */
 	private->iob.block_count = dreq->block_count;
@@ -252,7 +252,7 @@
 	}
 	/* Read Device Characteristics */
 	rdc_data = (void *) &(private->rdc_data);
-	rdc_data->dev_nr = device->devno;
+	rdc_data->dev_nr = _ccw_device_get_device_number(device->cdev);
 	rdc_data->rdc_len = sizeof (dasd_diag_characteristics_t);
 
 	rc = diag210((struct diag210 *) rdc_data);
diff -urN linux-2.5.66/drivers/s390/block/dasd_genhd.c linux-2.5.66-s390/drivers/s390/block/dasd_genhd.c
--- linux-2.5.66/drivers/s390/block/dasd_genhd.c	Wed Mar 26 15:45:19 2003
+++ linux-2.5.66-s390/drivers/s390/block/dasd_genhd.c	Wed Mar 26 15:45:19 2003
@@ -108,7 +108,6 @@
 struct gendisk *
 dasd_gendisk_alloc(int devindex)
 {
-	struct list_head *l;
 	struct major_info *mi;
 	struct gendisk *gdp;
 	int index, len, rc;
@@ -118,8 +117,7 @@
 	while (1) {
 		spin_lock(&dasd_major_lock);
 		index = devindex;
-		list_for_each(l, &dasd_major_info) {
-			mi = list_entry(l, struct major_info, list);
+		list_for_each_entry(mi, &dasd_major_info, list) {
 			if (index < DASD_PER_MAJOR)
 				break;
 			index -= DASD_PER_MAJOR;
@@ -192,14 +190,12 @@
  */
 int dasd_gendisk_index_major(int devindex)
 {
-	struct list_head *l;
 	struct major_info *mi;
 	int rc;
 
 	spin_lock(&dasd_major_lock);
 	rc = -ENODEV;
-	list_for_each(l, &dasd_major_info) {
-		mi = list_entry(l, struct major_info, list);
+	list_for_each_entry(mi, &dasd_major_info, list) {
 		if (devindex < DASD_PER_MAJOR) {
 			rc = mi->major;
 			break;
@@ -232,6 +228,7 @@
 dasd_destroy_partitions(dasd_device_t * device)
 {
 	del_gendisk(device->gdp);
+	put_disk(device->gdp);
 }
 
 int
diff -urN linux-2.5.66/drivers/s390/block/dasd_int.h linux-2.5.66-s390/drivers/s390/block/dasd_int.h
--- linux-2.5.66/drivers/s390/block/dasd_int.h	Wed Mar 26 15:45:19 2003
+++ linux-2.5.66-s390/drivers/s390/block/dasd_int.h	Wed Mar 26 15:45:19 2003
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.37 $
+ * $Revision: 1.38 $
  *
  * History of changes (starts July 2000)
  * 02/01/01 added dynamic registration of ioctls
@@ -297,10 +297,6 @@
 	struct list_head ccw_chunks;
 	struct list_head erp_chunks;
 
-	/* Common i/o stuff. */
-	/* FIXME: remove the next */
-	int devno;
-
 	atomic_t tasklet_scheduled;
         struct tasklet_struct tasklet;
 	struct work_struct kick_work;
@@ -315,24 +311,23 @@
 #endif
 } dasd_device_t;
 
+void dasd_put_device_wake(dasd_device_t *);
+
 /*
- * dasd_devmap_t is used to store the features and the relation
- * between device number and device index. To find a dasd_devmap_t
- * that corresponds to a device number of a device index each
- * dasd_devmap_t is added to two linked lists, one to search by
- * the device number and one to search by the device index. As
- * soon as big minor numbers are available the device index list
- * can be removed since the device number will then be identical
- * to the device index.
+ * Reference count inliners
  */
-typedef struct {
-	struct list_head devindex_list;
-	struct list_head devno_list;
-        unsigned int devindex;
-        unsigned short devno;
-        unsigned short features;
-        dasd_device_t *device;
-} dasd_devmap_t;
+static inline void
+dasd_get_device(dasd_device_t *device)
+{
+	atomic_inc(&device->ref_count);
+}
+
+static inline void
+dasd_put_device(dasd_device_t *device)
+{
+	if (atomic_dec_return(&device->ref_count) == 0)
+		dasd_put_device_wake(device);
+}
 
 /*
  * The static memory in ccw_mem and erp_mem is managed by a sorted
@@ -444,8 +439,9 @@
 	return set_normalized_cda(ccw, cda);
 }
 
-dasd_device_t *dasd_alloc_device(dasd_devmap_t *);
+dasd_device_t *dasd_alloc_device(unsigned int devindex);
 void dasd_free_device(dasd_device_t *);
+
 void dasd_enable_device(dasd_device_t *);
 void dasd_set_target_state(dasd_device_t *, int);
 void dasd_kick_device(dasd_device_t *);
@@ -476,13 +472,16 @@
 
 int dasd_devmap_init(void);
 void dasd_devmap_exit(void);
-dasd_devmap_t *dasd_devmap_from_devno(int);
-dasd_devmap_t *dasd_devmap_from_devindex(int);
-dasd_device_t *dasd_get_device(dasd_devmap_t *);
-void dasd_put_device(dasd_devmap_t *);
+
+dasd_device_t *dasd_create_device(struct ccw_device *);
+void dasd_delete_device(dasd_device_t *);
+
+kdev_t dasd_get_kdev(dasd_device_t *);
+dasd_device_t *dasd_device_from_devindex(int);
 
 int dasd_parse(void);
 int dasd_add_range(int, int, int);
+int dasd_devno_in_range(int);
 
 /* externals in dasd_gendisk.c */
 int  dasd_gendisk_init(void);
diff -urN linux-2.5.66/drivers/s390/block/dasd_ioctl.c linux-2.5.66-s390/drivers/s390/block/dasd_ioctl.c
--- linux-2.5.66/drivers/s390/block/dasd_ioctl.c	Mon Mar 24 23:00:48 2003
+++ linux-2.5.66-s390/drivers/s390/block/dasd_ioctl.c	Wed Mar 26 15:45:19 2003
@@ -333,7 +333,7 @@
 
 	cdev = device->cdev;
 
-	dasd_info->devno = device->devno;
+	dasd_info->devno = _ccw_device_get_device_number(device->cdev);
 	dasd_info->schid = _ccw_device_get_subchannel_number(device->cdev);
 	dasd_info->cu_type = cdev->id.cu_type;
 	dasd_info->cu_model = cdev->id.cu_model;
diff -urN linux-2.5.66/drivers/s390/block/dasd_proc.c linux-2.5.66-s390/drivers/s390/block/dasd_proc.c
--- linux-2.5.66/drivers/s390/block/dasd_proc.c	Mon Mar 24 23:00:09 2003
+++ linux-2.5.66-s390/drivers/s390/block/dasd_proc.c	Wed Mar 26 15:45:19 2003
@@ -9,7 +9,7 @@
  *
  * /proc interface for the dasd driver.
  *
- * $Revision: 1.17 $
+ * $Revision: 1.18 $
  *
  * History of changes
  * 05/04/02 split from dasd.c, code restructuring.
@@ -56,17 +56,14 @@
 static int
 dasd_devices_show(struct seq_file *m, void *v)
 {
-	dasd_devmap_t *devmap;
 	dasd_device_t *device;
 	char *substr;
 
-	devmap = dasd_devmap_from_devindex((unsigned long) v - 1);
-	device = (devmap != NULL) ?
-		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
+	device = dasd_device_from_devindex((unsigned long) v - 1);
 	if (IS_ERR(device))
 		return 0;
 	/* Print device number. */
-	seq_printf(m, "%04x", devmap->devno);
+	seq_printf(m, "%04x", _ccw_device_get_device_number(device->cdev));
 	/* Print discipline string. */
 	if (device != NULL && device->discipline != NULL)
 		seq_printf(m, "(%s)", device->discipline->name);
@@ -113,7 +110,7 @@
 		seq_printf(m, "no stat");
 		break;
 	}
-	dasd_put_device(devmap);
+	dasd_put_device(device);
 	if (dasd_probeonly)
 		seq_printf(m, "(probeonly)");
 	seq_printf(m, "\n");

