Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWHYQgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWHYQgx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 12:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWHYQgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 12:36:53 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:19481 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030210AbWHYQgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 12:36:52 -0400
Subject: Re: [PATCH 7/6] Lost bits - fix PG_writeback vs PG_private race in
	NFS
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <20060825153709.24254.28118.sendpatchset@twins>
References: <20060825153709.24254.28118.sendpatchset@twins>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 18:36:55 +0200
Message-Id: <1156523815.16027.43.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make sure we clear PG_writeback after we clear PG_private, otherwise
weird and wonderfull stuff will happen.

Also, teach try_to_release_page() about PG_swapcache pages.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 fs/buffer.c    |    2 +-
 fs/nfs/write.c |    5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -1567,7 +1567,7 @@ static void discard_buffer(struct buffer
  */
 int try_to_release_page(struct page *page, gfp_t gfp_mask)
 {
-	struct address_space * const mapping = page->mapping;
+	struct address_space * const mapping = page_mapping(page);
 
 	BUG_ON(!PageLocked(page));
 	if (PageWriteback(page))
Index: linux-2.6/fs/nfs/write.c
===================================================================
--- linux-2.6.orig/fs/nfs/write.c
+++ linux-2.6/fs/nfs/write.c
@@ -902,7 +902,6 @@ done:
 
 static void nfs_writepage_release(struct nfs_page *req)
 {
-	end_page_writeback(req->wb_page);
 
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 	if (!PageError(req->wb_page)) {
@@ -922,6 +921,7 @@ out:
 #else
 	nfs_inode_remove_request(req);
 #endif
+	end_page_writeback(req->wb_page);
 	nfs_clear_page_writeback(req);
 }
 
@@ -1222,12 +1222,10 @@ static void nfs_writeback_done_full(stru
 			ClearPageUptodate(page);
 			SetPageError(page);
 			req->wb_context->error = task->tk_status;
-			end_page_writeback(page);
 			nfs_inode_remove_request(req);
 			dprintk(", error = %d\n", task->tk_status);
 			goto next;
 		}
-		end_page_writeback(page);
 
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 		if (data->args.stable != NFS_UNSTABLE || data->verf.committed == NFS_FILE_SYNC) {
@@ -1242,6 +1240,7 @@ static void nfs_writeback_done_full(stru
 		nfs_inode_remove_request(req);
 #endif
 	next:
+		end_page_writeback(page);
 		nfs_clear_page_writeback(req);
 	}
 }


