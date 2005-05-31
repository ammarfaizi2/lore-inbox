Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVEaBBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVEaBBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 21:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVEaBBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 21:01:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10257 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261831AbVEaA6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 20:58:55 -0400
Date: Tue, 31 May 2005 02:58:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] DRM: misc cleanup
Message-ID: <20050531005853.GI3627@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 09:16:16PM +1100, Dave Airlie wrote:
> 
> I'll nack this patch for now Adrian, but I'm going to bring all these
> changes into the DRM tree as soon as I can.. one of the functions you
> removed pointed out a bug in the i810/i830/i915 drivers (granted
> no-one uses pageflip in those drivers but still should fix it..), I'm
> going to put the through drm CVS first...

I've seen that part of this is already in recent kernels.

Below is as a FYI a version against 2.6.12-rc5-mm1. 

> Thanks,
> Dave.

cu
Adrian


<--  snip   -->


This patch contains the following cleanups:
- make needlessly global functions static
- remove the following unused global functions:
  - drm_fops.c: drm_read
  - i915_dma.c: i915_do_cleanup_pageflip
  - via_ds.c: via_mmDumpMemInfo
  - via_ds.c: via_mmAddRange
  - via_ds.c: via_mmReserveMem
  - via_ds.c: via_mmFreeReserved
  - via_ds.c: via_mmDestroy
- remove the followig unused global variable:
  - via_mm.c: VIA_DEBUG

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/drm/ati_pcigart.c |    2 
 drivers/char/drm/drmP.h        |   22 ------
 drivers/char/drm/drm_auth.c    |    4 -
 drivers/char/drm/drm_bufs.c    |   12 +--
 drivers/char/drm/drm_context.c |    6 -
 drivers/char/drm/drm_drv.c     |    9 +-
 drivers/char/drm/drm_fops.c    |   10 ---
 drivers/char/drm/drm_irq.c     |    2 
 drivers/char/drm/drm_lock.c    |   12 ++-
 drivers/char/drm/drm_proc.c    |    2 
 drivers/char/drm/drm_stub.c    |   92 ++++++++++++++--------------
 drivers/char/drm/drm_vm.c      |   10 +--
 drivers/char/drm/i810_dma.c    |   24 +++----
 drivers/char/drm/i810_drv.h    |    1 
 drivers/char/drm/i830_dma.c    |   20 +++---
 drivers/char/drm/i830_drv.c    |    2 
 drivers/char/drm/i830_drv.h    |    2 
 drivers/char/drm/i830_irq.c    |    4 -
 drivers/char/drm/i915_dma.c    |   60 +++++++-----------
 drivers/char/drm/i915_drv.c    |    2 
 drivers/char/drm/i915_drv.h    |   10 ---
 drivers/char/drm/i915_irq.c    |    4 -
 drivers/char/drm/r128_state.c  |    2 
 drivers/char/drm/via_dma.c     |    4 -
 drivers/char/drm/via_drv.h     |    2 
 drivers/char/drm/via_ds.c      |  108 ---------------------------------
 drivers/char/drm/via_ds.h      |    8 --
 drivers/char/drm/via_map.c     |    2 
 drivers/char/drm/via_mm.c      |   14 ++--
 drivers/char/drm/via_mm.h      |    5 -
 30 files changed, 149 insertions(+), 308 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/char/drm/drmP.h.old	2005-04-18 03:54:16.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/drm/drmP.h	2005-04-18 03:54:49.000000000 +0200
@@ -774,8 +774,6 @@
 				/* Driver support (drm_drv.h) */
 extern int           drm_init(struct drm_driver *driver);
 extern void          drm_exit(struct drm_driver *driver);
-extern int           drm_version(struct inode *inode, struct file *filp,
-				  unsigned int cmd, unsigned long arg);
 extern int           drm_ioctl(struct inode *inode, struct file *filp,
 				unsigned int cmd, unsigned long arg);
 extern long	     drm_compat_ioctl(struct file *filp,
@@ -785,21 +783,13 @@
 				/* Device support (drm_fops.h) */
 extern int           drm_open(struct inode *inode, struct file *filp);
 extern int           drm_stub_open(struct inode *inode, struct file *filp);
-extern int	     drm_open_helper(struct inode *inode, struct file *filp,
-				      drm_device_t *dev);
 extern int	     drm_flush(struct file *filp);
 extern int	     drm_fasync(int fd, struct file *filp, int on);
 extern int           drm_release(struct inode *inode, struct file *filp);
 
 				/* Mapping support (drm_vm.h) */
-extern void	     drm_vm_open(struct vm_area_struct *vma);
-extern void	     drm_vm_close(struct vm_area_struct *vma);
-extern void	     drm_vm_shm_close(struct vm_area_struct *vma);
-extern int	     drm_mmap_dma(struct file *filp,
-				   struct vm_area_struct *vma);
 extern int	     drm_mmap(struct file *filp, struct vm_area_struct *vma);
 extern unsigned int  drm_poll(struct file *filp, struct poll_table_struct *wait);
-extern ssize_t       drm_read(struct file *filp, char __user *buf, size_t count, loff_t *off);
 
 				/* Memory management support (drm_memory.h) */
 #include "drm_memory.h"
@@ -854,9 +844,6 @@
 extern int	     drm_rmctx( struct inode *inode, struct file *filp,
 				 unsigned int cmd, unsigned long arg );
 
-extern int	     drm_context_switch(drm_device_t *dev, int old, int new);
-extern int	     drm_context_switch_complete(drm_device_t *dev, int new);
-
 extern int	     drm_ctxbitmap_init( drm_device_t *dev );
 extern void	     drm_ctxbitmap_cleanup( drm_device_t *dev );
 extern void          drm_ctxbitmap_free( drm_device_t *dev, int ctx_handle );
@@ -874,9 +861,6 @@
 
 
 				/* Authentication IOCTL support (drm_auth.h) */
-extern int	     drm_add_magic(drm_device_t *dev, drm_file_t *priv,
-				    drm_magic_t magic);
-extern int	     drm_remove_magic(drm_device_t *dev, drm_magic_t magic);
 extern int	     drm_getmagic(struct inode *inode, struct file *filp,
 				   unsigned int cmd, unsigned long arg);
 extern int	     drm_authmagic(struct inode *inode, struct file *filp,
@@ -893,13 +877,9 @@
 				 unsigned int cmd, unsigned long arg);
 extern int	     drm_lock_take(__volatile__ unsigned int *lock,
 				    unsigned int context);
-extern int	     drm_lock_transfer(drm_device_t *dev,
-					__volatile__ unsigned int *lock,
-					unsigned int context);
 extern int	     drm_lock_free(drm_device_t *dev,
 				    __volatile__ unsigned int *lock,
 				    unsigned int context);
-extern int           drm_notifier(void *priv);
 
 				/* Buffer management support (drm_bufs.h) */
 extern int	     drm_order( unsigned long size );
@@ -927,7 +907,6 @@
 				/* IRQ support (drm_irq.h) */
 extern int           drm_control( struct inode *inode, struct file *filp,
 				   unsigned int cmd, unsigned long arg );
-extern int           drm_irq_install( drm_device_t *dev );
 extern int           drm_irq_uninstall( drm_device_t *dev );
 extern irqreturn_t   drm_irq_handler( DRM_IRQ_ARGS );
 extern void          drm_driver_irq_preinstall( drm_device_t *dev );
@@ -967,7 +946,6 @@
 extern int drm_get_dev(struct pci_dev *pdev, const struct pci_device_id *ent,
 		     struct drm_driver *driver);
 extern int drm_put_dev(drm_device_t * dev);
-extern int drm_get_head(drm_device_t * dev, drm_head_t *head);
 extern int drm_put_head(drm_head_t * head);
 extern unsigned int   drm_debug;
 extern unsigned int   drm_cards_limit;
--- linux-2.6.12-rc2-mm3-full/drivers/char/drm/drm_stub.c.old	2005-04-18 03:55:03.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/drm/drm_stub.c	2005-04-18 03:56:00.000000000 +0200
@@ -159,51 +159,6 @@
 
 
 /**
- * Register.
- *
- * \param pdev - PCI device structure
- * \param ent entry from the PCI ID table with device type flags
- * \return zero on success or a negative number on failure.
- *
- * Attempt to gets inter module "drm" information. If we are first
- * then register the character device and inter module information.
- * Try and register, if we fail to register, backout previous work.
- */
-int drm_get_dev(struct pci_dev *pdev, const struct pci_device_id *ent,
-	      struct drm_driver *driver)
-{
-	drm_device_t *dev;
-	int ret;
-
-	DRM_DEBUG("\n");
-
-	dev = drm_calloc(1, sizeof(*dev), DRM_MEM_STUB);
-	if (!dev)
-		return -ENOMEM;
-
-	pci_enable_device(pdev);
-
-	if ((ret = drm_fill_in_dev(dev, pdev, ent, driver))) {
-		printk(KERN_ERR "DRM: Fill_in_dev failed.\n");
-		goto err_g1;
-	}
-	if ((ret = drm_get_head(dev, &dev->primary)))
-		goto err_g1;
-
-	/* postinit is a required function to display the signon banner */
-	/* drivers add secondary heads here if needed */
-	if ((ret = dev->driver->postinit(dev, ent->driver_data)))
-		goto err_g1;
-
-	return 0;
-
-err_g1:
-	drm_free(dev, sizeof(*dev), DRM_MEM_STUB);
-	return ret;
-}
-EXPORT_SYMBOL(drm_get_dev);
-
-/**
  * Get a secondary minor number.
  *
  * \param dev device data structure
@@ -214,7 +169,7 @@
  * create the proc init entry via proc_init(). This routines assigns
  * minor numbers to secondary heads of multi-headed cards
  */
-int drm_get_head(drm_device_t *dev, drm_head_t *head)
+static int drm_get_head(drm_device_t *dev, drm_head_t *head)
 {
 	drm_head_t **heads = drm_heads;
 	int ret;
@@ -264,6 +219,51 @@
 		
 
 /**
+ * Register.
+ *
+ * \param pdev - PCI device structure
+ * \param ent entry from the PCI ID table with device type flags
+ * \return zero on success or a negative number on failure.
+ *
+ * Attempt to gets inter module "drm" information. If we are first
+ * then register the character device and inter module information.
+ * Try and register, if we fail to register, backout previous work.
+ */
+int drm_get_dev(struct pci_dev *pdev, const struct pci_device_id *ent,
+	      struct drm_driver *driver)
+{
+	drm_device_t *dev;
+	int ret;
+
+	DRM_DEBUG("\n");
+
+	dev = drm_calloc(1, sizeof(*dev), DRM_MEM_STUB);
+	if (!dev)
+		return -ENOMEM;
+
+	pci_enable_device(pdev);
+
+	if ((ret = drm_fill_in_dev(dev, pdev, ent, driver))) {
+		printk(KERN_ERR "DRM: Fill_in_dev failed.\n");
+		goto err_g1;
+	}
+	if ((ret = drm_get_head(dev, &dev->primary)))
+		goto err_g1;
+
+	/* postinit is a required function to display the signon banner */
+	/* drivers add secondary heads here if needed */
+	if ((ret = dev->driver->postinit(dev, ent->driver_data)))
+		goto err_g1;
+
+	return 0;
+
+err_g1:
+	drm_free(dev, sizeof(*dev), DRM_MEM_STUB);
+	return ret;
+}
+EXPORT_SYMBOL(drm_get_dev);
+
+/**
  * Put a device minor number.
  *
  * \param dev device data structure
--- linux-2.6.12-rc2-mm3-full/drivers/char/drm/i810_drv.h.old	2005-04-18 03:57:34.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/drm/i810_drv.h	2005-04-18 03:57:41.000000000 +0200
@@ -115,7 +115,6 @@
 
 				/* i810_dma.c */
 extern void i810_reclaim_buffers(drm_device_t *dev, struct file *filp);
-extern int i810_mmap_buffers(struct file *filp, struct vm_area_struct *vma);
 
 extern int i810_driver_dma_quiescent(drm_device_t *dev);
 extern void i810_driver_release(drm_device_t *dev, struct file *filp);
--- linux-2.6.12-rc2-mm3-full/drivers/char/drm/i810_dma.c.old	2005-04-18 03:56:14.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/drm/i810_dma.c	2005-04-18 03:57:18.000000000 +0200
@@ -90,16 +90,7 @@
    	return 0;
 }
 
-static struct file_operations i810_buffer_fops = {
-	.open	 = drm_open,
-	.flush	 = drm_flush,
-	.release = drm_release,
-	.ioctl	 = drm_ioctl,
-	.mmap	 = i810_mmap_buffers,
-	.fasync  = drm_fasync,
-};
-
-int i810_mmap_buffers(struct file *filp, struct vm_area_struct *vma)
+static int i810_mmap_buffers(struct file *filp, struct vm_area_struct *vma)
 {
 	drm_file_t	    *priv	  = filp->private_data;
 	drm_device_t	    *dev;
@@ -126,6 +117,15 @@
 	return 0;
 }
 
+static struct file_operations i810_buffer_fops = {
+	.open	 = drm_open,
+	.flush	 = drm_flush,
+	.release = drm_release,
+	.ioctl	 = drm_ioctl,
+	.mmap	 = i810_mmap_buffers,
+	.fasync  = drm_fasync,
+};
+
 static int i810_map_buffer(drm_buf_t *buf, struct file *filp)
 {
 	drm_file_t	  *priv	  = filp->private_data;
@@ -1003,8 +1003,8 @@
 	}
 }
 
-int i810_flush_ioctl(struct inode *inode, struct file *filp,
-		     unsigned int cmd, unsigned long arg)
+static int i810_flush_ioctl(struct inode *inode, struct file *filp,
+			    unsigned int cmd, unsigned long arg)
 {
    	drm_file_t	  *priv	  = filp->private_data;
    	drm_device_t	  *dev	  = priv->head->dev;
--- linux-2.6.12-rc2-mm3-full/drivers/char/drm/r128_state.c.old	2005-04-18 03:58:14.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/drm/r128_state.c	2005-04-18 03:58:23.000000000 +0200
@@ -1307,7 +1307,7 @@
 	return 0;
 }
 
-int r128_do_cleanup_pageflip( drm_device_t *dev )
+static int r128_do_cleanup_pageflip( drm_device_t *dev )
 {
 	drm_r128_private_t *dev_priv = dev->dev_private;
 	DRM_DEBUG( "\n" );

--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/ati_pcigart.c.old	2005-01-31 00:12:08.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/ati_pcigart.c	2005-01-31 00:12:20.000000000 +0100
@@ -52,7 +52,7 @@
 # define ATI_MAX_PCIGART_PAGES		8192	/**< 32 MB aperture, 4K pages */
 # define ATI_PCIGART_PAGE_SIZE		4096	/**< PCI GART page size */
 
-unsigned long drm_ati_alloc_pcigart_table( void )
+static unsigned long drm_ati_alloc_pcigart_table( void )
 {
 	unsigned long address;
 	struct page *page;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_auth.c.old	2005-01-31 00:12:54.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_auth.c	2005-01-31 00:13:16.000000000 +0100
@@ -87,7 +87,7 @@
  * associated the magic number hash key in drm_device::magiclist, while holding
  * the drm_device::struct_sem lock.
  */
-int drm_add_magic(drm_device_t *dev, drm_file_t *priv, drm_magic_t magic)
+static int drm_add_magic(drm_device_t *dev, drm_file_t *priv, drm_magic_t magic)
 {
 	int		  hash;
 	drm_magic_entry_t *entry;
@@ -124,7 +124,7 @@
  * Searches and unlinks the entry in drm_device::magiclist with the magic
  * number hash key, while holding the drm_device::struct_sem lock.
  */
-int drm_remove_magic(drm_device_t *dev, drm_magic_t magic)
+static int drm_remove_magic(drm_device_t *dev, drm_magic_t magic)
 {
 	drm_magic_entry_t *prev = NULL;
 	drm_magic_entry_t *pt;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_bufs.c.old	2005-01-31 00:13:31.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_bufs.c	2005-01-31 00:14:18.000000000 +0100
@@ -345,8 +345,8 @@
  * reallocates the buffer list of the same size order to accommodate the new
  * buffers.
  */
-int drm_addbufs_agp( struct inode *inode, struct file *filp,
-		      unsigned int cmd, unsigned long arg )
+static int drm_addbufs_agp( struct inode *inode, struct file *filp,
+			     unsigned int cmd, unsigned long arg )
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -510,8 +510,8 @@
 }
 #endif /* __OS_HAS_AGP */
 
-int drm_addbufs_pci( struct inode *inode, struct file *filp,
-		      unsigned int cmd, unsigned long arg )
+static int drm_addbufs_pci( struct inode *inode, struct file *filp,
+			     unsigned int cmd, unsigned long arg )
 {
    	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -740,8 +740,8 @@
 
 }
 
-int drm_addbufs_sg( struct inode *inode, struct file *filp,
-                     unsigned int cmd, unsigned long arg )
+static int drm_addbufs_sg( struct inode *inode, struct file *filp,
+			    unsigned int cmd, unsigned long arg )
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_context.c.old	2005-01-31 00:14:48.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_context.c	2005-01-31 00:15:08.000000000 +0100
@@ -84,7 +84,7 @@
  * drm_device::context_sareas to accommodate the new entry while holding the
  * drm_device::struct_sem lock.
  */
-int drm_ctxbitmap_next( drm_device_t *dev )
+static int drm_ctxbitmap_next( drm_device_t *dev )
 {
 	int bit;
 
@@ -297,7 +297,7 @@
  *
  * Attempt to set drm_device::context_flag.
  */
-int drm_context_switch( drm_device_t *dev, int old, int new )
+static int drm_context_switch( drm_device_t *dev, int old, int new )
 {
         if ( test_and_set_bit( 0, &dev->context_flag ) ) {
                 DRM_ERROR( "Reentering -- FIXME\n" );
@@ -326,7 +326,7 @@
  * hardware lock is held, clears the drm_device::context_flag and wakes up
  * drm_device::context_wait.
  */
-int drm_context_switch_complete( drm_device_t *dev, int new )
+static int drm_context_switch_complete( drm_device_t *dev, int new )
 {
         dev->last_context = new;  /* PRE/POST: This is the _only_ writer. */
         dev->last_switch  = jiffies;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_drv.c.old	2005-01-31 00:15:26.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_drv.c	2005-01-31 00:16:58.000000000 +0100
@@ -55,8 +55,11 @@
 #include "drmP.h"
 #include "drm_core.h"
 
+static int drm_version( struct inode *inode, struct file *filp,
+			 unsigned int cmd, unsigned long arg );
+
 /** Ioctl table */
-drm_ioctl_desc_t		  drm_ioctls[] = {
+static drm_ioctl_desc_t		  drm_ioctls[] = {
 	[DRM_IOCTL_NR(DRM_IOCTL_VERSION)]       = { drm_version,     0, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_GET_UNIQUE)]    = { drm_getunique,   0, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_GET_MAGIC)]     = { drm_getmagic,    0, 0 },
@@ -461,8 +464,8 @@
  *
  * Fills in the version information in \p arg.
  */
-int drm_version( struct inode *inode, struct file *filp,
-		  unsigned int cmd, unsigned long arg )
+static int drm_version( struct inode *inode, struct file *filp,
+			 unsigned int cmd, unsigned long arg )
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_fops.c.old	2005-01-31 00:17:23.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_fops.c	2005-01-31 00:18:35.000000000 +0100
@@ -37,6 +37,8 @@
 #include "drmP.h"
 #include <linux/poll.h>
 
+static int drm_open_helper(struct inode *inode, struct file *filp, drm_device_t *dev);
+
 static int drm_setup( drm_device_t *dev )
 {
 	int i;
@@ -339,7 +341,7 @@
  * Creates and initializes a drm_file structure for the file private data in \p
  * filp and add it into the double linked list in \p dev.
  */
-int drm_open_helper(struct inode *inode, struct file *filp, drm_device_t *dev)
+static int drm_open_helper(struct inode *inode, struct file *filp, drm_device_t *dev)
 {
 	int	     minor = iminor(inode);
 	drm_file_t   *priv;
@@ -441,9 +443,3 @@
 }
 EXPORT_SYMBOL(drm_poll);
 
-
-/** No-op. */
-ssize_t drm_read(struct file *filp, char __user *buf, size_t count, loff_t *off)
-{
-	return 0;
-}
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_irq.c.old	2005-01-31 00:18:56.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_irq.c	2005-01-31 00:19:03.000000000 +0100
@@ -89,7 +89,7 @@
  * \c drm_driver_irq_preinstall() and \c drm_driver_irq_postinstall() functions
  * before and after the installation.
  */
-int drm_irq_install( drm_device_t *dev )
+static int drm_irq_install( drm_device_t *dev )
 {
 	int ret;
 	unsigned long sh_flags=0;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_lock.c.old	2005-01-31 00:19:29.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_lock.c	2005-01-31 01:28:35.000000000 +0100
@@ -35,6 +35,11 @@
 
 #include "drmP.h"
 
+static int drm_lock_transfer(drm_device_t *dev,
+			     __volatile__ unsigned int *lock,
+			     unsigned int context);
+static int drm_notifier(void *priv);
+
 /** 
  * Lock ioctl.
  *
@@ -225,8 +230,9 @@
  * Resets the lock file pointer.
  * Marks the lock as held by the given context, via the \p cmpxchg instruction.
  */
-int drm_lock_transfer(drm_device_t *dev,
-		       __volatile__ unsigned int *lock, unsigned int context)
+static int drm_lock_transfer(drm_device_t *dev,
+			     __volatile__ unsigned int *lock,
+			     unsigned int context)
 {
 	unsigned int old, new, prev;
 
@@ -282,7 +288,7 @@
  * \return one if the signal should be delivered normally, or zero if the
  * signal should be blocked.
  */
-int drm_notifier(void *priv)
+static int drm_notifier(void *priv)
 {
 	drm_sigdata_t *s = (drm_sigdata_t *)priv;
 	unsigned int  old, new, prev;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_proc.c.old	2005-01-31 00:20:47.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_proc.c	2005-01-31 00:20:56.000000000 +0100
@@ -57,7 +57,7 @@
 /**
  * Proc file list.
  */
-struct drm_proc_list {
+static struct drm_proc_list {
 	const char *name;	/**< file name */
 	int	   (*f)(char *, char **, off_t, int, int *, void *);	/**< proc callback*/
 } drm_proc_list[] = {
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_vm.c.old	2005-01-31 00:21:17.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_vm.c	2005-01-31 00:22:39.000000000 +0100
@@ -38,6 +38,8 @@
 #include <linux/efi.h>
 #endif
 
+static void drm_vm_close(struct vm_area_struct *vma);
+static void drm_vm_open(struct vm_area_struct *vma);
 
 /**
  * \c nopage method for AGP virtual memory.
@@ -163,7 +165,7 @@
  * Deletes map information if we are the last
  * person to close a mapping and it's not in the global maplist.
  */
-void drm_vm_shm_close(struct vm_area_struct *vma)
+static void drm_vm_shm_close(struct vm_area_struct *vma)
 {
 	drm_file_t	*priv	= vma->vm_file->private_data;
 	drm_device_t	*dev	= priv->dev;
@@ -399,7 +401,7 @@
  * Create a new drm_vma_entry structure as the \p vma private data entry and
  * add it to drm_device::vmalist.
  */
-void drm_vm_open(struct vm_area_struct *vma)
+static void drm_vm_open(struct vm_area_struct *vma)
 {
 	drm_file_t	*priv	= vma->vm_file->private_data;
 	drm_device_t	*dev	= priv->dev;
@@ -428,7 +430,7 @@
  * Search the \p vma private data entry in drm_device::vmalist, unlink it, and
  * free it.
  */
-void drm_vm_close(struct vm_area_struct *vma)
+static void drm_vm_close(struct vm_area_struct *vma)
 {
 	drm_file_t	*priv	= vma->vm_file->private_data;
 	drm_device_t	*dev	= priv->dev;
@@ -463,7 +465,7 @@
  * Sets the virtual memory area operations structure to vm_dma_ops, the file
  * pointer, and calls vm_open().
  */
-int drm_mmap_dma(struct file *filp, struct vm_area_struct *vma)
+static int drm_mmap_dma(struct file *filp, struct vm_area_struct *vma)
 {
 	drm_file_t	 *priv	 = filp->private_data;
 	drm_device_t	 *dev;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_drv.h.old	2005-01-31 00:50:32.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_drv.h	2005-01-31 00:56:14.000000000 +0100
@@ -79,14 +79,6 @@
 } drm_i915_private_t;
 
 				/* i915_dma.c */
-extern int i915_dma_init(DRM_IOCTL_ARGS);
-extern int i915_dma_cleanup(drm_device_t * dev);
-extern int i915_flush_ioctl(DRM_IOCTL_ARGS);
-extern int i915_batchbuffer(DRM_IOCTL_ARGS);
-extern int i915_flip_bufs(DRM_IOCTL_ARGS);
-extern int i915_getparam(DRM_IOCTL_ARGS);
-extern int i915_setparam(DRM_IOCTL_ARGS);
-extern int i915_cmdbuffer(DRM_IOCTL_ARGS);
 extern void i915_kernel_lost_context(drm_device_t * dev);
 extern void i915_driver_pretakedown(drm_device_t *dev);
 extern void i915_driver_prerelease(drm_device_t *dev, DRMFILE filp);
@@ -94,8 +86,6 @@
 /* i915_irq.c */
 extern int i915_irq_emit(DRM_IOCTL_ARGS);
 extern int i915_irq_wait(DRM_IOCTL_ARGS);
-extern int i915_wait_irq(drm_device_t * dev, int irq_nr);
-extern int i915_emit_irq(drm_device_t * dev);
 
 extern irqreturn_t i915_driver_irq_handler(DRM_IRQ_ARGS);
 extern void i915_driver_irq_preinstall(drm_device_t *dev);
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_dma.c.old	2005-01-31 00:50:50.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_dma.c	2005-01-31 00:55:04.000000000 +0100
@@ -12,23 +12,6 @@
 #include "i915_drm.h"
 #include "i915_drv.h"
 
-drm_ioctl_desc_t i915_ioctls[] = {
-	[DRM_IOCTL_NR(DRM_I915_INIT)] = {i915_dma_init, 1, 1},
-	[DRM_IOCTL_NR(DRM_I915_FLUSH)] = {i915_flush_ioctl, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_FLIP)] = {i915_flip_bufs, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_BATCHBUFFER)] = {i915_batchbuffer, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_IRQ_EMIT)] = {i915_irq_emit, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_IRQ_WAIT)] = {i915_irq_wait, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_GETPARAM)] = {i915_getparam, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_SETPARAM)] = {i915_setparam, 1, 1},
-	[DRM_IOCTL_NR(DRM_I915_ALLOC)] = {i915_mem_alloc, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_FREE)] = {i915_mem_free, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_INIT_HEAP)] = {i915_mem_init_heap, 1, 1},
-	[DRM_IOCTL_NR(DRM_I915_CMDBUFFER)] = {i915_cmdbuffer, 1, 0}
-};
-
-int i915_max_ioctl = DRM_ARRAY_SIZE(i915_ioctls);
-
 /* Really want an OS-independent resettable timer.  Would like to have
  * this loop run for (eg) 3 sec, but have the timer reset every time
  * the head pointer changes, so that EBUSY only happens if the ring
@@ -75,7 +58,7 @@
 		dev_priv->sarea_priv->perf_boxes |= I915_BOX_RING_EMPTY;
 }
 
-int i915_dma_cleanup(drm_device_t * dev)
+static int i915_dma_cleanup(drm_device_t * dev)
 {
 	/* Make sure interrupts are disabled here because the uninstall ioctl
 	 * may not have been called from userspace and after dev_private
@@ -227,7 +210,7 @@
 	return 0;
 }
 
-int i915_dma_init(DRM_IOCTL_ARGS)
+static int i915_dma_init(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_i915_private_t *dev_priv;
@@ -538,7 +521,7 @@
 	return i915_wait_ring(dev, dev_priv->ring.Size - 8, __FUNCTION__);
 }
 
-int i915_flush_ioctl(DRM_IOCTL_ARGS)
+static int i915_flush_ioctl(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 
@@ -547,7 +530,7 @@
 	return i915_quiescent(dev);
 }
 
-int i915_batchbuffer(DRM_IOCTL_ARGS)
+static int i915_batchbuffer(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_i915_private_t *dev_priv = (drm_i915_private_t *) dev->dev_private;
@@ -581,7 +564,7 @@
 	return ret;
 }
 
-int i915_cmdbuffer(DRM_IOCTL_ARGS)
+static int i915_cmdbuffer(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_i915_private_t *dev_priv = (drm_i915_private_t *) dev->dev_private;
@@ -617,18 +600,7 @@
 	return 0;
 }
 
-int i915_do_cleanup_pageflip(drm_device_t * dev)
-{
-	drm_i915_private_t *dev_priv = dev->dev_private;
-
-	DRM_DEBUG("%s\n", __FUNCTION__);
-	if (dev_priv->current_page != 0)
-		i915_dispatch_flip(dev);
-
-	return 0;
-}
-
-int i915_flip_bufs(DRM_IOCTL_ARGS)
+static int i915_flip_bufs(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 
@@ -639,7 +611,7 @@
 	return i915_dispatch_flip(dev);
 }
 
-int i915_getparam(DRM_IOCTL_ARGS)
+static int i915_getparam(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_i915_private_t *dev_priv = dev->dev_private;
@@ -674,7 +646,7 @@
 	return 0;
 }
 
-int i915_setparam(DRM_IOCTL_ARGS)
+static int i915_setparam(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_i915_private_t *dev_priv = dev->dev_private;
@@ -723,3 +695,19 @@
 	}
 }
 
+drm_ioctl_desc_t i915_ioctls[] = {
+	[DRM_IOCTL_NR(DRM_I915_INIT)] = {i915_dma_init, 1, 1},
+	[DRM_IOCTL_NR(DRM_I915_FLUSH)] = {i915_flush_ioctl, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_FLIP)] = {i915_flip_bufs, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_BATCHBUFFER)] = {i915_batchbuffer, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_IRQ_EMIT)] = {i915_irq_emit, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_IRQ_WAIT)] = {i915_irq_wait, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_GETPARAM)] = {i915_getparam, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_SETPARAM)] = {i915_setparam, 1, 1},
+	[DRM_IOCTL_NR(DRM_I915_ALLOC)] = {i915_mem_alloc, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_FREE)] = {i915_mem_free, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_INIT_HEAP)] = {i915_mem_init_heap, 1, 1},
+	[DRM_IOCTL_NR(DRM_I915_CMDBUFFER)] = {i915_cmdbuffer, 1, 0}
+};
+
+int i915_max_ioctl = DRM_ARRAY_SIZE(i915_ioctls);
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_drv.c.old	2005-01-31 00:55:25.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_drv.c	2005-01-31 00:55:32.000000000 +0100
@@ -15,7 +15,7 @@
 
 #include "drm_pciids.h"
 
-int postinit( struct drm_device *dev, unsigned long flags )
+static int postinit( struct drm_device *dev, unsigned long flags )
 {
 	dev->counters += 4;
 	dev->types[6] = _DRM_STAT_IRQ;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_irq.c.old	2005-01-31 00:55:58.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_irq.c	2005-01-31 00:56:19.000000000 +0100
@@ -36,7 +36,7 @@
 	return IRQ_HANDLED;
 }
 
-int i915_emit_irq(drm_device_t * dev)
+static int i915_emit_irq(drm_device_t * dev)
 {
 	drm_i915_private_t *dev_priv = dev->dev_private;
 	u32 ret;
@@ -56,7 +56,7 @@
 	return ret;
 }
 
-int i915_wait_irq(drm_device_t * dev, int irq_nr)
+static int i915_wait_irq(drm_device_t * dev, int irq_nr)
 {
 	drm_i915_private_t *dev_priv = (drm_i915_private_t *) dev->dev_private;
 	int ret = 0;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_ds.h.old	2005-01-31 01:15:58.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_ds.h	2005-01-31 01:17:18.000000000 +0100
@@ -101,12 +101,4 @@
  */
 int via_mmFreeMem(PMemBlock b);
 
-/*
- * destroy MM
- */
-void via_mmDestroy(memHeap_t * mmInit);
-
-/* For debugging purpose. */
-void via_mmDumpMemInfo(memHeap_t * mmInit);
-
 #endif
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_ds.c.old	2005-01-31 01:16:09.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_ds.c	2005-01-31 01:24:14.000000000 +0100
@@ -32,7 +32,6 @@
 #include <asm/io.h>
 
 #include "via_ds.h"
-extern unsigned int VIA_DEBUG;
 
 set_t *via_setInit(void)
 {
@@ -126,31 +125,8 @@
 
 #define ISFREE(bptr) ((bptr)->free)
 
-#define PRINTF(fmt, arg...) do{}while(0)
 #define fprintf(fmt, arg...) do{}while(0)
 
-void via_mmDumpMemInfo(memHeap_t * heap)
-{
-	TMemBlock *p;
-
-	PRINTF("Memory heap %p:\n", heap);
-
-	if (heap == 0)
-		PRINTF("  heap == 0\n");
-	else {
-		p = (TMemBlock *) heap;
-
-		while (p) {
-			PRINTF("  Offset:%08x, Size:%08x, %c%c\n", p->ofs,
-			       p->size, p->free ? '.' : 'U',
-			       p->reserved ? 'R' : '.');
-			p = p->next;
-		}
-	}
-
-	PRINTF("End of memory blocks\n");
-}
-
 memHeap_t *via_mmInit(int ofs, int size)
 {
 	PMemBlock blocks;
@@ -169,29 +145,6 @@
 		return 0;
 }
 
-memHeap_t *via_mmAddRange(memHeap_t * heap, int ofs, int size)
-{
-	PMemBlock blocks;
-	blocks = (TMemBlock *) drm_calloc(2, sizeof(TMemBlock), DRM_MEM_DRIVER);
-
-	if (blocks) {
-		blocks[0].size = size;
-		blocks[0].free = 1;
-		blocks[0].ofs = ofs;
-		blocks[0].next = &blocks[1];
-
-		/* Discontinuity - stops JoinBlock from trying to join non-adjacent
-		 * ranges.
-		 */
-		blocks[1].size = 0;
-		blocks[1].free = 0;
-		blocks[1].ofs = ofs + size;
-		blocks[1].next = (PMemBlock) heap;
-		return (memHeap_t *) blocks;
-	} else
-		return heap;
-}
-
 static TMemBlock *SliceBlock(TMemBlock * p,
 			     int startofs, int size,
 			     int reserved, int alignment)
@@ -325,64 +278,3 @@
 	return 0;
 }
 
-int via_mmReserveMem(memHeap_t * heap, int offset, int size)
-{
-	int endofs;
-	TMemBlock *p;
-
-	if (!heap || size <= 0)
-		return -1;
-	endofs = offset + size;
-	p = (TMemBlock *) heap;
-
-	while (p && p->ofs <= offset) {
-		if (ISFREE(p) && endofs <= (p->ofs + p->size)) {
-			SliceBlock(p, offset, size, 1, 1);
-			return 0;
-		}
-		p = p->next;
-	}
-	return -1;
-}
-
-int via_mmFreeReserved(memHeap_t * heap, int offset)
-{
-	TMemBlock *p, *prev;
-
-	if (!heap)
-		return -1;
-
-	p = (TMemBlock *) heap;
-	prev = NULL;
-
-	while (p && p->ofs != offset) {
-		prev = p;
-		p = p->next;
-	}
-
-	if (!p || !p->reserved)
-		return -1;
-	p->free = 1;
-	p->reserved = 0;
-	Join2Blocks(p);
-
-	if (prev)
-		Join2Blocks(prev);
-
-	return 0;
-}
-
-void via_mmDestroy(memHeap_t * heap)
-{
-	TMemBlock *p, *q;
-
-	if (!heap)
-		return;
-	p = (TMemBlock *) heap;
-
-	while (p) {
-		q = p->next;
-		drm_free(p, sizeof(TMemBlock), DRM_MEM_DRIVER);
-		p = q;
-	}
-}
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_drv.h.old	2005-01-31 01:22:30.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_drv.h	2005-01-31 01:23:24.000000000 +0100
@@ -70,7 +70,6 @@
 extern int via_init_context(drm_device_t * dev, int context);
 extern int via_final_context(drm_device_t * dev, int context);
 
-extern int via_do_init_map(drm_device_t * dev, drm_via_init_t * init);
 extern int via_do_cleanup_map(drm_device_t * dev);
 extern int via_map_init(struct inode *inode, struct file *filp,
 			unsigned int cmd, unsigned long arg);
@@ -84,7 +83,6 @@
 extern int via_dma_cleanup(drm_device_t * dev);
 extern void via_init_command_verifier(void);
 extern int via_verify_command_stream(const uint32_t * buf, unsigned int size, drm_device_t *dev);
-extern int via_wait_idle(drm_via_private_t * dev_priv);
 
 
 #endif
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_dma.c.old	2005-01-31 01:22:47.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_dma.c	2005-01-31 01:23:07.000000000 +0100
@@ -37,6 +37,8 @@
 static void via_cmdbuf_reset(drm_via_private_t * dev_priv);
 static void via_cmdbuf_rewind(drm_via_private_t * dev_priv);
 
+static int via_wait_idle(drm_via_private_t * dev_priv);
+
 /*
  * Free space in command buffer.
  */
@@ -483,7 +485,7 @@
 
 
 
-int via_wait_idle(drm_via_private_t * dev_priv)
+static int via_wait_idle(drm_via_private_t * dev_priv)
 {
 	int count = 10000000;
 	while (count-- && (VIA_READ(VIA_REG_STATUS) &
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_map.c.old	2005-01-31 01:23:33.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_map.c	2005-01-31 01:23:38.000000000 +0100
@@ -25,7 +25,7 @@
 #include "via_drm.h"
 #include "via_drv.h"
 
-int via_do_init_map(drm_device_t * dev, drm_via_init_t * init)
+static int via_do_init_map(drm_device_t * dev, drm_via_init_t * init)
 {
 	drm_via_private_t *dev_priv;
 	unsigned int i;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_mm.h.old	2005-01-31 01:24:48.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_mm.h	2005-01-31 01:26:40.000000000 +0100
@@ -37,9 +37,4 @@
 	void *virtual;
 } drm_via_dma_t;
 
-int via_fb_alloc(drm_via_mem_t * mem);
-int via_fb_free(drm_via_mem_t * mem);
-int via_agp_alloc(drm_via_mem_t * mem);
-int via_agp_free(drm_via_mem_t * mem);
-
 #endif
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_mm.c.old	2005-01-31 01:24:25.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_mm.c	2005-01-31 01:26:54.000000000 +0100
@@ -29,8 +29,6 @@
 
 #define MAX_CONTEXT 100
 
-unsigned int VIA_DEBUG = 1;
-
 typedef struct {
 	int used;
 	int context;
@@ -39,6 +37,11 @@
 
 static via_context_t global_ppriv[MAX_CONTEXT];
 
+static int via_agp_alloc(drm_via_mem_t * mem);
+static int via_agp_free(drm_via_mem_t * mem);
+static int via_fb_alloc(drm_via_mem_t * mem);
+static int via_fb_free(drm_via_mem_t * mem);
+
 static int add_alloc_set(int context, int type, unsigned int val)
 {
 	int i, retval = 0;
@@ -204,7 +207,7 @@
 	return -EFAULT;
 }
 
-int via_fb_alloc(drm_via_mem_t * mem)
+static int via_fb_alloc(drm_via_mem_t * mem)
 {
 	drm_via_mm_t fb;
 	PMemBlock block;
@@ -241,7 +244,7 @@
 	return retval;
 }
 
-int via_agp_alloc(drm_via_mem_t * mem)
+static int via_agp_alloc(drm_via_mem_t * mem)
 {
 	drm_via_mm_t agp;
 	PMemBlock block;
@@ -297,7 +300,7 @@
 	return -EFAULT;
 }
 
-int via_fb_free(drm_via_mem_t * mem)
+static int via_fb_free(drm_via_mem_t * mem)
 {
 	drm_via_mm_t fb;
 	int retval = 0;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--- linux-2.6.12-rc2-mm3-full/drivers/char/drm/i830_drv.h.old	2005-04-18 04:00:31.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/drm/i830_drv.h	2005-04-18 04:00:42.000000000 +0200
@@ -123,8 +123,6 @@
 /* i830_dma.c */
 extern void i830_reclaim_buffers(drm_device_t *dev, struct file *filp);
 
-extern int i830_mmap_buffers(struct file *filp, struct vm_area_struct *vma);
-
 /* i830_irq.c */
 extern int i830_irq_emit( struct inode *inode, struct file *filp, 
 			  unsigned int cmd, unsigned long arg );
--- linux-2.6.12-rc2-mm3-full/drivers/char/drm/i830_dma.c.old	2005-04-18 04:00:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/drm/i830_dma.c	2005-04-18 04:01:10.000000000 +0200
@@ -92,16 +92,7 @@
    	return 0;
 }
 
-static struct file_operations i830_buffer_fops = {
-	.open	 = drm_open,
-	.flush	 = drm_flush,
-	.release = drm_release,
-	.ioctl	 = drm_ioctl,
-	.mmap	 = i830_mmap_buffers,
-	.fasync  = drm_fasync,
-};
-
-int i830_mmap_buffers(struct file *filp, struct vm_area_struct *vma)
+static int i830_mmap_buffers(struct file *filp, struct vm_area_struct *vma)
 {
 	drm_file_t	    *priv	  = filp->private_data;
 	drm_device_t	    *dev;
@@ -128,6 +119,15 @@
 	return 0;
 }
 
+static struct file_operations i830_buffer_fops = {
+	.open	 = drm_open,
+	.flush	 = drm_flush,
+	.release = drm_release,
+	.ioctl	 = drm_ioctl,
+	.mmap	 = i830_mmap_buffers,
+	.fasync  = drm_fasync,
+};
+
 static int i830_map_buffer(drm_buf_t *buf, struct file *filp)
 {
 	drm_file_t	  *priv	  = filp->private_data;
--- linux-2.6.12-rc2-mm3-full/drivers/char/drm/i830_drv.c.old	2005-04-18 04:01:36.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/drm/i830_drv.c	2005-04-18 04:01:44.000000000 +0200
@@ -40,7 +40,7 @@
 
 #include "drm_pciids.h"
 
-int postinit( struct drm_device *dev, unsigned long flags )
+static int postinit( struct drm_device *dev, unsigned long flags )
 {
 	dev->counters += 4;
 	dev->types[6] = _DRM_STAT_IRQ;
--- linux-2.6.12-rc2-mm3-full/drivers/char/drm/i830_irq.c.old	2005-04-18 04:03:24.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/drm/i830_irq.c	2005-04-18 04:03:45.000000000 +0200
@@ -55,7 +55,7 @@
 }
 
 
-int i830_emit_irq(drm_device_t *dev)
+static int i830_emit_irq(drm_device_t *dev)
 {
 	drm_i830_private_t *dev_priv = dev->dev_private;
 	RING_LOCALS;
@@ -73,7 +73,7 @@
 }
 
 
-int i830_wait_irq(drm_device_t *dev, int irq_nr)
+static int i830_wait_irq(drm_device_t *dev, int irq_nr)
 {
   	drm_i830_private_t *dev_priv = 
 	   (drm_i830_private_t *)dev->dev_private;

