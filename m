Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261722AbTCZPJg>; Wed, 26 Mar 2003 10:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261718AbTCZPIf>; Wed, 26 Mar 2003 10:08:35 -0500
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:35575 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261711AbTCZPHa> convert rfc822-to-8bit; Wed, 26 Mar 2003 10:07:30 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 update (7/9): dasd driver bugs.
Date: Wed, 26 Mar 2003 16:12:50 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303261612.50465.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Take request queue lock in dasd_end_request.
* Make it work with CONFIG_DEVFS_FS=y.
* Properly wait for the root device.
* Cope with requests killed due to failed channel path.

diffstat:
 dasd.c       |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
 dasd_eckd.c  |   21 ++++++++++++--
 dasd_fba.c   |   11 ++++++-
 dasd_genhd.c |    3 +-
 dasd_int.h   |    3 +-
 5 files changed, 108 insertions(+), 17 deletions(-)

diff -urN linux-2.5.66/drivers/s390/block/dasd.c linux-2.5.66-s390/drivers/s390/block/dasd.c
--- linux-2.5.66/drivers/s390/block/dasd.c	Mon Mar 24 23:00:22 2003
+++ linux-2.5.66-s390/drivers/s390/block/dasd.c	Wed Mar 26 15:45:18 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.74 $
+ * $Revision: 1.81 $
  *
  * History of changes (starts July 2000)
  * 11/09/00 complete redesign after code review
@@ -176,7 +176,6 @@
 {
 	dasd_devmap_t *devmap;
 	umode_t devfs_perm;
-	devfs_handle_t dir;
 	int major, minor;
 	char buf[20];
 
@@ -192,9 +191,11 @@
 		return -ENODEV;
 	minor = devmap->devindex % DASD_PER_MAJOR;
 
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
@@ -969,6 +970,35 @@
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
@@ -1003,6 +1033,11 @@
 	dasd_era_t era;
 	char mask;
 
+	if (PTR_ERR(irb) == -EIO) {
+		dasd_handle_killed_request(cdev, intparm);
+		return;
+	}
+
 	now = get_clock();
 
 	DBF_EVENT(DBF_DEBUG, "Interrupt: stat %02x, bus_id %s",
@@ -1177,7 +1212,9 @@
 
 	req = (struct request *) data;
 	dasd_profile_end(cqr->device, cqr, req);
+	spin_lock_irq(&cqr->device->request_queue_lock);
 	dasd_end_request(req, (cqr->status == DASD_CQR_DONE));
+	spin_unlock_irq(&cqr->device->request_queue_lock);
 	dasd_sfree_request(cqr, cqr->device);
 }
 
@@ -1823,12 +1860,6 @@
 
 	cdev->handler = &dasd_int_handler;
 
-	if (dasd_autodetect ||
-	    dasd_devmap_from_devno(devno) != 0) {
-		/* => device was in dasd parameter line */
-		ccw_device_set_online(cdev);
-	}
-
 	return ret;
 }
 
@@ -1946,6 +1977,38 @@
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
+		if (dasd_autodetect ||
+		    dasd_devmap_from_devno(devno) != 0)
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
 
@@ -2078,11 +2141,13 @@
 
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
diff -urN linux-2.5.66/drivers/s390/block/dasd_eckd.c linux-2.5.66-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.5.66/drivers/s390/block/dasd_eckd.c	Mon Mar 24 22:59:53 2003
+++ linux-2.5.66-s390/drivers/s390/block/dasd_eckd.c	Wed Mar 26 15:45:18 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.36 $
+ * $Revision: 1.38 $
  *
  * History of changes (starts July 2000)
  * 07/11/00 Enabled rotational position sensing
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
 
diff -urN linux-2.5.66/drivers/s390/block/dasd_fba.c linux-2.5.66-s390/drivers/s390/block/dasd_fba.c
--- linux-2.5.66/drivers/s390/block/dasd_fba.c	Mon Mar 24 23:00:55 2003
+++ linux-2.5.66-s390/drivers/s390/block/dasd_fba.c	Wed Mar 26 15:45:18 2003
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
diff -urN linux-2.5.66/drivers/s390/block/dasd_genhd.c linux-2.5.66-s390/drivers/s390/block/dasd_genhd.c
--- linux-2.5.66/drivers/s390/block/dasd_genhd.c	Mon Mar 24 23:01:15 2003
+++ linux-2.5.66-s390/drivers/s390/block/dasd_genhd.c	Wed Mar 26 15:45:18 2003
@@ -9,7 +9,7 @@
  *
  * Dealing with devices registered to multiple major numbers.
  *
- * $Revision: 1.23 $
+ * $Revision: 1.24 $
  *
  * History of changes
  * 05/04/02 split from dasd.c, code restructuring.
@@ -142,6 +142,7 @@
 	gdp->major = mi->major;
 	gdp->first_minor = index << DASD_PARTN_BITS;
 	gdp->fops = &dasd_device_operations;
+	gdp->flags |= GENHD_FL_DEVFS;
 
 	/*
 	 * Set device name.
diff -urN linux-2.5.66/drivers/s390/block/dasd_int.h linux-2.5.66-s390/drivers/s390/block/dasd_int.h
--- linux-2.5.66/drivers/s390/block/dasd_int.h	Mon Mar 24 23:01:12 2003
+++ linux-2.5.66-s390/drivers/s390/block/dasd_int.h	Wed Mar 26 15:45:18 2003
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.36 $
+ * $Revision: 1.37 $
  *
  * History of changes (starts July 2000)
  * 02/01/01 added dynamic registration of ioctls
@@ -467,6 +467,7 @@
 int dasd_generic_set_online(struct ccw_device *cdev, 
 			    dasd_discipline_t *discipline);
 int dasd_generic_set_offline (struct ccw_device *cdev);
+void dasd_generic_auto_online (struct ccw_driver *);
 
 /* externals in dasd_devmap.c */
 extern int dasd_max_devindex;

