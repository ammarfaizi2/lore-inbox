Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268810AbUKAXXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268810AbUKAXXj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275920AbUKAXXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:23:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:13220 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S323729AbUKAV71 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:59:27 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <1099346276701@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Mon, 1 Nov 2004 13:57:56 -0800
Message-Id: <10993462762242@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2444, 2004/11/01 13:04:09-08:00, akpm@osdl.org

[PATCH] sysfs backing store: stop pinning dentries/inodes for leaf entries

From: Maneesh Soni <maneesh@in.ibm.com>

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

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/bin.c     |   28 +-------------
 fs/sysfs/dir.c     |  106 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/sysfs/file.c    |   25 +-----------
 fs/sysfs/mount.c   |    2 -
 fs/sysfs/symlink.c |   26 ++-----------
 fs/sysfs/sysfs.h   |    4 ++
 6 files changed, 115 insertions(+), 76 deletions(-)


diff -Nru a/fs/sysfs/bin.c b/fs/sysfs/bin.c
--- a/fs/sysfs/bin.c	2004-11-01 13:36:56 -08:00
+++ b/fs/sysfs/bin.c	2004-11-01 13:36:56 -08:00
@@ -141,7 +141,7 @@
 	return 0;
 }
 
-static struct file_operations bin_fops = {
+struct file_operations bin_fops = {
 	.read		= read,
 	.write		= write,
 	.llseek		= generic_file_llseek,
@@ -158,33 +158,9 @@
 
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
 
 
diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	2004-11-01 13:36:56 -08:00
+++ b/fs/sysfs/dir.c	2004-11-01 13:36:56 -08:00
@@ -61,15 +61,17 @@
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
@@ -77,6 +79,18 @@
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
@@ -91,8 +105,11 @@
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
@@ -136,6 +153,82 @@
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
@@ -219,8 +312,10 @@
 	if (!IS_ERR(new_dentry)) {
   		if (!new_dentry->d_inode) {
 			error = kobject_set_name(kobj, "%s", new_name);
-			if (!error)
+			if (!error) {
+				d_add(new_dentry, NULL);
 				d_move(kobj->dentry, new_dentry);
+			}
 			else
 				d_drop(new_dentry);
 		} else
@@ -254,7 +349,6 @@
 	down(&dentry->d_inode->i_sem);
 	list_del_init(&cursor->s_sibling);
 	up(&dentry->d_inode->i_sem);
-	sysfs_put(file->private_data);
 
 	return 0;
 }
diff -Nru a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c	2004-11-01 13:36:56 -08:00
+++ b/fs/sysfs/file.c	2004-11-01 13:36:56 -08:00
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
 
@@ -337,7 +328,7 @@
 	return 0;
 }
 
-static struct file_operations sysfs_file_operations = {
+struct file_operations sysfs_file_operations = {
 	.read		= sysfs_read_file,
 	.write		= sysfs_write_file,
 	.llseek		= generic_file_llseek,
@@ -348,24 +339,14 @@
 
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
 
diff -Nru a/fs/sysfs/mount.c b/fs/sysfs/mount.c
--- a/fs/sysfs/mount.c	2004-11-01 13:36:56 -08:00
+++ b/fs/sysfs/mount.c	2004-11-01 13:36:56 -08:00
@@ -42,7 +42,7 @@
 
 	inode = sysfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
 	if (inode) {
-		inode->i_op = &simple_dir_inode_operations;
+		inode->i_op = &sysfs_dir_inode_operations;
 		inode->i_fop = &sysfs_dir_operations;
 		/* directory inodes start off with i_nlink == 2 (for "." entry) */
 		inode->i_nlink++;	
diff -Nru a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
--- a/fs/sysfs/symlink.c	2004-11-01 13:36:56 -08:00
+++ b/fs/sysfs/symlink.c	2004-11-01 13:36:56 -08:00
@@ -9,18 +9,12 @@
 
 #include "sysfs.h"
 
-static struct inode_operations sysfs_symlink_inode_operations = {
+struct inode_operations sysfs_symlink_inode_operations = {
 	.readlink = generic_readlink,
 	.follow_link = sysfs_follow_link,
 	.put_link = sysfs_put_link,
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
@@ -55,9 +49,9 @@
 	}
 }
 
-static int sysfs_add_link(struct dentry * dentry, char * name, struct kobject * target)
+static int sysfs_add_link(struct dentry * parent, char * name, struct kobject * target)
 {
-	struct sysfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * parent_sd = parent->d_fsdata;
 	struct sysfs_symlink * sl;
 	int error = 0;
 
@@ -73,7 +67,7 @@
 	strcpy(sl->link_name, name);
 	sl->target_kobj = kobject_get(target);
 
-	error = sysfs_make_dirent(parent_sd, dentry, sl, S_IFLNK|S_IRWXUGO,
+	error = sysfs_make_dirent(parent_sd, NULL, sl, S_IFLNK|S_IRWXUGO,
 				SYSFS_KOBJ_LINK);
 	if (!error)
 		return 0;
@@ -94,22 +88,12 @@
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
diff -Nru a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
--- a/fs/sysfs/sysfs.h	2004-11-01 13:36:56 -08:00
+++ b/fs/sysfs/sysfs.h	2004-11-01 13:36:56 -08:00
@@ -22,6 +22,10 @@
 extern struct rw_semaphore sysfs_rename_sem;
 extern struct super_block * sysfs_sb;
 extern struct file_operations sysfs_dir_operations;
+extern struct file_operations sysfs_file_operations;
+extern struct file_operations bin_fops;
+extern struct inode_operations sysfs_dir_inode_operations;
+extern struct inode_operations sysfs_symlink_inode_operations;
 
 struct sysfs_symlink {
 	char * link_name;

