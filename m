Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313277AbSC1W4m>; Thu, 28 Mar 2002 17:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313279AbSC1W40>; Thu, 28 Mar 2002 17:56:26 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:2477 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S313277AbSC1W4L>; Thu, 28 Mar 2002 17:56:11 -0500
Message-ID: <3CA39F50.7050108@didntduck.org>
Date: Thu, 28 Mar 2002 17:55:12 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Subject: [PATCH] struct super_block cleanup - romfs
Content-Type: multipart/mixed;
 boundary="------------040901090402060904030103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040901090402060904030103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Kills romfs_sb_info by moving its single value to super_block->u.generic_ul.

-- 

						Brian Gerst

--------------040901090402060904030103
Content-Type: text/plain;
 name="sb-romfs-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-romfs-1"

diff -urN linux-2.5.7-bg2/fs/romfs/inode.c linux-2.5.7-bg3/fs/romfs/inode.c
--- linux-2.5.7-bg2/fs/romfs/inode.c	Mon Mar 18 16:14:16 2002
+++ linux-2.5.7-bg3/fs/romfs/inode.c	Thu Mar 28 15:19:26 2002
@@ -76,6 +76,8 @@
 
 #include <asm/uaccess.h>
 
+#define ROMFS_MAXSIZE(sb) (sb)->u.generic_ul
+
 struct romfs_inode_info {
 	unsigned long i_metasize;	/* size of non-data area */
 	unsigned long i_dataoffset;	/* from the start of fs */
@@ -112,7 +114,6 @@
 	/* I would parse the options here, but there are none.. :) */
 
 	sb_set_blocksize(s, ROMBSIZE);
-	s->u.generic_sbp = (void *) 0;
 	s->s_maxbytes = 0xFFFFFFFF;
 
 	bh = sb_bread(s, 0);
@@ -138,7 +139,7 @@
 	}
 
 	s->s_magic = ROMFS_MAGIC;
-	s->u.romfs_sb.s_maxsize = sz;
+	ROMFS_MAXSIZE(s) = sz;
 
 	s->s_flags |= MS_RDONLY;
 
@@ -174,7 +175,7 @@
 	buf->f_type = ROMFS_MAGIC;
 	buf->f_bsize = ROMBSIZE;
 	buf->f_bfree = buf->f_bavail = buf->f_ffree;
-	buf->f_blocks = (sb->u.romfs_sb.s_maxsize+ROMBSIZE-1)>>ROMBSBITS;
+	buf->f_blocks = (ROMFS_MAXSIZE(sb)+ROMBSIZE-1)>>ROMBSBITS;
 	buf->f_namelen = ROMFS_MAXFN;
 	return 0;
 }
@@ -187,7 +188,7 @@
 	struct buffer_head *bh;
 	unsigned long avail, maxsize, res;
 
-	maxsize = i->i_sb->u.romfs_sb.s_maxsize;
+	maxsize = ROMFS_MAXSIZE(i->i_sb);
 	if (offset >= maxsize)
 		return -1;
 
@@ -229,7 +230,7 @@
 	struct buffer_head *bh;
 	unsigned long avail, maxsize, res;
 
-	maxsize = i->i_sb->u.romfs_sb.s_maxsize;
+	maxsize = ROMFS_MAXSIZE(i->i_sb);
 	if (offset >= maxsize || count > maxsize || offset+count>maxsize)
 		return -1;
 
@@ -273,7 +274,7 @@
 	int stored = 0;
 	char fsname[ROMFS_MAXFN];	/* XXX dynamic? */
 
-	maxoff = i->i_sb->u.romfs_sb.s_maxsize;
+	maxoff = ROMFS_MAXSIZE(i->i_sb);
 
 	offset = filp->f_pos;
 	if (!offset) {
@@ -333,7 +334,7 @@
 	if (romfs_copyfrom(dir, &ri, offset, ROMFH_SIZE) <= 0)
 		goto out;
 
-	maxoff = dir->i_sb->u.romfs_sb.s_maxsize;
+	maxoff = ROMFS_MAXSIZE(dir->i_sb);
 	offset = ntohl(ri.spec) & ROMFH_MASK;
 
 	/* OK, now find the file whose name is in "dentry" in the
diff -urN linux-2.5.7-bg2/include/linux/fs.h linux-2.5.7-bg3/include/linux/fs.h
--- linux-2.5.7-bg2/include/linux/fs.h	Wed Mar 27 20:27:58 2002
+++ linux-2.5.7-bg3/include/linux/fs.h	Thu Mar 28 15:48:54 2002
@@ -648,7 +648,6 @@
 #include <linux/hpfs_fs_sb.h>
 #include <linux/ntfs_fs_sb.h>
 #include <linux/sysv_fs_sb.h>
-#include <linux/romfs_fs_sb.h>
 #include <linux/adfs_fs_sb.h>
 #include <linux/bfs_fs_sb.h>
 
@@ -690,10 +689,10 @@
 		struct hpfs_sb_info	hpfs_sb;
 		struct ntfs_sb_info	ntfs_sb;
 		struct sysv_sb_info	sysv_sb;
-		struct romfs_sb_info	romfs_sb;
 		struct adfs_sb_info	adfs_sb;
 		struct bfs_sb_info	bfs_sb;
 		void			*generic_sbp;
+		unsigned long		generic_ul;
 	} u;
 	/*
 	 * The next field is for VFS *only*. No filesystems have any business
diff -urN linux-2.5.7-bg2/include/linux/romfs_fs_sb.h linux-2.5.7-bg3/include/linux/romfs_fs_sb.h
--- linux-2.5.7-bg2/include/linux/romfs_fs_sb.h	Thu Mar  7 21:18:27 2002
+++ linux-2.5.7-bg3/include/linux/romfs_fs_sb.h	Wed Dec 31 19:00:00 1969
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

--------------040901090402060904030103--

