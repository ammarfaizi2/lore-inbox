Return-Path: <linux-kernel-owner+willy=40w.ods.org-S287505AbUKBCVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S287505AbUKBCVI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 21:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S381257AbUKAXN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:13:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:7844 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S323706AbUKAV7U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:59:20 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <10993462761946@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Mon, 1 Nov 2004 13:57:56 -0800
Message-Id: <1099346276701@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2443, 2004/11/01 13:03:53-08:00, akpm@osdl.org

[PATCH] sysfs backing store: use sysfs_dirent based tree in dir file operations

From: Maneesh Soni <maneesh@in.ibm.com>

o This patch implements the sysfs_dir_operations file_operations strucutre for
  sysfs directories. It uses the sysfs_dirent based tree for ->readdir() and
  ->lseek() methods instead of simple_dir_operations which use dentry based
  tree.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/dir.c   |  141 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/sysfs/mount.c |    2 
 fs/sysfs/sysfs.h |    2 
 3 files changed, 143 insertions(+), 2 deletions(-)


diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	2004-11-01 13:37:04 -08:00
+++ b/fs/sysfs/dir.c	2004-11-01 13:37:04 -08:00
@@ -70,7 +70,7 @@
 static int init_dir(struct inode * inode)
 {
 	inode->i_op = &simple_dir_inode_operations;
-	inode->i_fop = &simple_dir_operations;
+	inode->i_fop = &sysfs_dir_operations;
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inode->i_nlink++;
@@ -232,6 +232,145 @@
 
 	return error;
 }
+
+static int sysfs_dir_open(struct inode *inode, struct file *file)
+{
+	struct dentry * dentry = file->f_dentry;
+	struct sysfs_dirent * parent_sd = dentry->d_fsdata;
+
+	down(&dentry->d_inode->i_sem);
+	file->private_data = sysfs_new_dirent(parent_sd, NULL);
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
 
 EXPORT_SYMBOL_GPL(sysfs_create_dir);
 EXPORT_SYMBOL_GPL(sysfs_remove_dir);
diff -Nru a/fs/sysfs/mount.c b/fs/sysfs/mount.c
--- a/fs/sysfs/mount.c	2004-11-01 13:37:04 -08:00
+++ b/fs/sysfs/mount.c	2004-11-01 13:37:04 -08:00
@@ -43,7 +43,7 @@
 	inode = sysfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
 	if (inode) {
 		inode->i_op = &simple_dir_inode_operations;
-		inode->i_fop = &simple_dir_operations;
+		inode->i_fop = &sysfs_dir_operations;
 		/* directory inodes start off with i_nlink == 2 (for "." entry) */
 		inode->i_nlink++;	
 	} else {
diff -Nru a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
--- a/fs/sysfs/sysfs.h	2004-11-01 13:37:04 -08:00
+++ b/fs/sysfs/sysfs.h	2004-11-01 13:37:04 -08:00
@@ -20,6 +20,8 @@
 extern int sysfs_follow_link(struct dentry *, struct nameidata *);
 extern void sysfs_put_link(struct dentry *, struct nameidata *);
 extern struct rw_semaphore sysfs_rename_sem;
+extern struct super_block * sysfs_sb;
+extern struct file_operations sysfs_dir_operations;
 
 struct sysfs_symlink {
 	char * link_name;

