Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUEQMQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUEQMQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 08:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264982AbUEQMPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 08:15:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:41379 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264991AbUEQMMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 08:12:17 -0400
Date: Mon, 17 May 2004 17:38:21 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [2.6.6-mm3] sysfs-leaves-misc.patch
Message-ID: <20040517120821.GH1249@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040517120443.GB1249@in.ibm.com> <20040517120543.GC1249@in.ibm.com> <20040517120615.GD1249@in.ibm.com> <20040517120644.GE1249@in.ibm.com> <20040517120715.GF1249@in.ibm.com> <20040517120751.GG1249@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517120751.GG1249@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



=> changes in version 0.6
  o Re-diffed for 2.6.6-mm3
  o Removed sysfs_remove_dirent()
  o Added extern definition for the new sysfs_drop_dentry()

=> changes in version 0.5
  o New additions like struct sysfs_symlink. and changes to
    sysfs_get_kobject()

=> changes in version 0.4
 o Nil, just re-diffed

=> changes in version 0.3
 o Corrected dentry ref counting for sysfs_create_group() and
   sysfs_remove_group().

=> changes in Version 0.2
  o  Provided error checking after sysfs_get_dentry() call in 
     sysfs_remove_group().
  o  kfree the symlink name while freeing the corresponding sysfs_dirent in
     sysfs_put().

================
o This patch has the changes required for attribute groups and misc. routines.


 fs/sysfs/group.c |   18 ++++++++-----
 fs/sysfs/sysfs.h |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 82 insertions(+), 10 deletions(-)

diff -puN fs/sysfs/group.c~sysfs-leaves-misc fs/sysfs/group.c
--- linux-2.6.6-mm3/fs/sysfs/group.c~sysfs-leaves-misc	2004-05-17 15:29:32.000000000 +0530
+++ linux-2.6.6-mm3-maneesh/fs/sysfs/group.c	2004-05-17 15:29:32.000000000 +0530
@@ -10,7 +10,7 @@
 
 #include <linux/kobject.h>
 #include <linux/module.h>
-#include <linux/dcache.h>
+#include <linux/fs.h>
 #include <linux/err.h>
 #include "sysfs.h"
 
@@ -31,7 +31,7 @@ static int create_files(struct dentry * 
 	int error = 0;
 
 	for (attr = grp->attrs; *attr && !error; attr++) {
-		error = sysfs_add_file(dir,*attr);
+		error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
 	}
 	if (error)
 		remove_files(dir,grp);
@@ -70,11 +70,15 @@ void sysfs_remove_group(struct kobject *
 	else
 		dir = dget(kobj->dentry);
 
-	remove_files(dir,grp);
-	if (grp->name)
-		sysfs_remove_subdir(dir);
-	/* release the ref. taken in this routine */
-	dput(dir);
+	if (!IS_ERR(dir)) {
+		if (dir && dir->d_inode) {
+			remove_files(dir,grp);
+			if (grp->name)
+				sysfs_remove_subdir(dir);
+			/* release the ref. taken in this routine */
+			dput(dir);
+		}
+	}
 }
 
 
diff -puN fs/sysfs/sysfs.h~sysfs-leaves-misc fs/sysfs/sysfs.h
--- linux-2.6.6-mm3/fs/sysfs/sysfs.h~sysfs-leaves-misc	2004-05-17 15:29:32.000000000 +0530
+++ linux-2.6.6-mm3-maneesh/fs/sysfs/sysfs.h	2004-05-17 15:56:18.000000000 +0530
@@ -1,28 +1,96 @@
 
+#include <linux/fs.h>
 extern struct vfsmount * sysfs_mount;
+extern struct super_block * sysfs_sb;
 
 extern struct inode * sysfs_new_inode(mode_t mode);
 extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
 
 extern struct dentry * sysfs_get_dentry(struct dentry *, const char *);
+extern int sysfs_add_file(struct dentry *, const struct attribute *, int);
 
-extern int sysfs_add_file(struct dentry * dir, const struct attribute * attr);
 extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
 
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
+extern int sysfs_dir_open(struct inode *inode, struct file *file);
+extern int sysfs_dir_close(struct inode *inode, struct file *file);
+extern loff_t sysfs_dir_lseek(struct file *, loff_t, int);
+extern int sysfs_readdir(struct file *, void *, filldir_t);
+extern void sysfs_umount_begin(struct super_block *);
+extern const unsigned char * sysfs_get_name(struct sysfs_dirent *);
+extern struct dentry * sysfs_lookup(struct inode *, struct dentry *, struct nameidata *);
+extern void sysfs_drop_dentry(struct sysfs_dirent *, struct dentry *);
+extern int sysfs_symlink(struct inode *, struct dentry *, const char *);
+extern int init_symlink(struct inode *);
 
 extern int sysfs_readlink(struct dentry *, char __user *, int );
 extern int sysfs_follow_link(struct dentry *, struct nameidata *);
 extern struct rw_semaphore sysfs_rename_sem;
+extern struct file_operations sysfs_file_operations;
+extern struct file_operations bin_fops;
+extern struct inode_operations sysfs_dir_inode_operations;
+extern struct file_operations sysfs_dir_operations;
+
+struct sysfs_symlink {
+	char * link_name;
+	struct kobject * target_kobj;
+};
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
+
+static inline struct sysfs_dirent * sysfs_get(struct sysfs_dirent * sd)
+{
+	if (sd) {
+		WARN_ON(!atomic_read(&sd->s_count)); 
+		atomic_inc(&sd->s_count);
+	}
+	return sd;
+}
+
+static inline void sysfs_put(struct sysfs_dirent * sd)
+{
+	if (atomic_dec_and_test(&sd->s_count)) {
+		if (sd->s_type & SYSFS_KOBJ_LINK) {
+			struct sysfs_symlink * sl = sd->s_element;
+			kfree(sl->link_name);
+			kobject_put(sl->target_kobj);
+			kfree(sl);
+		}
+		kfree(sd);
+	}
+}
 
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

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
