Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263112AbVAFXAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbVAFXAE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbVAFW7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:59:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63502 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263103AbVAFWu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:50:57 -0500
Date: Thu, 6 Jan 2005 23:50:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/ext3/: possible cleanups
Message-ID: <20050106225051.GF28628@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following cleanups:
- make some needlessly global code static
- super.c: remove the unused global function ext3_panic

Please comment ib whether this patch is correct or conflicts with 
pending changes.


diffstat output:
 fs/ext3/balloc.c         |    2 
 fs/ext3/dir.c            |    2 
 fs/ext3/inode.c          |    4 
 fs/ext3/resize.c         |    4 
 fs/ext3/super.c          |   45 ++-----
 fs/ext3/xattr.c          |  242 +++++++++++++++++++--------------------
 fs/ext3/xattr.h          |    8 -
 include/linux/ext3_fs.h  |   10 -
 include/linux/ext3_jbd.h |    2 
 9 files changed, 143 insertions(+), 176 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/fs/ext3/balloc.c.old	2005-01-06 23:19:18.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/ext3/balloc.c	2005-01-06 23:19:26.000000000 +0100
@@ -1451,7 +1451,7 @@
 	}
 }
 
-int ext3_group_sparse(int group)
+static int ext3_group_sparse(int group)
 {
 	return (test_root(group, 3) || test_root(group, 5) ||
 		test_root(group, 7));
--- linux-2.6.10-mm2-full/fs/ext3/dir.c.old	2005-01-06 23:20:02.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/ext3/dir.c	2005-01-06 23:20:11.000000000 +0100
@@ -306,7 +306,7 @@
 }
 
 
-struct dir_private_info *create_dir_info(loff_t pos)
+static struct dir_private_info *create_dir_info(loff_t pos)
 {
 	struct dir_private_info *p;
 
--- linux-2.6.10-mm2-full/include/linux/ext3_jbd.h.old	2005-01-06 23:20:34.000000000 +0100
+++ linux-2.6.10-mm2-full/include/linux/ext3_jbd.h	2005-01-06 23:21:06.000000000 +0100
@@ -46,8 +46,6 @@
 					 EXT3_XATTR_TRANS_BLOCKS - 2 + \
 					 2*EXT3_QUOTA_TRANS_BLOCKS)
 
-extern int ext3_writepage_trans_blocks(struct inode *inode);
-
 /* Delete operations potentially hit one directory's namespace plus an
  * entire inode, plus arbitrary amounts of bitmap/indirection data.  Be
  * generous.  We can grow the delete transaction later if necessary. */
--- linux-2.6.10-mm2-full/fs/ext3/inode.c.old	2005-01-06 23:21:49.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/ext3/inode.c	2005-01-06 23:22:20.000000000 +0100
@@ -39,6 +39,8 @@
 #include "xattr.h"
 #include "acl.h"
 
+static int ext3_writepage_trans_blocks(struct inode *inode);
+
 /*
  * Test whether an inode is a fast symlink.
  */
@@ -2807,7 +2809,7 @@
  * block and work out the exact number of indirects which are touched.  Pah.
  */
 
-int ext3_writepage_trans_blocks(struct inode *inode)
+static int ext3_writepage_trans_blocks(struct inode *inode)
 {
 	int bpp = ext3_journal_blocks_per_page(inode);
 	int indirects = (EXT3_NDIR_BLOCKS % bpp) ? 5 : 3;
--- linux-2.6.10-mm2-full/fs/ext3/resize.c.old	2005-01-06 23:22:37.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/ext3/resize.c	2005-01-06 23:22:50.000000000 +0100
@@ -285,8 +285,8 @@
  * sequence of powers of 3, 5, and 7: 1, 3, 5, 7, 9, 25, 27, 49, 81, ...
  * For a non-sparse filesystem it will be every group: 1, 2, 3, 4, ...
  */
-unsigned ext3_list_backups(struct super_block *sb, unsigned *three,
-			   unsigned *five, unsigned *seven)
+static unsigned ext3_list_backups(struct super_block *sb, unsigned *three,
+				  unsigned *five, unsigned *seven)
 {
 	unsigned *min = three;
 	int mult = 3;
--- linux-2.6.10-mm2-full/include/linux/ext3_fs.h.old	2005-01-06 23:23:16.000000000 +0100
+++ linux-2.6.10-mm2-full/include/linux/ext3_fs.h	2005-01-06 23:27:28.000000000 +0100
@@ -793,25 +793,15 @@
 extern void __ext3_std_error (struct super_block *, const char *, int);
 extern void ext3_abort (struct super_block *, const char *, const char *, ...)
 	__attribute__ ((format (printf, 3, 4)));
-extern NORET_TYPE void ext3_panic (struct super_block *, const char *,
-				   const char *, ...)
-	__attribute__ ((NORET_AND format (printf, 3, 4)));
 extern void ext3_warning (struct super_block *, const char *, const char *, ...)
 	__attribute__ ((format (printf, 3, 4)));
 extern void ext3_update_dynamic_rev (struct super_block *sb);
-extern void ext3_put_super (struct super_block *);
-extern void ext3_write_super (struct super_block *);
-extern void ext3_write_super_lockfs (struct super_block *);
-extern void ext3_unlockfs (struct super_block *);
-extern int ext3_remount (struct super_block *, int *, char *);
-extern int ext3_statfs (struct super_block *, struct kstatfs *);
 
 #define ext3_std_error(sb, errno)				\
 do {								\
 	if ((errno))						\
 		__ext3_std_error((sb), __FUNCTION__, (errno));	\
 } while (0)
-extern const char *ext3_decode_error(struct super_block *sb, int errno, char nbuf[16]);
 
 /*
  * Inodes and files operations
--- linux-2.6.10-mm2-full/fs/ext3/super.c.old	2005-01-06 23:23:39.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/ext3/super.c	2005-01-06 23:28:34.000000000 +0100
@@ -50,6 +50,13 @@
 static void ext3_clear_journal_err(struct super_block * sb,
 				   struct ext3_super_block * es);
 static int ext3_sync_fs(struct super_block *sb, int wait);
+static const char *ext3_decode_error(struct super_block * sb, int errno,
+				     char nbuf[16]);
+static int ext3_remount (struct super_block * sb, int * flags, char * data);
+static int ext3_statfs (struct super_block * sb, struct kstatfs * buf);
+static void ext3_unlockfs(struct super_block *sb);
+static void ext3_write_super (struct super_block * sb);
+static void ext3_write_super_lockfs(struct super_block *sb);
 
 /* 
  * Wrappers for journal_start/end.
@@ -178,7 +185,8 @@
 	ext3_handle_error(sb);
 }
 
-const char *ext3_decode_error(struct super_block * sb, int errno, char nbuf[16])
+static const char *ext3_decode_error(struct super_block * sb, int errno,
+				     char nbuf[16])
 {
 	char *errstr = NULL;
 
@@ -261,29 +269,6 @@
 	journal_abort(EXT3_SB(sb)->s_journal, -EIO);
 }
 
-/* Deal with the reporting of failure conditions while running, such as
- * inconsistencies in operation or invalid system states.
- *
- * Use ext3_error() for cases of invalid filesystem states, as that will
- * record an error on disk and force a filesystem check on the next boot.
- */
-NORET_TYPE void ext3_panic (struct super_block * sb, const char * function,
-			    const char * fmt, ...)
-{
-	va_list args;
-
-	va_start(args, fmt);
-	printk(KERN_CRIT "EXT3-fs error (device %s): %s: ",sb->s_id, function);
-	vprintk(fmt, args);
-	printk("\n");
-	va_end(args);
-
-	/* this is to prevent panic from syncing this filesystem */
-	/* AKPM: is this sufficient? */
-	sb->s_flags |= MS_RDONLY;
-	panic ("EXT3-fs panic forced\n");
-}
-
 void ext3_warning (struct super_block * sb, const char * function,
 		   const char * fmt, ...)
 {
@@ -386,7 +371,7 @@
 	}
 }
 
-void ext3_put_super (struct super_block * sb)
+static void ext3_put_super (struct super_block * sb)
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	struct ext3_super_block *es = sbi->s_es;
@@ -2018,7 +2003,7 @@
  * This implicitly triggers the writebehind on sync().
  */
 
-void ext3_write_super (struct super_block * sb)
+static void ext3_write_super (struct super_block * sb)
 {
 	if (down_trylock(&sb->s_lock) == 0)
 		BUG();
@@ -2041,7 +2026,7 @@
  * LVM calls this function before a (read-only) snapshot is created.  This
  * gives us a chance to flush the journal completely and mark the fs clean.
  */
-void ext3_write_super_lockfs(struct super_block *sb)
+static void ext3_write_super_lockfs(struct super_block *sb)
 {
 	sb->s_dirt = 0;
 
@@ -2062,7 +2047,7 @@
  * Called by LVM after the snapshot is done.  We need to reset the RECOVER
  * flag here, even though the filesystem is not technically dirty yet.
  */
-void ext3_unlockfs(struct super_block *sb)
+static void ext3_unlockfs(struct super_block *sb)
 {
 	if (!(sb->s_flags & MS_RDONLY)) {
 		lock_super(sb);
@@ -2074,7 +2059,7 @@
 	}
 }
 
-int ext3_remount (struct super_block * sb, int * flags, char * data)
+static int ext3_remount (struct super_block * sb, int * flags, char * data)
 {
 	struct ext3_super_block * es;
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
@@ -2146,7 +2131,7 @@
 	return 0;
 }
 
-int ext3_statfs (struct super_block * sb, struct kstatfs * buf)
+static int ext3_statfs (struct super_block * sb, struct kstatfs * buf)
 {
 	struct ext3_super_block *es = EXT3_SB(sb)->s_es;
 	unsigned long overhead;
--- linux-2.6.10-mm2-full/fs/ext3/xattr.h.old	2005-01-06 23:29:45.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/ext3/xattr.h	2005-01-06 23:32:17.000000000 +0100
@@ -65,10 +65,8 @@
 extern ssize_t ext3_listxattr(struct dentry *, char *, size_t);
 
 extern int ext3_xattr_get(struct inode *, int, const char *, void *, size_t);
-extern int ext3_xattr_list(struct inode *, char *, size_t);
 extern int ext3_xattr_set(struct inode *, int, const char *, const void *, size_t, int);
 extern int ext3_xattr_set_handle(handle_t *, struct inode *, int, const char *,const void *,size_t,int);
-extern int ext3_xattr_block_set(handle_t *, struct inode *, int, const char *,const void *,size_t,int);
 
 extern void ext3_xattr_delete_inode(handle_t *, struct inode *);
 extern void ext3_xattr_put_super(struct super_block *);
@@ -88,12 +86,6 @@
 }
 
 static inline int
-ext3_xattr_list(struct inode *inode, void *buffer, size_t size)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int
 ext3_xattr_set(struct inode *inode, int name_index, const char *name,
 	       const void *value, size_t size, int flags)
 {
--- linux-2.6.10-mm2-full/fs/ext3/xattr.c.old	2005-01-06 23:28:52.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/ext3/xattr.c	2005-01-06 23:33:06.000000000 +0100
@@ -139,22 +139,11 @@
 }
 
 /*
- * Inode operation listxattr()
- *
- * dentry->d_inode->i_sem: don't care
- */
-ssize_t
-ext3_listxattr(struct dentry *dentry, char *buffer, size_t size)
-{
-	return ext3_xattr_list(dentry->d_inode, buffer, size);
-}
-
-/*
  * ext3_xattr_block_get()
  *
  * routine looks for attribute in EA block and returns it's value and size
  */
-int
+static int
 ext3_xattr_block_get(struct inode *inode, int name_index, const char *name,
 	       void *buffer, size_t buffer_size)
 {
@@ -250,7 +239,7 @@
  *
  * routine looks for attribute in inode body and returns it's value and size
  */
-int
+static int
 ext3_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 	       void *buffer, size_t buffer_size)
 {
@@ -352,7 +341,7 @@
  *
  * generate list of attributes stored in EA block
  */
-int
+static int
 ext3_xattr_block_list(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	struct buffer_head *bh = NULL;
@@ -428,7 +417,7 @@
  *
  * generate list of attributes stored in inode body
  */
-int
+static int
 ext3_xattr_ibody_list(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	struct ext3_xattr_entry *last;
@@ -507,7 +496,7 @@
  * Returns a negative error number on failure, or the number of bytes
  * used / required on success.
  */
-int
+static int
 ext3_xattr_list(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	int size = buffer_size;
@@ -546,6 +535,17 @@
 }
 
 /*
+ * Inode operation listxattr()
+ *
+ * dentry->d_inode->i_sem: don't care
+ */
+ssize_t
+ext3_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	return ext3_xattr_list(dentry->d_inode, buffer, size);
+}
+
+/*
  * If the EXT3_FEATURE_COMPAT_EXT_ATTR feature of this file system is
  * not set, set it.
  */
@@ -571,7 +571,7 @@
  * search attribute and calculate free space in inode body
  * NOTE: free space includes space our attribute hold
  */
-int
+static int
 ext3_xattr_ibody_find(struct inode *inode, int name_index,
 			const char *name, int *free)
 {
@@ -638,7 +638,7 @@
  * search attribute and calculate free space in EA block (if it allocated)
  * NOTE: free space includes space our attribute hold
  */
-int
+static int
 ext3_xattr_block_find(struct inode *inode, int name_index,
 			const char *name, int *free)
 {
@@ -698,7 +698,7 @@
  *
  * this routine add/remove/replace attribute in inode body
  */
-int
+static int
 ext3_xattr_ibody_set(handle_t *handle, struct inode *inode, int name_index,
 		      const char *name, const void *value, size_t value_len,
 		      int flags)
@@ -846,112 +846,11 @@
 }
 
 /*
- * ext3_xattr_set_handle()
- *
- * Create, replace or remove an extended attribute for this inode. Buffer
- * is NULL to remove an existing extended attribute, and non-NULL to
- * either replace an existing extended attribute, or create a new extended
- * attribute. The flags XATTR_REPLACE and XATTR_CREATE
- * specify that an extended attribute must exist and must not exist
- * previous to the call, respectively.
- *
- * Returns 0, or a negative error number on failure.
- */
-int
-ext3_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
-		const char *name, const void *value, size_t value_len,
-		int flags)
-{
-	int free1 = -1, free2 = -1;
-	int err, where = 0, total;
-	int name_len;
-
-	ea_idebug(inode, "name=%d.%s, value=%p, value_len=%ld",
-		  name_index, name, value, (long)value_len);
-
-	if (IS_RDONLY(inode))
-		return -EROFS;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
-		return -EPERM;
-	if (value == NULL)
-		value_len = 0;
-	if (name == NULL)
-		return -EINVAL;
-	name_len = strlen(name);
-	if (name_len > 255 || value_len > inode->i_sb->s_blocksize)
-		return -ERANGE;
-	down_write(&EXT3_I(inode)->xattr_sem);
-
-#define EX_FOUND_IN_IBODY	1
-#define EX_FOUND_IN_BLOCK	2
-
-	/* try to find attribute in inode body */
-	err = ext3_xattr_ibody_find(inode, name_index, name, &free1);
-	if (err == 0) {
-		/* found EA in inode */
-		where = EX_FOUND_IN_IBODY;
-	} else if (err == -ENOENT) {
-		/* there is no such attribute in inode body */
-		/* try to find attribute in dedicated block */
-		err = ext3_xattr_block_find(inode, name_index, name, &free2);
-		if (err != 0 && err != -ENOENT) {
-			/* not found EA in block */
-			goto finish;
-		} else if (err == 0) {
-			/* found EA in block */
-			where = EX_FOUND_IN_BLOCK;
-		}
-	} else
-		goto finish;
-
-	/* check flags: may replace? may create ? */
-	if (where && (flags & XATTR_CREATE)) {
-		err = -EEXIST;
-		goto finish;
-	} else if (!where && (flags & XATTR_REPLACE)) {
-		err = -ENODATA;
-		goto finish;
-	}
-
-	/* check if we have enough space to store attribute */
-	total = EXT3_XATTR_LEN(strlen(name)) + value_len;
-	if (total > free1 && free2 > 0 && total > free2) {
-		/* have no enough space */
-		err = -ENOSPC;
-		goto finish;
-	}
-
-	/* there are two cases when we want to remove EA from original storage:
-	 * a) EA is stored in the inode, but new value doesn't fit
-	 * b) EA is stored in the block, but new value fit in inode
-	 */
-	if (where == EX_FOUND_IN_IBODY && total > free1)
-		ext3_xattr_ibody_set(handle, inode, name_index, name,
-					NULL, 0, flags);
-	else if (where == EX_FOUND_IN_BLOCK && total <= free1)
-		ext3_xattr_block_set(handle, inode, name_index,
-					name, NULL, 0, flags);
-
-	/* try to store EA in inode body */
-	err = ext3_xattr_ibody_set(handle, inode, name_index, name,
-					value, value_len, flags);
-	if (err) {
-		/* can't store EA in inode body: try to store in block */
-		err = ext3_xattr_block_set(handle, inode, name_index, name,
-						value, value_len, flags);
-	}
-
-finish:
-	up_write(&EXT3_I(inode)->xattr_sem);
-	return err;
-}
-
-/*
  * ext3_xattr_block_set()
  *
  * this routine add/remove/replace attribute in EA block
  */
-int
+static int
 ext3_xattr_block_set(handle_t *handle, struct inode *inode, int name_index,
 		      const char *name, const void *value, size_t value_len,
 		      int flags)
@@ -1206,6 +1105,107 @@
 }
 
 /*
+ * ext3_xattr_set_handle()
+ *
+ * Create, replace or remove an extended attribute for this inode. Buffer
+ * is NULL to remove an existing extended attribute, and non-NULL to
+ * either replace an existing extended attribute, or create a new extended
+ * attribute. The flags XATTR_REPLACE and XATTR_CREATE
+ * specify that an extended attribute must exist and must not exist
+ * previous to the call, respectively.
+ *
+ * Returns 0, or a negative error number on failure.
+ */
+int
+ext3_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
+		const char *name, const void *value, size_t value_len,
+		int flags)
+{
+	int free1 = -1, free2 = -1;
+	int err, where = 0, total;
+	int name_len;
+
+	ea_idebug(inode, "name=%d.%s, value=%p, value_len=%ld",
+		  name_index, name, value, (long)value_len);
+
+	if (IS_RDONLY(inode))
+		return -EROFS;
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+		return -EPERM;
+	if (value == NULL)
+		value_len = 0;
+	if (name == NULL)
+		return -EINVAL;
+	name_len = strlen(name);
+	if (name_len > 255 || value_len > inode->i_sb->s_blocksize)
+		return -ERANGE;
+	down_write(&EXT3_I(inode)->xattr_sem);
+
+#define EX_FOUND_IN_IBODY	1
+#define EX_FOUND_IN_BLOCK	2
+
+	/* try to find attribute in inode body */
+	err = ext3_xattr_ibody_find(inode, name_index, name, &free1);
+	if (err == 0) {
+		/* found EA in inode */
+		where = EX_FOUND_IN_IBODY;
+	} else if (err == -ENOENT) {
+		/* there is no such attribute in inode body */
+		/* try to find attribute in dedicated block */
+		err = ext3_xattr_block_find(inode, name_index, name, &free2);
+		if (err != 0 && err != -ENOENT) {
+			/* not found EA in block */
+			goto finish;
+		} else if (err == 0) {
+			/* found EA in block */
+			where = EX_FOUND_IN_BLOCK;
+		}
+	} else
+		goto finish;
+
+	/* check flags: may replace? may create ? */
+	if (where && (flags & XATTR_CREATE)) {
+		err = -EEXIST;
+		goto finish;
+	} else if (!where && (flags & XATTR_REPLACE)) {
+		err = -ENODATA;
+		goto finish;
+	}
+
+	/* check if we have enough space to store attribute */
+	total = EXT3_XATTR_LEN(strlen(name)) + value_len;
+	if (total > free1 && free2 > 0 && total > free2) {
+		/* have no enough space */
+		err = -ENOSPC;
+		goto finish;
+	}
+
+	/* there are two cases when we want to remove EA from original storage:
+	 * a) EA is stored in the inode, but new value doesn't fit
+	 * b) EA is stored in the block, but new value fit in inode
+	 */
+	if (where == EX_FOUND_IN_IBODY && total > free1)
+		ext3_xattr_ibody_set(handle, inode, name_index, name,
+					NULL, 0, flags);
+	else if (where == EX_FOUND_IN_BLOCK && total <= free1)
+		ext3_xattr_block_set(handle, inode, name_index,
+					name, NULL, 0, flags);
+
+	/* try to store EA in inode body */
+	err = ext3_xattr_ibody_set(handle, inode, name_index, name,
+					value, value_len, flags);
+	if (err) {
+		/* can't store EA in inode body: try to store in block */
+		err = ext3_xattr_block_set(handle, inode, name_index, name,
+						value, value_len, flags);
+	}
+
+finish:
+	up_write(&EXT3_I(inode)->xattr_sem);
+	return err;
+}
+
+/*
  * Second half of ext3_xattr_set_handle(): Update the file system.
  */
 static int

