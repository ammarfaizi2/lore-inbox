Return-Path: <linux-kernel-owner+w=401wt.eu-S932850AbWLTB1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932850AbWLTB1W (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 20:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932865AbWLTB1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 20:27:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:18950 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932850AbWLTB1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 20:27:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QbrmpxpBxz052rlsFyIGRsBLa6rauqu89UpnQt759u57ORAU1ioJnOORW5kOyCgn+KS3RSZnJIFBLQs+WXKtBk2OsFsO2gXArrp7dfvGamPnNduksyIlCeZCfjiqjW8WEWLpwFzBSRJB4eetEJ1sdxkZYk/BP5TeHB+GE+ZiaZg=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] NFS: Kill the obsolete NFS_PARANOIA
Date: Wed, 20 Dec 2006 02:29:23 +0100
User-Agent: KMail/1.9.4
Cc: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612200229.24107.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This patch has been both compile and run-time tested.
It has been in -mm for quite a while without problems.
Trond & Andrew have both signed off on it.

Please apply.


Remove obsolete NFS_PARANOIA.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Acked-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/dir.c      |   17 ++---------------
 fs/nfs/getroot.c  |    1 -
 fs/nfs/inode.c    |    3 ---
 fs/nfs/nfs2xdr.c  |    1 -
 fs/nfs/pagelist.c |    7 -------
 5 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index dee3d6c..8b71075 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -38,7 +38,6 @@ #include "nfs4_fs.h"
 #include "delegation.h"
 #include "iostat.h"
 
-#define NFS_PARANOIA 1
 /* #define NFS_DEBUG_VERBOSE 1 */
 
 static int nfs_opendir(struct inode *, struct file *);
@@ -1322,11 +1321,6 @@ static int nfs_sillyrename(struct inode 
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
@@ -1641,16 +1635,9 @@ static int nfs_rename(struct inode *old_
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
 		drop_nlink(new_inode);
 
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index 8391bd7..4dc193f 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -42,7 +42,6 @@ #include "delegation.h"
 #include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_CLIENT
-#define NFS_PARANOIA 1
 
 /*
  * get an NFS2/NFS3 root dentry from the root filehandle
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 63e4702..d29dfe0 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -48,7 +48,6 @@ #include "iostat.h"
 #include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
-#define NFS_PARANOIA 1
 
 static void nfs_invalidate_inode(struct inode *);
 static int nfs_update_inode(struct inode *, struct nfs_fattr *);
@@ -1022,10 +1021,8 @@ static int nfs_update_inode(struct inode
 	/*
 	 * Big trouble! The inode has become a different object.
 	 */
-#ifdef NFS_PARANOIA
 	printk(KERN_DEBUG "%s: inode %ld mode changed, %07o to %07o\n",
 			__FUNCTION__, inode->i_ino, inode->i_mode, fattr->mode);
-#endif
  out_err:
 	/*
 	 * No need to worry about unhashing the dentry, as the
diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index 3be4e72..1fc757b 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -26,7 +26,6 @@ #include <linux/nfs_fs.h>
 #include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_XDR
-/* #define NFS_PARANOIA 1 */
 
 /* Mapping from NFS error code to "errno" error code. */
 #define errno_NFSERR_IO		EIO
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index ca4b1d4..7e32bf3 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -19,8 +19,6 @@ #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/writeback.h>
 
-#define NFS_PARANOIA 1
-
 static struct kmem_cache *nfs_page_cachep;
 
 static inline struct nfs_page *
@@ -172,11 +170,6 @@ nfs_release_request(struct nfs_page *req
 	if (!atomic_dec_and_test(&req->wb_count))
 		return;
 
-#ifdef NFS_PARANOIA
-	BUG_ON (!list_empty(&req->wb_list));
-	BUG_ON (NFS_WBACK_BUSY(req));
-#endif
-
 	/* Release struct file or cached credential */
 	nfs_clear_request(req);
 	put_nfs_open_context(req->wb_context);


