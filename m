Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbRAaKUL>; Wed, 31 Jan 2001 05:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129911AbRAaKTv>; Wed, 31 Jan 2001 05:19:51 -0500
Received: from [195.71.115.196] ([195.71.115.196]:24875 "HELO
	demdwug7.mediaways.net") by vger.kernel.org with SMTP
	id <S129692AbRAaKTs>; Wed, 31 Jan 2001 05:19:48 -0500
Date: Wed, 31 Jan 2001 11:21:09 +0100 (CET)
From: Martin Diehl <mdiehlcs@compuserve.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: becker@scyld.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] minor ne2k-pci irq fix
In-Reply-To: <Pine.LNX.4.10.10101291348330.9791-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101310346240.2065-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

while testing the SiS routing code, at some point my ne2k-pci didn't work
anymore. Was when BIOS was set for PnP OS and IRQ set to "auto" for the
NIC. Had to rmmod/insmod the ne2k-pci module after reboot to make it
working again.

Reason: we fetched the irq too early, before calling pci_enable_device(),
so it was bogus after initial routing.
Patch below (prepared for 2.4.0 - should be fine for 2.4.1 too).

Regards
Martin

-----

--- linux-2.4.0/drivers/net/ne2k-pci.c.orig	Tue Jan 30 23:21:48 2001
+++ linux-2.4.0/drivers/net/ne2k-pci.c	Tue Jan 30 23:22:35 2001
@@ -203,7 +203,6 @@
 		printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);
 
 	ioaddr = pci_resource_start (pdev, 0);
-	irq = pdev->irq;
 
 	if (!ioaddr || ((pci_resource_flags (pdev, 0) & IORESOURCE_IO) == 0)) {
 		printk (KERN_ERR "ne2k-pci: no I/O resource at PCI BAR #0\n");
@@ -213,6 +212,7 @@
 	i = pci_enable_device (pdev);
 	if (i)
 		return i;
+	irq = pdev->irq;
 
 	if (request_region (ioaddr, NE_IO_EXTENT, "ne2k-pci") == NULL) {
 		printk (KERN_ERR "ne2k-pci: I/O resource 0x%x @ 0x%lx busy\n",


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
