Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbUBEADA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbUBEACP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:02:15 -0500
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:30212 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S264942AbUBEAAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:00:31 -0500
Date: Wed, 4 Feb 2004 18:04:46 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: axboe@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates for 2.6 [1 of 11]
Message-ID: <Pine.LNX.4.58.0402041737080.18320@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 of 11. Please apply in order.
This patch eliminates the bad assumption that all of our PCI BARs will
always be 32-bits. Tested against the 2.6.2 kernel.
This is required to support the Pinnacles architecture. It is already in
the 2.4 tree.
Please consider this patch for inclusion.
--------------------------------------------------------------------------------------
diff -burN lx261.orig/drivers/block/cciss.c lx261/drivers/block/cciss.c
--- lx261.orig/drivers/block/cciss.c	2004-01-09 01:00:04.000000000 -0600
+++ lx261/drivers/block/cciss.c	2004-01-21 15:55:37.000000000 -0600
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
@@ -2192,22 +2223,27 @@

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
+		remap_pci_mem(pci_resource_start(pdev, cfg_base_addr_index)
 				+ cfg_offset, sizeof(CfgTable_struct));
 	c->board_id = board_id;

diff -burN lx261.orig/drivers/block/cciss.h lx261/drivers/block/cciss.h
--- lx261.orig/drivers/block/cciss.h	2004-01-09 00:59:02.000000000 -0600
+++ lx261/drivers/block/cciss.h	2004-01-21 15:53:59.000000000 -0600
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

Thanks,
mikem
mike.miller@hp.com

