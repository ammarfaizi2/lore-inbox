Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUIEJWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUIEJWn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 05:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266466AbUIEJWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 05:22:43 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:10383 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S266457AbUIEJVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 05:21:36 -0400
Date: Sun, 5 Sep 2004 10:21:34 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: [RFC] DRM remove DMA/IRQ macros..
Message-ID: <Pine.LNX.4.58.0409051015570.14009@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	The attached patch dumps the DMA/IRQ macros, I've realised I one
more to go after this for some macros from the ffb driver,

This one should be no issues, except maybe the separate init function
macro for the reclaim buffers....

Dave.

===== drivers/char/drm/drmP.h 1.48 vs edited =====
--- 1.48/drivers/char/drm/drmP.h	Sun Sep  5 10:55:34 2004
+++ edited/drivers/char/drm/drmP.h	Sun Sep  5 19:03:30 2004
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
@@ -566,6 +562,13 @@
  	int (*context_dtor)(struct drm_device *dev, int context);
  	int (*kernel_context_switch)(struct drm_device *dev, int old, int new);
  	int (*kernel_context_switch_unlock)(struct drm_device *dev);
+	int (*vblank_wait)(struct drm_device *dev, unsigned int *sequence);
+	/* these have to be filled in */
+	irqreturn_t (*irq_handler)( DRM_IRQ_ARGS );
+ 	void (*irq_preinstall)(struct drm_device *dev);
+ 	void (*irq_postinstall)(struct drm_device *dev);
+ 	void (*irq_uninstall)(struct drm_device *dev);
+	void (*reclaim_buffers)(struct file *filp);
 };
 /**
  * DRM device structure.
@@ -655,13 +658,13 @@
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
@@ -864,7 +867,6 @@
 				  unsigned int cmd, unsigned long arg );
 extern int	     DRM(rmmap)( struct inode *inode, struct file *filp,
 				 unsigned int cmd, unsigned long arg );
-#if __HAVE_DMA
 extern int	     DRM(addbufs)( struct inode *inode, struct file *filp,
 				   unsigned int cmd, unsigned long arg );
 extern int	     DRM(infobufs)( struct inode *inode, struct file *filp,
@@ -881,31 +883,21 @@
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
===== drivers/char/drm/drm_bufs.h 1.26 vs edited =====
--- 1.26/drivers/char/drm/drm_bufs.h	Sun Sep  5 10:30:48 2004
+++ edited/drivers/char/drm/drm_bufs.h	Sun Sep  5 17:32:09 2004
@@ -286,8 +286,6 @@
 	return 0;
 }

-#if __HAVE_DMA
-
 /**
  * Cleanup after an error on one of the addbufs() functions.
  *
@@ -926,6 +924,11 @@
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
@@ -971,6 +974,9 @@
 	int i;
 	int count;

+	if (!drm_core_check_feature(dev, DRIVER_HAVE_DMA))
+		return -EINVAL;
+
 	if ( !dma ) return -EINVAL;

 	spin_lock( &dev->count_lock );
@@ -1052,6 +1058,9 @@
 	int order;
 	drm_buf_entry_t *entry;

+	if (!drm_core_check_feature(dev, DRIVER_HAVE_DMA))
+		return -EINVAL;
+
 	if ( !dma ) return -EINVAL;

 	if ( copy_from_user( &request,
@@ -1099,6 +1108,9 @@
 	int idx;
 	drm_buf_t *buf;

+	if (!drm_core_check_feature(dev, DRIVER_HAVE_DMA))
+		return -EINVAL;
+
 	if ( !dma ) return -EINVAL;

 	if ( copy_from_user( &request,
@@ -1156,6 +1168,9 @@
 	drm_buf_map_t request;
 	int i;

+	if (!drm_core_check_feature(dev, DRIVER_HAVE_DMA))
+		return -EINVAL;
+
 	if ( !dma ) return -EINVAL;

 	spin_lock( &dev->count_lock );
@@ -1253,4 +1268,3 @@
 	return retcode;
 }

-#endif /* __HAVE_DMA */
===== drivers/char/drm/drm_dma.h 1.19 vs edited =====
--- 1.19/drivers/char/drm/drm_dma.h	Fri Sep  3 19:37:29 2004
+++ edited/drivers/char/drm/drm_dma.h	Sun Sep  5 18:22:10 2004
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
===== drivers/char/drm/drm_drv.h 1.44 vs edited =====
--- 1.44/drivers/char/drm/drm_drv.h	Sun Sep  5 10:55:34 2004
+++ edited/drivers/char/drm/drm_drv.h	Sun Sep  5 18:27:25 2004
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
@@ -200,11 +183,12 @@
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
@@ -327,9 +311,7 @@
 	if (dev->fn_tbl.pretakedown)
 	  dev->fn_tbl.pretakedown(dev);

-#if __HAVE_IRQ
 	if ( dev->irq_enabled ) DRM(irq_uninstall)( dev );
-#endif

 	down( &dev->struct_sem );
 	del_timer( &dev->timer );
@@ -430,8 +412,7 @@
 		dev->maplist = NULL;
  	}

-#if __HAVE_DMA_QUEUE || __HAVE_MULTIPLE_DMA_QUEUES
-	if ( dev->queuelist ) {
+	if (drm_core_check_feature(dev, DRIVER_DMA_QUEUE) && dev->queuelist ) {
 		for ( i = 0 ; i < dev->queue_count ; i++ ) {
 			if ( dev->queuelist[i] ) {
 				DRM(free)( dev->queuelist[i],
@@ -446,11 +427,10 @@
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
@@ -461,6 +441,11 @@
 	return 0;
 }

+static void DRM(init_fn_table)(struct drm_device *dev)
+{
+	dev->fn_tbl.reclaim_buffers = DRM(core_reclaim_buffers);
+}
+
 #include "drm_pciids.h"

 static struct pci_device_id DRM(pciidlist)[] = {
@@ -514,7 +499,10 @@
 	dev->irq = pdev->irq;

 	/* dev_priv_size can be changed by a driver in driver_register_fns */
- 	dev->dev_priv_size = sizeof(u32);
+	dev->dev_priv_size = sizeof(u32);
+
+	DRM(init_fn_table)(dev);
+
 	DRM(driver_register_fns)(dev);

 	if (dev->fn_tbl.preinit)
@@ -820,9 +808,10 @@
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

@@ -966,9 +955,6 @@
         DECLARE_WAITQUEUE( entry, current );
         drm_lock_t lock;
         int ret = 0;
-#if __HAVE_MULTIPLE_DMA_QUEUES
-	drm_queue_t *q;
-#endif

 	++priv->lock_count;

@@ -985,14 +971,9 @@
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
===== drivers/char/drm/drm_irq.h 1.5 vs edited =====
--- 1.5/drivers/char/drm/drm_irq.h	Sat Jul 17 00:14:58 2004
+++ edited/drivers/char/drm/drm_irq.h	Sun Sep  5 18:28:48 2004
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
===== drivers/char/drm/drm_os_linux.h 1.16 vs edited =====
--- 1.16/drivers/char/drm/drm_os_linux.h	Sun Sep  5 09:22:42 2004
+++ edited/drivers/char/drm/drm_os_linux.h	Sun Sep  5 18:30:22 2004
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

===== drivers/char/drm/gamma.h 1.18 vs edited =====
--- 1.18/drivers/char/drm/gamma.h	Sun Sep  5 10:30:48 2004
+++ edited/drivers/char/drm/gamma.h	Sun Sep  5 17:41:06 2004
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
===== drivers/char/drm/gamma_dma.c 1.26 vs edited =====
--- 1.26/drivers/char/drm/gamma_dma.c	Sun Sep  5 10:30:48 2004
+++ edited/drivers/char/drm/gamma_dma.c	Sun Sep  5 18:05:04 2004
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
===== drivers/char/drm/i810.h 1.18 vs edited =====
--- 1.18/drivers/char/drm/i810.h	Sun Sep  5 10:30:48 2004
+++ edited/drivers/char/drm/i810.h	Sun Sep  5 18:38:26 2004
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
===== drivers/char/drm/i810_dma.c 1.40 vs edited =====
--- 1.40/drivers/char/drm/i810_dma.c	Sun Sep  5 09:22:42 2004
+++ edited/drivers/char/drm/i810_dma.c	Sun Sep  5 18:37:41 2004
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

===== drivers/char/drm/i810_drv.c 1.9 vs edited =====
--- 1.9/drivers/char/drm/i810_drv.c	Sun Sep  5 10:30:48 2004
+++ edited/drivers/char/drm/i810_drv.c	Sun Sep  5 17:18:47 2004
@@ -48,6 +48,7 @@
 #include "drm_fops.h"
 #include "drm_init.h"
 #include "drm_ioctl.h"
+#include "drm_irq.h"
 #include "drm_lock.h"
 #include "drm_memory.h"
 #include "drm_proc.h"
===== drivers/char/drm/i830.h 1.16 vs edited =====
--- 1.16/drivers/char/drm/i830.h	Sun Sep  5 10:30:48 2004
+++ edited/drivers/char/drm/i830.h	Sun Sep  5 18:38:32 2004
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
===== drivers/char/drm/i830_dma.c 1.30 vs edited =====
--- 1.30/drivers/char/drm/i830_dma.c	Sun Sep  5 09:22:42 2004
+++ edited/drivers/char/drm/i830_dma.c	Sun Sep  5 18:38:11 2004
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

===== drivers/char/drm/i830_drv.h 1.11 vs edited =====
--- 1.11/drivers/char/drm/i830_drv.h	Fri Sep  3 19:05:58 2004
+++ edited/drivers/char/drm/i830_drv.h	Sun Sep  5 17:18:59 2004
@@ -136,6 +136,10 @@
 extern int i830_wait_irq(drm_device_t *dev, int irq_nr);
 extern int i830_emit_irq(drm_device_t *dev);

+extern irqreturn_t i830_driver_irq_handler( DRM_IRQ_ARGS );
+extern void i830_driver_irq_preinstall( drm_device_t *dev );
+extern void i830_driver_irq_postinstall( drm_device_t *dev );
+extern void i830_driver_irq_uninstall( drm_device_t *dev );

 #define I830_BASE(reg)		((unsigned long) \
 				dev_priv->mmio_map->handle)
===== drivers/char/drm/i830_irq.c 1.8 vs edited =====
--- 1.8/drivers/char/drm/i830_irq.c	Sat Jul 17 00:14:58 2004
+++ edited/drivers/char/drm/i830_irq.c	Sun Sep  5 17:18:59 2004
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
===== drivers/char/drm/i915.h 1.4 vs edited =====
--- 1.4/drivers/char/drm/i915.h	Sun Sep  5 10:30:48 2004
+++ edited/drivers/char/drm/i915.h	Sun Sep  5 17:43:24 2004
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
===== drivers/char/drm/i915_dma.c 1.5 vs edited =====
--- 1.5/drivers/char/drm/i915_dma.c	Sun Sep  5 09:22:42 2004
+++ edited/drivers/char/drm/i915_dma.c	Sun Sep  5 17:19:11 2004
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
===== drivers/char/drm/i915_drv.c 1.2 vs edited =====
--- 1.2/drivers/char/drm/i915_drv.c	Sun Sep  5 10:30:48 2004
+++ edited/drivers/char/drm/i915_drv.c	Sun Sep  5 17:18:59 2004
@@ -19,6 +19,7 @@
 #include "drm_bufs.h"
 #include "drm_context.h"	/* is this needed? */
 #include "drm_drawable.h"	/* is this needed? */
+#include "drm_dma.h"
 #include "drm_drv.h"
 #include "drm_fops.h"
 #include "drm_init.h"
===== drivers/char/drm/i915_drv.h 1.1 vs edited =====
--- 1.1/drivers/char/drm/i915_drv.h	Fri Aug 27 19:33:29 2004
+++ edited/drivers/char/drm/i915_drv.h	Sun Sep  5 18:41:11 2004
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
===== drivers/char/drm/i915_irq.c 1.2 vs edited =====
--- 1.2/drivers/char/drm/i915_irq.c	Fri Aug 27 20:36:17 2004
+++ edited/drivers/char/drm/i915_irq.c	Sun Sep  5 18:45:42 2004
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
===== drivers/char/drm/mga.h 1.14 vs edited =====
--- 1.14/drivers/char/drm/mga.h	Sun Sep  5 10:30:48 2004
+++ edited/drivers/char/drm/mga.h	Sun Sep  5 17:19:16 2004
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
===== drivers/char/drm/mga_dma.c 1.22 vs edited =====
--- 1.22/drivers/char/drm/mga_dma.c	Sun Sep  5 09:22:42 2004
+++ edited/drivers/char/drm/mga_dma.c	Sun Sep  5 17:19:16 2004
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
===== drivers/char/drm/mga_drv.h 1.15 vs edited =====
--- 1.15/drivers/char/drm/mga_drv.h	Sat Apr 10 16:19:59 2004
+++ edited/drivers/char/drm/mga_drv.h	Sun Sep  5 17:19:16 2004
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
===== drivers/char/drm/mga_irq.c 1.5 vs edited =====
--- 1.5/drivers/char/drm/mga_irq.c	Sat Apr 10 12:12:45 2004
+++ edited/drivers/char/drm/mga_irq.c	Sun Sep  5 17:19:16 2004
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
===== drivers/char/drm/r128.h 1.18 vs edited =====
--- 1.18/drivers/char/drm/r128.h	Sun Sep  5 10:30:48 2004
+++ edited/drivers/char/drm/r128.h	Sun Sep  5 17:45:10 2004
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
===== drivers/char/drm/r128_cce.c 1.23 vs edited =====
--- 1.23/drivers/char/drm/r128_cce.c	Sun Sep  5 09:22:42 2004
+++ edited/drivers/char/drm/r128_cce.c	Sun Sep  5 17:19:18 2004
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
===== drivers/char/drm/r128_drv.h 1.19 vs edited =====
--- 1.19/drivers/char/drm/r128_drv.h	Fri Sep  3 19:05:58 2004
+++ edited/drivers/char/drm/r128_drv.h	Sun Sep  5 17:19:18 2004
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
===== drivers/char/drm/r128_irq.c 1.5 vs edited =====
--- 1.5/drivers/char/drm/r128_irq.c	Sat Apr 10 12:12:45 2004
+++ edited/drivers/char/drm/r128_irq.c	Sun Sep  5 17:19:18 2004
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
===== drivers/char/drm/r128_state.c 1.21 vs edited =====
--- 1.21/drivers/char/drm/r128_state.c	Sun Sep  5 10:30:48 2004
+++ edited/drivers/char/drm/r128_state.c	Sun Sep  5 18:47:08 2004
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
===== drivers/char/drm/radeon.h 1.26 vs edited =====
--- 1.26/drivers/char/drm/radeon.h	Sun Sep  5 10:55:34 2004
+++ edited/drivers/char/drm/radeon.h	Sun Sep  5 17:47:09 2004
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
===== drivers/char/drm/radeon_cp.c 1.29 vs edited =====
--- 1.29/drivers/char/drm/radeon_cp.c	Sun Sep  5 09:22:42 2004
+++ edited/drivers/char/drm/radeon_cp.c	Sun Sep  5 17:19:22 2004
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
===== drivers/char/drm/radeon_drv.h 1.30 vs edited =====
--- 1.30/drivers/char/drm/radeon_drv.h	Sun Sep  5 10:55:34 2004
+++ edited/drivers/char/drm/radeon_drv.h	Sun Sep  5 17:19:22 2004
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
===== drivers/char/drm/radeon_irq.c 1.12 vs edited =====
--- 1.12/drivers/char/drm/radeon_irq.c	Sat Jul 17 00:14:58 2004
+++ edited/drivers/char/drm/radeon_irq.c	Sun Sep  5 17:19:22 2004
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
===== drivers/char/drm/radeon_state.c 1.34 vs edited =====
--- 1.34/drivers/char/drm/radeon_state.c	Sun Sep  5 10:55:34 2004
+++ edited/drivers/char/drm/radeon_state.c	Sun Sep  5 17:47:52 2004
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
===== drivers/char/drm/sis_drv.c 1.7 vs edited =====
--- 1.7/drivers/char/drm/sis_drv.c	Sun Sep  5 10:30:48 2004
+++ edited/drivers/char/drm/sis_drv.c	Sun Sep  5 17:19:08 2004
@@ -40,6 +40,7 @@
 #include "drm_drv.h"
 #include "drm_fops.h"
 #include "drm_init.h"
+#include "drm_irq.h"
 #include "drm_ioctl.h"
 #include "drm_lock.h"
 #include "drm_memory.h"
===== drivers/char/drm/tdfx_drv.c 1.10 vs edited =====
--- 1.10/drivers/char/drm/tdfx_drv.c	Sun Sep  5 10:30:48 2004
+++ edited/drivers/char/drm/tdfx_drv.c	Sun Sep  5 17:19:08 2004
@@ -45,6 +45,7 @@
 #include "drm_fops.h"
 #include "drm_init.h"
 #include "drm_ioctl.h"
+#include "drm_irq.h"
 #include "drm_lock.h"
 #include "drm_memory.h"
 #include "drm_proc.h"
