Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267737AbUIMOry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267737AbUIMOry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUIMOrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:47:53 -0400
Received: from soundwarez.org ([217.160.171.123]:62183 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S267576AbUIMOpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:45:53 -0400
Date: Mon, 13 Sep 2004 16:45:53 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Robert Love <rml@ximian.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040913144553.GA10620@vrfy.org>
References: <1093989924.4815.56.camel@betsy.boston.ximian.com> <20040902083407.GC3191@kroah.com> <1094142321.2284.12.camel@betsy.boston.ximian.com> <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy> <20040911165300.GA17028@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20040911165300.GA17028@kroah.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 11, 2004 at 09:53:00AM -0700, Greg KH wrote:
> On Sat, Sep 11, 2004 at 12:09:35AM -0400, Robert Love wrote:
> > > +/**
> > > + * send_uevent - notify userspace by sending event trough netlink socket
> > 
> > s/trough/through/ ;-)
> 
> Heh, give something for the "spelling nit-pickers" to submit a patch
> against :)
> 
> > We should probably add at least _some_ user.  The filesystem mount
> > events are good, since we want to add those to HAL.
> 
> True, anyone want to send me a patch with a user of this?

Do we agree on the model that the signal is a simple verb and we keep
only a small dictionary of _static_ signal strings and no fancy compositions?
And we should reserve the "add" and "remove" only for the hotplug events.

Here is the first user besides the hotplug event, for notification of
filesystem changes with "mount" and "umount" signals for the blockdevice.

Thanks,
Kay

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="uevent-fs-01.patch"

Kobject Userspace Event Notification for blockdevice mount and unmount events

Send notification over the new netlink socket to let userspace know that
the filesystem code claims/releases the superblock on an blockdevice.
This way, userspace can get rid of constantly polling /proc/mounts to
watch for filesystem changes.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
---
===== fs/super.c 1.122 vs edited =====
--- 1.122/fs/super.c	2004-07-11 11:23:26 +02:00
+++ edited/fs/super.c	2004-09-13 16:16:36 +02:00
@@ -35,6 +35,7 @@
 #include <linux/vfs.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
 #include <linux/idr.h>
+#include <linux/kobject.h>
 #include <asm/uaccess.h>
 
 
@@ -633,6 +634,16 @@ static int test_bdev_super(struct super_
 	return (void *)s->s_bdev == data;
 }
 
+static void bdev_uevent(const char *action, struct block_device *bdev)
+{
+	if (bdev->bd_disk) {
+		if (bdev->bd_part)
+			kobject_uevent(action, &bdev->bd_part->kobj, NULL);
+		else
+			kobject_uevent(action, &bdev->bd_disk->kobj, NULL);
+	}
+}
+
 struct super_block *get_sb_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int))
@@ -675,8 +686,10 @@ struct super_block *get_sb_bdev(struct f
 			up_write(&s->s_umount);
 			deactivate_super(s);
 			s = ERR_PTR(error);
-		} else
+		} else {
 			s->s_flags |= MS_ACTIVE;
+			bdev_uevent("mount", bdev);
+		}
 	}
 
 	return s;
@@ -691,6 +704,8 @@ EXPORT_SYMBOL(get_sb_bdev);
 void kill_block_super(struct super_block *sb)
 {
 	struct block_device *bdev = sb->s_bdev;
+
+	bdev_uevent("umount", bdev);
 	generic_shutdown_super(sb);
 	set_blocksize(bdev, sb->s_old_blocksize);
 	close_bdev_excl(bdev);

--YZ5djTAD1cGYuMQK--
