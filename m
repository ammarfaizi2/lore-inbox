Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264442AbUAaAlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 19:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbUAaAlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 19:41:50 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:35023 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S264442AbUAaAll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 19:41:41 -0500
Date: Fri, 30 Jan 2004 17:41:40 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: torvalds@osdl.org, akpm@osdl.org
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Replace pci_pool with generic dma_pool
Message-ID: <20040131004140.GD24967@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040131003205.GA24967@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131003205.GA24967@plexity.net>
User-Agent: Mutt/1.3.28i
Organization: Plexity Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux changes:

- Add dma_pools member to struct device
- Add include/linux/dmapool.h
- Remove pools memober from struct pci_dev
- Replace pci_pool_* functions with macros that map to dma_pool_* functions


diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Fri Jan 30 12:20:30 2004
+++ b/include/linux/device.h	Fri Jan 30 12:20:30 2004
@@ -284,6 +284,7 @@
 					   detached from its driver. */
 
 	u64		*dma_mask;	/* dma mask (if dma'able device) */
+	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
 
 	void	(*release)(struct device * dev);
 };
diff -Nru a/include/linux/dmapool.h b/include/linux/dmapool.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/dmapool.h	Fri Jan 30 12:20:30 2004
@@ -0,0 +1,27 @@
+/*
+ * include/linux/dmapool.h
+ *
+ * Allocation pools for DMAable (coherent) memory.
+ *
+ * This file is licensed under  the terms of the GNU General Public 
+ * License version 2. This program is licensed "as is" without any 
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef LINUX_DMAPOOL_H
+#define	LINUX_DMAPOOL_H
+
+#include <asm/io.h>
+#include <asm/scatterlist.h>
+
+struct dma_pool *dma_pool_create(const char *name, struct device *dev, 
+			size_t size, size_t align, size_t allocation);
+
+void dma_pool_destroy(struct dma_pool *pool);
+
+void *dma_pool_alloc(struct dma_pool *pool, int mem_flags, dma_addr_t *handle);
+
+void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t addr);
+
+#endif
+
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Fri Jan 30 12:20:30 2004
+++ b/include/linux/pci.h	Fri Jan 30 12:20:30 2004
@@ -393,7 +393,6 @@
 					   0xffffffff.  You only need to change
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */
-	struct list_head pools;		/* pci_pools tied to this device */
 
 	u64		consistent_dma_mask;/* Like dma_mask, but for
 					       pci_alloc_consistent mappings as
@@ -689,12 +688,15 @@
 int pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass);
 
 /* kmem_cache style wrapper around pci_alloc_consistent() */
-struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
-		size_t size, size_t align, size_t allocation);
-void pci_pool_destroy (struct pci_pool *pool);
 
-void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
-void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
+#include <linux/dmapool.h>
+
+#define	pci_pool dma_pool
+#define pci_pool_create(name, pdev, size, align, allocation) \
+		dma_pool_create(name, &pdev->dev, size, align, allocation)
+#define	pci_pool_destroy(pool) dma_pool_destroy(pool)
+#define	pci_pool_alloc(pool, flags, handle) dma_pool_alloc(pool, flags, handle)
+#define	pci_pool_free(pool, vaddr, addr) dma_pool_free(pool, vaddr, addr)
 
 #if defined(CONFIG_ISA) || defined(CONFIG_EISA)
 extern struct pci_dev *isa_bridge;
-- 
Deepak Saxena - dsaxena@plexity.net
