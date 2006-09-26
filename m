Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWIZFkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWIZFkr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWIZFkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:40:13 -0400
Received: from ns2.suse.de ([195.135.220.15]:41429 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751405AbWIZFjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:33 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 28/47] Driver core: add ability for classes to handle devices properly
Date: Mon, 25 Sep 2006 22:37:48 -0700
Message-Id: <11592491744040-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491704137-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This adds two new callbacks to the class structure:
	int	(*dev_uevent)(struct device *dev, char **envp, int num_envp,
			char *buffer, int buffer_size);
	void	(*dev_release)(struct device *dev);

And one pointer:
	struct device_attribute		* dev_attrs;

which all corrispond with the same thing as the "normal" class devices
do, yet this is for when a struct device is bound to a class.

Someday soon, struct class_device will go away, and then the other
fields in this structure can be removed too.  But this is necessary in
order to get the transition to work properly.

Tested out on a network core patch that converted it to use struct
device instead of struct class_device.


Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c    |   53 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |    4 ++++
 2 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5c91d0d..f1228f2 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -94,6 +94,8 @@ static void device_release(struct kobjec
 
 	if (dev->release)
 		dev->release(dev);
+	else if (dev->class && dev->class->dev_release)
+		dev->class->dev_release(dev);
 	else {
 		printk(KERN_ERR "Device '%s' does not have a release() function, "
 			"it is broken and must be fixed.\n",
@@ -183,6 +185,15 @@ static int dev_uevent(struct kset *kset,
 		}
 	}
 
+	if (dev->class && dev->class->dev_uevent) {
+		/* have the class specific function add its stuff */
+		retval = dev->class->dev_uevent(dev, envp, num_envp, buffer, buffer_size);
+			if (retval) {
+				pr_debug("%s - dev_uevent() returned %d\n",
+					 __FUNCTION__, retval);
+		}
+	}
+
 	return retval;
 }
 
@@ -228,6 +239,43 @@ static void device_remove_groups(struct 
 	}
 }
 
+static int device_add_attrs(struct device *dev)
+{
+	struct class *class = dev->class;
+	int error = 0;
+	int i;
+
+	if (!class)
+		return 0;
+
+	if (class->dev_attrs) {
+		for (i = 0; attr_name(class->dev_attrs[i]); i++) {
+			error = device_create_file(dev, &class->dev_attrs[i]);
+			if (error)
+				break;
+		}
+	}
+	if (error)
+		while (--i >= 0)
+			device_remove_file(dev, &class->dev_attrs[i]);
+	return error;
+}
+
+static void device_remove_attrs(struct device *dev)
+{
+	struct class *class = dev->class;
+	int i;
+
+	if (!class)
+		return;
+
+	if (class->dev_attrs) {
+		for (i = 0; attr_name(class->dev_attrs[i]); i++)
+			device_remove_file(dev, &class->dev_attrs[i]);
+	}
+}
+
+
 static ssize_t show_dev(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
@@ -382,6 +430,8 @@ int device_add(struct device *dev)
 		}
 	}
 
+	if ((error = device_add_attrs(dev)))
+		goto AttrsError;
 	if ((error = device_add_groups(dev)))
 		goto GroupError;
 	if ((error = device_pm_add(dev)))
@@ -412,6 +462,8 @@ int device_add(struct device *dev)
  PMError:
 	device_remove_groups(dev);
  GroupError:
+ 	device_remove_attrs(dev);
+ AttrsError:
 	if (dev->devt_attr) {
 		device_remove_file(dev, dev->devt_attr);
 		kfree(dev->devt_attr);
@@ -509,6 +561,7 @@ void device_del(struct device * dev)
 	}
 	device_remove_file(dev, &dev->uevent_attr);
 	device_remove_groups(dev);
+	device_remove_attrs(dev);
 
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
diff --git a/include/linux/device.h b/include/linux/device.h
index 994d3eb..3122bd2 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -151,12 +151,16 @@ struct class {
 
 	struct class_attribute		* class_attrs;
 	struct class_device_attribute	* class_dev_attrs;
+	struct device_attribute		* dev_attrs;
 
 	int	(*uevent)(struct class_device *dev, char **envp,
 			   int num_envp, char *buffer, int buffer_size);
+	int	(*dev_uevent)(struct device *dev, char **envp, int num_envp,
+				char *buffer, int buffer_size);
 
 	void	(*release)(struct class_device *dev);
 	void	(*class_release)(struct class *class);
+	void	(*dev_release)(struct device *dev);
 
 	int	(*suspend)(struct device *, pm_message_t state);
 	int	(*resume)(struct device *);
-- 
1.4.2.1

