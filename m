Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264656AbSJOPaJ>; Tue, 15 Oct 2002 11:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbSJOPaJ>; Tue, 15 Oct 2002 11:30:09 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:46085 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264656AbSJOP3W>; Tue, 15 Oct 2002 11:29:22 -0400
Date: Tue, 15 Oct 2002 16:34:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021015163444.D27906@infradead.org>
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

Patch 4: first round of ext3 cleanups (all against 2.5.42-mm3):

o same for ext3


--- linux-2.5.42-mm3-plain/fs/ext3/file.c	Tue Oct 15 17:05:08 2002
+++ linux-2.5.42-mm3/fs/ext3/file.c	Tue Oct 15 13:49:48 2002
@@ -22,9 +22,8 @@
 #include <linux/fs.h>
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
-#include <linux/ext3_xattr.h>
 #include <linux/ext3_jbd.h>
-#include <linux/smp_lock.h>
+#include "xattr.h"
 
 /*
  * Called when an inode is released. Note that this is different
--- linux-2.5.42-mm3-plain/fs/ext3/ialloc.c	Tue Oct 15 17:05:08 2002
+++ linux-2.5.42-mm3/fs/ext3/ialloc.c	Tue Oct 15 13:22:07 2002
@@ -17,7 +17,6 @@
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
-#include <linux/ext3_xattr.h>
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/quotaops.h>
@@ -25,6 +24,8 @@
 
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
+
+#include "xattr.h"
 
 /*
  * ialloc.c contains the inodes allocation and deallocation routines
--- linux-2.5.42-mm3-plain/fs/ext3/namei.c	Tue Oct 15 17:05:08 2002
+++ linux-2.5.42-mm3/fs/ext3/namei.c	Tue Oct 15 13:22:36 2002
@@ -30,13 +30,13 @@
 #include <linux/time.h>
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
-#include <linux/ext3_xattr.h>
 #include <linux/fcntl.h>
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/quotaops.h>
 #include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
+#include "xattr.h"
 
 
 /*
--- linux-2.5.42-mm3-plain/fs/ext3/super.c	Tue Oct 15 17:05:09 2002
+++ linux-2.5.42-mm3/fs/ext3/super.c	Tue Oct 15 13:23:10 2002
@@ -24,13 +24,13 @@
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
-#include <linux/ext3_xattr.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 #include <asm/uaccess.h>
+#include "xattr.h"
 
 #ifdef CONFIG_JBD_DEBUG
 static int ext3_ro_after; /* Make fs read-only after this many jiffies */
--- linux-2.5.42-mm3-plain/fs/ext3/symlink.c	Tue Oct 15 17:05:09 2002
+++ linux-2.5.42-mm3/fs/ext3/symlink.c	Tue Oct 15 13:50:16 2002
@@ -20,7 +20,7 @@
 #include <linux/fs.h>
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
-#include <linux/ext3_xattr.h>
+#include "xattr.h"
 
 static int ext3_readlink(struct dentry *dentry, char *buffer, int buflen)
 {
--- linux-2.5.42-mm3-plain/fs/ext3/xattr.c	Tue Oct 15 17:05:09 2002
+++ linux-2.5.42-mm3/fs/ext3/xattr.c	Tue Oct 15 16:13:25 2002
@@ -52,15 +52,15 @@
  * if the block is shared among inodes.
  */
 
+#include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/ext3_jbd.h>
 #include <linux/ext3_fs.h>
-#include <linux/ext3_xattr.h>
 #include <linux/mbcache.h>
 #include <linux/quotaops.h>
 #include <asm/semaphore.h>
-#include <linux/compatmac.h>
+#include "xattr.h"
 
 #define EXT3_EA_USER "user."
 
@@ -105,76 +105,7 @@
  * filesystem may still contain shared blocks, so we always take
  * the lock.
  */
-
-DECLARE_MUTEX(ext3_xattr_sem);
-
-static inline void
-ext3_xattr_lock(void)
-{
-	down(&ext3_xattr_sem);
-}
-
-static inline void
-ext3_xattr_unlock(void)
-{
-	up(&ext3_xattr_sem);
-}
-
-static inline int
-ext3_xattr_new_block(handle_t *handle, struct inode *inode,
-		     int * errp, int force)
-{
-	struct super_block *sb = inode->i_sb;
-	int goal = le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) +
-		EXT3_I(inode)->i_block_group * EXT3_BLOCKS_PER_GROUP(sb);
-
-	/* How can we enforce the allocation? */
-	int block = ext3_new_block(handle, inode, goal, 0, 0, errp);
-#ifdef OLD_QUOTAS
-	if (!*errp)
-		inode->i_blocks += inode->i_sb->s_blocksize >> 9;
-#endif
-	return block;
-}
-
-static inline int
-ext3_xattr_quota_alloc(struct inode *inode, int force)
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
-ext3_xattr_quota_free(struct inode *inode)
-{
-	DQUOT_FREE_BLOCK(inode->i_sb, inode, 1);
-	inode->i_blocks -= inode->i_sb->s_blocksize >> 9;
-}
-
-static inline void
-ext3_xattr_free_block(handle_t *handle, struct inode * inode,
-		      unsigned long block)
-{
-	ext3_free_blocks(handle, inode, block, 1);
-	inode->i_blocks -= inode->i_sb->s_blocksize >> 9;
-}
-
-#else
-# define ext3_xattr_quota_free(inode) \
-	DQUOT_FREE_BLOCK(inode, 1)
-# define ext3_xattr_free_block(handle, inode, block) \
-	ext3_free_blocks(handle, inode, block, 1)
-#endif
-
+static DECLARE_MUTEX(ext3_xattr_sem);
 struct ext3_xattr_handler *ext3_xattr_handlers[EXT3_XATTR_INDEX_MAX];
 rwlock_t ext3_handler_lock = RW_LOCK_UNLOCKED;
 
@@ -575,8 +506,8 @@
 	name_len = strlen(name);
 	if (name_len > 255 || value_len > sb->s_blocksize)
 		return -ERANGE;
-	ext3_xattr_lock();
 
+	down(&ext3_xattr_sem);
 	if (EXT3_I(inode)->i_file_acl) {
 		/* The inode already has an extended attribute block. */
 		int block = EXT3_I(inode)->i_file_acl;
@@ -775,7 +706,7 @@
 	brelse(bh);
 	if (!(bh && header == HDR(bh)))
 		kfree(header);
-	ext3_xattr_unlock();
+	up(&ext3_xattr_sem);
 
 	return error;
 }
@@ -803,7 +734,8 @@
 				new_bh->b_blocknr);
 			
 			error = -EDQUOT;
-			if (ext3_xattr_quota_alloc(inode, 1))
+			/* How can we enforce the allocation? */
+			if (DQUOT_ALLOC_BLOCK(inode, 1))
 				goto cleanup;
 			
 			error = ext3_journal_get_write_access(handle, new_bh);
@@ -819,16 +751,18 @@
 			ext3_xattr_cache_insert(new_bh);
 		} else {
 			/* We need to allocate a new block */
-			int force = EXT3_I(inode)->i_file_acl != 0;
-			int block = ext3_xattr_new_block(handle, inode,
-							 &error, force);
+			int goal = le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) +
+					EXT3_I(inode)->i_block_group * EXT3_BLOCKS_PER_GROUP(sb);
+			/* How can we enforce the allocation? */
+			int block = ext3_new_block(handle, inode, goal, 0, 0, &error);
 			if (error)
 				goto cleanup;
 			ea_idebug(inode, "creating block %d", block);
 
 			new_bh = sb_getblk(sb, block);
 			if (!new_bh) {
-getblk_failed:			ext3_xattr_free_block(handle, inode, block);
+getblk_failed:
+				ext3_free_blocks(handle, inode, block, 1);
 				error = -EIO;
 				goto cleanup;
 			}
@@ -871,7 +805,7 @@
 		if (refcount == 1) {
 			/* Free the old block. */
 			ea_bdebug(old_bh, "freeing");
-			ext3_xattr_free_block(handle, inode, old_bh->b_blocknr);
+			ext3_free_blocks(handle, inode, old_bh->b_blocknr, 1);
 
 			/* ext3_forget() calls bforget() for us, but we
 			   let our caller release old_bh, so we need to
@@ -882,7 +816,7 @@
 			/* Decrement the refcount only. */
 			refcount--;
 			HDR(old_bh)->h_refcount = cpu_to_le32(refcount);
-			ext3_xattr_quota_free(inode);
+			DQUOT_FREE_BLOCK(inode, 1);
 			ext3_journal_dirty_metadata(handle, old_bh);
 			ea_bdebug(old_bh, "refcount now=%d", refcount);
 		}
@@ -909,8 +843,8 @@
 
 	if (!block)
 		return;
-	ext3_xattr_lock();
 
+	down(&ext3_xattr_sem);
 	bh = sb_bread(inode->i_sb, block);
 	if (!bh) {
 		ext3_error(inode->i_sb, "ext3_xattr_delete_inode",
@@ -928,7 +862,7 @@
 	ea_bdebug(bh, "refcount now=%d", le32_to_cpu(HDR(bh)->h_refcount) - 1);
 	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
 		ext3_xattr_cache_remove(bh);
-		ext3_xattr_free_block(handle, inode, block);
+		ext3_free_blocks(handle, inode, block, 1);
 		ext3_forget(handle, 1, inode, bh, block);
 		bh = NULL;
 	} else {
@@ -937,13 +871,13 @@
 		ext3_journal_dirty_metadata(handle, bh);
 		if (IS_SYNC(inode))
 			handle->h_sync = 1;
-		ext3_xattr_quota_free(inode);
+		DQUOT_FREE_BLOCK(inode, 1);
 	}
 	EXT3_I(inode)->i_file_acl = 0;
 
 cleanup:
 	brelse(bh);
-	ext3_xattr_unlock();
+	up(&ext3_xattr_sem);
 }
 
 /*
--- linux-2.5.42-mm3-plain/fs/ext3/xattr.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.42-mm3/fs/ext3/xattr.h	Tue Oct 15 13:45:27 2002
@@ -0,0 +1,136 @@
+/*
+  File: fs/ext3/xattr.h
+
+  On-disk format of extended attributes for the ext3 filesystem.
+
+  (C) 2001 Andreas Gruenbacher, <a.gruenbacher@computer.org>
+*/
+
+#include <linux/config.h>
+#include <linux/xattr.h>
+
+/* Magic value in attribute blocks */
+#define EXT3_XATTR_MAGIC		0xEA020000
+
+/* Maximum number of references to one attribute block */
+#define EXT3_XATTR_REFCOUNT_MAX		1024
+
+/* Name indexes */
+#define EXT3_XATTR_INDEX_MAX			10
+#define EXT3_XATTR_INDEX_USER			1
+#define EXT3_XATTR_INDEX_POSIX_ACL_ACCESS	2
+#define EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT	3
+
+struct ext3_xattr_header {
+	__u32	h_magic;	/* magic number for identification */
+	__u32	h_refcount;	/* reference count */
+	__u32	h_blocks;	/* number of disk blocks used */
+	__u32	h_hash;		/* hash value of all attributes */
+	__u32	h_reserved[4];	/* zero right now */
+};
+
+struct ext3_xattr_entry {
+	__u8	e_name_len;	/* length of name */
+	__u8	e_name_index;	/* attribute name index */
+	__u16	e_value_offs;	/* offset in disk block of value */
+	__u32	e_value_block;	/* disk block attribute is stored on (n/i) */
+	__u32	e_value_size;	/* size of attribute value */
+	__u32	e_hash;		/* hash value of name and value */
+	char	e_name[0];	/* attribute name */
+};
+
+#define EXT3_XATTR_PAD_BITS		2
+#define EXT3_XATTR_PAD		(1<<EXT3_XATTR_PAD_BITS)
+#define EXT3_XATTR_ROUND		(EXT3_XATTR_PAD-1)
+#define EXT3_XATTR_LEN(name_len) \
+	(((name_len) + EXT3_XATTR_ROUND + \
+	sizeof(struct ext3_xattr_entry)) & ~EXT3_XATTR_ROUND)
+#define EXT3_XATTR_NEXT(entry) \
+	( (struct ext3_xattr_entry *)( \
+	  (char *)(entry) + EXT3_XATTR_LEN((entry)->e_name_len)) )
+#define EXT3_XATTR_SIZE(size) \
+	(((size) + EXT3_XATTR_ROUND) & ~EXT3_XATTR_ROUND)
+
+# ifdef CONFIG_EXT3_FS_XATTR
+
+struct ext3_xattr_handler {
+	char *prefix;
+	size_t (*list)(char *list, struct inode *inode, const char *name,
+		       int name_len);
+	int (*get)(struct inode *inode, const char *name, void *buffer,
+		   size_t size);
+	int (*set)(struct inode *inode, const char *name, const void *buffer,
+		   size_t size, int flags);
+};
+
+extern int ext3_xattr_register(int, struct ext3_xattr_handler *);
+extern void ext3_xattr_unregister(int, struct ext3_xattr_handler *);
+
+extern int ext3_setxattr(struct dentry *, const char *, void *, size_t, int);
+extern ssize_t ext3_getxattr(struct dentry *, const char *, void *, size_t);
+extern ssize_t ext3_listxattr(struct dentry *, char *, size_t);
+extern int ext3_removexattr(struct dentry *, const char *);
+
+extern int ext3_xattr_get(struct inode *, int, const char *, void *, size_t);
+extern int ext3_xattr_list(struct inode *, char *, size_t);
+extern int ext3_xattr_set(handle_t *handle, struct inode *, int, const char *, const void *, size_t, int);
+
+extern void ext3_xattr_delete_inode(handle_t *, struct inode *);
+extern void ext3_xattr_put_super(struct super_block *);
+
+extern int init_ext3_xattr(void);
+extern void exit_ext3_xattr(void);
+
+# else  /* CONFIG_EXT3_FS_XATTR */
+#  define ext3_setxattr		NULL
+#  define ext3_getxattr		NULL
+#  define ext3_listxattr	NULL
+#  define ext3_removexattr	NULL
+
+static inline int
+ext3_xattr_get(struct inode *inode, int name_index, const char *name,
+	       void *buffer, size_t size, int flags)
+{
+	return -ENOTSUPP;
+}
+
+static inline int
+ext3_xattr_list(struct inode *inode, void *buffer, size_t size, int flags)
+{
+	return -ENOTSUPP;
+}
+
+static inline int
+ext3_xattr_set(handle_t *handle, struct inode *inode, int name_index,
+	       const char *name, const void *value, size_t size, int flags)
+{
+	return -ENOTSUPP;
+}
+
+static inline void
+ext3_xattr_delete_inode(handle_t *handle, struct inode *inode)
+{
+}
+
+static inline void
+ext3_xattr_put_super(struct super_block *sb)
+{
+}
+
+static inline int
+init_ext3_xattr(void)
+{
+	return 0;
+}
+
+static inline void
+exit_ext3_xattr(void)
+{
+}
+
+# endif  /* CONFIG_EXT3_FS_XATTR */
+
+extern struct ext3_xattr_handler ext3_xattr_user_handler;
+
+
+
--- linux-2.5.42-mm3-plain/fs/ext3/xattr_user.c	Tue Oct 15 17:05:09 2002
+++ linux-2.5.42-mm3/fs/ext3/xattr_user.c	Tue Oct 15 16:13:54 2002
@@ -11,7 +11,7 @@
 #include <linux/smp_lock.h>
 #include <linux/ext3_jbd.h>
 #include <linux/ext3_fs.h>
-#include <linux/ext3_xattr.h>
+#include "xattr.h"
 
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
 # include <linux/ext3_acl.h>
--- linux-2.5.42-mm3-plain/include/linux/ext3_xattr.h	Tue Oct 15 17:05:12 2002
+++ linux-2.5.42-mm3/include/linux/ext3_xattr.h	Thu Jan  1 01:00:00 1970
@@ -1,137 +0,0 @@
-/*
-  File: linux/ext3_xattr.h
-
-  On-disk format of extended attributes for the ext3 filesystem.
-
-  (C) 2001 Andreas Gruenbacher, <a.gruenbacher@computer.org>
-*/
-
-#include <linux/config.h>
-#include <linux/init.h>
-#include <linux/xattr.h>
-
-/* Magic value in attribute blocks */
-#define EXT3_XATTR_MAGIC		0xEA020000
-
-/* Maximum number of references to one attribute block */
-#define EXT3_XATTR_REFCOUNT_MAX		1024
-
-/* Name indexes */
-#define EXT3_XATTR_INDEX_MAX			10
-#define EXT3_XATTR_INDEX_USER			1
-#define EXT3_XATTR_INDEX_POSIX_ACL_ACCESS	2
-#define EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT	3
-
-struct ext3_xattr_header {
-	__u32	h_magic;	/* magic number for identification */
-	__u32	h_refcount;	/* reference count */
-	__u32	h_blocks;	/* number of disk blocks used */
-	__u32	h_hash;		/* hash value of all attributes */
-	__u32	h_reserved[4];	/* zero right now */
-};
-
-struct ext3_xattr_entry {
-	__u8	e_name_len;	/* length of name */
-	__u8	e_name_index;	/* attribute name index */
-	__u16	e_value_offs;	/* offset in disk block of value */
-	__u32	e_value_block;	/* disk block attribute is stored on (n/i) */
-	__u32	e_value_size;	/* size of attribute value */
-	__u32	e_hash;		/* hash value of name and value */
-	char	e_name[0];	/* attribute name */
-};
-
-#define EXT3_XATTR_PAD_BITS		2
-#define EXT3_XATTR_PAD		(1<<EXT3_XATTR_PAD_BITS)
-#define EXT3_XATTR_ROUND		(EXT3_XATTR_PAD-1)
-#define EXT3_XATTR_LEN(name_len) \
-	(((name_len) + EXT3_XATTR_ROUND + \
-	sizeof(struct ext3_xattr_entry)) & ~EXT3_XATTR_ROUND)
-#define EXT3_XATTR_NEXT(entry) \
-	( (struct ext3_xattr_entry *)( \
-	  (char *)(entry) + EXT3_XATTR_LEN((entry)->e_name_len)) )
-#define EXT3_XATTR_SIZE(size) \
-	(((size) + EXT3_XATTR_ROUND) & ~EXT3_XATTR_ROUND)
-
-# ifdef CONFIG_EXT3_FS_XATTR
-
-struct ext3_xattr_handler {
-	char *prefix;
-	size_t (*list)(char *list, struct inode *inode, const char *name,
-		       int name_len);
-	int (*get)(struct inode *inode, const char *name, void *buffer,
-		   size_t size);
-	int (*set)(struct inode *inode, const char *name, const void *buffer,
-		   size_t size, int flags);
-};
-
-extern int ext3_xattr_register(int, struct ext3_xattr_handler *);
-extern void ext3_xattr_unregister(int, struct ext3_xattr_handler *);
-
-extern int ext3_setxattr(struct dentry *, const char *, void *, size_t, int);
-extern ssize_t ext3_getxattr(struct dentry *, const char *, void *, size_t);
-extern ssize_t ext3_listxattr(struct dentry *, char *, size_t);
-extern int ext3_removexattr(struct dentry *, const char *);
-
-extern int ext3_xattr_get(struct inode *, int, const char *, void *, size_t);
-extern int ext3_xattr_list(struct inode *, char *, size_t);
-extern int ext3_xattr_set(handle_t *handle, struct inode *, int, const char *, const void *, size_t, int);
-
-extern void ext3_xattr_delete_inode(handle_t *, struct inode *);
-extern void ext3_xattr_put_super(struct super_block *);
-
-extern int init_ext3_xattr(void) __init;
-extern void exit_ext3_xattr(void);
-
-# else  /* CONFIG_EXT3_FS_XATTR */
-#  define ext3_setxattr		NULL
-#  define ext3_getxattr		NULL
-#  define ext3_listxattr	NULL
-#  define ext3_removexattr	NULL
-
-static inline int
-ext3_xattr_get(struct inode *inode, int name_index, const char *name,
-	       void *buffer, size_t size, int flags)
-{
-	return -ENOTSUP;
-}
-
-static inline int
-ext3_xattr_list(struct inode *inode, void *buffer, size_t size, int flags)
-{
-	return -ENOTSUP;
-}
-
-static inline int
-ext3_xattr_set(handle_t *handle, struct inode *inode, int name_index,
-	       const char *name, const void *value, size_t size, int flags)
-{
-	return -ENOTSUP;
-}
-
-static inline void
-ext3_xattr_delete_inode(handle_t *handle, struct inode *inode)
-{
-}
-
-static inline void
-ext3_xattr_put_super(struct super_block *sb)
-{
-}
-
-static inline int
-init_ext3_xattr(void)
-{
-	return 0;
-}
-
-static inline void
-exit_ext3_xattr(void)
-{
-}
-
-# endif  /* CONFIG_EXT3_FS_XATTR */
-
-extern struct ext3_xattr_handler ext3_xattr_user_handler;
-
-
-
