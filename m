Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTKKOcd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 09:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTKKOcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 09:32:32 -0500
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:38665 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id S263510AbTKKOc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 09:32:27 -0500
Date: Tue, 11 Nov 2003 08:54:57 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: akpm@digeo.com
Cc: mike.miller@hp.com, linux-kernel@vger.kernel.org, torben.mathiasen@hp.com
Subject: patch to support 64-bit BARs for cciss
Message-ID: <Pine.LNX.4.58.0311110843220.27134@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch removes the bad assumption that all of our PCI BARs
would always be 32-bits. This is required to support some architectures in
cluding Pinnacles.
The patch was built and tested against 2.6.0-test9 and is currently in the
later 2.4 kernels. Please consider this patch for inclusion.

Thanks,
mikem
mike.miller@hp.com
-----------------------------------------------------------------------------------------
diff -burN test9.orig/drivers/block/cciss.c test9/drivers/block/cciss.c
--- test9.orig/drivers/block/cciss.c	2003-10-25 13:44:49.000000000 -0500
+++ test9/drivers/block/cciss.c	2003-11-06 11:47:36.000000000 -0600
@@ -2078,16 +2078,51 @@
 	c->io_mem_addr = 0;
 	c->io_mem_length = 0;
 }
+
+static int find_PCI_BAR_index(struct pci_dev *pdev,
+				unsigned long pci_bar_addr)
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
+				default: /* reserved in PCI 2.2 */
+					printk(KERN_WARNING "Base address is invalid\n");
+			       		return -1;
+				break;
+			}
+		}
+ 		if (offset == pci_bar_addr - PCI_BASE_ADDRESS_0)
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
 	__u32 board_id, scratchpad = 0;
-	int cfg_offset;
-	int cfg_base_addr;
-	int cfg_base_addr_index;
+	__u64 cfg_offset;
+	__u32 cfg_base_addr;
+	__u64 cfg_base_addr_index;
 	int i;

 	if (pci_enable_device(pdev))
@@ -2105,9 +2140,6 @@
 	device_id = pdev->device;
 	irq = pdev->irq;

-	for(i=0; i<6; i++)
-		addr[i] = pdev->resource[i].start;
-
 	(void) pci_read_config_word(pdev, PCI_COMMAND,&command);
 	(void) pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
 	(void) pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE,
@@ -2125,14 +2157,13 @@
 	}

 	/* search for our IO range so we can protect it */
-	for(i=0; i<6; i++)
+	for(i=0; i<DEVICE_COUNT_RESOURCE; i++)
 	{
 		/* is this an IO range */
-		if( pdev->resource[i].flags & 0x01 )
-		{
-			c->io_mem_addr = pdev->resource[i].start;
-			c->io_mem_length = pdev->resource[i].end -
-				pdev->resource[i].start +1;
+		if( pdev_resource_flags(pdev, i) & 0x01 ) {
+			c->io_mem_addr = pdev_resource_start(pdev, i);
+			c->io_mem_length = pdev_resource_end(pdev, i) -
+				pdev_resource_start(pdev, i) +1;
 #ifdef CCISS_DEBUG
 			printk("IO value found base_addr[%d] %lx %lx\n", i,
 				c->io_mem_addr, c->io_mem_length);
@@ -2155,7 +2186,7 @@
 	printk("device_id = %x\n", device_id);
 	printk("command = %x\n", command);
 	for(i=0; i<6; i++)
-		printk("addr[%d] = %x\n", i, addr[i]);
+		printk("addr[%d] = %x\n", i, pci_resource_start(pdev, i);
 	printk("revision = %x\n", revision);
 	printk("irq = %x\n", irq);
 	printk("cache_line_size = %x\n", cache_line_size);
@@ -2170,7 +2201,7 @@
          *   table
 	 */

-	c->paddr = addr[0] ; /* addressing mode bits already removed */
+	c->paddr = pci_resource_start(pdev, 0); /* addressing mode bits already removed */
 #ifdef CCISS_DEBUG
 	printk("address 0 = %x\n", c->paddr);
 #endif /* CCISS_DEBUG */
@@ -2193,21 +2224,27 @@
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

diff -burN test9.orig/drivers/block/cciss.h test9/drivers/block/cciss.h
--- test9.orig/drivers/block/cciss.h	2003-10-25 13:42:43.000000000 -0500
+++ test9/drivers/block/cciss.h	2003-11-06 10:57:47.000000000 -0600
@@ -42,8 +42,8 @@
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
-----------------------------------------------------------------------------------------
