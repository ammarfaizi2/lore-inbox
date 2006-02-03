Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWBCXDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWBCXDO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 18:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWBCXDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 18:03:14 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:4976 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751510AbWBCXDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 18:03:13 -0500
Date: Fri, 3 Feb 2006 15:02:32 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [git patches] ocfs2 updates
Message-ID: <20060203230232.GE2831@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'upstream-linus' branch of
git://oss.oracle.com/home/sourcebo/git/ocfs2.git

to receive the following updates:

 Documentation/filesystems/configfs/configfs_example.c |    2 
 Documentation/filesystems/ocfs2.txt                   |    1 
 MAINTAINERS                                           |    3 
 fs/Kconfig                                            |    2 
 fs/configfs/configfs_internal.h                       |   11 
 fs/configfs/dir.c                                     |   36 +-
 fs/configfs/file.c                                    |   19 -
 fs/configfs/inode.c                                   |  120 +++++++-
 fs/configfs/mount.c                                   |   28 +-
 fs/configfs/symlink.c                                 |    4 
 fs/ocfs2/buffer_head_io.c                             |   10 
 fs/ocfs2/cluster/heartbeat.c                          |    5 
 fs/ocfs2/cluster/tcp.c                                |   16 -
 fs/ocfs2/dlm/dlmcommon.h                              |    1 
 fs/ocfs2/dlm/dlmdomain.c                              |   18 +
 fs/ocfs2/dlm/dlmmaster.c                              |   24 -
 fs/ocfs2/dlm/dlmrecovery.c                            |  250 +++++++++++++++---
 fs/ocfs2/dlm/dlmunlock.c                              |   13 
 fs/ocfs2/dlm/userdlm.c                                |    2 
 fs/ocfs2/extent_map.c                                 |   12 
 fs/ocfs2/file.c                                       |   10 
 fs/ocfs2/inode.c                                      |    6 
 fs/ocfs2/inode.h                                      |    4 
 fs/ocfs2/journal.c                                    |   32 +-
 fs/ocfs2/ocfs2.h                                      |    3 
 fs/ocfs2/super.c                                      |   11 
 fs/ocfs2/sysfile.c                                    |    6 
 fs/ocfs2/uptodate.c                                   |   12 
 fs/ocfs2/uptodate.h                                   |    2 
 include/linux/configfs.h                              |    2 
 30 files changed, 507 insertions(+), 158 deletions(-)

Adrian Bunk:
      OCFS2: __init / __exit problem
      fs/ocfs2/dlm/dlmrecovery.c must #include <linux/delay.h>

Arjan van de Ven:
      ocfs2: Semaphore to mutex conversion.

Eric Sesterhenn / snakebyte:
      BUG_ON() Conversion in fs/ocfs2/
      BUG_ON() Conversion in fs/configfs/

J. Bruce Fields:
      [OCFS2] Documentation Fix

Jeff Mahoney:
      ocfs2/dlm: fix compilation on ia64

Joel Becker:
      o Remove confusing Kconfig text for CONFIGFS_FS.
      configfs: Clean up MAINTAINERS entry
      configfs: Add permission and ownership to configfs objects.

Kurt Hackel:
      ocfs2/dlm: fixes

Mark Fasheh:
      [OCFS2] Make ip_io_sem a mutex
      ocfs2: fix compile warnings
      ocfs2: don't wait on recovery when locking journal

diff --git a/Documentation/filesystems/configfs/configfs_example.c b/Documentation/filesystems/configfs/configfs_example.c
index f3c6e49..3d4713a 100644
--- a/Documentation/filesystems/configfs/configfs_example.c
+++ b/Documentation/filesystems/configfs/configfs_example.c
@@ -320,6 +320,7 @@ static struct config_item_type simple_ch
 	.ct_item_ops	= &simple_children_item_ops,
 	.ct_group_ops	= &simple_children_group_ops,
 	.ct_attrs	= simple_children_attrs,
+	.ct_owner	= THIS_MODULE,
 };
 
 static struct configfs_subsystem simple_children_subsys = {
@@ -403,6 +404,7 @@ static struct config_item_type group_chi
 	.ct_item_ops	= &group_children_item_ops,
 	.ct_group_ops	= &group_children_group_ops,
 	.ct_attrs	= group_children_attrs,
+	.ct_owner	= THIS_MODULE,
 };
 
 static struct configfs_subsystem group_children_subsys = {
diff --git a/Documentation/filesystems/ocfs2.txt b/Documentation/filesystems/ocfs2.txt
index f2595ca..4389c68 100644
--- a/Documentation/filesystems/ocfs2.txt
+++ b/Documentation/filesystems/ocfs2.txt
@@ -35,6 +35,7 @@ Features which OCFS2 does not support ye
 	  be cluster coherent.
 	- quotas
 	- cluster aware flock
+	- cluster aware lockf
 	- Directory change notification (F_NOTIFY)
 	- Distributed Caching (F_SETLEASE/F_GETLEASE/break_lease)
 	- POSIX ACLs
diff --git a/MAINTAINERS b/MAINTAINERS
index 42955fe..8133670 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -557,7 +557,8 @@ S:	Supported	
 
 CONFIGFS
 P:	Joel Becker
-M:	Joel Becker <joel.becker@oracle.com>
+M:	joel.becker@oracle.com
+L:	linux-kernel@vger.kernel.org
 S:	Supported
 
 CIRRUS LOGIC GENERIC FBDEV DRIVER
diff --git a/fs/Kconfig b/fs/Kconfig
index 93b5dc4..e9749b0 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -883,8 +883,6 @@ config CONFIGFS_FS
 	  Both sysfs and configfs can and should exist together on the
 	  same system. One is not a replacement for the other.
 
-	  If unsure, say N.
-
 endmenu
 
 menu "Miscellaneous filesystems"
diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index 8899d9c..f70e469 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -36,6 +36,7 @@ struct configfs_dirent {
 	int			s_type;
 	umode_t			s_mode;
 	struct dentry		* s_dentry;
+	struct iattr		* s_iattr;
 };
 
 #define CONFIGFS_ROOT		0x0001
@@ -48,10 +49,11 @@ struct configfs_dirent {
 #define CONFIGFS_NOT_PINNED	(CONFIGFS_ITEM_ATTR)
 
 extern struct vfsmount * configfs_mount;
+extern kmem_cache_t *configfs_dir_cachep;
 
 extern int configfs_is_root(struct config_item *item);
 
-extern struct inode * configfs_new_inode(mode_t mode);
+extern struct inode * configfs_new_inode(mode_t mode, struct configfs_dirent *);
 extern int configfs_create(struct dentry *, int mode, int (*init)(struct inode *));
 
 extern int configfs_create_file(struct config_item *, const struct configfs_attribute *);
@@ -63,6 +65,7 @@ extern void configfs_hash_and_remove(str
 
 extern const unsigned char * configfs_get_name(struct configfs_dirent *sd);
 extern void configfs_drop_dentry(struct configfs_dirent *sd, struct dentry *parent);
+extern int configfs_setattr(struct dentry *dentry, struct iattr *iattr);
 
 extern int configfs_pin_fs(void);
 extern void configfs_release_fs(void);
@@ -120,8 +123,10 @@ static inline struct config_item *config
 
 static inline void release_configfs_dirent(struct configfs_dirent * sd)
 {
-	if (!(sd->s_type & CONFIGFS_ROOT))
-		kfree(sd);
+	if (!(sd->s_type & CONFIGFS_ROOT)) {
+		kfree(sd->s_iattr);
+		kmem_cache_free(configfs_dir_cachep, sd);
+	}
 }
 
 static inline struct configfs_dirent * configfs_get(struct configfs_dirent * sd)
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index b668ec6..ca60e3a 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -72,7 +72,7 @@ static struct configfs_dirent *configfs_
 {
 	struct configfs_dirent * sd;
 
-	sd = kmalloc(sizeof(*sd), GFP_KERNEL);
+	sd = kmem_cache_alloc(configfs_dir_cachep, GFP_KERNEL);
 	if (!sd)
 		return NULL;
 
@@ -136,13 +136,19 @@ static int create_dir(struct config_item
 	int error;
 	umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
 
-	error = configfs_create(d, mode, init_dir);
+	error = configfs_make_dirent(p->d_fsdata, d, k, mode,
+				     CONFIGFS_DIR);
 	if (!error) {
-		error = configfs_make_dirent(p->d_fsdata, d, k, mode,
-					   CONFIGFS_DIR);
+		error = configfs_create(d, mode, init_dir);
 		if (!error) {
 			p->d_inode->i_nlink++;
 			(d)->d_op = &configfs_dentry_ops;
+		} else {
+			struct configfs_dirent *sd = d->d_fsdata;
+			if (sd) {
+				list_del_init(&sd->s_sibling);
+				configfs_put(sd);
+			}
 		}
 	}
 	return error;
@@ -182,12 +188,19 @@ int configfs_create_link(struct configfs
 	int err = 0;
 	umode_t mode = S_IFLNK | S_IRWXUGO;
 
-	err = configfs_create(dentry, mode, init_symlink);
+	err = configfs_make_dirent(parent->d_fsdata, dentry, sl, mode,
+				   CONFIGFS_ITEM_LINK);
 	if (!err) {
-		err = configfs_make_dirent(parent->d_fsdata, dentry, sl,
-					 mode, CONFIGFS_ITEM_LINK);
+		err = configfs_create(dentry, mode, init_symlink);
 		if (!err)
 			dentry->d_op = &configfs_dentry_ops;
+		else {
+			struct configfs_dirent *sd = dentry->d_fsdata;
+			if (sd) {
+				list_del_init(&sd->s_sibling);
+				configfs_put(sd);
+			}
+		}
 	}
 	return err;
 }
@@ -241,13 +254,15 @@ static int configfs_attach_attr(struct c
 	struct configfs_attribute * attr = sd->s_element;
 	int error;
 
+	dentry->d_fsdata = configfs_get(sd);
+	sd->s_dentry = dentry;
 	error = configfs_create(dentry, (attr->ca_mode & S_IALLUGO) | S_IFREG, init_file);
-	if (error)
+	if (error) {
+		configfs_put(sd);
 		return error;
+	}
 
 	dentry->d_op = &configfs_dentry_ops;
-	dentry->d_fsdata = configfs_get(sd);
-	sd->s_dentry = dentry;
 	d_rehash(dentry);
 
 	return 0;
@@ -839,6 +854,7 @@ struct inode_operations configfs_dir_ino
 	.symlink	= configfs_symlink,
 	.unlink		= configfs_unlink,
 	.lookup		= configfs_lookup,
+	.setattr	= configfs_setattr,
 };
 
 #if 0
diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index c26cd61..3921920 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -26,7 +26,6 @@
 
 #include <linux/fs.h>
 #include <linux/module.h>
-#include <linux/dnotify.h>
 #include <linux/slab.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
@@ -150,7 +149,7 @@ out:
 /**
  *	fill_write_buffer - copy buffer from userspace.
  *	@buffer:	data buffer for file.
- *	@userbuf:	data from user.
+ *	@buf:		data from user.
  *	@count:		number of bytes in @userbuf.
  *
  *	Allocate @buffer->page if it hasn't been already, then
@@ -177,8 +176,9 @@ fill_write_buffer(struct configfs_buffer
 
 /**
  *	flush_write_buffer - push buffer to config_item.
- *	@file:		file pointer.
+ *	@dentry:	dentry to the attribute
  *	@buffer:	data buffer for file.
+ *	@count:		number of bytes
  *
  *	Get the correct pointers for the config_item and the attribute we're
  *	dealing with, then call the store() method for the attribute,
@@ -217,15 +217,16 @@ static ssize_t
 configfs_write_file(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct configfs_buffer * buffer = file->private_data;
+	ssize_t len;
 
 	down(&buffer->sem);
-	count = fill_write_buffer(buffer,buf,count);
-	if (count > 0)
-		count = flush_write_buffer(file->f_dentry,buffer,count);
-	if (count > 0)
-		*ppos += count;
+	len = fill_write_buffer(buffer, buf, count);
+	if (len > 0)
+		len = flush_write_buffer(file->f_dentry, buffer, count);
+	if (len > 0)
+		*ppos += len;
 	up(&buffer->sem);
-	return count;
+	return len;
 }
 
 static int check_perm(struct inode * inode, struct file * file)
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index 6577c58..c153bd9 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -31,6 +31,7 @@
 #include <linux/pagemap.h>
 #include <linux/namei.h>
 #include <linux/backing-dev.h>
+#include <linux/capability.h>
 
 #include <linux/configfs.h>
 #include "configfs_internal.h"
@@ -48,18 +49,107 @@ static struct backing_dev_info configfs_
 	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
 };
 
-struct inode * configfs_new_inode(mode_t mode)
+static struct inode_operations configfs_inode_operations ={
+	.setattr	= configfs_setattr,
+};
+
+int configfs_setattr(struct dentry * dentry, struct iattr * iattr)
+{
+	struct inode * inode = dentry->d_inode;
+	struct configfs_dirent * sd = dentry->d_fsdata;
+	struct iattr * sd_iattr;
+	unsigned int ia_valid = iattr->ia_valid;
+	int error;
+
+	if (!sd)
+		return -EINVAL;
+
+	sd_iattr = sd->s_iattr;
+
+	error = inode_change_ok(inode, iattr);
+	if (error)
+		return error;
+
+	error = inode_setattr(inode, iattr);
+	if (error)
+		return error;
+
+	if (!sd_iattr) {
+		/* setting attributes for the first time, allocate now */
+		sd_iattr = kmalloc(sizeof(struct iattr), GFP_KERNEL);
+		if (!sd_iattr)
+			return -ENOMEM;
+		/* assign default attributes */
+		memset(sd_iattr, 0, sizeof(struct iattr));
+		sd_iattr->ia_mode = sd->s_mode;
+		sd_iattr->ia_uid = 0;
+		sd_iattr->ia_gid = 0;
+		sd_iattr->ia_atime = sd_iattr->ia_mtime = sd_iattr->ia_ctime = CURRENT_TIME;
+		sd->s_iattr = sd_iattr;
+	}
+
+	/* attributes were changed atleast once in past */
+
+	if (ia_valid & ATTR_UID)
+		sd_iattr->ia_uid = iattr->ia_uid;
+	if (ia_valid & ATTR_GID)
+		sd_iattr->ia_gid = iattr->ia_gid;
+	if (ia_valid & ATTR_ATIME)
+		sd_iattr->ia_atime = timespec_trunc(iattr->ia_atime,
+						inode->i_sb->s_time_gran);
+	if (ia_valid & ATTR_MTIME)
+		sd_iattr->ia_mtime = timespec_trunc(iattr->ia_mtime,
+						inode->i_sb->s_time_gran);
+	if (ia_valid & ATTR_CTIME)
+		sd_iattr->ia_ctime = timespec_trunc(iattr->ia_ctime,
+						inode->i_sb->s_time_gran);
+	if (ia_valid & ATTR_MODE) {
+		umode_t mode = iattr->ia_mode;
+
+		if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
+			mode &= ~S_ISGID;
+		sd_iattr->ia_mode = sd->s_mode = mode;
+	}
+
+	return error;
+}
+
+static inline void set_default_inode_attr(struct inode * inode, mode_t mode)
+{
+	inode->i_mode = mode;
+	inode->i_uid = 0;
+	inode->i_gid = 0;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+}
+
+static inline void set_inode_attr(struct inode * inode, struct iattr * iattr)
+{
+	inode->i_mode = iattr->ia_mode;
+	inode->i_uid = iattr->ia_uid;
+	inode->i_gid = iattr->ia_gid;
+	inode->i_atime = iattr->ia_atime;
+	inode->i_mtime = iattr->ia_mtime;
+	inode->i_ctime = iattr->ia_ctime;
+}
+
+struct inode * configfs_new_inode(mode_t mode, struct configfs_dirent * sd)
 {
 	struct inode * inode = new_inode(configfs_sb);
 	if (inode) {
-		inode->i_mode = mode;
-		inode->i_uid = 0;
-		inode->i_gid = 0;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		inode->i_mapping->a_ops = &configfs_aops;
 		inode->i_mapping->backing_dev_info = &configfs_backing_dev_info;
+		inode->i_op = &configfs_inode_operations;
+
+		if (sd->s_iattr) {
+			/* sysfs_dirent has non-default attributes
+			 * get them for the new inode from persistent copy
+			 * in sysfs_dirent
+			 */
+			set_inode_attr(inode, sd->s_iattr);
+		} else
+			set_default_inode_attr(inode, mode);
 	}
 	return inode;
 }
@@ -70,7 +160,8 @@ int configfs_create(struct dentry * dent
 	struct inode * inode = NULL;
 	if (dentry) {
 		if (!dentry->d_inode) {
-			if ((inode = configfs_new_inode(mode))) {
+			struct configfs_dirent *sd = dentry->d_fsdata;
+			if ((inode = configfs_new_inode(mode, sd))) {
 				if (dentry->d_parent && dentry->d_parent->d_inode) {
 					struct inode *p_inode = dentry->d_parent->d_inode;
 					p_inode->i_mtime = p_inode->i_ctime = CURRENT_TIME;
@@ -103,10 +194,9 @@ int configfs_create(struct dentry * dent
  */
 const unsigned char * configfs_get_name(struct configfs_dirent *sd)
 {
-	struct attribute * attr;
+	struct configfs_attribute *attr;
 
-	if (!sd || !sd->s_element)
-		BUG();
+	BUG_ON(!sd || !sd->s_element);
 
 	/* These always have a dentry, so use that */
 	if (sd->s_type & (CONFIGFS_DIR | CONFIGFS_ITEM_LINK))
@@ -114,7 +204,7 @@ const unsigned char * configfs_get_name(
 
 	if (sd->s_type & CONFIGFS_ITEM_ATTR) {
 		attr = sd->s_element;
-		return attr->name;
+		return attr->ca_name;
 	}
 	return NULL;
 }
@@ -130,13 +220,17 @@ void configfs_drop_dentry(struct configf
 
 	if (dentry) {
 		spin_lock(&dcache_lock);
+		spin_lock(&dentry->d_lock);
 		if (!(d_unhashed(dentry) && dentry->d_inode)) {
 			dget_locked(dentry);
 			__d_drop(dentry);
+			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
 			simple_unlink(parent->d_inode, dentry);
-		} else
+		} else {
+			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
+		}
 	}
 }
 
@@ -145,6 +239,10 @@ void configfs_hash_and_remove(struct den
 	struct configfs_dirent * sd;
 	struct configfs_dirent * parent_sd = dir->d_fsdata;
 
+	if (dir->d_inode == NULL)
+		/* no inode means this hasn't been made visible yet */
+		return;
+
 	mutex_lock(&dir->d_inode->i_mutex);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (!sd->s_element)
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 1a2f6f6..f920d30 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -38,6 +38,7 @@
 
 struct vfsmount * configfs_mount = NULL;
 struct super_block * configfs_sb = NULL;
+kmem_cache_t *configfs_dir_cachep;
 static int configfs_mnt_count = 0;
 
 static struct super_operations configfs_ops = {
@@ -62,6 +63,7 @@ static struct configfs_dirent configfs_r
 	.s_children	= LIST_HEAD_INIT(configfs_root.s_children),
 	.s_element	= &configfs_root_group.cg_item,
 	.s_type		= CONFIGFS_ROOT,
+	.s_iattr	= NULL,
 };
 
 static int configfs_fill_super(struct super_block *sb, void *data, int silent)
@@ -73,9 +75,11 @@ static int configfs_fill_super(struct su
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = CONFIGFS_MAGIC;
 	sb->s_op = &configfs_ops;
+	sb->s_time_gran = 1;
 	configfs_sb = sb;
 
-	inode = configfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
+	inode = configfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
+				   &configfs_root);
 	if (inode) {
 		inode->i_op = &configfs_dir_inode_operations;
 		inode->i_fop = &configfs_dir_operations;
@@ -128,19 +132,31 @@ static decl_subsys(config, NULL, NULL);
 
 static int __init configfs_init(void)
 {
-	int err;
+	int err = -ENOMEM;
+
+	configfs_dir_cachep = kmem_cache_create("configfs_dir_cache",
+						sizeof(struct configfs_dirent),
+						0, 0, NULL, NULL);
+	if (!configfs_dir_cachep)
+		goto out;
 
 	kset_set_kset_s(&config_subsys, kernel_subsys);
 	err = subsystem_register(&config_subsys);
-	if (err)
-		return err;
+	if (err) {
+		kmem_cache_destroy(configfs_dir_cachep);
+		configfs_dir_cachep = NULL;
+		goto out;
+	}
 
 	err = register_filesystem(&configfs_fs_type);
 	if (err) {
 		printk(KERN_ERR "configfs: Unable to register filesystem!\n");
 		subsystem_unregister(&config_subsys);
+		kmem_cache_destroy(configfs_dir_cachep);
+		configfs_dir_cachep = NULL;
 	}
 
+out:
 	return err;
 }
 
@@ -148,11 +164,13 @@ static void __exit configfs_exit(void)
 {
 	unregister_filesystem(&configfs_fs_type);
 	subsystem_unregister(&config_subsys);
+	kmem_cache_destroy(configfs_dir_cachep);
+	configfs_dir_cachep = NULL;
 }
 
 MODULE_AUTHOR("Oracle");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("0.0.1");
+MODULE_VERSION("0.0.2");
 MODULE_DESCRIPTION("Simple RAM filesystem for user driven kernel subsystem configuration.");
 
 module_init(configfs_init);
diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 50f5840..e5512e2 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -162,8 +162,7 @@ int configfs_unlink(struct inode *dir, s
 	if (!(sd->s_type & CONFIGFS_ITEM_LINK))
 		goto out;
 
-	if (dentry->d_parent == configfs_sb->s_root)
-		BUG();
+	BUG_ON(dentry->d_parent == configfs_sb->s_root);
 
 	sl = sd->s_element;
 
@@ -277,5 +276,6 @@ struct inode_operations configfs_symlink
 	.follow_link = configfs_follow_link,
 	.readlink = generic_readlink,
 	.put_link = configfs_put_link,
+	.setattr = configfs_setattr,
 };
 
diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index d424041..bae3d75 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -58,7 +58,7 @@ int ocfs2_write_block(struct ocfs2_super
 		goto out;
 	}
 
-	down(&OCFS2_I(inode)->ip_io_sem);
+	mutex_lock(&OCFS2_I(inode)->ip_io_mutex);
 
 	lock_buffer(bh);
 	set_buffer_uptodate(bh);
@@ -82,7 +82,7 @@ int ocfs2_write_block(struct ocfs2_super
 		brelse(bh);
 	}
 
-	up(&OCFS2_I(inode)->ip_io_sem);
+	mutex_unlock(&OCFS2_I(inode)->ip_io_mutex);
 out:
 	mlog_exit(ret);
 	return ret;
@@ -125,13 +125,13 @@ int ocfs2_read_blocks(struct ocfs2_super
 		flags &= ~OCFS2_BH_CACHED;
 
 	if (inode)
-		down(&OCFS2_I(inode)->ip_io_sem);
+		mutex_lock(&OCFS2_I(inode)->ip_io_mutex);
 	for (i = 0 ; i < nr ; i++) {
 		if (bhs[i] == NULL) {
 			bhs[i] = sb_getblk(sb, block++);
 			if (bhs[i] == NULL) {
 				if (inode)
-					up(&OCFS2_I(inode)->ip_io_sem);
+					mutex_unlock(&OCFS2_I(inode)->ip_io_mutex);
 				status = -EIO;
 				mlog_errno(status);
 				goto bail;
@@ -220,7 +220,7 @@ int ocfs2_read_blocks(struct ocfs2_super
 			ocfs2_set_buffer_uptodate(inode, bh);
 	}
 	if (inode)
-		up(&OCFS2_I(inode)->ip_io_sem);
+		mutex_unlock(&OCFS2_I(inode)->ip_io_mutex);
 
 	mlog(ML_BH_IO, "block=(%"MLFu64"), nr=(%d), cached=%s\n", block, nr,
 	     (!(flags & OCFS2_BH_CACHED) || ignore_cache) ? "no" : "yes");
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 7307ba5..d08971d 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -917,8 +917,9 @@ static int o2hb_thread(void *data)
 		elapsed_msec = o2hb_elapsed_msecs(&before_hb, &after_hb);
 
 		mlog(0, "start = %lu.%lu, end = %lu.%lu, msec = %u\n",
-		     before_hb.tv_sec, before_hb.tv_usec,
-		     after_hb.tv_sec, after_hb.tv_usec, elapsed_msec);
+		     before_hb.tv_sec, (unsigned long) before_hb.tv_usec,
+		     after_hb.tv_sec, (unsigned long) after_hb.tv_usec,
+		     elapsed_msec);
 
 		if (elapsed_msec < reg->hr_timeout_ms) {
 			/* the kthread api has blocked signals for us so no
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 35d92c0..d22d4cf 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1285,14 +1285,16 @@ static void o2net_idle_timer(unsigned lo
 	mlog(ML_NOTICE, "here are some times that might help debug the "
 	     "situation: (tmr %ld.%ld now %ld.%ld dr %ld.%ld adv "
 	     "%ld.%ld:%ld.%ld func (%08x:%u) %ld.%ld:%ld.%ld)\n",
-	     sc->sc_tv_timer.tv_sec, sc->sc_tv_timer.tv_usec, 
-	     now.tv_sec, now.tv_usec,
-	     sc->sc_tv_data_ready.tv_sec, sc->sc_tv_data_ready.tv_usec, 
-	     sc->sc_tv_advance_start.tv_sec, sc->sc_tv_advance_start.tv_usec, 
-	     sc->sc_tv_advance_stop.tv_sec, sc->sc_tv_advance_stop.tv_usec, 
+	     sc->sc_tv_timer.tv_sec, (long) sc->sc_tv_timer.tv_usec, 
+	     now.tv_sec, (long) now.tv_usec,
+	     sc->sc_tv_data_ready.tv_sec, (long) sc->sc_tv_data_ready.tv_usec,
+	     sc->sc_tv_advance_start.tv_sec,
+	     (long) sc->sc_tv_advance_start.tv_usec,
+	     sc->sc_tv_advance_stop.tv_sec,
+	     (long) sc->sc_tv_advance_stop.tv_usec,
 	     sc->sc_msg_key, sc->sc_msg_type,
-	     sc->sc_tv_func_start.tv_sec, sc->sc_tv_func_start.tv_usec,
-	     sc->sc_tv_func_stop.tv_sec, sc->sc_tv_func_stop.tv_usec);
+	     sc->sc_tv_func_start.tv_sec, (long) sc->sc_tv_func_start.tv_usec,
+	     sc->sc_tv_func_stop.tv_sec, (long) sc->sc_tv_func_stop.tv_usec);
 
 	o2net_sc_queue_work(sc, &sc->sc_shutdown_work);
 }
diff --git a/fs/ocfs2/dlm/dlmcommon.h b/fs/ocfs2/dlm/dlmcommon.h
index 3fecba0..42eb53b 100644
--- a/fs/ocfs2/dlm/dlmcommon.h
+++ b/fs/ocfs2/dlm/dlmcommon.h
@@ -657,6 +657,7 @@ void dlm_complete_thread(struct dlm_ctxt
 int dlm_launch_recovery_thread(struct dlm_ctxt *dlm);
 void dlm_complete_recovery_thread(struct dlm_ctxt *dlm);
 void dlm_wait_for_recovery(struct dlm_ctxt *dlm);
+int dlm_is_node_dead(struct dlm_ctxt *dlm, u8 node);
 
 void dlm_put(struct dlm_ctxt *dlm);
 struct dlm_ctxt *dlm_grab(struct dlm_ctxt *dlm);
diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index da3c220..6ee3083 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -573,8 +573,11 @@ static int dlm_query_join_handler(struct
 	spin_lock(&dlm_domain_lock);
 	dlm = __dlm_lookup_domain_full(query->domain, query->name_len);
 	/* Once the dlm ctxt is marked as leaving then we don't want
-	 * to be put in someone's domain map. */
+	 * to be put in someone's domain map. 
+	 * Also, explicitly disallow joining at certain troublesome
+	 * times (ie. during recovery). */
 	if (dlm && dlm->dlm_state != DLM_CTXT_LEAVING) {
+		int bit = query->node_idx;
 		spin_lock(&dlm->spinlock);
 
 		if (dlm->dlm_state == DLM_CTXT_NEW &&
@@ -586,6 +589,19 @@ static int dlm_query_join_handler(struct
 		} else if (dlm->joining_node != DLM_LOCK_RES_OWNER_UNKNOWN) {
 			/* Disallow parallel joins. */
 			response = JOIN_DISALLOW;
+		} else if (dlm->reco.state & DLM_RECO_STATE_ACTIVE) {
+			mlog(ML_NOTICE, "node %u trying to join, but recovery "
+			     "is ongoing.\n", bit);
+			response = JOIN_DISALLOW;
+		} else if (test_bit(bit, dlm->recovery_map)) {
+			mlog(ML_NOTICE, "node %u trying to join, but it "
+			     "still needs recovery.\n", bit);
+			response = JOIN_DISALLOW;
+		} else if (test_bit(bit, dlm->domain_map)) {
+			mlog(ML_NOTICE, "node %u trying to join, but it "
+			     "is still in the domain! needs recovery?\n",
+			     bit);
+			response = JOIN_DISALLOW;
 		} else {
 			/* Alright we're fully a part of this domain
 			 * so we keep some state as to who's joining
diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 27e984f..a3194fe 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -1050,17 +1050,10 @@ static int dlm_restart_lock_mastery(stru
 	node = dlm_bitmap_diff_iter_next(&bdi, &sc);
 	while (node >= 0) {
 		if (sc == NODE_UP) {
-			/* a node came up.  easy.  might not even need
-			 * to talk to it if its node number is higher
-			 * or if we are already blocked. */
-			mlog(0, "node up! %d\n", node);
-			if (blocked)
-				goto next;
-
-			if (node > dlm->node_num) {
-				mlog(0, "node > this node. skipping.\n");
-				goto next;
-			}
+			/* a node came up.  clear any old vote from
+			 * the response map and set it in the vote map
+			 * then restart the mastery. */
+			mlog(ML_NOTICE, "node %d up while restarting\n", node);
 
 			/* redo the master request, but only for the new node */
 			mlog(0, "sending request to new node\n");
@@ -2005,6 +1998,15 @@ fail:
 				break;
 
 			mlog(0, "timed out during migration\n");
+			/* avoid hang during shutdown when migrating lockres 
+			 * to a node which also goes down */
+			if (dlm_is_node_dead(dlm, target)) {
+				mlog(0, "%s:%.*s: expected migration target %u "
+				     "is no longer up.  restarting.\n",
+				     dlm->name, res->lockname.len,
+				     res->lockname.name, target);
+				ret = -ERESTARTSYS;
+			}
 		}
 		if (ret == -ERESTARTSYS) {
 			/* migration failed, detach and clean up mle */
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 0c8eb10..186e9a7 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -39,6 +39,7 @@
 #include <linux/inet.h>
 #include <linux/timer.h>
 #include <linux/kthread.h>
+#include <linux/delay.h>
 
 
 #include "cluster/heartbeat.h"
@@ -256,6 +257,27 @@ static int dlm_recovery_thread(void *dat
 	return 0;
 }
 
+/* returns true when the recovery master has contacted us */
+static int dlm_reco_master_ready(struct dlm_ctxt *dlm)
+{
+	int ready;
+	spin_lock(&dlm->spinlock);
+	ready = (dlm->reco.new_master != O2NM_INVALID_NODE_NUM);
+	spin_unlock(&dlm->spinlock);
+	return ready;
+}
+
+/* returns true if node is no longer in the domain
+ * could be dead or just not joined */
+int dlm_is_node_dead(struct dlm_ctxt *dlm, u8 node)
+{
+	int dead;
+	spin_lock(&dlm->spinlock);
+	dead = test_bit(node, dlm->domain_map);
+	spin_unlock(&dlm->spinlock);
+	return dead;
+}
+
 /* callers of the top-level api calls (dlmlock/dlmunlock) should
  * block on the dlm->reco.event when recovery is in progress.
  * the dlm recovery thread will set this state when it begins
@@ -297,6 +319,7 @@ static void dlm_end_recovery(struct dlm_
 static int dlm_do_recovery(struct dlm_ctxt *dlm)
 {
 	int status = 0;
+	int ret;
 
 	spin_lock(&dlm->spinlock);
 
@@ -343,10 +366,13 @@ static int dlm_do_recovery(struct dlm_ct
 		goto master_here;
 
 	if (dlm->reco.new_master == O2NM_INVALID_NODE_NUM) {
-		/* choose a new master */
-		if (!dlm_pick_recovery_master(dlm)) {
+		/* choose a new master, returns 0 if this node
+		 * is the master, -EEXIST if it's another node.
+		 * this does not return until a new master is chosen
+		 * or recovery completes entirely. */
+		ret = dlm_pick_recovery_master(dlm);
+		if (!ret) {
 			/* already notified everyone.  go. */
-			dlm->reco.new_master = dlm->node_num;
 			goto master_here;
 		}
 		mlog(0, "another node will master this recovery session.\n");
@@ -371,8 +397,13 @@ master_here:
 	if (status < 0) {
 		mlog(ML_ERROR, "error %d remastering locks for node %u, "
 		     "retrying.\n", status, dlm->reco.dead_node);
+		/* yield a bit to allow any final network messages
+		 * to get handled on remaining nodes */
+		msleep(100);
 	} else {
 		/* success!  see if any other nodes need recovery */
+		mlog(0, "DONE mastering recovery of %s:%u here(this=%u)!\n",
+		     dlm->name, dlm->reco.dead_node, dlm->node_num);
 		dlm_reset_recovery(dlm);
 	}
 	dlm_end_recovery(dlm);
@@ -477,7 +508,7 @@ static int dlm_remaster_locks(struct dlm
 					BUG();
 					break;
 				case DLM_RECO_NODE_DATA_DEAD:
-					mlog(0, "node %u died after "
+					mlog(ML_NOTICE, "node %u died after "
 					     "requesting recovery info for "
 					     "node %u\n", ndata->node_num,
 					     dead_node);
@@ -485,6 +516,19 @@ static int dlm_remaster_locks(struct dlm
 					// start all over
 					destroy = 1;
 					status = -EAGAIN;
+					/* instead of spinning like crazy here,
+					 * wait for the domain map to catch up
+					 * with the network state.  otherwise this
+					 * can be hit hundreds of times before
+					 * the node is really seen as dead. */
+					wait_event_timeout(dlm->dlm_reco_thread_wq,
+							   dlm_is_node_dead(dlm,
+								ndata->node_num),
+							   msecs_to_jiffies(1000));
+					mlog(0, "waited 1 sec for %u, "
+					     "dead? %s\n", ndata->node_num,
+					     dlm_is_node_dead(dlm, ndata->node_num) ?
+					     "yes" : "no");
 					goto leave;
 				case DLM_RECO_NODE_DATA_RECEIVING:
 				case DLM_RECO_NODE_DATA_REQUESTED:
@@ -678,11 +722,27 @@ static void dlm_request_all_locks_worker
 	dlm = item->dlm;
 	dead_node = item->u.ral.dead_node;
 	reco_master = item->u.ral.reco_master;
+	mres = (struct dlm_migratable_lockres *)data;
+
+	if (dead_node != dlm->reco.dead_node ||
+	    reco_master != dlm->reco.new_master) {
+		/* show extra debug info if the recovery state is messed */
+		mlog(ML_ERROR, "%s: bad reco state: reco(dead=%u, master=%u), "
+		     "request(dead=%u, master=%u)\n",
+		     dlm->name, dlm->reco.dead_node, dlm->reco.new_master,
+		     dead_node, reco_master);
+		mlog(ML_ERROR, "%s: name=%.*s master=%u locks=%u/%u flags=%u "
+		     "entry[0]={c=%"MLFu64",l=%u,f=%u,t=%d,ct=%d,hb=%d,n=%u}\n",
+		     dlm->name, mres->lockname_len, mres->lockname, mres->master,
+		     mres->num_locks, mres->total_locks, mres->flags,
+		     mres->ml[0].cookie, mres->ml[0].list, mres->ml[0].flags,
+		     mres->ml[0].type, mres->ml[0].convert_type,
+		     mres->ml[0].highest_blocked, mres->ml[0].node);
+		BUG();
+	}
 	BUG_ON(dead_node != dlm->reco.dead_node);
 	BUG_ON(reco_master != dlm->reco.new_master);
 
-	mres = (struct dlm_migratable_lockres *)data;
-
 	/* lock resources should have already been moved to the
  	 * dlm->reco.resources list.  now move items from that list
  	 * to a temp list if the dead owner matches.  note that the
@@ -757,15 +817,18 @@ int dlm_reco_data_done_handler(struct o2
 			continue;
 
 		switch (ndata->state) {
+			/* should have moved beyond INIT but not to FINALIZE yet */
 			case DLM_RECO_NODE_DATA_INIT:
 			case DLM_RECO_NODE_DATA_DEAD:
-			case DLM_RECO_NODE_DATA_DONE:
 			case DLM_RECO_NODE_DATA_FINALIZE_SENT:
 				mlog(ML_ERROR, "bad ndata state for node %u:"
 				     " state=%d\n", ndata->node_num,
 				     ndata->state);
 				BUG();
 				break;
+			/* these states are possible at this point, anywhere along
+			 * the line of recovery */
+			case DLM_RECO_NODE_DATA_DONE:
 			case DLM_RECO_NODE_DATA_RECEIVING:
 			case DLM_RECO_NODE_DATA_REQUESTED:
 			case DLM_RECO_NODE_DATA_REQUESTING:
@@ -799,13 +862,31 @@ static void dlm_move_reco_locks_to_list(
 {
 	struct dlm_lock_resource *res;
 	struct list_head *iter, *iter2;
+	struct dlm_lock *lock;
 
 	spin_lock(&dlm->spinlock);
 	list_for_each_safe(iter, iter2, &dlm->reco.resources) {
 		res = list_entry (iter, struct dlm_lock_resource, recovering);
+		/* always prune any $RECOVERY entries for dead nodes,
+		 * otherwise hangs can occur during later recovery */
 		if (dlm_is_recovery_lock(res->lockname.name,
-					 res->lockname.len))
+					 res->lockname.len)) {
+			spin_lock(&res->spinlock);
+			list_for_each_entry(lock, &res->granted, list) {
+				if (lock->ml.node == dead_node) {
+					mlog(0, "AHA! there was "
+					     "a $RECOVERY lock for dead "
+					     "node %u (%s)!\n", 
+					     dead_node, dlm->name);
+					list_del_init(&lock->list);
+					dlm_lock_put(lock);
+					break;
+				}
+			}
+			spin_unlock(&res->spinlock);
 			continue;
+		}
+
 		if (res->owner == dead_node) {
 			mlog(0, "found lockres owned by dead node while "
 				  "doing recovery for node %u. sending it.\n",
@@ -1179,7 +1260,7 @@ static void dlm_mig_lockres_worker(struc
 again:
 		ret = dlm_lockres_master_requery(dlm, res, &real_master);
 		if (ret < 0) {
-			mlog(0, "dlm_lockres_master_requery failure: %d\n",
+			mlog(0, "dlm_lockres_master_requery ret=%d\n",
 				  ret);
 			goto again;
 		}
@@ -1757,6 +1838,7 @@ static void dlm_do_local_recovery_cleanu
 	struct dlm_lock_resource *res;
 	int i;
 	struct list_head *bucket;
+	struct dlm_lock *lock;
 
 
 	/* purge any stale mles */
@@ -1780,10 +1862,25 @@ static void dlm_do_local_recovery_cleanu
 		bucket = &(dlm->resources[i]);
 		list_for_each(iter, bucket) {
 			res = list_entry (iter, struct dlm_lock_resource, list);
+ 			/* always prune any $RECOVERY entries for dead nodes,
+ 			 * otherwise hangs can occur during later recovery */
 			if (dlm_is_recovery_lock(res->lockname.name,
-						 res->lockname.len))
+						 res->lockname.len)) {
+				spin_lock(&res->spinlock);
+				list_for_each_entry(lock, &res->granted, list) {
+					if (lock->ml.node == dead_node) {
+						mlog(0, "AHA! there was "
+						     "a $RECOVERY lock for dead "
+						     "node %u (%s)!\n",
+						     dead_node, dlm->name);
+						list_del_init(&lock->list);
+						dlm_lock_put(lock);
+						break;
+					}
+				}
+				spin_unlock(&res->spinlock);
 				continue;
-			
+			}			
 			spin_lock(&res->spinlock);
 			/* zero the lvb if necessary */
 			dlm_revalidate_lvb(dlm, res, dead_node);
@@ -1869,12 +1966,9 @@ void dlm_hb_node_up_cb(struct o2nm_node 
 		return;
 
 	spin_lock(&dlm->spinlock);
-
 	set_bit(idx, dlm->live_nodes_map);
-
-	/* notify any mles attached to the heartbeat events */
-	dlm_hb_event_notify_attached(dlm, idx, 1);
-
+	/* do NOT notify mle attached to the heartbeat events.
+	 * new nodes are not interesting in mastery until joined. */
 	spin_unlock(&dlm->spinlock);
 
 	dlm_put(dlm);
@@ -1897,7 +1991,18 @@ static void dlm_reco_unlock_ast(void *as
 	mlog(0, "unlockast for recovery lock fired!\n");
 }
 
-
+/*
+ * dlm_pick_recovery_master will continually attempt to use
+ * dlmlock() on the special "$RECOVERY" lockres with the
+ * LKM_NOQUEUE flag to get an EX.  every thread that enters
+ * this function on each node racing to become the recovery
+ * master will not stop attempting this until either:
+ * a) this node gets the EX (and becomes the recovery master),
+ * or b) dlm->reco.new_master gets set to some nodenum 
+ * != O2NM_INVALID_NODE_NUM (another node will do the reco).
+ * so each time a recovery master is needed, the entire cluster
+ * will sync at this point.  if the new master dies, that will
+ * be detected in dlm_do_recovery */
 static int dlm_pick_recovery_master(struct dlm_ctxt *dlm)
 {
 	enum dlm_status ret;
@@ -1906,23 +2011,45 @@ static int dlm_pick_recovery_master(stru
 
 	mlog(0, "starting recovery of %s at %lu, dead=%u, this=%u\n",
 	     dlm->name, jiffies, dlm->reco.dead_node, dlm->node_num);
-retry:
+again:	
 	memset(&lksb, 0, sizeof(lksb));
 
 	ret = dlmlock(dlm, LKM_EXMODE, &lksb, LKM_NOQUEUE|LKM_RECOVERY,
 		      DLM_RECOVERY_LOCK_NAME, dlm_reco_ast, dlm, dlm_reco_bast);
 
+	mlog(0, "%s: dlmlock($RECOVERY) returned %d, lksb=%d\n",
+	     dlm->name, ret, lksb.status);
+
 	if (ret == DLM_NORMAL) {
 		mlog(0, "dlm=%s dlmlock says I got it (this=%u)\n",
 		     dlm->name, dlm->node_num);
-		/* I am master, send message to all nodes saying
-		 * that I am beginning a recovery session */
-		status = dlm_send_begin_reco_message(dlm,
-					      dlm->reco.dead_node);
+		
+		/* got the EX lock.  check to see if another node 
+		 * just became the reco master */
+		if (dlm_reco_master_ready(dlm)) {
+			mlog(0, "%s: got reco EX lock, but %u will "
+			     "do the recovery\n", dlm->name,
+			     dlm->reco.new_master);
+			status = -EEXIST;
+		} else {
+			status = dlm_send_begin_reco_message(dlm,
+				      dlm->reco.dead_node);
+			/* this always succeeds */
+			BUG_ON(status);
+
+			/* set the new_master to this node */
+			spin_lock(&dlm->spinlock);
+			dlm->reco.new_master = dlm->node_num;
+			spin_unlock(&dlm->spinlock);
+		}
 
 		/* recovery lock is a special case.  ast will not get fired,
 		 * so just go ahead and unlock it. */
 		ret = dlmunlock(dlm, &lksb, 0, dlm_reco_unlock_ast, dlm);
+		if (ret == DLM_DENIED) {
+			mlog(0, "got DLM_DENIED, trying LKM_CANCEL\n");
+			ret = dlmunlock(dlm, &lksb, LKM_CANCEL, dlm_reco_unlock_ast, dlm);
+		}
 		if (ret != DLM_NORMAL) {
 			/* this would really suck. this could only happen
 			 * if there was a network error during the unlock
@@ -1930,20 +2057,42 @@ retry:
 			 * is actually "done" and the lock structure is
 			 * even freed.  we can continue, but only
 			 * because this specific lock name is special. */
-			mlog(0, "dlmunlock returned %d\n", ret);
-		}
-
-		if (status < 0) {
-			mlog(0, "failed to send recovery message. "
-				   "must retry with new node map.\n");
-			goto retry;
+			mlog(ML_ERROR, "dlmunlock returned %d\n", ret);
 		}
 	} else if (ret == DLM_NOTQUEUED) {
 		mlog(0, "dlm=%s dlmlock says another node got it (this=%u)\n",
 		     dlm->name, dlm->node_num);
 		/* another node is master. wait on
-		 * reco.new_master != O2NM_INVALID_NODE_NUM */
+		 * reco.new_master != O2NM_INVALID_NODE_NUM 
+		 * for at most one second */
+		wait_event_timeout(dlm->dlm_reco_thread_wq,
+					 dlm_reco_master_ready(dlm),
+					 msecs_to_jiffies(1000));
+		if (!dlm_reco_master_ready(dlm)) {
+			mlog(0, "%s: reco master taking awhile\n",
+			     dlm->name);
+			goto again;
+		}
+		/* another node has informed this one that it is reco master */
+		mlog(0, "%s: reco master %u is ready to recover %u\n",
+		     dlm->name, dlm->reco.new_master, dlm->reco.dead_node);
 		status = -EEXIST;
+	} else {
+		struct dlm_lock_resource *res;
+
+		/* dlmlock returned something other than NOTQUEUED or NORMAL */
+		mlog(ML_ERROR, "%s: got %s from dlmlock($RECOVERY), "
+		     "lksb.status=%s\n", dlm->name, dlm_errname(ret),
+		     dlm_errname(lksb.status));
+		res = dlm_lookup_lockres(dlm, DLM_RECOVERY_LOCK_NAME,
+					 DLM_RECOVERY_LOCK_NAME_LEN);
+		if (res) {
+			dlm_print_one_lock_resource(res);
+			dlm_lockres_put(res);
+		} else {
+			mlog(ML_ERROR, "recovery lock not found\n");
+		}
+		BUG();
 	}
 
 	return status;
@@ -1982,7 +2131,7 @@ static int dlm_send_begin_reco_message(s
 			mlog(0, "not sending begin reco to self\n");
 			continue;
 		}
-
+retry:
 		ret = -EINVAL;
 		mlog(0, "attempting to send begin reco msg to %d\n",
 			  nodenum);
@@ -1991,8 +2140,17 @@ static int dlm_send_begin_reco_message(s
 		/* negative status is handled ok by caller here */
 		if (ret >= 0)
 			ret = status;
+		if (dlm_is_host_down(ret)) {
+			/* node is down.  not involved in recovery
+			 * so just keep going */
+			mlog(0, "%s: node %u was down when sending "
+			     "begin reco msg (%d)\n", dlm->name, nodenum, ret);
+			ret = 0;
+		}
 		if (ret < 0) {
 			struct dlm_lock_resource *res;
+			/* this is now a serious problem, possibly ENOMEM 
+			 * in the network stack.  must retry */
 			mlog_errno(ret);
 			mlog(ML_ERROR, "begin reco of dlm %s to node %u "
 			    " returned %d\n", dlm->name, nodenum, ret);
@@ -2004,7 +2162,10 @@ static int dlm_send_begin_reco_message(s
 			} else {
 				mlog(ML_ERROR, "recovery lock not found\n");
 			}
-			break;
+			/* sleep for a bit in hopes that we can avoid 
+			 * another ENOMEM */
+			msleep(100);
+			goto retry;
 		}
 	}
 
@@ -2027,19 +2188,34 @@ int dlm_begin_reco_handler(struct o2net_
 
 	spin_lock(&dlm->spinlock);
 	if (dlm->reco.new_master != O2NM_INVALID_NODE_NUM) {
-		mlog(0, "new_master already set to %u!\n",
-			  dlm->reco.new_master);
+		if (test_bit(dlm->reco.new_master, dlm->recovery_map)) {
+			mlog(0, "%s: new_master %u died, changing "
+			     "to %u\n", dlm->name, dlm->reco.new_master,
+			     br->node_idx);
+		} else {
+			mlog(0, "%s: new_master %u NOT DEAD, changing "
+			     "to %u\n", dlm->name, dlm->reco.new_master,
+			     br->node_idx);
+			/* may not have seen the new master as dead yet */
+		}
 	}
 	if (dlm->reco.dead_node != O2NM_INVALID_NODE_NUM) {
-		mlog(0, "dead_node already set to %u!\n",
-			  dlm->reco.dead_node);
+		mlog(ML_NOTICE, "%s: dead_node previously set to %u, "
+		     "node %u changing it to %u\n", dlm->name, 
+		     dlm->reco.dead_node, br->node_idx, br->dead_node);
 	}
 	dlm->reco.new_master = br->node_idx;
 	dlm->reco.dead_node = br->dead_node;
 	if (!test_bit(br->dead_node, dlm->recovery_map)) {
-		mlog(ML_ERROR, "recovery master %u sees %u as dead, but this "
+		mlog(0, "recovery master %u sees %u as dead, but this "
 		     "node has not yet.  marking %u as dead\n",
 		     br->node_idx, br->dead_node, br->dead_node);
+		if (!test_bit(br->dead_node, dlm->domain_map) ||
+		    !test_bit(br->dead_node, dlm->live_nodes_map))
+			mlog(0, "%u not in domain/live_nodes map "
+			     "so setting it in reco map manually\n",
+			     br->dead_node);
+		set_bit(br->dead_node, dlm->recovery_map);
 		__dlm_hb_node_down(dlm, br->dead_node);
 	}
 	spin_unlock(&dlm->spinlock);
diff --git a/fs/ocfs2/dlm/dlmunlock.c b/fs/ocfs2/dlm/dlmunlock.c
index cec2ce1..c95f08d 100644
--- a/fs/ocfs2/dlm/dlmunlock.c
+++ b/fs/ocfs2/dlm/dlmunlock.c
@@ -188,6 +188,19 @@ static enum dlm_status dlmunlock_common(
 			actions &= ~(DLM_UNLOCK_REMOVE_LOCK|
 				     DLM_UNLOCK_REGRANT_LOCK|
 				     DLM_UNLOCK_CLEAR_CONVERT_TYPE);
+		} else if (status == DLM_RECOVERING || 
+			   status == DLM_MIGRATING || 
+			   status == DLM_FORWARD) {
+			/* must clear the actions because this unlock
+			 * is about to be retried.  cannot free or do
+			 * any list manipulation. */
+			mlog(0, "%s:%.*s: clearing actions, %s\n",
+			     dlm->name, res->lockname.len,
+			     res->lockname.name,
+			     status==DLM_RECOVERING?"recovering":
+			     (status==DLM_MIGRATING?"migrating":
+			      "forward"));
+			actions = 0;
 		}
 		if (flags & LKM_CANCEL)
 			lock->cancel_pending = 0;
diff --git a/fs/ocfs2/dlm/userdlm.c b/fs/ocfs2/dlm/userdlm.c
index e1fdd28..c3764f4 100644
--- a/fs/ocfs2/dlm/userdlm.c
+++ b/fs/ocfs2/dlm/userdlm.c
@@ -27,7 +27,7 @@
  * Boston, MA 021110-1307, USA.
  */
 
-#include <asm/signal.h>
+#include <linux/signal.h>
 
 #include <linux/module.h>
 #include <linux/fs.h>
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index f2fb40c..b6ba292 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -262,8 +262,7 @@ static int ocfs2_extent_map_find_leaf(st
 		el = &eb->h_list;
 	}
 
-	if (el->l_tree_depth)
-		BUG();
+	BUG_ON(el->l_tree_depth);
 
 	for (i = 0; i < le16_to_cpu(el->l_next_free_rec); i++) {
 		rec = &el->l_recs[i];
@@ -364,8 +363,8 @@ static int ocfs2_extent_map_lookup_read(
 		return ret;
 	}
 
-	if (ent->e_tree_depth)
-		BUG();  /* FIXME: Make sure this isn't a corruption */
+	/* FIXME: Make sure this isn't a corruption */
+	BUG_ON(ent->e_tree_depth);
 
 	*ret_ent = ent;
 
@@ -423,8 +422,7 @@ static int ocfs2_extent_map_try_insert(s
 					  le32_to_cpu(rec->e_clusters), NULL,
 					  NULL);
 
-	if (!old_ent)
-		BUG();
+	BUG_ON(!old_ent);
 
 	ret = -EEXIST;
 	if (old_ent->e_tree_depth < tree_depth)
@@ -988,7 +986,7 @@ int __init init_ocfs2_extent_maps(void)
 	return 0;
 }
 
-void __exit exit_ocfs2_extent_maps(void)
+void exit_ocfs2_extent_maps(void)
 {
 	kmem_cache_destroy(ocfs2_em_ent_cachep);
 }
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index eaf33ca..1715bc9 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1022,8 +1022,9 @@ static ssize_t ocfs2_file_aio_write(stru
 		}
 		newsize = count + saved_pos;
 
-		mlog(0, "pos=%lld newsize=%"MLFu64" cursize=%lld\n",
-		     saved_pos, newsize, i_size_read(inode));
+		mlog(0, "pos=%lld newsize=%lld cursize=%lld\n",
+		     (long long) saved_pos, (long long) newsize,
+		     (long long) i_size_read(inode));
 
 		/* No need for a higher level metadata lock if we're
 		 * never going past i_size. */
@@ -1042,8 +1043,9 @@ static ssize_t ocfs2_file_aio_write(stru
 		spin_unlock(&OCFS2_I(inode)->ip_lock);
 
 		mlog(0, "Writing at EOF, may need more allocation: "
-		     "i_size = %lld, newsize = %"MLFu64", need %u clusters\n",
-		     i_size_read(inode), newsize, clusters);
+		     "i_size = %lld, newsize = %lld, need %u clusters\n",
+		     (long long) i_size_read(inode), (long long) newsize,
+		     clusters);
 
 		/* We only want to continue the rest of this loop if
 		 * our extend will actually require more
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index d4ecc06..8122489 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -903,10 +903,10 @@ void ocfs2_clear_inode(struct inode *ino
 			"Clear inode of %"MLFu64", inode is locked\n",
 			oi->ip_blkno);
 
-	mlog_bug_on_msg(down_trylock(&oi->ip_io_sem),
-			"Clear inode of %"MLFu64", io_sem is locked\n",
+	mlog_bug_on_msg(!mutex_trylock(&oi->ip_io_mutex),
+			"Clear inode of %"MLFu64", io_mutex is locked\n",
 			oi->ip_blkno);
-	up(&oi->ip_io_sem);
+	mutex_unlock(&oi->ip_io_mutex);
 
 	/*
 	 * down_trylock() returns 0, down_write_trylock() returns 1
diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
index 9b01774..84c5079 100644
--- a/fs/ocfs2/inode.h
+++ b/fs/ocfs2/inode.h
@@ -46,10 +46,10 @@ struct ocfs2_inode_info
 	struct list_head		ip_io_markers;
 	int				ip_orphaned_slot;
 
-	struct semaphore		ip_io_sem;
+	struct mutex			ip_io_mutex;
 
 	/* Used by the journalling code to attach an inode to a
-	 * handle.  These are protected by ip_io_sem in order to lock
+	 * handle.  These are protected by ip_io_mutex in order to lock
 	 * out other I/O to the inode until we either commit or
 	 * abort. */
 	struct list_head		ip_handle_list;
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 303c8d9..fa0bcac 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -147,8 +147,7 @@ struct ocfs2_journal_handle *ocfs2_start
 
 	mlog_entry("(max_buffs = %d)\n", max_buffs);
 
-	if (!osb || !osb->journal->j_journal)
-		BUG();
+	BUG_ON(!osb || !osb->journal->j_journal);
 
 	if (ocfs2_is_hard_readonly(osb)) {
 		ret = -EROFS;
@@ -401,7 +400,7 @@ int ocfs2_journal_access(struct ocfs2_jo
 	 * j_trans_barrier for us. */
 	ocfs2_set_inode_lock_trans(OCFS2_SB(inode->i_sb)->journal, inode);
 
-	down(&OCFS2_I(inode)->ip_io_sem);
+	mutex_lock(&OCFS2_I(inode)->ip_io_mutex);
 	switch (type) {
 	case OCFS2_JOURNAL_ACCESS_CREATE:
 	case OCFS2_JOURNAL_ACCESS_WRITE:
@@ -416,7 +415,7 @@ int ocfs2_journal_access(struct ocfs2_jo
 		status = -EINVAL;
 		mlog(ML_ERROR, "Uknown access type!\n");
 	}
-	up(&OCFS2_I(inode)->ip_io_sem);
+	mutex_unlock(&OCFS2_I(inode)->ip_io_mutex);
 
 	if (status < 0)
 		mlog(ML_ERROR, "Error %d getting %d access to buffer!\n",
@@ -561,7 +560,11 @@ int ocfs2_journal_init(struct ocfs2_jour
 	SET_INODE_JOURNAL(inode);
 	OCFS2_I(inode)->ip_open_count++;
 
-	status = ocfs2_meta_lock(inode, NULL, &bh, 1);
+	/* Skip recovery waits here - journal inode metadata never
+	 * changes in a live cluster so it can be considered an
+	 * exception to the rule. */
+	status = ocfs2_meta_lock_full(inode, NULL, &bh, 1,
+				      OCFS2_META_LOCK_RECOVERY);
 	if (status < 0) {
 		if (status != -ERESTARTSYS)
 			mlog(ML_ERROR, "Could not get lock on journal!\n");
@@ -672,8 +675,7 @@ void ocfs2_journal_shutdown(struct ocfs2
 
 	mlog_entry_void();
 
-	if (!osb)
-		BUG();
+	BUG_ON(!osb);
 
 	journal = osb->journal;
 	if (!journal)
@@ -805,8 +807,7 @@ int ocfs2_journal_wipe(struct ocfs2_jour
 
 	mlog_entry_void();
 
-	if (!journal)
-		BUG();
+	BUG_ON(!journal);
 
 	status = journal_wipe(journal->j_journal, full);
 	if (status < 0) {
@@ -1072,10 +1073,10 @@ restart:
 					NULL);
 
 bail:
-	down(&osb->recovery_lock);
+	mutex_lock(&osb->recovery_lock);
 	if (!status &&
 	    !ocfs2_node_map_is_empty(osb, &osb->recovery_map)) {
-		up(&osb->recovery_lock);
+		mutex_unlock(&osb->recovery_lock);
 		goto restart;
 	}
 
@@ -1083,7 +1084,7 @@ bail:
 	mb(); /* sync with ocfs2_recovery_thread_running */
 	wake_up(&osb->recovery_event);
 
-	up(&osb->recovery_lock);
+	mutex_unlock(&osb->recovery_lock);
 
 	mlog_exit(status);
 	/* no one is callint kthread_stop() for us so the kthread() api
@@ -1098,7 +1099,7 @@ void ocfs2_recovery_thread(struct ocfs2_
 	mlog_entry("(node_num=%d, osb->node_num = %d)\n",
 		   node_num, osb->node_num);
 
-	down(&osb->recovery_lock);
+	mutex_lock(&osb->recovery_lock);
 	if (osb->disable_recovery)
 		goto out;
 
@@ -1120,7 +1121,7 @@ void ocfs2_recovery_thread(struct ocfs2_
 	}
 
 out:
-	up(&osb->recovery_lock);
+	mutex_unlock(&osb->recovery_lock);
 	wake_up(&osb->recovery_event);
 
 	mlog_exit_void();
@@ -1271,8 +1272,7 @@ static int ocfs2_recover_node(struct ocf
 
 	/* Should not ever be called to recover ourselves -- in that
 	 * case we should've called ocfs2_journal_load instead. */
-	if (osb->node_num == node_num)
-		BUG();
+	BUG_ON(osb->node_num == node_num);
 
 	slot_num = ocfs2_node_num_to_slot(si, node_num);
 	if (slot_num == OCFS2_INVALID_SLOT) {
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index f468c60..8d8e477 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -33,6 +33,7 @@
 #include <linux/rbtree.h>
 #include <linux/workqueue.h>
 #include <linux/kref.h>
+#include <linux/mutex.h>
 
 #include "cluster/nodemanager.h"
 #include "cluster/heartbeat.h"
@@ -233,7 +234,7 @@ struct ocfs2_super
 	struct proc_dir_entry *proc_sub_dir; /* points to /proc/fs/ocfs2/<maj_min> */
 
 	atomic_t vol_state;
-	struct semaphore recovery_lock;
+	struct mutex recovery_lock;
 	struct task_struct *recovery_thread_task;
 	int disable_recovery;
 	wait_queue_head_t checkpoint_event;
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 364d64b..046824b 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -932,7 +932,7 @@ static void ocfs2_inode_init_once(void *
 		oi->ip_dir_start_lookup = 0;
 
 		init_rwsem(&oi->ip_alloc_sem);
-		init_MUTEX(&(oi->ip_io_sem));
+		mutex_init(&oi->ip_io_mutex);
 
 		oi->ip_blkno = 0ULL;
 		oi->ip_clusters = 0;
@@ -1137,9 +1137,9 @@ static void ocfs2_dismount_volume(struct
 
 	/* disable any new recovery threads and wait for any currently
 	 * running ones to exit. Do this before setting the vol_state. */
-	down(&osb->recovery_lock);
+	mutex_lock(&osb->recovery_lock);
 	osb->disable_recovery = 1;
-	up(&osb->recovery_lock);
+	mutex_unlock(&osb->recovery_lock);
 	wait_event(osb->recovery_event, !ocfs2_recovery_thread_running(osb));
 
 	/* At this point, we know that no more recovery threads can be
@@ -1254,8 +1254,7 @@ static int ocfs2_initialize_super(struct
 	osb->sb = sb;
 	/* Save off for ocfs2_rw_direct */
 	osb->s_sectsize_bits = blksize_bits(sector_size);
-	if (!osb->s_sectsize_bits)
-		BUG();
+	BUG_ON(!osb->s_sectsize_bits);
 
 	osb->net_response_ids = 0;
 	spin_lock_init(&osb->net_response_lock);
@@ -1283,7 +1282,7 @@ static int ocfs2_initialize_super(struct
 	snprintf(osb->dev_str, sizeof(osb->dev_str), "%u,%u",
 		 MAJOR(osb->sb->s_dev), MINOR(osb->sb->s_dev));
 
-	init_MUTEX(&osb->recovery_lock);
+	mutex_init(&osb->recovery_lock);
 
 	osb->disable_recovery = 0;
 	osb->recovery_thread_task = NULL;
diff --git a/fs/ocfs2/sysfile.c b/fs/ocfs2/sysfile.c
index 600a8bc..fc29cb7 100644
--- a/fs/ocfs2/sysfile.c
+++ b/fs/ocfs2/sysfile.c
@@ -77,8 +77,7 @@ struct inode *ocfs2_get_system_file_inod
 	if (arr && ((inode = *arr) != NULL)) {
 		/* get a ref in addition to the array ref */
 		inode = igrab(inode);
-		if (!inode)
-			BUG();
+		BUG_ON(!inode);
 
 		return inode;
 	}
@@ -89,8 +88,7 @@ struct inode *ocfs2_get_system_file_inod
 	/* add one more if putting into array for first time */
 	if (arr && inode) {
 		*arr = igrab(inode);
-		if (!*arr)
-			BUG();
+		BUG_ON(!*arr);
 	}
 	return inode;
 }
diff --git a/fs/ocfs2/uptodate.c b/fs/ocfs2/uptodate.c
index 3a0458f..300b5be 100644
--- a/fs/ocfs2/uptodate.c
+++ b/fs/ocfs2/uptodate.c
@@ -388,7 +388,7 @@ out_free:
 	}
 }
 
-/* Item insertion is guarded by ip_io_sem, so the insertion path takes
+/* Item insertion is guarded by ip_io_mutex, so the insertion path takes
  * advantage of this by not rechecking for a duplicate insert during
  * the slow case. Additionally, if the cache needs to be bumped up to
  * a tree, the code will not recheck after acquiring the lock --
@@ -418,7 +418,7 @@ void ocfs2_set_buffer_uptodate(struct in
 	     (unsigned long long) bh->b_blocknr);
 
 	/* No need to recheck under spinlock - insertion is guarded by
-	 * ip_io_sem */
+	 * ip_io_mutex */
 	spin_lock(&oi->ip_lock);
 	if (ocfs2_insert_can_use_array(oi, ci)) {
 		/* Fast case - it's an array and there's a free
@@ -440,7 +440,7 @@ void ocfs2_set_buffer_uptodate(struct in
 
 /* Called against a newly allocated buffer. Most likely nobody should
  * be able to read this sort of metadata while it's still being
- * allocated, but this is careful to take ip_io_sem anyway. */
+ * allocated, but this is careful to take ip_io_mutex anyway. */
 void ocfs2_set_new_buffer_uptodate(struct inode *inode,
 				   struct buffer_head *bh)
 {
@@ -451,9 +451,9 @@ void ocfs2_set_new_buffer_uptodate(struc
 
 	set_buffer_uptodate(bh);
 
-	down(&oi->ip_io_sem);
+	mutex_lock(&oi->ip_io_mutex);
 	ocfs2_set_buffer_uptodate(inode, bh);
-	up(&oi->ip_io_sem);
+	mutex_unlock(&oi->ip_io_mutex);
 }
 
 /* Requires ip_lock. */
@@ -537,7 +537,7 @@ int __init init_ocfs2_uptodate_cache(voi
 	return 0;
 }
 
-void __exit exit_ocfs2_uptodate_cache(void)
+void exit_ocfs2_uptodate_cache(void)
 {
 	if (ocfs2_uptodate_cachep)
 		kmem_cache_destroy(ocfs2_uptodate_cachep);
diff --git a/fs/ocfs2/uptodate.h b/fs/ocfs2/uptodate.h
index e5aacdf..01cd32d 100644
--- a/fs/ocfs2/uptodate.h
+++ b/fs/ocfs2/uptodate.h
@@ -27,7 +27,7 @@
 #define OCFS2_UPTODATE_H
 
 int __init init_ocfs2_uptodate_cache(void);
-void __exit exit_ocfs2_uptodate_cache(void);
+void exit_ocfs2_uptodate_cache(void);
 
 void ocfs2_metadata_cache_init(struct inode *inode);
 void ocfs2_metadata_cache_purge(struct inode *inode);
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index acffb8c..a7f0150 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -126,7 +126,7 @@ extern struct config_item *config_group_
 
 
 struct configfs_attribute {
-	char			*ca_name;
+	const char		*ca_name;
 	struct module 		*ca_owner;
 	mode_t			ca_mode;
 };
