Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267929AbUHKEXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267929AbUHKEXo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 00:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267928AbUHKEXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 00:23:43 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:29118 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267929AbUHKEVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 00:21:54 -0400
Date: Tue, 10 Aug 2004 16:03:38 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] Stop pinning dentries/inodes for leaf entries
Message-ID: <20040810210338.GF3124@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040810205739.GA3124@in.ibm.com> <20040810210102.GC3124@in.ibm.com> <20040810210203.GD3124@in.ibm.com> <20040810210240.GE3124@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810210240.GE3124@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o This patch stops the pinning of non-directory or leaf dentries and inodes. 
  The leaf dentries and inodes are created during lookup based on the
  entries on sysfs_dirent tree. These leaves are removed from the dcache
  through the VFS dentry ageing process during shrink dcache operations. Thus
  reducing about 80% of sysfs lowmem needs.

o This implments the ->lookup() for sysfs directory inodes and allocates
  dentry and inode if the lookup is successful and avoids the need of 
  allocating and pinning of dentry and inodes during the creation of 
  corresponding sysfs leaf entry. As of now the implementation has not 
  required negative dentry creation on failed lookup. As sysfs is still a
  RAM based filesystem, negative dentries are not of any use IMO.

o The leaf dentry allocated after successful lookup is connected to the 
  existing corresponding sysfs_dirent through the d_fsdata field.


 sysfs/group.c      |    0 
 fs/sysfs/bin.c     |   28 +-------------
 fs/sysfs/dir.c     |  106 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/sysfs/file.c    |   25 +-----------
 fs/sysfs/mount.c   |    2 -
 fs/sysfs/symlink.c |   26 ++-----------
 fs/sysfs/sysfs.h   |    4 ++
 7 files changed, 115 insertions(+), 76 deletions(-)

diff -puN fs/sysfs/dir.c~sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves fs/sysfs/dir.c
--- linux-2.6.8-rc4/fs/sysfs/dir.c~sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves	2004-08-10 15:09:20.000000000 -0500
+++ linux-2.6.8-rc4-maneesh/fs/sysfs/dir.c	2004-08-10 15:09:20.000000000 -0500
@@ -61,15 +61,17 @@ int sysfs_make_dirent(struct sysfs_diren
 	sd->s_mode = mode;
 	sd->s_type = type;
 	sd->s_dentry = dentry;
-	dentry->d_fsdata = sysfs_get(sd);
-	dentry->d_op = &sysfs_dentry_ops;
+	if (dentry) {
+		dentry->d_fsdata = sysfs_get(sd);
+		dentry->d_op = &sysfs_dentry_ops;
+	}
 
 	return 0;
 }
 
 static int init_dir(struct inode * inode)
 {
-	inode->i_op = &simple_dir_inode_operations;
+	inode->i_op = &sysfs_dir_inode_operations;
 	inode->i_fop = &sysfs_dir_operations;
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
@@ -77,6 +79,18 @@ static int init_dir(struct inode * inode
 	return 0;
 }
 
+static int init_file(struct inode * inode)
+{
+	inode->i_size = PAGE_SIZE;
+	inode->i_fop = &sysfs_file_operations;
+	return 0;
+}
+
+static int init_symlink(struct inode * inode)
+{
+	inode->i_op = &sysfs_symlink_inode_operations;
+	return 0;
+}
 
 static int create_dir(struct kobject * k, struct dentry * p,
 		      const char * n, struct dentry ** d)
@@ -91,8 +105,11 @@ static int create_dir(struct kobject * k
 		if (!error) {
 			error = sysfs_make_dirent(p->d_fsdata, *d, k, mode,
 						SYSFS_DIR);
-			if (!error)
+			if (!error) {
 				p->d_inode->i_nlink++;
+				(*d)->d_op = &sysfs_dentry_ops;
+				d_rehash(*d);
+			}
 		}
 		if (error)
 			d_drop(*d);
@@ -136,6 +153,82 @@ int sysfs_create_dir(struct kobject * ko
 	return error;
 }
 
+/* attaches attribute's sysfs_dirent to the dentry corresponding to the
+ * attribute file
+ */
+static int sysfs_attach_attr(struct sysfs_dirent * sd, struct dentry * dentry)
+{
+	struct attribute * attr = NULL;
+	struct bin_attribute * bin_attr = NULL;
+	int (* init) (struct inode *) = NULL;
+	int error = 0;
+
+        if (sd->s_type & SYSFS_KOBJ_BIN_ATTR) {
+                bin_attr = sd->s_element;
+                attr = &bin_attr->attr;
+        } else {
+                attr = sd->s_element;
+                init = init_file;
+        }
+
+	error = sysfs_create(dentry, (attr->mode & S_IALLUGO) | S_IFREG, init);
+	if (error)
+		return error;
+
+        if (bin_attr) {
+		dentry->d_inode->i_size = bin_attr->size;
+		dentry->d_inode->i_fop = &bin_fops;
+	}
+	dentry->d_op = &sysfs_dentry_ops;
+	dentry->d_fsdata = sysfs_get(sd);
+	sd->s_dentry = dentry;
+	d_rehash(dentry);
+
+	return 0;
+}
+
+static int sysfs_attach_link(struct sysfs_dirent * sd, struct dentry * dentry)
+{
+	int err = 0;
+
+	err = sysfs_create(dentry, S_IFLNK|S_IRWXUGO, init_symlink);
+	if (!err) {
+		dentry->d_op = &sysfs_dentry_ops;
+		dentry->d_fsdata = sysfs_get(sd);
+		sd->s_dentry = dentry;
+		d_rehash(dentry);
+	}
+	return err;
+}
+
+struct dentry * sysfs_lookup(struct inode *dir, struct dentry *dentry,
+				struct nameidata *nd)
+{
+	struct sysfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * sd;
+	int err = 0;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (sd->s_type & SYSFS_NOT_PINNED) {
+			const unsigned char * name = sysfs_get_name(sd);
+
+			if (strcmp(name, dentry->d_name.name))
+				continue;
+
+			if (sd->s_type & SYSFS_KOBJ_LINK)
+				err = sysfs_attach_link(sd, dentry);
+			else
+				err = sysfs_attach_attr(sd, dentry);
+			break;
+		}
+	}
+
+	return ERR_PTR(err);
+}
+
+struct inode_operations sysfs_dir_inode_operations = {
+	.lookup		= sysfs_lookup,
+};
 
 static void remove_dir(struct dentry * d)
 {
@@ -219,8 +312,10 @@ int sysfs_rename_dir(struct kobject * ko
 	if (!IS_ERR(new_dentry)) {
   		if (!new_dentry->d_inode) {
 			error = kobject_set_name(kobj,new_name);
-			if (!error)
+			if (!error) {
+				d_add(new_dentry, NULL);
 				d_move(kobj->dentry, new_dentry);
+			}
 			else
 				d_drop(new_dentry);
 		} else
@@ -254,7 +349,6 @@ static int sysfs_dir_close(struct inode 
 	down(&dentry->d_inode->i_sem);
 	list_del_init(&cursor->s_sibling);
 	up(&dentry->d_inode->i_sem);
-	sysfs_put(file->private_data);
 
 	return 0;
 }
diff -puN fs/sysfs/file.c~sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves fs/sysfs/file.c
--- linux-2.6.8-rc4/fs/sysfs/file.c~sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves	2004-08-10 15:09:20.000000000 -0500
+++ linux-2.6.8-rc4-maneesh/fs/sysfs/file.c	2004-08-10 15:09:20.000000000 -0500
@@ -9,15 +9,6 @@
 
 #include "sysfs.h"
 
-static struct file_operations sysfs_file_operations;
-
-static int init_file(struct inode * inode)
-{
-	inode->i_size = PAGE_SIZE;
-	inode->i_fop = &sysfs_file_operations;
-	return 0;
-}
-
 #define to_subsys(k) container_of(k,struct subsystem,kset.kobj)
 #define to_sattr(a) container_of(a,struct subsys_attribute,attr)
 
@@ -337,7 +328,7 @@ static int sysfs_release(struct inode * 
 	return 0;
 }
 
-static struct file_operations sysfs_file_operations = {
+struct file_operations sysfs_file_operations = {
 	.read		= sysfs_read_file,
 	.write		= sysfs_write_file,
 	.llseek		= generic_file_llseek,
@@ -348,24 +339,14 @@ static struct file_operations sysfs_file
 
 int sysfs_add_file(struct dentry * dir, const struct attribute * attr, int type)
 {
-	struct dentry * dentry;
 	struct sysfs_dirent * parent_sd = dir->d_fsdata;
 	umode_t mode = (attr->mode & S_IALLUGO) | S_IFREG;
 	int error = 0;
 
 	down(&dir->d_inode->i_sem);
-	dentry = sysfs_get_dentry(dir,attr->name);
-	if (!IS_ERR(dentry)) {
-		error = sysfs_create(dentry, mode, init_file);
-		if (!error)
-			error = sysfs_make_dirent(parent_sd, dentry, 
-						(void *) attr, mode, type);
-		if (error)
-			d_drop(dentry);
-		dput(dentry);
-	} else
-		error = PTR_ERR(dentry);
+	error = sysfs_make_dirent(parent_sd, NULL, (void *) attr, mode, type);
 	up(&dir->d_inode->i_sem);
+
 	return error;
 }
 
diff -puN fs/sysfs/bin.c~sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves fs/sysfs/bin.c
--- linux-2.6.8-rc4/fs/sysfs/bin.c~sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves	2004-08-10 15:09:20.000000000 -0500
+++ linux-2.6.8-rc4-maneesh/fs/sysfs/bin.c	2004-08-10 15:09:20.000000000 -0500
@@ -141,7 +141,7 @@ static int release(struct inode * inode,
 	return 0;
 }
 
-static struct file_operations bin_fops = {
+struct file_operations bin_fops = {
 	.read		= read,
 	.write		= write,
 	.llseek		= generic_file_llseek,
@@ -158,33 +158,9 @@ static struct file_operations bin_fops =
 
 int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr)
 {
-	struct dentry * dentry;
-	struct dentry * parent;
-	umode_t mode = (attr->attr.mode & S_IALLUGO) | S_IFREG;
-	int error = 0;
-
 	BUG_ON(!kobj || !kobj->dentry || !attr);
 
-	parent = kobj->dentry;
-
-	down(&parent->d_inode->i_sem);
-	dentry = sysfs_get_dentry(parent,attr->attr.name);
-	if (!IS_ERR(dentry)) {
-		error = sysfs_create(dentry, mode, NULL);
-		if (!error) {
-			dentry->d_inode->i_size = attr->size;
-			dentry->d_inode->i_fop = &bin_fops;
-			error = sysfs_make_dirent(parent->d_fsdata, dentry, 
-						  (void *) attr, mode, 
-						  SYSFS_KOBJ_BIN_ATTR);
-		}
-		if (error)
-			d_drop(dentry);
-		dput(dentry);
-	} else
-		error = PTR_ERR(dentry);
-	up(&parent->d_inode->i_sem);
-	return error;
+	return sysfs_add_file(kobj->dentry, &attr->attr, SYSFS_KOBJ_BIN_ATTR);
 }
 
 
diff -puN fs/sysfs/sysfs.h~sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves fs/sysfs/sysfs.h
--- linux-2.6.8-rc4/fs/sysfs/sysfs.h~sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves	2004-08-10 15:09:20.000000000 -0500
+++ linux-2.6.8-rc4-maneesh/fs/sysfs/sysfs.h	2004-08-10 15:09:20.000000000 -0500
@@ -21,6 +21,10 @@ extern int sysfs_follow_link(struct dent
 extern struct rw_semaphore sysfs_rename_sem;
 extern struct super_block * sysfs_sb;
 extern struct file_operations sysfs_dir_operations;
+extern struct file_operations sysfs_file_operations;
+extern struct file_operations bin_fops;
+extern struct inode_operations sysfs_dir_inode_operations;
+extern struct inode_operations sysfs_symlink_inode_operations;
 
 struct sysfs_symlink {
 	char * link_name;
diff -puN fs/sysfs/symlink.c~sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves fs/sysfs/symlink.c
--- linux-2.6.8-rc4/fs/sysfs/symlink.c~sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves	2004-08-10 15:09:20.000000000 -0500
+++ linux-2.6.8-rc4-maneesh/fs/sysfs/symlink.c	2004-08-10 15:09:20.000000000 -0500
@@ -8,17 +8,11 @@
 
 #include "sysfs.h"
 
-static struct inode_operations sysfs_symlink_inode_operations = {
+struct inode_operations sysfs_symlink_inode_operations = {
 	.readlink = sysfs_readlink,
 	.follow_link = sysfs_follow_link,
 };
 
-static int init_symlink(struct inode * inode)
-{
-	inode->i_op = &sysfs_symlink_inode_operations;
-	return 0;
-}
-
 static int object_depth(struct kobject * kobj)
 {
 	struct kobject * p = kobj;
@@ -53,9 +47,9 @@ static void fill_object_path(struct kobj
 	}
 }
 
-static int sysfs_add_link(struct dentry * dentry, char * name, struct kobject * target)
+static int sysfs_add_link(struct dentry * parent, char * name, struct kobject * target)
 {
-	struct sysfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * parent_sd = parent->d_fsdata;
 	struct sysfs_symlink * sl;
 	int error = 0;
 
@@ -71,7 +65,7 @@ static int sysfs_add_link(struct dentry 
 	strcpy(sl->link_name, name);
 	sl->target_kobj = kobject_get(target);
 
-	error = sysfs_make_dirent(parent_sd, dentry, sl, S_IFLNK|S_IRWXUGO, 
+	error = sysfs_make_dirent(parent_sd, NULL, sl, S_IFLNK|S_IRWXUGO, 
 				SYSFS_KOBJ_LINK);
 	if (!error)
 		return 0;
@@ -92,22 +86,12 @@ exit1:
 int sysfs_create_link(struct kobject * kobj, struct kobject * target, char * name)
 {
 	struct dentry * dentry = kobj->dentry;
-	struct dentry * d;
 	int error = 0;
 
 	BUG_ON(!kobj || !kobj->dentry || !name);
 
 	down(&dentry->d_inode->i_sem);
-	d = sysfs_get_dentry(dentry,name);
-	if (!IS_ERR(d)) {
-		error = sysfs_create(d, S_IFLNK|S_IRWXUGO, init_symlink);
-		if (!error)
-			error = sysfs_add_link(d, name, target);
-		if (error)
-			d_drop(d);
-		dput(d);
-	} else 
-		error = PTR_ERR(d);
+	error = sysfs_add_link(dentry, name, target);
 	up(&dentry->d_inode->i_sem);
 	return error;
 }
diff -puN fs/sysfs/group.c~sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves fs/sysfs/group.c
diff -puN fs/sysfs/mount.c~sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves fs/sysfs/mount.c
--- linux-2.6.8-rc4/fs/sysfs/mount.c~sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves	2004-08-10 15:09:20.000000000 -0500
+++ linux-2.6.8-rc4-maneesh/fs/sysfs/mount.c	2004-08-10 15:09:20.000000000 -0500
@@ -42,7 +42,7 @@ static int sysfs_fill_super(struct super
 
 	inode = sysfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
 	if (inode) {
-		inode->i_op = &simple_dir_inode_operations;
+		inode->i_op = &sysfs_dir_inode_operations;
 		inode->i_fop = &sysfs_dir_operations;
 		/* directory inodes start off with i_nlink == 2 (for "." entry) */
 		inode->i_nlink++;	

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
