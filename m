Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316896AbSGBUfU>; Tue, 2 Jul 2002 16:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSGBUfT>; Tue, 2 Jul 2002 16:35:19 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:40199 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S316896AbSGBUfS>; Tue, 2 Jul 2002 16:35:18 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: viro@math.psu.edu
cc: pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Filter /proc/mounts based on process root dir
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Jul 2002 13:37:22 -0700
Message-Id: <E17PUOo-0003ol-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch causes /proc/mounts to only display entries for mountpoints
within the current process root. This makes df and friends behave more
nicely in a chroot jail or with rootfs.

Most of the logic in proc_check_root() is moved to a new function,
is_namespace_subdir(), which checks whether the given mount/dentry
refers to a subdirectory of the process root directory in the current
namespace. show_vfsmount() now returns without adding an output line if
is_namespace_subdir() returns false for a given mountpoint.

Paul

diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/namespace.c linux-2.5.24-mounts/fs/namespace.c
--- linux-2.5.24/fs/namespace.c	Wed Jun 26 01:07:20 2002
+++ linux-2.5.24-mounts/fs/namespace.c	Wed Jun 26 01:17:42 2002
@@ -38,6 +38,36 @@
 	return tmp & hash_mask;
 }
 
+/* Check whether the given mount/dentry is contained within our root */
+int is_namespace_subdir(struct vfsmount *vfsmnt, struct dentry *dentry) {
+    
+	struct vfsmount *our_vfsmnt;
+	struct dentry   *our_root;
+	int res = 0;
+	
+	spin_lock(&dcache_lock); /* also protects access to current->fs */
+	
+	our_vfsmnt = current->fs->rootmnt;
+	our_root = current->fs->root;
+
+	while(vfsmnt != our_vfsmnt) {
+		if(vfsmnt == vfsmnt->mnt_parent) 
+			goto out;
+		dentry = vfsmnt->mnt_mountpoint;
+		vfsmnt = vfsmnt->mnt_parent;
+	}
+	
+	if(!is_subdir(dentry, our_root))
+		goto out;
+	
+	res = 1;
+ out:
+	spin_unlock(&dcache_lock);
+	return res;
+}
+
+
+
 struct vfsmount *alloc_vfsmnt(char *name)
 {
 	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL); 
@@ -212,6 +242,9 @@
 	struct proc_fs_info *fs_infop;
 	char *path_buf, *path;
 
+	if(!is_namespace_subdir(mnt, mnt->mnt_root))
+		return 0;
+
 	path_buf = (char *) __get_free_page(GFP_KERNEL);
 	if (!path_buf)
 		return -ENOMEM;
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/fs/proc/base.c linux-2.5.24-mounts/fs/proc/base.c
--- linux-2.5.24/fs/proc/base.c	Tue Jun 18 19:11:46 2002
+++ linux-2.5.24-mounts/fs/proc/base.c	Wed Jun 26 01:19:01 2002
@@ -265,42 +265,19 @@
 
 static int proc_check_root(struct inode *inode)
 {
-	struct dentry *de, *base, *root;
-	struct vfsmount *our_vfsmnt, *vfsmnt, *mnt;
+	struct dentry *root;
+	struct vfsmount *mnt;
 	int res = 0;
 
 	if (proc_root_link(inode, &root, &vfsmnt)) /* Ewww... */
 		return -ENOENT;
-	read_lock(&current->fs->lock);
-	our_vfsmnt = mntget(current->fs->rootmnt);
-	base = dget(current->fs->root);
-	read_unlock(&current->fs->lock);
 
-	spin_lock(&dcache_lock);
-	de = root;
-	mnt = vfsmnt;
+	if(!is_namespace_subdir(mnt, root))
+		res = -EACCES;
 
-	while (vfsmnt != our_vfsmnt) {
-		if (vfsmnt == vfsmnt->mnt_parent)
-			goto out;
-		de = vfsmnt->mnt_mountpoint;
-		vfsmnt = vfsmnt->mnt_parent;
-	}
-
-	if (!is_subdir(de, base))
-		goto out;
-	spin_unlock(&dcache_lock);
-
-exit:
-	dput(base);
-	mntput(our_vfsmnt);
 	dput(root);
 	mntput(mnt);
 	return res;
-out:
-	spin_unlock(&dcache_lock);
-	res = -EACCES;
-	goto exit;
 }
 
 static int proc_permission(struct inode *inode, int mask)
diff -Naur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.24/include/linux/namespace.h linux-2.5.24-mounts/include/linux/namespace.h
--- linux-2.5.24/include/linux/namespace.h	Tue Jun 18 19:11:55 2002
+++ linux-2.5.24-mounts/include/linux/namespace.h	Tue Jun 25 19:35:25 2002
@@ -43,5 +43,6 @@
 	atomic_inc(&namespace->count);
 }
 
+extern int is_namespace_subdir(struct vfsmount *, struct dentry *);
 #endif
 #endif



