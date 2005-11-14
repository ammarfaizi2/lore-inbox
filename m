Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVKNUUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVKNUUk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVKNUUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:20:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:11207 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932088AbVKNUTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:19:50 -0500
Date: Mon, 14 Nov 2005 12:06:18 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch 12/12] USB: add new anydata usb-serial driver
Message-ID: <20051114200618.GM2319@kroah.com>
References: <20051114200100.984523000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-serial-anydata.patch"
In-Reply-To: <20051114200456.GA2319@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

It's a "generic" device that needs a bigger transmit buffer to get
decent speeds.  The transmit buffer size is able to be changed by a
module paramater.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/serial/Kconfig   |    9 +++
 drivers/usb/serial/Makefile  |    1 
 drivers/usb/serial/anydata.c |  123 +++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/serial/generic.c |    1 
 4 files changed, 134 insertions(+)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ gregkh-2.6/drivers/usb/serial/anydata.c	2005-11-02 15:12:28.000000000 -0800
@@ -0,0 +1,123 @@
+/*
+ * AnyData CDMA Serial USB driver
+ *
+ * Copyright (C) 2005 Greg Kroah-Hartman <gregkh@suse.de>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License version
+ *	2 as published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/tty.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include "usb-serial.h"
+
+static struct usb_device_id id_table [] = {
+	{ USB_DEVICE(0x16d5, 0x6501) },	/* AirData CDMA device */
+	{ },
+};
+MODULE_DEVICE_TABLE(usb, id_table);
+
+/* if overridden by the user, then use their value for the size of the
+ * read and write urbs */
+static int buffer_size;
+static int debug;
+
+static struct usb_driver anydata_driver = {
+	.owner =	THIS_MODULE,
+	.name =		"anydata",
+	.probe =	usb_serial_probe,
+	.disconnect =	usb_serial_disconnect,
+	.id_table =	id_table,
+};
+
+static int anydata_open(struct usb_serial_port *port, struct file *filp)
+{
+	char *buffer;
+	int result = 0;
+
+	dbg("%s - port %d", __FUNCTION__, port->number);
+
+	if (buffer_size) {
+		/* override the default buffer sizes */
+		buffer = kmalloc(buffer_size, GFP_KERNEL);
+		if (!buffer) {
+			dev_err(&port->dev, "%s - out of memory.\n",
+				__FUNCTION__);
+			return -ENOMEM;
+		}
+		kfree (port->read_urb->transfer_buffer);
+		port->read_urb->transfer_buffer = buffer;
+		port->read_urb->transfer_buffer_length = buffer_size;
+
+		buffer = kmalloc(buffer_size, GFP_KERNEL);
+		if (!buffer) {
+			dev_err(&port->dev, "%s - out of memory.\n",
+				__FUNCTION__);
+			return -ENOMEM;
+		}
+		kfree (port->write_urb->transfer_buffer);
+		port->write_urb->transfer_buffer = buffer;
+		port->write_urb->transfer_buffer_length = buffer_size;
+		port->bulk_out_size = buffer_size;
+	}
+
+	/* Start reading from the device */
+	usb_fill_bulk_urb(port->read_urb, port->serial->dev,
+			  usb_rcvbulkpipe(port->serial->dev,
+				  	  port->bulk_in_endpointAddress),
+			  port->read_urb->transfer_buffer,
+			  port->read_urb->transfer_buffer_length,
+			  usb_serial_generic_write_bulk_callback, port);
+	result = usb_submit_urb(port->read_urb, GFP_KERNEL);
+	if (result)
+		dev_err(&port->dev,
+			"%s - failed submitting read urb, error %d\n",
+			__FUNCTION__, result);
+
+	return result;
+}
+
+static struct usb_serial_driver anydata_device = {
+	.driver = {
+		.owner =	THIS_MODULE,
+		.name =		"anydata",
+	},
+	.id_table =		id_table,
+	.num_interrupt_in =	NUM_DONT_CARE,
+	.num_bulk_in =		NUM_DONT_CARE,
+	.num_bulk_out =		NUM_DONT_CARE,
+	.num_ports =		1,
+	.open =			anydata_open,
+};
+
+static int __init anydata_init(void)
+{
+	int retval;
+
+	retval = usb_serial_register(&anydata_device);
+	if (retval)
+		return retval;
+	retval = usb_register(&anydata_driver);
+	if (retval)
+		usb_serial_deregister(&anydata_device);
+	return retval;
+}
+
+static void __exit anydata_exit(void)
+{
+	usb_deregister(&anydata_driver);
+	usb_serial_deregister(&anydata_device);
+}
+
+module_init(anydata_init);
+module_exit(anydata_exit);
+MODULE_LICENSE("GPL");
+
+module_param(debug, bool, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(debug, "Debug enabled or not");
+module_param(buffer_size, int, 0);
+MODULE_PARM_DESC(buffer_size, "Size of the transfer buffers");
--- gregkh-2.6.orig/drivers/usb/serial/Kconfig	2005-11-02 09:25:03.000000000 -0800
+++ gregkh-2.6/drivers/usb/serial/Kconfig	2005-11-02 15:04:05.000000000 -0800
@@ -62,6 +62,15 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called airprime.
 
+config USB_SERIAL_ANYDATA
+	tristate "USB AnyData CDMA Wireless Driver"
+	depends on USB_SERIAL
+	help
+	  Say Y here if you want to use a AnyData CDMA device.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called anydata.
+
 config USB_SERIAL_BELKIN
 	tristate "USB Belkin and Peracom Single Port Serial Driver"
 	depends on USB_SERIAL
--- gregkh-2.6.orig/drivers/usb/serial/Makefile	2005-11-02 09:25:03.000000000 -0800
+++ gregkh-2.6/drivers/usb/serial/Makefile	2005-11-02 15:03:22.000000000 -0800
@@ -12,6 +12,7 @@
 usbserial-objs	:= usb-serial.o generic.o bus.o $(usbserial-obj-y)
 
 obj-$(CONFIG_USB_SERIAL_AIRPRIME)		+= airprime.o
+obj-$(CONFIG_USB_SERIAL_ANYDATA)		+= anydata.o
 obj-$(CONFIG_USB_SERIAL_BELKIN)			+= belkin_sa.o
 obj-$(CONFIG_USB_SERIAL_CP2101)			+= cp2101.o
 obj-$(CONFIG_USB_SERIAL_CYBERJACK)		+= cyberjack.o
--- gregkh-2.6.orig/drivers/usb/serial/generic.c	2005-11-02 09:25:03.000000000 -0800
+++ gregkh-2.6/drivers/usb/serial/generic.c	2005-11-02 15:16:46.000000000 -0800
@@ -309,6 +309,7 @@
 
 	schedule_work(&port->work);
 }
+EXPORT_SYMBOL_GPL(usb_serial_generic_write_bulk_callback);
 
 void usb_serial_generic_shutdown (struct usb_serial *serial)
 {

--
