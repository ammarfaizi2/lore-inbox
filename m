Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWFIWm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWFIWm2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWFIWm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:42:28 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:6595 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751428AbWFIWm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:42:26 -0400
From: Oliver Bock <o.bock@fh-wolfenbuettel.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: new driver for Cypress CY7C63xxx mirco controllers
Date: Sat, 10 Jun 2006 00:42:19 +0200
User-Agent: KMail/1.9.1
Cc: pavel@ucw.cz, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606100042.19441.o.bock@fh-wolfenbuettel.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:dd33dd6c1d5f49fc970db4042b12446b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Bock <o.bock@fh-wolfenbuettel.de>

This is a new driver for the Cypress CY7C63xxx mirco controller series. It 
currently supports the pre-programmed CYC63001A-PC by AK Modul-Bus GmbH.
It's based on a kernel 2.4 driver (cyport) by Marcus Maul which I ported to kernel 2.6 
using sysfs. I intend to support more controllers of this family (and more features) as
soon as I get hold of the required IDs etc. Please see the source code's header for
more information.

Signed-off-by: Oliver Bock <o.bock@fh-wolfenbuettel.de>

---

Please CC me as I'm not yet subscribed to LKML. Any comments are welcome.
Special thanks to Greg K-H and Pavel Machek for their helpful support!

diff against 2.6.17-rc6

--- linux-2.6.17-rc6/drivers/usb/Makefile.orig	2006-06-09 23:59:57.000000000 +0200
+++ linux-2.6.17-rc6/drivers/usb/Makefile	2006-06-10 00:13:15.626507000 +0200
@@ -48,6 +48,7 @@ obj-$(CONFIG_USB_MICROTEK)	+= image/
 obj-$(CONFIG_USB_SERIAL)	+= serial/
 
 obj-$(CONFIG_USB_AUERSWALD)	+= misc/
+obj-$(CONFIG_USB_CY7C63)	+= misc/
 obj-$(CONFIG_USB_CYTHERM)	+= misc/
 obj-$(CONFIG_USB_EMI26)		+= misc/
 obj-$(CONFIG_USB_EMI62)		+= misc/
--- linux-2.6.17-rc6/drivers/usb/misc/Kconfig.orig	2006-03-28 08:49:02.000000000 +0200
+++ linux-2.6.17-rc6/drivers/usb/misc/Kconfig	2006-06-10 00:16:07.093223000 +0200
@@ -88,6 +88,20 @@ config USB_LED
 	  To compile this driver as a module, choose M here: the
 	  module will be called usbled.
 
+config USB_CY7C63
+	tristate "Cypress CY7C63xxx USB driver support"
+	depends on USB
+	help
+	  Say Y here if you want to connect a Cypress CY7C63xxx
+	  micro controller to your computer's USB port. This driver
+	  supports the pre-programmed devices (incl. firmware) by
+	  AK Modul-Bus Computer GmbH.
+
+	  Please see: http://www.ak-modul-bus.de/stat/mikrocontroller.html
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cy7c63.
+
 config USB_CYTHERM
 	tristate "Cypress USB thermometer driver support"
 	depends on USB
--- linux-2.6.17-rc6/drivers/usb/misc/Makefile.orig	2006-03-28 08:49:02.000000000 +0200
+++ linux-2.6.17-rc6/drivers/usb/misc/Makefile	2006-06-10 00:14:32.419306250 +0200
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_USB_AUERSWALD)	+= auerswald.o
+obj-$(CONFIG_USB_CY7C63)	+= cy7c63.o
 obj-$(CONFIG_USB_CYTHERM)	+= cytherm.o
 obj-$(CONFIG_USB_EMI26)		+= emi26.o
 obj-$(CONFIG_USB_EMI62)		+= emi62.o
--- linux-2.6.17-rc6/drivers/usb/misc/cy7c63.c.orig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc6/drivers/usb/misc/cy7c63.c	2006-06-04 23:45:54.000000000 +0200
@@ -0,0 +1,244 @@
+/*
+* cy7c63.c
+*
+* Copyright (c) 2006 Oliver Bock (bock@fh-wolfenbuettel.de)
+*
+*	This driver is based on the Cypress Thermometer USB Driver by
+*	Marcus Maul and the 2.0 version of Greg Kroah-Hartman's
+*	USB Skeleton driver.
+*
+*	Is is a generic driver for the Cypress CY7C63000 family.
+*	For the time being it enables you to toggle the single I/O ports
+*	of the device.
+*
+*	Supported vendors:	AK Modul-Bus Computer GmbH
+*	Supported devices:	CY7C63001A-PC (to be continued...)
+*	Supported functions:	Read/Write Ports (to be continued...)
+*
+*	Chipsets families:	CY7C63000, CY7C63001, CY7C63100, CY7C63101
+*
+*
+*	This program is free software; you can redistribute it and/or
+*	modify it under the terms of the GNU General Public License as
+*	published by the Free Software Foundation, version 2.
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/usb.h>
+
+#define DRIVER_AUTHOR		"Oliver Bock (bock@fh-wolfenbuettel.de)"
+#define DRIVER_DESC		"Cypress CY7C63xxx USB driver"
+
+#define CY7C63_VENDOR_ID	0xa2c
+#define CY7C63_PRODUCT_ID	0x8
+
+#define CY7C63_READ_PORT	0x4
+#define CY7C63_WRITE_PORT	0x5
+#define CY7C63_READ_RAM		0x2
+#define CY7C63_WRITE_RAM	0x3
+#define CY7C63_READ_ROM		0x1
+
+#define CY7C63_READ_PORT_ID0	0
+#define CY7C63_WRITE_PORT_ID0	0
+#define CY7C63_READ_PORT_ID1	0x2
+#define CY7C63_WRITE_PORT_ID1	1
+
+#define CY7C63_MAX_REQSIZE	8
+
+
+/* table of devices that work with this driver */
+static struct usb_device_id cy7c63_table [] = {
+	{ USB_DEVICE(CY7C63_VENDOR_ID, CY7C63_PRODUCT_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, cy7c63_table);
+
+/* structure to hold all of our device specific stuff */
+struct cy7c63 {
+	struct usb_device *	udev;
+	char 			port0;
+	char			port1;
+};
+
+/* used to send usb control messages to device */
+int vendor_command(struct cy7c63 *dev, unsigned char request,
+			 unsigned char address, unsigned char data) {
+
+	int retval = 0;
+	unsigned int pipe;
+	unsigned char *iobuf;
+
+	/* allocate some memory for the i/o buffer*/
+	iobuf = kzalloc(CY7C63_MAX_REQSIZE, GFP_KERNEL);
+	if (!iobuf) {
+		dev_err(&dev->udev->dev, "Out of memory!\n");
+		retval = -ENOMEM;
+		goto error;
+	}
+
+	dev_dbg(&dev->udev->dev, "Sending usb_control_msg (data: %d)\n", data);
+
+	/* prepare usb control message and send it upstream */
+	pipe = usb_rcvctrlpipe(dev->udev, 0);
+	retval = usb_control_msg(dev->udev, pipe, request,
+				USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+				address, data, iobuf, CY7C63_MAX_REQSIZE,
+				USB_CTRL_GET_TIMEOUT);
+
+	/* store returned data (more READs to be added!) */
+	switch (request) {
+		case CY7C63_READ_PORT:
+			if (address == CY7C63_READ_PORT_ID0) {
+				dev->port0 = iobuf[1];
+				dev_dbg(&dev->udev->dev,
+					"READ_PORT0 returned: %d\n",dev->port0);
+			}
+			else if (address == CY7C63_READ_PORT_ID1) {
+				dev->port1 = iobuf[1];
+				dev_dbg(&dev->udev->dev,
+					"READ_PORT1 returned: %d\n",dev->port1);
+			}
+			break;
+	}
+
+	kfree(iobuf);
+error:
+	return retval;
+}
+
+#define get_set_port(num,read_id,write_id) \
+static ssize_t set_port##num(struct device *dev, struct device_attribute *attr,	\
+					const char *buf, size_t count) {	\
+										\
+	int value;								\
+	int result = 0;								\
+										\
+	struct usb_interface *intf = to_usb_interface(dev);			\
+	struct cy7c63 *cyp = usb_get_intfdata(intf);				\
+										\
+	dev_dbg(&cyp->udev->dev, "WRITE_PORT%d called\n", num);			\
+										\
+	/* validate input data */						\
+	if (sscanf(buf, "%d", &value) < 1) {					\
+		result = -EINVAL;						\
+		goto error;							\
+	}									\
+	if (value>255 || value<0) {						\
+		result = -EINVAL;						\
+		goto error;							\
+	}									\
+										\
+	result = vendor_command(cyp, CY7C63_WRITE_PORT, write_id,		\
+					 (unsigned char)value);			\
+										\
+	dev_dbg(&cyp->udev->dev, "Result of vendor_command: %d\n\n",result);	\
+error:										\
+	return result < 0 ? result : count;					\
+}										\
+										\
+static ssize_t get_port##num(struct device *dev,				\
+				 struct device_attribute *attr, char *buf) {	\
+										\
+	int result = 0;								\
+										\
+	struct usb_interface *intf = to_usb_interface(dev);			\
+	struct cy7c63 *cyp = usb_get_intfdata(intf);				\
+										\
+	dev_dbg(&cyp->udev->dev, "READ_PORT%d called\n", num);			\
+										\
+	result = vendor_command(cyp, CY7C63_READ_PORT, read_id, 0);		\
+										\
+	dev_dbg(&cyp->udev->dev, "Result of vendor_command: %d\n\n", result);	\
+										\
+	return sprintf(buf, "%d", cyp->port##num);				\
+}										\
+static DEVICE_ATTR(port##num, S_IWUGO | S_IRUGO, get_port##num, set_port##num);
+
+get_set_port(0, CY7C63_READ_PORT_ID0, CY7C63_WRITE_PORT_ID0);
+get_set_port(1, CY7C63_READ_PORT_ID1, CY7C63_WRITE_PORT_ID1);
+
+static int cy7c63_probe(struct usb_interface *interface,
+			const struct usb_device_id *id) {
+
+	struct cy7c63 *dev = NULL;
+	int retval = -ENOMEM;
+
+	/* allocate memory for our device state and initialize it */
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (dev == NULL) {
+		dev_err(&dev->udev->dev, "Out of memory!\n");
+		goto error;
+	}
+
+	dev->udev = usb_get_dev(interface_to_usbdev(interface));
+
+	/* save our data pointer in this interface device */
+	usb_set_intfdata(interface, dev);
+
+	/* create device attribute files */
+	device_create_file(&interface->dev, &dev_attr_port0);
+	device_create_file(&interface->dev, &dev_attr_port1);
+
+	/* let the user know what node this device is now attached to */
+	dev_info(&interface->dev,
+		"Cypress CY7C63xxx device now attached\n");
+
+	retval = 0;
+error:
+	return retval;
+}
+
+static void cy7c63_disconnect(struct usb_interface *interface) {
+
+	struct cy7c63 *dev;
+
+	dev = usb_get_intfdata(interface);
+	usb_set_intfdata(interface, NULL);
+
+	/* remove device attribute files */
+	device_remove_file(&interface->dev, &dev_attr_port0);
+	device_remove_file(&interface->dev, &dev_attr_port1);
+
+	usb_put_dev(dev->udev);
+
+	dev_info(&interface->dev,
+		"Cypress CY7C63xxx device now disconnected\n");
+
+	kfree(dev);
+}
+
+static struct usb_driver cy7c63_driver = {
+	.name = "cy7c63",
+	.probe = cy7c63_probe,
+	.disconnect = cy7c63_disconnect,
+	.id_table = cy7c63_table,
+};
+
+static int __init cy7c63_init(void) {
+
+	int result;
+
+	/* register this driver with the USB subsystem */
+	result = usb_register(&cy7c63_driver);
+	if (result) {
+		err("Function usb_register failed! Error number: %d\n", result);
+	}
+
+	return result;
+}
+
+static void __exit cy7c63_exit(void) {
+
+	/* deregister this driver with the USB subsystem */
+	usb_deregister(&cy7c63_driver);
+}
+
+module_init(cy7c63_init);
+module_exit(cy7c63_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+
+MODULE_LICENSE("GPL");
