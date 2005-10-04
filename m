Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbVJDQnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbVJDQnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVJDQnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:43:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59303 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964848AbVJDQnH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:43:07 -0400
Date: Tue, 4 Oct 2005 17:43:06 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] bfs endianness annotations
Message-ID: <20051004164306.GG7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Author: Alexey Dobriyan <adobriyan@gmail.com>

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
[Note: there's a followup to that one, cleaning up iget() abuses in bfs/inode]

 fs/bfs/dir.c           |    2 +-
 fs/bfs/inode.c         |    2 +-
 include/linux/bfs_fs.h |   42 +++++++++++++++++++++---------------------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -108,7 +108,7 @@ static int bfs_create(struct inode * dir
 	inode->i_mapping->a_ops = &bfs_aops;
 	inode->i_mode = mode;
 	inode->i_ino = ino;
-	BFS_I(inode)->i_dsk_ino = cpu_to_le16(ino);
+	BFS_I(inode)->i_dsk_ino = ino;
 	BFS_I(inode)->i_sblock = 0;
 	BFS_I(inode)->i_eblock = 0;
 	insert_inode_hash(inode);
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -357,7 +357,7 @@ static int bfs_fill_super(struct super_b
 	}
 
 	info->si_blocks = (le32_to_cpu(bfs_sb->s_end) + 1)>>BFS_BSIZE_BITS; /* for statfs(2) */
-	info->si_freeb = (le32_to_cpu(bfs_sb->s_end) + 1 -  cpu_to_le32(bfs_sb->s_start))>>BFS_BSIZE_BITS;
+	info->si_freeb = (le32_to_cpu(bfs_sb->s_end) + 1 -  le32_to_cpu(bfs_sb->s_start))>>BFS_BSIZE_BITS;
 	info->si_freei = 0;
 	info->si_lf_eblk = 0;
 	info->si_lf_sblk = 0;
diff --git a/include/linux/bfs_fs.h b/include/linux/bfs_fs.h
--- a/include/linux/bfs_fs.h
+++ b/include/linux/bfs_fs.h
@@ -20,19 +20,19 @@
 
 /* BFS inode layout on disk */
 struct bfs_inode {
-	__u16 i_ino;
+	__le16 i_ino;
 	__u16 i_unused;
-	__u32 i_sblock;
-	__u32 i_eblock;
-	__u32 i_eoffset;
-	__u32 i_vtype;
-	__u32 i_mode;
-	__s32 i_uid;
-	__s32 i_gid;
-	__u32 i_nlink;
-	__u32 i_atime;
-	__u32 i_mtime;
-	__u32 i_ctime;
+	__le32 i_sblock;
+	__le32 i_eblock;
+	__le32 i_eoffset;
+	__le32 i_vtype;
+	__le32 i_mode;
+	__le32 i_uid;
+	__le32 i_gid;
+	__le32 i_nlink;
+	__le32 i_atime;
+	__le32 i_mtime;
+	__le32 i_ctime;
 	__u32 i_padding[4];
 };
 
@@ -41,17 +41,17 @@ struct bfs_inode {
 #define BFS_DIRS_PER_BLOCK	32
 
 struct bfs_dirent {
-	__u16 ino;
+	__le16 ino;
 	char name[BFS_NAMELEN];
 };
 
 /* BFS superblock layout on disk */
 struct bfs_super_block {
-	__u32 s_magic;
-	__u32 s_start;
-	__u32 s_end;
-	__s32 s_from;
-	__s32 s_to;
+	__le32 s_magic;
+	__le32 s_start;
+	__le32 s_end;
+	__le32 s_from;
+	__le32 s_to;
 	__s32 s_bfrom;
 	__s32 s_bto;
 	char  s_fsname[6];
@@ -66,15 +66,15 @@ struct bfs_super_block {
 #define BFS_INO2OFF(ino) \
 	((__u32)(((ino) - BFS_ROOT_INO) * sizeof(struct bfs_inode)) + BFS_BSIZE)
 #define BFS_NZFILESIZE(ip) \
-        ((cpu_to_le32((ip)->i_eoffset) + 1) -  cpu_to_le32((ip)->i_sblock) * BFS_BSIZE)
+        ((le32_to_cpu((ip)->i_eoffset) + 1) -  le32_to_cpu((ip)->i_sblock) * BFS_BSIZE)
 
 #define BFS_FILESIZE(ip) \
         ((ip)->i_sblock == 0 ? 0 : BFS_NZFILESIZE(ip))
 
 #define BFS_FILEBLOCKS(ip) \
-        ((ip)->i_sblock == 0 ? 0 : (cpu_to_le32((ip)->i_eblock) + 1) -  cpu_to_le32((ip)->i_sblock))
+        ((ip)->i_sblock == 0 ? 0 : (le32_to_cpu((ip)->i_eblock) + 1) -  le32_to_cpu((ip)->i_sblock))
 #define BFS_UNCLEAN(bfs_sb, sb)	\
-	((cpu_to_le32(bfs_sb->s_from) != -1) && (cpu_to_le32(bfs_sb->s_to) != -1) && !(sb->s_flags & MS_RDONLY))
+	((le32_to_cpu(bfs_sb->s_from) != -1) && (le32_to_cpu(bfs_sb->s_to) != -1) && !(sb->s_flags & MS_RDONLY))
 
 
 #endif	/* _LINUX_BFS_FS_H */

