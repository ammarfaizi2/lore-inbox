Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270570AbTGNM1E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270608AbTGNM05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:26:57 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40580
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270571AbTGNMIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:08:22 -0400
Date: Mon, 14 Jul 2003 13:22:22 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141222.h6ECMMoK030881@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: fix yenta hang on some laptops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/pcmcia/ti113x.h linux.22-pre5-ac1/drivers/pcmcia/ti113x.h
--- linux.22-pre5/drivers/pcmcia/ti113x.h	2003-07-14 12:27:38.000000000 +0100
+++ linux.22-pre5-ac1/drivers/pcmcia/ti113x.h	2003-07-08 23:31:27.000000000 +0100
@@ -171,21 +171,26 @@
 	/*
 	 * If ISA interrupts don't work, then fall back to routing card
 	 * interrupts to the PCI interrupt of the socket.
+	 *
+	 * Tweaking this when we are using serial PCI IRQs causes hangs
+	 *   --rmk
 	 */
 	if (!socket->cap.irq_mask) {
-		int irqmux, devctl;
-
-		printk (KERN_INFO "ti113x: Routing card interrupts to PCI\n");
+		u8 irqmux, devctl;
 
 		devctl = config_readb(socket, TI113X_DEVICE_CONTROL);
-		devctl &= ~TI113X_DCR_IMODE_MASK;
+		if (devctl & TI113X_DCR_IMODE_MASK != TI12XX_DCR_IMODE_ALL_SERIAL) {
+			printk (KERN_INFO "ti113x: Routing card interrupts to PCI\n");
+
+			devctl &= ~TI113X_DCR_IMODE_MASK;
 
-		irqmux = config_readl(socket, TI122X_IRQMUX);
-		irqmux = (irqmux & ~0x0f) | 0x02; /* route INTA */
-		irqmux = (irqmux & ~0xf0) | 0x20; /* route INTB */
+			irqmux = config_readl(socket, TI122X_IRQMUX);
+			irqmux = (irqmux & ~0x0f) | 0x02; /* route INTA */
+			irqmux = (irqmux & ~0xf0) | 0x20; /* route INTB */
 
-		config_writel(socket, TI122X_IRQMUX, irqmux);
-		config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
+			config_writel(socket, TI122X_IRQMUX, irqmux);
+			config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
+		}
 	}
 
 	return 0;
