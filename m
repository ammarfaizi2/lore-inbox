Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751531AbWHXNoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbWHXNoc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWHXNoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:44:32 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:32491 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751531AbWHXNoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:44:30 -0400
Date: Thu, 24 Aug 2006 15:44:30 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: fsdevel@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: [RFC] LogFS
Message-ID: <20060824134430.GB17132@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the last 16 month, I've been hacking on a small filesystem.  It
has progress far enough that it shouldn't be a total embarrassment to
show the code, but still needs quite a bit of work.

Anyhow, in case people are interested to have a look... comments are
very welcome.

Jörn

-- 
...one more straw can't possibly matter...
-- Kirby Bakken

 fs/Kconfig           |   13 
 fs/Makefile          |    1 
 fs/logfs/CREDITS     |   18 
 fs/logfs/Makefile    |    9 
 fs/logfs/NAMES       |   32 +
 fs/logfs/dir.c       |  464 +++++++++++++++++++++++
 fs/logfs/file.c      |   82 ++++
 fs/logfs/gc.c        |  517 ++++++++++++++++++++++++++
 fs/logfs/inode.c     |  385 +++++++++++++++++++
 fs/logfs/journal.c   |  216 +++++++++++
 fs/logfs/logfs.h     |  431 ++++++++++++++++++++++
 fs/logfs/readwrite.c |  992
+++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/logfs/super.c     |  435 ++++++++++++++++++++++
 13 files changed, 3595 insertions(+)

--- logfs3/fs/Kconfig~logfs	2006-08-24 15:35:33.000000000 +0200
+++ logfs3/fs/Kconfig	2006-08-24 15:39:42.000000000 +0200
@@ -1230,6 +1230,19 @@ config JFFS2_CMODE_SIZE
 
 endchoice
 
+config LOGFS
+	tristate "Log Filesystem (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  Successor of JFFS2, using explicit filesystem hierarchy.
+	  Continuing with the long tradition of calling the filesystem
+	  exactly what it is not, LogFS is a journaled filesystem,
+	  while JFFS and JFFS2 were true log-structured filesystems.
+	  The hybrid structure of journaled filesystems promise to
+	  scale better to larger sized.
+
+	  If unsure, say N.
+
 config CRAMFS
 	tristate "Compressed ROM file system support (cramfs)"
 	select ZLIB_INFLATE
--- logfs3/fs/Makefile~logfs	2006-08-24 15:35:33.000000000 +0200
+++ logfs3/fs/Makefile	2006-08-24 15:39:42.000000000 +0200
@@ -84,6 +84,7 @@ obj-$(CONFIG_UFS_FS)		+= ufs/
 obj-$(CONFIG_EFS_FS)		+= efs/
 obj-$(CONFIG_JFFS_FS)		+= jffs/
 obj-$(CONFIG_JFFS2_FS)		+= jffs2/
+obj-$(CONFIG_LOGFS)		+= logfs/
 obj-$(CONFIG_AFFS_FS)		+= affs/
 obj-$(CONFIG_ROMFS_FS)		+= romfs/
 obj-$(CONFIG_QNX4FS_FS)		+= qnx4/
--- /dev/null	2006-08-15 20:12:53.000000000 +0200
+++ logfs3/fs/logfs/CREDITS	2006-08-24 15:39:42.000000000 +0200
@@ -0,0 +1,18 @@
+Testing
+2005-2006	Joern Engel
+2006		Arnd Bergmann
+
+Design (in rough chronological order - and some may be unaware of the fact):
+1991		Mendel Rosenblum
+1991		John K. Ousterhout
+2005-2006	Joern Engel
+2005-2006	Arnd Bergmann
+2005		David Woodhouse
+2005-2006	Dirk Bolte
+2005		Carsten Otte
+2006		Martin Schwidefski
+2006		Ferenc Havasi
+2006		Hubertus Franke
+
+Implementation:
+2005-2006	Joern Engel
--- /dev/null	2006-08-15 20:12:53.000000000 +0200
+++ logfs3/fs/logfs/NAMES	2006-08-24 15:39:42.000000000 +0200
@@ -0,0 +1,32 @@
+This filesystem started with the codename "Logfs", which was actually
+a joke at the time.  Logfs was to replace JFFS2, the journaling flash
+filesystem (version 2).  JFFS2 was actually a log structured
+filesystem in its purest form, so the name described just what it was
+not.  Logfs was planned as a journaling filesystem, so its name would
+be in the same tradition of non-description.
+
+Apart from the joke, "Logfs" was only intended as a codename, later to
+be replaced by something better.  Some ideas from various people were:
+logfs
+jffs3
+jefs
+engelfs
+poofs
+crapfs
+sweetfs
+cutefs
+dynamic journaling fs - djofs
+tfsfkal - the file system formerly known as logfs
+
+Later it turned out that while having a journal, Logfs has borrowed so
+many concepts from log structured filesystems that the name actually
+made some sense.
+
+Yet later, Arnd noticed that Logfs was to scale logarithmically with
+increasing flash sizes, where JFFS2 scales linearly.  What a nice
+coincidence.  Even better, its successor can be called Log2fs,
+emphasizing this point.
+
+So to this day, I still like "Logfs" and cannot come up with a better
+name.  And unless someone has the stroke of a genius or there is
+massive opposition against this name, I'd like to just keep it.
--- /dev/null	2006-08-15 20:12:53.000000000 +0200
+++ logfs3/fs/logfs/Makefile	2006-08-24 15:39:42.000000000 +0200
@@ -0,0 +1,9 @@
+obj-$(CONFIG_LOGFS)	+= logfs.o
+
+logfs-y	+= dir.o
+logfs-y	+= file.o
+logfs-y	+= gc.o
+logfs-y	+= inode.o
+logfs-y	+= journal.o
+logfs-y	+= readwrite.o
+logfs-y	+= super.o
--- /dev/null	2006-08-15 20:12:53.000000000 +0200
+++ logfs3/fs/logfs/logfs.h	2006-08-24 15:39:42.000000000 +0200
@@ -0,0 +1,431 @@
+#ifndef logfs_h
+#define logfs_h
+
+#include <linux/kernel.h>
+#include <linux/kallsyms.h>
+
+/**
+ * Throughout the logfs code, we're constantly dealing with blocks at
+ * various positions or offsets.  To remove confusion, we stricly
+ * distinguish between a "position" - the logical position within a
+ * file and an "offset" - the physical location within the device.
+ *
+ * Any usage of the term offset for a logical location or position for
+ * a physical one is a bug and should get fixed.
+ */
+
+/**
+ * Block are allocated in one of several segments depending on their
+ * level.  The following levels are used:
+ * 0-1	- reserved
+ * 2	- gc recycled blocks
+ * 3	- new data blocks
+ * 4	- replacement blocks
+ * 5	- i1 indirect blocks
+ * 6	- i2 indirect blocks
+ * 7	- i3 indirect blocks
+ * 8	- i4 indirect blocks
+ * 9	- i5 indirect blocks
+ * 10	- ifile data blocks
+ * 11	- ifile i1 indirect blocks
+ * 12	- ifile i2 indirect blocks
+ * 13	- ifile i3 indirect blocks
+ * 14	- ifile i4 indirect blocks
+ * 15	- ifile i5 indirect blocks
+ *
+ * Levels 5-15 are necessary for robust gc operations and help seperate
+ * short-lived metadata from longer-lived file data.  Further, file data
+ * is seperated into several segments based on simple heuristics.  Old
+ * data recycled during gc operation is expected to be long-lived.  New
+ * data is of uncertain life expectancy.  New data used to replace older
+ * blocks in existing files is expected to be short-lived.
+ */
+
+
+typedef __be16 be16;
+typedef __be32 be32;
+typedef __be64 be64;
+
+typedef u64 pos_t;
+
+static inline pos_t be64_to_pos(const be64 p)
+{
+	return (__force pos_t) be64_to_cpu(p);
+}
+
+static inline be64 pos_to_be64(const pos_t p)
+{
+	return cpu_to_be64((__force u64) p);
+}
+
+#define packed __attribute__((__packed__))
+
+
+#undef TRACE
+#if 0
+#define TRACE() _TRACE()
+#else
+#define TRACE()
+#endif
+
+#define _TRACE() do {						\
+	printk("trace: %s:%d: ", __FILE__, __LINE__);		\
+	print_symbol("%s", (long)__builtin_return_address(0));	\
+	printk("->%s\n", __func__);				\
+} while(0)
+
+
+#define LOGFS_MAGIC 0xb21f205ac97e8168ull
+#define LOGFS_MAGIC_U32 0xc97e8168ull
+
+
+#define LOGFS_BLOCK_SECTORS	(8)
+#define LOGFS_BLOCK_BITS	(9)	/* 512 pointers, used for shifts */
+#define LOGFS_BLOCKSIZE		(4096ull)
+#define LOGFS_BLOCK_FACTOR (LOGFS_BLOCKSIZE / sizeof(u64))
+#define LOGFS_BLOCK_MASK (LOGFS_BLOCK_FACTOR-1)
+
+#define I0_BLOCKS	(4+16)
+#define I1_BLOCKS LOGFS_BLOCK_FACTOR
+#define I2_BLOCKS (LOGFS_BLOCK_FACTOR * I1_BLOCKS)
+#define I3_BLOCKS (LOGFS_BLOCK_FACTOR * I2_BLOCKS)
+#define I4_BLOCKS (LOGFS_BLOCK_FACTOR * I3_BLOCKS)
+#define I5_BLOCKS (LOGFS_BLOCK_FACTOR * I4_BLOCKS)
+
+#define I1_INDEX	(4+16)
+#define I2_INDEX	(5+16)
+#define I3_INDEX	(6+16)
+#define I4_INDEX	(7+16)
+#define I5_INDEX	(8+16)
+
+#define LOGFS_EMBEDDED_FIELDS	(9+16)
+
+#define LOGFS_EMBEDDED_SIZE	(LOGFS_EMBEDDED_FIELDS * sizeof(u64))
+#define LOGFS_I0_SIZE (I0_BLOCKS * LOGFS_BLOCKSIZE)
+#define LOGFS_I1_SIZE (I1_BLOCKS * LOGFS_BLOCKSIZE)
+#define LOGFS_I2_SIZE (I2_BLOCKS * LOGFS_BLOCKSIZE)
+#define LOGFS_I3_SIZE (I3_BLOCKS * LOGFS_BLOCKSIZE)
+#define LOGFS_I4_SIZE (I4_BLOCKS * LOGFS_BLOCKSIZE)
+#define LOGFS_I5_SIZE (I5_BLOCKS * LOGFS_BLOCKSIZE)
+
+#define LOGFS_MAX_INDIRECT	(5)
+#define LOGFS_MAX_LEVELS	(3)
+//#define LOGFS_MAX_LEVELS	(LOGFS_MAX_INDIRECT + 1)
+#define LOGFS_SEGMENTS		(2 * LOGFS_MAX_LEVELS)
+
+
+struct logfs_disk_super {
+	be64	ds_magic;
+	be32	ds_segment_size;
+	be32	ds_block_size;
+
+	be64	ds_journal_ofs;
+	be64	ds_journal_len;
+
+	u8	reserved;
+	u8	ds_ifile_levels;	/* max level of ifile */
+	u8	ds_iblock_levels;	/* max level of regular files */
+	u8	ds_data_levels;		/* number of segments to leaf blocks */
+	be64	ds_root_reserve;
+
+	be64	ds_filesystem_size;
+	be64	ds_feature_incompat;
+
+	be64	ds_feature_ro_compat;
+	be64	ds_feature_compat;
+
+	be32	ds_anchor_size;
+	be32	ds_sum_start;
+}packed;
+
+
+#define LOGFS_IF_VALID		0x00000001 /* inode exists */
+#define LOGFS_IF_EMBEDDED	0x00000002 /* data embedded in block pointers */
+#define LOGFS_IF_INVALID	0x80000000 /* inode does not exist */
+struct logfs_disk_inode {
+	be16	di_mode;
+	be16	di_pad;
+	be32	di_flags;
+	be32	di_uid;
+	be32	di_gid;
+
+	be64	di_ctime;
+	be64	di_mtime;
+
+	be32	di_refcount;
+	be32	di_generation;	/* for nfs file handles */
+	be64	di_blocks;
+
+	be64	di_size;
+	be64	di_data[LOGFS_EMBEDDED_FIELDS];
+}packed;
+
+
+#define LOGFS_MAX_NAMELEN 245
+struct logfs_disk_dentry {
+	be64	ino;		/* inode pointer */
+	be16	namelen;
+	u8	type;
+	u8	name[LOGFS_MAX_NAMELEN];
+}packed;
+
+
+struct logfs_disk_block {
+	be64	ino;
+	be64	pos;
+}packed;
+
+
+struct logfs_disk_sum {
+	/* footer */
+	be32	erase_count;
+	u8	level;
+	u8	pad[3];
+	union {
+		be64	ofs;
+		be64	gec;
+	};
+	struct logfs_disk_block blocks[0];
+}packed;
+
+
+struct logfs_anchor {
+	be64	da_maxec;	/* maximal erase count */
+	be64	da_gec;		/* global erase count */
+
+	be64	da_sweeper;	/* current position of gc "sweeper" */
+	be64	da_last_ino;
+
+	be64	da_size;
+	be64	da_data[LOGFS_EMBEDDED_FIELDS];
+}packed;
+
+
+enum {
+	JE_ANCHOR	= 1,
+	JE_SPILLOUT	= 2,
+};
+
+
+struct logfs_journal_entry {
+	be16	je_type;
+	be16	pad0;
+	be32	pad1;
+	be64	je_version;
+	union {
+		struct logfs_anchor da;
+	};
+}packed;
+
+
+////////////////////////////////////////////////////////////////////////////////
+////////////////////////////////////////////////////////////////////////////////
+
+
+#define LOGFS_SUPER(sb) ((struct logfs_super*)(sb->s_fs_info))
+#define LOGFS_INODE(inode) container_of(inode, struct logfs_inode, vfs_inode)
+
+
+			/*	0	reserved for gc markers */
+#define LOGFS_INO_MASTER	1	/* inode file */
+#define LOGFS_INO_ROOT		2	/* root directory */
+#define LOGFS_INO_JOURNAL	3	/* journal */
+#define LOGFS_INO_ATIME		4	/* atime for all inodes */
+#define LOGFS_INO_BAD_BLOCKS	5	/* bad blocks */
+#define LOGFS_INO_OBSOLETE	6	/* obsolete block count */
+#define LOGFS_INO_ERASE_COUNT	7	/* erase count */
+#define LOGFS_RESERVED_INOS	16
+
+
+struct logfs_block {
+	u64	ino;
+	pos_t	pos;
+};
+
+
+struct logfs_super;
+struct logfs_segment {
+	struct logfs_super *super;
+	int	active;
+	u64	ofs;
+	u16	cur_block;
+	/* footer */
+	u32	erase_count;
+	u8	level;
+	struct logfs_block blocks[0];
+};
+
+
+struct logfs_super {
+	struct super_block *s_sb;		/* should get removed... */
+	struct mtd_info	*s_mtd;			/* underlying device */
+	struct inode	*s_master_inode;	/* ifile */
+	/* gc.c fields */
+	long	 s_segsize;			/* size of a segment */
+	long	 s_no_segs;			/* segments on device */
+	long	 s_blocksize;			/* size of a block */
+	long	 s_no_blocks;			/* blocks per segment */
+	u64	 s_last;			/* position of last used seg */
+	u64	 s_size;			/* filesystem size */
+	void	*s_gc_buf;			/* copy buf for cleansing */
+	struct logfs_segment *s_segs[LOGFS_SEGMENTS];	/* segment array */
+	u8	*s_valid_count;			/* # of valid block per seg */
+	long	 s_no_free_segs;		/* # of free segments */
+	u64	 s_maxec;			/* max erase count */
+	u64	 s_gec;				/* global erase count */
+	u64	 s_sweeper;			/* current sweeper pos */
+	u8	 s_ifile_levels;		/* max level of ifile */
+	u8	 s_iblock_levels;		/* max level of regular files */
+	u8	 s_data_levels;			/* # of segments to leaf block*/
+	u8	 s_total_levels;		/* sum of above three */
+	/* inode.c fields */
+	spinlock_t s_ino_lock;			/* lock s_last_ino on 32bit */
+	u64	 s_last_ino;			/* highest ino used */
+	struct inode *s_write_inode;		/* inode currently written */
+	struct mutex s_write_inode_mutex;	/* only one deletion at once */
+	/* journal.c fields */
+	struct mutex s_log_sem;
+	struct logfs_journal_entry *s_je;	/* new journal entry */
+	u64	 s_log_ofs;
+	u64	 s_log_len;
+	u64	 s_last_version;
+	u64	 s_anchor_ofs;
+	u32	 s_anchor_size;			/* size of anchor */
+	u32	 s_sum_start;			/* start of summary in anchor */
+	/* readwrite.c fields */
+	struct mutex s_r_sem;
+	struct mutex s_w_sem;
+	be64	*s_rblock;
+	be64	*s_wblock[LOGFS_MAX_INDIRECT+1];
+	u64	 s_free;			/* number of free blocks */
+	u64	 s_gc_reserve;
+	u64	 s_root_reserve;
+};
+
+
+struct logfs_inode {
+	struct inode vfs_inode;
+	u64 li_data[LOGFS_EMBEDDED_FIELDS];
+	u32 li_flags;
+	u64 li_blocks;
+};
+
+
+static inline size_t logfs_summary_size(struct logfs_super *super)
+{
+	return super->s_no_blocks * sizeof(struct logfs_block);
+}
+static inline size_t logfs_segstruct_size(struct logfs_super *super)
+{
+	return sizeof(struct logfs_segment) + logfs_summary_size(super);
+}
+
+
+static inline pgoff_t logfs_index(u64 pos)
+{
+	return pos / LOGFS_BLOCKSIZE;
+}
+
+
+static inline struct inode *logfs_iget(struct super_block *sb, ino_t ino)
+{
+	struct logfs_super *super = LOGFS_SUPER(sb);
+	if (ino == LOGFS_INO_MASTER) /* never iget this "inode"! */
+		return super->s_master_inode;
+	return iget(sb, ino);
+}
+static inline void logfs_iput(struct inode *inode)
+{
+	if (inode->i_ino == LOGFS_INO_MASTER) /* never iput it either! */
+		return;
+	iput(inode);
+}
+
+
+static inline struct logfs_disk_sum *alloc_disk_sum(struct logfs_super *super)
+{
+	return kmalloc(logfs_summary_size(super), GFP_ATOMIC);
+}
+static inline void free_disk_sum(struct logfs_disk_sum *sum)
+{
+	kfree(sum);
+}
+
+
+/* dir.c */
+extern struct inode_operations logfs_dir_iops;
+extern struct file_operations logfs_dir_fops;
+
+
+/* file.c */
+extern struct inode_operations logfs_reg_iops;
+extern struct file_operations logfs_reg_fops;
+extern struct address_space_operations logfs_reg_aops;
+
+int logfs_setattr(struct dentry *dentry, struct iattr *iattr);
+
+
+/* gc.c */
+void logfs_gc_pass(struct logfs_super *super);
+s64 logfs_get_free_block(struct logfs_super*super, int level, u64 ino, pos_t pos);
+int logfs_init_gc(struct logfs_super *super);
+void logfs_cleanup_gc(struct logfs_super *super);
+/* still gc.c, but should get moved to segment.c */
+int logfs_erase_segment(struct logfs_super *super, u64 ofs);
+
+void logfs_disk_to_sum(struct logfs_super *super, struct logfs_segment *seg,
+		struct logfs_disk_sum *sum);
+void logfs_sum_to_disk(struct logfs_super *super, struct logfs_segment *seg,
+		struct logfs_disk_sum *sum);
+int logfs_init_segments(struct logfs_super *super);
+void logfs_cleanup_segments(struct logfs_super *super);
+
+
+/* inode.c */
+extern struct super_operations logfs_super_operations;
+
+struct inode *logfs_new_inode(struct inode *dir, int mode);
+struct inode *logfs_new_master_inode(struct super_block *sb);
+int logfs_init_inode_cache(void);
+void logfs_destroy_inode_cache(void);
+
+
+/* journal.c */
+int logfs_write_anchor(struct inode *inode);
+int logfs_init_log(struct super_block *sb);
+void logfs_cleanup_log(struct super_block *sb);
+
+
+/* readwrite.c */
+int logfs_inode_read(struct inode *inode, void *buf, size_t n, loff_t _pos);
+int logfs_inode_write_nolock(struct inode *inode, const void *buf, size_t n,
+		loff_t _pos);
+int logfs_inode_write(struct inode *inode, const void *buf, size_t n,
+		loff_t pos);
+int logfs_inode_write_loop(struct inode *inode, const void *buf, size_t n,
+		loff_t _pos);
+
+int logfs_readpage(struct file *file, struct page *page);
+int logfs_write_buf(struct inode *inode, pgoff_t index, void *buf);
+int logfs_rewrite_block(struct inode *inode, pgoff_t index, u64 ofs, void *buf);
+int logfs_is_valid_block(struct super_block *sb, u64 ofs, u64 ino, u64 pos);
+void logfs_truncate(struct inode *inode);
+
+int logfs_init_rw(struct logfs_super *super);
+void logfs_cleanup_rw(struct logfs_super *super);
+void logfs_set_blocks(struct inode *inode, u64 no);
+
+/* super.c */
+int mtderase(struct mtd_info *mtd, loff_t ofs, size_t len);
+int mtdread(struct mtd_info *mtd, loff_t ofs, size_t len, void *buf);
+int mtdwrite(struct mtd_info *mtd, loff_t ofs, size_t len, void *buf);
+int logfs_statfs(struct dentry *dentry, struct kstatfs *stats);
+
+
+/* symlink.c */
+
+
+#define EOF	256
+
+
+#endif
--- /dev/null	2006-08-15 20:12:53.000000000 +0200
+++ logfs3/fs/logfs/dir.c	2006-08-24 15:39:42.000000000 +0200
@@ -0,0 +1,464 @@
+#include <linux/fs.h>
+#include <linux/mtd/mtd.h>
+
+#include "logfs.h"
+
+static inline u8 logfs_type(struct inode *inode)
+{
+	return (inode->i_mode >> 12) & 15;
+}
+
+
+static inline void logfs_inc_count(struct inode *inode)
+{
+	inode->i_nlink++;
+	mark_inode_dirty(inode);
+}
+
+
+static inline void logfs_dec_count(struct inode *inode)
+{
+	inode->i_nlink--;
+	mark_inode_dirty(inode);
+}
+
+
+typedef int (*dir_callback)(struct inode *dir, struct dentry *dentry,
+		struct logfs_disk_dentry *dd, loff_t pos);
+
+
+static int __logfs_dir_walk(struct inode *dir, struct dentry *dentry,
+		dir_callback handler, struct logfs_disk_dentry *dd, loff_t *pos)
+{
+	struct qstr *name = dentry ? &dentry->d_name : NULL;
+	int ret;
+
+	TRACE();
+	BUG_ON(sizeof(*dd) != 256);
+	BUG_ON(i_size_read(dir) % sizeof(*dd));
+	for (; ; (*pos)++) {
+		ret = logfs_inode_read(dir, dd, sizeof(*dd),(*pos)*sizeof(*dd));
+		if (ret == -EOF)
+			return 0;
+		if (ret)
+			return ret;
+		if (be16_to_cpu(dd->namelen) == 0)
+			continue;
+
+		if (name) {
+			if (name->len != be16_to_cpu(dd->namelen))
+				continue;
+			if (memcmp(name->name, dd->name, name->len))
+				continue;
+		}
+
+		return handler(dir, dentry, dd, *pos);
+	}
+	return ret;
+}
+
+
+static int logfs_dir_walk(struct inode *dir, struct dentry *dentry,
+		dir_callback handler)
+{
+	struct logfs_disk_dentry dd;
+	loff_t pos = 0;
+	return __logfs_dir_walk(dir, dentry, handler, &dd, &pos);
+}
+
+
+static int logfs_lookup_handler(struct inode *dir, struct dentry *dentry,
+		struct logfs_disk_dentry *dd, loff_t pos)
+{
+	struct inode *inode;
+
+	TRACE();
+	inode = iget(dir->i_sb, be64_to_cpu(dd->ino));
+	if (!inode)
+		return -EIO;
+	return PTR_ERR(d_splice_alias(inode, dentry));
+}
+
+
+static struct dentry *logfs_lookup(struct inode *dir, struct dentry *dentry,
+		struct nameidata *nd)
+{
+	struct dentry *ret;
+
+	TRACE();
+	ret = ERR_PTR(logfs_dir_walk(dir, dentry, logfs_lookup_handler));
+	return ret;
+}
+
+
+/* unlink currently only makes the name length zero */
+static int logfs_unlink_handler(struct inode *dir, struct dentry *dentry,
+		struct logfs_disk_dentry *dd, loff_t pos)
+{
+	TRACE();
+	dd->namelen = 0;
+	return logfs_inode_write(dir, dd, sizeof(*dd), pos*sizeof(*dd));
+}
+
+
+static void logfs_post_unlink(struct inode *dir, struct inode *inode)
+{
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	logfs_dec_count(inode);
+	printk("unlink: %lx, %x\n", inode->i_ino, inode->i_nlink);
+	mark_inode_dirty(dir);
+}
+
+
+static int logfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	int ret;
+
+	TRACE();
+	ret = logfs_dir_walk(dir, dentry, logfs_unlink_handler);
+	if (ret)
+		return ret;
+
+	logfs_post_unlink(dir, inode);
+	return 0;
+}
+
+
+static int logfs_empty_handler(struct inode *dir, struct dentry *dentry,
+		struct logfs_disk_dentry *dd, loff_t pos)
+{
+	TRACE();
+	return -ENOTEMPTY;
+}
+static inline int logfs_empty_dir(struct inode *dir)
+{
+	return logfs_dir_walk(dir, NULL, logfs_empty_handler) == 0;
+}
+
+
+static void logfs_post_rmdir(struct inode *dir, struct inode *inode)
+{
+	inode->i_size = 0; /* FIXME: why this? */
+	logfs_dec_count(inode);
+	logfs_dec_count(dir);
+}
+
+
+static int logfs_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	int err;
+
+	TRACE();
+	if (!logfs_empty_dir(inode))
+		return -ENOTEMPTY;
+
+	err = logfs_unlink(dir, dentry);
+	if (err)
+		return err;
+
+	logfs_post_rmdir(dir, inode);
+	return 0;
+}
+
+
+/* FIXME: readdir currently has it's own dir_walk code.  I don't see a good
+ * way to combine the two copies */
+#define IMPLICIT_NODES 2
+static int __logfs_readdir(struct file *file, void *buf, filldir_t filldir)
+{
+	struct logfs_disk_dentry dd;
+	loff_t pos = file->f_pos - IMPLICIT_NODES;
+	int err;
+
+	TRACE();
+	BUG_ON(pos<0);
+	for (;; pos++) {
+		struct inode *dir = file->f_dentry->d_inode;
+		err = logfs_inode_read(dir, &dd, sizeof(dd), pos*sizeof(dd));
+		if (err == -EOF)
+			break;
+		if (err)
+			return err;
+
+		/* zero-length indicates deleted dentries */
+		if (be16_to_cpu(dd.namelen) == 0)
+			continue;
+
+		if (filldir(buf, dd.name, be16_to_cpu(dd.namelen), pos,
+					be64_to_cpu(dd.ino), dd.type))
+			break;
+	}
+
+	file->f_pos = pos + IMPLICIT_NODES;
+	return 0;
+}
+
+
+static int logfs_readdir(struct file *file, void *buf, filldir_t filldir)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+
+	TRACE();
+	if (file->f_pos < 0)
+		return -EINVAL;
+
+	if (file->f_pos == 0) {
+		if (filldir(buf, ".", 1, 1, inode->i_ino, DT_DIR) < 0)
+			return 0;
+		file->f_pos++;
+	}
+	if (file->f_pos == 1) {
+		ino_t pino = parent_ino(file->f_dentry);
+		if (filldir(buf, "..", 2, 2, pino, DT_DIR) < 0)
+			return 0;
+		file->f_pos++;
+	}
+
+	return __logfs_readdir(file, buf, filldir);
+}
+
+
+static int logfs_write_dir(struct inode *dir, struct dentry *dentry,
+		struct inode *inode)
+{
+	struct logfs_disk_dentry dd;
+	int err;
+
+	memset(&dd, 0, sizeof(dd));
+	dd.ino = cpu_to_be64(inode->i_ino);
+	dd.namelen = cpu_to_be16(dentry->d_name.len);
+	BUG_ON(dentry->d_name.len > LOGFS_MAX_NAMELEN);
+	memcpy(dd.name, dentry->d_name.name, dentry->d_name.len);
+	dd.type = logfs_type(inode);
+	err = logfs_inode_write(dir, &dd, sizeof(dd), i_size_read(dir));
+	if (err) {
+		logfs_dec_count(inode);
+		iput(inode);
+		return err;
+	}
+	d_instantiate(dentry, inode);
+	return 0;
+}
+
+
+/* FIXME: This should really be somewhere in the 64bit area. */
+#define LOGFS_LINK_MAX (2^30)
+static int logfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	struct inode *inode;
+	int ret;
+
+	TRACE();
+	if (dir->i_nlink >= LOGFS_LINK_MAX)
+		return -EMLINK;
+
+	logfs_inc_count(dir);
+
+	/* FIXME: why do we have to fill in S_IFDIR, while the mode is
+	 * correct for mknod, creat, etc.?
+	 */
+	inode = logfs_new_inode(dir, S_IFDIR | mode);
+	if (IS_ERR(inode)) {
+		logfs_dec_count(dir);
+		return PTR_ERR(inode);
+	}
+
+	inode->i_op = &logfs_dir_iops;
+	inode->i_fop = &logfs_dir_fops;
+
+	logfs_inc_count(inode);
+
+	ret = logfs_write_dir(dir, dentry, inode);
+	if (ret) {
+		logfs_dec_count(inode);
+		logfs_dec_count(inode);
+		iput(inode);
+		logfs_dec_count(dir);
+	}
+	return ret;
+}
+
+
+static int logfs_create(struct inode *dir, struct dentry *dentry, int mode,
+		struct nameidata *nd)
+{
+	struct inode *inode;
+
+	TRACE();
+	inode = logfs_new_inode(dir, mode);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	inode->i_op = &logfs_reg_iops;
+	inode->i_fop = &logfs_reg_fops;
+	inode->i_mapping->a_ops = &logfs_reg_aops;
+	mark_inode_dirty(inode);
+
+	return logfs_write_dir(dir, dentry, inode);
+}
+
+
+static int logfs_mknod(struct inode *dir, struct dentry *dentry, int mode,
+		dev_t rdev)
+{
+	struct inode *inode;
+	int ret;
+
+	TRACE();
+	BUG_ON(dentry->d_name.len > LOGFS_MAX_NAMELEN);
+
+	inode = logfs_new_inode(dir, mode);
+	ret = PTR_ERR(inode);
+	if (IS_ERR(inode))
+		goto out;
+
+	init_special_inode(inode, mode, rdev);
+	mark_inode_dirty(inode);
+
+	ret = logfs_write_dir(dir, dentry, inode);
+out:
+	return ret;
+}
+
+
+static struct inode_operations ext2_symlink_iops = {
+	.readlink	= generic_readlink,
+	.follow_link	= page_follow_link_light,
+};
+
+
+static int logfs_symlink(struct inode *dir, struct dentry *dentry,
+		const char *target)
+{
+	size_t len = strlen(target) + 1;
+	struct inode *inode;
+	int ret;
+
+	inode = logfs_new_inode(dir, S_IFLNK | S_IRWXUGO);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	inode->i_op = &ext2_symlink_iops;
+	inode->i_mapping->a_ops = &logfs_reg_aops;
+
+	ret = logfs_inode_write_loop(inode, target, len, 0);
+	if (ret) {
+		logfs_dec_count(inode);
+		iput(inode);
+		return ret;
+	}
+	return logfs_write_dir(dir, dentry, inode);
+}
+
+
+static int logfs_permission(struct inode *inode, int mask, struct nameidata *nd)
+{
+	return generic_permission(inode, mask, NULL);
+}
+
+
+static int logfs_link(struct dentry *old_dentry, struct inode *dir,
+		struct dentry *dentry)
+{
+	struct inode *inode = old_dentry->d_inode;
+
+	TRACE();
+	if (inode->i_nlink >= LOGFS_LINK_MAX)
+		return -EMLINK;
+
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	logfs_inc_count(inode);
+	atomic_inc(&inode->i_count);
+
+	return logfs_write_dir(dir, dentry, inode);
+}
+
+
+static int logfs_nop_handler(struct inode *dir, struct dentry *dentry,
+		struct logfs_disk_dentry *dd, loff_t pos)
+{
+	return 0;
+}
+static inline int logfs_get_dd(struct inode *dir, struct dentry *dentry,
+		struct logfs_disk_dentry *dd, loff_t *pos)
+{
+	return __logfs_dir_walk(dir, dentry, logfs_nop_handler, dd, pos);
+}
+
+
+static int logfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+		struct inode *new_dir, struct dentry *new_dentry)
+{
+	struct inode *old_inode = old_dentry->d_inode;
+	struct inode *new_inode = new_dentry->d_inode;
+	int isdir = S_ISDIR(old_inode->i_mode);
+	int err;
+
+	TRACE();
+	/* FIXME: request sync semaphore */
+	if (new_inode) { /* replace */
+		struct logfs_disk_dentry new_dd;
+		loff_t new_pos = 0;
+
+		BUG_ON(isdir && !S_ISDIR(new_inode->i_mode));
+		if (isdir) {
+			if (!logfs_empty_dir(new_inode))
+				return -ENOTEMPTY;
+		}
+
+		err = logfs_get_dd(new_dir, new_dentry, &new_dd, &new_pos);
+		BUG_ON(err); /* target should exist */
+
+		/* replace old dd */
+		new_dd.ino = cpu_to_be64(old_inode->i_ino);
+		new_dd.type = logfs_type(old_inode);
+		err = logfs_inode_write(new_dir, &new_dd, sizeof(new_dd),
+				new_pos*sizeof(new_dd));
+		if (err)
+			return err;
+
+		logfs_post_unlink(new_dir, new_inode);
+
+		logfs_inc_count(old_inode);
+		err = logfs_unlink(old_dir, old_dentry);
+		BUG_ON(err); /* FUCK!  we need to clean things up instead */
+
+		/* remove new_inode from old_dir - old_inode has moved to
+		 * new_dir, so this is correct */
+		if (isdir)
+			logfs_post_rmdir(old_dir, new_inode);
+
+		return err;
+	} else { /* just a move */
+		err = logfs_link(old_dentry, new_dir, new_dentry);
+		if (err)
+			return err;
+
+		if (isdir) {
+			logfs_inc_count(new_dir);
+			return logfs_rmdir(old_dir, old_dentry);
+		} else {
+			return logfs_unlink(old_dir, old_dentry);
+		}
+	}
+}
+
+
+struct inode_operations logfs_dir_iops = {
+	.create		= logfs_create,
+	.link		= logfs_link,
+	.lookup		= logfs_lookup,
+	.mkdir		= logfs_mkdir,
+	.mknod		= logfs_mknod,
+	.rename		= logfs_rename,
+	.rmdir		= logfs_rmdir,
+	.permission	= logfs_permission,
+	.symlink	= logfs_symlink,
+	.unlink		= logfs_unlink,
+};
+struct file_operations logfs_dir_fops = {
+	.readdir	= logfs_readdir,
+	.read		= generic_read_dir,
+};
--- /dev/null	2006-08-15 20:12:53.000000000 +0200
+++ logfs3/fs/logfs/file.c	2006-08-24 15:39:42.000000000 +0200
@@ -0,0 +1,82 @@
+#include <linux/mtd/mtd.h>
+#include <linux/pagemap.h>
+
+#include "logfs.h"
+
+
+static int logfs_prepare_write(struct file *file, struct page *page,
+               unsigned start, unsigned end)
+{
+       void *buf;
+
+       TRACE();
+       buf = kmap(page);
+       if (!PageUptodate(page)) {
+	       /* FIXME: shouldn't we read instead? */
+               memset(buf, 0, PAGE_CACHE_SIZE);
+               SetPageUptodate(page);
+       }
+
+       //set_page_dirty(page);
+       kunmap(page);
+
+       return 0;
+}
+
+
+static int logfs_commit_write(struct file *file, struct page *page,
+		unsigned start, unsigned end)
+{
+	struct inode *inode = page->mapping->host;
+	pgoff_t index = page->index;
+	void *buf;
+	int ret;
+
+	TRACE();
+	pr_debug("ino: %lu, page:%lu, start: %d, len:%d\n", inode->i_ino,
+			page->index, start, end-start);
+	BUG_ON(PAGE_CACHE_SIZE != LOGFS_BLOCKSIZE);
+	BUG_ON(page->index > I3_BLOCKS);
+
+	if (start == end)
+		return 0; /* FIXME: do we need to update inode? */
+
+	if (i_size_read(inode) < (index << PAGE_CACHE_SHIFT) + end) {
+		i_size_write(inode, (index << PAGE_CACHE_SHIFT) + end);
+		mark_inode_dirty(inode);
+	}
+
+	buf = kmap(page);
+	ret = logfs_write_buf(inode, index, buf);
+	kunmap(page);
+	return ret;
+}
+
+
+static int logfs_writepage(struct page *page, struct writeback_control *wbc)
+{
+	BUG();
+	return 0;
+}
+
+
+struct inode_operations logfs_reg_iops = {
+	.truncate	= logfs_truncate,
+};
+
+
+struct file_operations logfs_reg_fops = {
+	.llseek		= generic_file_llseek,
+	.open		= generic_file_open,
+	.read		= generic_file_read,
+	.write		= generic_file_write,
+};
+
+
+struct address_space_operations logfs_reg_aops = {
+	.commit_write	= logfs_commit_write,
+	.prepare_write	= logfs_prepare_write,
+	.readpage	= logfs_readpage,
+	.set_page_dirty	= __set_page_dirty_nobuffers,
+	.writepage	= logfs_writepage,
+};
--- /dev/null	2006-08-15 20:12:53.000000000 +0200
+++ logfs3/fs/logfs/gc.c	2006-08-24 15:39:42.000000000 +0200
@@ -0,0 +1,517 @@
+#include <linux/fs.h>
+#include <linux/mtd/mtd.h>
+
+#include "logfs.h"
+
+
+static int logfs_is_valid_block_gc(struct super_block *sb, u64 ofs, u64 ino,
+		pos_t pos)
+{
+	/* Umount closes a segment with free blocks remaining.  Those
+	 * blocks are by definition invalid. */
+	if (ino == -1)
+		return 0;
+
+	/* Journal blocks are by definition valid.  They will get
+	 * erased from journal.c sooner or later. */
+	if (ino == LOGFS_INO_JOURNAL)
+		return 1;
+
+	return logfs_is_valid_block(sb, ofs, ino, pos);
+}
+
+
+static int logfs_valid_count(struct logfs_super *super, u64 seg_offset)
+{
+	struct mtd_info *mtd = super->s_mtd;
+	struct logfs_disk_sum *sum;
+	int end = super->s_no_blocks-1;
+	u64 footer = seg_offset + end * super->s_blocksize;
+	int valid = 0;
+	int i, err;
+
+	/* Superblock.  Don't touch, or else... */
+	if (seg_offset == 0)
+		return end;
+	/* Primary journal segments.  Don't touch, or else... */
+	if ((seg_offset >= super->s_log_ofs)
+			&& (seg_offset - super->s_log_ofs < super->s_log_len))
+		return end;
+
+	/* Currently open segments */
+	for (i=0; i<LOGFS_SEGMENTS; i++) {
+		struct logfs_segment *seg = super->s_segs[i];
+		if (seg->active && (seg->ofs == seg_offset))
+			return end;
+	}
+
+	sum = alloc_disk_sum(super);
+	err = mtdread(mtd, footer, logfs_summary_size(super), sum);
+	BUG_ON(err);
+
+	for (i=0; i<end; i++) {
+		u64 ino = be64_to_cpu(sum->blocks[i].ino);
+		u64 ofs = seg_offset + i*super->s_blocksize;
+		pos_t pos = be64_to_pos(sum->blocks[i].pos);
+		if (logfs_is_valid_block_gc(super->s_sb, ofs, ino, pos))
+			valid++;
+		//printk("%6llx, %4llx, %6llx, %x\n", ofs, ino, pos, valid);
+	}
+	free_disk_sum(sum);
+	return valid;
+}
+
+
+int logfs_erase_segment(struct logfs_super *super, u64 ofs)
+{
+	u64 end = ofs + super->s_segsize;
+	long step = super->s_blocksize;
+	int ret;
+
+	super->s_gec++;
+
+	for ( ; ofs < end; ofs += step) {
+		ret = mtderase(super->s_mtd, ofs, step);
+		if (ret)
+			return -EIO;
+	}
+	return 0;
+}
+
+
+static void scan_valid_segments(struct logfs_super *super)
+{
+	int i;
+	int valid;
+
+	super->s_no_free_segs = 0;
+	for (i=0; i<super->s_no_segs; i++) {
+		u64 ofs = (u64)i * super->s_segsize;
+
+		valid = logfs_valid_count(super, ofs);
+		super->s_valid_count[i] = valid;
+		if (valid == 0)
+			super->s_no_free_segs++;
+	}
+}
+
+
+static int logfs_level(struct logfs_super *super, u64 seg_offset)
+{
+	struct mtd_info *mtd = super->s_mtd;
+	struct logfs_disk_sum *sum;
+	int end = super->s_no_blocks-1;
+	u64 footer = seg_offset + end * super->s_blocksize;
+	int i, level, err;
+
+	/* Currently open segments */
+	for (i=0; i<LOGFS_SEGMENTS; i++) {
+		struct logfs_segment *seg = super->s_segs[i];
+		if (seg->active && (seg->ofs == seg_offset))
+			return seg->level;
+	}
+
+	sum = alloc_disk_sum(super);
+	err = mtdread(mtd, footer, logfs_summary_size(super), sum);
+	BUG_ON(err);
+
+	level = sum->level;
+	free_disk_sum(sum);
+	return level;
+}
+
+
+static void dump_segments(struct logfs_super *super)
+{
+	int i;
+	int valid;
+
+	//return;
+	for (i=0; i<super->s_no_segs; i++) {
+		u64 ofs = (u64)i * super->s_segsize;
+
+		valid = logfs_valid_count(super, ofs);
+		printk("%5llx, %3d, %2d, %2d ", ofs, logfs_level(super, ofs),
+				super->s_valid_count[i], valid);
+		if (i & 1)
+			printk("\n");
+	}
+}
+
+
+static void logfs_cleanse_block(struct logfs_super *super, u64 ofs, u64 ino,
+		pos_t pos)
+{
+	struct super_block *sb = super->s_sb;
+	struct inode *inode;
+	int err;
+
+	inode = logfs_iget(sb, ino);
+	BUG_ON(!inode);
+	err = logfs_rewrite_block(inode, logfs_index(pos), ofs, NULL);
+	BUG_ON(err);
+	logfs_iput(inode);
+}
+
+
+static void __logfs_gc_segment(struct logfs_super *super, u64 seg_ofs)
+{
+	struct mtd_info *mtd = super->s_mtd;
+	struct logfs_disk_sum *sum;
+	int end = super->s_no_blocks-1;
+	u64 footer = seg_ofs + end * super->s_blocksize;
+	int i, err;
+
+	sum = alloc_disk_sum(super);
+	err = mtdread(mtd, footer, logfs_summary_size(super), sum);
+	BUG_ON(err);
+
+	for (i=0; i<end; i++) {
+		u64 ino = be64_to_cpu(sum->blocks[i].ino);
+		u64 ofs = seg_ofs + i*super->s_blocksize;
+		pos_t pos = be64_to_pos(sum->blocks[i].pos);
+		if (! logfs_is_valid_block_gc(super->s_sb, ofs, ino, pos))
+			continue;
+
+		logfs_cleanse_block(super, ofs, ino, pos);
+	}
+	free_disk_sum(sum);
+}
+
+
+static void logfs_gc_segment(struct logfs_super *super, u64 seg_ofs)
+{
+	int i;
+
+	/* Superblock.  Don't touch, or else... */
+	BUG_ON(seg_ofs == 0);
+	/* Primary journal segments.  Don't touch, or else... */
+	BUG_ON((seg_ofs >= super->s_log_ofs)
+			&& (seg_ofs - super->s_log_ofs < super->s_log_len));
+
+	/* Currently open segments */
+	for (i=0; i<LOGFS_SEGMENTS; i++) {
+		struct logfs_segment *seg = super->s_segs[i];
+		BUG_ON(seg->active && (seg->ofs == seg_ofs));
+	}
+	__logfs_gc_segment(super, seg_ofs);
+}
+
+
+static void logfs_gc_once(struct logfs_super *super)
+{
+	int end = super->s_no_blocks-1;
+	int i;
+
+	for (i = super->s_sweeper+1; 1 != super->s_sweeper; i++) {
+		u64 ofs;
+		int valid;
+
+		if (i >= super->s_no_segs)
+			i=1;	/* skip superblock */
+
+		ofs = (u64)i * super->s_segsize;
+		valid = super->s_valid_count[i];
+
+		if (valid == 0)
+			continue;
+		if (valid > end-1)
+			continue;
+		printk("candidate: %5llx\n", ofs);
+		logfs_gc_segment(super, ofs);
+		super->s_valid_count[i] = 0;
+		super->s_no_free_segs++;
+		super->s_sweeper = i;
+		return;
+	}
+	BUG();
+}
+
+
+void logfs_gc_pass(struct logfs_super *super)
+{
+	u8 reserve = super->s_total_levels;
+	int passes = 0;
+
+	for (;;) {
+		BUG_ON(passes++ > 100);
+
+		if (super->s_no_free_segs >= reserve)
+			return;
+
+		scan_valid_segments(super);
+
+		if (super->s_no_free_segs >= reserve)
+			return;
+
+		dump_segments(super);
+		logfs_gc_once(super);
+		dump_segments(super);
+		continue;
+	}
+}
+
+
+static u64 find_free_segment(struct logfs_super *super)
+{
+	int i;
+
+	for (i=0; i<super->s_no_segs; i++) {
+		u64 ofs = (u64)i * super->s_segsize;
+
+		if (super->s_valid_count[i] != 0)
+			continue;
+
+		BUG_ON(logfs_valid_count(super, ofs) != 0);
+
+		super->s_valid_count[i] = super->s_no_blocks-1;
+		super->s_no_free_segs--;
+		return ofs;
+	}
+
+	BUG();
+	return 0;
+}
+
+
+static int logfs_open_segment(struct logfs_segment *seg)
+{
+	struct logfs_super *super = seg->super;
+	struct mtd_info *mtd = super->s_mtd;
+	struct logfs_disk_sum *sum;
+	int end = super->s_no_blocks-1;
+	u64 footer;
+	int err;
+
+	TRACE();
+	if (seg->active)
+		return 0; /* nothing to do */
+
+	seg->ofs = find_free_segment(super);
+	seg->cur_block = 0;
+
+	sum = alloc_disk_sum(super);
+	footer = seg->ofs + end * super->s_blocksize;
+	err = mtdread(mtd, footer, logfs_summary_size(super), sum);
+	seg->erase_count = be32_to_cpu(sum->erase_count) + 1;
+	super->s_maxec = max(super->s_maxec, (u64)seg->erase_count);
+	//printk("open %8llx, %x\n", seg->ofs, seg->erase_count);
+	free_disk_sum(sum);
+	BUG_ON(err); /* FIXME */
+	if (err)
+		return err;
+
+	memset(&seg->blocks, 0xff, logfs_summary_size(super));
+	seg->active = 1;
+
+	logfs_erase_segment(super, seg->ofs);
+
+	return 0;
+}
+
+
+void logfs_disk_to_sum(struct logfs_super *super, struct logfs_segment *seg,
+		struct logfs_disk_sum *sum)
+{
+	int end = super->s_no_blocks-1;
+	int i;
+
+	seg->ofs = be64_to_cpu(sum->ofs);
+	if (seg->ofs + 1 == 0) {	/* inactive segment */
+		seg->active = 0;
+		return;
+	}
+
+	seg->active = 1;
+	seg->erase_count = be32_to_cpu(sum->erase_count);
+	seg->level = sum->level;
+
+	seg->cur_block = 0;
+	for (i=0; i<end; i++) {
+		seg->blocks[i].ino = be64_to_cpu(sum->blocks[i].ino);
+		seg->blocks[i].pos = be64_to_pos(sum->blocks[i].pos);
+		if (seg->blocks[i].ino + 1 != 0)
+			seg->cur_block = i+1;
+	}
+}
+
+
+void logfs_sum_to_disk(struct logfs_super *super, struct logfs_segment *seg,
+		struct logfs_disk_sum *sum)
+{
+	int end = super->s_no_blocks-1;
+	int i;
+
+	if (!seg->active) {
+		memset(sum, 0xff, logfs_summary_size(super));
+		return;
+	}
+
+	for (i=0; i<end; i++) {
+		sum->blocks[i].ino = cpu_to_be64(seg->blocks[i].ino);
+		sum->blocks[i].pos = pos_to_be64(seg->blocks[i].pos);
+	}
+	sum->erase_count = cpu_to_be32(seg->erase_count);
+	sum->level = seg->level;
+	sum->pad[0] = 's';
+	sum->pad[1] = 'u';
+	sum->pad[2] = 'm';
+	sum->ofs = cpu_to_be64(seg->ofs);
+}
+
+
+static int logfs_finish_segment(struct logfs_super *super,
+		struct logfs_segment *seg)
+{
+	struct mtd_info *mtd = super->s_mtd;
+	struct logfs_disk_sum *sum;
+	int end = super->s_no_blocks-1;
+	u64 ofs = seg->ofs + end * super->s_blocksize;
+	int err;
+
+	TRACE();
+	if (!seg->active)
+		return 0;
+
+	sum = alloc_disk_sum(super);
+	logfs_sum_to_disk(super, seg, sum);
+	sum->gec = cpu_to_be64(super->s_gec); /* we overwrite ofs here */
+	err = mtdwrite(mtd, ofs, logfs_summary_size(super), sum);
+	//printk("finish %8llx, %x\n", seg->ofs, seg->erase_count);
+	free_disk_sum(sum);
+	BUG_ON(err); /* lacking any better means */
+	return err;
+}
+
+
+static void logfs_close_segment(struct logfs_segment *seg)
+{
+	struct logfs_super *super = seg->super;
+
+	if (seg->cur_block == super->s_no_blocks - 1) {
+		logfs_finish_segment(super, seg); /* FIXME: return code */
+		seg->active = 0;
+	}
+}
+
+
+static s64 __logfs_get_free_block(struct logfs_segment *seg, u64 ino, pos_t pos)
+{
+	struct logfs_super *super = seg->super;
+	//struct logfs_segment *bug = super->s_segs[1];
+	s64 ofs;
+	int ret;
+
+	TRACE();
+	ret = logfs_open_segment(seg);
+	BUG_ON(ret>0);
+	if (ret)
+		return ret;
+
+	seg->blocks[seg->cur_block].ino = ino;
+	seg->blocks[seg->cur_block].pos = pos;
+
+	ofs = seg->ofs + seg->cur_block * super->s_blocksize;
+	seg->cur_block++;
+	logfs_close_segment(seg);
+
+	BUG_ON(ofs >= super->s_size);
+	return ofs;
+}
+
+
+s64 logfs_get_free_block(struct logfs_super *super, int level, u64 ino, pos_t pos)
+{
+	s64 ret;
+
+	TRACE();
+	BUG_ON(level >= LOGFS_MAX_LEVELS);
+
+	if (ino == LOGFS_INO_MASTER)	/* ifile has seperate segments */
+		level += LOGFS_MAX_LEVELS;
+
+	ret = __logfs_get_free_block(super->s_segs[level], ino, pos);
+	BUG_ON(ret <= 0); /* not sure, but it's safer to BUG than to accept */
+	return ret;
+}
+
+
+static void logfs_measure_free_space(struct logfs_super *super)
+{
+	u64 free = 0;
+	int i;
+
+	/* FIXME: superblock also needs a "don't touch" marker */
+	for (i=0; i<super->s_no_segs; i++) {
+		int valid = super->s_valid_count[i];
+		free += super->s_segsize/LOGFS_BLOCKSIZE - 1 - valid;
+	}
+	super->s_free = free;
+	printk("free: %lld\n", free);
+	return;
+}
+
+
+int logfs_init_segments(struct logfs_super *super)
+{
+	struct logfs_segment *segs;
+	int i;
+
+	segs = kzalloc(LOGFS_SEGMENTS * logfs_segstruct_size(super),
+			GFP_KERNEL);
+	if (!segs)
+		return -ENOMEM;
+	for (i=0; i<LOGFS_SEGMENTS; i++) {
+		super->s_segs[i] = (void*)segs + i*logfs_segstruct_size(super);
+		super->s_segs[i]->super = super;
+		super->s_segs[i]->level = i;
+	}
+	return 0;
+}
+
+
+/* needs to be called after init_journal, as we use s_last here */
+int logfs_init_gc(struct logfs_super *super)
+{
+	u64 div;
+
+	div = super->s_size;
+	do_div(div, super->s_segsize);
+	super->s_no_segs = div;
+
+	super->s_valid_count = kmalloc(super->s_no_segs, GFP_KERNEL);
+	if (!super->s_valid_count)
+		goto fail0;
+
+	super->s_gc_buf = kmalloc(super->s_blocksize, GFP_KERNEL);
+	if (!super->s_gc_buf)
+		goto fail1;
+
+	/* order is important - scan first */
+	scan_valid_segments(super);
+	logfs_measure_free_space(super);
+
+	return 0;
+fail1:
+	kfree(super->s_valid_count);
+fail0:
+	return -ENOMEM;
+}
+
+
+void logfs_cleanup_segments(struct logfs_super *super)
+{
+	int i;
+	for (i=0; i<LOGFS_SEGMENTS; i++) {
+		/* commit to flash */
+		//logfs_finish_segment(super, super->s_segs[i]);
+	}
+	kfree(super->s_segs[0]);
+}
+
+
+void logfs_cleanup_gc(struct logfs_super *super)
+{
+	kfree(super->s_gc_buf);
+	kfree(super->s_valid_count);
+}
--- /dev/null	2006-08-15 20:12:53.000000000 +0200
+++ logfs3/fs/logfs/inode.c	2006-08-24 15:39:42.000000000 +0200
@@ -0,0 +1,385 @@
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/mtd/mtd.h>
+
+#include "logfs.h"
+
+
+static kmem_cache_t *logfs_inode_cache;
+
+
+static struct inode *logfs_alloc_inode(struct super_block *sb)
+{
+	struct logfs_inode *li;
+
+	TRACE();
+	li = kmem_cache_alloc(logfs_inode_cache, SLAB_KERNEL);
+	if (!li)
+		return NULL;
+	return &li->vfs_inode;
+}
+
+
+static void logfs_init_inode(struct inode *inode)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	int i;
+
+	TRACE();
+	li->li_flags	= LOGFS_IF_VALID;
+	li->li_blocks	= 0;
+	inode->i_uid	= 0;
+	inode->i_gid	= 0;
+	inode->i_size	= 0;
+	inode->i_blocks	= 0;
+	inode->i_ctime	= CURRENT_TIME;
+	inode->i_mtime	= CURRENT_TIME;
+	inode->i_nlink	= 1;
+
+	for (i=0; i<LOGFS_EMBEDDED_FIELDS; i++)
+		li->li_data[i] = 0;
+
+	return;
+}
+
+
+struct inode *logfs_new_master_inode(struct super_block *sb)
+{
+	struct inode *inode;
+
+	inode = logfs_alloc_inode(sb);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	logfs_init_inode(inode);
+	inode->i_mode = 0;
+	inode->i_ino = LOGFS_INO_MASTER;
+	inode->i_sb = sb;
+
+	return inode;
+}
+
+
+static struct timespec be64_to_timespec(be64 betime)
+{
+	u64 time = be64_to_cpu(betime);
+	struct timespec tsp;
+	tsp.tv_sec = time >> 32;
+	tsp.tv_nsec = time & 0xffffffff;
+	return tsp;
+}
+
+
+static be64 timespec_to_be64(struct timespec tsp)
+{
+	u64 time = ((u64)tsp.tv_sec << 32) + (tsp.tv_nsec & 0xffffffff);
+	return cpu_to_be64(time);
+}
+
+
+static void logfs_disk_to_inode(struct logfs_disk_inode *di, struct inode*inode)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	int i;
+
+	TRACE();
+	inode->i_mode	= be16_to_cpu(di->di_mode);
+	li->li_flags	= be32_to_cpu(di->di_flags);
+	inode->i_uid	= be32_to_cpu(di->di_uid);
+	inode->i_gid	= be32_to_cpu(di->di_gid);
+	inode->i_size	= be64_to_cpu(di->di_size);
+	logfs_set_blocks(inode, be64_to_cpu(di->di_blocks));
+	inode->i_ctime	= be64_to_timespec(di->di_ctime);
+	inode->i_mtime	= be64_to_timespec(di->di_mtime);
+	inode->i_nlink	= be32_to_cpu(di->di_refcount);
+	inode->i_generation = be32_to_cpu(di->di_generation);
+
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFCHR: /* fall through */
+	case S_IFBLK: /* fall through */
+	case S_IFIFO:
+		inode->i_rdev = be64_to_cpu(di->di_data[0]);
+		break;
+	default:
+		for (i=0; i<LOGFS_EMBEDDED_FIELDS; i++)
+			li->li_data[i] = be64_to_cpu(di->di_data[i]);
+		break;
+	}
+}
+
+
+static void logfs_inode_to_disk(struct inode *inode, struct logfs_disk_inode*di)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	int i;
+
+	TRACE();
+	di->di_mode	= cpu_to_be16(inode->i_mode);
+	di->di_pad	= 0;
+	di->di_flags	= cpu_to_be32(li->li_flags);
+	di->di_uid	= cpu_to_be32(inode->i_uid);
+	di->di_gid	= cpu_to_be32(inode->i_gid);
+	di->di_size	= cpu_to_be64(i_size_read(inode));
+	di->di_blocks	= cpu_to_be64(li->li_blocks);
+	di->di_ctime	= timespec_to_be64(inode->i_ctime);
+	di->di_mtime	= timespec_to_be64(inode->i_mtime);
+	di->di_refcount	= cpu_to_be32(inode->i_nlink);
+	di->di_generation = cpu_to_be32(inode->i_generation);
+
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFCHR: /* fall through */
+	case S_IFBLK: /* fall through */
+	case S_IFIFO:
+		di->di_data[0] = cpu_to_be64(inode->i_rdev);
+		break;
+	default:
+		for (i=0; i<LOGFS_EMBEDDED_FIELDS; i++)
+			di->di_data[i] = cpu_to_be64(li->li_data[i]);
+		break;
+	}
+}
+
+
+static void dump_di(struct logfs_disk_inode *di)
+{
+	int i, k;
+	return;
+	for (i=0; i<sizeof(struct logfs_disk_inode); i+=32) {
+		for (k=0; k<32; k+=4) {
+			be32 *x = ((void*)di) + i + k;
+			printk("%08x ", be32_to_cpu(*x));
+		}
+		printk("\n");
+	}
+}
+
+
+static int logfs_read_disk_inode(struct logfs_disk_inode *di,
+		struct inode *inode)
+{
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	ino_t ino = inode->i_ino;
+	int ret;
+
+	TRACE();
+
+	BUG_ON(!super->s_master_inode);
+	ret = logfs_inode_read(super->s_master_inode, di, sizeof(*di),
+			ino * sizeof(*di));
+	dump_di(di);
+	if (ret)
+		return -EIO;
+
+	if ( !(be32_to_cpu(di->di_flags) & LOGFS_IF_VALID))
+		return -EIO;
+
+	if (be32_to_cpu(di->di_flags) & LOGFS_IF_INVALID)
+		return -EIO;
+
+	return 0;
+}
+
+
+static int __logfs_read_inode(struct inode *inode)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	struct logfs_disk_inode di;
+	int ret;
+
+	TRACE();
+	ret = logfs_read_disk_inode(&di, inode);
+	if (ret)
+		return ret;
+	logfs_disk_to_inode(&di, inode);
+
+	if ( !(li->li_flags&LOGFS_IF_VALID) || (li->li_flags&LOGFS_IF_INVALID))
+		return -EIO;
+
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFDIR:
+		inode->i_op = &logfs_dir_iops;
+		inode->i_fop = &logfs_dir_fops;
+		break;
+	case S_IFREG:
+		inode->i_op = &logfs_reg_iops;
+		inode->i_fop = &logfs_reg_fops;
+		inode->i_mapping->a_ops = &logfs_reg_aops;
+		break;
+	default:
+		;
+	}
+
+	return 0;
+}
+
+
+static void logfs_read_inode(struct inode *inode)
+{
+	int ret;
+
+	TRACE();
+	BUG_ON(inode->i_ino == LOGFS_INO_MASTER);
+
+	ret = __logfs_read_inode(inode);
+	if (ret) {
+		printk("%lx\n", inode->i_ino);
+		BUG();
+	}
+}
+
+
+static int logfs_write_disk_inode(struct logfs_disk_inode *di,
+		struct inode *inode)
+{
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	int ret;
+
+	TRACE();
+	BUG_ON(!super->s_master_inode);
+	ret = logfs_inode_write_nolock(super->s_master_inode, di, sizeof(*di),
+			inode->i_ino * sizeof(*di));
+	dump_di(di);
+	return ret;
+}
+
+
+static int logfs_write_inode(struct inode *inode, int do_sync)
+{
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	struct logfs_disk_inode old, new;
+	int ret = 0;
+
+	BUG_ON(inode->i_ino == LOGFS_INO_MASTER);
+
+	mutex_lock(&super->s_write_inode_mutex);
+	super->s_write_inode = inode;
+
+	logfs_inode_to_disk(inode, &new);
+	if (logfs_read_disk_inode(&old, inode))
+		ret = logfs_write_disk_inode(&new, inode);
+	if (memcmp(&old, &new, sizeof(old)))
+		ret = logfs_write_disk_inode(&new, inode);
+
+	super->s_write_inode = NULL;
+	mutex_unlock(&super->s_write_inode_mutex);
+	return ret;
+}
+
+
+static void logfs_delete_inode(struct inode *inode)
+{
+	TRACE();
+	if (i_size_read(inode) > 0) {
+		i_size_write(inode, 0);
+		logfs_truncate(inode);
+		truncate_inode_pages(&inode->i_data, 0);
+	}
+	logfs_write_inode(inode, 1);
+	clear_inode(inode);
+}
+
+
+static void logfs_destroy_inode(struct inode *inode)
+{
+	TRACE();
+	kmem_cache_free(logfs_inode_cache, LOGFS_INODE(inode));
+}
+
+
+static u64 logfs_get_ino(struct super_block *sb)
+{
+	struct logfs_super *super = LOGFS_SUPER(sb);
+	u64 ino;
+
+	/* FIXME: ino allocation should work in two modes:
+	 * o nonsparse - ifile is mostly occupied, just append
+	 * o sparse - ifile has lots of holes, fill them up
+	 */
+	spin_lock(&super->s_ino_lock);
+	ino = super->s_last_ino; /* ifile shouldn't be too sparse */
+	super->s_last_ino++;
+	spin_unlock(&super->s_ino_lock);
+	return ino;
+}
+
+
+struct inode *logfs_new_inode(struct inode *dir, int mode)
+{
+	struct super_block *sb = dir->i_sb;
+	struct inode *inode;
+	int ret;
+
+	inode = new_inode(sb);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	logfs_init_inode(inode);
+
+	inode->i_mode = mode;
+	inode->i_ino = logfs_get_ino(sb);
+
+	/* If we don't spend an option early, we may end up with dirty inodes
+	 * and no options left at umount time.  So write this inode NOW.
+	 */
+	ret = logfs_write_inode(inode, 1);
+	if (ret) {
+		logfs_destroy_inode(inode);
+		/* FIXME: we just grew super->s_last_ino */
+		return NULL;
+	}
+	/* FIXME: need to understand vfs inode handling a bit more */
+	insert_inode_hash(inode);
+
+	return inode;
+}
+
+
+static void logfs_init_once(void *_li, kmem_cache_t *cachep,
+		unsigned long flags)
+{
+	struct logfs_inode *li = _li;
+	struct inode *inode = _li;
+	int i;
+
+	TRACE();
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+			SLAB_CTOR_CONSTRUCTOR) {
+		li->li_flags = 0;
+		li->li_blocks = 0;
+		for (i=0; i<LOGFS_EMBEDDED_FIELDS; i++)
+			li->li_data[i] = 0;
+		inode_init_once(&li->vfs_inode);
+		/* FIXME: would block size be better? */
+		inode->i_blksize = PAGE_SIZE;
+	}
+
+}
+
+
+struct super_operations logfs_super_operations = {
+	.alloc_inode	= logfs_alloc_inode,
+	.delete_inode	= logfs_delete_inode,
+	.destroy_inode	= logfs_destroy_inode,
+	.read_inode	= logfs_read_inode,
+	.write_inode	= logfs_write_inode,
+	.statfs		= logfs_statfs,
+};
+
+
+int logfs_init_inode_cache(void)
+{
+	TRACE();
+	logfs_inode_cache = kmem_cache_create("logfs_inode_cache",
+			sizeof(struct logfs_inode), 0, SLAB_RECLAIM_ACCOUNT,
+			logfs_init_once, NULL);
+	if (!logfs_inode_cache)
+		return -ENOMEM;
+	return 0;
+}
+
+
+void logfs_destroy_inode_cache(void)
+{
+	TRACE();
+	kmem_cache_destroy(logfs_inode_cache);
+}
--- /dev/null	2006-08-15 20:12:53.000000000 +0200
+++ logfs3/fs/logfs/journal.c	2006-08-24 15:39:42.000000000 +0200
@@ -0,0 +1,216 @@
+#include <linux/fs.h>
+#include <linux/mtd/mtd.h>
+
+#include "logfs.h"
+
+
+/**
+ * FIXME: this code assumes that journal entries all fit into a block.
+ * Might become untrue someday.
+ */
+
+
+static inline u32 seg_offset(struct logfs_super *super, u64 ofs)
+{
+	u64 div = ofs;
+	u32 mod;
+
+	mod = do_div(div, super->s_segsize);
+	return mod;
+}
+
+
+static s64 __logfs_get_free_entry(struct logfs_super *super)
+{
+	u64 ofs;
+
+	ofs = super->s_anchor_ofs + super->s_blocksize;
+	if (ofs - super->s_log_ofs >= super->s_log_len)
+		ofs = super->s_log_ofs;
+	if ( !seg_offset(super, ofs)) {
+		if (logfs_erase_segment(super, ofs))
+			return -EIO;
+	}
+	BUG_ON((s64)ofs < 0);
+	return ofs;
+}
+
+
+/**
+ * logfs_get_free_entry - return free space for journal entry
+ */
+static s64 logfs_get_free_entry(struct logfs_super *super)
+{
+	s64 ret;
+
+	TRACE();
+	mutex_lock(&super->s_log_sem);
+	ret = __logfs_get_free_entry(super);
+	mutex_unlock(&super->s_log_sem);
+	BUG_ON(ret <= 0); /* not sure, but it's safer to BUG than to accept */
+	return ret;
+}
+
+
+static s64 logfs_find_anchor(struct logfs_super *super,
+		struct logfs_journal_entry *je)
+{
+	struct mtd_info *mtd = super->s_mtd;
+	u64 ofs, version, last_ofs = -EIO, last_version = 0;
+	int ret;
+
+	for (ofs = super->s_log_ofs; ofs - super->s_log_ofs < super->s_log_len;
+			ofs += super->s_blocksize) {
+		ret = mtdread(mtd, ofs, sizeof(*je), je);
+		if (ret)
+			return -EIO;
+		version = be64_to_cpu(je->je_version);
+		if (version == -1ULL)
+			continue;
+		if (version == last_version)
+			return -EIO;
+		if (version < last_version)
+			continue;
+		last_version = version;
+		last_ofs = ofs;
+	}
+	return last_ofs;
+}
+
+
+static void logfs_load_sums(struct logfs_super *super)
+{
+	struct logfs_journal_entry *je = super->s_je;
+	int i;
+
+	for (i=0; i<LOGFS_SEGMENTS; i++) {
+		struct logfs_segment *seg = super->s_segs[i];
+		void *sum = (void*)je + super->s_sum_start;
+		sum += i * logfs_summary_size(super);
+		logfs_disk_to_sum(super, seg, sum);
+	}
+}
+
+
+static int logfs_read_anchor(struct inode *inode)
+{
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	struct mtd_info *mtd = super->s_mtd;
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	struct logfs_journal_entry *je = super->s_je;
+	int i, ret;
+	s64 ofs;
+
+	TRACE();
+	ofs = logfs_find_anchor(super, je);
+	if (ofs < 0)
+		return ofs;
+
+	printk("%x\n", super->s_anchor_size);
+	ret = mtdread(mtd, ofs, super->s_anchor_size, je);
+	if (ret)
+		return ret;
+
+	logfs_load_sums(super);
+
+	BUG_ON(je->je_type != cpu_to_be16(JE_ANCHOR));
+	super->s_last_version = be64_to_cpu(je->je_version);
+	super->s_last_ino = be64_to_cpu(je->da.da_last_ino);
+	super->s_gec	= be64_to_cpu(je->da.da_gec);
+	super->s_maxec	= be64_to_cpu(je->da.da_maxec);
+	super->s_sweeper= be64_to_cpu(je->da.da_sweeper);
+	super->s_anchor_ofs = ofs;
+	li->li_flags	= LOGFS_IF_VALID;
+	i_size_write(inode, be64_to_cpu(je->da.da_size));
+
+	for (i=0; i<LOGFS_EMBEDDED_FIELDS; i++)
+		li->li_data[i] = be64_to_cpu(je->da.da_data[i]);
+
+	return 0;
+}
+
+
+static void logfs_save_sums(struct logfs_super *super)
+{
+	struct logfs_journal_entry *je = super->s_je;
+	int i;
+
+	for (i=0; i<LOGFS_SEGMENTS; i++) {
+		struct logfs_segment *seg = super->s_segs[i];
+		void *sum = (void*)je + super->s_sum_start;
+		sum += i * logfs_summary_size(super);
+		logfs_sum_to_disk(super, seg, sum);
+	}
+}
+
+
+int logfs_write_anchor(struct inode *inode)
+{
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	struct mtd_info *mtd = super->s_mtd;
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	struct logfs_journal_entry *je = super->s_je;
+	u64 ofs;
+	int i, ret;
+
+	TRACE();
+	ofs = logfs_get_free_entry(super);
+	BUG_ON(ofs >= super->s_size);
+
+	memset(je, 0, super->s_anchor_size);
+	je->je_type = cpu_to_be16(JE_ANCHOR);
+	super->s_last_version++;
+	je->je_version	= cpu_to_be64(super->s_last_version);
+	je->da.da_gec	= cpu_to_be64(super->s_gec);
+	je->da.da_maxec	= cpu_to_be64(super->s_maxec);
+	je->da.da_sweeper = cpu_to_be64(super->s_sweeper);
+	je->da.da_last_ino	= cpu_to_be64(super->s_last_ino);
+	je->da.da_size	= cpu_to_be64(i_size_read(inode));
+	for (i=0; i<LOGFS_EMBEDDED_FIELDS; i++)
+		je->da.da_data[i] = cpu_to_be64(li->li_data[i]);
+
+	logfs_save_sums(super);
+
+	ret = mtdwrite(mtd, ofs, super->s_anchor_size, je);
+	if (ret)
+		return ret;
+	super->s_anchor_ofs = ofs;
+	return 0;
+}
+
+
+int logfs_init_log(struct super_block *sb)
+{
+	struct logfs_super *super = LOGFS_SUPER(sb);
+	struct inode *inode;
+	int ret;
+
+	TRACE();
+	mutex_init(&super->s_log_sem);
+
+	super->s_je = kzalloc(super->s_anchor_size, GFP_KERNEL);
+	if (!super->s_je)
+		return -ENOMEM;
+
+	inode = logfs_new_master_inode(sb);
+	BUG_ON(!inode);
+	ret = logfs_read_anchor(inode);
+	if (ret)
+		return ret;
+	inode->i_nlink = 1; /* lock it in ram (FIXME: remove) */
+
+	super->s_master_inode = inode;
+	return 0;
+}
+
+
+void logfs_cleanup_log(struct super_block *sb)
+{
+	struct logfs_super *super = LOGFS_SUPER(sb);
+
+	logfs_write_anchor(super->s_master_inode);
+	sb->s_op->destroy_inode(super->s_master_inode);
+	super->s_master_inode = NULL;
+
+	kfree(super->s_je);
+}
--- /dev/null	2006-08-15 20:12:53.000000000 +0200
+++ logfs3/fs/logfs/readwrite.c	2006-08-24 15:39:42.000000000 +0200
@@ -0,0 +1,992 @@
+#include <linux/fs.h>
+#include <linux/mtd/mtd.h>
+#include <linux/pagemap.h>
+
+#include "logfs.h"
+
+
+static int logfs_read_empty(void *buf)
+{
+	TRACE();
+	memset(buf, 0, PAGE_CACHE_SIZE);
+	return 0;
+}
+
+
+static int logfs_read_embedded(struct inode *inode, void *buf)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+
+	TRACE();
+	memcpy(buf, li->li_data, LOGFS_EMBEDDED_SIZE);
+	return 0;
+}
+
+
+static int logfs_read_direct(struct inode *inode, pgoff_t index, void *buf)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	struct mtd_info *mtd = LOGFS_SUPER(inode->i_sb)->s_mtd;
+	u64 block;
+
+	TRACE();
+	block = li->li_data[index];
+	if (!block)
+		return logfs_read_empty(buf);
+
+	return mtdread(mtd, block, LOGFS_BLOCKSIZE, buf);
+}
+
+
+static be64 *logfs_get_rblock(struct logfs_super *super)
+{
+	TRACE();
+	mutex_lock(&super->s_r_sem);
+	return super->s_rblock;
+}
+
+
+static void logfs_put_rblock(struct logfs_super *super)
+{
+	mutex_unlock(&super->s_r_sem);
+}
+
+
+static be64 **logfs_get_wblocks(struct logfs_super *super)
+{
+	TRACE();
+	mutex_lock(&super->s_w_sem);
+	logfs_gc_pass(super);
+	return super->s_wblock;
+}
+
+
+static void logfs_put_wblocks(struct logfs_super *super)
+{
+	TRACE();
+	mutex_unlock(&super->s_w_sem);
+}
+
+
+static unsigned long get_bits(u64 val, int skip, int no)
+{
+	u64 ret = val;
+	ret >>= skip;
+	ret <<= 64 - no;
+	ret >>= 64 - no;
+	BUG_ON((unsigned long)ret != ret);
+	return ret;
+}
+
+
+static int logfs_read_loop(struct inode *inode, pgoff_t index, void *buf,
+		int count)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	struct mtd_info *mtd = super->s_mtd;
+	be64 *rblock;
+	u64 bofs = li->li_data[I1_INDEX + count];
+	int bits = LOGFS_BLOCK_BITS;
+	int i, ret;
+
+	TRACE();
+
+	if (!bofs)
+		return logfs_read_empty(buf);
+
+	rblock = logfs_get_rblock(super);
+
+	for (i=count*bits; i>=0; i-=bits) {
+		ret = mtdread(mtd, bofs, LOGFS_BLOCKSIZE, rblock);
+		if (ret)
+			goto out;
+		bofs = be64_to_cpu(rblock[get_bits(index, i, bits)]);
+
+		if (!bofs) {
+			ret = logfs_read_empty(buf);
+			goto out;
+		}
+	}
+
+	ret = mtdread(mtd, bofs, LOGFS_BLOCKSIZE, buf);
+out:
+	logfs_put_rblock(super);
+	return ret;
+}
+
+
+static int logfs_read_block(struct inode *inode, pgoff_t index, void *buf)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+
+	TRACE();
+	if (li->li_flags & LOGFS_IF_EMBEDDED) {
+		if (index != 0)
+			return logfs_read_empty(buf);
+		else
+			return logfs_read_embedded(inode, buf);
+	} else if (index < I0_BLOCKS)
+		return logfs_read_direct(inode, index, buf);
+	else if (index < I1_BLOCKS)
+		return logfs_read_loop(inode, index, buf, 0);
+	else if (index < I2_BLOCKS)
+		return logfs_read_loop(inode, index, buf, 1);
+	else if (index < I3_BLOCKS)
+		return logfs_read_loop(inode, index, buf, 2);
+
+	BUG();
+	return -EIO;
+}
+
+
+static int logfs_is_valid_direct(struct logfs_inode *li, pgoff_t index, u64 ofs)
+{
+	TRACE();
+	return li->li_data[index] == ofs;
+}
+
+
+static int logfs_is_valid_loop(struct inode *inode, pgoff_t index,
+		int count, u64 ofs)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	struct mtd_info *mtd = super->s_mtd;
+	be64 *rblock;
+	u64 bofs = li->li_data[I1_INDEX + count];
+	int bits = LOGFS_BLOCK_BITS;
+	int i, ret;
+
+	TRACE();
+
+	if (!bofs)
+		return 0;
+
+	rblock = logfs_get_rblock(super);
+
+	for (i=count*bits; i>=0; i-=bits) {
+		ret = mtdread(mtd, bofs, LOGFS_BLOCKSIZE, rblock);
+		if (ret)
+			goto fail;
+
+		bofs = be64_to_cpu(rblock[get_bits(index, i, bits)]);
+		if (!bofs)
+			goto fail;
+
+		if (bofs == ofs) {
+			ret = 1;
+			goto out;
+		}
+	}
+
+fail:
+	ret = 0;
+out:
+	logfs_put_rblock(super);
+	return ret;
+}
+
+
+static int __logfs_is_valid_block(struct inode *inode, pgoff_t index, u64 ofs)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+
+	//printk("%lx, %x, %x\n", inode->i_ino, inode->i_nlink, atomic_read(&inode->i_count));
+	if ((inode->i_nlink == 0) && atomic_read(&inode->i_count) == 1)
+		return 0;
+
+	if (li->li_flags & LOGFS_IF_EMBEDDED)
+		return 0;
+
+	if (index < I0_BLOCKS)
+		return logfs_is_valid_direct(li, index, ofs);
+	else if (index < I1_BLOCKS)
+		return logfs_is_valid_loop(inode, index, 0, ofs);
+	else if (index < I2_BLOCKS)
+		return logfs_is_valid_loop(inode, index, 1, ofs);
+	else if (index < I3_BLOCKS)
+		return logfs_is_valid_loop(inode, index, 2, ofs);
+
+	BUG();
+	return 0;
+}
+
+
+int logfs_is_valid_block(struct super_block *sb, u64 ofs, u64 ino, u64 pos)
+{
+	struct inode *write_inode = LOGFS_SUPER(sb)->s_write_inode;
+	struct inode *inode;
+	u64 idx;
+	int ret;
+
+	TRACE();
+	idx = logfs_index(pos);
+
+	BUG_ON((u64)(u_long)ino != ino);
+	inode = write_inode ? : logfs_iget(sb, ino);
+	if (!inode)
+		return 0;
+	ret = __logfs_is_valid_block(inode, idx, ofs);
+	if (!write_inode)
+		logfs_iput(inode);
+	return ret;
+}
+
+
+int logfs_readpage(struct file *file, struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+	void *buf;
+	int ret = -EIO;
+
+	TRACE();
+	buf = kmap(page);
+	ret = logfs_read_block(inode, page->index, buf);
+	kunmap(page);
+
+	if (ret) {
+		ClearPageUptodate(page);
+		SetPageError(page);
+	} else {
+		SetPageUptodate(page);
+		ClearPageError(page);
+	}
+	flush_dcache_page(page);
+
+	unlock_page(page);
+	return ret;
+}
+
+
+/**
+ * logfs_file_read - generic_file_read for in-kernel buffers
+ */
+static ssize_t __logfs_inode_read(struct inode *inode, char *buf, size_t count,
+		loff_t *ppos)
+{
+	void *block_data = NULL;
+	loff_t size = i_size_read(inode);
+	int err = -ENOMEM;
+
+	TRACE();
+	pr_debug("read from %lld, count %zd\n", *ppos, count);
+
+	if (*ppos >= size)
+		return 0;
+	if (count > size - *ppos)
+		count = size - *ppos;
+
+	BUG_ON(logfs_index(*ppos) != logfs_index(*ppos + count - 1));
+
+	block_data = kzalloc(LOGFS_BLOCKSIZE, GFP_KERNEL);
+	if (!block_data)
+		goto fail;
+
+	err = logfs_read_block(inode, logfs_index(*ppos), block_data);
+	if (err)
+		goto fail;
+
+	memcpy(buf, block_data + (*ppos % LOGFS_BLOCKSIZE), count);
+	*ppos += count;
+	kfree(block_data);
+	return count;
+fail:
+	kfree(block_data);
+	return err;
+}
+
+
+static s64 __logfs_write_block(struct logfs_super *super, void *buf, int level,
+		u64 inode, u64 pos)
+{
+	struct mtd_info *mtd = super->s_mtd;
+	u64 block;
+	int err;
+
+	TRACE();
+	block = logfs_get_free_block(super, level, inode, (__force pos_t) pos);
+	if (block < 0) {
+		BUG();
+		return block;
+	}
+
+	err = mtdwrite(mtd, block, PAGE_CACHE_SIZE, buf);
+	if (err) {
+		BUG();
+		return err;
+	}
+	return block;
+}
+
+
+static s64 logfs_write_block(struct logfs_super *super, void *buf, int level,
+		u64 inode, pgoff_t index)
+{
+	u64 pos = (u64)index * super->s_blocksize;
+	return __logfs_write_block(super, buf, level, inode, pos);
+}
+
+
+static void __logfs_set_blocks(struct inode *inode)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+
+	inode->i_blocks = ULONG_MAX;
+	if (li->li_blocks<<3 < ULONG_MAX)
+		inode->i_blocks = li->li_blocks<<3;
+}
+
+
+void logfs_set_blocks(struct inode *inode, u64 no)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+
+	li->li_blocks = no;
+	__logfs_set_blocks(inode);
+}
+
+
+static void logfs_add_blocks(struct inode *inode, u64 no)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+
+	BUG_ON(li->li_blocks + no < no); /* wraps are bad, mkay */
+	li->li_blocks += no;
+	__logfs_set_blocks(inode);
+}
+
+
+static void logfs_remove_blocks(struct inode *inode, u64 no, u64 ofs)
+{
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	struct logfs_inode *li = LOGFS_INODE(inode);
+
+	BUG_ON(li->li_blocks < no);
+	li->li_blocks -= no;
+	__logfs_set_blocks(inode);
+	super->s_free += no;
+}
+
+
+/* FIXME: s_free needs to be decremented as well */
+static int logfs_alloc_blocks(struct inode *inode, int no)
+{
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+
+	if (!no)
+		return 0;
+
+	//printk("%3llx %2x %2llx\n", super->s_free, no, super->s_gc_reserve);
+	if (super->s_free < no + super->s_gc_reserve)
+		return -ENOSPC;
+
+	super->s_free -= no;
+	logfs_add_blocks(inode, no);
+	return 0;
+}
+
+
+static int logfs_dirty_inode(struct inode *inode)
+{
+	TRACE();
+	if (inode->i_ino == LOGFS_INO_MASTER)
+		return logfs_write_anchor(inode);
+
+	mark_inode_dirty(inode);
+	return 0;
+}
+
+
+/*
+ * File is too large for embedded data when called.  Move data to first
+ * block and clear embedded area
+ */
+static int logfs_move_embedded(struct inode *inode, be64 **wblocks)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	void *buf;
+	s64 block;
+	int i;
+
+	TRACE();
+	if (! (li->li_flags & LOGFS_IF_EMBEDDED))
+		return 0;
+
+	if (logfs_alloc_blocks(inode, 1))
+		return -ENOSPC;
+
+	buf = wblocks[0];
+
+	memcpy(buf, li->li_data, LOGFS_EMBEDDED_SIZE);
+	block = logfs_write_block(super, buf, 0, inode->i_ino, 0);
+	if (block < 0)
+		return block;
+
+	li->li_data[0] = block;
+
+	li->li_flags &= ~LOGFS_IF_EMBEDDED;
+	for (i=1; i<LOGFS_EMBEDDED_FIELDS; i++)
+		li->li_data[i] = 0;
+
+	return logfs_dirty_inode(inode);
+}
+
+
+static int logfs_write_embedded(struct inode *inode, void *buf)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	void *dst = li->li_data;
+
+	TRACE();
+	//printk("inode->i_size: %lld\n", i_size_read(inode));
+	memcpy(dst, buf, max((long long)LOGFS_EMBEDDED_SIZE, i_size_read(inode)));
+
+	li->li_flags |= LOGFS_IF_EMBEDDED;
+	logfs_set_blocks(inode, 0);
+
+	return logfs_dirty_inode(inode);
+}
+
+
+static int logfs_write_direct(struct inode *inode, pgoff_t index, void *buf)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	s64 block;
+
+	TRACE();
+	if (! li->li_data[index])
+		if (logfs_alloc_blocks(inode, 1))
+			return -ENOSPC;
+
+	block = logfs_write_block(super, buf, 0, inode->i_ino, index);
+	if (block < 0)
+		return block;
+
+	li->li_data[index] = block;
+
+	return logfs_dirty_inode(inode);
+}
+
+
+static int logfs_write_loop(struct inode *inode, pgoff_t index, void *buf,
+		be64 **wblocks, int count)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	struct mtd_info *mtd = super->s_mtd;
+	u64 bofs = li->li_data[I1_INDEX + count];
+	s64 block;
+	int bits = LOGFS_BLOCK_BITS;
+	int allocs = 0;
+	int i, ret;
+
+	for (i=count; i>=0; i--) {
+		if (bofs) {
+			ret = mtdread(mtd, bofs, LOGFS_BLOCKSIZE, wblocks[i]);
+			if (ret)
+				return ret;
+		} else {
+			allocs++;
+			memset(wblocks[i], 0, LOGFS_BLOCKSIZE);
+		}
+		bofs = be64_to_cpu(wblocks[i][get_bits(index, i*bits, bits)]);
+	}
+
+	if (! wblocks[0][get_bits(index, 0, bits)])
+		allocs++;
+	if (logfs_alloc_blocks(inode, allocs))
+		return -ENOSPC;
+
+	block = logfs_write_block(super, buf, 0, inode->i_ino, index);
+	if (block < 0)
+		return block;
+
+	for (i=0; i<=count; i++) {
+		wblocks[i][get_bits(index, i*bits, bits)] = cpu_to_be64(block);
+		block = logfs_write_block(super, wblocks[i], 1, inode->i_ino,
+				index);
+		if (block < 0)
+			return block;
+	}
+
+	li->li_data[I1_INDEX + count] = block;
+
+	return logfs_dirty_inode(inode);
+}
+
+
+static int __logfs_write_buf(struct inode *inode, pgoff_t index, void *buf,
+		be64 **wblocks)
+{
+	u64 size = i_size_read(inode);
+	int err;
+
+	TRACE();
+
+	inode->i_ctime.tv_sec = inode->i_mtime.tv_sec = get_seconds();
+
+	if (size <= LOGFS_EMBEDDED_SIZE)
+		return logfs_write_embedded(inode, buf);
+
+	err = logfs_move_embedded(inode, wblocks);
+	if (err)
+		return err;
+
+	if (index < I0_BLOCKS)
+		return logfs_write_direct(inode, index, buf);
+	if (index < I1_BLOCKS)
+		return logfs_write_loop(inode, index, buf, wblocks, 0);
+	if (index < I2_BLOCKS)
+		return logfs_write_loop(inode, index, buf, wblocks, 1);
+	if (index < I3_BLOCKS)
+		return logfs_write_loop(inode, index, buf, wblocks, 2);
+
+	BUG();
+	return -EIO;
+}
+
+
+int logfs_write_buf(struct inode *inode, pgoff_t index, void *buf)
+{
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	be64 **wblocks;
+	int ret;
+
+	wblocks = logfs_get_wblocks(super);
+	ret = __logfs_write_buf(inode, index, buf, wblocks);
+	logfs_put_wblocks(super);
+	return ret;
+}
+
+
+static int logfs_rewrite_direct(struct inode *inode, pgoff_t index, void *buf)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	struct mtd_info *mtd = super->s_mtd;
+	s64 block;
+	int err;
+
+	TRACE();
+	block = li->li_data[index];
+	BUG_ON(! block);
+
+	err = mtdread(mtd, block, LOGFS_BLOCKSIZE, buf);
+	if (err)
+		return err;
+
+	block = logfs_write_block(super, buf, 0, inode->i_ino, index);
+	if (block < 0)
+		return block;
+
+	li->li_data[index] = block;
+
+	return logfs_dirty_inode(inode);
+}
+
+
+static int logfs_rewrite_loop(struct inode *inode, pgoff_t index, void *buf,
+		be64 **wblocks, int count)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	struct mtd_info *mtd = super->s_mtd;
+	u64 bofs = li->li_data[I1_INDEX + count];
+	s64 block;
+	int bits = LOGFS_BLOCK_BITS;
+	int i, err;
+
+	for (i=count; i>=0; i--) {
+		if (bofs) {
+			err = mtdread(mtd, bofs, LOGFS_BLOCKSIZE, wblocks[i]);
+			if (err)
+				return err;
+		} else {
+			BUG();
+		}
+		bofs = be64_to_cpu(wblocks[i][get_bits(index, i*bits, bits)]);
+	}
+
+	block = be64_to_cpu(wblocks[0][get_bits(index, 0, bits)]);
+	BUG_ON(! block);
+
+	err = mtdread(mtd, block, LOGFS_BLOCKSIZE, buf);
+	if (err)
+		return err;
+
+	block = logfs_write_block(super, buf, 0, inode->i_ino, index);
+	if (block < 0)
+		return block;
+
+	for (i=0; i<=count; i++) {
+		wblocks[i][get_bits(index, i*bits, bits)] = cpu_to_be64(block);
+		block = logfs_write_block(super, wblocks[i], 1, inode->i_ino,
+				index);
+		if (block < 0)
+			return block;
+	}
+
+	li->li_data[I1_INDEX + count] = block;
+
+	return logfs_dirty_inode(inode);
+}
+
+
+static int __logfs_rewrite_block(struct inode *inode, pgoff_t index, void *buf,
+		be64 **wblocks)
+{
+	TRACE();
+
+	if (index < I0_BLOCKS)
+		return logfs_rewrite_direct(inode, index, buf);
+	if (index < I1_BLOCKS)
+		return logfs_rewrite_loop(inode, index, buf, wblocks, 0);
+	if (index < I2_BLOCKS)
+		return logfs_rewrite_loop(inode, index, buf, wblocks, 1);
+	if (index < I3_BLOCKS)
+		return logfs_rewrite_loop(inode, index, buf, wblocks, 2);
+
+	BUG();
+	return -EIO;
+}
+
+
+int logfs_rewrite_block(struct inode *inode, pgoff_t index, u64 ofs, void *buf)
+{
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	be64 **wblocks;
+	int ret;
+
+	wblocks = super->s_wblock;
+	buf = wblocks[LOGFS_MAX_INDIRECT];
+	ret = __logfs_rewrite_block(inode, index, buf, wblocks);
+	return ret;
+}
+
+
+/**
+ * Three cases exist:
+ * size <= pos			- remove full block
+ * size >= pos + chunk		- do nothing
+ * pos < size < pos + chunk	- truncate, rewrite
+ */
+static s64 __logfs_truncate_i0(struct inode *inode, u64 size, u64 bofs,
+		u64 pos, be64 **wblocks)
+{
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	struct mtd_info *mtd = super->s_mtd;
+	size_t len = size - pos;
+	void *buf = wblocks[LOGFS_MAX_INDIRECT];
+	int err;
+
+	if (size <= pos) {	/* remove whole block */
+		logfs_remove_blocks(inode, 1, bofs);
+		return 0;
+	}
+
+	/* truncate this block, rewrite it */
+	memset(buf, 0, LOGFS_BLOCKSIZE);
+	err = mtdread(mtd, bofs, len, buf);
+	if (err)
+		return err;
+
+	return __logfs_write_block(super, buf, 0, inode->i_ino, pos);
+}
+
+
+/* FIXME: move to super */
+static u64 logfs_factor[] = {
+	LOGFS_BLOCKSIZE,
+	LOGFS_I1_SIZE,
+	LOGFS_I2_SIZE,
+	LOGFS_I3_SIZE
+};
+
+
+static u64 logfs_start[] = {
+	LOGFS_I0_SIZE,
+	LOGFS_I1_SIZE,
+	LOGFS_I2_SIZE,
+	LOGFS_I3_SIZE
+};
+
+
+/*
+ * One recursion per indirect block.  Logfs supports 5fold indirect blocks.
+ */
+static s64 __logfs_truncate_loop(struct inode *inode, u64 size, u64 old_bofs,
+		u64 pos, be64 **wblocks, int i)
+{
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	struct mtd_info *mtd = super->s_mtd;
+	s64 ofs;
+	int e, ret;
+
+	ret = mtdread(mtd, old_bofs, LOGFS_BLOCKSIZE, wblocks[i]);
+	if (ret)
+		return ret;
+
+	for (e = LOGFS_BLOCK_FACTOR-1; e>=0; e--) {
+		u64 bofs;
+		u64 new_pos = pos + e*logfs_factor[i];
+
+		if (size >= new_pos + logfs_factor[i])
+			break;
+
+		bofs = be64_to_cpu(wblocks[i][e]);
+		if (!bofs)
+			continue;
+
+		BUG_ON(bofs > super->s_size);
+
+		if (i)
+			ofs = __logfs_truncate_loop(inode, size, bofs, new_pos,
+					wblocks, i-1);
+		else
+			ofs = __logfs_truncate_i0(inode, size, bofs, new_pos,
+					wblocks);
+		if (ofs < 0)
+			return ofs;
+
+		wblocks[i][e] = cpu_to_be64(ofs);
+	}
+
+	if (size <= max(pos, logfs_start[i])) {
+		/* complete indirect block is removed */
+		logfs_remove_blocks(inode, 1, old_bofs);
+		return 0;
+	}
+
+	/* partially removed - write back */
+	return __logfs_write_block(super, wblocks[i], 1, inode->i_ino, pos);
+}
+
+
+static int logfs_truncate_direct(struct inode *inode, u64 size, be64 **wblocks)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	int e;
+	s64 bofs, ofs;
+
+	for (e = I1_INDEX-1; e>=0; e--) {
+		u64 new_pos = e*logfs_factor[0];
+
+		if (size > e*logfs_factor[0])
+			break;
+
+		bofs = li->li_data[e];
+		if (!bofs)
+			continue;
+
+		ofs = __logfs_truncate_i0(inode, size, bofs, new_pos, wblocks);
+		if (ofs < 0)
+			return ofs;
+
+		li->li_data[e] = ofs;
+	}
+	return 0;
+}
+
+
+static int logfs_truncate_loop(struct inode *inode, u64 size, be64 **wblocks,
+		int i)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	u64 bofs = li->li_data[I1_INDEX + i];
+	s64 ofs;
+
+	if (!bofs)
+		return 0;
+
+	ofs = __logfs_truncate_loop(inode, size, bofs, 0, wblocks, i);
+	if (ofs < 0)
+		return ofs;
+
+	li->li_data[I1_INDEX + i] = ofs;
+	return 0;
+}
+
+
+static void logfs_truncate_embedded(struct inode *inode, u64 size)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	void *buf = (void*)li->li_data + size;
+	size_t len = LOGFS_EMBEDDED_SIZE - size;
+
+	TRACE();
+	if (size >= LOGFS_EMBEDDED_SIZE)
+		return;
+	memset(buf, 0, len);
+}
+
+
+/* TODO: might make sense to turn inode into embedded again */
+static void __logfs_truncate(struct inode *inode, be64 **wblocks)
+{
+	struct logfs_inode *li = LOGFS_INODE(inode);
+	u64 size = i_size_read(inode);
+	int ret;
+
+	if (li->li_flags & LOGFS_IF_EMBEDDED)
+		return logfs_truncate_embedded(inode, size);
+
+	if (size >= logfs_factor[3])
+		return;
+	ret = logfs_truncate_loop(inode, size, wblocks, 2);
+	BUG_ON(ret);
+
+	if (size >= logfs_factor[2])
+		return;
+	ret = logfs_truncate_loop(inode, size, wblocks, 1);
+	BUG_ON(ret);
+
+	if (size >= logfs_factor[1])
+		return;
+	ret = logfs_truncate_loop(inode, size, wblocks, 0);
+	BUG_ON(ret);
+
+	ret = logfs_truncate_direct(inode, size, wblocks);
+	BUG_ON(ret);
+}
+
+
+void logfs_truncate(struct inode *inode)
+{
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	be64 **wblocks;
+
+	wblocks = logfs_get_wblocks(super);
+	__logfs_truncate(inode, wblocks);
+	logfs_put_wblocks(super);
+	mark_inode_dirty(inode);
+}
+
+
+static ssize_t __logfs_inode_write(struct inode *inode, const char *buf,
+		size_t count, loff_t *ppos)
+{
+	void *block_data = NULL;
+	int err = -ENOMEM;
+
+	TRACE();
+	pr_debug("write to 0x%llx, count %zd\n", *ppos, count);
+
+	BUG_ON(logfs_index(*ppos) != logfs_index(*ppos + count - 1));
+
+	block_data = kzalloc(LOGFS_BLOCKSIZE, GFP_KERNEL);
+	if (!block_data)
+		goto fail;
+
+	err = logfs_read_block(inode, logfs_index(*ppos), block_data);
+	if (err)
+		goto fail;
+
+	memcpy(block_data + (*ppos % LOGFS_BLOCKSIZE), buf, count);
+
+	if (i_size_read(inode) < *ppos + count)
+		i_size_write(inode, *ppos + count);
+
+	err = logfs_write_buf(inode, logfs_index(*ppos), block_data);
+	if (err)
+		goto fail;
+
+	*ppos += count;
+	pr_debug("write to %lld, count %zd\n", *ppos, count);
+	kfree(block_data);
+	return count;
+fail:
+	kfree(block_data);
+	return err;
+}
+
+
+int logfs_inode_read(struct inode *inode, void *buf, size_t n, loff_t _pos)
+{
+	loff_t pos = _pos;
+	ssize_t ret;
+
+	TRACE();
+	if (pos >= i_size_read(inode))
+		return -EOF;
+	ret = __logfs_inode_read(inode, buf, n, &pos);
+	ret = ret==n ? 0 : -EIO;
+	return ret;
+}
+
+
+int logfs_inode_write_nolock(struct inode *inode, const void *buf, size_t n,
+		loff_t _pos)
+{
+	loff_t pos = _pos;
+	ssize_t ret;
+
+	TRACE();
+	ret = __logfs_inode_write(inode, buf, n, &pos);
+	ret = ret==n ? 0 : -EIO;
+	return ret;
+}
+
+
+int logfs_inode_write(struct inode *inode, const void *buf, size_t n,
+		loff_t pos)
+{
+	struct logfs_super *super = LOGFS_SUPER(inode->i_sb);
+	int ret;
+
+	mutex_lock(&super->s_write_inode_mutex);
+	ret = logfs_inode_write_nolock(inode, buf, n, pos);
+	mutex_unlock(&super->s_write_inode_mutex);
+	return ret;
+}
+
+
+int logfs_inode_write_loop(struct inode *inode, const void *buf, size_t n,
+		loff_t _pos)
+{
+	loff_t pos = _pos;
+	int ret;
+
+	while (n > LOGFS_BLOCKSIZE) {
+		ret = logfs_inode_write(inode, buf, LOGFS_BLOCKSIZE, pos);
+		if (ret)
+			return ret;
+		pos += LOGFS_BLOCKSIZE;
+		buf += LOGFS_BLOCKSIZE;
+		n -= LOGFS_BLOCKSIZE;
+	}
+	return logfs_inode_write(inode, buf, n, pos);
+}
+
+
+int logfs_init_rw(struct logfs_super *super)
+{
+	int i;
+
+	mutex_init(&super->s_r_sem);
+	mutex_init(&super->s_w_sem);
+	super->s_rblock = kmalloc(LOGFS_BLOCKSIZE, GFP_KERNEL);
+	if (!super->s_wblock)
+		return -ENOMEM;
+	for (i=0; i<=LOGFS_MAX_INDIRECT; i++) {
+		super->s_wblock[i] = kmalloc(LOGFS_BLOCKSIZE, GFP_KERNEL);
+		if (!super->s_wblock) {
+			logfs_cleanup_rw(super);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+
+void logfs_cleanup_rw(struct logfs_super *super)
+{
+	int i;
+
+	for (i=0; i<=LOGFS_MAX_INDIRECT; i++)
+		kfree(super->s_wblock[i]);
+	kfree(super->s_rblock);
+}
--- /dev/null	2006-08-15 20:12:53.000000000 +0200
+++ logfs3/fs/logfs/super.c	2006-08-24 15:39:42.000000000 +0200
@@ -0,0 +1,435 @@
+#include <linux/fs.h>
+#include <linux/mtd/mtd.h>
+#include <linux/pagemap.h>
+#include <linux/statfs.h>
+
+#include "logfs.h"
+
+
+#define FAIL_ON(cond) do { if (unlikely((cond))) return -EINVAL; } while(0)
+
+int mtdread(struct mtd_info *mtd, loff_t ofs, size_t len, void *buf)
+{
+	size_t retlen;
+	int ret;
+
+	TRACE();
+	ret = mtd->read(mtd, ofs, len, &retlen, buf);
+	if (ret || (retlen != len)) {
+		printk("ret: %d\n", ret);
+		printk("retlen: %d, len: %d\n", retlen, len);
+		printk("ofs: %lld, mtd->size: %d\n", ofs, mtd->size);
+		dump_stack();
+		return -EIO;
+	}
+
+	return 0;
+}
+
+
+int mtdwrite(struct mtd_info *mtd, loff_t ofs, size_t len, void *buf)
+{
+	size_t retlen;
+	int ret;
+
+	TRACE();
+	//printk("write ofs=%llx, len=%x\n", ofs, len);
+	BUG_ON((ofs >= mtd->size) || (len > mtd->size - ofs));
+	ret = mtd->write(mtd, ofs, len, &retlen, buf);
+	if (ret || (retlen != len))
+		return -EIO;
+
+	return 0;
+}
+
+
+static DEFINE_MUTEX(logfs_erase_sem);
+static void logfs_erase_callback(struct erase_info *ei)
+{
+	mutex_unlock(&logfs_erase_sem);
+}
+int mtderase(struct mtd_info *mtd, loff_t ofs, size_t len)
+{
+	struct erase_info ei;
+	int ret;
+
+	TRACE();
+	BUG_ON(len % mtd->erasesize);
+
+	memset(&ei, 0, sizeof(ei));
+	ei.mtd = mtd;
+	ei.addr = ofs;
+	ei.len = len;
+	ei.callback = logfs_erase_callback;
+	ret = mtd->erase(mtd, &ei);
+	if (ret)
+		return -EIO;
+	mutex_lock(&logfs_erase_sem);
+	return 0;
+}
+
+
+int logfs_statfs(struct dentry *dentry, struct kstatfs *stats)
+{
+	struct logfs_super *super = LOGFS_SUPER(dentry->d_sb);
+
+	stats->f_type	= LOGFS_MAGIC_U32;
+	stats->f_bsize	= LOGFS_BLOCKSIZE;
+	stats->f_blocks	= super->s_size >> LOGFS_BLOCK_BITS >> 3;
+	stats->f_bfree	= super->s_free;
+	stats->f_bavail	= super->s_free; /* FIXME: leave some for root */
+	stats->f_files	= 0;
+	stats->f_ffree	= 0;
+	stats->f_namelen= LOGFS_MAX_NAMELEN;
+	return 0;
+}
+
+
+static int logfs_sb_set(struct super_block *sb, void *_super)
+{
+	struct logfs_super *super = _super;
+
+	TRACE();
+	sb->s_fs_info = super;
+	sb->s_dev = MKDEV(MTD_BLOCK_MAJOR, super->s_mtd->index);
+
+	return 0;
+}
+
+
+/*
+ * FIXME: the error recovery logic appears to be wrong.  redo.
+ */
+static int logfs_get_sb_final(struct super_block *sb, struct vfsmount *mnt)
+{
+	struct inode *inode;
+
+	TRACE();
+
+	/* root dir */
+	inode = iget(sb, LOGFS_INO_ROOT);
+	if (!inode)
+		goto fail;
+
+	sb->s_root = d_alloc_root(inode);
+	if (!sb->s_root)
+		goto fail1;
+
+	return simple_set_mnt(mnt, sb);
+
+fail1:
+	iput(inode);
+fail:
+	iput(LOGFS_SUPER(sb)->s_master_inode);
+	return -EIO;
+}
+
+
+static int logfs_mkfs_rootdir(struct logfs_super *super,
+		struct logfs_disk_super *ds, u32 seg_size)
+{
+	struct logfs_disk_inode *di;
+	u64 root_ofs;
+	int ret;
+
+	di = kzalloc(sizeof(*di), GFP_KERNEL);
+	if (!di)
+		return -ENOMEM;
+
+	di->di_flags	= cpu_to_be32(LOGFS_IF_VALID);
+	di->di_mode	= cpu_to_be16(S_IFDIR | 0755);
+	di->di_refcount	= cpu_to_be32(2);
+	root_ofs = 3*seg_size + LOGFS_INO_ROOT*sizeof(*di);
+	ret = mtdwrite(super->s_mtd, root_ofs, sizeof(*di), di);
+	kfree(di);
+	return ret;
+}
+
+
+static int logfs_mkfs_summary(struct logfs_super *super,
+		struct logfs_disk_super *ds, u32 seg_size)
+{
+	struct logfs_disk_sum *sum;
+	u64 sum_ofs;
+	int ret;
+
+	sum = kmalloc(LOGFS_BLOCKSIZE, GFP_KERNEL);
+	if (!sum)
+		return -ENOMEM;
+	memset(sum, 0xff, LOGFS_BLOCKSIZE);
+
+	sum->blocks[0].ino = cpu_to_be64(LOGFS_INO_MASTER);
+	sum->blocks[0].pos = cpu_to_be64(0);
+	sum_ofs = 4*seg_size - LOGFS_BLOCKSIZE;
+	sum->level = LOGFS_MAX_LEVELS;
+	ret = mtdwrite(super->s_mtd, sum_ofs, LOGFS_BLOCKSIZE, sum);
+	kfree(sum);
+	return ret;
+}
+
+
+static int logfs_mkfs_anchor(struct logfs_super *super,
+		struct logfs_disk_super *ds, u32 seg_size)
+{
+	struct logfs_journal_entry *je;
+	int ret;
+
+	je = kzalloc(sizeof(*je), GFP_KERNEL);
+	if (!je)
+		return -ENOMEM;
+
+	je->je_type = cpu_to_be16(JE_ANCHOR);
+	je->je_version = cpu_to_be64(1);
+	je->da.da_gec = 0;
+	je->da.da_maxec = 0;
+	je->da.da_sweeper = cpu_to_be64(4);
+	je->da.da_last_ino = cpu_to_be64(LOGFS_RESERVED_INOS);
+	je->da.da_size = cpu_to_be64((LOGFS_INO_ROOT+1)
+			* sizeof(struct logfs_disk_inode));
+	je->da.da_data[0] = cpu_to_be64(3*seg_size);
+	ret = mtdwrite(super->s_mtd, seg_size, sizeof(*je), je);
+	kfree(je);
+	return ret;
+}
+
+
+static int logfs_mkfs_super(struct logfs_super *super,
+		struct logfs_disk_super *ds, u32 seg_size, u32 block_size)
+{
+	u64 no_segments;
+	u64 size;
+	u32 mod;
+	int sum_start;
+	int no_blocks;
+
+	ds->ds_magic = cpu_to_be64(LOGFS_MAGIC);
+	ds->ds_segment_size = cpu_to_be32(seg_size);
+	ds->ds_block_size = cpu_to_be32(block_size);
+
+	ds->ds_journal_ofs = cpu_to_be64(seg_size);
+	ds->ds_journal_len = cpu_to_be64(2*seg_size);
+
+	ds->ds_root_reserve = 0;
+
+	size = super->s_mtd->size; /* size must be a multiple of seg_size */
+	mod = do_div(size, seg_size);
+	no_segments = size;
+	size = super->s_mtd->size - mod;
+	ds->ds_filesystem_size = cpu_to_be64(size);
+
+#if 0	/* sane defaults */
+	ds->ds_ifile_levels	= 3; /* 2+1, 1GiB */
+	ds->ds_iblock_levels	= 4; /* 3+1, 512GiB */
+	ds->ds_data_levels	= 3; /* old, young, unknown */
+#else
+	ds->ds_ifile_levels	= 1; /* 0+1, 80kiB */
+	ds->ds_iblock_levels	= 4; /* 3+1, 512GiB */
+	ds->ds_data_levels	= 1; /* unknown */
+#endif
+
+	ds->ds_anchor_size = cpu_to_be32(block_size);
+	no_blocks = seg_size / block_size;
+	sum_start  = block_size;
+	sum_start -= LOGFS_SEGMENTS * no_blocks * sizeof(struct logfs_block);
+	BUG_ON(sum_start < 2048);
+	ds->ds_sum_start = cpu_to_be32(sum_start);
+	return mtdwrite(super->s_mtd, 0, sizeof(*ds), ds);
+}
+
+
+static int logfs_mkfs(struct logfs_super *super, struct logfs_disk_super *ds)
+{
+	u32 seg_size = 1<<15;
+	u32 block_size = 1<<12;
+	int ret = 0;
+
+	TRACE();
+
+	ret = logfs_mkfs_rootdir(super, ds, seg_size);
+	if (ret)
+		return ret;
+
+	ret = logfs_mkfs_summary(super, ds, seg_size);
+	if (ret)
+		return ret;
+
+	ret = logfs_mkfs_anchor(super, ds, seg_size);
+	if (ret)
+		return ret;
+
+	ret = logfs_mkfs_super(super, ds, seg_size, block_size);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+
+static int logfs_read_sb(struct super_block *sb)
+{
+	struct logfs_super *super = LOGFS_SUPER(sb);
+	struct logfs_disk_super ds;
+	int ret;
+
+	TRACE();
+	ret = mtdread(super->s_mtd, 0, sizeof(ds), &ds);
+	if (ret)
+		return ret;
+
+	if (be64_to_cpu(ds.ds_magic) != LOGFS_MAGIC) {
+		ret = logfs_mkfs(super, &ds);
+		if (ret)
+			return ret;
+	}
+	super->s_segsize = be32_to_cpu(ds.ds_segment_size);
+	super->s_blocksize = be32_to_cpu(ds.ds_block_size);
+	super->s_no_blocks = super->s_segsize / super->s_blocksize;
+
+	super->s_log_ofs = be64_to_cpu(ds.ds_journal_ofs);
+	super->s_log_len = be64_to_cpu(ds.ds_journal_len);
+	super->s_size = be64_to_cpu(ds.ds_filesystem_size);
+	super->s_anchor_size = be32_to_cpu(ds.ds_anchor_size);
+	super->s_sum_start = be32_to_cpu(ds.ds_sum_start);
+	super->s_root_reserve = be64_to_cpu(ds.ds_root_reserve);
+
+
+	super->s_ifile_levels = ds.ds_ifile_levels;
+	super->s_iblock_levels = ds.ds_iblock_levels;
+	super->s_data_levels = ds.ds_data_levels;
+	super->s_total_levels = super->s_ifile_levels + super->s_iblock_levels
+		+ super->s_data_levels;
+	super->s_gc_reserve = super->s_total_levels * (2*super->s_no_blocks -1);
+
+	/* FIXME: store data in flash superblock */
+	mutex_init(&super->s_write_inode_mutex);
+
+	ret = logfs_init_rw(super);
+	if (ret)
+		return ret;
+
+	ret = logfs_init_segments(super);
+	if (ret)
+		return ret;
+
+	ret = logfs_init_log(sb);
+	if (ret)
+		return ret;
+
+	ret = logfs_init_gc(super);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&super->s_ino_lock);
+	return 0;
+}
+
+
+static void logfs_kill_sb(struct super_block *sb)
+{
+	struct logfs_super *super = LOGFS_SUPER(sb);
+
+	TRACE();
+	generic_shutdown_super(sb);
+	logfs_cleanup_gc(super);
+	logfs_cleanup_log(sb);
+	logfs_cleanup_segments(super);
+	logfs_cleanup_rw(super);
+	put_mtd_device(super->s_mtd);
+	kfree(super);
+}
+
+
+static int logfs_get_sb_mtd(struct file_system_type *type, int flags,
+		struct mtd_info *mtd, struct vfsmount *mnt)
+{
+	struct logfs_super *super = NULL;
+	struct super_block *sb;
+	int err = -ENOMEM;
+
+	TRACE();
+	super = kzalloc(sizeof*super, GFP_KERNEL);
+	if (!super)
+		goto err0;
+
+	super->s_mtd = mtd;
+	err = -EINVAL;
+	sb = sget(type, NULL, logfs_sb_set, super);
+	if (IS_ERR(sb))
+		goto err0;
+
+	sb->s_maxbytes	= LOGFS_I3_SIZE;
+	sb->s_op	= &logfs_super_operations;
+	sb->s_flags	= flags | MS_NOATIME;
+
+	super->s_sb = sb;
+	err = logfs_read_sb(sb);
+	if (err)
+		goto err0;
+
+	sb->s_flags |= MS_ACTIVE;
+	return logfs_get_sb_final(sb, mnt);
+
+err0:
+	kfree(super);
+	put_mtd_device(mtd);
+	return err;
+}
+
+
+static int logfs_get_sb(struct file_system_type *type, int flags,
+		const char *devname, void *data, struct vfsmount *mnt)
+{
+	ulong mtdnr;
+	struct mtd_info *mtd;
+
+	TRACE();
+#if 0
+	if (!devname)
+		return ERR_PTR(-EINVAL);
+	if (strncmp(devname, "mtd", 3))
+		return ERR_PTR(-EINVAL);
+
+	{
+		char *garbage;
+		mtdnr = simple_strtoul(devname+3, &garbage, 0);
+		if (*garbage)
+			return ERR_PTR(-EINVAL);
+	}
+#else
+	mtdnr = 0;
+#endif
+
+	mtd = get_mtd_device(NULL, mtdnr);
+	if (!mtd)
+		return -EINVAL;
+
+	return logfs_get_sb_mtd(type, flags, mtd, mnt);
+}
+
+
+static struct file_system_type logfs_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "logfs",
+	.get_sb		= logfs_get_sb,
+	.kill_sb	= logfs_kill_sb,
+};
+
+
+static int __init logfs_init(void)
+{
+	int ret = logfs_init_inode_cache();
+	if (ret)
+		return ret;
+	return register_filesystem(&logfs_fs_type);
+}
+
+
+static void __exit logfs_exit(void)
+{
+	unregister_filesystem(&logfs_fs_type);
+	logfs_destroy_inode_cache();
+}
+
+
+module_init(logfs_init);
+module_exit(logfs_exit);
