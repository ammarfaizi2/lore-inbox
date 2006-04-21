Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWDUUED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWDUUED (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWDUUED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:04:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41123 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932291AbWDUUEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:04:00 -0400
Date: Fri, 21 Apr 2006 12:52:55 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] class device: add attribute_group creation
Message-ID: <20060421125255.3451959f@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the support of attribute groups in class_device's to allow groups
to be created as part of the registration process. This allows network device's
to avoid race between registration and creating groups.

Note that unlike attributes that are a property of the class object, the groups
are a property of the class_device object. This is done because there are different
types of network devices (wireless for example).

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>


--- sky2-2.6.17.orig/drivers/base/class.c	2006-04-21 12:19:26.000000000 -0700
+++ sky2-2.6.17/drivers/base/class.c	2006-04-21 12:21:21.000000000 -0700
@@ -456,6 +456,35 @@
 	}
 }
 
+static int class_device_add_groups(struct class_device * cd)
+{
+	int i;
+	int error = 0;
+
+	if (cd->groups) {
+		for (i = 0; cd->groups[i]; i++) {
+			error = sysfs_create_group(&cd->kobj, cd->groups[i]);
+			if (error) {
+				while (--i >= 0)
+					sysfs_remove_group(&cd->kobj, cd->groups[i]);
+				goto out;
+			}
+		}
+	}
+out:
+	return error;
+}
+
+static void class_device_remove_groups(struct class_device * cd)
+{
+	int i;
+	if (cd->groups) {
+		for (i = 0; cd->groups[i]; i++) {
+			sysfs_remove_group(&cd->kobj, cd->groups[i]);
+		}
+	}
+}
+
 static ssize_t show_dev(struct class_device *class_dev, char *buf)
 {
 	return print_dev_t(buf, class_dev->devt);
@@ -559,6 +588,8 @@
 				  class_name);
 	}
 
+	class_device_add_groups(class_dev);
+
 	kobject_uevent(&class_dev->kobj, KOBJ_ADD);
 
 	/* notify any interfaces this device is now here */
@@ -672,6 +703,7 @@
 	if (class_dev->devt_attr)
 		class_device_remove_file(class_dev, class_dev->devt_attr);
 	class_device_remove_attrs(class_dev);
+	class_device_remove_groups(class_dev);
 
 	kobject_uevent(&class_dev->kobj, KOBJ_REMOVE);
 	kobject_del(&class_dev->kobj);
--- sky2-2.6.17.orig/include/linux/device.h	2006-04-21 12:19:26.000000000 -0700
+++ sky2-2.6.17/include/linux/device.h	2006-04-21 12:19:36.000000000 -0700
@@ -200,6 +200,7 @@
  * @node: for internal use by the driver core only.
  * @kobj: for internal use by the driver core only.
  * @devt_attr: for internal use by the driver core only.
+ * @groups: optional additional groups to be created
  * @dev: if set, a symlink to the struct device is created in the sysfs
  * directory for this struct class device.
  * @class_data: pointer to whatever you want to store here for this struct
@@ -228,6 +229,7 @@
 	struct device		* dev;		/* not necessary, but nice to have */
 	void			* class_data;	/* class-specific data */
 	struct class_device	*parent;	/* parent of this child device, if there is one */
+	struct attribute_group  ** groups;	/* optional groups */
 
 	void	(*release)(struct class_device *dev);
 	int	(*uevent)(struct class_device *dev, char **envp,
