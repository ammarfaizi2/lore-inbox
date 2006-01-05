Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWAEA5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWAEA5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWAEAuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:1978 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750980AbWAEAtz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:55 -0500
Cc: gregkh@suse.de
Subject: [PATCH] Driver core: Make block devices create the proper symlink name
In-Reply-To: <11364221702858@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:31 -0800
Message-Id: <11364221712844@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver core: Make block devices create the proper symlink name

Block devices need to add the block device name to the symlink they put
in the device directory, otherwise multiple symlinks of the same name
can be created.  This matches the class system, which works the same
way, we just forgot to convert block at the same time.

Cc: Pete Zaitcev <zaitcev@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8218ef80932aa7e5e3d20c929a640c8d82133a9a
tree 73f2e7a972563cf536a7dae0fa02d99c4041d893
parent 874c6241b2e49e52680d32a50d4909c7768d5cb9
author Greg Kroah-Hartman <gregkh@suse.de> Tue, 13 Dec 2005 15:17:34 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:09 -0800

 fs/partitions/check.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index 7187a57..7881ce0 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -336,12 +336,31 @@ void add_partition(struct gendisk *disk,
 	disk->part[part-1] = p;
 }
 
+static char *make_block_name(struct gendisk *disk)
+{
+	char *name;
+	static char *block_str = "block:";
+	int size;
+
+	size = strlen(block_str) + strlen(disk->disk_name) + 1;
+	name = kmalloc(size, GFP_KERNEL);
+	if (!name)
+		return NULL;
+	strcpy(name, block_str);
+	strcat(name, disk->disk_name);
+	return name;
+}
+
 static void disk_sysfs_symlinks(struct gendisk *disk)
 {
 	struct device *target = get_device(disk->driverfs_dev);
 	if (target) {
+		char *disk_name = make_block_name(disk);
 		sysfs_create_link(&disk->kobj,&target->kobj,"device");
-		sysfs_create_link(&target->kobj,&disk->kobj,"block");
+		if (disk_name) {
+			sysfs_create_link(&target->kobj,&disk->kobj,disk_name);
+			kfree(disk_name);
+		}
 	}
 }
 
@@ -461,8 +480,12 @@ void del_gendisk(struct gendisk *disk)
 	devfs_remove_disk(disk);
 
 	if (disk->driverfs_dev) {
+		char *disk_name = make_block_name(disk);
 		sysfs_remove_link(&disk->kobj, "device");
-		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");
+		if (disk_name) {
+			sysfs_remove_link(&disk->driverfs_dev->kobj, disk_name);
+			kfree(disk_name);
+		}
 		put_device(disk->driverfs_dev);
 	}
 	kobject_uevent(&disk->kobj, KOBJ_REMOVE);

