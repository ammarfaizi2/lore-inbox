Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbTJUPJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbTJUPJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:09:35 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:27864 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263149AbTJUPIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:08:23 -0400
Date: Tue, 21 Oct 2003 17:08:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (4/8): dasd driver fixes.
Message-ID: <20031021150829.GB1690@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Fix interrupt status examination.
 - Make dasd device attributes dependent on the devmap structure instead of
   the device structure to make them persistent and to be able to modify
   them in the offline state.
 - Add (diag) option to dasd= paramter.
 - Add missing spin_lock_init call.

diffstat:
 drivers/s390/block/dasd.c        |  185 ++++++---------------------------
 drivers/s390/block/dasd_devmap.c |  216 ++++++++++++++++++++++++++++++++++-----
 drivers/s390/block/dasd_int.h    |    5 
 include/asm-s390/dasd.h          |    4 
 4 files changed, 233 insertions(+), 177 deletions(-)

diff -urN linux-2.6/drivers/s390/block/dasd.c linux-2.6-s390/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	Fri Oct 17 23:43:09 2003
+++ linux-2.6-s390/drivers/s390/block/dasd.c	Tue Oct 21 16:37:36 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.114 $
+ * $Revision: 1.118 $
  */
 
 #include <linux/config.h>
@@ -57,7 +57,6 @@
 static void dasd_flush_ccw_queue(struct dasd_device *, int);
 static void dasd_tasklet(struct dasd_device *);
 static void do_kick_device(void *data);
-static int  dasd_add_sysfs_files(struct ccw_device *cdev);
 
 /*
  * SECTION: Operations on the device structure.
@@ -93,6 +92,7 @@
 
 	dasd_init_chunklist(&device->ccw_chunks, device->ccw_mem, PAGE_SIZE*2);
 	dasd_init_chunklist(&device->erp_chunks, device->erp_mem, PAGE_SIZE);
+	spin_lock_init(&device->mem_lock);
 	spin_lock_init(&device->request_queue_lock);
 	atomic_set (&device->tasklet_scheduled, 0);
 	tasklet_init(&device->tasklet, 
@@ -860,7 +860,7 @@
 
 	device = (struct dasd_device *) cqr->device;
 	if (device == NULL ||
-	    device != cdev->dev.driver_data ||
+	    device != dasd_device_from_cdev(cdev) ||
 	    strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
 		MESSAGE(KERN_DEBUG, "invalid device in request: bus_id %s",
 			cdev->dev.bus_id);
@@ -931,7 +931,9 @@
 	/* first of all check for state change pending interrupt */
 	mask = DEV_STAT_ATTENTION | DEV_STAT_DEV_END | DEV_STAT_UNIT_EXCEP;
 	if ((irb->scsw.dstat & mask) == mask) {
-		dasd_handle_state_change_pending(cdev->dev.driver_data);
+		device = dasd_device_from_cdev(cdev);
+		if (!IS_ERR(device))
+			dasd_handle_state_change_pending(device);
 		return;
 	}
 
@@ -949,7 +951,7 @@
 
 	device = (struct dasd_device *) cqr->device;
 	if (device == NULL ||
-	    device != cdev->dev.driver_data ||
+	    device != dasd_device_from_cdev(cdev) ||
 	    strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
 		MESSAGE(KERN_DEBUG, "invalid device in request: bus_id %s",
 			cdev->dev.bus_id);
@@ -959,17 +961,19 @@
 	DBF_DEV_EVENT(DBF_DEBUG, device, "Int: CS/DS 0x%04x",
 		      ((irb->scsw.cstat << 8) | irb->scsw.dstat));
 
-	/* Find out the appropriate era_action. */
-	era = dasd_era_none;
-	if (irb->scsw.dstat & ~(DEV_STAT_CHN_END | DEV_STAT_DEV_END) ||
-	    irb->esw.esw0.erw.cons) {
-		/* The request did end abnormally. */
-		if (irb->scsw.fctl & SCSW_FCTL_HALT_FUNC)
-			era = dasd_era_fatal;
-		else
-			era = device->discipline->examine_error(cqr, irb);
-		DBF_EVENT(DBF_NOTICE, "era_code %d", era);
-	}
+ 	/* Find out the appropriate era_action. */
+	if (irb->scsw.fctl & SCSW_FCTL_HALT_FUNC) 
+		era = dasd_era_fatal;
+	else if (irb->scsw.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END) &&
+		 irb->scsw.cstat == 0 &&
+		 !irb->esw.esw0.erw.cons)
+		era = dasd_era_none;
+	else if (irb->esw.esw0.erw.cons)
+		era = device->discipline->examine_error(cqr, irb);
+	else 
+		era = dasd_era_recover;
+
+	DBF_DEV_EVENT(DBF_DEBUG, device, "era_code %d", era);
 	expires = 0;
 	if (era == dasd_era_none) {
 		cqr->status = DASD_CQR_DONE;
@@ -1728,17 +1732,10 @@
 dasd_generic_probe (struct ccw_device *cdev,
 		    struct dasd_discipline *discipline)
 {
-	int ret = 0;
-
-	if (dasd_autodetect &&
-	    (ret = dasd_add_busid(cdev->dev.bus_id, DASD_FEATURE_DEFAULT))) {
-		printk (KERN_WARNING
-			"dasd_generic_probe: cannot autodetect %s\n",
-			cdev->dev.bus_id);
-		return ret;
-	}
+	int ret;
 
-	if (!ret && (ret = dasd_add_sysfs_files(cdev))) {
+	ret = dasd_add_sysfs_files(cdev);
+	if (ret) {
 		printk(KERN_WARNING
 		       "dasd_generic_probe: could not add driverfs entries"
 		       "for %s\n", cdev->dev.bus_id);
@@ -1754,12 +1751,11 @@
 int
 dasd_generic_remove (struct ccw_device *cdev)
 {
-	struct dasd_device *device;
-
-	device = cdev->dev.driver_data;
-	cdev->dev.driver_data = NULL;
-	if (device)
-		kfree(device);
+	/*
+	 * Nothing to remove. set_offline already removes the
+	 * dasd_device structure and the devmap information
+	 * is persistent.
+	 */
 	return 0;
 }
 
@@ -1779,24 +1775,14 @@
 		return PTR_ERR(device);
 
 	if (device->use_diag_flag)
-		device->discipline = dasd_diag_discipline_pointer;
-
-	rc = 0;
-	if (!device->discipline ||
-	    (rc = device->discipline->check_device(device))) {
-		pr_debug("device %s is not diag (%d)\n", 
-			 cdev->dev.bus_id, rc);
-		if (device->private != NULL) {
-			kfree(device->private);
-			device->private = NULL;
-		}
-		device->discipline = discipline;
-		rc = discipline->check_device(device);
-	}
-
+		discipline = dasd_diag_discipline_pointer;
+	device->discipline = discipline;
+	rc = discipline->check_device(device);
 	if (rc) {
-		printk (KERN_WARNING "dasd_generic found a bad device %s\n", 
-			cdev->dev.bus_id);
+		printk (KERN_WARNING
+			"dasd_generic couldn't online device %s "
+			"with discipline %s\n", 
+			cdev->dev.bus_id, discipline->name);
 		dasd_delete_device(device);
 		return rc;
 	}
@@ -1809,11 +1795,9 @@
 		rc = -ENODEV;
 		dasd_set_target_state(device, DASD_STATE_NEW);
 		dasd_delete_device(device);
-	} else {
+	} else
 		pr_debug("dasd_generic device %s found\n",
 				cdev->dev.bus_id);
-		cdev->dev.driver_data = device;
-	}
 
 	/* FIXME: we have to wait for the root device but we don't want
 	 * to wait for each single device but for all at once. */
@@ -1827,7 +1811,7 @@
 {
 	struct dasd_device *device;
 
-	device = cdev->dev.driver_data;
+	device = dasd_device_from_cdev(cdev);
 	dasd_set_target_state(device, DASD_STATE_NEW);
 	dasd_delete_device(device);
 	
@@ -1836,9 +1820,7 @@
 
 /*
  * Automatically online either all dasd devices (dasd_autodetect) or
- * all devices specified with dasd= parameters. For dasd_autodetect
- * dasd_generic_probe has added devmaps for all dasd devices. We
- * scan all present dasd devmaps and call ccw_device_set_online.
+ * all devices specified with dasd= parameters.
  */
 void
 dasd_generic_auto_online (struct ccw_driver *dasd_discipline_driver)
@@ -1863,97 +1845,6 @@
 	put_driver(drv);
 }
 
-/*
- * SECTION: files in sysfs
- */
-
-/*
- * readonly controls the readonly status of a dasd
- */
-static ssize_t
-dasd_ro_show(struct device *dev, char *buf)
-{
-	struct dasd_device *device;
-
-	device = dev->driver_data;
-	if (!device)
-		return snprintf(buf, PAGE_SIZE, "n/a\n");
-
-	return snprintf(buf, PAGE_SIZE, device->ro_flag ? "1\n" : "0\n");
-}
-
-static ssize_t
-dasd_ro_store(struct device *dev, const char *buf, size_t count)
-{
-	struct dasd_device *device = dev->driver_data;
-
-	if (device)
-		device->ro_flag = (buf[0] == '1') ? 1 : 0;
-	return count;
-}
-
-static DEVICE_ATTR(readonly, 0644, dasd_ro_show, dasd_ro_store);
-
-/*
- * use_diag controls whether the driver should use diag rather than ssch
- * to talk to the device
- */
-/* TODO: Implement */
-static ssize_t 
-dasd_use_diag_show(struct device *dev, char *buf)
-{
-	struct dasd_device *device;
-
-	device = dev->driver_data;
-	if (!device)
-		return sprintf(buf, "n/a\n");
-
-	return sprintf(buf, device->use_diag_flag ? "1\n" : "0\n");
-}
-
-static ssize_t
-dasd_use_diag_store(struct device *dev, const char *buf, size_t count)
-{
-	struct dasd_device *device = dev->driver_data;
-
-	if (device)
-		device->use_diag_flag = (buf[0] == '1') ? 1 : 0;
-	return count;
-}
-
-static
-DEVICE_ATTR(use_diag, 0644, dasd_use_diag_show, dasd_use_diag_store);
-
-static ssize_t
-dasd_discipline_show(struct device *dev, char *buf)
-{
-	struct dasd_device *device;
-
-	device = dev->driver_data;
-	if (!device || !device->discipline)
-		return sprintf(buf, "none\n");
-	return snprintf(buf, PAGE_SIZE, "%s\n", device->discipline->name);
-}
-
-static DEVICE_ATTR(discipline, 0444, dasd_discipline_show, NULL);
-
-static struct attribute * dasd_attrs[] = {
-	&dev_attr_readonly.attr,
-	&dev_attr_discipline.attr,
-	&dev_attr_use_diag.attr,
-	NULL,
-};
-
-static struct attribute_group dasd_attr_group = {
-	.attrs = dasd_attrs,
-};
-
-static int
-dasd_add_sysfs_files(struct ccw_device *cdev)
-{
-	return sysfs_create_group(&cdev->dev.kobj, &dasd_attr_group);
-}
-
 static int __init
 dasd_init(void)
 {
diff -urN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-s390/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	Fri Oct 17 23:43:13 2003
+++ linux-2.6-s390/drivers/s390/block/dasd_devmap.c	Tue Oct 21 16:37:36 2003
@@ -11,7 +11,7 @@
  * functions may not be called from interrupt context. In particular
  * dasd_get_device is a no-no from interrupt context.
  *
- * $Revision: 1.19 $
+ * $Revision: 1.23 $
  */
 
 #include <linux/config.h>
@@ -79,6 +79,8 @@
 static struct list_head dasd_hashlists[256];
 int dasd_max_devindex;
 
+static struct dasd_devmap *dasd_add_busid(char *, int);
+
 static inline int
 dasd_hash_busid(char *bus_id)
 {
@@ -168,12 +170,16 @@
 		*endp = str;
 		return DASD_FEATURE_DEFAULT;
 	}
+	str++;
 	features = 0;
+
 	while (1) {
 		for (len = 0; 
 		     str[len] && str[len] != ':' && str[len] != ')'; len++);
 		if (len == 2 && !strncmp(str, "ro", 2))
 			features |= DASD_FEATURE_READONLY;
+		else if (len == 4 && !strncmp(str, "diag", 4))
+			features |= DASD_FEATURE_USEDIAG;
 		else {
 			MESSAGE(KERN_WARNING,
 				"unsupported feature: %*s, "
@@ -203,6 +209,7 @@
 static inline int
 dasd_ranges_list(char *str)
 {
+	struct dasd_devmap *devmap;
 	int from, from_id0, from_id1;
 	int to, to_id0, to_id1;
 	int features, rc;
@@ -233,9 +240,9 @@
 		while (from <= to) {
 			sprintf(bus_id, "%01x.%01x.%04x",
 				from_id0, from_id1, from++);
-			rc = dasd_add_busid(bus_id, features);
-			if (rc)
-				return rc;
+			devmap = dasd_add_busid(bus_id, features);
+			if (IS_ERR(devmap))
+				return PTR_ERR(devmap);
 		}
 		if (*str != ',')
 			break;
@@ -299,7 +306,7 @@
  * added through this function will define the kdevs for the individual
  * devices. 
  */
-int
+static struct dasd_devmap *
 dasd_add_busid(char *bus_id, int features)
 {
 	struct dasd_devmap *devmap, *new, *tmp;
@@ -308,7 +315,7 @@
 	new = (struct dasd_devmap *)
 		kmalloc(sizeof(struct dasd_devmap), GFP_KERNEL);
 	if (!new)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	spin_lock(&dasd_devmap_lock);
 	devmap = 0;
 	hash = dasd_hash_busid(bus_id);
@@ -330,7 +337,7 @@
 	spin_unlock(&dasd_devmap_lock);
 	if (new)
 		kfree(new);
-	return 0;
+	return devmap;
 }
 
 /*
@@ -343,7 +350,7 @@
 	int hash;
 
 	spin_lock(&dasd_devmap_lock);
-	devmap = 0;
+	devmap = ERR_PTR(-ENODEV);
 	hash = dasd_hash_busid(bus_id);
 	list_for_each_entry(tmp, &dasd_hashlists[hash], list) {
 		if (strncmp(tmp->bus_id, bus_id, BUS_ID_SIZE) == 0) {
@@ -361,7 +368,7 @@
 int
 dasd_busid_known(char *bus_id)
 {
-	return dasd_find_busid(bus_id) ? 0 : -ENOENT;
+	return IS_ERR(dasd_find_busid(bus_id)) ? -ENOENT : 0;
 }
 
 /*
@@ -415,6 +422,28 @@
 }
 
 /*
+ * Return devmap for cdev. If no devmap exists yet, create one and
+ * connect it to the cdev.
+ */
+static struct dasd_devmap *
+dasd_devmap_from_cdev(struct ccw_device *cdev)
+{
+	struct dasd_devmap *devmap;
+
+	if (cdev->dev.driver_data)
+		return (struct dasd_devmap *) cdev->dev.driver_data;
+	devmap = dasd_find_busid(cdev->dev.bus_id);
+	if (!IS_ERR(devmap)) {
+		cdev->dev.driver_data = devmap;
+		return devmap;
+	}
+	devmap = dasd_add_busid(cdev->dev.bus_id, DASD_FEATURE_DEFAULT);
+	if (!IS_ERR(devmap))
+		cdev->dev.driver_data = devmap;
+	return devmap;
+}
+
+/*
  * Create a dasd device structure for cdev.
  */
 struct dasd_device *
@@ -424,11 +453,7 @@
 	struct dasd_device *device;
 	int rc;
 
-	rc = dasd_add_busid(cdev->dev.bus_id, DASD_FEATURE_DEFAULT);
-	if (rc)
-		return ERR_PTR(rc);
-
-	devmap = dasd_find_busid(cdev->dev.bus_id);
+	devmap = dasd_devmap_from_cdev(cdev);
 	if (IS_ERR(devmap))
 		return (void *) devmap;
 
@@ -436,29 +461,27 @@
 	if (IS_ERR(device))
 		return device;
 	atomic_set(&device->ref_count, 1);
-	device->devindex = devmap->devindex;
-	device->ro_flag = (devmap->features & DASD_FEATURE_READONLY) ? 1 : 0;
-	device->use_diag_flag = 1;
 
-	spin_lock_irq(get_ccwdev_lock(cdev));
-	if (cdev->dev.driver_data == NULL) {
+	spin_lock(&dasd_devmap_lock);
+	if (!devmap->device) {
+		devmap->device = device;
+		device->devindex = devmap->devindex;
+		device->ro_flag = 
+			(devmap->features & DASD_FEATURE_READONLY) != 0;
+		device->use_diag_flag = 
+			(devmap->features & DASD_FEATURE_USEDIAG) != 0;
 		get_device(&cdev->dev);
-		cdev->dev.driver_data = device;
 		device->cdev = cdev;
 		rc = 0;
 	} else
 		/* Someone else was faster. */
 		rc = -EBUSY;
-	spin_unlock_irq(get_ccwdev_lock(cdev));
+	spin_unlock(&dasd_devmap_lock);
+
 	if (rc) {
 		dasd_free_device(device);
 		return ERR_PTR(rc);
 	}
-	/* Device created successfully. Make it known via devmap. */
-	spin_lock(&dasd_devmap_lock);
-	devmap->device = device;
-	spin_unlock(&dasd_devmap_lock);
-
 	return device;
 }
 
@@ -489,7 +512,6 @@
 	/* Disconnect dasd_device structure from ccw_device structure. */
 	cdev = device->cdev;
 	device->cdev = NULL;
-	cdev->dev.driver_data = NULL;
 
 	/* Put ccw_device structure. */
 	put_device(&cdev->dev);
@@ -508,6 +530,146 @@
 	wake_up(&dasd_delete_wq);
 }
 
+/*
+ * Return dasd_device structure associated with cdev.
+ */
+struct dasd_device *
+dasd_device_from_cdev(struct ccw_device *cdev)
+{
+	struct dasd_devmap *devmap;
+	struct dasd_device *device;
+
+	device = ERR_PTR(-ENODEV);
+	spin_lock(&dasd_devmap_lock);
+	devmap = cdev->dev.driver_data;
+	if (devmap && devmap->device)
+		device = devmap->device;
+	spin_unlock(&dasd_devmap_lock);
+	return device;
+}
+
+/*
+ * SECTION: files in sysfs
+ */
+
+/*
+ * readonly controls the readonly status of a dasd
+ */
+static ssize_t
+dasd_ro_show(struct device *dev, char *buf)
+{
+	struct dasd_devmap *devmap;
+	int ro_flag;
+
+	devmap = dev->driver_data;
+	if (devmap)
+		ro_flag = (devmap->features & DASD_FEATURE_READONLY) != 0;
+	else
+		ro_flag = (DASD_FEATURE_DEFAULT & DASD_FEATURE_READONLY) != 0;
+	return snprintf(buf, PAGE_SIZE, ro_flag ? "1\n" : "0\n");
+}
+
+static ssize_t
+dasd_ro_store(struct device *dev, const char *buf, size_t count)
+{
+	struct dasd_devmap *devmap;
+	int ro_flag;
+
+	devmap = dasd_devmap_from_cdev(to_ccwdev(dev));
+	ro_flag = buf[0] == '1';
+	spin_lock(&dasd_devmap_lock);
+	if (ro_flag)
+		devmap->features |= DASD_FEATURE_READONLY;
+	else
+		devmap->features &= ~DASD_FEATURE_READONLY;
+	if (devmap->device) {
+		if (devmap->device->gdp)
+			set_disk_ro(devmap->device->gdp, ro_flag);
+		devmap->device->ro_flag = ro_flag;
+	}
+	spin_unlock(&dasd_devmap_lock);
+	return count;
+}
+
+static DEVICE_ATTR(readonly, 0644, dasd_ro_show, dasd_ro_store);
+
+/*
+ * use_diag controls whether the driver should use diag rather than ssch
+ * to talk to the device
+ */
+/* TODO: Implement */
+static ssize_t 
+dasd_use_diag_show(struct device *dev, char *buf)
+{
+	struct dasd_devmap *devmap;
+	int use_diag;
+
+	devmap = dev->driver_data;
+	if (devmap)
+		use_diag = (devmap->features & DASD_FEATURE_USEDIAG) != 0;
+	else
+		use_diag = (DASD_FEATURE_DEFAULT & DASD_FEATURE_USEDIAG) != 0;
+	return sprintf(buf, use_diag ? "1\n" : "0\n");
+}
+
+static ssize_t
+dasd_use_diag_store(struct device *dev, const char *buf, size_t count)
+{
+	struct dasd_devmap *devmap;
+	int use_diag;
+
+	devmap = dasd_devmap_from_cdev(to_ccwdev(dev));
+	use_diag = buf[0] == '1';
+	spin_lock(&dasd_devmap_lock);
+	/* Changing diag discipline flag is only allowed in offline state. */
+	if (!devmap->device) {
+		if (use_diag)
+			devmap->features |= DASD_FEATURE_USEDIAG;
+		else
+			devmap->features &= ~DASD_FEATURE_USEDIAG;
+	} else
+		count = -EPERM;
+	spin_unlock(&dasd_devmap_lock);
+	return count;
+}
+
+static
+DEVICE_ATTR(use_diag, 0644, dasd_use_diag_show, dasd_use_diag_store);
+
+static ssize_t
+dasd_discipline_show(struct device *dev, char *buf)
+{
+	struct dasd_devmap *devmap;
+	char *dname;
+
+	spin_lock(&dasd_devmap_lock);
+	dname = "none";
+	devmap = dev->driver_data;
+	if (devmap && devmap->device && devmap->device->discipline)
+		dname = devmap->device->discipline->name;
+	spin_unlock(&dasd_devmap_lock);
+	return snprintf(buf, PAGE_SIZE, "%s\n", dname);
+}
+
+static DEVICE_ATTR(discipline, 0444, dasd_discipline_show, NULL);
+
+static struct attribute * dasd_attrs[] = {
+	&dev_attr_readonly.attr,
+	&dev_attr_discipline.attr,
+	&dev_attr_use_diag.attr,
+	NULL,
+};
+
+static struct attribute_group dasd_attr_group = {
+	.attrs = dasd_attrs,
+};
+
+int
+dasd_add_sysfs_files(struct ccw_device *cdev)
+{
+	return sysfs_create_group(&cdev->dev.kobj, &dasd_attr_group);
+}
+
 int
 dasd_devmap_init(void)
 {
diff -urN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-s390/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	Fri Oct 17 23:43:21 2003
+++ linux-2.6-s390/drivers/s390/block/dasd_int.h	Tue Oct 21 16:37:36 2003
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.48 $
+ * $Revision: 1.49 $
  */
 
 #ifndef DASD_INT_H
@@ -474,10 +474,11 @@
 struct dasd_device *dasd_create_device(struct ccw_device *);
 void dasd_delete_device(struct dasd_device *);
 
+int dasd_add_sysfs_files(struct ccw_device *);
+struct dasd_device *dasd_device_from_cdev(struct ccw_device *);
 struct dasd_device *dasd_device_from_devindex(int);
 
 int dasd_parse(void);
-int dasd_add_busid(char *, int);
 int dasd_busid_known(char *);
 
 /* externals in dasd_gendisk.c */
diff -urN linux-2.6/include/asm-s390/dasd.h linux-2.6-s390/include/asm-s390/dasd.h
--- linux-2.6/include/asm-s390/dasd.h	Fri Oct 17 23:42:55 2003
+++ linux-2.6-s390/include/asm-s390/dasd.h	Tue Oct 21 16:37:36 2003
@@ -8,7 +8,7 @@
  * any future changes wrt the API will result in a change of the APIVERSION reported
  * to userspace by the DASDAPIVER-ioctl
  *
- * $Revision: 1.4 $
+ * $Revision: 1.5 $
  *
  */
 
@@ -69,9 +69,11 @@
  * values to be used for dasd_information_t.features
  * 0x00: default features
  * 0x01: readonly (ro)
+ * 0x02: use diag discipline (diag)
  */
 #define DASD_FEATURE_DEFAULT  0
 #define DASD_FEATURE_READONLY 1
+#define DASD_FEATURE_USEDIAG  2
 
 #define DASD_PARTN_BITS 2
 
