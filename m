Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbVCJAzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbVCJAzD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVCJArI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:47:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:55455 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262628AbVCJAmb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:31 -0500
Cc: gregkh@suse.de
Subject: [PATCH] class: add a semaphore to struct class, and use that instead of the subsystem rwsem.
In-Reply-To: <11104148863516@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:46 -0800
Message-Id: <11104148861716@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2055, 2005/03/09 15:41:29-08:00, gregkh@suse.de

[PATCH] class: add a semaphore to struct class, and use that instead of the subsystem rwsem.

This moves us away from using the rwsem, although recursive adds and removes of class devices
is not yet possible (nor is it really known if it even is needed.)  So this simple change is
done instead.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/base/class.c   |   23 +++++++++++------------
 include/linux/device.h |    2 +-
 2 files changed, 12 insertions(+), 13 deletions(-)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	2005-03-09 16:28:04 -08:00
+++ b/drivers/base/class.c	2005-03-09 16:28:04 -08:00
@@ -140,6 +140,7 @@
 
 	INIT_LIST_HEAD(&cls->children);
 	INIT_LIST_HEAD(&cls->interfaces);
+	init_MUTEX(&cls->sem);
 	error = kobject_set_name(&cls->subsys.kset.kobj, "%s", cls->name);
 	if (error)
 		return error;
@@ -413,12 +414,12 @@
 
 	/* now take care of our own registration */
 	if (parent) {
-		down_write(&parent->subsys.rwsem);
+		down(&parent->sem);
 		list_add_tail(&class_dev->node, &parent->children);
 		list_for_each_entry(class_intf, &parent->interfaces, node)
 			if (class_intf->add)
 				class_intf->add(class_dev);
-		up_write(&parent->subsys.rwsem);
+		up(&parent->sem);
 	}
 
 	if (MAJOR(class_dev->devt))
@@ -448,12 +449,12 @@
 	struct class_interface * class_intf;
 
 	if (parent) {
-		down_write(&parent->subsys.rwsem);
+		down(&parent->sem);
 		list_del_init(&class_dev->node);
 		list_for_each_entry(class_intf, &parent->interfaces, node)
 			if (class_intf->remove)
 				class_intf->remove(class_dev);
-		up_write(&parent->subsys.rwsem);
+		up(&parent->sem);
 	}
 
 	if (class_dev->dev)
@@ -509,8 +510,8 @@
 
 int class_interface_register(struct class_interface *class_intf)
 {
-	struct class * parent;
-	struct class_device * class_dev;
+	struct class *parent;
+	struct class_device *class_dev;
 
 	if (!class_intf || !class_intf->class)
 		return -ENODEV;
@@ -519,14 +520,13 @@
 	if (!parent)
 		return -EINVAL;
 
-	down_write(&parent->subsys.rwsem);
+	down(&parent->sem);
 	list_add_tail(&class_intf->node, &parent->interfaces);
-
 	if (class_intf->add) {
 		list_for_each_entry(class_dev, &parent->children, node)
 			class_intf->add(class_dev);
 	}
-	up_write(&parent->subsys.rwsem);
+	up(&parent->sem);
 
 	return 0;
 }
@@ -539,14 +539,13 @@
 	if (!parent)
 		return;
 
-	down_write(&parent->subsys.rwsem);
+	down(&parent->sem);
 	list_del_init(&class_intf->node);
-
 	if (class_intf->remove) {
 		list_for_each_entry(class_dev, &parent->children, node)
 			class_intf->remove(class_dev);
 	}
-	up_write(&parent->subsys.rwsem);
+	up(&parent->sem);
 
 	class_put(parent);
 }
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2005-03-09 16:28:04 -08:00
+++ b/include/linux/device.h	2005-03-09 16:28:04 -08:00
@@ -15,7 +15,6 @@
 #include <linux/ioport.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
-#include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/pm.h>
@@ -148,6 +147,7 @@
 	struct subsystem	subsys;
 	struct list_head	children;
 	struct list_head	interfaces;
+	struct semaphore	sem;	/* locks both the children and interfaces lists */
 
 	struct class_attribute		* class_attrs;
 	struct class_device_attribute	* class_dev_attrs;

