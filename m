Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRBGTxN>; Wed, 7 Feb 2001 14:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBGTxD>; Wed, 7 Feb 2001 14:53:03 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:56038 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S129481AbRBGTws>; Wed, 7 Feb 2001 14:52:48 -0500
Date: Wed, 7 Feb 2001 19:52:34 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
Message-ID: <Pine.LNX.4.31.0102071951060.17788-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> rejected -- ioaddr assigned a value before pci_enable_device is called

Better ?

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/starfire.c linux-dj/drivers/net/starfire.c
--- linux/drivers/net/starfire.c	Wed Feb  7 12:42:42 2001
+++ linux-dj/drivers/net/starfire.c	Wed Feb  7 19:47:54 2001
@@ -396,12 +396,6 @@
 		printk(KERN_INFO "%s" KERN_INFO "%s" KERN_INFO "%s",
 		       version1, version2, version3);

-	ioaddr = pci_resource_start (pdev, 0);
-	if (!ioaddr || ((pci_resource_flags (pdev, 0) & IORESOURCE_MEM) == 0)) {
-		printk (KERN_ERR "starfire %d: no PCI MEM resources, aborting\n", card_idx);
-		return -ENODEV;
-	}
-
 	dev = init_etherdev(NULL, sizeof(*np));
 	if (!dev) {
 		printk (KERN_ERR "starfire %d: cannot alloc etherdev, aborting\n", card_idx);
@@ -409,6 +403,14 @@
 	}
 	SET_MODULE_OWNER(dev);

+	if (pci_enable_device (pdev))
+		goto err_out_free_netdev;
+
+	ioaddr = pci_resource_start (pdev, 0);
+	if (!ioaddr || ((pci_resource_flags (pdev, 0) & IORESOURCE_MEM) == 0)) {
+		printk (KERN_ERR "starfire %d: no PCI MEM resources, aborting\n", card_idx);
+		return -ENODEV;
+	}
 	irq = pdev->irq;

 	if (request_mem_region (ioaddr, io_size, dev->name) == NULL) {
@@ -416,10 +418,7 @@
 			card_idx, io_size, ioaddr);
 		goto err_out_free_netdev;
 	}
-
-	if (pci_enable_device (pdev))
-		goto err_out_free_res;
-
+
 	ioaddr = (long) ioremap (ioaddr, io_size);
 	if (!ioaddr) {
 		printk (KERN_ERR "starfire %d: cannot remap 0x%x @ 0x%lx, aborting\n",


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
