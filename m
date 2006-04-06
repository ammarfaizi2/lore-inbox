Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWDFQTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWDFQTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWDFQTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 12:19:08 -0400
Received: from mail.parknet.jp ([210.171.160.80]:59659 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1750835AbWDFQTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 12:19:06 -0400
X-AuthUser: hirofumi@parknet.jp
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, reiserfs-dev@namesys.com
Subject: [PATCH 2/2] writeback: fix range handling
References: <877j62n0l7.fsf@duaron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 07 Apr 2006 01:18:59 +0900
In-Reply-To: <877j62n0l7.fsf@duaron.myhome.or.jp> (OGAWA Hirofumi's message of "Fri, 07 Apr 2006 01:13:56 +0900")
Message-ID: <873bgqn0cs.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

reiser4 doesn't check wbc->end, and perhaps it does not use cyclic
behavior. So, I guess this is ok.

Could you review this?
---

 fs/reiser4/entd.c             |    8 ++++----
 fs/reiser4/plugin/file/file.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff -puN fs/reiser4/entd.c~wbc-range-cleanup-reiser4 fs/reiser4/entd.c
--- linux-2.6-akpm/fs/reiser4/entd.c~wbc-range-cleanup-reiser4	2006-04-06 05:44:56.000000000 +0900
+++ linux-2.6-akpm-hirofumi/fs/reiser4/entd.c	2006-04-06 05:44:56.000000000 +0900
@@ -265,14 +265,14 @@ static void entd_flush(struct super_bloc
 	init_stack_context(&ctx, super);
 	ctx.entd = 1;
 
-	rq->wbc->start = rq->page->index << PAGE_CACHE_SHIFT;
-	rq->wbc->end = (rq->page->index + ENTD_CAPTURE_APAGE_BURST) << PAGE_CACHE_SHIFT;
+	rq->wbc->range_start = rq->page->index << PAGE_CACHE_SHIFT;
+	rq->wbc->range_end = (rq->page->index + ENTD_CAPTURE_APAGE_BURST) << PAGE_CACHE_SHIFT;
 	tmp = rq->wbc->nr_to_write;
 	rq->mapping->a_ops->writepages(rq->mapping, rq->wbc);
 
 	if (rq->wbc->nr_to_write > 0) {
-		rq->wbc->start = 0;
-		rq->wbc->end = 0;
+		rq->wbc->range_start = 0;
+		rq->wbc->range_end = LLONG_MAX;
 		generic_sync_sb_inodes(super, rq->wbc);
 	}
 	rq->wbc->nr_to_write = ENTD_CAPTURE_APAGE_BURST;
diff -puN fs/reiser4/plugin/file/file.c~wbc-range-cleanup-reiser4 fs/reiser4/plugin/file/file.c
--- linux-2.6-akpm/fs/reiser4/plugin/file/file.c~wbc-range-cleanup-reiser4	2006-04-06 05:44:56.000000000 +0900
+++ linux-2.6-akpm-hirofumi/fs/reiser4/plugin/file/file.c	2006-04-06 05:44:56.000000000 +0900
@@ -1550,7 +1550,7 @@ writepages_unix_file(struct address_spac
 		result = 0;
 		goto end;
 	}
-	jindex = pindex = wbc->start >> PAGE_CACHE_SHIFT;
+	jindex = pindex = wbc->range_start >> PAGE_CACHE_SHIFT;
 	result = 0;
 	nr_pages =
 	    (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
_
