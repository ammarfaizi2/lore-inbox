Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWHXLap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWHXLap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWHXLap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:30:45 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:6708 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751152AbWHXLao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:30:44 -0400
Date: Thu, 24 Aug 2006 13:30:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] s390: dasd deadlock after state change pending interrupt.
Message-ID: <20060824113041.GG7022@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] dasd deadlock after state change pending interrupt.

The dasd_device_from_cdev function is called from interrupt context
to get the struct dasd_device associated with a ccw device. The
driver_data of the ccw device points to the dasd_devmap structure
which contains the pointer to the dasd_device structure. The lock
that protects the dasd_devmap structure is acquire with out irqsave.
To prevent the deadlock in dasd_device_from_cdev if it is called
from interrupt context the dependency to the dasd_devmap structure
needs to be removed. Let the driver_data of the ccw device point
to the dasd_device structure directly and use the ccw device lock
to protect the access.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c        |    4 +-
 drivers/s390/block/dasd_devmap.c |   74 +++++++++++++++++++++++++--------------
 drivers/s390/block/dasd_int.h    |    1 
 3 files changed, 51 insertions(+), 28 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-08-24 12:10:54.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-08-24 12:10:59.000000000 +0200
@@ -893,7 +893,7 @@ dasd_handle_killed_request(struct ccw_de
 
 	device = (struct dasd_device *) cqr->device;
 	if (device == NULL ||
-	    device != dasd_device_from_cdev(cdev) ||
+	    device != dasd_device_from_cdev_locked(cdev) ||
 	    strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
 		MESSAGE(KERN_DEBUG, "invalid device in request: bus_id %s",
 			cdev->dev.bus_id);
@@ -970,7 +970,7 @@ dasd_int_handler(struct ccw_device *cdev
 	/* first of all check for state change pending interrupt */
 	mask = DEV_STAT_ATTENTION | DEV_STAT_DEV_END | DEV_STAT_UNIT_EXCEP;
 	if ((irb->scsw.dstat & mask) == mask) {
-		device = dasd_device_from_cdev(cdev);
+		device = dasd_device_from_cdev_locked(cdev);
 		if (!IS_ERR(device)) {
 			dasd_handle_state_change_pending(device);
 			dasd_put_device(device);
diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2006-08-24 12:10:21.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2006-08-24 12:10:59.000000000 +0200
@@ -523,17 +523,17 @@ dasd_create_device(struct ccw_device *cd
 {
 	struct dasd_devmap *devmap;
 	struct dasd_device *device;
+	unsigned long flags;
 	int rc;
 
 	devmap = dasd_devmap_from_cdev(cdev);
 	if (IS_ERR(devmap))
 		return (void *) devmap;
-	cdev->dev.driver_data = devmap;
 
 	device = dasd_alloc_device();
 	if (IS_ERR(device))
 		return device;
-	atomic_set(&device->ref_count, 2);
+	atomic_set(&device->ref_count, 3);
 
 	spin_lock(&dasd_devmap_lock);
 	if (!devmap->device) {
@@ -552,6 +552,11 @@ dasd_create_device(struct ccw_device *cd
 		dasd_free_device(device);
 		return ERR_PTR(rc);
 	}
+
+	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
+	cdev->dev.driver_data = device;
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
+
 	return device;
 }
 
@@ -569,6 +574,7 @@ dasd_delete_device(struct dasd_device *d
 {
 	struct ccw_device *cdev;
 	struct dasd_devmap *devmap;
+	unsigned long flags;
 
 	/* First remove device pointer from devmap. */
 	devmap = dasd_find_busid(device->cdev->dev.bus_id);
@@ -582,9 +588,16 @@ dasd_delete_device(struct dasd_device *d
 	devmap->device = NULL;
 	spin_unlock(&dasd_devmap_lock);
 
-	/* Drop ref_count by 2, one for the devmap reference and
-	 * one for the passed reference. */
-	atomic_sub(2, &device->ref_count);
+	/* Disconnect dasd_device structure from ccw_device structure. */
+	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
+	device->cdev->dev.driver_data = NULL;
+	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+
+	/*
+	 * Drop ref_count by 3, one for the devmap reference, one for
+	 * the cdev reference and one for the passed reference.
+	 */
+	atomic_sub(3, &device->ref_count);
 
 	/* Wait for reference counter to drop to zero. */
 	wait_event(dasd_delete_wq, atomic_read(&device->ref_count) == 0);
@@ -593,9 +606,6 @@ dasd_delete_device(struct dasd_device *d
 	cdev = device->cdev;
 	device->cdev = NULL;
 
-	/* Disconnect dasd_devmap structure from ccw_device structure. */
-	cdev->dev.driver_data = NULL;
-
 	/* Put ccw_device structure. */
 	put_device(&cdev->dev);
 
@@ -615,21 +625,32 @@ dasd_put_device_wake(struct dasd_device 
 
 /*
  * Return dasd_device structure associated with cdev.
+ * This function needs to be called with the ccw device
+ * lock held. It can be used from interrupt context.
+ */
+struct dasd_device *
+dasd_device_from_cdev_locked(struct ccw_device *cdev)
+{
+	struct dasd_device *device = cdev->dev.driver_data;
+
+	if (!device)
+		return ERR_PTR(-ENODEV);
+	dasd_get_device(device);
+	return device;
+}
+
+/*
+ * Return dasd_device structure associated with cdev.
  */
 struct dasd_device *
 dasd_device_from_cdev(struct ccw_device *cdev)
 {
-	struct dasd_devmap *devmap;
 	struct dasd_device *device;
+	unsigned long flags;
 
-	device = ERR_PTR(-ENODEV);
-	spin_lock(&dasd_devmap_lock);
-	devmap = cdev->dev.driver_data;
-	if (devmap && devmap->device) {
-		device = devmap->device;
-		dasd_get_device(device);
-	}
-	spin_unlock(&dasd_devmap_lock);
+	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
+	device = dasd_device_from_cdev_locked(cdev);
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
 	return device;
 }
 
@@ -730,16 +751,17 @@ static ssize_t
 dasd_discipline_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
 {
-	struct dasd_devmap *devmap;
-	char *dname;
+	struct dasd_device *device;
+	ssize_t len;
 
-	spin_lock(&dasd_devmap_lock);
-	dname = "none";
-	devmap = dev->driver_data;
-	if (devmap && devmap->device && devmap->device->discipline)
-		dname = devmap->device->discipline->name;
-	spin_unlock(&dasd_devmap_lock);
-	return snprintf(buf, PAGE_SIZE, "%s\n", dname);
+	device = dasd_device_from_cdev(to_ccwdev(dev));
+	if (!IS_ERR(device) && device->discipline) {
+		len = snprintf(buf, PAGE_SIZE, "%s\n",
+			       device->discipline->name);
+		dasd_put_device(device);
+	} else
+		len = snprintf(buf, PAGE_SIZE, "none\n");
+	return len;
 }
 
 static DEVICE_ATTR(discipline, 0444, dasd_discipline_show, NULL);
diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2006-08-24 12:09:53.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2006-08-24 12:10:59.000000000 +0200
@@ -534,6 +534,7 @@ int dasd_add_sysfs_files(struct ccw_devi
 void dasd_remove_sysfs_files(struct ccw_device *);
 
 struct dasd_device *dasd_device_from_cdev(struct ccw_device *);
+struct dasd_device *dasd_device_from_cdev_locked(struct ccw_device *);
 struct dasd_device *dasd_device_from_devindex(int);
 
 int dasd_parse(void);
