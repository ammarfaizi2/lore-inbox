Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946249AbWJSRHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946249AbWJSRHt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946239AbWJSRGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:06:12 -0400
Received: from mx2.netapp.com ([216.240.18.37]:6061 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1946240AbWJSRGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:06:08 -0400
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="419607081:sNHT77186228"
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Thu, 19 Oct 2006 13:04:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20061019170432.8171.94121.stgit@lade.trondhjem.org>
In-Reply-To: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
References: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Subject: [PATCH 02/11] NFS: Fix oops in nfs_cancel_commit_list
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 19 Oct 2006 17:06:26.0660 (UTC) FILETIME=[E9A10A40:01C6F3A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

Fix two bugs:
 - nfs_inode_remove_request will call nfs_clear_request, so we cannot
   reference req->wb_page after it. Move the call to dec_zone_page_state so
   that it occurs while req->wb_page is still valid.
 - Calling nfs_clear_page_writeback is unnecessary since the radix tree
   tags will have been cleared by the call to nfs_inode_remove_request.
   Replace with a simple call to nfs_unlock_request.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/write.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index f6675d2..d80fa8c 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -588,10 +588,10 @@ static void nfs_cancel_commit_list(struc
 
 	while(!list_empty(head)) {
 		req = nfs_list_entry(head->next);
+		dec_zone_page_state(req->wb_page, NR_UNSTABLE_NFS);
 		nfs_list_remove_request(req);
 		nfs_inode_remove_request(req);
-		dec_zone_page_state(req->wb_page, NR_UNSTABLE_NFS);
-		nfs_clear_page_writeback(req);
+		nfs_unlock_request(req);
 	}
 }
 
