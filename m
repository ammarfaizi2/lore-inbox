Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVAHGtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVAHGtP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVAHGss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:48:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:6278 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261911AbVAHFsj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:39 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632651067@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:45 -0800
Message-Id: <11051632654050@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.17, 2004/12/15 16:33:30-08:00, david-b@pacbell.net

[PATCH] USB: auerswald and usb_dev->ep[] (5/15)

Update the auerswald driver to stop using the now-vanished
usb_epnum_to_ep_desc() function.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/misc/auerswald.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)


diff -Nru a/drivers/usb/misc/auerswald.c b/drivers/usb/misc/auerswald.c
--- a/drivers/usb/misc/auerswald.c	2005-01-07 15:49:22 -08:00
+++ b/drivers/usb/misc/auerswald.c	2005-01-07 15:49:22 -08:00
@@ -1123,16 +1123,16 @@
 static int auerswald_int_open (pauerswald_t cp)
 {
         int ret;
-	struct usb_endpoint_descriptor *ep;
+	struct usb_host_endpoint *ep;
 	int irqsize;
 	dbg ("auerswald_int_open");
 
-	ep = usb_epnum_to_ep_desc (cp->usbdev, USB_DIR_IN | AU_IRQENDP);
+	ep = cp->usbdev->ep_in[AU_IRQENDP];
 	if (!ep) {
 		ret = -EFAULT;
   		goto intoend;
     	}
-	irqsize = ep->wMaxPacketSize;
+	irqsize = ep->desc.wMaxPacketSize;
 	cp->irqsize = irqsize;
 
 	/* allocate the urb and data buffer */
@@ -1151,7 +1151,9 @@
                 }
         }
         /* setup urb */
-        usb_fill_int_urb (cp->inturbp, cp->usbdev, usb_rcvintpipe (cp->usbdev,AU_IRQENDP), cp->intbufp, irqsize, auerswald_int_complete, cp, ep->bInterval);
+        usb_fill_int_urb (cp->inturbp, cp->usbdev,
+			usb_rcvintpipe (cp->usbdev,AU_IRQENDP), cp->intbufp,
+			irqsize, auerswald_int_complete, cp, ep->desc.bInterval);
         /* start the urb */
 	cp->inturbp->status = 0;	/* needed! */
 	ret = usb_submit_urb (cp->inturbp, GFP_KERNEL);

