Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313162AbSDOKKt>; Mon, 15 Apr 2002 06:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313163AbSDOKKs>; Mon, 15 Apr 2002 06:10:48 -0400
Received: from copper.ftech.net ([212.32.16.118]:55946 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id <S313162AbSDOKKs>;
	Mon, 15 Apr 2002 06:10:48 -0400
Message-ID: <7C078C66B7752B438B88E11E5E20E72E4294@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: "'akpm@zip.com.au'" <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.8] farsync.c driver updates
Date: Mon, 15 Apr 2002 11:10:34 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
	please incorporate the following patch into the next release of the
2.5 Kernel.  It removes the references to the rmem_start and rmem_end fields
no longer supported in the net device structure, and moves the call to the
pci_enable_device (thanks Morten).

Kevin 

--- farsync.c.orig      Mon Apr 15 10:38:41 2002
+++ farsync.c   Mon Apr 15 10:42:03 2002
@@ -1469,10 +1469,6 @@
                                  + BUF_OFFSET ( txBuffer[i][0][0]);
                 dev->mem_end     = card->phys_mem
                                  + BUF_OFFSET (
txBuffer[i][NUM_TX_BUFFER][0]);
-                dev->rmem_start  = card->phys_mem
-                                 + BUF_OFFSET ( rxBuffer[i][0][0]);
-                dev->rmem_end    = card->phys_mem
-                                 + BUF_OFFSET (
rxBuffer[i][NUM_RX_BUFFER][0]);
                 dev->base_addr   = card->pci_conf;
                 dev->irq         = card->irq;
 
@@ -1531,6 +1527,13 @@
         }
         memset ( card, 0, sizeof ( struct fst_card_info ));
 
+        /* Try to enable the device */
+        if (( err = pci_enable_device ( pdev )) != 0 )
+        {
+                printk_err ("Failed to enable card. Err %d\n", -err );
+                goto error_free_card;
+        }
+
         /* Record info we need*/
         card->irq         = pdev->irq;
         card->pci_conf    = pci_resource_start ( pdev, 1 );
@@ -1570,12 +1573,6 @@
                 goto error_release_mem;
         }
 
-        /* Try to enable the device */
-        if (( err = pci_enable_device ( pdev )) != 0 )
-        {
-                printk_err ("Failed to enable card. Err %d\n", -err );
-                goto error_release_ctlmem;
-        }
 
         /* Get virtual addresses of memory regions */
         if (( card->mem = ioremap ( card->phys_mem, FST_MEMSIZE )) == NULL
)
