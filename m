Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVIJWnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVIJWnj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVIJWmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:42:32 -0400
Received: from styx.suse.cz ([82.119.242.94]:35492 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932355AbVIJWdw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:52 -0400
Subject: [PATCH 15/26] HID - handle multi-transascion reports
In-Reply-To: <1126391653526@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:13 +0200
Message-Id: <11263916532510@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: HID - handle multi-transascion reports
From: Michael Haboustak <mike-@cinci.rr.com>
Date: 1125897121 -0500

Fixes handling of multi-transaction reports for HID devices. New
function hid_size_buffers() that calculates the longest report
for each endpoint and stores the result in the hid_device object.
These lengths are used to allocate buffers that are large enough
to store any report on the endpoint. For compatibility, the minimum
size for an endpoint buffer set to HID_BUFFER_SIZE rather than the
known optimal case (the longest report length).

It fixes bug #3063 in bugzilla.

Signed-off-by: Michael Haboustak <mike-@cinci.rr.com>

I simplified the patch a bit to use just a single buffer size.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/usb/input/hid-core.c |   62 ++++++++++++++++++++++++++++++------------
 drivers/usb/input/hid.h      |    5 +++
 2 files changed, 48 insertions(+), 19 deletions(-)

bf0964dcda97e42964d312d0ff73a832171e080a
diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -2,7 +2,8 @@
  *  USB HID support for Linux
  *
  *  Copyright (c) 1999 Andreas Gal
- *  Copyright (c) 2000-2001 Vojtech Pavlik <vojtech@suse.cz>
+ *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
  */
 
 /*
@@ -38,7 +39,7 @@
  * Version Information
  */
 
-#define DRIVER_VERSION "v2.01"
+#define DRIVER_VERSION "v2.6"
 #define DRIVER_AUTHOR "Andreas Gal, Vojtech Pavlik"
 #define DRIVER_DESC "USB HID core driver"
 #define DRIVER_LICENSE "GPL"
@@ -1058,8 +1059,8 @@ static int hid_submit_ctrl(struct hid_de
 		if (maxpacket > 0) {
 			padlen = (len + maxpacket - 1) / maxpacket;
 			padlen *= maxpacket;
-			if (padlen > HID_BUFFER_SIZE)
-				padlen = HID_BUFFER_SIZE;
+			if (padlen > hid->bufsize)
+				padlen = hid->bufsize;
 		} else
 			padlen = 0;
 		hid->urbctrl->transfer_buffer_length = padlen;
@@ -1284,13 +1285,8 @@ void hid_init_reports(struct hid_device 
 	struct hid_report *report;
 	int err, ret;
 
-	list_for_each_entry(report, &hid->report_enum[HID_INPUT_REPORT].report_list, list) {
-		int size = ((report->size - 1) >> 3) + 1 + hid->report_enum[HID_INPUT_REPORT].numbered;
-		if (size > HID_BUFFER_SIZE) size = HID_BUFFER_SIZE;
-		if (size > hid->urbin->transfer_buffer_length)
-			hid->urbin->transfer_buffer_length = size;
+	list_for_each_entry(report, &hid->report_enum[HID_INPUT_REPORT].report_list, list)
 		hid_submit_report(hid, report, USB_DIR_IN);
-	}
 
 	list_for_each_entry(report, &hid->report_enum[HID_FEATURE_REPORT].report_list, list)
 		hid_submit_report(hid, report, USB_DIR_IN);
@@ -1564,15 +1560,32 @@ static struct hid_blacklist {
 	{ 0, 0 }
 };
 
+/*
+ * Traverse the supplied list of reports and find the longest
+ */
+static void hid_find_max_report(struct hid_device *hid, unsigned int type, int *max)
+{
+	struct hid_report *report;
+	int size;
+
+	list_for_each_entry(report, &hid->report_enum[type].report_list, list) {
+		size = ((report->size - 1) >> 3) + 1;
+		if (type == HID_INPUT_REPORT && hid->report_enum[type].numbered)
+			size++;
+		if (*max < size)
+			*max = size;
+	}
+}
+
 static int hid_alloc_buffers(struct usb_device *dev, struct hid_device *hid)
 {
-	if (!(hid->inbuf = usb_buffer_alloc(dev, HID_BUFFER_SIZE, SLAB_ATOMIC, &hid->inbuf_dma)))
+	if (!(hid->inbuf = usb_buffer_alloc(dev, hid->bufsize, SLAB_ATOMIC, &hid->inbuf_dma)))
 		return -1;
-	if (!(hid->outbuf = usb_buffer_alloc(dev, HID_BUFFER_SIZE, SLAB_ATOMIC, &hid->outbuf_dma)))
+	if (!(hid->outbuf = usb_buffer_alloc(dev, hid->bufsize, SLAB_ATOMIC, &hid->outbuf_dma)))
 		return -1;
 	if (!(hid->cr = usb_buffer_alloc(dev, sizeof(*(hid->cr)), SLAB_ATOMIC, &hid->cr_dma)))
 		return -1;
-	if (!(hid->ctrlbuf = usb_buffer_alloc(dev, HID_BUFFER_SIZE, SLAB_ATOMIC, &hid->ctrlbuf_dma)))
+	if (!(hid->ctrlbuf = usb_buffer_alloc(dev, hid->bufsize, SLAB_ATOMIC, &hid->ctrlbuf_dma)))
 		return -1;
 
 	return 0;
@@ -1581,13 +1594,13 @@ static int hid_alloc_buffers(struct usb_
 static void hid_free_buffers(struct usb_device *dev, struct hid_device *hid)
 {
 	if (hid->inbuf)
-		usb_buffer_free(dev, HID_BUFFER_SIZE, hid->inbuf, hid->inbuf_dma);
+		usb_buffer_free(dev, hid->bufsize, hid->inbuf, hid->inbuf_dma);
 	if (hid->outbuf)
-		usb_buffer_free(dev, HID_BUFFER_SIZE, hid->outbuf, hid->outbuf_dma);
+		usb_buffer_free(dev, hid->bufsize, hid->outbuf, hid->outbuf_dma);
 	if (hid->cr)
 		usb_buffer_free(dev, sizeof(*(hid->cr)), hid->cr, hid->cr_dma);
 	if (hid->ctrlbuf)
-		usb_buffer_free(dev, HID_BUFFER_SIZE, hid->ctrlbuf, hid->ctrlbuf_dma);
+		usb_buffer_free(dev, hid->bufsize, hid->ctrlbuf, hid->ctrlbuf_dma);
 }
 
 static struct hid_device *usb_hid_configure(struct usb_interface *intf)
@@ -1598,7 +1611,7 @@ static struct hid_device *usb_hid_config
 	struct hid_device *hid;
 	unsigned quirks = 0, rsize = 0;
 	char *buf, *rdesc;
-	int n;
+	int n, insize = 0;
 
 	for (n = 0; hid_blacklist[n].idVendor; n++)
 		if ((hid_blacklist[n].idVendor == le16_to_cpu(dev->descriptor.idVendor)) &&
@@ -1652,6 +1665,19 @@ static struct hid_device *usb_hid_config
 	kfree(rdesc);
 	hid->quirks = quirks;
 
+	hid->bufsize = HID_MIN_BUFFER_SIZE;
+	hid_find_max_report(hid, HID_INPUT_REPORT, &hid->bufsize);
+	hid_find_max_report(hid, HID_OUTPUT_REPORT, &hid->bufsize);
+	hid_find_max_report(hid, HID_FEATURE_REPORT, &hid->bufsize);
+
+	if (hid->bufsize > HID_MAX_BUFFER_SIZE)
+		hid->bufsize = HID_MAX_BUFFER_SIZE;
+
+	hid_find_max_report(hid, HID_INPUT_REPORT, &insize);
+
+	if (insize > HID_MAX_BUFFER_SIZE)
+		insize = HID_MAX_BUFFER_SIZE;
+
 	if (hid_alloc_buffers(dev, hid)) {
 		hid_free_buffers(dev, hid);
 		goto fail;
@@ -1682,7 +1708,7 @@ static struct hid_device *usb_hid_config
 			if (!(hid->urbin = usb_alloc_urb(0, GFP_KERNEL)))
 				goto fail;
 			pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
-			usb_fill_int_urb(hid->urbin, dev, pipe, hid->inbuf, 0,
+			usb_fill_int_urb(hid->urbin, dev, pipe, hid->inbuf, insize,
 					 hid_irq_in, hid, interval);
 			hid->urbin->transfer_dma = hid->inbuf_dma;
 			hid->urbin->transfer_flags |=(URB_NO_TRANSFER_DMA_MAP | URB_ASYNC_UNLINK);
diff --git a/drivers/usb/input/hid.h b/drivers/usb/input/hid.h
--- a/drivers/usb/input/hid.h
+++ b/drivers/usb/input/hid.h
@@ -351,7 +351,8 @@ struct hid_report_enum {
 
 #define HID_REPORT_TYPES 3
 
-#define HID_BUFFER_SIZE		64		/* use 64 for compatibility with all possible packetlen */
+#define HID_MIN_BUFFER_SIZE	64		/* make sure there is at least a packet size of space */
+#define HID_MAX_BUFFER_SIZE	4096		/* 4kb */
 #define HID_CONTROL_FIFO_SIZE	256		/* to init devices with >100 reports */
 #define HID_OUTPUT_FIFO_SIZE	64
 
@@ -389,6 +390,8 @@ struct hid_device {							/* device repo
 
 	unsigned long iofl;						/* I/O flags (CTRL_RUNNING, OUT_RUNNING) */
 
+	unsigned int bufsize;						/* URB buffer size */
+
 	struct urb *urbin;						/* Input URB */
 	char *inbuf;							/* Input buffer */
 	dma_addr_t inbuf_dma;						/* Input buffer dma */

