Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVAHIdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVAHIdm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVAHIcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:32:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:13446 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261924AbVAHFsq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:46 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632662436@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:46 -0800
Message-Id: <11051632662286@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.23, 2004/12/15 16:35:49-08:00, david-b@pacbell.net

[PATCH] USB: maintain usb_host_endpoint.urb_list (11/15)

This patch changes the HCD glue code to use the URB queue now kept in
usb_host_endpoint, and matching HCD API changes.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/core/config.c  |    1 
 drivers/usb/core/hcd.c     |   58 +++++++++++++++++++++------------------------
 drivers/usb/core/message.c |    2 -
 drivers/usb/core/usb.c     |    1 
 4 files changed, 31 insertions(+), 31 deletions(-)


diff -Nru a/drivers/usb/core/config.c b/drivers/usb/core/config.c
--- a/drivers/usb/core/config.c	2005-01-07 15:48:36 -08:00
+++ b/drivers/usb/core/config.c	2005-01-07 15:48:36 -08:00
@@ -88,6 +88,7 @@
 
 	memcpy(&endpoint->desc, d, n);
 	le16_to_cpus(&endpoint->desc.wMaxPacketSize);
+	INIT_LIST_HEAD(&endpoint->urb_list);
 
 	/* Skip over any Class Specific or Vendor Specific descriptors;
 	 * find the next endpoint or interface descriptor */
diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	2005-01-07 15:48:36 -08:00
+++ b/drivers/usb/core/hcd.c	2005-01-07 15:48:36 -08:00
@@ -1045,10 +1045,12 @@
 {
 	int			status;
 	struct usb_hcd		*hcd = urb->dev->bus->hcpriv;
-	struct hcd_dev		*dev = urb->dev->hcpriv;
+	struct usb_host_endpoint *ep;
 	unsigned long		flags;
 
-	if (!hcd || !dev)
+	ep = (usb_pipein(urb->pipe) ? urb->dev->ep_in : urb->dev->ep_out)
+			[usb_pipeendpoint(urb->pipe)];
+	if (!hcd || !ep)
 		return -ENODEV;
 
 	/*
@@ -1075,7 +1077,7 @@
 	case USB_STATE_RUNNING:
 	case USB_STATE_RESUMING:
 		usb_get_dev (urb->dev);
-		list_add_tail (&urb->urb_list, &dev->urb_list);
+		list_add_tail (&urb->urb_list, &ep->urb_list);
 		status = 0;
 		break;
 	default:
@@ -1129,7 +1131,7 @@
 					    : DMA_TO_DEVICE);
 	}
 
-	status = hcd->driver->urb_enqueue (hcd, urb, mem_flags);
+	status = hcd->driver->urb_enqueue (hcd, ep, urb, mem_flags);
 done:
 	if (unlikely (status)) {
 		urb_unlink (urb);
@@ -1188,7 +1190,7 @@
  */
 static int hcd_unlink_urb (struct urb *urb, int status)
 {
-	struct hcd_dev			*dev;
+	struct usb_host_endpoint	*ep;
 	struct usb_hcd			*hcd = NULL;
 	struct device			*sys = NULL;
 	unsigned long			flags;
@@ -1197,6 +1199,12 @@
 
 	if (!urb)
 		return -EINVAL;
+	if (!urb->dev || !urb->dev->bus)
+		return -ENODEV;
+	ep = (usb_pipein(urb->pipe) ? urb->dev->ep_in : urb->dev->ep_out)
+			[usb_pipeendpoint(urb->pipe)];
+	if (!ep)
+		return -ENODEV;
 
 	/*
 	 * we contend for urb->status with the hcd core,
@@ -1212,15 +1220,9 @@
 	spin_lock_irqsave (&urb->lock, flags);
 	spin_lock (&hcd_data_lock);
 
-	if (!urb->dev || !urb->dev->bus) {
-		retval = -ENODEV;
-		goto done;
-	}
-
-	dev = urb->dev->hcpriv;
 	sys = &urb->dev->dev;
 	hcd = urb->dev->bus->hcpriv;
-	if (!dev || !hcd) {
+	if (hcd == NULL) {
 		retval = -ENODEV;
 		goto done;
 	}
@@ -1232,7 +1234,7 @@
 	WARN_ON (!HCD_IS_RUNNING (hcd->state) && hcd->state != USB_STATE_HALT);
 
 	/* insist the urb is still queued */
-	list_for_each(tmp, &dev->urb_list) {
+	list_for_each(tmp, &ep->urb_list) {
 		if (tmp == &urb->urb_list)
 			break;
 	}
@@ -1284,40 +1286,36 @@
  * the hcd to make sure all endpoint state is gone from hardware. use for
  * set_configuration, set_interface, driver removal, physical disconnect.
  *
- * example:  a qh stored in hcd_dev.ep[], holding state related to endpoint
+ * example:  a qh stored in ep->hcpriv, holding state related to endpoint
  * type, maxpacket size, toggle, halt status, and scheduling.
  */
-static void hcd_endpoint_disable (struct usb_device *udev, int endpoint)
+static void
+hcd_endpoint_disable (struct usb_device *udev, struct usb_host_endpoint *ep)
 {
-	struct hcd_dev	*dev;
-	struct usb_hcd	*hcd;
-	struct urb	*urb;
-	unsigned	epnum = endpoint & USB_ENDPOINT_NUMBER_MASK;
+	struct usb_hcd		*hcd;
+	struct urb		*urb;
 
-	dev = udev->hcpriv;
 	hcd = udev->bus->hcpriv;
 
 	WARN_ON (!HCD_IS_RUNNING (hcd->state) && hcd->state != USB_STATE_HALT);
 
 	local_irq_disable ();
 
+	/* FIXME move most of this into message.c as part of its
+	 * endpoint disable logic
+	 */
+
 	/* ep is already gone from udev->ep_{in,out}[]; no more submits */
 rescan:
 	spin_lock (&hcd_data_lock);
-	list_for_each_entry (urb, &dev->urb_list, urb_list) {
-		int	tmp = urb->pipe;
-
-		/* ignore urbs for other endpoints */
-		if (usb_pipeendpoint (tmp) != epnum)
-			continue;
-		/* NOTE assumption that only ep0 is a control endpoint */
-		if (epnum != 0 && ((tmp ^ endpoint) & USB_DIR_IN))
-			continue;
+	list_for_each_entry (urb, &ep->urb_list, urb_list) {
+		int	tmp;
 
 		/* another cpu may be in hcd, spinning on hcd_data_lock
 		 * to giveback() this urb.  the races here should be
 		 * small, but a full fix needs a new "can't submit"
 		 * urb state.
+		 * FIXME urb->reject should allow that...
 		 */
 		if (urb->status != -EINPROGRESS)
 			continue;
@@ -1359,7 +1357,7 @@
 	 */
 	might_sleep ();
 	if (hcd->driver->endpoint_disable)
-		hcd->driver->endpoint_disable (hcd, dev, endpoint);
+		hcd->driver->endpoint_disable (hcd, ep);
 }
 
 /*-------------------------------------------------------------------------*/
diff -Nru a/drivers/usb/core/message.c b/drivers/usb/core/message.c
--- a/drivers/usb/core/message.c	2005-01-07 15:48:36 -08:00
+++ b/drivers/usb/core/message.c	2005-01-07 15:48:36 -08:00
@@ -932,7 +932,7 @@
 		dev->ep_in[epnum] = NULL;
 	}
 	if (ep && dev->bus && dev->bus->op && dev->bus->op->disable)
-		dev->bus->op->disable(dev, ep->desc.bEndpointAddress);
+		dev->bus->op->disable(dev, ep);
 }
 
 /**
diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	2005-01-07 15:48:36 -08:00
+++ b/drivers/usb/core/usb.c	2005-01-07 15:48:36 -08:00
@@ -688,6 +688,7 @@
 	dev->dev.release = usb_release_dev;
 	dev->state = USB_STATE_ATTACHED;
 
+	INIT_LIST_HEAD(&dev->ep0.urb_list);
 	dev->ep0.desc.bLength = USB_DT_ENDPOINT_SIZE;
 	dev->ep0.desc.bDescriptorType = USB_DT_ENDPOINT;
 	/* ep0 maxpacket comes later, from device descriptor */

