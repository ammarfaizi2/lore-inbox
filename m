Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129288AbRBGSmx>; Wed, 7 Feb 2001 13:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129373AbRBGSmn>; Wed, 7 Feb 2001 13:42:43 -0500
Received: from rhenium.btinternet.com ([194.73.73.93]:51329 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S129288AbRBGSmb>;
	Wed, 7 Feb 2001 13:42:31 -0500
Date: Wed, 7 Feb 2001 18:42:07 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Alan Cox <alan@redhat.com>
cc: <becker@scyld.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] starfire reads irq before pci_enable_device.
Message-ID: <Pine.LNX.4.31.0102071840010.17118-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan, Donald,

This driver should call pci_enable_device before reading
pdev->irq.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/starfire.c linux-dj/drivers/net/starfire.c
--- linux/drivers/net/starfire.c	Wed Feb  7 12:42:42 2001
+++ linux-dj/drivers/net/starfire.c	Wed Feb  7 18:34:22 2001
@@ -409,6 +409,9 @@
 	}
 	SET_MODULE_OWNER(dev);

+	if (pci_enable_device (pdev))
+		goto err_out_free_netdev;
+
 	irq = pdev->irq;

 	if (request_mem_region (ioaddr, io_size, dev->name) == NULL) {
@@ -416,10 +419,7 @@
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
