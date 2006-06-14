Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWFNXKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWFNXKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWFNXKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:10:31 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:38092 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S965002AbWFNXKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:10:30 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Mike Miller <mike.miller@hp.com>
Subject: [PATCH 3/7] CCISS: announce cciss%d devices with PCI address/IRQ/DAC info
Date: Wed, 14 Jun 2006 17:10:12 -0600
User-Agent: KMail/1.8.3
Cc: iss_storagedev@hp.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <200606141707.27404.bjorn.helgaas@hp.com>
In-Reply-To: <200606141707.27404.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606141710.12182.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We already print "cciss: using DAC cycles" or similar for every
adapter found: why not just identify the device we're talking
about and include other useful information?

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: rc6-mm2/drivers/block/cciss.c
===================================================================
--- rc6-mm2.orig/drivers/block/cciss.c	2006-06-14 16:18:20.000000000 -0600
+++ rc6-mm2/drivers/block/cciss.c	2006-06-14 16:18:29.000000000 -0600
@@ -3086,11 +3086,8 @@
 	int i;
 	int j;
 	int rc;
+	int dac;
 
-	printk(KERN_DEBUG "cciss: Device 0x%x has been found at"
-			" bus %d dev %d func %d\n",
-		pdev->device, pdev->bus->number, PCI_SLOT(pdev->devfn),
-			PCI_FUNC(pdev->devfn));
 	i = alloc_cciss_hba();
 	if(i < 0)
 		return (-1);
@@ -3106,11 +3103,11 @@
 
 	/* configure PCI DMA stuff */
 	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK))
-		printk("cciss: using DAC cycles\n");
+		dac = 1;
 	else if (!pci_set_dma_mask(pdev, DMA_32BIT_MASK))
-		printk("cciss: not using DAC cycles\n");
+		dac = 0;
 	else {
-		printk("cciss: no suitable DMA available\n");
+		printk(KERN_ERR "cciss: no suitable DMA available\n");
 		goto clean1;
 	}
 
@@ -3141,6 +3138,11 @@
 			hba[i]->intr[SIMPLE_MODE_INT], hba[i]->devname);
 		goto clean2;
 	}
+
+	printk(KERN_INFO "%s: <0x%x> at PCI %s IRQ %d%s using DAC\n",
+		hba[i]->devname, pdev->device, pci_name(pdev),
+		hba[i]->intr[SIMPLE_MODE_INT], dac ? "" : " not");
+
 	hba[i]->cmd_pool_bits = kmalloc(((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long), GFP_KERNEL);
 	hba[i]->cmd_pool = (CommandList_struct *)pci_alloc_consistent(
 		hba[i]->pdev, NR_CMDS * sizeof(CommandList_struct), 
