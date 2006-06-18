Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWFRPwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWFRPwb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWFRPwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:52:31 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:2496 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751204AbWFRPwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:52:30 -0400
From: Oliver Bock <o.bock@fh-wolfenbuettel.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] usb: new driver for Cypress CY7C63xxx mirco controllers
Date: Sun, 18 Jun 2006 17:52:26 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
References: <200606100042.19441.o.bock@fh-wolfenbuettel.de> <20060613192304.GG27312@elf.ucw.cz> <20060613211604.GB26851@kroah.com>
In-Reply-To: <20060613211604.GB26851@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606181752.27139.o.bock@fh-wolfenbuettel.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:dd33dd6c1d5f49fc970db4042b12446b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Bock <o.bock@fh-wolfenbuettel.de>

This is a new driver for the Cypress CY7C63xxx mirco controller series. It 
currently supports the pre-programmed CYC63001A-PC by AK Modul-Bus GmbH.
It's based on a kernel 2.4 driver (cyport) by Marcus Maul which I ported to
kernel 2.6 using sysfs. I intend to support more controllers of this family
(and more features) as soon as I get hold of the required IDs etc. Please see
the source code's header for more information.

Signed-off-by: Oliver Bock <o.bock@fh-wolfenbuettel.de>

---

Please CC me as I'm not yet subscribed to LKML. Any comments are welcome.
Special thanks to Greg K-H and Pavel Machek for their helpful support!

I polished the formatting and indentation (source looks perfectly fine although the
patch shows too few spaces in wrapped function headers) and also redesigned
the code using the usual approach instead of a marco. The module name
changed also to look not too cryptic. I considered naming it cypress_akmodbus
but that name would limit future extensions of the driver, thus I dropped that
idea again. In my opinion this is the final patch of this initial version.

diff against 2.6.17 as there's no prepatch version yet.


--- linux-2.6.17/drivers/usb/Makefile.orig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.17/drivers/usb/Makefile	2006-06-18 17:17:43.292942750 +0200
@@ -48,6 +48,7 @@ obj-$(CONFIG_USB_MICROTEK)	+= image/
 obj-$(CONFIG_USB_SERIAL)	+= serial/
 
 obj-$(CONFIG_USB_AUERSWALD)	+= misc/
+obj-$(CONFIG_USB_CYPRESS_CY7C63)+= misc/
 obj-$(CONFIG_USB_CYTHERM)	+= misc/
 obj-$(CONFIG_USB_EMI26)		+= misc/
 obj-$(CONFIG_USB_EMI62)		+= misc/
--- linux-2.6.17/drivers/usb/misc/Kconfig.orig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.17/drivers/usb/misc/Kconfig	2006-06-18 17:15:09.475329750 +0200
@@ -88,6 +88,20 @@ config USB_LED
 	  To compile this driver as a module, choose M here: the
 	  module will be called usbled.
 
+config USB_CYPRESS_CY7C63
+	tristate "Cypress CY7C63xxx USB driver support"
+	depends on USB
+	help
+	  Say Y here if you want to connect a Cypress CY7C63xxx
+	  micro controller to your computer's USB port. Currently this
+	  driver supports the pre-programmed devices (incl. firmware)
+	  by AK Modul-Bus Computer GmbH.
+
+	  Please see: http://www.ak-modul-bus.de/stat/mikrocontroller.html
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cypress_cy7c63.
+
 config USB_CYTHERM
 	tristate "Cypress USB thermometer driver support"
 	depends on USB
--- linux-2.6.17/drivers/usb/misc/Makefile.orig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.17/drivers/usb/misc/Makefile	2006-06-18 17:16:49.833601750 +0200
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_USB_AUERSWALD)	+= auerswald.o
+obj-$(CONFIG_USB_CYPRESS_CY7C63)+= cypress_cy7c63.o
 obj-$(CONFIG_USB_CYTHERM)	+= cytherm.o
 obj-$(CONFIG_USB_EMI26)		+= emi26.o
 obj-$(CONFIG_USB_EMI62)		+= emi62.o
--- linux-2.6.17/drivers/usb/misc/cypress_cy7c63.c.orig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17/drivers/usb/misc/cypress_cy7c63.c	2006-06-18 14:47:33.000000000 +0200
@@ -0,0 +1,279 @@
+/*
+* cypress_cy7c63.c
+*
+* Copyright (c) 2006 Oliver Bock (o.bock@fh-wolfenbuettel.de)
+*
+*	This driver is based on the Cypress USB Driver by Marcus Maul
+*	(cyport) and the 2.0 version of Greg Kroah-Hartman's
+*	USB Skeleton driver.
+*
+*	This is a generic driver for the Cypress CY7C63xxx family.
+*	For the time being it enables you to read from and write to
+*	the single I/O ports of the device.
+*
+*	Supported vendors:	AK Modul-Bus Computer GmbH
+*	Supported devices:	CY7C63001A-PC (to be continued...)
+*	Supported functions:	Read/Write Ports (to be continued...)
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
+#define DRIVER_AUTHOR		"Oliver Bock (o.bock@fh-wolfenbuettel.de)"
+#define DRIVER_DESC		"Cypress CY7C63xxx USB driver"
+
+#define CYPRESS_VENDOR_ID	0xa2c
+#define CYPRESS_PRODUCT_ID	0x8
+
+#define CYPRESS_READ_PORT	0x4
+#define CYPRESS_WRITE_PORT	0x5
+
+#define CYPRESS_READ_RAM	0x2
+#define CYPRESS_WRITE_RAM	0x3
+#define CYPRESS_READ_ROM	0x1
+
+#define CYPRESS_READ_PORT_ID0	0
+#define CYPRESS_WRITE_PORT_ID0	0
+#define CYPRESS_READ_PORT_ID1	0x2
+#define CYPRESS_WRITE_PORT_ID1	1
+
+#define CYPRESS_MAX_REQSIZE	8
+
+
+/* table of devices that work with this driver */
+static struct usb_device_id cypress_table [] = {
+	{ USB_DEVICE(CYPRESS_VENDOR_ID, CYPRESS_PRODUCT_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, cypress_table);
+
+/* structure to hold all of our device specific stuff */
+struct cypress {
+	struct usb_device *	udev;
+	unsigned char		port[2];
+};
+
+/* used to send usb control messages to device */
+int vendor_command(struct cypress *dev, unsigned char request,
+		   unsigned char address, unsigned char data)
+{
+	int retval = 0;
+	unsigned int pipe;
+	unsigned char *iobuf;
+
+	/* allocate some memory for the i/o buffer*/
+	iobuf = kzalloc(CYPRESS_MAX_REQSIZE, GFP_KERNEL);
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
+				 USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+				 address, data, iobuf, CYPRESS_MAX_REQSIZE,
+				 USB_CTRL_GET_TIMEOUT);
+
+	/* store returned data (more READs to be added) */
+	switch (request) {
+		case CYPRESS_READ_PORT:
+			if (address == CYPRESS_READ_PORT_ID0) {
+				dev->port[0] = iobuf[1];
+				dev_dbg(&dev->udev->dev,
+					"READ_PORT0 returned: %d\n",
+					dev->port[0]);
+			}
+			else if (address == CYPRESS_READ_PORT_ID1) {
+				dev->port[1] = iobuf[1];
+				dev_dbg(&dev->udev->dev,
+					"READ_PORT1 returned: %d\n",
+					dev->port[1]);
+			}
+			break;
+	}
+
+	kfree(iobuf);
+error:
+	return retval;
+}
+
+/* write port value */
+static ssize_t write_port(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count,
+			  int port_num, int write_id)
+{
+	int value = -1;
+	int result = 0;
+
+	struct usb_interface *intf = to_usb_interface(dev);
+	struct cypress *cyp = usb_get_intfdata(intf);
+
+	dev_dbg(&cyp->udev->dev, "WRITE_PORT%d called\n", port_num);
+
+	/* validate input data */
+	if (sscanf(buf, "%d", &value) < 1) {
+		result = -EINVAL;
+		goto error;
+	}
+	if (value < 0 || value > 255) {
+		result = -EINVAL;
+		goto error;
+	}
+
+	result = vendor_command(cyp, CYPRESS_WRITE_PORT, write_id,
+				(unsigned char)value);
+
+	dev_dbg(&cyp->udev->dev, "Result of vendor_command: %d\n\n", result);
+error:
+	return result < 0 ? result : count;
+}
+
+/* attribute callback handler (write) */
+static ssize_t set_port0_handler(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	return write_port(dev, attr, buf, count, 0, CYPRESS_WRITE_PORT_ID0);
+}
+
+/* attribute callback handler (write) */
+static ssize_t set_port1_handler(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	return write_port(dev, attr, buf, count, 1, CYPRESS_WRITE_PORT_ID1);
+}
+
+/* read port value */
+static ssize_t read_port(struct device *dev, struct device_attribute *attr,
+			 char *buf, int port_num, int read_id)
+{
+	int result = 0;
+
+	struct usb_interface *intf = to_usb_interface(dev);
+	struct cypress *cyp = usb_get_intfdata(intf);
+
+	dev_dbg(&cyp->udev->dev, "READ_PORT%d called\n", port_num);
+
+	result = vendor_command(cyp, CYPRESS_READ_PORT, read_id, 0);
+
+	dev_dbg(&cyp->udev->dev, "Result of vendor_command: %d\n\n", result);
+
+	return sprintf(buf, "%d", cyp->port[port_num]);
+}
+
+/* attribute callback handler (read) */
+static ssize_t get_port0_handler(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	return read_port(dev, attr, buf, 0, CYPRESS_READ_PORT_ID0);
+}
+
+/* attribute callback handler (read) */
+static ssize_t get_port1_handler(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	return read_port(dev, attr, buf, 1, CYPRESS_READ_PORT_ID1);
+}
+
+static DEVICE_ATTR(port0, S_IWUGO | S_IRUGO,
+		   get_port0_handler, set_port0_handler);
+
+static DEVICE_ATTR(port1, S_IWUGO | S_IRUGO,
+		   get_port1_handler, set_port1_handler);
+
+
+static int cypress_probe(struct usb_interface *interface,
+			 const struct usb_device_id *id)
+{
+	struct cypress *dev = NULL;
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
+	/* let the user know that the device is now attached */
+	dev_info(&interface->dev,
+		 "Cypress CY7C63xxx device now attached\n");
+
+	retval = 0;
+error:
+	return retval;
+}
+
+static void cypress_disconnect(struct usb_interface *interface)
+{
+	struct cypress *dev;
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
+		 "Cypress CY7C63xxx device now disconnected\n");
+
+	kfree(dev);
+}
+
+static struct usb_driver cypress_driver = {
+	.name = "cypress_cy7c63",
+	.probe = cypress_probe,
+	.disconnect = cypress_disconnect,
+	.id_table = cypress_table,
+};
+
+static int __init cypress_init(void)
+{
+	int result;
+
+	/* register this driver with the USB subsystem */
+	result = usb_register(&cypress_driver);
+	if (result) {
+		err("Function usb_register failed! Error number: %d\n", result);
+	}
+
+	return result;
+}
+
+static void __exit cypress_exit(void)
+{
+	/* deregister this driver with the USB subsystem */
+	usb_deregister(&cypress_driver);
+}
+
+module_init(cypress_init);
+module_exit(cypress_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+
+MODULE_LICENSE("GPL");


