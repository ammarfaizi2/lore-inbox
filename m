Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVAHGBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVAHGBm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVAHGAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:00:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:18309 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261801AbVAHFrz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:47:55 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163258176@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:38 -0800
Message-Id: <11051632582690@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.1, 2004/12/15 10:48:19-08:00, rml@novell.com

[PATCH] add class_device to miscdevice

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


Add the class_device structure to miscdevice so that we can add sysfs
attributes to /sys/class/misc/foo

Signed-Off-By: Robert Love <rml@novell.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/char/misc.c        |   14 ++++++--------
 include/linux/miscdevice.h |    5 +++--
 2 files changed, 9 insertions(+), 10 deletions(-)


diff -Nru a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c	2005-01-07 15:52:07 -08:00
+++ b/drivers/char/misc.c	2005-01-07 15:52:07 -08:00
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
 
diff -Nru a/include/linux/miscdevice.h b/include/linux/miscdevice.h
--- a/include/linux/miscdevice.h	2005-01-07 15:52:07 -08:00
+++ b/include/linux/miscdevice.h	2005-01-07 15:52:07 -08:00
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
 

