Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265639AbTGDB4w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265669AbTGDBzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:55:33 -0400
Received: from granite.he.net ([216.218.226.66]:24334 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265652AbTGDByv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:51 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1057284554141@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <10572845542321@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:14 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1372, 2003/07/03 16:28:49-07:00, greg@kroah.com

[PATCH] SYSFS: add module referencing to sysfs attribute files.


 fs/sysfs/file.c        |    9 +++++++++
 include/linux/device.h |   11 ++++++-----
 include/linux/sysfs.h  |    2 ++
 3 files changed, 17 insertions(+), 5 deletions(-)


diff -Nru a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c	Thu Jul  3 18:16:03 2003
+++ b/fs/sysfs/file.c	Thu Jul  3 18:16:03 2003
@@ -247,6 +247,12 @@
 	if (!kobj || !attr)
 		goto Einval;
 
+	/* Grab the module reference for this attribute if we have one */
+	if (!try_module_get(attr->owner)) {
+		error = -ENODEV;
+		goto Done;
+	}
+
 	/* if the kobject has no ktype, then we assume that it is a subsystem
 	 * itself, and use ops for it.
 	 */
@@ -300,6 +306,7 @@
 	goto Done;
  Eaccess:
 	error = -EACCES;
+	module_put(attr->owner);
  Done:
 	if (error && kobj)
 		kobject_put(kobj);
@@ -314,10 +321,12 @@
 static int sysfs_release(struct inode * inode, struct file * filp)
 {
 	struct kobject * kobj = filp->f_dentry->d_parent->d_fsdata;
+	struct attribute * attr = filp->f_dentry->d_fsdata;
 	struct sysfs_buffer * buffer = filp->private_data;
 
 	if (kobj) 
 		kobject_put(kobj);
+	module_put(attr->owner);
 
 	if (buffer) {
 		if (buffer->page)
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Thu Jul  3 18:16:03 2003
+++ b/include/linux/device.h	Thu Jul  3 18:16:03 2003
@@ -18,6 +18,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/ioport.h>
+#include <linux/module.h>
 #include <asm/semaphore.h>
 #include <asm/atomic.h>
 
@@ -95,7 +96,7 @@
 
 #define BUS_ATTR(_name,_mode,_show,_store)	\
 struct bus_attribute bus_attr_##_name = { 		\
-	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
 	.show	= _show,				\
 	.store	= _store,				\
 };
@@ -136,7 +137,7 @@
 
 #define DRIVER_ATTR(_name,_mode,_show,_store)	\
 struct driver_attribute driver_attr_##_name = { 		\
-	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
 	.show	= _show,				\
 	.store	= _store,				\
 };
@@ -176,7 +177,7 @@
 
 #define CLASS_ATTR(_name,_mode,_show,_store)			\
 struct class_attribute class_attr_##_name = { 			\
-	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
 	.show	= _show,					\
 	.store	= _store,					\
 };
@@ -226,7 +227,7 @@
 
 #define CLASS_DEVICE_ATTR(_name,_mode,_show,_store)		\
 struct class_device_attribute class_device_attr_##_name = { 	\
-	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
 	.show	= _show,					\
 	.store	= _store,					\
 };
@@ -324,7 +325,7 @@
 
 #define DEVICE_ATTR(_name,_mode,_show,_store) \
 struct device_attribute dev_attr_##_name = { 		\
-	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
 	.show	= _show,				\
 	.store	= _store,				\
 };
diff -Nru a/include/linux/sysfs.h b/include/linux/sysfs.h
--- a/include/linux/sysfs.h	Thu Jul  3 18:16:03 2003
+++ b/include/linux/sysfs.h	Thu Jul  3 18:16:03 2003
@@ -10,9 +10,11 @@
 #define _SYSFS_H_
 
 struct kobject;
+struct module;
 
 struct attribute {
 	char			* name;
+	struct module 		* owner;
 	mode_t			mode;
 };
 

