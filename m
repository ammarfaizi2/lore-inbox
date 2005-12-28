Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVL1M6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVL1M6D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 07:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVL1M6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 07:58:02 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:17677 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S964800AbVL1M6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 07:58:00 -0500
To: junjie cai <junjiec@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][fat] use mpage_readpage when cluster size is page-alignment
References: <ca992f110512272356l379dccc5k6288c28411ff7af4@mail.gmail.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 28 Dec 2005 21:57:44 +0900
In-Reply-To: <ca992f110512272356l379dccc5k6288c28411ff7af4@mail.gmail.com> (junjie cai's message of "Wed, 28 Dec 2005 16:56:55 +0900")
Message-ID: <87u0ctwf93.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

junjie cai <junjiec@gmail.com> writes:

> it seems that mpage_read is faster then block_read_full_page
> when performing block-adjacent I/O.
> though not tested strictly, in a flash-based system,
> copying a 600k file reduced to 17ms from 30ms

Looks like good to me. Thanks for doing this.

I changed it recently, and it's waiting to open 2.6.16 in -mm tree.
The patch (fat-add-the-read-writepages.patch) is the following, but it
is using mpage_readpage() always. (also use mpage_xxxpages().)

Can't we use mpage_readpage() always? IIRC, that should work fine
without disadvantage.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/fat/inode.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletion(-)

diff -puN fs/fat/inode.c~fat-add-the-read-writepages fs/fat/inode.c
--- 25/fs/fat/inode.c~fat-add-the-read-writepages	Mon Nov  7 17:02:07 2005
+++ 25-akpm/fs/fat/inode.c	Mon Nov  7 17:02:07 2005
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
