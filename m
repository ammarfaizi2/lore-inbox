Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVAEJ1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVAEJ1Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 04:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVAEJ1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 04:27:25 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:19332 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262296AbVAEJ1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 04:27:06 -0500
Date: Wed, 5 Jan 2005 09:27:04 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org
Subject: [bk tree] DRM: mark ffb as broken and make it compile..
Message-ID: <Pine.LNX.4.58.0501050923270.3200@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
	The sparc ffb driver has been broken since 2.6.8, and is even more
broken now, so mark it as such until someone fixes it (I'm available to
help but I can't do any testing), it also just makes it at least build...

(davem: I've just cc'ed you as this touchs sparc64 Kconfig.)

Please do a

	bk pull bk://drm.bkbits.net/drm-linus

This will include the latest DRM changes and will update the following files:

 arch/sparc64/Kconfig       |    2
 drivers/char/drm/ffb_drv.c |   97 ++++++++++++++++++++++++++++++++-------------
 drivers/char/drm/ffb_drv.h |    2
 3 files changed, 73 insertions(+), 28 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (05/01/02 1.2091)
   drm: mark ffb as broken because it actually is

   The ffb driver has been broken since 2.6.8 at least, so mark it
   as so. This also contains some fixes so it at least compiles.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
--- a/arch/sparc64/Kconfig	2005-01-05 20:22:31 +11:00
+++ b/arch/sparc64/Kconfig	2005-01-05 20:22:31 +11:00
@@ -556,7 +556,7 @@

 config DRM_FFB
 	tristate "Creator/Creator3D"
-	depends on DRM
+	depends on DRM && BROKEN
 	help
 	  Choose this option if you have one of Sun's Creator3D-based graphics
 	  and frame buffer cards.  Product page at
diff -Nru a/drivers/char/drm/ffb_drv.c b/drivers/char/drm/ffb_drv.c
--- a/drivers/char/drm/ffb_drv.c	2005-01-05 20:22:31 +11:00
+++ b/drivers/char/drm/ffb_drv.c	2005-01-05 20:22:31 +11:00
@@ -210,30 +210,17 @@
 	return addr;
 }

-/* This functions must be here since it references drm_numdevs)
- * which drm_drv.h declares.
- */
 static int ffb_presetup(drm_device_t *dev)
 {
 	ffb_dev_priv_t	*ffb_priv;
-	drm_device_t *temp_dev;
 	int ret = 0;
-	int i;
+	int i = 0;

 	/* Check for the case where no device was found. */
 	if (ffb_position == NULL)
 		return -ENODEV;

-	/* Find our instance number by finding our device in dev structure */
-	for (i = 0; i < drm_numdevs; i++) {
-		temp_dev = &(drm_device[i]);
-		if(temp_dev == dev)
-			break;
-	}
-
-	if (i == drm_numdevs)
-		return -ENODEV;
-
+	/* code used to use numdevs no numdevs anymore */
 	ffb_priv = kmalloc(sizeof(ffb_dev_priv_t), GFP_KERNEL);
 	if (!ffb_priv)
 		return -ENOMEM;
@@ -305,16 +292,74 @@
        return 0;
 }

-void ffb_driver_register_fns(drm_device_t *dev)
+static int postinit( struct drm_device *dev, unsigned long flags )
+{
+	DRM_INFO( "Initialized %s %d.%d.%d %s on minor %d\n",
+		DRIVER_NAME,
+		DRIVER_MAJOR,
+		DRIVER_MINOR,
+		DRIVER_PATCHLEVEL,
+		DRIVER_DATE,
+		dev->minor
+		);
+	return 0;
+}
+
+static int version( drm_version_t *version )
 {
-	ffb_set_context_ioctls();
-	DRM(fops).get_unmapped_area = ffb_get_unmapped_area;
-	dev->driver.release = ffb_driver_release;
-	dev->driver.presetup = ffb_presetup;
-	dev->driver.pretakedown = ffb_driver_pretakedown;
-	dev->driver.postcleanup = ffb_driver_postcleanup;
-	dev->driver.kernel_context_switch = ffb_context_switch;
-	dev->driver.kernel_context_switch_unlock = ffb_driver_kernel_context_switch_unlock;
-	dev->driver.get_map_ofs = ffb_driver_get_map_ofs;
-	dev->driver.get_reg_ofs = ffb_driver_get_reg_ofs;
+	int len;
+
+	version->version_major = DRIVER_MAJOR;
+	version->version_minor = DRIVER_MINOR;
+	version->version_patchlevel = DRIVER_PATCHLEVEL;
+	DRM_COPY( version->name, DRIVER_NAME );
+	DRM_COPY( version->date, DRIVER_DATE );
+	DRM_COPY( version->desc, DRIVER_DESC );
+	return 0;
 }
+
+static drm_ioctl_desc_t ioctls[] = {
+
+};
+
+static struct drm_driver driver = {
+	.driver_features = 0,
+	.dev_priv_size = sizeof(u32),
+	.release = ffb_driver_release,
+	.presetup = ffb_presetup,
+	.pretakedown = ffb_driver_pretakedown,
+	.postcleanup = ffb_driver_postcleanup,
+	.kernel_context_switch = ffb_driver_context_switch,
+	.kernel_context_switch_unlock = ffb_driver_kernel_context_switch_unlock,
+	.get_map_ofs = ffb_driver_get_map_ofs,
+	.get_reg_ofs = ffb_driver_get_reg_ofs,
+	.postinit = postinit,
+	.version = version,
+	.ioctls = ioctls,
+	.num_ioctls = DRM_ARRAY_SIZE(ioctls),
+	.fops = {
+		.owner = THIS_MODULE,
+		.open = drm_open,
+		.release = drm_release,
+		.ioctl = drm_ioctl,
+		.mmap = drm_mmap,
+		.poll = drm_poll,
+		.fasync = drm_fasync,
+	},
+};
+
+static int __init ffb_init(void)
+{
+	return -ENODEV;
+}
+
+static void __exit ffb_exit(void)
+{
+}
+
+module_init(ffb_init);
+module_exit(ffb_exit);
+
+MODULE_AUTHOR( DRIVER_AUTHOR );
+MODULE_DESCRIPTION( DRIVER_DESC );
+MODULE_LICENSE("GPL and additional rights");
diff -Nru a/drivers/char/drm/ffb_drv.h b/drivers/char/drm/ffb_drv.h
--- a/drivers/char/drm/ffb_drv.h	2005-01-05 20:22:31 +11:00
+++ b/drivers/char/drm/ffb_drv.h	2005-01-05 20:22:31 +11:00
@@ -275,7 +275,6 @@
 	struct ffb_hw_context	*hw_state[FFB_MAX_CTXS];
 } ffb_dev_priv_t;

-extern struct file_operations DRM(fops);
 extern unsigned long ffb_get_unmapped_area(struct file *filp,
 					   unsigned long hint,
 					   unsigned long len,
@@ -284,3 +283,4 @@
 extern void ffb_set_context_ioctls(void);
 extern drm_ioctl_desc_t DRM(ioctls)[];

+extern int ffb_driver_context_switch(drm_device_t *dev, int old, int new);
