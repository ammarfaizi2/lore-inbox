Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270712AbTHOSdC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270714AbTHOSZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:25:45 -0400
Received: from mail.kroah.org ([65.200.24.183]:57730 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270700AbTHOSZb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:25:31 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10609719472782@kroah.com>
Subject: [PATCH] Driver Core fixes for 2.6.0-test3
In-Reply-To: <20030815182459.GA3755@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 15 Aug 2003 11:25:47 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1152.2.1, 2003/08/14 16:31:09-07:00, greg@kroah.com

Driver Core: remove struct device.name as it is not needed

If a specific driver subsystem needs a name field, they should implement it
for just that subsystem.


 drivers/base/core.c      |    6 ++----
 drivers/base/interface.c |    8 --------
 drivers/base/platform.c  |    1 -
 drivers/base/power.c     |    2 +-
 include/linux/device.h   |    1 -
 5 files changed, 3 insertions(+), 15 deletions(-)


diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Fri Aug 15 11:16:13 2003
+++ b/drivers/base/core.c	Fri Aug 15 11:16:13 2003
@@ -210,8 +210,7 @@
 
 	parent = get_device(dev->parent);
 
-	pr_debug("DEV: registering device: ID = '%s', name = %s\n",
-		 dev->bus_id, dev->name);
+	pr_debug("DEV: registering device: ID = '%s'\n", dev->bus_id);
 
 	/* first, register with generic layer. */
 	strlcpy(dev->kobj.name,dev->bus_id,KOBJ_NAME_LEN);
@@ -337,8 +336,7 @@
  */
 void device_unregister(struct device * dev)
 {
-	pr_debug("DEV: Unregistering device. ID = '%s', name = '%s'\n",
-		 dev->bus_id,dev->name);
+	pr_debug("DEV: Unregistering device. ID = '%s'\n", dev->bus_id);
 	device_del(dev);
 	put_device(dev);
 }
diff -Nru a/drivers/base/interface.c b/drivers/base/interface.c
--- a/drivers/base/interface.c	Fri Aug 15 11:16:13 2003
+++ b/drivers/base/interface.c	Fri Aug 15 11:16:13 2003
@@ -14,13 +14,6 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 
-static ssize_t device_read_name(struct device * dev, char * buf)
-{
-	return sprintf(buf,"%s\n",dev->name);
-}
-
-static DEVICE_ATTR(name,S_IRUGO,device_read_name,NULL);
-
 static ssize_t
 device_read_power(struct device * dev, char * page)
 {
@@ -91,7 +84,6 @@
 		   device_read_power,device_write_power);
 
 struct attribute * dev_default_attrs[] = {
-	&dev_attr_name.attr,
 	&dev_attr_power.attr,
 	NULL,
 };
diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	Fri Aug 15 11:16:13 2003
+++ b/drivers/base/platform.c	Fri Aug 15 11:16:13 2003
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 
 struct device legacy_bus = {
-	.name		= "legacy bus",
 	.bus_id		= "legacy",
 };
 
diff -Nru a/drivers/base/power.c b/drivers/base/power.c
--- a/drivers/base/power.c	Fri Aug 15 11:16:13 2003
+++ b/drivers/base/power.c	Fri Aug 15 11:16:13 2003
@@ -59,7 +59,7 @@
 			error = dev->driver->suspend(dev,state,level);
 			if (error)
 				printk(KERN_ERR "%s: suspend returned %d\n",
-				       dev->name,error);
+				       dev->bus_id, error);
 		}
 	}
 	up_write(&devices_subsys.rwsem);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Fri Aug 15 11:16:13 2003
+++ b/include/linux/device.h	Fri Aug 15 11:16:13 2003
@@ -258,7 +258,6 @@
 	struct device 	* parent;
 
 	struct kobject kobj;
-	char	name[DEVICE_NAME_SIZE];	/* descriptive ascii string */
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
 
 	struct bus_type	* bus;		/* type of bus device is on */

