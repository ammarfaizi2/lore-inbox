Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbTEWMhb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 08:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTEWMhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 08:37:31 -0400
Received: from pat.uio.no ([129.240.130.16]:23484 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264045AbTEWMd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 08:33:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16078.6120.392676.114609@charged.uio.no>
Date: Fri, 23 May 2003 14:45:28 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH 2/4] Optimize NFS open() calls by means of 'intents'...
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add open() intents to the i_op->lookup() routines. This will be used
by NFSv2/v3 in order to optimize close-to-open cache consistency
checking.
It will additionally be used by NFSv4 in order to optimize away LOOKUP calls
that may be replaced by the stateful OPEN call.


diff -u --recursive --new-file linux-2.5.69-01-open1/drivers/net/wan/comx.c linux-2.5.69-02-open2/drivers/net/wan/comx.c
--- linux-2.5.69-01-open1/drivers/net/wan/comx.c	2003-05-20 08:57:38.000000000 +0200
+++ linux-2.5.69-02-open2/drivers/net/wan/comx.c	2003-05-22 14:26:22.000000000 +0200
@@ -86,7 +86,7 @@
 
 static int comx_mkdir(struct inode *, struct dentry *, int);
 static int comx_rmdir(struct inode *, struct dentry *);
-static struct dentry *comx_lookup(struct inode *, struct dentry *);
+static struct dentry *comx_lookup(struct inode *, struct dentry *, struct vfsintent *);
 
 static struct inode_operations comx_root_inode_ops = {
 	.lookup = comx_lookup,
@@ -922,7 +922,7 @@
 	return 0;
 }
 
-static struct dentry *comx_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *comx_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct proc_dir_entry *de;
 	struct inode *inode = NULL;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/adfs/adfs.h linux-2.5.69-02-open2/fs/adfs/adfs.h
--- linux-2.5.69-01-open1/fs/adfs/adfs.h	2002-05-01 20:54:55.000000000 +0200
+++ linux-2.5.69-02-open2/fs/adfs/adfs.h	2003-05-22 14:38:10.000000000 +0200
@@ -88,7 +88,7 @@
 #define adfs_error(sb, fmt...) __adfs_error(sb, __FUNCTION__, fmt)
 
 /* namei.c */
-extern struct dentry *adfs_lookup(struct inode *dir, struct dentry *dentry);
+extern struct dentry *adfs_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *);
 
 /* super.c */
 
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/adfs/dir.c linux-2.5.69-02-open2/fs/adfs/dir.c
--- linux-2.5.69-01-open1/fs/adfs/dir.c	2002-08-03 12:12:00.000000000 +0200
+++ linux-2.5.69-02-open2/fs/adfs/dir.c	2003-05-22 14:26:22.000000000 +0200
@@ -269,7 +269,7 @@
 	.d_compare	= adfs_compare,
 };
 
-struct dentry *adfs_lookup(struct inode *dir, struct dentry *dentry)
+struct dentry *adfs_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct inode *inode = NULL;
 	struct object_info obj;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/affs/namei.c linux-2.5.69-02-open2/fs/affs/namei.c
--- linux-2.5.69-01-open1/fs/affs/namei.c	2003-03-17 07:33:20.000000000 +0100
+++ linux-2.5.69-02-open2/fs/affs/namei.c	2003-05-22 14:26:22.000000000 +0200
@@ -210,7 +210,7 @@
 }
 
 struct dentry *
-affs_lookup(struct inode *dir, struct dentry *dentry)
+affs_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct super_block *sb = dir->i_sb;
 	struct buffer_head *bh;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/afs/dir.c linux-2.5.69-02-open2/fs/afs/dir.c
--- linux-2.5.69-01-open1/fs/afs/dir.c	2003-04-03 08:51:32.000000000 +0200
+++ linux-2.5.69-02-open2/fs/afs/dir.c	2003-05-22 14:40:30.000000000 +0200
@@ -23,10 +23,10 @@
 #include "super.h"
 #include "internal.h"
 
-static struct dentry *afs_dir_lookup(struct inode *dir, struct dentry *dentry);
+static struct dentry *afs_dir_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *);
 static int afs_dir_open(struct inode *inode, struct file *file);
 static int afs_dir_readdir(struct file *file, void *dirent, filldir_t filldir);
-static int afs_d_revalidate(struct dentry *dentry, int flags);
+static int afs_d_revalidate(struct dentry *dentry, struct vfsintent *);
 static int afs_d_delete(struct dentry *dentry);
 static int afs_dir_lookup_filldir(void *_cookie, const char *name, int nlen, loff_t fpos,
 				     ino_t ino, unsigned dtype);
@@ -414,7 +414,7 @@
 /*
  * look up an entry in a directory
  */
-static struct dentry *afs_dir_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *afs_dir_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct afs_dir_lookup_cookie cookie;
 	struct afs_super_info *as;
@@ -487,7 +487,7 @@
  * - NOTE! the hit can be a negative hit too, so we can't assume we have an inode
  * (derived from nfs_lookup_revalidate)
  */
-static int afs_d_revalidate(struct dentry *dentry, int flags)
+static int afs_d_revalidate(struct dentry *dentry, struct vfsintent *intent)
 {
 	struct afs_dir_lookup_cookie cookie;
 	struct dentry *parent;
@@ -495,7 +495,7 @@
 	unsigned fpos;
 	int ret;
 
-	_enter("%s,%x",dentry->d_name.name,flags);
+	_enter("%s,%p",dentry->d_name.name,intent);
 
 	parent = dget_parent(dentry);
 	dir = parent->d_inode;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/afs/mntpt.c linux-2.5.69-02-open2/fs/afs/mntpt.c
--- linux-2.5.69-01-open1/fs/afs/mntpt.c	2002-10-16 14:34:58.000000000 +0200
+++ linux-2.5.69-02-open2/fs/afs/mntpt.c	2003-05-22 14:40:59.000000000 +0200
@@ -21,7 +21,7 @@
 #include "internal.h"
 
 
-static struct dentry *afs_mntpt_lookup(struct inode *dir, struct dentry *dentry);
+static struct dentry *afs_mntpt_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *);
 static int afs_mntpt_open(struct inode *inode, struct file *file);
 
 struct file_operations afs_mntpt_file_operations = {
@@ -93,7 +93,7 @@
 /*
  * no valid lookup procedure on this sort of dir
  */
-static struct dentry *afs_mntpt_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *afs_mntpt_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	return ERR_PTR(-EREMOTE);
 } /* end afs_mntpt_lookup() */
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/autofs/root.c linux-2.5.69-02-open2/fs/autofs/root.c
--- linux-2.5.69-01-open1/fs/autofs/root.c	2002-11-17 21:30:45.000000000 +0100
+++ linux-2.5.69-02-open2/fs/autofs/root.c	2003-05-22 14:26:22.000000000 +0200
@@ -18,7 +18,7 @@
 #include "autofs_i.h"
 
 static int autofs_root_readdir(struct file *,void *,filldir_t);
-static struct dentry *autofs_root_lookup(struct inode *,struct dentry *);
+static struct dentry *autofs_root_lookup(struct inode *,struct dentry *, struct vfsintent *);
 static int autofs_root_symlink(struct inode *,struct dentry *,const char *);
 static int autofs_root_unlink(struct inode *,struct dentry *);
 static int autofs_root_rmdir(struct inode *,struct dentry *);
@@ -144,7 +144,7 @@
  * yet completely filled in, and revalidate has to delay such
  * lookups..
  */
-static int autofs_revalidate(struct dentry * dentry, int flags)
+static int autofs_revalidate(struct dentry * dentry, struct vfsintent *intent)
 {
 	struct inode * dir;
 	struct autofs_sb_info *sbi;
@@ -195,7 +195,7 @@
 	.d_revalidate	= autofs_revalidate,
 };
 
-static struct dentry *autofs_root_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *autofs_root_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct autofs_sb_info *sbi;
 	int oz_mode;
@@ -230,7 +230,7 @@
 	d_add(dentry, NULL);
 
 	up(&dir->i_sem);
-	autofs_revalidate(dentry, 0);
+	autofs_revalidate(dentry, intent);
 	down(&dir->i_sem);
 
 	/*
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/autofs4/root.c linux-2.5.69-02-open2/fs/autofs4/root.c
--- linux-2.5.69-01-open1/fs/autofs4/root.c	2002-11-18 13:37:59.000000000 +0100
+++ linux-2.5.69-02-open2/fs/autofs4/root.c	2003-05-22 14:26:22.000000000 +0200
@@ -18,13 +18,13 @@
 #include <linux/smp_lock.h>
 #include "autofs_i.h"
 
-static struct dentry *autofs4_dir_lookup(struct inode *,struct dentry *);
+static struct dentry *autofs4_dir_lookup(struct inode *,struct dentry *, struct vfsintent *);
 static int autofs4_dir_symlink(struct inode *,struct dentry *,const char *);
 static int autofs4_dir_unlink(struct inode *,struct dentry *);
 static int autofs4_dir_rmdir(struct inode *,struct dentry *);
 static int autofs4_dir_mkdir(struct inode *,struct dentry *,int);
 static int autofs4_root_ioctl(struct inode *, struct file *,unsigned int,unsigned long);
-static struct dentry *autofs4_root_lookup(struct inode *,struct dentry *);
+static struct dentry *autofs4_root_lookup(struct inode *,struct dentry *, struct vfsintent *);
 
 struct file_operations autofs4_root_operations = {
 	.open		= dcache_dir_open,
@@ -143,7 +143,7 @@
  * yet completely filled in, and revalidate has to delay such
  * lookups..
  */
-static int autofs4_root_revalidate(struct dentry * dentry, int flags)
+static int autofs4_root_revalidate(struct dentry * dentry, struct vfsintent *intent)
 {
 	struct inode * dir = dentry->d_parent->d_inode;
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
@@ -186,7 +186,7 @@
 	return 1;
 }
 
-static int autofs4_revalidate(struct dentry *dentry, int flags)
+static int autofs4_revalidate(struct dentry *dentry, struct vfsintent *intent)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 
@@ -228,7 +228,7 @@
 /* Lookups in non-root dirs never find anything - if it's there, it's
    already in the dcache */
 /* SMP-safe */
-static struct dentry *autofs4_dir_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *autofs4_dir_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 #if 0
 	DPRINTK(("autofs_dir_lookup: ignoring lookup of %.*s/%.*s\n",
@@ -242,7 +242,7 @@
 }
 
 /* Lookups in the root directory */
-static struct dentry *autofs4_root_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *autofs4_root_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct autofs_sb_info *sbi;
 	int oz_mode;
@@ -279,7 +279,7 @@
 
 	if (dentry->d_op && dentry->d_op->d_revalidate) {
 		up(&dir->i_sem);
-		(dentry->d_op->d_revalidate)(dentry, 0);
+		(dentry->d_op->d_revalidate)(dentry, intent);
 		down(&dir->i_sem);
 	}
 
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/befs/linuxvfs.c linux-2.5.69-02-open2/fs/befs/linuxvfs.c
--- linux-2.5.69-01-open1/fs/befs/linuxvfs.c	2003-04-01 01:55:42.000000000 +0200
+++ linux-2.5.69-02-open2/fs/befs/linuxvfs.c	2003-05-22 14:26:22.000000000 +0200
@@ -33,7 +33,7 @@
 static int befs_get_block(struct inode *, sector_t, struct buffer_head *, int);
 static int befs_readpage(struct file *file, struct page *page);
 static sector_t befs_bmap(struct address_space *mapping, sector_t block);
-static struct dentry *befs_lookup(struct inode *, struct dentry *);
+static struct dentry *befs_lookup(struct inode *, struct dentry *, struct vfsintent *);
 static void befs_read_inode(struct inode *ino);
 static struct inode *befs_alloc_inode(struct super_block *sb);
 static void befs_destroy_inode(struct inode *inode);
@@ -163,7 +163,7 @@
 }
 
 static struct dentry *
-befs_lookup(struct inode *dir, struct dentry *dentry)
+befs_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct inode *inode = NULL;
 	struct super_block *sb = dir->i_sb;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/bfs/dir.c linux-2.5.69-02-open2/fs/bfs/dir.c
--- linux-2.5.69-01-open1/fs/bfs/dir.c	2003-05-05 07:49:54.000000000 +0200
+++ linux-2.5.69-02-open2/fs/bfs/dir.c	2003-05-22 14:26:22.000000000 +0200
@@ -127,7 +127,7 @@
 	return 0;
 }
 
-static struct dentry * bfs_lookup(struct inode * dir, struct dentry * dentry)
+static struct dentry * bfs_lookup(struct inode * dir, struct dentry * dentry, struct vfsintent *intent)
 {
 	struct inode * inode = NULL;
 	struct buffer_head * bh;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/cifs/cifsfs.h linux-2.5.69-02-open2/fs/cifs/cifsfs.h
--- linux-2.5.69-01-open1/fs/cifs/cifsfs.h	2003-02-15 23:10:23.000000000 +0100
+++ linux-2.5.69-02-open2/fs/cifs/cifsfs.h	2003-05-22 14:26:22.000000000 +0200
@@ -47,7 +47,7 @@
 /* Functions related to inodes */
 extern struct inode_operations cifs_dir_inode_ops;
 extern int cifs_create(struct inode *, struct dentry *, int);
-extern struct dentry *cifs_lookup(struct inode *, struct dentry *);
+extern struct dentry *cifs_lookup(struct inode *, struct dentry *, struct vfsintent *);
 extern int cifs_unlink(struct inode *, struct dentry *);
 extern int cifs_hardlink(struct dentry *, struct inode *, struct dentry *);
 extern int cifs_mkdir(struct inode *, struct dentry *, int);
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/cifs/dir.c linux-2.5.69-02-open2/fs/cifs/dir.c
--- linux-2.5.69-01-open1/fs/cifs/dir.c	2003-02-15 23:10:23.000000000 +0100
+++ linux-2.5.69-02-open2/fs/cifs/dir.c	2003-05-22 14:26:22.000000000 +0200
@@ -178,7 +178,7 @@
 }
 
 struct dentry *
-cifs_lookup(struct inode *parent_dir_inode, struct dentry *direntry)
+cifs_lookup(struct inode *parent_dir_inode, struct dentry *direntry, struct vfsintent *intent)
 {
 	int rc, xid;
 	struct cifs_sb_info *cifs_sb;
@@ -262,7 +262,7 @@
 }
 
 static int
-cifs_d_revalidate(struct dentry *direntry, int flags)
+cifs_d_revalidate(struct dentry *direntry, struct vfsintent *intent)
 {
 	int isValid = 1;
 
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/coda/dir.c linux-2.5.69-02-open2/fs/coda/dir.c
--- linux-2.5.69-01-open1/fs/coda/dir.c	2002-11-20 12:19:02.000000000 +0100
+++ linux-2.5.69-02-open2/fs/coda/dir.c	2003-05-22 14:26:22.000000000 +0200
@@ -30,7 +30,7 @@
 /* dir inode-ops */
 static int coda_create(struct inode *dir, struct dentry *new, int mode);
 static int coda_mknod(struct inode *dir, struct dentry *new, int mode, dev_t rdev);
-static struct dentry *coda_lookup(struct inode *dir, struct dentry *target);
+static struct dentry *coda_lookup(struct inode *dir, struct dentry *target, struct vfsintent *intent);
 static int coda_link(struct dentry *old_dentry, struct inode *dir_inode, 
 		     struct dentry *entry);
 static int coda_unlink(struct inode *dir_inode, struct dentry *entry);
@@ -45,7 +45,7 @@
 static int coda_readdir(struct file *file, void *dirent, filldir_t filldir);
 
 /* dentry ops */
-static int coda_dentry_revalidate(struct dentry *de, int);
+static int coda_dentry_revalidate(struct dentry *de, struct vfsintent *intent);
 static int coda_dentry_delete(struct dentry *);
 
 /* support routines */
@@ -90,7 +90,7 @@
 
 /* inode operations for directories */
 /* access routines: lookup, readlink, permission */
-static struct dentry *coda_lookup(struct inode *dir, struct dentry *entry)
+static struct dentry *coda_lookup(struct inode *dir, struct dentry *entry, struct vfsintent *intent)
 {
 	struct inode *res_inode = NULL;
 	struct ViceFid resfid = {0,0,0};
@@ -627,7 +627,7 @@
 }
 
 /* called when a cache lookup succeeds */
-static int coda_dentry_revalidate(struct dentry *de, int flags)
+static int coda_dentry_revalidate(struct dentry *de, struct vfsintent *intent)
 {
 	struct inode *inode = de->d_inode;
 	struct coda_inode_info *cii;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/cramfs/inode.c linux-2.5.69-02-open2/fs/cramfs/inode.c
--- linux-2.5.69-01-open1/fs/cramfs/inode.c	2003-03-26 21:16:08.000000000 +0100
+++ linux-2.5.69-02-open2/fs/cramfs/inode.c	2003-05-22 14:26:22.000000000 +0200
@@ -342,7 +342,7 @@
 /*
  * Lookup and fill in the inode data..
  */
-static struct dentry * cramfs_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry * cramfs_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	unsigned int offset = 0;
 	int sorted;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/devfs/base.c linux-2.5.69-02-open2/fs/devfs/base.c
--- linux-2.5.69-01-open1/fs/devfs/base.c	2003-05-13 06:23:09.000000000 +0200
+++ linux-2.5.69-02-open2/fs/devfs/base.c	2003-05-22 14:46:37.000000000 +0200
@@ -2161,7 +2161,7 @@
     .d_iput       = devfs_d_iput,
 };
 
-static int devfs_d_revalidate_wait (struct dentry *dentry, int flags);
+static int devfs_d_revalidate_wait (struct dentry *dentry, struct vfsintent *);
 
 static struct dentry_operations devfs_wait_dops =
 {
@@ -2198,7 +2198,7 @@
 
 /* XXX: this doesn't handle the case where we got a negative dentry
         but a devfs entry has been registered in the meanwhile */
-static int devfs_d_revalidate_wait (struct dentry *dentry, int flags)
+static int devfs_d_revalidate_wait (struct dentry *dentry, struct vfsintent *intent)
 {
     struct inode *dir = dentry->d_parent->d_inode;
     struct fs_info *fs_info = dir->i_sb->s_fs_info;
@@ -2251,7 +2251,7 @@
 
 /*  Inode operations for device entries follow  */
 
-static struct dentry *devfs_lookup (struct inode *dir, struct dentry *dentry)
+static struct dentry *devfs_lookup (struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
     struct devfs_entry tmp;  /*  Must stay in scope until devfsd idle again  */
     struct devfs_lookup_struct lookup_info;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/efs/namei.c linux-2.5.69-02-open2/fs/efs/namei.c
--- linux-2.5.69-01-open1/fs/efs/namei.c	2002-05-23 15:18:43.000000000 +0200
+++ linux-2.5.69-02-open2/fs/efs/namei.c	2003-05-22 14:26:22.000000000 +0200
@@ -57,7 +57,7 @@
 	return(0);
 }
 
-struct dentry *efs_lookup(struct inode *dir, struct dentry *dentry) {
+struct dentry *efs_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent) {
 	efs_ino_t inodenum;
 	struct inode * inode = NULL;
 
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/ext2/namei.c linux-2.5.69-02-open2/fs/ext2/namei.c
--- linux-2.5.69-01-open1/fs/ext2/namei.c	2002-11-21 22:10:50.000000000 +0100
+++ linux-2.5.69-02-open2/fs/ext2/namei.c	2003-05-22 14:26:22.000000000 +0200
@@ -66,7 +66,7 @@
  * Methods themselves.
  */
 
-static struct dentry *ext2_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *ext2_lookup(struct inode * dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct inode * inode;
 	ino_t ino;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/ext3/namei.c linux-2.5.69-02-open2/fs/ext3/namei.c
--- linux-2.5.69-01-open1/fs/ext3/namei.c	2003-05-13 06:23:28.000000000 +0200
+++ linux-2.5.69-02-open2/fs/ext3/namei.c	2003-05-22 14:26:22.000000000 +0200
@@ -972,7 +972,7 @@
 }
 #endif
 
-static struct dentry *ext3_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *ext3_lookup(struct inode * dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct inode * inode;
 	struct ext3_dir_entry_2 * de;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/freevxfs/vxfs_lookup.c linux-2.5.69-02-open2/fs/freevxfs/vxfs_lookup.c
--- linux-2.5.69-01-open1/fs/freevxfs/vxfs_lookup.c	2002-04-24 18:20:09.000000000 +0200
+++ linux-2.5.69-02-open2/fs/freevxfs/vxfs_lookup.c	2003-05-22 14:26:22.000000000 +0200
@@ -51,7 +51,7 @@
 #define VXFS_BLOCK_PER_PAGE(sbp)  ((PAGE_CACHE_SIZE / (sbp)->s_blocksize))
 
 
-static struct dentry *	vxfs_lookup(struct inode *, struct dentry *);
+static struct dentry *	vxfs_lookup(struct inode *, struct dentry *, struct vfsintent *);
 static int		vxfs_readdir(struct file *, void *, filldir_t);
 
 struct inode_operations vxfs_dir_inode_ops = {
@@ -193,6 +193,7 @@
  * vxfs_lookup - lookup pathname component
  * @dip:	dir in which we lookup
  * @dp:		dentry we lookup
+ * @intent:	lookup intent structure
  *
  * Description:
  *   vxfs_lookup tries to lookup the pathname component described
@@ -203,7 +204,7 @@
  *   in the return pointer.
  */
 static struct dentry *
-vxfs_lookup(struct inode *dip, struct dentry *dp)
+vxfs_lookup(struct inode *dip, struct dentry *dp, struct vfsintent *intent)
 {
 	struct inode		*ip = NULL;
 	ino_t			ino;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/hfs/dir_cap.c linux-2.5.69-02-open2/fs/hfs/dir_cap.c
--- linux-2.5.69-01-open1/fs/hfs/dir_cap.c	2002-10-07 22:51:35.000000000 +0200
+++ linux-2.5.69-02-open2/fs/hfs/dir_cap.c	2003-05-22 14:26:22.000000000 +0200
@@ -28,7 +28,7 @@
 
 /*================ Forward declarations ================*/
 
-static struct dentry *cap_lookup(struct inode *, struct dentry *);
+static struct dentry *cap_lookup(struct inode *, struct dentry *, struct vfsintent *);
 static int cap_readdir(struct file *, void *, filldir_t);
 
 /*================ Global variables ================*/
@@ -95,7 +95,7 @@
  * inode corresponding to an entry in a directory, given the inode for
  * the directory and the name (and its length) of the entry.
  */
-static struct dentry *cap_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *cap_lookup(struct inode * dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	ino_t dtype;
 	struct hfs_name cname;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/hfs/dir_dbl.c linux-2.5.69-02-open2/fs/hfs/dir_dbl.c
--- linux-2.5.69-01-open1/fs/hfs/dir_dbl.c	2002-10-07 22:51:35.000000000 +0200
+++ linux-2.5.69-02-open2/fs/hfs/dir_dbl.c	2003-05-22 14:26:22.000000000 +0200
@@ -24,7 +24,7 @@
 
 /*================ Forward declarations ================*/
 
-static struct dentry *dbl_lookup(struct inode *, struct dentry *);
+static struct dentry *dbl_lookup(struct inode *, struct dentry *, struct vfsintent *);
 static int dbl_readdir(struct file *, void *, filldir_t);
 static int dbl_create(struct inode *, struct dentry *, int);
 static int dbl_mkdir(struct inode *, struct dentry *, int);
@@ -108,7 +108,7 @@
  * the inode for the directory and the name (and its length) of the
  * entry.
  */
-static struct dentry *dbl_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *dbl_lookup(struct inode * dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct hfs_name cname;
 	struct hfs_cat_entry *entry;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/hfs/dir_nat.c linux-2.5.69-02-open2/fs/hfs/dir_nat.c
--- linux-2.5.69-01-open1/fs/hfs/dir_nat.c	2002-10-07 22:51:36.000000000 +0200
+++ linux-2.5.69-02-open2/fs/hfs/dir_nat.c	2003-05-22 14:26:22.000000000 +0200
@@ -30,7 +30,7 @@
 
 /*================ Forward declarations ================*/
 
-static struct dentry *nat_lookup(struct inode *, struct dentry *);
+static struct dentry *nat_lookup(struct inode *, struct dentry *, struct vfsintent *);
 static int nat_readdir(struct file *, void *, filldir_t);
 static int nat_rmdir(struct inode *, struct dentry *);
 static int nat_hdr_unlink(struct inode *, struct dentry *);
@@ -97,7 +97,7 @@
  * the inode corresponding to an entry in a directory, given the inode
  * for the directory and the name (and its length) of the entry.
  */
-static struct dentry *nat_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *nat_lookup(struct inode * dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	ino_t dtype;
 	struct hfs_name cname;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/hfs/sysdep.c linux-2.5.69-02-open2/fs/hfs/sysdep.c
--- linux-2.5.69-01-open1/fs/hfs/sysdep.c	2002-11-17 20:53:57.000000000 +0100
+++ linux-2.5.69-02-open2/fs/hfs/sysdep.c	2003-05-22 14:26:22.000000000 +0200
@@ -19,7 +19,7 @@
 #include <linux/hfs_fs.h>
 #include <linux/smp_lock.h>
 
-static int hfs_revalidate_dentry(struct dentry *, int);
+static int hfs_revalidate_dentry(struct dentry *, struct vfsintent *);
 static int hfs_hash_dentry(struct dentry *, struct qstr *);
 static int hfs_compare_dentry(struct dentry *, struct qstr *, struct qstr *);
 static void hfs_dentry_iput(struct dentry *, struct inode *);
@@ -90,7 +90,7 @@
 	iput(inode);
 }
 
-static int hfs_revalidate_dentry(struct dentry *dentry, int flags)
+static int hfs_revalidate_dentry(struct dentry *dentry, struct vfsintent *intent)
 {
 	struct inode *inode = dentry->d_inode;
 	int diff;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/hpfs/dir.c linux-2.5.69-02-open2/fs/hpfs/dir.c
--- linux-2.5.69-01-open1/fs/hpfs/dir.c	2002-11-17 20:53:57.000000000 +0100
+++ linux-2.5.69-02-open2/fs/hpfs/dir.c	2003-05-22 14:49:07.000000000 +0200
@@ -198,7 +198,7 @@
  *	      to tell read_inode to read fnode or not.
  */
 
-struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry)
+struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	const char *name = dentry->d_name.name;
 	unsigned len = dentry->d_name.len;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/hpfs/hpfs_fn.h linux-2.5.69-02-open2/fs/hpfs/hpfs_fn.h
--- linux-2.5.69-01-open1/fs/hpfs/hpfs_fn.h	2003-01-01 02:27:01.000000000 +0100
+++ linux-2.5.69-02-open2/fs/hpfs/hpfs_fn.h	2003-05-22 14:49:31.000000000 +0200
@@ -216,7 +216,7 @@
 int hpfs_dir_release(struct inode *, struct file *);
 loff_t hpfs_dir_lseek(struct file *, loff_t, int);
 int hpfs_readdir(struct file *, void *, filldir_t);
-struct dentry *hpfs_lookup(struct inode *, struct dentry *);
+struct dentry *hpfs_lookup(struct inode *, struct dentry *, struct vfsintent *);
 
 /* dnode.c */
 
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/intermezzo/dcache.c linux-2.5.69-02-open2/fs/intermezzo/dcache.c
--- linux-2.5.69-01-open1/fs/intermezzo/dcache.c	2003-03-14 01:52:26.000000000 +0100
+++ linux-2.5.69-02-open2/fs/intermezzo/dcache.c	2003-05-22 14:26:22.000000000 +0200
@@ -50,7 +50,7 @@
 kmem_cache_t * presto_dentry_slab;
 
 /* called when a cache lookup succeeds */
-static int presto_d_revalidate(struct dentry *de, int flag)
+static int presto_d_revalidate(struct dentry *de, struct vfsintent *intent)
 {
         struct inode *inode = de->d_inode;
         struct presto_file_set * root_fset;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/intermezzo/dir.c linux-2.5.69-02-open2/fs/intermezzo/dir.c
--- linux-2.5.69-01-open1/fs/intermezzo/dir.c	2003-03-18 18:08:01.000000000 +0100
+++ linux-2.5.69-02-open2/fs/intermezzo/dir.c	2003-05-22 14:26:22.000000000 +0200
@@ -239,7 +239,7 @@
         return de;
 }
 
-struct dentry *presto_lookup(struct inode * dir, struct dentry *dentry)
+struct dentry *presto_lookup(struct inode * dir, struct dentry *dentry, struct vfsintent *intent)
 {
         int rc = 0;
         struct dentry *de;
@@ -286,7 +286,7 @@
                                 (dir, dentry, ino, generation);
                         is_ilookup = 1;
                 } else
-                        de = iops->lookup(dir, dentry);
+                        de = iops->lookup(dir, dentry, intent);
 #if 0
         }
 #endif
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/intermezzo/intermezzo_fs.h linux-2.5.69-02-open2/fs/intermezzo/intermezzo_fs.h
--- linux-2.5.69-01-open1/fs/intermezzo/intermezzo_fs.h	2002-12-14 02:27:19.000000000 +0100
+++ linux-2.5.69-02-open2/fs/intermezzo/intermezzo_fs.h	2003-05-22 14:56:51.000000000 +0200
@@ -370,7 +370,7 @@
 # define PRESTO_ILOOKUP_MAGIC "...ino:"
 # define PRESTO_ILOOKUP_SEP ':'
 int izo_dentry_is_ilookup(struct dentry *, ino_t *id, unsigned int *generation);
-struct dentry *presto_lookup(struct inode * dir, struct dentry *dentry);
+struct dentry *presto_lookup(struct inode * dir, struct dentry *dentry, struct vfsintent *intent);
 
 struct presto_dentry_data {
         int dd_count; /* how mnay dentries are using this dentry */
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/isofs/namei.c linux-2.5.69-02-open2/fs/isofs/namei.c
--- linux-2.5.69-01-open1/fs/isofs/namei.c	2002-05-23 15:18:50.000000000 +0200
+++ linux-2.5.69-02-open2/fs/isofs/namei.c	2003-05-22 14:26:22.000000000 +0200
@@ -158,7 +158,7 @@
 	return 0;
 }
 
-struct dentry *isofs_lookup(struct inode * dir, struct dentry * dentry)
+struct dentry *isofs_lookup(struct inode * dir, struct dentry * dentry, struct vfsintent *intent)
 {
 	unsigned long ino;
 	struct inode *inode;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/jffs/inode-v23.c linux-2.5.69-02-open2/fs/jffs/inode-v23.c
--- linux-2.5.69-01-open1/fs/jffs/inode-v23.c	2003-05-13 03:59:23.000000000 +0200
+++ linux-2.5.69-02-open2/fs/jffs/inode-v23.c	2003-05-22 14:26:22.000000000 +0200
@@ -642,7 +642,7 @@
 /* Find a file in a directory. If the file exists, return its
    corresponding dentry.  */
 static struct dentry *
-jffs_lookup(struct inode *dir, struct dentry *dentry)
+jffs_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct jffs_file *d;
 	struct jffs_file *f;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/jffs2/dir.c linux-2.5.69-02-open2/fs/jffs2/dir.c
--- linux-2.5.69-01-open1/fs/jffs2/dir.c	2002-11-20 12:19:02.000000000 +0100
+++ linux-2.5.69-02-open2/fs/jffs2/dir.c	2003-05-22 14:26:22.000000000 +0200
@@ -26,7 +26,7 @@
 static int jffs2_readdir (struct file *, void *, filldir_t);
 
 static int jffs2_create (struct inode *,struct dentry *,int);
-static struct dentry *jffs2_lookup (struct inode *,struct dentry *);
+static struct dentry *jffs2_lookup (struct inode *,struct dentry *, struct vfsintent *);
 static int jffs2_link (struct dentry *,struct inode *,struct dentry *);
 static int jffs2_unlink (struct inode *,struct dentry *);
 static int jffs2_symlink (struct inode *,struct dentry *,const char *);
@@ -66,7 +66,7 @@
    and we use the same hash function as the dentries. Makes this 
    nice and simple
 */
-static struct dentry *jffs2_lookup(struct inode *dir_i, struct dentry *target)
+static struct dentry *jffs2_lookup(struct inode *dir_i, struct dentry *target, struct vfsintent *intent)
 {
 	struct jffs2_inode_info *dir_f;
 	struct jffs2_sb_info *c;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/jfs/namei.c linux-2.5.69-02-open2/fs/jfs/namei.c
--- linux-2.5.69-01-open1/fs/jfs/namei.c	2003-02-05 17:27:03.000000000 +0100
+++ linux-2.5.69-02-open2/fs/jfs/namei.c	2003-05-22 14:26:22.000000000 +0200
@@ -1374,7 +1374,7 @@
 	return -rc;
 }
 
-static struct dentry *jfs_lookup(struct inode *dip, struct dentry *dentry)
+static struct dentry *jfs_lookup(struct inode *dip, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct btstack btstack;
 	ino_t inum;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/libfs.c linux-2.5.69-02-open2/fs/libfs.c
--- linux-2.5.69-01-open1/fs/libfs.c	2003-05-13 22:42:27.000000000 +0200
+++ linux-2.5.69-02-open2/fs/libfs.c	2003-05-22 14:26:22.000000000 +0200
@@ -31,7 +31,7 @@
  * exist, we know it is negative.
  */
 
-struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry)
+struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	d_add(dentry, NULL);
 	return NULL;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/minix/namei.c linux-2.5.69-02-open2/fs/minix/namei.c
--- linux-2.5.69-01-open1/fs/minix/namei.c	2002-11-20 12:19:02.000000000 +0100
+++ linux-2.5.69-02-open2/fs/minix/namei.c	2003-05-22 14:26:22.000000000 +0200
@@ -54,7 +54,7 @@
 	.d_hash		= minix_hash,
 };
 
-static struct dentry *minix_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *minix_lookup(struct inode * dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct inode * inode = NULL;
 	ino_t ino;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/msdos/namei.c linux-2.5.69-02-open2/fs/msdos/namei.c
--- linux-2.5.69-01-open1/fs/msdos/namei.c	2002-11-17 21:40:03.000000000 +0100
+++ linux-2.5.69-02-open2/fs/msdos/namei.c	2003-05-22 14:26:22.000000000 +0200
@@ -193,7 +193,7 @@
  */
 
 /***** Get inode using directory and name */
-struct dentry *msdos_lookup(struct inode *dir,struct dentry *dentry)
+struct dentry *msdos_lookup(struct inode *dir,struct dentry *dentry, struct vfsintent *intent)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/namei.c linux-2.5.69-02-open2/fs/namei.c
--- linux-2.5.69-01-open1/fs/namei.c	2003-05-22 15:30:50.000000000 +0200
+++ linux-2.5.69-02-open2/fs/namei.c	2003-05-23 00:29:00.000000000 +0200
@@ -274,7 +274,7 @@
  * Internal lookup() using the new generic dcache.
  * SMP-safe
  */
-static struct dentry * cached_lookup(struct dentry * parent, struct qstr * name, int flags)
+static struct dentry * cached_lookup(struct dentry * parent, struct qstr * name, struct vfsintent *intent)
 {
 	struct dentry * dentry = __d_lookup(parent, name);
 
@@ -285,7 +285,7 @@
 		dentry = d_lookup(parent, name);
 
 	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
-		if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) {
+		if (!dentry->d_op->d_revalidate(dentry, intent) && !d_invalidate(dentry)) {
 			dput(dentry);
 			dentry = NULL;
 		}
@@ -337,7 +337,7 @@
  * make sure that nobody added the entry to the dcache in the meantime..
  * SMP-safe
  */
-static struct dentry * real_lookup(struct dentry * parent, struct qstr * name, int flags)
+static struct dentry * real_lookup(struct dentry * parent, struct qstr * name, struct vfsintent *intent)
 {
 	struct dentry * result;
 	struct inode *dir = parent->d_inode;
@@ -362,7 +362,7 @@
 		struct dentry * dentry = d_alloc(parent, name);
 		result = ERR_PTR(-ENOMEM);
 		if (dentry) {
-			result = dir->i_op->lookup(dir, dentry);
+			result = dir->i_op->lookup(dir, dentry, intent);
 			if (result)
 				dput(dentry);
 			else
@@ -378,7 +378,7 @@
 	 */
 	up(&dir->i_sem);
 	if (result->d_op && result->d_op->d_revalidate) {
-		if (!result->d_op->d_revalidate(result, flags) && !d_invalidate(result)) {
+		if (!result->d_op->d_revalidate(result, intent) && !d_invalidate(result)) {
 			dput(result);
 			result = ERR_PTR(-ENOENT);
 		}
@@ -524,8 +524,7 @@
  *  small and for now I'd prefer to have fast path as straight as possible.
  *  It _is_ time-critical.
  */
-static int do_lookup(struct nameidata *nd, struct qstr *name,
-		     struct path *path, int flags)
+static int do_lookup(struct nameidata *nd, struct qstr *name, struct path *path)
 {
 	struct vfsmount *mnt = nd->mnt;
 	struct dentry *dentry = __d_lookup(nd->dentry, name);
@@ -540,13 +539,13 @@
 	return 0;
 
 need_lookup:
-	dentry = real_lookup(nd->dentry, name, LOOKUP_CONTINUE);
+	dentry = real_lookup(nd->dentry, name, nd->intent);
 	if (IS_ERR(dentry))
 		goto fail;
 	goto done;
 
 need_revalidate:
-	if (dentry->d_op->d_revalidate(dentry, flags))
+	if (dentry->d_op->d_revalidate(dentry, nd->intent))
 		goto done;
 	if (d_invalidate(dentry))
 		goto done;
@@ -640,7 +639,7 @@
 				break;
 		}
 		/* This does the actual lookups.. */
-		err = do_lookup(nd, &this, &next, LOOKUP_CONTINUE);
+		err = do_lookup(nd, &this, &next);
 		if (err)
 			break;
 		/* Check mountpoints.. */
@@ -701,7 +700,7 @@
 			if (err < 0)
 				break;
 		}
-		err = do_lookup(nd, &this, &next, 0);
+		err = do_lookup(nd, &this, &next);
 		if (err)
 			break;
 		follow_mount(&next.mnt, &next.dentry);
@@ -768,6 +767,7 @@
 		 * NAME was not found in alternate root or it's a directory.  Try to find
 		 * it in the normal root:
 		 */
+		nd_root.intent = NULL;
 		nd_root.last_type = LAST_ROOT;
 		nd_root.flags = nd->flags;
 		read_lock(&current->fs->lock);
@@ -835,8 +835,10 @@
 	return 1;
 }
 
-int path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
+int __path_lookup(const char *name, unsigned int flags, struct nameidata *nd,
+		struct vfsintent *intent)
 {
+	nd->intent = intent;
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
 	nd->flags = flags;
 
@@ -862,12 +864,17 @@
 	return link_path_walk(name, nd);
 }
 
+int path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
+{
+	return __path_lookup(name, flags, nd, NULL);
+}
+
 /*
  * Restricted form of lookup. Doesn't follow links, single-component only,
  * needs parent already locked. Doesn't follow mounts.
  * SMP-safe.
  */
-struct dentry * lookup_hash(struct qstr *name, struct dentry * base)
+static struct dentry * __lookup_hash(struct qstr *name, struct dentry * base, struct vfsintent *intent)
 {
 	struct dentry * dentry;
 	struct inode *inode;
@@ -890,13 +897,13 @@
 			goto out;
 	}
 
-	dentry = cached_lookup(base, name, 0);
+	dentry = cached_lookup(base, name, intent);
 	if (!dentry) {
 		struct dentry *new = d_alloc(base, name);
 		dentry = ERR_PTR(-ENOMEM);
 		if (!new)
 			goto out;
-		dentry = inode->i_op->lookup(inode, new);
+		dentry = inode->i_op->lookup(inode, new, intent);
 		if (!dentry)
 			dentry = new;
 		else
@@ -906,6 +913,11 @@
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
@@ -1211,6 +1223,7 @@
 	int error = 0;
 	struct dentry *dentry;
 	struct dentry *dir;
+	struct vfsintent *intent = &opendata->intent;
 	int count = 0;
 
 	/* Allow the LSM permission hook to distinguish append 
@@ -1218,11 +1231,14 @@
 	if (flag & O_APPEND)
 		opendata->acc_mode |= MAY_APPEND;
 
+	intent->type = OPEN_INTENT;
+	intent->nd = nd;
+
 	/*
 	 * The simplest case - just a plain lookup.
 	 */
 	if (!(flag & O_CREAT)) {
-		error = path_lookup(pathname, lookup_flags(flag), nd);
+		error = __path_lookup(pathname, lookup_flags(flag), nd, intent);
 		if (error)
 			return error;
 		dentry = nd->dentry;
@@ -1232,7 +1248,7 @@
 	/*
 	 * Create - we need to know the parent.
 	 */
-	error = path_lookup(pathname, LOOKUP_PARENT, nd);
+	error = __path_lookup(pathname, LOOKUP_PARENT, nd, intent);
 	if (error)
 		return error;
 
@@ -1247,7 +1263,7 @@
 
 	dir = nd->dentry;
 	down(&dir->d_inode->i_sem);
-	dentry = lookup_hash(&nd->last, nd->dentry);
+	dentry = __lookup_hash(&nd->last, nd->dentry, intent);
 
 do_last:
 	error = PTR_ERR(dentry);
@@ -1351,7 +1367,7 @@
 	}
 	dir = nd->dentry;
 	down(&dir->d_inode->i_sem);
-	dentry = lookup_hash(&nd->last, nd->dentry);
+	dentry = __lookup_hash(&nd->last, nd->dentry, intent);
 	putname(nd->last.name);
 	goto do_last;
 }
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/ncpfs/dir.c linux-2.5.69-02-open2/fs/ncpfs/dir.c
--- linux-2.5.69-01-open1/fs/ncpfs/dir.c	2003-04-03 08:51:32.000000000 +0200
+++ linux-2.5.69-02-open2/fs/ncpfs/dir.c	2003-05-22 14:26:22.000000000 +0200
@@ -35,7 +35,7 @@
 static int ncp_readdir(struct file *, void *, filldir_t);
 
 static int ncp_create(struct inode *, struct dentry *, int);
-static struct dentry *ncp_lookup(struct inode *, struct dentry *);
+static struct dentry *ncp_lookup(struct inode *, struct dentry *, struct vfsintent *);
 static int ncp_unlink(struct inode *, struct dentry *);
 static int ncp_mkdir(struct inode *, struct dentry *, int);
 static int ncp_rmdir(struct inode *, struct dentry *);
@@ -72,7 +72,7 @@
 /*
  * Dentry operations routines
  */
-static int ncp_lookup_validate(struct dentry *, int);
+static int ncp_lookup_validate(struct dentry *, struct vfsintent *);
 static int ncp_hash_dentry(struct dentry *, struct qstr *);
 static int ncp_compare_dentry (struct dentry *, struct qstr *, struct qstr *);
 static int ncp_delete_dentry(struct dentry *);
@@ -264,7 +264,7 @@
 
 
 static int
-__ncp_lookup_validate(struct dentry * dentry, int flags)
+__ncp_lookup_validate(struct dentry * dentry, struct vfsintent *intent)
 {
 	struct ncp_server *server;
 	struct dentry *parent;
@@ -333,11 +333,11 @@
 }
 
 static int
-ncp_lookup_validate(struct dentry * dentry, int flags)
+ncp_lookup_validate(struct dentry * dentry, struct vfsintent *intent)
 {
 	int res;
 	lock_kernel();
-	res = __ncp_lookup_validate(dentry, flags);
+	res = __ncp_lookup_validate(dentry, intent);
 	unlock_kernel();
 	return res;
 }
@@ -797,7 +797,7 @@
 	return result;
 }
 
-static struct dentry *ncp_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *ncp_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct ncp_server *server = NCP_SERVER(dir);
 	struct inode *inode = NULL;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/nfs/dir.c linux-2.5.69-02-open2/fs/nfs/dir.c
--- linux-2.5.69-01-open1/fs/nfs/dir.c	2003-05-07 12:34:41.000000000 +0200
+++ linux-2.5.69-02-open2/fs/nfs/dir.c	2003-05-22 14:26:22.000000000 +0200
@@ -37,7 +37,7 @@
 
 static int nfs_opendir(struct inode *, struct file *);
 static int nfs_readdir(struct file *, void *, filldir_t);
-static struct dentry *nfs_lookup(struct inode *, struct dentry *);
+static struct dentry *nfs_lookup(struct inode *, struct dentry *, struct vfsintent *);
 static int nfs_cached_lookup(struct inode *, struct dentry *,
 				struct nfs_fh *, struct nfs_fattr *);
 static int nfs_create(struct inode *, struct dentry *, int);
@@ -515,7 +515,7 @@
  * If the parent directory is seen to have changed, we throw out the
  * cached dentry and do a new lookup.
  */
-static int nfs_lookup_revalidate(struct dentry * dentry, int flags)
+static int nfs_lookup_revalidate(struct dentry * dentry, struct vfsintent *intent)
 {
 	struct inode *dir;
 	struct inode *inode;
@@ -630,7 +630,7 @@
 	.d_iput		= nfs_dentry_iput,
 };
 
-static struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry)
+static struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, struct vfsintent *intent)
 {
 	struct inode *inode = NULL;
 	int error;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/nfsctl.c linux-2.5.69-02-open2/fs/nfsctl.c
--- linux-2.5.69-01-open1/fs/nfsctl.c	2003-04-16 23:09:42.000000000 +0200
+++ linux-2.5.69-02-open2/fs/nfsctl.c	2003-05-23 00:03:56.000000000 +0200
@@ -34,6 +34,7 @@
 	nd.dentry = dget(nd.mnt->mnt_root);
 	nd.last_type = LAST_ROOT;
 	nd.flags = 0;
+	nd.intent = NULL;
 
 	error = path_walk(name, &nd);
 	if (error)
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/ntfs/namei.c linux-2.5.69-02-open2/fs/ntfs/namei.c
--- linux-2.5.69-01-open1/fs/ntfs/namei.c	2003-04-30 14:51:58.000000000 +0200
+++ linux-2.5.69-02-open2/fs/ntfs/namei.c	2003-05-22 14:26:22.000000000 +0200
@@ -29,6 +29,7 @@
  * ntfs_lookup - find the inode represented by a dentry in a directory inode
  * @dir_ino:	directory inode in which to look for the inode
  * @dent:	dentry representing the inode to look for
+ * @intent:	lookup intent structure
  *
  * In short, ntfs_lookup() looks for the inode represented by the dentry @dent
  * in the directory inode @dir_ino and if found attaches the inode to the
@@ -87,7 +88,7 @@
  *    name. We then convert the name to the current NLS code page, and proceed
  *    searching for a dentry with this name, etc, as in case 2), above.
  */
-static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent)
+static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent, struct vfsintent *intent)
 {
 	ntfs_volume *vol = NTFS_SB(dir_ino->i_sb);
 	struct inode *dent_inode;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/openpromfs/inode.c linux-2.5.69-02-open2/fs/openpromfs/inode.c
--- linux-2.5.69-01-open1/fs/openpromfs/inode.c	2002-09-28 17:36:22.000000000 +0200
+++ linux-2.5.69-02-open2/fs/openpromfs/inode.c	2003-05-22 14:26:22.000000000 +0200
@@ -61,7 +61,7 @@
 
 static int openpromfs_create (struct inode *, struct dentry *, int);
 static int openpromfs_readdir(struct file *, void *, filldir_t);
-static struct dentry *openpromfs_lookup(struct inode *, struct dentry *dentry);
+static struct dentry *openpromfs_lookup(struct inode *, struct dentry *dentry, struct vfsintent *intent);
 static int openpromfs_unlink (struct inode *, struct dentry *dentry);
 
 static ssize_t nodenum_read(struct file *file, char *buf,
@@ -639,7 +639,7 @@
 	return 0;
 }
 
-static struct dentry *openpromfs_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *openpromfs_lookup(struct inode * dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	int ino = 0;
 #define OPFSL_DIR	0
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/proc/base.c linux-2.5.69-02-open2/fs/proc/base.c
--- linux-2.5.69-01-open1/fs/proc/base.c	2003-05-19 21:20:10.000000000 +0200
+++ linux-2.5.69-02-open2/fs/proc/base.c	2003-05-22 14:26:22.000000000 +0200
@@ -806,7 +806,7 @@
  * directory. In this case, however, we can do it - no aliasing problems
  * due to the way we treat inodes.
  */
-static int pid_revalidate(struct dentry * dentry, int flags)
+static int pid_revalidate(struct dentry * dentry, struct vfsintent *intent)
 {
 	if (proc_task(dentry->d_inode)->pid)
 		return 1;
@@ -814,7 +814,7 @@
 	return 0;
 }
 
-static int pid_fd_revalidate(struct dentry * dentry, int flags)
+static int pid_fd_revalidate(struct dentry * dentry, struct vfsintent *intent)
 {
 	struct task_struct *task = proc_task(dentry->d_inode);
 	int fd = proc_type(dentry->d_inode) - PROC_PID_FD_DIR;
@@ -898,7 +898,7 @@
 }
 
 /* SMP-safe */
-static struct dentry *proc_lookupfd(struct inode * dir, struct dentry * dentry)
+static struct dentry *proc_lookupfd(struct inode * dir, struct dentry * dentry, struct vfsintent *intent)
 {
 	struct task_struct *task = proc_task(dir);
 	unsigned fd = name_to_int(dentry);
@@ -964,7 +964,7 @@
 };
 
 /* SMP-safe */
-static struct dentry *proc_base_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *proc_base_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct inode *inode;
 	int error;
@@ -1096,7 +1096,7 @@
 };
 
 /* SMP-safe */
-struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry)
+struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, struct vfsintent *intent)
 {
 	struct task_struct *task;
 	struct inode *inode;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/proc/generic.c linux-2.5.69-02-open2/fs/proc/generic.c
--- linux-2.5.69-01-open1/fs/proc/generic.c	2003-04-25 17:46:19.000000000 +0200
+++ linux-2.5.69-02-open2/fs/proc/generic.c	2003-05-22 14:26:22.000000000 +0200
@@ -336,7 +336,7 @@
  * Don't create negative dentries here, return -ENOENT by hand
  * instead.
  */
-struct dentry *proc_lookup(struct inode * dir, struct dentry *dentry)
+struct dentry *proc_lookup(struct inode * dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct inode *inode = NULL;
 	struct proc_dir_entry * de;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/proc/root.c linux-2.5.69-02-open2/fs/proc/root.c
--- linux-2.5.69-01-open1/fs/proc/root.c	2002-09-28 17:36:29.000000000 +0200
+++ linux-2.5.69-02-open2/fs/proc/root.c	2003-05-22 14:26:22.000000000 +0200
@@ -79,7 +79,7 @@
 	proc_bus = proc_mkdir("bus", 0);
 }
 
-static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry)
+static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry, struct vfsintent *intent)
 {
 	if (dir->i_ino == PROC_ROOT_INO) { /* check for safety... */
 		lock_kernel();
@@ -87,11 +87,11 @@
 		unlock_kernel();
 	}
 
-	if (!proc_lookup(dir, dentry)) {
+	if (!proc_lookup(dir, dentry, intent)) {
 		return NULL;
 	}
 	
-	return proc_pid_lookup(dir, dentry);
+	return proc_pid_lookup(dir, dentry, intent);
 }
 
 static int proc_root_readdir(struct file * filp,
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/qnx4/namei.c linux-2.5.69-02-open2/fs/qnx4/namei.c
--- linux-2.5.69-01-open1/fs/qnx4/namei.c	2002-05-23 15:18:54.000000000 +0200
+++ linux-2.5.69-02-open2/fs/qnx4/namei.c	2003-05-22 14:26:22.000000000 +0200
@@ -107,7 +107,7 @@
 	return NULL;
 }
 
-struct dentry * qnx4_lookup(struct inode *dir, struct dentry *dentry)
+struct dentry * qnx4_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	int ino;
 	struct qnx4_inode_entry *de;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/reiserfs/namei.c linux-2.5.69-02-open2/fs/reiserfs/namei.c
--- linux-2.5.69-01-open1/fs/reiserfs/namei.c	2002-12-07 11:19:52.000000000 +0100
+++ linux-2.5.69-02-open2/fs/reiserfs/namei.c	2003-05-22 14:26:22.000000000 +0200
@@ -316,7 +316,7 @@
 }
 
 
-static struct dentry * reiserfs_lookup (struct inode * dir, struct dentry * dentry)
+static struct dentry * reiserfs_lookup (struct inode * dir, struct dentry * dentry, struct vfsintent *intent)
 {
     int retval;
     struct inode * inode = NULL;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/romfs/inode.c linux-2.5.69-02-open2/fs/romfs/inode.c
--- linux-2.5.69-01-open1/fs/romfs/inode.c	2003-01-02 20:04:34.000000000 +0100
+++ linux-2.5.69-02-open2/fs/romfs/inode.c	2003-05-22 14:26:22.000000000 +0200
@@ -329,7 +329,7 @@
 }
 
 static struct dentry *
-romfs_lookup(struct inode *dir, struct dentry *dentry)
+romfs_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	unsigned long offset, maxoff;
 	int fslen, res;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/smbfs/dir.c linux-2.5.69-02-open2/fs/smbfs/dir.c
--- linux-2.5.69-01-open1/fs/smbfs/dir.c	2003-04-03 08:51:32.000000000 +0200
+++ linux-2.5.69-02-open2/fs/smbfs/dir.c	2003-05-22 15:07:27.000000000 +0200
@@ -24,7 +24,7 @@
 static int smb_readdir(struct file *, void *, filldir_t);
 static int smb_dir_open(struct inode *, struct file *);
 
-static struct dentry *smb_lookup(struct inode *, struct dentry *);
+static struct dentry *smb_lookup(struct inode *, struct dentry *, struct vfsintent *);
 static int smb_create(struct inode *, struct dentry *, int);
 static int smb_mkdir(struct inode *, struct dentry *, int);
 static int smb_rmdir(struct inode *, struct dentry *);
@@ -268,7 +268,7 @@
 /*
  * Dentry operations routines
  */
-static int smb_lookup_validate(struct dentry *, int);
+static int smb_lookup_validate(struct dentry *, struct vfsintent *);
 static int smb_hash_dentry(struct dentry *, struct qstr *);
 static int smb_compare_dentry(struct dentry *, struct qstr *, struct qstr *);
 static int smb_delete_dentry(struct dentry *);
@@ -292,7 +292,7 @@
  * This is the callback when the dcache has a lookup hit.
  */
 static int
-smb_lookup_validate(struct dentry * dentry, int flags)
+smb_lookup_validate(struct dentry * dentry, struct vfsintent *intent)
 {
 	struct smb_sb_info *server = server_from_dentry(dentry);
 	struct inode * inode = dentry->d_inode;
@@ -420,7 +420,7 @@
 }
 
 static struct dentry *
-smb_lookup(struct inode *dir, struct dentry *dentry)
+smb_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct smb_fattr finfo;
 	struct inode *inode;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/sysv/namei.c linux-2.5.69-02-open2/fs/sysv/namei.c
--- linux-2.5.69-01-open1/fs/sysv/namei.c	2002-11-20 12:19:02.000000000 +0100
+++ linux-2.5.69-02-open2/fs/sysv/namei.c	2003-05-22 14:26:22.000000000 +0200
@@ -64,7 +64,7 @@
 	.d_hash		= sysv_hash,
 };
 
-static struct dentry *sysv_lookup(struct inode * dir, struct dentry * dentry)
+static struct dentry *sysv_lookup(struct inode * dir, struct dentry * dentry, struct vfsintent *intent)
 {
 	struct inode * inode = NULL;
 	ino_t ino;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/udf/namei.c linux-2.5.69-02-open2/fs/udf/namei.c
--- linux-2.5.69-01-open1/fs/udf/namei.c	2002-11-20 12:19:02.000000000 +0100
+++ linux-2.5.69-02-open2/fs/udf/namei.c	2003-05-22 14:26:22.000000000 +0200
@@ -289,6 +289,7 @@
  * PRE-CONDITIONS
  *	dir			Pointer to inode of parent directory.
  *	dentry			Pointer to dentry to complete.
+ *	intent			Pointer to lookup intent structure
  *
  * POST-CONDITIONS
  *	<return>		Zero on success.
@@ -299,7 +300,7 @@
  */
 
 static struct dentry *
-udf_lookup(struct inode *dir, struct dentry *dentry)
+udf_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct inode *inode = NULL;
 	struct fileIdentDesc cfi, *fi;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/ufs/namei.c linux-2.5.69-02-open2/fs/ufs/namei.c
--- linux-2.5.69-01-open1/fs/ufs/namei.c	2002-11-20 12:19:02.000000000 +0100
+++ linux-2.5.69-02-open2/fs/ufs/namei.c	2003-05-22 14:26:22.000000000 +0200
@@ -62,7 +62,7 @@
 	return err;
 }
 
-static struct dentry *ufs_lookup(struct inode * dir, struct dentry *dentry)
+static struct dentry *ufs_lookup(struct inode * dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct inode * inode = NULL;
 	ino_t ino;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/umsdos/dir.c linux-2.5.69-02-open2/fs/umsdos/dir.c
--- linux-2.5.69-01-open1/fs/umsdos/dir.c	2002-11-05 16:35:59.000000000 +0100
+++ linux-2.5.69-02-open2/fs/umsdos/dir.c	2003-05-22 14:26:22.000000000 +0200
@@ -30,7 +30,7 @@
  */
 
 /* nothing for now ... */
-static int umsdos_dentry_validate(struct dentry *dentry, int flags)
+static int umsdos_dentry_validate(struct dentry *dentry, struct vfsintent *intent)
 {
 	return 1;
 }
@@ -564,7 +564,7 @@
  * Called by VFS; should fill dentry->d_inode via d_add.
  */
 
-struct dentry *UMSDOS_lookup (struct inode *dir, struct dentry *dentry)
+struct dentry *UMSDOS_lookup (struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	struct dentry *ret;
 
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/umsdos/rdir.c linux-2.5.69-02-open2/fs/umsdos/rdir.c
--- linux-2.5.69-01-open1/fs/umsdos/rdir.c	2002-11-05 16:35:59.000000000 +0100
+++ linux-2.5.69-02-open2/fs/umsdos/rdir.c	2003-05-22 14:26:22.000000000 +0200
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
+struct dentry *UMSDOS_rlookup ( struct inode *dir, struct dentry *dentry, struct vfsintent *intent)
 {
 	return umsdos_rlookup_x (dir, dentry, 0);
 }
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/vfat/namei.c linux-2.5.69-02-open2/fs/vfat/namei.c
--- linux-2.5.69-01-open1/fs/vfat/namei.c	2002-11-17 20:53:57.000000000 +0100
+++ linux-2.5.69-02-open2/fs/vfat/namei.c	2003-05-22 14:26:22.000000000 +0200
@@ -45,7 +45,7 @@
 static int vfat_hash(struct dentry *parent, struct qstr *qstr);
 static int vfat_cmpi(struct dentry *dentry, struct qstr *a, struct qstr *b);
 static int vfat_cmp(struct dentry *dentry, struct qstr *a, struct qstr *b);
-static int vfat_revalidate(struct dentry *dentry, int);
+static int vfat_revalidate(struct dentry *dentry, struct vfsintent *intent);
 
 static struct dentry_operations vfat_dentry_ops[4] = {
 	{
@@ -68,7 +68,7 @@
 	}
 };
 
-static int vfat_revalidate(struct dentry *dentry, int flags)
+static int vfat_revalidate(struct dentry *dentry, struct vfsintent *intent)
 {
 	PRINTK1(("vfat_revalidate: %s\n", dentry->d_name.name));
 	spin_lock(&dcache_lock);
@@ -859,7 +859,7 @@
 	return res ? res : -ENOENT;
 }
 
-struct dentry *vfat_lookup(struct inode *dir,struct dentry *dentry)
+struct dentry *vfat_lookup(struct inode *dir,struct dentry *dentry, struct vfsintent *intent)
 {
 	int res;
 	struct vfat_slot_info sinfo;
diff -u --recursive --new-file linux-2.5.69-01-open1/fs/xfs/linux/xfs_iops.c linux-2.5.69-02-open2/fs/xfs/linux/xfs_iops.c
--- linux-2.5.69-01-open1/fs/xfs/linux/xfs_iops.c	2003-05-19 20:29:41.000000000 +0200
+++ linux-2.5.69-02-open2/fs/xfs/linux/xfs_iops.c	2003-05-22 14:26:22.000000000 +0200
@@ -190,7 +190,8 @@
 STATIC struct dentry *
 linvfs_lookup(
 	struct inode	*dir,
-	struct dentry	*dentry)
+	struct dentry	*dentry,
+	struct vfsintent *intent)
 {
 	struct inode	*ip = NULL;
 	vnode_t		*vp, *cvp = NULL;
diff -u --recursive --new-file linux-2.5.69-01-open1/include/linux/affs_fs.h linux-2.5.69-02-open2/include/linux/affs_fs.h
--- linux-2.5.69-01-open1/include/linux/affs_fs.h	2002-03-17 20:38:14.000000000 +0100
+++ linux-2.5.69-02-open2/include/linux/affs_fs.h	2003-05-22 14:38:54.000000000 +0200
@@ -41,7 +41,7 @@
 /* namei.c */
 
 extern int	affs_hash_name(struct super_block *sb, const u8 *name, unsigned int len);
-extern struct dentry *affs_lookup(struct inode *dir, struct dentry *dentry);
+extern struct dentry *affs_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *);
 extern int	affs_unlink(struct inode *dir, struct dentry *dentry);
 extern int	affs_create(struct inode *dir, struct dentry *dentry, int mode);
 extern int	affs_mkdir(struct inode *dir, struct dentry *dentry, int mode);
diff -u --recursive --new-file linux-2.5.69-01-open1/include/linux/dcache.h linux-2.5.69-02-open2/include/linux/dcache.h
--- linux-2.5.69-01-open1/include/linux/dcache.h	2003-04-20 08:22:23.000000000 +0200
+++ linux-2.5.69-02-open2/include/linux/dcache.h	2003-05-22 14:26:22.000000000 +0200
@@ -10,6 +10,7 @@
 #include <linux/rcupdate.h>
 #include <asm/bug.h>
 
+struct vfsintent;
 struct vfsmount;
 
 /*
@@ -106,7 +107,7 @@
 #define DNAME_INLINE_LEN	(sizeof(struct dentry)-offsetof(struct dentry,d_iname))
  
 struct dentry_operations {
-	int (*d_revalidate)(struct dentry *, int);
+	int (*d_revalidate)(struct dentry *, struct vfsintent *);
 	int (*d_hash) (struct dentry *, struct qstr *);
 	int (*d_compare) (struct dentry *, struct qstr *, struct qstr *);
 	int (*d_delete)(struct dentry *);
diff -u --recursive --new-file linux-2.5.69-01-open1/include/linux/efs_fs.h linux-2.5.69-02-open2/include/linux/efs_fs.h
--- linux-2.5.69-01-open1/include/linux/efs_fs.h	2003-02-17 01:16:32.000000000 +0100
+++ linux-2.5.69-02-open2/include/linux/efs_fs.h	2003-05-22 14:26:22.000000000 +0200
@@ -46,7 +46,7 @@
 extern void efs_read_inode(struct inode *);
 extern efs_block_t efs_map_block(struct inode *, efs_block_t);
 
-extern struct dentry *efs_lookup(struct inode *, struct dentry *);
+extern struct dentry *efs_lookup(struct inode *, struct dentry *, struct vfsintent *);
 extern int efs_bmap(struct inode *, int);
 
 #endif /* __EFS_FS_H__ */
diff -u --recursive --new-file linux-2.5.69-01-open1/include/linux/fs.h linux-2.5.69-02-open2/include/linux/fs.h
--- linux-2.5.69-01-open1/include/linux/fs.h	2003-05-22 14:25:57.000000000 +0200
+++ linux-2.5.69-02-open2/include/linux/fs.h	2003-05-22 14:26:22.000000000 +0200
@@ -22,6 +22,7 @@
 #include <asm/atomic.h>
 
 struct iovec;
+struct vfsintent;
 struct nameidata;
 struct opendata;
 struct pipe_inode_info;
@@ -730,7 +731,7 @@
 
 struct inode_operations {
 	int (*create) (struct inode *,struct dentry *,int);
-	struct dentry * (*lookup) (struct inode *,struct dentry *);
+	struct dentry * (*lookup) (struct inode *,struct dentry *, struct vfsintent *);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
 	int (*symlink) (struct inode *,struct dentry *,const char *);
@@ -1291,7 +1292,7 @@
 extern int simple_commit_write(struct file *file, struct page *page,
 				unsigned offset, unsigned to);
 
-extern struct dentry *simple_lookup(struct inode *, struct dentry *);
+extern struct dentry *simple_lookup(struct inode *, struct dentry *, struct vfsintent *);
 extern ssize_t generic_read_dir(struct file *, char __user *, size_t, loff_t *);
 extern struct file_operations simple_dir_operations;
 extern struct inode_operations simple_dir_inode_operations;
diff -u --recursive --new-file linux-2.5.69-01-open1/include/linux/iso_fs.h linux-2.5.69-02-open2/include/linux/iso_fs.h
--- linux-2.5.69-01-open1/include/linux/iso_fs.h	2003-04-25 21:35:37.000000000 +0200
+++ linux-2.5.69-02-open2/include/linux/iso_fs.h	2003-05-22 14:26:22.000000000 +0200
@@ -227,7 +227,7 @@
 int get_joliet_filename(struct iso_directory_record *, unsigned char *, struct inode *);
 int get_acorn_filename(struct iso_directory_record *, char *, struct inode *);
 
-extern struct dentry *isofs_lookup(struct inode *, struct dentry *);
+extern struct dentry *isofs_lookup(struct inode *, struct dentry *, struct vfsintent *);
 extern struct buffer_head *isofs_bread(struct inode *, sector_t);
 extern int isofs_get_blocks(struct inode *, sector_t, struct buffer_head **, unsigned long);
 
diff -u --recursive --new-file linux-2.5.69-01-open1/include/linux/msdos_fs.h linux-2.5.69-02-open2/include/linux/msdos_fs.h
--- linux-2.5.69-01-open1/include/linux/msdos_fs.h	2003-05-13 06:23:11.000000000 +0200
+++ linux-2.5.69-02-open2/include/linux/msdos_fs.h	2003-05-22 14:26:22.000000000 +0200
@@ -317,7 +317,7 @@
 		    struct msdos_dir_entry **res_de, int *ino);
 
 /* msdos/namei.c  - these are for Umsdos */
-extern struct dentry *msdos_lookup(struct inode *dir, struct dentry *);
+extern struct dentry *msdos_lookup(struct inode *dir, struct dentry *, struct vfsintent *);
 extern int msdos_create(struct inode *dir, struct dentry *dentry, int mode);
 extern int msdos_rmdir(struct inode *dir, struct dentry *dentry);
 extern int msdos_mkdir(struct inode *dir, struct dentry *dentry, int mode);
@@ -327,7 +327,7 @@
 extern int msdos_fill_super(struct super_block *sb, void *data, int silent);
 
 /* vfat/namei.c - these are for dmsdos */
-extern struct dentry *vfat_lookup(struct inode *dir, struct dentry *);
+extern struct dentry *vfat_lookup(struct inode *dir, struct dentry *, struct vfsintent *);
 extern int vfat_create(struct inode *dir, struct dentry *dentry, int mode);
 extern int vfat_rmdir(struct inode *dir, struct dentry *dentry);
 extern int vfat_unlink(struct inode *dir, struct dentry *dentry);
diff -u --recursive --new-file linux-2.5.69-01-open1/include/linux/namei.h linux-2.5.69-02-open2/include/linux/namei.h
--- linux-2.5.69-01-open1/include/linux/namei.h	2003-04-09 20:44:15.000000000 +0200
+++ linux-2.5.69-02-open2/include/linux/namei.h	2003-05-23 00:28:04.000000000 +0200
@@ -4,6 +4,7 @@
 #include <linux/linkage.h>
 
 struct vfsmount;
+struct vfsintent;
 
 struct nameidata {
 	struct dentry	*dentry;
@@ -11,6 +12,7 @@
 	struct qstr	last;
 	unsigned int	flags;
 	int		last_type;
+	struct vfsintent	*intent;
 };
 
 /*
@@ -33,6 +35,27 @@
 #define LOOKUP_NOALT		32
 
 
+/*
+ * Intent type
+ */
+enum intent_type {
+	OPEN_INTENT = 0,
+};
+
+/*
+ * Intents are used in order to declare what you want to
+ * do with the results of a lookup operation.
+ *
+ * They are used by filesystems that need atomicity guarantees
+ * between the lookup and the subsequent fs operation beyond
+ * that provided by the VFS. Currently this means NFS...
+ */
+struct vfsintent {
+	enum intent_type type;
+	struct nameidata *nd;
+};
+
+
 extern int FASTCALL(__user_walk(const char __user *, unsigned, struct nameidata *));
 #define user_path_walk(name,nd) \
 	__user_walk(name, LOOKUP_FOLLOW, nd)
diff -u --recursive --new-file linux-2.5.69-01-open1/include/linux/open.h linux-2.5.69-02-open2/include/linux/open.h
--- linux-2.5.69-01-open1/include/linux/open.h	2003-05-22 14:25:57.000000000 +0200
+++ linux-2.5.69-02-open2/include/linux/open.h	2003-05-22 14:26:22.000000000 +0200
@@ -2,10 +2,12 @@
 #define _LINUX_OPEN_H
 
 struct opendata {
+	struct vfsintent intent;
 	int flag;
 	int mode;
 	int acc_mode;
 
+	struct file *filp;
 #if 0
 	/* Private data to be added to the filp->private_data field */
 	void *private;
diff -u --recursive --new-file linux-2.5.69-01-open1/include/linux/proc_fs.h linux-2.5.69-02-open2/include/linux/proc_fs.h
--- linux-2.5.69-01-open1/include/linux/proc_fs.h	2003-05-12 20:10:09.000000000 +0200
+++ linux-2.5.69-02-open2/include/linux/proc_fs.h	2003-05-22 14:26:22.000000000 +0200
@@ -86,7 +86,7 @@
 extern void proc_root_init(void);
 extern void proc_misc_init(void);
 
-struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry);
+struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, struct vfsintent *intent);
 int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir);
 
 extern struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
@@ -107,7 +107,7 @@
  * of the /proc/<pid> subdirectories.
  */
 extern int proc_readdir(struct file *, void *, filldir_t);
-extern struct dentry *proc_lookup(struct inode *, struct dentry *);
+extern struct dentry *proc_lookup(struct inode *, struct dentry *, struct vfsintent *);
 
 extern struct file_operations proc_kcore_operations;
 extern struct file_operations proc_kmsg_operations;
diff -u --recursive --new-file linux-2.5.69-01-open1/include/linux/qnx4_fs.h linux-2.5.69-02-open2/include/linux/qnx4_fs.h
--- linux-2.5.69-01-open1/include/linux/qnx4_fs.h	2002-10-07 19:27:58.000000000 +0200
+++ linux-2.5.69-02-open2/include/linux/qnx4_fs.h	2003-05-22 14:26:22.000000000 +0200
@@ -110,7 +110,7 @@
 	struct inode vfs_inode;
 };
 
-extern struct dentry *qnx4_lookup(struct inode *dir, struct dentry *dentry);
+extern struct dentry *qnx4_lookup(struct inode *dir, struct dentry *dentry, struct vfsintent *intent);
 extern unsigned long qnx4_count_free_blocks(struct super_block *sb);
 extern unsigned long qnx4_block_map(struct inode *inode, long iblock);
 
diff -u --recursive --new-file linux-2.5.69-01-open1/include/linux/umsdos_fs.p linux-2.5.69-02-open2/include/linux/umsdos_fs.p
--- linux-2.5.69-01-open1/include/linux/umsdos_fs.p	2002-11-20 12:19:02.000000000 +0100
+++ linux-2.5.69-02-open2/include/linux/umsdos_fs.p	2003-05-22 14:26:22.000000000 +0200
@@ -10,7 +10,7 @@
 void umsdos_lookup_patch_new(struct dentry *, struct umsdos_info *);
 int umsdos_is_pseudodos (struct inode *dir, struct dentry *dentry);
 struct dentry *umsdos_lookup_x ( struct inode *dir, struct dentry *dentry, int nopseudo);
-struct dentry *UMSDOS_lookup(struct inode *, struct dentry *);
+struct dentry *UMSDOS_lookup(struct inode *, struct dentry *, struct vfsintent *);
 struct dentry *umsdos_lookup_dentry(struct dentry *, char *, int, int);
 struct dentry *umsdos_covered(struct dentry *, char *, int);
 
@@ -92,7 +92,7 @@
 
 /* rdir.c 22/03/95 03.31.42 */
 struct dentry *umsdos_rlookup_x (struct inode *dir, struct dentry *dentry, int nopseudo);
-struct dentry *UMSDOS_rlookup (struct inode *dir, struct dentry *dentry);
+struct dentry *UMSDOS_rlookup (struct inode *dir, struct dentry *dentry, struct vfsintent *intent);
 
 static inline struct umsdos_inode_info *UMSDOS_I(struct inode *inode)
 {
diff -u --recursive --new-file linux-2.5.69-01-open1/net/sunrpc/rpc_pipe.c linux-2.5.69-02-open2/net/sunrpc/rpc_pipe.c
--- linux-2.5.69-01-open1/net/sunrpc/rpc_pipe.c	2003-05-13 22:42:28.000000000 +0200
+++ linux-2.5.69-02-open2/net/sunrpc/rpc_pipe.c	2003-05-23 00:01:03.000000000 +0200
@@ -402,6 +402,7 @@
 	nd->dentry = dget(rpc_mount->mnt_root);
 	nd->last_type = LAST_ROOT;
 	nd->flags = LOOKUP_PARENT;
+	nd->intent = NULL;
 
 	if (path_walk(path, nd)) {
 		printk(KERN_WARNING "%s: %s failed to find path %s\n",
