Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUBRNBe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 08:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUBRNBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 08:01:34 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:58245 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266878AbUBRM6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 07:58:37 -0500
Date: Wed, 18 Feb 2004 18:33:06 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mjbligh@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Matt Mackall <mpm@selenic.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>
Subject: Re: [RFC][1/6] Sysfs backing store release 0.1
Message-ID: <20040218130306.GC1255@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040218130211.GB1255@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218130211.GB1255@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



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



 fs/sysfs/mount.c      |   27 +++++++++++++++++++++++++--
 include/linux/sysfs.h |   19 +++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff -puN fs/sysfs/mount.c~sysfs-leaves-mount fs/sysfs/mount.c
--- linux-2.6.3-mm1/fs/sysfs/mount.c~sysfs-leaves-mount	2004-02-18 14:47:52.000000000 +0530
+++ linux-2.6.3-mm1-maneesh/fs/sysfs/mount.c	2004-02-18 15:18:47.000000000 +0530
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
@@ -60,6 +69,20 @@ static struct super_block *sysfs_get_sb(
 	return get_sb_single(fs_type, flags, data, sysfs_fill_super);
 }
 
+/* For freeing zero refenced dentries / inodes while force unmounting 
+ *
+ * sysfs is mounted once within kernel during init(), and this keeps the super 
+ * block always active. So in case of user just doing normal umount, 
+ * ->kill_sb is never called. So, in order to immediately free the memory used 
+ * by un-used dentries and inodes, sysfs should to be umounted with force 
+ * option. In anycase there will be normal pruning of unused dentries/inodes
+ * as usual due to memory pressure.
+ */
+void sysfs_umount_begin(struct super_block * sb) 
+{
+	shrink_dcache_parent(sb->s_root);
+}
+
 static struct file_system_type sysfs_fs_type = {
 	.name		= "sysfs",
 	.get_sb		= sysfs_get_sb,
diff -puN include/linux/sysfs.h~sysfs-leaves-mount include/linux/sysfs.h
--- linux-2.6.3-mm1/include/linux/sysfs.h~sysfs-leaves-mount	2004-02-18 14:40:32.000000000 +0530
+++ linux-2.6.3-mm1-maneesh/include/linux/sysfs.h	2004-02-18 14:48:03.000000000 +0530
@@ -9,6 +9,8 @@
 #ifndef _SYSFS_H_
 #define _SYSFS_H_
 
+#include <asm/atomic.h>
+
 struct kobject;
 struct module;
 
@@ -47,6 +49,23 @@ sysfs_remove_dir(struct kobject *);
 extern void
 sysfs_rename_dir(struct kobject *, const char *new_name);
 
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
+#define SYSFS_KOBJECT		0x0002
+#define SYSFS_KOBJ_ATTR 	0x0004
+#define SYSFS_KOBJ_BIN_ATTR	0x0008
+#define SYSFS_KOBJ_ATTR_GROUP	0x0010
+#define SYSFS_KOBJ_LINK 	0x0020
+#define SYSFS_NOT_PINNED	(SYSFS_KOBJ_ATTR | SYSFS_KOBJ_BIN_ATTR | SYSFS_KOBJ_LINK)
+
 extern int
 sysfs_create_file(struct kobject *, const struct attribute *);
 

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-5268553
T/L : 9243696
