Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161099AbWBVSIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbWBVSIN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161263AbWBVSIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:08:13 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:43163 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161269AbWBVSIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:08:12 -0500
Subject: [PATCH] restore superblock mount/umount uevents
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, kay.sievers@suse.de, gregkh@suse.de,
       torvalds@osdl.org
Date: Wed, 22 Feb 2006 20:08:09 +0200
Message-Id: <1140631690.11447.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch fixes an userspace regression caused by "[PATCH] remove
mount/umount uevents from superblock handling" where gnome-volume-manager no
longer detects plugged in devices. You can find a complete bug description
here: http://bugzilla.kernel.org/show_bug.cgi?id=6021.

I have tested this patch on Gentoo Linux running HAL 0.5.5.1.

Cc: Kay Sievers <kay.sievers@suse.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

diff --git a/fs/super.c b/fs/super.c
index 3029421..e20b558 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -666,6 +666,16 @@ static int test_bdev_super(struct super_
 	return (void *)s->s_bdev == data;
 }
 
+static void bdev_uevent(struct block_device *bdev, enum kobject_action action)
+{
+	if (bdev->bd_disk) {
+		if (bdev->bd_part)
+			kobject_uevent(&bdev->bd_part->kobj, action);
+		else
+			kobject_uevent(&bdev->bd_disk->kobj, action);
+	}
+}
+
 struct super_block *get_sb_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int))
@@ -707,8 +717,10 @@ struct super_block *get_sb_bdev(struct f
 			up_write(&s->s_umount);
 			deactivate_super(s);
 			s = ERR_PTR(error);
-		} else
+		} else {
 			s->s_flags |= MS_ACTIVE;
+			bdev_uevent(bdev, KOBJ_MOUNT);
+		}
 	}
 
 	return s;
@@ -724,6 +736,7 @@ void kill_block_super(struct super_block
 {
 	struct block_device *bdev = sb->s_bdev;
 
+	bdev_uevent(bdev, KOBJ_UMOUNT);
 	generic_shutdown_super(sb);
 	sync_blockdev(bdev);
 	close_bdev_excl(bdev);
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 2a8d8da..8983f20 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -41,8 +41,10 @@ enum kobject_action {
 	KOBJ_ADD	= (__force kobject_action_t) 0x01,	/* exclusive to core */
 	KOBJ_REMOVE	= (__force kobject_action_t) 0x02,	/* exclusive to core */
 	KOBJ_CHANGE	= (__force kobject_action_t) 0x03,	/* device state change */
-	KOBJ_OFFLINE	= (__force kobject_action_t) 0x04,	/* device offline */
-	KOBJ_ONLINE	= (__force kobject_action_t) 0x05,	/* device online */
+	KOBJ_MOUNT	= (__force kobject_action_t) 0x04,	/* mount event for block devices */
+	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices */
+	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* offline event for hotplug devices */
+	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* online event for hotplug devices */
 };
 
 struct kobject {
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 1b1985c..086a0c6 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -38,6 +38,10 @@ static char *action_to_string(enum kobje
 		return "remove";
 	case KOBJ_CHANGE:
 		return "change";
+	case KOBJ_MOUNT:
+		return "mount";
+	case KOBJ_UMOUNT:
+		return "umount";
 	case KOBJ_OFFLINE:
 		return "offline";
 	case KOBJ_ONLINE:


