Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUDIPE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 11:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUDIPE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 11:04:57 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:46284 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261389AbUDIPEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 11:04:35 -0400
Date: Fri, 9 Apr 2004 16:04:33 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: [patch] Trying to get DRM up to date in 2.6
Message-ID: <Pine.LNX.4.58.0404090838000.30863@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

In a first attempt to bring the DRM in 2.6 in line with the latest
developments in DRM CVS, I'm going to try and split the latest DRM stuff
up into patches and submit them,

I've setup a temporary BK repo at http://freedesktop.org:1234/drm-2.6/
and it contains a first changeset to convert the drivers to using PCI IDs,
I've left out the addition of PCI names (I'd rather get stuff merged..)

This patch is only an initial test, it if proves okay, I'll ramp up with
most of the other diffs to the DRM as soon as I can ...

patch is also attached for viewing pleasure :-)
Regards,
Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1783  -> 1.1784
#	drivers/char/drm/gamma.h	1.7     -> 1.8
#	drivers/char/drm/i830.h	1.8     -> 1.9
#	drivers/char/drm/i810.h	1.10    -> 1.11
#	drivers/char/drm/r128.h	1.11    -> 1.12
#	drivers/char/drm/tdfx_drv.c	1.6     -> 1.7
#	drivers/char/drm/tdfx.h	1.3     -> 1.4
#	drivers/char/drm/drmP.h	1.30    -> 1.31
#	drivers/char/drm/drm_drv.h	1.26    -> 1.27
#	drivers/char/drm/radeon.h	1.15    -> 1.16
#	drivers/char/drm/sis.h	1.6     -> 1.7
#	drivers/char/drm/mga.h	1.7     -> 1.8
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/04/09	airlied@pdx.freedesktop.org	1.1784
# - Converted Linux drivers to initialize DRM instances based on PCI IDs, not
# just a single instance. The PCI ID lists include a driver private field, which may be used
# by drivers for chip family or other information. Based on work by jonsmirl
# and Eric Anholt. I've left out the PCI device naming for this patch as
# that might be a bit controversial. clean up tdfx to look like everyone else..
# --------------------------------------------
#
diff -Nru a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
--- a/drivers/char/drm/drmP.h	Fri Apr  9 00:37:35 2004
+++ b/drivers/char/drm/drmP.h	Fri Apr  9 00:37:35 2004
@@ -362,10 +362,12 @@
 typedef int drm_ioctl_t( struct inode *inode, struct file *filp,
 			 unsigned int cmd, unsigned long arg );

-typedef struct drm_pci_list {
-	u16 vendor;
-	u16 device;
-} drm_pci_list_t;
+typedef struct drm_pci_id_list
+{
+	int vendor;
+	int device;
+	long driver_private;
+} drm_pci_id_list_t;

 typedef struct drm_ioctl_desc {
 	drm_ioctl_t	     *func;
@@ -622,6 +624,7 @@
 	int		  unique_len;	/**< Length of unique field */
 	dev_t		  device;	/**< Device number for mknod */
 	char		  *devname;	/**< For /proc/interrupts */
+	int		  minor;        /**< Minor device number */

 	int		  blocked;	/**< Blocked due to VC switch? */
 	struct proc_dir_entry *root;	/**< Root for this device's entries */
diff -Nru a/drivers/char/drm/drm_drv.h b/drivers/char/drm/drm_drv.h
--- a/drivers/char/drm/drm_drv.h	Fri Apr  9 00:37:35 2004
+++ b/drivers/char/drm/drm_drv.h	Fri Apr  9 00:37:35 2004
@@ -159,15 +159,8 @@
 #undef DRM_OPTIONS_FUNC
 #endif

-/**
- * The default number of instances (minor numbers) to initialize.
- */
-#ifndef DRIVER_NUM_CARDS
-#define DRIVER_NUM_CARDS 1
-#endif
-
-static drm_device_t	*DRM(device);
-static int		*DRM(minor);
+#define MAX_DEVICES 4
+static drm_device_t	DRM(device)[MAX_DEVICES];
 static int		DRM(numdevs) = 0;

 DRIVER_FOPS;
@@ -534,43 +527,93 @@
 	return 0;
 }

-/**
- * Figure out how many instances to initialize.
- *
- * \return number of cards found.
- *
- * Searches for every PCI card in \c DRIVER_CARD_LIST with matching vendor and device ids.
- */
-static int drm_count_cards(void)
+static drm_pci_id_list_t DRM(pciidlist)[] = {
+	DRIVER_PCI_IDS
+};
+
+static int DRM(probe)(struct pci_dev *pdev)
 {
-	int num = 0;
-#if defined(DRIVER_CARD_LIST)
-	int i;
-	drm_pci_list_t *l;
-	u16 device, vendor;
-	struct pci_dev *pdev = NULL;
+	drm_device_t *dev;
+#if __HAVE_CTX_BITMAP
+	int retcode;
 #endif
+	int i;
+	int is_compat = 0;

 	DRM_DEBUG( "\n" );

-#if defined(DRIVER_COUNT_CARDS)
-	num = DRIVER_COUNT_CARDS();
-#elif defined(DRIVER_CARD_LIST)
-	for (i = 0, l = DRIVER_CARD_LIST; l[i].vendor != 0; i++) {
-		pdev = NULL;
-		vendor = l[i].vendor;
-		device = l[i].device;
-		if(device == 0xffff) device = PCI_ANY_ID;
-		if(vendor == 0xffff) vendor = PCI_ANY_ID;
-		while ((pdev = pci_find_device(vendor, device, pdev))) {
-			num++;
+	for (i = 0; DRM(pciidlist)[i].vendor != 0; i++) {
+		if ((DRM(pciidlist)[i].vendor == pdev->vendor) &&
+		    (DRM(pciidlist)[i].device == pdev->device)) {
+			is_compat = 1;
 		}
 	}
-#else
-	num = DRIVER_NUM_CARDS;
+	if (is_compat == 0)
+		return -ENODEV;
+
+	if (DRM(numdevs) >= MAX_DEVICES)
+		return -ENODEV;
+
+	dev = &(DRM(device)[DRM(numdevs)]);
+
+	memset( (void *)dev, 0, sizeof(*dev) );
+	dev->count_lock = SPIN_LOCK_UNLOCKED;
+	init_timer( &dev->timer );
+	sema_init( &dev->struct_sem, 1 );
+
+	if ((dev->minor = DRM(stub_register)(DRIVER_NAME, &DRM(fops),dev)) < 0)
+		return -EPERM;
+	dev->device = MKDEV(DRM_MAJOR, dev->minor );
+	dev->name   = DRIVER_NAME;
+
+	dev->pdev   = pdev;
+#ifdef __alpha__
+	dev->hose   = pdev->sysdata;
 #endif
-	DRM_DEBUG("numdevs = %d\n", num);
-	return num;
+
+	DRIVER_PREINIT();
+
+#if __REALLY_HAVE_AGP
+	dev->agp = DRM(agp_init)();
+#if __MUST_HAVE_AGP
+	if ( dev->agp == NULL ) {
+		DRM_ERROR( "Cannot initialize the agpgart module.\n" );
+		DRM(stub_unregister)(dev->minor);
+		DRM(takedown)( dev );
+		return -EINVAL;
+	}
+#endif
+#if __REALLY_HAVE_MTRR
+	if (dev->agp)
+		dev->agp->agp_mtrr = mtrr_add( dev->agp->agp_info.aper_base,
+					dev->agp->agp_info.aper_size*1024*1024,
+					MTRR_TYPE_WRCOMB,
+					1 );
+#endif
+#endif
+
+#if __HAVE_CTX_BITMAP
+	retcode = DRM(ctxbitmap_init)( dev );
+	if( retcode ) {
+		DRM_ERROR( "Cannot allocate memory for context bitmap.\n" );
+		DRM(stub_unregister)(dev->minor);
+		DRM(takedown)( dev );
+		return retcode;
+ 	}
+#endif
+	DRM(numdevs)++; /* no errors, mark it reserved */
+
+	DRM_INFO( "Initialized %s %d.%d.%d %s on minor %d\n",
+		DRIVER_NAME,
+		DRIVER_MAJOR,
+		DRIVER_MINOR,
+		DRIVER_PATCHLEVEL,
+		DRIVER_DATE,
+		dev->minor);
+
+	DRIVER_POSTINIT();
+
+	return 0;
 }

 /**
@@ -588,88 +631,19 @@
  */
 static int __init drm_init( void )
 {
+	struct pci_dev *pdev = NULL;

-	drm_device_t *dev;
-	int i;
-#if __HAVE_CTX_BITMAP
-	int retcode;
-#endif
 	DRM_DEBUG( "\n" );

 #ifdef MODULE
 	DRM(parse_options)( drm_opts );
 #endif

-	DRM(numdevs) = drm_count_cards();
-	/* Force at least one instance. */
-	if (DRM(numdevs) <= 0)
-		DRM(numdevs) = 1;
-
-	DRM(device) = kmalloc(sizeof(*DRM(device)) * DRM(numdevs), GFP_KERNEL);
-	if (!DRM(device)) {
-		return -ENOMEM;
-	}
-	DRM(minor) = kmalloc(sizeof(*DRM(minor)) * DRM(numdevs), GFP_KERNEL);
-	if (!DRM(minor)) {
-		kfree(DRM(device));
-		return -ENOMEM;
-	}
-
-	DRIVER_PREINIT();
-
 	DRM(mem_init)();

-	for (i = 0; i < DRM(numdevs); i++) {
-		dev = &(DRM(device)[i]);
-		memset( (void *)dev, 0, sizeof(*dev) );
-		dev->count_lock = SPIN_LOCK_UNLOCKED;
-		init_timer( &dev->timer );
-		sema_init( &dev->struct_sem, 1 );
-
-		if ((DRM(minor)[i] = DRM(stub_register)(DRIVER_NAME, &DRM(fops),dev)) < 0)
-			return -EPERM;
-		dev->device = MKDEV(DRM_MAJOR, DRM(minor)[i] );
-		dev->name   = DRIVER_NAME;
-
-#if __REALLY_HAVE_AGP
-		dev->agp = DRM(agp_init)();
-#if __MUST_HAVE_AGP
-		if ( dev->agp == NULL ) {
-			DRM_ERROR( "Cannot initialize the agpgart module.\n" );
-			DRM(stub_unregister)(DRM(minor)[i]);
-			DRM(takedown)( dev );
-			return -EINVAL;
-		}
-#endif
-#if __REALLY_HAVE_MTRR
-		if (dev->agp)
-			dev->agp->agp_mtrr = mtrr_add( dev->agp->agp_info.aper_base,
-				       dev->agp->agp_info.aper_size*1024*1024,
-				       MTRR_TYPE_WRCOMB,
-				       1 );
-#endif
-#endif
-
-#if __HAVE_CTX_BITMAP
-		retcode = DRM(ctxbitmap_init)( dev );
-		if( retcode ) {
-			DRM_ERROR( "Cannot allocate memory for context bitmap.\n" );
-			DRM(stub_unregister)(DRM(minor)[i]);
-			DRM(takedown)( dev );
-			return retcode;
-		}
-#endif
-		DRM_INFO( "Initialized %s %d.%d.%d %s on minor %d\n",
-		  	DRIVER_NAME,
-		  	DRIVER_MAJOR,
-		  	DRIVER_MINOR,
-		  	DRIVER_PATCHLEVEL,
-		  	DRIVER_DATE,
-		  	DRM(minor)[i] );
+	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
+		DRM(probe)(pdev);
 	}
-
-	DRIVER_POSTINIT();
-
 	return 0;
 }

@@ -689,10 +663,10 @@

 	for (i = DRM(numdevs) - 1; i >= 0; i--) {
 		dev = &(DRM(device)[i]);
-		if ( DRM(stub_unregister)(DRM(minor)[i]) ) {
+		if ( DRM(stub_unregister)(dev->minor) ) {
 			DRM_ERROR( "Cannot unload module\n" );
 		} else {
-			DRM_DEBUG("minor %d unregistered\n", DRM(minor)[i]);
+			DRM_DEBUG("minor %d unregistered\n", dev->minor);
 			if (i == 0) {
 				DRM_INFO( "Module unloaded\n" );
 			}
@@ -722,8 +696,6 @@
 #endif
 	}
 	DRIVER_POSTCLEANUP();
-	kfree(DRM(minor));
-	kfree(DRM(device));
 	DRM(numdevs) = 0;
 }

@@ -795,7 +767,7 @@
 	int i;

 	for (i = 0; i < DRM(numdevs); i++) {
-		if (iminor(inode) == DRM(minor)[i]) {
+		if (iminor(inode) == DRM(device)[i].minor) {
 			dev = &(DRM(device)[i]);
 			break;
 		}
diff -Nru a/drivers/char/drm/gamma.h b/drivers/char/drm/gamma.h
--- a/drivers/char/drm/gamma.h	Fri Apr  9 00:37:35 2004
+++ b/drivers/char/drm/gamma.h	Fri Apr  9 00:37:35 2004
@@ -53,6 +53,10 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_GAMMA_INIT)] = { gamma_dma_init,  1, 1 }, \
 	[DRM_IOCTL_NR(DRM_IOCTL_GAMMA_COPY)] = { gamma_dma_copy,  1, 1 }

+#define DRIVER_PCI_IDS							\
+	{0x3d3d, 0x0008, 0},			\
+	{0, 0, 0}
+
 #define IOCTL_TABLE_NAME	DRM(ioctls)
 #define IOCTL_FUNC_NAME 	DRM(ioctl)

diff -Nru a/drivers/char/drm/i810.h b/drivers/char/drm/i810.h
--- a/drivers/char/drm/i810.h	Fri Apr  9 00:37:35 2004
+++ b/drivers/char/drm/i810.h	Fri Apr  9 00:37:35 2004
@@ -77,7 +77,14 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_I810_MC)]      = { i810_dma_mc,     1, 1 }, \
 	[DRM_IOCTL_NR(DRM_IOCTL_I810_RSTATUS)] = { i810_rstatus,    1, 0 }, \
 	[DRM_IOCTL_NR(DRM_IOCTL_I810_FLIP)] =    { i810_flip_bufs,  1, 0 }
-
+
+#define DRIVER_PCI_IDS							\
+	{0x8086, 0x7121, 0},						\
+	{0x8086, 0x7123, 0},						\
+	{0x8086, 0x7125, 0},						\
+	{0x8086, 0x1132, 0},						\
+	{0, 0, 0}
+

 #define __HAVE_COUNTERS         4
 #define __HAVE_COUNTER6         _DRM_STAT_IRQ
diff -Nru a/drivers/char/drm/i830.h b/drivers/char/drm/i830.h
--- a/drivers/char/drm/i830.h	Fri Apr  9 00:37:35 2004
+++ b/drivers/char/drm/i830.h	Fri Apr  9 00:37:35 2004
@@ -77,6 +77,13 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_I830_GETPARAM)] = { i830_getparam,  1, 0 }, \
 	[DRM_IOCTL_NR(DRM_IOCTL_I830_SETPARAM)] = { i830_setparam,  1, 0 }

+#define DRIVER_PCI_IDS							\
+	{0x8086, 0x3577, 0},						\
+	{0x8086, 0x2562, 0},						\
+	{0x8086, 0x3582, 0},						\
+ 	{0x8086, 0x2572, 0},				 		\
+	{0, 0, 0}
+
 #define __HAVE_COUNTERS         4
 #define __HAVE_COUNTER6         _DRM_STAT_IRQ
 #define __HAVE_COUNTER7         _DRM_STAT_PRIMARY
diff -Nru a/drivers/char/drm/mga.h b/drivers/char/drm/mga.h
--- a/drivers/char/drm/mga.h	Fri Apr  9 00:37:35 2004
+++ b/drivers/char/drm/mga.h	Fri Apr  9 00:37:35 2004
@@ -64,6 +64,12 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_MGA_BLIT)]    = { mga_dma_blit,    1, 0 }, \
 	[DRM_IOCTL_NR(DRM_IOCTL_MGA_GETPARAM)]= { mga_getparam,    1, 0 },

+#define DRIVER_PCI_IDS							\
+	{0x102b, 0x0521, 0},						\
+	{0x102b, 0x0525, 0},						\
+	{0x102b, 0x2527, 0},						\
+	{0, 0, 0}
+
 #define __HAVE_COUNTERS         3
 #define __HAVE_COUNTER6         _DRM_STAT_IRQ
 #define __HAVE_COUNTER7         _DRM_STAT_PRIMARY
diff -Nru a/drivers/char/drm/r128.h b/drivers/char/drm/r128.h
--- a/drivers/char/drm/r128.h	Fri Apr  9 00:37:35 2004
+++ b/drivers/char/drm/r128.h	Fri Apr  9 00:37:35 2004
@@ -79,6 +79,46 @@
    [DRM_IOCTL_NR(DRM_IOCTL_R128_INDIRECT)]   = { r128_cce_indirect, 1, 1 }, \
    [DRM_IOCTL_NR(DRM_IOCTL_R128_GETPARAM)]   = { r128_getparam, 1, 0 },

+#define DRIVER_PCI_IDS							\
+	{0x1002, 0x4c45, 0},						\
+	{0x1002, 0x4c46, 0},						\
+	{0x1002, 0x4d46, 0},						\
+	{0x1002, 0x4d4c, 0},						\
+	{0x1002, 0x5041, 0},						\
+	{0x1002, 0x5042, 0},						\
+	{0x1002, 0x5043, 0},						\
+	{0x1002, 0x5044, 0},						\
+	{0x1002, 0x5045, 0},						\
+	{0x1002, 0x5046, 0},						\
+	{0x1002, 0x5047, 0},						\
+	{0x1002, 0x5048, 0},						\
+	{0x1002, 0x5049, 0},						\
+	{0x1002, 0x504A, 0},						\
+	{0x1002, 0x504B, 0},						\
+	{0x1002, 0x504C, 0},						\
+	{0x1002, 0x504D, 0},						\
+	{0x1002, 0x504E, 0},						\
+	{0x1002, 0x504F, 0},						\
+	{0x1002, 0x5050, 0},						\
+	{0x1002, 0x5051, 0},						\
+	{0x1002, 0x5052, 0},						\
+	{0x1002, 0x5053, 0},						\
+	{0x1002, 0x5054, 0},						\
+	{0x1002, 0x5055, 0},						\
+	{0x1002, 0x5056, 0},						\
+	{0x1002, 0x5057, 0},						\
+	{0x1002, 0x5058, 0},						\
+	{0x1002, 0x5245, 0},						\
+	{0x1002, 0x5246, 0},						\
+	{0x1002, 0x5247, 0},						\
+	{0x1002, 0x524b, 0},						\
+	{0x1002, 0x524c, 0},						\
+	{0x1002, 0x534d, 0},						\
+	{0x1002, 0x5446, 0},						\
+	{0x1002, 0x544C, 0},						\
+	{0x1002, 0x5452, 0},						\
+	{0, 0, 0}
+
 /* Driver customization:
  */
 #define DRIVER_PRERELEASE() do {					\
diff -Nru a/drivers/char/drm/radeon.h b/drivers/char/drm/radeon.h
--- a/drivers/char/drm/radeon.h	Fri Apr  9 00:37:35 2004
+++ b/drivers/char/drm/radeon.h	Fri Apr  9 00:37:35 2004
@@ -109,7 +109,66 @@
  [DRM_IOCTL_NR(DRM_IOCTL_RADEON_IRQ_EMIT)]   = { radeon_irq_emit, 1, 0 }, \
  [DRM_IOCTL_NR(DRM_IOCTL_RADEON_IRQ_WAIT)]   = { radeon_irq_wait, 1, 0 },

-
+#define DRIVER_PCI_IDS							\
+	{0x1002, 0x4136, 0},						\
+	{0x1002, 0x4137, 0},						\
+	{0x1002, 0x4237, 0},						\
+	{0x1002, 0x4242, 0},						\
+	{0x1002, 0x4242, 0},						\
+	{0x1002, 0x4336, 0},						\
+	{0x1002, 0x4337, 0},						\
+	{0x1002, 0x4437, 0},						\
+	{0x1002, 0x4964, 0},						\
+	{0x1002, 0x4965, 0},						\
+	{0x1002, 0x4966, 0},						\
+	{0x1002, 0x4967, 0},						\
+	{0x1002, 0x4C57, 0},						\
+	{0x1002, 0x4C58, 0},						\
+	{0x1002, 0x4C59, 0},						\
+	{0x1002, 0x4C5A, 0},						\
+	{0x1002, 0x4C64, 0},						\
+	{0x1002, 0x4C65, 0},						\
+	{0x1002, 0x4C66, 0},						\
+	{0x1002, 0x4C67, 0},						\
+	{0x1002, 0x5144, 0},						\
+	{0x1002, 0x5145, 0},						\
+	{0x1002, 0x5146, 0},						\
+	{0x1002, 0x5147, 0},						\
+	{0x1002, 0x5148, 0},						\
+	{0x1002, 0x5149, 0},						\
+	{0x1002, 0x514A, 0},						\
+	{0x1002, 0x514B, 0},						\
+	{0x1002, 0x514C, 0},						\
+	{0x1002, 0x514D, 0},						\
+	{0x1002, 0x514E, 0},						\
+	{0x1002, 0x514F, 0},						\
+	{0x1002, 0x5157, 0},						\
+	{0x1002, 0x5158, 0},						\
+	{0x1002, 0x5159, 0},						\
+	{0x1002, 0x515A, 0},						\
+	{0x1002, 0x5168, 0},						\
+	{0x1002, 0x5169, 0},						\
+	{0x1002, 0x516A, 0},						\
+	{0x1002, 0x516B, 0},						\
+	{0x1002, 0x516C, 0},						\
+	{0x1002, 0x5834, 0},						\
+	{0x1002, 0x5835, 0},						\
+	{0x1002, 0x5836, 0},						\
+	{0x1002, 0x5837, 0},						\
+	{0x1002, 0x5960, 0},						\
+	{0x1002, 0x5961, 0},						\
+	{0x1002, 0x5962, 0},						\
+	{0x1002, 0x5963, 0},						\
+	{0x1002, 0x5964, 0},						\
+	{0x1002, 0x5968, 0},						\
+	{0x1002, 0x5969, 0},						\
+	{0x1002, 0x596A, 0},						\
+	{0x1002, 0x596B, 0},						\
+	{0x1002, 0x5c61, 0},						\
+	{0x1002, 0x5c62, 0},						\
+	{0x1002, 0x5c63, 0},						\
+	{0x1002, 0x5c64, 0},						\
+	{0, 0, 0}

 /* When a client dies:
  *    - Check for and clean up flipped page state
diff -Nru a/drivers/char/drm/sis.h b/drivers/char/drm/sis.h
--- a/drivers/char/drm/sis.h	Fri Apr  9 00:37:35 2004
+++ b/drivers/char/drm/sis.h	Fri Apr  9 00:37:35 2004
@@ -62,6 +62,13 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_SIS_AGP_FREE)]	= { sis_ioctl_agp_free,	1, 0 }, \
 	[DRM_IOCTL_NR(DRM_IOCTL_SIS_FB_INIT)]	= { sis_fb_init,	1, 1 }

+#define DRIVER_PCI_IDS							\
+	{0x1039, 0x0300, 0},						\
+	{0x1039, 0x5300, 0},						\
+	{0x1039, 0x6300, 0},						\
+	{0x1039, 0x7300, 0},						\
+	{0, 0, 0}
+
 #define __HAVE_COUNTERS		5

 /* Buffer customization:
diff -Nru a/drivers/char/drm/tdfx.h b/drivers/char/drm/tdfx.h
--- a/drivers/char/drm/tdfx.h	Fri Apr  9 00:37:35 2004
+++ b/drivers/char/drm/tdfx.h	Fri Apr  9 00:37:35 2004
@@ -39,4 +39,22 @@
 #define __HAVE_MTRR		1
 #define __HAVE_CTX_BITMAP	1

+#define DRIVER_AUTHOR		"VA Linux Systems Inc."
+
+#define DRIVER_NAME		"tdfx"
+#define DRIVER_DESC		"3dfx Banshee/Voodoo3+"
+#define DRIVER_DATE		"20010216"
+
+#define DRIVER_MAJOR		1
+#define DRIVER_MINOR		0
+#define DRIVER_PATCHLEVEL	0
+
+#define DRIVER_PCI_IDS							\
+	{0x121a, 0x0003, 0},						\
+	{0x121a, 0x0004, 0},						\
+	{0x121a, 0x0005, 0},						\
+	{0x121a, 0x0007, 0},						\
+	{0x121a, 0x0009, 0},						\
+	{0, 0, 0}
+
 #endif
diff -Nru a/drivers/char/drm/tdfx_drv.c b/drivers/char/drm/tdfx_drv.c
--- a/drivers/char/drm/tdfx_drv.c	Fri Apr  9 00:37:35 2004
+++ b/drivers/char/drm/tdfx_drv.c	Fri Apr  9 00:37:35 2004
@@ -34,47 +34,6 @@
 #include "tdfx.h"
 #include "drmP.h"

-#define DRIVER_AUTHOR		"VA Linux Systems Inc."
-
-#define DRIVER_NAME		"tdfx"
-#define DRIVER_DESC		"3dfx Banshee/Voodoo3+"
-#define DRIVER_DATE		"20010216"
-
-#define DRIVER_MAJOR		1
-#define DRIVER_MINOR		0
-#define DRIVER_PATCHLEVEL	0
-
-#ifndef PCI_VENDOR_ID_3DFX
-#define PCI_VENDOR_ID_3DFX 0x121A
-#endif
-#ifndef PCI_DEVICE_ID_3DFX_VOODOO5
-#define PCI_DEVICE_ID_3DFX_VOODOO5 0x0009
-#endif
-#ifndef PCI_DEVICE_ID_3DFX_VOODOO4
-#define PCI_DEVICE_ID_3DFX_VOODOO4 0x0007
-#endif
-#ifndef PCI_DEVICE_ID_3DFX_VOODOO3_3000 /* Voodoo3 3000 */
-#define PCI_DEVICE_ID_3DFX_VOODOO3_3000 0x0005
-#endif
-#ifndef PCI_DEVICE_ID_3DFX_VOODOO3_2000 /* Voodoo3 3000 */
-#define PCI_DEVICE_ID_3DFX_VOODOO3_2000 0x0004
-#endif
-#ifndef PCI_DEVICE_ID_3DFX_BANSHEE
-#define PCI_DEVICE_ID_3DFX_BANSHEE 0x0003
-#endif
-
-static drm_pci_list_t DRM(idlist)[] = {
-	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_BANSHEE },
-	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO3_2000 },
-	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO3_3000 },
-	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO4 },
-	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO5 },
-	{ 0, 0 }
-};
-
-#define DRIVER_CARD_LIST DRM(idlist)
-
-
 #include "drm_auth.h"
 #include "drm_bufs.h"
 #include "drm_context.h"
