Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbTIQSSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 14:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbTIQSSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 14:18:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:22978 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262608AbTIQSSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 14:18:35 -0400
Date: Wed, 17 Sep 2003 11:11:51 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: dwmw2@infradead.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] applicom LEAK #warning
Message-Id: <20030917111151.27ff73c9.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi David,

This is an attempt to fix the LEAK #warning in applicom.c.
The patch calls iounmap() for the composite memory area
after all of the individual areas are mapped.  Is that OK?

It also adds some unwinding of resources on failed cases
and doesn't save <irq> on request_irq() failure.

Question:  why are some error conditions in applicom_init()
handled by "return -EIO" and others handled by "continue"?

Comments?

Thanks,
--
~Randy


patch_name:	applicom_leak.patch
patch_version:	2003-09-17.11:06:35
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	fix ioremap() leak and #warning;
		unwind init on errors;
		don't save irq on request_irq() failure;
product:	Linux
product_versions: 2.6.0-test5
maintainer:	David Woodhouse (dwmw2@infradead.org)
diffstat:	=
 drivers/char/applicom.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)


diff -Naurp ./drivers/char/applicom.c~appleak ./drivers/char/applicom.c
--- ./drivers/char/applicom.c~appleak	2003-09-08 12:50:29.000000000 -0700
+++ ./drivers/char/applicom.c	2003-09-17 11:06:01.000000000 -0700
@@ -192,7 +192,7 @@ int __init applicom_init(void)
 {
 	int i, numisa = 0;
 	struct pci_dev *dev = NULL;
-	void *RamIO;
+	void *RamIO, *maxRamIO;
 	int boardno;
 
 	printk(KERN_INFO "Applicom driver: $Id: ac.c,v 1.30 2000/03/22 16:03:57 dwmw2 Exp $\n");
@@ -214,6 +214,7 @@ int __init applicom_init(void)
 
 		if (!RamIO) {
 			printk(KERN_INFO "ac.o: Failed to ioremap PCI memory space at 0x%lx\n", dev->resource[0].start);
+			pci_disable_device(dev);
 			return -EIO;
 		}
 
@@ -225,12 +226,14 @@ int __init applicom_init(void)
 						  (unsigned long)RamIO,0))) {
 			printk(KERN_INFO "ac.o: PCI Applicom device doesn't have correct signature.\n");
 			iounmap(RamIO);
+			pci_disable_device(dev);
 			continue;
 		}
 
 		if (request_irq(dev->irq, &ac_interrupt, SA_SHIRQ, "Applicom PCI", &dummy)) {
 			printk(KERN_INFO "Could not allocate IRQ %d for PCI Applicom device.\n", dev->irq);
 			iounmap(RamIO);
+			pci_disable_device(dev);
 			apbs[boardno - 1].RamIO = 0;
 			continue;
 		}
@@ -257,10 +260,9 @@ int __init applicom_init(void)
 
 	/* Now try the specified ISA cards */
 
-#warning "LEAK"
-	RamIO = ioremap(mem, LEN_RAM_IO * MAX_ISA_BOARD);
+	maxRamIO = ioremap(mem, LEN_RAM_IO * MAX_ISA_BOARD);
 
-	if (!RamIO) 
+	if (!maxRamIO) 
 		printk(KERN_INFO "ac.o: Failed to ioremap ISA memory space at 0x%lx\n", mem);
 
 	for (i = 0; i < MAX_ISA_BOARD; i++) {
@@ -285,7 +287,8 @@ int __init applicom_init(void)
 				iounmap((void *) RamIO);
 				apbs[boardno - 1].RamIO = 0;
 			}
-			apbs[boardno - 1].irq = irq;
+			else
+				apbs[boardno - 1].irq = irq;
 		}
 		else
 			apbs[boardno - 1].irq = 0;
@@ -296,6 +299,8 @@ int __init applicom_init(void)
 	if (!numisa)
 		printk(KERN_WARNING"ac.o: No valid ISA Applicom boards found at mem 0x%lx\n",mem);
 
+	iounmap(maxRamIO);
+
  fin:
 	init_waitqueue_head(&FlagSleepRec);
 
