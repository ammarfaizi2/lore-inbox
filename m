Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288842AbSAUXAg>; Mon, 21 Jan 2002 18:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288882AbSAUXAS>; Mon, 21 Jan 2002 18:00:18 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:27396 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288842AbSAUXAB>; Mon, 21 Jan 2002 18:00:01 -0500
Date: Mon, 21 Jan 2002 23:59:28 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: AFFS oops.
In-Reply-To: <20020120142811.A22052@suse.de>
Message-ID: <Pine.LNX.4.33.0201212346080.10584-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 20 Jan 2002, Dave Jones wrote:

> It's a boring Sunday afternoon, so I decided to do some destruction testing
> on unusual filesystems. First on the list is AFFS.

Thanks for testing.

> I mounted a 900k AFFS floppy disk image via loopback, and ran fsx on it.
> It dies instantly, before fsx gets to do any of its usual fun.

The patch below fixes everything I was able to find with fsx.
Marcelo, could you please apply the patch?
Thanks.

bye, Roman

Index: fs/affs/Changes
===================================================================
RCS file: /usr/src/cvsroot/linux-2.4/fs/affs/Changes,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 Changes
--- fs/affs/Changes	23 Sep 2001 20:55:48 -0000	1.1.1.4
+++ fs/affs/Changes	21 Jan 2002 22:38:43 -0000
@@ -28,6 +28,12 @@

 Please direct bug reports to: zippel@linux-m68k.org

+Version 3.19
+------------
+
+- sizeof changes from Kernel Janitor Project
+- several bug fixes found with fsx
+
 Version 3.18
 ------------

Index: fs/affs/bitmap.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.4/fs/affs/bitmap.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 bitmap.c
--- fs/affs/bitmap.c	3 May 2001 18:23:08 -0000	1.1.1.3
+++ fs/affs/bitmap.c	21 Jan 2002 22:37:32 -0000
@@ -292,7 +292,7 @@
 	AFFS_SB->s_bmap_bits = sb->s_blocksize * 8 - 32;
 	AFFS_SB->s_bmap_count = (AFFS_SB->s_partition_size - AFFS_SB->s_reserved +
 				 AFFS_SB->s_bmap_bits - 1) / AFFS_SB->s_bmap_bits;
-	size = AFFS_SB->s_bmap_count * sizeof(struct affs_bm_info);
+	size = AFFS_SB->s_bmap_count * sizeof(*bm);
 	bm = AFFS_SB->s_bitmap = kmalloc(size, GFP_KERNEL);
 	if (!AFFS_SB->s_bitmap) {
 		printk(KERN_ERR "AFFS: Bitmap allocation failed\n");
Index: fs/affs/file.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.4/fs/affs/file.c,v
retrieving revision 1.1.1.10
diff -u -r1.1.1.10 file.c
--- fs/affs/file.c	23 Sep 2001 20:55:48 -0000	1.1.1.10
+++ fs/affs/file.c	21 Jan 2002 22:12:48 -0000
@@ -510,7 +510,7 @@
 static int
 affs_do_readpage_ofs(struct file *file, struct page *page, unsigned from, unsigned to)
 {
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh;
 	char *data;
@@ -518,6 +518,8 @@
 	u32 tmp;

 	pr_debug("AFFS: read_page(%u, %ld, %d, %d)\n", (u32)inode->i_ino, page->index, from, to);
+	if (from > to || to > PAGE_CACHE_SIZE)
+		BUG();
 	data = page_address(page);
 	bsize = AFFS_SB->s_data_blksize;
 	tmp = (page->index << PAGE_CACHE_SHIFT) + from;
@@ -528,7 +530,9 @@
 		bh = affs_bread_ino(inode, bidx, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
-		tmp = min(bsize - boff, from - to);
+		tmp = min(bsize - boff, to - from);
+		if (from + tmp > to || tmp > bsize)
+			BUG();
 		memcpy(data + from, AFFS_DATA(bh) + boff, tmp);
 		affs_brelse(bh);
 		bidx++;
@@ -539,9 +543,8 @@
 }

 static int
-affs_extent_file_ofs(struct file *file, u32 newsize)
+affs_extent_file_ofs(struct inode *inode, u32 newsize)
 {
-	struct inode *inode = file->f_dentry->d_inode;
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh, *prev_bh;
 	u32 bidx, boff;
@@ -551,7 +554,7 @@
 	pr_debug("AFFS: extent_file(%u, %d)\n", (u32)inode->i_ino, newsize);
 	bsize = AFFS_SB->s_data_blksize;
 	bh = NULL;
-	size = inode->i_size;
+	size = AFFS_INODE->mmu_private;
 	bidx = size / bsize;
 	boff = size % bsize;
 	if (boff) {
@@ -559,6 +562,8 @@
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		tmp = min(bsize - boff, newsize - size);
+		if (boff + tmp > bsize || tmp > bsize)
+			BUG();
 		memset(AFFS_DATA(bh) + boff, 0, tmp);
 		AFFS_DATA_HEAD(bh)->size = cpu_to_be32(be32_to_cpu(AFFS_DATA_HEAD(bh)->size) + tmp);
 		affs_fix_checksum(sb, bh);
@@ -577,18 +582,21 @@
 		if (IS_ERR(bh))
 			goto out;
 		tmp = min(bsize, newsize - size);
+		if (tmp > bsize)
+			BUG();
 		AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 		AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
 		AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
 		AFFS_DATA_HEAD(bh)->size = cpu_to_be32(tmp);
 		affs_fix_checksum(sb, bh);
+		bh->b_state &= ~(1UL << BH_New);
 		mark_buffer_dirty_inode(bh, inode);
 		if (prev_bh) {
 			u32 tmp = be32_to_cpu(AFFS_DATA_HEAD(prev_bh)->next);
 			if (tmp)
-				affs_warning(sb, "prepare_write_ofs", "next block already set for %d (%d)", bidx, tmp);
+				affs_warning(sb, "extent_file_ofs", "next block already set for %d (%d)", bidx, tmp);
 			AFFS_DATA_HEAD(prev_bh)->next = cpu_to_be32(bh->b_blocknr);
-			affs_adjust_checksum(prev_bh, bidx - tmp);
+			affs_adjust_checksum(prev_bh, bh->b_blocknr - tmp);
 			mark_buffer_dirty_inode(prev_bh, inode);
 			affs_brelse(prev_bh);
 		}
@@ -596,7 +604,7 @@
 		bidx++;
 	}
 	affs_brelse(bh);
-	inode->i_size = AFFS_INODE->mmu_private = size;
+	inode->i_size = AFFS_INODE->mmu_private = newsize;
 	return 0;

 out:
@@ -607,7 +615,7 @@
 static int
 affs_readpage_ofs(struct file *file, struct page *page)
 {
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = page->mapping->host;
 	u32 to;
 	int err;

@@ -627,22 +635,22 @@

 static int affs_prepare_write_ofs(struct file *file, struct page *page, unsigned from, unsigned to)
 {
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = page->mapping->host;
 	u32 size, offset;
 	u32 tmp;
 	int err = 0;

 	pr_debug("AFFS: prepare_write(%u, %ld, %d, %d)\n", (u32)inode->i_ino, page->index, from, to);
-	if (Page_Uptodate(page))
-		return 0;
-
-	size = inode->i_size;
 	offset = page->index << PAGE_CACHE_SHIFT;
-	if (offset + from > size) {
-		err = affs_extent_file_ofs(file, offset + from);
+	if (offset + from > AFFS_INODE->mmu_private) {
+		err = affs_extent_file_ofs(inode, offset + from);
 		if (err)
 			return err;
 	}
+	size = inode->i_size;
+
+	if (Page_Uptodate(page))
+		return 0;

 	if (from) {
 		err = affs_do_readpage_ofs(file, page, 0, from);
@@ -653,7 +661,7 @@
 		memset(page_address(page) + to, 0, PAGE_CACHE_SIZE - to);
 		if (size > offset + to) {
 			if (size < offset + PAGE_CACHE_SIZE)
-				tmp = size & PAGE_CACHE_MASK;
+				tmp = size & ~PAGE_CACHE_MASK;
 			else
 				tmp = PAGE_CACHE_SIZE;
 			err = affs_do_readpage_ofs(file, page, to, tmp);
@@ -664,7 +672,7 @@

 static int affs_commit_write_ofs(struct file *file, struct page *page, unsigned from, unsigned to)
 {
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh, *prev_bh;
 	char *data;
@@ -686,6 +694,8 @@
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		tmp = min(bsize - boff, to - from);
+		if (boff + tmp > bsize || tmp > bsize)
+			BUG();
 		memcpy(AFFS_DATA(bh) + boff, data + from, tmp);
 		AFFS_DATA_HEAD(bh)->size = cpu_to_be32(be32_to_cpu(AFFS_DATA_HEAD(bh)->size) + tmp);
 		affs_fix_checksum(sb, bh);
@@ -710,12 +720,13 @@
 			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
 			AFFS_DATA_HEAD(bh)->size = cpu_to_be32(bsize);
 			AFFS_DATA_HEAD(bh)->next = 0;
+			bh->b_state &= ~(1UL << BH_New);
 			if (prev_bh) {
 				u32 tmp = be32_to_cpu(AFFS_DATA_HEAD(prev_bh)->next);
 				if (tmp)
-					affs_warning(sb, "prepare_write_ofs", "next block already set for %d (%d)", bidx, tmp);
+					affs_warning(sb, "commit_write_ofs", "next block already set for %d (%d)", bidx, tmp);
 				AFFS_DATA_HEAD(prev_bh)->next = cpu_to_be32(bh->b_blocknr);
-				affs_adjust_checksum(prev_bh, bidx - tmp);
+				affs_adjust_checksum(prev_bh, bh->b_blocknr - tmp);
 				mark_buffer_dirty_inode(prev_bh, inode);
 			}
 		}
@@ -732,6 +743,8 @@
 		if (IS_ERR(bh))
 			goto out;
 		tmp = min(bsize, to - from);
+		if (tmp > bsize)
+			BUG();
 		memcpy(AFFS_DATA(bh), data + from, tmp);
 		if (bh->b_state & (1UL << BH_New)) {
 			AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
@@ -739,12 +752,13 @@
 			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
 			AFFS_DATA_HEAD(bh)->size = cpu_to_be32(tmp);
 			AFFS_DATA_HEAD(bh)->next = 0;
+			bh->b_state &= ~(1UL << BH_New);
 			if (prev_bh) {
 				u32 tmp = be32_to_cpu(AFFS_DATA_HEAD(prev_bh)->next);
 				if (tmp)
-					affs_warning(sb, "prepare_write_ofs", "next block already set for %d (%d)", bidx, tmp);
+					affs_warning(sb, "commit_write_ofs", "next block already set for %d (%d)", bidx, tmp);
 				AFFS_DATA_HEAD(prev_bh)->next = cpu_to_be32(bh->b_blocknr);
-				affs_adjust_checksum(prev_bh, bidx - tmp);
+				affs_adjust_checksum(prev_bh, bh->b_blocknr - tmp);
 				mark_buffer_dirty_inode(prev_bh, inode);
 			}
 		} else if (be32_to_cpu(AFFS_DATA_HEAD(bh)->size) < tmp)
@@ -808,7 +822,8 @@
 	struct buffer_head *ext_bh;
 	int i;

-	pr_debug("AFFS: truncate(inode=%d, size=%u)\n", (u32)inode->i_ino, (u32)inode->i_size);
+	pr_debug("AFFS: truncate(inode=%d, oldsize=%u, newsize=%u)\n",
+		 (u32)inode->i_ino, (u32)AFFS_INODE->mmu_private, (u32)inode->i_size);

 	last_blk = 0;
 	ext = 0;
@@ -839,10 +854,19 @@

 	// lock cache
 	ext_bh = affs_get_extblock(inode, ext);
+	if (IS_ERR(ext_bh)) {
+		affs_warning(sb, "truncate", "unexpected read error for ext block %u (%d)",
+			     ext, PTR_ERR(ext_bh));
+		return;
+	}
 	if (AFFS_INODE->i_lc) {
 		/* clear linear cache */
-		for (i = (ext + 1) >> AFFS_INODE->i_lc_shift; i < AFFS_LC_SIZE; i++)
-			AFFS_INODE->i_lc[i] = 0;
+		i = (ext + 1) >> AFFS_INODE->i_lc_shift;
+		if (AFFS_INODE->i_lc_size > i) {
+			AFFS_INODE->i_lc_size = i;
+			for (; i < AFFS_LC_SIZE; i++)
+				AFFS_INODE->i_lc[i] = 0;
+		}
 		/* clear associative cache */
 		for (i = 0; i < AFFS_AC_SIZE; i++)
 			if (AFFS_INODE->i_ac[i].ext >= ext)
@@ -873,6 +897,19 @@
 	if (inode->i_size) {
 		AFFS_INODE->i_blkcnt = last_blk + 1;
 		AFFS_INODE->i_extcnt = ext + 1;
+		if (AFFS_SB->s_flags & SF_OFS) {
+			struct buffer_head *bh = affs_bread_ino(inode, last_blk, 0);
+			u32 tmp;
+			if (IS_ERR(ext_bh)) {
+				affs_warning(sb, "truncate", "unexpected read error for last block %u (%d)",
+					     ext, PTR_ERR(ext_bh));
+				return;
+			}
+			tmp = be32_to_cpu(AFFS_DATA_HEAD(bh)->next);
+			AFFS_DATA_HEAD(bh)->next = 0;
+			affs_adjust_checksum(bh, -tmp);
+			affs_brelse(bh);
+		}
 	} else {
 		AFFS_INODE->i_blkcnt = 0;
 		AFFS_INODE->i_extcnt = 1;
@@ -891,4 +928,5 @@
 		ext_key = be32_to_cpu(AFFS_TAIL(sb, ext_bh)->extension);
 		affs_brelse(ext_bh);
 	}
+	affs_free_prealloc(inode);
 }
Index: fs/affs/inode.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.4/fs/affs/inode.c,v
retrieving revision 1.1.1.10
diff -u -r1.1.1.10 inode.c
--- fs/affs/inode.c	15 Oct 2001 22:38:15 -0000	1.1.1.10
+++ fs/affs/inode.c	21 Jan 2002 22:37:32 -0000
@@ -68,7 +68,7 @@
 	inode->i_size = 0;
 	inode->i_nlink = 1;
 	inode->i_mode = 0;
-	memset(AFFS_INODE, 0, sizeof(struct affs_inode_info));
+	memset(AFFS_INODE, 0, sizeof(*AFFS_INODE));
 	init_MUTEX(&AFFS_INODE->i_link_lock);
 	init_MUTEX(&AFFS_INODE->i_ext_lock);
 	AFFS_INODE->i_extcnt = 1;
@@ -318,7 +318,7 @@
 	inode->i_ino     = block;
 	inode->i_nlink   = 1;
 	inode->i_mtime   = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	memset(AFFS_INODE, 0, sizeof(struct affs_inode_info));
+	memset(AFFS_INODE, 0, sizeof(*AFFS_INODE));
 	AFFS_INODE->i_extcnt = 1;
 	AFFS_INODE->i_ext_last = ~1;
 	init_MUTEX(&AFFS_INODE->i_link_lock);
Index: fs/affs/super.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.4/fs/affs/super.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 super.c
--- fs/affs/super.c	23 Nov 2001 19:24:33 -0000	1.1.1.7
+++ fs/affs/super.c	21 Jan 2002 22:37:32 -0000
@@ -240,7 +240,7 @@

 	sb->s_magic             = AFFS_SUPER_MAGIC;
 	sb->s_op                = &affs_sops;
-	memset(AFFS_SB, 0, sizeof(struct affs_sb_info));
+	memset(AFFS_SB, 0, sizeof(*AFFS_SB));
 	init_MUTEX(&AFFS_SB->s_bmlock);

 	if (!parse_options(data,&uid,&gid,&i,&reserved,&root_block,


