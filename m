Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVDUIP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVDUIP4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVDUIPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:15:36 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:60855 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261456AbVDUHaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:22 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 17/22] W1: cleanup slave refcounting & more
Date: Thu, 21 Apr 2005 02:23:59 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
References: <200504210207.02421.dtor_core@ameritech.net>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504210223.59430.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: clean-up slave device implementation:
    - get rid of separate refcount, rely on driver model to
      enforce lifetime rules;
    - pin w1 module until slave device is registered with sysfs
      to make sure W1 core stays loaded.
    - drop 'name' attribute as we already have it in bus_id.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 w1.c        |  165 ++++++++++++++++++++++++------------------------------------
 w1.h        |    3 -
 w1_family.c |    2 
 w1_family.h |    2 
 w1_smem.c   |   18 ------
 w1_therm.c  |   20 -------
 6 files changed, 71 insertions(+), 139 deletions(-)

Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -108,9 +108,6 @@ static ssize_t w1_default_read_bin(struc
 	return sprintf(buf, "No family registered.\n");
 }
 
-static struct device_attribute w1_slave_attribute =
-	__ATTR(name, S_IRUGO, w1_default_read_name, NULL);
-
 static struct device_attribute w1_slave_attribute_val =
 	__ATTR(value, S_IRUGO, w1_default_read_name, NULL);
 
@@ -126,166 +123,138 @@ static struct bin_attribute w1_slave_bin
 
 static void w1_slave_release(struct device *dev)
 {
-	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+	struct w1_slave *slave = to_w1_slave(dev);
 
-	complete(&sl->dev_released);
+	w1_family_put(slave->family);
+	kfree(slave);
+	module_put(THIS_MODULE);
 }
 
-static int __w1_attach_slave_device(struct w1_slave *sl)
+static int __w1_attach_slave_device(struct w1_slave *slave)
 {
 	int err;
 
-	sl->dev.parent = &sl->master->dev;
-	sl->dev.bus = &w1_bus_type;
-	sl->dev.release = &w1_slave_release;
+	slave->dev.parent = &slave->master->dev;
+	slave->dev.bus = &w1_bus_type;
+	slave->dev.release = &w1_slave_release;
 
-	snprintf(&sl->dev.bus_id[0], sizeof(sl->dev.bus_id),
-		  "%02x-%012llx",
-		  (unsigned int) sl->reg_num.family,
-		  (unsigned long long) sl->reg_num.id);
-	snprintf (&sl->name[0], sizeof(sl->name),
+	snprintf(&slave->dev.bus_id[0], sizeof(slave->dev.bus_id),
 		  "%02x-%012llx",
-		  (unsigned int) sl->reg_num.family,
-		  (unsigned long long) sl->reg_num.id);
+		  (unsigned int) slave->reg_num.family,
+		  (unsigned long long) slave->reg_num.id);
 
-	dev_dbg(&sl->dev, "%s: registering %s.\n", __func__,
-		&sl->dev.bus_id[0]);
+	dev_dbg(&slave->dev, "%s: registering %s.\n", __func__,
+		&slave->dev.bus_id[0]);
 
-	err = device_register(&sl->dev);
+	err = device_register(&slave->dev);
 	if (err < 0) {
-		dev_err(&sl->dev,
+		dev_err(&slave->dev,
 			 "Device registration [%s] failed. err=%d\n",
-			 sl->dev.bus_id, err);
+			 slave->dev.bus_id, err);
 		return err;
 	}
 
-	memcpy(&sl->attr_bin, &w1_slave_bin_attribute, sizeof(sl->attr_bin));
-	memcpy(&sl->attr_name, &w1_slave_attribute, sizeof(sl->attr_name));
-	memcpy(&sl->attr_val, &w1_slave_attribute_val, sizeof(sl->attr_val));
-
-	sl->attr_bin.read = sl->family->fops->rbin;
-	sl->attr_name.show = sl->family->fops->rname;
-	sl->attr_val.show = sl->family->fops->rval;
-	sl->attr_val.attr.name = sl->family->fops->rvalname;
+	__module_get(THIS_MODULE);
 
-	err = device_create_file(&sl->dev, &sl->attr_name);
-	if (err < 0) {
-		dev_err(&sl->dev,
-			 "sysfs file creation for [%s] failed. err=%d\n",
-			 sl->dev.bus_id, err);
-		device_unregister(&sl->dev);
-		return err;
-	}
+	memcpy(&slave->attr_bin, &w1_slave_bin_attribute, sizeof(slave->attr_bin));
+	memcpy(&slave->attr_val, &w1_slave_attribute_val, sizeof(slave->attr_val));
 
-	err = device_create_file(&sl->dev, &sl->attr_val);
+	slave->attr_bin.read = slave->family->fops->rbin;
+	slave->attr_val.show = slave->family->fops->rval;
+	slave->attr_val.attr.name = slave->family->fops->rvalname;
+
+	err = device_create_file(&slave->dev, &slave->attr_val);
 	if (err < 0) {
-		dev_err(&sl->dev,
+		dev_err(&slave->dev,
 			 "sysfs file creation for [%s] failed. err=%d\n",
-			 sl->dev.bus_id, err);
-		device_remove_file(&sl->dev, &sl->attr_name);
-		device_unregister(&sl->dev);
+			 slave->dev.bus_id, err);
+		device_unregister(&slave->dev);
 		return err;
 	}
 
-	err = sysfs_create_bin_file(&sl->dev.kobj, &sl->attr_bin);
+	err = sysfs_create_bin_file(&slave->dev.kobj, &slave->attr_bin);
 	if (err < 0) {
-		dev_err(&sl->dev,
+		dev_err(&slave->dev,
 			 "sysfs file creation for [%s] failed. err=%d\n",
-			 sl->dev.bus_id, err);
-		device_remove_file(&sl->dev, &sl->attr_name);
-		device_remove_file(&sl->dev, &sl->attr_val);
-		device_unregister(&sl->dev);
+			 slave->dev.bus_id, err);
+		device_remove_file(&slave->dev, &slave->attr_val);
+		device_unregister(&slave->dev);
 		return err;
 	}
 
-	err = sysfs_create_group(&sl->dev.kobj, &w1_slave_defattr_group);
+	err = sysfs_create_group(&slave->dev.kobj, &w1_slave_defattr_group);
 	if (err < 0) {
-		dev_err(&sl->dev,
+		dev_err(&slave->dev,
 			 "sysfs group creation for [%s] failed. err=%d\n",
-			 sl->dev.bus_id, err);
-		sysfs_remove_bin_file(&sl->dev.kobj, &sl->attr_bin);
-		device_remove_file(&sl->dev, &sl->attr_name);
-		device_remove_file(&sl->dev, &sl->attr_val);
-		device_unregister(&sl->dev);
+			 slave->dev.bus_id, err);
+		sysfs_remove_bin_file(&slave->dev.kobj, &slave->attr_bin);
+		device_remove_file(&slave->dev, &slave->attr_val);
+		device_unregister(&slave->dev);
 		return err;
 	}
 
-	list_add_tail(&sl->node, &sl->master->slist);
+	list_add_tail(&slave->node, &slave->master->slist);
 
 	return 0;
 }
 
-static int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
+static int w1_attach_slave_device(struct w1_master *master, struct w1_reg_num *rn)
 {
-	struct w1_slave *sl;
+	struct w1_slave *slave;
 	struct w1_family *f;
 	int err;
 
-	sl = kmalloc(sizeof(struct w1_slave), GFP_KERNEL);
-	if (!sl) {
-		dev_err(&dev->dev,
+	slave = kcalloc(1, sizeof(struct w1_slave), GFP_KERNEL);
+	if (!slave) {
+		dev_err(&master->dev,
 			 "%s: failed to allocate new slave device.\n",
 			 __func__);
 		return -ENOMEM;
 	}
 
-	memset(sl, 0, sizeof(*sl));
-
-	sl->master = dev;
-	set_bit(W1_SLAVE_ACTIVE, &sl->flags);
-
-	memcpy(&sl->reg_num, rn, sizeof(sl->reg_num));
-	atomic_set(&sl->refcnt, 0);
-	init_completion(&sl->dev_released);
+	slave->master = master;
+	slave->reg_num = *rn;
+	set_bit(W1_SLAVE_ACTIVE, &slave->flags);
 
 	spin_lock(&w1_flock);
 	f = w1_family_registered(rn->family);
 	if (!f) {
 		spin_unlock(&w1_flock);
-		dev_info(&dev->dev, "Family %x for %02x.%012llx.%02x is not registered.\n",
-			  rn->family, rn->family,
-			  (unsigned long long)rn->id, rn->crc);
-		kfree(sl);
+		dev_info(&master->dev,
+			 "Family %x for %02x.%012llx.%02x is not registered.\n",
+			 rn->family, rn->family,
+			 (unsigned long long)rn->id, rn->crc);
+		kfree(slave);
 		return -ENODEV;
 	}
 	__w1_family_get(f);
 	spin_unlock(&w1_flock);
 
-	sl->family = f;
+	slave->family = f;
 
-
-	err = __w1_attach_slave_device(sl);
+	err = __w1_attach_slave_device(slave);
 	if (err < 0) {
-		dev_err(&dev->dev, "%s: Attaching %s failed.\n", __func__,
-			 sl->name);
-		w1_family_put(sl->family);
-		kfree(sl);
+		dev_err(&master->dev, "%s: Attaching %s failed.\n", __func__,
+			slave->dev.bus_id);
+		w1_family_put(slave->family);
+		kfree(slave);
 		return err;
 	}
 
-	sl->ttl = dev->slave_ttl;
+	slave->ttl = master->slave_ttl;
 
 	return 0;
 }
 
-static void w1_slave_detach(struct w1_slave *sl)
+static void w1_slave_detach(struct w1_slave *slave)
 {
-	dev_info(&sl->dev, "%s: detaching %s.\n", __func__, sl->name);
+	dev_info(&slave->dev, "%s: detaching %s.\n",
+		 __func__, slave->dev.bus_id);
 
-	while (atomic_read(&sl->refcnt)) {
-		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
-				sl->name, atomic_read(&sl->refcnt));
-
-		if (msleep_interruptible(1000))
-			flush_signals(current);
-	}
-
-	sysfs_remove_group(&sl->dev.kobj, &w1_slave_defattr_group);
-	sysfs_remove_bin_file(&sl->dev.kobj, &sl->attr_bin);
-	device_remove_file(&sl->dev, &sl->attr_name);
-	device_remove_file(&sl->dev, &sl->attr_val);
-	device_unregister(&sl->dev);
-	w1_family_put(sl->family);
+	sysfs_remove_group(&slave->dev.kobj, &w1_slave_defattr_group);
+	sysfs_remove_bin_file(&slave->dev.kobj, &slave->attr_bin);
+	device_remove_file(&slave->dev, &slave->attr_val);
+	device_unregister(&slave->dev);
 }
 
 static void w1_slave_found(struct w1_master *dev, u64 rn)
@@ -333,7 +302,6 @@ static void w1_master_scan_slaves(struct
 		    !--slave->ttl) {
 			list_del(&slave->node);
 			w1_slave_detach(slave);
-			kfree(slave);
 		}
 	}
 	up(&master->mutex);
@@ -554,7 +522,6 @@ void w1_remove_master_device(struct w1_m
 	list_for_each_entry_safe(slave, next, &master->slist, node) {
 		list_del(&slave->node);
 		w1_slave_detach(slave);
-		kfree(slave);
 	}
 
 	sysfs_remove_group(&master->dev.kobj, &w1_master_defattr_group);
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -62,10 +62,8 @@ struct w1_reg_num
 
 struct w1_slave
 {
-	unsigned char		name[W1_MAXNAMELEN];
 	struct list_head	node;
 	struct w1_reg_num	reg_num;
-	atomic_t		refcnt;
 	u8			rom[9];
 	unsigned long		flags;
 	int			ttl;
@@ -73,7 +71,6 @@ struct w1_slave
 	struct w1_master	*master;
 	struct w1_family	*family;
 	struct device		dev;
-	struct completion	dev_released;
 
 	struct bin_attribute	attr_bin;
 	struct device_attribute	attr_name, attr_val;
Index: dtor/drivers/w1/w1_therm.c
===================================================================
--- dtor.orig/drivers/w1/w1_therm.c
+++ dtor/drivers/w1/w1_therm.c
@@ -41,24 +41,15 @@ static u8 bad_roms[][9] = {
 				{}
 			};
 
-static ssize_t w1_therm_read_name(struct device *, char *);
 static ssize_t w1_therm_read_temp(struct device *, char *);
 static ssize_t w1_therm_read_bin(struct kobject *, char *, loff_t, size_t);
 
 static struct w1_family_ops w1_therm_fops = {
-	.rname = &w1_therm_read_name,
 	.rbin = &w1_therm_read_bin,
 	.rval = &w1_therm_read_temp,
 	.rvalname = "temp1_input",
 };
 
-static ssize_t w1_therm_read_name(struct device *dev, char *buf)
-{
-	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
-
-	return sprintf(buf, "%s\n", sl->name);
-}
-
 static inline int w1_convert_temp(u8 rom[9])
 {
 	int t, h;
@@ -102,12 +93,8 @@ static ssize_t w1_therm_read_bin(struct 
 	u8 rom[9], crc, verdict;
 	int i, max_trying = 10;
 
-	atomic_inc(&sl->refcnt);
-	smp_mb__after_atomic_inc();
-	if (down_interruptible(&sl->master->mutex)) {
-		count = 0;
-		goto out_dec;
-	}
+	if (down_interruptible(&sl->master->mutex))
+		return 0;
 
 	if (off > W1_SLAVE_DATA_SIZE) {
 		count = 0;
@@ -178,9 +165,6 @@ static ssize_t w1_therm_read_bin(struct 
 	count += sprintf(buf + count, "t=%d\n", w1_convert_temp(rom));
 out:
 	up(&dev->mutex);
-out_dec:
-	smp_mb__before_atomic_inc();
-	atomic_dec(&sl->refcnt);
 
 	return count;
 }
Index: dtor/drivers/w1/w1_smem.c
===================================================================
--- dtor.orig/drivers/w1/w1_smem.c
+++ dtor/drivers/w1/w1_smem.c
@@ -35,24 +35,15 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
 MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, 64bit memory family.");
 
-static ssize_t w1_smem_read_name(struct device *, char *);
 static ssize_t w1_smem_read_val(struct device *, char *);
 static ssize_t w1_smem_read_bin(struct kobject *, char *, loff_t, size_t);
 
 static struct w1_family_ops w1_smem_fops = {
-	.rname = &w1_smem_read_name,
 	.rbin = &w1_smem_read_bin,
 	.rval = &w1_smem_read_val,
 	.rvalname = "id",
 };
 
-static ssize_t w1_smem_read_name(struct device *dev, char *buf)
-{
-	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
-
-	return sprintf(buf, "%s\n", sl->name);
-}
-
 static ssize_t w1_smem_read_val(struct device *dev, char *buf)
 {
 	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
@@ -72,11 +63,8 @@ static ssize_t w1_smem_read_bin(struct k
 					   struct w1_slave, dev);
 	int i;
 
-	atomic_inc(&sl->refcnt);
-	if (down_interruptible(&sl->master->mutex)) {
-		count = 0;
-		goto out_dec;
-	}
+	if (down_interruptible(&sl->master->mutex))
+		return 0;
 
 	if (off > W1_SLAVE_DATA_SIZE) {
 		count = 0;
@@ -92,8 +80,6 @@ static ssize_t w1_smem_read_bin(struct k
 
 out:
 	up(&sl->master->mutex);
-out_dec:
-	atomic_dec(&sl->refcnt);
 
 	return count;
 }
Index: dtor/drivers/w1/w1_family.c
===================================================================
--- dtor.orig/drivers/w1/w1_family.c
+++ dtor/drivers/w1/w1_family.c
@@ -30,7 +30,7 @@ static LIST_HEAD(w1_families);
 
 static int w1_check_family(struct w1_family *f)
 {
-	if (!f->fops->rname || !f->fops->rbin || !f->fops->rval || !f->fops->rvalname)
+	if (!f->fops->rbin || !f->fops->rval || !f->fops->rvalname)
 		return -EINVAL;
 
 	return 0;
Index: dtor/drivers/w1/w1_family.h
===================================================================
--- dtor.orig/drivers/w1/w1_family.h
+++ dtor/drivers/w1/w1_family.h
@@ -34,9 +34,7 @@
 
 struct w1_family_ops
 {
-	ssize_t (* rname)(struct device *, char *);
 	ssize_t (* rbin)(struct kobject *, char *, loff_t, size_t);
-
 	ssize_t (* rval)(struct device *, char *);
 	unsigned char rvalname[MAXNAMELEN];
 };
