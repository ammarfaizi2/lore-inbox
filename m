Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUIEBIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUIEBIf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 21:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUIEBIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 21:08:34 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:51604 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S265127AbUIEBFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 21:05:14 -0400
Date: Sun, 5 Sep 2004 02:05:12 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK pull] DRM macro removal part 2
Message-ID: <Pine.LNX.4.58.0409050203270.29736@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
	This is the second set of macro removals, it removes __HAVE_AGP,
__HAVE_MTRR, __HAVE_CTX_BITMAP, __HAVE_SG, __HAVE_PCI_DMA and
DRIVER_FILE_FIELDS.

I've one remaining patch for getting rid of HAVE_IRQ and HAVE_DMA but it is
the most intricate one so far, so I'll submit it separately after I submit to
LK for review.

Please do a

	bk pull bk://drm.bkbits.net/drm-fntbl

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/drmP.h             |   71 ++++++++++++------------
 drivers/char/drm/drm_agpsupport.h   |    5 -
 drivers/char/drm/drm_bufs.h         |   69 +++++++++--------------
 drivers/char/drm/drm_context.h      |    6 --
 drivers/char/drm/drm_drv.h          |  104 ++++++++++++++----------------------
 drivers/char/drm/drm_fops.h         |   12 +++-
 drivers/char/drm/drm_memory.h       |   37 +++++++-----
 drivers/char/drm/drm_memory_debug.h |    2
 drivers/char/drm/drm_os_linux.h     |   26 +++++++++
 drivers/char/drm/drm_scatter.h      |    6 ++
 drivers/char/drm/drm_vm.h           |   23 ++++---
 drivers/char/drm/gamma.h            |    5 -
 drivers/char/drm/gamma_dma.c        |    1
 drivers/char/drm/gamma_drv.c        |    1
 drivers/char/drm/i810.h             |    4 -
 drivers/char/drm/i810_dma.c         |    1
 drivers/char/drm/i810_drv.c         |    1
 drivers/char/drm/i830.h             |    4 -
 drivers/char/drm/i830_dma.c         |    1
 drivers/char/drm/i830_drv.c         |    1
 drivers/char/drm/i915.h             |    4 -
 drivers/char/drm/i915_dma.c         |    1
 drivers/char/drm/i915_drv.c         |    1
 drivers/char/drm/mga.h              |    4 -
 drivers/char/drm/mga_dma.c          |    1
 drivers/char/drm/mga_drv.c          |    1
 drivers/char/drm/r128.h             |    7 --
 drivers/char/drm/r128_cce.c         |   12 ++--
 drivers/char/drm/r128_state.c       |    1
 drivers/char/drm/radeon.h           |    9 ---
 drivers/char/drm/radeon_cp.c        |   14 ++--
 drivers/char/drm/radeon_drv.h       |    3 +
 drivers/char/drm/radeon_state.c     |   33 +++++++++--
 drivers/char/drm/sis.h              |    4 -
 drivers/char/drm/sis_drv.c          |    1
 drivers/char/drm/sis_mm.c           |    1
 drivers/char/drm/tdfx.h             |    2
 drivers/char/drm/tdfx_drv.c         |    3 +
 38 files changed, 247 insertions(+), 235 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/09/05 1.2022)
   remove DRIVER_FILE_FIELDS, replace with a private driver structure
   allocated in open helper and freed in free_filp_priv.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/09/05 1.2021)
   Drop __HAVE_CTX_BITMAP, __HAVE_SG, __HAVE_PCI_DMA, these are
   fairly straightforward removals..

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/09/05 1.2020)
   Remove __HAVE_AGP and __HAVE_MTRR, add driver features bitmask,
   Cleaned up a lot of #ifdef in functions using suggestions from Arjan.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
--- a/drivers/char/drm/drmP.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/drmP.h	Sun Sep  5 10:58:50 2004
@@ -73,22 +73,22 @@
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
-#ifndef __HAVE_CTX_BITMAP
-#define __HAVE_CTX_BITMAP	0
-#endif
+/* driver capabilities and requirements mask */
+#define DRIVER_USE_AGP     0x1
+#define DRIVER_REQUIRE_AGP 0x2
+#define DRIVER_USE_MTRR    0x4
+#define DRIVER_PCI_DMA     0x8
+#define DRIVER_SG          0x10
+
 #ifndef __HAVE_DMA
 #define __HAVE_DMA		0
 #endif
@@ -96,14 +96,6 @@
 #define __HAVE_IRQ		0
 #endif

-#define __REALLY_HAVE_AGP	(__HAVE_AGP && (defined(CONFIG_AGP) || \
-						defined(CONFIG_AGP_MODULE)))
-#define __REALLY_HAVE_MTRR	(__HAVE_MTRR && defined(CONFIG_MTRR))
-#define __REALLY_HAVE_SG	(__HAVE_SG)
-
-/*@}*/
-
-
 /***********************************************************************/
 /** \name Begin the DRM... */
 /*@{*/
@@ -419,9 +411,7 @@
 	struct drm_device *dev;
 	int 		  remove_auth_on_close;
 	unsigned long     lock_count;
-#ifdef DRIVER_FILE_FIELDS
-	DRIVER_FILE_FIELDS;
-#endif
+	void              *driver_priv;
 } drm_file_t;

 /** Wait queue */
@@ -479,7 +469,6 @@
 	/*@}*/
 } drm_device_dma_t;

-#if __REALLY_HAVE_AGP
 /**
  * AGP memory entry.  Stored as a doubly linked list.
  */
@@ -508,7 +497,6 @@
 	int		   cant_use_aperture;
 	unsigned long	   page_mask;
 } drm_agp_head_t;
-#endif

 /**
  * Scatter-gather memory.
@@ -569,7 +557,8 @@
 	int (*postcleanup)(struct drm_device *);
 	int (*presetup)(struct drm_device *);
 	int (*postsetup)(struct drm_device *);
-	void (*open_helper)(struct drm_device *, drm_file_t *);
+	int (*open_helper)(struct drm_device *, drm_file_t *);
+	void (*free_filp_priv)(struct drm_device *, drm_file_t *);
 	void (*release)(struct drm_device *, struct file *filp);
 	void (*dma_ready)(struct drm_device *);
 	int (*dma_quiescent)(struct drm_device *);
@@ -685,9 +674,7 @@
 	wait_queue_head_t buf_readers;	/**< Processes waiting to read */
 	wait_queue_head_t buf_writers;	/**< Processes waiting to ctx switch */

-#if __REALLY_HAVE_AGP
 	drm_agp_head_t    *agp;	/**< AGP data */
-#endif

 	struct pci_dev    *pdev;	/**< PCI device structure */
 	int               pci_domain;	/**< PCI bus domain number */
@@ -710,8 +697,32 @@
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
@@ -768,12 +779,10 @@
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
@@ -810,10 +819,8 @@
 extern int	     DRM(context_switch)(drm_device_t *dev, int old, int new);
 extern int	     DRM(context_switch_complete)(drm_device_t *dev, int new);

-#if __HAVE_CTX_BITMAP
 extern int	     DRM(ctxbitmap_init)( drm_device_t *dev );
 extern void	     DRM(ctxbitmap_cleanup)( drm_device_t *dev );
-#endif

 extern int	     DRM(setsareactx)( struct inode *inode, struct file *filp,
 				       unsigned int cmd, unsigned long arg );
@@ -900,7 +907,6 @@
 #endif


-#if __REALLY_HAVE_AGP
 				/* AGP/GART support (drm_agpsupport.h) */
 extern drm_agp_head_t *DRM(agp_init)(void);
 extern void           DRM(agp_uninit)(void);
@@ -925,7 +931,6 @@
 extern int            DRM(agp_free_memory)(DRM_AGP_MEM *handle);
 extern int            DRM(agp_bind_memory)(DRM_AGP_MEM *handle, off_t start);
 extern int            DRM(agp_unbind_memory)(DRM_AGP_MEM *handle);
-#endif

 				/* Stub support (drm_stub.h) */
 int                   DRM(stub_register)(const char *name,
@@ -942,14 +947,12 @@
 					struct proc_dir_entry *root,
 					struct proc_dir_entry *dev_root);

-#ifdef __HAVE_SG
 				/* Scatter Gather Support (drm_scatter.h) */
 extern void           DRM(sg_cleanup)(drm_sg_mem_t *entry);
 extern int            DRM(sg_alloc)(struct inode *inode, struct file *filp,
 				    unsigned int cmd, unsigned long arg);
 extern int            DRM(sg_free)(struct inode *inode, struct file *filp,
 				   unsigned int cmd, unsigned long arg);
-#endif

                                /* ATI PCIGART support (ati_pcigart.h) */
 extern int            DRM(ati_pcigart_init)(drm_device_t *dev,
diff -Nru a/drivers/char/drm/drm_agpsupport.h b/drivers/char/drm/drm_agpsupport.h
--- a/drivers/char/drm/drm_agpsupport.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/drm_agpsupport.h	Sun Sep  5 10:58:50 2004
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
diff -Nru a/drivers/char/drm/drm_bufs.h b/drivers/char/drm/drm_bufs.h
--- a/drivers/char/drm/drm_bufs.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/drm_bufs.h	Sun Sep  5 10:58:50 2004
@@ -36,14 +36,6 @@
 #include <linux/vmalloc.h>
 #include "drmP.h"

-#ifndef __HAVE_PCI_DMA
-#define __HAVE_PCI_DMA		0
-#endif
-
-#ifndef __HAVE_SG
-#define __HAVE_SG		0
-#endif
-
 /**
  * Compute size order.  Returns the exponent of the smaller power of two which
  * is greater or equal to given number.
@@ -130,13 +122,13 @@
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
@@ -162,15 +154,15 @@
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
@@ -270,15 +262,15 @@
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
@@ -340,7 +332,7 @@
 	}
 }

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 /**
  * Add AGP buffers for DMA transfers (ioctl).
  *
@@ -517,9 +509,8 @@
 	atomic_dec( &dev->buf_alloc );
 	return 0;
 }
-#endif /* __REALLY_HAVE_AGP */
+#endif /* __OS_HAS_AGP */

-#if __HAVE_PCI_DMA
 int DRM(addbufs_pci)( struct inode *inode, struct file *filp,
 		      unsigned int cmd, unsigned long arg )
 {
@@ -544,6 +535,7 @@
 	drm_buf_t **temp_buflist;
 	drm_buf_desc_t __user *argp = (void __user *)arg;

+	if (!drm_core_check_feature(dev, DRIVER_PCI_DMA)) return -EINVAL;
 	if ( !dma ) return -EINVAL;

 	if ( copy_from_user( &request, argp, sizeof(request) ) )
@@ -749,9 +741,7 @@
 	return 0;

 }
-#endif /* __HAVE_PCI_DMA */

-#if __HAVE_SG
 int DRM(addbufs_sg)( struct inode *inode, struct file *filp,
                      unsigned int cmd, unsigned long arg )
 {
@@ -774,6 +764,8 @@
 	int i;
 	drm_buf_t **temp_buflist;

+	if (!drm_core_check_feature(dev, DRIVER_SG)) return -EINVAL;
+
 	if ( !dma ) return -EINVAL;

 	if ( copy_from_user( &request, argp, sizeof(request) ) )
@@ -915,7 +907,6 @@
 	atomic_dec( &dev->buf_alloc );
 	return 0;
 }
-#endif /* __HAVE_SG */

 /**
  * Add buffers for DMA transfers (ioctl).
@@ -940,21 +931,15 @@
 			     sizeof(request) ) )
 		return -EFAULT;

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	if ( request.flags & _DRM_AGP_BUFFER )
 		return DRM(addbufs_agp)( inode, filp, cmd, arg );
 	else
 #endif
-#if __HAVE_SG
 	if ( request.flags & _DRM_SG_BUFFER )
 		return DRM(addbufs_sg)( inode, filp, cmd, arg );
 	else
-#endif
-#if __HAVE_PCI_DMA
 		return DRM(addbufs_pci)( inode, filp, cmd, arg );
-#else
-		return -EINVAL;
-#endif
 }


@@ -1185,8 +1170,8 @@
 		return -EFAULT;

 	if ( request.count >= dma->buf_count ) {
-		if ( (__HAVE_AGP && (dma->flags & _DRM_DMA_USE_AGP)) ||
-		     (__HAVE_SG && (dma->flags & _DRM_DMA_USE_SG)) ) {
+		if ((drm_core_has_AGP(dev) && (dma->flags & _DRM_DMA_USE_AGP)) ||
+		    (drm_core_check_feature(dev, DRIVER_SG) && (dma->flags & _DRM_DMA_USE_SG)) ) {
 			drm_map_t *map = dev->agp_buffer_map;

 			if ( !map ) {
diff -Nru a/drivers/char/drm/drm_context.h b/drivers/char/drm/drm_context.h
--- a/drivers/char/drm/drm_context.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/drm_context.h	Sun Sep  5 10:58:50 2004
@@ -42,11 +42,6 @@

 #include "drmP.h"

-#if !__HAVE_CTX_BITMAP
-#error "__HAVE_CTX_BITMAP must be defined"
-#endif
-
-
 /******************************************************************/
 /** \name Context bitmap support */
 /*@{*/
@@ -580,3 +575,4 @@
 }

 /*@}*/
+
diff -Nru a/drivers/char/drm/drm_drv.h b/drivers/char/drm/drm_drv.h
--- a/drivers/char/drm/drm_drv.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/drm_drv.h	Sun Sep  5 10:58:50 2004
@@ -52,12 +52,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */

-#ifndef __MUST_HAVE_AGP
-#define __MUST_HAVE_AGP			0
-#endif
-#ifndef __HAVE_CTX_BITMAP
-#define __HAVE_CTX_BITMAP		0
-#endif
+
 #ifndef __HAVE_IRQ
 #define __HAVE_IRQ			0
 #endif
@@ -70,9 +65,6 @@
 #ifndef __HAVE_COUNTERS
 #define __HAVE_COUNTERS			0
 #endif
-#ifndef __HAVE_SG
-#define __HAVE_SG			0
-#endif

 #ifndef DRIVER_IOCTLS
 #define DRIVER_IOCTLS
@@ -133,10 +125,8 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_ADD_MAP)]       = { DRM(addmap),      1, 1 },
 	[DRM_IOCTL_NR(DRM_IOCTL_RM_MAP)]        = { DRM(rmmap),       1, 0 },

-#if __HAVE_CTX_BITMAP
 	[DRM_IOCTL_NR(DRM_IOCTL_SET_SAREA_CTX)] = { DRM(setsareactx), 1, 1 },
 	[DRM_IOCTL_NR(DRM_IOCTL_GET_SAREA_CTX)] = { DRM(getsareactx), 1, 0 },
-#endif

 	[DRM_IOCTL_NR(DRM_IOCTL_ADD_CTX)]       = { DRM(addctx),      1, 1 },
 	[DRM_IOCTL_NR(DRM_IOCTL_RM_CTX)]        = { DRM(rmctx),       1, 1 },
@@ -166,7 +156,7 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_CONTROL)]       = { DRM(control),     1, 1 },
 #endif

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	[DRM_IOCTL_NR(DRM_IOCTL_AGP_ACQUIRE)]   = { DRM(agp_acquire), 1, 1 },
 	[DRM_IOCTL_NR(DRM_IOCTL_AGP_RELEASE)]   = { DRM(agp_release), 1, 1 },
 	[DRM_IOCTL_NR(DRM_IOCTL_AGP_ENABLE)]    = { DRM(agp_enable),  1, 1 },
@@ -177,10 +167,8 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_AGP_UNBIND)]    = { DRM(agp_unbind),  1, 1 },
 #endif

-#if __HAVE_SG
 	[DRM_IOCTL_NR(DRM_IOCTL_SG_ALLOC)]      = { DRM(sg_alloc),    1, 1 },
 	[DRM_IOCTL_NR(DRM_IOCTL_SG_FREE)]       = { DRM(sg_free),     1, 1 },
-#endif

 #ifdef __HAVE_VBL_IRQ
 	[DRM_IOCTL_NR(DRM_IOCTL_WAIT_VBLANK)]   = { DRM(wait_vblank), 0, 0 },
@@ -367,9 +355,8 @@
 		dev->magiclist[i].head = dev->magiclist[i].tail = NULL;
 	}

-#if __REALLY_HAVE_AGP
 				/* Clear AGP information */
-	if ( dev->agp ) {
+	if (drm_core_has_AGP(dev) && dev->agp) {
 		drm_agp_mem_t *entry;
 		drm_agp_mem_t *nexte;

@@ -388,7 +375,6 @@
 		dev->agp->acquired = 0;
 		dev->agp->enabled  = 0;
 	}
-#endif

 				/* Clear vma list (only built for debugging) */
 	if ( dev->vmalist ) {
@@ -407,15 +393,15 @@
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
@@ -428,15 +414,11 @@
 					 */
 					break;
 				case _DRM_SCATTER_GATHER:
-					/* Handle it, but do nothing, if HAVE_SG
-					 * isn't defined.
-					 */
-#if __HAVE_SG
-					if(dev->sg) {
+					/* Handle it */
+					if (drm_core_check_feature(dev, DRIVER_SG) && dev->sg) {
 						DRM(sg_cleanup)(dev->sg);
 						dev->sg = NULL;
 					}
-#endif
 					break;
 				}
 				DRM(free)(map, sizeof(*map), DRM_MEM_MAPS);
@@ -488,9 +470,7 @@
 static int DRM(probe)(struct pci_dev *pdev)
 {
 	drm_device_t *dev;
-#if __HAVE_CTX_BITMAP
 	int retcode;
-#endif
 	int i;
 	int is_compat = 0;

@@ -540,34 +520,32 @@
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

-#if __HAVE_CTX_BITMAP
 	retcode = DRM(ctxbitmap_init)( dev );
 	if( retcode ) {
 		DRM_ERROR( "Cannot allocate memory for context bitmap.\n" );
 		DRM(stub_unregister)(dev->minor);
 		DRM(takedown)( dev );
 		return retcode;
- 	}
-#endif
+	}
+
 	DRM(numdevs)++; /* no errors, mark it reserved */

 	DRM_INFO( "Initialized %s %d.%d.%d %s on minor %d: %s\n",
@@ -640,29 +618,26 @@
 				DRM_INFO( "Module unloaded\n" );
 			}
 		}
-#if __HAVE_CTX_BITMAP
+
 		DRM(ctxbitmap_cleanup)( dev );
-#endif

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

@@ -860,9 +835,9 @@
 			     pos->handle != DRM_KERNEL_CONTEXT ) {
 				if (dev->fn_tbl.context_dtor)
 					dev->fn_tbl.context_dtor(dev, pos->handle);
-#if __HAVE_CTX_BITMAP
+
 				DRM(ctxbitmap_free)( dev, pos->handle );
-#endif
+
 				list_del( &pos->head );
 				DRM(free)( pos, sizeof(*pos), DRM_MEM_CTXLIST );
 			}
@@ -890,6 +865,9 @@
 	}
 	up( &dev->struct_sem );

+	if (dev->fn_tbl.free_filp_priv)
+		dev->fn_tbl.free_filp_priv(dev, priv);
+
 	DRM(free)( priv, sizeof(*priv), DRM_MEM_FILES );

 	/* ========================================================
diff -Nru a/drivers/char/drm/drm_fops.h b/drivers/char/drm/drm_fops.h
--- a/drivers/char/drm/drm_fops.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/drm_fops.h	Sun Sep  5 10:58:50 2004
@@ -53,6 +53,7 @@
 {
 	int	     minor = iminor(inode);
 	drm_file_t   *priv;
+	int ret;

 	if (filp->f_flags & O_EXCL)   return -EBUSY; /* No exclusive opens */
 	if (!DRM(cpu_valid)())        return -EINVAL;
@@ -72,8 +73,11 @@
 	priv->authenticated = capable(CAP_SYS_ADMIN);
 	priv->lock_count    = 0;

-	if (dev->fn_tbl.open_helper)
-	  dev->fn_tbl.open_helper(dev, priv);
+	if (dev->fn_tbl.open_helper) {
+		ret=dev->fn_tbl.open_helper(dev, priv);
+		if (ret < 0)
+			goto out_free;
+	}

 	down(&dev->struct_sem);
 	if (!dev->file_last) {
@@ -105,6 +109,10 @@
 #endif

 	return 0;
+out_free:
+	DRM(free)(priv, sizeof(*priv), DRM_MEM_FILES);
+	filp->private_data=NULL;
+	return ret;
 }

 /** No-op. */
diff -Nru a/drivers/char/drm/drm_memory.h b/drivers/char/drm/drm_memory.h
--- a/drivers/char/drm/drm_memory.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/drm_memory.h	Sun Sep  5 10:58:50 2004
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
diff -Nru a/drivers/char/drm/drm_memory_debug.h b/drivers/char/drm/drm_memory_debug.h
--- a/drivers/char/drm/drm_memory_debug.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/drm_memory_debug.h	Sun Sep  5 10:58:50 2004
@@ -352,7 +352,7 @@
 	}
 }

-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP

 DRM_AGP_MEM *DRM(alloc_agp)(int pages, u32 type)
 {
diff -Nru a/drivers/char/drm/drm_os_linux.h b/drivers/char/drm/drm_os_linux.h
--- a/drivers/char/drm/drm_os_linux.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/drm_os_linux.h	Sun Sep  5 10:58:50 2004
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
diff -Nru a/drivers/char/drm/drm_scatter.h b/drivers/char/drm/drm_scatter.h
--- a/drivers/char/drm/drm_scatter.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/drm_scatter.h	Sun Sep  5 10:58:50 2004
@@ -73,6 +73,9 @@

 	DRM_DEBUG( "%s\n", __FUNCTION__ );

+	if (drm_core_check_feature(dev, DRIVER_SG))
+		return -EINVAL;
+
 	if ( dev->sg )
 		return -EINVAL;

@@ -205,6 +208,9 @@
 	drm_device_t *dev = priv->dev;
 	drm_scatter_gather_t request;
 	drm_sg_mem_t *entry;
+
+	if (drm_core_check_feature(dev, DRIVER_SG))
+		return -EINVAL;

 	if ( copy_from_user( &request,
 			     (drm_scatter_gather_t __user *)arg,
diff -Nru a/drivers/char/drm/drm_vm.h b/drivers/char/drm/drm_vm.h
--- a/drivers/char/drm/drm_vm.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/drm_vm.h	Sun Sep  5 10:58:50 2004
@@ -46,10 +46,10 @@
  * Find the right map and if it's AGP memory find the real physical page to
  * map, get the page, increment the use count and return it.
  */
+#if __OS_HAS_AGP
 static __inline__ struct page *DRM(do_vm_nopage)(struct vm_area_struct *vma,
 						 unsigned long address)
 {
-#if __REALLY_HAVE_AGP
 	drm_file_t *priv  = vma->vm_file->private_data;
 	drm_device_t *dev = priv->dev;
 	drm_map_t *map    = NULL;
@@ -59,6 +59,8 @@
 	/*
          * Find the right map
          */
+	if (!drm_core_has_AGP(dev))
+		goto vm_nopage_error;

 	if(!dev->agp || !dev->agp->cant_use_aperture) goto vm_nopage_error;

@@ -107,10 +109,15 @@
 		return page;
         }
 vm_nopage_error:
-#endif /* __REALLY_HAVE_AGP */
-
 	return NOPAGE_SIGBUS;		/* Disallow mremap */
 }
+#else /* __OS_HAS_AGP */
+static __inline__ struct page *DRM(do_vm_nopage)(struct vm_area_struct *vma,
+						 unsigned long address)
+{
+	return NOPAGE_SIGBUS;
+}
+#endif /* __OS_HAS_AGP */

 /**
  * \c nopage method for shared virtual memory.
@@ -201,15 +208,13 @@
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
@@ -533,7 +538,7 @@
 	 * --BenH.
 	 */
 	if (!VM_OFFSET(vma)
-#if __REALLY_HAVE_AGP
+#if __OS_HAS_AGP
 	    && (!dev->agp || dev->agp->agp_info.device->vendor != PCI_VENDOR_ID_APPLE)
 #endif
 	    )
@@ -577,8 +582,7 @@

 	switch (map->type) {
         case _DRM_AGP:
-#if __REALLY_HAVE_AGP
-	  if (dev->agp->cant_use_aperture) {
+	  if (drm_core_has_AGP(dev) && dev->agp->cant_use_aperture) {
                 /*
                  * On some platforms we can't talk to bus dma address from the CPU, so for
                  * memory of type DRM_AGP, we'll deal with sorting out the real physical
@@ -590,7 +594,6 @@
                 vma->vm_ops = &DRM(vm_ops);
                 break;
 	  }
-#endif
                 /* fall through to _DRM_FRAME_BUFFER... */
 	case _DRM_FRAME_BUFFER:
 	case _DRM_REGISTERS:
diff -Nru a/drivers/char/drm/gamma.h b/drivers/char/drm/gamma.h
--- a/drivers/char/drm/gamma.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/gamma.h	Sun Sep  5 10:58:50 2004
@@ -36,8 +36,6 @@

 /* General customization:
  */
-#define __HAVE_MTRR			1
-
 #define DRIVER_AUTHOR		"VA Linux Systems Inc."

 #define DRIVER_NAME		"gamma"
@@ -72,10 +70,7 @@
 /* DMA customization:
  */
 #define __HAVE_DMA			1
-#define __HAVE_AGP			1
-#define __MUST_HAVE_AGP			0
 #define __HAVE_OLD_DMA			1
-#define __HAVE_PCI_DMA			1

 #define __HAVE_MULTIPLE_DMA_QUEUES	1
 #define __HAVE_DMA_WAITQUEUE		1
diff -Nru a/drivers/char/drm/gamma_dma.c b/drivers/char/drm/gamma_dma.c
--- a/drivers/char/drm/gamma_dma.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/gamma_dma.c	Sun Sep  5 10:58:50 2004
@@ -934,6 +934,7 @@

 void gamma_driver_register_fns(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA;
 	DRM(fops).read = gamma_fops_read;
 	DRM(fops).poll = gamma_fops_poll;
 	dev->fn_tbl.preinit = gamma_driver_preinit;
diff -Nru a/drivers/char/drm/gamma_drv.c b/drivers/char/drm/gamma_drv.c
--- a/drivers/char/drm/gamma_drv.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/gamma_drv.c	Sun Sep  5 10:58:50 2004
@@ -56,3 +56,4 @@
 #include "drm_proc.h"
 #include "drm_vm.h"
 #include "drm_stub.h"
+#include "drm_scatter.h"
diff -Nru a/drivers/char/drm/i810.h b/drivers/char/drm/i810.h
--- a/drivers/char/drm/i810.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/i810.h	Sun Sep  5 10:58:50 2004
@@ -36,10 +36,6 @@

 /* General customization:
  */
-#define __HAVE_AGP		1
-#define __MUST_HAVE_AGP		1
-#define __HAVE_MTRR		1
-#define __HAVE_CTX_BITMAP	1

 #define DRIVER_AUTHOR		"VA Linux Systems Inc."

diff -Nru a/drivers/char/drm/i810_dma.c b/drivers/char/drm/i810_dma.c
--- a/drivers/char/drm/i810_dma.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/i810_dma.c	Sun Sep  5 10:58:50 2004
@@ -1407,6 +1407,7 @@

 void i810_driver_register_fns(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR;
 	dev->dev_priv_size = sizeof(drm_i810_buf_priv_t);
 	dev->fn_tbl.pretakedown = i810_driver_pretakedown;
 	dev->fn_tbl.release = i810_driver_release;
diff -Nru a/drivers/char/drm/i810_drv.c b/drivers/char/drm/i810_drv.c
--- a/drivers/char/drm/i810_drv.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/i810_drv.c	Sun Sep  5 10:58:50 2004
@@ -53,3 +53,4 @@
 #include "drm_proc.h"
 #include "drm_vm.h"
 #include "drm_stub.h"
+#include "drm_scatter.h"
diff -Nru a/drivers/char/drm/i830.h b/drivers/char/drm/i830.h
--- a/drivers/char/drm/i830.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/i830.h	Sun Sep  5 10:58:50 2004
@@ -36,10 +36,6 @@

 /* General customization:
  */
-#define __HAVE_AGP		1
-#define __MUST_HAVE_AGP		1
-#define __HAVE_MTRR		1
-#define __HAVE_CTX_BITMAP	1

 #define DRIVER_AUTHOR		"VA Linux Systems Inc."

diff -Nru a/drivers/char/drm/i830_dma.c b/drivers/char/drm/i830_dma.c
--- a/drivers/char/drm/i830_dma.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/i830_dma.c	Sun Sep  5 10:58:50 2004
@@ -1602,6 +1602,7 @@

 void i830_driver_register_fns(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR;
 	dev->dev_priv_size = sizeof(drm_i830_buf_priv_t);
 	dev->fn_tbl.pretakedown = i830_driver_pretakedown;
 	dev->fn_tbl.release = i830_driver_release;
diff -Nru a/drivers/char/drm/i830_drv.c b/drivers/char/drm/i830_drv.c
--- a/drivers/char/drm/i830_drv.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/i830_drv.c	Sun Sep  5 10:58:50 2004
@@ -56,3 +56,4 @@
 #include "drm_proc.h"
 #include "drm_vm.h"
 #include "drm_stub.h"
+#include "drm_scatter.h"
diff -Nru a/drivers/char/drm/i915.h b/drivers/char/drm/i915.h
--- a/drivers/char/drm/i915.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/i915.h	Sun Sep  5 10:58:50 2004
@@ -16,10 +16,6 @@

 /* General customization:
  */
-#define __HAVE_AGP		1
-#define __MUST_HAVE_AGP		1
-#define __HAVE_MTRR		1
-#define __HAVE_CTX_BITMAP	1

 #define DRIVER_AUTHOR		"Tungsten Graphics, Inc."

diff -Nru a/drivers/char/drm/i915_dma.c b/drivers/char/drm/i915_dma.c
--- a/drivers/char/drm/i915_dma.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/i915_dma.c	Sun Sep  5 10:58:50 2004
@@ -732,6 +732,7 @@

 void i915_driver_register_fns(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR;
 	dev->fn_tbl.pretakedown = i915_driver_pretakedown;
 	dev->fn_tbl.prerelease = i915_driver_prerelease;
 }
diff -Nru a/drivers/char/drm/i915_drv.c b/drivers/char/drm/i915_drv.c
--- a/drivers/char/drm/i915_drv.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/i915_drv.c	Sun Sep  5 10:58:50 2004
@@ -29,3 +29,4 @@
 #include "drm_proc.h"
 #include "drm_vm.h"
 #include "drm_stub.h"
+#include "drm_scatter.h"
diff -Nru a/drivers/char/drm/mga.h b/drivers/char/drm/mga.h
--- a/drivers/char/drm/mga.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/mga.h	Sun Sep  5 10:58:50 2004
@@ -36,10 +36,6 @@

 /* General customization:
  */
-#define __HAVE_AGP		1
-#define __MUST_HAVE_AGP		1
-#define __HAVE_MTRR		1
-#define __HAVE_CTX_BITMAP	1

 #define DRIVER_AUTHOR		"Gareth Hughes, VA Linux Systems Inc."

diff -Nru a/drivers/char/drm/mga_dma.c b/drivers/char/drm/mga_dma.c
--- a/drivers/char/drm/mga_dma.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/mga_dma.c	Sun Sep  5 10:58:50 2004
@@ -813,6 +813,7 @@

 void mga_driver_register_fns(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR;
 	dev->fn_tbl.pretakedown = mga_driver_pretakedown;
 	dev->fn_tbl.dma_quiescent = mga_driver_dma_quiescent;
 }
diff -Nru a/drivers/char/drm/mga_drv.c b/drivers/char/drm/mga_drv.c
--- a/drivers/char/drm/mga_drv.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/mga_drv.c	Sun Sep  5 10:58:50 2004
@@ -51,3 +51,4 @@
 #include "drm_proc.h"
 #include "drm_vm.h"
 #include "drm_stub.h"
+#include "drm_scatter.h"
diff -Nru a/drivers/char/drm/r128.h b/drivers/char/drm/r128.h
--- a/drivers/char/drm/r128.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/r128.h	Sun Sep  5 10:58:50 2004
@@ -36,13 +36,6 @@

 /* General customization:
  */
-#define __HAVE_AGP		1
-#define __MUST_HAVE_AGP		0
-#define __HAVE_MTRR		1
-#define __HAVE_CTX_BITMAP	1
-#define __HAVE_SG		1
-#define __HAVE_PCI_DMA		1
-
 #define DRIVER_AUTHOR		"Gareth Hughes, VA Linux Systems Inc."

 #define DRIVER_NAME		"r128"
diff -Nru a/drivers/char/drm/r128_cce.c b/drivers/char/drm/r128_cce.c
--- a/drivers/char/drm/r128_cce.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/r128_cce.c	Sun Sep  5 10:58:50 2004
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
diff -Nru a/drivers/char/drm/r128_state.c b/drivers/char/drm/r128_state.c
--- a/drivers/char/drm/r128_state.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/r128_state.c	Sun Sep  5 10:58:50 2004
@@ -1712,6 +1712,7 @@

 void r128_driver_register_fns(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA | DRIVER_SG;
 	dev->dev_priv_size = sizeof(drm_r128_buf_priv_t);
 	dev->fn_tbl.prerelease = r128_driver_prerelease;
 	dev->fn_tbl.pretakedown = r128_driver_pretakedown;
diff -Nru a/drivers/char/drm/radeon.h b/drivers/char/drm/radeon.h
--- a/drivers/char/drm/radeon.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/radeon.h	Sun Sep  5 10:58:50 2004
@@ -37,12 +37,6 @@

 /* General customization:
  */
-#define __HAVE_AGP		1
-#define __MUST_HAVE_AGP		0
-#define __HAVE_MTRR		1
-#define __HAVE_CTX_BITMAP	1
-#define __HAVE_SG		1
-#define __HAVE_PCI_DMA		1

 #define DRIVER_AUTHOR		"Gareth Hughes, Keith Whitwell, others."

@@ -114,9 +108,6 @@
  [DRM_IOCTL_NR(DRM_IOCTL_RADEON_IRQ_EMIT)]   = { radeon_irq_emit,    1, 0 }, \
  [DRM_IOCTL_NR(DRM_IOCTL_RADEON_IRQ_WAIT)]   = { radeon_irq_wait,    1, 0 }, \
  [DRM_IOCTL_NR(DRM_IOCTL_RADEON_SETPARAM)]   = { radeon_cp_setparam, 1, 0 }, \
-
-#define DRIVER_FILE_FIELDS						\
-	int64_t radeon_fb_delta;					\

 /* DMA customization:
  */
diff -Nru a/drivers/char/drm/radeon_cp.c b/drivers/char/drm/radeon_cp.c
--- a/drivers/char/drm/radeon_cp.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/radeon_cp.c	Sun Sep  5 10:58:50 2004
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
diff -Nru a/drivers/char/drm/radeon_drv.h b/drivers/char/drm/radeon_drv.h
--- a/drivers/char/drm/radeon_drv.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/radeon_drv.h	Sun Sep  5 10:58:50 2004
@@ -60,6 +60,9 @@
 	u32 se_cntl;
 } drm_radeon_depth_clear_t;

+struct drm_radeon_driver_file_fields {
+	int64_t radeon_fb_delta;
+};

 struct mem_block {
 	struct mem_block *next;
diff -Nru a/drivers/char/drm/radeon_state.c b/drivers/char/drm/radeon_state.c
--- a/drivers/char/drm/radeon_state.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/radeon_state.c	Sun Sep  5 10:58:50 2004
@@ -43,12 +43,14 @@
 						     drm_file_t *filp_priv,
 						     u32 *offset ) {
 	u32 off = *offset;
+	struct drm_radeon_driver_file_fields *radeon_priv;

 	if ( off >= dev_priv->fb_location &&
 	     off < ( dev_priv->gart_vm_start + dev_priv->gart_size ) )
 		return 0;

-	off += filp_priv->radeon_fb_delta;
+	radeon_priv = filp_priv->driver_priv;
+	off += radeon_priv->radeon_fb_delta;

 	DRM_DEBUG( "offset fixed up to 0x%x\n", off );

@@ -2525,6 +2527,7 @@
 	drm_radeon_private_t *dev_priv = dev->dev_private;
 	drm_file_t *filp_priv;
 	drm_radeon_setparam_t sp;
+	struct drm_radeon_driver_file_fields *radeon_priv;

 	if ( !dev_priv ) {
 		DRM_ERROR( "%s called with no initialization\n", __FUNCTION__ );
@@ -2538,7 +2541,8 @@

 	switch( sp.param ) {
 	case RADEON_SETPARAM_FB_LOCATION:
-		filp_priv->radeon_fb_delta = dev_priv->fb_location - sp.value;
+		radeon_priv = filp_priv->driver_priv;
+		radeon_priv->radeon_fb_delta = dev_priv->fb_location - sp.value;
 		break;
 	default:
 		DRM_DEBUG( "Invalid parameter %d\n", sp.param );
@@ -2571,19 +2575,38 @@
 	radeon_do_release(dev);
 }

-static void radeon_driver_open_helper(drm_device_t *dev, drm_file_t *filp_priv)
+static int radeon_driver_open_helper(drm_device_t *dev, drm_file_t *filp_priv)
 {
 	drm_radeon_private_t *dev_priv = dev->dev_private;
+	struct drm_radeon_driver_file_fields *radeon_priv;
+
+	radeon_priv = (struct drm_radeon_driver_file_fields *)DRM(alloc)(sizeof(*radeon_priv), DRM_MEM_FILES);
+
+	if (!radeon_priv)
+		return -ENOMEM;
+
+	filp_priv->driver_priv = radeon_priv;
 	if ( dev_priv )
-		filp_priv->radeon_fb_delta = dev_priv->fb_location;
+		radeon_priv->radeon_fb_delta = dev_priv->fb_location;
 	else
-		filp_priv->radeon_fb_delta = 0;
+		radeon_priv->radeon_fb_delta = 0;
+	return 0;
+}
+
+
+static void radeon_driver_free_filp_priv(drm_device_t *dev, drm_file_t *filp_priv)
+{
+	 struct drm_radeon_driver_file_fields *radeon_priv = filp_priv->driver_priv;
+
+	 DRM(free)(radeon_priv, sizeof(*radeon_priv), DRM_MEM_FILES);
 }

 void radeon_driver_register_fns(struct drm_device *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA | DRIVER_SG;
 	dev->dev_priv_size = sizeof(drm_radeon_buf_priv_t);
 	dev->fn_tbl.prerelease = radeon_driver_prerelease;
 	dev->fn_tbl.pretakedown = radeon_driver_pretakedown;
 	dev->fn_tbl.open_helper = radeon_driver_open_helper;
+	dev->fn_tbl.free_filp_priv = radeon_driver_free_filp_priv;
 }
diff -Nru a/drivers/char/drm/sis.h b/drivers/char/drm/sis.h
--- a/drivers/char/drm/sis.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/sis.h	Sun Sep  5 10:58:50 2004
@@ -41,10 +41,6 @@

 /* General customization:
  */
-#define __HAVE_AGP		1
-#define __MUST_HAVE_AGP		0
-#define __HAVE_MTRR		1
-#define __HAVE_CTX_BITMAP	1

 #define DRIVER_AUTHOR		"SIS"
 #define DRIVER_NAME		"sis"
diff -Nru a/drivers/char/drm/sis_drv.c b/drivers/char/drm/sis_drv.c
--- a/drivers/char/drm/sis_drv.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/sis_drv.c	Sun Sep  5 10:58:50 2004
@@ -46,4 +46,5 @@
 #include "drm_proc.h"
 #include "drm_vm.h"
 #include "drm_stub.h"
+#include "drm_scatter.h"

diff -Nru a/drivers/char/drm/sis_mm.c b/drivers/char/drm/sis_mm.c
--- a/drivers/char/drm/sis_mm.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/sis_mm.c	Sun Sep  5 10:58:50 2004
@@ -407,6 +407,7 @@

 void DRM(driver_register_fns)(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_USE_MTRR;
 	dev->fn_tbl.context_ctor = sis_init_context;
 	dev->fn_tbl.context_dtor = sis_final_context;
 }
diff -Nru a/drivers/char/drm/tdfx.h b/drivers/char/drm/tdfx.h
--- a/drivers/char/drm/tdfx.h	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/tdfx.h	Sun Sep  5 10:58:50 2004
@@ -36,8 +36,6 @@

 /* General customization:
  */
-#define __HAVE_MTRR		1
-#define __HAVE_CTX_BITMAP	1

 #define DRIVER_AUTHOR		"VA Linux Systems Inc."

diff -Nru a/drivers/char/drm/tdfx_drv.c b/drivers/char/drm/tdfx_drv.c
--- a/drivers/char/drm/tdfx_drv.c	Sun Sep  5 10:58:50 2004
+++ b/drivers/char/drm/tdfx_drv.c	Sun Sep  5 10:58:50 2004
@@ -34,6 +34,7 @@
 #include "tdfx.h"
 #include "drmP.h"

+#include "drm_agpsupport.h"
 #include "drm_auth.h"
 #include "drm_bufs.h"
 #include "drm_context.h"
@@ -49,8 +50,10 @@
 #include "drm_proc.h"
 #include "drm_vm.h"
 #include "drm_stub.h"
+#include "drm_scatter.h"

 void DRM(driver_register_fns)(drm_device_t *dev)
 {
+	dev->driver_features = DRIVER_USE_MTRR;
 }


