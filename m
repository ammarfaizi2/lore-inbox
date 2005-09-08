Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbVIHW1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbVIHW1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVIHW0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:26:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:39614 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965045AbVIHWW4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:22:56 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: Added add/remove slave callbacks.
In-Reply-To: <11262181613204@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 8 Sep 2005 15:22:41 -0700
Message-Id: <11262181614069@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: Added add/remove slave callbacks.

Patch is based on work from Ben Gardner <bgardner@wabtec.com>

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d2a4ef6a0ce4d841293b49bf2cdc17a0ebfaaf9d
tree 2d49373e06fd65aae5217aad864fafb849c8cda2
parent ea7d8f65c865ebfa1d7cd67c360a87333ff013c1
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Thu, 11 Aug 2005 17:27:50 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 08 Sep 2005 14:41:26 -0700

 drivers/w1/w1.c        |  119 +++++++++++++++++++++++++++---------------------
 drivers/w1/w1.h        |    3 -
 drivers/w1/w1_family.c |   11 ----
 drivers/w1/w1_family.h |    6 ++
 drivers/w1/w1_smem.c   |   47 -------------------
 drivers/w1/w1_therm.c  |   32 +++++++++----
 6 files changed, 93 insertions(+), 125 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -59,19 +59,6 @@ static pid_t control_thread;
 static int control_needs_exit;
 static DECLARE_COMPLETION(w1_control_complete);
 
-/* stuff for the default family */
-static ssize_t w1_famdefault_read_name(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
-	return(sprintf(buf, "%s\n", sl->name));
-}
-static struct w1_family_ops w1_default_fops = {
-	.rname = &w1_famdefault_read_name,
-};
-static struct w1_family w1_default_family = {
-	.fops = &w1_default_fops,
-};
-
 static int w1_master_match(struct device *dev, struct device_driver *drv)
 {
 	return 1;
@@ -99,30 +86,47 @@ static void w1_slave_release(struct devi
 	complete(&sl->dev_released);
 }
 
-static ssize_t w1_default_read_name(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t w1_slave_read_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "No family registered.\n");
+      struct w1_slave *sl = dev_to_w1_slave(dev);
+
+      return sprintf(buf, "%s\n", sl->name);
 }
 
-static ssize_t w1_default_read_bin(struct kobject *kobj, char *buf, loff_t off,
-		     size_t count)
+static ssize_t w1_slave_read_id(struct kobject *kobj, char *buf, loff_t off, size_t count)
 {
-	return sprintf(buf, "No family registered.\n");
-}
+      struct w1_slave *sl = kobj_to_w1_slave(kobj);
 
-static struct device_attribute w1_slave_attribute =
-	__ATTR(name, S_IRUGO, w1_default_read_name, NULL);
+      atomic_inc(&sl->refcnt);
+      if (off > 8) {
+              count = 0;
+	} else {
+		if (off + count > 8)
+			count = 8 - off;
 
-static struct bin_attribute w1_slave_bin_attribute = {
-	.attr = {
-		.name = "w1_slave",
-		.mode = S_IRUGO,
-		.owner = THIS_MODULE,
-	},
-	.size = W1_SLAVE_DATA_SIZE,
-	.read = &w1_default_read_bin,
+		memcpy(buf, (u8 *)&sl->reg_num, count);
+	}
+	atomic_dec(&sl->refcnt);
+
+	return count;
+  }
+
+static struct device_attribute w1_slave_attr_name =
+	__ATTR(name, S_IRUGO, w1_slave_read_name, NULL);
+
+static struct bin_attribute w1_slave_attr_bin_id = {
+      .attr = {
+              .name = "id",
+              .mode = S_IRUGO,
+              .owner = THIS_MODULE,
+      },
+      .size = 8,
+      .read = w1_slave_read_id,
 };
 
+/* Default family */
+static struct w1_family w1_default_family;
+
 static int w1_hotplug(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size);
 
 static struct bus_type w1_bus_type = {
@@ -413,36 +417,44 @@ static int __w1_attach_slave_device(stru
 		return err;
 	}
 
-	memcpy(&sl->attr_bin, &w1_slave_bin_attribute, sizeof(sl->attr_bin));
-	memcpy(&sl->attr_name, &w1_slave_attribute, sizeof(sl->attr_name));
-
-	sl->attr_bin.read = sl->family->fops->rbin;
-	sl->attr_name.show = sl->family->fops->rname;
+	/* Create "name" entry */
+	err = device_create_file(&sl->dev, &w1_slave_attr_name);
+	if (err < 0) {
+		dev_err(&sl->dev,
+			"sysfs file creation for [%s] failed. err=%d\n",
+			sl->dev.bus_id, err);
+		goto out_unreg;
+	}
 
-	err = device_create_file(&sl->dev, &sl->attr_name);
+	/* Create "id" entry */
+	err = sysfs_create_bin_file(&sl->dev.kobj, &w1_slave_attr_bin_id);
 	if (err < 0) {
 		dev_err(&sl->dev,
 			"sysfs file creation for [%s] failed. err=%d\n",
 			sl->dev.bus_id, err);
-		device_unregister(&sl->dev);
-		return err;
+		goto out_rem1;
 	}
 
-	if ( sl->attr_bin.read ) {
-		err = sysfs_create_bin_file(&sl->dev.kobj, &sl->attr_bin);
-		if (err < 0) {
-			dev_err(&sl->dev,
-				"sysfs file creation for [%s] failed. err=%d\n",
-				sl->dev.bus_id, err);
-			device_remove_file(&sl->dev, &sl->attr_name);
-			device_unregister(&sl->dev);
-			return err;
-		}
+	/* if the family driver needs to initialize something... */
+	if (sl->family->fops && sl->family->fops->add_slave &&
+	    ((err = sl->family->fops->add_slave(sl)) < 0)) {
+		dev_err(&sl->dev,
+			"sysfs file creation for [%s] failed. err=%d\n",
+			sl->dev.bus_id, err);
+		goto out_rem2;
 	}
 
 	list_add_tail(&sl->w1_slave_entry, &sl->master->slist);
 
 	return 0;
+
+out_rem2:
+	sysfs_remove_bin_file(&sl->dev.kobj, &w1_slave_attr_bin_id);
+out_rem1:
+	device_remove_file(&sl->dev, &w1_slave_attr_name);
+out_unreg:
+	device_unregister(&sl->dev);
+	return err;
 }
 
 static int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
@@ -517,10 +529,11 @@ static void w1_slave_detach(struct w1_sl
 			flush_signals(current);
 	}
 
-	if ( sl->attr_bin.read ) {
-		sysfs_remove_bin_file (&sl->dev.kobj, &sl->attr_bin);
-	}
-	device_remove_file(&sl->dev, &sl->attr_name);
+	if (sl->family->fops && sl->family->fops->remove_slave)
+		sl->family->fops->remove_slave(sl);
+
+	sysfs_remove_bin_file(&sl->dev.kobj, &w1_slave_attr_bin_id);
+	device_remove_file(&sl->dev, &w1_slave_attr_name);
 	device_unregister(&sl->dev);
 	w1_family_put(sl->family);
 
@@ -805,8 +818,8 @@ int w1_process(void *data)
 			if (!test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags) && !--sl->ttl) {
 				list_del (&sl->w1_slave_entry);
 
-				w1_slave_detach (sl);
-				kfree (sl);
+				w1_slave_detach(sl);
+				kfree(sl);
 
 				dev->slave_count--;
 			} else if (test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags))
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -77,9 +77,6 @@ struct w1_slave
 	struct w1_family	*family;
 	struct device		dev;
 	struct completion	dev_released;
-
-	struct bin_attribute	attr_bin;
-	struct device_attribute	attr_name;
 };
 
 typedef void (* w1_slave_found_callback)(unsigned long, u64);
diff --git a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
--- a/drivers/w1/w1_family.c
+++ b/drivers/w1/w1_family.c
@@ -29,23 +29,12 @@ DEFINE_SPINLOCK(w1_flock);
 static LIST_HEAD(w1_families);
 extern void w1_reconnect_slaves(struct w1_family *f);
 
-static int w1_check_family(struct w1_family *f)
-{
-	if (!f->fops->rname || !f->fops->rbin)
-		return -EINVAL;
-
-	return 0;
-}
-
 int w1_register_family(struct w1_family *newf)
 {
 	struct list_head *ent, *n;
 	struct w1_family *f;
 	int ret = 0;
 
-	if (w1_check_family(newf))
-		return -EINVAL;
-
 	spin_lock(&w1_flock);
 	list_for_each_safe(ent, n, &w1_families) {
 		f = list_entry(ent, struct w1_family, family_entry);
diff --git a/drivers/w1/w1_family.h b/drivers/w1/w1_family.h
--- a/drivers/w1/w1_family.h
+++ b/drivers/w1/w1_family.h
@@ -35,10 +35,12 @@
 
 #define MAXNAMELEN		32
 
+struct w1_slave;
+
 struct w1_family_ops
 {
-	ssize_t (* rname)(struct device *, struct device_attribute *, char *);
-	ssize_t (* rbin)(struct kobject *, char *, loff_t, size_t);
+	int  (* add_slave)(struct w1_slave *);
+	void (* remove_slave)(struct w1_slave *);
 };
 
 struct w1_family
diff --git a/drivers/w1/w1_smem.c b/drivers/w1/w1_smem.c
--- a/drivers/w1/w1_smem.c
+++ b/drivers/w1/w1_smem.c
@@ -36,59 +36,12 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
 MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, 64bit memory family.");
 
-static ssize_t w1_smem_read_name(struct device *, struct device_attribute *attr, char *);
-static ssize_t w1_smem_read_bin(struct kobject *, char *, loff_t, size_t);
-
-static struct w1_family_ops w1_smem_fops = {
-	.rname = &w1_smem_read_name,
-	.rbin = &w1_smem_read_bin,
-};
-
-static ssize_t w1_smem_read_name(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct w1_slave *sl = dev_to_w1_slave(dev);
-	return sprintf(buf, "%s\n", sl->name);
-}
-
-static ssize_t w1_smem_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
-{
-	struct w1_slave *sl = kobj_to_w1_slave(kobj);
-	int i;
-
-	atomic_inc(&sl->refcnt);
-	if (down_interruptible(&sl->master->mutex)) {
-		count = 0;
-		goto out_dec;
-	}
-
-	if (off > W1_SLAVE_DATA_SIZE) {
-		count = 0;
-		goto out;
-	}
-	if (off + count > W1_SLAVE_DATA_SIZE) {
-		count = 0;
-		goto out;
-	}
-	for (i = 0; i < 8; ++i)
-		count += sprintf(buf + count, "%02x ", ((u8 *)&sl->reg_num)[i]);
-	count += sprintf(buf + count, "\n");
-
-out:
-	up(&sl->master->mutex);
-out_dec:
-	atomic_dec(&sl->refcnt);
-
-	return count;
-}
-
 static struct w1_family w1_smem_family_01 = {
 	.fid = W1_FAMILY_SMEM_01,
-	.fops = &w1_smem_fops,
 };
 
 static struct w1_family w1_smem_family_81 = {
 	.fid = W1_FAMILY_SMEM_81,
-	.fops = &w1_smem_fops,
 };
 
 static int __init w1_smem_init(void)
diff --git a/drivers/w1/w1_therm.c b/drivers/w1/w1_therm.c
--- a/drivers/w1/w1_therm.c
+++ b/drivers/w1/w1_therm.c
@@ -42,12 +42,31 @@ static u8 bad_roms[][9] = {
 				{}
 			};
 
-static ssize_t w1_therm_read_name(struct device *, struct device_attribute *attr, char *);
 static ssize_t w1_therm_read_bin(struct kobject *, char *, loff_t, size_t);
 
+static struct bin_attribute w1_therm_bin_attr = {
+	.attr = {
+		.name = "w1_slave",
+		.mode = S_IRUGO,
+		.owner = THIS_MODULE,
+	},
+	.size = W1_SLAVE_DATA_SIZE,
+	.read = w1_therm_read_bin,
+};
+
+static int w1_therm_add_slave(struct w1_slave *sl)
+{
+	return sysfs_create_bin_file(&sl->dev.kobj, &w1_therm_bin_attr);
+}
+
+static void w1_therm_remove_slave(struct w1_slave *sl)
+{
+	sysfs_remove_bin_file(&sl->dev.kobj, &w1_therm_bin_attr);
+}
+
 static struct w1_family_ops w1_therm_fops = {
-	.rname = &w1_therm_read_name,
-	.rbin = &w1_therm_read_bin,
+	.add_slave	= w1_therm_add_slave,
+	.remove_slave	= w1_therm_remove_slave,
 };
 
 static struct w1_family w1_therm_family_DS18S20 = {
@@ -59,6 +78,7 @@ static struct w1_family w1_therm_family_
 	.fid = W1_THERM_DS18B20,
 	.fops = &w1_therm_fops,
 };
+
 static struct w1_family w1_therm_family_DS1822 = {
 	.fid = W1_THERM_DS1822,
 	.fops = &w1_therm_fops,
@@ -90,12 +110,6 @@ static struct w1_therm_family_converter 
 	},
 };
 
-static ssize_t w1_therm_read_name(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct w1_slave *sl = dev_to_w1_slave(dev);
-	return sprintf(buf, "%s\n", sl->name);
-}
-
 static inline int w1_DS18B20_convert_temp(u8 rom[9])
 {
 	int t = (rom[1] << 8) | rom[0];

