Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267707AbUHPQZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267707AbUHPQZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 12:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267702AbUHPQZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 12:25:41 -0400
Received: from [144.51.25.10] ([144.51.25.10]:30962 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S267707AbUHPQZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 12:25:06 -0400
Subject: [PATCH][SELINUX] Add null device node to selinuxfs, remove
	open_devnull
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1092673395.16631.92.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 12:23:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a null device node to selinuxfs and replaces the SELinux
open_devnull() code by simply acquiring a reference to this node each
time, based on a comment by Al Viro on lkml (see
http://marc.theaimsgroup.com/?l=linux-kernel&m=108664922032035&w=2). Please
apply.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by:  James Morris <jmorris@redhat.com>

 security/selinux/hooks.c     |   63 ++-----------------------------------------
 security/selinux/selinuxfs.c |   44 ++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 62 deletions(-)

diff -X /home/sds/dontdiff -ru linux-2.6.8.old/security/selinux/hooks.c linux-2.6.8/security/selinux/hooks.c
--- linux-2.6.8.old/security/selinux/hooks.c	2004-08-05 10:59:12.000000000 -0400
+++ linux-2.6.8/security/selinux/hooks.c	2004-08-05 11:00:53.928155384 -0400
@@ -62,7 +62,6 @@
 #include <linux/nfs_mount.h>
 #include <net/ipv6.h>
 #include <linux/hugetlb.h>
-#include <linux/major.h>
 #include <linux/personality.h>
 
 #include "avc.h"
@@ -1726,64 +1725,8 @@
 	kfree(bsec);
 }
 
-/* Create an open file that refers to the null device.
-   Derived from the OpenWall LSM. */
-struct file *open_devnull(void)
-{
-	struct inode *inode;
-	struct dentry *dentry;
-	struct file *file = NULL;
-	struct inode_security_struct *isec;
-	dev_t dev;
-
-	inode = new_inode(current->fs->rootmnt->mnt_sb);
-	if (!inode)
-		goto out;
-
-	dentry = dget(d_alloc_root(inode));
-	if (!dentry)
-		goto out_iput;
-
-	file = get_empty_filp();
-	if (!file)
-		goto out_dput;
-
-	dev = MKDEV(MEM_MAJOR, 3); /* null device */
-
-	inode->i_uid = current->fsuid;
-	inode->i_gid = current->fsgid;
-	inode->i_blksize = PAGE_SIZE;
-	inode->i_blocks = 0;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-	inode->i_state = I_DIRTY; /* so that mark_inode_dirty won't touch us */
-
-	isec = inode->i_security;
-	isec->sid = SECINITSID_DEVNULL;
-	isec->sclass = SECCLASS_CHR_FILE;
-	isec->initialized = 1;
-
-	file->f_flags = O_RDWR;
-	file->f_mode = FMODE_READ | FMODE_WRITE;
-	file->f_dentry = dentry;
-	file->f_vfsmnt = mntget(current->fs->rootmnt);
-	file->f_pos = 0;
-
-	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO, dev);
-	if (inode->i_fop->open(inode, file))
-		goto out_fput;
-
-out:
-	return file;
-out_fput:
-	mntput(file->f_vfsmnt);
-	put_filp(file);
-out_dput:
-	dput(dentry);
-out_iput:
-	iput(inode);
-	file = NULL;
-	goto out;
-}
+extern struct vfsmount *selinuxfs_mount;
+extern struct dentry *selinux_null;
 
 /* Derived from fs/exec.c:flush_old_files. */
 static inline void flush_unauthorized_files(struct files_struct * files)
@@ -1826,7 +1769,7 @@
 					if (devnull) {
 						atomic_inc(&devnull->f_count);
 					} else {
-						devnull = open_devnull();
+						devnull = dentry_open(dget(selinux_null), mntget(selinuxfs_mount), O_RDWR);
 						if (!devnull) {
 							put_unused_fd(fd);
 							fput(file);
diff -X /home/sds/dontdiff -ru linux-2.6.8.old/security/selinux/selinuxfs.c linux-2.6.8/security/selinux/selinuxfs.c
--- linux-2.6.8.old/security/selinux/selinuxfs.c	2004-08-05 10:59:12.000000000 -0400
+++ linux-2.6.8/security/selinux/selinuxfs.c	2004-08-05 11:00:25.074541800 -0400
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/security.h>
+#include <linux/major.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 
@@ -1042,12 +1043,17 @@
 	goto out;
 }
 
+#define NULL_FILE_NAME "null"
+
+struct dentry *selinux_null = NULL;
+
 static int sel_fill_super(struct super_block * sb, void * data, int silent)
 {
 	int ret;
 	struct dentry *dentry;
 	struct inode *inode;
 	struct qstr qname;
+	struct inode_security_struct *isec;
 
 	static struct tree_descr selinux_files[] = {
 		[SEL_LOAD] = {"load", &sel_load_ops, S_IRUSR|S_IWUSR},
@@ -1085,10 +1091,29 @@
 	if (ret)
 		goto out;
 
+	qname.name = NULL_FILE_NAME;
+	qname.len = strlen(qname.name);
+	qname.hash = full_name_hash(qname.name, qname.len);
+	dentry = d_alloc(sb->s_root, &qname);
+	if (!dentry)
+		return -ENOMEM;
+
+	inode = sel_make_inode(sb, S_IFCHR | S_IRUGO | S_IWUGO);
+	if (!inode)
+		goto out;
+	isec = (struct inode_security_struct*)inode->i_security;
+	isec->sid = SECINITSID_DEVNULL;
+	isec->sclass = SECCLASS_CHR_FILE;
+	isec->initialized = 1;
+
+	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO, MKDEV(MEM_MAJOR, 3));
+	d_add(dentry, inode);
+	selinux_null = dentry;
+
 	return 0;
 out:
 	dput(dentry);
-	printk(KERN_ERR "security:	error creating conditional out_dput\n");
+	printk(KERN_ERR "%s:  failed while creating inodes\n", __FUNCTION__);
 	return -ENOMEM;
 }
 
@@ -1104,9 +1129,24 @@
 	.kill_sb	= kill_litter_super,
 };
 
+struct vfsmount *selinuxfs_mount;
+
 static int __init init_sel_fs(void)
 {
-	return selinux_enabled ? register_filesystem(&sel_fs_type) : 0;
+	int err;
+
+	if (!selinux_enabled)
+		return 0;
+	err = register_filesystem(&sel_fs_type);
+	if (!err) {
+		selinuxfs_mount = kern_mount(&sel_fs_type);
+		if (IS_ERR(selinuxfs_mount)) {
+			printk(KERN_ERR "selinuxfs:  could not mount!\n");
+			err = PTR_ERR(selinuxfs_mount);
+			selinuxfs_mount = NULL;
+		}
+	}
+	return err;
 }
 
 __initcall(init_sel_fs);

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

