Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTJJDFe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 23:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTJJDFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 23:05:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:19098 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262094AbTJJDFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 23:05:23 -0400
Date: Thu, 9 Oct 2003 20:04:19 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: dwmw2@infradead.org
Subject: Re: [PATCH] applicom: fix LEAK, unwind on errors;
Message-Id: <20031009200419.17024c32.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> -#warning "LEAK"
> -     RamIO = ioremap(mem, LEN_RAM_IO * MAX_ISA_BOARD);
> +     maxRamIO = ioremap(mem, LEN_RAM_IO * MAX_ISA_BOARD);
>
> -     if (!RamIO)
> +     if (!maxRamIO)
>               printk(KERN_INFO "ac.o: Failed to ioremap ISA memory space at 0x%lx\n", mem);

to which Andrew Morton replied:
It seems that this driver is just testing to see if it can ioremap the
whole region before going through and mapping each board.

If we want to keep this sanity check then the iounmap should come
immediately after the ioremap, or it should just be removed.

Probably the latter: if the individual ioremaps work then they've worked,
haven't they?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sure, that's fine by me.  David, OK with you?
Here's the updated patch.

--
~Randy


patch_name:	applicom_leak2.patch
patch_version:	2003-10-09.19:54:49
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	remove ioremap() warning and leak;
		unwind on errors in init;
		don't save irq on request_irq() failure;
product:	Linux
product_versions: 2.6.0-test7
maintainer:	David Woodhouse (dwmw2@infradead.org)
diffstat:	=
 drivers/char/applicom.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)


diff -Naur ./drivers/char/applicom.c~appleak ./drivers/char/applicom.c
--- ./drivers/char/applicom.c~appleak	2003-10-08 12:24:50.000000000 -0700
+++ ./drivers/char/applicom.c	2003-10-09 19:52:47.000000000 -0700
@@ -214,6 +214,7 @@
 
 		if (!RamIO) {
 			printk(KERN_INFO "ac.o: Failed to ioremap PCI memory space at 0x%lx\n", dev->resource[0].start);
+			pci_disable_device(dev);
 			return -EIO;
 		}
 
@@ -225,12 +226,14 @@
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
@@ -257,12 +260,6 @@
 
 	/* Now try the specified ISA cards */
 
-#warning "LEAK"
-	RamIO = ioremap(mem, LEN_RAM_IO * MAX_ISA_BOARD);
-
-	if (!RamIO) 
-		printk(KERN_INFO "ac.o: Failed to ioremap ISA memory space at 0x%lx\n", mem);
-
 	for (i = 0; i < MAX_ISA_BOARD; i++) {
 		RamIO = ioremap(mem + (LEN_RAM_IO * i), LEN_RAM_IO);
 
@@ -285,7 +282,8 @@
 				iounmap((void *) RamIO);
 				apbs[boardno - 1].RamIO = 0;
 			}
-			apbs[boardno - 1].irq = irq;
+			else
+				apbs[boardno - 1].irq = irq;
 		}
 		else
 			apbs[boardno - 1].irq = 0;
