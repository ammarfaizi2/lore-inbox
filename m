Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWJLROl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWJLROl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWJLROf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:14:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35712 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751423AbWJLROO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:14:14 -0400
Subject: [PATCH 5/7] [GFS2] Pass the correct value to kunmap_atomic
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Russell Cattelan <cattelan@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 12 Oct 2006 18:19:24 +0100
Message-Id: <1160673564.11901.826.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From c312c4fdc88514dd9522b7858eb879e610aeb9b1 Mon Sep 17 00:00:00 2001
From: Russell Cattelan <cattelan@redhat.com>
Date: Thu, 12 Oct 2006 09:23:41 -0400
Subject: [GFS2] Pass the correct value to kunmap_atomic

Pass kaddr rather than (incorrect) struct page to kunmap_atomic.

Signed-off-by: Russell Cattelan <cattelan@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/lops.c        |    4 ++--
 fs/gfs2/ops_address.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 881e337..ab6d111 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -492,7 +492,7 @@ static int gfs2_check_magic(struct buffe
 	ptr = kaddr + bh_offset(bh);
 	if (*ptr == cpu_to_be32(GFS2_MAGIC))
 		rv = 1;
-	kunmap_atomic(page, KM_USER0);
+	kunmap_atomic(kaddr, KM_USER0);
 
 	return rv;
 }
@@ -626,7 +626,7 @@ static void databuf_lo_before_commit(str
 				memcpy(bh->b_data,
 				       kaddr + bh_offset(bd2->bd_bh),
 				       sdp->sd_sb.sb_bsize);
-				kunmap_atomic(page, KM_USER0);
+				kunmap_atomic(kaddr, KM_USER0);
 				*(__be32 *)bh->b_data = 0;
 			} else {
 				bh = gfs2_log_fake_buf(sdp, bd2->bd_bh);
diff --git a/fs/gfs2/ops_address.c b/fs/gfs2/ops_address.c
index 99c9337..e0599fe 100644
--- a/fs/gfs2/ops_address.c
+++ b/fs/gfs2/ops_address.c
@@ -162,7 +162,7 @@ static int zero_readpage(struct page *pa
 
 	kaddr = kmap_atomic(page, KM_USER0);
 	memset(kaddr, 0, PAGE_CACHE_SIZE);
-	kunmap_atomic(page, KM_USER0);
+	kunmap_atomic(kaddr, KM_USER0);
 
 	SetPageUptodate(page);
 
@@ -195,7 +195,7 @@ static int stuffed_readpage(struct gfs2_
 	memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode),
 	       ip->i_di.di_size);
 	memset(kaddr + ip->i_di.di_size, 0, PAGE_CACHE_SIZE - ip->i_di.di_size);
-	kunmap_atomic(page, KM_USER0);
+	kunmap_atomic(kaddr, KM_USER0);
 
 	brelse(dibh);
 
@@ -485,7 +485,7 @@ static int gfs2_commit_write(struct file
 		kaddr = kmap_atomic(page, KM_USER0);
 		memcpy(dibh->b_data + sizeof(struct gfs2_dinode) + from,
 		       kaddr + from, to - from);
-		kunmap_atomic(page, KM_USER0);
+		kunmap_atomic(kaddr, KM_USER0);
 
 		SetPageUptodate(page);
 
-- 
1.4.1



