Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030609AbWJDMTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030609AbWJDMTH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 08:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030689AbWJDMTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 08:19:06 -0400
Received: from havoc.gtf.org ([69.61.125.42]:27530 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030609AbWJDMTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 08:19:04 -0400
Date: Wed, 4 Oct 2006 08:19:00 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/partitions/check: add sysfs error handling
Message-ID: <20061004121900.GA23988@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Handle errors thrown in disk_sysfs_symlinks(), and propagate back
to caller.

The callers and associated functions don't do a real good job
of handling kobject errors anyway (add_partition, register_disk,
rescan_partitions), so this should do until something better comes
along.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 fs/partitions/check.c |   50 ++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index 51c6a74..6fb4b61 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -376,18 +376,48 @@ static char *make_block_name(struct gend
 	return name;
 }
 
-static void disk_sysfs_symlinks(struct gendisk *disk)
+static int disk_sysfs_symlinks(struct gendisk *disk)
 {
 	struct device *target = get_device(disk->driverfs_dev);
+	int err;
+	char *disk_name = NULL;
+
 	if (target) {
-		char *disk_name = make_block_name(disk);
-		sysfs_create_link(&disk->kobj,&target->kobj,"device");
-		if (disk_name) {
-			sysfs_create_link(&target->kobj,&disk->kobj,disk_name);
-			kfree(disk_name);
+		disk_name = make_block_name(disk);
+		if (!disk_name) {
+			err = -ENOMEM;
+			goto err_out;
 		}
+
+		err = sysfs_create_link(&disk->kobj, &target->kobj, "device");
+		if (err)
+			goto err_out_disk_name;
+
+		err = sysfs_create_link(&target->kobj, &disk->kobj, disk_name);
+		if (err)
+			goto err_out_dev_link;
 	}
-	sysfs_create_link(&disk->kobj, &block_subsys.kset.kobj, "subsystem");
+
+	err = sysfs_create_link(&disk->kobj, &block_subsys.kset.kobj,
+				"subsystem");
+	if (err)
+		goto err_out_disk_name_lnk;
+
+	kfree(disk_name);
+
+	return 0;
+
+err_out_disk_name_lnk:
+	if (target) {
+		sysfs_remove_link(&target->kobj, disk_name);
+err_out_dev_link:
+		sysfs_remove_link(&disk->kobj, "device");
+err_out_disk_name:
+		kfree(disk_name);
+err_out:
+		put_device(target);
+	}
+	return err;
 }
 
 /* Not exported, helper to add_disk(). */
@@ -406,7 +436,11 @@ void register_disk(struct gendisk *disk)
 		*s = '!';
 	if ((err = kobject_add(&disk->kobj)))
 		return;
-	disk_sysfs_symlinks(disk);
+	err = disk_sysfs_symlinks(disk);
+	if (err) {
+		kobject_del(&disk->kobj);
+		return;
+	}
  	disk_sysfs_add_subdirs(disk);
 
 	/* No minors to use for partitions */
