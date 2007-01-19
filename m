Return-Path: <linux-kernel-owner+w=401wt.eu-S932834AbXASSiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932834AbXASSiT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 13:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932835AbXASSiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 13:38:19 -0500
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:59220 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932834AbXASSiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 13:38:18 -0500
X-Greylist: delayed 4185 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jan 2007 13:38:18 EST
Message-ID: <45B0FFB1.3000900@gmail.com>
Date: Fri, 19 Jan 2007 19:28:17 +0200
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070105)
MIME-Version: 1.0
To: Jiri Kosina <jkosina@suse.cz>
CC: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       linux-input@atrey.karlin.mff.cuni.cz,
       LKML <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [patch] hid: put usb_interface instead of usb_device into hid->dev
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 4916b3a57fc94664677d439b911b8aaf86c7ec23 introduced a
hid regression between 2.6.19 and 2.6.20-rc1. The device put in
input_dev->cdev is now of type usb_device instead of usb_interface.

Before:
> # readlink -f /sys/class/input/input6/event4/device
> /sys/devices/pci0000:00/0000:00:10.0/usb2/2-1/2-1:1.1
After:
> # readlink -f /sys/class/input/input3/event3/device
> /sys/devices/pci0000:00/0000:00:10.0/usb1/1-1

This causes breakage:
> # udevinfo -q all -n /dev/input/event3
> P: /class/input/input3/event3
> N: input/event3
> S: input/by-path/pci-1-1--event-
> E: ID_SERIAL=noserial
> E: ID_PATH=pci-1-1-

No ID_MODEL, ID_VENDOR, ID_REVISION, ID_TYPE etc etc.

Fix this by assigning the intf->dev into hid->dev, and fixing
all the users.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---

I recommend this fix to go to the stable tree before 2.6.20 is released.



diff -Nurp -x '*.mod' -x '*~' linux-2.6.20-rc4-git5-promise-sata-pata-old/drivers/usb/input/hid-core.c linux-2.6.20-rc4-git5-promise-sata-pata/drivers/usb/input/hid-core.c
--- linux-2.6.20-rc4-git5-promise-sata-pata-old/drivers/usb/input/hid-core.c	2007-01-12 16:16:18.000000000 +0200
+++ linux-2.6.20-rc4-git5-promise-sata-pata/drivers/usb/input/hid-core.c	2007-01-19 18:58:55.000000000 +0200
@@ -106,18 +106,18 @@ static void hid_reset(struct work_struct
 
 	if (test_bit(HID_CLEAR_HALT, &usbhid->iofl)) {
 		dev_dbg(&usbhid->intf->dev, "clear halt\n");
-		rc = usb_clear_halt(to_usb_device(hid->dev), usbhid->urbin->pipe);
+		rc = usb_clear_halt(hid_to_usb_dev(hid), usbhid->urbin->pipe);
 		clear_bit(HID_CLEAR_HALT, &usbhid->iofl);
 		hid_start_in(hid);
 	}
 
 	else if (test_bit(HID_RESET_PENDING, &usbhid->iofl)) {
 		dev_dbg(&usbhid->intf->dev, "resetting device\n");
-		rc = rc_lock = usb_lock_device_for_reset(to_usb_device(hid->dev), usbhid->intf);
+		rc = rc_lock = usb_lock_device_for_reset(hid_to_usb_dev(hid), usbhid->intf);
 		if (rc_lock >= 0) {
-			rc = usb_reset_composite_device(to_usb_device(hid->dev), usbhid->intf);
+			rc = usb_reset_composite_device(hid_to_usb_dev(hid), usbhid->intf);
 			if (rc_lock)
-				usb_unlock_device(to_usb_device(hid->dev));
+				usb_unlock_device(hid_to_usb_dev(hid));
 		}
 		clear_bit(HID_RESET_PENDING, &usbhid->iofl);
 	}
@@ -129,8 +129,8 @@ static void hid_reset(struct work_struct
 		break;
 	default:
 		err("can't reset device, %s-%s/input%d, status %d",
-				to_usb_device(hid->dev)->bus->bus_name,
-				to_usb_device(hid->dev)->devpath,
+				hid_to_usb_dev(hid)->bus->bus_name,
+				hid_to_usb_dev(hid)->devpath,
 				usbhid->ifnum, rc);
 		/* FALLTHROUGH */
 	case -EHOSTUNREACH:
@@ -217,8 +217,8 @@ static void hid_irq_in(struct urb *urb)
 		clear_bit(HID_IN_RUNNING, &usbhid->iofl);
 		if (status != -EPERM) {
 			err("can't resubmit intr, %s-%s/input%d, status %d",
-					to_usb_device(hid->dev)->bus->bus_name,
-					to_usb_device(hid->dev)->devpath,
+					hid_to_usb_dev(hid)->bus->bus_name,
+					hid_to_usb_dev(hid)->devpath,
 					usbhid->ifnum, status);
 			hid_io_error(hid);
 		}
@@ -251,7 +251,7 @@ static int hid_submit_out(struct hid_dev
 
 	hid_output_report(report, usbhid->outbuf);
 	usbhid->urbout->transfer_buffer_length = ((report->size - 1) >> 3) + 1 + (report->id > 0);
-	usbhid->urbout->dev = to_usb_device(hid->dev);
+	usbhid->urbout->dev = hid_to_usb_dev(hid);
 
 	dbg("submitting out urb");
 
@@ -276,13 +276,13 @@ static int hid_submit_ctrl(struct hid_de
 	len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
 	if (dir == USB_DIR_OUT) {
 		hid_output_report(report, usbhid->ctrlbuf);
-		usbhid->urbctrl->pipe = usb_sndctrlpipe(to_usb_device(hid->dev), 0);
+		usbhid->urbctrl->pipe = usb_sndctrlpipe(hid_to_usb_dev(hid), 0);
 		usbhid->urbctrl->transfer_buffer_length = len;
 	} else {
 		int maxpacket, padlen;
 
-		usbhid->urbctrl->pipe = usb_rcvctrlpipe(to_usb_device(hid->dev), 0);
-		maxpacket = usb_maxpacket(to_usb_device(hid->dev), usbhid->urbctrl->pipe, 0);
+		usbhid->urbctrl->pipe = usb_rcvctrlpipe(hid_to_usb_dev(hid), 0);
+		maxpacket = usb_maxpacket(hid_to_usb_dev(hid), usbhid->urbctrl->pipe, 0);
 		if (maxpacket > 0) {
 			padlen = (len + maxpacket - 1) / maxpacket;
 			padlen *= maxpacket;
@@ -292,7 +292,7 @@ static int hid_submit_ctrl(struct hid_de
 			padlen = 0;
 		usbhid->urbctrl->transfer_buffer_length = padlen;
 	}
-	usbhid->urbctrl->dev = to_usb_device(hid->dev);
+	usbhid->urbctrl->dev = hid_to_usb_dev(hid);
 
 	usbhid->cr->bRequestType = USB_TYPE_CLASS | USB_RECIP_INTERFACE | dir;
 	usbhid->cr->bRequest = (dir == USB_DIR_OUT) ? HID_REQ_SET_REPORT : HID_REQ_GET_REPORT;
@@ -1187,7 +1187,7 @@ static struct hid_device *usb_hid_config
 
 	hid->version = le16_to_cpu(hdesc->bcdHID);
 	hid->country = hdesc->bCountryCode;
-	hid->dev = &dev->dev;
+	hid->dev = &intf->dev;
 	usbhid->intf = intf;
 	usbhid->ifnum = interface->desc.bInterfaceNumber;
 
@@ -1282,7 +1282,7 @@ static void hid_disconnect(struct usb_in
 	usb_free_urb(usbhid->urbctrl);
 	usb_free_urb(usbhid->urbout);
 
-	hid_free_buffers(to_usb_device(hid->dev), hid);
+	hid_free_buffers(hid_to_usb_dev(hid), hid);
 	hid_free_device(hid);
 }
 
diff -Nurp -x '*.mod' -x '*~' linux-2.6.20-rc4-git5-promise-sata-pata-old/drivers/usb/input/hiddev.c linux-2.6.20-rc4-git5-promise-sata-pata/drivers/usb/input/hiddev.c
--- linux-2.6.20-rc4-git5-promise-sata-pata-old/drivers/usb/input/hiddev.c	2007-01-12 16:16:18.000000000 +0200
+++ linux-2.6.20-rc4-git5-promise-sata-pata/drivers/usb/input/hiddev.c	2007-01-19 18:58:51.000000000 +0200
@@ -384,7 +384,7 @@ static int hiddev_ioctl(struct inode *in
 	struct hiddev_list *list = file->private_data;
 	struct hiddev *hiddev = list->hiddev;
 	struct hid_device *hid = hiddev->hid;
-	struct usb_device *dev = to_usb_device(hid->dev);
+	struct usb_device *dev = hid_to_usb_dev(hid);
 	struct hiddev_collection_info cinfo;
 	struct hiddev_report_info rinfo;
 	struct hiddev_field_info finfo;
diff -Nurp -x '*.mod' -x '*~' linux-2.6.20-rc4-git5-promise-sata-pata-old/drivers/usb/input/hid-ff.c linux-2.6.20-rc4-git5-promise-sata-pata/drivers/usb/input/hid-ff.c
--- linux-2.6.20-rc4-git5-promise-sata-pata-old/drivers/usb/input/hid-ff.c	2007-01-12 16:16:18.000000000 +0200
+++ linux-2.6.20-rc4-git5-promise-sata-pata/drivers/usb/input/hid-ff.c	2007-01-19 19:08:14.000000000 +0200
@@ -33,6 +33,7 @@
 #include <linux/usb.h>
 
 #include <linux/hid.h>
+#include "usbhid.h"
 
 /*
  * This table contains pointers to initializers. To add support for new
@@ -70,8 +71,8 @@ static struct hid_ff_initializer inits[]
 int hid_ff_init(struct hid_device* hid)
 {
 	struct hid_ff_initializer *init;
-	int vendor = le16_to_cpu(to_usb_device(hid->dev)->descriptor.idVendor);
-	int product = le16_to_cpu(to_usb_device(hid->dev)->descriptor.idProduct);
+	int vendor = le16_to_cpu(hid_to_usb_dev(hid)->descriptor.idVendor);
+	int product = le16_to_cpu(hid_to_usb_dev(hid)->descriptor.idProduct);
 
 	for (init = inits; init->idVendor; init++)
 		if (init->idVendor == vendor && init->idProduct == product)
diff -Nurp -x '*.mod' -x '*~' linux-2.6.20-rc4-git5-promise-sata-pata-old/drivers/usb/input/usbhid.h linux-2.6.20-rc4-git5-promise-sata-pata/drivers/usb/input/usbhid.h
--- linux-2.6.20-rc4-git5-promise-sata-pata-old/drivers/usb/input/usbhid.h	2007-01-12 16:16:18.000000000 +0200
+++ linux-2.6.20-rc4-git5-promise-sata-pata/drivers/usb/input/usbhid.h	2007-01-19 18:57:52.000000000 +0200
@@ -80,5 +80,8 @@ struct usbhid_device {
 
 };
 
+#define	hid_to_usb_dev(hid_dev) \
+	container_of(hid_dev->dev->parent, struct usb_device, dev)
+
 #endif
 


-- 
Anssi Hannula


