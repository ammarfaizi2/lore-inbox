Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWDUUkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWDUUkb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWDUUkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:40:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5292 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750795AbWDUUka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:40:30 -0400
Date: Fri, 21 Apr 2006 13:40:27 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] class_device_add needs error checks
Message-ID: <20060421134027.3198974e@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

class_device_add needs to check the return value of all the setup functions
it calls. It doesn't handle out of memory well. 

This is not complete, probably more needs to be done, and the unwind
may not work right.

--- linux-2.6.orig/drivers/base/class.c	2006-04-21 12:21:21.000000000 -0700
+++ linux-2.6/drivers/base/class.c	2006-04-21 12:41:48.000000000 -0700
@@ -546,7 +546,10 @@
 		 class_dev->class_id);
 
 	/* first, register with generic layer. */
-	kobject_set_name(&class_dev->kobj, "%s", class_dev->class_id);
+	error = kobject_set_name(&class_dev->kobj, "%s", class_dev->class_id);
+	if (error)
+		goto register_done;
+
 	if (parent_class_dev)
 		class_dev->kobj.parent = &parent_class_dev->kobj;
 	else
@@ -561,34 +564,49 @@
 	class_dev->uevent_attr.attr.mode = S_IWUSR;
 	class_dev->uevent_attr.attr.owner = parent_class->owner;
 	class_dev->uevent_attr.store = store_uevent;
-	class_device_create_file(class_dev, &class_dev->uevent_attr);
+	error = class_device_create_file(class_dev, &class_dev->uevent_attr);
+	if (error)
+		goto register_done;
 
 	if (MAJOR(class_dev->devt)) {
 		struct class_device_attribute *attr;
 		attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 		if (!attr) {
 			error = -ENOMEM;
-			kobject_del(&class_dev->kobj);
 			goto register_done;
 		}
 		attr->attr.name = "dev";
 		attr->attr.mode = S_IRUGO;
 		attr->attr.owner = parent_class->owner;
 		attr->show = show_dev;
-		class_device_create_file(class_dev, attr);
+		error = class_device_create_file(class_dev, attr);
+		if (error) {
+			kfree(attr);
+			goto register_done;
+		}
+
 		class_dev->devt_attr = attr;
 	}
 
-	class_device_add_attrs(class_dev);
+	error = class_device_add_attrs(class_dev);
+	if (error)
+		goto register_done;
+
 	if (class_dev->dev) {
 		class_name = make_class_name(class_dev);
-		sysfs_create_link(&class_dev->kobj,
-				  &class_dev->dev->kobj, "device");
-		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
-				  class_name);
+		error = sysfs_create_link(&class_dev->kobj,
+					  &class_dev->dev->kobj, "device");
+		if (error)
+			goto register_done;
+		error = sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
+					  class_name);
+		if (error)
+			goto register_done;
 	}
 
-	class_device_add_groups(class_dev);
+	error = class_device_add_groups(class_dev);
+	if (error)
+		goto register_done;
 
 	kobject_uevent(&class_dev->kobj, KOBJ_ADD);
 
@@ -603,6 +621,15 @@
 
  register_done:
 	if (error) {
+		sysfs_remove_link(&class_dev->kobj, "device");
+		sysfs_remove_link(&class_dev->dev->kobj, class_name);
+		class_device_remove_attrs(class_dev);
+		class_device_remove_file(class_dev, &class_dev->uevent_attr);
+		if (class_dev->devt_attr)
+			class_device_remove_file(class_dev, class_dev->devt_attr);
+
+		if (atomic_read(&class_dev->kobj.kref.refcount))
+			kobject_del(&class_dev->kobj);
 		class_put(parent_class);
 		class_device_put(parent_class_dev);
 	}
