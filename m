Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVFUELE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVFUELE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVFUCrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:47:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:21476 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261679AbVFTW7m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:42 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] sysfs: (driver/block) if show/store is missing return -EIO
In-Reply-To: <111930836153@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:21 -0700
Message-Id: <11193083611124@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sysfs: (driver/block) if show/store is missing return -EIO

sysfs: fix drivers/block so if an attribute doesn't implement
       show or store method read/write will return -EIO
       instead of 0 or -EINVAL.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6c1852a08e444a2e66367352a99c0e93c8bf3e97
tree ffa075f75b7eb0e5b1399aeb8e34e6cf9a631a10
parent fc7e4828995d8c9e4c9597f8a19179e4ab53f73e
author Dmitry Torokhov <dtor_core@ameritech.net> Fri, 29 Apr 2005 01:26:06 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:03 -0700

 drivers/block/as-iosched.c       |    4 ++--
 drivers/block/cfq-iosched.c      |    4 ++--
 drivers/block/deadline-iosched.c |    4 ++--
 drivers/block/genhd.c            |    2 +-
 drivers/block/ll_rw_blk.c        |    4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/as-iosched.c b/drivers/block/as-iosched.c
--- a/drivers/block/as-iosched.c
+++ b/drivers/block/as-iosched.c
@@ -2044,7 +2044,7 @@ as_attr_show(struct kobject *kobj, struc
 	struct as_fs_entry *entry = to_as(attr);
 
 	if (!entry->show)
-		return 0;
+		return -EIO;
 
 	return entry->show(e->elevator_data, page);
 }
@@ -2057,7 +2057,7 @@ as_attr_store(struct kobject *kobj, stru
 	struct as_fs_entry *entry = to_as(attr);
 
 	if (!entry->store)
-		return -EINVAL;
+		return -EIO;
 
 	return entry->store(e->elevator_data, page, length);
 }
diff --git a/drivers/block/cfq-iosched.c b/drivers/block/cfq-iosched.c
--- a/drivers/block/cfq-iosched.c
+++ b/drivers/block/cfq-iosched.c
@@ -1775,7 +1775,7 @@ cfq_attr_show(struct kobject *kobj, stru
 	struct cfq_fs_entry *entry = to_cfq(attr);
 
 	if (!entry->show)
-		return 0;
+		return -EIO;
 
 	return entry->show(e->elevator_data, page);
 }
@@ -1788,7 +1788,7 @@ cfq_attr_store(struct kobject *kobj, str
 	struct cfq_fs_entry *entry = to_cfq(attr);
 
 	if (!entry->store)
-		return -EINVAL;
+		return -EIO;
 
 	return entry->store(e->elevator_data, page, length);
 }
diff --git a/drivers/block/deadline-iosched.c b/drivers/block/deadline-iosched.c
--- a/drivers/block/deadline-iosched.c
+++ b/drivers/block/deadline-iosched.c
@@ -886,7 +886,7 @@ deadline_attr_show(struct kobject *kobj,
 	struct deadline_fs_entry *entry = to_deadline(attr);
 
 	if (!entry->show)
-		return 0;
+		return -EIO;
 
 	return entry->show(e->elevator_data, page);
 }
@@ -899,7 +899,7 @@ deadline_attr_store(struct kobject *kobj
 	struct deadline_fs_entry *entry = to_deadline(attr);
 
 	if (!entry->store)
-		return -EINVAL;
+		return -EIO;
 
 	return entry->store(e->elevator_data, page, length);
 }
diff --git a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c
+++ b/drivers/block/genhd.c
@@ -322,7 +322,7 @@ static ssize_t disk_attr_show(struct kob
 	struct gendisk *disk = to_disk(kobj);
 	struct disk_attribute *disk_attr =
 		container_of(attr,struct disk_attribute,attr);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (disk_attr->show)
 		ret = disk_attr->show(disk,page);
diff --git a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c
+++ b/drivers/block/ll_rw_blk.c
@@ -3574,7 +3574,7 @@ queue_attr_show(struct kobject *kobj, st
 
 	q = container_of(kobj, struct request_queue, kobj);
 	if (!entry->show)
-		return 0;
+		return -EIO;
 
 	return entry->show(q, page);
 }
@@ -3588,7 +3588,7 @@ queue_attr_store(struct kobject *kobj, s
 
 	q = container_of(kobj, struct request_queue, kobj);
 	if (!entry->store)
-		return -EINVAL;
+		return -EIO;
 
 	return entry->store(q, page, length);
 }

