Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWENEmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWENEmV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 00:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWENEmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 00:42:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:27014 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932368AbWENEmU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 00:42:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aytcnyieyVNaJZY8OM9MImU4jJb4CGKgXLmxsxCqnq9jboQZo7jHtw3aPIO2XVxwBce1QL7/sJAgtzHvfOmonuO646Fbi2r0NunTshfGLEGyStl2PsUOFgwVtNEvGwM3Em/Mo3E92322HHU6LXUyCzfxHjPVe2rZsIoNyPHmjoc=
Message-ID: <305c16960605132142o6b4dd67er6cdeb623c2d65ec9@mail.gmail.com>
Date: Sun, 14 May 2006 01:42:18 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "kernel list" <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] hid-core: Implement generic framework for descriptor patching
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, dtor_core@ameritech.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The motivation for this is that the quirks framework doesnt scale
well. Currently there is only one device needing the descriptor table
to be patched, but as soon as something like this gets accepted, im
going to implement a fixup for my own crappy keyboard, and over time
others will follow.

The reason i decided to pass struct usb_device as a parameter to the
fixup function is that some hardware has multiple input channels, so
just the vendor and product id arent enough to decide if we patch it
or not. I specially need feedback on this, before i add a function
that will need to fixup just one of the channels of my keyboard/mouse
combo.

Thanks to Vojtech Pavlik for the sugestion.


Signed-off-by: Matheus Izvekov <mizvekov@gmail.com>

diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
index 7724780..dfad1a5 100644
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -1593,8 +1593,6 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },

-	{ USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION, HID_QUIRK_CYMOTION },
-
 	{ USB_VENDOR_ID_APPLE, 0x020E, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x020F, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x0214, HID_QUIRK_POWERBOOK_HAS_FN },
@@ -1607,6 +1605,31 @@ static const struct hid_blacklist {
 };

 /*
+ * Cherry Cymotion keyboard have an invalid HID report descriptor,
+ * that needs fixing before we can parse it.
+ */
+
+static void hid_fixup_cymotion_descriptor(char *rdesc, int rsize,
struct usb_device *dev)
+{
+	if (rsize >= 17 && rdesc[11] == 0x3c && rdesc[12] == 0x02) {
+		info("Fixing up Cherry Cymotion report descriptor");
+		rdesc[11] = rdesc[16] = 0xff;
+		rdesc[12] = rdesc[17] = 0x03;
+	}
+}
+
+static const struct hid_desc_fixup_list {
+	__u16 idVendor;
+	__u16 idProduct;
+	void (*fixup)(char *rdesc, int rsize, struct usb_device *dev);
+} hid_desc_fixup_list[] = {
+
+	{ USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION,
hid_fixup_cymotion_descriptor},
+
+	{ 0, 0 }
+};
+
+/*
  * Traverse the supplied list of reports and find the longest
  */
 static void hid_find_max_report(struct hid_device *hid, unsigned int
type, int *max)
@@ -1649,20 +1672,6 @@ static void hid_free_buffers(struct usb_
 		usb_buffer_free(dev, hid->bufsize, hid->ctrlbuf, hid->ctrlbuf_dma);
 }

-/*
- * Cherry Cymotion keyboard have an invalid HID report descriptor,
- * that needs fixing before we can parse it.
- */
-
-static void hid_fixup_cymotion_descriptor(char *rdesc, int rsize)
-{
-	if (rsize >= 17 && rdesc[11] == 0x3c && rdesc[12] == 0x02) {
-		info("Fixing up Cherry Cymotion report descriptor");
-		rdesc[11] = rdesc[16] = 0xff;
-		rdesc[12] = rdesc[17] = 0x03;
-	}
-}
-
 static struct hid_device *usb_hid_configure(struct usb_interface *intf)
 {
 	struct usb_host_interface *interface = intf->cur_altsetting;
@@ -1710,8 +1719,10 @@ static struct hid_device *usb_hid_config
 		return NULL;
 	}

-	if ((quirks & HID_QUIRK_CYMOTION))
-		hid_fixup_cymotion_descriptor(rdesc, rsize);
+	for (n = 0; hid_desc_fixup_list[n].idVendor; n++)
+		if ((hid_desc_fixup_list[n].idVendor ==
le16_to_cpu(dev->descriptor.idVendor)) &&
+			(hid_desc_fixup_list[n].idProduct ==
le16_to_cpu(dev->descriptor.idProduct)))
+				hid_desc_fixup_list[n].fixup(rdesc, rsize, dev);

 #ifdef DEBUG_DATA
 	printk(KERN_DEBUG __FILE__ ": report descriptor (size %u, read %d) =
", rsize, n);
diff --git a/drivers/usb/input/hid.h b/drivers/usb/input/hid.h
index 8b0d434..570116a 100644
--- a/drivers/usb/input/hid.h
+++ b/drivers/usb/input/hid.h
@@ -246,7 +246,6 @@ #define HID_QUIRK_2WHEEL_MOUSE_HACK_7		0
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x00000100
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x00000200
 #define HID_QUIRK_2WHEEL_POWERMOUSE		0x00000400
-#define HID_QUIRK_CYMOTION			0x00000800
 #define HID_QUIRK_POWERBOOK_HAS_FN		0x00001000
 #define HID_QUIRK_POWERBOOK_FN_ON		0x00002000
