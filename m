Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965242AbWILO23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbWILO23 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 10:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbWILO23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 10:28:29 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:44300 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S965243AbWILO22
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 10:28:28 -0400
Date: Tue, 12 Sep 2006 10:28:27 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1
In-Reply-To: <200609120008.19714.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.0609121007530.6338-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2006, Rafael J. Wysocki wrote:

> Now I have another symtom: during the _second_ suspend the suspending of
> USB controllers fails with messages like this:
> 
> usb_hcd_pci_suspend(): ehci_pci_suspend+0x0/0xab [ehci_hcd]() returns -22
> pci_device_suspend(): usb_hcd_pci_suspend+0x0/0x16d [usbcore]() returns -22
> suspend_device(): pci_device_suspend+0x0/0x4b() returns -22
> Could not suspend device 0000:00:13.2: error -22
> 
> Could you please tell me which patches might have caused this, in your opinion?

It's a little difficult to pin down the blame.  In one form or another
this problem probably existed all along, although it may not have been 
very obvious.

For those interested in the explanation:

The EHCI USB controller is represented in sysfs by two device structures.  
The higher one represents the controller's PCI interface (let's call it
the "PCI-controller") and the lower one represents the USB interface
(let's call it the "root hub").  Inside the resume() routine for the
PCI-controller, if the driver finds that power was lost during the suspend
-- as it would be for suspend-to-disk -- the driver reinitializes the root
hub but without telling usbcore it has done so.  If the root hub had
already been suspended at the time of the suspend-to-disk, then
resume-from-disk would skip calling its resume() method.  So as far as 
usbcore knows the root hub should still be suspended, but in fact it is 
awake.

Consequently during the second suspend-to-disk, usbcore does not pass the
suspend() call on to the root hub's driver.  Then the suspend() method for
the PCI-controller fails, because it sees that the child root hub is still
unsuspended.

I was just going to send in a patch to fix the problem.  I haven't had
much of a chance to try it out yet.  The patch is included below, so you
can test it right away and let me know if it works for you before I submit 
it.

Alan Stern


Index: usb-2.6/drivers/usb/core/hub.c
===================================================================
--- usb-2.6.orig/drivers/usb/core/hub.c
+++ usb-2.6/drivers/usb/core/hub.c
@@ -1066,6 +1066,12 @@ void usb_root_hub_lost_power(struct usb_
 	unsigned long flags;
 
 	dev_warn(&rhdev->dev, "root hub lost power or was reset\n");
+
+	/* Make sure no potential wakeup events get lost,
+	 * by forcing the root hub to be resumed.
+	 */
+	rhdev->dev.power.prev_state.event = PM_EVENT_ON;
+
 	spin_lock_irqsave(&device_state_lock, flags);
 	hub = hdev_to_hub(rhdev);
 	for (port1 = 1; port1 <= rhdev->maxchild; ++port1) {

