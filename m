Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVAHGx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVAHGx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVAHGuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:50:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:8070 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261915AbVAHFsl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:41 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632661756@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:46 -0800
Message-Id: <11051632662436@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.22, 2004/12/15 16:35:26-08:00, david-b@pacbell.net

[PATCH] USB: remove some now-unused HCD infrastructure (10/15)

This removes the code supporting usb_device->hcpriv allocation/deallocation,
and hcd_dev-dev_list, from usbcore and the HCDs.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/core/hcd-pci.c      |    2 -
 drivers/usb/core/hcd.c          |   74 ----------------------------------------
 drivers/usb/core/usb.c          |    9 ----
 drivers/usb/host/ohci-lh7a404.c |    2 -
 drivers/usb/host/ohci-omap.c    |    1 
 drivers/usb/host/ohci-pxa27x.c  |    2 -
 drivers/usb/host/ohci-sa1111.c  |    2 -
 7 files changed, 92 deletions(-)


diff -Nru a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
--- a/drivers/usb/core/hcd-pci.c	2005-01-07 15:48:43 -08:00
+++ b/drivers/usb/core/hcd-pci.c	2005-01-07 15:48:43 -08:00
@@ -195,8 +195,6 @@
 	hcd->self.hcpriv = (void *) hcd;
 	init_timer (&hcd->rh_timer);
 
-	INIT_LIST_HEAD (&hcd->dev_list);
-
 	usb_register_bus (&hcd->self);
 
 	if ((retval = driver->start (hcd)) < 0) {
diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	2005-01-07 15:48:43 -08:00
+++ b/drivers/usb/core/hcd.c	2005-01-07 15:48:43 -08:00
@@ -1018,40 +1018,6 @@
 
 /*-------------------------------------------------------------------------*/
 
-/* called from khubd, or root hub init threads for hcd-private init */
-static int hcd_alloc_dev (struct usb_device *udev)
-{
-	struct hcd_dev		*dev;
-	struct usb_hcd		*hcd;
-	unsigned long		flags;
-
-	if (!udev || udev->hcpriv)
-		return -EINVAL;
-	if (!udev->bus || !udev->bus->hcpriv)
-		return -ENODEV;
-	hcd = udev->bus->hcpriv;
-	if (hcd->state == USB_STATE_QUIESCING)
-		return -ENOLINK;
-
-	dev = (struct hcd_dev *) kmalloc (sizeof *dev, GFP_KERNEL);
-	if (dev == NULL)
-		return -ENOMEM;
-	memset (dev, 0, sizeof *dev);
-
-	INIT_LIST_HEAD (&dev->dev_list);
-	INIT_LIST_HEAD (&dev->urb_list);
-
-	spin_lock_irqsave (&hcd_data_lock, flags);
-	list_add (&dev->dev_list, &hcd->dev_list);
-	// refcount is implicit
-	udev->hcpriv = dev;
-	spin_unlock_irqrestore (&hcd_data_lock, flags);
-
-	return 0;
-}
-
-/*-------------------------------------------------------------------------*/
-
 static void urb_unlink (struct urb *urb)
 {
 	unsigned long		flags;
@@ -1463,44 +1429,6 @@
 
 /*-------------------------------------------------------------------------*/
 
-/* called by khubd, rmmod, apmd, or other thread for hcd-private cleanup.
- * we're guaranteed that the device is fully quiesced.  also, that each
- * endpoint has been hcd_endpoint_disabled.
- */
-
-static int hcd_free_dev (struct usb_device *udev)
-{
-	struct hcd_dev		*dev;
-	struct usb_hcd		*hcd;
-	unsigned long		flags;
-
-	if (!udev || !udev->hcpriv)
-		return -EINVAL;
-
-	if (!udev->bus || !udev->bus->hcpriv)
-		return -ENODEV;
-
-	// should udev->devnum == -1 ??
-
-	dev = udev->hcpriv;
-	hcd = udev->bus->hcpriv;
-
-	/* device driver problem with refcounts? */
-	if (!list_empty (&dev->urb_list)) {
-		dev_dbg (hcd->self.controller, "free busy dev, %s devnum %d (bug!)\n",
-			hcd->self.bus_name, udev->devnum);
-		return -EINVAL;
-	}
-
-	spin_lock_irqsave (&hcd_data_lock, flags);
-	list_del (&dev->dev_list);
-	udev->hcpriv = NULL;
-	spin_unlock_irqrestore (&hcd_data_lock, flags);
-
-	kfree (dev);
-	return 0;
-}
-
 /*
  * usb_hcd_operations - adapts usb_bus framework to HCD framework (bus glue)
  *
@@ -1509,11 +1437,9 @@
  * bus glue for non-PCI system busses will need to use this.
  */
 struct usb_operations usb_hcd_operations = {
-	.allocate =		hcd_alloc_dev,
 	.get_frame_number =	hcd_get_frame_number,
 	.submit_urb =		hcd_submit_urb,
 	.unlink_urb =		hcd_unlink_urb,
-	.deallocate =		hcd_free_dev,
 	.buffer_alloc =		hcd_buffer_alloc,
 	.buffer_free =		hcd_buffer_free,
 	.disable =		hcd_endpoint_disable,
diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	2005-01-07 15:48:43 -08:00
+++ b/drivers/usb/core/usb.c	2005-01-07 15:48:43 -08:00
@@ -646,8 +646,6 @@
 
 	udev = to_usb_device(dev);
 
-	if (udev->bus && udev->bus->op && udev->bus->op->deallocate)
-		udev->bus->op->deallocate(udev);
 	usb_destroy_configuration(udev);
 	usb_bus_put(udev->bus);
 	kfree (udev);
@@ -729,13 +727,6 @@
 	INIT_LIST_HEAD(&dev->filelist);
 
 	init_MUTEX(&dev->serialize);
-
-	if (dev->bus->op->allocate)
-		if (dev->bus->op->allocate(dev)) {
-			usb_bus_put(bus);
-			kfree(dev);
-			return NULL;
-		}
 
 	return dev;
 }
diff -Nru a/drivers/usb/host/ohci-lh7a404.c b/drivers/usb/host/ohci-lh7a404.c
--- a/drivers/usb/host/ohci-lh7a404.c	2005-01-07 15:48:43 -08:00
+++ b/drivers/usb/host/ohci-lh7a404.c	2005-01-07 15:48:43 -08:00
@@ -151,8 +151,6 @@
 	hcd->self.bus_name = "lh7a404";
 	hcd->product_desc = "LH7A404 OHCI";
 
-	INIT_LIST_HEAD (&hcd->dev_list);
-
 	usb_register_bus (&hcd->self);
 
 	if ((retval = driver->start (hcd)) < 0)
diff -Nru a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
--- a/drivers/usb/host/ohci-omap.c	2005-01-07 15:48:43 -08:00
+++ b/drivers/usb/host/ohci-omap.c	2005-01-07 15:48:43 -08:00
@@ -335,7 +335,6 @@
 	hcd->self.bus_name = pdev->dev.bus_id;
 	hcd->product_desc = "OMAP OHCI";
 
-	INIT_LIST_HEAD (&hcd->dev_list);
 	usb_register_bus (&hcd->self);
 
 	if ((retval = driver->start (hcd)) < 0) 
diff -Nru a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
--- a/drivers/usb/host/ohci-pxa27x.c	2005-01-07 15:48:43 -08:00
+++ b/drivers/usb/host/ohci-pxa27x.c	2005-01-07 15:48:43 -08:00
@@ -249,8 +249,6 @@
 	hcd->self.bus_name = "pxa27x";
 	hcd->product_desc = "PXA27x OHCI";
 
-	INIT_LIST_HEAD (&hcd->dev_list);
-
 	usb_register_bus (&hcd->self);
 
 	if ((retval = driver->start (hcd)) < 0) {
diff -Nru a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
--- a/drivers/usb/host/ohci-sa1111.c	2005-01-07 15:48:43 -08:00
+++ b/drivers/usb/host/ohci-sa1111.c	2005-01-07 15:48:43 -08:00
@@ -199,8 +199,6 @@
 	hcd->self.bus_name = "sa1111";
 	hcd->product_desc = "SA-1111 OHCI";
 
-	INIT_LIST_HEAD (&hcd->dev_list);
-
 	usb_register_bus (&hcd->self);
 
 	if ((retval = driver->start (hcd)) < 0) 

