Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265247AbUG2UjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbUG2UjA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUG2UjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:39:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:25536 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265247AbUG2Uhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:37:36 -0400
Date: Thu, 29 Jul 2004 15:38:21 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] Add sysfs_dirent to sysfs dentry
Message-ID: <20040729203821.GC4592@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040729203718.GB4592@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729203718.GB4592@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o This the first patch in the series of patches implementing sysfs backing
  store. It introduces the new sysfs_dirent data structure. The sysfs_dirent 
  is added to each of the element which can be represented in sysfs like, 
  kobject (directory), text or binary attributes (files), attribute groups 
  (directory) and symlinks.

o It uses dentry's d_fsdata field to attach the corresponding sysfs_dirent.

o The sysfs_dirents are maintained in a tree of all the sysfs entries using the
  s_children and s_sibling list pointers. 

o The patch just adds the sysfs_dirent structure and hence should not be used
  independently but system can boot with it.


 fs/sysfs/bin.c        |   17 +++++++++++----
 fs/sysfs/dir.c        |   27 +++++++++++++++++++-----
 fs/sysfs/file.c       |   25 ++++++++++++++++------
 fs/sysfs/group.c      |    2 -
 fs/sysfs/mount.c      |    8 +++++++
 fs/sysfs/symlink.c    |   56 +++++++++++++++++++++++++++++++++++++++++++++-----
 fs/sysfs/sysfs.h      |   37 ++++++++++++++++++++++++++++++---
 include/linux/sysfs.h |   21 ++++++++++++++++++
 8 files changed, 169 insertions(+), 24 deletions(-)

diff -puN include/linux/sysfs.h~sysfs-backing-store-add-sysfs_dirent include/linux/sysfs.h
--- linux-2.6.8-rc2-mm1/include/linux/sysfs.h~sysfs-backing-store-add-sysfs_dirent	2004-07-29 15:30:37.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/include/linux/sysfs.h	2004-07-29 15:30:37.000000000 -0500
@@ -9,6 +9,8 @@
 #ifndef _SYSFS_H_
 #define _SYSFS_H_
 
+#include <asm/atomic.h>
+
 struct kobject;
 struct module;
 
@@ -57,6 +59,25 @@ struct sysfs_ops {
 	ssize_t	(*store)(struct kobject *,struct attribute *,const char *, size_t);
 };
 
+struct sysfs_dirent {
+	atomic_t		s_count;
+	struct list_head	s_sibling;
+	struct list_head	s_children;
+	void 			* s_element;
+	int			s_type;
+	umode_t			s_mode;
+	struct dentry		* s_dentry;
+};
+
+#define SYSFS_ROOT		0x0001
+#define SYSFS_KOBJECT		0x0002
+#define SYSFS_KOBJ_ATTR 	0x0004
+#define SYSFS_KOBJ_BIN_ATTR	0x0008
+#define SYSFS_KOBJ_ATTR_GROUP	0x0010
+#define SYSFS_KOBJ_LINK 	0x0020
+#define SYSFS_NOT_PINNED	(SYSFS_KOBJ_ATTR | SYSFS_KOBJ_BIN_ATTR | SYSFS_KOBJ_LINK)
+
+
 #ifdef CONFIG_SYSFS
 
 extern int
diff -puN fs/sysfs/dir.c~sysfs-backing-store-add-sysfs_dirent fs/sysfs/dir.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/dir.c~sysfs-backing-store-add-sysfs_dirent	2004-07-29 15:30:37.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/dir.c	2004-07-29 15:31:16.000000000 -0500
@@ -27,17 +27,34 @@ static int create_dir(struct kobject * k
 		      const char * n, struct dentry ** d)
 {
 	int error;
+	umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
 
 	down(&p->d_inode->i_sem);
 	*d = sysfs_get_dentry(p,n);
 	if (!IS_ERR(*d)) {
-		error = sysfs_create(*d,
-					 S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
-					 init_dir);
+		error = sysfs_create(*d, mode, init_dir);
 		if (!error) {
-			(*d)->d_fsdata = k;
-			p->d_inode->i_nlink++;
+			struct sysfs_dirent * sd, * parent_sd;
+			parent_sd = p->d_fsdata;
+			sd = sysfs_new_dirent(parent_sd, k,
+						(parent_sd->s_element == k) ?
+						SYSFS_KOBJ_ATTR_GROUP :
+						SYSFS_KOBJECT);
+			if (sd) {
+				(*d)->d_fsdata = sd;
+				p->d_inode->i_nlink++;
+				sd->s_dentry = *d;
+				sd->s_mode = mode;
+			} else {
+				/* error, release the ref taken in
+				 * sysfs_create()
+				 */
+				dput(*d);  
+				error = -ENOMEM;
+			}
 		}
+		/* This will free the dentry in case of error 
+		 */
 		dput(*d);
 	} else
 		error = PTR_ERR(*d);
diff -puN fs/sysfs/file.c~sysfs-backing-store-add-sysfs_dirent fs/sysfs/file.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/file.c~sysfs-backing-store-add-sysfs_dirent	2004-07-29 15:30:37.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/file.c	2004-07-29 15:31:10.000000000 -0500
@@ -346,10 +346,12 @@ static struct file_operations sysfs_file
 };
 
 
-int sysfs_add_file(struct dentry * dir, const struct attribute * attr)
+int sysfs_add_file(struct dentry * dir, const struct attribute * attr, int type)
 {
 	struct dentry * dentry;
-	int error;
+	struct sysfs_dirent * sd;
+	struct sysfs_dirent * parent_sd = dir->d_fsdata;
+	int error = 0;
 
 	down(&dir->d_inode->i_sem);
 	dentry = sysfs_get_dentry(dir,attr->name);
@@ -357,8 +359,18 @@ int sysfs_add_file(struct dentry * dir, 
 		error = sysfs_create(dentry,
 				     (attr->mode & S_IALLUGO) | S_IFREG,
 				     init_file);
-		if (!error)
-			dentry->d_fsdata = (void *)attr;
+		if (!error) {
+
+			sd = sysfs_new_dirent(parent_sd, (void *) attr, type);
+			if (sd) {
+				sd->s_mode = (attr->mode & S_IALLUGO) | S_IFREG;
+				dentry->d_fsdata = sd;
+				sd->s_dentry = dentry;
+			} else {
+				dput(dentry);
+				error = -ENOMEM;
+			}
+		}
 		dput(dentry);
 	} else
 		error = PTR_ERR(dentry);
@@ -375,8 +387,9 @@ int sysfs_add_file(struct dentry * dir, 
 
 int sysfs_create_file(struct kobject * kobj, const struct attribute * attr)
 {
-	if (kobj && attr)
-		return sysfs_add_file(kobj->dentry,attr);
+	if (kobj && kobj->dentry && attr)
+		return sysfs_add_file(kobj->dentry, attr, SYSFS_KOBJ_ATTR);
+
 	return -EINVAL;
 }
 
diff -puN fs/sysfs/bin.c~sysfs-backing-store-add-sysfs_dirent fs/sysfs/bin.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/bin.c~sysfs-backing-store-add-sysfs_dirent	2004-07-29 15:30:37.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/bin.c	2004-07-29 15:31:10.000000000 -0500
@@ -160,6 +160,8 @@ int sysfs_create_bin_file(struct kobject
 {
 	struct dentry * dentry;
 	struct dentry * parent;
+	struct sysfs_dirent * sd;
+	umode_t mode = (attr->attr.mode & S_IALLUGO) | S_IFREG;
 	int error = 0;
 
 	if (!kobj || !attr)
@@ -170,13 +172,20 @@ int sysfs_create_bin_file(struct kobject
 	down(&parent->d_inode->i_sem);
 	dentry = sysfs_get_dentry(parent,attr->attr.name);
 	if (!IS_ERR(dentry)) {
-		dentry->d_fsdata = (void *)attr;
-		error = sysfs_create(dentry,
-				     (attr->attr.mode & S_IALLUGO) | S_IFREG,
-				     NULL);
+		error = sysfs_create(dentry, mode, NULL);
 		if (!error) {
 			dentry->d_inode->i_size = attr->size;
 			dentry->d_inode->i_fop = &bin_fops;
+			sd = sysfs_new_dirent(parent->d_fsdata, (void *) attr, 
+						SYSFS_KOBJ_BIN_ATTR);
+			if (!sd) {
+				sd->s_mode = mode;
+				dentry->d_fsdata = sd;
+				sd->s_dentry = dentry;
+			} else {
+				dput(dentry);
+				error =  -ENOMEM;
+			}
 		}
 		dput(dentry);
 	} else
diff -puN fs/sysfs/sysfs.h~sysfs-backing-store-add-sysfs_dirent fs/sysfs/sysfs.h
--- linux-2.6.8-rc2-mm1/fs/sysfs/sysfs.h~sysfs-backing-store-add-sysfs_dirent	2004-07-29 15:30:37.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/sysfs.h	2004-07-29 15:31:16.000000000 -0500
@@ -5,8 +5,9 @@ extern struct inode * sysfs_new_inode(mo
 extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
 
 extern struct dentry * sysfs_get_dentry(struct dentry *, const char *);
+extern void sysfs_drop_dentry(struct sysfs_dirent *, struct dentry *);
 
-extern int sysfs_add_file(struct dentry * dir, const struct attribute * attr);
+extern int sysfs_add_file(struct dentry *, const struct attribute *, int);
 extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
 
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
@@ -16,14 +17,44 @@ extern int sysfs_readlink(struct dentry 
 extern int sysfs_follow_link(struct dentry *, struct nameidata *);
 extern struct rw_semaphore sysfs_rename_sem;
 
+struct sysfs_symlink {
+	char * link_name;
+	struct kobject * target_kobj;
+};
+
 static inline struct kobject *sysfs_get_kobject(struct dentry *dentry)
 {
 	struct kobject * kobj = NULL;
 
 	spin_lock(&dcache_lock);
-	if (!d_unhashed(dentry))
-		kobj = kobject_get(dentry->d_fsdata);
+	if (!d_unhashed(dentry)) {
+		struct sysfs_dirent * sd = dentry->d_fsdata;
+		if (sd->s_type & SYSFS_KOBJ_LINK) {
+			struct sysfs_symlink * sl = sd->s_element;
+			kobj = kobject_get(sl->target_kobj);
+		} else
+			kobj = kobject_get(sd->s_element);
+	}
 	spin_unlock(&dcache_lock);
 
 	return kobj;
 }
+
+static inline
+struct sysfs_dirent * sysfs_new_dirent(struct sysfs_dirent * p, void * e, int t)
+{
+	struct sysfs_dirent * sd;
+
+	sd = kmalloc(sizeof(*sd), GFP_KERNEL);
+	if (!sd)
+		return NULL;
+	memset(sd, 0, sizeof(*sd));
+	atomic_set(&sd->s_count, 1);
+	sd->s_element = e;
+	sd->s_type = t;
+	sd->s_dentry = NULL;
+	INIT_LIST_HEAD(&sd->s_children);
+	list_add(&sd->s_sibling, &p->s_children);
+
+	return sd;
+}
diff -puN fs/sysfs/group.c~sysfs-backing-store-add-sysfs_dirent fs/sysfs/group.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/group.c~sysfs-backing-store-add-sysfs_dirent	2004-07-29 15:30:37.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/group.c	2004-07-29 15:30:37.000000000 -0500
@@ -31,7 +31,7 @@ static int create_files(struct dentry * 
 	int error = 0;
 
 	for (attr = grp->attrs; *attr && !error; attr++) {
-		error = sysfs_add_file(dir,*attr);
+		error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
 	}
 	if (error)
 		remove_files(dir,grp);
diff -puN fs/sysfs/symlink.c~sysfs-backing-store-add-sysfs_dirent fs/sysfs/symlink.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/symlink.c~sysfs-backing-store-add-sysfs_dirent	2004-07-29 15:30:37.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/symlink.c	2004-07-29 15:31:07.000000000 -0500
@@ -53,6 +53,39 @@ static void fill_object_path(struct kobj
 	}
 }
 
+static struct sysfs_dirent * 
+sysfs_add_link(struct sysfs_dirent * parent_sd, char * name, 
+		struct kobject * target)
+{
+	struct sysfs_dirent * sd;
+	struct sysfs_symlink * sl;
+	int error = 0;
+
+	error = -ENOMEM;
+	sl = kmalloc(sizeof(*sl), GFP_KERNEL);
+	if (!sl)
+		goto exit1;
+
+	sl->link_name = kmalloc(strlen(name) + 1, GFP_KERNEL);
+	if (!sl->link_name)
+		goto exit2;
+
+	strcpy(sl->link_name, name);
+	sl->target_kobj = kobject_get(target);
+
+	sd = sysfs_new_dirent(parent_sd, sl, SYSFS_KOBJ_LINK);
+	if (sd) {
+		sd->s_mode = S_IFLNK|S_IRWXUGO;
+		return sd;
+	}
+
+	kfree(sl->link_name);
+exit2:
+	kfree(sl);
+exit1:
+	return ERR_PTR(error);
+}
+
 /**
  *	sysfs_create_link - create symlink between two objects.
  *	@kobj:	object whose directory we're creating the link in.
@@ -65,15 +98,28 @@ int sysfs_create_link(struct kobject * k
 	struct dentry * d;
 	int error = 0;
 
+	if (!name)
+		return -EINVAL;
+
 	down(&dentry->d_inode->i_sem);
 	d = sysfs_get_dentry(dentry,name);
 	if (!IS_ERR(d)) {
 		error = sysfs_create(d, S_IFLNK|S_IRWXUGO, init_symlink);
-		if (!error)
-			/* 
-			 * associate the link dentry with the target kobject 
-			 */
-			d->d_fsdata = kobject_get(target);
+		if (!error) {
+			struct sysfs_dirent * sd;
+			sd = sysfs_add_link(dentry->d_fsdata, name, target);
+			if (!IS_ERR(sd)) {
+				/* 
+			 	* associate the link dentry with the target  
+			 	* through the corresponding sysfs_dirent.
+			 	*/
+				d->d_fsdata = sd;
+				sd->s_dentry = dentry;
+			} else {
+				dput(d);
+				error = PTR_ERR(sd);
+			}
+		}
 		dput(d);
 	} else 
 		error = PTR_ERR(d);
diff -puN fs/sysfs/mount.c~sysfs-backing-store-add-sysfs_dirent fs/sysfs/mount.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/mount.c~sysfs-backing-store-add-sysfs_dirent	2004-07-29 15:30:37.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/mount.c	2004-07-29 15:31:16.000000000 -0500
@@ -22,6 +22,13 @@ static struct super_operations sysfs_ops
 	.drop_inode	= generic_delete_inode,
 };
 
+struct sysfs_dirent sysfs_root = {
+	.s_sibling	= LIST_HEAD_INIT(sysfs_root.s_sibling),
+	.s_children	= LIST_HEAD_INIT(sysfs_root.s_children),
+	.s_element	= NULL,
+	.s_type		= SYSFS_ROOT,
+};
+
 static int sysfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct inode *inode;
@@ -50,6 +57,7 @@ static int sysfs_fill_super(struct super
 		iput(inode);
 		return -ENOMEM;
 	}
+	root->d_fsdata = &sysfs_root;
 	sb->s_root = root;
 	return 0;
 }

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
