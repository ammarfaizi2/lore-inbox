Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTHFOdh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTHFOdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:33:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26897 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263590AbTHFOdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:33:21 -0400
Date: Wed, 6 Aug 2003 15:33:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Misha Nasledov <misha@nasledov.com>
Subject: [PATCH] Fix Yenta ISA IRQs
Message-ID: <20030806153316.A13251@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Misha Nasledov <misha@nasledov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While looking at the Yenta IRQ problem, I discovered that some of
the merges from the -ac tree a while ago did something undesirable,
effectively disabling all ISA interrupts for Yenta sockets.

The following patch checks for the presence of ISA interrupts
_before_ deciding that we don't have any rather than deciding we
don't have any and then trying to probe for ISA interrupts.

Could people with Yenta interrupt problems:

(1) report the dmesg from bootup
(2) try with this patch applied with their standard configuration
(3) same as (2), but try disabling PNP support in their kernel,
    leaving i82365 enabled
(4) same as (2), but try leaving PNP support enabled, and disable
    i82365

diff -u ref/drivers/pcmcia/ti113x.h linux/drivers/pcmcia/ti113x.h
--- ref/drivers/pcmcia/ti113x.h	Fri Aug  1 14:05:11 2003
+++ linux/drivers/pcmcia/ti113x.h	Wed Aug  6 15:22:45 2003
@@ -258,31 +258,6 @@
 	if (new != reg)
 		exca_writeb(socket, I365_INTCTL, new);
 
-	/*
-	 * If ISA interrupts don't work, then fall back to routing card
-	 * interrupts to the PCI interrupt of the socket.
-	 *
-	 * Tweaking this when we are using serial PCI IRQs causes hangs
-	 *   --rmk
-	 */
-	if (!socket->socket.irq_mask) {
-		u8 irqmux, devctl;
-
-		devctl = config_readb(socket, TI113X_DEVICE_CONTROL);
-		if ((devctl & TI113X_DCR_IMODE_MASK) != TI12XX_DCR_IMODE_ALL_SERIAL) {
-			printk (KERN_INFO "ti113x: Routing card interrupts to PCI\n");
-
-			devctl &= ~TI113X_DCR_IMODE_MASK;
-
-			irqmux = config_readl(socket, TI122X_IRQMUX);
-			irqmux = (irqmux & ~0x0f) | 0x02; /* route INTA */
-			irqmux = (irqmux & ~0xf0) | 0x20; /* route INTB */
-
-			config_writel(socket, TI122X_IRQMUX, irqmux);
-			config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
-		}
-	}
-
 	socket->socket.ops->init = ti_init;
 	return 0;
 }
diff -u ref/drivers/pcmcia/yenta_socket.c linux/drivers/pcmcia/yenta_socket.c
--- ref/drivers/pcmcia/yenta_socket.c	Tue Aug  5 11:22:02 2003
+++ linux/drivers/pcmcia/yenta_socket.c	Wed Aug  6 15:22:42 2003
@@ -506,7 +506,34 @@
 	socket->socket.irq_mask = yenta_probe_irq(socket, isa_irq_mask);
 	socket->socket.cb_dev = socket->dev;
 
-	printk("Yenta IRQ list %04x, PCI irq%d\n", socket->socket.irq_mask, socket->cb_irq);
+	printk(KERN_INFO "Yenta: ISA IRQ list %04x, PCI irq%d\n",
+	       socket->socket.irq_mask, socket->cb_irq);
+
+	/*
+	 * If we didn't detect any ISA interrupts, fall back to routing
+	 * card interrupts to the PCI interrupt of the socket.
+	 *
+	 * Tweaking this when we are using serial PCI IRQs causes hangs
+	 *   --rmk
+	 */
+	if (socket->dev->vendor == PCI_VENDOR_ID_TI &&
+	    socket->socket.irq_mask == 0) {
+		u8 irqmux, devctl;
+
+		devctl = config_readb(socket, TI113X_DEVICE_CONTROL);
+		if ((devctl & TI113X_DCR_IMODE_MASK) != TI12XX_DCR_IMODE_ALL_SERIAL) {
+			printk (KERN_INFO "Yenta: Routing card interrupts to PCI\n");
+
+			devctl &= ~TI113X_DCR_IMODE_MASK;
+
+			irqmux = config_readl(socket, TI122X_IRQMUX);
+			irqmux = (irqmux & ~0x0f) | 0x02; /* route INTA */
+			irqmux = (irqmux & ~0xf0) | 0x20; /* route INTB */
+
+			config_writel(socket, TI122X_IRQMUX, irqmux);
+			config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
+		}
+	}
 }
 
 


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

