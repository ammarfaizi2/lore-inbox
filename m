Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270305AbUJUHrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270305AbUJUHrv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270401AbUJUHlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:41:14 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:50843 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270395AbUJUHaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 03:30:12 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 2/7] Input: remove class devices on disconnect
Date: Thu, 21 Oct 2004 02:25:21 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200410210223.45498.dtor_core@ameritech.net> <200410210224.33971.dtor_core@ameritech.net>
In-Reply-To: <200410210224.33971.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210225.24364.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1955, 2004-10-13 01:05:47-05:00, dtor_core@ameritech.net
  Input: evdev, joydev, mousedev, tsdev - remove class device and devfs
         entry when hardware driver disconnects instead of waiting for
         the last user to drop off. This way hardware drivers can be
         unloaded at any time.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 evdev.c    |    4 ++--
 joydev.c   |    4 ++--
 mousedev.c |    4 ++--
 tsdev.c    |   10 +++++-----
 4 files changed, 11 insertions(+), 11 deletions(-)


===================================================================



diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	2004-10-21 02:08:42 -05:00
+++ b/drivers/input/evdev.c	2004-10-21 02:08:42 -05:00
@@ -91,8 +91,6 @@
 
 static void evdev_free(struct evdev *evdev)
 {
-	devfs_remove("input/event%d", evdev->minor);
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
 	evdev_table[evdev->minor] = NULL;
 	kfree(evdev);
 }
@@ -441,6 +439,8 @@
 {
 	struct evdev *evdev = handle->private;
 
+	class_simple_device_remove(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
+	devfs_remove("input/event%d", evdev->minor);
 	evdev->exist = 0;
 
 	if (evdev->open) {
diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	2004-10-21 02:08:42 -05:00
+++ b/drivers/input/joydev.c	2004-10-21 02:08:42 -05:00
@@ -143,9 +143,7 @@
 
 static void joydev_free(struct joydev *joydev)
 {
-	devfs_remove("input/js%d", joydev->minor);
 	joydev_table[joydev->minor] = NULL;
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
 	kfree(joydev);
 }
 
@@ -466,6 +464,8 @@
 {
 	struct joydev *joydev = handle->private;
 
+	class_simple_device_remove(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
+	devfs_remove("input/js%d", joydev->minor);
 	joydev->exist = 0;
 
 	if (joydev->open)
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	2004-10-21 02:08:42 -05:00
+++ b/drivers/input/mousedev.c	2004-10-21 02:08:42 -05:00
@@ -335,8 +335,6 @@
 
 static void mousedev_free(struct mousedev *mousedev)
 {
-	devfs_remove("input/mouse%d", mousedev->minor);
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
 	mousedev_table[mousedev->minor] = NULL;
 	kfree(mousedev);
 }
@@ -646,6 +644,8 @@
 {
 	struct mousedev *mousedev = handle->private;
 
+	class_simple_device_remove(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
+	devfs_remove("input/mouse%d", mousedev->minor);
 	mousedev->exist = 0;
 
 	if (mousedev->open) {
diff -Nru a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c	2004-10-21 02:08:42 -05:00
+++ b/drivers/input/tsdev.c	2004-10-21 02:08:42 -05:00
@@ -1,7 +1,7 @@
 /*
  * $Id: tsdev.c,v 1.15 2002/04/10 16:50:19 jsimmons Exp $
  *
- *  Copyright (c) 2001 "Crazy" james Simmons 
+ *  Copyright (c) 2001 "Crazy" james Simmons
  *
  *  Compaq touchscreen protocol driver. The protocol emulated by this driver
  *  is obsolete; for new programs use the tslib library which can read directly
@@ -177,8 +177,6 @@
 
 static void tsdev_free(struct tsdev *tsdev)
 {
-	devfs_remove("input/ts%d", tsdev->minor);
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
 	tsdev_table[tsdev->minor] = NULL;
 	kfree(tsdev);
 }
@@ -418,7 +416,7 @@
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/ts%d", minor);
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor + TSDEV_MINORS/2),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/tsraw%d", minor);
-	class_simple_device_add(input_class, 
+	class_simple_device_add(input_class,
 				MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
 				dev->dev, "ts%d", minor);
 
@@ -429,6 +427,9 @@
 {
 	struct tsdev *tsdev = handle->private;
 
+	class_simple_device_remove(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
+	devfs_remove("input/ts%d", tsdev->minor);
+	devfs_remove("input/tsraw%d", tsdev->minor);
 	tsdev->exist = 0;
 
 	if (tsdev->open) {
@@ -436,7 +437,6 @@
 		wake_up_interruptible(&tsdev->wait);
 	} else
 		tsdev_free(tsdev);
-	devfs_remove("input/tsraw%d", tsdev->minor);
 }
 
 static struct input_device_id tsdev_ids[] = {
