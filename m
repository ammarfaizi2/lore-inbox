Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVIPTgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVIPTgS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 15:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVIPTgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 15:36:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57014 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751243AbVIPTgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 15:36:18 -0400
Date: Fri, 16 Sep 2005 15:33:28 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: [PATCH] fix class symlinks in sysfs
Message-ID: <20050916193328.GC17181@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, greg@kroah.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The class symlinks in sysfs don't properly handle changing device names.

To demonstrate, rename your network device from eth0 to eth1. Your
pci (or usb, or whatever) device will still have a 'net:eth0' link,
except now it points to /sys/class/net/eth1.

The attached patch makes sure the class symlink name changes when
the class device name changes. It isn't 100% correct, it should be
using sysfs_rename_link. Unfortunately, sysfs_rename_link doesn't exist.

Signed-off-by: Bill Nottingham <notting@redhat.com>

Bill

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-sysfs.patch"

diff -ru linux/drivers/base/class.c linux/drivers/base/class.c
--- linux/drivers/base/class.c	2005-09-16 15:17:11.000000000 -0400
+++ linux/drivers/base/class.c	2005-09-16 15:15:58.000000000 -0400
@@ -669,6 +669,7 @@
 int class_device_rename(struct class_device *class_dev, char *new_name)
 {
 	int error = 0;
+	char *old_class_name = NULL, *new_class_name = NULL;
 
 	class_dev = class_device_get(class_dev);
 	if (!class_dev)
@@ -677,11 +678,24 @@
 	pr_debug("CLASS: renaming '%s' to '%s'\n", class_dev->class_id,
 		 new_name);
 
+	if (class_dev->dev) {
+		old_class_name = make_class_name(class_dev);
+	}
+
 	strlcpy(class_dev->class_id, new_name, KOBJ_NAME_LEN);
 
 	error = kobject_rename(&class_dev->kobj, new_name);
 
+	if (class_dev->dev) {
+		new_class_name = make_class_name(class_dev);
+		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
+				  new_class_name);
+		sysfs_remove_link(&class_dev->dev->kobj, old_class_name);
+	}
 	class_device_put(class_dev);
+	
+	kfree(old_class_name);
+	kfree(new_class_name);
 
 	return error;
 }

--X1bOJ3K7DJ5YkBrT--
