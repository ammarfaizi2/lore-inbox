Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262325AbSJQXq0>; Thu, 17 Oct 2002 19:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262328AbSJQXq0>; Thu, 17 Oct 2002 19:46:26 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:25915 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S262325AbSJQXqP>; Thu, 17 Oct 2002 19:46:15 -0400
Date: Fri, 18 Oct 2002 00:53:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 4/9 shmem fs cleanup
In-Reply-To: <Pine.LNX.4.44.0210180042480.7220-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210180051340.7220-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove obsolete shmem_fs_type: we were in some doubt whether safe yet
to do so, then found 2.5.4 typo changed it from 2.4's "shm" to "shmem"
ever since: nobody complained, delete it - we're "tmpfs" since 2.4.4.
Use libfs' simple_empty and simple_sync_file instead of homegrown.
Remove exit_shmem_fs, it fools people that this might be a module.
Allow for faint possibility that shm_mnt could not be initialized.

--- tmpfs3/Documentation/devices.txt	Wed Jul 17 04:05:27 2002
+++ tmpfs4/Documentation/devices.txt	Thu Oct 17 22:01:19 2002
@@ -2667,7 +2667,7 @@
 cannot be provided with standard device nodes.
 
 /dev/pts	devpts		PTY slave filesystem
-/dev/shm	shmfs		POSIX shared memory maintenance access
+/dev/shm	tmpfs		POSIX shared memory maintenance access
 
  ****	TERMINAL DEVICES
 
--- tmpfs3/mm/shmem.c	Thu Oct 17 22:01:09 2002
+++ tmpfs4/mm/shmem.c	Thu Oct 17 22:01:19 2002
@@ -1297,39 +1297,6 @@
 	return 0;
 }
 
-static inline int shmem_positive(struct dentry *dentry)
-{
-	return dentry->d_inode && !d_unhashed(dentry);
-}
-
-/*
- * Check that a directory is empty (this works
- * for regular files too, they'll just always be
- * considered empty..).
- *
- * Note that an empty directory can still have
- * children, they just all have to be negative..
- */
-static int shmem_empty(struct dentry *dentry)
-{
-	struct list_head *list;
-
-	spin_lock(&dcache_lock);
-	list = dentry->d_subdirs.next;
-
-	while (list != &dentry->d_subdirs) {
-		struct dentry *de = list_entry(list, struct dentry, d_child);
-
-		if (shmem_positive(de)) {
-			spin_unlock(&dcache_lock);
-			return 0;
-		}
-		list = list->next;
-	}
-	spin_unlock(&dcache_lock);
-	return 1;
-}
-
 static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
@@ -1343,7 +1310,7 @@
 
 static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	if (!shmem_empty(dentry))
+	if (!simple_empty(dentry))
 		return -ENOTEMPTY;
 
 	dir->i_nlink--;
@@ -1361,7 +1328,7 @@
 	struct inode *inode = old_dentry->d_inode;
 	int they_are_dirs = S_ISDIR(inode->i_mode);
 
-	if (!shmem_empty(new_dentry))
+	if (!simple_empty(new_dentry))
 		return -ENOTEMPTY;
 
 	if (new_dentry->d_inode) {
@@ -1546,15 +1513,10 @@
 	unsigned long max_blocks = sbinfo->max_blocks;
 	unsigned long max_inodes = sbinfo->max_inodes;
 
-	if (shmem_parse_options (data, NULL, NULL, NULL, &max_blocks, &max_inodes))
+	if (shmem_parse_options(data, NULL, NULL, NULL, &max_blocks, &max_inodes))
 		return -EINVAL;
 	return shmem_set_size(sbinfo, max_blocks, max_inodes);
 }
-
-int shmem_sync_file(struct file *file, struct dentry *dentry, int datasync)
-{
-	return 0;
-}
 #endif
 
 static int shmem_fill_super(struct super_block *sb, void *data, int silent)
@@ -1583,7 +1545,7 @@
 	blocks = inodes = si.totalram / 2;
 
 #ifdef CONFIG_TMPFS
-	if (shmem_parse_options (data, &mode, &uid, &gid, &blocks, &inodes)) {
+	if (shmem_parse_options(data, &mode, &uid, &gid, &blocks, &inodes)) {
 		err = -EINVAL;
 		goto failed;
 	}
@@ -1686,7 +1648,7 @@
 #ifdef CONFIG_TMPFS
 	.read		= shmem_file_read,
 	.write		= shmem_file_write,
-	.fsync		= shmem_sync_file,
+	.fsync		= simple_sync_file,
 #endif
 };
 
@@ -1731,15 +1693,6 @@
 	return get_sb_nodev(fs_type, flags, data, shmem_fill_super);
 }
 
-#ifdef CONFIG_TMPFS
-/* type "shm" will be tagged obsolete in 2.5 */
-static struct file_system_type shmem_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "shmem",
-	.get_sb		= shmem_get_sb,
-	.kill_sb	= kill_litter_super,
-};
-#endif
 static struct file_system_type tmpfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "tmpfs",
@@ -1748,10 +1701,9 @@
 };
 static struct vfsmount *shm_mnt;
 
-static int __init init_shmem_fs(void)
+static int __init init_tmpfs(void)
 {
 	int error;
-	struct vfsmount *res;
 
 	error = init_inodecache();
 	if (error)
@@ -1763,52 +1715,31 @@
 		goto out2;
 	}
 #ifdef CONFIG_TMPFS
-	error = register_filesystem(&shmem_fs_type);
-	if (error) {
-		printk(KERN_ERR "Could not register shm fs\n");
-		goto out1;
-	}
 	devfs_mk_dir(NULL, "shm", NULL);
 #endif
-	res = kern_mount(&tmpfs_fs_type);
-	if (IS_ERR (res)) {
-		error = PTR_ERR(res);
-		printk(KERN_ERR "could not kern_mount tmpfs\n");
-		goto out;
+	shm_mnt = kern_mount(&tmpfs_fs_type);
+	if (IS_ERR(shm_mnt)) {
+		error = PTR_ERR(shm_mnt);
+		printk(KERN_ERR "Could not kern_mount tmpfs\n");
+		goto out1;
 	}
-	shm_mnt = res;
 
 	/* The internal instance should not do size checking */
-	shmem_set_size(SHMEM_SB(res->mnt_sb), ULONG_MAX, ULONG_MAX);
+	shmem_set_size(SHMEM_SB(shm_mnt->mnt_sb), ULONG_MAX, ULONG_MAX);
 	return 0;
 
-out:
-#ifdef CONFIG_TMPFS
-	unregister_filesystem(&shmem_fs_type);
 out1:
-#endif
 	unregister_filesystem(&tmpfs_fs_type);
 out2:
 	destroy_inodecache();
 out3:
+	shm_mnt = ERR_PTR(error);
 	return error;
 }
-
-static void __exit exit_shmem_fs(void)
-{
-#ifdef CONFIG_TMPFS
-	unregister_filesystem(&shmem_fs_type);
-#endif
-	unregister_filesystem(&tmpfs_fs_type);
-	mntput(shm_mnt);
-	destroy_inodecache();
-}
-
-module_init(init_shmem_fs)
-module_exit(exit_shmem_fs)
+module_init(init_tmpfs)
 
 /*
- * shmem_file_setup - get an unlinked file living in shmem fs
+ * shmem_file_setup - get an unlinked file living in tmpfs
  *
  * @name: name for dentry (to be seen in /proc/<pid>/maps
  * @size: size to be set for the file
@@ -1822,6 +1753,9 @@
 	struct dentry *dentry, *root;
 	struct qstr this;
 
+	if (IS_ERR(shm_mnt))
+		return (void *)shm_mnt;
+
 	if (size > SHMEM_MAX_BYTES)
 		return ERR_PTR(-EINVAL);
 

