Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751693AbWCIJZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbWCIJZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 04:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbWCIJZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 04:25:27 -0500
Received: from [206.222.18.114] ([206.222.18.114]:24451 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751657AbWCIJZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 04:25:26 -0500
Date: Thu, 9 Mar 2006 17:25:23 +0800
Message-ID: <29732654.1141896323823.JavaMail.websites@opensubscriber>
From: lanslott.gish@gmail.com
Reply-To: lanslott.gish@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] add support for TouchSet USB Touchscreen Device
In-Reply-To: <200603082346.37479.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

repost the patch.

thx for all.


Lanslot Gish


=====================================================================
diff -u -N linux-2.6.16-rc5/drivers/usb/input/hid-core.c linux-2.6.16-rc5.modi/drivers/usb/input/hid-core.c
--- linux-2.6.16-rc5/drivers/usb/input/hid-core.c	2006-02-27 13:09:35.000000000 +0800
+++ linux-2.6.16-rc5.modi/drivers/usb/input/hid-core.c	2006-03-02 10:20:36.000000000 +0800
@@ -1459,6 +1459,9 @@
 #define USB_VENDOR_ID_HP		0x03f0
 #define USB_DEVICE_ID_HP_USBHUB_KB	0x020c
 
+#define USB_VENDOR_ID_TOUCHSET	0x134c
+#define USB_DEVICE_ID_TOUCHSET	0x0001
+
 /*
  * Alphabetically sorted blacklist by quirk type.
  */
@@ -1603,6 +1609,11 @@
 	{ USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },
 
+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET + 1, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET + 2, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET + 3, HID_QUIRK_IGNORE },
+
 	{ 0, 0 }
 };
 
diff -u -N linux-2.6.16-rc5/drivers/usb/input/Kconfig linux-2.6.16-rc5.modi/drivers/usb/input/Kconfig
--- linux-2.6.16-rc5/drivers/usb/input/Kconfig	2006-02-27 13:09:35.000000000 +0800
+++ linux-2.6.16-rc5.modi/drivers/usb/input/Kconfig	2006-03-08 10:28:33.686019096 +0800
@@ -330,3 +330,16 @@
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called appletouch.
+
+config USB_TOUCHSET
+	tristate "TouchSet USB Device Driver"
+	depends on USB && INPUT
+	---help---
+	  Say Y here if you want to use a TouchSet USB
+	  Touchscreen controller.
+
+	  Have a look at <http://linux.chapter7.ch/touchkit/> for
+	  a usage description and the required user-space stuff.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called usbtouchset.
diff -u -N linux-2.6.16-rc5/drivers/usb/input/Makefile linux-2.6.16-rc5.modi/drivers/usb/input/Makefile
--- linux-2.6.16-rc5/drivers/usb/input/Makefile	2006-02-27 13:09:35.000000000 +0800
+++ linux-2.6.16-rc5.modi/drivers/usb/input/Makefile	2006-03-08 10:27:29.188824160 +0800
@@ -43,6 +43,7 @@
 obj-$(CONFIG_USB_YEALINK)	+= yealink.o
 obj-$(CONFIG_USB_XPAD)		+= xpad.o
 obj-$(CONFIG_USB_APPLETOUCH)	+= appletouch.o
+obj-$(CONFIG_USB_TOUCHSET)	+= usbtouchset.o
 
 ifeq ($(CONFIG_USB_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -u -N linux-2.6.16-rc5/drivers/usb/input/usbtouchset.c linux-2.6.16-rc5.modi/drivers/usb/input/usbtouchset.c
--- linux-2.6.16-rc5/drivers/usb/input/usbtouchset.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.16-rc5.modi/drivers/usb/input/usbtouchset.c	2006-03-07 11:43:18.000000000 +0800
@@ -0,0 +1,303 @@
+/******************************************************************************
+ * usbtouchset.c  --  Driver for TouchSet USB Device
+ *
+ * Copyright (C) 2004 by Daniel Ritz
+ * Copyright (C) 2006 by Lanslott Gish
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
+ * Based upon mtouchusb.c
+ *
+ *****************************************************************************/
+
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
+#define DRIVER_VERSION			"0.2"
+#define DRIVER_AUTHOR			"Lanslott Gish <lanslott.gish@gmail.com>"
+#define DRIVER_DESC			"TouchSet USB Device"
+
+static int swap_xy;
+module_param(swap_xy, bool, 0644);
+MODULE_PARM_DESC(swap_xy, "Swap X and Y axes.");
+
+
+struct usb_touchset {
+	unsigned char *data;
+	dma_addr_t data_dma;
+	struct urb *irq;
+	struct usb_device *udev;
+	struct input_dev *input;
+	char name[128];
+	char phys[64];
+};
+
+static struct usb_device_id usbtouchset_devices[] = {
+	{USB_DEVICE(0x134c, 0x0001)},
+	{USB_DEVICE(0x134c, 0x0002)},
+	{USB_DEVICE(0x134c, 0x0003)},
+	{USB_DEVICE(0x134c, 0x0004)},
+	{}
+};
+
+static inline int usbtouchset_get_touched(char *data)
+{
+	return ((((data)[0]) & TOUCHSET_DOWN) ? 1 : 0);
+}
+
+static inline int usbtouchset_get_x(char *data)
+{
+	return ((data)[1] | ((data)[2] << 8));
+}
+
+static inline int usbtouchset_get_y(char *data)
+{
+	return ((data)[3] | ((data)[4] << 8));
+}
+
+static void usbtouchset_irq(struct urb *urb, struct pt_regs *regs)
+{
+	struct usb_touchset *touchset = urb->context;
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
+		y = usbtouchset_get_x(touchset->data);
+		x = usbtouchset_get_y(touchset->data);
+	} else {
+		x = usbtouchset_get_x(touchset->data);
+		y = usbtouchset_get_y(touchset->data);
+	}
+
+	input_regs(touchset->input, regs);
+	input_report_key(touchset->input, BTN_TOUCH,
+	                 usbtouchset_get_touched(touchset->data));
+	input_report_abs(touchset->input, ABS_X, x);
+	input_report_abs(touchset->input, ABS_Y, y);
+	input_sync(touchset->input);
+
+exit:
+	retval = usb_submit_urb(urb, GFP_ATOMIC);
+	if (retval)
+		err("%s - usb_submit_urb failed with result: %d",
+		    __FUNCTION__, retval);
+}
+
+static int usbtouchset_open(struct input_dev *input)
+{
+	struct usb_touchset *touchset = input->private;
+
+	touchset->irq->dev = touchset->udev;
+
+	if (usb_submit_urb(touchset->irq, GFP_KERNEL))
+		return -EIO;
+
+	return 0;
+}
+
+static void usbtouchset_close(struct input_dev *input)
+{
+	struct usb_touchset *touchset = input->private;
+
+	usb_kill_urb(touchset->irq);
+}
+
+static int usbtouchset_alloc_buffers(struct usb_device *udev,
+				  struct usb_touchset *touchset)
+{
+	touchset->data = usb_buffer_alloc(udev, TOUCHSET_REPORT_DATA_SIZE,
+	                                  SLAB_KERNEL, &touchset->data_dma);
+
+	if (!touchset->data)
+		return -1;
+
+	return 0;
+}
+
+static void usbtouchset_free_buffers(struct usb_device *udev,
+				  struct usb_touchset *touchset)
+{
+	if (touchset->data)
+		usb_buffer_free(udev, TOUCHSET_REPORT_DATA_SIZE,
+		                touchset->data, touchset->data_dma);
+}
+
+static int usbtouchset_probe(struct usb_interface *intf,
+			  const struct usb_device_id *id)
+{
+	struct usb_touchset *touchset;
+	struct input_dev *input_dev;
+	struct usb_host_interface *interface;
+	struct usb_endpoint_descriptor *endpoint;
+	struct usb_device *udev = interface_to_usbdev(intf);
+
+	interface = intf->cur_altsetting;
+	endpoint = &interface->endpoint[0].desc;
+
+	touchset = kzalloc(sizeof(struct usb_touchset), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!touchset || !input_dev)
+		goto out_free;
+
+	if (usbtouchset_alloc_buffers(udev, touchset))
+		goto out_free;
+
+	touchset->irq = usb_alloc_urb(0, GFP_KERNEL);
+	if (!touchset->irq) {
+		dbg("%s - usb_alloc_urb failed: touchset->irq", __FUNCTION__);
+		goto out_free_buffers;
+	}
+
+	touchset->udev = udev;
+	touchset->input = input_dev;
+
+	if (udev->manufacturer)
+		strlcpy(touchset->name, udev->manufacturer, sizeof(touchset->name));
+
+	if (udev->product) {
+		if (udev->manufacturer)
+			strlcat(touchset->name, " ", sizeof(touchset->name));
+		strlcat(touchset->name, udev->product, sizeof(touchset->name));
+	}
+
+	if (!strlen(touchset->name))
+		snprintf(touchset->name, sizeof(touchset->name),
+			"USB Device %04x:%04x",
+			 le16_to_cpu(udev->descriptor.idVendor),
+			 le16_to_cpu(udev->descriptor.idProduct));
+
+	usb_make_path(udev, touchset->phys, sizeof(touchset->phys));
+	strlcpy(touchset->phys, "/input0", sizeof(touchset->phys));
+
+	input_dev->name = touchset->name;
+	input_dev->phys = touchset->phys;
+	usb_to_input_id(udev, &input_dev->id);
+	input_dev->cdev.dev = &intf->dev;
+	input_dev->private = touchset;
+	input_dev->open = usbtouchset_open;
+	input_dev->close = usbtouchset_close;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_set_abs_params(input_dev, ABS_X, TOUCHSET_MIN_XC, TOUCHSET_MAX_XC,
+				TOUCHSET_XC_FUZZ, TOUCHSET_XC_FLAT);
+	input_set_abs_params(input_dev, ABS_Y, TOUCHSET_MIN_YC, TOUCHSET_MAX_YC,
+				TOUCHSET_YC_FUZZ, TOUCHSET_YC_FLAT);
+
+	usb_fill_int_urb(touchset->irq, touchset->udev,
+			 usb_rcvintpipe(touchset->udev, 0x81),
+			 touchset->data, TOUCHSET_REPORT_DATA_SIZE,
+			 usbtouchset_irq, touchset, endpoint->bInterval);
+
+	input_register_device(touchset->input);
+
+	usb_set_intfdata(intf, touchset);
+	return 0;
+
+out_free_buffers:
+	usbtouchset_free_buffers(udev, touchset);
+out_free:
+	input_free_device(input_dev);
+	kfree(touchset);
+	return -ENOMEM;
+}
+
+static void usbtouchset_disconnect(struct usb_interface *intf)
+{
+	struct usb_touchset *touchset = usb_get_intfdata(intf);
+
+	dbg("%s - called", __FUNCTION__);
+
+	if (!touchset)
+		return;
+
+	dbg("%s - touchset is initialized, cleaning up", __FUNCTION__);
+	usb_set_intfdata(intf, NULL);
+	usb_kill_urb(touchset->irq);
+	input_unregister_device(touchset->input);
+	usb_free_urb(touchset->irq);
+	usbtouchset_free_buffers(interface_to_usbdev(intf), touchset);
+	kfree(touchset);
+}
+
+MODULE_DEVICE_TABLE(usb, usbtouchset_devices);
+
+static struct usb_driver usbtouchset_driver = {
+	.name		= "usbtouchset",
+	.probe		= usbtouchset_probe,
+	.disconnect	= usbtouchset_disconnect,
+	.id_table	= usbtouchset_devices,
+};
+
+static int __init usbtouchset_init(void)
+{
+	return usb_register(&usbtouchset_driver);
+}
+
+static void __exit usbtouchset_cleanup(void)
+{
+	usb_deregister(&usbtouchset_driver);
+}
+
+module_init(usbtouchset_init);
+module_exit(usbtouchset_cleanup);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");

=====================================================================

--
This message was sent on behalf of lanslott.gish@gmail.com at openSubscriber.com
http://www.opensubscriber.com/message/linux-kernel@vger.kernel.org/3535239.html
