Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUAHBJT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 20:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUAHBJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 20:09:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:57993 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262960AbUAHBJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 20:09:03 -0500
Date: Wed, 7 Jan 2004 17:08:59 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] sysfs input class patch - [1/1]
Message-ID: <20040108010859.GA3874@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a single patch against 2.6.1-rc2 (should apply cleanly to 2.6.0)
that adds input device class support to sysfs. 

This patch require the sysfs simple class patch that is currently in the
-mm tree.  Only USB mice end up creating a symlink to the device that
the input device is assigned to at this time.  I'll add the other
one-line changes to the input drivers at a later time.

Andrew, can you please add this patch to your -mm tree to get some
testing?

Note, Al Viro has pointed out a race condition with unloading modules
that use the simple class code to add sysfs support.  I'll work on
fixing that up properly.  Until then, these patches are good to play
with, just be careful when unloading modules that you don't have any
sysfs files open (a very rare occurrence in the wild, but very easy to
duplicate if you want to.)

Thanks a lot to Hanna Linder for early versions of this patch, on which
this is based.

thanks,

greg k-h


diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	Wed Jan  7 17:12:01 2004
+++ b/drivers/input/evdev.c	Wed Jan  7 17:12:01 2004
@@ -92,6 +92,7 @@
 static void evdev_free(struct evdev *evdev)
 {
 	devfs_remove("input/event%d", evdev->minor);
+	simple_remove_class_device(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
 	evdev_table[evdev->minor] = NULL;
 	kfree(evdev);
 }
@@ -426,6 +427,9 @@
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/event%d", minor);
+	simple_add_class_device(&input_class, 
+				MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
+				dev->dev, "event%d", minor);
 
 	return &evdev->handle;
 }
diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	Wed Jan  7 17:12:01 2004
+++ b/drivers/input/joydev.c	Wed Jan  7 17:12:01 2004
@@ -145,6 +145,7 @@
 {
 	devfs_remove("js%d", joydev->minor);
 	joydev_table[joydev->minor] = NULL;
+	simple_remove_class_device(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
 	kfree(joydev);
 }
 
@@ -444,6 +445,9 @@
 	
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "js%d", minor);
+	simple_add_class_device(&input_class, 
+				MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
+				dev->dev, "js%d", minor);
 
 	return &joydev->handle;
 }
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Wed Jan  7 17:12:01 2004
+++ b/drivers/input/mousedev.c	Wed Jan  7 17:12:01 2004
@@ -203,6 +203,7 @@
 static void mousedev_free(struct mousedev *mousedev)
 {
 	devfs_remove("input/mouse%d", mousedev->minor);
+	simple_remove_class_device(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
 	mousedev_table[mousedev->minor] = NULL;
 	kfree(mousedev);
 }
@@ -464,6 +465,9 @@
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/mouse%d", minor);
+	simple_add_class_device(&input_class, 
+				MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
+				dev->dev, "mouse%d", minor);
 
 	return &mousedev->handle;
 }
@@ -542,7 +546,8 @@
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/mice");
-
+	simple_add_class_device(&input_class, MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
+				NULL, "mice");
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 	if (!(mousedev_mix.misc = !misc_register(&psaux_mouse)))
@@ -561,6 +566,7 @@
 		misc_deregister(&psaux_mouse);
 #endif
 	devfs_remove("input/mice");
+	simple_remove_class_device(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX));
 	input_unregister_handler(&mousedev_handler);
 }
 
diff -Nru a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c	Wed Jan  7 17:12:01 2004
+++ b/drivers/input/tsdev.c	Wed Jan  7 17:12:01 2004
@@ -119,6 +119,7 @@
 static void tsdev_free(struct tsdev *tsdev)
 {
 	devfs_remove("input/ts%d", tsdev->minor);
+	simple_remove_class_device(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
 	tsdev_table[tsdev->minor] = NULL;
 	kfree(tsdev);
 }
@@ -333,6 +334,9 @@
 	
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/ts%d", minor);
+	simple_add_class_device(&input_class, 
+				MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
+				dev->dev, "ts%d", minor);
 
 	return &tsdev->handle;
 }
diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	Wed Jan  7 17:12:01 2004
+++ b/drivers/usb/input/hid-input.c	Wed Jan  7 17:12:01 2004
@@ -592,6 +592,7 @@
 				hidinput->input.id.vendor = dev->descriptor.idVendor;
 				hidinput->input.id.product = dev->descriptor.idProduct;
 				hidinput->input.id.version = dev->descriptor.bcdDevice;
+				hidinput->input.dev = &dev->dev;
 			}
 
 			for (i = 0; i < report->maxfield; i++)
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Wed Jan  7 17:12:01 2004
+++ b/include/linux/input.h	Wed Jan  7 17:12:01 2004
@@ -809,6 +809,7 @@
 	int (*erase_effect)(struct input_dev *dev, int effect_id);
 
 	struct input_handle *grab;
+	struct device *dev;
 
 	struct list_head	h_list;
 	struct list_head	node;
