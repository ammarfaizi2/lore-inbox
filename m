Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266902AbUBRNGh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 08:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266545AbUBRNEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 08:04:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:3303 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266204AbUBRNCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 08:02:52 -0500
Date: Wed, 18 Feb 2004 18:37:21 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mjbligh@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Matt Mackall <mpm@selenic.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>
Subject: [RFC][6/6] Sysfs backing store release 0.1
Message-ID: <20040218130721.GH1255@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040218130211.GB1255@in.ibm.com> <20040218130306.GC1255@in.ibm.com> <20040218130411.GD1255@in.ibm.com> <20040218130501.GE1255@in.ibm.com> <20040218130542.GF1255@in.ibm.com> <20040218130647.GG1255@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218130647.GG1255@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o This patch has the changes require for attribute groups and misc. routines.


 fs/sysfs/group.c |    2 -
 fs/sysfs/sysfs.h |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 2 deletions(-)

diff -puN fs/sysfs/group.c~sysfs-leaves-misc fs/sysfs/group.c
--- linux-2.6.3-mm1/fs/sysfs/group.c~sysfs-leaves-misc	2004-02-18 17:24:32.000000000 +0530
+++ linux-2.6.3-mm1-maneesh/fs/sysfs/group.c	2004-02-18 17:24:32.000000000 +0530
@@ -31,7 +31,7 @@ static int create_files(struct dentry * 
 	int error = 0;
 
 	for (attr = grp->attrs; *attr && !error; attr++) {
-		error = sysfs_add_file(dir,*attr);
+		error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
 	}
 	if (error)
 		remove_files(dir,grp);
diff -puN fs/sysfs/sysfs.h~sysfs-leaves-misc fs/sysfs/sysfs.h
--- linux-2.6.3-mm1/fs/sysfs/sysfs.h~sysfs-leaves-misc	2004-02-18 17:24:32.000000000 +0530
+++ linux-2.6.3-mm1-maneesh/fs/sysfs/sysfs.h	2004-02-18 17:24:32.000000000 +0530
@@ -1,4 +1,5 @@
 
+#include <linux/fs.h>
 extern struct vfsmount * sysfs_mount;
 
 extern struct inode * sysfs_new_inode(mode_t mode);
@@ -6,8 +7,81 @@ extern int sysfs_create(struct dentry *,
 
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
Phone: 91-80-25044999 Fax: 91-80-5268553
T/L : 9243696
