Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVAHLH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVAHLH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 06:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVAHHdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:33:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:646 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261903AbVAHFse convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:34 -0500
Subject: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <20050108054626.GB8065@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:37 -0800
Message-Id: <1105163256826@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.43, 2004/12/22 15:48:48-08:00, greg@kroah.com

Merge kroah.com:/home/greg/linux/BK/bleed-2.6
into kroah.com:/home/greg/linux/BK/usb-2.6


 MAINTAINERS                 |    6 ++++++
 drivers/usb/core/devio.c    |   13 ++++++-------
 drivers/usb/host/ehci-hub.c |   12 ++++++------
 drivers/usb/host/ohci-hub.c |    2 +-
 4 files changed, 19 insertions(+), 14 deletions(-)


diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2005-01-07 15:39:45 -08:00
+++ b/MAINTAINERS	2005-01-07 15:39:45 -08:00
@@ -328,6 +328,12 @@
 W:	http://julien.lerouge.free.fr
 S:	Maintained
 
+ATA OVER ETHERNET DRIVER
+P:	Ed L. Cashin
+M:	ecashin@coraid.com
+W:	http://www.coraid.com/support/linux
+S:	Supported
+
 ATM
 P:	Chas Williams
 M:	chas@cmf.nrl.navy.mil
diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	2005-01-07 15:39:45 -08:00
+++ b/drivers/usb/core/devio.c	2005-01-07 15:39:45 -08:00
@@ -523,13 +523,12 @@
 
 	usb_lock_device(dev);
 	list_del_init(&ps->list);
-
-	if (connected(dev)) {
-		for (ifnum = 0; ps->ifclaimed && ifnum < 8*sizeof(ps->ifclaimed); ifnum++)
-			if (test_bit(ifnum, &ps->ifclaimed))
-				releaseintf(ps, ifnum);
-		destroy_all_async(ps);
+	for (ifnum = 0; ps->ifclaimed && ifnum < 8*sizeof(ps->ifclaimed);
+			ifnum++) {
+		if (test_bit(ifnum, &ps->ifclaimed))
+			releaseintf(ps, ifnum);
 	}
+	destroy_all_async(ps);
 	usb_unlock_device(dev);
 	usb_put_dev(dev);
 	ps->dev = NULL;
@@ -1034,7 +1033,7 @@
 	int ret;
 
 	add_wait_queue(&ps->wait, &wait);
-	while (connected(dev)) {
+	for (;;) {
 		__set_current_state(TASK_INTERRUPTIBLE);
 		if ((as = async_getcompleted(ps)))
 			break;
diff -Nru a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
--- a/drivers/usb/host/ehci-hub.c	2005-01-07 15:39:45 -08:00
+++ b/drivers/usb/host/ehci-hub.c	2005-01-07 15:39:45 -08:00
@@ -44,7 +44,7 @@
 	/* stop schedules, clean any completed work */
 	if (HCD_IS_RUNNING(hcd->state)) {
 		ehci_quiesce (ehci);
-		ehci->hcd.state = USB_STATE_QUIESCING;
+		hcd->state = USB_STATE_QUIESCING;
 	}
 	ehci->command = readl (&ehci->regs->command);
 	if (ehci->reclaim)
@@ -59,7 +59,7 @@
 
 		if ((t1 & PORT_PE) && !(t1 & PORT_OWNER))
 			t2 |= PORT_SUSPEND;
-		if (ehci->hcd.remote_wakeup)
+		if (hcd->remote_wakeup)
 			t2 |= PORT_WKOC_E|PORT_WKDISC_E|PORT_WKCONN_E;
 		else
 			t2 &= ~(PORT_WKOC_E|PORT_WKDISC_E|PORT_WKCONN_E);
@@ -73,7 +73,7 @@
 
 	/* turn off now-idle HC */
 	ehci_halt (ehci);
-	ehci->hcd.state = HCD_STATE_SUSPENDED;
+	hcd->state = HCD_STATE_SUSPENDED;
 
 	ehci->next_statechange = jiffies + msecs_to_jiffies(10);
 	spin_unlock_irq (&ehci->lock);
@@ -145,7 +145,7 @@
 	}
 
 	ehci->next_statechange = jiffies + msecs_to_jiffies(5);
-	ehci->hcd.state = USB_STATE_RUNNING;
+	hcd->state = USB_STATE_RUNNING;
 
 	/* Now we can safely re-enable irqs */
 	if (intr_enable)
@@ -212,7 +212,7 @@
 	unsigned long	flags;
 
 	/* if !USB_SUSPEND, root hub timers won't get shut down ... */
-	if (!HCD_IS_RUNNING(ehci->hcd.state))
+	if (!HCD_IS_RUNNING(hcd->state))
 		return 0;
 
 	/* init status to no-changes */
@@ -499,7 +499,7 @@
 			if ((temp & PORT_PE) == 0
 					|| (temp & PORT_RESET) != 0)
 				goto error;
-			if (ehci->hcd.remote_wakeup)
+			if (hcd->remote_wakeup)
 				temp |= PORT_WAKE_BITS;
 			writel (temp | PORT_SUSPEND,
 				&ehci->regs->port_status [wIndex]);
diff -Nru a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
--- a/drivers/usb/host/ohci-hub.c	2005-01-07 15:39:45 -08:00
+++ b/drivers/usb/host/ohci-hub.c	2005-01-07 15:39:45 -08:00
@@ -304,7 +304,7 @@
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
 	int		ports, i, changed = 0, length = 1;
-	int		can_suspend = 1;
+	int		can_suspend = hcd->can_wakeup;
 	unsigned long	flags;
 
 	spin_lock_irqsave (&ohci->lock, flags);

