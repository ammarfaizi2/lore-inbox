Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVASFVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVASFVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 00:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVASFVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 00:21:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30872 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261585AbVASFUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 00:20:52 -0500
Date: Tue, 18 Jan 2005 21:20:33 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: rmk@arm.linux.org.uk
Cc: zaitcev@redhat.com, david-b@pacbell.net, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: usbmon, usb core, ARM
Message-ID: <20050118212033.26e1b6f0@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Russell:

I have a favour to ask of you. I need the following patch to be applied
to the USB core:

diff -urpN -X dontdiff linux-2.6.11-rc1-bk4/drivers/usb/core/hcd.c linux-2.6.11-rc1-bk4-lem/drivers/usb/core/hcd.c
--- linux-2.6.11-rc1-bk4/drivers/usb/core/hcd.c	2005-01-12 16:35:53.000000000 -0800
+++ linux-2.6.11-rc1-bk4-lem/drivers/usb/core/hcd.c	2005-01-17 21:38:51.000000000 -0800
@@ -1099,14 +1104,12 @@ static int hcd_submit_urb (struct urb *u
 	urb = usb_get_urb (urb);
 	atomic_inc (&urb->use_count);
 
-	if (urb->dev == hcd->self.root_hub) {
+	if (usb_pipedevice(urb->pipe) == 1) {
 		/* NOTE:  requirement on hub callers (usbfs and the hub
 		 * driver, for now) that URBs' urb->transfer_buffer be
 		 * valid and usb_buffer_{sync,unmap}() not be needed, since
 		 * they could clobber root hub response data.
 		 */
-		urb->transfer_flags |= (URB_NO_TRANSFER_DMA_MAP
-					| URB_NO_SETUP_DMA_MAP);
 		status = rh_urb_enqueue (hcd, urb);
 		goto done;
 	}
@@ -1168,7 +1171,7 @@ unlink1 (struct usb_hcd *hcd, struct urb
 {
 	int		value;
 
-	if (urb->dev == hcd->self.root_hub)
+	if (usb_pipedevice(urb->pipe) == 1)
 		value = usb_rh_urb_dequeue (hcd, urb);
 	else {
 
@@ -1258,7 +1261,7 @@ static int hcd_unlink_urb (struct urb *u
 	 * finish unlinking the initial failed usb_set_address()
 	 * or device descriptor fetch.
 	 */
-	if (!hcd->saw_irq && hcd->self.root_hub != urb->dev) {
+	if (!hcd->saw_irq && usb_pipedevice(urb->pipe) != 1) {
 		dev_warn (hcd->self.controller, "Unlink after no-IRQ?  "
 			"Controller is probably using the wrong IRQ."
 			"\n");
@@ -1465,12 +1468,8 @@ void usb_hcd_giveback_urb (struct usb_hc
 {
 	urb_unlink (urb);
 
-	// NOTE:  a generic device/urb monitoring hook would go here.
-	// hcd_monitor_hook(MONITOR_URB_FINISH, urb, dev)
-	// It would catch exit/unlink paths for all urbs.
-
 	/* lower level hcd code should use *_dma exclusively */
-	if (hcd->self.controller->dma_mask) {
+	if (hcd->self.controller->dma_mask && usb_pipedevice(urb->pipe) != 1) {
 		if (usb_pipecontrol (urb->pipe)
 			&& !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP))
 			dma_unmap_single (hcd->self.controller, urb->setup_dma,

However, David objects to the patch on the grounds that it can damage ARM.
I am sure that what I do matches perfectly what ARM needs, based on this:
 http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.5/usb-core-2-2.5.33.patch

#    This was first noticed on ARM (no surprises here); the root hub
#    code, rh_call_control(), placed data into the buffer and then
#    called usb_hcd_giveback_urb().  This function called
#    pci_unmap_single() on this region which promptly destroyed the
#    data that rh_call_control() had placed there.  This lead to a
#    corrupted device descriptor and the "too many configurations"
#    message.

So, it would help me a lot if you tested the patch on a system with SA-1111
against a regression and thus buried this silly ARM canard decisively.

Please let me know if you have time to help me out.

Thank you,
-- Pete
