Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbRHJIZv>; Fri, 10 Aug 2001 04:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266158AbRHJIZd>; Fri, 10 Aug 2001 04:25:33 -0400
Received: from gold.MUSKOKA.COM ([216.123.107.5]:8455 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S266040AbRHJIZR>;
	Fri, 10 Aug 2001 04:25:17 -0400
Message-ID: <3B7393B0.45952B8A@yahoo.com>
Date: Fri, 10 Aug 2001 03:56:32 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.19 i586)
MIME-Version: 1.0
To: kern@wolf.ericsson.net.nz
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops pcnet32 ethernet driver on Compaq Deskpro 5100
In-Reply-To: <Pine.LNX.4.33.0108041641480.14017-100000@wolf.ericsson.net.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kern@wolf.ericsson.net.nz wrote:
> 
> hey -
> 
> I am getting the following oops when I try to insert the pcnet32 ethernet
> driver on an older Compaq 5100 (Pentium 100 with onboard ethernet
> controller) and rh7.1
> 
> When the machine boots the module loads Ok, I only get this error when I
> rmmod pcnet32 and then modprobe to reinsert it.
 
I posted a fix for this in January, but looking at pcnet32 (2.4.7) I
see that it never made it in.  Hrrm, I see there is an I/O resource leak
in the driver as well.  Okay, this should fix both - please test.

Paul.

--- drivers/net/pcnet32.c~	Thu Aug  9 16:33:37 2001
+++ drivers/net/pcnet32.c	Thu Aug  9 18:35:30 2001
@@ -179,6 +179,7 @@
  * v1.25kf Added No Interrupt on successful Tx for some Tx's <kaf@fc.hp.com>
  * v1.26   Converted to pci_alloc_consistent, Jamey Hicks / George France
  *                                           <jamey@crl.dec.com>
+ * v1.26p Fix oops on rmmod+insmod; plug i/o resource leak - Paul Gortmaker
  */
 
 
@@ -510,6 +511,7 @@
 pcnet32_probe1(unsigned long ioaddr, unsigned char irq_line, int shared, int card_idx, struct pci_dev *pdev)
 {
     struct pcnet32_private *lp;
+    struct resource *res;
     dma_addr_t lp_dma_addr;
     int i,media,fdx = 0, mii = 0, fset = 0;
 #ifdef DO_DXSUFLO
@@ -682,11 +684,15 @@
     }
 
     dev->base_addr = ioaddr;
-    request_region(ioaddr, PCNET32_TOTAL_SIZE, chipname);
+    res = request_region(ioaddr, PCNET32_TOTAL_SIZE, chipname);
+    if (res == NULL)
+	return -EBUSY;
     
     /* pci_alloc_consistent returns page-aligned memory, so we do not have to check the alignment */
-    if ((lp = pci_alloc_consistent(pdev, sizeof(*lp), &lp_dma_addr)) == NULL)
+    if ((lp = pci_alloc_consistent(pdev, sizeof(*lp), &lp_dma_addr)) == NULL) {
+	release_resource(res);
 	return -ENOMEM;
+    }
 
     memset(lp, 0, sizeof(*lp));
     lp->dma_addr = lp_dma_addr;
@@ -715,6 +721,7 @@
     if (a == NULL) {
       printk(KERN_ERR "pcnet32: No access methods\n");
       pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
+      release_resource(res);
       return -ENODEV;
     }
     lp->a = *a;
@@ -762,6 +769,7 @@
 	else {
 	    printk(", failed to detect IRQ line.\n");
 	    pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
+	    release_resource(res);
 	    return -ENODEV;
 	}
     }
@@ -1579,6 +1587,8 @@
 	next_dev = lp->next;
 	unregister_netdev(pcnet32_dev);
 	release_region(pcnet32_dev->base_addr, PCNET32_TOTAL_SIZE);
+	if (lp->pci_dev != NULL)
+	    pci_unregister_driver(&pcnet32_driver);
         pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
 	kfree(pcnet32_dev);
 	pcnet32_dev = next_dev;


