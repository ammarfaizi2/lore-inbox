Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286360AbRLTURc>; Thu, 20 Dec 2001 15:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286359AbRLTURW>; Thu, 20 Dec 2001 15:17:22 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:15887 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S286360AbRLTURG>; Thu, 20 Dec 2001 15:17:06 -0500
Date: Thu, 20 Dec 2001 15:16:55 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Making TI bridges work with kernel PCMCIA
Message-ID: <Pine.LNX.4.33.0112191617370.2705-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The driver for Cardbus/PCMCIA bridges (yenta_socket) doesn't initialize 
the irqmux register of TI bridges.  In fact, the driver doesn't even 
access that register.

My experience shows that relying in the initial values of that register is
not a good idea.  It is set to use ISA interrupts, but they don't work
with either of two motherboards I tested the bridge with.

Bridge:
CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)

Fisrt system:
Athlon 1GHz, motherboard AOpen KT-133.

Second system:
Compaq AP500, 2 x Pentium II, motherboard with Intel 440BX chipset.

This patch makes the same thing as "irq_mode=0" does in the standalone
PCMCIA driver (i82365).  It means that PCMCIA cards inserted to the socket
have their interrupt redirected to the same PCI interrupt that is used for
the Card Status Change (csc) notification.  I believe that's the safest
behavior, as it avoids probing ISA interupts.

Since the patch changes ti_open(), it affects all TI bridges.  This should 
be the right thing to do according to the pcmcia-cs sources.  I'm a bit 
surprized that the driver doesn't access those registers at all except 
some old TI113x models.

The code with TI122X_SCR_INTRTIE has been copied from pcmcia-cs without
changes.  It should only affect two-socket bridges.

The patch is against 2.4.17-rc2.

=========================
--- linux.orig/drivers/pcmcia/ti113x.h
+++ linux/drivers/pcmcia/ti113x.h
@@ -150,11 +150,27 @@
  */
 static int ti_open(pci_socket_t *socket)
 {
+	u32 irqmux;
+	u8 devctl, sysctl;
 	u8 new, reg = exca_readb(socket, I365_INTCTL);
 
 	new = reg & ~I365_INTR_ENA;
 	if (new != reg)
 		exca_writeb(socket, I365_INTCTL, new);
+
+	/* Disable ISA interrupt routing ... */
+	devctl = config_readb(socket, TI113X_DEVICE_CONTROL);
+	devctl &= ~TI113X_DCR_IMODE_MASK;
+	config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
+	/* ... and enable PCI routing instead */
+	sysctl = config_readb(socket, TI113X_SYSTEM_CONTROL);
+	irqmux = config_readl(socket, TI122X_IRQMUX);
+	irqmux = (irqmux & ~0x0f) | 0x02; /* route INTA */
+	if (!(sysctl & TI122X_SCR_INTRTIE)) {
+		irqmux = (irqmux & ~0xf0) | 0x20; /* route INTB */
+	}
+	config_writel(socket, TI122X_IRQMUX, irqmux);
+
 	return 0;
 }
 
=========================

-- 
Regards,
Pavel Roskin

