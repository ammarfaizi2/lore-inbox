Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030703AbWKOQyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030703AbWKOQyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030700AbWKOQyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:54:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32698 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030703AbWKOQyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:54:04 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
To: trond.myklebust@fys.uio.no, torvalds@osdl.org, akpm@osdl.org,
       sds@tycho.nsa.gov
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Subject: [PATCH 24/19] FS-Cache: NFS: Remove old support for R/W caching
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 15 Nov 2006 16:51:47 +0000
Message-ID: <31408.1163609507@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove old support for caching of files that are opened for writing.  This is
not currently supported, and so the bits that enabled it are currently useless.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/nfs/fscache.c |   11 -----------
 fs/nfs/fscache.h |   32 --------------------------------
 fs/nfs/inode.c   |    1 -
 fs/nfs/write.c   |    3 ---
 4 files changed, 0 insertions(+), 47 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 81286f6..6bdd1f2 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -334,14 +334,3 @@ void nfs_readpage_from_fscache_complete(
 			unlock_page(page);
 	}
 }
-
-/*
- * handle completion of a page being read from the cache
- * - really need to synchronise the end of writeback, probably using a page
- *   flag, but for the moment we disable caching on writable files
- */
-void nfs_writepage_to_fscache_complete(struct page *page,
-				       void *data,
-				       int error)
-{
-}
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index b82b896..92c2dbf 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -425,33 +425,6 @@ static inline int nfs_readpages_from_fsc
 	return ret;
 }
 
-/*
- * store an updated page in fscache
- */
-extern void nfs_writepage_to_fscache_complete(struct page *page, void *data, int error);
-
-static inline void nfs_writepage_to_fscache(struct inode *inode,
-					    struct page *page)
-{
-	int error;
-
-	if (PageNfsCached(page) && NFS_I(inode)->fscache) {
-		dfprintk(FSCACHE,
-			 "NFS: writepage_to_fscache (0x%p/0x%p/0x%p)\n",
-			 NFS_I(inode)->fscache, page, inode);
-
-		error = fscache_write_page(NFS_I(inode)->fscache, page,
-					   nfs_writepage_to_fscache_complete,
-					   NULL, GFP_KERNEL);
-		if (error != 0) {
-			dfprintk(FSCACHE,
-				 "NFS:    fscache_write_page error %d\n",
-				 error);
-			fscache_uncache_page(NFS_I(inode)->fscache, page);
-		}
-	}
-}
-
 #else /* CONFIG_NFS_FSCACHE */
 static inline int nfs_fscache_register(void) { return 0; }
 static inline void nfs_fscache_unregister(void) {}
@@ -493,10 +466,5 @@ static inline int nfs_readpages_from_fsc
 	return -ENOBUFS;
 }
 
-static inline void nfs_writepage_to_fscache(struct inode *inode, struct page *page)
-{
-	BUG_ON(PageNfsCached(page));
-}
-
 #endif /* CONFIG_NFS_FSCACHE */
 #endif /* _NFS_FSCACHE_H */
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 25376a5..3409448 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -381,7 +381,6 @@ void nfs_setattr_update_inode(struct ino
 	if ((attr->ia_valid & ATTR_SIZE) != 0) {
 		nfs_inc_stats(inode, NFSIOS_SETATTRTRUNC);
 		inode->i_size = attr->ia_size;
-		nfs_fscache_set_size(inode);
 		vmtruncate(inode, attr->ia_size);
 	}
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 77d0d9d..a2e0570 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -340,9 +340,6 @@ do_it:
 		err = -EBADF;
 		goto out;
 	}
-
-	nfs_writepage_to_fscache(inode, page);
-
 	lock_kernel();
 	if (!IS_SYNC(inode) && inode_referenced) {
 		err = nfs_writepage_async(ctx, inode, page, 0, offset);
