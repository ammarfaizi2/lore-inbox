Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVAHGbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVAHGbP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVAHGa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:30:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:15238 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261927AbVAHFsq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:46 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632663258@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:46 -0800
Message-Id: <11051632662317@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.26, 2004/12/15 16:37:38-08:00, david-b@pacbell.net

[PATCH] USB: UHCI and HCD API change (14/15)

UHCI changes to match the updated HCD glue calls.  Since it's handed the
relevant endpoint queue on a silver platter, the driver no longer needs
to search anything to find the queue entries.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/uhci-hcd.c |   39 +++++----------------------------------
 1 files changed, 5 insertions(+), 34 deletions(-)


diff -Nru a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
--- a/drivers/usb/host/uhci-hcd.c	2005-01-07 15:48:04 -08:00
+++ b/drivers/usb/host/uhci-hcd.c	2005-01-07 15:48:04 -08:00
@@ -1255,7 +1255,9 @@
 	return NULL;
 }
 
-static int uhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, int mem_flags)
+static int uhci_urb_enqueue(struct usb_hcd *hcd,
+		struct usb_host_endpoint *ep,
+		struct urb *urb, int mem_flags)
 {
 	int ret;
 	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
@@ -2293,44 +2295,13 @@
 	return &uhci->hcd;
 }
 
-/* Are there any URBs for a particular device/endpoint on a given list? */
-static int urbs_for_ep_list(struct list_head *head,
-		struct hcd_dev *hdev, int ep)
-{
-	struct urb_priv *urbp;
-
-	list_for_each_entry(urbp, head, urb_list) {
-		struct urb *urb = urbp->urb;
-
-		if (hdev == urb->dev->hcpriv && ep ==
-				(usb_pipeendpoint(urb->pipe) |
-				 usb_pipein(urb->pipe)))
-			return 1;
-	}
-	return 0;
-}
-
-/* Are there any URBs for a particular device/endpoint? */
-static int urbs_for_ep(struct uhci_hcd *uhci, struct hcd_dev *hdev, int ep)
-{
-	int rc;
-
-	spin_lock_irq(&uhci->schedule_lock);
-	rc = (urbs_for_ep_list(&uhci->urb_list, hdev, ep) ||
-			urbs_for_ep_list(&uhci->complete_list, hdev, ep) ||
-			urbs_for_ep_list(&uhci->urb_remove_list, hdev, ep));
-	spin_unlock_irq(&uhci->schedule_lock);
-	return rc;
-}
-
 /* Wait until all the URBs for a particular device/endpoint are gone */
 static void uhci_hcd_endpoint_disable(struct usb_hcd *hcd,
-		struct hcd_dev *hdev, int endpoint)
+		struct usb_host_endpoint *ep)
 {
 	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
 
-	wait_event_interruptible(uhci->waitqh,
-			!urbs_for_ep(uhci, hdev, endpoint));
+	wait_event_interruptible(uhci->waitqh, list_empty(&ep->urb_list));
 }
 
 static int uhci_hcd_get_frame_number(struct usb_hcd *hcd)

