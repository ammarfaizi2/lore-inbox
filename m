Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWA2PtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWA2PtT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 10:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWA2PtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 10:49:18 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:55055 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1751036AbWA2Ps5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 10:48:57 -0500
Message-Id: <200601291548.k0TFmqPF016948@devron.myhome.or.jp>
Subject: [PATCH 3/3] fat: Fix truncate() write ordering
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
From: hirofumi@mail.parknet.co.jp
Date: Mon, 30 Jan 2006 00:48:51 +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The truncate() should write the file size before writing the new EOF entry.
This patch fixes it.

This bug was pointed out by Machida Hiroyuki.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/file.c |   50 +++++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff -puN fs/fat/file.c~fat_truncate-sync-fix fs/fat/file.c
--- linux-2.6/fs/fat/file.c~fat_truncate-sync-fix	2006-01-12 21:53:06.000000000 +0900
+++ linux-2.6-hirofumi/fs/fat/file.c	2006-01-12 21:53:06.000000000 +0900
@@ -210,10 +210,30 @@ static int fat_free(struct inode *inode,
 	if (MSDOS_I(inode)->i_start == 0)
 		return 0;
 
-	/*
-	 * Write a new EOF, and get the remaining cluster chain for freeing.
-	 */
+	fat_cache_inval_inode(inode);
+
 	wait = IS_DIRSYNC(inode);
+	i_start = free_start = MSDOS_I(inode)->i_start;
+	i_logstart = MSDOS_I(inode)->i_logstart;
+
+	/* First, we write the new file size. */
+	if (!skip) {
+		MSDOS_I(inode)->i_start = 0;
+		MSDOS_I(inode)->i_logstart = 0;
+	}
+	MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
+	if (wait) {
+		err = fat_sync_inode(inode);
+		if (err) {
+			MSDOS_I(inode)->i_start = i_start;
+			MSDOS_I(inode)->i_logstart = i_logstart;
+			return err;
+		}
+	} else
+		mark_inode_dirty(inode);
+
+	/* Write a new EOF, and get the remaining cluster chain for freeing. */
 	if (skip) {
 		struct fat_entry fatent;
 		int ret, fclus, dclus;
@@ -244,35 +264,11 @@ static int fat_free(struct inode *inode,
 			return ret;
 
 		free_start = ret;
-		i_start = i_logstart = 0;
-		fat_cache_inval_inode(inode);
-	} else {
-		fat_cache_inval_inode(inode);
-
-		i_start = free_start = MSDOS_I(inode)->i_start;
-		i_logstart = MSDOS_I(inode)->i_logstart;
-		MSDOS_I(inode)->i_start = 0;
-		MSDOS_I(inode)->i_logstart = 0;
 	}
-	MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
-	if (wait) {
-		err = fat_sync_inode(inode);
-		if (err)
-			goto error;
-	} else
-		mark_inode_dirty(inode);
 	inode->i_blocks = skip << (MSDOS_SB(sb)->cluster_bits - 9);
 
 	/* Freeing the remained cluster chain */
 	return fat_free_clusters(inode, free_start);
-
-error:
-	if (i_start) {
-		MSDOS_I(inode)->i_start = i_start;
-		MSDOS_I(inode)->i_logstart = i_logstart;
-	}
-	return err;
 }
 
 void fat_truncate(struct inode *inode)
_
