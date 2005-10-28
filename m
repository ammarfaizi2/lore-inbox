Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbVJ1GhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbVJ1GhW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbVJ1Gbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:49642 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965153AbVJ1Gb1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:27 -0400
Cc: gregkh@suse.de
Subject: [PATCH] INPUT: Create symlinks for backwards compatibility
In-Reply-To: <1130481027412@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:27 -0700
Message-Id: <11304810273085@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] INPUT: Create symlinks for backwards compatibility

This creates symlinks in /sys/class/input/ to the nested class devices
to help userspace cope with the nesting.

Unfortunatly udev still needs to be updated as it can't handle symlinks
properly here :(

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d608407b3691e3a1c20b382c81e0d00d3bf1e303
tree 95f8d5989d6af01aa635eefffb2bdf7eb0f536c3
parent fdbb989037a62b1748fdf3e292601a9373fa0739
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:25:43 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:07 -0700

 drivers/input/evdev.c    |   10 ++++++++--
 drivers/input/joydev.c   |   10 ++++++++--
 drivers/input/mousedev.c |   10 ++++++++--
 drivers/input/tsdev.c    |   10 ++++++++--
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 2a96b26..a4696cd 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -661,6 +661,7 @@ static struct file_operations evdev_fops
 static struct input_handle *evdev_connect(struct input_handler *handler, struct input_dev *dev, struct input_device_id *id)
 {
 	struct evdev *evdev;
+	struct class_device *cdev;
 	int minor;
 
 	for (minor = 0; minor < EVDEV_MINORS && evdev_table[minor]; minor++);
@@ -686,9 +687,13 @@ static struct input_handle *evdev_connec
 
 	evdev_table[minor] = evdev;
 
-	class_device_create(&input_class, &dev->cdev,
+	cdev = class_device_create(&input_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
-			dev->cdev.dev, "event%d", minor);
+			dev->cdev.dev, evdev->name);
+
+	/* temporary symlink to keep userspace happy */
+	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
+			  evdev->name);
 
 	return &evdev->handle;
 }
@@ -698,6 +703,7 @@ static void evdev_disconnect(struct inpu
 	struct evdev *evdev = handle->private;
 	struct evdev_list *list;
 
+	sysfs_remove_link(&input_class.subsys.kset.kobj, evdev->name);
 	class_device_destroy(&input_class,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
 	evdev->exist = 0;
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 25f7eba..20e2972 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -448,6 +448,7 @@ static struct file_operations joydev_fop
 static struct input_handle *joydev_connect(struct input_handler *handler, struct input_dev *dev, struct input_device_id *id)
 {
 	struct joydev *joydev;
+	struct class_device *cdev;
 	int i, j, t, minor;
 
 	for (minor = 0; minor < JOYDEV_MINORS && joydev_table[minor]; minor++);
@@ -513,9 +514,13 @@ static struct input_handle *joydev_conne
 
 	joydev_table[minor] = joydev;
 
-	class_device_create(&input_class, &dev->cdev,
+	cdev = class_device_create(&input_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
-			dev->cdev.dev, "js%d", minor);
+			dev->cdev.dev, joydev->name);
+
+	/* temporary symlink to keep userspace happy */
+	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
+			  joydev->name);
 
 	return &joydev->handle;
 }
@@ -525,6 +530,7 @@ static void joydev_disconnect(struct inp
 	struct joydev *joydev = handle->private;
 	struct joydev_list *list;
 
+	sysfs_remove_link(&input_class.subsys.kset.kobj, joydev->name);
 	class_device_destroy(&input_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
 	joydev->exist = 0;
 
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index de2808f..2d0af44 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -620,6 +620,7 @@ static struct file_operations mousedev_f
 static struct input_handle *mousedev_connect(struct input_handler *handler, struct input_dev *dev, struct input_device_id *id)
 {
 	struct mousedev *mousedev;
+	struct class_device *cdev;
 	int minor = 0;
 
 	for (minor = 0; minor < MOUSEDEV_MINORS && mousedev_table[minor]; minor++);
@@ -648,9 +649,13 @@ static struct input_handle *mousedev_con
 
 	mousedev_table[minor] = mousedev;
 
-	class_device_create(&input_class, &dev->cdev,
+	cdev = class_device_create(&input_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
-			dev->cdev.dev, "mouse%d", minor);
+			dev->cdev.dev, mousedev->name);
+
+	/* temporary symlink to keep userspace happy */
+	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
+			  mousedev->name);
 
 	return &mousedev->handle;
 }
@@ -660,6 +665,7 @@ static void mousedev_disconnect(struct i
 	struct mousedev *mousedev = handle->private;
 	struct mousedev_list *list;
 
+	sysfs_remove_link(&input_class.subsys.kset.kobj, mousedev->name);
 	class_device_destroy(&input_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
 	mousedev->exist = 0;
diff --git a/drivers/input/tsdev.c b/drivers/input/tsdev.c
index 75e1657..ca15479 100644
--- a/drivers/input/tsdev.c
+++ b/drivers/input/tsdev.c
@@ -368,6 +368,7 @@ static struct input_handle *tsdev_connec
 					  struct input_device_id *id)
 {
 	struct tsdev *tsdev;
+	struct class_device *cdev;
 	int minor, delta;
 
 	for (minor = 0; minor < TSDEV_MINORS/2 && tsdev_table[minor];
@@ -409,9 +410,13 @@ static struct input_handle *tsdev_connec
 
 	tsdev_table[minor] = tsdev;
 
-	class_device_create(&input_class, &dev->cdev,
+	cdev = class_device_create(&input_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
-			dev->cdev.dev, "ts%d", minor);
+			dev->cdev.dev, tsdev->name);
+
+	/* temporary symlink to keep userspace happy */
+	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
+			  tsdev->name);
 
 	return &tsdev->handle;
 }
@@ -421,6 +426,7 @@ static void tsdev_disconnect(struct inpu
 	struct tsdev *tsdev = handle->private;
 	struct tsdev_list *list;
 
+	sysfs_remove_link(&input_class.subsys.kset.kobj, tsdev->name);
 	class_device_destroy(&input_class,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
 	tsdev->exist = 0;

