Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWFZXcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWFZXcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWFZXcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:32:09 -0400
Received: from dh134.citi.umich.edu ([141.211.133.134]:28062 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S1030203AbWFZXcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:32:05 -0400
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: [PATCH 1/2] NFS: Fix NFS page_state usage
Date: Mon, 26 Jun 2006 19:32:04 -0400
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20060626233204.6228.86324.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

The introduction of the FLUSH_INVALIDATE argument to nfs_sync_inode_wait()
can cause the nr_unstable page state counter to be corrupted. Fix by
moving the call to sub_page_state() to inside nfs_scan_commit().

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/write.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index b383fdd..d054f12 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -636,6 +636,7 @@ nfs_scan_commit(struct inode *inode, str
 	if (nfsi->ncommit != 0) {
 		res = nfs_scan_list(nfsi, &nfsi->commit, dst, idx_start, npages);
 		nfsi->ncommit -= res;
+		sub_page_state(nr_unstable,res);
 		if ((nfsi->ncommit == 0) != list_empty(&nfsi->commit))
 			printk(KERN_ERR "NFS: desynchronized value of nfs_i.ncommit.\n");
 	}
@@ -1434,7 +1435,6 @@ static void nfs_commit_done(struct rpc_t
 		nfs_clear_page_writeback(req);
 		res++;
 	}
-	sub_page_state(nr_unstable,res);
 }
 
 static const struct rpc_call_ops nfs_commit_ops = {
