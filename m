Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263198AbUKAXL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263198AbUKAXL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S381277AbUKAXK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:10:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:4516 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S323699AbUKAV7S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:59:18 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <10993462752309@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Mon, 1 Nov 2004 13:57:56 -0800
Message-Id: <10993462761688@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2441, 2004/11/01 13:03:13-08:00, akpm@osdl.org

[PATCH] sysfs backing store - add sysfs_direct structure

From: Maneesh Soni <maneesh@in.ibm.com>

o This patch introduces the new sysfs_dirent data structure. The sysfs_dirent
  is added to the dentry corresponding to each of the element which can be
  represented in sysfs like, kobject (directory), text or binary attributes
  (files), attribute groups (directory) and symlinks.

o It uses dentry's d_fsdata field to attach the corresponding sysfs_dirent.

o The sysfs_dirents are maintained in a tree of all the sysfs entries using the
  s_children and s_sibling list pointers.

o This patch also changes how we access attributes and kobjects in
  file_operations from a given dentry, basically introducing one more level of
  indirection.

o The sysfs_dirents are freed and the sysfs_dirent tree is updated accordingly
  upon the deletion of corresponding dentry. The sysfs dirents are kept alive
  as long as there is corresponding dentry around. The are freed when the
  dentry is finally out of dcache using the ->d_iput() method.

o This also fixes the dentry leaks in case of error paths after sysfs has
  got a newly alocated (and hashed) dentry from sysfs_get_dentry() by
  d_drop()'ing the dentry.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/bin.c        |   14 ++++----
 fs/sysfs/dir.c        |   84 ++++++++++++++++++++++++++++++++++++++++++++------
 fs/sysfs/file.c       |   25 ++++++++------
 fs/sysfs/group.c      |    4 +-
 fs/sysfs/inode.c      |   10 ++++-
 fs/sysfs/mount.c      |    8 ++++
 fs/sysfs/symlink.c    |   39 ++++++++++++++++++++---
 fs/sysfs/sysfs.h      |   39 +++++++++++++++++++----
 include/linux/sysfs.h |   19 +++++++++++
 9 files changed, 204 insertions(+), 38 deletions(-)


diff -Nru a/fs/sysfs/bin.c b/fs/sysfs/bin.c
--- a/fs/sysfs/bin.c	2004-11-01 13:37:18 -08:00
+++ b/fs/sysfs/bin.c	2004-11-01 13:37:18 -08:00
@@ -160,24 +160,26 @@
 {
 	struct dentry * dentry;
 	struct dentry * parent;
+	umode_t mode = (attr->attr.mode & S_IALLUGO) | S_IFREG;
 	int error = 0;
 
-	if (!kobj || !attr)
-		return -EINVAL;
+	BUG_ON(!kobj || !kobj->dentry || !attr);
 
 	parent = kobj->dentry;
 
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
+			error = sysfs_make_dirent(parent->d_fsdata, dentry,
+						  (void *) attr, mode,
+						  SYSFS_KOBJ_BIN_ATTR);
 		}
+		if (error)
+			d_drop(dentry);
 		dput(dentry);
 	} else
 		error = PTR_ERR(dentry);
diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	2004-11-01 13:37:18 -08:00
+++ b/fs/sysfs/dir.c	2004-11-01 13:37:18 -08:00
@@ -12,6 +12,61 @@
 
 DECLARE_RWSEM(sysfs_rename_sem);
 
+static void sysfs_d_iput(struct dentry * dentry, struct inode * inode)
+{
+	struct sysfs_dirent * sd = dentry->d_fsdata;
+
+	if (sd) {
+		BUG_ON(sd->s_dentry != dentry);
+		sd->s_dentry = NULL;
+		release_sysfs_dirent(sd);
+	}
+	iput(inode);
+}
+
+static struct dentry_operations sysfs_dentry_ops = {
+	.d_iput		= sysfs_d_iput,
+};
+
+/*
+ * Allocates a new sysfs_dirent and links it to the parent sysfs_dirent
+ */
+static struct sysfs_dirent * sysfs_new_dirent(struct sysfs_dirent * parent_sd,
+						void * element)
+{
+	struct sysfs_dirent * sd;
+
+	sd = kmalloc(sizeof(*sd), GFP_KERNEL);
+	if (!sd)
+		return ERR_PTR(-ENOMEM);
+
+	memset(sd, 0, sizeof(*sd));
+	atomic_set(&sd->s_count, 1);
+	INIT_LIST_HEAD(&sd->s_children);
+	list_add(&sd->s_sibling, &parent_sd->s_children);
+	sd->s_element = element;
+
+	return sd;
+}
+
+int sysfs_make_dirent(struct sysfs_dirent * parent_sd, struct dentry * dentry,
+			void * element, umode_t mode, int type)
+{
+	struct sysfs_dirent * sd;
+
+	sd = sysfs_new_dirent(parent_sd, element);
+	if (!sd)
+		return -ENOMEM;
+
+	sd->s_mode = mode;
+	sd->s_type = type;
+	sd->s_dentry = dentry;
+	dentry->d_fsdata = sd;
+	dentry->d_op = &sysfs_dentry_ops;
+
+	return 0;
+}
+
 static int init_dir(struct inode * inode)
 {
 	inode->i_op = &simple_dir_inode_operations;
@@ -27,17 +82,20 @@
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
+			error = sysfs_make_dirent(p->d_fsdata, *d, k, mode,
+						SYSFS_DIR);
+			if (!error)
+				p->d_inode->i_nlink++;
 		}
+		if (error)
+			d_drop(*d);
 		dput(*d);
 	} else
 		error = PTR_ERR(*d);
@@ -63,8 +121,7 @@
 	struct dentry * parent;
 	int error = 0;
 
-	if (!kobj)
-		return -EINVAL;
+	BUG_ON(!kobj);
 
 	if (kobj->parent)
 		parent = kobj->parent->dentry;
@@ -83,8 +140,12 @@
 static void remove_dir(struct dentry * d)
 {
 	struct dentry * parent = dget(d->d_parent);
+	struct sysfs_dirent * sd;
+
 	down(&parent->d_inode->i_sem);
 	d_delete(d);
+	sd = d->d_fsdata;
+ 	list_del_init(&sd->s_sibling);
 	if (d->d_inode)
 		simple_rmdir(parent->d_inode,d);
 
@@ -130,6 +191,7 @@
 		node = node->next;
 		pr_debug(" o %s (%d): ",d->d_name.name,atomic_read(&d->d_count));
 		if (!d_unhashed(d) && (d->d_inode)) {
+			struct sysfs_dirent * sd = d->d_fsdata;
 			d = dget_locked(d);
 			pr_debug("removing");
 
@@ -142,8 +204,9 @@
 			 * a symlink
 			 */
 			if (S_ISLNK(d->d_inode->i_mode))
-				kobject_put(d->d_fsdata);
+				kobject_put(sd->s_element);
 			
+			list_del_init(&sd->s_sibling);
 			simple_unlink(dentry->d_inode,d);
 			dput(d);
 			pr_debug(" done\n");
@@ -184,7 +247,10 @@
 			error = kobject_set_name(kobj, "%s", new_name);
 			if (!error)
 				d_move(kobj->dentry, new_dentry);
-		}
+			else
+				d_drop(new_dentry);
+		} else
+			error = -EEXIST;
 		dput(new_dentry);
 	}
 	up(&parent->d_inode->i_sem);	
diff -Nru a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c	2004-11-01 13:37:18 -08:00
+++ b/fs/sysfs/file.c	2004-11-01 13:37:18 -08:00
@@ -346,19 +346,22 @@
 };
 
 
-int sysfs_add_file(struct dentry * dir, const struct attribute * attr)
+int sysfs_add_file(struct dentry * dir, const struct attribute * attr, int type)
 {
 	struct dentry * dentry;
-	int error;
+	struct sysfs_dirent * parent_sd = dir->d_fsdata;
+	umode_t mode = (attr->mode & S_IALLUGO) | S_IFREG;
+	int error = 0;
 
 	down(&dir->d_inode->i_sem);
 	dentry = sysfs_get_dentry(dir,attr->name);
 	if (!IS_ERR(dentry)) {
-		error = sysfs_create(dentry,
-				     (attr->mode & S_IALLUGO) | S_IFREG,
-				     init_file);
+		error = sysfs_create(dentry, mode, init_file);
 		if (!error)
-			dentry->d_fsdata = (void *)attr;
+			error = sysfs_make_dirent(parent_sd, dentry,
+						(void *) attr, mode, type);
+		if (error)
+			d_drop(dentry);
 		dput(dentry);
 	} else
 		error = PTR_ERR(dentry);
@@ -375,9 +378,10 @@
 
 int sysfs_create_file(struct kobject * kobj, const struct attribute * attr)
 {
-	if (kobj && attr)
-		return sysfs_add_file(kobj->dentry,attr);
-	return -EINVAL;
+	BUG_ON(!kobj || !kobj->dentry || !attr);
+
+	return sysfs_add_file(kobj->dentry, attr, SYSFS_KOBJ_ATTR);
+
 }
 
 
@@ -409,7 +413,8 @@
 			 */
 			dput(victim);
 			res = 0;
-		}
+		} else
+			d_drop(victim);
 		
 		/**
 		 * Drop the reference acquired from sysfs_get_dentry() above.
diff -Nru a/fs/sysfs/group.c b/fs/sysfs/group.c
--- a/fs/sysfs/group.c	2004-11-01 13:37:18 -08:00
+++ b/fs/sysfs/group.c	2004-11-01 13:37:18 -08:00
@@ -31,7 +31,7 @@
 	int error = 0;
 
 	for (attr = grp->attrs; *attr && !error; attr++) {
-		error = sysfs_add_file(dir,*attr);
+		error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
 	}
 	if (error)
 		remove_files(dir,grp);
@@ -44,6 +44,8 @@
 {
 	struct dentry * dir;
 	int error;
+
+	BUG_ON(!kobj || !kobj->dentry);
 
 	if (grp->name) {
 		error = sysfs_create_subdir(kobj,grp->name,&dir);
diff -Nru a/fs/sysfs/inode.c b/fs/sysfs/inode.c
--- a/fs/sysfs/inode.c	2004-11-01 13:37:18 -08:00
+++ b/fs/sysfs/inode.c	2004-11-01 13:37:18 -08:00
@@ -11,6 +11,8 @@
 #include <linux/pagemap.h>
 #include <linux/namei.h>
 #include <linux/backing-dev.h>
+#include "sysfs.h"
+
 extern struct super_block * sysfs_sb;
 
 static struct address_space_operations sysfs_aops = {
@@ -91,6 +93,7 @@
 void sysfs_hash_and_remove(struct dentry * dir, const char * name)
 {
 	struct dentry * victim;
+	struct sysfs_dirent * sd;
 
 	down(&dir->d_inode->i_sem);
 	victim = sysfs_get_dentry(dir,name);
@@ -101,14 +104,17 @@
 			pr_debug("sysfs: Removing %s (%d)\n", victim->d_name.name,
 				 atomic_read(&victim->d_count));
 
+			sd = victim->d_fsdata;
 			d_drop(victim);
 			/* release the target kobject in case of 
 			 * a symlink
 			 */
 			if (S_ISLNK(victim->d_inode->i_mode))
-				kobject_put(victim->d_fsdata);
+				kobject_put(sd->s_element);
+			list_del_init(&sd->s_sibling);
 			simple_unlink(dir->d_inode,victim);
-		}
+		} else
+			d_drop(victim);
 		/*
 		 * Drop reference from sysfs_get_dentry() above.
 		 */
diff -Nru a/fs/sysfs/mount.c b/fs/sysfs/mount.c
--- a/fs/sysfs/mount.c	2004-11-01 13:37:18 -08:00
+++ b/fs/sysfs/mount.c	2004-11-01 13:37:18 -08:00
@@ -22,6 +22,13 @@
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
@@ -50,6 +57,7 @@
 		iput(inode);
 		return -ENOMEM;
 	}
+	root->d_fsdata = &sysfs_root;
 	sb->s_root = root;
 	return 0;
 }
diff -Nru a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
--- a/fs/sysfs/symlink.c	2004-11-01 13:37:18 -08:00
+++ b/fs/sysfs/symlink.c	2004-11-01 13:37:18 -08:00
@@ -55,6 +55,36 @@
 	}
 }
 
+static int sysfs_add_link(struct dentry * dentry, char * name, struct kobject * target)
+{
+	struct sysfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
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
+	error = sysfs_make_dirent(parent_sd, dentry, sl, S_IFLNK|S_IRWXUGO,
+				SYSFS_KOBJ_LINK);
+	if (!error)
+		return 0;
+
+	kfree(sl->link_name);
+exit2:
+	kfree(sl);
+exit1:
+	return error;
+}
+
 /**
  *	sysfs_create_link - create symlink between two objects.
  *	@kobj:	object whose directory we're creating the link in.
@@ -67,15 +97,16 @@
 	struct dentry * d;
 	int error = 0;
 
+	BUG_ON(!kobj || !kobj->dentry || !name);
+
 	down(&dentry->d_inode->i_sem);
 	d = sysfs_get_dentry(dentry,name);
 	if (!IS_ERR(d)) {
 		error = sysfs_create(d, S_IFLNK|S_IRWXUGO, init_symlink);
 		if (!error)
-			/* 
-			 * associate the link dentry with the target kobject 
-			 */
-			d->d_fsdata = kobject_get(target);
+			error = sysfs_add_link(d, name, target);
+		if (error)
+			d_drop(d);
 		dput(d);
 	} else 
 		error = PTR_ERR(d);
diff -Nru a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
--- a/fs/sysfs/sysfs.h	2004-11-01 13:37:18 -08:00
+++ b/fs/sysfs/sysfs.h	2004-11-01 13:37:18 -08:00
@@ -4,9 +4,11 @@
 extern struct inode * sysfs_new_inode(mode_t mode);
 extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
 
+extern int sysfs_make_dirent(struct sysfs_dirent *, struct dentry *, void *,
+				umode_t, int);
 extern struct dentry * sysfs_get_dentry(struct dentry *, const char *);
 
-extern int sysfs_add_file(struct dentry * dir, const struct attribute * attr);
+extern int sysfs_add_file(struct dentry *, const struct attribute *, int);
 extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
 
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
@@ -16,19 +18,27 @@
 extern void sysfs_put_link(struct dentry *, struct nameidata *);
 extern struct rw_semaphore sysfs_rename_sem;
 
+struct sysfs_symlink {
+	char * link_name;
+	struct kobject * target_kobj;
+};
+
 static inline struct kobject * to_kobj(struct dentry * dentry)
 {
-	return ((struct kobject *) dentry->d_fsdata);
+	struct sysfs_dirent * sd = dentry->d_fsdata;
+	return ((struct kobject *) sd->s_element);
 }
 
 static inline struct attribute * to_attr(struct dentry * dentry)
 {
-	return ((struct attribute *) dentry->d_fsdata);
+	struct sysfs_dirent * sd = dentry->d_fsdata;
+	return ((struct attribute *) sd->s_element);
 }
 
 static inline struct bin_attribute * to_bin_attr(struct dentry * dentry)
 {
-	return ((struct bin_attribute *) dentry->d_fsdata);
+	struct sysfs_dirent * sd = dentry->d_fsdata;
+	return ((struct bin_attribute *) sd->s_element);
 }
 
 static inline struct kobject *sysfs_get_kobject(struct dentry *dentry)
@@ -36,10 +46,27 @@
 	struct kobject * kobj = NULL;
 
 	spin_lock(&dcache_lock);
-	if (!d_unhashed(dentry))
-		kobj = kobject_get(to_kobj(dentry));
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
+}
+
+static inline void release_sysfs_dirent(struct sysfs_dirent * sd)
+{
+	if (sd->s_type & SYSFS_KOBJ_LINK) {
+		struct sysfs_symlink * sl = sd->s_element;
+		kfree(sl->link_name);
+		kobject_put(sl->target_kobj);
+		kfree(sl);
+	}
+	kfree(sd);
 }
 
diff -Nru a/include/linux/sysfs.h b/include/linux/sysfs.h
--- a/include/linux/sysfs.h	2004-11-01 13:37:18 -08:00
+++ b/include/linux/sysfs.h	2004-11-01 13:37:18 -08:00
@@ -9,6 +9,8 @@
 #ifndef _SYSFS_H_
 #define _SYSFS_H_
 
+#include <asm/atomic.h>
+
 struct kobject;
 struct module;
 
@@ -56,6 +58,23 @@
 	ssize_t	(*show)(struct kobject *, struct attribute *,char *);
 	ssize_t	(*store)(struct kobject *,struct attribute *,const char *, size_t);
 };
+
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
+#define SYSFS_DIR		0x0002
+#define SYSFS_KOBJ_ATTR 	0x0004
+#define SYSFS_KOBJ_BIN_ATTR	0x0008
+#define SYSFS_KOBJ_LINK 	0x0020
+#define SYSFS_NOT_PINNED	(SYSFS_KOBJ_ATTR | SYSFS_KOBJ_BIN_ATTR | SYSFS_KOBJ_LINK)
 
 #ifdef CONFIG_SYSFS
 

