Return-Path: <linux-kernel-owner+w=401wt.eu-S1751699AbWLVSL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWLVSL5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 13:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWLVSL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 13:11:56 -0500
Received: from mail.sncag.com ([217.111.56.16]:35229 "EHLO mail.sncag.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699AbWLVSL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 13:11:56 -0500
X-Greylist: delayed 643 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 13:11:55 EST
To: greg@kroah.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] interrupt endpoint support for keyspan USB-to-serial
From: Rainer Weikusat <rweikusat@sncag.com>
Date: Fri, 22 Dec 2006 19:01:00 +0100
Message-ID: <87k60jg68z.fsf@farside.sncag.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rainer Weikusat <rweikusat@sncag.com>

At least the Keyspan USA-19HS USB-to-serial converter supports
two different configurations, one where the input endpoints
have interrupt transfer type and one where they are bulk endpoints.
The default configuration uses the interrupt input endpoints.
The keyspan driver, OTOH, assumes that the device has only bulk
endpoints (all URBs are initialized by calling usb_fill_bulk_urb
in keyspan.c/ keyspan_setup_urb). This causes the interval field
of the input URBs to have a value of zero instead of one, which
'accidentally' worked with Linux at least up to 2.6.17.11 but
stopped to with 2.6.18, which changed the code handling URBs for
interrupt endpoints. The patch below modifies to driver to
initialize its input URBs either as interrupt or as bulk URBs,
depending on the transfertype contained in the associated endpoint
descriptor (only tested with the default configuration) enabling
the driver to again receive data from the serial converter.

Signed-off-by: Rainer Weikusat <rweikusat@sncag.com>
---
diff -uprN linux-2.6.19.1.orig/drivers/usb/serial/keyspan.c linux-2.6.19.1/drivers/usb/serial/keyspan.c
--- linux-2.6.19.1.orig/drivers/usb/serial/keyspan.c	2006-12-22 18:28:09.000000000 +0100
+++ linux-2.6.19.1/drivers/usb/serial/keyspan.c	2006-12-22 18:52:15.000000000 +0100
@@ -95,6 +95,7 @@
 */
 
 
+#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/jiffies.h>
 #include <linux/errno.h>
@@ -1275,11 +1276,35 @@ static int keyspan_fake_startup (struct 
 }
 
 /* Helper functions used by keyspan_setup_urbs */
+static struct usb_endpoint_descriptor const *
+find_ep_desc_for(struct usb_serial const *serial, int endpoint)
+{
+	struct usb_host_interface const *setting;
+	struct usb_endpoint_descriptor const *ep_desc;
+	int n;
+
+	setting = serial->interface->cur_altsetting;
+	n = setting->desc.bNumEndpoints - 1;
+	do
+		ep_desc = &setting->endpoint[n].desc;
+	while (ep_desc->bEndpointAddress != endpoint && --n >= 0);
+
+	if (unlikely(n == -1)) {
+		printk(KERN_ERR "no endpoint descriptor found\n");
+		BUG();
+	}
+
+	dbg("%s - found endpoint descriptor @ %p", __func__, ep_desc);
+	return ep_desc;
+}
+
 static struct urb *keyspan_setup_urb (struct usb_serial *serial, int endpoint,
 				      int dir, void *ctx, char *buf, int len,
 				      void (*callback)(struct urb *))
 {
+	struct usb_endpoint_descriptor const *ep_desc;
 	struct urb *urb;
+	unsigned ep_type;
 
 	if (endpoint == -1)
 		return NULL;		/* endpoint not needed */
@@ -1290,11 +1315,33 @@ static struct urb *keyspan_setup_urb (st
 		dbg ("%s - alloc for endpoint %d failed.", __FUNCTION__, endpoint);
 		return NULL;
 	}
+	
+	ep_desc = find_ep_desc_for(serial, endpoint);
+	ep_type = ep_desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK;
+	switch (ep_type) {
+	case USB_ENDPOINT_XFER_INT:
+		dbg("%s - filling urb %p for int endpoint",
+		    __func__, urb);
+		
+		usb_fill_int_urb(urb, serial->dev,
+				 usb_sndintpipe(serial->dev, endpoint) | dir,
+				 buf, len, callback, ctx,
+				 ep_desc->bInterval);
+		break;
+
+	case USB_ENDPOINT_XFER_BULK:
+		dbg("%s - filling urb %p for bulk endpoint",
+		    __func__, urb);
+		
+		usb_fill_bulk_urb(urb, serial->dev,
+				  usb_sndbulkpipe(serial->dev, endpoint) | dir,
+				  buf, len, callback, ctx);
+		break;
 
-		/* Fill URB using supplied data. */
-	usb_fill_bulk_urb(urb, serial->dev,
-		      usb_sndbulkpipe(serial->dev, endpoint) | dir,
-		      buf, len, callback, ctx);
+	default:
+		printk(KERN_ERR "unexpected endpoint type %d", ep_type);
+		BUG();
+	}
 
 	return urb;
 }
