Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbSJaHMC>; Thu, 31 Oct 2002 02:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265202AbSJaHLT>; Thu, 31 Oct 2002 02:11:19 -0500
Received: from dp.samba.org ([66.70.73.150]:42149 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265201AbSJaHKs>;
	Thu, 31 Oct 2002 02:10:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, faith@redhat.com, dwmw2@redhat.com,
       davem@redhat.com
Subject: [PATCH] Module rewrite series 5/5: DRM and MTD
In-reply-to: Your message of "Thu, 31 Oct 2002 17:39:57 +1100."
             <20021031064316.D9F5D2C0E1@lists.samba.org> 
Date: Thu, 31 Oct 2002 18:16:45 +1100
Message-Id: <20021031071714.687F32C064@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the three inter_module* users (compile, but untested):

1) MTD really wants symbol_get, and now they have it.  The solution
   uses weak symbols: you can return to #ifdef CONFIG_xxx if you want
   this to work on Sparc64.

2) DRM really wants symbol_get and symbol_put for AGP detection
   (although that still leaves you high and dry if you insmod it
   later).  They also use it for piggybacking for multiple DRM
   modules: I've simply dumped this in drivers/char/misc.c because
   it seems inherently broken.

For the record, the DRM code should be rewritten using standard kernel
idioms so that it is readable by the rest of us.

Name: Removed inter_module functions
Author: Rusty Russell
Status: Untested
Depends: Module/module-i386.patch.gz
Depends: Module/module-ppc.patch.gz

D: Gets rid of inter_module* and fixes up DRM and mtd drivers.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/drivers/char/agp/agp.c .13357-linux-2.5.45.updated/drivers/char/agp/agp.c
--- .13357-linux-2.5.45/drivers/char/agp/agp.c	2002-10-15 15:30:55.000000000 +1000
+++ .13357-linux-2.5.45.updated/drivers/char/agp/agp.c	2002-10-31 15:34:52.000000000 +1100
@@ -46,6 +46,7 @@ EXPORT_SYMBOL(agp_unbind_memory);
 EXPORT_SYMBOL(agp_enable);
 EXPORT_SYMBOL(agp_backend_acquire);
 EXPORT_SYMBOL(agp_backend_release);
+EXPORT_SYMBOL(agp_drm);
 
 struct agp_bridge_data agp_bridge = { type: NOT_SUPPORTED };
 static int agp_try_unsupported __initdata = 0;
@@ -1600,7 +1601,7 @@ static int agp_power(struct pm_dev *dev,
 extern int agp_frontend_initialize(void);
 extern void agp_frontend_cleanup(void);
 
-static const drm_agp_t drm_agp = {
+const drm_agp_t agp_drm = {
 	&agp_free_memory,
 	&agp_allocate_memory,
 	&agp_bind_memory,
@@ -1632,8 +1633,6 @@ static int agp_probe (struct pci_dev *de
 		return ret_val;
 	}
 
-	inter_module_register("drm_agp", THIS_MODULE, &drm_agp);
-	
 	pm_register(PM_PCI_DEV, PM_PCI_ID(agp_bridge.dev), agp_power);
 	return 0;
 }
@@ -1680,7 +1679,6 @@ static void __exit agp_cleanup(void)
 		pm_unregister_all(agp_power);
 		agp_frontend_cleanup();
 		agp_backend_cleanup();
-		inter_module_unregister("drm_agp");
 	}
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/drivers/char/drm/Makefile .13357-linux-2.5.45.updated/drivers/char/drm/Makefile
--- .13357-linux-2.5.45/drivers/char/drm/Makefile	2002-10-15 15:19:40.000000000 +1000
+++ .13357-linux-2.5.45.updated/drivers/char/drm/Makefile	2002-10-31 15:34:53.000000000 +1100
@@ -2,6 +2,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
+export-objs := gamma.o tdfx.o r128.o radeon.o mga.o i810.i i830.o ffb.o
+
 gamma-objs  := gamma_drv.o gamma_dma.o
 tdfx-objs   := tdfx_drv.o
 r128-objs   := r128_drv.o r128_cce.o r128_state.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/drivers/char/drm/drm_agpsupport.h .13357-linux-2.5.45.updated/drivers/char/drm/drm_agpsupport.h
--- .13357-linux-2.5.45/drivers/char/drm/drm_agpsupport.h	2002-09-01 12:23:00.000000000 +1000
+++ .13357-linux-2.5.45.updated/drivers/char/drm/drm_agpsupport.h	2002-10-31 15:34:53.000000000 +1100
@@ -35,8 +35,8 @@
 
 #if __REALLY_HAVE_AGP
 
-#define DRM_AGP_GET (drm_agp_t *)inter_module_get("drm_agp")
-#define DRM_AGP_PUT inter_module_put("drm_agp")
+#define DRM_AGP_GET symbol_get(agp_drm)
+#define DRM_AGP_PUT symbol_put(agp_drm)
 
 static const drm_agp_t *drm_agp = NULL;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/drivers/char/drm/drm_stub.h .13357-linux-2.5.45.updated/drivers/char/drm/drm_stub.h
--- .13357-linux-2.5.45/drivers/char/drm/drm_stub.h	2002-09-01 12:23:00.000000000 +1000
+++ .13357-linux-2.5.45.updated/drivers/char/drm/drm_stub.h	2002-10-31 15:34:53.000000000 +1100
@@ -97,6 +97,12 @@ static int DRM(stub_getminor)(const char
 	return -1;
 }
 
+/* Hacked into char/misc.c */
+extern void drm_stub_set(struct drm_stub_info *, struct module *owner);
+extern void drm_stub_unset(void);
+extern struct drm_stub_info *drm_stub_get(void);
+extern void drm_stub_put(void);
+
 static int DRM(stub_putminor)(int minor)
 {
 	if (minor < 0 || minor >= DRM_STUB_MAXCARDS) return -1;
@@ -105,9 +111,9 @@ static int DRM(stub_putminor)(int minor)
 	DRM(proc_cleanup)(minor, DRM(stub_root),
 			  DRM(stub_list)[minor].dev_root);
 	if (minor) {
-		inter_module_put("drm");
+		drm_stub_put();
 	} else {
-		inter_module_unregister("drm");
+		drm_stub_unset();
 		DRM(free)(DRM(stub_list),
 			  sizeof(*DRM(stub_list)) * DRM_STUB_MAXCARDS,
 			  DRM_MEM_STUB);
@@ -124,7 +130,7 @@ int DRM(stub_register)(const char *name,
 
 	DRM_DEBUG("\n");
 	if (register_chrdev(DRM_MAJOR, "drm", &DRM(stub_fops)))
-		i = (struct drm_stub_info *)inter_module_get("drm");
+		i = drm_stub_get();
 
 	if (i) {
 				/* Already registered */
@@ -134,8 +140,8 @@ int DRM(stub_register)(const char *name,
 	} else if (DRM(stub_info).info_register != DRM(stub_getminor)) {
 		DRM(stub_info).info_register   = DRM(stub_getminor);
 		DRM(stub_info).info_unregister = DRM(stub_putminor);
-		DRM_DEBUG("calling inter_module_register\n");
-		inter_module_register("drm", THIS_MODULE, &DRM(stub_info));
+		DRM_DEBUG("calling drm_stub_set\n");
+		drm_stub_set(&DRM(stub_info), THIS_MODULE);
 	}
 	if (DRM(stub_info).info_register)
 		return DRM(stub_info).info_register(name, fops, dev);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/drivers/char/misc.c .13357-linux-2.5.45.updated/drivers/char/misc.c
--- .13357-linux-2.5.45/drivers/char/misc.c	2002-09-18 16:04:38.000000000 +1000
+++ .13357-linux-2.5.45.updated/drivers/char/misc.c	2002-10-31 15:34:53.000000000 +1100
@@ -287,3 +287,42 @@ int __init misc_init(void)
 	}
 	return 0;
 }
+
+/* This (racy) hack is here because the DRM coders are taking
+   Linux-incompatible drugs */
+#if defined(CONFIG_DRM) || defined(CONFIG_DRM_MODULE)
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
+		__MOD_INC_USE_COUNT(drm_stub_owner);
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
+#endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/drivers/mtd/Makefile .13357-linux-2.5.45.updated/drivers/mtd/Makefile
--- .13357-linux-2.5.45/drivers/mtd/Makefile	2002-10-16 15:01:17.000000000 +1000
+++ .13357-linux-2.5.45.updated/drivers/mtd/Makefile	2002-10-31 15:38:35.000000000 +1100
@@ -8,22 +8,6 @@ export-objs	:= mtdcore.o mtdpart.o redbo
 
 obj-y           += chips/ maps/ devices/ nand/
 
-#                       *** BIG UGLY NOTE ***
-#
-# The shiny new inter_module_xxx has introduced yet another ugly link
-# order dependency, which I'd previously taken great care to avoid.
-# We now have to ensure that the chip drivers are initialised before the
-# map drivers, and that the doc200[01] drivers are initialised before
-# docprobe.
-#
-# We'll hopefully merge the doc200[01] drivers and docprobe back into
-# a single driver some time soon, but the CFI drivers are going to have
-# to stay like that.
-#
-# Urgh.
-# 
-# dwmw2 21/11/0
-
 # Core functionality.
 obj-$(CONFIG_MTD)		+= mtdcore.o
 obj-$(CONFIG_MTD_CONCAT)	+= mtdconcat.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/drivers/mtd/chips/Makefile .13357-linux-2.5.45.updated/drivers/mtd/chips/Makefile
--- .13357-linux-2.5.45/drivers/mtd/chips/Makefile	2002-05-30 14:56:57.000000000 +1000
+++ .13357-linux-2.5.45.updated/drivers/mtd/chips/Makefile	2002-10-31 15:34:54.000000000 +1100
@@ -3,14 +3,7 @@
 #
 # $Id: Makefile,v 1.7 2001/10/05 06:53:51 dwmw2 Exp $
 
-export-objs	:= chipreg.o gen_probe.o
-
-#                       *** BIG UGLY NOTE ***
-#
-# The removal of get_module_symbol() and replacement with
-# inter_module_register() et al has introduced a link order dependency
-# here where previously there was none.  We now have to ensure that
-# the CFI command set drivers are linked before cfi_probe.o
+export-objs	:= chipreg.o gen_probe.o cfi_cmdset_0001.o cfi_cmdset_0002.o
 
 obj-$(CONFIG_MTD)		+= chipreg.o
 obj-$(CONFIG_MTD_AMDSTD)	+= amd_flash.o 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/drivers/mtd/chips/cfi_cmdset_0001.c .13357-linux-2.5.45.updated/drivers/mtd/chips/cfi_cmdset_0001.c
--- .13357-linux-2.5.45/drivers/mtd/chips/cfi_cmdset_0001.c	2001-10-06 00:40:30.000000000 +1000
+++ .13357-linux-2.5.45.updated/drivers/mtd/chips/cfi_cmdset_0001.c	2002-10-31 15:34:54.000000000 +1100
@@ -97,13 +97,6 @@ static void cfi_tell_features(struct cfi
 }
 #endif
 
-/* This routine is made available to other mtd code via
- * inter_module_register.  It must only be accessed through
- * inter_module_get which will bump the use count of this module.  The
- * addresses passed back in cfi are valid as long as the use count of
- * this module is non-zero, i.e. between inter_module_get and
- * inter_module_put.  Keith Owens <kaos@ocs.com.au> 29 Oct 2000.
- */
 struct mtd_info *cfi_cmdset_0001(struct map_info *map, int primary)
 {
 	struct cfi_private *cfi = map->fldrv_priv;
@@ -1601,22 +1594,19 @@ static void cfi_intelext_destroy(struct 
 	kfree(cfi);
 }
 
-static char im_name_1[]="cfi_cmdset_0001";
-static char im_name_3[]="cfi_cmdset_0003";
-
 int __init cfi_intelext_init(void)
 {
-	inter_module_register(im_name_1, THIS_MODULE, &cfi_cmdset_0001);
-	inter_module_register(im_name_3, THIS_MODULE, &cfi_cmdset_0001);
 	return 0;
 }
 
 static void __exit cfi_intelext_exit(void)
 {
-	inter_module_unregister(im_name_1);
-	inter_module_unregister(im_name_3);
 }
 
+struct mtd_info *cfi_cmdset_0003(struct map_info *map, int primary) __attribute__((alias("cfi_cmdset_0001")));
+EXPORT_SYMBOL(cfi_cmdset_0001);
+EXPORT_SYMBOL(cfi_cmdset_0003);
+
 module_init(cfi_intelext_init);
 module_exit(cfi_intelext_exit);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/drivers/mtd/chips/cfi_cmdset_0002.c .13357-linux-2.5.45.updated/drivers/mtd/chips/cfi_cmdset_0002.c
--- .13357-linux-2.5.45/drivers/mtd/chips/cfi_cmdset_0002.c	2001-10-30 13:38:02.000000000 +1100
+++ .13357-linux-2.5.45.updated/drivers/mtd/chips/cfi_cmdset_0002.c	2002-10-31 15:34:54.000000000 +1100
@@ -934,19 +934,17 @@ static void cfi_amdstd_destroy(struct mt
 	kfree(cfi);
 }
 
-static char im_name[]="cfi_cmdset_0002";
-
 int __init cfi_amdstd_init(void)
 {
-	inter_module_register(im_name, THIS_MODULE, &cfi_cmdset_0002);
 	return 0;
 }
 
 static void __exit cfi_amdstd_exit(void)
 {
-	inter_module_unregister(im_name);
 }
 
+EXPORT_SYMBOL(cfi_cmdset_0002);
+
 module_init(cfi_amdstd_init);
 module_exit(cfi_amdstd_exit);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/drivers/mtd/chips/gen_probe.c .13357-linux-2.5.45.updated/drivers/mtd/chips/gen_probe.c
--- .13357-linux-2.5.45/drivers/mtd/chips/gen_probe.c	2001-10-06 00:40:30.000000000 +1000
+++ .13357-linux-2.5.45.updated/drivers/mtd/chips/gen_probe.c	2002-10-31 15:34:54.000000000 +1100
@@ -234,35 +234,48 @@ static int genprobe_new_chip(struct map_
 
 typedef struct mtd_info *cfi_cmdset_fn_t(struct map_info *, int);
 
-extern cfi_cmdset_fn_t cfi_cmdset_0001;
-extern cfi_cmdset_fn_t cfi_cmdset_0002;
+static struct mtd_info *unknown_cmdset(struct map_info *map, int primary)
+{
+	struct cfi_private *cfi = map->fldrv_priv;
+	__u16 type = primary?cfi->cfiq->P_ID:cfi->cfiq->A_ID;
+
+	printk(KERN_NOTICE "Support for command set %04X not present\n",
+	       type);
+	return NULL;
+}
+
+/* when we are built without module support, so we still link */
+cfi_cmdset_fn_t cfi_cmdset_0001 __attribute__((weak, alias("unknown_cmdset")));
+cfi_cmdset_fn_t cfi_cmdset_0002 __attribute__((weak, alias("unknown_cmdset")));
+cfi_cmdset_fn_t cfi_cmdset_0003 __attribute__((weak, alias("unknown_cmdset")));
 
 static inline struct mtd_info *cfi_cmdset_unknown(struct map_info *map, 
 						  int primary)
 {
 	struct cfi_private *cfi = map->fldrv_priv;
 	__u16 type = primary?cfi->cfiq->P_ID:cfi->cfiq->A_ID;
-#if defined(CONFIG_MODULES) && defined(HAVE_INTER_MODULE)
-	char probename[32];
-	cfi_cmdset_fn_t *probe_function;
-
-	sprintf(probename, "cfi_cmdset_%4.4X", type);
-		
-	probe_function = inter_module_get_request(probename, probename);
+	cfi_cmdset_fn_t *probe_function = NULL;
 
+	switch (type) {
+	case 1:
+		probe_function = symbol_get(cfi_cmdset_0001);
+		break;
+	case 2:
+		probe_function = symbol_get(cfi_cmdset_0002);
+		break;
+	case 3:
+		probe_function = symbol_get(cfi_cmdset_0003);
+		break;
+	}
 	if (probe_function) {
 		struct mtd_info *mtd;
 
 		mtd = (*probe_function)(map, primary);
 		/* If it was happy, it'll have increased its own use count */
-		inter_module_put(probename);
+		symbol_put_addr(probe_function);
 		return mtd;
 	}
-#endif
-	printk(KERN_NOTICE "Support for command set %04X not present\n",
-	       type);
-
-	return NULL;
+	return unknown_cmdset(map, primary);
 }
 
 static struct mtd_info *check_cmd_set(struct map_info *map, int primary)
@@ -273,24 +286,6 @@ static struct mtd_info *check_cmd_set(st
 	if (type == P_ID_NONE || type == P_ID_RESERVED)
 		return NULL;
 
-	switch(type){
-		/* Urgh. Ifdefs. The version with weak symbols was
-		 * _much_ nicer. Shame it didn't seem to work on
-		 * anything but x86, really.
-		 * But we can't rely in inter_module_get() because
-		 * that'd mean we depend on link order.
-		 */
-#ifdef CONFIG_MTD_CFI_INTELEXT
-	case 0x0001:
-	case 0x0003:
-		return cfi_cmdset_0001(map, primary);
-#endif
-#ifdef CONFIG_MTD_CFI_AMDSTD
-	case 0x0002:
-		return cfi_cmdset_0002(map, primary);
-#endif
-	}
-
 	return cfi_cmdset_unknown(map, primary);
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/drivers/mtd/devices/Makefile .13357-linux-2.5.45.updated/drivers/mtd/devices/Makefile
--- .13357-linux-2.5.45/drivers/mtd/devices/Makefile	2002-05-30 14:56:57.000000000 +1000
+++ .13357-linux-2.5.45.updated/drivers/mtd/devices/Makefile	2002-10-31 15:34:54.000000000 +1100
@@ -3,12 +3,7 @@
 #
 # $Id: Makefile,v 1.4 2001/06/26 21:10:05 spse Exp $
 
-#                       *** BIG UGLY NOTE ***
-#
-# The removal of get_module_symbol() and replacement with
-# inter_module_register() et al has introduced a link order dependency
-# here where previously there was none.  We now have to ensure that
-# doc200[01].o are linked before docprobe.o
+export-objs := doc1000.o doc2000.o doc2001.o
 
 obj-$(CONFIG_MTD_DOC1000)	+= doc1000.o
 obj-$(CONFIG_MTD_DOC2000)	+= doc2000.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/drivers/mtd/devices/doc2000.c .13357-linux-2.5.45.updated/drivers/mtd/devices/doc2000.c
--- .13357-linux-2.5.45/drivers/mtd/devices/doc2000.c	2002-05-24 15:20:20.000000000 +1000
+++ .13357-linux-2.5.45.updated/drivers/mtd/devices/doc2000.c	2002-10-31 15:34:54.000000000 +1100
@@ -503,16 +503,7 @@ static int DoC2k_is_alias(struct DiskOnC
 	return retval;
 }
 
-static const char im_name[] = "DoC2k_init";
-
-/* This routine is made available to other mtd code via
- * inter_module_register.  It must only be accessed through
- * inter_module_get which will bump the use count of this module.  The
- * addresses passed back in mtd are valid as long as the use count of
- * this module is non-zero, i.e. between inter_module_get and
- * inter_module_put.  Keith Owens <kaos@ocs.com.au> 29 Oct 2000.
- */
-static void DoC2k_init(struct mtd_info *mtd)
+void DoC2k_init(struct mtd_info *mtd)
 {
 	struct DiskOnChip *this = (struct DiskOnChip *) mtd->priv;
 	struct DiskOnChip *old = NULL;
@@ -1143,7 +1134,6 @@ static int doc_erase(struct mtd_info *mt
 
 int __init init_doc2000(void)
 {
-       inter_module_register(im_name, THIS_MODULE, &DoC2k_init);
        return 0;
 }
 
@@ -1162,9 +1152,10 @@ static void __exit cleanup_doc2000(void)
 		kfree(this->chips);
 		kfree(mtd);
 	}
-	inter_module_unregister(im_name);
 }
 
+EXPORT_SYMBOL(DoC2k_init);
+
 module_exit(cleanup_doc2000);
 module_init(init_doc2000);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/drivers/mtd/devices/doc2001.c .13357-linux-2.5.45.updated/drivers/mtd/devices/doc2001.c
--- .13357-linux-2.5.45/drivers/mtd/devices/doc2001.c	2001-10-06 00:40:30.000000000 +1000
+++ .13357-linux-2.5.45.updated/drivers/mtd/devices/doc2001.c	2002-10-31 15:34:54.000000000 +1100
@@ -318,16 +318,7 @@ static int DoCMil_is_alias(struct DiskOn
 	return retval;
 }
 
-static const char im_name[] = "DoCMil_init";
-
-/* This routine is made available to other mtd code via
- * inter_module_register.  It must only be accessed through
- * inter_module_get which will bump the use count of this module.  The
- * addresses passed back in mtd are valid as long as the use count of
- * this module is non-zero, i.e. between inter_module_get and
- * inter_module_put.  Keith Owens <kaos@ocs.com.au> 29 Oct 2000.
- */
-static void DoCMil_init(struct mtd_info *mtd)
+void DoCMil_init(struct mtd_info *mtd)
 {
 	struct DiskOnChip *this = (struct DiskOnChip *)mtd->priv;
 	struct DiskOnChip *old = NULL;
@@ -850,7 +841,6 @@ int doc_erase (struct mtd_info *mtd, str
 
 int __init init_doc2001(void)
 {
-	inter_module_register(im_name, THIS_MODULE, &DoCMil_init);
 	return 0;
 }
 
@@ -869,12 +859,13 @@ static void __exit cleanup_doc2001(void)
 		kfree(this->chips);
 		kfree(mtd);
 	}
-	inter_module_unregister(im_name);
 }
 
 module_exit(cleanup_doc2001);
 module_init(init_doc2001);
 
+EXPORT_SYMBOL(DoCMil_init);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Woodhouse <dwmw2@infradead.org> et al.");
 MODULE_DESCRIPTION("Alternative driver for DiskOnChip Millennium");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/drivers/mtd/devices/docprobe.c .13357-linux-2.5.45.updated/drivers/mtd/devices/docprobe.c
--- .13357-linux-2.5.45/drivers/mtd/devices/docprobe.c	2001-10-06 00:40:30.000000000 +1000
+++ .13357-linux-2.5.45.updated/drivers/mtd/devices/docprobe.c	2002-10-31 15:34:54.000000000 +1100
@@ -219,28 +219,22 @@ static void __init DoC_Probe(unsigned lo
 		switch(ChipID) {
 		case DOC_ChipID_Doc2k:
 			name="2000";
-			im_funcname = "DoC2k_init";
-			im_modname = "doc2000";
+			initroutine = symbol_request(DoC2k_init);
 			break;
 			
 		case DOC_ChipID_DocMil:
 			name="Millennium";
 #ifdef DOC_SINGLE_DRIVER
-			im_funcname = "DoC2k_init";
-			im_modname = "doc2000";
+			initroutine = symbol_request(DoC2k_init);
 #else
-			im_funcname = "DoCMil_init";
-			im_modname = "doc2001";
+			initroutine = symbol_request(DoCMil_init);
 #endif /* DOC_SINGLE_DRIVER */
 			break;
 		}
 
-		if (im_funcname)
-			initroutine = inter_module_get_request(im_funcname, im_modname);
-
 		if (initroutine) {
 			(*initroutine)(mtd);
-			inter_module_put(im_funcname);
+			symbol_put_addr(initroutine);
 			return;
 		}
 		printk(KERN_NOTICE "Cannot find driver for DiskOnChip %s at 0x%lX\n", name, physadr);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/include/linux/agp_backend.h .13357-linux-2.5.45.updated/include/linux/agp_backend.h
--- .13357-linux-2.5.45/include/linux/agp_backend.h	2002-10-15 15:31:04.000000000 +1000
+++ .13357-linux-2.5.45.updated/include/linux/agp_backend.h	2002-10-31 15:34:54.000000000 +1100
@@ -262,12 +262,7 @@ typedef struct {
 	int        (*copy_info)(agp_kern_info *);
 } drm_agp_t;
 
-extern const drm_agp_t *drm_agp_p;
-
-/*
- * Interface between drm and agp code.  When agp initializes, it makes
- * the above structure available via inter_module_register(), drm might
- * use it.  Keith Owens <kaos@ocs.com.au> 28 Oct 2000.
- */
+/* Used by drm. */
+extern const drm_agp_t agp_drm;
 
 #endif				/* _AGP_BACKEND_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13357-linux-2.5.45/include/linux/mtd/cfi.h .13357-linux-2.5.45.updated/include/linux/mtd/cfi.h
--- .13357-linux-2.5.45/include/linux/mtd/cfi.h	2002-05-24 15:20:34.000000000 +1000
+++ .13357-linux-2.5.45.updated/include/linux/mtd/cfi.h	2002-10-31 15:36:21.000000000 +1100
@@ -247,7 +247,6 @@ struct cfi_private {
 	int mfr, id;
 	int numchips;
 	unsigned long chipshift; /* Because they're of the same type */
-	const char *im_name;	 /* inter_module name for cmdset_setup */
 	struct flchip chips[0];  /* per-chip data structure for each chip */
 };
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
