Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVDVHZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVDVHZl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 03:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVDVHZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 03:25:40 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:57734 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262006AbVDVHXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 03:23:53 -0400
Date: Fri, 22 Apr 2005 09:23:56 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/10] squashfs: add swabbing infrastructure
Message-ID: <20050422072355.GE10459@wohnheim.fh-wedel.de>
References: <20050420065500.GA24213@wohnheim.fh-wedel.de> <20050421010817.GB29755@wohnheim.fh-wedel.de> <20050421011045.GC29755@wohnheim.fh-wedel.de> <20050421011126.GD29755@wohnheim.fh-wedel.de> <20050422072037.GB10459@wohnheim.fh-wedel.de> <20050422072200.GC10459@wohnheim.fh-wedel.de> <20050422072251.GD10459@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050422072251.GD10459@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn

-- 
Correctness comes second.
Features come third.
Performance comes last.
Maintainability is needed for all of them.


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 fs/squashfs/inode.c            |   16 ++++++++++++++++
 include/linux/squashfs_fs_sb.h |    3 +++
 2 files changed, 19 insertions(+)

--- linux-2.6.12-rc3cow/fs/squashfs/inode.c~squashfs_cu8	2005-04-22 08:09:25.993528336 +0200
+++ linux-2.6.12-rc3cow/fs/squashfs/inode.c	2005-04-22 09:17:42.136819904 +0200
@@ -43,6 +43,16 @@
 #include <linux/vmalloc.h>
 #include "squashfs.h"
 
+
+#define SQUASHFS_SWAB(XX)					\
+u##XX squashfs_swab##XX(u##XX x)	{ return swab##XX(x); }	\
+u##XX squashfs_ident##XX(u##XX x)	{ return x; }
+
+SQUASHFS_SWAB(16)
+SQUASHFS_SWAB(32)
+SQUASHFS_SWAB(64)
+
+
 static void squashfs_put_super(struct super_block *);
 static int squashfs_statfs(struct super_block *, struct kstatfs *);
 static int squashfs_symlink_readpage(struct file *file, struct page *page);
@@ -862,6 +872,9 @@ static int squashfs_fill_super(struct su
 
 	/* Check it is a SQUASHFS superblock */
 	msBlk->swap = 0;
+	msBlk->swab16 = squashfs_ident16;
+	msBlk->swab32 = squashfs_ident32;
+	msBlk->swab64 = squashfs_ident64;
 	if ((s->s_magic = sBlk->s_magic) != SQUASHFS_MAGIC) {
 		if (sBlk->s_magic == SQUASHFS_MAGIC_SWAP) {
 			squashfs_super_block sblk;
@@ -872,6 +885,9 @@ static int squashfs_fill_super(struct su
 			SQUASHFS_SWAP_SUPER_BLOCK(&sblk, sBlk);
 			memcpy(sBlk, &sblk, sizeof(squashfs_super_block));
 			msBlk->swap = 1;
+			msBlk->swab16 = squashfs_swab16;
+			msBlk->swab32 = squashfs_swab32;
+			msBlk->swab64 = squashfs_swab64;
 		} else  {
 			SERROR("Can't find a SQUASHFS superblock on %s\n",
 							bdevname(s->s_bdev, b));
--- linux-2.6.12-rc3cow/include/linux/squashfs_fs_sb.h~squashfs_cu8	2005-04-22 07:13:33.526180840 +0200
+++ linux-2.6.12-rc3cow/include/linux/squashfs_fs_sb.h	2005-04-22 08:54:52.891976760 +0200
@@ -44,6 +44,9 @@ typedef struct squashfs_sb_info {
 	int			devblksize;
 	int			devblksize_log2;
 	int			swap;
+	u16			(*swab16)(u16);
+	u32			(*swab32)(u32);
+	u64			(*swab64)(u64);
 	squashfs_cache		*block_cache;
 	struct squashfs_fragment_cache	*fragment;
 	int			next_cache;
