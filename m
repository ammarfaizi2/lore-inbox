Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130742AbRCMBuh>; Mon, 12 Mar 2001 20:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130749AbRCMBu1>; Mon, 12 Mar 2001 20:50:27 -0500
Received: from [194.73.73.176] ([194.73.73.176]:47250 "EHLO protactinium")
	by vger.kernel.org with ESMTP id <S130742AbRCMBuX>;
	Mon, 12 Mar 2001 20:50:23 -0500
Date: Tue, 13 Mar 2001 01:49:38 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon>
To: Alan Cox <alan@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] missing pci_enable_device
Message-ID: <Pine.LNX.4.31.0103130147170.574-100000@athlon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pcnet32 is still touching resources before enabling.
Patch below should apply to ac19.

regards

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/pcnet32.c linux-dj/drivers/net/pcnet32.c
--- linux/drivers/net/pcnet32.c	Fri Mar  9 03:29:08 2001
+++ linux-dj/drivers/net/pcnet32.c	Fri Mar  9 03:41:33 2001
@@ -482,6 +482,12 @@

     printk(KERN_INFO "pcnet32_probe_pci: found device %#08x.%#08x\n", ent->vendor, ent->device);

+    if ((err = pci_enable_device(pdev)) < 0) {
+	printk(KERN_ERR "pcnet32.c: failed to enable device -- err=%d\n", err);
+	return err;
+    }
+    pci_set_master(pdev);
+
     ioaddr = pci_resource_start (pdev, 0);
     printk(KERN_INFO "    ioaddr=%#08lx  resource_flags=%#08lx\n", ioaddr, pci_resource_flags (pdev, 0));
     if (!ioaddr) {
@@ -494,13 +500,6 @@
 	return -ENODEV;
     }

-    if ((err = pci_enable_device(pdev)) < 0) {
-	printk(KERN_ERR "pcnet32.c: failed to enable device -- err=%d\n", err);
-	return err;
-    }
-
-    pci_set_master(pdev);
-
     return pcnet32_probe1(ioaddr, pdev->irq, 1, card_idx, pdev);
 }


