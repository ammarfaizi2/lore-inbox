Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWFUTym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWFUTym (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWFUTyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:54:32 -0400
Received: from ns.suse.de ([195.135.220.2]:38321 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030254AbWFUTuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:50:03 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 17/22] [PATCH] Driver core: change make_class_name() to take kobjects
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:46:00 -0700
Message-Id: <1150919218895-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <1150919214366-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com> <11509191812079-git-send-email-greg@kroah.com> <115091918546-git-send-email-greg@kroah.com> <11509191893358-git-send-email-greg@kroah.com> <1150919192294-git-send-email-greg@kroah.com> <11509191951525-git-send-email-greg@kroah.com> <11509191982588-git-send-email-greg@kroah.com> <11509192022315-git-send-email-greg@kroah.com> <11509192043044-git-send-email-greg@kroah.com> <11509192081167-git-send-email-greg@kroah.com> <11509192111668-git-send-email-greg@kroah.com> <1150919214366-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is needed for a future patch for the device code to create the
proper symlinks for devices that are "class devices".

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/base.h  |    1 +
 drivers/base/class.c |   31 +++++++++++++++++--------------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 79115ef..c3b8dc9 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -42,4 +42,5 @@ struct class_device_attribute *to_class_
 	return container_of(_attr, struct class_device_attribute, attr);
 }
 
+extern char *make_class_name(const char *name, struct kobject *kobj);
 
diff --git a/drivers/base/class.c b/drivers/base/class.c
index 4b598be..41a8e09 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -504,22 +504,21 @@ void class_device_initialize(struct clas
 	INIT_LIST_HEAD(&class_dev->node);
 }
 
-static char *make_class_name(struct class_device *class_dev)
+char *make_class_name(const char *name, struct kobject *kobj)
 {
-	char *name;
+	char *class_name;
 	int size;
 
-	size = strlen(class_dev->class->name) +
-		strlen(kobject_name(&class_dev->kobj)) + 2;
+	size = strlen(name) + strlen(kobject_name(kobj)) + 2;
 
-	name = kmalloc(size, GFP_KERNEL);
-	if (!name)
+	class_name = kmalloc(size, GFP_KERNEL);
+	if (!class_name)
 		return ERR_PTR(-ENOMEM);
 
-	strcpy(name, class_dev->class->name);
-	strcat(name, ":");
-	strcat(name, kobject_name(&class_dev->kobj));
-	return name;
+	strcpy(class_name, name);
+	strcat(class_name, ":");
+	strcat(class_name, kobject_name(kobj));
+	return class_name;
 }
 
 int class_device_add(struct class_device *class_dev)
@@ -594,7 +593,8 @@ int class_device_add(struct class_device
 		goto out5;
 
 	if (class_dev->dev) {
-		class_name = make_class_name(class_dev);
+		class_name = make_class_name(class_dev->class->name,
+					     &class_dev->kobj);
 		error = sysfs_create_link(&class_dev->kobj,
 					  &class_dev->dev->kobj, "device");
 		if (error)
@@ -731,7 +731,8 @@ void class_device_del(struct class_devic
 	}
 
 	if (class_dev->dev) {
-		class_name = make_class_name(class_dev);
+		class_name = make_class_name(class_dev->class->name,
+					     &class_dev->kobj);
 		sysfs_remove_link(&class_dev->kobj, "device");
 		sysfs_remove_link(&class_dev->dev->kobj, class_name);
 	}
@@ -796,14 +797,16 @@ int class_device_rename(struct class_dev
 		 new_name);
 
 	if (class_dev->dev)
-		old_class_name = make_class_name(class_dev);
+		old_class_name = make_class_name(class_dev->class->name,
+						 &class_dev->kobj);
 
 	strlcpy(class_dev->class_id, new_name, KOBJ_NAME_LEN);
 
 	error = kobject_rename(&class_dev->kobj, new_name);
 
 	if (class_dev->dev) {
-		new_class_name = make_class_name(class_dev);
+		new_class_name = make_class_name(class_dev->class->name,
+						 &class_dev->kobj);
 		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
 				  new_class_name);
 		sysfs_remove_link(&class_dev->dev->kobj, old_class_name);
-- 
1.4.0

