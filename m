Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbTJFJ1y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 05:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbTJFJ1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 05:27:54 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:55789 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263943AbTJFJZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 05:25:51 -0400
Date: Mon, 6 Oct 2003 11:25:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (3/7): dasd driver.
Message-ID: <20031006092510.GD1786@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Remove dynamic allocation of major numbers. Just use static major 94.
 - Use bus_id instead of device number where possible.
 - Don't check open_count in dasd_generic_set_offline.

diffstat:
 drivers/s390/block/dasd.c        |   52 +-----
 drivers/s390/block/dasd_devmap.c |  304 +++++++++++++++++++--------------------
 drivers/s390/block/dasd_genhd.c  |  121 +--------------
 drivers/s390/block/dasd_int.h    |    8 -
 drivers/s390/block/dasd_proc.c   |    4 
 5 files changed, 181 insertions(+), 308 deletions(-)

diff -urN linux-2.6/drivers/s390/block/dasd.c linux-2.6-s390/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	Sun Sep 28 02:50:19 2003
+++ linux-2.6-s390/drivers/s390/block/dasd.c	Mon Oct  6 10:59:19 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.110 $
+ * $Revision: 1.114 $
  */
 
 #include <linux/config.h>
@@ -1142,8 +1142,8 @@
 		req = elv_next_request(queue);
 		if (device->ro_flag && rq_data_dir(req) == WRITE) {
 			DBF_EVENT(DBF_ERR,
-				  "(%04x) Rejecting write request %p",
-				  _ccw_device_get_device_number(device->cdev),
+				  "(%s) Rejecting write request %p",
+				  device->cdev->dev.bus_id,
 				  req);
 			blkdev_dequeue_request(req);
 			dasd_end_request(req, 0);
@@ -1154,8 +1154,8 @@
 			if (PTR_ERR(cqr) == -ENOMEM)
 				break;	/* terminate request queue loop */
 			DBF_EVENT(DBF_ERR,
-				  "(%04x) CCW creation failed on request %p",
-				  _ccw_device_get_device_number(device->cdev),
+				  "(%s) CCW creation failed on request %p",
+				  device->cdev->dev.bus_id,
 				  req);
 			blkdev_dequeue_request(req);
 			dasd_end_request(req, 0);
@@ -1728,12 +1728,10 @@
 dasd_generic_probe (struct ccw_device *cdev,
 		    struct dasd_discipline *discipline)
 {
-	int devno;
 	int ret = 0;
 
-	devno = _ccw_device_get_device_number(cdev);
-	if (dasd_autodetect
-	    && (ret = dasd_add_range(devno, devno, DASD_FEATURE_DEFAULT))) {
+	if (dasd_autodetect &&
+	    (ret = dasd_add_busid(cdev->dev.bus_id, DASD_FEATURE_DEFAULT))) {
 		printk (KERN_WARNING
 			"dasd_generic_probe: cannot autodetect %s\n",
 			cdev->dev.bus_id);
@@ -1830,12 +1828,6 @@
 	struct dasd_device *device;
 
 	device = cdev->dev.driver_data;
-	if (atomic_read(&device->open_count) > 0) {
-		printk (KERN_WARNING "Can't offline dasd device with open"
-			" count = %i.\n",
-			atomic_read(&device->open_count));
-		return -EBUSY;
-	}
 	dasd_set_target_state(device, DASD_STATE_NEW);
 	dasd_delete_device(device);
 	
@@ -1854,7 +1846,6 @@
 	struct device_driver *drv;
 	struct device *d, *dev;
 	struct ccw_device *cdev;
-	int devno;
 
 	drv = get_driver(&dasd_discipline_driver->driver);
 	down_read(&drv->bus->subsys.rwsem);
@@ -1864,8 +1855,7 @@
 		if (!dev)
 			continue;
 		cdev = to_ccwdev(dev);
-		devno = _ccw_device_get_device_number(cdev);
-		if (dasd_autodetect || dasd_devno_in_range(devno) == 0)
+		if (dasd_autodetect || dasd_busid_known(cdev->dev.bus_id) == 0)
 			ccw_device_set_online(cdev);
 		put_device(dev);
 	}
@@ -1934,31 +1924,6 @@
 static
 DEVICE_ATTR(use_diag, 0644, dasd_use_diag_show, dasd_use_diag_store);
 
-#if 0
-/* this file shows the same information as /proc/dasd/devices using
- * an inaccaptable interface */
-/* TODO: Split this up into smaller files! */
-static ssize_t
-dasd_devices_show(struct device *dev, char *buf)
-{
-	
-	struct dasd_device *device;
-	dasd_devmap_t *devmap;
-
-	devmap = NULL;
-	device = dev->driver_data;
-	if (device)
-		devmap = dasd_devmap_from_devno(device->devno);
-
-	if (!devmap)
-		return sprintf(buf, "unused\n");
-
-	return min ((size_t) dasd_devices_print(devmap, buf), PAGE_SIZE);
-}
-
-static DEVICE_ATTR(dasd, 0444, dasd_devices_show, 0);
-#endif
-
 static ssize_t
 dasd_discipline_show(struct device *dev, char *buf)
 {
@@ -1973,7 +1938,6 @@
 static DEVICE_ATTR(discipline, 0444, dasd_discipline_show, NULL);
 
 static struct attribute * dasd_attrs[] = {
-	//&dev_attr_dasd.attr,
 	&dev_attr_readonly.attr,
 	&dev_attr_discipline.attr,
 	&dev_attr_use_diag.attr,
diff -urN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-s390/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	Sun Sep 28 02:50:20 2003
+++ linux-2.6-s390/drivers/s390/block/dasd_devmap.c	Mon Oct  6 10:59:19 2003
@@ -11,7 +11,7 @@
  * functions may not be called from interrupt context. In particular
  * dasd_get_device is a no-no from interrupt context.
  *
- * $Revision: 1.17 $
+ * $Revision: 1.19 $
  */
 
 #include <linux/config.h>
@@ -37,10 +37,9 @@
  * to the device index.
  */
 struct dasd_devmap {
-	struct list_head devindex_list;
-	struct list_head devno_list;
+	struct list_head list;
+	char bus_id[BUS_ID_SIZE];
         unsigned int devindex;
-        unsigned short devno;
         unsigned short features;
 	struct dasd_device *device;
 };
@@ -48,12 +47,15 @@
 /*
  * Parameter parsing functions for dasd= parameter. The syntax is:
  *   <devno>		: (0x)?[0-9a-fA-F]+
+ *   <busid>		: [0-0a-f]\.[0-9a-f]\.(0x)?[0-9a-fA-F]+
  *   <feature>		: ro
  *   <feature_list>	: \(<feature>(:<feature>)*\)
- *   <range>		: <devno>(-<devno>)?<feature_list>?
+ *   <devno-range>	: <devno>(-<devno>)?<feature_list>?
+ *   <busid-range>	: <busid>(-<busid>)?<feature_list>?
+ *   <devices>		: <devno-range>|<busid-range>
  *   <dasd_module>	: dasd_diag_mod|dasd_eckd_mod|dasd_fba_mod
  *
- *   <dasd>		: autodetect|probeonly|<range>(,<range>)*
+ *   <dasd>		: autodetect|probeonly|<devices>(,<devices>)*
  */
 
 int dasd_probeonly =  0;	/* is true, when probeonly mode is active */
@@ -74,10 +76,20 @@
 /*
  * Hash lists for devmap structures.
  */
-static struct list_head dasd_devindex_hashlists[256];
-static struct list_head dasd_devno_hashlists[256];
+static struct list_head dasd_hashlists[256];
 int dasd_max_devindex;
 
+static inline int
+dasd_hash_busid(char *bus_id)
+{
+	int hash, i;
+
+	hash = 0;
+	for (i = 0; (i < BUS_ID_SIZE) && *bus_id; i++, bus_id++)
+		hash += *bus_id;
+	return hash & 0xff;
+}
+
 #ifndef MODULE
 /*
  * The parameter parsing functions for builtin-drivers are called
@@ -98,27 +110,47 @@
 #endif	/* #ifndef MODULE */
 
 /*
- * Read a device number from a string. The number is always in hex,
- * a leading 0x is accepted.
+ * Read a device busid/devno from a string.
  */
 static inline int
-dasd_devno(char *str, char **endp)
+dasd_busid(char **str, int *id0, int *id1, int *devno)
 {
-	int val;
+	int val, old_style;
  
-	/* remove leading '0x' */
-	if (*str == '0') {
-		str++;
-		if (*str == 'x')
-			str++;
+	/* check for leading '0x' */
+	old_style = 0;
+	if ((*str)[0] == '0' && (*str)[1] == 'x') {
+		*str += 2;
+		old_style = 1;
 	}
-	/* We require at least one hex digit */
-	if (!isxdigit(*str))
+	if (!isxdigit((*str)[0]))	/* We require at least one hex digit */
+		return -EINVAL;
+	val = simple_strtoul(*str, str, 16);
+	if (old_style || (*str)[0] != '.') {
+		*id0 = *id1 = 0;
+		if (val < 0 || val > 0xffff)
+			return -EINVAL;
+		*devno = val;
+		return 0;
+	}
+	/* New style x.y.z busid */
+	if (val < 0 || val > 0xff)
+		return -EINVAL;
+	*id0 = val;
+	(*str)++;
+	if (!isxdigit((*str)[0]))	/* We require at least one hex digit */
 		return -EINVAL;
-	val = simple_strtoul(str, endp, 16);
-	if ((val > 0xFFFF) || (val < 0))
+	val = simple_strtoul(*str, str, 16);
+	if (val < 0 || val > 0xff || (*str)++[0] != '.')
 		return -EINVAL;
-	return val;
+	*id1 = val;
+	if (!isxdigit((*str)[0]))	/* We require at least one hex digit */
+		return -EINVAL;
+	val = simple_strtoul(*str, str, 16);
+	if (val < 0 || val > 0xffff)
+		return -EINVAL;
+	*devno = val;
+	return 0;
 }
 
 /*
@@ -171,18 +203,37 @@
 static inline int
 dasd_ranges_list(char *str)
 {
-	int from, to, features, rc;
+	int from, from_id0, from_id1;
+	int to, to_id0, to_id1;
+	int features, rc;
+	char bus_id[BUS_ID_SIZE+1], *orig_str;
 
+	orig_str = str;
 	while (1) {
-		to = from = dasd_devno(str, &str);
-		if (*str == '-') {
-			str++;
-			to = dasd_devno(str, &str);
+		rc = dasd_busid(&str, &from_id0, &from_id1, &from);
+		if (rc == 0) {
+			to = from;
+			to_id0 = from_id0;
+			to_id1 = from_id1;
+			if (*str == '-') {
+				str++;
+				rc = dasd_busid(&str, &to_id0, &to_id1, &to);
+			}
+		}
+		if (rc == 0 &&
+		    (from_id0 != to_id0 || from_id1 != to_id1 || from > to))
+			rc = -EINVAL;
+		if (rc) {
+			MESSAGE(KERN_ERR, "Invalid device range %s", orig_str);
+			return rc;
 		}
 		features = dasd_feature_list(str, &str);
-		/* Negative numbers in from/to/features indicate errors */
-		if (from >= 0 && to >= 0 && features >= 0) {
-			rc = dasd_add_range(from, to, features);
+		if (features < 0)
+			return -EINVAL;
+		while (from <= to) {
+			sprintf(bus_id, "%01x.%01x.%04x",
+				from_id0, from_id1, from++);
+			rc = dasd_add_busid(bus_id, features);
 			if (rc)
 				return rc;
 		}
@@ -243,77 +294,74 @@
 }
 
 /*
- * Add a range of devices and creates the corresponding devreg_t
- * structures. The order of the ranges added through this function
- * will define the kdevs for the individual devices. 
+ * Add a devmap for the device specified by busid. It is possible that
+ * the devmap already exists (dasd= parameter). The order of the devices
+ * added through this function will define the kdevs for the individual
+ * devices. 
  */
 int
-dasd_add_range(int from, int to, int features)
+dasd_add_busid(char *bus_id, int features)
 {
-	int devindex;
-	int devno;
+	struct dasd_devmap *devmap, *new, *tmp;
+	int hash;
 
-	if (from > to) {
-		MESSAGE(KERN_ERR,
-			"Invalid device range %04x-%04x", from, to);
-		return -EINVAL;
-	}
+	new = (struct dasd_devmap *)
+		kmalloc(sizeof(struct dasd_devmap), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
 	spin_lock(&dasd_devmap_lock);
-	for (devno = from; devno <= to; devno++) {
-		struct dasd_devmap *devmap, *tmp;
-
-		devmap = NULL;
-		/* Find previous devmap for device number i */
-		list_for_each_entry(tmp, &dasd_devno_hashlists[devno & 255],
-				    devno_list) {
-			if (tmp->devno == devno) {
-				devmap = tmp;
-				break;
-			}
-		}
-		if (devmap == NULL) {
-			/* This devno is new. */
-			devmap = (struct dasd_devmap *)
-				kmalloc(sizeof(struct dasd_devmap),GFP_KERNEL);
-			if (devmap == NULL)
-				return -ENOMEM;
-			devindex = dasd_max_devindex++;
-			devmap->devindex = devindex;
-			devmap->devno = devno;
-			devmap->features = features;
-			devmap->device = NULL;
-			list_add(&devmap->devindex_list,
-				 &dasd_devindex_hashlists[devindex & 255]);
-			list_add(&devmap->devno_list,
-				 &dasd_devno_hashlists[devno & 255]);
+	devmap = 0;
+	hash = dasd_hash_busid(bus_id);
+	list_for_each_entry(tmp, &dasd_hashlists[hash], list)
+		if (strncmp(tmp->bus_id, bus_id, BUS_ID_SIZE) == 0) {
+			devmap = tmp;
+			break;
 		}
+	if (!devmap) {
+		/* This bus_id is new. */
+		new->devindex = dasd_max_devindex++;
+		strncpy(new->bus_id, bus_id, BUS_ID_SIZE);
+		new->features = features;
+		new->device = 0;
+		list_add(&new->list, &dasd_hashlists[hash]);
+		devmap = new;
+		new = 0;
 	}
 	spin_unlock(&dasd_devmap_lock);
+	if (new)
+		kfree(new);
 	return 0;
 }
 
 /*
- * Check if devno has been added to the list of dasd ranges.
+ * Find devmap for device with given bus_id.
  */
-int
-dasd_devno_in_range(int devno)
+static struct dasd_devmap *
+dasd_find_busid(char *bus_id)
 {
-	struct dasd_devmap *devmap;
-	int ret;
-		
-	ret = -ENOENT;
+	struct dasd_devmap *devmap, *tmp;
+	int hash;
+
 	spin_lock(&dasd_devmap_lock);
-	/* Find devmap for device with device number devno */
-	list_for_each_entry(devmap, &dasd_devno_hashlists[devno&255],
-			    devno_list) {
-		if (devmap->devno == devno) {
-			/* Found the device. */
-			ret = 0;
+	devmap = 0;
+	hash = dasd_hash_busid(bus_id);
+	list_for_each_entry(tmp, &dasd_hashlists[hash], list) {
+		if (strncmp(tmp->bus_id, bus_id, BUS_ID_SIZE) == 0) {
+			devmap = tmp;
 			break;
 		}
 	}
 	spin_unlock(&dasd_devmap_lock);
-	return ret;
+	return devmap;
+}
+
+/*
+ * Check if busid has been added to the list of dasd ranges.
+ */
+int
+dasd_busid_known(char *bus_id)
+{
+	return dasd_find_busid(bus_id) ? 0 : -ENOENT;
 }
 
 /*
@@ -323,18 +371,15 @@
 static void
 dasd_forget_ranges(void)
 {
+	struct dasd_devmap *devmap, *n;
 	int i;
 
 	spin_lock(&dasd_devmap_lock);
 	for (i = 0; i < 256; i++) {
-		struct list_head *l, *next;
-		struct dasd_devmap *devmap;
-		list_for_each_safe(l, next, &dasd_devno_hashlists[i]) {
-			devmap = list_entry(l, struct dasd_devmap, devno_list);
+		list_for_each_entry_safe(devmap, n, &dasd_hashlists[i], list) {
 			if (devmap->device != NULL)
 				BUG();
-			list_del(&devmap->devindex_list);
-			list_del(&devmap->devno_list);
+			list_del(&devmap->list);
 			kfree(devmap);
 		}
 	}
@@ -342,64 +387,28 @@
 }
 
 /*
- * Find the devmap structure from a devno. Can be removed as soon
- * as big minors are available.
+ * Find the device struct by its device index.
  */
-static struct dasd_devmap *
-dasd_devmap_from_devno(int devno)
-{
-	struct dasd_devmap *devmap, *tmp;
-		
-	devmap = NULL;
-	spin_lock(&dasd_devmap_lock);
-	/* Find devmap for device with device number devno */
-	list_for_each_entry(tmp, &dasd_devno_hashlists[devno&255], devno_list) {
-		if (tmp->devno == devno) {
-			/* Found the device, return devmap */
-			devmap = tmp;
-			break;
-		}
-	}
-	spin_unlock(&dasd_devmap_lock);
-	return devmap;
-}
-
-/*
- * Find the devmap for a device by its device index. Can be removed
- * as soon as big minors are available.
- */
-static struct dasd_devmap *
-dasd_devmap_from_devindex(int devindex)
-{
-	struct dasd_devmap *devmap, *tmp;
-		
-	devmap = NULL;
-	spin_lock(&dasd_devmap_lock);
-	/* Find devmap for device with device index devindex */
-	list_for_each_entry(tmp, &dasd_devindex_hashlists[devindex & 255],
-			    devindex_list) {
-		if (tmp->devindex == devindex) {
-			/* Found the device, return devno */
-			devmap = tmp;
-			break;
-		}
-	}
-	spin_unlock(&dasd_devmap_lock);
-	return devmap;
-}
-
 struct dasd_device *
 dasd_device_from_devindex(int devindex)
 {
-	struct dasd_devmap *devmap;
+	struct dasd_devmap *devmap, *tmp;
 	struct dasd_device *device;
+	int i;
 
-	devmap = dasd_devmap_from_devindex(devindex);
 	spin_lock(&dasd_devmap_lock);
-	device = devmap->device;
-	if (device)
+	devmap = 0;
+	for (i = 0; (i < 256) && !devmap; i++)
+		list_for_each_entry(tmp, &dasd_hashlists[i], list)
+			if (tmp->devindex == devindex) {
+				/* Found the devmap for the device. */
+				devmap = tmp;
+				break;
+			}
+	if (devmap && devmap->device) {
+		device = devmap->device;
 		dasd_get_device(device);
-	else
+	} else
 		device = ERR_PTR(-ENODEV);
 	spin_unlock(&dasd_devmap_lock);
 	return device;
@@ -413,16 +422,15 @@
 {
 	struct dasd_devmap *devmap;
 	struct dasd_device *device;
-	int devno;
 	int rc;
 
-	devno = _ccw_device_get_device_number(cdev);
-	rc = dasd_add_range(devno, devno, DASD_FEATURE_DEFAULT);
+	rc = dasd_add_busid(cdev->dev.bus_id, DASD_FEATURE_DEFAULT);
 	if (rc)
 		return ERR_PTR(rc);
 
-	if (!(devmap = dasd_devmap_from_devno (devno)))
-		return ERR_PTR(-ENODEV);
+	devmap = dasd_find_busid(cdev->dev.bus_id);
+	if (IS_ERR(devmap))
+		return (void *) devmap;
 
 	device = dasd_alloc_device();
 	if (IS_ERR(device))
@@ -467,11 +475,9 @@
 {
 	struct ccw_device *cdev;
 	struct dasd_devmap *devmap;
-	int devno;
 
 	/* First remove device pointer from devmap. */
-	devno = _ccw_device_get_device_number(device->cdev);
-	devmap = dasd_devmap_from_devno (devno);
+	devmap = dasd_find_busid(device->cdev->dev.bus_id);
 	spin_lock(&dasd_devmap_lock);
 	devmap->device = NULL;
 	spin_unlock(&dasd_devmap_lock);
@@ -509,10 +515,8 @@
 
 	/* Initialize devmap structures. */
 	dasd_max_devindex = 0;
-	for (i = 0; i < 256; i++) {
-		INIT_LIST_HEAD(&dasd_devindex_hashlists[i]);
-		INIT_LIST_HEAD(&dasd_devno_hashlists[i]);
-	}
+	for (i = 0; i < 256; i++)
+		INIT_LIST_HEAD(&dasd_hashlists[i]);
 	return 0;
 
 }
diff -urN linux-2.6/drivers/s390/block/dasd_genhd.c linux-2.6-s390/drivers/s390/block/dasd_genhd.c
--- linux-2.6/drivers/s390/block/dasd_genhd.c	Sun Sep 28 02:50:39 2003
+++ linux-2.6-s390/drivers/s390/block/dasd_genhd.c	Mon Oct  6 10:59:19 2003
@@ -7,9 +7,9 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * Dealing with devices registered to multiple major numbers.
+ * gendisk related functions for the dasd driver.
  *
- * $Revision: 1.38 $
+ * $Revision: 1.41 $
  */
 
 #include <linux/config.h>
@@ -24,116 +24,26 @@
 
 #include "dasd_int.h"
 
-static spinlock_t dasd_major_lock = SPIN_LOCK_UNLOCKED;
-static struct list_head dasd_major_info = LIST_HEAD_INIT(dasd_major_info);
-
-struct major_info {
-	struct list_head list;
-	int major;
-};
-
-/*
- * Register major number for the dasd driver. Call with DASD_MAJOR to
- * setup the static dasd device major 94 or with 0 to allocated a major
- * dynamically.
- */
-static int
-dasd_register_major(int major)
-{
-	struct major_info *mi;
-	int new_major;
-
-	/* Allocate major info structure. */
-	mi = kmalloc(sizeof(struct major_info), GFP_KERNEL);
-
-	/* Check if one of the allocations failed. */
-	if (mi == NULL) {
-		MESSAGE(KERN_WARNING, "%s",
-			"Cannot get memory to allocate another "
-			"major number");
-		return -ENOMEM;
-	}
-
-	/* Register block device. */
-	new_major = register_blkdev(major, "dasd");
-	if (new_major < 0) {
-		kfree(mi);
-		return new_major;
-	}
-	if (major != 0)
-		new_major = major;
-
-	/* Initialize major info structure. */
-	mi->major = new_major;
-
-	/* Insert the new major info structure into dasd_major_info list. */
-	spin_lock(&dasd_major_lock);
-	list_add_tail(&mi->list, &dasd_major_info);
-	spin_unlock(&dasd_major_lock);
-
-	return 0;
-}
-
-static void
-dasd_unregister_major(struct major_info * mi)
-{
-	int rc;
-
-	if (mi == NULL)
-		return;
-
-	/* Delete the major info from dasd_major_info. */
-	spin_lock(&dasd_major_lock);
-	list_del(&mi->list);
-	spin_unlock(&dasd_major_lock);
-
-	rc = unregister_blkdev(mi->major, "dasd");
-	if (rc < 0)
-		MESSAGE(KERN_WARNING,
-			"Cannot unregister from major no %d, rc = %d",
-			mi->major, rc);
-
-	/* Free memory. */
-	kfree(mi);
-}
-
 /*
  * Allocate and register gendisk structure for device.
  */
 int
 dasd_gendisk_alloc(struct dasd_device *device)
 {
-	struct major_info *mi;
 	struct gendisk *gdp;
-	int index, len, rc;
+	int len;
+
+	/* Make sure the minor for this device exists. */
+	if (device->devindex >= DASD_PER_MAJOR)
+		return -EBUSY;
 
-	/* Make sure the major for this device exists. */
-	mi = NULL;
-	while (1) {
-		spin_lock(&dasd_major_lock);
-		index = device->devindex;
-		list_for_each_entry(mi, &dasd_major_info, list) {
-			if (index < DASD_PER_MAJOR)
-				break;
-			index -= DASD_PER_MAJOR;
-		}
-		spin_unlock(&dasd_major_lock);
-		if (index < DASD_PER_MAJOR)
-			break;
-		rc = dasd_register_major(0);
-		if (rc) {
-			DBF_EXC(DBF_ALERT, "%s", "out of major numbers!");
-			return rc;
-		}
-	}
-	
 	gdp = alloc_disk(1 << DASD_PARTN_BITS);
 	if (!gdp)
 		return -ENOMEM;
 
 	/* Initialize gendisk structure. */
-	gdp->major = mi->major;
-	gdp->first_minor = index << DASD_PARTN_BITS;
+	gdp->major = DASD_MAJOR;
+	gdp->first_minor = device->devindex << DASD_PARTN_BITS;
 	gdp->fops = &dasd_device_operations;
 	gdp->driverfs_dev = &device->cdev->dev;
 
@@ -153,8 +63,7 @@
 	}
 	len += sprintf(gdp->disk_name + len, "%c", 'a'+(device->devindex%26));
 
- 	sprintf(gdp->devfs_name, "dasd/%04x",
-		_ccw_device_get_device_number(device->cdev));
+ 	sprintf(gdp->devfs_name, "dasd/%s", device->cdev->dev.bus_id);
 
 	if (device->ro_flag)
 		set_disk_ro(gdp, 1);
@@ -173,6 +82,7 @@
 dasd_gendisk_free(struct dasd_device *device)
 {
 	del_gendisk(device->gdp);
+	device->gdp->queue = 0;
 	put_disk(device->gdp);
 	device->gdp = 0;
 }
@@ -221,7 +131,7 @@
 	int rc;
 
 	/* Register to static dasd major 94 */
-	rc = dasd_register_major(DASD_MAJOR);
+	rc = register_blkdev(DASD_MAJOR, "dasd");
 	if (rc != 0) {
 		MESSAGE(KERN_WARNING,
 			"Couldn't register successfully to "
@@ -234,10 +144,5 @@
 void
 dasd_gendisk_exit(void)
 {
-	struct list_head *l, *n;
-
-	spin_lock(&dasd_major_lock);
-	list_for_each_safe(l, n, &dasd_major_info)
-		dasd_unregister_major(list_entry(l, struct major_info, list));
-	spin_unlock(&dasd_major_lock);
+	unregister_blkdev(DASD_MAJOR, "dasd");
 }
diff -urN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-s390/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	Sun Sep 28 02:50:38 2003
+++ linux-2.6-s390/drivers/s390/block/dasd_int.h	Mon Oct  6 10:59:19 2003
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.45 $
+ * $Revision: 1.48 $
  */
 
 #ifndef DASD_INT_H
@@ -15,7 +15,7 @@
 #ifdef __KERNEL__
 
 /* we keep old device allocation scheme; IOW, minors are still in 0..255 */
-#define DASD_PER_MAJOR ( 1U<<(8-DASD_PARTN_BITS))
+#define DASD_PER_MAJOR (1U << (MINORBITS - DASD_PARTN_BITS))
 #define DASD_PARTN_MASK ((1 << DASD_PARTN_BITS) - 1)
 
 /*
@@ -477,8 +477,8 @@
 struct dasd_device *dasd_device_from_devindex(int);
 
 int dasd_parse(void);
-int dasd_add_range(int, int, int);
-int dasd_devno_in_range(int);
+int dasd_add_busid(char *, int);
+int dasd_busid_known(char *);
 
 /* externals in dasd_gendisk.c */
 int  dasd_gendisk_init(void);
diff -urN linux-2.6/drivers/s390/block/dasd_proc.c linux-2.6-s390/drivers/s390/block/dasd_proc.c
--- linux-2.6/drivers/s390/block/dasd_proc.c	Sun Sep 28 02:50:10 2003
+++ linux-2.6-s390/drivers/s390/block/dasd_proc.c	Mon Oct  6 10:59:19 2003
@@ -9,7 +9,7 @@
  *
  * /proc interface for the dasd driver.
  *
- * $Revision: 1.22 $
+ * $Revision: 1.23 $
  */
 
 #include <linux/config.h>
@@ -59,7 +59,7 @@
 	if (IS_ERR(device))
 		return 0;
 	/* Print device number. */
-	seq_printf(m, "%04x", _ccw_device_get_device_number(device->cdev));
+	seq_printf(m, "%s", device->cdev->dev.bus_id);
 	/* Print discipline string. */
 	if (device != NULL && device->discipline != NULL)
 		seq_printf(m, "(%s)", device->discipline->name);
