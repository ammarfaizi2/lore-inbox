Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWJ1SzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWJ1SzS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWJ1SzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:55:18 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:6783 "EHLO
	mo-p07-ob.rzone.de") by vger.kernel.org with ESMTP id S932091AbWJ1SzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:55:16 -0400
Date: Sat, 28 Oct 2006 20:55:03 +0200 (MEST)
From: Oliver Neukum <oliver@neukum.name>
To: Sergey Vlasov <vsu@altlinux.ru>, Soeren Sonnenburg <kernel@nn7.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: [linux-usb-devel] usb initialization order (usbhid vs. appletouch)
User-Agent: KMail/1.8.2
Cc: linux-usb-devel@lists.sourceforge.net
References: <1161856438.5214.2.camel@no.intranet.wo.rk> <1162054576.3769.15.camel@localhost> <200610282043.59106.oliver@neukum.org>
In-Reply-To: <200610282043.59106.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610282055.29423.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Sergey Vlasov <vsu@altlinux.ru>
> Subject: usbhid: Add HID_QUIRK_IGNORE_MOUSE flag
> 
> Some HID devices by Apple have both keyboard and mouse interfaces; the
> keyboard interface is handled by usbhid, but the mouse (really
> touchpad) interface must be handled by the separate 'appletouch'
> driver.  Using HID_QUIRK_IGNORE will make hiddev ignore both
> interfaces, therefore a new quirk flag to ignore only the mouse
> interface is required.

Exactly. Combing both patches:
Soeren, if this works, please sign it off and send it to Greg.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
index 0549ec9..0745fcb 100644
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -1626,8 +1626,16 @@ #define USB_DEVICE_ID_LD_POWERCONTROL	0x
 #define USB_DEVICE_ID_LD_MACHINETEST	0x2040
 
 #define USB_VENDOR_ID_APPLE		0x05ac
+
+#define USB_DEVICE_ID_APPLE_GEYSER_ANSI	0x0214
+#define USB_DEVICE_ID_APPLE_GEYSER_ISO	0x0215
+#define USB_DEVICE_ID_APPLE_GEYSER_JIS	0x0216
+#define USB_DEVICE_ID_APPLE_GEYSER3_ANSI	0x0217
+#define USB_DEVICE_ID_APPLE_GEYSER3_ISO	0x0218
+#define USB_DEVICE_ID_APPLE_GEYSER3_JIS	0x0219
 #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE	0x0304
 
+
 #define USB_VENDOR_ID_CHERRY		0x046a
 #define USB_DEVICE_ID_CHERRY_CYMOTION	0x0023
 
@@ -1801,6 +1809,18 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },
 
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI, HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ISO, HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_JIS, HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI, HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO, HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS, HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, 0x020E, HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, 0x020F, HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_IGNORE_MOUSE },
+
+
 	{ USB_VENDOR_ID_PANJIT, 0x0001, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_PANJIT, 0x0002, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_PANJIT, 0x0003, HID_QUIRK_IGNORE },
@@ -1897,6 +1917,9 @@ static struct hid_device *usb_hid_config
 
 	if (quirks & HID_QUIRK_IGNORE)
 		return NULL;
+	if (quirks & HID_QUIRK_IGNORE_MOUSE)
+		if (interface->desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_MOUSE)
+			return NULL;
 
 	if (usb_get_extra_descriptor(interface, HID_DT_HID, &hdesc) &&
 	    (!interface->desc.bNumEndpoints ||
diff --git a/drivers/usb/input/hid.h b/drivers/usb/input/hid.h
index 9b50eff..abd7b52 100644
--- a/drivers/usb/input/hid.h
+++ b/drivers/usb/input/hid.h
@@ -260,6 +260,7 @@ #define HID_QUIRK_CYMOTION			0x00000800
 #define HID_QUIRK_POWERBOOK_HAS_FN		0x00001000
 #define HID_QUIRK_POWERBOOK_FN_ON		0x00002000
 #define HID_QUIRK_INVERT_HWHEEL			0x00004000
+#define HID_QUIRK_IGNORE_MOUSE			0x00008000
 
 /*
  * This is the global environment of the parser. This information is
