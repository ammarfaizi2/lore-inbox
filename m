Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbULQUz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbULQUz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 15:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbULQUzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 15:55:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:31165 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262159AbULQUyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 15:54:19 -0500
From: Mike Werner <werner@sgi.com>
Reply-To: werner@sgi.com
To: davej@codemonkey.org.uk
Subject: [patch 2.6.10-rc3 3/4] agpgart: allow multiple backends to be initialized
Date: Fri, 17 Dec 2004 12:56:11 -0800
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412171256.11310.werner@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This new version reduces the number of changes required by users of the agpgart
such as drm to support the new api for multiple agp bridges. 
The first patch doesn't touch any platform specific files and all current platform
gart drivers will just work the same as they do now since the global 
agp_bridge is still supported as the default bridge.

Summary for the 4 patches.
[1/4] Allow multiple backends to be initialized for agpgart
[2/4] Run Lindent on generic.c
[3/4] Patch drm code to work with modified agpgart api.
[4/4] Patch framebuffer code to work with modified agpgart api.
-----------------------------------------------------------------------------
 drmP.h           |    9 +++++----
 drm_agpsupport.h |   34 +++++++++++++++++++++-------------
 drm_drv.h        |    4 ++--
 drm_memory.h     |    4 ++--
 4 files changed, 30 insertions(+), 21 deletions(-)

# This is a BitKeeper generated diff -Nru style patch.
#
#   add drm support for new multiple agp bridge agpgart api
# 
diff -Nru a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
--- a/drivers/char/drm/drmP.h	2004-12-17 12:12:56 -08:00
+++ b/drivers/char/drm/drmP.h	2004-12-17 12:12:56 -08:00
@@ -481,6 +481,7 @@
 	DRM_AGP_KERN       agp_info;	/**< AGP device information */
 	drm_agp_mem_t      *memory;	/**< memory entries */
 	unsigned long      mode;	/**< AGP mode */
+	struct agp_bridge_data  *bridge;
 	int                enabled;	/**< whether the AGP bus as been enabled */
 	int                acquired;	/**< whether the AGP device has been acquired */
 	unsigned long      base;
@@ -778,7 +779,7 @@
 					   drm_device_t *dev);
 extern void	     DRM(ioremapfree)(void *pt, unsigned long size, drm_device_t *dev);
 
-extern DRM_AGP_MEM   *DRM(alloc_agp)(int pages, u32 type);
+extern DRM_AGP_MEM   *DRM(alloc_agp)(struct agp_bridge_data *bridge, int pages, u32 type);
 extern int           DRM(free_agp)(DRM_AGP_MEM *handle, int pages);
 extern int           DRM(bind_agp)(DRM_AGP_MEM *handle, unsigned int start);
 extern int           DRM(unbind_agp)(DRM_AGP_MEM *handle);
@@ -896,11 +897,11 @@
 extern void          DRM(vbl_send_signals)( drm_device_t *dev );
 
 				/* AGP/GART support (drm_agpsupport.h) */
-extern drm_agp_head_t *DRM(agp_init)(void);
+extern drm_agp_head_t *DRM(agp_init)(drm_device_t *dev);
 extern void           DRM(agp_uninit)(void);
 extern int            DRM(agp_acquire)(struct inode *inode, struct file *filp,
 				       unsigned int cmd, unsigned long arg);
-extern void           DRM(agp_do_release)(void);
+extern void           DRM(agp_do_release)(drm_device_t *dev);
 extern int            DRM(agp_release)(struct inode *inode, struct file *filp,
 				       unsigned int cmd, unsigned long arg);
 extern int            DRM(agp_enable)(struct inode *inode, struct file *filp,
@@ -915,7 +916,7 @@
 				      unsigned int cmd, unsigned long arg);
 extern int            DRM(agp_bind)(struct inode *inode, struct file *filp,
 				    unsigned int cmd, unsigned long arg);
-extern DRM_AGP_MEM    *DRM(agp_allocate_memory)(size_t pages, u32 type);
+extern DRM_AGP_MEM    *DRM(agp_allocate_memory)(struct agp_bridge_data *bridge, size_t pages, u32 type);
 extern int            DRM(agp_free_memory)(DRM_AGP_MEM *handle);
 extern int            DRM(agp_bind_memory)(DRM_AGP_MEM *handle, off_t start);
 extern int            DRM(agp_unbind_memory)(DRM_AGP_MEM *handle);
diff -Nru a/drivers/char/drm/drm_agpsupport.h b/drivers/char/drm/drm_agpsupport.h
--- a/drivers/char/drm/drm_agpsupport.h	2004-12-17 12:12:56 -08:00
+++ b/drivers/char/drm/drm_agpsupport.h	2004-12-17 12:12:56 -08:00
@@ -100,7 +100,7 @@
 {
 	drm_file_t	 *priv	 = filp->private_data;
 	drm_device_t	 *dev	 = priv->dev;
-	int              retcode;
+	
 
 	if (!dev->agp)
 		return -ENODEV;
@@ -108,8 +108,8 @@
 		return -EBUSY;
 	if (!drm_agp->acquire)
 		return -EINVAL;
-	if ((retcode = drm_agp->acquire()))
-		return retcode;
+	if (!(dev->agp->bridge = drm_agp->acquire(dev->pdev)))
+		return -ENODEV;
 	dev->agp->acquired = 1;
 	return 0;
 }
@@ -133,7 +133,7 @@
 
 	if (!dev->agp || !dev->agp->acquired || !drm_agp->release)
 		return -EINVAL;
-	drm_agp->release();
+	drm_agp->release(dev->agp->bridge);
 	dev->agp->acquired = 0;
 	return 0;
 
@@ -144,10 +144,10 @@
  *
  * Calls drm_agp->release().
  */
-void DRM(agp_do_release)(void)
+void DRM(agp_do_release)(drm_device_t *dev)
 {
 	if (drm_agp->release)
-		drm_agp->release();
+		drm_agp->release(dev->agp->bridge);
 }
 
 /**
@@ -176,7 +176,7 @@
 		return -EFAULT;
 
 	dev->agp->mode    = mode.mode;
-	drm_agp->enable(mode.mode);
+	drm_agp->enable(dev->agp->bridge, mode.mode);
 	dev->agp->base    = dev->agp->agp_info.aper_base;
 	dev->agp->enabled = 1;
 	return 0;
@@ -218,7 +218,7 @@
 	pages = (request.size + PAGE_SIZE - 1) / PAGE_SIZE;
 	type = (u32) request.type;
 
-	if (!(memory = DRM(alloc_agp)(pages, type))) {
+	if (!(memory = DRM(alloc_agp)(dev->agp->bridge, pages, type))) {
 		DRM(free)(entry, sizeof(*entry), DRM_MEM_AGPLISTS);
 		return -ENOMEM;
 	}
@@ -395,16 +395,24 @@
  * via the inter_module_* functions. Creates and initializes a drm_agp_head
  * structure.
  */
-drm_agp_head_t *DRM(agp_init)(void)
+drm_agp_head_t *DRM(agp_init)(drm_device_t *dev)
 {
 	drm_agp_head_t *head         = NULL;
 
 	drm_agp = DRM_AGP_GET;
-	if (drm_agp) {
+	if (!drm_agp)
+		DRM_ERROR("DRM_AGP_GET returned NULL\n");
+	else
+		{
 		if (!(head = DRM(alloc)(sizeof(*head), DRM_MEM_AGPLISTS)))
 			return NULL;
 		memset((void *)head, 0, sizeof(*head));
-		drm_agp->copy_info(&head->agp_info);
+		if (!(head->bridge = drm_agp->acquire(dev->pdev))) {
+			DRM(free)(head, sizeof(*head), DRM_MEM_AGPLISTS);
+			return NULL;
+		}	
+		drm_agp->copy_info(head->bridge, &head->agp_info);
+		drm_agp->release(head->bridge);
 		if (head->agp_info.chipset == NOT_SUPPORTED) {
 			DRM(free)(head, sizeof(*head), DRM_MEM_AGPLISTS);
 			return NULL;
@@ -433,11 +441,11 @@
 }
 
 /** Calls drm_agp->allocate_memory() */
-DRM_AGP_MEM *DRM(agp_allocate_memory)(size_t pages, u32 type)
+DRM_AGP_MEM *DRM(agp_allocate_memory)(struct agp_bridge_data *bridge, size_t pages, u32 type)
 {
 	if (!drm_agp->allocate_memory)
 		return NULL;
-	return drm_agp->allocate_memory(pages, type);
+	return drm_agp->allocate_memory(bridge, pages, type);
 }
 
 /** Calls drm_agp->free_memory() */
diff -Nru a/drivers/char/drm/drm_drv.h b/drivers/char/drm/drm_drv.h
--- a/drivers/char/drm/drm_drv.h	2004-12-17 12:12:56 -08:00
+++ b/drivers/char/drm/drm_drv.h	2004-12-17 12:12:56 -08:00
@@ -318,7 +318,7 @@
 		}
 		dev->agp->memory = NULL;
 
-		if ( dev->agp->acquired ) DRM(agp_do_release)();
+		if ( dev->agp->acquired ) DRM(agp_do_release)( dev);
 
 		dev->agp->acquired = 0;
 		dev->agp->enabled  = 0;
@@ -490,7 +490,7 @@
 
 	if (drm_core_has_AGP(dev))
 	{
-		dev->agp = DRM(agp_init)();
+		dev->agp = DRM(agp_init)(dev);
 		if (drm_core_check_feature(dev, DRIVER_REQUIRE_AGP) && (dev->agp == NULL)) {
 			DRM_ERROR( "Cannot initialize the agpgart module.\n" );
 			DRM(stub_unregister)(dev->minor);
diff -Nru a/drivers/char/drm/drm_memory.h b/drivers/char/drm/drm_memory.h
--- a/drivers/char/drm/drm_memory.h	2004-12-17 12:12:56 -08:00
+++ b/drivers/char/drm/drm_memory.h	2004-12-17 12:12:56 -08:00
@@ -343,9 +343,9 @@
 
 #if __OS_HAS_AGP
 /** Wrapper around agp_allocate_memory() */
-DRM_AGP_MEM *DRM(alloc_agp)(int pages, u32 type)
+DRM_AGP_MEM *DRM(alloc_agp)(struct agp_bridge_data *bridge, int pages, u32 type)
 {
-	return DRM(agp_allocate_memory)(pages, type);
+	return DRM(agp_allocate_memory)(bridge, pages, type);
 }
 
 /** Wrapper around agp_free_memory() */
