Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTGKPAz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTGKPAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:00:55 -0400
Received: from pat.uio.no ([129.240.130.16]:9636 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262955AbTGKPAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:00:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16142.54383.804882.881178@charged.uio.no>
Date: Fri, 11 Jul 2003 17:14:55 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.75 Support dentry revalidation under open(".")
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

  link_path_walk() currently treats the special filenames ".", ".." 
and "/" differently in that it does not call down to the filesystem in
order to revalidate the cached dentry, but just assumes that it is
fine.

  For most filesystems this is OK, but it the case of the stateless
NFS, this means that it circumvents path staleness detection, and the
attribute+data cache revalidation code on such common commands as
opendir(".").
  The following patch provides a way to do such revalidation for NFS
without impacting other filesystems.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.74/fs/namei.c linux-2.5.74-reval/fs/namei.c
--- linux-2.5.74/fs/namei.c	2003-07-07 21:25:00.000000000 +0200
+++ linux-2.5.74-reval/fs/namei.c	2003-07-08 18:37:06.000000000 +0200
@@ -574,7 +574,7 @@
 	while (*name=='/')
 		name++;
 	if (!*name)
-		goto return_base;
+		goto return_reval;
 
 	inode = nd->dentry->d_inode;
 	if (current->link_count)
@@ -695,7 +695,7 @@
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
 			case 1:
-				goto return_base;
+				goto return_reval;
 		}
 		if (nd->dentry->d_op && nd->dentry->d_op->d_hash) {
 			err = nd->dentry->d_op->d_hash(nd->dentry, &this);
@@ -739,6 +739,21 @@
 			nd->last_type = LAST_DOT;
 		else if (this.len == 2 && this.name[1] == '.')
 			nd->last_type = LAST_DOTDOT;
+		else
+			goto return_base;
+return_reval:
+		/*
+		 * We bypassed the ordinary revalidation routines.
+		 * We may need to check the cached dentry for staleness.
+		 */
+		if (nd->dentry && nd->dentry->d_sb &&
+		    (nd->dentry->d_sb->s_type->fs_flags & FS_REVAL_DOT)) {
+			err = -ESTALE;
+			if (!nd->dentry->d_op->d_revalidate(nd->dentry, nd)) {
+				d_invalidate(nd->dentry);
+				break;
+			}
+		}
 return_base:
 		return 0;
 out_dput:
diff -u --recursive --new-file linux-2.5.74/fs/nfs/inode.c linux-2.5.74-reval/fs/nfs/inode.c
--- linux-2.5.74/fs/nfs/inode.c	2003-06-20 22:16:06.000000000 +0200
+++ linux-2.5.74-reval/fs/nfs/inode.c	2003-07-08 17:41:23.000000000 +0200
@@ -1273,7 +1273,7 @@
 	.name		= "nfs",
 	.get_sb		= nfs_get_sb,
 	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_ODD_RENAME,
+	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT,
 };
 
 #ifdef CONFIG_NFS_V4
@@ -1505,7 +1505,7 @@
 	.name		= "nfs4",
 	.get_sb		= nfs4_get_sb,
 	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_ODD_RENAME,
+	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT,
 };
 
 #define nfs4_zero_state(nfsi) \
diff -u --recursive --new-file linux-2.5.74/include/linux/fs.h linux-2.5.74-reval/include/linux/fs.h
--- linux-2.5.74/include/linux/fs.h	2003-07-06 22:23:51.000000000 +0200
+++ linux-2.5.74-reval/include/linux/fs.h	2003-07-08 17:40:39.000000000 +0200
@@ -89,6 +89,7 @@
 
 /* public flags for file_system_type */
 #define FS_REQUIRES_DEV 1 
+#define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
 #define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
 				  * as nfs_rename() will be cleaned up
 				  */
