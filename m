Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289172AbSAMM4p>; Sun, 13 Jan 2002 07:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289174AbSAMM4h>; Sun, 13 Jan 2002 07:56:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:45044 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289172AbSAMM4W>;
	Sun, 13 Jan 2002 07:56:22 -0500
Date: Sun, 13 Jan 2002 07:56:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Roskin <proski@gnu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: binfmt_misc module gets stuck
In-Reply-To: <Pine.LNX.4.43.0201081531180.1744-100000@marabou.research.att.com>
Message-ID: <Pine.GSO.4.21.0201130746400.26122-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Jan 2002, Pavel Roskin wrote:

> I believe that kern_mount() and kern_umount() are remnants from the time
> when the binfmt_misc filesystem was mounted automatically by the kernel.  
> Removing them preserves all functionality (I did check it) while allows
> unloading binfmt_misc if and only if the binfmt_misc filesystem is not
> used for any mounts.

That's wrong - you are using that tree to store information (entries
you've defined), so the lifetime should be "there are mounts or there
are entries".  Which is actually pretty easy to implement - see if
the following (completely untested) patch works for you.  It should
give the following rules:
	if you had defined some entries - they stay alive until you remove
them, mounted or not (i.e. umount /proc/sys/binfmt_misc && mount ... will
not destroy any state)
	if there is no entries and fs is not mounted - you can rmmod.


diff -urN C2-pre11-grow_page_buffers/fs/binfmt_misc.c C2-pre11-current/fs/binfmt_misc.c
--- C2-pre11-grow_page_buffers/fs/binfmt_misc.c	Sat Oct 20 22:14:42 2001
+++ C2-pre11-current/fs/binfmt_misc.c	Sun Jan 13 06:53:30 2002
@@ -49,6 +49,8 @@
 } Node;
 
 static rwlock_t entries_lock __attribute__((unused)) = RW_LOCK_UNLOCKED;
+static struct vfsmount *bm_mnt;
+static int entry_count = 0;
 
 /* 
  * Check if we support the binfmt
@@ -390,10 +392,15 @@
 	Node *e = inode->u.generic_ip;
 
 	if (e) {
+		struct vfsmount *mnt;
 		write_lock(&entries_lock);
 		list_del(&e->list);
+		mnt = bm_mnt;
+		if (!--entry_count)
+			bm_mnt = NULL;
 		write_unlock(&entries_lock);
 		kfree(e);
+		mntput(mnt);
 	}
 }
 
@@ -404,8 +411,7 @@
 	write_lock(&entries_lock);
 	dentry = e->dentry;
 	if (dentry) {
-		list_del(&e->list);
-		INIT_LIST_HEAD(&e->list);
+		list_del_init(&e->list);
 		e->dentry = NULL;
 	}
 	write_unlock(&entries_lock);
@@ -484,12 +490,16 @@
 	write:		bm_entry_write,
 };
 
+static struct file_system_type bm_fs_type;
+
 /* /register */
 
 static ssize_t bm_register_write(struct file *file, const char *buffer,
 			       size_t count, loff_t *ppos)
 {
 	Node *e;
+	struct inode *inode;
+	struct vfsmount *mnt = NULL;
 	struct dentry *root, *dentry;
 	struct super_block *sb = file->f_vfsmnt->mnt_sb;
 	int err = 0;
@@ -503,31 +513,52 @@
 	down(&root->d_inode->i_sem);
 	dentry = lookup_one_len(e->name, root, strlen(e->name));
 	err = PTR_ERR(dentry);
-	if (!IS_ERR(dentry)) {
-		down(&root->d_inode->i_zombie);
-		if (dentry->d_inode) {
-			err = -EEXIST;
-		} else {
-			struct inode * inode = bm_get_inode(sb, S_IFREG | 0644);
-			err = -ENOMEM;
+	if (IS_ERR(dentry))
+		goto out;
 
-			if (inode) {
-				write_lock(&entries_lock);
+	down(&root->d_inode->i_zombie);
 
-				e->dentry = dget(dentry);
-				inode->u.generic_ip = e;
-				inode->i_fop = &bm_entry_operations;
-				d_instantiate(dentry, inode);
+	err = -EEXIST;
+	if (dentry->d_inode)
+		goto out2;
 
-				list_add(&e->list, &entries);
-				write_unlock(&entries_lock);
+	inode = bm_get_inode(sb, S_IFREG | 0644);
 
-				err = 0;
-			}
+	err = -ENOMEM;
+	if (!inode)
+		goto out2;
+
+	write_lock(&entries_lock);
+	if (!bm_mnt) {
+		write_unlock(&entries_lock);
+		mnt = kern_mount(&bm_fs_type);
+		if (IS_ERR(mnt)) {
+			err = PTR_ERR(mnt);
+			iput(inode);
+			inode = NULL;
+			goto out2;
 		}
-		up(&root->d_inode->i_zombie);
-		dput(dentry);
+		write_lock(&entries_lock);
+		if (!bm_mnt)
+			bm_mnt = mnt;
 	}
+	mntget(bm_mnt);
+	entry_count++;
+
+	e->dentry = dget(dentry);
+	inode->u.generic_ip = e;
+	inode->i_fop = &bm_entry_operations;
+	d_instantiate(dentry, inode);
+
+	list_add(&e->list, &entries);
+	write_unlock(&entries_lock);
+
+	mntput(mnt);
+	err = 0;
+out2:
+	up(&root->d_inode->i_zombie);
+	dput(dentry);
+out:
 	up(&root->d_inode->i_sem);
 	dput(root);
 
@@ -687,23 +718,13 @@
 
 static DECLARE_FSTYPE(bm_fs_type, "binfmt_misc", bm_read_super, FS_SINGLE|FS_LITTER);
 
-static struct vfsmount *bm_mnt;
-
 static int __init init_misc_binfmt(void)
 {
 	int err = register_filesystem(&bm_fs_type);
 	if (!err) {
-		bm_mnt = kern_mount(&bm_fs_type);
-		err = PTR_ERR(bm_mnt);
-		if (IS_ERR(bm_mnt))
+		err = register_binfmt(&misc_format);
+		if (err)
 			unregister_filesystem(&bm_fs_type);
-		else {
-			err = register_binfmt(&misc_format);
-			if (err) {
-				unregister_filesystem(&bm_fs_type);
-				kern_umount(bm_mnt);
-			}
-		}
 	}
 	return err;
 }
@@ -712,7 +733,6 @@
 {
 	unregister_binfmt(&misc_format);
 	unregister_filesystem(&bm_fs_type);
-	kern_umount(bm_mnt);
 }
 
 EXPORT_NO_SYMBOLS;

