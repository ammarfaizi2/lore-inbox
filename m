Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWAEBAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWAEBAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWAEAuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:5306 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750993AbWAEAt6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:58 -0500
Cc: kay.sievers@suse.de
Subject: [PATCH] remove mount/umount uevents from superblock handling
In-Reply-To: <11364221683611@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:29 -0800
Message-Id: <11364221693870@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] remove mount/umount uevents from superblock handling

The names of these events have been confusing from the beginning
on, as they have been more like claim/release events. We needed these
events for noticing HAL if storage devices have been mounted.

Thanks to Al, we have the proper solution now and can poll()
/proc/mounts instead to get notfied about mount tree changes.

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 033b96fd30db52a710d97b06f87d16fc59fee0f1
tree 00fbccf2cf478307e213f298a221e330f3ba12ae
parent 0f76e5acf9dc788e664056dda1e461f0bec93948
author Kay Sievers <kay.sievers@suse.de> Fri, 11 Nov 2005 06:09:55 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:07 -0800

 fs/super.c              |   15 +--------------
 include/linux/kobject.h |    6 ++----
 lib/kobject_uevent.c    |    4 ----
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 6689dde..5a347a4 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -665,16 +665,6 @@ static int test_bdev_super(struct super_
 	return (void *)s->s_bdev == data;
 }
 
-static void bdev_uevent(struct block_device *bdev, enum kobject_action action)
-{
-	if (bdev->bd_disk) {
-		if (bdev->bd_part)
-			kobject_uevent(&bdev->bd_part->kobj, action, NULL);
-		else
-			kobject_uevent(&bdev->bd_disk->kobj, action, NULL);
-	}
-}
-
 struct super_block *get_sb_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int))
@@ -717,10 +707,8 @@ struct super_block *get_sb_bdev(struct f
 			up_write(&s->s_umount);
 			deactivate_super(s);
 			s = ERR_PTR(error);
-		} else {
+		} else
 			s->s_flags |= MS_ACTIVE;
-			bdev_uevent(bdev, KOBJ_MOUNT);
-		}
 	}
 
 	return s;
@@ -736,7 +724,6 @@ void kill_block_super(struct super_block
 {
 	struct block_device *bdev = sb->s_bdev;
 
-	bdev_uevent(bdev, KOBJ_UMOUNT);
 	generic_shutdown_super(sb);
 	sync_blockdev(bdev);
 	close_bdev_excl(bdev);
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index baf5251..e6926b3 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -42,10 +42,8 @@ enum kobject_action {
 	KOBJ_ADD	= (__force kobject_action_t) 0x01,	/* add event, for hotplug */
 	KOBJ_REMOVE	= (__force kobject_action_t) 0x02,	/* remove event, for hotplug */
 	KOBJ_CHANGE	= (__force kobject_action_t) 0x03,	/* a sysfs attribute file has changed */
-	KOBJ_MOUNT	= (__force kobject_action_t) 0x04,	/* mount event for block devices */
-	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices */
-	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* offline event for hotplug devices */
-	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* online event for hotplug devices */
+	KOBJ_OFFLINE	= (__force kobject_action_t) 0x04,	/* offline event for hotplug devices */
+	KOBJ_ONLINE	= (__force kobject_action_t) 0x05,	/* online event for hotplug devices */
 };
 
 struct kobject {
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 1f90eea..845bf67 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -39,10 +39,6 @@ static char *action_to_string(enum kobje
 		return "remove";
 	case KOBJ_CHANGE:
 		return "change";
-	case KOBJ_MOUNT:
-		return "mount";
-	case KOBJ_UMOUNT:
-		return "umount";
 	case KOBJ_OFFLINE:
 		return "offline";
 	case KOBJ_ONLINE:

