Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268494AbTCABUS>; Fri, 28 Feb 2003 20:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268495AbTCABUR>; Fri, 28 Feb 2003 20:20:17 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:26093 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S268494AbTCABUP>; Fri, 28 Feb 2003 20:20:15 -0500
Date: Fri, 28 Feb 2003 20:30:36 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: David Hinds <dahinds@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fallback to PCI IRQs for TI bridges
Message-ID: <Pine.LNX.4.50.0302281944470.6367-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, David and all!

David, I understand from the Linux MAINTAINERS file that you also maintain
the PCMCIA code in the kernel.  It's quite strange for me, because the
kernel code is quite different from what I used to see in pcmcia-cs.

Anyway, the kernel driver for TI bridges in the 2.4 series really needs to
be fixed.  It's becoming a FAQ in all mailing lists dealing with PCMCIA
devices - "what happens with interrupts?"

The bridges I'm using are configured to use ISA interrupts by default, but
it's PCI devices, which are not connected to the ISA bus in any way.
Here's the record from lspci:

00:0d.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)

pcmcia-cs takes the half-manual approach - the existing routing is used
unless the user overrides it by setting irq_mode.  This is not a good idea
- some bridges are misconfigured, and the user may not have a chance to
set module parameters, e.g. during the installation.

Kernel's yenta_socket in 2.4 series is too primitive to take care of the
problem.  The default routing is used.  ISA interrupts are probed.  If no
ISA interrupts are detected, the driver tries to use the PCI interrupt,
but the low-level commands to change routing are not issued.

yenta_socket in 2.5.63 knows different models of the bridges and sets IRQ
routing to PCI for certain models.  I don't really like this approach.
The chip can be integrated into the motherboard, and we don't know if the
ISA IRQ lines are connected or not.  The architecture may not support ISA
bus (e.g. PowerPC), then there will be no ISA interrupts, no matter what
chip is used.

I believe using PCI interrupts should not be considered as an inferior
approach compared to ISA interrupts.  The only driver I know that had
problems with PCI interrupts was ide-cs, but it's now fixed in the Alan's
tree, and hopefully in 2.4.21-pre5 (I didn't have a chance to test it).

Anyway, for the sake of backward compatibility, let's consider using PCI
interrupts a fallback that we use only if ISA interrupts don't work.

I have made a patch against 2.4.21-pre4-ac7 (it should work with all 2.4.x
kernels) that enables routing to PCI interrupts on TI bridges if no ISA
interrupts were detected.  I want to post it to the Linux list, although
I'm almost sure that it won't be applied.  At least it could start a
useful discussion, and maybe some Linux distributors will pick it.
Similar patch is needed for Ricoh bridges, but let's start with TI.

In my opinion, the problem with IRQ routing on PCI-to-PCMCIA bridges is a
major problem that needs to be addressed in 2.4 series.  Linux
distributors who chose to use kernel PCMCIA (e.g. Red Hat) should be
interested in working PCMCIA support.  I cannot count how many times I
asked Red Hat users to recompile the kernel without PCMCIA support when
they wrote me about IRQ problems.

Here's the patch for 2.4.x kernels:

======================================
--- linux.orig/drivers/pcmcia/ti113x.h
+++ linux/drivers/pcmcia/ti113x.h
@@ -167,6 +167,27 @@
 		new |= I365_INTR_ENA;
 	if (new != reg)
 		exca_writeb(socket, I365_INTCTL, new);
+
+	/*
+	 * If ISA interrupts don't work, then fall back to routing card
+	 * interrupts to the PCI interrupt of the socket.
+	 */
+	if (!socket->cap.irq_mask) {
+		int irqmux, devctl;
+
+		printk (KERN_INFO "ti113x: Routing card interrupts to PCI\n");
+
+		devctl = config_readb(socket, TI113X_DEVICE_CONTROL);
+		devctl &= ~TI113X_DCR_IMODE_MASK;
+
+		irqmux = config_readl(socket, TI122X_IRQMUX);
+		irqmux = (irqmux & ~0x0f) | 0x02; /* route INTA */
+		irqmux = (irqmux & ~0xf0) | 0x20; /* route INTB */
+
+		config_writel(socket, TI122X_IRQMUX, irqmux);
+		config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
+	}
+
 	return 0;
 }

======================================

-- 
Regards,
Pavel Roskin
