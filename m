Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWCNRUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWCNRUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752307AbWCNRUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:20:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27052 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751367AbWCNRUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:20:15 -0500
Message-ID: <4416FBA0.6000504@ce.jp.nec.com>
Date: Tue, 14 Mar 2006 12:21:36 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: agk@redhat.com, gregkh@suse.de, neilb@suse.de, lmb@suse.de,
       dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] dm/md dependency tree in sysfs: bd_claim_by_kobject
References: <4415EC4B.4010003@ce.jp.nec.com>	<4415EEFD.6010002@ce.jp.nec.com> <20060313182730.335bc6c8.akpm@osdl.org>
In-Reply-To: <20060313182730.335bc6c8.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000907030202010407080903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000907030202010407080903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

Thank you for the review and comments.

Attached patch reflects your comments.
The patch also reflects the other comment regarding uninlining
bd_claim_by_disk() and bd_release_from_disk().

Could you please replace
dm-md-dependency-tree-in-sysfs-bd_claim_by_kobject.patch with this
and drop dm-md-dependency-tree-in-sysfs-bd_claim_by_disk.patch?
Or am I better to send a patch relative to the previous ones?


Andrew Morton wrote:
> Bear in mind that sysfs is Kconfigurable (CONFIG_SYSFS).  If possible,
> newly-added code which doesn't make sense without sysfs should not appear
> in a CONFIG_SYSFS=n vmlinux.

OK, fixed.
CONFIG_SYSFS=n built ok and confirmed no symbols related to
my sysfs symlinking exist in it.

>>+static inline struct kobject * bdev_get_kobj(struct block_device *bdev)
> 
> pet-peeve: The space after asterisk has no use.

Fixed.

>>+static inline struct kobject * bdev_get_holder(struct block_device *bdev)
>>+static inline void add_symlink(struct kobject *from, struct kobject *to)
>>+static inline void del_symlink(struct kobject *from, struct kobject *to)
>>+static inline int bd_holder_grab_dirs(struct block_device *bdev,
>>+static inline void bd_holder_release_dirs(struct bd_holder *bo)
> 
> I suposse the inlines are OK, given that we "know" that there's only a
> single callsite.  But recent gcc's take care of that automatically.

I removed 'inline's from them and let it cared by gcc.

>>+static int add_bd_holder(struct block_device *bdev, struct bd_holder *bo)
>>+{
>>+        struct bd_holder *tmp;
>>+
>>+	if (!bo)
>>+		return 0;
> 
> whitespace went wild there.

Fixed. Thank you.

> Some comments which describe what these do, what they return and why they
> return it would be nice.

Comments are added for non-trivial functions and a structure.

>>+}
>>+
>>+EXPORT_SYMBOL(bd_claim_by_kobject);
> 
> I don't think the blank line before the EXPORT_SYMBOL() does anything useful.

Sure. They just followed the other exports in the file.
Fixed.

> EXPORT_SYMBOL_GPL() might be preferred.

I changed them to EXPORT_SYMBOL_GPL().

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------000907030202010407080903
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

 fs/block_dev.c     |  297 +++++++++++++++++++++++++++++++++++++++++++++++++++++ include/linux/fs.h |   10 +
 2 files changed, 307 insertions(+)

--- linux-2.6.16-rc6.orig/include/linux/fs.h	2006-03-11 17:12:55.000000000 -0500
+++ linux-2.6.16-rc6/include/linux/fs.h	2006-03-14 08:01:33.000000000 -0500
@@ -402,6 +402,9 @@ struct block_device {
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;
+#ifdef CONFIG_SYSFS
+	struct list_head	bd_holder_list;
+#endif
 	struct block_device *	bd_contains;
 	unsigned		bd_block_size;
 	struct hd_struct *	bd_part;
@@ -1381,6 +1384,13 @@ extern int blkdev_get(struct block_devic
 extern int blkdev_put(struct block_device *);
 extern int bd_claim(struct block_device *, void *);
 extern void bd_release(struct block_device *);
+#ifdef CONFIG_SYSFS
+extern int bd_claim_by_disk(struct block_device *, void *, struct gendisk *);
+extern void bd_release_from_disk(struct block_device *, struct gendisk *);
+#else
+#define bd_claim_by_disk(bdev, holder, disk)	bd_claim(bdev, holder)
+#define bd_release_from_disk(bdev, disk)	bd_release(bdev)
+#endif
 
 /* fs/char_dev.c */
 extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, const char *);
--- linux-2.6.16-rc6.orig/fs/block_dev.c	2006-03-11 17:12:55.000000000 -0500
+++ linux-2.6.16-rc6/fs/block_dev.c	2006-03-14 11:46:47.000000000 -0500
@@ -269,6 +269,9 @@ static void init_once(void * foo, kmem_c
 		sema_init(&bdev->bd_mount_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
+#ifdef CONFIG_SYSFS
+		INIT_LIST_HEAD(&bdev->bd_holder_list);
+#endif
 		inode_init_once(&ei->vfs_inode);
 	}
 }
@@ -492,6 +495,300 @@ void bd_release(struct block_device *bde
 
 EXPORT_SYMBOL(bd_release);
 
+#ifdef CONFIG_SYSFS
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
+static struct kobject *bdev_get_kobj(struct block_device *bdev)
+{
+	if (bdev->bd_contains != bdev)
+		return kobject_get(&bdev->bd_part->kobj);
+	else
+		return kobject_get(&bdev->bd_disk->kobj);
+}
+
+static struct kobject *bdev_get_holder(struct block_device *bdev)
+{
+	if (bdev->bd_contains != bdev)
+		return kobject_get(bdev->bd_part->holder_dir);
+	else
+		return kobject_get(bdev->bd_disk->holder_dir);
+}
+
+static void add_symlink(struct kobject *from, struct kobject *to)
+{
+	if (!from || !to)
+		return;
+	sysfs_create_link(from, to, kobject_name(to));
+}
+
+static void del_symlink(struct kobject *from, struct kobject *to)
+{
+	if (!from || !to)
+		return;
+	sysfs_remove_link(from, kobject_name(to));
+}
+
+/*
+ * 'struct bd_holder' contains pointers to kobjects symlinked by
+ * bd_claim_by_kobject.
+ * It's connected to bd_holder_list which is protected by bdev->bd_sem.
+ */
+struct bd_holder {
+	struct list_head list;	/* chain of holders of the bdev */
+	int count;		/* references from the holder */
+	struct kobject *sdir;	/* holder object, e.g. "/block/dm-0/slaves" */
+	struct kobject *hdev;	/* e.g. "/block/dm-0" */
+	struct kobject *hdir;	/* e.g. "/block/sda/holders" */
+	struct kobject *sdev;	/* e.g. "/block/sda" */
+};
+
+/*
+ * Get references of related kobjects at once.
+ * Returns 1 on success. 0 on failure.
+ *
+ * Should call bd_holder_release_dirs() after successful use.
+ */
+static int bd_holder_grab_dirs(struct block_device *bdev,
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
+/* Put references of related kobjects at once. */
+static void bd_holder_release_dirs(struct bd_holder *bo)
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
+/**
+ * add_bd_holder - create sysfs symlinks for bd_claim() relationship
+ *
+ * @bdev:	block device to be bd_claimed
+ * @bo:		preallocated and initialized by alloc_bd_holder()
+ *
+ * If there is no matching entry with @bo in @bdev->bd_holder_list,
+ * add @bo to the list, create symlinks.
+ *
+ * Returns 1 if @bo was added to the list.
+ * Returns 0 if @bo wasn't used by any reason and should be freed.
+ */
+static int add_bd_holder(struct block_device *bdev, struct bd_holder *bo)
+{
+	struct bd_holder *tmp;
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
+/**
+ * del_bd_holder - delete sysfs symlinks for bd_claim() relationship
+ *
+ * @bdev:	block device to be bd_claimed
+ * @kobj:	holder's kobject
+ *
+ * If there is matching entry with @kobj in @bdev->bd_holder_list
+ * and no other bd_claim() from the same kobject,
+ * remove the struct bd_holder from the list, delete symlinks for it.
+ *
+ * Returns a pointer to the struct bd_holder when it's removed from the list
+ * and ready to be freed.
+ * Returns NULL if matching claim isn't found or there is other bd_claim()
+ * by the same kobject.
+ */
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
+/**
+ * bd_claim_by_kobject - bd_claim() with additional kobject signature 
+ *
+ * @bdev:	block device to be claimed
+ * @holder:	holder's signature
+ * @kobj:	holder's kobject
+ *
+ * Do bd_claim() and if it succeeds, create sysfs symlinks between
+ * the bdev and the holder's kobject.
+ * Use bd_release_from_kobject() when relesing the claimed bdev.
+ *
+ * Returns 0 on success. (same as bd_claim())
+ * Returns errno on failure.
+ */
+static int bd_claim_by_kobject(struct block_device *bdev, void *holder,
+				struct kobject *kobj)
+{
+	int res;
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
+/**
+ * bd_release_from_kobject - bd_release() with additional kobject signature
+ *
+ * @bdev:	block device to be released
+ * @kobj:	holder's kobject
+ *
+ * Do bd_release() and remove sysfs symlinks created by bd_claim_by_kobject().
+ */
+static void bd_release_from_kobject(struct block_device *bdev,
+					struct kobject *kobj)
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
+/**
+ * bd_claim_by_disk - wrapper function for bd_claim_by_kobject()
+ *
+ * @bdev:	block device to be claimed
+ * @holder:	holder's signature
+ * @disk:	holder's gendisk
+ *
+ * Call bd_claim_by_kobject() with getting @disk->slave_dir.
+ */
+int bd_claim_by_disk(struct block_device *bdev, void *holder,
+			struct gendisk *disk)
+{
+	return bd_claim_by_kobject(bdev, holder, kobject_get(disk->slave_dir));
+}
+EXPORT_SYMBOL_GPL(bd_claim_by_disk);
+
+/**
+ * bd_release_from_disk - wrapper function for bd_release_from_kobject()
+ *
+ * @bdev:	block device to be claimed
+ * @disk:	holder's gendisk
+ *
+ * Call bd_release_from_kobject() and put @disk->slave_dir.
+ */
+void bd_release_from_disk(struct block_device *bdev, struct gendisk *disk)
+{
+	bd_release_from_kobject(bdev, disk->slave_dir);
+	kobject_put(disk->slave_dir);
+}
+EXPORT_SYMBOL_GPL(bd_release_from_disk);
+#endif
+
 /*
  * Tries to open block device by device number.  Use it ONLY if you
  * really do not have anything better - i.e. when you are behind a

--------------000907030202010407080903--
