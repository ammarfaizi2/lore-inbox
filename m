Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTHFOyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTHFOyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:54:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58129 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263738AbTHFOyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:54:37 -0400
Date: Wed, 6 Aug 2003 15:54:33 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Misha Nasledov <misha@nasledov.com>
Subject: Re: [PATCH] Fix Yenta ISA IRQs
Message-ID: <20030806155433.A14117@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Misha Nasledov <misha@nasledov.com>
References: <20030806153316.A13251@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030806153316.A13251@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Aug 06, 2003 at 03:33:16PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 03:33:16PM +0100, Russell King wrote:
> Hi,
> 
> While looking at the Yenta IRQ problem, I discovered that some of
> the merges from the -ac tree a while ago did something undesirable,
> effectively disabling all ISA interrupts for Yenta sockets.
> 
> The following patch checks for the presence of ISA interrupts
> _before_ deciding that we don't have any rather than deciding we
> don't have any and then trying to probe for ISA interrupts.
> 
> Could people with Yenta interrupt problems:
> 
> (1) report the dmesg from bootup
> (2) try with this patch applied with their standard configuration
> (3) same as (2), but try disabling PNP support in their kernel,
>     leaving i82365 enabled
> (4) same as (2), but try leaving PNP support enabled, and disable
>     i82365

Ok, ok, I messed up that (untested) patch.  This one is more tested
though, now that my previous x86 kernel build completed...

It's still not perfect - I'm now seeing:

	PCI: Found IRQ 11 for device 0000:00:02.0
	PCI: Sharing IRQ 11 with 0000:00:03.0
	Yenta: ISA IRQ list 00b8, PCI irq11
	Socket status: 30000006
	PCI: Found IRQ 11 for device 0000:00:02.1
	Yenta: ISA IRQ list 00b0, PCI irq11
	Socket status: 30000020
	Intel PCIC probe: PNP invalid resources ?
	pnp: Device 00:14 disabled.
	not found.

from my PCI1450 device in my laptop (note the differing ISA IRQ list
between the sockets - 2.4 reports 00b8 for both.)

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
+++ linux/drivers/pcmcia/yenta_socket.c	Wed Aug  6 15:36:55 2003
@@ -443,73 +443,6 @@
 	add_timer(&socket->poll_timer);
 }
 
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
-
-/*
- * Set static data that doesn't need re-initializing..
- */
-static void yenta_get_socket_capabilities(struct yenta_socket *socket, u32 isa_irq_mask)
-{
-	socket->socket.features |= SS_CAP_PAGE_REGS | SS_CAP_PCCARD | SS_CAP_CARDBUS;
-	socket->socket.map_size = 0x1000;
-	socket->socket.pci_irq = socket->cb_irq;
-	socket->socket.irq_mask = yenta_probe_irq(socket, isa_irq_mask);
-	socket->socket.cb_dev = socket->dev;
-
-	printk("Yenta IRQ list %04x, PCI irq%d\n", socket->socket.irq_mask, socket->cb_irq);
-}
-
-
 static void yenta_clear_maps(struct yenta_socket *socket)
 {
 	int i;
@@ -815,6 +748,100 @@
 
 
 /*
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
+/*
+ * Set static data that doesn't need re-initializing..
+ */
+static void yenta_get_socket_capabilities(struct yenta_socket *socket, u32 isa_irq_mask)
+{
+	socket->socket.features |= SS_CAP_PAGE_REGS | SS_CAP_PCCARD | SS_CAP_CARDBUS;
+	socket->socket.map_size = 0x1000;
+	socket->socket.pci_irq = socket->cb_irq;
+	socket->socket.irq_mask = yenta_probe_irq(socket, isa_irq_mask);
+	socket->socket.cb_dev = socket->dev;
+
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
+}
+
+
+/*
  * Initialize a cardbus controller. Make sure we have a usable
  * interrupt, and that we can map the cardbus area. Fill in the
  * socket information structure..


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

