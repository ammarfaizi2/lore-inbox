Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbVIHW03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVIHW03 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVIHW00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:26:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:37822 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965036AbVIHWWz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:22:55 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: Detouching bug fixed.
In-Reply-To: <11262181602327@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 8 Sep 2005 15:22:40 -0700
Message-Id: <11262181601746@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: Detouching bug fixed.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 3aca692d3ec7cf89da4575f598e41f74502b22d7
tree 84740dbcf1ea648b303020f2106e7f9e46f92835
parent d2a4ef6a0ce4d841293b49bf2cdc17a0ebfaaf9d
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Thu, 11 Aug 2005 17:27:50 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 08 Sep 2005 14:41:26 -0700

 drivers/w1/w1.c     |   93 +++++++++++++++++++++++++++------------------------
 drivers/w1/w1.h     |    3 +-
 drivers/w1/w1_int.c |    6 +--
 3 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -45,10 +45,12 @@ MODULE_AUTHOR("Evgeniy Polyakov <johnpol
 MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol.");
 
 static int w1_timeout = 10;
+static int w1_control_timeout = 1;
 int w1_max_slave_count = 10;
 int w1_max_slave_ttl = 10;
 
 module_param_named(timeout, w1_timeout, int, 0);
+module_param_named(control_timeout, w1_control_timeout, int, 0);
 module_param_named(max_slave_count, w1_max_slave_count, int, 0);
 module_param_named(slave_ttl, w1_max_slave_ttl, int, 0);
 
@@ -69,37 +71,51 @@ static int w1_master_probe(struct device
 	return -ENODEV;
 }
 
-static int w1_master_remove(struct device *dev)
-{
-	return 0;
-}
-
 static void w1_master_release(struct device *dev)
 {
 	struct w1_master *md = dev_to_w1_master(dev);
-	complete(&md->dev_released);
+
+	dev_dbg(dev, "%s: Releasing %s.\n", __func__, md->name);
+
+	if (md->nls && md->nls->sk_socket)
+		sock_release(md->nls->sk_socket);
+	memset(md, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
+	kfree(md);
 }
 
 static void w1_slave_release(struct device *dev)
 {
 	struct w1_slave *sl = dev_to_w1_slave(dev);
-	complete(&sl->dev_released);
+
+	dev_dbg(dev, "%s: Releasing %s.\n", __func__, sl->name);
+
+	while (atomic_read(&sl->refcnt)) {
+		dev_dbg(dev, "Waiting for %s to become free: refcnt=%d.\n",
+				sl->name, atomic_read(&sl->refcnt));
+		if (msleep_interruptible(1000))
+			flush_signals(current);
+	}
+
+	w1_family_put(sl->family);
+	sl->master->slave_count--;
+
+	complete(&sl->released);
 }
 
 static ssize_t w1_slave_read_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
-      struct w1_slave *sl = dev_to_w1_slave(dev);
+	struct w1_slave *sl = dev_to_w1_slave(dev);
 
-      return sprintf(buf, "%s\n", sl->name);
+	return sprintf(buf, "%s\n", sl->name);
 }
 
 static ssize_t w1_slave_read_id(struct kobject *kobj, char *buf, loff_t off, size_t count)
 {
-      struct w1_slave *sl = kobj_to_w1_slave(kobj);
+	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 
-      atomic_inc(&sl->refcnt);
-      if (off > 8) {
-              count = 0;
+	atomic_inc(&sl->refcnt);
+	if (off > 8) {
+		count = 0;
 	} else {
 		if (off + count > 8)
 			count = 8 - off;
@@ -109,7 +125,7 @@ static ssize_t w1_slave_read_id(struct k
 	atomic_dec(&sl->refcnt);
 
 	return count;
-  }
+}
 
 static struct device_attribute w1_slave_attr_name =
 	__ATTR(name, S_IRUGO, w1_slave_read_name, NULL);
@@ -139,7 +155,6 @@ struct device_driver w1_master_driver = 
 	.name = "w1_master_driver",
 	.bus = &w1_bus_type,
 	.probe = w1_master_probe,
-	.remove = w1_master_remove,
 };
 
 struct device w1_master_device = {
@@ -160,6 +175,7 @@ struct device w1_slave_device = {
 	.bus = &w1_bus_type,
 	.bus_id = "w1 bus slave",
 	.driver = &w1_slave_driver,
+	.release = &w1_slave_release
 };
 
 static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_attribute *attr, char *buf)
@@ -406,8 +422,7 @@ static int __w1_attach_slave_device(stru
 		 (unsigned int) sl->reg_num.family,
 		 (unsigned long long) sl->reg_num.id);
 
-	dev_dbg(&sl->dev, "%s: registering %s.\n", __func__,
-		&sl->dev.bus_id[0]);
+	dev_dbg(&sl->dev, "%s: registering %s as %p.\n", __func__, &sl->dev.bus_id[0]);
 
 	err = device_register(&sl->dev);
 	if (err < 0) {
@@ -480,7 +495,7 @@ static int w1_attach_slave_device(struct
 
 	memcpy(&sl->reg_num, rn, sizeof(sl->reg_num));
 	atomic_set(&sl->refcnt, 0);
-	init_completion(&sl->dev_released);
+	init_completion(&sl->released);
 
 	spin_lock(&w1_flock);
 	f = w1_family_registered(rn->family);
@@ -512,6 +527,8 @@ static int w1_attach_slave_device(struct
 	msg.type = W1_SLAVE_ADD;
 	w1_netlink_send(dev, &msg);
 
+	dev_info(&dev->dev, "Finished %s for sl=%p.\n", __func__, sl);
+
 	return 0;
 }
 
@@ -519,29 +536,23 @@ static void w1_slave_detach(struct w1_sl
 {
 	struct w1_netlink_msg msg;
 
-	dev_info(&sl->dev, "%s: detaching %s.\n", __func__, sl->name);
+	dev_info(&sl->dev, "%s: detaching %s [%p].\n", __func__, sl->name, sl);
 
-	while (atomic_read(&sl->refcnt)) {
-		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
-				sl->name, atomic_read(&sl->refcnt));
-
-		if (msleep_interruptible(1000))
-			flush_signals(current);
-	}
+	list_del(&sl->w1_slave_entry);
 
 	if (sl->family->fops && sl->family->fops->remove_slave)
 		sl->family->fops->remove_slave(sl);
 
+	memcpy(&msg.id.id, &sl->reg_num, sizeof(msg.id.id));
+	msg.type = W1_SLAVE_REMOVE;
+	w1_netlink_send(sl->master, &msg);
+
 	sysfs_remove_bin_file(&sl->dev.kobj, &w1_slave_attr_bin_id);
 	device_remove_file(&sl->dev, &w1_slave_attr_name);
 	device_unregister(&sl->dev);
-	w1_family_put(sl->family);
 
-	sl->master->slave_count--;
-
-	memcpy(&msg.id.id, &sl->reg_num, sizeof(msg.id.id));
-	msg.type = W1_SLAVE_REMOVE;
-	w1_netlink_send(sl->master, &msg);
+	wait_for_completion(&sl->released);
+	kfree(sl);
 }
 
 static struct w1_master *w1_search_master(unsigned long data)
@@ -713,7 +724,7 @@ static int w1_control(void *data)
 		have_to_wait = 0;
 
 		try_to_freeze();
-		msleep_interruptible(w1_timeout * 1000);
+		msleep_interruptible(w1_control_timeout * 1000);
 
 		if (signal_pending(current))
 			flush_signals(current);
@@ -746,13 +757,12 @@ static int w1_control(void *data)
 				list_del(&dev->w1_master_entry);
 				spin_unlock_bh(&w1_mlock);
 
+				down(&dev->mutex);
 				list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
-					list_del(&sl->w1_slave_entry);
-
 					w1_slave_detach(sl);
-					kfree(sl);
 				}
 				w1_destroy_master_attributes(dev);
+				up(&dev->mutex);
 				atomic_dec(&dev->refcnt);
 				continue;
 			}
@@ -760,19 +770,17 @@ static int w1_control(void *data)
 			if (test_bit(W1_MASTER_NEED_RECONNECT, &dev->flags)) {
 				dev_info(&dev->dev, "Reconnecting slaves in device %s.\n", dev->name);
 				down(&dev->mutex);
-				list_for_each_entry(sl, &dev->slist, w1_slave_entry) {
+				list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
 					if (sl->family->fid == W1_FAMILY_DEFAULT) {
 						struct w1_reg_num rn;
-						list_del(&sl->w1_slave_entry);
-						w1_slave_detach(sl);
 
 						memcpy(&rn, &sl->reg_num, sizeof(rn));
-
-						kfree(sl);
+						w1_slave_detach(sl);
 
 						w1_attach_slave_device(dev, &rn);
 					}
 				}
+				dev_info(&dev->dev, "Reconnecting slaves in device %s has been finished.\n", dev->name);
 				clear_bit(W1_MASTER_NEED_RECONNECT, &dev->flags);
 				up(&dev->mutex);
 			}
@@ -816,10 +824,7 @@ int w1_process(void *data)
 
 		list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
 			if (!test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags) && !--sl->ttl) {
-				list_del (&sl->w1_slave_entry);
-
 				w1_slave_detach(sl);
-				kfree(sl);
 
 				dev->slave_count--;
 			} else if (test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags))
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -76,7 +76,7 @@ struct w1_slave
 	struct w1_master	*master;
 	struct w1_family	*family;
 	struct device		dev;
-	struct completion	dev_released;
+	struct completion	released;
 };
 
 typedef void (* w1_slave_found_callback)(unsigned long, u64);
@@ -176,7 +176,6 @@ struct w1_master
 
 	struct device_driver	*driver;
 	struct device		dev;
-	struct completion	dev_released;
 	struct completion	dev_exited;
 
 	struct w1_bus_master	*bus_master;
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -76,7 +76,6 @@ static struct w1_master * w1_alloc_dev(u
 	INIT_LIST_HEAD(&dev->slist);
 	init_MUTEX(&dev->mutex);
 
-	init_completion(&dev->dev_released);
 	init_completion(&dev->dev_exited);
 
 	memcpy(&dev->dev, device, sizeof(struct device));
@@ -107,9 +106,6 @@ static struct w1_master * w1_alloc_dev(u
 void w1_free_dev(struct w1_master *dev)
 {
 	device_unregister(&dev->dev);
-	dev_fini_netlink(dev);
-	memset(dev, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
-	kfree(dev);
 }
 
 int w1_add_master_device(struct w1_bus_master *master)
@@ -184,7 +180,7 @@ void __w1_remove_master_device(struct w1
 			 __func__, dev->kpid);
 
 	while (atomic_read(&dev->refcnt)) {
-		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
+		dev_dbg(&dev->dev, "Waiting for %s to become free: refcnt=%d.\n",
 				dev->name, atomic_read(&dev->refcnt));
 
 		if (msleep_interruptible(1000))

