Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262968AbREWD0Y>; Tue, 22 May 2001 23:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262969AbREWD0P>; Tue, 22 May 2001 23:26:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53414 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262968AbREWD0I>;
	Tue, 22 May 2001 23:26:08 -0400
Date: Tue, 22 May 2001 23:26:06 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (part 1) fs/super.c cleanups
Message-ID: <Pine.GSO.4.21.0105222256180.17373-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus, since we have sane kill_super() now, the long-promised
cleanups are coming ;-) I'm going to feed them in small incremental
chunks, so if you see something unacceptable - yell. It may turn out
to be a result of bad choice of chunk boundaries, so...

	OK, here comes the chunk #1:

	* we have different rules for ->mnt_parent and ->mnt_mountpoint
in case of root filesystem(s). I.e. in case if vfsmount is not mounted
on anything (root and kern_mount() stuff). In that case we have
	mnt->mnt_parent == mnt
	mnt->mnt_mountpoint == mnt->mnt_root.
We shouldn't hold ->d_count of ->mnt_mountpoint. It's inconsistent with
the way we treat ->mnt_parent, it's not needed (->mnt_root is pinned
down just fine), it complicates the logics and it's conceptually wrong -
sure, going upwards from root leaves us where we were (thus the rules
above), but we don't have anything actually mounted on the root.
	Change: now ->mnt_mountpoint holds a reference to dentry only
if mnt is actually mounted on something. It will allow to simplify a
lot of stuff, since we get the same rules as we have for ->mnt_parent.

	* pivot_root(2) was slightly broken. It is OK to have new_root
not at the root of filesystem. However, it should be a mountpoint. Which
is actually not a restriction - mount --bind foo foo will make foo a
mountpoint just fine.
	Change: add the missing check, remove the broken attempts to handle
that case.

	Patch follows. Please, apply.
								Al
PS: next chunk simplifies the move_vfsmnt() and friends - both API and
internals.

diff -urN S5-pre5/fs/super.c S5-pre5-mountpoint/fs/super.c
--- S5-pre5/fs/super.c	Tue May 22 16:44:21 2001
+++ S5-pre5-mountpoint/fs/super.c	Tue May 22 22:54:54 2001
@@ -337,7 +337,7 @@
 	if (nd && !IS_ROOT(nd->dentry) && d_unhashed(nd->dentry))
 		goto fail;
 	mnt->mnt_root = dget(root);
-	mnt->mnt_mountpoint = nd ? dget(nd->dentry) : dget(root);
+	mnt->mnt_mountpoint = nd ? dget(nd->dentry) : root;
 	mnt->mnt_parent = nd ? mntget(nd->mnt) : mnt;
 
 	if (nd) {
@@ -388,7 +388,7 @@
 	}
 
 	/* flip the linkage */
-	mnt->mnt_mountpoint = dget(mountpoint);
+	mnt->mnt_mountpoint = parent ? dget(mountpoint) : mnt->mnt_root;
 	mnt->mnt_parent = parent ? mntget(parent) : mnt;
 	list_del(&mnt->mnt_clash);
 	list_del(&mnt->mnt_child);
@@ -402,9 +402,10 @@
 	spin_unlock(&dcache_lock);
 
 	/* put the old stuff */
-	dput(old_mountpoint);
-	if (old_parent != mnt)
+	if (old_parent != mnt) {
+		dput(old_mountpoint);
 		mntput(old_parent);
+	}
 }
 
 /*
@@ -419,10 +420,10 @@
 	list_del(&mnt->mnt_child);
 	spin_unlock(&dcache_lock);
 	/* Now we can work safely */
-	if (mnt->mnt_parent != mnt)
+	if (mnt->mnt_parent != mnt) {
+		dput(mnt->mnt_mountpoint);
 		mntput(mnt->mnt_parent);
-
-	dput(mnt->mnt_mountpoint);
+	}
 	dput(mnt->mnt_root);
 	if (mnt->mnt_devname)
 		kfree(mnt->mnt_devname);
@@ -1612,8 +1613,9 @@
  *  - we don't move root/cwd if they are not at the root (reason: if something
  *    cared enough to change them, it's probably wrong to force them elsewhere)
  *  - it's okay to pick a root that isn't the root of a file system, e.g.
- *    /nfs/my_root where /nfs is the mount point. Better avoid creating
- *    unreachable mount points this way, though.
+ *    /nfs/my_root where /nfs is the mount point. It must be a mountpoint,
+ *    though, so you may need to say mount --bind /nfs/my_root /nfs/my_root
+ *    first.
  */
 
 asmlinkage long sys_pivot_root(const char *new_root, const char *put_old)
@@ -1669,6 +1671,8 @@
 	if (new_nd.mnt == root_mnt || old_nd.mnt == root_mnt)
 		goto out2; /* loop */
 	error = -EINVAL;
+	if (new_nd.mnt->mnt_root != new_nd.dentry)
+		goto out2; /* not a mountpoint */
 	tmp = old_nd.mnt; /* make sure we can reach put_old from new_root */
 	spin_lock(&dcache_lock);
 	if (tmp != new_nd.mnt) {
@@ -1685,7 +1689,7 @@
 		goto out3;
 	spin_unlock(&dcache_lock);
 
-	move_vfsmnt(new_nd.mnt, new_nd.dentry, NULL, NULL);
+	move_vfsmnt(new_nd.mnt, NULL, NULL, NULL);
 	move_vfsmnt(root_mnt, old_nd.dentry, old_nd.mnt, NULL);
 	chroot_fs_refs(root,root_mnt,new_nd.dentry,new_nd.mnt);
 	error = 0;

