Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbREYSjo>; Fri, 25 May 2001 14:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbREYSje>; Fri, 25 May 2001 14:39:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:42406 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261505AbREYSjS>;
	Fri, 25 May 2001 14:39:18 -0400
Date: Fri, 25 May 2001 14:39:16 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (part 5) fs/super.c cleanups
Message-ID: <Pine.GSO.4.21.0105251436110.27664-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Takes allocation/initalization of vfsmounts into separate function.
We will need this separation to deal with several places where we need
a non-blocking (and non-failing) equivalent of add_vfsmnt(). There allocation
will be done outside of critical area.

	Please, apply.

diff -urN S5-pre6-MNT_VISIBLE/fs/super.c S5-pre6-alloc_vfsmnt/fs/super.c
--- S5-pre6-MNT_VISIBLE/fs/super.c	Thu May 24 23:57:23 2001
+++ S5-pre6-alloc_vfsmnt/fs/super.c	Fri May 25 04:13:30 2001
@@ -282,6 +282,21 @@
 
 static LIST_HEAD(vfsmntlist);
 
+struct vfsmount *alloc_vfsmnt(void)
+{
+	struct vfsmount *mnt = kmalloc(sizeof(struct vfsmount), GFP_KERNEL); 
+	if (mnt) {
+		memset(mnt, 0, sizeof(struct vfsmount));
+		atomic_set(&mnt->mnt_count,1);
+		INIT_LIST_HEAD(&mnt->mnt_clash);
+		INIT_LIST_HEAD(&mnt->mnt_child);
+		INIT_LIST_HEAD(&mnt->mnt_mounts);
+		INIT_LIST_HEAD(&mnt->mnt_list);
+		mnt->mnt_owner = current->uid;
+	}
+	return mnt;
+}
+
 static void detach_mnt(struct vfsmount *mnt, struct nameidata *old_nd)
 {
 	old_nd->dentry = mnt->mnt_mountpoint;
@@ -324,10 +339,9 @@
 	struct super_block *sb = root->d_inode->i_sb;
 	char *name;
 
-	mnt = kmalloc(sizeof(struct vfsmount), GFP_KERNEL);
+	mnt = alloc_vfsmnt();
 	if (!mnt)
 		goto out;
-	memset(mnt, 0, sizeof(struct vfsmount));
 
 	/* It may be NULL, but who cares? */
 	if (dev_name) {
@@ -337,8 +351,6 @@
 			mnt->mnt_devname = name;
 		}
 	}
-	mnt->mnt_owner = current->uid;
-	atomic_set(&mnt->mnt_count,1);
 	mnt->mnt_sb = sb;
 
 	spin_lock(&dcache_lock);
@@ -351,10 +363,7 @@
 	} else {
 		mnt->mnt_mountpoint = mnt->mnt_root;
 		mnt->mnt_parent = mnt;
-		INIT_LIST_HEAD(&mnt->mnt_child);
-		INIT_LIST_HEAD(&mnt->mnt_clash);
 	}
-	INIT_LIST_HEAD(&mnt->mnt_mounts);
 	list_add(&mnt->mnt_instances, &sb->s_mounts);
 	if (nd || dev_name)
 		list_add(&mnt->mnt_list, vfsmntlist.prev);

