Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317308AbSIAS4o>; Sun, 1 Sep 2002 14:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSIAS4o>; Sun, 1 Sep 2002 14:56:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20229 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317308AbSIAS4n>; Sun, 1 Sep 2002 14:56:43 -0400
To: greg@kroah.com
CC: LKML <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 2.5.32-usb
Message-Id: <E17lZy6-000153-00@raistlin.arm.linux.org.uk>
Date: Sun, 01 Sep 2002 20:01:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.32, but applies cleanly.

The following patch fixes 3 problems in USB:

1. Don't pci_map buffers when we know we're not going to pass them
   to a device.

   This was first noticed on ARM (no surprises here); the root hub
   code, rh_call_control(), placed data into the buffer and then
   called usb_hcd_giveback_urb().  This function called
   pci_unmap_single() on this region which promptly destroyed the
   data that rh_call_control() had placed there.  This lead to a
   corrupted device descriptor and the "too many configurations"
   message.

2. If controller->hcca is NULL, don't try to dereference it.

3. If we free the root hub (in ohci-hcd.c or uhci-hcd.c), don't
   leave a dangling pointer around to trip us up in usb_disconnect().
   EHCI appears to get this right.

 drivers/usb/core/hcd.c      |   21 +++++++++++----------
 drivers/usb/host/ohci-dbg.c |    3 ++-
 drivers/usb/host/ohci-hcd.c |    3 ++-
 drivers/usb/host/uhci-hcd.c |    1 +
 4 files changed, 16 insertions, 12 deletions

diff -ur orig/drivers/usb/core/hcd.c linux/drivers/usb/core/hcd.c
--- orig/drivers/usb/core/hcd.c	Fri Aug 30 14:53:19 2002
+++ linux/drivers/usb/core/hcd.c	Sun Sep  1 19:51:46 2002
@@ -1020,6 +1020,16 @@
 	if (status)
 		return status;
 
+	/* increment urb's reference count as part of giving it to the HCD
+	 * (which now controls it).  HCD guarantees that it either returns
+	 * an error or calls giveback(), but not both.
+	 */
+	urb = usb_get_urb (urb);
+	if (urb->dev == hcd->self.root_hub) {
+		urb->transfer_flags |= URB_NO_DMA_MAP;
+		return rh_urb_enqueue (hcd, urb);
+	}
+
 	/* lower level hcd code should use *_dma exclusively */
 	if (!(urb->transfer_flags & URB_NO_DMA_MAP)) {
 		if (usb_pipecontrol (urb->pipe))
@@ -1038,16 +1048,7 @@
 					    : PCI_DMA_TODEVICE);
 	}
 
-	/* increment urb's reference count as part of giving it to the HCD
-	 * (which now controls it).  HCD guarantees that it either returns
-	 * an error or calls giveback(), but not both.
-	 */
-	urb = usb_get_urb (urb);
-	if (urb->dev == hcd->self.root_hub)
-		status = rh_urb_enqueue (hcd, urb);
-	else
-		status = hcd->driver->urb_enqueue (hcd, urb, mem_flags);
-	return status;
+	return hcd->driver->urb_enqueue (hcd, urb, mem_flags);
 }
 
 /*-------------------------------------------------------------------------*/
diff -ur orig/drivers/usb/host/ohci-dbg.c linux/drivers/usb/host/ohci-dbg.c
--- orig/drivers/usb/host/ohci-dbg.c	Sat Jul 27 13:55:21 2002
+++ linux/drivers/usb/host/ohci-dbg.c	Sun Sep  1 17:14:27 2002
@@ -239,7 +239,8 @@
 	if (verbose)
 		ohci_dump_periodic (controller, "hcca");
 #endif
-	dbg ("hcca frame #%04x", controller->hcca->frame_no);
+	if (controller->hcca)
+		dbg ("hcca frame #%04x", controller->hcca->frame_no);
 	ohci_dump_roothub (controller, 1);
 }
 
diff -ur orig/drivers/usb/host/ohci-hcd.c linux/drivers/usb/host/ohci-hcd.c
--- orig/drivers/usb/host/ohci-hcd.c	Sat Jul 27 13:55:21 2002
+++ linux/drivers/usb/host/ohci-hcd.c	Sun Sep  1 17:26:11 2002
@@ -530,7 +530,8 @@
 	usb_connect (udev);
 	udev->speed = USB_SPEED_FULL;
 	if (usb_register_root_hub (udev, ohci->parent_dev) != 0) {
-		usb_free_dev (udev); 
+		usb_free_dev (udev);
+		ohci->hcd.self.root_hub = NULL;
 		disable (ohci);
 		ohci->hc_control &= ~OHCI_CTRL_HCFS;
 		writel (ohci->hc_control, &ohci->regs->control);
--- orig/drivers/usb/host/uhci-hcd.c	Fri Aug 30 14:53:21 2002
+++ linux/drivers/usb/host/uhci-hcd.c	Sun Sep  1 19:58:51 2002
@@ -2340,6 +2340,7 @@
 err_alloc_skeltd:
 	usb_free_dev(uhci->rh_dev);
 	uhci->rh_dev = NULL;
+	hcd->self.root_hub = NULL;
 
 err_alloc_root_hub:
 	pci_pool_destroy(uhci->qh_pool);
