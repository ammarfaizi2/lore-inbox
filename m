Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVAHHMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVAHHMX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVAHHLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:11:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:61061 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261893AbVAHFsb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:31 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632662439@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:46 -0800
Message-Id: <11051632663258@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.25, 2004/12/15 16:37:08-08:00, david-b@pacbell.net

[PATCH] USB: OHCI and HCD API changes (13/15)

Updates the OHCI HCD to match API updates.  This includes both new
changes (struct hcd_dev gone) and older ones (endpoints now properly
enabled/disabled, so "re"init paths aren't needed).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/ohci-hcd.c |   23 ++++++++--------------
 drivers/usb/host/ohci-q.c   |   46 +++++++++++++++++++-------------------------
 2 files changed, 29 insertions(+), 40 deletions(-)


diff -Nru a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
--- a/drivers/usb/host/ohci-hcd.c	2005-01-07 15:48:16 -08:00
+++ b/drivers/usb/host/ohci-hcd.c	2005-01-07 15:48:16 -08:00
@@ -165,6 +165,7 @@
  */
 static int ohci_urb_enqueue (
 	struct usb_hcd	*hcd,
+	struct usb_host_endpoint *ep,
 	struct urb	*urb,
 	int		mem_flags
 ) {
@@ -181,7 +182,7 @@
 #endif
 	
 	/* every endpoint has a ed, locate and maybe (re)initialize it */
-	if (! (ed = ed_get (ohci, urb->dev, pipe, urb->interval)))
+	if (! (ed = ed_get (ohci, ep, urb->dev, pipe, urb->interval)))
 		return -ENOMEM;
 
 	/* for the private part of the URB we need the number of TDs (size) */
@@ -338,26 +339,21 @@
  */
 
 static void
-ohci_endpoint_disable (struct usb_hcd *hcd, struct hcd_dev *dev, int ep)
+ohci_endpoint_disable (struct usb_hcd *hcd, struct usb_host_endpoint *ep)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
-	int			epnum = ep & USB_ENDPOINT_NUMBER_MASK;
 	unsigned long		flags;
-	struct ed		*ed;
+	struct ed		*ed = ep->hcpriv;
 	unsigned		limit = 1000;
 
 	/* ASSERT:  any requests/urbs are being unlinked */
 	/* ASSERT:  nobody can be submitting urbs for this any more */
 
-	epnum <<= 1;
-	if (epnum != 0 && !(ep & USB_DIR_IN))
-		epnum |= 1;
+	if (!ed)
+		return;
 
 rescan:
 	spin_lock_irqsave (&ohci->lock, flags);
-	ed = dev->ep [epnum];
-	if (!ed)
-		goto done;
 
 	if (!HCD_IS_RUNNING (ohci->hcd.state)) {
 sanitize:
@@ -387,14 +383,13 @@
 		/* caller was supposed to have unlinked any requests;
 		 * that's not our job.  can't recover; must leak ed.
 		 */
-		ohci_err (ohci, "leak ed %p (#%d) state %d%s\n",
-			ed, epnum, ed->state,
+		ohci_err (ohci, "leak ed %p (#%02x) state %d%s\n",
+			ed, ep->desc.bEndpointAddress, ed->state,
 			list_empty (&ed->td_list) ? "" : " (has tds)");
 		td_free (ohci, ed->dummy);
 		break;
 	}
-	dev->ep [epnum] = NULL;
-done:
+	ep->hcpriv = NULL;
 	spin_unlock_irqrestore (&ohci->lock, flags);
 	return;
 }
diff -Nru a/drivers/usb/host/ohci-q.c b/drivers/usb/host/ohci-q.c
--- a/drivers/usb/host/ohci-q.c	2005-01-07 15:48:16 -08:00
+++ b/drivers/usb/host/ohci-q.c	2005-01-07 15:48:16 -08:00
@@ -386,37 +386,30 @@
 /*-------------------------------------------------------------------------*/
 
 /* get and maybe (re)init an endpoint. init _should_ be done only as part
- * of usb_set_configuration() or usb_set_interface() ... but the USB stack
- * isn't very stateful, so we re-init whenever the HC isn't looking.
+ * of enumeration, usb_set_configuration() or usb_set_interface().
  */
 static struct ed *ed_get (
 	struct ohci_hcd		*ohci,
+	struct usb_host_endpoint *ep,
 	struct usb_device	*udev,
 	unsigned int		pipe,
 	int			interval
 ) {
-	int			is_out = !usb_pipein (pipe);
-	int			type = usb_pipetype (pipe);
-	struct hcd_dev		*dev = (struct hcd_dev *) udev->hcpriv;
 	struct ed		*ed; 
-	unsigned		ep;
 	unsigned long		flags;
 
-	ep = usb_pipeendpoint (pipe) << 1;
-	if (type != PIPE_CONTROL && is_out)
-		ep |= 1;
-
 	spin_lock_irqsave (&ohci->lock, flags);
 
-	if (!(ed = dev->ep [ep])) {
+	if (!(ed = ep->hcpriv)) {
 		struct td	*td;
+		int		is_out;
+		u32		info;
 
 		ed = ed_alloc (ohci, GFP_ATOMIC);
 		if (!ed) {
 			/* out of memory */
 			goto done;
 		}
-		dev->ep [ep] = ed;
 
   		/* dummy td; end of td list for ed */
 		td = td_alloc (ohci, GFP_ATOMIC);
@@ -430,38 +423,39 @@
 		ed->hwTailP = cpu_to_hc32 (ohci, td->td_dma);
 		ed->hwHeadP = ed->hwTailP;	/* ED_C, ED_H zeroed */
 		ed->state = ED_IDLE;
-		ed->type = type;
-	}
 
-	/* NOTE: only ep0 currently needs this "re"init logic, during
-	 * enumeration (after set_address).
-	 */
-  	if (ed->state == ED_IDLE) {
-		u32	info;
+		is_out = !(ep->desc.bEndpointAddress & USB_DIR_IN);
 
+		/* FIXME usbcore changes dev->devnum before SET_ADDRESS
+		 * suceeds ... otherwise we wouldn't need "pipe".
+		 */
 		info = usb_pipedevice (pipe);
-		info |= (ep >> 1) << 7;
-		info |= usb_maxpacket (udev, pipe, is_out) << 16;
+		ed->type = usb_pipetype(pipe);
+
+		info |= (ep->desc.bEndpointAddress & ~USB_DIR_IN) << 7;
+		info |= ep->desc.wMaxPacketSize << 16;
 		if (udev->speed == USB_SPEED_LOW)
 			info |= ED_LOWSPEED;
 		/* only control transfers store pids in tds */
-		if (type != PIPE_CONTROL) {
+		if (ed->type != PIPE_CONTROL) {
 			info |= is_out ? ED_OUT : ED_IN;
-			if (type != PIPE_BULK) {
+			if (ed->type != PIPE_BULK) {
 				/* periodic transfers... */
-				if (type == PIPE_ISOCHRONOUS)
+				if (ed->type == PIPE_ISOCHRONOUS)
 					info |= ED_ISO;
 				else if (interval > 32)	/* iso can be bigger */
 					interval = 32;
 				ed->interval = interval;
 				ed->load = usb_calc_bus_time (
 					udev->speed, !is_out,
-					type == PIPE_ISOCHRONOUS,
-					usb_maxpacket (udev, pipe, is_out))
+					ed->type == PIPE_ISOCHRONOUS,
+					ep->desc.wMaxPacketSize)
 						/ 1000;
 			}
 		}
 		ed->hwINFO = cpu_to_hc32(ohci, info);
+
+		ep->hcpriv = ed;
 	}
 
 done:

