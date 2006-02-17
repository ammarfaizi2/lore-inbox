Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWBQSAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWBQSAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 13:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWBQSAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 13:00:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9358 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751139AbWBQSAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 13:00:37 -0500
Message-ID: <43F60F8C.8090207@ce.jp.nec.com>
Date: Fri, 17 Feb 2006 13:01:48 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>
CC: device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] sysfs representation of stacked devices (dm/md common)
References: <43F60F31.1030507@ce.jp.nec.com>
In-Reply-To: <43F60F31.1030507@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------090707000204020103000604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090707000204020103000604
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch provides common functions to create symlinks in sysfs
between stacked device and its slaves.

I placed functions in fs/block_dev.c as some of them are
privately used by bd_claim().
I'm not sure if it's better to put them in other files.

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------090707000204020103000604
Content-Type: text/x-patch;
 name="stacked-device-representation-in-sysfs-1-common.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stacked-device-representation-in-sysfs-1-common.patch"

Exporting stacked device relationship to sysfs (common functions)

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

--- linux-2.6.15.orig/include/linux/fs.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/include/linux/fs.h	2006-02-16 10:46:31.000000000 -0500
@@ -373,6 +373,7 @@ struct block_device {
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;
+	struct kobject		bd_holder_kobj;
 	struct block_device *	bd_contains;
 	unsigned		bd_block_size;
 	struct hd_struct *	bd_part;
@@ -1352,6 +1353,13 @@ extern int blkdev_put(struct block_devic
 extern int bd_claim(struct block_device *, void *);
 extern void bd_release(struct block_device *);
 
+/* stacked device linking */
+extern void stackdev_init(struct kobject *, struct kobject *);
+extern void stackdev_clear(struct kobject *);
+extern void stackdev_link(struct block_device *,
+				struct kobject *, struct kobject *);
+extern void stackdev_unlink(struct block_device *,
+				struct kobject *, struct kobject *);
 /* fs/char_dev.c */
 extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, const char *);
 extern int register_chrdev_region(dev_t, unsigned, const char *);
--- linux-2.6.15.orig/fs/block_dev.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/fs/block_dev.c	2006-02-17 10:06:17.000000000 -0500
@@ -443,6 +443,126 @@ void bd_forget(struct inode *inode)
 	spin_unlock(&bdev_lock);
 }
 
+/*
+ * kobject linking functions for stacked device
+ */
+
+static inline struct kobject * bdev_get_kobj(struct block_device *bdev)
+{
+	if (!bdev)
+		return NULL;
+	else if (bdev->bd_contains != bdev)
+		return kobject_get(&bdev->bd_part->kobj);
+	else
+		return kobject_get(&bdev->bd_disk->kobj);
+}
+
+static inline void add_symlink(struct kobject *from, struct kobject *to)
+{
+	if (!from || !to)
+		return;
+	sysfs_create_link(from, to, kobject_name(to));
+}
+
+static inline void del_symlink(struct kobject *from, struct kobject *to)
+{
+	if (!from || !to)
+		return;
+	sysfs_remove_link(from, kobject_name(to));
+}
+
+/* This is a mere directory in sysfs. No methods are needed. */
+static struct kobj_type bd_holder_ktype = {
+	.release	= NULL,
+	.sysfs_ops	= NULL,
+	.default_attrs	= NULL,
+};
+
+/*
+ * Set the bdev as possible slave of a stacked device
+ * (called from bd_claim)
+ */
+static inline void add_holder_object(struct block_device *bdev)
+{
+	struct kobject *kobj = &bdev->bd_holder_kobj;
+
+	kobj->ktype = &bd_holder_ktype;
+	kobject_set_name(kobj, "holders");
+	kobj->parent = bdev_get_kobj(bdev);
+	kobject_register(kobj);
+	kobject_put(kobj->parent);
+}
+
+/*
+ * Declare the bdev is no longer a possible slave of a stacked device
+ * (called from bd_release)
+ */
+static inline void del_holder_object(struct block_device *bdev)
+{
+	kobject_unregister(&bdev->bd_holder_kobj);
+}
+
+/* This is a mere directory in sysfs. No methods are needed. */
+static struct kobj_type bd_slave_ktype = {
+	.release	= NULL,
+	.sysfs_ops	= NULL,
+	.default_attrs	= NULL,
+};
+
+/* Set the bdev as stacked device */
+void stackdev_init(struct kobject *slave_dir, struct kobject *holder_dev)
+{
+	slave_dir->ktype = &bd_slave_ktype;
+	kobject_set_name(slave_dir, "slaves");
+	slave_dir->parent = holder_dev;
+
+	kobject_register(slave_dir);
+}
+EXPORT_SYMBOL(stackdev_init);
+
+/* Declare the bdev is no longer a stacked device */
+void stackdev_clear(struct kobject *slave_dir)
+{
+	kobject_unregister(slave_dir);
+}
+EXPORT_SYMBOL(stackdev_clear);
+
+/*
+ * Create symlinks between the holder and the slave of the stacked device.
+ * The slave devices needs to be bd_claim()-ed before.
+ */
+void stackdev_link(struct block_device *slave,
+			struct kobject *slave_dir, struct kobject *holder_dev)
+{
+	struct kobject *slave_dev, *holder_dir;
+
+	slave_dev = bdev_get_kobj(slave);
+
+	add_symlink(slave_dir, slave_dev);
+	add_symlink(&slave->bd_holder_kobj, holder_dev);
+
+	kobject_put(slave_dev);
+}
+EXPORT_SYMBOL(stackdev_link);
+
+/*
+ * Remove symlinks between the holder and the slave of the stacked device.
+ * This should be called before bd_release() the slave device.
+ */
+void stackdev_unlink(struct block_device *slave,
+			struct kobject *slave_dir, struct kobject *holder_dev)
+{
+	struct kobject *slave_dev, *holder_dir;
+
+	slave_dev = bdev_get_kobj(slave);
+
+	del_symlink(slave_dir, slave_dev);
+	del_symlink(&slave->bd_holder_kobj, holder_dev);
+
+	kobject_put(slave_dev);
+}
+EXPORT_SYMBOL(stackdev_unlink);
+
 int bd_claim(struct block_device *bdev, void *holder)
 {
 	int res;
@@ -450,7 +570,7 @@ int bd_claim(struct block_device *bdev, 
 
 	/* first decide result */
 	if (bdev->bd_holder == holder)
-		res = 0;	 /* already a holder */
+		res = 1;	 /* already a holder */
 	else if (bdev->bd_holder != NULL)
 		res = -EBUSY; 	 /* held by someone else */
 	else if (bdev->bd_contains == bdev)
@@ -469,10 +589,14 @@ int bd_claim(struct block_device *bdev, 
 		 * will be incremented twice, and bd_holder will
 		 * be set to bd_claim before being set to holder
 		 */
-		bdev->bd_contains->bd_holders ++;
 		bdev->bd_contains->bd_holder = bd_claim;
-		bdev->bd_holders++;
 		bdev->bd_holder = holder;
+		add_holder_object(bdev);
+	}
+	if (res >= 0) {
+		bdev->bd_contains->bd_holders ++;
+		bdev->bd_holders++;
+		res = 0;
 	}
 	spin_unlock(&bdev_lock);
 	return res;
@@ -485,8 +609,10 @@ void bd_release(struct block_device *bde
 	spin_lock(&bdev_lock);
 	if (!--bdev->bd_contains->bd_holders)
 		bdev->bd_contains->bd_holder = NULL;
-	if (!--bdev->bd_holders)
+	if (!--bdev->bd_holders) {
 		bdev->bd_holder = NULL;
+		del_holder_object(bdev);
+	}
 	spin_unlock(&bdev_lock);
 }

--------------090707000204020103000604--
