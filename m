Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSFTQQF>; Thu, 20 Jun 2002 12:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314783AbSFTQQE>; Thu, 20 Jun 2002 12:16:04 -0400
Received: from hera.cwi.nl ([192.16.191.8]:3786 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312498AbSFTQQD>;
	Thu, 20 Jun 2002 12:16:03 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 20 Jun 2002 18:16:00 +0200 (MEST)
Message-Id: <UTC200206201616.g5KGG0J08669.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCHlet] 2.5.23 usb, ide
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier, I reported that 2.5.22 and 2.5.23 do not boot.
With Marcin's IDE-93 this is corrected, and the system boots.

Earlier, I reported an oops at shutdown. I just looked at
what causes the oops and find that the call
	hcd->driver->stop()
is executed while hcd->driver->stop is NULL.

So, applying

diff -r -u linux-2.5.23/linux/drivers/usb/core/hcd-pci.c linux-2.5.23a/linux/drivers/usb/core/hcd-pci.c
--- linux-2.5.23/linux/drivers/usb/core/hcd-pci.c	Mon Jun 17 19:35:40 2002
+++ linux-2.5.23a/linux/drivers/usb/core/hcd-pci.c	Thu Jun 20 17:48:09 2002
@@ -209,13 +209,16 @@
 
 	if (in_interrupt ()) BUG ();
 
+	if (!hcd->driver) BUG ();
+
 	hub = hcd->self.root_hub;
 	hcd->state = USB_STATE_QUIESCING;
 
 	dbg ("%s: roothub graceful disconnect", hcd->self.bus_name);
 	usb_disconnect (&hub);
 
-	hcd->driver->stop (hcd);
+	if (hcd->driver->stop)
+		hcd->driver->stop (hcd);
 	hcd->state = USB_STATE_HALT;
 
 	free_irq (hcd->irq, hcd);
@@ -232,7 +235,8 @@
 	if (atomic_read (&hcd->self.refcnt) != 1)
 		err ("usb_hcd_pci_remove %s, count != 1", hcd->self.bus_name);
 
-	hcd->driver->hcd_free (hcd);
+	if (hcd->driver->hcd_free)
+		hcd->driver->hcd_free (hcd);
 }
 EXPORT_SYMBOL (usb_hcd_pci_remove);
 

stops the oops.
USB people may worry whether hcd->driver->stop should
have been non-NULL.

Andries
with a somewhat working 2.5
