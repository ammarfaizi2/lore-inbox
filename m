Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269858AbUJSRAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269858AbUJSRAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269683AbUJSQ7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:59:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:45764 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269682AbUJSQik convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:40 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982037783139@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:19 -0700
Message-Id: <1098203779656@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1867.3.5, 2004/09/15 14:16:46-07:00, greg@kroah.com

kevent: add block mount and umount support

Send notification over the new netlink socket to let userspace know that
the filesystem code claims/releases the superblock on an blockdevice.
This way, userspace can get rid of constantly polling /proc/mounts to
watch for filesystem changes.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/super.c                     |   17 ++++++++++++++++-
 include/linux/kobject_uevent.h |    1 +
 lib/kobject_uevent.c           |    1 +
 3 files changed, 18 insertions(+), 1 deletion(-)


diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	2004-10-19 09:22:39 -07:00
+++ b/fs/super.c	2004-10-19 09:22:39 -07:00
@@ -35,6 +35,7 @@
 #include <linux/vfs.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
 #include <linux/idr.h>
+#include <linux/kobject.h>
 #include <asm/uaccess.h>
 
 
@@ -633,6 +634,16 @@
 	return (void *)s->s_bdev == data;
 }
 
+static void bdev_uevent(struct block_device *bdev, enum kobject_action action)
+{
+	if (bdev->bd_disk) {
+		if (bdev->bd_part)
+			kobject_uevent(&bdev->bd_part->kobj, action, NULL);
+		else
+			kobject_uevent(&bdev->bd_disk->kobj, action, NULL);
+	}
+}
+
 struct super_block *get_sb_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int))
@@ -675,8 +686,10 @@
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
@@ -691,6 +704,8 @@
 void kill_block_super(struct super_block *sb)
 {
 	struct block_device *bdev = sb->s_bdev;
+
+	bdev_uevent(bdev, KOBJ_UMOUNT);
 	generic_shutdown_super(sb);
 	set_blocksize(bdev, sb->s_old_blocksize);
 	close_bdev_excl(bdev);
diff -Nru a/include/linux/kobject_uevent.h b/include/linux/kobject_uevent.h
--- a/include/linux/kobject_uevent.h	2004-10-19 09:22:39 -07:00
+++ b/include/linux/kobject_uevent.h	2004-10-19 09:22:39 -07:00
@@ -21,6 +21,7 @@
 	KOBJ_REMOVE	= 0x01,	/* remove event, for hotplug */
 	KOBJ_CHANGE	= 0x02,	/* a sysfs attribute file has changed */
 	KOBJ_MOUNT	= 0x03,	/* mount event for block devices */
+	KOBJ_UMOUNT	= 0x04,	/* umount event for block devices */
 	KOBJ_MAX_ACTION,	/* must be last action listed */
 };
 
diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-10-19 09:22:39 -07:00
+++ b/lib/kobject_uevent.c	2004-10-19 09:22:39 -07:00
@@ -32,6 +32,7 @@
 	"remove",	/* 0x01 */
 	"change",	/* 0x02 */
 	"mount",	/* 0x03 */
+	"umount",	/* 0x04 */
 };
 
 static char *action_to_string(enum kobject_action action)

