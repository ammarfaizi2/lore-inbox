Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272608AbTHKHhz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 03:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272611AbTHKHhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 03:37:55 -0400
Received: from tmi.comex.ru ([217.10.33.92]:25791 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S272608AbTHKHhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 03:37:04 -0400
Subject: [RFC] file extents for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
To: linux-kernel@vger.kernel.org
Cc: ext2-devel@lists.sourceforge.net
Organization: HOME
Date: Mon, 11 Aug 2003 11:41:41 +0400
Message-ID: <m3ptjcabey.fsf@bzzz.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


hello all!

there are several problems with old good method ext2/ext3
use to store map of block for an inode. for example, ext3's
truncate is quite slow. I think extents could solve this
and some other troubles. so ...


in fact, design is taken from htree modern ext2/ext3 uses. in constrast with
htree, it isn't backward-compatible.


there are three structures extents use:
1) extent
	struct ext3_extent {
		__u32	e_block;	/* first logical block extent covers */
		__u32	e_start;	/* first physical block extents lives at */
		__u32	e_num;		/* number of blocks covered by extent */
	};

   these structures live at the bottom of the tree

2) index
	struct ext3_extent_idx {
		__u32	e_block;	/* index covers logical blocks from 'block' */
		__u32	e_leaf;		/* pointer to the physical block of the next *
					 * level. leaf or next index could bet here */
	};

    these structures live at the all level, but bottom

3) block header
	struct ext3_extent_header {	
		__u16	e_num;		/* number of valid entries */
		__u16	e_max;		/* capacity of store in entries */
	};

    every storage (blocks and inode->i_data) starts with this


first level is placed in the inode->i_data. inode->i_depth contains current
depth of the tree. thus, knowing current level and i_depth we recognize block
as an index or a leaf. new file has depth=0 and first extents will be placed
in the inode->i_data. as inode->i_data gets exhausted we allocate new block,
move existing leaves from inode->i_data there, initialize inode->i_data as
index storage, put first index into and increment inode->i_depth. since now
we have a tree. as some leaf get exhausted, we create new index and allocate
new block for new leaf. as index storage overflowes, we grow tree in depth
and this procedure is the same as described above. all of this works just
fine for append case. insertion cases are more complex. we have to walk up to
the tree and looking for free index entry, insert new index there and create
needed number of blocks down to the bottom, moving part of index entries and
extents into the new blocks. here is disadvantage, though. depending on the
access pattern, we could end with 1 extent per leaf. therefore, it's better
to look into the neighboring leaf and check it for free space. if it isn't
full then put new extent there and correct all indexes above for that leaf.
there are pathological cases, of course. but I believe we could work them
around using clinical methods ;)

truncate case is much simpler, because all we need is recusrively tree
walking. probably we could check needness of the 2nd level at the end of the
walking and move it into the root level.

A flag (EXT3_EXTENTS_FL) in inode indicates that list of block for this inode
stored in extents format.


now some numbers I've got on dual P3-1GHz/512/SCSI HDD:

                        before          after
1 GB file creation:     0m33.510s       0m29.389s
1 GB file rewrite :     0m43.118s       0m29.562s
1 GB file removal :     0m1.522s        0m0.214s


                        before          after
8 GB file creation:     6m9.172s        5m40.798s
8 GB file rewrite :     6m46.805s       5m35.580s
8 GB file removal :     0m11.942s       0m1.366s

(NOTE: before each run I remounted filesystem in order to drop cache)

                        before          after
ave. for 4 dbench   8:  67.05412        142.48675
ave. for 4 dbench  16:  39.04725        118.16475
ave. for 4 dbench 128:  23.61612        61.35597

also, all the experiments with Lustre gave indication that the real win
might be in re-write.



lots of work need to be done (error handling, for example), lots of
improvement are possible. I need your ideas, comments and suggestions!
patch is attached and it's against 2.6.0-test2-mm3. you have to use
'extents' mount option to get it working.


with best regards, Alex



--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=ext3-extents.patch

 ext3/Makefile      |    2 
 ext3/extents.c     | 1353 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 ext3/ialloc.c      |    2 
 ext3/inode.c       |   25 
 ext3/super.c       |   11 
 linux/ext3_fs.h    |   17 
 linux/ext3_fs_i.h  |    4 
 linux/ext3_fs_sb.h |   10 
 8 files changed, 1418 insertions(+), 6 deletions(-)

diff -puN /dev/null fs/ext3/extents.c
--- /dev/null	2002-08-31 03:31:37.000000000 +0400
+++ linux-2.6.0-test2-mm3-alexey/fs/ext3/extents.c	2003-08-10 20:12:39.000000000 +0400
@@ -0,0 +1,1353 @@
+/*
+ *
+ * linux/fs/ext3/extents.c
+ *
+ * Extents support for EXT3
+ *
+ * 07/08/2003    Alex Tomas <bzzz@tmi.comex.ru>
+ * 
+ * TODO:
+ *   - find_goal() [to be tested and improved]
+ *   - error handling
+ *   - we could leak allocated block in some error cases
+ *   - quick search for index/leaf in ext3_ext_find_extent()
+ *   - tree reduction
+ *   - cache last found extent
+ *   - arch-independent
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/time.h>
+#include <linux/ext3_jbd.h>
+#include <linux/jbd.h>
+#include <linux/smp_lock.h>
+#include <linux/highuid.h>
+#include <linux/pagemap.h>
+#include <linux/quotaops.h>
+#include <linux/string.h>
+#include <linux/buffer_head.h>
+#include <linux/writeback.h>
+#include <linux/mpage.h>
+
+/*
+ * with AGRESSIVE_TEST defined capacity of index/leaf blocks
+ * become very little, so index split, in-depth growing and
+ * other hard changes happens much more often
+ * this is for debug purposes only
+ */
+#define AGRESSIVE_TEST_
+
+/*
+ * if EXT_DEBUG defined you can use 'extdebug' mount option
+ * to get lots of info what's going on
+ */
+#define EXT_DEBUG
+#ifdef EXT_DEBUG
+#define ext_debug(inode,fmt,a...) 		\
+do {						\
+	if (test_opt((inode)->i_sb, EXTDEBUG))	\
+		printk(fmt, ##a);		\
+} while (0);
+#else
+#define ext_debug(inode,fmt,a...)
+#endif
+
+#define EXT3_ALLOC_NEEDED	2	/* block bitmap + group descriptor */
+
+/*
+ * ext3_inode has i_block array (total 60 bytes)
+ * first 4 bytes are used to store:
+ *  - tree depth (0 mean there is no tree yet. all extents in the inode)
+ *  - number of alive extents in the inode
+ */
+
+/*
+ * this is extent on-disk structure
+ * it's used at the bottom of the tree
+ */
+struct ext3_extent {
+	__u32	e_block;	/* first logical block extent covers */
+	__u32	e_start;	/* first physical block extents lives */
+	__u32	e_num;		/* number of blocks covered by extent */
+};
+
+/*
+ * this is index on-disk structure
+ * it's used at all the levels, but the bottom
+ */
+struct ext3_extent_idx {
+	__u32	e_block;	/* index covers logical blocks from 'block' */
+	__u32	e_leaf;		/* pointer to the physical block of the next *
+				 * level. leaf or next index could bet here */
+};
+
+/*
+ * each block (leaves and indexes), even inode-stored has header
+ */
+struct ext3_extent_header {	
+	__u16	e_num;		/* number of valid entries */
+	__u16	e_max;		/* capacity of store in entries */
+};
+
+/*
+ * array of ext3_ext_path contains path to some extent
+ * creation/lookup routines use it for traversal/splitting/etc
+ * truncate uses it to simulate recursive walking
+ */
+struct ext3_ext_path {
+	__u32				p_block;
+	__u16				p_depth;
+	struct ext3_extent		*p_ext;
+	struct ext3_extent_idx		*p_idx;
+	struct ext3_extent_header	*p_hdr;
+	struct buffer_head		*p_bh;
+};
+
+#define EXT_FIRST_EXTENT(__hdr__) \
+	((struct ext3_extent *) (((char *) (__hdr__)) +		\
+				 sizeof(struct ext3_extent_header)))
+#define EXT_FIRST_INDEX(__hdr__) \
+	((struct ext3_extent_idx *) (((char *) (__hdr__)) +	\
+				     sizeof(struct ext3_extent_header)))
+#define EXT_HAS_FREE_INDEX(__path__) \
+	((__path__)->p_hdr->e_num < (__path__)->p_hdr->e_max)
+#define EXT_LAST_EXTENT(__hdr__) \
+	(EXT_FIRST_EXTENT((__hdr__)) + (__hdr__)->e_num - 1)
+#define EXT_LAST_INDEX(__hdr__) \
+	(EXT_FIRST_INDEX((__hdr__)) + (__hdr__)->e_num - 1)
+#define EXT_MAX_EXTENT(__hdr__) \
+	(EXT_FIRST_EXTENT((__hdr__)) + (__hdr__)->e_max - 1)
+#define EXT_MAX_INDEX(__hdr__) \
+	(EXT_FIRST_INDEX((__hdr__)) + (__hdr__)->e_max - 1)
+
+
+#define EXT_ASSERT(__x__) if (!(__x__)) BUG();
+
+
+int ext3_ext_get_access(handle_t *handle, struct inode *inode,
+			struct ext3_ext_path *path)
+{
+	if (path->p_bh) {
+		/* path points to block */
+		return ext3_journal_get_write_access(handle, path->p_bh);
+	}
+
+	/* path points to leaf/index in inode body */
+	return 0;
+}
+
+int ext3_ext_dirty(handle_t *handle, struct inode *inode,
+			struct ext3_ext_path *path)
+{
+	if (path->p_bh) {
+		/* path points to block */
+		return ext3_journal_dirty_metadata(handle, path->p_bh);
+	}
+
+	/* path points to leaf/index in inode body */
+	ext3_mark_inode_dirty(handle, inode);
+	return 0;
+}
+
+static inline int ext3_ext_space_block(struct inode *inode)
+{
+	int size;
+
+	size = (inode->i_sb->s_blocksize - sizeof(struct ext3_extent_header))
+		/ sizeof(struct ext3_extent);
+#ifdef AGRESSIVE_TEST
+	size = 6; /* FIXME: for debug, remove this line */
+#endif
+	return size;
+}
+
+static inline int ext3_ext_space_inode(struct inode *inode)
+{
+	int size;
+
+	size = (sizeof(EXT3_I(inode)->i_data) -
+			sizeof(struct ext3_extent_header))
+			/ sizeof(struct ext3_extent);
+#ifdef AGRESSIVE_TEST
+	size = 3; /* FIXME: for debug, remove this line */
+#endif
+	return size;
+}
+
+static inline int ext3_ext_space_inode_idx(struct inode *inode)
+{
+	int size;
+
+	size = (sizeof(EXT3_I(inode)->i_data) -
+			sizeof(struct ext3_extent_header))
+			/ sizeof(struct ext3_extent_idx);
+#ifdef AGRESSIVE_TEST
+	size = 4; /* FIXME: for debug, remove this line */
+#endif
+	return size;
+}
+
+static void ext3_ext_show_path(struct inode *inode, struct ext3_ext_path *path)
+{
+	int k, l = path->p_depth;
+
+	ext_debug(inode, "path:");
+	for (k = 0; k <= l; k++, path++) {
+		if (path->p_idx) {
+			ext_debug(inode, "  %d->%d", path->p_idx->e_block,
+					path->p_idx->e_leaf);
+		} else if (path->p_ext) {
+			ext_debug(inode, "  %d:%d:%d",
+					path->p_ext->e_block,
+					path->p_ext->e_start,
+					path->p_ext->e_num);
+		} else
+			ext_debug(inode, "  []");
+	}
+	ext_debug(inode, "\n");
+}
+
+static void ext3_ext_show_leaf(struct inode *inode, struct ext3_ext_path *path)
+{
+	int depth = EXT3_I(inode)->i_depth;
+	struct ext3_extent_header *eh = path[depth].p_hdr;
+	struct ext3_extent *ex = EXT_FIRST_EXTENT(eh);
+	int i;
+
+	for (i = 0; i < eh->e_num; i++, ex++) {
+		ext_debug(inode, "%d:%d:%d ",
+				ex->e_block, ex->e_start, ex->e_num);
+	}
+	ext_debug(inode, "\n");
+}
+
+static void ext3_ext_drop_refs(struct inode *inode, struct ext3_ext_path *path)
+{
+	int depth = path->p_depth;
+	int i;
+
+	for (i = 0; i <= depth; i++, path++)
+		if (path->p_bh) {
+			brelse(path->p_bh);
+			path->p_bh = NULL;
+		}
+}
+
+static int ext3_ext_find_goal(struct inode *inode, struct ext3_ext_path *path)
+{
+	struct ext3_inode_info *ei = EXT3_I(inode);
+	unsigned long bg_start;
+	unsigned long colour;
+	int depth;
+	
+	if (path) {
+		depth = path->p_depth;
+		/* try to find previous block */
+		if (path[depth].p_ext)
+			return path[depth].p_ext->e_start +
+				path[depth].p_ext->e_num - 1;
+		
+		/* it looks index is empty
+		 * try to find starting from index itself */
+		if (path[depth].p_bh)
+			return path[depth].p_bh->b_blocknr;
+	}
+
+	/* OK. use inode's group */
+	bg_start = (ei->i_block_group * EXT3_BLOCKS_PER_GROUP(inode->i_sb)) +
+		le32_to_cpu(EXT3_SB(inode->i_sb)->s_es->s_first_data_block);
+	colour = (current->pid % 16) *
+			(EXT3_BLOCKS_PER_GROUP(inode->i_sb) / 16);
+	return bg_start + colour;
+}
+
+static struct ext3_ext_path *
+ext3_ext_find_extent(struct inode *inode, int block, struct ext3_ext_path *path)
+{
+	struct ext3_inode_info *ei = EXT3_I(inode);
+	struct ext3_extent_header *eh = (void *) ei->i_data;
+	struct ext3_extent_idx *ix;
+	struct buffer_head *bh;
+	struct ext3_extent *ex;
+	int depth, i, k, ppos = 0;
+	
+	eh = (struct ext3_extent_header *) ei->i_data;
+
+	/* initialize capacity of leaf in inode for first time */
+	if (eh->e_max == 0)
+		eh->e_max = ext3_ext_space_inode(inode);
+	i = depth = ei->i_depth;
+	EXT_ASSERT(i == 0 || eh->e_num > 0);
+	
+	/* account possible depth increase */
+	if (!path) {
+		path = kmalloc(sizeof(struct ext3_ext_path) * (depth + 2),
+				GFP_NOFS);
+		if (!path)
+			return ERR_PTR(-ENOMEM);
+	}
+	memset(path, 0, sizeof(struct ext3_ext_path) * (depth + 1));
+
+	/* walk through the tree */
+	while (i) {
+		ext_debug(inode, "depth %d: num %d, max %d\n",
+				ppos, eh->e_num, eh->e_max);
+		ix = EXT_FIRST_INDEX(eh);
+		if (eh->e_num)
+			path[ppos].p_idx = ix;
+		EXT_ASSERT(eh->e_num <= eh->e_max);
+		for (k = 0; k < eh->e_num; k++, ix++) {
+			ext_debug(inode, "index: %d -> %d\n",
+					ix->e_block, ix->e_leaf);
+			if (block < ix->e_block)
+				break;
+			path[ppos].p_idx = ix;
+		}
+		path[ppos].p_block = path[ppos].p_idx->e_leaf;
+		path[ppos].p_depth = i;
+		path[ppos].p_hdr = eh;
+		path[ppos].p_ext = NULL;
+
+		bh = sb_bread(inode->i_sb, path[ppos].p_block);
+		if (!bh) {
+			ext3_ext_drop_refs(inode, path);
+			kfree(path);
+			return ERR_PTR(-EIO);
+		}
+		eh = (struct ext3_extent_header *) bh->b_data;
+		ppos++;
+		EXT_ASSERT(ppos <= depth);
+		path[ppos].p_bh = bh;
+		i--;
+	}
+
+	path[ppos].p_depth = i;
+	path[ppos].p_hdr = eh;
+	path[ppos].p_ext = NULL;
+	
+	/* find extent */
+	ex = EXT_FIRST_EXTENT(eh);
+	if (eh->e_num)
+		path[ppos].p_ext = ex;
+	EXT_ASSERT(eh->e_num <= eh->e_max);
+	for (k = 0; k < eh->e_num; k++, ex++) {
+		if (block < ex->e_block) 
+			break;
+		path[ppos].p_ext = ex;
+	}
+
+	ext3_ext_show_path(inode, path);
+
+	return path;
+}
+
+void ext3_ext_check_boundary(struct inode *inode, struct ext3_ext_path *curp,
+				void *addr, int len)
+{
+	void *end;
+
+	if (!len)
+		return;
+	if (curp->p_bh)
+		end = (void *) curp->p_hdr + inode->i_sb->s_blocksize;
+	else
+		end = (void *) curp->p_hdr + sizeof(EXT3_I(inode)->i_data);
+	if (((unsigned long) addr) + len > (unsigned long) end) {
+		printk("overflow! 0x%p > 0x%p\n", addr + len, end);
+		BUG();
+	}
+	if ((unsigned long) addr < (unsigned long) curp->p_hdr) {
+		printk("underflow! 0x%p < 0x%p\n", addr, curp->p_hdr);
+		BUG();
+	}
+}
+
+void ext3_ext_insert_index(handle_t *handle, struct inode *inode,
+				struct ext3_ext_path *curp, int logical,
+				int ptr)
+{
+	struct ext3_extent_idx *ix;
+	int len, err;
+
+	if ((err = ext3_ext_get_access(handle, inode, curp)))
+		BUG();
+
+	EXT_ASSERT(logical != curp->p_idx->e_block);
+	len = EXT_MAX_INDEX(curp->p_hdr) - curp->p_idx;
+	if (logical > curp->p_idx->e_block) {
+		/* insert after */
+		len = (len - 1) * sizeof(struct ext3_extent_idx);
+		len = len < 0 ? 0 : len;
+		ext_debug(inode, "insert new index %d after: %d. "
+				"move %d from 0x%p to 0x%p\n",
+				logical, ptr, len,
+				(curp->p_idx + 1), (curp->p_idx + 2));
+
+		ext3_ext_check_boundary(inode, curp, curp->p_idx + 2, len);
+		memmove(curp->p_idx + 2, curp->p_idx + 1, len);
+		ix = curp->p_idx + 1;
+	} else {
+		/* insert before */
+		len = len * sizeof(struct ext3_extent_idx);
+		len = len < 0 ? 0 : len;
+		ext_debug(inode, "insert new index %d before: %d. "
+				"move %d from 0x%p to 0x%p\n",
+				logical, ptr, len,
+				curp->p_idx, (curp->p_idx + 1));
+
+		ext3_ext_check_boundary(inode, curp, curp->p_idx + 1, len);
+		memmove(curp->p_idx + 1, curp->p_idx, len);
+		ix = curp->p_idx;
+	}
+
+	ix->e_block = logical;
+	ix->e_leaf = ptr;
+	curp->p_hdr->e_num++;
+
+	if ((err = ext3_ext_dirty(handle, inode, curp)))
+		BUG();
+}
+
+int ext3_ext_create_new_leaf(handle_t *handle, struct inode *inode,
+				struct ext3_ext_path *path,
+				struct ext3_extent *newext)
+{
+	struct buffer_head *bh;
+	int depth = EXT3_I(inode)->i_depth;
+	struct ext3_ext_path *curp;
+	struct ext3_extent_header *neh;
+	struct ext3_extent_idx *fidx;
+	struct ext3_extent *ex;
+	int i = depth, k, m;
+	int newblock, border;
+	int err = 0;
+
+	/* walk up to the tree and look for free index entry */
+	curp = path + depth;
+	while (i > 0 && !EXT_HAS_FREE_INDEX(curp)) {
+		i--;
+		curp--;
+	}
+
+	/* we use already allocated block for index block
+	 * so, subsequent data blocks should be contigoues */
+	newblock = newext->e_start;
+	newext->e_num--;
+	bh = sb_getblk(inode->i_sb, newblock);
+	if (!bh)
+		return -EIO;
+
+	lock_buffer(bh);
+
+	if (EXT_HAS_FREE_INDEX(curp)) {
+		/* if we found index with free entry, then use that
+		 * entry: create all needed subtree and add new leaf */
+
+		/* make decision: where to split? */
+		/* FIXME: now desicion is simplest: at current extent */
+
+		/* if current leaf will be splitted, then we should use 
+		 * border from split point */
+		if (path[depth].p_ext != EXT_MAX_EXTENT(path[depth].p_hdr)) {
+			border = path[depth].p_ext[1].e_block;
+			ext_debug(inode, "leaf will be splitted."
+					" next leaf starts at %d\n",
+					 border);
+		} else {
+			border = newext->e_block;
+			ext_debug(inode, "leaf will be added."
+					" next leaf starts at %d\n",
+					border);
+		}
+		/* insert new index */
+		ext3_ext_insert_index(handle, inode, curp, border, newblock);
+
+		k = depth - i - 1;
+		EXT_ASSERT(k >= 0);
+		if (k)
+			ext_debug(inode,
+					"create %d intermediate indices\n", k);
+		/* insert new index into current index block */
+		/* current depth stored in i var */
+		i++;
+		while (k--) {
+			newblock =
+				ext3_new_block(handle, inode, newblock,
+						0, 0, &err);
+			if (!newblock)
+				BUG();
+
+			if ((err = ext3_journal_get_create_access(handle, bh)))
+				BUG();
+			
+			neh = (struct ext3_extent_header *) bh->b_data;
+			neh->e_num = 1;
+			neh->e_max = ext3_ext_space_block(inode);
+			fidx = EXT_FIRST_INDEX(neh);
+			fidx->e_block = border;
+			fidx->e_leaf = newblock;
+			
+			/* copy indexes */
+			m = 0;
+			path[i].p_idx++;
+			EXT_ASSERT(EXT_MAX_INDEX(path[i].p_hdr) ==
+						EXT_LAST_INDEX(path[i].p_hdr));
+			ext_debug(inode, "cur 0x%p, last 0x%p\n", path[i].p_idx,
+					EXT_MAX_INDEX(path[i].p_hdr));
+			while (path[i].p_idx <=
+					EXT_MAX_INDEX(path[i].p_hdr)) {
+				ext_debug(inode, "%d: move %d:%d in new index\n",
+						i, path[i].p_idx->e_block,
+						path[i].p_idx->e_leaf);
+				memmove(++fidx, path[i].p_idx++,
+						sizeof(struct ext3_extent_idx));
+				neh->e_num++;
+				m++;
+			}
+
+			/* correct old index */
+			if (m) {
+				err = ext3_ext_get_access(handle,inode,path+i);
+				if (err)
+					BUG();
+				path[i].p_hdr->e_num -= m;
+				err = ext3_ext_dirty(handle, inode, path + i);
+				if (err)
+					BUG();
+			}
+
+			set_buffer_uptodate(bh);
+			unlock_buffer(bh);
+
+			if ((err = ext3_journal_dirty_metadata(handle, bh)))
+				BUG();
+			brelse(bh);
+			
+			bh = sb_getblk(inode->i_sb, newblock);
+			if (!bh)
+				BUG();
+			lock_buffer(bh);
+			i++;
+		}
+		
+		/* initialize new leaf */
+		if ((err = ext3_journal_get_create_access(handle, bh)))
+			BUG();
+
+		neh = (struct ext3_extent_header *) bh->b_data;
+		neh->e_num = 0;
+		neh->e_max = ext3_ext_space_block(inode);
+		ex = EXT_FIRST_EXTENT(neh);
+
+		/* move remain of path[depth] to the new leaf */
+		k = 0;
+		EXT_ASSERT(path[depth].p_hdr->e_num ==
+				path[depth].p_hdr->e_max);
+		/* start copy from next extent */
+		path[depth].p_ext++;
+		while (path[depth].p_ext <=
+				EXT_MAX_EXTENT(path[depth].p_hdr)) {
+			ext_debug(inode, "move %d:%d:%d in new leaf\n",
+					path[depth].p_ext->e_block,
+					path[depth].p_ext->e_start,
+					path[depth].p_ext->e_num);
+			memmove(ex++, path[depth].p_ext++,
+					sizeof(struct ext3_extent));
+			neh->e_num++;
+			k++;
+		}
+		set_buffer_uptodate(bh);
+		unlock_buffer(bh);
+
+		if ((err = ext3_journal_dirty_metadata(handle, bh)))
+			BUG();
+
+		/* correct old leaf */
+		if (k) {
+			if ((err = ext3_ext_get_access(handle, inode, path)))
+				BUG();
+			path[depth].p_hdr->e_num -= k;
+			if ((err = ext3_ext_dirty(handle, inode, path)))
+				BUG();
+		}
+	} else {
+		/* tree is full, time to grow in depth */
+		int len;
+		
+		if ((err = ext3_journal_get_create_access(handle, bh)))
+			BUG();
+
+		/* move top-level index/leaf into new block */
+		len = sizeof(struct ext3_extent_header) +
+			sizeof(struct ext3_extent) * curp->p_hdr->e_max;
+		EXT_ASSERT(len >= 0 && len < 4096);
+		memmove(bh->b_data, curp->p_hdr, len);
+
+		/* set size of new block */
+		neh = (struct ext3_extent_header *) bh->b_data;
+		neh->e_max = ext3_ext_space_block(inode);
+		set_buffer_uptodate(bh);
+		unlock_buffer(bh);
+
+		if ((err = ext3_journal_dirty_metadata(handle, bh)))
+			BUG();
+		
+		/* create index in new top-level index: num,max,pointer */
+		if ((err = ext3_ext_get_access(handle, inode, curp)))
+			BUG();
+
+		curp->p_hdr->e_max = ext3_ext_space_inode_idx(inode);
+		curp->p_hdr->e_num = 1;
+		curp->p_idx = EXT_FIRST_INDEX(curp->p_hdr);
+		curp->p_idx->e_block = EXT_FIRST_EXTENT(path[0].p_hdr)->e_block;
+		curp->p_idx->e_leaf = newblock;
+		
+		neh = (struct ext3_extent_header *) EXT3_I(inode)->i_data;
+		fidx = EXT_FIRST_INDEX(neh);
+		ext_debug(inode, "new root: num %d(%d), lblock %d, ptr %d\n",
+			neh->e_num, neh->e_max, fidx->e_block, fidx->e_leaf); 
+				
+		EXT3_I(inode)->i_depth++;
+		if ((err = ext3_ext_dirty(handle, inode, curp)))
+			BUG();
+	}
+	brelse(bh);
+
+	/* refill path */
+	ext3_ext_drop_refs(inode, path);
+	path = ext3_ext_find_extent(inode, newext->e_block, path);
+	if (IS_ERR(path)) {
+		/* FIXME: we have to clean all above */
+		return PTR_ERR(path);
+	}
+
+	/*
+	 * probably we've used some blocks from extent
+	 * let's allocate new block for it
+	 */
+	if (newext->e_num == 0 && !err) {
+		newext->e_start =
+			ext3_new_block(handle, inode, newblock, 0, 0, &err);
+		newext->e_num = 1;
+	}
+
+	return err;
+}
+
+#if 0
+/* FIXME: it hasn't tested yet! */
+static unsigned ext3_ext_next_allocated_block(struct inode *inode,
+                                               struct ext3_ext_path *path)
+{
+	int depth;
+
+	EXT_ASSERT(path != NULL);
+	depth = path->p_depth;
+
+	if (depth == 0 && path->p_ext == NULL)
+		return 0xffffffff;
+
+	/* FIXME: what if index isn't full ?! */
+	while (depth >= 0) {
+		if (depth == path->p_depth) {
+			/* leaf */
+			if (path[depth].p_ext !=
+					EXT_LAST_EXTENT(path[depth].p_hdr))
+				return path[depth].p_ext[1].e_block;
+		} else {
+			/* index */
+			if (path[depth].p_idx !=
+					EXT_LAST_INDEX(path[depth].p_hdr))
+				return path[depth].p_idx[1].e_block;
+		}
+		depth--;        
+	}
+
+	return 0xffffffff;
+}
+#endif
+
+/* FIXME: it hasn't tested yet! */
+static unsigned ext3_ext_next_leaf_block(struct inode *inode,
+                                               struct ext3_ext_path *path)
+{
+	int depth;
+
+	EXT_ASSERT(path != NULL);
+	depth = path->p_depth;
+
+	/* zero-tree has no leaf blocks at all */
+	if (depth == 0)
+		return 0xffffffff;
+
+	/* go to index block */
+	depth--;
+	
+	while (depth >= 0) {
+		if (path[depth].p_idx !=
+				EXT_LAST_INDEX(path[depth].p_hdr))
+			return path[depth].p_idx[1].e_block;
+		depth--;        
+	}
+
+	return 0xffffffff;
+}
+
+int ext3_ext_insert_extent(handle_t *handle, struct inode *inode,
+				struct ext3_ext_path *path,
+				struct ext3_extent *newext)
+{
+	int depth, len;
+	struct ext3_extent_header * eh;
+	struct ext3_extent *ex;
+	struct ext3_extent *nearex; /* nearest extent */
+	struct ext3_ext_path *npath = NULL;
+	int err;
+
+	depth = EXT3_I(inode)->i_depth;	
+	if ((ex = path[depth].p_ext)) {
+		/* try to insert block into found extent and return */
+		if (ex->e_block + ex->e_num == newext->e_block &&
+				ex->e_start + ex->e_num == newext->e_start) {
+#ifdef AGRESSIVE_TEST
+			if (ex->e_num >= 2)
+				goto repeat;
+#endif
+			if ((err = ext3_ext_get_access(handle, inode,
+							path + depth)))
+				BUG();
+			ext_debug(inode, "append %d block to %d:%d (from %d)\n",
+					newext->e_num, ex->e_block, ex->e_num,
+					ex->e_start);
+			ex->e_num += newext->e_num;
+			if ((err = ext3_ext_dirty(handle, inode, path + depth)))
+				BUG();
+			return 0;
+		}
+	}
+
+repeat:
+	depth = EXT3_I(inode)->i_depth;	
+	eh = path[depth].p_hdr;
+	if (eh->e_num == eh->e_max) {
+		/* probably next leaf has space for us? */
+		int next = ext3_ext_next_leaf_block(inode, path);
+		if (next != 0xffffffff) {
+			ext_debug(inode, "next leaf block - %d\n", next);
+			EXT_ASSERT(!npath);
+			npath = ext3_ext_find_extent(inode, next, NULL);
+			if (IS_ERR(npath))
+				return PTR_ERR(npath);
+			EXT_ASSERT(npath->p_depth == path->p_depth);
+			eh = npath[depth].p_hdr;
+			if (eh->e_num < eh->e_max) {
+				ext_debug(inode,
+						"next leaf has free ext(%d)\n",
+						eh->e_num);
+				path = npath;
+				goto repeat;
+			}
+			ext_debug(inode, "next leaf has no free space(%d, %d)\n",
+					eh->e_num, eh->e_max);
+		}
+		err = ext3_ext_create_new_leaf(handle, inode, path, newext);
+		if (err)
+			goto cleanup;
+		goto repeat;
+	}
+
+	nearex = path[depth].p_ext;
+
+	if ((err = ext3_ext_get_access(handle, inode, path + depth)))
+		BUG();
+
+	if (!nearex) {
+		/* there is no extent in this leaf, create first one */
+		eh->e_num++;
+		nearex = EXT_FIRST_EXTENT(eh);
+		ext_debug(inode, "first extent in the leaf: %d:%d:%d\n",
+				newext->e_block, newext->e_start,
+				newext->e_num);
+
+	} else if (newext->e_block > nearex->e_block) {
+		EXT_ASSERT(newext->e_block != nearex->e_block);
+		len = EXT_MAX_EXTENT(eh) - nearex;
+		len = (len - 1) * sizeof(struct ext3_extent);
+		len = len < 0 ? 0 : len;
+		ext_debug(inode, "insert %d:%d:%d after: nearest 0x%p, "
+				"move %d from 0x%p to 0x%p\n",
+				newext->e_block, newext->e_start, newext->e_num,
+				nearex, len, nearex + 1, nearex + 2);
+		ext3_ext_check_boundary(inode, path + depth, nearex + 2, len);
+		memmove(nearex + 2, nearex + 1, len);
+		nearex++;
+		eh->e_num++;
+	} else {
+		EXT_ASSERT(newext->e_block != nearex->e_block);
+		len = (EXT_MAX_EXTENT(eh) - nearex) * sizeof(struct ext3_extent);
+		len = len < 0 ? 0 : len;
+		ext_debug(inode, "insert %d:%d:%d before: nearest 0x%p, "
+				"move %d from 0x%p to 0x%p\n",
+				newext->e_block, newext->e_start, newext->e_num,
+				nearex, len, nearex + 1, nearex + 2);
+		memmove(nearex + 1, nearex, len);
+		eh->e_num++;
+
+		/* time to correct all indexes above */
+		if (nearex == EXT_FIRST_EXTENT(eh) && depth > 0) {
+			int k = depth - 1;
+			if ((err = ext3_ext_get_access(handle, inode, path+k)))
+				BUG();
+			path[k].p_idx->e_block = newext->e_block;
+			if ((err = ext3_ext_dirty(handle, inode, path + k)))
+				BUG();
+			while (k--) {
+				/* change all left-side indexes */
+				if (path[k].p_idx !=
+					EXT_FIRST_INDEX(path[k].p_hdr) &&
+					k != 0)
+					break;
+				if ((err = ext3_ext_get_access(handle, inode,
+								path + k)))
+					BUG();
+				path[k].p_idx->e_block = newext->e_block;
+				if ((err = ext3_ext_dirty(handle, inode,
+								path + k)))
+					BUG();
+			}
+		}
+	}
+
+	if (!err) {
+		nearex->e_block = newext->e_block;
+		nearex->e_start = newext->e_start;
+		nearex->e_num = newext->e_num;
+	}
+
+	if ((err = ext3_ext_dirty(handle, inode, path + depth)))
+		BUG();
+
+cleanup:
+	if (npath) {
+		ext3_ext_drop_refs(inode, npath);
+		kfree(npath);
+	}
+		
+	return err;
+}
+
+int ext3_ext_get_block(handle_t *handle, struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create,
+			int extend_disksize)
+{
+	struct ext3_ext_path *path;
+	int depth = EXT3_I(inode)->i_depth;
+	struct ext3_extent newex;
+	struct ext3_extent *ex;
+	int newblock, err = 0;
+
+	ext_debug(inode, "block %d requested for inode %u, bh_result 0x%p\n",
+			(int) iblock, (unsigned) inode->i_ino, bh_result);
+	clear_buffer_new(bh_result);
+
+	down(&EXT3_I(inode)->i_ext_sem);
+
+	/* find extent for this block */
+	path = ext3_ext_find_extent(inode, iblock, NULL);
+	if (IS_ERR(path)) {
+		err = PTR_ERR(path);
+		goto out2;
+	}
+
+	if ((ex = path[depth].p_ext)) {
+		/* if found exent covers block, simple return it */
+		if (iblock >= ex->e_block && iblock < ex->e_block + ex->e_num) {
+			newblock = iblock - ex->e_block + ex->e_start;
+			ext_debug(inode, "%d fit into %d:%d -> %d\n",
+					(int) iblock, ex->e_block, ex->e_num,
+					newblock);
+			goto out;
+		}
+	}
+
+	/*
+	 * we couldn't try to create block if create flag is zero 
+	 */
+	if (!create) 
+		goto out2;
+
+	/* allocate new block */
+	newblock = ext3_ext_find_goal(inode, path);
+	newblock = ext3_new_block(handle, inode, newblock, 0, 0, &err);
+	if (!newblock)
+		goto out2;
+
+	/* try to insert new extent into found leaf and return */
+	newex.e_block = iblock;
+	newex.e_start = newblock;
+	newex.e_num = 1;
+	err = ext3_ext_insert_extent(handle, inode, path, &newex);
+	if (err)
+		goto out2;
+	
+	/* previous routine could use block we allocated
+	 * for index block */
+	newblock = newex.e_start;
+	set_buffer_new(bh_result);
+
+out:
+	ext3_ext_show_leaf(inode, path);
+	map_bh(bh_result, inode->i_sb, newblock);
+out2:
+	ext3_ext_drop_refs(inode, path);
+	kfree(path);
+	up(&EXT3_I(inode)->i_ext_sem);
+
+	return err;	
+}
+
+/*
+ * returns 1 if current index have to be freed (even partial)
+ */
+int ext3_ext_more_to_truncate(struct inode *inode,
+				struct ext3_ext_path *path)
+{
+	EXT_ASSERT(path->p_idx);
+
+	if (path->p_idx < EXT_FIRST_INDEX(path->p_hdr))
+		return 0;
+
+	/*
+	 * if truncate on deeper level happened it it wasn't partial
+	 * so we have to consider current index for truncation
+	 */
+	if (path->p_hdr->e_num == path->p_block)
+		return 0;
+
+	/*
+	 * put actual number of indexes to know is this number got
+	 * changed at the next iteration
+	 */
+	path->p_block = path->p_hdr->e_num;
+	
+	return 1;
+}
+
+void ext3_ext_remove_index(handle_t *handle, struct inode *inode,
+					struct ext3_ext_path *path)
+{
+	struct buffer_head *bh;
+	int err;
+	
+	/* free index block */
+	path--;
+	EXT_ASSERT(path->p_hdr->e_num);
+	if ((err = ext3_ext_get_access(handle, inode, path)))
+		BUG();
+	path->p_hdr->e_num--;
+	if ((err = ext3_ext_dirty(handle, inode, path)))
+		BUG();
+	bh = sb_find_get_block(inode->i_sb, path->p_idx->e_leaf);
+	ext3_forget(handle, 0, inode, bh, path->p_idx->e_leaf);
+	ext3_free_blocks(handle, inode, path->p_idx->e_leaf, 1);
+
+	ext_debug(inode, "index is empty, remove it, free block %d\n",
+			path->p_idx->e_leaf);
+}
+
+/*
+ * returns 1 if current extent needs to be freed (even partial)
+ * instead, returns 0
+ */
+int ext3_ext_more_leaves_to_truncate(struct inode *inode,
+					struct ext3_ext_path *path)
+{
+	unsigned blocksize = inode->i_sb->s_blocksize;
+	struct ext3_extent *ex = path->p_ext;
+	int last_block; 
+
+	EXT_ASSERT(ex);
+
+	/* is there leave in the current leaf? */
+	if (ex < EXT_FIRST_EXTENT(path->p_hdr))
+		return 0;
+	
+	last_block = (inode->i_size + blocksize-1)
+					>> EXT3_BLOCK_SIZE_BITS(inode->i_sb);
+
+	if (last_block >= ex->e_block + ex->e_num)
+		return 0;
+
+	/* seems it extent have to be freed */
+	return 1;
+}
+
+handle_t *ext3_ext_journal_restart(handle_t *handle, int needed)
+{
+	int err;
+
+	if (handle->h_buffer_credits > needed)
+		return handle;
+	if (!ext3_journal_extend(handle, needed))
+		return handle;
+	err = ext3_journal_restart(handle, needed);
+	
+	return handle;
+}
+
+/*
+ * this routine calculate max number of blocks to be modified
+ * while freeing extent and is intended to be used in truncate path
+ */
+static int ext3_ext_calc_credits(struct inode *inode,
+					struct ext3_ext_path *path,
+					int num)
+{
+	int depth = EXT3_I(inode)->i_depth;
+	int needed;
+	
+	/*
+	 * extent couldn't cross group, so we will modify
+	 * single bitmap block and single group descriptor
+	 */
+	needed = 2;
+
+	/*
+	 * if this is last extent in a leaf, then we have to
+	 * free leaf block and remove pointer from index above.
+	 * that pointer could be last in index block, so we'll
+	 * have to remove it too. this way we could modify/free
+	 * the whole path + root index (inode stored) will be
+	 * modified
+	 */
+	if (!path || (num == path->p_ext->e_num &&
+				path->p_ext == EXT_FIRST_EXTENT(path->p_hdr)))
+		needed += (depth * EXT3_ALLOC_NEEDED) + 1;
+
+	return needed;
+}
+
+void ext3_ext_truncate_leaf(handle_t *handle, struct inode *inode,
+				struct ext3_ext_path *path, int depth)
+{
+	unsigned blocksize = inode->i_sb->s_blocksize;
+	int last_block; 
+	int i, err, sf, num;
+
+	ext_debug(inode, "level %d - leaf\n", depth);
+	if (!path->p_hdr)
+		path->p_hdr =
+			(struct ext3_extent_header *) path->p_bh->b_data;
+
+	EXT_ASSERT(path->p_hdr->e_num <= path->p_hdr->e_max);
+	
+	last_block = (inode->i_size + blocksize-1)
+					>> EXT3_BLOCK_SIZE_BITS(inode->i_sb);
+	path->p_ext = EXT_LAST_EXTENT(path->p_hdr);
+	while (ext3_ext_more_leaves_to_truncate(inode, path)) {
+
+		/* what part of extent have to be freed? */
+		sf = last_block > path->p_ext->e_block ?
+			last_block : path->p_ext->e_block;
+
+		/* number of blocks from extent to be freed */
+		num = path->p_ext->e_block + path->p_ext->e_num - sf;
+
+		/* calc physical first physical block to be freed */
+		sf = path->p_ext->e_start + (sf - path->p_ext->e_block);
+
+		i = ext3_ext_calc_credits(inode, path, num);
+		handle = ext3_ext_journal_restart(handle, i);
+		if (IS_ERR(handle)) 
+			BUG();
+		
+		ext_debug(inode, "free extent %d:%d:%d -> free %d:%d\n",
+				path->p_ext->e_block, path->p_ext->e_start,
+				path->p_ext->e_num, sf, num);
+		for (i = 0; i < num; i++) {
+			struct buffer_head *bh =
+				sb_find_get_block(inode->i_sb, sf + i);
+			ext3_forget(handle, 0, inode, bh, sf + i);
+		}
+		ext3_free_blocks(handle, inode, sf, num);
+
+		/* collect extents usage stats */
+		spin_lock(&EXT3_SB(inode->i_sb)->s_ext_lock);
+		EXT3_SB(inode->i_sb)->s_ext_extents++;
+		EXT3_SB(inode->i_sb)->s_ext_blocks += num;
+		spin_unlock(&EXT3_SB(inode->i_sb)->s_ext_lock);
+
+		if ((err = ext3_ext_get_access(handle, inode, path)))
+			BUG();
+
+		/* reduce extent */
+		path->p_ext->e_num -= num;
+		if (path->p_ext->e_num == 0)
+			path->p_hdr->e_num--;
+
+		if ((err = ext3_ext_dirty(handle, inode, path)))
+			BUG();
+
+		path->p_ext--;
+	}
+	
+	/* if this leaf is free, then we should
+	 * remove it from index block above */
+	if (path->p_hdr->e_num == 0 && depth > 0) 
+		ext3_ext_remove_index(handle, inode, path);
+
+}
+
+static void ext3_ext_collect_stats(struct inode *inode)
+{
+	int depth;
+	
+	/* skip inodes with old good bitmap */
+	if (!(EXT3_I(inode)->i_flags & EXT3_EXTENTS_FL))
+		return;
+	
+	/* collect on full truncate only */
+	if (inode->i_size)
+		return;
+
+  
+	depth = EXT3_I(inode)->i_depth;
+	if (depth < EXT3_SB(inode->i_sb)->s_ext_mindepth)
+		 EXT3_SB(inode->i_sb)->s_ext_mindepth = depth;
+	if (depth > EXT3_SB(inode->i_sb)->s_ext_maxdepth)
+		 EXT3_SB(inode->i_sb)->s_ext_maxdepth = depth;
+	EXT3_SB(inode->i_sb)->s_ext_sum += depth;
+	EXT3_SB(inode->i_sb)->s_ext_count++;
+	
+}
+
+void ext3_ext_truncate(struct inode * inode)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct ext3_ext_path *path;
+	struct page * page;
+	handle_t *handle;
+	int i, depth;
+
+	ext3_ext_collect_stats(inode);
+
+	/*
+	 * We have to lock the EOF page here, because lock_page() nests
+	 * outside journal_start().
+	 */
+	if ((inode->i_size & (inode->i_sb->s_blocksize - 1)) == 0) {
+		/* Block boundary? Nothing to do */
+		page = NULL;
+	} else {
+		page = grab_cache_page(mapping,
+				inode->i_size >> PAGE_CACHE_SHIFT);
+		if (!page)
+			return;
+	}
+
+	/*
+	 * probably first extent we're gonna free will be last in block
+	 */
+	i = ext3_ext_calc_credits(inode, NULL, 0);
+	handle = ext3_journal_start(inode, i);
+	if (IS_ERR(handle)) {
+		if (page) {
+			clear_highpage(page);
+			flush_dcache_page(page);
+			unlock_page(page);
+			page_cache_release(page);
+		}
+		return;
+	}
+
+	if (page)
+		ext3_block_truncate_page(handle, page, mapping, inode->i_size);
+
+	/* 
+	 * TODO: optimization is possible here
+	 * probably we need not scaning at all,
+	 * because page truncation is enough
+	 */
+	if (ext3_orphan_add(handle, inode))
+		goto out_stop;
+
+	/* we have to know where to truncate from in crash case */
+	EXT3_I(inode)->i_disksize = inode->i_size;
+	ext3_mark_inode_dirty(handle, inode);
+
+	/*
+	 * we start scanning from right side freeing all the blocks
+	 * after i_size and walking into the deep
+	 */
+	i = 0;
+	depth = EXT3_I(inode)->i_depth;
+	path = kmalloc(sizeof(struct ext3_ext_path) * (depth + 1), GFP_KERNEL);
+	if (IS_ERR(path)) {
+		ext3_error(inode->i_sb, "ext3_ext_truncate",
+				"Can't allocate path array");
+		goto out_stop;
+	}
+	memset(path, 0, sizeof(struct ext3_ext_path) * (depth + 1));
+
+	path[i].p_hdr = (struct ext3_extent_header *) EXT3_I(inode)->i_data;
+	while (i >= 0) {
+		if (i == depth) {
+			/* this is leaf block */
+			ext3_ext_truncate_leaf(handle, inode, path + i, i);
+			/* root level have p_bh == NULL, brelse() eats this */
+			brelse(path[i].p_bh);
+			i--;
+			continue;
+		}
+		
+		/* this is index block */
+		if (!path[i].p_hdr) {
+			path[i].p_hdr =
+				(struct ext3_extent_header *) path[i].p_bh->b_data;
+			ext_debug(inode, "initialize header\n");
+		}
+
+		EXT_ASSERT(path[i].p_hdr->e_num <= path[i].p_hdr->e_max);
+		
+		if (!path[i].p_idx) {
+			/* this level hasn't touched yet */
+			path[i].p_idx = EXT_LAST_INDEX(path[i].p_hdr);
+			path[i].p_block = path[i].p_hdr->e_num + 1;
+			ext_debug(inode, "init index ptr: hdr 0x%p, num %d\n",
+					path[i].p_hdr, path[i].p_hdr->e_num);
+		} else {
+			/* we've already was here, see at next index */
+			path[i].p_idx--;
+		}
+
+		ext_debug(inode, "level %d - index, first 0x%p, cur 0x%p\n",
+				i, EXT_FIRST_INDEX(path[i].p_hdr),
+				path[i].p_idx);
+		if (ext3_ext_more_to_truncate(inode, path + i)) {
+			/* go to the next level */
+			ext_debug(inode, "move to level %d (block %d)\n", i+1,
+					path[i].p_idx->e_leaf);
+			memset(path+i+1, 0, sizeof(*path));
+			path[i+1].p_bh = sb_bread(inode->i_sb,
+							path[i].p_idx->e_leaf);
+			EXT_ASSERT(path[i + 1].p_bh);
+			i++;
+		} else {
+			/* we finish processing this index, go up */
+			if (path[i].p_hdr->e_num == 0 && i > 0) {
+				/* index is empty, remove it
+				 * handle must be already prepared by the
+				 * truncate_leaf()
+				 */
+				ext3_ext_remove_index(handle, inode, path + i);
+
+			}
+			/* root level have p_bh == NULL, brelse() eats this */
+			brelse(path[i].p_bh);
+			i--;
+			ext_debug(inode, "return to level %d\n", i);
+		}
+	}
+
+	/* TODO: flexible tree reduction should be here */
+	if (path->p_hdr->e_num == 0) {
+		/*
+		 * truncate to zero freed all the tree
+		 * so, we need to correct i_depth
+		 */
+		EXT3_I(inode)->i_depth = 0;
+		path->p_hdr->e_max = 0;
+		ext3_mark_inode_dirty(handle, inode);
+	}
+
+	kfree(path);
+
+	/* In a multi-transaction truncate, we only make the final
+	 * transaction synchronous */
+	if (IS_SYNC(inode))
+		handle->h_sync = 1;
+
+out_stop:
+	/*
+	 * If this was a simple ftruncate(), and the file will remain alive
+	 * then we need to clear up the orphan record which we created above.
+	 * However, if this was a real unlink then we were called by
+	 * ext3_delete_inode(), and we allow that function to clean up the
+	 * orphan info for us.
+	 */
+	if (inode->i_nlink)
+		ext3_orphan_del(handle, inode);
+
+	ext3_journal_stop(handle);
+}
+
+/*
+ * this routine calculate max number of blocks we could modify
+ * in order to allocate new block for an inode
+ */
+int ext3_ext_writepage_trans_blocks(struct inode *inode, int num)
+{
+	struct ext3_inode_info *ei = EXT3_I(inode);
+	int depth = ei->i_depth + 1;
+	int needed;
+	
+	/*
+	 * the worste case we're expecting is creation of the
+	 * new root (growing in depth) with index splitting
+	 * for splitting we have to consider depth + 1 because
+	 * previous growing could increase it
+	 */
+
+	/* 
+	 * growing in depth:
+	 * block allocation + new root + old root
+	 */
+	needed = EXT3_ALLOC_NEEDED + 2;
+
+	/* index split. we may need:
+	 *   allocate intermediate indexes and new leaf
+	 *   change two blocks at each level, but root
+	 *   modify root block (inode)
+	 */
+	needed += (depth * EXT3_ALLOC_NEEDED) + (2 * depth) + 1;
+
+	/* caller want to allocate num blocks */
+	needed *= num;
+	
+#ifdef CONFIG_QUOTA
+	/* 
+	 * FIXME: real calculation should be here
+	 * it depends on blockmap format of qouta file
+	 */
+	needed += 2 * EXT3_SINGLEDATA_TRANS_BLOCKS;
+#endif
+
+	return needed;
+}
+
+void ext3_ext_init(struct super_block *sb)
+{
+	/*
+	 * possible initialization would be here
+	 */
+
+	if (test_opt(sb, EXTENTS))
+		printk("EXT3-fs: file extents enabled\n");
+	spin_lock_init(&EXT3_SB(sb)->s_ext_lock);
+}
+
+void ext3_ext_release(struct super_block *sb)
+{
+	struct ext3_sb_info *sbi = EXT3_SB(sb);
+
+	/* show collected stats */
+	if (sbi->s_ext_count && sbi->s_ext_extents)
+		printk("EXT3-fs: min depth - %d, max depth - %d, "
+				"ave. depth - %d, ave. blocks/extent - %d\n",
+				sbi->s_ext_mindepth,
+				sbi->s_ext_maxdepth,
+				sbi->s_ext_sum / sbi->s_ext_count,
+				sbi->s_ext_blocks / sbi->s_ext_extents);
+}
+
diff -puN fs/ext3/ialloc.c~ext3-extents fs/ext3/ialloc.c
--- linux-2.6.0-test2-mm3/fs/ext3/ialloc.c~ext3-extents	2003-08-03 17:28:41.000000000 +0400
+++ linux-2.6.0-test2-mm3-alexey/fs/ext3/ialloc.c	2003-08-03 17:28:41.000000000 +0400
@@ -600,6 +600,8 @@ got:
 		DQUOT_FREE_INODE(inode);
 		goto fail2;
   	}
+	if (test_opt(sb, EXTENTS))
+		EXT3_I(inode)->i_flags |= EXT3_EXTENTS_FL;
 	err = ext3_mark_inode_dirty(handle, inode);
 	if (err) {
 		ext3_std_error(sb, err);
diff -puN fs/ext3/inode.c~ext3-extents fs/ext3/inode.c
--- linux-2.6.0-test2-mm3/fs/ext3/inode.c~ext3-extents	2003-08-03 17:28:41.000000000 +0400
+++ linux-2.6.0-test2-mm3-alexey/fs/ext3/inode.c	2003-08-09 15:52:47.000000000 +0400
@@ -862,6 +862,15 @@ changed:
 	goto reread;
 }
 
+static inline int
+ext3_get_block_wrap(handle_t *handle, struct inode *inode, sector_t block,
+		struct buffer_head *bh, int create, int extend_disksize)
+{
+	if (EXT3_I(inode)->i_flags & EXT3_EXTENTS_FL)
+		return ext3_ext_get_block(handle, inode, block, bh, create, 1);
+	return ext3_get_block_handle(handle, inode, block, bh, create, 1);
+}
+
 static int ext3_get_block(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
@@ -872,7 +881,7 @@ static int ext3_get_block(struct inode *
 		handle = ext3_journal_current_handle();
 		J_ASSERT(handle != 0);
 	}
-	ret = ext3_get_block_handle(handle, inode, iblock,
+	ret = ext3_get_block_wrap(handle, inode, iblock,
 				bh_result, create, 1);
 	return ret;
 }
@@ -899,7 +908,7 @@ ext3_direct_io_get_blocks(struct inode *
 		}
 	}
 	if (ret == 0)
-		ret = ext3_get_block_handle(handle, inode, iblock,
+		ret = ext3_get_block_wrap(handle, inode, iblock,
 					bh_result, create, 0);
 	if (ret == 0)
 		bh_result->b_size = (1 << inode->i_blkbits);
@@ -921,7 +930,7 @@ struct buffer_head *ext3_getblk(handle_t
 	dummy.b_state = 0;
 	dummy.b_blocknr = -1000;
 	buffer_trace_init(&dummy.b_history);
-	*errp = ext3_get_block_handle(handle, inode, block, &dummy, create, 1);
+	*errp = ext3_get_block_wrap(handle, inode, block, &dummy, create, 1);
 	if (!*errp && buffer_mapped(&dummy)) {
 		struct buffer_head *bh;
 		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
@@ -1663,7 +1672,7 @@ void ext3_set_aops(struct inode *inode)
  * This required during truncate. We need to physically zero the tail end
  * of that block so it doesn't yield old data if the file is later grown.
  */
-static int ext3_block_truncate_page(handle_t *handle, struct page *page,
+int ext3_block_truncate_page(handle_t *handle, struct page *page,
 		struct address_space *mapping, loff_t from)
 {
 	unsigned long index = from >> PAGE_CACHE_SHIFT;
@@ -2145,6 +2154,9 @@ void ext3_truncate(struct inode * inode)
 
 	ext3_discard_prealloc(inode);
 
+	if (EXT3_I(inode)->i_flags & EXT3_EXTENTS_FL)
+		return ext3_ext_truncate(inode);
+
 	/*
 	 * We have to lock the EOF page here, because lock_page() nests
 	 * outside journal_start().
@@ -2540,6 +2552,7 @@ void ext3_read_inode(struct inode * inod
 	ei->i_prealloc_count = 0;
 #endif
 	ei->i_block_group = iloc.block_group;
+	ei->i_depth = raw_inode->osd2.linux2.l_i_depth;
 
 	/*
 	 * NOTE! The in-memory inode i_data array is in little-endian order
@@ -2642,6 +2655,7 @@ static int ext3_do_update_inode(handle_t
 	raw_inode->i_frag = ei->i_frag_no;
 	raw_inode->i_fsize = ei->i_frag_size;
 #endif
+ 	raw_inode->osd2.linux2.l_i_depth = ei->i_depth;
 	raw_inode->i_file_acl = cpu_to_le32(ei->i_file_acl);
 	if (!S_ISREG(inode->i_mode)) {
 		raw_inode->i_dir_acl = cpu_to_le32(ei->i_dir_acl);
@@ -2856,6 +2870,9 @@ int ext3_writepage_trans_blocks(struct i
 	int indirects = (EXT3_NDIR_BLOCKS % bpp) ? 5 : 3;
 	int ret;
 
+	if (EXT3_I(inode)->i_flags & EXT3_EXTENTS_FL)
+		return ext3_ext_writepage_trans_blocks(inode, bpp);
+
 	if (ext3_should_journal_data(inode))
 		ret = 3 * (bpp + indirects) + 2;
 	else
diff -puN fs/ext3/Makefile~ext3-extents fs/ext3/Makefile
--- linux-2.6.0-test2-mm3/fs/ext3/Makefile~ext3-extents	2003-08-03 17:28:41.000000000 +0400
+++ linux-2.6.0-test2-mm3-alexey/fs/ext3/Makefile	2003-08-03 17:33:27.000000000 +0400
@@ -5,7 +5,7 @@
 obj-$(CONFIG_EXT3_FS) += ext3.o
 
 ext3-y	:= balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
-	   ioctl.o namei.o super.o symlink.o hash.o
+	   ioctl.o namei.o super.o symlink.o hash.o extents.o
 
 ext3-$(CONFIG_EXT3_FS_XATTR)	 += xattr.o xattr_user.o xattr_trusted.o
 ext3-$(CONFIG_EXT3_FS_POSIX_ACL) += acl.o
diff -puN fs/ext3/super.c~ext3-extents fs/ext3/super.c
--- linux-2.6.0-test2-mm3/fs/ext3/super.c~ext3-extents	2003-08-03 17:28:41.000000000 +0400
+++ linux-2.6.0-test2-mm3-alexey/fs/ext3/super.c	2003-08-10 10:30:05.000000000 +0400
@@ -446,6 +446,7 @@ void ext3_put_super (struct super_block 
 	struct ext3_super_block *es = sbi->s_es;
 	int i;
 
+	ext3_ext_release(sb);
 	ext3_xattr_put_super(sb);
 	journal_destroy(sbi->s_journal);
 	if (!(sb->s_flags & MS_RDONLY)) {
@@ -504,6 +505,8 @@ static struct inode *ext3_alloc_inode(st
 	ei->i_default_acl = EXT3_ACL_NOT_CACHED;
 #endif
 	ei->vfs_inode.i_version = 1;
+	ei->i_depth = 0;
+	sema_init(&ei->i_ext_sem, 1);
 	return &ei->vfs_inode;
 }
 
@@ -656,6 +659,12 @@ static int parse_options (char * options
 			continue;
 		if ((value = strchr (this_char, '=')) != NULL)
 			*value++ = 0;
+		if (!strcmp (this_char, "extents"))
+			set_opt (sbi->s_mount_opt, EXTENTS);
+		else
+		if (!strcmp (this_char, "extdebug"))
+			set_opt (sbi->s_mount_opt, EXTDEBUG);
+		else
 #ifdef CONFIG_EXT3_FS_XATTR
 		if (!strcmp (this_char, "user_xattr"))
 			set_opt (sbi->s_mount_opt, XATTR_USER);
@@ -1442,6 +1451,8 @@ static int ext3_fill_super (struct super
 	percpu_counter_mod(&sbi->s_dirs_counter,
 		ext3_count_dirs(sb));
 
+	ext3_ext_init(sb);
+
 	return 0;
 
 failed_mount3:
diff -puN include/linux/ext3_fs.h~ext3-extents include/linux/ext3_fs.h
--- linux-2.6.0-test2-mm3/include/linux/ext3_fs.h~ext3-extents	2003-08-03 17:28:41.000000000 +0400
+++ linux-2.6.0-test2-mm3-alexey/include/linux/ext3_fs.h	2003-08-10 10:25:56.000000000 +0400
@@ -186,6 +186,7 @@ struct ext3_group_desc
 #define EXT3_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
 #define EXT3_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
 #define EXT3_RESERVED_FL		0x80000000 /* reserved for ext3 lib */
+#define EXT3_EXTENTS_FL			0x00080000 /* Inode uses extents */
 
 #define EXT3_FL_USER_VISIBLE		0x0003DFFF /* User visible flags */
 #define EXT3_FL_USER_MODIFIABLE		0x000380FF /* User modifiable flags */
@@ -244,7 +245,7 @@ struct ext3_inode {
 		struct {
 			__u8	l_i_frag;	/* Fragment number */
 			__u8	l_i_fsize;	/* Fragment size */
-			__u16	i_pad1;
+			__u16	l_i_depth;
 			__u16	l_i_uid_high;	/* these 2 fields    */
 			__u16	l_i_gid_high;	/* were reserved2[0] */
 			__u32	l_i_reserved2;
@@ -324,6 +325,8 @@ struct ext3_inode {
 #define EXT3_MOUNT_NO_UID32		0x2000  /* Disable 32-bit UIDs */
 #define EXT3_MOUNT_XATTR_USER		0x4000	/* Extended user attributes */
 #define EXT3_MOUNT_POSIX_ACL		0x8000	/* POSIX Access Control Lists */
+#define EXT3_MOUNT_EXTENTS		0x10000	/* Extents support */
+#define EXT3_MOUNT_EXTDEBUG		0x20000	/* Extents debug */
 
 /* Compatibility, for having both ext2_fs.h and ext3_fs.h included at once */
 #ifndef _LINUX_EXT2_FS_H
@@ -733,6 +736,11 @@ extern int ext3_change_inode_journal_fla
 extern void ext3_truncate (struct inode *);
 extern void ext3_set_inode_flags(struct inode *);
 extern void ext3_set_aops(struct inode *inode);
+extern int ext3_block_truncate_page(handle_t *handle, struct page *page,
+					struct address_space *mapping, loff_t from);
+extern int ext3_forget(handle_t *handle, int is_metadata,
+		       struct inode *inode, struct buffer_head *bh,
+		       int blocknr);
 
 /* ioctl.c */
 extern int ext3_ioctl (struct inode *, struct file *, unsigned int,
@@ -789,6 +797,13 @@ extern struct inode_operations ext3_spec
 extern struct inode_operations ext3_symlink_inode_operations;
 extern struct inode_operations ext3_fast_symlink_inode_operations;
 
+/* extents.c */
+extern int ext3_ext_writepage_trans_blocks(struct inode *, int);
+extern int ext3_ext_get_block(handle_t *, struct inode *, sector_t,
+				struct buffer_head *, int, int);
+extern void ext3_ext_truncate(struct inode *);
+extern void ext3_ext_init(struct super_block *);
+extern void ext3_ext_release(struct super_block *);
 
 #endif	/* __KERNEL__ */
 
diff -puN include/linux/ext3_fs_i.h~ext3-extents include/linux/ext3_fs_i.h
--- linux-2.6.0-test2-mm3/include/linux/ext3_fs_i.h~ext3-extents	2003-08-03 17:41:58.000000000 +0400
+++ linux-2.6.0-test2-mm3-alexey/include/linux/ext3_fs_i.h	2003-08-10 13:23:24.000000000 +0400
@@ -108,6 +108,10 @@ struct ext3_inode_info {
 	 */
 	struct rw_semaphore truncate_sem;
 	struct inode vfs_inode;
+
+	/* extents-related data */
+	struct semaphore i_ext_sem;
+	__u16 i_depth;
 };
 
 #endif	/* _LINUX_EXT3_FS_I */
diff -puN include/linux/ext3_fs_sb.h~ext3-extents include/linux/ext3_fs_sb.h
--- linux-2.6.0-test2-mm3/include/linux/ext3_fs_sb.h~ext3-extents	2003-08-03 17:54:55.000000000 +0400
+++ linux-2.6.0-test2-mm3-alexey/include/linux/ext3_fs_sb.h	2003-08-10 13:24:09.000000000 +0400
@@ -68,6 +68,16 @@ struct ext3_sb_info {
 	struct timer_list turn_ro_timer;	/* For turning read-only (crash simulation) */
 	wait_queue_head_t ro_wait_queue;	/* For people waiting for the fs to go read-only */
 #endif
+
+	/* extents */
+	int s_ext_debug;
+	int s_ext_mindepth;
+	int s_ext_maxdepth;
+	int s_ext_sum;
+	int s_ext_count;
+	spinlock_t s_ext_lock;
+	int s_ext_extents;
+	int s_ext_blocks;
 };
 
 #endif	/* _LINUX_EXT3_FS_SB */

_

--=-=-=--

