Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVAHHHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVAHHHm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVAHHGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:06:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:12422 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261920AbVAHFsp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:45 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163265931@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:45 -0800
Message-Id: <11051632653471@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.15, 2004/12/15 16:32:41-08:00, david-b@pacbell.net

[PATCH] USB: usbfs changes for usb_dev->ep[] (3/15)

Updates usbfs to stop using usb_epnum_to_ep_desc().  In the process,
it acquires better error detection on its urb submit path.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/core/devio.c |   39 +++++++++++++++++++++++++--------------
 1 files changed, 25 insertions(+), 14 deletions(-)


diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	2005-01-07 15:49:37 -08:00
+++ b/drivers/usb/core/devio.c	2005-01-07 15:49:37 -08:00
@@ -808,7 +808,7 @@
 {
 	struct usbdevfs_urb uurb;
 	struct usbdevfs_iso_packet_desc *isopkt = NULL;
-	struct usb_endpoint_descriptor *ep_desc;
+	struct usb_host_endpoint *ep;
 	struct async *as;
 	struct usb_ctrlrequest *dr = NULL;
 	unsigned int u, totlen, isofrmlen;
@@ -829,14 +829,17 @@
 		if ((ret = checkintf(ps, ifnum)))
 			return ret;
 	}
+	if ((uurb.endpoint & ~USB_ENDPOINT_DIR_MASK) != 0)
+		ep = ps->dev->ep_in [uurb.endpoint & USB_ENDPOINT_NUMBER_MASK];
+	else
+		ep = ps->dev->ep_out [uurb.endpoint & USB_ENDPOINT_NUMBER_MASK];
+	if (!ep)
+		return -ENOENT;
 	switch(uurb.type) {
 	case USBDEVFS_URB_TYPE_CONTROL:
-		if ((uurb.endpoint & ~USB_ENDPOINT_DIR_MASK) != 0) {
-			if (!(ep_desc = usb_epnum_to_ep_desc(ps->dev, uurb.endpoint)))
-				return -ENOENT;
-			if ((ep_desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_CONTROL)
-				return -EINVAL;
-		}
+		if ((ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
+				!= USB_ENDPOINT_XFER_CONTROL)
+			return -EINVAL;
 		/* min 8 byte setup packet, max arbitrary */
 		if (uurb.buffer_length < 8 || uurb.buffer_length > PAGE_SIZE)
 			return -EINVAL;
@@ -865,6 +868,12 @@
 		break;
 
 	case USBDEVFS_URB_TYPE_BULK:
+		switch (ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) {
+		case USB_ENDPOINT_XFER_CONTROL:
+		case USB_ENDPOINT_XFER_ISOC:
+			return -EINVAL;
+		/* allow single-shot interrupt transfers, at bogus rates */
+		}
 		uurb.number_of_packets = 0;
 		if (uurb.buffer_length > MAX_USBFS_BUFFER_SIZE)
 			return -EINVAL;
@@ -876,9 +885,10 @@
 		/* arbitrary limit */
 		if (uurb.number_of_packets < 1 || uurb.number_of_packets > 128)
 			return -EINVAL;
-		if (!(ep_desc = usb_epnum_to_ep_desc(ps->dev, uurb.endpoint)))
-			return -ENOENT;
-		interval = 1 << min (15, ep_desc->bInterval - 1);
+		if ((ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
+				!= USB_ENDPOINT_XFER_ISOC)
+			return -EINVAL;
+		interval = 1 << min (15, ep->desc.bInterval - 1);
 		isofrmlen = sizeof(struct usbdevfs_iso_packet_desc) * uurb.number_of_packets;
 		if (!(isopkt = kmalloc(isofrmlen, GFP_KERNEL)))
 			return -ENOMEM;
@@ -902,12 +912,13 @@
 
 	case USBDEVFS_URB_TYPE_INTERRUPT:
 		uurb.number_of_packets = 0;
-		if (!(ep_desc = usb_epnum_to_ep_desc(ps->dev, uurb.endpoint)))
-			return -ENOENT;
+		if ((ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
+				!= USB_ENDPOINT_XFER_INT)
+			return -EINVAL;
 		if (ps->dev->speed == USB_SPEED_HIGH)
-			interval = 1 << min (15, ep_desc->bInterval - 1);
+			interval = 1 << min (15, ep->desc.bInterval - 1);
 		else
-			interval = ep_desc->bInterval;
+			interval = ep->desc.bInterval;
 		if (uurb.buffer_length > MAX_USBFS_BUFFER_SIZE)
 			return -EINVAL;
 		if (!access_ok((uurb.endpoint & USB_DIR_IN) ? VERIFY_WRITE : VERIFY_READ, uurb.buffer, uurb.buffer_length))

