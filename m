Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbVALG6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVALG6e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 01:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbVALG6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 01:58:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:9653 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262871AbVALG6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 01:58:20 -0500
Date: Tue, 11 Jan 2005 22:58:17 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
Subject: [RFC] stop using the class device rwsem
Message-ID: <20050112065817.GA2085@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, the first step in refactoring the locking in the driver core.
Classes, the easy one.  This patch adds a semaphore to struct class that
is used to protect adding and removing things from the interface and
children lists.  We now only hold the semaphore for a very short time
(hm, I wonder if I should just make it a spinlock then...)

This is against 2.6.10-bk14, and works here for me with a whole lot of
class add and remove events happening on a smp box.

Any complaints about making this change, or anyone see anything stupid
that I missed?

thanks,

greg k-h

---------
Driver Core: move the class core to use it's own semaphore and not the subsystem one.

This is a step on the way to stop using the subsystem rwsem, and it should allow us
to add or remove class devices and interfaces from within add() or remove() class interface
callbacks.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	2005-01-11 22:54:26 -08:00
+++ b/drivers/base/class.c	2005-01-11 22:54:26 -08:00
@@ -139,6 +139,7 @@
 
 	INIT_LIST_HEAD(&cls->children);
 	INIT_LIST_HEAD(&cls->interfaces);
+	init_MUTEX(&cls->sem);
 	error = kobject_set_name(&cls->subsys.kset.kobj, "%s", cls->name);
 	if (error)
 		return error;
@@ -425,12 +426,14 @@
 
 	/* now take care of our own registration */
 	if (parent) {
-		down_write(&parent->subsys.rwsem);
+		struct class_interface *temp;
+
+		down(&parent->sem);
 		list_add_tail(&class_dev->node, &parent->children);
-		list_for_each_entry(class_intf, &parent->interfaces, node)
+		up(&parent->sem);
+		list_for_each_entry_safe(class_intf, temp, &parent->interfaces, node)
 			if (class_intf->add)
 				class_intf->add(class_dev);
-		up_write(&parent->subsys.rwsem);
 	}
 	class_device_add_attrs(class_dev);
 	class_device_dev_link(class_dev);
@@ -455,12 +458,14 @@
 	struct class_interface * class_intf;
 
 	if (parent) {
-		down_write(&parent->subsys.rwsem);
+		struct class_interface *temp;
+
+		down(&parent->sem);
 		list_del_init(&class_dev->node);
-		list_for_each_entry(class_intf, &parent->interfaces, node)
+		up(&parent->sem);
+		list_for_each_entry_safe(class_intf, temp, &parent->interfaces, node)
 			if (class_intf->remove)
 				class_intf->remove(class_dev);
-		up_write(&parent->subsys.rwsem);
 	}
 
 	class_device_dev_unlink(class_dev);
@@ -516,8 +521,9 @@
 
 int class_interface_register(struct class_interface *class_intf)
 {
-	struct class * parent;
-	struct class_device * class_dev;
+	struct class *parent;
+	struct class_device *class_dev;
+	struct class_device *temp;
 
 	if (!class_intf || !class_intf->class)
 		return -ENODEV;
@@ -526,14 +532,14 @@
 	if (!parent)
 		return -EINVAL;
 
-	down_write(&parent->subsys.rwsem);
+	down(&parent->sem);
 	list_add_tail(&class_intf->node, &parent->interfaces);
+	up(&parent->sem);
 
 	if (class_intf->add) {
-		list_for_each_entry(class_dev, &parent->children, node)
+		list_for_each_entry_safe(class_dev, temp, &parent->children, node)
 			class_intf->add(class_dev);
 	}
-	up_write(&parent->subsys.rwsem);
 
 	return 0;
 }
@@ -542,18 +548,19 @@
 {
 	struct class * parent = class_intf->class;
 	struct class_device *class_dev;
+	struct class_device *temp;
 
 	if (!parent)
 		return;
 
-	down_write(&parent->subsys.rwsem);
+	down(&parent->sem);
 	list_del_init(&class_intf->node);
+	up(&parent->sem);
 
 	if (class_intf->remove) {
-		list_for_each_entry(class_dev, &parent->children, node)
+		list_for_each_entry_safe(class_dev, temp, &parent->children, node)
 			class_intf->remove(class_dev);
 	}
-	up_write(&parent->subsys.rwsem);
 
 	class_put(parent);
 }
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2005-01-11 22:54:26 -08:00
+++ b/include/linux/device.h	2005-01-11 22:54:26 -08:00
@@ -148,6 +148,7 @@
 	struct subsystem	subsys;
 	struct list_head	children;
 	struct list_head	interfaces;
+	struct semaphore	sem;	/* locks both the children and interfaces lists */
 
 	struct class_attribute		* class_attrs;
 	struct class_device_attribute	* class_dev_attrs;
