Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbUBWXf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbUBWXf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 18:35:26 -0500
Received: from 217-162-59-239.dclient.hispeed.ch ([217.162.59.239]:16900 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S262093AbUBWXex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 18:34:53 -0500
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>
Subject: [PATCH] yenta: irq-routing for TI bridges
Date: Tue, 24 Feb 2004 00:33:31 +0100
User-Agent: KMail/1.5.2
Cc: Russell King <rmk+pcmcia@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Guylhem Aznar <pcmcia@externe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402240033.31042.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

this patch should fix up wrongly initialized TI bridges. in a safe way (hopefully).

people with a TI bridge please test.
andrew, any chance for this in -mm?
thanx to Guylhem Aznar for testing it.

rgds
-daniel


---patch---

another TI irq routing patch. this one is not blidly guessing what's right.
it changes the routing depending on the device control registers. and it only
changes the device control register when interrupts are not working at all.
this has the following advantages over the old (and disabled in 2.6, but not in 2.4)
routing code:
- it shouldn't change working setups
- it's in the right place (the old code is wrong: checks irq_mask before it is set)
- it doens't disable working parallel ISA interrupts
- irqmux is 32bit, the old code operates on a 8bit variable, chaning the routing on
  5 of 7 MFUNCs.
- the routing of INTB depends on the chip and the INTRTIE flag in the device control
  register (may be unsafe, don't know)

against 2.6.3-bk


--- 1.18/drivers/pcmcia/ti113x.h	Wed Aug 27 21:58:54 2003
+++ edited/drivers/pcmcia/ti113x.h	Fri Feb 20 21:26:49 2004
@@ -273,6 +273,8 @@
 
 static int ti_override(struct yenta_socket *socket)
 {
+	u32 irqmux, irqmux_old, devctl;
+	unsigned probe_mask;
 	u8 new, reg = exca_readb(socket, I365_INTCTL);
 
 	new = reg & ~I365_INTR_ENA;
@@ -281,33 +283,73 @@
 
 	ti_set_zv(socket);
 
-#if 0
 	/*
-	 * If ISA interrupts don't work, then fall back to routing card
-	 * interrupts to the PCI interrupt of the socket.
-	 *
-	 * Tweaking this when we are using serial PCI IRQs causes hangs
-	 *   --rmk
+	 * a more reliable way of changing the IRQMUX. don't blindly guess
+	 * what's right, look up the device control register, change the
+	 * routing depending on that data. only fall back to PCI interrupts
+	 * when it's not working at all. there should be no change to the
+	 * IRQMUX when it's programmed right.
 	 */
-	if (!socket->socket.irq_mask) {
-		u8 irqmux, devctl;
 
-		devctl = config_readb(socket, TI113X_DEVICE_CONTROL);
-		if ((devctl & TI113X_DCR_IMODE_MASK) != TI12XX_DCR_IMODE_ALL_SERIAL) {
-			printk (KERN_INFO "ti113x: Routing card interrupts to PCI\n");
-
-			devctl &= ~TI113X_DCR_IMODE_MASK;
-
-			irqmux = config_readl(socket, TI122X_IRQMUX);
-			irqmux = (irqmux & ~0x0f) | 0x02; /* route INTA */
-			irqmux = (irqmux & ~0xf0) | 0x20; /* route INTB */
+	/* check IRQ routing to see if 16bit cards would work */
+	irqmux = irqmux_old = config_readl(socket, TI122X_IRQMUX);
+	devctl = config_readb(socket, TI113X_DEVICE_CONTROL);
+	printk(KERN_INFO "Yenta TI: irqmux %08x, devctl %02x\n", irqmux, devctl);
+
+#if 1
+	/* serialized interrupts: MFUNC3 must be IRQSER */
+	if (devctl & TI113X_DCR_IMODE_SERIAL)
+		irqmux = (irqmux & ~0xf000) | 0x1000;
+#endif
 
+#if 1
+	/* if we have all serial: probe, fall back to parallel PCI */
+	if ((devctl & TI113X_DCR_IMODE_MASK) == TI12XX_DCR_IMODE_ALL_SERIAL) {
+		/* write down if changed, probe */
+		if (irqmux_old != irqmux) {
+			printk(KERN_INFO "Yenta TI: changing to %08x", irqmux);
 			config_writel(socket, TI122X_IRQMUX, irqmux);
+		}
+	
+		probe_mask = yenta_probe_irq(socket, isa_interrupts);
+		if (!probe_mask) {
+			/* no chance to have all serial working -> PCI */
+			printk(KERN_INFO "Yenta TI: serial interrupts not working -> PCI\n");
+			devctl &= ~TI113X_DCR_IMODE_MASK;
 			config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
 		}
 	}
 #endif
 
+	/* parallel PCI interrupts: MFUNC0 must be INTA */
+	if ((devctl & TI113X_DCR_IMODE_MASK) != TI12XX_DCR_IMODE_ALL_SERIAL) {
+		u32 sysctl;
+		irqmux = (irqmux & ~0x0f) | 0x02;
+
+		/* route INTB depending on INTRTIE */
+		switch (socket->dev->device) {
+			/* there are more... */
+			case PCI_DEVICE_ID_TI_1220:
+			case PCI_DEVICE_ID_TI_1221:
+			case PCI_DEVICE_ID_TI_1225:
+			case PCI_DEVICE_ID_TI_1420:
+			case PCI_DEVICE_ID_TI_1450:
+			//case PCI_DEVICE_ID_TI_1451:
+			case PCI_DEVICE_ID_TI_1520:
+				sysctl = config_readl(socket, TI113X_SYSTEM_CONTROL);
+				if (!(sysctl & TI122X_SCR_INTRTIE))
+					irqmux = (irqmux & ~0xf0) | 0x20;
+
+			default:
+				break;
+		}
+	}
+
+	if (irqmux_old != irqmux) {
+		printk(KERN_INFO "Yenta TI: changing to %08x", irqmux);
+		config_writel(socket, TI122X_IRQMUX, irqmux);
+	}
+
 	return 0;
 }
 
@@ -365,26 +407,6 @@
 			old, diag);
 		config_writeb(socket, TI1250_DIAGNOSTIC, diag);
 	}
-
-#if 0
-	/*
-	 * This is highly machine specific, and we should NOT touch
-	 * this register - we have no knowledge how the hardware
-	 * is actually wired.
-	 *
-	 * If we're going to do this, we should probably look into
-	 * using the subsystem IDs.
-	 *
-	 * On ThinkPad 380XD, this changes MFUNC0 from the ISA IRQ3
-	 * output (which it is) to IRQ2.  We also change MFUNC1
-	 * from ISA IRQ4 to IRQ6.
-	 */
-	irqmux = config_readl(socket, TI122X_IRQMUX);
-	irqmux = (irqmux & ~0x0f) | 0x02; /* route INTA */
-	if (!(ti_sysctl(socket) & TI122X_SCR_INTRTIE))
-		irqmux = (irqmux & ~0xf0) | 0x20; /* route INTB */
-	config_writel(socket, TI122X_IRQMUX, irqmux);
-#endif
 
 	return ti12xx_override(socket);
 }
===== drivers/pcmcia/yenta_socket.c 1.51 vs edited =====
--- 1.51/drivers/pcmcia/yenta_socket.c	Wed Dec 31 01:35:29 2003
+++ edited/drivers/pcmcia/yenta_socket.c	Mon Feb 16 18:23:50 2004
@@ -648,6 +648,8 @@
 
 	pci_release_regions(dev);
 	pci_set_drvdata(dev, NULL);
+
+	kfree(sock);
 }
 
 
@@ -662,6 +664,59 @@
 };
 
 
+/*
+ * Only probe "regular" interrupts, don't
+ * touch dangerous spots like the mouse irq,
+ * because there are mice that apparently
+ * get really confused if they get fondled
+ * too intimately.
+ *
+ * Default to 11, 10, 9, 7, 6, 5, 4, 3.
+ */
+static u32 isa_interrupts = 0x0ef8;
+
+static unsigned int yenta_probe_irq(struct yenta_socket *socket, u32 isa_irq_mask)
+{
+	int i;
+	unsigned long val;
+	u16 bridge_ctrl;
+	u32 mask;
+
+	/* Set up ISA irq routing to probe the ISA irqs.. */
+	bridge_ctrl = config_readw(socket, CB_BRIDGE_CONTROL);
+	if (!(bridge_ctrl & CB_BRIDGE_INTR)) {
+		bridge_ctrl |= CB_BRIDGE_INTR;
+		config_writew(socket, CB_BRIDGE_CONTROL, bridge_ctrl);
+	}
+
+	/*
+	 * Probe for usable interrupts using the force
+	 * register to generate bogus card status events.
+	 */
+	cb_writel(socket, CB_SOCKET_EVENT, -1);
+	cb_writel(socket, CB_SOCKET_MASK, CB_CSTSMASK);
+	exca_writeb(socket, I365_CSCINT, 0);
+	val = probe_irq_on() & isa_irq_mask;
+	for (i = 1; i < 16; i++) {
+		if (!((val >> i) & 1))
+			continue;
+		exca_writeb(socket, I365_CSCINT, I365_CSC_STSCHG | (i << 4));
+		cb_writel(socket, CB_SOCKET_FORCE, CB_FCARDSTS);
+		udelay(100);
+		cb_writel(socket, CB_SOCKET_EVENT, -1);
+	}
+	cb_writel(socket, CB_SOCKET_MASK, 0);
+	exca_writeb(socket, I365_CSCINT, 0);
+
+	mask = probe_irq_mask(val) & 0xffff;
+
+	bridge_ctrl &= ~CB_BRIDGE_INTR;
+	config_writew(socket, CB_BRIDGE_CONTROL, bridge_ctrl);
+
+	return mask;
+}
+
+
 #include "ti113x.h"
 #include "ricoh.h"
 #include "topic.h"
@@ -715,58 +770,6 @@
 	},
 };
 
-
-/*
- * Only probe "regular" interrupts, don't
- * touch dangerous spots like the mouse irq,
- * because there are mice that apparently
- * get really confused if they get fondled
- * too intimately.
- *
- * Default to 11, 10, 9, 7, 6, 5, 4, 3.
- */
-static u32 isa_interrupts = 0x0ef8;
-
-static unsigned int yenta_probe_irq(struct yenta_socket *socket, u32 isa_irq_mask)
-{
-	int i;
-	unsigned long val;
-	u16 bridge_ctrl;
-	u32 mask;
-
-	/* Set up ISA irq routing to probe the ISA irqs.. */
-	bridge_ctrl = config_readw(socket, CB_BRIDGE_CONTROL);
-	if (!(bridge_ctrl & CB_BRIDGE_INTR)) {
-		bridge_ctrl |= CB_BRIDGE_INTR;
-		config_writew(socket, CB_BRIDGE_CONTROL, bridge_ctrl);
-	}
-
-	/*
-	 * Probe for usable interrupts using the force
-	 * register to generate bogus card status events.
-	 */
-	cb_writel(socket, CB_SOCKET_EVENT, -1);
-	cb_writel(socket, CB_SOCKET_MASK, CB_CSTSMASK);
-	exca_writeb(socket, I365_CSCINT, 0);
-	val = probe_irq_on() & isa_irq_mask;
-	for (i = 1; i < 16; i++) {
-		if (!((val >> i) & 1))
-			continue;
-		exca_writeb(socket, I365_CSCINT, I365_CSC_STSCHG | (i << 4));
-		cb_writel(socket, CB_SOCKET_FORCE, CB_FCARDSTS);
-		udelay(100);
-		cb_writel(socket, CB_SOCKET_EVENT, -1);
-	}
-	cb_writel(socket, CB_SOCKET_MASK, 0);
-	exca_writeb(socket, I365_CSCINT, 0);
-
-	mask = probe_irq_mask(val) & 0xffff;
-
-	bridge_ctrl &= ~CB_BRIDGE_INTR;
-	config_writew(socket, CB_BRIDGE_CONTROL, bridge_ctrl);
-
-	return mask;
-}
 
 /*
  * Set static data that doesn't need re-initializing..




