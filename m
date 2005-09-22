Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbVIVHun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbVIVHun (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVIVHuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:50:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:15283 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932161AbVIVHtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:49:42 -0400
Date: Thu, 22 Sep 2005 00:49:07 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       david-b@pacbell.net
Subject: [patch 13/18] USB: sl811-hcd minor fixes
Message-ID: <20050922074907.GN15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-sl811-minor-fixes.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

Three minor sl811-hcd fixes:

 - Elminate memory leak on one (rare) disable/shutdown path.

 - For periodic transfers that don't need to be scheduled, update
   urb->start_frame to represent the transfer phase correctly.

 - Report the (single) port as removable, by default.

Since no drivers yet use start_frame or that part of the hub descriptor,
only that leak is likely to ever matter.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/usb/host/sl811-hcd.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- scsi-2.6.orig/drivers/usb/host/sl811-hcd.c	2005-09-20 06:00:03.000000000 -0700
+++ scsi-2.6/drivers/usb/host/sl811-hcd.c	2005-09-21 17:29:45.000000000 -0700
@@ -782,6 +782,9 @@
 /* usb 1.1 says max 90% of a frame is available for periodic transfers.
  * this driver doesn't promise that much since it's got to handle an
  * IRQ per packet; irq handling latencies also use up that time.
+ *
+ * NOTE:  the periodic schedule is a sparse tree, with the load for
+ * each branch minimized.  see fig 3.5 in the OHCI spec for example.
  */
 #define	MAX_PERIODIC_LOAD	500	/* out of 1000 usec */
 
@@ -843,6 +846,7 @@
 	if (!(sl811->port1 & (1 << USB_PORT_FEAT_ENABLE))
 			|| !HC_IS_RUNNING(hcd->state)) {
 		retval = -ENODEV;
+		kfree(ep);
 		goto fail;
 	}
 
@@ -911,8 +915,16 @@
 	case PIPE_ISOCHRONOUS:
 	case PIPE_INTERRUPT:
 		urb->interval = ep->period;
-		if (ep->branch < PERIODIC_SIZE)
+		if (ep->branch < PERIODIC_SIZE) {
+			/* NOTE:  the phase is correct here, but the value
+			 * needs offsetting by the transfer queue depth.
+			 * All current drivers ignore start_frame, so this
+			 * is unlikely to ever matter...
+			 */
+			urb->start_frame = (sl811->frame & (PERIODIC_SIZE - 1))
+						+ ep->branch;
 			break;
+		}
 
 		retval = balance(sl811, ep->period, ep->load);
 		if (retval < 0)
@@ -1122,7 +1134,7 @@
 	desc->wHubCharacteristics = (__force __u16)cpu_to_le16(temp);
 
 	/* two bitmaps:  ports removable, and legacy PortPwrCtrlMask */
-	desc->bitmap[0] = 1 << 1;
+	desc->bitmap[0] = 0 << 1;
 	desc->bitmap[1] = ~0;
 }
 

--
