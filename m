Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbUK2XIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbUK2XIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUK2Wxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:53:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62105 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261864AbUK2WoM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:44:12 -0500
Date: Mon, 29 Nov 2004 22:44:04 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com, zippel@linux-m68k.org
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041129224404.GP26051@parcelfarce.linux.theplanet.co.uk>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk> <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com> <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Speaking of include/* cleanups, here's a work of about 10 minutes
(and yes, result does build):

*	private stuff moved into fs/affs/affs.h
*	include/linux/affs_fs_{i,sb}.h removed, since they do not contain
anything that might be used outside of fs/affs/*
*	includes in fs/affs/* trimmed (as the matter of fact, only super.c
needed something not pulled by affs.h)
*	duplicate MODULE_LICENSE removed from fs/affs/inode.c (fs/affs/super.c
already has exact same thing)
*	bogus extern (affs_fs()) removed (used to be in affs_fs.h, function
in question simply doesn't exist)

That leaves affs_fs.h containing only AFFS_SUPER_MAGIC declaration and
amigaffs.h also seriously cleaned up; it still has a bunch of defines that
are almost certainly never used in userland (they refer to ->b_data and
in-core affs superblock), but these might in theory be useful (similar
stuff for ext2 *is* used by userland code).

If Roman is OK with their removal, AFFS_DATA and friends should also get
moved to fs/affs/affs.h.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC10-rc2-bk12-base/fs/affs/affs.h RC10-rc2-bk12-current/fs/affs/affs.h
--- RC10-rc2-bk12-base/fs/affs/affs.h	1969-12-31 19:00:00.000000000 -0500
+++ RC10-rc2-bk12-current/fs/affs/affs.h	2004-11-29 17:20:17.536489880 -0500
@@ -0,0 +1,283 @@
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/buffer_head.h>
+#include <linux/affs_fs.h>
+#include <linux/amigaffs.h>
+
+#define AFFS_CACHE_SIZE		PAGE_SIZE
+
+#define AFFS_MAX_PREALLOC	32
+#define AFFS_LC_SIZE		(AFFS_CACHE_SIZE/sizeof(u32)/2)
+#define AFFS_AC_SIZE		(AFFS_CACHE_SIZE/sizeof(struct affs_ext_key)/2)
+#define AFFS_AC_MASK		(AFFS_AC_SIZE-1)
+
+struct affs_ext_key {
+	u32	ext;				/* idx of the extended block */
+	u32	key;				/* block number */
+};
+
+/*
+ * affs fs inode data in memory
+ */
+struct affs_inode_info {
+	u32	 i_opencnt;
+	struct semaphore i_link_lock;		/* Protects internal inode access. */
+	struct semaphore i_ext_lock;		/* Protects internal inode access. */
+#define i_hash_lock i_ext_lock
+	u32	 i_blkcnt;			/* block count */
+	u32	 i_extcnt;			/* extended block count */
+	u32	*i_lc;				/* linear cache of extended blocks */
+	u32	 i_lc_size;
+	u32	 i_lc_shift;
+	u32	 i_lc_mask;
+	struct affs_ext_key *i_ac;		/* associative cache of extended blocks */
+	u32	 i_ext_last;			/* last accessed extended block */
+	struct buffer_head *i_ext_bh;		/* bh of last extended block */
+	loff_t	 mmu_private;
+	u32	 i_protect;			/* unused attribute bits */
+	u32	 i_lastalloc;			/* last allocated block */
+	int	 i_pa_cnt;			/* number of preallocated blocks */
+#if 0
+	s32	 i_original;			/* if != 0, this is the key of the original */
+	u32	 i_data[AFFS_MAX_PREALLOC];	/* preallocated blocks */
+	int	 i_cache_users;			/* Cache cannot be freed while > 0 */
+	unsigned char i_hlink;			/* This is a fake */
+	unsigned char i_pad;
+	s32	 i_parent;			/* parent ino */
+#endif
+	struct inode vfs_inode;
+};
+
+/* short cut to get to the affs specific inode data */
+static inline struct affs_inode_info *AFFS_I(struct inode *inode)
+{
+	return list_entry(inode, struct affs_inode_info, vfs_inode);
+}
+
+/*
+ * super-block data in memory
+ *
+ * Block numbers are adjusted for their actual size
+ *
+ */
+
+struct affs_bm_info {
+	u32 bm_key;			/* Disk block number */
+	u32 bm_free;			/* Free blocks in here */
+};
+
+struct affs_sb_info {
+	int s_partition_size;		/* Partition size in blocks. */
+	int s_reserved;			/* Number of reserved blocks. */
+	//u32 s_blksize;			/* Initial device blksize */
+	u32 s_data_blksize;		/* size of the data block w/o header */
+	u32 s_root_block;		/* FFS root block number. */
+	int s_hashsize;			/* Size of hash table. */
+	unsigned long s_flags;		/* See below. */
+	uid_t s_uid;			/* uid to override */
+	gid_t s_gid;			/* gid to override */
+	umode_t s_mode;			/* mode to override */
+	struct buffer_head *s_root_bh;	/* Cached root block. */
+	struct semaphore s_bmlock;	/* Protects bitmap access. */
+	struct affs_bm_info *s_bitmap;	/* Bitmap infos. */
+	u32 s_bmap_count;		/* # of bitmap blocks. */
+	u32 s_bmap_bits;		/* # of bits in one bitmap blocks */
+	u32 s_last_bmap;
+	struct buffer_head *s_bmap_bh;
+	char *s_prefix;			/* Prefix for volumes and assigns. */
+	int s_prefix_len;		/* Length of prefix. */
+	char s_volume[32];		/* Volume prefix for absolute symlinks. */
+};
+
+#define SF_INTL		0x0001		/* International filesystem. */
+#define SF_BM_VALID	0x0002		/* Bitmap is valid. */
+#define SF_IMMUTABLE	0x0004		/* Protection bits cannot be changed */
+#define SF_QUIET	0x0008		/* chmod errors will be not reported */
+#define SF_SETUID	0x0010		/* Ignore Amiga uid */
+#define SF_SETGID	0x0020		/* Ignore Amiga gid */
+#define SF_SETMODE	0x0040		/* Ignore Amiga protection bits */
+#define SF_MUFS		0x0100		/* Use MUFS uid/gid mapping */
+#define SF_OFS		0x0200		/* Old filesystem */
+#define SF_PREFIX	0x0400		/* Buffer for prefix is allocated */
+#define SF_VERBOSE	0x0800		/* Talk about fs when mounting */
+
+/* short cut to get to the affs specific sb data */
+static inline struct affs_sb_info *AFFS_SB(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+/* amigaffs.c */
+
+extern int	affs_insert_hash(struct inode *inode, struct buffer_head *bh);
+extern int	affs_remove_hash(struct inode *dir, struct buffer_head *rem_bh);
+extern int	affs_remove_header(struct dentry *dentry);
+extern u32	affs_checksum_block(struct super_block *sb, struct buffer_head *bh);
+extern void	affs_fix_checksum(struct super_block *sb, struct buffer_head *bh);
+extern void	secs_to_datestamp(time_t secs, struct affs_date *ds);
+extern mode_t	prot_to_mode(u32 prot);
+extern void	mode_to_prot(struct inode *inode);
+extern void	affs_error(struct super_block *sb, const char *function, const char *fmt, ...);
+extern void	affs_warning(struct super_block *sb, const char *function, const char *fmt, ...);
+extern int	affs_check_name(const unsigned char *name, int len);
+extern int	affs_copy_name(unsigned char *bstr, struct dentry *dentry);
+
+/* bitmap. c */
+
+extern u32	affs_count_free_blocks(struct super_block *s);
+extern void	affs_free_block(struct super_block *sb, u32 block);
+extern u32	affs_alloc_block(struct inode *inode, u32 goal);
+extern int	affs_init_bitmap(struct super_block *sb, int *flags);
+extern void	affs_free_bitmap(struct super_block *sb);
+
+/* namei.c */
+
+extern int	affs_hash_name(struct super_block *sb, const u8 *name, unsigned int len);
+extern struct dentry *affs_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *);
+extern int	affs_unlink(struct inode *dir, struct dentry *dentry);
+extern int	affs_create(struct inode *dir, struct dentry *dentry, int mode, struct nameidata *);
+extern int	affs_mkdir(struct inode *dir, struct dentry *dentry, int mode);
+extern int	affs_rmdir(struct inode *dir, struct dentry *dentry);
+extern int	affs_link(struct dentry *olddentry, struct inode *dir,
+			  struct dentry *dentry);
+extern int	affs_symlink(struct inode *dir, struct dentry *dentry,
+			     const char *symname);
+extern int	affs_rename(struct inode *old_dir, struct dentry *old_dentry,
+			    struct inode *new_dir, struct dentry *new_dentry);
+
+/* inode.c */
+
+extern unsigned long		 affs_parent_ino(struct inode *dir);
+extern struct inode		*affs_new_inode(struct inode *dir);
+extern int			 affs_notify_change(struct dentry *dentry, struct iattr *attr);
+extern void			 affs_put_inode(struct inode *inode);
+extern void			 affs_delete_inode(struct inode *inode);
+extern void			 affs_clear_inode(struct inode *inode);
+extern void			 affs_read_inode(struct inode *inode);
+extern int			 affs_write_inode(struct inode *inode, int);
+extern int			 affs_add_entry(struct inode *dir, struct inode *inode, struct dentry *dentry, s32 type);
+
+/* file.c */
+
+void		affs_free_prealloc(struct inode *inode);
+extern void	affs_truncate(struct inode *);
+
+/* dir.c */
+
+extern void   affs_dir_truncate(struct inode *);
+
+/* jump tables */
+
+extern struct inode_operations	 affs_file_inode_operations;
+extern struct inode_operations	 affs_dir_inode_operations;
+extern struct inode_operations   affs_symlink_inode_operations;
+extern struct file_operations	 affs_file_operations;
+extern struct file_operations	 affs_file_operations_ofs;
+extern struct file_operations	 affs_dir_operations;
+extern struct address_space_operations	 affs_symlink_aops;
+extern struct address_space_operations	 affs_aops;
+extern struct address_space_operations	 affs_aops_ofs;
+
+extern struct dentry_operations	 affs_dentry_operations;
+extern struct dentry_operations	 affs_dentry_operations_intl;
+
+static inline void
+affs_set_blocksize(struct super_block *sb, int size)
+{
+	sb_set_blocksize(sb, size);
+}
+static inline struct buffer_head *
+affs_bread(struct super_block *sb, int block)
+{
+	pr_debug("affs_bread: %d\n", block);
+	if (block >= AFFS_SB(sb)->s_reserved && block < AFFS_SB(sb)->s_partition_size)
+		return sb_bread(sb, block);
+	return NULL;
+}
+static inline struct buffer_head *
+affs_getblk(struct super_block *sb, int block)
+{
+	pr_debug("affs_getblk: %d\n", block);
+	if (block >= AFFS_SB(sb)->s_reserved && block < AFFS_SB(sb)->s_partition_size)
+		return sb_getblk(sb, block);
+	return NULL;
+}
+static inline struct buffer_head *
+affs_getzeroblk(struct super_block *sb, int block)
+{
+	struct buffer_head *bh;
+	pr_debug("affs_getzeroblk: %d\n", block);
+	if (block >= AFFS_SB(sb)->s_reserved && block < AFFS_SB(sb)->s_partition_size) {
+		bh = sb_getblk(sb, block);
+		lock_buffer(bh);
+		memset(bh->b_data, 0 , sb->s_blocksize);
+		set_buffer_uptodate(bh);
+		unlock_buffer(bh);
+		return bh;
+	}
+	return NULL;
+}
+static inline struct buffer_head *
+affs_getemptyblk(struct super_block *sb, int block)
+{
+	struct buffer_head *bh;
+	pr_debug("affs_getemptyblk: %d\n", block);
+	if (block >= AFFS_SB(sb)->s_reserved && block < AFFS_SB(sb)->s_partition_size) {
+		bh = sb_getblk(sb, block);
+		wait_on_buffer(bh);
+		set_buffer_uptodate(bh);
+		return bh;
+	}
+	return NULL;
+}
+static inline void
+affs_brelse(struct buffer_head *bh)
+{
+	if (bh)
+		pr_debug("affs_brelse: %lld\n", (long long) bh->b_blocknr);
+	brelse(bh);
+}
+
+static inline void
+affs_adjust_checksum(struct buffer_head *bh, u32 val)
+{
+	u32 tmp = be32_to_cpu(((__be32 *)bh->b_data)[5]);
+	((__be32 *)bh->b_data)[5] = cpu_to_be32(tmp - val);
+}
+static inline void
+affs_adjust_bitmapchecksum(struct buffer_head *bh, u32 val)
+{
+	u32 tmp = be32_to_cpu(((__be32 *)bh->b_data)[0]);
+	((__be32 *)bh->b_data)[0] = cpu_to_be32(tmp - val);
+}
+
+static inline void
+affs_lock_link(struct inode *inode)
+{
+	down(&AFFS_I(inode)->i_link_lock);
+}
+static inline void
+affs_unlock_link(struct inode *inode)
+{
+	up(&AFFS_I(inode)->i_link_lock);
+}
+static inline void
+affs_lock_dir(struct inode *inode)
+{
+	down(&AFFS_I(inode)->i_hash_lock);
+}
+static inline void
+affs_unlock_dir(struct inode *inode)
+{
+	up(&AFFS_I(inode)->i_hash_lock);
+}
+static inline void
+affs_lock_ext(struct inode *inode)
+{
+	down(&AFFS_I(inode)->i_ext_lock);
+}
+static inline void
+affs_unlock_ext(struct inode *inode)
+{
+	up(&AFFS_I(inode)->i_ext_lock);
+}
diff -urN RC10-rc2-bk12-base/fs/affs/amigaffs.c RC10-rc2-bk12-current/fs/affs/amigaffs.c
--- RC10-rc2-bk12-base/fs/affs/amigaffs.c	2004-10-18 17:53:43.000000000 -0400
+++ RC10-rc2-bk12-current/fs/affs/amigaffs.c	2004-11-29 17:00:38.594716272 -0500
@@ -8,14 +8,7 @@
  *  Please send bug reports to: hjw@zvw.de
  */
 
-#include <stdarg.h>
-#include <linux/stat.h>
-#include <linux/time.h>
-#include <linux/affs_fs.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/amigaffs.h>
-#include <linux/buffer_head.h>
+#include "affs.h"
 
 extern struct timezone sys_tz;
 
diff -urN RC10-rc2-bk12-base/fs/affs/bitmap.c RC10-rc2-bk12-current/fs/affs/bitmap.c
--- RC10-rc2-bk12-base/fs/affs/bitmap.c	2004-10-18 17:55:28.000000000 -0400
+++ RC10-rc2-bk12-current/fs/affs/bitmap.c	2004-11-29 17:01:22.855987536 -0500
@@ -7,15 +7,7 @@
  *  block allocation, deallocation, calculation of free space.
  */
 
-#include <linux/time.h>
-#include <linux/affs_fs.h>
-#include <linux/stat.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/bitops.h>
-#include <linux/amigaffs.h>
-#include <linux/buffer_head.h>
+#include "affs.h"
 
 /* This is, of course, shamelessly stolen from fs/minix */
 
diff -urN RC10-rc2-bk12-base/fs/affs/dir.c RC10-rc2-bk12-current/fs/affs/dir.c
--- RC10-rc2-bk12-base/fs/affs/dir.c	2004-10-18 17:54:55.000000000 -0400
+++ RC10-rc2-bk12-current/fs/affs/dir.c	2004-11-29 17:02:15.392000848 -0500
@@ -13,17 +13,7 @@
  *
  */
 
-#include <asm/uaccess.h>
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/kernel.h>
-#include <linux/affs_fs.h>
-#include <linux/stat.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/amigaffs.h>
-#include <linux/smp_lock.h>
-#include <linux/buffer_head.h>
+#include "affs.h"
 
 static int affs_readdir(struct file *, void *, filldir_t);
 
diff -urN RC10-rc2-bk12-base/fs/affs/file.c RC10-rc2-bk12-current/fs/affs/file.c
--- RC10-rc2-bk12-base/fs/affs/file.c	2004-10-18 17:54:08.000000000 -0400
+++ RC10-rc2-bk12-current/fs/affs/file.c	2004-11-29 17:04:02.952649144 -0500
@@ -12,24 +12,7 @@
  *  affs regular file handling primitives
  */
 
-#include <asm/div64.h>
-#include <asm/uaccess.h>
-#include <asm/system.h>
-#include <linux/time.h>
-#include <linux/affs_fs.h>
-#include <linux/fcntl.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/stat.h>
-#include <linux/smp_lock.h>
-#include <linux/dirent.h>
-#include <linux/fs.h>
-#include <linux/amigaffs.h>
-#include <linux/mm.h>
-#include <linux/highmem.h>
-#include <linux/pagemap.h>
-#include <linux/buffer_head.h>
+#include "affs.h"
 
 #if PAGE_SIZE < 4096
 #error PAGE_SIZE must be at least 4096
diff -urN RC10-rc2-bk12-base/fs/affs/inode.c RC10-rc2-bk12-current/fs/affs/inode.c
--- RC10-rc2-bk12-base/fs/affs/inode.c	2004-10-18 17:54:07.000000000 -0400
+++ RC10-rc2-bk12-current/fs/affs/inode.c	2004-11-29 17:11:20.702101112 -0500
@@ -10,26 +10,7 @@
  *  (C) 1991  Linus Torvalds - minix filesystem
  */
 
-#include <asm/div64.h>
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/slab.h>
-#include <linux/stat.h>
-#include <linux/time.h>
-#include <linux/affs_fs.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/genhd.h>
-#include <linux/amigaffs.h>
-#include <linux/major.h>
-#include <linux/blkdev.h>
-#include <linux/init.h>
-#include <linux/smp_lock.h>
-#include <linux/buffer_head.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <linux/module.h>
+#include "affs.h"
 
 extern struct inode_operations affs_symlink_inode_operations;
 extern struct timezone sys_tz;
@@ -428,4 +409,3 @@
 	affs_unlock_link(inode);
 	goto done;
 }
-MODULE_LICENSE("GPL");
diff -urN RC10-rc2-bk12-base/fs/affs/namei.c RC10-rc2-bk12-current/fs/affs/namei.c
--- RC10-rc2-bk12-base/fs/affs/namei.c	2004-10-18 17:53:46.000000000 -0400
+++ RC10-rc2-bk12-current/fs/affs/namei.c	2004-11-29 17:15:09.782275632 -0500
@@ -8,23 +8,10 @@
  *  (C) 1991  Linus Torvalds - minix filesystem
  */
 
-#include <linux/time.h>
-#include <linux/affs_fs.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/stat.h>
-#include <linux/fcntl.h>
-#include <linux/amigaffs.h>
-#include <linux/smp_lock.h>
-#include <linux/buffer_head.h>
-#include <asm/uaccess.h>
-
-#include <linux/errno.h>
+#include "affs.h"
 
 typedef int (*toupper_t)(int);
 
-extern struct inode_operations affs_symlink_inode_operations;
-
 static int	 affs_toupper(int ch);
 static int	 affs_hash_dentry(struct dentry *, struct qstr *);
 static int       affs_compare_dentry(struct dentry *, struct qstr *, struct qstr *);
diff -urN RC10-rc2-bk12-base/fs/affs/super.c RC10-rc2-bk12-current/fs/affs/super.c
--- RC10-rc2-bk12-base/fs/affs/super.c	2004-10-18 17:54:39.000000000 -0400
+++ RC10-rc2-bk12-current/fs/affs/super.c	2004-11-29 17:17:59.947406600 -0500
@@ -11,26 +11,10 @@
  */
 
 #include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/slab.h>
-#include <linux/stat.h>
-#include <linux/time.h>
-#include <linux/affs_fs.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/genhd.h>
-#include <linux/amigaffs.h>
-#include <linux/major.h>
-#include <linux/blkdev.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
-#include <linux/buffer_head.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/parser.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
+#include "affs.h"
 
 extern struct timezone sys_tz;
 
diff -urN RC10-rc2-bk12-base/fs/affs/symlink.c RC10-rc2-bk12-current/fs/affs/symlink.c
--- RC10-rc2-bk12-base/fs/affs/symlink.c	2004-10-18 17:53:42.000000000 -0400
+++ RC10-rc2-bk12-current/fs/affs/symlink.c	2004-11-29 17:14:21.318643224 -0500
@@ -8,14 +8,7 @@
  *  affs symlink handling code
  */
 
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/stat.h>
-#include <linux/affs_fs.h>
-#include <linux/amigaffs.h>
-#include <linux/pagemap.h>
-#include <linux/smp_lock.h>
-#include <linux/buffer_head.h>
+#include "affs.h"
 
 static int affs_symlink_readpage(struct file *file, struct page *page)
 {
diff -urN RC10-rc2-bk12-base/include/linux/affs_fs.h RC10-rc2-bk12-current/include/linux/affs_fs.h
--- RC10-rc2-bk12-base/include/linux/affs_fs.h	2004-10-18 17:53:06.000000000 -0400
+++ RC10-rc2-bk12-current/include/linux/affs_fs.h	2004-11-29 16:53:07.815245168 -0500
@@ -3,94 +3,5 @@
 /*
  * The affs filesystem constants/structures
  */
-
-#include <linux/types.h>
-
-#include <linux/affs_fs_i.h>
-#include <linux/affs_fs_sb.h>
-
 #define AFFS_SUPER_MAGIC 0xadff
-
-struct affs_date;
-
-/* --- Prototypes -----------------------------------------------------------------------------	*/
-
-/* amigaffs.c */
-
-extern int	affs_insert_hash(struct inode *inode, struct buffer_head *bh);
-extern int	affs_remove_hash(struct inode *dir, struct buffer_head *rem_bh);
-extern int	affs_remove_header(struct dentry *dentry);
-extern u32	affs_checksum_block(struct super_block *sb, struct buffer_head *bh);
-extern void	affs_fix_checksum(struct super_block *sb, struct buffer_head *bh);
-extern void	secs_to_datestamp(time_t secs, struct affs_date *ds);
-extern mode_t	prot_to_mode(u32 prot);
-extern void	mode_to_prot(struct inode *inode);
-extern void	affs_error(struct super_block *sb, const char *function, const char *fmt, ...);
-extern void	affs_warning(struct super_block *sb, const char *function, const char *fmt, ...);
-extern int	affs_check_name(const unsigned char *name, int len);
-extern int	affs_copy_name(unsigned char *bstr, struct dentry *dentry);
-
-/* bitmap. c */
-
-extern u32	affs_count_free_blocks(struct super_block *s);
-extern void	affs_free_block(struct super_block *sb, u32 block);
-extern u32	affs_alloc_block(struct inode *inode, u32 goal);
-extern int	affs_init_bitmap(struct super_block *sb, int *flags);
-extern void	affs_free_bitmap(struct super_block *sb);
-
-/* namei.c */
-
-extern int	affs_hash_name(struct super_block *sb, const u8 *name, unsigned int len);
-extern struct dentry *affs_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *);
-extern int	affs_unlink(struct inode *dir, struct dentry *dentry);
-extern int	affs_create(struct inode *dir, struct dentry *dentry, int mode, struct nameidata *);
-extern int	affs_mkdir(struct inode *dir, struct dentry *dentry, int mode);
-extern int	affs_rmdir(struct inode *dir, struct dentry *dentry);
-extern int	affs_link(struct dentry *olddentry, struct inode *dir,
-			  struct dentry *dentry);
-extern int	affs_symlink(struct inode *dir, struct dentry *dentry,
-			     const char *symname);
-extern int	affs_rename(struct inode *old_dir, struct dentry *old_dentry,
-			    struct inode *new_dir, struct dentry *new_dentry);
-
-/* inode.c */
-
-extern unsigned long		 affs_parent_ino(struct inode *dir);
-extern struct inode		*affs_new_inode(struct inode *dir);
-extern int			 affs_notify_change(struct dentry *dentry, struct iattr *attr);
-extern void			 affs_put_inode(struct inode *inode);
-extern void			 affs_delete_inode(struct inode *inode);
-extern void			 affs_clear_inode(struct inode *inode);
-extern void			 affs_read_inode(struct inode *inode);
-extern int			 affs_write_inode(struct inode *inode, int);
-extern int			 affs_add_entry(struct inode *dir, struct inode *inode, struct dentry *dentry, s32 type);
-
-/* super.c */
-
-extern int			 affs_fs(void);
-
-/* file.c */
-
-void		affs_free_prealloc(struct inode *inode);
-extern void	affs_truncate(struct inode *);
-
-/* dir.c */
-
-extern void   affs_dir_truncate(struct inode *);
-
-/* jump tables */
-
-extern struct inode_operations	 affs_file_inode_operations;
-extern struct inode_operations	 affs_dir_inode_operations;
-extern struct inode_operations   affs_symlink_inode_operations;
-extern struct file_operations	 affs_file_operations;
-extern struct file_operations	 affs_file_operations_ofs;
-extern struct file_operations	 affs_dir_operations;
-extern struct address_space_operations	 affs_symlink_aops;
-extern struct address_space_operations	 affs_aops;
-extern struct address_space_operations	 affs_aops_ofs;
-
-extern struct dentry_operations	 affs_dentry_operations;
-extern struct dentry_operations	 affs_dentry_operations_intl;
-
 #endif
diff -urN RC10-rc2-bk12-base/include/linux/affs_fs_i.h RC10-rc2-bk12-current/include/linux/affs_fs_i.h
--- RC10-rc2-bk12-base/include/linux/affs_fs_i.h	2004-10-18 17:55:28.000000000 -0400
+++ RC10-rc2-bk12-current/include/linux/affs_fs_i.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,59 +0,0 @@
-#ifndef _AFFS_FS_I
-#define _AFFS_FS_I
-
-#include <linux/a.out.h>
-#include <linux/fs.h>
-#include <asm/semaphore.h>
-
-#define AFFS_CACHE_SIZE		PAGE_SIZE
-//#define AFFS_CACHE_SIZE		(4*4)
-
-#define AFFS_MAX_PREALLOC	32
-#define AFFS_LC_SIZE		(AFFS_CACHE_SIZE/sizeof(u32)/2)
-#define AFFS_AC_SIZE		(AFFS_CACHE_SIZE/sizeof(struct affs_ext_key)/2)
-#define AFFS_AC_MASK		(AFFS_AC_SIZE-1)
-
-struct affs_ext_key {
-	u32	ext;				/* idx of the extended block */
-	u32	key;				/* block number */
-};
-
-/*
- * affs fs inode data in memory
- */
-struct affs_inode_info {
-	u32	 i_opencnt;
-	struct semaphore i_link_lock;		/* Protects internal inode access. */
-	struct semaphore i_ext_lock;		/* Protects internal inode access. */
-#define i_hash_lock i_ext_lock
-	u32	 i_blkcnt;			/* block count */
-	u32	 i_extcnt;			/* extended block count */
-	u32	*i_lc;				/* linear cache of extended blocks */
-	u32	 i_lc_size;
-	u32	 i_lc_shift;
-	u32	 i_lc_mask;
-	struct affs_ext_key *i_ac;		/* associative cache of extended blocks */
-	u32	 i_ext_last;			/* last accessed extended block */
-	struct buffer_head *i_ext_bh;		/* bh of last extended block */
-	loff_t	 mmu_private;
-	u32	 i_protect;			/* unused attribute bits */
-	u32	 i_lastalloc;			/* last allocated block */
-	int	 i_pa_cnt;			/* number of preallocated blocks */
-#if 0
-	s32	 i_original;			/* if != 0, this is the key of the original */
-	u32	 i_data[AFFS_MAX_PREALLOC];	/* preallocated blocks */
-	int	 i_cache_users;			/* Cache cannot be freed while > 0 */
-	unsigned char i_hlink;			/* This is a fake */
-	unsigned char i_pad;
-	s32	 i_parent;			/* parent ino */
-#endif
-	struct inode vfs_inode;
-};
-
-/* short cut to get to the affs specific inode data */
-static inline struct affs_inode_info *AFFS_I(struct inode *inode)
-{
-	return list_entry(inode, struct affs_inode_info, vfs_inode);
-}
-
-#endif
diff -urN RC10-rc2-bk12-base/include/linux/affs_fs_sb.h RC10-rc2-bk12-current/include/linux/affs_fs_sb.h
--- RC10-rc2-bk12-base/include/linux/affs_fs_sb.h	2004-10-18 17:53:22.000000000 -0400
+++ RC10-rc2-bk12-current/include/linux/affs_fs_sb.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,57 +0,0 @@
-#ifndef _AFFS_FS_SB
-#define _AFFS_FS_SB
-
-/*
- * super-block data in memory
- *
- * Block numbers are adjusted for their actual size
- *
- */
-
-struct affs_bm_info {
-	u32 bm_key;			/* Disk block number */
-	u32 bm_free;			/* Free blocks in here */
-};
-
-struct affs_sb_info {
-	int s_partition_size;		/* Partition size in blocks. */
-	int s_reserved;			/* Number of reserved blocks. */
-	//u32 s_blksize;			/* Initial device blksize */
-	u32 s_data_blksize;		/* size of the data block w/o header */
-	u32 s_root_block;		/* FFS root block number. */
-	int s_hashsize;			/* Size of hash table. */
-	unsigned long s_flags;		/* See below. */
-	uid_t s_uid;			/* uid to override */
-	gid_t s_gid;			/* gid to override */
-	umode_t s_mode;			/* mode to override */
-	struct buffer_head *s_root_bh;	/* Cached root block. */
-	struct semaphore s_bmlock;	/* Protects bitmap access. */
-	struct affs_bm_info *s_bitmap;	/* Bitmap infos. */
-	u32 s_bmap_count;		/* # of bitmap blocks. */
-	u32 s_bmap_bits;		/* # of bits in one bitmap blocks */
-	u32 s_last_bmap;
-	struct buffer_head *s_bmap_bh;
-	char *s_prefix;			/* Prefix for volumes and assigns. */
-	int s_prefix_len;		/* Length of prefix. */
-	char s_volume[32];		/* Volume prefix for absolute symlinks. */
-};
-
-#define SF_INTL		0x0001		/* International filesystem. */
-#define SF_BM_VALID	0x0002		/* Bitmap is valid. */
-#define SF_IMMUTABLE	0x0004		/* Protection bits cannot be changed */
-#define SF_QUIET	0x0008		/* chmod errors will be not reported */
-#define SF_SETUID	0x0010		/* Ignore Amiga uid */
-#define SF_SETGID	0x0020		/* Ignore Amiga gid */
-#define SF_SETMODE	0x0040		/* Ignore Amiga protection bits */
-#define SF_MUFS		0x0100		/* Use MUFS uid/gid mapping */
-#define SF_OFS		0x0200		/* Old filesystem */
-#define SF_PREFIX	0x0400		/* Buffer for prefix is allocated */
-#define SF_VERBOSE	0x0800		/* Talk about fs when mounting */
-
-/* short cut to get to the affs specific sb data */
-static inline struct affs_sb_info *AFFS_SB(struct super_block *sb)
-{
-	return sb->s_fs_info;
-}
-
-#endif
diff -urN RC10-rc2-bk12-base/include/linux/amigaffs.h RC10-rc2-bk12-current/include/linux/amigaffs.h
--- RC10-rc2-bk12-base/include/linux/amigaffs.h	2004-10-18 17:53:23.000000000 -0400
+++ RC10-rc2-bk12-current/include/linux/amigaffs.h	2004-11-29 17:20:01.572916712 -0500
@@ -2,8 +2,6 @@
 #define AMIGAFFS_H
 
 #include <linux/types.h>
-#include <linux/buffer_head.h>
-#include <linux/string.h>
 #include <asm/byteorder.h>
 
 /* AmigaOS allows file names with up to 30 characters length.
@@ -20,107 +18,6 @@
 #define AFFS_GET_HASHENTRY(data,hashkey) be32_to_cpu(((struct dir_front *)data)->hashtable[hashkey])
 #define AFFS_BLOCK(sb, bh, blk)		(AFFS_HEAD(bh)->table[AFFS_SB(sb)->s_hashsize-1-(blk)])
 
-static inline void
-affs_set_blocksize(struct super_block *sb, int size)
-{
-	sb_set_blocksize(sb, size);
-}
-static inline struct buffer_head *
-affs_bread(struct super_block *sb, int block)
-{
-	pr_debug("affs_bread: %d\n", block);
-	if (block >= AFFS_SB(sb)->s_reserved && block < AFFS_SB(sb)->s_partition_size)
-		return sb_bread(sb, block);
-	return NULL;
-}
-static inline struct buffer_head *
-affs_getblk(struct super_block *sb, int block)
-{
-	pr_debug("affs_getblk: %d\n", block);
-	if (block >= AFFS_SB(sb)->s_reserved && block < AFFS_SB(sb)->s_partition_size)
-		return sb_getblk(sb, block);
-	return NULL;
-}
-static inline struct buffer_head *
-affs_getzeroblk(struct super_block *sb, int block)
-{
-	struct buffer_head *bh;
-	pr_debug("affs_getzeroblk: %d\n", block);
-	if (block >= AFFS_SB(sb)->s_reserved && block < AFFS_SB(sb)->s_partition_size) {
-		bh = sb_getblk(sb, block);
-		lock_buffer(bh);
-		memset(bh->b_data, 0 , sb->s_blocksize);
-		set_buffer_uptodate(bh);
-		unlock_buffer(bh);
-		return bh;
-	}
-	return NULL;
-}
-static inline struct buffer_head *
-affs_getemptyblk(struct super_block *sb, int block)
-{
-	struct buffer_head *bh;
-	pr_debug("affs_getemptyblk: %d\n", block);
-	if (block >= AFFS_SB(sb)->s_reserved && block < AFFS_SB(sb)->s_partition_size) {
-		bh = sb_getblk(sb, block);
-		wait_on_buffer(bh);
-		set_buffer_uptodate(bh);
-		return bh;
-	}
-	return NULL;
-}
-static inline void
-affs_brelse(struct buffer_head *bh)
-{
-	if (bh)
-		pr_debug("affs_brelse: %lld\n", (long long) bh->b_blocknr);
-	brelse(bh);
-}
-
-static inline void
-affs_adjust_checksum(struct buffer_head *bh, u32 val)
-{
-	u32 tmp = be32_to_cpu(((__be32 *)bh->b_data)[5]);
-	((__be32 *)bh->b_data)[5] = cpu_to_be32(tmp - val);
-}
-static inline void
-affs_adjust_bitmapchecksum(struct buffer_head *bh, u32 val)
-{
-	u32 tmp = be32_to_cpu(((__be32 *)bh->b_data)[0]);
-	((__be32 *)bh->b_data)[0] = cpu_to_be32(tmp - val);
-}
-
-static inline void
-affs_lock_link(struct inode *inode)
-{
-	down(&AFFS_I(inode)->i_link_lock);
-}
-static inline void
-affs_unlock_link(struct inode *inode)
-{
-	up(&AFFS_I(inode)->i_link_lock);
-}
-static inline void
-affs_lock_dir(struct inode *inode)
-{
-	down(&AFFS_I(inode)->i_hash_lock);
-}
-static inline void
-affs_unlock_dir(struct inode *inode)
-{
-	up(&AFFS_I(inode)->i_hash_lock);
-}
-static inline void
-affs_lock_ext(struct inode *inode)
-{
-	down(&AFFS_I(inode)->i_ext_lock);
-}
-static inline void
-affs_unlock_ext(struct inode *inode)
-{
-	up(&AFFS_I(inode)->i_ext_lock);
-}
-
 #ifdef __LITTLE_ENDIAN
 #define BO_EXBITS	0x18UL
 #elif defined(__BIG_ENDIAN)
