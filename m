Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267537AbUIOVbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267537AbUIOVbX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267341AbUIOV2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:28:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:43951 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267538AbUIOVX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:23:58 -0400
Date: Wed, 15 Sep 2004 14:21:10 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@novell.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915212110.GA25840@kroah.com>
References: <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy> <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com> <1095211167.20763.2.camel@localhost> <20040915034455.GB30747@kroah.com> <20040915194018.GC24131@kroah.com> <1095279043.23385.102.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095279043.23385.102.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 04:10:43PM -0400, Robert Love wrote:
> On Wed, 2004-09-15 at 12:40 -0700, Greg KH wrote:
> 
> > And here's the patch I applied to my trees and will show up in the next
> > -mm release.
> > 
> > I'll go convert Kay's mount patch to the new interface and add it too.
> 
> I think you want an "unmount" signal, too.

Doh!  You're right.  Here's Kay's patch ported to the new interface, and
adding a umount event type.  I've applied it to my trees.

thanks,

greg k-h

-----


kevent: add block mount and umount support

Send notification over the new netlink socket to let userspace know that
the filesystem code claims/releases the superblock on an blockdevice.
This way, userspace can get rid of constantly polling /proc/mounts to
watch for filesystem changes.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	2004-09-15 14:15:54 -07:00
+++ b/fs/super.c	2004-09-15 14:15:54 -07:00
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
--- a/include/linux/kobject_uevent.h	2004-09-15 14:15:54 -07:00
+++ b/include/linux/kobject_uevent.h	2004-09-15 14:15:54 -07:00
@@ -21,6 +21,7 @@
 	KOBJ_REMOVE	= 0x01,	/* remove event, for hotplug */
 	KOBJ_CHANGE	= 0x02,	/* a sysfs attribute file has changed */
 	KOBJ_MOUNT	= 0x03,	/* mount event for block devices */
+	KOBJ_UMOUNT	= 0x04,	/* umount event for block devices */
 	KOBJ_MAX_ACTION,	/* must be last action listed */
 };
 
diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-09-15 14:15:54 -07:00
+++ b/lib/kobject_uevent.c	2004-09-15 14:15:54 -07:00
@@ -32,6 +32,7 @@
 	"remove",	/* 0x01 */
 	"change",	/* 0x02 */
 	"mount",	/* 0x03 */
+	"umount",	/* 0x04 */
 };
 
 static char *action_to_string(enum kobject_action action)
