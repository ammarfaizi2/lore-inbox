Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbUCPN6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 08:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUCPN6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:58:20 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:40348 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S261710AbUCPNux
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:50:53 -0500
Date: Tue, 16 Mar 2004 14:50:37 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (5/10): dasd driver fixes.
Message-ID: <20040316135037.GF2785@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dasd driver fixes:
 - Remove additional dasd attributes for a ccw-device if the discipline
   (=driver) gets unloaded.
 - Fix race of dasd_generic_offline against dasd_open.
 - Remove irq_exit calls from diag interrupt handler. The irq_enter/
   irq_exit is done in the external interrupt handler.

diffstat:
 drivers/s390/block/Kconfig       |    8 +++---
 drivers/s390/block/dasd.c        |   49 +++++++++++++++++++++++++++++++--------
 drivers/s390/block/dasd_devmap.c |    9 ++++++-
 drivers/s390/block/dasd_diag.c   |    4 ---
 drivers/s390/block/dasd_int.h    |    4 ++-
 5 files changed, 55 insertions(+), 19 deletions(-)

diff -urN linux-2.6/drivers/s390/block/Kconfig linux-2.6-s390/drivers/s390/block/Kconfig
--- linux-2.6/drivers/s390/block/Kconfig	Thu Mar 11 03:55:21 2004
+++ linux-2.6-s390/drivers/s390/block/Kconfig	Tue Mar 16 14:03:09 2004
@@ -48,12 +48,12 @@
 	  say "Y".
 
 config DASD_DIAG
-	tristate "Support for DIAG access to CMS reserved Disks"
+	tristate "Support for DIAG access to Disks"
 	depends on DASD && ARCH_S390X = 'n'
 	help
-	  Select this option if you want to use CMS reserved Disks under VM
-	  with the Diagnose250 command.  If you are not running under VM or
-	  unsure what it is, say "N".
+	  Select this option if you want to use Diagnose250 command to access
+	  Disks under VM.  If you are not running under VM or unsure what it is, 
+	  say "N".
 
 config DASD_CMB
 	tristate "Compatibility interface for DASD channel measurement blocks"
diff -urN linux-2.6/drivers/s390/block/dasd.c linux-2.6-s390/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	Thu Mar 11 03:55:26 2004
+++ linux-2.6-s390/drivers/s390/block/dasd.c	Tue Mar 16 14:03:09 2004
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.129 $
+ * $Revision: 1.133 $
  */
 
 #include <linux/config.h>
@@ -1655,11 +1655,24 @@
 {
 	struct gendisk *disk = inp->i_bdev->bd_disk;
 	struct dasd_device *device = disk->private_data;
-	int rc;
+	int old_count, rc;
+
+	/*
+	 * We use a negative value in open_count to indicate that  
+	 * the device must not be used. 
+	 */
+	do {
+		old_count = atomic_read(&device->open_count);
+		if (old_count < 0)  
+			return -ENODEV;
+	} while (atomic_compare_and_swap(old_count, old_count + 1,
+					 &device->open_count));
+
+	if (!try_module_get(device->discipline->owner)) {
+		rc = -EINVAL;
+		goto unlock;
+	}
 
-	if (!try_module_get(device->discipline->owner))
-		return -EINVAL;
-	
 	if (dasd_probeonly) {
 		MESSAGE(KERN_INFO,
 			"No access to device %s due to probeonly mode",
@@ -1676,11 +1689,12 @@
 		goto out;
 	}
 
-	atomic_inc(&device->open_count);
 	return 0;
 
 out:
 	module_put(device->discipline->owner);
+unlock:
+	atomic_dec(&device->open_count);
 	return rc;
 }
 
@@ -1741,7 +1755,7 @@
 	ret = dasd_add_sysfs_files(cdev);
 	if (ret) {
 		printk(KERN_WARNING
-		       "dasd_generic_probe: could not add driverfs entries"
+		       "dasd_generic_probe: could not add sysfs entries "
 		       "for %s\n", cdev->dev.bus_id);
 	}
 
@@ -1757,8 +1771,15 @@
 {
 	struct dasd_device *device;
 
+	dasd_remove_sysfs_files(cdev);
 	device = dasd_device_from_cdev(cdev);
 	if (!IS_ERR(device)) {
+		/*
+		 * This device is removed unconditionally. Set open_count
+		 * to -1 to prevent dasd_open from opening it while it is
+		 * no quite down yet.
+		 */
+		atomic_set(&device->open_count,-1);
 		dasd_set_target_state(device, DASD_STATE_NEW);
 		/* dasd_delete_device destroys the device reference. */
 		dasd_delete_device(device);
@@ -1830,15 +1851,23 @@
 	struct dasd_device *device;
 
 	device = dasd_device_from_cdev(cdev);
-	if (atomic_read(&device->open_count) > 0) {
+	/*
+	 * We must make sure that this device is currently not in use 
+	 * (current open_count == 0 ). We set open_count to -1 to indicate 
+	 * that from now on set_offline is in progress and the device must
+	 * not be used otherwise. 
+	 */
+	if (atomic_compare_and_swap(0, -1, &device->open_count)) {
 		printk (KERN_WARNING "Can't offline dasd device with open"
 			" count = %i.\n",
 			atomic_read(&device->open_count));
 		dasd_put_device(device);
 		return -EBUSY;
 	}
-	dasd_put_device(device);
-	dasd_generic_remove (cdev);
+	dasd_set_target_state(device, DASD_STATE_NEW);
+	/* dasd_delete_device destroys the device reference. */
+	dasd_delete_device(device);
+
 	return 0;
 }
 
diff -urN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-s390/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	Thu Mar 11 03:55:27 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_devmap.c	Tue Mar 16 14:03:09 2004
@@ -11,7 +11,7 @@
  * functions may not be called from interrupt context. In particular
  * dasd_get_device is a no-no from interrupt context.
  *
- * $Revision: 1.25 $
+ * $Revision: 1.26 $
  */
 
 #include <linux/config.h>
@@ -681,6 +681,13 @@
 	return sysfs_create_group(&cdev->dev.kobj, &dasd_attr_group);
 }
 
+void
+dasd_remove_sysfs_files(struct ccw_device *cdev)
+{
+	sysfs_remove_group(&cdev->dev.kobj, &dasd_attr_group);
+}
+
+
 int
 dasd_devmap_init(void)
 {
diff -urN linux-2.6/drivers/s390/block/dasd_diag.c linux-2.6-s390/drivers/s390/block/dasd_diag.c
--- linux-2.6/drivers/s390/block/dasd_diag.c	Thu Mar 11 03:55:21 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_diag.c	Tue Mar 16 14:03:09 2004
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.33 $
+ * $Revision: 1.34 $
  */
 
 #include <linux/config.h>
@@ -173,7 +173,6 @@
 
 	if (!ip) {		/* no intparm: unsolicited interrupt */
 		MESSAGE(KERN_DEBUG, "%s", "caught unsolicited interrupt");
-		irq_exit();
 		return;
 	}
 	cqr = (struct dasd_ccw_req *)(addr_t) ip;
@@ -183,7 +182,6 @@
 			    " magic number of dasd_ccw_req 0x%08X doesn't"
 			    " match discipline 0x%08X",
 			    cqr->magic, *(int *) (&device->discipline->name));
-		irq_exit();
 		return;
 	}
 
diff -urN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-s390/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	Thu Mar 11 03:55:36 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_int.h	Tue Mar 16 14:03:09 2004
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.54 $
+ * $Revision: 1.55 $
  */
 
 #ifndef DASD_INT_H
@@ -485,6 +485,8 @@
 void dasd_delete_device(struct dasd_device *);
 
 int dasd_add_sysfs_files(struct ccw_device *);
+void dasd_remove_sysfs_files(struct ccw_device *);
+
 struct dasd_device *dasd_device_from_cdev(struct ccw_device *);
 struct dasd_device *dasd_device_from_devindex(int);
 
