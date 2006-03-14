Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752315AbWCNRUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbWCNRUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752312AbWCNRUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:20:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31660 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752305AbWCNRUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:20:16 -0500
Message-ID: <4416FBA9.8040009@ce.jp.nec.com>
Date: Tue, 14 Mar 2006 12:21:45 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alasdair Kergon <agk@redhat.com>, Greg KH <gregkh@suse.de>,
       Neil Brown <neilb@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] dm/md dependency tree in sysfs: holders/slaves subdirectory
References: <4415EC4B.4010003@ce.jp.nec.com> <4415EED0.20208@ce.jp.nec.com>
In-Reply-To: <4415EED0.20208@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------050304050800000706020800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050304050800000706020800
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi Andrew,

Attached patch makes sysfs symlinking related codes conditional
on CONFIG_SYSFS.
Could you please replace
dm-md-dependency-tree-in-sysfs-holders-slaves-subdirectory.patch
with this?

Jun'ichi Nomura wrote:
> This patch is part of dm/md dependency tree in sysfs.
> 
> With this patch, "slaves" and "holders" directories are
> created in /sys/block/<disk> and
> "holders" directory is created in /sys/block/<disk>/<partition>.

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------050304050800000706020800
Content-Type: text/x-patch;
 name="02-add_subdirs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-add_subdirs.patch"

Creating "slaves" and "holders" directories in /sys/block/<disk> and
creating "holders" directory under /sys/block/<disk>/<partition>

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

 fs/partitions/check.c |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/genhd.h |    7 +++++++
 2 files changed, 43 insertions(+)

--- linux-2.6.16-rc6.orig/include/linux/genhd.h	2006-03-11 17:12:55.000000000 -0500
+++ linux-2.6.16-rc6/include/linux/genhd.h	2006-03-14 08:09:51.000000000 -0500
@@ -78,6 +78,9 @@ struct hd_struct {
 	sector_t start_sect;
 	sector_t nr_sects;
 	struct kobject kobj;
+#ifdef CONFIG_SYSFS
+	struct kobject *holder_dir;
+#endif
 	unsigned ios[2], sectors[2];	/* READs and WRITEs */
 	int policy, partno;
 };
@@ -114,6 +117,10 @@ struct gendisk {
 	int number;			/* more of the same */
 	struct device *driverfs_dev;
 	struct kobject kobj;
+#ifdef CONFIG_SYSFS
+	struct kobject *holder_dir;
+	struct kobject *slave_dir;
+#endif
 
 	struct timer_rand_state *random;
 	int policy;
--- linux-2.6.16-rc6.orig/fs/partitions/check.c	2006-03-14 08:09:24.000000000 -0500
+++ linux-2.6.16-rc6/fs/partitions/check.c	2006-03-14 11:49:15.000000000 -0500
@@ -297,6 +297,30 @@ struct kobj_type ktype_part = {
 	.sysfs_ops	= &part_sysfs_ops,
 };
 
+#ifdef CONFIG_SYSFS
+static inline void partition_sysfs_add_subdir(struct hd_struct *p)
+{
+	struct kobject *k;
+
+	k = kobject_get(&p->kobj);
+	p->holder_dir = kobject_add_dir(k, "holders");
+	kobject_put(k);
+}
+
+static inline void disk_sysfs_add_subdirs(struct gendisk *disk)
+{
+	struct kobject *k;
+
+	k = kobject_get(&disk->kobj);
+	disk->holder_dir = kobject_add_dir(k, "holders");
+	disk->slave_dir = kobject_add_dir(k, "slaves");
+	kobject_put(k);
+}
+#else
+#define partition_sysfs_add_subdir(x)	do { } while (0)
+#define disk_sysfs_add_subdirs(x)	do { } while (0)
+#endif
+
 void delete_partition(struct gendisk *disk, int part)
 {
 	struct hd_struct *p = disk->part[part-1];
@@ -310,6 +334,10 @@ void delete_partition(struct gendisk *di
 	p->ios[0] = p->ios[1] = 0;
 	p->sectors[0] = p->sectors[1] = 0;
 	devfs_remove("%s/part%d", disk->devfs_name, part);
+#ifdef CONFIG_SYSFS
+	if (p->holder_dir)
+		kobject_unregister(p->holder_dir);
+#endif
 	kobject_unregister(&p->kobj);
 }
 
@@ -337,6 +365,7 @@ void add_partition(struct gendisk *disk,
 	p->kobj.parent = &disk->kobj;
 	p->kobj.ktype = &ktype_part;
 	kobject_register(&p->kobj);
+	partition_sysfs_add_subdir(p);
 	disk->part[part-1] = p;
 }
 
@@ -383,6 +412,7 @@ void register_disk(struct gendisk *disk)
 	if ((err = kobject_add(&disk->kobj)))
 		return;
 	disk_sysfs_symlinks(disk);
+ 	disk_sysfs_add_subdirs(disk);
 	kobject_uevent(&disk->kobj, KOBJ_ADD);
 
 	/* No minors to use for partitions */
@@ -483,6 +513,12 @@ void del_gendisk(struct gendisk *disk)
 
 	devfs_remove_disk(disk);
 
+#ifdef CONFIG_SYSFS
+	if (disk->holder_dir)
+		kobject_unregister(disk->holder_dir);
+	if (disk->slave_dir)
+		kobject_unregister(disk->slave_dir);
+#endif
 	if (disk->driverfs_dev) {
 		char *disk_name = make_block_name(disk);
 		sysfs_remove_link(&disk->kobj, "device");

--------------050304050800000706020800--
