Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVAHHMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVAHHMY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVAHHJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:09:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:12678 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261922AbVAHFsp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:45 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632662286@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:46 -0800
Message-Id: <11051632662439@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.24, 2004/12/15 16:36:14-08:00, david-b@pacbell.net

[PATCH] USB: EHCI and HCD API updates (12/15)

Updates the EHCI HCD to match API updates.  This includes both new
changes (struct hcd_dev gone) and older ones (endpoints now properly
enabled/disabled, so "re"init paths aren't needed).  Hmm, the ISO
stuff could avoid that lookup now too.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/ehci-hcd.c   |   20 ++++++++------------
 drivers/usb/host/ehci-q.c     |   33 ++++++---------------------------
 drivers/usb/host/ehci-sched.c |   33 ++++++++++++++-------------------
 drivers/usb/host/ehci.h       |    3 ++-
 4 files changed, 30 insertions(+), 59 deletions(-)


diff -Nru a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
--- a/drivers/usb/host/ehci-hcd.c	2005-01-07 15:48:28 -08:00
+++ b/drivers/usb/host/ehci-hcd.c	2005-01-07 15:48:28 -08:00
@@ -895,6 +895,7 @@
  */
 static int ehci_urb_enqueue (
 	struct usb_hcd	*hcd,
+	struct usb_host_endpoint *ep,
 	struct urb	*urb,
 	int		mem_flags
 ) {
@@ -909,12 +910,12 @@
 	default:
 		if (!qh_urb_transaction (ehci, urb, &qtd_list, mem_flags))
 			return -ENOMEM;
-		return submit_async (ehci, urb, &qtd_list, mem_flags);
+		return submit_async (ehci, ep, urb, &qtd_list, mem_flags);
 
 	case PIPE_INTERRUPT:
 		if (!qh_urb_transaction (ehci, urb, &qtd_list, mem_flags))
 			return -ENOMEM;
-		return intr_submit (ehci, urb, &qtd_list, mem_flags);
+		return intr_submit (ehci, ep, urb, &qtd_list, mem_flags);
 
 	case PIPE_ISOCHRONOUS:
 		if (urb->dev->speed == USB_SPEED_HIGH)
@@ -1014,23 +1015,18 @@
 // bulk qh holds the data toggle
 
 static void
-ehci_endpoint_disable (struct usb_hcd *hcd, struct hcd_dev *dev, int ep)
+ehci_endpoint_disable (struct usb_hcd *hcd, struct usb_host_endpoint *ep)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
-	int			epnum;
 	unsigned long		flags;
 	struct ehci_qh		*qh, *tmp;
 
 	/* ASSERT:  any requests/urbs are being unlinked */
 	/* ASSERT:  nobody can be submitting urbs for this any more */
 
-	epnum = ep & USB_ENDPOINT_NUMBER_MASK;
-	if (epnum != 0 && (ep & USB_DIR_IN))
-		epnum |= 0x10;
-
 rescan:
 	spin_lock_irqsave (&ehci->lock, flags);
-	qh = (struct ehci_qh *) dev->ep [epnum];
+	qh = ep->hcpriv;
 	if (!qh)
 		goto done;
 
@@ -1072,12 +1068,12 @@
 		/* caller was supposed to have unlinked any requests;
 		 * that's not our job.  just leak this memory.
 		 */
-		ehci_err (ehci, "qh %p (#%d) state %d%s\n",
-			qh, epnum, qh->qh_state,
+		ehci_err (ehci, "qh %p (#%02x) state %d%s\n",
+			qh, ep->desc.bEndpointAddress, qh->qh_state,
 			list_empty (&qh->qtd_list) ? "" : "(has tds)");
 		break;
 	}
-	dev->ep[epnum] = NULL;
+	ep->hcpriv = NULL;
 done:
 	spin_unlock_irqrestore (&ehci->lock, flags);
 	return;
diff -Nru a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
--- a/drivers/usb/host/ehci-q.c	2005-01-07 15:48:28 -08:00
+++ b/drivers/usb/host/ehci-q.c	2005-01-07 15:48:28 -08:00
@@ -832,26 +832,8 @@
 			qtd = list_entry (qtd_list->next, struct ehci_qtd,
 					qtd_list);
 
-		/* control qh may need patching after enumeration */
+		/* control qh may need patching ... */
 		if (unlikely (epnum == 0)) {
-			/* set_address changes the address */
-			if ((qh->hw_info1 & QH_ADDR_MASK) == 0)
-				qh->hw_info1 |= cpu_to_le32 (
-						usb_pipedevice (urb->pipe));
-
-			/* for full speed, ep0 maxpacket can grow */
-			else if (!(qh->hw_info1
-					& __constant_cpu_to_le32 (0x3 << 12))) {
-				u32	info, max;
-
-				info = le32_to_cpu (qh->hw_info1);
-				max = urb->dev->descriptor.bMaxPacketSize0;
-				if (max > (0x07ff & (info >> 16))) {
-					info &= ~(0x07ff << 16);
-					info |= max << 16;
-					qh->hw_info1 = cpu_to_le32 (info);
-				}
-			}
 
                         /* usb_reset_device() briefly reverts to address 0 */
                         if (usb_pipedevice (urb->pipe) == 0)
@@ -908,33 +890,30 @@
 static int
 submit_async (
 	struct ehci_hcd		*ehci,
+	struct usb_host_endpoint *ep,
 	struct urb		*urb,
 	struct list_head	*qtd_list,
 	int			mem_flags
 ) {
 	struct ehci_qtd		*qtd;
-	struct hcd_dev		*dev;
 	int			epnum;
 	unsigned long		flags;
 	struct ehci_qh		*qh = NULL;
 
 	qtd = list_entry (qtd_list->next, struct ehci_qtd, qtd_list);
-	dev = (struct hcd_dev *)urb->dev->hcpriv;
-	epnum = usb_pipeendpoint (urb->pipe);
-	if (usb_pipein (urb->pipe) && !usb_pipecontrol (urb->pipe))
-		epnum |= 0x10;
+	epnum = ep->desc.bEndpointAddress;
 
 #ifdef EHCI_URB_TRACE
 	ehci_dbg (ehci,
 		"%s %s urb %p ep%d%s len %d, qtd %p [qh %p]\n",
 		__FUNCTION__, urb->dev->devpath, urb,
-		epnum & 0x0f, usb_pipein (urb->pipe) ? "in" : "out",
+		epnum & 0x0f, (epnum & USB_DIR_IN) ? "in" : "out",
 		urb->transfer_buffer_length,
-		qtd, dev ? dev->ep [epnum] : (void *)~0);
+		qtd, ep->hcpriv);
 #endif
 
 	spin_lock_irqsave (&ehci->lock, flags);
-	qh = qh_append_tds (ehci, urb, qtd_list, epnum, &dev->ep [epnum]);
+	qh = qh_append_tds (ehci, urb, qtd_list, epnum, &ep->hcpriv);
 
 	/* Control/bulk operations through TTs don't need scheduling,
 	 * the HC and TT handle it when the TT has a buffer ready.
diff -Nru a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
--- a/drivers/usb/host/ehci-sched.c	2005-01-07 15:48:28 -08:00
+++ b/drivers/usb/host/ehci-sched.c	2005-01-07 15:48:28 -08:00
@@ -525,6 +525,7 @@
 
 static int intr_submit (
 	struct ehci_hcd		*ehci,
+	struct usb_host_endpoint *ep,
 	struct urb		*urb,
 	struct list_head	*qtd_list,
 	int			mem_flags
@@ -532,23 +533,17 @@
 	unsigned		epnum;
 	unsigned long		flags;
 	struct ehci_qh		*qh;
-	struct hcd_dev		*dev;
-	int			is_input;
 	int			status = 0;
 	struct list_head	empty;
 
 	/* get endpoint and transfer/schedule data */
-	epnum = usb_pipeendpoint (urb->pipe);
-	is_input = usb_pipein (urb->pipe);
-	if (is_input)
-		epnum |= 0x10;
+	epnum = ep->desc.bEndpointAddress;
 
 	spin_lock_irqsave (&ehci->lock, flags);
-	dev = (struct hcd_dev *)urb->dev->hcpriv;
 
 	/* get qh and force any scheduling errors */
 	INIT_LIST_HEAD (&empty);
-	qh = qh_append_tds (ehci, urb, &empty, epnum, &dev->ep [epnum]);
+	qh = qh_append_tds (ehci, urb, &empty, epnum, &ep->hcpriv);
 	if (qh == 0) {
 		status = -ENOMEM;
 		goto done;
@@ -559,7 +554,7 @@
 	}
 
 	/* then queue the urb's tds to the qh */
-	qh = qh_append_tds (ehci, urb, qtd_list, epnum, &dev->ep [epnum]);
+	qh = qh_append_tds (ehci, urb, qtd_list, epnum, &ep->hcpriv);
 	BUG_ON (qh == 0);
 
 	/* ... update usbfs periodic stats */
@@ -689,7 +684,6 @@
 	 */
 	if (stream->refcount == 1) {
 		int		is_in;
-		struct hcd_dev	*dev = stream->udev->hcpriv;
 
 		// BUG_ON (!list_empty(&stream->td_list));
 
@@ -719,7 +713,7 @@
 
 		is_in = (stream->bEndpointAddress & USB_DIR_IN) ? 0x10 : 0;
 		stream->bEndpointAddress &= 0x0f;
-		dev->ep[is_in + stream->bEndpointAddress] = NULL;
+		stream->ep->hcpriv = NULL;
 
 		if (stream->rescheduled) {
 			ehci_info (ehci, "ep%d%s-iso rescheduled "
@@ -746,24 +740,25 @@
 iso_stream_find (struct ehci_hcd *ehci, struct urb *urb)
 {
 	unsigned		epnum;
-	struct hcd_dev		*dev;
 	struct ehci_iso_stream	*stream;
+	struct usb_host_endpoint *ep;
 	unsigned long		flags;
 
 	epnum = usb_pipeendpoint (urb->pipe);
 	if (usb_pipein(urb->pipe))
-		epnum += 0x10;
+		ep = urb->dev->ep_in[epnum];
+	else
+		ep = urb->dev->ep_out[epnum];
 
 	spin_lock_irqsave (&ehci->lock, flags);
-
-	dev = (struct hcd_dev *)urb->dev->hcpriv;
-	stream = dev->ep [epnum];
+	stream = ep->hcpriv;
 
 	if (unlikely (stream == 0)) {
 		stream = iso_stream_alloc(GFP_ATOMIC);
 		if (likely (stream != 0)) {
 			/* dev->ep owns the initial refcount */
-			dev->ep[epnum] = stream;
+			ep->hcpriv = stream;
+			stream->ep = ep;
 			iso_stream_init(stream, urb->dev, urb->pipe,
 					urb->interval);
 		}
@@ -771,8 +766,8 @@
 	/* if dev->ep [epnum] is a QH, info1.maxpacket is nonzero */
 	} else if (unlikely (stream->hw_info1 != 0)) {
 		ehci_dbg (ehci, "dev %s ep%d%s, not iso??\n",
-			urb->dev->devpath, epnum & 0x0f,
-			(epnum & 0x10) ? "in" : "out");
+			urb->dev->devpath, epnum,
+			usb_pipein(urb->pipe) ? "in" : "out");
 		stream = NULL;
 	}
 
diff -Nru a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
--- a/drivers/usb/host/ehci.h	2005-01-07 15:48:28 -08:00
+++ b/drivers/usb/host/ehci.h	2005-01-07 15:48:28 -08:00
@@ -36,7 +36,7 @@
 
 /* ehci_hcd->lock guards shared data against other CPUs:
  *   ehci_hcd:	async, reclaim, periodic (and shadow), ...
- *   hcd_dev:	ep[]
+ *   usb_host_endpoint: hcpriv
  *   ehci_qh:	qh_next, qtd_list
  *   ehci_qtd:	qtd_list
  *
@@ -430,6 +430,7 @@
 	struct list_head	td_list;	/* queued itds/sitds */
 	struct list_head	free_list;	/* list of unused itds/sitds */
 	struct usb_device	*udev;
+ 	struct usb_host_endpoint *ep;
 
 	/* output of (re)scheduling */
 	unsigned long		start;		/* jiffies */

