Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbSJOP22>; Tue, 15 Oct 2002 11:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264655AbSJOP22>; Tue, 15 Oct 2002 11:28:28 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:45317 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264654AbSJOP2N>; Tue, 15 Oct 2002 11:28:13 -0400
Date: Tue, 15 Oct 2002 16:33:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021015163359.C27906@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <E181IS8-0001DQ-00@snap.thunk.org> <20021015125816.A22877@infradead.org> <20021015131507.GC31235@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021015131507.GC31235@think.thunk.org>; from tytso@mit.edu on Tue, Oct 15, 2002 at 09:15:07AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 09:15:07AM -0400, Theodore Ts'o wrote:
> Actually, I did, for those comments that made sense.  The fs/Config.in
> logic has been cleaned up, as well as removing excess header files,
> stray LINUX_VERSION_CODE #ifdef's that I had missed the first time
> around, etc.
> 
> fs/mbcache.c is still there because it applies to both ext2 and ext3
> filesystems, and so your suggestion of moving it into the ext2 and
> ext3 directories would cause code duplication and maintenance
> headaches.  It also *can* be used by other filesystems, as it is
> written in a generic way.  The fs/Config.in only compiles it in if
> necessary (i.e., if ext2/3 extended attribute is enabled) so it won't
> cause code bloat for other filesystems if it is not needed.
> 
> The superblock fields are more of an issue with the posix acl changes
> than for the extended attribute patches.  I had wanted to get the
> extended attribute changes in first, since they stand alone, and so I
> have fewer patches to juggle.

Patch 3: first round of ext2 cleanups (all against 2.5.42-mm3):

o move include/linux/ext2_xattr.h to fs/ext2/xattr.h
o include xattr.h in the files that actually need it
o remove old compat code
o remove dead quota code
o remove ext2_xattr_lock/ext2_xattr_unlock wrappers (only two callers..)

More cleanups will follow.


--- linux-2.5.42-mm3-plain/fs/ext2/ext2.h	Tue Oct 15 17:05:08 2002
+++ linux-2.5.42-mm3/fs/ext2/ext2.h	Tue Oct 15 13:46:09 2002
@@ -1,6 +1,5 @@
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
-#include <linux/ext2_xattr.h>
 
 /*
  * second extended file system inode data in memory
--- linux-2.5.42-mm3-plain/fs/ext2/file.c	Tue Oct 15 17:05:08 2002
+++ linux-2.5.42-mm3/fs/ext2/file.c	Tue Oct 15 13:20:55 2002
@@ -18,8 +18,9 @@
  * 	(jj@sunsite.ms.mff.cuni.cz)
  */
 
-#include "ext2.h"
 #include <linux/time.h>
+#include "ext2.h"
+#include "xattr.h"
 
 /*
  * Called when an inode is released. Note that this is different
--- linux-2.5.42-mm3-plain/fs/ext2/ialloc.c	Tue Oct 15 17:05:08 2002
+++ linux-2.5.42-mm3/fs/ext2/ialloc.c	Tue Oct 15 13:22:21 2002
@@ -14,6 +14,7 @@
 
 #include <linux/config.h>
 #include "ext2.h"
+#include "xattr.h"
 #include <linux/quotaops.h>
 #include <linux/sched.h>
 #include <linux/backing-dev.h>
--- linux-2.5.42-mm3-plain/fs/ext2/namei.c	Tue Oct 15 17:05:08 2002
+++ linux-2.5.42-mm3/fs/ext2/namei.c	Tue Oct 15 13:22:55 2002
@@ -29,8 +29,10 @@
  *        David S. Miller (davem@caip.rutgers.edu), 1995
  */
 
-#include "ext2.h"
 #include <linux/pagemap.h>
+#include "ext2.h"
+#include "xattr.h"
+
 
 /*
  * Couple of helper functions - make the code slightly cleaner.
--- linux-2.5.42-mm3-plain/fs/ext2/super.c	Tue Oct 15 17:05:08 2002
+++ linux-2.5.42-mm3/fs/ext2/super.c	Tue Oct 15 13:23:20 2002
@@ -27,6 +27,7 @@
 #include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
+#include "xattr.h"
 
 
 static void ext2_sync_super(struct super_block *sb,
--- linux-2.5.42-mm3-plain/fs/ext2/symlink.c	Tue Oct 15 17:05:08 2002
+++ linux-2.5.42-mm3/fs/ext2/symlink.c	Tue Oct 15 13:49:15 2002
@@ -18,6 +18,7 @@
  */
 
 #include "ext2.h"
+#include "xattr.h"
 
 static int ext2_readlink(struct dentry *dentry, char *buffer, int buflen)
 {
--- linux-2.5.42-mm3-plain/fs/ext2/xattr.c	Tue Oct 15 17:05:08 2002
+++ linux-2.5.42-mm3/fs/ext2/xattr.c	Tue Oct 15 16:11:43 2002
@@ -49,20 +49,17 @@
  * For writing we also grab the ext2_xattr_sem semaphore. This ensures that
  * only a single process is modifying an extended attribute block, even
  * if the block is shared among inodes.
- *
- * Note for porting to 2.5
- * -----------------------
- * The BKL will no longer be held in the xattr inode operations.
  */
 
-#include "ext2.h"
 #include <linux/buffer_head.h>
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/mbcache.h>
 #include <linux/quotaops.h>
 #include <asm/semaphore.h>
-#include <linux/compatmac.h>
+#include "ext2.h"
+#include "xattr.h"
 
 /* These symbols may be needed by a module. */
 EXPORT_SYMBOL(ext2_xattr_register);
@@ -71,10 +68,6 @@
 EXPORT_SYMBOL(ext2_xattr_list);
 EXPORT_SYMBOL(ext2_xattr_set);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-# define mark_buffer_dirty(bh) mark_buffer_dirty(bh, 1)
-#endif
-
 #define HDR(bh) ((struct ext2_xattr_header *)((bh)->b_data))
 #define ENTRY(ptr) ((struct ext2_xattr_entry *)(ptr))
 #define FIRST_ENTRY(bh) ENTRY(HDR(bh)+1)
@@ -116,92 +109,9 @@
  * filesystem may still contain shared blocks, so we always take
  * the lock.
  */
-
-DECLARE_MUTEX(ext2_xattr_sem);
-
-static inline void
-ext2_xattr_lock(void)
-{
-	down(&ext2_xattr_sem);
-}
-
-static inline void
-ext2_xattr_unlock(void)
-{
-	up(&ext2_xattr_sem);
-}
-
-static inline int
-ext2_xattr_new_block(struct inode *inode, int * errp, int force)
-{
-	struct super_block *sb = inode->i_sb;
-	int goal = le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block) +
-		EXT2_I(inode)->i_block_group * EXT2_BLOCKS_PER_GROUP(sb);
-
-	/* How can we enforce the allocation? */
-	int block = ext2_new_block(inode, goal, 0, 0, errp);
-#ifdef OLD_QUOTAS
-	if (!*errp)
-		inode->i_blocks += inode->i_sb->s_blocksize >> 9;
-#endif
-	return block;
-}
-
-static inline int
-ext2_xattr_quota_alloc(struct inode *inode, int force)
-{
-	/* How can we enforce the allocation? */
-#ifdef OLD_QUOTAS
-	int error = DQUOT_ALLOC_BLOCK(inode->i_sb, inode, 1);
-	if (!error)
-		inode->i_blocks += inode->i_sb->s_blocksize >> 9;
-#else
-	int error = DQUOT_ALLOC_BLOCK(inode, 1);
-#endif
-	return error;
-}
-
-#ifdef OLD_QUOTAS
-
-static inline void
-ext2_xattr_quota_free(struct inode *inode)
-{
-	DQUOT_FREE_BLOCK(inode->i_sb, inode, 1);
-	inode->i_blocks -= inode->i_sb->s_blocksize >> 9;
-}
-
-static inline void
-ext2_xattr_free_block(struct inode * inode, unsigned long block)
-{
-	ext2_free_blocks(inode, block, 1);
-	inode->i_blocks -= inode->i_sb->s_blocksize >> 9;
-}
-
-#else
-# define ext2_xattr_quota_free(inode) \
-	DQUOT_FREE_BLOCK(inode, 1)
-# define ext2_xattr_free_block(inode, block) \
-	ext2_free_blocks(inode, block, 1)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,18)
-
-static inline struct buffer_head *
-sb_bread(struct super_block *sb, int block)
-{
-	return bread(sb->s_dev, block, sb->s_blocksize);
-}
-
-static inline struct buffer_head *
-sb_getblk(struct super_block *sb, int block)
-{
-	return getblk(sb->s_dev, block, sb->s_blocksize);
-}
-
-#endif
-
-struct ext2_xattr_handler *ext2_xattr_handlers[EXT2_XATTR_INDEX_MAX];
-rwlock_t ext2_handler_lock = RW_LOCK_UNLOCKED;
+static DECLARE_MUTEX(ext2_xattr_sem);
+static struct ext2_xattr_handler *ext2_xattr_handlers[EXT2_XATTR_INDEX_MAX];
+static rwlock_t ext2_handler_lock = RW_LOCK_UNLOCKED;
 
 int
 ext2_xattr_register(int name_index, struct ext2_xattr_handler *handler)
@@ -545,9 +455,6 @@
 		return;
 
 	lock_super(sb);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-	EXT2_SB(sb)->s_feature_compat |= EXT2_FEATURE_COMPAT_EXT_ATTR;
-#endif
 	EXT2_SB(sb)->s_es->s_feature_compat |=
 		cpu_to_le32(EXT2_FEATURE_COMPAT_EXT_ATTR);
 	sb->s_dirt = 1;
@@ -605,8 +512,8 @@
 	name_len = strlen(name);
 	if (name_len > 255 || value_len > sb->s_blocksize)
 		return -ERANGE;
-	ext2_xattr_lock();
 
+	down(&ext2_xattr_sem);
 	if (EXT2_I(inode)->i_file_acl) {
 		/* The inode already has an extended attribute block. */
 		int block = EXT2_I(inode)->i_file_acl;
@@ -802,7 +709,7 @@
 	brelse(bh);
 	if (!(bh && header == HDR(bh)))
 		kfree(header);
-	ext2_xattr_unlock();
+	up(&ext2_xattr_sem);
 
 	return error;
 }
@@ -830,7 +737,8 @@
 				new_bh->b_blocknr);
 			
 			error = -EDQUOT;
-			if (ext2_xattr_quota_alloc(inode, 1))
+			/* How can we enforce the allocation? */
+			if (DQUOT_ALLOC_BLOCK(inode, 1))
 				goto cleanup;
 			
 			HDR(new_bh)->h_refcount = cpu_to_le32(
@@ -843,15 +751,18 @@
 			ext2_xattr_cache_insert(new_bh);
 		} else {
 			/* We need to allocate a new block */
-			int force = EXT2_I(inode)->i_file_acl != 0;
-			int block = ext2_xattr_new_block(inode, &error, force);
+			int goal = le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block) +
+					EXT2_I(inode)->i_block_group *
+					EXT2_BLOCKS_PER_GROUP(sb);
+			/* How can we enforce the allocation? */
+			int block = ext2_new_block(inode, goal, 0, 0, &error);
 			if (error)
 				goto cleanup;
 			ea_idebug(inode, "creating block %d", block);
 
 			new_bh = sb_getblk(sb, block);
 			if (!new_bh) {
-				ext2_xattr_free_block(inode, block);
+				ext2_free_blocks(inode, block, 1);
 				error = -EIO;
 				goto cleanup;
 			}
@@ -894,7 +805,7 @@
 		if (refcount == 1) {
 			/* Free the old block. */
 			ea_bdebug(old_bh, "freeing");
-			ext2_xattr_free_block(inode, old_bh->b_blocknr);
+			ext2_free_blocks(inode, old_bh->b_blocknr, 1);
 			/* We let our caller release old_bh, so we
 			 * need to duplicate the buffer before. */
 			get_bh(old_bh);
@@ -903,7 +814,7 @@
 			/* Decrement the refcount only. */
 			refcount--;
 			HDR(old_bh)->h_refcount = cpu_to_le32(refcount);
-			ext2_xattr_quota_free(inode);
+			DQUOT_FREE_BLOCK(inode, 1);
 			mark_buffer_dirty(old_bh);
 			ea_bdebug(old_bh, "refcount now=%d", refcount);
 		}
@@ -930,8 +841,8 @@
 
 	if (!block)
 		return;
-	ext2_xattr_lock();
 
+	down(&ext2_xattr_sem);
 	bh = sb_bread(inode->i_sb, block);
 	if (!bh) {
 		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
@@ -948,7 +859,7 @@
 	ea_bdebug(bh, "refcount now=%d", le32_to_cpu(HDR(bh)->h_refcount) - 1);
 	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
 		ext2_xattr_cache_remove(bh);
-		ext2_xattr_free_block(inode, block);
+		ext2_free_blocks(inode, block, 1);
 		bforget(bh);
 		bh = NULL;
 	} else {
@@ -959,13 +870,13 @@
 			ll_rw_block(WRITE, 1, &bh);
 			wait_on_buffer(bh);
 		}
-		ext2_xattr_quota_free(inode);
+		DQUOT_FREE_BLOCK(inode, 1);
 	}
 	EXT2_I(inode)->i_file_acl = 0;
 
 cleanup:
 	brelse(bh);
-	ext2_xattr_unlock();
+	up(&ext2_xattr_sem);
 }
 
 /*
--- linux-2.5.42-mm3-plain/fs/ext2/xattr.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.42-mm3/fs/ext2/xattr.h	Tue Oct 15 13:45:05 2002
@@ -0,0 +1,134 @@
+/*
+  File: fs/ext2/xattr.h
+
+  On-disk format of extended attributes for the ext2 filesystem.
+
+  (C) 2001 Andreas Gruenbacher, <a.gruenbacher@computer.org>
+*/
+
+#include <linux/config.h>
+#include <linux/xattr.h>
+
+/* Magic value in attribute blocks */
+#define EXT2_XATTR_MAGIC		0xEA020000
+
+/* Maximum number of references to one attribute block */
+#define EXT2_XATTR_REFCOUNT_MAX		1024
+
+/* Name indexes */
+#define EXT2_XATTR_INDEX_MAX			10
+#define EXT2_XATTR_INDEX_USER			1
+#define EXT2_XATTR_INDEX_POSIX_ACL_ACCESS	2
+#define EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT	3
+
+struct ext2_xattr_header {
+	__u32	h_magic;	/* magic number for identification */
+	__u32	h_refcount;	/* reference count */
+	__u32	h_blocks;	/* number of disk blocks used */
+	__u32	h_hash;		/* hash value of all attributes */
+	__u32	h_reserved[4];	/* zero right now */
+};
+
+struct ext2_xattr_entry {
+	__u8	e_name_len;	/* length of name */
+	__u8	e_name_index;	/* attribute name index */
+	__u16	e_value_offs;	/* offset in disk block of value */
+	__u32	e_value_block;	/* disk block attribute is stored on (n/i) */
+	__u32	e_value_size;	/* size of attribute value */
+	__u32	e_hash;		/* hash value of name and value */
+	char	e_name[0];	/* attribute name */
+};
+
+#define EXT2_XATTR_PAD_BITS		2
+#define EXT2_XATTR_PAD		(1<<EXT2_XATTR_PAD_BITS)
+#define EXT2_XATTR_ROUND		(EXT2_XATTR_PAD-1)
+#define EXT2_XATTR_LEN(name_len) \
+	(((name_len) + EXT2_XATTR_ROUND + \
+	sizeof(struct ext2_xattr_entry)) & ~EXT2_XATTR_ROUND)
+#define EXT2_XATTR_NEXT(entry) \
+	( (struct ext2_xattr_entry *)( \
+	  (char *)(entry) + EXT2_XATTR_LEN((entry)->e_name_len)) )
+#define EXT2_XATTR_SIZE(size) \
+	(((size) + EXT2_XATTR_ROUND) & ~EXT2_XATTR_ROUND)
+
+# ifdef CONFIG_EXT2_FS_XATTR
+
+struct ext2_xattr_handler {
+	char *prefix;
+	size_t (*list)(char *list, struct inode *inode, const char *name,
+		       int name_len);
+	int (*get)(struct inode *inode, const char *name, void *buffer,
+		   size_t size);
+	int (*set)(struct inode *inode, const char *name, const void *buffer,
+		   size_t size, int flags);
+};
+
+extern int ext2_xattr_register(int, struct ext2_xattr_handler *);
+extern void ext2_xattr_unregister(int, struct ext2_xattr_handler *);
+
+extern int ext2_setxattr(struct dentry *, const char *, void *, size_t, int);
+extern ssize_t ext2_getxattr(struct dentry *, const char *, void *, size_t);
+extern ssize_t ext2_listxattr(struct dentry *, char *, size_t);
+extern int ext2_removexattr(struct dentry *, const char *);
+
+extern int ext2_xattr_get(struct inode *, int, const char *, void *, size_t);
+extern int ext2_xattr_list(struct inode *, char *, size_t);
+extern int ext2_xattr_set(struct inode *, int, const char *, const void *, size_t, int);
+
+extern void ext2_xattr_delete_inode(struct inode *);
+extern void ext2_xattr_put_super(struct super_block *);
+
+extern int init_ext2_xattr(void);
+extern void exit_ext2_xattr(void);
+
+# else  /* CONFIG_EXT2_FS_XATTR */
+#  define ext2_setxattr		NULL
+#  define ext2_getxattr		NULL
+#  define ext2_listxattr	NULL
+#  define ext2_removexattr	NULL
+
+static inline int
+ext2_xattr_get(struct inode *inode, int name_index,
+	       const char *name, void *buffer, size_t size)
+{
+	return -ENOTSUPP;
+}
+
+static inline int
+ext2_xattr_list(struct inode *inode, char *buffer, size_t size)
+{
+	return -ENOTSUPP;
+}
+
+static inline int
+ext2_xattr_set(struct inode *inode, int name_index, const char *name,
+	       const void *value, size_t size, int flags)
+{
+	return -ENOTSUPP;
+}
+
+static inline void
+ext2_xattr_delete_inode(struct inode *inode)
+{
+}
+
+static inline void
+ext2_xattr_put_super(struct super_block *sb)
+{
+}
+
+static inline int
+init_ext2_xattr(void)
+{
+	return 0;
+}
+
+static inline void
+exit_ext2_xattr(void)
+{
+}
+
+# endif  /* CONFIG_EXT2_FS_XATTR */
+
+extern struct ext2_xattr_handler ext2_xattr_user_handler;
+
--- linux-2.5.42-mm3-plain/fs/ext2/xattr_user.c	Tue Oct 15 17:05:08 2002
+++ linux-2.5.42-mm3/fs/ext2/xattr_user.c	Tue Oct 15 16:10:37 2002
@@ -5,9 +5,11 @@
  * Copyright (C) 2001 by Andreas Gruenbacher, <a.gruenbacher@computer.org>
  */
 
-#include "ext2.h"
+#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include "ext2.h"
+#include "xattr.h"
 
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
 # include <linux/ext2_acl.h>
--- linux-2.5.42-mm3-plain/include/linux/ext2_xattr.h	Tue Oct 15 17:05:12 2002
+++ linux-2.5.42-mm3/include/linux/ext2_xattr.h	Thu Jan  1 01:00:00 1970
@@ -1,135 +0,0 @@
-/*
-  File: linux/ext2_xattr.h
-
-  On-disk format of extended attributes for the ext2 filesystem.
-
-  (C) 2001 Andreas Gruenbacher, <a.gruenbacher@computer.org>
-*/
-
-#include <linux/config.h>
-#include <linux/init.h>
-#include <linux/xattr.h>
-
-/* Magic value in attribute blocks */
-#define EXT2_XATTR_MAGIC		0xEA020000
-
-/* Maximum number of references to one attribute block */
-#define EXT2_XATTR_REFCOUNT_MAX		1024
-
-/* Name indexes */
-#define EXT2_XATTR_INDEX_MAX			10
-#define EXT2_XATTR_INDEX_USER			1
-#define EXT2_XATTR_INDEX_POSIX_ACL_ACCESS	2
-#define EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT	3
-
-struct ext2_xattr_header {
-	__u32	h_magic;	/* magic number for identification */
-	__u32	h_refcount;	/* reference count */
-	__u32	h_blocks;	/* number of disk blocks used */
-	__u32	h_hash;		/* hash value of all attributes */
-	__u32	h_reserved[4];	/* zero right now */
-};
-
-struct ext2_xattr_entry {
-	__u8	e_name_len;	/* length of name */
-	__u8	e_name_index;	/* attribute name index */
-	__u16	e_value_offs;	/* offset in disk block of value */
-	__u32	e_value_block;	/* disk block attribute is stored on (n/i) */
-	__u32	e_value_size;	/* size of attribute value */
-	__u32	e_hash;		/* hash value of name and value */
-	char	e_name[0];	/* attribute name */
-};
-
-#define EXT2_XATTR_PAD_BITS		2
-#define EXT2_XATTR_PAD		(1<<EXT2_XATTR_PAD_BITS)
-#define EXT2_XATTR_ROUND		(EXT2_XATTR_PAD-1)
-#define EXT2_XATTR_LEN(name_len) \
-	(((name_len) + EXT2_XATTR_ROUND + \
-	sizeof(struct ext2_xattr_entry)) & ~EXT2_XATTR_ROUND)
-#define EXT2_XATTR_NEXT(entry) \
-	( (struct ext2_xattr_entry *)( \
-	  (char *)(entry) + EXT2_XATTR_LEN((entry)->e_name_len)) )
-#define EXT2_XATTR_SIZE(size) \
-	(((size) + EXT2_XATTR_ROUND) & ~EXT2_XATTR_ROUND)
-
-# ifdef CONFIG_EXT2_FS_XATTR
-
-struct ext2_xattr_handler {
-	char *prefix;
-	size_t (*list)(char *list, struct inode *inode, const char *name,
-		       int name_len);
-	int (*get)(struct inode *inode, const char *name, void *buffer,
-		   size_t size);
-	int (*set)(struct inode *inode, const char *name, const void *buffer,
-		   size_t size, int flags);
-};
-
-extern int ext2_xattr_register(int, struct ext2_xattr_handler *);
-extern void ext2_xattr_unregister(int, struct ext2_xattr_handler *);
-
-extern int ext2_setxattr(struct dentry *, const char *, void *, size_t, int);
-extern ssize_t ext2_getxattr(struct dentry *, const char *, void *, size_t);
-extern ssize_t ext2_listxattr(struct dentry *, char *, size_t);
-extern int ext2_removexattr(struct dentry *, const char *);
-
-extern int ext2_xattr_get(struct inode *, int, const char *, void *, size_t);
-extern int ext2_xattr_list(struct inode *, char *, size_t);
-extern int ext2_xattr_set(struct inode *, int, const char *, const void *, size_t, int);
-
-extern void ext2_xattr_delete_inode(struct inode *);
-extern void ext2_xattr_put_super(struct super_block *);
-
-extern int init_ext2_xattr(void) __init;
-extern void exit_ext2_xattr(void);
-
-# else  /* CONFIG_EXT2_FS_XATTR */
-#  define ext2_setxattr		NULL
-#  define ext2_getxattr		NULL
-#  define ext2_listxattr	NULL
-#  define ext2_removexattr	NULL
-
-static inline int
-ext2_xattr_get(struct inode *inode, int name_index,
-	       const char *name, void *buffer, size_t size)
-{
-	return -ENOTSUP;
-}
-
-static inline int
-ext2_xattr_list(struct inode *inode, char *buffer, size_t size)
-{
-	return -ENOTSUP;
-}
-
-static inline int
-ext2_xattr_set(struct inode *inode, int name_index, const char *name,
-	       const void *value, size_t size, int flags)
-{
-	return -ENOTSUP;
-}
-
-static inline void
-ext2_xattr_delete_inode(struct inode *inode)
-{
-}
-
-static inline void
-ext2_xattr_put_super(struct super_block *sb)
-{
-}
-
-static inline int
-init_ext2_xattr(void)
-{
-	return 0;
-}
-
-static inline void
-exit_ext2_xattr(void)
-{
-}
-
-# endif  /* CONFIG_EXT2_FS_XATTR */
-
-extern struct ext2_xattr_handler ext2_xattr_user_handler;
-
