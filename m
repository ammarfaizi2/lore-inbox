Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267808AbUJCLrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267808AbUJCLrK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 07:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUJCLrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 07:47:10 -0400
Received: from verein.lst.de ([213.95.11.210]:11445 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S267808AbUJCLq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 07:46:59 -0400
Date: Sun, 3 Oct 2004 13:46:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: mike.miller@hp.com, iss_storagedev@hp.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __iomem annotations for cciss
Message-ID: <20041003114655.GA32392@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also remove the page masking before ioremap, it's not been nessecary for
ages.


--- 1.122/drivers/block/cciss.c	2004-08-23 10:15:28 +02:00
+++ edited/drivers/block/cciss.c	2004-10-02 15:14:22 +02:00
@@ -1841,17 +1841,6 @@
 	cmd_free(info_p, c, 1);
 	return (status);
 } 
-/*
- * Map (physical) PCI mem into (virtual) kernel space
- */
-static ulong remap_pci_mem(ulong base, ulong size)
-{
-        ulong page_base        = ((ulong) base) & PAGE_MASK;
-        ulong page_offs        = ((ulong) base) - page_base;
-        ulong page_remapped    = (ulong) ioremap(page_base, page_offs+size);
-
-        return (ulong) (page_remapped ? (page_remapped + page_offs) : 0UL);
-}
 
 /* 
  * Takes jobs of the Q and sends them to the hardware, then puts it on 
@@ -2369,11 +2358,7 @@
          *   table
 	 */
 
-	c->paddr = pci_resource_start(pdev, 0); /* addressing mode bits already removed */
-#ifdef CCISS_DEBUG
-	printk("address 0 = %x\n", c->paddr);
-#endif /* CCISS_DEBUG */ 
-	c->vaddr = remap_pci_mem(c->paddr, 200);
+	c->vaddr = ioremap(pci_resource_start(pdev, 0), 200);
 
 	/* Wait for the board to become ready.  (PCI hotplug needs this.)
 	 * We poll for up to 120 secs, once per 100ms. */
@@ -2410,8 +2395,7 @@
 #ifdef CCISS_DEBUG
 	printk("cfg offset = %x\n", cfg_offset);
 #endif /* CCISS_DEBUG */
-	c->cfgtable = (CfgTable_struct *) 
-		remap_pci_mem(pci_resource_start(pdev, cfg_base_addr_index)
+	c->cfgtable = ioremap(pci_resource_start(pdev, cfg_base_addr_index)
 				+ cfg_offset, sizeof(CfgTable_struct));
 	c->board_id = board_id;
 
@@ -2824,7 +2808,7 @@
 	}
 	free_irq(hba[i]->intr, hba[i]);
 	pci_set_drvdata(pdev, NULL);
-	iounmap((void*)hba[i]->vaddr);
+	iounmap(hba[i]->vaddr);
 	cciss_unregister_scsi(i);  /* unhook from SCSI subsystem */
 	unregister_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname);
 	remove_proc_entry(hba[i]->devname, proc_cciss);	
--- 1.24/drivers/block/cciss.h	2004-08-23 10:15:28 +02:00
+++ edited/drivers/block/cciss.h	2004-10-02 15:12:53 +02:00
@@ -43,11 +43,10 @@
 	char	firm_ver[4]; // Firmware version 
 	struct pci_dev *pdev;
 	__u32	board_id;
-	unsigned long vaddr;
-	unsigned long paddr;
+	void __iomem *vaddr;
 	unsigned long io_mem_addr;
 	unsigned long io_mem_length;
-	CfgTable_struct *cfgtable;
+	CfgTable_struct __iomem *cfgtable;
 	unsigned int intr;
 	int	interrupts_enabled;
 	int 	max_commands;
