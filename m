Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbWH2Qv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWH2Qv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWH2QtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:49:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33949 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965119AbWH2QqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:46:11 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 09/19] BLOCK: Move __invalidate_device() to block_dev.c [try #5]
Date: Tue, 29 Aug 2006 17:46:08 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060829164608.15723.51702.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com>
References: <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com>
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
index 02acae1..8e96181 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1305,3 +1305,24 @@ void close_bdev_excl(struct block_device
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
