Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261480AbTCYGjg>; Tue, 25 Mar 2003 01:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261482AbTCYGjg>; Tue, 25 Mar 2003 01:39:36 -0500
Received: from krynn.axis.se ([193.13.178.10]:2714 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S261480AbTCYGja>;
	Tue, 25 Mar 2003 01:39:30 -0500
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE923@mailse01.se.axis.com>
From: Mikael Starvik <mikael.starvik@axis.com>
To: "'davej@codemonkey.org.uk'" <davej@codemonkey.org.uk>,
       "'torvalds@transmeta.com'" <torvalds@transmeta.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Add missing time initialisation to get_cramfs_inode
Date: Tue, 25 Mar 2003 07:50:29 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have tried to push a patch similar to yours for quite some time without
any success.

diff -Nurp linux-2.5/fs/cramfs/inode.c linux-2.5-local/fs/cramfs/inode.c
--- linux-2.5/fs/cramfs/inode.c	Tue Mar 25 07:43:00 2003
+++ linux-2.5-local/fs/cramfs/inode.c	Tue Mar 25 07:44:32 2003
@@ -52,6 +52,10 @@ static struct inode *get_cramfs_inode(st
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_gid = cramfs_inode->gid;
 		inode->i_ino = CRAMINO(cramfs_inode);
+		inode->i_mtime.tv_sec = ((struct cramfs_sb_info*)sb->s_fs_info)->fstime;
+		inode->i_mtime.tv_nsec = 0;
+		inode->i_ctime.tv_sec = ((struct cramfs_sb_info*)sb->s_fs_info)->fstime;
+		inode->i_ctime.tv_nsec = 0;
 		/* inode->i_nlink is left 1 - arguably wrong for directories,
 		   but it's the best we can do without reading the directory
 	           contents.  1 yields the right result in GNU find, even
@@ -135,7 +139,7 @@ static void *cramfs_read(struct super_bl
 		return read_buffers[i] + blk_offset;
 	}
 
-	devsize = sb->s_bdev->bd_inode->i_size >> 12;
+	devsize = sb->s_bdev->bd_inode->i_size >> PAGE_CACHE_SHIFT;
 	if (!devsize)
 		devsize = ~0UL;
 
@@ -232,10 +236,13 @@ static int cramfs_fill_super(struct supe
 		goto out;
 	}
 	root_offset = super.root.offset << 2;
+	sbi->fstime = 0;
 	if (super.flags & CRAMFS_FLAG_FSID_VERSION_2) {
 		sbi->size=super.size;
 		sbi->blocks=super.fsid.blocks;
 		sbi->files=super.fsid.files;
+		if (super.flags & CRAMFS_FLAG_EDITION_TIMESTAMP)
+			sbi->fstime=super.fsid.edition;
 	} else {
 		sbi->size=1<<28;
 		sbi->blocks=0;
diff -Nurp linux-2.5/include/linux/cramfs_fs.h linux-2.5-local/include/linux/cramfs_fs.h
--- linux-2.5/include/linux/cramfs_fs.h	Tue Mar 25 07:43:13 2003
+++ linux-2.5-local/include/linux/cramfs_fs.h	Mon Nov 18 08:29:53 2002
@@ -76,6 +76,7 @@ struct cramfs_super {
  */
 #define CRAMFS_FLAG_FSID_VERSION_2	0x00000001	/* fsid version #2 */
 #define CRAMFS_FLAG_SORTED_DIRS	0x00000002	/* sorted dirs */
+#define CRAMFS_FLAG_EDITION_TIMESTAMP	0x00000004	/* fstime in edition */
 #define CRAMFS_FLAG_HOLES		0x00000100	/* support for holes */
 #define CRAMFS_FLAG_WRONG_SIGNATURE	0x00000200	/* reserved */
 #define CRAMFS_FLAG_SHIFTED_ROOT_OFFSET	0x00000400	/* shifted root fs */
diff -Nurp linux-2.5/include/linux/cramfs_fs_sb.h linux-2.5-local/include/linux/cramfs_fs_sb.h
--- linux-2.5/include/linux/cramfs_fs_sb.h	Tue Mar 25 07:43:16 2003
+++ linux-2.5-local/include/linux/cramfs_fs_sb.h	Mon Nov 18 08:30:05 2002
@@ -10,6 +10,7 @@ struct cramfs_sb_info {
 			unsigned long blocks;
 			unsigned long files;
 			unsigned long flags;
+			time_t        fstime; /* From the edition field if EDITION_TIMESTAMP */
 };
 
 static inline struct cramfs_sb_info *CRAMFS_SB(struct super_block *sb)

/Mikael

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of
davej@codemonkey.org.uk
Sent: Monday, March 24, 2003 5:42 PM
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Add missing time initialisation to get_cramfs_inode


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/cramfs/inode.c linux-2.5/fs/cramfs/inode.c
--- bk-linus/fs/cramfs/inode.c	2003-03-08 09:57:39.000000000 +0000
+++ linux-2.5/fs/cramfs/inode.c	2003-03-22 12:49:42.000000000 +0000
@@ -51,6 +51,7 @@ static struct inode *get_cramfs_inode(st
 		inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_gid = cramfs_inode->gid;
+		inode->i_mtime = inode->i_atime = inode->i_ctime = 0;
 		inode->i_ino = CRAMINO(cramfs_inode);
 		/* inode->i_nlink is left 1 - arguably wrong for directories,
 		   but it's the best we can do without reading the directory
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
