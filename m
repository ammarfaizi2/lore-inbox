Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315947AbSEGTLy>; Tue, 7 May 2002 15:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315948AbSEGTLx>; Tue, 7 May 2002 15:11:53 -0400
Received: from imladris.infradead.org ([194.205.184.45]:33291 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315947AbSEGTLv>; Tue, 7 May 2002 15:11:51 -0400
Date: Tue, 7 May 2002 19:03:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][HACK] make romfs use private superblock
Message-ID: <20020507190325.A31863@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or actually no sb at all :)

--- 1.18/fs/romfs/inode.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/romfs/inode.c	Tue May  7 20:57:34 2002
@@ -82,6 +82,12 @@
 	struct inode vfs_inode;
 };
 
+/* instead of private superblock data */
+static inline unsigned long romfs_maxsize(struct super_block *sb)
+{
+	return (unsigned long)sb->u.generic_sbp;
+}
+
 static inline struct romfs_inode_info *ROMFS_I(struct inode *inode)
 {
 	return list_entry(inode, struct romfs_inode_info, vfs_inode);
@@ -138,7 +144,7 @@
 	}
 
 	s->s_magic = ROMFS_MAGIC;
-	s->u.romfs_sb.s_maxsize = sz;
+	s->u_generic_sbp = (void *)sz;
 
 	s->s_flags |= MS_RDONLY;
 
@@ -174,7 +180,7 @@
 	buf->f_type = ROMFS_MAGIC;
 	buf->f_bsize = ROMBSIZE;
 	buf->f_bfree = buf->f_bavail = buf->f_ffree;
-	buf->f_blocks = (sb->u.romfs_sb.s_maxsize+ROMBSIZE-1)>>ROMBSBITS;
+	buf->f_blocks = (romfs_maxsize(sb)+ROMBSIZE-1)>>ROMBSBITS;
 	buf->f_namelen = ROMFS_MAXFN;
 	return 0;
 }
@@ -187,7 +193,7 @@
 	struct buffer_head *bh;
 	unsigned long avail, maxsize, res;
 
-	maxsize = i->i_sb->u.romfs_sb.s_maxsize;
+	maxsize = romfs_maxsize(i->i_sb);
 	if (offset >= maxsize)
 		return -1;
 
@@ -229,7 +235,7 @@
 	struct buffer_head *bh;
 	unsigned long avail, maxsize, res;
 
-	maxsize = i->i_sb->u.romfs_sb.s_maxsize;
+	maxsize = romfs_maxsize(i->i_sb);
 	if (offset >= maxsize || count > maxsize || offset+count>maxsize)
 		return -1;
 
@@ -275,7 +281,7 @@
 
 	lock_kernel();
 	
-	maxoff = i->i_sb->u.romfs_sb.s_maxsize;
+	maxoff = romfs_maxsize(i->i_sb);
 
 	offset = filp->f_pos;
 	if (!offset) {
@@ -338,7 +344,7 @@
 	if (romfs_copyfrom(dir, &ri, offset, ROMFH_SIZE) <= 0)
 		goto out;
 
-	maxoff = dir->i_sb->u.romfs_sb.s_maxsize;
+	maxoff = romfs_maxsize(dir->i_sb);
 	offset = ntohl(ri.spec) & ROMFH_MASK;
 
 	/* OK, now find the file whose name is in "dentry" in the
===== include/linux/fs.h 1.108 vs edited =====
--- 1.108/include/linux/fs.h	Tue Apr 30 22:58:45 2002
+++ edited/include/linux/fs.h	Tue May  7 20:52:05 2002
@@ -607,7 +607,6 @@
 #include <linux/ext3_fs_sb.h>
 #include <linux/hpfs_fs_sb.h>
 #include <linux/ufs_fs_sb.h>
-#include <linux/romfs_fs_sb.h>
 #include <linux/adfs_fs_sb.h>
 
 extern struct list_head super_blocks;
@@ -651,7 +650,6 @@
 		struct ext3_sb_info	ext3_sb;
 		struct hpfs_sb_info	hpfs_sb;
 		struct ufs_sb_info	ufs_sb;
-		struct romfs_sb_info	romfs_sb;
 		struct adfs_sb_info	adfs_sb;
 		void			*generic_sbp;
 	} u;
--- include/linux/romfs_fs_sb.h	Tue May  7 20:58:57 2002
+++ /dev/null	Thu Dec 13 11:34:58 2001
@@ -1,10 +0,0 @@
-#ifndef __ROMFS_FS_SB
-#define __ROMFS_FS_SB
-
-/* romfs superblock in-core data */
-
-struct romfs_sb_info {
-	unsigned long s_maxsize;
-};
-
-#endif

