Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbTDNRu3 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263615AbTDNRuP (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:50:15 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:1439 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S263596AbTDNRpb (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:45:31 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (7/16): dasd driver fixes.
Date: Mon, 14 Apr 2003 19:50:13 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304141950.13050.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 dasd driver fixes:
 - Take request queue lock in dasd_end_request.
 - Make it work with CONFIG_DEVFS_FS=y.
 - Properly wait for the root device.
 - Cope with requests killed due to failed channel path.
 - Improve reference counting.
 - Remove devno from struct dasd_device.
 - Remove unnecessary bdget/bdput calls.

diffstat:
 Kconfig             |    2 
 block/dasd.c        |  241 +++++++++++++++++++++++++++++-----------------------
 block/dasd_devmap.c |  188 +++++++++++++++++++++++++++++++++-------
 block/dasd_diag.c   |   10 +-
 block/dasd_eckd.c   |   25 ++++-
 block/dasd_fba.c    |   11 +-
 block/dasd_genhd.c  |   12 +-
 block/dasd_int.h    |   52 +++++------
 block/dasd_ioctl.c  |    3 
 block/dasd_proc.c   |   11 --
 10 files changed, 363 insertions(+), 192 deletions(-)

diff -urN linux-2.5.67/drivers/s390/Kconfig linux-2.5.67-s390/drivers/s390/Kconfig
--- linux-2.5.67/drivers/s390/Kconfig	Mon Apr  7 19:32:28 2003
+++ linux-2.5.67-s390/drivers/s390/Kconfig	Mon Apr 14 19:11:52 2003
@@ -164,7 +164,7 @@
 
 config DASD_DIAG
 	tristate "Support for DIAG access to CMS reserved Disks"
-	depends on DASD
+	depends on DASD && ARCH_S390X = 'n'
 	help
 	  Select this option if you want to use CMS reserved Disks under VM
 	  with the Diagnose250 command.  If you are not running under VM or
diff -urN linux-2.5.67/drivers/s390/block/dasd.c linux-2.5.67-s390/drivers/s390/block/dasd.c
--- linux-2.5.67/drivers/s390/block/dasd.c	Mon Apr  7 19:31:14 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd.c	Mon Apr 14 19:11:52 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.74 $
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
 
@@ -174,35 +172,35 @@
 static inline int
 dasd_state_new_to_known(dasd_device_t *device)
 {
-	dasd_devmap_t *devmap;
 	umode_t devfs_perm;
-	devfs_handle_t dir;
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
 
+#ifdef CONFIG_DEVFS_FS
 	/* Add a proc directory and the dasd device entry to devfs. */
- 	dir = devfs_mk_dir("dasd/%04x", device->devno);
-	device->gdp->de = dir;
+ 	device->gdp->de = devfs_mk_dir("dasd/%04x",
+		_ccw_device_get_device_number(device->cdev));
+#endif
 	if (device->ro_flag)
 		devfs_perm = S_IFBLK | S_IRUSR;
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
@@ -215,8 +213,6 @@
 static inline void
 dasd_state_known_to_new(dasd_device_t * device)
 {
-	struct block_device *bdev;
-
 	/* Remove device entry and devfs directory. */
 	devfs_unregister(device->devfs_entry);
 	devfs_unregister(device->gdp->de);
@@ -225,10 +221,8 @@
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
@@ -428,7 +422,8 @@
         if (rc && rc != -EAGAIN) {
 		if (rc != -ENODEV)
 			MESSAGE (KERN_INFO, "giving up on dasd device with "
-				 "devno %04x", device->devno);
+				 "devno %04x",
+				 _ccw_device_get_device_number(device->cdev));
                 device->target = device->state;
         }
 
@@ -445,26 +440,18 @@
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
@@ -646,7 +633,7 @@
 	}
 	strncpy((char *) &cqr->magic, magic, 4);
 	ASCEBC((char *) &cqr->magic, 4);
-	atomic_inc(&device->ref_count);
+	dasd_get_device(device);
 	return cqr;
 }
 
@@ -693,7 +680,7 @@
 	}
 	strncpy((char *) &cqr->magic, magic, 4);
 	ASCEBC((char *) &cqr->magic, 4);
-	atomic_inc(&device->ref_count);
+	dasd_get_device(device);
 	return cqr;
 }
 
@@ -723,7 +710,7 @@
 	if (cqr->data != NULL)
 		kfree(cqr->data);
 	kfree(cqr);
-	atomic_dec(&device->ref_count);
+	dasd_put_device(device);
 }
 
 void
@@ -738,7 +725,7 @@
 	spin_lock_irqsave(&device->mem_lock, flags);
 	dasd_free_chunk(&device->ccw_chunks, cqr);
 	spin_unlock_irqrestore(&device->mem_lock, flags);
-	atomic_dec(&device->ref_count);
+	dasd_put_device(device);
 }
 
 /*
@@ -936,19 +923,14 @@
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
@@ -965,10 +947,39 @@
 	}
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	dasd_schedule_bh(device);
-	dasd_put_device(devmap);
+	dasd_put_device(device);
 	kfree(p);
 }
 
+static void
+dasd_handle_killed_request(struct ccw_device *cdev, unsigned long intparm)
+{
+	dasd_ccw_req_t *cqr;
+	dasd_device_t *device;
+
+	cqr = (dasd_ccw_req_t *) intparm;
+	if (cqr->status != DASD_CQR_IN_IO) {
+		MESSAGE(KERN_DEBUG,
+			"invalid status: bus_id %s, status %02x",
+			cdev->dev.bus_id, cqr->status);
+		return;
+	}
+
+	device = (dasd_device_t *) cqr->device;
+	if (device == NULL ||
+	    device != cdev->dev.driver_data ||
+	    strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
+		MESSAGE(KERN_DEBUG, "invalid device in request: bus_id %s",
+			cdev->dev.bus_id);
+		return;
+	}
+
+	/* Schedule request to be retried. */
+	cqr->status = DASD_CQR_QUEUED;
+
+	dasd_clear_timer(device);
+	dasd_schedule_bh(device);
+}
 
 static void
 dasd_handle_state_change_pending(dasd_device_t *device)
@@ -984,8 +995,7 @@
 		return;
 	INIT_WORK(&p->work, (void *) do_state_change_pending, p);
 	p->device = device;
-	atomic_inc(&device->ref_count);
-	/* queue call to do_state_change_pending to the kernel event daemon. */
+	dasd_get_device(device);
 	schedule_work(&p->work);
 }
 
@@ -1003,6 +1013,23 @@
 	dasd_era_t era;
 	char mask;
 
+	if (IS_ERR(irb)) {
+		switch (PTR_ERR(irb)) {
+		case -EIO:
+			dasd_handle_killed_request(cdev, intparm);
+			break;
+		case -ETIMEDOUT:
+			printk(KERN_WARNING"%s(%s): request timed out\n",
+			       __FUNCTION__, cdev->dev.bus_id);
+			//FIXME - dasd uses own timeout interface...
+			break;
+		default:
+			printk(KERN_WARNING"%s(%s): unknown error %ld\n",
+			       __FUNCTION__, cdev->dev.bus_id, PTR_ERR(irb));
+		}
+		return;
+	}
+
 	now = get_clock();
 
 	DBF_EVENT(DBF_DEBUG, "Interrupt: stat %02x, bus_id %s",
@@ -1108,7 +1135,6 @@
 		BUG();
 	add_disk_randomness(req->rq_disk);
 	end_that_request_last(req);
-	return;
 }
 
 /*
@@ -1177,7 +1203,9 @@
 
 	req = (struct request *) data;
 	dasd_profile_end(cqr->device, cqr, req);
+	spin_lock_irq(&cqr->device->request_queue_lock);
 	dasd_end_request(req, (cqr->status == DASD_CQR_DONE));
+	spin_unlock_irq(&cqr->device->request_queue_lock);
 	dasd_sfree_request(cqr, cqr->device);
 }
 
@@ -1189,7 +1217,6 @@
 __dasd_process_blk_queue(dasd_device_t * device)
 {
 	request_queue_t *queue;
-	struct list_head *l;
 	struct request *req;
 	dasd_ccw_req_t *cqr;
 	int nr_queued;
@@ -1211,11 +1238,9 @@
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
 	       elv_next_request(queue) &&
 		nr_queued < DASD_CHANQ_MAX_SIZE) {
@@ -1223,7 +1248,8 @@
 		if (device->ro_flag && rq_data_dir(req) == WRITE) {
 			DBF_EVENT(DBF_ERR,
 				  "(%04x) Rejecting write request %p",
-				  device->devno, req);
+				  _ccw_device_get_device_number(device->cdev),
+				  req);
 			blkdev_dequeue_request(req);
 			dasd_end_request(req, 0);
 			continue;
@@ -1234,7 +1260,8 @@
 				break;	/* terminate request queue loop */
 			DBF_EVENT(DBF_ERR,
 				  "(%04x) CCW creation failed on request %p",
-				  device->devno, req);
+				  _ccw_device_get_device_number(device->cdev),
+				  req);
 			blkdev_dequeue_request(req);
 			dasd_end_request(req, 0);
 			continue;
@@ -1371,8 +1398,7 @@
 	__dasd_start_head(device);
 	spin_unlock(get_ccwdev_lock(device->cdev));
 	spin_unlock_irq(&device->request_queue_lock);
-	/* FIXME: what if ref_count == 0 && state == DASD_STATE_NEW ?? */
-	atomic_dec(&device->ref_count);
+	dasd_put_device(device);
 }
 
 /*
@@ -1384,7 +1410,7 @@
 	/* Protect against rescheduling. */
 	if (atomic_compare_and_swap (0, 1, &device->tasklet_scheduled))
 		return;
-	atomic_inc(&device->ref_count);
+	dasd_get_device(device);
 	tasklet_hi_schedule(&device->tasklet);
 }
 
@@ -1766,8 +1792,8 @@
 	return 0;
 }
 
-struct
-block_device_operations dasd_device_operations = {
+struct block_device_operations
+dasd_device_operations = {
 	.owner		= THIS_MODULE,
 	.open		= dasd_open,
 	.release	= dasd_release,
@@ -1823,12 +1849,6 @@
 
 	cdev->handler = &dasd_int_handler;
 
-	if (dasd_autodetect ||
-	    dasd_devmap_from_devno(devno) != 0) {
-		/* => device was in dasd parameter line */
-		ccw_device_set_online(cdev);
-	}
-
 	return ret;
 }
 
@@ -1854,30 +1874,12 @@
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
@@ -1898,7 +1900,7 @@
 	if (rc) {
 		printk (KERN_WARNING "dasd_generic found a bad device %s\n", 
 			cdev->dev.bus_id);
-		dasd_put_device(devmap);
+		dasd_delete_device(device);
 		return rc;
 	}
 
@@ -1909,16 +1911,17 @@
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
 
@@ -1926,26 +1929,52 @@
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
 
 /*
+ * Automatically online either all dasd devices (dasd_autodetect) or
+ * all devices specified with dasd= parameters. For dasd_autodetect
+ * dasd_generic_probe has added devmaps for all dasd devices. We
+ * scan all present dasd devmaps and call ccw_device_set_online.
+ */
+void
+dasd_generic_auto_online (struct ccw_driver *dasd_discipline_driver)
+{
+	struct device_driver *drv;
+	struct device *d, *dev;
+	struct ccw_device *cdev;
+	int devno;
+
+	drv = get_driver(&dasd_discipline_driver->driver);
+	down_read(&drv->bus->subsys.rwsem);
+	dev = NULL;
+	list_for_each_entry(d, &drv->devices, driver_list) {
+		dev = get_device(d);
+		if (!dev)
+			continue;
+		cdev = to_ccwdev(dev);
+		devno = _ccw_device_get_device_number(cdev);
+		if (dasd_autodetect || dasd_devno_in_range(devno) == 0)
+			ccw_device_set_online(cdev);
+		put_device(dev);
+	}
+	up_read(&drv->bus->subsys.rwsem);
+	put_driver(drv);
+}
+
+/*
  * SECTION: files in sysfs
  */
 
@@ -2078,11 +2107,13 @@
 
 	DBF_EVENT(DBF_EMERG, "%s", "debug area created");
 
-	if (devfs_mk_dir("dasd")) {
+#ifdef CONFIG_DEVFS_FS
+	if (!devfs_mk_dir("dasd")) {
 		DBF_EVENT(DBF_ALERT, "%s", "no devfs");
 		rc = -ENOSYS;
 		goto failed;
 	}
+#endif
 	rc = dasd_devmap_init();
 	if (rc)
 		goto failed;
diff -urN linux-2.5.67/drivers/s390/block/dasd_devmap.c linux-2.5.67-s390/drivers/s390/block/dasd_devmap.c
--- linux-2.5.67/drivers/s390/block/dasd_devmap.c	Mon Apr  7 19:31:23 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_devmap.c	Mon Apr 14 19:11:52 2003
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
diff -urN linux-2.5.67/drivers/s390/block/dasd_diag.c linux-2.5.67-s390/drivers/s390/block/dasd_diag.c
--- linux-2.5.67/drivers/s390/block/dasd_diag.c	Mon Apr  7 19:30:35 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_diag.c	Mon Apr 14 19:11:52 2003
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
diff -urN linux-2.5.67/drivers/s390/block/dasd_eckd.c linux-2.5.67-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.5.67/drivers/s390/block/dasd_eckd.c	Mon Apr  7 19:30:34 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_eckd.c	Mon Apr 14 19:11:52 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.36 $
+ * $Revision: 1.38 $
  *
  * History of changes (starts July 2000)
  * 07/11/00 Enabled rotational position sensing
@@ -1003,7 +1003,7 @@
 				return ERR_PTR(-EINVAL);
 			count += bv->bv_len >> (device->s2b_shift + 9);
 #if defined(CONFIG_ARCH_S390X)
-			cidaw += idal_nr_words(kmap(bv->bv_page) +
+			cidaw += idal_nr_words(page_address(bv->bv_page) +
 					       bv->bv_offset, bv->bv_len);
 #endif
 		}
@@ -1042,7 +1042,7 @@
 			      last_rec - recid + 1, cmd, device, blksize);
 	}
 	rq_for_each_bio(bio, req) bio_for_each_segment(bv, bio, i) {
-		dst = kmap(bv->bv_page) + bv->bv_offset;
+		dst = page_address(bv->bv_page) + bv->bv_offset;
 		for (off = 0; off < bv->bv_len; off += blksize) {
 			sector_t trkid = recid;
 			unsigned int recoffs = sector_div(trkid, blk_per_trk);
@@ -1453,6 +1453,8 @@
 static int __init
 dasd_eckd_init(void)
 {
+	int ret;
+
 	dasd_ioctl_no_register(THIS_MODULE, BIODASDSATTR,
 			       dasd_eckd_set_attrib);
 	dasd_ioctl_no_register(THIS_MODULE, BIODASDPSRD,
@@ -1466,7 +1468,22 @@
 
 	ASCEBC(dasd_eckd_discipline.ebcname, 4);
 
-	ccw_driver_register(&dasd_eckd_driver);
+	ret = ccw_driver_register(&dasd_eckd_driver);
+	if (ret) {
+		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDSATTR,
+					 dasd_eckd_set_attrib);
+		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDPSRD,
+					 dasd_eckd_performance);
+		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDRLSE,
+					 dasd_eckd_release);
+		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDRSRV,
+					 dasd_eckd_reserve);
+		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDSLCK,
+					 dasd_eckd_steal_lock);
+		return ret;
+	}
+
+	dasd_generic_auto_online(&dasd_eckd_driver);
 	return 0;
 }
 
diff -urN linux-2.5.67/drivers/s390/block/dasd_fba.c linux-2.5.67-s390/drivers/s390/block/dasd_fba.c
--- linux-2.5.67/drivers/s390/block/dasd_fba.c	Mon Apr  7 19:31:56 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_fba.c	Mon Apr 14 19:11:52 2003
@@ -4,7 +4,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.25 $
+ * $Revision: 1.27 $
  *
  * History of changes
  *	    fixed partition handling and HDIO_GETGEO
@@ -414,9 +414,16 @@
 static int __init
 dasd_fba_init(void)
 {
+	int ret;
+
 	ASCEBC(dasd_fba_discipline.ebcname, 4);
 
-	return ccw_driver_register(&dasd_fba_driver);
+	ret = ccw_driver_register(&dasd_fba_driver);
+	if (ret)
+		return ret;
+
+	dasd_generic_auto_online(&dasd_fba_driver);
+	return 0;
 }
 
 static void __exit
diff -urN linux-2.5.67/drivers/s390/block/dasd_genhd.c linux-2.5.67-s390/drivers/s390/block/dasd_genhd.c
--- linux-2.5.67/drivers/s390/block/dasd_genhd.c	Mon Apr  7 19:32:18 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_genhd.c	Mon Apr 14 19:11:52 2003
@@ -9,7 +9,7 @@
  *
  * Dealing with devices registered to multiple major numbers.
  *
- * $Revision: 1.23 $
+ * $Revision: 1.24 $
  *
  * History of changes
  * 05/04/02 split from dasd.c, code restructuring.
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
@@ -142,6 +140,7 @@
 	gdp->major = mi->major;
 	gdp->first_minor = index << DASD_PARTN_BITS;
 	gdp->fops = &dasd_device_operations;
+	gdp->flags |= GENHD_FL_DEVFS;
 
 	/*
 	 * Set device name.
@@ -191,14 +190,12 @@
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
@@ -231,6 +228,7 @@
 dasd_destroy_partitions(dasd_device_t * device)
 {
 	del_gendisk(device->gdp);
+	put_disk(device->gdp);
 }
 
 int
diff -urN linux-2.5.67/drivers/s390/block/dasd_int.h linux-2.5.67-s390/drivers/s390/block/dasd_int.h
--- linux-2.5.67/drivers/s390/block/dasd_int.h	Mon Apr  7 19:32:16 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_int.h	Mon Apr 14 19:11:52 2003
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.36 $
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
@@ -467,6 +463,7 @@
 int dasd_generic_set_online(struct ccw_device *cdev, 
 			    dasd_discipline_t *discipline);
 int dasd_generic_set_offline (struct ccw_device *cdev);
+void dasd_generic_auto_online (struct ccw_driver *);
 
 /* externals in dasd_devmap.c */
 extern int dasd_max_devindex;
@@ -475,13 +472,16 @@
 
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
diff -urN linux-2.5.67/drivers/s390/block/dasd_ioctl.c linux-2.5.67-s390/drivers/s390/block/dasd_ioctl.c
--- linux-2.5.67/drivers/s390/block/dasd_ioctl.c	Mon Apr  7 19:31:46 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_ioctl.c	Mon Apr 14 19:11:52 2003
@@ -12,7 +12,6 @@
  * 05/04/02 split from dasd.c, code restructuring.
  */
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/interrupt.h>
 #include <linux/major.h>
 #include <linux/fs.h>
@@ -333,7 +332,7 @@
 
 	cdev = device->cdev;
 
-	dasd_info->devno = device->devno;
+	dasd_info->devno = _ccw_device_get_device_number(device->cdev);
 	dasd_info->schid = _ccw_device_get_subchannel_number(device->cdev);
 	dasd_info->cu_type = cdev->id.cu_type;
 	dasd_info->cu_model = cdev->id.cu_model;
diff -urN linux-2.5.67/drivers/s390/block/dasd_proc.c linux-2.5.67-s390/drivers/s390/block/dasd_proc.c
--- linux-2.5.67/drivers/s390/block/dasd_proc.c	Mon Apr  7 19:30:45 2003
+++ linux-2.5.67-s390/drivers/s390/block/dasd_proc.c	Mon Apr 14 19:11:52 2003
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

