Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265452AbUBIXsU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265466AbUBIX1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:27:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:2493 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265452AbUBIXWq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:46 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689391232@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:19 -0800
Message-Id: <107636893939@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.11, 2004/02/03 16:22:27-08:00, david-b@pacbell.net

[PATCH] PCI: dma_pool fixups


 Documentation/DMA-API.txt |   83 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/dmapool.c    |    6 +--
 2 files changed, 86 insertions(+), 3 deletions(-)


diff -Nru a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
--- a/Documentation/DMA-API.txt	Mon Feb  9 14:59:04 2004
+++ b/Documentation/DMA-API.txt	Mon Feb  9 14:59:04 2004
@@ -20,6 +20,10 @@
 To get the pci_ API, you must #include <linux/pci.h>
 To get the dma_ API, you must #include <linux/dma-mapping.h>
 
+
+Part Ia - Using large dma-coherent buffers
+------------------------------------------
+
 void *
 dma_alloc_coherent(struct device *dev, size_t size,
 			     dma_addr_t *dma_handle, int flag)
@@ -42,6 +46,7 @@
 Note: consistent memory can be expensive on some platforms, and the
 minimum allocation length may be as big as a page, so you should
 consolidate your requests for consistent memory as much as possible.
+The simplest way to do that is to use the dma_pool calls (see below).
 
 The flag parameter (dma_alloc_coherent only) allows the caller to
 specify the GFP_ flags (see kmalloc) for the allocation (the
@@ -61,6 +66,79 @@
 consistent allocate.  cpu_addr must be the virtual address returned by
 the consistent allocate
 
+
+Part Ib - Using small dma-coherent buffers
+------------------------------------------
+
+To get this part of the dma_ API, you must #include <linux/dmapool.h>
+
+Many drivers need lots of small dma-coherent memory regions for DMA
+descriptors or I/O buffers.  Rather than allocating in units of a page
+or more using dma_alloc_coherent(), you can use DMA pools.  These work
+much like a kmem_cache_t, except that they use the dma-coherent allocator
+not __get_free_pages().  Also, they understand common hardware constraints
+for alignment, like queue heads needing to be aligned on N byte boundaries.
+
+
+	struct dma_pool *
+	dma_pool_create(const char *name, struct device *dev,
+			size_t size, size_t align, size_t alloc);
+
+	struct pci_pool *
+	pci_pool_create(const char *name, struct pci_device *dev,
+			size_t size, size_t align, size_t alloc);
+
+The pool create() routines initialize a pool of dma-coherent buffers
+for use with a given device.  It must be called in a context which
+can sleep.
+
+The "name" is for diagnostics (like a kmem_cache_t name); dev and size
+are like what you'd pass to dma_alloc_coherent().  The device's hardware
+alignment requirement for this type of data is "align" (which is expressed
+in bytes, and must be a power of two).  If your device has no boundary
+crossing restrictions, pass 0 for alloc; passing 4096 says memory allocated
+from this pool must not cross 4KByte boundaries.
+
+
+	void *dma_pool_alloc(struct dma_pool *pool, int gfp_flags,
+			dma_addr_t *dma_handle);
+
+	void *pci_pool_alloc(struct pci_pool *pool, int gfp_flags,
+			dma_addr_t *dma_handle);
+
+This allocates memory from the pool; the returned memory will meet the size
+and alignment requirements specified at creation time.  Pass GFP_ATOMIC to
+prevent blocking, or if it's permitted (not in_interrupt, not holding SMP locks)
+pass GFP_KERNEL to allow blocking.  Like dma_alloc_coherent(), this returns
+two values:  an address usable by the cpu, and the dma address usable by the
+pool's device.
+
+
+	void dma_pool_free(struct dma_pool *pool, void *vaddr,
+			dma_addr_t addr);
+
+	void pci_pool_free(struct pci_pool *pool, void *vaddr,
+			dma_addr_t addr);
+
+This puts memory back into the pool.  The pool is what was passed to
+the the pool allocation routine; the cpu and dma addresses are what
+were returned when that routine allocated the memory being freed.
+
+
+	void dma_pool_destroy(struct dma_pool *pool);
+
+	void pci_pool_destroy(struct pci_pool *pool);
+
+The pool destroy() routines free the resources of the pool.  They must be
+called in a context which can sleep.  Make sure you've freed all allocated
+memory back to the pool before you destroy it.  While pci_pool_destroy()
+may not be called in interrupt context, it's perfectly safe to do that with
+dma_pool_destroy().
+
+
+Part Ic - DMA addressing limitations
+------------------------------------
+
 int
 dma_supported(struct device *dev, u64 mask)
 int
@@ -86,6 +164,10 @@
 
 Returns: 1 if successful and 0 if not
 
+
+Part Id - Streaming DMA mappings
+--------------------------------
+
 dma_addr_t
 dma_map_single(struct device *dev, void *cpu_addr, size_t size,
 		      enum dma_data_direction direction)
@@ -253,6 +335,7 @@
   DMA_BIDIRECTIONAL
 
 See also dma_map_single().
+
 
 Part II - Advanced dma_ usage
 -----------------------------
diff -Nru a/drivers/base/dmapool.c b/drivers/base/dmapool.c
--- a/drivers/base/dmapool.c	Mon Feb  9 14:59:04 2004
+++ b/drivers/base/dmapool.c	Mon Feb  9 14:59:04 2004
@@ -257,7 +257,7 @@
 /**
  * dma_pool_alloc - get a block of consistent memory
  * @pool: dma pool that will produce the block
- * @mem_flags: SLAB_KERNEL or SLAB_ATOMIC
+ * @mem_flags: GFP_* bitmask
  * @handle: pointer to dma address of block
  *
  * This returns the kernel virtual address of a currently unused block,
@@ -295,7 +295,7 @@
 		}
 	}
 	if (!(page = pool_alloc_page (pool, SLAB_ATOMIC))) {
-		if (mem_flags == SLAB_KERNEL) {
+		if (mem_flags & __GFP_WAIT) {
 			DECLARE_WAITQUEUE (wait, current);
 
 			current->state = TASK_INTERRUPTIBLE;
@@ -409,7 +409,7 @@
 	/*
 	 * Resist a temptation to do
 	 *    if (!is_page_busy(bpp, page->bitmap)) pool_free_page(pool, page);
-	 * it is not interrupt safe. Better have empty pages hang around.
+	 * Better have a few empty pages hang around.
 	 */
 	spin_unlock_irqrestore (&pool->lock, flags);
 }

