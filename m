Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265141AbUG2Ujr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUG2Ujr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUG2Ujr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:39:47 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:55459 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265141AbUG2Uid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:38:33 -0400
Date: Thu, 29 Jul 2004 15:39:19 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] Use sysfs_dirent tree for ->readdir etc.
Message-ID: <20040729203919.GD4592@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040729203718.GB4592@in.ibm.com> <20040729203821.GC4592@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729203821.GC4592@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o This patch implements the sysfs_dir_operations file_operations strucutre for 
  sysfs directories. It uses the sysfs_dirent based tree for ->readdir() and 
  ->lseek() methods instead of simple_dir_operations which use dentry based 
  tree.

o This also has the code for sysfs_get() and sysfs_put() which manipulates
  the reference counting for for sysfs_dirents.


 fs/sysfs/dir.c   |  173 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/sysfs/mount.c |    2 
 fs/sysfs/sysfs.h |   27 ++++++++
 3 files changed, 200 insertions(+), 2 deletions(-)

diff -puN fs/sysfs/dir.c~sysfs-backing-store-sysfs_readdir fs/sysfs/dir.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/dir.c~sysfs-backing-store-sysfs_readdir	2004-07-29 15:30:38.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/dir.c	2004-07-29 15:31:13.000000000 -0500
@@ -15,7 +15,7 @@ DECLARE_RWSEM(sysfs_rename_sem);
 static int init_dir(struct inode * inode)
 {
 	inode->i_op = &simple_dir_inode_operations;
-	inode->i_fop = &simple_dir_operations;
+	inode->i_fop = &sysfs_dir_operations;
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inode->i_nlink++;
@@ -210,6 +210,177 @@ int sysfs_rename_dir(struct kobject * ko
 	return error;
 }
 
+/* get the name for corresponding element represented by the given sysfs_dirent
+ */
+const unsigned char * sysfs_get_name(struct sysfs_dirent *sd)
+{
+	struct attribute * attr;
+	struct bin_attribute * bin_attr;
+	struct sysfs_symlink  * sl;
+
+	if (!sd || !sd->s_element)
+		BUG();
+
+	switch (sd->s_type) {
+		case SYSFS_KOBJECT:
+		case SYSFS_KOBJ_ATTR_GROUP:
+			/* Always have a dentry so use that */
+			return sd->s_dentry->d_name.name;
+
+		case SYSFS_KOBJ_ATTR:
+			attr = sd->s_element;
+			return attr->name;
+
+		case SYSFS_KOBJ_BIN_ATTR:
+			bin_attr = sd->s_element;
+			return bin_attr->attr.name;
+
+		case SYSFS_KOBJ_LINK:
+			sl = sd->s_element;
+			return sl->link_name;
+	}
+	return NULL;
+}
+
+static int sysfs_dir_open(struct inode *inode, struct file *file)
+{
+	struct dentry * dentry = file->f_dentry;
+	struct sysfs_dirent * parent_sd = dentry->d_fsdata;
+
+	down(&dentry->d_inode->i_sem);
+	file->private_data = sysfs_new_dirent(parent_sd, NULL, 0);
+	up(&dentry->d_inode->i_sem);
+
+	return file->private_data ? 0 : -ENOMEM;
+
+}
+
+static int sysfs_dir_close(struct inode *inode, struct file *file)
+{
+	struct dentry * dentry = file->f_dentry;
+	struct sysfs_dirent * cursor = file->private_data;
+
+	down(&dentry->d_inode->i_sem);
+	list_del_init(&cursor->s_sibling);
+	up(&dentry->d_inode->i_sem);
+	sysfs_put(file->private_data);
+
+	return 0;
+}
+
+/* Relationship between s_mode and the DT_xxx types */
+static inline unsigned char dt_type(struct sysfs_dirent *sd)
+{
+	return (sd->s_mode >> 12) & 15;
+}
+
+static int sysfs_readdir(struct file * filp, void * dirent, filldir_t filldir)
+{
+	struct dentry *dentry = filp->f_dentry;
+	struct sysfs_dirent * parent_sd = dentry->d_fsdata;
+	struct sysfs_dirent *cursor = filp->private_data;
+	struct list_head *p, *q = &cursor->s_sibling;
+	ino_t ino;
+	int i = filp->f_pos;
+
+	switch (i) {
+		case 0:
+			ino = dentry->d_inode->i_ino;
+			if (filldir(dirent, ".", 1, i, ino, DT_DIR) < 0)
+				break;
+			filp->f_pos++;
+			i++;
+			/* fallthrough */
+		case 1:
+			ino = parent_ino(dentry);
+			if (filldir(dirent, "..", 2, i, ino, DT_DIR) < 0)
+				break;
+			filp->f_pos++;
+			i++;
+			/* fallthrough */
+		default:
+			if (filp->f_pos == 2) {
+				list_del(q);
+				list_add(q, &parent_sd->s_children);
+			}
+			for (p=q->next; p!= &parent_sd->s_children; p=p->next) {
+				struct sysfs_dirent *next;
+				const char * name;
+				int len;
+
+				next = list_entry(p, struct sysfs_dirent,
+						   s_sibling);
+				if (!next->s_element)
+					continue;
+
+				name = sysfs_get_name(next);
+				len = strlen(name);
+				if (next->s_dentry)
+					ino = next->s_dentry->d_inode->i_ino;
+				else
+					ino = iunique(sysfs_sb, 2);
+
+				if (filldir(dirent, name, len, filp->f_pos, ino,
+						 dt_type(next)) < 0)
+					return 0;
+
+				list_del(q);
+				list_add(q, p);
+				p = q;
+				filp->f_pos++;
+			}
+	}
+	return 0;
+}
+
+static loff_t sysfs_dir_lseek(struct file * file, loff_t offset, int origin)
+{
+	struct dentry * dentry = file->f_dentry;
+
+	down(&dentry->d_inode->i_sem);
+	switch (origin) {
+		case 1:
+			offset += file->f_pos;
+		case 0:
+			if (offset >= 0)
+				break;
+		default:
+			up(&file->f_dentry->d_inode->i_sem);
+			return -EINVAL;
+	}
+	if (offset != file->f_pos) {
+		file->f_pos = offset;
+		if (file->f_pos >= 2) {
+			struct sysfs_dirent *sd = dentry->d_fsdata;
+			struct sysfs_dirent *cursor = file->private_data;
+			struct list_head *p;
+			loff_t n = file->f_pos - 2;
+
+			list_del(&cursor->s_sibling);
+			p = sd->s_children.next;
+			while (n && p != &sd->s_children) {
+				struct sysfs_dirent *next;
+				next = list_entry(p, struct sysfs_dirent,
+						   s_sibling);
+				if (next->s_element)
+					n--;
+				p = p->next;
+			}
+			list_add_tail(&cursor->s_sibling, p);
+		}
+	}
+	up(&dentry->d_inode->i_sem);
+	return offset;
+}
+
+struct file_operations sysfs_dir_operations = {
+	.open		= sysfs_dir_open,
+	.release	= sysfs_dir_close,
+	.llseek		= sysfs_dir_lseek,
+	.read		= generic_read_dir,
+	.readdir	= sysfs_readdir,
+};
+
 EXPORT_SYMBOL(sysfs_create_dir);
 EXPORT_SYMBOL(sysfs_remove_dir);
 EXPORT_SYMBOL(sysfs_rename_dir);
diff -puN fs/sysfs/sysfs.h~sysfs-backing-store-sysfs_readdir fs/sysfs/sysfs.h
--- linux-2.6.8-rc2-mm1/fs/sysfs/sysfs.h~sysfs-backing-store-sysfs_readdir	2004-07-29 15:30:38.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/sysfs.h	2004-07-29 15:31:07.000000000 -0500
@@ -4,6 +4,8 @@ extern struct vfsmount * sysfs_mount;
 extern struct inode * sysfs_new_inode(mode_t mode);
 extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
 
+
+extern const unsigned char * sysfs_get_name(struct sysfs_dirent *sd);
 extern struct dentry * sysfs_get_dentry(struct dentry *, const char *);
 extern void sysfs_drop_dentry(struct sysfs_dirent *, struct dentry *);
 
@@ -16,6 +18,8 @@ extern void sysfs_remove_subdir(struct d
 extern int sysfs_readlink(struct dentry *, char __user *, int );
 extern int sysfs_follow_link(struct dentry *, struct nameidata *);
 extern struct rw_semaphore sysfs_rename_sem;
+extern struct super_block * sysfs_sb;
+extern struct file_operations sysfs_dir_operations;
 
 struct sysfs_symlink {
 	char * link_name;
@@ -58,3 +62,26 @@ struct sysfs_dirent * sysfs_new_dirent(s
 
 	return sd;
 }
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
diff -puN fs/sysfs/mount.c~sysfs-backing-store-sysfs_readdir fs/sysfs/mount.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/mount.c~sysfs-backing-store-sysfs_readdir	2004-07-29 15:30:38.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/mount.c	2004-07-29 15:31:07.000000000 -0500
@@ -43,7 +43,7 @@ static int sysfs_fill_super(struct super
 	inode = sysfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
 	if (inode) {
 		inode->i_op = &simple_dir_inode_operations;
-		inode->i_fop = &simple_dir_operations;
+		inode->i_fop = &sysfs_dir_operations;
 		/* directory inodes start off with i_nlink == 2 (for "." entry) */
 		inode->i_nlink++;	
 	} else {

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
