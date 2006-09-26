Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWIZXaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWIZXaA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 19:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWIZXaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 19:30:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:62109 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932489AbWIZX37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 19:29:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Sq3UiKAZXQOQnDFjTRajdXCgFEwBuVqUAkNLo+msWHwkXxyrMgIa5RmD4KsH+Fp7iMU1M+3GqbqlMaulSJxzUX3v/VMiTwlUUwaswtr0+kMEDFnC4zDahn9lc4zSTC8nNtnOsBl3z2aingEd0iYh+vsHR7bwfulkwt/8jzfQz7I=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [PATCH][resend] NFS: Kill obsolete NFS_PARANOIA
Date: Wed, 27 Sep 2006 01:31:16 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, Rick Sladkey <jrs@world.std.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609270131.16608.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  [ please keep me on Cc: ] 


Remove obsolete NFS_PARANOIA .

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/nfs/dir.c      |   17 ++---------------
 fs/nfs/inode.c    |   11 +----------
 fs/nfs/nfs2xdr.c  |    1 -
 fs/nfs/pagelist.c |    7 ++-----
 4 files changed, 5 insertions(+), 31 deletions(-)

diff -upr linux-2.6.18-git6-orig/fs/nfs/dir.c linux-2.6.18-git6/fs/nfs/dir.c
--- linux-2.6.18-git6-orig/fs/nfs/dir.c	2006-09-27 01:16:52.000000000 +0200
+++ linux-2.6.18-git6/fs/nfs/dir.c	2006-09-27 01:25:21.000000000 +0200
@@ -38,7 +38,6 @@
 #include "delegation.h"
 #include "iostat.h"
 
-#define NFS_PARANOIA 1
 /* #define NFS_DEBUG_VERBOSE 1 */
 
 static int nfs_opendir(struct inode *, struct file *);
@@ -1309,11 +1308,6 @@ static int nfs_sillyrename(struct inode 
 		atomic_read(&dentry->d_count));
 	nfs_inc_stats(dir, NFSIOS_SILLYRENAME);
 
-#ifdef NFS_PARANOIA
-if (!dentry->d_inode)
-printk("NFS: silly-renaming %s/%s, negative dentry??\n",
-dentry->d_parent->d_name.name, dentry->d_name.name);
-#endif
 	/*
 	 * We don't allow a dentry to be silly-renamed twice.
 	 */
@@ -1628,16 +1622,9 @@ static int nfs_rename(struct inode *old_
 			new_inode = NULL;
 			/* instantiate the replacement target */
 			d_instantiate(new_dentry, NULL);
-		} else if (atomic_read(&new_dentry->d_count) > 1) {
-		/* dentry still busy? */
-#ifdef NFS_PARANOIA
-			printk("nfs_rename: target %s/%s busy, d_count=%d\n",
-			       new_dentry->d_parent->d_name.name,
-			       new_dentry->d_name.name,
-			       atomic_read(&new_dentry->d_count));
-#endif
+		} else if (atomic_read(&new_dentry->d_count) > 1)
+			/* dentry still busy? */
 			goto out;
-		}
 	} else
 		new_inode->i_nlink--;
 
diff -upr linux-2.6.18-git6-orig/fs/nfs/inode.c linux-2.6.18-git6/fs/nfs/inode.c
--- linux-2.6.18-git6-orig/fs/nfs/inode.c	2006-09-27 01:16:52.000000000 +0200
+++ linux-2.6.18-git6/fs/nfs/inode.c	2006-09-27 01:25:57.000000000 +0200
@@ -48,7 +48,6 @@
 #include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
-#define NFS_PARANOIA 1
 
 static void nfs_invalidate_inode(struct inode *);
 static int nfs_update_inode(struct inode *, struct nfs_fattr *);
@@ -894,7 +893,7 @@ static int nfs_update_inode(struct inode
 	 * Make sure the inode's type hasn't changed.
 	 */
 	if ((inode->i_mode & S_IFMT) != (fattr->mode & S_IFMT))
-		goto out_changed;
+		goto out_err;
 
 	server = NFS_SERVER(inode);
 	/* Update the fsid if and only if this is the root directory */
@@ -1004,14 +1003,6 @@ static int nfs_update_inode(struct inode
 		nfsi->cache_validity |= invalid;
 
 	return 0;
- out_changed:
-	/*
-	 * Big trouble! The inode has become a different object.
-	 */
-#ifdef NFS_PARANOIA
-	printk(KERN_DEBUG "%s: inode %ld mode changed, %07o to %07o\n",
-			__FUNCTION__, inode->i_ino, inode->i_mode, fattr->mode);
-#endif
  out_err:
 	/*
 	 * No need to worry about unhashing the dentry, as the
diff -upr linux-2.6.18-git6-orig/fs/nfs/nfs2xdr.c linux-2.6.18-git6/fs/nfs/nfs2xdr.c
--- linux-2.6.18-git6-orig/fs/nfs/nfs2xdr.c	2006-09-27 01:16:52.000000000 +0200
+++ linux-2.6.18-git6/fs/nfs/nfs2xdr.c	2006-09-27 01:25:57.000000000 +0200
@@ -26,7 +26,6 @@
 #include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_XDR
-/* #define NFS_PARANOIA 1 */
 
 /* Mapping from NFS error code to "errno" error code. */
 #define errno_NFSERR_IO		EIO
diff -upr linux-2.6.18-git6-orig/fs/nfs/pagelist.c linux-2.6.18-git6/fs/nfs/pagelist.c
--- linux-2.6.18-git6-orig/fs/nfs/pagelist.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18-git6/fs/nfs/pagelist.c	2006-09-27 01:25:57.000000000 +0200
@@ -18,7 +18,6 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 
-#define NFS_PARANOIA 1
 
 static kmem_cache_t *nfs_page_cachep;
 
@@ -171,10 +170,8 @@ nfs_release_request(struct nfs_page *req
 	if (!atomic_dec_and_test(&req->wb_count))
 		return;
 
-#ifdef NFS_PARANOIA
-	BUG_ON (!list_empty(&req->wb_list));
-	BUG_ON (NFS_WBACK_BUSY(req));
-#endif
+	BUG_ON(!list_empty(&req->wb_list));
+	BUG_ON(NFS_WBACK_BUSY(req));
 
 	/* Release struct file or cached credential */
 	nfs_clear_request(req);


