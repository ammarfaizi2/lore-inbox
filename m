Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWEEQpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWEEQpa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbWEEQp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:45:29 -0400
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:35716 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751654AbWEEQo4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:44:56 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
In-Reply-To: <2.420169009@selenic.com>
Message-Id: <9.420169009@selenic.com>
Subject: [PATCH 8/14] random: Remove SA_SAMPLE_RANDOM from USB gadget drivers
Date: Fri, 05 May 2006 11:42:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove SA_SAMPLE_RANDOM from USB gadget drivers

There's no a priori reason to think that USB device interrupts will
contain "entropy" as defined/required by /dev/random. In fact, most
operations will be streaming and bandwidth- or CPU-limited.
/dev/random needs unpredictable inputs such as human interaction or
chaotic physical processes like turbulence manifested in disk seek
times.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/drivers/usb/gadget/pxa2xx_udc.c
===================================================================
--- 2.6.orig/drivers/usb/gadget/pxa2xx_udc.c	2006-05-02 17:28:45.000000000 -0500
+++ 2.6/drivers/usb/gadget/pxa2xx_udc.c	2006-05-03 12:46:17.000000000 -0500
@@ -2525,10 +2525,8 @@ static int __init pxa2xx_udc_probe(struc
 
 #ifdef CONFIG_ARCH_LUBBOCK
 	if (machine_is_lubbock()) {
-		retval = request_irq(LUBBOCK_USB_DISC_IRQ,
-				lubbock_vbus_irq,
-				SA_INTERRUPT | SA_SAMPLE_RANDOM,
-				driver_name, dev);
+		retval = request_irq(LUBBOCK_USB_DISC_IRQ, lubbock_vbus_irq,
+				     SA_INTERRUPT, driver_name, dev);
 		if (retval != 0) {
 			printk(KERN_ERR "%s: can't get irq %i, err %d\n",
 				driver_name, LUBBOCK_USB_DISC_IRQ, retval);
@@ -2536,10 +2534,8 @@ lubbock_fail0:
 			free_irq(IRQ_USB, dev);
 			return -EBUSY;
 		}
-		retval = request_irq(LUBBOCK_USB_IRQ,
-				lubbock_vbus_irq,
-				SA_INTERRUPT | SA_SAMPLE_RANDOM,
-				driver_name, dev);
+		retval = request_irq(LUBBOCK_USB_IRQ, lubbock_vbus_irq,
+				     SA_INTERRUPT, driver_name, dev);
 		if (retval != 0) {
 			printk(KERN_ERR "%s: can't get irq %i, err %d\n",
 				driver_name, LUBBOCK_USB_IRQ, retval);
Index: 2.6/drivers/usb/gadget/omap_udc.c
===================================================================
--- 2.6.orig/drivers/usb/gadget/omap_udc.c	2006-05-02 17:28:45.000000000 -0500
+++ 2.6/drivers/usb/gadget/omap_udc.c	2006-05-03 13:11:57.000000000 -0500
@@ -2819,7 +2819,7 @@ bad_on_1710:
 
 	/* USB general purpose IRQ:  ep0, state changes, dma, etc */
 	status = request_irq(pdev->resource[1].start, omap_udc_irq,
-			SA_SAMPLE_RANDOM, driver_name, udc);
+			     0, driver_name, udc);
 	if (status != 0) {
 		ERR( "can't get irq %ld, err %d\n",
 			pdev->resource[1].start, status);
@@ -2828,7 +2828,7 @@ bad_on_1710:
 
 	/* USB "non-iso" IRQ (PIO for all but ep0) */
 	status = request_irq(pdev->resource[2].start, omap_udc_pio_irq,
-			SA_SAMPLE_RANDOM, "omap_udc pio", udc);
+			     0, "omap_udc pio", udc);
 	if (status != 0) {
 		ERR( "can't get irq %ld, err %d\n",
 			pdev->resource[2].start, status);
Index: 2.6/drivers/usb/gadget/goku_udc.c
===================================================================
--- 2.6.orig/drivers/usb/gadget/goku_udc.c	2006-05-02 17:28:45.000000000 -0500
+++ 2.6/drivers/usb/gadget/goku_udc.c	2006-05-03 12:08:20.000000000 -0500
@@ -1924,8 +1924,7 @@ static int goku_probe(struct pci_dev *pd
 	/* init to known state, then setup irqs */
 	udc_reset(dev);
 	udc_reinit (dev);
-	if (request_irq(pdev->irq, goku_irq, SA_SHIRQ/*|SA_SAMPLE_RANDOM*/,
-			driver_name, dev) != 0) {
+	if (request_irq(pdev->irq, goku_irq, SA_SHIRQ, driver_name, dev)) {
 		DBG(dev, "request interrupt %s failed\n", bufp);
 		retval = -EBUSY;
 		goto done;
@@ -1945,7 +1944,7 @@ static int goku_probe(struct pci_dev *pd
 
 	return 0;
 
-done:
+ done:
 	if (dev)
 		goku_remove (pdev);
 	return retval;
