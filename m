Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265281AbUG2Ux7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265281AbUG2Ux7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266635AbUG2Ura
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:47:30 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:21676 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265281AbUG2UoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:44:09 -0400
Date: Thu, 29 Jul 2004 15:44:49 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] Stop pinning dentries & inodes for leaves
Message-ID: <20040729204449.GG4592@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040729203718.GB4592@in.ibm.com> <20040729203821.GC4592@in.ibm.com> <20040729203919.GD4592@in.ibm.com> <20040729204031.GE4592@in.ibm.com> <20040729204359.GF4592@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729204359.GF4592@in.ibm.com>
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
  existing corresponding sysfs_dirent through the d_fsdata field. This 
  increments the ref count of sysfs_dirent. The ref count is released through 
  ->d_iput() dentry_operation when dentry dies.


 fs/sysfs/bin.c     |   41 ++----------------
 fs/sysfs/dir.c     |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/sysfs/file.c    |   37 ++---------------
 fs/sysfs/inode.c   |    3 -
 fs/sysfs/mount.c   |    2 
 fs/sysfs/symlink.c |   40 ++----------------
 fs/sysfs/sysfs.h   |    4 +
 7 files changed, 137 insertions(+), 105 deletions(-)

diff -puN fs/sysfs/inode.c~sysfs-backing-store-stop-pinning fs/sysfs/inode.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/inode.c~sysfs-backing-store-stop-pinning	2004-07-29 15:30:41.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/inode.c	2004-07-29 15:30:41.000000000 -0500
@@ -68,7 +68,8 @@ int sysfs_create(struct dentry * dentry,
 		error = init(inode);
 	if (!error) {
 		d_instantiate(dentry, inode);
-		dget(dentry); /* Extra count - pin the dentry in core */
+		if (S_ISDIR(mode))
+			dget(dentry);  /* pin only directory dentry in core */
 	} else
 		iput(inode);
  Done:
diff -puN fs/sysfs/dir.c~sysfs-backing-store-stop-pinning fs/sysfs/dir.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/dir.c~sysfs-backing-store-stop-pinning	2004-07-29 15:30:41.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/dir.c	2004-07-29 15:30:41.000000000 -0500
@@ -14,7 +14,7 @@ DECLARE_RWSEM(sysfs_rename_sem);
 
 static int init_dir(struct inode * inode)
 {
-	inode->i_op = &simple_dir_inode_operations;
+	inode->i_op = &sysfs_dir_inode_operations;
 	inode->i_fop = &sysfs_dir_operations;
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
@@ -22,6 +22,35 @@ static int init_dir(struct inode * inode
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
+
+static void sysfs_d_iput(struct dentry * dentry, struct inode * inode)
+{
+	struct sysfs_dirent * sd = dentry->d_fsdata;
+
+	if (sd) {
+		BUG_ON(sd->s_dentry != dentry);
+		sd->s_dentry = NULL;
+		sysfs_put(sd);
+	}
+	iput(inode);
+}
+
+static struct dentry_operations sysfs_dentry_ops = {
+	.d_iput		= sysfs_d_iput,
+};
+
 
 static int create_dir(struct kobject * k, struct dentry * p,
 		      const char * n, struct dentry ** d)
@@ -41,10 +70,12 @@ static int create_dir(struct kobject * k
 						SYSFS_KOBJ_ATTR_GROUP :
 						SYSFS_KOBJECT);
 			if (sd) {
-				(*d)->d_fsdata = sd;
+				(*d)->d_fsdata = sysfs_get(sd);
+				(*d)->d_op = &sysfs_dentry_ops;
 				p->d_inode->i_nlink++;
 				sd->s_dentry = *d;
 				sd->s_mode = mode;
+				d_rehash(*d);
 			} else {
 				/* error, release the ref taken in
 				 * sysfs_create()
@@ -96,6 +127,82 @@ int sysfs_create_dir(struct kobject * ko
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
@@ -179,8 +286,10 @@ int sysfs_rename_dir(struct kobject * ko
 	if (!IS_ERR(new_dentry)) {
   		if (!new_dentry->d_inode) {
 			error = kobject_set_name(kobj,new_name);
-			if (!error)
+			if (!error) {
+				d_add(new_dentry, NULL);
 				d_move(kobj->dentry, new_dentry);
+			}
 		}
 		dput(new_dentry);
 	}
diff -puN fs/sysfs/file.c~sysfs-backing-store-stop-pinning fs/sysfs/file.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/file.c~sysfs-backing-store-stop-pinning	2004-07-29 15:30:41.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/file.c	2004-07-29 15:30:41.000000000 -0500
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
 
@@ -347,7 +338,7 @@ static int sysfs_release(struct inode * 
 	return 0;
 }
 
-static struct file_operations sysfs_file_operations = {
+struct file_operations sysfs_file_operations = {
 	.read		= sysfs_read_file,
 	.write		= sysfs_write_file,
 	.llseek		= generic_file_llseek,
@@ -358,32 +349,16 @@ static struct file_operations sysfs_file
 
 int sysfs_add_file(struct dentry * dir, const struct attribute * attr, int type)
 {
-	struct dentry * dentry;
 	struct sysfs_dirent * sd;
 	struct sysfs_dirent * parent_sd = dir->d_fsdata;
 	int error = 0;
 
 	down(&dir->d_inode->i_sem);
-	dentry = sysfs_get_dentry(dir,attr->name);
-	if (!IS_ERR(dentry)) {
-		error = sysfs_create(dentry,
-				     (attr->mode & S_IALLUGO) | S_IFREG,
-				     init_file);
-		if (!error) {
-
-			sd = sysfs_new_dirent(parent_sd, (void *) attr, type);
-			if (sd) {
-				sd->s_mode = (attr->mode & S_IALLUGO) | S_IFREG;
-				dentry->d_fsdata = sd;
-				sd->s_dentry = dentry;
-			} else {
-				dput(dentry);
-				error = -ENOMEM;
-			}
-		}
-		dput(dentry);
-	} else
-		error = PTR_ERR(dentry);
+	sd = sysfs_new_dirent(parent_sd, (void *) attr, type);
+	if (sd)
+		sd->s_mode = (attr->mode & S_IALLUGO) | S_IFREG;
+	else
+		error = -ENOMEM;
 	up(&dir->d_inode->i_sem);
 	return error;
 }
diff -puN fs/sysfs/bin.c~sysfs-backing-store-stop-pinning fs/sysfs/bin.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/bin.c~sysfs-backing-store-stop-pinning	2004-07-29 15:30:41.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/bin.c	2004-07-29 15:30:41.000000000 -0500
@@ -148,7 +148,7 @@ static int release(struct inode * inode,
 	return 0;
 }
 
-static struct file_operations bin_fops = {
+struct file_operations bin_fops = {
 	.read		= read,
 	.write		= write,
 	.llseek		= generic_file_llseek,
@@ -165,40 +165,11 @@ static struct file_operations bin_fops =
 
 int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr)
 {
-	struct dentry * dentry;
-	struct dentry * parent;
-	struct sysfs_dirent * sd;
-	umode_t mode = (attr->attr.mode & S_IALLUGO) | S_IFREG;
-	int error = 0;
-
-	if (!kobj || !attr)
-		return -EINVAL;
-
-	parent = kobj->dentry;
-
-	down(&parent->d_inode->i_sem);
-	dentry = sysfs_get_dentry(parent,attr->attr.name);
-	if (!IS_ERR(dentry)) {
-		error = sysfs_create(dentry, mode, NULL);
-		if (!error) {
-			dentry->d_inode->i_size = attr->size;
-			dentry->d_inode->i_fop = &bin_fops;
-			sd = sysfs_new_dirent(parent->d_fsdata, (void *) attr, 
-						SYSFS_KOBJ_BIN_ATTR);
-			if (!sd) {
-				sd->s_mode = mode;
-				dentry->d_fsdata = sd;
-				sd->s_dentry = dentry;
-			} else {
-				dput(dentry);
-				error =  -ENOMEM;
-			}
-		}
-		dput(dentry);
-	} else
-		error = PTR_ERR(dentry);
-	up(&parent->d_inode->i_sem);
-	return error;
+	if (kobj && kobj->dentry && attr)
+		return sysfs_add_file(kobj->dentry, &attr->attr,
+					SYSFS_KOBJ_BIN_ATTR);
+	return -EINVAL;
+
 }
 
 
diff -puN fs/sysfs/symlink.c~sysfs-backing-store-stop-pinning fs/sysfs/symlink.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/symlink.c~sysfs-backing-store-stop-pinning	2004-07-29 15:30:41.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/symlink.c	2004-07-29 15:30:41.000000000 -0500
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
@@ -53,9 +47,8 @@ static void fill_object_path(struct kobj
 	}
 }
 
-static struct sysfs_dirent * 
-sysfs_add_link(struct sysfs_dirent * parent_sd, char * name, 
-		struct kobject * target)
+static int sysfs_add_link(struct sysfs_dirent * parent_sd, char * name,
+			    struct kobject * target)
 {
 	struct sysfs_dirent * sd;
 	struct sysfs_symlink * sl;
@@ -76,14 +69,14 @@ sysfs_add_link(struct sysfs_dirent * par
 	sd = sysfs_new_dirent(parent_sd, sl, SYSFS_KOBJ_LINK);
 	if (sd) {
 		sd->s_mode = S_IFLNK|S_IRWXUGO;
-		return sd;
+		return 0;
 	}
 
 	kfree(sl->link_name);
 exit2:
 	kfree(sl);
 exit1:
-	return ERR_PTR(error);
+	return error;
 }
 
 /**
@@ -95,34 +88,13 @@ exit1:
 int sysfs_create_link(struct kobject * kobj, struct kobject * target, char * name)
 {
 	struct dentry * dentry = kobj->dentry;
-	struct dentry * d;
 	int error = 0;
 
 	if (!name)
 		return -EINVAL;
 
 	down(&dentry->d_inode->i_sem);
-	d = sysfs_get_dentry(dentry,name);
-	if (!IS_ERR(d)) {
-		error = sysfs_create(d, S_IFLNK|S_IRWXUGO, init_symlink);
-		if (!error) {
-			struct sysfs_dirent * sd;
-			sd = sysfs_add_link(dentry->d_fsdata, name, target);
-			if (!IS_ERR(sd)) {
-				/* 
-			 	* associate the link dentry with the target  
-			 	* through the corresponding sysfs_dirent.
-			 	*/
-				d->d_fsdata = sd;
-				sd->s_dentry = dentry;
-			} else {
-				dput(d);
-				error = PTR_ERR(sd);
-			}
-		}
-		dput(d);
-	} else 
-		error = PTR_ERR(d);
+	error = sysfs_add_link(dentry->d_fsdata, name, target);
 	up(&dentry->d_inode->i_sem);
 	return error;
 }
diff -puN fs/sysfs/sysfs.h~sysfs-backing-store-stop-pinning fs/sysfs/sysfs.h
--- linux-2.6.8-rc2-mm1/fs/sysfs/sysfs.h~sysfs-backing-store-stop-pinning	2004-07-29 15:30:41.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/sysfs.h	2004-07-29 15:30:41.000000000 -0500
@@ -20,6 +20,10 @@ extern int sysfs_follow_link(struct dent
 extern struct rw_semaphore sysfs_rename_sem;
 extern struct super_block * sysfs_sb;
 extern struct file_operations sysfs_dir_operations;
+extern struct file_operations sysfs_file_operations;
+extern struct file_operations bin_fops;
+extern struct inode_operations sysfs_dir_inode_operations;
+extern struct inode_operations sysfs_symlink_inode_operations;
 
 struct sysfs_symlink {
 	char * link_name;
diff -puN fs/sysfs/mount.c~sysfs-backing-store-stop-pinning fs/sysfs/mount.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/mount.c~sysfs-backing-store-stop-pinning	2004-07-29 15:30:41.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/mount.c	2004-07-29 15:30:41.000000000 -0500
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
