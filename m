Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVAHIdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVAHIdn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVAHIbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:31:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:13702 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261925AbVAHFsq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:46 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163265230@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:45 -0800
Message-Id: <1105163265931@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.14, 2004/12/15 16:32:16-08:00, david-b@pacbell.net

[PATCH] USB: usbcore changes for usb_dev->ep[](2/15)

This patch updates usbcore to match interface changes in the previous patch.

 - udev->ep[] arrays are updated during config change events and
   as needed during enumeration;

 - usb_epnum_to_ep_desc() vanishes;

 - so do the udev->epmaxpacket[] arrays.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/core/hcd.c     |   10 ++--------
 drivers/usb/core/hub.c     |   45 +++++++++++++++++++++++++--------------------
 drivers/usb/core/message.c |   45 +++++++++++++++++++++++++--------------------
 drivers/usb/core/urb.c     |    2 +-
 drivers/usb/core/usb.c     |   44 +++++---------------------------------------
 drivers/usb/core/usb.h     |    2 --
 6 files changed, 58 insertions(+), 90 deletions(-)


diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	2005-01-07 15:49:45 -08:00
+++ b/drivers/usb/core/hcd.c	2005-01-07 15:49:45 -08:00
@@ -807,7 +807,7 @@
 	down (&usb_bus_list_lock);
 	usb_dev->bus->root_hub = usb_dev;
 
-	usb_dev->epmaxpacketin[0] = usb_dev->epmaxpacketout[0] = 64;
+	usb_dev->ep0.desc.wMaxPacketSize = 64;
 	retval = usb_get_device_descriptor(usb_dev, USB_DT_DEVICE_SIZE);
 	if (retval != sizeof usb_dev->descriptor) {
 		usb_dev->bus->root_hub = NULL;
@@ -1335,14 +1335,8 @@
 
 	local_irq_disable ();
 
+	/* ep is already gone from udev->ep_{in,out}[]; no more submits */
 rescan:
-	/* (re)block new requests, as best we can */
-	if (endpoint & USB_DIR_IN)
-		udev->epmaxpacketin [epnum] = 0;
-	else
-		udev->epmaxpacketout [epnum] = 0;
-
-	/* then kill any current requests */
 	spin_lock (&hcd_data_lock);
 	list_for_each_entry (urb, &dev->urb_list, urb_list) {
 		int	tmp = urb->pipe;
diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	2005-01-07 15:49:45 -08:00
+++ b/drivers/usb/core/hub.c	2005-01-07 15:49:45 -08:00
@@ -2024,6 +2024,13 @@
 	return portstatus;
 }
 
+static void ep0_reinit(struct usb_device *udev)
+{
+	usb_disable_endpoint(udev, 0 + USB_DIR_IN);
+	usb_disable_endpoint(udev, 0 + USB_DIR_OUT);
+	udev->ep_in[0] = udev->ep_out[0] = &udev->ep0;
+}
+
 #define usb_sndaddr0pipe()	(PIPE_CONTROL << 30)
 #define usb_rcvaddr0pipe()	((PIPE_CONTROL << 30) | USB_DIR_IN)
 
@@ -2041,12 +2048,8 @@
 		USB_REQ_SET_ADDRESS, 0, udev->devnum, 0,
 		NULL, 0, HZ * USB_CTRL_SET_TIMEOUT);
 	if (retval == 0) {
-		int m = udev->epmaxpacketin[0];
-
 		usb_set_device_state(udev, USB_STATE_ADDRESS);
-		usb_disable_endpoint(udev, 0 + USB_DIR_IN);
-		usb_disable_endpoint(udev, 0 + USB_DIR_OUT);
-		udev->epmaxpacketin[0] = udev->epmaxpacketout[0] = m;
+		ep0_reinit(udev);
 	}
 	return retval;
 }
@@ -2104,22 +2107,21 @@
 	 */
 	switch (udev->speed) {
 	case USB_SPEED_HIGH:		/* fixed at 64 */
-		i = 64;
+		udev->ep0.desc.wMaxPacketSize = 64;
 		break;
 	case USB_SPEED_FULL:		/* 8, 16, 32, or 64 */
 		/* to determine the ep0 maxpacket size, try to read
 		 * the device descriptor to get bMaxPacketSize0 and
 		 * then correct our initial guess.
 		 */
-		i = 64;
+		udev->ep0.desc.wMaxPacketSize = 64;
 		break;
 	case USB_SPEED_LOW:		/* fixed at 8 */
-		i = 8;
+		udev->ep0.desc.wMaxPacketSize = 8;
 		break;
 	default:
 		goto fail;
 	}
-	udev->epmaxpacketin[0] = udev->epmaxpacketout[0] = i;
  
 	dev_info (&udev->dev,
 			"%s %s speed USB device using %s and address %d\n",
@@ -2194,7 +2196,10 @@
 				retval = -ENODEV;
 				goto fail;
 			}
-			if (udev->descriptor.bMaxPacketSize0 == 0) {
+			switch (udev->descriptor.bMaxPacketSize0) {
+			case 64: case 32: case 16: case 8:
+				break;
+			default:
 				dev_err(&udev->dev, "device descriptor "
 						"read/%s, error %d\n",
 						"64", j);
@@ -2241,12 +2246,14 @@
 		goto fail;
 
 	/* Should we verify that the value is valid? */
-	i = udev->descriptor.bMaxPacketSize0;
-	if (udev->epmaxpacketin[0] != i) {
-		dev_dbg(&udev->dev, "ep0 maxpacket = %d\n", i);
-		usb_disable_endpoint(udev, 0 + USB_DIR_IN);
-		usb_disable_endpoint(udev, 0 + USB_DIR_OUT);
-		udev->epmaxpacketin[0] = udev->epmaxpacketout[0] = i;
+	/* (YES!) */
+	if (udev->ep0.desc.wMaxPacketSize
+			!= udev->descriptor.bMaxPacketSize0) {
+		udev->ep0.desc.wMaxPacketSize
+				= udev->descriptor.bMaxPacketSize0;
+		dev_dbg(&udev->dev, "ep0 maxpacket = %d\n",
+				udev->ep0.desc.wMaxPacketSize);
+		ep0_reinit(udev);
 	}
   
 	retval = usb_get_device_descriptor(udev, USB_DT_DEVICE_SIZE);
@@ -2508,8 +2515,7 @@
 
 loop:
 		hub_port_disable(hdev, port);
-		usb_disable_endpoint(udev, 0 + USB_DIR_IN);
-		usb_disable_endpoint(udev, 0 + USB_DIR_OUT);
+		ep0_reinit(udev);
 		release_address(udev);
 		usb_put_dev(udev);
 		if (status == -ENOTCONN)
@@ -2893,8 +2899,7 @@
 
 		/* ep0 maxpacket size may change; let the HCD know about it.
 		 * Other endpoints will be handled by re-enumeration. */
-		usb_disable_endpoint(udev, 0 + USB_DIR_IN);
-		usb_disable_endpoint(udev, 0 + USB_DIR_OUT);
+		ep0_reinit(udev);
 		ret = hub_port_init(parent, udev, port, i);
 		if (ret >= 0)
 			break;
diff -Nru a/drivers/usb/core/message.c b/drivers/usb/core/message.c
--- a/drivers/usb/core/message.c	2005-01-07 15:49:45 -08:00
+++ b/drivers/usb/core/message.c	2005-01-07 15:49:45 -08:00
@@ -918,16 +918,21 @@
  */
 void usb_disable_endpoint(struct usb_device *dev, unsigned int epaddr)
 {
-	if (dev && dev->bus && dev->bus->op && dev->bus->op->disable)
-		dev->bus->op->disable(dev, epaddr);
-	else {
-		unsigned int epnum = epaddr & USB_ENDPOINT_NUMBER_MASK;
-
-		if (usb_endpoint_out(epaddr))
-			dev->epmaxpacketout[epnum] = 0;
-		else
-			dev->epmaxpacketin[epnum] = 0;
+	unsigned int epnum = epaddr & USB_ENDPOINT_NUMBER_MASK;
+	struct usb_host_endpoint *ep;
+
+	if (!dev)
+		return;
+
+	if (usb_endpoint_out(epaddr)) {
+		ep = dev->ep_out[epnum];
+		dev->ep_out[epnum] = NULL;
+	} else {
+		ep = dev->ep_in[epnum];
+		dev->ep_in[epnum] = NULL;
 	}
+	if (ep && dev->bus && dev->bus->op && dev->bus->op->disable)
+		dev->bus->op->disable(dev, ep->desc.bEndpointAddress);
 }
 
 /**
@@ -1002,27 +1007,27 @@
 /*
  * usb_enable_endpoint - Enable an endpoint for USB communications
  * @dev: the device whose interface is being enabled
- * @epd: pointer to the endpoint descriptor
+ * @ep: the endpoint
  *
- * Resets the endpoint toggle and stores its maxpacket value.
+ * Resets the endpoint toggle, and sets dev->ep_{in,out} pointers.
  * For control endpoints, both the input and output sides are handled.
  */
-void usb_enable_endpoint(struct usb_device *dev,
-		struct usb_endpoint_descriptor *epd)
+static void
+usb_enable_endpoint(struct usb_device *dev, struct usb_host_endpoint *ep)
 {
-	int maxsize = epd->wMaxPacketSize;
-	unsigned int epaddr = epd->bEndpointAddress;
+	unsigned int epaddr = ep->desc.bEndpointAddress;
 	unsigned int epnum = epaddr & USB_ENDPOINT_NUMBER_MASK;
-	int is_control = ((epd->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
-				USB_ENDPOINT_XFER_CONTROL);
+	int is_control;
 
+	is_control = ((ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
+			== USB_ENDPOINT_XFER_CONTROL);
 	if (usb_endpoint_out(epaddr) || is_control) {
 		usb_settoggle(dev, epnum, 1, 0);
-		dev->epmaxpacketout[epnum] = maxsize;
+		dev->ep_out[epnum] = ep;
 	}
 	if (!usb_endpoint_out(epaddr) || is_control) {
 		usb_settoggle(dev, epnum, 0, 0);
-		dev->epmaxpacketin[epnum] = maxsize;
+		dev->ep_in[epnum] = ep;
 	}
 }
 
@@ -1040,7 +1045,7 @@
 	int i;
 
 	for (i = 0; i < alt->desc.bNumEndpoints; ++i)
-		usb_enable_endpoint(dev, &alt->endpoint[i].desc);
+		usb_enable_endpoint(dev, &alt->endpoint[i]);
 }
 
 /**
diff -Nru a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
--- a/drivers/usb/core/urb.c	2005-01-07 15:49:45 -08:00
+++ b/drivers/usb/core/urb.c	2005-01-07 15:49:45 -08:00
@@ -265,7 +265,7 @@
 	max = usb_maxpacket (dev, pipe, is_out);
 	if (max <= 0) {
 		dev_dbg(&dev->dev,
-			"bogus endpoint ep%d%s in %s (bad maxpacket %d)",
+			"bogus endpoint ep%d%s in %s (bad maxpacket %d)\n",
 			usb_pipeendpoint (pipe), is_out ? "out" : "in",
 			__FUNCTION__, max);
 		return -EMSGSIZE;
diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	2005-01-07 15:49:45 -08:00
+++ b/drivers/usb/core/usb.c	2005-01-07 15:49:45 -08:00
@@ -267,44 +267,6 @@
 }
 
 /**
- * usb_epnum_to_ep_desc - get the endpoint object with a given endpoint number
- * @dev: the device whose current configuration+altsettings is considered
- * @epnum: the desired endpoint, masked with USB_DIR_IN as appropriate.
- *
- * This walks the device descriptor for the currently active configuration,
- * and returns a pointer to the endpoint with that particular endpoint
- * number, or null.
- *
- * Note that interface descriptors are not required to list endpoint
- * numbers in any standardized order, so that it would be wrong to
- * assume that ep2in precedes either ep5in, ep2out, or even ep1out.
- * This routine helps device drivers avoid such mistakes.
- */
-struct usb_endpoint_descriptor *
-usb_epnum_to_ep_desc(struct usb_device *dev, unsigned epnum)
-{
-	struct usb_host_config *config = dev->actconfig;
-	int i, k;
-
-	if (!config)
-		return NULL;
-	for (i = 0; i < config->desc.bNumInterfaces; i++) {
-		struct usb_interface		*intf;
-		struct usb_host_interface	*alt;
-
-		/* only endpoints in current altsetting are active */
-		intf = config->interface[i];
-		alt = intf->cur_altsetting;
-
-		for (k = 0; k < alt->desc.bNumEndpoints; k++)
-			if (epnum == alt->endpoint[k].desc.bEndpointAddress)
-				return &alt->endpoint[k].desc;
-	}
-
-	return NULL;
-}
-
-/**
  * usb_driver_claim_interface - bind a driver to an interface
  * @driver: the driver to be bound
  * @iface: the interface to which it will be bound; must be in the
@@ -728,6 +690,11 @@
 	dev->dev.release = usb_release_dev;
 	dev->state = USB_STATE_ATTACHED;
 
+	dev->ep0.desc.bLength = USB_DT_ENDPOINT_SIZE;
+	dev->ep0.desc.bDescriptorType = USB_DT_ENDPOINT;
+	/* ep0 maxpacket comes later, from device descriptor */
+	dev->ep_in[0] = dev->ep_out[0] = &dev->ep0;
+
 	/* Save readable and stable topology id, distinguishing devices
 	 * by location for diagnostics, tools, driver model, etc.  The
 	 * string is a path along hub ports, from the root.  Each device's
@@ -1533,7 +1500,6 @@
  * These symbols are exported for device (or host controller)
  * driver modules to use.
  */
-EXPORT_SYMBOL(usb_epnum_to_ep_desc);
 
 EXPORT_SYMBOL(usb_register);
 EXPORT_SYMBOL(usb_deregister);
diff -Nru a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
--- a/drivers/usb/core/usb.h	2005-01-07 15:49:45 -08:00
+++ b/drivers/usb/core/usb.h	2005-01-07 15:49:45 -08:00
@@ -13,8 +13,6 @@
 extern void usb_release_interface_cache(struct kref *ref);
 extern void usb_disable_device (struct usb_device *dev, int skip_ep0);
 
-extern void usb_enable_endpoint (struct usb_device *dev,
-		struct usb_endpoint_descriptor *epd);
 extern void usb_enable_interface (struct usb_device *dev,
 		struct usb_interface *intf);
 

