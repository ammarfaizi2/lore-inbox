Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbUBXX0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbUBXX0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:26:46 -0500
Received: from 217-162-59-239.dclient.hispeed.ch ([217.162.59.239]:19460 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S262525AbUBXX0Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:26:25 -0500
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Russell King <rmk+lkml@arm.linux.org.uk>, Pavel Roskin <proski@gnu.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] yenta: irq-routing for TI bridges - take 2
Date: Wed, 25 Feb 2004 00:26:20 +0100
User-Agent: KMail/1.5.2
References: <200402240033.31042.daniel.ritz@gmx.ch> <20040224124011.A30975@flint.arm.linux.org.uk> <200402241623.11569.daniel.ritz@alcatel.ch>
In-Reply-To: <200402241623.11569.daniel.ritz@alcatel.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402250026.20708.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

the last patch was bad...chaning stuff it shouldn't on TI125x, 145x...

another try...comments?
couldn't find datasheets for 1210, 1220, 1250 so i'm not quite sure about them....
compile tested (my TI works, so no difference there)

against 2.6.3-bk

rgds
-daniel


--- 1.139/include/linux/pci_ids.h	Fri Feb 20 17:57:29 2004
+++ edited/include/linux/pci_ids.h	Tue Feb 24 22:24:10 2004
@@ -704,6 +704,7 @@
 #define PCI_VENDOR_ID_TI		0x104c
 #define PCI_DEVICE_ID_TI_TVP4010	0x3d04
 #define PCI_DEVICE_ID_TI_TVP4020	0x3d07
+#define PCI_DEVICE_ID_TI_4450		0x8011
 #define PCI_DEVICE_ID_TI_1130		0xac12
 #define PCI_DEVICE_ID_TI_1031		0xac13
 #define PCI_DEVICE_ID_TI_1131		0xac15
@@ -720,6 +721,7 @@
 #define PCI_DEVICE_ID_TI_4451		0xac42
 #define PCI_DEVICE_ID_TI_1410		0xac50
 #define PCI_DEVICE_ID_TI_1420		0xac51
+#define PCI_DEVICE_ID_TI_1451A		0xac52
 #define PCI_DEVICE_ID_TI_1520		0xac55
 #define PCI_DEVICE_ID_TI_1510		0xac56
 
--- 1.51/drivers/pcmcia/yenta_socket.c	Wed Dec 31 01:35:29 2003
+++ edited/drivers/pcmcia/yenta_socket.c	Tue Feb 24 23:01:26 2004
@@ -662,6 +662,59 @@
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
@@ -717,58 +770,6 @@
 
 
 /*
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
-
-/*
  * Set static data that doesn't need re-initializing..
  */
 static void yenta_get_socket_capabilities(struct yenta_socket *socket, u32 isa_irq_mask)
@@ -997,7 +998,6 @@
 	 * data sheets for these devices. --rmk)
 	 */
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1210, TI),
-	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1251B, TI),
 
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1130, TI113X),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1131, TI113X),
@@ -1007,11 +1007,13 @@
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1221, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1225, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1251A, TI12XX),
+	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1251B, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1420, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1450, TI12XX),
+	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1451A, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1520, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4410, TI12XX),
-//	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4450, TI12XX),
+	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4450, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4451, TI12XX),
 
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1250, TI1250),
--- 1.18/drivers/pcmcia/ti113x.h	Wed Aug 27 21:58:54 2003
+++ edited/drivers/pcmcia/ti113x.h	Wed Feb 25 00:21:23 2004
@@ -252,7 +252,7 @@
  * INTCTL register that sets the PCI CSC interrupt.
  * Make sure we set it correctly at open and init
  * time
- * - open: disable the PCI CSC interrupt. This makes
+ * - override: disable the PCI CSC interrupt. This makes
  *   it possible to use the CSC interrupt to probe the
  *   ISA interrupts.
  * - init: set the interrupt to match our PCI state.
@@ -281,33 +281,6 @@
 
 	ti_set_zv(socket);
 
-#if 0
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
-#endif
-
 	return 0;
 }
 
@@ -327,7 +300,9 @@
 
 static int ti12xx_override(struct yenta_socket *socket)
 {
-	u32 val;
+	u32 val, mfunc, mfunc_old, devctl;
+	unsigned probe_mask;
+	int ret;
 
 	/* make sure that memory burst is active */
 	val = config_readl(socket, TI113X_SYSTEM_CONTROL);
@@ -347,7 +322,105 @@
 	printk(KERN_INFO "Yenta: Routing CardBus interrupts to %s\n",
 		(val & TI1250_DIAG_PCI_IREQ) ? "PCI" : "ISA");
 
-	return ti_override(socket);
+
+	/* need to call ti_override() before testing interrupts */
+	ret = ti_override(socket);
+	if (ret)
+		goto out;
+
+	/* probe interrupts before any 'fixup' */
+	probe_mask = yenta_probe_irq(socket, isa_interrupts);
+	if (probe_mask)
+		goto out;
+
+
+	/*
+	 * we're here which means interrupts are not delivered. try to fix it:
+	 * first look at device control register, change MFUNCs to match that.
+	 * fall back to PCI interrupts if interrupt test still fails
+	 *
+	 * the 125x/145x are special: they have an extra pin (non-MFUNC) for
+	 * INTA. don't mess around with MFUNC0
+	 * also some chips don't have an IRQSER setting in MFUNC3
+	 */
+
+	mfunc = mfunc_old = config_readl(socket, TI122X_IRQMUX);
+	devctl = config_readb(socket, TI113X_DEVICE_CONTROL);
+	printk(KERN_INFO "Yenta TI: mfunc %08x, devctl %02x\n", mfunc, devctl);
+
+	/* serialized interrupts: MFUNC3 should be IRQSER */
+	if (devctl & TI113X_DCR_IMODE_SERIAL) {
+		switch (socket->dev->device) {
+			/* FIXME 1220, 1210?? no datasheets... */
+			case PCI_DEVICE_ID_TI_1250:
+			case PCI_DEVICE_ID_TI_1251A:
+			case PCI_DEVICE_ID_TI_1251B:
+			case PCI_DEVICE_ID_TI_4450:
+			case PCI_DEVICE_ID_TI_4451:
+				/* these chips have no IRQSER setting in MFUNC3  */
+				break;
+
+			default:
+				mfunc = (mfunc & ~0xf000) | 0x1000;
+
+				/* write down if changed, probe */
+				if (mfunc != mfunc_old) {
+					printk(KERN_INFO "Yenta TI: changing mfunc to %08x\n", mfunc);
+					config_writel(socket, TI122X_IRQMUX, mfunc);
+
+					probe_mask = yenta_probe_irq(socket, isa_interrupts);
+					if (probe_mask)
+						goto out;
+				}
+		}
+	}
+
+	/* all-serial and not working: fall back to PCI */
+	if ((devctl & TI113X_DCR_IMODE_MASK) == TI12XX_DCR_IMODE_ALL_SERIAL) {
+		printk(KERN_INFO "Yenta TI: falling back to PCI interrupts\n");
+		devctl &= ~TI113X_DCR_IMODE_MASK;
+		config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
+	}
+
+	/* parallel PCI interrupts: MFUNC0 -> INTA. not for 125x/145x */
+	switch (socket->dev->device) {
+		case PCI_DEVICE_ID_TI_1250:
+		case PCI_DEVICE_ID_TI_1251A:
+		case PCI_DEVICE_ID_TI_1251B:
+		case PCI_DEVICE_ID_TI_1450:
+			/* nada */
+			break;
+
+		default:
+			mfunc = (mfunc & ~0x0f) | 0x02;
+			if (mfunc != mfunc_old) {
+				printk(KERN_INFO "Yenta TI: changing mfunc to %08x\n", mfunc);
+				config_writel(socket, TI122X_IRQMUX, mfunc);
+			}
+	}
+
+#if 0
+	/* dual slot chips: routing of INTB / INTRTIE */
+	switch (socket->dev->device) {
+		case PCI_DEVICE_ID_TI_1220:
+		case PCI_DEVICE_ID_TI_1221:
+		case PCI_DEVICE_ID_TI_1225:
+		case PCI_DEVICE_ID_TI_1420:
+		case PCI_DEVICE_ID_TI_1450:
+		case PCI_DEVICE_ID_TI_1451:
+		case PCI_DEVICE_ID_TI_1520:
+			sysctl = config_readl(socket, TI113X_SYSTEM_CONTROL);
+			if (!(sysctl & TI122X_SCR_INTRTIE))
+				mfunc = (mfunc & ~0xf0) | 0x20;
+
+			/* we could also do the opposite and just set INTRTIE */
+		default:
+			break;
+	}
+#endif
+
+out:
+	return ret;
 }
 
 
@@ -365,26 +438,6 @@
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



