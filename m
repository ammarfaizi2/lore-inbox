Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbRFEUmZ>; Tue, 5 Jun 2001 16:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263335AbRFEUmP>; Tue, 5 Jun 2001 16:42:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:20370 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263333AbRFEUmE>;
	Tue, 5 Jun 2001 16:42:04 -0400
Date: Tue, 5 Jun 2001 16:42:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more fs/super.c cleanups (1)
Message-ID: <Pine.GSO.4.21.0106051635510.4799-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus, here's the next series of fs/super.c cleanups, cut into
small chunks. Patches are incremental.

Chunk #1:
	Switches special case in do_umount() to do_remount_sb() (from
do_remount()); takes all per-superblock steps of remount into remount_sb().
That will allow to clean the lookup logics in the do_remount()/do_lookup()/
do_mount() (next chunk).

Please, apply.
							Al

diff -urN S6-pre1/fs/super.c S6-pre1-do_remount/fs/super.c
--- S6-pre1/fs/super.c	Tue Jun  5 06:21:52 2001
+++ S6-pre1-do_remount/fs/super.c	Tue Jun  5 08:14:29 2001
@@ -55,7 +55,6 @@
 extern int root_mountflags;
 
 static int do_remount_sb(struct super_block *sb, int flags, char * data);
-static int do_remount(const char *dir, int flags, char * data);
 
 /* this is initialized in init/main.c */
 kdev_t ROOT_DEV;
@@ -923,6 +922,10 @@
 	if (!(flags & MS_RDONLY) && sb->s_dev && is_read_only(sb->s_dev))
 		return -EACCES;
 		/*flags |= MS_RDONLY;*/
+	if (flags & MS_RDONLY)
+		acct_auto_close(sb->s_dev);
+	shrink_dcache_sb(sb);
+	fsync_dev(sb->s_dev);
 	/* If we are remounting RDONLY, make sure there are no rw files open */
 	if ((flags & MS_RDONLY) && !(sb->s_flags & MS_RDONLY))
 		if (!fs_may_remount_ro(sb))
@@ -1004,11 +1007,14 @@
 	 * call reboot(9). Then init(8) could umount root and exec /reboot.
 	 */
 	if (mnt == current->fs->rootmnt) {
+		int retval = 0;
 		/*
 		 * Special case for "unmounting" root ...
 		 * we just try to remount it readonly.
 		 */
-		return do_remount("/", MS_RDONLY, NULL);
+		if (!(sb->s_flags & MS_RDONLY))
+			retval = do_remount_sb(sb, MS_RDONLY, 0);
+		return retval;
 	}
 
 	spin_lock(&dcache_lock);
@@ -1202,24 +1208,14 @@
 
 	if (path_init(dir, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
 		retval = path_walk(dir, &nd);
-	if (!retval) {
-		struct super_block * sb = nd.dentry->d_inode->i_sb;
-		retval = -ENODEV;
-		if (sb) {
-			retval = -EINVAL;
-			if (nd.dentry == sb->s_root) {
-				/*
-				 * Shrink the dcache and sync the device.
-				 */
-				shrink_dcache_sb(sb);
-				fsync_dev(sb->s_dev);
-				if (flags & MS_RDONLY)
-					acct_auto_close(sb->s_dev);
-				retval = do_remount_sb(sb, flags, data);
-			}
-		}
-		path_release(&nd);
-	}
+	if (retval)
+		return retval;
+
+	retval = -EINVAL;
+	if (nd.dentry == nd.mnt->mnt_root)
+		retval = do_remount_sb(nd.mnt->mnt_sb, flags, data);
+
+	path_release(&nd);
 	return retval;
 }
 

