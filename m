Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946241AbWJSRGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946241AbWJSRGg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946237AbWJSRGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:06:17 -0400
Received: from mx2.netapp.com ([216.240.18.37]:6061 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1946241AbWJSRGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:06:09 -0400
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="419607092:sNHT19493700"
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Thu, 19 Oct 2006 13:04:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20061019170432.8171.49033.stgit@lade.trondhjem.org>
In-Reply-To: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
References: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Subject: [PATCH 07/11] NFS: fix minor bug in new NFS symlink code
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 19 Oct 2006 17:06:27.0317 (UTC) FILETIME=[EA054A50:01C6F3A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The original code confused a zero return code from pagevec_add() as
success.

Test plan:
None.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/dir.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 58d4405..c86a1ea 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1519,8 +1519,8 @@ static int nfs_symlink(struct inode *dir
 	pagevec_init(&lru_pvec, 0);
 	if (!add_to_page_cache(page, dentry->d_inode->i_mapping, 0,
 							GFP_KERNEL)) {
-		if (!pagevec_add(&lru_pvec, page))
-			__pagevec_lru_add(&lru_pvec);
+		pagevec_add(&lru_pvec, page);
+		pagevec_lru_add(&lru_pvec);
 		SetPageUptodate(page);
 		unlock_page(page);
 	} else
