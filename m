Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbULaHvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbULaHvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 02:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbULaHvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 02:51:54 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:40586 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261831AbULaHuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 02:50:51 -0500
Date: Fri, 31 Dec 2004 07:50:48 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [bk tree] minor DRM patches
Message-ID: <Pine.LNX.4.58.0412310749390.24852@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please do a

	bk pull bk://drm.bkbits.net/drm-linus

This will include some minor DRM patches and cleanups from DRM CVS.

 drivers/char/drm/ati_pcigart.c |    2 +-
 drivers/char/drm/drmP.h        |    4 ++--
 drivers/char/drm/drm_dma.c     |    4 +---
 drivers/char/drm/drm_fops.c    |    2 +-
 drivers/char/drm/drm_stub.c    |    2 +-
 drivers/char/drm/i810_dma.c    |    6 ++----
 drivers/char/drm/i810_drv.h    |    2 +-
 drivers/char/drm/i830_dma.c    |    6 ++----
 drivers/char/drm/i830_drv.h    |    2 +-
 drivers/char/drm/sis_ds.c      |    4 ++--
 drivers/char/drm/sis_ds.h      |    8 ++++----
 11 files changed, 18 insertions(+), 24 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/12/31 1.2089)
   drm: make reclaim_buffers take dev argument

   Allow drivers to override reclaim_buffers in an OS-independent
   way by passing drm_device_t* as first parameter, like in the
   BSD version.

   From: Felix Kuehling <fxhuehl@gmx.de>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/12/31 1.2088)
   drm: use spin_lock_init instead of SPIN_LOCK_UNLOCKED

   From: Jon Smirl <jonsmirl@gmail.com>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/12/31 1.2087)
   drm: correct historic mis-attribution of copyright

   From: Keith Withwell <keithw@tungstengraphics.com>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/12/31 1.2086)
   Make 1-bit fields be unsigned (no sign bit :).
   sparse complains about them:
   drivers/char/drm/sis_ds.h:88:12: warning: dubious one-bit signed bitfield
   drivers/char/drm/sis_ds.h:89:16: warning: dubious one-bit signed bitfield

   Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/12/31 1.2081.1.1)
   drm: Use wbinvd macro instead of assembly for it,

   From: Stefan Dirsch <sndirsch@suse.de>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/ati_pcigart.c b/drivers/char/drm/ati_pcigart.c
--- a/drivers/char/drm/ati_pcigart.c	2004-12-31 18:41:20 +11:00
+++ b/drivers/char/drm/ati_pcigart.c	2004-12-31 18:41:20 +11:00
@@ -195,7 +195,7 @@
 	ret = 1;

 #if defined(__i386__) || defined(__x86_64__)
-	asm volatile ( "wbinvd" ::: "memory" );
+	wbinvd();
 #else
 	mb();
 #endif
diff -Nru a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
--- a/drivers/char/drm/drmP.h	2004-12-31 18:41:20 +11:00
+++ b/drivers/char/drm/drmP.h	2004-12-31 18:41:20 +11:00
@@ -580,7 +580,7 @@
  	void (*irq_preinstall)(struct drm_device *dev);
  	void (*irq_postinstall)(struct drm_device *dev);
  	void (*irq_uninstall)(struct drm_device *dev);
-	void (*reclaim_buffers)(struct file *filp);
+	void (*reclaim_buffers)(struct drm_device *dev, struct file *filp);
 	unsigned long (*get_map_ofs)(drm_map_t *map);
 	unsigned long (*get_reg_ofs)(struct drm_device *dev);
 	void (*set_version)(struct drm_device *dev, drm_set_version_t *sv);
@@ -912,7 +912,7 @@
 extern int	     drm_dma_setup(drm_device_t *dev);
 extern void	     drm_dma_takedown(drm_device_t *dev);
 extern void	     drm_free_buffer(drm_device_t *dev, drm_buf_t *buf);
-extern void	     drm_core_reclaim_buffers( struct file *filp );
+extern void	     drm_core_reclaim_buffers(drm_device_t *dev, struct file *filp);

 				/* IRQ support (drm_irq.h) */
 extern int           drm_control( struct inode *inode, struct file *filp,
diff -Nru a/drivers/char/drm/drm_dma.c b/drivers/char/drm/drm_dma.c
--- a/drivers/char/drm/drm_dma.c	2004-12-31 18:41:20 +11:00
+++ b/drivers/char/drm/drm_dma.c	2004-12-31 18:41:20 +11:00
@@ -154,10 +154,8 @@
  *
  * Frees each buffer associated with \p filp not already on the hardware.
  */
-void drm_core_reclaim_buffers( struct file *filp )
+void drm_core_reclaim_buffers(drm_device_t *dev, struct file *filp)
 {
-	drm_file_t    *priv   = filp->private_data;
-	drm_device_t  *dev    = priv->dev;
 	drm_device_dma_t *dma = dev->dma;
 	int		 i;

diff -Nru a/drivers/char/drm/drm_fops.c b/drivers/char/drm/drm_fops.c
--- a/drivers/char/drm/drm_fops.c	2004-12-31 18:41:20 +11:00
+++ b/drivers/char/drm/drm_fops.c	2004-12-31 18:41:20 +11:00
@@ -251,7 +251,7 @@

 	if (drm_core_check_feature(dev, DRIVER_HAVE_DMA))
 	{
-		dev->driver->reclaim_buffers(filp);
+		dev->driver->reclaim_buffers(dev, filp);
 	}

 	drm_fasync( -1, filp, 0 );
diff -Nru a/drivers/char/drm/drm_stub.c b/drivers/char/drm/drm_stub.c
--- a/drivers/char/drm/drm_stub.c	2004-12-31 18:41:20 +11:00
+++ b/drivers/char/drm/drm_stub.c	2004-12-31 18:41:20 +11:00
@@ -57,7 +57,7 @@
 {
 	int retcode;

-	dev->count_lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&dev->count_lock);
 	init_timer( &dev->timer );
 	sema_init( &dev->struct_sem, 1 );
 	sema_init( &dev->ctxlist_sem, 1 );
diff -Nru a/drivers/char/drm/i810_dma.c b/drivers/char/drm/i810_dma.c
--- a/drivers/char/drm/i810_dma.c	2004-12-31 18:41:20 +11:00
+++ b/drivers/char/drm/i810_dma.c	2004-12-31 18:41:20 +11:00
@@ -994,10 +994,8 @@
 }

 /* Must be called with the lock held */
-void i810_reclaim_buffers(struct file *filp)
+void i810_reclaim_buffers(drm_device_t *dev, struct file *filp)
 {
-	drm_file_t    *priv   = filp->private_data;
-	drm_device_t  *dev    = priv->dev;
 	drm_device_dma_t *dma = dev->dma;
 	int		 i;

@@ -1367,7 +1365,7 @@

 void i810_driver_release(drm_device_t *dev, struct file *filp)
 {
-	i810_reclaim_buffers(filp);
+	i810_reclaim_buffers(dev, filp);
 }

 int i810_driver_dma_quiescent(drm_device_t *dev)
diff -Nru a/drivers/char/drm/i810_drv.h b/drivers/char/drm/i810_drv.h
--- a/drivers/char/drm/i810_drv.h	2004-12-31 18:41:20 +11:00
+++ b/drivers/char/drm/i810_drv.h	2004-12-31 18:41:20 +11:00
@@ -122,7 +122,7 @@
 extern int  i810_dma_cleanup(drm_device_t *dev);
 extern int  i810_flush_ioctl(struct inode *inode, struct file *filp,
 			     unsigned int cmd, unsigned long arg);
-extern void i810_reclaim_buffers(struct file *filp);
+extern void i810_reclaim_buffers(drm_device_t *dev, struct file *filp);
 extern int  i810_getage(struct inode *inode, struct file *filp,
 			unsigned int cmd, unsigned long arg);
 extern int i810_mmap_buffers(struct file *filp, struct vm_area_struct *vma);
diff -Nru a/drivers/char/drm/i830_dma.c b/drivers/char/drm/i830_dma.c
--- a/drivers/char/drm/i830_dma.c	2004-12-31 18:41:20 +11:00
+++ b/drivers/char/drm/i830_dma.c	2004-12-31 18:41:20 +11:00
@@ -1283,10 +1283,8 @@
 }

 /* Must be called with the lock held */
-void i830_reclaim_buffers( struct file *filp )
+void i830_reclaim_buffers(drm_device_t *dev, struct file *filp)
 {
-	drm_file_t    *priv   = filp->private_data;
-	drm_device_t  *dev    = priv->dev;
 	drm_device_dma_t *dma = dev->dma;
 	int		 i;

@@ -1570,7 +1568,7 @@

 void i830_driver_release(drm_device_t *dev, struct file *filp)
 {
-	i830_reclaim_buffers(filp);
+	i830_reclaim_buffers(dev, filp);
 }

 int i830_driver_dma_quiescent(drm_device_t *dev)
diff -Nru a/drivers/char/drm/i830_drv.h b/drivers/char/drm/i830_drv.h
--- a/drivers/char/drm/i830_drv.h	2004-12-31 18:41:20 +11:00
+++ b/drivers/char/drm/i830_drv.h	2004-12-31 18:41:20 +11:00
@@ -129,7 +129,7 @@
 extern int  i830_dma_cleanup(drm_device_t *dev);
 extern int  i830_flush_ioctl(struct inode *inode, struct file *filp,
 			     unsigned int cmd, unsigned long arg);
-extern void i830_reclaim_buffers(struct file *filp);
+extern void i830_reclaim_buffers(drm_device_t *dev, struct file *filp);
 extern int  i830_getage(struct inode *inode, struct file *filp, unsigned int cmd,
 			unsigned long arg);
 extern int i830_mmap_buffers(struct file *filp, struct vm_area_struct *vma);
diff -Nru a/drivers/char/drm/sis_ds.c b/drivers/char/drm/sis_ds.c
--- a/drivers/char/drm/sis_ds.c	2004-12-31 18:41:20 +11:00
+++ b/drivers/char/drm/sis_ds.c	2004-12-31 18:41:20 +11:00
@@ -134,7 +134,7 @@

 /*
  * GLX Hardware Device Driver common code
- * Copyright (C) 1999 Keith Whitwell
+ * Copyright (C) 1999 Wittawat Yamwong
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -149,7 +149,7 @@
  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
  * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * KEITH WHITWELL, OR ANY OTHER CONTRIBUTORS BE LIABLE FOR ANY CLAIM,
+ * WITTAWAT YAMWONG, OR ANY OTHER CONTRIBUTORS BE LIABLE FOR ANY CLAIM,
  * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
  * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
  * OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
diff -Nru a/drivers/char/drm/sis_ds.h b/drivers/char/drm/sis_ds.h
--- a/drivers/char/drm/sis_ds.h	2004-12-31 18:41:20 +11:00
+++ b/drivers/char/drm/sis_ds.h	2004-12-31 18:41:20 +11:00
@@ -58,7 +58,7 @@

 /*
  * GLX Hardware Device Driver common code
- * Copyright (C) 1999 Keith Whitwell
+ * Copyright (C) 1999 Wittawat Yamwong
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -73,7 +73,7 @@
  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
  * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * KEITH WHITWELL, OR ANY OTHER CONTRIBUTORS BE LIABLE FOR ANY CLAIM,
+ * WITTAWAT YAMWONG, OR ANY OTHER CONTRIBUTORS BE LIABLE FOR ANY CLAIM,
  * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
  * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
  * OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
@@ -85,8 +85,8 @@
 	struct mem_block_t *heap;
 	int ofs,size;
 	int align;
-	int free:1;
-	int reserved:1;
+	unsigned int free:1;
+	unsigned int reserved:1;
 };
 typedef struct mem_block_t TMemBlock;
 typedef struct mem_block_t *PMemBlock;
