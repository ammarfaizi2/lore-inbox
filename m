Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264594AbUATBSk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUATBRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:17:52 -0500
Received: from mail.kroah.org ([65.200.24.183]:27081 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265336AbUATBMl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:12:41 -0500
Subject: Re: [PATCH] Driver Core update and fixes for 2.6.1
In-Reply-To: <10745611602@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 17:12:40 -0800
Message-Id: <10745611602007@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1499, 2004/01/19 16:38:36-08:00, greg@kroah.com

[PATCH] Input: add sysfs class support for input devices

This patch adds sysfs support for all input devices.  It also provides
the "device" and "driver" symlink for all Input devices that specify it.


 drivers/input/evdev.c    |    4 ++++
 drivers/input/input.c    |    8 +++-----
 drivers/input/joydev.c   |    4 ++++
 drivers/input/mousedev.c |    8 +++++++-
 drivers/input/tsdev.c    |    4 ++++
 include/linux/input.h    |    3 ++-
 6 files changed, 24 insertions(+), 7 deletions(-)


diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	Mon Jan 19 17:05:06 2004
+++ b/drivers/input/evdev.c	Mon Jan 19 17:05:06 2004
@@ -92,6 +92,7 @@
 static void evdev_free(struct evdev *evdev)
 {
 	devfs_remove("input/event%d", evdev->minor);
+	class_simple_device_remove(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
 	evdev_table[evdev->minor] = NULL;
 	kfree(evdev);
 }
@@ -426,6 +427,9 @@
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/event%d", minor);
+	class_simple_device_add(input_class, 
+				MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
+				dev->dev, "event%d", minor);
 
 	return &evdev->handle;
 }
diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Mon Jan 19 17:05:06 2004
+++ b/drivers/input/input.c	Mon Jan 19 17:05:06 2004
@@ -720,15 +720,13 @@
 static inline int input_proc_init(void) { return 0; }
 #endif
 
-struct class input_class = {
-	.name		= "input",
-};
+struct class_simple *input_class;
 
 static int __init input_init(void)
 {
 	int retval = -ENOMEM;
 
-	class_register(&input_class);
+	input_class = class_simple_create(THIS_MODULE, "input");
 	input_proc_init();
 	retval = register_chrdev(INPUT_MAJOR, "input", &input_fops);
 	if (retval) {
@@ -757,7 +755,7 @@
 
 	devfs_remove("input");
 	unregister_chrdev(INPUT_MAJOR, "input");
-	class_unregister(&input_class);
+	class_simple_destroy(input_class);
 }
 
 subsys_initcall(input_init);
diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	Mon Jan 19 17:05:06 2004
+++ b/drivers/input/joydev.c	Mon Jan 19 17:05:06 2004
@@ -145,6 +145,7 @@
 {
 	devfs_remove("js%d", joydev->minor);
 	joydev_table[joydev->minor] = NULL;
+	class_simple_device_remove(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
 	kfree(joydev);
 }
 
@@ -444,6 +445,9 @@
 	
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "js%d", minor);
+	class_simple_device_add(input_class, 
+				MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
+				dev->dev, "js%d", minor);
 
 	return &joydev->handle;
 }
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Mon Jan 19 17:05:06 2004
+++ b/drivers/input/mousedev.c	Mon Jan 19 17:05:06 2004
@@ -225,6 +225,7 @@
 static void mousedev_free(struct mousedev *mousedev)
 {
 	devfs_remove("input/mouse%d", mousedev->minor);
+	class_simple_device_remove(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
 	mousedev_table[mousedev->minor] = NULL;
 	kfree(mousedev);
 }
@@ -486,6 +487,9 @@
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/mouse%d", minor);
+	class_simple_device_add(input_class, 
+				MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
+				dev->dev, "mouse%d", minor);
 
 	return &mousedev->handle;
 }
@@ -564,7 +568,8 @@
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/mice");
-
+	class_simple_device_add(input_class, MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
+				NULL, "mice");
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 	if (!(mousedev_mix.misc = !misc_register(&psaux_mouse)))
@@ -583,6 +588,7 @@
 		misc_deregister(&psaux_mouse);
 #endif
 	devfs_remove("input/mice");
+	class_simple_device_remove(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX));
 	input_unregister_handler(&mousedev_handler);
 }
 
diff -Nru a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c	Mon Jan 19 17:05:06 2004
+++ b/drivers/input/tsdev.c	Mon Jan 19 17:05:06 2004
@@ -129,6 +129,7 @@
 static void tsdev_free(struct tsdev *tsdev)
 {
 	devfs_remove("input/ts%d", tsdev->minor);
+	class_simple_device_remove(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
 	tsdev_table[tsdev->minor] = NULL;
 	kfree(tsdev);
 }
@@ -343,6 +344,9 @@
 	
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/ts%d", minor);
+	class_simple_device_add(input_class, 
+				MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
+				dev->dev, "ts%d", minor);
 
 	return &tsdev->handle;
 }
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Mon Jan 19 17:05:06 2004
+++ b/include/linux/input.h	Mon Jan 19 17:05:06 2004
@@ -809,6 +809,7 @@
 	int (*erase_effect)(struct input_dev *dev, int effect_id);
 
 	struct input_handle *grab;
+	struct device *dev;
 
 	struct list_head	h_list;
 	struct list_head	node;
@@ -921,7 +922,7 @@
 #define input_regs(a,b)		do { (a)->regs = (b); } while (0)
 #define input_sync(a)		do { input_event(a, EV_SYN, SYN_REPORT, 0); (a)->regs = NULL; } while (0)
 
-extern struct class input_class;
+extern struct class_simple *input_class;
 
 #endif
 #endif

