Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbVIVHsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbVIVHsQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbVIVHsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:48:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:35250 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751431AbVIVHsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:48:15 -0400
Date: Thu, 22 Sep 2005 00:47:36 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       notting@redhat.com
Subject: [patch 03/18] fix class symlinks in sysfs
Message-ID: <20050922074736.GD15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="driver-fix-class-symlinks.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bill Nottingham <notting@redhat.com>

The class symlinks in sysfs don't properly handle changing device names.

To demonstrate, rename your network device from eth0 to eth1. Your
pci (or usb, or whatever) device will still have a 'net:eth0' link,
except now it points to /sys/class/net/eth1.

The attached patch makes sure the class symlink name changes when
the class device name changes. It isn't 100% correct, it should be
using sysfs_rename_link. Unfortunately, sysfs_rename_link doesn't exist.

Signed-off-by: Bill Nottingham <notting@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/class.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- scsi-2.6.orig/drivers/base/class.c	2005-09-20 05:59:41.000000000 -0700
+++ scsi-2.6/drivers/base/class.c	2005-09-21 17:29:22.000000000 -0700
@@ -669,6 +669,7 @@
 int class_device_rename(struct class_device *class_dev, char *new_name)
 {
 	int error = 0;
+	char *old_class_name = NULL, *new_class_name = NULL;
 
 	class_dev = class_device_get(class_dev);
 	if (!class_dev)
@@ -677,12 +678,24 @@
 	pr_debug("CLASS: renaming '%s' to '%s'\n", class_dev->class_id,
 		 new_name);
 
+	if (class_dev->dev)
+		old_class_name = make_class_name(class_dev);
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
 
+	kfree(old_class_name);
+	kfree(new_class_name);
+
 	return error;
 }
 

--
