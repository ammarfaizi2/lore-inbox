Return-Path: <linux-kernel-owner+w=401wt.eu-S1754886AbXABSYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbXABSYq (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 13:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754902AbXABSYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 13:24:46 -0500
Received: from [217.111.56.2] ([217.111.56.2]:42135 "EHLO semtex.sncag.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754886AbXABSYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 13:24:45 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 13:24:44 EST
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc3] fix for bugzilla #7544 (keyspan USB-to-serial converter)
From: Rainer Weikusat <rainer.weikusat@sncag.com>
Date: Tue, 02 Jan 2007 19:16:54 +0100
Message-ID: <877iw5l2eh.fsf@semtex.sncag.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At least the Keyspan USA-19HS USB-to-serial converter supports
two different configurations, one where the input endpoints
have interrupt transfer type and one where they are bulk endpoints.
The default UHCI configuration uses the interrupt input endpoints.
The keyspan driver, OTOH, assumes that the device has only bulk
endpoints (all URBs are initialized by calling usb_fill_bulk_urb
in keyspan.c/ keyspan_setup_urb). This causes the interval field
of the input URBs to have a value of zero instead of one, which
'accidentally' worked with Linux at least up to 2.6.17.11 but
stopped to with 2.6.18, which changed the UHCI support code handling
URBs for interrupt endpoints. The patch below modifies to driver to
initialize its input URBs either as interrupt or as bulk URBs,
depending on the transfertype contained in the associated endpoint
descriptor (only tested with the default configuration) enabling
the driver to again receive data from the serial converter.

Signed-off-by: Rainer Weikusat <rweikusat@sncag.com>
---
diff -pNur linux-2.6.20-rc3/drivers/usb/serial/keyspan.c linux-2.6.20-rc3-keyspan/drivers/usb/serial/keyspan.c
--- linux-2.6.20-rc3/drivers/usb/serial/keyspan.c	2007-01-02 11:10:22.000000000 +0100
+++ linux-2.6.20-rc3-keyspan/drivers/usb/serial/keyspan.c	2007-01-02 18:54:16.000000000 +0100
@@ -95,6 +95,7 @@
 */
 
 
+#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/jiffies.h>
 #include <linux/errno.h>
@@ -1275,11 +1276,29 @@ static int keyspan_fake_startup (struct 
 }
 
 /* Helper functions used by keyspan_setup_urbs */
+static struct usb_endpoint_descriptor const *
+find_ep_desc_for(struct usb_serial const *serial, int endpoint)
+{
+	struct usb_host_endpoint const *p, *e;
+
+	p = serial->interface->cur_altsetting->endpoint;
+	e = p + serial->interface->cur_altsetting->desc.bNumEndpoints;
+	while (p < e && p->desc.bEndpointAddress != endpoint) ++p;
+	
+	if (unlikely(p == e)) panic("found no endpoint descriptor for "
+				    "endpoint %d\n", endpoint);
+
+	return &p->desc;
+}
+
 static struct urb *keyspan_setup_urb (struct usb_serial *serial, int endpoint,
 				      int dir, void *ctx, char *buf, int len,
 				      void (*callback)(struct urb *))
 {
 	struct urb *urb;
+	struct usb_endpoint_descriptor const *ep_desc;
+	char const *ep_type_name;
+	unsigned ep_type;
 
 	if (endpoint == -1)
 		return NULL;		/* endpoint not needed */
@@ -1290,12 +1309,31 @@ static struct urb *keyspan_setup_urb (st
 		dbg ("%s - alloc for endpoint %d failed.", __FUNCTION__, endpoint);
 		return NULL;
 	}
+	
+	ep_desc = find_ep_desc_for(serial, endpoint);
+	ep_type = ep_desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK;
+	switch (ep_type) {
+	case USB_ENDPOINT_XFER_INT:
+		ep_type_name = "INT";
+		usb_fill_int_urb(urb, serial->dev,
+				 usb_sndintpipe(serial->dev, endpoint) | dir,
+				 buf, len, callback, ctx,
+				 ep_desc->bInterval);
+		break;
+
+	case USB_ENDPOINT_XFER_BULK:
+		ep_type_name = "BULK";
+		usb_fill_bulk_urb(urb, serial->dev,
+				  usb_sndbulkpipe(serial->dev, endpoint) | dir,
+				  buf, len, callback, ctx);
+		break;
 
-		/* Fill URB using supplied data. */
-	usb_fill_bulk_urb(urb, serial->dev,
-		      usb_sndbulkpipe(serial->dev, endpoint) | dir,
-		      buf, len, callback, ctx);
+	default:
+		panic("unsupported endpoint type %d", ep_type);
+	}
 
+	dbg("%s - using urb %p for %s endpoint %d",
+	    __func__, urb, ep_type_name, endpoint);
 	return urb;
 }
 
