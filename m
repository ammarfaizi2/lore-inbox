Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbVIOGwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbVIOGwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbVIOGwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:52:19 -0400
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:38310 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030384AbVIOGvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:51:47 -0400
Message-Id: <20050915064943.619025000.dtor_core@ameritech.net>
References: <20050915064552.836273000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 01:45:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de>,
Kay Sievers <kay.sievers@vrfy.org>,
Vojtech Pavlik <vojtech@suse.cz>,
Hannes Reinecke <hare@suse.de>
Subject: [patch 07/28] Input: kill devfs references
Content-Disposition: inline; filename=input-kill-devfs.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Input: remove references to devfs from input subsystem

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/evdev.c    |    4 ----
 drivers/input/input.c    |    7 -------
 drivers/input/joydev.c   |    4 ----
 drivers/input/mousedev.c |    9 +--------
 drivers/input/tsdev.c    |    7 -------
 5 files changed, 1 insertion(+), 30 deletions(-)

Index: work/drivers/input/evdev.c
===================================================================
--- work.orig/drivers/input/evdev.c
+++ work/drivers/input/evdev.c
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
 	class_device_create(input_class,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
 			dev->dev, "event%d", minor);
@@ -703,7 +700,6 @@ static void evdev_disconnect(struct inpu
 
 	class_device_destroy(input_class,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
-	devfs_remove("input/event%d", evdev->minor);
 	evdev->exist = 0;
 
 	if (evdev->open) {
Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -22,7 +22,6 @@
 #include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("Input core");
@@ -769,13 +768,8 @@ static int __init input_init(void)
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
@@ -784,7 +778,6 @@ static int __init input_init(void)
 static void __exit input_exit(void)
 {
 	input_proc_exit();
-	devfs_remove("input");
 	unregister_chrdev(INPUT_MAJOR, "input");
 	class_destroy(input_class);
 }
Index: work/drivers/input/joydev.c
===================================================================
--- work.orig/drivers/input/joydev.c
+++ work/drivers/input/joydev.c
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
 	class_device_create(input_class,
 			MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
 			dev->dev, "js%d", minor);
@@ -529,7 +526,6 @@ static void joydev_disconnect(struct inp
 	struct joydev_list *list;
 
 	class_device_destroy(input_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
-	devfs_remove("input/js%d", joydev->minor);
 	joydev->exist = 0;
 
 	if (joydev->open) {
Index: work/drivers/input/mousedev.c
===================================================================
--- work.orig/drivers/input/mousedev.c
+++ work/drivers/input/mousedev.c
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
 	class_device_create(input_class,
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
 	class_device_create(input_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX), NULL, "mice");
 
@@ -759,7 +753,6 @@ static void __exit mousedev_exit(void)
 	if (psaux_registered)
 		misc_deregister(&psaux_mouse);
 #endif
-	devfs_remove("input/mice");
 	class_device_destroy(input_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX));
 	input_unregister_handler(&mousedev_handler);
Index: work/drivers/input/tsdev.c
===================================================================
--- work.orig/drivers/input/tsdev.c
+++ work/drivers/input/tsdev.c
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
 	class_device_create(input_class,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
 			dev->dev, "ts%d", minor);
@@ -428,8 +423,6 @@ static void tsdev_disconnect(struct inpu
 
 	class_device_destroy(input_class,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
-	devfs_remove("input/ts%d", tsdev->minor);
-	devfs_remove("input/tsraw%d", tsdev->minor);
 	tsdev->exist = 0;
 
 	if (tsdev->open) {

