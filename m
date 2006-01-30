Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWA3NXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWA3NXG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 08:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWA3NXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 08:23:05 -0500
Received: from mx01.qsc.de ([213.148.129.14]:22730 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S932254AbWA3NXB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 08:23:01 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Adaptec USBXchange and USB2Xchange support
Date: Mon, 30 Jan 2006 14:22:40 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       "Louis C. Kouvaris" <louisk@comcast.net>,
       "wilford smith" <wilford_smith_2@hotmail.com>
References: <200509132253.53960.rene@exactcode.de> <20050914031827.69ad98e5.akpm@osdl.org>
In-Reply-To: <20050914031827.69ad98e5.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200601301422.40500.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi all, On Wednesday 14 September 2005 12:18, Andrew
	Morton wrote: > ..., then resend the patch, cc'ing >
	linux-usb-devel@lists.sourceforge.net, thanks. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Wednesday 14 September 2005 12:18, Andrew Morton wrote:

> ..., then resend the patch, cc'ing
> linux-usb-devel@lists.sourceforge.net, thanks.

please find attached the revisited patch for the Adaptec USBXchange and 
USB2Xchange USB<->SCSI cable.

Aside that the existing usb-storage code gives up scannign too early when 
there is just a device with a high SCSI ID (e.g. 5 or 6) conected to the 
USB2Xchange it works fine.

I'll try to come up with a solution for this high ID issue with the 
USB2Xchange when I have the next free time slot.

Extracted, firmware loader compatible firmware is here:

  http://dl.exactcode.de/adaptec-usbxchange/

diff -urN linux-2.6.15/drivers/usb/storage/Kconfig linux-2.6.15-usb2x/drivers/usb/storage/Kconfig
--- linux-2.6.15-mm4/drivers/usb/storage/Kconfig	2006-01-30 12:16:10.838447250 +0100
+++ linux-2.6.15-usb2x/drivers/usb/storage/Kconfig	2006-01-30 12:09:28.857325000 +0100
@@ -134,6 +134,13 @@
 	  this input in any keybinding software. (e.g. gnome's keyboard short-
 	  cuts)
 
+config USB_USBXCHANGE
+	tristate "Adaptec USBXchange and USB2Xchange firmware loader"
+	depends on USB_STORAGE_USBXCHANGE
+	help
+	  Say Y here to include additional code to load the firmware into the
+	  Adaptec USBXchange and USB2Xchange USB --> SCSI converter dongle.
+
 config USB_LIBUSUAL
 	bool "The shared table of common (or usual) storage devices"
 	depends on USB
diff -urN linux-2.6.15/drivers/usb/storage/Makefile linux-2.6.15-usb2x/drivers/usb/storage/Makefile
--- linux-2.6.15-mm4/drivers/usb/storage/Makefile	2006-01-30 12:16:10.838447250 +0100
+++ linux-2.6.15-usb2x/drivers/usb/storage/Makefile	2006-01-30 12:08:29.781633000 +0100
@@ -24,6 +24,8 @@
 usb-storage-objs :=	scsiglue.o protocol.o transport.o usb.o \
 			initializers.o $(usb-storage-obj-y)
 
+obj-$(CONFIG_USB_USBXCHANGE)			+= usbxchange_fw.o
+
 ifneq ($(CONFIG_USB_LIBUSUAL),)
 	obj-$(CONFIG_USB)	+= libusual.o
 endif
diff -urN linux-2.6.15/drivers/usb/storage/initializers.c linux-2.6.15-usb2x/drivers/usb/storage/initializers.c
--- linux-2.6.15/drivers/usb/storage/initializers.c	2006-01-30 12:16:10.826446500 +0100
+++ linux-2.6.15-usb2x/drivers/usb/storage/initializers.c	2006-01-30 12:08:09.340355500 +0100
@@ -164,3 +164,27 @@
 	return USB_STOR_TRANSPORT_FAILED;
 }
 
+/* Firmware Initialisation for the Adaptec USB2Xchange, needed for
+ * to recognize devices properly. René Rebe <rene@exactcode.de> */
+int usb2xchange_init(struct us_data *us)
+{
+	int result;
+
+	US_DEBUGP ("usb2xchange_init: initialising after reenumeration.\n");
+
+	result = usb_control_msg(us->pusb_dev, us->send_ctrl_pipe, 
+				 0x5a, 0x40, 0x01,
+				 0, 0,	// buffer,
+				 0,	// length,
+				 300);
+	US_DEBUGP ("usb2xchange_init: reset #1 (%d)\n", result);
+
+	result = usb_control_msg(us->pusb_dev, us->send_ctrl_pipe,
+				 0x5a, 0x40, 0x02,
+				 0, 0,	// buffer,
+				 0,	// length,
+				 300);
+	US_DEBUGP ("usb2xchange_init: reset #2 (%d)\n", result);
+
+	return result;
+}
diff -urN linux-2.6.15/drivers/usb/storage/initializers.h linux-2.6.15-usb2x/drivers/usb/storage/initializers.h
--- linux-2.6.15-mm4/drivers/usb/storage/initializers.h	2006-01-30 12:16:10.826446500 +0100
+++ linux-2.6.15-usb2x/drivers/usb/storage/initializers.h	2006-01-30 12:04:35.110967000 +0100
@@ -49,3 +49,6 @@
  * flash reader */
 int usb_stor_ucr61s2b_init(struct us_data *us);
 int rio_karma_init(struct us_data *us);
+
+/* Firmware Initialization for the Adaptec USB2Xchange */
+int usb2xchange_init(struct us_data *us);
diff -urN linux-2.6.15/drivers/usb/storage/unusual_devs.h linux-2.6.15-usb2x/drivers/usb/storage/unusual_devs.h
--- linux-2.6.15/drivers/usb/storage/unusual_devs.h	2006-01-30 12:16:10.870449250 +0100
+++ linux-2.6.15-usb2x/drivers/usb/storage/unusual_devs.h	2006-01-27 21:49:46.570867000 +0100
@@ -1180,6 +1180,21 @@
 		US_FL_SINGLE_LUN),
 #endif
 
+/* Adaptec USBXchange and USB2Xchange, after firmware download.
+ * Requires Ez-USB Style firmware loader. René Rebe <rene@exactcode.de> */
+
+UNUSUAL_DEV(  0x03f3, 0x2001, 0x0000, 0xffff,
+		"Adaptec",
+		"USBXchange",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		0 ),
+
+UNUSUAL_DEV(  0x03f3, 0x2003, 0x0000, 0xffff,
+		"Adaptec",
+		"USB2Xchange",
+		US_SC_SCSI, US_PR_BULK, usb2xchange_init,
+		0 ),
+
 /* Control/Bulk transport for all SubClass values */
 USUAL_DEV(US_SC_RBC, US_PR_CB, USB_US_TYPE_STOR),
 USUAL_DEV(US_SC_8020, US_PR_CB, USB_US_TYPE_STOR),
diff -urN linux-2.6.15/drivers/usb/storage/usbxchange_fw.c linux-2.6.15-usb2x/drivers/usb/storage/usbxchange_fw.c
--- linux-2.6.15-mm4/drivers/usb/storage/usbxchange_fw.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-usb2x/drivers/usb/storage/usbxchange_fw.c	2006-01-28 09:45:14.308438000 +0100
@@ -0,0 +1,215 @@
+/*
+ * Firmware loader for Adaptec USBXchange / USB2Xchange.
+ *
+ * Uploads device firmware into the Adaptec USBXchange and USB2Xchange
+ * USB --> SCSI dongle.
+ *
+ * Current development and maintenance by:
+ *   (c) 2005 René Rebe <rene@exactcode.de>
+ *
+ * Initial work by:
+ *   (c) 2004 Beier & Dauskardt IT <sda@bdit.de>
+ *
+ * Based on emi26.c:
+ *   (c) 2002 Tapio Laxström <tapio.laxstrom@iptime.fi>
+ *
+ * To use this driver, you need to get the devices firmware from some
+ * windows driver:
+ *   usbxchg_win_v120.exe - for USBXchange
+ *   usb2xchg_win_drv_v200.exe - for USB2Xchange
+ *
+ * Hotplug firmware loader compatible files can be found at:
+ *   http://dl.exactcode.de/adaptec-usbxchange/
+ *
+ * Note:
+ * The USB2Xchange seems to have some internal buffer < 64K. 
+ * Sending 64K requests crashes the device. Possibly it needs a
+ * "max_sectors: 8" setting.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, as published by
+ * the Free Software Foundation, version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/usb.h>
+#include <linux/firmware.h>
+
+#include "usbxchange_fw.h"
+
+static int usbxchange_writememory(struct usb_device *dev, int address,
+				  unsigned char *data, int length,
+				  __u8 bRequest);
+static int usbxchange_set_reset(struct usb_device *dev, int cpureg,
+				unsigned char reset_bit);
+static int usbxchange_load_firmware(struct usb_device *dev);
+
+static int usbxchange_probe(struct usb_interface *iface,
+			    const struct usb_device_id *id);
+static void usbxchange_disconnect(struct usb_interface *iface);
+static int __init usbxchange_init(void);
+static void __exit usbxchange_exit(void);
+
+#define usbxchange_VENDOR_ID 0x03f3
+#define usbxchange_PRODUCT_ID 0x2000
+#define usb2xchange_PRODUCT_ID 0x2002
+
+static struct usb_device_id usbxchange_usb_ids[] = {
+	{USB_DEVICE(usbxchange_VENDOR_ID, usbxchange_PRODUCT_ID)},
+	{USB_DEVICE(usbxchange_VENDOR_ID, usb2xchange_PRODUCT_ID)},
+	{}			/* terminating entry */
+};
+
+MODULE_DEVICE_TABLE(usb, usbxchange_usb_ids);
+
+/* thanks to drivers/usb/serial/keyspan_pda.c code */
+static int usbxchange_writememory(struct usb_device *dev, int address,
+                                  unsigned char *data, int length, __u8 request)
+{
+	int result;
+	unsigned char *buffer = kmalloc(length, GFP_KERNEL);
+
+	if (!buffer) {
+		printk(KERN_ERR "usbxchange: kmalloc(%d) failed.\n", length);
+		return -ENOMEM;
+	}
+	memcpy(buffer, data, length);
+	result = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), request, 0x40,
+	                         address, 0, buffer, length, 300);
+	kfree(buffer);
+	return result;
+}
+
+/* thanks to drivers/usb/serial/keyspan_pda.c code */
+static int usbxchange_set_reset(struct usb_device *dev, int cpureg,
+				unsigned char reset_bit)
+{
+	int response;
+	printk(KERN_INFO "%s - %d\n", __FUNCTION__, reset_bit);
+	response =
+	    usbxchange_writememory(dev, cpureg, &reset_bit, 1,
+				   ANCHOR_LOAD_INTERNAL);
+	if (response < 0) {
+		printk(KERN_ERR "usbxchange: set_reset (%d) failed\n",
+		       reset_bit);
+	}
+	return response;
+}
+
+static int usbxchange_load_firmware(struct usb_device *dev)
+{
+	INTEL_HEX_RECORD *record;
+	int err, cpureg;
+
+	const struct firmware *firmware;
+
+	switch (le16_to_cpu(dev->descriptor.idProduct)) {
+	case usbxchange_PRODUCT_ID:
+		err = request_firmware(&firmware, "usbxchange.fw", &dev->dev);
+		cpureg = CPUCS_REG;
+		break;
+	case usb2xchange_PRODUCT_ID:
+		err = request_firmware(&firmware, "usb2xchange.fw", &dev->dev);
+		cpureg = CPUCS_REG_FX2;
+		break;
+	default:
+		printk(KERN_ERR "%s - device not recognized %x\n", __FUNCTION__,
+		       le16_to_cpu(dev->descriptor.idProduct));
+		return 1;
+	}
+
+	if (err != 0) {
+		printk(KERN_ERR "Hotplug firmware request failed.\n");
+		return err;
+	}
+
+	/* Stop CPU */
+	err = usbxchange_set_reset(dev, cpureg, 1);
+	err = usbxchange_set_reset(dev, cpureg, 1);
+	if (err < 0) {
+		printk(KERN_ERR "%s - error stopping dongle CPU: error = %d\n",
+		       __FUNCTION__, err);
+		return err;
+	}
+
+	/* Upload firmware */
+	for (record = (INTEL_HEX_RECORD *)firmware->data;
+	     record->type == 0; record++) {
+
+		err = usbxchange_writememory(dev, le32_to_cpu(record->address),
+					     record->data,
+					     le32_to_cpu(record->length),
+					     ANCHOR_LOAD_INTERNAL);
+		if (err < 0) {
+			printk(KERN_ERR
+			       "%s - error loading firmware: error = %d\n",
+			       __FUNCTION__, err);
+			return err;
+		}
+	}
+
+	/* De-assert reset (let the CPU run) */
+	err = usbxchange_set_reset(dev, cpureg, 1);
+	err = usbxchange_set_reset(dev, cpureg, 0);
+	if (err < 0) {
+		printk(KERN_ERR "%s - error resetting dongle CPU: error = %d\n",
+		       __FUNCTION__, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int usbxchange_probe(struct usb_interface *iface,
+                            const struct usb_device_id *id)
+{
+	struct usb_device *dev = interface_to_usbdev(iface);
+
+	printk(KERN_INFO "%s start\n", __FUNCTION__);
+
+	usbxchange_load_firmware(dev);
+
+	/* forcing an unload would save some kB of kernel memory ... */
+	return 0;
+}
+
+static void usbxchange_disconnect(struct usb_interface *iface)
+{
+}
+
+static struct usb_driver usbxchange_driver = {
+	.name = "usbxchange_fw",
+	.probe = usbxchange_probe,
+	.disconnect = usbxchange_disconnect,
+	.id_table = usbxchange_usb_ids,
+};
+
+static int __init usbxchange_init(void)
+{
+	usb_register(&usbxchange_driver);
+	return 0;
+}
+
+static void __exit usbxchange_exit(void)
+{
+	usb_deregister(&usbxchange_driver);
+}
+
+module_init(usbxchange_init);
+module_exit(usbxchange_exit);
+
+MODULE_AUTHOR("René Rebe <rene@exactcode.de>, Sancho Dauskardt <sda@bdit.de>");
+MODULE_DESCRIPTION("Adaptec USBXchange firmware loader.");
+MODULE_LICENSE("GPL");
+
+/* vi:ai:syntax=c:sw=8:ts=8:tw=80
+ */
diff -urN linux-2.6.15/drivers/usb/storage/usbxchange_fw.h linux-2.6.15-usb2x/drivers/usb/storage/usbxchange_fw.h
--- linux-2.6.15-mm4/drivers/usb/storage/usbxchange_fw.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-usb2x/drivers/usb/storage/usbxchange_fw.h	2006-01-27 17:18:18.246377000 +0100
@@ -0,0 +1,45 @@
+/* 
+ * Firmware loader for Adaptec USBXchange / USB2Xchange.
+ *
+ * Uploads device firmware into the Adaptec USBXchange and USB2Xchange
+ * USB --> SCSI dongle.
+ *
+ * Current development and maintenance by:
+ *   (c) 2005 René Rebe <rene@exactcode.de>
+ *
+ * Initial work by:
+ *   (c) 2004 Beier & Dauskardt IT <sda@bdit.de>
+ *
+ * Based on emi26.c:
+ *   (c) 2002 Tapio Laxström <tapio.laxstrom@iptime.fi>
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, as published by
+ * the Free Software Foundation, version 2.
+ */
+
+#ifndef _USB_USBXCHANGE_FW_H_INCLUDED
+#define _USB_USBXCHANGE_FW_H_INCLUDED
+
+#define MAX_INTEL_HEX_RECORD_LENGTH 16
+typedef struct _INTEL_HEX_RECORD {
+	__u32 length;
+	__u32 address;
+	__u32 type;
+	__u8 data[MAX_INTEL_HEX_RECORD_LENGTH];
+} INTEL_HEX_RECORD, *PINTEL_HEX_RECORD;
+
+/* Vendor specific request code for Anchor Upload/Download
+   (This one is implemented in the core). */
+#define ANCHOR_LOAD_INTERNAL	0xA0
+
+/* EZ-USB Control and Status Register. Bit 0 controls 8051 reset */
+#define CPUCS_REG		0x7F92	/* original / FX */
+#define CPUCS_REG_FX2		0xE600	/* FX2 */
+
+#endif


-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
