Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936331AbWK3MTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936331AbWK3MTL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936322AbWK3MSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:18:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17547 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936314AbWK3MSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:18:38 -0500
Subject: [GFS2] Remove unused zero_readpage from stuffed_readpage [37/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Russell Cattelan <cattelan@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:18:57 +0000
Message-Id: <1164889137.3752.378.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 61057c6bb3a3d14cf2bea6ca20dc6d367e1d852e Mon Sep 17 00:00:00 2001
From: Russell Cattelan <cattelan@redhat.com>
Date: Thu, 9 Nov 2006 11:42:33 -0500
Subject: [PATCH] [GFS2] Remove unused zero_readpage from stuffed_readpage

Stuffed files only consist of a maximum of
(gfs2 block size - sizeof(struct gfs2_dinode)) bytes. Since the
gfs2 block size is always less than page size, we will never see
a call to stuffed_readpage for anything other than the first page
in the file.

Signed-off-by: Russell Cattelan <cattelan@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/ops_address.c |   20 ++++----------------
 1 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/ops_address.c b/fs/gfs2/ops_address.c
index 3822189..2f7ef98 100644
--- a/fs/gfs2/ops_address.c
+++ b/fs/gfs2/ops_address.c
@@ -156,19 +156,6 @@ out_ignore:
 	return 0;
 }
 
-static int zero_readpage(struct page *page)
-{
-	void *kaddr;
-
-	kaddr = kmap_atomic(page, KM_USER0);
-	memset(kaddr, 0, PAGE_CACHE_SIZE);
-	kunmap_atomic(kaddr, KM_USER0);
-
-	SetPageUptodate(page);
-
-	return 0;
-}
-
 /**
  * stuffed_readpage - Fill in a Linux page with stuffed file data
  * @ip: the inode
@@ -183,9 +170,7 @@ static int stuffed_readpage(struct gfs2_
 	void *kaddr;
 	int error;
 
-	/* Only the first page of a stuffed file might contain data */
-	if (unlikely(page->index))
-		return zero_readpage(page);
+	BUG_ON(page->index);
 
 	error = gfs2_meta_inode_buffer(ip, &dibh);
 	if (error)
@@ -737,6 +722,9 @@ int gfs2_releasepage(struct page *page, 
 			if (!atomic_read(&aspace->i_writecount))
 				return 0;
 
+			if (!(gfp_mask & __GFP_WAIT))
+				return 0;
+
 			if (time_after_eq(jiffies, t)) {
 				stuck_releasepage(bh);
 				/* should we withdraw here? */
-- 
1.4.1



