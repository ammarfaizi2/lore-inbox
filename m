Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbSJCWpC>; Thu, 3 Oct 2002 18:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261415AbSJCWpB>; Thu, 3 Oct 2002 18:45:01 -0400
Received: from holomorphy.com ([66.224.33.161]:17099 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261405AbSJCWoM>;
	Thu, 3 Oct 2002 18:44:12 -0400
Date: Thu, 3 Oct 2002 15:48:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu, mochel@osdl.org,
       akpm@zip.com.au
Subject: move ramfs' pure dcache manipulations into libfs.c
Message-ID: <20021003224859.GF12432@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@math.psu.edu, mochel@osdl.org, akpm@zip.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The simple_link(), simple_unlink(), simple_rename(), simple_sync_file(),
simple_rmdir(), and simple_empty() functions are easy to duplicate.
Basically, I duplicated them in an fs patch of mine, and Linus told me
to put them in libfs.c

Pat Mochel has acked the changes for driverfs (in that he'll convert
the stuff over when they're available from libfs), and my hugetlbfs
implementation was the thing that spurred the whole incident.


Here it is,
Bill


diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/fs/libfs.c hugetlbfs/fs/libfs.c
--- linux-2.5/fs/libfs.c	Wed Oct  2 20:14:48 2002
+++ hugetlbfs/fs/libfs.c	Thu Oct  3 15:42:44 2002
@@ -208,3 +208,73 @@
 	deactivate_super(s);
 	return ERR_PTR(-ENOMEM);
 }
+
+int simple_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = old_dentry->d_inode;
+
+	inode->i_nlink++;
+	atomic_inc(&inode->i_count);
+	dget(dentry);
+	d_instantiate(dentry, inode);
+	return 0;
+}
+
+static inline int simple_positive(struct dentry *dentry)
+{
+	return dentry->d_inode && !d_unhashed(dentry);
+}
+
+int simple_empty(struct dentry *dentry)
+{
+	struct dentry *child;
+	int ret = 0;
+
+	spin_lock(&dcache_lock);
+	list_for_each_entry(child, &dentry->d_subdirs, d_child)
+		if (simple_positive(child))
+			goto out;
+	ret = 1;
+out:
+	spin_unlock(&dcache_lock);
+	return ret;
+}
+
+int simple_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+
+	inode->i_nlink--;
+	dput(dentry);
+	return 0;
+}
+
+int simple_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	if (!simple_empty(dentry))
+		return -ENOTEMPTY;
+
+	dentry->d_inode->i_nlink--;
+	simple_unlink(dir, dentry);
+	dir->i_nlink--;
+	return 0;
+}
+
+int simple_rename(struct inode *old_dir, struct dentry *old_dentry, struct inode *new_dir, struct dentry *new_dentry)
+{
+	struct inode *inode;
+
+	if (!simple_empty(new_dentry))
+		return -ENOTEMPTY;
+
+	inode = new_dentry->d_inode;
+	if (inode) {
+		inode->i_nlink--;
+		dput(new_dentry);
+	}
+	if (S_ISDIR(old_dentry->d_inode->i_mode)) {
+		old_dir->i_nlink--;
+		new_dir->i_nlink++;
+	}
+	return 0;
+}
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/fs/ramfs/inode.c hugetlbfs/fs/ramfs/inode.c
--- linux-2.5/fs/ramfs/inode.c	Wed Oct  2 20:14:49 2002
+++ hugetlbfs/fs/ramfs/inode.c	Thu Oct  3 15:28:04 2002
@@ -155,102 +155,6 @@
 	return ramfs_mknod(dir, dentry, mode | S_IFREG, 0);
 }
 
-/*
- * Link a file..
- */
-static int ramfs_link(struct dentry *old_dentry, struct inode * dir, struct dentry * dentry)
-{
-	struct inode *inode = old_dentry->d_inode;
-
-	inode->i_nlink++;
-	atomic_inc(&inode->i_count);	/* New dentry reference */
-	dget(dentry);		/* Extra pinning count for the created dentry */
-	d_instantiate(dentry, inode);
-	return 0;
-}
-
-static inline int ramfs_positive(struct dentry *dentry)
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
-static int ramfs_empty(struct dentry *dentry)
-{
-	struct list_head *list;
-
-	spin_lock(&dcache_lock);
-	list = dentry->d_subdirs.next;
-
-	while (list != &dentry->d_subdirs) {
-		struct dentry *de = list_entry(list, struct dentry, d_child);
-
-		if (ramfs_positive(de)) {
-			spin_unlock(&dcache_lock);
-			return 0;
-		}
-		list = list->next;
-	}
-	spin_unlock(&dcache_lock);
-	return 1;
-}
-
-/*
- * Unlink a ramfs entry
- */
-static int ramfs_unlink(struct inode * dir, struct dentry *dentry)
-{
-	struct inode *inode = dentry->d_inode;
-
-	inode->i_nlink--;
-	dput(dentry);			/* Undo the count from "create" - this does all the work */
-	return 0;
-}
-
-static int ramfs_rmdir(struct inode * dir, struct dentry *dentry)
-{
-	int retval = -ENOTEMPTY;
-
-	if (ramfs_empty(dentry)) {
-		dentry->d_inode->i_nlink--;
-		ramfs_unlink(dir, dentry);
-		dir->i_nlink--;
-		retval = 0;
-	}
-	return retval;
-}
-
-/*
- * The VFS layer already does all the dentry stuff for rename,
- * we just have to decrement the usage count for the target if
- * it exists so that the VFS layer correctly free's it when it
- * gets overwritten.
- */
-static int ramfs_rename(struct inode * old_dir, struct dentry *old_dentry, struct inode * new_dir,struct dentry *new_dentry)
-{
-	int error = -ENOTEMPTY;
-
-	if (ramfs_empty(new_dentry)) {
-		struct inode *inode = new_dentry->d_inode;
-		if (inode) {
-			inode->i_nlink--;
-			dput(new_dentry);
-		}
-		if (S_ISDIR(old_dentry->d_inode->i_mode)) {
-			old_dir->i_nlink--;
-			new_dir->i_nlink++;
-		}
-		error = 0;
-	}
-	return error;
-}
 
 static int ramfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
 {
@@ -270,11 +174,6 @@
 	return error;
 }
 
-static int ramfs_sync_file(struct file * file, struct dentry *dentry, int datasync)
-{
-	return 0;
-}
-
 static struct address_space_operations ramfs_aops = {
 	.readpage	= ramfs_readpage,
 	.writepage	= fail_writepage,
@@ -286,20 +185,20 @@
 	.read		= generic_file_read,
 	.write		= generic_file_write,
 	.mmap		= generic_file_mmap,
-	.fsync		= ramfs_sync_file,
+	.fsync		= simple_sync_file,
 	.sendfile	= generic_file_sendfile,
 };
 
 static struct inode_operations ramfs_dir_inode_operations = {
 	.create		= ramfs_create,
 	.lookup		= simple_lookup,
-	.link		= ramfs_link,
-	.unlink		= ramfs_unlink,
+	.link		= simple_link,
+	.unlink		= simple_unlink,
 	.symlink	= ramfs_symlink,
 	.mkdir		= ramfs_mkdir,
-	.rmdir		= ramfs_rmdir,
+	.rmdir		= simple_rmdir,
 	.mknod		= ramfs_mknod,
-	.rename		= ramfs_rename,
+	.rename		= simple_rename,
 };
 
 static struct super_operations ramfs_ops = {
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/include/linux/fs.h hugetlbfs/include/linux/fs.h
--- linux-2.5/include/linux/fs.h	Wed Oct  2 20:14:55 2002
+++ hugetlbfs/include/linux/fs.h	Thu Oct  3 15:42:48 2002
@@ -1290,6 +1290,12 @@
 extern loff_t dcache_dir_lseek(struct file *, loff_t, int);
 extern int dcache_readdir(struct file *, void *, filldir_t);
 extern int simple_statfs(struct super_block *, struct statfs *);
+extern int simple_link(struct dentry *, struct inode *, struct dentry *);
+extern int simple_unlink(struct inode *, struct dentry *);
+extern int simple_rmdir(struct inode *, struct dentry *);
+extern int simple_rename(struct inode *, struct dentry *, struct inode *, struct dentry *);
+extern int simple_sync_file(struct file *, struct dentry *, int);
+extern int simple_empty(struct dentry *);
 extern struct dentry *simple_lookup(struct inode *, struct dentry *);
 extern ssize_t generic_read_dir(struct file *, char *, size_t, loff_t *);
 extern struct file_operations simple_dir_operations;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/kernel/ksyms.c hugetlbfs/kernel/ksyms.c
--- linux-2.5/kernel/ksyms.c	Wed Oct  2 20:14:56 2002
+++ hugetlbfs/kernel/ksyms.c	Thu Oct  3 15:42:48 2002
@@ -302,6 +302,12 @@
 EXPORT_SYMBOL(simple_lookup);
 EXPORT_SYMBOL(simple_dir_operations);
 EXPORT_SYMBOL(simple_dir_inode_operations);
+EXPORT_SYMBOL(simple_link);
+EXPORT_SYMBOL(simple_unlink);
+EXPORT_SYMBOL(simple_rmdir);
+EXPORT_SYMBOL(simple_rename);
+EXPORT_SYMBOL(simple_sync_file);
+EXPORT_SYMBOL(simple_empty);
 EXPORT_SYMBOL(fd_install);
 EXPORT_SYMBOL(put_unused_fd);
 EXPORT_SYMBOL(get_sb_bdev);
