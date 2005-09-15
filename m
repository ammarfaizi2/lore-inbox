Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbVIOHRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbVIOHRH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbVIOHQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:16:57 -0400
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:54947 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030437AbVIOHP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:15:59 -0400
Message-Id: <20050915064944.260368000.dtor_core@ameritech.net>
References: <20050915064552.836273000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 01:46:04 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de>,
Kay Sievers <kay.sievers@vrfy.org>,
Vojtech Pavlik <vojtech@suse.cz>,
Hannes Reinecke <hare@suse.de>
Subject: [patch 12/28] Input: convert onetouch to dynamic input_dev allocation
Content-Disposition: inline; filename=input-dynalloc-onetouch.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Input: convert onetouch to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/storage/onetouch.c |  105 ++++++++++++++++++++---------------------
 1 files changed, 53 insertions(+), 52 deletions(-)

Index: work/drivers/usb/storage/onetouch.c
===================================================================
--- work.orig/drivers/usb/storage/onetouch.c
+++ work/drivers/usb/storage/onetouch.c
@@ -5,7 +5,7 @@
  *	Copyright (c) 2005 Nick Sillik <n.sillik@temple.edu>
  *
  * Initial work by:
- * 	Copyright (c) 2003 Erik Thyren <erth7411@student.uu.se>
+ *	Copyright (c) 2003 Erik Thyren <erth7411@student.uu.se>
  *
  * Based on usbmouse.c (Vojtech Pavlik) and xpad.c (Marko Friedemann)
  *
@@ -46,7 +46,7 @@ void onetouch_release_input(void *onetou
 struct usb_onetouch {
 	char name[128];
 	char phys[64];
-	struct input_dev dev;	/* input device interface */
+	struct input_dev *dev;	/* input device interface */
 	struct usb_device *udev;	/* usb device */
 
 	struct urb *irq;	/* urb for interrupt in report */
@@ -58,7 +58,7 @@ static void usb_onetouch_irq(struct urb 
 {
 	struct usb_onetouch *onetouch = urb->context;
 	signed char *data = onetouch->data;
-	struct input_dev *dev = &onetouch->dev;
+	struct input_dev *dev = onetouch->dev;
 	int status;
 
 	switch (urb->status) {
@@ -74,11 +74,9 @@ static void usb_onetouch_irq(struct urb 
 	}
 
 	input_regs(dev, regs);
-
-	input_report_key(&onetouch->dev, ONETOUCH_BUTTON,
-			 data[0] & 0x02);
-
+	input_report_key(dev, ONETOUCH_BUTTON, data[0] & 0x02);
 	input_sync(dev);
+
 resubmit:
 	status = usb_submit_urb (urb, SLAB_ATOMIC);
 	if (status)
@@ -113,8 +111,8 @@ int onetouch_connect_input(struct us_dat
 	struct usb_host_interface *interface;
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_onetouch *onetouch;
+	struct input_dev *input_dev;
 	int pipe, maxp;
-	char path[64];
 
 	interface = ss->pusb_intf->cur_altsetting;
 
@@ -122,62 +120,62 @@ int onetouch_connect_input(struct us_dat
 		return -ENODEV;
 
 	endpoint = &interface->endpoint[2].desc;
-	if(!(endpoint->bEndpointAddress & USB_DIR_IN))
+	if (!(endpoint->bEndpointAddress & USB_DIR_IN))
 		return -ENODEV;
-	if((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
+	if ((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
 			!= USB_ENDPOINT_XFER_INT)
 		return -ENODEV;
 
 	pipe = usb_rcvintpipe(udev, endpoint->bEndpointAddress);
 	maxp = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
 
-	if (!(onetouch = kcalloc(1, sizeof(struct usb_onetouch), GFP_KERNEL)))
-		return -ENOMEM;
+	onetouch = kzalloc(sizeof(struct usb_onetouch), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!onetouch || !input_dev)
+		goto fail1;
 
 	onetouch->data = usb_buffer_alloc(udev, ONETOUCH_PKT_LEN,
 					  SLAB_ATOMIC, &onetouch->data_dma);
-	if (!onetouch->data){
-		kfree(onetouch);
-		return -ENOMEM;
-	}
+	if (!onetouch->data)
+		goto fail1;
 
 	onetouch->irq = usb_alloc_urb(0, GFP_KERNEL);
-	if (!onetouch->irq){
-		kfree(onetouch);
-		usb_buffer_free(udev, ONETOUCH_PKT_LEN,
-				onetouch->data, onetouch->data_dma);
-		return -ENODEV;
-	}
-
+	if (!onetouch->irq)
+		goto fail2;
 
 	onetouch->udev = udev;
-
-	set_bit(EV_KEY, onetouch->dev.evbit);
-	set_bit(ONETOUCH_BUTTON, onetouch->dev.keybit);
-	clear_bit(0, onetouch->dev.keybit);
-
-	onetouch->dev.private = onetouch;
-	onetouch->dev.open = usb_onetouch_open;
-	onetouch->dev.close = usb_onetouch_close;
-
-	usb_make_path(udev, path, sizeof(path));
-	sprintf(onetouch->phys, "%s/input0", path);
-
-	onetouch->dev.name = onetouch->name;
-	onetouch->dev.phys = onetouch->phys;
-
-	usb_to_input_id(udev, &onetouch->dev.id);
-
-	onetouch->dev.dev = &udev->dev;
+	onetouch->dev = input_dev;
 
 	if (udev->manufacturer)
-		strcat(onetouch->name, udev->manufacturer);
-	if (udev->product)
-		sprintf(onetouch->name, "%s %s", onetouch->name,
-			udev->product);
+		strlcpy(onetouch->name, udev->manufacturer,
+			sizeof(onetouch->name));
+	if (udev->product) {
+		if (udev->manufacturer)
+			strlcat(onetouch->name, " ", sizeof(onetouch->name));
+		strlcat(onetouch->name, udev->product, sizeof(onetouch->name));
+	}
+
 	if (!strlen(onetouch->name))
-		sprintf(onetouch->name, "Maxtor Onetouch %04x:%04x",
-			onetouch->dev.id.vendor, onetouch->dev.id.product);
+		snprintf(onetouch->name, sizeof(onetouch->name),
+			 "Maxtor Onetouch %04x:%04x",
+			 le16_to_cpu(udev->descriptor.idVendor),
+			 le16_to_cpu(udev->descriptor.idProduct));
+
+	usb_make_path(udev, onetouch->phys, sizeof(onetouch->phys));
+	strlcat(onetouch->phys, "/input0", sizeof(onetouch->phys));
+
+	input_dev->name = onetouch->name;
+	input_dev->phys = onetouch->phys;
+	usb_to_input_id(udev, &input_dev->id);
+	input_dev->cdev.dev = &udev->dev;
+
+	set_bit(EV_KEY, input_dev->evbit);
+	set_bit(ONETOUCH_BUTTON, input_dev->keybit);
+	clear_bit(0, input_dev->keybit);
+
+	input_dev->private = onetouch;
+	input_dev->open = usb_onetouch_open;
+	input_dev->close = usb_onetouch_close;
 
 	usb_fill_int_urb(onetouch->irq, udev, pipe, onetouch->data,
 			 (maxp > 8 ? 8 : maxp),
@@ -188,10 +186,15 @@ int onetouch_connect_input(struct us_dat
 	ss->extra_destructor = onetouch_release_input;
 	ss->extra = onetouch;
 
-	input_register_device(&onetouch->dev);
-	printk(KERN_INFO "usb-input: %s on %s\n", onetouch->dev.name, path);
+	input_register_device(onetouch->dev);
 
 	return 0;
+
+ fail2:	usb_buffer_free(udev, ONETOUCH_PKT_LEN,
+			onetouch->data, onetouch->data_dma);
+ fail1:	kfree(onetouch);
+	input_free_device(input_dev);
+	return -ENOMEM;
 }
 
 void onetouch_release_input(void *onetouch_)
@@ -200,11 +203,9 @@ void onetouch_release_input(void *onetou
 
 	if (onetouch) {
 		usb_kill_urb(onetouch->irq);
-		input_unregister_device(&onetouch->dev);
+		input_unregister_device(onetouch->dev);
 		usb_free_urb(onetouch->irq);
 		usb_buffer_free(onetouch->udev, ONETOUCH_PKT_LEN,
 				onetouch->data, onetouch->data_dma);
-		printk(KERN_INFO "usb-input: deregistering %s\n",
-				onetouch->dev.name);
 	}
 }

