Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVDRQlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVDRQlx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 12:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVDRQlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 12:41:53 -0400
Received: from post.hexten.net ([65.254.52.58]:61883 "EHLO post.hexten.net")
	by vger.kernel.org with ESMTP id S262085AbVDRQlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 12:41:47 -0400
Mime-Version: 1.0 (Apple Message framework v622)
Content-Transfer-Encoding: 7bit
Message-Id: <37b978ceccdb5fbea39a925ea9eaa2cb@hexten.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Andy Armstrong <andy@hexten.net>
Subject: [PATCH 2.6.11.7 1/2] USB HID: Patch for Cherry CyMotion Linux keyboard
Date: Mon, 18 Apr 2005 17:41:46 +0100
X-Mailer: Apple Mail (2.622)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those who haven't seen it the Cherry CyMotion Linux keyboard is a 
decent quality keyboard with the Windows specific keys replaced with 
Linux keys. It's got a nice little picture of Tux on it too. The 
supplied patches aren't suitable for current kernels so I've bashed 
their patches into a suitable form.

The special case in hid_get_class_descriptor() (which necessitated 
moving that function after the #defines for vendor and device ID) is 
lifted directly from the code Cherry supply. I'm not certain that's the 
best place for it but I don't know the USB HID architecture well enough 
to know what else to do with it. Suggestions welcome.

diff -ur linux-2.6.11.7.orig/drivers/usb/input/hid-core.c 
linux/drivers/usb/input/hid-core.c
--- linux-2.6.11.7.orig/drivers/usb/input/hid-core.c	2005-04-07 
19:57:43.000000000 +0100
+++ linux/drivers/usb/input/hid-core.c	2005-04-18 13:34:59.000000000 
+0100
@@ -1291,22 +1291,6 @@
  	return 0;
  }

-static int hid_get_class_descriptor(struct usb_device *dev, int ifnum,
-		unsigned char type, void *buf, int size)
-{
-	int result, retries = 4;
-
-	memset(buf,0,size);	// Make sure we parse really received data
-
-	do {
-		result = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
-				USB_REQ_GET_DESCRIPTOR, USB_RECIP_INTERFACE | USB_DIR_IN,
-				(type << 8), ifnum, buf, size, HZ * USB_CTRL_GET_TIMEOUT);
-		retries--;
-	} while (result < size && retries);
-	return result;
-}
-
  int hid_open(struct hid_device *hid)
  {
  	if (hid->open++)
@@ -1494,6 +1478,9 @@
  #define USB_VENDOR_ID_DELORME		0x1163
  #define USB_DEVICE_ID_DELORME_EARTHMATE 0x0100

+#define USB_VENDOR_ID_CHERRY            0x046a
+#define USB_DEVICE_ID_CHERRY_CYMOTION   0x0023
+
  static struct hid_blacklist {
  	__u16 idVendor;
  	__u16 idProduct;
@@ -1589,6 +1576,37 @@
  	{ 0, 0 }
  };

+static int hid_get_class_descriptor(struct usb_device *dev, int ifnum,
+		unsigned char type, void *buf, int size)
+{
+	int result, retries = 4;
+        char *p = (char*)buf;
+
+	memset(buf,0,size);	// Make sure we parse really received data
+
+	do {
+		result = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
+				USB_REQ_GET_DESCRIPTOR, USB_RECIP_INTERFACE | USB_DIR_IN,
+				(type << 8), ifnum, buf, size, HZ * USB_CTRL_GET_TIMEOUT);
+		retries--;
+	} while (result < size && retries);
+
+        // wn_hack: patch wrong descriptor for this device
+        // hardware sends wrong descriptor
+        // AA, 20050418: should this test be skipped altogether if 
result < size?
+        if (dev->descriptor.idVendor == USB_VENDOR_ID_CHERRY
+                && dev->descriptor.idProduct == 
USB_DEVICE_ID_CHERRY_CYMOTION
+                && result > 12
+                && p[11] == 0x3c
+                && p[12] == 0x02) {
+            printk(KERN_DEBUG __FILE__ " : modifying descriptor for 
Cherry CyMotion keyboard \n");
+            p[11] = p[16] = 0xff;
+            p[12] = p[17] = 0x03;
+        }
+
+	return result;
+}
+
  static int hid_alloc_buffers(struct usb_device *dev, struct hid_device 
*hid)
  {
  	if (!(hid->inbuf = usb_buffer_alloc(dev, HID_BUFFER_SIZE, 
SLAB_ATOMIC, &hid->inbuf_dma)))

-- 
Andy Armstrong, hexten.net

