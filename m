Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946246AbWJSRGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946246AbWJSRGK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946244AbWJSRGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:06:09 -0400
Received: from mx2.netapp.com ([216.240.18.37]:6061 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1946238AbWJSRGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:06:07 -0400
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="419607066:sNHT15526384"
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Thu, 19 Oct 2006 13:04:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20061019170432.8171.446.stgit@lade.trondhjem.org>
In-Reply-To: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
References: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Subject: [PATCH 03/11] NFS: Fix error handling in nfs_direct_write_result()
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 19 Oct 2006 17:06:23.0817 (UTC) FILETIME=[E7EF3B90:01C6F3A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

If the RPC call tanked, we should not be checking the return value
of data->res.verf->committed, since it is unlikely to even be
initialised.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/direct.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 9f7f8b9..1e873fc 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -532,10 +532,12 @@ static void nfs_direct_write_result(stru
 
 	spin_lock(&dreq->lock);
 
-	if (likely(status >= 0))
-		dreq->count += data->res.count;
-	else
-		dreq->error = task->tk_status;
+	if (unlikely(status < 0)) {
+		dreq->error = status;
+		goto out_unlock;
+	}
+
+	dreq->count += data->res.count;
 
 	if (data->res.verf->committed != NFS_FILE_SYNC) {
 		switch (dreq->flags) {
@@ -550,7 +552,7 @@ static void nfs_direct_write_result(stru
 				}
 		}
 	}
-
+out_unlock:
 	spin_unlock(&dreq->lock);
 }
 
