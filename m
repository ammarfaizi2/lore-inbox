Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268290AbUIBMw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268290AbUIBMw0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 08:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268297AbUIBMw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 08:52:26 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:27873 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S268290AbUIBMvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 08:51:01 -0400
Date: Thu, 2 Sep 2004 13:50:39 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] DRM 2nd macro removal..
Message-ID: <Pine.LNX.4.58.0409021339030.31788@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Again this is for review for any obvious issues, it applies on top of the
previous function table addition patch, it gets rid of another group of
macros DRIVER_CTX_[CD]TOR, HAVE_KERNEL_CTX_SWITCH, DRIVER_BUF_PRIV_T,
DRIVER_AGP_BUFFERS_MAP

Again this is just pulled from DRM CVS (plus a fix for a mistake I spotted
on the way past ..).. I'll submit the patches as I build them to the LK
list and if no-one has any issues I'll build a bk tree for submission to
Linus with all the patches together... I have four smaller ones I'll send
on next time I get a chance...

The patches will also be at http://www.skynet.ie/~airlied/patches/lk_drm/

Dave.

===== drivers/char/drm/drmP.h 1.41 vs edited =====
--- 1.41/drivers/char/drm/drmP.h	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/drmP.h	Thu Sep  2 22:32:41 2004
@@ -627,6 +627,10 @@
 	void (*release)(struct drm_device *, struct file *filp);
 	void (*dma_ready)(struct drm_device *);
 	int (*dma_quiescent)(struct drm_device *);
+	int (*context_ctor)(struct drm_device *dev, int context);
+ 	int (*context_dtor)(struct drm_device *dev, int context);
+ 	int (*kernel_context_switch)(struct drm_device *dev, int old, int new);
+ 	int (*kernel_context_switch_unlock)(struct drm_device *dev);
 };
 /**
  * DRM device structure.
@@ -758,7 +762,8 @@
 	sigset_t          sigmask;

 	struct            drm_driver_fn fn_tbl;
-
+	drm_local_map_t   *agp_buffer_map;
+	int               dev_priv_size;
 } drm_device_t;

 extern void DRM(driver_register_fns)(struct drm_device *dev);
===== drivers/char/drm/drm_bufs.h 1.22 vs edited =====
--- 1.22/drivers/char/drm/drm_bufs.h	Sat Aug 28 10:02:28 2004
+++ edited/drivers/char/drm/drm_bufs.h	Thu Sep  2 22:10:57 2004
@@ -44,18 +44,6 @@
 #define __HAVE_SG		0
 #endif

-#ifndef DRIVER_BUF_PRIV_T
-#define DRIVER_BUF_PRIV_T		u32
-#endif
-#ifndef DRIVER_AGP_BUFFERS_MAP
-#if __HAVE_AGP && __HAVE_DMA
-#error "You must define DRIVER_AGP_BUFFERS_MAP()"
-#else
-#define DRIVER_AGP_BUFFERS_MAP( dev )	NULL
-#endif
-#endif
5~-
-
 /**
  * Compute size order.  Returns the exponent of the smaller power of two which
  * is greater or equal to given number.
@@ -473,8 +461,8 @@
 		init_waitqueue_head( &buf->dma_wait );
 		buf->filp    = NULL;

-		buf->dev_priv_size = sizeof(DRIVER_BUF_PRIV_T);
-		buf->dev_private = DRM(alloc)( sizeof(DRIVER_BUF_PRIV_T),
+		buf->dev_priv_size = dev->dev_priv_size;
+		buf->dev_private = DRM(alloc)( buf->dev_priv_size,
 					       DRM_MEM_BUFS );
 		if(!buf->dev_private) {
 			/* Set count correctly so we free the proper amount. */
@@ -698,8 +686,8 @@
 			init_waitqueue_head( &buf->dma_wait );
 			buf->filp    = NULL;

-			buf->dev_priv_size = sizeof(DRIVER_BUF_PRIV_T);
-			buf->dev_private = DRM(alloc)( sizeof(DRIVER_BUF_PRIV_T),
+			buf->dev_priv_size = dev->dev_priv_size;
+			buf->dev_private = DRM(alloc)( dev->dev_priv_size,
 						       DRM_MEM_BUFS );
 			if(!buf->dev_private) {
 				/* Set count correctly so we free the proper amount. */
@@ -882,8 +870,8 @@
 		init_waitqueue_head( &buf->dma_wait );
 		buf->filp    = NULL;

-		buf->dev_priv_size = sizeof(DRIVER_BUF_PRIV_T);
-		buf->dev_private = DRM(alloc)( sizeof(DRIVER_BUF_PRIV_T),
+		buf->dev_priv_size = dev->dev_priv_size;
+		buf->dev_private = DRM(alloc)( dev->dev_priv_size,
 					       DRM_MEM_BUFS );
 		if(!buf->dev_private) {
 			/* Set count correctly so we free the proper amount. */
@@ -1221,7 +1209,7 @@
 	if ( request.count >= dma->buf_count ) {
 		if ( (__HAVE_AGP && (dma->flags & _DRM_DMA_USE_AGP)) ||
 		     (__HAVE_SG && (dma->flags & _DRM_DMA_USE_SG)) ) {
-			drm_map_t *map = DRIVER_AGP_BUFFERS_MAP( dev );
+			drm_map_t *map = dev->agp_buffer_map;

 			if ( !map ) {
 				retcode = -EINVAL;
===== drivers/char/drm/drm_context.h 1.15 vs edited =====
--- 1.15/drivers/char/drm/drm_context.h	Sat Jul 17 00:14:58 2004
+++ edited/drivers/char/drm/drm_context.h	Thu Sep  2 22:32:27 2004
@@ -419,10 +419,13 @@
 				/* Should this return -EBUSY instead? */
 		return -ENOMEM;
 	}
-#ifdef DRIVER_CTX_CTOR
+
 	if ( ctx.handle != DRM_KERNEL_CONTEXT )
-		DRIVER_CTX_CTOR(ctx.handle); /* XXX: also pass dev ? */
-#endif
+	{
+		if (dev->fn_tbl.context_ctor)
+			dev->fn_tbl.context_ctor(dev, ctx.handle);
+	}
+
 	ctx_entry = DRM(alloc)( sizeof(*ctx_entry), DRM_MEM_CTXLIST );
 	if ( !ctx_entry ) {
 		DRM_DEBUG("out of memory\n");
@@ -554,9 +557,8 @@
 		priv->remove_auth_on_close = 1;
 	}
 	if ( ctx.handle != DRM_KERNEL_CONTEXT ) {
-#ifdef DRIVER_CTX_DTOR
-		DRIVER_CTX_DTOR(ctx.handle); /* XXX: also pass dev ? */
-#endif
+		if (dev->fn_tbl.context_dtor)
+			dev->fn_tbl.context_dtor(dev, ctx.handle);
 		DRM(ctxbitmap_free)( dev, ctx.handle );
 	}

===== drivers/char/drm/drm_drv.h 1.37 vs edited =====
--- 1.37/drivers/char/drm/drm_drv.h	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/drm_drv.h	Thu Sep  2 22:23:46 2004
@@ -76,13 +76,6 @@
 #ifndef __HAVE_SG
 #define __HAVE_SG			0
 #endif
-/* __HAVE_KERNEL_CTX_SWITCH isn't used by any of the drm modules in
- * the DRI cvs tree, but it is required by the kernel tree's sparc
- * driver.
- */
-#ifndef __HAVE_KERNEL_CTX_SWITCH
-#define __HAVE_KERNEL_CTX_SWITCH	0
-#endif
 #ifndef __HAVE_DRIVER_FOPS_READ
 #define __HAVE_DRIVER_FOPS_READ		0
 #endif
@@ -272,9 +265,6 @@
 #ifdef __HAVE_COUNTER14
 	dev->types[14] = __HAVE_COUNTER14;
 #endif
-#ifdef __HAVE_COUNTER15
-	dev->types[14] = __HAVE_COUNTER14;
-#endif

 	for ( i = 0 ; i < DRM_ARRAY_SIZE(dev->counts) ; i++ )
 		atomic_set( &dev->counts[i], 0 );
@@ -559,6 +549,8 @@
 	dev->pci_func = PCI_FUNC(pdev->devfn);
 	dev->irq = pdev->irq;

+	/* dev_priv_size can be changed by a driver in driver_register_fns */
+ 	dev->dev_priv_size = sizeof(u32);
 	DRM(driver_register_fns)(dev);

 	if (dev->fn_tbl.preinit)
@@ -882,9 +874,8 @@
 		list_for_each_entry_safe( pos, n, &dev->ctxlist->head, head ) {
 			if ( pos->tag == priv &&
 			     pos->handle != DRM_KERNEL_CONTEXT ) {
-#ifdef DRIVER_CTX_DTOR
-				DRIVER_CTX_DTOR(pos->handle);
-#endif
+				if (dev->fn_tbl.context_dtor)
+					dev->fn_tbl.context_dtor(dev, pos->handle);
 #if __HAVE_CTX_BITMAP
 				DRM(ctxbitmap_free)( dev, pos->handle );
 #endif
@@ -1083,17 +1074,15 @@
 	if ( dev->fn_tbl.dma_quiescent && (lock.flags & _DRM_LOCK_QUIESCENT ))
 		return dev->fn_tbl.dma_quiescent(dev);

-	/* __HAVE_KERNEL_CTX_SWITCH isn't used by any of the
-	 * drm modules in the DRI cvs tree, but it is required
-	 * by the Sparc driver.
+	/* dev->fn_tbl.kernel_context_switch isn't used by any of the x86
+	 *  drivers but is used by the Sparc driver.
 	 */
-#if __HAVE_KERNEL_CTX_SWITCH
-	if ( dev->last_context != lock.context ) {
-		DRM(context_switch)(dev, dev->last_context,
-				    lock.context);
-	}
-#endif

+	if (dev->fn_tbl.kernel_context_switch &&
+	    dev->last_context != lock.context) {
+	  dev->fn_tbl.kernel_context_switch(dev, dev->last_context,
+					    lock.context);
+	}
         DRM_DEBUG( "%d %s\n", lock.context, ret ? "interrupted" : "has lock" );

         return ret;
@@ -1128,40 +1117,24 @@

 	atomic_inc( &dev->counts[_DRM_STAT_UNLOCKS] );

-	/* __HAVE_KERNEL_CTX_SWITCH isn't used by any of the drm
-	 * modules in the DRI cvs tree, but it is required by the
-	 * Sparc driver.
-	 */
-#if __HAVE_KERNEL_CTX_SWITCH
-	/* We no longer really hold it, but if we are the next
-	 * agent to request it then we should just be able to
-	 * take it immediately and not eat the ioctl.
+	/* kernel_context_switch isn't used by any of the x86 drm
+	 * modules but is required by the Sparc driver.
 	 */
-	dev->lock.filp = NULL;
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
-#else
-	DRM(lock_transfer)( dev, &dev->lock.hw_lock->lock,
-			    DRM_KERNEL_CONTEXT );
+	if (dev->fn_tbl.kernel_context_switch_unlock)
+		dev->fn_tbl.kernel_context_switch_unlock(dev);
+	else {
+		DRM(lock_transfer)( dev, &dev->lock.hw_lock->lock,
+				    DRM_KERNEL_CONTEXT );
+
 #if __HAVE_DMA_SCHEDULE
-	DRM(dma_schedule)( dev, 1 );
+		DRM(dma_schedule)( dev, 1 );
 #endif

-	if ( DRM(lock_free)( dev, &dev->lock.hw_lock->lock,
-			     DRM_KERNEL_CONTEXT ) ) {
-		DRM_ERROR( "\n" );
+		if ( DRM(lock_free)( dev, &dev->lock.hw_lock->lock,
+				     DRM_KERNEL_CONTEXT ) ) {
+			DRM_ERROR( "\n" );
+		}
 	}
-#endif /* !__HAVE_KERNEL_CTX_SWITCH */

 	unblock_all_signals();
 	return 0;
===== drivers/char/drm/ffb.h 1.6 vs edited =====
--- 1.6/drivers/char/drm/ffb.h	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/ffb.h	Thu Sep  2 22:10:57 2004
@@ -8,9 +8,5 @@
  */
 #define DRM(x) ffb_##x

-/* General customization:
- */
-#define __HAVE_KERNEL_CTX_SWITCH	1
-
 #endif

===== drivers/char/drm/ffb_context.c 1.7 vs edited =====
--- 1.7/drivers/char/drm/ffb_context.c	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/ffb_context.c	Thu Sep  2 22:10:57 2004
@@ -570,10 +570,29 @@
 	if (ffb_position != NULL) kfree(ffb_position);
 }

+static int ffb_driver_kernel_context_switch_unlock(struct drm_device *dev)
+{
+	dev->lock.filp = 0;
+	{
+		__volatile__ unsigned int *plock = &dev->lock.hw_lock->lock;
+		unsigned int old, new, prev, ctx;
+
+		ctx = lock.context;
+		do {
+			old  = *plock;
+			new  = ctx;
+			prev = cmpxchg(plock, old, new);
+		} while (prev != old);
+	}
+	wake_up_interruptible(&dev->lock.lock_queue);
+}
+
 static void ffb_driver_register_fns(drm_device_t *dev)
 {
 	dev->fn_tbl.release = ffb_driver_release;
 	dev->fn_tbl.presetup = ffb_driver_presetup;
 	dev->fn_tbl.pretakedown = ffb_driver_pretakedown;
 	dev->fn_tbl.postcleanup = ffb_driver_postcleanup;
+	dev->fn_tbl.kernel_context_switch = ffb_context_switch;
+	dev->fn_tbl.kernel_context_switch_unlock = ffb_driver_kernel_context_switch_unlock;
 }
===== drivers/char/drm/gamma.h 1.11 vs edited =====
--- 1.11/drivers/char/drm/gamma.h	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/gamma.h	Thu Sep  2 22:10:57 2004
@@ -91,8 +91,4 @@
 #define __HAVE_IRQ			1
 #define __HAVE_IRQ_BH			1

-#define DRIVER_AGP_BUFFERS_MAP( dev )					\
-	((drm_gamma_private_t *)((dev)->dev_private))->buffers
-
-
 #endif /* __GAMMA_H__ */
===== drivers/char/drm/gamma_dma.c 1.21 vs edited =====
--- 1.21/drivers/char/drm/gamma_dma.c	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/gamma_dma.c	Thu Sep  2 22:10:57 2004
@@ -661,9 +661,9 @@

 		buf = dma->buflist[GLINT_DRI_BUF_COUNT];
 	} else {
-		DRM_FIND_MAP( dev_priv->buffers, init->buffers_offset );
+		DRM_FIND_MAP( dev->agp_buffer_map, init->buffers_offset );

-		DRM_IOREMAP( dev_priv->buffers, dev );
+		DRM_IOREMAP( dev->agp_buffer_map, dev );

 		buf = dma->buflist[GLINT_DRI_BUF_COUNT];
 		pgt = buf->address;
@@ -699,10 +699,9 @@
 #endif

 	if ( dev->dev_private ) {
-		drm_gamma_private_t *dev_priv = dev->dev_private;

-		if ( dev_priv->buffers != NULL )
-			DRM_IOREMAPFREE( dev_priv->buffers, dev );
+		if ( dev->agp_buffer_map != NULL )
+			DRM_IOREMAPFREE( dev->agp_buffer_map, dev );

 		DRM(free)( dev->dev_private, sizeof(drm_gamma_private_t),
 			   DRM_MEM_DRIVER );
===== drivers/char/drm/gamma_drv.h 1.8 vs edited =====
--- 1.8/drivers/char/drm/gamma_drv.h	Tue Apr 29 12:54:54 2003
+++ edited/drivers/char/drm/gamma_drv.h	Thu Sep  2 22:10:57 2004
@@ -35,7 +35,6 @@
 typedef struct drm_gamma_private {
 	drm_gamma_sarea_t *sarea_priv;
 	drm_map_t *sarea;
-	drm_map_t *buffers;
 	drm_map_t *mmio0;
 	drm_map_t *mmio1;
 	drm_map_t *mmio2;
===== drivers/char/drm/i810.h 1.14 vs edited =====
--- 1.14/drivers/char/drm/i810.h	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/i810.h	Thu Sep  2 22:10:57 2004
@@ -97,12 +97,4 @@
 /* XXX: Add vblank support? */
 #define __HAVE_IRQ		0

-/* Buffer customization:
- */
-
-#define DRIVER_BUF_PRIV_T	drm_i810_buf_priv_t
-
-#define DRIVER_AGP_BUFFERS_MAP( dev )					\
-	((drm_i810_private_t *)((dev)->dev_private))->buffer_map
-
 #endif
===== drivers/char/drm/i810_dma.c 1.37 vs edited =====
--- 1.37/drivers/char/drm/i810_dma.c	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/i810_dma.c	Thu Sep  2 22:10:57 2004
@@ -371,8 +371,8 @@
 	   	DRM_ERROR("can not find mmio map!\n");
 	   	return -EINVAL;
 	}
-	DRM_FIND_MAP( dev_priv->buffer_map, init->buffers_offset );
-	if (!dev_priv->buffer_map) {
+	DRM_FIND_MAP( dev->agp_buffer_map, init->buffers_offset );
+	if (!dev->agp_buffer_map) {
 		dev->dev_private = (void *)dev_priv;
 	   	i810_dma_cleanup(dev);
 	   	DRM_ERROR("can not find dma buffer map!\n");
@@ -1407,6 +1407,7 @@

 void i810_driver_register_fns(drm_device_t *dev)
 {
+	dev->dev_priv_size = sizeof(drm_i810_buf_priv_t);
 	dev->fn_tbl.pretakedown = i810_driver_pretakedown;
 	dev->fn_tbl.release = i810_driver_release;
 	dev->fn_tbl.dma_quiescent = i810_driver_dma_quiescent;
===== drivers/char/drm/i810_drv.h 1.11 vs edited =====
--- 1.11/drivers/char/drm/i810_drv.h	Fri Jul 11 16:26:02 2003
+++ edited/drivers/char/drm/i810_drv.h	Thu Sep  2 22:10:57 2004
@@ -53,7 +53,6 @@

 typedef struct drm_i810_private {
 	drm_map_t *sarea_map;
-	drm_map_t *buffer_map;
 	drm_map_t *mmio_map;

 	drm_i810_sarea_t *sarea_priv;
===== drivers/char/drm/i830.h 1.12 vs edited =====
--- 1.12/drivers/char/drm/i830.h	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/i830.h	Thu Sep  2 22:10:57 2004
@@ -104,13 +104,4 @@
 #define __HAVE_IRQ          0
 #endif

-
-/* Buffer customization:
- */
-
-#define DRIVER_BUF_PRIV_T	drm_i830_buf_priv_t
-
-#define DRIVER_AGP_BUFFERS_MAP( dev )					\
-	((drm_i830_private_t *)((dev)->dev_private))->buffer_map
-
 #endif
===== drivers/char/drm/i830_dma.c 1.27 vs edited =====
--- 1.27/drivers/char/drm/i830_dma.c	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/i830_dma.c	Thu Sep  2 22:10:57 2004
@@ -378,8 +378,8 @@
 		DRM_ERROR("can not find mmio map!\n");
 		return -EINVAL;
 	}
-	DRM_FIND_MAP( dev_priv->buffer_map, init->buffers_offset );
-	if(!dev_priv->buffer_map) {
+	DRM_FIND_MAP( dev->agp_buffer_map, init->buffers_offset );
+	if(!dev->agp_buffer_map) {
 		dev->dev_private = (void *)dev_priv;
 		i830_dma_cleanup(dev);
 		DRM_ERROR("can not find dma buffer map!\n");
@@ -1602,6 +1602,7 @@

 void i830_driver_register_fns(drm_device_t *dev)
 {
+	dev->dev_priv_size = sizeof(drm_i830_buf_priv_t);
 	dev->fn_tbl.pretakedown = i830_driver_pretakedown;
 	dev->fn_tbl.release = i830_driver_release;
 	dev->fn_tbl.dma_quiescent = i830_driver_dma_quiescent;
===== drivers/char/drm/i830_drv.h 1.10 vs edited =====
--- 1.10/drivers/char/drm/i830_drv.h	Tue Apr 13 03:54:26 2004
+++ edited/drivers/char/drm/i830_drv.h	Thu Sep  2 22:10:57 2004
@@ -53,7 +53,6 @@

 typedef struct drm_i830_private {
 	drm_map_t *sarea_map;
-	drm_map_t *buffer_map;
 	drm_map_t *mmio_map;

 	drm_i830_sarea_t *sarea_priv;
===== drivers/char/drm/mga.h 1.11 vs edited =====
--- 1.11/drivers/char/drm/mga.h	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/mga.h	Thu Sep  2 22:11:41 2004
@@ -76,11 +76,4 @@
 #define __HAVE_VBL_IRQ		1
 #define __HAVE_SHARED_IRQ       1

-/* Buffer customization:
- */
-#define DRIVER_BUF_PRIV_T	drm_mga_buf_priv_t
-
-#define DRIVER_AGP_BUFFERS_MAP( dev )					\
-	((drm_mga_private_t *)((dev)->dev_private))->buffers
-
 #endif
===== drivers/char/drm/mga_dma.c 1.19 vs edited =====
--- 1.19/drivers/char/drm/mga_dma.c	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/mga_dma.c	Thu Sep  2 22:11:41 2004
@@ -533,8 +533,8 @@
 		mga_do_cleanup_dma( dev );
 		return DRM_ERR(EINVAL);
 	}
-	DRM_FIND_MAP( dev_priv->buffers, init->buffers_offset );
-	if(!dev_priv->buffers) {
+	DRM_FIND_MAP( dev->agp_buffer_map, init->buffers_offset );
+	if(!dev->agp_buffer_map) {
 		DRM_ERROR( "failed to find dma buffer region!\n" );
 		/* Assign dev_private so we can do cleanup. */
 		dev->dev_private = (void *)dev_priv;
@@ -548,11 +548,11 @@

 	DRM_IOREMAP( dev_priv->warp, dev );
 	DRM_IOREMAP( dev_priv->primary, dev );
-	DRM_IOREMAP( dev_priv->buffers, dev );
+	DRM_IOREMAP( dev->agp_buffer_map, dev );

 	if(!dev_priv->warp->handle ||
 	   !dev_priv->primary->handle ||
-	   !dev_priv->buffers->handle ) {
+	   !dev->agp_buffer_map->handle ) {
 		DRM_ERROR( "failed to ioremap agp regions!\n" );
 		/* Assign dev_private so we can do cleanup. */
 		dev->dev_private = (void *)dev_priv;
@@ -646,8 +646,8 @@
 			DRM_IOREMAPFREE( dev_priv->warp, dev );
 		if ( dev_priv->primary != NULL )
 			DRM_IOREMAPFREE( dev_priv->primary, dev );
-		if ( dev_priv->buffers != NULL )
-			DRM_IOREMAPFREE( dev_priv->buffers, dev );
+		if ( dev->agp_buffer_map != NULL )
+			DRM_IOREMAPFREE( dev->agp_buffer_map, dev );

 		if ( dev_priv->head != NULL ) {
 			mga_freelist_cleanup( dev );
===== drivers/char/drm/r128.h 1.15 vs edited =====
--- 1.15/drivers/char/drm/r128.h	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/r128.h	Thu Sep  2 22:11:41 2004
@@ -86,11 +86,4 @@
 #define __HAVE_VBL_IRQ		1
 #define __HAVE_SHARED_IRQ       1

-/* Buffer customization:
- */
-#define DRIVER_BUF_PRIV_T	drm_r128_buf_priv_t
-
-#define DRIVER_AGP_BUFFERS_MAP( dev )					\
-	((drm_r128_private_t *)((dev)->dev_private))->buffers
-
 #endif
===== drivers/char/drm/r128_cce.c 1.20 vs edited =====
--- 1.20/drivers/char/drm/r128_cce.c	Sat Jul 17 00:14:58 2004
+++ edited/drivers/char/drm/r128_cce.c	Thu Sep  2 22:11:41 2004
@@ -488,8 +488,8 @@
 		r128_do_cleanup_cce( dev );
 		return DRM_ERR(EINVAL);
 	}
-	DRM_FIND_MAP( dev_priv->buffers, init->buffers_offset );
-	if(!dev_priv->buffers) {
+	DRM_FIND_MAP( dev->agp_buffer_map, init->buffers_offset );
+	if(!dev->agp_buffer_map) {
 		DRM_ERROR("could not find dma buffer region!\n");
 		dev->dev_private = (void *)dev_priv;
 		r128_do_cleanup_cce( dev );
@@ -515,10 +515,10 @@
 	if ( !dev_priv->is_pci ) {
 		DRM_IOREMAP( dev_priv->cce_ring, dev );
 		DRM_IOREMAP( dev_priv->ring_rptr, dev );
-		DRM_IOREMAP( dev_priv->buffers, dev );
+		DRM_IOREMAP( dev->agp_buffer_map, dev );
 		if(!dev_priv->cce_ring->handle ||
 		   !dev_priv->ring_rptr->handle ||
-		   !dev_priv->buffers->handle) {
+		   !dev->agp_buffer_map->handle) {
 			DRM_ERROR("Could not ioremap agp regions!\n");
 			dev->dev_private = (void *)dev_priv;
 			r128_do_cleanup_cce( dev );
@@ -531,7 +531,7 @@
 			(void *)dev_priv->cce_ring->offset;
 		dev_priv->ring_rptr->handle =
 			(void *)dev_priv->ring_rptr->offset;
-		dev_priv->buffers->handle = (void *)dev_priv->buffers->offset;
+		dev->agp_buffer_map->handle = (void *)dev->agp_buffer_map->offset;
 	}

 #if __REALLY_HAVE_AGP
@@ -604,8 +604,8 @@
 				DRM_IOREMAPFREE( dev_priv->cce_ring, dev );
 			if ( dev_priv->ring_rptr != NULL )
 				DRM_IOREMAPFREE( dev_priv->ring_rptr, dev );
-			if ( dev_priv->buffers != NULL )
-				DRM_IOREMAPFREE( dev_priv->buffers, dev );
+			if ( dev->agp_buffer_map != NULL )
+				DRM_IOREMAPFREE( dev->agp_buffer_map, dev );
 		} else
 #endif
 		{
===== drivers/char/drm/r128_drv.h 1.18 vs edited =====
--- 1.18/drivers/char/drm/r128_drv.h	Sat Apr 10 23:27:19 2004
+++ edited/drivers/char/drm/r128_drv.h	Thu Sep  2 22:11:41 2004
@@ -100,7 +100,6 @@
 	drm_local_map_t *mmio;
 	drm_local_map_t *cce_ring;
 	drm_local_map_t *ring_rptr;
-	drm_local_map_t *buffers;
 	drm_local_map_t *agp_textures;
 } drm_r128_private_t;

===== drivers/char/drm/r128_state.c 1.18 vs edited =====
--- 1.18/drivers/char/drm/r128_state.c	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/r128_state.c	Thu Sep  2 22:11:41 2004
@@ -667,7 +667,7 @@
 		 */
 		if ( dwords & 1 ) {
 			u32 *data = (u32 *)
-				((char *)dev_priv->buffers->handle
+				((char *)dev->agp_buffer_map->handle
 				 + buf->offset + start);
 			data[dwords++] = cpu_to_le32( R128_CCE_PACKET2 );
 		}
@@ -713,7 +713,7 @@
 	drm_r128_buf_priv_t *buf_priv = buf->dev_private;
 	drm_r128_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	int format = sarea_priv->vc_format;
-	int offset = dev_priv->buffers->offset - dev_priv->cce_buffers_offset;
+	int offset = dev->agp_buffer_map->offset - dev_priv->cce_buffers_offset;
 	int prim = buf_priv->prim;
 	u32 *data;
 	int dwords;
@@ -733,7 +733,7 @@

 		dwords = (end - start + 3) / sizeof(u32);

-		data = (u32 *)((char *)dev_priv->buffers->handle
+		data = (u32 *)((char *)dev->agp_buffer_map->handle
 			       + buf->offset + start);

 		data[0] = cpu_to_le32( CCE_PACKET3( R128_3D_RNDR_GEN_INDX_PRIM,
@@ -857,7 +857,7 @@

 	dwords = (blit->width * blit->height) >> dword_shift;

-	data = (u32 *)((char *)dev_priv->buffers->handle + buf->offset);
+	data = (u32 *)((char *)dev->agp_buffer_map->handle + buf->offset);

 	data[0] = cpu_to_le32( CCE_PACKET3( R128_CNTL_HOSTDATA_BLT, dwords + 6 ) );
 	data[1] = cpu_to_le32( (R128_GMC_DST_PITCH_OFFSET_CNTL |
@@ -1712,6 +1712,7 @@

 void r128_driver_register_fns(drm_device_t *dev)
 {
+	dev->dev_priv_size = sizeof(drm_r128_buf_priv_t);
 	dev->fn_tbl.prerelease = r128_driver_prerelease;
 	dev->fn_tbl.pretakedown = r128_driver_pretakedown;
 }
===== drivers/char/drm/radeon.h 1.22 vs edited =====
--- 1.22/drivers/char/drm/radeon.h	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/radeon.h	Thu Sep  2 22:11:44 2004
@@ -125,12 +125,4 @@
 #define __HAVE_VBL_IRQ		1
 #define __HAVE_SHARED_IRQ       1

-
-/* Buffer customization:
- */
-#define DRIVER_BUF_PRIV_T	drm_radeon_buf_priv_t
-
-#define DRIVER_AGP_BUFFERS_MAP( dev )				\
-	((drm_radeon_private_t *)((dev)->dev_private))->buffers
-
 #endif
===== drivers/char/drm/radeon_cp.c 1.26 vs edited =====
--- 1.26/drivers/char/drm/radeon_cp.c	Sat Jul 17 00:14:58 2004
+++ edited/drivers/char/drm/radeon_cp.c	Thu Sep  2 22:11:44 2004
@@ -1139,8 +1139,8 @@
 		radeon_do_cleanup_cp(dev);
 		return DRM_ERR(EINVAL);
 	}
-	DRM_FIND_MAP( dev_priv->buffers, init->buffers_offset );
-	if(!dev_priv->buffers) {
+	DRM_FIND_MAP( dev->agp_buffer_map, init->buffers_offset );
+	if(!dev->agp_buffer_map) {
 		DRM_ERROR("could not find dma buffer region!\n");
 		dev->dev_private = (void *)dev_priv;
 		radeon_do_cleanup_cp(dev);
@@ -1165,10 +1165,10 @@
 	if ( !dev_priv->is_pci ) {
 		DRM_IOREMAP( dev_priv->cp_ring, dev );
 		DRM_IOREMAP( dev_priv->ring_rptr, dev );
-		DRM_IOREMAP( dev_priv->buffers, dev );
+		DRM_IOREMAP( dev->agp_buffer_map, dev );
 		if(!dev_priv->cp_ring->handle ||
 		   !dev_priv->ring_rptr->handle ||
-		   !dev_priv->buffers->handle) {
+		   !dev->agp_buffer_map->handle) {
 			DRM_ERROR("could not find ioremap agp regions!\n");
 			dev->dev_private = (void *)dev_priv;
 			radeon_do_cleanup_cp(dev);
@@ -1181,14 +1181,14 @@
 			(void *)dev_priv->cp_ring->offset;
 		dev_priv->ring_rptr->handle =
 			(void *)dev_priv->ring_rptr->offset;
-		dev_priv->buffers->handle = (void *)dev_priv->buffers->offset;
+		dev->agp_buffer_map->handle = (void *)dev->agp_buffer_map->offset;

 		DRM_DEBUG( "dev_priv->cp_ring->handle %p\n",
 			   dev_priv->cp_ring->handle );
 		DRM_DEBUG( "dev_priv->ring_rptr->handle %p\n",
 			   dev_priv->ring_rptr->handle );
-		DRM_DEBUG( "dev_priv->buffers->handle %p\n",
-			   dev_priv->buffers->handle );
+		DRM_DEBUG( "dev->agp_buffer_map->handle %p\n",
+			   dev->agp_buffer_map->handle );
 	}

 	dev_priv->fb_location = ( RADEON_READ( RADEON_MC_FB_LOCATION )
@@ -1213,12 +1213,12 @@

 #if __REALLY_HAVE_AGP
 	if ( !dev_priv->is_pci )
-		dev_priv->gart_buffers_offset = (dev_priv->buffers->offset
+		dev_priv->gart_buffers_offset = (dev->agp_buffer_map->offset
 						- dev->agp->base
 						+ dev_priv->gart_vm_start);
 	else
 #endif
-		dev_priv->gart_buffers_offset = (dev_priv->buffers->offset
+		dev_priv->gart_buffers_offset = (dev->agp_buffer_map->offset
 						- dev->sg->handle
 						+ dev_priv->gart_vm_start);

@@ -1292,8 +1292,8 @@
 				DRM_IOREMAPFREE( dev_priv->cp_ring, dev );
 			if ( dev_priv->ring_rptr != NULL )
 				DRM_IOREMAPFREE( dev_priv->ring_rptr, dev );
-			if ( dev_priv->buffers != NULL )
-				DRM_IOREMAPFREE( dev_priv->buffers, dev );
+			if ( dev->agp_buffer_map != NULL )
+				DRM_IOREMAPFREE( dev->agp_buffer_map, dev );
 		} else
 #endif
 		{
===== drivers/char/drm/radeon_drv.h 1.28 vs edited =====
--- 1.28/drivers/char/drm/radeon_drv.h	Sat Jul 17 00:14:58 2004
+++ edited/drivers/char/drm/radeon_drv.h	Thu Sep  2 22:11:44 2004
@@ -138,7 +138,6 @@
 	drm_local_map_t *mmio;
 	drm_local_map_t *cp_ring;
 	drm_local_map_t *ring_rptr;
-	drm_local_map_t *buffers;
 	drm_local_map_t *gart_textures;

 	struct mem_block *gart_heap;
===== drivers/char/drm/radeon_state.c 1.30 vs edited =====
--- 1.30/drivers/char/drm/radeon_state.c	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/radeon_state.c	Thu Sep  2 22:26:18 2004
@@ -1247,7 +1247,7 @@
 		 */
 		if ( dwords & 1 ) {
 			u32 *data = (u32 *)
-				((char *)dev_priv->buffers->handle
+				((char *)dev->agp_buffer_map->handle
 				 + buf->offset + start);
 			data[dwords++] = RADEON_CP_PACKET2;
 		}
@@ -1301,7 +1301,7 @@

 	dwords = (prim->finish - prim->start + 3) / sizeof(u32);

-	data = (u32 *)((char *)dev_priv->buffers->handle +
+	data = (u32 *)((char *)dev->agp_buffer_map->handle +
 		       elt_buf->offset + prim->start);

 	data[0] = CP_PACKET3( RADEON_3D_RNDR_GEN_INDX_PRIM, dwords-2 );
@@ -1445,7 +1445,7 @@

 		/* Dispatch the indirect buffer.
 		 */
-		buffer = (u32*)((char*)dev_priv->buffers->handle + buf->offset);
+		buffer = (u32*)((char*)dev->agp_buffer_map->handle + buf->offset);
 		dwords = size / 4;
 		buffer[0] = CP_PACKET3( RADEON_CNTL_HOSTDATA_BLT, dwords + 6 );
 		buffer[1] = (RADEON_GMC_DST_PITCH_OFFSET_CNTL |
@@ -2548,6 +2548,12 @@
 	return 0;
 }

+/* When a client dies:
+ *    - Check for and clean up flipped page state
+ *    - Free any alloced GART memory.
+ *
+ * DRM infrastructure takes care of reclaiming dma buffers.
+ */
 static void radeon_driver_prerelease(drm_device_t *dev, DRMFILE filp)
 {
 	if ( dev->dev_private ) {
@@ -2576,6 +2582,7 @@

 void radeon_driver_register_fns(struct drm_device *dev)
 {
+	dev->dev_priv_size = sizeof(drm_radeon_buf_priv_t);
 	dev->fn_tbl.prerelease = radeon_driver_prerelease;
 	dev->fn_tbl.pretakedown = radeon_driver_pretakedown;
 	dev->fn_tbl.open_helper = radeon_driver_open_helper;
===== drivers/char/drm/sis.h 1.8 vs edited =====
--- 1.8/drivers/char/drm/sis.h	Thu Apr 22 21:25:27 2004
+++ edited/drivers/char/drm/sis.h	Thu Sep  2 22:11:44 2004
@@ -64,15 +64,4 @@

 #define __HAVE_COUNTERS		5

-/* Buffer customization:
- */
-#define DRIVER_AGP_BUFFERS_MAP( dev )					\
-	((drm_sis_private_t *)((dev)->dev_private))->buffers
-
-extern int sis_init_context(int context);
-extern int sis_final_context(int context);
-
-#define DRIVER_CTX_CTOR sis_init_context
-#define DRIVER_CTX_DTOR sis_final_context
-
 #endif
===== drivers/char/drm/sis_drv.h 1.4 vs edited =====
--- 1.4/drivers/char/drm/sis_drv.h	Fri Sep 26 01:30:25 2003
+++ edited/drivers/char/drm/sis_drv.h	Thu Sep  2 22:11:44 2004
@@ -31,8 +31,6 @@
 #include "sis_ds.h"

 typedef struct drm_sis_private {
-	drm_map_t *buffers;
-
 	memHeap_t *AGPHeap;
 	memHeap_t *FBHeap;
 } drm_sis_private_t;
===== drivers/char/drm/sis_mm.c 1.12 vs edited =====
--- 1.12/drivers/char/drm/sis_mm.c	Thu Sep  2 21:51:56 2004
+++ edited/drivers/char/drm/sis_mm.c	Thu Sep  2 22:33:36 2004
@@ -326,7 +326,7 @@
 	return 0;
 }

-int sis_init_context(int context)
+int sis_init_context(struct drm_device *dev, int context)
 {
 	int i;

@@ -358,7 +358,7 @@
 	return 1;
 }

-int sis_final_context(int context)
+int sis_final_context(struct drm_device *dev, int context)
 {
 	int i;

@@ -407,4 +407,6 @@

 void DRM(driver_register_fns)(drm_device_t *dev)
 {
+	dev->fn_tbl.context_ctor = sis_init_context;
+	dev->fn_tbl.context_dtor = sis_final_context;
 }
