Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVC1LlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVC1LlD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 06:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVC1LlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 06:41:03 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:46032 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261547AbVC1LkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 06:40:18 -0500
Date: Mon, 28 Mar 2005 12:40:16 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [bk tree] DRM add a version check.. for 2.6.12 (distro kernel
 maintainers + drm users plz read also...)
Message-ID: <Pine.LNX.4.58.0503281236330.27073@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

In order to stop someone loading a drm driver on a wrong core this patch
makes the driver pass in the version is was built against, this mainly
useful for people using the DRI snapshots for cards that aren't their
normal cards...

Also for anyone who maintains a kernel for distros or builds their own
please build your kernels with CONFIG_DRM=m not =y, from 2.6.11 onwards..
as if you build with =y then DRI snapshots will no longer work..

Please do a

	bk pull bk://drm.bkbits.net/drm-linus

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/Kconfig      |    6 ++++--
 drivers/char/drm/drmP.h       |    2 +-
 drivers/char/drm/drm_core.h   |    4 ++++
 drivers/char/drm/drm_drv.c    |    9 +++++++--
 drivers/char/drm/i810_drv.c   |    3 ++-
 drivers/char/drm/i830_drv.c   |    3 ++-
 drivers/char/drm/i915_drv.c   |    3 ++-
 drivers/char/drm/mga_drv.c    |    3 ++-
 drivers/char/drm/r128_drv.c   |    3 ++-
 drivers/char/drm/radeon_drv.c |    3 ++-
 drivers/char/drm/sis_drv.c    |    3 ++-
 drivers/char/drm/tdfx_drv.c   |    3 ++-
 12 files changed, 32 insertions(+), 13 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (05/03/28 1.2234)
   drm: mention in help that you should use M for DRM

   For DRM M is really the best option as if you build drm core
   into the kernel, then you won't be able to use DRM CVS or
   snapshots as the drivers won't load on the kernels DRM..

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/28 1.2233)
   drm: add a version check to drm_init

   This checks the CORE_VERSION from the module against the
   kernel CORE_VERSION and makes sure they don't mismatch..

   the kernel version numbers shouldn't change.. only the CVS snapshot
   ones should... driver writers should use kernel versions...

   Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/Kconfig b/drivers/char/drm/Kconfig
--- a/drivers/char/drm/Kconfig	2005-03-28 21:34:45 +10:00
+++ b/drivers/char/drm/Kconfig	2005-03-28 21:34:45 +10:00
@@ -9,12 +9,14 @@
 	depends on AGP || AGP=n
 	help
 	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
-	  introduced in XFree86 4.0. If you say Y here, you need to select
+	  introduced in XFree86 4.0. If you say M/Y here, you need to select
 	  the module that's right for your graphics card from the list below.
 	  These modules provide support for synchronization, security, and
 	  DMA transfers. Please see <http://dri.sourceforge.net/> for more
 	  details.  You should also select and configure AGP
-	  (/dev/agpgart) support.
+	  (/dev/agpgart) support. You should usually pick M here as it
+	  allows for using snapshots later, only pick Y if you really know
+	  what you are doing.

 config DRM_TDFX
 	tristate "3dfx Banshee/Voodoo3+"
diff -Nru a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
--- a/drivers/char/drm/drmP.h	2005-03-28 21:34:45 +10:00
+++ b/drivers/char/drm/drmP.h	2005-03-28 21:34:45 +10:00
@@ -769,7 +769,7 @@
 extern int           drm_cpu_valid( void );

 				/* Driver support (drm_drv.h) */
-extern int           drm_init(struct drm_driver *driver);
+extern int           drm_init(struct drm_driver *driver, unsigned int version);
 extern void          drm_exit(struct drm_driver *driver);
 extern int           drm_version(struct inode *inode, struct file *filp,
 				  unsigned int cmd, unsigned long arg);
diff -Nru a/drivers/char/drm/drm_core.h b/drivers/char/drm/drm_core.h
--- a/drivers/char/drm/drm_core.h	2005-03-28 21:34:45 +10:00
+++ b/drivers/char/drm/drm_core.h	2005-03-28 21:34:45 +10:00
@@ -29,6 +29,10 @@
 #define DRM_IF_MAJOR	1
 #define DRM_IF_MINOR	2

+/* these are limited to 16-bits - major and minor are combined into a 32-bit */
+/* for the kernel these should never change unless something major happens */
 #define CORE_MAJOR	1
 #define CORE_MINOR	0
 #define CORE_PATCHLEVEL 0
+
+#define CORE_VERSION DRM_IF_VERSION(CORE_MAJOR, CORE_MINOR)
diff -Nru a/drivers/char/drm/drm_drv.c b/drivers/char/drm/drm_drv.c
--- a/drivers/char/drm/drm_drv.c	2005-03-28 21:34:45 +10:00
+++ b/drivers/char/drm/drm_drv.c	2005-03-28 21:34:45 +10:00
@@ -279,14 +279,19 @@
  * Expands the \c DRIVER_PREINIT and \c DRIVER_POST_INIT macros before and
  * after the initialization for driver customization.
  */
-int drm_init( struct drm_driver *driver )
+int drm_init( struct drm_driver *driver, unsigned int version )
 {
 	struct pci_dev *pdev = NULL;
 	struct pci_device_id *pid;
 	int i;

 	DRM_DEBUG( "\n" );
-
+
+	if (version!=CORE_VERSION) {
+		printk("Attempt to load DRM module %d:%d on incorrect core %d:%d\n", (version>>16)&0xffff, version & 0xffff, CORE_MAJOR, CORE_MINOR);
+		return -1;
+	}
+
 	drm_mem_init();

 	for (i=0; driver->pci_driver.id_table[i].vendor != 0; i++) {
diff -Nru a/drivers/char/drm/i810_drv.c b/drivers/char/drm/i810_drv.c
--- a/drivers/char/drm/i810_drv.c	2005-03-28 21:34:45 +10:00
+++ b/drivers/char/drm/i810_drv.c	2005-03-28 21:34:45 +10:00
@@ -32,6 +32,7 @@

 #include <linux/config.h>
 #include "drmP.h"
+#include "drm_core.h"
 #include "drm.h"
 #include "i810_drm.h"
 #include "i810_drv.h"
@@ -110,7 +111,7 @@
 static int __init i810_init(void)
 {
 	driver.num_ioctls = i810_max_ioctl;
-	return drm_init(&driver);
+	return drm_init(&driver, CORE_VERSION);
 }

 static void __exit i810_exit(void)
diff -Nru a/drivers/char/drm/i830_drv.c b/drivers/char/drm/i830_drv.c
--- a/drivers/char/drm/i830_drv.c	2005-03-28 21:34:45 +10:00
+++ b/drivers/char/drm/i830_drv.c	2005-03-28 21:34:45 +10:00
@@ -34,6 +34,7 @@

 #include <linux/config.h>
 #include "drmP.h"
+#include "drm_core.h"
 #include "drm.h"
 #include "i830_drm.h"
 #include "i830_drv.h"
@@ -121,7 +122,7 @@
 static int __init i830_init(void)
 {
 	driver.num_ioctls = i830_max_ioctl;
-	return drm_init(&driver);
+	return drm_init(&driver, CORE_VERSION);
 }

 static void __exit i830_exit(void)
diff -Nru a/drivers/char/drm/i915_drv.c b/drivers/char/drm/i915_drv.c
--- a/drivers/char/drm/i915_drv.c	2005-03-28 21:34:45 +10:00
+++ b/drivers/char/drm/i915_drv.c	2005-03-28 21:34:45 +10:00
@@ -9,6 +9,7 @@
  **************************************************************************/

 #include "drmP.h"
+#include "drm_core.h"
 #include "drm.h"
 #include "i915_drm.h"
 #include "i915_drv.h"
@@ -88,7 +89,7 @@
 static int __init i915_init(void)
 {
 	driver.num_ioctls = i915_max_ioctl;
-	return drm_init(&driver);
+	return drm_init(&driver, CORE_VERSION);
 }

 static void __exit i915_exit(void)
diff -Nru a/drivers/char/drm/mga_drv.c b/drivers/char/drm/mga_drv.c
--- a/drivers/char/drm/mga_drv.c	2005-03-28 21:34:45 +10:00
+++ b/drivers/char/drm/mga_drv.c	2005-03-28 21:34:45 +10:00
@@ -31,6 +31,7 @@

 #include <linux/config.h>
 #include "drmP.h"
+#include "drm_core.h"
 #include "drm.h"
 #include "mga_drm.h"
 #include "mga_drv.h"
@@ -111,7 +112,7 @@
 static int __init mga_init(void)
 {
 	driver.num_ioctls = mga_max_ioctl;
-	return drm_init(&driver);
+	return drm_init(&driver, CORE_VERSION);
 }

 static void __exit mga_exit(void)
diff -Nru a/drivers/char/drm/r128_drv.c b/drivers/char/drm/r128_drv.c
--- a/drivers/char/drm/r128_drv.c	2005-03-28 21:34:45 +10:00
+++ b/drivers/char/drm/r128_drv.c	2005-03-28 21:34:45 +10:00
@@ -31,6 +31,7 @@

 #include <linux/config.h>
 #include "drmP.h"
+#include "drm_core.h"
 #include "drm.h"
 #include "r128_drm.h"
 #include "r128_drv.h"
@@ -106,7 +107,7 @@
 static int __init r128_init(void)
 {
 	driver.num_ioctls = r128_max_ioctl;
-	return drm_init(&driver);
+	return drm_init(&driver, CORE_VERSION);
 }

 static void __exit r128_exit(void)
diff -Nru a/drivers/char/drm/radeon_drv.c b/drivers/char/drm/radeon_drv.c
--- a/drivers/char/drm/radeon_drv.c	2005-03-28 21:34:45 +10:00
+++ b/drivers/char/drm/radeon_drv.c	2005-03-28 21:34:45 +10:00
@@ -32,6 +32,7 @@

 #include <linux/config.h>
 #include "drmP.h"
+#include "drm_core.h"
 #include "drm.h"
 #include "radeon_drm.h"
 #include "radeon_drv.h"
@@ -111,7 +112,7 @@
 static int __init radeon_init(void)
 {
 	driver.num_ioctls = radeon_max_ioctl;
-	return drm_init(&driver);
+	return drm_init(&driver, CORE_VERSION);
 }

 static void __exit radeon_exit(void)
diff -Nru a/drivers/char/drm/sis_drv.c b/drivers/char/drm/sis_drv.c
--- a/drivers/char/drm/sis_drv.c	2005-03-28 21:34:45 +10:00
+++ b/drivers/char/drm/sis_drv.c	2005-03-28 21:34:45 +10:00
@@ -27,6 +27,7 @@

 #include <linux/config.h>
 #include "drmP.h"
+#include "drm_core.h"
 #include "sis_drm.h"
 #include "sis_drv.h"

@@ -94,7 +95,7 @@
 static int __init sis_init(void)
 {
 	driver.num_ioctls = sis_max_ioctl;
-	return drm_init(&driver);
+	return drm_init(&driver, CORE_VERSION);
 }

 static void __exit sis_exit(void)
diff -Nru a/drivers/char/drm/tdfx_drv.c b/drivers/char/drm/tdfx_drv.c
--- a/drivers/char/drm/tdfx_drv.c	2005-03-28 21:34:45 +10:00
+++ b/drivers/char/drm/tdfx_drv.c	2005-03-28 21:34:45 +10:00
@@ -32,6 +32,7 @@

 #include <linux/config.h>
 #include "drmP.h"
+#include "drm_core.h"
 #include "tdfx_drv.h"

 #include "drm_pciids.h"
@@ -91,7 +92,7 @@

 static int __init tdfx_init(void)
 {
-	return drm_init(&driver);
+	return drm_init(&driver, CORE_VERSION);
 }

 static void __exit tdfx_exit(void)
