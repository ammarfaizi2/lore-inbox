Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265329AbUBJADX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 19:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbUBJAAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 19:00:46 -0500
Received: from mail.kroah.org ([65.200.24.183]:58812 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265403AbUBIXWf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:35 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689362918@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:17 -0800
Message-Id: <10763689371868@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.5, 2004/02/02 11:05:17-08:00, dsaxena@plexity.net

[PATCH] PCI: Replace pci_pool with generic dma_pool, part 2

include/linux changes:

- Add dma_pools member to struct device
- Add include/linux/dmapool.h
- Remove pools memober from struct pci_dev
- Replace pci_pool_* functions with macros that map to dma_pool_* functions


 include/linux/device.h  |    1 +
 include/linux/dmapool.h |   27 +++++++++++++++++++++++++++
 include/linux/pci.h     |   14 ++++++++------
 3 files changed, 36 insertions(+), 6 deletions(-)


diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Mon Feb  9 14:59:31 2004
+++ b/include/linux/device.h	Mon Feb  9 14:59:31 2004
@@ -284,6 +284,7 @@
 					   detached from its driver. */
 
 	u64		*dma_mask;	/* dma mask (if dma'able device) */
+	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
 
 	void	(*release)(struct device * dev);
 };
diff -Nru a/include/linux/dmapool.h b/include/linux/dmapool.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/dmapool.h	Mon Feb  9 14:59:31 2004
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
--- a/include/linux/pci.h	Mon Feb  9 14:59:31 2004
+++ b/include/linux/pci.h	Mon Feb  9 14:59:31 2004
@@ -393,7 +393,6 @@
 					   0xffffffff.  You only need to change
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */
-	struct list_head pools;		/* pci_pools tied to this device */
 
 	u64		consistent_dma_mask;/* Like dma_mask, but for
 					       pci_alloc_consistent mappings as
@@ -692,12 +691,15 @@
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

