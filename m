Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbUJ0NEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbUJ0NEg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUJ0NEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:04:36 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:38879 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262423AbUJ0NAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:00:30 -0400
Date: Wed, 27 Oct 2004 14:00:28 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, jonsmirl@gmail.com
Subject: [rfc] [bk tree] DRM 2.6 for -mm
Message-ID: <Pine.LNX.4.58.0410271351570.17741@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I'm getting ready to port the drm core split to the kernel, I've put two
ground work patches in my bk://drm.bkbits.net/drm-2.6 tree,

These patches are ground work, the core tree fixes up the DRM for a lot of
2.6 features and removes the inter module stuff and old module parameters
(i.e. don't shout about the old macros and code being used we can't fix it
all in one go and not break it...)

The minor number handling is a lot better with this code, multiple cards
work a lot better, and it isn't as horrid as the old stub stuff..

So please review the patch below and if no-one has any major objections
I'll push these to Linus for a start, I'll probably add some more patches
to 2.6 tree over the next day or two.. (Andrew are you still taking this
tree? you can drop the -via tree if you want for now, as I'm still not
happy we've resolved all the issues with it..)

Dave.

 drivers/char/drm/drmP.h             |   51 +++++
 drivers/char/drm/drm_drv.h          |  186 ++++++++++-----------
 drivers/char/drm/drm_irq.h          |    4
 drivers/char/drm/drm_memory.h       |   20 --
 drivers/char/drm/drm_memory_debug.h |    2
 drivers/char/drm/drm_os_linux.h     |    5
 drivers/char/drm/drm_proc.h         |   20 --
 drivers/char/drm/drm_stub.h         |  308 ++++++++++++++++++++----------------
 drivers/char/drm/i915_mem.c         |   20 +-
 drivers/char/drm/r128_state.c       |   84 ++++-----
 drivers/char/drm/radeon_mem.c       |   20 +-
 drivers/char/drm/radeon_state.c     |    3
 12 files changed, 382 insertions(+), 341 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/10/27 1.2026.3.2)
   drm: device minor fixups and /proc fixups

   This patch fixes up the DRM to do better minor number accounting
   and /proc directory creation, the old code was buggy in a number
   of situations with multiple cards, and rather ugly. It is also
   a step on the way to the drm_core module.

   From: Jon Smirl and Dave Airlie
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/10/24 1.2026.3.1)
   drm: memory allocation patch

   This removes some unnecessary macros for allocating DRM memory.
   It doesn't change any functionality.

   From: Jon Smirl <jonsmirl@gmail.com>
   Signed-off-by: Dave Airlie <airlied@linux.ie>
diff -Nru a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
--- a/drivers/char/drm/drmP.h	2004-10-27 22:54:10 +10:00
+++ b/drivers/char/drm/drmP.h	2004-10-27 22:54:10 +10:00
@@ -34,6 +34,8 @@
 #ifndef _DRM_P_H_
 #define _DRM_P_H_

+/* If you want the memory alloc debug functionality, change define below */
+/* #define DEBUG_MEMORY */

 #ifdef __KERNEL__
 #ifdef __alpha__
@@ -55,6 +57,7 @@
 #include <linux/jiffies.h>
 #include <linux/smp_lock.h>	/* For (un)lock_kernel */
 #include <linux/mm.h>
+#include <linux/cdev.h>
 #if defined(__alpha__) || defined(__powerpc__)
 #include <asm/pgtable.h> /* For pte_wrprotect */
 #endif
@@ -693,12 +696,31 @@
 	drm_sigdata_t     sigdata; /**< For block_all_signals */
 	sigset_t          sigmask;

+	struct file_operations *fops;	/**< file operations */
+	struct proc_dir_entry  *dev_root; /**< proc directory entry */
+
 	struct            drm_driver_fn fn_tbl;
 	drm_local_map_t   *agp_buffer_map;
 	int               dev_priv_size;
 	u32               driver_features;
 } drm_device_t;

+typedef struct drm_minor {
+	enum {
+		DRM_MINOR_FREE = 0,
+		DRM_MINOR_PRIMARY,
+	} type;
+	drm_device_t *dev;
+	struct proc_dir_entry  *dev_root; /**< proc directory entry */
+} drm_minor_t;
+
+typedef struct drm_global {
+	unsigned int cards_limit;
+	drm_minor_t *minors;
+	struct class_simple *drm_class;
+	struct proc_dir_entry *proc_root;
+} drm_global_t;
+
 static __inline__ int drm_core_check_feature(struct drm_device *dev, int feature)
 {
 	return ((dev->driver_features & feature) ? 1 : 0);
@@ -765,11 +787,9 @@
 extern void	     DRM(mem_init)(void);
 extern int	     DRM(mem_info)(char *buf, char **start, off_t offset,
 				   int request, int *eof, void *data);
-extern void	     *DRM(alloc)(size_t size, int area);
 extern void	     *DRM(calloc)(size_t nmemb, size_t size, int area);
 extern void	     *DRM(realloc)(void *oldpt, size_t oldsize, size_t size,
 				   int area);
-extern void	     DRM(free)(void *pt, size_t size, int area);
 extern unsigned long DRM(alloc_pages)(int order, int area);
 extern void	     DRM(free_pages)(unsigned long address, int order,
 				     int area);
@@ -921,13 +941,12 @@
 extern int            DRM(agp_unbind_memory)(DRM_AGP_MEM *handle);

 				/* Stub support (drm_stub.h) */
-int                   DRM(stub_register)(const char *name,
-					 struct file_operations *fops,
-					 drm_device_t *dev);
-int                   DRM(stub_unregister)(int minor);
+extern int 	      DRM(probe)(struct pci_dev *pdev, const struct pci_device_id *ent);
+extern int 	      DRM(put_minor)(drm_device_t *dev);
+extern drm_global_t   *DRM(global);

 				/* Proc support (drm_proc.h) */
-extern struct proc_dir_entry *DRM(proc_init)(drm_device_t *dev,
+extern int            DRM(proc_init)(drm_device_t *dev,
 					     int minor,
 					     struct proc_dir_entry *root,
 					     struct proc_dir_entry **dev_root);
@@ -984,6 +1003,24 @@
 static __inline__ void drm_core_dropmap(struct drm_map *map)
 {
 }
+
+#ifndef DEBUG_MEMORY
+/** Wrapper around kmalloc() */
+static __inline__ void *DRM(alloc)(size_t size, int area)
+{
+	return kmalloc(size, GFP_KERNEL);
+}
+
+/** Wrapper around kfree() */
+static __inline__ void DRM(free)(void *pt, size_t size, int area)
+{
+	kfree(pt);
+}
+#else
+extern void *DRM(alloc)(size_t size, int area);
+extern void DRM(free)(void *pt, size_t size, int area);
+#endif
+
 /*@}*/

 extern unsigned long DRM(core_get_map_ofs)(drm_map_t *map);
diff -Nru a/drivers/char/drm/drm_drv.h b/drivers/char/drm/drm_drv.h
--- a/drivers/char/drm/drm_drv.h	2004-10-27 22:54:10 +10:00
+++ b/drivers/char/drm/drm_drv.h	2004-10-27 22:54:10 +10:00
@@ -74,10 +74,6 @@
 #undef DRM_OPTIONS_FUNC
 #endif

-#define MAX_DEVICES 4
-static drm_device_t	DRM(device)[MAX_DEVICES];
-static int		DRM(numdevs) = 0;
-
 struct file_operations	DRM(fops) = {
 	.owner   = THIS_MODULE,
 	.open	 = DRM(open),
@@ -158,15 +154,6 @@

 #define DRIVER_IOCTL_COUNT	DRM_ARRAY_SIZE( DRM(ioctls) )

-#ifdef MODULE
-static char *drm_opts = NULL;
-#endif
-
-MODULE_AUTHOR( DRIVER_AUTHOR );
-MODULE_DESCRIPTION( DRIVER_DESC );
-MODULE_PARM( drm_opts, "s" );
-MODULE_LICENSE("GPL and additional rights");
-
 static int DRM(setup)( drm_device_t *dev )
 {
 	int i;
@@ -420,44 +407,19 @@
 	DRM(PCI_IDS)
 };

-static int DRM(probe)(struct pci_dev *pdev)
+int DRM(fill_in_dev)(drm_device_t *dev, struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	drm_device_t *dev;
 	int retcode;
-	int i;
-	int is_compat = 0;
-
-	DRM_DEBUG( "\n" );
-
-	for (i = 0; DRM(pciidlist)[i].vendor != 0; i++) {
-		if ((DRM(pciidlist)[i].vendor == pdev->vendor) &&
-		    (DRM(pciidlist)[i].device == pdev->device)) {
-			is_compat = 1;
-		}
-	}
-	if (is_compat == 0)
-		return -ENODEV;
-
-	if (DRM(numdevs) >= MAX_DEVICES)
-		return -ENODEV;

-	if ((retcode=pci_enable_device(pdev)))
-		return retcode;
-
-	dev = &(DRM(device)[DRM(numdevs)]);
-
-	memset( (void *)dev, 0, sizeof(*dev) );
 	dev->count_lock = SPIN_LOCK_UNLOCKED;
 	init_timer( &dev->timer );
 	sema_init( &dev->struct_sem, 1 );
 	sema_init( &dev->ctxlist_sem, 1 );

-	if ((dev->minor = DRM(stub_register)(DRIVER_NAME, &DRM(fops),dev)) < 0)
-		return -EPERM;
-	dev->device = MKDEV(DRM_MAJOR, dev->minor );
 	dev->name   = DRIVER_NAME;
-
+	dev->fops   = &DRM(fops);
 	dev->pdev   = pdev;
+
 #ifdef __alpha__
 	dev->hose   = pdev->sysdata;
 	dev->pci_domain = dev->hose->bus->number;
@@ -486,16 +448,15 @@
 	DRM(driver_register_fns)(dev);

 	if (dev->fn_tbl.preinit)
-	  dev->fn_tbl.preinit(dev);
+		if ((retcode = dev->fn_tbl.preinit(dev)))
+			goto error_out_unreg;

-	if (drm_core_has_AGP(dev))
-	{
+	if (drm_core_has_AGP(dev)) {
 		dev->agp = DRM(agp_init)();
 		if (drm_core_check_feature(dev, DRIVER_REQUIRE_AGP) && (dev->agp == NULL)) {
 			DRM_ERROR( "Cannot initialize the agpgart module.\n" );
-			DRM(stub_unregister)(dev->minor);
-			DRM(takedown)( dev );
-			return -EINVAL;
+			retcode = -EINVAL;
+			goto error_out_unreg;
 		}
 		if (drm_core_has_MTRR(dev)) {
 			if (dev->agp)
@@ -509,13 +470,11 @@
 	retcode = DRM(ctxbitmap_init)( dev );
 	if( retcode ) {
 		DRM_ERROR( "Cannot allocate memory for context bitmap.\n" );
-		DRM(stub_unregister)(dev->minor);
-		DRM(takedown)( dev );
-		return retcode;
+		goto error_out_unreg;
 	}

-	DRM(numdevs)++; /* no errors, mark it reserved */
-
+	dev->device = MKDEV(DRM_MAJOR, dev->minor );
+
 	DRM_INFO( "Initialized %s %d.%d.%d %s on minor %d: %s\n",
 		DRIVER_NAME,
 		DRIVER_MAJOR,
@@ -526,11 +485,21 @@
 		pci_pretty_name(pdev));

 	if (dev->fn_tbl.postinit)
-	  dev->fn_tbl.postinit(dev);
+		if ((retcode = dev->fn_tbl.postinit(dev)))
+			goto error_out_unreg;

 	return 0;
+
+error_out_unreg:
+	DRM(takedown)(dev);
+	return retcode;
 }

+#ifdef MODULE
+static char *drm_opts = NULL;
+#endif
+MODULE_PARM( drm_opts, "s" );
+
 /**
  * Module initialization. Called via init_module at module load time, or via
  * linux/init/main.c (this is not currently supported).
@@ -547,6 +516,8 @@
 static int __init drm_init( void )
 {
 	struct pci_dev *pdev = NULL;
+	struct pci_device_id *pid;
+	int i;

 	DRM_DEBUG( "\n" );

@@ -556,8 +527,16 @@

 	DRM(mem_init)();

-	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
-		DRM(probe)(pdev);
+	for (i=0; DRM(pciidlist)[i].vendor != 0; i++) {
+		pid = &DRM(pciidlist[i]);
+
+		pdev=NULL;
+		/* pass back in pdev to account for multiple identical cards */
+		while ((pdev = pci_get_subsys(pid->vendor, pid->device, pid->subvendor, pid->subdevice, pdev)) != NULL) {
+			/* stealth mode requires a manual probe */
+			pci_dev_get(pdev);
+			DRM(probe)(pdev, pid);
+		}
 	}
 	return 0;
 }
@@ -569,52 +548,68 @@
  *
  * \sa drm_init().
  */
-static void __exit drm_cleanup( void )
+static void __exit drm_cleanup( drm_device_t *dev )
 {
-	drm_device_t *dev;
-	int i;
-
 	DRM_DEBUG( "\n" );

-	for (i = DRM(numdevs) - 1; i >= 0; i--) {
-		dev = &(DRM(device)[i]);
-		if ( DRM(stub_unregister)(dev->minor) ) {
-			DRM_ERROR( "Cannot unload module\n" );
-		} else {
-			DRM_DEBUG("minor %d unregistered\n", dev->minor);
-			if (i == 0) {
-				DRM_INFO( "Module unloaded\n" );
-			}
-		}
+	if (!dev) {
+		DRM_ERROR("cleanup called no dev\n");
+		return;
+	}

-		DRM(ctxbitmap_cleanup)( dev );
+	DRM(takedown)( dev );

-		if (drm_core_has_MTRR(dev) && drm_core_has_AGP(dev) &&
-		    dev->agp && dev->agp->agp_mtrr >= 0) {
-			int retval;
-			retval = mtrr_del( dev->agp->agp_mtrr,
+	DRM(ctxbitmap_cleanup)( dev );
+
+	if (drm_core_has_MTRR(dev) && drm_core_has_AGP(dev) &&
+	    dev->agp && dev->agp->agp_mtrr >= 0) {
+		int retval;
+		retval = mtrr_del( dev->agp->agp_mtrr,
 				   dev->agp->agp_info.aper_base,
 				   dev->agp->agp_info.aper_size*1024*1024 );
-			DRM_DEBUG( "mtrr_del=%d\n", retval );
-		}
+		DRM_DEBUG( "mtrr_del=%d\n", retval );
+	}
+
+	if (drm_core_has_AGP(dev) && dev->agp ) {
+		DRM(agp_uninit)();
+		DRM(free)( dev->agp, sizeof(*dev->agp), DRM_MEM_AGPLISTS );
+		dev->agp = NULL;
+	}

-		DRM(takedown)( dev );
+	if (dev->fn_tbl.postcleanup)
+		dev->fn_tbl.postcleanup(dev);
+
+	if ( DRM(put_minor)(dev) )
+		DRM_ERROR( "Cannot unload module\n" );
+}

-		if (drm_core_has_AGP(dev) && dev->agp ) {
-			DRM(agp_uninit)();
-			DRM(free)( dev->agp, sizeof(*dev->agp), DRM_MEM_AGPLISTS );
-			dev->agp = NULL;
-		}

-		if (dev->fn_tbl.postcleanup)
-		  dev->fn_tbl.postcleanup(dev);
+static void __exit drm_exit (void)
+{
+	int i;
+	drm_device_t *dev;
+	drm_minor_t *minor;
+
+	DRM_DEBUG( "\n" );

-	}
-	DRM(numdevs) = 0;
+	if (DRM(global)) {
+		for (i = 0; DRM(global) && (i < DRM(global)->cards_limit); i++) {
+			minor = &DRM(global)->minors[i];
+			dev = minor->dev;
+
+			if ((minor->type == DRM_MINOR_PRIMARY) && (dev->fops == &DRM(fops))) {
+				/* release the pci driver */
+				if (dev->pdev)
+					pci_dev_put(dev->pdev);
+				drm_cleanup(dev);
+			}
+		}
+	}
+	DRM_INFO( "Module unloaded\n" );
 }

 module_init( drm_init );
-module_exit( drm_cleanup );
+module_exit( drm_exit );


 /**
@@ -674,19 +669,16 @@
 int DRM(open)( struct inode *inode, struct file *filp )
 {
 	drm_device_t *dev = NULL;
+	int minor = iminor(inode);
 	int retcode = 0;
-	int i;

-	for (i = 0; i < DRM(numdevs); i++) {
-		if (iminor(inode) == DRM(device)[i].minor) {
-			dev = &(DRM(device)[i]);
-			break;
-		}
-	}
-	if (!dev) {
+	if (!((minor >= 0) && (minor < DRM(global)->cards_limit)))
 		return -ENODEV;
-	}
-
+
+	dev = DRM(global)->minors[minor].dev;
+	if (!dev)
+		return -ENODEV;
+
 	retcode = DRM(open_helper)( inode, filp, dev );
 	if ( !retcode ) {
 		atomic_inc( &dev->counts[_DRM_STAT_OPENS] );
diff -Nru a/drivers/char/drm/drm_irq.h b/drivers/char/drm/drm_irq.h
--- a/drivers/char/drm/drm_irq.h	2004-10-27 22:54:10 +10:00
+++ b/drivers/char/drm/drm_irq.h	2004-10-27 22:54:10 +10:00
@@ -300,7 +300,7 @@

 		spin_unlock_irqrestore( &dev->vbl_lock, irqflags );

-		if ( !( vbl_sig = DRM_MALLOC( sizeof( drm_vbl_sig_t ) ) ) ) {
+		if ( !( vbl_sig = DRM(alloc)( sizeof( drm_vbl_sig_t ), DRM_MEM_DRIVER ) ) ) {
 			return -ENOMEM;
 		}

@@ -356,7 +356,7 @@

 			list_del( list );

-			DRM_FREE( vbl_sig, sizeof(*vbl_sig) );
+			DRM(free)( vbl_sig, sizeof(*vbl_sig), DRM_MEM_DRIVER );

 			dev->vbl_pending--;
 		}
diff -Nru a/drivers/char/drm/drm_memory.h b/drivers/char/drm/drm_memory.h
--- a/drivers/char/drm/drm_memory.h	2004-10-27 22:54:10 +10:00
+++ b/drivers/char/drm/drm_memory.h	2004-10-27 22:54:10 +10:00
@@ -39,10 +39,8 @@

 /**
  * Cut down version of drm_memory_debug.h, which used to be called
- * drm_memory.h.  If you want the debug functionality, change 0 to 1
- * below.
+ * drm_memory.h.
  */
-#define DEBUG_MEMORY 0

 #if __OS_HAS_AGP

@@ -197,7 +195,7 @@
 }


-#if DEBUG_MEMORY
+#ifdef DEBUG_MEMORY
 #include "drm_memory_debug.h"
 #else

@@ -226,13 +224,7 @@
 }

 /** Wrapper around kmalloc() */
-void *DRM(alloc)(size_t size, int area)
-{
-	return kmalloc(size, GFP_KERNEL);
-}
-
-/** Wrapper around kmalloc() */
-void *DRM(calloc)(size_t size, size_t nmemb, int area)
+void *DRM(calloc)(size_t nmemb, size_t size, int area)
 {
 	void *addr;

@@ -254,12 +246,6 @@
 		kfree(oldpt);
 	}
 	return pt;
-}
-
-/** Wrapper around kfree() */
-void DRM(free)(void *pt, size_t size, int area)
-{
-	kfree(pt);
 }

 /**
diff -Nru a/drivers/char/drm/drm_memory_debug.h b/drivers/char/drm/drm_memory_debug.h
--- a/drivers/char/drm/drm_memory_debug.h	2004-10-27 22:54:10 +10:00
+++ b/drivers/char/drm/drm_memory_debug.h	2004-10-27 22:54:10 +10:00
@@ -167,7 +167,7 @@
 	return pt;
 }

-void *DRM(calloc)(size_t size, size_t nmemb, int area)
+void *DRM(calloc)(size_t nmemb, size_t size, int area)
 {
 	void *addr;

diff -Nru a/drivers/char/drm/drm_os_linux.h b/drivers/char/drm/drm_os_linux.h
--- a/drivers/char/drm/drm_os_linux.h	2004-10-27 22:54:10 +10:00
+++ b/drivers/char/drm/drm_os_linux.h	2004-10-27 22:54:10 +10:00
@@ -100,11 +100,6 @@
 	__put_user(val, uaddr)


-/** 'malloc' without the overhead of DRM(alloc)() */
-#define DRM_MALLOC(x) kmalloc(x, GFP_KERNEL)
-/** 'free' without the overhead of DRM(free)() */
-#define DRM_FREE(x,size) kfree(x)
-
 #define DRM_GET_PRIV_WITH_RETURN(_priv, _filp) _priv = _filp->private_data

 /**
diff -Nru a/drivers/char/drm/drm_proc.h b/drivers/char/drm/drm_proc.h
--- a/drivers/char/drm/drm_proc.h	2004-10-27 22:54:10 +10:00
+++ b/drivers/char/drm/drm_proc.h	2004-10-27 22:54:10 +10:00
@@ -86,25 +86,19 @@
  * "/proc/dri/%minor%/", and each entry in proc_list as
  * "/proc/dri/%minor%/%name%".
  */
-struct proc_dir_entry *DRM(proc_init)(drm_device_t *dev, int minor,
-				      struct proc_dir_entry *root,
-				      struct proc_dir_entry **dev_root)
+int DRM(proc_init)(drm_device_t *dev, int minor,
+		    struct proc_dir_entry *root,
+		    struct proc_dir_entry **dev_root)
 {
 	struct proc_dir_entry *ent;
 	int		      i, j;
 	char                  name[64];

-	if (!minor) root = create_proc_entry("dri", S_IFDIR, NULL);
-	if (!root) {
-		DRM_ERROR("Cannot create /proc/dri\n");
-		return NULL;
-	}
-
 	sprintf(name, "%d", minor);
 	*dev_root = create_proc_entry(name, S_IFDIR, root);
 	if (!*dev_root) {
 		DRM_ERROR("Cannot create /proc/dri/%s\n", name);
-		return NULL;
+		return -1;
 	}

 	for (i = 0; i < DRM_PROC_ENTRIES; i++) {
@@ -117,14 +111,13 @@
 				remove_proc_entry(DRM(proc_list)[i].name,
 						  *dev_root);
 			remove_proc_entry(name, root);
-			if (!minor) remove_proc_entry("dri", NULL);
-			return NULL;
+			return -1;
 		}
 		ent->read_proc = DRM(proc_list)[i].f;
 		ent->data      = dev;
 	}

-	return root;
+	return 0;
 }


@@ -150,7 +143,6 @@
 		remove_proc_entry(DRM(proc_list)[i].name, dev_root);
 	sprintf(name, "%d", minor);
 	remove_proc_entry(name, root);
-	if (!minor) remove_proc_entry("dri", NULL);

 	return 0;
 }
diff -Nru a/drivers/char/drm/drm_stub.h b/drivers/char/drm/drm_stub.h
--- a/drivers/char/drm/drm_stub.h	2004-10-27 22:54:10 +10:00
+++ b/drivers/char/drm/drm_stub.h	2004-10-27 22:54:10 +10:00
@@ -33,25 +33,19 @@

 #include "drmP.h"

-#define DRM_STUB_MAXCARDS 16	/* Enough for one machine */
+static unsigned int cards_limit = 16;	/* Enough for one machine */
+static unsigned int debug = 0;		/* 1 to enable debug output */

-static struct class_simple *drm_class;
+MODULE_AUTHOR( DRIVER_AUTHOR );
+MODULE_DESCRIPTION( DRIVER_DESC );
+MODULE_LICENSE("GPL and additional rights");
+MODULE_PARM_DESC(cards_limit, "Maximum number of graphics cards");
+MODULE_PARM_DESC(debug, "Enable debug output");

-/** Stub list. One for each minor. */
-static struct drm_stub_list {
-	const char             *name;
-	struct file_operations *fops;	/**< file operations */
-	struct proc_dir_entry  *dev_root;	/**< proc directory entry */
-} *DRM(stub_list);
-
-static struct proc_dir_entry *DRM(stub_root);
-
-/** Stub information */
-static struct drm_stub_info {
-	int (*info_register)(const char *name, struct file_operations *fops,
-			     drm_device_t *dev);
-	int (*info_unregister)(int minor);
-} DRM(stub_info);
+module_param(cards_limit, int, 0444);
+module_param(debug, int, 0666);
+
+drm_global_t *DRM(global);

 /**
  * File \c open operation.
@@ -59,18 +53,27 @@
  * \param inode device inode.
  * \param filp file pointer.
  *
- * Puts the drm_stub_list::fops corresponding to the device minor number into
+ * Puts the dev->fops corresponding to the device minor number into
  * \p filp, call the \c open method, and restore the file operations.
  */
-static int DRM(stub_open)(struct inode *inode, struct file *filp)
+static int stub_open(struct inode *inode, struct file *filp)
 {
-	int                    minor = iminor(inode);
-	int                    err   = -ENODEV;
+	drm_device_t *dev = NULL;
+	int minor = iminor(inode);
+	int err = -ENODEV;
 	struct file_operations *old_fops;
+
+	DRM_DEBUG("\n");
+
+	if (!((minor >= 0) && (minor < DRM(global)->cards_limit)))
+		return -ENODEV;

-	if (!DRM(stub_list) || !DRM(stub_list)[minor].fops) return -ENODEV;
-	old_fops   = filp->f_op;
-	filp->f_op = fops_get(DRM(stub_list)[minor].fops);
+	dev = DRM(global)->minors[minor].dev;
+	if (!dev)
+		return -ENODEV;
+
+	old_fops = filp->f_op;
+	filp->f_op = fops_get(dev->fops);
 	if (filp->f_op->open && (err = filp->f_op->open(inode, filp))) {
 		fops_put(filp->f_op);
 		filp->f_op = fops_get(old_fops);
@@ -83,48 +86,72 @@
 /** File operations structure */
 static struct file_operations DRM(stub_fops) = {
 	.owner = THIS_MODULE,
-	.open  = DRM(stub_open)
+	.open  = stub_open
 };

 /**
  * Get a device minor number.
  *
- * \param name driver name.
- * \param fops file operations.
- * \param dev DRM device.
- * \return minor number on success, or a negative number on failure.
- *
- * Allocate and initialize ::stub_list if one doesn't exist already.  Search an
- * empty entry and initialize it to the given parameters, and create the proc
- * init entry via proc_init().
+ * \param pdev PCI device structure
+ * \param ent entry from the PCI ID table with device type flags
+ * \return negative number on failure.
+ *
+ * Search an empty entry and initialize it to the given parameters, and
+ * create the proc init entry via proc_init().
  */
-static int DRM(stub_getminor)(const char *name, struct file_operations *fops,
-			      drm_device_t *dev)
+static int get_minor(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	int i;
+	struct class_device *dev_class;
+	drm_device_t *dev;
+	int ret;
+	int minor;
+	drm_minor_t *minors = &DRM(global)->minors[0];

-	if (!DRM(stub_list)) {
-		DRM(stub_list) = DRM(alloc)(sizeof(*DRM(stub_list))
-					    * DRM_STUB_MAXCARDS, DRM_MEM_STUB);
-		if(!DRM(stub_list)) return -1;
-		for (i = 0; i < DRM_STUB_MAXCARDS; i++) {
-			DRM(stub_list)[i].name = NULL;
-			DRM(stub_list)[i].fops = NULL;
-		}
-	}
-	for (i = 0; i < DRM_STUB_MAXCARDS; i++) {
-		if (!DRM(stub_list)[i].fops) {
-			DRM(stub_list)[i].name = name;
-			DRM(stub_list)[i].fops = fops;
-			DRM(stub_root) = DRM(proc_init)(dev, i, DRM(stub_root),
-							&DRM(stub_list)[i]
-							.dev_root);
-			class_simple_device_add(drm_class, MKDEV(DRM_MAJOR, i), NULL, name);
-			return i;
+	DRM_DEBUG("\n");
+
+	for (minor=0; minor<DRM(global)->cards_limit; minor++, minors++) {
+		if (minors->type == DRM_MINOR_FREE) {
+
+			DRM_DEBUG("assigning minor %d\n", minor);
+			dev = DRM(calloc)(1, sizeof(*dev), DRM_MEM_STUB);
+			if (!dev)
+				return -ENOMEM;
+
+			*minors = (drm_minor_t){.dev = dev, .type=DRM_MINOR_PRIMARY};
+			dev->minor = minor;
+			if ((ret=DRM(fill_in_dev)(dev, pdev, ent))) {
+				printk(KERN_ERR "DRM: Fill_in_dev failed.\n");
+				goto err_g1;
+			}
+			if ((ret = DRM(proc_init)(dev, minor, DRM(global)->proc_root, &dev->dev_root))) {
+				printk (KERN_ERR "DRM: Failed to initialize /proc/dri.\n");
+				goto err_g1;
+			}
+
+			pci_enable_device(pdev);
+
+			dev_class = class_simple_device_add(DRM(global)->drm_class,
+							    MKDEV(DRM_MAJOR, minor), &pdev->dev, "card%d", minor);
+			if (IS_ERR(dev_class)) {
+				printk(KERN_ERR "DRM: Error class_simple_device_add.\n");
+				ret = PTR_ERR(dev_class);
+				goto err_g2;
+			}
+
+			DRM_DEBUG("new minor assigned %d\n", minor);
+			return 0;
 		}
 	}
-	return -1;
+	DRM_ERROR("out of minors\n");
+	return -ENOMEM;
+err_g2:
+	DRM(proc_cleanup)(minor, DRM(global)->proc_root, minors->dev_root);
+err_g1:
+	*minors = (drm_minor_t){.dev = NULL, .type = DRM_MINOR_FREE};
+	DRM(free)(dev, sizeof(*dev), DRM_MEM_STUB);
+	return ret;
 }
+

 /**
  * Put a device minor number.
@@ -136,101 +163,112 @@
  * "drm" data, otherwise unregisters the "drm" data, frees the stub list and
  * unregisters the character device.
  */
-static int DRM(stub_putminor)(int minor)
+int DRM(put_minor)(drm_device_t *dev)
 {
-	if (minor < 0 || minor >= DRM_STUB_MAXCARDS) return -1;
-	DRM(stub_list)[minor].name = NULL;
-	DRM(stub_list)[minor].fops = NULL;
-	DRM(proc_cleanup)(minor, DRM(stub_root),
-			  DRM(stub_list)[minor].dev_root);
-	if (minor) {
-		class_simple_device_remove(MKDEV(DRM_MAJOR, minor));
-		inter_module_put("drm");
-	} else {
-		inter_module_unregister("drm");
-		DRM(free)(DRM(stub_list),
-			  sizeof(*DRM(stub_list)) * DRM_STUB_MAXCARDS,
-			  DRM_MEM_STUB);
-		unregister_chrdev(DRM_MAJOR, "drm");
-		class_simple_device_remove(MKDEV(DRM_MAJOR, minor));
-		class_simple_destroy(drm_class);
+	drm_minor_t *minors = &DRM(global)->minors[dev->minor];
+	int i;
+
+	DRM_DEBUG("release minor %d\n", dev->minor);
+
+	DRM(proc_cleanup)(dev->minor, DRM(global)->proc_root, dev->dev_root);
+	class_simple_device_remove(MKDEV(DRM_MAJOR, dev->minor));
+
+	*minors = (drm_minor_t){.dev = NULL, .type = DRM_MINOR_FREE};
+	DRM(free)(dev, sizeof(*dev), DRM_MEM_STUB);
+
+	/* if any device pointers are non-NULL we are not the last module */
+	for (i=0; i<DRM(global)->cards_limit; i++) {
+		if (DRM(global)->minors[i].type != DRM_MINOR_FREE) {
+			DRM_DEBUG("inter_module_put called\n");
+			inter_module_put("drm");
+			return 0;
+		}
 	}
+	DRM_DEBUG("unregistering inter_module.\n");
+	inter_module_unregister("drm");
+	remove_proc_entry("dri", NULL);
+	class_simple_destroy(DRM(global)->drm_class);
+
+	unregister_chrdev(DRM_MAJOR, "drm");
+	DRM(free)(DRM(global)->minors, sizeof(*DRM(global)->minors) *
+		  DRM(global)->cards_limit, DRM_MEM_STUB);
+	DRM(free)(DRM(global), sizeof(*DRM(global)), DRM_MEM_STUB);
+	DRM(global) = NULL;
+
 	return 0;
 }

 /**
  * Register.
  *
- * \param name driver name.
- * \param fops file operations
- * \param dev DRM device.
+ * \param pdev - PCI device structure
+ * \param ent entry from the PCI ID table with device type flags
  * \return zero on success or a negative number on failure.
  *
- * Attempt to register the char device and get the foreign "drm" data. If
- * successful then another module already registered so gets the stub info,
- * otherwise use this module stub info and make it available for other modules.
- *
- * Finally calls stub_info::info_register.
+ * Attempt to gets inter module "drm" information. If we are first
+ * then register the character device and inter module information.
+ * Try and register, if we fail to register, backout previous work.
  */
-int DRM(stub_register)(const char *name, struct file_operations *fops,
-		       drm_device_t *dev)
+int DRM(probe)(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	struct drm_stub_info *i = NULL;
-	int ret1;
-	int ret2;
+	drm_global_t *global;
+	int ret = -ENOMEM;

 	DRM_DEBUG("\n");
-	ret1 = register_chrdev(DRM_MAJOR, "drm", &DRM(stub_fops));
-	if (!ret1) {
-		drm_class = class_simple_create(THIS_MODULE, "drm");
-		if (IS_ERR(drm_class)) {
-			printk (KERN_ERR "Error creating drm class.\n");
-			unregister_chrdev(DRM_MAJOR, "drm");
-			return PTR_ERR(drm_class);
+
+	/* use the inter_module_get to check - as if the same module
+		registers chrdev twice it succeeds */
+	global = (drm_global_t *)inter_module_get("drm");
+	if (global) {
+		DRM(global) = global;
+		global = NULL;
+	} else {
+		DRM_DEBUG("first probe\n");
+
+		global = DRM(calloc)(1, sizeof(*global), DRM_MEM_STUB);
+		if(!global)
+			return -ENOMEM;
+
+		global->cards_limit = (cards_limit < DRM_MAX_MINOR + 1 ? cards_limit : DRM_MAX_MINOR + 1);
+		global->minors = DRM(calloc)(global->cards_limit,
+					sizeof(*global->minors), DRM_MEM_STUB);
+		if(!global->minors)
+			goto err_p1;
+
+		if (register_chrdev(DRM_MAJOR, "drm", &DRM(stub_fops)))
+			goto err_p1;
+
+		global->drm_class = class_simple_create(THIS_MODULE, "drm");
+		if (IS_ERR(global->drm_class)) {
+			printk (KERN_ERR "DRM: Error creating drm class.\n");
+			ret = PTR_ERR(global->drm_class);
+			goto err_p2;
 		}
-	}
-	else if (ret1 == -EBUSY)
-		i = (struct drm_stub_info *)inter_module_get("drm");
-	else
-		return -1;
-
-	if (i) {
-				/* Already registered */
-		DRM(stub_info).info_register   = i->info_register;
-		DRM(stub_info).info_unregister = i->info_unregister;
-		DRM_DEBUG("already registered\n");
-	} else if (DRM(stub_info).info_register != DRM(stub_getminor)) {
-		DRM(stub_info).info_register   = DRM(stub_getminor);
-		DRM(stub_info).info_unregister = DRM(stub_putminor);
-		DRM_DEBUG("calling inter_module_register\n");
-		inter_module_register("drm", THIS_MODULE, &DRM(stub_info));
-	}
-	if (DRM(stub_info).info_register) {
-		ret2 = DRM(stub_info).info_register(name, fops, dev);
-		if (ret2) {
-			if (!ret1) {
-				unregister_chrdev(DRM_MAJOR, "drm");
-				class_simple_destroy(drm_class);
-			}
-			if (!i)
-				inter_module_unregister("drm");
+
+		global->proc_root = create_proc_entry("dri", S_IFDIR, NULL);
+		if (!global->proc_root) {
+			DRM_ERROR("Cannot create /proc/dri\n");
+			ret = -1;
+			goto err_p3;
 		}
-		return ret2;
+		DRM_DEBUG("calling inter_module_register\n");
+		inter_module_register("drm", THIS_MODULE, global);
+
+		DRM(global) = global;
+	}
+	if ((ret = get_minor(pdev, ent))) {
+		if (global)
+			goto err_p3;
+		return ret;
 	}
-	return -1;
-}
-
-/**
- * Unregister.
- *
- * \param minor
- *
- * Calls drm_stub_info::unregister.
- */
-int DRM(stub_unregister)(int minor)
-{
-	DRM_DEBUG("%d\n", minor);
-	if (DRM(stub_info).info_unregister)
-		return DRM(stub_info).info_unregister(minor);
-	return -1;
+	return 0;
+err_p3:
+	class_simple_destroy(global->drm_class);
+err_p2:
+	unregister_chrdev(DRM_MAJOR, "drm");
+	DRM(free)(global->minors, sizeof(*global->minors) * global->cards_limit, DRM_MEM_STUB);
+err_p1:
+	DRM(free)(global, sizeof(*global), DRM_MEM_STUB);
+	DRM(global) = NULL;
+	return ret;
 }
diff -Nru a/drivers/char/drm/i915_mem.c b/drivers/char/drm/i915_mem.c
--- a/drivers/char/drm/i915_mem.c	2004-10-27 22:54:10 +10:00
+++ b/drivers/char/drm/i915_mem.c	2004-10-27 22:54:10 +10:00
@@ -75,7 +75,7 @@
 {
 	/* Maybe cut off the start of an existing block */
 	if (start > p->start) {
-		struct mem_block *newblock = DRM_MALLOC(sizeof(*newblock));
+		struct mem_block *newblock = DRM(alloc)(sizeof(*newblock), DRM_MEM_BUFLISTS);
 		if (!newblock)
 			goto out;
 		newblock->start = start;
@@ -91,7 +91,7 @@

 	/* Maybe cut off the end of an existing block */
 	if (size < p->size) {
-		struct mem_block *newblock = DRM_MALLOC(sizeof(*newblock));
+		struct mem_block *newblock = DRM(alloc)(sizeof(*newblock), DRM_MEM_BUFLISTS);
 		if (!newblock)
 			goto out;
 		newblock->start = start + size;
@@ -148,7 +148,7 @@
 		p->size += q->size;
 		p->next = q->next;
 		p->next->prev = p;
-		DRM_FREE(q, sizeof(*q));
+		DRM(free)(q, sizeof(*q), DRM_MEM_BUFLISTS);
 	}

 	if (p->prev->filp == NULL) {
@@ -156,7 +156,7 @@
 		q->size += p->size;
 		q->next = p->next;
 		q->next->prev = q;
-		DRM_FREE(p, sizeof(*q));
+		DRM(free)(p, sizeof(*q), DRM_MEM_BUFLISTS);
 	}
 }

@@ -164,14 +164,14 @@
  */
 static int init_heap(struct mem_block **heap, int start, int size)
 {
-	struct mem_block *blocks = DRM_MALLOC(sizeof(*blocks));
+	struct mem_block *blocks = DRM(alloc)(sizeof(*blocks), DRM_MEM_BUFLISTS);

 	if (!blocks)
 		return -ENOMEM;

-	*heap = DRM_MALLOC(sizeof(**heap));
+	*heap = DRM(alloc)(sizeof(**heap), DRM_MEM_BUFLISTS);
 	if (!*heap) {
-		DRM_FREE(blocks, sizeof(*blocks));
+		DRM(free)(blocks, sizeof(*blocks), DRM_MEM_BUFLISTS);
 		return -ENOMEM;
 	}

@@ -211,7 +211,7 @@
 			p->size += q->size;
 			p->next = q->next;
 			p->next->prev = p;
-			DRM_FREE(q, sizeof(*q));
+			DRM(free)(q, sizeof(*q), DRM_MEM_BUFLISTS);
 		}
 	}
 }
@@ -228,10 +228,10 @@
 	for (p = (*heap)->next; p != *heap;) {
 		struct mem_block *q = p;
 		p = p->next;
-		DRM_FREE(q, sizeof(*q));
+		DRM(free)(q, sizeof(*q), DRM_MEM_BUFLISTS);
 	}

-	DRM_FREE(*heap, sizeof(**heap));
+	DRM(free)(*heap, sizeof(**heap), DRM_MEM_BUFLISTS);
 	*heap = NULL;
 }

diff -Nru a/drivers/char/drm/r128_state.c b/drivers/char/drm/r128_state.c
--- a/drivers/char/drm/r128_state.c	2004-10-27 22:54:10 +10:00
+++ b/drivers/char/drm/r128_state.c	2004-10-27 22:54:10 +10:00
@@ -926,24 +926,24 @@
 	}

 	buffer_size = depth->n * sizeof(u32);
-	buffer = DRM_MALLOC( buffer_size );
+	buffer = DRM(alloc)( buffer_size, DRM_MEM_BUFS );
 	if ( buffer == NULL )
 		return DRM_ERR(ENOMEM);
 	if ( DRM_COPY_FROM_USER( buffer, depth->buffer, buffer_size ) ) {
-		DRM_FREE( buffer, buffer_size);
+		DRM(free)( buffer, buffer_size, DRM_MEM_BUFS);
 		return DRM_ERR(EFAULT);
 	}

 	mask_size = depth->n * sizeof(u8);
 	if ( depth->mask ) {
-		mask = DRM_MALLOC( mask_size );
+		mask = DRM(alloc)( mask_size, DRM_MEM_BUFS );
 		if ( mask == NULL ) {
-			DRM_FREE( buffer, buffer_size );
+			DRM(free)( buffer, buffer_size, DRM_MEM_BUFS );
 			return DRM_ERR(ENOMEM);
 		}
 		if ( DRM_COPY_FROM_USER( mask, depth->mask, mask_size ) ) {
-			DRM_FREE( buffer, buffer_size );
-			DRM_FREE( mask, mask_size );
+			DRM(free)( buffer, buffer_size, DRM_MEM_BUFS );
+			DRM(free)( mask, mask_size, DRM_MEM_BUFS );
 			return DRM_ERR(EFAULT);
 		}

@@ -970,7 +970,7 @@
 			}
 		}

-		DRM_FREE( mask, mask_size );
+		DRM(free)( mask, mask_size, DRM_MEM_BUFS );
 	} else {
 		for ( i = 0 ; i < count ; i++, x++ ) {
 			BEGIN_RING( 6 );
@@ -994,7 +994,7 @@
 		}
 	}

-	DRM_FREE( buffer, buffer_size );
+	DRM(free)( buffer, buffer_size, DRM_MEM_BUFS );

 	return 0;
 }
@@ -1016,54 +1016,54 @@

 	xbuf_size = count * sizeof(*x);
 	ybuf_size = count * sizeof(*y);
-	x = DRM_MALLOC( xbuf_size );
+	x = DRM(alloc)( xbuf_size, DRM_MEM_BUFS );
 	if ( x == NULL ) {
 		return DRM_ERR(ENOMEM);
 	}
-	y = DRM_MALLOC( ybuf_size );
+	y = DRM(alloc)( ybuf_size, DRM_MEM_BUFS );
 	if ( y == NULL ) {
-		DRM_FREE( x, xbuf_size );
+		DRM(free)( x, xbuf_size, DRM_MEM_BUFS );
 		return DRM_ERR(ENOMEM);
 	}
 	if ( DRM_COPY_FROM_USER( x, depth->x, xbuf_size ) ) {
-		DRM_FREE( x, xbuf_size );
-		DRM_FREE( y, ybuf_size );
+		DRM(free)( x, xbuf_size, DRM_MEM_BUFS );
+		DRM(free)( y, ybuf_size, DRM_MEM_BUFS );
 		return DRM_ERR(EFAULT);
 	}
 	if ( DRM_COPY_FROM_USER( y, depth->y, xbuf_size ) ) {
-		DRM_FREE( x, xbuf_size );
-		DRM_FREE( y, ybuf_size );
+		DRM(free)( x, xbuf_size, DRM_MEM_BUFS );
+		DRM(free)( y, ybuf_size, DRM_MEM_BUFS );
 		return DRM_ERR(EFAULT);
 	}

 	buffer_size = depth->n * sizeof(u32);
-	buffer = DRM_MALLOC( buffer_size );
+	buffer = DRM(alloc)( buffer_size, DRM_MEM_BUFS );
 	if ( buffer == NULL ) {
-		DRM_FREE( x, xbuf_size );
-		DRM_FREE( y, ybuf_size );
+		DRM(free)( x, xbuf_size, DRM_MEM_BUFS );
+		DRM(free)( y, ybuf_size, DRM_MEM_BUFS );
 		return DRM_ERR(ENOMEM);
 	}
 	if ( DRM_COPY_FROM_USER( buffer, depth->buffer, buffer_size ) ) {
-		DRM_FREE( x, xbuf_size );
-		DRM_FREE( y, ybuf_size );
-		DRM_FREE( buffer, buffer_size );
+		DRM(free)( x, xbuf_size, DRM_MEM_BUFS );
+		DRM(free)( y, ybuf_size, DRM_MEM_BUFS );
+		DRM(free)( buffer, buffer_size, DRM_MEM_BUFS );
 		return DRM_ERR(EFAULT);
 	}

 	if ( depth->mask ) {
 		mask_size = depth->n * sizeof(u8);
-		mask = DRM_MALLOC( mask_size );
+		mask = DRM(alloc)( mask_size, DRM_MEM_BUFS );
 		if ( mask == NULL ) {
-			DRM_FREE( x, xbuf_size );
-			DRM_FREE( y, ybuf_size );
-			DRM_FREE( buffer, buffer_size );
+			DRM(free)( x, xbuf_size, DRM_MEM_BUFS );
+			DRM(free)( y, ybuf_size, DRM_MEM_BUFS );
+			DRM(free)( buffer, buffer_size, DRM_MEM_BUFS );
 			return DRM_ERR(ENOMEM);
 		}
 		if ( DRM_COPY_FROM_USER( mask, depth->mask, mask_size ) ) {
-			DRM_FREE( x, xbuf_size );
-			DRM_FREE( y, ybuf_size );
-			DRM_FREE( buffer, buffer_size );
-			DRM_FREE( mask, mask_size );
+			DRM(free)( x, xbuf_size, DRM_MEM_BUFS  );
+			DRM(free)( y, ybuf_size, DRM_MEM_BUFS  );
+			DRM(free)( buffer, buffer_size, DRM_MEM_BUFS  );
+			DRM(free)( mask, mask_size, DRM_MEM_BUFS  );
 			return DRM_ERR(EFAULT);
 		}

@@ -1090,7 +1090,7 @@
 			}
 		}

-		DRM_FREE( mask, mask_size );
+		DRM(free)( mask, mask_size, DRM_MEM_BUFS );
 	} else {
 		for ( i = 0 ; i < count ; i++ ) {
 			BEGIN_RING( 6 );
@@ -1114,9 +1114,9 @@
 		}
 	}

-	DRM_FREE( x, xbuf_size );
-	DRM_FREE( y, ybuf_size );
-	DRM_FREE( buffer, buffer_size );
+	DRM(free)( x, xbuf_size, DRM_MEM_BUFS );
+	DRM(free)( y, ybuf_size, DRM_MEM_BUFS );
+	DRM(free)( buffer, buffer_size, DRM_MEM_BUFS );

 	return 0;
 }
@@ -1184,23 +1184,23 @@

 	xbuf_size = count * sizeof(*x);
 	ybuf_size = count * sizeof(*y);
-	x = DRM_MALLOC( xbuf_size );
+	x = DRM(alloc)( xbuf_size, DRM_MEM_BUFS );
 	if ( x == NULL ) {
 		return DRM_ERR(ENOMEM);
 	}
-	y = DRM_MALLOC( ybuf_size );
+	y = DRM(alloc)( ybuf_size, DRM_MEM_BUFS );
 	if ( y == NULL ) {
-		DRM_FREE( x, xbuf_size );
+		DRM(free)( x, xbuf_size, DRM_MEM_BUFS );
 		return DRM_ERR(ENOMEM);
 	}
 	if ( DRM_COPY_FROM_USER( x, depth->x, xbuf_size ) ) {
-		DRM_FREE( x, xbuf_size );
-		DRM_FREE( y, ybuf_size );
+		DRM(free)( x, xbuf_size, DRM_MEM_BUFS );
+		DRM(free)( y, ybuf_size, DRM_MEM_BUFS );
 		return DRM_ERR(EFAULT);
 	}
 	if ( DRM_COPY_FROM_USER( y, depth->y, ybuf_size ) ) {
-		DRM_FREE( x, xbuf_size );
-		DRM_FREE( y, ybuf_size );
+		DRM(free)( x, xbuf_size, DRM_MEM_BUFS );
+		DRM(free)( y, ybuf_size, DRM_MEM_BUFS );
 		return DRM_ERR(EFAULT);
 	}

@@ -1228,8 +1228,8 @@
 		ADVANCE_RING();
 	}

-	DRM_FREE( x, xbuf_size );
-	DRM_FREE( y, ybuf_size );
+	DRM(free)( x, xbuf_size, DRM_MEM_BUFS );
+	DRM(free)( y, ybuf_size, DRM_MEM_BUFS );

 	return 0;
 }
diff -Nru a/drivers/char/drm/radeon_mem.c b/drivers/char/drm/radeon_mem.c
--- a/drivers/char/drm/radeon_mem.c	2004-10-27 22:54:10 +10:00
+++ b/drivers/char/drm/radeon_mem.c	2004-10-27 22:54:10 +10:00
@@ -44,7 +44,7 @@
 {
 	/* Maybe cut off the start of an existing block */
 	if (start > p->start) {
-		struct mem_block *newblock = DRM_MALLOC(sizeof(*newblock));
+		struct mem_block *newblock = DRM(alloc)(sizeof(*newblock), DRM_MEM_BUFS );
 		if (!newblock)
 			goto out;
 		newblock->start = start;
@@ -60,7 +60,7 @@

 	/* Maybe cut off the end of an existing block */
 	if (size < p->size) {
-		struct mem_block *newblock = DRM_MALLOC(sizeof(*newblock));
+		struct mem_block *newblock = DRM(alloc)(sizeof(*newblock), DRM_MEM_BUFS );
 		if (!newblock)
 			goto out;
 		newblock->start = start + size;
@@ -118,7 +118,7 @@
 		p->size += q->size;
 		p->next = q->next;
 		p->next->prev = p;
-		DRM_FREE(q, sizeof(*q));
+		DRM(free)(q, sizeof(*q), DRM_MEM_BUFS );
 	}

 	if (p->prev->filp == 0) {
@@ -126,7 +126,7 @@
 		q->size += p->size;
 		q->next = p->next;
 		q->next->prev = q;
-		DRM_FREE(p, sizeof(*q));
+		DRM(free)(p, sizeof(*q), DRM_MEM_BUFS );
 	}
 }

@@ -134,14 +134,14 @@
  */
 static int init_heap(struct mem_block **heap, int start, int size)
 {
-	struct mem_block *blocks = DRM_MALLOC(sizeof(*blocks));
+	struct mem_block *blocks = DRM(alloc)(sizeof(*blocks), DRM_MEM_BUFS );

 	if (!blocks)
 		return DRM_ERR(ENOMEM);

-	*heap = DRM_MALLOC(sizeof(**heap));
+	*heap = DRM(alloc)(sizeof(**heap), DRM_MEM_BUFS );
 	if (!*heap) {
-		DRM_FREE( blocks, sizeof(*blocks) );
+		DRM(free)( blocks, sizeof(*blocks), DRM_MEM_BUFS );
 		return DRM_ERR(ENOMEM);
 	}

@@ -180,7 +180,7 @@
 			p->size += q->size;
 			p->next = q->next;
 			p->next->prev = p;
-			DRM_FREE(q, sizeof(*q));
+			DRM(free)(q, sizeof(*q),DRM_MEM_DRIVER);
 		}
 	}
 }
@@ -197,10 +197,10 @@
 	for (p = (*heap)->next ; p != *heap ; ) {
 		struct mem_block *q = p;
 		p = p->next;
-		DRM_FREE(q, sizeof(*q));
+		DRM(free)(q, sizeof(*q),DRM_MEM_DRIVER);
 	}

-	DRM_FREE( *heap, sizeof(**heap) );
+	DRM(free)( *heap, sizeof(**heap),DRM_MEM_DRIVER );
 	*heap = NULL;
 }

diff -Nru a/drivers/char/drm/radeon_state.c b/drivers/char/drm/radeon_state.c
--- a/drivers/char/drm/radeon_state.c	2004-10-27 22:54:10 +10:00
+++ b/drivers/char/drm/radeon_state.c	2004-10-27 22:54:10 +10:00
@@ -1440,7 +1440,8 @@
 		}
 		if ( !buf ) {
 			DRM_DEBUG("radeon_cp_dispatch_texture: EAGAIN\n");
-			DRM_COPY_TO_USER( tex->image, image, sizeof(*image) );
+			if (DRM_COPY_TO_USER( tex->image, image, sizeof(*image) ))
+				return DRM_ERR(EFAULT);
 			return DRM_ERR(EAGAIN);
 		}

