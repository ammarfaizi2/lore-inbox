Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWDWLjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWDWLjH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 07:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWDWLjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 07:39:07 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61451 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751375AbWDWLjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 07:39:05 -0400
Date: Sun, 23 Apr 2006 13:39:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/base/firmware_class.c: cleanups
Message-ID: <20060423113904.GI5010@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- remove the following global function that is both unused and 
  unimplemented:
  - register_firmware()
- make the following needlessly global function static:
  - firmware_class_uevent()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/firmware_class/README                   |   17 ----
 Documentation/firmware_class/firmware_sample_driver.c |   11 --
 drivers/base/firmware_class.c                         |   39 ++--------
 include/linux/firmware.h                              |    1 
 4 files changed, 8 insertions(+), 60 deletions(-)

--- linux-2.6.17-rc1-mm3-full/Documentation/firmware_class/README.old	2006-04-23 01:25:58.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/Documentation/firmware_class/README	2006-04-23 01:26:16.000000000 +0200
@@ -105,20 +105,3 @@
    on the setup, so I think that the choice on what firmware to make
    persistent should be left to userspace.
 
- - Why register_firmware()+__init can be useful:
- 	- For boot devices needing firmware.
-	- To make the transition easier:
-		The firmware can be declared __init and register_firmware()
-		called on module_init. Then the firmware is warranted to be
-		there even if "firmware hotplug userspace" is not there yet or
-		it doesn't yet provide the needed firmware.
-		Once the firmware is widely available in userspace, it can be
-		removed from the kernel. Or made optional (CONFIG_.*_FIRMWARE).
-
-	In either case, if firmware hotplug support is there, it can move the
-	firmware out of kernel memory into the real filesystem for later
-	usage.
-
-	Note: If persistence is implemented on top of initramfs,
-	register_firmware() may not be appropriate.
-
--- linux-2.6.17-rc1-mm3-full/Documentation/firmware_class/firmware_sample_driver.c.old	2006-04-23 01:26:28.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/Documentation/firmware_class/firmware_sample_driver.c	2006-04-23 01:26:57.000000000 +0200
@@ -5,8 +5,6 @@
  *
  * Sample code on how to use request_firmware() from drivers.
  *
- * Note that register_firmware() is currently useless.
- *
  */
 
 #include <linux/module.h>
@@ -17,11 +15,6 @@
 
 #include "linux/firmware.h"
 
-#define WE_CAN_NEED_FIRMWARE_BEFORE_USERSPACE_IS_AVAILABLE
-#ifdef WE_CAN_NEED_FIRMWARE_BEFORE_USERSPACE_IS_AVAILABLE
-char __init inkernel_firmware[] = "let's say that this is firmware\n";
-#endif
-
 static struct device ghost_device = {
 	.bus_id    = "ghost0",
 };
@@ -104,10 +97,6 @@
 
 static int sample_init(void)
 {
-#ifdef WE_CAN_NEED_FIRMWARE_BEFORE_USERSPACE_IS_AVAILABLE
-	register_firmware("sample_driver_fw", inkernel_firmware,
-			  sizeof(inkernel_firmware));
-#endif
 	device_initialize(&ghost_device);
 	/* since there is no real hardware insertion I just call the
 	 * sample probe functions here */
--- linux-2.6.17-rc1-mm3-full/include/linux/firmware.h.old	2006-04-23 01:27:07.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/include/linux/firmware.h	2006-04-23 01:27:13.000000000 +0200
@@ -19,5 +19,4 @@
 	void (*cont)(const struct firmware *fw, void *context));
 
 void release_firmware(const struct firmware *fw);
-void register_firmware(const char *name, const u8 *data, size_t size);
 #endif
--- linux-2.6.17-rc1-mm3-full/drivers/base/firmware_class.c.old	2006-04-23 01:27:22.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/base/firmware_class.c	2006-04-23 01:29:13.000000000 +0200
@@ -86,18 +86,9 @@
 static CLASS_ATTR(timeout, 0644, firmware_timeout_show, firmware_timeout_store);
 
 static void  fw_class_dev_release(struct class_device *class_dev);
-int firmware_class_uevent(struct class_device *dev, char **envp,
-			   int num_envp, char *buffer, int buffer_size);
 
-static struct class firmware_class = {
-	.name		= "firmware",
-	.uevent	= firmware_class_uevent,
-	.release	= fw_class_dev_release,
-};
-
-int
-firmware_class_uevent(struct class_device *class_dev, char **envp,
-		       int num_envp, char *buffer, int buffer_size)
+static int firmware_class_uevent(struct class_device *class_dev, char **envp,
+				 int num_envp, char *buffer, int buffer_size)
 {
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
 	int i = 0, len = 0;
@@ -116,6 +107,12 @@
 	return 0;
 }
 
+static struct class firmware_class = {
+	.name		= "firmware",
+	.uevent		= firmware_class_uevent,
+	.release	= fw_class_dev_release,
+};
+
 static ssize_t
 firmware_loading_show(struct class_device *class_dev, char *buf)
 {
@@ -493,25 +490,6 @@
 	}
 }
 
-/**
- * register_firmware: - provide a firmware image for later usage
- * @name: name of firmware image file
- * @data: buffer pointer for the firmware image
- * @size: size of the data buffer area
- *
- *	Make sure that @data will be available by requesting firmware @name.
- *
- *	Note: This will not be possible until some kind of persistence
- *	is available.
- **/
-void
-register_firmware(const char *name, const u8 *data, size_t size)
-{
-	/* This is meaningless without firmware caching, so until we
-	 * decide if firmware caching is reasonable just leave it as a
-	 * noop */
-}
-
 /* Async support */
 struct firmware_work {
 	struct work_struct work;
@@ -630,4 +608,3 @@
 EXPORT_SYMBOL(release_firmware);
 EXPORT_SYMBOL(request_firmware);
 EXPORT_SYMBOL(request_firmware_nowait);
-EXPORT_SYMBOL(register_firmware);

