Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUHREDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUHREDc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 00:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267252AbUHREDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 00:03:32 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:63733 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S267250AbUHREDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 00:03:14 -0400
Subject: Re: Oops modprobing i830 with 2.6.8.1
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dave Jones <davej@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       David =?ISO-8859-1?Q?H=E4rdeman?= <david@2gen.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040817234522.GA4170@redhat.com>
References: <20040817220816.GA14343@hardeman.nu>
	 <20040817233732.GA8264@redhat.com> <20040818004339.A27701@infradead.org>
	 <20040817234522.GA4170@redhat.com>
Content-Type: text/plain
Message-Id: <1092801681.27352.194.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 Aug 2004 14:01:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-18 at 09:45, Dave Jones wrote:
> On Wed, Aug 18, 2004 at 12:43:39AM +0100, Christoph Hellwig wrote:
>  > Btw, any chance we can finally kill the inter_module_ bullshit in drm
>  > and make it use normal depencies like every other driver on earth does?
> 
> The patch I saw from Rusty ripping out inter_module_* foo completely
> did just that iirc.

Thx for reminder.  Polished up the drm stuff: this compiles.  Of course,
as Christoph would say, it's still shit.  However, the turd is now more
polished.

Dave, please consider removing the piggybacking of DRM module stubs; it
is the cause of this horror.  I don't know enough to know what that
would break.

Name: Removed inter_module functions from DRM
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Status: Compiles

Gets rid of inter_module* from DRM drivers, in favour of exporting
symbols and using symbol_get.

This is a classic example of a soft-dependency: DRM wants to use AGP
if it's available, but doesn't want to rely on it.  It's limited, in
that loading an AGP driver later won't be used, but it exists.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17062-linux-2.6.8.1/drivers/char/agp/backend.c .17062-linux-2.6.8.1.updated/drivers/char/agp/backend.c
--- .17062-linux-2.6.8.1/drivers/char/agp/backend.c	2004-06-17 08:48:07.000000000 +1000
+++ .17062-linux-2.6.8.1.updated/drivers/char/agp/backend.c	2004-08-18 11:14:53.000000000 +1000
@@ -214,7 +214,7 @@ static void agp_backend_cleanup(struct a
 				phys_to_virt(bridge->scratch_page_real));
 }
 
-static const drm_agp_t drm_agp = {
+const drm_agp_t drm_agp = {
 	&agp_free_memory,
 	&agp_allocate_memory,
 	&agp_bind_memory,
@@ -224,6 +224,7 @@ static const drm_agp_t drm_agp = {
 	&agp_backend_release,
 	&agp_copy_info
 };
+EXPORT_SYMBOL(drm_agp);
 
 /* XXX Kludge alert: agpgart isn't ready for multiple bridges yet */
 struct agp_bridge_data *agp_alloc_bridge(void)
@@ -277,9 +278,6 @@ int agp_add_bridge(struct agp_bridge_dat
 		goto frontend_err;
 	}
 
-	/* FIXME: What to do with this? */
-	inter_module_register("drm_agp", THIS_MODULE, &drm_agp);
-
 	agp_count++;
 	return 0;
 
@@ -298,7 +296,6 @@ void agp_remove_bridge(struct agp_bridge
 	bridge->type = NOT_SUPPORTED;
 	agp_frontend_cleanup();
 	agp_backend_cleanup(bridge);
-	inter_module_unregister("drm_agp");
 	agp_count--;
 	module_put(bridge->driver->owner);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17062-linux-2.6.8.1/drivers/char/drm/Makefile .17062-linux-2.6.8.1.updated/drivers/char/drm/Makefile
--- .17062-linux-2.6.8.1/drivers/char/drm/Makefile	2003-09-22 10:26:35.000000000 +1000
+++ .17062-linux-2.6.8.1.updated/drivers/char/drm/Makefile	2004-08-18 11:14:53.000000000 +1000
@@ -12,6 +12,8 @@ radeon-objs := radeon_drv.o radeon_cp.o 
 ffb-objs    := ffb_drv.o ffb_context.o
 sis-objs    := sis_drv.o sis_ds.o sis_mm.o
 
+obj-y			:= base.o
+
 obj-$(CONFIG_DRM_GAMMA) += gamma.o
 obj-$(CONFIG_DRM_TDFX)	+= tdfx.o
 obj-$(CONFIG_DRM_R128)	+= r128.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17062-linux-2.6.8.1/drivers/char/drm/base.c .17062-linux-2.6.8.1.updated/drivers/char/drm/base.c
--- .17062-linux-2.6.8.1/drivers/char/drm/base.c	1970-01-01 10:00:00.000000000 +1000
+++ .17062-linux-2.6.8.1.updated/drivers/char/drm/base.c	2004-08-18 11:14:53.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17062-linux-2.6.8.1/drivers/char/drm/drmP.h .17062-linux-2.6.8.1.updated/drivers/char/drm/drmP.h
--- .17062-linux-2.6.8.1/drivers/char/drm/drmP.h	2004-08-16 10:15:49.000000000 +1000
+++ .17062-linux-2.6.8.1.updated/drivers/char/drm/drmP.h	2004-08-18 11:14:53.000000000 +1000
@@ -741,6 +741,14 @@ typedef struct drm_device {
 } drm_device_t;
 
 
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17062-linux-2.6.8.1/drivers/char/drm/drm_agpsupport.h .17062-linux-2.6.8.1.updated/drivers/char/drm/drm_agpsupport.h
--- .17062-linux-2.6.8.1/drivers/char/drm/drm_agpsupport.h	2004-08-16 10:15:49.000000000 +1000
+++ .17062-linux-2.6.8.1.updated/drivers/char/drm/drm_agpsupport.h	2004-08-18 11:51:05.000000000 +1000
@@ -37,13 +37,13 @@
 #if __REALLY_HAVE_AGP
 
 
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
@@ -65,7 +65,7 @@ int DRM(agp_info)(struct inode *inode, s
 	DRM_AGP_KERN     *kern;
 	drm_agp_info_t   info;
 
-	if (!dev->agp || !dev->agp->acquired || !drm_agp->copy_info)
+	if (!dev->agp || !dev->agp->acquired || !drm_agp_p->copy_info)
 		return -EINVAL;
 
 	kern                   = &dev->agp->agp_info;
@@ -94,7 +94,7 @@ int DRM(agp_info)(struct inode *inode, s
  * \return zero on success or a negative number on failure. 
  *
  * Verifies the AGP device hasn't been acquired before and calls
- * drm_agp->acquire().
+ * drm_agp_p->acquire().
  */
 int DRM(agp_acquire)(struct inode *inode, struct file *filp,
 		     unsigned int cmd, unsigned long arg)
@@ -107,9 +107,9 @@ int DRM(agp_acquire)(struct inode *inode
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
@@ -124,7 +124,7 @@ int DRM(agp_acquire)(struct inode *inode
  * \param arg user argument.
  * \return zero on success or a negative number on failure.
  *
- * Verifies the AGP device has been acquired and calls drm_agp->release().
+ * Verifies the AGP device has been acquired and calls drm_agp_p->release().
  */
 int DRM(agp_release)(struct inode *inode, struct file *filp,
 		     unsigned int cmd, unsigned long arg)
@@ -132,9 +132,9 @@ int DRM(agp_release)(struct inode *inode
 	drm_file_t	 *priv	 = filp->private_data;
 	drm_device_t	 *dev	 = priv->dev;
 
-	if (!dev->agp || !dev->agp->acquired || !drm_agp->release)
+	if (!dev->agp || !dev->agp->acquired || !drm_agp_p->release)
 		return -EINVAL;
-	drm_agp->release();
+	drm_agp_p->release();
 	dev->agp->acquired = 0;
 	return 0;
 
@@ -143,12 +143,12 @@ int DRM(agp_release)(struct inode *inode
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
@@ -161,7 +161,7 @@ void DRM(agp_do_release)(void)
  * \return zero on success or a negative number on failure.
  *
  * Verifies the AGP device has been acquired but not enabled, and calls
- * drm_agp->enable().
+ * drm_agp_p->enable().
  */
 int DRM(agp_enable)(struct inode *inode, struct file *filp,
 		    unsigned int cmd, unsigned long arg)
@@ -170,14 +170,14 @@ int DRM(agp_enable)(struct inode *inode,
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
@@ -326,7 +326,7 @@ int DRM(agp_bind)(struct inode *inode, s
 	int               retcode;
 	int               page;
 
-	if (!dev->agp || !dev->agp->acquired || !drm_agp->bind_memory)
+	if (!dev->agp || !dev->agp->acquired || !drm_agp_p->bind_memory)
 		return -EINVAL;
 	if (copy_from_user(&request, (drm_agp_binding_t __user *)arg, sizeof(request)))
 		return -EFAULT;
@@ -400,12 +400,12 @@ drm_agp_head_t *DRM(agp_init)(void)
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
@@ -430,40 +430,40 @@ drm_agp_head_t *DRM(agp_init)(void)
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
 
 #endif /* __REALLY_HAVE_AGP */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17062-linux-2.6.8.1/drivers/char/drm/drm_stub.h .17062-linux-2.6.8.1.updated/drivers/char/drm/drm_stub.h
--- .17062-linux-2.6.8.1/drivers/char/drm/drm_stub.h	2004-06-17 08:48:07.000000000 +1000
+++ .17062-linux-2.6.8.1.updated/drivers/char/drm/drm_stub.h	2004-08-18 11:14:53.000000000 +1000
@@ -145,9 +145,9 @@ static int DRM(stub_putminor)(int minor)
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
@@ -190,7 +190,7 @@ int DRM(stub_register)(const char *name,
 		}
 	}
 	else if (ret1 == -EBUSY)
-		i = (struct drm_stub_info *)inter_module_get("drm");
+		i = drm_stub_get();
 	else
 		return -1;
 
@@ -202,8 +202,8 @@ int DRM(stub_register)(const char *name,
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
@@ -213,7 +213,7 @@ int DRM(stub_register)(const char *name,
 				class_simple_destroy(drm_class);
 			}
 			if (!i)
-				inter_module_unregister("drm");
+				drm_stub_unset();
 		}
 		return ret2;
 	}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17062-linux-2.6.8.1/drivers/video/i810/i810_main.c .17062-linux-2.6.8.1.updated/drivers/video/i810/i810_main.c
--- .17062-linux-2.6.8.1/drivers/video/i810/i810_main.c	2004-04-05 09:04:39.000000000 +1000
+++ .17062-linux-2.6.8.1.updated/drivers/video/i810/i810_main.c	2004-08-18 11:14:53.000000000 +1000
@@ -1578,7 +1578,7 @@ static int __devinit i810_alloc_agp_mem(
 	i810_fix_offsets(par);
 	size = par->fb.size + par->iring.size;
 
-	par->drm_agp = (drm_agp_t *) inter_module_get("drm_agp");
+	par->drm_agp = symbol_get(drm_agp);
 	if (!par->drm_agp) {
 		printk("i810fb: cannot acquire agp\n");
 		return -ENODEV;
@@ -1937,7 +1937,7 @@ static void i810fb_release_resource(stru
 			if (par->i810_gtt.i810_fb_memory) 
 				agp->free_memory(gtt->i810_fb_memory);
 
-			inter_module_put("drm_agp");
+			symbol_put(drm_agp);
 			par->drm_agp = NULL;
 		}
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17062-linux-2.6.8.1/include/linux/agp_backend.h .17062-linux-2.6.8.1.updated/include/linux/agp_backend.h
--- .17062-linux-2.6.8.1/include/linux/agp_backend.h	2003-09-22 10:08:38.000000000 +1000
+++ .17062-linux-2.6.8.1.updated/include/linux/agp_backend.h	2004-08-18 11:14:53.000000000 +1000
@@ -112,7 +112,8 @@ typedef struct {
 	int			(*copy_info)(struct agp_kern_info *);
 } drm_agp_t;
 
-extern const drm_agp_t *drm_agp_p;
+/* Used by drm. */
+extern const drm_agp_t drm_agp;
 
 #endif				/* __KERNEL__ */
 #endif				/* _AGP_BACKEND_H */


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

