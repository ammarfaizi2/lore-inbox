Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVAHFwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVAHFwW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 00:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVAHFwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 00:52:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:15237 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261795AbVAHFrx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:47:53 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163268388@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:48 -0800
Message-Id: <11051632683091@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.44, 2004/12/20 14:20:07-08:00, stern@rowland.harvard.edu

[PATCH] USB: Create usb_hcd structures within usbcore [5/13]

This patch alters the non-PCI OHCI drivers, removing the routines that
allocate the hcd structures and introducing inline functions to convert
safely between the public and private hcd structures.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/ohci-lh7a404.c |   43 +++-----
 drivers/usb/host/ohci-omap.c    |   60 +++++-------
 drivers/usb/host/ohci-pxa27x.c  |   41 +++-----
 drivers/usb/host/ohci-sa1111.c  |   28 ++---
 drivers/usb/host/sl811-hcd.c    |  198 +++++++++++++++++++++-------------------
 drivers/usb/host/sl811.h        |    8 +
 6 files changed, 184 insertions(+), 194 deletions(-)


diff -Nru a/drivers/usb/host/ohci-lh7a404.c b/drivers/usb/host/ohci-lh7a404.c
--- a/drivers/usb/host/ohci-lh7a404.c	2005-01-07 15:43:22 -08:00
+++ b/drivers/usb/host/ohci-lh7a404.c	2005-01-07 15:43:22 -08:00
@@ -106,23 +106,22 @@
 		retval = -ENOMEM;
 		goto err1;
 	}
-	
 
-	hcd = driver->hcd_alloc ();
-	if (hcd == NULL){
-		pr_debug ("hcd_alloc failed");
+	if(dev->resource[1].flags != IORESOURCE_IRQ){
+		pr_debug ("resource[1] is not IORESOURCE_IRQ");
 		retval = -ENOMEM;
 		goto err1;
 	}
+	
 
-	if(dev->resource[1].flags != IORESOURCE_IRQ){
-		pr_debug ("resource[1] is not IORESOURCE_IRQ");
+	hcd = usb_create_hcd (driver);
+	if (hcd == NULL){
+		pr_debug ("hcd_alloc failed");
 		retval = -ENOMEM;
 		goto err1;
 	}
+	ohci_hcd_init(hcd_to_ohci(hcd));
 
-	hcd->driver = (struct hc_driver *) driver;
-	hcd->description = driver->description;
 	hcd->irq = dev->resource[1].start;
 	hcd->regs = addr;
 	hcd->self.controller = &dev->dev;
@@ -130,27 +129,21 @@
 	retval = hcd_buffer_create (hcd);
 	if (retval != 0) {
 		pr_debug ("pool alloc fail");
-		goto err1;
+		goto err2;
 	}
 
 	retval = request_irq (hcd->irq, usb_hcd_lh7a404_hcim_irq, SA_INTERRUPT,
-			      hcd->description, hcd);
+			      hcd->driver->description, hcd);
 	if (retval != 0) {
 		pr_debug("request_irq failed");
 		retval = -EBUSY;
-		goto err2;
+		goto err3;
 	}
 
 	pr_debug ("%s (LH7A404) at 0x%p, irq %d",
-	     hcd->description, hcd->regs, hcd->irq);
+		hcd->driver->description, hcd->regs, hcd->irq);
 
-	usb_bus_init (&hcd->self);
-	hcd->self.op = &usb_hcd_operations;
-	hcd->self.release = &usb_hcd_release;
-	hcd->self.hcpriv = (void *) hcd;
 	hcd->self.bus_name = "lh7a404";
-	hcd->product_desc = "LH7A404 OHCI";
-
 	usb_register_bus (&hcd->self);
 
 	if ((retval = driver->start (hcd)) < 0)
@@ -162,10 +155,11 @@
 	*hcd_out = hcd;
 	return 0;
 
- err2:
+ err3:
 	hcd_buffer_destroy (hcd);
+ err2:
+	usb_put_hcd(hcd);
  err1:
-	kfree(hcd);
 	lh7a404_stop_hc(dev);
 	release_mem_region(dev->resource[0].start,
 				dev->resource[0].end
@@ -226,7 +220,7 @@
 		return ret;
 
 	if ((ret = ohci_run (ohci)) < 0) {
-		err ("can't start %s", ohci->hcd.self.bus_name);
+		err ("can't start %s", hcd->self.bus_name);
 		ohci_stop (hcd);
 		return ret;
 	}
@@ -237,6 +231,8 @@
 
 static const struct hc_driver ohci_lh7a404_hc_driver = {
 	.description =		hcd_name,
+	.product_desc =		"LH7A404 OHCI",
+	.hcd_priv_size =	sizeof(struct ohci_hcd),
 
 	/*
 	 * generic hardware linkage
@@ -253,11 +249,6 @@
 	/* resume:		ohci_lh7a404_resume,   -- tbd */
 #endif /*CONFIG_PM*/
 	.stop =			ohci_stop,
-
-	/*
-	 * memory lifecycle (except per-request)
-	 */
-	.hcd_alloc =		ohci_hcd_alloc,
 
 	/*
 	 * managing i/o requests and associated device resources
diff -Nru a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
--- a/drivers/usb/host/ohci-omap.c	2005-01-07 15:43:22 -08:00
+++ b/drivers/usb/host/ohci-omap.c	2005-01-07 15:43:22 -08:00
@@ -157,7 +157,7 @@
 
 static void start_hnp(struct ohci_hcd *ohci)
 {
-	const unsigned	port = ohci->hcd.self.otg_port - 1;
+	const unsigned	port = ohci_to_hcd(ohci)->self.otg_port - 1;
 	unsigned long	flags;
 
 	otg_start_hnp(ohci->transceiver);
@@ -181,7 +181,7 @@
 	dev_dbg(&pdev->dev, "starting USB Controller\n");
 
 	if (config->otg) {
-		ohci->hcd.self.otg_port = config->otg;
+		ohci_to_hcd(ohci)->self.otg_port = config->otg;
 		/* default/minimum OTG power budget:  8 mA */
 		ohci->power_budget = 8;
 	}
@@ -198,7 +198,7 @@
 		ohci->transceiver = otg_get_transceiver();
 		if (ohci->transceiver) {
 			int	status = otg_set_host(ohci->transceiver,
-						&ohci->hcd.self);
+						&ohci_to_hcd(ohci)->self);
 			dev_dbg(&pdev->dev, "init %s transceiver, status %d\n",
 					ohci->transceiver->label, status);
 			if (status) {
@@ -293,7 +293,7 @@
 		return -EBUSY;
 	}
 
-	hcd = driver->hcd_alloc ();
+	hcd = usb_create_hcd (driver);
 	if (hcd == NULL){
 		dev_dbg(&pdev->dev, "hcd_alloc failed\n");
 		retval = -ENOMEM;
@@ -301,40 +301,33 @@
 	}
 	dev_set_drvdata(&pdev->dev, hcd);
 	ohci = hcd_to_ohci(hcd);
+	ohci_hcd_init(ohci);
 
-	hcd->driver = (struct hc_driver *) driver;
-	hcd->description = driver->description;
 	hcd->irq = pdev->resource[1].start;
 	hcd->regs = (void *)pdev->resource[0].start;
 	hcd->self.controller = &pdev->dev;
 
 	retval = omap_start_hc(ohci, pdev);
 	if (retval < 0)
-		goto err1;
+		goto err2;
 
 	retval = hcd_buffer_create (hcd);
 	if (retval != 0) {
 		dev_dbg(&pdev->dev, "pool alloc fail\n");
-		goto err1;
+		goto err2;
 	}
 
 	retval = request_irq (hcd->irq, usb_hcd_irq, 
-			      SA_INTERRUPT, hcd->description, hcd);
+			      SA_INTERRUPT, hcd->driver->description, hcd);
 	if (retval != 0) {
 		dev_dbg(&pdev->dev, "request_irq failed\n");
 		retval = -EBUSY;
-		goto err2;
+		goto err3;
 	}
 
 	dev_info(&pdev->dev, "at 0x%p, irq %d\n", hcd->regs, hcd->irq);
 
-	usb_bus_init (&hcd->self);
-	hcd->self.op = &usb_hcd_operations;
-	hcd->self.release = &usb_hcd_release;
-	hcd->self.hcpriv = (void *) hcd;
 	hcd->self.bus_name = pdev->dev.bus_id;
-	hcd->product_desc = "OMAP OHCI";
-
 	usb_register_bus (&hcd->self);
 
 	if ((retval = driver->start (hcd)) < 0) 
@@ -345,16 +338,17 @@
 
 	return 0;
 
- err2:
+ err3:
 	hcd_buffer_destroy (hcd);
+ err2:
+	dev_set_drvdata(&pdev->dev, NULL);
+	usb_put_hcd(hcd);
  err1:
-	kfree(hcd);
 	omap_stop_hc(pdev);
 
 	release_mem_region(pdev->resource[0].start, 
 			   pdev->resource[0].end - pdev->resource[0].start + 1);
 
-	dev_set_drvdata(&pdev->dev, 0);
 	return retval;
 }
 
@@ -418,7 +412,7 @@
 		writel(OHCI_CTRL_RWC, &ohci->regs->control);
 
 	if ((ret = ohci_run (ohci)) < 0) {
-		err ("can't start %s", ohci->hcd.self.bus_name);
+		err ("can't start %s", hcd->self.bus_name);
 		ohci_stop (hcd);
 		return ret;
 	}
@@ -429,6 +423,8 @@
 
 static const struct hc_driver ohci_omap_hc_driver = {
 	.description =		hcd_name,
+	.product_desc =		"OMAP OHCI",
+	.hcd_priv_size =	sizeof(struct ohci_hcd),
 
 	/*
 	 * generic hardware linkage
@@ -443,11 +439,6 @@
 	.stop =			ohci_stop,
 
 	/*
-	 * memory lifecycle (except per-request)
-	 */
-	.hcd_alloc =		ohci_hcd_alloc,
-
-	/*
 	 * managing i/o requests and associated device resources
 	 */
 	.urb_enqueue =		ohci_urb_enqueue,
@@ -512,19 +503,20 @@
 		return 0;
 
 	dev_dbg(dev, "suspend to %d\n", state);
-	down(&ohci->hcd.self.root_hub->serialize);
-	status = ohci_hub_suspend(&ohci->hcd);
+	down(&ohci_to_hcd(ohci)->self.root_hub->serialize);
+	status = ohci_hub_suspend(ohci_to_hcd(ohci));
 	if (status == 0) {
 		if (state >= 4) {
 			/* power off + reset */
 			OTG_SYSCON_2_REG &= ~UHOST_EN;
-			ohci->hcd.self.root_hub->state = USB_STATE_SUSPENDED;
+			ohci_to_hcd(ohci)->self.root_hub->state =
+					USB_STATE_SUSPENDED;
 			state = 4;
 		}
-		ohci->hcd.state = HCD_STATE_SUSPENDED;
+		ohci_to_hcd(ohci)->state = HCD_STATE_SUSPENDED;
 		dev->power.power_state = state;
 	}
-	up(&ohci->hcd.self.root_hub->serialize);
+	up(&ohci_to_hcd(ohci)->self.root_hub->serialize);
 	return status;
 }
 
@@ -546,11 +538,11 @@
 		dev_dbg(dev, "resume from %d\n", dev->power.power_state);
 #ifdef	CONFIG_USB_SUSPEND
 		/* get extra cleanup even if remote wakeup isn't in use */
-		status = usb_resume_device(ohci->hcd.self.root_hub);
+		status = usb_resume_device(ohci_to_hcd(ohci)->self.root_hub);
 #else
-		down(&ohci->hcd.self.root_hub->serialize);
-		status = ohci_hub_resume(&ohci->hcd);
-		up(&ohci->hcd.self.root_hub->serialize);
+		down(&ohci_to_hcd(ohci)->self.root_hub->serialize);
+		status = ohci_hub_resume(ohci_to_hcd(ohci));
+		up(&ohci_to_hcd(ohci)->self.root_hub->serialize);
 #endif
 		if (status == 0)
 			dev->power.power_state = 0;
diff -Nru a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
--- a/drivers/usb/host/ohci-pxa27x.c	2005-01-07 15:43:22 -08:00
+++ b/drivers/usb/host/ohci-pxa27x.c	2005-01-07 15:43:22 -08:00
@@ -206,21 +206,20 @@
 		goto err1;
 	}
 
-	hcd = driver->hcd_alloc ();
-	if (hcd == NULL){
-		pr_debug ("hcd_alloc failed");
+	if(dev->resource[1].flags != IORESOURCE_IRQ){
+		pr_debug ("resource[1] is not IORESOURCE_IRQ");
 		retval = -ENOMEM;
 		goto err1;
 	}
 
-	if(dev->resource[1].flags != IORESOURCE_IRQ){
-		pr_debug ("resource[1] is not IORESOURCE_IRQ");
+	hcd = usb_create_hcd (driver);
+	if (hcd == NULL){
+		pr_debug ("hcd_alloc failed");
 		retval = -ENOMEM;
 		goto err1;
 	}
+	ohci_hcd_init(hcd_to_ohci(hcd));
 
-	hcd->driver = (struct hc_driver *) driver;
-	hcd->description = driver->description;
 	hcd->irq = dev->resource[1].start;
 	hcd->regs = addr;
 	hcd->self.controller = &dev->dev;
@@ -228,27 +227,21 @@
 	retval = hcd_buffer_create (hcd);
 	if (retval != 0) {
 		pr_debug ("pool alloc fail");
-		goto err1;
+		goto err2;
 	}
 
 	retval = request_irq (hcd->irq, usb_hcd_irq, SA_INTERRUPT,
-			      hcd->description, hcd);
+			      hcd->driver->description, hcd);
 	if (retval != 0) {
 		pr_debug("request_irq(%d) failed with retval %d\n",hcd->irq,retval);
 		retval = -EBUSY;
-		goto err2;
+		goto err3;
 	}
 
 	pr_debug ("%s (pxa27x) at 0x%p, irq %d",
-	     hcd->description, hcd->regs, hcd->irq);
+		hcd->driver->description, hcd->regs, hcd->irq);
 
-	usb_bus_init (&hcd->self);
-	hcd->self.op = &usb_hcd_operations;
-	hcd->self.release = &usb_hcd_release;
-	hcd->self.hcpriv = (void *) hcd;
 	hcd->self.bus_name = "pxa27x";
-	hcd->product_desc = "PXA27x OHCI";
-
 	usb_register_bus (&hcd->self);
 
 	if ((retval = driver->start (hcd)) < 0) {
@@ -259,10 +252,11 @@
 	*hcd_out = hcd;
 	return 0;
 
- err2:
+ err3:
 	hcd_buffer_destroy (hcd);
+ err2:
+	usb_put_hcd(hcd);
  err1:
-	kfree(hcd);
 	pxa27x_stop_hc(dev);
 	release_mem_region(dev->resource[0].start,
 				dev->resource[0].end
@@ -323,7 +317,7 @@
 		return ret;
 
 	if ((ret = ohci_run (ohci)) < 0) {
-		err ("can't start %s", ohci->hcd.self.bus_name);
+		err ("can't start %s", hcd->self.bus_name);
 		ohci_stop (hcd);
 		return ret;
 	}
@@ -335,6 +329,8 @@
 
 static const struct hc_driver ohci_pxa27x_hc_driver = {
 	.description =		hcd_name,
+	.product_desc =		"PXA27x OHCI",
+	.hcd_priv_size =	sizeof(struct ohci_hcd),
 
 	/*
 	 * generic hardware linkage
@@ -347,11 +343,6 @@
 	 */
 	.start =		ohci_pxa27x_start,
 	.stop =			ohci_stop,
-
-	/*
-	 * memory lifecycle (except per-request)
-	 */
-	.hcd_alloc =		ohci_hcd_alloc,
 
 	/*
 	 * managing i/o requests and associated device resources
diff -Nru a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
--- a/drivers/usb/host/ohci-sa1111.c	2005-01-07 15:43:22 -08:00
+++ b/drivers/usb/host/ohci-sa1111.c	2005-01-07 15:43:22 -08:00
@@ -162,15 +162,14 @@
 
 	sa1111_start_hc(dev);
 
-	hcd = driver->hcd_alloc ();
+	hcd = usb_create_hcd (driver);
 	if (hcd == NULL){
 		dbg ("hcd_alloc failed");
 		retval = -ENOMEM;
 		goto err1;
 	}
+	ohci_hcd_init(hcd_to_ohci(hcd));
 
-	hcd->driver = (struct hc_driver *) driver;
-	hcd->description = driver->description;
 	hcd->irq = dev->irq[1];
 	hcd->regs = dev->mapbase;
 	hcd->self.controller = &dev->dev;
@@ -178,27 +177,21 @@
 	retval = hcd_buffer_create (hcd);
 	if (retval != 0) {
 		dbg ("pool alloc fail");
-		goto err1;
+		goto err2;
 	}
 
 	retval = request_irq (hcd->irq, usb_hcd_sa1111_hcim_irq, SA_INTERRUPT,
-			      hcd->description, hcd);
+			      hcd->driver->description, hcd);
 	if (retval != 0) {
 		dbg("request_irq failed");
 		retval = -EBUSY;
-		goto err2;
+		goto err3;
 	}
 
 	info ("%s (SA-1111) at 0x%p, irq %d\n",
-	      hcd->description, hcd->regs, hcd->irq);
+		hcd->driver->description, hcd->regs, hcd->irq);
 
-	usb_bus_init (&hcd->self);
-	hcd->self.op = &usb_hcd_operations;
-	hcd->self.release = &usb_hcd_release;
-	hcd->self.hcpriv = (void *) hcd;
 	hcd->self.bus_name = "sa1111";
-	hcd->product_desc = "SA-1111 OHCI";
-
 	usb_register_bus (&hcd->self);
 
 	if ((retval = driver->start (hcd)) < 0) 
@@ -210,10 +203,11 @@
 	*hcd_out = hcd;
 	return 0;
 
- err2:
+ err3:
 	hcd_buffer_destroy (hcd);
+ err2:
+	usb_put_hcd(hcd);
  err1:
-	kfree(hcd);
 	sa1111_stop_hc(dev);
 	release_mem_region(dev->res.start, dev->res.end - dev->res.start + 1);
 	return retval;
@@ -269,7 +263,7 @@
 		return ret;
 
 	if ((ret = ohci_run (ohci)) < 0) {
-		err ("can't start %s", ohci->hcd.self.bus_name);
+		err ("can't start %s", hcd->self.bus_name);
 		ohci_stop (hcd);
 		return ret;
 	}
@@ -280,6 +274,8 @@
 
 static const struct hc_driver ohci_sa1111_hc_driver = {
 	.description =		hcd_name,
+	.product_desc =		"SA-1111 OHCI",
+	.hcd_priv_size =	sizeof(struct ohci_hcd),
 
 	/*
 	 * generic hardware linkage
diff -Nru a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
--- a/drivers/usb/host/sl811-hcd.c	2005-01-07 15:43:22 -08:00
+++ b/drivers/usb/host/sl811-hcd.c	2005-01-07 15:43:22 -08:00
@@ -90,10 +90,12 @@
 
 /*-------------------------------------------------------------------------*/
 
-static irqreturn_t sl811h_irq(int irq, void *_sl811, struct pt_regs *regs);
+static irqreturn_t sl811h_irq(int irq, void *_hcd, struct pt_regs *regs);
 
 static void port_power(struct sl811 *sl811, int is_on)
 {
+	struct usb_hcd	*hcd = sl811_to_hcd(sl811);
+
 	/* hub is inactive unless the port is powered */
 	if (is_on) {
 		if (sl811->port1 & (1 << USB_PORT_FEAT_POWER))
@@ -101,12 +103,12 @@
 
 		sl811->port1 = (1 << USB_PORT_FEAT_POWER);
 		sl811->irq_enable = SL11H_INTMASK_INSRMV;
-		sl811->hcd.self.controller->power.power_state = PM_SUSPEND_ON;
+		hcd->self.controller->power.power_state = PM_SUSPEND_ON;
 	} else {
 		sl811->port1 = 0;
 		sl811->irq_enable = 0;
-		sl811->hcd.state = USB_STATE_HALT;
-		sl811->hcd.self.controller->power.power_state = PM_SUSPEND_DISK;
+		hcd->state = USB_STATE_HALT;
+		hcd->self.controller->power.power_state = PM_SUSPEND_DISK;
 	}
 	sl811->ctrl1 = 0;
 	sl811_write(sl811, SL11H_IRQ_ENABLE, 0);
@@ -115,12 +117,12 @@
 	if (sl811->board && sl811->board->port_power) {
 		/* switch VBUS, at 500mA unless hub power budget gets set */
 		DBG("power %s\n", is_on ? "on" : "off");
-		sl811->board->port_power(sl811->hcd.self.controller, is_on);
+		sl811->board->port_power(hcd->self.controller, is_on);
 	}
 
 	/* reset as thoroughly as we can */
 	if (sl811->board && sl811->board->reset)
-		sl811->board->reset(sl811->hcd.self.controller);
+		sl811->board->reset(hcd->self.controller);
 
 	sl811_write(sl811, SL11H_IRQ_ENABLE, 0);
 	sl811_write(sl811, SL11H_CTLREG1, sl811->ctrl1);
@@ -446,7 +448,7 @@
 	spin_unlock(&urb->lock);
 
 	spin_unlock(&sl811->lock);
-	usb_hcd_giveback_urb(&sl811->hcd, urb, regs);
+	usb_hcd_giveback_urb(sl811_to_hcd(sl811), urb, regs);
 	spin_lock(&sl811->lock);
 
 	/* leave active endpoints in the schedule */
@@ -475,7 +477,7 @@
 	}	
 	ep->branch = PERIODIC_SIZE;
 	sl811->periodic_count--;
-	hcd_to_bus(&sl811->hcd)->bandwidth_allocated
+	sl811_to_hcd(sl811)->self.bandwidth_allocated
 		-= ep->load / ep->period;
 	if (ep == sl811->next_periodic)
 		sl811->next_periodic = ep->next;
@@ -643,9 +645,10 @@
 	return irqstat;
 }
 
-static irqreturn_t sl811h_irq(int irq, void *_sl811, struct pt_regs *regs)
+static irqreturn_t sl811h_irq(int irq, void *_hcd, struct pt_regs *regs)
 {
-	struct sl811	*sl811 = _sl811;
+	struct usb_hcd	*hcd = _hcd;
+	struct sl811	*sl811 = hcd_to_sl811(hcd);
 	u8		irqstat;
 	irqreturn_t	ret = IRQ_NONE;
 	unsigned	retries = 5;
@@ -757,7 +760,7 @@
 		if (sl811->port1 & (1 << USB_PORT_FEAT_ENABLE))
 			start_transfer(sl811);
 		ret = IRQ_HANDLED;
-		sl811->hcd.saw_irq = 1;
+		hcd->saw_irq = 1;
 		if (retries--)
 			goto retry;
 	}
@@ -835,7 +838,7 @@
 
 	/* don't submit to a dead or disabled port */
 	if (!(sl811->port1 & (1 << USB_PORT_FEAT_ENABLE))
-			|| !HCD_IS_RUNNING(sl811->hcd.state)) {
+			|| !HCD_IS_RUNNING(hcd->state)) {
 		retval = -ENODEV;
 		goto fail;
 	}
@@ -937,8 +940,7 @@
 			sl811->load[i] += ep->load;
 		}
 		sl811->periodic_count++;
-		hcd_to_bus(&sl811->hcd)->bandwidth_allocated
-				+= ep->load / ep->period;
+		hcd->self.bandwidth_allocated += ep->load / ep->period;
 		sofirq_on(sl811);
 	}
 
@@ -1396,7 +1398,7 @@
 	unsigned		i;
 
 	seq_printf(s, "%s\n%s version %s\nportstatus[1] = %08x\n",
-		sl811->hcd.product_desc,
+		sl811_to_hcd(sl811)->product_desc,
 		hcd_name, DRIVER_VERSION,
 		sl811->port1);
 
@@ -1544,7 +1546,7 @@
 	struct sl811	*sl811 = hcd_to_sl811(hcd);
 	unsigned long	flags;
 
-	del_timer_sync(&sl811->hcd.rh_timer);
+	del_timer_sync(&hcd->rh_timer);
 
 	spin_lock_irqsave(&sl811->lock, flags);
 	port_power(sl811, 0);
@@ -1559,7 +1561,7 @@
 
 	/* chip has been reset, VBUS power is off */
 
-	udev = usb_alloc_dev(NULL, &sl811->hcd.self, 0);
+	udev = usb_alloc_dev(NULL, &hcd->self, 0);
 	if (!udev)
 		return -ENOMEM;
 
@@ -1567,9 +1569,9 @@
 	hcd->state = USB_STATE_RUNNING;
 
 	if (sl811->board)
-		sl811->hcd.can_wakeup = sl811->board->can_wakeup;
+		hcd->can_wakeup = sl811->board->can_wakeup;
 
-	if (hcd_register_root(udev, &sl811->hcd) != 0) {
+	if (hcd_register_root(udev, hcd) != 0) {
 		usb_put_dev(udev);
 		sl811h_stop(hcd);
 		return -ENODEV;
@@ -1585,6 +1587,7 @@
 
 static struct hc_driver sl811h_hc_driver = {
 	.description =		hcd_name,
+	.hcd_priv_size =	sizeof(struct sl811),
 
 	/*
 	 * generic hardware linkage
@@ -1618,35 +1621,32 @@
 sl811h_remove(struct device *dev)
 {
 	struct sl811		*sl811 = dev_get_drvdata(dev);
+	struct usb_hcd		*hcd = sl811_to_hcd(sl811);
 	struct platform_device	*pdev;
 	struct resource		*res;
 
 	pdev = container_of(dev, struct platform_device, dev);
 
-	if (HCD_IS_RUNNING(sl811->hcd.state))
-		sl811->hcd.state = USB_STATE_QUIESCING;
+	if (HCD_IS_RUNNING(hcd->state))
+		hcd->state = USB_STATE_QUIESCING;
 
-	usb_disconnect(&sl811->hcd.self.root_hub);
+	usb_disconnect(&hcd->self.root_hub);
 	remove_debug_file(sl811);
-	sl811h_stop(&sl811->hcd);
+	sl811h_stop(hcd);
 
-	if (!list_empty(&sl811->hcd.self.bus_list))
-		usb_deregister_bus(&sl811->hcd.self);
+	usb_deregister_bus(&hcd->self);
 
-	if (sl811->hcd.irq >= 0)
-		free_irq(sl811->hcd.irq, sl811);
+	free_irq(hcd->irq, hcd);
 
-	if (sl811->data_reg)
-		iounmap(sl811->data_reg);
+	iounmap(sl811->data_reg);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	release_mem_region(res->start, 1);
 
-	if (sl811->addr_reg) 
-		iounmap(sl811->addr_reg);
+	iounmap(sl811->addr_reg);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, 1);
 
-	kfree(sl811);
+	usb_put_hcd(hcd);
 	return 0;
 }
 
@@ -1655,13 +1655,15 @@
 static int __init
 sl811h_probe(struct device *dev)
 {
+	struct usb_hcd		*hcd;
 	struct sl811		*sl811;
 	struct platform_device	*pdev;
 	struct resource		*addr, *data;
 	int			irq;
-	int			status;
+	void __iomem		*addr_reg;
+	void __iomem		*data_reg;
+	int			retval;
 	u8			tmp;
-	unsigned long		flags;
 
 	/* basic sanity checks first.  board-specific init logic should
 	 * have initialized these three resources and probably board
@@ -1684,32 +1686,39 @@
 		return -EINVAL;
 	}
 
-	if (!request_mem_region(addr->start, 1, hcd_name))
-		return -EBUSY;
+	if (!request_mem_region(addr->start, 1, hcd_name)) {
+		retval = -EBUSY;
+		goto err1;
+	}
+	addr_reg = ioremap(addr->start, resource_len(addr));
+	if (addr_reg == NULL) {
+		retval = -ENOMEM;
+		goto err2;
+	}
+
 	if (!request_mem_region(data->start, 1, hcd_name)) {
-		release_mem_region(addr->start, 1);
-		return -EBUSY;
+		retval = -EBUSY;
+		goto err3;
+	}
+	data_reg = ioremap(data->start, resource_len(addr));
+	if (data_reg == NULL) {
+		retval = -ENOMEM;
+		goto err4;
 	}
 
 	/* allocate and initialize hcd */
-	sl811 = kcalloc(1, sizeof *sl811, GFP_KERNEL);
-	if (!sl811)
-		return 0;
+	hcd = usb_create_hcd(&sl811h_hc_driver);
+	if (!hcd) {
+		retval = 0;
+		goto err5;
+	}
+	sl811 = hcd_to_sl811(hcd);
 	dev_set_drvdata(dev, sl811);
 
-	usb_bus_init(&sl811->hcd.self);
-	sl811->hcd.self.controller = dev;
-	sl811->hcd.self.bus_name = dev->bus_id;
-	sl811->hcd.self.op = &usb_hcd_operations;
-	sl811->hcd.self.hcpriv = sl811;
-
-	sl811->hcd.self.release = &usb_hcd_release;
-
-	sl811->hcd.description = sl811h_hc_driver.description;
-	init_timer(&sl811->hcd.rh_timer);
-	sl811->hcd.driver = &sl811h_hc_driver;
-	sl811->hcd.irq = -1;
-	sl811->hcd.state = USB_STATE_HALT;
+	hcd->self.controller = dev;
+	hcd->self.bus_name = dev->bus_id;
+	hcd->irq = irq;
+	hcd->regs = addr_reg;
 
 	spin_lock_init(&sl811->lock);
 	INIT_LIST_HEAD(&sl811->async);
@@ -1717,36 +1726,27 @@
 	init_timer(&sl811->timer);
 	sl811->timer.function = sl811h_timer;
 	sl811->timer.data = (unsigned long) sl811;
+	sl811->addr_reg = addr_reg;
+	sl811->data_reg = data_reg;
 
-	sl811->addr_reg = ioremap(addr->start, resource_len(addr));
-	if (sl811->addr_reg == NULL) {
-		status = -ENOMEM;
-		goto fail;
-	}
-	sl811->data_reg = ioremap(data->start, resource_len(addr));
-	if (sl811->data_reg == NULL) {
-		status = -ENOMEM;
-		goto fail;
-	}
-
-	spin_lock_irqsave(&sl811->lock, flags);
+	spin_lock_irq(&sl811->lock);
 	port_power(sl811, 0);
-	spin_unlock_irqrestore(&sl811->lock, flags);
+	spin_unlock_irq(&sl811->lock);
 	msleep(200);
 
 	tmp = sl811_read(sl811, SL11H_HWREVREG);
 	switch (tmp >> 4) {
 	case 1:
-		sl811->hcd.product_desc = "SL811HS v1.2";
+		hcd->product_desc = "SL811HS v1.2";
 		break;
 	case 2:
-		sl811->hcd.product_desc = "SL811HS v1.5";
+		hcd->product_desc = "SL811HS v1.5";
 		break;
 	default:
 		/* reject case 0, SL11S is less functional */
 		DBG("chiprev %02x\n", tmp);
-		status = -ENXIO;
-		goto fail;
+		retval = -ENXIO;
+		goto err6;
 	}
 
 	/* sl811s would need a different handler for this irq */
@@ -1754,25 +1754,41 @@
 	/* Cypress docs say the IRQ is IRQT_HIGH ... */
 	set_irq_type(irq, IRQT_RISING);
 #endif
-	status = request_irq(irq, sl811h_irq, SA_INTERRUPT, hcd_name, sl811);
-	if (status < 0)
-		goto fail;
-	sl811->hcd.irq = irq;
+	retval = request_irq(irq, sl811h_irq, SA_INTERRUPT,
+			hcd->driver->description, hcd);
+	if (retval != 0)
+		goto err6;
+
+	INFO("%s, irq %d\n", hcd->product_desc, irq);
+
+	retval = usb_register_bus(&hcd->self);
+	if (retval < 0)
+		goto err7;
+
+	retval = sl811h_start(hcd);
+	if (retval < 0)
+		goto err8;
 
-	INFO("%s, irq %d\n", sl811->hcd.product_desc, irq);
+	create_debug_file(sl811);
+	return 0;
 
-	status = usb_register_bus(&sl811->hcd.self);
-	if (status < 0)
-		goto fail;
-	status = sl811h_start(&sl811->hcd);
-	if (status == 0) {
-		create_debug_file(sl811);
-		return 0;
-	}
-fail:
-	sl811h_remove(dev);
-	DBG("init error, %d\n", status);
-	return status;
+ err8:
+	usb_deregister_bus(&hcd->self);
+ err7:
+	free_irq(hcd->irq, hcd);
+ err6:
+	usb_put_hcd(hcd);
+ err5:
+	iounmap(data_reg);
+ err4:
+	release_mem_region(data->start, 1);
+ err3:
+	iounmap(addr_reg);
+ err2:
+	release_mem_region(addr->start, 1);
+ err1:
+	DBG("init error, %d\n", retval);
+	return retval;
 }
 
 #ifdef	CONFIG_PM
@@ -1792,7 +1808,7 @@
 		return retval;
 
 	if (state <= PM_SUSPEND_MEM)
-		retval = sl811h_hub_suspend(&sl811->hcd);
+		retval = sl811h_hub_suspend(sl811_to_hcd(sl811));
 	else
 		port_power(sl811, 0);
 	if (retval == 0)
@@ -1812,14 +1828,14 @@
 	 * let's assume it'd only be powered to enable remote wakeup.
 	 */
 	if (dev->power.power_state > PM_SUSPEND_MEM
-			|| !sl811->hcd.can_wakeup) {
+			|| !sl811_to_hcd(sl811)->can_wakeup) {
 		sl811->port1 = 0;
 		port_power(sl811, 1);
 		return 0;
 	}
 
 	dev->power.power_state = PM_SUSPEND_ON;
-	return sl811h_hub_resume(&sl811->hcd);
+	return sl811h_hub_resume(sl811_to_hcd(sl811));
 }
 
 #else
diff -Nru a/drivers/usb/host/sl811.h b/drivers/usb/host/sl811.h
--- a/drivers/usb/host/sl811.h	2005-01-07 15:43:22 -08:00
+++ b/drivers/usb/host/sl811.h	2005-01-07 15:43:22 -08:00
@@ -118,7 +118,6 @@
 #define	PERIODIC_SIZE		(1 << LOG2_PERIODIC_SIZE)
 
 struct sl811 {
-	struct usb_hcd		hcd;
 	spinlock_t		lock;
 	void __iomem		*addr_reg;
 	void __iomem		*data_reg;
@@ -158,7 +157,12 @@
 
 static inline struct sl811 *hcd_to_sl811(struct usb_hcd *hcd)
 {
-	return container_of(hcd, struct sl811, hcd);
+	return (struct sl811 *) (hcd->hcd_priv);
+}
+
+static inline struct usb_hcd *sl811_to_hcd(struct sl811 *sl811)
+{
+	return container_of((void *) sl811, struct usb_hcd, hcd_priv);
 }
 
 struct sl811h_ep {

