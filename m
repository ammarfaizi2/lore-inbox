Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317276AbSGCXkY>; Wed, 3 Jul 2002 19:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317277AbSGCXkX>; Wed, 3 Jul 2002 19:40:23 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:22496 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S317276AbSGCXkW>; Wed, 3 Jul 2002 19:40:22 -0400
Date: Wed, 3 Jul 2002 19:42:53 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org, Martin Mares <mj@ucw.cz>
Subject: [PATCH] Cyrix PCI IRQ routing fix
Message-ID: <Pine.LNX.4.44.0207031917190.3740-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Martin and everybody else!

A comment in Linux-2.5.24, file arch/i386/pci/irq.c says:

/* 
 * Cyrix: nibble offset 0x5C 
 * 0x5C bits 7:4 is INTB bits 3:0 is INTA  
 * 0x5D bits 7:4 is INTD bits 3:0 is INTC 
 */

Too bad that the functions pirq_cyrix_get() and pirq_cyrix_set() do it 
wrong.  Indeed, for INTA, pirq is 1, (pirq-1)^1 is 1, read_config_nybble() 
takes most significant bits in 0x5C, and so does write_config_nybble().
For INTB pirq is 2, (pirq-1)^1 is 0, so we get bits 3:0 from 0x5c.

This results in the following warnings that disappear when the code is
fixed to match the comment:

Intel ISA/PCI/CardBus PCIC probe:
PCI: Found IRQ 11 for device 00:11.0
IRQ routing conflict for 00:11.0, have irq 15, want irq 11
PCI: Found IRQ 15 for device 00:11.1
IRQ routing conflict for 00:11.1, have irq 11, want irq 15

Patch for 2.5.24:

================================
--- linux.orig/arch/i386/pci/irq.c
+++ linux/arch/i386/pci/irq.c
@@ -248,12 +248,12 @@ static int pirq_opti_set(struct pci_dev 
  */
 static int pirq_cyrix_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 {
-	return read_config_nybble(router, 0x5C, (pirq-1)^1);
+	return read_config_nybble(router, 0x5C, pirq-1);
 }
 
 static int pirq_cyrix_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
-	write_config_nybble(router, 0x5C, (pirq-1)^1, irq);
+	write_config_nybble(router, 0x5C, pirq-1, irq);
 	return 1;
 }
 
================================

Patch for 2.4.19-rc1:

================================
--- linux.orig/arch/i386/kernel/pci-irq.c
+++ linux/arch/i386/kernel/pci-irq.c
@@ -243,12 +243,12 @@ static int pirq_opti_set(struct pci_dev 
  */
 static int pirq_cyrix_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 {
-	return read_config_nybble(router, 0x5C, (pirq-1)^1);
+	return read_config_nybble(router, 0x5C, pirq-1);
 }
 
 static int pirq_cyrix_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
-	write_config_nybble(router, 0x5C, (pirq-1)^1, irq);
+	write_config_nybble(router, 0x5C, pirq-1, irq);
 	return 1;
 }
 
================================

The code was right in 2.4.17, but it was broken in 2.4.18.  This change is 
not mentioned in 
http://www.kernel.org/pub/linux/kernel/v2.4/ChangeLog-2.4.18
I'm assuming it was an accidental breakage, and it should be reverted.

-- 
Regards,
Pavel Roskin

