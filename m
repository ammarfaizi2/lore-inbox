Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbTF3OZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 10:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTF3OZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 10:25:25 -0400
Received: from pat.uio.no ([129.240.130.16]:39841 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264672AbTF3OWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 10:22:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16128.19197.159225.698080@charged.uio.no>
Date: Mon, 30 Jun 2003 16:36:45 +0200
To: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH 1/4] Optimize NFS open() calls by means of 'intents'...
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 - Add open intent information to the 'struct nameidata'.
 - Pass the struct nameidata as an optional parameter to the
   lookup() inode operation.
 - Pass the struct nameidata as an optional parameter to the
   d_revalidate() dentry operation.
 - Make link_path_walk() set the LOOKUP_CONTINUE flag in nd->flags instead
   of passing it as an extra parameter to d_revalidate().
 - Make open_namei(), and sys_uselib() set the open()/create() intent
   data.

diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/drivers/net/wan/comx.c linux-2.5.73-04-lookupintent/drivers/net/wan/comx.c
--- linux-2.5.73-03-rpc_integ/drivers/net/wan/comx.c	2003-05-20 08:57:38.000000000 +0200
+++ linux-2.5.73-04-lookupintent/drivers/net/wan/comx.c	2003-06-30 08:48:42.000000000 +0200
@@ -86,7 +86,7 @@
 
 static int comx_mkdir(struct inode *, struct dentry *, int);
 static int comx_rmdir(struct inode *, struct dentry *);
-static struct dentry *comx_lookup(struct inode *, struct dentry *);
+static struct dentry *comx_lookup(struct inode *, struct dentry *, struct nameidata *);
 
 static struct inode_operations comx_root_inode_ops = {
 	.lookup = comx_lookup,
@@ -922,7 +922,7 @@
 	return 0;
 }
 
-static struct dentry *comx_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *comx_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct proc_dir_entry *de;
 	struct inode *inode = NULL;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/adfs/adfs.h linux-2.5.73-04-lookupintent/fs/adfs/adfs.h
--- linux-2.5.73-03-rpc_integ/fs/adfs/adfs.h	2002-05-01 20:54:55.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/adfs/adfs.h	2003-06-30 08:48:42.000000000 +0200
@@ -88,7 +88,7 @@
 #define adfs_error(sb, fmt...) __adfs_error(sb, __FUNCTION__, fmt)
 
 /* namei.c */
-extern struct dentry *adfs_lookup(struct inode *dir, struct dentry *dentry);
+extern struct dentry *adfs_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *);
 
 /* super.c */
 
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/adfs/dir.c linux-2.5.73-04-lookupintent/fs/adfs/dir.c
--- linux-2.5.73-03-rpc_integ/fs/adfs/dir.c	2002-08-03 12:12:00.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/adfs/dir.c	2003-06-30 08:48:42.000000000 +0200
@@ -269,7 +269,7 @@
 	.d_compare	= adfs_compare,
 };
 
-struct dentry *adfs_lookup(struct inode *dir, struct dentry *dentry)
+struct dentry *adfs_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = NULL;
 	struct object_info obj;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/affs/namei.c linux-2.5.73-04-lookupintent/fs/affs/namei.c
--- linux-2.5.73-03-rpc_integ/fs/affs/namei.c	2003-03-17 07:33:20.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/affs/namei.c	2003-06-30 08:48:42.000000000 +0200
@@ -210,7 +210,7 @@
 }
 
 struct dentry *
-affs_lookup(struct inode *dir, struct dentry *dentry)
+affs_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct super_block *sb = dir->i_sb;
 	struct buffer_head *bh;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/afs/dir.c linux-2.5.73-04-lookupintent/fs/afs/dir.c
--- linux-2.5.73-03-rpc_integ/fs/afs/dir.c	2003-04-03 08:51:32.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/afs/dir.c	2003-06-30 08:48:42.000000000 +0200
@@ -23,10 +23,10 @@
 #include "super.h"
 #include "internal.h"
 
-static struct dentry *afs_dir_lookup(struct inode *dir, struct dentry *dentry);
+static struct dentry *afs_dir_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *);
 static int afs_dir_open(struct inode *inode, struct file *file);
 static int afs_dir_readdir(struct file *file, void *dirent, filldir_t filldir);
-static int afs_d_revalidate(struct dentry *dentry, int flags);
+static int afs_d_revalidate(struct dentry *dentry, struct nameidata *);
 static int afs_d_delete(struct dentry *dentry);
 static int afs_dir_lookup_filldir(void *_cookie, const char *name, int nlen, loff_t fpos,
 				     ino_t ino, unsigned dtype);
@@ -414,7 +414,7 @@
 /*
  * look up an entry in a directory
  */
-static struct dentry *afs_dir_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *afs_dir_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct afs_dir_lookup_cookie cookie;
 	struct afs_super_info *as;
@@ -487,7 +487,7 @@
  * - NOTE! the hit can be a negative hit too, so we can't assume we have an inode
  * (derived from nfs_lookup_revalidate)
  */
-static int afs_d_revalidate(struct dentry *dentry, int flags)
+static int afs_d_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
 	struct afs_dir_lookup_cookie cookie;
 	struct dentry *parent;
@@ -495,7 +495,7 @@
 	unsigned fpos;
 	int ret;
 
-	_enter("%s,%x",dentry->d_name.name,flags);
+	_enter("%s,%p",dentry->d_name.name,nd);
 
 	parent = dget_parent(dentry);
 	dir = parent->d_inode;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/afs/mntpt.c linux-2.5.73-04-lookupintent/fs/afs/mntpt.c
--- linux-2.5.73-03-rpc_integ/fs/afs/mntpt.c	2002-10-16 14:34:58.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/afs/mntpt.c	2003-06-30 08:48:42.000000000 +0200
@@ -21,7 +21,7 @@
 #include "internal.h"
 
 
-static struct dentry *afs_mntpt_lookup(struct inode *dir, struct dentry *dentry);
+static struct dentry *afs_mntpt_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *);
 static int afs_mntpt_open(struct inode *inode, struct file *file);
 
 struct file_operations afs_mntpt_file_operations = {
@@ -93,7 +93,7 @@
 /*
  * no valid lookup procedure on this sort of dir
  */
-static struct dentry *afs_mntpt_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *afs_mntpt_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	return ERR_PTR(-EREMOTE);
 } /* end afs_mntpt_lookup() */
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/autofs/root.c linux-2.5.73-04-lookupintent/fs/autofs/root.c
--- linux-2.5.73-03-rpc_integ/fs/autofs/root.c	2002-11-17 21:30:45.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/autofs/root.c	2003-06-30 08:48:42.000000000 +0200
@@ -18,7 +18,7 @@
 #include "autofs_i.h"
 
 static int autofs_root_readdir(struct file *,void *,filldir_t);
-static struct dentry *autofs_root_lookup(struct inode *,struct dentry *);
+static struct dentry *autofs_root_lookup(struct inode *,struct dentry *, struct nameidata *);
 static int autofs_root_symlink(struct inode *,struct dentry *,const char *);
 static int autofs_root_unlink(struct inode *,struct dentry *);
 static int autofs_root_rmdir(struct inode *,struct dentry *);
@@ -144,7 +144,7 @@
  * yet completely filled in, and revalidate has to delay such
  * lookups..
  */
-static int autofs_revalidate(struct dentry * dentry, int flags)
+static int autofs_revalidate(struct dentry * dentry, struct nameidata *nd)
 {
 	struct inode * dir;
 	struct autofs_sb_info *sbi;
@@ -195,7 +195,7 @@
 	.d_revalidate	= autofs_revalidate,
 };
 
-static struct dentry *autofs_root_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *autofs_root_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct autofs_sb_info *sbi;
 	int oz_mode;
@@ -230,7 +230,7 @@
 	d_add(dentry, NULL);
 
 	up(&dir->i_sem);
-	autofs_revalidate(dentry, 0);
+	autofs_revalidate(dentry, nd);
 	down(&dir->i_sem);
 
 	/*
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/autofs4/root.c linux-2.5.73-04-lookupintent/fs/autofs4/root.c
--- linux-2.5.73-03-rpc_integ/fs/autofs4/root.c	2003-05-26 08:19:27.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/autofs4/root.c	2003-06-30 08:48:42.000000000 +0200
@@ -18,13 +18,13 @@
 #include <linux/smp_lock.h>
 #include "autofs_i.h"
 
-static struct dentry *autofs4_dir_lookup(struct inode *,struct dentry *);
+static struct dentry *autofs4_dir_lookup(struct inode *,struct dentry *, struct nameidata *);
 static int autofs4_dir_symlink(struct inode *,struct dentry *,const char *);
 static int autofs4_dir_unlink(struct inode *,struct dentry *);
 static int autofs4_dir_rmdir(struct inode *,struct dentry *);
 static int autofs4_dir_mkdir(struct inode *,struct dentry *,int);
 static int autofs4_root_ioctl(struct inode *, struct file *,unsigned int,unsigned long);
-static struct dentry *autofs4_root_lookup(struct inode *,struct dentry *);
+static struct dentry *autofs4_root_lookup(struct inode *,struct dentry *, struct nameidata *);
 
 struct file_operations autofs4_root_operations = {
 	.open		= dcache_dir_open,
@@ -143,7 +143,7 @@
  * yet completely filled in, and revalidate has to delay such
  * lookups..
  */
-static int autofs4_root_revalidate(struct dentry * dentry, int flags)
+static int autofs4_root_revalidate(struct dentry * dentry, struct nameidata *nd)
 {
 	struct inode * dir = dentry->d_parent->d_inode;
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
@@ -183,7 +183,7 @@
 	return 1;
 }
 
-static int autofs4_revalidate(struct dentry *dentry, int flags)
+static int autofs4_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 
@@ -225,7 +225,7 @@
 /* Lookups in non-root dirs never find anything - if it's there, it's
    already in the dcache */
 /* SMP-safe */
-static struct dentry *autofs4_dir_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *autofs4_dir_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 #if 0
 	DPRINTK(("autofs_dir_lookup: ignoring lookup of %.*s/%.*s\n",
@@ -239,7 +239,7 @@
 }
 
 /* Lookups in the root directory */
-static struct dentry *autofs4_root_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *autofs4_root_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct autofs_sb_info *sbi;
 	int oz_mode;
@@ -276,7 +276,7 @@
 
 	if (dentry->d_op && dentry->d_op->d_revalidate) {
 		up(&dir->i_sem);
-		(dentry->d_op->d_revalidate)(dentry, 0);
+		(dentry->d_op->d_revalidate)(dentry, nd);
 		down(&dir->i_sem);
 	}
 
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/befs/linuxvfs.c linux-2.5.73-04-lookupintent/fs/befs/linuxvfs.c
--- linux-2.5.73-03-rpc_integ/fs/befs/linuxvfs.c	2003-06-20 22:16:06.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/befs/linuxvfs.c	2003-06-30 08:48:42.000000000 +0200
@@ -33,7 +33,7 @@
 static int befs_get_block(struct inode *, sector_t, struct buffer_head *, int);
 static int befs_readpage(struct file *file, struct page *page);
 static sector_t befs_bmap(struct address_space *mapping, sector_t block);
-static struct dentry *befs_lookup(struct inode *, struct dentry *);
+static struct dentry *befs_lookup(struct inode *, struct dentry *, struct nameidata *);
 static void befs_read_inode(struct inode *ino);
 static struct inode *befs_alloc_inode(struct super_block *sb);
 static void befs_destroy_inode(struct inode *inode);
@@ -163,7 +163,7 @@
 }
 
 static struct dentry *
-befs_lookup(struct inode *dir, struct dentry *dentry)
+befs_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = NULL;
 	struct super_block *sb = dir->i_sb;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/bfs/dir.c linux-2.5.73-04-lookupintent/fs/bfs/dir.c
--- linux-2.5.73-03-rpc_integ/fs/bfs/dir.c	2003-05-05 07:49:54.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/bfs/dir.c	2003-06-30 08:48:42.000000000 +0200
@@ -127,7 +127,7 @@
 	return 0;
 }
 
-static struct dentry * bfs_lookup(struct inode * dir, struct dentry * dentry)
+static struct dentry * bfs_lookup(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
 {
 	struct inode * inode = NULL;
 	struct buffer_head * bh;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/cifs/cifsfs.h linux-2.5.73-04-lookupintent/fs/cifs/cifsfs.h
--- linux-2.5.73-03-rpc_integ/fs/cifs/cifsfs.h	2003-02-15 23:10:23.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/cifs/cifsfs.h	2003-06-30 08:48:42.000000000 +0200
@@ -47,7 +47,7 @@
 /* Functions related to inodes */
 extern struct inode_operations cifs_dir_inode_ops;
 extern int cifs_create(struct inode *, struct dentry *, int);
-extern struct dentry *cifs_lookup(struct inode *, struct dentry *);
+extern struct dentry *cifs_lookup(struct inode *, struct dentry *, struct nameidata *);
 extern int cifs_unlink(struct inode *, struct dentry *);
 extern int cifs_hardlink(struct dentry *, struct inode *, struct dentry *);
 extern int cifs_mkdir(struct inode *, struct dentry *, int);
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/cifs/dir.c linux-2.5.73-04-lookupintent/fs/cifs/dir.c
--- linux-2.5.73-03-rpc_integ/fs/cifs/dir.c	2003-02-15 23:10:23.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/cifs/dir.c	2003-06-30 08:48:42.000000000 +0200
@@ -178,7 +178,7 @@
 }
 
 struct dentry *
-cifs_lookup(struct inode *parent_dir_inode, struct dentry *direntry)
+cifs_lookup(struct inode *parent_dir_inode, struct dentry *direntry, struct nameidata *nd)
 {
 	int rc, xid;
 	struct cifs_sb_info *cifs_sb;
@@ -262,7 +262,7 @@
 }
 
 static int
-cifs_d_revalidate(struct dentry *direntry, int flags)
+cifs_d_revalidate(struct dentry *direntry, struct nameidata *nd)
 {
 	int isValid = 1;
 
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/coda/dir.c linux-2.5.73-04-lookupintent/fs/coda/dir.c
--- linux-2.5.73-03-rpc_integ/fs/coda/dir.c	2002-11-20 12:19:02.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/coda/dir.c	2003-06-30 08:48:42.000000000 +0200
@@ -30,7 +30,7 @@
 /* dir inode-ops */
 static int coda_create(struct inode *dir, struct dentry *new, int mode);
 static int coda_mknod(struct inode *dir, struct dentry *new, int mode, dev_t rdev);
-static struct dentry *coda_lookup(struct inode *dir, struct dentry *target);
+static struct dentry *coda_lookup(struct inode *dir, struct dentry *target, struct nameidata *nd);
 static int coda_link(struct dentry *old_dentry, struct inode *dir_inode, 
 		     struct dentry *entry);
 static int coda_unlink(struct inode *dir_inode, struct dentry *entry);
@@ -45,7 +45,7 @@
 static int coda_readdir(struct file *file, void *dirent, filldir_t filldir);
 
 /* dentry ops */
-static int coda_dentry_revalidate(struct dentry *de, int);
+static int coda_dentry_revalidate(struct dentry *de, struct nameidata *nd);
 static int coda_dentry_delete(struct dentry *);
 
 /* support routines */
@@ -90,7 +90,7 @@
 
 /* inode operations for directories */
 /* access routines: lookup, readlink, permission */
-static struct dentry *coda_lookup(struct inode *dir, struct dentry *entry)
+static struct dentry *coda_lookup(struct inode *dir, struct dentry *entry, struct nameidata *nd)
 {
 	struct inode *res_inode = NULL;
 	struct ViceFid resfid = {0,0,0};
@@ -627,7 +627,7 @@
 }
 
 /* called when a cache lookup succeeds */
-static int coda_dentry_revalidate(struct dentry *de, int flags)
+static int coda_dentry_revalidate(struct dentry *de, struct nameidata *nd)
 {
 	struct inode *inode = de->d_inode;
 	struct coda_inode_info *cii;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/cramfs/inode.c linux-2.5.73-04-lookupintent/fs/cramfs/inode.c
--- linux-2.5.73-03-rpc_integ/fs/cramfs/inode.c	2003-06-20 22:16:06.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/cramfs/inode.c	2003-06-30 08:48:42.000000000 +0200
@@ -342,7 +342,7 @@
 /*
  * Lookup and fill in the inode data..
  */
-static struct dentry * cramfs_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry * cramfs_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	unsigned int offset = 0;
 	int sorted;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/devfs/base.c linux-2.5.73-04-lookupintent/fs/devfs/base.c
--- linux-2.5.73-03-rpc_integ/fs/devfs/base.c	2003-06-11 08:33:24.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/devfs/base.c	2003-06-30 08:48:42.000000000 +0200
@@ -2175,7 +2175,7 @@
     .d_iput       = devfs_d_iput,
 };
 
-static int devfs_d_revalidate_wait (struct dentry *dentry, int flags);
+static int devfs_d_revalidate_wait (struct dentry *dentry, struct nameidata *);
 
 static struct dentry_operations devfs_wait_dops =
 {
@@ -2212,7 +2212,7 @@
 
 /* XXX: this doesn't handle the case where we got a negative dentry
         but a devfs entry has been registered in the meanwhile */
-static int devfs_d_revalidate_wait (struct dentry *dentry, int flags)
+static int devfs_d_revalidate_wait (struct dentry *dentry, struct nameidata *nd)
 {
     struct inode *dir = dentry->d_parent->d_inode;
     struct fs_info *fs_info = dir->i_sb->s_fs_info;
@@ -2265,7 +2265,7 @@
 
 /*  Inode operations for device entries follow  */
 
-static struct dentry *devfs_lookup (struct inode *dir, struct dentry *dentry)
+static struct dentry *devfs_lookup (struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
     struct devfs_entry tmp;  /*  Must stay in scope until devfsd idle again  */
     struct devfs_lookup_struct lookup_info;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/efs/namei.c linux-2.5.73-04-lookupintent/fs/efs/namei.c
--- linux-2.5.73-03-rpc_integ/fs/efs/namei.c	2002-05-23 15:18:43.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/efs/namei.c	2003-06-30 08:48:42.000000000 +0200
@@ -57,7 +57,7 @@
 	return(0);
 }
 
-struct dentry *efs_lookup(struct inode *dir, struct dentry *dentry) {
+struct dentry *efs_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd) {
 	efs_ino_t inodenum;
 	struct inode * inode = NULL;
 
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/exec.c linux-2.5.73-04-lookupintent/fs/exec.c
--- linux-2.5.73-03-rpc_integ/fs/exec.c	2003-06-06 08:36:53.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/exec.c	2003-06-30 08:48:42.000000000 +0200
@@ -117,7 +117,8 @@
 	struct nameidata nd;
 	int error;
 
-	error = user_path_walk(library, &nd);
+	nd.u.open.flags = O_RDONLY;
+	error = __user_walk(library, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);
 	if (error)
 		goto out;
 
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/ext2/namei.c linux-2.5.73-04-lookupintent/fs/ext2/namei.c
--- linux-2.5.73-03-rpc_integ/fs/ext2/namei.c	2002-11-21 22:10:50.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/ext2/namei.c	2003-06-30 08:48:42.000000000 +0200
@@ -66,7 +66,7 @@
  * Methods themselves.
  */
 
-static struct dentry *ext2_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *ext2_lookup(struct inode * dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode * inode;
 	ino_t ino;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/ext3/namei.c linux-2.5.73-04-lookupintent/fs/ext3/namei.c
--- linux-2.5.73-03-rpc_integ/fs/ext3/namei.c	2003-06-26 01:30:59.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/ext3/namei.c	2003-06-30 08:48:42.000000000 +0200
@@ -970,7 +970,7 @@
 }
 #endif
 
-static struct dentry *ext3_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *ext3_lookup(struct inode * dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode * inode;
 	struct ext3_dir_entry_2 * de;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/freevxfs/vxfs_lookup.c linux-2.5.73-04-lookupintent/fs/freevxfs/vxfs_lookup.c
--- linux-2.5.73-03-rpc_integ/fs/freevxfs/vxfs_lookup.c	2002-04-24 18:20:09.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/freevxfs/vxfs_lookup.c	2003-06-30 08:48:42.000000000 +0200
@@ -51,7 +51,7 @@
 #define VXFS_BLOCK_PER_PAGE(sbp)  ((PAGE_CACHE_SIZE / (sbp)->s_blocksize))
 
 
-static struct dentry *	vxfs_lookup(struct inode *, struct dentry *);
+static struct dentry *	vxfs_lookup(struct inode *, struct dentry *, struct nameidata *);
 static int		vxfs_readdir(struct file *, void *, filldir_t);
 
 struct inode_operations vxfs_dir_inode_ops = {
@@ -193,6 +193,7 @@
  * vxfs_lookup - lookup pathname component
  * @dip:	dir in which we lookup
  * @dp:		dentry we lookup
+ * @nd:		lookup nameidata
  *
  * Description:
  *   vxfs_lookup tries to lookup the pathname component described
@@ -203,7 +204,7 @@
  *   in the return pointer.
  */
 static struct dentry *
-vxfs_lookup(struct inode *dip, struct dentry *dp)
+vxfs_lookup(struct inode *dip, struct dentry *dp, struct nameidata *nd)
 {
 	struct inode		*ip = NULL;
 	ino_t			ino;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/hfs/dir_cap.c linux-2.5.73-04-lookupintent/fs/hfs/dir_cap.c
--- linux-2.5.73-03-rpc_integ/fs/hfs/dir_cap.c	2002-10-07 22:51:35.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/hfs/dir_cap.c	2003-06-30 08:48:42.000000000 +0200
@@ -28,7 +28,7 @@
 
 /*================ Forward declarations ================*/
 
-static struct dentry *cap_lookup(struct inode *, struct dentry *);
+static struct dentry *cap_lookup(struct inode *, struct dentry *, struct nameidata *);
 static int cap_readdir(struct file *, void *, filldir_t);
 
 /*================ Global variables ================*/
@@ -95,7 +95,7 @@
  * inode corresponding to an entry in a directory, given the inode for
  * the directory and the name (and its length) of the entry.
  */
-static struct dentry *cap_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *cap_lookup(struct inode * dir, struct dentry *dentry, struct nameidata *nd)
 {
 	ino_t dtype;
 	struct hfs_name cname;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/hfs/dir_dbl.c linux-2.5.73-04-lookupintent/fs/hfs/dir_dbl.c
--- linux-2.5.73-03-rpc_integ/fs/hfs/dir_dbl.c	2002-10-07 22:51:35.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/hfs/dir_dbl.c	2003-06-30 08:48:42.000000000 +0200
@@ -24,7 +24,7 @@
 
 /*================ Forward declarations ================*/
 
-static struct dentry *dbl_lookup(struct inode *, struct dentry *);
+static struct dentry *dbl_lookup(struct inode *, struct dentry *, struct nameidata *);
 static int dbl_readdir(struct file *, void *, filldir_t);
 static int dbl_create(struct inode *, struct dentry *, int);
 static int dbl_mkdir(struct inode *, struct dentry *, int);
@@ -108,7 +108,7 @@
  * the inode for the directory and the name (and its length) of the
  * entry.
  */
-static struct dentry *dbl_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *dbl_lookup(struct inode * dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct hfs_name cname;
 	struct hfs_cat_entry *entry;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/hfs/dir_nat.c linux-2.5.73-04-lookupintent/fs/hfs/dir_nat.c
--- linux-2.5.73-03-rpc_integ/fs/hfs/dir_nat.c	2002-10-07 22:51:36.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/hfs/dir_nat.c	2003-06-30 08:48:42.000000000 +0200
@@ -30,7 +30,7 @@
 
 /*================ Forward declarations ================*/
 
-static struct dentry *nat_lookup(struct inode *, struct dentry *);
+static struct dentry *nat_lookup(struct inode *, struct dentry *, struct nameidata *);
 static int nat_readdir(struct file *, void *, filldir_t);
 static int nat_rmdir(struct inode *, struct dentry *);
 static int nat_hdr_unlink(struct inode *, struct dentry *);
@@ -97,7 +97,7 @@
  * the inode corresponding to an entry in a directory, given the inode
  * for the directory and the name (and its length) of the entry.
  */
-static struct dentry *nat_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *nat_lookup(struct inode * dir, struct dentry *dentry, struct nameidata *nd)
 {
 	ino_t dtype;
 	struct hfs_name cname;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/hfs/sysdep.c linux-2.5.73-04-lookupintent/fs/hfs/sysdep.c
--- linux-2.5.73-03-rpc_integ/fs/hfs/sysdep.c	2002-11-17 20:53:57.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/hfs/sysdep.c	2003-06-30 08:48:42.000000000 +0200
@@ -19,7 +19,7 @@
 #include <linux/hfs_fs.h>
 #include <linux/smp_lock.h>
 
-static int hfs_revalidate_dentry(struct dentry *, int);
+static int hfs_revalidate_dentry(struct dentry *, struct nameidata *);
 static int hfs_hash_dentry(struct dentry *, struct qstr *);
 static int hfs_compare_dentry(struct dentry *, struct qstr *, struct qstr *);
 static void hfs_dentry_iput(struct dentry *, struct inode *);
@@ -90,7 +90,7 @@
 	iput(inode);
 }
 
-static int hfs_revalidate_dentry(struct dentry *dentry, int flags)
+static int hfs_revalidate_dentry(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
 	int diff;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/hpfs/dir.c linux-2.5.73-04-lookupintent/fs/hpfs/dir.c
--- linux-2.5.73-03-rpc_integ/fs/hpfs/dir.c	2002-11-17 20:53:57.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/hpfs/dir.c	2003-06-30 08:48:42.000000000 +0200
@@ -198,7 +198,7 @@
  *	      to tell read_inode to read fnode or not.
  */
 
-struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry)
+struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	const char *name = dentry->d_name.name;
 	unsigned len = dentry->d_name.len;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/hpfs/hpfs_fn.h linux-2.5.73-04-lookupintent/fs/hpfs/hpfs_fn.h
--- linux-2.5.73-03-rpc_integ/fs/hpfs/hpfs_fn.h	2003-06-20 22:16:06.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/hpfs/hpfs_fn.h	2003-06-30 08:48:42.000000000 +0200
@@ -216,7 +216,7 @@
 int hpfs_dir_release(struct inode *, struct file *);
 loff_t hpfs_dir_lseek(struct file *, loff_t, int);
 int hpfs_readdir(struct file *, void *, filldir_t);
-struct dentry *hpfs_lookup(struct inode *, struct dentry *);
+struct dentry *hpfs_lookup(struct inode *, struct dentry *, struct nameidata *);
 
 /* dnode.c */
 
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/intermezzo/dcache.c linux-2.5.73-04-lookupintent/fs/intermezzo/dcache.c
--- linux-2.5.73-03-rpc_integ/fs/intermezzo/dcache.c	2003-03-14 01:52:26.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/intermezzo/dcache.c	2003-06-30 08:48:42.000000000 +0200
@@ -50,7 +50,7 @@
 kmem_cache_t * presto_dentry_slab;
 
 /* called when a cache lookup succeeds */
-static int presto_d_revalidate(struct dentry *de, int flag)
+static int presto_d_revalidate(struct dentry *de, struct nameidata *nd)
 {
         struct inode *inode = de->d_inode;
         struct presto_file_set * root_fset;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/intermezzo/dir.c linux-2.5.73-04-lookupintent/fs/intermezzo/dir.c
--- linux-2.5.73-03-rpc_integ/fs/intermezzo/dir.c	2003-03-18 18:08:01.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/intermezzo/dir.c	2003-06-30 08:48:42.000000000 +0200
@@ -239,7 +239,7 @@
         return de;
 }
 
-struct dentry *presto_lookup(struct inode * dir, struct dentry *dentry)
+struct dentry *presto_lookup(struct inode * dir, struct dentry *dentry, struct nameidata *nd)
 {
         int rc = 0;
         struct dentry *de;
@@ -286,7 +286,7 @@
                                 (dir, dentry, ino, generation);
                         is_ilookup = 1;
                 } else
-                        de = iops->lookup(dir, dentry);
+                        de = iops->lookup(dir, dentry, nd);
 #if 0
         }
 #endif
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/intermezzo/intermezzo_fs.h linux-2.5.73-04-lookupintent/fs/intermezzo/intermezzo_fs.h
--- linux-2.5.73-03-rpc_integ/fs/intermezzo/intermezzo_fs.h	2003-06-20 22:16:06.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/intermezzo/intermezzo_fs.h	2003-06-30 08:48:42.000000000 +0200
@@ -370,7 +370,7 @@
 # define PRESTO_ILOOKUP_MAGIC "...ino:"
 # define PRESTO_ILOOKUP_SEP ':'
 int izo_dentry_is_ilookup(struct dentry *, ino_t *id, unsigned int *generation);
-struct dentry *presto_lookup(struct inode * dir, struct dentry *dentry);
+struct dentry *presto_lookup(struct inode * dir, struct dentry *dentry, struct nameidata *nd);
 
 struct presto_dentry_data {
         int dd_count; /* how mnay dentries are using this dentry */
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/isofs/namei.c linux-2.5.73-04-lookupintent/fs/isofs/namei.c
--- linux-2.5.73-03-rpc_integ/fs/isofs/namei.c	2002-05-23 15:18:50.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/isofs/namei.c	2003-06-30 08:48:42.000000000 +0200
@@ -158,7 +158,7 @@
 	return 0;
 }
 
-struct dentry *isofs_lookup(struct inode * dir, struct dentry * dentry)
+struct dentry *isofs_lookup(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
 {
 	unsigned long ino;
 	struct inode *inode;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/jffs/inode-v23.c linux-2.5.73-04-lookupintent/fs/jffs/inode-v23.c
--- linux-2.5.73-03-rpc_integ/fs/jffs/inode-v23.c	2003-05-26 05:01:37.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/jffs/inode-v23.c	2003-06-30 08:48:42.000000000 +0200
@@ -642,7 +642,7 @@
 /* Find a file in a directory. If the file exists, return its
    corresponding dentry.  */
 static struct dentry *
-jffs_lookup(struct inode *dir, struct dentry *dentry)
+jffs_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct jffs_file *d;
 	struct jffs_file *f;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/jffs2/dir.c linux-2.5.73-04-lookupintent/fs/jffs2/dir.c
--- linux-2.5.73-03-rpc_integ/fs/jffs2/dir.c	2003-06-23 14:42:27.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/jffs2/dir.c	2003-06-30 08:48:42.000000000 +0200
@@ -33,7 +33,7 @@
 static int jffs2_readdir (struct file *, void *, filldir_t);
 
 static int jffs2_create (struct inode *,struct dentry *,int);
-static struct dentry *jffs2_lookup (struct inode *,struct dentry *);
+static struct dentry *jffs2_lookup (struct inode *,struct dentry *, struct nameidata *);
 static int jffs2_link (struct dentry *,struct inode *,struct dentry *);
 static int jffs2_unlink (struct inode *,struct dentry *);
 static int jffs2_symlink (struct inode *,struct dentry *,const char *);
@@ -73,7 +73,7 @@
    and we use the same hash function as the dentries. Makes this 
    nice and simple
 */
-static struct dentry *jffs2_lookup(struct inode *dir_i, struct dentry *target)
+static struct dentry *jffs2_lookup(struct inode *dir_i, struct dentry *target, struct nameidata *nd)
 {
 	struct jffs2_inode_info *dir_f;
 	struct jffs2_sb_info *c;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/jfs/namei.c linux-2.5.73-04-lookupintent/fs/jfs/namei.c
--- linux-2.5.73-03-rpc_integ/fs/jfs/namei.c	2003-06-11 19:26:32.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/jfs/namei.c	2003-06-30 08:48:42.000000000 +0200
@@ -1373,7 +1373,7 @@
 	return -rc;
 }
 
-static struct dentry *jfs_lookup(struct inode *dip, struct dentry *dentry)
+static struct dentry *jfs_lookup(struct inode *dip, struct dentry *dentry, struct nameidata *nd)
 {
 	struct btstack btstack;
 	ino_t inum;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/libfs.c linux-2.5.73-04-lookupintent/fs/libfs.c
--- linux-2.5.73-03-rpc_integ/fs/libfs.c	2003-06-20 22:16:06.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/libfs.c	2003-06-30 08:48:42.000000000 +0200
@@ -29,7 +29,7 @@
  * exist, we know it is negative.
  */
 
-struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry)
+struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	d_add(dentry, NULL);
 	return NULL;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/minix/namei.c linux-2.5.73-04-lookupintent/fs/minix/namei.c
--- linux-2.5.73-03-rpc_integ/fs/minix/namei.c	2002-11-20 12:19:02.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/minix/namei.c	2003-06-30 08:48:42.000000000 +0200
@@ -54,7 +54,7 @@
 	.d_hash		= minix_hash,
 };
 
-static struct dentry *minix_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *minix_lookup(struct inode * dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode * inode = NULL;
 	ino_t ino;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/msdos/namei.c linux-2.5.73-04-lookupintent/fs/msdos/namei.c
--- linux-2.5.73-03-rpc_integ/fs/msdos/namei.c	2003-05-27 16:32:40.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/msdos/namei.c	2003-06-30 08:48:42.000000000 +0200
@@ -193,7 +193,7 @@
  */
 
 /***** Get inode using directory and name */
-struct dentry *msdos_lookup(struct inode *dir,struct dentry *dentry)
+struct dentry *msdos_lookup(struct inode *dir,struct dentry *dentry, struct nameidata *nd)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/namei.c linux-2.5.73-04-lookupintent/fs/namei.c
--- linux-2.5.73-03-rpc_integ/fs/namei.c	2003-06-17 07:09:04.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/namei.c	2003-06-30 08:48:42.000000000 +0200
@@ -273,7 +273,7 @@
  * Internal lookup() using the new generic dcache.
  * SMP-safe
  */
-static struct dentry * cached_lookup(struct dentry * parent, struct qstr * name, int flags)
+static struct dentry * cached_lookup(struct dentry * parent, struct qstr * name, struct nameidata *nd)
 {
 	struct dentry * dentry = __d_lookup(parent, name);
 
@@ -284,7 +284,7 @@
 		dentry = d_lookup(parent, name);
 
 	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
-		if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) {
+		if (!dentry->d_op->d_revalidate(dentry, nd) && !d_invalidate(dentry)) {
 			dput(dentry);
 			dentry = NULL;
 		}
@@ -336,7 +336,7 @@
  * make sure that nobody added the entry to the dcache in the meantime..
  * SMP-safe
  */
-static struct dentry * real_lookup(struct dentry * parent, struct qstr * name, int flags)
+static struct dentry * real_lookup(struct dentry * parent, struct qstr * name, struct nameidata *nd)
 {
 	struct dentry * result;
 	struct inode *dir = parent->d_inode;
@@ -361,7 +361,7 @@
 		struct dentry * dentry = d_alloc(parent, name);
 		result = ERR_PTR(-ENOMEM);
 		if (dentry) {
-			result = dir->i_op->lookup(dir, dentry);
+			result = dir->i_op->lookup(dir, dentry, nd);
 			if (result)
 				dput(dentry);
 			else
@@ -377,7 +377,7 @@
 	 */
 	up(&dir->i_sem);
 	if (result->d_op && result->d_op->d_revalidate) {
-		if (!result->d_op->d_revalidate(result, flags) && !d_invalidate(result)) {
+		if (!result->d_op->d_revalidate(result, nd) && !d_invalidate(result)) {
 			dput(result);
 			result = ERR_PTR(-ENOENT);
 		}
@@ -524,7 +524,7 @@
  *  It _is_ time-critical.
  */
 static int do_lookup(struct nameidata *nd, struct qstr *name,
-		     struct path *path, int flags)
+		     struct path *path)
 {
 	struct vfsmount *mnt = nd->mnt;
 	struct dentry *dentry = __d_lookup(nd->dentry, name);
@@ -539,13 +539,13 @@
 	return 0;
 
 need_lookup:
-	dentry = real_lookup(nd->dentry, name, LOOKUP_CONTINUE);
+	dentry = real_lookup(nd->dentry, name, nd);
 	if (IS_ERR(dentry))
 		goto fail;
 	goto done;
 
 need_revalidate:
-	if (dentry->d_op->d_revalidate(dentry, flags))
+	if (dentry->d_op->d_revalidate(dentry, nd))
 		goto done;
 	if (d_invalidate(dentry))
 		goto done;
@@ -638,8 +638,9 @@
 			if (err < 0)
 				break;
 		}
+		nd->flags |= LOOKUP_CONTINUE;
 		/* This does the actual lookups.. */
-		err = do_lookup(nd, &this, &next, LOOKUP_CONTINUE);
+		err = do_lookup(nd, &this, &next);
 		if (err)
 			break;
 		/* Check mountpoints.. */
@@ -681,6 +682,7 @@
 last_with_slashes:
 		lookup_flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 last_component:
+		nd->flags &= ~LOOKUP_CONTINUE;
 		if (lookup_flags & LOOKUP_PARENT)
 			goto lookup_parent;
 		if (this.name[0] == '.') switch (this.len) {
@@ -700,7 +702,7 @@
 			if (err < 0)
 				break;
 		}
-		err = do_lookup(nd, &this, &next, 0);
+		err = do_lookup(nd, &this, &next);
 		if (err)
 			break;
 		follow_mount(&next.mnt, &next.dentry);
@@ -769,6 +771,7 @@
 		 */
 		nd_root.last_type = LAST_ROOT;
 		nd_root.flags = nd->flags;
+		memcpy(&nd_root.u, &nd->u, sizeof(nd_root.u));
 		read_lock(&current->fs->lock);
 		nd_root.mnt = mntget(current->fs->rootmnt);
 		nd_root.dentry = dget(current->fs->root);
@@ -866,7 +869,7 @@
  * needs parent already locked. Doesn't follow mounts.
  * SMP-safe.
  */
-struct dentry * lookup_hash(struct qstr *name, struct dentry * base)
+static struct dentry * __lookup_hash(struct qstr *name, struct dentry * base, struct nameidata *nd)
 {
 	struct dentry * dentry;
 	struct inode *inode;
@@ -889,13 +892,13 @@
 			goto out;
 	}
 
-	dentry = cached_lookup(base, name, 0);
+	dentry = cached_lookup(base, name, nd);
 	if (!dentry) {
 		struct dentry *new = d_alloc(base, name);
 		dentry = ERR_PTR(-ENOMEM);
 		if (!new)
 			goto out;
-		dentry = inode->i_op->lookup(inode, new);
+		dentry = inode->i_op->lookup(inode, new, nd);
 		if (!dentry)
 			dentry = new;
 		else
@@ -905,6 +908,11 @@
 	return dentry;
 }
 
+struct dentry * lookup_hash(struct qstr *name, struct dentry * base)
+{
+	return __lookup_hash(name, base, NULL);
+}
+
 /* SMP-safe */
 struct dentry * lookup_one_len(const char * name, struct dentry * base, int len)
 {
@@ -1222,11 +1230,15 @@
 	if (flag & O_APPEND)
 		acc_mode |= MAY_APPEND;
 
+	/* Fill in the open() intent data */
+	nd->u.open.flags = flag;
+	nd->u.open.create_mode = mode;
+
 	/*
 	 * The simplest case - just a plain lookup.
 	 */
 	if (!(flag & O_CREAT)) {
-		error = path_lookup(pathname, lookup_flags(flag), nd);
+		error = path_lookup(pathname, lookup_flags(flag)|LOOKUP_OPEN, nd);
 		if (error)
 			return error;
 		dentry = nd->dentry;
@@ -1236,7 +1248,7 @@
 	/*
 	 * Create - we need to know the parent.
 	 */
-	error = path_lookup(pathname, LOOKUP_PARENT, nd);
+	error = path_lookup(pathname, LOOKUP_PARENT|LOOKUP_OPEN|LOOKUP_CREATE, nd);
 	if (error)
 		return error;
 
@@ -1250,8 +1262,9 @@
 		goto exit;
 
 	dir = nd->dentry;
+	nd->flags &= ~LOOKUP_PARENT;
 	down(&dir->d_inode->i_sem);
-	dentry = lookup_hash(&nd->last, nd->dentry);
+	dentry = __lookup_hash(&nd->last, nd->dentry, nd);
 
 do_last:
 	error = PTR_ERR(dentry);
@@ -1354,7 +1367,7 @@
 	}
 	dir = nd->dentry;
 	down(&dir->d_inode->i_sem);
-	dentry = lookup_hash(&nd->last, nd->dentry);
+	dentry = __lookup_hash(&nd->last, nd->dentry, nd);
 	putname(nd->last.name);
 	goto do_last;
 }
@@ -1368,6 +1381,7 @@
 	dentry = ERR_PTR(-EEXIST);
 	if (nd->last_type != LAST_NORM)
 		goto fail;
+	nd->flags &= ~LOOKUP_PARENT;
 	dentry = lookup_hash(&nd->last, nd->dentry);
 	if (IS_ERR(dentry))
 		goto fail;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/ncpfs/dir.c linux-2.5.73-04-lookupintent/fs/ncpfs/dir.c
--- linux-2.5.73-03-rpc_integ/fs/ncpfs/dir.c	2003-04-03 08:51:32.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/ncpfs/dir.c	2003-06-30 08:48:42.000000000 +0200
@@ -35,7 +35,7 @@
 static int ncp_readdir(struct file *, void *, filldir_t);
 
 static int ncp_create(struct inode *, struct dentry *, int);
-static struct dentry *ncp_lookup(struct inode *, struct dentry *);
+static struct dentry *ncp_lookup(struct inode *, struct dentry *, struct nameidata *);
 static int ncp_unlink(struct inode *, struct dentry *);
 static int ncp_mkdir(struct inode *, struct dentry *, int);
 static int ncp_rmdir(struct inode *, struct dentry *);
@@ -72,7 +72,7 @@
 /*
  * Dentry operations routines
  */
-static int ncp_lookup_validate(struct dentry *, int);
+static int ncp_lookup_validate(struct dentry *, struct nameidata *);
 static int ncp_hash_dentry(struct dentry *, struct qstr *);
 static int ncp_compare_dentry (struct dentry *, struct qstr *, struct qstr *);
 static int ncp_delete_dentry(struct dentry *);
@@ -264,7 +264,7 @@
 
 
 static int
-__ncp_lookup_validate(struct dentry * dentry, int flags)
+__ncp_lookup_validate(struct dentry * dentry, struct nameidata *nd)
 {
 	struct ncp_server *server;
 	struct dentry *parent;
@@ -333,11 +333,11 @@
 }
 
 static int
-ncp_lookup_validate(struct dentry * dentry, int flags)
+ncp_lookup_validate(struct dentry * dentry, struct nameidata *nd)
 {
 	int res;
 	lock_kernel();
-	res = __ncp_lookup_validate(dentry, flags);
+	res = __ncp_lookup_validate(dentry, nd);
 	unlock_kernel();
 	return res;
 }
@@ -797,7 +797,7 @@
 	return result;
 }
 
-static struct dentry *ncp_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *ncp_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct ncp_server *server = NCP_SERVER(dir);
 	struct inode *inode = NULL;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/nfs/dir.c linux-2.5.73-04-lookupintent/fs/nfs/dir.c
--- linux-2.5.73-03-rpc_integ/fs/nfs/dir.c	2003-06-26 01:30:54.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/nfs/dir.c	2003-06-30 08:48:42.000000000 +0200
@@ -37,7 +37,7 @@
 
 static int nfs_opendir(struct inode *, struct file *);
 static int nfs_readdir(struct file *, void *, filldir_t);
-static struct dentry *nfs_lookup(struct inode *, struct dentry *);
+static struct dentry *nfs_lookup(struct inode *, struct dentry *, struct nameidata *);
 static int nfs_cached_lookup(struct inode *, struct dentry *,
 				struct nfs_fh *, struct nfs_fattr *);
 static int nfs_create(struct inode *, struct dentry *, int);
@@ -515,7 +515,7 @@
  * If the parent directory is seen to have changed, we throw out the
  * cached dentry and do a new lookup.
  */
-static int nfs_lookup_revalidate(struct dentry * dentry, int flags)
+static int nfs_lookup_revalidate(struct dentry * dentry, struct nameidata *nd)
 {
 	struct inode *dir;
 	struct inode *inode;
@@ -630,7 +630,7 @@
 	.d_iput		= nfs_dentry_iput,
 };
 
-static struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry)
+static struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd)
 {
 	struct inode *inode = NULL;
 	int error;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/ntfs/namei.c linux-2.5.73-04-lookupintent/fs/ntfs/namei.c
--- linux-2.5.73-03-rpc_integ/fs/ntfs/namei.c	2003-04-30 14:51:58.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/ntfs/namei.c	2003-06-30 08:48:42.000000000 +0200
@@ -29,6 +29,7 @@
  * ntfs_lookup - find the inode represented by a dentry in a directory inode
  * @dir_ino:	directory inode in which to look for the inode
  * @dent:	dentry representing the inode to look for
+ * @nd:		lookup nameidata
  *
  * In short, ntfs_lookup() looks for the inode represented by the dentry @dent
  * in the directory inode @dir_ino and if found attaches the inode to the
@@ -87,7 +88,7 @@
  *    name. We then convert the name to the current NLS code page, and proceed
  *    searching for a dentry with this name, etc, as in case 2), above.
  */
-static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent)
+static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent, struct nameidata *nd)
 {
 	ntfs_volume *vol = NTFS_SB(dir_ino->i_sb);
 	struct inode *dent_inode;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/openpromfs/inode.c linux-2.5.73-04-lookupintent/fs/openpromfs/inode.c
--- linux-2.5.73-03-rpc_integ/fs/openpromfs/inode.c	2003-05-26 05:01:15.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/openpromfs/inode.c	2003-06-30 08:48:42.000000000 +0200
@@ -61,7 +61,7 @@
 
 static int openpromfs_create (struct inode *, struct dentry *, int);
 static int openpromfs_readdir(struct file *, void *, filldir_t);
-static struct dentry *openpromfs_lookup(struct inode *, struct dentry *dentry);
+static struct dentry *openpromfs_lookup(struct inode *, struct dentry *dentry, struct nameidata *nd);
 static int openpromfs_unlink (struct inode *, struct dentry *dentry);
 
 static ssize_t nodenum_read(struct file *file, char *buf,
@@ -639,7 +639,7 @@
 	return 0;
 }
 
-static struct dentry *openpromfs_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *openpromfs_lookup(struct inode * dir, struct dentry *dentry, struct nameidata *nd)
 {
 	int ino = 0;
 #define OPFSL_DIR	0
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/proc/base.c linux-2.5.73-04-lookupintent/fs/proc/base.c
--- linux-2.5.73-03-rpc_integ/fs/proc/base.c	2003-06-20 22:16:23.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/proc/base.c	2003-06-30 08:48:43.000000000 +0200
@@ -864,7 +864,7 @@
  * directory. In this case, however, we can do it - no aliasing problems
  * due to the way we treat inodes.
  */
-static int pid_revalidate(struct dentry * dentry, int flags)
+static int pid_revalidate(struct dentry * dentry, struct nameidata *nd)
 {
 	if (pid_alive(proc_task(dentry->d_inode)))
 		return 1;
@@ -872,7 +872,7 @@
 	return 0;
 }
 
-static int pid_fd_revalidate(struct dentry * dentry, int flags)
+static int pid_fd_revalidate(struct dentry * dentry, struct nameidata *nd)
 {
 	struct task_struct *task = proc_task(dentry->d_inode);
 	int fd = proc_type(dentry->d_inode) - PROC_PID_FD_DIR;
@@ -961,7 +961,7 @@
 }
 
 /* SMP-safe */
-static struct dentry *proc_lookupfd(struct inode * dir, struct dentry * dentry)
+static struct dentry *proc_lookupfd(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
 {
 	struct task_struct *task = proc_task(dir);
 	unsigned fd = name_to_int(dentry);
@@ -1219,7 +1219,7 @@
 	return ERR_PTR(error);
 }
 
-static struct dentry *proc_base_lookup(struct inode *dir, struct dentry *dentry){
+static struct dentry *proc_base_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd){
 	return proc_pident_lookup(dir, dentry, base_stuff);
 }
 
@@ -1326,7 +1326,7 @@
 }
 
 /* SMP-safe */
-struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry)
+struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd)
 {
 	struct task_struct *task;
 	struct inode *inode;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/proc/generic.c linux-2.5.73-04-lookupintent/fs/proc/generic.c
--- linux-2.5.73-03-rpc_integ/fs/proc/generic.c	2003-04-25 17:46:19.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/proc/generic.c	2003-06-30 08:48:43.000000000 +0200
@@ -336,7 +336,7 @@
  * Don't create negative dentries here, return -ENOENT by hand
  * instead.
  */
-struct dentry *proc_lookup(struct inode * dir, struct dentry *dentry)
+struct dentry *proc_lookup(struct inode * dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = NULL;
 	struct proc_dir_entry * de;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/proc/root.c linux-2.5.73-04-lookupintent/fs/proc/root.c
--- linux-2.5.73-03-rpc_integ/fs/proc/root.c	2003-05-26 03:48:57.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/proc/root.c	2003-06-30 08:48:43.000000000 +0200
@@ -79,7 +79,7 @@
 	proc_bus = proc_mkdir("bus", 0);
 }
 
-static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry)
+static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
 {
 	if (dir->i_ino == PROC_ROOT_INO) { /* check for safety... */
 		lock_kernel();
@@ -87,11 +87,11 @@
 		unlock_kernel();
 	}
 
-	if (!proc_lookup(dir, dentry)) {
+	if (!proc_lookup(dir, dentry, nd)) {
 		return NULL;
 	}
 	
-	return proc_pid_lookup(dir, dentry);
+	return proc_pid_lookup(dir, dentry, nd);
 }
 
 static int proc_root_readdir(struct file * filp,
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/qnx4/namei.c linux-2.5.73-04-lookupintent/fs/qnx4/namei.c
--- linux-2.5.73-03-rpc_integ/fs/qnx4/namei.c	2002-05-23 15:18:54.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/qnx4/namei.c	2003-06-30 08:48:43.000000000 +0200
@@ -107,7 +107,7 @@
 	return NULL;
 }
 
-struct dentry * qnx4_lookup(struct inode *dir, struct dentry *dentry)
+struct dentry * qnx4_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	int ino;
 	struct qnx4_inode_entry *de;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/reiserfs/namei.c linux-2.5.73-04-lookupintent/fs/reiserfs/namei.c
--- linux-2.5.73-03-rpc_integ/fs/reiserfs/namei.c	2002-12-07 11:19:52.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/reiserfs/namei.c	2003-06-30 08:48:43.000000000 +0200
@@ -316,7 +316,7 @@
 }
 
 
-static struct dentry * reiserfs_lookup (struct inode * dir, struct dentry * dentry)
+static struct dentry * reiserfs_lookup (struct inode * dir, struct dentry * dentry, struct nameidata *nd)
 {
     int retval;
     struct inode * inode = NULL;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/romfs/inode.c linux-2.5.73-04-lookupintent/fs/romfs/inode.c
--- linux-2.5.73-03-rpc_integ/fs/romfs/inode.c	2003-06-20 22:16:06.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/romfs/inode.c	2003-06-30 08:48:43.000000000 +0200
@@ -329,7 +329,7 @@
 }
 
 static struct dentry *
-romfs_lookup(struct inode *dir, struct dentry *dentry)
+romfs_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	unsigned long offset, maxoff;
 	int fslen, res;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/smbfs/dir.c linux-2.5.73-04-lookupintent/fs/smbfs/dir.c
--- linux-2.5.73-03-rpc_integ/fs/smbfs/dir.c	2003-04-03 08:51:32.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/smbfs/dir.c	2003-06-30 08:48:43.000000000 +0200
@@ -24,7 +24,7 @@
 static int smb_readdir(struct file *, void *, filldir_t);
 static int smb_dir_open(struct inode *, struct file *);
 
-static struct dentry *smb_lookup(struct inode *, struct dentry *);
+static struct dentry *smb_lookup(struct inode *, struct dentry *, struct nameidata *);
 static int smb_create(struct inode *, struct dentry *, int);
 static int smb_mkdir(struct inode *, struct dentry *, int);
 static int smb_rmdir(struct inode *, struct dentry *);
@@ -268,7 +268,7 @@
 /*
  * Dentry operations routines
  */
-static int smb_lookup_validate(struct dentry *, int);
+static int smb_lookup_validate(struct dentry *, struct nameidata *);
 static int smb_hash_dentry(struct dentry *, struct qstr *);
 static int smb_compare_dentry(struct dentry *, struct qstr *, struct qstr *);
 static int smb_delete_dentry(struct dentry *);
@@ -292,7 +292,7 @@
  * This is the callback when the dcache has a lookup hit.
  */
 static int
-smb_lookup_validate(struct dentry * dentry, int flags)
+smb_lookup_validate(struct dentry * dentry, struct nameidata *nd)
 {
 	struct smb_sb_info *server = server_from_dentry(dentry);
 	struct inode * inode = dentry->d_inode;
@@ -420,7 +420,7 @@
 }
 
 static struct dentry *
-smb_lookup(struct inode *dir, struct dentry *dentry)
+smb_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct smb_fattr finfo;
 	struct inode *inode;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/sysv/namei.c linux-2.5.73-04-lookupintent/fs/sysv/namei.c
--- linux-2.5.73-03-rpc_integ/fs/sysv/namei.c	2002-11-20 12:19:02.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/sysv/namei.c	2003-06-30 08:48:43.000000000 +0200
@@ -64,7 +64,7 @@
 	.d_hash		= sysv_hash,
 };
 
-static struct dentry *sysv_lookup(struct inode * dir, struct dentry * dentry)
+static struct dentry *sysv_lookup(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
 {
 	struct inode * inode = NULL;
 	ino_t ino;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/udf/namei.c linux-2.5.73-04-lookupintent/fs/udf/namei.c
--- linux-2.5.73-03-rpc_integ/fs/udf/namei.c	2002-11-20 12:19:02.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/udf/namei.c	2003-06-30 08:48:43.000000000 +0200
@@ -289,6 +289,7 @@
  * PRE-CONDITIONS
  *	dir			Pointer to inode of parent directory.
  *	dentry			Pointer to dentry to complete.
+ *	nd			Pointer to lookup nameidata
  *
  * POST-CONDITIONS
  *	<return>		Zero on success.
@@ -299,7 +300,7 @@
  */
 
 static struct dentry *
-udf_lookup(struct inode *dir, struct dentry *dentry)
+udf_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = NULL;
 	struct fileIdentDesc cfi, *fi;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/ufs/namei.c linux-2.5.73-04-lookupintent/fs/ufs/namei.c
--- linux-2.5.73-03-rpc_integ/fs/ufs/namei.c	2002-11-20 12:19:02.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/ufs/namei.c	2003-06-30 08:48:43.000000000 +0200
@@ -62,7 +62,7 @@
 	return err;
 }
 
-static struct dentry *ufs_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *ufs_lookup(struct inode * dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode * inode = NULL;
 	ino_t ino;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/umsdos/dir.c linux-2.5.73-04-lookupintent/fs/umsdos/dir.c
--- linux-2.5.73-03-rpc_integ/fs/umsdos/dir.c	2002-11-05 16:35:59.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/umsdos/dir.c	2003-06-30 08:48:43.000000000 +0200
@@ -30,7 +30,7 @@
  */
 
 /* nothing for now ... */
-static int umsdos_dentry_validate(struct dentry *dentry, int flags)
+static int umsdos_dentry_validate(struct dentry *dentry, struct nameidata *nd)
 {
 	return 1;
 }
@@ -564,7 +564,7 @@
  * Called by VFS; should fill dentry->d_inode via d_add.
  */
 
-struct dentry *UMSDOS_lookup (struct inode *dir, struct dentry *dentry)
+struct dentry *UMSDOS_lookup (struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct dentry *ret;
 
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/umsdos/rdir.c linux-2.5.73-04-lookupintent/fs/umsdos/rdir.c
--- linux-2.5.73-03-rpc_integ/fs/umsdos/rdir.c	2002-11-05 16:35:59.000000000 +0100
+++ linux-2.5.73-04-lookupintent/fs/umsdos/rdir.c	2003-06-30 08:48:43.000000000 +0200
@@ -101,7 +101,7 @@
 		goto out;
 	}
 
-	ret = msdos_lookup (dir, dentry);
+	ret = msdos_lookup (dir, dentry, NULL);
 	if (ret) {
 		printk(KERN_WARNING
 			"umsdos_rlookup_x: %s/%s failed, ret=%ld\n",
@@ -129,7 +129,7 @@
 }
 
 
-struct dentry *UMSDOS_rlookup ( struct inode *dir, struct dentry *dentry)
+struct dentry *UMSDOS_rlookup ( struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	return umsdos_rlookup_x (dir, dentry, 0);
 }
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/vfat/namei.c linux-2.5.73-04-lookupintent/fs/vfat/namei.c
--- linux-2.5.73-03-rpc_integ/fs/vfat/namei.c	2003-05-27 16:32:40.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/vfat/namei.c	2003-06-30 08:48:43.000000000 +0200
@@ -45,7 +45,7 @@
 static int vfat_hash(struct dentry *parent, struct qstr *qstr);
 static int vfat_cmpi(struct dentry *dentry, struct qstr *a, struct qstr *b);
 static int vfat_cmp(struct dentry *dentry, struct qstr *a, struct qstr *b);
-static int vfat_revalidate(struct dentry *dentry, int);
+static int vfat_revalidate(struct dentry *dentry, struct nameidata *nd);
 
 static struct dentry_operations vfat_dentry_ops[4] = {
 	{
@@ -68,7 +68,7 @@
 	}
 };
 
-static int vfat_revalidate(struct dentry *dentry, int flags)
+static int vfat_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
 	PRINTK1(("vfat_revalidate: %s\n", dentry->d_name.name));
 	spin_lock(&dcache_lock);
@@ -860,7 +860,7 @@
 	return res ? res : -ENOENT;
 }
 
-struct dentry *vfat_lookup(struct inode *dir,struct dentry *dentry)
+struct dentry *vfat_lookup(struct inode *dir,struct dentry *dentry, struct nameidata *nd)
 {
 	int res;
 	struct vfat_slot_info sinfo;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/fs/xfs/linux/xfs_iops.c linux-2.5.73-04-lookupintent/fs/xfs/linux/xfs_iops.c
--- linux-2.5.73-03-rpc_integ/fs/xfs/linux/xfs_iops.c	2003-06-19 20:39:57.000000000 +0200
+++ linux-2.5.73-04-lookupintent/fs/xfs/linux/xfs_iops.c	2003-06-30 08:48:43.000000000 +0200
@@ -192,7 +192,8 @@
 STATIC struct dentry *
 linvfs_lookup(
 	struct inode	*dir,
-	struct dentry	*dentry)
+	struct dentry	*dentry,
+	struct nameidata *nd)
 {
 	struct inode	*ip = NULL;
 	vnode_t		*vp, *cvp = NULL;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/include/linux/affs_fs.h linux-2.5.73-04-lookupintent/include/linux/affs_fs.h
--- linux-2.5.73-03-rpc_integ/include/linux/affs_fs.h	2002-03-17 20:38:14.000000000 +0100
+++ linux-2.5.73-04-lookupintent/include/linux/affs_fs.h	2003-06-30 08:48:43.000000000 +0200
@@ -41,7 +41,7 @@
 /* namei.c */
 
 extern int	affs_hash_name(struct super_block *sb, const u8 *name, unsigned int len);
-extern struct dentry *affs_lookup(struct inode *dir, struct dentry *dentry);
+extern struct dentry *affs_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *);
 extern int	affs_unlink(struct inode *dir, struct dentry *dentry);
 extern int	affs_create(struct inode *dir, struct dentry *dentry, int mode);
 extern int	affs_mkdir(struct inode *dir, struct dentry *dentry, int mode);
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/include/linux/dcache.h linux-2.5.73-04-lookupintent/include/linux/dcache.h
--- linux-2.5.73-03-rpc_integ/include/linux/dcache.h	2003-06-12 18:31:21.000000000 +0200
+++ linux-2.5.73-04-lookupintent/include/linux/dcache.h	2003-06-30 08:48:43.000000000 +0200
@@ -10,6 +10,7 @@
 #include <linux/rcupdate.h>
 #include <asm/bug.h>
 
+struct nameidata;
 struct vfsmount;
 
 /*
@@ -106,7 +107,7 @@
 #define DNAME_INLINE_LEN	(sizeof(struct dentry)-offsetof(struct dentry,d_iname))
  
 struct dentry_operations {
-	int (*d_revalidate)(struct dentry *, int);
+	int (*d_revalidate)(struct dentry *, struct nameidata *);
 	int (*d_hash) (struct dentry *, struct qstr *);
 	int (*d_compare) (struct dentry *, struct qstr *, struct qstr *);
 	int (*d_delete)(struct dentry *);
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/include/linux/efs_fs.h linux-2.5.73-04-lookupintent/include/linux/efs_fs.h
--- linux-2.5.73-03-rpc_integ/include/linux/efs_fs.h	2003-06-20 22:16:06.000000000 +0200
+++ linux-2.5.73-04-lookupintent/include/linux/efs_fs.h	2003-06-30 08:48:43.000000000 +0200
@@ -46,7 +46,7 @@
 extern void efs_read_inode(struct inode *);
 extern efs_block_t efs_map_block(struct inode *, efs_block_t);
 
-extern struct dentry *efs_lookup(struct inode *, struct dentry *);
+extern struct dentry *efs_lookup(struct inode *, struct dentry *, struct nameidata *);
 extern int efs_bmap(struct inode *, int);
 
 #endif /* __EFS_FS_H__ */
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/include/linux/fs.h linux-2.5.73-04-lookupintent/include/linux/fs.h
--- linux-2.5.73-03-rpc_integ/include/linux/fs.h	2003-06-20 22:16:06.000000000 +0200
+++ linux-2.5.73-04-lookupintent/include/linux/fs.h	2003-06-30 08:48:43.000000000 +0200
@@ -731,7 +731,7 @@
 
 struct inode_operations {
 	int (*create) (struct inode *,struct dentry *,int);
-	struct dentry * (*lookup) (struct inode *,struct dentry *);
+	struct dentry * (*lookup) (struct inode *,struct dentry *, struct nameidata *);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
 	int (*symlink) (struct inode *,struct dentry *,const char *);
@@ -1291,7 +1291,7 @@
 extern int simple_commit_write(struct file *file, struct page *page,
 				unsigned offset, unsigned to);
 
-extern struct dentry *simple_lookup(struct inode *, struct dentry *);
+extern struct dentry *simple_lookup(struct inode *, struct dentry *, struct nameidata *);
 extern ssize_t generic_read_dir(struct file *, char __user *, size_t, loff_t *);
 extern struct file_operations simple_dir_operations;
 extern struct inode_operations simple_dir_inode_operations;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/include/linux/iso_fs.h linux-2.5.73-04-lookupintent/include/linux/iso_fs.h
--- linux-2.5.73-03-rpc_integ/include/linux/iso_fs.h	2003-04-25 21:35:37.000000000 +0200
+++ linux-2.5.73-04-lookupintent/include/linux/iso_fs.h	2003-06-30 08:48:43.000000000 +0200
@@ -227,7 +227,7 @@
 int get_joliet_filename(struct iso_directory_record *, unsigned char *, struct inode *);
 int get_acorn_filename(struct iso_directory_record *, char *, struct inode *);
 
-extern struct dentry *isofs_lookup(struct inode *, struct dentry *);
+extern struct dentry *isofs_lookup(struct inode *, struct dentry *, struct nameidata *);
 extern struct buffer_head *isofs_bread(struct inode *, sector_t);
 extern int isofs_get_blocks(struct inode *, sector_t, struct buffer_head **, unsigned long);
 
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/include/linux/msdos_fs.h linux-2.5.73-04-lookupintent/include/linux/msdos_fs.h
--- linux-2.5.73-03-rpc_integ/include/linux/msdos_fs.h	2003-06-20 22:16:06.000000000 +0200
+++ linux-2.5.73-04-lookupintent/include/linux/msdos_fs.h	2003-06-30 08:48:43.000000000 +0200
@@ -307,7 +307,7 @@
 		    struct msdos_dir_entry **res_de, loff_t *i_pos);
 
 /* msdos/namei.c  - these are for Umsdos */
-extern struct dentry *msdos_lookup(struct inode *dir, struct dentry *);
+extern struct dentry *msdos_lookup(struct inode *dir, struct dentry *, struct nameidata *);
 extern int msdos_create(struct inode *dir, struct dentry *dentry, int mode);
 extern int msdos_rmdir(struct inode *dir, struct dentry *dentry);
 extern int msdos_mkdir(struct inode *dir, struct dentry *dentry, int mode);
@@ -317,7 +317,7 @@
 extern int msdos_fill_super(struct super_block *sb, void *data, int silent);
 
 /* vfat/namei.c - these are for dmsdos */
-extern struct dentry *vfat_lookup(struct inode *dir, struct dentry *);
+extern struct dentry *vfat_lookup(struct inode *dir, struct dentry *, struct nameidata *);
 extern int vfat_create(struct inode *dir, struct dentry *dentry, int mode);
 extern int vfat_rmdir(struct inode *dir, struct dentry *dentry);
 extern int vfat_unlink(struct inode *dir, struct dentry *dentry);
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/include/linux/namei.h linux-2.5.73-04-lookupintent/include/linux/namei.h
--- linux-2.5.73-03-rpc_integ/include/linux/namei.h	2003-04-09 20:44:15.000000000 +0200
+++ linux-2.5.73-04-lookupintent/include/linux/namei.h	2003-06-30 08:48:43.000000000 +0200
@@ -5,12 +5,28 @@
 
 struct vfsmount;
 
+struct open_intent {
+	int	flags;
+	int	create_mode;
+};
+
 struct nameidata {
 	struct dentry	*dentry;
 	struct vfsmount *mnt;
 	struct qstr	last;
 	unsigned int	flags;
 	int		last_type;
+
+	/* Intent data */
+	union {
+		struct open_intent open;
+	} u;
+
+#if 0
+	/* FS private data */
+	void		*it_private;
+	void (*it_release)(struct nameidata *, void *);
+#endif
 };
 
 /*
@@ -31,7 +47,11 @@
 #define LOOKUP_CONTINUE		 4
 #define LOOKUP_PARENT		16
 #define LOOKUP_NOALT		32
-
+/*
+ * Intent data
+ */
+#define LOOKUP_OPEN		(0x0100)
+#define LOOKUP_CREATE		(0x0200)
 
 extern int FASTCALL(__user_walk(const char __user *, unsigned, struct nameidata *));
 #define user_path_walk(name,nd) \
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/include/linux/proc_fs.h linux-2.5.73-04-lookupintent/include/linux/proc_fs.h
--- linux-2.5.73-03-rpc_integ/include/linux/proc_fs.h	2003-06-08 00:17:50.000000000 +0200
+++ linux-2.5.73-04-lookupintent/include/linux/proc_fs.h	2003-06-30 08:48:43.000000000 +0200
@@ -92,7 +92,7 @@
 extern void proc_root_init(void);
 extern void proc_misc_init(void);
 
-struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry);
+struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *);
 struct dentry *proc_pid_unhash(struct task_struct *p);
 void proc_pid_flush(struct dentry *proc_dentry);
 int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir);
@@ -115,7 +115,7 @@
  * of the /proc/<pid> subdirectories.
  */
 extern int proc_readdir(struct file *, void *, filldir_t);
-extern struct dentry *proc_lookup(struct inode *, struct dentry *);
+extern struct dentry *proc_lookup(struct inode *, struct dentry *, struct nameidata *);
 
 extern struct file_operations proc_kcore_operations;
 extern struct file_operations proc_kmsg_operations;
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/include/linux/qnx4_fs.h linux-2.5.73-04-lookupintent/include/linux/qnx4_fs.h
--- linux-2.5.73-03-rpc_integ/include/linux/qnx4_fs.h	2002-10-07 19:27:58.000000000 +0200
+++ linux-2.5.73-04-lookupintent/include/linux/qnx4_fs.h	2003-06-30 08:48:43.000000000 +0200
@@ -110,7 +110,7 @@
 	struct inode vfs_inode;
 };
 
-extern struct dentry *qnx4_lookup(struct inode *dir, struct dentry *dentry);
+extern struct dentry *qnx4_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd);
 extern unsigned long qnx4_count_free_blocks(struct super_block *sb);
 extern unsigned long qnx4_block_map(struct inode *inode, long iblock);
 
diff -u --recursive --new-file linux-2.5.73-03-rpc_integ/include/linux/umsdos_fs.p linux-2.5.73-04-lookupintent/include/linux/umsdos_fs.p
--- linux-2.5.73-03-rpc_integ/include/linux/umsdos_fs.p	2002-11-20 12:19:02.000000000 +0100
+++ linux-2.5.73-04-lookupintent/include/linux/umsdos_fs.p	2003-06-30 08:48:43.000000000 +0200
@@ -10,7 +10,7 @@
 void umsdos_lookup_patch_new(struct dentry *, struct umsdos_info *);
 int umsdos_is_pseudodos (struct inode *dir, struct dentry *dentry);
 struct dentry *umsdos_lookup_x ( struct inode *dir, struct dentry *dentry, int nopseudo);
-struct dentry *UMSDOS_lookup(struct inode *, struct dentry *);
+struct dentry *UMSDOS_lookup(struct inode *, struct dentry *, struct nameidata *);
 struct dentry *umsdos_lookup_dentry(struct dentry *, char *, int, int);
 struct dentry *umsdos_covered(struct dentry *, char *, int);
 
@@ -92,7 +92,7 @@
 
 /* rdir.c 22/03/95 03.31.42 */
 struct dentry *umsdos_rlookup_x (struct inode *dir, struct dentry *dentry, int nopseudo);
-struct dentry *UMSDOS_rlookup (struct inode *dir, struct dentry *dentry);
+struct dentry *UMSDOS_rlookup (struct inode *dir, struct dentry *dentry, struct nameidata *nd);
 
 static inline struct umsdos_inode_info *UMSDOS_I(struct inode *inode)
 {
