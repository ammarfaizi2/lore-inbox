Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTL2Jjx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 04:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTL2JjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 04:39:20 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:51391 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263166AbTL2JhL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 04:37:11 -0500
Date: Mon, 29 Dec 2003 15:06:30 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC 5/5] sysfs backing store (leaves only) - sysfs-leaves-misc.patch
Message-ID: <20031229093630.GF1649@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031229093213.GA1649@in.ibm.com> <20031229093354.GB1649@in.ibm.com> <20031229093434.GC1649@in.ibm.com> <20031229093519.GD1649@in.ibm.com> <20031229093545.GE1649@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229093545.GE1649@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


o This patch has the changes require for attribute groups and symlinks, and
  misc. routines.

 fs/sysfs/group.c   |    2 -
 fs/sysfs/symlink.c |    2 +
 fs/sysfs/sysfs.h   |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 72 insertions(+), 2 deletions(-)

diff -puN fs/sysfs/symlink.c~sysfs-leaves-misc fs/sysfs/symlink.c
--- linux-2.6.0/fs/sysfs/symlink.c~sysfs-leaves-misc	2003-12-29 14:39:03.000000000 +0530
+++ linux-2.6.0-maneesh/fs/sysfs/symlink.c	2003-12-29 14:39:36.000000000 +0530
@@ -25,6 +25,8 @@ static int sysfs_symlink(struct inode * 
 		error = page_symlink(dentry->d_inode, symname, l);
 		if (error)
 			iput(dentry->d_inode);
+		else
+			d_rehash(dentry);
 	}
 	return error;
 }
diff -puN fs/sysfs/group.c~sysfs-leaves-misc fs/sysfs/group.c
--- linux-2.6.0/fs/sysfs/group.c~sysfs-leaves-misc	2003-12-29 14:39:03.000000000 +0530
+++ linux-2.6.0-maneesh/fs/sysfs/group.c	2003-12-29 14:39:03.000000000 +0530
@@ -31,7 +31,7 @@ static int create_files(struct dentry * 
 	int error = 0;
 
 	for (attr = grp->attrs; *attr && !error; attr++) {
-		error = sysfs_add_file(dir,*attr);
+		error = sysfs_add_file(dir, SYSFS_KOBJ_ATTR, * attr);
 	}
 	if (error)
 		remove_files(dir,grp);
diff -puN fs/sysfs/sysfs.h~sysfs-leaves-misc fs/sysfs/sysfs.h
--- linux-2.6.0/fs/sysfs/sysfs.h~sysfs-leaves-misc	2003-12-29 14:39:03.000000000 +0530
+++ linux-2.6.0-maneesh/fs/sysfs/sysfs.h	2003-12-29 14:39:03.000000000 +0530
@@ -1,4 +1,5 @@
 
+#include <linux/fs.h>
 extern struct vfsmount * sysfs_mount;
 
 extern struct inode * sysfs_new_inode(mode_t mode);
@@ -6,8 +7,75 @@ extern int sysfs_create(struct dentry *,
 
 extern struct dentry * sysfs_get_dentry(struct dentry *, const char *);
 
-extern int sysfs_add_file(struct dentry * dir, const struct attribute * attr);
+extern int sysfs_add_file(struct dentry *, int, const struct attribute *);
 extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
 
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
+
+extern loff_t sysfs_dir_lseek(struct file *, loff_t, int);
+extern int sysfs_readdir(struct file *, void *, filldir_t);
+extern void sysfs_umount_begin(struct super_block *);
+extern char * sysfs_get_name(struct sysfs_dirent *);
+extern struct dentry * sysfs_lookup(struct inode *, struct dentry *, struct nameidata *);
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
+	if (atomic_dec_and_test(&sd->s_count))
+		kfree(sd);
+}
+
+static inline 
+void sysfs_remove_attr_dirent(struct sysfs_dirent * sd, const char * name)
+{
+	struct list_head * tmp;
+
+	tmp = sd->s_children.next;
+	while (tmp != & sd->s_children) {
+		struct sysfs_dirent * tmp_sd;
+		tmp_sd = list_entry(tmp, struct sysfs_dirent, s_sibling);
+		tmp = tmp->next;
+		if ((tmp_sd->s_type == SYSFS_KOBJ_ATTR) || 
+			(tmp_sd->s_type == SYSFS_KOBJ_BIN_ATTR)) {
+			if (!strcmp(sysfs_get_name(tmp_sd), name)) {
+				list_del_init(&tmp_sd->s_sibling);
+				sysfs_put(tmp_sd);
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
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
