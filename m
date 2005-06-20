Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVFUDvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVFUDvp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVFUDRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:17:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:5348 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261650AbVFTW7e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:34 -0400
Cc: gregkh@suse.de
Subject: [PATCH] INPUT: move to use the new class code, instead of class_simple
In-Reply-To: <11193083612284@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:22 -0700
Message-Id: <11193083621397@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] INPUT: move to use the new class code, instead of class_simple

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 1235686f6e67cf30c460eb77d90a6cb4be57b92f
tree c7ef368a38c8e0c64e09d9e0e8a2a93392a1732c
parent 7fe845d11ad1b4aac098d40c55275569e143c483
author gregkh@suse.de <gregkh@suse.de> Tue, 15 Mar 2005 14:26:30 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:04 -0700

 drivers/input/evdev.c    |    9 +++++----
 drivers/input/input.c    |   10 +++++-----
 drivers/input/joydev.c   |    8 ++++----
 drivers/input/mousedev.c |   16 +++++++++-------
 drivers/input/tsdev.c    |    9 +++++----
 include/linux/input.h    |    2 +-
 6 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -431,9 +431,9 @@ static struct input_handle *evdev_connec
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/event%d", minor);
-	class_simple_device_add(input_class,
-				MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
-				dev->dev, "event%d", minor);
+	class_device_create(input_class,
+			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
+			dev->dev, "event%d", minor);
 
 	return &evdev->handle;
 }
@@ -443,7 +443,8 @@ static void evdev_disconnect(struct inpu
 	struct evdev *evdev = handle->private;
 	struct evdev_list *list;
 
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
+	class_device_destroy(input_class,
+			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
 	devfs_remove("input/event%d", evdev->minor);
 	evdev->exist = 0;
 
diff --git a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -702,13 +702,13 @@ static int __init input_proc_init(void)
 static inline int input_proc_init(void) { return 0; }
 #endif
 
-struct class_simple *input_class;
+struct class *input_class;
 
 static int __init input_init(void)
 {
 	int retval = -ENOMEM;
 
-	input_class = class_simple_create(THIS_MODULE, "input");
+	input_class = class_create(THIS_MODULE, "input");
 	if (IS_ERR(input_class))
 		return PTR_ERR(input_class);
 	input_proc_init();
@@ -718,7 +718,7 @@ static int __init input_init(void)
 		remove_proc_entry("devices", proc_bus_input_dir);
 		remove_proc_entry("handlers", proc_bus_input_dir);
 		remove_proc_entry("input", proc_bus);
-		class_simple_destroy(input_class);
+		class_destroy(input_class);
 		return retval;
 	}
 
@@ -728,7 +728,7 @@ static int __init input_init(void)
 		remove_proc_entry("handlers", proc_bus_input_dir);
 		remove_proc_entry("input", proc_bus);
 		unregister_chrdev(INPUT_MAJOR, "input");
-		class_simple_destroy(input_class);
+		class_destroy(input_class);
 	}
 	return retval;
 }
@@ -741,7 +741,7 @@ static void __exit input_exit(void)
 
 	devfs_remove("input");
 	unregister_chrdev(INPUT_MAJOR, "input");
-	class_simple_destroy(input_class);
+	class_destroy(input_class);
 }
 
 subsys_initcall(input_init);
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -452,9 +452,9 @@ static struct input_handle *joydev_conne
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/js%d", minor);
-	class_simple_device_add(input_class,
-				MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
-				dev->dev, "js%d", minor);
+	class_device_create(input_class,
+			MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
+			dev->dev, "js%d", minor);
 
 	return &joydev->handle;
 }
@@ -464,7 +464,7 @@ static void joydev_disconnect(struct inp
 	struct joydev *joydev = handle->private;
 	struct joydev_list *list;
 
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
+	class_device_destroy(input_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
 	devfs_remove("input/js%d", joydev->minor);
 	joydev->exist = 0;
 
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -647,9 +647,9 @@ static struct input_handle *mousedev_con
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/mouse%d", minor);
-	class_simple_device_add(input_class,
-				MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
-				dev->dev, "mouse%d", minor);
+	class_device_create(input_class,
+			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
+			dev->dev, "mouse%d", minor);
 
 	return &mousedev->handle;
 }
@@ -659,7 +659,8 @@ static void mousedev_disconnect(struct i
 	struct mousedev *mousedev = handle->private;
 	struct mousedev_list *list;
 
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
+	class_device_destroy(input_class,
+			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
 	devfs_remove("input/mouse%d", mousedev->minor);
 	mousedev->exist = 0;
 
@@ -735,8 +736,8 @@ static int __init mousedev_init(void)
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/mice");
-	class_simple_device_add(input_class, MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
-				NULL, "mice");
+	class_device_create(input_class,
+			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX), NULL, "mice");
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 	if (!(psaux_registered = !misc_register(&psaux_mouse)))
@@ -755,7 +756,8 @@ static void __exit mousedev_exit(void)
 		misc_deregister(&psaux_mouse);
 #endif
 	devfs_remove("input/mice");
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX));
+	class_device_destroy(input_class,
+			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX));
 	input_unregister_handler(&mousedev_handler);
 }
 
diff --git a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c
+++ b/drivers/input/tsdev.c
@@ -414,9 +414,9 @@ static struct input_handle *tsdev_connec
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/ts%d", minor);
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor + TSDEV_MINORS/2),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/tsraw%d", minor);
-	class_simple_device_add(input_class,
-				MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
-				dev->dev, "ts%d", minor);
+	class_device_create(input_class,
+			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
+			dev->dev, "ts%d", minor);
 
 	return &tsdev->handle;
 }
@@ -426,7 +426,8 @@ static void tsdev_disconnect(struct inpu
 	struct tsdev *tsdev = handle->private;
 	struct tsdev_list *list;
 
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
+	class_device_destroy(input_class,
+			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
 	devfs_remove("input/ts%d", tsdev->minor);
 	devfs_remove("input/tsraw%d", tsdev->minor);
 	tsdev->exist = 0;
diff --git a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1015,7 +1015,7 @@ static inline void input_set_abs_params(
 	dev->absbit[LONG(axis)] |= BIT(axis);
 }
 
-extern struct class_simple *input_class;
+extern struct class *input_class;
 
 #endif
 #endif

