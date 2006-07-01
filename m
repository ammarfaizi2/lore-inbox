Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWGAPDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWGAPDa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWGAPDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:03:12 -0400
Received: from www.osadl.org ([213.239.205.134]:7589 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751529AbWGAO5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:39 -0400
Message-Id: <20060701145228.016076000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:55:08 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, greg@kroah.com
Subject: [RFC][patch 41/44] usb: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-usb.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/usb/core/hcd-pci.c       |    2 +-
 drivers/usb/gadget/at91_udc.c    |    4 ++--
 drivers/usb/gadget/goku_udc.c    |    2 +-
 drivers/usb/gadget/lh7a40x_udc.c |    2 +-
 drivers/usb/gadget/net2280.c     |    2 +-
 drivers/usb/gadget/omap_udc.c    |    6 +++---
 drivers/usb/gadget/pxa2xx_udc.c  |    6 +++---
 drivers/usb/host/ehci-au1xxx.c   |    2 +-
 drivers/usb/host/ehci-fsl.c      |    2 +-
 drivers/usb/host/isp116x-hcd.c   |    2 +-
 drivers/usb/host/ohci-at91.c     |    2 +-
 drivers/usb/host/ohci-au1xxx.c   |    2 +-
 drivers/usb/host/ohci-lh7a404.c  |    2 +-
 drivers/usb/host/ohci-omap.c     |    4 ++--
 drivers/usb/host/ohci-ppc-soc.c  |    2 +-
 drivers/usb/host/ohci-pxa27x.c   |    2 +-
 drivers/usb/host/ohci-s3c2410.c  |    2 +-
 drivers/usb/host/ohci-sa1111.c   |    2 +-
 drivers/usb/host/sl811-hcd.c     |    2 +-
 19 files changed, 25 insertions(+), 25 deletions(-)

Index: linux-2.6.git/drivers/usb/core/hcd-pci.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/core/hcd-pci.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/core/hcd-pci.c	2006-07-01 16:51:49.000000000 +0200
@@ -125,7 +125,7 @@ int usb_hcd_pci_probe (struct pci_dev *d
 
 	pci_set_master (dev);
 
-	retval = usb_add_hcd (hcd, dev->irq, SA_SHIRQ);
+	retval = usb_add_hcd (hcd, dev->irq, IRQF_SHARED);
 	if (retval != 0)
 		goto err4;
 	return retval;
Index: linux-2.6.git/drivers/usb/gadget/at91_udc.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/gadget/at91_udc.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/gadget/at91_udc.c	2006-07-01 16:51:49.000000000 +0200
@@ -1653,13 +1653,13 @@ static int __devinit at91udc_probe(struc
 	pullup(udc, 0);
 
 	/* request UDC and maybe VBUS irqs */
-	if (request_irq(AT91_ID_UDP, at91_udc_irq, SA_INTERRUPT, driver_name, udc)) {
+	if (request_irq(AT91_ID_UDP, at91_udc_irq, IRQF_DISABLED, driver_name, udc)) {
 		DBG("request irq %d failed\n", AT91_ID_UDP);
 		retval = -EBUSY;
 		goto fail1;
 	}
 	if (udc->board.vbus_pin > 0) {
-		if (request_irq(udc->board.vbus_pin, at91_vbus_irq, SA_INTERRUPT, driver_name, udc)) {
+		if (request_irq(udc->board.vbus_pin, at91_vbus_irq, IRQF_DISABLED, driver_name, udc)) {
 			DBG("request vbus irq %d failed\n", udc->board.vbus_pin);
 			free_irq(AT91_ID_UDP, udc);
 			retval = -EBUSY;
Index: linux-2.6.git/drivers/usb/gadget/goku_udc.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/gadget/goku_udc.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/gadget/goku_udc.c	2006-07-01 16:51:49.000000000 +0200
@@ -1916,7 +1916,7 @@ static int goku_probe(struct pci_dev *pd
 	/* init to known state, then setup irqs */
 	udc_reset(dev);
 	udc_reinit (dev);
-	if (request_irq(pdev->irq, goku_irq, SA_SHIRQ/*|SA_SAMPLE_RANDOM*/,
+	if (request_irq(pdev->irq, goku_irq, IRQF_SHARED/*|IRQF_SAMPLE_RANDOM*/,
 			driver_name, dev) != 0) {
 		DBG(dev, "request interrupt %d failed\n", pdev->irq);
 		retval = -EBUSY;
Index: linux-2.6.git/drivers/usb/gadget/lh7a40x_udc.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/gadget/lh7a40x_udc.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/gadget/lh7a40x_udc.c	2006-07-01 16:51:49.000000000 +0200
@@ -2107,7 +2107,7 @@ static int lh7a40x_udc_probe(struct plat
 
 	/* irq setup after old hardware state is cleaned up */
 	retval =
-	    request_irq(IRQ_USBINTR, lh7a40x_udc_irq, SA_INTERRUPT, driver_name,
+	    request_irq(IRQ_USBINTR, lh7a40x_udc_irq, IRQF_DISABLED, driver_name,
 			dev);
 	if (retval != 0) {
 		DEBUG(KERN_ERR "%s: can't get irq %i, err %d\n", driver_name,
Index: linux-2.6.git/drivers/usb/gadget/net2280.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/gadget/net2280.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/gadget/net2280.c	2006-07-01 16:51:49.000000000 +0200
@@ -2895,7 +2895,7 @@ static int net2280_probe (struct pci_dev
 		goto done;
 	}
 
-	if (request_irq (pdev->irq, net2280_irq, SA_SHIRQ, driver_name, dev)
+	if (request_irq (pdev->irq, net2280_irq, IRQF_SHARED, driver_name, dev)
 			!= 0) {
 		ERROR (dev, "request interrupt %d failed\n", pdev->irq);
 		retval = -EBUSY;
Index: linux-2.6.git/drivers/usb/gadget/omap_udc.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/gadget/omap_udc.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/gadget/omap_udc.c	2006-07-01 16:51:49.000000000 +0200
@@ -2818,7 +2818,7 @@ bad_on_1710:
 
 	/* USB general purpose IRQ:  ep0, state changes, dma, etc */
 	status = request_irq(pdev->resource[1].start, omap_udc_irq,
-			SA_SAMPLE_RANDOM, driver_name, udc);
+			IRQF_SAMPLE_RANDOM, driver_name, udc);
 	if (status != 0) {
 		ERR( "can't get irq %ld, err %d\n",
 			pdev->resource[1].start, status);
@@ -2827,7 +2827,7 @@ bad_on_1710:
 
 	/* USB "non-iso" IRQ (PIO for all but ep0) */
 	status = request_irq(pdev->resource[2].start, omap_udc_pio_irq,
-			SA_SAMPLE_RANDOM, "omap_udc pio", udc);
+			IRQF_SAMPLE_RANDOM, "omap_udc pio", udc);
 	if (status != 0) {
 		ERR( "can't get irq %ld, err %d\n",
 			pdev->resource[2].start, status);
@@ -2835,7 +2835,7 @@ bad_on_1710:
 	}
 #ifdef	USE_ISO
 	status = request_irq(pdev->resource[3].start, omap_udc_iso_irq,
-			SA_INTERRUPT, "omap_udc iso", udc);
+			IRQF_DISABLED, "omap_udc iso", udc);
 	if (status != 0) {
 		ERR("can't get irq %ld, err %d\n",
 			pdev->resource[3].start, status);
Index: linux-2.6.git/drivers/usb/gadget/pxa2xx_udc.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/gadget/pxa2xx_udc.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/gadget/pxa2xx_udc.c	2006-07-01 16:51:49.000000000 +0200
@@ -2521,7 +2521,7 @@ static int __init pxa2xx_udc_probe(struc
 
 	/* irq setup after old hardware state is cleaned up */
 	retval = request_irq(IRQ_USB, pxa2xx_udc_irq,
-			SA_INTERRUPT, driver_name, dev);
+			IRQF_DISABLED, driver_name, dev);
 	if (retval != 0) {
 		printk(KERN_ERR "%s: can't get irq %i, err %d\n",
 			driver_name, IRQ_USB, retval);
@@ -2533,7 +2533,7 @@ static int __init pxa2xx_udc_probe(struc
 	if (machine_is_lubbock()) {
 		retval = request_irq(LUBBOCK_USB_DISC_IRQ,
 				lubbock_vbus_irq,
-				SA_INTERRUPT | SA_SAMPLE_RANDOM,
+				IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
 				driver_name, dev);
 		if (retval != 0) {
 			printk(KERN_ERR "%s: can't get irq %i, err %d\n",
@@ -2544,7 +2544,7 @@ lubbock_fail0:
 		}
 		retval = request_irq(LUBBOCK_USB_IRQ,
 				lubbock_vbus_irq,
-				SA_INTERRUPT | SA_SAMPLE_RANDOM,
+				IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
 				driver_name, dev);
 		if (retval != 0) {
 			printk(KERN_ERR "%s: can't get irq %i, err %d\n",
Index: linux-2.6.git/drivers/usb/host/ehci-au1xxx.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/host/ehci-au1xxx.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/host/ehci-au1xxx.c	2006-07-01 16:51:49.000000000 +0200
@@ -148,7 +148,7 @@ int usb_ehci_au1xxx_probe(const struct h
 	/* ehci_hcd_init(hcd_to_ehci(hcd)); */
 
 	retval =
-	    usb_add_hcd(hcd, dev->resource[1].start, SA_INTERRUPT | SA_SHIRQ);
+	    usb_add_hcd(hcd, dev->resource[1].start, IRQF_DISABLED | IRQF_SHARED);
 	if (retval == 0)
 		return retval;
 
Index: linux-2.6.git/drivers/usb/host/ehci-fsl.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/host/ehci-fsl.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/host/ehci-fsl.c	2006-07-01 16:51:49.000000000 +0200
@@ -121,7 +121,7 @@ int usb_hcd_fsl_probe(const struct hc_dr
 	temp = in_le32(hcd->regs + 0x1a8);
 	out_le32(hcd->regs + 0x1a8, temp | 0x3);
 
-	retval = usb_add_hcd(hcd, irq, SA_SHIRQ);
+	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (retval != 0)
 		goto err4;
 	return retval;
Index: linux-2.6.git/drivers/usb/host/isp116x-hcd.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/host/isp116x-hcd.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/host/isp116x-hcd.c	2006-07-01 16:51:49.000000000 +0200
@@ -1653,7 +1653,7 @@ static int __init isp116x_probe(struct p
 		goto err6;
 	}
 
-	ret = usb_add_hcd(hcd, irq, SA_INTERRUPT);
+	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED);
 	if (ret)
 		goto err6;
 
Index: linux-2.6.git/drivers/usb/host/ohci-at91.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/host/ohci-at91.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/host/ohci-at91.c	2006-07-01 16:51:49.000000000 +0200
@@ -125,7 +125,7 @@ int usb_hcd_at91_probe (const struct hc_
 	at91_start_hc(pdev);
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
-	retval = usb_add_hcd(hcd, pdev->resource[1].start, SA_INTERRUPT);
+	retval = usb_add_hcd(hcd, pdev->resource[1].start, IRQF_DISABLED);
 	if (retval == 0)
 		return retval;
 
Index: linux-2.6.git/drivers/usb/host/ohci-au1xxx.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/host/ohci-au1xxx.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/host/ohci-au1xxx.c	2006-07-01 16:51:49.000000000 +0200
@@ -191,7 +191,7 @@ static int usb_ohci_au1xxx_probe(const s
 	au1xxx_start_ohc(dev);
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
-	retval = usb_add_hcd(hcd, dev->resource[1].start, SA_INTERRUPT | SA_SHIRQ);
+	retval = usb_add_hcd(hcd, dev->resource[1].start, IRQF_DISABLED | IRQF_SHARED);
 	if (retval == 0)
 		return retval;
 
Index: linux-2.6.git/drivers/usb/host/ohci-lh7a404.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/host/ohci-lh7a404.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/host/ohci-lh7a404.c	2006-07-01 16:51:49.000000000 +0200
@@ -100,7 +100,7 @@ int usb_hcd_lh7a404_probe (const struct 
 	lh7a404_start_hc(dev);
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
-	retval = usb_add_hcd(hcd, dev->resource[1].start, SA_INTERRUPT);
+	retval = usb_add_hcd(hcd, dev->resource[1].start, IRQF_DISABLED);
 	if (retval == 0)
 		return retval;
 
Index: linux-2.6.git/drivers/usb/host/ohci-omap.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/host/ohci-omap.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/host/ohci-omap.c	2006-07-01 16:51:49.000000000 +0200
@@ -14,7 +14,7 @@
  * This file is licenced under the GPL.
  */
 
-#include <linux/signal.h>	/* SA_INTERRUPT */
+#include <linux/signal.h>	/* IRQF_DISABLED */
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
@@ -334,7 +334,7 @@ int usb_hcd_omap_probe (const struct hc_
 		retval = -ENXIO;
 		goto err2;
 	}
-	retval = usb_add_hcd(hcd, irq, SA_INTERRUPT);
+	retval = usb_add_hcd(hcd, irq, IRQF_DISABLED);
 	if (retval == 0)
 		return retval;
 
Index: linux-2.6.git/drivers/usb/host/ohci-ppc-soc.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/host/ohci-ppc-soc.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/host/ohci-ppc-soc.c	2006-07-01 16:51:49.000000000 +0200
@@ -75,7 +75,7 @@ static int usb_hcd_ppc_soc_probe(const s
 	ohci->flags |= OHCI_BIG_ENDIAN;
 	ohci_hcd_init(ohci);
 
-	retval = usb_add_hcd(hcd, irq, SA_INTERRUPT);
+	retval = usb_add_hcd(hcd, irq, IRQF_DISABLED);
 	if (retval == 0)
 		return retval;
 
Index: linux-2.6.git/drivers/usb/host/ohci-pxa27x.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/host/ohci-pxa27x.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/host/ohci-pxa27x.c	2006-07-01 16:51:49.000000000 +0200
@@ -190,7 +190,7 @@ int usb_hcd_pxa27x_probe (const struct h
 
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
-	retval = usb_add_hcd(hcd, pdev->resource[1].start, SA_INTERRUPT);
+	retval = usb_add_hcd(hcd, pdev->resource[1].start, IRQF_DISABLED);
 	if (retval == 0)
 		return retval;
 
Index: linux-2.6.git/drivers/usb/host/ohci-s3c2410.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/host/ohci-s3c2410.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/host/ohci-s3c2410.c	2006-07-01 16:51:49.000000000 +0200
@@ -388,7 +388,7 @@ static int usb_hcd_s3c2410_probe (const 
 
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
-	retval = usb_add_hcd(hcd, dev->resource[1].start, SA_INTERRUPT);
+	retval = usb_add_hcd(hcd, dev->resource[1].start, IRQF_DISABLED);
 	if (retval != 0)
 		goto err_ioremap;
 
Index: linux-2.6.git/drivers/usb/host/ohci-sa1111.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/host/ohci-sa1111.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/host/ohci-sa1111.c	2006-07-01 16:51:49.000000000 +0200
@@ -143,7 +143,7 @@ int usb_hcd_sa1111_probe (const struct h
 	sa1111_start_hc(dev);
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
-	retval = usb_add_hcd(hcd, dev->irq[1], SA_INTERRUPT);
+	retval = usb_add_hcd(hcd, dev->irq[1], IRQF_DISABLED);
 	if (retval == 0)
 		return retval;
 
Index: linux-2.6.git/drivers/usb/host/sl811-hcd.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/host/sl811-hcd.c	2006-07-01 16:51:09.000000000 +0200
+++ linux-2.6.git/drivers/usb/host/sl811-hcd.c	2006-07-01 16:51:49.000000000 +0200
@@ -1749,7 +1749,7 @@ sl811h_probe(struct platform_device *dev
 	 * was on a system with single edge triggering, so most sorts of
 	 * triggering arrangement should work.
 	 */
-	retval = usb_add_hcd(hcd, irq, SA_INTERRUPT | SA_SHIRQ);
+	retval = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
 	if (retval != 0)
 		goto err6;
 

--

