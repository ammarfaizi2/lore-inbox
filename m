Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWCKVAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWCKVAk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 16:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWCKVAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 16:00:40 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:46720 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1751442AbWCKVAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 16:00:39 -0500
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Lanslott Gish <lanslott.gish@gmail.com>, Greg KH <greg@kroah.com>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>
Subject: [RFC][PATCH] USB touch screen driver, all-in-one
Date: Sat, 11 Mar 2006 21:55:37 +0100
User-Agent: KMail/1.7.2
Cc: tejohnson@yahoo.com, hc@mivu.no, vojtech@suse.cz
References: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com>
In-Reply-To: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603112155.38984.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-05.tornado.cablecom.ch 32700;
	Body=9 Fuz1=9 Fuz2=9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

here my merge of the USB touchscreen drivers, based on my patch from
thursday for touchkitusb. this time it's a new driver...

and of course it's untested. i can test the egalax part next week...

[ also cc'ing the authors of the other drivers ]

the sizes for comparison:
   text    data     bss     dec     hex filename
   2942     724       4    3670     e56 touchkitusb.ko
   2647     660       0    3307     ceb mtouchusb.ko
   2448     628       0    3076     c04 itmtouch.ko
   4097    1012       4    5113    13f9 usbtouchscreen.ko

comments?

rgds
-daniel

------------

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/drivers/usb/input/Kconfig b/drivers/usb/input/Kconfig
index 5246b35..2f16657 100644
--- a/drivers/usb/input/Kconfig
+++ b/drivers/usb/input/Kconfig
@@ -240,6 +240,42 @@ config USB_EGALAX
 	  To compile this driver as a module, choose M here: the
 	  module will be called touchkitusb.
 
+config USB_TOUCHSCREEN
+	tristate "USB Touchscreen Driver"
+	depends on USB && INPUT
+	---help---
+	  USB Touchscreen driver for:
+	  - eGalax Touchkit USB
+	  - PanJit TouchSet USB
+	  - 3M MicroTouch USB
+	  - ITM
+
+	  Have a look at <http://linux.chapter7.ch/touchkit/> for
+	  a usage description and the required user-space stuff.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called usbtouchscreen.
+
+config USB_TOUCHSCREEN_EGALAX
+	default y
+	bool "eGalax device support" if EMBEDDED
+	depends on USB_TOUCHSCREEN
+
+config USB_TOUCHSCREEN_PANJIT
+	default y
+	bool "PanJit device support" if EMBEDDED
+	depends on USB_TOUCHSCREEN
+
+config USB_TOUCHSCREEN_3M
+	default y
+	bool "3M/Microtouch device support" if EMBEDDED
+	depends on USB_TOUCHSCREEN
+
+config USB_TOUCHSCREEN_ITM
+	default y
+	bool "ITM device support" if EMBEDDED
+	depends on USB_TOUCHSCREEN
+
 config USB_YEALINK
 	tristate "Yealink usb-p1k voip phone"
 	depends on USB && INPUT && EXPERIMENTAL
diff --git a/drivers/usb/input/Makefile b/drivers/usb/input/Makefile
index d512d9f..7641145 100644
--- a/drivers/usb/input/Makefile
+++ b/drivers/usb/input/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_USB_MOUSE)		+= usbmouse.o
 obj-$(CONFIG_USB_MTOUCH)	+= mtouchusb.o
 obj-$(CONFIG_USB_ITMTOUCH)	+= itmtouch.o
 obj-$(CONFIG_USB_EGALAX)	+= touchkitusb.o
+obj-$(CONFIG_USB_TOUCHSCREEN)	+= usbtouchscreen.o
 obj-$(CONFIG_USB_POWERMATE)	+= powermate.o
 obj-$(CONFIG_USB_WACOM)		+= wacom.o
 obj-$(CONFIG_USB_ACECAD)	+= acecad.o
diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
index 07a012f..103e33f 100644
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -1460,6 +1460,8 @@ void hid_init_reports(struct hid_device 
 #define USB_VENDOR_ID_HP		0x03f0
 #define USB_DEVICE_ID_HP_USBHUB_KB	0x020c
 
+#define USB_VENDOR_ID_PANJIT		0x134c
+
 /*
  * Alphabetically sorted blacklist by quirk type.
  */
@@ -1605,6 +1607,11 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },
 
+	{ USB_VENDOR_ID_PANJIT, 0x0001, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_PANJIT, 0x0002, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_PANJIT, 0x0003, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_PANJIT, 0x0004, HID_QUIRK_IGNORE },
+
 	{ 0, 0 }
 };
 
--- /dev/null	1998-05-05 22:32:27.000000000 +0200
+++ b/drivers/usb/input/usbtouchscreen.c	2006-03-11 16:06:04.000000000 +0100
@@ -0,0 +1,587 @@
+/******************************************************************************
+ * usbtouchscreen.c
+ * Driver for USB Touchscreens, supporting those devices:
+ *  - eGalax Touchkit
+ *  - 3M/Microtouch
+ *  - ITM
+ *  - PanJit TouchSet
+ *
+ * Copyright (C) 2004-2006 by Daniel Ritz <daniel.ritz@gmx.ch>
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
+ * Driver is based on touchkitusb.c
+ * - ITM parts are from itmtouch.c
+ * - 3M parts are from mtouchusb.c
+ * - PanJit parts are from an unmerged driver by Lanslott Gish
+ *
+ *****************************************************************************/
+
+//#define DEBUG
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
+
+#define DRIVER_VERSION		"v0.3"
+#define DRIVER_AUTHOR		"Daniel Ritz <daniel.ritz@gmx.ch>"
+#define DRIVER_DESC		"USB Touchscreen Driver"
+
+static int swap_xy;
+module_param(swap_xy, bool, 0644);
+MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
+
+
+/* device specifc data/functions */
+struct usbtouch_usb;
+struct usbtouch_device_info {
+	int min_xc, max_xc;
+	int min_yc, max_yc;
+	int min_press, max_press;
+	int rept_size;
+	int flags;
+
+	void (*process_pkt) (struct usbtouch_usb *usbtouch, struct pt_regs *regs, char *pkt, int len);
+	int  (*read_data)   (char *pkt, int *x, int *y, int *touch, int *press);
+	void (*init)        (struct usbtouch_usb *usbtouch);
+};
+
+#define USBTOUCH_FLG_BUFFER	0x01
+
+
+/* a usbtouch device */
+struct usbtouch_usb {
+	unsigned char *data;
+	dma_addr_t data_dma;
+	char *buffer;
+	int buf_len;
+	struct urb *irq;
+	struct usb_device *udev;
+	struct input_dev *input;
+	struct usbtouch_device_info *type;
+	char name[128];
+	char phys[64];
+};
+
+static void usbtouch_process_pkt(struct usbtouch_usb *usbtouch,
+                                 struct pt_regs *regs, char *pkt, int len);
+
+/* device types */
+enum {
+	DEVTPYE_DUMMY = -1,
+	DEVTYPE_EGALAX,
+	DEVTYPE_PANJIT,
+	DEVTYPE_3M,
+	DEVTYPE_ITM,
+};
+
+static struct usb_device_id usbtouch_devices[] = {
+#ifdef CONFIG_USB_TOUCHSCREEN_EGALAX
+	{USB_DEVICE(0x3823, 0x0001), .driver_info = DEVTYPE_EGALAX},
+	{USB_DEVICE(0x0123, 0x0001), .driver_info = DEVTYPE_EGALAX},
+	{USB_DEVICE(0x0eef, 0x0001), .driver_info = DEVTYPE_EGALAX},
+	{USB_DEVICE(0x0eef, 0x0002), .driver_info = DEVTYPE_EGALAX},
+#endif
+
+#ifdef CONFIG_USB_TOUCHSCREEN_PANJIT
+	{USB_DEVICE(0x134c, 0x0001), .driver_info = DEVTYPE_PANJIT},
+	{USB_DEVICE(0x134c, 0x0002), .driver_info = DEVTYPE_PANJIT},
+	{USB_DEVICE(0x134c, 0x0003), .driver_info = DEVTYPE_PANJIT},
+	{USB_DEVICE(0x134c, 0x0004), .driver_info = DEVTYPE_PANJIT},
+#endif
+
+#ifdef CONFIG_USB_TOUCHSCREEN_3M
+	{USB_DEVICE(0x0596, 0x0001), .driver_info = DEVTYPE_3M},
+#endif
+
+#ifdef CONFIG_USB_TOUCHSCREEN_ITM
+	{USB_DEVICE(0x0403, 0xf9e9), .driver_info = DEVTYPE_ITM},
+#endif
+
+	{}
+};
+
+
+/*****************************************************************************
+ * eGalax part
+ */
+
+#ifdef CONFIG_USB_TOUCHSCREEN_EGALAX
+
+#define EGALAX_PKT_TYPE_MASK		0xFE
+#define EGALAX_PKT_TYPE_REPT		0x80
+#define EGALAX_PKT_TYPE_DIAG		0x0A
+
+static int egalax_read_data(char *pkt, int *x, int *y, int *touch, int *press)
+{
+	if ((pkt[0] & EGALAX_PKT_TYPE_MASK) != EGALAX_PKT_TYPE_REPT)
+		return 0;
+
+	*x = ((pkt[3] & 0x0F) << 7) | (pkt[4] & 0x7F);
+	*y = ((pkt[1] & 0x0F) << 7) | (pkt[2] & 0x7F);
+	*touch = (pkt[0] & 0x01) ? 1 : 0;
+
+	return 1;
+
+}
+
+static int egalax_get_pkt_len(char *buf)
+{
+	switch (buf[0] & EGALAX_PKT_TYPE_MASK) {
+	case EGALAX_PKT_TYPE_REPT:
+		return 5;
+
+	case EGALAX_PKT_TYPE_DIAG:
+		return buf[1] + 2;
+	}
+
+	return 0;
+}
+
+static void egalax_process(struct usbtouch_usb *usbtouch,
+                           struct pt_regs *regs, char *pkt, int len)
+{
+	char *buffer;
+	int pkt_len, buf_len, pos;
+
+	/* if the buffer contains data, append */
+	if (unlikely(usbtouch->buf_len)) {
+		int tmp;
+
+		/* if only 1 byte in buffer, add another one to get length */
+		if (usbtouch->buf_len == 1)
+			usbtouch->buffer[1] = pkt[0];
+
+		pkt_len = egalax_get_pkt_len(usbtouch->buffer);
+
+		/* unknown packet: drop everything */
+		if (!pkt_len)
+			return;
+
+		/* append, process */
+		tmp = pkt_len - usbtouch->buf_len;
+		memcpy(usbtouch->buffer + usbtouch->buf_len, pkt, tmp);
+		usbtouch_process_pkt(usbtouch, regs, usbtouch->buffer, pkt_len);
+
+		buffer = pkt + tmp;
+		buf_len = len - tmp;
+	} else {
+		buffer = pkt;
+		buf_len = len;
+	}
+
+	/* only one byte left in buffer */
+	if (unlikely(buf_len == 1)) {
+		usbtouch->buffer[0] = buffer[0];
+		usbtouch->buf_len = 1;
+		return;
+	}
+
+	/* loop over the buffer */
+	pos = 0;
+	while (pos < buf_len) {
+		/* get packet len */
+		pkt_len = egalax_get_pkt_len(buffer + pos);
+
+		/* unknown packet: drop everything */
+		if (unlikely(!pkt_len))
+			return;
+
+		/* full packet: process */
+		if (likely(pkt_len <= buf_len)) {
+			usbtouch_process_pkt(usbtouch, regs, buffer + pos, pkt_len);
+		} else {
+			/* incomplete packet: save in buffer */
+			memcpy(usbtouch->buffer, buffer + pos, buf_len - pos);
+			usbtouch->buf_len = buf_len - pos;
+		}
+		pos += pkt_len;
+	}
+}
+#endif
+
+
+/*****************************************************************************
+ * PanJit Part
+ */
+#ifdef CONFIG_USB_TOUCHSCREEN_PANJIT
+static int panjit_read_data(char *pkt, int *x, int *y, int *touch, int *press)
+{
+	*x = pkt[1] | (pkt[2] << 8);
+	*y = pkt[3] | (pkt[4] << 8);
+	*touch = (pkt[0] & 0x01) ? 1 : 0;
+
+	return 1;
+}
+#endif
+
+
+/*****************************************************************************
+ * 3M/Microtouch Part
+ */
+#ifdef CONFIG_USB_TOUCHSCREEN_3M
+
+#define MTOUCHUSB_ASYNC_REPORT          1
+#define MTOUCHUSB_RESET                 7
+#define MTOUCHUSB_REQ_CTRLLR_ID         10
+
+static int mtouch_read_data(char *pkt, int *x, int *y, int *touch, int *press)
+{
+	*x = (pkt[8] << 8) | pkt[7];
+	*y = (pkt[10] << 8) | pkt[9];
+	*touch = (pkt[2] & 0x40) ? 1 : 0;
+
+	return 1;
+}
+
+static void mtouch_init(struct usbtouch_usb *usbtouch)
+{
+	int ret;
+
+	ret = usb_control_msg(usbtouch->udev, usb_rcvctrlpipe(usbtouch->udev, 0),
+	                      MTOUCHUSB_RESET,
+	                      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+	                      1, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
+	dbg("%s - usb_control_msg - MTOUCHUSB_RESET - bytes|err: %d",
+	    __FUNCTION__, ret);
+
+	ret = usb_control_msg(usbtouch->udev, usb_rcvctrlpipe(usbtouch->udev, 0),
+	                      MTOUCHUSB_ASYNC_REPORT,
+	                      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+	                      1, 1, NULL, 0, USB_CTRL_SET_TIMEOUT);
+	dbg("%s - usb_control_msg - MTOUCHUSB_ASYNC_REPORT - bytes|err: %d",
+	    __FUNCTION__, ret);
+}
+#endif
+
+
+/*****************************************************************************
+ * ITM Part
+ */
+#ifdef CONFIG_USB_TOUCHSCREEN_ITM
+static int itm_read_data(char *pkt, int *x, int *y, int *touch, int *press)
+{
+	*x = ((pkt[0] & 0x1F) << 7) | (pkt[3] & 0x7F);
+	*x = ((pkt[1] & 0x1F) << 7) | (pkt[4] & 0x7F);
+	*press = ((pkt[2] & 0x1F) << 7) | (pkt[5] & 0x7F);
+	*touch = ~pkt[7] & 0x20;
+
+	return 1;
+}
+#endif
+
+
+/*****************************************************************************
+ * the different device descriptors
+ */
+static struct usbtouch_device_info usbtouch_dev_info[] = {
+#ifdef CONFIG_USB_TOUCHSCREEN_EGALAX
+	[DEVTYPE_EGALAX] = {
+		.min_xc		= 0x0,
+		.max_xc		= 0x07ff,
+		.min_yc		= 0x0,
+		.max_yc		= 0x07ff,
+		.rept_size	= 16,
+		.flags		= USBTOUCH_FLG_BUFFER,
+		.process_pkt	= egalax_process,
+		.read_data	= egalax_read_data,
+	},
+#endif
+
+#ifdef CONFIG_USB_TOUCHSCREEN_PANJIT
+	[DEVTYPE_PANJIT] = {
+		.min_xc		= 0x0,
+		.max_xc		= 0x0fff,
+		.min_yc		= 0x0,
+		.max_yc		= 0x0fff,
+		.rept_size	= 8,
+		.read_data	= panjit_read_data,
+	},
+#endif
+
+#ifdef CONFIG_USB_TOUCHSCREEN_3M
+	[DEVTYPE_3M] = {
+		.min_xc		= 0x0,
+		.max_xc		= 0x4000,
+		.min_yc		= 0x0,
+		.max_yc		= 0x4000,
+		.rept_size	= 11,
+		.read_data	= mtouch_read_data,
+		.init		= mtouch_init,
+	},
+#endif
+
+#ifdef CONFIG_USB_TOUCHSCREEN_ITM
+	[DEVTYPE_ITM] = {
+		.min_xc		= 0x0,
+		.max_xc		= 0x0fff,
+		.min_yc		= 0x0,
+		.max_yc		= 0x0fff,
+		.max_press	= 0xff,
+		.rept_size	= 8,
+		.read_data	= itm_read_data,
+	},
+#endif
+};
+
+
+/*****************************************************************************
+ * Generic Part
+ */
+static void usbtouch_process_pkt(struct usbtouch_usb *usbtouch,
+                                 struct pt_regs *regs, char *pkt, int len)
+{
+	int x, y, touch, press;
+
+	if (!usbtouch->type->read_data(pkt, &x, &y, &touch, &press))
+			return;
+
+	input_regs(usbtouch->input, regs);
+	input_report_key(usbtouch->input, BTN_TOUCH, touch);
+
+	if (swap_xy) {
+		input_report_abs(usbtouch->input, ABS_X, y);
+		input_report_abs(usbtouch->input, ABS_Y, x);
+	} else {
+		input_report_abs(usbtouch->input, ABS_X, x);
+		input_report_abs(usbtouch->input, ABS_Y, y);
+	}
+	if (usbtouch->type->max_press)
+		input_report_abs(usbtouch->input, ABS_PRESSURE, press);
+	input_sync(usbtouch->input);
+}
+
+
+static void usbtouch_irq(struct urb *urb, struct pt_regs *regs)
+{
+	struct usbtouch_usb *usbtouch = urb->context;
+	int retval;
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
+	usbtouch->type->process_pkt(usbtouch, regs, usbtouch->data, urb->actual_length);
+
+exit:
+	retval = usb_submit_urb(urb, GFP_ATOMIC);
+	if (retval)
+		err("%s - usb_submit_urb failed with result: %d",
+		    __FUNCTION__, retval);
+}
+
+static int usbtouch_open(struct input_dev *input)
+{
+	struct usbtouch_usb *usbtouch = input->private;
+
+	usbtouch->irq->dev = usbtouch->udev;
+
+	if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
+		return -EIO;
+
+	return 0;
+}
+
+static void usbtouch_close(struct input_dev *input)
+{
+	struct usbtouch_usb *usbtouch = input->private;
+
+	usb_kill_urb(usbtouch->irq);
+}
+
+
+static void usbtouch_free_buffers(struct usb_device *udev,
+				  struct usbtouch_usb *usbtouch)
+{
+	if (usbtouch->data)
+		usb_buffer_free(udev, usbtouch->type->rept_size,
+		                usbtouch->data, usbtouch->data_dma);
+	kfree(usbtouch->buffer);
+}
+
+
+static int usbtouch_probe(struct usb_interface *intf,
+			  const struct usb_device_id *id)
+{
+	struct usbtouch_usb *usbtouch;
+	struct input_dev *input_dev;
+	struct usb_host_interface *interface;
+	struct usb_endpoint_descriptor *endpoint;
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct usbtouch_device_info *type;
+
+	interface = intf->cur_altsetting;
+	endpoint = &interface->endpoint[0].desc;
+
+	usbtouch = kzalloc(sizeof(struct usbtouch_usb), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!usbtouch || !input_dev)
+		goto out_free;
+
+	type = &usbtouch_dev_info[id->driver_info];
+	usbtouch->type = type;
+	if (!type->process_pkt)
+		type->process_pkt = usbtouch_process_pkt;
+
+	usbtouch->data = usb_buffer_alloc(udev, type->rept_size,
+	                                  SLAB_KERNEL, &usbtouch->data_dma);
+	if (!usbtouch->data)
+		goto out_free;
+
+	if (type->flags & USBTOUCH_FLG_BUFFER) {
+		usbtouch->buffer = kmalloc(type->rept_size, GFP_KERNEL);
+		if (!usbtouch->buffer)
+			goto out_free_buffers;
+	}
+
+	usbtouch->irq = usb_alloc_urb(0, GFP_KERNEL);
+	if (!usbtouch->irq) {
+		dbg("%s - usb_alloc_urb failed: usbtouch->irq", __FUNCTION__);
+		goto out_free_buffers;
+	}
+
+	usbtouch->udev = udev;
+	usbtouch->input = input_dev;
+
+	if (udev->manufacturer)
+		strlcpy(usbtouch->name, udev->manufacturer, sizeof(usbtouch->name));
+
+	if (udev->product) {
+		if (udev->manufacturer)
+			strlcat(usbtouch->name, " ", sizeof(usbtouch->name));
+		strlcat(usbtouch->name, udev->product, sizeof(usbtouch->name));
+	}
+
+	if (!strlen(usbtouch->name))
+		snprintf(usbtouch->name, sizeof(usbtouch->name),
+			"USB Touchscreen %04x:%04x",
+			 le16_to_cpu(udev->descriptor.idVendor),
+			 le16_to_cpu(udev->descriptor.idProduct));
+
+	usb_make_path(udev, usbtouch->phys, sizeof(usbtouch->phys));
+	strlcpy(usbtouch->phys, "/input0", sizeof(usbtouch->phys));
+
+	input_dev->name = usbtouch->name;
+	input_dev->phys = usbtouch->phys;
+	usb_to_input_id(udev, &input_dev->id);
+	input_dev->cdev.dev = &intf->dev;
+	input_dev->private = usbtouch;
+	input_dev->open = usbtouch_open;
+	input_dev->close = usbtouch_close;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_set_abs_params(input_dev, ABS_X, type->min_xc, type->max_xc, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, type->min_yc, type->max_yc, 0, 0);
+	input_set_abs_params(input_dev, ABS_PRESSURE, type->min_press, type->max_press, 0, 0);
+
+	usb_fill_int_urb(usbtouch->irq, usbtouch->udev,
+			 usb_rcvintpipe(usbtouch->udev, 0x81),
+			 usbtouch->data, type->rept_size,
+			 usbtouch_irq, usbtouch, endpoint->bInterval);
+
+	usbtouch->irq->transfer_dma = usbtouch->data_dma;
+	usbtouch->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	input_register_device(usbtouch->input);
+
+	usb_set_intfdata(intf, usbtouch);
+
+	/* device specific init */
+	if (type->init)
+		type->init(usbtouch);
+
+	return 0;
+
+out_free_buffers:
+	usbtouch_free_buffers(udev, usbtouch);
+out_free:
+	input_free_device(input_dev);
+	kfree(usbtouch);
+	return -ENOMEM;
+}
+
+static void usbtouch_disconnect(struct usb_interface *intf)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+
+	dbg("%s - called", __FUNCTION__);
+
+	if (!usbtouch)
+		return;
+
+	dbg("%s - usbtouch is initialized, cleaning up", __FUNCTION__);
+	usb_set_intfdata(intf, NULL);
+	usb_kill_urb(usbtouch->irq);
+	input_unregister_device(usbtouch->input);
+	usb_free_urb(usbtouch->irq);
+	usbtouch_free_buffers(interface_to_usbdev(intf), usbtouch);
+	kfree(usbtouch);
+}
+
+MODULE_DEVICE_TABLE(usb, usbtouch_devices);
+
+static struct usb_driver usbtouch_driver = {
+	.name		= "usbtouchscreen",
+	.probe		= usbtouch_probe,
+	.disconnect	= usbtouch_disconnect,
+	.id_table	= usbtouch_devices,
+};
+
+static int __init usbtouch_init(void)
+{
+	return usb_register(&usbtouch_driver);
+}
+
+static void __exit usbtouch_cleanup(void)
+{
+	usb_deregister(&usbtouch_driver);
+}
+
+module_init(usbtouch_init);
+module_exit(usbtouch_cleanup);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+MODULE_ALIAS("touchkitusb");
+MODULE_ALIAS("itmtouch");
+MODULE_ALIAS("mtouchusb");

