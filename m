Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267806AbUIFMDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267806AbUIFMDy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 08:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267819AbUIFMDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 08:03:54 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:3994 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267806AbUIFMCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 08:02:10 -0400
Date: Mon, 6 Sep 2004 13:02:08 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK pull] DRM macro removal the end..
Message-ID: <Pine.LNX.4.58.0409061300020.30423@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This is the last of the major DRM macro removal patches I've queued up, it
also fixes up the ffb driver so it at least compiles for me with no problems,
the logic all looks the same... I'll look at moving the PCI stuff to the
correct interfaces soon.. (bit of reading to do..)..

Please do a

	bk pull bk://drm.bkbits.net/drm-fntbl

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/drmP.h         |   46 +++++-------
 drivers/char/drm/drm_bufs.h     |   22 +++++
 drivers/char/drm/drm_dma.h      |   40 ----------
 drivers/char/drm/drm_drv.h      |   84 +++++++++-------------
 drivers/char/drm/drm_ioctl.h    |    6 -
 drivers/char/drm/drm_irq.h      |   77 ++++++++++----------
 drivers/char/drm/drm_os_linux.h |    4 -
 drivers/char/drm/drm_vm.h       |   21 ++---
 drivers/char/drm/ffb_context.c  |   82 ++++------------------
 drivers/char/drm/ffb_drv.c      |  149 ++++++++++++++++++++--------------------
 drivers/char/drm/ffb_drv.h      |    3
 drivers/char/drm/gamma.h        |    6 -
 drivers/char/drm/gamma_dma.c    |   16 ++--
 drivers/char/drm/i810.h         |   12 ---
 drivers/char/drm/i810_dma.c     |    8 +-
 drivers/char/drm/i810_drv.c     |    1
 drivers/char/drm/i830.h         |   13 ---
 drivers/char/drm/i830_dma.c     |   14 ++-
 drivers/char/drm/i830_drv.h     |    4 +
 drivers/char/drm/i830_irq.c     |    8 +-
 drivers/char/drm/i915.h         |    4 -
 drivers/char/drm/i915_dma.c     |    6 +
 drivers/char/drm/i915_drv.c     |    1
 drivers/char/drm/i915_drv.h     |    5 +
 drivers/char/drm/i915_irq.c     |   12 ++-
 drivers/char/drm/mga.h          |    7 -
 drivers/char/drm/mga_dma.c      |    9 +-
 drivers/char/drm/mga_drv.h      |    6 +
 drivers/char/drm/mga_irq.c      |    4 -
 drivers/char/drm/r128.h         |    7 -
 drivers/char/drm/r128_cce.c     |    2
 drivers/char/drm/r128_drv.h     |    6 +
 drivers/char/drm/r128_irq.c     |    4 -
 drivers/char/drm/r128_state.c   |    7 +
 drivers/char/drm/radeon.h       |    7 -
 drivers/char/drm/radeon_cp.c    |    2
 drivers/char/drm/radeon_drv.h   |    5 +
 drivers/char/drm/radeon_irq.c   |    4 -
 drivers/char/drm/radeon_state.c |    7 +
 drivers/char/drm/sis_drv.c      |    1
 drivers/char/drm/tdfx_drv.c     |    1
 41 files changed, 324 insertions(+), 399 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/09/06 1.2036.3.2)
   drm: Sparc64 ffb compile fixes

   Fixup ffb driver and interfaces it uses, also avoid bus_to_virt
   on sparc, I'll look into using the proper APIs for the DRM soon.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/09/06 1.2036.3.1)
   drm: remove __HAVE_DMA/IRQ and mapping offset macros

   Remove __HAVE_DMA and __HAVE_IRQ and associated macros.
   Also remove GET_MAP related macros...

   Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
--- a/drivers/char/drm/drmP.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/drmP.h	Mon Sep  6 21:54:11 2004
@@ -88,13 +88,11 @@
 #define DRIVER_USE_MTRR    0x4
 #define DRIVER_PCI_DMA     0x8
 #define DRIVER_SG          0x10
-
-#ifndef __HAVE_DMA
-#define __HAVE_DMA		0
-#endif
-#ifndef __HAVE_IRQ
-#define __HAVE_IRQ		0
-#endif
+#define DRIVER_HAVE_DMA    0x20
+#define DRIVER_HAVE_IRQ    0x40
+#define DRIVER_IRQ_SHARED  0x80
+#define DRIVER_IRQ_VBL     0x100
+#define DRIVER_DMA_QUEUE   0x200

 /***********************************************************************/
 /** \name Begin the DRM... */
@@ -533,7 +531,6 @@
 	drm_file_t		*tag;   /**< associated fd private data */
 } drm_ctx_list_t;

-#ifdef __HAVE_VBL_IRQ

 typedef struct drm_vbl_sig {
 	struct list_head	head;
@@ -542,7 +539,6 @@
 	struct task_struct	*task;
 } drm_vbl_sig_t;

-#endif

 /**
  * DRM device functions structure
@@ -565,7 +561,17 @@
 	int (*context_ctor)(struct drm_device *dev, int context);
  	int (*context_dtor)(struct drm_device *dev, int context);
  	int (*kernel_context_switch)(struct drm_device *dev, int old, int new);
- 	int (*kernel_context_switch_unlock)(struct drm_device *dev);
+	void (*kernel_context_switch_unlock)(struct drm_device *dev, drm_lock_t *lock);
+	int (*vblank_wait)(struct drm_device *dev, unsigned int *sequence);
+	/* these have to be filled in */
+	irqreturn_t (*irq_handler)( DRM_IRQ_ARGS );
+ 	void (*irq_preinstall)(struct drm_device *dev);
+ 	void (*irq_postinstall)(struct drm_device *dev);
+ 	void (*irq_uninstall)(struct drm_device *dev);
+	void (*reclaim_buffers)(struct file *filp);
+	unsigned long (*get_map_ofs)(drm_map_t *map);
+	unsigned long (*get_reg_ofs)(struct drm_device *dev);
+	void (*set_version)(struct drm_device *dev, drm_set_version_t *sv);
 };
 /**
  * DRM device structure.
@@ -655,13 +661,13 @@
 	struct work_struct	work;
 	/** \name VBLANK IRQ support */
 	/*@{*/
-#ifdef __HAVE_VBL_IRQ
+
    	wait_queue_head_t vbl_queue;	/**< VBLANK wait queue */
    	atomic_t          vbl_received;
 	spinlock_t        vbl_lock;
 	drm_vbl_sig_t     vbl_sigs;	/**< signal list to send on VBLANK */
 	unsigned int      vbl_pending;
-#endif
+
 	/*@}*/
 	cycles_t	  ctx_start;
 	cycles_t	  lck_start;
@@ -864,7 +870,6 @@
 				  unsigned int cmd, unsigned long arg );
 extern int	     DRM(rmmap)( struct inode *inode, struct file *filp,
 				 unsigned int cmd, unsigned long arg );
-#if __HAVE_DMA
 extern int	     DRM(addbufs)( struct inode *inode, struct file *filp,
 				   unsigned int cmd, unsigned long arg );
 extern int	     DRM(infobufs)( struct inode *inode, struct file *filp,
@@ -881,31 +886,21 @@
 extern void	     DRM(dma_takedown)(drm_device_t *dev);
 extern void	     DRM(free_buffer)(drm_device_t *dev, drm_buf_t *buf);
 extern void	     DRM(reclaim_buffers)( struct file *filp );
-#endif /* __HAVE_DMA */

 				/* IRQ support (drm_irq.h) */
-#if __HAVE_IRQ || __HAVE_DMA
 extern int           DRM(control)( struct inode *inode, struct file *filp,
 				   unsigned int cmd, unsigned long arg );
-#endif
-#if __HAVE_IRQ
 extern int           DRM(irq_install)( drm_device_t *dev );
 extern int           DRM(irq_uninstall)( drm_device_t *dev );
 extern irqreturn_t   DRM(irq_handler)( DRM_IRQ_ARGS );
 extern void          DRM(driver_irq_preinstall)( drm_device_t *dev );
 extern void          DRM(driver_irq_postinstall)( drm_device_t *dev );
 extern void          DRM(driver_irq_uninstall)( drm_device_t *dev );
-#ifdef __HAVE_VBL_IRQ
+
 extern int           DRM(wait_vblank)(struct inode *inode, struct file *filp,
 				      unsigned int cmd, unsigned long arg);
 extern int           DRM(vblank_wait)(drm_device_t *dev, unsigned int *vbl_seq);
 extern void          DRM(vbl_send_signals)( drm_device_t *dev );
-#endif
-#ifdef __HAVE_IRQ_BH
-extern void          DRM(irq_immediate_bh)( void *dev );
-#endif
-#endif
-

 				/* AGP/GART support (drm_agpsupport.h) */
 extern drm_agp_head_t *DRM(agp_init)(void);
@@ -997,6 +992,9 @@
 {
 }
 /*@}*/
+
+extern unsigned long DRM(core_get_map_ofs)(drm_map_t *map);
+extern unsigned long DRM(core_get_reg_ofs)(struct drm_device *dev);

 #endif /* __KERNEL__ */
 #endif
diff -Nru a/drivers/char/drm/drm_bufs.h b/drivers/char/drm/drm_bufs.h
--- a/drivers/char/drm/drm_bufs.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/drm_bufs.h	Mon Sep  6 21:54:11 2004
@@ -286,8 +286,6 @@
 	return 0;
 }

-#if __HAVE_DMA
-
 /**
  * Cleanup after an error on one of the addbufs() functions.
  *
@@ -661,7 +659,9 @@
 			buf->used    = 0;
 			buf->offset  = (dma->byte_count + byte_count + offset);
 			buf->address = (void *)(page + offset);
+#ifndef __sparc__
 			buf->bus_address = virt_to_bus(buf->address);
+#endif
 			buf->next    = NULL;
 			buf->waiting = 0;
 			buf->pending = 0;
@@ -926,6 +926,11 @@
 		  unsigned int cmd, unsigned long arg )
 {
 	drm_buf_desc_t request;
+	drm_file_t *priv = filp->private_data;
+	drm_device_t *dev = priv->dev;
+
+	if (!drm_core_check_feature(dev, DRIVER_HAVE_DMA))
+		return -EINVAL;

 	if ( copy_from_user( &request, (drm_buf_desc_t __user *)arg,
 			     sizeof(request) ) )
@@ -971,6 +976,9 @@
 	int i;
 	int count;

+	if (!drm_core_check_feature(dev, DRIVER_HAVE_DMA))
+		return -EINVAL;
+
 	if ( !dma ) return -EINVAL;

 	spin_lock( &dev->count_lock );
@@ -1052,6 +1060,9 @@
 	int order;
 	drm_buf_entry_t *entry;

+	if (!drm_core_check_feature(dev, DRIVER_HAVE_DMA))
+		return -EINVAL;
+
 	if ( !dma ) return -EINVAL;

 	if ( copy_from_user( &request,
@@ -1099,6 +1110,9 @@
 	int idx;
 	drm_buf_t *buf;

+	if (!drm_core_check_feature(dev, DRIVER_HAVE_DMA))
+		return -EINVAL;
+
 	if ( !dma ) return -EINVAL;

 	if ( copy_from_user( &request,
@@ -1156,6 +1170,9 @@
 	drm_buf_map_t request;
 	int i;

+	if (!drm_core_check_feature(dev, DRIVER_HAVE_DMA))
+		return -EINVAL;
+
 	if ( !dma ) return -EINVAL;

 	spin_lock( &dev->count_lock );
@@ -1253,4 +1270,3 @@
 	return retcode;
 }

-#endif /* __HAVE_DMA */
diff -Nru a/drivers/char/drm/drm_dma.h b/drivers/char/drm/drm_dma.h
--- a/drivers/char/drm/drm_dma.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/drm_dma.h	Mon Sep  6 21:54:11 2004
@@ -35,16 +35,6 @@

 #include "drmP.h"

-
-#ifndef __HAVE_DMA_WAITQUEUE
-#define __HAVE_DMA_WAITQUEUE	0
-#endif
-#ifndef __HAVE_DMA_RECLAIM
-#define __HAVE_DMA_RECLAIM	0
-#endif
-
-#if __HAVE_DMA
-
 /**
  * Initialize the DMA data.
  *
@@ -152,12 +142,11 @@
 	buf->filp     = NULL;
 	buf->used     = 0;

-	if ( __HAVE_DMA_WAITQUEUE && waitqueue_active(&buf->dma_wait)) {
+	if (drm_core_check_feature(dev, DRIVER_DMA_QUEUE) && waitqueue_active(&buf->dma_wait)) {
 		wake_up_interruptible(&buf->dma_wait);
 	}
 }

-#if !__HAVE_DMA_RECLAIM
 /**
  * Reclaim the buffers.
  *
@@ -165,7 +154,7 @@
  *
  * Frees each buffer associated with \p filp not already on the hardware.
  */
-void DRM(reclaim_buffers)( struct file *filp )
+void DRM(core_reclaim_buffers)( struct file *filp )
 {
 	drm_file_t    *priv   = filp->private_data;
 	drm_device_t  *dev    = priv->dev;
@@ -189,29 +178,4 @@
 		}
 	}
 }
-#endif
-
-#if !__HAVE_IRQ
-/* This stub DRM_IOCTL_CONTROL handler is for the drivers that used to require
- * IRQs for DMA but no longer do.  It maintains compatibility with the X Servers
- * that try to use the control ioctl by simply returning success.
- */
-int DRM(control)( struct inode *inode, struct file *filp,
-		  unsigned int cmd, unsigned long arg )
-{
-	drm_control_t ctl;
-
-	if ( copy_from_user( &ctl, (drm_control_t __user *)arg, sizeof(ctl) ) )
-		return -EFAULT;
-
-	switch ( ctl.func ) {
-	case DRM_INST_HANDLER:
-	case DRM_UNINST_HANDLER:
-		return 0;
-	default:
-		return -EINVAL;
-	}
-}
-#endif

-#endif /* __HAVE_DMA */
diff -Nru a/drivers/char/drm/drm_drv.h b/drivers/char/drm/drm_drv.h
--- a/drivers/char/drm/drm_drv.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/drm_drv.h	Mon Sep  6 21:54:11 2004
@@ -52,16 +52,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */

-
-#ifndef __HAVE_IRQ
-#define __HAVE_IRQ			0
-#endif
-#ifndef __HAVE_DMA_QUEUE
-#define __HAVE_DMA_QUEUE		0
-#endif
-#ifndef __HAVE_MULTIPLE_DMA_QUEUES
-#define __HAVE_MULTIPLE_DMA_QUEUES	0
-#endif
 #ifndef __HAVE_COUNTERS
 #define __HAVE_COUNTERS			0
 #endif
@@ -109,9 +99,7 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_VERSION)]       = { DRM(version),     0, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_GET_UNIQUE)]    = { DRM(getunique),   0, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_GET_MAGIC)]     = { DRM(getmagic),    0, 0 },
-#if __HAVE_IRQ
 	[DRM_IOCTL_NR(DRM_IOCTL_IRQ_BUSID)]     = { DRM(irq_by_busid), 0, 1 },
-#endif
 	[DRM_IOCTL_NR(DRM_IOCTL_GET_MAP)]       = { DRM(getmap),      0, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_GET_CLIENT)]    = { DRM(getclient),   0, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_GET_STATS)]     = { DRM(getstats),    0, 0 },
@@ -144,17 +132,14 @@

 	[DRM_IOCTL_NR(DRM_IOCTL_FINISH)]        = { DRM(noop),      1, 0 },

-#if __HAVE_DMA
 	[DRM_IOCTL_NR(DRM_IOCTL_ADD_BUFS)]      = { DRM(addbufs),     1, 1 },
 	[DRM_IOCTL_NR(DRM_IOCTL_MARK_BUFS)]     = { DRM(markbufs),    1, 1 },
 	[DRM_IOCTL_NR(DRM_IOCTL_INFO_BUFS)]     = { DRM(infobufs),    1, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_MAP_BUFS)]      = { DRM(mapbufs),     1, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_FREE_BUFS)]     = { DRM(freebufs),    1, 0 },
 	/* The DRM_IOCTL_DMA ioctl should be defined by the driver. */
-#endif
-#if __HAVE_IRQ || __HAVE_DMA
+
 	[DRM_IOCTL_NR(DRM_IOCTL_CONTROL)]       = { DRM(control),     1, 1 },
-#endif

 #if __OS_HAS_AGP
 	[DRM_IOCTL_NR(DRM_IOCTL_AGP_ACQUIRE)]   = { DRM(agp_acquire), 1, 1 },
@@ -170,9 +155,7 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_SG_ALLOC)]      = { DRM(sg_alloc),    1, 1 },
 	[DRM_IOCTL_NR(DRM_IOCTL_SG_FREE)]       = { DRM(sg_free),     1, 1 },

-#ifdef __HAVE_VBL_IRQ
 	[DRM_IOCTL_NR(DRM_IOCTL_WAIT_VBLANK)]   = { DRM(wait_vblank), 0, 0 },
-#endif

 	DRIVER_IOCTLS
 };
@@ -191,20 +174,26 @@
 static int DRM(setup)( drm_device_t *dev )
 {
 	int i;
+	int ret;

 	if (dev->fn_tbl.presetup)
-		dev->fn_tbl.presetup(dev);
+	{
+		ret=dev->fn_tbl.presetup(dev);
+		if (ret!=0)
+			return ret;
+	}

 	atomic_set( &dev->ioctl_count, 0 );
 	atomic_set( &dev->vma_count, 0 );
 	dev->buf_use = 0;
 	atomic_set( &dev->buf_alloc, 0 );

-#if __HAVE_DMA
-	i = DRM(dma_setup)( dev );
-	if ( i < 0 )
-		return i;
-#endif
+	if (drm_core_check_feature(dev, DRIVER_HAVE_DMA))
+	{
+		i = DRM(dma_setup)( dev );
+		if ( i < 0 )
+			return i;
+	}

 	dev->counters  = 6 + __HAVE_COUNTERS;
 	dev->types[0]  = _DRM_STAT_LOCK;
@@ -327,9 +316,7 @@
 	if (dev->fn_tbl.pretakedown)
 	  dev->fn_tbl.pretakedown(dev);

-#if __HAVE_IRQ
 	if ( dev->irq_enabled ) DRM(irq_uninstall)( dev );
-#endif

 	down( &dev->struct_sem );
 	del_timer( &dev->timer );
@@ -430,8 +417,7 @@
 		dev->maplist = NULL;
  	}

-#if __HAVE_DMA_QUEUE || __HAVE_MULTIPLE_DMA_QUEUES
-	if ( dev->queuelist ) {
+	if (drm_core_check_feature(dev, DRIVER_DMA_QUEUE) && dev->queuelist ) {
 		for ( i = 0 ; i < dev->queue_count ; i++ ) {
 			if ( dev->queuelist[i] ) {
 				DRM(free)( dev->queuelist[i],
@@ -446,11 +432,10 @@
 		dev->queuelist = NULL;
 	}
 	dev->queue_count = 0;
-#endif

-#if __HAVE_DMA
-	DRM(dma_takedown)( dev );
-#endif
+	if (drm_core_check_feature(dev, DRIVER_HAVE_DMA))
+		DRM(dma_takedown)( dev );
+
 	if ( dev->lock.hw_lock ) {
 		dev->sigdata.lock = dev->lock.hw_lock = NULL; /* SHM removed */
 		dev->lock.filp = NULL;
@@ -461,6 +446,13 @@
 	return 0;
 }

+static void DRM(init_fn_table)(struct drm_device *dev)
+{
+	dev->fn_tbl.reclaim_buffers = DRM(core_reclaim_buffers);
+	dev->fn_tbl.get_map_ofs = DRM(core_get_map_ofs);
+	dev->fn_tbl.get_reg_ofs = DRM(core_get_reg_ofs);
+}
+
 #include "drm_pciids.h"

 static struct pci_device_id DRM(pciidlist)[] = {
@@ -514,7 +506,10 @@
 	dev->irq = pdev->irq;

 	/* dev_priv_size can be changed by a driver in driver_register_fns */
- 	dev->dev_priv_size = sizeof(u32);
+	dev->dev_priv_size = sizeof(u32);
+
+	DRM(init_fn_table)(dev);
+
 	DRM(driver_register_fns)(dev);

 	if (dev->fn_tbl.preinit)
@@ -820,9 +815,10 @@
 		}
 	}

-#if __HAVE_DMA
-	DRM(reclaim_buffers)( filp );
-#endif
+	if (drm_core_check_feature(dev, DRIVER_HAVE_DMA))
+	{
+		dev->fn_tbl.reclaim_buffers(filp);
+	}

 	DRM(fasync)( -1, filp, 0 );

@@ -966,9 +962,6 @@
         DECLARE_WAITQUEUE( entry, current );
         drm_lock_t lock;
         int ret = 0;
-#if __HAVE_MULTIPLE_DMA_QUEUES
-	drm_queue_t *q;
-#endif

 	++priv->lock_count;

@@ -985,14 +978,9 @@
 		   lock.context, current->pid,
 		   dev->lock.hw_lock->lock, lock.flags );

-#if __HAVE_DMA_QUEUE
-        if ( lock.context < 0 )
-                return -EINVAL;
-#elif __HAVE_MULTIPLE_DMA_QUEUES
-        if ( lock.context < 0 || lock.context >= dev->queue_count )
-                return -EINVAL;
-	q = dev->queuelist[lock.context];
-#endif
+	if (drm_core_check_feature(dev, DRIVER_DMA_QUEUE))
+		if ( lock.context < 0 )
+			return -EINVAL;

 	add_wait_queue( &dev->lock.lock_queue, &entry );
 	for (;;) {
@@ -1083,7 +1071,7 @@
 	 * modules but is required by the Sparc driver.
 	 */
 	if (dev->fn_tbl.kernel_context_switch_unlock)
-		dev->fn_tbl.kernel_context_switch_unlock(dev);
+		dev->fn_tbl.kernel_context_switch_unlock(dev, &lock);
 	else {
 		DRM(lock_transfer)( dev, &dev->lock.hw_lock->lock,
 				    DRM_KERNEL_CONTEXT );
diff -Nru a/drivers/char/drm/drm_ioctl.h b/drivers/char/drm/drm_ioctl.h
--- a/drivers/char/drm/drm_ioctl.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/drm_ioctl.h	Mon Sep  6 21:54:11 2004
@@ -341,9 +341,9 @@
 		if (sv.drm_dd_major != DRIVER_MAJOR ||
 		    sv.drm_dd_minor < 0 || sv.drm_dd_minor > DRIVER_MINOR)
 			return EINVAL;
-#ifdef DRIVER_SETVERSION
-		DRIVER_SETVERSION(dev, &sv);
-#endif
+
+		if (dev->fn_tbl.set_version)
+			dev->fn_tbl.set_version(dev, &sv);
 	}
 	return 0;
 }
diff -Nru a/drivers/char/drm/drm_irq.h b/drivers/char/drm/drm_irq.h
--- a/drivers/char/drm/drm_irq.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/drm_irq.h	Mon Sep  6 21:54:11 2004
@@ -37,16 +37,6 @@

 #include <linux/interrupt.h>	/* For task queue support */

-#ifndef __HAVE_SHARED_IRQ
-#define __HAVE_SHARED_IRQ	0
-#endif
-
-#if __HAVE_SHARED_IRQ
-#define DRM_IRQ_TYPE		SA_SHIRQ
-#else
-#define DRM_IRQ_TYPE		0
-#endif
-
 /**
  * Get interrupt from bus id.
  *
@@ -68,6 +58,9 @@
 	drm_irq_busid_t __user *argp = (void __user *)arg;
 	drm_irq_busid_t p;

+	if (!drm_core_check_feature(dev, DRIVER_HAVE_IRQ))
+		return -EINVAL;
+
 	if (copy_from_user(&p, argp, sizeof(p)))
 		return -EFAULT;

@@ -86,8 +79,6 @@
 	return 0;
 }

-#if __HAVE_IRQ
-
 /**
  * Install IRQ handler.
  *
@@ -101,7 +92,11 @@
 int DRM(irq_install)( drm_device_t *dev )
 {
 	int ret;
-
+	unsigned long sh_flags=0;
+
+	if (!drm_core_check_feature(dev, DRIVER_HAVE_IRQ))
+		return -EINVAL;
+
 	if ( dev->irq == 0 )
 		return -EINVAL;

@@ -122,32 +117,29 @@

 	DRM_DEBUG( "%s: irq=%d\n", __FUNCTION__, dev->irq );

-#if __HAVE_DMA
 	dev->dma->next_buffer = NULL;
 	dev->dma->next_queue = NULL;
 	dev->dma->this_buffer = NULL;
-#endif
-
-#ifdef __HAVE_IRQ_BH
-	INIT_WORK(&dev->work, DRM(irq_immediate_bh), dev);
-#endif
-
-#ifdef __HAVE_VBL_IRQ
-	init_waitqueue_head(&dev->vbl_queue);
-
-	spin_lock_init( &dev->vbl_lock );
-
-	INIT_LIST_HEAD( &dev->vbl_sigs.head );

-	dev->vbl_pending = 0;
-#endif
+	if (drm_core_check_feature(dev, DRIVER_IRQ_VBL)) {
+		init_waitqueue_head(&dev->vbl_queue);
+
+		spin_lock_init( &dev->vbl_lock );
+
+		INIT_LIST_HEAD( &dev->vbl_sigs.head );
+
+		dev->vbl_pending = 0;
+	}

 				/* Before installing handler */
-	DRM(driver_irq_preinstall)(dev);
+	dev->fn_tbl.irq_preinstall(dev);

 				/* Install handler */
-	ret = request_irq( dev->irq, DRM(irq_handler),
-			   DRM_IRQ_TYPE, dev->devname, dev );
+	if (drm_core_check_feature(dev, DRIVER_IRQ_SHARED))
+		sh_flags = SA_SHIRQ;
+
+	ret = request_irq( dev->irq, dev->fn_tbl.irq_handler,
+			   sh_flags, dev->devname, dev );
 	if ( ret < 0 ) {
 		down( &dev->struct_sem );
 		dev->irq_enabled = 0;
@@ -156,7 +148,7 @@
 	}

 				/* After installing handler */
-	DRM(driver_irq_postinstall)(dev);
+	dev->fn_tbl.irq_postinstall(dev);

 	return 0;
 }
@@ -172,6 +164,9 @@
 {
 	int irq_enabled;

+	if (!drm_core_check_feature(dev, DRIVER_HAVE_IRQ))
+		return -EINVAL;
+
 	down( &dev->struct_sem );
 	irq_enabled = dev->irq_enabled;
 	dev->irq_enabled = 0;
@@ -182,7 +177,7 @@

 	DRM_DEBUG( "%s: irq=%d\n", __FUNCTION__, dev->irq );

-	DRM(driver_irq_uninstall)( dev );
+	dev->fn_tbl.irq_uninstall(dev);

 	free_irq( dev->irq, dev );

@@ -206,25 +201,29 @@
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
 	drm_control_t ctl;
+
+	/* if we haven't irq we fallback for compatibility reasons - this used to be a separate function in drm_dma.h */

 	if ( copy_from_user( &ctl, (drm_control_t __user *)arg, sizeof(ctl) ) )
 		return -EFAULT;

 	switch ( ctl.func ) {
 	case DRM_INST_HANDLER:
+		if (!drm_core_check_feature(dev, DRIVER_HAVE_IRQ))
+			return 0;
 		if (dev->if_version < DRM_IF_VERSION(1, 2) &&
 		    ctl.irq != dev->irq)
 			return -EINVAL;
 		return DRM(irq_install)( dev );
 	case DRM_UNINST_HANDLER:
+		if (!drm_core_check_feature(dev, DRIVER_HAVE_IRQ))
+			return 0;
 		return DRM(irq_uninstall)( dev );
 	default:
 		return -EINVAL;
 	}
 }

-#ifdef __HAVE_VBL_IRQ
-
 /**
  * Wait for VBLANK.
  *
@@ -254,6 +253,9 @@
 	int ret = 0;
 	unsigned int flags;

+	if (!drm_core_check_feature(dev, DRIVER_IRQ_VBL))
+		return -EINVAL;
+
 	if (!dev->irq)
 		return -EINVAL;

@@ -318,7 +320,8 @@

 		spin_unlock_irqrestore( &dev->vbl_lock, irqflags );
 	} else {
-		ret = DRM(vblank_wait)( dev, &vblwait.request.sequence );
+		if (dev->fn_tbl.vblank_wait)
+			ret = dev->fn_tbl.vblank_wait( dev, &vblwait.request.sequence );

 		do_gettimeofday( &now );
 		vblwait.reply.tval_sec = now.tv_sec;
@@ -366,6 +369,4 @@
 	spin_unlock_irqrestore( &dev->vbl_lock, flags );
 }

-#endif	/* __HAVE_VBL_IRQ */

-#endif /* __HAVE_IRQ */
diff -Nru a/drivers/char/drm/drm_os_linux.h b/drivers/char/drm/drm_os_linux.h
--- a/drivers/char/drm/drm_os_linux.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/drm_os_linux.h	Mon Sep  6 21:54:11 2004
@@ -58,13 +58,13 @@
 static __inline__ int mtrr_add (unsigned long base, unsigned long size,
                                 unsigned int type, char increment)
 {
-    return -ENODEV;
+	return -ENODEV;
 }

 static __inline__ int mtrr_del (int reg, unsigned long base,
                                 unsigned long size)
 {
-    return -ENODEV;
+	return -ENODEV;
 }
 #define MTRR_TYPE_WRCOMB     1

diff -Nru a/drivers/char/drm/drm_vm.h b/drivers/char/drm/drm_vm.h
--- a/drivers/char/drm/drm_vm.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/drm_vm.h	Mon Sep  6 21:54:11 2004
@@ -493,18 +493,19 @@
 	return 0;
 }

-#ifndef DRIVER_GET_MAP_OFS
-#define DRIVER_GET_MAP_OFS()	(map->offset)
-#endif
+unsigned long DRM(core_get_map_ofs)(drm_map_t *map)
+{
+	return map->offset;
+}

-#ifndef DRIVER_GET_REG_OFS
+unsigned long DRM(core_get_reg_ofs)(struct drm_device *dev)
+{
 #ifdef __alpha__
-#define DRIVER_GET_REG_OFS()	(dev->hose->dense_mem_base -	\
-				 dev->hose->mem_space->start)
+	return dev->hose->dense_mem_base - dev->hose->mem_space->start;
 #else
-#define DRIVER_GET_REG_OFS()	0
-#endif
+	return 0;
 #endif
+}

 /**
  * mmap DMA memory.
@@ -557,7 +558,7 @@
 		r_list = list_entry(list, drm_map_list_t, head);
 		map = r_list->map;
 		if (!map) continue;
-		off = DRIVER_GET_MAP_OFS();
+		off = dev->fn_tbl.get_map_ofs(map);
 		if (off == VM_OFFSET(vma)) break;
 	}

@@ -612,7 +613,7 @@
 		if (map->type != _DRM_AGP)
 			vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 #endif
-		offset = DRIVER_GET_REG_OFS();
+		offset = dev->fn_tbl.get_reg_ofs(dev);
 #ifdef __sparc__
 		if (io_remap_page_range(DRM_RPR_ARG(vma) vma->vm_start,
 					VM_OFFSET(vma) + offset,
diff -Nru a/drivers/char/drm/ffb_context.c b/drivers/char/drm/ffb_context.c
--- a/drivers/char/drm/ffb_context.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/ffb_context.c	Mon Sep  6 21:54:11 2004
@@ -354,7 +354,7 @@
 	} while (--limit);
 }

-int DRM(context_switch)(drm_device_t *dev, int old, int new)
+int ffb_driver_context_switch(drm_device_t *dev, int old, int new)
 {
 	ffb_dev_priv_t *fpriv = (ffb_dev_priv_t *) dev->dev_private;

@@ -380,7 +380,7 @@
         return 0;
 }

-int DRM(resctx)(struct inode *inode, struct file *filp, unsigned int cmd,
+int ffb_driver_resctx(struct inode *inode, struct file *filp, unsigned int cmd,
 		unsigned long arg)
 {
 	drm_ctx_res_t	res;
@@ -407,7 +407,7 @@
 }


-int DRM(addctx)(struct inode *inode, struct file *filp, unsigned int cmd,
+int ffb_driver_addctx(struct inode *inode, struct file *filp, unsigned int cmd,
 		unsigned long arg)
 {
 	drm_file_t	*priv	= filp->private_data;
@@ -428,7 +428,7 @@
 	return 0;
 }

-int DRM(modctx)(struct inode *inode, struct file *filp, unsigned int cmd,
+int ffb_driver_modctx(struct inode *inode, struct file *filp, unsigned int cmd,
 		unsigned long arg)
 {
 	drm_file_t	*priv	= filp->private_data;
@@ -457,7 +457,7 @@
 	return 0;
 }

-int DRM(getctx)(struct inode *inode, struct file *filp, unsigned int cmd,
+int ffb_driver_getctx(struct inode *inode, struct file *filp, unsigned int cmd,
 		unsigned long arg)
 {
 	drm_file_t	*priv	= filp->private_data;
@@ -489,7 +489,7 @@
 	return 0;
 }

-int DRM(switchctx)(struct inode *inode, struct file *filp, unsigned int cmd,
+int ffb_driver_switchctx(struct inode *inode, struct file *filp, unsigned int cmd,
 		   unsigned long arg)
 {
 	drm_file_t	*priv	= filp->private_data;
@@ -499,10 +499,10 @@
 	if (copy_from_user(&ctx, (drm_ctx_t  __user *)arg, sizeof(ctx)))
 		return -EFAULT;
 	DRM_DEBUG("%d\n", ctx.handle);
-	return DRM(context_switch)(dev, dev->last_context, ctx.handle);
+	return ffb_driver_context_switch(dev, dev->last_context, ctx.handle);
 }

-int DRM(newctx)(struct inode *inode, struct file *filp, unsigned int cmd,
+int ffb_driver_newctx(struct inode *inode, struct file *filp, unsigned int cmd,
 		unsigned long arg)
 {
 	drm_ctx_t	ctx;
@@ -514,7 +514,7 @@
 	return 0;
 }

-int DRM(rmctx)(struct inode *inode, struct file *filp, unsigned int cmd,
+int ffb_driver_rmctx(struct inode *inode, struct file *filp, unsigned int cmd,
 	       unsigned long arg)
 {
 	drm_ctx_t	ctx;
@@ -538,62 +538,14 @@
 	return 0;
 }

-static void ffb_driver_release(drm_device_t *dev)
+void ffb_set_context_ioctls(void)
 {
-	ffb_dev_priv_t *fpriv = (ffb_dev_priv_t *) dev->dev_private;
-	int context = _DRM_LOCKING_CONTEXT(dev->lock.hw_lock->lock);
-	int idx;
-
-	idx = context - 1;
-	if (fpriv &&
-	    context != DRM_KERNEL_CONTEXT &&
-	    fpriv->hw_state[idx] != NULL) {
-		kfree(fpriv->hw_state[idx]);
-		fpriv->hw_state[idx] = NULL;
-	}
-}
-
-static int ffb_driver_presetup(drm_device_t *dev)
-{
-	int ret;
-	ret = ffb_presetup(dev);
-	if (_ret != 0) return ret;
-}
-
-static void ffb_driver_pretakedown(drm_device_t *dev)
-{
-	if (dev->dev_private) kfree(dev->dev_private);
-}
-
-static void ffb_driver_postcleanup(drm_device_t *dev)
-{
-	if (ffb_position != NULL) kfree(ffb_position);
-}
+	DRM(ioctls)[DRM_IOCTL_NR(DRM_IOCTL_ADD_CTX)].func = ffb_driver_addctx;
+	DRM(ioctls)[DRM_IOCTL_NR(DRM_IOCTL_RM_CTX)].func = ffb_driver_rmctx;
+	DRM(ioctls)[DRM_IOCTL_NR(DRM_IOCTL_MOD_CTX)].func = ffb_driver_modctx;
+	DRM(ioctls)[DRM_IOCTL_NR(DRM_IOCTL_GET_CTX)].func = ffb_driver_getctx;
+	DRM(ioctls)[DRM_IOCTL_NR(DRM_IOCTL_SWITCH_CTX)].func = ffb_driver_switchctx;
+	DRM(ioctls)[DRM_IOCTL_NR(DRM_IOCTL_NEW_CTX)].func = ffb_driver_newctx;
+	DRM(ioctls)[DRM_IOCTL_NR(DRM_IOCTL_RES_CTX)].func = ffb_driver_resctx;

-static int ffb_driver_kernel_context_switch_unlock(struct drm_device *dev)
-{
-	dev->lock.filp = 0;
-	{
-		__volatile__ unsigned int *plock = &dev->lock.hw_lock->lock;
-		unsigned int old, new, prev, ctx;
-
-		ctx = lock.context;
-		do {
-			old  = *plock;
-			new  = ctx;
-			prev = cmpxchg(plock, old, new);
-		} while (prev != old);
-	}
-	wake_up_interruptible(&dev->lock.lock_queue);
-}
-
-static void ffb_driver_register_fns(drm_device_t *dev)
-{
-	DRM(fops).get_unmapped_area = ffb_get_unmapped_area;
-	dev->fn_tbl.release = ffb_driver_release;
-	dev->fn_tbl.presetup = ffb_driver_presetup;
-	dev->fn_tbl.pretakedown = ffb_driver_pretakedown;
-	dev->fn_tbl.postcleanup = ffb_driver_postcleanup;
-	dev->fn_tbl.kernel_context_switch = ffb_context_switch;
-	dev->fn_tbl.kernel_context_switch_unlock = ffb_driver_kernel_context_switch_unlock;
 }
diff -Nru a/drivers/char/drm/ffb_drv.c b/drivers/char/drm/ffb_drv.c
--- a/drivers/char/drm/ffb_drv.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/ffb_drv.c	Mon Sep  6 21:54:11 2004
@@ -26,12 +26,6 @@
 #define DRIVER_MINOR		0
 #define DRIVER_PATCHLEVEL	1

-#define DRIVER_COUNT_CARDS()	ffb_count_card_instances()
-
-/* For mmap customization */
-#define DRIVER_GET_MAP_OFS()	(map->offset & 0xffffffff)
-#define DRIVER_GET_REG_OFS()	ffb_get_reg_offset(dev)
-
 typedef struct _ffb_position_t {
 	int node;
 	int root;
@@ -146,63 +140,6 @@
 	return 0;
 }

-static int __init ffb_count_siblings(int root)
-{
-	int node, child, count = 0;
-
-	child = prom_getchild(root);
-	for (node = prom_searchsiblings(child, "SUNW,ffb"); node;
-	     node = prom_searchsiblings(prom_getsibling(node), "SUNW,ffb"))
-		count++;
-
-	return count;
-}
-
-static int __init ffb_scan_siblings(int root, int instance)
-{
-	int node, child;
-
-	child = prom_getchild(root);
-	for (node = prom_searchsiblings(child, "SUNW,ffb"); node;
-	     node = prom_searchsiblings(prom_getsibling(node), "SUNW,ffb")) {
-		ffb_position[instance].node = node;
-		ffb_position[instance].root = root;
-		instance++;
-	}
-
-	return instance;
-}
-
-static int ffb_presetup(drm_device_t *);
-
-static int __init ffb_count_card_instances(void)
-{
-	int root, total, instance;
-
-	total = ffb_count_siblings(prom_root_node);
-	root = prom_getchild(prom_root_node);
-	for (root = prom_searchsiblings(root, "upa"); root;
-	     root = prom_searchsiblings(prom_getsibling(root), "upa"))
-		total += ffb_count_siblings(root);
-
-	ffb_position = kmalloc(sizeof(ffb_position_t) * total, GFP_KERNEL);
-
-	/* Actual failure will be caught during ffb_presetup b/c we can't catch
-	 * it easily here.
-	 */
-	if (!ffb_position)
-		return -ENOMEM;
-
-	instance = ffb_scan_siblings(prom_root_node, 0);
-
-	root = prom_getchild(prom_root_node);
-	for (root = prom_searchsiblings(root, "upa"); root;
-	     root = prom_searchsiblings(prom_getsibling(root), "upa"))
-		instance = ffb_scan_siblings(root, instance);
-
-	return total;
-}
-
 static drm_map_t *ffb_find_map(struct file *filp, unsigned long off)
 {
 	drm_file_t	*priv	= filp->private_data;
@@ -273,18 +210,9 @@
 	return addr;
 }

-static unsigned long ffb_get_reg_offset(drm_device_t *dev)
-{
-	ffb_dev_priv_t *ffb_priv = (ffb_dev_priv_t *)dev->dev_private;
-
-	if (ffb_priv)
-		return ffb_priv->card_phys_base;
-
-	return 0;
-}
-
 #include "drm_auth.h"
 #include "drm_bufs.h"
+#include "drm_context.h"
 #include "drm_dma.h"
 #include "drm_drawable.h"
 #include "drm_drv.h"
@@ -329,8 +257,83 @@
 #include "drm_fops.h"
 #include "drm_init.h"
 #include "drm_ioctl.h"
+#include "drm_irq.h"
 #include "drm_lock.h"
 #include "drm_memory.h"
 #include "drm_proc.h"
 #include "drm_vm.h"
 #include "drm_stub.h"
+#include "drm_scatter.h"
+
+
+static void ffb_driver_release(drm_device_t *dev, struct file *filp)
+{
+	ffb_dev_priv_t *fpriv = (ffb_dev_priv_t *) dev->dev_private;
+	int context = _DRM_LOCKING_CONTEXT(dev->lock.hw_lock->lock);
+	int idx;
+
+	idx = context - 1;
+	if (fpriv &&
+	    context != DRM_KERNEL_CONTEXT &&
+	    fpriv->hw_state[idx] != NULL) {
+		kfree(fpriv->hw_state[idx]);
+		fpriv->hw_state[idx] = NULL;
+	}
+}
+
+static void ffb_driver_pretakedown(drm_device_t *dev)
+{
+	if (dev->dev_private) kfree(dev->dev_private);
+}
+
+static int ffb_driver_postcleanup(drm_device_t *dev)
+{
+	if (ffb_position != NULL) kfree(ffb_position);
+	return 0;
+}
+
+static void ffb_driver_kernel_context_switch_unlock(struct drm_device *dev, drm_lock_t *lock)
+{
+	dev->lock.filp = 0;
+	{
+		__volatile__ unsigned int *plock = &dev->lock.hw_lock->lock;
+		unsigned int old, new, prev, ctx;
+
+		ctx = lock->context;
+		do {
+			old  = *plock;
+			new  = ctx;
+			prev = cmpxchg(plock, old, new);
+		} while (prev != old);
+	}
+	wake_up_interruptible(&dev->lock.lock_queue);
+}
+
+static unsigned long ffb_driver_get_map_ofs(drm_map_t *map)
+{
+	return (map->offset & 0xffffffff);
+}
+
+static unsigned long ffb_driver_get_reg_ofs(drm_device_t *dev)
+{
+       ffb_dev_priv_t *ffb_priv = (ffb_dev_priv_t *)dev->dev_private;
+
+       if (ffb_priv)
+               return ffb_priv->card_phys_base;
+
+       return 0;
+}
+
+void ffb_driver_register_fns(drm_device_t *dev)
+{
+	ffb_set_context_ioctls();
+	DRM(fops).get_unmapped_area = ffb_get_unmapped_area;
+	dev->fn_tbl.release = ffb_driver_release;
+	dev->fn_tbl.presetup = ffb_presetup;
+	dev->fn_tbl.pretakedown = ffb_driver_pretakedown;
+	dev->fn_tbl.postcleanup = ffb_driver_postcleanup;
+	dev->fn_tbl.kernel_context_switch = ffb_context_switch;
+	dev->fn_tbl.kernel_context_switch_unlock = ffb_driver_kernel_context_switch_unlock;
+	dev->fn_tbl.get_map_ofs = ffb_driver_get_map_ofs;
+	dev->fn_tbl.get_reg_ofs = ffb_driver_get_reg_ofs;
+}
diff -Nru a/drivers/char/drm/ffb_drv.h b/drivers/char/drm/ffb_drv.h
--- a/drivers/char/drm/ffb_drv.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/ffb_drv.h	Mon Sep  6 21:54:11 2004
@@ -281,3 +281,6 @@
 					   unsigned long len,
 					   unsigned long pgoff,
 					   unsigned long flags);
+extern void ffb_set_context_ioctls(void);
+extern drm_ioctl_desc_t DRM(ioctls)[];
+
diff -Nru a/drivers/char/drm/gamma.h b/drivers/char/drm/gamma.h
--- a/drivers/char/drm/gamma.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/gamma.h	Mon Sep  6 21:54:11 2004
@@ -69,15 +69,9 @@

 /* DMA customization:
  */
-#define __HAVE_DMA			1
-#define __HAVE_OLD_DMA			1
-
 #define __HAVE_MULTIPLE_DMA_QUEUES	1
 #define __HAVE_DMA_WAITQUEUE		1

 /* removed from DRM HAVE_DMA_FREELIST & HAVE_DMA_SCHEDULE */
-
-#define __HAVE_IRQ			1
-#define __HAVE_IRQ_BH			1

 #endif /* __GAMMA_H__ */
diff -Nru a/drivers/char/drm/gamma_dma.c b/drivers/char/drm/gamma_dma.c
--- a/drivers/char/drm/gamma_dma.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/gamma_dma.c	Mon Sep  6 21:54:11 2004
@@ -116,7 +116,7 @@
 	return (!GAMMA_READ(GAMMA_DMACOUNT));
 }

-irqreturn_t gamma_irq_handler( DRM_IRQ_ARGS )
+irqreturn_t gamma_driver_irq_handler( DRM_IRQ_ARGS )
 {
 	drm_device_t	 *dev = (drm_device_t *)arg;
 	drm_device_dma_t *dma = dev->dma;
@@ -689,13 +689,13 @@
 {
 	DRM_DEBUG( "%s\n", __FUNCTION__ );

-#if __HAVE_IRQ
 	/* Make sure interrupts are disabled here because the uninstall ioctl
 	 * may not have been called from userspace and after dev_private
 	 * is freed, it's too late.
 	 */
-	if ( dev->irq_enabled ) DRM(irq_uninstall)(dev);
-#endif
+	if (drm_core_check_feature(dev, DRIVER_HAVE_IRQ))
+		if ( dev->irq_enabled )
+			DRM(irq_uninstall)(dev);

 	if ( dev->dev_private ) {

@@ -866,7 +866,7 @@
 	return 0;
 }

-void DRM(driver_irq_preinstall)( drm_device_t *dev ) {
+void gamma_driver_irq_preinstall( drm_device_t *dev ) {
 	drm_gamma_private_t *dev_priv =
 				(drm_gamma_private_t *)dev->dev_private;

@@ -877,7 +877,7 @@
 	GAMMA_WRITE( GAMMA_GDMACONTROL,		0x00000000 );
 }

-void DRM(driver_irq_postinstall)( drm_device_t *dev ) {
+void gamma_driver_irq_postinstall( drm_device_t *dev ) {
 	drm_gamma_private_t *dev_priv =
 				(drm_gamma_private_t *)dev->dev_private;

@@ -889,7 +889,7 @@
 	GAMMA_WRITE( GAMMA_GDELAYTIMER,		0x00039090 );
 }

-void DRM(driver_irq_uninstall)( drm_device_t *dev ) {
+void gamma_driver_irq_uninstall( drm_device_t *dev ) {
 	drm_gamma_private_t *dev_priv =
 				(drm_gamma_private_t *)dev->dev_private;
 	if (!dev_priv)
@@ -934,7 +934,7 @@

 void gamma_driver_register_fns(drm_device_t *dev)
 {
-	dev->driver_features = DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA;
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA | DRIVER_HAVE_DMA | DRIVER_HAVE_IRQ;
 	DRM(fops).read = gamma_fops_read;
 	DRM(fops).poll = gamma_fops_poll;
 	dev->fn_tbl.preinit = gamma_driver_preinit;
diff -Nru a/drivers/char/drm/i810.h b/drivers/char/drm/i810.h
--- a/drivers/char/drm/i810.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/i810.h	Mon Sep  6 21:54:11 2004
@@ -80,16 +80,4 @@
 #define __HAVE_COUNTER8         _DRM_STAT_SECONDARY
 #define __HAVE_COUNTER9         _DRM_STAT_DMA

-/* DMA customization:
- */
-#define __HAVE_DMA		1
-#define __HAVE_DMA_QUEUE	1
-#define __HAVE_DMA_RECLAIM	1
-
-/* Don't need an irq any more.  The template code will make sure that
- * a noop stub is generated for compatibility.
- */
-/* XXX: Add vblank support? */
-#define __HAVE_IRQ		0
-
 #endif
diff -Nru a/drivers/char/drm/i810_dma.c b/drivers/char/drm/i810_dma.c
--- a/drivers/char/drm/i810_dma.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/i810_dma.c	Mon Sep  6 21:54:11 2004
@@ -232,13 +232,12 @@
 {
 	drm_device_dma_t *dma = dev->dma;

-#if __HAVE_IRQ
 	/* Make sure interrupts are disabled here because the uninstall ioctl
 	 * may not have been called from userspace and after dev_private
 	 * is freed, it's too late.
 	 */
-	if ( dev->irq_enabled ) DRM(irq_uninstall)(dev);
-#endif
+	if (drm_core_check_feature(dev, DRIVER_HAVE_IRQ) && dev->irq_enabled)
+		DRM(irq_uninstall)(dev);

 	if (dev->dev_private) {
 		int i;
@@ -1407,10 +1406,11 @@

 void i810_driver_register_fns(drm_device_t *dev)
 {
-	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR;
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR | DRIVER_HAVE_DMA | DRIVER_DMA_QUEUE;
 	dev->dev_priv_size = sizeof(drm_i810_buf_priv_t);
 	dev->fn_tbl.pretakedown = i810_driver_pretakedown;
 	dev->fn_tbl.release = i810_driver_release;
 	dev->fn_tbl.dma_quiescent = i810_driver_dma_quiescent;
+	dev->fn_tbl.reclaim_buffers = i810_reclaim_buffers;
 }

diff -Nru a/drivers/char/drm/i810_drv.c b/drivers/char/drm/i810_drv.c
--- a/drivers/char/drm/i810_drv.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/i810_drv.c	Mon Sep  6 21:54:11 2004
@@ -48,6 +48,7 @@
 #include "drm_fops.h"
 #include "drm_init.h"
 #include "drm_ioctl.h"
+#include "drm_irq.h"
 #include "drm_lock.h"
 #include "drm_memory.h"
 #include "drm_proc.h"
diff -Nru a/drivers/char/drm/i830.h b/drivers/char/drm/i830.h
--- a/drivers/char/drm/i830.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/i830.h	Mon Sep  6 21:54:11 2004
@@ -79,24 +79,11 @@
 #define __HAVE_COUNTER8         _DRM_STAT_SECONDARY
 #define __HAVE_COUNTER9         _DRM_STAT_DMA

-/* DMA customization:
- */
-#define __HAVE_DMA		1
-#define __HAVE_DMA_QUEUE	1
-#define __HAVE_DMA_RECLAIM	1
-
 /* Driver will work either way: IRQ's save cpu time when waiting for
  * the card, but are subject to subtle interactions between bios,
  * hardware and the driver.
  */
 /* XXX: Add vblank support? */
 #define USE_IRQS 0
-
-#if USE_IRQS
-#define __HAVE_IRQ		1
-#define __HAVE_SHARED_IRQ	1
-#else
-#define __HAVE_IRQ          0
-#endif

 #endif
diff -Nru a/drivers/char/drm/i830_dma.c b/drivers/char/drm/i830_dma.c
--- a/drivers/char/drm/i830_dma.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/i830_dma.c	Mon Sep  6 21:54:11 2004
@@ -233,13 +233,11 @@
 {
 	drm_device_dma_t *dma = dev->dma;

-#if __HAVE_IRQ
 	/* Make sure interrupts are disabled here because the uninstall ioctl
 	 * may not have been called from userspace and after dev_private
 	 * is freed, it's too late.
 	 */
 	if ( dev->irq_enabled ) DRM(irq_uninstall)(dev);
-#endif

 	if (dev->dev_private) {
 		int i;
@@ -1602,10 +1600,20 @@

 void i830_driver_register_fns(drm_device_t *dev)
 {
-	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR;
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR | DRIVER_HAVE_DMA | DRIVER_DMA_QUEUE;
+#if USE_IRQS
+	dev->driver_features |= DRIVER_HAVE_IRQ | DRIVER_SHARED_IRQ;
+#endif
 	dev->dev_priv_size = sizeof(drm_i830_buf_priv_t);
 	dev->fn_tbl.pretakedown = i830_driver_pretakedown;
 	dev->fn_tbl.release = i830_driver_release;
 	dev->fn_tbl.dma_quiescent = i830_driver_dma_quiescent;
+	dev->fn_tbl.reclaim_buffers = i830_reclaim_buffers;
+#if USE_IRQS
+	dev->fn_tbl.irq_preinstall = i830_driver_irq_preinstall;
+	dev->fn_tbl.irq_postinstall = i830_driver_irq_postinstall;
+	dev->fn_tbl.irq_uninstall = i830_driver_irq_uninstall;
+	dev->fn_tbl.irq_handler = i830_driver_irq_handler;
+#endif
 }

diff -Nru a/drivers/char/drm/i830_drv.h b/drivers/char/drm/i830_drv.h
--- a/drivers/char/drm/i830_drv.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/i830_drv.h	Mon Sep  6 21:54:11 2004
@@ -136,6 +136,10 @@
 extern int i830_wait_irq(drm_device_t *dev, int irq_nr);
 extern int i830_emit_irq(drm_device_t *dev);

+extern irqreturn_t i830_driver_irq_handler( DRM_IRQ_ARGS );
+extern void i830_driver_irq_preinstall( drm_device_t *dev );
+extern void i830_driver_irq_postinstall( drm_device_t *dev );
+extern void i830_driver_irq_uninstall( drm_device_t *dev );

 #define I830_BASE(reg)		((unsigned long) \
 				dev_priv->mmio_map->handle)
diff -Nru a/drivers/char/drm/i830_irq.c b/drivers/char/drm/i830_irq.c
--- a/drivers/char/drm/i830_irq.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/i830_irq.c	Mon Sep  6 21:54:11 2004
@@ -35,7 +35,7 @@
 #include <linux/delay.h>


-irqreturn_t DRM(irq_handler)( DRM_IRQ_ARGS )
+irqreturn_t i830_driver_irq_handler( DRM_IRQ_ARGS )
 {
 	drm_device_t	 *dev = (drm_device_t *)arg;
       	drm_i830_private_t *dev_priv = (drm_i830_private_t *)dev->dev_private;
@@ -178,7 +178,7 @@

 /* drm_dma.h hooks
 */
-void DRM(driver_irq_preinstall)( drm_device_t *dev ) {
+void i830_driver_irq_preinstall( drm_device_t *dev ) {
 	drm_i830_private_t *dev_priv =
 		(drm_i830_private_t *)dev->dev_private;

@@ -190,14 +190,14 @@
 	init_waitqueue_head(&dev_priv->irq_queue);
 }

-void DRM(driver_irq_postinstall)( drm_device_t *dev ) {
+void i830_driver_irq_postinstall( drm_device_t *dev ) {
 	drm_i830_private_t *dev_priv =
 		(drm_i830_private_t *)dev->dev_private;

 	I830_WRITE16( I830REG_INT_ENABLE_R, 0x2 );
 }

-void DRM(driver_irq_uninstall)( drm_device_t *dev ) {
+void i830_driver_irq_uninstall( drm_device_t *dev ) {
 	drm_i830_private_t *dev_priv =
 		(drm_i830_private_t *)dev->dev_private;
 	if (!dev_priv)
diff -Nru a/drivers/char/drm/i915.h b/drivers/char/drm/i915.h
--- a/drivers/char/drm/i915.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/i915.h	Mon Sep  6 21:54:11 2004
@@ -54,10 +54,6 @@
 /* We use our own dma mechanisms, not the drm template code.  However,
  * the shared IRQ code is useful to us:
  */
-#define __HAVE_DMA		0
-#define __HAVE_IRQ		1
-#define __HAVE_SHARED_IRQ	1
-
 #define __HAVE_PM		1

 #endif
diff -Nru a/drivers/char/drm/i915_dma.c b/drivers/char/drm/i915_dma.c
--- a/drivers/char/drm/i915_dma.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/i915_dma.c	Mon Sep  6 21:54:11 2004
@@ -732,7 +732,11 @@

 void i915_driver_register_fns(drm_device_t *dev)
 {
-	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR;
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR | DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED;
 	dev->fn_tbl.pretakedown = i915_driver_pretakedown;
 	dev->fn_tbl.prerelease = i915_driver_prerelease;
+	dev->fn_tbl.irq_preinstall = i915_driver_irq_preinstall;
+	dev->fn_tbl.irq_postinstall = i915_driver_irq_postinstall;
+	dev->fn_tbl.irq_uninstall = i915_driver_irq_uninstall;
+	dev->fn_tbl.irq_handler = i915_driver_irq_handler;
 }
diff -Nru a/drivers/char/drm/i915_drv.c b/drivers/char/drm/i915_drv.c
--- a/drivers/char/drm/i915_drv.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/i915_drv.c	Mon Sep  6 21:54:11 2004
@@ -19,6 +19,7 @@
 #include "drm_bufs.h"
 #include "drm_context.h"	/* is this needed? */
 #include "drm_drawable.h"	/* is this needed? */
+#include "drm_dma.h"
 #include "drm_drv.h"
 #include "drm_fops.h"
 #include "drm_init.h"
diff -Nru a/drivers/char/drm/i915_drv.h b/drivers/char/drm/i915_drv.h
--- a/drivers/char/drm/i915_drv.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/i915_drv.h	Mon Sep  6 21:54:11 2004
@@ -73,6 +73,11 @@
 extern int i915_wait_irq(drm_device_t * dev, int irq_nr);
 extern int i915_emit_irq(drm_device_t * dev);

+extern irqreturn_t i915_driver_irq_handler(DRM_IRQ_ARGS);
+extern void i915_driver_irq_preinstall(drm_device_t *dev);
+extern void i915_driver_irq_postinstall(drm_device_t *dev);
+extern void i915_driver_irq_uninstall(drm_device_t *dev);
+
 /* i915_mem.c */
 extern int i915_mem_alloc(DRM_IOCTL_ARGS);
 extern int i915_mem_free(DRM_IOCTL_ARGS);
diff -Nru a/drivers/char/drm/i915_irq.c b/drivers/char/drm/i915_irq.c
--- a/drivers/char/drm/i915_irq.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/i915_irq.c	Mon Sep  6 21:54:11 2004
@@ -17,7 +17,8 @@
 #define MAX_NOPID ((u32)~0)
 #define READ_BREADCRUMB(dev_priv)  (((u32*)(dev_priv->hw_status_page))[5])

-irqreturn_t DRM(irq_handler) (DRM_IRQ_ARGS) {
+irqreturn_t i915_driver_irq_handler(DRM_IRQ_ARGS)
+{
 	drm_device_t *dev = (drm_device_t *) arg;
 	drm_i915_private_t *dev_priv = (drm_i915_private_t *) dev->dev_private;
 	u16 temp;
@@ -135,7 +136,8 @@

 /* drm_dma.h hooks
 */
-void DRM(driver_irq_preinstall) (drm_device_t * dev) {
+void i915_driver_irq_preinstall(drm_device_t * dev)
+{
 	drm_i915_private_t *dev_priv = (drm_i915_private_t *) dev->dev_private;

 	I915_WRITE16(I915REG_HWSTAM, 0xfffe);
@@ -143,14 +145,16 @@
 	I915_WRITE16(I915REG_INT_ENABLE_R, 0x0);
 }

-void DRM(driver_irq_postinstall) (drm_device_t * dev) {
+void i915_driver_irq_postinstall(drm_device_t * dev)
+{
 	drm_i915_private_t *dev_priv = (drm_i915_private_t *) dev->dev_private;

 	I915_WRITE16(I915REG_INT_ENABLE_R, USER_INT_FLAG);
 	DRM_INIT_WAITQUEUE(&dev_priv->irq_queue);
 }

-void DRM(driver_irq_uninstall) (drm_device_t * dev) {
+void i915_driver_irq_uninstall(drm_device_t * dev)
+{
 	drm_i915_private_t *dev_priv = (drm_i915_private_t *) dev->dev_private;
 	if (!dev_priv)
 		return;
diff -Nru a/drivers/char/drm/mga.h b/drivers/char/drm/mga.h
--- a/drivers/char/drm/mga.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/mga.h	Mon Sep  6 21:54:11 2004
@@ -65,11 +65,4 @@
 #define __HAVE_COUNTER7         _DRM_STAT_PRIMARY
 #define __HAVE_COUNTER8         _DRM_STAT_SECONDARY

-/* DMA customization:
- */
-#define __HAVE_DMA		1
-#define __HAVE_IRQ		1
-#define __HAVE_VBL_IRQ		1
-#define __HAVE_SHARED_IRQ       1
-
 #endif
diff -Nru a/drivers/char/drm/mga_dma.c b/drivers/char/drm/mga_dma.c
--- a/drivers/char/drm/mga_dma.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/mga_dma.c	Mon Sep  6 21:54:11 2004
@@ -630,13 +630,11 @@
 {
 	DRM_DEBUG( "\n" );

-#if __HAVE_IRQ
 	/* Make sure interrupts are disabled here because the uninstall ioctl
 	 * may not have been called from userspace and after dev_private
 	 * is freed, it's too late.
 	 */
 	if ( dev->irq_enabled ) DRM(irq_uninstall)(dev);
-#endif

 	if ( dev->dev_private ) {
 		drm_mga_private_t *dev_priv = dev->dev_private;
@@ -813,7 +811,12 @@

 void mga_driver_register_fns(drm_device_t *dev)
 {
-	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR;
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_REQUIRE_AGP | DRIVER_USE_MTRR | DRIVER_HAVE_DMA | DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_IRQ_VBL;
 	dev->fn_tbl.pretakedown = mga_driver_pretakedown;
 	dev->fn_tbl.dma_quiescent = mga_driver_dma_quiescent;
+	dev->fn_tbl.vblank_wait = mga_driver_vblank_wait;
+	dev->fn_tbl.irq_preinstall = mga_driver_irq_preinstall;
+	dev->fn_tbl.irq_postinstall = mga_driver_irq_postinstall;
+	dev->fn_tbl.irq_uninstall = mga_driver_irq_uninstall;
+	dev->fn_tbl.irq_handler = mga_driver_irq_handler;
 }
diff -Nru a/drivers/char/drm/mga_drv.h b/drivers/char/drm/mga_drv.h
--- a/drivers/char/drm/mga_drv.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/mga_drv.h	Mon Sep  6 21:54:11 2004
@@ -130,6 +130,12 @@
 extern int mga_warp_install_microcode( drm_mga_private_t *dev_priv );
 extern int mga_warp_init( drm_mga_private_t *dev_priv );

+extern int mga_driver_vblank_wait(drm_device_t *dev, unsigned int *sequence);
+extern irqreturn_t mga_driver_irq_handler( DRM_IRQ_ARGS );
+extern void mga_driver_irq_preinstall( drm_device_t *dev );
+extern void mga_driver_irq_postinstall( drm_device_t *dev );
+extern void mga_driver_irq_uninstall( drm_device_t *dev );
+
 #define mga_flush_write_combine()	DRM_WRITEMEMORYBARRIER()

 #if defined(__linux__) && defined(__alpha__)
diff -Nru a/drivers/char/drm/mga_irq.c b/drivers/char/drm/mga_irq.c
--- a/drivers/char/drm/mga_irq.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/mga_irq.c	Mon Sep  6 21:54:11 2004
@@ -36,7 +36,7 @@
 #include "mga_drm.h"
 #include "mga_drv.h"

-irqreturn_t mga_irq_handler( DRM_IRQ_ARGS )
+irqreturn_t mga_driver_irq_handler( DRM_IRQ_ARGS )
 {
 	drm_device_t *dev = (drm_device_t *) arg;
 	drm_mga_private_t *dev_priv =
@@ -56,7 +56,7 @@
 	return IRQ_NONE;
 }

-int mga_vblank_wait(drm_device_t *dev, unsigned int *sequence)
+int mga_driver_vblank_wait(drm_device_t *dev, unsigned int *sequence)
 {
 	unsigned int cur_vblank;
 	int ret = 0;
diff -Nru a/drivers/char/drm/r128.h b/drivers/char/drm/r128.h
--- a/drivers/char/drm/r128.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/r128.h	Mon Sep  6 21:54:11 2004
@@ -72,11 +72,4 @@
    [DRM_IOCTL_NR(DRM_IOCTL_R128_INDIRECT)]   = { r128_cce_indirect, 1, 1 }, \
    [DRM_IOCTL_NR(DRM_IOCTL_R128_GETPARAM)]   = { r128_getparam, 1, 0 },

-/* DMA customization:
- */
-#define __HAVE_DMA		1
-#define __HAVE_IRQ		1
-#define __HAVE_VBL_IRQ		1
-#define __HAVE_SHARED_IRQ       1
-
 #endif
diff -Nru a/drivers/char/drm/r128_cce.c b/drivers/char/drm/r128_cce.c
--- a/drivers/char/drm/r128_cce.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/r128_cce.c	Mon Sep  6 21:54:11 2004
@@ -586,13 +586,11 @@
 int r128_do_cleanup_cce( drm_device_t *dev )
 {

-#if __HAVE_IRQ
 	/* Make sure interrupts are disabled here because the uninstall ioctl
 	 * may not have been called from userspace and after dev_private
 	 * is freed, it's too late.
 	 */
 	if ( dev->irq_enabled ) DRM(irq_uninstall)(dev);
-#endif

 	if ( dev->dev_private ) {
 		drm_r128_private_t *dev_priv = dev->dev_private;
diff -Nru a/drivers/char/drm/r128_drv.h b/drivers/char/drm/r128_drv.h
--- a/drivers/char/drm/r128_drv.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/r128_drv.h	Mon Sep  6 21:54:11 2004
@@ -142,6 +142,12 @@
 extern int r128_cce_stipple( DRM_IOCTL_ARGS );
 extern int r128_cce_indirect( DRM_IOCTL_ARGS );

+extern int r128_driver_vblank_wait(drm_device_t *dev, unsigned int *sequence);
+
+extern irqreturn_t r128_driver_irq_handler( DRM_IRQ_ARGS );
+extern void r128_driver_irq_preinstall( drm_device_t *dev );
+extern void r128_driver_irq_postinstall( drm_device_t *dev );
+extern void r128_driver_irq_uninstall( drm_device_t *dev );

 /* Register definitions, register access macros and drmAddMap constants
  * for Rage 128 kernel driver.
diff -Nru a/drivers/char/drm/r128_irq.c b/drivers/char/drm/r128_irq.c
--- a/drivers/char/drm/r128_irq.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/r128_irq.c	Mon Sep  6 21:54:11 2004
@@ -36,7 +36,7 @@
 #include "r128_drm.h"
 #include "r128_drv.h"

-irqreturn_t r128_irq_handler( DRM_IRQ_ARGS )
+irqreturn_t r128_driver_irq_handler( DRM_IRQ_ARGS )
 {
 	drm_device_t *dev = (drm_device_t *) arg;
 	drm_r128_private_t *dev_priv =
@@ -56,7 +56,7 @@
 	return IRQ_NONE;
 }

-int DRM(vblank_wait)(drm_device_t *dev, unsigned int *sequence)
+int r128_driver_vblank_wait(drm_device_t *dev, unsigned int *sequence)
 {
 	unsigned int cur_vblank;
 	int ret = 0;
diff -Nru a/drivers/char/drm/r128_state.c b/drivers/char/drm/r128_state.c
--- a/drivers/char/drm/r128_state.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/r128_state.c	Mon Sep  6 21:54:11 2004
@@ -1712,8 +1712,13 @@

 void r128_driver_register_fns(drm_device_t *dev)
 {
-	dev->driver_features = DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA | DRIVER_SG;
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA | DRIVER_SG | DRIVER_HAVE_DMA | DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_IRQ_VBL;
 	dev->dev_priv_size = sizeof(drm_r128_buf_priv_t);
 	dev->fn_tbl.prerelease = r128_driver_prerelease;
 	dev->fn_tbl.pretakedown = r128_driver_pretakedown;
+	dev->fn_tbl.vblank_wait = r128_driver_vblank_wait;
+	dev->fn_tbl.irq_preinstall = r128_driver_irq_preinstall;
+	dev->fn_tbl.irq_postinstall = r128_driver_irq_postinstall;
+	dev->fn_tbl.irq_uninstall = r128_driver_irq_uninstall;
+	dev->fn_tbl.irq_handler = r128_driver_irq_handler;
 }
diff -Nru a/drivers/char/drm/radeon.h b/drivers/char/drm/radeon.h
--- a/drivers/char/drm/radeon.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/radeon.h	Mon Sep  6 21:54:11 2004
@@ -109,11 +109,4 @@
  [DRM_IOCTL_NR(DRM_IOCTL_RADEON_IRQ_WAIT)]   = { radeon_irq_wait,    1, 0 }, \
  [DRM_IOCTL_NR(DRM_IOCTL_RADEON_SETPARAM)]   = { radeon_cp_setparam, 1, 0 }, \

-/* DMA customization:
- */
-#define __HAVE_DMA		1
-#define __HAVE_IRQ		1
-#define __HAVE_VBL_IRQ		1
-#define __HAVE_SHARED_IRQ       1
-
 #endif
diff -Nru a/drivers/char/drm/radeon_cp.c b/drivers/char/drm/radeon_cp.c
--- a/drivers/char/drm/radeon_cp.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/radeon_cp.c	Mon Sep  6 21:54:11 2004
@@ -1275,13 +1275,11 @@
 {
 	DRM_DEBUG( "\n" );

-#if __HAVE_IRQ
 	/* Make sure interrupts are disabled here because the uninstall ioctl
 	 * may not have been called from userspace and after dev_private
 	 * is freed, it's too late.
 	 */
 	if ( dev->irq_enabled ) DRM(irq_uninstall)(dev);
-#endif

 	if ( dev->dev_private ) {
 		drm_radeon_private_t *dev_priv = dev->dev_private;
diff -Nru a/drivers/char/drm/radeon_drv.h b/drivers/char/drm/radeon_drv.h
--- a/drivers/char/drm/radeon_drv.h	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/radeon_drv.h	Mon Sep  6 21:54:11 2004
@@ -205,6 +205,11 @@
 extern int radeon_emit_irq(drm_device_t *dev);

 extern void radeon_do_release(drm_device_t *dev);
+extern int radeon_driver_vblank_wait(drm_device_t *dev, unsigned int *sequence);
+extern irqreturn_t radeon_driver_irq_handler( DRM_IRQ_ARGS );
+extern void radeon_driver_irq_preinstall( drm_device_t *dev );
+extern void radeon_driver_irq_postinstall( drm_device_t *dev );
+extern void radeon_driver_irq_uninstall( drm_device_t *dev );

 /* Flags for stats.boxes
  */
diff -Nru a/drivers/char/drm/radeon_irq.c b/drivers/char/drm/radeon_irq.c
--- a/drivers/char/drm/radeon_irq.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/radeon_irq.c	Mon Sep  6 21:54:11 2004
@@ -54,7 +54,7 @@
  * tied to dma at all, this is just a hangover from dri prehistory.
  */

-irqreturn_t DRM(irq_handler)( DRM_IRQ_ARGS )
+irqreturn_t radeon_driver_irq_handler( DRM_IRQ_ARGS )
 {
 	drm_device_t *dev = (drm_device_t *) arg;
 	drm_radeon_private_t *dev_priv =
@@ -141,7 +141,7 @@
 }


-int DRM(vblank_wait)(drm_device_t *dev, unsigned int *sequence)
+int radeon_driver_vblank_wait(drm_device_t *dev, unsigned int *sequence)
 {
   	drm_radeon_private_t *dev_priv =
 	   (drm_radeon_private_t *)dev->dev_private;
diff -Nru a/drivers/char/drm/radeon_state.c b/drivers/char/drm/radeon_state.c
--- a/drivers/char/drm/radeon_state.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/radeon_state.c	Mon Sep  6 21:54:11 2004
@@ -2603,10 +2603,15 @@

 void radeon_driver_register_fns(struct drm_device *dev)
 {
-	dev->driver_features = DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA | DRIVER_SG;
+	dev->driver_features = DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA | DRIVER_SG | DRIVER_HAVE_IRQ | DRIVER_HAVE_DMA | DRIVER_IRQ_SHARED | DRIVER_IRQ_VBL;
 	dev->dev_priv_size = sizeof(drm_radeon_buf_priv_t);
 	dev->fn_tbl.prerelease = radeon_driver_prerelease;
 	dev->fn_tbl.pretakedown = radeon_driver_pretakedown;
 	dev->fn_tbl.open_helper = radeon_driver_open_helper;
 	dev->fn_tbl.free_filp_priv = radeon_driver_free_filp_priv;
+	dev->fn_tbl.vblank_wait = radeon_driver_vblank_wait;
+ 	dev->fn_tbl.irq_preinstall = radeon_driver_irq_preinstall;
+ 	dev->fn_tbl.irq_postinstall = radeon_driver_irq_postinstall;
+ 	dev->fn_tbl.irq_uninstall = radeon_driver_irq_uninstall;
+ 	dev->fn_tbl.irq_handler = radeon_driver_irq_handler;
 }
diff -Nru a/drivers/char/drm/sis_drv.c b/drivers/char/drm/sis_drv.c
--- a/drivers/char/drm/sis_drv.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/sis_drv.c	Mon Sep  6 21:54:11 2004
@@ -40,6 +40,7 @@
 #include "drm_drv.h"
 #include "drm_fops.h"
 #include "drm_init.h"
+#include "drm_irq.h"
 #include "drm_ioctl.h"
 #include "drm_lock.h"
 #include "drm_memory.h"
diff -Nru a/drivers/char/drm/tdfx_drv.c b/drivers/char/drm/tdfx_drv.c
--- a/drivers/char/drm/tdfx_drv.c	Mon Sep  6 21:54:11 2004
+++ b/drivers/char/drm/tdfx_drv.c	Mon Sep  6 21:54:11 2004
@@ -45,6 +45,7 @@
 #include "drm_fops.h"
 #include "drm_init.h"
 #include "drm_ioctl.h"
+#include "drm_irq.h"
 #include "drm_lock.h"
 #include "drm_memory.h"
 #include "drm_proc.h"
