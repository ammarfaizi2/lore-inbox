Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWFZXcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWFZXcf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWFZXcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:32:11 -0400
Received: from dh134.citi.umich.edu ([141.211.133.134]:28830 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S1030234AbWFZXcH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:32:07 -0400
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: [PATCH 2/2] NFS: missing set_page_writeback()/end_page_writeback() in nfs_cancel_requests
Date: Mon, 26 Jun 2006 19:32:07 -0400
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20060626233206.6228.95805.stgit@lade.trondhjem.org>
In-Reply-To: <20060626233204.6228.86324.stgit@lade.trondhjem.org>
References: <20060626233204.6228.86324.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/write.c |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index d054f12..fe3eb36 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -579,7 +579,23 @@ static int nfs_wait_on_requests(struct i
 	return ret;
 }
 
-static void nfs_cancel_requests(struct list_head *head)
+static void nfs_cancel_dirty_list(struct list_head *head)
+{
+	struct nfs_page *req;
+	while(!list_empty(head)) {
+		req = nfs_list_entry(head->next);
+		nfs_list_remove_request(req);
+		/* Hack, cough, splutter!
+		 * Wretched borken mm requires us to do this...
+		 */
+		set_page_writeback(req->wb_page);
+		end_page_writeback(req->wb_page);
+		nfs_inode_remove_request(req);
+		nfs_clear_page_writeback(req);
+	}
+}
+
+static void nfs_cancel_commit_list(struct list_head *head)
 {
 	struct nfs_page *req;
 	while(!list_empty(head)) {
@@ -1503,7 +1519,7 @@ int nfs_sync_inode_wait(struct inode *in
 		if (pages != 0) {
 			spin_unlock(&nfsi->req_lock);
 			if (how & FLUSH_INVALIDATE)
-				nfs_cancel_requests(&head);
+				nfs_cancel_dirty_list(&head);
 			else
 				ret = nfs_flush_list(inode, &head, pages, how);
 			spin_lock(&nfsi->req_lock);
@@ -1516,7 +1532,7 @@ int nfs_sync_inode_wait(struct inode *in
 			break;
 		if (how & FLUSH_INVALIDATE) {
 			spin_unlock(&nfsi->req_lock);
-			nfs_cancel_requests(&head);
+			nfs_cancel_commit_list(&head);
 			spin_lock(&nfsi->req_lock);
 			continue;
 		}
