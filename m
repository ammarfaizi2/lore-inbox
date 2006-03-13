Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWCMWNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWCMWNG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWCMWNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:13:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18886 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932498AbWCMWNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:13:04 -0500
Message-ID: <4415EED0.20208@ce.jp.nec.com>
Date: Mon, 13 Mar 2006 17:14:40 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Alasdair Kergon <agk@redhat.com>,
       Greg KH <gregkh@suse.de>, Neil Brown <neilb@suse.de>
CC: Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] dm/md dependency tree in sysfs: holders/slaves subdirectory
References: <4415EC4B.4010003@ce.jp.nec.com>
In-Reply-To: <4415EC4B.4010003@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------080909080901060903030707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080909080901060903030707
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch is part of dm/md dependency tree in sysfs.

With this patch, "slaves" and "holders" directories are
created in /sys/block/<disk> and
"holders" directory is created in /sys/block/<disk>/<partition>.

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------080909080901060903030707
Content-Type: text/x-patch;
 name="02-add_subdirs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-add_subdirs.patch"

Creating "slaves" and "holders" directories in /sys/block/<disk> and
creating "holders" directory under /sys/block/<disk>/<partition>

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

 fs/partitions/check.c |   27 +++++++++++++++++++++++++++
 include/linux/genhd.h |    3 +++
 2 files changed, 30 insertions(+)

--- linux-2.6.16-rc6.orig/include/linux/genhd.h	2006-03-11 17:12:55.000000000 -0500
+++ linux-2.6.16-rc6/include/linux/genhd.h	2006-03-13 11:24:13.000000000 -0500
@@ -78,6 +78,7 @@ struct hd_struct {
 	sector_t start_sect;
 	sector_t nr_sects;
 	struct kobject kobj;
+	struct kobject *holder_dir;
 	unsigned ios[2], sectors[2];	/* READs and WRITEs */
 	int policy, partno;
 };
@@ -114,6 +115,8 @@ struct gendisk {
 	int number;			/* more of the same */
 	struct device *driverfs_dev;
 	struct kobject kobj;
+	struct kobject *holder_dir;
+	struct kobject *slave_dir;
 
 	struct timer_rand_state *random;
 	int policy;
--- linux-2.6.16-rc6.orig/fs/partitions/check.c	2006-03-11 17:12:55.000000000 -0500
+++ linux-2.6.16-rc6/fs/partitions/check.c	2006-03-13 11:24:03.000000000 -0500
@@ -297,6 +297,25 @@ struct kobj_type ktype_part = {
 	.sysfs_ops	= &part_sysfs_ops,
 };
 
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
+
 void delete_partition(struct gendisk *disk, int part)
 {
 	struct hd_struct *p = disk->part[part-1];
@@ -310,6 +329,8 @@ void delete_partition(struct gendisk *di
 	p->ios[0] = p->ios[1] = 0;
 	p->sectors[0] = p->sectors[1] = 0;
 	devfs_remove("%s/part%d", disk->devfs_name, part);
+	if (p->holder_dir)
+		kobject_unregister(p->holder_dir);
 	kobject_unregister(&p->kobj);
 }
 
@@ -337,6 +358,7 @@ void add_partition(struct gendisk *disk,
 	p->kobj.parent = &disk->kobj;
 	p->kobj.ktype = &ktype_part;
 	kobject_register(&p->kobj);
+	partition_sysfs_add_subdir(p);
 	disk->part[part-1] = p;
 }
 
@@ -383,6 +405,7 @@ void register_disk(struct gendisk *disk)
 	if ((err = kobject_add(&disk->kobj)))
 		return;
 	disk_sysfs_symlinks(disk);
+ 	disk_sysfs_add_subdirs(disk);
 	kobject_uevent(&disk->kobj, KOBJ_ADD);
 
 	/* No minors to use for partitions */
@@ -483,6 +506,10 @@ void del_gendisk(struct gendisk *disk)
 
 	devfs_remove_disk(disk);
 
+	if (disk->holder_dir)
+		kobject_unregister(disk->holder_dir);
+	if (disk->holder_dir)
+		kobject_unregister(disk->slave_dir);
 	if (disk->driverfs_dev) {
 		char *disk_name = make_block_name(disk);
 		sysfs_remove_link(&disk->kobj, "device");

--------------080909080901060903030707--
