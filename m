Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbULCDcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbULCDcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 22:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbULCDcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 22:32:08 -0500
Received: from [61.48.52.229] ([61.48.52.229]:9711 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261916AbULCDae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 22:30:34 -0500
Date: Thu, 2 Dec 2004 19:20:35 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412030320.iB33KZI03215@adam.yggdrasil.com>
To: maneesh@in.ibm.com
Subject: [Patch] Do not allocate sysfs_dirent.s_children for non-directories
Cc: akpm@osdl.org, chrisw@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The following patch, against a heavily hacked 2.6.10-rc2-bk15
sysfs tree, removes the s_children field from sysfs_dirent and
creates a new structure just for directories named sysfs_dir, which
embeds a sysfs_dirent and also adds s_children.  Directories allocate
a sysfs_dir; non-directories allocate a sysfs_dirent.  There are
two separate kmem caches for the different data types.

	Not allocating s_children from each non-directory saves
two pointers (8 bytes) for each of the 2573 non-directory nodes
in my sysfs tree, or about 20kB on unswappable memory, but
having another kmem cache probably wastes an average of half
a page in memory fragmentation and then there is are few
bytes from the new code and the additional kmem_cache_t
structure, so I would guess it probably saves about 16kB in
practice.

	In the future, I hope to make a similar change for symbolic
links.

	By the way, this patch will also make it easier for me to
try to unpin sysfs directories because there are a few other
fields specific to directories that I would want to store
in sysfs_dir.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l

diff -u5 linux.prev/fs/sysfs/dir.c linux/fs/sysfs/dir.c
--- linux.prev/fs/sysfs/dir.c	2004-12-02 14:51:01.000000000 +0800
+++ linux/fs/sysfs/dir.c	2004-12-03 10:36:20.000000000 +0800
@@ -29,38 +29,46 @@
 };
 
 /*
  * Allocates a new sysfs_dirent and links it to the parent sysfs_dirent
  */
-static struct sysfs_dirent * sysfs_new_dirent(struct sysfs_dirent * parent_sd,
-						void * element)
+static struct sysfs_dirent * sysfs_new_dirent(struct sysfs_dir * parent_sd,
+					      void * element, int type)
 {
 	struct sysfs_dirent * sd;
 
-	sd = kmem_cache_alloc(sysfs_dir_cachep, GFP_KERNEL);
-	if (!sd)
-		return NULL;
+	if (sysfs_type_dir(type)) {
+		struct sysfs_dir * sdir;
+		sdir = kmem_cache_alloc(sysfs_dir_cachep, GFP_KERNEL);
+		if (!sdir)
+			return NULL;
+		INIT_LIST_HEAD(&sdir->s_children);
+		sd = &sdir->s_ent;
+	} else {
+		sd = kmem_cache_alloc(sysfs_dirent_cachep, GFP_KERNEL);
+		if (!sd)
+			return NULL;
+	}
 
 	memset(sd, 0, sizeof(*sd));
-	INIT_LIST_HEAD(&sd->s_children);
 	list_add(&sd->s_sibling, &parent_sd->s_children);
 	sd->s_element = element;
+	sd->s_type = type;
 
 	return sd;
 }
 
-int sysfs_make_dirent(struct sysfs_dirent * parent_sd, struct dentry * dentry,
+int sysfs_make_dirent(struct sysfs_dir * parent_sd, struct dentry * dentry,
 			void * element, umode_t mode, int type)
 {
 	struct sysfs_dirent * sd;
 
-	sd = sysfs_new_dirent(parent_sd, element);
+	sd = sysfs_new_dirent(parent_sd, element, type);
 	if (!sd)
 		return -ENOMEM;
 
 	sd->s_mode = mode;
-	sd->s_type = type;
 	sd->s_dentry = dentry;
 	if (dentry) {
 		dentry->d_fsdata = sd;
 		dentry->d_op = &sysfs_dentry_ops;
 	}
@@ -94,17 +102,19 @@
 static int create_dir(void *element, struct dentry * p,
 		      const char * n, struct dentry ** d, int type)
 {
 	int error;
 	umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
+	struct sysfs_dir *parent_sd;
 
 	down(&p->d_inode->i_sem);
 	*d = sysfs_get_dentry(p,n);
 	if (!IS_ERR(*d)) {
 		error = sysfs_create(*d, mode, init_dir);
 		if (!error) {
-			error = sysfs_make_dirent(p->d_fsdata, *d, element,
+			parent_sd = dentry_to_sysfs_dir(p);
+			error = sysfs_make_dirent(parent_sd, *d, element,
 						  mode, type);
 			if (!error) {
 				p->d_inode->i_nlink++;
 				(*d)->d_op = &sysfs_dentry_ops;
 				d_rehash(*d);
@@ -122,11 +132,12 @@
 
 int sysfs_create_subdir(struct kobject * k,
 			const struct attribute_group *grp,
 			struct dentry ** d)
 {
-	return create_dir(grp, k->dentry, grp->name, d, SYSFS_ATTR_GROUP);
+	return create_dir((void*)grp, k->dentry, grp->name, d,
+			  SYSFS_ATTR_GROUP);
 }
 
 /**
  *	sysfs_create_dir - create a directory for an object.
  *	@parent:	parent parent object.
@@ -203,11 +214,11 @@
 }
 
 static struct dentry * sysfs_lookup(struct inode *dir, struct dentry *dentry,
 				struct nameidata *nd)
 {
-	struct sysfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
+	struct sysfs_dir * parent_sd = dentry_to_sysfs_dir(dentry->d_parent);
 	struct sysfs_dirent * sd;
 	int err = 0;
 
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (sd->s_type & SYSFS_NOT_PINNED) {
@@ -267,20 +278,20 @@
  */
 
 void sysfs_remove_dir(struct kobject * kobj)
 {
 	struct dentry * dentry = dget(kobj->dentry);
-	struct sysfs_dirent * parent_sd;
+	struct sysfs_dir * parent_sd;
 	struct sysfs_dirent * sd, * tmp;
 
 	if (!dentry)
 		return;
 
 	pr_debug("sysfs %s: removing dir\n",dentry->d_name.name);
 	down(&dentry->d_inode->i_sem);
-	parent_sd = dentry->d_fsdata;
-	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
+	parent_sd = dentry_to_sysfs_dir(dentry);
+	list_for_each_entry_safe(sd,tmp,&parent_sd->s_children,s_sibling) {
 		if (!sd->s_element || !(sd->s_type & SYSFS_NOT_PINNED))
 			continue;
 		sysfs_drop_dentry(sd, dentry);
 		list_del_init(&sd->s_sibling);
 		sysfs_put(sd);
@@ -331,14 +342,14 @@
 }
 
 static int sysfs_dir_open(struct inode *inode, struct file *file)
 {
 	struct dentry * dentry = file->f_dentry;
-	struct sysfs_dirent * parent_sd = dentry->d_fsdata;
+	struct sysfs_dir * parent_sd = dentry_to_sysfs_dir(dentry);
 
 	down(&dentry->d_inode->i_sem);
-	file->private_data = sysfs_new_dirent(parent_sd, NULL);
+	file->private_data = sysfs_new_dirent(parent_sd, NULL, SYSFS_CURSOR);
 	up(&dentry->d_inode->i_sem);
 
 	return file->private_data ? 0 : -ENOMEM;
 
 }
@@ -350,10 +361,13 @@
 
 	down(&dentry->d_inode->i_sem);
 	list_del_init(&cursor->s_sibling);
 	up(&dentry->d_inode->i_sem);
 
+	BUG_ON(cursor->s_dentry != NULL);
+	release_sysfs_dirent(cursor);
+
 	return 0;
 }
 
 /* Relationship between s_mode and the DT_xxx types */
 static inline unsigned char dt_type(struct sysfs_dirent *sd)
@@ -362,11 +376,11 @@
 }
 
 static int sysfs_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
 	struct dentry *dentry = filp->f_dentry;
-	struct sysfs_dirent * parent_sd = dentry->d_fsdata;
+	struct sysfs_dir * parent_sd = dentry_to_sysfs_dir(dentry);
 	struct sysfs_dirent *cursor = filp->private_data;
 	struct list_head *p, *q = &cursor->s_sibling;
 	ino_t ino;
 	int i = filp->f_pos;
 
@@ -395,10 +409,11 @@
 				const char * name;
 				int len;
 
 				next = list_entry(p, struct sysfs_dirent,
 						   s_sibling);
+
 				if (!next->s_element)
 					continue;
 
 				name = sysfs_get_name(next);
 				len = strlen(name);
@@ -436,11 +451,11 @@
 			return -EINVAL;
 	}
 	if (offset != file->f_pos) {
 		file->f_pos = offset;
 		if (file->f_pos >= 2) {
-			struct sysfs_dirent *sd = dentry->d_fsdata;
+			struct sysfs_dir *sd = dentry_to_sysfs_dir(dentry);
 			struct sysfs_dirent *cursor = file->private_data;
 			struct list_head *p;
 			loff_t n = file->f_pos - 2;
 
 			list_del(&cursor->s_sibling);
diff -u5 linux.prev/fs/sysfs/file.c linux/fs/sysfs/file.c
--- linux.prev/fs/sysfs/file.c	2004-11-07 13:02:53.000000000 +0800
+++ linux/fs/sysfs/file.c	2004-12-02 23:19:56.000000000 +0800
@@ -355,11 +355,11 @@
 };
 
 
 int sysfs_add_file(struct dentry * dir, const struct attribute * attr, int type)
 {
-	struct sysfs_dirent * parent_sd = dir->d_fsdata;
+	struct sysfs_dir * parent_sd = dentry_to_sysfs_dir(dir);
 	umode_t mode = (attr->mode & S_IALLUGO) | S_IFREG;
 	int error = 0;
 
 	down(&dir->d_inode->i_sem);
 	error = sysfs_make_dirent(parent_sd, NULL, (void *) attr, mode, type);
diff -u5 linux.prev/fs/sysfs/inode.c linux/fs/sysfs/inode.c
--- linux.prev/fs/sysfs/inode.c	2004-12-02 14:51:01.000000000 +0800
+++ linux/fs/sysfs/inode.c	2004-12-03 00:43:39.000000000 +0800
@@ -146,11 +146,11 @@
 }
 
 void sysfs_hash_and_remove(struct dentry * dir, const char * name)
 {
 	struct sysfs_dirent * sd;
-	struct sysfs_dirent * parent_sd = dir->d_fsdata;
+	struct sysfs_dir * parent_sd = dentry_to_sysfs_dir(dir);
 
 	down(&dir->d_inode->i_sem);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (!sd->s_element)
 			continue;
diff -u5 linux.prev/fs/sysfs/mount.c linux/fs/sysfs/mount.c
--- linux.prev/fs/sysfs/mount.c	2004-12-02 11:55:02.000000000 +0800
+++ linux/fs/sysfs/mount.c	2004-12-02 23:27:39.000000000 +0800
@@ -15,21 +15,24 @@
 #define SYSFS_MAGIC 0x62656572
 
 struct vfsmount *sysfs_mount;
 struct super_block * sysfs_sb = NULL;
 kmem_cache_t *sysfs_dir_cachep;
+kmem_cache_t *sysfs_dirent_cachep;
 
 static struct super_operations sysfs_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
 };
 
-static struct sysfs_dirent sysfs_root = {
-	.s_sibling	= LIST_HEAD_INIT(sysfs_root.s_sibling),
+static struct sysfs_dir sysfs_root = {
 	.s_children	= LIST_HEAD_INIT(sysfs_root.s_children),
-	.s_element	= NULL,
-	.s_type		= SYSFS_ROOT,
+	.s_ent		= {
+		.s_sibling	= LIST_HEAD_INIT(sysfs_root.s_ent.s_sibling),
+		.s_element	= NULL,
+		.s_type		= SYSFS_ROOT,
+	}
 };
 
 static int sysfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct inode *inode;
@@ -56,11 +59,11 @@
 	if (!root) {
 		pr_debug("%s: could not get root dentry!\n",__FUNCTION__);
 		iput(inode);
 		return -ENOMEM;
 	}
-	root->d_fsdata = &sysfs_root;
+	root->d_fsdata = &sysfs_root.s_ent;
 	sb->s_root = root;
 	return 0;
 }
 
 static struct super_block *sysfs_get_sb(struct file_system_type *fs_type,
@@ -77,16 +80,22 @@
 
 int __init sysfs_init(void)
 {
 	int err = -ENOMEM;
 
-	sysfs_dir_cachep = kmem_cache_create("sysfs_dir_cache",
-					      sizeof(struct sysfs_dirent),
+	sysfs_dir_cachep = kmem_cache_create("sysfs_dir",
+					      sizeof(struct sysfs_dir),
 					      0, 0, NULL, NULL);
 	if (!sysfs_dir_cachep)
 		goto out;
 
+	sysfs_dirent_cachep = kmem_cache_create("sysfs_dirent",
+					      sizeof(struct sysfs_dirent),
+					      0, 0, NULL, NULL);
+	if (!sysfs_dirent_cachep)
+		goto out_no_dirent_cachep;
+
 	err = register_filesystem(&sysfs_fs_type);
 	if (!err) {
 		sysfs_mount = kern_mount(&sysfs_fs_type);
 		if (IS_ERR(sysfs_mount)) {
 			printk(KERN_ERR "sysfs: could not mount!\n");
@@ -97,8 +106,10 @@
 	} else
 		goto out_err;
 out:
 	return err;
 out_err:
+	kmem_cache_destroy(sysfs_dirent_cachep);
+out_no_dirent_cachep:
 	kmem_cache_destroy(sysfs_dir_cachep);
 	goto out;
 }
diff -u5 linux.prev/fs/sysfs/symlink.c linux/fs/sysfs/symlink.c
--- linux.prev/fs/sysfs/symlink.c	2004-11-07 13:02:53.000000000 +0800
+++ linux/fs/sysfs/symlink.c	2004-12-02 23:57:01.000000000 +0800
@@ -43,11 +43,11 @@
 	}
 }
 
 static int sysfs_add_link(struct dentry * parent, char * name, struct kobject * target)
 {
-	struct sysfs_dirent * parent_sd = parent->d_fsdata;
+	struct sysfs_dir * parent_sd = dentry_to_sysfs_dir(parent);
 	struct sysfs_symlink * sl;
 	int error = 0;
 
 	error = -ENOMEM;
 	sl = kmalloc(sizeof(*sl), GFP_KERNEL);
diff -u5 linux.prev/fs/sysfs/sysfs.h linux/fs/sysfs/sysfs.h
--- linux.prev/fs/sysfs/sysfs.h	2004-12-02 15:29:39.000000000 +0800
+++ linux/fs/sysfs/sysfs.h	2004-12-03 00:51:44.000000000 +0800
@@ -1,32 +1,38 @@
 #include <linux/time.h>
 #include <linux/sysfs.h>
 
+#define SYSFS_CURSOR		0
 #define SYSFS_ROOT		0x0001
 #define SYSFS_DIR		0x0002
 #define SYSFS_KOBJ_ATTR 	0x0004
 #define SYSFS_KOBJ_BIN_ATTR	0x0008
 #define SYSFS_ATTR_GROUP	0x0010
 #define SYSFS_KOBJ_LINK 	0x0020
 #define SYSFS_NOT_PINNED	(SYSFS_KOBJ_ATTR | SYSFS_KOBJ_BIN_ATTR | SYSFS_KOBJ_LINK)
 
 struct sysfs_dirent {
 	struct list_head	s_sibling;
-	struct list_head	s_children;
 	void 			* s_element;
-	int			s_type;
+	unsigned short		s_type;
 	umode_t			s_mode;
 	struct dentry		* s_dentry;
 };
 
+struct sysfs_dir {
+	struct list_head	s_children;
+	struct sysfs_dirent	s_ent;
+};
+
 extern struct vfsmount * sysfs_mount;
 extern kmem_cache_t *sysfs_dir_cachep;
+extern kmem_cache_t *sysfs_dirent_cachep;
 
 extern struct inode * sysfs_new_inode(mode_t mode);
 extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
 
-extern int sysfs_make_dirent(struct sysfs_dirent *, struct dentry *, void *,
+extern int sysfs_make_dirent(struct sysfs_dir *, struct dentry *, void *,
 				umode_t, int);
 extern struct dentry * sysfs_get_dentry(struct dentry *, const char *);
 
 extern int sysfs_add_file(struct dentry *, const struct attribute *, int);
 extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
@@ -48,10 +54,29 @@
 struct sysfs_symlink {
 	char * link_name;
 	struct kobject * target_kobj;
 };
 
+static inline int sysfs_type_dir(int s_type)
+{
+	return (s_type == SYSFS_DIR ||
+		s_type == SYSFS_ATTR_GROUP ||
+		s_type == SYSFS_ROOT);
+}
+
+static inline struct sysfs_dir * to_sysfs_dir(struct sysfs_dirent *ent)
+{
+	BUG_ON(!sysfs_type_dir(ent->s_type));
+	return container_of(ent, struct sysfs_dir, s_ent);
+}
+
+static inline struct sysfs_dir *dentry_to_sysfs_dir(struct dentry * dentry)
+{
+	struct sysfs_dirent * sd = dentry->d_fsdata;
+	return to_sysfs_dir(sd);
+}
+
 static inline struct kobject * to_kobj(struct dentry * dentry)
 {
 	struct sysfs_dirent * sd = dentry->d_fsdata;
 
 	if (sd->s_type == SYSFS_ATTR_GROUP)
@@ -101,11 +126,14 @@
 		struct sysfs_symlink * sl = sd->s_element;
 		kfree(sl->link_name);
 		kobject_put(sl->target_kobj);
 		kfree(sl);
 	}
-	kmem_cache_free(sysfs_dir_cachep, sd);
+	if (sysfs_type_dir(sd->s_type))
+		kmem_cache_free(sysfs_dir_cachep, to_sysfs_dir(sd));
+	else
+		kmem_cache_free(sysfs_dirent_cachep, sd);
 }
 
 static inline void sysfs_put(struct sysfs_dirent * sd)
 {
 	if (list_empty(&sd->s_sibling) && sd->s_dentry == NULL)
