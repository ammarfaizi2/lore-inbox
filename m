Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTGHQ1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 12:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbTGHQ1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 12:27:09 -0400
Received: from pat.uio.no ([129.240.130.16]:34212 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264590AbTGHQ1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 12:27:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16138.62523.63031.756089@charged.uio.no>
Date: Tue, 8 Jul 2003 18:41:31 +0200
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Fastwalk: reduce cacheline bouncing of d_count (Changelog@1.1024.1.11)
In-Reply-To: <20030708162008.GA18924@delft.aura.cs.cmu.edu>
References: <16138.53118.777914.828030@charged.uio.no>
	<20030708162008.GA18924@delft.aura.cs.cmu.edu>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jan Harkes <jaharkes@cs.cmu.edu> writes:

     > One thing you might want to add to avoid revalidating all
     > pathnames that happen to start with a dot, like '.bashrc'.

Oops. Well caught! Revised patch would be as follows.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.22-odirect/fs/namei.c linux-2.4.22-fix_cto/fs/namei.c
--- linux-2.4.22-odirect/fs/namei.c	2003-06-27 13:34:41.000000000 +0200
+++ linux-2.4.22-fix_cto/fs/namei.c	2003-07-08 18:34:55.000000000 +0200
@@ -563,7 +563,7 @@
 	while (*name=='/')
 		name++;
 	if (!*name)
-		goto return_base;
+		goto return_reval;
 
 	inode = nd->dentry->d_inode;
 	if (current->link_count)
@@ -686,7 +686,7 @@
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
 			case 1:
-				goto return_base;
+				goto return_reval;
 		}
 		if (nd->dentry->d_op && nd->dentry->d_op->d_hash) {
 			err = nd->dentry->d_op->d_hash(nd->dentry, &this);
@@ -732,6 +732,26 @@
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
+			struct dentry *dentry = nd->dentry;
+			unlock_nd(nd);
+			dput(pinned.dentry);
+			mntput(pinned.mnt);
+			if (!dentry->d_op->d_revalidate(dentry, 0)) {
+				d_invalidate(dentry);
+				path_release(nd);
+				return -ESTALE;
+			}
+			return 0;
+		}
 return_base:
 		unlock_nd(nd);
 		dput(pinned.dentry);
diff -u --recursive --new-file linux-2.4.22-odirect/fs/nfs/inode.c linux-2.4.22-fix_cto/fs/nfs/inode.c
--- linux-2.4.22-odirect/fs/nfs/inode.c	2002-08-15 03:05:32.000000000 +0200
+++ linux-2.4.22-fix_cto/fs/nfs/inode.c	2003-07-08 15:24:32.000000000 +0200
@@ -1125,7 +1125,7 @@
 /*
  * File system information
  */
-static DECLARE_FSTYPE(nfs_fs_type, "nfs", nfs_read_super, FS_ODD_RENAME);
+static DECLARE_FSTYPE(nfs_fs_type, "nfs", nfs_read_super, FS_ODD_RENAME|FS_REVAL_DOT);
 
 extern int nfs_init_nfspagecache(void);
 extern void nfs_destroy_nfspagecache(void);
diff -u --recursive --new-file linux-2.4.22-odirect/include/linux/fs.h linux-2.4.22-fix_cto/include/linux/fs.h
--- linux-2.4.22-odirect/include/linux/fs.h	2003-07-08 11:47:08.000000000 +0200
+++ linux-2.4.22-fix_cto/include/linux/fs.h	2003-07-08 15:57:26.000000000 +0200
@@ -92,6 +92,7 @@
 #define FS_SINGLE	8 /* Filesystem that can have only one superblock */
 #define FS_NOMOUNT	16 /* Never mount from userland */
 #define FS_LITTER	32 /* Keeps the tree in dcache */
+#define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
 #define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
 				  * as nfs_rename() will be cleaned up
 				  */
