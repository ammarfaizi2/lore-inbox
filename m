Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265705AbTFNUVo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265713AbTFNUVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:21:44 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:31977 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265705AbTFNUVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:21:31 -0400
Date: Sat, 14 Jun 2003 22:35:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Implement device grabbing [1/13]
Message-ID: <20030614223513.A25948@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is a batch of already very much overdue fixes and needed
improvements. The most significant changes are Synaptics pad support
(although that code will still develop a bit), and fixes and
quirk additions in USB HID driver.

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1215.104.18, 2003-06-09 13:45:46+02:00, warp@mercury.d2dc.net
  input: Implement input device grabbing so that it is possible to steal
  an input device from other handlers and have an exclusive access
  to events.


 drivers/input/evdev.c |   37 +++++++++++++++++++++++++++++++++++--
 drivers/input/input.c |   27 ++++++++++++++++++++++++---
 include/linux/input.h |    7 +++++++
 3 files changed, 66 insertions(+), 5 deletions(-)

===================================================================

diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	Sat Jun 14 22:21:24 2003
+++ b/drivers/input/evdev.c	Sat Jun 14 22:21:24 2003
@@ -29,6 +29,7 @@
 	char name[16];
 	struct input_handle handle;
 	wait_queue_head_t wait;
+	struct evdev_list *grab;
 	struct list_head list;
 };
 
@@ -48,7 +49,8 @@
 	struct evdev *evdev = handle->private;
 	struct evdev_list *list;
 
-	list_for_each_entry(list, &evdev->list, node) {
+	if (evdev->grab) {
+		list = evdev->grab;
 
 		do_gettimeofday(&list->buffer[list->head].time);
 		list->buffer[list->head].type = type;
@@ -57,7 +59,17 @@
 		list->head = (list->head + 1) & (EVDEV_BUFFER_SIZE - 1);
 
 		kill_fasync(&list->fasync, SIGIO, POLL_IN);
-	}
+	} else
+		list_for_each_entry(list, &evdev->list, node) {
+
+			do_gettimeofday(&list->buffer[list->head].time);
+			list->buffer[list->head].type = type;
+			list->buffer[list->head].code = code;
+			list->buffer[list->head].value = value;
+			list->head = (list->head + 1) & (EVDEV_BUFFER_SIZE - 1);
+
+			kill_fasync(&list->fasync, SIGIO, POLL_IN);
+		}
 
 	wake_up_interruptible(&evdev->wait);
 }
@@ -88,6 +100,11 @@
 {
 	struct evdev_list *list = file->private_data;
 
+	if (list->evdev->grab == list) {
+		input_release_device(&list->evdev->handle);
+		list->evdev->grab = NULL;
+	}
+
 	evdev_fasync(-1, file, 0);
 	list_del(&list->node);
 
@@ -256,6 +273,22 @@
 			if (put_user(dev->ff_effects_max, (int*) arg))
 				return -EFAULT;
 			return 0;
+
+		case EVIOCGRAB:
+			if (arg) {
+				if (evdev->grab)
+					return -EBUSY;
+				if (input_grab_device(&evdev->handle))
+					return -EBUSY;
+				evdev->grab = list;
+				return 0;
+			} else {
+				if (evdev->grab != list)
+					return -EINVAL;
+				input_release_device(&evdev->handle);
+				evdev->grab = NULL;
+				return 0;
+			}
 
 		default:
 
diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Sat Jun 14 22:21:24 2003
+++ b/drivers/input/input.c	Sat Jun 14 22:21:24 2003
@@ -33,6 +33,8 @@
 EXPORT_SYMBOL(input_unregister_device);
 EXPORT_SYMBOL(input_register_handler);
 EXPORT_SYMBOL(input_unregister_handler);
+EXPORT_SYMBOL(input_grab_device);
+EXPORT_SYMBOL(input_release_device);
 EXPORT_SYMBOL(input_open_device);
 EXPORT_SYMBOL(input_close_device);
 EXPORT_SYMBOL(input_accept_process);
@@ -175,9 +177,12 @@
 	if (type != EV_SYN) 
 		dev->sync = 0;
 
-	list_for_each_entry(handle, &dev->h_list, d_node)
-		if (handle->open)
-			handle->handler->event(handle, type, code, value);
+	if (dev->grab)
+		dev->grab->handler->event(dev->grab, type, code, value);
+	else
+		list_for_each_entry(handle, &dev->h_list, d_node)
+			if (handle->open)
+				handle->handler->event(handle, type, code, value);
 }
 
 static void input_repeat_key(unsigned long data)
@@ -201,6 +206,21 @@
 	return 0;
 }
 
+int input_grab_device(struct input_handle *handle)
+{
+	if (handle->dev->grab)
+		return -EBUSY;
+
+	handle->dev->grab = handle;
+	return 0;
+}
+
+void input_release_device(struct input_handle *handle)
+{
+	if (handle->dev->grab == handle)
+		handle->dev->grab = NULL;
+}
+
 int input_open_device(struct input_handle *handle)
 {
 	if (handle->dev->pm_dev)
@@ -221,6 +241,7 @@
 
 void input_close_device(struct input_handle *handle)
 {
+	input_release_device(handle);
 	if (handle->dev->pm_dev)
 		pm_dev_idle(handle->dev->pm_dev);
 	if (handle->dev->close)
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Sat Jun 14 22:21:24 2003
+++ b/include/linux/input.h	Sat Jun 14 22:21:24 2003
@@ -77,6 +77,8 @@
 #define EVIOCRMFF		_IOW('E', 0x81, int)			/* Erase a force effect */
 #define EVIOCGEFFECTS		_IOR('E', 0x84, int)			/* Report number of effects playable at the same time */
 
+#define EVIOCGRAB		_IOW('E', 0x90, int)			/* Grab/Release device */
+
 /*
  * Event types
  */
@@ -798,6 +800,8 @@
 	int (*upload_effect)(struct input_dev *dev, struct ff_effect *effect);
 	int (*erase_effect)(struct input_dev *dev, int effect_id);
 
+	struct input_handle *grab;
+
 	struct list_head	h_list;
 	struct list_head	node;
 };
@@ -887,6 +891,9 @@
 
 void input_register_handler(struct input_handler *);
 void input_unregister_handler(struct input_handler *);
+
+int input_grab_device(struct input_handle *);
+void input_release_device(struct input_handle *);
 
 int input_open_device(struct input_handle *);
 void input_close_device(struct input_handle *);
