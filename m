Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbTHYSYO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 14:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTHYSYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 14:24:13 -0400
Received: from [203.185.132.124] ([203.185.132.124]:36932 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262160AbTHYSYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 14:24:02 -0400
Message-ID: <3F4A53ED.60801@nectec.or.th>
Date: Tue, 26 Aug 2003 01:22:37 +0700
From: Samphan Raruenrom <samphan@nectec.or.th>
Organization: NECTEC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en, th
MIME-Version: 1.0
To: Jens Axboe <axboe@image.dk>
CC: linux-kernel@vger.kernel.org, Linux TLE Team <rdi1@opentle.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Add MOUNT_STATUS ioctl to cdrom device
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch add a new ioctl MOUNT_STATUS to the 2.4 kernel's cdrom
device. It'll be used as an API to query the mount status of a
cdrom :-

CDROM_MOUNT_STATUS
Return :-
0 = not mount.
1 = mounted, but not in-use. It is ok to umount.
2 = busy. Umount will result in getting EBUSY.
<0 = error.

This same functionality can be done in user-space, like the way
'fuser' do, but doing so in kernel-space is simpler and faster.
The ioctl can (will) be used by automount daemon to query the
device to see if it is in use or not and lock/unlock the drive
as needed. This will make the cdrom "eject" button work as it
should be (as auto-umount button). Novice GUI users usually wonder
why they can't eject cds even when the discs are not in use.

An experimental implementation has been done and working on my machine.
I'm completely new to kernel hacking so please make comments about
this patch and whether it's justified or plain stupid to add another
ioctl for this feature cause I really have no idea.



diff -dur linux-2.4.22-pre10.orig/drivers/cdrom/cdrom.c linux-2.4.22-pre10/drivers/cdrom/cdrom.c
--- linux-2.4.22-pre10.orig/drivers/cdrom/cdrom.c	2002-11-29 06:53:12.000000000 +0700
+++ linux-2.4.22-pre10/drivers/cdrom/cdrom.c	2003-08-26 00:10:22.000000000 +0700
@@ -264,6 +264,8 @@
  #include <linux/sysctl.h>
  #include <linux/proc_fs.h>
  #include <linux/init.h>
+#include <linux/namespace.h>
+#include <linux/mount.h>

  #include <asm/fcntl.h>
  #include <asm/segment.h>
@@ -1622,6 +1624,26 @@
  		return cdo->lock_door(cdi, arg);
  		}

+	case CDROM_MOUNT_STATUS: {
+		struct super_block *sb = get_super(dev);
+		if (sb == NULL) return -EINVAL;
+		down_read(&current->namespace->sem);
+		struct vfsmount *mnt = NULL;
+		struct list_head *p;
+		list_for_each(p, &current->namespace->list) {
+			struct vfsmount *m = list_entry(p, struct vfsmount, mnt_list);
+			if (sb == m->mnt_sb) {
+				mnt = m; break;
+			}
+		}
+		up_read(&current->namespace->sem);		
+		drop_super(sb);		
+		int mstat = 0; /* 0 not mounted, 1 umount ok, 2 umount EBUSY */
+		if (mnt) mstat = 1 + (atomic_read(&mnt->mnt_count) > 1);
+		cdinfo(CD_DO_IOCTL, "mount status(%s) = %d\n", mnt->mnt_devname, mstat);
+		return mstat;
+		}
+	
  	case CDROM_DEBUG: {
  		if (!capable(CAP_SYS_ADMIN))
  			return -EACCES;
diff -dur linux-2.4.22-pre10.orig/include/linux/cdrom.h linux-2.4.22-pre10/include/linux/cdrom.h
--- linux-2.4.22-pre10.orig/include/linux/cdrom.h	2003-08-05 02:59:58.000000000 +0700
+++ linux-2.4.22-pre10/include/linux/cdrom.h	2003-08-13 21:41:27.000000000 +0700
@@ -127,6 +127,7 @@
  #define CDROM_LOCKDOOR		0x5329  /* lock or unlock door */
  #define CDROM_DEBUG		0x5330	/* Turn debug messages on/off */
  #define CDROM_GET_CAPABILITY	0x5331	/* get capabilities */
+#define CDROM_MOUNT_STATUS	0x5332	/* is it mounted? can umount? */

  /* Note that scsi/scsi_ioctl.h also uses 0x5382 - 0x5386.
   * Future CDROM ioctls should be kept below 0x537F


-- 
Samphan Raruenrom,
The Open Source Project,
National Electronics and Computer Technology Center,
National Science and Technology Development Agency,
Thailand.



