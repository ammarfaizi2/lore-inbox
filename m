Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267085AbTBLK5K>; Wed, 12 Feb 2003 05:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267079AbTBLKzt>; Wed, 12 Feb 2003 05:55:49 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:24713 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267048AbTBLKyT>;
	Wed, 12 Feb 2003 05:54:19 -0500
Date: Wed, 12 Feb 2003 12:03:59 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: HID update [7/14]
Message-ID: <20030212120359.F1563@ucw.cz>
References: <20030212115954.A1268@ucw.cz> <20030212120038.A1563@ucw.cz> <20030212120119.B1563@ucw.cz> <20030212120154.C1563@ucw.cz> <20030212120242.D1563@ucw.cz> <20030212120321.E1563@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030212120321.E1563@ucw.cz>; from vojtech@suse.cz on Wed, Feb 12, 2003 at 12:03:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1010, 2003-02-12 10:55:13+01:00, vojtech@suse.cz
  input: HID update
  	- Fix a bad #define for HID_QUIRK_BADPAD
  	- Set absfuzz and absflat for joysticks/gamepads only
  	- Add TangTop quirk


 hid-core.c  |    6 ++++++
 hid-input.c |    9 +++++++--
 hid.h       |    2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Wed Feb 12 11:56:57 2003
+++ b/drivers/usb/input/hid-core.c	Wed Feb 12 11:56:57 2003
@@ -1327,6 +1327,9 @@
 #define USB_VENDOR_ID_ONTRAK		0x0a07
 #define USB_DEVICE_ID_ONTRAK_ADU100	0x0064
 
+#define USB_VENDOR_ID_TANGTOP          0x0d3d
+#define USB_DEVICE_ID_TANGTOP_USBPS2   0x0001
+
 struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1368,6 +1371,7 @@
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 300, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 400, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 500, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_TANGTOP, USB_DEVICE_ID_TANGTOP_USBPS2, HID_QUIRK_NOGET },
 	{ 0, 0 }
 };
 
@@ -1533,6 +1537,8 @@
 	kfree(buf);
 
 	hid->urbctrl = usb_alloc_urb(0, GFP_KERNEL);
+	if (!hid->urbctrl)
+		goto fail;
 	usb_fill_control_urb(hid->urbctrl, dev, 0, (void *) hid->cr,
 			     hid->ctrlbuf, 1, hid_ctrl, hid);
 	hid->urbctrl->setup_dma = hid->cr_dma;
diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	Wed Feb 12 11:56:57 2003
+++ b/drivers/usb/input/hid-input.c	Wed Feb 12 11:56:57 2003
@@ -364,8 +364,13 @@
 		
 		input->absmin[usage->code] = a;
 		input->absmax[usage->code] = b;
-		input->absfuzz[usage->code] = (b - a) >> 8;
-		input->absflat[usage->code] = (b - a) >> 4;
+		input->absfuzz[usage->code] = 0;
+		input->absflat[usage->code] = 0;
+
+		if (field->application == HID_GD_GAMEPAD || field->application == HID_GD_JOYSTICK) {
+			input->absfuzz[usage->code] = (b - a) >> 8;
+			input->absflat[usage->code] = (b - a) >> 4;
+		}
 	}
 
 	if (usage->hat_min != usage->hat_max) {
diff -Nru a/drivers/usb/input/hid.h b/drivers/usb/input/hid.h
--- a/drivers/usb/input/hid.h	Wed Feb 12 11:56:57 2003
+++ b/drivers/usb/input/hid.h	Wed Feb 12 11:56:57 2003
@@ -206,7 +206,7 @@
 #define HID_QUIRK_IGNORE	0x04
 #define HID_QUIRK_NOGET		0x08
 #define HID_QUIRK_HIDDEV	0x10
-#define HID_QUIRK_BADPAD        0x12
+#define HID_QUIRK_BADPAD        0x20
 
 /*
  * This is the global enviroment of the parser. This information is
