Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261709AbREYTLp>; Fri, 25 May 2001 15:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbREYTLg>; Fri, 25 May 2001 15:11:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:29649 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261709AbREYTL2>;
	Fri, 25 May 2001 15:11:28 -0400
Date: Fri, 25 May 2001 15:11:27 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (part 6) fs/super.c cleanups
Message-ID: <Pine.GSO.4.21.0105251439250.27664-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Expands add_vfsmnt() call in kern_mount(), takes alloc_vfsmnt()
before reading superblock and makes (in add_vfsmnt()) insertion into
vfsmntlist unconditional (kern_mount()) was the only case when we didn't
want it to happen. Moreover, recovery in kern_mount() becomes simpler.

	Please, apply.
diff -urN S5-pre6-alloc_vfsmnt/fs/super.c S5-pre6-kern_mount/fs/super.c
--- S5-pre6-alloc_vfsmnt/fs/super.c	Fri May 25 04:13:30 2001
+++ S5-pre6-kern_mount/fs/super.c	Fri May 25 15:07:19 2001
@@ -365,8 +365,7 @@
 		mnt->mnt_parent = mnt;
 	}
 	list_add(&mnt->mnt_instances, &sb->s_mounts);
-	if (nd || dev_name)
-		list_add(&mnt->mnt_list, vfsmntlist.prev);
+	list_add(&mnt->mnt_list, vfsmntlist.prev);
 	spin_unlock(&dcache_lock);
 out:
 	return mnt;
@@ -945,21 +944,31 @@
 
 struct vfsmount *kern_mount(struct file_system_type *type)
 {
-	kdev_t dev = get_unnamed_dev();
 	struct super_block *sb;
-	struct vfsmount *mnt;
-	if (!dev)
+	struct vfsmount *mnt = alloc_vfsmnt();
+	kdev_t dev;
+
+	if (!mnt)
+		return ERR_PTR(-ENOMEM);
+
+	dev = get_unnamed_dev();
+	if (!dev) {
+		kfree(mnt);
 		return ERR_PTR(-EMFILE);
+	}
 	sb = read_super(dev, NULL, type, 0, NULL, 0);
 	if (!sb) {
 		put_unnamed_dev(dev);
+		kfree(mnt);
 		return ERR_PTR(-EINVAL);
 	}
-	mnt = add_vfsmnt(NULL, sb->s_root, NULL);
-	if (!mnt) {
-		kill_super(sb);
-		return ERR_PTR(-ENOMEM);
-	}
+	mnt->mnt_sb = sb;
+	mnt->mnt_root = dget(sb->s_root);
+	mnt->mnt_mountpoint = mnt->mnt_root;
+	mnt->mnt_parent = mnt;
+	spin_lock(&dcache_lock);
+	list_add(&mnt->mnt_instances, &sb->s_mounts);
+	spin_unlock(&dcache_lock);
 	type->kern_mnt = mnt;
 	return mnt;
 }

