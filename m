Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbTJBHO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 03:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbTJBHO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 03:14:29 -0400
Received: from zork.zork.net ([64.81.246.102]:39586 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S262443AbTJBHO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 03:14:27 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] record mount time and expose it in /proc/self/mounts
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Thu, 02 Oct 2003 08:14:26 +0100
Message-ID: <6u1xtwglgt.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if this is even useful, never mind implemented correctly.
Against 2.6.0-test6.


diff -urN --exclude '*~' --exclude '*.orig' T6/fs/namespace.c edited/fs/namespace.c
--- T6/fs/namespace.c	2003-07-28 10:22:18.000000000 +0100
+++ edited/fs/namespace.c	2003-10-01 20:17:18.000000000 +0100
@@ -21,6 +21,7 @@
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/mount.h>
+#include <linux/time.h>
 #include <asm/uaccess.h>
 
 extern int __init init_rootfs(void);
@@ -152,6 +153,7 @@
 		mnt->mnt_root = dget(root);
 		mnt->mnt_mountpoint = mnt->mnt_root;
 		mnt->mnt_parent = mnt;
+		do_gettimeofday(&mnt->mnt_when);
 	}
 	return mnt;
 }
@@ -236,6 +238,7 @@
 	}
 	if (mnt->mnt_sb->s_op->show_options)
 		err = mnt->mnt_sb->s_op->show_options(m, mnt);
+	seq_printf(m, ",when=%ld", (long)mnt->mnt_when.tv_sec);
 	seq_puts(m, " 0 0\n");
 	return err;
 }
diff -urN --exclude '*~' --exclude '*.orig' T6/fs/super.c edited/fs/super.c
--- T6/fs/super.c	2003-10-01 18:50:21.000000000 +0100
+++ edited/fs/super.c	2003-10-01 20:17:18.000000000 +0100
@@ -32,6 +32,7 @@
 #include <linux/security.h>
 #include <linux/vfs.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
+#include <linux/time.h>
 #include <asm/uaccess.h>
 
 
@@ -693,6 +694,7 @@
 	mnt->mnt_parent = mnt;
 	up_write(&sb->s_umount);
 	put_filesystem(type);
+	do_gettimeofday(&mnt->mnt_when);
 	return mnt;
 out_sb:
 	up_write(&sb->s_umount);
diff -urN --exclude '*~' --exclude '*.orig' T6/include/linux/mount.h edited/include/linux/mount.h
--- T6/include/linux/mount.h	2003-07-14 04:30:35.000000000 +0100
+++ edited/include/linux/mount.h	2003-10-01 20:17:18.000000000 +0100
@@ -13,6 +13,7 @@
 #ifdef __KERNEL__
 
 #include <linux/list.h>
+#include <linux/time.h>
 
 #define MNT_NOSUID	1
 #define MNT_NODEV	2
@@ -30,6 +31,7 @@
 	atomic_t mnt_count;
 	int mnt_flags;
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
+	struct timeval mnt_when;
 	struct list_head mnt_list;
 };
 
