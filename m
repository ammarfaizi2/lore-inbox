Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWANQBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWANQBK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWANQBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:01:10 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:44637 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932285AbWANQBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:01:09 -0500
Message-Id: <20060114154832.759176000.dtor_core@ameritech.net>
References: <20060114151645.035957000.dtor_core@ameritech.net>
Date: Sat, 14 Jan 2006 10:16:47 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [git pull 2/7] HID: Add support for Cherry Cymotion keyboard
Content-Disposition: inline; filename=cherry-cymotion-support.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vojtech Pavlik <vojtech@suse.cz>

Input: HID - add support for Cherry Cymotion keyboard

The Cherry Cymotion is a special Linux keyboard made by Cherry, with
only one little problem: it doesn't work with Linux. This patch
(originally by hexten.net, cleaned up by me) makes it work including
all the special keys.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/input/hid-core.c  |   22 ++++++++++++++++++++++
 drivers/usb/input/hid-input.c |    8 ++++++++
 drivers/usb/input/hid.h       |    1 +
 3 files changed, 31 insertions(+)

Index: work/drivers/usb/input/hid-core.c
===================================================================
--- work.orig/drivers/usb/input/hid-core.c
+++ work/drivers/usb/input/hid-core.c
@@ -1450,6 +1450,9 @@ void hid_init_reports(struct hid_device 
 #define USB_VENDOR_ID_APPLE		0x05ac
 #define USB_DEVICE_ID_APPLE_POWERMOUSE	0x0304
 
+#define USB_VENDOR_ID_CHERRY		0x046a
+#define USB_DEVICE_ID_CHERRY_CYMOTION	0x0023
+
 /*
  * Alphabetically sorted blacklist by quirk type.
  */
@@ -1580,6 +1583,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
 
+	{ USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION, HID_QUIRK_CYMOTION },
+
 	{ 0, 0 }
 };
 
@@ -1626,6 +1631,20 @@ static void hid_free_buffers(struct usb_
 		usb_buffer_free(dev, hid->bufsize, hid->ctrlbuf, hid->ctrlbuf_dma);
 }
 
+/*
+ * Cherry Cymotion keyboard have an invalid HID report descriptor,
+ * that needs fixing before we can parse it.
+ */
+
+static void hid_fixup_cymotion_descriptor(char *rdesc, int rsize)
+{
+	if (rsize >= 17 && rdesc[11] == 0x3c && rdesc[12] == 0x02) {
+		info("Fixing up Cherry Cymotion report descriptor");
+		rdesc[11] = rdesc[16] = 0xff;
+		rdesc[12] = rdesc[17] = 0x03;
+	}
+}
+
 static struct hid_device *usb_hid_configure(struct usb_interface *intf)
 {
 	struct usb_host_interface *interface = intf->cur_altsetting;
@@ -1673,6 +1692,9 @@ static struct hid_device *usb_hid_config
 		return NULL;
 	}
 
+	if ((quirks & HID_QUIRK_CYMOTION))
+		hid_fixup_cymotion_descriptor(rdesc, rsize);
+
 #ifdef DEBUG_DATA
 	printk(KERN_DEBUG __FILE__ ": report descriptor (size %u, read %d) = ", rsize, n);
 	for (n = 0; n < rsize; n++)
Index: work/drivers/usb/input/hid-input.c
===================================================================
--- work.orig/drivers/usb/input/hid-input.c
+++ work/drivers/usb/input/hid-input.c
@@ -289,11 +289,19 @@ static void hidinput_configure_usage(str
 				case 0x226: map_key_clear(KEY_STOP);		break;
 				case 0x227: map_key_clear(KEY_REFRESH);		break;
 				case 0x22a: map_key_clear(KEY_BOOKMARKS);	break;
+				case 0x233: map_key_clear(KEY_SCROLLUP);	break;
+				case 0x234: map_key_clear(KEY_SCROLLDOWN);	break;
 				case 0x238: map_rel(REL_HWHEEL);		break;
 				case 0x279: map_key_clear(KEY_REDO);		break;
 				case 0x289: map_key_clear(KEY_REPLY);		break;
 				case 0x28b: map_key_clear(KEY_FORWARDMAIL);	break;
 				case 0x28c: map_key_clear(KEY_SEND);		break;
+
+				/* Reported on a Cherry Cymotion keyboard */
+				case 0x301: map_key_clear(KEY_PROG1);		break;
+				case 0x302: map_key_clear(KEY_PROG2);		break;
+				case 0x303: map_key_clear(KEY_PROG3);		break;
+
 				default:    goto ignore;
 			}
 			break;
Index: work/drivers/usb/input/hid.h
===================================================================
--- work.orig/drivers/usb/input/hid.h
+++ work/drivers/usb/input/hid.h
@@ -246,6 +246,7 @@ struct hid_item {
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x100
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x200
 #define HID_QUIRK_2WHEEL_POWERMOUSE		0x400
+#define HID_QUIRK_CYMOTION			0x800
 
 /*
  * This is the global environment of the parser. This information is

