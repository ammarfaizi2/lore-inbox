Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946237AbWJSRGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946237AbWJSRGh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946242AbWJSRGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:06:15 -0400
Received: from mx2.netapp.com ([216.240.18.37]:6061 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1946237AbWJSRGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:06:09 -0400
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="419607090:sNHT72497992"
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Thu, 19 Oct 2006 13:04:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20061019170432.8171.16653.stgit@lade.trondhjem.org>
In-Reply-To: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
References: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Subject: [PATCH 06/11] NFS: Deal with failure of invalidate_inode_pages2()
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 19 Oct 2006 17:06:27.0098 (UTC) FILETIME=[E9E3DFA0:01C6F3A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

If invalidate_inode_pages2() fails, then it should in principle just be
because the current process was signalled. In that case, we just want to
ensure that the inode's page cache remains marked as invalid.

Also add a helper to allow the O_DIRECT code to simply mark the page cache
as invalid once it is finished writing, instead of calling
invalidate_inode_pages2() itself.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/dir.c           |    6 ++++--
 fs/nfs/direct.c        |   13 ++-----------
 fs/nfs/inode.c         |   28 +++++++++++++++++++++++-----
 include/linux/nfs_fs.h |    1 +
 4 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 481f889..58d4405 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -203,8 +203,10 @@ int nfs_readdir_filler(nfs_readdir_descr
 	 * Note: assumes we have exclusive access to this mapping either
 	 *	 through inode->i_mutex or some other mechanism.
 	 */
-	if (page->index == 0)
-		invalidate_inode_pages2_range(inode->i_mapping, PAGE_CACHE_SIZE, -1);
+	if (page->index == 0 && invalidate_inode_pages2_range(inode->i_mapping, PAGE_CACHE_SIZE, -1) < 0) {
+		/* Should never happen */
+		nfs_zap_mapping(inode, inode->i_mapping);
+	}
 	unlock_page(page);
 	return 0;
  error:
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 1e873fc..bdfabf8 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -497,6 +497,7 @@ static void nfs_direct_write_complete(st
 			if (dreq->commit_data != NULL)
 				nfs_commit_free(dreq->commit_data);
 			nfs_direct_free_writedata(dreq);
+			nfs_zap_mapping(inode, inode->i_mapping);
 			nfs_direct_complete(dreq);
 	}
 }
@@ -517,6 +518,7 @@ static void nfs_direct_write_complete(st
 {
 	nfs_end_data_update(inode);
 	nfs_direct_free_writedata(dreq);
+	nfs_zap_mapping(inode, inode->i_mapping);
 	nfs_direct_complete(dreq);
 }
 #endif
@@ -830,17 +832,6 @@ ssize_t nfs_file_direct_write(struct kio
 
 	retval = nfs_direct_write(iocb, (unsigned long) buf, count, pos);
 
-	/*
-	 * XXX: nfs_end_data_update() already ensures this file's
-	 *      cached data is subsequently invalidated.  Do we really
-	 *      need to call invalidate_inode_pages2() again here?
-	 *
-	 *      For aio writes, this invalidation will almost certainly
-	 *      occur before the writes complete.  Kind of racey.
-	 */
-	if (mapping->nrpages)
-		invalidate_inode_pages2(mapping);
-
 	if (retval > 0)
 		iocb->ki_pos = pos + retval;
 
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index bc9376c..9979ad1 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -131,6 +131,15 @@ void nfs_zap_caches(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 }
 
+void nfs_zap_mapping(struct inode *inode, struct address_space *mapping)
+{
+	if (mapping->nrpages != 0) {
+		spin_lock(&inode->i_lock);
+		NFS_I(inode)->cache_validity |= NFS_INO_INVALID_DATA;
+		spin_unlock(&inode->i_lock);
+	}
+}
+
 static void nfs_zap_acl_cache(struct inode *inode)
 {
 	void (*clear_acl_cache)(struct inode *);
@@ -671,13 +680,20 @@ int nfs_revalidate_mapping(struct inode 
 	if ((nfsi->cache_validity & NFS_INO_REVAL_PAGECACHE)
 			|| nfs_attribute_timeout(inode))
 		ret = __nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	if (ret < 0)
+		goto out;
 
 	if (nfsi->cache_validity & NFS_INO_INVALID_DATA) {
-		nfs_inc_stats(inode, NFSIOS_DATAINVALIDATE);
-		if (S_ISREG(inode->i_mode))
-			nfs_sync_mapping(mapping);
-		invalidate_inode_pages2(mapping);
-
+		if (mapping->nrpages != 0) {
+			if (S_ISREG(inode->i_mode)) {
+				ret = nfs_sync_mapping(mapping);
+				if (ret < 0)
+					goto out;
+			}
+			ret = invalidate_inode_pages2(mapping);
+			if (ret < 0)
+				goto out;
+		}
 		spin_lock(&inode->i_lock);
 		nfsi->cache_validity &= ~NFS_INO_INVALID_DATA;
 		if (S_ISDIR(inode->i_mode)) {
@@ -687,10 +703,12 @@ int nfs_revalidate_mapping(struct inode 
 		}
 		spin_unlock(&inode->i_lock);
 
+		nfs_inc_stats(inode, NFSIOS_DATAINVALIDATE);
 		dfprintk(PAGECACHE, "NFS: (%s/%Ld) data cache invalidated\n",
 				inode->i_sb->s_id,
 				(long long)NFS_FILEID(inode));
 	}
+out:
 	return ret;
 }
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 76ff548..6b2de1b 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -290,6 +290,7 @@ static inline int nfs_verify_change_attr
  * linux/fs/nfs/inode.c
  */
 extern int nfs_sync_mapping(struct address_space *mapping);
+extern void nfs_zap_mapping(struct inode *inode, struct address_space *mapping);
 extern void nfs_zap_caches(struct inode *);
 extern struct inode *nfs_fhget(struct super_block *, struct nfs_fh *,
 				struct nfs_fattr *);
