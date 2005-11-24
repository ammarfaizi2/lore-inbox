Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbVKXXEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVKXXEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 18:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbVKXXET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 18:04:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:16000 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750942AbVKXXET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 18:04:19 -0500
Subject: [PATCH] USB: Fix USB suspend/resume crasher (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 09:59:46 +1100
Message-Id: <1132873186.26560.487.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch closes the IRQ race and makes various other OHCI & EHCI code
path safer vs. suspend/resume.
I've been able to (finally !) successfully suspend and resume various
Mac models, with or without USB mouse plugged, or plugging while asleep,
or unplugging while asleep etc... all without a crash.

Alan, please verify the UHCI bit I did, I only verified that it builds.
It's very simple so I wouldn't expect any issue there. If you aren't
confident, then just drop the hunks that change uhci-hcd.c

I also made the patch a little bit more "safer" by making sure the store
to the interrupt register that disables interrupts is not posted before
I set the flag and drop the spinlock.

Without this patch, you cannot reliably sleep/wakeup any recent Mac, and
I suspect PCs have some more sneaky issues too (they don't frankly crash
with machine checks because x86 tend to silently swallow PCI errors but
that won't last afaik, at least PCI Express will blow up in those
situations, but the USB code may still misbehave).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

This new version also fixes the mis-merge with David's patch.

Index: linux-work/drivers/usb/core/hcd-pci.c
===================================================================
--- linux-work.orig/drivers/usb/core/hcd-pci.c	2005-11-25 09:36:14.000000000 +1100
+++ linux-work/drivers/usb/core/hcd-pci.c	2005-11-25 09:41:50.000000000 +1100
@@ -219,6 +219,7 @@ int usb_hcd_pci_suspend (struct pci_dev 
 			goto done;
 		}
 	}
+	synchronize_irq(dev->irq);
 
 	/* FIXME until the generic PM interfaces change a lot more, this
 	 * can't use PCI D1 and D2 states.  For example, the confusion
@@ -392,7 +393,7 @@ int usb_hcd_pci_resume (struct pci_dev *
 
 	dev->dev.power.power_state = PMSG_ON;
 
-	hcd->saw_irq = 0;
+	clear_bit(HCD_FLAG_SAW_IRQ, &hcd->flags);
 
 	if (hcd->driver->resume) {
 		retval = hcd->driver->resume(hcd);
Index: linux-work/drivers/usb/core/hcd.c
===================================================================
--- linux-work.orig/drivers/usb/core/hcd.c	2005-11-21 11:53:15.000000000 +1100
+++ linux-work/drivers/usb/core/hcd.c	2005-11-25 09:41:50.000000000 +1100
@@ -1315,11 +1315,12 @@ static int hcd_unlink_urb (struct urb *u
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
@@ -1649,13 +1650,15 @@ irqreturn_t usb_hcd_irq (int irq, void *
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
@@ -1768,6 +1771,8 @@ int usb_add_hcd(struct usb_hcd *hcd,
 
 	dev_info(hcd->self.controller, "%s\n", hcd->product_desc);
 
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+
 	/* till now HC has been in an indeterminate state ... */
 	if (hcd->driver->reset && (retval = hcd->driver->reset(hcd)) < 0) {
 		dev_err(hcd->self.controller, "can't reset\n");
Index: linux-work/drivers/usb/core/hcd.h
===================================================================
--- linux-work.orig/drivers/usb/core/hcd.h	2005-11-01 14:13:55.000000000 +1100
+++ linux-work/drivers/usb/core/hcd.h	2005-11-25 09:41:50.000000000 +1100
@@ -72,7 +72,12 @@ struct usb_hcd {	/* usb_bus.hcpriv point
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
Index: linux-work/drivers/usb/host/ehci-pci.c
===================================================================
--- linux-work.orig/drivers/usb/host/ehci-pci.c	2005-11-25 09:36:14.000000000 +1100
+++ linux-work/drivers/usb/host/ehci-pci.c	2005-11-25 09:46:54.000000000 +1100
@@ -228,14 +228,36 @@ static int ehci_pci_reset(struct usb_hcd
 static int ehci_pci_suspend(struct usb_hcd *hcd, pm_message_t message)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
+	unsigned long		flags;
+	int			rc = 0;
 
 	if (time_before(jiffies, ehci->next_statechange))
 		msleep(10);
 
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
+	(void)readl(&ehci->regs->intr_enable);
+
+	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+ bail:
+	spin_unlock_irqrestore (&ehci->lock, flags);
+
 	// could save FLADJ in case of Vaux power loss
 	// ... we'd only use it to handle clock skew
 
-	return 0;
+	return rc;
 }
 
 static int ehci_pci_resume(struct usb_hcd *hcd)
@@ -251,6 +273,9 @@ static int ehci_pci_resume(struct usb_hc
 	if (time_before(jiffies, ehci->next_statechange))
 		msleep(100);
 
+	/* Mark hardware accessible again as we are out of D3 state by now */
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+
 	/* If CF is clear, we lost PCI Vaux power and need to restart.  */
 	if (readl(&ehci->regs->configured_flag) != FLAG_CF)
 		goto restart;
Index: linux-work/drivers/usb/host/ehci-q.c
===================================================================
--- linux-work.orig/drivers/usb/host/ehci-q.c	2005-11-01 14:13:55.000000000 +1100
+++ linux-work/drivers/usb/host/ehci-q.c	2005-11-25 09:41:50.000000000 +1100
@@ -912,6 +912,7 @@ submit_async (
 	int			epnum;
 	unsigned long		flags;
 	struct ehci_qh		*qh = NULL;
+	int			rc = 0;
 
 	qtd = list_entry (qtd_list->next, struct ehci_qtd, qtd_list);
 	epnum = ep->desc.bEndpointAddress;
@@ -926,21 +927,28 @@ submit_async (
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
Index: linux-work/drivers/usb/host/ehci-sched.c
===================================================================
--- linux-work.orig/drivers/usb/host/ehci-sched.c	2005-11-01 14:13:55.000000000 +1100
+++ linux-work/drivers/usb/host/ehci-sched.c	2005-11-25 09:41:50.000000000 +1100
@@ -602,6 +602,12 @@ static int intr_submit (
 
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
@@ -1456,7 +1462,11 @@ static int itd_submit (struct ehci_hcd *
 
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
@@ -1815,7 +1825,11 @@ static int sitd_submit (struct ehci_hcd 
 
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
Index: linux-work/drivers/usb/host/ohci-hcd.c
===================================================================
--- linux-work.orig/drivers/usb/host/ohci-hcd.c	2005-11-01 14:13:55.000000000 +1100
+++ linux-work/drivers/usb/host/ohci-hcd.c	2005-11-25 09:41:50.000000000 +1100
@@ -115,7 +115,7 @@
 
 /*-------------------------------------------------------------------------*/
 
-// #define OHCI_VERBOSE_DEBUG	/* not always helpful */
+#undef OHCI_VERBOSE_DEBUG	/* not always helpful */
 
 /* For initializing controller (mask in an HCFS mode too) */
 #define	OHCI_CONTROL_INIT 	OHCI_CTRL_CBSR
@@ -253,6 +253,10 @@ static int ohci_urb_enqueue (
 	spin_lock_irqsave (&ohci->lock, flags);
 
 	/* don't submit to a dead HC */
+	if (!test_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags)) {
+		retval = -ENODEV;
+		goto fail;
+	}
 	if (!HC_IS_RUNNING(hcd->state)) {
 		retval = -ENODEV;
 		goto fail;
Index: linux-work/drivers/usb/host/ohci-hub.c
===================================================================
--- linux-work.orig/drivers/usb/host/ohci-hub.c	2005-11-01 14:13:55.000000000 +1100
+++ linux-work/drivers/usb/host/ohci-hub.c	2005-11-25 09:41:51.000000000 +1100
@@ -53,6 +53,11 @@ static int ohci_bus_suspend (struct usb_
 
 	spin_lock_irqsave (&ohci->lock, flags);
 
+	if (unlikely(!test_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags))) {
+		spin_unlock_irqrestore (&ohci->lock, flags);
+		return -ESHUTDOWN;
+	}
+
 	ohci->hc_control = ohci_readl (ohci, &ohci->regs->control);
 	switch (ohci->hc_control & OHCI_CTRL_HCFS) {
 	case OHCI_USB_RESUME:
@@ -140,11 +145,19 @@ static int ohci_bus_resume (struct usb_h
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
@@ -179,7 +192,7 @@ static int ohci_bus_resume (struct usb_h
 		ohci_dbg (ohci, "lost power\n");
 		status = -EBUSY;
 	}
-	spin_unlock_irq (&ohci->lock);
+	spin_unlock_irqrestore (&ohci->lock, flags);
 	if (status == -EBUSY) {
 		(void) ohci_init (ohci);
 		return ohci_restart (ohci);
@@ -297,8 +310,8 @@ ohci_hub_status_data (struct usb_hcd *hc
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
@@ -508,6 +521,9 @@ static int ohci_hub_control (
 	u32		temp;
 	int		retval = 0;
 
+	if (unlikely(!test_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags)))
+		return -ESHUTDOWN;
+
 	switch (typeReq) {
 	case ClearHubFeature:
 		switch (wValue) {
Index: linux-work/drivers/usb/host/ohci-pci.c
===================================================================
--- linux-work.orig/drivers/usb/host/ohci-pci.c	2005-11-25 09:36:14.000000000 +1100
+++ linux-work/drivers/usb/host/ohci-pci.c	2005-11-25 09:50:27.000000000 +1100
@@ -105,13 +105,36 @@ ohci_pci_start (struct usb_hcd *hcd)
 
 static int ohci_pci_suspend (struct usb_hcd *hcd, pm_message_t message)
 {
-	/* root hub was already suspended */
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
+	(void)ohci_readl(ohci, &ohci->regs->intrdisable);
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
Index: linux-work/drivers/usb/host/uhci-hcd.c
===================================================================
--- linux-work.orig/drivers/usb/host/uhci-hcd.c	2005-11-14 10:42:00.000000000 +1100
+++ linux-work/drivers/usb/host/uhci-hcd.c	2005-11-25 09:50:04.000000000 +1100
@@ -717,6 +717,7 @@ static int uhci_suspend(struct usb_hcd *
 	 * at the source, so we must turn off PIRQ.
 	 */
 	pci_write_config_word(to_pci_dev(uhci_dev(uhci)), USBLEGSUP, 0);
+	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	uhci->hc_inaccessible = 1;
 	hcd->poll_rh = 0;
 
@@ -733,6 +734,11 @@ static int uhci_resume(struct usb_hcd *h
 
 	dev_dbg(uhci_dev(uhci), "%s\n", __FUNCTION__);
 
+	/* We aren't in D3 state anymore, we do that even if dead as I
+	 * really don't want to keep a stale HCD_FLAG_HW_ACCESSIBLE=0
+	 */
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+
 	if (uhci->rh_state == UHCI_RH_RESET)	/* Dead */
 		return 0;
 	spin_lock_irq(&uhci->lock);


