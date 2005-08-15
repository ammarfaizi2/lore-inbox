Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbVHOR2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVHOR2Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVHOR2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:28:24 -0400
Received: from loihi.boulder.swri.edu ([65.241.78.2]:21195 "EHLO
	perseus.boulder.swri.edu") by vger.kernel.org with ESMTP
	id S964846AbVHOR2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:28:23 -0400
Message-ID: <4300D09C.4030702@skyrush.com>
Date: Mon, 15 Aug 2005 11:27:56 -0600
From: Joe Peterson <joe@skyrush.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-input@atrey.karlin.mff.cuni.cz
CC: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] to drivers/input/evdev.c to add mixer device "/dev/input/events"
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030602040109010402010106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030602040109010402010106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I, and a growing number of others, have been having trouble with using
touch screen devices in Linux, particularly the motorized ones that fit
into car dashboards.  The problem is that these devices, which have a
USB touchscreen (often the eGalax brand), turn off when the screen is
retracted, causing Linux to remove and/or disconnect the event device
in /dev/input.

Using udev to assign a persistent symlink to the device was the first
thing I tried, but it does not solve the problem, since X windows does
not see the device when it turns back on, even if it's the same name.  I
(and others) have tried hacks like changing virtual terminals, etc. to
get it back, but these are not elegant solutions are are problematic.

Anyway, I finally decided the thing I needed was something like
/dev/input/mice, since it is always there for X to see, even if the
device is off during boot.  But the mousedev devices are not the
right data format for use with the touch screens (you need "event"
ones).  So I hacked evdev.c and added "/dev/input/events", which is a
mixer as well and catches all events from event0, event1, etc.

This works great, and I think it would be a great addition to the Linux
kernel.  I would like to submit this patch, and I hope it can be made a
part of the Linux kernel.  However, I would feel more comfortable if
someone (the maintainer?) could look over my changes and verify that
they are done correctly.  I had a few open questions that resulted from
the fact that evdev is slightly different than mousedev:

For example, in evdev_open, I had to check evdev->handle.dev for
non-zero before making the input call (evdev_mix has a zero in this
pointer), or of course I would get a seg fault.  I also got a lockup
later that I fixed by making other similar checks for a zero
handle.dev, but since these checks were not necessary in mousedev, I
would like to verify that this is the correct way to deal with it.

Another thing is the "grab" concept in evdev.  I check for handle.dev to
be non-zero before I let grab get set, and I do not know every aspect of
the grab mechanism, so I hope this is the right thing to do.

Anyway, I hope my change is valuable.  I (and others) would love to see
it appear in the official kernel source.  I attached the patch.

	Thanks, Joe


--------------030602040109010402010106
Content-Type: text/x-patch;
 name="evdev.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="evdev.c.patch"

--- linux-2.6.12/drivers/input/evdev.c.orig	2005-08-15 11:12:15.000000000 -0600
+++ linux-2.6.12/drivers/input/evdev.c	2005-08-15 11:12:11.000000000 -0600
@@ -8,8 +8,17 @@
  * the Free Software Foundation.
  */
 
+/*
+ * Modified 2005-8-12  Joe Peterson
+ *
+ *     - Added persistent mixer device "/dev/input/events"
+ *       (analogous to mousedev.c's "/dev/input/mice")
+ *
+ */
+
 #define EVDEV_MINOR_BASE	64
 #define EVDEV_MINORS		32
+#define EVDEV_MIX               31
 #define EVDEV_BUFFER_SIZE	64
 
 #include <linux/poll.h>
@@ -42,11 +51,13 @@ struct evdev_list {
 	struct list_head node;
 };
 
+static struct input_handler evdev_handler;
+
 static struct evdev *evdev_table[EVDEV_MINORS];
+static struct evdev evdev_mix;
 
-static void evdev_event(struct input_handle *handle, unsigned int type, unsigned int code, int value)
+static void evdev_handle_event(struct evdev *evdev, unsigned int type, unsigned int code, int value)
 {
-	struct evdev *evdev = handle->private;
 	struct evdev_list *list;
 
 	if (evdev->grab) {
@@ -74,6 +85,14 @@ static void evdev_event(struct input_han
 	wake_up_interruptible(&evdev->wait);
 }
 
+static void evdev_event(struct input_handle *handle, unsigned int type, unsigned int code, int value)
+{
+	struct evdev *evdev = handle->private;
+
+        evdev_handle_event(evdev, type, code, value);
+        evdev_handle_event(&evdev_mix, type, code, value);
+}
+
 static int evdev_fasync(int fd, struct file *file, int on)
 {
 	int retval;
@@ -86,7 +105,10 @@ static int evdev_flush(struct file * fil
 {
 	struct evdev_list *list = file->private_data;
 	if (!list->evdev->exist) return -ENODEV;
-	return input_flush_device(&list->evdev->handle, file);
+        if (list->evdev->handle.dev)
+            return input_flush_device(&list->evdev->handle, file);
+        else
+            return 0;
 }
 
 static void evdev_free(struct evdev *evdev)
@@ -95,6 +117,24 @@ static void evdev_free(struct evdev *evd
 	kfree(evdev);
 }
 
+static int mixdev_release(void)
+{
+	struct input_handle *handle;
+
+	list_for_each_entry(handle, &evdev_handler.h_list, h_node) {
+		struct evdev *evdev = handle->private;
+
+		if (!evdev->open) {
+			if (evdev->exist)
+				input_close_device(&evdev->handle);
+			else
+				evdev_free(evdev);
+		}
+	}
+
+	return 0;
+}
+
 static int evdev_release(struct inode * inode, struct file * file)
 {
 	struct evdev_list *list = file->private_data;
@@ -108,10 +148,15 @@ static int evdev_release(struct inode * 
 	list_del(&list->node);
 
 	if (!--list->evdev->open) {
-		if (list->evdev->exist)
-			input_close_device(&list->evdev->handle);
-		else
-			evdev_free(list->evdev);
+		if (list->evdev->minor == EVDEV_MIX)
+			return mixdev_release();
+
+		if (!evdev_mix.open) {
+			if (list->evdev->exist)
+				input_close_device(&list->evdev->handle);
+			else
+				evdev_free(list->evdev);
+		}
 	}
 
 	kfree(list);
@@ -121,13 +166,16 @@ static int evdev_release(struct inode * 
 static int evdev_open(struct inode * inode, struct file * file)
 {
 	struct evdev_list *list;
+	struct input_handle *handle;
+	struct evdev *evdev;
 	int i = iminor(inode) - EVDEV_MINOR_BASE;
 	int accept_err;
 
 	if (i >= EVDEV_MINORS || !evdev_table[i] || !evdev_table[i]->exist)
 		return -ENODEV;
 
-	if ((accept_err = input_accept_process(&(evdev_table[i]->handle), file)))
+        if (evdev_table[i]->handle.dev)
+            if ((accept_err = input_accept_process(&(evdev_table[i]->handle), file)))
 		return accept_err;
 
 	if (!(list = kmalloc(sizeof(struct evdev_list), GFP_KERNEL)))
@@ -138,10 +186,18 @@ static int evdev_open(struct inode * ino
 	list_add_tail(&list->node, &evdev_table[i]->list);
 	file->private_data = list;
 
-	if (!list->evdev->open++)
-		if (list->evdev->exist)
-			input_open_device(&list->evdev->handle);
-
+	if (!list->evdev->open++) {
+		if (list->evdev->minor == EVDEV_MIX) {
+			list_for_each_entry(handle, &evdev_handler.h_list, h_node) {
+				evdev = handle->private;
+				if (!evdev->open && evdev->exist)
+					input_open_device(handle);
+			}
+		} else
+			if (!evdev_mix.open && list->evdev->exist)
+				input_open_device(&list->evdev->handle);
+        }
+        
 	return 0;
 }
 
@@ -157,7 +213,8 @@ static ssize_t evdev_write(struct file *
 
 		if (copy_from_user(&event, buffer + retval, sizeof(struct input_event)))
 			return -EFAULT;
-		input_event(list->evdev->handle.dev, event.type, event.code, event.value);
+                if (list->evdev->handle.dev)
+                    input_event(list->evdev->handle.dev, event.type, event.code, event.value);
 		retval += sizeof(struct input_event);
 	}
 
@@ -268,20 +325,24 @@ static int evdev_ioctl(struct inode *ino
 			return 0;
 
 		case EVIOCGRAB:
-			if (arg) {
+                        if (evdev->handle.dev) {
+                            if (arg) {
 				if (evdev->grab)
 					return -EBUSY;
 				if (input_grab_device(&evdev->handle))
 					return -EBUSY;
 				evdev->grab = list;
 				return 0;
-			} else {
+			    } else {
 				if (evdev->grab != list)
 					return -EINVAL;
 				input_release_device(&evdev->handle);
 				evdev->grab = NULL;
 				return 0;
-			}
+			    }
+                        } else {
+                            return 0;
+                        }
 
 		default:
 
@@ -427,6 +488,9 @@ static struct input_handle *evdev_connec
 	evdev->handle.private = evdev;
 	sprintf(evdev->name, "event%d", minor);
 
+	if (evdev_mix.open)
+		input_open_device(&evdev->handle);
+
 	evdev_table[minor] = evdev;
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
@@ -452,8 +516,11 @@ static void evdev_disconnect(struct inpu
 		wake_up_interruptible(&evdev->wait);
 		list_for_each_entry(list, &evdev->list, node)
 			kill_fasync(&list->fasync, SIGIO, POLL_HUP);
-	} else
+	} else {
+		if (evdev_mix.open)
+			input_close_device(handle);
 		evdev_free(evdev);
+        }
 }
 
 static struct input_device_id evdev_ids[] = {
@@ -476,11 +543,28 @@ static struct input_handler evdev_handle
 static int __init evdev_init(void)
 {
 	input_register_handler(&evdev_handler);
+
+	memset(&evdev_mix, 0, sizeof(struct evdev));
+	INIT_LIST_HEAD(&evdev_mix.list);
+	init_waitqueue_head(&evdev_mix.wait);
+	evdev_table[EVDEV_MIX] = &evdev_mix;
+	evdev_mix.exist = 1;
+	evdev_mix.minor = EVDEV_MIX;
+
+	devfs_mk_cdev(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + EVDEV_MIX),
+			S_IFCHR|S_IRUGO|S_IWUSR, "input/events");
+	class_simple_device_add(input_class, MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + EVDEV_MIX),
+				NULL, "events");
+
+	printk(KERN_INFO "events: event device common for all events\n");
+
 	return 0;
 }
 
 static void __exit evdev_exit(void)
 {
+	devfs_remove("input/events");
+	class_simple_device_remove(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + EVDEV_MIX));
 	input_unregister_handler(&evdev_handler);
 }
 

--------------030602040109010402010106--
