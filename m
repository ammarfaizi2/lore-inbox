Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261500AbREYSfo>; Fri, 25 May 2001 14:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261502AbREYSfe>; Fri, 25 May 2001 14:35:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53152 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261500AbREYSfO>;
	Fri, 25 May 2001 14:35:14 -0400
Date: Fri, 25 May 2001 14:35:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (part 4) fs/super.c cleanup
Message-ID: <Pine.GSO.4.21.0105251431230.27664-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* MNT_VISIBLE is gone. We simply do not insert vfsmounts we don't
want to see into the vfsmntlist. The only place where it is used is
get_filesystem_info(), so it's obviously correct.
	
	Please, apply.

PS: I've done a different locking scheme for superblocks, so right
now I'm testing it on a complete patch. I.e. that part is postponed until
it gets some testing. So the next several pieces will be just a bunch
of trivial cleanups.

diff -urN S5-pre6/fs/super.c S5-pre6-MNT_VISIBLE/fs/super.c
--- S5-pre6/fs/super.c	Thu May 24 22:15:03 2001
+++ S5-pre6-MNT_VISIBLE/fs/super.c	Thu May 24 23:57:23 2001
@@ -314,13 +314,6 @@
  *	Potential reason for failure (aside of trivial lack of memory) is a
  *	deleted mountpoint. Caller must hold ->i_zombie on mountpoint
  *	dentry (if any).
- *
- *	Node is marked as MNT_VISIBLE (visible in /proc/mounts) unless both
- *	@nd and @devname are %NULL. It works since we pass non-%NULL @devname
- *	when we are mounting root and kern_mount() filesystems are deviceless.
- *	If we will get a kern_mount() filesystem with nontrivial @devname we
- *	will have to pass the visibility flag explicitly, so if we will add
- *	support for such beasts we'll have to change prototype.
  */
 
 static struct vfsmount *add_vfsmnt(struct nameidata *nd,
@@ -336,9 +329,6 @@
 		goto out;
 	memset(mnt, 0, sizeof(struct vfsmount));
 
-	if (nd || dev_name)
-		mnt->mnt_flags = MNT_VISIBLE;
-
 	/* It may be NULL, but who cares? */
 	if (dev_name) {
 		name = kmalloc(strlen(dev_name)+1, GFP_KERNEL);
@@ -366,7 +356,8 @@
 	}
 	INIT_LIST_HEAD(&mnt->mnt_mounts);
 	list_add(&mnt->mnt_instances, &sb->s_mounts);
-	list_add(&mnt->mnt_list, vfsmntlist.prev);
+	if (nd || dev_name)
+		list_add(&mnt->mnt_list, vfsmntlist.prev);
 	spin_unlock(&dcache_lock);
 out:
 	return mnt;
@@ -500,8 +491,6 @@
 
 	for (p = vfsmntlist.next; p != &vfsmntlist; p = p->next) {
 		struct vfsmount *tmp = list_entry(p, struct vfsmount, mnt_list);
-		if (!(tmp->mnt_flags & MNT_VISIBLE))
-			continue;
 		path = d_path(tmp->mnt_root, tmp, buffer, PAGE_SIZE);
 		if (!path)
 			continue;
diff -urN S5-pre6/include/linux/mount.h S5-pre6-MNT_VISIBLE/include/linux/mount.h
--- S5-pre6/include/linux/mount.h	Thu May 24 22:15:06 2001
+++ S5-pre6-MNT_VISIBLE/include/linux/mount.h	Thu May 24 23:58:00 2001
@@ -12,8 +12,6 @@
 #define _LINUX_MOUNT_H
 #ifdef __KERNEL__
 
-#define MNT_VISIBLE	1
-
 struct vfsmount
 {
 	struct dentry *mnt_mountpoint;	/* dentry of mountpoint */

