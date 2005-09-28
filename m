Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVI1D4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVI1D4P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 23:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVI1D4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 23:56:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23244 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751177AbVI1D4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 23:56:13 -0400
Date: Tue, 27 Sep 2005 20:55:59 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sourceforge.net,
       linux-usb-storage@lists.one-eyed-alien.net, zaitcev@redhat.com
Subject: RFC drivers/usb/storage/libusual
Message-Id: <20050927205559.078ba9ed.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my tree, I always use the following patchlet, which deconflicts
ub and usb-storage:

*** linux-2.6.14-rc1-lem/drivers/usb/storage/usb.c	2005-09-13 12:01:58.000000000 -0700
@@ -152,7 +152,9 @@ static struct usb_device_id storage_usb_
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_QIC, US_PR_BULK) },
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_UFI, US_PR_BULK) },
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_8070, US_PR_BULK) },
+#if !defined(CONFIG_BLK_DEV_UB) && !defined(CONFIG_BLK_DEV_UB_MODULE)
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_SCSI, US_PR_BULK) },
+#endif
 
 	/* Terminating entry */
 	{ }
@@ -226,8 +228,10 @@ static struct us_unusual_dev us_unusual_
 	  .useTransport = US_PR_BULK},
 	{ .useProtocol = US_SC_8070,
 	  .useTransport = US_PR_BULK},
+#if !defined(CONFIG_BLK_DEV_UB) && !defined(CONFIG_BLK_DEV_UB_MODULE)
 	{ .useProtocol = US_SC_SCSI,
 	  .useTransport = US_PR_BULK},
+#endif
 
 	/* Terminating entry */
 	{ NULL }

This makes hotplug to function in a deterministic way, which is a good
thing. The patch is not in Linus' tree. It was there at one point,
but Adrian Bunk removed it.

Why? Because he could not be bothered to understand how the hotplug
works. Before we say "how stupid", observe that he was very far from
being alone. A few other users also enabled UB (despite all the
warnings in Kconfig) and then did not know what to do when something
did not work for them. And people involved were not morons at all.
I had to explain how this was supposed to work to Doug Gilbert
and Randy Dunlap, who had considerable experience. This tells me that
the mechanisms I used here were unreasonably intricate (to put it
mildly).

Simply put, if it's not obvious, it's wrong.

So, I came up with a solution to the problem, which, I hope, is better.
It has the following features:
 - The usb_device_id table is now shared between ub and usb-storage.
 - The table is located physically in a neutral driver, libusual.
 - There is only one table. It is not split in any way.
 - Userland tricks are not used (not necesserily a good thing).
 - Devices can be marked for use by ub or usb-storage without rebuilding
   or rebooting.
 - The scheme can be useful for sharing of devices between
   HID, Wacom, and Apitek, if we like how it works for the storage.
 - Even with every kernel option enabled, the assignment defaults to
   usb-storage. Users have to add an explicit option to /etc/modprobe.conf
   before the ub gets hotplugged. Thus, the system addresses the Adrian's
   original problem.

Patch is attached. I would like someone to look it over and challenge it.
The thing looks too complex to me, but I see no other way. Anyone?

Thanks,
-- Pete

diff -urpN -X dontdiff linux-2.6.14-rc2/drivers/block/Kconfig linux-2.6.14-rc2-wip/drivers/block/Kconfig
--- linux-2.6.14-rc2/drivers/block/Kconfig	2005-09-24 20:32:32.000000000 -0700
+++ linux-2.6.14-rc2-wip/drivers/block/Kconfig	2005-09-26 00:27:56.000000000 -0700
@@ -358,7 +358,8 @@ config BLK_DEV_UB
 	  This driver supports certain USB attached storage devices
 	  such as flash keys.
 
-	  Warning: Enabling this cripples the usb-storage driver.
+	  If you enable this driver, it is recommended to avoid conflicts
+	  with usb-storage by enabling USB_LIBUSUAL.
 
 	  If unsure, say N.
 
diff -urpN -X dontdiff linux-2.6.14-rc2/drivers/block/ub.c linux-2.6.14-rc2-wip/drivers/block/ub.c
--- linux-2.6.14-rc2/drivers/block/ub.c	2005-09-24 20:32:33.000000000 -0700
+++ linux-2.6.14-rc2-wip/drivers/block/ub.c	2005-09-27 18:11:52.000000000 -0700
@@ -29,6 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/usb.h>
+#include <linux/usb_usual.h>
 #include <linux/blkdev.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/timer.h>
@@ -110,11 +111,13 @@
  * Definitions which have to be scattered once we understand the layout better.
  */
 
+#if 0 /* Subclass and protocol are in usb_usual.h now. */
 /* Transport (despite PR in the name) */
 #define US_PR_BULK	0x50		/* bulk only */
 
 /* Protocol */
 #define US_SC_SCSI	0x06		/* Transparent */
+#endif
 
 /*
  * This many LUNs per USB device.
@@ -422,13 +425,18 @@ static int ub_probe_lun(struct ub_dev *s
 
 /*
  */
+#ifdef CONFIG_USB_LIBUSUAL
+
+#define ub_usb_ids  storage_usb_ids
+#else
+
 static struct usb_device_id ub_usb_ids[] = {
-	// { USB_DEVICE_VER(0x0781, 0x0002, 0x0009, 0x0009) },	/* SDDR-31 */
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_SCSI, US_PR_BULK) },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(usb, ub_usb_ids);
+#endif /* CONFIG_USB_LIBUSUAL */
 
 /*
  * Find me a way to identify "next free minor" for add_disk(),
@@ -2466,8 +2474,7 @@ static int __init ub_init(void)
 {
 	int rc;
 
-	/* P3 */ printk("ub: sizeof ub_scsi_cmd %zu ub_dev %zu ub_lun %zu\n",
-			sizeof(struct ub_scsi_cmd), sizeof(struct ub_dev), sizeof(struct ub_lun));
+	usb_usual_set_present(USB_US_TYPE_UB, 1);
 
 	if ((rc = register_blkdev(UB_MAJOR, DRV_NAME)) != 0)
 		goto err_regblkdev;
@@ -2482,6 +2489,8 @@ err_register:
 	devfs_remove(DEVFS_NAME);
 	unregister_blkdev(UB_MAJOR, DRV_NAME);
 err_regblkdev:
+
+	usb_usual_set_present(USB_US_TYPE_UB, 0);
 	return rc;
 }
 
@@ -2491,6 +2500,7 @@ static void __exit ub_exit(void)
 
 	devfs_remove(DEVFS_NAME);
 	unregister_blkdev(UB_MAJOR, DRV_NAME);
+	usb_usual_set_present(USB_US_TYPE_UB, 0);
 }
 
 module_init(ub_init);
diff -urpN -X dontdiff linux-2.6.14-rc2/drivers/usb/storage/Kconfig linux-2.6.14-rc2-wip/drivers/usb/storage/Kconfig
--- linux-2.6.14-rc2/drivers/usb/storage/Kconfig	2005-09-24 20:32:55.000000000 -0700
+++ linux-2.6.14-rc2-wip/drivers/usb/storage/Kconfig	2005-09-26 00:35:14.000000000 -0700
@@ -123,3 +123,17 @@ config USB_STORAGE_ONETOUCH
 	  hard drive's as an input device. An action can be associated with
 	  this input in any keybinding software. (e.g. gnome's keyboard short-
 	  cuts)
+
+config USB_LIBUSUAL
+	bool "The shared table of common (or usual) storage devices"
+	depends on USB
+	help
+	  This module contains a table of common (or usual) devices
+	  for usb-storage and ub drivers, and allows to switch binding
+	  of these devices without rebuilding modules.
+
+	  Typical syntax of /etc/modprobe.conf is:
+
+		options libusual bias="ub"
+
+	  If unsure, say N.
diff -urpN -X dontdiff linux-2.6.14-rc2/drivers/usb/storage/libusual.c linux-2.6.14-rc2-wip/drivers/usb/storage/libusual.c
--- linux-2.6.14-rc2/drivers/usb/storage/libusual.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.14-rc2-wip/drivers/usb/storage/libusual.c	2005-09-27 19:33:03.000000000 -0700
@@ -0,0 +1,292 @@
+/*
+ * libusual
+ *
+ * The libusual contains the table of devices common for ub and usb-storage.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/usb_usual.h>
+#include <linux/vmalloc.h>
+
+/*
+ */
+#define USU_MOD_FL_THREAD   1	/* Thread is running */
+#define USU_MOD_FL_PRESENT  2	/* The module is loaded */
+
+struct mod_status {
+	unsigned long fls;
+};
+
+static struct mod_status stat[3];
+static DEFINE_SPINLOCK(usu_lock);
+
+/*
+ */
+#define USB_US_DEFAULT_BIAS	USB_US_TYPE_STOR
+
+#define BIAS_NAME_SIZE  (sizeof("usb-storage"))
+static char bias[BIAS_NAME_SIZE];
+static const char *bias_names[3] = { "none", "usb-storage", "ub" };
+
+static DECLARE_COMPLETION(usu_init_notify);
+static DECLARE_COMPLETION(usu_end_notify);
+static atomic_t total_threads = ATOMIC_INIT(0);
+
+static int usu_probe_thread(void *arg);
+static void bias_storage_ids(int to_bias);
+static int parse_bias(const char *bias_s);
+
+/*
+ * The UNUSUAL_DEV_FL is a version of UNUSUAL_DEV for "flags-only"
+ * devices which only need an entry in usb_device_id array.
+ * It keeps arguments for vendor and product names because
+ * they are valuable comments, even though they are not used by the code.
+ */
+
+#define UNUSUAL_DEV(id_vendor, id_product, bcdDeviceMin, bcdDeviceMax, \
+		    vendorName, productName,useProtocol, useTransport, \
+		    initFunction, flags) \
+{ USB_DEVICE_VER(id_vendor, id_product, bcdDeviceMin,bcdDeviceMax), \
+  .driver_info = (flags)|(USB_US_TYPE_STOR<<24) },
+
+#define UNUSUAL_DEV_FL(id_vendor, id_product, bcdDeviceMin, bcdDeviceMax, \
+		    vendorName, productName, \
+		    flags) \
+{ USB_DEVICE_VER(id_vendor, id_product, bcdDeviceMin,bcdDeviceMax), \
+  .driver_info = (flags)|(USB_US_TYPE_STOR<<24) },
+
+#define USUAL_DEV(useProto, useTrans) \
+	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, useProto, useTrans), \
+	  .driver_info = (USB_US_TYPE_STOR<<24) },
+
+struct usb_device_id storage_usb_ids [] = {
+#	include "unusual_devs.h"
+
+	/* Control/Bulk transport for all SubClass values */
+	USUAL_DEV(US_SC_RBC, US_PR_CB)
+	USUAL_DEV(US_SC_8020, US_PR_CB)
+	USUAL_DEV(US_SC_QIC, US_PR_CB)
+	USUAL_DEV(US_SC_UFI, US_PR_CB)
+	USUAL_DEV(US_SC_8070, US_PR_CB)
+	USUAL_DEV(US_SC_SCSI, US_PR_CB)
+
+	/* Control/Bulk/Interrupt transport for all SubClass values */
+	USUAL_DEV(US_SC_RBC, US_PR_CBI)
+	USUAL_DEV(US_SC_8020, US_PR_CBI)
+	USUAL_DEV(US_SC_QIC, US_PR_CBI)
+	USUAL_DEV(US_SC_UFI, US_PR_CBI)
+	USUAL_DEV(US_SC_8070, US_PR_CBI)
+	USUAL_DEV(US_SC_SCSI, US_PR_CBI)
+
+	/* Bulk-only transport for all SubClass values */
+	USUAL_DEV(US_SC_RBC, US_PR_BULK)
+	USUAL_DEV(US_SC_8020, US_PR_BULK)
+	USUAL_DEV(US_SC_QIC, US_PR_BULK)
+	USUAL_DEV(US_SC_UFI, US_PR_BULK)
+	USUAL_DEV(US_SC_8070, US_PR_BULK)
+	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_SCSI, US_PR_BULK),
+	  .driver_info = 0 },
+
+	/* Terminating entry */
+	{ }
+};
+
+#undef USUAL_DEV
+#undef UNUSUAL_DEV
+#undef UNUSUAL_DEV_FL
+
+MODULE_DEVICE_TABLE(usb, storage_usb_ids);
+EXPORT_SYMBOL(storage_usb_ids);
+
+/*
+ * @present: boolean, module is present
+ */
+void usb_usual_set_present(int type, int present)
+{
+	struct mod_status *st;
+	unsigned long flags;
+
+	if (type <= 0 || type >= 3)
+		return;
+	st = &stat[type];
+	spin_lock_irqsave(&usu_lock, flags);
+	st->fls &= ~USU_MOD_FL_PRESENT;
+	st->fls |= present * USU_MOD_FL_PRESENT;
+	spin_unlock_irqrestore(&usu_lock, flags);
+}
+EXPORT_SYMBOL(usb_usual_set_present);
+
+/*
+ */
+static int usu_probe(struct usb_interface *intf,
+			 const struct usb_device_id *id)
+{
+	int type = USB_US_TYPE(id->driver_info);
+	int rc;
+	unsigned long flags;
+
+	if (type == 0) {
+/* P3 */ printk("libusual: probing an unbiased device\n");
+		return -ENXIO;
+	}
+
+	spin_lock_irqsave(&usu_lock, flags);
+	if ((stat[type].fls & (USU_MOD_FL_THREAD|USU_MOD_FL_PRESENT)) != 0) {
+/* P3 */ printk("libusual: double probing for %s: 0x%lx\n",
+   bias_names[type], stat[type].fls);
+		spin_lock_irqsave(&usu_lock, flags);
+		return -ENXIO;
+	}
+	stat[type].fls |= USU_MOD_FL_THREAD;
+	spin_unlock_irqrestore(&usu_lock, flags);
+
+	rc = kernel_thread(usu_probe_thread, (void*)type, CLONE_VM);
+	if (rc < 0) {
+		printk(KERN_WARNING "libusual: "
+		    "Unable to start the thread for %s: %d\n",
+		    bias_names[type], rc);
+		spin_lock_irqsave(&usu_lock, flags);
+		stat[type].fls &= ~USU_MOD_FL_THREAD;
+		spin_unlock_irqrestore(&usu_lock, flags);
+		return rc;	/* Not being -ENXIO causes a message printed */
+	}
+	atomic_inc(&total_threads);
+
+	return -ENXIO;
+}
+
+static void usu_disconnect(struct usb_interface *intf)
+{
+	;	/* We should not be here. */
+}
+
+static struct usb_driver usu_driver = {
+	.owner =	THIS_MODULE,
+	.name =		"libusual",
+	.probe =	usu_probe,
+	.disconnect =	usu_disconnect,
+	.id_table =	storage_usb_ids,
+};
+
+/*
+ * A whole new thread for a purpose of request_module seems quite stupid.
+ * The request_module forks once inside again. However, if we attempt
+ * to load a storage module from our own modprobe thread, that module
+ * references our symbols, which cannot be resolved until our module is
+ * initialized. I wish there was a way to wait for the end of initialization.
+ * The module notifier reports MODULE_STATE_COMING only.
+ * So, we wait until module->init ends as the next best thing.
+ */
+static int usu_probe_thread(void *arg)
+{
+	int type = (unsigned long) arg;
+	struct mod_status *st = &stat[type];
+	int rc;
+	unsigned long flags;
+
+	daemonize("libusual_%d", type);	/* "usb-storage" is kinda too long */
+	wait_for_completion(&usu_init_notify);
+
+	rc = request_module(bias_names[type]);
+/* P3 */ printk("request_module(%s) ended with %d\n", bias_names[type], rc);
+
+	spin_lock_irqsave(&usu_lock, flags);
+	if (rc == 0 && (st->fls & USU_MOD_FL_PRESENT) == 0) {
+		/*
+		 * This should not happen, but let us keep tabs on it.
+		 */
+		printk(KERN_NOTICE "libusual: "
+		    "modprobe for %s succeeded, but module is not present\n",
+		    bias_names[type]);
+	}
+	st->fls &= ~USU_MOD_FL_THREAD;
+	spin_unlock_irqrestore(&usu_lock, flags);
+	complete_and_exit(&usu_end_notify, 0);
+}
+
+/*
+ */
+static void bias_storage_ids(int to_bias)
+{
+	struct usb_device_id *id;
+
+	for (id = storage_usb_ids;
+		id->idVendor || id->bDeviceClass || id->bInterfaceClass ||
+		id->driver_info;
+		    id++) {
+		if (USB_US_TYPE(id->driver_info) == 0) {
+			id->driver_info |= to_bias << 24;
+		}
+	}
+}
+
+/*
+ */
+static int __init usb_usual_init(void)
+{
+	int usb_usual_bias;
+	int rc;
+
+	bias[BIAS_NAME_SIZE-1] = 0;
+	usb_usual_bias = parse_bias(bias);
+	bias_storage_ids(usb_usual_bias);
+
+	if ((rc = usb_register(&usu_driver)) != 0) {
+		complete_and_exit(&usu_init_notify, 1);
+		return 0; /* Not reached, but whatever... */
+	}
+	complete(&usu_init_notify);
+	return 0;
+}
+
+static void __exit usb_usual_exit(void)
+{
+	/*
+	 * We do not check for any drivers present, because
+	 * they keep us pinned with symbol references.
+	 */
+
+	usb_deregister(&usu_driver);
+
+	while (atomic_read(&total_threads) > 0) {
+		wait_for_completion(&usu_end_notify);
+		atomic_dec(&total_threads);
+	}
+}
+
+/*
+ * Validate and accept the bias parameter.
+ * Maybe make an sysfs method later. XXX
+ */
+static int parse_bias(const char *bias_s)
+{
+	int i;
+	int bias_n = 0;
+
+	if (bias_s[0] == 0 || bias_s[0] == ' ') {
+		bias_n = USB_US_DEFAULT_BIAS;
+	} else {
+		for (i = 1; i < 3; i++) {
+			if (strcmp(bias_s, bias_names[i]) == 0) {
+				bias_n = i;
+				break;
+			}
+		}
+		if (bias_n == 0) {
+			bias_n = USB_US_DEFAULT_BIAS;
+			printk(KERN_INFO
+			    "libusual: unknown bias \"%s\", using \"%s\"\n",
+			    bias_s, bias_names[bias_n]);
+		}
+	}
+	return bias_n;
+}
+
+module_init(usb_usual_init);
+module_exit(usb_usual_exit);
+
+module_param_string(bias, bias, BIAS_NAME_SIZE,  S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(bias, "Bias to usb-storage or ub");
+
+MODULE_LICENSE("GPL");
diff -urpN -X dontdiff linux-2.6.14-rc2/drivers/usb/storage/Makefile linux-2.6.14-rc2-wip/drivers/usb/storage/Makefile
--- linux-2.6.14-rc2/drivers/usb/storage/Makefile	2005-09-24 20:32:55.000000000 -0700
+++ linux-2.6.14-rc2-wip/drivers/usb/storage/Makefile	2005-09-27 19:32:42.000000000 -0700
@@ -22,3 +22,7 @@ usb-storage-obj-$(CONFIG_USB_STORAGE_ONE
 
 usb-storage-objs :=	scsiglue.o protocol.o transport.o usb.o \
 			initializers.o $(usb-storage-obj-y)
+
+ifneq ($(CONFIG_USB_LIBUSUAL),)
+	obj-$(CONFIG_USB)	+= libusual.o
+endif
diff -urpN -X dontdiff linux-2.6.14-rc2/drivers/usb/storage/protocol.h linux-2.6.14-rc2-wip/drivers/usb/storage/protocol.h
--- linux-2.6.14-rc2/drivers/usb/storage/protocol.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.14-rc2-wip/drivers/usb/storage/protocol.h	2005-09-27 17:49:25.000000000 -0700
@@ -41,20 +41,6 @@
 #ifndef _PROTOCOL_H_
 #define _PROTOCOL_H_
 
-/* Sub Classes */
-
-#define US_SC_RBC	0x01		/* Typically, flash devices */
-#define US_SC_8020	0x02		/* CD-ROM */
-#define US_SC_QIC	0x03		/* QIC-157 Tapes */
-#define US_SC_UFI	0x04		/* Floppy */
-#define US_SC_8070	0x05		/* Removable media */
-#define US_SC_SCSI	0x06		/* Transparent */
-#define US_SC_ISD200    0x07		/* ISD200 ATA */
-#define US_SC_MIN	US_SC_RBC
-#define US_SC_MAX	US_SC_ISD200
-
-#define US_SC_DEVICE	0xff		/* Use device's value */
-
 /* Protocol handling routines */
 extern void usb_stor_ATAPI_command(struct scsi_cmnd*, struct us_data*);
 extern void usb_stor_qic157_command(struct scsi_cmnd*, struct us_data*);
diff -urpN -X dontdiff linux-2.6.14-rc2/drivers/usb/storage/scsiglue.c linux-2.6.14-rc2-wip/drivers/usb/storage/scsiglue.c
--- linux-2.6.14-rc2/drivers/usb/storage/scsiglue.c	2005-09-24 20:32:55.000000000 -0700
+++ linux-2.6.14-rc2-wip/drivers/usb/storage/scsiglue.c	2005-09-25 20:06:55.000000000 -0700
@@ -342,14 +342,14 @@ static int proc_info (struct Scsi_Host *
 	/* print product, vendor, and serial number strings */
 	if (us->pusb_dev->manufacturer)
 		string = us->pusb_dev->manufacturer;
-	else if (us->unusual_dev->vendorName)
+	else if (us->unusual_dev && us->unusual_dev->vendorName)
 		string = us->unusual_dev->vendorName;
 	else
 		string = "Unknown";
 	SPRINTF("       Vendor: %s\n", string);
 	if (us->pusb_dev->product)
 		string = us->pusb_dev->product;
-	else if (us->unusual_dev->productName)
+	else if (us->unusual_dev && us->unusual_dev->productName)
 		string = us->unusual_dev->productName;
 	else
 		string = "Unknown";
diff -urpN -X dontdiff linux-2.6.14-rc2/drivers/usb/storage/transport.h linux-2.6.14-rc2-wip/drivers/usb/storage/transport.h
--- linux-2.6.14-rc2/drivers/usb/storage/transport.h	2005-09-13 01:06:21.000000000 -0700
+++ linux-2.6.14-rc2-wip/drivers/usb/storage/transport.h	2005-09-27 17:50:23.000000000 -0700
@@ -44,36 +44,6 @@
 #include <linux/config.h>
 #include <linux/blkdev.h>
 
-/* Protocols */
-
-#define US_PR_CBI	0x00		/* Control/Bulk/Interrupt */
-#define US_PR_CB	0x01		/* Control/Bulk w/o interrupt */
-#define US_PR_BULK	0x50		/* bulk only */
-#ifdef CONFIG_USB_STORAGE_USBAT
-#define US_PR_SCM_ATAPI	0x80		/* SCM-ATAPI bridge */
-#endif
-#ifdef CONFIG_USB_STORAGE_SDDR09
-#define US_PR_EUSB_SDDR09	0x81	/* SCM-SCSI bridge for SDDR-09 */
-#endif
-#ifdef CONFIG_USB_STORAGE_SDDR55
-#define US_PR_SDDR55	0x82		/* SDDR-55 (made up) */
-#endif
-#define US_PR_DPCM_USB  0xf0		/* Combination CB/SDDR09 */
-
-#ifdef CONFIG_USB_STORAGE_FREECOM
-#define US_PR_FREECOM   0xf1		/* Freecom */
-#endif
-
-#ifdef CONFIG_USB_STORAGE_DATAFAB
-#define US_PR_DATAFAB   0xf2		/* Datafab chipsets */
-#endif
-
-#ifdef CONFIG_USB_STORAGE_JUMPSHOT
-#define US_PR_JUMPSHOT  0xf3		/* Lexar Jumpshot */
-#endif
-
-#define US_PR_DEVICE	0xff		/* Use device's value */
-
 /*
  * Bulk only data structures
  */
diff -urpN -X dontdiff linux-2.6.14-rc2/drivers/usb/storage/unusual_devs.h linux-2.6.14-rc2-wip/drivers/usb/storage/unusual_devs.h
--- linux-2.6.14-rc2/drivers/usb/storage/unusual_devs.h	2005-09-24 20:32:56.000000000 -0700
+++ linux-2.6.14-rc2-wip/drivers/usb/storage/unusual_devs.h	2005-09-25 20:56:07.000000000 -0700
@@ -50,74 +50,68 @@
 
 /* patch submitted by Vivian Bregier <Vivian.Bregier@imag.fr>
  */
-UNUSUAL_DEV(  0x03eb, 0x2002, 0x0100, 0x0100,
+UNUSUAL_DEV_FL( 0x03eb, 0x2002, 0x0100, 0x0100,
                 "ATMEL",
                 "SND1 Storage",
-                US_SC_DEVICE, US_PR_DEVICE, NULL,
-                US_FL_IGNORE_RESIDUE),
+                US_FL_IGNORE_RESIDUE)
 
-UNUSUAL_DEV(  0x03ee, 0x6901, 0x0000, 0x0100,
+UNUSUAL_DEV_FL( 0x03ee, 0x6901, 0x0000, 0x0100,
 		"Mitsumi",
 		"USB FDD",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 
 UNUSUAL_DEV(  0x03f0, 0x0107, 0x0200, 0x0200, 
 		"HP",
 		"CD-Writer+",
-		US_SC_8070, US_PR_CB, NULL, 0), 
+		US_SC_8070, US_PR_CB, NULL, 0)
 
 #ifdef CONFIG_USB_STORAGE_USBAT
 UNUSUAL_DEV(  0x03f0, 0x0207, 0x0001, 0x0001, 
 		"HP",
 		"CD-Writer+ 8200e",
-		US_SC_8070, US_PR_SCM_ATAPI, init_usbat, 0), 
+		US_SC_8070, US_PR_SCM_ATAPI, init_usbat, 0)
 
 UNUSUAL_DEV(  0x03f0, 0x0307, 0x0001, 0x0001, 
 		"HP",
 		"CD-Writer+ CD-4e",
-		US_SC_8070, US_PR_SCM_ATAPI, init_usbat, 0), 
+		US_SC_8070, US_PR_SCM_ATAPI, init_usbat, 0)
 #endif
 
 /* Patch submitted by Mihnea-Costin Grigore <mihnea@zulu.ro> */
-UNUSUAL_DEV(  0x040d, 0x6205, 0x0003, 0x0003,
+UNUSUAL_DEV_FL( 0x040d, 0x6205, 0x0003, 0x0003,
 		"VIA Technologies Inc.",
 		"USB 2.0 Card Reader",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_IGNORE_RESIDUE ),
+		US_FL_IGNORE_RESIDUE )
 
 /* Reported by Sebastian Kapfer <sebastian_kapfer@gmx.net>
  * and Olaf Hering <olh@suse.de> (different bcd's, same vendor/product)
  * for USB floppies that need the SINGLE_LUN enforcement.
  */
-UNUSUAL_DEV(  0x0409, 0x0040, 0x0000, 0x9999,
+UNUSUAL_DEV_FL( 0x0409, 0x0040, 0x0000, 0x9999,
 		"NEC",
 		"NEC USB UF000x",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 
 /* Deduced by Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
  * Entry needed for flags: US_FL_FIX_INQUIRY because initial inquiry message
  * always fails and confuses drive.
  */
-UNUSUAL_DEV(  0x0411, 0x001c, 0x0113, 0x0113,
+UNUSUAL_DEV_FL( 0x0411, 0x001c, 0x0113, 0x0113,
 		"Buffalo",
 		"DUB-P40G HDD",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_INQUIRY ),
+		US_FL_FIX_INQUIRY )
 
 /* Reported by Olaf Hering <olh@suse.de> from novell bug #105878 */
-UNUSUAL_DEV(  0x0424, 0x0fdc, 0x0210, 0x0210,
+UNUSUAL_DEV_FL( 0x0424, 0x0fdc, 0x0210, 0x0210,
 		"SMSC",
 		"FDC GOLD-2.30",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 
 #ifdef CONFIG_USB_STORAGE_DPCM
 UNUSUAL_DEV(  0x0436, 0x0005, 0x0100, 0x0100,
 		"Microtech",
 		"CameraMate (DPCM_USB)",
- 		US_SC_SCSI, US_PR_DPCM_USB, NULL, 0 ),
+ 		US_SC_SCSI, US_PR_DPCM_USB, NULL, 0 )
 #endif
 
 /*
@@ -125,36 +119,35 @@ UNUSUAL_DEV(  0x0436, 0x0005, 0x0100, 0x
  * The key does not actually break, but it returns zero sense which
  * makes our SCSI stack to print confusing messages.
  */
-UNUSUAL_DEV(  0x0457, 0x0150, 0x0100, 0x0100,
+UNUSUAL_DEV_FL( 0x0457, 0x0150, 0x0100, 0x0100,
 		"USBest Technology",	/* sold by Transcend */
 		"USB Mass Storage Device",
-		US_SC_DEVICE, US_PR_DEVICE, NULL, US_FL_NOT_LOCKABLE ),
+		US_FL_NOT_LOCKABLE )
 
 /* Patch submitted by Daniel Drake <dsd@gentoo.org>
  * Device reports nonsense bInterfaceProtocol 6 when connected over USB2 */
-UNUSUAL_DEV(  0x0451, 0x5416, 0x0100, 0x0100,
+UNUSUAL_DEV_FL( 0x0451, 0x5416, 0x0100, 0x0100,
 		"Neuros Audio",
 		"USB 2.0 HD 2.5",
-		US_SC_DEVICE, US_PR_BULK, NULL,
-		US_FL_NEED_OVERRIDE ),
+		US_FL_NEED_OVERRIDE )
 
 /* Patch submitted by Philipp Friedrich <philipp@void.at> */
 UNUSUAL_DEV(  0x0482, 0x0100, 0x0100, 0x0100,
 		"Kyocera",
 		"Finecam S3x",
-		US_SC_8070, US_PR_CB, NULL, US_FL_FIX_INQUIRY),
+		US_SC_8070, US_PR_CB, NULL, US_FL_FIX_INQUIRY)
 
 /* Patch submitted by Philipp Friedrich <philipp@void.at> */
 UNUSUAL_DEV(  0x0482, 0x0101, 0x0100, 0x0100,
 		"Kyocera",
 		"Finecam S4",
-		US_SC_8070, US_PR_CB, NULL, US_FL_FIX_INQUIRY),
+		US_SC_8070, US_PR_CB, NULL, US_FL_FIX_INQUIRY)
 
 /* Patch submitted by Stephane Galles <stephane.galles@free.fr> */
-UNUSUAL_DEV(  0x0482, 0x0103, 0x0100, 0x0100,
+UNUSUAL_DEV_FL( 0x0482, 0x0103, 0x0100, 0x0100,
 		"Kyocera",
 		"Finecam S5",
-		US_SC_DEVICE, US_PR_DEVICE, NULL, US_FL_FIX_INQUIRY),
+		US_FL_FIX_INQUIRY)
 
 /* Patch for Kyocera Finecam L3
  * Submitted by Michael Krauth <michael.krauth@web.de>
@@ -164,44 +157,42 @@ UNUSUAL_DEV(  0x0482, 0x0105, 0x0100, 0x
 		"Kyocera",
 		"Finecam L3",
 		US_SC_SCSI, US_PR_BULK, NULL,
-		US_FL_FIX_INQUIRY),
+		US_FL_FIX_INQUIRY)
 
 /* Reported by Paul Stewart <stewart@wetlogic.net>
  * This entry is needed because the device reports Sub=ff */
 UNUSUAL_DEV(  0x04a4, 0x0004, 0x0001, 0x0001,
 		"Hitachi",
 		"DVD-CAM DZ-MV100A Camcorder",
-		US_SC_SCSI, US_PR_CB, NULL, US_FL_SINGLE_LUN),
+		US_SC_SCSI, US_PR_CB, NULL, US_FL_SINGLE_LUN)
 
 /* Reported by Andreas Bockhold <andreas@bockionline.de> */
-UNUSUAL_DEV(  0x04b0, 0x0405, 0x0100, 0x0100,
+UNUSUAL_DEV_FL( 0x04b0, 0x0405, 0x0100, 0x0100,
 		"NIKON",
 		"NIKON DSC D70",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_CAPACITY),
+		US_FL_FIX_CAPACITY)
 
 /* BENQ DC5330
  * Reported by Manuel Fombuena <mfombuena@ya.com> and
  * Frank Copeland <fjc@thingy.apana.org.au> */
-UNUSUAL_DEV(  0x04a5, 0x3010, 0x0100, 0x0100,
+UNUSUAL_DEV_FL( 0x04a5, 0x3010, 0x0100, 0x0100,
 		"Tekom Technologies, Inc",
 		"300_CAMERA",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_IGNORE_RESIDUE ),
+		US_FL_IGNORE_RESIDUE )
 
 /* Reported by Simon Levitt <simon@whattf.com>
  * This entry needs Sub and Proto fields */
 UNUSUAL_DEV(  0x04b8, 0x0601, 0x0100, 0x0100,
 		"Epson",
 		"875DC Storage",
-		US_SC_SCSI, US_PR_CB, NULL, US_FL_FIX_INQUIRY),
+		US_SC_SCSI, US_PR_CB, NULL, US_FL_FIX_INQUIRY)
 
 /* Reported by Khalid Aziz <khalid@gonehiking.org>
  * This entry is needed because the device reports Sub=ff */
 UNUSUAL_DEV(  0x04b8, 0x0602, 0x0110, 0x0110,
 		"Epson",
 		"785EPX Storage",
-		US_SC_SCSI, US_PR_BULK, NULL, US_FL_SINGLE_LUN),
+		US_SC_SCSI, US_PR_BULK, NULL, US_FL_SINGLE_LUN)
 
 /* Not sure who reported this originally but
  * Pavel Machek <pavel@ucw.cz> reported that the extra US_FL_SINGLE_LUN
@@ -209,16 +200,15 @@ UNUSUAL_DEV(  0x04b8, 0x0602, 0x0110, 0x
 UNUSUAL_DEV(  0x04cb, 0x0100, 0x0000, 0x2210,
 		"Fujifilm",
 		"FinePix 1400Zoom",
-		US_SC_UFI, US_PR_DEVICE, NULL, US_FL_FIX_INQUIRY | US_FL_SINGLE_LUN),
+		US_SC_UFI, US_PR_DEVICE, NULL, US_FL_FIX_INQUIRY | US_FL_SINGLE_LUN)
 
 /* Reported by Peter Wächtler <pwaechtler@loewe-komp.de>
  * The device needs the flags only.
  */
-UNUSUAL_DEV(  0x04ce, 0x0002, 0x0074, 0x0074,
+UNUSUAL_DEV_FL( 0x04ce, 0x0002, 0x0074, 0x0074,
 		"ScanLogic",
 		"SL11R-IDE",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_INQUIRY),
+		US_FL_FIX_INQUIRY)
 
 /* Reported by Kriston Fincher <kriston@airmail.net>
  * Patch submitted by Sean Millichamp <sean@bruenor.org>
@@ -228,21 +218,20 @@ UNUSUAL_DEV(  0x04ce, 0x0002, 0x0074, 0x
 UNUSUAL_DEV(  0x04da, 0x0901, 0x0100, 0x0200,
 		"Panasonic",
 		"LS-120 Camera",
-		US_SC_UFI, US_PR_DEVICE, NULL, 0),
+		US_SC_UFI, US_PR_DEVICE, NULL, 0)
 
 /* From Yukihiro Nakai, via zaitcev@yahoo.com.
  * This is needed for CB instead of CBI */
 UNUSUAL_DEV(  0x04da, 0x0d05, 0x0000, 0x0000,
 		"Sharp CE-CW05",
 		"CD-R/RW Drive",
-		US_SC_8070, US_PR_CB, NULL, 0),
+		US_SC_8070, US_PR_CB, NULL, 0)
 
 /* Reported by Adriaan Penning <a.penning@luon.net> */
-UNUSUAL_DEV(  0x04da, 0x2372, 0x0000, 0x9999,
+UNUSUAL_DEV_FL( 0x04da, 0x2372, 0x0000, 0x9999,
 		"Panasonic",
 		"DMC-LCx Camera",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_CAPACITY | US_FL_NOT_LOCKABLE ),
+		US_FL_FIX_CAPACITY | US_FL_NOT_LOCKABLE )
 
 /* Most of the following entries were developed with the help of
  * Shuttle/SCM directly.
@@ -250,27 +239,27 @@ UNUSUAL_DEV(  0x04da, 0x2372, 0x0000, 0x
 UNUSUAL_DEV(  0x04e6, 0x0001, 0x0200, 0x0200, 
 		"Matshita",
 		"LS-120",
-		US_SC_8020, US_PR_CB, NULL, 0),
+		US_SC_8020, US_PR_CB, NULL, 0)
 
 UNUSUAL_DEV(  0x04e6, 0x0002, 0x0100, 0x0100, 
 		"Shuttle",
 		"eUSCSI Bridge",
 		US_SC_DEVICE, US_PR_DEVICE, usb_stor_euscsi_init, 
-		US_FL_SCM_MULT_TARG ), 
+		US_FL_SCM_MULT_TARG )
 
 #ifdef CONFIG_USB_STORAGE_SDDR09
 UNUSUAL_DEV(  0x04e6, 0x0003, 0x0000, 0x9999, 
 		"Sandisk",
 		"ImageMate SDDR09",
 		US_SC_SCSI, US_PR_EUSB_SDDR09, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 
 /* This entry is from Andries.Brouwer@cwi.nl */
 UNUSUAL_DEV(  0x04e6, 0x0005, 0x0100, 0x0208,
 		"SCM Microsystems",
 		"eUSB SmartMedia / CompactFlash Adapter",
 		US_SC_SCSI, US_PR_DPCM_USB, sddr09_init, 
-		0), 
+		0)
 #endif
 
 /* Reported by Markus Demleitner <msdemlei@cl.uni-heidelberg.de> */
@@ -278,65 +267,64 @@ UNUSUAL_DEV(  0x04e6, 0x0006, 0x0100, 0x
 		"SCM Microsystems Inc.",
 		"eUSB MMC Adapter",
 		US_SC_SCSI, US_PR_CB, NULL, 
-		US_FL_SINGLE_LUN), 
+		US_FL_SINGLE_LUN)
 
 /* Reported by Daniel Nouri <dpunktnpunkt@web.de> */
 UNUSUAL_DEV(  0x04e6, 0x0006, 0x0205, 0x0205, 
 		"Shuttle",
 		"eUSB MMC Adapter",
 		US_SC_SCSI, US_PR_DEVICE, NULL, 
-		US_FL_SINGLE_LUN), 
+		US_FL_SINGLE_LUN)
 
 UNUSUAL_DEV(  0x04e6, 0x0007, 0x0100, 0x0200, 
 		"Sony",
 		"Hifd",
 		US_SC_SCSI, US_PR_CB, NULL, 
-		US_FL_SINGLE_LUN), 
+		US_FL_SINGLE_LUN)
 
 UNUSUAL_DEV(  0x04e6, 0x0009, 0x0200, 0x0200, 
 		"Shuttle",
 		"eUSB ATA/ATAPI Adapter",
-		US_SC_8020, US_PR_CB, NULL, 0),
+		US_SC_8020, US_PR_CB, NULL, 0)
 
 UNUSUAL_DEV(  0x04e6, 0x000a, 0x0200, 0x0200, 
 		"Shuttle",
 		"eUSB CompactFlash Adapter",
-		US_SC_8020, US_PR_CB, NULL, 0),
+		US_SC_8020, US_PR_CB, NULL, 0)
 
 UNUSUAL_DEV(  0x04e6, 0x000B, 0x0100, 0x0100, 
 		"Shuttle",
 		"eUSCSI Bridge",
 		US_SC_SCSI, US_PR_BULK, usb_stor_euscsi_init, 
-		US_FL_SCM_MULT_TARG ), 
+		US_FL_SCM_MULT_TARG )
 
 UNUSUAL_DEV(  0x04e6, 0x000C, 0x0100, 0x0100, 
 		"Shuttle",
 		"eUSCSI Bridge",
 		US_SC_SCSI, US_PR_BULK, usb_stor_euscsi_init, 
-		US_FL_SCM_MULT_TARG ), 
+		US_FL_SCM_MULT_TARG )
 
 UNUSUAL_DEV(  0x04e6, 0x0101, 0x0200, 0x0200, 
 		"Shuttle",
 		"CD-RW Device",
-		US_SC_8020, US_PR_CB, NULL, 0),
+		US_SC_8020, US_PR_CB, NULL, 0)
 
 /* Entry and supporting patch by Theodore Kilgore <kilgota@auburn.edu>.
  * Device uses standards-violating 32-byte Bulk Command Block Wrappers and
  * reports itself as "Proprietary SCSI Bulk." Cf. device entry 0x084d:0x0011.
  */
 
-UNUSUAL_DEV(  0x04fc, 0x80c2, 0x0100, 0x0100,
+UNUSUAL_DEV_FL( 0x04fc, 0x80c2, 0x0100, 0x0100,
 		"Kobian Mercury",
 		"Binocam DCB-132",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_BULK32),
+		US_FL_BULK32)
 
 #ifdef CONFIG_USB_STORAGE_USBAT
 UNUSUAL_DEV(  0x04e6, 0x1010, 0x0000, 0x9999,
 		"SCM",
 		"SCM USBAT-02",
 		US_SC_SCSI, US_PR_SCM_ATAPI, init_usbat,
-		US_FL_SINGLE_LUN),
+		US_FL_SINGLE_LUN)
 #endif
 
 /* Reported by Bob Sass <rls@vectordb.com> -- only rev 1.33 tested */
@@ -344,7 +332,7 @@ UNUSUAL_DEV(  0x050d, 0x0115, 0x0133, 0x
 		"Belkin",
 		"USB SCSI Adaptor",
 		US_SC_SCSI, US_PR_BULK, usb_stor_euscsi_init,
-		US_FL_SCM_MULT_TARG ),
+		US_FL_SCM_MULT_TARG )
 
 /* Iomega Clik! Drive 
  * Reported by David Chatenay <dchatenay@hotmail.com>
@@ -354,170 +342,156 @@ UNUSUAL_DEV(  0x0525, 0xa140, 0x0100, 0x
 		"Iomega",
 		"USB Clik! 40",
 		US_SC_8070, US_PR_BULK, NULL,
-		US_FL_FIX_INQUIRY ),
+		US_FL_FIX_INQUIRY )
 
 /* Yakumo Mega Image 37
  * Submitted by Stephan Fuhrmann <atomenergie@t-online.de> */
-UNUSUAL_DEV(  0x052b, 0x1801, 0x0100, 0x0100,
+UNUSUAL_DEV_FL( 0x052b, 0x1801, 0x0100, 0x0100,
 		"Tekom Technologies, Inc",
 		"300_CAMERA",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_IGNORE_RESIDUE ),
+		US_FL_IGNORE_RESIDUE )
 
 /* Another Yakumo camera.
  * Reported by Michele Alzetta <michele.alzetta@aliceposta.it> */
-UNUSUAL_DEV(  0x052b, 0x1804, 0x0100, 0x0100,
+UNUSUAL_DEV_FL( 0x052b, 0x1804, 0x0100, 0x0100,
 		"Tekom Technologies, Inc",
 		"300_CAMERA",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_IGNORE_RESIDUE ),
+		US_FL_IGNORE_RESIDUE )
 
 /* Reported by Iacopo Spalletti <avvisi@spalletti.it> */
-UNUSUAL_DEV(  0x052b, 0x1807, 0x0100, 0x0100,
+UNUSUAL_DEV_FL( 0x052b, 0x1807, 0x0100, 0x0100,
 		"Tekom Technologies, Inc",
 		"300_CAMERA",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_IGNORE_RESIDUE ),
+		US_FL_IGNORE_RESIDUE )
 
 /* Yakumo Mega Image 47
  * Reported by Bjoern Paetzel <kolrabi@kolrabi.de> */
-UNUSUAL_DEV(  0x052b, 0x1905, 0x0100, 0x0100,
+UNUSUAL_DEV_FL( 0x052b, 0x1905, 0x0100, 0x0100,
 		"Tekom Technologies, Inc",
 		"400_CAMERA",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_IGNORE_RESIDUE ),
+		US_FL_IGNORE_RESIDUE )
 
 /* Reported by Paul Ortyl <ortylp@3miasto.net>
  * Note that it's similar to the device above, only different prodID */
-UNUSUAL_DEV(  0x052b, 0x1911, 0x0100, 0x0100,
+UNUSUAL_DEV_FL( 0x052b, 0x1911, 0x0100, 0x0100,
 		"Tekom Technologies, Inc",
 		"400_CAMERA",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_IGNORE_RESIDUE ),
+		US_FL_IGNORE_RESIDUE )
 
 UNUSUAL_DEV(  0x054c, 0x0010, 0x0106, 0x0450, 
 		"Sony",
 		"DSC-S30/S70/S75/505V/F505/F707/F717/P8", 
 		US_SC_SCSI, US_PR_DEVICE, NULL,
-		US_FL_SINGLE_LUN | US_FL_NOT_LOCKABLE | US_FL_NO_WP_DETECT ),
+		US_FL_SINGLE_LUN | US_FL_NOT_LOCKABLE | US_FL_NO_WP_DETECT )
 
 /* This entry is needed because the device reports Sub=ff */
 UNUSUAL_DEV(  0x054c, 0x0010, 0x0500, 0x0500, 
                "Sony",
                "DSC-T1", 
                US_SC_8070, US_PR_DEVICE, NULL,
-               US_FL_SINGLE_LUN ),
+               US_FL_SINGLE_LUN )
 
 
 /* Reported by wim@geeks.nl */
-UNUSUAL_DEV(  0x054c, 0x0025, 0x0100, 0x0100, 
+UNUSUAL_DEV_FL( 0x054c, 0x0025, 0x0100, 0x0100, 
 		"Sony",
 		"Memorystick NW-MS7",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 
 #ifdef CONFIG_USB_STORAGE_ISD200
 UNUSUAL_DEV(  0x054c, 0x002b, 0x0100, 0x0110,
 		"Sony",
 		"Portable USB Harddrive V2",
 		US_SC_ISD200, US_PR_BULK, isd200_Initialization,
-		0 ),
+		0 )
 #endif
 
 /* Submitted by Olaf Hering, <olh@suse.de> SuSE Bugzilla #49049 */
-UNUSUAL_DEV(  0x054c, 0x002c, 0x0501, 0x0501,
+UNUSUAL_DEV_FL( 0x054c, 0x002c, 0x0501, 0x0501,
 		"Sony",
 		"USB Floppy Drive",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 
-UNUSUAL_DEV(  0x054c, 0x002d, 0x0100, 0x0100, 
+UNUSUAL_DEV_FL( 0x054c, 0x002d, 0x0100, 0x0100, 
 		"Sony",
 		"Memorystick MSAC-US1",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 
 /* Submitted by Klaus Mueller <k.mueller@intershop.de> */
 UNUSUAL_DEV(  0x054c, 0x002e, 0x0106, 0x0310, 
 		"Sony",
 		"Handycam",
 		US_SC_SCSI, US_PR_DEVICE, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 
 /* Submitted by Rajesh Kumble Nayak <nayak@obs-nice.fr> */
 UNUSUAL_DEV(  0x054c, 0x002e, 0x0500, 0x0500, 
 		"Sony",
 		"Handycam HC-85",
 		US_SC_UFI, US_PR_DEVICE, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 
-UNUSUAL_DEV(  0x054c, 0x0032, 0x0000, 0x9999,
+UNUSUAL_DEV_FL( 0x054c, 0x0032, 0x0000, 0x9999,
 		"Sony",
 		"Memorystick MSC-U01N",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 
 /* Submitted by Michal Mlotek <mlotek@foobar.pl> */
-UNUSUAL_DEV(  0x054c, 0x0058, 0x0000, 0x9999,
+UNUSUAL_DEV_FL( 0x054c, 0x0058, 0x0000, 0x9999,
 		"Sony",
 		"PEG N760c Memorystick",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_INQUIRY ),
+		US_FL_FIX_INQUIRY )
 		
 UNUSUAL_DEV(  0x054c, 0x0069, 0x0000, 0x9999,
 		"Sony",
 		"Memorystick MSC-U03",
 		US_SC_UFI, US_PR_CB, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 
 /* Submitted by Nathan Babb <nathan@lexi.com> */
-UNUSUAL_DEV(  0x054c, 0x006d, 0x0000, 0x9999,
+UNUSUAL_DEV_FL( 0x054c, 0x006d, 0x0000, 0x9999,
 		"Sony",
 		"PEG Mass Storage",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_INQUIRY ),
+		US_FL_FIX_INQUIRY )
 
 /* Submitted by Mike Alborn <malborn@deandra.homeip.net> */
-UNUSUAL_DEV(  0x054c, 0x016a, 0x0000, 0x9999,
+UNUSUAL_DEV_FL( 0x054c, 0x016a, 0x0000, 0x9999,
 		"Sony",
 		"PEG Mass Storage",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_INQUIRY ),
+		US_FL_FIX_INQUIRY )
 		
 /* Submitted by Frank Engel <frankie@cse.unsw.edu.au> */
-UNUSUAL_DEV(  0x054c, 0x0099, 0x0000, 0x9999,
+UNUSUAL_DEV_FL( 0x054c, 0x0099, 0x0000, 0x9999,
                 "Sony",
                 "PEG Mass Storage",
-                US_SC_DEVICE, US_PR_DEVICE, NULL,
-                US_FL_FIX_INQUIRY ),
+                US_FL_FIX_INQUIRY )
 
 		
 UNUSUAL_DEV(  0x057b, 0x0000, 0x0000, 0x0299, 
 		"Y-E Data",
 		"Flashbuster-U",
 		US_SC_DEVICE,  US_PR_CB, NULL,
-		US_FL_SINGLE_LUN),
+		US_FL_SINGLE_LUN)
 
-UNUSUAL_DEV(  0x057b, 0x0000, 0x0300, 0x9999, 
+UNUSUAL_DEV_FL( 0x057b, 0x0000, 0x0300, 0x9999, 
 		"Y-E Data",
 		"Flashbuster-U",
-		US_SC_DEVICE,  US_PR_DEVICE, NULL,
-		US_FL_SINGLE_LUN),
+		US_FL_SINGLE_LUN)
 
 /* Reported by Johann Cardon <johann.cardon@free.fr>
  * This entry is needed only because the device reports
  * bInterfaceClass = 0xff (vendor-specific)
  */
-UNUSUAL_DEV(  0x057b, 0x0022, 0x0000, 0x9999, 
+UNUSUAL_DEV_FL( 0x057b, 0x0022, 0x0000, 0x9999, 
 		"Y-E Data",
 		"Silicon Media R/W",
-		US_SC_DEVICE, US_PR_DEVICE, NULL, 0),
+		0)
 
 /* Fabrizio Fellini <fello@libero.it> */
 UNUSUAL_DEV(  0x0595, 0x4343, 0x0000, 0x2210,
 		"Fujifilm",
 		"Digital Camera EX-20 DSC",
-		US_SC_8070, US_PR_DEVICE, NULL, 0 ),
+		US_SC_8070, US_PR_DEVICE, NULL, 0 )
 
 /* The entry was here before I took over, and had US_SC_RBC. It turns
  * out that isn't needed. Additionally, Torsten Eriksson
@@ -526,10 +500,10 @@ UNUSUAL_DEV(  0x0595, 0x4343, 0x0000, 0x
  * for all users (the protocol is likely needed), so is staying at
  * this time. - Phil Dibowitz <phil@ipom.com>
  */
-UNUSUAL_DEV(  0x059f, 0xa601, 0x0200, 0x0200, 
+UNUSUAL_DEV_FL( 0x059f, 0xa601, 0x0200, 0x0200, 
 		"LaCie",
 		"USB Hard Disk",
-		US_SC_DEVICE, US_PR_CB, NULL, 0 ),
+		0 )
 
 /* Submitted by Joel Bourquard <numlock@freesurf.ch>
  * Some versions of this device need the SubClass and Protocol overrides
@@ -539,32 +513,32 @@ UNUSUAL_DEV(  0x05ab, 0x0060, 0x1104, 0x
 		"In-System",
 		"PyroGate External CD-ROM Enclosure (FCD-523)",
 		US_SC_SCSI, US_PR_BULK, NULL,
-		US_FL_NEED_OVERRIDE ),
+		US_FL_NEED_OVERRIDE )
 
 #ifdef CONFIG_USB_STORAGE_ISD200
 UNUSUAL_DEV(  0x05ab, 0x0031, 0x0100, 0x0110,
 		"In-System",
 		"USB/IDE Bridge (ATA/ATAPI)",
 		US_SC_ISD200, US_PR_BULK, isd200_Initialization,
-		0 ),
+		0 )
 
 UNUSUAL_DEV(  0x05ab, 0x0301, 0x0100, 0x0110,
 		"In-System",
 		"Portable USB Harddrive V2",
 		US_SC_ISD200, US_PR_BULK, isd200_Initialization,
-		0 ),
+		0 )
 
 UNUSUAL_DEV(  0x05ab, 0x0351, 0x0100, 0x0110,
 		"In-System",
 		"Portable USB Harddrive V2",
 		US_SC_ISD200, US_PR_BULK, isd200_Initialization,
-		0 ),
+		0 )
 
 UNUSUAL_DEV(  0x05ab, 0x5701, 0x0100, 0x0110,
 		"In-System",
 		"USB Storage Adapter V2",
 		US_SC_ISD200, US_PR_BULK, isd200_Initialization,
-		0 ),
+		0 )
 #endif
 
 /* Submitted by Sven Anderson <sven-linux@anderson.de>
@@ -573,45 +547,40 @@ UNUSUAL_DEV(  0x05ab, 0x5701, 0x0100, 0x
  * to change with firmware updates, I changed the range to maximum for all
  * iPod entries.
  */
-UNUSUAL_DEV( 0x05ac, 0x1202, 0x0000, 0x9999,
+UNUSUAL_DEV_FL( 0x05ac, 0x1202, 0x0000, 0x9999,
 		"Apple",
 		"iPod",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_CAPACITY ),
+		US_FL_FIX_CAPACITY )
 
 /* Reported by Avi Kivity <avi@argo.co.il> */
-UNUSUAL_DEV( 0x05ac, 0x1203, 0x0000, 0x9999,
+UNUSUAL_DEV_FL( 0x05ac, 0x1203, 0x0000, 0x9999,
 		"Apple",
 		"iPod",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_CAPACITY ),
+		US_FL_FIX_CAPACITY )
 
-UNUSUAL_DEV( 0x05ac, 0x1204, 0x0000, 0x9999,
+UNUSUAL_DEV_FL( 0x05ac, 0x1204, 0x0000, 0x9999,
 		"Apple",
 		"iPod",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_CAPACITY ),
+		US_FL_FIX_CAPACITY )
 
-UNUSUAL_DEV( 0x05ac, 0x1205, 0x0000, 0x9999,
+UNUSUAL_DEV_FL( 0x05ac, 0x1205, 0x0000, 0x9999,
 		"Apple",
 		"iPod",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_CAPACITY ),
+		US_FL_FIX_CAPACITY )
 
 #ifdef CONFIG_USB_STORAGE_JUMPSHOT
 UNUSUAL_DEV(  0x05dc, 0x0001, 0x0000, 0x0001,
 		"Lexar",
 		"Jumpshot USB CF Reader",
 		US_SC_SCSI, US_PR_JUMPSHOT, NULL,
-		US_FL_NEED_OVERRIDE ),
+		US_FL_NEED_OVERRIDE )
 #endif
 
 /* Reported by Blake Matheny <bmatheny@purdue.edu> */
-UNUSUAL_DEV(  0x05dc, 0xb002, 0x0000, 0x0113,
+UNUSUAL_DEV_FL( 0x05dc, 0xb002, 0x0000, 0x0113,
 		"Lexar",
 		"USB CF Reader",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_INQUIRY ),
+		US_FL_FIX_INQUIRY )
 
 /* The following two entries are for a Genesys USB to IDE
  * converter chip, but it changes its ProductId depending
@@ -620,17 +589,15 @@ UNUSUAL_DEV(  0x05dc, 0xb002, 0x0000, 0x
  * <alexander@all-2.com> and Peter Marks <peter.marks@turner.com>
  * respectively.
  */
-UNUSUAL_DEV(  0x05e3, 0x0701, 0x0000, 0xffff,
+UNUSUAL_DEV_FL( 0x05e3, 0x0701, 0x0000, 0xffff,
 		"Genesys Logic",
 		"USB to IDE Optical",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_GO_SLOW ),
+		US_FL_GO_SLOW )
 
-UNUSUAL_DEV(  0x05e3, 0x0702, 0x0000, 0xffff,
+UNUSUAL_DEV_FL( 0x05e3, 0x0702, 0x0000, 0xffff,
 		"Genesys Logic",
 		"USB to IDE Disk",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_GO_SLOW ),
+		US_FL_GO_SLOW )
 
 /* Reported by Hanno Boeck <hanno@gmx.de>
  * Taken from the Lycoris Kernel */
@@ -638,115 +605,111 @@ UNUSUAL_DEV(  0x0636, 0x0003, 0x0000, 0x
 		"Vivitar",
 		"Vivicam 35Xx",
 		US_SC_SCSI, US_PR_BULK, NULL,
-		US_FL_FIX_INQUIRY ),
+		US_FL_FIX_INQUIRY )
 
 UNUSUAL_DEV(  0x0644, 0x0000, 0x0100, 0x0100, 
 		"TEAC",
 		"Floppy Drive",
-		US_SC_UFI, US_PR_CB, NULL, 0 ), 
+		US_SC_UFI, US_PR_CB, NULL, 0 )
 
 #ifdef CONFIG_USB_STORAGE_SDDR09
 UNUSUAL_DEV(  0x066b, 0x0105, 0x0100, 0x0100, 
 		"Olympus",
 		"Camedia MAUSB-2",
 		US_SC_SCSI, US_PR_EUSB_SDDR09, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 #endif
 
 /* Reported by Darsen Lu <darsen@micro.ee.nthu.edu.tw> */
-UNUSUAL_DEV( 0x066f, 0x8000, 0x0001, 0x0001,
+UNUSUAL_DEV_FL( 0x066f, 0x8000, 0x0001, 0x0001,
 		"SigmaTel",
 		"USBMSC Audio Player",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_CAPACITY ),
+		US_FL_FIX_CAPACITY )
 
 /* Reported by Richard -=[]=- <micro_flyer@hotmail.com> */
-UNUSUAL_DEV( 0x067b, 0x2507, 0x0100, 0x0100,
+UNUSUAL_DEV_FL( 0x067b, 0x2507, 0x0100, 0x0100,
 		"Prolific Technology Inc.",
 		"Mass Storage Device",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_CAPACITY | US_FL_GO_SLOW ),
+		US_FL_FIX_CAPACITY | US_FL_GO_SLOW )
 
 /* Reported by Alex Butcher <alex.butcher@assursys.co.uk> */
-UNUSUAL_DEV( 0x067b, 0x3507, 0x0001, 0x0001,
+UNUSUAL_DEV_FL( 0x067b, 0x3507, 0x0001, 0x0001,
 		"Prolific Technology Inc.",
 		"ATAPI-6 Bridge Controller",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_CAPACITY | US_FL_GO_SLOW ),
+		US_FL_FIX_CAPACITY | US_FL_GO_SLOW )
 
 /* Submitted by Benny Sjostrand <benny@hostmobility.com> */
 UNUSUAL_DEV( 0x0686, 0x4011, 0x0001, 0x0001,
 		"Minolta",
 		"Dimage F300",
-		US_SC_SCSI, US_PR_BULK, NULL, 0 ),
+		US_SC_SCSI, US_PR_BULK, NULL, 0 )
 
 /* Reported by Miguel A. Fosas <amn3s1a@ono.com> */
 UNUSUAL_DEV(  0x0686, 0x4017, 0x0001, 0x0001,
                 "Minolta",
                 "DIMAGE E223",
-                US_SC_SCSI, US_PR_DEVICE, NULL, 0 ),
+                US_SC_SCSI, US_PR_DEVICE, NULL, 0 )
 
 UNUSUAL_DEV(  0x0693, 0x0002, 0x0100, 0x0100, 
 		"Hagiwara",
 		"FlashGate SmartMedia",
-		US_SC_SCSI, US_PR_BULK, NULL, 0 ),
+		US_SC_SCSI, US_PR_BULK, NULL, 0 )
 
 UNUSUAL_DEV(  0x0693, 0x0005, 0x0100, 0x0100,
 		"Hagiwara",
 		"Flashgate",
-		US_SC_SCSI, US_PR_BULK, NULL, 0 ), 
+		US_SC_SCSI, US_PR_BULK, NULL, 0 )
 
 UNUSUAL_DEV(  0x0781, 0x0001, 0x0200, 0x0200, 
 		"Sandisk",
 		"ImageMate SDDR-05a",
 		US_SC_SCSI, US_PR_CB, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 
 UNUSUAL_DEV(  0x0781, 0x0100, 0x0100, 0x0100,
 		"Sandisk",
 		"ImageMate SDDR-12",
 		US_SC_SCSI, US_PR_CB, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 
 #ifdef CONFIG_USB_STORAGE_SDDR09
 UNUSUAL_DEV(  0x0781, 0x0200, 0x0000, 0x9999, 
 		"Sandisk",
 		"ImageMate SDDR-09",
 		US_SC_SCSI, US_PR_EUSB_SDDR09, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 #endif
 
 #ifdef CONFIG_USB_STORAGE_FREECOM
 UNUSUAL_DEV(  0x07ab, 0xfc01, 0x0000, 0x9999,
 		"Freecom",
 		"USB-IDE",
-		US_SC_QIC, US_PR_FREECOM, freecom_init, 0),
+		US_SC_QIC, US_PR_FREECOM, freecom_init, 0)
 #endif
 
 /* Reported by Eero Volotinen <eero@ping-viini.org> */
-UNUSUAL_DEV(  0x07ab, 0xfccd, 0x0406, 0x0406,
+UNUSUAL_DEV_FL( 0x07ab, 0xfccd, 0x0406, 0x0406,
 		"Freecom Technologies",
 		"FHD-Classic",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_CAPACITY),
+		US_FL_FIX_CAPACITY)
 
 UNUSUAL_DEV(  0x07af, 0x0004, 0x0100, 0x0133, 
 		"Microtech",
 		"USB-SCSI-DB25",
 		US_SC_SCSI, US_PR_BULK, usb_stor_euscsi_init,
-		US_FL_SCM_MULT_TARG ), 
+		US_FL_SCM_MULT_TARG )
 
 UNUSUAL_DEV(  0x07af, 0x0005, 0x0100, 0x0100, 
 		"Microtech",
 		"USB-SCSI-HD50",
 		US_SC_DEVICE, US_PR_DEVICE, usb_stor_euscsi_init,
-		US_FL_SCM_MULT_TARG ), 
+		US_FL_SCM_MULT_TARG )
 
 #ifdef CONFIG_USB_STORAGE_DPCM
 UNUSUAL_DEV(  0x07af, 0x0006, 0x0100, 0x0100,
 		"Microtech",
 		"CameraMate (DPCM_USB)",
- 		US_SC_SCSI, US_PR_DPCM_USB, NULL, 0 ),
+ 		US_SC_SCSI, US_PR_DPCM_USB, NULL, 0 )
 #endif
 
 #ifdef CONFIG_USB_STORAGE_DATAFAB
@@ -754,7 +717,7 @@ UNUSUAL_DEV(  0x07c4, 0xa000, 0x0000, 0x
 		"Datafab",
 		"MDCFE-B USB CF Reader",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		0 ),
+		0 )
 
 /*
  * The following Datafab-based devices may or may not work
@@ -771,38 +734,38 @@ UNUSUAL_DEV( 0x07c4, 0xa001, 0x0000, 0xf
 		"SIIG/Datafab",
 		"SIIG/Datafab Memory Stick+CF Reader/Writer",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		0 ),
+		0 )
 
 /* Reported by Josef Reisinger <josef.reisinger@netcologne.de> */
 UNUSUAL_DEV( 0x07c4, 0xa002, 0x0000, 0xffff,
 		"Datafab/Unknown",
 		"MD2/MD3 Disk enclosure",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 
 UNUSUAL_DEV( 0x07c4, 0xa003, 0x0000, 0xffff,
 		"Datafab/Unknown",
 		"Datafab-based Reader",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		0 ),
+		0 )
 
 UNUSUAL_DEV( 0x07c4, 0xa004, 0x0000, 0xffff,
 		"Datafab/Unknown",
 		"Datafab-based Reader",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		0 ),
+		0 )
 
 UNUSUAL_DEV( 0x07c4, 0xa005, 0x0000, 0xffff,
 		"PNY/Datafab",
 		"PNY/Datafab CF+SM Reader",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		0 ),
+		0 )
 
 UNUSUAL_DEV( 0x07c4, 0xa006, 0x0000, 0xffff,
 		"Simple Tech/Datafab",
 		"Simple Tech/Datafab CF+SM Reader",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		0 ),
+		0 )
 #endif
 		
 #ifdef CONFIG_USB_STORAGE_SDDR55
@@ -811,7 +774,7 @@ UNUSUAL_DEV( 0x07c4, 0xa103, 0x0000, 0x9
 		"Datafab",
 		"MDSM-B reader",
 		US_SC_SCSI, US_PR_SDDR55, NULL,
-		US_FL_FIX_INQUIRY ),
+		US_FL_FIX_INQUIRY )
 #endif
 
 #ifdef CONFIG_USB_STORAGE_DATAFAB
@@ -820,7 +783,7 @@ UNUSUAL_DEV(  0x07c4, 0xa109, 0x0000, 0x
 		"Datafab Systems, Inc.",
 		"USB to CF + SM Combo (LC1)",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		0 ),
+		0 )
 #endif
 #ifdef CONFIG_USB_STORAGE_SDDR55
 /* SM part - aeb <Andries.Brouwer@cwi.nl> */
@@ -828,7 +791,7 @@ UNUSUAL_DEV(  0x07c4, 0xa109, 0x0000, 0x
 		"Datafab Systems, Inc.",
 		"USB to CF + SM Combo (LC1)",
 		US_SC_SCSI, US_PR_SDDR55, NULL,
-		US_FL_SINGLE_LUN ),
+		US_FL_SINGLE_LUN )
 #endif
 
 #ifdef CONFIG_USB_STORAGE_DATAFAB
@@ -840,7 +803,7 @@ UNUSUAL_DEV(  0x07c4, 0xa10b, 0x0000, 0x
                 "DataFab Systems Inc.",
                 "USB CF+MS",
                 US_SC_SCSI, US_PR_DATAFAB, NULL,
-                0 ),
+                0 )
 
 #endif
 
@@ -850,11 +813,10 @@ UNUSUAL_DEV(  0x07c4, 0xa10b, 0x0000, 0x
  * Submitted by Marek Michalkiewicz <marekm@amelek.gda.pl>.
  * See also http://martin.wilck.bei.t-online.de/#kecf .
  */
-UNUSUAL_DEV(  0x07c4, 0xa400, 0x0000, 0xffff,
+UNUSUAL_DEV_FL( 0x07c4, 0xa400, 0x0000, 0xffff,
 		"Datafab",
 		"KECF-USB",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_INQUIRY ),
+		US_FL_FIX_INQUIRY )
 
 /* Casio QV 2x00/3x00/4000/8000 digital still cameras are not conformant
  * to the USB storage specification in two ways:
@@ -871,14 +833,13 @@ UNUSUAL_DEV( 0x07cf, 0x1001, 0x1000, 0x9
 		"Casio",
 		"QV DigitalCamera",
 		US_SC_8070, US_PR_CB, NULL,
-		US_FL_NEED_OVERRIDE | US_FL_FIX_INQUIRY ),
+		US_FL_NEED_OVERRIDE | US_FL_FIX_INQUIRY )
 
 /* Submitted by Hartmut Wahl <hwahl@hwahl.de>*/
-UNUSUAL_DEV( 0x0839, 0x000a, 0x0001, 0x0001,
+UNUSUAL_DEV_FL( 0x0839, 0x000a, 0x0001, 0x0001,
 		"Samsung",
 		"Digimax 410",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_INQUIRY),
+		US_FL_FIX_INQUIRY)
 
 /* Entry and supporting patch by Theodore Kilgore <kilgota@auburn.edu>.
  * Flag will support Bulk devices which use a standards-violating 32-byte
@@ -886,11 +847,10 @@ UNUSUAL_DEV( 0x0839, 0x000a, 0x0001, 0x0
  * Grandtech GT892x chip, which request "Proprietary SCSI Bulk" support.
  */
 
-UNUSUAL_DEV(  0x084d, 0x0011, 0x0110, 0x0110,
+UNUSUAL_DEV_FL( 0x084d, 0x0011, 0x0110, 0x0110,
 		"Grandtech",
 		"DC2MEGA",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_BULK32),
+		US_FL_BULK32)
 
 
 /* Entry needed for flags. Moreover, all devices with this ID use
@@ -902,7 +862,7 @@ UNUSUAL_DEV(  0x090a, 0x1001, 0x0100, 0x
 		"Trumpion",
 		"t33520 USB Flash Card Controller",
 		US_SC_DEVICE, US_PR_BULK, NULL,
-		US_FL_NEED_OVERRIDE ),
+		US_FL_NEED_OVERRIDE )
 
 /* Reported by Filippo Bardelli <filibard@libero.it>
  * The device reports a subclass of RBC, which is wrong.
@@ -911,21 +871,20 @@ UNUSUAL_DEV(  0x090a, 0x1050, 0x0100, 0x
 		"Trumpion Microelectronics, Inc.",
 		"33520 USB Digital Voice Recorder",
 		US_SC_UFI, US_PR_DEVICE, NULL,
-		0),
+		0)
 
 /* Trumpion Microelectronics MP3 player (felipe_alfaro@linuxmail.org) */
 UNUSUAL_DEV( 0x090a, 0x1200, 0x0000, 0x9999,
 		"Trumpion",
 		"MP3 player",
 		US_SC_RBC, US_PR_BULK, NULL,
-		0 ),
+		0 )
 
 /* aeb */
-UNUSUAL_DEV( 0x090c, 0x1132, 0x0000, 0xffff,
+UNUSUAL_DEV_FL( 0x090c, 0x1132, 0x0000, 0xffff,
 		"Feiya",
 		"5-in-1 Card Reader",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_CAPACITY ),
+		US_FL_FIX_CAPACITY )
 
 /* This Pentax still camera is not conformant
  * to the USB storage specification: -
@@ -934,26 +893,24 @@ UNUSUAL_DEV( 0x090c, 0x1132, 0x0000, 0xf
  * Tested on Rev. 10.00 (0x1000)
  * Submitted by James Courtier-Dutton <James@superbug.demon.co.uk>
  */
-UNUSUAL_DEV( 0x0a17, 0x0004, 0x1000, 0x1000,
+UNUSUAL_DEV_FL( 0x0a17, 0x0004, 0x1000, 0x1000,
                 "Pentax",
                 "Optio 2/3/400",
-                US_SC_DEVICE, US_PR_DEVICE, NULL,
-                US_FL_FIX_INQUIRY ),
+                US_FL_FIX_INQUIRY )
 
 
 /* Submitted by Per Winkvist <per.winkvist@uk.com> */
-UNUSUAL_DEV( 0x0a17, 0x006, 0x0000, 0xffff,
+UNUSUAL_DEV_FL( 0x0a17, 0x006, 0x0000, 0xffff,
                 "Pentax",
                 "Optio S/S4",
-                US_SC_DEVICE, US_PR_DEVICE, NULL,
-                US_FL_FIX_INQUIRY ),
+                US_FL_FIX_INQUIRY )
 		
 #ifdef CONFIG_USB_STORAGE_ISD200
 UNUSUAL_DEV(  0x0bf6, 0xa001, 0x0100, 0x0110,
 		"ATI",
 		"USB Cable 205",
 		US_SC_ISD200, US_PR_BULK, isd200_Initialization,
-		0 ),
+		0 )
 #endif
 
 #ifdef CONFIG_USB_STORAGE_DATAFAB
@@ -961,14 +918,14 @@ UNUSUAL_DEV( 0x0c0b, 0xa109, 0x0000, 0xf
 	       "Acomdata",
 	       "CF",
 	       US_SC_SCSI, US_PR_DATAFAB, NULL,
-	       US_FL_SINGLE_LUN ),
+	       US_FL_SINGLE_LUN )
 #endif
 #ifdef CONFIG_USB_STORAGE_SDDR55
 UNUSUAL_DEV( 0x0c0b, 0xa109, 0x0000, 0xffff,
 	       "Acomdata",
 	       "SM",
 	       US_SC_SCSI, US_PR_SDDR55, NULL,
-	       US_FL_SINGLE_LUN ),
+	       US_FL_SINGLE_LUN )
 #endif
 
 /* Submitted by: Nick Sillik <n.sillik@temple.edu>
@@ -980,80 +937,72 @@ UNUSUAL_DEV( 0x0c0b, 0xa109, 0x0000, 0xf
 			"Maxtor",
 			"OneTouch External Harddrive",
 			US_SC_DEVICE, US_PR_DEVICE, onetouch_connect_input,
-			0),
+			0)
 #endif
 
 /* Submitted by Joris Struyve <joris@struyve.be> */
-UNUSUAL_DEV( 0x0d96, 0x410a, 0x0001, 0xffff,
+UNUSUAL_DEV_FL( 0x0d96, 0x410a, 0x0001, 0xffff,
 		"Medion",
 		"MD 7425",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_INQUIRY),
+		US_FL_FIX_INQUIRY)
 
 /*
  * Entry for Jenoptik JD 5200z3
  *
  * email: car.busse@gmx.de
  */
-UNUSUAL_DEV(  0x0d96, 0x5200, 0x0001, 0x0200,
+UNUSUAL_DEV_FL( 0x0d96, 0x5200, 0x0001, 0x0200,
 		"Jenoptik",
 		"JD 5200 z3",
-		US_SC_DEVICE, US_PR_DEVICE, NULL, US_FL_FIX_INQUIRY),
+		US_FL_FIX_INQUIRY)
 
 /* Reported by Lubomir Blaha <tritol@trilogic.cz>
  * I _REALLY_ don't know what 3rd, 4th number and all defines mean, but this
  * works for me. Can anybody correct these values? (I able to test corrected
  * version.)
  */
-UNUSUAL_DEV( 0x0dd8, 0x1060, 0x0000, 0xffff,
+UNUSUAL_DEV_FL( 0x0dd8, 0x1060, 0x0000, 0xffff,
 		"Netac",
 		"USB-CF-Card",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_INQUIRY ),
+		US_FL_FIX_INQUIRY )
 
 /* Patch by Stephan Walter <stephan.walter@epfl.ch>
  * I don't know why, but it works... */
-UNUSUAL_DEV( 0x0dda, 0x0001, 0x0012, 0x0012,
+UNUSUAL_DEV_FL( 0x0dda, 0x0001, 0x0012, 0x0012,
 		"WINWARD",
 		"Music Disk",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_IGNORE_RESIDUE ),
+		US_FL_IGNORE_RESIDUE )
 
 /* Reported by Ian McConnell <ian at emit.demon.co.uk> */
-UNUSUAL_DEV(  0x0dda, 0x0301, 0x0012, 0x0012,
+UNUSUAL_DEV_FL( 0x0dda, 0x0301, 0x0012, 0x0012,
 		"PNP_MP3",
 		"PNP_MP3 PLAYER",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_IGNORE_RESIDUE ),
+		US_FL_IGNORE_RESIDUE )
 
 /* Submitted by Antoine Mairesse <antoine.mairesse@free.fr> */
-UNUSUAL_DEV( 0x0ed1, 0x6660, 0x0100, 0x0300,
+UNUSUAL_DEV_FL( 0x0ed1, 0x6660, 0x0100, 0x0300,
 		"USB",
 		"Solid state disk",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_FIX_INQUIRY ),
+		US_FL_FIX_INQUIRY )
 
 /* Submitted by Daniel Drake <dsd@gentoo.org>
  * Reported by dayul on the Gentoo Forums */
-UNUSUAL_DEV(  0x0ea0, 0x2168, 0x0110, 0x0110,
+UNUSUAL_DEV_FL( 0x0ea0, 0x2168, 0x0110, 0x0110,
 		"Ours Technology",
 		"Flash Disk",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_IGNORE_RESIDUE ),
+		US_FL_IGNORE_RESIDUE )
 
 /* Reported by Rastislav Stanik <rs_kernel@yahoo.com> */
-UNUSUAL_DEV(  0x0ea0, 0x6828, 0x0110, 0x0110,
+UNUSUAL_DEV_FL( 0x0ea0, 0x6828, 0x0110, 0x0110,
 		"USB",
 		"Flash Disk",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_IGNORE_RESIDUE ),
+		US_FL_IGNORE_RESIDUE )
 
 /* Reported by Michael Stattmann <michael@stattmann.com> */
-UNUSUAL_DEV(  0x0fce, 0xd008, 0x0000, 0x0000,
+UNUSUAL_DEV_FL( 0x0fce, 0xd008, 0x0000, 0x0000,
 		"Sony Ericsson",
 		"V800-Vodafone 802",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_NO_WP_DETECT ),
+		US_FL_NO_WP_DETECT )
 
 /* Reported by Kevin Cernekee <kpc-usbdev@gelato.uiuc.edu>
  * Tested on hardware version 1.10.
@@ -1063,33 +1012,30 @@ UNUSUAL_DEV(  0x1019, 0x0c55, 0x0000, 0x
 		"Desknote",
 		"UCR-61S2B",
 		US_SC_DEVICE, US_PR_DEVICE, usb_stor_ucr61s2b_init,
-		0 ),
+		0 )
 
 /* Reported by Vilius Bilinkevicius <vilisas AT xxx DOT lt) */
-UNUSUAL_DEV(  0x132b, 0x000b, 0x0001, 0x0001,
+UNUSUAL_DEV_FL( 0x132b, 0x000b, 0x0001, 0x0001,
 		"Minolta",
 		"Dimage Z10",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		0 ),
+		0 )
 
 /* Reported by Kotrla Vitezslav <kotrla@ceb.cz> */
-UNUSUAL_DEV(  0x1370, 0x6828, 0x0110, 0x0110,
+UNUSUAL_DEV_FL( 0x1370, 0x6828, 0x0110, 0x0110,
 		"SWISSBIT",
 		"Black Silver",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_IGNORE_RESIDUE ),
+		US_FL_IGNORE_RESIDUE )
 
 /* Reported by Radovan Garabik <garabik@kassiopeia.juls.savba.sk> */
-UNUSUAL_DEV(  0x2735, 0x100b, 0x0000, 0x9999,
+UNUSUAL_DEV_FL( 0x2735, 0x100b, 0x0000, 0x9999,
 		"MPIO",
 		"HS200",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_GO_SLOW ),
+		US_FL_GO_SLOW )
 
 #ifdef CONFIG_USB_STORAGE_SDDR55
 UNUSUAL_DEV(  0x55aa, 0xa103, 0x0000, 0x9999, 
 		"Sandisk",
 		"ImageMate SDDR55",
 		US_SC_SCSI, US_PR_SDDR55, NULL,
-		US_FL_SINGLE_LUN),
+		US_FL_SINGLE_LUN)
 #endif
diff -urpN -X dontdiff linux-2.6.14-rc2/drivers/usb/storage/usb.c linux-2.6.14-rc2-wip/drivers/usb/storage/usb.c
--- linux-2.6.14-rc2/drivers/usb/storage/usb.c	2005-09-24 20:32:56.000000000 -0700
+++ linux-2.6.14-rc2-wip/drivers/usb/storage/usb.c	2005-09-27 19:40:39.000000000 -0700
@@ -116,20 +116,25 @@ static int storage_probe(struct usb_inte
 
 static void storage_disconnect(struct usb_interface *iface);
 
-/* The entries in this table, except for final ones here
- * (USB_MASS_STORAGE_CLASS and the empty entry), correspond,
- * line for line with the entries of us_unsuaul_dev_list[].
- */
+#ifndef CONFIG_USB_LIBUSUAL
 
 #define UNUSUAL_DEV(id_vendor, id_product, bcdDeviceMin, bcdDeviceMax, \
 		    vendorName, productName,useProtocol, useTransport, \
 		    initFunction, flags) \
-{ USB_DEVICE_VER(id_vendor, id_product, bcdDeviceMin,bcdDeviceMax) }
+{ USB_DEVICE_VER(id_vendor, id_product, bcdDeviceMin,bcdDeviceMax), \
+  .driver_info = (flags) },
+
+#define UNUSUAL_DEV_FL(id_vendor, id_product, bcdDeviceMin, bcdDeviceMax, \
+		    vendorName, productName, \
+		    flags) \
+{ USB_DEVICE_VER(id_vendor, id_product, bcdDeviceMin,bcdDeviceMax), \
+  .driver_info = (flags) },
 
 static struct usb_device_id storage_usb_ids [] = {
 
 #	include "unusual_devs.h"
 #undef UNUSUAL_DEV
+#undef UNUSUAL_DEV_FL
 	/* Control/Bulk transport for all SubClass values */
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_RBC, US_PR_CB) },
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_8020, US_PR_CB) },
@@ -159,6 +164,7 @@ static struct usb_device_id storage_usb_
 };
 
 MODULE_DEVICE_TABLE (usb, storage_usb_ids);
+#endif /* CONFIG_USB_LIBUSUAL */
 
 /* This is the list of devices we recognize, along with their flag data */
 
@@ -171,63 +177,29 @@ MODULE_DEVICE_TABLE (usb, storage_usb_id
  * are free to use as many characters as you like.
  */
 
-#undef UNUSUAL_DEV
-#define UNUSUAL_DEV(idVendor, idProduct, bcdDeviceMin, bcdDeviceMax, \
+#define UNUSUAL_DEV(idV, idP, bcdDevMin, bcdDevMax, \
 		    vendor_name, product_name, use_protocol, use_transport, \
 		    init_function, Flags) \
 { \
 	.vendorName = vendor_name,	\
 	.productName = product_name,	\
+	.idVendor = idV,		\
+	.idProduct = idP,		\
+	.bcdDevice_lo = bcdDevMin,	\
+	.bcdDevice_hi = bcdDevMax,	\
 	.useProtocol = use_protocol,	\
 	.useTransport = use_transport,	\
 	.initFunction = init_function,	\
-	.flags = Flags, \
-}
+},
+
+#define UNUSUAL_DEV_FL(idV, idP, bcdDevMin, bcdDevMax, \
+		    vendor_name, product_name, \
+		    Flags)	/* */
 
 static struct us_unusual_dev us_unusual_dev_list[] = {
 #	include "unusual_devs.h" 
 #	undef UNUSUAL_DEV
-	/* Control/Bulk transport for all SubClass values */
-	{ .useProtocol = US_SC_RBC,
-	  .useTransport = US_PR_CB},
-	{ .useProtocol = US_SC_8020,
-	  .useTransport = US_PR_CB},
-	{ .useProtocol = US_SC_QIC,
-	  .useTransport = US_PR_CB},
-	{ .useProtocol = US_SC_UFI,
-	  .useTransport = US_PR_CB},
-	{ .useProtocol = US_SC_8070,
-	  .useTransport = US_PR_CB},
-	{ .useProtocol = US_SC_SCSI,
-	  .useTransport = US_PR_CB},
-
-	/* Control/Bulk/Interrupt transport for all SubClass values */
-	{ .useProtocol = US_SC_RBC,
-	  .useTransport = US_PR_CBI},
-	{ .useProtocol = US_SC_8020,
-	  .useTransport = US_PR_CBI},
-	{ .useProtocol = US_SC_QIC,
-	  .useTransport = US_PR_CBI},
-	{ .useProtocol = US_SC_UFI,
-	  .useTransport = US_PR_CBI},
-	{ .useProtocol = US_SC_8070,
-	  .useTransport = US_PR_CBI},
-	{ .useProtocol = US_SC_SCSI,
-	  .useTransport = US_PR_CBI},
-
-	/* Bulk-only transport for all SubClass values */
-	{ .useProtocol = US_SC_RBC,
-	  .useTransport = US_PR_BULK},
-	{ .useProtocol = US_SC_8020,
-	  .useTransport = US_PR_BULK},
-	{ .useProtocol = US_SC_QIC,
-	  .useTransport = US_PR_BULK},
-	{ .useProtocol = US_SC_UFI,
-	  .useTransport = US_PR_BULK},
-	{ .useProtocol = US_SC_8070,
-	  .useTransport = US_PR_BULK},
-	{ .useProtocol = US_SC_SCSI,
-	  .useTransport = US_PR_BULK},
+#	undef UNUSUAL_DEV_FL
 
 	/* Terminating entry */
 	{ NULL }
@@ -470,24 +442,41 @@ static int associate_dev(struct us_data 
 	return 0;
 }
 
+/* Find an unusual_dev descriptor, if any */
+static struct us_unusual_dev *find_unusual_entry(const struct usb_device_id *id)
+{
+	struct us_unusual_dev *ud;
+
+	for (ud = us_unusual_dev_list; ud->idVendor || ud->idProduct; ud++) {
+		if (ud->idVendor == id->idVendor &&
+		    ud->idProduct == id->idProduct &&
+		    ud->bcdDevice_lo == id->bcdDevice_lo &&
+		    ud->bcdDevice_hi == id->bcdDevice_hi) {
+			return ud;
+		}
+	}
+	return NULL;
+}
+
 /* Get the unusual_devs entries and the string descriptors */
-static void get_device_info(struct us_data *us, int id_index)
+static void get_device_info(struct us_data *us, const struct usb_device_id *id)
 {
 	struct usb_device *dev = us->pusb_dev;
 	struct usb_interface_descriptor *idesc =
 		&us->pusb_intf->cur_altsetting->desc;
-	struct us_unusual_dev *unusual_dev = &us_unusual_dev_list[id_index];
-	struct usb_device_id *id = &storage_usb_ids[id_index];
+	struct us_unusual_dev *unusual_dev = find_unusual_entry(id);
 
 	/* Store the entries */
 	us->unusual_dev = unusual_dev;
-	us->subclass = (unusual_dev->useProtocol == US_SC_DEVICE) ?
+	us->subclass = (unusual_dev == NULL ||
+			unusual_dev->useProtocol == US_SC_DEVICE) ?
 			idesc->bInterfaceSubClass :
 			unusual_dev->useProtocol;
-	us->protocol = (unusual_dev->useTransport == US_PR_DEVICE) ?
+	us->protocol = (unusual_dev == NULL ||
+			unusual_dev->useTransport == US_PR_DEVICE) ?
 			idesc->bInterfaceProtocol :
 			unusual_dev->useTransport;
-	us->flags = unusual_dev->flags;
+	us->flags = id->driver_info;
 
 	/*
 	 * This flag is only needed when we're in high-speed, so let's
@@ -501,7 +490,7 @@ static void get_device_info(struct us_da
 	 * reports from users that will help us remove unneeded entries
 	 * from the unusual_devs.h table.
 	 */
-	if (id->idVendor || id->idProduct) {
+	if (unusual_dev != NULL && (id->idVendor || id->idProduct)) {
 		static char *msgs[3] = {
 			"an unneeded SubClass entry",
 			"an unneeded Protocol entry",
@@ -515,7 +504,7 @@ static void get_device_info(struct us_da
 		if (unusual_dev->useTransport != US_PR_DEVICE &&
 			us->protocol == idesc->bInterfaceProtocol)
 			msg += 2;
-		if (msg >= 0 && !(unusual_dev->flags & US_FL_NEED_OVERRIDE))
+		if (msg >= 0 && !(us->flags & US_FL_NEED_OVERRIDE))
 			printk(KERN_NOTICE USB_STORAGE "This device "
 				"(%04x,%04x,%04x S %02x P %02x)"
 				" has %s in unusual_devs.h\n"
@@ -762,7 +751,7 @@ static int usb_stor_acquire_resources(st
 
 	/* Just before we start our control thread, initialize
 	 * the device if it needs initialization */
-	if (us->unusual_dev->initFunction)
+	if (us->unusual_dev && us->unusual_dev->initFunction)
 		us->unusual_dev->initFunction(us);
 
 	up(&us->dev_semaphore);
@@ -921,7 +910,6 @@ static int storage_probe(struct usb_inte
 {
 	struct Scsi_Host *host;
 	struct us_data *us;
-	const int id_index = id - storage_usb_ids; 
 	int result;
 
 	US_DEBUGP("USB Mass Storage device detected\n");
@@ -951,12 +939,8 @@ static int storage_probe(struct usb_inte
 
 	/*
 	 * Get the unusual_devs entries and the descriptors
-	 *
-	 * id_index is calculated in the declaration to be the index number
-	 * of the match from the usb_device_id table, so we can find the
-	 * corresponding entry in the private table.
 	 */
-	get_device_info(us, id_index);
+	get_device_info(us, id);
 
 #ifdef CONFIG_USB_STORAGE_SDDR09
 	if (us->protocol == US_PR_EUSB_SDDR09 ||
@@ -1043,10 +1027,14 @@ static int __init usb_stor_init(void)
 	int retval;
 	printk(KERN_INFO "Initializing USB Mass Storage driver...\n");
 
+	usb_usual_set_present(USB_US_TYPE_STOR, 1);
+
 	/* register the driver, return usb_register return code if error */
 	retval = usb_register(&usb_storage_driver);
 	if (retval == 0)
 		printk(KERN_INFO "USB Mass Storage support registered.\n");
+	else
+		usb_usual_set_present(USB_US_TYPE_STOR, 0);
 
 	return retval;
 }
@@ -1071,6 +1059,8 @@ static void __exit usb_stor_exit(void)
 		wait_for_completion(&threads_gone);
 		atomic_dec(&total_threads);
 	}
+
+	usb_usual_set_present(USB_US_TYPE_STOR, 0);
 }
 
 module_init(usb_stor_init);
diff -urpN -X dontdiff linux-2.6.14-rc2/drivers/usb/storage/usb.h linux-2.6.14-rc2-wip/drivers/usb/storage/usb.h
--- linux-2.6.14-rc2/drivers/usb/storage/usb.h	2005-09-24 20:32:56.000000000 -0700
+++ linux-2.6.14-rc2-wip/drivers/usb/storage/usb.h	2005-09-27 18:06:44.000000000 -0700
@@ -45,6 +45,7 @@
 #define _USB_H_
 
 #include <linux/usb.h>
+#include <linux/usb_usual.h>
 #include <linux/blkdev.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
@@ -60,53 +61,15 @@ struct scsi_cmnd;
 struct us_unusual_dev {
 	const char* vendorName;
 	const char* productName;
+	__u16 idVendor;
+	__u16 idProduct;
+	__u16 bcdDevice_lo;
+	__u16 bcdDevice_hi;
 	__u8  useProtocol;
 	__u8  useTransport;
 	int (*initFunction)(struct us_data *);
-	unsigned int flags;
 };
 
-/*
- * Static flag definitions.  We use this roundabout technique so that the
- * proc_info() routine can automatically display a message for each flag.
- */
-#define US_DO_ALL_FLAGS						\
-	US_FLAG(SINGLE_LUN,	0x00000001)			\
-		/* allow access to only LUN 0 */		\
-	US_FLAG(NEED_OVERRIDE,	0x00000002)			\
-		/* unusual_devs entry is necessary */		\
-	US_FLAG(SCM_MULT_TARG,	0x00000004)			\
-		/* supports multiple targets */			\
-	US_FLAG(FIX_INQUIRY,	0x00000008)			\
-		/* INQUIRY response needs faking */		\
-	US_FLAG(FIX_CAPACITY,	0x00000010)			\
-		/* READ CAPACITY response too big */		\
-	US_FLAG(IGNORE_RESIDUE,	0x00000020)			\
-		/* reported residue is wrong */			\
-	US_FLAG(BULK32,		0x00000040)			\
-		/* Uses 32-byte CBW length */			\
-	US_FLAG(NOT_LOCKABLE,	0x00000080)			\
-		/* PREVENT/ALLOW not supported */		\
-	US_FLAG(GO_SLOW,	0x00000100)			\
-		/* Need delay after Command phase */		\
-	US_FLAG(NO_WP_DETECT,	0x00000200)			\
-		/* Don't check for write-protect */		\
-
-#define US_FLAG(name, value)	US_FL_##name = value ,
-enum { US_DO_ALL_FLAGS };
-#undef US_FLAG
-
-/* Dynamic flag definitions: used in set_bit() etc. */
-#define US_FLIDX_URB_ACTIVE	18  /* 0x00040000  current_urb is in use  */
-#define US_FLIDX_SG_ACTIVE	19  /* 0x00080000  current_sg is in use   */
-#define US_FLIDX_ABORTING	20  /* 0x00100000  abort is in progress   */
-#define US_FLIDX_DISCONNECTING	21  /* 0x00200000  disconnect in progress */
-#define ABORTING_OR_DISCONNECTING	((1UL << US_FLIDX_ABORTING) | \
-					 (1UL << US_FLIDX_DISCONNECTING))
-#define US_FLIDX_RESETTING	22  /* 0x00400000  device reset in progress */
-#define US_FLIDX_TIMED_OUT	23  /* 0x00800000  SCSI midlayer timed out  */
-
-
 #define USB_STOR_STRING_LEN 32
 
 /*
diff -urpN -X dontdiff linux-2.6.14-rc2/include/linux/usb_usual.h linux-2.6.14-rc2-wip/include/linux/usb_usual.h
--- linux-2.6.14-rc2/include/linux/usb_usual.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.14-rc2-wip/include/linux/usb_usual.h	2005-09-27 18:05:09.000000000 -0700
@@ -0,0 +1,134 @@
+/*
+ * Interface to the libusual.
+ *
+ * Copyright (c) 2005 Pete Zaitcev <zaitcev@redhat.com>
+ * Copyright (c) 1999-2002 Matthew Dharm (mdharm-usb@one-eyed-alien.net)
+ * Copyright (c) 1999 Michael Gee (michael@linuxspecific.com)
+ */
+
+#ifndef __LINUX_USB_USUAL_H
+#define __LINUX_USB_USUAL_H
+
+#include <linux/config.h>
+
+/* We should do this for cleanliness... But other usb_foo.h do not do this. */
+/* #include <linux/usb.h> */
+
+/*
+ * The flags field, which we store in usb_device_id.driver_info.
+ * It is compatible with the old usb-storage flags in lower 24 bits.
+ */
+
+/*
+ * Static flag definitions.  We use this roundabout technique so that the
+ * proc_info() routine can automatically display a message for each flag.
+ */
+#define US_DO_ALL_FLAGS						\
+	US_FLAG(SINGLE_LUN,	0x00000001)			\
+		/* allow access to only LUN 0 */		\
+	US_FLAG(NEED_OVERRIDE,	0x00000002)			\
+		/* unusual_devs entry is necessary */		\
+	US_FLAG(SCM_MULT_TARG,	0x00000004)			\
+		/* supports multiple targets */			\
+	US_FLAG(FIX_INQUIRY,	0x00000008)			\
+		/* INQUIRY response needs faking */		\
+	US_FLAG(FIX_CAPACITY,	0x00000010)			\
+		/* READ CAPACITY response too big */		\
+	US_FLAG(IGNORE_RESIDUE,	0x00000020)			\
+		/* reported residue is wrong */			\
+	US_FLAG(BULK32,		0x00000040)			\
+		/* Uses 32-byte CBW length */			\
+	US_FLAG(NOT_LOCKABLE,	0x00000080)			\
+		/* PREVENT/ALLOW not supported */		\
+	US_FLAG(GO_SLOW,	0x00000100)			\
+		/* Need delay after Command phase */		\
+	US_FLAG(NO_WP_DETECT,	0x00000200)			\
+		/* Don't check for write-protect */		\
+
+#define US_FLAG(name, value)	US_FL_##name = value ,
+enum { US_DO_ALL_FLAGS };
+#undef US_FLAG
+
+/* Dynamic flag definitions: used in set_bit() etc. */
+#define US_FLIDX_URB_ACTIVE	18  /* 0x00040000  current_urb is in use  */
+#define US_FLIDX_SG_ACTIVE	19  /* 0x00080000  current_sg is in use   */
+#define US_FLIDX_ABORTING	20  /* 0x00100000  abort is in progress   */
+#define US_FLIDX_DISCONNECTING	21  /* 0x00200000  disconnect in progress */
+#define ABORTING_OR_DISCONNECTING	((1UL << US_FLIDX_ABORTING) | \
+					 (1UL << US_FLIDX_DISCONNECTING))
+#define US_FLIDX_RESETTING	22  /* 0x00400000  device reset in progress */
+#define US_FLIDX_TIMED_OUT	23  /* 0x00800000  SCSI midlayer timed out  */
+
+/*
+ * The bias field for libusual and friends.
+ * Observe that usb-storage blatantly mixes set_bit() and normal
+ * shift and mask operations on flags, which is strictly illegal.
+ * And it probably even works for all flags except GO_SLOW and NO_WP_DETECT.
+ * We align with the shift and mask version used by static flags above, because
+ * we do not know (in theory) about the set_bit used by usb-storage internally.
+ * In next release, it might as well remap, use spinlocks, or whatever...
+ */
+#define USB_US_TYPE_NONE   0
+#define USB_US_TYPE_STOR   1
+#define USB_US_TYPE_UB     2
+
+#define USB_US_TYPE(flags)  (((flags) >> 24) & 0xFF)
+
+/*
+ * This is probably not the best place to keep these constants, conceptually.
+ * But it's the only header included into all places which need them.
+ */
+
+/* Sub Classes */
+
+#define US_SC_RBC	0x01		/* Typically, flash devices */
+#define US_SC_8020	0x02		/* CD-ROM */
+#define US_SC_QIC	0x03		/* QIC-157 Tapes */
+#define US_SC_UFI	0x04		/* Floppy */
+#define US_SC_8070	0x05		/* Removable media */
+#define US_SC_SCSI	0x06		/* Transparent */
+#define US_SC_ISD200    0x07		/* ISD200 ATA */
+#define US_SC_MIN	US_SC_RBC
+#define US_SC_MAX	US_SC_ISD200
+
+#define US_SC_DEVICE	0xff		/* Use device's value */
+
+/* Protocols */
+
+#define US_PR_CBI	0x00		/* Control/Bulk/Interrupt */
+#define US_PR_CB	0x01		/* Control/Bulk w/o interrupt */
+#define US_PR_BULK	0x50		/* bulk only */
+#ifdef CONFIG_USB_STORAGE_USBAT
+#define US_PR_SCM_ATAPI	0x80		/* SCM-ATAPI bridge */
+#endif
+#ifdef CONFIG_USB_STORAGE_SDDR09
+#define US_PR_EUSB_SDDR09	0x81	/* SCM-SCSI bridge for SDDR-09 */
+#endif
+#ifdef CONFIG_USB_STORAGE_SDDR55
+#define US_PR_SDDR55	0x82		/* SDDR-55 (made up) */
+#endif
+#define US_PR_DPCM_USB  0xf0		/* Combination CB/SDDR09 */
+#ifdef CONFIG_USB_STORAGE_FREECOM
+#define US_PR_FREECOM   0xf1		/* Freecom */
+#endif
+#ifdef CONFIG_USB_STORAGE_DATAFAB
+#define US_PR_DATAFAB   0xf2		/* Datafab chipsets */
+#endif
+#ifdef CONFIG_USB_STORAGE_JUMPSHOT
+#define US_PR_JUMPSHOT  0xf3		/* Lexar Jumpshot */
+#endif
+
+#define US_PR_DEVICE	0xff		/* Use device's value */
+
+/*
+ */
+#ifdef CONFIG_USB_LIBUSUAL
+
+extern struct usb_device_id storage_usb_ids[];
+extern void usb_usual_set_present(int type, int present);
+#else
+
+#define usb_usual_set_present(t,p)	do { } while(0)
+#endif /* CONFIG_USB_LIBUSUAL */
+
+#endif /* __LINUX_USB_USUAL_H */
