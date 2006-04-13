Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWDMHOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWDMHOx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 03:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWDMHOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 03:14:53 -0400
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:10119 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S964813AbWDMHOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 03:14:51 -0400
To: Ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC][19/21]ext2resize enlarge file size and filesystem size
Message-Id: <20060413161411sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 13 Apr 2006 16:14:11 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [19/21] enlarge max file size and max filesystem size
          - With "-O large_block" option in mke2fs, the maximum size of
            a file is (blocksize) * (2^32-1) bytes, and of a filesystem
            is (pagesize) * (2^32-1).

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -Nurp old/ext2resize-1.1.19/src/ext2.c ext2resize-1.1.19/src/ext2.c
--- old/ext2resize-1.1.19/src/ext2.c	2006-03-20 21:46:08.000000000 +0800
+++ ext2resize-1.1.19/src/ext2.c	2006-03-20 21:47:33.000000000 +0800
@@ -295,7 +295,6 @@ int ext2_block_iterate(struct ext2_fs *f
 	blk_t			 curblock;
 	int			 count = 0;
 	int			 i;
-	int			 i512perblock = 1 << (fs->logsize - 9);
 	unsigned long long 	apb;
 
 	apb = fs->u32perblock;
@@ -341,7 +340,7 @@ int ext2_block_iterate(struct ext2_fs *f
 		inode->i_block[EXT2_DIND_BLOCK] = dindblk;
 		bh = ext2_bread(fs, inode->i_block[EXT2_DIND_BLOCK]);
 		memset(bh->data, 0, fs->blocksize);
-		inode->i_blocks += i512perblock;
+		inode->i_blocks += I_BLOCKS;
 	}
 	else
 		bh = ext2_bread(fs, inode->i_block[EXT2_DIND_BLOCK]);
@@ -363,7 +362,7 @@ int ext2_block_iterate(struct ext2_fs *f
 			ext2_zero_blocks(fs, block, 1);
 			ext2_set_block_state(fs, block, 1, 1);
 			bh->dirty = 1;
-			inode->i_blocks += i512perblock;
+			inode->i_blocks += I_BLOCKS;
 			inode->i_mtime = time(NULL);
 			ext2_brelse(bh, 0);
 			return 1;
@@ -379,7 +378,7 @@ int ext2_block_iterate(struct ext2_fs *f
 
 		bh2 = ext2_bread(fs, udata[i]);
 		udata2 = (__u32 *)bh2->data;
-		count += i512perblock;
+		count += I_BLOCKS;
 
 		for (j = 0; j < fs->u32perblock; j++, curblock++) {
 			if (action == EXT2_ACTION_ADD && !udata2[j]) {
@@ -390,7 +389,7 @@ int ext2_block_iterate(struct ext2_fs *f
 					       curblock, udata[i]);
 				bh2->dirty = 1;
 				udata2[j] = block;
-				inode->i_blocks += i512perblock;
+				inode->i_blocks += I_BLOCKS;
 				if (new_size > inode->i_size)
 					inode->i_size = new_size;
 				inode->i_mtime = time(NULL);
@@ -407,7 +406,7 @@ int ext2_block_iterate(struct ext2_fs *f
 						       curblock, udata[i]);
 					bh2->dirty = 1;
 					udata2[j] = 0;
-					inode->i_blocks -= i512perblock;
+					inode->i_blocks -= I_BLOCKS;
 					inode->i_mtime = time(NULL);
 					if (!(fs->flags & FL_ONLINE))
 						ext2_set_block_state(fs, block,
@@ -418,7 +417,7 @@ int ext2_block_iterate(struct ext2_fs *f
 				return curblock;
 			}
 			if (udata2[j]) {
-				count += i512perblock;
+				count += I_BLOCKS;
 				if (count >= inode->i_blocks &&
 				    action != EXT2_ACTION_ADD)
 					return -1;
@@ -787,7 +786,7 @@ static blk_t ext2_get_reserved(struct ex
 
 		for (i = 0; i < fs->numgroups; i++)
 			sb_groups += ext2_bg_has_super(fs, i);
-		resgdblocks = ((inode->i_blocks >> (fs->logsize - 9)) -
+		resgdblocks = ((inode->i_blocks >> I_BLOCKS_SHIFT) -
 			       (inode->i_block[EXT2_IND_BLOCK] ? 1 : 0) -
 			       (inode->i_block[EXT2_DIND_BLOCK] ? 1 : 0)) /
 			      sb_groups;
@@ -820,15 +819,16 @@ static blk_t ext2_get_reserved(struct ex
 				  EXT2_FEATURE_COMPAT_RESIZE_INODE)
 #define EXT2_OPEN_RO_COMPAT_UNSUPP ~(EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER | \
 				     EXT2_FEATURE_RO_COMPAT_LARGE_FILE)
-#define EXT2_OPEN_INCOMPAT_UNSUPP ~EXT2_FEATURE_INCOMPAT_FILETYPE
+#define EXT2_OPEN_INCOMPAT_UNSUPP ~(EXT2_FEATURE_INCOMPAT_FILETYPE | \
+				    EXT2_FEATURE_INCOMPAT_LARGE_BLOCK)
 
-struct ext2_fs *ext2_open(struct ext2_dev_handle *handle, blk_t newblocks,
+struct ext2_fs *ext2_open(struct ext2_dev_handle *handle, blk64_t newblocks,
 			  int flags)
 {
 	struct ext2_fs *fs;
 	struct ext2_inode inode;
 	int maxgroups;
-	blk_t devsize;
+	blk64_t devsize;
 	blk_t residue;
 
 	if (flags & FL_DEBUG)
@@ -909,6 +909,12 @@ struct ext2_fs *ext2_open(struct ext2_de
 		newblocks = devsize;
 	else if (fs->flags & FL_KB_BLOCKS)
 		newblocks >>= fs->logsize - 10;
+	if (newblocks > ~0U) {
+		/* actually we can't process fs over 4G-1 amount of blocks */
+		fprintf(stderr, "%s: can't resize filesystem over %uTB\n",
+			fs->prog, fs->blocksize >> (40 - 32));
+		goto error_free_bcache;
+	}
 
 	if (fs->flags & FL_VERBOSE)
 		printf("new filesystem size %d\n", newblocks);
@@ -926,13 +932,13 @@ struct ext2_fs *ext2_open(struct ext2_de
 	if (devsize < newblocks && !(fs->flags & FL_PREPARE)) {
 		char *junk[fs->blocksize];
 
-		fprintf(stderr, "%s: warning - device size %u, specified %u\n",
+		fprintf(stderr, "%s: warning - device size %llu, specified %llu\n",
 			fs->prog, devsize, newblocks);
 
 		ext2_read_blocks(fs, junk, newblocks - 1, 1);
 	} else if (fs->sb.s_blocks_count > devsize) {
 		char *junk[fs->blocksize];
-		fprintf(stderr, "%s: warning - device size %u, filesystem %u\n",
+		fprintf(stderr, "%s: warning - device size %llu, filesystem %u\n",
 			fs->prog, devsize, fs->sb.s_blocks_count);
 
 		ext2_read_blocks(fs, junk, fs->sb.s_blocks_count - 1, 1);
@@ -1014,7 +1020,7 @@ void ext2_fix_resize_inode(struct ext2_f
 
 		if (inode->i_block[EXT2_DIND_BLOCK]) {
 			ext2_zero_blocks(fs, inode->i_block[EXT2_DIND_BLOCK], 1);
-			inode->i_blocks = 1 << (fs->logsize - 9);
+			inode->i_blocks = I_BLOCKS;
 		}
 
 		for (i = 0, block = fs->sb.s_first_data_block + fs->newgdblocks + 1;
diff -Nurp old/ext2resize-1.1.19/src/ext2_fs.h ext2resize-1.1.19/src/ext2_fs.h
--- old/ext2resize-1.1.19/src/ext2_fs.h	2002-07-04 01:52:24.000000000 +0800
+++ ext2resize-1.1.19/src/ext2_fs.h	2006-03-20 21:47:33.000000000 +0800
@@ -509,6 +509,8 @@ struct ext2_super_block {
 #define EXT2_FEATURE_INCOMPAT_FILETYPE		0x0002
 #define EXT3_FEATURE_INCOMPAT_RECOVER		0x0004 /* Needs recovery */
 #define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008 /* Journal device */
+/*	EXT3_FEATURE_INCOMPAT_EXTENTS		0x0040 */
+#define EXT2_FEATURE_INCOMPAT_LARGE_BLOCK	0x0080
 
 #define EXT2_FEATURE_COMPAT_SUPP	0
 #define EXT2_FEATURE_INCOMPAT_SUPP	EXT2_FEATURE_INCOMPAT_FILETYPE
diff -Nurp old/ext2resize-1.1.19/src/ext2.h ext2resize-1.1.19/src/ext2.h
--- old/ext2resize-1.1.19/src/ext2.h	2006-03-20 21:47:15.000000000 +0800
+++ ext2resize-1.1.19/src/ext2.h	2006-03-20 21:47:33.000000000 +0800
@@ -51,6 +51,7 @@ static const char _ext2_h[] = "$Id: ext2
 #define cpu_to_le32(a)	(a)
 #endif
 typedef u_int32_t blk_t;
+typedef unsigned long long blk64_t;	/* don't use autoheader for now */
 
 #include "ext2_fs.h"
 
@@ -85,7 +86,7 @@ struct ext2_buffer_head
 struct ext2_dev_ops
 {
 	void	(*close)(void *cookie);
-	blk_t	(*get_size)(void *cookie);
+	blk64_t	(*get_size)(void *cookie);
 	void	(*read)(void *cookie, void *ptr, blk_t block, blk_t num);
 	void	(*set_blocksize)(void *cookie, int logsize);
 	void	(*sync)(void *cookie);
@@ -176,7 +177,7 @@ int ext2_bg_has_super(struct ext2_fs *fs
 unsigned int ext2_list_backups(struct ext2_fs *fs, unsigned int *three,
 			       unsigned int *five, unsigned int *seven);
 void ext2_move_blocks(struct ext2_fs *fs, blk_t src, blk_t num, blk_t dest);
-struct ext2_fs *ext2_open(struct ext2_dev_handle *handle, blk_t newblocks,
+struct ext2_fs *ext2_open(struct ext2_dev_handle *handle, blk64_t newblocks,
 			  int kb_blocks);
 void ext2_read_blocks(struct ext2_fs *fs, void *ptr, blk_t block,
 		      blk_t numblocks);
@@ -248,6 +249,11 @@ void ext2_fix_resize_inode(struct ext2_f
 #define clear_bit(buf, offset)	buf[(offset)>>3] &= ~_bitmap[(offset)&7]
 #define check_bit(buf, offset)	(buf[(offset)>>3] & _bitmap[(offset)&7])
 
+/* Switch macro for EXT2_FEATURE_INCOMPAT_LARGE_BLOCK */
+#define I_BLOCKS_SHIFT	(EXT2_HAS_INCOMPAT_FEATURE(&fs->sb, \
+		EXT2_FEATURE_INCOMPAT_LARGE_BLOCK) ? 0 : (fs->logsize - 9))
+#define I_BLOCKS	(1 << I_BLOCKS_SHIFT)
+
 #ifdef USE_EXT2_IS_DATA_BLOCK
 static int __inline__ ext2_is_data_block(struct ext2_fs *fs, blk_t block)
 {
diff -Nurp old/ext2resize-1.1.19/src/ext2online.c ext2resize-1.1.19/src/ext2online.c
--- old/ext2resize-1.1.19/src/ext2online.c	2006-03-20 21:46:08.000000000 +0800
+++ ext2resize-1.1.19/src/ext2online.c	2006-03-20 21:47:33.000000000 +0800
@@ -573,7 +573,8 @@ int main(int argc, char *argv[])
 	char			*progname;
 	struct ext2_dev_handle	*handle;
 	struct ext2_fs		*fs;
-	blk_t			 resize = 0, realsize = 0;
+	blk64_t			 resize = 0;
+	blk_t			 realsize = 0;
 	char			 mod = '\0';
 	int			 flags = FL_SAFE;
 
@@ -603,7 +604,7 @@ int main(int argc, char *argv[])
 
 	/* See if the user has specified a filesystem size */
 	if (argc == 2) {
-		sscanf(argv[1], "%i%c", &resize, &mod);
+		sscanf(argv[1], "%lli%c", &resize, &mod);
 
 		switch (mod) {	/* Order of these options is important!! */
 			case 't':
diff -Nurp old/ext2resize-1.1.19/src/ext2prepare.c ext2resize-1.1.19/src/ext2prepare.c
--- old/ext2resize-1.1.19/src/ext2prepare.c	2006-03-20 21:46:08.000000000 +0800
+++ ext2resize-1.1.19/src/ext2prepare.c	2006-03-20 21:47:33.000000000 +0800
@@ -228,7 +228,7 @@ int main(int argc, char *argv[])
 	char			*dev;
 	char			*progname;
 	blk_t			 maxres;
-	blk_t			 resize = 0;
+	blk64_t			 resize = 0;
 	char			 mod = '\0';
 	int			 flags = FL_SAFE;
 
@@ -248,7 +248,7 @@ int main(int argc, char *argv[])
 	if (handle == NULL)
 		return 1;
 
-	sscanf(argv[1], "%i%c", &resize, &mod);
+	sscanf(argv[1], "%lli%c", &resize, &mod);
 
 	switch (mod) {	/* Order of these options is important!! */
 		case 't':
@@ -282,11 +282,13 @@ int main(int argc, char *argv[])
 			"%s: won't prepare 1k block filesystem over 128GB.\n"
 			"\tToo much space would be wasted.\n", progname);
 		return 1;
-	} else if ((fs->blocksize == 4096 && fs->newblocks > 1<<30) ||
+	} else if (!EXT2_HAS_INCOMPAT_FEATURE(&fs->sb, EXT2_FEATURE_INCOMPAT_LARGE_BLOCK)) {
+	    if ((fs->blocksize == 4096 && fs->newblocks > 1<<29) ||
 		   fs->newblocks > 1<<31) {
 		fprintf(stderr,
 			"%s: can't resize filesystem over 2TB.\n", progname);
 		return 1;
+	    }
 	}
 
 	maxres = (1 + fs->u32perblock) * fs->u32perblock + EXT2_NDIR_BLOCKS;
diff -Nurp old/ext2resize-1.1.19/src/ext2resize.c ext2resize-1.1.19/src/ext2resize.c
--- old/ext2resize-1.1.19/src/ext2resize.c	2001-04-19 06:31:21.000000000 +0800
+++ ext2resize-1.1.19/src/ext2resize.c	2006-03-20 21:47:33.000000000 +0800
@@ -30,7 +30,7 @@ static const char _ext2resize_c[] = "$Id
 void usage(FILE *outfile, char *progname)
 {
 	fprintf(outfile,
-		"usage: %s [-dfquvV] device [new_size[bkmgt]]\n\t"
+		"usage: %s [-dfquvV] device [new_size[bkmgt]]\n"
 		"\t-d, --debug    : turn debug info on\n"
 		"\t-f, --force    : skip safety checks\n"
 		"\t-q, --quiet    : be quiet (print only errors)\n"
@@ -81,7 +81,7 @@ int main(int argc, char *argv[])
 	char			*dev;
 	char			*progname;
 	char			 mod = '\0';
-	blk_t			 resize = 0;
+	blk64_t			 resize = 0;
 	int			 flags = FL_SAFE;
 
 	progname = strrchr(argv[0], '/') ? strrchr(argv[0], '/') + 1 : argv[0];
@@ -102,7 +102,7 @@ int main(int argc, char *argv[])
 		return 1;
 
 	if (argc == 2) {
-		sscanf(argv[1], "%i%c", &resize, &mod);
+		sscanf(argv[1], "%lli%c", &resize, &mod);
 
 		switch (mod) {	/* Order of these options is important!! */
 			case 't':
diff -Nurp old/ext2resize-1.1.19/src/ext2_unix_io.c ext2resize-1.1.19/src/ext2_unix_io.c
--- old/ext2resize-1.1.19/src/ext2_unix_io.c	2004-09-30 22:04:04.000000000 +0800
+++ ext2resize-1.1.19/src/ext2_unix_io.c	2006-03-20 21:47:33.000000000 +0800
@@ -96,7 +96,7 @@ static int valid_offset(int fd, __loff_t
 	return 1;
 }
 
-static blk_t do_get_size(void *cookie)
+static blk64_t do_get_size(void *cookie)
 {
 	struct my_cookie *monster = cookie;
 	blk_t size;
@@ -138,7 +138,7 @@ static blk_t do_get_size(void *cookie)
 		/* Reset filesystem position? */
 		ext2_llseek(monster->fdread, monster->readoff, SEEK_SET);
 
-		size = high >> 9;
+		return high >> monster->logsize;
 	}
 
 	return size >> (monster->logsize - 9);
