Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbULBGvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbULBGvR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 01:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbULBGvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 01:51:16 -0500
Received: from [61.48.53.101] ([61.48.53.101]:22503 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261558AbULBGus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 01:50:48 -0500
Date: Wed, 1 Dec 2004 22:41:08 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412020641.iB26f8W26315@adam.yggdrasil.com>
To: maneesh@in.ibm.com
Subject: [Patch?] Teach sysfs_get_name not to use a dentry
Cc: akpm@osdl.org, chrisw@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maneesh,

	The following patch changes syfs_getname to avoid using
sysfs_dirent->s_dentry for getting the names of directories (as
this pointer may be NULL in a future version where sysfs would
be able to release the inode and dentry for each sysfs directory).
It does so by defining different sysfs_dirent.s_type values depending
on whether the diretory represents a kobject or an attribute_group.

	This patch is ground work for unpinning the struct inode
and struct dentry used by each sysfs directory.  The patch also may
facilitate eliminating the sysfs_dentry for each member of an
attribute group.  The patch has no benefits by itself, but I'm posting
it now separately in the hopes of making it easier for people
to spot problems, and, also, because if it is integrated, I think
it will make the rest of the change to unpin directories (which
I have not yet written) easier to understand.

	This patch is against 2.6.10-rc2-bk13 with both Chris Wright's
patch to allocate sysfs_dirent's from a kmem_cache and my patch
for removing sysfs_dirent.s_count already applied (in other words,
bk13 with two patches --> bk13 with three patches).

	I have verified that "find /sys" produces the same output
before and after applying this patch, and I have also been successfully
runing the tests that you previously suggested (loading and unloading
the dummy network device modules with running "ls -lR" on /sys and
cat'ing the files in /sys/class/net, all in a repeating loop).

	Please let me know what you think.  If you could get this
patch integrated and forwarded downstream, that would be great, and
would be a step toward encouraging small incremental patches if you
prefer those when feasible, but it can also wait for the patch to
unpin sysfs directories that is your preference.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
--- linux.prev/include/linux/sysfs.h	2004-12-02 10:14:06.000000000 +0800
+++ linux/include/linux/sysfs.h	2004-12-02 13:27:04.000000000 +0800
@@ -70,10 +70,11 @@
 
 #define SYSFS_ROOT		0x0001
 #define SYSFS_DIR		0x0002
 #define SYSFS_KOBJ_ATTR 	0x0004
 #define SYSFS_KOBJ_BIN_ATTR	0x0008
+#define SYSFS_ATTR_GROUP	0x0010
 #define SYSFS_KOBJ_LINK 	0x0020
 #define SYSFS_NOT_PINNED	(SYSFS_KOBJ_ATTR | SYSFS_KOBJ_BIN_ATTR | SYSFS_KOBJ_LINK)
 
 #ifdef CONFIG_SYSFS
 
diff -u5 linux.prev/fs/sysfs/dir.c linux/fs/sysfs/dir.c
--- linux.prev/fs/sysfs/dir.c	2004-12-02 11:55:02.000000000 +0800
+++ linux/fs/sysfs/dir.c	2004-12-02 13:14:51.000000000 +0800
@@ -89,23 +89,23 @@
 {
 	inode->i_op = &sysfs_symlink_inode_operations;
 	return 0;
 }
 
-static int create_dir(struct kobject * k, struct dentry * p,
-		      const char * n, struct dentry ** d)
+static int create_dir(void *element, struct dentry * p,
+		      const char * n, struct dentry ** d, int type)
 {
 	int error;
 	umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
 
 	down(&p->d_inode->i_sem);
 	*d = sysfs_get_dentry(p,n);
 	if (!IS_ERR(*d)) {
 		error = sysfs_create(*d, mode, init_dir);
 		if (!error) {
-			error = sysfs_make_dirent(p->d_fsdata, *d, k, mode,
-						SYSFS_DIR);
+			error = sysfs_make_dirent(p->d_fsdata, *d, element,
+						  mode, type);
 			if (!error) {
 				p->d_inode->i_nlink++;
 				(*d)->d_op = &sysfs_dentry_ops;
 				d_rehash(*d);
 			}
@@ -118,13 +118,15 @@
 	up(&p->d_inode->i_sem);
 	return error;
 }
 
 
-int sysfs_create_subdir(struct kobject * k, const char * n, struct dentry ** d)
+int sysfs_create_subdir(struct kobject * k,
+			const struct attribute_group *grp,
+			struct dentry ** d)
 {
-	return create_dir(k,k->dentry,n,d);
+	return create_dir(grp, k->dentry, grp->name, d, SYSFS_ATTR_GROUP);
 }
 
 /**
  *	sysfs_create_dir - create a directory for an object.
  *	@parent:	parent parent object.
@@ -144,11 +146,11 @@
 	else if (sysfs_mount && sysfs_mount->mnt_sb)
 		parent = sysfs_mount->mnt_sb->s_root;
 	else
 		return -EFAULT;
 
-	error = create_dir(kobj,parent,kobject_name(kobj),&dentry);
+	error = create_dir(kobj,parent,kobject_name(kobj),&dentry, SYSFS_DIR);
 	if (!error)
 		kobj->dentry = dentry;
 	return error;
 }
 
diff -u5 linux.prev/fs/sysfs/group.c linux/fs/sysfs/group.c
--- linux.prev/fs/sysfs/group.c	2004-11-03 15:09:12.000000000 +0800
+++ linux/fs/sysfs/group.c	2004-12-02 13:16:06.000000000 +0800
@@ -46,11 +46,11 @@
 	int error;
 
 	BUG_ON(!kobj || !kobj->dentry);
 
 	if (grp->name) {
-		error = sysfs_create_subdir(kobj,grp->name,&dir);
+		error = sysfs_create_subdir(kobj, grp, &dir);
 		if (error)
 			return error;
 	} else
 		dir = kobj->dentry;
 	dir = dget(dir);
diff -u5 linux.prev/fs/sysfs/inode.c linux/fs/sysfs/inode.c
--- linux.prev/fs/sysfs/inode.c	2004-12-02 10:14:06.000000000 +0800
+++ linux/fs/sysfs/inode.c	2004-12-02 13:18:22.000000000 +0800
@@ -92,18 +92,24 @@
 const unsigned char * sysfs_get_name(struct sysfs_dirent *sd)
 {
 	struct attribute * attr;
 	struct bin_attribute * bin_attr;
 	struct sysfs_symlink  * sl;
+	struct attribute_group *grp;
+	struct kobject *kobj;
 
 	if (!sd || !sd->s_element)
 		BUG();
 
 	switch (sd->s_type) {
 		case SYSFS_DIR:
-			/* Always have a dentry so use that */
-			return sd->s_dentry->d_name.name;
+			kobj = sd->s_element;
+			return kobj->name;
+
+		case SYSFS_ATTR_GROUP:
+			grp = sd->s_element;
+			return grp->name;
 
 		case SYSFS_KOBJ_ATTR:
 			attr = sd->s_element;
 			return attr->name;
 
diff -u5 linux.prev/fs/sysfs/sysfs.h linux/fs/sysfs/sysfs.h
--- linux.prev/fs/sysfs/sysfs.h	2004-12-02 11:55:02.000000000 +0800
+++ linux/fs/sysfs/sysfs.h	2004-12-02 13:56:51.000000000 +0800
@@ -10,11 +10,11 @@
 extern struct dentry * sysfs_get_dentry(struct dentry *, const char *);
 
 extern int sysfs_add_file(struct dentry *, const struct attribute *, int);
 extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
 
-extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
+extern int sysfs_create_subdir(struct kobject *, const struct attribute_group *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
 
 extern const unsigned char * sysfs_get_name(struct sysfs_dirent *sd);
 extern void sysfs_drop_dentry(struct sysfs_dirent *sd, struct dentry *parent);
 
@@ -32,10 +32,15 @@
 };
 
 static inline struct kobject * to_kobj(struct dentry * dentry)
 {
 	struct sysfs_dirent * sd = dentry->d_fsdata;
+
+	if (sd->s_type == SYSFS_ATTR_GROUP)
+		sd = dentry->d_parent->d_fsdata;
+
+	BUG_ON(sd->s_type != SYSFS_DIR);
 	return ((struct kobject *) sd->s_element);
 }
 
 static inline struct attribute * to_attr(struct dentry * dentry)
 {
@@ -54,10 +59,14 @@
 	struct kobject * kobj = NULL;
 
 	spin_lock(&dcache_lock);
 	if (!d_unhashed(dentry)) {
 		struct sysfs_dirent * sd = dentry->d_fsdata;
+		if (sd->s_type == SYSFS_ATTR_GROUP) {
+			sd = dentry->d_parent->d_fsdata;
+			BUG_ON(sd->s_type != SYSFS_DIR);
+		}
 		if (sd->s_type & SYSFS_KOBJ_LINK) {
 			struct sysfs_symlink * sl = sd->s_element;
 			kobj = kobject_get(sl->target_kobj);
 		} else
 			kobj = kobject_get(sd->s_element);
