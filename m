Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268435AbUHaNU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268435AbUHaNU0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 09:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268144AbUHaNU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 09:20:26 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:23503 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S268435AbUHaNLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 09:11:13 -0400
Date: Tue, 31 Aug 2004 14:11:11 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: [rfc][patch] DRM initial function table support.
Message-ID: <Pine.LNX.4.58.0408311409530.18657@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay this is the first driver function table patch for the DRM, something
similar has been running in DRM CVS for a month or so (underneath another
5-10 patches removing all the rest of the macros..)

This patch disables gamma in the Makefile as it breaks it.. I'll do a
proper Kconfig later..

One thing we've discussed on dri-devel was changing the
if (dev->fn_tbl.function)
        dev->fn_tbl.function();

to something else but in future patches I've had slightly more complex
checks to do and this check looks to be the most obvious from a
readability point of view, if the driver supports the function call it..
The other option was to use default noop fns, this also caused issues
later on with some places where the code did more than just call the
function..

So please any comments on it?


===== drivers/char/drm/Makefile 1.18 vs edited =====
--- 1.18/drivers/char/drm/Makefile	Fri Aug 27 19:38:14 2004
+++ edited/drivers/char/drm/Makefile	Tue Aug 31 22:31:28 2004
@@ -2,7 +2,7 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.

-gamma-objs  := gamma_drv.o gamma_dma.o
+#gamma-objs  := gamma_drv.o gamma_dma.o
 tdfx-objs   := tdfx_drv.o
 r128-objs   := r128_drv.o r128_cce.o r128_state.o r128_irq.o
 mga-objs    := mga_drv.o mga_dma.o mga_state.o mga_warp.o mga_irq.o
@@ -13,7 +13,7 @@
 ffb-objs    := ffb_drv.o ffb_context.o
 sis-objs    := sis_drv.o sis_ds.o sis_mm.o

-obj-$(CONFIG_DRM_GAMMA) += gamma.o
+#obj-$(CONFIG_DRM_GAMMA) += gamma.o
 obj-$(CONFIG_DRM_TDFX)	+= tdfx.o
 obj-$(CONFIG_DRM_R128)	+= r128.o
 obj-$(CONFIG_DRM_RADEON)+= radeon.o
===== drivers/char/drm/drmP.h 1.40 vs edited =====
--- 1.40/drivers/char/drm/drmP.h	Sat Jul 17 00:14:58 2004
+++ edited/drivers/char/drm/drmP.h	Tue Aug 31 22:09:43 2004
@@ -610,6 +610,24 @@

 #endif

+/**
+ * DRM device functions structure
+ */
+struct drm_device;
+
+struct drm_driver_fn {
+	int (*preinit)(struct drm_device *);
+	int (*postinit)(struct drm_device *);
+	void (*prerelease)(struct drm_device *, struct file *filp);
+	void (*pretakedown)(struct drm_device *);
+	int (*postcleanup)(struct drm_device *);
+	int (*presetup)(struct drm_device *);
+	int (*postsetup)(struct drm_device *);
+	void (*open_helper)(struct drm_device *, drm_file_t *);
+	void (*release)(struct drm_device *, struct file *filp);
+	void (*dma_ready)(struct drm_device *);
+	int (*dma_quiescent)(struct drm_device *);
+};
 /**
  * DRM device structure.
  */
@@ -738,8 +756,12 @@
 	void		  *dev_private; /**< device private data */
 	drm_sigdata_t     sigdata; /**< For block_all_signals */
 	sigset_t          sigmask;
+
+	struct            drm_driver_fn fn_tbl;
+
 } drm_device_t;

+extern void DRM(driver_register_fns)(struct drm_device *dev);

 /******************************************************************/
 /** \name Internal function definitions */
===== drivers/char/drm/drm_drv.h 1.36 vs edited =====
--- 1.36/drivers/char/drm/drm_drv.h	Tue Jul 27 07:27:52 2004
+++ edited/drivers/char/drm/drm_drv.h	Tue Aug 31 22:35:08 2004
@@ -70,18 +70,6 @@
 #ifndef __HAVE_DMA_SCHEDULE
 #define __HAVE_DMA_SCHEDULE		0
 #endif
-#ifndef __HAVE_DMA_FLUSH
-#define __HAVE_DMA_FLUSH		0
-#endif
-#ifndef __HAVE_DMA_READY
-#define __HAVE_DMA_READY		0
-#endif
-#ifndef __HAVE_DMA_QUIESCENT
-#define __HAVE_DMA_QUIESCENT		0
-#endif
-#ifndef __HAVE_RELEASE
-#define __HAVE_RELEASE			0
-#endif
 #ifndef __HAVE_COUNTERS
 #define __HAVE_COUNTERS			0
 #endif
@@ -102,33 +90,9 @@
 #define __HAVE_DRIVER_FOPS_POLL		0
 #endif

-#ifndef DRIVER_PREINIT
-#define DRIVER_PREINIT()
-#endif
-#ifndef DRIVER_POSTINIT
-#define DRIVER_POSTINIT()
-#endif
-#ifndef DRIVER_PRERELEASE
-#define DRIVER_PRERELEASE()
-#endif
-#ifndef DRIVER_PRETAKEDOWN
-#define DRIVER_PRETAKEDOWN()
-#endif
-#ifndef DRIVER_POSTCLEANUP
-#define DRIVER_POSTCLEANUP()
-#endif
-#ifndef DRIVER_PRESETUP
-#define DRIVER_PRESETUP()
-#endif
-#ifndef DRIVER_POSTSETUP
-#define DRIVER_POSTSETUP()
-#endif
 #ifndef DRIVER_IOCTLS
 #define DRIVER_IOCTLS
 #endif
-#ifndef DRIVER_OPEN_HELPER
-#define DRIVER_OPEN_HELPER( priv, dev )
-#endif
 #ifndef DRIVER_FOPS
 #define DRIVER_FOPS				\
 static struct file_operations	DRM(fops) = {	\
@@ -169,7 +133,7 @@
 DRIVER_FOPS;

 /** Ioctl table */
-static drm_ioctl_desc_t		  DRM(ioctls)[] = {
+drm_ioctl_desc_t		  DRM(ioctls)[] = {
 	[DRM_IOCTL_NR(DRM_IOCTL_VERSION)]       = { DRM(version),     0, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_GET_UNIQUE)]    = { DRM(getunique),   0, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_GET_MAGIC)]     = { DRM(getmagic),    0, 0 },
@@ -208,12 +172,7 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_LOCK)]	        = { DRM(lock),        1, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_UNLOCK)]        = { DRM(unlock),      1, 0 },

-#if __HAVE_DMA_FLUSH
-	/* Gamma only, really */
-	[DRM_IOCTL_NR(DRM_IOCTL_FINISH)]        = { DRM(finish),      1, 0 },
-#else
 	[DRM_IOCTL_NR(DRM_IOCTL_FINISH)]        = { DRM(noop),      1, 0 },
-#endif

 #if __HAVE_DMA
 	[DRM_IOCTL_NR(DRM_IOCTL_ADD_BUFS)]      = { DRM(addbufs),     1, 1 },
@@ -265,7 +224,9 @@
 {
 	int i;

-	DRIVER_PRESETUP();
+	if (dev->fn_tbl.presetup)
+		dev->fn_tbl.presetup(dev);
+
 	atomic_set( &dev->ioctl_count, 0 );
 	atomic_set( &dev->vma_count, 0 );
 	dev->buf_use = 0;
@@ -371,7 +332,9 @@
 	 * drm_select_queue fails between the time the interrupt is
 	 * initialized and the time the queues are initialized.
 	 */
-	DRIVER_POSTSETUP();
+	if (dev->fn_tbl.postsetup)
+		dev->fn_tbl.postsetup(dev);
+
 	return 0;
 }

@@ -396,7 +359,9 @@

 	DRM_DEBUG( "\n" );

-	DRIVER_PRETAKEDOWN();
+	if (dev->fn_tbl.pretakedown)
+	  dev->fn_tbl.pretakedown(dev);
+
 #if __HAVE_IRQ
 	if ( dev->irq_enabled ) DRM(irq_uninstall)( dev );
 #endif
@@ -594,7 +559,10 @@
 	dev->pci_func = PCI_FUNC(pdev->devfn);
 	dev->irq = pdev->irq;

-	DRIVER_PREINIT();
+	DRM(driver_register_fns)(dev);
+
+	if (dev->fn_tbl.preinit)
+	  dev->fn_tbl.preinit(dev);

 #if __REALLY_HAVE_AGP
 	dev->agp = DRM(agp_init)();
@@ -635,7 +603,8 @@
 		dev->minor,
 		pci_pretty_name(pdev));

-	DRIVER_POSTINIT();
+	if (dev->fn_tbl.postinit)
+	  dev->fn_tbl.postinit(dev);

 	return 0;
 }
@@ -718,8 +687,10 @@
 			dev->agp = NULL;
 		}
 #endif
+		if (dev->fn_tbl.postcleanup)
+		  dev->fn_tbl.postcleanup(dev);
+
 	}
-	DRIVER_POSTCLEANUP();
 	DRM(numdevs) = 0;
 }

@@ -834,7 +805,8 @@

 	DRM_DEBUG( "open_count = %d\n", dev->open_count );

-	DRIVER_PRERELEASE();
+	if (dev->fn_tbl.prerelease)
+		dev->fn_tbl.prerelease(dev, filp);

 	/* ========================================================
 	 * Begin inline drm_release
@@ -849,9 +821,10 @@
 		DRM_DEBUG( "File %p released, freeing lock for context %d\n",
 			filp,
 			_DRM_LOCKING_CONTEXT(dev->lock.hw_lock->lock) );
-#if __HAVE_RELEASE
-		DRIVER_RELEASE();
-#endif
+
+		if (dev->fn_tbl.release)
+			dev->fn_tbl.release(dev, filp);
+
 		DRM(lock_free)( dev, &dev->lock.hw_lock->lock,
 				_DRM_LOCKING_CONTEXT(dev->lock.hw_lock->lock) );

@@ -860,8 +833,7 @@
                                    processed via a callback to the X
                                    server. */
 	}
-#if __HAVE_RELEASE
-	else if ( priv->lock_count && dev->lock.hw_lock ) {
+	else if ( dev->fn_tbl.release && priv->lock_count && dev->lock.hw_lock ) {
 		/* The lock is required to reclaim buffers */
 		DECLARE_WAITQUEUE( entry, current );

@@ -890,12 +862,14 @@
 		current->state = TASK_RUNNING;
 		remove_wait_queue( &dev->lock.lock_queue, &entry );
 		if( !retcode ) {
-			DRIVER_RELEASE();
+			if (dev->fn_tbl.release)
+				dev->fn_tbl.release(dev, filp);
 			DRM(lock_free)( dev, &dev->lock.hw_lock->lock,
 					DRM_KERNEL_CONTEXT );
 		}
 	}
-#elif __HAVE_DMA
+
+#if __HAVE_DMA
 	DRM(reclaim_buffers)( filp );
 #endif

@@ -1067,74 +1041,59 @@
 	q = dev->queuelist[lock.context];
 #endif

-#if __HAVE_DMA_FLUSH
-	ret = DRM(flush_block_and_flush)( dev, lock.context, lock.flags );
-#endif
-        if ( !ret ) {
-                add_wait_queue( &dev->lock.lock_queue, &entry );
-                for (;;) {
-                        current->state = TASK_INTERRUPTIBLE;
-                        if ( !dev->lock.hw_lock ) {
-                                /* Device has been unregistered */
-                                ret = -EINTR;
-                                break;
-                        }
-                        if ( DRM(lock_take)( &dev->lock.hw_lock->lock,
-					     lock.context ) ) {
-                                dev->lock.filp      = filp;
-                                dev->lock.lock_time = jiffies;
-                                atomic_inc( &dev->counts[_DRM_STAT_LOCKS] );
-                                break;  /* Got lock */
-                        }
-
-                                /* Contention */
-                        schedule();
-                        if ( signal_pending( current ) ) {
-                                ret = -ERESTARTSYS;
-                                break;
-                        }
-                }
-                current->state = TASK_RUNNING;
-                remove_wait_queue( &dev->lock.lock_queue, &entry );
-        }
-
-#if __HAVE_DMA_FLUSH
-	DRM(flush_unblock)( dev, lock.context, lock.flags ); /* cleanup phase */
-#endif
-
-        if ( !ret ) {
-		sigemptyset( &dev->sigmask );
-		sigaddset( &dev->sigmask, SIGSTOP );
-		sigaddset( &dev->sigmask, SIGTSTP );
-		sigaddset( &dev->sigmask, SIGTTIN );
-		sigaddset( &dev->sigmask, SIGTTOU );
-		dev->sigdata.context = lock.context;
-		dev->sigdata.lock    = dev->lock.hw_lock;
-		block_all_signals( DRM(notifier),
-				   &dev->sigdata, &dev->sigmask );
-
-#if __HAVE_DMA_READY
-                if ( lock.flags & _DRM_LOCK_READY ) {
-			DRIVER_DMA_READY();
+	add_wait_queue( &dev->lock.lock_queue, &entry );
+	for (;;) {
+		current->state = TASK_INTERRUPTIBLE;
+		if ( !dev->lock.hw_lock ) {
+			/* Device has been unregistered */
+			ret = -EINTR;
+			break;
 		}
-#endif
-#if __HAVE_DMA_QUIESCENT
-                if ( lock.flags & _DRM_LOCK_QUIESCENT ) {
-			DRIVER_DMA_QUIESCENT();
+		if ( DRM(lock_take)( &dev->lock.hw_lock->lock,
+				     lock.context ) ) {
+			dev->lock.filp      = filp;
+			dev->lock.lock_time = jiffies;
+			atomic_inc( &dev->counts[_DRM_STAT_LOCKS] );
+			break;  /* Got lock */
 		}
-#endif
-		/* __HAVE_KERNEL_CTX_SWITCH isn't used by any of the
-		 * drm modules in the DRI cvs tree, but it is required
-		 * by the Sparc driver.
-		 */
-#if __HAVE_KERNEL_CTX_SWITCH
-		if ( dev->last_context != lock.context ) {
-			DRM(context_switch)(dev, dev->last_context,
-					    lock.context);
+
+		/* Contention */
+		schedule();
+		if ( signal_pending( current ) ) {
+			ret = -ERESTARTSYS;
+			break;
 		}
-#endif
-        }
+	}
+	current->state = TASK_RUNNING;
+	remove_wait_queue( &dev->lock.lock_queue, &entry );

+	sigemptyset( &dev->sigmask );
+	sigaddset( &dev->sigmask, SIGSTOP );
+	sigaddset( &dev->sigmask, SIGTSTP );
+	sigaddset( &dev->sigmask, SIGTTIN );
+	sigaddset( &dev->sigmask, SIGTTOU );
+	dev->sigdata.context = lock.context;
+	dev->sigdata.lock    = dev->lock.hw_lock;
+	block_all_signals( DRM(notifier),
+			   &dev->sigdata, &dev->sigmask );
+
+	if (dev->fn_tbl.dma_ready && (lock.flags & _DRM_LOCK_READY))
+		dev->fn_tbl.dma_ready(dev);
+
+	if ( dev->fn_tbl.dma_quiescent && (lock.flags & _DRM_LOCK_QUIESCENT ))
+		return dev->fn_tbl.dma_quiescent(dev);
+
+	/* __HAVE_KERNEL_CTX_SWITCH isn't used by any of the
+	 * drm modules in the DRI cvs tree, but it is required
+	 * by the Sparc driver.
+	 */
+#if __HAVE_KERNEL_CTX_SWITCH
+	if ( dev->last_context != lock.context ) {
+		DRM(context_switch)(dev, dev->last_context,
+				    lock.context);
+	}
+#endif
+
         DRM_DEBUG( "%d %s\n", lock.context, ret ? "interrupted" : "has lock" );

         return ret;
===== drivers/char/drm/drm_fops.h 1.15 vs edited =====
--- 1.15/drivers/char/drm/drm_fops.h	Sat Jul 17 00:14:58 2004
+++ edited/drivers/char/drm/drm_fops.h	Tue Aug 31 22:06:35 2004
@@ -72,7 +72,8 @@
 	priv->authenticated = capable(CAP_SYS_ADMIN);
 	priv->lock_count    = 0;

-	DRIVER_OPEN_HELPER( priv, dev );
+	if (dev->fn_tbl.open_helper)
+	  dev->fn_tbl.open_helper(dev, priv);

 	down(&dev->struct_sem);
 	if (!dev->file_last) {
===== drivers/char/drm/ffb.h 1.5 vs edited =====
--- 1.5/drivers/char/drm/ffb.h	Thu Apr 22 21:25:27 2004
+++ edited/drivers/char/drm/ffb.h	Tue Aug 31 22:06:35 2004
@@ -11,6 +11,6 @@
 /* General customization:
  */
 #define __HAVE_KERNEL_CTX_SWITCH	1
-#define __HAVE_RELEASE			1
+
 #endif

===== drivers/char/drm/ffb_context.c 1.6 vs edited =====
--- 1.6/drivers/char/drm/ffb_context.c	Tue Jul 27 08:10:53 2004
+++ edited/drivers/char/drm/ffb_context.c	Tue Aug 31 22:06:35 2004
@@ -537,3 +537,43 @@
 	}
 	return 0;
 }
+
+static void ffb_driver_release(drm_device_t *dev)
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
+static int ffb_driver_presetup(drm_device_t *dev)
+{
+	int ret;
+	ret = ffb_presetup(dev);
+	if (_ret != 0) return ret;
+}
+
+static void ffb_driver_pretakedown(drm_device_t *dev)
+{
+	if (dev->dev_private) kfree(dev->dev_private);
+}
+
+static void ffb_driver_postcleanup(drm_device_t *dev)
+{
+	if (ffb_position != NULL) kfree(ffb_position);
+}
+
+static void ffb_driver_register_fns(drm_device_t *dev)
+{
+	dev->fn_tbl.release = ffb_driver_release;
+	dev->fn_tbl.presetup = ffb_driver_presetup;
+	dev->fn_tbl.pretakedown = ffb_driver_pretakedown;
+	dev->fn_tbl.postcleanup = ffb_driver_postcleanup;
+}
===== drivers/char/drm/ffb_drv.c 1.13 vs edited =====
--- 1.13/drivers/char/drm/ffb_drv.c	Tue Jan  6 07:59:27 2004
+++ edited/drivers/char/drm/ffb_drv.c	Tue Aug 31 22:06:35 2004
@@ -41,38 +41,6 @@
 }

 #define DRIVER_COUNT_CARDS()	ffb_count_card_instances()
-/* Allocate private structure and fill it */
-#define DRIVER_PRESETUP()	do {		\
-	int _ret;				\
-	_ret = ffb_presetup(dev);		\
-	if (_ret != 0) return _ret;		\
-} while(0)
-
-/* Free private structure */
-#define DRIVER_PRETAKEDOWN()	do {				\
-	if (dev->dev_private) kfree(dev->dev_private);		\
-} while(0)
-
-#define DRIVER_POSTCLEANUP()	do {				\
-	if (ffb_position != NULL) kfree(ffb_position);		\
-} while(0)
-
-/* We have to free up the rogue hw context state holding error or
- * else we will leak it.
- */
-#define DRIVER_RELEASE()	do {					\
-	ffb_dev_priv_t *fpriv = (ffb_dev_priv_t *) dev->dev_private;	\
-	int context = _DRM_LOCKING_CONTEXT(dev->lock.hw_lock->lock);	\
-	int idx;							\
-									\
-	idx = context - 1;						\
-	if (fpriv &&							\
-	    context != DRM_KERNEL_CONTEXT &&				\
-	    fpriv->hw_state[idx] != NULL) {				\
-		kfree(fpriv->hw_state[idx]);				\
-		fpriv->hw_state[idx] = NULL;				\
-	}								\
-} while(0)

 /* For mmap customization */
 #define DRIVER_GET_MAP_OFS()	(map->offset & 0xffffffff)
===== drivers/char/drm/gamma.h 1.10 vs edited =====
--- 1.10/drivers/char/drm/gamma.h	Thu Apr 22 21:25:27 2004
+++ edited/drivers/char/drm/gamma.h	Tue Aug 31 21:48:59 2004
@@ -86,23 +86,7 @@
 #define __HAVE_DMA_WAITLIST		1
 #define __HAVE_DMA_FREELIST		1

-#define __HAVE_DMA_FLUSH		1
 #define __HAVE_DMA_SCHEDULE		1
-
-#define __HAVE_DMA_READY		1
-#define DRIVER_DMA_READY() do {						\
-	gamma_dma_ready(dev);						\
-} while (0)
-
-#define __HAVE_DMA_QUIESCENT		1
-#define DRIVER_DMA_QUIESCENT() do {					\
-	drm_gamma_private_t *dev_priv =					\
-		(drm_gamma_private_t *)dev->dev_private;		\
-	if (dev_priv->num_rast == 2)					\
-		gamma_dma_quiescent_dual(dev);				\
-	else gamma_dma_quiescent_single(dev);				\
-	return 0;							\
-} while (0)

 #define __HAVE_IRQ			1
 #define __HAVE_IRQ_BH			1
===== drivers/char/drm/gamma_dma.c 1.20 vs edited =====
--- 1.20/drivers/char/drm/gamma_dma.c	Sat Jul 17 00:14:58 2004
+++ edited/drivers/char/drm/gamma_dma.c	Tue Aug 31 22:06:38 2004
@@ -904,3 +904,42 @@
 	GAMMA_WRITE( GAMMA_COMMANDINTENABLE,	0x00000000 );
 	GAMMA_WRITE( GAMMA_GINTENABLE,		0x00000000 );
 }
+
+extern drm_ioctl_desc_t DRM(ioctls)[];
+
+static int gamma_driver_preinit(drm_device_t *dev)
+{
+	/* reset the finish ioctl */
+	DRM(ioctls)[DRM_IOCTL_NR(DRM_IOCTL_FINISH)].func = DRM(finish);
+	return 0;
+}
+
+static void gamma_driver_pretakedown(drm_device_t *dev)
+{
+	gamma_do_cleanup_dma(dev);
+}
+
+static void gamma_driver_dma_ready(drm_device_t *dev)
+{
+	gamma_dma_ready(dev);
+}
+
+static int gamma_driver_dma_quiescent(drm_device_t *dev)
+{
+	drm_gamma_private_t *dev_priv =	(
+		drm_gamma_private_t *)dev->dev_private;
+	if (dev_priv->num_rast == 2)
+		gamma_dma_quiescent_dual(dev);
+	else gamma_dma_quiescent_single(dev);
+	return 0;
+}
+
+void gamma_driver_register_fns(drm_device_t *dev)
+{
+	dev->fn_tbl.preinit = gamma_driver_preinit;
+	dev->fn_tbl.pretakedown = gamma_driver_pretakedown;
+	dev->fn_tbl.dma_ready = gamma_driver_dma_ready;
+	dev->fn_tbl.dma_quiescent = gamma_driver_dma_quiescent;
+	dev->fn_tbl.dma_flush_block_and_flush = gamma_flush_block_and_flush;
+	dev->fn_tbl.dma_flush_unblock = gamma_flush_unblock;
+}
===== drivers/char/drm/i810.h 1.13 vs edited =====
--- 1.13/drivers/char/drm/i810.h	Thu Apr 22 21:25:27 2004
+++ edited/drivers/char/drm/i810.h	Tue Aug 31 22:10:39 2004
@@ -84,28 +84,12 @@
 #define __HAVE_COUNTER8         _DRM_STAT_SECONDARY
 #define __HAVE_COUNTER9         _DRM_STAT_DMA

-/* Driver customization:
- */
-#define __HAVE_RELEASE		1
-#define DRIVER_RELEASE() do {						\
-	i810_reclaim_buffers( filp );					\
-} while (0)
-
-#define DRIVER_PRETAKEDOWN() do {					\
-	i810_dma_cleanup( dev );					\
-} while (0)
-
 /* DMA customization:
  */
 #define __HAVE_DMA		1
 #define __HAVE_DMA_QUEUE	1
 #define __HAVE_DMA_WAITLIST	0
 #define __HAVE_DMA_RECLAIM	1
-
-#define __HAVE_DMA_QUIESCENT	1
-#define DRIVER_DMA_QUIESCENT() do {					\
-	i810_dma_quiescent( dev );					\
-} while (0)

 /* Don't need an irq any more.  The template code will make sure that
  * a noop stub is generated for compatibility.
===== drivers/char/drm/i810_dma.c 1.36 vs edited =====
--- 1.36/drivers/char/drm/i810_dma.c	Sat Aug 28 04:26:15 2004
+++ edited/drivers/char/drm/i810_dma.c	Tue Aug 31 22:06:47 2004
@@ -1388,3 +1388,27 @@
 	i810_dma_dispatch_flip( dev );
    	return 0;
 }
+
+static void i810_driver_pretakedown(drm_device_t *dev)
+{
+	i810_dma_cleanup( dev );
+}
+
+static void i810_driver_release(drm_device_t *dev, struct file *filp)
+{
+	i810_reclaim_buffers(filp);
+}
+
+static int i810_driver_dma_quiescent(drm_device_t *dev)
+{
+	i810_dma_quiescent( dev );
+	return 0;
+}
+
+void i810_driver_register_fns(drm_device_t *dev)
+{
+	dev->fn_tbl.pretakedown = i810_driver_pretakedown;
+	dev->fn_tbl.release = i810_driver_release;
+	dev->fn_tbl.dma_quiescent = i810_driver_dma_quiescent;
+}
+
===== drivers/char/drm/i830.h 1.11 vs edited =====
--- 1.11/drivers/char/drm/i830.h	Thu Apr 22 21:25:27 2004
+++ edited/drivers/char/drm/i830.h	Tue Aug 31 22:06:47 2004
@@ -83,29 +83,12 @@
 #define __HAVE_COUNTER8         _DRM_STAT_SECONDARY
 #define __HAVE_COUNTER9         _DRM_STAT_DMA

-/* Driver customization:
- */
-#define __HAVE_RELEASE		1
-#define DRIVER_RELEASE() do {						\
-	i830_reclaim_buffers( filp );					\
-} while (0)
-
-#define DRIVER_PRETAKEDOWN() do {					\
-	i830_dma_cleanup( dev );					\
-} while (0)
-
 /* DMA customization:
  */
 #define __HAVE_DMA		1
 #define __HAVE_DMA_QUEUE	1
 #define __HAVE_DMA_WAITLIST	0
 #define __HAVE_DMA_RECLAIM	1
-
-#define __HAVE_DMA_QUIESCENT	1
-#define DRIVER_DMA_QUIESCENT() do {					\
-	i830_dma_quiescent( dev );					\
-} while (0)
-

 /* Driver will work either way: IRQ's save cpu time when waiting for
  * the card, but are subject to subtle interactions between bios,
===== drivers/char/drm/i830_dma.c 1.26 vs edited =====
--- 1.26/drivers/char/drm/i830_dma.c	Sat Aug 28 04:26:17 2004
+++ edited/drivers/char/drm/i830_dma.c	Tue Aug 31 22:06:47 2004
@@ -1582,3 +1582,28 @@

 	return 0;
 }
+
+
+static void i830_driver_pretakedown(drm_device_t *dev)
+{
+	i830_dma_cleanup( dev );
+}
+
+static void i830_driver_release(drm_device_t *dev, struct file *filp)
+{
+	i830_reclaim_buffers(filp);
+}
+
+static int i830_driver_dma_quiescent(drm_device_t *dev)
+{
+	i830_dma_quiescent( dev );
+	return 0;
+}
+
+void i830_driver_register_fns(drm_device_t *dev)
+{
+	dev->fn_tbl.pretakedown = i830_driver_pretakedown;
+	dev->fn_tbl.release = i830_driver_release;
+	dev->fn_tbl.dma_quiescent = i830_driver_dma_quiescent;
+}
+
===== drivers/char/drm/i915.h 1.1 vs edited =====
--- 1.1/drivers/char/drm/i915.h	Fri Aug 27 19:33:29 2004
+++ edited/drivers/char/drm/i915.h	Tue Aug 31 22:11:15 2004
@@ -55,27 +55,6 @@
 #define __HAVE_COUNTER8         _DRM_STAT_SECONDARY
 #define __HAVE_COUNTER9         _DRM_STAT_DMA

-/* Driver customization:
- */
-#define DRIVER_PRETAKEDOWN() do {					\
-	if ( dev->dev_private ) {					\
-		drm_i915_private_t *dev_priv = dev->dev_private;	\
-	        i915_mem_takedown( &(dev_priv->agp_heap) );             \
- 	}								\
-	i915_dma_cleanup( dev );					\
-} while (0)
-
-/* When a client dies:
- *    - Free any alloced agp memory.
- */
-#define DRIVER_PRERELEASE() 						\
-do {									\
-	if ( dev->dev_private ) {					\
-		drm_i915_private_t *dev_priv = dev->dev_private;	\
-                i915_mem_release( dev, filp, dev_priv->agp_heap );	\
-	}								\
-} while (0)
-
 /* We use our own dma mechanisms, not the drm template code.  However,
  * the shared IRQ code is useful to us:
  */
===== drivers/char/drm/i915_dma.c 1.2 vs edited =====
--- 1.2/drivers/char/drm/i915_dma.c	Sat Aug 28 10:05:27 2004
+++ edited/drivers/char/drm/i915_dma.c	Tue Aug 31 22:06:55 2004
@@ -712,3 +712,26 @@

 	return 0;
 }
+
+static void i915_driver_pretakedown(drm_device_t *dev)
+{
+	if ( dev->dev_private ) {
+		drm_i915_private_t *dev_priv = dev->dev_private;
+	        i915_mem_takedown( &(dev_priv->agp_heap) );
+ 	}
+	i915_dma_cleanup( dev );
+}
+
+static void i915_driver_prerelease(drm_device_t *dev, DRMFILE filp)
+{
+	if ( dev->dev_private ) {
+		drm_i915_private_t *dev_priv = dev->dev_private;
+                i915_mem_release( dev, filp, dev_priv->agp_heap );
+	}
+}
+
+void i915_driver_register_fns(drm_device_t *dev)
+{
+	dev->fn_tbl.pretakedown = i915_driver_pretakedown;
+	dev->fn_tbl.prerelease = i915_driver_prerelease;
+}
===== drivers/char/drm/mga.h 1.10 vs edited =====
--- 1.10/drivers/char/drm/mga.h	Thu Apr 22 21:25:27 2004
+++ edited/drivers/char/drm/mga.h	Tue Aug 31 22:11:39 2004
@@ -69,24 +69,12 @@
 #define __HAVE_COUNTER7         _DRM_STAT_PRIMARY
 #define __HAVE_COUNTER8         _DRM_STAT_SECONDARY

-/* Driver customization:
- */
-#define DRIVER_PRETAKEDOWN() do {					\
-	mga_do_cleanup_dma( dev );					\
-} while (0)
-
 /* DMA customization:
  */
 #define __HAVE_DMA		1
 #define __HAVE_IRQ		1
 #define __HAVE_VBL_IRQ		1
 #define __HAVE_SHARED_IRQ       1
-
-#define __HAVE_DMA_QUIESCENT	1
-#define DRIVER_DMA_QUIESCENT() do {					\
-	drm_mga_private_t *dev_priv = dev->dev_private;			\
-	return mga_do_wait_for_idle( dev_priv );			\
-} while (0)

 /* Buffer customization:
  */
===== drivers/char/drm/mga_dma.c 1.18 vs edited =====
--- 1.18/drivers/char/drm/mga_dma.c	Sat Jul 17 00:14:58 2004
+++ edited/drivers/char/drm/mga_dma.c	Tue Aug 31 22:06:58 2004
@@ -800,3 +800,20 @@

 	return ret;
 }
+
+static void mga_driver_pretakedown(drm_device_t *dev)
+{
+	mga_do_cleanup_dma( dev );
+}
+
+static int mga_driver_dma_quiescent(drm_device_t *dev)
+{
+	drm_mga_private_t *dev_priv = dev->dev_private;
+	return mga_do_wait_for_idle( dev_priv );
+}
+
+void mga_driver_register_fns(drm_device_t *dev)
+{
+	dev->fn_tbl.pretakedown = mga_driver_pretakedown;
+	dev->fn_tbl.dma_quiescent = mga_driver_dma_quiescent;
+}
===== drivers/char/drm/r128.h 1.14 vs edited =====
--- 1.14/drivers/char/drm/r128.h	Thu Apr 22 21:25:27 2004
+++ edited/drivers/char/drm/r128.h	Tue Aug 31 22:11:55 2004
@@ -79,36 +79,12 @@
    [DRM_IOCTL_NR(DRM_IOCTL_R128_INDIRECT)]   = { r128_cce_indirect, 1, 1 }, \
    [DRM_IOCTL_NR(DRM_IOCTL_R128_GETPARAM)]   = { r128_getparam, 1, 0 },

-/* Driver customization:
- */
-#define DRIVER_PRERELEASE() do {					\
-	if ( dev->dev_private ) {					\
-		drm_r128_private_t *dev_priv = dev->dev_private;	\
-		if ( dev_priv->page_flipping ) {			\
-			r128_do_cleanup_pageflip( dev );		\
-		}							\
-	}								\
-} while (0)
-
-#define DRIVER_PRETAKEDOWN() do {					\
-	r128_do_cleanup_cce( dev );					\
-} while (0)
-
 /* DMA customization:
  */
 #define __HAVE_DMA		1
 #define __HAVE_IRQ		1
 #define __HAVE_VBL_IRQ		1
 #define __HAVE_SHARED_IRQ       1
-
-#if 0
-/* GH: Remove this for now... */
-#define __HAVE_DMA_QUIESCENT	1
-#define DRIVER_DMA_QUIESCENT() do {					\
-	drm_r128_private_t *dev_priv = dev->dev_private;		\
-	return r128_do_cce_idle( dev_priv );				\
-} while (0)
-#endif

 /* Buffer customization:
  */
===== drivers/char/drm/r128_state.c 1.17 vs edited =====
--- 1.17/drivers/char/drm/r128_state.c	Sat Jul 17 00:14:58 2004
+++ edited/drivers/char/drm/r128_state.c	Tue Aug 31 22:06:58 2004
@@ -1694,3 +1694,24 @@

 	return 0;
 }
+
+static void r128_driver_prerelease(drm_device_t *dev, DRMFILE filp)
+{
+	if ( dev->dev_private ) {
+		drm_r128_private_t *dev_priv = dev->dev_private;
+		if ( dev_priv->page_flipping ) {
+			r128_do_cleanup_pageflip( dev );
+		}
+	}
+}
+
+static void r128_driver_pretakedown(drm_device_t *dev)
+{
+	r128_do_cleanup_cce( dev );
+}
+
+void r128_driver_register_fns(drm_device_t *dev)
+{
+	dev->fn_tbl.prerelease = r128_driver_prerelease;
+	dev->fn_tbl.pretakedown = r128_driver_pretakedown;
+}
===== drivers/char/drm/radeon.h 1.21 vs edited =====
--- 1.21/drivers/char/drm/radeon.h	Mon Jul  5 22:09:31 2004
+++ edited/drivers/char/drm/radeon.h	Tue Aug 31 22:41:33 2004
@@ -118,43 +118,6 @@
 #define DRIVER_FILE_FIELDS						\
 	int64_t radeon_fb_delta;					\

-#define DRIVER_OPEN_HELPER( filp_priv, dev )				\
-do {									\
-	drm_radeon_private_t *dev_priv = dev->dev_private;		\
-	if ( dev_priv )							\
-		filp_priv->radeon_fb_delta = dev_priv->fb_location;	\
-	else								\
-		filp_priv->radeon_fb_delta = 0;				\
-} while( 0 )
-
-/* When a client dies:
- *    - Check for and clean up flipped page state
- *    - Free any alloced GART memory.
- *
- * DRM infrastructure takes care of reclaiming dma buffers.
- */
-#define DRIVER_PRERELEASE() 						\
-do {									\
-	if ( dev->dev_private ) {					\
-		drm_radeon_private_t *dev_priv = dev->dev_private;	\
-		if ( dev_priv->page_flipping ) {			\
-			radeon_do_cleanup_pageflip( dev );		\
-		}							\
-		radeon_mem_release( filp, dev_priv->gart_heap );	\
-		radeon_mem_release( filp, dev_priv->fb_heap );		\
-	}								\
-} while (0)
-
-/* When the last client dies, shut down the CP and free dev->dev_priv.
- */
-/* #define __HAVE_RELEASE 1 */
-#define DRIVER_PRETAKEDOWN()			\
-do {						\
-    radeon_do_release( dev );			\
-} while (0)
-
-
-
 /* DMA customization:
  */
 #define __HAVE_DMA		1
===== drivers/char/drm/radeon_state.c 1.29 vs edited =====
--- 1.29/drivers/char/drm/radeon_state.c	Sat Jul 17 00:14:58 2004
+++ edited/drivers/char/drm/radeon_state.c	Tue Aug 31 22:42:56 2004
@@ -2547,3 +2547,36 @@

 	return 0;
 }
+
+static void radeon_driver_prerelease(drm_device_t *dev, DRMFILE filp)
+{
+	if ( dev->dev_private ) {
+		drm_radeon_private_t *dev_priv = dev->dev_private;
+		if ( dev_priv->page_flipping ) {
+			radeon_do_cleanup_pageflip( dev );
+		}
+		radeon_mem_release( filp, dev_priv->gart_heap );
+		radeon_mem_release( filp, dev_priv->fb_heap );
+	}
+}
+
+static void radeon_driver_pretakedown(drm_device_t *dev)
+{
+	radeon_do_release(dev);
+}
+
+static void radeon_driver_open_helper(drm_device_t *dev, drm_file_t *filp_priv)
+{
+	drm_radeon_private_t *dev_priv = dev->dev_private;
+	if ( dev_priv )
+		filp_priv->radeon_fb_delta = dev_priv->fb_location;
+	else
+		filp_priv->radeon_fb_delta = 0;
+}
+
+void radeon_driver_register_fns(struct drm_device *dev)
+{
+	dev->fn_tbl.prerelease = radeon_driver_prerelease;
+	dev->fn_tbl.pretakedown = radeon_driver_pretakedown;
+	dev->fn_tbl.open_helper = radeon_driver_open_helper;
+}
===== drivers/char/drm/sis_drv.c 1.5 vs edited =====
--- 1.5/drivers/char/drm/sis_drv.c	Sat Apr 26 08:57:58 2003
+++ edited/drivers/char/drm/sis_drv.c	Tue Aug 31 22:14:30 2004
@@ -46,3 +46,4 @@
 #include "drm_proc.h"
 #include "drm_vm.h"
 #include "drm_stub.h"
+
===== drivers/char/drm/sis_mm.c 1.11 vs edited =====
--- 1.11/drivers/char/drm/sis_mm.c	Sat Aug 28 10:05:27 2004
+++ edited/drivers/char/drm/sis_mm.c	Tue Aug 31 22:14:31 2004
@@ -404,3 +404,7 @@

 	return 1;
 }
+
+void DRM(driver_register_fns)(drm_device_t *dev)
+{
+}
===== drivers/char/drm/tdfx_drv.c 1.7 vs edited =====
--- 1.7/drivers/char/drm/tdfx_drv.c	Fri Apr  9 17:28:35 2004
+++ edited/drivers/char/drm/tdfx_drv.c	Tue Aug 31 22:06:51 2004
@@ -49,3 +49,8 @@
 #include "drm_proc.h"
 #include "drm_vm.h"
 #include "drm_stub.h"
+
+void DRM(driver_register_fns)(drm_device_t *dev)
+{
+}
+
