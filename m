Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTKLM0e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 07:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbTKLM0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 07:26:34 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:15863 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261890AbTKLM00
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 07:26:26 -0500
Date: Wed, 12 Nov 2003 17:55:03 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@osdl.org>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC 1/5] sysfs-backing-store.patch
Message-ID: <20031112122503.GE14580@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031112122344.GD14580@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112122344.GD14580@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o This patch describes the necessary data structures needed for sysfs backing
  store and the changes related to initialing sysfs filesystem. sysfs_dirent
  represents any element from kobject infrastructure. The element could be
  kobject, attribute, binary attribute, attribute group or symlink. kobject
  hierarchy is represented by using sysfs_dirent's s_children & s_sibling
  links. 

o Root of sysfs filesystem is represented by statically allocated sysfs_dirent
  structure. Initialisation now does not mount sysfs filesystem and just
  does registration.

o The patch also has some support routines internal to sysfs code.


 fs/sysfs/mount.c        |   41 ++++++++++---------
 fs/sysfs/sysfs.h        |  103 ++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/kobject.h |    2 
 include/linux/sysfs.h   |   19 ++++++++
 4 files changed, 142 insertions(+), 23 deletions(-)

diff -puN include/linux/kobject.h~sysfs-backing-store include/linux/kobject.h
--- linux-2.6.0-test9/include/linux/kobject.h~sysfs-backing-store	2003-11-12 16:02:27.000000000 +0530
+++ linux-2.6.0-test9-maneesh/include/linux/kobject.h	2003-11-12 16:02:27.000000000 +0530
@@ -31,7 +31,7 @@ struct kobject {
 	struct kobject		* parent;
 	struct kset		* kset;
 	struct kobj_type	* ktype;
-	struct dentry		* dentry;
+	struct sysfs_dirent	* s_dirent;
 };
 
 extern int kobject_set_name(struct kobject *, const char *, ...)
diff -puN include/linux/sysfs.h~sysfs-backing-store include/linux/sysfs.h
--- linux-2.6.0-test9/include/linux/sysfs.h~sysfs-backing-store	2003-11-12 16:02:27.000000000 +0530
+++ linux-2.6.0-test9-maneesh/include/linux/sysfs.h	2003-11-12 16:14:56.000000000 +0530
@@ -9,6 +9,8 @@
 #ifndef _SYSFS_H_
 #define _SYSFS_H_
 
+#include <linux/rwsem.h>
+
 struct kobject;
 struct module;
 
@@ -63,6 +65,23 @@ struct attribute_group {
 	struct attribute	** attrs;
 };
 
+struct sysfs_dirent {
+	struct list_head	s_sibling;  
+	struct list_head	s_children;
+	void 			* s_element;
+	struct dentry		* s_dentry;
+	int			s_type;
+	struct rw_semaphore	s_rwsem;
+};
+
+/* Types of kobject elements represented by sysfs_dirent */
+#define SYSFS_ROOT		0x0001
+#define	SYSFS_KOBJECT		0x0002
+#define	SYSFS_KOBJ_ATTR		0x0004
+#define	SYSFS_KOBJ_BIN_ATTR	0x0008
+#define	SYSFS_KOBJ_ATTR_GROUP	0x0010
+#define	SYSFS_KOBJ_LINK		0x0020
+
 int sysfs_create_group(struct kobject *, const struct attribute_group *);
 void sysfs_remove_group(struct kobject *, const struct attribute_group *);
 
diff -puN fs/sysfs/mount.c~sysfs-backing-store fs/sysfs/mount.c
--- linux-2.6.0-test9/fs/sysfs/mount.c~sysfs-backing-store	2003-11-12 16:02:27.000000000 +0530
+++ linux-2.6.0-test9-maneesh/fs/sysfs/mount.c	2003-11-12 16:02:27.000000000 +0530
@@ -14,7 +14,6 @@
 /* Random magic number */
 #define SYSFS_MAGIC 0x62656572
 
-struct vfsmount *sysfs_mount;
 struct super_block * sysfs_sb = NULL;
 
 static struct super_operations sysfs_ops = {
@@ -22,6 +21,15 @@ static struct super_operations sysfs_ops
 	.drop_inode	= generic_delete_inode,
 };
 
+struct sysfs_dirent sysfs_root = {
+	.s_sibling	= LIST_HEAD_INIT(sysfs_root.s_sibling),
+	.s_children	= LIST_HEAD_INIT(sysfs_root.s_children),
+	.s_element	= NULL,
+	.s_dentry	= NULL,
+	.s_type		= SYSFS_ROOT,
+	.s_rwsem	= __RWSEM_INITIALIZER(sysfs_root.s_rwsem),
+};
+
 static int sysfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct inode *inode;
@@ -35,10 +43,9 @@ static int sysfs_fill_super(struct super
 
 	inode = sysfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
 	if (inode) {
-		inode->i_op = &simple_dir_inode_operations;
-		inode->i_fop = &simple_dir_operations;
-		/* directory inodes start off with i_nlink == 2 (for "." entry) */
-		inode->i_nlink++;	
+		inode->i_op = &sysfs_dir_inode_operations;
+		inode->i_fop = &sysfs_dir_operations;
+		inode->i_nlink += sysfs_get_link_count(&sysfs_root);
 	} else {
 		pr_debug("sysfs: could not get root inode\n");
 		return -ENOMEM;
@@ -50,7 +57,10 @@ static int sysfs_fill_super(struct super
 		iput(inode);
 		return -ENOMEM;
 	}
+	root->d_fsdata = &sysfs_root;
+	sysfs_root.s_dentry = root;
 	sb->s_root = root;
+
 	return 0;
 }
 
@@ -60,24 +70,19 @@ static struct super_block *sysfs_get_sb(
 	return get_sb_single(fs_type, flags, data, sysfs_fill_super);
 }
 
+static void sysfs_kill_super(struct super_block * sb)
+{
+	sysfs_root.s_dentry = NULL;
+	kill_anon_super(sb);
+}
+
 static struct file_system_type sysfs_fs_type = {
 	.name		= "sysfs",
 	.get_sb		= sysfs_get_sb,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= sysfs_kill_super,
 };
 
 int __init sysfs_init(void)
 {
-	int err;
-
-	err = register_filesystem(&sysfs_fs_type);
-	if (!err) {
-		sysfs_mount = kern_mount(&sysfs_fs_type);
-		if (IS_ERR(sysfs_mount)) {
-			printk(KERN_ERR "sysfs: could not mount!\n");
-			err = PTR_ERR(sysfs_mount);
-			sysfs_mount = NULL;
-		}
-	}
-	return err;
+	return register_filesystem(&sysfs_fs_type);
 }
diff -puN fs/sysfs/sysfs.h~sysfs-backing-store fs/sysfs/sysfs.h
--- linux-2.6.0-test9/fs/sysfs/sysfs.h~sysfs-backing-store	2003-11-12 16:02:27.000000000 +0530
+++ linux-2.6.0-test9-maneesh/fs/sysfs/sysfs.h	2003-11-12 16:02:27.000000000 +0530
@@ -1,13 +1,108 @@
 
-extern struct vfsmount * sysfs_mount;
+#include <linux/fs.h>
+
+extern struct sysfs_dirent sysfs_root;
 
 extern struct inode * sysfs_new_inode(mode_t mode);
 extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
 
 extern struct dentry * sysfs_get_dentry(struct dentry *, const char *);
 
-extern int sysfs_add_file(struct dentry * dir, const struct attribute * attr);
-extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
+extern int sysfs_add_file(struct sysfs_dirent * , const struct attribute * );
+extern void sysfs_hash_and_remove(struct sysfs_dirent *, const char *);
 
-extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
+extern char * sysfs_get_name(struct sysfs_dirent *);
+extern int sysfs_get_link_count(struct sysfs_dirent *);
+extern struct dentry * sysfs_get_new_dentry(struct dentry *, const char *);
+extern int sysfs_init_file(struct inode * inode);
+extern int sysfs_symlink(struct inode *, struct dentry *, const char *);
+
+extern struct inode_operations sysfs_dir_inode_operations;
+extern struct file_operations sysfs_dir_operations;
+extern struct file_operations bin_fops;
+
+struct dentry * sysfs_lookup(struct inode *, struct dentry *, struct nameidata *);
+int sysfs_dir_open(struct inode *inode, struct file *file);
+int sysfs_dir_close(struct inode *inode, struct file *file);
+loff_t sysfs_dir_lseek(struct file *file, loff_t offset, int origin);
+int sysfs_readdir(struct file * filp, void * dirent, filldir_t filldir);
+
+static inline struct kobject * sysfs_get_file_kobject(struct dentry * dentry)
+{
+	struct dentry * parent;
+	struct sysfs_dirent * sd;
+	
+	parent = dentry->d_parent;
+	sd = parent->d_fsdata;
+	if (sd->s_type == SYSFS_KOBJ_ATTR_GROUP)
+		sd = parent->d_parent->d_fsdata;
+
+	return (struct kobject *) sd->s_element;
+		
+}
+
+static inline struct attribute * sysfs_get_file_attr(struct file * filp)
+{
+	struct sysfs_dirent * sd = filp->f_dentry->d_fsdata;
+	return sd->s_element;
+		
+}
+
+static inline struct sysfs_dirent * 
+sysfs_alloc_dirent(struct sysfs_dirent * parent_sd, void * element, int type)
+{
+	struct sysfs_dirent * sd;
+					
+	sd = kmalloc(sizeof(*sd), GFP_KERNEL);
+	if (!sd)
+		return ERR_PTR(-ENOMEM);
+
+	init_rwsem(&sd->s_rwsem);
+	INIT_LIST_HEAD(&sd->s_children);
+	sd->s_element = element;
+	sd->s_type = type;
+	sd->s_dentry = NULL;
+
+	down_write(&parent_sd->s_rwsem);
+	list_add(&sd->s_sibling, &parent_sd->s_children);
+	up_write(&parent_sd->s_rwsem);
+
+	return sd;
+}
+
+static inline void
+sysfs_free_dirent(struct sysfs_dirent * parent_sd, const char * name)
+{
+	struct sysfs_dirent * sd;
+	struct list_head * tmp;
+	
+	down_write(&parent_sd->s_rwsem);
+	tmp = parent_sd->s_children.next;
+	while (tmp != &parent_sd->s_children) {
+		sd = list_entry(tmp, struct sysfs_dirent, s_sibling);
+		tmp = tmp->next;
+		if (!strcmp(name, sysfs_get_name(sd))) {
+			list_del(&sd->s_sibling);
+			kfree(sd);
+		}
+	}
+	up_write(&parent_sd->s_rwsem);
+}
+
+static inline void
+sysfs_free_children(struct sysfs_dirent * parent_sd)
+{
+	struct sysfs_dirent * sd;
+	struct list_head * tmp;
+	
+	down_write(&parent_sd->s_rwsem);
+	tmp = parent_sd->s_children.next;
+	while (tmp != &parent_sd->s_children) {
+		sd = list_entry(tmp, struct sysfs_dirent, s_sibling);
+		tmp = tmp->next;
+		list_del(&sd->s_sibling);
+		kfree(sd);
+	}
+	up_write(&parent_sd->s_rwsem);
+}

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
