Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267651AbUJIXzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267651AbUJIXzQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 19:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUJIXzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 19:55:16 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:20883 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267653AbUJIXyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 19:54:32 -0400
Date: Sun, 10 Oct 2004 00:54:29 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: dri-devel@lists.sf.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] [patch] drm core internal versioning..
Message-ID: <Pine.LNX.4.58.0410100050160.6083@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


An issue raised by DRM people with the new drm core is how to stop users
shotting themselves in the foot when upgrading drm modules from CVS and
mixing up cores and drivers...

This patch (against DRM CVS) proposes a simple internal version that gets
passed from the module to the core, when built in-kernel, it gets set to
default DRM_INTERNAL_VERSION_KERNEL, when built in DRM CVS or snapshot, it
gets DRM_INTERNAL_VERSION_EXTERNAL, a core built in one will refuse to
load a module build in the other..

This is quite a simple solution that should stop the most obvious issue,
it doesn't stop people updating CVS drivers on top of themselves but my
view is anyone doing this is either following our scripts or knows what
they are doing...

Dave.

Index: linux-core/Makefile
===================================================================
RCS file: /cvs/dri/drm/linux-core/Makefile,v
retrieving revision 1.17
diff -u -r1.17 Makefile
--- linux-core/Makefile	30 Sep 2004 20:25:13 -0000	1.17
+++ linux-core/Makefile	9 Oct 2004 23:48:31 -0000
@@ -282,6 +282,8 @@
 # This needs to go before all other include paths.
 CC += -I$(DRMSRCDIR)

+EXTRA_CFLAGS = -DDRM_INTERNVAL_VERSION=DRM_INTERNAL_VERSION_EXTERNAL
+
 # Check for Red Hat's 4-argument do_munmap().
 DOMUNMAP := $(shell grep do_munmap $(LINUXDIR)/include/linux/mm.h | \
                 grep -c acct)
Index: linux-core/drmP.h
===================================================================
RCS file: /cvs/dri/drm/linux-core/drmP.h,v
retrieving revision 1.130
diff -u -r1.130 drmP.h
--- linux-core/drmP.h	9 Oct 2004 10:58:19 -0000	1.130
+++ linux-core/drmP.h	9 Oct 2004 23:48:35 -0000
@@ -87,6 +87,13 @@

 #include "drm_os_linux.h"

+#define DRM_INTERNAL_VERSION_KERNEL 1
+#define DRM_INTERNAL_VERSION_EXTERNAL 2
+
+#ifndef DRM_INTERNAL_VERSION
+#define DRM_INTERNAL_VERSION DRM_INTERNAL_VERSION_KERNEL
+#endif
+
 /* If you want the memory alloc debug functionality, change define below */
 /* #define DEBUG_MEMORY */

@@ -730,7 +737,8 @@
 extern int drm_fb_loaded;
 extern int __devinit drm_init(struct pci_driver *driver,
 			      struct pci_device_id *pciidlist,
-			      struct drm_driver_fn *driver_fn);
+			      struct drm_driver_fn *driver_fn,
+			      int internal_version);
 extern void __exit drm_exit(struct pci_driver *driver);
 extern void __exit drm_cleanup_pci(struct pci_dev *pdev);
 extern int drm_version(struct inode *inode, struct file *filp,
Index: linux-core/drm_drv.c
===================================================================
RCS file: /cvs/dri/drm/linux-core/drm_drv.c,v
retrieving revision 1.96
diff -u -r1.96 drm_drv.c
--- linux-core/drm_drv.c	8 Oct 2004 14:31:25 -0000	1.96
+++ linux-core/drm_drv.c	9 Oct 2004 23:48:37 -0000
@@ -74,6 +74,8 @@
 #undef DRM_OPTIONS_FUNC
 #endif

+static int drm_internal_version=DRM_INTERNAL_VERSION;
+
 int drm_fb_loaded = 0;

 /** Ioctl table */
@@ -320,7 +322,7 @@
  */
 int drm_init(struct pci_driver *driver,
 		       struct pci_device_id *pciidlist,
-		       struct drm_driver_fn *driver_fn)
+		       struct drm_driver_fn *driver_fn, int internal_version)
 {
 	struct pci_dev *pdev;
 	struct pci_device_id *pid;
@@ -332,6 +334,11 @@
 	drm_parse_options(drm_opts);
 #endif

+	if (drm_internal_version!=internal_version) {
+		printk("Attempt to load DRM module on different core\m");
+		return -1;
+	}
+
 	drm_mem_init();

 	for (i = 0; (pciidlist[i].vendor != 0) && !drm_fb_loaded; i++) {
Index: linux-core/i810_drv.c
===================================================================
RCS file: /cvs/dri/drm/linux-core/i810_drv.c,v
retrieving revision 1.46
diff -u -r1.46 i810_drv.c
--- linux-core/i810_drv.c	30 Sep 2004 21:12:05 -0000	1.46
+++ linux-core/i810_drv.c	9 Oct 2004 23:48:37 -0000
@@ -132,7 +132,7 @@

 static int __init i810_init(void)
 {
-	return drm_init(&driver, pciidlist, &driver_fn);
+	return drm_init(&driver, pciidlist, &driver_fn, DRM_INTERNAL_VERSION);
 }

 static void __exit i810_exit(void)
Index: linux-core/i830_drv.c
===================================================================
RCS file: /cvs/dri/drm/linux-core/i830_drv.c,v
retrieving revision 1.13
diff -u -r1.13 i830_drv.c
--- linux-core/i830_drv.c	30 Sep 2004 21:12:05 -0000	1.13
+++ linux-core/i830_drv.c	9 Oct 2004 23:48:37 -0000
@@ -142,7 +142,7 @@

 static int __init i830_init(void)
 {
-	return drm_init(&driver, pciidlist, &driver_fn);
+	return drm_init(&driver, pciidlist, &driver_fn, DRM_INTERNAL_VERSION);
 }

 static void __exit i830_exit(void)
Index: linux-core/i915_drv.c
===================================================================
RCS file: /cvs/dri/drm/linux-core/i915_drv.c,v
retrieving revision 1.7
diff -u -r1.7 i915_drv.c
--- linux-core/i915_drv.c	30 Sep 2004 21:12:05 -0000	1.7
+++ linux-core/i915_drv.c	9 Oct 2004 23:48:37 -0000
@@ -106,7 +106,7 @@

 static int __init i915_init(void)
 {
-	return drm_init(&driver, pciidlist, &driver_fn);
+	return drm_init(&driver, pciidlist, &driver_fn, DRM_INTERNAL_VERSION);
 }

 static void __exit i915_exit(void)
Index: linux-core/mach64_drv.c
===================================================================
RCS file: /cvs/dri/drm/linux-core/mach64_drv.c,v
retrieving revision 1.7
diff -u -r1.7 mach64_drv.c
--- linux-core/mach64_drv.c	30 Sep 2004 21:12:05 -0000	1.7
+++ linux-core/mach64_drv.c	9 Oct 2004 23:48:37 -0000
@@ -123,7 +123,7 @@

 static int __init mach64_init(void)
 {
-	return drm_init(&driver, pciidlist, &driver_fn);
+	return drm_init(&driver, pciidlist, &driver_fn, DRM_INTERNAL_VERSION);
 }

 static void __exit mach64_exit(void)
Index: linux-core/mga_drv.c
===================================================================
RCS file: /cvs/dri/drm/linux-core/mga_drv.c,v
retrieving revision 1.44
diff -u -r1.44 mga_drv.c
--- linux-core/mga_drv.c	30 Sep 2004 21:12:06 -0000	1.44
+++ linux-core/mga_drv.c	9 Oct 2004 23:48:37 -0000
@@ -128,7 +128,7 @@

 static int __init mga_init(void)
 {
-	return drm_init(&driver, pciidlist, &driver_fn);
+	return drm_init(&driver, pciidlist, &driver_fn, DRM_INTERNAL_VERSION);
 }

 static void __exit mga_exit(void)
Index: linux-core/r128_drv.c
===================================================================
RCS file: /cvs/dri/drm/linux-core/r128_drv.c,v
retrieving revision 1.51
diff -u -r1.51 r128_drv.c
--- linux-core/r128_drv.c	30 Sep 2004 21:12:06 -0000	1.51
+++ linux-core/r128_drv.c	9 Oct 2004 23:48:37 -0000
@@ -139,7 +139,7 @@

 static int __init r128_init(void)
 {
-	return drm_init(&driver, pciidlist, &driver_fn);
+	return drm_init(&driver, pciidlist, &driver_fn, DRM_INTERNAL_VERSION);
 }

 static void __exit r128_exit(void)
Index: linux-core/radeon_drv.c
===================================================================
RCS file: /cvs/dri/drm/linux-core/radeon_drv.c,v
retrieving revision 1.25
diff -u -r1.25 radeon_drv.c
--- linux-core/radeon_drv.c	30 Sep 2004 21:12:06 -0000	1.25
+++ linux-core/radeon_drv.c	9 Oct 2004 23:48:40 -0000
@@ -179,7 +179,7 @@

 static int __init radeon_init(void)
 {
-	return drm_init(&driver, pciidlist, &driver_fn);
+	return drm_init(&driver, pciidlist, &driver_fn, DRM_INTERNAL_VERSION);
 }

 static void __exit radeon_exit(void)
Index: linux-core/savage_drv.c
===================================================================
RCS file: /cvs/dri/drm/linux-core/savage_drv.c,v
retrieving revision 1.10
diff -u -r1.10 savage_drv.c
--- linux-core/savage_drv.c	30 Sep 2004 21:12:06 -0000	1.10
+++ linux-core/savage_drv.c	9 Oct 2004 23:48:40 -0000
@@ -316,7 +316,7 @@

 static int __init savage_init(void)
 {
-	return drm_init(&driver, pciidlist, &driver_fn);
+	return drm_init(&driver, pciidlist, &driver_fn, DRM_INTERNAL_VERSION);
 }

 static void __exit savage_exit(void)
Index: linux-core/sis_drv.c
===================================================================
RCS file: /cvs/dri/drm/linux-core/sis_drv.c,v
retrieving revision 1.23
diff -u -r1.23 sis_drv.c
--- linux-core/sis_drv.c	30 Sep 2004 21:12:06 -0000	1.23
+++ linux-core/sis_drv.c	9 Oct 2004 23:48:40 -0000
@@ -105,7 +105,7 @@

 static int __init sis_init(void)
 {
-	return drm_init(&driver, pciidlist, &driver_fn);
+	return drm_init(&driver, pciidlist, &driver_fn, DRM_INTERNAL_VERSION);
 }

 static void __exit sis_exit(void)
Index: linux-core/tdfx_drv.c
===================================================================
RCS file: /cvs/dri/drm/linux-core/tdfx_drv.c,v
retrieving revision 1.42
diff -u -r1.42 tdfx_drv.c
--- linux-core/tdfx_drv.c	30 Sep 2004 21:12:06 -0000	1.42
+++ linux-core/tdfx_drv.c	9 Oct 2004 23:48:40 -0000
@@ -96,7 +96,7 @@

 static int __init tdfx_init(void)
 {
-	return drm_init(&driver, pciidlist, &driver_fn);
+	return drm_init(&driver, pciidlist, &driver_fn, DRM_INTERNAL_VERSION);
 }

 static void __exit tdfx_exit(void)
Index: shared-core/via_drv.c
===================================================================
RCS file: /cvs/dri/drm/shared-core/via_drv.c,v
retrieving revision 1.13
diff -u -r1.13 via_drv.c
--- shared-core/via_drv.c	9 Oct 2004 12:42:52 -0000	1.13
+++ shared-core/via_drv.c	9 Oct 2004 23:48:40 -0000
@@ -113,7 +113,7 @@

 static int __init via_init(void)
 {
-	return drm_init(&driver, pciidlist, &driver_fn);
+	return drm_init(&driver, pciidlist, &driver_fn, DRM_INTERNAL_VERSION);
 }

 static void __exit via_exit(void)
