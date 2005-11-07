Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbVKGRh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbVKGRh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbVKGRh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:37:58 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:42505 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S965052AbVKGRh5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:37:57 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] fat: add the read/writepages()
References: <87hdaotlci.fsf@devron.myhome.or.jp>
	<87d5lctl5y.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Nov 2005 02:37:44 +0900
In-Reply-To: <87d5lctl5y.fsf@devron.myhome.or.jp> (OGAWA Hirofumi's message of "Tue, 08 Nov 2005 02:36:25 +0900")
Message-ID: <878xw0tl3r.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/inode.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff -puN fs/fat/inode.c~fat_read-writepages fs/fat/inode.c
--- linux-2.6.14/fs/fat/inode.c~fat_read-writepages	2005-11-07 03:58:49.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fat/inode.c	2005-11-07 03:58:49.000000000 +0900
@@ -18,6 +18,7 @@
 #include <linux/seq_file.h>
 #include <linux/msdos_fs.h>
 #include <linux/pagemap.h>
+#include <linux/mpage.h>
 #include <linux/buffer_head.h>
 #include <linux/mount.h>
 #include <linux/vfs.h>
@@ -90,9 +91,21 @@ static int fat_writepage(struct page *pa
 	return block_write_full_page(page, fat_get_block, wbc);
 }
 
+static int fat_writepages(struct address_space *mapping,
+			  struct writeback_control *wbc)
+{
+	return mpage_writepages(mapping, wbc, fat_get_block);
+}
+
 static int fat_readpage(struct file *file, struct page *page)
 {
-	return block_read_full_page(page, fat_get_block);
+	return mpage_readpage(page, fat_get_block);
+}
+
+static int fat_readpages(struct file *file, struct address_space *mapping,
+			 struct list_head *pages, unsigned nr_pages)
+{
+	return mpage_readpages(mapping, pages, nr_pages, fat_get_block);
 }
 
 static int fat_prepare_write(struct file *file, struct page *page,
@@ -122,7 +135,9 @@ static sector_t _fat_bmap(struct address
 
 static struct address_space_operations fat_aops = {
 	.readpage	= fat_readpage,
+	.readpages	= fat_readpages,
 	.writepage	= fat_writepage,
+	.writepages	= fat_writepages,
 	.sync_page	= block_sync_page,
 	.prepare_write	= fat_prepare_write,
 	.commit_write	= fat_commit_write,
_
