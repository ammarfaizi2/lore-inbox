Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSGAXrt>; Mon, 1 Jul 2002 19:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316588AbSGAXrs>; Mon, 1 Jul 2002 19:47:48 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:4236 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S316582AbSGAXrr>; Mon, 1 Jul 2002 19:47:47 -0400
Date: Mon, 1 Jul 2002 19:50:14 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
cc: David Hinds <dhinds@sonic.net>
Subject: Cyrix IRQ routing is wrong?
Message-ID: <Pine.LNX.4.44.0207011814070.18831-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm using Linux 2.4.19-rc1 with pcmcia-cs 3.1.34 on EM-350A system
(http://www.voxtechnologies.com/Embedded_Platforms/em-350a.htm) with Cyrix
MediaGX.  CONFIG_PCMCIA is disabled, so the drivers come from pcmcia-cs.  
Every time the i82365 driver is loaded, the following message appears in
the kernel log:

Intel ISA/PCI/CardBus PCIC probe:
PCI: Found IRQ 11 for device 00:11.0
IRQ routing conflict for 00:11.0, have irq 15, want irq 11
PCI: Found IRQ 15 for device 00:11.1
IRQ routing conflict for 00:11.1, have irq 11, want irq 15

It happens regardless of whether I'm using CONFIG_PCI_GOBIOS or 
CONFIG_PCI_GODIRECT in the kernel config.

My understanding is that the first number comes from the PCI config space, 
whereas the second number comes from pirq_cyrix_get(), a Cyrix specific 
function that accesses the routing registers.  The later numbers are 
ignored if there is a conflict.

I have found that the following patch fixes this warning.  I don't know if 
it's correct.  The reason for the warning may be a hardware bug, but I'll 
post it anyway so that poeple with the documentation for Cyrix could 
recheck this code.

======================================
--- linux.orig/arch/i386/kernel/pci-irq.c
+++ linux/arch/i386/kernel/pci-irq.c
@@ -243,12 +243,12 @@ static int pirq_opti_set(struct pci_dev 
  */
 static int pirq_cyrix_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 {
-	return read_config_nybble(router, 0x5C, (pirq-1)^1);
+	return read_config_nybble(router, 0x5C, (pirq-1));
 }
 
 static int pirq_cyrix_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
-	write_config_nybble(router, 0x5C, (pirq-1)^1, irq);
+	write_config_nybble(router, 0x5C, (pirq-1), irq);
 	return 1;
 }
 
======================================

The existing code uses the upper nibble in the same byte for lower pirq,
but it seems that we should start with the lower nibble for EM-350A.

When using PCI interrupts in the i82365 driver (parameter irq_mode=0), all 
PCMCIA cards work properly and generate interrupts, with and without the 
above patch.

The fix in the latest beta of pcmcia-cs has no effect on 2.4.x kernels.  
It implements exactly the same logic, which is used in 2.4.x kernels 
(upper nibble first).

Possibly relevant part of initial kernel messages:

PCI: PCI BIOS revision 2.10 entry at 0xfad80, last bus=0
PCI: Probing PCI hardware
PCI: Using IRQ router NatSemi [1078/0100] at 00:12.0

lspci output:

00:00.0 Host bridge: Cyrix Corporation PCI Master
00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:11.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
00:11.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
00:12.0 ISA bridge: Cyrix Corporation 5530 Legacy [Kahlua] (rev 30)
00:12.1 Bridge: Cyrix Corporation 5530 SMI [Kahlua]
00:12.2 IDE interface: Cyrix Corporation 5530 IDE [Kahlua]
00:12.3 Multimedia audio controller: Cyrix Corporation 5530 Audio [Kahlua]
00:12.4 VGA compatible controller: Cyrix Corporation 5530 Video [Kahlua]

-- 
Regards,
Pavel Roskin

