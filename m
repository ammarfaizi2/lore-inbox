Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTJCXeQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbTJCXeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:34:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:21929 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261464AbTJCXd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:33:58 -0400
Date: Fri, 3 Oct 2003 16:25:32 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: cherry <cherry@osdl.org>, akpm <akpm@osdl.org>
Subject: [PATCH] applicom: fix LEAK, unwind on errors;
Message-Id: <20031003162532.62130e39.rddunlap@osdl.org>
In-Reply-To: <200310032246.h93Mker6018458@cherrypit.pdx.osdl.net>
References: <200310032246.h93Mker6018458@cherrypit.pdx.osdl.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Oct 2003 15:46:40 -0700 John Cherry <cherry@osdl.org> wrote:

| drivers/char/applicom.c:260:2: warning: #warning "LEAK"
| drivers/char/applicom.c:524:2: warning: #warning "Je suis stupide. DW. - copy*user in cli"
| drivers/char/applicom.c:67: warning: `applicom_pci_tbl' defined but not used


Here's a patch for applicom.c.
David Woodhouse has reviewed and okayed it, although he no
longer has hardware to test it.

Any other reviews/comments on it?
If not, I'll ask Andrew to merge it.

--
~Randy


patch_name:	applicom_leak.patch
patch_version:	2003-09-17.11:06:35
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	fix ioremap() leak and #warning;
		unwind init on errors;
		don't save irq on request_irq() failure;
product:	Linux
product_versions: 2.6.0-test5 (and -test6)
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
 
