Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTIRV5R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 17:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbTIRV5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 17:57:17 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:18086 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262164AbTIRV4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 17:56:55 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: [PATCH] 2.4 IA64 DRM interface changes
Date: Thu, 18 Sep 2003 15:56:50 -0600
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309181556.50692.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a "dev" parameter to drm_ioremap(), drm_ioremap_nocache(),
and drm_ioremapfree().  This change is already in 2.5, and is required to
support DRM on ia64.

The problem on ia64 is that CPU addresses don't get remapped by the
GART, so we have to fiddle with the kernel page tables, and the
ioremap interfaces need the dev pointer to do that.

This part is strictly interface changes; the actual use of the new
parameter is messier code that I'll send separately.  The changes
below should be straightforward enough to be fairly non-controversial.

Bjorn


===== drivers/char/drm/drmP.h 1.10 vs edited =====
--- 1.10/drivers/char/drm/drmP.h	Sat Aug 16 14:15:30 2003
+++ edited/drivers/char/drm/drmP.h	Thu Sep 18 16:48:03 2003
@@ -328,16 +328,16 @@
    if (len > DRM_PROC_LIMIT) { ret; *eof = 1; return len - offset; }
 
 				/* Mapping helper macros */
-#define DRM_IOREMAP(map)						\
-	(map)->handle = DRM(ioremap)( (map)->offset, (map)->size )
+#define DRM_IOREMAP(map, dev)					\
+	(map)->handle = DRM(ioremap)((map)->offset, (map)->size, (dev) )
 
-#define DRM_IOREMAP_NOCACHE(map)					\
-	(map)->handle = DRM(ioremap_nocache)((map)->offset, (map)->size)
+#define DRM_IOREMAP_NOCACHE(map, dev)					\
+	(map)->handle = DRM(ioremap_nocache)((map)->offset, (map)->size, (dev) )
 
-#define DRM_IOREMAPFREE(map)						\
+#define DRM_IOREMAPFREE(map, dev)						\
 	do {								\
 		if ( (map)->handle && (map)->size )			\
-			DRM(ioremapfree)( (map)->handle, (map)->size );	\
+			DRM(ioremapfree)( (map)->handle, (map)->size, (dev) );	\
 	} while (0)
 
 #define DRM_FIND_MAP(_map, _o)						\
@@ -789,9 +789,9 @@
 extern unsigned long DRM(alloc_pages)(int order, int area);
 extern void	     DRM(free_pages)(unsigned long address, int order,
 				     int area);
-extern void	     *DRM(ioremap)(unsigned long offset, unsigned long size);
-extern void	     *DRM(ioremap_nocache)(unsigned long offset, unsigned long size);
-extern void	     DRM(ioremapfree)(void *pt, unsigned long size);
+extern void	     *DRM(ioremap)(unsigned long offset, unsigned long size, drm_device_t *dev);
+extern void	     *DRM(ioremap_nocache)(unsigned long offset, unsigned long size, drm_device_t *dev);
+extern void	     DRM(ioremapfree)(void *pt, unsigned long size, drm_device_t *dev);
 
 #if __REALLY_HAVE_AGP
 extern agp_memory    *DRM(alloc_agp)(int pages, u32 type);
===== drivers/char/drm/drm_bufs.h 1.6 vs edited =====
--- 1.6/drivers/char/drm/drm_bufs.h	Sat Aug 16 14:15:30 2003
+++ edited/drivers/char/drm/drm_bufs.h	Thu Sep 18 16:48:03 2003
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
===== drivers/char/drm/drm_drv.h 1.5 vs edited =====
--- 1.5/drivers/char/drm/drm_drv.h	Mon Jul 28 14:09:43 2003
+++ edited/drivers/char/drm/drm_drv.h	Thu Sep 18 16:48:03 2003
@@ -443,7 +443,7 @@
 					DRM_DEBUG( "mtrr_del=%d\n", retcode );
 				}
 #endif
-				DRM(ioremapfree)( map->handle, map->size );
+				DRM(ioremapfree)( map->handle, map->size, dev );
 				break;
 			case _DRM_SHM:
 				vfree(map->handle);
===== drivers/char/drm/drm_memory.h 1.4 vs edited =====
--- 1.4/drivers/char/drm/drm_memory.h	Sat Aug 16 14:15:30 2003
+++ edited/drivers/char/drm/drm_memory.h	Thu Sep 18 16:50:36 2003
@@ -290,7 +290,7 @@
 	}
 }
 
-void *DRM(ioremap)(unsigned long offset, unsigned long size)
+void *DRM(ioremap)(unsigned long offset, unsigned long size, drm_device_t *dev)
 {
 	void *pt;
 
@@ -313,7 +313,7 @@
 	return pt;
 }
 
-void *DRM(ioremap_nocache)(unsigned long offset, unsigned long size)
+void *DRM(ioremap_nocache)(unsigned long offset, unsigned long size, drm_device_t *dev)
 {
 	void *pt;
 
@@ -336,7 +336,7 @@
 	return pt;
 }
 
-void DRM(ioremapfree)(void *pt, unsigned long size)
+void DRM(ioremapfree)(void *pt, unsigned long size, drm_device_t *dev)
 {
 	int alloc_count;
 	int free_count;
===== drivers/char/drm/drm_vm.h 1.14 vs edited =====
--- 1.14/drivers/char/drm/drm_vm.h	Sat Aug 16 14:15:30 2003
+++ edited/drivers/char/drm/drm_vm.h	Thu Sep 18 16:48:49 2003
@@ -206,7 +206,7 @@
 					DRM_DEBUG("mtrr_del = %d\n", retcode);
 				}
 #endif
-				DRM(ioremapfree)(map->handle, map->size);
+				DRM(ioremapfree)(map->handle, map->size, dev);
 				break;
 			case _DRM_SHM:
 				vfree(map->handle);
===== drivers/char/drm/i810_dma.c 1.9 vs edited =====
--- 1.9/drivers/char/drm/i810_dma.c	Mon Jul 28 14:09:43 2003
+++ edited/drivers/char/drm/i810_dma.c	Thu Sep 18 16:59:08 2003
@@ -276,7 +276,7 @@
 
 	   	if(dev_priv->ring.virtual_start) {
 		   	DRM(ioremapfree)((void *) dev_priv->ring.virtual_start,
-					 dev_priv->ring.Size);
+					 dev_priv->ring.Size, dev);
 		}
 	   	if(dev_priv->hw_status_page != 0UL) {
 		   	pci_free_consistent(dev->pdev, PAGE_SIZE,
@@ -292,7 +292,7 @@
 		for (i = 0; i < dma->buf_count; i++) {
 			drm_buf_t *buf = dma->buflist[ i ];
 			drm_i810_buf_priv_t *buf_priv = buf->dev_private;
-			DRM(ioremapfree)(buf_priv->kernel_virtual, buf->total);
+			DRM(ioremapfree)(buf_priv->kernel_virtual, buf->total, dev);
 		}
 	}
    	return 0;
@@ -362,7 +362,7 @@
 	   	*buf_priv->in_use = I810_BUF_FREE;
 
 		buf_priv->kernel_virtual = DRM(ioremap)(buf->bus_address,
-							buf->total);
+							buf->total, dev);
 	}
 	return 0;
 }
@@ -415,7 +415,7 @@
 
    	dev_priv->ring.virtual_start = DRM(ioremap)(dev->agp->base +
 						    init->ring_start,
-						    init->ring_size);
+						    init->ring_size, dev);
 
    	if (dev_priv->ring.virtual_start == NULL) {
 		dev->dev_private = (void *) dev_priv;
===== drivers/char/drm/mga_dma.c 1.6 vs edited =====
--- 1.6/drivers/char/drm/mga_dma.c	Mon Jul 28 14:09:43 2003
+++ edited/drivers/char/drm/mga_dma.c	Thu Sep 18 16:48:49 2003
@@ -556,9 +556,9 @@
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
@@ -644,9 +644,9 @@
 	if ( dev->dev_private ) {
 		drm_mga_private_t *dev_priv = dev->dev_private;
 
-		DRM_IOREMAPFREE( dev_priv->warp );
-		DRM_IOREMAPFREE( dev_priv->primary );
-		DRM_IOREMAPFREE( dev_priv->buffers );
+		DRM_IOREMAPFREE( dev_priv->warp, dev );
+		DRM_IOREMAPFREE( dev_priv->primary, dev );
+		DRM_IOREMAPFREE( dev_priv->buffers, dev );
 
 		if ( dev_priv->head != NULL ) {
 			mga_freelist_cleanup( dev );
===== drivers/char/drm/r128_cce.c 1.6 vs edited =====
--- 1.6/drivers/char/drm/r128_cce.c	Mon Jul 28 14:09:43 2003
+++ edited/drivers/char/drm/r128_cce.c	Thu Sep 18 16:48:49 2003
@@ -542,9 +542,9 @@
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
@@ -618,9 +618,9 @@
 #if __REALLY_HAVE_SG
 		if ( !dev_priv->is_pci ) {
 #endif
-			DRM_IOREMAPFREE( dev_priv->cce_ring );
-			DRM_IOREMAPFREE( dev_priv->ring_rptr );
-			DRM_IOREMAPFREE( dev_priv->buffers );
+			DRM_IOREMAPFREE( dev_priv->cce_ring, dev );
+			DRM_IOREMAPFREE( dev_priv->ring_rptr, dev );
+			DRM_IOREMAPFREE( dev_priv->buffers, dev );
 #if __REALLY_HAVE_SG
 		} else {
 			if (!DRM(ati_pcigart_cleanup)( dev,
===== drivers/char/drm/radeon_cp.c 1.7 vs edited =====
--- 1.7/drivers/char/drm/radeon_cp.c	Mon Jul 28 14:09:43 2003
+++ edited/drivers/char/drm/radeon_cp.c	Thu Sep 18 16:48:49 2003
@@ -1145,9 +1145,9 @@
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
@@ -1266,9 +1266,9 @@
 		drm_radeon_private_t *dev_priv = dev->dev_private;
 
 		if ( !dev_priv->is_pci ) {
-			DRM_IOREMAPFREE( dev_priv->cp_ring );
-			DRM_IOREMAPFREE( dev_priv->ring_rptr );
-			DRM_IOREMAPFREE( dev_priv->buffers );
+			DRM_IOREMAPFREE( dev_priv->cp_ring, dev );
+			DRM_IOREMAPFREE( dev_priv->ring_rptr, dev );
+			DRM_IOREMAPFREE( dev_priv->buffers, dev );
 		} else {
 #if __REALLY_HAVE_SG
 			if (!DRM(ati_pcigart_cleanup)( dev,
===== drivers/char/drm-4.0/bufs.c 1.1 vs edited =====
--- 1.1/drivers/char/drm-4.0/bufs.c	Tue Feb  5 07:10:18 2002
+++ edited/drivers/char/drm-4.0/bufs.c	Thu Sep 18 16:48:49 2003
@@ -87,7 +87,7 @@
 					     MTRR_TYPE_WRCOMB, 1);
 		}
 #endif
-		map->handle = drm_ioremap(map->offset, map->size);
+		map->handle = drm_ioremap(map->offset, map->size, dev);
 		break;
 			
 
===== drivers/char/drm-4.0/drmP.h 1.1 vs edited =====
--- 1.1/drivers/char/drm-4.0/drmP.h	Tue Feb  5 07:10:18 2002
+++ edited/drivers/char/drm-4.0/drmP.h	Thu Sep 18 17:00:46 2003
@@ -679,8 +679,8 @@
 extern unsigned long drm_alloc_pages(int order, int area);
 extern void	     drm_free_pages(unsigned long address, int order,
 				    int area);
-extern void	     *drm_ioremap(unsigned long offset, unsigned long size);
-extern void	     drm_ioremapfree(void *pt, unsigned long size);
+extern void	     *drm_ioremap(unsigned long offset, unsigned long size, drm_device_t *dev);
+extern void	     drm_ioremapfree(void *pt, unsigned long size, drm_device_t *dev);
 
 #if defined(CONFIG_AGP) || defined(CONFIG_AGP_MODULE)
 extern agp_memory    *drm_alloc_agp(int pages, u32 type);
===== drivers/char/drm-4.0/ffb_drv.c 1.3 vs edited =====
--- 1.3/drivers/char/drm-4.0/ffb_drv.c	Fri Aug 16 07:59:45 2002
+++ edited/drivers/char/drm-4.0/ffb_drv.c	Thu Sep 18 16:48:49 2003
@@ -158,7 +158,7 @@
 			switch (map->type) {
 			case _DRM_REGISTERS:
 			case _DRM_FRAME_BUFFER:
-				drm_ioremapfree(map->handle, map->size);
+				drm_ioremapfree(map->handle, map->size, dev);
 				break;
 
 			case _DRM_SHM:
===== drivers/char/drm-4.0/gamma_drv.c 1.1 vs edited =====
--- 1.1/drivers/char/drm-4.0/gamma_drv.c	Tue Feb  5 07:10:18 2002
+++ edited/drivers/char/drm-4.0/gamma_drv.c	Thu Sep 18 16:48:49 2003
@@ -258,7 +258,7 @@
 					DRM_DEBUG("mtrr_del = %d\n", retcode);
 				}
 #endif
-				drm_ioremapfree(map->handle, map->size);
+				drm_ioremapfree(map->handle, map->size, dev);
 				break;
 			case _DRM_SHM:
 				drm_free_pages((unsigned long)map->handle,
===== drivers/char/drm-4.0/i810_dma.c 1.5 vs edited =====
--- 1.5/drivers/char/drm-4.0/i810_dma.c	Fri Mar 28 06:51:55 2003
+++ edited/drivers/char/drm-4.0/i810_dma.c	Thu Sep 18 17:01:07 2003
@@ -305,7 +305,7 @@
 	   
 	   	if(dev_priv->ring.virtual_start) {
 		   	drm_ioremapfree((void *) dev_priv->ring.virtual_start,
-					dev_priv->ring.Size);
+					dev_priv->ring.Size, dev);
 		}
 	   	if(dev_priv->hw_status_page != 0UL) {
 		   	i810_free_page(dev, dev_priv->hw_status_page);
@@ -319,7 +319,7 @@
 		for (i = 0; i < dma->buf_count; i++) {
 			drm_buf_t *buf = dma->buflist[ i ];
 			drm_i810_buf_priv_t *buf_priv = buf->dev_private;
-			drm_ioremapfree(buf_priv->kernel_virtual, buf->total);
+			drm_ioremapfree(buf_priv->kernel_virtual, buf->total, dev);
 		}
 	}
    	return 0;
@@ -393,7 +393,7 @@
 	   	*buf_priv->in_use = I810_BUF_FREE;
 
 		buf_priv->kernel_virtual = drm_ioremap(buf->bus_address, 
-						       buf->total);
+						       buf->total, dev);
 	}
 	return 0;
 }
@@ -430,7 +430,7 @@
 
    	dev_priv->ring.virtual_start = drm_ioremap(dev->agp->base + 
 						   init->ring_start, 
-						   init->ring_size);
+						   init->ring_size, dev);
 
    	dev_priv->ring.tail_mask = dev_priv->ring.Size - 1;
    
===== drivers/char/drm-4.0/i810_drv.c 1.1 vs edited =====
--- 1.1/drivers/char/drm-4.0/i810_drv.c	Tue Feb  5 07:10:18 2002
+++ edited/drivers/char/drm-4.0/i810_drv.c	Thu Sep 18 16:48:49 2003
@@ -286,7 +286,7 @@
 					DRM_DEBUG("mtrr_del = %d\n", retcode);
 				}
 #endif
-				drm_ioremapfree(map->handle, map->size);
+				drm_ioremapfree(map->handle, map->size, dev);
 				break;
 			case _DRM_SHM:
 				drm_free_pages((unsigned long)map->handle,
===== drivers/char/drm-4.0/memory.c 1.1 vs edited =====
--- 1.1/drivers/char/drm-4.0/memory.c	Tue Feb  5 07:10:18 2002
+++ edited/drivers/char/drm-4.0/memory.c	Thu Sep 18 16:48:49 2003
@@ -296,7 +296,7 @@
 	}
 }
 
-void *drm_ioremap(unsigned long offset, unsigned long size)
+void *drm_ioremap(unsigned long offset, unsigned long size, drm_device_t *dev)
 {
 	void *pt;
 	
@@ -319,7 +319,7 @@
 	return pt;
 }
 
-void drm_ioremapfree(void *pt, unsigned long size)
+void drm_ioremapfree(void *pt, unsigned long size, drm_device_t *dev)
 {
 	int alloc_count;
 	int free_count;
===== drivers/char/drm-4.0/mga_dma.c 1.1 vs edited =====
--- 1.1/drivers/char/drm-4.0/mga_dma.c	Tue Feb  5 07:10:18 2002
+++ edited/drivers/char/drm-4.0/mga_dma.c	Thu Sep 18 16:48:49 2003
@@ -308,7 +308,7 @@
 	temp = ((temp + PAGE_SIZE - 1) / PAGE_SIZE) * PAGE_SIZE;
 
 	dev_priv->ioremap = drm_ioremap(dev->agp->base + offset,
-					temp);
+					temp, dev);
 	if(dev_priv->ioremap == NULL) {
 		DRM_ERROR("Ioremap failed\n");
 		return -ENOMEM;
@@ -635,7 +635,7 @@
 				    dev_priv->primary_size +
 				    PAGE_SIZE - 1) / PAGE_SIZE * PAGE_SIZE;
 
-			drm_ioremapfree((void *) dev_priv->ioremap, temp);
+			drm_ioremapfree((void *) dev_priv->ioremap, temp, dev);
 		}
 	   	if(dev_priv->status_page != NULL) {
 		   	iounmap(dev_priv->status_page);
===== drivers/char/drm-4.0/mga_drv.c 1.1 vs edited =====
--- 1.1/drivers/char/drm-4.0/mga_drv.c	Tue Feb  5 07:10:18 2002
+++ edited/drivers/char/drm-4.0/mga_drv.c	Thu Sep 18 16:48:49 2003
@@ -286,7 +286,7 @@
 					DRM_DEBUG("mtrr_del = %d\n", retcode);
 				}
 #endif
-				drm_ioremapfree(map->handle, map->size);
+				drm_ioremapfree(map->handle, map->size, dev);
 				break;
 			case _DRM_SHM:
 				drm_free_pages((unsigned long)map->handle,
===== drivers/char/drm-4.0/r128_cce.c 1.1 vs edited =====
--- 1.1/drivers/char/drm-4.0/r128_cce.c	Tue Feb  5 07:10:18 2002
+++ edited/drivers/char/drm-4.0/r128_cce.c	Thu Sep 18 16:55:27 2003
@@ -86,12 +86,12 @@
 };
 
 
-#define DO_REMAP(_m) (_m)->handle = drm_ioremap((_m)->offset, (_m)->size)
+#define DO_REMAP(_m, _d) (_m)->handle = drm_ioremap((_m)->offset, (_m)->size, (_d))
 
-#define DO_REMAPFREE(_m)                                                    \
+#define DO_REMAPFREE(_m, _d)                                                   \
 	do {                                                                \
 		if ((_m)->handle && (_m)->size)                             \
-			drm_ioremapfree((_m)->handle, (_m)->size);          \
+			drm_ioremapfree((_m)->handle, (_m)->size, (_d));    \
 	} while (0)
 
 #define DO_FIND_MAP(_m, _o)                                                 \
@@ -481,12 +481,12 @@
 		(drm_r128_sarea_t *)((u8 *)dev_priv->sarea->handle +
 				     init->sarea_priv_offset);
 
-	DO_REMAP( dev_priv->cce_ring );
-	DO_REMAP( dev_priv->ring_rptr );
-	DO_REMAP( dev_priv->buffers );
+	DO_REMAP( dev_priv->cce_ring, dev );
+	DO_REMAP( dev_priv->ring_rptr, dev );
+	DO_REMAP( dev_priv->buffers, dev );
 #if 0
 	if ( !dev_priv->is_pci ) {
-		DO_REMAP( dev_priv->agp_textures );
+		DO_REMAP( dev_priv->agp_textures, dev );
 	}
 #endif
 
@@ -521,12 +521,12 @@
 	if ( dev->dev_private ) {
 		drm_r128_private_t *dev_priv = dev->dev_private;
 
-		DO_REMAPFREE( dev_priv->cce_ring );
-		DO_REMAPFREE( dev_priv->ring_rptr );
-		DO_REMAPFREE( dev_priv->buffers );
+		DO_REMAPFREE( dev_priv->cce_ring, dev );
+		DO_REMAPFREE( dev_priv->ring_rptr, dev );
+		DO_REMAPFREE( dev_priv->buffers, dev );
 #if 0
 		if ( !dev_priv->is_pci ) {
-			DO_REMAPFREE( dev_priv->agp_textures );
+			DO_REMAPFREE( dev_priv->agp_textures, dev );
 		}
 #endif
 
===== drivers/char/drm-4.0/r128_drv.c 1.1 vs edited =====
--- 1.1/drivers/char/drm-4.0/r128_drv.c	Tue Feb  5 07:10:18 2002
+++ edited/drivers/char/drm-4.0/r128_drv.c	Thu Sep 18 16:51:42 2003
@@ -296,7 +296,7 @@
 					DRM_DEBUG("mtrr_del = %d\n", retcode);
 				}
 #endif
-				drm_ioremapfree(map->handle, map->size);
+				drm_ioremapfree(map->handle, map->size, dev);
 				break;
 			case _DRM_SHM:
 				drm_free_pages((unsigned long)map->handle,
===== drivers/char/drm-4.0/radeon_cp.c 1.1 vs edited =====
--- 1.1/drivers/char/drm-4.0/radeon_cp.c	Tue Feb  5 07:10:18 2002
+++ edited/drivers/char/drm-4.0/radeon_cp.c	Thu Sep 18 16:53:48 2003
@@ -300,12 +300,12 @@
 };
 
 
-#define DO_IOREMAP(_m) (_m)->handle = drm_ioremap((_m)->offset, (_m)->size)
+#define DO_IOREMAP(_m, _d) (_m)->handle = drm_ioremap((_m)->offset, (_m)->size, (_d))
 
-#define DO_IOREMAPFREE(_m)						\
+#define DO_IOREMAPFREE(_m, _d)						\
 	do {								\
 		if ((_m)->handle && (_m)->size)				\
-			drm_ioremapfree((_m)->handle, (_m)->size);	\
+			drm_ioremapfree((_m)->handle, (_m)->size, (_d));\
 	} while (0)
 
 #define DO_FIND_MAP(_m, _o)						\
@@ -757,12 +757,12 @@
 		(drm_radeon_sarea_t *)((u8 *)dev_priv->sarea->handle +
 				       init->sarea_priv_offset);
 
-	DO_IOREMAP( dev_priv->cp_ring );
-	DO_IOREMAP( dev_priv->ring_rptr );
-	DO_IOREMAP( dev_priv->buffers );
+	DO_IOREMAP( dev_priv->cp_ring, dev );
+	DO_IOREMAP( dev_priv->ring_rptr, dev );
+	DO_IOREMAP( dev_priv->buffers, dev );
 #if 0
 	if ( !dev_priv->is_pci ) {
-		DO_IOREMAP( dev_priv->agp_textures );
+		DO_IOREMAP( dev_priv->agp_textures, dev );
 	}
 #endif
 
@@ -828,12 +828,12 @@
 	if ( dev->dev_private ) {
 		drm_radeon_private_t *dev_priv = dev->dev_private;
 
-		DO_IOREMAPFREE( dev_priv->cp_ring );
-		DO_IOREMAPFREE( dev_priv->ring_rptr );
-		DO_IOREMAPFREE( dev_priv->buffers );
+		DO_IOREMAPFREE( dev_priv->cp_ring, dev );
+		DO_IOREMAPFREE( dev_priv->ring_rptr, dev );
+		DO_IOREMAPFREE( dev_priv->buffers, dev );
 #if 0
 		if ( !dev_priv->is_pci ) {
-			DO_IOREMAPFREE( dev_priv->agp_textures );
+			DO_IOREMAPFREE( dev_priv->agp_textures, dev );
 		}
 #endif
 
===== drivers/char/drm-4.0/radeon_drv.c 1.1 vs edited =====
--- 1.1/drivers/char/drm-4.0/radeon_drv.c	Tue Feb  5 07:10:18 2002
+++ edited/drivers/char/drm-4.0/radeon_drv.c	Thu Sep 18 16:49:33 2003
@@ -294,7 +294,7 @@
 					DRM_DEBUG("mtrr_del = %d\n", retcode);
 				}
 #endif
-				drm_ioremapfree(map->handle, map->size);
+				drm_ioremapfree(map->handle, map->size, dev);
 				break;
 			case _DRM_SHM:
 				drm_free_pages((unsigned long)map->handle,
===== drivers/char/drm-4.0/tdfx_drv.c 1.2 vs edited =====
--- 1.2/drivers/char/drm-4.0/tdfx_drv.c	Fri Aug 16 07:59:45 2002
+++ edited/drivers/char/drm-4.0/tdfx_drv.c	Thu Sep 18 16:49:33 2003
@@ -264,7 +264,7 @@
 					DRM_DEBUG("mtrr_del = %d\n", retcode);
 				}
 #endif
-				drm_ioremapfree(map->handle, map->size);
+				drm_ioremapfree(map->handle, map->size, dev);
 				break;
 			case _DRM_SHM:
 				drm_free_pages((unsigned long)map->handle,

