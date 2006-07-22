Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWGVPia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWGVPia (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 11:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWGVPiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 11:38:07 -0400
Received: from wm402rot.66.ADSL.NetSurf.Net ([66.135.97.66]:36738 "EHLO
	png3r11.pngxnet.com") by vger.kernel.org with ESMTP
	id S1750813AbWGVPhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 11:37:38 -0400
From: Dave Airlie <airlied@linux.ie>
To: linux-kernel@vger.kernel.org
Cc: Dave Airlie <airlied@linux.ie>
Subject: [PATCH] gpu/drm: Add GPU layer support to generic DRM (06/07)
Date: Sun, 23 Jul 2006 01:38:32 +1000
Message-Id: <11535827143978-git-send-email-airlied@linux.ie>
X-Mailer: git-send-email 1.4.1.ga3e6
In-Reply-To: <11535827142307-git-send-email-airlied@linux.ie>
References: <11535827134076-git-send-email-airlied@linux.ie> <11535827133352-git-send-email-airlied@linux.ie> <11535827131612-git-send-email-airlied@linux.ie> <11535827132905-git-send-email-airlied@linux.ie> <11535827141780-git-send-email-airlied@linux.ie> <11535827142307-git-send-email-airlied@linux.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the GPU layer support to the drm library.
It doesn't touch any drivers just adds the gpu layer to the drm code.

Signed-off-by: Dave Airlie <airlied@linux.ie>
---
 drivers/char/drm/Makefile     |    2 +
 drivers/char/drm/drmP.h       |   16 ++++++++++
 drivers/char/drm/drm_drv.c    |   10 +++++--
 drivers/char/drm/drm_gpu.c    |   63 +++++++++++++++++++++++++++++++++++++++++
 drivers/char/drm/drm_ioctl.c  |    8 +++--
 drivers/char/drm/drm_memory.c |    1 +
 drivers/char/drm/drm_stub.c   |   31 +++++++++-----------
 drivers/char/drm/drm_sysfs.c  |   14 +++++++--
 8 files changed, 116 insertions(+), 29 deletions(-)

diff --git a/drivers/char/drm/Makefile b/drivers/char/drm/Makefile
index 9d180c4..150d735 100644
--- a/drivers/char/drm/Makefile
+++ b/drivers/char/drm/Makefile
@@ -6,7 +6,7 @@ drm-objs    :=	drm_auth.o drm_bufs.o drm
 		drm_drv.o drm_fops.o drm_ioctl.o drm_irq.o \
 		drm_lock.o drm_memory.o drm_proc.o drm_stub.o drm_vm.o \
 		drm_agpsupport.o drm_scatter.o ati_pcigart.o drm_pci.o \
-		drm_sysfs.o
+		drm_sysfs.o drm_gpu.o
 
 tdfx-objs   := tdfx_drv.o
 r128-objs   := r128_drv.o r128_cce.o r128_state.o r128_irq.o
diff --git a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
index 4dd28e1..ae590d5 100644
--- a/drivers/char/drm/drmP.h
+++ b/drivers/char/drm/drmP.h
@@ -52,6 +52,7 @@ #include <linux/proc_fs.h>
 #include <linux/init.h>
 #include <linux/file.h>
 #include <linux/pci.h>
+#include <linux/gpu_layer.h>
 #include <linux/jiffies.h>
 #include <linux/smp_lock.h>	/* For (un)lock_kernel */
 #include <linux/mm.h>
@@ -532,6 +533,10 @@ typedef struct ati_pcigart_info {
  * a family of cards. There will one drm_device for each card present
  * in this family
  */
+
+#define DRM_DRV_PCI 1
+#define DRM_DRV_GPU 2
+
 struct drm_device;
 
 struct drm_driver {
@@ -592,6 +597,9 @@ struct drm_driver {
 	drm_ioctl_desc_t *ioctls;
 	int num_ioctls;
 	struct file_operations fops;
+	int drv_type;
+
+	struct gpu_driver gpu_driver;
 	struct pci_driver pci_driver;
 };
 
@@ -710,6 +718,8 @@ typedef struct drm_device {
 
 	drm_agp_head_t *agp;	/**< AGP data */
 
+	/* a pointer to the GPU device */
+	struct gpu_device *gdev;
 	struct pci_dev *pdev;		/**< PCI device structure */
 #ifdef __alpha__
 	struct pci_controller *hose;
@@ -791,9 +801,12 @@ #endif
 /******************************************************************/
 /** \name Internal function definitions */
 /*@{*/
+extern void drm_gpu_cleanup(struct gpu_device *gdev);
+extern int drm_gpu_get_dev(struct gpu_device *gdev, struct drm_driver *driver, void *driver_id, struct pci_dev *pdev);
 
 				/* Driver support (drm_drv.h) */
 extern int drm_init(struct drm_driver *driver);
+extern void drm_cleanup(drm_device_t * dev);
 extern void drm_exit(struct drm_driver *driver);
 extern int drm_ioctl(struct inode *inode, struct file *filp,
 		     unsigned int cmd, unsigned long arg);
@@ -972,9 +985,12 @@ extern int drm_agp_bind_memory(DRM_AGP_M
 extern int drm_agp_unbind_memory(DRM_AGP_MEM * handle);
 
 				/* Stub support (drm_stub.h) */
+extern int drm_fill_in_dev(drm_device_t * dev, unsigned long driver_data,
+			   struct drm_driver *driver);
 extern int drm_get_dev(struct pci_dev *pdev, const struct pci_device_id *ent,
 		       struct drm_driver *driver);
 extern int drm_put_dev(drm_device_t * dev);
+extern int drm_get_head(drm_device_t * dev, drm_head_t * head);
 extern int drm_put_head(drm_head_t * head);
 extern unsigned int drm_debug;
 extern unsigned int drm_cards_limit;
diff --git a/drivers/char/drm/drm_drv.c b/drivers/char/drm/drm_drv.c
index 3c0b882..04443d0 100644
--- a/drivers/char/drm/drm_drv.c
+++ b/drivers/char/drm/drm_drv.c
@@ -260,6 +260,8 @@ int drm_init(struct drm_driver *driver)
 
 	drm_mem_init();
 
+	driver->drv_type = DRM_DRV_PCI;
+
 	for (i = 0; driver->pci_driver.id_table[i].vendor != 0; i++) {
 		pid = (struct pci_device_id *)&driver->pci_driver.id_table[i];
 
@@ -285,7 +287,7 @@ EXPORT_SYMBOL(drm_init);
  *
  * \sa drm_init
  */
-static void drm_cleanup(drm_device_t * dev)
+void drm_cleanup(drm_device_t * dev)
 {
 	DRM_DEBUG("\n");
 
@@ -344,8 +346,10 @@ void drm_exit(struct drm_driver *driver)
 		dev = head->dev;
 		if (dev) {
 			/* release the pci driver */
-			if (dev->pdev)
-				pci_dev_put(dev->pdev);
+			if (dev->pdev && (dev->driver->drv_type == DRM_DRV_PCI)) {
+				if (dev->pdev)
+					pci_dev_put(dev->pdev);
+			}
 			drm_cleanup(dev);
 		}
 	}
diff --git a/drivers/char/drm/drm_gpu.c b/drivers/char/drm/drm_gpu.c
new file mode 100644
index 0000000..1ab750a
--- /dev/null
+++ b/drivers/char/drm/drm_gpu.c
@@ -0,0 +1,63 @@
+/*
+ * drivers/char/drm/drm_gpu.c
+ *
+ * Copyright (C) Dave Airlie <airlied@linux.ie>
+ *
+ * Unlike the rest of the DRM this is actually GPL licensed
+ * as it doesn't make much sense for it to be MIT.
+ */
+#include "drmP.h"
+
+/* DRM GPU Interface layer */
+
+int drm_gpu_get_dev(struct gpu_device *gdev, struct drm_driver *driver, void *driver_id, struct pci_dev *pdev)
+{
+	drm_device_t *dev;
+	int ret;
+	struct pci_device_id *id = (struct pci_device_id *)driver_id;
+	unsigned long driver_data = id->driver_data;
+
+	DRM_DEBUG("\n");
+
+	dev = drm_calloc(1, sizeof(*dev), DRM_MEM_STUB);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->gdev = gdev;
+	dev->pdev = pdev;
+#ifdef __alpha__
+	dev->hose = pdev->sysdata;
+#endif
+	dev->irq = pdev->irq;
+
+	if ((ret = drm_fill_in_dev(dev, driver_data, driver))) {
+		printk(KERN_ERR "DRM: Fill_in_dev failed.\n");
+		goto err_g1;
+	}
+
+	if ((ret = drm_get_head(dev, &dev->primary)))
+		goto err_g1;
+
+	gpu_set_drvdata(gdev, dev);
+
+	DRM_INFO("Initialized GPU %s %d.%d.%d %s on minor %d\n",
+		 driver->name, driver->major, driver->minor, driver->patchlevel,
+		 driver->date, dev->primary.minor);
+	return 0;
+
+err_g1:
+	drm_free(dev, sizeof(*dev), DRM_MEM_STUB);
+	return 0;
+}
+EXPORT_SYMBOL(drm_gpu_get_dev);
+
+void drm_gpu_cleanup(struct gpu_device *gdev)
+{
+	drm_device_t *dev = gpu_get_drvdata(gdev);
+
+	gpu_set_drvdata(gdev, NULL);
+	if (dev)
+		drm_cleanup(dev);
+}
+EXPORT_SYMBOL(drm_gpu_cleanup);
+
diff --git a/drivers/char/drm/drm_ioctl.c b/drivers/char/drm/drm_ioctl.c
index 9d9f988..74fb274 100644
--- a/drivers/char/drm/drm_ioctl.c
+++ b/drivers/char/drm/drm_ioctl.c
@@ -110,12 +110,12 @@ int drm_setunique(struct inode *inode, s
 	dev->unique[dev->unique_len] = '\0';
 
 	dev->devname =
-	    drm_alloc(strlen(dev->driver->pci_driver.name) +
+	    drm_alloc(strlen(dev->driver->name) +
 		      strlen(dev->unique) + 2, DRM_MEM_DRIVER);
 	if (!dev->devname)
 		return -ENOMEM;
 
-	sprintf(dev->devname, "%s@%s", dev->driver->pci_driver.name,
+	sprintf(dev->devname, "%s@%s", dev->driver->name,
 		dev->unique);
 
 	/* Return error if the busid submitted doesn't match the device's actual
@@ -157,12 +157,12 @@ static int drm_set_busid(drm_device_t * 
 		DRM_ERROR("Unique buffer overflowed\n");
 
 	dev->devname =
-	    drm_alloc(strlen(dev->driver->pci_driver.name) + dev->unique_len +
+	    drm_alloc(strlen(dev->driver->name) + dev->unique_len +
 		      2, DRM_MEM_DRIVER);
 	if (dev->devname == NULL)
 		return ENOMEM;
 
-	sprintf(dev->devname, "%s@%s", dev->driver->pci_driver.name,
+	sprintf(dev->devname, "%s@%s", dev->driver->name,
 		dev->unique);
 
 	return 0;
diff --git a/drivers/char/drm/drm_memory.c b/drivers/char/drm/drm_memory.c
index 5681cae..96d962d 100644
--- a/drivers/char/drm/drm_memory.c
+++ b/drivers/char/drm/drm_memory.c
@@ -44,6 +44,7 @@ #else
 void drm_mem_init(void)
 {
 }
+EXPORT_SYMBOL(drm_mem_init);
 
 /**
  * Called when "/proc/dri/%dev%/mem" is read.
diff --git a/drivers/char/drm/drm_stub.c b/drivers/char/drm/drm_stub.c
index 96449d5..b2e63c8 100644
--- a/drivers/char/drm/drm_stub.c
+++ b/drivers/char/drm/drm_stub.c
@@ -53,9 +53,8 @@ drm_head_t **drm_heads;
 struct class *drm_class;
 struct proc_dir_entry *drm_proc_root;
 
-static int drm_fill_in_dev(drm_device_t * dev, struct pci_dev *pdev,
-			   const struct pci_device_id *ent,
-			   struct drm_driver *driver)
+int drm_fill_in_dev(drm_device_t * dev, unsigned long driver_data,
+		    struct drm_driver *driver)
 {
 	int retcode;
 
@@ -64,16 +63,6 @@ static int drm_fill_in_dev(drm_device_t 
 	mutex_init(&dev->struct_mutex);
 	mutex_init(&dev->ctxlist_mutex);
 
-	dev->pdev = pdev;
-
-#ifdef __alpha__
-	dev->hose = pdev->sysdata;
-	dev->pci_domain = dev->hose->bus->number;
-#else
-	dev->pci_domain = 0;
-#endif
-	dev->irq = pdev->irq;
-
 	dev->maplist = drm_calloc(1, sizeof(*dev->maplist), DRM_MEM_MAPS);
 	if (dev->maplist == NULL)
 		return -ENOMEM;
@@ -91,7 +80,7 @@ #endif
 	dev->driver = driver;
 
 	if (dev->driver->load)
-		if ((retcode = dev->driver->load(dev, ent->driver_data)))
+		if ((retcode = dev->driver->load(dev, driver_data)))
 			goto error_out_unreg;
 
 	if (drm_core_has_AGP(dev)) {
@@ -137,7 +126,7 @@ #endif
  * create the proc init entry via proc_init(). This routines assigns
  * minor numbers to secondary heads of multi-headed cards
  */
-static int drm_get_head(drm_device_t * dev, drm_head_t * head)
+int drm_get_head(drm_device_t * dev, drm_head_t * head)
 {
 	drm_head_t **heads = drm_heads;
 	int ret;
@@ -208,14 +197,22 @@ int drm_get_dev(struct pci_dev *pdev, co
 
 	pci_enable_device(pdev);
 
-	if ((ret = drm_fill_in_dev(dev, pdev, ent, driver))) {
+	/* setup up PCI pointers */
+	dev->pdev = pdev;
+
+#ifdef __alpha__
+	dev->hose = pdev->sysdata;
+#endif
+	dev->irq = pdev->irq;
+
+	if ((ret = drm_fill_in_dev(dev, ent->driver_data, driver))) {
 		printk(KERN_ERR "DRM: Fill_in_dev failed.\n");
 		goto err_g1;
 	}
 	if ((ret = drm_get_head(dev, &dev->primary)))
 		goto err_g1;
 	
-	DRM_INFO("Initialized %s %d.%d.%d %s on minor %d\n",
+	DRM_INFO("Initialized PCI %s %d.%d.%d %s on minor %d\n",
 		 driver->name, driver->major, driver->minor, driver->patchlevel,
 		 driver->date, dev->primary.minor);
 
diff --git a/drivers/char/drm/drm_sysfs.c b/drivers/char/drm/drm_sysfs.c
index 51ad98c..eff610c 100644
--- a/drivers/char/drm/drm_sysfs.c
+++ b/drivers/char/drm/drm_sysfs.c
@@ -98,10 +98,16 @@ struct class_device *drm_sysfs_device_ad
 	struct class_device *class_dev;
 	int i;
 
-	class_dev = class_device_create(cs, NULL,
-					MKDEV(DRM_MAJOR, head->minor),
-					&(head->dev->pdev)->dev,
-					"card%d", head->minor);
+	if (head->dev->driver->drv_type == DRM_DRV_PCI)
+		class_dev = class_device_create(cs, NULL,
+						MKDEV(DRM_MAJOR, head->minor),
+						&(head->dev->pdev)->dev,
+						"card%d", head->minor);
+	else
+		class_dev = class_device_create(cs, NULL,
+						MKDEV(DRM_MAJOR, head->minor),
+						&(head->dev->gdev)->dev,
+						"card%d", head->minor);
 	if (!class_dev)
 		return NULL;
 
-- 
1.4.1.ga3e6

