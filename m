Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbSJAAcA>; Mon, 30 Sep 2002 20:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261417AbSJAAcA>; Mon, 30 Sep 2002 20:32:00 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:3590 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261413AbSJAAbc>;
	Mon, 30 Sep 2002 20:31:32 -0400
Date: Mon, 30 Sep 2002 17:34:40 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB changes for 2.5.39
Message-ID: <20021001003440.GE3994@kroah.com>
References: <20021001003104.GA3994@kroah.com> <20021001003240.GB3994@kroah.com> <20021001003304.GC3994@kroah.com> <20021001003401.GD3994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001003401.GD3994@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.660.1.3 -> 1.660.1.4
#	drivers/usb/core/usb.c	1.88    -> 1.89   
#	drivers/usb/core/Makefile	1.11    -> 1.12   
#	               (new)	        -> 1.1     drivers/usb/core/usb.h
#	               (new)	        -> 1.1     drivers/usb/core/driverfs.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/30	greg@kroah.com	1.660.1.4
# USB: add a lot more driverfs files for all usb devices.
# --------------------------------------------
#
diff -Nru a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
--- a/drivers/usb/core/Makefile	Mon Sep 30 17:25:40 2002
+++ b/drivers/usb/core/Makefile	Mon Sep 30 17:25:40 2002
@@ -5,7 +5,7 @@
 export-objs	:= usb.o hcd.o hcd-pci.o urb.o message.o file.o buffer.o
 
 usbcore-objs	:= usb.o usb-debug.o hub.o hcd.o urb.o message.o \
-			config.o file.o buffer.o
+			config.o file.o buffer.o driverfs.o
 
 ifeq ($(CONFIG_PCI),y)
 	usbcore-objs	+= hcd-pci.o
diff -Nru a/drivers/usb/core/driverfs.c b/drivers/usb/core/driverfs.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/usb/core/driverfs.c	Mon Sep 30 17:25:40 2002
@@ -0,0 +1,177 @@
+/*
+ * drivers/usb/core/driverfs.c
+ *
+ * (C) Copyright 2002 David Brownell
+ * (C) Copyright 2002 Greg Kroah-Hartman
+ * (C) Copyright 2002 IBM Corp.
+ *
+ * All of the driverfs file attributes for usb devices and interfaces.
+ *
+ */
+
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+
+#ifdef CONFIG_USB_DEBUG
+	#define DEBUG
+#else
+	#undef DEBUG
+#endif
+#include <linux/usb.h>
+
+#include "usb.h"
+
+/* Active configuration fields */
+#define usb_actconfig_attr(field, format_string)			\
+static ssize_t								\
+show_##field (struct device *dev, char *buf, size_t count, loff_t off)	\
+{									\
+	struct usb_device *udev;					\
+									\
+	if (off)							\
+		return 0;						\
+									\
+	udev = to_usb_device (dev);					\
+	return sprintf (buf, format_string, udev->actconfig->field);	\
+}									\
+static DEVICE_ATTR(field, S_IRUGO, show_##field, NULL);
+
+usb_actconfig_attr (bNumInterfaces, "%2d\n")
+usb_actconfig_attr (bConfigurationValue, "%2d\n")
+usb_actconfig_attr (bmAttributes, "%2x\n")
+usb_actconfig_attr (MaxPower, "%3dmA\n")
+
+/* String fields */
+static ssize_t show_product (struct device *dev, char *buf, size_t count, loff_t off)
+{
+	struct usb_device *udev;
+	int len;
+
+	if (off)
+		return 0;
+	udev = to_usb_device (dev);
+
+	len = usb_string(udev, udev->descriptor.iProduct, buf, PAGE_SIZE);
+	if (len < 0)
+		return 0;
+	buf[len] = '\n';
+	buf[len+1] = 0;
+	return len+1;
+}
+static DEVICE_ATTR(product,S_IRUGO,show_product,NULL);
+
+static ssize_t
+show_manufacturer (struct device *dev, char *buf, size_t count, loff_t off)
+{
+	struct usb_device *udev;
+	int len;
+
+	if (off)
+		return 0;
+	udev = to_usb_device (dev);
+
+	len = usb_string(udev, udev->descriptor.iManufacturer, buf, PAGE_SIZE);
+	if (len < 0)
+		return 0;
+	buf[len] = '\n';
+	buf[len+1] = 0;
+	return len+1;
+}
+static DEVICE_ATTR(manufacturer,S_IRUGO,show_manufacturer,NULL);
+
+static ssize_t
+show_serial (struct device *dev, char *buf, size_t count, loff_t off)
+{
+	struct usb_device *udev;
+	int len;
+
+	if (off)
+		return 0;
+	udev = to_usb_device (dev);
+
+	len = usb_string(udev, udev->descriptor.iSerialNumber, buf, PAGE_SIZE);
+	if (len < 0)
+		return 0;
+	buf[len] = '\n';
+	buf[len+1] = 0;
+	return len+1;
+}
+static DEVICE_ATTR(serial,S_IRUGO,show_serial,NULL);
+
+/* Descriptor fields */
+#define usb_descriptor_attr(field, format_string)			\
+static ssize_t								\
+show_##field (struct device *dev, char *buf, size_t count, loff_t off)	\
+{									\
+	struct usb_device *udev;					\
+									\
+	if (off)							\
+		return 0;						\
+									\
+	udev = to_usb_device (dev);					\
+	return sprintf (buf, format_string, udev->descriptor.field);	\
+}									\
+static DEVICE_ATTR(field, S_IRUGO, show_##field, NULL);
+
+usb_descriptor_attr (idVendor, "%04x\n")
+usb_descriptor_attr (idProduct, "%04x\n")
+usb_descriptor_attr (bcdDevice, "%04x\n")
+usb_descriptor_attr (bDeviceClass, "%02x\n")
+usb_descriptor_attr (bDeviceSubClass, "%02x\n")
+usb_descriptor_attr (bDeviceProtocol, "%02x\n")
+
+
+void usb_create_driverfs_dev_files (struct usb_device *udev)
+{
+	struct device *dev = &udev->dev;
+
+	device_create_file (dev, &dev_attr_bNumInterfaces);
+	device_create_file (dev, &dev_attr_bConfigurationValue);
+	device_create_file (dev, &dev_attr_bmAttributes);
+	device_create_file (dev, &dev_attr_MaxPower);
+	device_create_file (dev, &dev_attr_idVendor);
+	device_create_file (dev, &dev_attr_idProduct);
+	device_create_file (dev, &dev_attr_bcdDevice);
+	device_create_file (dev, &dev_attr_bDeviceClass);
+	device_create_file (dev, &dev_attr_bDeviceSubClass);
+	device_create_file (dev, &dev_attr_bDeviceProtocol);
+
+	if (udev->descriptor.iManufacturer)
+		device_create_file (dev, &dev_attr_manufacturer);
+	if (udev->descriptor.iProduct)
+		device_create_file (dev, &dev_attr_product);
+	if (udev->descriptor.iSerialNumber)
+		device_create_file (dev, &dev_attr_serial);
+}
+
+/* Interface fields */
+#define usb_intf_attr(field, format_string)				\
+static ssize_t								\
+show_##field (struct device *dev, char *buf, size_t count, loff_t off)	\
+{									\
+	struct usb_interface *intf;					\
+	int alt;							\
+									\
+	if (off)							\
+		return 0;						\
+									\
+	intf = to_usb_interface (dev);					\
+	alt = intf->act_altsetting;					\
+									\
+	return sprintf (buf, format_string, intf->altsetting[alt].field);	\
+}									\
+static DEVICE_ATTR(field, S_IRUGO, show_##field, NULL);
+
+usb_intf_attr (bAlternateSetting, "%2d\n")
+usb_intf_attr (bInterfaceClass, "%02x\n")
+usb_intf_attr (bInterfaceSubClass, "%02x\n")
+usb_intf_attr (bInterfaceProtocol, "%02x\n")
+
+void usb_create_driverfs_intf_files (struct usb_interface *intf)
+{
+	device_create_file (&intf->dev, &dev_attr_bAlternateSetting);
+	device_create_file (&intf->dev, &dev_attr_bInterfaceClass);
+	device_create_file (&intf->dev, &dev_attr_bInterfaceSubClass);
+	device_create_file (&intf->dev, &dev_attr_bInterfaceProtocol);
+}
diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	Mon Sep 30 17:25:40 2002
+++ b/drivers/usb/core/usb.c	Mon Sep 30 17:25:40 2002
@@ -42,6 +42,7 @@
 #include <linux/usb.h>
 
 #include "hcd.h"
+#include "usb.h"
 
 extern int  usb_hub_init(void);
 extern void usb_hub_cleanup(void);
@@ -629,98 +630,6 @@
 
 #endif	/* CONFIG_HOTPLUG */
 
-/* driverfs files */
-
-/* devices have one current configuration, with one
- * or more interfaces that are used concurrently 
- */
-static ssize_t
-show_config (struct device *dev, char *buf, size_t count, loff_t off)
-{
-	struct usb_device	*udev;
-
-	if (off)
-		return 0;
-	udev = to_usb_device (dev);
-	return sprintf (buf, "%u\n", udev->actconfig->bConfigurationValue);
-}
-
-static DEVICE_ATTR(configuration,S_IRUGO,show_config,NULL);
-
-/* interfaces have one current setting; alternates
- * can have different endpoints and class info.
- */
-static ssize_t
-show_altsetting (struct device *dev, char *buf, size_t count, loff_t off)
-{
-	struct usb_interface	*interface;
-
-	if (off)
-		return 0;
-	interface = to_usb_interface (dev);
-	return sprintf (buf, "%u\n", interface->altsetting->bAlternateSetting);
-}
-static DEVICE_ATTR(altsetting,S_IRUGO,show_altsetting,NULL);
-
-/* product driverfs file */
-static ssize_t show_product (struct device *dev, char *buf, size_t count, loff_t off)
-{
-	struct usb_device *udev;
-	int len;
-
-	if (off)
-		return 0;
-	udev = to_usb_device (dev);
-
-	len = usb_string(udev, udev->descriptor.iProduct, buf, PAGE_SIZE);
-	if (len < 0)
-		return 0;
-	buf[len] = '\n';
-	buf[len+1] = 0;
-	return len+1;
-}
-static DEVICE_ATTR(product,S_IRUGO,show_product,NULL);
-
-/* manufacturer driverfs file */
-static ssize_t
-show_manufacturer (struct device *dev, char *buf, size_t count, loff_t off)
-{
-	struct usb_device *udev;
-	int len;
-
-	if (off)
-		return 0;
-	udev = to_usb_device (dev);
-
-	len = usb_string(udev, udev->descriptor.iManufacturer, buf, PAGE_SIZE);
-	if (len < 0)
-		return 0;
-	buf[len] = '\n';
-	buf[len+1] = 0;
-	return len+1;
-}
-static DEVICE_ATTR(manufacturer,S_IRUGO,show_manufacturer,NULL);
-
-/* serial number driverfs file */
-static ssize_t
-show_serial (struct device *dev, char *buf, size_t count, loff_t off)
-{
-	struct usb_device *udev;
-	int len;
-
-	if (off)
-		return 0;
-	udev = to_usb_device (dev);
-
-	len = usb_string(udev, udev->descriptor.iSerialNumber, buf, PAGE_SIZE);
-	if (len < 0)
-		return 0;
-	buf[len] = '\n';
-	buf[len+1] = 0;
-	return len+1;
-}
-static DEVICE_ATTR(serial,S_IRUGO,show_serial,NULL);
-
 /**
  * usb_alloc_dev - allocate a usb device structure (usbcore-internal)
  * @parent: hub to which device is connected
@@ -1133,13 +1042,7 @@
 		return err;
 
 	/* add the USB device specific driverfs files */
-	device_create_file (&dev->dev, &dev_attr_configuration);
-	if (dev->descriptor.iManufacturer)
-		device_create_file (&dev->dev, &dev_attr_manufacturer);
-	if (dev->descriptor.iProduct)
-		device_create_file (&dev->dev, &dev_attr_product);
-	if (dev->descriptor.iSerialNumber)
-		device_create_file (&dev->dev, &dev_attr_serial);
+	usb_create_driverfs_dev_files (dev);
 
 	/* Register all of the interfaces for this device with the driver core.
 	 * Remember, interfaces get bound to drivers, not devices. */
@@ -1169,7 +1072,7 @@
 		}
 		dbg ("%s - registering %s", __FUNCTION__, interface->dev.bus_id);
 		device_register (&interface->dev);
-		device_create_file (&interface->dev, &dev_attr_altsetting);
+		usb_create_driverfs_intf_files (interface);
 	}
 
 	/* add a /proc/bus/usb entry */
diff -Nru a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/usb/core/usb.h	Mon Sep 30 17:25:40 2002
@@ -0,0 +1,5 @@
+/* Functions local to drivers/usb/core/ */
+
+extern void usb_create_driverfs_dev_files (struct usb_device *dev);
+extern void usb_create_driverfs_intf_files (struct usb_interface *intf);
+
