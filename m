Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132291AbRA1L0X>; Sun, 28 Jan 2001 06:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136067AbRA1L0N>; Sun, 28 Jan 2001 06:26:13 -0500
Received: from [194.73.73.138] ([194.73.73.138]:17917 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S136006AbRA1L0C>;
	Sun, 28 Jan 2001 06:26:02 -0500
Date: Sun, 28 Jan 2001 11:25:51 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <tsbogend@alpha.franken.de>
Subject: [PATCH] PCNet32.c missing pci_free_consistent
Message-ID: <Pine.LNX.4.31.0101281123510.5726-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This driver fails to release allocations from pci_alloc_consistent
in its failure paths. Patch below is against 2.4.0-ac12, but should
also apply to Linus' tree cleanly.

regards,

Davej.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/pcnet32.c linux-dj/drivers/net/pcnet32.c
--- linux/drivers/net/pcnet32.c	Sun Jan 28 10:06:06 2001
+++ linux-dj/drivers/net/pcnet32.c	Sun Jan 28 11:12:37 2001
@@ -685,6 +685,7 @@

     if (a == NULL) {
       printk(KERN_ERR "pcnet32: No access methods\n");
+      pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
       return -ENODEV;
     }
     lp->a = *a;
@@ -731,6 +732,7 @@
 	    printk(", probed IRQ %d.\n", dev->irq);
 	else {
 	    printk(", failed to detect IRQ line.\n");
+	    pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
 	    return -ENODEV;
 	}
     }


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
