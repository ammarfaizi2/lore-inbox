Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVAHG2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVAHG2F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVAHG0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:26:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:31878 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261948AbVAHFsy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:54 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632682199@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:48 -0800
Message-Id: <11051632682125@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.41, 2004/12/20 14:18:23-08:00, stern@rowland.harvard.edu

[PATCH] USB: Create usb_hcd structures within usbcore [2/13]

This patch alters the EHCI driver, removing the routine that allocates the
hcd structure and introducing inline functions to convert safely between
the public and private hcd structures.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/ehci-dbg.c   |   30 +++++++++++++++-------------
 drivers/usb/host/ehci-hcd.c   |   45 ++++++++++++++++++++----------------------
 drivers/usb/host/ehci-hub.c   |   12 +++++------
 drivers/usb/host/ehci-mem.c   |   31 +++++-----------------------
 drivers/usb/host/ehci-q.c     |   23 +++++++++++----------
 drivers/usb/host/ehci-sched.c |   34 +++++++++++++++----------------
 drivers/usb/host/ehci.h       |   23 +++++++++++++--------
 7 files changed, 94 insertions(+), 104 deletions(-)


diff -Nru a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
--- a/drivers/usb/host/ehci-dbg.c	2005-01-07 15:43:52 -08:00
+++ b/drivers/usb/host/ehci-dbg.c	2005-01-07 15:43:52 -08:00
@@ -19,13 +19,13 @@
 /* this file is part of ehci-hcd.c */
 
 #define ehci_dbg(ehci, fmt, args...) \
-	dev_dbg ((ehci)->hcd.self.controller , fmt , ## args )
+	dev_dbg (ehci_to_hcd(ehci)->self.controller , fmt , ## args )
 #define ehci_err(ehci, fmt, args...) \
-	dev_err ((ehci)->hcd.self.controller , fmt , ## args )
+	dev_err (ehci_to_hcd(ehci)->self.controller , fmt , ## args )
 #define ehci_info(ehci, fmt, args...) \
-	dev_info ((ehci)->hcd.self.controller , fmt , ## args )
+	dev_info (ehci_to_hcd(ehci)->self.controller , fmt , ## args )
 #define ehci_warn(ehci, fmt, args...) \
-	dev_warn ((ehci)->hcd.self.controller , fmt , ## args )
+	dev_warn (ehci_to_hcd(ehci)->self.controller , fmt , ## args )
 
 #ifdef EHCI_VERBOSE_DEBUG
 #	define vdbg dbg
@@ -657,7 +657,7 @@
 		"EHCI %x.%02x, hcd state %d\n",
 		hcd->self.controller->bus->name,
 		hcd->self.controller->bus_id,
-		i >> 8, i & 0x0ff, ehci->hcd.state);
+		i >> 8, i & 0x0ff, hcd->state);
 	size -= temp;
 	next += temp;
 
@@ -733,18 +733,22 @@
 }
 static CLASS_DEVICE_ATTR (registers, S_IRUGO, show_registers, NULL);
 
-static inline void create_debug_files (struct ehci_hcd *bus)
+static inline void create_debug_files (struct ehci_hcd *ehci)
 {
-	class_device_create_file(&bus->hcd.self.class_dev, &class_device_attr_async);
-	class_device_create_file(&bus->hcd.self.class_dev, &class_device_attr_periodic);
-	class_device_create_file(&bus->hcd.self.class_dev, &class_device_attr_registers);
+	struct class_device *cldev = &ehci_to_hcd(ehci)->self.class_dev;
+
+	class_device_create_file(cldev, &class_device_attr_async);
+	class_device_create_file(cldev, &class_device_attr_periodic);
+	class_device_create_file(cldev, &class_device_attr_registers);
 }
 
-static inline void remove_debug_files (struct ehci_hcd *bus)
+static inline void remove_debug_files (struct ehci_hcd *ehci)
 {
-	class_device_remove_file(&bus->hcd.self.class_dev, &class_device_attr_async);
-	class_device_remove_file(&bus->hcd.self.class_dev, &class_device_attr_periodic);
-	class_device_remove_file(&bus->hcd.self.class_dev, &class_device_attr_registers);
+	struct class_device *cldev = &ehci_to_hcd(ehci)->self.class_dev;
+
+	class_device_remove_file(cldev, &class_device_attr_async);
+	class_device_remove_file(cldev, &class_device_attr_periodic);
+	class_device_remove_file(cldev, &class_device_attr_registers);
 }
 
 #endif /* STUB_DEBUG_FILES */
diff -Nru a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
--- a/drivers/usb/host/ehci-hcd.c	2005-01-07 15:43:52 -08:00
+++ b/drivers/usb/host/ehci-hcd.c	2005-01-07 15:43:52 -08:00
@@ -199,7 +199,7 @@
 	command |= CMD_RESET;
 	dbg_cmd (ehci, "reset", command);
 	writel (command, &ehci->regs->command);
-	ehci->hcd.state = USB_STATE_HALT;
+	ehci_to_hcd(ehci)->state = USB_STATE_HALT;
 	ehci->next_statechange = jiffies;
 	return handshake (&ehci->regs->command, CMD_RESET, 0, 250 * 1000);
 }
@@ -210,7 +210,7 @@
 	u32	temp;
 
 #ifdef DEBUG
-	if (!HCD_IS_RUNNING (ehci->hcd.state))
+	if (!HCD_IS_RUNNING (ehci_to_hcd(ehci)->state))
 		BUG ();
 #endif
 
@@ -219,7 +219,7 @@
 	temp &= STS_ASS | STS_PSS;
 	if (handshake (&ehci->regs->status, STS_ASS | STS_PSS,
 				temp, 16 * 125) != 0) {
-		ehci->hcd.state = USB_STATE_HALT;
+		ehci_to_hcd(ehci)->state = USB_STATE_HALT;
 		return;
 	}
 
@@ -231,7 +231,7 @@
 	/* hardware can take 16 microframes to turn off ... */
 	if (handshake (&ehci->regs->status, STS_ASS | STS_PSS,
 				0, 16 * 125) != 0) {
-		ehci->hcd.state = USB_STATE_HALT;
+		ehci_to_hcd(ehci)->state = USB_STATE_HALT;
 		return;
 	}
 }
@@ -285,7 +285,8 @@
 {
 	if (cap & (1 << 16)) {
 		int msec = 5000;
-		struct pci_dev *pdev = to_pci_dev(ehci->hcd.self.controller);
+		struct pci_dev *pdev =
+				to_pci_dev(ehci_to_hcd(ehci)->self.controller);
 
 		/* request handoff to OS */
 		cap |= 1 << 24;
@@ -343,7 +344,7 @@
 #ifdef	CONFIG_PCI
 	/* EHCI 0.96 and later may have "extended capabilities" */
 	if (hcd->self.controller->bus == &pci_bus_type) {
-		struct pci_dev	*pdev = to_pci_dev(ehci->hcd.self.controller);
+		struct pci_dev	*pdev = to_pci_dev(hcd->self.controller);
 
 		/* AMD8111 EHCI doesn't work, according to AMD errata */
 		if ((pdev->vendor == PCI_VENDOR_ID_AMD)
@@ -358,7 +359,7 @@
 	while (temp && count--) {
 		u32		cap;
 
-		pci_read_config_dword (to_pci_dev(ehci->hcd.self.controller),
+		pci_read_config_dword (to_pci_dev(hcd->self.controller),
 				temp, &cap);
 		ehci_dbg (ehci, "capability %04x at %02x\n", cap, temp);
 		switch (cap & 0xff) {
@@ -505,7 +506,7 @@
 		writel (0, &ehci->regs->segment);
 #if 0
 // this is deeply broken on almost all architectures
-		if (!pci_set_dma_mask (to_pci_dev(ehci->hcd.self.controller), 0xffffffffffffffffULL))
+		if (!pci_set_dma_mask (to_pci_dev(hcd->self.controller), 0xffffffffffffffffULL))
 			ehci_info (ehci, "enabled 64bit PCI DMA\n");
 #endif
 	}
@@ -570,7 +571,7 @@
 		register_reboot_notifier (&ehci->reboot_notifier);
 	}
 
-	ehci->hcd.state = USB_STATE_RUNNING;
+	hcd->state = USB_STATE_RUNNING;
 	writel (FLAG_CF, &ehci->regs->configured_flag);
 	readl (&ehci->regs->command);	/* unblock posted write */
 
@@ -627,7 +628,7 @@
 	del_timer_sync (&ehci->watchdog);
 
 	spin_lock_irq(&ehci->lock);
-	if (HCD_IS_RUNNING (ehci->hcd.state))
+	if (HCD_IS_RUNNING (hcd->state))
 		ehci_quiesce (ehci);
 
 	ehci_reset (ehci);
@@ -794,8 +795,9 @@
 	 * misplace IRQs, and should let us run completely without IRQs.
 	 * such lossage has been observed on both VT6202 and VT8235. 
 	 */
-	if (HCD_IS_RUNNING (ehci->hcd.state) && (ehci->async->qh_next.ptr != 0
-			|| ehci->periodic_sched != 0))
+	if (HCD_IS_RUNNING (ehci_to_hcd(ehci)->state) &&
+			(ehci->async->qh_next.ptr != 0 ||
+			 ehci->periodic_sched != 0))
 		timer_action (ehci, TIMER_IO_WATCHDOG);
 }
 
@@ -852,7 +854,7 @@
 	}
 
 	/* remote wakeup [4.3.1] */
-	if ((status & STS_PCD) && ehci->hcd.remote_wakeup) {
+	if ((status & STS_PCD) && hcd->remote_wakeup) {
 		unsigned	i = HCS_N_PORTS (ehci->hcs_params);
 
 		/* resume root hub? */
@@ -873,7 +875,7 @@
 			 * stop that signaling.
 			 */
 			ehci->reset_done [i] = jiffies + msecs_to_jiffies (20);
-			mod_timer (&ehci->hcd.rh_timer,
+			mod_timer (&hcd->rh_timer,
 					ehci->reset_done [i] + 1);
 			ehci_dbg (ehci, "port %d remote wakeup\n", i + 1);
 		}
@@ -947,7 +949,7 @@
 	/* if we need to use IAA and it's busy, defer */
 	if (qh->qh_state == QH_STATE_LINKED
 			&& ehci->reclaim
-			&& HCD_IS_RUNNING (ehci->hcd.state)) {
+			&& HCD_IS_RUNNING (ehci_to_hcd(ehci)->state)) {
 		struct ehci_qh		*last;
 
 		for (last = ehci->reclaim;
@@ -958,7 +960,7 @@
 		last->reclaim = qh;
 
 	/* bypass IAA if the hc can't care */
-	} else if (!HCD_IS_RUNNING (ehci->hcd.state) && ehci->reclaim)
+	} else if (!HCD_IS_RUNNING (ehci_to_hcd(ehci)->state) && ehci->reclaim)
 		end_unlink_async (ehci, NULL);
 
 	/* something else might have unlinked the qh by now */
@@ -1006,7 +1008,7 @@
 
 		/* reschedule QH iff another request is queued */
 		if (!list_empty (&qh->qtd_list)
-				&& HCD_IS_RUNNING (ehci->hcd.state)) {
+				&& HCD_IS_RUNNING (hcd->state)) {
 			int status;
 
 			status = qh_schedule (ehci, qh);
@@ -1062,7 +1064,7 @@
 		goto idle_timeout;
 	}
 
-	if (!HCD_IS_RUNNING (ehci->hcd.state))
+	if (!HCD_IS_RUNNING (hcd->state))
 		qh->qh_state = QH_STATE_IDLE;
 	switch (qh->qh_state) {
 	case QH_STATE_LINKED:
@@ -1107,6 +1109,8 @@
 
 static const struct hc_driver ehci_driver = {
 	.description =		hcd_name,
+	.product_desc =		"EHCI Host Controller",
+	.hcd_priv_size =	sizeof(struct ehci_hcd),
 
 	/*
 	 * generic hardware linkage
@@ -1124,11 +1128,6 @@
 	.resume =		ehci_resume,
 #endif
 	.stop =			ehci_stop,
-
-	/*
-	 * memory lifecycle (except per-request)
-	 */
-	.hcd_alloc =		ehci_hcd_alloc,
 
 	/*
 	 * managing i/o requests and associated device resources
diff -Nru a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
--- a/drivers/usb/host/ehci-hub.c	2005-01-07 15:43:52 -08:00
+++ b/drivers/usb/host/ehci-hub.c	2005-01-07 15:43:52 -08:00
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
diff -Nru a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
--- a/drivers/usb/host/ehci-mem.c	2005-01-07 15:43:52 -08:00
+++ b/drivers/usb/host/ehci-mem.c	2005-01-07 15:43:52 -08:00
@@ -32,25 +32,6 @@
  */
 
 /*-------------------------------------------------------------------------*/
-/* 
- * Allocator / cleanup for the per device structure
- * Called by hcd init / removal code
- */
-static struct usb_hcd *ehci_hcd_alloc (void)
-{
-	struct ehci_hcd *ehci;
-
-	ehci = (struct ehci_hcd *)
-		kmalloc (sizeof (struct ehci_hcd), GFP_KERNEL);
-	if (ehci != 0) {
-		memset (ehci, 0, sizeof (struct ehci_hcd));
-		ehci->hcd.product_desc = "EHCI Host Controller";
-		return &ehci->hcd;
-	}
-	return NULL;
-}
-
-/*-------------------------------------------------------------------------*/
 
 /* Allocate the key transfer structures from the previously allocated pool */
 
@@ -169,7 +150,7 @@
 	ehci->sitd_pool = NULL;
 
 	if (ehci->periodic)
-		dma_free_coherent (ehci->hcd.self.controller,
+		dma_free_coherent (ehci_to_hcd(ehci)->self.controller,
 			ehci->periodic_size * sizeof (u32),
 			ehci->periodic, ehci->periodic_dma);
 	ehci->periodic = NULL;
@@ -187,7 +168,7 @@
 
 	/* QTDs for control/bulk/intr transfers */
 	ehci->qtd_pool = dma_pool_create ("ehci_qtd", 
-			ehci->hcd.self.controller,
+			ehci_to_hcd(ehci)->self.controller,
 			sizeof (struct ehci_qtd),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
@@ -197,7 +178,7 @@
 
 	/* QHs for control/bulk/intr transfers */
 	ehci->qh_pool = dma_pool_create ("ehci_qh", 
-			ehci->hcd.self.controller,
+			ehci_to_hcd(ehci)->self.controller,
 			sizeof (struct ehci_qh),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
@@ -211,7 +192,7 @@
 
 	/* ITD for high speed ISO transfers */
 	ehci->itd_pool = dma_pool_create ("ehci_itd", 
-			ehci->hcd.self.controller,
+			ehci_to_hcd(ehci)->self.controller,
 			sizeof (struct ehci_itd),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
@@ -221,7 +202,7 @@
 
 	/* SITD for full/low speed split ISO transfers */
 	ehci->sitd_pool = dma_pool_create ("ehci_sitd", 
-			ehci->hcd.self.controller,
+			ehci_to_hcd(ehci)->self.controller,
 			sizeof (struct ehci_sitd),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
@@ -231,7 +212,7 @@
 
 	/* Hardware periodic table */
 	ehci->periodic = (__le32 *)
-		dma_alloc_coherent (ehci->hcd.self.controller,
+		dma_alloc_coherent (ehci_to_hcd(ehci)->self.controller,
 			ehci->periodic_size * sizeof(__le32),
 			&ehci->periodic_dma, 0);
 	if (ehci->periodic == 0) {
diff -Nru a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
--- a/drivers/usb/host/ehci-q.c	2005-01-07 15:43:52 -08:00
+++ b/drivers/usb/host/ehci-q.c	2005-01-07 15:43:52 -08:00
@@ -200,7 +200,7 @@
 					|| QTD_CERR(token) == 0)
 				&& (!ehci_is_ARC(ehci)
                 	                || urb->dev->tt->hub !=
-						ehci->hcd.self.root_hub)) {
+					   ehci_to_hcd(ehci)->self.root_hub)) {
 #ifdef DEBUG
 			struct usb_device *tt = urb->dev->tt->hub;
 			dev_dbg (&tt->dev,
@@ -225,7 +225,7 @@
 		if ((qh->hw_info2 & __constant_cpu_to_le32 (0x00ff)) != 0) {
 
 			/* ... update hc-wide periodic stats (for usbfs) */
-			hcd_to_bus (&ehci->hcd)->bandwidth_int_reqs--;
+			ehci_to_hcd(ehci)->self.bandwidth_int_reqs--;
 		}
 		qh_put (qh);
 	}
@@ -262,7 +262,7 @@
 
 	/* complete() can reenter this HCD */
 	spin_unlock (&ehci->lock);
-	usb_hcd_giveback_urb (&ehci->hcd, urb, regs);
+	usb_hcd_giveback_urb (ehci_to_hcd(ehci), urb, regs);
 	spin_lock (&ehci->lock);
 }
 
@@ -347,13 +347,13 @@
 
 		/* stop scanning when we reach qtds the hc is using */
 		} else if (likely (!stopped
-				&& HCD_IS_RUNNING (ehci->hcd.state))) {
+				&& HCD_IS_RUNNING (ehci_to_hcd(ehci)->state))) {
 			break;
 
 		} else {
 			stopped = 1;
 
-			if (unlikely (!HCD_IS_RUNNING (ehci->hcd.state)))
+			if (unlikely (!HCD_IS_RUNNING (ehci_to_hcd(ehci)->state)))
 				urb->status = -ESHUTDOWN;
 
 			/* ignore active urbs unless some previous qtd
@@ -717,7 +717,8 @@
 		 * root hub tt, leave it zeroed.
 		 */
 		if (!ehci_is_ARC(ehci)
-				|| urb->dev->tt->hub != ehci->hcd.self.root_hub)
+				|| urb->dev->tt->hub !=
+					ehci_to_hcd(ehci)->self.root_hub)
 			info2 |= urb->dev->tt->hub->devnum << 16;
 
 		/* NOTE:  if (PIPE_INTERRUPT) { scheduler sets c-mask } */
@@ -778,7 +779,7 @@
 			(void) handshake (&ehci->regs->status, STS_ASS, 0, 150);
 			cmd |= CMD_ASE | CMD_RUN;
 			writel (cmd, &ehci->regs->command);
-			ehci->hcd.state = USB_STATE_RUNNING;
+			ehci_to_hcd(ehci)->state = USB_STATE_RUNNING;
 			/* posted write need not be known to HC yet ... */
 		}
 	}
@@ -957,7 +958,7 @@
 	qh_completions (ehci, qh, regs);
 
 	if (!list_empty (&qh->qtd_list)
-			&& HCD_IS_RUNNING (ehci->hcd.state))
+			&& HCD_IS_RUNNING (ehci_to_hcd(ehci)->state))
 		qh_link_async (ehci, qh);
 	else {
 		qh_put (qh);		// refcount from async list
@@ -965,7 +966,7 @@
 		/* it's not free to turn the async schedule on/off; leave it
 		 * active but idle for a while once it empties.
 		 */
-		if (HCD_IS_RUNNING (ehci->hcd.state)
+		if (HCD_IS_RUNNING (ehci_to_hcd(ehci)->state)
 				&& ehci->async->qh_next.qh == 0)
 			timer_action (ehci, TIMER_ASYNC_OFF);
 	}
@@ -999,7 +1000,7 @@
 	/* stop async schedule right now? */
 	if (unlikely (qh == ehci->async)) {
 		/* can't get here without STS_ASS set */
-		if (ehci->hcd.state != USB_STATE_HALT) {
+		if (ehci_to_hcd(ehci)->state != USB_STATE_HALT) {
 			writel (cmd & ~CMD_ASE, &ehci->regs->command);
 			wmb ();
 			// handshake later, if we need to
@@ -1019,7 +1020,7 @@
 	prev->qh_next = qh->qh_next;
 	wmb ();
 
-	if (unlikely (ehci->hcd.state == USB_STATE_HALT)) {
+	if (unlikely (ehci_to_hcd(ehci)->state == USB_STATE_HALT)) {
 		/* if (unlikely (qh->reclaim != 0))
 		 * 	this will recurse, probably not much
 		 */
diff -Nru a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
--- a/drivers/usb/host/ehci-sched.c	2005-01-07 15:43:52 -08:00
+++ b/drivers/usb/host/ehci-sched.c	2005-01-07 15:43:52 -08:00
@@ -249,14 +249,14 @@
 	 */
 	status = handshake (&ehci->regs->status, STS_PSS, 0, 9 * 125);
 	if (status != 0) {
-		ehci->hcd.state = USB_STATE_HALT;
+		ehci_to_hcd(ehci)->state = USB_STATE_HALT;
 		return status;
 	}
 
 	cmd = readl (&ehci->regs->command) | CMD_PSE;
 	writel (cmd, &ehci->regs->command);
 	/* posted write ... PSS happens later */
-	ehci->hcd.state = USB_STATE_RUNNING;
+	ehci_to_hcd(ehci)->state = USB_STATE_RUNNING;
 
 	/* make sure ehci_work scans these */
 	ehci->next_uframe = readl (&ehci->regs->frame_index)
@@ -274,7 +274,7 @@
 	 */
 	status = handshake (&ehci->regs->status, STS_PSS, STS_PSS, 9 * 125);
 	if (status != 0) {
-		ehci->hcd.state = USB_STATE_HALT;
+		ehci_to_hcd(ehci)->state = USB_STATE_HALT;
 		return status;
 	}
 
@@ -348,7 +348,7 @@
 	qh_get (qh);
 
 	/* update per-qh bandwidth for usbfs */
-	hcd_to_bus (&ehci->hcd)->bandwidth_allocated += qh->period
+	ehci_to_hcd(ehci)->self.bandwidth_allocated += qh->period
 		? ((qh->usecs + qh->c_usecs) / qh->period)
 		: (qh->usecs * 8);
 
@@ -379,7 +379,7 @@
 		periodic_unlink (ehci, i, qh);
 
 	/* update per-qh bandwidth for usbfs */
-	hcd_to_bus (&ehci->hcd)->bandwidth_allocated -= qh->period
+	ehci_to_hcd(ehci)->self.bandwidth_allocated -= qh->period
 		? ((qh->usecs + qh->c_usecs) / qh->period)
 		: (qh->usecs * 8);
 
@@ -618,7 +618,7 @@
 	BUG_ON (qh == 0);
 
 	/* ... update usbfs periodic stats */
-	hcd_to_bus (&ehci->hcd)->bandwidth_int_reqs++;
+	ehci_to_hcd(ehci)->self.bandwidth_int_reqs++;
 
 done:
 	spin_unlock_irqrestore (&ehci->lock, flags);
@@ -1258,7 +1258,7 @@
 	next_uframe = stream->next_uframe % mod;
 
 	if (unlikely (list_empty(&stream->td_list))) {
-		hcd_to_bus (&ehci->hcd)->bandwidth_allocated
+		ehci_to_hcd(ehci)->self.bandwidth_allocated
 				+= stream->bandwidth;
 		ehci_vdbg (ehci,
 			"schedule devp %s ep%d%s-iso period %d start %d.%d\n",
@@ -1268,7 +1268,7 @@
 			next_uframe >> 3, next_uframe & 0x7);
 		stream->start = jiffies;
 	}
-	hcd_to_bus (&ehci->hcd)->bandwidth_isoc_reqs++;
+	ehci_to_hcd(ehci)->self.bandwidth_isoc_reqs++;
 
 	/* fill iTDs uframe by uframe */
 	for (packet = 0, itd = NULL; packet < urb->number_of_packets; ) {
@@ -1390,10 +1390,10 @@
 	ehci->periodic_sched--;
 	if (unlikely (!ehci->periodic_sched))
 		(void) disable_periodic (ehci);
-	hcd_to_bus (&ehci->hcd)->bandwidth_isoc_reqs--;
+	ehci_to_hcd(ehci)->self.bandwidth_isoc_reqs--;
 
 	if (unlikely (list_empty (&stream->td_list))) {
-		hcd_to_bus (&ehci->hcd)->bandwidth_allocated
+		ehci_to_hcd(ehci)->self.bandwidth_allocated
 				-= stream->bandwidth;
 		ehci_vdbg (ehci,
 			"deschedule devp %s ep%d%s-iso\n",
@@ -1643,7 +1643,7 @@
 
 	if (list_empty(&stream->td_list)) {
 		/* usbfs ignores TT bandwidth */
-		hcd_to_bus (&ehci->hcd)->bandwidth_allocated
+		ehci_to_hcd(ehci)->self.bandwidth_allocated
 				+= stream->bandwidth;
 		ehci_vdbg (ehci,
 			"sched dev%s ep%d%s-iso [%d] %dms/%04x\n",
@@ -1653,7 +1653,7 @@
 			stream->interval, le32_to_cpu (stream->splits));
 		stream->start = jiffies;
 	}
-	hcd_to_bus (&ehci->hcd)->bandwidth_isoc_reqs++;
+	ehci_to_hcd(ehci)->self.bandwidth_isoc_reqs++;
 
 	/* fill sITDs frame by frame */
 	for (packet = 0, sitd = NULL;
@@ -1753,10 +1753,10 @@
 	ehci->periodic_sched--;
 	if (!ehci->periodic_sched)
 		(void) disable_periodic (ehci);
-	hcd_to_bus (&ehci->hcd)->bandwidth_isoc_reqs--;
+	ehci_to_hcd(ehci)->self.bandwidth_isoc_reqs--;
 
 	if (list_empty (&stream->td_list)) {
-		hcd_to_bus (&ehci->hcd)->bandwidth_allocated
+		ehci_to_hcd(ehci)->self.bandwidth_allocated
 				-= stream->bandwidth;
 		ehci_vdbg (ehci,
 			"deschedule devp %s ep%d%s-iso\n",
@@ -1860,7 +1860,7 @@
 	 * Touches as few pages as possible:  cache-friendly.
 	 */
 	now_uframe = ehci->next_uframe;
-	if (HCD_IS_RUNNING (ehci->hcd.state))
+	if (HCD_IS_RUNNING (ehci_to_hcd(ehci)->state))
 		clock = readl (&ehci->regs->frame_index);
 	else
 		clock = now_uframe + mod - 1;
@@ -1894,7 +1894,7 @@
 			union ehci_shadow	temp;
 			int			live;
 
-			live = HCD_IS_RUNNING (ehci->hcd.state);
+			live = HCD_IS_RUNNING (ehci_to_hcd(ehci)->state);
 			switch (type) {
 			case Q_TYPE_QH:
 				/* handle any completions */
@@ -1983,7 +1983,7 @@
 		if (now_uframe == clock) {
 			unsigned	now;
 
-			if (!HCD_IS_RUNNING (ehci->hcd.state))
+			if (!HCD_IS_RUNNING (ehci_to_hcd(ehci)->state))
 				break;
 			ehci->next_uframe = now_uframe;
 			now = readl (&ehci->regs->frame_index) % mod;
diff -Nru a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
--- a/drivers/usb/host/ehci.h	2005-01-07 15:43:52 -08:00
+++ b/drivers/usb/host/ehci.h	2005-01-07 15:43:52 -08:00
@@ -47,13 +47,6 @@
 #define	EHCI_MAX_ROOT_PORTS	15		/* see HCS_N_PORTS */
 
 struct ehci_hcd {			/* one per controller */
-
-	/* glue to PCI and HCD framework */
-	struct usb_hcd		hcd;		/* must come first! */
-	struct ehci_caps __iomem *caps;
-	struct ehci_regs __iomem *regs;
-	__u32			hcs_params;	/* cached register copy */
-
 	spinlock_t		lock;
 
 	/* async schedule support */
@@ -91,6 +84,11 @@
 
 	unsigned		is_arc_rh_tt:1;	/* ARC roothub with TT */
 
+	/* glue to PCI and HCD framework */
+	struct ehci_caps __iomem *caps;
+	struct ehci_regs __iomem *regs;
+	__u32			hcs_params;	/* cached register copy */
+
 	/* irq statistics */
 #ifdef EHCI_STATS
 	struct ehci_stats	stats;
@@ -100,8 +98,15 @@
 #endif
 };
 
-/* unwrap an HCD pointer to get an EHCI_HCD pointer */ 
-#define hcd_to_ehci(hcd_ptr) container_of(hcd_ptr, struct ehci_hcd, hcd)
+/* convert between an HCD pointer and the corresponding EHCI_HCD */ 
+static inline struct ehci_hcd *hcd_to_ehci (struct usb_hcd *hcd)
+{
+	return (struct ehci_hcd *) (hcd->hcd_priv);
+}
+static inline struct usb_hcd *ehci_to_hcd (struct ehci_hcd *ehci)
+{
+	return container_of ((void *) ehci, struct usb_hcd, hcd_priv);
+}
 
 
 enum ehci_timer_action {

