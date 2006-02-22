Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWBVRoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWBVRoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWBVRoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:44:09 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:29087
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1422647AbWBVRoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:44:07 -0500
Date: Wed, 22 Feb 2006 09:44:15 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, kay.sievers@suse.de
Subject: [PATCH] Revert mount/umount uevent removal
Message-ID: <20060222174415.GB11415@kroah.com>
References: <20060222174339.GA11415@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222174339.GA11415@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This change reverts the 033b96fd30db52a710d97b06f87d16fc59fee0f1 commit
from Kay Sievers that removed the mount/umount uevents from the kernel.
Some older versions of HAL still depend on these events to detect when a
new device has been mounted.  These events are not correctly emitted,
and are broken by design, and so, should not be relied upon by any
future program.  Instead, the /proc/mounts file should be polled to
properly detect this kind of event.

A feature-removal-schedule.txt entry has been added, noting when this
interface will be removed from the kernel.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 Documentation/feature-removal-schedule.txt |    9 +++++++++
 fs/super.c                                 |   15 ++++++++++++++-
 include/linux/kobject.h                    |    6 ++++--
 lib/kobject_uevent.c                       |    4 ++++
 4 files changed, 31 insertions(+), 3 deletions(-)

fa675765afed59bb89adba3369094ebd428b930b
diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index b730d76..be5ae60 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -171,3 +171,12 @@ Why:	The ISA interface is faster and sho
 	probing is also known to cause trouble in at least one case (see
 	bug #5889.)
 Who:	Jean Delvare <khali@linux-fr.org>
+
+---------------------------
+
+What:	mount/umount uevents
+When:	February 2007
+Why:	These events are not correct, and do not properly let userspace know
+	when a file system has been mounted or unmounted.  Userspace should
+	poll the /proc/mounts file instead to detect this properly.
+Who:	Greg Kroah-Hartman <gregkh@suse.de>
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
index 2a8d8da..c374b5f 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -41,8 +41,10 @@ enum kobject_action {
 	KOBJ_ADD	= (__force kobject_action_t) 0x01,	/* exclusive to core */
 	KOBJ_REMOVE	= (__force kobject_action_t) 0x02,	/* exclusive to core */
 	KOBJ_CHANGE	= (__force kobject_action_t) 0x03,	/* device state change */
-	KOBJ_OFFLINE	= (__force kobject_action_t) 0x04,	/* device offline */
-	KOBJ_ONLINE	= (__force kobject_action_t) 0x05,	/* device online */
+	KOBJ_MOUNT	= (__force kobject_action_t) 0x04,	/* mount event for block devices (broken) */
+	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices (broken) */
+	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* device offline */
+	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* device online */
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

