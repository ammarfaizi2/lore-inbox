Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161488AbWAMPYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161488AbWAMPYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161548AbWAMPYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:24:46 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:52135 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161488AbWAMPY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:24:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=UA08+FCSHMtQ78mDljEhIBKUiljdCbFTId2pTFNQz8Rp0tuB0c3AA/LZ0PNkr97TF8OGz8GtSrnyrpHVGAGGiJmi+R68Fbyv3m/J335ceHgp16l4kqZ9i6U6LcpBxbmir54DQ8srjnzZKqkgd+CIZxp6ksD8QCDWWjRBT4VdREY=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/8] block: convert block/rd.c to use blk_kmap helpers
In-Reply-To: <11371658562541-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sat, 14 Jan 2006 00:24:17 +0900
Message-Id: <11371658574014-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, bzolnier@gmail.com, rmk@arm.linux.org.uk,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert block/rd.c to use blk_kmap/unmap helpers.  rd already had all
needed cache flushes, so this patch doesn't change its functionality.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/block/rd.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

f09db99a6eb5be8a6a793c3a73e1457bfa61c928
diff --git a/drivers/block/rd.c b/drivers/block/rd.c
index ffd6abd..d0ff693 100644
--- a/drivers/block/rd.c
+++ b/drivers/block/rd.c
@@ -232,9 +232,11 @@ static int rd_blkdev_pagecache_IO(int rw
 
 		if (rw == READ) {
 			src = kmap_atomic(page, KM_USER0) + offset;
-			dst = kmap_atomic(vec->bv_page, KM_USER1) + vec_offset;
+			dst = blk_kmap_atomic(vec->bv_page, KM_USER1,
+					      DMA_FROM_DEVICE) + vec_offset;
 		} else {
-			src = kmap_atomic(vec->bv_page, KM_USER0) + vec_offset;
+			src = blk_kmap_atomic(vec->bv_page, KM_USER0,
+					      DMA_TO_DEVICE) + vec_offset;
 			dst = kmap_atomic(page, KM_USER1) + offset;
 		}
 		offset = 0;
@@ -242,13 +244,14 @@ static int rd_blkdev_pagecache_IO(int rw
 
 		memcpy(dst, src, count);
 
-		kunmap_atomic(src, KM_USER0);
-		kunmap_atomic(dst, KM_USER1);
-
-		if (rw == READ)
-			flush_dcache_page(vec->bv_page);
-		else
+		if (rw == READ) {
+			kunmap_atomic(src, KM_USER0);
+			blk_kunmap_atomic(dst, KM_USER1, DMA_FROM_DEVICE);
+		} else {
+			blk_kunmap_atomic(src, KM_USER0, DMA_TO_DEVICE);
+			kunmap_atomic(dst, KM_USER1);
 			set_page_dirty(page);
+		}
 		unlock_page(page);
 		put_page(page);
 	} while (size);
-- 
1.0.6


