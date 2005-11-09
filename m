Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161250AbVKIVv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161250AbVKIVv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161253AbVKIVv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:51:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:30638 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161250AbVKIVv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:51:56 -0500
Subject: Need test: 2.6.14: Fix IRQ race in USB sleep/wakeup code]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 08:50:22 +1100
Message-Id: <1131573022.24637.106.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch that fixes a race in the USB code with sleep/wakeup.
It's against 2.6.14 and I'd like to see it in the stable series as
powerbook sleep crashes without it, but it needs a little bit of
field testing first. So I would appreciate if ppl could give it a
go and let me know if it doesn't seem to cause any regression (or
if it does of course ;)

Ben.


Index: 2.6.14-ben/drivers/usb/core/hcd-pci.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/core/hcd-pci.c
+++ 2.6.14-ben/drivers/usb/core/hcd-pci.c
@@ -32,6 +32,13 @@
 #include <linux/usb.h>
 #include "hcd.h"
 
+#ifdef CONFIG_PPC_PMAC
+#include <asm/machdep.h>
+#include <asm/pmac_feature.h>
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+#endif
+
 
 /* PCI-based HCs are common, but plenty of non-PCI HCs are used too */
 
@@ -278,6 +285,18 @@ int usb_hcd_pci_suspend (struct pci_dev 
 		break;
 	}
 
+#ifdef CONFIG_PPC_PMAC
+	if (retval == 0 && _machine == _MACH_Pmac) {
+	   	struct device_node	*of_node;
+
+		/* Disable USB PAD & cell clock */
+		of_node = pci_device_to_OF_node (to_pci_dev(hcd->self.
+							    controller));
+		if (of_node)
+			pmac_call_feature(PMAC_FTR_USB_ENABLE, of_node, 0, 0);
+	}
+#endif /* CONFIG_PPC_PMAC */
+
 	/* update power_state **ONLY** to make sysfs happier */
 	if (retval == 0)
 		dev->dev.power.power_state = message;
@@ -303,6 +322,18 @@ int usb_hcd_pci_resume (struct pci_dev *
 		return 0;
 	}
 
+#ifdef CONFIG_PPC_PMAC
+	if (_machine == _MACH_Pmac) {
+		struct device_node *of_node;
+
+		/* Re-enable USB PAD & cell clock */
+		of_node = pci_device_to_OF_node (to_pci_dev(hcd->self.
+							    controller));
+		if (of_node)
+			pmac_call_feature(PMAC_FTR_USB_ENABLE, of_node, 0, 1);
+	}
+#endif /* CONFIG_PPC_PMAC */
+
 	/* NOTE:  chip docs cover clean "real suspend" cases (what Linux
 	 * calls "standby", "suspend to RAM", and so on).  There are also
 	 * dirty cases when swsusp fakes a suspend in "shutdown" mode.
Index: 2.6.14-ben/drivers/usb/core/hcd.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/core/hcd.c
+++ 2.6.14-ben/drivers/usb/core/hcd.c
@@ -1600,7 +1600,8 @@ irqreturn_t usb_hcd_irq (int irq, void *
 	struct usb_hcd		*hcd = __hcd;
 	int			start = hcd->state;
 
-	if (start == HC_STATE_HALT)
+	if (start == HC_STATE_HALT ||
+	    !test_bit(HC_FLAG_IRQ_ON, &hcd->bitflags))
 		return IRQ_NONE;
 	if (hcd->driver->irq (hcd, r) == IRQ_NONE)
 		return IRQ_NONE;
@@ -1736,6 +1737,9 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	if (hcd->driver->irq) {
 		char	buf[8], *bufp = buf;
 
+		set_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+		mb();
+
 #ifdef __sparc__
 		bufp = __irq_itoa(irqnum);
 #else
Index: 2.6.14-ben/drivers/usb/core/hcd.h
===================================================================
--- 2.6.14-ben.orig/drivers/usb/core/hcd.h
+++ 2.6.14-ben/drivers/usb/core/hcd.h
@@ -71,6 +71,9 @@ struct usb_hcd {	/* usb_bus.hcpriv point
 	/*
 	 * hardware info/state
 	 */
+       unsigned long           bitflags;       /* various single-bit flags */
+#define HC_FLAG_IRQ_ON         0
+
 	const struct hc_driver	*driver;	/* hw-specific hooks */
 	unsigned		saw_irq : 1;
 	unsigned		can_wakeup:1;	/* hw supports wakeup? */
Index: 2.6.14-ben/drivers/usb/host/ehci-hcd.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/host/ehci-hcd.c
+++ 2.6.14-ben/drivers/usb/host/ehci-hcd.c
@@ -750,6 +750,12 @@ static int ehci_suspend (struct usb_hcd 
 	if (time_before (jiffies, ehci->next_statechange))
 		msleep (100);
 
+	/* Disable emission of interrupts during suspend */
+	writel(0, &ehci->regs->intr_enable);
+	mb();
+	clear_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+	synchronize_irq(to_pci_dev(hcd->self.controller)->irq);
+
 #ifdef	CONFIG_USB_SUSPEND
 	(void) usb_suspend_device (hcd->self.root_hub, message);
 #else
@@ -776,6 +782,8 @@ static int ehci_resume (struct usb_hcd *
 	if (time_before (jiffies, ehci->next_statechange))
 		msleep (100);
 
+	set_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+
 	/* If any port is suspended (or owned by the companion),
 	 * we know we can/must resume the HC (and mustn't reset it).
 	 */
Index: 2.6.14-ben/drivers/usb/host/ehci-q.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/host/ehci-q.c
+++ 2.6.14-ben/drivers/usb/host/ehci-q.c
@@ -926,6 +926,11 @@ submit_async (
 #endif
 
 	spin_lock_irqsave (&ehci->lock, flags);
+	if (HC_IS_SUSPENDED(ehci_to_hcd(ehci)->state)) {
+		spin_unlock_irqrestore (&ehci->lock, flags);
+		return -ESHUTDOWN;
+	}
+
 	qh = qh_append_tds (ehci, urb, qtd_list, epnum, &ep->hcpriv);
 
 	/* Control/bulk operations through TTs don't need scheduling,
Index: 2.6.14-ben/drivers/usb/host/ehci-sched.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/host/ehci-sched.c
+++ 2.6.14-ben/drivers/usb/host/ehci-sched.c
@@ -602,6 +602,11 @@ static int intr_submit (
 
 	spin_lock_irqsave (&ehci->lock, flags);
 
+	if (HC_IS_SUSPENDED(ehci_to_hcd(ehci)->state)) {
+		spin_unlock_irqrestore (&ehci->lock, flags);
+		return -ESHUTDOWN;
+	}
+
 	/* get qh and force any scheduling errors */
 	INIT_LIST_HEAD (&empty);
 	qh = qh_append_tds (ehci, urb, &empty, epnum, &ep->hcpriv);
@@ -1456,6 +1461,11 @@ static int itd_submit (struct ehci_hcd *
 
 	/* schedule ... need to lock */
 	spin_lock_irqsave (&ehci->lock, flags);
+	if (HC_IS_SUSPENDED(ehci_to_hcd(ehci)->state)) {
+		spin_unlock_irqrestore (&ehci->lock, flags);
+		status = -ESHUTDOWN;
+		goto done;
+	}
 	status = iso_stream_schedule (ehci, urb, stream);
  	if (likely (status == 0))
 		itd_link_urb (ehci, urb, ehci->periodic_size << 3, stream);
@@ -1815,6 +1825,11 @@ static int sitd_submit (struct ehci_hcd 
 
 	/* schedule ... need to lock */
 	spin_lock_irqsave (&ehci->lock, flags);
+	if (HC_IS_SUSPENDED(ehci_to_hcd(ehci)->state)) {
+		spin_unlock_irqrestore (&ehci->lock, flags);
+		status = -ESHUTDOWN;
+		goto done;
+	}
 	status = iso_stream_schedule (ehci, urb, stream);
  	if (status == 0)
 		sitd_link_urb (ehci, urb, ehci->periodic_size << 3, stream);
Index: 2.6.14-ben/drivers/usb/host/ohci-hcd.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/host/ohci-hcd.c
+++ 2.6.14-ben/drivers/usb/host/ohci-hcd.c
@@ -252,6 +252,10 @@ static int ohci_urb_enqueue (
 
 	spin_lock_irqsave (&ohci->lock, flags);
 
+	if (HC_IS_SUSPENDED(hcd->state)) {
+		retval = -ESHUTDOWN;
+		goto fail;
+	}
 	/* don't submit to a dead HC */
 	if (!HC_IS_RUNNING(hcd->state)) {
 		retval = -ENODEV;
Index: 2.6.14-ben/drivers/usb/host/ohci-hub.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/host/ohci-hub.c
+++ 2.6.14-ben/drivers/usb/host/ohci-hub.c
@@ -219,13 +219,6 @@ static int ohci_hub_resume (struct usb_h
 	/* Sometimes PCI D3 suspend trashes frame timings ... */
 	periodic_reinit (ohci);
 
-	/* interrupts might have been disabled */
-	ohci_writel (ohci, OHCI_INTR_INIT, &ohci->regs->intrenable);
-	if (ohci->ed_rm_list)
-		ohci_writel (ohci, OHCI_INTR_SF, &ohci->regs->intrenable);
-	ohci_writel (ohci, ohci_readl (ohci, &ohci->regs->intrstatus),
-			&ohci->regs->intrstatus);
-
 	/* Then re-enable operations */
 	ohci_writel (ohci, OHCI_USB_OPER, &ohci->regs->control);
 	(void) ohci_readl (ohci, &ohci->regs->control);
@@ -241,6 +234,13 @@ static int ohci_hub_resume (struct usb_h
 	/* TRSMRCY */
 	msleep (10);
 
+	/* interrupts might have been disabled */
+	ohci_writel (ohci, OHCI_INTR_INIT, &ohci->regs->intrenable);
+	if (ohci->ed_rm_list)
+		ohci_writel (ohci, OHCI_INTR_SF, &ohci->regs->intrenable);
+	ohci_writel (ohci, ohci_readl (ohci, &ohci->regs->intrstatus),
+			&ohci->regs->intrstatus);
+
 	/* keep it alive for ~5x suspend + resume costs */
 	ohci->next_statechange = jiffies + msecs_to_jiffies (250);
 
Index: 2.6.14-ben/drivers/usb/host/ohci-pci.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/host/ohci-pci.c
+++ 2.6.14-ben/drivers/usb/host/ohci-pci.c
@@ -14,13 +14,6 @@
  * This file is licenced under the GPL.
  */
  
-#ifdef CONFIG_PPC_PMAC
-#include <asm/machdep.h>
-#include <asm/pmac_feature.h>
-#include <asm/pci-bridge.h>
-#include <asm/prom.h>
-#endif
-
 #ifndef CONFIG_PCI
 #error "This file is PCI bus glue.  CONFIG_PCI must be defined."
 #endif
@@ -118,6 +111,12 @@ static int ohci_pci_suspend (struct usb_
 	if (time_before (jiffies, ohci->next_statechange))
 		msleep (100);
 
+	/* Disable emission of interrupts during suspend */
+	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
+	mb();
+	clear_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+	synchronize_irq(to_pci_dev(hcd->self.controller)->irq);
+
 #ifdef	CONFIG_USB_SUSPEND
 	(void) usb_suspend_device (hcd->self.root_hub, message);
 #else
@@ -129,16 +128,6 @@ static int ohci_pci_suspend (struct usb_
 	/* let things settle down a bit */
 	msleep (100);
 	
-#ifdef CONFIG_PPC_PMAC
-	if (_machine == _MACH_Pmac) {
-	   	struct device_node	*of_node;
- 
-		/* Disable USB PAD & cell clock */
-		of_node = pci_device_to_OF_node (to_pci_dev(hcd->self.controller));
-		if (of_node)
-			pmac_call_feature(PMAC_FTR_USB_ENABLE, of_node, 0, 0);
-	}
-#endif /* CONFIG_PPC_PMAC */
 	return 0;
 }
 
@@ -148,20 +137,11 @@ static int ohci_pci_resume (struct usb_h
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
 	int			retval = 0;
 
-#ifdef CONFIG_PPC_PMAC
-	if (_machine == _MACH_Pmac) {
-		struct device_node *of_node;
-
-		/* Re-enable USB PAD & cell clock */
-		of_node = pci_device_to_OF_node (to_pci_dev(hcd->self.controller));
-		if (of_node)
-			pmac_call_feature (PMAC_FTR_USB_ENABLE, of_node, 0, 1);
-	}
-#endif /* CONFIG_PPC_PMAC */
-
 	/* resume root hub */
 	if (time_before (jiffies, ohci->next_statechange))
 		msleep (100);
+	set_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+
 #ifdef	CONFIG_USB_SUSPEND
 	/* get extra cleanup even if remote wakeup isn't in use */
 	retval = usb_resume_device (hcd->self.root_hub);
Index: 2.6.14-ben/drivers/usb/host/uhci-hcd.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/host/uhci-hcd.c
+++ 2.6.14-ben/drivers/usb/host/uhci-hcd.c
@@ -797,6 +797,11 @@ static int uhci_suspend(struct usb_hcd *
 
 done:
 	spin_unlock_irq(&uhci->lock);
+	if (rc == 0) {
+		mb();
+		clear_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+		synchronize_irq(hcd->irq);
+	}
 	return rc;
 }
 
@@ -818,6 +823,8 @@ static int uhci_resume(struct usb_hcd *h
 	 * system wakeup.  Check it and reconfigure to avoid problems.
 	 */
 	check_and_reset_hc(uhci);
+	set_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+	mb();
 	configure_hc(uhci);
 
 #ifndef CONFIG_USB_SUSPEND

