Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWCJJYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWCJJYt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 04:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbWCJJYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 04:24:49 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:59609 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751123AbWCJJYs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 04:24:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WH9CEUnF13uKsh0A9Gns9q0roHy8szAINxHH+mMIOnlDUHQbSihx8FX6Sv+jWqj5R2vX09aDxa1/YJ9B/1Su4SS+mJEfRZLRJ7wDWQkFfIhAQngCttZ0Cwj4Ch4UTEVrHCVBCNknw9Jyfe81aGISeK4EpQpsngGfVBegxT5wAak=
Message-ID: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com>
Date: Fri, 10 Mar 2006 17:24:47 +0800
From: "Lanslott Gish" <lanslott.gish@gmail.com>
To: "Greg KH" <greg@kroah.com>, "Daniel Ritz" <daniel.ritz@gmx.ch>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: [PATCH] Try to add support for universal USB touchscreen device, and WISH for help~
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>,
       "Daniel Ritz" <daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

i try to arrange some codes, and named "usbtouchdev",
wish to help merging all USB touchscreen devices like
mtouchusb.c, itmtouch.c, touchkitusb.c, usbtouchset.c, etc.

in this moment, only add my touchscreen driver here and test pass.
if anyone wanna add another USB touchscreen driver, or wanna modify the codes,
or any help i can do, please feel free to tell me.

wish help some.

======
--- linux-2.6.16-rc5.org/drivers/usb/input/hid-core.c	2006-02-27
+++ linux-2.6.16-rc5/drivers/usb/input/hid-core.c	2006-03-10
@@ -1459,6 +1459,9 @@
 #define USB_VENDOR_ID_HP		0x03f0
 #define USB_DEVICE_ID_HP_USBHUB_KB	0x020c

+#define USB_VENDOR_ID_TOUCHSET	0x134c
+#define USB_DEVICE_ID_TOUCHSET	0x0001
+
 /*
  * Alphabetically sorted blacklist by quirk type.
  */
@@ -1602,6 +1605,15 @@
 	{ USB_VENDOR_ID_APPLE, 0x0216, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },
+
+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET,
+		HID_QUIRK_IGNORE},
+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET + 1,
+		HID_QUIRK_IGNORE},
+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET + 2,
+		HID_QUIRK_IGNORE},
+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET + 3,
+		HID_QUIRK_IGNORE},

 	{ 0, 0 }
 };
--- linux-2.6.16-rc5.org/drivers/usb/input/Kconfig	2006-02-27
+++ linux-2.6.16-rc5/drivers/usb/input/Kconfig	2006-03-10
@@ -330,3 +330,15 @@

 	  To compile this driver as a module, choose M here: the
 	  module will be called appletouch.
+
+config USB_TOUCHDEV
+	tristate "Touchscreen General USB Device"
+	depends on USB && INPUT
+	---help---
+	  Say Y here if you want to use a USB Touchscreen controller.
+
+	  Have a look at <http://linux.chapter7.ch/touchkit/> for
+	  a usage description and the required user-space stuff.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called usbtouchset.
--- linux-2.6.16-rc5.org/drivers/usb/input/Makefile	2006-02-27
+++ linux-2.6.16-rc5/drivers/usb/input/Makefile	2006-03-10
@@ -43,6 +43,7 @@
 obj-$(CONFIG_USB_YEALINK)	+= yealink.o
 obj-$(CONFIG_USB_XPAD)		+= xpad.o
 obj-$(CONFIG_USB_APPLETOUCH)	+= appletouch.o
++obj-$(CONFIG_USB_TOUCHDEV)	+= usbtouchdev.o

 ifeq ($(CONFIG_USB_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
--- linux-2.6.16-rc5.org/drivers/usb/input/usbtouchdev.c	1970-01-01
+++ linux-2.6.16-rc5/drivers/usb/input/usbtouchdev.c	2006-03-10
@@ -0,0 +1,280 @@
+/******************************************************************************
+ * usbtouchdev.c  --  Driver for TouchScreen USB Device
+ *
+ * Copyright (C) 2004-2005 by Daniel Ritz <daniel.ritz@gmx.ch>
+ * Copyright (C) by Todd E. Johnson (mtouchusb.c)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Try to united general USB touchscreen devices.
+ *
+ * -- 2006/3/10 --
+ *
+ * Changlog:
+ * v0.1 2006/3/10 Lanslott Gish
+ * Initial release based on mtouchusb.c & touchkitusb.c (Thx Todd & Daniel!)
+ *
+ * ToDo:
+ * * Merge USB touchscreen devices(mtouchusb.c,
+ *   touchkitusb.c, itmtouch.c, etc.) if possible.
+ * * Functions to swap raw data for axies(X,Y,Z,...)
+ * * Access I/O devices with file operators.
+ * * ask for any idea :)
+ *
+ * NOTE:
+ * 	This kernel driver is required X.org/XFree86 input driver
+ * 	for your X server, as well as refer to "Evtouch",
+ * 	Touchscreen-Driver for X.
+ *
+ *****************************************************************************/
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/usb.h>
+#include <linux/usb_input.h>
+
+#include "usbtouchdev.c"
+
+#define DRIVER_VERSION "0.1"
+#define DRIVER_AUTHOR "Lanslott Gish <lanslott.gish@gmail.com>"
+#define DRIVER_DESC "Touchscreen General USB Device"
+#define DRIVER_LICENSE "GPL"
+
+static int swap_xy;
+module_param(swap_xy, bool, 0644);
+MODULE_PARM_DESC(swap_xy, "Swap X and Y axes.");
+
+static void usbtouchdev_irq(struct urb *urb, struct pt_regs *regs)
+{
+	struct usb_touchdev *usbtouchdev = urb->context;
+	int retval;
+	int x, y;
+
+	switch (urb->status) {
+	case 0:
+		/* success */
+		break;
+	case -ETIMEDOUT:
+		/* this urb is timing out */
+		dbg("%s - urb timed out - was the device unplugged?",
+		    __FUNCTION__);
+		return;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/* this urb is terminated, clean up */
+		dbg("%s - urb shutting down with status: %d",
+		    __FUNCTION__, urb->status);
+		return;
+	default:
+		dbg("%s - nonzero urb status received: %d",
+		    __FUNCTION__, urb->status);
+		goto exit;
+	}
+
+	if (swap_xy) {
+		y = touchset_get_x(usbtouchdev->data);
+		x = touchset_get_y(usbtouchdev->data);
+	} else {
+		x = touchset_get_x(usbtouchdev->data);
+		y = touchset_get_y(usbtouchdev->data);
+	}
+
+	input_regs(usbtouchdev->input, regs);
+	input_report_key(usbtouchdev->input, BTN_TOUCH,
+		usbtouchdev_get_touched(usbtouchdev->data));
+	input_report_abs(usbtouchdev->input, ABS_X, x);
+	input_report_abs(usbtouchdev->input, ABS_Y, y);
+	input_sync(usbtouchdev->input);
+
+exit:
+	retval = usb_submit_urb(urb, GFP_ATOMIC);
+	if (retval)
+		err("%s - usb_submit_urb failed with result: %d",
+		    __FUNCTION__, retval);
+}
+
+static int usbtouchdev_open(struct input_dev *input)
+{
+	struct usb_touchdev *usbtouchdev = input->private;
+
+	usbtouchdev->irq->dev = usbtouchdev->udev;
+
+	if (usb_submit_urb(usbtouchdev->irq, GFP_KERNEL))
+		return -EIO;
+
+	return 0;
+}
+
+static void usbtouchdev_close(struct input_dev *input)
+{
+	struct usb_touchdev *usbtouchdev = input->private;
+
+	usb_kill_urb(usbtouchdev->irq);
+}
+
+static int usbtouchdev_alloc_buffers(struct usb_device *udev,
+				  struct usb_touchdev *usbtouchdev)
+{
+	usbtouchdev->data = usb_buffer_alloc(udev,
+				TOUCHSET_REPORT_DATA_SIZE, SLAB_KERNEL,
+				&usbtouchdev->data_dma);
+
+	if (!usbtouchdev->data)
+		return -1;
+
+	return 0;
+}
+
+static void usbtouchdev_free_buffers(struct usb_device *udev,
+				  struct usb_touchdev *usbtouchdev)
+{
+	if (usbtouchdev->data)
+		usb_buffer_free(udev,
+				TOUCHSET_REPORT_DATA_SIZE,
+		                usbtouchdev->data, usbtouchdev->data_dma);
+}
+
+static int usbtouchdev_probe(struct usb_interface *intf,
+			  const struct usb_device_id *id)
+{
+	struct usb_touchdev *usbtouchdev;
+	struct input_dev *input_dev;
+	struct usb_host_interface *interface;
+	struct usb_endpoint_descriptor *endpoint;
+	struct usb_device *udev = interface_to_usbdev(intf);
+
+	interface = intf->cur_altsetting;
+	endpoint = &interface->endpoint[0].desc;
+
+	usbtouchdev = kzalloc(sizeof(struct usb_touchdev), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!usbtouchdev || !input_dev)
+		goto out_free;
+
+	if (usbtouchdev_alloc_buffers(udev, usbtouchdev))
+		goto out_free;
+
+	usbtouchdev->irq = usb_alloc_urb(0, GFP_KERNEL);
+	if (!usbtouchdev->irq) {
+		dbg("%s - usb_alloc_urb failed: usbtouchdev->irq",
+				__FUNCTION__);
+		goto out_free_buffers;
+	}
+
+	usbtouchdev->udev = udev;
+	usbtouchdev->input = input_dev;
+
+	if (udev->manufacturer)
+		strlcpy(usbtouchdev->name, udev->manufacturer,
+		sizeof(usbtouchdev->name));
+
+	if (udev->product) {
+		if (udev->manufacturer)
+		strlcat(usbtouchdev->name, " ",
+			sizeof(usbtouchdev->name));
+				strlcat(usbtouchdev->name, udev->product,
+					sizeof(usbtouchdev->name));
+	}
+
+	if (!strlen(usbtouchdev->name))
+		snprintf(usbtouchdev->name, sizeof(usbtouchdev->name),
+			"USB Device %04x:%04x",
+			 le16_to_cpu(udev->descriptor.idVendor),
+			 le16_to_cpu(udev->descriptor.idProduct));
+
+	usb_make_path(udev, usbtouchdev->phys, sizeof(usbtouchdev->phys));
+	strlcpy(usbtouchdev->phys, "/input0", sizeof(usbtouchdev->phys));
+
+	input_dev->name = usbtouchdev->name;
+	input_dev->phys = usbtouchdev->phys;
+	usb_to_input_id(udev, &input_dev->id);
+	input_dev->cdev.dev = &intf->dev;
+	input_dev->private = usbtouchdev;
+	input_dev->open = usbtouchdev_open;
+	input_dev->close = usbtouchdev_close;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_set_abs_params(input_dev, ABS_X, TOUCHSET_MIN_XC,
+		TOUCHSET_MAX_XC, TOUCHSET_XC_FUZZ, TOUCHSET_XC_FLAT);
+	input_set_abs_params(input_dev, ABS_Y, TOUCHSET_MIN_YC,
+		TOUCHSET_MAX_YC, TOUCHSET_YC_FUZZ, TOUCHSET_YC_FLAT);
+
+	usb_fill_int_urb(usbtouchdev->irq, usbtouchdev->udev,
+			 usb_rcvintpipe(usbtouchdev->udev, 0x81),
+			 usbtouchdev->data, TOUCHSET_REPORT_DATA_SIZE,
+			 usbtouchdev_irq, usbtouchdev, endpoint->bInterval);
+
+	input_register_device(usbtouchdev->input);
+
+	usb_set_intfdata(intf, usbtouchdev);
+	return 0;
+
+out_free_buffers:
+	usbtouchdev_free_buffers(udev, usbtouchdev);
+out_free:
+	input_free_device(input_dev);
+	kfree(usbtouchdev);
+	return -ENOMEM;
+}
+
+static void usbtouchdev_disconnect(struct usb_interface *intf)
+{
+	struct usb_touchdev *usbtouchdev = usb_get_intfdata(intf);
+
+	dbg("%s - called", __FUNCTION__);
+
+	if (!usbtouchdev)
+		return;
+
+	dbg("%s - usbtouchdev is initialized, cleaning up", __FUNCTION__);
+	usb_set_intfdata(intf, NULL);
+	usb_kill_urb(usbtouchdev->irq);
+	input_unregister_device(usbtouchdev->input);
+	usb_free_urb(usbtouchdev->irq);
+	usbtouchdev_free_buffers(interface_to_usbdev(intf), usbtouchdev);
+	kfree(usbtouchdev);
+}
+
+MODULE_DEVICE_TABLE(usb, usbtouchdev_devices);
+
+static struct usb_driver usbtouchdev_driver = {
+	.name		= "usbtouchdev",
+	.probe		= usbtouchdev_probe,
+	.disconnect	= usbtouchdev_disconnect,
+	.id_table	= usbtouchdev_devices,
+};
+
+static int __init usbtouchdev_init(void)
+{
+	return usb_register(&usbtouchdev_driver);
+}
+
+static void __exit usbtouchdev_cleanup(void)
+{
+	usb_deregister(&usbtouchdev_driver);
+}
+
+module_init(usbtouchdev_init);
+module_exit(usbtouchdev_cleanup);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
--- linux-2.6.16-rc5.org/drivers/usb/input/usbtouchdev.h	1970-01-01
+++ linux-2.6.16-rc5/drivers/usb/input/usbtouchdev.h	2006-03-10
@@ -0,0 +1,100 @@
+/******************************************************************************
+ * usbtouchdev.h  --  Driver for TouchScreen USB Device
+ *
+ * Copyright (C) 2004-2005 by Daniel Ritz <daniel.ritz@gmx.ch>
+ * Copyright (C) by Todd E. Johnson (mtouchusb.c)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * TouchScreen Universal USB Device Drivers.
+ *
+ *****************************************************************************/
+
+
+
+/***  Here for the touchscreen USB Device infomation  ***/
+
+/*TouchSet USB Touch Panel*/
+#define TOUCHSET_VENDOR_ID	0x134c
+#define TOUCHSET_PRODUCT_ID	0x0001
+
+/***  Here for the touchscreen data like axies or something  ***/
+
+
+/*TouchSet USB Touch Panel*/
+#define TOUCHSET_MIN_XC			0x0
+#define TOUCHSET_MAX_XC			0x0fff
+#define TOUCHSET_XC_FUZZ		0x0
+#define TOUCHSET_XC_FLAT		0x0
+#define TOUCHSET_MIN_YC			0x0
+#define TOUCHSET_MAX_YC			0x0fff
+#define TOUCHSET_YC_FUZZ		0x0
+#define TOUCHSET_YC_FLAT		0x0
+#define TOUCHSET_REPORT_DATA_SIZE	8
+
+#define TOUCHSET_DOWN			0x01
+#define TOUCHSET_POINT_TOUCH		0x81
+#define TOUCHSET_POINT_NOTOUCH		0x80
+
+/***  Structure for touchscreen devices  ***/
+
+/*TouchSet USB Touch Panel*/
+struct usb_touchdev {
+	unsigned char *data;
+	dma_addr_t data_dma;
+	struct urb *irq;
+	struct usb_device *udev;
+	struct input_dev *input;
+	char name[128];
+	char phys[64];
+};
+
+
+/***  Structure for touch device  ***/
+
+/*TouchSet USB Touch Panel*/
+static struct usb_device_id usbtouchdev_devices[] = {
+
+	/*TouchSet USB Device ID*/
+	{USB_DEVICE(TOUCHSET_VENDOR_ID, TOUCHSET_PRODUCT_ID)},
+	{USB_DEVICE(TOUCHSET_VENDOR_ID, TOUCHSET_PRODUCT_ID + 1)},
+	{USB_DEVICE(TOUCHSET_VENDOR_ID, TOUCHSET_PRODUCT_ID + 2)},
+	{USB_DEVICE(TOUCHSET_VENDOR_ID, TOUCHSET_PRODUCT_ID + 3)},
+
+	/*and something else...*/
+	{}
+};
+
+
+/***  Handle packets form touchscreen devices  ***/
+
+/*TouchSet USB Touch Panel*/
+static inline int touchset_get_touched(char *data)
+{
+	return ((((data)[0]) & TOUCHSET_DOWN) ? 1 : 0);
+}
+
+static inline int touchset_get_x(char *data)
+{
+	return ((data)[1] | ((data)[2] << 8));
+}
+
+static inline int touchset_get_y(char *data)
+{
+	return ((data)[3] | ((data)[4] << 8));
+}
+
+
+


======
--
L.G, Life's Good~
