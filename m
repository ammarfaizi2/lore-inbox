Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280012AbRKDPw6>; Sun, 4 Nov 2001 10:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280014AbRKDPwk>; Sun, 4 Nov 2001 10:52:40 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:10489 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280012AbRKDPwZ>;
	Sun, 4 Nov 2001 10:52:25 -0500
Date: Sun, 4 Nov 2001 10:52:19 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [CFT][PATCH] ramfs/tmpfs readdir()
Message-ID: <Pine.GSO.4.21.0111041046040.21449-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	OK, here's a patch that should (hopefully) fix the ramfs readdir()
problems.
	Summary:
* open() on directory creates an unhashed negative dentry - child of that
  directory and sticks it in ->private_data.
* close() does dput() on it.
* readdir() uses that dentry as a cursor - boundary in d_subdirs/d_child
  between the part we've already read and stuff we are yet to read.
* lseek() not to the current position moves that cursor, counting positive
  hashed dentries in the list.

I've switched the code that was using dcache_readdir() (including tmpfs
and ramfs) to that scheme.  It seems to be working fine, but more testing
is obviously needed.

Please, help with review and testing.  Linus, if you have problems with
that approach - please, tell.

Patch against 2.4.14-pre8 follows:

diff -urN S14-pre8/fs/autofs/autofs_i.h S14-pre8-ramfs/fs/autofs/autofs_i.h
--- S14-pre8/fs/autofs/autofs_i.h	Wed Oct 31 20:21:24 2001
+++ S14-pre8-ramfs/fs/autofs/autofs_i.h	Sun Nov  4 08:37:08 2001
@@ -141,7 +141,6 @@
 extern struct inode_operations autofs_symlink_inode_operations;
 extern struct inode_operations autofs_dir_inode_operations;
 extern struct file_operations autofs_root_operations;
-extern struct file_operations autofs_dir_operations;
 
 /* Initializing function */
 
diff -urN S14-pre8/fs/autofs/dir.c S14-pre8-ramfs/fs/autofs/dir.c
--- S14-pre8/fs/autofs/dir.c	Fri Feb 16 13:34:14 2001
+++ S14-pre8-ramfs/fs/autofs/dir.c	Sun Nov  4 08:28:03 2001
@@ -23,11 +23,6 @@
 	return NULL;
 }
 
-struct file_operations autofs_dir_operations = {
-	read:		generic_read_dir,
-	readdir:	dcache_readdir,
-};
-
 struct inode_operations autofs_dir_inode_operations = {
 	lookup:		autofs_dir_lookup,
 };
diff -urN S14-pre8/fs/autofs/inode.c S14-pre8-ramfs/fs/autofs/inode.c
--- S14-pre8/fs/autofs/inode.c	Tue Jul  3 21:09:13 2001
+++ S14-pre8-ramfs/fs/autofs/inode.c	Sun Nov  4 08:28:12 2001
@@ -208,7 +208,7 @@
 	/* Initialize to the default case (stub directory) */
 
 	inode->i_op = &autofs_dir_inode_operations;
-	inode->i_fop = &autofs_dir_operations;
+	inode->i_fop = &dcache_dir_ops;
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
 	inode->i_nlink = 2;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
diff -urN S14-pre8/fs/autofs4/autofs_i.h S14-pre8-ramfs/fs/autofs4/autofs_i.h
--- S14-pre8/fs/autofs4/autofs_i.h	Wed Oct 31 20:21:32 2001
+++ S14-pre8-ramfs/fs/autofs4/autofs_i.h	Sun Nov  4 08:37:16 2001
@@ -139,7 +139,6 @@
 extern struct inode_operations autofs4_symlink_inode_operations;
 extern struct inode_operations autofs4_dir_inode_operations;
 extern struct inode_operations autofs4_root_inode_operations;
-extern struct file_operations autofs4_dir_operations;
 extern struct file_operations autofs4_root_operations;
 
 /* Initializing function */
diff -urN S14-pre8/fs/autofs4/inode.c S14-pre8-ramfs/fs/autofs4/inode.c
--- S14-pre8/fs/autofs4/inode.c	Fri Feb 16 22:52:15 2001
+++ S14-pre8-ramfs/fs/autofs4/inode.c	Sun Nov  4 08:28:51 2001
@@ -314,7 +314,7 @@
 	if (S_ISDIR(inf->mode)) {
 		inode->i_nlink = 2;
 		inode->i_op = &autofs4_dir_inode_operations;
-		inode->i_fop = &autofs4_dir_operations;
+		inode->i_fop = &dcache_dir_ops;
 	} else if (S_ISLNK(inf->mode))
 		inode->i_op = &autofs4_symlink_inode_operations;
 
diff -urN S14-pre8/fs/autofs4/root.c S14-pre8-ramfs/fs/autofs4/root.c
--- S14-pre8/fs/autofs4/root.c	Fri Feb 16 19:36:08 2001
+++ S14-pre8-ramfs/fs/autofs4/root.c	Sun Nov  4 08:43:54 2001
@@ -27,14 +27,13 @@
 static struct dentry *autofs4_root_lookup(struct inode *,struct dentry *);
 
 struct file_operations autofs4_root_operations = {
+	open:		dcache_dir_open,
+	release:	dcache_dir_close,
+	llseek:		dcache_dir_lseek,
 	read:		generic_read_dir,
 	readdir:	dcache_readdir,
+	fsync:		dcache_dir_fsync,
 	ioctl:		autofs4_root_ioctl,
-};
-
-struct file_operations autofs4_dir_operations = {
-	read:		generic_read_dir,
-	readdir:	dcache_readdir,
 };
 
 struct inode_operations autofs4_root_inode_operations = {
diff -urN S14-pre8/fs/binfmt_misc.c S14-pre8-ramfs/fs/binfmt_misc.c
--- S14-pre8/fs/binfmt_misc.c	Wed Oct 24 04:10:05 2001
+++ S14-pre8-ramfs/fs/binfmt_misc.c	Sun Nov  4 08:25:28 2001
@@ -600,11 +600,6 @@
 	return NULL;
 }
 
-static struct file_operations bm_dir_operations = {
-	read:		generic_read_dir,
-	readdir:	dcache_readdir,
-};
-
 static struct inode_operations bm_dir_inode_operations = {
 	lookup:		bm_lookup,
 };
@@ -646,7 +641,7 @@
 	if (!inode)
 		return NULL;
 	inode->i_op = &bm_dir_inode_operations;
-	inode->i_fop = &bm_dir_operations;
+	inode->i_fop = &dcache_dir_ops;
 	dentry[0] = d_alloc_root(inode);
 	if (!dentry[0]) {
 		iput(inode);
diff -urN S14-pre8/fs/namespace.c S14-pre8-ramfs/fs/namespace.c
--- S14-pre8/fs/namespace.c	Wed Oct 24 04:10:06 2001
+++ S14-pre8-ramfs/fs/namespace.c	Sun Nov  4 09:01:15 2001
@@ -940,10 +940,6 @@
 	d_add(dentry, NULL);
 	return NULL;
 }
-static struct file_operations rootfs_dir_operations = {
-	read:		generic_read_dir,
-	readdir:	dcache_readdir,
-};
 static struct inode_operations rootfs_dir_inode_operations = {
 	lookup:		rootfs_lookup,
 };
@@ -959,7 +955,7 @@
 	inode->i_mode = S_IFDIR|0555;
 	inode->i_uid = inode->i_gid = 0;
 	inode->i_op = &rootfs_dir_inode_operations;
-	inode->i_fop = &rootfs_dir_operations;
+	inode->i_fop = &dcache_dir_ops;
 	root = d_alloc_root(inode);
 	if (!root) {
 		iput(inode);
diff -urN S14-pre8/fs/ramfs/inode.c S14-pre8-ramfs/fs/ramfs/inode.c
--- S14-pre8/fs/ramfs/inode.c	Sun Nov  4 05:28:47 2001
+++ S14-pre8-ramfs/fs/ramfs/inode.c	Sun Nov  4 08:26:12 2001
@@ -37,7 +37,6 @@
 
 static struct super_operations ramfs_ops;
 static struct address_space_operations ramfs_aops;
-static struct file_operations ramfs_dir_operations;
 static struct file_operations ramfs_file_operations;
 static struct inode_operations ramfs_dir_inode_operations;
 
@@ -120,7 +119,7 @@
 			break;
 		case S_IFDIR:
 			inode->i_op = &ramfs_dir_inode_operations;
-			inode->i_fop = &ramfs_dir_operations;
+			inode->i_fop = &dcache_dir_ops;
 			break;
 		case S_IFLNK:
 			inode->i_op = &page_symlink_inode_operations;
@@ -276,12 +275,6 @@
 	read:		generic_file_read,
 	write:		generic_file_write,
 	mmap:		generic_file_mmap,
-	fsync:		ramfs_sync_file,
-};
-
-static struct file_operations ramfs_dir_operations = {
-	read:		generic_read_dir,
-	readdir:	dcache_readdir,
 	fsync:		ramfs_sync_file,
 };
 
diff -urN S14-pre8/fs/readdir.c S14-pre8-ramfs/fs/readdir.c
--- S14-pre8/fs/readdir.c	Thu Aug 16 20:05:50 2001
+++ S14-pre8-ramfs/fs/readdir.c	Sun Nov  4 08:43:36 2001
@@ -33,6 +33,64 @@
 	return res;
 }
 
+int dcache_dir_open(struct inode *inode, struct file *file)
+{
+	static struct qstr cursor_name = {len:1, name:"."};
+
+	file->private_data = d_alloc(file->f_dentry, &cursor_name);
+
+	return file->private_data ? 0 : -ENOMEM;
+}
+
+int dcache_dir_close(struct inode *inode, struct file *file)
+{
+	dput(file->private_data);
+	return 0;
+}
+
+loff_t dcache_dir_lseek(struct file *file, loff_t offset, int origin)
+{
+	down(&file->f_dentry->d_inode->i_sem);
+	switch (origin) {
+		case 1:
+			offset += file->f_pos;
+		case 0:
+			if (offset >= 0)
+				break;
+		default:
+			up(&file->f_dentry->d_inode->i_sem);
+			return -EINVAL;
+	}
+	if (offset != file->f_pos) {
+		file->f_pos = offset;
+		if (file->f_pos >= 2) {
+			struct list_head *p;
+			struct dentry *cursor = file->private_data;
+			loff_t n = file->f_pos - 2;
+
+			spin_lock(&dcache_lock);
+			p = file->f_dentry->d_subdirs.next;
+			while (n && p != &file->f_dentry->d_subdirs) {
+				struct dentry *next;
+				next = list_entry(p, struct dentry, d_child);
+				if (!list_empty(&next->d_hash) && next->d_inode)
+					n--;
+				p = p->next;
+			}
+			list_del(&cursor->d_child);
+			list_add_tail(&cursor->d_child, p);
+			spin_unlock(&dcache_lock);
+		}
+	}
+	up(&file->f_dentry->d_inode->i_sem);
+	return offset;
+}
+
+int dcache_dir_fsync(struct file * file, struct dentry *dentry, int datasync)
+{
+	return 0;
+}
+
 /*
  * Directory is locked and all positive dentries in it are safe, since
  * for ramfs-type trees they can't go away without unlink() or rmdir(),
@@ -41,61 +99,64 @@
 
 int dcache_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
-	int i;
 	struct dentry *dentry = filp->f_dentry;
+	struct dentry *cursor = filp->private_data;
+	struct list_head *p, *q = &cursor->d_child;
+	ino_t ino;
+	int i = filp->f_pos;
 
-	i = filp->f_pos;
 	switch (i) {
 		case 0:
-			if (filldir(dirent, ".", 1, i, dentry->d_inode->i_ino, DT_DIR) < 0)
+			ino = dentry->d_inode->i_ino;
+			if (filldir(dirent, ".", 1, i, ino, DT_DIR) < 0)
 				break;
-			i++;
 			filp->f_pos++;
+			i++;
 			/* fallthrough */
 		case 1:
-			if (filldir(dirent, "..", 2, i, dentry->d_parent->d_inode->i_ino, DT_DIR) < 0)
+			spin_lock(&dcache_lock);
+			ino = dentry->d_parent->d_inode->i_ino;
+			spin_unlock(&dcache_lock);
+			if (filldir(dirent, "..", 2, i, ino, DT_DIR) < 0)
 				break;
-			i++;
 			filp->f_pos++;
+			i++;
 			/* fallthrough */
-		default: {
-			struct list_head *list;
-			int j = i-2;
-
+		default:
 			spin_lock(&dcache_lock);
-			list = dentry->d_subdirs.next;
-
-			for (;;) {
-				if (list == &dentry->d_subdirs) {
-					spin_unlock(&dcache_lock);
-					return 0;
-				}
-				if (!j)
-					break;
-				j--;
-				list = list->next;
+			if (filp->f_pos == 2) {
+				list_del(q);
+				list_add(q, &dentry->d_subdirs);
 			}
-
-			while(1) {
-				struct dentry *de = list_entry(list, struct dentry, d_child);
-
-				if (!list_empty(&de->d_hash) && de->d_inode) {
-					spin_unlock(&dcache_lock);
-					if (filldir(dirent, de->d_name.name, de->d_name.len, filp->f_pos, de->d_inode->i_ino, DT_UNKNOWN) < 0)
-						break;
-					spin_lock(&dcache_lock);
-				}
-				filp->f_pos++;
-				list = list->next;
-				if (list != &dentry->d_subdirs)
+			for (p=q->next; p != &dentry->d_subdirs; p=p->next) {
+				struct dentry *next;
+				next = list_entry(p, struct dentry, d_child);
+				if (list_empty(&next->d_hash) || !next->d_inode)
 					continue;
+
 				spin_unlock(&dcache_lock);
-				break;
+				if (filldir(dirent, next->d_name.name, next->d_name.len, filp->f_pos, next->d_inode->i_ino, DT_UNKNOWN) < 0)
+					return 0;
+				spin_lock(&dcache_lock);
+				/* next is still alive */
+				list_del(q);
+				list_add(q, p);
+				p = q;
+				filp->f_pos++;
 			}
-		}
+			spin_unlock(&dcache_lock);
 	}
 	return 0;
 }
+
+struct file_operations dcache_dir_ops = {
+	open:		dcache_dir_open,
+	release:	dcache_dir_close,
+	llseek:		dcache_dir_lseek,
+	read:		generic_read_dir,
+	readdir:	dcache_readdir,
+	fsync:		dcache_dir_fsync,
+};
 
 /*
  * Traditional linux readdir() handling..
diff -urN S14-pre8/include/linux/fs.h S14-pre8-ramfs/include/linux/fs.h
--- S14-pre8/include/linux/fs.h	Sun Nov  4 05:28:49 2001
+++ S14-pre8-ramfs/include/linux/fs.h	Sun Nov  4 08:35:58 2001
@@ -1392,7 +1392,12 @@
 extern struct inode_operations page_symlink_inode_operations;
 
 extern int vfs_readdir(struct file *, filldir_t, void *);
+extern int dcache_dir_open(struct inode *, struct file *);
+extern int dcache_dir_close(struct inode *, struct file *);
+extern loff_t dcache_dir_lseek(struct file *, loff_t, int);
+extern int dcache_dir_fsync(struct file *, struct dentry *, int);
 extern int dcache_readdir(struct file *, void *, filldir_t);
+extern struct file_operations dcache_dir_ops;
 
 extern struct file_system_type *get_fs_type(const char *name);
 extern struct super_block *get_super(kdev_t);
diff -urN S14-pre8/kernel/ksyms.c S14-pre8-ramfs/kernel/ksyms.c
--- S14-pre8/kernel/ksyms.c	Sun Nov  4 05:28:49 2001
+++ S14-pre8-ramfs/kernel/ksyms.c	Sun Nov  4 08:33:09 2001
@@ -266,7 +266,12 @@
 EXPORT_SYMBOL(lease_get_mtime);
 EXPORT_SYMBOL(lock_may_read);
 EXPORT_SYMBOL(lock_may_write);
+EXPORT_SYMBOL(dcache_dir_open);
+EXPORT_SYMBOL(dcache_dir_close);
+EXPORT_SYMBOL(dcache_dir_lseek);
+EXPORT_SYMBOL(dcache_dir_fsync);
 EXPORT_SYMBOL(dcache_readdir);
+EXPORT_SYMBOL(dcache_dir_ops);
 
 /* for stackable file systems (lofs, wrapfs, cryptfs, etc.) */
 EXPORT_SYMBOL(default_llseek);
diff -urN S14-pre8/mm/shmem.c S14-pre8-ramfs/mm/shmem.c
--- S14-pre8/mm/shmem.c	Sun Nov  4 05:28:50 2001
+++ S14-pre8-ramfs/mm/shmem.c	Sun Nov  4 08:27:09 2001
@@ -41,7 +41,6 @@
 static struct address_space_operations shmem_aops;
 static struct file_operations shmem_file_operations;
 static struct inode_operations shmem_inode_operations;
-static struct file_operations shmem_dir_operations;
 static struct inode_operations shmem_dir_inode_operations;
 static struct vm_operations_struct shmem_vm_ops;
 
@@ -717,7 +716,7 @@
 		case S_IFDIR:
 			inode->i_nlink++;
 			inode->i_op = &shmem_dir_inode_operations;
-			inode->i_fop = &shmem_dir_operations;
+			inode->i_fop = &dcache_dir_ops;
 			break;
 		case S_IFLNK:
 			break;
@@ -1344,14 +1343,6 @@
 
 static struct inode_operations shmem_inode_operations = {
 	truncate:	shmem_truncate,
-};
-
-static struct file_operations shmem_dir_operations = {
-	read:		generic_read_dir,
-	readdir:	dcache_readdir,
-#ifdef CONFIG_TMPFS
-	fsync:		shmem_sync_file,
-#endif
 };
 
 static struct inode_operations shmem_dir_inode_operations = {

