Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVGUK0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVGUK0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 06:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVGUK0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 06:26:50 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:29867 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261743AbVGUKYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 06:24:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Update PCI support
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20050721102122.4440C4BC@mctpc71>
Date: Thu, 21 Jul 2005 19:21:22 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These changes are untested (I no longer have the hardware).

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/kernel/rte_mb_a_pci.c |   37 +++++++++++++++++++++++++++++++------
 arch/v850/kernel/vmlinux.lds.S  |   14 ++++++++++++++
 include/asm-v850/pci.h          |   37 +++++++++++++++++++++++++++++++------
 3 files changed, 76 insertions(+), 12 deletions(-)

diff -ruN -X../cludes linux-2.6.12-uc0/arch/v850/kernel/rte_mb_a_pci.c linux-2.6.12-uc0-v850-20050721/arch/v850/kernel/rte_mb_a_pci.c
--- linux-2.6.12-uc0/arch/v850/kernel/rte_mb_a_pci.c	2005-03-04 11:31:28.597101000 +0900
+++ linux-2.6.12-uc0-v850-20050721/arch/v850/kernel/rte_mb_a_pci.c	2005-07-21 18:45:49.496213000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/mb_a_pci.c -- PCI support for Midas lab RTE-MOTHER-A board
  *
- *  Copyright (C) 2001,02,03  NEC Electronics Corporation
- *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03,05  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03,05  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -743,15 +743,17 @@
    for a scatter-gather list, same rules and usage.  */
 
 void
-pci_dma_sync_sg_for_cpu (struct pci_dev *dev, struct scatterlist *sg, int sg_len,
-		 int dir)
+pci_dma_sync_sg_for_cpu (struct pci_dev *dev,
+			 struct scatterlist *sg, int sg_len,
+			 int dir)
 {
 	BUG ();
 }
 
 void
-pci_dma_sync_sg_for_device (struct pci_dev *dev, struct scatterlist *sg, int sg_len,
-		 int dir)
+pci_dma_sync_sg_for_device (struct pci_dev *dev,
+			    struct scatterlist *sg, int sg_len,
+			    int dir)
 {
 	BUG ();
 }
@@ -786,6 +788,27 @@
 }
 
 
+/* iomap/iomap */
+
+void __iomem *pci_iomap (struct pci_dev *dev, int bar, unsigned long max)
+{
+	unsigned long start = pci_resource_start (dev, bar);
+	unsigned long len = pci_resource_len (dev, bar);
+
+	if (!start || len == 0)
+		return 0;
+
+	/* None of the ioremap functions actually do anything, other than
+	   re-casting their argument, so don't bother differentiating them.  */
+	return ioremap (start, len);
+}
+
+void pci_iounmap (struct pci_dev *dev, void __iomem *addr)
+{
+	/* nothing */
+}
+
+
 /* symbol exports (for modules) */
 
 EXPORT_SYMBOL (pci_map_single);
@@ -794,3 +817,5 @@
 EXPORT_SYMBOL (pci_free_consistent);
 EXPORT_SYMBOL (pci_dma_sync_single_for_cpu);
 EXPORT_SYMBOL (pci_dma_sync_single_for_device);
+EXPORT_SYMBOL (pci_iomap);
+EXPORT_SYMBOL (pci_iounmap);
diff -ruN -X../cludes linux-2.6.12-uc0/arch/v850/kernel/vmlinux.lds.S linux-2.6.12-uc0-v850-20050721/arch/v850/kernel/vmlinux.lds.S
--- linux-2.6.12-uc0/arch/v850/kernel/vmlinux.lds.S	2004-12-27 11:26:17.694361000 +0900
+++ linux-2.6.12-uc0-v850-20050721/arch/v850/kernel/vmlinux.lds.S	2005-07-21 18:27:09.415864000 +0900
@@ -12,6 +12,7 @@
  */
 
 #include <linux/config.h>
+
 #define VMLINUX_SYMBOL(_sym_) _##_sym_
 #include <asm-generic/vmlinux.lds.h>
 
@@ -42,6 +43,19 @@
 			*(.rodata) *(.rodata.*)				      \
 			*(__vermagic)		/* Kernel version magic */    \
 			*(.rodata1)					      \
+		/* PCI quirks */					      \
+		___start_pci_fixups_early = . ;				      \
+			*(.pci_fixup_early)				      \
+		___end_pci_fixups_early = . ;				      \
+		___start_pci_fixups_header = . ;			      \
+			*(.pci_fixup_header)				      \
+		___end_pci_fixups_header = . ;				      \
+		___start_pci_fixups_final = . ;				      \
+			*(.pci_fixup_final)				      \
+		___end_pci_fixups_final = . ;				      \
+		___start_pci_fixups_enable = . ;			      \
+			*(.pci_fixup_enable)				      \
+		___end_pci_fixups_enable = . ;				      \
 		/* Kernel symbol table: Normal symbols */		      \
 		___start___ksymtab = .;					      \
 			*(__ksymtab)					      \
diff -ruN -X../cludes linux-2.6.12-uc0/include/asm-v850/pci.h linux-2.6.12-uc0-v850-20050721/include/asm-v850/pci.h
--- linux-2.6.12-uc0/include/asm-v850/pci.h	2004-04-05 11:34:01.719157000 +0900
+++ linux-2.6.12-uc0-v850-20050721/include/asm-v850/pci.h	2005-07-21 18:54:55.951640000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/pci.h -- PCI support
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,05  NEC Corporation
+ *  Copyright (C) 2001,02,05  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -48,12 +48,12 @@
    perform a pci_dma_sync_for_device, and then the device again owns
    the buffer.  */
 extern void
-pci_dma_sync_single_for_cpu (struct pci_dev *dev, dma_addr_t dma_addr, size_t size,
-		     int dir);
+pci_dma_sync_single_for_cpu (struct pci_dev *dev, dma_addr_t dma_addr,
+			     size_t size, int dir);
 
 extern void
-pci_dma_sync_single_for_device (struct pci_dev *dev, dma_addr_t dma_addr, size_t size,
-		     int dir);
+pci_dma_sync_single_for_device (struct pci_dev *dev, dma_addr_t dma_addr,
+				size_t size, int dir);
 
 
 /* Do multiple DMA mappings at once.  */
@@ -65,6 +65,28 @@
 pci_unmap_sg (struct pci_dev *pdev, struct scatterlist *sg, int sg_len,
 	      int dir);
 
+/* SG-list versions of pci_dma_sync functions.  */
+extern void
+pci_dma_sync_sg_for_cpu (struct pci_dev *dev,
+			 struct scatterlist *sg, int sg_len,
+			 int dir);
+extern void
+pci_dma_sync_sg_for_device (struct pci_dev *dev,
+			    struct scatterlist *sg, int sg_len,
+			    int dir);
+
+#define pci_map_page(dev, page, offs, size, dir) \
+  pci_map_single(dev, (page_address(page) + (offs)), size, dir)
+#define pci_unmap_page(dev,addr,sz,dir) \
+  pci_unmap_single(dev, addr, sz, dir)
+
+/* Test for pci_map_single or pci_map_page having generated an error.  */
+static inline int
+pci_dma_mapping_error (dma_addr_t dma_addr)
+{
+	return dma_addr == 0;
+}
+
 /* Allocate and map kernel buffer using consistent mode DMA for PCI
    device.  Returns non-NULL cpu-view pointer to the buffer if
    successful and sets *DMA_ADDR to the pci side dma address as well,
@@ -81,6 +103,9 @@
 pci_free_consistent (struct pci_dev *pdev, size_t size, void *cpu_addr,
 		     dma_addr_t dma_addr);
 
+extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
+extern void pci_iounmap (struct pci_dev *dev, void __iomem *addr);
+
 static inline void pcibios_add_platform_entries(struct pci_dev *dev)
 {
 }
