Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269641AbRHMB2F>; Sun, 12 Aug 2001 21:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269646AbRHMB1v>; Sun, 12 Aug 2001 21:27:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:59788 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269641AbRHMB1J>;
	Sun, 12 Aug 2001 21:27:09 -0400
Date: Sun, 12 Aug 2001 21:27:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/super.c fixes - second series (4/11)
In-Reply-To: <Pine.GSO.4.21.0108122126400.7092-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108122127030.7092-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Part 4/11

do_remount_sb() placed under the exclusive lock on ->s_umount. All it takes
is replacement of fsync_dev() with fsync_super(). Callers updated.

diff -urN S9-pre1-get_sb_bdev2/fs/super.c S9-pre1-do_remount_sb/fs/super.c
--- S9-pre1-get_sb_bdev2/fs/super.c	Sun Aug 12 20:45:49 2001
+++ S9-pre1-do_remount_sb/fs/super.c	Sun Aug 12 20:45:50 2001
@@ -1035,8 +1035,8 @@
 	if (!sb)
 		BUG();
 	atomic_inc(&sb->s_active);
-	do_remount_sb(sb, flags, data);
 	down_write(&sb->s_umount);
+	do_remount_sb(sb, flags, data);
 	return sb;
 }
 
@@ -1107,7 +1107,7 @@
 	if (flags & MS_RDONLY)
 		acct_auto_close(sb->s_dev);
 	shrink_dcache_sb(sb);
-	fsync_dev(sb->s_dev);
+	fsync_super(sb);
 	/* If we are remounting RDONLY, make sure there are no rw files open */
 	if ((flags & MS_RDONLY) && !(sb->s_flags & MS_RDONLY))
 		if (!fs_may_remount_ro(sb))
@@ -1192,8 +1192,11 @@
 		 * Special case for "unmounting" root ...
 		 * we just try to remount it readonly.
 		 */
-		if (!(sb->s_flags & MS_RDONLY))
+		if (!(sb->s_flags & MS_RDONLY)) {
+			down_write(&sb->s_umount);
 			retval = do_remount_sb(sb, MS_RDONLY, 0);
+			up_write(&sb->s_umount);
+		}
 		return retval;
 	}
 
@@ -1369,13 +1372,19 @@
 
 static int do_remount(struct nameidata *nd, int flags, char *data)
 {
+	int err;
+	struct super_block * sb = nd->mnt->mnt_sb;
+
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	if (nd->dentry != nd->mnt->mnt_root)
 		return -EINVAL;
 
-	return do_remount_sb(nd->mnt->mnt_sb, flags, data);
+	down_write(&sb->s_umount);
+	err = do_remount_sb(sb, flags, data);
+	up_write(&sb->s_umount);
+	return err;
 }
 
 static int do_add_mount(struct nameidata *nd, char *type, int flags,


