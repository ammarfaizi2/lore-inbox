Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbTEJJ5F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 05:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTEJJ5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 05:57:05 -0400
Received: from palrel11.hp.com ([156.153.255.246]:47004 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263740AbTEJJ4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 05:56:38 -0400
Date: Sat, 10 May 2003 03:09:16 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Improved DRM support for cant_use_aperture platforms
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

This patch is rather big, but actually very straight-forward: it adds
a "agp dev" argument to DRM_IOREMAP(), DRM_IOREMAP_NOCACHE(), and
DRM_IOREMAPFREE() and then uses it in drm_memory.h to support
platforms where CPU accesses to the AGP space are not translated by
the GART (true for ia64 and alpha, not true for x86, I don't know
about the other platforms).  On platforms where cant_use_aperture is
always false, this whole patch will look like a no-op.  On ia64, it
works.  Don't know about other platforms, but it should simplify
things for Alpha at least (and if it breaks a platform, I shall be
happy to work with the respective maintainer to get fix back to
working).

Thanks,

	--david

diff -Nru a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
--- a/drivers/char/drm/drmP.h	Sat May 10 01:47:43 2003
+++ b/drivers/char/drm/drmP.h	Sat May 10 01:47:43 2003
@@ -225,16 +225,16 @@
    if (len > DRM_PROC_LIMIT) { ret; *eof = 1; return len - offset; }
 
 				/* Mapping helper macros */
-#define DRM_IOREMAP(map)						\
-	(map)->handle = DRM(ioremap)( (map)->offset, (map)->size )
+#define DRM_IOREMAP(map, dev)							\
+	(map)->handle = DRM(ioremap)( (map)->offset, (map)->size, (dev) )
 
-#define DRM_IOREMAP_NOCACHE(map)					\
-	(map)->handle = DRM(ioremap_nocache)((map)->offset, (map)->size)
+#define DRM_IOREMAP_NOCACHE(map, dev)						\
+	(map)->handle = DRM(ioremap_nocache)((map)->offset, (map)->size, (dev))
 
-#define DRM_IOREMAPFREE(map)						\
-	do {								\
-		if ( (map)->handle && (map)->size )			\
-			DRM(ioremapfree)( (map)->handle, (map)->size );	\
+#define DRM_IOREMAPFREE(map, dev)							\
+	do {									\
+		if ( (map)->handle && (map)->size )				\
+			DRM(ioremapfree)( (map)->handle, (map)->size, (dev) );	\
 	} while (0)
 
 #define DRM_FIND_MAP(_map, _o)								\
@@ -652,9 +652,10 @@
 extern unsigned long DRM(alloc_pages)(int order, int area);
 extern void	     DRM(free_pages)(unsigned long address, int order,
 				     int area);
-extern void	     *DRM(ioremap)(unsigned long offset, unsigned long size);
-extern void	     *DRM(ioremap_nocache)(unsigned long offset, unsigned long size);
-extern void	     DRM(ioremapfree)(void *pt, unsigned long size);
+extern void	     *DRM(ioremap)(unsigned long offset, unsigned long size, drm_device_t *dev);
+extern void	     *DRM(ioremap_nocache)(unsigned long offset, unsigned long size,
+					   drm_device_t *dev);
+extern void	     DRM(ioremapfree)(void *pt, unsigned long size, drm_device_t *dev);
 
 #if __REALLY_HAVE_AGP
 extern agp_memory    *DRM(alloc_agp)(int pages, u32 type);
diff -Nru a/drivers/char/drm/drm_bufs.h b/drivers/char/drm/drm_bufs.h
--- a/drivers/char/drm/drm_bufs.h	Sat May 10 01:47:43 2003
+++ b/drivers/char/drm/drm_bufs.h	Sat May 10 01:47:43 2003
@@ -123,7 +123,7 @@
 					      MTRR_TYPE_WRCOMB, 1 );
 		}
 #endif
-		map->handle = DRM(ioremap)( map->offset, map->size );
+		map->handle = DRM(ioremap)( map->offset, map->size, dev );
 		break;
 
 	case _DRM_SHM:
@@ -245,7 +245,7 @@
 				DRM_DEBUG("mtrr_del = %d\n", retcode);
 			}
 #endif
-			DRM(ioremapfree)(map->handle, map->size);
+			DRM(ioremapfree)(map->handle, map->size, dev);
 			break;
 		case _DRM_SHM:
 			vfree(map->handle);
diff -Nru a/drivers/char/drm/drm_drv.h b/drivers/char/drm/drm_drv.h
--- a/drivers/char/drm/drm_drv.h	Sat May 10 01:47:43 2003
+++ b/drivers/char/drm/drm_drv.h	Sat May 10 01:47:43 2003
@@ -454,7 +454,7 @@
 					DRM_DEBUG( "mtrr_del=%d\n", retcode );
 				}
 #endif
-				DRM(ioremapfree)( map->handle, map->size );
+				DRM(ioremapfree)( map->handle, map->size, dev );
 				break;
 			case _DRM_SHM:
 				vfree(map->handle);
diff -Nru a/drivers/char/drm/drm_memory.h b/drivers/char/drm/drm_memory.h
--- a/drivers/char/drm/drm_memory.h	Sat May 10 01:47:42 2003
+++ b/drivers/char/drm/drm_memory.h	Sat May 10 01:47:43 2003
@@ -31,6 +31,10 @@
 
 #include <linux/config.h>
 #include "drmP.h"
+#include <linux/vmalloc.h>
+
+#include <asm/agp.h>
+#include <asm/tlbflush.h>
 
 /* Cut down version of drm_memory_debug.h, which used to be called
  * drm_memory.h.  If you want the debug functionality, change 0 to 1
@@ -38,6 +42,150 @@
  */
 #define DEBUG_MEMORY 0
 
+#if __REALLY_HAVE_AGP
+
+/*
+ * Find the drm_map that covers the range [offset, offset+size).
+ */
+static inline drm_map_t *
+drm_lookup_map (unsigned long offset, unsigned long size, drm_device_t *dev)
+{
+	struct list_head *list;
+	drm_map_list_t *r_list;
+	drm_map_t *map;
+
+	list_for_each(list, &dev->maplist->head) {
+		r_list = (drm_map_list_t *) list;
+		map = r_list->map;
+		if (!map)
+			continue;
+		if (map->offset <= offset && (offset + size) <= (map->offset + map->size))
+			return map;
+	}
+	return NULL;
+}
+
+static inline void *
+agp_remap (unsigned long offset, unsigned long size, drm_device_t *dev)
+{
+	unsigned long *phys_addr_map, i, num_pages = PAGE_ALIGN(size) / PAGE_SIZE;
+	struct drm_agp_mem *agpmem;
+	struct page **page_map;
+	void *addr;
+
+	size = PAGE_ALIGN(size);
+
+	for (agpmem = dev->agp->memory; agpmem; agpmem = agpmem->next)
+		if (agpmem->bound <= offset
+		    && (agpmem->bound + (agpmem->pages << PAGE_SHIFT)) >= (offset + size))
+			break;
+	if (!agpmem)
+		return NULL;
+
+	/*
+	 * OK, we're mapping AGP space on a chipset/platform on which memory accesses by
+	 * the CPU do not get remapped by the GART.  We fix this by using the kernel's
+	 * page-table instead (that's probably faster anyhow...).
+	 */
+	/* note: use vmalloc() because num_pages could be large... */
+	page_map = vmalloc(num_pages * sizeof(struct page *));
+	if (!page_map)
+		return NULL;
+
+	phys_addr_map = agpmem->memory->memory + (offset - agpmem->bound) / PAGE_SIZE;
+	for (i = 0; i < num_pages; ++i)
+		page_map[i] = pfn_to_page(phys_addr_map[i] >> PAGE_SHIFT);
+	addr = vmap(page_map, num_pages, VM_IOREMAP, PAGE_AGP);
+	vfree(page_map);
+	if (!addr)
+		return NULL;
+
+	flush_tlb_kernel_range((unsigned long) addr, (unsigned long) addr + size);
+	return addr;
+}
+
+static inline unsigned long
+drm_follow_page (void *vaddr)
+{
+	pgd_t *pgd = pgd_offset_k((unsigned long) vaddr);
+	pmd_t *pmd = pmd_offset(pgd, (unsigned long) vaddr);
+	pte_t *ptep = pte_offset_kernel(pmd, (unsigned long) vaddr);
+	return pte_pfn(*ptep) << PAGE_SHIFT;
+}
+
+#else /* !__REALLY_HAVE_AGP */
+
+static inline void *
+agp_remap (unsigned long offset, unsigned long size, drm_device_t *dev)
+{
+	return NULL;
+}
+
+#endif /* !__REALLY_HAVE_AGP */
+
+static inline void *drm_ioremap(unsigned long offset, unsigned long size, drm_device_t *dev)
+{
+	int remap_aperture = 0;
+
+#if __REALLY_HAVE_AGP
+	if (dev->agp->cant_use_aperture) {
+		drm_map_t *map = drm_lookup_map(offset, size, dev);
+
+		if (map && map->type == _DRM_AGP)
+			remap_aperture = 1;
+	}
+#endif
+	if (remap_aperture)
+		return agp_remap(offset, size, dev);
+ 	else
+		return ioremap(offset, size);
+}
+
+static inline void *drm_ioremap_nocache(unsigned long offset, unsigned long size,
+					drm_device_t *dev)
+{
+	int remap_aperture = 0;
+
+#if __REALLY_HAVE_AGP
+	if (dev->agp->cant_use_aperture) {
+		drm_map_t *map = drm_lookup_map(offset, size, dev);
+
+		if (map && map->type == _DRM_AGP)
+			remap_aperture = 1;
+	}
+#endif
+	if (remap_aperture)
+		return agp_remap(offset, size, dev);
+	else
+		return ioremap_nocache(offset, size);
+}
+
+static inline void drm_ioremapfree(void *pt, unsigned long size, drm_device_t *dev)
+{
+	int unmap_aperture = 0;
+#if __REALLY_HAVE_AGP
+	/*
+	 * This is a bit ugly.  It would be much cleaner if the DRM API would use separate
+	 * routines for handling mappings in the AGP space.  Hopefully this can be done in
+	 * a future revision of the interface...
+	 */
+	if (dev->agp->cant_use_aperture
+	    && ((unsigned long) pt >= VMALLOC_START && (unsigned long) pt < VMALLOC_END))
+	{
+		unsigned long offset;
+		drm_map_t *map;
+
+		offset = drm_follow_page(pt) | ((unsigned long) pt & ~PAGE_MASK);
+		map = drm_lookup_map(offset, size, dev);
+		if (map && map->type == _DRM_AGP)
+			unmap_aperture = 1;
+	}
+#endif
+	if (unmap_aperture)
+		vunmap(pt);
+	else
+		iounmap(pt);
+}
 
 #if DEBUG_MEMORY
 #include "drm_memory_debug.h"
@@ -118,19 +266,19 @@
 	free_pages(address, order);
 }
 
-void *DRM(ioremap)(unsigned long offset, unsigned long size)
+void *DRM(ioremap)(unsigned long offset, unsigned long size, drm_device_t *dev)
 {
-	return ioremap(offset, size);
+	return drm_ioremap(offset, size, dev);
 }
 
-void *DRM(ioremap_nocache)(unsigned long offset, unsigned long size)
+void *DRM(ioremap_nocache)(unsigned long offset, unsigned long size, drm_device_t *dev)
 {
-	return ioremap_nocache(offset, size);
+	return drm_ioremap_nocache(offset, size, dev);
 }
 
-void DRM(ioremapfree)(void *pt, unsigned long size)
+void DRM(ioremapfree)(void *pt, unsigned long size, drm_device_t *dev)
 {
-	iounmap(pt);
+	drm_ioremapfree(pt, size, dev);
 }
 
 #if __REALLY_HAVE_AGP
diff -Nru a/drivers/char/drm/drm_memory_debug.h b/drivers/char/drm/drm_memory_debug.h
--- a/drivers/char/drm/drm_memory_debug.h	Sat May 10 01:47:42 2003
+++ b/drivers/char/drm/drm_memory_debug.h	Sat May 10 01:47:42 2003
@@ -269,7 +269,7 @@
 	}
 }
 
-void *DRM(ioremap)(unsigned long offset, unsigned long size)
+void *DRM(ioremap)(unsigned long offset, unsigned long size, drm_device_t *dev)
 {
 	void *pt;
 
@@ -279,7 +279,7 @@
 		return NULL;
 	}
 
-	if (!(pt = ioremap(offset, size))) {
+	if (!(pt = drm_ioremap(offset, size, dev))) {
 		spin_lock(&DRM(mem_lock));
 		++DRM(mem_stats)[DRM_MEM_MAPPINGS].fail_count;
 		spin_unlock(&DRM(mem_lock));
@@ -292,7 +292,7 @@
 	return pt;
 }
 
-void *DRM(ioremap_nocache)(unsigned long offset, unsigned long size)
+void *DRM(ioremap_nocache)(unsigned long offset, unsigned long size, drm_device_t *dev)
 {
 	void *pt;
 
@@ -302,7 +302,7 @@
 		return NULL;
 	}
 
-	if (!(pt = ioremap_nocache(offset, size))) {
+	if (!(pt = drm_ioremap_nocache(offset, size, dev))) {
 		spin_lock(&DRM(mem_lock));
 		++DRM(mem_stats)[DRM_MEM_MAPPINGS].fail_count;
 		spin_unlock(&DRM(mem_lock));
@@ -315,7 +315,7 @@
 	return pt;
 }
 
-void DRM(ioremapfree)(void *pt, unsigned long size)
+void DRM(ioremapfree)(void *pt, unsigned long size, drm_device_t *dev)
 {
 	int alloc_count;
 	int free_count;
@@ -324,7 +324,7 @@
 		DRM_MEM_ERROR(DRM_MEM_MAPPINGS,
 			      "Attempt to free NULL pointer\n");
 	else
-		iounmap(pt);
+		drm_ioremapfree(pt, size, dev);
 
 	spin_lock(&DRM(mem_lock));
 	DRM(mem_stats)[DRM_MEM_MAPPINGS].bytes_freed += size;
diff -Nru a/drivers/char/drm/drm_vm.h b/drivers/char/drm/drm_vm.h
--- a/drivers/char/drm/drm_vm.h	Sat May 10 01:47:43 2003
+++ b/drivers/char/drm/drm_vm.h	Sat May 10 01:47:43 2003
@@ -107,12 +107,12 @@
                  * Get the page, inc the use count, and return it
                  */
 		offset = (baddr - agpmem->bound) >> PAGE_SHIFT;
-		agpmem->memory->memory[offset] &= dev->agp->page_mask;
 		page = virt_to_page(__va(agpmem->memory->memory[offset]));
 		get_page(page);
 
-		DRM_DEBUG("baddr = 0x%lx page = 0x%p, offset = 0x%lx\n",
-			  baddr, __va(agpmem->memory->memory[offset]), offset);
+		DRM_DEBUG("baddr = 0x%lx page = 0x%p, offset = 0x%lx, count=%d\n",
+			  baddr, __va(agpmem->memory->memory[offset]), offset,
+			  atomic_read(&page->count));
 
 		return page;
         }
@@ -206,7 +206,7 @@
 					DRM_DEBUG("mtrr_del = %d\n", retcode);
 				}
 #endif
-				DRM(ioremapfree)(map->handle, map->size);
+				DRM(ioremapfree)(map->handle, map->size, dev);
 				break;
 			case _DRM_SHM:
 				vfree(map->handle);
@@ -420,15 +420,16 @@
 
 	switch (map->type) {
         case _DRM_AGP:
-#if defined(__alpha__)
+#if __REALLY_HAVE_AGP
+	  if (dev->agp->cant_use_aperture) {
                 /*
-                 * On Alpha we can't talk to bus dma address from the
-                 * CPU, so for memory of type DRM_AGP, we'll deal with
-                 * sorting out the real physical pages and mappings
-                 * in nopage()
+                 * On some platforms we can't talk to bus dma address from the CPU, so for
+                 * memory of type DRM_AGP, we'll deal with sorting out the real physical
+                 * pages and mappings in nopage()
                  */
                 vma->vm_ops = &DRM(vm_ops);
                 break;
+	  }
 #endif
                 /* fall through to _DRM_FRAME_BUFFER... */        
 	case _DRM_FRAME_BUFFER:
@@ -439,15 +440,15 @@
 				pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
 				pgprot_val(vma->vm_page_prot) &= ~_PAGE_PWT;
 			}
-#elif defined(__ia64__)
-			if (map->type != _DRM_AGP)
-				vma->vm_page_prot =
-					pgprot_writecombine(vma->vm_page_prot);
 #elif defined(__powerpc__)
 			pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE | _PAGE_GUARDED;
 #endif
 			vma->vm_flags |= VM_IO;	/* not in core dump */
 		}
+#if defined(__ia64__)
+		if (map->type != _DRM_AGP)
+			vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+#endif
 		offset = DRIVER_GET_REG_OFS();
 #ifdef __sparc__
 		if (io_remap_page_range(DRM_RPR_ARG(vma) vma->vm_start,
diff -Nru a/drivers/char/drm/gamma_dma.c b/drivers/char/drm/gamma_dma.c
--- a/drivers/char/drm/gamma_dma.c	Sat May 10 01:47:43 2003
+++ b/drivers/char/drm/gamma_dma.c	Sat May 10 01:47:43 2003
@@ -612,7 +612,7 @@
 	} else {
 		DRM_FIND_MAP( dev_priv->buffers, init->buffers_offset );
 
-		DRM_IOREMAP( dev_priv->buffers );
+		DRM_IOREMAP( dev_priv->buffers, dev );
 
 		buf = dma->buflist[GLINT_DRI_BUF_COUNT];
 		pgt = buf->address;
@@ -651,7 +651,7 @@
 		drm_gamma_private_t *dev_priv = dev->dev_private;
 
 		if ( dev_priv->buffers != NULL )
-			DRM_IOREMAPFREE( dev_priv->buffers );
+			DRM_IOREMAPFREE( dev_priv->buffers, dev );
 
 		DRM(free)( dev->dev_private, sizeof(drm_gamma_private_t),
 			   DRM_MEM_DRIVER );
diff -Nru a/drivers/char/drm/i810_dma.c b/drivers/char/drm/i810_dma.c
--- a/drivers/char/drm/i810_dma.c	Sat May 10 01:47:43 2003
+++ b/drivers/char/drm/i810_dma.c	Sat May 10 01:47:43 2003
@@ -246,7 +246,7 @@
 
 	   	if(dev_priv->ring.virtual_start) {
 		   	DRM(ioremapfree)((void *) dev_priv->ring.virtual_start,
-					 dev_priv->ring.Size);
+					 dev_priv->ring.Size, dev);
 		}
 	   	if (dev_priv->hw_status_page) {
 		   	pci_free_consistent(dev->pdev, PAGE_SIZE,
@@ -263,7 +263,7 @@
 			drm_buf_t *buf = dma->buflist[ i ];
 			drm_i810_buf_priv_t *buf_priv = buf->dev_private;
 			if ( buf_priv->kernel_virtual && buf->total )
-				DRM(ioremapfree)(buf_priv->kernel_virtual, buf->total);
+				DRM(ioremapfree)(buf_priv->kernel_virtual, buf->total, dev);
 		}
 	}
    	return 0;
@@ -333,7 +333,7 @@
 	   	*buf_priv->in_use = I810_BUF_FREE;
 
 		buf_priv->kernel_virtual = DRM(ioremap)(buf->bus_address,
-							buf->total);
+							buf->total, dev);
 	}
 	return 0;
 }
@@ -386,7 +386,7 @@
 
    	dev_priv->ring.virtual_start = DRM(ioremap)(dev->agp->base +
 						    init->ring_start,
-						    init->ring_size);
+						    init->ring_size, dev);
 
    	if (dev_priv->ring.virtual_start == NULL) {
 		dev->dev_private = (void *) dev_priv;
diff -Nru a/drivers/char/drm/i830_dma.c b/drivers/char/drm/i830_dma.c
--- a/drivers/char/drm/i830_dma.c	Sat May 10 01:47:42 2003
+++ b/drivers/char/drm/i830_dma.c	Sat May 10 01:47:42 2003
@@ -246,7 +246,7 @@
 	   
 	   	if (dev_priv->ring.virtual_start) {
 		   	DRM(ioremapfree)((void *) dev_priv->ring.virtual_start,
-					 dev_priv->ring.Size);
+					 dev_priv->ring.Size, dev);
 		}
 	   	if (dev_priv->hw_status_page) {
 			pci_free_consistent(dev->pdev, PAGE_SIZE,
@@ -264,7 +264,7 @@
 			drm_buf_t *buf = dma->buflist[ i ];
 			drm_i830_buf_priv_t *buf_priv = buf->dev_private;
 			if ( buf_priv->kernel_virtual && buf->total )
-				DRM(ioremapfree)(buf_priv->kernel_virtual, buf->total);
+				DRM(ioremapfree)(buf_priv->kernel_virtual, buf->total, dev);
 		}
 	}
    	return 0;
@@ -340,7 +340,7 @@
 	   	*buf_priv->in_use = I830_BUF_FREE;
 
 		buf_priv->kernel_virtual = DRM(ioremap)(buf->bus_address, 
-							buf->total);
+							buf->total, dev);
 	}
 	return 0;
 }
@@ -394,7 +394,7 @@
 
    	dev_priv->ring.virtual_start = DRM(ioremap)(dev->agp->base + 
 						    init->ring_start, 
-						    init->ring_size);
+						    init->ring_size, dev);
 
    	if (dev_priv->ring.virtual_start == NULL) {
 		dev->dev_private = (void *) dev_priv;
diff -Nru a/drivers/char/drm/mga_dma.c b/drivers/char/drm/mga_dma.c
--- a/drivers/char/drm/mga_dma.c	Sat May 10 01:47:43 2003
+++ b/drivers/char/drm/mga_dma.c	Sat May 10 01:47:43 2003
@@ -554,9 +554,9 @@
 		(drm_mga_sarea_t *)((u8 *)dev_priv->sarea->handle +
 				    init->sarea_priv_offset);
 
-	DRM_IOREMAP( dev_priv->warp );
-	DRM_IOREMAP( dev_priv->primary );
-	DRM_IOREMAP( dev_priv->buffers );
+	DRM_IOREMAP( dev_priv->warp, dev );
+	DRM_IOREMAP( dev_priv->primary, dev );
+	DRM_IOREMAP( dev_priv->buffers, dev );
 
 	if(!dev_priv->warp->handle ||
 	   !dev_priv->primary->handle ||
@@ -651,11 +651,11 @@
 		drm_mga_private_t *dev_priv = dev->dev_private;
 
 		if ( dev_priv->warp != NULL )
-			DRM_IOREMAPFREE( dev_priv->warp );
+			DRM_IOREMAPFREE( dev_priv->warp, dev );
 		if ( dev_priv->primary != NULL )
-			DRM_IOREMAPFREE( dev_priv->primary );
+			DRM_IOREMAPFREE( dev_priv->primary, dev );
 		if ( dev_priv->buffers != NULL )
-			DRM_IOREMAPFREE( dev_priv->buffers );
+			DRM_IOREMAPFREE( dev_priv->buffers, dev );
 
 		if ( dev_priv->head != NULL ) {
 			mga_freelist_cleanup( dev );
diff -Nru a/drivers/char/drm/mga_drv.h b/drivers/char/drm/mga_drv.h
--- a/drivers/char/drm/mga_drv.h	Sat May 10 01:47:43 2003
+++ b/drivers/char/drm/mga_drv.h	Sat May 10 01:47:43 2003
@@ -226,7 +226,7 @@
 	if ( MGA_VERBOSE ) {						\
 		DRM_INFO( "BEGIN_DMA( %d ) in %s\n",			\
 			  (n), __FUNCTION__ );				\
-		DRM_INFO( "   space=0x%x req=0x%x\n",			\
+		DRM_INFO( "   space=0x%x req=0x%Zx\n",			\
 			  dev_priv->prim.space, (n) * DMA_BLOCK_SIZE );	\
 	}								\
 	prim = dev_priv->prim.start;					\
@@ -276,7 +276,7 @@
 #define DMA_WRITE( offset, val )					\
 do {									\
 	if ( MGA_VERBOSE ) {						\
-		DRM_INFO( "   DMA_WRITE( 0x%08x ) at 0x%04x\n",		\
+		DRM_INFO( "   DMA_WRITE( 0x%08x ) at 0x%04Zx\n",	\
 			  (u32)(val), write + (offset) * sizeof(u32) );	\
 	}								\
 	*(volatile u32 *)(prim + write + (offset) * sizeof(u32)) = val;	\
diff -Nru a/drivers/char/drm/r128_cce.c b/drivers/char/drm/r128_cce.c
--- a/drivers/char/drm/r128_cce.c	Sat May 10 01:47:42 2003
+++ b/drivers/char/drm/r128_cce.c	Sat May 10 01:47:42 2003
@@ -350,8 +350,8 @@
 
 		R128_WRITE( R128_PM4_BUFFER_DL_RPTR_ADDR,
      			    entry->busaddr[page_ofs]);
-		DRM_DEBUG( "ring rptr: offset=0x%08x handle=0x%08lx\n",
-			   entry->busaddr[page_ofs],
+		DRM_DEBUG( "ring rptr: offset=0x%08lx handle=0x%08lx\n",
+			   (unsigned long) entry->busaddr[page_ofs],
      			   entry->handle + tmp_ofs );
 	}
 
@@ -540,9 +540,9 @@
 				     init->sarea_priv_offset);
 
 	if ( !dev_priv->is_pci ) {
-		DRM_IOREMAP( dev_priv->cce_ring );
-		DRM_IOREMAP( dev_priv->ring_rptr );
-		DRM_IOREMAP( dev_priv->buffers );
+		DRM_IOREMAP( dev_priv->cce_ring, dev );
+		DRM_IOREMAP( dev_priv->ring_rptr, dev );
+		DRM_IOREMAP( dev_priv->buffers, dev );
 		if(!dev_priv->cce_ring->handle ||
 		   !dev_priv->ring_rptr->handle ||
 		   !dev_priv->buffers->handle) {
@@ -629,11 +629,11 @@
 		if ( !dev_priv->is_pci ) {
 #endif
 			if ( dev_priv->cce_ring != NULL )
-				DRM_IOREMAPFREE( dev_priv->cce_ring );
+				DRM_IOREMAPFREE( dev_priv->cce_ring, dev );
 			if ( dev_priv->ring_rptr != NULL )
-				DRM_IOREMAPFREE( dev_priv->ring_rptr );
+				DRM_IOREMAPFREE( dev_priv->ring_rptr, dev );
 			if ( dev_priv->buffers != NULL )
-				DRM_IOREMAPFREE( dev_priv->buffers );
+				DRM_IOREMAPFREE( dev_priv->buffers, dev );
 #if __REALLY_HAVE_SG
 		} else {
 			if (!DRM(ati_pcigart_cleanup)( dev,
diff -Nru a/drivers/char/drm/radeon_cp.c b/drivers/char/drm/radeon_cp.c
--- a/drivers/char/drm/radeon_cp.c	Sat May 10 01:47:43 2003
+++ b/drivers/char/drm/radeon_cp.c	Sat May 10 01:47:43 2003
@@ -903,8 +903,8 @@
 
 		RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR,
 			     entry->busaddr[page_ofs]);
-		DRM_DEBUG( "ring rptr: offset=0x%08x handle=0x%08lx\n",
-			   entry->busaddr[page_ofs],
+		DRM_DEBUG( "ring rptr: offset=0x%08lx handle=0x%08lx\n",
+			   (unsigned long) entry->busaddr[page_ofs],
 			   entry->handle + tmp_ofs );
 	}
 
@@ -1152,9 +1152,9 @@
 				       init->sarea_priv_offset);
 
 	if ( !dev_priv->is_pci ) {
-		DRM_IOREMAP( dev_priv->cp_ring );
-		DRM_IOREMAP( dev_priv->ring_rptr );
-		DRM_IOREMAP( dev_priv->buffers );
+		DRM_IOREMAP( dev_priv->cp_ring, dev );
+		DRM_IOREMAP( dev_priv->ring_rptr, dev );
+		DRM_IOREMAP( dev_priv->buffers, dev );
 		if(!dev_priv->cp_ring->handle ||
 		   !dev_priv->ring_rptr->handle ||
 		   !dev_priv->buffers->handle) {
@@ -1279,11 +1279,11 @@
 
 		if ( !dev_priv->is_pci ) {
 			if ( dev_priv->cp_ring != NULL )
-				DRM_IOREMAPFREE( dev_priv->cp_ring );
+				DRM_IOREMAPFREE( dev_priv->cp_ring, dev );
 			if ( dev_priv->ring_rptr != NULL )
-				DRM_IOREMAPFREE( dev_priv->ring_rptr );
+				DRM_IOREMAPFREE( dev_priv->ring_rptr, dev );
 			if ( dev_priv->buffers != NULL )
-				DRM_IOREMAPFREE( dev_priv->buffers );
+				DRM_IOREMAPFREE( dev_priv->buffers, dev );
 		} else {
 #if __REALLY_HAVE_SG
 			if (!DRM(ati_pcigart_cleanup)( dev,
diff -Nru a/include/asm-alpha/agp.h b/include/asm-alpha/agp.h
--- a/include/asm-alpha/agp.h	Sat May 10 01:47:42 2003
+++ b/include/asm-alpha/agp.h	Sat May 10 01:47:42 2003
@@ -10,4 +10,11 @@
 #define flush_agp_mappings() 
 #define flush_agp_cache() mb()
 
+/*
+ * Page-protection value to be used for AGP memory mapped into kernel space.  For
+ * platforms which use coherent AGP DMA, this can be PAGE_KERNEL.  For others, it needs to
+ * be an uncached mapping (such as write-combining).
+ */
+#define PAGE_AGP			PAGE_KERNEL_NOCACHE	/* XXX fix me */
+
 #endif
diff -Nru a/include/asm-i386/agp.h b/include/asm-i386/agp.h
--- a/include/asm-i386/agp.h	Sat May 10 01:47:42 2003
+++ b/include/asm-i386/agp.h	Sat May 10 01:47:42 2003
@@ -20,4 +20,11 @@
    worth it. Would need a page for it. */
 #define flush_agp_cache() asm volatile("wbinvd":::"memory")
 
+/*
+ * Page-protection value to be used for AGP memory mapped into kernel space.  For
+ * platforms which use coherent AGP DMA, this can be PAGE_KERNEL.  For others, it needs to
+ * be an uncached mapping (such as write-combining).
+ */
+#define PAGE_AGP			PAGE_KERNEL_NOCACHE
+
 #endif
diff -Nru a/include/asm-sparc64/agp.h b/include/asm-sparc64/agp.h
--- a/include/asm-sparc64/agp.h	Sat May 10 01:47:42 2003
+++ b/include/asm-sparc64/agp.h	Sat May 10 01:47:42 2003
@@ -8,4 +8,11 @@
 #define flush_agp_mappings() 
 #define flush_agp_cache() mb()
 
+/*
+ * Page-protection value to be used for AGP memory mapped into kernel space.  For
+ * platforms which use coherent AGP DMA, this can be PAGE_KERNEL.  For others, it needs to
+ * be an uncached mapping (such as write-combining).
+ */
+#define PAGE_AGP			PAGE_KERNEL_NOCACHE
+
 #endif
diff -Nru a/include/asm-x86_64/agp.h b/include/asm-x86_64/agp.h
--- a/include/asm-x86_64/agp.h	Sat May 10 01:47:42 2003
+++ b/include/asm-x86_64/agp.h	Sat May 10 01:47:42 2003
@@ -20,4 +20,11 @@
    worth it. Would need a page for it. */
 #define flush_agp_cache() asm volatile("wbinvd":::"memory")
 
+/*
+ * Page-protection value to be used for AGP memory mapped into kernel space.  For
+ * platforms which use coherent AGP DMA, this can be PAGE_KERNEL.  For others, it needs to
+ * be an uncached mapping (such as write-combining).
+ */
+#define PAGE_AGP			PAGE_KERNEL_NOCACHE
+
 #endif
