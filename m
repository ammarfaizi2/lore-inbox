Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbUKAGB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbUKAGB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 01:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbUKAGB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 01:01:56 -0500
Received: from ozlabs.org ([203.10.76.45]:18410 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261382AbUKAGBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 01:01:33 -0500
Subject: Re: [PATCH} Trivial - fix drm_agp symbol export
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339104102311229276d8@mail.gmail.com>
References: <9e473391041022214570eab48a@mail.gmail.com>
	 <20041023095644.GC30137@infradead.org>
	 <9e47339104102311229276d8@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 17:01:29 +1100
Message-Id: <1099288890.25525.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 14:22 -0400, Jon Smirl wrote:
> There are still coding style issues. These are slowly getting fixed
> but on the other hand we don't want to break the working code. We can
> fix a few more on each round of submissions. Main highlights of this
> version are elimination of the DRM() macros and elminination of
> inter_module() use for both DRM and AGP.

Delighted to hear it.  I've pushed this patch on and off for a couple of
years now; if you're working on this actively it's probably only good
for a laugh.

Thanks,
Rusty.

Name: Removed inter_module functions from DRM
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Status: Compiles

Gets rid of inter_module* from DRM drivers, in favour of exporting
symbols and using symbol_get.

This is a classic example of a soft-dependency: DRM wants to use AGP
if it's available, but doesn't want to rely on it.  It's limited, in
that loading an AGP driver later won't be used, but it exists.

Index: linux-2.6.10-rc1-bk10-Module/drivers/char/drm/base.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc1-bk10-Module/drivers/char/drm/base.c	2004-11-01 16:34:56.472190960 +1100
@@ -0,0 +1,44 @@
+/* This (racy) hack exists because the DRM coders are taking
+ * Linux-incompatible drugs.  The second drm module attempts to share
+ * the drm_stub_info with whoever got there first: this is detected by
+ * register_chrdev returning -EBUSY.  There's no locking, and it's not
+ * clear that loading two drm modules actually does anything useful.
+ *
+ * Copyright (C) 2004  Rusty Russell IBM Corporation
+ */
+#include <linux/module.h>
+
+struct drm_stub_info;
+
+static struct drm_stub_info *drm_stub;
+static struct module *drm_stub_owner;
+
+/* Registers a new stub. */
+void drm_stub_set(struct drm_stub_info *stub_info, struct module *owner)
+{
+	drm_stub = stub_info;
+	drm_stub_owner = owner;
+}
+void drm_stub_unset(void)
+{
+	drm_stub = NULL;
+	drm_stub_owner = NULL;
+}
+
+/* Get and put. */
+struct drm_stub_info *drm_stub_get(void)
+{
+	if (drm_stub) {
+		__module_get(drm_stub_owner);
+		return drm_stub;
+	}
+	return NULL;
+}
+void drm_stub_put(void)
+{
+	module_put(drm_stub_owner);
+}
+EXPORT_SYMBOL(drm_stub_set);
+EXPORT_SYMBOL(drm_stub_unset);
+EXPORT_SYMBOL(drm_stub_get);
+EXPORT_SYMBOL(drm_stub_put);
Index: linux-2.6.10-rc1-bk10-Module/drivers/char/drm/Makefile
===================================================================
--- linux-2.6.10-rc1-bk10-Module.orig/drivers/char/drm/Makefile	2004-10-19 14:33:57.000000000 +1000
+++ linux-2.6.10-rc1-bk10-Module/drivers/char/drm/Makefile	2004-11-01 16:34:56.472190960 +1100
@@ -13,6 +13,8 @@
 ffb-objs    := ffb_drv.o ffb_context.o
 sis-objs    := sis_drv.o sis_ds.o sis_mm.o
 
+obj-y			:= base.o
+
 obj-$(CONFIG_DRM_GAMMA) += gamma.o
 obj-$(CONFIG_DRM_TDFX)	+= tdfx.o
 obj-$(CONFIG_DRM_R128)	+= r128.o
Index: linux-2.6.10-rc1-bk10-Module/drivers/char/drm/drmP.h
===================================================================
--- linux-2.6.10-rc1-bk10-Module.orig/drivers/char/drm/drmP.h	2004-10-19 14:33:57.000000000 +1000
+++ linux-2.6.10-rc1-bk10-Module/drivers/char/drm/drmP.h	2004-11-01 16:34:56.474190656 +1100
@@ -724,6 +724,14 @@
 
 extern void DRM(driver_register_fns)(struct drm_device *dev);
 
+/* drm functions for handling registration of stubs in base.c */
+struct drm_stub_info;
+extern void drm_stub_set(struct drm_stub_info *, struct module *owner);
+extern void drm_stub_unset(void);
+extern struct drm_stub_info *drm_stub_get(void);
+extern void drm_stub_put(void);
+
+
 /******************************************************************/
 /** \name Internal function definitions */
 /*@{*/
Index: linux-2.6.10-rc1-bk10-Module/drivers/char/agp/backend.c
===================================================================
--- linux-2.6.10-rc1-bk10-Module.orig/drivers/char/agp/backend.c	2004-06-17 08:48:07.000000000 +1000
+++ linux-2.6.10-rc1-bk10-Module/drivers/char/agp/backend.c	2004-11-01 16:34:56.471191112 +1100
@@ -214,7 +214,7 @@
 				phys_to_virt(bridge->scratch_page_real));
 }
 
-static const drm_agp_t drm_agp = {
+const drm_agp_t drm_agp = {
 	&agp_free_memory,
 	&agp_allocate_memory,
 	&agp_bind_memory,
@@ -224,6 +224,7 @@
 	&agp_backend_release,
 	&agp_copy_info
 };
+EXPORT_SYMBOL(drm_agp);
 
 /* XXX Kludge alert: agpgart isn't ready for multiple bridges yet */
 struct agp_bridge_data *agp_alloc_bridge(void)
@@ -277,9 +278,6 @@
 		goto frontend_err;
 	}
 
-	/* FIXME: What to do with this? */
-	inter_module_register("drm_agp", THIS_MODULE, &drm_agp);
-
 	agp_count++;
 	return 0;
 
@@ -298,7 +296,6 @@
 	bridge->type = NOT_SUPPORTED;
 	agp_frontend_cleanup();
 	agp_backend_cleanup(bridge);
-	inter_module_unregister("drm_agp");
 	agp_count--;
 	module_put(bridge->driver->owner);
 }
Index: linux-2.6.10-rc1-bk10-Module/drivers/char/drm/drm_stub.h
===================================================================
--- linux-2.6.10-rc1-bk10-Module.orig/drivers/char/drm/drm_stub.h	2004-06-17 08:48:07.000000000 +1000
+++ linux-2.6.10-rc1-bk10-Module/drivers/char/drm/drm_stub.h	2004-11-01 16:34:56.477190200 +1100
@@ -145,9 +145,9 @@
 			  DRM(stub_list)[minor].dev_root);
 	if (minor) {
 		class_simple_device_remove(MKDEV(DRM_MAJOR, minor));
-		inter_module_put("drm");
+		drm_stub_put();
 	} else {
-		inter_module_unregister("drm");
+		drm_stub_unset();
 		DRM(free)(DRM(stub_list),
 			  sizeof(*DRM(stub_list)) * DRM_STUB_MAXCARDS,
 			  DRM_MEM_STUB);
@@ -190,7 +190,7 @@
 		}
 	}
 	else if (ret1 == -EBUSY)
-		i = (struct drm_stub_info *)inter_module_get("drm");
+		i = drm_stub_get();
 	else
 		return -1;
 
@@ -202,8 +202,8 @@
 	} else if (DRM(stub_info).info_register != DRM(stub_getminor)) {
 		DRM(stub_info).info_register   = DRM(stub_getminor);
 		DRM(stub_info).info_unregister = DRM(stub_putminor);
-		DRM_DEBUG("calling inter_module_register\n");
-		inter_module_register("drm", THIS_MODULE, &DRM(stub_info));
+		DRM_DEBUG("calling drm_stub_set\n");
+		drm_stub_set(&DRM(stub_info), THIS_MODULE);
 	}
 	if (DRM(stub_info).info_register) {
 		ret2 = DRM(stub_info).info_register(name, fops, dev);
@@ -213,7 +213,7 @@
 				class_simple_destroy(drm_class);
 			}
 			if (!i)
-				inter_module_unregister("drm");
+				drm_stub_unset();
 		}
 		return ret2;
 	}
Index: linux-2.6.10-rc1-bk10-Module/include/linux/agp_backend.h
===================================================================
--- linux-2.6.10-rc1-bk10-Module.orig/include/linux/agp_backend.h	2003-09-22 10:08:38.000000000 +1000
+++ linux-2.6.10-rc1-bk10-Module/include/linux/agp_backend.h	2004-11-01 16:34:56.484189136 +1100
@@ -112,7 +112,8 @@
 	int			(*copy_info)(struct agp_kern_info *);
 } drm_agp_t;
 
-extern const drm_agp_t *drm_agp_p;
+/* Used by drm. */
+extern const drm_agp_t drm_agp;
 
 #endif				/* __KERNEL__ */
 #endif				/* _AGP_BACKEND_H */
Index: linux-2.6.10-rc1-bk10-Module/drivers/char/drm/drm_agpsupport.h
===================================================================
--- linux-2.6.10-rc1-bk10-Module.orig/drivers/char/drm/drm_agpsupport.h	2004-10-19 14:33:57.000000000 +1000
+++ linux-2.6.10-rc1-bk10-Module/drivers/char/drm/drm_agpsupport.h	2004-11-01 16:36:21.824215480 +1100
@@ -36,13 +36,13 @@
 
 #if __OS_HAS_AGP
 
-#define DRM_AGP_GET (drm_agp_t *)inter_module_get("drm_agp")
-#define DRM_AGP_PUT inter_module_put("drm_agp")
+#define DRM_AGP_GET symbol_get(drm_agp)
+#define DRM_AGP_PUT symbol_put(drm_agp)
 
 /**
  * Pointer to the drm_agp_t structure made available by the agpgart module.
  */
-static const drm_agp_t *drm_agp = NULL;
+static const drm_agp_t *drm_agp_p = NULL;
 
 /**
  * AGP information ioctl.
@@ -64,7 +64,7 @@
 	DRM_AGP_KERN     *kern;
 	drm_agp_info_t   info;
 
-	if (!dev->agp || !dev->agp->acquired || !drm_agp->copy_info)
+	if (!dev->agp || !dev->agp->acquired || !drm_agp_p->copy_info)
 		return -EINVAL;
 
 	kern                   = &dev->agp->agp_info;
@@ -93,7 +93,7 @@
  * \return zero on success or a negative number on failure. 
  *
  * Verifies the AGP device hasn't been acquired before and calls
- * drm_agp->acquire().
+ * drm_agp_p->acquire().
  */
 int DRM(agp_acquire)(struct inode *inode, struct file *filp,
 		     unsigned int cmd, unsigned long arg)
@@ -106,9 +106,9 @@
 		return -ENODEV;
 	if (dev->agp->acquired)
 		return -EBUSY;
-	if (!drm_agp->acquire)
+	if (!drm_agp_p->acquire)
 		return -EINVAL;
-	if ((retcode = drm_agp->acquire()))
+	if ((retcode = drm_agp_p->acquire()))
 		return retcode;
 	dev->agp->acquired = 1;
 	return 0;
@@ -123,7 +123,7 @@
  * \param arg user argument.
  * \return zero on success or a negative number on failure.
  *
- * Verifies the AGP device has been acquired and calls drm_agp->release().
+ * Verifies the AGP device has been acquired and calls drm_agp_p->release().
  */
 int DRM(agp_release)(struct inode *inode, struct file *filp,
 		     unsigned int cmd, unsigned long arg)
@@ -131,9 +131,9 @@
 	drm_file_t	 *priv	 = filp->private_data;
 	drm_device_t	 *dev	 = priv->dev;
 
-	if (!dev->agp || !dev->agp->acquired || !drm_agp->release)
+	if (!dev->agp || !dev->agp->acquired || !drm_agp_p->release)
 		return -EINVAL;
-	drm_agp->release();
+	drm_agp_p->release();
 	dev->agp->acquired = 0;
 	return 0;
 
@@ -142,12 +142,12 @@
 /**
  * Release the AGP device.
  *
- * Calls drm_agp->release().
+ * Calls drm_agp_p->release().
  */
 void DRM(agp_do_release)(void)
 {
-	if (drm_agp->release)
-		drm_agp->release();
+	if (drm_agp_p->release)
+		drm_agp_p->release();
 }
 
 /**
@@ -160,7 +160,7 @@
  * \return zero on success or a negative number on failure.
  *
  * Verifies the AGP device has been acquired but not enabled, and calls
- * drm_agp->enable().
+ * drm_agp_p->enable().
  */
 int DRM(agp_enable)(struct inode *inode, struct file *filp,
 		    unsigned int cmd, unsigned long arg)
@@ -169,14 +169,14 @@
 	drm_device_t	 *dev	 = priv->dev;
 	drm_agp_mode_t   mode;
 
-	if (!dev->agp || !dev->agp->acquired || !drm_agp->enable)
+	if (!dev->agp || !dev->agp->acquired || !drm_agp_p->enable)
 		return -EINVAL;
 
 	if (copy_from_user(&mode, (drm_agp_mode_t __user *)arg, sizeof(mode)))
 		return -EFAULT;
 
 	dev->agp->mode    = mode.mode;
-	drm_agp->enable(mode.mode);
+	drm_agp_p->enable(mode.mode);
 	dev->agp->base    = dev->agp->agp_info.aper_base;
 	dev->agp->enabled = 1;
 	return 0;
@@ -325,7 +325,7 @@
 	int               retcode;
 	int               page;
 
-	if (!dev->agp || !dev->agp->acquired || !drm_agp->bind_memory)
+	if (!dev->agp || !dev->agp->acquired || !drm_agp_p->bind_memory)
 		return -EINVAL;
 	if (copy_from_user(&request, (drm_agp_binding_t __user *)arg, sizeof(request)))
 		return -EFAULT;
@@ -392,19 +392,18 @@
  * \return pointer to a drm_agp_head structure.
  *
  * Gets the drm_agp_t structure which is made available by the agpgart module
- * via the inter_module_* functions. Creates and initializes a drm_agp_head
- * structure.
+ * via symbol_get. Creates and initializes a drm_agp_head structure.
  */
 drm_agp_head_t *DRM(agp_init)(void)
 {
 	drm_agp_head_t *head         = NULL;
 
-	drm_agp = DRM_AGP_GET;
-	if (drm_agp) {
+	drm_agp_p = DRM_AGP_GET;
+	if (drm_agp_p) {
 		if (!(head = DRM(alloc)(sizeof(*head), DRM_MEM_AGPLISTS)))
 			return NULL;
 		memset((void *)head, 0, sizeof(*head));
-		drm_agp->copy_info(&head->agp_info);
+		drm_agp_p->copy_info(&head->agp_info);
 		if (head->agp_info.chipset == NOT_SUPPORTED) {
 			DRM(free)(head, sizeof(*head), DRM_MEM_AGPLISTS);
 			return NULL;
@@ -429,40 +428,40 @@
 void DRM(agp_uninit)(void)
 {
 	DRM_AGP_PUT;
-	drm_agp = NULL;
+	drm_agp_p = NULL;
 }
 
-/** Calls drm_agp->allocate_memory() */
+/** Calls drm_agp_p->allocate_memory() */
 DRM_AGP_MEM *DRM(agp_allocate_memory)(size_t pages, u32 type)
 {
-	if (!drm_agp->allocate_memory)
+	if (!drm_agp_p->allocate_memory)
 		return NULL;
-	return drm_agp->allocate_memory(pages, type);
+	return drm_agp_p->allocate_memory(pages, type);
 }
 
 /** Calls drm_agp->free_memory() */
 int DRM(agp_free_memory)(DRM_AGP_MEM *handle)
 {
-	if (!handle || !drm_agp->free_memory)
+	if (!handle || !drm_agp_p->free_memory)
 		return 0;
-	drm_agp->free_memory(handle);
+	drm_agp_p->free_memory(handle);
 	return 1;
 }
 
 /** Calls drm_agp->bind_memory() */
 int DRM(agp_bind_memory)(DRM_AGP_MEM *handle, off_t start)
 {
-	if (!handle || !drm_agp->bind_memory)
+	if (!handle || !drm_agp_p->bind_memory)
 		return -EINVAL;
-	return drm_agp->bind_memory(handle, start);
+	return drm_agp_p->bind_memory(handle, start);
 }
 
 /** Calls drm_agp->unbind_memory() */
 int DRM(agp_unbind_memory)(DRM_AGP_MEM *handle)
 {
-	if (!handle || !drm_agp->unbind_memory)
+	if (!handle || !drm_agp_p->unbind_memory)
 		return -EINVAL;
-	return drm_agp->unbind_memory(handle);
+	return drm_agp_p->unbind_memory(handle);
 }
 
 #endif /* __OS_HAS_AGP */

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

