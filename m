Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbUCAI6F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 03:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbUCAI4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 03:56:25 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:32202 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262287AbUCAIwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 03:52:05 -0500
Date: Mon, 1 Mar 2004 09:51:54 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (4/5): tape class for s390 tapes.
Message-ID: <20040301085154.GE675@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 tape device driver changes:
 - Add private tape class to support udev configuration.

diffstat:
 drivers/s390/char/Makefile     |    2 
 drivers/s390/char/tape.h       |    8 ---
 drivers/s390/char/tape_block.c |    5 --
 drivers/s390/char/tape_char.c  |   65 ++++++++++++++++++++------
 drivers/s390/char/tape_class.c |  100 +++++++++++++++++++++++++++++++++++++++++
 drivers/s390/char/tape_class.h |   54 ++++++++++++++++++++++
 drivers/s390/char/tape_core.c  |   66 +--------------------------
 7 files changed, 209 insertions(+), 91 deletions(-)

diff -urN linux-2.6/drivers/s390/char/Makefile linux-2.6-s390/drivers/s390/char/Makefile
--- linux-2.6/drivers/s390/char/Makefile	Wed Feb 18 04:57:48 2004
+++ linux-2.6-s390/drivers/s390/char/Makefile	Fri Feb 27 20:05:04 2004
@@ -18,6 +18,6 @@
 
 tape-$(CONFIG_S390_TAPE_BLOCK) += tape_block.o
 tape-$(CONFIG_PROC_FS) += tape_proc.o
-tape-objs := tape_core.o tape_std.o tape_char.o $(tape-y)
+tape-objs := tape_core.o tape_std.o tape_char.o tape_class.o $(tape-y)
 obj-$(CONFIG_S390_TAPE) += tape.o
 obj-$(CONFIG_S390_TAPE_34XX) += tape_34xx.o
diff -urN linux-2.6/drivers/s390/char/tape.h linux-2.6-s390/drivers/s390/char/tape.h
--- linux-2.6/drivers/s390/char/tape.h	Wed Feb 18 04:58:43 2004
+++ linux-2.6-s390/drivers/s390/char/tape.h	Fri Feb 27 20:05:04 2004
@@ -60,12 +60,6 @@
 #define TAPEBLOCK_HSEC_S2B	2
 #define TAPEBLOCK_RETRIES	5
 
-/* Event types for hotplug */
-#define TAPE_HOTPLUG_CHAR_ADD     1
-#define TAPE_HOTPLUG_BLOCK_ADD    2
-#define TAPE_HOTPLUG_CHAR_REMOVE  3
-#define TAPE_HOTPLUG_BLOCK_REMOVE 4
-
 enum tape_medium_state {
 	MS_UNKNOWN,
 	MS_LOADED,
@@ -205,6 +199,8 @@
 	struct list_head		node;
 
 	struct ccw_device *		cdev;
+	struct cdev *			nt;
+	struct cdev *			rt;
 
 	/* Device discipline information. */
 	struct tape_discipline *	discipline;
diff -urN linux-2.6/drivers/s390/char/tape_block.c linux-2.6-s390/drivers/s390/char/tape_block.c
--- linux-2.6/drivers/s390/char/tape_block.c	Wed Feb 18 04:58:55 2004
+++ linux-2.6-s390/drivers/s390/char/tape_block.c	Fri Feb 27 20:05:04 2004
@@ -259,9 +259,6 @@
 	INIT_WORK(&blkdat->requeue_task, tapeblock_requeue,
 		tape_get_device_reference(device));
 
-	/* Will vanish */
-	tape_hotplug_event(device, tapeblock_major, TAPE_HOTPLUG_BLOCK_ADD);
-
 	return 0;
 
 cleanup_queue:
@@ -274,8 +271,6 @@
 void
 tapeblock_cleanup_device(struct tape_device *device)
 {
-	tape_hotplug_event(device, tapeblock_major, TAPE_HOTPLUG_BLOCK_REMOVE);
-
 	flush_scheduled_work();
 	device->blk_data.requeue_task.data = tape_put_device(device);
 
diff -urN linux-2.6/drivers/s390/char/tape_char.c linux-2.6-s390/drivers/s390/char/tape_char.c
--- linux-2.6/drivers/s390/char/tape_char.c	Wed Feb 18 04:59:05 2004
+++ linux-2.6-s390/drivers/s390/char/tape_char.c	Fri Feb 27 20:05:04 2004
@@ -20,6 +20,7 @@
 
 #include "tape.h"
 #include "tape_std.h"
+#include "tape_class.h"
 
 #define PRINTK_HEADER "TAPE_CHAR: "
 
@@ -47,20 +48,50 @@
 
 static int tapechar_major = TAPECHAR_MAJOR;
 
+struct cdev *
+tapechar_register_tape_dev(struct tape_device *device, char *name, int i)
+{
+	struct cdev *	cdev;
+	char		devname[11];
+
+	sprintf(devname, "%s%i", name, i / 2);
+	cdev = register_tape_dev(
+		&device->cdev->dev,
+		MKDEV(tapechar_major, i),
+		&tape_fops,
+		devname
+	);
+
+	return ((IS_ERR(cdev)) ? NULL : cdev);
+}
+
 /*
  * This function is called for every new tapedevice
  */
 int
 tapechar_setup_device(struct tape_device * device)
 {
-	tape_hotplug_event(device, tapechar_major, TAPE_HOTPLUG_CHAR_ADD);
+	device->nt = tapechar_register_tape_dev(
+			device,
+			"ntibm",
+			device->first_minor
+	);
+	device->rt = tapechar_register_tape_dev(
+			device,
+			"rtibm",
+			device->first_minor + 1
+	);
+
 	return 0;
 }
 
 void
 tapechar_cleanup_device(struct tape_device *device)
 {
-	tape_hotplug_event(device, tapechar_major, TAPE_HOTPLUG_CHAR_REMOVE);
+	unregister_tape_dev(device->rt);
+	device->rt = NULL;
+	unregister_tape_dev(device->nt);
+	device->nt = NULL;
 }
 
 /*
@@ -461,20 +492,17 @@
 int
 tapechar_init (void)
 {
-	int rc;
+	dev_t	dev;
 
-	/* Register the tape major number to the kernel */
-	rc = register_chrdev(tapechar_major, "tape", &tape_fops);
-	if (rc < 0) {
-		PRINT_ERR("can't get major %d\n", tapechar_major);
-		DBF_EVENT(3, "TCHAR:initfail\n");
-		return rc;
-	}
-	if (tapechar_major == 0)
-		tapechar_major = rc;  /* accept dynamic major number */
-	PRINT_ERR("Tape gets major %d for char device\n", tapechar_major);
-	DBF_EVENT(3, "Tape gets major %d for char device\n", rc);
-	DBF_EVENT(3, "TCHAR:init ok\n");
+	if (alloc_chrdev_region(&dev, 0, 256, "tape") != 0)
+		return -1;
+
+	tapechar_major = MAJOR(dev);
+	PRINT_INFO("tape gets major %d for character devices\n", MAJOR(dev));
+
+#ifdef TAPE390_INTERNAL_CLASS
+	tape_setup_class();
+#endif
 	return 0;
 }
 
@@ -484,5 +512,10 @@
 void
 tapechar_exit(void)
 {
-	unregister_chrdev (tapechar_major, "tape");
+#ifdef TAPE390_INTERNAL_CLASS
+	tape_cleanup_class();
+#endif
+	PRINT_INFO("tape releases major %d for character devices\n",
+		tapechar_major);
+	unregister_chrdev_region(MKDEV(tapechar_major, 0), 256);
 }
diff -urN linux-2.6/drivers/s390/char/tape_class.c linux-2.6-s390/drivers/s390/char/tape_class.c
--- linux-2.6/drivers/s390/char/tape_class.c	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/drivers/s390/char/tape_class.c	Fri Feb 27 20:05:04 2004
@@ -0,0 +1,100 @@
+/*
+ * Tape class device support
+ *
+ * Author: Stefan Bader <shbader@de.ibm.com>
+ * Based on simple class device code by Greg K-H
+ */
+#include "tape_class.h"
+
+#ifndef TAPE390_INTERNAL_CLASS
+MODULE_AUTHOR("Stefan Bader <shbader@de.ibm.com>");
+MODULE_DESCRIPTION("Tape class");
+MODULE_LICENSE("GPL");
+#endif
+
+struct class_simple *tape_class;
+
+/*
+ * Register a tape device and return a pointer to the cdev structure.
+ *
+ * device
+ *	The pointer to the struct device of the physical (base) device.
+ * drivername
+ *	The pointer to the drivers name for it's character devices.
+ * dev
+ *	The intended major/minor number. The major number may be 0 to
+ *	get a dynamic major number.
+ * fops
+ *	The pointer to the drivers file operations for the tape device.
+ * devname
+ *	The pointer to the name of the character device.
+ */
+struct cdev *register_tape_dev(
+	struct device *		device,
+	dev_t			dev,
+	struct file_operations *fops,
+	char *			devname
+) {
+	struct cdev *	cdev;
+	int		rc;
+	char *		s;
+
+	cdev = cdev_alloc();
+	if (!cdev)
+		return ERR_PTR(-ENOMEM);
+
+	cdev->owner = fops->owner;
+	cdev->ops   = fops;
+	cdev->dev   = dev;
+	strcpy(cdev->kobj.name, devname);
+	for (s = strchr(cdev->kobj.name, '/'); s; s = strchr(s, '/'))
+		*s = '!';
+
+	rc = cdev_add(cdev, cdev->dev, 1);
+	if (rc) {
+		kobject_put(&cdev->kobj);
+		return ERR_PTR(rc);
+	}
+	class_simple_device_add(tape_class, cdev->dev, device, "%s", devname);
+
+	return cdev;
+}
+EXPORT_SYMBOL(register_tape_dev);
+
+void unregister_tape_dev(struct cdev *cdev)
+{
+	if (cdev != NULL) {
+		class_simple_device_remove(cdev->dev);
+		cdev_del(cdev);
+	}
+}
+EXPORT_SYMBOL(unregister_tape_dev);
+
+
+#ifndef TAPE390_INTERNAL_CLASS
+static int __init tape_init(void)
+#else
+int tape_setup_class(void)
+#endif
+{
+	tape_class = class_simple_create(THIS_MODULE, "tape390");
+	return 0;
+}
+
+#ifndef TAPE390_INTERNAL_CLASS
+static void __exit tape_exit(void)
+#else
+void tape_cleanup_class(void)
+#endif
+{
+	class_simple_destroy(tape_class);
+	tape_class = NULL;
+}
+
+#ifndef TAPE390_INTERNAL_CLASS
+postcore_initcall(tape_init);
+module_exit(tape_exit);
+#else
+EXPORT_SYMBOL(tape_setup_class);
+EXPORT_SYMBOL(tape_cleanup_class);
+#endif
diff -urN linux-2.6/drivers/s390/char/tape_class.h linux-2.6-s390/drivers/s390/char/tape_class.h
--- linux-2.6/drivers/s390/char/tape_class.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/drivers/s390/char/tape_class.h	Fri Feb 27 20:05:04 2004
@@ -0,0 +1,54 @@
+/*
+ * Tape class device support
+ *
+ * Author: Stefan Bader <shbader@de.ibm.com>
+ * Based on simple class device code by Greg K-H
+ */
+#ifndef __TAPE_CLASS_H__
+#define __TAPE_CLASS_H__
+
+#if 0
+#include <linux/init.h>
+#include <linux/module.h>
+#endif
+
+#include <linux/fs.h>
+#include <linux/major.h>
+#include <linux/kobject.h>
+#include <linux/kobj_map.h>
+#include <linux/cdev.h>
+
+#include <linux/device.h>
+#include <linux/kdev_t.h>
+
+#define TAPE390_INTERNAL_CLASS
+
+/*
+ * Register a tape device and return a pointer to the cdev structure.
+ *
+ * device
+ *	The pointer to the struct device of the physical (base) device.
+ * drivername
+ *	The pointer to the drivers name for it's character devices.
+ * dev
+ *	The intended major/minor number. The major number may be 0 to
+ *	get a dynamic major number.
+ * fops
+ *	The pointer to the drivers file operations for the tape device.
+ * devname
+ *	The pointer to the name of the character device.
+ */
+struct cdev *register_tape_dev(
+	struct device *		device,
+	dev_t			dev,
+	struct file_operations *fops,
+	char *			devname
+);
+void unregister_tape_dev(struct cdev *cdev);
+
+#ifdef TAPE390_INTERNAL_CLASS
+int tape_setup_class(void);
+void tape_cleanup_class(void);
+#endif
+
+#endif /* __TAPE_CLASS_H__ */
diff -urN linux-2.6/drivers/s390/char/tape_core.c linux-2.6-s390/drivers/s390/char/tape_core.c
--- linux-2.6/drivers/s390/char/tape_core.c	Fri Feb 27 20:04:45 2004
+++ linux-2.6-s390/drivers/s390/char/tape_core.c	Fri Feb 27 20:05:04 2004
@@ -237,10 +237,7 @@
 
 	rc = 0;
 	for (retries = 0; retries < 5; retries++) {
-		if (retries < 2)
-			rc = ccw_device_halt(device->cdev, (long) request);
-		else
-			rc = ccw_device_clear(device->cdev, (long) request);
+		rc = ccw_device_clear(device->cdev, (long) request);
 
 		if (rc == 0) {                     /* Termination successful */
 			request->rc     = -EIO;
@@ -1016,63 +1013,6 @@
 }
 
 /*
- * Hutplug event support.
- */
-void
-tape_hotplug_event(struct tape_device *device, int devmaj, int action) {
-#ifdef CONFIG_HOTPLUG
-	char *argv[3];
-	char *envp[8];
-	char  busid[20];
-	char  major[20];
-	char  minor[20];
-
-	/* Call the busid DEVNO to be compatible with old tape.agent. */
-	sprintf(busid, "DEVNO=%s",   device->cdev->dev.bus_id);
-	sprintf(major, "MAJOR=%d",   devmaj);
-	sprintf(minor, "MINOR=%d",   device->first_minor);
-
-	argv[0] = hotplug_path;
-	argv[1] = "tape";
-	argv[2] = NULL;
-
-	envp[0] = "HOME=/";
-	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-
-	switch (action) {
-		case TAPE_HOTPLUG_CHAR_ADD:
-		case TAPE_HOTPLUG_BLOCK_ADD:
-			envp[2] = "ACTION=add";
-			break;
-		case TAPE_HOTPLUG_CHAR_REMOVE:
-		case TAPE_HOTPLUG_BLOCK_REMOVE:
-			envp[2] = "ACTION=remove";
-			break;
-		default:
-			BUG();
-	}
-	switch (action) {
-		case TAPE_HOTPLUG_CHAR_ADD:
-		case TAPE_HOTPLUG_CHAR_REMOVE:
-			envp[3] = "INTERFACE=char";
-			break;
-		case TAPE_HOTPLUG_BLOCK_ADD:
-		case TAPE_HOTPLUG_BLOCK_REMOVE:
-			envp[3] = "INTERFACE=block";
-			break;
-		default:
-			BUG();
-	}
-	envp[4] = busid;
-	envp[5] = major;
-	envp[6] = minor;
-	envp[7] = NULL;
-
-	call_usermodehelper(argv[0], argv, envp, 0);
-#endif
-}
-
-/*
  * Tape init function.
  */
 static int
@@ -1083,7 +1023,7 @@
 #ifdef DBF_LIKE_HELL
 	debug_set_level(tape_dbf_area, 6);
 #endif
-	DBF_EVENT(3, "tape init: ($Revision: 1.41 $)\n");
+	DBF_EVENT(3, "tape init: ($Revision: 1.44 $)\n");
 	tape_proc_init();
 	tapechar_init ();
 	tapeblock_init ();
@@ -1108,7 +1048,7 @@
 MODULE_AUTHOR("(C) 2001 IBM Deutschland Entwicklung GmbH by Carsten Otte and "
 	      "Michael Holzheu (cotte@de.ibm.com,holzheu@de.ibm.com)");
 MODULE_DESCRIPTION("Linux on zSeries channel attached "
-		   "tape device driver ($Revision: 1.41 $)");
+		   "tape device driver ($Revision: 1.44 $)");
 MODULE_LICENSE("GPL");
 
 module_init(tape_init);
