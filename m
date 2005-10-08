Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVJHVCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVJHVCA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 17:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVJHVCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 17:02:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41130 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751112AbVJHVB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 17:01:59 -0400
Date: Sat, 8 Oct 2005 14:01:32 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       usb-storage@lists.one-eyed-alien.net, zaitcev@redhat.com
Subject: usb: drivers/usb/storage/libusual
Message-Id: <20051008140132.49f9eec3.zaitcev@redhat.com>
In-Reply-To: <20050928085159.GA11862@kroah.com>
References: <20050927205559.078ba9ed.zaitcev@redhat.com>
	<20050928085159.GA11862@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a shim driver libusual, which routes devices between
usb-storage and ub according to the common table, based on unusual_devs.h.
The help and example syntax is in Kconfig.

Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>

---

I think libusual is ready for Andrew's tree now. I realize that the use
of request_module is an inkblot in this copybook, so maybe it's not the
time for Linus' tree yet. Another concern I have is if we have any races
with hotplug, udev, and HAL.

I haven't heard from Adrian yet, but I suppose it's a good sign.
No word from Matt Dharm either, which is not so good... But I do have
Alan Stern's buy-in.

This version uses unusual_devs practically as-is, so Phil Deibowitz would
see no change.

diff -urpN -X dontdiff linux-2.6.14-rc3/drivers/block/Kconfig linux-2.6.14-rc3-lem/drivers/block/Kconfig
--- linux-2.6.14-rc3/drivers/block/Kconfig	2005-10-07 21:27:50.000000000 -0700
+++ linux-2.6.14-rc3-lem/drivers/block/Kconfig	2005-10-08 12:05:18.000000000 -0700
@@ -358,7 +358,8 @@ config BLK_DEV_UB
 	  This driver supports certain USB attached storage devices
 	  such as flash keys.
 
-	  Warning: Enabling this cripples the usb-storage driver.
+	  If you enable this driver, it is recommended to avoid conflicts
+	  with usb-storage by enabling USB_LIBUSUAL.
 
 	  If unsure, say N.
 
diff -urpN -X dontdiff linux-2.6.14-rc3/drivers/block/ub.c linux-2.6.14-rc3-lem/drivers/block/ub.c
--- linux-2.6.14-rc3/drivers/block/ub.c	2005-10-07 21:27:51.000000000 -0700
+++ linux-2.6.14-rc3-lem/drivers/block/ub.c	2005-10-08 13:16:16.000000000 -0700
@@ -29,6 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/usb.h>
+#include <linux/usb_usual.h>
 #include <linux/blkdev.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/timer.h>
@@ -107,16 +108,6 @@
  */
 
 /*
- * Definitions which have to be scattered once we understand the layout better.
- */
-
-/* Transport (despite PR in the name) */
-#define US_PR_BULK	0x50		/* bulk only */
-
-/* Protocol */
-#define US_SC_SCSI	0x06		/* Transparent */
-
-/*
  * This many LUNs per USB device.
  * Every one of them takes a host, see UB_MAX_HOSTS.
  */
@@ -422,13 +413,18 @@ static int ub_probe_lun(struct ub_dev *s
 
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
@@ -2172,6 +2168,9 @@ static int ub_probe(struct usb_interface
 	int rc;
 	int i;
 
+	if (USB_US_TYPE(dev_id->driver_info) != USB_US_TYPE_UB)
+		return -ENXIO;
+
 	rc = -ENOMEM;
 	if ((sc = kmalloc(sizeof(struct ub_dev), GFP_KERNEL)) == NULL)
 		goto err_core;
@@ -2472,6 +2471,8 @@ static int __init ub_init(void)
 {
 	int rc;
 
+	usb_usual_set_present(USB_US_TYPE_UB);
+
 	if ((rc = register_blkdev(UB_MAJOR, DRV_NAME)) != 0)
 		goto err_regblkdev;
 	devfs_mk_dir(DEVFS_NAME);
@@ -2485,6 +2486,7 @@ err_register:
 	devfs_remove(DEVFS_NAME);
 	unregister_blkdev(UB_MAJOR, DRV_NAME);
 err_regblkdev:
+	usb_usual_clear_present(USB_US_TYPE_UB);
 	return rc;
 }
 
@@ -2494,6 +2496,7 @@ static void __exit ub_exit(void)
 
 	devfs_remove(DEVFS_NAME);
 	unregister_blkdev(UB_MAJOR, DRV_NAME);
+	usb_usual_clear_present(USB_US_TYPE_UB);
 }
 
 module_init(ub_init);
diff -urpN -X dontdiff linux-2.6.14-rc3/drivers/usb/storage/Kconfig linux-2.6.14-rc3-lem/drivers/usb/storage/Kconfig
--- linux-2.6.14-rc3/drivers/usb/storage/Kconfig	2005-10-07 21:28:13.000000000 -0700
+++ linux-2.6.14-rc3-lem/drivers/usb/storage/Kconfig	2005-10-08 12:05:18.000000000 -0700
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
diff -urpN -X dontdiff linux-2.6.14-rc3/drivers/usb/storage/libusual.c linux-2.6.14-rc3-lem/drivers/usb/storage/libusual.c
--- linux-2.6.14-rc3/drivers/usb/storage/libusual.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.14-rc3-lem/drivers/usb/storage/libusual.c	2005-10-08 13:10:20.000000000 -0700
@@ -0,0 +1,268 @@
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
+static DECLARE_MUTEX_LOCKED(usu_init_notify);
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
+  .driver_info = (flags)|(USB_US_TYPE_STOR<<24) }
+
+#define USUAL_DEV(useProto, useTrans, useType) \
+{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, useProto, useTrans), \
+  .driver_info = ((useType)<<24) }
+
+struct usb_device_id storage_usb_ids [] = {
+#	include "unusual_devs.h"
+	{ } /* Terminating entry */
+};
+
+#undef USUAL_DEV
+#undef UNUSUAL_DEV
+
+MODULE_DEVICE_TABLE(usb, storage_usb_ids);
+EXPORT_SYMBOL(storage_usb_ids);
+
+/*
+ * @type: the module type as an integer
+ */
+void usb_usual_set_present(int type)
+{
+	struct mod_status *st;
+	unsigned long flags;
+
+	if (type <= 0 || type >= 3)
+		return;
+	st = &stat[type];
+	spin_lock_irqsave(&usu_lock, flags);
+	st->fls |= USU_MOD_FL_PRESENT;
+	spin_unlock_irqrestore(&usu_lock, flags);
+}
+EXPORT_SYMBOL(usb_usual_set_present);
+
+void usb_usual_clear_present(int type)
+{
+	struct mod_status *st;
+	unsigned long flags;
+
+	if (type <= 0 || type >= 3)
+		return;
+	st = &stat[type];
+	spin_lock_irqsave(&usu_lock, flags);
+	st->fls &= ~USU_MOD_FL_PRESENT;
+	spin_unlock_irqrestore(&usu_lock, flags);
+}
+EXPORT_SYMBOL(usb_usual_clear_present);
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
+	if (type == 0)
+		return -ENXIO;
+
+	spin_lock_irqsave(&usu_lock, flags);
+	if ((stat[type].fls & (USU_MOD_FL_THREAD|USU_MOD_FL_PRESENT)) != 0) {
+		spin_unlock_irqrestore(&usu_lock, flags);
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
+
+	/* A completion does not work here because it's counted. */
+	down(&usu_init_notify);
+	up(&usu_init_notify);
+
+	rc = request_module(bias_names[type]);
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
+		up(&usu_init_notify);
+		return rc;
+	}
+	up(&usu_init_notify);
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
diff -urpN -X dontdiff linux-2.6.14-rc3/drivers/usb/storage/Makefile linux-2.6.14-rc3-lem/drivers/usb/storage/Makefile
--- linux-2.6.14-rc3/drivers/usb/storage/Makefile	2005-10-07 21:28:13.000000000 -0700
+++ linux-2.6.14-rc3-lem/drivers/usb/storage/Makefile	2005-10-08 12:05:18.000000000 -0700
@@ -22,3 +22,7 @@ usb-storage-obj-$(CONFIG_USB_STORAGE_ONE
 
 usb-storage-objs :=	scsiglue.o protocol.o transport.o usb.o \
 			initializers.o $(usb-storage-obj-y)
+
+ifneq ($(CONFIG_USB_LIBUSUAL),)
+	obj-$(CONFIG_USB)	+= libusual.o
+endif
diff -urpN -X dontdiff linux-2.6.14-rc3/drivers/usb/storage/protocol.h linux-2.6.14-rc3-lem/drivers/usb/storage/protocol.h
--- linux-2.6.14-rc3/drivers/usb/storage/protocol.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.14-rc3-lem/drivers/usb/storage/protocol.h	2005-10-08 12:05:18.000000000 -0700
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
diff -urpN -X dontdiff linux-2.6.14-rc3/drivers/usb/storage/transport.h linux-2.6.14-rc3-lem/drivers/usb/storage/transport.h
--- linux-2.6.14-rc3/drivers/usb/storage/transport.h	2005-09-13 01:06:21.000000000 -0700
+++ linux-2.6.14-rc3-lem/drivers/usb/storage/transport.h	2005-10-08 13:14:20.000000000 -0700
@@ -41,39 +41,8 @@
 #ifndef _TRANSPORT_H_
 #define _TRANSPORT_H_
 
-#include <linux/config.h>
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
diff -urpN -X dontdiff linux-2.6.14-rc3/drivers/usb/storage/unusual_devs.h linux-2.6.14-rc3-lem/drivers/usb/storage/unusual_devs.h
--- linux-2.6.14-rc3/drivers/usb/storage/unusual_devs.h	2005-10-07 21:28:14.000000000 -0700
+++ linux-2.6.14-rc3-lem/drivers/usb/storage/unusual_devs.h	2005-10-08 12:05:18.000000000 -0700
@@ -1093,3 +1113,27 @@ UNUSUAL_DEV(  0x55aa, 0xa103, 0x0000, 0x
 		US_SC_SCSI, US_PR_SDDR55, NULL,
 		US_FL_SINGLE_LUN),
 #endif
+
+/* Control/Bulk transport for all SubClass values */
+USUAL_DEV(US_SC_RBC, US_PR_CB, USB_US_TYPE_STOR),
+USUAL_DEV(US_SC_8020, US_PR_CB, USB_US_TYPE_STOR),
+USUAL_DEV(US_SC_QIC, US_PR_CB, USB_US_TYPE_STOR),
+USUAL_DEV(US_SC_UFI, US_PR_CB, USB_US_TYPE_STOR),
+USUAL_DEV(US_SC_8070, US_PR_CB, USB_US_TYPE_STOR),
+USUAL_DEV(US_SC_SCSI, US_PR_CB, USB_US_TYPE_STOR),
+
+/* Control/Bulk/Interrupt transport for all SubClass values */
+USUAL_DEV(US_SC_RBC, US_PR_CBI, USB_US_TYPE_STOR),
+USUAL_DEV(US_SC_8020, US_PR_CBI, USB_US_TYPE_STOR),
+USUAL_DEV(US_SC_QIC, US_PR_CBI, USB_US_TYPE_STOR),
+USUAL_DEV(US_SC_UFI, US_PR_CBI, USB_US_TYPE_STOR),
+USUAL_DEV(US_SC_8070, US_PR_CBI, USB_US_TYPE_STOR),
+USUAL_DEV(US_SC_SCSI, US_PR_CBI, USB_US_TYPE_STOR),
+
+/* Bulk-only transport for all SubClass values */
+USUAL_DEV(US_SC_RBC, US_PR_BULK, USB_US_TYPE_STOR),
+USUAL_DEV(US_SC_8020, US_PR_BULK, USB_US_TYPE_STOR),
+USUAL_DEV(US_SC_QIC, US_PR_BULK, USB_US_TYPE_STOR),
+USUAL_DEV(US_SC_UFI, US_PR_BULK, USB_US_TYPE_STOR),
+USUAL_DEV(US_SC_8070, US_PR_BULK, USB_US_TYPE_STOR),
+USUAL_DEV(US_SC_SCSI, US_PR_BULK, 0),
diff -urpN -X dontdiff linux-2.6.14-rc3/drivers/usb/storage/usb.c linux-2.6.14-rc3-lem/drivers/usb/storage/usb.c
--- linux-2.6.14-rc3/drivers/usb/storage/usb.c	2005-10-07 21:28:14.000000000 -0700
+++ linux-2.6.14-rc3-lem/drivers/usb/storage/usb.c	2005-10-08 13:10:55.000000000 -0700
@@ -116,49 +116,33 @@ static int storage_probe(struct usb_inte
 
 static void storage_disconnect(struct usb_interface *iface);
 
-/* The entries in this table, except for final ones here
- * (USB_MASS_STORAGE_CLASS and the empty entry), correspond,
- * line for line with the entries of us_unsuaul_dev_list[].
+/*
+ * The entries in this table correspond, line for line,
+ * with the entries of us_unusual_dev_list[].
  */
+#ifndef CONFIG_USB_LIBUSUAL
 
 #define UNUSUAL_DEV(id_vendor, id_product, bcdDeviceMin, bcdDeviceMax, \
 		    vendorName, productName,useProtocol, useTransport, \
 		    initFunction, flags) \
-{ USB_DEVICE_VER(id_vendor, id_product, bcdDeviceMin,bcdDeviceMax) }
+{ USB_DEVICE_VER(id_vendor, id_product, bcdDeviceMin,bcdDeviceMax), \
+  .driver_info = (flags)|(USB_US_TYPE_STOR<<24) }
+
+#define USUAL_DEV(useProto, useTrans, useType) \
+{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, useProto, useTrans), \
+  .driver_info = (USB_US_TYPE_STOR<<24) }
 
 static struct usb_device_id storage_usb_ids [] = {
 
 #	include "unusual_devs.h"
 #undef UNUSUAL_DEV
-	/* Control/Bulk transport for all SubClass values */
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_RBC, US_PR_CB) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_8020, US_PR_CB) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_QIC, US_PR_CB) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_UFI, US_PR_CB) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_8070, US_PR_CB) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_SCSI, US_PR_CB) },
-
-	/* Control/Bulk/Interrupt transport for all SubClass values */
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_RBC, US_PR_CBI) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_8020, US_PR_CBI) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_QIC, US_PR_CBI) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_UFI, US_PR_CBI) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_8070, US_PR_CBI) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_SCSI, US_PR_CBI) },
-
-	/* Bulk-only transport for all SubClass values */
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_RBC, US_PR_BULK) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_8020, US_PR_BULK) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_QIC, US_PR_BULK) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_UFI, US_PR_BULK) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_8070, US_PR_BULK) },
-	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_SCSI, US_PR_BULK) },
-
+#undef USUAL_DEV
 	/* Terminating entry */
 	{ }
 };
 
 MODULE_DEVICE_TABLE (usb, storage_usb_ids);
+#endif /* CONFIG_USB_LIBUSUAL */
 
 /* This is the list of devices we recognize, along with their flag data */
 
@@ -171,7 +155,6 @@ MODULE_DEVICE_TABLE (usb, storage_usb_id
  * are free to use as many characters as you like.
  */
 
-#undef UNUSUAL_DEV
 #define UNUSUAL_DEV(idVendor, idProduct, bcdDeviceMin, bcdDeviceMax, \
 		    vendor_name, product_name, use_protocol, use_transport, \
 		    init_function, Flags) \
@@ -181,53 +164,18 @@ MODULE_DEVICE_TABLE (usb, storage_usb_id
 	.useProtocol = use_protocol,	\
 	.useTransport = use_transport,	\
 	.initFunction = init_function,	\
-	.flags = Flags, \
+}
+
+#define USUAL_DEV(use_protocol, use_transport, use_type) \
+{ \
+	.useProtocol = use_protocol,	\
+	.useTransport = use_transport,	\
 }
 
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
+#	undef USUAL_DEV
 
 	/* Terminating entry */
 	{ NULL }
@@ -469,15 +417,21 @@ static int associate_dev(struct us_data 
 	}
 	return 0;
 }
+ 
+/* Find an unusual_dev descriptor (always succeeds in the current code) */
+static struct us_unusual_dev *find_unusual_entry(const struct usb_device_id *id)
+{
+	const int id_index = id - storage_usb_ids;
+	return &us_unusual_dev_list[id_index];
+}
 
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
@@ -487,7 +441,7 @@ static void get_device_info(struct us_da
 	us->protocol = (unusual_dev->useTransport == US_PR_DEVICE) ?
 			idesc->bInterfaceProtocol :
 			unusual_dev->useTransport;
-	us->flags = unusual_dev->flags;
+	us->flags = id->driver_info;
 
 	/*
 	 * This flag is only needed when we're in high-speed, so let's
@@ -515,7 +469,7 @@ static void get_device_info(struct us_da
 		if (unusual_dev->useTransport != US_PR_DEVICE &&
 			us->protocol == idesc->bInterfaceProtocol)
 			msg += 2;
-		if (msg >= 0 && !(unusual_dev->flags & US_FL_NEED_OVERRIDE))
+		if (msg >= 0 && !(us->flags & US_FL_NEED_OVERRIDE))
 			printk(KERN_NOTICE USB_STORAGE "This device "
 				"(%04x,%04x,%04x S %02x P %02x)"
 				" has %s in unusual_devs.h\n"
@@ -921,9 +897,11 @@ static int storage_probe(struct usb_inte
 {
 	struct Scsi_Host *host;
 	struct us_data *us;
-	const int id_index = id - storage_usb_ids; 
 	int result;
 
+	if (USB_US_TYPE(id->driver_info) != USB_US_TYPE_STOR)
+		return -ENXIO;
+
 	US_DEBUGP("USB Mass Storage device detected\n");
 
 	/*
@@ -956,7 +934,7 @@ static int storage_probe(struct usb_inte
 	 * of the match from the usb_device_id table, so we can find the
 	 * corresponding entry in the private table.
 	 */
-	get_device_info(us, id_index);
+	get_device_info(us, id);
 
 #ifdef CONFIG_USB_STORAGE_SDDR09
 	if (us->protocol == US_PR_EUSB_SDDR09 ||
@@ -1043,10 +1021,14 @@ static int __init usb_stor_init(void)
 	int retval;
 	printk(KERN_INFO "Initializing USB Mass Storage driver...\n");
 
+	usb_usual_set_present(USB_US_TYPE_STOR);
+
 	/* register the driver, return usb_register return code if error */
 	retval = usb_register(&usb_storage_driver);
 	if (retval == 0)
 		printk(KERN_INFO "USB Mass Storage support registered.\n");
+	else
+		usb_usual_clear_present(USB_US_TYPE_STOR);
 
 	return retval;
 }
@@ -1071,6 +1053,8 @@ static void __exit usb_stor_exit(void)
 		wait_for_completion(&threads_gone);
 		atomic_dec(&total_threads);
 	}
+
+	usb_usual_clear_present(USB_US_TYPE_STOR);
 }
 
 module_init(usb_stor_init);
diff -urpN -X dontdiff linux-2.6.14-rc3/drivers/usb/storage/usb.h linux-2.6.14-rc3-lem/drivers/usb/storage/usb.h
--- linux-2.6.14-rc3/drivers/usb/storage/usb.h	2005-10-07 21:28:14.000000000 -0700
+++ linux-2.6.14-rc3-lem/drivers/usb/storage/usb.h	2005-10-08 12:05:18.000000000 -0700
@@ -45,6 +45,7 @@
 #define _USB_H_
 
 #include <linux/usb.h>
+#include <linux/usb_usual.h>
 #include <linux/blkdev.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
@@ -63,38 +64,8 @@ struct us_unusual_dev {
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
 
 /* Dynamic flag definitions: used in set_bit() etc. */
 #define US_FLIDX_URB_ACTIVE	18  /* 0x00040000  current_urb is in use  */
diff -urpN -X dontdiff linux-2.6.14-rc3/include/linux/usb_usual.h linux-2.6.14-rc3-lem/include/linux/usb_usual.h
--- linux-2.6.14-rc3/include/linux/usb_usual.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.14-rc3-lem/include/linux/usb_usual.h	2005-10-08 13:15:00.000000000 -0700
@@ -0,0 +1,120 @@
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
+/*
+ * The bias field for libusual and friends.
+ */
+#define USB_US_TYPE_NONE   0
+#define USB_US_TYPE_STOR   1		/* usb-storage */
+#define USB_US_TYPE_UB     2		/* ub */
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
+extern void usb_usual_set_present(int type);
+extern void usb_usual_clear_present(int type);
+#else
+
+#define usb_usual_set_present(t)	do { } while(0)
+#define usb_usual_clear_present(t)	do { } while(0)
+#endif /* CONFIG_USB_LIBUSUAL */
+
+#endif /* __LINUX_USB_USUAL_H */
