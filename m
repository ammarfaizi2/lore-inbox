Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbUCPOCi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbUCPOAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:00:24 -0500
Received: from mtagate7.de.ibm.com ([195.212.29.156]:52731 "EHLO
	mtagate7.de.ibm.com") by vger.kernel.org with ESMTP id S261720AbUCPNv7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:51:59 -0500
Date: Tue, 16 Mar 2004 14:51:29 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (7/10): tape driver fixes.
Message-ID: <20040316135129.GH2785@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tape driver fixes:
 - Link from ccw device to class device in sysfs.
 - Cosmetic changes.
 - Add copyright statements.

diffstat:
 drivers/s390/char/Makefile     |    4 -
 drivers/s390/char/tape.h       |    4 -
 drivers/s390/char/tape_char.c  |   47 ++++++-------------
 drivers/s390/char/tape_class.c |  101 ++++++++++++++++++++++++++---------------
 drivers/s390/char/tape_class.h |   41 +++++++++-------
 5 files changed, 109 insertions(+), 88 deletions(-)

diff -urN linux-2.6/drivers/s390/char/Makefile linux-2.6-s390/drivers/s390/char/Makefile
--- linux-2.6/drivers/s390/char/Makefile	Thu Mar 11 03:55:26 2004
+++ linux-2.6-s390/drivers/s390/char/Makefile	Tue Mar 16 14:03:13 2004
@@ -18,6 +18,6 @@
 
 tape-$(CONFIG_S390_TAPE_BLOCK) += tape_block.o
 tape-$(CONFIG_PROC_FS) += tape_proc.o
-tape-objs := tape_core.o tape_std.o tape_char.o tape_class.o $(tape-y)
-obj-$(CONFIG_S390_TAPE) += tape.o
+tape-objs := tape_core.o tape_std.o tape_char.o $(tape-y)
+obj-$(CONFIG_S390_TAPE) += tape.o tape_class.o
 obj-$(CONFIG_S390_TAPE_34XX) += tape_34xx.o
diff -urN linux-2.6/drivers/s390/char/tape.h linux-2.6-s390/drivers/s390/char/tape.h
--- linux-2.6/drivers/s390/char/tape.h	Thu Mar 11 03:55:36 2004
+++ linux-2.6-s390/drivers/s390/char/tape.h	Tue Mar 16 14:03:13 2004
@@ -199,8 +199,8 @@
 	struct list_head		node;
 
 	struct ccw_device *		cdev;
-	struct cdev *			nt;
-	struct cdev *			rt;
+	struct tape_class_device *	nt;
+	struct tape_class_device *	rt;
 
 	/* Device discipline information. */
 	struct tape_discipline *	discipline;
diff -urN linux-2.6/drivers/s390/char/tape_char.c linux-2.6-s390/drivers/s390/char/tape_char.c
--- linux-2.6/drivers/s390/char/tape_char.c	Thu Mar 11 03:55:37 2004
+++ linux-2.6-s390/drivers/s390/char/tape_char.c	Tue Mar 16 14:03:13 2004
@@ -48,38 +48,29 @@
 
 static int tapechar_major = TAPECHAR_MAJOR;
 
-struct cdev *
-tapechar_register_tape_dev(struct tape_device *device, char *name, int i)
-{
-	struct cdev *	cdev;
-	char		devname[11];
-
-	sprintf(devname, "%s%i", name, i / 2);
-	cdev = register_tape_dev(
-		&device->cdev->dev,
-		MKDEV(tapechar_major, i),
-		&tape_fops,
-		devname
-	);
-
-	return ((IS_ERR(cdev)) ? NULL : cdev);
-}
-
 /*
  * This function is called for every new tapedevice
  */
 int
 tapechar_setup_device(struct tape_device * device)
 {
-	device->nt = tapechar_register_tape_dev(
-			device,
-			"ntibm",
-			device->first_minor
+	char	device_name[20];
+
+	sprintf(device_name, "ntibm%i", device->first_minor / 2);
+	device->nt = register_tape_dev(
+		&device->cdev->dev,
+		MKDEV(tapechar_major, device->first_minor),
+		&tape_fops,
+		device_name,
+		"non-rewinding"
 	);
-	device->rt = tapechar_register_tape_dev(
-			device,
-			"rtibm",
-			device->first_minor + 1
+	device_name[0] = 'r';
+	device->rt = register_tape_dev(
+		&device->cdev->dev,
+		MKDEV(tapechar_major, device->first_minor + 1),
+		&tape_fops,
+		device_name,
+		"rewinding"
 	);
 
 	return 0;
@@ -500,9 +491,6 @@
 	tapechar_major = MAJOR(dev);
 	PRINT_INFO("tape gets major %d for character devices\n", MAJOR(dev));
 
-#ifdef TAPE390_INTERNAL_CLASS
-	tape_setup_class();
-#endif
 	return 0;
 }
 
@@ -512,9 +500,6 @@
 void
 tapechar_exit(void)
 {
-#ifdef TAPE390_INTERNAL_CLASS
-	tape_cleanup_class();
-#endif
 	PRINT_INFO("tape releases major %d for character devices\n",
 		tapechar_major);
 	unregister_chrdev_region(MKDEV(tapechar_major, 0), 256);
diff -urN linux-2.6/drivers/s390/char/tape_class.c linux-2.6-s390/drivers/s390/char/tape_class.c
--- linux-2.6/drivers/s390/char/tape_class.c	Tue Mar 16 14:02:44 2004
+++ linux-2.6-s390/drivers/s390/char/tape_class.c	Tue Mar 16 14:03:13 2004
@@ -1,4 +1,7 @@
 /*
+ * (C) Copyright IBM Corp. 2004
+ * tape_class.c ($Revision: 1.6 $)
+ *
  * Tape class device support
  *
  * Author: Stefan Bader <shbader@de.ibm.com>
@@ -6,11 +9,12 @@
  */
 #include "tape_class.h"
 
-#ifndef TAPE390_INTERNAL_CLASS
 MODULE_AUTHOR("Stefan Bader <shbader@de.ibm.com>");
-MODULE_DESCRIPTION("Tape class");
+MODULE_DESCRIPTION(
+	"(C) Copyright IBM Corp. 2004   All Rights Reserved.\n"
+	"tape_class.c ($Revision: 1.6 $)"
+);
 MODULE_LICENSE("GPL");
-#endif
 
 struct class_simple *tape_class;
 
@@ -29,69 +33,94 @@
  * devname
  *	The pointer to the name of the character device.
  */
-struct cdev *register_tape_dev(
+struct tape_class_device *register_tape_dev(
 	struct device *		device,
 	dev_t			dev,
 	struct file_operations *fops,
-	char *			devname
-) {
-	struct cdev *	cdev;
+	char *			device_name,
+	char *			mode_name)
+{
+	struct tape_class_device *	tcd;
 	int		rc;
 	char *		s;
 
-	cdev = cdev_alloc();
-	if (!cdev)
+	tcd = kmalloc(sizeof(struct tape_class_device), GFP_KERNEL);
+	if (!tcd)
 		return ERR_PTR(-ENOMEM);
 
-	cdev->owner = fops->owner;
-	cdev->ops   = fops;
-	cdev->dev   = dev;
-
-	rc = cdev_add(cdev, cdev->dev, 1);
-	if (rc) {
-		cdev_del(cdev);
-		return ERR_PTR(rc);
+	memset(tcd, 0, sizeof(struct tape_class_device));
+	strncpy(tcd->device_name, device_name, TAPECLASS_NAME_LEN);
+	for (s = strchr(tcd->device_name, '/'); s; s = strchr(s, '/'))
+		*s = '!';
+	strncpy(tcd->mode_name, mode_name, TAPECLASS_NAME_LEN);
+	for (s = strchr(tcd->mode_name, '/'); s; s = strchr(s, '/'))
+		*s = '!';
+
+	tcd->char_device = cdev_alloc();
+	if (!tcd->char_device) {
+		rc = -ENOMEM;
+		goto fail_with_tcd;
 	}
-	class_simple_device_add(tape_class, cdev->dev, device, "%s", devname);
 
-	return cdev;
+	tcd->char_device->owner = fops->owner;
+	tcd->char_device->ops   = fops;
+	tcd->char_device->dev   = dev;
+
+	rc = cdev_add(tcd->char_device, tcd->char_device->dev, 1);
+	if (rc)
+		goto fail_with_cdev;
+
+	tcd->class_device = class_simple_device_add(
+				tape_class,
+				tcd->char_device->dev,
+				device,
+				"%s", tcd->device_name
+			);
+	sysfs_create_link(
+		&device->kobj,
+		&tcd->class_device->kobj,
+		tcd->mode_name
+	);
+
+	return tcd;
+
+fail_with_cdev:
+	cdev_del(&tcd->char_device);
+
+fail_with_tcd:
+	kfree(tcd);
+
+	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL(register_tape_dev);
 
-void unregister_tape_dev(struct cdev *cdev)
+void unregister_tape_dev(struct tape_class_device *tcd)
 {
-	if (cdev != NULL) {
-		class_simple_device_remove(cdev->dev);
-		cdev_del(cdev);
+	if (tcd != NULL && !IS_ERR(tcd)) {
+		sysfs_remove_link(
+			&tcd->class_device->dev->kobj,
+			tcd->mode_name
+		);
+		class_simple_device_remove(tcd->char_device->dev);
+		cdev_del(tcd->char_device);
+		kfree(tcd);
 	}
 }
 EXPORT_SYMBOL(unregister_tape_dev);
 
 
-#ifndef TAPE390_INTERNAL_CLASS
 static int __init tape_init(void)
-#else
-int tape_setup_class(void)
-#endif
 {
 	tape_class = class_simple_create(THIS_MODULE, "tape390");
+
 	return 0;
 }
 
-#ifndef TAPE390_INTERNAL_CLASS
 static void __exit tape_exit(void)
-#else
-void tape_cleanup_class(void)
-#endif
 {
 	class_simple_destroy(tape_class);
 	tape_class = NULL;
 }
 
-#ifndef TAPE390_INTERNAL_CLASS
 postcore_initcall(tape_init);
 module_exit(tape_exit);
-#else
-EXPORT_SYMBOL(tape_setup_class);
-EXPORT_SYMBOL(tape_cleanup_class);
-#endif
diff -urN linux-2.6/drivers/s390/char/tape_class.h linux-2.6-s390/drivers/s390/char/tape_class.h
--- linux-2.6/drivers/s390/char/tape_class.h	Thu Mar 11 03:55:24 2004
+++ linux-2.6-s390/drivers/s390/char/tape_class.h	Tue Mar 16 14:03:13 2004
@@ -1,4 +1,7 @@
 /*
+ * (C) Copyright IBM Corp. 2004   All Rights Reserved.
+ * tape_class.h ($Revision: 1.4 $)
+ *
  * Tape class device support
  *
  * Author: Stefan Bader <shbader@de.ibm.com>
@@ -7,11 +10,8 @@
 #ifndef __TAPE_CLASS_H__
 #define __TAPE_CLASS_H__
 
-#if 0
 #include <linux/init.h>
 #include <linux/module.h>
-#endif
-
 #include <linux/fs.h>
 #include <linux/major.h>
 #include <linux/kobject.h>
@@ -21,34 +21,41 @@
 #include <linux/device.h>
 #include <linux/kdev_t.h>
 
-#define TAPE390_INTERNAL_CLASS
+#define TAPECLASS_NAME_LEN	32
+
+struct tape_class_device {
+	struct cdev *		char_device;
+	struct class_device *	class_device;
+	char			device_name[TAPECLASS_NAME_LEN];
+	char			mode_name[TAPECLASS_NAME_LEN];
+};
 
 /*
- * Register a tape device and return a pointer to the cdev structure.
+ * Register a tape device and return a pointer to the tape class device
+ * created by the call.
  *
  * device
  *	The pointer to the struct device of the physical (base) device.
- * drivername
- *	The pointer to the drivers name for it's character devices.
  * dev
  *	The intended major/minor number. The major number may be 0 to
  *	get a dynamic major number.
  * fops
  *	The pointer to the drivers file operations for the tape device.
- * devname
- *	The pointer to the name of the character device.
+ * device_name
+ *	Pointer to the logical device name (will also be used as kobject name
+ *	of the cdev). This can also be called the name of the tape class
+ *	device.
+ * mode_name
+ *	Points to the name of the tape mode. This creates a link with that
+ *	name from the physical device to the logical device (class).
  */
-struct cdev *register_tape_dev(
+struct tape_class_device *register_tape_dev(
 	struct device *		device,
 	dev_t			dev,
 	struct file_operations *fops,
-	char *			devname
+	char *			device_name,
+	char *			node_name
 );
-void unregister_tape_dev(struct cdev *cdev);
-
-#ifdef TAPE390_INTERNAL_CLASS
-int tape_setup_class(void);
-void tape_cleanup_class(void);
-#endif
+void unregister_tape_dev(struct tape_class_device *tcd);
 
 #endif /* __TAPE_CLASS_H__ */
