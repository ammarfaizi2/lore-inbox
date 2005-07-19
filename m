Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVGSJox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVGSJox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 05:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVGSJox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 05:44:53 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:59245 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S261515AbVGSJow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 05:44:52 -0400
Message-ID: <42DCCBFD.6070504@tu-harburg.de>
Date: Tue, 19 Jul 2005 11:46:37 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
References: <42D72705.8010306@tu-harburg.de> <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------080802070803020104080804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080802070803020104080804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> I really think you should update the "simple_xxx()" functions instead, and 
> thus make this happen for _any_ filesystem that uses the simple fs helper 
> functions.
> 

Ok, I revised the patch. This is just the first step with changes to 
libfs and ramfs.

To move the directory i_size handling completely to libfs it is 
necessary to allocate the inodes in libfs. Therefore, simple_get_inode() 
and simple_mknod_init() (honestly, I don't like that name) are 
introduced. simple_mknod_init() uses a callback mechanism to initialize 
the file system specific stuff of the inodes.

What do you think of it?

Jan

--------------080802070803020104080804
Content-Type: text/x-patch;
 name="libfs_bogo_dirent_size.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libfs_bogo_dirent_size.diff"

 fs/libfs.c         |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/fs.h |    7 +++++
 2 files changed, 72 insertions(+), 1 deletion(-)

Index: linux-2.6/fs/libfs.c
===================================================================
--- linux-2.6.orig/fs/libfs.c
+++ linux-2.6/fs/libfs.c
@@ -238,13 +238,72 @@ Enomem:
 	return ERR_PTR(-ENOMEM);
 }
 
+struct inode *simple_get_inode(struct super_block *sb, int mode,
+			       int (*init)(struct inode *, void *), void *arg)
+{
+	struct inode * inode = new_inode(sb);
+
+	if (!inode)
+		return ERR_PTR(-ENOSPC);
+
+	inode->i_mode = mode;
+	inode->i_uid = current->fsuid;
+	inode->i_gid = current->fsgid;
+	inode->i_blksize = sb->s_blocksize;
+	inode->i_blocks = 0;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+
+	if (S_ISDIR(mode)) {
+		/* directory inodes start with i_nlink == 2 (for "." entry) */
+		inode->i_nlink++;
+		/* i_size for "." and ".." */
+		inode->i_size = 2 * SIMPLE_BOGO_DIRENT_SIZE;
+	}
+
+	if (init) {
+		int error = init(inode, arg);
+		if (error) {
+			iput(inode);
+			inode = ERR_PTR(error);
+		}
+	}
+
+	return inode;
+}
+
+int simple_mknod_init(struct inode *dir, struct dentry *dentry, int mode,
+		      int (*init)(struct inode *, void *), void *arg)
+{
+	struct inode * inode;
+
+	inode = simple_get_inode(dir->i_sb, mode, init, arg);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	if (dir->i_mode & S_ISGID) {
+		inode->i_gid = dir->i_gid;
+		if (S_ISDIR(mode))
+			inode->i_mode |= S_ISGID;
+	}
+
+	if (S_ISDIR(mode))
+		dir->i_nlink++;
+
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_size += SIMPLE_BOGO_DIRENT_SIZE;
+	d_instantiate(dentry, inode);
+	dget(dentry);	/* pin the dentry in core */
+	return 0;
+}
+
 int simple_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = old_dentry->d_inode;
 
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	inode->i_ctime = dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	inode->i_nlink++;
 	atomic_inc(&inode->i_count);
+	dir->i_size += SIMPLE_BOGO_DIRENT_SIZE;
 	dget(dentry);
 	d_instantiate(dentry, inode);
 	return 0;
@@ -276,6 +335,7 @@ int simple_unlink(struct inode *dir, str
 
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	inode->i_nlink--;
+	dir->i_size -= SIMPLE_BOGO_DIRENT_SIZE;
 	dput(dentry);
 	return 0;
 }
@@ -311,6 +371,8 @@ int simple_rename(struct inode *old_dir,
 
 	old_dir->i_ctime = old_dir->i_mtime = new_dir->i_ctime =
 		new_dir->i_mtime = inode->i_ctime = CURRENT_TIME;
+	old_dir->i_size -= SIMPLE_BOGO_DIRENT_SIZE;
+	new_dir->i_size += SIMPLE_BOGO_DIRENT_SIZE;
 
 	return 0;
 }
@@ -629,6 +691,8 @@ EXPORT_SYMBOL(simple_empty);
 EXPORT_SYMBOL(d_alloc_name);
 EXPORT_SYMBOL(simple_fill_super);
 EXPORT_SYMBOL(simple_getattr);
+EXPORT_SYMBOL(simple_get_inode);
+EXPORT_SYMBOL(simple_mknod_init);
 EXPORT_SYMBOL(simple_link);
 EXPORT_SYMBOL(simple_lookup);
 EXPORT_SYMBOL(simple_pin_fs);
Index: linux-2.6/include/linux/fs.h
===================================================================
--- linux-2.6.orig/include/linux/fs.h
+++ linux-2.6/include/linux/fs.h
@@ -1624,6 +1624,11 @@ extern loff_t dcache_dir_lseek(struct fi
 extern int dcache_readdir(struct file *, void *, filldir_t);
 extern int simple_getattr(struct vfsmount *, struct dentry *, struct kstat *);
 extern int simple_statfs(struct super_block *, struct kstatfs *);
+extern struct inode *simple_get_inode(struct super_block *, int ,
+				      int (*init)(struct inode *, void *),
+				      void *);
+extern int simple_mknod_init(struct inode *, struct dentry *, int ,
+			    int (*init)(struct inode *, void *), void *);
 extern int simple_link(struct dentry *, struct inode *, struct dentry *);
 extern int simple_unlink(struct inode *, struct dentry *);
 extern int simple_rmdir(struct inode *, struct dentry *);
@@ -1744,6 +1749,8 @@ ssize_t simple_attr_read(struct file *fi
 ssize_t simple_attr_write(struct file *file, const char __user *buf,
 			  size_t len, loff_t *ppos);
 
+/* Pretend that each dirent is of this size in simple directories */
+#define SIMPLE_BOGO_DIRENT_SIZE 20
 
 #ifdef CONFIG_SECURITY
 static inline char *alloc_secdata(void)

--------------080802070803020104080804
Content-Type: text/x-patch;
 name="ramfs_bogo_dirent_size.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ramfs_bogo_dirent_size.diff"

 fs/ramfs/inode.c |  118 ++++++++++++++++++++++---------------------------------
 1 files changed, 48 insertions(+), 70 deletions(-)

Index: linux-2.6/fs/ramfs/inode.c
===================================================================
--- linux-2.6.orig/fs/ramfs/inode.c
+++ linux-2.6/fs/ramfs/inode.c
@@ -50,40 +50,40 @@ static struct backing_dev_info ramfs_bac
 			  BDI_CAP_READ_MAP | BDI_CAP_WRITE_MAP | BDI_CAP_EXEC_MAP,
 };
 
-struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev)
-{
-	struct inode * inode = new_inode(sb);
-
-	if (inode) {
-		inode->i_mode = mode;
-		inode->i_uid = current->fsuid;
-		inode->i_gid = current->fsgid;
-		inode->i_blksize = PAGE_CACHE_SIZE;
-		inode->i_blocks = 0;
-		inode->i_mapping->a_ops = &ramfs_aops;
-		inode->i_mapping->backing_dev_info = &ramfs_backing_dev_info;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-		switch (mode & S_IFMT) {
-		default:
-			init_special_inode(inode, mode, dev);
-			break;
-		case S_IFREG:
-			inode->i_op = &ramfs_file_inode_operations;
-			inode->i_fop = &ramfs_file_operations;
-			break;
-		case S_IFDIR:
-			inode->i_op = &ramfs_dir_inode_operations;
-			inode->i_fop = &simple_dir_operations;
-
-			/* directory inodes start off with i_nlink == 2 (for "." entry) */
-			inode->i_nlink++;
-			break;
-		case S_IFLNK:
-			inode->i_op = &page_symlink_inode_operations;
-			break;
-		}
+struct ramfs_init_args {
+	dev_t dev;
+	const char *name;
+};
+
+static int ramfs_inode_init(struct inode *inode, void *__arg)
+{
+	struct ramfs_init_args *arg = (struct ramfs_init_args *)__arg;
+	int len;
+	int err = 0;
+
+	inode->i_mapping->a_ops = &ramfs_aops;
+	inode->i_mapping->backing_dev_info = &ramfs_backing_dev_info;
+
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFREG:
+		inode->i_op = &ramfs_file_inode_operations;
+		inode->i_fop = &ramfs_file_operations;
+		break;
+	case S_IFDIR:
+		inode->i_op = &ramfs_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+		break;
+	case S_IFLNK:
+		inode->i_op = &page_symlink_inode_operations;
+		len = strlen(arg->symname)+1;
+		err = page_symlink(inode, arg->symname, len);
+		break;
+	default:
+		init_special_inode(inode, inode->i_mode, arg->dev);
+		break;
 	}
-	return inode;
+
+	return err;
 }
 
 /*
@@ -93,53 +93,31 @@ struct inode *ramfs_get_inode(struct sup
 static int
 ramfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
-	struct inode * inode = ramfs_get_inode(dir->i_sb, mode, dev);
-	int error = -ENOSPC;
+	struct ramfs_init_args args = { .dev = dev };
 
-	if (inode) {
-		if (dir->i_mode & S_ISGID) {
-			inode->i_gid = dir->i_gid;
-			if (S_ISDIR(mode))
-				inode->i_mode |= S_ISGID;
-		}
-		d_instantiate(dentry, inode);
-		dget(dentry);	/* Extra count - pin the dentry in core */
-		error = 0;
-	}
-	return error;
+	return simple_mknod_init(dir, dentry, mode,
+				 ramfs_inode_init, (void *) &args);
 }
 
 static int ramfs_mkdir(struct inode * dir, struct dentry * dentry, int mode)
 {
-	int retval = ramfs_mknod(dir, dentry, mode | S_IFDIR, 0);
-	if (!retval)
-		dir->i_nlink++;
-	return retval;
+	return simple_mknod_init(dir, dentry, mode|S_IFDIR,
+				 ramfs_inode_init, NULL);
 }
 
 static int ramfs_create(struct inode *dir, struct dentry *dentry, int mode, struct nameidata *nd)
 {
-	return ramfs_mknod(dir, dentry, mode | S_IFREG, 0);
+	return simple_mknod_init(dir, dentry, mode|S_IFREG,
+				 ramfs_inode_init, NULL);
 }
 
-static int ramfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
+static int ramfs_symlink(struct inode *dir, struct dentry *dentry,
+			 const char *name)
 {
-	struct inode *inode;
-	int error = -ENOSPC;
+	struct ramfs_init_args args = { .name = name };
 
-	inode = ramfs_get_inode(dir->i_sb, S_IFLNK|S_IRWXUGO, 0);
-	if (inode) {
-		int l = strlen(symname)+1;
-		error = page_symlink(inode, symname, l);
-		if (!error) {
-			if (dir->i_mode & S_ISGID)
-				inode->i_gid = dir->i_gid;
-			d_instantiate(dentry, inode);
-			dget(dentry);
-		} else
-			iput(inode);
-	}
-	return error;
+	return simple_mknod_init(dir, dentry, S_IFLNK|S_IRWXUGO,
+				 ramfs_inode_init, (void *) &args);
 }
 
 static struct address_space_operations ramfs_aops = {
@@ -189,9 +167,9 @@ static int ramfs_fill_super(struct super
 	sb->s_magic = RAMFS_MAGIC;
 	sb->s_op = &ramfs_ops;
 	sb->s_time_gran = 1;
-	inode = ramfs_get_inode(sb, S_IFDIR | 0755, 0);
-	if (!inode)
-		return -ENOMEM;
+	inode = simple_get_inode(sb, S_IFDIR|0755, ramfs_inode_init, NULL);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode); // -ENOMEM
 
 	root = d_alloc_root(inode);
 	if (!root) {

--------------080802070803020104080804--
