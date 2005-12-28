Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbVL1H45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVL1H45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 02:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbVL1H45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 02:56:57 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:61520 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932500AbVL1H44 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 02:56:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OJ1Sv3cDClaiDQWgoPsWeGd4Uh1bKioyazPBfaH8DCBjajyM4JPV6gpmDN1OxcfJErE4V6jQem1Yipg37kmf00wEbL9mMBPZOcXw7FERLVtvdmJNh22MqNyowafuS3s/Oho+rJ5xDjx7j6KklCNTQm4QBhM2ENcgd9fQlrytgIQ=
Message-ID: <ca992f110512272356l379dccc5k6288c28411ff7af4@mail.gmail.com>
Date: Wed, 28 Dec 2005 16:56:55 +0900
From: junjie cai <junjiec@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC][fat] use mpage_readpage when cluster size is page-alignment
Cc: junjie cai <junjiec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

it seems that mpage_read is faster then block_read_full_page
when performing block-adjacent I/O.
though not tested strictly, in a flash-based system,
copying a 600k file reduced to 17ms from 30ms

thanks.
                                             junjie

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index a0f9b9f..3d25a2b 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -22,6 +22,7 @@
 #include <linux/mount.h>
 #include <linux/vfs.h>
 #include <linux/parser.h>
+#include <linux/mpage.h>
 #include <asm/unaligned.h>

 #ifndef CONFIG_FAT_DEFAULT_IOCHARSET
@@ -95,6 +96,11 @@ static int fat_readpage(struct file *fil
 	return block_read_full_page(page, fat_get_block);
 }

+static int fat_mpage_readpage(struct file *file, struct page *page)
+{
+	return  mpage_readpage(page, fat_get_block);
+}
+
 static int fat_prepare_write(struct file *file, struct page *page,
 			     unsigned from, unsigned to)
 {
@@ -130,6 +136,18 @@ static struct address_space_operations f
 };

 /*
+ * for page-alignemnt cluster-size
+ */
+static struct address_space_operations fat_mpage_aops = {
+	.readpage	= fat_mpage_readpage,
+	.writepage	= fat_writepage,
+	.sync_page	= block_sync_page,
+	.prepare_write	= fat_prepare_write,
+	.commit_write	= fat_commit_write,
+	.bmap		= _fat_bmap
+};
+
+/*
  * New FAT inode stuff. We do the following:
  *	a) i_ino is constant and has nothing with on-disk location.
  *	b) FAT manages its own cache of directory entries.
@@ -288,7 +306,12 @@ static int fat_fill_inode(struct inode *
 		inode->i_size = le32_to_cpu(de->size);
 		inode->i_op = &fat_file_inode_operations;
 		inode->i_fop = &fat_file_operations;
-		inode->i_mapping->a_ops = &fat_aops;
+
+		if (sbi->cluster_size & ~PAGE_MASK)
+			inode->i_mapping->a_ops = &fat_aops;
+		else
+			inode->i_mapping->a_ops = &fat_mpage_aops;
+
 		MSDOS_I(inode)->mmu_private = inode->i_size;
 	}
 	if (de->attr & ATTR_SYS) {
