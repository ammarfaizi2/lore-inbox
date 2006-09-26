Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWIZFjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWIZFjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWIZFjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:39:22 -0400
Received: from cantor2.suse.de ([195.135.220.15]:31189 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751318AbWIZFix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:53 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 16/47] PM: USB HCDs use PM_EVENT_PRETHAW
Date: Mon, 25 Sep 2006 22:37:36 -0700
Message-Id: <11592491342421-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491303012-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

This teaches several USB host controller drivers to treat PRETHAW as a chip
reset since the controller, and all devices connected to it, are no longer in
states compatible with how the snapshotted suspend() left them.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/core/hcd-pci.c   |    2 +-
 drivers/usb/host/ehci-pci.c  |    6 ++++++
 drivers/usb/host/ohci-pci.c  |    5 +++++
 drivers/usb/host/sl811-hcd.c |    9 +++++++--
 drivers/usb/host/uhci-hcd.c  |    4 ++++
 5 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 5078fb3..fa36391 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -281,7 +281,7 @@ int usb_hcd_pci_suspend (struct pci_dev 
 			(void) usb_hcd_pci_resume (dev);
 		}
 
-	} else {
+	} else if (hcd->state != HC_STATE_HALT) {
 		dev_dbg (hcd->self.controller, "hcd state %d; not suspended\n",
 			hcd->state);
 		WARN_ON(1);
diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index cadffac..6967ab7 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -238,6 +238,12 @@ static int ehci_pci_suspend(struct usb_h
 	writel (0, &ehci->regs->intr_enable);
 	(void)readl(&ehci->regs->intr_enable);
 
+	/* make sure snapshot being resumed re-enumerates everything */
+	if (message.event == PM_EVENT_PRETHAW) {
+		ehci_halt(ehci);
+		ehci_reset(ehci);
+	}
+
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
  bail:
 	spin_unlock_irqrestore (&ehci->lock, flags);
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index b268537..37e1228 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -135,6 +135,11 @@ static int ohci_pci_suspend (struct usb_
 	}
 	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
 	(void)ohci_readl(ohci, &ohci->regs->intrdisable);
+
+	/* make sure snapshot being resumed re-enumerates everything */
+	if (message.event == PM_EVENT_PRETHAW)
+		ohci_usb_reset(ohci);
+
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
  bail:
 	spin_unlock_irqrestore (&ohci->lock, flags);
diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index fa34092..9de115d 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1783,10 +1783,15 @@ sl811h_suspend(struct platform_device *d
 	struct sl811	*sl811 = hcd_to_sl811(hcd);
 	int		retval = 0;
 
-	if (state.event == PM_EVENT_FREEZE)
+	switch (state.event) {
+	case PM_EVENT_FREEZE:
 		retval = sl811h_bus_suspend(hcd);
-	else if (state.event == PM_EVENT_SUSPEND)
+		break;
+	case PM_EVENT_SUSPEND:
+	case PM_EVENT_PRETHAW:		/* explicitly discard hw state */
 		port_power(sl811, 0);
+		break;
+	}
 	if (retval == 0)
 		dev->dev.power.power_state = state;
 	return retval;
diff --git a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
index 4151f61..b7402ce 100644
--- a/drivers/usb/host/uhci-hcd.c
+++ b/drivers/usb/host/uhci-hcd.c
@@ -734,6 +734,10 @@ static int uhci_suspend(struct usb_hcd *
 
 	/* FIXME: Enable non-PME# remote wakeup? */
 
+	/* make sure snapshot being resumed re-enumerates everything */
+	if (message.event == PM_EVENT_PRETHAW)
+		uhci_hc_died(uhci);
+
 done_okay:
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 done:
-- 
1.4.2.1

