Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVCORLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVCORLi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVCORLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:11:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:49095 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261519AbVCORL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:11:27 -0500
Date: Tue, 15 Mar 2005 09:10:33 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Cc: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Changes to the driver model class code.
Message-ID: <20050315171033.GD25475@kroah.com>
References: <20050315170834.GA25475@kroah.com> <20050315170935.GB25475@kroah.com> <20050315171000.GC25475@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315171000.GC25475@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch 3 of 4

 Subject: INPUT: move to use the new class code, instead of class_simple
  
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	2005-03-15 08:54:28 -08:00
+++ b/drivers/input/evdev.c	2005-03-15 08:54:28 -08:00
@@ -431,9 +431,9 @@
 
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
@@ -443,7 +443,8 @@
 	struct evdev *evdev = handle->private;
 	struct evdev_list *list;
 
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
+	class_device_destroy(input_class,
+			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
 	devfs_remove("input/event%d", evdev->minor);
 	evdev->exist = 0;
 
diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	2005-03-15 08:54:28 -08:00
+++ b/drivers/input/input.c	2005-03-15 08:54:28 -08:00
@@ -702,13 +702,13 @@
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
@@ -718,7 +718,7 @@
 		remove_proc_entry("devices", proc_bus_input_dir);
 		remove_proc_entry("handlers", proc_bus_input_dir);
 		remove_proc_entry("input", proc_bus);
-		class_simple_destroy(input_class);
+		class_destroy(input_class);
 		return retval;
 	}
 
@@ -728,7 +728,7 @@
 		remove_proc_entry("handlers", proc_bus_input_dir);
 		remove_proc_entry("input", proc_bus);
 		unregister_chrdev(INPUT_MAJOR, "input");
-		class_simple_destroy(input_class);
+		class_destroy(input_class);
 	}
 	return retval;
 }
@@ -741,7 +741,7 @@
 
 	devfs_remove("input");
 	unregister_chrdev(INPUT_MAJOR, "input");
-	class_simple_destroy(input_class);
+	class_destroy(input_class);
 }
 
 subsys_initcall(input_init);
diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	2005-03-15 08:54:28 -08:00
+++ b/drivers/input/joydev.c	2005-03-15 08:54:28 -08:00
@@ -452,9 +452,9 @@
 
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
@@ -464,7 +464,7 @@
 	struct joydev *joydev = handle->private;
 	struct joydev_list *list;
 
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
+	class_device_destroy(input_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
 	devfs_remove("input/js%d", joydev->minor);
 	joydev->exist = 0;
 
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	2005-03-15 08:54:28 -08:00
+++ b/drivers/input/mousedev.c	2005-03-15 08:54:28 -08:00
@@ -642,9 +642,9 @@
 
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
@@ -654,7 +654,8 @@
 	struct mousedev *mousedev = handle->private;
 	struct mousedev_list *list;
 
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
+	class_device_destroy(input_class,
+			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
 	devfs_remove("input/mouse%d", mousedev->minor);
 	mousedev->exist = 0;
 
@@ -730,8 +731,8 @@
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/mice");
-	class_simple_device_add(input_class, MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
-				NULL, "mice");
+	class_device_create(input_class,
+			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX), NULL, "mice");
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 	if (!(psaux_registered = !misc_register(&psaux_mouse)))
@@ -750,7 +751,8 @@
 		misc_deregister(&psaux_mouse);
 #endif
 	devfs_remove("input/mice");
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX));
+	class_device_destroy(input_class,
+			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX));
 	input_unregister_handler(&mousedev_handler);
 }
 
diff -Nru a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c	2005-03-15 08:54:28 -08:00
+++ b/drivers/input/tsdev.c	2005-03-15 08:54:28 -08:00
@@ -414,9 +414,9 @@
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
@@ -426,7 +426,8 @@
 	struct tsdev *tsdev = handle->private;
 	struct tsdev_list *list;
 
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
+	class_device_destroy(input_class,
+			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
 	devfs_remove("input/ts%d", tsdev->minor);
 	devfs_remove("input/tsraw%d", tsdev->minor);
 	tsdev->exist = 0;
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	2005-03-15 08:54:28 -08:00
+++ b/include/linux/input.h	2005-03-15 08:54:28 -08:00
@@ -1010,7 +1010,7 @@
 	dev->absbit[LONG(axis)] |= BIT(axis);
 }
 
-extern struct class_simple *input_class;
+extern struct class *input_class;
 
 #endif
 #endif
