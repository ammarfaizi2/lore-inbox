Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWCMWNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWCMWNw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWCMWNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:13:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50630 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932495AbWCMWNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:13:50 -0500
Message-ID: <4415EEFD.6010002@ce.jp.nec.com>
Date: Mon, 13 Mar 2006 17:15:25 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Alasdair Kergon <agk@redhat.com>,
       Greg KH <gregkh@suse.de>, Neil Brown <neilb@suse.de>
CC: Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] dm/md dependency tree in sysfs: bd_claim_by_kobject
References: <4415EC4B.4010003@ce.jp.nec.com>
In-Reply-To: <4415EC4B.4010003@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------080009020706080400080500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080009020706080400080500
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch is part of dm/md dependency tree in sysfs.

This adds bd_claim_by_kobject() function which takes kobject as
additional signature of holder device and creates sysfs symlinks
between holder device and claimed device.
bd_release_from_kobject() is a counter part of bd_claim_by_kobject.

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------080009020706080400080500
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

 fs/block_dev.c     |  206 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |    3
 2 files changed, 209 insertions(+)

--- linux-2.6.16-rc6.orig/include/linux/fs.h	2006-03-11 17:12:55.000000000 -0500
+++ linux-2.6.16-rc6/include/linux/fs.h	2006-03-13 11:24:18.000000000 -0500
@@ -402,6 +402,7 @@ struct block_device {
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;
+	struct list_head	bd_holder_list;
 	struct block_device *	bd_contains;
 	unsigned		bd_block_size;
 	struct hd_struct *	bd_part;
@@ -1381,6 +1382,8 @@ extern int blkdev_get(struct block_devic
 extern int blkdev_put(struct block_device *);
 extern int bd_claim(struct block_device *, void *);
 extern void bd_release(struct block_device *);
+extern int bd_claim_by_kobject(struct block_device *, void *, struct kobject *);
+extern void bd_release_from_kobject(struct block_device *, struct kobject *);
 
 /* fs/char_dev.c */
 extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, const char *);
--- linux-2.6.16-rc6.orig/fs/block_dev.c	2006-03-11 17:12:55.000000000 -0500
+++ linux-2.6.16-rc6/fs/block_dev.c	2006-03-13 11:24:18.000000000 -0500
@@ -269,6 +269,7 @@ static void init_once(void * foo, kmem_c
 		sema_init(&bdev->bd_mount_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
+		INIT_LIST_HEAD(&bdev->bd_holder_list);
 		inode_init_once(&ei->vfs_inode);
 	}
 }
@@ -493,6 +494,211 @@ void bd_release(struct block_device *bde
 EXPORT_SYMBOL(bd_release);
 
 /*
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
+
+static inline struct kobject * bdev_get_kobj(struct block_device *bdev)
+{
+	if (bdev->bd_contains != bdev)
+		return kobject_get(&bdev->bd_part->kobj);
+	else
+		return kobject_get(&bdev->bd_disk->kobj);
+}
+
+static inline struct kobject * bdev_get_holder(struct block_device *bdev)
+{
+	if (bdev->bd_contains != bdev)
+		return kobject_get(bdev->bd_part->holder_dir);
+	else
+		return kobject_get(bdev->bd_disk->holder_dir);
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
+/* bd_holder_list is protected by bdev_lock */
+struct bd_holder {
+	struct list_head list;	/* chain of holders of the bdev */
+	int count;		/* references from the holder */
+	struct kobject *sdir;	/* holder object, e.g. "/block/dm-0/slaves" */
+	struct kobject *hdev;	/* e.g. "/block/dm-0" */
+	struct kobject *hdir;	/* e.g. "/block/sda/holders" */
+	struct kobject *sdev;	/* e.g. "/block/sda" */
+};
+
+static inline int bd_holder_grab_dirs(struct block_device *bdev,
+			struct bd_holder *bo)
+{
+	if (!bdev || !bo)
+		return 0;
+
+	bo->sdir = kobject_get(bo->sdir);
+	if (!bo->sdir)
+		return 0;
+
+	bo->hdev = kobject_get(bo->sdir->parent);
+	if (!bo->hdev)
+		goto fail_put_sdir;
+
+	bo->sdev = bdev_get_kobj(bdev);
+	if (!bo->sdev)
+		goto fail_put_hdev;
+
+	bo->hdir = bdev_get_holder(bdev);
+	if (!bo->hdir)
+		goto fail_put_sdev;
+
+	return 1;
+
+fail_put_sdev:
+	kobject_put(bo->sdev);
+fail_put_hdev:
+	kobject_put(bo->hdev);
+fail_put_sdir:
+	kobject_put(bo->sdir);
+
+	return 0;
+}
+
+static inline void bd_holder_release_dirs(struct bd_holder *bo)
+{
+	kobject_put(bo->hdir);
+	kobject_put(bo->sdev);
+	kobject_put(bo->hdev);
+	kobject_put(bo->sdir);
+}
+
+static struct bd_holder *alloc_bd_holder(struct kobject *kobj)
+{
+	struct bd_holder *bo;
+
+	bo = kzalloc(sizeof(*bo), GFP_KERNEL);
+	if (!bo)
+		return NULL;
+
+	bo->count = 1;
+	bo->sdir = kobj;
+
+	return bo;
+}
+
+static void free_bd_holder(struct bd_holder *bo)
+{
+	kfree(bo);
+}
+
+static int add_bd_holder(struct block_device *bdev, struct bd_holder *bo)
+{
+        struct bd_holder *tmp;
+
+	if (!bo)
+		return 0;
+
+	list_for_each_entry(tmp, &bdev->bd_holder_list, list) {
+		if (tmp->sdir == bo->sdir) {
+			tmp->count++;
+			return 0;
+		}
+	}
+
+	if (!bd_holder_grab_dirs(bdev, bo))
+		return 0;
+
+	add_symlink(bo->sdir, bo->sdev);
+	add_symlink(bo->hdir, bo->hdev);
+	list_add_tail(&bo->list, &bdev->bd_holder_list);
+	return 1;
+}
+
+static struct bd_holder *del_bd_holder(struct block_device *bdev,
+					struct kobject *kobj)
+{
+	struct bd_holder *bo;
+
+	list_for_each_entry(bo, &bdev->bd_holder_list, list) {
+		if (bo->sdir == kobj) {
+			bo->count--;
+			BUG_ON(bo->count < 0);
+			if (!bo->count) {
+				list_del(&bo->list);
+				del_symlink(bo->sdir, bo->sdev);
+				del_symlink(bo->hdir, bo->hdev);
+				bd_holder_release_dirs(bo);
+				return bo;
+			}
+			break;
+		}
+	}
+
+	return NULL;
+}
+
+int bd_claim_by_kobject(struct block_device *bdev, void *holder,
+			struct kobject *kobj)
+{
+	int res = -EBUSY;
+	struct bd_holder *bo;
+
+	if (!kobj)
+		return -EINVAL;
+
+	bo = alloc_bd_holder(kobj);
+	if (!bo)
+		return -ENOMEM;
+
+	down(&bdev->bd_sem);
+	res = bd_claim(bdev, holder);
+	if (res || !add_bd_holder(bdev, bo))
+		free_bd_holder(bo);
+	up(&bdev->bd_sem);
+
+	return res;
+}
+
+EXPORT_SYMBOL(bd_claim_by_kobject);
+
+void bd_release_from_kobject(struct block_device *bdev, struct kobject *kobj)
+{
+	struct bd_holder *bo;
+
+	if (!kobj)
+		return;
+
+	down(&bdev->bd_sem);
+	bd_release(bdev);
+	if ((bo = del_bd_holder(bdev, kobj)))
+		free_bd_holder(bo);
+	up(&bdev->bd_sem);
+}
+
+EXPORT_SYMBOL(bd_release_from_kobject);
+
+/*
  * Tries to open block device by device number.  Use it ONLY if you
  * really do not have anything better - i.e. when you are behind a
  * truly sucky interface and all you are given is a device number.  _Never_

--------------080009020706080400080500--
