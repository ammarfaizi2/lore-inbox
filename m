Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268672AbUJDWSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268672AbUJDWSz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268520AbUJDVd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:33:59 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:33995 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S268650AbUJDVcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:32:10 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: PATCH/RFC: ohci wakeup updates (4/4)
Date: Mon, 4 Oct 2004 14:11:25 -0700
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410041411.25567.david-b@pacbell.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9xbYBayHnvK19W6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_9xbYBayHnvK19W6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The HCDs that understand about wakeup (OHCI, EHCI) would
need small tweaks to use the driver model hooks.

EHCI needs comparable changes, but I didn't want to spend
the time splitting them out from other patches unless there
was some agreement that this was the way the driver model
should expose wakeup.

--Boundary-00=_9xbYBayHnvK19W6
Content-Type: text/x-diff;
  charset="us-ascii";
  name="wake-ohci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="wake-ohci.patch"

Makes OHCI use the new pmcore wakeup bits, not the old usbcore ones.
Also includes a slightly better interpretation of the RWC bit.

[ against Greg's 2.6.9-rc3 USB tree, hence 2.6.9-rc3-mm2 ]


--- 1.83/drivers/usb/host/ohci-hcd.c	Fri Oct  1 16:23:18 2004
+++ edited/drivers/usb/host/ohci-hcd.c	Sat Oct  2 11:01:41 2004
@@ -505,10 +505,6 @@
 			hcfs2string (ohci->hc_control & OHCI_CTRL_HCFS),
 			ohci->hc_control);
 
-	if (ohci->hc_control & OHCI_CTRL_RWC
-			&& !(ohci->flags & OHCI_QUIRK_AMD756))
-		ohci->hcd.can_wakeup = 1;
-
 	switch (ohci->hc_control & OHCI_CTRL_HCFS) {
 	case OHCI_USB_OPER:
 		temp = 0;
@@ -655,7 +651,7 @@
 		usb_set_device_state (udev, USB_STATE_CONFIGURED);
 		return 0;
 	}
- 
+
 	/* connect the virtual root hub */
 	udev = usb_alloc_dev (NULL, bus, 0);
 	if (!udev) {
@@ -664,6 +660,11 @@
 		writel (ohci->hc_control, &ohci->regs->control);
 		return -ENOMEM;
 	}
+	/* RWC doesn't always mean the same thing... */
+	if (device_can_wakeup(bus->controller))
+		device_init_wakeup(bus->controller,
+				ohci->hc_control & OHCI_CTRL_RWC);
+	device_init_wakeup(&udev->dev, !(ohci->flags & OHCI_QUIRK_AMD756));
 
 	udev->speed = USB_SPEED_FULL;
 	if (hcd_register_root (udev, &ohci->hcd) != 0) {
--- 1.36/drivers/usb/host/ohci-hub.c	Mon Sep 20 10:31:27 2004
+++ edited/drivers/usb/host/ohci-hub.c	Sat Oct  2 11:01:41 2004
@@ -105,7 +105,7 @@
 	writel (ohci_readl (&ohci->regs->intrstatus), &ohci->regs->intrstatus);
 
 	/* maybe resume can wake root hub */
-	if (ohci->hcd.remote_wakeup)
+	if (device_may_wakeup(&root->dev))
 		ohci->hc_control |= OHCI_CTRL_RWE;
 	else
 		ohci->hc_control &= ~OHCI_CTRL_RWE;
@@ -231,7 +231,7 @@
 	msleep (3);
 
 	temp = OHCI_CONTROL_INIT | OHCI_USB_OPER;
-	if (ohci->hcd.can_wakeup)
+	if (device_can_wakeup(hcd->self.controller));
 		temp |= OHCI_CTRL_RWC;
 	ohci->hc_control = temp;
 	writel (temp, &ohci->regs->control);
@@ -347,7 +347,8 @@
 		 */
 		if (!(status & RH_PS_CCS))
 			continue;
-		if ((status & RH_PS_PSS) && ohci->hcd.remote_wakeup)
+		if ((status & RH_PS_PSS)
+				&& device_may_wakeup(&hcd->self.root_hub->dev))
 			continue;
 		can_suspend = 0;
 	}

--Boundary-00=_9xbYBayHnvK19W6--
