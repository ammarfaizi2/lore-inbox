Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTL2Jjy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 04:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTL2Jib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 04:38:31 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:34455 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263185AbTL2Jeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 04:34:37 -0500
Date: Mon, 29 Dec 2003 15:03:54 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC 1/5] sysfs backing store (leaves only) - sysfs-leaves-mount.patch
Message-ID: <20031229093354.GB1649@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031229093213.GA1649@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229093213.GA1649@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


o  The following patch contains the sysfs_dirent structure definition. 
   sysfs_dirent can represent kobject, attribute group, text attribute or
   binary attribute for kobjects registered with sysfs. sysfs_dirent is 
   allocated with a ref count (s_count) of 1. Ref count is incremented when
   a dentry is associated with the sysfs_dirent and it is decremented when
   the corresponding dentry is freed. 

o  sysfs_dirent's corresponding to the attribute files of a kobject or attribute
   group are linked together with s_sibling and are anchored at s_children of 
   the corresponding kobject's or attribute-group's  sysfs_dirent.

o  The patch also contains the mount related changes for sysfs backing store. 
   Because we mount sysfs once while init(), plain umount of sysfs doesnot
   free all the un-used dentries (present in LRU list). To use force umount
   flag, umount_begin() routine is provided which does a shrink_dcache_parent()
   to release all the unused dentries.

 fs/sysfs/mount.c      |   21 +++++++++++++++++++--
 include/linux/sysfs.h |   17 +++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff -puN include/linux/sysfs.h~sysfs-leaves-mount include/linux/sysfs.h
--- linux-2.6.0/include/linux/sysfs.h~sysfs-leaves-mount	2003-12-29 12:50:50.000000000 +0530
+++ linux-2.6.0-maneesh/include/linux/sysfs.h	2003-12-29 12:53:50.000000000 +0530
@@ -9,6 +9,8 @@
 #ifndef _SYSFS_H_
 #define _SYSFS_H_
 
+#include <asm/atomic.h>
+
 struct kobject;
 struct module;
 
@@ -33,6 +35,21 @@ struct sysfs_ops {
 	ssize_t	(*store)(struct kobject *,struct attribute *,const char *, size_t);
 };
 
+struct sysfs_dirent {
+	atomic_t		s_count;
+	struct list_head	s_sibling;
+	struct list_head	s_children;
+	void 			* s_element;
+	int			s_type;
+	struct dentry		* s_dentry;
+};
+
+#define SYSFS_ROOT		0x0001
+#define	SYSFS_KOBJECT		0x0002
+#define	SYSFS_KOBJ_ATTR		0x0004
+#define	SYSFS_KOBJ_BIN_ATTR	0x0008
+#define	SYSFS_KOBJ_ATTR_GROUP	0x0010
+
 extern int
 sysfs_create_dir(struct kobject *);
 
diff -puN fs/sysfs/mount.c~sysfs-leaves-mount fs/sysfs/mount.c
--- linux-2.6.0/fs/sysfs/mount.c~sysfs-leaves-mount	2003-12-29 12:51:04.000000000 +0530
+++ linux-2.6.0-maneesh/fs/sysfs/mount.c	2003-12-29 12:59:21.000000000 +0530
@@ -20,6 +20,14 @@ struct super_block * sysfs_sb = NULL;
 static struct super_operations sysfs_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
+	.umount_begin 	= sysfs_umount_begin,
+};
+
+struct sysfs_dirent sysfs_root = {
+	.s_sibling	= LIST_HEAD_INIT(sysfs_root.s_sibling),
+	.s_children	= LIST_HEAD_INIT(sysfs_root.s_children),
+	.s_element	= NULL,
+	.s_type		= SYSFS_ROOT,
 };
 
 static int sysfs_fill_super(struct super_block *sb, void *data, int silent)
@@ -35,8 +43,8 @@ static int sysfs_fill_super(struct super
 
 	inode = sysfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
 	if (inode) {
-		inode->i_op = &simple_dir_inode_operations;
-		inode->i_fop = &simple_dir_operations;
+		inode->i_op = &sysfs_dir_inode_operations;
+		inode->i_fop = &sysfs_dir_operations;
 		/* directory inodes start off with i_nlink == 2 (for "." entry) */
 		inode->i_nlink++;	
 	} else {
@@ -50,6 +58,7 @@ static int sysfs_fill_super(struct super
 		iput(inode);
 		return -ENOMEM;
 	}
+	root->d_fsdata = &sysfs_root;
 	sb->s_root = root;
 	return 0;
 }
@@ -60,6 +69,14 @@ static struct super_block *sysfs_get_sb(
 	return get_sb_single(fs_type, flags, data, sysfs_fill_super);
 }
 
+void sysfs_umount_begin(struct super_block * sb) 
+{
+	lock_super(sb);
+	if (sb->s_root) 
+		shrink_dcache_parent(sb->s_root);
+	unlock_super(sb);
+}
+
 static struct file_system_type sysfs_fs_type = {
 	.name		= "sysfs",
 	.get_sb		= sysfs_get_sb,

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
