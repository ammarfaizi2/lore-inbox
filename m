Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268487AbUI2Nt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268487AbUI2Nt2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268435AbUI2NtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:49:05 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:44279 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S268425AbUI2Nk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:40:59 -0400
Date: Wed, 29 Sep 2004 14:40:57 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: vga class / drm patch
Message-ID: <Pine.LNX.4.58.0409291431330.1574@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As promised this is the fixed up code that makes the VGA class stuff work,
it also ports the DRM, I have a half ported fb but I haven't tested it
yet... all fb drivers would need to be ported and that probably requires
buy-in from the fb team (it take a bit of work and some testing for each
driver...)

the initial affect on the drm is minor as shown we only do PCI probing in
once place so we can replace it with vga probing with no issues.. the fb
has no such central place...

Dave.

diff -Nru a/drivers/char/drm/ati_pcigart.h b/drivers/char/drm/ati_pcigart.h
--- a/drivers/char/drm/ati_pcigart.h	Wed Sep 29 21:29:06 2004
+++ b/drivers/char/drm/ati_pcigart.h	Wed Sep 29 21:29:06 2004
@@ -112,12 +112,12 @@
 		goto done;
 	}

-	if ( !dev->pdev ) {
+	if ( !dev->vdev->pci_dev ) {
 		DRM_ERROR( "PCI device unknown!\n" );
 		goto done;
 	}

-	bus_address = pci_map_single(dev->pdev, (void *)address,
+	bus_address = pci_map_single(dev->vdev->pci_dev, (void *)address,
 				  ATI_PCIGART_TABLE_PAGES * PAGE_SIZE,
 				  PCI_DMA_TODEVICE);
 	if (bus_address == 0) {
@@ -136,7 +136,7 @@

 	for ( i = 0 ; i < pages ; i++ ) {
 		/* we need to support large memory configurations */
-		entry->busaddr[i] = pci_map_single(dev->pdev,
+		entry->busaddr[i] = pci_map_single(dev->vdev->pci_dev,
 					   page_address( entry->pagelist[i] ),
 					   PAGE_SIZE,
 					   PCI_DMA_TODEVICE);
@@ -184,7 +184,7 @@
 	}

 	if ( bus_addr ) {
-		pci_unmap_single(dev->pdev, bus_addr,
+		pci_unmap_single(dev->vdev->pci_dev, bus_addr,
 				 ATI_PCIGART_TABLE_PAGES * PAGE_SIZE,
 				 PCI_DMA_TODEVICE);

@@ -193,7 +193,7 @@

 		for ( i = 0 ; i < pages ; i++ ) {
 			if ( !entry->busaddr[i] ) break;
-			pci_unmap_single(dev->pdev, entry->busaddr[i],
+			pci_unmap_single(dev->vdev->pci_dev, entry->busaddr[i],
 					 PAGE_SIZE, PCI_DMA_TODEVICE);
 		}
 	}
diff -Nru a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
--- a/drivers/char/drm/drmP.h	Wed Sep 29 21:29:06 2004
+++ b/drivers/char/drm/drmP.h	Wed Sep 29 21:29:06 2004
@@ -71,6 +71,7 @@
 #include <linux/workqueue.h>
 #include <linux/poll.h>
 #include <asm/pgalloc.h>
+#include <linux/vga_class.h>
 #include "drm.h"

 #define __OS_HAS_AGP (defined(CONFIG_AGP) || (defined(CONFIG_AGP_MODULE) && defined(MODULE)))
@@ -682,7 +683,7 @@

 	drm_agp_head_t    *agp;	/**< AGP data */

-	struct pci_dev    *pdev;	/**< PCI device structure */
+	struct vga_dev    *vdev;	/**< PCI device structure */
 	int               pci_domain;	/**< PCI bus domain number */
 	int               pci_bus;	/**< PCI bus number */
 	int               pci_slot;	/**< PCI slot number */
diff -Nru a/drivers/char/drm/drm_drv.h b/drivers/char/drm/drm_drv.h
--- a/drivers/char/drm/drm_drv.h	Wed Sep 29 21:29:06 2004
+++ b/drivers/char/drm/drm_drv.h	Wed Sep 29 21:29:06 2004
@@ -453,30 +453,21 @@
 	dev->fn_tbl.get_reg_ofs = DRM(core_get_reg_ofs);
 }

-#include "drm_pciids.h"
+#include "drm_vgaids.h"

-static struct pci_device_id DRM(pciidlist)[] = {
+static struct vga_device_id DRM(vgaidlist)[] = {
 	DRM(PCI_IDS)
 };

-static int DRM(probe)(struct pci_dev *pdev)
+
+
+static int DRM(probe)(struct vga_dev *vdev, const struct vga_device_id *id)
 {
 	drm_device_t *dev;
 	int retcode;
-	int i;
-	int is_compat = 0;

 	DRM_DEBUG( "\n" );

-	for (i = 0; DRM(pciidlist)[i].vendor != 0; i++) {
-		if ((DRM(pciidlist)[i].vendor == pdev->vendor) &&
-		    (DRM(pciidlist)[i].device == pdev->device)) {
-			is_compat = 1;
-		}
-	}
-	if (is_compat == 0)
-		return -ENODEV;
-
 	if (DRM(numdevs) >= MAX_DEVICES)
 		return -ENODEV;

@@ -493,17 +484,17 @@
 	dev->device = MKDEV(DRM_MAJOR, dev->minor );
 	dev->name   = DRIVER_NAME;

-	dev->pdev   = pdev;
+	dev->vdev   = vdev;
 #ifdef __alpha__
 	dev->hose   = pdev->sysdata;
 	dev->pci_domain = dev->hose->bus->number;
 #else
 	dev->pci_domain = 0;
 #endif
-	dev->pci_bus = pdev->bus->number;
-	dev->pci_slot = PCI_SLOT(pdev->devfn);
-	dev->pci_func = PCI_FUNC(pdev->devfn);
-	dev->irq = pdev->irq;
+	dev->pci_bus = vdev->pci_dev->bus->number;
+	dev->pci_slot = PCI_SLOT(vdev->pci_dev->devfn);
+	dev->pci_func = PCI_FUNC(vdev->pci_dev->devfn);
+	dev->irq = vdev->pci_dev->irq;

 	/* dev_priv_size can be changed by a driver in driver_register_fns */
 	dev->dev_priv_size = sizeof(u32);
@@ -550,7 +541,7 @@
 		DRIVER_PATCHLEVEL,
 		DRIVER_DATE,
 		dev->minor,
-		pci_pretty_name(pdev));
+		pci_pretty_name(vdev->pci_dev));

 	if (dev->fn_tbl.postinit)
 	  dev->fn_tbl.postinit(dev);
@@ -558,6 +549,26 @@
 	return 0;
 }

+static void DRM(vga_notify_attach)(struct vga_dev *vga_dev, int type)
+{
+
+}
+
+static void DRM(vga_notify_detach)(struct vga_dev *vga_dev, int type)
+{
+
+}
+
+static struct vga_driver DRM(vga_driver) = {
+  .type = TYPE_DRI,
+  .name = "drm",
+  .probe = DRM(probe),
+  .id_table = DRM(vgaidlist),
+  .notify_attach = DRM(vga_notify_attach),
+  .notify_detach = DRM(vga_notify_detach)
+};
+
+
 /**
  * Module initialization. Called via init_module at module load time, or via
  * linux/init/main.c (this is not currently supported).
@@ -573,7 +584,6 @@
  */
 static int __init drm_init( void )
 {
-	struct pci_dev *pdev = NULL;

 	DRM_DEBUG( "\n" );

@@ -583,9 +593,8 @@

 	DRM(mem_init)();

-	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
-		DRM(probe)(pdev);
-	}
+	vga_register_driver(&DRM(vga_driver));
+
 	return 0;
 }

@@ -603,6 +612,8 @@

 	DRM_DEBUG( "\n" );

+	vga_unregister_driver(&DRM(vga_driver));
+
 	for (i = DRM(numdevs) - 1; i >= 0; i--) {
 		dev = &(DRM(device)[i]);
 		if ( DRM(stub_unregister)(dev->minor) ) {
@@ -632,6 +643,8 @@
 			DRM(free)( dev->agp, sizeof(*dev->agp), DRM_MEM_AGPLISTS );
 			dev->agp = NULL;
 		}
+
+

 		if (dev->fn_tbl.postcleanup)
 		  dev->fn_tbl.postcleanup(dev);
@@ -1086,3 +1099,4 @@
 	unblock_all_signals();
 	return 0;
 }
+
diff -Nru a/drivers/char/drm/drm_vgaids.h b/drivers/char/drm/drm_vgaids.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/drm/drm_vgaids.h	Wed Sep 29 21:29:06 2004
@@ -0,0 +1,212 @@
+/*
+   This file is auto-generated from the drm_pciids.txt in the DRM CVS
+   Please contact dri-devel@lists.sf.net to add new cards to this list
+*/
+#define radeon_PCI_IDS \
+	{0x1002, 0x4136, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4137, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4237, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4242, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4242, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4336, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4337, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4437, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4964, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4965, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4966, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4967, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4C57, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4C58, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4C59, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4C5A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4C64, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4C65, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4C66, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4C67, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5144, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5145, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5146, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5147, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5148, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x514A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x514B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x514C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x514D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x514E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x514F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5157, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5158, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5159, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x515A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5168, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5169, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x516A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x516B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x516C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5834, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5835, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5836, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5837, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5960, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5961, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5962, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5963, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5964, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5968, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5969, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x596A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x596B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5c61, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5c62, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5c63, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5c64, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0, 0, 0}
+
+#define r128_PCI_IDS \
+	{0x1002, 0x4c45, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4c46, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4d46, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4d4c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5041, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5042, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5043, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5044, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5045, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5046, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5047, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5048, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5049, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x504A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x504B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x504C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x504D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x504E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x504F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5050, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5051, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5052, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5054, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5055, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5056, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5057, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5058, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5245, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5246, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5247, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x524b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x524c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x534d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5446, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x544C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x5452, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0, 0, 0}
+
+#define mga_PCI_IDS \
+	{0x102b, 0x0521, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x102b, 0x0525, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x102b, 0x2527, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0, 0, 0}
+
+#define mach64_PCI_IDS \
+	{0x1002, 0x4749, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4750, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4751, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4742, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4744, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4c49, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4c50, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4c51, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4c42, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4c44, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x474c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x474f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4752, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4753, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x474d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x474e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4c52, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4c53, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4c4d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1002, 0x4c4e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0, 0, 0}
+
+#define sisdrv_PCI_IDS \
+	{0x1039, 0x0300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1039, 0x5300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1039, 0x6300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1039, 0x7300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0, 0, 0}
+
+#define tdfx_PCI_IDS \
+	{0x121a, 0x0003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x121a, 0x0004, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x121a, 0x0005, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x121a, 0x0007, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x121a, 0x0009, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x121a, 0x000b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0, 0, 0}
+
+#define viadrv_PCI_IDS \
+	{0x1106, 0x3022, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1106, 0x3118, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1106, 0x3122, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1106, 0x7205, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x1106, 0x7204, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0, 0, 0}
+
+#define i810_PCI_IDS \
+	{0x8086, 0x7121, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x8086, 0x7123, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x8086, 0x7125, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x8086, 0x1132, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0, 0, 0}
+
+#define i830_PCI_IDS \
+	{0x8086, 0x3577, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x8086, 0x2562, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x8086, 0x3582, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x8086, 0x2572, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0, 0, 0}
+
+#define gamma_PCI_IDS \
+	{0x3d3d, 0x0008, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0, 0, 0}
+
+#define savage_PCI_IDS \
+	{0x5333, 0x8a22, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8a23, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8c10, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8c11, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8c12, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8c13, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8c20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8c21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8c22, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8c24, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8c26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8c2a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8c2b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8c2c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8c2d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8c2e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8c2f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8a25, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8a26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8d01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8d02, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x5333, 0x8d04, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0, 0, 0}
+
+#define ffb_PCI_IDS \
+	{0, 0, 0}
+
+#define i915_PCI_IDS \
+	{0x8086, 0x3577, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x8086, 0x2562, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x8086, 0x3582, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x8086, 0x2572, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0x8086, 0x2582, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_DRI, 0}, \
+	{0, 0, 0}
+
diff -Nru a/drivers/char/drm/i810_dma.c b/drivers/char/drm/i810_dma.c
--- a/drivers/char/drm/i810_dma.c	Wed Sep 29 21:29:06 2004
+++ b/drivers/char/drm/i810_dma.c	Wed Sep 29 21:29:06 2004
@@ -249,7 +249,7 @@
 					 dev_priv->ring.Size, dev);
 		}
 	   	if (dev_priv->hw_status_page) {
-		   	pci_free_consistent(dev->pdev, PAGE_SIZE,
+		   	pci_free_consistent(dev->vdev->pci_dev, PAGE_SIZE,
 					    dev_priv->hw_status_page,
 					    dev_priv->dma_status_page);
 		   	/* Need to rewrite hardware status page */
@@ -416,7 +416,7 @@

    	/* Program Hardware Status Page */
    	dev_priv->hw_status_page =
-		pci_alloc_consistent(dev->pdev, PAGE_SIZE,
+		pci_alloc_consistent(dev->vdev->pci_dev, PAGE_SIZE,
 						&dev_priv->dma_status_page);
    	if (!dev_priv->hw_status_page) {
 		dev->dev_private = (void *)dev_priv;
diff -Nru a/drivers/char/drm/i830_dma.c b/drivers/char/drm/i830_dma.c
--- a/drivers/char/drm/i830_dma.c	Wed Sep 29 21:29:06 2004
+++ b/drivers/char/drm/i830_dma.c	Wed Sep 29 21:29:06 2004
@@ -249,7 +249,7 @@
 					 dev_priv->ring.Size, dev);
 		}
 	   	if (dev_priv->hw_status_page) {
-			pci_free_consistent(dev->pdev, PAGE_SIZE,
+			pci_free_consistent(dev->vdev->pci_dev, PAGE_SIZE,
 					    dev_priv->hw_status_page,
 					    dev_priv->dma_status_page);
 		   	/* Need to rewrite hardware status page */
@@ -434,7 +434,7 @@

    	/* Program Hardware Status Page */
    	dev_priv->hw_status_page =
-		pci_alloc_consistent(dev->pdev, PAGE_SIZE,
+		pci_alloc_consistent(dev->vdev->pci_dev, PAGE_SIZE,
 						&dev_priv->dma_status_page);
    	if (!dev_priv->hw_status_page) {
 		dev->dev_private = (void *)dev_priv;
diff -Nru a/drivers/char/drm/i915_dma.c b/drivers/char/drm/i915_dma.c
--- a/drivers/char/drm/i915_dma.c	Wed Sep 29 21:29:06 2004
+++ b/drivers/char/drm/i915_dma.c	Wed Sep 29 21:29:06 2004
@@ -95,7 +95,7 @@
 		}

 		if (dev_priv->hw_status_page) {
-			pci_free_consistent(dev->pdev, PAGE_SIZE,
+			pci_free_consistent(dev->vdev->pci_dev, PAGE_SIZE,
 					    dev_priv->hw_status_page,
 					    dev_priv->dma_status_page);
 			/* Need to rewrite hardware status page */
@@ -175,7 +175,7 @@

 	/* Program Hardware Status Page */
 	dev_priv->hw_status_page =
-	    pci_alloc_consistent(dev->pdev, PAGE_SIZE,
+	    pci_alloc_consistent(dev->vdev->pci_dev, PAGE_SIZE,
 				 &dev_priv->dma_status_page);

 	if (!dev_priv->hw_status_page) {
diff -Nru a/drivers/video/vga_class.c b/drivers/video/vga_class.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/video/vga_class.c	Wed Sep 29 21:29:06 2004
@@ -0,0 +1,552 @@
+/*
+ * drivers/video/vga-driver.c
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <asm/semaphore.h>
+#include <linux/vga_class.h>
+
+/*
+ *  Registration of video drivers and handling of hot-pluggable devices.
+ */
+
+static LIST_HEAD(vga_devices);	/* No I don't know why its not DECLARE_LIST_HEAD either */
+
+/**
+ * vga_match_one_device - Tell if a PCI device structure has a matching
+ *                        PCI device id structure
+ * @id: single PCI device id structure to match
+ * @dev: the PCI device structure to match against
+ *
+ * Returns the matching vga_device_id structure or %NULL if there is no match.
+ */
+
+static inline const struct vga_device_id *
+vga_match_one_device(const struct vga_device_id *id, const struct pci_dev *dev)
+{
+	printk("%s\n", __FUNCTION__);
+	if ((id->vendor == PCI_ANY_ID || id->vendor == dev->vendor) &&
+	    (id->device == PCI_ANY_ID || id->device == dev->device) &&
+	    (id->subvendor == PCI_ANY_ID || id->subvendor == dev->subsystem_vendor) &&
+	    (id->subdevice == PCI_ANY_ID || id->subdevice == dev->subsystem_device) &&
+	    !((id->class ^ dev->class) & id->class_mask))
+		return id;
+	return NULL;
+}
+
+
+/**
+ * vga_match_device - Tell if a VGA device structure has a matching
+ *                    PCI device id structure
+ * @ids: array of PCI device id structures to search in
+ * @dev: the PCI device structure to match against
+ *
+ * Used by a driver to check whether a PCI device present in the
+ * system is in its list of supported devices.Returns the matching
+ * vga_device_id structure or %NULL if there is no match.
+ */
+static const struct vga_device_id *
+vga_match_device(const struct vga_device_id *ids, const struct vga_dev *vdev)
+{
+	struct pci_dev *pdev = vdev->pci_dev;
+	printk("%s\n", __FUNCTION__);
+	while (ids->vendor || ids->subvendor || ids->class_mask) {
+		printk("vga: ids unit %d vdev %d\n", ids->unit, vdev->unit);
+		if (vga_match_one_device(ids, pdev) && ids->unit == vdev->unit)
+			return ids;
+		ids++;
+	}
+	return NULL;
+}
+
+
+static void vga_device_notify_install(struct vga_dev *vdev, int type)
+{
+	int i;
+	printk("%s\n", __FUNCTION__);
+	for(i = TYPE_MEM; i < TYPE_LAST; i++) {
+		struct vga_dev *v = vdev->shared->device[i];
+		if(v != NULL && v->driver && i != type)
+			v->driver->notify_attach(v, type);
+	}
+}
+
+static void vga_device_notify_remove(struct vga_dev *vdev, int type)
+{
+	int i;
+	printk("%s\n", __FUNCTION__);
+	for(i = TYPE_MEM; i < TYPE_LAST; i++) {
+		struct vga_dev *v = vdev->shared->device[i];
+		if(v != NULL && v->driver && i != type)
+			v->driver->notify_detach(v, type);
+	}
+}
+
+/**
+ * vga_device_probe_static()
+ *
+ * returns 0 and sets vdev->driver when drv claims vdev, else error.
+ */
+static int
+vga_device_probe_static(struct vga_driver *vdrv, struct vga_dev *vdev)
+{
+	int error = -ENODEV;
+	const struct vga_device_id *id;
+
+	printk("%s\n", __FUNCTION__);
+	if (!vdrv->id_table)
+		return error;
+	id = vga_match_device(vdrv->id_table, vdev);
+	if (id)
+		error = vdrv->probe(vdev, id);
+	if (error >= 0) {
+		vdev->driver = vdrv;
+		down(&vdev->shared->shared_sem);
+		vdev->shared->users++;
+		vga_device_notify_install(vdev, vdev->unit);
+		up(&vdev->shared->shared_sem);
+		error = 0;
+	}
+	return error;
+}
+
+/**
+ * __vga_device_probe()
+ *
+ * returns 0  on success, else error.
+ * side-effect: vdev->driver is set to vdrv when drv claims vdev.
+ */
+static int
+__vga_device_probe(struct vga_driver *vdrv, struct vga_dev *vdev)
+{
+	int error = 0;
+
+	printk("%s\n", __FUNCTION__);
+	if (!vdev->driver && vdrv->probe) {
+		error = vga_device_probe_static(vdrv, vdev);
+	}
+	return error;
+}
+
+static int vga_device_probe(struct device *dev)
+{
+	int error = 0;
+	struct vga_driver *drv;
+	struct vga_dev *vdev;
+
+	printk("%s\n", __FUNCTION__);
+	drv = to_vga_driver(dev->driver);
+	vdev = to_vga_dev(dev);
+	vga_dev_get(vdev);
+	error = __vga_device_probe(drv, vdev);
+	if (error)
+		vga_dev_put(vdev);
+
+	return error;
+}
+
+static int vga_device_remove(struct device *dev)
+{
+	struct vga_dev *vdev = to_vga_dev(dev);
+	struct vga_driver *vdrv = vdev->driver;
+
+	printk("%s\n", __FUNCTION__);
+	down(&vdev->shared->shared_sem);
+	vdev->shared->users--;
+	if (vdrv) {
+		vga_device_notify_remove(vdev, vdev->unit);
+		if (vdrv->remove)
+			vdrv->remove(vdev, vdev->shared->count);
+		vdev->driver = NULL;
+	}
+	vdev->shared->device[vdev->unit] = NULL;
+	up(&vdev->shared->shared_sem);
+
+	vga_dev_put(vdev);
+	return 0;
+}
+
+static int vga_device_suspend(struct device *dev, u32 state)
+{
+	return 0;
+}
+
+
+/*
+ * Default resume method for devices that have no driver provided resume,
+ * or not even a driver at all.
+ */
+
+static int vga_device_resume(struct device *dev)
+{
+	return 0;
+}
+
+static struct kobj_type vga_driver_kobj_type = {
+};
+
+/**
+ * vga_register_driver - register a new pci driver
+ * @drv: the driver structure to register
+ *
+ * Adds the driver structure to the list of registered drivers
+ * Returns the number of vga devices which were claimed by the driver
+ * during registration.  The driver remains registered even if the
+ * return value is zero.
+ */
+
+int vga_register_driver(struct vga_driver *drv)
+{
+	int count;
+
+	/* initialize common driver fields */
+	drv->driver.name = drv->name;
+	drv->driver.bus = &vga_bus_type;
+	drv->driver.probe = vga_device_probe;
+	drv->driver.remove = vga_device_remove;
+	drv->driver.kobj.ktype = &vga_driver_kobj_type;
+
+	count = driver_register(&drv->driver);
+	printk("VGA Register driver called returning %d\n", count);
+	/* register with core */
+	return count;
+}
+
+/**
+ * vga_unregister_driver - unregister a pci driver
+ * @drv: the driver structure to unregister
+ *
+ * Deletes the driver structure from the list of registered VGA drivers,
+ * gives it a chance to clean up by calling its remove() function for
+ * each device it was responsible for, and marks those devices as
+ * driverless.
+ */
+
+void vga_unregister_driver(struct vga_driver *vdrv)
+{
+
+	printk("%s\n", __FUNCTION__);
+	driver_unregister(&vdrv->driver);
+}
+
+/**
+ * vga_dev_driver - get the vga_driver of a device
+ * @dev: the device to query
+ * @type: type of device
+ *
+ * Returns the appropriate vga_driver structure or %NULL if there is no
+ * registered driver for the device. The shared block is used so that
+ * you can pass your own vdev to receive driver information about
+ * other attached drivers to the same PCI device. Caller must be careful
+ * about locking and use of shared_sem.
+ */
+
+struct vga_driver *vga_dev_driver(const struct vga_dev *vdev, int type)
+{
+	struct vga_dev *v = vdev->shared->device[type];
+
+	printk("%s\n", __FUNCTION__);
+	if(v == NULL)
+		return NULL;
+	return v->driver;
+}
+
+/**
+ * vga_bus_match - Tell if a VGA device structure has a matching PCI device id structure
+ * @ids: array of PCI device id structures to search in
+ * @dev: the VGA device structure to match against
+ *
+ * Used by a driver to check whether a VGA device present in the
+ * system is in its list of supported devices.Returns the matching
+ * vga_device_id structure or %NULL if there is no match.
+ */
+
+static int vga_bus_match(struct device *dev, struct device_driver * drv)
+{
+	const struct vga_dev *vdev = to_vga_dev(dev);
+	struct vga_driver *vdrv = to_vga_driver(drv);
+	const struct vga_device_id * ids = vdrv->id_table;
+
+	printk("%s\n", __FUNCTION__);
+	if (!ids)
+		return 0;
+	return vga_match_device(ids, vdev) ? 1 : 0;
+}
+
+/**
+ * vga_dev_get - increments the reference count of the pci device structure
+ * @dev: the device being referenced
+ *
+ * Each live reference to a device should be refcounted.
+ *
+ * Drivers for VGA devices should normally record such references in
+ * their probe() methods, when they bind to a device, and release
+ * them by calling vga_dev_put(), in their disconnect() methods.
+ *
+ * A pointer to the device with the incremented reference counter is returned.
+ */
+struct vga_dev *vga_dev_get(struct vga_dev *vdev)
+{
+	struct device *tmp;
+
+	printk("%s\n", __FUNCTION__);
+	if (!vdev)
+		return NULL;
+
+	tmp = get_device(&vdev->dev);
+	if (tmp)
+		return to_vga_dev(tmp);
+	else
+		return NULL;
+}
+
+/**
+ * vga_dev_put - release a use of the vga_dev structure
+ * @dev: device that's been disconnected
+ *
+ * Must be called when a user of a device is finished with it.  When the last
+ * user of the device calls this function, the memory of the device is freed.
+ */
+void vga_dev_put(struct vga_dev *dev)
+{
+	printk("%s\n", __FUNCTION__);
+	if (dev)
+		put_device(&dev->dev);
+}
+
+/* For now */
+int vga_hotplug (struct device *dev, char **envp, int num_envp,
+		 char *buffer, int buffer_size)
+{
+	printk("%s\n", __FUNCTION__);
+	return -ENODEV;
+}
+
+struct bus_type vga_bus_type = {
+	.name		= "vga",
+	.match		= vga_bus_match,
+	.hotplug	= vga_hotplug,
+	.suspend	= vga_device_suspend,
+	.resume		= vga_device_resume,
+};
+
+
+
+/*
+ *	Helper for VESAfb and friends.
+ */
+
+static int mmio_resource_overlap(struct pci_dev *dev, int i, unsigned long mmio)
+{
+	unsigned long st = pci_resource_start(dev, i);
+	unsigned long size = pci_resource_len(dev, i);
+	unsigned long flags = pci_resource_flags(dev, i);
+
+	if(st == 0 || size == 0)
+	   	return 0;
+	if(st + size < mmio)
+		return 0;
+	if(st > mmio)
+		return 0;
+	if(flags & IORESOURCE_IO)
+		return 0;
+	return 1;
+}
+
+static struct pci_dev *vga_find_by_mmio(unsigned long mmio)
+{
+	struct list_head *l;
+	list_for_each(l, &vga_devices) {
+		struct vga_dev *vdev = list_entry(l, struct vga_dev, next);
+		int i;
+		for (i = 0; i < 6; i++) {
+			if (mmio_resource_overlap(vdev->pci_dev, i, mmio))
+				return vdev->pci_dev;
+		}
+	}
+	/* Check ISA window routing ? */
+	return NULL;
+}
+
+
+/*
+ *	Big locking as suggested by Linus. Drivers can of course be
+ *	more friendly and work together on some things.
+ */
+
+void vga_take_lock(struct vga_dev *vdev, struct vga_driver *vdrv, void *context)
+{
+	struct vga_shared *v = vdev->shared;
+
+	down(&v->shared_sem);
+	down(&v->fb_sem);
+	if(v->lock_owner != vdrv || v->lock_context != context)
+	{
+		if(v->lock_release)
+			v->lock_release(vdev, v->lock_context);
+		v->lock_release = NULL;
+	}
+	v->lock_owner = vdrv;
+	v->lock_context = context;
+}
+
+EXPORT_SYMBOL_GPL(vga_take_lock);
+
+/*
+ *	Drop the big locking
+ */
+
+void vga_drop_lock(struct vga_dev *vdev, void (*lock_release)(struct vga_dev *, void *))
+{
+	struct vga_shared *v = vdev->shared;
+	v->lock_release = lock_release;
+	up(&v->fb_sem);
+	up(&v->shared_sem);
+}
+
+EXPORT_SYMBOL_GPL(vga_drop_lock);
+
+/*
+ *	VGA device discovery from the PCI side
+ */
+
+
+/**
+ * vga_release_dev - free a pci device structure when all users of it are finished.
+ * @dev: device that's been disconnected
+ *
+ * Will be called only by the device core when all users of this vga device are
+ * done.
+ */
+
+static void vga_release_dev(struct device *dev)
+{
+	struct vga_dev *vdev = to_vga_dev(dev);
+	/* We want this very late because the remove methods might want to
+	   use the locks */
+
+	printk("%s\n", __FUNCTION__);
+	vga_take_lock(vdev, NULL, NULL);
+	vga_drop_lock(vdev, NULL);
+	down(&vdev->shared->shared_sem);
+	vdev->shared->device[vdev->unit] = NULL;
+	vdev->shared->count --;
+	up(&vdev->shared->shared_sem);
+	if(vdev->shared->count == 0)
+		kfree(vdev->shared);
+	kfree(vdev);
+}
+
+/**
+ *	vga_remove_one		-	Remove vga adapter
+ *	@pdev: PCI device
+ *
+ *	A VGA adapter has been removed. We must propogate this into the
+ *	VGA bus world
+ */
+
+static void vga_remove_one(struct pci_dev *pdev)
+{
+	struct vga_dev *vdev = (struct vga_dev *)pdev->dev.driver_data;
+
+	printk("%s\n", __FUNCTION__);
+	device_unregister(&vdev->dev);
+	/* Remove from lists etc here */
+	vga_dev_put(vdev);
+}
+
+/**
+ *	vga_found_one		-	Add vga adapter
+ *	@pdev: PCI device
+ *	@ent: matching PCI entity
+ *
+ *	Allocate and install a new VGA class entity set after the PCI layer
+ *	discovers it.  We create device objects for the frame buffer,
+ *	memory manager and dri objects at the moment. Additional frame
+ *	buffer objects (multihead) can be allocated by the callers.
+ */
+
+static int vga_found_one(struct pci_dev *pdev,
+					const struct pci_device_id *ent)
+{
+	struct vga_shared *vshar = kmalloc(sizeof(*vshar), GFP_KERNEL);
+	int i;
+	if(vshar == NULL)
+		return -ENOMEM;
+
+	printk("%s\n", __FUNCTION__);
+	memset(vshar, 0, sizeof(*vshar));
+	init_MUTEX(&vshar->shared_sem);
+	init_MUTEX(&vshar->fb_sem);
+	vshar->lock_owner = NULL;
+
+	for(i = TYPE_MEM; i <= TYPE_FB0; i++)
+	{
+		struct vga_dev *vdev = kmalloc(sizeof(*vdev), GFP_KERNEL);
+		if(vdev == NULL)
+			return -ENOMEM;
+		memset(vdev, 0, sizeof(*vdev));
+
+		vdev->pci_dev = pdev;
+		vdev->shared = vshar;
+		vdev->unit = i;
+
+		sprintf(vdev->dev.bus_id, "vga%02X:%02X", vshar->count, vdev->unit);
+		vshar->device[i] = vdev;
+		vshar->count ++;
+
+		vdev->dev.bus = &vga_bus_type;
+		vdev->dev.parent = &pdev->dev;	/* ? */
+		vdev->dev.driver_data = pdev;
+		device_initialize(&vdev->dev);
+		vdev->dev.release = vga_release_dev;
+		vdev->dev.dma_mask = pdev->dev.dma_mask;
+		vdev->dev.coherent_dma_mask = pdev->dev.coherent_dma_mask;
+		vga_dev_get(vdev);
+
+		INIT_LIST_HEAD(&vdev->next);
+		list_add_tail(&vdev->next, &vga_devices);
+		device_add(&vdev->dev);
+	}
+	return 1;
+}
+
+/*
+ *	Match all video VGA class objects
+ */
+
+static struct pci_device_id vga_id_table[] = {
+	{ PCI_DEVICE_CLASS(((PCI_CLASS_DISPLAY_VGA << 8) | 0x00), ~0), },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, vga_id_table);
+
+static struct pci_driver vga_driver = {
+	.name		= "vga",
+	.probe		= vga_found_one,
+	.remove		= vga_remove_one,
+	.id_table	= vga_id_table,
+	/* Could use suspend/resume hooks ? */
+};
+
+EXPORT_SYMBOL(vga_register_driver);
+EXPORT_SYMBOL(vga_unregister_driver);
+EXPORT_SYMBOL(vga_dev_driver);
+EXPORT_SYMBOL(vga_bus_type);
+EXPORT_SYMBOL(vga_dev_get);
+EXPORT_SYMBOL(vga_dev_put);
+
+int __init vga_driver_init(void)
+{
+	if( bus_register(&vga_bus_type) < 0)
+		printk(KERN_ERR "Unable to register VGA bus type.\n");
+	return pci_module_init(&vga_driver);
+}
+
+
+postcore_initcall(vga_driver_init);
diff -Nru a/include/linux/vga_class.h b/include/linux/vga_class.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/vga_class.h	Wed Sep 29 21:29:06 2004
@@ -0,0 +1,71 @@
+#ifndef _LINUX_VGA_CLASS_H
+#define _LINUX_VGA_CLASS_H
+
+
+#define TYPE_MEM                0       /* Memory manager */
+#define TYPE_COMMON		1	/* Lowlevel common code */
+#define TYPE_DRI		2	/* Direct render agent */
+#define TYPE_FB0		3	/* Frame buffer head 0 */
+#define TYPE_FB1		4	/* Frame buffer head 1 */
+#define TYPE_FB2		5	/* Frame buffer head 2 */
+#define TYPE_FB3		6	/* Frame buffer head 3 */
+#define TYPE_LAST		7
+#define NUM_TYPES		8
+
+struct vga_shared {
+	struct vga_dev *device[NUM_TYPES];
+	struct semaphore shared_sem;
+	int count;			/* Devices */
+	int users;			/* Active users */
+	struct semaphore fb_sem;
+	void (*lock_release)(struct vga_dev *, void *);
+	void *lock_context;
+	struct vga_driver *lock_owner;
+};
+
+struct vga_dev {
+	struct list_head next;		/* All VGA devices */
+	struct list_head router_list;	/* By VGA router (not yet done) */
+	struct vga_driver *driver;
+	struct pci_dev *pci_dev;
+	struct device dev;
+	int unit;
+	struct vga_shared *shared;
+};
+
+struct vga_device_id {
+	__u32 vendor, device;		/* Vendor and device ID or PCI_ANY_ID*/
+	__u32 subvendor, subdevice;	/* Subsystem ID's or PCI_ANY_ID */
+	__u32 class, class_mask;	/* (class,subclass,prog-if) triplet */
+	__u32 unit;			/* Logical unit for attach */
+	kernel_ulong_t driver_data;	/* Data private to the driver */
+};
+
+
+#define	to_vga_dev(n) container_of(n, struct vga_dev, dev)
+
+struct vga_driver {
+	struct list_head node;
+	int type;
+	char *name;
+	int (*probe) (struct vga_dev *vdev, const struct vga_device_id *id);
+	void (*remove) (struct vga_dev *dev, int users);	/* Device removed (NULL if not a hot-plug capable driver) */
+	int  (*suspend) (struct vga_dev *vdev, u32 state);	/* Device suspended */	int  (*resume) (struct vga_dev *vdev);	                /* Device woken up */
+	void (*notify_attach) (struct vga_dev *, int);
+	void (*notify_detach) (struct vga_dev *, int);
+	struct device_driver driver;
+	struct vga_device_id *id_table;
+};
+
+#define to_vga_driver(drv) container_of(drv, struct vga_driver, driver)
+
+extern struct bus_type vga_bus_type;
+
+extern int vga_register_driver(struct vga_driver *drv);
+extern void vga_unregister_driver(struct vga_driver *drv);
+extern struct vga_driver *vga_dev_driver(const struct vga_dev *, int);
+extern struct bus_type vga_bus_type;
+extern struct vga_dev *vga_dev_get(struct vga_dev *);
+extern void vga_dev_put(struct vga_dev *);
+
+#endif
