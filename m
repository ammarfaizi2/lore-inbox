Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbVKWDLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVKWDLf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 22:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVKWDLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 22:11:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:50648 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932492AbVKWDLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 22:11:34 -0500
Subject: [PATCH] Fix USB suspend/resume crasher
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 14:08:07 +1100
Message-Id: <1132715288.26560.262.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my latest patch against current linus -git, it closes the IRQ
race and makes various other OHCI & EHCI code path safer vs.
suspend/resume. I've been able to (finally !) successfully suspend and
resume various Mac models, with or without USB mouse plugged, or
plugging while asleep, or unplugging while asleep etc... all without a
crash. There are still some races here or there in the USB code, but at
least the main cause of crash is now fixes by this patch (access to a
controller that has been suspended, due to either shared interrupts or
other code path).

I haven't fixed UHCI as I don't have any HW to test, though I hope I
haven't broken it neither. Alan, I would appreciate if you could have a
look.

This patch applies on top of the patch that moves the PowerMac specific
code out of ohci-pci.c to hcd-pci.c where it belongs. This patch isn't
upstream yet for reasons I don't fully understand (why does USB stuffs
has such a high latency for going upstream ?), I'm sending it as a reply
to this email for completeness.

Without this patch, you cannot reliably sleep/wakeup any recent Mac, and
I suspect PCs have some more sneaky issues too (they don't frankly crash
with machine checks because x86 tend to silently swallow PCI errors but
that won't last afaik, at least PCI Express will blow up in those
situations, but the USB code may still misbehave).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note that I REALLY want that in 2.6.15. 2.6.14 is already broken, though I
have a similar patch for it that some users have been successfully testing
and I don't want 2.6.15 to be broken too. So unless you have a major issue
with the patch as it is and it breaks something, I think it should be applied,
and I don't want to get into yet another 10000 email exchange discussion on
the merit of doing proper locking and why the current situation is broken...

Index: linux-serialfix/drivers/usb/core/hcd-pci.c
===================================================================
--- linux-serialfix.orig/drivers/usb/core/hcd-pci.c	2005-11-23 13:52:23.000000000 +1100
+++ linux-serialfix/drivers/usb/core/hcd-pci.c	2005-11-23 13:52:32.000000000 +1100
@@ -218,6 +218,7 @@
 			goto done;
 		}
 	}
+	synchronize_irq(dev->irq);
 
 	/* FIXME until the generic PM interfaces change a lot more, this
 	 * can't use PCI D1 and D2 states.  For example, the confusion
@@ -386,7 +387,7 @@
 
 	dev->dev.power.power_state = PMSG_ON;
 
-	hcd->saw_irq = 0;
+	clear_bit(HCD_FLAG_SAW_IRQ, &hcd->flags);
 
 	if (hcd->driver->resume) {
 		retval = hcd->driver->resume(hcd);
Index: linux-serialfix/drivers/usb/core/hcd.c
===================================================================
--- linux-serialfix.orig/drivers/usb/core/hcd.c	2005-11-23 13:47:45.000000000 +1100
+++ linux-serialfix/drivers/usb/core/hcd.c	2005-11-23 13:52:32.000000000 +1100
@@ -1315,11 +1315,12 @@
 	 * finish unlinking the initial failed usb_set_address()
 	 * or device descriptor fetch.
 	 */
-	if (!hcd->saw_irq && hcd->self.root_hub != urb->dev) {
+	if (!test_bit(HCD_FLAG_SAW_IRQ, &hcd->flags)
+	    && hcd->self.root_hub != urb->dev) {
 		dev_warn (hcd->self.controller, "Unlink after no-IRQ?  "
 			"Controller is probably using the wrong IRQ."
 			"\n");
-		hcd->saw_irq = 1;
+		set_bit(HCD_FLAG_SAW_IRQ, &hcd->flags);
 	}
 
 	urb->status = status;
@@ -1649,13 +1650,15 @@
 	struct usb_hcd		*hcd = __hcd;
 	int			start = hcd->state;
 
-	if (start == HC_STATE_HALT)
+	if (unlikely(start == HC_STATE_HALT ||
+	    !test_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags)))
 		return IRQ_NONE;
 	if (hcd->driver->irq (hcd, r) == IRQ_NONE)
 		return IRQ_NONE;
 
-	hcd->saw_irq = 1;
-	if (hcd->state == HC_STATE_HALT)
+	set_bit(HCD_FLAG_SAW_IRQ, &hcd->flags);
+
+	if (unlikely(hcd->state == HC_STATE_HALT))
 		usb_hc_died (hcd);
 	return IRQ_HANDLED;
 }
@@ -1768,6 +1771,8 @@
 
 	dev_info(hcd->self.controller, "%s\n", hcd->product_desc);
 
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+
 	/* till now HC has been in an indeterminate state ... */
 	if (hcd->driver->reset && (retval = hcd->driver->reset(hcd)) < 0) {
 		dev_err(hcd->self.controller, "can't reset\n");
Index: linux-serialfix/drivers/usb/core/hcd.h
===================================================================
--- linux-serialfix.orig/drivers/usb/core/hcd.h	2005-11-23 13:47:45.000000000 +1100
+++ linux-serialfix/drivers/usb/core/hcd.h	2005-11-23 13:52:32.000000000 +1100
@@ -72,7 +72,12 @@
 	 * hardware info/state
 	 */
 	const struct hc_driver	*driver;	/* hw-specific hooks */
-	unsigned		saw_irq : 1;
+
+	/* Flags that need to be manipulated atomically */
+	unsigned long		flags;
+#define HCD_FLAG_HW_ACCESSIBLE	0x00000001
+#define HCD_FLAG_SAW_IRQ	0x00000002
+
 	unsigned		can_wakeup:1;	/* hw supports wakeup? */
 	unsigned		remote_wakeup:1;/* sw should use wakeup? */
 	unsigned		rh_registered:1;/* is root hub registered? */
Index: linux-serialfix/drivers/usb/host/ehci-pci.c
===================================================================
--- linux-serialfix.orig/drivers/usb/host/ehci-pci.c	2005-11-23 13:47:45.000000000 +1100
+++ linux-serialfix/drivers/usb/host/ehci-pci.c	2005-11-23 13:52:32.000000000 +1100
@@ -244,22 +244,34 @@
 static int ehci_pci_suspend (struct usb_hcd *hcd, pm_message_t message)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
+	unsigned long		flags;
+	int			rc = 0;
 
 	if (time_before (jiffies, ehci->next_statechange))
 		msleep (100);
 
-#ifdef	CONFIG_USB_SUSPEND
-	(void) usb_suspend_device (hcd->self.root_hub);
-#else
-	usb_lock_device (hcd->self.root_hub);
-	(void) ehci_bus_suspend (hcd);
-	usb_unlock_device (hcd->self.root_hub);
-#endif
+	/* Root hub was already suspended. Disable irq emission and
+	 * mark HW unaccessible, bail out if RH has been resumed. Use
+	 * the spinlock to properly synchronize with possible pending
+	 * RH suspend or resume activity.
+	 *
+	 * This is still racy as hcd->state is manipulated outside of
+	 * any locks =P But that will be a different fix.
+	 */
+	spin_lock_irqsave (&ehci->lock, flags);
+	if (hcd->state != HC_STATE_SUSPENDED) {
+		rc = -EINVAL;
+		goto bail;
+	}
+	writel (0, &ehci->regs->intr_enable);
+	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+ bail:
+	spin_unlock_irqrestore (&ehci->lock, flags);
 
 	// save (PCI) FLADJ in case of Vaux power loss
 	// ... we'd only use it to handle clock skew
 
-	return 0;
+	return rc;
 }
 
 static int ehci_pci_resume (struct usb_hcd *hcd)
@@ -274,6 +286,8 @@
 	if (time_before (jiffies, ehci->next_statechange))
 		msleep (100);
 
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+
 	/* If any port is suspended (or owned by the companion),
 	 * we know we can/must resume the HC (and mustn't reset it).
 	 */
Index: linux-serialfix/drivers/usb/host/ehci-q.c
===================================================================
--- linux-serialfix.orig/drivers/usb/host/ehci-q.c	2005-11-23 13:47:45.000000000 +1100
+++ linux-serialfix/drivers/usb/host/ehci-q.c	2005-11-23 13:52:32.000000000 +1100
@@ -912,6 +912,7 @@
 	int			epnum;
 	unsigned long		flags;
 	struct ehci_qh		*qh = NULL;
+	int			rc = 0;
 
 	qtd = list_entry (qtd_list->next, struct ehci_qtd, qtd_list);
 	epnum = ep->desc.bEndpointAddress;
@@ -926,21 +927,28 @@
 #endif
 
 	spin_lock_irqsave (&ehci->lock, flags);
+	if (unlikely(!test_bit(HCD_FLAG_HW_ACCESSIBLE,
+			       &ehci_to_hcd(ehci)->flags))) {
+		rc = -ESHUTDOWN;
+		goto done;
+	}
+
 	qh = qh_append_tds (ehci, urb, qtd_list, epnum, &ep->hcpriv);
+	if (unlikely(qh == NULL)) {
+		rc = -ENOMEM;
+		goto done;
+	}
 
 	/* Control/bulk operations through TTs don't need scheduling,
 	 * the HC and TT handle it when the TT has a buffer ready.
 	 */
-	if (likely (qh != NULL)) {
-		if (likely (qh->qh_state == QH_STATE_IDLE))
-			qh_link_async (ehci, qh_get (qh));
-	}
+	if (likely (qh->qh_state == QH_STATE_IDLE))
+		qh_link_async (ehci, qh_get (qh));
+ done:
 	spin_unlock_irqrestore (&ehci->lock, flags);
-	if (unlikely (qh == NULL)) {
+	if (unlikely (qh == NULL))
 		qtd_list_free (ehci, urb, qtd_list);
-		return -ENOMEM;
-	}
-	return 0;
+	return rc;
 }
 
 /*-------------------------------------------------------------------------*/
Index: linux-serialfix/drivers/usb/host/ehci-sched.c
===================================================================
--- linux-serialfix.orig/drivers/usb/host/ehci-sched.c	2005-11-23 13:47:45.000000000 +1100
+++ linux-serialfix/drivers/usb/host/ehci-sched.c	2005-11-23 13:52:32.000000000 +1100
@@ -602,6 +602,12 @@
 
 	spin_lock_irqsave (&ehci->lock, flags);
 
+	if (unlikely(!test_bit(HCD_FLAG_HW_ACCESSIBLE,
+			       &ehci_to_hcd(ehci)->flags))) {
+		status = -ESHUTDOWN;
+		goto done;
+	}
+
 	/* get qh and force any scheduling errors */
 	INIT_LIST_HEAD (&empty);
 	qh = qh_append_tds (ehci, urb, &empty, epnum, &ep->hcpriv);
@@ -1456,7 +1462,11 @@
 
 	/* schedule ... need to lock */
 	spin_lock_irqsave (&ehci->lock, flags);
-	status = iso_stream_schedule (ehci, urb, stream);
+	if (unlikely(!test_bit(HCD_FLAG_HW_ACCESSIBLE,
+			       &ehci_to_hcd(ehci)->flags)))
+		status = -ESHUTDOWN;
+	else
+		status = iso_stream_schedule (ehci, urb, stream);
  	if (likely (status == 0))
 		itd_link_urb (ehci, urb, ehci->periodic_size << 3, stream);
 	spin_unlock_irqrestore (&ehci->lock, flags);
@@ -1815,7 +1825,11 @@
 
 	/* schedule ... need to lock */
 	spin_lock_irqsave (&ehci->lock, flags);
-	status = iso_stream_schedule (ehci, urb, stream);
+	if (unlikely(!test_bit(HCD_FLAG_HW_ACCESSIBLE,
+			       &ehci_to_hcd(ehci)->flags)))
+		status = -ESHUTDOWN;
+	else
+		status = iso_stream_schedule (ehci, urb, stream);
  	if (status == 0)
 		sitd_link_urb (ehci, urb, ehci->periodic_size << 3, stream);
 	spin_unlock_irqrestore (&ehci->lock, flags);
Index: linux-serialfix/drivers/usb/host/ohci-hcd.c
===================================================================
--- linux-serialfix.orig/drivers/usb/host/ohci-hcd.c	2005-11-23 13:47:45.000000000 +1100
+++ linux-serialfix/drivers/usb/host/ohci-hcd.c	2005-11-23 13:57:06.000000000 +1100
@@ -115,7 +115,7 @@
 
 /*-------------------------------------------------------------------------*/
 
-// #define OHCI_VERBOSE_DEBUG	/* not always helpful */
+#undef OHCI_VERBOSE_DEBUG	/* not always helpful */
 
 /* For initializing controller (mask in an HCFS mode too) */
 #define	OHCI_CONTROL_INIT 	OHCI_CTRL_CBSR
@@ -253,6 +253,10 @@
 	spin_lock_irqsave (&ohci->lock, flags);
 
 	/* don't submit to a dead HC */
+	if (!test_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags)) {
+		retval = -ENODEV;
+		goto fail;
+	}
 	if (!HC_IS_RUNNING(hcd->state)) {
 		retval = -ENODEV;
 		goto fail;
Index: linux-serialfix/drivers/usb/host/ohci-hub.c
===================================================================
--- linux-serialfix.orig/drivers/usb/host/ohci-hub.c	2005-11-23 13:47:45.000000000 +1100
+++ linux-serialfix/drivers/usb/host/ohci-hub.c	2005-11-23 13:54:04.000000000 +1100
@@ -53,6 +53,11 @@
 
 	spin_lock_irqsave (&ohci->lock, flags);
 
+	if (unlikely(!test_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags))) {
+		spin_unlock_irqrestore (&ohci->lock, flags);
+		return -ESHUTDOWN;
+	}
+
 	ohci->hc_control = ohci_readl (ohci, &ohci->regs->control);
 	switch (ohci->hc_control & OHCI_CTRL_HCFS) {
 	case OHCI_USB_RESUME:
@@ -140,11 +145,19 @@
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
 	u32			temp, enables;
 	int			status = -EINPROGRESS;
+	unsigned long		flags;
 
 	if (time_before (jiffies, ohci->next_statechange))
 		msleep(5);
 
-	spin_lock_irq (&ohci->lock);
+	spin_lock_irqsave (&ohci->lock, flags);
+
+	if (unlikely(!test_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags))) {
+		spin_unlock_irqrestore (&ohci->lock, flags);
+		return -ESHUTDOWN;
+	}
+
+
 	ohci->hc_control = ohci_readl (ohci, &ohci->regs->control);
 
 	if (ohci->hc_control & (OHCI_CTRL_IR | OHCI_SCHED_ENABLES)) {
@@ -179,7 +192,7 @@
 		ohci_dbg (ohci, "lost power\n");
 		status = -EBUSY;
 	}
-	spin_unlock_irq (&ohci->lock);
+	spin_unlock_irqrestore (&ohci->lock, flags);
 	if (status == -EBUSY) {
 		(void) ohci_init (ohci);
 		return ohci_restart (ohci);
@@ -297,8 +310,8 @@
 	/* handle autosuspended root:  finish resuming before
 	 * letting khubd or root hub timer see state changes.
 	 */
-	if ((ohci->hc_control & OHCI_CTRL_HCFS) != OHCI_USB_OPER
-			|| !HC_IS_RUNNING(hcd->state)) {
+	if (unlikely((ohci->hc_control & OHCI_CTRL_HCFS) != OHCI_USB_OPER
+		     || !HC_IS_RUNNING(hcd->state))) {
 		can_suspend = 0;
 		goto done;
 	}
@@ -508,6 +521,9 @@
 	u32		temp;
 	int		retval = 0;
 
+	if (unlikely(!test_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags)))
+		return -ESHUTDOWN;
+
 	switch (typeReq) {
 	case ClearHubFeature:
 		switch (wValue) {
Index: linux-serialfix/drivers/usb/host/ohci-pci.c
===================================================================
--- linux-serialfix.orig/drivers/usb/host/ohci-pci.c	2005-11-23 13:52:23.000000000 +1100
+++ linux-serialfix/drivers/usb/host/ohci-pci.c	2005-11-23 13:52:32.000000000 +1100
@@ -114,12 +114,35 @@
 
 static int ohci_pci_suspend (struct usb_hcd *hcd, pm_message_t message)
 {
-	return 0;
+	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
+	unsigned long	flags;
+	int		rc = 0;
+
+	/* Root hub was already suspended. Disable irq emission and
+	 * mark HW unaccessible, bail out if RH has been resumed. Use
+	 * the spinlock to properly synchronize with possible pending
+	 * RH suspend or resume activity.
+	 *
+	 * This is still racy as hcd->state is manipulated outside of
+	 * any locks =P But that will be a different fix.
+	 */
+	spin_lock_irqsave (&ohci->lock, flags);
+	if (hcd->state != HC_STATE_SUSPENDED) {
+		rc = -EINVAL;
+		goto bail;
+	}
+	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
+	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+ bail:
+	spin_unlock_irqrestore (&ohci->lock, flags);
+
+	return rc;
 }
 
 
 static int ohci_pci_resume (struct usb_hcd *hcd)
 {
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	usb_hcd_resume_root_hub(hcd);
 	return 0;
 }


