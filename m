Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422991AbWJQE3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422991AbWJQE3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 00:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423028AbWJQE3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 00:29:33 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:10422 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1422991AbWJQE3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 00:29:32 -0400
Subject: [PATCH] arch/i386/kernel/pci-dma.c: ioremap balanced with iounmap
From: Amol Lad <amol@verismonetworks.com>
To: gregkh@suse.de
Cc: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 10:02:50 +0530
Message-Id: <1161059570.20400.26.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap must be balanced by an iounmap and failing to do so can result
in a memory leak.

Tested (compilation only):
- using allmodconfig
- making sure the files are compiling without any warning/error due to
new changes

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/arch/i386/kernel/pci-dma.c linux-2.6.19-rc1/arch/i386/kernel/pci-dma.c
--- linux-2.6.19-rc1-orig/arch/i386/kernel/pci-dma.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.19-rc1/arch/i386/kernel/pci-dma.c	2006-10-05 18:36:39.000000000 +0530
@@ -75,7 +75,7 @@ EXPORT_SYMBOL(dma_free_coherent);
 int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
 				dma_addr_t device_addr, size_t size, int flags)
 {
-	void __iomem *mem_base;
+	void __iomem *mem_base = NULL;
 	int pages = size >> PAGE_SHIFT;
 	int bitmap_size = (pages + 31)/32;
 
@@ -114,6 +114,8 @@ int dma_declare_coherent_memory(struct d
  free1_out:
 	kfree(dev->dma_mem->bitmap);
  out:
+	if (mem_base)
+		iounmap(mem_base);
 	return 0;
 }
 EXPORT_SYMBOL(dma_declare_coherent_memory);


