Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262983AbREWEP2>; Wed, 23 May 2001 00:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262985AbREWEPT>; Wed, 23 May 2001 00:15:19 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:27627 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262983AbREWEPH>;
	Wed, 23 May 2001 00:15:07 -0400
Date: Wed, 23 May 2001 00:15:05 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (part 2) fs/super.c cleanups
In-Reply-To: <Pine.GSO.4.21.0105222256180.17373-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0105222359430.17373-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	OK, here's chunk #2.

	* two helper functions added: attach_mnt() and detach_mnt().
attach_mnt() adds leaf to mount tree, detach_mnt() - removes.
	Locking rules: both require mount_sem and dcache_lock being
held by callers.
	The rest of stuff doing manipulations of mount tree converted
to using these two.

	* move_vfsmnt() takes nameidata of the new attachment point
now.

	* pivot_root() taught how to work in chroot environment (not
a security issue, since it requires root anyway, but why not handle
it correctly if it comes for free?)
	It used to tear the chroot subtree away. Now it reattaches
new root to the place where old used to be (if any).
	If process root is not on a mountpoint (or global root) -
-EINVAL.
	That way it works as expected in chroot environment. Price:
extra if and call of attach_mnt(). Variant in the current tree screws
up in these conditions.

	Patch (incremental to the previous) follow. Please, apply.
								   Al
PS: the next chunk is (finally) GC for struct vfsmount.

diff -urN S5-pre5-mountpoint/fs/super.c S5-pre5-mnt_detach/fs/super.c
--- S5-pre5-mountpoint/fs/super.c	Tue May 22 23:27:25 2001
+++ S5-pre5-mnt_detach/fs/super.c	Tue May 22 23:55:59 2001
@@ -282,6 +282,24 @@
 
 static LIST_HEAD(vfsmntlist);
 
+static void detach_mnt(struct vfsmount *mnt, struct nameidata *old_nd)
+{
+	old_nd->dentry = mnt->mnt_mountpoint;
+	old_nd->mnt = mnt->mnt_parent;
+	mnt->mnt_parent = mnt;
+	mnt->mnt_mountpoint = mnt->mnt_root;
+	list_del_init(&mnt->mnt_child);
+	list_del_init(&mnt->mnt_clash);
+}
+
+static void attach_mnt(struct vfsmount *mnt, struct nameidata *nd)
+{
+	mnt->mnt_parent = mntget(nd->mnt);
+	mnt->mnt_mountpoint = dget(nd->dentry);
+	list_add(&mnt->mnt_clash, &nd->dentry->d_vfsmnt);
+	list_add(&mnt->mnt_child, &nd->mnt->mnt_mounts);
+}
+
 /**
  *	add_vfsmnt - add a new mount node
  *	@nd: location of mountpoint or %NULL if we want a root node
@@ -337,13 +355,12 @@
 	if (nd && !IS_ROOT(nd->dentry) && d_unhashed(nd->dentry))
 		goto fail;
 	mnt->mnt_root = dget(root);
-	mnt->mnt_mountpoint = nd ? dget(nd->dentry) : root;
-	mnt->mnt_parent = nd ? mntget(nd->mnt) : mnt;
 
 	if (nd) {
-		list_add(&mnt->mnt_child, &nd->mnt->mnt_mounts);
-		list_add(&mnt->mnt_clash, &nd->dentry->d_vfsmnt);
+		attach_mnt(mnt, nd);
 	} else {
+		mnt->mnt_mountpoint = mnt->mnt_root;
+		mnt->mnt_parent = mnt;
 		INIT_LIST_HEAD(&mnt->mnt_child);
 		INIT_LIST_HEAD(&mnt->mnt_clash);
 	}
@@ -362,12 +379,10 @@
 }
 
 static void move_vfsmnt(struct vfsmount *mnt,
-			struct dentry *mountpoint,
-			struct vfsmount *parent,
+			struct nameidata *nd, 
 			const char *dev_name)
 {
-	struct dentry *old_mountpoint;
-	struct vfsmount *old_parent;
+	struct nameidata parent_nd;
 	char *new_devname = NULL;
 
 	if (dev_name) {
@@ -377,35 +392,19 @@
 	}
 
 	spin_lock(&dcache_lock);
-	old_mountpoint = mnt->mnt_mountpoint;
-	old_parent = mnt->mnt_parent;
+	detach_mnt(mnt, &parent_nd);
+	attach_mnt(mnt, nd);
 
-	/* flip names */
 	if (new_devname) {
 		if (mnt->mnt_devname)
 			kfree(mnt->mnt_devname);
 		mnt->mnt_devname = new_devname;
 	}
-
-	/* flip the linkage */
-	mnt->mnt_mountpoint = parent ? dget(mountpoint) : mnt->mnt_root;
-	mnt->mnt_parent = parent ? mntget(parent) : mnt;
-	list_del(&mnt->mnt_clash);
-	list_del(&mnt->mnt_child);
-	if (parent) {
-		list_add(&mnt->mnt_child, &parent->mnt_mounts);
-		list_add(&mnt->mnt_clash, &mountpoint->d_vfsmnt);
-	} else {
-		INIT_LIST_HEAD(&mnt->mnt_child);
-		INIT_LIST_HEAD(&mnt->mnt_clash);
-	}
 	spin_unlock(&dcache_lock);
 
 	/* put the old stuff */
-	if (old_parent != mnt) {
-		dput(old_mountpoint);
-		mntput(old_parent);
-	}
+	if (parent_nd.mnt != mnt)
+		path_release(&parent_nd);
 }
 
 /*
@@ -413,18 +412,16 @@
  */
 static void remove_vfsmnt(struct vfsmount *mnt)
 {
+	struct nameidata parent_nd;
 	/* First of all, remove it from all lists */
+	detach_mnt(mnt, &parent_nd);
 	list_del(&mnt->mnt_instances);
-	list_del(&mnt->mnt_clash);
 	list_del(&mnt->mnt_list);
-	list_del(&mnt->mnt_child);
 	spin_unlock(&dcache_lock);
 	/* Now we can work safely */
-	if (mnt->mnt_parent != mnt) {
-		dput(mnt->mnt_mountpoint);
-		mntput(mnt->mnt_parent);
-	}
 	dput(mnt->mnt_root);
+	if (parent_nd.mnt != mnt)
+		path_release(&parent_nd);
 	if (mnt->mnt_devname)
 		kfree(mnt->mnt_devname);
 	kfree(mnt);
@@ -1623,7 +1620,7 @@
 	struct dentry *root;
 	struct vfsmount *root_mnt;
 	struct vfsmount *tmp;
-	struct nameidata new_nd, old_nd;
+	struct nameidata new_nd, old_nd, parent_nd, root_parent;
 	char *name;
 	int error;
 
@@ -1671,6 +1668,8 @@
 	if (new_nd.mnt == root_mnt || old_nd.mnt == root_mnt)
 		goto out2; /* loop */
 	error = -EINVAL;
+	if (root_mnt->mnt_root != root)
+		goto out2;
 	if (new_nd.mnt->mnt_root != new_nd.dentry)
 		goto out2; /* not a mountpoint */
 	tmp = old_nd.mnt; /* make sure we can reach put_old from new_root */
@@ -1687,12 +1686,18 @@
 			goto out3;
 	} else if (!is_subdir(old_nd.dentry, new_nd.dentry))
 		goto out3;
+	detach_mnt(new_nd.mnt, &parent_nd);
+	detach_mnt(root_mnt, &root_parent);
+	attach_mnt(root_mnt, &old_nd);
+	if (root_parent.mnt != root_mnt)
+		attach_mnt(new_nd.mnt, &root_parent);
 	spin_unlock(&dcache_lock);
-
-	move_vfsmnt(new_nd.mnt, NULL, NULL, NULL);
-	move_vfsmnt(root_mnt, old_nd.dentry, old_nd.mnt, NULL);
 	chroot_fs_refs(root,root_mnt,new_nd.dentry,new_nd.mnt);
 	error = 0;
+	if (root_parent.mnt != root_mnt)
+		path_release(&root_parent);
+	if (parent_nd.mnt != new_nd.mnt)
+		path_release(&parent_nd);
 out2:
 	up(&old_nd.dentry->d_inode->i_zombie);
 	up(&mount_sem);
@@ -1769,7 +1774,7 @@
 		return error;
 	}
 	/* FIXME: we should hold i_zombie on nd.dentry */
-	move_vfsmnt(old_rootmnt, nd.dentry, nd.mnt, "/dev/root.old");
+	move_vfsmnt(old_rootmnt, &nd, "/dev/root.old");
 	mntput(old_rootmnt);
 	path_release(&nd);
 	return 0;

