Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWDZQxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWDZQxS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 12:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWDZQxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 12:53:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53911 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932227AbWDZQxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 12:53:18 -0400
Date: Wed, 26 Apr 2006 09:53:14 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] class_device_add needs error checks
Message-ID: <20060426095314.21fdd490@localhost.localdomain>
In-Reply-To: <20060425223958.GA30677@kroah.com>
References: <20060421134027.3198974e@localhost.localdomain>
	<20060425223958.GA30677@kroah.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2006 15:39:58 -0700
Greg KH <greg@kroah.com> wrote:

> On Fri, Apr 21, 2006 at 01:40:27PM -0700, Stephen Hemminger wrote:
> > +		if (atomic_read(&class_dev->kobj.kref.refcount))
> > +			kobject_del(&class_dev->kobj);
> 
> Yeah, we can't do this, we should not be mucking around in the kref core
> like this.
> 
> Are you having problems where class_device_add() should be failing and
> it isn't?

No, never seen it happen; just that the code is ignoring a lot of
possible out of memory conditions.

The following has better unwind..
-----------------------------------
class_device_add needs to check the return value of all the setup it
does. It doesn't handle out of memory well. This is not complete, probably
more needs to be done.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- linux-2.6.orig/drivers/base/class.c	2006-04-25 15:47:32.000000000 -0700
+++ linux-2.6/drivers/base/class.c	2006-04-26 09:50:34.000000000 -0700
@@ -535,18 +535,22 @@
 		return -EINVAL;
 
 	if (!strlen(class_dev->class_id))
-		goto register_done;
+		goto out1;
 
 	parent_class = class_get(class_dev->class);
 	if (!parent_class)
-		goto register_done;
+		goto out1;
+
 	parent_class_dev = class_device_get(class_dev->parent);
 
 	pr_debug("CLASS: registering class device: ID = '%s'\n",
 		 class_dev->class_id);
 
 	/* first, register with generic layer. */
-	kobject_set_name(&class_dev->kobj, "%s", class_dev->class_id);
+	error = kobject_set_name(&class_dev->kobj, "%s", class_dev->class_id);
+	if (error)
+		goto out2;
+
 	if (parent_class_dev)
 		class_dev->kobj.parent = &parent_class_dev->kobj;
 	else
@@ -554,41 +558,56 @@
 
 	error = kobject_add(&class_dev->kobj);
 	if (error)
-		goto register_done;
+		goto out2;
 
 	/* add the needed attributes to this device */
 	class_dev->uevent_attr.attr.name = "uevent";
 	class_dev->uevent_attr.attr.mode = S_IWUSR;
 	class_dev->uevent_attr.attr.owner = parent_class->owner;
 	class_dev->uevent_attr.store = store_uevent;
-	class_device_create_file(class_dev, &class_dev->uevent_attr);
+	error = class_device_create_file(class_dev, &class_dev->uevent_attr);
+	if (error)
+		goto out3;
 
 	if (MAJOR(class_dev->devt)) {
 		struct class_device_attribute *attr;
 		attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 		if (!attr) {
 			error = -ENOMEM;
-			kobject_del(&class_dev->kobj);
-			goto register_done;
+			goto out4;
 		}
 		attr->attr.name = "dev";
 		attr->attr.mode = S_IRUGO;
 		attr->attr.owner = parent_class->owner;
 		attr->show = show_dev;
-		class_device_create_file(class_dev, attr);
+		error = class_device_create_file(class_dev, attr);
+		if (error) {
+			kfree(attr);
+			goto out4;
+		}
+
 		class_dev->devt_attr = attr;
 	}
 
-	class_device_add_attrs(class_dev);
+	error = class_device_add_attrs(class_dev);
+	if (error)
+		goto out5;
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
+			goto out6;
+		error = sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
+					  class_name);
+		if (error)
+			goto out7;
 	}
 
-	class_device_add_groups(class_dev);
+	error = class_device_add_groups(class_dev);
+	if (error)
+		goto out8;
 
 	kobject_uevent(&class_dev->kobj, KOBJ_ADD);
 
@@ -601,11 +620,28 @@
 	}
 	up(&parent_class->sem);
 
- register_done:
-	if (error) {
-		class_put(parent_class);
+	return 0;
+
+ out8:
+	if (class_dev->dev)
+		sysfs_remove_link(&class_dev->kobj, class_name);
+ out7:
+	if (class_dev->dev)
+		sysfs_remove_link(&class_dev->kobj, "device");
+ out6:
+	class_device_remove_attrs(class_dev);
+ out5:
+	if (class_dev->devt_attr)
+		class_device_remove_file(class_dev, class_dev->devt_attr);
+ out4:
+	class_device_remove_file(class_dev, &class_dev->uevent_attr);
+ out3:
+	kobject_del(&class_dev->kobj);
+ out2:
+	if(parent_class_dev)
 		class_device_put(parent_class_dev);
-	}
+	class_put(parent_class);
+ out1:
 	class_device_put(class_dev);
 	kfree(class_name);
 	return error;
