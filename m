Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUCABYR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 20:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbUCABYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 20:24:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24990 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262215AbUCABXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 20:23:52 -0500
Date: Sun, 29 Feb 2004 20:24:15 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Hellwig <hch@infradead.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [SELINUX] Handle fuse binary mount data.
In-Reply-To: <20040229150213.3ebd7ef9.akpm@osdl.org>
Message-ID: <Xine.LNX.4.44.0402291938140.22392-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Feb 2004, Andrew Morton wrote:

> Christoph Hellwig <hch@infradead.org> wrote:
>
> > Umm, binary mount data is bad enough, but hardcoding filesystem-depend code
> > in selinux is just bogus..
> 
> Yes, it's rather awkward.
> 
> Could we do something such as passing a new mount flag in from userspace? 
> Add a new flag alongside MS_SYNCHRONOUS, MS_REMOUNT and friends?

It seems more like a property of the filesystem type: perhaps add 
FS_BINARY_MOUNTDATA to fs_flags for such filesystems, per the patch below.

We also need to change one of the LSM hook arguments.


diff -urN -X dontdiff linux-2.6.3-mm4.o/fs/afs/super.c linux-2.6.3-mm4.w/fs/afs/super.c
--- linux-2.6.3-mm4.o/fs/afs/super.c	2004-02-04 08:39:05.000000000 -0500
+++ linux-2.6.3-mm4.w/fs/afs/super.c	2004-02-29 19:50:28.797502696 -0500
@@ -53,6 +53,7 @@
 	.name		= "afs",
 	.get_sb		= afs_get_sb,
 	.kill_sb	= kill_anon_super,
+	.fs_flags	= FS_BINARY_MOUNTDATA,
 };
 
 static struct super_operations afs_super_ops = {
diff -urN -X dontdiff linux-2.6.3-mm4.o/fs/coda/inode.c linux-2.6.3-mm4.w/fs/coda/inode.c
--- linux-2.6.3-mm4.o/fs/coda/inode.c	2003-09-27 20:50:20.000000000 -0400
+++ linux-2.6.3-mm4.w/fs/coda/inode.c	2004-02-29 19:49:14.272832168 -0500
@@ -306,5 +306,6 @@
 	.name		= "coda",
 	.get_sb		= coda_get_sb,
 	.kill_sb	= kill_anon_super,
+	.fs_flags	= FS_BINARY_MOUNTDATA,
 };
 
diff -urN -X dontdiff linux-2.6.3-mm4.o/fs/nfs/inode.c linux-2.6.3-mm4.w/fs/nfs/inode.c
--- linux-2.6.3-mm4.o/fs/nfs/inode.c	2004-02-25 22:42:12.000000000 -0500
+++ linux-2.6.3-mm4.w/fs/nfs/inode.c	2004-02-29 19:48:24.350421528 -0500
@@ -1406,7 +1406,7 @@
 	.name		= "nfs",
 	.get_sb		= nfs_get_sb,
 	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT,
+	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
 };
 
 #ifdef CONFIG_NFS_V4
@@ -1720,7 +1720,7 @@
 	.name		= "nfs4",
 	.get_sb		= nfs4_get_sb,
 	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT,
+	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
 };
 
 #define nfs4_zero_state(nfsi) \
diff -urN -X dontdiff linux-2.6.3-mm4.o/fs/smbfs/inode.c linux-2.6.3-mm4.w/fs/smbfs/inode.c
--- linux-2.6.3-mm4.o/fs/smbfs/inode.c	2003-10-15 08:53:19.000000000 -0400
+++ linux-2.6.3-mm4.w/fs/smbfs/inode.c	2004-02-29 19:50:58.172037088 -0500
@@ -778,6 +778,7 @@
 	.name		= "smbfs",
 	.get_sb		= smb_get_sb,
 	.kill_sb	= kill_anon_super,
+	.fs_flags	= FS_BINARY_MOUNTDATA,
 };
 
 static int __init init_smb_fs(void)
diff -urN -X dontdiff linux-2.6.3-mm4.o/fs/super.c linux-2.6.3-mm4.w/fs/super.c
--- linux-2.6.3-mm4.o/fs/super.c	2004-02-25 22:42:12.000000000 -0500
+++ linux-2.6.3-mm4.w/fs/super.c	2004-02-29 19:56:03.687591664 -0500
@@ -746,7 +746,7 @@
 			goto out_mnt;
 		}
 
-		error = security_sb_copy_data(fstype, data, secdata);
+		error = security_sb_copy_data(type, data, secdata);
 		if (error) {
 			sb = ERR_PTR(error);
 			goto out_free_secdata;
diff -urN -X dontdiff linux-2.6.3-mm4.o/include/linux/fs.h linux-2.6.3-mm4.w/include/linux/fs.h
--- linux-2.6.3-mm4.o/include/linux/fs.h	2004-02-25 22:42:14.000000000 -0500
+++ linux-2.6.3-mm4.w/include/linux/fs.h	2004-02-29 19:43:33.922573272 -0500
@@ -89,6 +89,7 @@
 
 /* public flags for file_system_type */
 #define FS_REQUIRES_DEV 1 
+#define FS_BINARY_MOUNTDATA 2
 #define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
 #define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
 				  * as nfs_rename() will be cleaned up
diff -urN -X dontdiff linux-2.6.3-mm4.o/include/linux/security.h linux-2.6.3-mm4.w/include/linux/security.h
--- linux-2.6.3-mm4.o/include/linux/security.h	2004-02-25 22:42:14.000000000 -0500
+++ linux-2.6.3-mm4.w/include/linux/security.h	2004-02-29 19:57:58.125194504 -0500
@@ -177,7 +177,7 @@
  *	options cleanly (a filesystem may modify the data e.g. with strsep()).
  *	This also allows the original mount data to be stripped of security-
  *	specific options to avoid having to make filesystems aware of them.
- *	@fstype the type of filesystem being mounted.
+ *	@type the type of filesystem being mounted.
  *	@orig the original mount data copied from userspace.
  *	@copy copied data which will be passed to the security module.
  *	Returns 0 if the copy was successful.
@@ -1033,7 +1033,8 @@
 
 	int (*sb_alloc_security) (struct super_block * sb);
 	void (*sb_free_security) (struct super_block * sb);
-	int (*sb_copy_data)(const char *fstype, void *orig, void *copy);
+	int (*sb_copy_data)(struct file_system_type *type,
+			    void *orig, void *copy);
 	int (*sb_kern_mount) (struct super_block *sb, void *data);
 	int (*sb_statfs) (struct super_block * sb);
 	int (*sb_mount) (char *dev_name, struct nameidata * nd,
@@ -1318,9 +1319,10 @@
 	security_ops->sb_free_security (sb);
 }
 
-static inline int security_sb_copy_data (const char *fstype, void *orig, void *copy)
+static inline int security_sb_copy_data (struct file_system_type *type,
+					 void *orig, void *copy)
 {
-	return security_ops->sb_copy_data (fstype, orig, copy);
+	return security_ops->sb_copy_data (type, orig, copy);
 }
 
 static inline int security_sb_kern_mount (struct super_block *sb, void *data)
@@ -1988,7 +1990,8 @@
 static inline void security_sb_free (struct super_block *sb)
 { }
 
-static inline int security_sb_copy_data (const char *fstype, void *orig, void *copy)
+static inline int security_sb_copy_data (struct file_system_type *type,
+					 void *orig, void *copy)
 {
 	return 0;
 }
diff -urN -X dontdiff linux-2.6.3-mm4.o/security/dummy.c linux-2.6.3-mm4.w/security/dummy.c
--- linux-2.6.3-mm4.o/security/dummy.c	2004-02-25 22:42:16.000000000 -0500
+++ linux-2.6.3-mm4.w/security/dummy.c	2004-02-29 19:58:29.999348896 -0500
@@ -194,7 +194,8 @@
 	return;
 }
 
-static int dummy_sb_copy_data (const char *fstype, void *orig, void *copy)
+static int dummy_sb_copy_data (struct file_system_type *type,
+			       void *orig, void *copy)
 {
 	return 0;
 }
diff -urN -X dontdiff linux-2.6.3-mm4.o/security/selinux/hooks.c linux-2.6.3-mm4.w/security/selinux/hooks.c
--- linux-2.6.3-mm4.o/security/selinux/hooks.c	2004-02-25 22:42:16.000000000 -0500
+++ linux-2.6.3-mm4.w/security/selinux/hooks.c	2004-02-29 20:15:19.841829504 -0500
@@ -331,25 +331,24 @@
 
 	name = sb->s_type->name;
 
-	/* Ignore these fileystems with binary mount option data. */
-	if (!strcmp(name, "coda") ||
-	    !strcmp(name, "afs") || !strcmp(name, "smbfs"))
-		goto out;
-
-	/* NFS we understand. */
-	if (!strcmp(name, "nfs")) {
-		struct nfs_mount_data *d = data;
+	if (sb->s_type->fs_flags & FS_BINARY_MOUNTDATA) {
 
-		if (d->version <  NFS_MOUNT_VERSION)
+		/* NFS we understand. */
+		if (!strcmp(name, "nfs")) {
+			struct nfs_mount_data *d = data;
+			
+			if (d->version <  NFS_MOUNT_VERSION)
+				goto out;
+				
+			if (d->context[0]) {
+				context = d->context;
+				seen |= Opt_context;
+			}
+		} else
 			goto out;
 
-		if (d->context[0]) {
-			context = d->context;
-			seen |= Opt_context;
-		}
-
-	/* Standard string-based options. */
 	} else {
+		/* Standard string-based options. */
 		char *p, *options = data;
 
 		while ((p = strsep(&options, ",")) != NULL) {
@@ -1886,7 +1885,7 @@
 	*to += len;
 }
 
-static int selinux_sb_copy_data(const char *fstype, void *orig, void *copy)
+static int selinux_sb_copy_data(struct file_system_type *type, void *orig, void *copy)
 {
 	int fnosec, fsec, rc = 0;
 	char *in_save, *in_curr, *in_end;
@@ -1896,8 +1895,7 @@
 	sec_curr = copy;
 
 	/* Binary mount data: just copy */
-	if (!strcmp(fstype, "nfs") || !strcmp(fstype, "coda") ||
-	    !strcmp(fstype, "smbfs") || !strcmp(fstype, "afs")) {
+	if (type->fs_flags & FS_BINARY_MOUNTDATA) {
 		copy_page(sec_curr, in_curr);
 		goto out;
 	}

