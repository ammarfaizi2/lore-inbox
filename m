Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273452AbRINTCy>; Fri, 14 Sep 2001 15:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273450AbRINTCg>; Fri, 14 Sep 2001 15:02:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30372 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273449AbRINTCN>;
	Fri, 14 Sep 2001 15:02:13 -0400
Date: Fri, 14 Sep 2001 15:02:31 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] lazy umount (2/4)
In-Reply-To: <Pine.GSO.4.21.0109141427070.11172-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0109141502090.11172-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 2/4:
	Added minimal rootfs (read-only root directory - absolute minimum,
just to have something to go with root vfsmount), Now we have a fixed
root vfsmount and that allows to kill a lot of special-casing,

diff -urN S10-pre9-move_vfsmnt/fs/super.c S10-pre9-root_vfsmnt/fs/super.c
--- S10-pre9-move_vfsmnt/fs/super.c	Fri Sep 14 14:02:32 2001
+++ S10-pre9-root_vfsmnt/fs/super.c	Fri Sep 14 14:03:34 2001
@@ -280,6 +280,7 @@
 }
 
 static LIST_HEAD(vfsmntlist);
+static struct vfsmount *root_vfsmnt;
 
 static struct list_head *mount_hashtable;
 static int hash_mask, hash_bits;
@@ -346,52 +347,6 @@
 	nd->dentry->d_mounted++;
 }
 
-/**
- *	add_vfsmnt - add a new mount node
- *	@nd: location of mountpoint or %NULL if we want a root node
- *	@root: root of (sub)tree to be mounted
- *	@dev_name: device name to show in /proc/mounts or %NULL (for "none").
- *
- *	This is VFS idea of mount. New node is allocated, bound to a tree
- *	we are mounting and optionally (OK, usually) registered as mounted
- *	on a given mountpoint. Returns a pointer to new node or %NULL in
- *	case of failure.
- *
- *	Potential reason for failure (aside of trivial lack of memory) is a
- *	deleted mountpoint. Caller must hold ->i_zombie on mountpoint
- *	dentry (if any).
- */
-
-static struct vfsmount *add_vfsmnt(struct dentry *root, const char *dev_name)
-{
-	struct vfsmount *mnt;
-	struct super_block *sb = root->d_inode->i_sb;
-	char *name;
-
-	mnt = alloc_vfsmnt();
-	if (!mnt)
-		goto out;
-
-	/* It may be NULL, but who cares? */
-	if (dev_name) {
-		name = kmalloc(strlen(dev_name)+1, GFP_KERNEL);
-		if (name) {
-			strcpy(name, dev_name);
-			mnt->mnt_devname = name;
-		}
-	}
-	mnt->mnt_sb = sb;
-	mnt->mnt_root = dget(root);
-	mnt->mnt_mountpoint = mnt->mnt_root;
-	mnt->mnt_parent = mnt;
-
-	spin_lock(&dcache_lock);
-	list_add(&mnt->mnt_list, vfsmntlist.prev);
-	spin_unlock(&dcache_lock);
-out:
-	return mnt;
-}
-
 static struct vfsmount *clone_mnt(struct vfsmount *old, struct dentry *root)
 {
 	char *name = old->mnt_devname;
@@ -1200,8 +1155,7 @@
 		list_del(&mnt->mnt_list);
 		spin_unlock(&dcache_lock);
 		mntput(mnt);
-		if (parent_nd.mnt != mnt)
-			path_release(&parent_nd);
+		path_release(&parent_nd);
 		return 0;
 	}
 	spin_unlock(&dcache_lock);
@@ -1241,8 +1195,7 @@
 	list_del(&mnt->mnt_list);
 	spin_unlock(&dcache_lock);
 	mntput(mnt);
-	if (parent_nd.mnt != mnt)
-		path_release(&parent_nd);
+	path_release(&parent_nd);
 	return 0;
 }
 
@@ -1601,6 +1554,7 @@
 
 void __init mount_root(void)
 {
+	struct nameidata root_nd;
 	struct file_system_type * fs_type;
 	struct super_block * sb;
 	struct vfsmount *vfsmnt;
@@ -1610,6 +1564,7 @@
 	void *handle;
 	char path[64];
 	int path_start = -1;
+	char *name = "/dev/root";
 
 #ifdef CONFIG_ROOT_NFS
 	void *data;
@@ -1746,13 +1701,26 @@
 		fs_type->name,
 		(sb->s_flags & MS_RDONLY) ? " readonly" : "");
 	if (path_start >= 0) {
+		name = path + path_start;
 		devfs_mk_symlink (NULL, "root", DEVFS_FL_DEFAULT,
-				  path + 5 + path_start, NULL, NULL);
-		memcpy (path + path_start, "/dev/", 5);
-		vfsmnt = add_vfsmnt(sb->s_root, path + path_start);
+				  name + 5, NULL, NULL);
+		memcpy (name, "/dev/", 5);
 	}
-	else
-		vfsmnt = add_vfsmnt(sb->s_root, "/dev/root");
+	vfsmnt = alloc_vfsmnt();
+	if (!vfsmnt)
+		panic("VFS: alloc_vfsmnt failed for root fs");
+
+	vfsmnt->mnt_devname = kmalloc(strlen(name)+1, GFP_KERNEL);
+	if (vfsmnt->mnt_devname)
+		strcpy(vfsmnt->mnt_devname, name);
+	vfsmnt->mnt_sb = sb;
+	vfsmnt->mnt_root = dget(sb->s_root);
+
+	root_nd.mnt = root_vfsmnt;
+	root_nd.dentry = root_vfsmnt->mnt_sb->s_root;
+	graft_tree(vfsmnt, &root_nd);
+	mntput(vfsmnt);
+
 	/* FIXME: if something will try to umount us right now... */
 	if (vfsmnt) {
 		set_fs_root(current->fs, vfsmnt, sb->s_root);
@@ -1761,10 +1729,8 @@
 			bdput(bdev); /* sb holds a reference */
 		return;
 	}
-	panic("VFS: add_vfsmnt failed for root fs");
 }
 
-
 static void chroot_fs_refs(struct dentry *old_root,
 			   struct vfsmount *old_rootmnt,
 			   struct dentry *new_root,
@@ -1878,15 +1844,12 @@
 	detach_mnt(new_nd.mnt, &parent_nd);
 	detach_mnt(root_mnt, &root_parent);
 	attach_mnt(root_mnt, &old_nd);
-	if (root_parent.mnt != root_mnt)
-		attach_mnt(new_nd.mnt, &root_parent);
+	attach_mnt(new_nd.mnt, &root_parent);
 	spin_unlock(&dcache_lock);
 	chroot_fs_refs(root,root_mnt,new_nd.dentry,new_nd.mnt);
 	error = 0;
-	if (root_parent.mnt != root_mnt)
-		path_release(&root_parent);
-	if (parent_nd.mnt != new_nd.mnt)
-		path_release(&parent_nd);
+	path_release(&root_parent);
+	path_release(&parent_nd);
 out2:
 	up(&old_nd.dentry->d_inode->i_zombie);
 	up(&mount_sem);
@@ -1959,24 +1922,19 @@
 		if (!blivet) {
 			spin_lock(&dcache_lock);
 			list_del(&old_rootmnt->mnt_list);
-			if (atomic_read(&old_rootmnt->mnt_count) > 2) {
-				spin_unlock(&dcache_lock);
-				mntput(old_rootmnt);
-				blivet = -EBUSY;
-			} else {
-				spin_unlock(&dcache_lock);
-				mntput(old_rootmnt);
-				if (parent_nd.mnt != old_rootmnt)
-					path_release(&parent_nd);
-				mntput(old_rootmnt);
-				ioctl_by_bdev(ramdisk, BLKFLSBUF, 0);
-				printk("okay\n");
-				error = 0;
-			}
+			spin_unlock(&dcache_lock);
+			mntput(old_rootmnt);
+			mntput(old_rootmnt);
+			blivet = ioctl_by_bdev(ramdisk, BLKFLSBUF, 0);
+			path_release(&parent_nd);
 			blkdev_put(ramdisk, BDEV_FS);
 		}
-		if (blivet)
+		if (blivet) {
 			printk(KERN_ERR "error %d\n", blivet);
+		} else  {
+			printk("okay\n");
+			error = 0;
+		}
 		kfree(new_devname);
 		return error;
 	}
@@ -1991,8 +1949,7 @@
 	spin_unlock(&dcache_lock);
 
 	/* put the old stuff */
-	if (parent_nd.mnt != old_rootmnt)
-		path_release(&parent_nd);
+	path_release(&parent_nd);
 	mntput(old_rootmnt);
 	path_release(&nd);
 	return 0;
@@ -2000,6 +1957,54 @@
 
 #endif
 
+/*
+ * Absolutely minimal fake fs - only empty root directory and nothing else.
+ * In 2.5 we'll use ramfs or tmpfs, but for now it's all we need - just
+ * something to go with root vfsmount.
+ */
+static struct dentry *rootfs_lookup(struct inode *dir, struct dentry *dentry)
+{
+	d_add(dentry, NULL);
+	return NULL;
+}
+static struct file_operations rootfs_dir_operations = {
+	read:		generic_read_dir,
+	readdir:	dcache_readdir,
+};
+static struct inode_operations rootfs_dir_inode_operations = {
+	lookup:		rootfs_lookup,
+};
+static struct super_block *rootfs_read_super(struct super_block * sb, void * data, int silent)
+{
+	struct inode * inode;
+	struct dentry * root;
+	static struct super_operations s_ops = {};
+	sb->s_op = &s_ops;
+	inode = new_inode(sb);
+	if (!inode)
+		return NULL;
+	inode->i_mode = S_IFDIR|0555;
+	inode->i_uid = inode->i_gid = 0;
+	inode->i_op = &rootfs_dir_inode_operations;
+	inode->i_fop = &rootfs_dir_operations;
+	root = d_alloc_root(inode);
+	if (!root) {
+		iput(inode);
+		return NULL;
+	}
+	sb->s_root = root;
+	return sb;
+}
+static DECLARE_FSTYPE(root_fs_type, "rootfs", rootfs_read_super, FS_NOMOUNT);
+
+static void __init init_mount_tree(void)
+{
+	register_filesystem(&root_fs_type);
+	root_vfsmnt = do_kern_mount("rootfs", 0, "rootfs", NULL);
+	if (IS_ERR(root_vfsmnt))
+		panic("can't allocate root vfsmount");
+}
+
 void __init mnt_init(unsigned long mempages)
 {
 	struct list_head *d;
@@ -2055,4 +2060,5 @@
 		d++;
 		i--;
 	} while (i);
+	init_mount_tree();
 }


