Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbSLaQ2D>; Tue, 31 Dec 2002 11:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbSLaQ2D>; Tue, 31 Dec 2002 11:28:03 -0500
Received: from host194.steeleye.com ([66.206.164.34]:51215 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S263313AbSLaQ1t>; Tue, 31 Dec 2002 11:27:49 -0500
Message-Id: <200212311636.gBVGa8t02091@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: David Brownell <david-b@pacbell.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic device DMA (dma_pool update) 
In-Reply-To: Message from David Brownell <david-b@pacbell.net> 
   of "Mon, 30 Dec 2002 15:11:19 PST." <3E10D297.1090206@pacbell.net> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-18983497320"
Date: Tue, 31 Dec 2002 10:36:08 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-18983497320
Content-Type: text/plain; charset=us-ascii

How about the attached as the basis for a generic coherent memory pool 
implementation.  It basically leverages pci/pool.c to be more generic, and 
thus makes use of well tested code.

Obviously, as a final tidy up, pci/pool.c should probably be moved to 
base/pool.c with compile options for drivers that want it.

James


--==_Exmh_-18983497320
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Tue Dec 31 10:33:58 2002
+++ b/drivers/base/core.c	Tue Dec 31 10:33:58 2002
@@ -146,6 +146,7 @@
 	INIT_LIST_HEAD(&dev->bus_list);
 	INIT_LIST_HEAD(&dev->class_list);
 	INIT_LIST_HEAD(&dev->intf_list);
+	INIT_LIST_HEAD(&dev->pools);
 }
 
 /**
diff -Nru a/drivers/pci/pool.c b/drivers/pci/pool.c
--- a/drivers/pci/pool.c	Tue Dec 31 10:33:58 2002
+++ b/drivers/pci/pool.c	Tue Dec 31 10:33:58 2002
@@ -1,6 +1,8 @@
-#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/types.h>
+#include <linux/blkdev.h>
+#include <linux/dma-mapping.h>
 
 /*
  * Pool allocator ... wraps the pci_alloc_consistent page allocator, so
@@ -8,19 +10,19 @@
  * This should probably be sharing the guts of the slab allocator.
  */
 
-struct pci_pool {	/* the pool */
+struct dma_pool {	/* the pool */
 	struct list_head	page_list;
 	spinlock_t		lock;
 	size_t			blocks_per_page;
 	size_t			size;
-	struct pci_dev		*dev;
+	struct device		*dev;
 	size_t			allocation;
 	char			name [32];
 	wait_queue_head_t	waitq;
 	struct list_head	pools;
 };
 
-struct pci_page {	/* cacheable header for 'allocation' bytes */
+struct dma_page {	/* cacheable header for 'allocation' bytes */
 	struct list_head	page_list;
 	void			*vaddr;
 	dma_addr_t		dma;
@@ -36,7 +38,6 @@
 static ssize_t
 show_pools (struct device *dev, char *buf, size_t count, loff_t off)
 {
-	struct pci_dev		*pdev;
 	unsigned		temp, size;
 	char			*next;
 	struct list_head	*i, *j;
@@ -44,7 +45,6 @@
 	if (off != 0)
 		return 0;
 
-	pdev = container_of (dev, struct pci_dev, dev);
 	next = buf;
 	size = count;
 
@@ -53,16 +53,16 @@
 	next += temp;
 
 	down (&pools_lock);
-	list_for_each (i, &pdev->pools) {
-		struct pci_pool	*pool;
+	list_for_each (i, &dev->pools) {
+		struct dma_pool	*pool;
 		unsigned	pages = 0, blocks = 0;
 
-		pool = list_entry (i, struct pci_pool, pools);
+		pool = list_entry (i, struct dma_pool, pools);
 
 		list_for_each (j, &pool->page_list) {
-			struct pci_page	*page;
+			struct dma_page	*page;
 
-			page = list_entry (j, struct pci_page, page_list);
+			page = list_entry (j, struct dma_page, page_list);
 			pages++;
 			blocks += page->in_use;
 		}
@@ -82,31 +82,31 @@
 static DEVICE_ATTR (pools, S_IRUGO, show_pools, NULL);
 
 /**
- * pci_pool_create - Creates a pool of pci consistent memory blocks, for dma.
+ * dma_pool_create - Creates a pool of coherent memory blocks, for dma.
  * @name: name of pool, for diagnostics
- * @pdev: pci device that will be doing the DMA
+ * @dev: device that will be doing the DMA
  * @size: size of the blocks in this pool.
  * @align: alignment requirement for blocks; must be a power of two
  * @allocation: returned blocks won't cross this boundary (or zero)
  * Context: !in_interrupt()
  *
- * Returns a pci allocation pool with the requested characteristics, or
- * null if one can't be created.  Given one of these pools, pci_pool_alloc()
+ * Returns a dma allocation pool with the requested characteristics, or
+ * null if one can't be created.  Given one of these pools, dma_pool_alloc()
  * may be used to allocate memory.  Such memory will all have "consistent"
  * DMA mappings, accessible by the device and its driver without using
  * cache flushing primitives.  The actual size of blocks allocated may be
  * larger than requested because of alignment.
  *
- * If allocation is nonzero, objects returned from pci_pool_alloc() won't
+ * If allocation is nonzero, objects returned from dma_pool_alloc() won't
  * cross that size boundary.  This is useful for devices which have
  * addressing restrictions on individual DMA transfers, such as not crossing
  * boundaries of 4KBytes.
  */
-struct pci_pool *
-pci_pool_create (const char *name, struct pci_dev *pdev,
+struct dma_pool *
+dma_pool_create (const char *name, struct device *dev,
 	size_t size, size_t align, size_t allocation)
 {
-	struct pci_pool		*retval;
+	struct dma_pool		*retval;
 
 	if (align == 0)
 		align = 1;
@@ -134,7 +134,7 @@
 	strncpy (retval->name, name, sizeof retval->name);
 	retval->name [sizeof retval->name - 1] = 0;
 
-	retval->dev = pdev;
+	retval->dev = dev;
 
 	INIT_LIST_HEAD (&retval->page_list);
 	spin_lock_init (&retval->lock);
@@ -143,12 +143,12 @@
 	retval->blocks_per_page = allocation / size;
 	init_waitqueue_head (&retval->waitq);
 
-	if (pdev) {
+	if (dev) {
 		down (&pools_lock);
-		if (list_empty (&pdev->pools))
-			device_create_file (&pdev->dev, &dev_attr_pools);
+		if (list_empty (&dev->pools))
+			device_create_file (dev, &dev_attr_pools);
 		/* note:  not currently insisting "name" be unique */
-		list_add (&retval->pools, &pdev->pools);
+		list_add (&retval->pools, &dev->pools);
 		up (&pools_lock);
 	} else
 		INIT_LIST_HEAD (&retval->pools);
@@ -157,22 +157,22 @@
 }
 
 
-static struct pci_page *
-pool_alloc_page (struct pci_pool *pool, int mem_flags)
+static struct dma_page *
+pool_alloc_page (struct dma_pool *pool, int mem_flags)
 {
-	struct pci_page	*page;
+	struct dma_page	*page;
 	int		mapsize;
 
 	mapsize = pool->blocks_per_page;
 	mapsize = (mapsize + BITS_PER_LONG - 1) / BITS_PER_LONG;
 	mapsize *= sizeof (long);
 
-	page = (struct pci_page *) kmalloc (mapsize + sizeof *page, mem_flags);
+	page = (struct dma_page *) kmalloc (mapsize + sizeof *page, mem_flags);
 	if (!page)
 		return 0;
-	page->vaddr = pci_alloc_consistent (pool->dev,
-					    pool->allocation,
-					    &page->dma);
+	page->vaddr = dma_alloc_coherent (pool->dev,
+					  pool->allocation,
+					  &page->dma);
 	if (page->vaddr) {
 		memset (page->bitmap, 0xff, mapsize);	// bit set == free
 #ifdef	CONFIG_DEBUG_SLAB
@@ -200,43 +200,43 @@
 }
 
 static void
-pool_free_page (struct pci_pool *pool, struct pci_page *page)
+pool_free_page (struct dma_pool *pool, struct dma_page *page)
 {
 	dma_addr_t	dma = page->dma;
 
 #ifdef	CONFIG_DEBUG_SLAB
 	memset (page->vaddr, POOL_POISON_BYTE, pool->allocation);
 #endif
-	pci_free_consistent (pool->dev, pool->allocation, page->vaddr, dma);
+	dma_free_coherent (pool->dev, pool->allocation, page->vaddr, dma);
 	list_del (&page->page_list);
 	kfree (page);
 }
 
 
 /**
- * pci_pool_destroy - destroys a pool of pci memory blocks.
- * @pool: pci pool that will be destroyed
+ * dma_pool_destroy - destroys a pool of dma memory blocks.
+ * @pool: dma pool that will be destroyed
  * Context: !in_interrupt()
  *
  * Caller guarantees that no more memory from the pool is in use,
  * and that nothing will try to use the pool after this call.
  */
 void
-pci_pool_destroy (struct pci_pool *pool)
+dma_pool_destroy (struct dma_pool *pool)
 {
 	down (&pools_lock);
 	list_del (&pool->pools);
 	if (pool->dev && list_empty (&pool->dev->pools))
-		device_remove_file (&pool->dev->dev, &dev_attr_pools);
+		device_remove_file (pool->dev, &dev_attr_pools);
 	up (&pools_lock);
 
 	while (!list_empty (&pool->page_list)) {
-		struct pci_page		*page;
+		struct dma_page		*page;
 		page = list_entry (pool->page_list.next,
-				struct pci_page, page_list);
+				struct dma_page, page_list);
 		if (is_page_busy (pool->blocks_per_page, page->bitmap)) {
-			printk (KERN_ERR "pci_pool_destroy %s/%s, %p busy\n",
-				pool->dev ? pool->dev->slot_name : NULL,
+			printk (KERN_ERR "dma_pool_destroy %s/%s, %p busy\n",
+				pool->dev ? pool->dev->name : NULL,
 				pool->name, page->vaddr);
 			/* leak the still-in-use consistent memory */
 			list_del (&page->page_list);
@@ -250,8 +250,8 @@
 
 
 /**
- * pci_pool_alloc - get a block of consistent memory
- * @pool: pci pool that will produce the block
+ * dma_pool_alloc - get a block of consistent memory
+ * @pool: dma pool that will produce the block
  * @mem_flags: SLAB_KERNEL or SLAB_ATOMIC
  * @handle: pointer to dma address of block
  *
@@ -260,11 +260,11 @@
  * If such a memory block can't be allocated, null is returned.
  */
 void *
-pci_pool_alloc (struct pci_pool *pool, int mem_flags, dma_addr_t *handle)
+dma_pool_alloc (struct dma_pool *pool, int mem_flags, dma_addr_t *handle)
 {
 	unsigned long		flags;
 	struct list_head	*entry;
-	struct pci_page		*page;
+	struct dma_page		*page;
 	int			map, block;
 	size_t			offset;
 	void			*retval;
@@ -273,7 +273,7 @@
 	spin_lock_irqsave (&pool->lock, flags);
 	list_for_each (entry, &pool->page_list) {
 		int		i;
-		page = list_entry (entry, struct pci_page, page_list);
+		page = list_entry (entry, struct dma_page, page_list);
 		/* only cachable accesses here ... */
 		for (map = 0, i = 0;
 				i < pool->blocks_per_page;
@@ -319,16 +319,16 @@
 }
 
 
-static struct pci_page *
-pool_find_page (struct pci_pool *pool, dma_addr_t dma)
+static struct dma_page *
+pool_find_page (struct dma_pool *pool, dma_addr_t dma)
 {
 	unsigned long		flags;
 	struct list_head	*entry;
-	struct pci_page		*page;
+	struct dma_page		*page;
 
 	spin_lock_irqsave (&pool->lock, flags);
 	list_for_each (entry, &pool->page_list) {
-		page = list_entry (entry, struct pci_page, page_list);
+		page = list_entry (entry, struct dma_page, page_list);
 		if (dma < page->dma)
 			continue;
 		if (dma < (page->dma + pool->allocation))
@@ -342,8 +342,8 @@
 
 
 /**
- * pci_pool_free - put block back into pci pool
- * @pool: the pci pool holding the block
+ * dma_pool_free - put block back into dma pool
+ * @pool: the dma pool holding the block
  * @vaddr: virtual address of block
  * @dma: dma address of block
  *
@@ -351,15 +351,15 @@
  * unless it is first re-allocated.
  */
 void
-pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t dma)
+dma_pool_free (struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 {
-	struct pci_page		*page;
+	struct dma_page		*page;
 	unsigned long		flags;
 	int			map, block;
 
 	if ((page = pool_find_page (pool, dma)) == 0) {
-		printk (KERN_ERR "pci_pool_free %s/%s, %p/%lx (bad dma)\n",
-			pool->dev ? pool->dev->slot_name : NULL,
+		printk (KERN_ERR "dma_pool_free %s/%s, %p/%lx (bad dma)\n",
+			pool->dev ? pool->dev->name : NULL,
 			pool->name, vaddr, (unsigned long) dma);
 		return;
 	}
@@ -371,13 +371,13 @@
 
 #ifdef	CONFIG_DEBUG_SLAB
 	if (((dma - page->dma) + (void *)page->vaddr) != vaddr) {
-		printk (KERN_ERR "pci_pool_free %s/%s, %p (bad vaddr)/%Lx\n",
+		printk (KERN_ERR "dma_pool_free %s/%s, %p (bad vaddr)/%Lx\n",
 			pool->dev ? pool->dev->slot_name : NULL,
 			pool->name, vaddr, (unsigned long long) dma);
 		return;
 	}
 	if (page->bitmap [map] & (1UL << block)) {
-		printk (KERN_ERR "pci_pool_free %s/%s, dma %Lx already free\n",
+		printk (KERN_ERR "dma_pool_free %s/%s, dma %Lx already free\n",
 			pool->dev ? pool->dev->slot_name : NULL,
 			pool->name, (unsigned long long)dma);
 		return;
@@ -399,7 +399,7 @@
 }
 
 
-EXPORT_SYMBOL (pci_pool_create);
-EXPORT_SYMBOL (pci_pool_destroy);
-EXPORT_SYMBOL (pci_pool_alloc);
-EXPORT_SYMBOL (pci_pool_free);
+EXPORT_SYMBOL (dma_pool_create);
+EXPORT_SYMBOL (dma_pool_destroy);
+EXPORT_SYMBOL (dma_pool_alloc);
+EXPORT_SYMBOL (dma_pool_free);
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Tue Dec 31 10:33:58 2002
+++ b/drivers/pci/probe.c	Tue Dec 31 10:33:58 2002
@@ -353,8 +353,6 @@
 
 	sprintf(dev->slot_name, "%02x:%02x.%d", dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
 	sprintf(dev->dev.name, "PCI device %04x:%04x", dev->vendor, dev->device);
-	INIT_LIST_HEAD(&dev->pools);
-	
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
 	class >>= 8;				    /* upper 3 bytes */
 	dev->class = class;
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Tue Dec 31 10:33:58 2002
+++ b/include/linux/device.h	Tue Dec 31 10:33:58 2002
@@ -256,6 +256,8 @@
 	struct list_head driver_list;
 	struct list_head children;
 	struct list_head intf_list;
+	struct list_head pools;		/* dma_pools tied to this device */
+
 	struct device 	* parent;
 
 	struct kobject kobj;
diff -Nru a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
--- a/include/linux/dma-mapping.h	Tue Dec 31 10:33:58 2002
+++ b/include/linux/dma-mapping.h	Tue Dec 31 10:33:58 2002
@@ -1,6 +1,8 @@
 #ifndef _ASM_LINUX_DMA_MAPPING_H
 #define _ASM_LINUX_DMA_MAPPING_H
 
+#include <linux/dma-pool.h>
+
 /* These definitions mirror those in pci.h, so they can be used
  * interchangeably with their PCI_ counterparts */
 enum dma_data_direction {
diff -Nru a/include/linux/dma-pool.h b/include/linux/dma-pool.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/dma-pool.h	Tue Dec 31 10:33:58 2002
@@ -0,0 +1,15 @@
+#ifndef _LINUX_DMA_POOL_H
+#define _LINUX_DMA_POOL_H
+
+#include <linux/device.h>
+
+/* dma_pool is an opaque structure pointer */
+struct dma_pool;
+
+struct dma_pool *dma_pool_create(const char *name, struct device *dev,
+				 size_t size, size_t align, size_t allocation);
+void dma_pool_destroy(struct dma_pool *pool);
+void *dma_pool_alloc(struct dma_pool *pool, int flags, dma_addr_t *handle);
+void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t addr);
+
+#endif
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Tue Dec 31 10:33:58 2002
+++ b/include/linux/pci.h	Tue Dec 31 10:33:58 2002
@@ -388,8 +388,6 @@
 					   0xffffffff.  You only need to change
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */
-	struct list_head pools;		/* pci_pools tied to this device */
-
 	u32             current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
@@ -658,14 +656,38 @@
 unsigned int pci_do_scan_bus(struct pci_bus *bus);
 struct pci_bus * pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr);
 int pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass);
+#include <linux/dma-pool.h>
 
 /* kmem_cache style wrapper around pci_alloc_consistent() */
-struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
-		size_t size, size_t align, size_t allocation);
-void pci_pool_destroy (struct pci_pool *pool);
 
-void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
-void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
+/* struct pci_pool is an alias for struct dma_pool.  However, its contents
+ * are never exposed so just declare it here */
+struct pci_pool;
+
+static inline struct pci_pool *
+pci_pool_create (const char *name, struct pci_dev *dev,
+		size_t size, size_t align, size_t allocation)
+{
+	return (struct pci_pool *)dma_pool_create(name, &dev->dev, size, align, allocation);
+}
+
+static inline void
+pci_pool_destroy(struct pci_pool *pool)
+{
+	dma_pool_destroy((struct dma_pool *)pool);
+}
+
+static inline void *
+pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle)
+{
+	return dma_pool_alloc((struct dma_pool *)pool, flags, handle);
+}
+
+static inline void
+pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr)
+{
+	dma_pool_free((struct dma_pool *)pool, vaddr, addr);
+}
 
 #if defined(CONFIG_ISA) || defined(CONFIG_EISA)
 extern struct pci_dev *isa_bridge;

--==_Exmh_-18983497320--


