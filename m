Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264983AbUEQMKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264983AbUEQMKG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 08:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264982AbUEQMKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 08:10:06 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:8327 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264984AbUEQMJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 08:09:36 -0400
Date: Mon, 17 May 2004 17:35:43 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [2.6.6-mm3] sysfs-leaves-mount.patch
Message-ID: <20040517120543.GC1249@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040517120443.GB1249@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517120443.GB1249@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



=> changes in version 0.6
  o Re-diffed for 2.6.6-mm3

=> changes in version 0.5
  o Removed ->umount_begin() as mount -o remount does the same function
    basically shrink dcache by removing the unsed dentries. 

=> changes in version 0.4
  o Nil, just re-diffed

=> changes in version 0.3
  o Nil, just re-diffed

=> changes in version 0.2
  o Nil, just re-diffed

=> changes in version 0.1
  o Corrected sysfs_umount_begin(), it doesnot need lock_super() and also the 
    s_root check is not required. The reason being, that sysfs filesystem is 
    always mounted internally during init and there is no chance of sysfs super 
    block going away.

  o corrected comments for umount_begin()
		
============================================================================
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



 fs/sysfs/mount.c      |   12 ++++++++++--
 include/linux/sysfs.h |   20 ++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff -puN include/linux/sysfs.h~sysfs-leaves-mount include/linux/sysfs.h
--- linux-2.6.6-mm3/include/linux/sysfs.h~sysfs-leaves-mount	2004-05-17 15:26:35.000000000 +0530
+++ linux-2.6.6-mm3-maneesh/include/linux/sysfs.h	2004-05-17 15:26:35.000000000 +0530
@@ -9,6 +9,8 @@
 #ifndef _SYSFS_H_
 #define _SYSFS_H_
 
+#include <asm/atomic.h>
+
 struct kobject;
 struct module;
 
@@ -47,6 +49,24 @@ sysfs_remove_dir(struct kobject *);
 extern int
 sysfs_rename_dir(struct kobject *, const char *new_name);
 
+struct sysfs_dirent {
+	atomic_t		s_count;
+	struct list_head	s_sibling;
+	struct list_head	s_children;
+	void 			* s_element;
+	int			s_type;
+	umode_t			s_mode;
+	struct dentry		* s_dentry;
+};
+
+#define SYSFS_ROOT		0x0001
+#define SYSFS_KOBJECT		0x0002
+#define SYSFS_KOBJ_ATTR 	0x0004
+#define SYSFS_KOBJ_BIN_ATTR	0x0008
+#define SYSFS_KOBJ_ATTR_GROUP	0x0010
+#define SYSFS_KOBJ_LINK 	0x0020
+#define SYSFS_NOT_PINNED	(SYSFS_KOBJ_ATTR | SYSFS_KOBJ_BIN_ATTR | SYSFS_KOBJ_LINK)
+
 extern int
 sysfs_create_file(struct kobject *, const struct attribute *);
 
diff -puN fs/sysfs/mount.c~sysfs-leaves-mount fs/sysfs/mount.c
--- linux-2.6.6-mm3/fs/sysfs/mount.c~sysfs-leaves-mount	2004-05-17 15:26:35.000000000 +0530
+++ linux-2.6.6-mm3-maneesh/fs/sysfs/mount.c	2004-05-17 15:26:35.000000000 +0530
@@ -22,6 +22,13 @@ static struct super_operations sysfs_ops
 	.drop_inode	= generic_delete_inode,
 };
 
+struct sysfs_dirent sysfs_root = {
+	.s_sibling	= LIST_HEAD_INIT(sysfs_root.s_sibling),
+	.s_children	= LIST_HEAD_INIT(sysfs_root.s_children),
+	.s_element	= NULL,
+	.s_type		= SYSFS_ROOT,
+};
+
 static int sysfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct inode *inode;
@@ -35,8 +42,8 @@ static int sysfs_fill_super(struct super
 
 	inode = sysfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
 	if (inode) {
-		inode->i_op = &simple_dir_inode_operations;
-		inode->i_fop = &simple_dir_operations;
+		inode->i_op = &sysfs_dir_inode_operations;
+		inode->i_fop = &sysfs_dir_operations;
 		/* directory inodes start off with i_nlink == 2 (for "." entry) */
 		inode->i_nlink++;	
 	} else {
@@ -50,6 +57,7 @@ static int sysfs_fill_super(struct super
 		iput(inode);
 		return -ENOMEM;
 	}
+	root->d_fsdata = &sysfs_root;
 	sb->s_root = root;
 	return 0;
 }

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
