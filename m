Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945938AbWBRBDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945938AbWBRBDG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945934AbWBRBDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 20:03:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44253 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1945938AbWBRBCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 20:02:42 -0500
Message-ID: <43F67274.80509@ce.jp.nec.com>
Date: Fri, 17 Feb 2006 20:03:48 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alasdair G Kergon <agk@redhat.com>
CC: Neil Brown <neilb@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sysfs representation of stacked devices (dm/md common)
References: <43F60F31.1030507@ce.jp.nec.com> <43F60F8C.8090207@ce.jp.nec.com> <20060217184435.GM12169@agk.surrey.redhat.com>
In-Reply-To: <20060217184435.GM12169@agk.surrey.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------070506020807000903080209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070506020807000903080209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alasdair,

Thank you for the comments.

Alasdair G Kergon wrote:
> Make sure you test this properly under low memory situations.

OK.

> dm_swap_table() mustn't block waiting for memory to become
> free (except in a controlled way e.g. with a mempool, but
> it would need more than that here).
> 
> Here, dm_swap_table() leads to kmalloc() getting called
> in sysfs_add_link().

I moved the sysfs_add_link() to the last part of dm_resume().
Directory creation/deletion are also moved in the alloc_dev/
free_dev function as kobject_register/unregister may allocate
memory.
I didn't change the part of removing symlink as it doesn't
allocate memory.

Do you think this is an acceptable approach?

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------070506020807000903080209
Content-Type: text/x-patch;
 name="stacked-device-representation-in-sysfs-2-dm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stacked-device-representation-in-sysfs-2-dm.patch"

Exporting stacked device relationship to sysfs (dm)

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

--- linux-2.6.15.orig/drivers/md/dm.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/drivers/md/dm.c	2006-02-17 16:27:38.000000000 -0500
@@ -98,6 +98,12 @@ struct mapped_device {
 	 */
 	struct super_block *frozen_sb;
 	struct block_device *frozen_bdev;
+
+	/*
+	 * sysfs deptree
+	 */
+	int sysfs_linked;
+	struct kobject slave_dir;
 };
 
 #define MIN_IOS 256
@@ -791,6 +797,7 @@ static struct mapped_device *alloc_dev(u
 	md->disk->private_data = md;
 	sprintf(md->disk->disk_name, "dm-%d", minor);
 	add_disk(md->disk);
+	stackdev_init(&md->slave_dir, &md->disk->kobj);
 
 	atomic_set(&md->pending, 0);
 	init_waitqueue_head(&md->wait);
@@ -815,6 +822,7 @@ static void free_dev(struct mapped_devic
 	free_minor(md->disk->first_minor);
 	mempool_destroy(md->tio_pool);
 	mempool_destroy(md->io_pool);
+	stackdev_clear(&md->slave_dir);
 	del_gendisk(md->disk);
 	put_disk(md->disk);
 	blk_put_queue(md->queue);
@@ -841,6 +849,42 @@ static void __set_size(struct mapped_dev
 	up(&md->frozen_bdev->bd_inode->i_sem);
 }
 
+/* create sysfs symlinks between mapped device and underlying devices */
+static int __link_device(struct mapped_device *md, struct dm_table *t)
+{
+	struct list_head *d, *devices;
+
+	if (md->sysfs_linked)
+		return 0;
+
+	devices = dm_table_get_devices(t);
+	for (d = devices->next; d != devices; d = d->next) {
+		struct dm_dev *dd = list_entry(d, struct dm_dev, list);
+		stackdev_link(dd->bdev, &md->slave_dir, &md->disk->kobj);
+	}
+
+	md->sysfs_linked = 1;
+	return 0;
+}
+
+/* remove sysfs symlinks between mapped device and underlying devices */
+static int __unlink_device(struct mapped_device *md, struct dm_table *t)
+{
+	struct list_head *d, *devices;
+
+	if (!md->sysfs_linked)
+		return 0;
+
+	devices = dm_table_get_devices(t);
+	for (d = devices->next; d != devices; d = d->next) {
+		struct dm_dev *dd = list_entry(d, struct dm_dev, list);
+		stackdev_unlink(dd->bdev, &md->slave_dir, &md->disk->kobj);
+	}
+
+	md->sysfs_linked = 0;
+	return 0;
+}
+
 static int __bind(struct mapped_device *md, struct dm_table *t)
 {
 	request_queue_t *q = md->queue;
@@ -873,6 +917,7 @@ static void __unbind(struct mapped_devic
 	write_lock(&md->map_lock);
 	md->map = NULL;
 	write_unlock(&md->map_lock);
+	__unlink_device(md, map);
 	dm_table_put(map);
 }
 
@@ -1139,6 +1184,8 @@ int dm_resume(struct mapped_device *md)
 
 	dm_table_unplug_all(map);
 
+	__link_device(md, map);
+
 	r = 0;
 
 out:

--------------070506020807000903080209--
