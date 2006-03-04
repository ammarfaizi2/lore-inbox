Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWCDA4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWCDA4k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 19:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWCDA4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 19:56:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53155 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750814AbWCDA4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 19:56:20 -0500
Message-ID: <4408E607.2010300@ce.jp.nec.com>
Date: Fri, 03 Mar 2006 19:57:43 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alasdair Kergon <agk@redhat.com>, Neil Brown <neilb@suse.de>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
CC: Lars Marowsky-Bree <lmb@suse.de>, akpm@osdl.org,
       device-mapper development <dm-devel@redhat.com>
Subject: [PATCH 3/6] bd_claim_by_kobject
References: <4408E33E.1080703@ce.jp.nec.com>
In-Reply-To: <4408E33E.1080703@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------080505040400050701020003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080505040400050701020003
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch is part of dm/md sysfs dependency tree.

This adds bd_claim_by_kobject() function which takes kobject as
additional signature of holder device and creates sysfs symlinks
between holder device and claimed device.
bd_release_from_kobject() is a counter part of bd_claim_by_kobject.

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------080505040400050701020003
Content-Type: text/x-patch;
 name="03-bd_claim_by_kobj.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03-bd_claim_by_kobj.patch"

Adding bd_claim_by_kobject() function which takes kobject as
additional signature of holder device and creates sysfs symlinks
between holder device and claimed device.
bd_release_from_kobject() is a counter part of bd_claim_by_kobject.

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

 fs/block_dev.c     |  196 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/fs.h |    3
 2 files changed, 197 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc5.orig/include/linux/fs.h	2006-02-27 00:09:35.000000000 -0500
+++ linux-2.6.16-rc5/include/linux/fs.h	2006-03-02 10:29:55.000000000 -0500
@@ -401,6 +401,7 @@ struct block_device {
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;
+	struct list_head	bd_holder_list;
 	struct block_device *	bd_contains;
 	unsigned		bd_block_size;
 	struct hd_struct *	bd_part;
@@ -1380,6 +1381,8 @@ extern int blkdev_get(struct block_devic
 extern int blkdev_put(struct block_device *);
 extern int bd_claim(struct block_device *, void *);
 extern void bd_release(struct block_device *);
+extern int bd_claim_by_kobject(struct block_device *, void *, struct kobject *);
+extern void bd_release_from_kobject(struct block_device *, struct kobject *);
 
 /* fs/char_dev.c */
 extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, const char *);
--- linux-2.6.16-rc5.orig/fs/block_dev.c	2006-02-27 00:09:35.000000000 -0500
+++ linux-2.6.16-rc5/fs/block_dev.c	2006-03-02 10:29:55.000000000 -0500
@@ -269,6 +269,7 @@ static void init_once(void * foo, kmem_c
 		sema_init(&bdev->bd_mount_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
+		INIT_LIST_HEAD(&bdev->bd_holder_list);
 		inode_init_once(&ei->vfs_inode);
 	}
 }
@@ -443,7 +444,179 @@ void bd_forget(struct inode *inode)
 	spin_unlock(&bdev_lock);
 }
 
-int bd_claim(struct block_device *bdev, void *holder)
+/*
+ * Functions for bd_claim_by_kobject / bd_release_from_kobject
+ *
+ *     If a kobject is passed to bd_claim_by_kobject() 
+ *     and the kobject has a parent directory,
+ *     following symlinks are created:
+ *        o from the kobject to the claimed bdev
+ *        o from "holders" directory of the bdev to the parent of the kobject
+ *     bd_release_from_kobject() removes these symlinks.
+ *
+ *     Example:
+ *        If /dev/dm-0 maps to /dev/sda, kobject corresponding to
+ *        /sys/block/dm-0/slaves is passed to bd_claim_by_kobject(), then:
+ *           /sys/block/dm-0/slaves/sda --> /sys/block/sda
+ *           /sys/block/sda/holders/dm-0 --> /sys/block/dm-0
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
+static inline struct kobject * bdev_get_holder(struct block_device *bdev)
+{
+	if (!bdev)
+		return NULL;
+	else if (bdev->bd_contains != bdev)
+		return kobject_get(bdev->bd_part->holder_dir);
+	else
+		return kobject_get(bdev->bd_disk->holder_dir);
+}
+
+static inline void add_symlink(struct kobject *from, struct kobject *to)
+{
+	if (!from || !to)
+		return;
+	kobject_get(from);
+	kobject_get(to);
+	sysfs_create_link(from, to, kobject_name(to));
+}
+
+static inline void del_symlink(struct kobject *from, struct kobject *to)
+{
+	if (!from || !to)
+		return;
+	sysfs_remove_link(from, kobject_name(to));
+	kobject_put(from);
+	kobject_put(to);
+}
+
+static inline int bd_claim_grab_dirs(struct block_device *bdev,
+			struct kobject *holder,
+			struct kobject **sdir, struct kobject **sdev,
+			struct kobject **hdir, struct kobject **hdev)
+{
+	*sdir = kobject_get(holder);
+	if (!*sdir)
+		return 0;
+
+	*hdev = kobject_get((*sdir)->parent);
+	if (!*hdev)
+		goto fail_put_sdir;
+
+	*sdev = bdev_get_kobj(bdev);
+	if (!*sdev)
+		goto fail_put_hdev;
+
+	*hdir = bdev_get_holder(bdev);
+	if (!*hdir)
+		goto fail_put_sdev;
+
+	return 1;
+
+fail_put_sdev:
+	kobject_put(*sdev);
+fail_put_hdev:
+	kobject_put(*hdev);
+fail_put_sdir:
+	kobject_put(*sdir);
+
+	return 0;
+}
+
+static inline void bd_claim_release_dirs(
+			struct kobject *sdir, struct kobject *sdev,
+			struct kobject *hdir, struct kobject *hdev)
+{
+	kobject_put(hdir);
+	kobject_put(sdev);
+	kobject_put(hdev);
+	kobject_put(sdir);
+}
+
+static void link_bd_holder(struct block_device *bdev, struct kobject *holder)
+{
+	struct kobject *sdir, *sdev, *hdir, *hdev;
+
+	if (bd_claim_grab_dirs(bdev, holder, &sdir, &sdev, &hdir, &hdev)) {
+		add_symlink(sdir, sdev);
+		add_symlink(hdir, hdev);
+		bd_claim_release_dirs(sdir, sdev, hdir, hdev);
+	}
+
+	return;
+}
+
+static void unlink_bd_holder(struct block_device *bdev, struct kobject *holder)
+{
+	struct kobject *sdir, *sdev, *hdir, *hdev;
+
+	if (bd_claim_grab_dirs(bdev, holder, &sdir, &sdev, &hdir, &hdev)) {
+		del_symlink(sdir, sdev);
+		del_symlink(hdir, hdev);
+		bd_claim_release_dirs(sdir, sdev, hdir, hdev);
+	}
+}
+
+/* bd_holder_list is protected by bdev_lock */
+struct bd_holder {
+	struct list_head list;	/* chain of holders of the bdev */
+	int count;		/* references from the holder */
+	struct kobject *kobj;	/* holder kobject */
+};
+
+static int add_bd_holder(struct block_device *bdev, struct kobject *kobj)
+{
+        struct bd_holder *bo;
+
+	list_for_each_entry(bo, &bdev->bd_holder_list, list) {
+		if (bo->kobj == kobj) {
+			bo->count++;
+			return 0;
+		}
+	}
+
+	bo = kmalloc(sizeof(*bo), GFP_KERNEL);
+	if (!bo)
+		return -ENOMEM;
+
+	bo->count = 1;
+	bo->kobj = kobj;
+	list_add_tail(&bo->list, &bdev->bd_holder_list);
+	link_bd_holder(bdev, kobj);
+
+	return 0;
+}
+
+static int del_bd_holder(struct block_device *bdev, struct kobject *kobj)
+{
+	struct bd_holder *bo;
+
+	list_for_each_entry(bo, &bdev->bd_holder_list, list) {
+		if (bo->kobj == kobj) {
+			bo->count--;
+			BUG_ON(bo->count < 0);
+			if (!bo->count) {
+				unlink_bd_holder(bdev, kobj);
+				list_del(&bo->list);
+				kfree(bo);
+			}
+			break;
+		}
+	}
+
+	return 0;
+}
+
+int bd_claim_by_kobject(struct block_device *bdev, void *holder, struct kobject *kobj)
 {
 	int res;
 	spin_lock(&bdev_lock);
@@ -464,6 +637,9 @@ int bd_claim(struct block_device *bdev, 
 		res = 0;	 /* is a partition of an un-held device */
 
 	/* now impose change */
+	if (res == 0 && kobj)
+		res = add_bd_holder(bdev, kobj);
+
 	if (res==0) {
 		/* note that for a whole device bd_holders
 		 * will be incremented twice, and bd_holder will
@@ -478,11 +654,20 @@ int bd_claim(struct block_device *bdev, 
 	return res;
 }
 
+EXPORT_SYMBOL(bd_claim_by_kobject);
+
+int bd_claim(struct block_device *bdev, void *holder)
+{
+	return bd_claim_by_kobject(bdev, holder, NULL);
+}
+
 EXPORT_SYMBOL(bd_claim);
 
-void bd_release(struct block_device *bdev)
+void bd_release_from_kobject(struct block_device *bdev, struct kobject *kobj)
 {
 	spin_lock(&bdev_lock);
+	if (kobj)
+		del_bd_holder(bdev, kobj);
 	if (!--bdev->bd_contains->bd_holders)
 		bdev->bd_contains->bd_holder = NULL;
 	if (!--bdev->bd_holders)
@@ -490,6 +675,13 @@ void bd_release(struct block_device *bde
 	spin_unlock(&bdev_lock);
 }
 
+EXPORT_SYMBOL(bd_release_from_kobject);
+
+void bd_release(struct block_device *bdev)
+{
+	bd_release_from_kobject(bdev, NULL);
+}
+
 EXPORT_SYMBOL(bd_release);
 
 /*

--------------080505040400050701020003--
