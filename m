Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261756AbREYTYA>; Fri, 25 May 2001 15:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbREYTXu>; Fri, 25 May 2001 15:23:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22242 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261756AbREYTXl>;
	Fri, 25 May 2001 15:23:41 -0400
Date: Fri, 25 May 2001 15:23:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (part 7) fs/super.c cleanups
Message-ID: <Pine.GSO.4.21.0105251511300.27912-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Handling of refcounts for FS_SINGLE filesystems moved to
add_vfsmnt(). That's the first half of real fix for FS_SINGLE mess -
we should make it "read_super() if we hadn't done it yet, otherwise
return what we have". That will make kern_mount() uses simpler and
remove all special-casing with refcounts. in the hindsight, the trick
I've used in 2.4.0-test2 merge was ugly - kern_mount() should be used
only when kernel explicitly asks for a vfsmount of its own, not as
as part of init for FS_SINGLE filesystems. Fix is easy, but that chunk
touches several files besides fs/super.c and requires sane locking
to be safe. Patch below is the preliminary part local to fs/super.c.

	Please, apply.

diff -urN S5-pre6-kern_mount/fs/super.c S5-pre6-single1/fs/super.c
--- S5-pre6-kern_mount/fs/super.c	Fri May 25 15:07:19 2001
+++ S5-pre6-single1/fs/super.c	Fri May 25 15:12:36 2001
@@ -367,6 +367,8 @@
 	list_add(&mnt->mnt_instances, &sb->s_mounts);
 	list_add(&mnt->mnt_list, vfsmntlist.prev);
 	spin_unlock(&dcache_lock);
+	if (sb->s_type->fs_flags & FS_SINGLE)
+		get_filesystem(sb->s_type);
 out:
 	return mnt;
 fail:
@@ -852,7 +854,6 @@
 	sb = fs_type->kern_mnt->mnt_sb;
 	if (!sb)
 		BUG();
-	get_filesystem(fs_type);
 	do_remount_sb(sb, flags, data);
 	return sb;
 }
@@ -1165,8 +1166,6 @@
 		goto out2;
 
 	err = -ENOMEM;
-	if (old_nd.mnt->mnt_sb->s_type->fs_flags & FS_SINGLE)
-		get_filesystem(old_nd.mnt->mnt_sb->s_type);
 		
 	down(&mount_sem);
 	/* there we go */
@@ -1177,8 +1176,6 @@
 		err = 0;
 	up(&new_nd.dentry->d_inode->i_zombie);
 	up(&mount_sem);
-	if (err && old_nd.mnt->mnt_sb->s_type->fs_flags & FS_SINGLE)
-		put_filesystem(old_nd.mnt->mnt_sb->s_type);
 out2:
 	path_release(&new_nd);
 out1:
@@ -1369,8 +1366,6 @@
 	return retval;
 
 fail:
-	if (fstype->fs_flags & FS_SINGLE)
-		put_filesystem(fstype);
 	kill_super(sb);
 	goto unlock_out;
 }

