Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUCVG3p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 01:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUCVG3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 01:29:05 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:37775 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261764AbUCVG1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 01:27:38 -0500
Date: Mon, 22 Mar 2004 12:02:17 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Carsten Otte <COTTE@de.ibm.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>,
       "Martin J. Bligh" <mjbligh@us.ibm.com>
Subject: Re: [RFC 6/6] sysfs backing store v0.3
Message-ID: <20040322063217.GG5898@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040318063306.GA27107@in.ibm.com> <20040320175708.GQ11010@waste.org> <20040322062842.GA5898@in.ibm.com> <20040322063012.GB5898@in.ibm.com> <20040322063034.GC5898@in.ibm.com> <20040322063058.GD5898@in.ibm.com> <20040322063124.GE5898@in.ibm.com> <20040322063153.GF5898@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322063153.GF5898@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



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


 fs/sysfs/group.c |    2 -
 fs/sysfs/sysfs.h |   77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 2 deletions(-)

diff -puN fs/sysfs/group.c~sysfs-leaves-misc fs/sysfs/group.c
--- linux-2.6.5-rc2/fs/sysfs/group.c~sysfs-leaves-misc	2004-03-22 10:45:43.000000000 +0530
+++ linux-2.6.5-rc2-maneesh/fs/sysfs/group.c	2004-03-22 10:48:34.000000000 +0530
@@ -31,7 +31,7 @@ static int create_files(struct dentry * 
 	int error = 0;
 
 	for (attr = grp->attrs; *attr && !error; attr++) {
-		error = sysfs_add_file(dir,*attr);
+		error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
 	}
 	if (error)
 		remove_files(dir,grp);
diff -puN fs/sysfs/sysfs.h~sysfs-leaves-misc fs/sysfs/sysfs.h
--- linux-2.6.5-rc2/fs/sysfs/sysfs.h~sysfs-leaves-misc	2004-03-22 10:45:54.000000000 +0530
+++ linux-2.6.5-rc2-maneesh/fs/sysfs/sysfs.h	2004-03-22 10:46:39.000000000 +0530
@@ -1,4 +1,5 @@
 
+#include <linux/fs.h>
 extern struct vfsmount * sysfs_mount;
 
 extern struct inode * sysfs_new_inode(mode_t mode);
@@ -6,8 +7,82 @@ extern int sysfs_create(struct dentry *,
 
 extern struct dentry * sysfs_get_dentry(struct dentry *, const char *);
 
-extern int sysfs_add_file(struct dentry * dir, const struct attribute * attr);
+extern int sysfs_add_file(struct dentry *, const struct attribute *, int);
 extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
 
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
+
+extern loff_t sysfs_dir_lseek(struct file *, loff_t, int);
+extern int sysfs_readdir(struct file *, void *, filldir_t);
+extern void sysfs_umount_begin(struct super_block *);
+extern char * sysfs_get_name(struct sysfs_dirent *);
+extern struct dentry * sysfs_lookup(struct inode *, struct dentry *, struct nameidata *);
+extern int sysfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname);
+
+extern struct file_operations sysfs_file_operations;
+extern struct file_operations bin_fops;
+extern struct inode_operations sysfs_dir_inode_operations;
+extern struct file_operations sysfs_dir_operations;
+
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
+			char ** link_names = sd->s_element;
+			kfree(link_names[0]);
+			kfree(link_names[1]);
+			kfree(sd->s_element);
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

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
