Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbTDQFyG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbTDQFwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:52:55 -0400
Received: from granite.he.net ([216.218.226.66]:54032 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263080AbTDQFu7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:50:59 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1050559504756@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.67
In-Reply-To: <10505595042978@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 16 Apr 2003 23:05:04 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1058, 2003/04/14 10:20:28-07:00, david-b@pacbell.net

[PATCH] disconnect cleanup, new HCD callback

Attached, find a patch that "ought to" teach OHCI how to do that
cleanup, by implementing the new callback.  (And the first half
is the patch you applied, with that irqsave tweak -- so you should
already have it.)


diff -Nru a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
--- a/drivers/usb/host/ohci-hcd.c	Wed Apr 16 10:49:20 2003
+++ b/drivers/usb/host/ohci-hcd.c	Wed Apr 16 10:49:20 2003
@@ -313,65 +313,56 @@
  */
 
 static void
-ohci_free_config (struct usb_hcd *hcd, struct usb_device *udev)
+ohci_endpoint_disable (struct usb_hcd *hcd, struct hcd_dev *dev, int ep)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
-	struct hcd_dev		*dev = (struct hcd_dev *) udev->hcpriv;
-	int			i;
+	int			epnum = ep & USB_ENDPOINT_NUMBER_MASK;
 	unsigned long		flags;
+	struct ed		*ed;
 
-rescan:
-	/* free any eds, and dummy tds, still hanging around */
-	spin_lock_irqsave (&ohci->lock, flags);
-	for (i = 0; i < 32; i++) {
-		struct ed	*ed = dev->ep [i];
+	/* ASSERT:  any requests/urbs are being unlinked */
+	/* ASSERT:  nobody can be submitting urbs for this any more */
 
-		if (!ed)
-			continue;
+	ohci_dbg (ohci, "ep %02x disable\n", ep);
+	epnum <<= 1;
+	if (epnum != 0 && !(ep & USB_DIR_IN))
+		epnum |= 1;
 
-		if (ohci->disabled && ed->state != ED_IDLE)
-			ed->state = ED_IDLE;
-		switch (ed->state) {
-		case ED_UNLINK:		/* wait a frame? */
-			goto do_rescan;
-		case ED_IDLE:		/* fully unlinked */
+rescan:
+	spin_lock_irqsave (&ohci->lock, flags);
+	ed = dev->ep [epnum];
+	if (!ed)
+		goto done;
+
+	if (!HCD_IS_RUNNING (ohci->hcd.state) || ohci->disabled)
+		ed->state = ED_IDLE;
+	switch (ed->state) {
+	case ED_UNLINK:		/* wait for hw to finish? */
+		spin_unlock_irqrestore (&ohci->lock, flags);
+		set_current_state (TASK_UNINTERRUPTIBLE);
+		schedule_timeout (1);
+		goto rescan;
+	case ED_IDLE:		/* fully unlinked */
+		if (list_empty (&ed->td_list)) {
 			td_free (ohci, ed->dummy);
+			ed_free (ohci, ed);
 			break;
-		default:
-			ohci_err (ohci,
-				"dev %s ep%d-%s linked; disconnect() bug?\n",
-				udev->devpath,
-				(i >> 1) & 0x0f, (i & 1) ? "out" : "in");
-
-			/* ED_OPER: some driver disconnect() is broken,
-			 * it didn't even start its unlinks much less wait
-			 * for their completions.
-			 * OTHERWISE:  hcd bug, ed is garbage
-			 *
-			 * ... we can't recycle this memory in either case,
-			 * so just leak it to avoid oopsing.
-			 */
-			continue;
 		}
-		ed_free (ohci, ed);
+		/* else FALL THROUGH */
+	default:
+		/* caller was supposed to have unlinked any requests;
+		 * that's not our job.  can't recover; must leak ed.
+		 */
+		ohci_err (ohci, "ed %p (#%d) state %d%s\n",
+			ed, epnum, ed->state,
+			list_empty (&ed->td_list) ? "" : "(has tds)");
+		td_free (ohci, ed->dummy);
+		break;
 	}
+	dev->ep [epnum] = 0;
+done:
 	spin_unlock_irqrestore (&ohci->lock, flags);
 	return;
-
-do_rescan:
-#ifdef DEBUG
-	/* a driver->disconnect() returned before its unlinks completed? */
-	if (in_interrupt ()) {
-		ohci_warn (ohci,
-			"driver disconnect() bug %s ep%d-%s\n", 
-			udev->devpath,
-			(i >> 1) & 0x0f, (i & 1) ? "out" : "in");
-	}
-#endif
-
-	spin_unlock_irqrestore (&ohci->lock, flags);
-	wait_ms (1);
-	goto rescan;
 }
 
 static int ohci_get_frame (struct usb_hcd *hcd)
diff -Nru a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
--- a/drivers/usb/host/ohci-pci.c	Wed Apr 16 10:49:20 2003
+++ b/drivers/usb/host/ohci-pci.c	Wed Apr 16 10:49:20 2003
@@ -334,7 +334,7 @@
 	 */
 	.urb_enqueue =		ohci_urb_enqueue,
 	.urb_dequeue =		ohci_urb_dequeue,
-	.free_config =		ohci_free_config,
+	.endpoint_disable =	ohci_endpoint_disable,
 
 	/*
 	 * scheduling support
diff -Nru a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
--- a/drivers/usb/host/ohci-sa1111.c	Wed Apr 16 10:49:20 2003
+++ b/drivers/usb/host/ohci-sa1111.c	Wed Apr 16 10:49:20 2003
@@ -333,7 +333,7 @@
 	 */
 	.urb_enqueue =		ohci_urb_enqueue,
 	.urb_dequeue =		ohci_urb_dequeue,
-	.free_config =		ohci_free_config,
+	.endpoint_disable =	ohci_endpoint_disable,
 
 	/*
 	 * scheduling support
diff -Nru a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
--- a/drivers/usb/host/uhci-hcd.c	Wed Apr 16 10:49:20 2003
+++ b/drivers/usb/host/uhci-hcd.c	Wed Apr 16 10:49:20 2003
@@ -2390,7 +2390,6 @@
 
 	.urb_enqueue =		uhci_urb_enqueue,
 	.urb_dequeue =		uhci_urb_dequeue,
-	.free_config =		NULL,
 
 	.get_frame_number =	uhci_hcd_get_frame_number,
 

