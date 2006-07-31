Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWGaOdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWGaOdg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWGaOdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:33:35 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:56152 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932363AbWGaOdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:33:13 -0400
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.18-rc3] build fixes:  ohci-omap
Date: Mon, 31 Jul 2006 07:29:39 -0700
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UPhzE9YkR5C9i2b"
Message-Id: <200607310729.40379.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_UPhzE9YkR5C9i2b
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The basic issue here is that some reorganization of the OMAP1 code
broke the build; this has been fixed in the linux-omap tree for
some time, so this also syncs up with the latest changes there.

--Boundary-00=_UPhzE9YkR5C9i2b
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ohci-omap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ohci-omap.patch"

The ohci-omap code has diverged from the working version in the linux-omap
tree; this syncs up the versions:

  - Another clock is needed in various cases
  - The omap-1510 iommu code needs to be #ifdeffed out on newer parts
  - Saner use of the HCD framework
  - Various other changes, e.g. a Nokia 770 quirk

And some minor dead-whitespace removal.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: o26/drivers/usb/host/ohci-omap.c
===================================================================
--- o26.orig/drivers/usb/host/ohci-omap.c	2006-07-30 22:09:39.000000000 -0700
+++ o26/drivers/usb/host/ohci-omap.c	2006-07-31 06:09:56.000000000 -0700
@@ -4,7 +4,7 @@
  * (C) Copyright 1999 Roman Weissgaerber <weissg@vienna.at>
  * (C) Copyright 2000-2005 David Brownell
  * (C) Copyright 2002 Hewlett-Packard Company
- * 
+ *
  * OMAP Bus Glue
  *
  * Modified for OMAP by Tony Lindgren <tony@atomide.com>
@@ -66,15 +66,20 @@ extern int usb_disabled(void);
 extern int ocpi_enable(void);
 
 static struct clk *usb_host_ck;
+static struct clk *usb_dc_ck;
+static int host_enabled;
+static int host_initialized;
 
 static void omap_ohci_clock_power(int on)
 {
 	if (on) {
+		clk_enable(usb_dc_ck);
 		clk_enable(usb_host_ck);
 		/* guesstimate for T5 == 1x 32K clock + APLL lock time */
 		udelay(100);
 	} else {
 		clk_disable(usb_host_ck);
+		clk_disable(usb_dc_ck);
 	}
 }
 
@@ -87,14 +92,14 @@ static int omap_ohci_transceiver_power(i
 	if (on) {
 		if (machine_is_omap_innovator() && cpu_is_omap1510())
 			fpga_write(fpga_read(INNOVATOR_FPGA_CAM_USB_CONTROL)
-				| ((1 << 5/*usb1*/) | (1 << 3/*usb2*/)), 
+				| ((1 << 5/*usb1*/) | (1 << 3/*usb2*/)),
 			       INNOVATOR_FPGA_CAM_USB_CONTROL);
 		else if (machine_is_omap_osk())
 			tps65010_set_gpio_out_value(GPIO1, LOW);
 	} else {
 		if (machine_is_omap_innovator() && cpu_is_omap1510())
 			fpga_write(fpga_read(INNOVATOR_FPGA_CAM_USB_CONTROL)
-				& ~((1 << 5/*usb1*/) | (1 << 3/*usb2*/)), 
+				& ~((1 << 5/*usb1*/) | (1 << 3/*usb2*/)),
 			       INNOVATOR_FPGA_CAM_USB_CONTROL);
 		else if (machine_is_omap_osk())
 			tps65010_set_gpio_out_value(GPIO1, HIGH);
@@ -103,6 +108,7 @@ static int omap_ohci_transceiver_power(i
 	return 0;
 }
 
+#ifdef CONFIG_ARCH_OMAP15XX
 /*
  * OMAP-1510 specific Local Bus clock on/off
  */
@@ -121,8 +127,8 @@ static int omap_1510_local_bus_power(int
 /*
  * OMAP-1510 specific Local Bus initialization
  * NOTE: This assumes 32MB memory size in OMAP1510LB_MEMSIZE.
- *       See also arch/mach-omap/memory.h for __virt_to_dma() and 
- *       __dma_to_virt() which need to match with the physical 
+ *       See also arch/mach-omap/memory.h for __virt_to_dma() and
+ *       __dma_to_virt() which need to match with the physical
  *       Local Bus address below.
  */
 static int omap_1510_local_bus_init(void)
@@ -130,7 +136,7 @@ static int omap_1510_local_bus_init(void
 	unsigned int tlb;
 	unsigned long lbaddr, physaddr;
 
-	omap_writel((omap_readl(OMAP1510_LB_CLOCK_DIV) & 0xfffffff8) | 0x4, 
+	omap_writel((omap_readl(OMAP1510_LB_CLOCK_DIV) & 0xfffffff8) | 0x4,
 	       OMAP1510_LB_CLOCK_DIV);
 
 	/* Configure the Local Bus MMU table */
@@ -138,7 +144,7 @@ static int omap_1510_local_bus_init(void
 		lbaddr = tlb * 0x00100000 + OMAP1510_LB_OFFSET;
 		physaddr = tlb * 0x00100000 + PHYS_OFFSET;
 		omap_writel((lbaddr & 0x0fffffff) >> 22, OMAP1510_LB_MMU_CAM_H);
-		omap_writel(((lbaddr & 0x003ffc00) >> 6) | 0xc, 
+		omap_writel(((lbaddr & 0x003ffc00) >> 6) | 0xc,
 		       OMAP1510_LB_MMU_CAM_L);
 		omap_writel(physaddr >> 16, OMAP1510_LB_MMU_RAM_H);
 		omap_writel((physaddr & 0x0000fc00) | 0x300, OMAP1510_LB_MMU_RAM_L);
@@ -152,6 +158,10 @@ static int omap_1510_local_bus_init(void
 
 	return 0;
 }
+#else
+#define omap_1510_local_bus_power(x)	{}
+#define omap_1510_local_bus_init()	{}
+#endif
 
 #ifdef	CONFIG_USB_OTG
 
@@ -173,13 +183,14 @@ static void start_hnp(struct ohci_hcd *o
 
 /*-------------------------------------------------------------------------*/
 
-static int omap_start_hc(struct ohci_hcd *ohci, struct platform_device *pdev)
+static int ohci_omap_init(struct usb_hcd *hcd)
 {
-	struct omap_usb_config	*config = pdev->dev.platform_data;
+	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
+	struct omap_usb_config	*config = hcd->self.controller->platform_data;
 	int			need_transceiver = (config->otg != 0);
 	int			ret;
 
-	dev_dbg(&pdev->dev, "starting USB Controller\n");
+	dev_dbg(hcd->self.controller, "starting USB Controller\n");
 
 	if (config->otg) {
 		ohci_to_hcd(ohci)->self.otg_port = config->otg;
@@ -200,7 +211,7 @@ static int omap_start_hc(struct ohci_hcd
 		if (ohci->transceiver) {
 			int	status = otg_set_host(ohci->transceiver,
 						&ohci_to_hcd(ohci)->self);
-			dev_dbg(&pdev->dev, "init %s transceiver, status %d\n",
+			dev_dbg(hcd->self.controller, "init %s transceiver, status %d\n",
 					ohci->transceiver->label, status);
 			if (status) {
 				if (ohci->transceiver)
@@ -208,7 +219,7 @@ static int omap_start_hc(struct ohci_hcd
 				return status;
 			}
 		} else {
-			dev_err(&pdev->dev, "can't find transceiver\n");
+			dev_err(hcd->self.controller, "can't find transceiver\n");
 			return -ENODEV;
 		}
 	}
@@ -247,6 +258,10 @@ static int omap_start_hc(struct ohci_hcd
 		}
 		ohci_writel(ohci, rh, &ohci->regs->roothub.a);
 		distrust_firmware = 0;
+	} else if (machine_is_nokia770()) {
+		/* We require a self-powered hub, which should have
+		 * plenty of power. */
+		ohci_to_hcd(ohci)->power_budget = 0;
 	}
 
 	/* FIXME khubd hub requests should manage power switching */
@@ -260,21 +275,15 @@ static int omap_start_hc(struct ohci_hcd
 	return 0;
 }
 
-static void omap_stop_hc(struct platform_device *pdev)
+static void ohci_omap_stop(struct usb_hcd *hcd)
 {
-	dev_dbg(&pdev->dev, "stopping USB Controller\n");
+	dev_dbg(hcd->self.controller, "stopping USB Controller\n");
 	omap_ohci_clock_power(0);
 }
 
 
 /*-------------------------------------------------------------------------*/
 
-void usb_hcd_omap_remove (struct usb_hcd *, struct platform_device *);
-
-/* configure so an HC device and id are always provided */
-/* always called with process context; sleeping is OK */
-
-
 /**
  * usb_hcd_omap_probe - initialize OMAP-based HCDs
  * Context: !in_interrupt()
@@ -283,7 +292,7 @@ void usb_hcd_omap_remove (struct usb_hcd
  * then invokes the start() method for the HCD associated with it
  * through the hotplug entry's driver_data.
  */
-int usb_hcd_omap_probe (const struct hc_driver *driver,
+static int usb_hcd_omap_probe (const struct hc_driver *driver,
 			  struct platform_device *pdev)
 {
 	int retval, irq;
@@ -291,12 +300,12 @@ int usb_hcd_omap_probe (const struct hc_
 	struct ohci_hcd *ohci;
 
 	if (pdev->num_resources != 2) {
-		printk(KERN_ERR "hcd probe: invalid num_resources: %i\n", 
+		printk(KERN_ERR "hcd probe: invalid num_resources: %i\n",
 		       pdev->num_resources);
 		return -ENODEV;
 	}
 
-	if (pdev->resource[0].flags != IORESOURCE_MEM 
+	if (pdev->resource[0].flags != IORESOURCE_MEM
 			|| pdev->resource[1].flags != IORESOURCE_IRQ) {
 		printk(KERN_ERR "hcd probe: invalid resource type\n");
 		return -ENODEV;
@@ -306,6 +315,17 @@ int usb_hcd_omap_probe (const struct hc_
 	if (IS_ERR(usb_host_ck))
 		return PTR_ERR(usb_host_ck);
 
+	if (!cpu_is_omap1510())
+		usb_dc_ck = clk_get(0, "usb_dc_ck");
+	else
+		usb_dc_ck = clk_get(0, "lb_ck");
+
+	if (IS_ERR(usb_dc_ck)) {
+		clk_put(usb_host_ck);
+		return PTR_ERR(usb_dc_ck);
+	}
+
+
 	hcd = usb_create_hcd (driver, &pdev->dev, pdev->dev.bus_id);
 	if (!hcd) {
 		retval = -ENOMEM;
@@ -325,9 +345,8 @@ int usb_hcd_omap_probe (const struct hc_
 	ohci = hcd_to_ohci(hcd);
 	ohci_hcd_init(ohci);
 
-	retval = omap_start_hc(ohci, pdev);
-	if (retval < 0)
-		goto err2;
+	host_initialized = 0;
+	host_enabled = 1;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -335,15 +354,21 @@ int usb_hcd_omap_probe (const struct hc_
 		goto err2;
 	}
 	retval = usb_add_hcd(hcd, irq, IRQF_DISABLED);
-	if (retval == 0)
-		return retval;
+	if (retval)
+		goto err2;
 
-	omap_stop_hc(pdev);
+	host_initialized = 1;
+
+	if (!host_enabled)
+		omap_ohci_clock_power(0);
+
+	return 0;
 err2:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 err1:
 	usb_put_hcd(hcd);
 err0:
+	clk_put(usb_dc_ck);
 	clk_put(usb_host_ck);
 	return retval;
 }
@@ -359,28 +384,36 @@ err0:
  * Reverses the effect of usb_hcd_omap_probe(), first invoking
  * the HCD's stop() method.  It is always called from a thread
  * context, normally "rmmod", "apmd", or something similar.
- *
  */
-void usb_hcd_omap_remove (struct usb_hcd *hcd, struct platform_device *pdev)
+static inline void
+usb_hcd_omap_remove (struct usb_hcd *hcd, struct platform_device *pdev)
 {
+	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
+
 	usb_remove_hcd(hcd);
+	if (ohci->transceiver) {
+		(void) otg_set_host(ohci->transceiver, 0);
+		put_device(ohci->transceiver->dev);
+	}
 	if (machine_is_omap_osk())
 		omap_free_gpio(9);
-	omap_stop_hc(pdev);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
+	clk_put(usb_dc_ck);
 	clk_put(usb_host_ck);
 }
 
 /*-------------------------------------------------------------------------*/
 
-static int __devinit
+static int
 ohci_omap_start (struct usb_hcd *hcd)
 {
 	struct omap_usb_config *config;
 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
 	int		ret;
 
+	if (!host_enabled)
+		return 0;
 	config = hcd->self.controller->platform_data;
 	if (config->otg || config->rwc)
 		writel(OHCI_CTRL_RWC, &ohci->regs->control);
@@ -409,8 +442,9 @@ static const struct hc_driver ohci_omap_
 	/*
 	 * basic lifecycle operations
 	 */
+	.reset =		ohci_omap_init,
 	.start =		ohci_omap_start,
-	.stop =			ohci_stop,
+	.stop =			ohci_omap_stop,
 
 	/*
 	 * managing i/o requests and associated device resources
@@ -446,13 +480,8 @@ static int ohci_hcd_omap_drv_probe(struc
 static int ohci_hcd_omap_drv_remove(struct platform_device *dev)
 {
 	struct usb_hcd		*hcd = platform_get_drvdata(dev);
-	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
 
 	usb_hcd_omap_remove(hcd, dev);
-	if (ohci->transceiver) {
-		(void) otg_set_host(ohci->transceiver, 0);
-		put_device(ohci->transceiver->dev);
-	}
 	platform_set_drvdata(dev, NULL);
 
 	return 0;
@@ -472,7 +501,7 @@ static int ohci_omap_suspend(struct plat
 
 	omap_ohci_clock_power(0);
 	ohci_to_hcd(ohci)->state = HC_STATE_SUSPENDED;
-	dev->power.power_state = PMSG_SUSPEND;
+	dev->dev.power.power_state = PMSG_SUSPEND;
 	return 0;
 }
 
@@ -485,8 +514,8 @@ static int ohci_omap_resume(struct platf
 	ohci->next_statechange = jiffies;
 
 	omap_ohci_clock_power(1);
-	dev->power.power_state = PMSG_ON;
-	usb_hcd_resume_root_hub(dev_get_drvdata(dev));
+	dev->dev.power.power_state = PMSG_ON;
+	usb_hcd_resume_root_hub(platform_get_drvdata(dev));
 	return 0;
 }
 

--Boundary-00=_UPhzE9YkR5C9i2b--
