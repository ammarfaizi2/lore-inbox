Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTDPPmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTDPPmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:42:08 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:16392 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264464AbTDPPmA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:42:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: cciss patches for 2.4.21pre7
Date: Wed, 16 Apr 2003 10:53:48 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF102399B32@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss patches for 2.4.21pre7
Thread-Index: AcMEL4fieKUDv9n7Szqjxf0RkG4aZgAABM7g
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Cameron, Steve" <Steve.Cameron@hp.com>
X-OriginalArrivalTime: 16 Apr 2003 15:53:48.0649 (UTC) FILETIME=[5E79D590:01C30430]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second of 3 patches to update the HP cciss driver to version 2.4.44 for the 2.4.21pre7 kernel. Patches should be applied in order.

Thanks,
mikem

2003/04/15

Changes:
	1. Modifies the way we find the cciss config table. Required
	   for certain architecures.

diff -urN lx2421p7-1/drivers/block/cciss.c lx2421p7-1.1/drivers/block/cciss.c
--- lx2421p7-1/drivers/block/cciss.c	Mon Apr  7 15:36:41 2003
+++ lx2421p7-1.1/drivers/block/cciss.c	Mon Apr  7 15:44:06 2003
@@ -2438,25 +2438,54 @@
 	c->io_mem_addr = 0;
 	c->io_mem_length = 0;
 }
+static int find_PCI_BAR_index(struct pci_dev *pdev,
+               unsigned long pci_bar_addr)
+{
+       int i, offset, mem_type, bar_type;
+       if (pci_bar_addr == PCI_BASE_ADDRESS_0) /* looking for BAR zero? */
+               return 0;
+       offset = 0;
+       for (i=0; i<DEVICE_COUNT_RESOURCE; i++) {
+               bar_type = pdev->resource[i].flags &
+                       PCI_BASE_ADDRESS_SPACE; 
+               if (bar_type == PCI_BASE_ADDRESS_SPACE_IO)
+                       offset += 4;
+               else {
+                       mem_type = pdev->resource[i].flags & 
+                               PCI_BASE_ADDRESS_MEM_TYPE_MASK; 
+                       switch (mem_type) {
+                               case PCI_BASE_ADDRESS_MEM_TYPE_32:
+                               case PCI_BASE_ADDRESS_MEM_TYPE_1M:
+                                       offset += 4; /* 32 bit */
+                                       break;
+                               case PCI_BASE_ADDRESS_MEM_TYPE_64:
+                                       offset += 8;
+                                       break;
+                               case PCI_BASE_ADDRESS_MEM_PREFETCH:
+                                       break;
+                       }
+               }
+               if (offset == pci_bar_addr - PCI_BASE_ADDRESS_0)
+                       return i+1;
+       }
+       return -1;
+ }
+				  
 static int cciss_pci_init(ctlr_info_t *c, struct pci_dev *pdev)
 {
 	ushort vendor_id, device_id, command;
 	unchar cache_line_size, latency_timer;
 	unchar irq, revision;
-	uint addr[6];
 	__u32 board_id;
-	int cfg_offset;
-	int cfg_base_addr;
-	int cfg_base_addr_index;
+	__u64 cfg_offset;
+	__u32 cfg_base_addr;
+	__u64 cfg_base_addr_index;
 	int i;
 
 	vendor_id = pdev->vendor;
 	device_id = pdev->device;
 	irq = pdev->irq;
 
-	for(i=0; i<6; i++)
-		addr[i] = pdev->resource[i].start;
-
 	if (pci_enable_device(pdev)) {
 		printk(KERN_ERR "cciss: Unable to Enable PCI device\n");
 		return -1;
@@ -2482,7 +2511,7 @@
 		return -1;
 	}
 	/* search for our IO range so we can protect it */
-	for (i=0; i<6; i++) {
+	for (i=0; i<DEVICE_COUNT_RESOURCE; i++) {
 		/* is this an IO range */
 		if (pdev->resource[i].flags & 0x01) {
 			c->io_mem_addr = pdev->resource[i].start;
@@ -2492,6 +2521,7 @@
 			printk("IO value found base_addr[%d] %lx %lx\n", i,
 				c->io_mem_addr, c->io_mem_length);
 #endif /* CCISS_DEBUG */
+			printk(KERN_DEBUG "IO range: %lx\n", c->io_mem_addr);
 			/* register the IO range */
 			if (!request_region( c->io_mem_addr,
                                         c->io_mem_length, "cciss")) {
@@ -2511,7 +2541,7 @@
 	printk("device_id = %x\n", device_id);
 	printk("command = %x\n", command);
 	for(i=0; i<6; i++)
-		printk("addr[%d] = %x\n", i, addr[i]);
+		printk("addr[%d] = %x\n", i, pdev->resource[i].start);
 	printk("revision = %x\n", revision);
 	printk("irq = %x\n", irq);
 	printk("cache_line_size = %x\n", cache_line_size);
@@ -2526,30 +2556,35 @@
          *   table
 	 */
 
-	c->paddr = addr[0] ; /* addressing mode bits already removed */
+	c->paddr = pdev->resource[0].start; /* addressing mode bits already removed */
 #ifdef CCISS_DEBUG
 	printk("address 0 = %x\n", c->paddr);
 #endif /* CCISS_DEBUG */ 
-	c->vaddr = remap_pci_mem(c->paddr, 200);
 
+	c->vaddr = remap_pci_mem(c->paddr, 200);
 	/* get the address index number */
 	cfg_base_addr = readl(c->vaddr + SA5_CTCFG_OFFSET);
-	/* I am not prepared to deal with a 64 bit address value */
-	cfg_base_addr &= 0xffff;
+	cfg_base_addr &= (__u32) 0x0000ffff;
 #ifdef CCISS_DEBUG
 	printk("cfg base address = %x\n", cfg_base_addr);
 #endif /* CCISS_DEBUG */
-	cfg_base_addr_index = (cfg_base_addr  - PCI_BASE_ADDRESS_0)/4;
+	cfg_base_addr_index = 
+		find_PCI_BAR_index(pdev, cfg_base_addr);
 #ifdef CCISS_DEBUG
 	printk("cfg base address index = %x\n", cfg_base_addr_index);
 #endif /* CCISS_DEBUG */
+	if (cfg_base_addr_index == -1) {
+		printk(KERN_WARNING "cciss: Cannot find cfg_base_addr_index\n");
+		release_io_mem(hba[i]);
+		return -1;
+	}
 
 	cfg_offset = readl(c->vaddr + SA5_CTMEM_OFFSET);
 #ifdef CCISS_DEBUG
 	printk("cfg offset = %x\n", cfg_offset);
 #endif /* CCISS_DEBUG */
 	c->cfgtable = (CfgTable_struct *) 
-		remap_pci_mem((addr[cfg_base_addr_index] & 0xfffffff0)
+		remap_pci_mem(pdev->resource[cfg_base_addr_index].start
 				+ cfg_offset, sizeof(CfgTable_struct));
 	c->board_id = board_id;
 
diff -urN lx2421p7-1/drivers/block/cciss.h lx2421p7-1.1/drivers/block/cciss.h
--- lx2421p7-1/drivers/block/cciss.h	Mon Apr  7 10:23:53 2003
+++ lx2421p7-1.1/drivers/block/cciss.h	Mon Apr  7 15:39:38 2003
@@ -45,8 +45,8 @@
 	char	firm_ver[4]; // Firmware version 
 	struct pci_dev *pdev;
 	__u32	board_id;
-	ulong   vaddr;
-	__u32	paddr;	
+	unsigned long vaddr;
+	unsigned long paddr;	
 	unsigned long io_mem_addr;
 	unsigned long io_mem_length;
 	CfgTable_struct *cfgtable;
