Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750725AbWHPCJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWHPCJg (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 15 Aug 2006 22:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWHPCJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:09:36 -0400
Received: from m5-82.163.com ([202.108.5.82]:33247 "HELO m5-82.163.com")
	by vger.kernel.org with SMTP id S1750725AbWHPCJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:09:35 -0400
Date: Wed, 16 Aug 2006 10:09:12 +0800
From: "liyu" <raise_sail@163.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Greg" <greg@kroah.com>,
        "linux-usb-devel" <linux-usb-devel@lists.sourceforge.net>
Subject: [PATCH] usb: Betop BTP-2118 joystick force-feedback driver
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-Id: <44E27D27.04D611.25849>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changelogs:

	1. the first release.

NOTE:	This driver requires:
	1.  [PATCH] usb: The HID Simple Driver Interface 0.3.1 (core)
	2.  [PATCH] usb: HID Simple Driver Interface 0.3.1 (Kconfig and Makefile)

It also can apply on 2.6.17.6 and 2.6.17.8 at least. 

PS: I have not Subscribe linux-usb-devel maillist, please CC me your reply, thanks. 
	
Signed-off-by: Liyu <raise.sail@gmail.com>

diff -Naurp linux-2.6.17.7/drivers/usb/input.orig/btp2118.c linux-2.6.17.7/drivers/usb/input/btp2118.c
--- linux-2.6.17.7/drivers/usb/input.orig/btp2118.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.17.7/drivers/usb/input/btp2118.c	2006-08-15 15:41:43.000000000 +0800
@@ -0,0 +1,438 @@
+/*
+ *  Betop BTP-2118 joystick force-feedback driver
+ *
+ *  Version:	0.1.0
+ *
+ *  Copyright (c) 2006 Liyu <raise.sail@gmail.com>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/sched.h>
+#include "hid.h"
+#include "hid-simple.h"
+
+#define USB_ID_VENDOR	0x12bd
+#define USB_ID_PRODUCT	0xc003
+
+#define USAGE_PAGE_BTP_FF	0x008c0000 /* Bar Code Scanner ? */
+#define USAGE_BTP_FF	0x0002
+
+#define BTP_EFFECT_NONE	(-1)
+
+/* usb_btp_info->flags list */
+#define BTP_DISCONNECTING	0
+#define BTP_URB_DONE		1
+#define BTP_BUSY		2	/* avoid to resend urb */
+
+#define IS_BTP_DISCONNECTING(info) (test_bit(BTP_DISCONNECTING, &(info)->flags))
+#define IS_BTP_URB_DONE(info) \
+	(test_bit(BTP_URB_DONE|BTP_DISCONNECTING, &(info)->flags))
+#define IS_BTP_BUSY(info) (test_bit(BTP_BUSY, &(info)->flags))
+
+#define BTP_SET_DISCONNECTING(info) (set_bit(BTP_DISCONNECTING, &(info)->flags))
+#define BTP_SET_URB_DONE(info) (set_bit(BTP_URB_DONE, &(info)->flags))
+#define BTP_SET_BUSY(info)	(set_bit(BTP_BUSY, &(info)->flags))
+
+#define BTP_CLR_BUSY(info)	(clear_bit(BTP_BUSY, &(info)->flags))
+
+static spinlock_t btp_lock;
+
+struct usb_btp_info {
+	struct timer_list timer;
+	unsigned long flags;
+	/* default shock strength */
+	unsigned char left_strength;
+	unsigned char right_strength;
+	unsigned char start_packet[8];
+	unsigned char stop_packet[8];
+	/* ff data */
+	struct ff_effect	effects[8];
+	int running_effect;
+	int repeat;
+	/* usb data */
+	struct usb_ctrlrequest req;
+	struct usb_device *dev;
+	struct urb *ctrl0;	
+	unsigned int pipe0;
+	int timeout;
+};
+
+static struct usb_device_id btp_id_table[] = {
+	{
+		USB_DEVICE(USB_ID_VENDOR, USB_ID_PRODUCT)
+	},
+	{}
+};
+
+MODULE_DEVICE_TABLE(usb, btp_id_table);
+
+static char driver_name[] = "BETOP Vibration Gamepad (BTP-2118) Driver";
+
+/* This gamepad reports three usages, but all are same. */
+static struct usage_block btp_ff_usage_block[] = {
+	USAGE_BLOCK(USAGE_BTP_FF, 0, EV_FF, FF_GAIN, 0),
+	USAGE_BLOCK(USAGE_BTP_FF, 0, EV_FF, FF_RUMBLE, 0),
+	USAGE_BLOCK(USAGE_BTP_FF, 0, EV_FF, FF_CONSTANT, 0),
+	USAGE_BLOCK(USAGE_BTP_FF, 0, EV_FF, FF_SPRING, 0),
+	USAGE_BLOCK(USAGE_BTP_FF, 0, EV_FF, FF_FRICTION, 0),
+	USAGE_BLOCK(USAGE_BTP_FF, 0, EV_FF, FF_DAMPER, 0),
+	USAGE_BLOCK(USAGE_BTP_FF, 0, EV_FF, FF_INERTIA, 0),
+	USAGE_BLOCK(USAGE_BTP_FF, 0, EV_FF, FF_RAMP, 0),
+	USAGE_BLOCK(USAGE_BTP_FF, 0, EV_FF_STATUS, 0, FF_STATUS_STOPPED),
+	USAGE_BLOCK(USAGE_BTP_FF, 0, EV_FF_STATUS, 0, FF_STATUS_PLAYING),
+	USAGE_BLOCK_NULL
+};
+
+static struct usage_page_block btp_ff_usage_page_blockes[] = {
+	USAGE_PAGE_BLOCK(USAGE_PAGE_BTP_FF, btp_ff_usage_block),
+	USAGE_PAGE_BLOCK_NULL
+};
+
+/* usb_complete_t */
+static void urb_complete(struct urb *urb, struct pt_regs *regs)
+{
+	struct usb_btp_info *info = urb->context;
+	
+	info = urb->context;
+	usb_unlink_urb(urb);
+	
+	if (IS_BTP_DISCONNECTING(info))
+		BTP_SET_URB_DONE(info);
+	BTP_CLR_BUSY(info);
+}
+
+static int inline btp_effect_request(struct usb_btp_info *info, char *packet)
+{
+	if (IS_BTP_BUSY(info))
+		return -EBUSY;
+
+	usb_fill_control_urb (info->ctrl0, info->dev, info->pipe0,
+							(char*)&info->req,
+							packet,
+							info->req.wLength,
+							urb_complete,
+		                                        info);
+	BTP_SET_BUSY(info);
+	usb_submit_urb(info->ctrl0, GFP_ATOMIC);
+	return 0;
+}
+
+/* run by usb_btp_info->timer */
+static void btp_effect_repeat(unsigned long data)
+{
+	struct usb_btp_info *info = (struct usb_btp_info*)data;
+
+	if (IS_BTP_DISCONNECTING(info))
+		return;
+
+	spin_lock(&btp_lock);
+	if (!info->repeat) {
+		info->running_effect = BTP_EFFECT_NONE;
+	} else {
+		mod_timer(&info->timer, jiffies+4*HZ);
+		BTP_CLR_BUSY(info);
+		btp_effect_request(info, info->start_packet);
+		--info->repeat;
+	}
+	spin_unlock(&btp_lock);
+}
+
+/* the caller must hold btp_lock first */
+static int btp_effect_start(struct hid_input *hidinput)
+{
+	struct usb_btp_info *info;
+
+	info = hidinput->private;
+	if (info)
+		return btp_effect_request(info, info->start_packet);
+	return -ENODEV;
+}
+
+/* the caller must hold btp_lock first */
+static int btp_effect_stop(struct hid_input *hidinput)
+{
+	struct usb_btp_info *info;
+
+	info = hidinput->private;
+	if (info)
+		return btp_effect_request(info, info->stop_packet);
+	return -ENODEV;
+}
+
+static int btp_connect(struct hid_device *hid, struct hid_input *hidinput)
+{
+	struct usb_btp_info *info;
+	
+	info = kzalloc(sizeof(struct usb_btp_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;	
+	info->ctrl0 = usb_alloc_urb(0, GFP_KERNEL);
+	if (!info->ctrl0) {
+		kfree(info);
+		return -ENOMEM;
+	}
+	/* Betop-2118 joystick default parameter */
+	info->left_strength = '\x14';
+	info->right_strength = '\x14';
+	info->req.bRequest = 0x9;
+	info->req.bRequestType = (USB_TYPE_CLASS|USB_RECIP_INTERFACE);
+	info->req.wIndex = 0x0;
+	info->req.wValue = 0x200;
+	info->req.wLength = 0x3;
+	info->timeout = USB_CTRL_SET_TIMEOUT;
+	info->dev = hid->dev;
+	info->pipe0 = usb_sndctrlpipe(hid->dev, 0);
+	info->start_packet[0] = info->left_strength;
+	info->start_packet[1] = info->right_strength;
+	info->running_effect = BTP_EFFECT_NONE;
+	init_timer(&info->timer);
+	info->timer.data = (unsigned long)info;
+	info->timer.function = btp_effect_repeat;
+	hidinput->private = info;
+	spin_lock_init(&btp_lock);
+	return 0;
+}
+
+static void inline btp_wait_for_effect(struct usb_btp_info *info)
+{
+	while ( info->flags && !IS_BTP_URB_DONE(info) )
+		schedule();
+	return;
+}
+
+static void btp_disconnect(struct hid_device *hid, struct hid_input *hidinput)
+{
+	struct usb_btp_info *info;
+	unsigned long flags;
+
+	if (!hidinput)
+		return;
+
+	spin_lock_irqsave(&btp_lock, flags);
+	info = hidinput->private;
+	if (IS_BTP_BUSY(info))
+		BTP_SET_DISCONNECTING(info);
+	info->repeat = 0;
+	spin_unlock_irqrestore(&btp_lock, flags);
+
+	del_timer_sync(&info->timer);
+	btp_wait_for_effect(info);
+
+	spin_lock_irqsave(&btp_lock, flags);
+	hidinput->private = NULL;
+	spin_unlock_irqrestore(&btp_lock, flags);
+
+	usb_free_urb(info->ctrl0);
+	kfree(info);
+}
+
+static void usb_btp_update_effect(struct hid_input *hidinput, int offset)
+{
+	struct usb_btp_info *info;
+
+	spin_lock(&btp_lock);
+	info = hidinput->private;
+	if (offset == info->running_effect) {
+		if (btp_effect_stop(hidinput))
+			goto exit;
+		if (info->effects[offset].type) {
+			if (btp_effect_start(hidinput))
+				goto exit;
+		}
+		else	/* remove effect */
+			del_timer(&info->timer);
+	}
+exit:
+	spin_unlock(&btp_lock);
+}
+
+static int btp_FF_GAIN_handler(struct hid_input *hidinput, int value)
+{
+	int offset;
+	unsigned char strength;
+	struct usb_btp_info *info;
+
+	if (value < 0 || value > 99)
+		return -EINVAL;
+	offset = (value>49); /*0 - left motor, 1 - right motor */
+	if (offset)
+		value -= 50;
+	if (!value) {
+		strength = 0;
+		goto exit0;
+	}
+	/* the range of value is from 1 to 50 */
+	/* this mapping value to shock strength (from 0xa to 0x1f) */
+	strength = ((21*value)+459)/48;
+exit0:
+	spin_lock(&btp_lock);
+	info = hidinput->private;
+	if (info)
+		info->start_packet[offset] = strength;
+	spin_unlock(&btp_lock);
+	return 0;
+}
+
+static int btp_ff_event(struct input_dev *dev, int type, int code, int value)
+{
+	struct hid_input *hidinput;
+	struct usb_btp_info *info;
+	int ret = 0;
+	int running_effect;
+
+	hidinput = hidinput_simple_inputdev_to_hidinput(dev);
+	if (!hidinput)
+		return -ENODEV;
+
+	spin_lock(&btp_lock);
+	info = hidinput->private;
+	if (!info || IS_BTP_DISCONNECTING(info)) {
+		ret = -ENODEV;
+		goto unlock_exit;
+	}
+	running_effect = info->running_effect;
+	spin_unlock(&btp_lock);
+
+	if (type == EV_FF_STATUS) {
+		if (code == running_effect)
+			input_report_ff_status(dev, code, FF_STATUS_PLAYING);
+		else
+			input_report_ff_status(dev, code, FF_STATUS_STOPPED);
+	}
+
+	if (type != EV_FF)
+		return -EINVAL;
+
+	switch (code) {
+		case FF_GAIN:
+			return btp_FF_GAIN_handler(hidinput, value);
+		default:
+			spin_lock(&btp_lock);
+			info = hidinput->private;
+			if (!info) {
+				ret = -ENODEV;
+				goto unlock_exit;
+			}
+			info->repeat = value;
+			if (value) {
+				if (btp_effect_start(hidinput))
+					goto unlock_exit;
+				if (value>1) {
+					del_timer(&info->timer);
+					mod_timer(&info->timer, jiffies+4*HZ);
+				}
+				info->running_effect = code;
+			}
+			else {
+				del_timer(&info->timer);
+				if (btp_effect_stop(hidinput))
+					goto unlock_exit;
+				info->running_effect = BTP_EFFECT_NONE;
+			}
+	}
+
+unlock_exit:
+	spin_unlock(&btp_lock);
+	return ret; 
+}
+
+static int inline btp_new_effect_id(void)
+{
+	static atomic_t effect_id= ATOMIC_INIT(0);
+	
+	atomic_inc(&effect_id);
+	return atomic_read(&effect_id);
+}
+
+static int btp_upload_effect(struct input_dev *dev, struct ff_effect *effect)
+{
+	struct hid_input *hidinput;
+	struct usb_btp_info *info;
+	int offset;
+
+	hidinput = hidinput_simple_inputdev_to_hidinput(dev);
+	if (!hidinput) {
+		return -ENODEV;
+	}
+	offset = effect->type - FF_RUMBLE;
+	effect->id = ((effect->id != -1) ?: btp_new_effect_id());
+	if (offset>=0 && offset<8) {
+		spin_lock(&btp_lock);
+		info = hidinput->private;
+		if (!info || IS_BTP_DISCONNECTING(info)) {
+			spin_unlock(&btp_lock);
+			return -ENODEV;
+		}
+		memcpy(info->effects+offset, effect, sizeof(struct ff_effect));
+		spin_unlock(&btp_lock);
+		usb_btp_update_effect(hidinput, effect->type);
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int btp_erase_effect(struct input_dev *dev, int effect_id)
+{	
+	struct hid_input *hidinput;
+	struct usb_btp_info *info;
+	int offset, ret=0;
+
+	hidinput = hidinput_simple_inputdev_to_hidinput(dev);
+	if (!hidinput) {
+		return -ENODEV;
+	}
+
+	spin_lock(&btp_lock);
+	info = hidinput->private;
+	if (!info || IS_BTP_DISCONNECTING(info)) {
+		spin_unlock(&btp_lock);
+		return -ENODEV;
+	}
+	for (offset=0; offset<8; ++offset) {
+		if (effect_id == info->effects[offset].id) {
+			memset(info->effects+offset, 0, sizeof(struct ff_effect));
+			break;
+		}
+	}
+	spin_unlock(&btp_lock);
+	usb_btp_update_effect(hidinput, offset);
+	return ret;
+}
+
+static struct hidinput_simple_driver btp_driver = {
+	__SIMPLE_DRIVER_INIT
+	.name = driver_name,
+	.connect = btp_connect,
+	.disconnect = btp_disconnect,
+	.ff_event = btp_ff_event,
+	.upload_effect = btp_upload_effect,
+	.erase_effect = btp_erase_effect,
+	.id_table = btp_id_table,
+	.usage_page_table = btp_ff_usage_page_blockes,
+	.private = NULL,
+};
+
+static int __init btp_init(void)
+{
+	return hidinput_register_simple_driver(&btp_driver);
+}
+
+static void __exit btp_exit(void)
+{
+	hidinput_unregister_simple_driver(&btp_driver);
+}
+
+module_init(btp_init);
+module_exit(btp_exit);
+
+MODULE_LICENSE("GPL");



