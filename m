Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVIHWZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVIHWZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbVIHWW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:22:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:33470 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965042AbVIHWWy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:22:54 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: hotplug support.
In-Reply-To: <11262181611488@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 8 Sep 2005 15:22:41 -0700
Message-Id: <11262181612005@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: hotplug support.

Here is W1 hotplug in addition to netlink notifications.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 7f772ed8df27c6941952452330c618512389c4c7
tree 6ad8320e0ee8bd2f4709176381662460ec4b1e45
parent 8949d2aa05ddf5e9a31d738568a79915970cb38e
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Thu, 11 Aug 2005 13:20:07 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 08 Sep 2005 14:41:26 -0700

 drivers/w1/w1.c     |   90 +++++++++++++++++++++++++++++++++++++++++++++------
 drivers/w1/w1_int.c |    6 ++-
 2 files changed, 82 insertions(+), 14 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -125,27 +125,41 @@ static struct bin_attribute w1_slave_bin
 	.read = &w1_default_read_bin,
 };
 
+static int w1_hotplug(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size);
 
 static struct bus_type w1_bus_type = {
 	.name = "w1",
 	.match = w1_master_match,
+	.hotplug = w1_hotplug,
 };
 
-struct device_driver w1_driver = {
-	.name = "w1_driver",
+struct device_driver w1_master_driver = {
+	.name = "w1_master_driver",
 	.bus = &w1_bus_type,
 	.probe = w1_master_probe,
 	.remove = w1_master_remove,
 };
 
-struct device w1_device = {
+struct device w1_master_device = {
 	.parent = NULL,
 	.bus = &w1_bus_type,
 	.bus_id = "w1 bus master",
-	.driver = &w1_driver,
+	.driver = &w1_master_driver,
 	.release = &w1_master_release
 };
 
+struct device_driver w1_slave_driver = {
+	.name = "w1_slave_driver",
+	.bus = &w1_bus_type,
+};
+
+struct device w1_slave_device = {
+	.parent = NULL,
+	.bus = &w1_bus_type,
+	.bus_id = "w1 bus slave",
+	.driver = &w1_slave_driver,
+};
+
 static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
@@ -329,12 +343,55 @@ void w1_destroy_master_attributes(struct
 	sysfs_remove_group(&master->dev.kobj, &w1_master_defattr_group);
 }
 
+#ifdef CONFIG_HOTPLUG
+static int w1_hotplug(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size)
+{
+	struct w1_master *md = NULL;
+	struct w1_slave *sl = NULL;
+	char *event_owner, *name;
+	int err, cur_index=0, cur_len=0;
+
+	if (dev->driver == &w1_master_driver) {
+		md = container_of(dev, struct w1_master, dev);
+		event_owner = "master";
+		name = md->name;
+	} else if (dev->driver == &w1_slave_driver) {
+		sl = container_of(dev, struct w1_slave, dev);
+		event_owner = "slave";
+		name = sl->name;
+	} else {
+		dev_dbg(dev, "Unknown hotplug event.\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "Hotplug event for %s %s, bus_id=%s.\n", event_owner, name, dev->bus_id);
+
+	if (dev->driver != &w1_slave_driver || !sl)
+		return 0;
+
+	err = add_hotplug_env_var(envp, num_envp, &cur_index, buffer, buffer_size, &cur_len, "W1_FID=%02X", sl->reg_num.family);
+	if (err)
+		return err;
+
+	err = add_hotplug_env_var(envp, num_envp, &cur_index, buffer, buffer_size, &cur_len, "W1_SLAVE_ID=%024llX", sl->reg_num.id);
+	if (err)
+		return err;
+
+	return 0;
+};
+#else
+static int w1_hotplug(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size)
+{
+	return 0;
+}
+#endif
+
 static int __w1_attach_slave_device(struct w1_slave *sl)
 {
 	int err;
 
 	sl->dev.parent = &sl->master->dev;
-	sl->dev.driver = sl->master->driver;
+	sl->dev.driver = &w1_slave_driver;
 	sl->dev.bus = &w1_bus_type;
 	sl->dev.release = &w1_slave_release;
 
@@ -507,7 +564,6 @@ void w1_reconnect_slaves(struct w1_famil
 	spin_unlock_bh(&w1_mlock);
 }
 
-
 static void w1_slave_found(unsigned long data, u64 rn)
 {
 	int slave_count;
@@ -783,7 +839,7 @@ static int w1_init(void)
 		goto err_out_exit_init;
 	}
 
-	retval = driver_register(&w1_driver);
+	retval = driver_register(&w1_master_driver);
 	if (retval) {
 		printk(KERN_ERR
 			"Failed to register master driver. err=%d.\n",
@@ -791,18 +847,29 @@ static int w1_init(void)
 		goto err_out_bus_unregister;
 	}
 
+	retval = driver_register(&w1_slave_driver);
+	if (retval) {
+		printk(KERN_ERR
+			"Failed to register master driver. err=%d.\n",
+			retval);
+		goto err_out_master_unregister;
+	}
+
 	control_thread = kernel_thread(&w1_control, NULL, 0);
 	if (control_thread < 0) {
 		printk(KERN_ERR "Failed to create control thread. err=%d\n",
 			control_thread);
 		retval = control_thread;
-		goto err_out_driver_unregister;
+		goto err_out_slave_unregister;
 	}
 
 	return 0;
 
-err_out_driver_unregister:
-	driver_unregister(&w1_driver);
+err_out_slave_unregister:
+	driver_unregister(&w1_slave_driver);
+
+err_out_master_unregister:
+	driver_unregister(&w1_master_driver);
 
 err_out_bus_unregister:
 	bus_unregister(&w1_bus_type);
@@ -821,7 +888,8 @@ static void w1_fini(void)
 	control_needs_exit = 1;
 	wait_for_completion(&w1_control_complete);
 
-	driver_unregister(&w1_driver);
+	driver_unregister(&w1_slave_driver);
+	driver_unregister(&w1_master_driver);
 	bus_unregister(&w1_bus_type);
 }
 
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -29,9 +29,9 @@
 
 static u32 w1_ids = 1;
 
-extern struct device_driver w1_driver;
+extern struct device_driver w1_master_driver;
 extern struct bus_type w1_bus_type;
-extern struct device w1_device;
+extern struct device w1_master_device;
 extern int w1_max_slave_count;
 extern int w1_max_slave_ttl;
 extern struct list_head w1_masters;
@@ -125,7 +125,7 @@ int w1_add_master_device(struct w1_bus_m
 		return(-EINVAL);
         }
 
-	dev = w1_alloc_dev(w1_ids++, w1_max_slave_count, w1_max_slave_ttl, &w1_driver, &w1_device);
+	dev = w1_alloc_dev(w1_ids++, w1_max_slave_count, w1_max_slave_ttl, &w1_master_driver, &w1_master_device);
 	if (!dev)
 		return -ENOMEM;
 

