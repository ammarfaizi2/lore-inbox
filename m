Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267336AbUHWSwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267336AbUHWSwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUHWSv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:51:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:17092 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267336AbUHWShN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:13 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286088860@kroah.com>
Date: Mon, 23 Aug 2004 11:34:48 -0700
Message-Id: <10932860884122@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.33, 2004/08/09 10:44:46-07:00, johnpol@2ka.mipt.ru

[PATCH] w1: Added dynamic slave removal mechanism. Fixed bug when we have multiple slave with different families.

Added dynamic slave removal mechanism by introducing u32 flags; in each slave.
        If slave was found during search process then set flag.
        If after search complete we have slave entryes without magic flag then remove them.
Fixed bug when we have multiple slave with different families.
        Since attributes were static then each new family will rewrite static values with new
        function pointers... badly broken.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1.c |   59 +++++++++++++++++++++++++++++++++++++++++++-------------
 drivers/w1/w1.h |    6 +++++
 2 files changed, 52 insertions(+), 13 deletions(-)


diff -Nru a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c	2004-08-23 11:03:29 -07:00
+++ b/drivers/w1/w1.c	2004-08-23 11:03:29 -07:00
@@ -338,12 +338,16 @@
 		return err;
 	}
 
-	w1_slave_bin_attribute.read = sl->family->fops->rbin;
-	w1_slave_attribute.show = sl->family->fops->rname;
-	w1_slave_attribute_val.show = sl->family->fops->rval;
-	w1_slave_attribute_val.attr.name = sl->family->fops->rvalname;
+	memcpy(&sl->attr_bin, &w1_slave_bin_attribute, sizeof(sl->attr_bin));
+	memcpy(&sl->attr_name, &w1_slave_attribute, sizeof(sl->attr_name));
+	memcpy(&sl->attr_val, &w1_slave_attribute_val, sizeof(sl->attr_val));
+	
+	sl->attr_bin.read = sl->family->fops->rbin;
+	sl->attr_name.show = sl->family->fops->rname;
+	sl->attr_val.show = sl->family->fops->rval;
+	sl->attr_val.attr.name = sl->family->fops->rvalname;
 
-	err = device_create_file(&sl->dev, &w1_slave_attribute);
+	err = device_create_file(&sl->dev, &sl->attr_name);
 	if (err < 0) {
 		dev_err(&sl->dev,
 			 "sysfs file creation for [%s] failed. err=%d\n",
@@ -352,23 +356,23 @@
 		return err;
 	}
 
-	err = device_create_file(&sl->dev, &w1_slave_attribute_val);
+	err = device_create_file(&sl->dev, &sl->attr_val);
 	if (err < 0) {
 		dev_err(&sl->dev,
 			 "sysfs file creation for [%s] failed. err=%d\n",
 			 sl->dev.bus_id, err);
-		device_remove_file(&sl->dev, &w1_slave_attribute);
+		device_remove_file(&sl->dev, &sl->attr_name);
 		device_unregister(&sl->dev);
 		return err;
 	}
 
-	err = sysfs_create_bin_file(&sl->dev.kobj, &w1_slave_bin_attribute);
+	err = sysfs_create_bin_file(&sl->dev.kobj, &sl->attr_bin);
 	if (err < 0) {
 		dev_err(&sl->dev,
 			 "sysfs file creation for [%s] failed. err=%d\n",
 			 sl->dev.bus_id, err);
-		device_remove_file(&sl->dev, &w1_slave_attribute);
-		device_remove_file(&sl->dev, &w1_slave_attribute_val);
+		device_remove_file(&sl->dev, &sl->attr_name);
+		device_remove_file(&sl->dev, &sl->attr_val);
 		device_unregister(&sl->dev);
 		return err;
 	}
@@ -397,6 +401,7 @@
 
 	sl->owner = THIS_MODULE;
 	sl->master = dev;
+	set_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
 
 	memcpy(&sl->reg_num, rn, sizeof(sl->reg_num));
 	atomic_set(&sl->refcnt, 0);
@@ -444,8 +449,9 @@
 	while (atomic_read(&sl->refcnt))
 		schedule_timeout(10);
 
-	sysfs_remove_bin_file(&sl->dev.kobj, &w1_slave_bin_attribute);
-	device_remove_file(&sl->dev, &w1_slave_attribute);
+	sysfs_remove_bin_file (&sl->dev.kobj, &sl->attr_bin);
+	device_remove_file(&sl->dev, &sl->attr_name);
+	device_remove_file(&sl->dev, &sl->attr_val);
 	device_unregister(&sl->dev);
 	w1_family_put(sl->family);
 
@@ -551,7 +557,10 @@
 			if (sl->reg_num.family == tmp->family &&
 			    sl->reg_num.id == tmp->id &&
 			    sl->reg_num.crc == tmp->crc)
+			{
+				set_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
 				break;
+			}
 			else if (sl->reg_num.family == tmp->family) {
 				family_found = 1;
 				break;
@@ -672,6 +681,8 @@
 {
 	struct w1_master *dev = (struct w1_master *) data;
 	unsigned long timeout;
+	struct list_head *ent, *n;
+	struct w1_slave *sl;
 
 	daemonize("%s", dev->name);
 	allow_signal(SIGTERM);
@@ -695,7 +706,29 @@
 
 		if (down_interruptible(&dev->mutex))
 			continue;
-		w1_search(dev);
+
+		list_for_each_safe(ent, n, &dev->slist) {
+			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
+
+			if (sl)
+				clear_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
+		}
+		
+      		w1_search(dev);
+		
+		list_for_each_safe(ent, n, &dev->slist) {
+			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
+
+			if (sl && !test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags))
+			{
+				list_del (&sl->w1_slave_entry);
+
+				w1_slave_detach (sl);
+				kfree (sl);
+
+				dev->slave_count--;
+			}
+		}
 		up(&dev->mutex);
 	}
 
diff -Nru a/drivers/w1/w1.h b/drivers/w1/w1.h
--- a/drivers/w1/w1.h	2004-08-23 11:03:29 -07:00
+++ b/drivers/w1/w1.h	2004-08-23 11:03:29 -07:00
@@ -52,6 +52,8 @@
 #define W1_READ_PSUPPLY		0xB4
 #define W1_MATCH_ROM		0x55
 
+#define W1_SLAVE_ACTIVE		(1<<0)
+
 struct w1_slave
 {
 	struct module		*owner;
@@ -60,11 +62,15 @@
 	struct w1_reg_num	reg_num;
 	atomic_t		refcnt;
 	u8			rom[9];
+	u32			flags;
 
 	struct w1_master	*master;
 	struct w1_family 	*family;
 	struct device 		dev;
 	struct completion 	dev_released;
+
+	struct bin_attribute 	attr_bin;
+	struct device_attribute	attr_name, attr_val;
 };
 
 struct w1_bus_master

