Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264050AbTEWMe3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 08:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbTEWMe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 08:34:28 -0400
Received: from pat.uio.no ([129.240.130.16]:5308 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264041AbTEWMdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 08:33:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16078.6142.874792.21854@charged.uio.no>
Date: Fri, 23 May 2003 14:45:50 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH 3/4] Optimize NFS open() calls by means of 'intents'...
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following adds support for passing the open() intent down to the
file i_op->create() method. This enables us to pass down the O_EXCL
flag and the open modes.

PATCH 4/4 will take advantage of O_EXCL. The open modes will be needed
for stateful opens under NFSv4.

Cheers,
  Trond


diff -u --recursive --new-file linux-2.5.69-02-open2/fs/affs/namei.c linux-2.5.69-03-creat/fs/affs/namei.c
--- linux-2.5.69-02-open2/fs/affs/namei.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/affs/namei.c	2003-05-23 00:13:37.000000000 +0200
@@ -256,7 +256,7 @@
 }
 
 int
-affs_create(struct inode *dir, struct dentry *dentry, int mode)
+affs_create(struct inode *dir, struct dentry *dentry, int mode, struct vfsintent *intent)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode	*inode;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/bfs/dir.c linux-2.5.69-03-creat/fs/bfs/dir.c
--- linux-2.5.69-02-open2/fs/bfs/dir.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/bfs/dir.c	2003-05-23 00:13:37.000000000 +0200
@@ -78,7 +78,8 @@
 
 extern void dump_imap(const char *, struct super_block *);
 
-static int bfs_create(struct inode * dir, struct dentry * dentry, int mode)
+static int bfs_create(struct inode * dir, struct dentry * dentry, int mode,
+		struct vfsintent *intent)
 {
 	int err;
 	struct inode * inode;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/cifs/cifsfs.h linux-2.5.69-03-creat/fs/cifs/cifsfs.h
--- linux-2.5.69-02-open2/fs/cifs/cifsfs.h	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/cifs/cifsfs.h	2003-05-23 00:13:37.000000000 +0200
@@ -46,7 +46,7 @@
 
 /* Functions related to inodes */
 extern struct inode_operations cifs_dir_inode_ops;
-extern int cifs_create(struct inode *, struct dentry *, int);
+extern int cifs_create(struct inode *, struct dentry *, int, struct vfsintent *);
 extern struct dentry *cifs_lookup(struct inode *, struct dentry *, struct vfsintent *);
 extern int cifs_unlink(struct inode *, struct dentry *);
 extern int cifs_hardlink(struct dentry *, struct inode *, struct dentry *);
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/cifs/dir.c linux-2.5.69-03-creat/fs/cifs/dir.c
--- linux-2.5.69-02-open2/fs/cifs/dir.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/cifs/dir.c	2003-05-23 00:13:37.000000000 +0200
@@ -119,7 +119,8 @@
 /* Inode operations in similar order to how they appear in the Linux file fs.h */
 
 int
-cifs_create(struct inode *inode, struct dentry *direntry, int mode)
+cifs_create(struct inode *inode, struct dentry *direntry, int mode,
+		struct vfsintent *intent)
 {
 	int rc = -ENOENT;
 	int xid;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/coda/dir.c linux-2.5.69-03-creat/fs/coda/dir.c
--- linux-2.5.69-02-open2/fs/coda/dir.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/coda/dir.c	2003-05-23 00:13:37.000000000 +0200
@@ -28,7 +28,7 @@
 #include <linux/coda_proc.h>
 
 /* dir inode-ops */
-static int coda_create(struct inode *dir, struct dentry *new, int mode);
+static int coda_create(struct inode *dir, struct dentry *new, int mode, struct vfsintent *intent);
 static int coda_mknod(struct inode *dir, struct dentry *new, int mode, dev_t rdev);
 static struct dentry *coda_lookup(struct inode *dir, struct dentry *target, struct vfsintent *intent);
 static int coda_link(struct dentry *old_dentry, struct inode *dir_inode, 
@@ -190,7 +190,7 @@
 }
 
 /* creation routines: create, mknod, mkdir, link, symlink */
-static int coda_create(struct inode *dir, struct dentry *de, int mode)
+static int coda_create(struct inode *dir, struct dentry *de, int mode, struct vfsintent *intent)
 {
         int error=0;
 	const char *name=de->d_name.name;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/ext2/namei.c linux-2.5.69-03-creat/fs/ext2/namei.c
--- linux-2.5.69-02-open2/fs/ext2/namei.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/ext2/namei.c	2003-05-23 00:13:37.000000000 +0200
@@ -120,7 +120,7 @@
  * If the create succeeds, we fill in the inode information
  * with d_instantiate(). 
  */
-static int ext2_create (struct inode * dir, struct dentry * dentry, int mode)
+static int ext2_create (struct inode * dir, struct dentry * dentry, int mode, struct vfsintent *intent)
 {
 	struct inode * inode = ext2_new_inode (dir, mode);
 	int err = PTR_ERR(inode);
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/ext3/namei.c linux-2.5.69-03-creat/fs/ext3/namei.c
--- linux-2.5.69-02-open2/fs/ext3/namei.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/ext3/namei.c	2003-05-23 00:13:37.000000000 +0200
@@ -1633,7 +1633,8 @@
  * If the create succeeds, we fill in the inode information
  * with d_instantiate(). 
  */
-static int ext3_create (struct inode * dir, struct dentry * dentry, int mode)
+static int ext3_create (struct inode * dir, struct dentry * dentry, int mode,
+		struct vfsintent *intent)
 {
 	handle_t *handle; 
 	struct inode * inode;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/hfs/dir.c linux-2.5.69-03-creat/fs/hfs/dir.c
--- linux-2.5.69-02-open2/fs/hfs/dir.c	2002-02-15 01:54:38.000000000 +0100
+++ linux-2.5.69-03-creat/fs/hfs/dir.c	2003-05-23 00:13:37.000000000 +0200
@@ -163,7 +163,7 @@
  * a directory and return a corresponding inode, given the inode for
  * the directory and the name (and its length) of the new file.
  */
-int hfs_create(struct inode * dir, struct dentry *dentry, int mode)
+int hfs_create(struct inode * dir, struct dentry *dentry, int mode, struct vfsintent *intent)
 {
 	struct hfs_cat_entry *entry = HFS_I(dir)->entry;
 	struct hfs_cat_entry *new;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/hfs/dir_dbl.c linux-2.5.69-03-creat/fs/hfs/dir_dbl.c
--- linux-2.5.69-02-open2/fs/hfs/dir_dbl.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/hfs/dir_dbl.c	2003-05-23 00:13:37.000000000 +0200
@@ -26,7 +26,7 @@
 
 static struct dentry *dbl_lookup(struct inode *, struct dentry *, struct vfsintent *);
 static int dbl_readdir(struct file *, void *, filldir_t);
-static int dbl_create(struct inode *, struct dentry *, int);
+static int dbl_create(struct inode *, struct dentry *, int, struct vfsintent *);
 static int dbl_mkdir(struct inode *, struct dentry *, int);
 static int dbl_unlink(struct inode *, struct dentry *);
 static int dbl_rmdir(struct inode *, struct dentry *);
@@ -272,7 +272,7 @@
  * the directory and the name (and its length) of the new file.
  */
 static int dbl_create(struct inode * dir, struct dentry *dentry,
-		      int mode)
+		      int mode, struct vfsintent *intent)
 {
 	int error;
 
@@ -280,7 +280,7 @@
 	if (is_hdr(dir, dentry->d_name.name, dentry->d_name.len)) {
 		error = -EEXIST;
 	} else {
-		error = hfs_create(dir, dentry, mode);
+		error = hfs_create(dir, dentry, mode, intent);
 	}
 	unlock_kernel();
 	return error;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/hpfs/hpfs_fn.h linux-2.5.69-03-creat/fs/hpfs/hpfs_fn.h
--- linux-2.5.69-02-open2/fs/hpfs/hpfs_fn.h	2003-05-22 14:49:31.000000000 +0200
+++ linux-2.5.69-03-creat/fs/hpfs/hpfs_fn.h	2003-05-23 00:13:37.000000000 +0200
@@ -285,7 +285,7 @@
 /* namei.c */
 
 int hpfs_mkdir(struct inode *, struct dentry *, int);
-int hpfs_create(struct inode *, struct dentry *, int);
+int hpfs_create(struct inode *, struct dentry *, int, struct vfsintent *);
 int hpfs_mknod(struct inode *, struct dentry *, int, dev_t);
 int hpfs_symlink(struct inode *, struct dentry *, const char *);
 int hpfs_unlink(struct inode *, struct dentry *);
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/hpfs/namei.c linux-2.5.69-03-creat/fs/hpfs/namei.c
--- linux-2.5.69-02-open2/fs/hpfs/namei.c	2002-11-20 12:19:02.000000000 +0100
+++ linux-2.5.69-03-creat/fs/hpfs/namei.c	2003-05-23 00:13:37.000000000 +0200
@@ -106,7 +106,7 @@
 	return -ENOSPC;
 }
 
-int hpfs_create(struct inode *dir, struct dentry *dentry, int mode)
+int hpfs_create(struct inode *dir, struct dentry *dentry, int mode, struct vfsintent *intent)
 {
 	const char *name = dentry->d_name.name;
 	unsigned len = dentry->d_name.len;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/hugetlbfs/inode.c linux-2.5.69-03-creat/fs/hugetlbfs/inode.c
--- linux-2.5.69-02-open2/fs/hugetlbfs/inode.c	2003-05-05 07:49:54.000000000 +0200
+++ linux-2.5.69-03-creat/fs/hugetlbfs/inode.c	2003-05-23 00:13:37.000000000 +0200
@@ -410,7 +410,7 @@
 	return retval;
 }
 
-static int hugetlbfs_create(struct inode *dir, struct dentry *dentry, int mode)
+static int hugetlbfs_create(struct inode *dir, struct dentry *dentry, int mode, struct vfsintent *intent)
 {
 	return hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0);
 }
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/intermezzo/dir.c linux-2.5.69-03-creat/fs/intermezzo/dir.c
--- linux-2.5.69-02-open2/fs/intermezzo/dir.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/intermezzo/dir.c	2003-05-23 00:13:37.000000000 +0200
@@ -412,7 +412,8 @@
         return 0;
 }
 
-static int presto_create(struct inode * dir, struct dentry * dentry, int mode)
+static int presto_create(struct inode * dir, struct dentry * dentry, int mode,
+                struct vfsintent *intent)
 {
         int error;
         struct presto_cache *cache;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/intermezzo/vfs.c linux-2.5.69-03-creat/fs/intermezzo/vfs.c
--- linux-2.5.69-02-open2/fs/intermezzo/vfs.c	2003-03-23 07:14:13.000000000 +0100
+++ linux-2.5.69-03-creat/fs/intermezzo/vfs.c	2003-05-23 00:13:37.000000000 +0200
@@ -598,7 +598,7 @@
         }
         DQUOT_INIT(dir->d_inode);
         lock_kernel();
-        error = iops->create(dir->d_inode, dentry, mode);
+        error = iops->create(dir->d_inode, dentry, mode, NULL);
         if (error) {
                 EXIT;
                 goto exit_lock;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/jffs/inode-v23.c linux-2.5.69-03-creat/fs/jffs/inode-v23.c
--- linux-2.5.69-02-open2/fs/jffs/inode-v23.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/jffs/inode-v23.c	2003-05-23 00:13:37.000000000 +0200
@@ -1273,7 +1273,8 @@
  * with d_instantiate().
  */
 static int
-jffs_create(struct inode *dir, struct dentry *dentry, int mode)
+jffs_create(struct inode *dir, struct dentry *dentry, int mode,
+		struct vfsintent *intent)
 {
 	struct jffs_raw_inode raw_inode;
 	struct jffs_control *c;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/jffs2/dir.c linux-2.5.69-03-creat/fs/jffs2/dir.c
--- linux-2.5.69-02-open2/fs/jffs2/dir.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/jffs2/dir.c	2003-05-23 00:13:37.000000000 +0200
@@ -25,7 +25,7 @@
 
 static int jffs2_readdir (struct file *, void *, filldir_t);
 
-static int jffs2_create (struct inode *,struct dentry *,int);
+static int jffs2_create (struct inode *,struct dentry *,int, struct vfsintent *);
 static struct dentry *jffs2_lookup (struct inode *,struct dentry *, struct vfsintent *);
 static int jffs2_link (struct dentry *,struct inode *,struct dentry *);
 static int jffs2_unlink (struct inode *,struct dentry *);
@@ -168,7 +168,8 @@
 /***********************************************************************/
 
 
-static int jffs2_create(struct inode *dir_i, struct dentry *dentry, int mode)
+static int jffs2_create(struct inode *dir_i, struct dentry *dentry, int mode,
+		struct vfsintent *intent)
 {
 	struct jffs2_raw_inode *ri;
 	struct jffs2_inode_info *f, *dir_f;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/jfs/namei.c linux-2.5.69-03-creat/fs/jfs/namei.c
--- linux-2.5.69-02-open2/fs/jfs/namei.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/jfs/namei.c	2003-05-23 00:13:37.000000000 +0200
@@ -55,11 +55,13 @@
  * PARAMETER:	dip 	- parent directory vnode
  *		dentry	- dentry of new file
  *		mode	- create mode (rwxrwxrwx).
+ *		intent- intent struct
  *
  * RETURN:	Errors from subroutines
  *
  */
-int jfs_create(struct inode *dip, struct dentry *dentry, int mode)
+int jfs_create(struct inode *dip, struct dentry *dentry, int mode,
+		struct vfsintent *intent)
 {
 	int rc = 0;
 	tid_t tid;		/* transaction id */
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/minix/namei.c linux-2.5.69-03-creat/fs/minix/namei.c
--- linux-2.5.69-02-open2/fs/minix/namei.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/minix/namei.c	2003-05-23 00:13:37.000000000 +0200
@@ -89,7 +89,8 @@
 	return error;
 }
 
-static int minix_create(struct inode * dir, struct dentry *dentry, int mode)
+static int minix_create(struct inode * dir, struct dentry *dentry, int mode,
+		struct vfsintent *intent)
 {
 	return minix_mknod(dir, dentry, mode, 0);
 }
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/msdos/namei.c linux-2.5.69-03-creat/fs/msdos/namei.c
--- linux-2.5.69-02-open2/fs/msdos/namei.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/msdos/namei.c	2003-05-23 00:13:37.000000000 +0200
@@ -262,7 +262,8 @@
  */
 
 /***** Create a file */
-int msdos_create(struct inode *dir,struct dentry *dentry,int mode)
+int msdos_create(struct inode *dir,struct dentry *dentry,int mode,
+		struct vfsintent *intent)
 {
 	struct super_block *sb = dir->i_sb;
 	struct buffer_head *bh;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/namei.c linux-2.5.69-03-creat/fs/namei.c
--- linux-2.5.69-02-open2/fs/namei.c	2003-05-23 00:29:00.000000000 +0200
+++ linux-2.5.69-03-creat/fs/namei.c	2003-05-23 00:29:36.000000000 +0200
@@ -1106,7 +1106,8 @@
 	}
 }
 
-int vfs_create(struct inode *dir, struct dentry *dentry, int mode)
+int vfs_create(struct inode *dir, struct dentry *dentry, int mode,
+		struct vfsintent *intent)
 {
 	int error = may_create(dir, dentry);
 
@@ -1121,7 +1122,7 @@
 	if (error)
 		return error;
 	DQUOT_INIT(dir);
-	error = dir->i_op->create(dir, dentry, mode);
+	error = dir->i_op->create(dir, dentry, mode, intent);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
 		security_inode_post_create(dir, dentry, mode);
@@ -1277,7 +1278,7 @@
 		int mode = opendata->mode;
 		if (!IS_POSIXACL(dir->d_inode))
 			mode &= ~current->fs->umask;
-		error = vfs_create(dir->d_inode, dentry, mode);
+		error = vfs_create(dir->d_inode, dentry, mode, intent);
 		up(&dir->d_inode->i_sem);
 		dput(nd->dentry);
 		nd->dentry = dentry;
@@ -1444,7 +1445,7 @@
 	if (!IS_ERR(dentry)) {
 		switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
-			error = vfs_create(nd.dentry->d_inode,dentry,mode);
+			error = vfs_create(nd.dentry->d_inode,dentry,mode,NULL);
 			break;
 		case S_IFCHR: case S_IFBLK: case S_IFIFO: case S_IFSOCK:
 			error = vfs_mknod(nd.dentry->d_inode,dentry,mode,dev);
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/ncpfs/dir.c linux-2.5.69-03-creat/fs/ncpfs/dir.c
--- linux-2.5.69-02-open2/fs/ncpfs/dir.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/ncpfs/dir.c	2003-05-23 00:13:37.000000000 +0200
@@ -34,7 +34,7 @@
 
 static int ncp_readdir(struct file *, void *, filldir_t);
 
-static int ncp_create(struct inode *, struct dentry *, int);
+static int ncp_create(struct inode *, struct dentry *, int, struct vfsintent *);
 static struct dentry *ncp_lookup(struct inode *, struct dentry *, struct vfsintent *);
 static int ncp_unlink(struct inode *, struct dentry *);
 static int ncp_mkdir(struct inode *, struct dentry *, int);
@@ -942,7 +942,8 @@
 	return error;
 }
 
-static int ncp_create(struct inode *dir, struct dentry *dentry, int mode)
+static int ncp_create(struct inode *dir, struct dentry *dentry, int mode,
+		struct vfsintent *intent)
 {
 	return ncp_create_new(dir, dentry, mode, 0, 0);
 }
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/nfs/dir.c linux-2.5.69-03-creat/fs/nfs/dir.c
--- linux-2.5.69-02-open2/fs/nfs/dir.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/nfs/dir.c	2003-05-23 00:13:37.000000000 +0200
@@ -40,7 +40,7 @@
 static struct dentry *nfs_lookup(struct inode *, struct dentry *, struct vfsintent *);
 static int nfs_cached_lookup(struct inode *, struct dentry *,
 				struct nfs_fh *, struct nfs_fattr *);
-static int nfs_create(struct inode *, struct dentry *, int);
+static int nfs_create(struct inode *, struct dentry *, int, struct vfsintent *);
 static int nfs_mkdir(struct inode *, struct dentry *, int);
 static int nfs_rmdir(struct inode *, struct dentry *);
 static int nfs_unlink(struct inode *, struct dentry *);
@@ -787,7 +787,8 @@
  * that the operation succeeded on the server, but an error in the
  * reply path made it appear to have failed.
  */
-static int nfs_create(struct inode *dir, struct dentry *dentry, int mode)
+static int nfs_create(struct inode *dir, struct dentry *dentry, int mode,
+		struct vfsintent *intent)
 {
 	struct iattr attr;
 	struct nfs_fattr fattr;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/nfsd/vfs.c linux-2.5.69-03-creat/fs/nfsd/vfs.c
--- linux-2.5.69-02-open2/fs/nfsd/vfs.c	2003-05-05 07:49:54.000000000 +0200
+++ linux-2.5.69-03-creat/fs/nfsd/vfs.c	2003-05-23 00:13:37.000000000 +0200
@@ -908,7 +908,7 @@
 	err = nfserr_perm;
 	switch (type) {
 	case S_IFREG:
-		err = vfs_create(dirp, dchild, iap->ia_mode);
+		err = vfs_create(dirp, dchild, iap->ia_mode, NULL);
 		break;
 	case S_IFDIR:
 		err = vfs_mkdir(dirp, dchild, iap->ia_mode);
@@ -1051,7 +1051,7 @@
 		goto out;
 	}
 
-	err = vfs_create(dirp, dchild, iap->ia_mode);
+	err = vfs_create(dirp, dchild, iap->ia_mode, NULL);
 	if (err < 0)
 		goto out_nfserr;
 
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/openpromfs/inode.c linux-2.5.69-03-creat/fs/openpromfs/inode.c
--- linux-2.5.69-02-open2/fs/openpromfs/inode.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/openpromfs/inode.c	2003-05-23 00:13:37.000000000 +0200
@@ -59,7 +59,7 @@
 #define NODE2INO(node) (node + OPENPROM_FIRST_INO)
 #define NODEP2INO(no) (no + OPENPROM_FIRST_INO + last_node)
 
-static int openpromfs_create (struct inode *, struct dentry *, int);
+static int openpromfs_create (struct inode *, struct dentry *, int, struct vfsintent *);
 static int openpromfs_readdir(struct file *, void *, filldir_t);
 static struct dentry *openpromfs_lookup(struct inode *, struct dentry *dentry, struct vfsintent *intent);
 static int openpromfs_unlink (struct inode *, struct dentry *dentry);
@@ -854,7 +854,8 @@
 	return 0;
 }
 
-static int openpromfs_create (struct inode *dir, struct dentry *dentry, int mode)
+static int openpromfs_create (struct inode *dir, struct dentry *dentry, int mode,
+		struct vfsintent *intent)
 {
 	char *p;
 	struct inode *inode;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/qnx4/namei.c linux-2.5.69-03-creat/fs/qnx4/namei.c
--- linux-2.5.69-02-open2/fs/qnx4/namei.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/qnx4/namei.c	2003-05-23 00:13:37.000000000 +0200
@@ -142,7 +142,8 @@
 }
 
 #ifdef CONFIG_QNX4FS_RW
-int qnx4_create(struct inode *dir, struct dentry *dentry, int mode)
+int qnx4_create(struct inode *dir, struct dentry *dentry, int mode,
+		struct vfsintent *intent)
 {
 	QNX4DEBUG(("qnx4: qnx4_create\n"));
 	if (dir == NULL) {
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/ramfs/inode.c linux-2.5.69-03-creat/fs/ramfs/inode.c
--- linux-2.5.69-02-open2/fs/ramfs/inode.c	2002-12-29 21:23:40.000000000 +0100
+++ linux-2.5.69-03-creat/fs/ramfs/inode.c	2003-05-23 00:13:37.000000000 +0200
@@ -111,7 +111,7 @@
 	return retval;
 }
 
-static int ramfs_create(struct inode *dir, struct dentry *dentry, int mode)
+static int ramfs_create(struct inode *dir, struct dentry *dentry, int mode, struct vfsintent *intent)
 {
 	return ramfs_mknod(dir, dentry, mode | S_IFREG, 0);
 }
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/reiserfs/namei.c linux-2.5.69-03-creat/fs/reiserfs/namei.c
--- linux-2.5.69-02-open2/fs/reiserfs/namei.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/reiserfs/namei.c	2003-05-23 00:13:37.000000000 +0200
@@ -558,7 +558,8 @@
     return 0 ;
 }
 
-static int reiserfs_create (struct inode * dir, struct dentry *dentry, int mode)
+static int reiserfs_create (struct inode * dir, struct dentry *dentry, int mode,
+		struct vfsintent *intent)
 {
     int retval;
     struct inode * inode;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/smbfs/dir.c linux-2.5.69-03-creat/fs/smbfs/dir.c
--- linux-2.5.69-02-open2/fs/smbfs/dir.c	2003-05-22 15:07:27.000000000 +0200
+++ linux-2.5.69-03-creat/fs/smbfs/dir.c	2003-05-23 00:13:37.000000000 +0200
@@ -25,7 +25,7 @@
 static int smb_dir_open(struct inode *, struct file *);
 
 static struct dentry *smb_lookup(struct inode *, struct dentry *, struct vfsintent *);
-static int smb_create(struct inode *, struct dentry *, int);
+static int smb_create(struct inode *, struct dentry *, int, struct vfsintent *);
 static int smb_mkdir(struct inode *, struct dentry *, int);
 static int smb_rmdir(struct inode *, struct dentry *);
 static int smb_unlink(struct inode *, struct dentry *);
@@ -510,7 +510,8 @@
 
 /* N.B. How should the mode argument be used? */
 static int
-smb_create(struct inode *dir, struct dentry *dentry, int mode)
+smb_create(struct inode *dir, struct dentry *dentry, int mode,
+		struct vfsintent *intent)
 {
 	struct smb_sb_info *server = server_from_dentry(dentry);
 	__u16 fileid;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/sysv/namei.c linux-2.5.69-03-creat/fs/sysv/namei.c
--- linux-2.5.69-02-open2/fs/sysv/namei.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/sysv/namei.c	2003-05-23 00:13:37.000000000 +0200
@@ -96,7 +96,7 @@
 	return err;
 }
 
-static int sysv_create(struct inode * dir, struct dentry * dentry, int mode)
+static int sysv_create(struct inode * dir, struct dentry * dentry, int mode, struct vfsintent *intent)
 {
 	return sysv_mknod(dir, dentry, mode, 0);
 }
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/udf/namei.c linux-2.5.69-03-creat/fs/udf/namei.c
--- linux-2.5.69-02-open2/fs/udf/namei.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/udf/namei.c	2003-05-23 00:13:37.000000000 +0200
@@ -621,7 +621,7 @@
 	return udf_write_fi(inode, cfi, fi, fibh, NULL, NULL);
 }
 
-static int udf_create(struct inode *dir, struct dentry *dentry, int mode)
+static int udf_create(struct inode *dir, struct dentry *dentry, int mode, struct vfsintent *intent)
 {
 	struct udf_fileident_bh fibh;
 	struct inode *inode;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/ufs/namei.c linux-2.5.69-03-creat/fs/ufs/namei.c
--- linux-2.5.69-02-open2/fs/ufs/namei.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/ufs/namei.c	2003-05-23 00:13:37.000000000 +0200
@@ -92,7 +92,8 @@
  * If the create succeeds, we fill in the inode information
  * with d_instantiate(). 
  */
-static int ufs_create (struct inode * dir, struct dentry * dentry, int mode)
+static int ufs_create (struct inode * dir, struct dentry * dentry, int mode,
+		struct vfsintent *intent)
 {
 	struct inode * inode = ufs_new_inode(dir, mode);
 	int err = PTR_ERR(inode);
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/umsdos/emd.c linux-2.5.69-03-creat/fs/umsdos/emd.c
--- linux-2.5.69-02-open2/fs/umsdos/emd.c	2002-04-30 00:18:54.000000000 +0200
+++ linux-2.5.69-03-creat/fs/umsdos/emd.c	2003-05-23 00:13:37.000000000 +0200
@@ -105,7 +105,7 @@
 Printk(("umsdos_make_emd: creating EMD %s/%s\n",
 parent->d_name.name, demd->d_name.name));
 
-	err = msdos_create(parent->d_inode, demd, S_IFREG | 0777);
+	err = msdos_create(parent->d_inode, demd, S_IFREG | 0777, NULL);
 	if (err) {
 		printk (KERN_WARNING
 			"umsdos_make_emd: create %s/%s failed, err=%d\n",
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/umsdos/namei.c linux-2.5.69-03-creat/fs/umsdos/namei.c
--- linux-2.5.69-02-open2/fs/umsdos/namei.c	2002-11-20 12:19:02.000000000 +0100
+++ linux-2.5.69-03-creat/fs/umsdos/namei.c	2003-05-23 00:13:37.000000000 +0200
@@ -274,7 +274,7 @@
 	if (fake->d_inode)
 		goto out_remove_dput;
 
-	ret = msdos_create (dir, fake, S_IFREG | 0777);
+	ret = msdos_create (dir, fake, S_IFREG | 0777, NULL);
 	if (ret)
 		goto out_remove_dput;
 
@@ -311,7 +311,7 @@
  * 
  * Return the status of the operation. 0 mean success.
  */
-int UMSDOS_create (struct inode *dir, struct dentry *dentry, int mode)
+int UMSDOS_create (struct inode *dir, struct dentry *dentry, int mode, struct vfsintent *intent)
 {
 	return umsdos_create_any (dir, dentry, mode, 0, 0);
 }
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/vfat/namei.c linux-2.5.69-03-creat/fs/vfat/namei.c
--- linux-2.5.69-02-open2/fs/vfat/namei.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/vfat/namei.c	2003-05-23 00:13:37.000000000 +0200
@@ -911,7 +911,8 @@
 	return dentry;
 }
 
-int vfat_create(struct inode *dir,struct dentry* dentry,int mode)
+int vfat_create(struct inode *dir,struct dentry* dentry,int mode,
+		struct vfsintent *intent)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
diff -u --recursive --new-file linux-2.5.69-02-open2/fs/xfs/linux/xfs_iops.c linux-2.5.69-03-creat/fs/xfs/linux/xfs_iops.c
--- linux-2.5.69-02-open2/fs/xfs/linux/xfs_iops.c	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/fs/xfs/linux/xfs_iops.c	2003-05-23 00:13:37.000000000 +0200
@@ -173,7 +173,8 @@
 linvfs_create(
 	struct inode	*dir,
 	struct dentry	*dentry,
-	int		mode)
+	int		mode,
+	struct vfsintent *intent)
 {
 	return linvfs_mknod(dir, dentry, mode, 0);
 }
diff -u --recursive --new-file linux-2.5.69-02-open2/include/linux/affs_fs.h linux-2.5.69-03-creat/include/linux/affs_fs.h
--- linux-2.5.69-02-open2/include/linux/affs_fs.h	2003-05-22 14:38:54.000000000 +0200
+++ linux-2.5.69-03-creat/include/linux/affs_fs.h	2003-05-23 00:13:37.000000000 +0200
@@ -43,7 +43,7 @@
 extern int	affs_hash_name(struct super_block *sb, const u8 *name, unsigned int len);
 extern struct dentry *affs_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *);
 extern int	affs_unlink(struct inode *dir, struct dentry *dentry);
-extern int	affs_create(struct inode *dir, struct dentry *dentry, int mode);
+extern int	affs_create(struct inode *dir, struct dentry *dentry, int mode, struct vfsintent *);
 extern int	affs_mkdir(struct inode *dir, struct dentry *dentry, int mode);
 extern int	affs_rmdir(struct inode *dir, struct dentry *dentry);
 extern int	affs_link(struct dentry *olddentry, struct inode *dir,
diff -u --recursive --new-file linux-2.5.69-02-open2/include/linux/fs.h linux-2.5.69-03-creat/include/linux/fs.h
--- linux-2.5.69-02-open2/include/linux/fs.h	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/include/linux/fs.h	2003-05-23 00:13:37.000000000 +0200
@@ -639,7 +639,7 @@
 /*
  * VFS helper functions..
  */
-extern int vfs_create(struct inode *, struct dentry *, int);
+extern int vfs_create(struct inode *, struct dentry *, int, struct vfsintent *);
 extern int vfs_mkdir(struct inode *, struct dentry *, int);
 extern int vfs_mknod(struct inode *, struct dentry *, int, dev_t);
 extern int vfs_symlink(struct inode *, struct dentry *, const char *);
@@ -730,7 +730,7 @@
 };
 
 struct inode_operations {
-	int (*create) (struct inode *,struct dentry *,int);
+	int (*create) (struct inode *,struct dentry *,int, struct vfsintent *);
 	struct dentry * (*lookup) (struct inode *,struct dentry *, struct vfsintent *);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
diff -u --recursive --new-file linux-2.5.69-02-open2/include/linux/hfs_fs.h linux-2.5.69-03-creat/include/linux/hfs_fs.h
--- linux-2.5.69-02-open2/include/linux/hfs_fs.h	2002-10-07 19:27:58.000000000 +0200
+++ linux-2.5.69-03-creat/include/linux/hfs_fs.h	2003-05-23 00:13:37.000000000 +0200
@@ -234,7 +234,7 @@
 					 const struct hfs_cat_key *);
 
 /* dir.c */
-extern int hfs_create(struct inode *, struct dentry *, int);
+extern int hfs_create(struct inode *, struct dentry *, int, struct vfsintent *);
 extern int hfs_mkdir(struct inode *, struct dentry *, int);
 extern int hfs_unlink(struct inode *, struct dentry *);
 extern int hfs_rmdir(struct inode *, struct dentry *);
diff -u --recursive --new-file linux-2.5.69-02-open2/include/linux/msdos_fs.h linux-2.5.69-03-creat/include/linux/msdos_fs.h
--- linux-2.5.69-02-open2/include/linux/msdos_fs.h	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/include/linux/msdos_fs.h	2003-05-23 00:13:37.000000000 +0200
@@ -318,7 +318,7 @@
 
 /* msdos/namei.c  - these are for Umsdos */
 extern struct dentry *msdos_lookup(struct inode *dir, struct dentry *, struct vfsintent *);
-extern int msdos_create(struct inode *dir, struct dentry *dentry, int mode);
+extern int msdos_create(struct inode *dir, struct dentry *dentry, int mode, struct vfsintent *);
 extern int msdos_rmdir(struct inode *dir, struct dentry *dentry);
 extern int msdos_mkdir(struct inode *dir, struct dentry *dentry, int mode);
 extern int msdos_unlink(struct inode *dir, struct dentry *dentry);
@@ -328,7 +328,7 @@
 
 /* vfat/namei.c - these are for dmsdos */
 extern struct dentry *vfat_lookup(struct inode *dir, struct dentry *, struct vfsintent *);
-extern int vfat_create(struct inode *dir, struct dentry *dentry, int mode);
+extern int vfat_create(struct inode *dir, struct dentry *dentry, int mode, struct vfsintent *);
 extern int vfat_rmdir(struct inode *dir, struct dentry *dentry);
 extern int vfat_unlink(struct inode *dir, struct dentry *dentry);
 extern int vfat_mkdir(struct inode *dir, struct dentry *dentry, int mode);
diff -u --recursive --new-file linux-2.5.69-02-open2/include/linux/qnx4_fs.h linux-2.5.69-03-creat/include/linux/qnx4_fs.h
--- linux-2.5.69-02-open2/include/linux/qnx4_fs.h	2003-05-22 14:26:22.000000000 +0200
+++ linux-2.5.69-03-creat/include/linux/qnx4_fs.h	2003-05-23 00:13:37.000000000 +0200
@@ -117,14 +117,13 @@
 extern struct buffer_head *qnx4_getblk(struct inode *, int, int);
 extern struct buffer_head *qnx4_bread(struct inode *, int, int);
 
-extern int qnx4_create(struct inode *dir, struct dentry *dentry, int mode);
 extern struct inode_operations qnx4_file_inode_operations;
 extern struct inode_operations qnx4_dir_inode_operations;
 extern struct file_operations qnx4_file_operations;
 extern struct file_operations qnx4_dir_operations;
 extern int qnx4_is_free(struct super_block *sb, long block);
 extern int qnx4_set_bitmap(struct super_block *sb, long block, int busy);
-extern int qnx4_create(struct inode *inode, struct dentry *dentry, int mode);
+extern int qnx4_create(struct inode *inode, struct dentry *dentry, int mode, struct vfsintent *intent);
 extern void qnx4_truncate(struct inode *inode);
 extern void qnx4_free_inode(struct inode *inode);
 extern int qnx4_unlink(struct inode *dir, struct dentry *dentry);
diff -u --recursive --new-file linux-2.5.69-02-open2/mm/shmem.c linux-2.5.69-03-creat/mm/shmem.c
--- linux-2.5.69-02-open2/mm/shmem.c	2003-05-12 23:35:19.000000000 +0200
+++ linux-2.5.69-03-creat/mm/shmem.c	2003-05-23 00:13:37.000000000 +0200
@@ -1396,7 +1396,8 @@
 	return 0;
 }
 
-static int shmem_create(struct inode *dir, struct dentry *dentry, int mode)
+static int shmem_create(struct inode *dir, struct dentry *dentry, int mode,
+		struct vfsintent *intent)
 {
 	return shmem_mknod(dir, dentry, mode | S_IFREG, 0);
 }
