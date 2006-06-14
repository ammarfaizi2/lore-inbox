Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbWFNXJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWFNXJu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWFNXJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:09:49 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:23168 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S965001AbWFNXJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:09:48 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Mike Miller <mike.miller@hp.com>
Subject: [PATCH 2/7] CCISS: request all PCI resources
Date: Wed, 14 Jun 2006 17:09:30 -0600
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
Message-Id: <200606141709.30649.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We should call pci_request_regions() to claim all resources the device
decodes.  Previously, we claimed only the I/O port range.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: rc5-mm3/drivers/block/cciss.c
===================================================================
--- rc5-mm3.orig/drivers/block/cciss.c	2006-06-14 14:37:49.000000000 -0600
+++ rc5-mm3/drivers/block/cciss.c	2006-06-14 14:44:03.000000000 -0600
@@ -2638,16 +2638,6 @@
 }
 #endif /* CCISS_DEBUG */ 
 
-static void release_io_mem(ctlr_info_t *c)
-{
-	/* if IO mem was not protected do nothing */
-	if( c->io_mem_addr == 0)
-		return;
-	release_region(c->io_mem_addr, c->io_mem_length);
-	c->io_mem_addr = 0;
-	c->io_mem_length = 0;
-}
-
 static int find_PCI_BAR_index(struct pci_dev *pdev,
 				unsigned long pci_bar_addr)
 {
@@ -2762,36 +2752,18 @@
 		return err;
 	}
 
+	err = pci_request_regions(pdev, "cciss");
+	if (err) {
+		printk(KERN_ERR "cciss: Cannot obtain PCI resources, "
+			"aborting\n");
+		goto err_out_disable_pdev;
+	}
+
 	subsystem_vendor_id = pdev->subsystem_vendor;
 	subsystem_device_id = pdev->subsystem_device;
 	board_id = (((__u32) (subsystem_device_id << 16) & 0xffff0000) |
 					subsystem_vendor_id);
 
-	/* search for our IO range so we can protect it */
-	for(i=0; i<DEVICE_COUNT_RESOURCE; i++)
-	{
-		/* is this an IO range */ 
-		if( pci_resource_flags(pdev, i) & 0x01 ) {
-			c->io_mem_addr = pci_resource_start(pdev, i);
-			c->io_mem_length = pci_resource_end(pdev, i) -
-				pci_resource_start(pdev, i) +1;
-#ifdef CCISS_DEBUG
-			printk("IO value found base_addr[%d] %lx %lx\n", i,
-				c->io_mem_addr, c->io_mem_length);
-#endif /* CCISS_DEBUG */
-			/* register the IO range */ 
-			if(!request_region( c->io_mem_addr,
-                                        c->io_mem_length, "cciss"))
-			{
-				printk(KERN_WARNING "cciss I/O memory range already in use addr=%lx length=%ld\n",
-				c->io_mem_addr, c->io_mem_length);
-				c->io_mem_addr= 0;
-				c->io_mem_length = 0;
-			} 
-			break;
-		}
-	}
-
 #ifdef CCISS_DEBUG
 	printk("command = %x\n", command);
 	printk("irq = %x\n", pdev->irq);
@@ -2826,7 +2798,7 @@
 	if (scratchpad != CCISS_FIRMWARE_READY) {
 		printk(KERN_WARNING "cciss: Board not ready.  Timed out.\n");
 		err = -ENODEV;
-		goto err_out_disable_pdev;
+		goto err_out_free_res;
 	}
 
 	/* get the address index number */
@@ -2842,9 +2814,8 @@
 #endif /* CCISS_DEBUG */
 	if (cfg_base_addr_index == -1) {
 		printk(KERN_WARNING "cciss: Cannot find cfg_base_addr_index\n");
-		release_io_mem(c);
 		err = -ENODEV;
-		goto err_out_disable_pdev;
+		goto err_out_free_res;
 	}
 
 	cfg_offset = readl(c->vaddr + SA5_CTMEM_OFFSET);
@@ -2872,7 +2843,7 @@
 			" to access the Smart Array controller %08lx\n", 
 				(unsigned long)board_id);
 		err = -ENODEV;
-		goto err_out_disable_pdev;
+		goto err_out_free_res;
 	}
 	if (  (readb(&c->cfgtable->Signature[0]) != 'C') ||
 	      (readb(&c->cfgtable->Signature[1]) != 'I') ||
@@ -2881,7 +2852,7 @@
 	{
 		printk("Does not appear to be a valid CISS config table\n");
 		err = -ENODEV;
-		goto err_out_disable_pdev;
+		goto err_out_free_res;
 	}
 
 #ifdef CONFIG_X86
@@ -2926,10 +2897,13 @@
 		printk(KERN_WARNING "cciss: unable to get board into"
 					" simple mode\n");
 		err = -ENODEV;
-		goto err_out_disable_pdev;
+		goto err_out_free_res;
 	}
 	return 0;
 
+err_out_free_res:
+	pci_release_regions(pdev);
+
 err_out_disable_pdev:
 	pci_disable_device(pdev);
 	return err;
@@ -3276,7 +3250,6 @@
 clean2:
 	unregister_blkdev(hba[i]->major, hba[i]->devname);
 clean1:
-	release_io_mem(hba[i]);
 	hba[i]->busy_initializing = 0;
 	free_hba(i);
 	return(-1);
@@ -3322,7 +3295,6 @@
                 pci_disable_msi(hba[i]->pdev);
 #endif /* CONFIG_PCI_MSI */
 
-	pci_set_drvdata(pdev, NULL);
 	iounmap(hba[i]->vaddr);
 	cciss_unregister_scsi(i);  /* unhook from SCSI subsystem */
 	unregister_blkdev(hba[i]->major, hba[i]->devname);
@@ -3349,7 +3321,9 @@
 #ifdef CONFIG_CISS_SCSI_TAPE
 	kfree(hba[i]->scsi_rejects.complete);
 #endif
- 	release_io_mem(hba[i]);
+ 	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
 	free_hba(i);
 }	
 
Index: rc5-mm3/drivers/block/cciss.h
===================================================================
--- rc5-mm3.orig/drivers/block/cciss.h	2006-03-19 22:53:29.000000000 -0700
+++ rc5-mm3/drivers/block/cciss.h	2006-06-14 14:45:00.000000000 -0600
@@ -60,8 +60,6 @@
 	__u32	board_id;
 	void __iomem *vaddr;
 	unsigned long paddr;
-	unsigned long io_mem_addr;
-	unsigned long io_mem_length;
 	CfgTable_struct __iomem *cfgtable;
 	int	interrupts_enabled;
 	int	major;
