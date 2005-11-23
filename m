Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVKWXtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVKWXtB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVKWXrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:47:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:36546 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751337AbVKWXqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:37 -0500
Date: Wed, 23 Nov 2005 15:45:28 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       david-b@pacbell.net
Subject: [patch 16/22] USB: EHCI updates
Message-ID: <20051123234528.GQ527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-ehci-updates.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

This fixes some bugs in EHCI suspend/resume that joined us over the past
few releases (as usbcore, PCI, pmcore, and other components evolved):

  - Removes suspend and resume recursion from the EHCI driver, getting
    rid of the USB_SUSPEND special casing.

  - Updates the wakeup mechanism to work again; there's a newish usbcore
    call it needs to use.

  - Provide simpler tests for "do we need to restart from scratch", to
    address another case where PCI Vaux was lost.  (In this case it was
    restoring a swsusp snapshot, but there could be others.)

Un-exports a symbol that was temporarily exported.

A notable change from previous version is that this doesn't move
the spinlock init, so there's still a resume/reinit path bug.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/core/hub.c      |    1 
 drivers/usb/host/ehci-hcd.c |    3 -
 drivers/usb/host/ehci-hub.c |    7 ++++
 drivers/usb/host/ehci-pci.c |   77 +++++++++++++++++++++-----------------------
 4 files changed, 46 insertions(+), 42 deletions(-)

--- usb-2.6.orig/drivers/usb/host/ehci-hcd.c
+++ usb-2.6/drivers/usb/host/ehci-hcd.c
@@ -636,9 +636,8 @@ static irqreturn_t ehci_irq (struct usb_
 			 * stop that signaling.
 			 */
 			ehci->reset_done [i] = jiffies + msecs_to_jiffies (20);
-			mod_timer (&hcd->rh_timer,
-					ehci->reset_done [i] + 1);
 			ehci_dbg (ehci, "port %d remote wakeup\n", i + 1);
+			usb_hcd_resume_root_hub(hcd);
 		}
 	}
 
--- usb-2.6.orig/drivers/usb/host/ehci-pci.c
+++ usb-2.6/drivers/usb/host/ehci-pci.c
@@ -235,10 +235,11 @@ static void ehci_pci_stop (struct usb_hc
 
 /* suspend/resume, section 4.3 */
 
-/* These routines rely on the bus (pci, platform, etc)
+/* These routines rely on the PCI bus glue
  * to handle powerdown and wakeup, and currently also on
  * transceivers that don't need any software attention to set up
  * the right sort of wakeup.
+ * Also they depend on separate root hub suspend/resume.
  */
 
 static int ehci_pci_suspend (struct usb_hcd *hcd, pm_message_t message)
@@ -246,17 +247,9 @@ static int ehci_pci_suspend (struct usb_
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
 
 	if (time_before (jiffies, ehci->next_statechange))
-		msleep (100);
-
-#ifdef	CONFIG_USB_SUSPEND
-	(void) usb_suspend_device (hcd->self.root_hub);
-#else
-	usb_lock_device (hcd->self.root_hub);
-	(void) ehci_bus_suspend (hcd);
-	usb_unlock_device (hcd->self.root_hub);
-#endif
+		msleep (10);
 
-	// save (PCI) FLADJ in case of Vaux power loss
+	// could save FLADJ in case of Vaux power loss
 	// ... we'd only use it to handle clock skew
 
 	return 0;
@@ -269,13 +262,18 @@ static int ehci_pci_resume (struct usb_h
 	struct usb_device	*root = hcd->self.root_hub;
 	int			retval = -EINVAL;
 
-	// maybe restore (PCI) FLADJ
+	// maybe restore FLADJ
 
 	if (time_before (jiffies, ehci->next_statechange))
 		msleep (100);
 
+	/* If CF is clear, we lost PCI Vaux power and need to restart.  */
+	if (readl (&ehci->regs->configured_flag) != cpu_to_le32(FLAG_CF))
+		goto restart;
+
 	/* If any port is suspended (or owned by the companion),
 	 * we know we can/must resume the HC (and mustn't reset it).
+	 * We just defer that to the root hub code.
 	 */
 	for (port = HCS_N_PORTS (ehci->hcs_params); port > 0; ) {
 		u32	status;
@@ -283,42 +281,43 @@ static int ehci_pci_resume (struct usb_h
 		status = readl (&ehci->regs->port_status [port]);
 		if (!(status & PORT_POWER))
 			continue;
-		if (status & (PORT_SUSPEND | PORT_OWNER)) {
-			down (&hcd->self.root_hub->serialize);
-			retval = ehci_bus_resume (hcd);
-			up (&hcd->self.root_hub->serialize);
-			break;
+		if (status & (PORT_SUSPEND | PORT_RESUME | PORT_OWNER)) {
+			usb_hcd_resume_root_hub(hcd);
+			return 0;
 		}
+	}
+
+restart:
+	ehci_dbg(ehci, "lost power, restarting\n");
+	for (port = HCS_N_PORTS (ehci->hcs_params); port > 0; ) {
+		port--;
 		if (!root->children [port])
 			continue;
-		dbg_port (ehci, __FUNCTION__, port + 1, status);
 		usb_set_device_state (root->children[port],
 					USB_STATE_NOTATTACHED);
 	}
 
 	/* Else reset, to cope with power loss or flush-to-storage
-	 * style "resume" having activated BIOS during reboot.
+	 * style "resume" having let BIOS kick in during reboot.
 	 */
-	if (port == 0) {
-		(void) ehci_halt (ehci);
-		(void) ehci_reset (ehci);
-		(void) ehci_pci_reset (hcd);
-
-		/* emptying the schedule aborts any urbs */
-		spin_lock_irq (&ehci->lock);
-		if (ehci->reclaim)
-			ehci->reclaim_ready = 1;
-		ehci_work (ehci, NULL);
-		spin_unlock_irq (&ehci->lock);
-
-		/* restart; khubd will disconnect devices */
-		retval = ehci_run (hcd);
-
-		/* here we "know" root ports should always stay powered;
-		 * but some controllers may lose all power.
-		 */
-		ehci_port_power (ehci, 1);
-	}
+	(void) ehci_halt (ehci);
+	(void) ehci_reset (ehci);
+	(void) ehci_pci_reset (hcd);
+
+	/* emptying the schedule aborts any urbs */
+	spin_lock_irq (&ehci->lock);
+	if (ehci->reclaim)
+		ehci->reclaim_ready = 1;
+	ehci_work (ehci, NULL);
+	spin_unlock_irq (&ehci->lock);
+
+	/* restart; khubd will disconnect devices */
+	retval = ehci_run (hcd);
+
+	/* here we "know" root ports should always stay powered;
+	 * but some controllers may lose all power.
+	 */
+	ehci_port_power (ehci, 1);
 
 	return retval;
 }
--- usb-2.6.orig/drivers/usb/host/ehci-hub.c
+++ usb-2.6/drivers/usb/host/ehci-hub.c
@@ -94,6 +94,13 @@ static int ehci_bus_resume (struct usb_h
 		msleep(5);
 	spin_lock_irq (&ehci->lock);
 
+	/* Ideally and we've got a real resume here, and no port's power
+	 * was lost.  (For PCI, that means Vaux was maintained.)  But we
+	 * could instead be restoring a swsusp snapshot -- so that BIOS was
+	 * the last user of the controller, not reset/pm hardware keeping
+	 * state we gave to it.
+	 */
+
 	/* re-init operational registers in case we lost power */
 	if (readl (&ehci->regs->intr_enable) == 0) {
  		/* at least some APM implementations will try to deliver
--- usb-2.6.orig/drivers/usb/core/hub.c
+++ usb-2.6/drivers/usb/core/hub.c
@@ -1669,7 +1669,6 @@ int usb_suspend_device(struct usb_device
 	return 0;
 #endif
 }
-EXPORT_SYMBOL_GPL(usb_suspend_device);
 
 /*
  * If the USB "suspend" state is in use (rather than "global suspend"),

--
