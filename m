Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030728AbWKORYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030728AbWKORYx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030731AbWKORYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:24:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41695 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030728AbWKORYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:24:51 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
To: trond.myklebust@fys.uio.no, torvalds@osdl.org, akpm@osdl.org,
       sds@tycho.nsa.gov
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Subject: [PATCH 25/19] FS-Cache: NFS: Wait in releasepage() if FS-Cache is busy and __GFP_WAIT is set
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 15 Nov 2006 17:22:26 +0000
Message-ID: <899.1163611346@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make NFS wait in its releasepage() op if FS-Cache is busy with a page and
__GFP_WAIT was supplied in the gfp parameter rather than returning false to the
VM.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/nfs/file.c    |    2 +-
 fs/nfs/fscache.h |    9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 9da03ec..6ac3ac7 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -350,7 +350,7 @@ static int nfs_release_page(struct page 
 	if (nfs_wb_page(page->mapping->host, page) < 0)
 		return 0;
 
-	if (nfs_fscache_release_page(page) < 0)
+	if (nfs_fscache_release_page(page, gfp) < 0)
 		return 0;
 
 	/* PG_private may have been set due to either caching or writing */
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 92c2dbf..c363421 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -238,10 +238,13 @@ static inline void nfs_fscache_install_v
  * release the caching state associated with a page, if the page isn't busy
  * interacting with the cache
  */
-static inline int nfs_fscache_release_page(struct page *page)
+static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
 {
-	if (PageFsMisc(page))
-		return -EBUSY;
+	if (PageFsMisc(page)) {
+		if (!(gfp & __GFP_WAIT))
+			return -EBUSY;
+		wait_on_page_fs_misc(page);
+	}
 
 	if (PageNfsCached(page)) {
 		struct nfs_inode *nfsi = NFS_I(page->mapping->host);
