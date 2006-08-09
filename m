Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWHIQ56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWHIQ56 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWHIQ5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:57:42 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:45698 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751012AbWHIQ5f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:57:35 -0400
Subject: [PATCH 4/6] r/o bind mount prepwork: inc_nlink() helper
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 09 Aug 2006 09:57:32 -0700
References: <20060809165729.FE36B262@localhost.localdomain>
In-Reply-To: <20060809165729.FE36B262@localhost.localdomain>
Message-Id: <20060809165732.F7BDE416@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is mostly included for parity with dec_nlink(), where
we will have some more hooks.  This one should stay pretty
darn straightforward for now.


Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/drivers/infiniband/hw/ipath/ipath_fs.c |    4 ++--
 lxc-dave/drivers/usb/core/inode.c               |    4 ++--
 lxc-dave/fs/9p/vfs_inode.c                      |    2 +-
 lxc-dave/fs/autofs/root.c                       |    2 +-
 lxc-dave/fs/autofs4/root.c                      |    2 +-
 lxc-dave/fs/bfs/dir.c                           |    2 +-
 lxc-dave/fs/cifs/inode.c                        |    2 +-
 lxc-dave/fs/coda/dir.c                          |    2 +-
 lxc-dave/fs/configfs/dir.c                      |    4 ++--
 lxc-dave/fs/configfs/mount.c                    |    2 +-
 lxc-dave/fs/debugfs/inode.c                     |    4 ++--
 lxc-dave/fs/ext3/namei.c                        |    6 +++---
 lxc-dave/fs/fuse/control.c                      |    2 +-
 lxc-dave/fs/hfsplus/dir.c                       |    2 +-
 lxc-dave/fs/hpfs/namei.c                        |    4 ++--
 lxc-dave/fs/hugetlbfs/inode.c                   |    4 ++--
 lxc-dave/fs/jffs2/dir.c                         |    6 +++---
 lxc-dave/fs/jffs2/fs.c                          |    6 +++---
 lxc-dave/fs/jfs/namei.c                         |    6 +++---
 lxc-dave/fs/libfs.c                             |    4 ++--
 lxc-dave/fs/msdos/namei.c                       |    4 ++--
 lxc-dave/fs/ocfs2/dlm/dlmfs.c                   |    6 +++---
 lxc-dave/fs/ocfs2/namei.c                       |    8 ++++----
 lxc-dave/fs/ramfs/inode.c                       |    4 ++--
 lxc-dave/fs/reiserfs/namei.c                    |    6 +++---
 lxc-dave/fs/sysfs/dir.c                         |    4 ++--
 lxc-dave/fs/sysfs/mount.c                       |    2 +-
 lxc-dave/fs/udf/inode.c                         |    2 +-
 lxc-dave/fs/udf/namei.c                         |    6 +++---
 lxc-dave/fs/vfat/namei.c                        |    4 ++--
 lxc-dave/include/linux/fs.h                     |    7 ++++++-
 lxc-dave/ipc/mqueue.c                           |    2 +-
 lxc-dave/kernel/cpuset.c                        |    8 ++++----
 lxc-dave/mm/shmem.c                             |    8 ++++----
 lxc-dave/net/sunrpc/rpc_pipe.c                  |    6 +++---
 lxc-dave/security/inode.c                       |    4 ++--
 lxc-dave/security/selinux/selinuxfs.c           |    4 ++--
 37 files changed, 80 insertions(+), 75 deletions(-)

diff -puN include/linux/fs.h~B4-monitor_inc_nlink include/linux/fs.h
--- lxc/include/linux/fs.h~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/include/linux/fs.h	2006-08-08 10:57:59.000000000 -0700
@@ -1256,9 +1256,14 @@ static inline void mark_inode_dirty_sync
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
-static inline void inode_inc_link_count(struct inode *inode)
+static inline void inc_nlink(struct inode *inode)
 {
 	inode->i_nlink++;
+}
+
+static inline void inode_inc_link_count(struct inode *inode)
+{
+	inc_nlink(inode);
 	mark_inode_dirty(inode);
 }
 
diff -puN fs/libfs.c~B4-monitor_inc_nlink fs/libfs.c
--- lxc/fs/libfs.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/libfs.c	2006-08-08 10:57:59.000000000 -0700
@@ -243,7 +243,7 @@ int simple_link(struct dentry *old_dentr
 	struct inode *inode = old_dentry->d_inode;
 
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
-	inode->i_nlink++;
+	inc_nlink(inode);
 	atomic_inc(&inode->i_count);
 	dget(dentry);
 	d_instantiate(dentry, inode);
@@ -306,7 +306,7 @@ int simple_rename(struct inode *old_dir,
 			drop_nlink(old_dir);
 	} else if (they_are_dirs) {
 		drop_nlink(old_dir);
-		new_dir->i_nlink++;
+		inc_nlink(new_dir);
 	}
 
 	old_dir->i_ctime = old_dir->i_mtime = new_dir->i_ctime =
diff -puN mm/shmem.c~B4-monitor_inc_nlink mm/shmem.c
--- lxc/mm/shmem.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/mm/shmem.c	2006-08-08 10:57:59.000000000 -0700
@@ -1371,7 +1371,7 @@ shmem_get_inode(struct super_block *sb, 
 							&sbinfo->policy_nodes);
 			break;
 		case S_IFDIR:
-			inode->i_nlink++;
+			inc_nlink(inode);
 			/* Some things misbehave if size == 0 on a directory */
 			inode->i_size = 2 * BOGO_DIRENT_SIZE;
 			inode->i_op = &shmem_dir_inode_operations;
@@ -1703,7 +1703,7 @@ static int shmem_mkdir(struct inode *dir
 
 	if ((error = shmem_mknod(dir, dentry, mode | S_IFDIR, 0)))
 		return error;
-	dir->i_nlink++;
+	inc_nlink(dir);
 	return 0;
 }
 
@@ -1738,7 +1738,7 @@ static int shmem_link(struct dentry *old
 
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
-	inode->i_nlink++;
+	inc_nlink(inode);
 	atomic_inc(&inode->i_count);	/* New dentry reference */
 	dget(dentry);		/* Extra pinning count for the created dentry */
 	d_instantiate(dentry, inode);
@@ -1795,7 +1795,7 @@ static int shmem_rename(struct inode *ol
 			drop_nlink(old_dir);
 	} else if (they_are_dirs) {
 		drop_nlink(old_dir);
-		new_dir->i_nlink++;
+		inc_nlink(new_dir);
 	}
 
 	old_dir->i_size -= BOGO_DIRENT_SIZE;
diff -puN drivers/infiniband/hw/ipath/ipath_fs.c~B4-monitor_inc_nlink drivers/infiniband/hw/ipath/ipath_fs.c
--- lxc/drivers/infiniband/hw/ipath/ipath_fs.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/drivers/infiniband/hw/ipath/ipath_fs.c	2006-08-08 10:57:59.000000000 -0700
@@ -66,8 +66,8 @@ static int ipathfs_mknod(struct inode *d
 	inode->i_private = data;
 	if ((mode & S_IFMT) == S_IFDIR) {
 		inode->i_op = &simple_dir_inode_operations;
-		inode->i_nlink++;
-		dir->i_nlink++;
+		inc_nlink(inode);
+		inc_nlink(dir);
 	}
 
 	inode->i_fop = fops;
diff -puN drivers/usb/core/inode.c~B4-monitor_inc_nlink drivers/usb/core/inode.c
--- lxc/drivers/usb/core/inode.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/drivers/usb/core/inode.c	2006-08-08 10:57:59.000000000 -0700
@@ -263,7 +263,7 @@ static struct inode *usbfs_get_inode (st
 			inode->i_fop = &simple_dir_operations;
 
 			/* directory inodes start off with i_nlink == 2 (for "." entry) */
-			inode->i_nlink++;
+			inc_nlink(inode);
 			break;
 		}
 	}
@@ -295,7 +295,7 @@ static int usbfs_mkdir (struct inode *di
 	mode = (mode & (S_IRWXUGO | S_ISVTX)) | S_IFDIR;
 	res = usbfs_mknod (dir, dentry, mode, 0);
 	if (!res)
-		dir->i_nlink++;
+		inc_nlink(dir);
 	return res;
 }
 
diff -puN fs/9p/vfs_inode.c~B4-monitor_inc_nlink fs/9p/vfs_inode.c
--- lxc/fs/9p/vfs_inode.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/fs/9p/vfs_inode.c	2006-08-08 10:57:59.000000000 -0700
@@ -233,7 +233,7 @@ struct inode *v9fs_get_inode(struct supe
 			inode->i_op = &v9fs_symlink_inode_operations;
 			break;
 		case S_IFDIR:
-			inode->i_nlink++;
+			inc_nlink(inode);
 			if(v9ses->extended)
 				inode->i_op = &v9fs_dir_inode_operations_ext;
 			else
diff -puN fs/autofs/root.c~B4-monitor_inc_nlink fs/autofs/root.c
--- lxc/fs/autofs/root.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/autofs/root.c	2006-08-08 10:57:59.000000000 -0700
@@ -466,7 +466,7 @@ static int autofs_root_mkdir(struct inod
 	ent->dentry = dentry;
 	autofs_hash_insert(dh,ent);
 
-	dir->i_nlink++;
+	inc_nlink(dir);
 	d_instantiate(dentry, iget(dir->i_sb,ino));
 	unlock_kernel();
 
diff -puN fs/autofs4/root.c~B4-monitor_inc_nlink fs/autofs4/root.c
--- lxc/fs/autofs4/root.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/autofs4/root.c	2006-08-08 10:57:59.000000000 -0700
@@ -713,7 +713,7 @@ static int autofs4_dir_mkdir(struct inod
 	if (p_ino && dentry->d_parent != dentry)
 		atomic_inc(&p_ino->count);
 	ino->inode = inode;
-	dir->i_nlink++;
+	inc_nlink(dir);
 	dir->i_mtime = CURRENT_TIME;
 
 	return 0;
diff -puN fs/bfs/dir.c~B4-monitor_inc_nlink fs/bfs/dir.c
--- lxc/fs/bfs/dir.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/bfs/dir.c	2006-08-08 10:57:59.000000000 -0700
@@ -163,7 +163,7 @@ static int bfs_link(struct dentry * old,
 		unlock_kernel();
 		return err;
 	}
-	inode->i_nlink++;
+	inc_nlink(inode);
 	inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 	atomic_inc(&inode->i_count);
diff -puN fs/cifs/inode.c~B4-monitor_inc_nlink fs/cifs/inode.c
--- lxc/fs/cifs/inode.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/cifs/inode.c	2006-08-08 10:57:59.000000000 -0700
@@ -736,7 +736,7 @@ int cifs_mkdir(struct inode *inode, stru
 		cFYI(1, ("cifs_mkdir returned 0x%x", rc));
 		d_drop(direntry);
 	} else {
-		inode->i_nlink++;
+		inc_nlink(inode);
 		if (pTcon->ses->capabilities & CAP_UNIX)
 			rc = cifs_get_inode_info_unix(&newinode, full_path,
 						      inode->i_sb,xid);
diff -puN fs/coda/dir.c~B4-monitor_inc_nlink fs/coda/dir.c
--- lxc/fs/coda/dir.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/coda/dir.c	2006-08-08 10:57:59.000000000 -0700
@@ -304,7 +304,7 @@ static int coda_link(struct dentry *sour
 	coda_dir_changed(dir_inode, 0);
 	atomic_inc(&inode->i_count);
 	d_instantiate(de, inode);
-	inode->i_nlink++;
+	inc_nlink(inode);
         
 out:
 	unlock_kernel();
diff -puN fs/configfs/dir.c~B4-monitor_inc_nlink fs/configfs/dir.c
--- lxc/fs/configfs/dir.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/fs/configfs/dir.c	2006-08-08 10:57:59.000000000 -0700
@@ -113,7 +113,7 @@ static int init_dir(struct inode * inode
 	inode->i_fop = &configfs_dir_operations;
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
-	inode->i_nlink++;
+	inc_nlink(inode);
 	return 0;
 }
 
@@ -141,7 +141,7 @@ static int create_dir(struct config_item
 	if (!error) {
 		error = configfs_create(d, mode, init_dir);
 		if (!error) {
-			p->d_inode->i_nlink++;
+			inc_nlink(p->d_inode);
 			(d)->d_op = &configfs_dentry_ops;
 		} else {
 			struct configfs_dirent *sd = d->d_fsdata;
diff -puN fs/configfs/mount.c~B4-monitor_inc_nlink fs/configfs/mount.c
--- lxc/fs/configfs/mount.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/fs/configfs/mount.c	2006-08-08 10:57:59.000000000 -0700
@@ -84,7 +84,7 @@ static int configfs_fill_super(struct su
 		inode->i_op = &configfs_dir_inode_operations;
 		inode->i_fop = &configfs_dir_operations;
 		/* directory inodes start off with i_nlink == 2 (for "." entry) */
-		inode->i_nlink++;
+		inc_nlink(inode);
 	} else {
 		pr_debug("configfs: could not get root inode\n");
 		return -ENOMEM;
diff -puN fs/debugfs/inode.c~B4-monitor_inc_nlink fs/debugfs/inode.c
--- lxc/fs/debugfs/inode.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/fs/debugfs/inode.c	2006-08-08 10:57:59.000000000 -0700
@@ -54,7 +54,7 @@ static struct inode *debugfs_get_inode(s
 			inode->i_fop = &simple_dir_operations;
 
 			/* directory inodes start off with i_nlink == 2 (for "." entry) */
-			inode->i_nlink++;
+			inc_nlink(inode);
 			break;
 		}
 	}
@@ -87,7 +87,7 @@ static int debugfs_mkdir(struct inode *d
 	mode = (mode & (S_IRWXUGO | S_ISVTX)) | S_IFDIR;
 	res = debugfs_mknod(dir, dentry, mode, 0);
 	if (!res)
-		dir->i_nlink++;
+		inc_nlink(dir);
 	return res;
 }
 
diff -puN fs/ext3/namei.c~B4-monitor_inc_nlink fs/ext3/namei.c
--- lxc/fs/ext3/namei.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/ext3/namei.c	2006-08-08 10:57:59.000000000 -0700
@@ -1616,7 +1616,7 @@ static int ext3_delete_entry (handle_t *
  */
 static inline void ext3_inc_count(handle_t *handle, struct inode *inode)
 {
-	inode->i_nlink++;
+	inc_nlink(inode);
 }
 
 static inline void ext3_dec_count(handle_t *handle, struct inode *inode)
@@ -1775,7 +1775,7 @@ retry:
 		iput (inode);
 		goto out_stop;
 	}
-	dir->i_nlink++;
+	inc_nlink(dir);
 	ext3_update_dx_flag(dir);
 	ext3_mark_inode_dirty(handle, dir);
 	d_instantiate(dentry, inode);
@@ -2341,7 +2341,7 @@ static int ext3_rename (struct inode * o
 		if (new_inode) {
 			drop_nlink(new_inode);
 		} else {
-			new_dir->i_nlink++;
+			inc_nlink(new_dir);
 			ext3_update_dx_flag(new_dir);
 			ext3_mark_inode_dirty(handle, new_dir);
 		}
diff -puN fs/fuse/control.c~B4-monitor_inc_nlink fs/fuse/control.c
--- lxc/fs/fuse/control.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/fs/fuse/control.c	2006-08-08 10:57:59.000000000 -0700
@@ -116,7 +116,7 @@ int fuse_ctl_add_conn(struct fuse_conn *
 		return 0;
 
 	parent = fuse_control_sb->s_root;
-	parent->d_inode->i_nlink++;
+	inc_nlink(parent->d_inode);
 	sprintf(name, "%llu", (unsigned long long) fc->id);
 	parent = fuse_ctl_add_dentry(parent, fc, name, S_IFDIR | 0500, 2,
 				     &simple_dir_inode_operations,
diff -puN fs/hfsplus/dir.c~B4-monitor_inc_nlink fs/hfsplus/dir.c
--- lxc/fs/hfsplus/dir.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/hfsplus/dir.c	2006-08-08 10:57:59.000000000 -0700
@@ -298,7 +298,7 @@ static int hfsplus_link(struct dentry *s
 	if (res)
 		return res;
 
-	inode->i_nlink++;
+	inc_nlink(inode);
 	hfsplus_instantiate(dst_dentry, inode, cnid);
 	atomic_inc(&inode->i_count);
 	inode->i_ctime = CURRENT_TIME_SEC;
diff -puN fs/hpfs/namei.c~B4-monitor_inc_nlink fs/hpfs/namei.c
--- lxc/fs/hpfs/namei.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/hpfs/namei.c	2006-08-08 10:57:59.000000000 -0700
@@ -89,7 +89,7 @@ static int hpfs_mkdir(struct inode *dir,
 	brelse(bh);
 	hpfs_mark_4buffers_dirty(&qbh0);
 	hpfs_brelse4(&qbh0);
-	dir->i_nlink++;
+	inc_nlink(dir);
 	insert_inode_hash(result);
 
 	if (result->i_uid != current->fsuid ||
@@ -635,7 +635,7 @@ static int hpfs_rename(struct inode *old
 	end:
 	hpfs_i(i)->i_parent_dir = new_dir->i_ino;
 	if (S_ISDIR(i->i_mode)) {
-		new_dir->i_nlink++;
+		inc_nlink(new_dir);
 		drop_nlink(old_dir);
 	}
 	if ((fnode = hpfs_map_fnode(i->i_sb, i->i_ino, &bh))) {
diff -puN fs/hugetlbfs/inode.c~B4-monitor_inc_nlink fs/hugetlbfs/inode.c
--- lxc/fs/hugetlbfs/inode.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/fs/hugetlbfs/inode.c	2006-08-08 10:57:59.000000000 -0700
@@ -377,7 +377,7 @@ static struct inode *hugetlbfs_get_inode
 			inode->i_fop = &simple_dir_operations;
 
 			/* directory inodes start off with i_nlink == 2 (for "." entry) */
-			inode->i_nlink++;
+			inc_nlink(inode);
 			break;
 		case S_IFLNK:
 			inode->i_op = &page_symlink_inode_operations;
@@ -418,7 +418,7 @@ static int hugetlbfs_mkdir(struct inode 
 {
 	int retval = hugetlbfs_mknod(dir, dentry, mode | S_IFDIR, 0);
 	if (!retval)
-		dir->i_nlink++;
+		inc_nlink(dir);
 	return retval;
 }
 
diff -puN fs/jffs2/dir.c~B4-monitor_inc_nlink fs/jffs2/dir.c
--- lxc/fs/jffs2/dir.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/jffs2/dir.c	2006-08-08 10:57:59.000000000 -0700
@@ -588,7 +588,7 @@ static int jffs2_mkdir (struct inode *di
 	}
 
 	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
-	dir_i->i_nlink++;
+	inc_nlink(dir_i);
 
 	jffs2_free_raw_dirent(rd);
 
@@ -836,7 +836,7 @@ static int jffs2_rename (struct inode *o
 	/* If it was a directory we moved, and there was no victim,
 	   increase i_nlink on its new parent */
 	if (S_ISDIR(old_dentry->d_inode->i_mode) && !victim_f)
-		new_dir_i->i_nlink++;
+		inc_nlink(new_dir_i);
 
 	/* Unlink the original */
 	ret = jffs2_do_unlink(c, JFFS2_INODE_INFO(old_dir_i),
@@ -848,7 +848,7 @@ static int jffs2_rename (struct inode *o
 		/* Oh shit. We really ought to make a single node which can do both atomically */
 		struct jffs2_inode_info *f = JFFS2_INODE_INFO(old_dentry->d_inode);
 		down(&f->sem);
-		old_dentry->d_inode->i_nlink++;
+		inc_nlink(old_dentry->d_inode);
 		if (f->inocache)
 			f->inocache->nlink++;
 		up(&f->sem);
diff -puN fs/jffs2/fs.c~B4-monitor_inc_nlink fs/jffs2/fs.c
--- lxc/fs/jffs2/fs.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/fs/jffs2/fs.c	2006-08-08 10:57:59.000000000 -0700
@@ -277,13 +277,13 @@ void jffs2_read_inode (struct inode *ino
 
 		for (fd=f->dents; fd; fd = fd->next) {
 			if (fd->type == DT_DIR && fd->ino)
-				inode->i_nlink++;
+				inc_nlink(inode);
 		}
 		/* and '..' */
-		inode->i_nlink++;
+		inc_nlink(inode);
 		/* Root dir gets i_nlink 3 for some reason */
 		if (inode->i_ino == 1)
-			inode->i_nlink++;
+			inc_nlink(inode);
 
 		inode->i_op = &jffs2_dir_inode_operations;
 		inode->i_fop = &jffs2_dir_operations;
diff -puN fs/jfs/namei.c~B4-monitor_inc_nlink fs/jfs/namei.c
--- lxc/fs/jfs/namei.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/jfs/namei.c	2006-08-08 10:57:59.000000000 -0700
@@ -292,7 +292,7 @@ static int jfs_mkdir(struct inode *dip, 
 	mark_inode_dirty(ip);
 
 	/* update parent directory inode */
-	dip->i_nlink++;		/* for '..' from child directory */
+	inc_nlink(dip);		/* for '..' from child directory */
 	dip->i_ctime = dip->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(dip);
 
@@ -822,7 +822,7 @@ static int jfs_link(struct dentry *old_d
 		goto free_dname;
 
 	/* update object inode */
-	ip->i_nlink++;		/* for new link */
+	inc_nlink(ip);		/* for new link */
 	ip->i_ctime = CURRENT_TIME;
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(dir);
@@ -1206,7 +1206,7 @@ static int jfs_rename(struct inode *old_
 			goto out4;
 		}
 		if (S_ISDIR(old_ip->i_mode))
-			new_dir->i_nlink++;
+			inc_nlink(new_dir);
 	}
 	/*
 	 * Remove old directory entry
diff -puN fs/msdos/namei.c~B4-monitor_inc_nlink fs/msdos/namei.c
--- lxc/fs/msdos/namei.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/msdos/namei.c	2006-08-08 10:57:59.000000000 -0700
@@ -385,7 +385,7 @@ static int msdos_mkdir(struct inode *dir
 	err = msdos_add_entry(dir, msdos_name, 1, is_hid, cluster, &ts, &sinfo);
 	if (err)
 		goto out_free;
-	dir->i_nlink++;
+	inc_nlink(dir);
 
 	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
 	brelse(sinfo.bh);
@@ -544,7 +544,7 @@ static int do_msdos_rename(struct inode 
 		}
 		drop_nlink(old_dir);
 		if (!new_inode)
-			new_dir->i_nlink++;
+			inc_nlink(new_dir);
 	}
 
 	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
diff -puN fs/ocfs2/dlm/dlmfs.c~B4-monitor_inc_nlink fs/ocfs2/dlm/dlmfs.c
--- lxc/fs/ocfs2/dlm/dlmfs.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/fs/ocfs2/dlm/dlmfs.c	2006-08-08 10:57:59.000000000 -0700
@@ -338,7 +338,7 @@ static struct inode *dlmfs_get_root_inod
 		inode->i_blocks = 0;
 		inode->i_mapping->backing_dev_info = &dlmfs_backing_dev_info;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-		inode->i_nlink++;
+		inc_nlink(inode);
 
 		inode->i_fop = &simple_dir_operations;
 		inode->i_op = &dlmfs_root_inode_operations;
@@ -395,7 +395,7 @@ static struct inode *dlmfs_get_inode(str
 
 		/* directory inodes start off with i_nlink ==
 		 * 2 (for "." entry) */
-		inode->i_nlink++;
+		inc_nlink(inode);
 		break;
 	}
 
@@ -449,7 +449,7 @@ static int dlmfs_mkdir(struct inode * di
 	}
 	ip->ip_dlm = dlm;
 
-	dir->i_nlink++;
+	inc_nlink(dir);
 	d_instantiate(dentry, inode);
 	dget(dentry);	/* Extra count - pin the dentry in core */
 
diff -puN fs/ocfs2/namei.c~B4-monitor_inc_nlink fs/ocfs2/namei.c
--- lxc/fs/ocfs2/namei.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/ocfs2/namei.c	2006-08-08 10:57:59.000000000 -0700
@@ -408,7 +408,7 @@ static int ocfs2_mknod(struct inode *dir
 			mlog_errno(status);
 			goto leave;
 		}
-		dir->i_nlink++;
+		inc_nlink(dir);
 	}
 
 	status = ocfs2_add_entry(handle, dentry, inode,
@@ -702,7 +702,7 @@ static int ocfs2_link(struct dentry *old
 		goto bail;
 	}
 
-	inode->i_nlink++;
+	inc_nlink(inode);
 	inode->i_ctime = CURRENT_TIME;
 	fe->i_links_count = cpu_to_le16(inode->i_nlink);
 	fe->i_ctime = cpu_to_le64(inode->i_ctime.tv_sec);
@@ -902,7 +902,7 @@ static int ocfs2_unlink(struct inode *di
 						parent_node_bh);
 		if (status < 0) {
 			mlog_errno(status);
-			dir->i_nlink++;
+			inc_nlink(dir);
 		}
 	}
 
@@ -1344,7 +1344,7 @@ static int ocfs2_rename(struct inode *ol
 		if (new_inode) {
 			new_inode->i_nlink--;
 		} else {
-			new_dir->i_nlink++;
+			inc_nlink(new_dir);
 			mark_inode_dirty(new_dir);
 		}
 	}
diff -puN fs/ramfs/inode.c~B4-monitor_inc_nlink fs/ramfs/inode.c
--- lxc/fs/ramfs/inode.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/fs/ramfs/inode.c	2006-08-08 10:57:59.000000000 -0700
@@ -75,7 +75,7 @@ struct inode *ramfs_get_inode(struct sup
 			inode->i_fop = &simple_dir_operations;
 
 			/* directory inodes start off with i_nlink == 2 (for "." entry) */
-			inode->i_nlink++;
+			inc_nlink(inode);
 			break;
 		case S_IFLNK:
 			inode->i_op = &page_symlink_inode_operations;
@@ -113,7 +113,7 @@ static int ramfs_mkdir(struct inode * di
 {
 	int retval = ramfs_mknod(dir, dentry, mode | S_IFDIR, 0);
 	if (!retval)
-		dir->i_nlink++;
+		inc_nlink(dir);
 	return retval;
 }
 
diff -puN fs/reiserfs/namei.c~B4-monitor_inc_nlink fs/reiserfs/namei.c
--- lxc/fs/reiserfs/namei.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/reiserfs/namei.c	2006-08-08 10:57:59.000000000 -0700
@@ -19,7 +19,7 @@
 #include <linux/smp_lock.h>
 #include <linux/quotaops.h>
 
-#define INC_DIR_INODE_NLINK(i) if (i->i_nlink != 1) { i->i_nlink++; if (i->i_nlink >= REISERFS_LINK_MAX) i->i_nlink=1; }
+#define INC_DIR_INODE_NLINK(i) if (i->i_nlink != 1) { inc_nlink(i); if (i->i_nlink >= REISERFS_LINK_MAX) i->i_nlink=1; }
 #define DEC_DIR_INODE_NLINK(i) if (i->i_nlink != 1) drop_nlink(i);
 
 // directory item contains array of entry headers. This performs
@@ -1006,7 +1006,7 @@ static int reiserfs_unlink(struct inode 
 	    reiserfs_cut_from_item(&th, &path, &(de.de_entry_key), dir, NULL,
 				   0);
 	if (retval < 0) {
-		inode->i_nlink++;
+		inc_nlink(inode);
 		goto end_unlink;
 	}
 	inode->i_ctime = CURRENT_TIME_SEC;
@@ -1143,7 +1143,7 @@ static int reiserfs_link(struct dentry *
 	}
 
 	/* inc before scheduling so reiserfs_unlink knows we are here */
-	inode->i_nlink++;
+	inc_nlink(inode);
 
 	retval = journal_begin(&th, dir->i_sb, jbegin_count);
 	if (retval) {
diff -puN fs/sysfs/dir.c~B4-monitor_inc_nlink fs/sysfs/dir.c
--- lxc/fs/sysfs/dir.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/fs/sysfs/dir.c	2006-08-08 10:57:59.000000000 -0700
@@ -103,7 +103,7 @@ static int init_dir(struct inode * inode
 	inode->i_fop = &sysfs_dir_operations;
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
-	inode->i_nlink++;
+	inc_nlink(inode);
 	return 0;
 }
 
@@ -137,7 +137,7 @@ static int create_dir(struct kobject * k
 		if (!error) {
 			error = sysfs_create(*d, mode, init_dir);
 			if (!error) {
-				p->d_inode->i_nlink++;
+				inc_nlink(p->d_inode);
 				(*d)->d_op = &sysfs_dentry_ops;
 				d_rehash(*d);
 			}
diff -puN fs/sysfs/mount.c~B4-monitor_inc_nlink fs/sysfs/mount.c
--- lxc/fs/sysfs/mount.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/fs/sysfs/mount.c	2006-08-08 10:57:59.000000000 -0700
@@ -49,7 +49,7 @@ static int sysfs_fill_super(struct super
 		inode->i_op = &sysfs_dir_inode_operations;
 		inode->i_fop = &sysfs_dir_operations;
 		/* directory inodes start off with i_nlink == 2 (for "." entry) */
-		inode->i_nlink++;	
+		inc_nlink(inode);
 	} else {
 		pr_debug("sysfs: could not get root inode\n");
 		return -ENOMEM;
diff -puN fs/udf/inode.c~B4-monitor_inc_nlink fs/udf/inode.c
--- lxc/fs/udf/inode.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/fs/udf/inode.c	2006-08-08 10:57:59.000000000 -0700
@@ -1165,7 +1165,7 @@ static void udf_fill_inode(struct inode 
 			inode->i_op = &udf_dir_inode_operations;
 			inode->i_fop = &udf_dir_operations;
 			inode->i_mode |= S_IFDIR;
-			inode->i_nlink ++;
+			inc_nlink(inode);
 			break;
 		}
 		case ICBTAG_FILE_TYPE_REALTIME:
diff -puN fs/udf/namei.c~B4-monitor_inc_nlink fs/udf/namei.c
--- lxc/fs/udf/namei.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/udf/namei.c	2006-08-08 10:57:59.000000000 -0700
@@ -762,7 +762,7 @@ static int udf_mkdir(struct inode * dir,
 		cpu_to_le32(UDF_I_UNIQUE(inode) & 0x00000000FFFFFFFFUL);
 	cfi.fileCharacteristics |= FID_FILE_CHAR_DIRECTORY;
 	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
-	dir->i_nlink++;
+	inc_nlink(dir);
 	mark_inode_dirty(dir);
 	d_instantiate(dentry, inode);
 	if (fibh.sbh != fibh.ebh)
@@ -1147,7 +1147,7 @@ static int udf_link(struct dentry * old_
 	if (fibh.sbh != fibh.ebh)
 		udf_release_data(fibh.ebh);
 	udf_release_data(fibh.sbh);
-	inode->i_nlink ++;
+	inc_nlink(inode);
 	inode->i_ctime = current_fs_time(inode->i_sb);
 	mark_inode_dirty(inode);
 	atomic_inc(&inode->i_count);
@@ -1282,7 +1282,7 @@ static int udf_rename (struct inode * ol
 		}
 		else
 		{
-			new_dir->i_nlink ++;
+			inc_nlink(new_dir);
 			mark_inode_dirty(new_dir);
 		}
 	}
diff -puN fs/vfat/namei.c~B4-monitor_inc_nlink fs/vfat/namei.c
--- lxc/fs/vfat/namei.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/fs/vfat/namei.c	2006-08-08 10:57:59.000000000 -0700
@@ -837,7 +837,7 @@ static int vfat_mkdir(struct inode *dir,
 	if (err)
 		goto out_free;
 	dir->i_version++;
-	dir->i_nlink++;
+	inc_nlink(dir);
 
 	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
 	brelse(sinfo.bh);
@@ -932,7 +932,7 @@ static int vfat_rename(struct inode *old
 		}
 		drop_nlink(old_dir);
 		if (!new_inode)
- 			new_dir->i_nlink++;
+ 			inc_nlink(new_dir);
 	}
 
 	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
diff -puN ipc/mqueue.c~B4-monitor_inc_nlink ipc/mqueue.c
--- lxc/ipc/mqueue.c~B4-monitor_inc_nlink	2006-08-08 10:57:11.000000000 -0700
+++ lxc-dave/ipc/mqueue.c	2006-08-08 10:57:59.000000000 -0700
@@ -168,7 +168,7 @@ static struct inode *mqueue_get_inode(st
 			/* all is ok */
 			info->user = get_uid(u);
 		} else if (S_ISDIR(mode)) {
-			inode->i_nlink++;
+			inc_nlink(inode);
 			/* Some things misbehave if size == 0 on a directory */
 			inode->i_size = 2 * DIRENT_SIZE;
 			inode->i_op = &mqueue_dir_inode_operations;
diff -puN kernel/cpuset.c~B4-monitor_inc_nlink kernel/cpuset.c
--- lxc/kernel/cpuset.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/kernel/cpuset.c	2006-08-08 10:57:59.000000000 -0700
@@ -377,7 +377,7 @@ static int cpuset_fill_super(struct supe
 		inode->i_op = &simple_dir_inode_operations;
 		inode->i_fop = &simple_dir_operations;
 		/* directories start off with i_nlink == 2 (for "." entry) */
-		inode->i_nlink++;
+		inc_nlink(inode);
 	} else {
 		return -ENOMEM;
 	}
@@ -1552,7 +1552,7 @@ static int cpuset_create_file(struct den
 		inode->i_fop = &simple_dir_operations;
 
 		/* start off with i_nlink == 2 (for "." entry) */
-		inode->i_nlink++;
+		inc_nlink(inode);
 	} else if (S_ISREG(mode)) {
 		inode->i_size = 0;
 		inode->i_fop = &cpuset_file_operations;
@@ -1585,7 +1585,7 @@ static int cpuset_create_dir(struct cpus
 	error = cpuset_create_file(dentry, S_IFDIR | mode);
 	if (!error) {
 		dentry->d_fsdata = cs;
-		parent->d_inode->i_nlink++;
+		inc_nlink(parent->d_inode);
 		cs->dentry = dentry;
 	}
 	dput(dentry);
@@ -2020,7 +2020,7 @@ int __init cpuset_init(void)
 	}
 	root = cpuset_mount->mnt_sb->s_root;
 	root->d_fsdata = &top_cpuset;
-	root->d_inode->i_nlink++;
+	inc_nlink(root->d_inode);
 	top_cpuset.dentry = root;
 	root->d_inode->i_op = &cpuset_dir_inode_operations;
 	number_of_cpusets = 1;
diff -puN net/sunrpc/rpc_pipe.c~B4-monitor_inc_nlink net/sunrpc/rpc_pipe.c
--- lxc/net/sunrpc/rpc_pipe.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/net/sunrpc/rpc_pipe.c	2006-08-08 10:57:59.000000000 -0700
@@ -496,7 +496,7 @@ rpc_get_inode(struct super_block *sb, in
 		case S_IFDIR:
 			inode->i_fop = &simple_dir_operations;
 			inode->i_op = &simple_dir_inode_operations;
-			inode->i_nlink++;
+			inc_nlink(inode);
 		default:
 			break;
 	}
@@ -572,7 +572,7 @@ rpc_populate(struct dentry *parent,
 		if (private)
 			rpc_inode_setowner(inode, private);
 		if (S_ISDIR(mode))
-			dir->i_nlink++;
+			inc_nlink(dir);
 		d_add(dentry, inode);
 	}
 	mutex_unlock(&dir->i_mutex);
@@ -594,7 +594,7 @@ __rpc_mkdir(struct inode *dir, struct de
 		goto out_err;
 	inode->i_ino = iunique(dir->i_sb, 100);
 	d_instantiate(dentry, inode);
-	dir->i_nlink++;
+	inc_nlink(dir);
 	inode_dir_notify(dir, DN_CREATE);
 	return 0;
 out_err:
diff -puN security/inode.c~B4-monitor_inc_nlink security/inode.c
--- lxc/security/inode.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/security/inode.c	2006-08-08 10:57:59.000000000 -0700
@@ -78,7 +78,7 @@ static struct inode *get_inode(struct su
 			inode->i_fop = &simple_dir_operations;
 
 			/* directory inodes start off with i_nlink == 2 (for "." entry) */
-			inode->i_nlink++;
+			inc_nlink(inode);
 			break;
 		}
 	}
@@ -111,7 +111,7 @@ static int mkdir(struct inode *dir, stru
 	mode = (mode & (S_IRWXUGO | S_ISVTX)) | S_IFDIR;
 	res = mknod(dir, dentry, mode, 0);
 	if (!res)
-		dir->i_nlink++;
+		inc_nlink(dir);
 	return res;
 }
 
diff -puN security/selinux/selinuxfs.c~B4-monitor_inc_nlink security/selinux/selinuxfs.c
--- lxc/security/selinux/selinuxfs.c~B4-monitor_inc_nlink	2006-08-08 09:30:58.000000000 -0700
+++ lxc-dave/security/selinux/selinuxfs.c	2006-08-08 10:57:59.000000000 -0700
@@ -1253,10 +1253,10 @@ static int sel_make_dir(struct inode *di
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
-	inode->i_nlink++;
+	inc_nlink(inode);
 	d_add(dentry, inode);
 	/* bump link count on parent directory, too */
-	dir->i_nlink++;
+	inc_nlink(dir);
 out:
 	return ret;
 }
_
