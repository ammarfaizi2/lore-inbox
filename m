Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269919AbUIDN2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269919AbUIDN2f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 09:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267889AbUIDN2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 09:28:35 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:13540 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269919AbUIDNXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 09:23:31 -0400
Date: Sat, 4 Sep 2004 14:23:30 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/patch] macro_removal_agp_mtrr.diff
In-Reply-To: <20040904103711.GD5313@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0409041418450.25475@skynet>
References: <Pine.LNX.4.58.0409041053450.25475@skynet>
 <1094292878.2801.7.camel@laptop.fenrus.com> <Pine.LNX.4.58.0409041126500.25475@skynet>
 <20040904103711.GD5313@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay here is an updated patch:

I've taken suggestions from Christoph and Arjan on board,

My only issue is with the stuff in drm_os_linux.h, I've had to make a
dummy AGP structure, and add the mtrr_add/mtrr_del stubs (as they are fine
on x86 but don't exist on anything else..) but perhaps a small ugly in
there is better than big uglies elsewhere...

I might be able to drop the OS_HAS_AGP from the drivers, but that'll be a
job that requires testing via CVS (as that is where we have the people
with the different cards..)

Dave.

===== drivers/char/drm/drmP.h 1.45 vs edited =====
--- 1.45/drivers/char/drm/drmP.h	Fri Sep  3 20:00:58 2004
+++ edited/drivers/char/drm/drmP.h	Sat Sep  4 22:54:58 2004
@@ -73,19 +73,20 @@
 #include <asm/pgalloc.h>
 #include "drm.h"

-#include "drm_os_linux.h"
+#define __OS_HAS_AGP (defined(CONFIG_AGP) || (defined(CONFIG_AGP_MODULE) && defined(MODULE)))
+#define __OS_HAS_MTRR (defined(CONFIG_MTRR))

+#include "drm_os_linux.h"

 /***********************************************************************/
 /** \name DRM template customization defaults */
 /*@{*/

-#ifndef __HAVE_AGP
-#define __HAVE_AGP		0
-#endif
-#ifndef __HAVE_MTRR
-#define __HAVE_MTRR		0
-#endif
+/* driver capabilities and requirements mask */
+#define DRIVER_USE_AGP     0x1
+#define DRIVER_REQUIRE_AGP 0x2
+#define DRIVER_USE_MTRR    0x4
+
 #ifndef __HAVE_CTX_BITMAP
 #define __HAVE_CTX_BITMAP	0
 #endif
@@ -96,11 +97,9 @@
 #define __HAVE_IRQ		0
 #endif

-#define __REALLY_HAVE_AGP	(__HAVE_AGP && (defined(CONFIG_AGP) || \
-						defined(CONFIG_AGP_MODULE)))
-#define __REALLY_HAVE_MTRR	(__HAVE_MTRR && defined(CONFIG_MTRR))
 #define __REALLY_HAVE_SG	(__HAVE_SG)

+
 /*@}*/


@@ -479,7 +478,6 @@
 	/*@}*/
 } drm_device_dma_t;

-#if __REALLY_HAVE_AGP
 /**
  * AGP memory entry.  Stored as a doubly linked list.
  */
@@ -508,7 +506,6 @@
 	int		   cant_use_aperture;
 	unsigned long	   page_mask;
 } drm_agp_head_t;
-#endif

 /**
  * Scatter-gather memory.
@@ -685,9 +682,7 @@
 	wait_queue_head_t buf_readers;	/**< Processes waiting to read */
 	wait_queue_head_t buf_writers;	/**< Processes waiting to ctx switch */

-#if __REALLY_HAVE_AGP
 	drm_agp_head_t    *agp;	/**< AGP data */
-#endif

 	struct pci_dev    *pdev;	/**< PCI device structure */
 	int               pci_domain;	/**< PCI bus domain number */
@@ -710,8 +705,32 @@
 	struct            drm_driver_fn fn_tbl;
 	drm_local_map_t   *agp_buffer_map;
 	int               dev_priv_size;
+	u32               driver_features;
 } drm_device_t;

+static __inline__ int drm_core_check_feature(struct drm_device *dev, int feature)
+{
+	return ((dev->driver_features & feature) ? 1 : 0);
+}
+
+#if __OS_HAS_AGP
+static inline int drm_core_has_AGP(struct drm_device *dev)
+{
+  return drm_core_check_feature(dev, DRIVER_USE_AGP);
+}
+#else
+#define drm_core_has_AGP(dev) (0)
+#endif
+
+#if __OS_HAS_MTRR
+static inline int drm_core_has_MTRR(struct drm_device *dev)
+{
+  return drm_core_check_feature(dev, DRIVER_USE_MTRR);
+}
+#else
+#define drm_core_has_MTRR(dev) (0)
+#endif
+
 extern void DRM(driver_register_fns)(struct drm_device *dev);

 /******************************************************************/
@@ -768,12 +787,10 @@
 					   drm_device_t *dev);
 extern void	     DRM(ioremapfree)(void *pt, unsigned long size, drm_device_t *dev);

-#if __REALLY_HAVE_AGP
 extern DRM_AGP_MEM   *DRM(alloc_agp)(int pages, u32 type);
 extern int           DRM(free_agp)(DRM_AGP_MEM *handle, int pages);
 extern int           DRM(bind_agp)(DRM_AGP_MEM *handle, unsigned int start);
 extern int           DRM(unbind_agp)(DRM_AGP_MEM *handle);
-#endif

 				/* Misc. IOCTL support (drm_ioctl.h) */
 extern int	     DRM(irq_by_busid)(struct inode *inode, struct file *filp,
@@ -900,7 +917,6 @@
 #endif


-#if __REALLY_HAVE_AGP
 				/* AGP/GART support (drm_agpsupport.h) */
 extern drm_agp_head_t *DRM(agp_init)(void);
 extern void           DRM(agp_uninit)(void);
@@ -925,7 +941,6 @@
 extern int            DRM(agp_free_memory)(DRM_AGP_MEM *handle);
 extern int            DRM(agp_bind_memory)(DRM_AGP_MEM *handle, off_t start);
 extern int            DRM(agp_unbind_memory)(DRM_AGP_MEM *handle);
-#endif

 				/* Stub support (drm_stub.h) */
 int                   DRM(stub_register)(const char *name,
===== drivers/char/drm/drm_agpsupport.h 1.28 vs edited =====
--- 1.28/drivers/char/drm/drm_agpsupport.h	Sat Jul 17 00:14:58 2004
+++ edited/drivers/char/drm/drm_agpsupport.h	Sat Sep  4 19:03:35 2004
@@ -34,8 +34,7 @@
 #include "drmP.h"
 #include <linux/module.h>

-#if __REALLY_HAVE_AGP
-
+#if __OS_HAS_AGP

 #define DRM_AGP_GET (drm_agp_t *)inter_module_get("drm_agp")
 #define DRM_AGP_PUT inter_module_put("drm_agp")
@@ -466,4 +465,4 @@
 	return drm_agp->unbind_memory(handle);
 }

-#endif /* __REALLY_HAVE_AGP */
+#endif /* __OS_HAS_AGP */
===== drivers/char/drm/drm_bufs.h 1.24 vs edited =====
--- 1.24/drivers/char/drm/drm_bufs.h	Fri Sep  3 19:37:29 2004
+++ edited/drivers/char/drm/drm_bufs.h	Sat Sep  4 22:57:34 2004
@@ -130,13 +130,13 @@
 #ifdef __alpha__
 		map->offset += dev->hose->mem_space->start;
 #endif
-#if __REALLY_HAVE_MTRR
-		if ( map->type == _DRM_FRAME_BUFFER ||
-		     (map->flags & _DRM_WRITE_COMBINING) ) {
-			map->mtrr = mtrr_add( map->offset, map->size,
-					      MTRR_TYPE_WRCOMB, 1 );
+		if (drm_core_has_MTRR(dev)) {
+			if ( map->type == _DRM_FRAME_BUFFER ||
+			     (map->flags & _DRM_WRITE_COMBINING) ) {
+				map->mtrr = mtrr_add( map->offset, map->size,
+						      MTRR_TYPE_WRCOMB, 1 );
+			}
 		}
-#endif
 		if (map->type == _DRM_REGISTERS)
 			map->handle = DRM(ioremap)( map->offset, map->size,
 						    dev );
@@ -162,15 +162,15 @@
 			dev->lock.hw_lock = map->handle; /* Pointer to lock */
 		}
 		break;
-#if __REALLY_HAVE_AGP
 	case _DRM_AGP:
+		if (drm_core_has_AGP(dev)) {
 #ifdef __alpha__
-		map->offset += dev->hose->mem_space->start;
+			map->offset += dev->hose->mem_space->start;
 #endif
-		map->offset += dev->agp->base;
-		map->mtrr   = dev->agp->agp_mtrr; /* for getmap */
+			map->offset += dev->agp->base;
+			map->mtrr   = dev->agp->agp_mtrr; /* for getmap */
+		}
 		break;
-#endif
 	case _DRM_SCATTER_GATHER:
 		if (!dev->sg) {
 			DRM(free)(map, sizeof(*map), DRM_MEM_MAPS);
@@ -270,15 +270,15 @@
 		switch (map->type) {
 		case _DRM_REGISTERS:
 		case _DRM_FRAME_BUFFER:
-#if __REALLY_HAVE_MTRR
-			if (map->mtrr >= 0) {
-				int retcode;
-				retcode = mtrr_del(map->mtrr,
-						   map->offset,
-						   map->size);
-				DRM_DEBUG("mtrr_del = %d\n", retcode);
+		  if (drm_core_has_MTRR(dev)) {
+				if (map->mtrr >= 0) {
+					int retcode;
+					retcode = mtrr_del(map->mtrr,
+							   map->offset,
+							   map->size);
+					DRM_DEBUG("mtrr_del = %d\n", retcode);
+				}
 			}
-#endif
 			DRM(ioremapfree)(map->handle, map->size, dev);
 			break;
 		case _DRM_SHM:
@@ -340,7 +340,7 @@
 	}
 }

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 /**
  * Add AGP buffers for DMA transfers (ioctl).
  *
@@ -517,7 +517,7 @@
 	atomic_dec( &dev->buf_alloc );
 	return 0;
 }
-#endif /* __REALLY_HAVE_AGP */
+#endif /* __OS_HAS_AGP */

 #if __HAVE_PCI_DMA
 int DRM(addbufs_pci)( struct inode *inode, struct file *filp,
@@ -940,7 +940,7 @@
 			     sizeof(request) ) )
 		return -EFAULT;

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	if ( request.flags & _DRM_AGP_BUFFER )
 		return DRM(addbufs_agp)( inode, filp, cmd, arg );
 	else
@@ -1185,8 +1185,8 @@
 		return -EFAULT;

 	if ( request.count >= dma->buf_count ) {
-		if ( (__HAVE_AGP && (dma->flags & _DRM_DMA_USE_AGP)) ||
-		     (__HAVE_SG && (dma->flags & _DRM_DMA_USE_SG)) ) {
+		if ((drm_core_has_AGP(dev) && (dma->flags & _DRM_DMA_USE_AGP)) ||
+		    (__HAVE_SG && (dma->flags & _DRM_DMA_USE_SG)) ) {
 			drm_map_t *map = dev->agp_buffer_map;

 			if ( !map ) {
===== drivers/char/drm/drm_drv.h 1.41 vs edited =====
--- 1.41/drivers/char/drm/drm_drv.h	Fri Sep  3 19:49:23 2004
+++ edited/drivers/char/drm/drm_drv.h	Sat Sep  4 21:28:36 2004
@@ -52,9 +52,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */

-#ifndef __MUST_HAVE_AGP
-#define __MUST_HAVE_AGP			0
-#endif
+
 #ifndef __HAVE_CTX_BITMAP
 #define __HAVE_CTX_BITMAP		0
 #endif
@@ -166,7 +164,7 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_CONTROL)]       = { DRM(control),     1, 1 },
 #endif

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	[DRM_IOCTL_NR(DRM_IOCTL_AGP_ACQUIRE)]   = { DRM(agp_acquire), 1, 1 },
 	[DRM_IOCTL_NR(DRM_IOCTL_AGP_RELEASE)]   = { DRM(agp_release), 1, 1 },
 	[DRM_IOCTL_NR(DRM_IOCTL_AGP_ENABLE)]    = { DRM(agp_enable),  1, 1 },
@@ -367,9 +365,8 @@
 		dev->magiclist[i].head = dev->magiclist[i].tail = NULL;
 	}

-#if __REALLY_HAVE_AGP
 				/* Clear AGP information */
-	if ( dev->agp ) {
+	if (drm_core_has_AGP(dev) && dev->agp) {
 		drm_agp_mem_t *entry;
 		drm_agp_mem_t *nexte;

@@ -388,7 +385,6 @@
 		dev->agp->acquired = 0;
 		dev->agp->enabled  = 0;
 	}
-#endif

 				/* Clear vma list (only built for debugging) */
 	if ( dev->vmalist ) {
@@ -407,15 +403,15 @@
 				switch ( map->type ) {
 				case _DRM_REGISTERS:
 				case _DRM_FRAME_BUFFER:
-#if __REALLY_HAVE_MTRR
-					if ( map->mtrr >= 0 ) {
-						int retcode;
-						retcode = mtrr_del( map->mtrr,
-								    map->offset,
-								    map->size );
-						DRM_DEBUG( "mtrr_del=%d\n", retcode );
+					if (drm_core_has_MTRR(dev)) {
+						if ( map->mtrr >= 0 ) {
+							int retcode;
+							retcode = mtrr_del( map->mtrr,
+									    map->offset,
+									    map->size );
+							DRM_DEBUG( "mtrr_del=%d\n", retcode );
+						}
 					}
-#endif
 					DRM(ioremapfree)( map->handle, map->size, dev );
 					break;
 				case _DRM_SHM:
@@ -540,24 +536,23 @@
 	if (dev->fn_tbl.preinit)
 	  dev->fn_tbl.preinit(dev);

-#if __REALLY_HAVE_AGP
-	dev->agp = DRM(agp_init)();
-#if __MUST_HAVE_AGP
-	if ( dev->agp == NULL ) {
-		DRM_ERROR( "Cannot initialize the agpgart module.\n" );
-		DRM(stub_unregister)(dev->minor);
-		DRM(takedown)( dev );
-		return -EINVAL;
+	if (drm_core_has_AGP(dev))
+	{
+		dev->agp = DRM(agp_init)();
+		if (drm_core_check_feature(dev, DRIVER_REQUIRE_AGP) && (dev->agp == NULL)) {
+			DRM_ERROR( "Cannot initialize the agpgart module.\n" );
+			DRM(stub_unregister)(dev->minor);
+			DRM(takedown)( dev );
+			return -EINVAL;
+		}
+		if (drm_core_has_MTRR(dev)) {
+			if (dev->agp)
+				dev->agp->agp_mtrr = mtrr_add( dev->agp->agp_info.aper_base,
+							       dev->agp->agp_info.aper_size*1024*1024,
+							       MTRR_TYPE_WRCOMB,
+							       1 );
+		}
 	}
-#endif
-#if __REALLY_HAVE_MTRR
-	if (dev->agp)
-		dev->agp->agp_mtrr = mtrr_add( dev->agp->agp_info.aper_base,
-					dev->agp->agp_info.aper_size*1024*1024,
-					MTRR_TYPE_WRCOMB,
-					1 );
-#endif
-#endif

 #if __HAVE_CTX_BITMAP
 	retcode = DRM(ctxbitmap_init)( dev );
@@ -644,25 +639,23 @@
 		DRM(ctxbitmap_cleanup)( dev );
 #endif

-#if __REALLY_HAVE_AGP && __REALLY_HAVE_MTRR
-		if ( dev->agp && dev->agp->agp_mtrr >= 0) {
+		if (drm_core_has_MTRR(dev) && drm_core_has_AGP(dev) &&
+		    dev->agp && dev->agp->agp_mtrr >= 0) {
 			int retval;
 			retval = mtrr_del( dev->agp->agp_mtrr,
 				   dev->agp->agp_info.aper_base,
 				   dev->agp->agp_info.aper_size*1024*1024 );
 			DRM_DEBUG( "mtrr_del=%d\n", retval );
 		}
-#endif

 		DRM(takedown)( dev );

-#if __REALLY_HAVE_AGP
-		if ( dev->agp ) {
+		if (drm_core_has_AGP(dev) && dev->agp ) {
 			DRM(agp_uninit)();
 			DRM(free)( dev->agp, sizeof(*dev->agp), DRM_MEM_AGPLISTS );
 			dev->agp = NULL;
 		}
-#endif
+
 		if (dev->fn_tbl.postcleanup)
 		  dev->fn_tbl.postcleanup(dev);

===== drivers/char/drm/drm_memory.h 1.15 vs edited =====
--- 1.15/drivers/char/drm/drm_memory.h	Fri Sep  3 20:00:58 2004
+++ edited/drivers/char/drm/drm_memory.h	Sat Sep  4 22:43:45 2004
@@ -44,7 +44,7 @@
  */
 #define DEBUG_MEMORY 0

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP

 #include <linux/vmalloc.h>

@@ -130,46 +130,56 @@
 	return pte_pfn(*ptep) << PAGE_SHIFT;
 }

-#endif /* __REALLY_HAVE_AGP */
+#else /* __OS_HAS_AGP */
+
+static inline drm_map_t *drm_lookup_map(unsigned long offset, unsigned long size, drm_device_t *dev)
+{
+  return NULL;
+}
+
+static inline void *agp_remap(unsigned long offset, unsigned long size, drm_device_t *dev)
+{
+  return NULL;
+}
+
+static inline unsigned long drm_follow_page (void *vaddr)
+{
+  return 0;
+}
+
+#endif

 static inline void *drm_ioremap(unsigned long offset, unsigned long size, drm_device_t *dev)
 {
-#if __REALLY_HAVE_AGP
-	if (dev->agp && dev->agp->cant_use_aperture) {
+	if (drm_core_has_AGP(dev) && dev->agp && dev->agp->cant_use_aperture) {
 		drm_map_t *map = drm_lookup_map(offset, size, dev);

 		if (map && map->type == _DRM_AGP)
 			return agp_remap(offset, size, dev);
 	}
-#endif
-
 	return ioremap(offset, size);
 }

 static inline void *drm_ioremap_nocache(unsigned long offset, unsigned long size,
 					drm_device_t *dev)
 {
-#if __REALLY_HAVE_AGP
-	if (dev->agp && dev->agp->cant_use_aperture) {
+	if (drm_core_has_AGP(dev) && dev->agp && dev->agp->cant_use_aperture) {
 		drm_map_t *map = drm_lookup_map(offset, size, dev);

 		if (map && map->type == _DRM_AGP)
 			return agp_remap(offset, size, dev);
 	}
-#endif
-
 	return ioremap_nocache(offset, size);
 }

 static inline void drm_ioremapfree(void *pt, unsigned long size, drm_device_t *dev)
 {
-#if __REALLY_HAVE_AGP
 	/*
 	 * This is a bit ugly.  It would be much cleaner if the DRM API would use separate
 	 * routines for handling mappings in the AGP space.  Hopefully this can be done in
 	 * a future revision of the interface...
 	 */
-	if (dev->agp && dev->agp->cant_use_aperture
+	if (drm_core_has_AGP(dev) && dev->agp && dev->agp->cant_use_aperture
 	    && ((unsigned long) pt >= VMALLOC_START && (unsigned long) pt < VMALLOC_END))
 	{
 		unsigned long offset;
@@ -182,7 +192,6 @@
 			return;
 		}
 	}
-#endif

 	iounmap(pt);
 }
@@ -332,7 +341,7 @@
 	drm_ioremapfree(pt, size, dev);
 }

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 /** Wrapper around agp_allocate_memory() */
 DRM_AGP_MEM *DRM(alloc_agp)(int pages, u32 type)
 {
===== drivers/char/drm/drm_memory_debug.h 1.7 vs edited =====
--- 1.7/drivers/char/drm/drm_memory_debug.h	Sat Apr 10 17:06:27 2004
+++ edited/drivers/char/drm/drm_memory_debug.h	Sat Sep  4 19:03:35 2004
@@ -352,7 +352,7 @@
 	}
 }

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP

 DRM_AGP_MEM *DRM(alloc_agp)(int pages, u32 type)
 {
===== drivers/char/drm/drm_os_linux.h 1.15 vs edited =====
--- 1.15/drivers/char/drm/drm_os_linux.h	Fri Aug 27 19:38:14 2004
+++ edited/drivers/char/drm/drm_os_linux.h	Sat Sep  4 22:47:44 2004
@@ -41,8 +41,34 @@
 #define DRM_IRQ_ARGS		int irq, void *arg, struct pt_regs *regs

 /** AGP types */
+#if __OS_HAS_AGP
 #define DRM_AGP_MEM		struct agp_memory
 #define DRM_AGP_KERN		struct agp_kern_info
+#else
+/* define some dummy types for non AGP supporting kernels */
+struct no_agp_kern {
+  unsigned long aper_base;
+  unsigned long aper_size;
+};
+#define DRM_AGP_MEM             int
+#define DRM_AGP_KERN            struct no_agp_kern
+#endif
+
+#if !(__OS_HAS_MTRR)
+static __inline__ int mtrr_add (unsigned long base, unsigned long size,
+                                unsigned int type, char increment)
+{
+    return -ENODEV;
+}
+
+static __inline__ int mtrr_del (int reg, unsigned long base,
+                                unsigned long size)
+{
+    return -ENODEV;
+}
+#define MTRR_TYPE_WRCOMB     1
+
+#endif

 /** Task queue handler arguments */
 #define DRM_TASKQUEUE_ARGS	void *arg
===== drivers/char/drm/drm_vm.h 1.29 vs edited =====
--- 1.29/drivers/char/drm/drm_vm.h	Sat Jul 17 00:14:58 2004
+++ edited/drivers/char/drm/drm_vm.h	Sat Sep  4 23:08:04 2004
@@ -46,10 +46,11 @@
  * Find the right map and if it's AGP memory find the real physical page to
  * map, get the page, increment the use count and return it.
  */
+#if __OS_HAS_AGP
 static __inline__ struct page *DRM(do_vm_nopage)(struct vm_area_struct *vma,
 						 unsigned long address)
 {
-#if __REALLY_HAVE_AGP
+
 	drm_file_t *priv  = vma->vm_file->private_data;
 	drm_device_t *dev = priv->dev;
 	drm_map_t *map    = NULL;
@@ -59,6 +60,8 @@
 	/*
          * Find the right map
          */
+	if (!drm_core_has_AGP(dev, DRIVER_USE_AGP))
+		goto vm_nopage_error;

 	if(!dev->agp || !dev->agp->cant_use_aperture) goto vm_nopage_error;

@@ -107,10 +110,15 @@
 		return page;
         }
 vm_nopage_error:
-#endif /* __REALLY_HAVE_AGP */
-
 	return NOPAGE_SIGBUS;		/* Disallow mremap */
 }
+#else
+static __inline__ struct page *DRM(do_vm_nopage)(struct vm_area_struct *vma,
+						 unsigned long address)
+{
+	return NOPAGE_SIGBUS;
+}
+#endif /* __OS_HAS_AGP */

 /**
  * \c nopage method for shared virtual memory.
@@ -201,15 +209,13 @@
 			switch (map->type) {
 			case _DRM_REGISTERS:
 			case _DRM_FRAME_BUFFER:
-#if __REALLY_HAVE_MTRR
-				if (map->mtrr >= 0) {
+				if (drm_core_has_MTRR(dev) && map->mtrr >= 0) {
 					int retcode;
 					retcode = mtrr_del(map->mtrr,
 							   map->offset,
 							   map->size);
 					DRM_DEBUG("mtrr_del = %d\n", retcode);
 				}
-#endif
 				DRM(ioremapfree)(map->handle, map->size, dev);
 				break;
 			case _DRM_SHM:
@@ -533,7 +539,7 @@
 	 * --BenH.
 	 */
 	if (!VM_OFFSET(vma)
-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	    && (!dev->agp || dev->agp->agp_info.device->vendor != PCI_VENDOR_ID_APPLE)
 #endif
 	    )
@@ -577,8 +583,7 @@

 	switch (map->type) {
         case _DRM_AGP:
-#if __REALLY_HAVE_AGP
-	  if (dev->agp->cant_use_aperture) {
+	  if (drm_core_has_AGP(dev) && dev->agp->cant_use_aperture) {
                 /*
                  * On some platforms we can't talk to bus dma address from the CPU, so for
                  * memory of type DRM_AGP, we'll deal with sorting out the real physical
@@ -590,7 +595,6 @@
                 vma->vm_ops = &DRM(vm_ops);
                 break;
 	  }
-#endif
                 /* fall through to _DRM_FRAME_BUFFER... */
 	case _DRM_FRAME_BUFFER:
 	case _DRM_REGISTERS:
===== drivers/char/drm/gamma.h 1.16 vs edited =====
--- 1.16/drivers/char/drm/gamma.h	Fri Sep  3 19:49:23 2004
+++ edited/drivers/char/drm/gamma.h	Sat Sep  4 19:03:35 2004
@@ -36,8 +36,6 @@

 /* General customization:
  */
-#define __HAVE_MTRR			1
-
 #define DRIVER_AUTHOR		"VA Linux Systems Inc."

 #define DRIVER_NAME		"gamma"
@@ -72,8 +70,6 @@
 /* DMA customization:
  */
 #define __HAVE_DMA			1
-#define __HAVE_AGP			1
-#define __MUST_HAVE_AGP			0
 #define __HAVE_OLD_DMA			1
 #define __HAVE_PCI_DMA			1

===== drivers/char/drm/gamma_dma.c 1.24 vs edited =====
--- 1.24/drivers/char/drm/gamma_dma.c	Fri Sep  3 20:00:58 2004
+++ edited/drivers/char/drm/gamma_dma.c	Sat Sep  4 19:03:35 2004
@@ -934,6 +934,7 @@

 void gamma_driver_register_fns(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_USE_MTRR;
 	DRM(fops).read = gamma_fops_read;
 	DRM(fops).poll = gamma_fops_poll;
 	dev->fn_tbl.preinit = gamma_driver_preinit;
===== drivers/char/drm/i810.h 1.16 vs edited =====
--- 1.16/drivers/char/drm/i810.h	Fri Sep  3 19:49:23 2004
+++ edited/drivers/char/drm/i810.h	Sat Sep  4 19:03:35 2004
@@ -36,9 +36,6 @@

 /* General customization:
  */
-#define __HAVE_AGP		1
-#define __MUST_HAVE_AGP		1
-#define __HAVE_MTRR		1
 #define __HAVE_CTX_BITMAP	1

 #define DRIVER_AUTHOR		"VA Linux Systems Inc."
===== drivers/char/drm/i810_dma.c 1.39 vs edited =====
--- 1.39/drivers/char/drm/i810_dma.c	Fri Sep  3 20:00:58 2004
+++ edited/drivers/char/drm/i810_dma.c	Sat Sep  4 19:03:35 2004
@@ -1407,6 +1407,7 @@

 void i810_driver_register_fns(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR;
 	dev->dev_priv_size = sizeof(drm_i810_buf_priv_t);
 	dev->fn_tbl.pretakedown = i810_driver_pretakedown;
 	dev->fn_tbl.release = i810_driver_release;
===== drivers/char/drm/i830.h 1.14 vs edited =====
--- 1.14/drivers/char/drm/i830.h	Fri Sep  3 19:49:23 2004
+++ edited/drivers/char/drm/i830.h	Sat Sep  4 19:03:35 2004
@@ -36,9 +36,6 @@

 /* General customization:
  */
-#define __HAVE_AGP		1
-#define __MUST_HAVE_AGP		1
-#define __HAVE_MTRR		1
 #define __HAVE_CTX_BITMAP	1

 #define DRIVER_AUTHOR		"VA Linux Systems Inc."
===== drivers/char/drm/i830_dma.c 1.29 vs edited =====
--- 1.29/drivers/char/drm/i830_dma.c	Fri Sep  3 20:00:58 2004
+++ edited/drivers/char/drm/i830_dma.c	Sat Sep  4 19:03:35 2004
@@ -1602,6 +1602,7 @@

 void i830_driver_register_fns(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR;
 	dev->dev_priv_size = sizeof(drm_i830_buf_priv_t);
 	dev->fn_tbl.pretakedown = i830_driver_pretakedown;
 	dev->fn_tbl.release = i830_driver_release;
===== drivers/char/drm/i915.h 1.2 vs edited =====
--- 1.2/drivers/char/drm/i915.h	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/i915.h	Sat Sep  4 19:03:44 2004
@@ -16,9 +16,6 @@

 /* General customization:
  */
-#define __HAVE_AGP		1
-#define __MUST_HAVE_AGP		1
-#define __HAVE_MTRR		1
 #define __HAVE_CTX_BITMAP	1

 #define DRIVER_AUTHOR		"Tungsten Graphics, Inc."
===== drivers/char/drm/i915_dma.c 1.4 vs edited =====
--- 1.4/drivers/char/drm/i915_dma.c	Fri Sep  3 20:00:58 2004
+++ edited/drivers/char/drm/i915_dma.c	Sat Sep  4 19:03:44 2004
@@ -732,6 +732,7 @@

 void i915_driver_register_fns(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR;
 	dev->fn_tbl.pretakedown = i915_driver_pretakedown;
 	dev->fn_tbl.prerelease = i915_driver_prerelease;
 }
===== drivers/char/drm/mga.h 1.12 vs edited =====
--- 1.12/drivers/char/drm/mga.h	Fri Sep  3 19:05:58 2004
+++ edited/drivers/char/drm/mga.h	Sat Sep  4 19:04:01 2004
@@ -36,9 +36,6 @@

 /* General customization:
  */
-#define __HAVE_AGP		1
-#define __MUST_HAVE_AGP		1
-#define __HAVE_MTRR		1
 #define __HAVE_CTX_BITMAP	1

 #define DRIVER_AUTHOR		"Gareth Hughes, VA Linux Systems Inc."
===== drivers/char/drm/mga_dma.c 1.21 vs edited =====
--- 1.21/drivers/char/drm/mga_dma.c	Fri Sep  3 20:00:58 2004
+++ edited/drivers/char/drm/mga_dma.c	Sat Sep  4 19:04:01 2004
@@ -813,6 +813,7 @@

 void mga_driver_register_fns(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR;
 	dev->fn_tbl.pretakedown = mga_driver_pretakedown;
 	dev->fn_tbl.dma_quiescent = mga_driver_dma_quiescent;
 }
===== drivers/char/drm/r128.h 1.16 vs edited =====
--- 1.16/drivers/char/drm/r128.h	Fri Sep  3 19:05:58 2004
+++ edited/drivers/char/drm/r128.h	Sat Sep  4 19:04:01 2004
@@ -36,9 +36,6 @@

 /* General customization:
  */
-#define __HAVE_AGP		1
-#define __MUST_HAVE_AGP		0
-#define __HAVE_MTRR		1
 #define __HAVE_CTX_BITMAP	1
 #define __HAVE_SG		1
 #define __HAVE_PCI_DMA		1
===== drivers/char/drm/r128_cce.c 1.22 vs edited =====
--- 1.22/drivers/char/drm/r128_cce.c	Fri Sep  3 20:00:58 2004
+++ edited/drivers/char/drm/r128_cce.c	Sat Sep  4 19:04:01 2004
@@ -322,7 +322,7 @@
 	/* The manual (p. 2) says this address is in "VM space".  This
 	 * means it's an offset from the start of AGP space.
 	 */
-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	if ( !dev_priv->is_pci )
 		ring_start = dev_priv->cce_ring->offset - dev->agp->base;
 	else
@@ -510,7 +510,7 @@
 		(drm_r128_sarea_t *)((u8 *)dev_priv->sarea->handle +
 				     init->sarea_priv_offset);

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	if ( !dev_priv->is_pci ) {
 		drm_core_ioremap( dev_priv->cce_ring, dev );
 		drm_core_ioremap( dev_priv->ring_rptr, dev );
@@ -533,7 +533,7 @@
 		dev->agp_buffer_map->handle = (void *)dev->agp_buffer_map->offset;
 	}

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	if ( !dev_priv->is_pci )
 		dev_priv->cce_buffers_offset = dev->agp->base;
 	else
@@ -558,7 +558,7 @@
 	R128_WRITE( R128_LAST_DISPATCH_REG,
 		    dev_priv->sarea_priv->last_dispatch );

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	if ( dev_priv->is_pci ) {
 #endif
 		if (!DRM(ati_pcigart_init)( dev, &dev_priv->phys_pci_gart,
@@ -569,7 +569,7 @@
 			return DRM_ERR(ENOMEM);
 		}
 		R128_WRITE( R128_PCI_GART_PAGE, dev_priv->bus_pci_gart );
-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	}
 #endif

@@ -597,7 +597,7 @@
 	if ( dev->dev_private ) {
 		drm_r128_private_t *dev_priv = dev->dev_private;

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 		if ( !dev_priv->is_pci ) {
 			if ( dev_priv->cce_ring != NULL )
 				drm_core_ioremapfree( dev_priv->cce_ring, dev );
===== drivers/char/drm/r128_state.c 1.19 vs edited =====
--- 1.19/drivers/char/drm/r128_state.c	Fri Sep  3 19:05:58 2004
+++ edited/drivers/char/drm/r128_state.c	Sat Sep  4 19:04:01 2004
@@ -1712,6 +1712,7 @@

 void r128_driver_register_fns(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_USE_MTRR;
 	dev->dev_priv_size = sizeof(drm_r128_buf_priv_t);
 	dev->fn_tbl.prerelease = r128_driver_prerelease;
 	dev->fn_tbl.pretakedown = r128_driver_pretakedown;
===== drivers/char/drm/radeon.h 1.23 vs edited =====
--- 1.23/drivers/char/drm/radeon.h	Fri Sep  3 19:05:58 2004
+++ edited/drivers/char/drm/radeon.h	Sat Sep  4 19:04:01 2004
@@ -37,9 +37,6 @@

 /* General customization:
  */
-#define __HAVE_AGP		1
-#define __MUST_HAVE_AGP		0
-#define __HAVE_MTRR		1
 #define __HAVE_CTX_BITMAP	1
 #define __HAVE_SG		1
 #define __HAVE_PCI_DMA		1
===== drivers/char/drm/radeon_cp.c 1.28 vs edited =====
--- 1.28/drivers/char/drm/radeon_cp.c	Fri Sep  3 20:00:58 2004
+++ edited/drivers/char/drm/radeon_cp.c	Sat Sep  4 19:13:57 2004
@@ -858,7 +858,7 @@
 		      ( ( dev_priv->gart_vm_start - 1 ) & 0xffff0000 )
 		    | ( dev_priv->fb_location >> 16 ) );

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	if ( !dev_priv->is_pci ) {
 		RADEON_WRITE( RADEON_MC_AGP_LOCATION,
 			      (((dev_priv->gart_vm_start - 1 +
@@ -885,7 +885,7 @@
 	SET_RING_HEAD( dev_priv, cur_read_ptr );
 	dev_priv->ring.tail = cur_read_ptr;

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	if ( !dev_priv->is_pci ) {
 		RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR,
 			      dev_priv->ring_rptr->offset
@@ -1161,7 +1161,7 @@
 		(drm_radeon_sarea_t *)((u8 *)dev_priv->sarea->handle +
 				       init->sarea_priv_offset);

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	if ( !dev_priv->is_pci ) {
 		drm_core_ioremap( dev_priv->cp_ring, dev );
 		drm_core_ioremap( dev_priv->ring_rptr, dev );
@@ -1211,7 +1211,7 @@
 	dev_priv->gart_vm_start = dev_priv->fb_location
 				+ RADEON_READ( RADEON_CONFIG_APER_SIZE );

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	if ( !dev_priv->is_pci )
 		dev_priv->gart_buffers_offset = (dev->agp_buffer_map->offset
 						- dev->agp->base
@@ -1240,7 +1240,7 @@

 	dev_priv->ring.high_mark = RADEON_RING_HIGH_MARK;

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	if ( !dev_priv->is_pci ) {
 		/* Turn off PCI GART */
 		radeon_set_pcigart( dev_priv, 0 );
@@ -1286,7 +1286,7 @@
 	if ( dev->dev_private ) {
 		drm_radeon_private_t *dev_priv = dev->dev_private;

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 		if ( !dev_priv->is_pci ) {
 			if ( dev_priv->cp_ring != NULL )
 				drm_core_ioremapfree( dev_priv->cp_ring, dev );
@@ -1329,7 +1329,7 @@

 	DRM_DEBUG("Starting radeon_do_resume_cp()\n");

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	if ( !dev_priv->is_pci ) {
 		/* Turn off PCI GART */
 		radeon_set_pcigart( dev_priv, 0 );
===== drivers/char/drm/radeon_state.c 1.31 vs edited =====
--- 1.31/drivers/char/drm/radeon_state.c	Fri Sep  3 19:05:58 2004
+++ edited/drivers/char/drm/radeon_state.c	Sat Sep  4 19:04:01 2004
@@ -2582,6 +2582,7 @@

 void radeon_driver_register_fns(struct drm_device *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_USE_MTRR;
 	dev->dev_priv_size = sizeof(drm_radeon_buf_priv_t);
 	dev->fn_tbl.prerelease = radeon_driver_prerelease;
 	dev->fn_tbl.pretakedown = radeon_driver_pretakedown;
===== drivers/char/drm/sis.h 1.9 vs edited =====
--- 1.9/drivers/char/drm/sis.h	Fri Sep  3 19:05:58 2004
+++ edited/drivers/char/drm/sis.h	Sat Sep  4 19:04:01 2004
@@ -41,9 +41,6 @@

 /* General customization:
  */
-#define __HAVE_AGP		1
-#define __MUST_HAVE_AGP		0
-#define __HAVE_MTRR		1
 #define __HAVE_CTX_BITMAP	1

 #define DRIVER_AUTHOR		"SIS"
===== drivers/char/drm/sis_mm.c 1.13 vs edited =====
--- 1.13/drivers/char/drm/sis_mm.c	Fri Sep  3 19:05:58 2004
+++ edited/drivers/char/drm/sis_mm.c	Sat Sep  4 19:04:01 2004
@@ -407,6 +407,7 @@

 void DRM(driver_register_fns)(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_USE_MTRR;
 	dev->fn_tbl.context_ctor = sis_init_context;
 	dev->fn_tbl.context_dtor = sis_final_context;
 }
===== drivers/char/drm/tdfx.h 1.5 vs edited =====
--- 1.5/drivers/char/drm/tdfx.h	Thu Apr 22 21:25:27 2004
+++ edited/drivers/char/drm/tdfx.h	Sat Sep  4 19:04:01 2004
@@ -36,7 +36,6 @@

 /* General customization:
  */
-#define __HAVE_MTRR		1
 #define __HAVE_CTX_BITMAP	1

 #define DRIVER_AUTHOR		"VA Linux Systems Inc."
===== drivers/char/drm/tdfx_drv.c 1.8 vs edited =====
--- 1.8/drivers/char/drm/tdfx_drv.c	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/tdfx_drv.c	Sat Sep  4 19:28:19 2004
@@ -34,6 +34,7 @@
 #include "tdfx.h"
 #include "drmP.h"

+#include "drm_agpsupport.h"
 #include "drm_auth.h"
 #include "drm_bufs.h"
 #include "drm_context.h"
@@ -52,5 +53,6 @@

 void DRM(driver_register_fns)(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_MTRR;
 }

