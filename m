Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWENWXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWENWXG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 18:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWENWXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 18:23:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:9862 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751189AbWENWXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 18:23:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=TP+3ardWnYMJt40lK1NdBfh/TuQGX7tnvtNCd2sNXBEOnswcGDF6j4kuNp7QvbNtjTtOgZpkGAJf2S4axliYe7dbda1Yzkkm9GtirWu7JyO/HVOi37oudvXAbuZRVyFRek5OXnM9m1horggVMkjeZNF7NNwVqOR3Yekjoxql2IU=
Date: Sun, 14 May 2006 19:23:24 -0300
From: Matheus Izvekov <mizvekov@gmail.com>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, dtor_core@ameritech.net,
       linux-usb-devel@lists.sourceforge.net
Subject: [RFC][PATCH][RESEND] usbhid: Implement generic framework for
 descriptor patching
Message-ID: <20060514192324.58740d0c@localhost>
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The motivation for this is that the quirks framework doesnt scale
well. Currently there is only one device needing the descriptor table
to be patched, but as soon as something like this gets accepted, im
going to implement a fixup for my own crappy keyboard, and over time
others will follow.

Signed-off-by: Matheus Izvekov <mizvekov@gmail.com>
---

The difference from the previous submission is that now instead of passing
usb_device as a parameter to the patching function, im using
usb_device_descriptor (ddesc) and usb_interface_descriptor (idesc),
as i think it was too generic, most users would be interested just in ddesc
and idesc.
The reason for passing idesc is that i will need to do
if (idesc.bInterfaceNumber == 1)
in a patching function, in order to patch just the mouse part of my
mouse/keyboard combo.
The reason for passing ddesc is to make it possible to reuse one function
to patch several devices with different manufacturer and product ids.

Maybe im still too generic here, and passing just idVendor, idProduct and
bInterfaceNumber will be enough for everybody in the future, hence my
request for comments.

Thanks to Vojtech Pavlik for the sugestion of starting this work.

diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
index 7724780..a25ecbb 100644
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
@@ -1607,6 +1605,35 @@ static const struct hid_blacklist {
 };
 
 /*
+ * Cherry Cymotion keyboard have an invalid HID report descriptor,
+ * that needs fixing before we can parse it.
+ */
+
+static void hid_fixup_cymotion_descriptor(char *rdesc, int rsize,
+					struct usb_device_descriptor *ddesc,
+					struct usb_interface_descriptor *idesc)
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
+	void (*fixup)(char *rdesc, int rsize,
+			struct usb_device_descriptor *ddesc,
+			struct usb_interface_descriptor *idesc);
+} hid_desc_fixup_list[] = {
+
+	{ USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION,  hid_fixup_cymotion_descriptor},
+
+	{ 0, 0 }
+};
+
+/*
  * Traverse the supplied list of reports and find the longest
  */
 static void hid_find_max_report(struct hid_device *hid, unsigned int type, int *max)
@@ -1649,20 +1676,6 @@ static void hid_free_buffers(struct usb_
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
@@ -1710,8 +1723,10 @@ static struct hid_device *usb_hid_config
 		return NULL;
 	}
 
-	if ((quirks & HID_QUIRK_CYMOTION))
-		hid_fixup_cymotion_descriptor(rdesc, rsize);
+	for (n = 0; hid_desc_fixup_list[n].idVendor; n++)
+		if ((hid_desc_fixup_list[n].idVendor == le16_to_cpu(dev->descriptor.idVendor)) &&
+			(hid_desc_fixup_list[n].idProduct == le16_to_cpu(dev->descriptor.idProduct)))
+				hid_desc_fixup_list[n].fixup(rdesc, rsize, &dev->descriptor, &interface->desc);
 
 #ifdef DEBUG_DATA
 	printk(KERN_DEBUG __FILE__ ": report descriptor (size %u, read %d) = ", rsize, n);
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
 
