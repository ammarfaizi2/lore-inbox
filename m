Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSD2MBS>; Mon, 29 Apr 2002 08:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315124AbSD2MBS>; Mon, 29 Apr 2002 08:01:18 -0400
Received: from krynn.axis.se ([193.13.178.10]:36744 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S315120AbSD2MBQ>;
	Mon, 29 Apr 2002 08:01:16 -0400
Date: Mon, 29 Apr 2002 13:57:00 +0200 (CEST)
From: Johan Adolfsson <johan.adolfsson@axis.com>
X-X-Sender: <johana@ado-2.axis.se>
To: <quinlan@transmeta.com>, <marcelo@conectiva.com.br>,
        <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] cramfs 2/6 - timestamp and blocksize in inode.c 
Message-ID: <Pine.LNX.4.33.0204291355080.25892-100000@ado-2.axis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2. Support for fstime in fs/cramfs/inode.c together with
   fixing hardcoded blocksize conversion
   (Now uses /(PAGE_CACHE_SIZE/1024) instead of >> 2).

Please apply
/Johan

--- linux-2.4.19-pre7/fs/cramfs/inode.c	Tue Apr 23 15:18:36 2002
+++ linux/fs/cramfs/inode.c	Mon Apr 29 13:05:00 2002
@@ -28,6 +28,7 @@
 #define CRAMFS_SB_BLOCKS u.cramfs_sb.blocks
 #define CRAMFS_SB_FILES u.cramfs_sb.files
 #define CRAMFS_SB_FLAGS u.cramfs_sb.flags
+#define CRAMFS_SB_FSTIME u.cramfs_sb.fstime

 static struct super_operations cramfs_ops;
 static struct inode_operations cramfs_dir_inode_operations;
@@ -54,6 +55,8 @@
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_gid = cramfs_inode->gid;
 		inode->i_ino = CRAMINO(cramfs_inode);
+		inode->i_mtime = sb->CRAMFS_SB_FSTIME;
+		inode->i_ctime = sb->CRAMFS_SB_FSTIME;
 		/* inode->i_nlink is left 1 - arguably wrong for directories,
 		   but it's the best we can do without reading the directory
 	           contents.  1 yields the right result in GNU find, even
@@ -144,7 +147,7 @@
 	minor = MINOR(sb->s_dev);

 	if (blk_size[major])
-		devsize = blk_size[major][minor] >> 2;
+		devsize = blk_size[major][minor] / (PAGE_CACHE_SIZE / 1024);

 	/* Ok, read in BLKS_PER_BUF pages completely first. */
 	unread = 0;
@@ -230,10 +233,13 @@
 		goto out;
 	}
 	root_offset = super.root.offset << 2;
+	sb->CRAMFS_SB_FSTIME = 0;
 	if (super.flags & CRAMFS_FLAG_FSID_VERSION_2) {
 		sb->CRAMFS_SB_SIZE=super.size;
 		sb->CRAMFS_SB_BLOCKS=super.fsid.blocks;
 		sb->CRAMFS_SB_FILES=super.fsid.files;
+		if (super.flags & CRAMFS_FLAG_EDITION_TIMESTAMP)
+			sb->CRAMFS_SB_FSTIME=super.fsid.edition;
 	} else {
 		sb->CRAMFS_SB_SIZE=1<<28;
 		sb->CRAMFS_SB_BLOCKS=0;

