Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264659AbUEENAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264659AbUEENAM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 09:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbUEEM7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 08:59:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:61865 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264647AbUEEM4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:56:47 -0400
Date: Wed, 5 May 2004 18:29:49 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>
Subject: [RFC 6/6] sysfs backing store ver 0.5
Message-ID: <20040505125949.GG1244@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040505125702.GA1244@in.ibm.com> <20040505125755.GB1244@in.ibm.com> <20040505125815.GC1244@in.ibm.com> <20040505125833.GD1244@in.ibm.com> <20040505125902.GE1244@in.ibm.com> <20040505125925.GF1244@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505125925.GF1244@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



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


 fs/sysfs/group.c |   18 ++++++----
 fs/sysfs/sysfs.h |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 101 insertions(+), 10 deletions(-)

diff -puN fs/sysfs/group.c~sysfs-leaves-misc fs/sysfs/group.c
--- linux-2.6.6-rc3-mm1/fs/sysfs/group.c~sysfs-leaves-misc	2004-05-05 10:55:17.000000000 +0530
+++ linux-2.6.6-rc3-mm1-maneesh/fs/sysfs/group.c	2004-05-05 10:55:17.000000000 +0530
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
--- linux-2.6.6-rc3-mm1/fs/sysfs/sysfs.h~sysfs-leaves-misc	2004-05-05 10:55:17.000000000 +0530
+++ linux-2.6.6-rc3-mm1-maneesh/fs/sysfs/sysfs.h	2004-05-05 10:58:00.000000000 +0530
@@ -1,28 +1,115 @@
 
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
+extern int sysfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname);
+extern int init_symlink(struct inode * inode);
 
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
+
+static inline 
+void sysfs_remove_dirent(struct sysfs_dirent * parent_sd, const char * name)
+{
+	struct list_head * tmp;
+
+	tmp = parent_sd->s_children.next;
+	while (tmp != & parent_sd->s_children) {
+		struct sysfs_dirent * sd;
+		sd = list_entry(tmp, struct sysfs_dirent, s_sibling);
+		tmp = tmp->next;
+		if (sd->s_type & SYSFS_NOT_PINNED) {
+			if (!strcmp(sysfs_get_name(sd), name)) {
+				list_del_init(&sd->s_sibling);
+				sysfs_put(sd);
+			}
+		}
+	}
+}
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

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
