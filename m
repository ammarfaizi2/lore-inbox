Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVAHGGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVAHGGU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVAHGEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:04:49 -0500
Received: from mail.kroah.org ([69.55.234.183]:19845 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261804AbVAHFr5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:47:57 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632682125@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:48 -0800
Message-Id: <1105163268738@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.42, 2004/12/20 14:19:05-08:00, stern@rowland.harvard.edu

[PATCH] USB: Create usb_hcd structures within usbcore [3/13]

This patch alters the OHCI driver, removing the routine that allocates the
hcd structure and introducing inline functions to convert safely between
the public and private hcd structures.  It also moves the code to
initialize the private structure into the reset routine, since the
allocation routine is now gone.  That particular aspect should be reviewed
by David, but for now it seems to work.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/ohci-dbg.c |   22 +++++++++++++---------
 drivers/usb/host/ohci-hcd.c |   34 +++++++++++++++++-----------------
 drivers/usb/host/ohci-hub.c |   27 +++++++++++++--------------
 drivers/usb/host/ohci-mem.c |   25 +++++++++----------------
 drivers/usb/host/ohci-pci.c |    8 +++-----
 drivers/usb/host/ohci-q.c   |   32 ++++++++++++++++----------------
 drivers/usb/host/ohci.h     |   25 ++++++++++++++-----------
 7 files changed, 85 insertions(+), 88 deletions(-)


diff -Nru a/drivers/usb/host/ohci-dbg.c b/drivers/usb/host/ohci-dbg.c
--- a/drivers/usb/host/ohci-dbg.c	2005-01-07 15:43:40 -08:00
+++ b/drivers/usb/host/ohci-dbg.c	2005-01-07 15:43:40 -08:00
@@ -676,19 +676,23 @@
 static CLASS_DEVICE_ATTR (registers, S_IRUGO, show_registers, NULL);
 
 
-static inline void create_debug_files (struct ohci_hcd *bus)
+static inline void create_debug_files (struct ohci_hcd *ohci)
 {
-	class_device_create_file(&bus->hcd.self.class_dev, &class_device_attr_async);
-	class_device_create_file(&bus->hcd.self.class_dev, &class_device_attr_periodic);
-	class_device_create_file(&bus->hcd.self.class_dev, &class_device_attr_registers);
-	ohci_dbg (bus, "created debug files\n");
+	struct class_device *cldev = &ohci_to_hcd(ohci)->self.class_dev;
+
+	class_device_create_file(cldev, &class_device_attr_async);
+	class_device_create_file(cldev, &class_device_attr_periodic);
+	class_device_create_file(cldev, &class_device_attr_registers);
+	ohci_dbg (ohci, "created debug files\n");
 }
 
-static inline void remove_debug_files (struct ohci_hcd *bus)
+static inline void remove_debug_files (struct ohci_hcd *ohci)
 {
-	class_device_remove_file(&bus->hcd.self.class_dev, &class_device_attr_async);
-	class_device_remove_file(&bus->hcd.self.class_dev, &class_device_attr_periodic);
-	class_device_remove_file(&bus->hcd.self.class_dev, &class_device_attr_registers);
+	struct class_device *cldev = &ohci_to_hcd(ohci)->self.class_dev;
+
+	class_device_remove_file(cldev, &class_device_attr_async);
+	class_device_remove_file(cldev, &class_device_attr_periodic);
+	class_device_remove_file(cldev, &class_device_attr_registers);
 }
 
 #endif
diff -Nru a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
--- a/drivers/usb/host/ohci-hcd.c	2005-01-07 15:43:40 -08:00
+++ b/drivers/usb/host/ohci-hcd.c	2005-01-07 15:43:40 -08:00
@@ -240,7 +240,7 @@
 	spin_lock_irqsave (&ohci->lock, flags);
 
 	/* don't submit to a dead HC */
-	if (!HCD_IS_RUNNING(ohci->hcd.state)) {
+	if (!HCD_IS_RUNNING(hcd->state)) {
 		retval = -ENODEV;
 		goto fail;
 	}
@@ -308,7 +308,7 @@
 #endif		  
 
 	spin_lock_irqsave (&ohci->lock, flags);
- 	if (HCD_IS_RUNNING(ohci->hcd.state)) {
+ 	if (HCD_IS_RUNNING(hcd->state)) {
 		urb_priv_t  *urb_priv;
 
 		/* Unless an IRQ completed the unlink while it was being
@@ -355,7 +355,7 @@
 rescan:
 	spin_lock_irqsave (&ohci->lock, flags);
 
-	if (!HCD_IS_RUNNING (ohci->hcd.state)) {
+	if (!HCD_IS_RUNNING (hcd->state)) {
 sanitize:
 		ed->state = ED_IDLE;
 		finish_unlinks (ohci, 0, NULL);
@@ -420,7 +420,7 @@
 	int ret;
 
 	disable (ohci);
-	ohci->regs = ohci->hcd.regs;
+	ohci->regs = ohci_to_hcd(ohci)->regs;
 	ohci->next_statechange = jiffies;
 
 #ifndef IR_DISABLE
@@ -456,13 +456,13 @@
 	if (ohci->hcca)
 		return 0;
 
-	ohci->hcca = dma_alloc_coherent (ohci->hcd.self.controller,
+	ohci->hcca = dma_alloc_coherent (ohci_to_hcd(ohci)->self.controller,
 			sizeof *ohci->hcca, &ohci->hcca_dma, 0);
 	if (!ohci->hcca)
 		return -ENOMEM;
 
 	if ((ret = ohci_mem_init (ohci)) < 0)
-		ohci_stop (&ohci->hcd);
+		ohci_stop (ohci_to_hcd(ohci));
 
 	return ret;
 
@@ -507,7 +507,7 @@
 
 	if (ohci->hc_control & OHCI_CTRL_RWC
 			&& !(ohci->flags & OHCI_QUIRK_AMD756))
-		ohci->hcd.can_wakeup = 1;
+		ohci_to_hcd(ohci)->can_wakeup = 1;
 
 	switch (ohci->hc_control & OHCI_CTRL_HCFS) {
 	case OHCI_USB_OPER:
@@ -605,7 +605,7 @@
 	ohci->hc_control &= OHCI_CTRL_RWC;
  	ohci->hc_control |= OHCI_CONTROL_INIT | OHCI_USB_OPER;
  	ohci_writel (ohci, ohci->hc_control, &ohci->regs->control);
-	ohci->hcd.state = USB_STATE_RUNNING;
+	ohci_to_hcd(ohci)->state = USB_STATE_RUNNING;
 
 	/* wake on ConnectStatusChange, matching external hubs */
 	ohci_writel (ohci, RH_HS_DRWE, &ohci->regs->roothub.status);
@@ -645,12 +645,12 @@
 
 	// POTPGT delay is bits 24-31, in 2 ms units.
 	mdelay ((roothub_a (ohci) >> 23) & 0x1fe);
-	bus = hcd_to_bus (&ohci->hcd);
-	ohci->hcd.state = USB_STATE_RUNNING;
+	bus = &ohci_to_hcd(ohci)->self;
+	ohci_to_hcd(ohci)->state = USB_STATE_RUNNING;
 
 	ohci_dump (ohci, 1);
 
-	udev = hcd_to_bus (&ohci->hcd)->root_hub;
+	udev = bus->root_hub;
 	if (udev) {
 		return 0;
 	}
@@ -665,7 +665,7 @@
 	}
 
 	udev->speed = USB_SPEED_FULL;
-	if (hcd_register_root (udev, &ohci->hcd) != 0) {
+	if (hcd_register_root (udev, ohci_to_hcd(ohci)) != 0) {
 		usb_put_dev (udev);
 		disable (ohci);
 		ohci->hc_control &= ~OHCI_CTRL_HCFS;
@@ -740,11 +740,11 @@
 	if (ohci->ed_rm_list)
 		finish_unlinks (ohci, ohci_frame_no(ohci), ptregs);
 	if ((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
-			&& HCD_IS_RUNNING(ohci->hcd.state))
+			&& HCD_IS_RUNNING(hcd->state))
 		ohci_writel (ohci, OHCI_INTR_SF, &regs->intrdisable);	
 	spin_unlock (&ohci->lock);
 
-	if (HCD_IS_RUNNING(ohci->hcd.state)) {
+	if (HCD_IS_RUNNING(hcd->state)) {
 		ohci_writel (ohci, ints, &regs->intrstatus);
 		ohci_writel (ohci, OHCI_INTR_MIE, &regs->intrenable);	
 		// flush those writes
@@ -762,7 +762,7 @@
 
 	ohci_dbg (ohci, "stop %s controller (state 0x%02x)\n",
 		hcfs2string (ohci->hc_control & OHCI_CTRL_HCFS),
-		ohci->hcd.state);
+		hcd->state);
 	ohci_dump (ohci, 1);
 
 	flush_scheduled_work();
@@ -773,7 +773,7 @@
 	remove_debug_files (ohci);
 	ohci_mem_cleanup (ohci);
 	if (ohci->hcca) {
-		dma_free_coherent (ohci->hcd.self.controller, 
+		dma_free_coherent (hcd->self.controller, 
 				sizeof *ohci->hcca, 
 				ohci->hcca, ohci->hcca_dma);
 		ohci->hcca = NULL;
@@ -792,7 +792,7 @@
 	int temp;
 	int i;
 	struct urb_priv *priv;
-	struct usb_device *root = ohci->hcd.self.root_hub;
+	struct usb_device *root = ohci_to_hcd(ohci)->self.root_hub;
 
 	/* mark any devices gone, so they do nothing till khubd disconnects.
 	 * recycle any "live" eds/tds (and urbs) right away.
diff -Nru a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
--- a/drivers/usb/host/ohci-hub.c	2005-01-07 15:43:40 -08:00
+++ b/drivers/usb/host/ohci-hub.c	2005-01-07 15:43:40 -08:00
@@ -73,7 +73,7 @@
 	ohci_dbg (ohci, "suspend root hub\n");
 
 	/* First stop any processing */
-	ohci->hcd.state = USB_STATE_QUIESCING;
+	hcd->state = USB_STATE_QUIESCING;
 	if (ohci->hc_control & OHCI_SCHED_ENABLES) {
 		int		limit;
 
@@ -103,7 +103,7 @@
 			&ohci->regs->intrstatus);
 
 	/* maybe resume can wake root hub */
-	if (ohci->hcd.remote_wakeup)
+	if (hcd->remote_wakeup)
 		ohci->hc_control |= OHCI_CTRL_RWE;
 	else
 		ohci->hc_control &= ~OHCI_CTRL_RWE;
@@ -119,7 +119,7 @@
 
 done:
 	if (status == 0)
-		ohci->hcd.state = HCD_STATE_SUSPENDED;
+		hcd->state = HCD_STATE_SUSPENDED;
 	spin_unlock_irqrestore (&ohci->lock, flags);
 	return status;
 }
@@ -198,7 +198,7 @@
 	}
 
 	/* Some controllers (lucent) need extra-long delays */
-	ohci->hcd.state = USB_STATE_RESUMING;
+	hcd->state = USB_STATE_RESUMING;
 	mdelay (20 /* usb 11.5.1.10 */ + 15);
 
 	temp = ohci_readl (ohci, &ohci->regs->control);
@@ -231,7 +231,7 @@
 	msleep (3);
 
 	temp = OHCI_CONTROL_INIT | OHCI_USB_OPER;
-	if (ohci->hcd.can_wakeup)
+	if (hcd->can_wakeup)
 		temp |= OHCI_CTRL_RWC;
 	ohci->hc_control = temp;
 	ohci_writel (ohci, temp, &ohci->regs->control);
@@ -261,8 +261,7 @@
 			temp |= OHCI_BLF;
 		}
 	}
-	if (hcd_to_bus (&ohci->hcd)->bandwidth_isoc_reqs
-			|| hcd_to_bus (&ohci->hcd)->bandwidth_int_reqs)
+	if (hcd->self.bandwidth_isoc_reqs || hcd->self.bandwidth_int_reqs)
 		enables |= OHCI_CTRL_PLE|OHCI_CTRL_IE;
 	if (enables) {
 		ohci_dbg (ohci, "restarting schedules ... %08x\n", enables);
@@ -273,7 +272,7 @@
 		(void) ohci_readl (ohci, &ohci->regs->control);
 	}
 
-	ohci->hcd.state = USB_STATE_RUNNING;
+	hcd->state = USB_STATE_RUNNING;
 	return 0;
 }
 
@@ -314,7 +313,7 @@
 	 * letting khubd or root hub timer see state changes.
 	 */
 	if ((ohci->hc_control & OHCI_CTRL_HCFS) != OHCI_USB_OPER
-			|| !HCD_IS_RUNNING(ohci->hcd.state)) {
+			|| !HCD_IS_RUNNING(hcd->state)) {
 		can_suspend = 0;
 		goto done;
 	}
@@ -356,7 +355,7 @@
 		 */
 		if (!(status & RH_PS_CCS))
 			continue;
-		if ((status & RH_PS_PSS) && ohci->hcd.remote_wakeup)
+		if ((status & RH_PS_PSS) && hcd->remote_wakeup)
 			continue;
 		can_suspend = 0;
 	}
@@ -378,8 +377,8 @@
 			&& usb_trylock_device (hcd->self.root_hub)
 			) {
 		ohci_vdbg (ohci, "autosuspend\n");
-		(void) ohci_hub_suspend (&ohci->hcd);
-		ohci->hcd.state = USB_STATE_RUNNING;
+		(void) ohci_hub_suspend (hcd);
+		hcd->state = USB_STATE_RUNNING;
 		usb_unlock_device (hcd->self.root_hub);
 	}
 #endif
@@ -613,8 +612,8 @@
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
 #ifdef	CONFIG_USB_OTG
-			if (ohci->hcd.self.otg_port == (wIndex + 1)
-					&& ohci->hcd.self.b_hnp_enable)
+			if (hcd->self.otg_port == (wIndex + 1)
+					&& hcd->self.b_hnp_enable)
 				start_hnp(ohci);
 			else
 #endif
diff -Nru a/drivers/usb/host/ohci-mem.c b/drivers/usb/host/ohci-mem.c
--- a/drivers/usb/host/ohci-mem.c	2005-01-07 15:43:40 -08:00
+++ b/drivers/usb/host/ohci-mem.c	2005-01-07 15:43:40 -08:00
@@ -23,34 +23,27 @@
 
 /*-------------------------------------------------------------------------*/
 
-static struct usb_hcd *ohci_hcd_alloc (void)
+static void ohci_hcd_init (struct ohci_hcd *ohci)
 {
-	struct ohci_hcd *ohci;
-
-	ohci = (struct ohci_hcd *) kmalloc (sizeof *ohci, GFP_KERNEL);
-	if (ohci != 0) {
-		memset (ohci, 0, sizeof (struct ohci_hcd));
-		ohci->hcd.product_desc = "OHCI Host Controller";
-		ohci->next_statechange = jiffies;
-		spin_lock_init (&ohci->lock);
-		INIT_LIST_HEAD (&ohci->pending);
-		INIT_WORK (&ohci->rh_resume, ohci_rh_resume, &ohci->hcd);
-		return &ohci->hcd;
-	}
-	return NULL;
+	ohci->next_statechange = jiffies;
+	spin_lock_init (&ohci->lock);
+	INIT_LIST_HEAD (&ohci->pending);
+	INIT_WORK (&ohci->rh_resume, ohci_rh_resume, ohci_to_hcd(ohci));
 }
 
 /*-------------------------------------------------------------------------*/
 
 static int ohci_mem_init (struct ohci_hcd *ohci)
 {
-	ohci->td_cache = dma_pool_create ("ohci_td", ohci->hcd.self.controller,
+	ohci->td_cache = dma_pool_create ("ohci_td",
+		ohci_to_hcd(ohci)->self.controller,
 		sizeof (struct td),
 		32 /* byte alignment */,
 		0 /* no page-crossing issues */);
 	if (!ohci->td_cache)
 		return -ENOMEM;
-	ohci->ed_cache = dma_pool_create ("ohci_ed", ohci->hcd.self.controller,
+	ohci->ed_cache = dma_pool_create ("ohci_ed",
+		ohci_to_hcd(ohci)->self.controller,
 		sizeof (struct ed),
 		16 /* byte alignment */,
 		0 /* no page-crossing issues */);
diff -Nru a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
--- a/drivers/usb/host/ohci-pci.c	2005-01-07 15:43:40 -08:00
+++ b/drivers/usb/host/ohci-pci.c	2005-01-07 15:43:40 -08:00
@@ -35,6 +35,7 @@
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
 
+	ohci_hcd_init (ohci);
 	return ohci_init (ohci);
 }
 
@@ -172,6 +173,8 @@
 
 static const struct hc_driver ohci_pci_hc_driver = {
 	.description =		hcd_name,
+	.product_desc =		"OHCI Host Controller",
+	.hcd_priv_size =	sizeof(struct ohci_hcd),
 
 	/*
 	 * generic hardware linkage
@@ -189,11 +192,6 @@
 	.resume =		ohci_pci_resume,
 #endif
 	.stop =			ohci_stop,
-
-	/*
-	 * memory lifecycle (except per-request)
-	 */
-	.hcd_alloc =		ohci_hcd_alloc,
 
 	/*
 	 * managing i/o requests and associated device resources
diff -Nru a/drivers/usb/host/ohci-q.c b/drivers/usb/host/ohci-q.c
--- a/drivers/usb/host/ohci-q.c	2005-01-07 15:43:40 -08:00
+++ b/drivers/usb/host/ohci-q.c	2005-01-07 15:43:40 -08:00
@@ -60,10 +60,10 @@
 
 	switch (usb_pipetype (urb->pipe)) {
 	case PIPE_ISOCHRONOUS:
-		hcd_to_bus (&ohci->hcd)->bandwidth_isoc_reqs--;
+		ohci_to_hcd(ohci)->self.bandwidth_isoc_reqs--;
 		break;
 	case PIPE_INTERRUPT:
-		hcd_to_bus (&ohci->hcd)->bandwidth_int_reqs--;
+		ohci_to_hcd(ohci)->self.bandwidth_int_reqs--;
 		break;
 	}
 
@@ -73,12 +73,12 @@
 
 	/* urb->complete() can reenter this HCD */
 	spin_unlock (&ohci->lock);
-	usb_hcd_giveback_urb (&ohci->hcd, urb, regs);
+	usb_hcd_giveback_urb (ohci_to_hcd(ohci), urb, regs);
 	spin_lock (&ohci->lock);
 
 	/* stop periodic dma if it's not needed */
-	if (hcd_to_bus (&ohci->hcd)->bandwidth_isoc_reqs == 0
-			&& hcd_to_bus (&ohci->hcd)->bandwidth_int_reqs == 0) {
+	if (ohci_to_hcd(ohci)->self.bandwidth_isoc_reqs == 0
+			&& ohci_to_hcd(ohci)->self.bandwidth_int_reqs == 0) {
 		ohci->hc_control &= ~(OHCI_CTRL_PLE|OHCI_CTRL_IE);
 		ohci_writel (ohci, ohci->hc_control, &ohci->regs->control);
 	}
@@ -163,7 +163,7 @@
 		}
 		ohci->load [i] += ed->load;
 	}
-	hcd_to_bus (&ohci->hcd)->bandwidth_allocated += ed->load / ed->interval;
+	ohci_to_hcd(ohci)->self.bandwidth_allocated += ed->load / ed->interval;
 }
 
 /* link an ed into one of the HC chains */
@@ -172,7 +172,7 @@
 {	 
 	int	branch;
 
-	if (ohci->hcd.state == USB_STATE_QUIESCING)
+	if (ohci_to_hcd(ohci)->state == USB_STATE_QUIESCING)
 		return -EAGAIN;
 
 	ed->state = ED_OPER;
@@ -276,7 +276,7 @@
 		}
 		ohci->load [i] -= ed->load;
 	}	
-	hcd_to_bus (&ohci->hcd)->bandwidth_allocated -= ed->load / ed->interval;
+	ohci_to_hcd(ohci)->self.bandwidth_allocated -= ed->load / ed->interval;
 
 	ohci_vdbg (ohci, "unlink %sed %p branch %d [%dus.], interval %d\n",
 		(ed->hwINFO & cpu_to_hc32 (ohci, ED_ISO)) ? "iso " : "",
@@ -619,8 +619,8 @@
 	 */
 	case PIPE_INTERRUPT:
 		/* ... and periodic urbs have extra accounting */
-		periodic = hcd_to_bus (&ohci->hcd)->bandwidth_int_reqs++ == 0
-			&& hcd_to_bus (&ohci->hcd)->bandwidth_isoc_reqs == 0;
+		periodic = ohci_to_hcd(ohci)->self.bandwidth_int_reqs++ == 0
+			&& ohci_to_hcd(ohci)->self.bandwidth_isoc_reqs == 0;
 		/* FALLTHROUGH */
 	case PIPE_BULK:
 		info = is_out
@@ -688,8 +688,8 @@
 				data + urb->iso_frame_desc [cnt].offset,
 				urb->iso_frame_desc [cnt].length, urb, cnt);
 		}
-		periodic = hcd_to_bus (&ohci->hcd)->bandwidth_isoc_reqs++ == 0
-			&& hcd_to_bus (&ohci->hcd)->bandwidth_int_reqs == 0;
+		periodic = ohci_to_hcd(ohci)->self.bandwidth_isoc_reqs++ == 0
+			&& ohci_to_hcd(ohci)->self.bandwidth_int_reqs == 0;
 		break;
 	}
 
@@ -920,7 +920,7 @@
 		/* only take off EDs that the HC isn't using, accounting for
 		 * frame counter wraps and EDs with partially retired TDs
 		 */
-		if (likely (regs && HCD_IS_RUNNING(ohci->hcd.state))) {
+		if (likely (regs && HCD_IS_RUNNING(ohci_to_hcd(ohci)->state))) {
 			if (tick_before (tick, ed->tick)) {
 skip_ed:
 				last = &ed->ed_next;
@@ -1002,7 +1002,7 @@
 
 		/* but if there's work queued, reschedule */
 		if (!list_empty (&ed->td_list)) {
-			if (HCD_IS_RUNNING(ohci->hcd.state))
+			if (HCD_IS_RUNNING(ohci_to_hcd(ohci)->state))
 				ed_schedule (ohci, ed);
 		}
 
@@ -1011,8 +1011,8 @@
    	}
 
 	/* maybe reenable control and bulk lists */ 
-	if (HCD_IS_RUNNING(ohci->hcd.state)
-			&& ohci->hcd.state != USB_STATE_QUIESCING
+	if (HCD_IS_RUNNING(ohci_to_hcd(ohci)->state)
+			&& ohci_to_hcd(ohci)->state != USB_STATE_QUIESCING
 			&& !ohci->ed_rm_list) {
 		u32	command = 0, control = 0;
 
diff -Nru a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
--- a/drivers/usb/host/ohci.h	2005-01-07 15:43:40 -08:00
+++ b/drivers/usb/host/ohci.h	2005-01-07 15:43:40 -08:00
@@ -345,11 +345,6 @@
  */
 
 struct ohci_hcd {
-	/*
-	 * framework state
-	 */
-	struct usb_hcd		hcd;		/* must come first! */
-
 	spinlock_t		lock;
 
 	/*
@@ -405,7 +400,15 @@
 
 };
 
-#define hcd_to_ohci(hcd_ptr) container_of(hcd_ptr, struct ohci_hcd, hcd)
+/* convert between an hcd pointer and the corresponding ohci_hcd */
+static inline struct ohci_hcd *hcd_to_ohci (struct usb_hcd *hcd)
+{
+	return (struct ohci_hcd *) (hcd->hcd_priv);
+}
+static inline struct usb_hcd *ohci_to_hcd (const struct ohci_hcd *ohci)
+{
+	return container_of ((void *) ohci, struct usb_hcd, hcd_priv);
+}
 
 /*-------------------------------------------------------------------------*/
 
@@ -414,13 +417,13 @@
 #endif	/* DEBUG */
 
 #define ohci_dbg(ohci, fmt, args...) \
-	dev_dbg ((ohci)->hcd.self.controller , fmt , ## args )
+	dev_dbg (ohci_to_hcd(ohci)->self.controller , fmt , ## args )
 #define ohci_err(ohci, fmt, args...) \
-	dev_err ((ohci)->hcd.self.controller , fmt , ## args )
+	dev_err (ohci_to_hcd(ohci)->self.controller , fmt , ## args )
 #define ohci_info(ohci, fmt, args...) \
-	dev_info ((ohci)->hcd.self.controller , fmt , ## args )
+	dev_info (ohci_to_hcd(ohci)->self.controller , fmt , ## args )
 #define ohci_warn(ohci, fmt, args...) \
-	dev_warn ((ohci)->hcd.self.controller , fmt , ## args )
+	dev_warn (ohci_to_hcd(ohci)->self.controller , fmt , ## args )
 
 #ifdef OHCI_VERBOSE_DEBUG
 #	define ohci_vdbg ohci_dbg
@@ -553,7 +556,7 @@
 
 static inline void disable (struct ohci_hcd *ohci)
 {
-	ohci->hcd.state = USB_STATE_HALT;
+	ohci_to_hcd(ohci)->state = USB_STATE_HALT;
 }
 
 #define	FI			0x2edf		/* 12000 bits per frame (-1) */

