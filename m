Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVAHG0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVAHG0l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVAHGUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:20:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:30854 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261946AbVAHFsx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:53 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632683091@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:49 -0800
Message-Id: <11051632692510@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.45, 2004/12/20 14:20:30-08:00, stern@rowland.harvard.edu

[PATCH] USB: Create usb_hcd structures within usbcore [6/13]

This patch alters the dummy_hcd driver, removing the routine that
allocates the hcd structure and introducing inline functions to convert
safely between the public and private hcd structures.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/gadget/dummy_hcd.c |   44 +++++++++++++----------------------------
 1 files changed, 14 insertions(+), 30 deletions(-)


diff -Nru a/drivers/usb/gadget/dummy_hcd.c b/drivers/usb/gadget/dummy_hcd.c
--- a/drivers/usb/gadget/dummy_hcd.c	2005-01-07 15:43:14 -08:00
+++ b/drivers/usb/gadget/dummy_hcd.c	2005-01-07 15:43:14 -08:00
@@ -149,7 +149,6 @@
 };
 
 struct dummy {
-	struct usb_hcd			hcd;		/* must come first! */
 	spinlock_t			lock;
 
 	/*
@@ -178,12 +177,17 @@
 
 static inline struct dummy *hcd_to_dummy (struct usb_hcd *hcd)
 {
-	return container_of(hcd, struct dummy, hcd);
+	return (struct dummy *) (hcd->hcd_priv);
+}
+
+static inline struct usb_hcd *dummy_to_hcd (struct dummy *dum)
+{
+	return container_of((void *) dum, struct usb_hcd, hcd_priv);
 }
 
 static inline struct device *dummy_dev (struct dummy *dum)
 {
-	return dum->hcd.self.controller;
+	return dummy_to_hcd(dum)->self.controller;
 }
 
 static inline struct dummy *ep_to_dummy (struct dummy_ep *ep)
@@ -1368,7 +1372,7 @@
 			ep->already_seen = ep->setup_stage = 0;
 
 		spin_unlock (&dum->lock);
-		usb_hcd_giveback_urb (&dum->hcd, urb, 0);
+		usb_hcd_giveback_urb (dummy_to_hcd(dum), urb, 0);
 		spin_lock (&dum->lock);
 
 		goto restart;
@@ -1570,20 +1574,6 @@
 
 /*-------------------------------------------------------------------------*/
 
-static struct usb_hcd *dummy_alloc (void)
-{
-	struct dummy		*dum;
-
-	dum = kmalloc (sizeof *dum, SLAB_KERNEL);
-	if (dum == NULL)
-		return NULL;
-	the_controller = dum;
-	memset (dum, 0, sizeof *dum);
-	return &dum->hcd;
-}
-
-/*-------------------------------------------------------------------------*/
-
 static inline ssize_t
 show_urb (char *buf, size_t size, struct urb *urb)
 {
@@ -1711,13 +1701,14 @@
 
 static const struct hc_driver dummy_hcd = {
 	.description =		(char *) driver_name,
+	.product_desc =		"Dummy host controller",
+	.hcd_priv_size =	sizeof(struct dummy),
+
 	.flags =		HCD_USB2,
 
 	.start =		dummy_start,
 	.stop =			dummy_stop,
 
-	.hcd_alloc = 		dummy_alloc,
-
 	.urb_enqueue = 		dummy_urb_enqueue,
 	.urb_dequeue = 		dummy_urb_dequeue,
 
@@ -1737,7 +1728,7 @@
 
 	dev_info (dev, "%s, driver " DRIVER_VERSION "\n", driver_desc);
 
-	hcd = dummy_alloc ();
+	hcd = usb_create_hcd (&dummy_hcd);
 	if (hcd == NULL) {
 		dev_dbg (dev, "hcd_alloc failed\n");
 		return -ENOMEM;
@@ -1745,9 +1736,8 @@
 
 	dev_set_drvdata (dev, hcd);
 	dum = hcd_to_dummy (hcd);
+	the_controller = dum;
 
-	hcd->driver = (struct hc_driver *) &dummy_hcd;
-	hcd->description = dummy_hcd.description;
 	hcd->self.controller = dev;
 
 	/* FIXME don't require the pci-based buffer/alloc impls;
@@ -1760,13 +1750,7 @@
 		goto err1;
 	}
 
-	usb_bus_init (&hcd->self);
-	hcd->self.op = &usb_hcd_operations;
-	hcd->self.release = &usb_hcd_release;
-	hcd->self.hcpriv = hcd;
 	hcd->self.bus_name = dev->bus_id;
-	hcd->product_desc = "Dummy host controller";
-
 	usb_register_bus (&hcd->self);
 
 	if ((retval = dummy_start (hcd)) < 0) 
@@ -1774,7 +1758,7 @@
 	return retval;
 
 err1:
-	kfree (hcd);
+	usb_put_hcd (hcd);
 	dev_set_drvdata (dev, NULL);
 	return retval;
 }

