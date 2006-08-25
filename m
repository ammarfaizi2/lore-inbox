Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422874AbWHYTld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422874AbWHYTld (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422853AbWHYTjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:39:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37775 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422840AbWHYThV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:37:21 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 09/18] [PATCH] BLOCK: Move __invalidate_device() to block_dev.c [try #4]
Date: Fri, 25 Aug 2006 20:37:18 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060825193718.11384.92765.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com>
References: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Move __invalidate_device() from fs/inode.c to fs/block_dev.c so that it can
more easily be disabled when the block layer is disabled.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/block_dev.c |   21 +++++++++++++++++++++
 fs/inode.c     |   21 ---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6e24cd4..f2c3637 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1307,3 +1307,24 @@ void close_bdev_excl(struct block_device
 }
 
 EXPORT_SYMBOL(close_bdev_excl);
+
+int __invalidate_device(struct block_device *bdev)
+{
+	struct super_block *sb = get_super(bdev);
+	int res = 0;
+
+	if (sb) {
+		/*
+		 * no need to lock the super, get_super holds the
+		 * read mutex so the filesystem cannot go away
+		 * under us (->put_super runs with the write lock
+		 * hold).
+		 */
+		shrink_dcache_sb(sb);
+		res = invalidate_inodes(sb);
+		drop_super(sb);
+	}
+	invalidate_bdev(bdev, 0);
+	return res;
+}
+EXPORT_SYMBOL(__invalidate_device);
diff --git a/fs/inode.c b/fs/inode.c
index 0bf9f04..6426bb0 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -363,27 +363,6 @@ int invalidate_inodes(struct super_block
 }
 
 EXPORT_SYMBOL(invalidate_inodes);
- 
-int __invalidate_device(struct block_device *bdev)
-{
-	struct super_block *sb = get_super(bdev);
-	int res = 0;
-
-	if (sb) {
-		/*
-		 * no need to lock the super, get_super holds the
-		 * read mutex so the filesystem cannot go away
-		 * under us (->put_super runs with the write lock
-		 * hold).
-		 */
-		shrink_dcache_sb(sb);
-		res = invalidate_inodes(sb);
-		drop_super(sb);
-	}
-	invalidate_bdev(bdev, 0);
-	return res;
-}
-EXPORT_SYMBOL(__invalidate_device);
 
 static int can_unuse(struct inode *inode)
 {
