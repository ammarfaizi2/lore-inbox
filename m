Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVBOWsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVBOWsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVBOWsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:48:01 -0500
Received: from scrat.cs.umu.se ([130.239.40.18]:36528 "EHLO scrat.cs.umu.se")
	by vger.kernel.org with ESMTP id S261933AbVBOWqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:46:06 -0500
Date: Tue, 15 Feb 2005 23:45:53 +0100
From: Peter Hagervall <hager@cs.umu.se>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] Kill some sparse warnings
Message-ID: <20050215224553.GA24630@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaned up some address space issues in:

arch/i386(kernel/pci-dma.c
drivers/base/dmapool.c
fs/proc/base.c
include/asm-generic/pci-dma-compat.h
include/linux/dmapool.h
kernel/stop_machine.c

Signed-off-by: Peter Hagervall <hager@cs.umu.se>



===== arch/i386/kernel/pci-dma.c 1.19 vs edited =====
--- 1.19/arch/i386/kernel/pci-dma.c	2005-02-12 02:33:28 +01:00
+++ edited/arch/i386/kernel/pci-dma.c	2005-02-15 18:24:02 +01:00
@@ -14,17 +14,17 @@
 #include <asm/io.h>
 
 struct dma_coherent_mem {
-	void		*virt_base;
+	void	__iomem *virt_base;
 	u32		device_base;
 	int		size;
 	int		flags;
 	unsigned long	*bitmap;
 };
 
-void *dma_alloc_coherent(struct device *dev, size_t size,
+void __iomem *dma_alloc_coherent(struct device *dev, size_t size,
 			   dma_addr_t *dma_handle, int gfp)
 {
-	void *ret;
+	void __iomem *ret;
 	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
 	int order = get_order(size);
 	/* ignore region specifiers */
@@ -36,7 +36,7 @@
 		if (page >= 0) {
 			*dma_handle = mem->device_base + (page << PAGE_SHIFT);
 			ret = mem->virt_base + (page << PAGE_SHIFT);
-			memset(ret, 0, size);
+			memset((void __force *)ret, 0, size);
 			return ret;
 		}
 		if (mem->flags & DMA_MEMORY_EXCLUSIVE)
@@ -46,17 +46,17 @@
 	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
 		gfp |= GFP_DMA;
 
-	ret = (void *)__get_free_pages(gfp, order);
+	ret = (void __iomem *)__get_free_pages(gfp, order);
 
 	if (ret != NULL) {
-		memset(ret, 0, size);
-		*dma_handle = virt_to_phys(ret);
+		memset((void __force *)ret, 0, size);
+		*dma_handle = virt_to_phys((volatile void __force *)ret);
 	}
 	return ret;
 }
 
 void dma_free_coherent(struct device *dev, size_t size,
-			 void *vaddr, dma_addr_t dma_handle)
+			 void __iomem *vaddr, dma_addr_t dma_handle)
 {
 	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
 	int order = get_order(size);
@@ -128,7 +128,7 @@
 }
 EXPORT_SYMBOL(dma_release_declared_memory);
 
-void *dma_mark_declared_memory_occupied(struct device *dev,
+void __iomem *dma_mark_declared_memory_occupied(struct device *dev,
 					dma_addr_t device_addr, size_t size)
 {
 	struct dma_coherent_mem *mem = dev->dma_mem;
@@ -136,12 +136,12 @@
 	int pos, err;
 
 	if (!mem)
-		return ERR_PTR(-EINVAL);
+		return (void __iomem *)ERR_PTR(-EINVAL);
 
 	pos = (device_addr - mem->device_base) >> PAGE_SHIFT;
 	err = bitmap_allocate_region(mem->bitmap, pos, get_order(pages));
 	if (err != 0)
-		return ERR_PTR(err);
+		return (void __iomem *)ERR_PTR(err);
 	return mem->virt_base + (pos << PAGE_SHIFT);
 }
 EXPORT_SYMBOL(dma_mark_declared_memory_occupied);
===== drivers/base/dmapool.c 1.22 vs edited =====
--- 1.22/drivers/base/dmapool.c	2004-06-30 17:57:24 +02:00
+++ edited/drivers/base/dmapool.c	2005-02-15 23:13:07 +01:00
@@ -28,7 +28,7 @@
 
 struct dma_page {	/* cacheable header for 'allocation' bytes */
 	struct list_head	page_list;
-	void			*vaddr;
+	void __iomem		*vaddr;
 	dma_addr_t		dma;
 	unsigned		in_use;
 	unsigned long		bitmap [0];
@@ -175,7 +175,7 @@
 	if (page->vaddr) {
 		memset (page->bitmap, 0xff, mapsize);	// bit set == free
 #ifdef	CONFIG_DEBUG_SLAB
-		memset (page->vaddr, POOL_POISON_FREED, pool->allocation);
+		memset ((void __force *)page->vaddr, POOL_POISON_FREED, pool->allocation);
 #endif
 		list_add (&page->page_list, &pool->page_list);
 		page->in_use = 0;
@@ -204,7 +204,7 @@
 	dma_addr_t	dma = page->dma;
 
 #ifdef	CONFIG_DEBUG_SLAB
-	memset (page->vaddr, POOL_POISON_FREED, pool->allocation);
+	memset ((void __force *)page->vaddr, POOL_POISON_FREED, pool->allocation);
 #endif
 	dma_free_coherent (pool->dev, pool->allocation, page->vaddr, dma);
 	list_del (&page->page_list);
@@ -261,14 +261,14 @@
  * and reports its dma address through the handle.
  * If such a memory block can't be allocated, null is returned.
  */
-void *
+void __iomem *
 dma_pool_alloc (struct dma_pool *pool, int mem_flags, dma_addr_t *handle)
 {
 	unsigned long		flags;
 	struct dma_page		*page;
 	int			map, block;
 	size_t			offset;
-	void			*retval;
+	void __iomem		*retval;
 
 restart:
 	spin_lock_irqsave (&pool->lock, flags);
@@ -313,7 +313,7 @@
 	retval = offset + page->vaddr;
 	*handle = offset + page->dma;
 #ifdef	CONFIG_DEBUG_SLAB
-	memset (retval, POOL_POISON_ALLOCATED, pool->size);
+	memset ((void __force *)retval, POOL_POISON_ALLOCATED, pool->size);
 #endif
 done:
 	spin_unlock_irqrestore (&pool->lock, flags);
@@ -351,7 +351,7 @@
  * unless it is first re-allocated.
  */
 void
-dma_pool_free (struct dma_pool *pool, void *vaddr, dma_addr_t dma)
+dma_pool_free (struct dma_pool *pool, void __iomem *vaddr, dma_addr_t dma)
 {
 	struct dma_page		*page;
 	unsigned long		flags;
@@ -373,7 +373,7 @@
 	block %= BITS_PER_LONG;
 
 #ifdef	CONFIG_DEBUG_SLAB
-	if (((dma - page->dma) + (void *)page->vaddr) != vaddr) {
+	if (((dma - page->dma) + page->vaddr) != vaddr) {
 		if (pool->dev)
 			dev_err(pool->dev, "dma_pool_free %s, %p (bad vaddr)/%Lx\n",
 				pool->name, vaddr, (unsigned long long) dma);
@@ -391,7 +391,7 @@
 				pool->name, (unsigned long long)dma);
 		return;
 	}
-	memset (vaddr, POOL_POISON_FREED, pool->size);
+	memset ((void __force *)vaddr, POOL_POISON_FREED, pool->size);
 #endif
 
 	spin_lock_irqsave (&pool->lock, flags);
===== fs/proc/base.c 1.88 vs edited =====
--- 1.88/fs/proc/base.c	2005-01-31 07:33:47 +01:00
+++ edited/fs/proc/base.c	2005-02-15 16:50:53 +01:00
@@ -689,7 +689,7 @@
 	.open		= mem_open,
 };
 
-static ssize_t oom_adjust_read(struct file *file, char *buf,
+static ssize_t oom_adjust_read(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	struct task_struct *task = proc_task(file->f_dentry->d_inode);
@@ -709,7 +709,7 @@
 	return count;
 }
 
-static ssize_t oom_adjust_write(struct file *file, const char *buf,
+static ssize_t oom_adjust_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	struct task_struct *task = proc_task(file->f_dentry->d_inode);
@@ -735,8 +735,8 @@
 }
 
 static struct file_operations proc_oom_adjust_operations = {
-	read:		oom_adjust_read,
-	write:		oom_adjust_write,
+	.read		= oom_adjust_read,
+	.write		= oom_adjust_write,
 };
 
 static struct inode_operations proc_mem_inode_operations = {
===== include/asm-generic/pci-dma-compat.h 1.6 vs edited =====
--- 1.6/include/asm-generic/pci-dma-compat.h	2004-03-23 19:12:38 +01:00
+++ edited/include/asm-generic/pci-dma-compat.h	2005-02-15 19:22:15 +01:00
@@ -15,7 +15,7 @@
 	return dma_supported(hwdev == NULL ? NULL : &hwdev->dev, mask);
 }
 
-static inline void *
+static inline void __iomem *
 pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
 		     dma_addr_t *dma_handle)
 {
@@ -24,7 +24,7 @@
 
 static inline void
 pci_free_consistent(struct pci_dev *hwdev, size_t size,
-		    void *vaddr, dma_addr_t dma_handle)
+		    void __iomem *vaddr, dma_addr_t dma_handle)
 {
 	dma_free_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, vaddr, dma_handle);
 }
===== include/linux/dmapool.h 1.1 vs edited =====
--- 1.1/include/linux/dmapool.h	2004-01-30 13:20:30 +01:00
+++ edited/include/linux/dmapool.h	2005-02-15 23:11:33 +01:00
@@ -19,9 +19,9 @@
 
 void dma_pool_destroy(struct dma_pool *pool);
 
-void *dma_pool_alloc(struct dma_pool *pool, int mem_flags, dma_addr_t *handle);
+void __iomem *dma_pool_alloc(struct dma_pool *pool, int mem_flags, dma_addr_t *handle);
 
-void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t addr);
+void dma_pool_free(struct dma_pool *pool, void __iomem *vaddr, dma_addr_t addr);
 
 #endif
 
===== kernel/stop_machine.c 1.6 vs edited =====
--- 1.6/kernel/stop_machine.c	2005-01-08 06:44:05 +01:00
+++ edited/kernel/stop_machine.c	2005-02-15 22:20:08 +01:00
@@ -85,7 +85,7 @@
 static int stop_machine(void)
 {
 	int i, ret = 0;
-	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
+	struct sched_param __user param = { .sched_priority = MAX_RT_PRIO-1 };
 
 	/* One high-prio thread per cpu.  We'll do this one. */
 	sys_sched_setscheduler(current->pid, SCHED_FIFO, &param);



-- 
Peter Hagervall <hager@cs.umu.se>
