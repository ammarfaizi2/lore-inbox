Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbUKQQyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbUKQQyt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUKQQxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:53:12 -0500
Received: from peabody.ximian.com ([130.57.169.10]:11934 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262419AbUKQQvt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:51:49 -0500
Subject: [patch] add class_device to miscdevice
From: Robert Love <rml@novell.com>
To: greg@kroah.com
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 17 Nov 2004 11:48:59 -0500
Message-Id: <1100710140.5009.6.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, et al.

Currently misc_register() throws away the return from
class_simple_device_add().  This makes it impossible to get to the
class_device of the directories in /sys/class/misc and, for example,
thus impossible to add attributes to those directories.

Attached patch adds a class_device structure to the miscdevice structure
and assigns to it the value returned from class_simple_device_add() in
misc_register(), thus caching the value and allowing us to f.e. later
call class_device_create_file().

We need this for inotify, but I can see plenty of other misc. devices
wanting this and consider it missing but required functionality.

Thanks,

	Robert Love


Add the class_device structure to miscdevice so that we can add sysfs
attributes to /sys/class/misc/foo

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/misc.c        |   14 ++++++--------
 include/linux/miscdevice.h |    5 +++--
 2 files changed, 9 insertions(+), 10 deletions(-)

diff -urN linux-2.6.10-rc2/drivers/char/misc.c linux/drivers/char/misc.c
--- linux-2.6.10-rc2/drivers/char/misc.c	2004-10-18 17:55:21.000000000 -0400
+++ linux/drivers/char/misc.c	2004-11-16 14:11:17.164542312 -0500
@@ -207,10 +207,9 @@
 int misc_register(struct miscdevice * misc)
 {
 	struct miscdevice *c;
-	struct class_device *class;
 	dev_t dev;
 	int err;
-	
+
 	down(&misc_sem);
 	list_for_each_entry(c, &misc_list, list) {
 		if (c->minor == misc->minor) {
@@ -224,8 +223,7 @@
 		while (--i >= 0)
 			if ( (misc_minors[i>>3] & (1 << (i&7))) == 0)
 				break;
-		if (i<0)
-		{
+		if (i<0) {
 			up(&misc_sem);
 			return -EBUSY;
 		}
@@ -240,10 +238,10 @@
 	}
 	dev = MKDEV(MISC_MAJOR, misc->minor);
 
-	class = class_simple_device_add(misc_class, dev,
-					misc->dev, misc->name);
-	if (IS_ERR(class)) {
-		err = PTR_ERR(class);
+	misc->class = class_simple_device_add(misc_class, dev,
+					      misc->dev, misc->name);
+	if (IS_ERR(misc->class)) {
+		err = PTR_ERR(misc->class);
 		goto out;
 	}
 
diff -urN linux-2.6.10-rc2/include/linux/miscdevice.h linux/include/linux/miscdevice.h
--- linux-2.6.10-rc2/include/linux/miscdevice.h	2004-10-18 17:54:32.000000000 -0400
+++ linux/include/linux/miscdevice.h	2004-11-16 14:09:04.345733840 -0500
@@ -2,6 +2,7 @@
 #define _LINUX_MISCDEVICE_H
 #include <linux/module.h>
 #include <linux/major.h>
+#include <linux/device.h>
 
 #define PSMOUSE_MINOR  1
 #define MS_BUSMOUSE_MINOR 2
@@ -32,13 +33,13 @@
 
 struct device;
 
-struct miscdevice 
-{
+struct miscdevice  {
 	int minor;
 	const char *name;
 	struct file_operations *fops;
 	struct list_head list;
 	struct device *dev;
+	struct class_device *class;
 	char devfs_name[64];
 };
 


