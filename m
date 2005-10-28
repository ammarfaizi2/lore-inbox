Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbVJ1GcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbVJ1GcX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbVJ1GcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:32:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:40170 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965138AbVJ1GbW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:22 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] Input: kill devfs references
In-Reply-To: <11304810242749@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:24 -0700
Message-Id: <11304810242681@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Input: kill devfs references

Input: remove references to devfs from input subsystem

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit f2e28e004f12e0e3fd1edf3ca1f35b42ab45988f
tree c460ec846a36705836ba7f641a610a161f3a7996
parent e9a873633c67dd048c9d53f3e934e83df10312d1
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 15 Sep 2005 02:01:38 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:03 -0700

 drivers/input/evdev.c    |    4 ----
 drivers/input/input.c    |    7 -------
 drivers/input/joydev.c   |    4 ----
 drivers/input/mousedev.c |    9 +--------
 drivers/input/tsdev.c    |    7 -------
 5 files changed, 1 insertions(+), 30 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 83b694c..14ea57f 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -20,7 +20,6 @@
 #include <linux/major.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/compat.h>
 
 struct evdev {
@@ -687,8 +686,6 @@ static struct input_handle *evdev_connec
 
 	evdev_table[minor] = evdev;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/event%d", minor);
 	class_device_create(input_class, NULL,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
 			dev->dev, "event%d", minor);
@@ -703,7 +700,6 @@ static void evdev_disconnect(struct inpu
 
 	class_device_destroy(input_class,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
-	devfs_remove("input/event%d", evdev->minor);
 	evdev->exist = 0;
 
 	if (evdev->open) {
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 14ae558..072bbf5 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -22,7 +22,6 @@
 #include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("Input core");
@@ -770,13 +769,8 @@ static int __init input_init(void)
 		goto fail2;
 	}
 
-	err = devfs_mk_dir("input");
-	if (err)
-		goto fail3;
-
 	return 0;
 
- fail3:	unregister_chrdev(INPUT_MAJOR, "input");
  fail2:	input_proc_exit();
  fail1:	class_destroy(input_class);
 	return err;
@@ -785,7 +779,6 @@ static int __init input_init(void)
 static void __exit input_exit(void)
 {
 	input_proc_exit();
-	devfs_remove("input");
 	unregister_chrdev(INPUT_MAJOR, "input");
 	class_destroy(input_class);
 }
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index c696fb2..40d2b46 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -26,7 +26,6 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Joystick device interfaces");
@@ -514,8 +513,6 @@ static struct input_handle *joydev_conne
 
 	joydev_table[minor] = joydev;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/js%d", minor);
 	class_device_create(input_class, NULL,
 			MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
 			dev->dev, "js%d", minor);
@@ -529,7 +526,6 @@ static void joydev_disconnect(struct inp
 	struct joydev_list *list;
 
 	class_device_destroy(input_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
-	devfs_remove("input/js%d", joydev->minor);
 	joydev->exist = 0;
 
 	if (joydev->open) {
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index d7144e1..89c3e49 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -9,7 +9,7 @@
  * the Free Software Foundation.
  */
 
-#define MOUSEDEV_MINOR_BASE 	32
+#define MOUSEDEV_MINOR_BASE	32
 #define MOUSEDEV_MINORS		32
 #define MOUSEDEV_MIX		31
 
@@ -24,7 +24,6 @@
 #include <linux/random.h>
 #include <linux/major.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 #include <linux/miscdevice.h>
 #endif
@@ -649,8 +648,6 @@ static struct input_handle *mousedev_con
 
 	mousedev_table[minor] = mousedev;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/mouse%d", minor);
 	class_device_create(input_class, NULL,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
 			dev->dev, "mouse%d", minor);
@@ -665,7 +662,6 @@ static void mousedev_disconnect(struct i
 
 	class_device_destroy(input_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
-	devfs_remove("input/mouse%d", mousedev->minor);
 	mousedev->exist = 0;
 
 	if (mousedev->open) {
@@ -738,8 +734,6 @@ static int __init mousedev_init(void)
 	mousedev_mix.exist = 1;
 	mousedev_mix.minor = MOUSEDEV_MIX;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/mice");
 	class_device_create(input_class, NULL,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX), NULL, "mice");
 
@@ -759,7 +753,6 @@ static void __exit mousedev_exit(void)
 	if (psaux_registered)
 		misc_deregister(&psaux_mouse);
 #endif
-	devfs_remove("input/mice");
 	class_device_destroy(input_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX));
 	input_unregister_handler(&mousedev_handler);
diff --git a/drivers/input/tsdev.c b/drivers/input/tsdev.c
index fbb35c9..2d45e4d 100644
--- a/drivers/input/tsdev.c
+++ b/drivers/input/tsdev.c
@@ -53,7 +53,6 @@
 #include <linux/random.h>
 #include <linux/time.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 
 #ifndef CONFIG_INPUT_TSDEV_SCREEN_X
 #define CONFIG_INPUT_TSDEV_SCREEN_X	240
@@ -410,10 +409,6 @@ static struct input_handle *tsdev_connec
 
 	tsdev_table[minor] = tsdev;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/ts%d", minor);
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor + TSDEV_MINORS/2),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/tsraw%d", minor);
 	class_device_create(input_class, NULL,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
 			dev->dev, "ts%d", minor);
@@ -428,8 +423,6 @@ static void tsdev_disconnect(struct inpu
 
 	class_device_destroy(input_class,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
-	devfs_remove("input/ts%d", tsdev->minor);
-	devfs_remove("input/tsraw%d", tsdev->minor);
 	tsdev->exist = 0;
 
 	if (tsdev->open) {

