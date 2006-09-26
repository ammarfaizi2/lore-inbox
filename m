Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWIZFsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWIZFsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWIZFsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:48:22 -0400
Received: from mail.suse.de ([195.135.220.2]:60129 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751111AbWIZFj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:26 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 26/47] Driver core: add groups support to struct device
Date: Mon, 25 Sep 2006 22:37:46 -0700
Message-Id: <11592491672052-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491643725-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is needed for the network class devices in order to be able to
convert over to use struct device.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c    |   34 ++++++++++++++++++++++++++++++++++
 include/linux/device.h |    1 +
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5d4b7e0..641c0c4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -197,6 +197,35 @@ static ssize_t store_uevent(struct devic
 	return count;
 }
 
+static int device_add_groups(struct device *dev)
+{
+	int i;
+	int error = 0;
+
+	if (dev->groups) {
+		for (i = 0; dev->groups[i]; i++) {
+			error = sysfs_create_group(&dev->kobj, dev->groups[i]);
+			if (error) {
+				while (--i >= 0)
+					sysfs_remove_group(&dev->kobj, dev->groups[i]);
+				goto out;
+			}
+		}
+	}
+out:
+	return error;
+}
+
+static void device_remove_groups(struct device *dev)
+{
+	int i;
+	if (dev->groups) {
+		for (i = 0; dev->groups[i]; i++) {
+			sysfs_remove_group(&dev->kobj, dev->groups[i]);
+		}
+	}
+}
+
 static ssize_t show_dev(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
@@ -350,6 +379,8 @@ int device_add(struct device *dev)
 		sysfs_create_link(&dev->parent->kobj, &dev->kobj, class_name);
 	}
 
+	if ((error = device_add_groups(dev)))
+		goto GroupError;
 	if ((error = device_pm_add(dev)))
 		goto PMError;
 	if ((error = bus_add_device(dev)))
@@ -376,6 +407,8 @@ int device_add(struct device *dev)
  BusError:
 	device_pm_remove(dev);
  PMError:
+	device_remove_groups(dev);
+ GroupError:
 	if (dev->devt_attr) {
 		device_remove_file(dev, dev->devt_attr);
 		kfree(dev->devt_attr);
@@ -470,6 +503,7 @@ void device_del(struct device * dev)
 		up(&dev->class->sem);
 	}
 	device_remove_file(dev, &dev->uevent_attr);
+	device_remove_groups(dev);
 
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
diff --git a/include/linux/device.h b/include/linux/device.h
index b364646..994d3eb 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -344,6 +344,7 @@ struct device {
 	struct list_head	node;
 	struct class		*class;		/* optional*/
 	dev_t			devt;		/* dev_t, creates the sysfs "dev" */
+	struct attribute_group	**groups;	/* optional groups */
 
 	void	(*release)(struct device * dev);
 };
-- 
1.4.2.1

