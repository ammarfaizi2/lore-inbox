Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135317AbRALVLA>; Fri, 12 Jan 2001 16:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135285AbRALVKu>; Fri, 12 Jan 2001 16:10:50 -0500
Received: from cs.columbia.edu ([128.59.16.20]:52657 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S135319AbRALVKk>;
	Fri, 12 Jan 2001 16:10:40 -0500
Date: Fri, 12 Jan 2001 13:10:30 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Fix for Adaptec Starfire resource handling
Message-ID: <Pine.LNX.4.30.0101121300410.13338-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The starfire driver in 2.4.0 (and 2.4.0-ac8) forgets to release its MMIO
region when the module is unloaded, which makes it impossible to load it a
second time. The attached patch fixed this problem; I tested it here on a
2-port card.

Please apply.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

--------------------------------------
--- linux-2.4.vanilla/drivers/net/starfire.c	Fri Aug 11 15:57:58 2000
+++ linux-2.4/drivers/net/starfire.c	Fri Jan 12 12:52:48 2001
@@ -390,7 +390,7 @@
 	static int card_idx = -1;
 	static int printed_version = 0;
 	long ioaddr;
-	int drv_flags, io_size = netdrv_tbl[chip_idx].io_size;
+	int drv_flags, io_size;

 	card_idx++;
 	option = card_idx < MAX_UNITS ? options[card_idx] : 0;
@@ -400,6 +400,7 @@
 		       version1, version2, version3);

 	ioaddr = pci_resource_start (pdev, 0);
+	io_size = pci_resource_len (pdev, 0);
 	if (!ioaddr || ((pci_resource_flags (pdev, 0) & IORESOURCE_MEM) == 0)) {
 		printk (KERN_ERR "starfire %d: no PCI MEM resources, aborting\n", card_idx);
 		return -ENODEV;
@@ -1359,6 +1360,9 @@

 	unregister_netdev(dev);
 	iounmap((char *)dev->base_addr);
+
+	release_mem_region(pci_resource_start (pdev, 0),
+					   pci_resource_len (pdev, 0));

 	if (np->tx_done_q)
 		pci_free_consistent(np->pci_dev, PAGE_SIZE,

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
