Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263397AbSJHAFD>; Mon, 7 Oct 2002 20:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263410AbSJHAFC>; Mon, 7 Oct 2002 20:05:02 -0400
Received: from air-2.osdl.org ([65.172.181.6]:33704 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S263939AbSJHAD2>;
	Mon, 7 Oct 2002 20:03:28 -0400
Date: Mon, 7 Oct 2002 17:11:30 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] Rename driverfs to kfs
In-Reply-To: <Pine.LNX.4.44.0210071701460.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210071711210.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.573.1.137, 2002-10-07 15:03:25-07:00, mochel@osdl.org
  kfs: s/driverfs/kfs/ for internal functions. 
  
  The API still is not affected. 
  
  init_kfs_fs() is now a core_initcall and happens implicitly, instead of being explicitly
  called from the driver model init.

diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Mon Oct  7 15:40:24 2002
+++ b/drivers/base/core.c	Mon Oct  7 15:40:24 2002
@@ -274,18 +274,6 @@
 		put_device(dev->parent);
 }
 
-static int __init device_init(void)
-{
-	int error;
-
-	error = init_driverfs_fs();
-	if (error)
-		panic("DEV: could not initialize driverfs");
-	return 0;
-}
-
-core_initcall(device_init);
-
 EXPORT_SYMBOL(device_register);
 EXPORT_SYMBOL(get_device);
 EXPORT_SYMBOL(put_device);
diff -Nru a/fs/kfs/inode.c b/fs/kfs/inode.c
--- a/fs/kfs/inode.c	Mon Oct  7 15:40:24 2002
+++ b/fs/kfs/inode.c	Mon Oct  7 15:40:24 2002
@@ -1,5 +1,5 @@
 /*
- * driverfs.c - The device driver file system
+ * kfs.c - The kernel filesystem.
  *
  * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
  *
@@ -17,10 +17,10 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  *
- * This is a simple, ram-based filesystem, which allows kernel
- * callbacks for read/write of files.
+ * This is a simple filesystem intended to export attributes of kernel data
+ * structures and their relationships with each other to userspace.
  *
- * Please see Documentation/filesystems/driverfs.txt for more information.
+ * Please see Documentation/filesystems/kfs.txt for more information.
  */
 
 #include <linux/list.h>
@@ -46,23 +46,23 @@
 #endif
 
 /* Random magic number */
-#define DRIVERFS_MAGIC 0x42454552
+#define KFS_MAGIC 0x42454552
 
-static struct super_operations driverfs_ops;
-static struct file_operations driverfs_file_operations;
-static struct inode_operations driverfs_dir_inode_operations;
-static struct address_space_operations driverfs_aops;
+static struct super_operations kfs_ops;
+static struct file_operations kfs_file_operations;
+static struct inode_operations kfs_dir_inode_operations;
+static struct address_space_operations kfs_aops;
 
-static struct vfsmount *driverfs_mount;
+static struct vfsmount *kfs_mount;
 static spinlock_t mount_lock = SPIN_LOCK_UNLOCKED;
 static int mount_count = 0;
 
-static struct backing_dev_info driverfs_backing_dev_info = {
+static struct backing_dev_info kfs_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
 	.memory_backed	= 1,	/* Does not contribute to dirty memory */
 };
 
-static int driverfs_readpage(struct file *file, struct page * page)
+static int kfs_readpage(struct file *file, struct page * page)
 {
 	if (!PageUptodate(page)) {
 		void *kaddr = kmap_atomic(page, KM_USER0);
@@ -76,7 +76,7 @@
 	return 0;
 }
 
-static int driverfs_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
+static int kfs_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
 {
 	if (!PageUptodate(page)) {
 		void *kaddr = kmap_atomic(page, KM_USER0);
@@ -89,7 +89,7 @@
 	return 0;
 }
 
-static int driverfs_commit_write(struct file *file, struct page *page, unsigned offset, unsigned to)
+static int kfs_commit_write(struct file *file, struct page *page, unsigned offset, unsigned to)
 {
 	struct inode *inode = page->mapping->host;
 	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
@@ -101,7 +101,7 @@
 }
 
 
-struct inode *driverfs_get_inode(struct super_block *sb, int mode, int dev)
+struct inode *kfs_get_inode(struct super_block *sb, int mode, int dev)
 {
 	struct inode *inode = new_inode(sb);
 
@@ -113,17 +113,17 @@
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-		inode->i_mapping->a_ops = &driverfs_aops;
-		inode->i_mapping->backing_dev_info = &driverfs_backing_dev_info;
+		inode->i_mapping->a_ops = &kfs_aops;
+		inode->i_mapping->backing_dev_info = &kfs_backing_dev_info;
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
 			break;
 		case S_IFREG:
-			inode->i_fop = &driverfs_file_operations;
+			inode->i_fop = &kfs_file_operations;
 			break;
 		case S_IFDIR:
-			inode->i_op = &driverfs_dir_inode_operations;
+			inode->i_op = &kfs_dir_inode_operations;
 			inode->i_fop = &simple_dir_operations;
 
 			/* directory inodes start off with i_nlink == 2 (for "." entry) */
@@ -137,7 +137,7 @@
 	return inode;
 }
 
-static int driverfs_mknod(struct inode *dir, struct dentry *dentry, int mode, int dev)
+static int kfs_mknod(struct inode *dir, struct dentry *dentry, int mode, int dev)
 {
 	struct inode *inode;
 	int error = -ENOSPC;
@@ -146,8 +146,8 @@
 		return -EEXIST;
 
 	/* only allow create if ->d_fsdata is not NULL (so we can assume it 
-	 * comes from the driverfs API below. */
-	inode = driverfs_get_inode(dir->i_sb, mode, dev);
+	 * comes from the kfs API below. */
+	inode = kfs_get_inode(dir->i_sb, mode, dev);
 	if (inode) {
 		d_instantiate(dentry, inode);
 		error = 0;
@@ -155,25 +155,25 @@
 	return error;
 }
 
-static int driverfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+static int kfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	int res;
 	mode = (mode & (S_IRWXUGO|S_ISVTX)) | S_IFDIR;
- 	res = driverfs_mknod(dir, dentry, mode, 0);
+ 	res = kfs_mknod(dir, dentry, mode, 0);
  	if (!res)
  		dir->i_nlink++;
 	return res;
 }
 
-static int driverfs_create(struct inode *dir, struct dentry *dentry, int mode)
+static int kfs_create(struct inode *dir, struct dentry *dentry, int mode)
 {
 	int res;
 	mode = (mode & S_IALLUGO) | S_IFREG;
- 	res = driverfs_mknod(dir, dentry, mode, 0);
+ 	res = kfs_mknod(dir, dentry, mode, 0);
 	return res;
 }
 
-static int driverfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
+static int kfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
 {
 	struct inode *inode;
 	int error = -ENOSPC;
@@ -181,7 +181,7 @@
 	if (dentry->d_inode)
 		return -EEXIST;
 
-	inode = driverfs_get_inode(dir->i_sb, S_IFLNK|S_IRWXUGO, 0);
+	inode = kfs_get_inode(dir->i_sb, S_IFLNK|S_IRWXUGO, 0);
 	if (inode) {
 		int l = strlen(symname)+1;
 		error = page_symlink(inode, symname, l);
@@ -194,12 +194,12 @@
 	return error;
 }
 
-static inline int driverfs_positive(struct dentry *dentry)
+static inline int kfs_positive(struct dentry *dentry)
 {
 	return (dentry->d_inode && !d_unhashed(dentry));
 }
 
-static int driverfs_empty(struct dentry *dentry)
+static int kfs_empty(struct dentry *dentry)
 {
 	struct list_head *list;
 
@@ -207,7 +207,7 @@
 
 	list_for_each(list, &dentry->d_subdirs) {
 		struct dentry *de = list_entry(list, struct dentry, d_child);
-		if (driverfs_positive(de)) {
+		if (kfs_positive(de)) {
 			spin_unlock(&dcache_lock);
 			return 0;
 		}
@@ -217,7 +217,7 @@
 	return 1;
 }
 
-static int driverfs_unlink(struct inode *dir, struct dentry *dentry)
+static int kfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	down(&inode->i_sem);
@@ -229,7 +229,7 @@
 }
 
 /**
- * driverfs_read_file - "read" data from a file.
+ * kfs_read_file - "read" data from a file.
  * @file:	file pointer
  * @buf:	buffer to fill
  * @count:	number of bytes to read
@@ -244,7 +244,7 @@
  * of bytes it put in it. We update @ppos correctly.
  */
 static ssize_t
-driverfs_read_file(struct file *file, char *buf, size_t count, loff_t *ppos)
+kfs_read_file(struct file *file, char *buf, size_t count, loff_t *ppos)
 {
 	struct attribute * attr = file->f_dentry->d_fsdata;
 	struct driver_dir_entry * dir;
@@ -289,20 +289,20 @@
 }
 
 /**
- * driverfs_write_file - "write" to a file
+ * kfs_write_file - "write" to a file
  * @file:	file pointer
  * @buf:	data to write
  * @count:	number of bytes
  * @ppos:	starting offset
  *
- * Similarly to driverfs_read_file, we act essentially as a bit pipe.
+ * Similarly to kfs_read_file, we act essentially as a bit pipe.
  * We check for a "write" callback in file->private_data, and pass
  * @buffer, @count, @ppos, and the file entry's data to the callback.
  * The number of bytes written is returned, and we handle updating
  * @ppos properly.
  */
 static ssize_t
-driverfs_write_file(struct file *file, const char *buf, size_t count, loff_t *ppos)
+kfs_write_file(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
 	struct attribute * attr = file->f_dentry->d_fsdata;
 	struct driver_dir_entry * dir;
@@ -342,7 +342,7 @@
 }
 
 static loff_t
-driverfs_file_lseek(struct file *file, loff_t offset, int orig)
+kfs_file_lseek(struct file *file, loff_t offset, int orig)
 {
 	loff_t retval = -EINVAL;
 
@@ -367,7 +367,7 @@
 	return retval;
 }
 
-static int driverfs_open_file(struct inode * inode, struct file * filp)
+static int kfs_open_file(struct inode * inode, struct file * filp)
 {
 	struct driver_dir_entry * dir;
 	int error = 0;
@@ -386,7 +386,7 @@
 	return error;
 }
 
-static int driverfs_release(struct inode * inode, struct file * filp)
+static int kfs_release(struct inode * inode, struct file * filp)
 {
 	struct driver_dir_entry * dir;
 	dir = (struct driver_dir_entry *)filp->f_dentry->d_parent->d_fsdata;
@@ -395,40 +395,40 @@
 	return 0;
 }
 
-static struct file_operations driverfs_file_operations = {
-	.read		= driverfs_read_file,
-	.write		= driverfs_write_file,
-	.llseek		= driverfs_file_lseek,
-	.open		= driverfs_open_file,
-	.release	= driverfs_release,
+static struct file_operations kfs_file_operations = {
+	.read		= kfs_read_file,
+	.write		= kfs_write_file,
+	.llseek		= kfs_file_lseek,
+	.open		= kfs_open_file,
+	.release	= kfs_release,
 };
 
-static struct inode_operations driverfs_dir_inode_operations = {
+static struct inode_operations kfs_dir_inode_operations = {
 	.lookup		= simple_lookup,
 };
 
-static struct address_space_operations driverfs_aops = {
-	.readpage	= driverfs_readpage,
+static struct address_space_operations kfs_aops = {
+	.readpage	= kfs_readpage,
 	.writepage	= fail_writepage,
-	.prepare_write	= driverfs_prepare_write,
-	.commit_write	= driverfs_commit_write
+	.prepare_write	= kfs_prepare_write,
+	.commit_write	= kfs_commit_write
 };
 
-static struct super_operations driverfs_ops = {
+static struct super_operations kfs_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
 };
 
-static int driverfs_fill_super(struct super_block *sb, void *data, int silent)
+static int kfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct inode *inode;
 	struct dentry *root;
 
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
-	sb->s_magic = DRIVERFS_MAGIC;
-	sb->s_op = &driverfs_ops;
-	inode = driverfs_get_inode(sb, S_IFDIR | 0755, 0);
+	sb->s_magic = KFS_MAGIC;
+	sb->s_op = &kfs_ops;
+	inode = kfs_get_inode(sb, S_IFDIR | 0755, 0);
 
 	if (!inode) {
 		DBG("%s: could not get inode!\n",__FUNCTION__);
@@ -445,16 +445,16 @@
 	return 0;
 }
 
-static struct super_block *driverfs_get_sb(struct file_system_type *fs_type,
+static struct super_block *kfs_get_sb(struct file_system_type *fs_type,
 	int flags, char *dev_name, void *data)
 {
-	return get_sb_single(fs_type, flags, data, driverfs_fill_super);
+	return get_sb_single(fs_type, flags, data, kfs_fill_super);
 }
 
-static struct file_system_type driverfs_fs_type = {
+static struct file_system_type kfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "kfs",
-	.get_sb		= driverfs_get_sb,
+	.get_sb		= kfs_get_sb,
 	.kill_sb	= kill_litter_super,
 };
 
@@ -463,35 +463,35 @@
 	struct vfsmount * mnt;
 
 	spin_lock(&mount_lock);
-	if (driverfs_mount) {
-		mntget(driverfs_mount);
+	if (kfs_mount) {
+		mntget(kfs_mount);
 		++mount_count;
 		spin_unlock(&mount_lock);
 		goto go_ahead;
 	}
 
 	spin_unlock(&mount_lock);
-	mnt = kern_mount(&driverfs_fs_type);
+	mnt = kern_mount(&kfs_fs_type);
 
 	if (IS_ERR(mnt)) {
-		printk(KERN_ERR "driverfs: could not mount!\n");
+		printk(KERN_ERR "kfs: could not mount!\n");
 		return -ENODEV;
 	}
 
 	spin_lock(&mount_lock);
-	if (!driverfs_mount) {
-		driverfs_mount = mnt;
+	if (!kfs_mount) {
+		kfs_mount = mnt;
 		++mount_count;
 		spin_unlock(&mount_lock);
 		goto go_ahead;
 	}
 
-	mntget(driverfs_mount);
+	mntget(kfs_mount);
 	++mount_count;
 	spin_unlock(&mount_lock);
 
  go_ahead:
-	DBG("driverfs: mount_count = %d\n",mount_count);
+	DBG("kfs: mount_count = %d\n",mount_count);
 	return 0;
 }
 
@@ -500,20 +500,22 @@
 	struct vfsmount * mnt;
 
 	spin_lock(&mount_lock);
-	mnt = driverfs_mount;
+	mnt = kfs_mount;
 	--mount_count;
 	if (!mount_count)
-		driverfs_mount = NULL;
+		kfs_mount = NULL;
 	spin_unlock(&mount_lock);
 	mntput(mnt);
-	DBG("driverfs: mount_count = %d\n",mount_count);
+	DBG("kfs: mount_count = %d\n",mount_count);
 }
 
-int __init init_driverfs_fs(void)
+static int __init init_kfs_fs(void)
 {
-	return register_filesystem(&driverfs_fs_type);
+	return register_filesystem(&kfs_fs_type);
 }
 
+core_initcall(init_kfs_fs);
+
 static struct dentry * get_dentry(struct dentry * parent, const char * name)
 {
 	struct qstr qstr;
@@ -545,8 +547,8 @@
 	parent_dentry = parent ? parent->dentry : NULL;
 
 	if (!parent_dentry)
-		if (driverfs_mount && driverfs_mount->mnt_sb)
-			parent_dentry = driverfs_mount->mnt_sb->s_root;
+		if (kfs_mount && kfs_mount->mnt_sb)
+			parent_dentry = kfs_mount->mnt_sb->s_root;
 
 	if (!parent_dentry) {
 		put_mount();
@@ -558,7 +560,7 @@
 	if (!IS_ERR(dentry)) {
 		dentry->d_fsdata = (void *) entry;
 		entry->dentry = dentry;
-		error = driverfs_mkdir(parent_dentry->d_inode,dentry,entry->mode);
+		error = kfs_mkdir(parent_dentry->d_inode,dentry,entry->mode);
 	} else
 		error = PTR_ERR(dentry);
 	up(&parent_dentry->d_inode->i_sem);
@@ -592,7 +594,7 @@
 	dentry = get_dentry(parent->dentry,entry->name);
 	if (!IS_ERR(dentry)) {
 		dentry->d_fsdata = (void *)entry;
-		error = driverfs_create(parent->dentry->d_inode,dentry,entry->mode);
+		error = kfs_create(parent->dentry->d_inode,dentry,entry->mode);
 	} else
 		error = PTR_ERR(dentry);
 	up(&parent->dentry->d_inode->i_sem);
@@ -622,7 +624,7 @@
 	down(&parent->dentry->d_inode->i_sem);
 	dentry = get_dentry(parent->dentry,name);
 	if (!IS_ERR(dentry))
-		error = driverfs_symlink(parent->dentry->d_inode,dentry,target);
+		error = kfs_symlink(parent->dentry->d_inode,dentry,target);
 	else
 		error = PTR_ERR(dentry);
 	up(&parent->dentry->d_inode->i_sem);
@@ -650,7 +652,7 @@
 		/* make sure dentry is really there */
 		if (dentry->d_inode && 
 		    (dentry->d_parent->d_inode == dir->dentry->d_inode)) {
-			driverfs_unlink(dir->dentry->d_inode,dentry);
+			kfs_unlink(dir->dentry->d_inode,dentry);
 		}
 	}
 	up(&dir->dentry->d_inode->i_sem);
@@ -680,11 +682,11 @@
 		struct dentry * d = list_entry(node,struct dentry,d_child);
 		/* make sure dentry is still there */
 		if (d->d_inode)
-			driverfs_unlink(dentry->d_inode,d);
+			kfs_unlink(dentry->d_inode,d);
 	}
 
 	d_invalidate(dentry);
-	if (driverfs_empty(dentry)) {
+	if (kfs_empty(dentry)) {
 		dentry->d_inode->i_nlink -= 2;
 		dentry->d_inode->i_flags |= S_DEAD;
 		parent->d_inode->i_nlink--;

