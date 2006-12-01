Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162345AbWLAXeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162345AbWLAXeZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162254AbWLAXW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:22:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:21485 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162246AbWLAXWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:22:45 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 9/36] CONFIG_SYSFS_DEPRECATED - class symlinks
Date: Fri,  1 Dec 2006 15:21:39 -0800
Message-Id: <11650153522862-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <1165015349830-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Sievers <kay.sievers@vrfy.org>

Turn off class symlinks CONFIG_SYSFS_DEPRECATED is enabled.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/class.c |  149 +++++++++++++++++++++++++++++++++-----------------
 1 files changed, 98 insertions(+), 51 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 2e705f6..f098881 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -352,6 +352,92 @@ static const char *class_uevent_name(str
 	return class_dev->class->name;
 }
 
+#ifdef CONFIG_SYSFS_DEPRECATED
+char *make_class_name(const char *name, struct kobject *kobj)
+{
+	char *class_name;
+	int size;
+
+	size = strlen(name) + strlen(kobject_name(kobj)) + 2;
+
+	class_name = kmalloc(size, GFP_KERNEL);
+	if (!class_name)
+		return ERR_PTR(-ENOMEM);
+
+	strcpy(class_name, name);
+	strcat(class_name, ":");
+	strcat(class_name, kobject_name(kobj));
+	return class_name;
+}
+
+static int deprecated_class_uevent(char **envp, int num_envp, int *cur_index,
+				   char *buffer, int buffer_size,
+				   int *cur_len,
+				   struct class_device *class_dev)
+{
+	struct device *dev = class_dev->dev;
+	char *path;
+
+	if (!dev)
+		return 0;
+
+	/* add device, backing this class device (deprecated) */
+	path = kobject_get_path(&dev->kobj, GFP_KERNEL);
+
+	add_uevent_var(envp, num_envp, cur_index, buffer, buffer_size,
+		       cur_len, "PHYSDEVPATH=%s", path);
+	kfree(path);
+
+	if (dev->bus)
+		add_uevent_var(envp, num_envp, cur_index,
+			       buffer, buffer_size, cur_len,
+			       "PHYSDEVBUS=%s", dev->bus->name);
+
+	if (dev->driver)
+		add_uevent_var(envp, num_envp, cur_index,
+			       buffer, buffer_size, cur_len,
+			       "PHYSDEVDRIVER=%s", dev->driver->name);
+	return 0;
+}
+
+static int make_deprecated_class_device_links(struct class_device *class_dev)
+{
+	char *class_name;
+	int error;
+
+	if (!class_dev->dev)
+		return 0;
+
+	class_name = make_class_name(class_dev->class->name, &class_dev->kobj);
+	error = sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
+				  class_name);
+	kfree(class_name);
+	return error;
+}
+
+static void remove_deprecated_class_device_links(struct class_device *class_dev)
+{
+	char *class_name;
+
+	if (!class_dev->dev)
+		return;
+
+	class_name = make_class_name(class_dev->class->name, &class_dev->kobj);
+	sysfs_remove_link(&class_dev->dev->kobj, class_name);
+	kfree(class_name);
+}
+#else
+static inline int deprecated_class_uevent(char **envp, int num_envp,
+					  int *cur_index, char *buffer,
+					  int buffer_size, int *cur_len,
+					  struct class_device *class_dev)
+{ return 0; }
+static inline int make_deprecated_class_device_links(struct class_device *cd)
+{ return 0; }
+static void remove_deprecated_class_device_links(struct class_device *cd)
+{ }
+#endif
+
 static int class_uevent(struct kset *kset, struct kobject *kobj, char **envp,
 			 int num_envp, char *buffer, int buffer_size)
 {
@@ -362,25 +448,8 @@ static int class_uevent(struct kset *kse
 
 	pr_debug("%s - name = %s\n", __FUNCTION__, class_dev->class_id);
 
-	if (class_dev->dev) {
-		/* add device, backing this class device (deprecated) */
-		struct device *dev = class_dev->dev;
-		char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
-
-		add_uevent_var(envp, num_envp, &i, buffer, buffer_size,
-			       &length, "PHYSDEVPATH=%s", path);
-		kfree(path);
-
-		if (dev->bus)
-			add_uevent_var(envp, num_envp, &i,
-				       buffer, buffer_size, &length,
-				       "PHYSDEVBUS=%s", dev->bus->name);
-
-		if (dev->driver)
-			add_uevent_var(envp, num_envp, &i,
-				       buffer, buffer_size, &length,
-				       "PHYSDEVDRIVER=%s", dev->driver->name);
-	}
+	deprecated_class_uevent(envp, num_envp, &i, buffer, buffer_size,
+				&length, class_dev);
 
 	if (MAJOR(class_dev->devt)) {
 		add_uevent_var(envp, num_envp, &i,
@@ -506,29 +575,11 @@ void class_device_initialize(struct clas
 	INIT_LIST_HEAD(&class_dev->node);
 }
 
-char *make_class_name(const char *name, struct kobject *kobj)
-{
-	char *class_name;
-	int size;
-
-	size = strlen(name) + strlen(kobject_name(kobj)) + 2;
-
-	class_name = kmalloc(size, GFP_KERNEL);
-	if (!class_name)
-		return ERR_PTR(-ENOMEM);
-
-	strcpy(class_name, name);
-	strcat(class_name, ":");
-	strcat(class_name, kobject_name(kobj));
-	return class_name;
-}
-
 int class_device_add(struct class_device *class_dev)
 {
 	struct class *parent_class = NULL;
 	struct class_device *parent_class_dev = NULL;
 	struct class_interface *class_intf;
-	char *class_name = NULL;
 	int error = -EINVAL;
 
 	class_dev = class_device_get(class_dev);
@@ -599,20 +650,18 @@ int class_device_add(struct class_device
 		goto out5;
 
 	if (class_dev->dev) {
-		class_name = make_class_name(class_dev->class->name,
-					     &class_dev->kobj);
 		error = sysfs_create_link(&class_dev->kobj,
 					  &class_dev->dev->kobj, "device");
 		if (error)
 			goto out6;
-		error = sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
-					  class_name);
-		if (error)
-			goto out7;
 	}
 
 	error = class_device_add_groups(class_dev);
 	if (error)
+		goto out7;
+
+	error = make_deprecated_class_device_links(class_dev);
+	if (error)
 		goto out8;
 
 	kobject_uevent(&class_dev->kobj, KOBJ_ADD);
@@ -629,8 +678,7 @@ int class_device_add(struct class_device
 	goto out1;
 
  out8:
-	if (class_dev->dev)
-		sysfs_remove_link(&class_dev->kobj, class_name);
+	class_device_remove_groups(class_dev);
  out7:
 	if (class_dev->dev)
 		sysfs_remove_link(&class_dev->kobj, "device");
@@ -649,7 +697,6 @@ int class_device_add(struct class_device
 	class_put(parent_class);
  out1:
 	class_device_put(class_dev);
-	kfree(class_name);
 	return error;
 }
 
@@ -726,7 +773,6 @@ void class_device_del(struct class_devic
 	struct class *parent_class = class_dev->class;
 	struct class_device *parent_device = class_dev->parent;
 	struct class_interface *class_intf;
-	char *class_name = NULL;
 
 	if (parent_class) {
 		down(&parent_class->sem);
@@ -738,10 +784,8 @@ void class_device_del(struct class_devic
 	}
 
 	if (class_dev->dev) {
-		class_name = make_class_name(class_dev->class->name,
-					     &class_dev->kobj);
+		remove_deprecated_class_device_links(class_dev);
 		sysfs_remove_link(&class_dev->kobj, "device");
-		sysfs_remove_link(&class_dev->dev->kobj, class_name);
 	}
 	sysfs_remove_link(&class_dev->kobj, "subsystem");
 	class_device_remove_file(class_dev, &class_dev->uevent_attr);
@@ -755,7 +799,6 @@ void class_device_del(struct class_devic
 
 	class_device_put(parent_device);
 	class_put(parent_class);
-	kfree(class_name);
 }
 
 void class_device_unregister(struct class_device *class_dev)
@@ -804,14 +847,17 @@ int class_device_rename(struct class_dev
 	pr_debug("CLASS: renaming '%s' to '%s'\n", class_dev->class_id,
 		 new_name);
 
+#ifdef CONFIG_SYSFS_DEPRECATED
 	if (class_dev->dev)
 		old_class_name = make_class_name(class_dev->class->name,
 						 &class_dev->kobj);
+#endif
 
 	strlcpy(class_dev->class_id, new_name, KOBJ_NAME_LEN);
 
 	error = kobject_rename(&class_dev->kobj, new_name);
 
+#ifdef CONFIG_SYSFS_DEPRECATED
 	if (class_dev->dev) {
 		new_class_name = make_class_name(class_dev->class->name,
 						 &class_dev->kobj);
@@ -819,6 +865,7 @@ int class_device_rename(struct class_dev
 				  new_class_name);
 		sysfs_remove_link(&class_dev->dev->kobj, old_class_name);
 	}
+#endif
 	class_device_put(class_dev);
 
 	kfree(old_class_name);
-- 
1.4.4.1

