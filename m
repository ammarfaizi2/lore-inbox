Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbTDQFvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbTDQFvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:51:07 -0400
Received: from granite.he.net ([216.218.226.66]:50704 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263074AbTDQFuy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:50:54 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1050559505786@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.67
In-Reply-To: <10505595041530@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 16 Apr 2003 23:05:05 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1063, 2003/04/14 10:26:02-07:00, david-b@pacbell.net

[PATCH] USB: EHCI disconnect cleanup

So here's the EHCI implementation of that new callback,
morphed/simplified from the old "free_config" one (which
is now gone).  It looks almost identical to the OHCI
version, except the dummy TDs work a bit differently.

Again, drivers that clean themselves up in disconnect()
shouldn't notice this change.  I didn't re-test this;
I don't have devices with the other kind of driver.  You
should do so with one of yours (high speed hub and TT).

There are still about half a dozen places in usbcore
and the HCDs that would benefit from using this new
callback, FWIW.  I'd call them non-critical bugfixes
that should wait a bit, while this batch shakes out.


diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	Wed Apr 16 10:48:49 2003
+++ b/drivers/usb/core/hcd.c	Wed Apr 16 10:48:49 2003
@@ -1353,9 +1353,6 @@
 		return -EINVAL;
 	}
 
-	if (hcd->driver->free_config)
-		hcd->driver->free_config (hcd, udev);
-
 	spin_lock_irqsave (&hcd_data_lock, flags);
 	list_del (&dev->dev_list);
 	udev->hcpriv = NULL;
diff -Nru a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
--- a/drivers/usb/core/hcd.h	Wed Apr 16 10:48:48 2003
+++ b/drivers/usb/core/hcd.h	Wed Apr 16 10:48:48 2003
@@ -196,11 +196,6 @@
 					int mem_flags);
 	int	(*urb_dequeue) (struct usb_hcd *hcd, struct urb *urb);
 
-	// frees configuration resources -- allocated as needed during
-	// urb_enqueue, and not freed by urb_dequeue
-	void		(*free_config) (struct usb_hcd *hcd,
-				struct usb_device *dev);
-
 	/* hw synch, freeing endpoint resources that urb_dequeue can't */
 	void 	(*endpoint_disable)(struct usb_hcd *hcd,
 			struct hcd_dev *dev, int bEndpointAddress);
diff -Nru a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
--- a/drivers/usb/host/ehci-hcd.c	Wed Apr 16 10:48:49 2003
+++ b/drivers/usb/host/ehci-hcd.c	Wed Apr 16 10:48:49 2003
@@ -870,80 +870,55 @@
 
 // bulk qh holds the data toggle
 
-static void ehci_free_config (struct usb_hcd *hcd, struct usb_device *udev)
+static void
+ehci_endpoint_disable (struct usb_hcd *hcd, struct hcd_dev *dev, int ep)
 {
-	struct hcd_dev		*dev = (struct hcd_dev *)udev->hcpriv;
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
-	int			i;
+	int			epnum;
 	unsigned long		flags;
+	struct ehci_qh		*qh;
 
-	/* ASSERT:  no requests/urbs are still linked (so no TDs) */
+	/* ASSERT:  any requests/urbs are being unlinked */
 	/* ASSERT:  nobody can be submitting urbs for this any more */
 
-	ehci_dbg (ehci, "free_config %s devnum %d\n",
-			udev->devpath, udev->devnum);
+	ehci_dbg (ehci, "ep %02x disable\n", ep);
+	epnum = ep & USB_ENDPOINT_NUMBER_MASK;
+	if (epnum != 0 && (ep & USB_DIR_IN))
+		epnum |= 0x10;
 
+rescan:
 	spin_lock_irqsave (&ehci->lock, flags);
-	for (i = 0; i < 32; i++) {
-		if (dev->ep [i]) {
-			struct ehci_qh		*qh;
-			char			*why;
-
-			/* dev->ep never has ITDs or SITDs */
-			qh = (struct ehci_qh *) dev->ep [i];
-
-			/* detect/report non-recoverable errors */
-			if (in_interrupt ()) 
-				why = "disconnect() didn't";
-			else if ((qh->hw_info2 & cpu_to_le32 (0xffff)) != 0
-					&& qh->qh_state != QH_STATE_IDLE)
-				why = "(active periodic)";
-			else
-				why = 0;
-			if (why) {
-				err ("dev %s-%s ep %d-%s error: %s",
-					hcd_to_bus (hcd)->bus_name,
-					udev->devpath,
-					i & 0xf, (i & 0x10) ? "IN" : "OUT",
-					why);
-				BUG ();
-			}
-
-			dev->ep [i] = 0;
-			if (qh->qh_state == QH_STATE_IDLE)
-				goto idle;
-			ehci_dbg (ehci, "free_config, async ep 0x%02x qh %p",
-					i, qh);
-
-			/* scan_async() empties the ring as it does its work,
-			 * using IAA, but doesn't (yet?) turn it off.  if it
-			 * doesn't empty this qh, likely it's the last entry.
-			 */
-			while (qh->qh_state == QH_STATE_LINKED
-					&& ehci->reclaim
-					&& HCD_IS_RUNNING (ehci->hcd.state)
-					) {
-				spin_unlock_irqrestore (&ehci->lock, flags);
-				/* wait_ms() won't spin, we're a thread;
-				 * and we know IRQ/timer/... can progress
-				 */
-				wait_ms (1);
-				spin_lock_irqsave (&ehci->lock, flags);
-			}
-			if (qh->qh_state == QH_STATE_LINKED)
-				start_unlink_async (ehci, qh);
-			while (qh->qh_state != QH_STATE_IDLE
-					&& ehci->hcd.state != USB_STATE_HALT) {
-				spin_unlock_irqrestore (&ehci->lock, flags);
-				wait_ms (1);
-				spin_lock_irqsave (&ehci->lock, flags);
-			}
-idle:
+	qh = (struct ehci_qh *) dev->ep [epnum];
+	if (!qh)
+		goto done;
+
+	if (!HCD_IS_RUNNING (ehci->hcd.state))
+		qh->qh_state = QH_STATE_IDLE;
+	switch (qh->qh_state) {
+	case QH_STATE_UNLINK:		/* wait for hw to finish? */
+		spin_unlock_irqrestore (&ehci->lock, flags);
+		set_current_state (TASK_UNINTERRUPTIBLE);
+		schedule_timeout (1);
+		goto rescan;
+	case QH_STATE_IDLE:		/* fully unlinked */
+		if (list_empty (&qh->qtd_list)) {
 			qh_put (ehci, qh);
+			break;
 		}
+		/* else FALL THROUGH */
+	default:
+		/* caller was supposed to have unlinked any requests;
+		 * that's not our job.  just leak this memory.
+		 */
+		ehci_err (ehci, "qh %p (#%d) state %d%s\n",
+			qh, epnum, qh->qh_state,
+			list_empty (&qh->qtd_list) ? "" : "(has tds)");
+		break;
 	}
-
+	dev->ep [epnum] = 0;
+done:
 	spin_unlock_irqrestore (&ehci->lock, flags);
+	return;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -978,7 +953,7 @@
 	 */
 	.urb_enqueue =		ehci_urb_enqueue,
 	.urb_dequeue =		ehci_urb_dequeue,
-	.free_config =		ehci_free_config,
+	.endpoint_disable =	ehci_endpoint_disable,
 
 	/*
 	 * scheduling support

