Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbTDXWAC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 18:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264439AbTDXWAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 18:00:02 -0400
Received: from mailout.zma.compaq.com ([161.114.64.103]:14860 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S263798AbTDXV7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:59:47 -0400
Date: Thu, 24 Apr 2003 17:11:40 -0500
From: mikem@beardog.cca.cpqcorp.net
Message-Id: <200304242211.h3OMBel01137@beardog.cca.cpqcorp.net>
To: axboe@suse.de
Subject: RE:cciss patches for 2.4.21-rc1, 2 of 4
Cc: linux-kernel@vger.kernel.org, mike.miller@hp.com, steve.cameron@hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

20030424

Changes:
	1. Modifies the way we find the cciss config table. Required 
	   for some architectures.
	2. Now uses the pci_resource_XXXX wrappers for code compatibility.

diff -urN lx2421rc1-p1/drivers/block/cciss.c lx2421rc1/drivers/block/cciss.c
--- lx2421rc1-p1/drivers/block/cciss.c	Thu Apr 24 15:05:49 2003
+++ lx2421rc1/drivers/block/cciss.c	Thu Apr 24 14:58:19 2003
@@ -2438,25 +2438,54 @@
 	c->io_mem_addr = 0;
 	c->io_mem_length = 0;
 }
+static int find_PCI_BAR_index(struct pci_dev *pdev,
+               unsigned long pci_bar_addr)
+{
+	int i, offset, mem_type, bar_type;
+	if (pci_bar_addr == PCI_BASE_ADDRESS_0) /* looking for BAR zero? */
+		return 0;
+	offset = 0;
+	for (i=0; i<DEVICE_COUNT_RESOURCE; i++) {
+		bar_type = pci_resource_flags(pdev, i) &
+			PCI_BASE_ADDRESS_SPACE; 
+		if (bar_type == PCI_BASE_ADDRESS_SPACE_IO)
+			offset += 4;
+		else {
+			mem_type = pci_resource_flags(pdev, i) &
+				PCI_BASE_ADDRESS_MEM_TYPE_MASK; 
+			switch (mem_type) {
+				case PCI_BASE_ADDRESS_MEM_TYPE_32:
+				case PCI_BASE_ADDRESS_MEM_TYPE_1M:
+					offset += 4; /* 32 bit */
+					break;
+				case PCI_BASE_ADDRESS_MEM_TYPE_64:
+					offset += 8;
+					break;
+				case PCI_BASE_ADDRESS_MEM_PREFETCH:
+				break;
+			}
+		}
+		if (offset == pci_bar_addr - PCI_BASE_ADDRESS_0)
+			return i+1;
+	}
+	return -1;
+}
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
@@ -2482,12 +2511,12 @@
 		return -1;
 	}
 	/* search for our IO range so we can protect it */
-	for (i=0; i<6; i++) {
+	for (i=0; i<DEVICE_COUNT_RESOURCE; i++) {
 		/* is this an IO range */
-		if (pdev->resource[i].flags & 0x01) {
-			c->io_mem_addr = pdev->resource[i].start;
-			c->io_mem_length = pdev->resource[i].end -
-				pdev->resource[i].start +1; 
+		if (pci_resource_flags(pdev, i) & 0x01) {
+			c->io_mem_addr = pci_resource_start(pdev, i);
+			c->io_mem_length = pci_resource_end(pdev, i) -
+				pci_resource_start(pdev, i) + 1; 
 #ifdef CCISS_DEBUG
 			printk("IO value found base_addr[%d] %lx %lx\n", i,
 				c->io_mem_addr, c->io_mem_length);
@@ -2511,7 +2540,7 @@
 	printk("device_id = %x\n", device_id);
 	printk("command = %x\n", command);
 	for(i=0; i<6; i++)
-		printk("addr[%d] = %x\n", i, addr[i]);
+		printk("addr[%d] = %x\n", i, pci_resource_start(pdev, i);
 	printk("revision = %x\n", revision);
 	printk("irq = %x\n", irq);
 	printk("cache_line_size = %x\n", cache_line_size);
@@ -2526,7 +2555,7 @@
          *   table
 	 */
 
-	c->paddr = addr[0] ; /* addressing mode bits already removed */
+	c->paddr = pci_resource_start(pdev, 0); /* addressing mode bits already removed */
 #ifdef CCISS_DEBUG
 	printk("address 0 = %x\n", c->paddr);
 #endif /* CCISS_DEBUG */ 
@@ -2535,21 +2564,27 @@
 	/* get the address index number */
 	cfg_base_addr = readl(c->vaddr + SA5_CTCFG_OFFSET);
 	/* I am not prepared to deal with a 64 bit address value */
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
+		remap_pci_mem(pci_resource_start(pdev, cfg_base_addr_index)
 				+ cfg_offset, sizeof(CfgTable_struct));
 	c->board_id = board_id;
 
diff -urN lx2421rc1-p1/drivers/block/cciss.h lx2421rc1/drivers/block/cciss.h
--- lx2421rc1-p1/drivers/block/cciss.h	Thu Apr 24 09:37:52 2003
+++ lx2421rc1/drivers/block/cciss.h	Thu Apr 24 14:59:51 2003
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
