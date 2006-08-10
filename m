Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWHJBTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWHJBTy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWHJBTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:19:54 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:43143 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750750AbWHJBTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:19:51 -0400
Subject: [PATCH 5/5] Use JBD2 in ext4 filesystem
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 09 Aug 2006 18:19:37 -0700
Message-Id: <1155172777.3161.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changes in ext4 to use the renamed JBD2 functions. rename
include/linux/ext4_jbd.h to include/linux/ext4_jdb2.h

Signed-Off-By: Mingming Cao<cmm@us.ibm.com>


---

 /dev/null                                       |  268 ------------------------
 linux-2.6.18-rc4-ming/fs/ext4/acl.c             |    2 
 linux-2.6.18-rc4-ming/fs/ext4/balloc.c          |   10 
 linux-2.6.18-rc4-ming/fs/ext4/bitmap.c          |    2 
 linux-2.6.18-rc4-ming/fs/ext4/dir.c             |    2 
 linux-2.6.18-rc4-ming/fs/ext4/file.c            |    4 
 linux-2.6.18-rc4-ming/fs/ext4/fsync.c           |    4 
 linux-2.6.18-rc4-ming/fs/ext4/hash.c            |    2 
 linux-2.6.18-rc4-ming/fs/ext4/ialloc.c          |    6 
 linux-2.6.18-rc4-ming/fs/ext4/inode.c           |   52 ++--
 linux-2.6.18-rc4-ming/fs/ext4/ioctl.c           |   16 -
 linux-2.6.18-rc4-ming/fs/ext4/namei.c           |    4 
 linux-2.6.18-rc4-ming/fs/ext4/resize.c          |    2 
 linux-2.6.18-rc4-ming/fs/ext4/super.c           |   84 +++----
 linux-2.6.18-rc4-ming/fs/ext4/symlink.c         |    2 
 linux-2.6.18-rc4-ming/fs/ext4/xattr.c           |    2 
 linux-2.6.18-rc4-ming/fs/ext4/xattr_security.c  |    2 
 linux-2.6.18-rc4-ming/fs/ext4/xattr_trusted.c   |    2 
 linux-2.6.18-rc4-ming/fs/ext4/xattr_user.c      |    2 
 linux-2.6.18-rc4-ming/include/linux/ext4_jbd2.h |  268 ++++++++++++++++++++++++
 20 files changed, 368 insertions(+), 368 deletions(-)

diff -puN /dev/null include/linux/ext4_jbd2.h
--- /dev/null	2006-08-08 14:57:22.983223272 -0700
+++ linux-2.6.18-rc4-ming/include/linux/ext4_jbd2.h	2006-08-09 15:41:40.289194884 -0700
@@ -0,0 +1,268 @@
+/*
+ * linux/include/linux/ext4_jbd2.h
+ *
+ * Written by Stephen C. Tweedie <sct@redhat.com>, 1999
+ *
+ * Copyright 1998--1999 Red Hat corp --- All Rights Reserved
+ *
+ * This file is part of the Linux kernel and is made available under
+ * the terms of the GNU General Public License, version 2, or at your
+ * option, any later version, incorporated herein by reference.
+ *
+ * Ext3-specific journaling extensions.
+ */
+
+#ifndef _LINUX_EXT4_JBD_H
+#define _LINUX_EXT4_JBD_H
+
+#include <linux/fs.h>
+#include <linux/jbd2.h>
+#include <linux/ext4_fs.h>
+
+#define EXT4_JOURNAL(inode)	(EXT4_SB((inode)->i_sb)->s_journal)
+
+/* Define the number of blocks we need to account to a transaction to
+ * modify one block of data.
+ *
+ * We may have to touch one inode, one bitmap buffer, up to three
+ * indirection blocks, the group and superblock summaries, and the data
+ * block to complete the transaction.  */
+
+#define EXT4_SINGLEDATA_TRANS_BLOCKS	8U
+
+/* Extended attribute operations touch at most two data buffers,
+ * two bitmap buffers, and two group summaries, in addition to the inode
+ * and the superblock, which are already accounted for. */
+
+#define EXT4_XATTR_TRANS_BLOCKS		6U
+
+/* Define the minimum size for a transaction which modifies data.  This
+ * needs to take into account the fact that we may end up modifying two
+ * quota files too (one for the group, one for the user quota).  The
+ * superblock only gets updated once, of course, so don't bother
+ * counting that again for the quota updates. */
+
+#define EXT4_DATA_TRANS_BLOCKS(sb)	(EXT4_SINGLEDATA_TRANS_BLOCKS + \
+					 EXT4_XATTR_TRANS_BLOCKS - 2 + \
+					 2*EXT4_QUOTA_TRANS_BLOCKS(sb))
+
+/* Delete operations potentially hit one directory's namespace plus an
+ * entire inode, plus arbitrary amounts of bitmap/indirection data.  Be
+ * generous.  We can grow the delete transaction later if necessary. */
+
+#define EXT4_DELETE_TRANS_BLOCKS(sb)	(2 * EXT4_DATA_TRANS_BLOCKS(sb) + 64)
+
+/* Define an arbitrary limit for the amount of data we will anticipate
+ * writing to any given transaction.  For unbounded transactions such as
+ * write(2) and truncate(2) we can write more than this, but we always
+ * start off at the maximum transaction size and grow the transaction
+ * optimistically as we go. */
+
+#define EXT4_MAX_TRANS_DATA		64U
+
+/* We break up a large truncate or write transaction once the handle's
+ * buffer credits gets this low, we need either to extend the
+ * transaction or to start a new one.  Reserve enough space here for
+ * inode, bitmap, superblock, group and indirection updates for at least
+ * one block, plus two quota updates.  Quota allocations are not
+ * needed. */
+
+#define EXT4_RESERVE_TRANS_BLOCKS	12U
+
+#define EXT4_INDEX_EXTRA_TRANS_BLOCKS	8
+
+#ifdef CONFIG_QUOTA
+/* Amount of blocks needed for quota update - we know that the structure was
+ * allocated so we need to update only inode+data */
+#define EXT4_QUOTA_TRANS_BLOCKS(sb) (test_opt(sb, QUOTA) ? 2 : 0)
+/* Amount of blocks needed for quota insert/delete - we do some block writes
+ * but inode, sb and group updates are done only once */
+#define EXT4_QUOTA_INIT_BLOCKS(sb) (test_opt(sb, QUOTA) ? (DQUOT_INIT_ALLOC*\
+		(EXT4_SINGLEDATA_TRANS_BLOCKS-3)+3+DQUOT_INIT_REWRITE) : 0)
+#define EXT4_QUOTA_DEL_BLOCKS(sb) (test_opt(sb, QUOTA) ? (DQUOT_DEL_ALLOC*\
+		(EXT4_SINGLEDATA_TRANS_BLOCKS-3)+3+DQUOT_DEL_REWRITE) : 0)
+#else
+#define EXT4_QUOTA_TRANS_BLOCKS(sb) 0
+#define EXT4_QUOTA_INIT_BLOCKS(sb) 0
+#define EXT4_QUOTA_DEL_BLOCKS(sb) 0
+#endif
+
+int
+ext4_mark_iloc_dirty(handle_t *handle,
+		     struct inode *inode,
+		     struct ext4_iloc *iloc);
+
+/*
+ * On success, We end up with an outstanding reference count against
+ * iloc->bh.  This _must_ be cleaned up later.
+ */
+
+int ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
+			struct ext4_iloc *iloc);
+
+int ext4_mark_inode_dirty(handle_t *handle, struct inode *inode);
+
+/*
+ * Wrapper functions with which ext4 calls into JBD.  The intent here is
+ * to allow these to be turned into appropriate stubs so ext4 can control
+ * ext2 filesystems, so ext2+ext4 systems only nee one fs.  This work hasn't
+ * been done yet.
+ */
+
+void ext4_journal_abort_handle(const char *caller, const char *err_fn,
+		struct buffer_head *bh, handle_t *handle, int err);
+
+static inline int
+__ext4_journal_get_undo_access(const char *where, handle_t *handle,
+				struct buffer_head *bh)
+{
+	int err = jbd2_journal_get_undo_access(handle, bh);
+	if (err)
+		ext4_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
+	return err;
+}
+
+static inline int
+__ext4_journal_get_write_access(const char *where, handle_t *handle,
+				struct buffer_head *bh)
+{
+	int err = jbd2_journal_get_write_access(handle, bh);
+	if (err)
+		ext4_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
+	return err;
+}
+
+static inline void
+ext4_journal_release_buffer(handle_t *handle, struct buffer_head *bh)
+{
+	jbd2_journal_release_buffer(handle, bh);
+}
+
+static inline int
+__ext4_journal_forget(const char *where, handle_t *handle, struct buffer_head *bh)
+{
+	int err = jbd2_journal_forget(handle, bh);
+	if (err)
+		ext4_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
+	return err;
+}
+
+static inline int
+__ext4_journal_revoke(const char *where, handle_t *handle,
+		      unsigned long blocknr, struct buffer_head *bh)
+{
+	int err = jbd2_journal_revoke(handle, blocknr, bh);
+	if (err)
+		ext4_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
+	return err;
+}
+
+static inline int
+__ext4_journal_get_create_access(const char *where,
+				 handle_t *handle, struct buffer_head *bh)
+{
+	int err = jbd2_journal_get_create_access(handle, bh);
+	if (err)
+		ext4_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
+	return err;
+}
+
+static inline int
+__ext4_journal_dirty_metadata(const char *where,
+			      handle_t *handle, struct buffer_head *bh)
+{
+	int err = jbd2_journal_dirty_metadata(handle, bh);
+	if (err)
+		ext4_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
+	return err;
+}
+
+
+#define ext4_journal_get_undo_access(handle, bh) \
+	__ext4_journal_get_undo_access(__FUNCTION__, (handle), (bh))
+#define ext4_journal_get_write_access(handle, bh) \
+	__ext4_journal_get_write_access(__FUNCTION__, (handle), (bh))
+#define ext4_journal_revoke(handle, blocknr, bh) \
+	__ext4_journal_revoke(__FUNCTION__, (handle), (blocknr), (bh))
+#define ext4_journal_get_create_access(handle, bh) \
+	__ext4_journal_get_create_access(__FUNCTION__, (handle), (bh))
+#define ext4_journal_dirty_metadata(handle, bh) \
+	__ext4_journal_dirty_metadata(__FUNCTION__, (handle), (bh))
+#define ext4_journal_forget(handle, bh) \
+	__ext4_journal_forget(__FUNCTION__, (handle), (bh))
+
+int ext4_journal_dirty_data(handle_t *handle, struct buffer_head *bh);
+
+handle_t *ext4_journal_start_sb(struct super_block *sb, int nblocks);
+int __ext4_journal_stop(const char *where, handle_t *handle);
+
+static inline handle_t *ext4_journal_start(struct inode *inode, int nblocks)
+{
+	return ext4_journal_start_sb(inode->i_sb, nblocks);
+}
+
+#define ext4_journal_stop(handle) \
+	__ext4_journal_stop(__FUNCTION__, (handle))
+
+static inline handle_t *ext4_journal_current_handle(void)
+{
+	return journal_current_handle();
+}
+
+static inline int ext4_journal_extend(handle_t *handle, int nblocks)
+{
+	return jbd2_journal_extend(handle, nblocks);
+}
+
+static inline int ext4_journal_restart(handle_t *handle, int nblocks)
+{
+	return jbd2_journal_restart(handle, nblocks);
+}
+
+static inline int ext4_journal_blocks_per_page(struct inode *inode)
+{
+	return jbd2_journal_blocks_per_page(inode);
+}
+
+static inline int ext4_journal_force_commit(journal_t *journal)
+{
+	return jbd2_journal_force_commit(journal);
+}
+
+/* super.c */
+int ext4_force_commit(struct super_block *sb);
+
+static inline int ext4_should_journal_data(struct inode *inode)
+{
+	if (!S_ISREG(inode->i_mode))
+		return 1;
+	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
+		return 1;
+	if (EXT4_I(inode)->i_flags & EXT4_JOURNAL_DATA_FL)
+		return 1;
+	return 0;
+}
+
+static inline int ext4_should_order_data(struct inode *inode)
+{
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+	if (EXT4_I(inode)->i_flags & EXT4_JOURNAL_DATA_FL)
+		return 0;
+	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
+		return 1;
+	return 0;
+}
+
+static inline int ext4_should_writeback_data(struct inode *inode)
+{
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+	if (EXT4_I(inode)->i_flags & EXT4_JOURNAL_DATA_FL)
+		return 0;
+	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_WRITEBACK_DATA)
+		return 1;
+	return 0;
+}
+
+#endif	/* _LINUX_EXT4_JBD_H */
diff -puN -L include/linux/ext4_jbd.h include/linux/ext4_jbd.h~rename-jbd2-in-ext4 /dev/null
--- linux-2.6.18-rc4/include/linux/ext4_jbd.h
+++ /dev/null	2006-08-08 14:57:22.983223272 -0700
@@ -1,268 +0,0 @@
-/*
- * linux/include/linux/ext4_jbd.h
- *
- * Written by Stephen C. Tweedie <sct@redhat.com>, 1999
- *
- * Copyright 1998--1999 Red Hat corp --- All Rights Reserved
- *
- * This file is part of the Linux kernel and is made available under
- * the terms of the GNU General Public License, version 2, or at your
- * option, any later version, incorporated herein by reference.
- *
- * Ext3-specific journaling extensions.
- */
-
-#ifndef _LINUX_EXT4_JBD_H
-#define _LINUX_EXT4_JBD_H
-
-#include <linux/fs.h>
-#include <linux/jbd.h>
-#include <linux/ext4_fs.h>
-
-#define EXT4_JOURNAL(inode)	(EXT4_SB((inode)->i_sb)->s_journal)
-
-/* Define the number of blocks we need to account to a transaction to
- * modify one block of data.
- *
- * We may have to touch one inode, one bitmap buffer, up to three
- * indirection blocks, the group and superblock summaries, and the data
- * block to complete the transaction.  */
-
-#define EXT4_SINGLEDATA_TRANS_BLOCKS	8U
-
-/* Extended attribute operations touch at most two data buffers,
- * two bitmap buffers, and two group summaries, in addition to the inode
- * and the superblock, which are already accounted for. */
-
-#define EXT4_XATTR_TRANS_BLOCKS		6U
-
-/* Define the minimum size for a transaction which modifies data.  This
- * needs to take into account the fact that we may end up modifying two
- * quota files too (one for the group, one for the user quota).  The
- * superblock only gets updated once, of course, so don't bother
- * counting that again for the quota updates. */
-
-#define EXT4_DATA_TRANS_BLOCKS(sb)	(EXT4_SINGLEDATA_TRANS_BLOCKS + \
-					 EXT4_XATTR_TRANS_BLOCKS - 2 + \
-					 2*EXT4_QUOTA_TRANS_BLOCKS(sb))
-
-/* Delete operations potentially hit one directory's namespace plus an
- * entire inode, plus arbitrary amounts of bitmap/indirection data.  Be
- * generous.  We can grow the delete transaction later if necessary. */
-
-#define EXT4_DELETE_TRANS_BLOCKS(sb)	(2 * EXT4_DATA_TRANS_BLOCKS(sb) + 64)
-
-/* Define an arbitrary limit for the amount of data we will anticipate
- * writing to any given transaction.  For unbounded transactions such as
- * write(2) and truncate(2) we can write more than this, but we always
- * start off at the maximum transaction size and grow the transaction
- * optimistically as we go. */
-
-#define EXT4_MAX_TRANS_DATA		64U
-
-/* We break up a large truncate or write transaction once the handle's
- * buffer credits gets this low, we need either to extend the
- * transaction or to start a new one.  Reserve enough space here for
- * inode, bitmap, superblock, group and indirection updates for at least
- * one block, plus two quota updates.  Quota allocations are not
- * needed. */
-
-#define EXT4_RESERVE_TRANS_BLOCKS	12U
-
-#define EXT4_INDEX_EXTRA_TRANS_BLOCKS	8
-
-#ifdef CONFIG_QUOTA
-/* Amount of blocks needed for quota update - we know that the structure was
- * allocated so we need to update only inode+data */
-#define EXT4_QUOTA_TRANS_BLOCKS(sb) (test_opt(sb, QUOTA) ? 2 : 0)
-/* Amount of blocks needed for quota insert/delete - we do some block writes
- * but inode, sb and group updates are done only once */
-#define EXT4_QUOTA_INIT_BLOCKS(sb) (test_opt(sb, QUOTA) ? (DQUOT_INIT_ALLOC*\
-		(EXT4_SINGLEDATA_TRANS_BLOCKS-3)+3+DQUOT_INIT_REWRITE) : 0)
-#define EXT4_QUOTA_DEL_BLOCKS(sb) (test_opt(sb, QUOTA) ? (DQUOT_DEL_ALLOC*\
-		(EXT4_SINGLEDATA_TRANS_BLOCKS-3)+3+DQUOT_DEL_REWRITE) : 0)
-#else
-#define EXT4_QUOTA_TRANS_BLOCKS(sb) 0
-#define EXT4_QUOTA_INIT_BLOCKS(sb) 0
-#define EXT4_QUOTA_DEL_BLOCKS(sb) 0
-#endif
-
-int
-ext4_mark_iloc_dirty(handle_t *handle,
-		     struct inode *inode,
-		     struct ext4_iloc *iloc);
-
-/*
- * On success, We end up with an outstanding reference count against
- * iloc->bh.  This _must_ be cleaned up later.
- */
-
-int ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
-			struct ext4_iloc *iloc);
-
-int ext4_mark_inode_dirty(handle_t *handle, struct inode *inode);
-
-/*
- * Wrapper functions with which ext4 calls into JBD.  The intent here is
- * to allow these to be turned into appropriate stubs so ext4 can control
- * ext2 filesystems, so ext2+ext4 systems only nee one fs.  This work hasn't
- * been done yet.
- */
-
-void ext4_journal_abort_handle(const char *caller, const char *err_fn,
-		struct buffer_head *bh, handle_t *handle, int err);
-
-static inline int
-__ext4_journal_get_undo_access(const char *where, handle_t *handle,
-				struct buffer_head *bh)
-{
-	int err = journal_get_undo_access(handle, bh);
-	if (err)
-		ext4_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
-	return err;
-}
-
-static inline int
-__ext4_journal_get_write_access(const char *where, handle_t *handle,
-				struct buffer_head *bh)
-{
-	int err = journal_get_write_access(handle, bh);
-	if (err)
-		ext4_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
-	return err;
-}
-
-static inline void
-ext4_journal_release_buffer(handle_t *handle, struct buffer_head *bh)
-{
-	journal_release_buffer(handle, bh);
-}
-
-static inline int
-__ext4_journal_forget(const char *where, handle_t *handle, struct buffer_head *bh)
-{
-	int err = journal_forget(handle, bh);
-	if (err)
-		ext4_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
-	return err;
-}
-
-static inline int
-__ext4_journal_revoke(const char *where, handle_t *handle,
-		      unsigned long blocknr, struct buffer_head *bh)
-{
-	int err = journal_revoke(handle, blocknr, bh);
-	if (err)
-		ext4_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
-	return err;
-}
-
-static inline int
-__ext4_journal_get_create_access(const char *where,
-				 handle_t *handle, struct buffer_head *bh)
-{
-	int err = journal_get_create_access(handle, bh);
-	if (err)
-		ext4_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
-	return err;
-}
-
-static inline int
-__ext4_journal_dirty_metadata(const char *where,
-			      handle_t *handle, struct buffer_head *bh)
-{
-	int err = journal_dirty_metadata(handle, bh);
-	if (err)
-		ext4_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
-	return err;
-}
-
-
-#define ext4_journal_get_undo_access(handle, bh) \
-	__ext4_journal_get_undo_access(__FUNCTION__, (handle), (bh))
-#define ext4_journal_get_write_access(handle, bh) \
-	__ext4_journal_get_write_access(__FUNCTION__, (handle), (bh))
-#define ext4_journal_revoke(handle, blocknr, bh) \
-	__ext4_journal_revoke(__FUNCTION__, (handle), (blocknr), (bh))
-#define ext4_journal_get_create_access(handle, bh) \
-	__ext4_journal_get_create_access(__FUNCTION__, (handle), (bh))
-#define ext4_journal_dirty_metadata(handle, bh) \
-	__ext4_journal_dirty_metadata(__FUNCTION__, (handle), (bh))
-#define ext4_journal_forget(handle, bh) \
-	__ext4_journal_forget(__FUNCTION__, (handle), (bh))
-
-int ext4_journal_dirty_data(handle_t *handle, struct buffer_head *bh);
-
-handle_t *ext4_journal_start_sb(struct super_block *sb, int nblocks);
-int __ext4_journal_stop(const char *where, handle_t *handle);
-
-static inline handle_t *ext4_journal_start(struct inode *inode, int nblocks)
-{
-	return ext4_journal_start_sb(inode->i_sb, nblocks);
-}
-
-#define ext4_journal_stop(handle) \
-	__ext4_journal_stop(__FUNCTION__, (handle))
-
-static inline handle_t *ext4_journal_current_handle(void)
-{
-	return journal_current_handle();
-}
-
-static inline int ext4_journal_extend(handle_t *handle, int nblocks)
-{
-	return journal_extend(handle, nblocks);
-}
-
-static inline int ext4_journal_restart(handle_t *handle, int nblocks)
-{
-	return journal_restart(handle, nblocks);
-}
-
-static inline int ext4_journal_blocks_per_page(struct inode *inode)
-{
-	return journal_blocks_per_page(inode);
-}
-
-static inline int ext4_journal_force_commit(journal_t *journal)
-{
-	return journal_force_commit(journal);
-}
-
-/* super.c */
-int ext4_force_commit(struct super_block *sb);
-
-static inline int ext4_should_journal_data(struct inode *inode)
-{
-	if (!S_ISREG(inode->i_mode))
-		return 1;
-	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
-		return 1;
-	if (EXT4_I(inode)->i_flags & EXT4_JOURNAL_DATA_FL)
-		return 1;
-	return 0;
-}
-
-static inline int ext4_should_order_data(struct inode *inode)
-{
-	if (!S_ISREG(inode->i_mode))
-		return 0;
-	if (EXT4_I(inode)->i_flags & EXT4_JOURNAL_DATA_FL)
-		return 0;
-	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
-		return 1;
-	return 0;
-}
-
-static inline int ext4_should_writeback_data(struct inode *inode)
-{
-	if (!S_ISREG(inode->i_mode))
-		return 0;
-	if (EXT4_I(inode)->i_flags & EXT4_JOURNAL_DATA_FL)
-		return 0;
-	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_WRITEBACK_DATA)
-		return 1;
-	return 0;
-}
-
-#endif	/* _LINUX_EXT4_JBD_H */
diff -puN fs/ext4/acl.c~rename-jbd2-in-ext4 fs/ext4/acl.c
--- linux-2.6.18-rc4/fs/ext4/acl.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.226194374 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/acl.c	2006-08-09 15:41:40.292194908 -0700
@@ -9,7 +9,7 @@
 #include <linux/slab.h>
 #include <linux/capability.h>
 #include <linux/fs.h>
-#include <linux/ext4_jbd.h>
+#include <linux/ext4_jbd2.h>
 #include <linux/ext4_fs.h>
 #include "xattr.h"
 #include "acl.h"
diff -puN fs/ext4/balloc.c~rename-jbd2-in-ext4 fs/ext4/balloc.c
--- linux-2.6.18-rc4/fs/ext4/balloc.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.229194398 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/balloc.c	2006-08-09 15:41:40.295194932 -0700
@@ -14,9 +14,9 @@
 #include <linux/time.h>
 #include <linux/capability.h>
 #include <linux/fs.h>
-#include <linux/jbd.h>
+#include <linux/jbd2.h>
 #include <linux/ext4_fs.h>
-#include <linux/ext4_jbd.h>
+#include <linux/ext4_jbd2.h>
 #include <linux/quotaops.h>
 #include <linux/buffer_head.h>
 
@@ -422,12 +422,12 @@ do_more:
 		 * transaction.
 		 *
 		 * Ideally we would want to allow that to happen, but to
-		 * do so requires making journal_forget() capable of
+		 * do so requires making jbd2_journal_forget() capable of
 		 * revoking the queued write of a data block, which
 		 * implies blocking on the journal lock.  *forget()
 		 * cannot block due to truncate races.
 		 *
-		 * Eventually we can fix this by making journal_forget()
+		 * Eventually we can fix this by making jbd2_journal_forget()
 		 * return a status indicating whether or not it was able
 		 * to revoke the buffer.  On successful revoke, it is
 		 * safe not to set the allocation bit in the committed
@@ -1188,7 +1188,7 @@ int ext4_should_retry_alloc(struct super
 
 	jbd_debug(1, "%s: retrying operation after ENOSPC\n", sb->s_id);
 
-	return journal_force_commit_nested(EXT4_SB(sb)->s_journal);
+	return jbd2_journal_force_commit_nested(EXT4_SB(sb)->s_journal);
 }
 
 /*
diff -puN fs/ext4/bitmap.c~rename-jbd2-in-ext4 fs/ext4/bitmap.c
--- linux-2.6.18-rc4/fs/ext4/bitmap.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.232194422 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/bitmap.c	2006-08-09 15:41:40.295194932 -0700
@@ -8,7 +8,7 @@
  */
 
 #include <linux/buffer_head.h>
-#include <linux/jbd.h>
+#include <linux/jbd2.h>
 #include <linux/ext4_fs.h>
 
 #ifdef EXT4FS_DEBUG
diff -puN fs/ext4/dir.c~rename-jbd2-in-ext4 fs/ext4/dir.c
--- linux-2.6.18-rc4/fs/ext4/dir.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.235194447 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/dir.c	2006-08-09 15:41:40.296194941 -0700
@@ -22,7 +22,7 @@
  */
 
 #include <linux/fs.h>
-#include <linux/jbd.h>
+#include <linux/jbd2.h>
 #include <linux/ext4_fs.h>
 #include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
diff -puN fs/ext4/file.c~rename-jbd2-in-ext4 fs/ext4/file.c
--- linux-2.6.18-rc4/fs/ext4/file.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.238194471 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/file.c	2006-08-09 15:41:40.297194949 -0700
@@ -20,9 +20,9 @@
 
 #include <linux/time.h>
 #include <linux/fs.h>
-#include <linux/jbd.h>
+#include <linux/jbd2.h>
 #include <linux/ext4_fs.h>
-#include <linux/ext4_jbd.h>
+#include <linux/ext4_jbd2.h>
 #include "xattr.h"
 #include "acl.h"
 
diff -puN fs/ext4/fsync.c~rename-jbd2-in-ext4 fs/ext4/fsync.c
--- linux-2.6.18-rc4/fs/ext4/fsync.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.241194495 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/fsync.c	2006-08-09 15:41:40.297194949 -0700
@@ -26,9 +26,9 @@
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/writeback.h>
-#include <linux/jbd.h>
+#include <linux/jbd2.h>
 #include <linux/ext4_fs.h>
-#include <linux/ext4_jbd.h>
+#include <linux/ext4_jbd2.h>
 
 /*
  * akpm: A new design for ext4_sync_file().
diff -puN fs/ext4/hash.c~rename-jbd2-in-ext4 fs/ext4/hash.c
--- linux-2.6.18-rc4/fs/ext4/hash.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.244194520 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/hash.c	2006-08-09 15:41:40.298194957 -0700
@@ -10,7 +10,7 @@
  */
 
 #include <linux/fs.h>
-#include <linux/jbd.h>
+#include <linux/jbd2.h>
 #include <linux/sched.h>
 #include <linux/ext4_fs.h>
 #include <linux/cryptohash.h>
diff -puN fs/ext4/ialloc.c~rename-jbd2-in-ext4 fs/ext4/ialloc.c
--- linux-2.6.18-rc4/fs/ext4/ialloc.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.249194560 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/ialloc.c	2006-08-09 15:41:40.299194965 -0700
@@ -14,9 +14,9 @@
 
 #include <linux/time.h>
 #include <linux/fs.h>
-#include <linux/jbd.h>
+#include <linux/jbd2.h>
 #include <linux/ext4_fs.h>
-#include <linux/ext4_jbd.h>
+#include <linux/ext4_jbd2.h>
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/quotaops.h>
@@ -497,7 +497,7 @@ repeat_in_this_group:
 				goto got;
 			}
 			/* we lost it */
-			journal_release_buffer(handle, bitmap_bh);
+			jbd2_journal_release_buffer(handle, bitmap_bh);
 
 			if (++ino < EXT4_INODES_PER_GROUP(sb))
 				goto repeat_in_this_group;
diff -puN fs/ext4/inode.c~rename-jbd2-in-ext4 fs/ext4/inode.c
--- linux-2.6.18-rc4/fs/ext4/inode.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.253194592 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/inode.c	2006-08-09 15:41:40.306195022 -0700
@@ -25,8 +25,8 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/time.h>
-#include <linux/ext4_jbd.h>
-#include <linux/jbd.h>
+#include <linux/ext4_jbd2.h>
+#include <linux/jbd2.h>
 #include <linux/smp_lock.h>
 #include <linux/highuid.h>
 #include <linux/pagemap.h>
@@ -83,7 +83,7 @@ int ext4_forget(handle_t *handle, int is
 	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
 	    (!is_metadata && !ext4_should_journal_data(inode))) {
 		if (bh) {
-			BUFFER_TRACE(bh, "call journal_forget");
+			BUFFER_TRACE(bh, "call jbd2_journal_forget");
 			return ext4_journal_forget(handle, bh);
 		}
 		return 0;
@@ -656,7 +656,7 @@ static int ext4_alloc_branch(handle_t *h
 failed:
 	/* Allocation failed, free what we already allocated */
 	for (i = 1; i <= n ; i++) {
-		BUFFER_TRACE(branch[i].bh, "call journal_forget");
+		BUFFER_TRACE(branch[i].bh, "call jbd2_journal_forget");
 		ext4_journal_forget(handle, branch[i].bh);
 	}
 	for (i = 0; i <indirect_blks; i++)
@@ -757,7 +757,7 @@ static int ext4_splice_branch(handle_t *
 
 err_out:
 	for (i = 1; i <= num; i++) {
-		BUFFER_TRACE(where[i].bh, "call journal_forget");
+		BUFFER_TRACE(where[i].bh, "call jbd2_journal_forget");
 		ext4_journal_forget(handle, where[i].bh);
 		ext4_free_blocks(handle,inode,le32_to_cpu(where[i-1].key),1);
 	}
@@ -1115,7 +1115,7 @@ static int walk_page_buffers(	handle_t *
  * To preserve ordering, it is essential that the hole instantiation and
  * the data write be encapsulated in a single transaction.  We cannot
  * close off a transaction and start a new one between the ext4_get_block()
- * and the commit_write().  So doing the journal_start at the start of
+ * and the commit_write().  So doing the jbd2_journal_start at the start of
  * prepare_write() is the right place.
  *
  * Also, this function can nest inside ext4_writepage() ->
@@ -1131,7 +1131,7 @@ static int walk_page_buffers(	handle_t *
  * transaction open and was blocking on the quota lock - a ranking
  * violation.
  *
- * So what we do is to rely on the fact that journal_stop/journal_start
+ * So what we do is to rely on the fact that jbd2_journal_stop/journal_start
  * will _not_ run commit under these circumstances because handle->h_ref
  * is elevated.  We'll still have enough credits for the tiny quotafile
  * write.
@@ -1180,7 +1180,7 @@ out:
 
 int ext4_journal_dirty_data(handle_t *handle, struct buffer_head *bh)
 {
-	int err = journal_dirty_data(handle, bh);
+	int err = jbd2_journal_dirty_data(handle, bh);
 	if (err)
 		ext4_journal_abort_handle(__FUNCTION__, __FUNCTION__,
 						bh, handle,err);
@@ -1329,9 +1329,9 @@ static sector_t ext4_bmap(struct address
 
 		EXT4_I(inode)->i_state &= ~EXT4_STATE_JDATA;
 		journal = EXT4_JOURNAL(inode);
-		journal_lock_updates(journal);
-		err = journal_flush(journal);
-		journal_unlock_updates(journal);
+		jbd2_journal_lock_updates(journal);
+		err = jbd2_journal_flush(journal);
+		jbd2_journal_unlock_updates(journal);
 
 		if (err)
 			return 0;
@@ -1352,7 +1352,7 @@ static int bput_one(handle_t *handle, st
 	return 0;
 }
 
-static int journal_dirty_data_fn(handle_t *handle, struct buffer_head *bh)
+static int jbd2_journal_dirty_data_fn(handle_t *handle, struct buffer_head *bh)
 {
 	if (buffer_mapped(bh))
 		return ext4_journal_dirty_data(handle, bh);
@@ -1460,7 +1460,7 @@ static int ext4_ordered_writepage(struct
 	 */
 	if (ret == 0) {
 		err = walk_page_buffers(handle, page_bufs, 0, PAGE_CACHE_SIZE,
-					NULL, journal_dirty_data_fn);
+					NULL, jbd2_journal_dirty_data_fn);
 		if (!ret)
 			ret = err;
 	}
@@ -1591,7 +1591,7 @@ static void ext4_invalidatepage(struct p
 	if (offset == 0)
 		ClearPageChecked(page);
 
-	journal_invalidatepage(journal, page, offset);
+	jbd2_journal_invalidatepage(journal, page, offset);
 }
 
 static int ext4_releasepage(struct page *page, gfp_t wait)
@@ -1601,7 +1601,7 @@ static int ext4_releasepage(struct page 
 	WARN_ON(PageChecked(page));
 	if (!page_has_buffers(page))
 		return 0;
-	return journal_try_to_free_buffers(journal, page, wait);
+	return jbd2_journal_try_to_free_buffers(journal, page, wait);
 }
 
 /*
@@ -1978,11 +1978,11 @@ static void ext4_clear_blocks(handle_t *
 
 	/*
 	 * Any buffers which are on the journal will be in memory. We find
-	 * them on the hash table so journal_revoke() will run journal_forget()
+	 * them on the hash table so jbd2_journal_revoke() will run jbd2_journal_forget()
 	 * on them.  We've already detached each block from the file, so
-	 * bforget() in journal_forget() should be safe.
+	 * bforget() in jbd2_journal_forget() should be safe.
 	 *
-	 * AKPM: turn on bforget in journal_forget()!!!
+	 * AKPM: turn on bforget in jbd2_journal_forget()!!!
 	 */
 	for (p = first; p < last; p++) {
 		u32 nr = le32_to_cpu(*p);
@@ -2128,11 +2128,11 @@ static void ext4_free_branches(handle_t 
 			 * We've probably journalled the indirect block several
 			 * times during the truncate.  But it's no longer
 			 * needed and we now drop it from the transaction via
-			 * journal_revoke().
+			 * jbd2_journal_revoke().
 			 *
 			 * That's easy if it's exclusively part of this
 			 * transaction.  But if it's part of the committing
-			 * transaction then journal_forget() will simply
+			 * transaction then jbd2_journal_forget() will simply
 			 * brelse() it.  That means that if the underlying
 			 * block is reallocated in ext4_get_block(),
 			 * unmap_underlying_metadata() will find this block
@@ -2247,7 +2247,7 @@ void ext4_truncate(struct inode *inode)
 
 	/*
 	 * We have to lock the EOF page here, because lock_page() nests
-	 * outside journal_start().
+	 * outside jbd2_journal_start().
 	 */
 	if ((inode->i_size & (blocksize - 1)) == 0) {
 		/* Block boundary? Nothing to do */
@@ -3033,7 +3033,7 @@ int ext4_mark_iloc_dirty(handle_t *handl
 	/* the do_update_inode consumes one bh->b_count */
 	get_bh(iloc->bh);
 
-	/* ext4_do_update_inode() does journal_dirty_metadata */
+	/* ext4_do_update_inode() does jbd2_journal_dirty_metadata */
 	err = ext4_do_update_inode(handle, inode, iloc);
 	put_bh(iloc->bh);
 	return err;
@@ -3151,7 +3151,7 @@ static int ext4_pin_inode(handle_t *hand
 		err = ext4_get_inode_loc(inode, &iloc);
 		if (!err) {
 			BUFFER_TRACE(iloc.bh, "get_write_access");
-			err = journal_get_write_access(handle, iloc.bh);
+			err = jbd2_journal_get_write_access(handle, iloc.bh);
 			if (!err)
 				err = ext4_journal_dirty_metadata(handle,
 								  iloc.bh);
@@ -3183,8 +3183,8 @@ int ext4_change_inode_journal_flag(struc
 	if (is_journal_aborted(journal) || IS_RDONLY(inode))
 		return -EROFS;
 
-	journal_lock_updates(journal);
-	journal_flush(journal);
+	jbd2_journal_lock_updates(journal);
+	jbd2_journal_flush(journal);
 
 	/*
 	 * OK, there are no updates running now, and all cached data is
@@ -3200,7 +3200,7 @@ int ext4_change_inode_journal_flag(struc
 		EXT4_I(inode)->i_flags &= ~EXT4_JOURNAL_DATA_FL;
 	ext4_set_aops(inode);
 
-	journal_unlock_updates(journal);
+	jbd2_journal_unlock_updates(journal);
 
 	/* Finally we can mark the inode as dirty. */
 
diff -puN fs/ext4/ioctl.c~rename-jbd2-in-ext4 fs/ext4/ioctl.c
--- linux-2.6.18-rc4/fs/ext4/ioctl.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.257194625 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/ioctl.c	2006-08-09 15:41:40.307195030 -0700
@@ -8,10 +8,10 @@
  */
 
 #include <linux/fs.h>
-#include <linux/jbd.h>
+#include <linux/jbd2.h>
 #include <linux/capability.h>
 #include <linux/ext4_fs.h>
-#include <linux/ext4_jbd.h>
+#include <linux/ext4_jbd2.h>
 #include <linux/time.h>
 #include <asm/uaccess.h>
 
@@ -218,9 +218,9 @@ flags_err:
 			return -EFAULT;
 
 		err = ext4_group_extend(sb, EXT4_SB(sb)->s_es, n_blocks_count);
-		journal_lock_updates(EXT4_SB(sb)->s_journal);
-		journal_flush(EXT4_SB(sb)->s_journal);
-		journal_unlock_updates(EXT4_SB(sb)->s_journal);
+		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
+		jbd2_journal_flush(EXT4_SB(sb)->s_journal);
+		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
 
 		return err;
 	}
@@ -240,9 +240,9 @@ flags_err:
 			return -EFAULT;
 
 		err = ext4_group_add(sb, &input);
-		journal_lock_updates(EXT4_SB(sb)->s_journal);
-		journal_flush(EXT4_SB(sb)->s_journal);
-		journal_unlock_updates(EXT4_SB(sb)->s_journal);
+		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
+		jbd2_journal_flush(EXT4_SB(sb)->s_journal);
+		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
 
 		return err;
 	}
diff -puN fs/ext4/namei.c~rename-jbd2-in-ext4 fs/ext4/namei.c
--- linux-2.6.18-rc4/fs/ext4/namei.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.260194649 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/namei.c	2006-08-09 15:41:40.310195054 -0700
@@ -26,10 +26,10 @@
 
 #include <linux/fs.h>
 #include <linux/pagemap.h>
-#include <linux/jbd.h>
+#include <linux/jbd2.h>
 #include <linux/time.h>
 #include <linux/ext4_fs.h>
-#include <linux/ext4_jbd.h>
+#include <linux/ext4_jbd2.h>
 #include <linux/fcntl.h>
 #include <linux/stat.h>
 #include <linux/string.h>
diff -puN fs/ext4/resize.c~rename-jbd2-in-ext4 fs/ext4/resize.c
--- linux-2.6.18-rc4/fs/ext4/resize.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.266194698 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/resize.c	2006-08-09 15:41:40.312195070 -0700
@@ -13,7 +13,7 @@
 
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
-#include <linux/ext4_jbd.h>
+#include <linux/ext4_jbd2.h>
 
 #include <linux/errno.h>
 #include <linux/slab.h>
diff -puN fs/ext4/super.c~rename-jbd2-in-ext4 fs/ext4/super.c
--- linux-2.6.18-rc4/fs/ext4/super.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.269194722 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/super.c	2006-08-09 15:41:40.317195111 -0700
@@ -20,9 +20,9 @@
 #include <linux/string.h>
 #include <linux/fs.h>
 #include <linux/time.h>
-#include <linux/jbd.h>
+#include <linux/jbd2.h>
 #include <linux/ext4_fs.h>
-#include <linux/ext4_jbd.h>
+#include <linux/ext4_jbd2.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
@@ -63,7 +63,7 @@ static void ext4_write_super (struct sup
 static void ext4_write_super_lockfs(struct super_block *sb);
 
 /*
- * Wrappers for journal_start/end.
+ * Wrappers for jbd2_journal_start/end.
  *
  * The only special thing we need to do here is to make sure that all
  * journal_end calls result in the superblock being marked dirty, so
@@ -87,12 +87,12 @@ handle_t *ext4_journal_start_sb(struct s
 		return ERR_PTR(-EROFS);
 	}
 
-	return journal_start(journal, nblocks);
+	return jbd2_journal_start(journal, nblocks);
 }
 
 /*
  * The only special thing we need to do here is to make sure that all
- * journal_stop calls result in the superblock being marked dirty, so
+ * jbd2_journal_stop calls result in the superblock being marked dirty, so
  * that sync() will call the filesystem's write_super callback if
  * appropriate.
  */
@@ -104,7 +104,7 @@ int __ext4_journal_stop(const char *wher
 
 	sb = handle->h_transaction->t_journal->j_private;
 	err = handle->h_err;
-	rc = journal_stop(handle);
+	rc = jbd2_journal_stop(handle);
 
 	if (!err)
 		err = rc;
@@ -131,7 +131,7 @@ void ext4_journal_abort_handle(const cha
 	printk(KERN_ERR "%s: aborting transaction: %s in %s\n",
 	       caller, errstr, err_fn);
 
-	journal_abort_handle(handle);
+	jbd2_journal_abort_handle(handle);
 }
 
 /* Deal with the reporting of failure conditions on a filesystem such as
@@ -144,7 +144,7 @@ void ext4_journal_abort_handle(const cha
  * be aborted, we can't rely on the current, or future, transactions to
  * write out the superblock safely.
  *
- * We'll just use the journal_abort() error code to record an error in
+ * We'll just use the jbd2_journal_abort() error code to record an error in
  * the journal instead.  On recovery, the journal will compain about
  * that error until we've noted it down and cleared it.
  */
@@ -167,7 +167,7 @@ static void ext4_handle_error(struct sup
 
 		EXT4_SB(sb)->s_mount_opt |= EXT4_MOUNT_ABORT;
 		if (journal)
-			journal_abort(journal, -EIO);
+			jbd2_journal_abort(journal, -EIO);
 	}
 	if (test_opt(sb, ERRORS_PANIC))
 		panic("EXT4-fs (device %s): panic forced after error\n",
@@ -202,7 +202,7 @@ static const char *ext4_decode_error(str
 		errstr = "Out of memory";
 		break;
 	case -EROFS:
-		if (!sb || EXT4_SB(sb)->s_journal->j_flags & JFS_ABORT)
+		if (!sb || EXT4_SB(sb)->s_journal->j_flags & JBD2_ABORT)
 			errstr = "Journal has aborted";
 		else
 			errstr = "Readonly filesystem";
@@ -278,7 +278,7 @@ void ext4_abort (struct super_block * sb
 	EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
 	sb->s_flags |= MS_RDONLY;
 	EXT4_SB(sb)->s_mount_opt |= EXT4_MOUNT_ABORT;
-	journal_abort(EXT4_SB(sb)->s_journal, -EIO);
+	jbd2_journal_abort(EXT4_SB(sb)->s_journal, -EIO);
 }
 
 void ext4_warning (struct super_block * sb, const char * function,
@@ -390,7 +390,7 @@ static void ext4_put_super (struct super
 	int i;
 
 	ext4_xattr_put_super(sb);
-	journal_destroy(sbi->s_journal);
+	jbd2_journal_destroy(sbi->s_journal);
 	if (!(sb->s_flags & MS_RDONLY)) {
 		EXT4_CLEAR_INCOMPAT_FEATURE(sb, EXT4_FEATURE_INCOMPAT_RECOVER);
 		es->s_state = cpu_to_le16(sbi->s_mount_state);
@@ -1677,8 +1677,8 @@ static int ext4_fill_super (struct super
 		/* No mode set, assume a default based on the journal
                    capabilities: ORDERED_DATA if the journal can
                    cope, else JOURNAL_DATA */
-		if (journal_check_available_features
-		    (sbi->s_journal, 0, 0, JFS_FEATURE_INCOMPAT_REVOKE))
+		if (jbd2_journal_check_available_features
+		    (sbi->s_journal, 0, 0, JBD2_FEATURE_INCOMPAT_REVOKE))
 			set_opt(sbi->s_mount_opt, ORDERED_DATA);
 		else
 			set_opt(sbi->s_mount_opt, JOURNAL_DATA);
@@ -1686,8 +1686,8 @@ static int ext4_fill_super (struct super
 
 	case EXT4_MOUNT_ORDERED_DATA:
 	case EXT4_MOUNT_WRITEBACK_DATA:
-		if (!journal_check_available_features
-		    (sbi->s_journal, 0, 0, JFS_FEATURE_INCOMPAT_REVOKE)) {
+		if (!jbd2_journal_check_available_features
+		    (sbi->s_journal, 0, 0, JBD2_FEATURE_INCOMPAT_REVOKE)) {
 			printk(KERN_ERR "EXT4-fs: Journal does not support "
 			       "requested data journaling mode\n");
 			goto failed_mount4;
@@ -1704,7 +1704,7 @@ static int ext4_fill_super (struct super
 		}
 	}
 	/*
-	 * The journal_load will have done any necessary log recovery,
+	 * The jbd2_journal_load will have done any necessary log recovery,
 	 * so we can safely mount the rest of the filesystem now.
 	 */
 
@@ -1752,7 +1752,7 @@ cantfind_ext4:
 	goto failed_mount;
 
 failed_mount4:
-	journal_destroy(sbi->s_journal);
+	jbd2_journal_destroy(sbi->s_journal);
 failed_mount3:
 	percpu_counter_destroy(&sbi->s_freeblocks_counter);
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
@@ -1792,9 +1792,9 @@ static void ext4_init_journal_params(str
 
 	spin_lock(&journal->j_state_lock);
 	if (test_opt(sb, BARRIER))
-		journal->j_flags |= JFS_BARRIER;
+		journal->j_flags |= JBD2_BARRIER;
 	else
-		journal->j_flags &= ~JFS_BARRIER;
+		journal->j_flags &= ~JBD2_BARRIER;
 	spin_unlock(&journal->j_state_lock);
 }
 
@@ -1827,7 +1827,7 @@ static journal_t *ext4_get_journal(struc
 		return NULL;
 	}
 
-	journal = journal_init_inode(journal_inode);
+	journal = jbd2_journal_init_inode(journal_inode);
 	if (!journal) {
 		printk(KERN_ERR "EXT4-fs: Could not load journal inode\n");
 		iput(journal_inode);
@@ -1899,7 +1899,7 @@ static journal_t *ext4_get_dev_journal(s
 	start = sb_block + 1;
 	brelse(bh);	/* we're done with the superblock */
 
-	journal = journal_init_dev(bdev, sb->s_bdev,
+	journal = jbd2_journal_init_dev(bdev, sb->s_bdev,
 					start, len, blocksize);
 	if (!journal) {
 		printk(KERN_ERR "EXT4-fs: failed to create device journal\n");
@@ -1922,7 +1922,7 @@ static journal_t *ext4_get_dev_journal(s
 	ext4_init_journal_params(sb, journal);
 	return journal;
 out_journal:
-	journal_destroy(journal);
+	jbd2_journal_destroy(journal);
 out_bdev:
 	ext4_blkdev_put(bdev);
 	return NULL;
@@ -1983,22 +1983,22 @@ static int ext4_load_journal(struct supe
 	}
 
 	if (!really_read_only && test_opt(sb, UPDATE_JOURNAL)) {
-		err = journal_update_format(journal);
+		err = jbd2_journal_update_format(journal);
 		if (err)  {
 			printk(KERN_ERR "EXT4-fs: error updating journal.\n");
-			journal_destroy(journal);
+			jbd2_journal_destroy(journal);
 			return err;
 		}
 	}
 
 	if (!EXT4_HAS_INCOMPAT_FEATURE(sb, EXT4_FEATURE_INCOMPAT_RECOVER))
-		err = journal_wipe(journal, !really_read_only);
+		err = jbd2_journal_wipe(journal, !really_read_only);
 	if (!err)
-		err = journal_load(journal);
+		err = jbd2_journal_load(journal);
 
 	if (err) {
 		printk(KERN_ERR "EXT4-fs: error loading journal.\n");
-		journal_destroy(journal);
+		jbd2_journal_destroy(journal);
 		return err;
 	}
 
@@ -2035,9 +2035,9 @@ static int ext4_create_journal(struct su
 	printk(KERN_INFO "EXT4-fs: creating new journal on inode %d\n",
 	       journal_inum);
 
-	if (journal_create(journal)) {
+	if (jbd2_journal_create(journal)) {
 		printk(KERN_ERR "EXT4-fs: error creating journal.\n");
-		journal_destroy(journal);
+		jbd2_journal_destroy(journal);
 		return -EIO;
 	}
 
@@ -2084,15 +2084,15 @@ static void ext4_mark_recovery_complete(
 {
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 
-	journal_lock_updates(journal);
-	journal_flush(journal);
+	jbd2_journal_lock_updates(journal);
+	jbd2_journal_flush(journal);
 	if (EXT4_HAS_INCOMPAT_FEATURE(sb, EXT4_FEATURE_INCOMPAT_RECOVER) &&
 	    sb->s_flags & MS_RDONLY) {
 		EXT4_CLEAR_INCOMPAT_FEATURE(sb, EXT4_FEATURE_INCOMPAT_RECOVER);
 		sb->s_dirt = 0;
 		ext4_commit_super(sb, es, 1);
 	}
-	journal_unlock_updates(journal);
+	jbd2_journal_unlock_updates(journal);
 }
 
 /*
@@ -2114,7 +2114,7 @@ static void ext4_clear_journal_err(struc
 	 * journal by a prior ext4_error() or ext4_abort()
 	 */
 
-	j_errno = journal_errno(journal);
+	j_errno = jbd2_journal_errno(journal);
 	if (j_errno) {
 		char nbuf[16];
 
@@ -2128,7 +2128,7 @@ static void ext4_clear_journal_err(struc
 		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
 		ext4_commit_super (sb, es, 1);
 
-		journal_clear_err(journal);
+		jbd2_journal_clear_err(journal);
 	}
 }
 
@@ -2171,9 +2171,9 @@ static int ext4_sync_fs(struct super_blo
 	tid_t target;
 
 	sb->s_dirt = 0;
-	if (journal_start_commit(EXT4_SB(sb)->s_journal, &target)) {
+	if (jbd2_journal_start_commit(EXT4_SB(sb)->s_journal, &target)) {
 		if (wait)
-			log_wait_commit(EXT4_SB(sb)->s_journal, target);
+			jbd2_log_wait_commit(EXT4_SB(sb)->s_journal, target);
 	}
 	return 0;
 }
@@ -2190,8 +2190,8 @@ static void ext4_write_super_lockfs(stru
 		journal_t *journal = EXT4_SB(sb)->s_journal;
 
 		/* Now we set up the journal barrier. */
-		journal_lock_updates(journal);
-		journal_flush(journal);
+		jbd2_journal_lock_updates(journal);
+		jbd2_journal_flush(journal);
 
 		/* Journal blocked and flushed, clear needs_recovery flag. */
 		EXT4_CLEAR_INCOMPAT_FEATURE(sb, EXT4_FEATURE_INCOMPAT_RECOVER);
@@ -2211,7 +2211,7 @@ static void ext4_unlockfs(struct super_b
 		EXT4_SET_INCOMPAT_FEATURE(sb, EXT4_FEATURE_INCOMPAT_RECOVER);
 		ext4_commit_super(sb, EXT4_SB(sb)->s_es, 1);
 		unlock_super(sb);
-		journal_unlock_updates(EXT4_SB(sb)->s_journal);
+		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
 	}
 }
 
@@ -2394,9 +2394,9 @@ static int ext4_statfs (struct dentry * 
  * is locked for write. Otherwise the are possible deadlocks:
  * Process 1                         Process 2
  * ext4_create()                     quota_sync()
- *   journal_start()                   write_dquot()
+ *   jbd2_journal_start()                   write_dquot()
  *   DQUOT_INIT()                        down(dqio_mutex)
- *     down(dqio_mutex)                    journal_start()
+ *     down(dqio_mutex)                    jbd2_journal_start()
  *
  */
 
diff -puN fs/ext4/symlink.c~rename-jbd2-in-ext4 fs/ext4/symlink.c
--- linux-2.6.18-rc4/fs/ext4/symlink.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.272194746 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/symlink.c	2006-08-09 15:41:40.318195119 -0700
@@ -18,7 +18,7 @@
  */
 
 #include <linux/fs.h>
-#include <linux/jbd.h>
+#include <linux/jbd2.h>
 #include <linux/ext4_fs.h>
 #include <linux/namei.h>
 #include "xattr.h"
diff -puN fs/ext4/xattr.c~rename-jbd2-in-ext4 fs/ext4/xattr.c
--- linux-2.6.18-rc4/fs/ext4/xattr.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.276194779 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/xattr.c	2006-08-09 15:41:40.320195135 -0700
@@ -53,7 +53,7 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
-#include <linux/ext4_jbd.h>
+#include <linux/ext4_jbd2.h>
 #include <linux/ext4_fs.h>
 #include <linux/mbcache.h>
 #include <linux/quotaops.h>
diff -puN fs/ext4/xattr_security.c~rename-jbd2-in-ext4 fs/ext4/xattr_security.c
--- linux-2.6.18-rc4/fs/ext4/xattr_security.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.279194803 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/xattr_security.c	2006-08-09 15:41:40.321195143 -0700
@@ -7,7 +7,7 @@
 #include <linux/string.h>
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
-#include <linux/ext4_jbd.h>
+#include <linux/ext4_jbd2.h>
 #include <linux/ext4_fs.h>
 #include <linux/security.h>
 #include "xattr.h"
diff -puN fs/ext4/xattr_trusted.c~rename-jbd2-in-ext4 fs/ext4/xattr_trusted.c
--- linux-2.6.18-rc4/fs/ext4/xattr_trusted.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.282194827 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/xattr_trusted.c	2006-08-09 15:41:40.321195143 -0700
@@ -10,7 +10,7 @@
 #include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
-#include <linux/ext4_jbd.h>
+#include <linux/ext4_jbd2.h>
 #include <linux/ext4_fs.h>
 #include "xattr.h"
 
diff -puN fs/ext4/xattr_user.c~rename-jbd2-in-ext4 fs/ext4/xattr_user.c
--- linux-2.6.18-rc4/fs/ext4/xattr_user.c~rename-jbd2-in-ext4	2006-08-09 15:41:40.285194852 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/xattr_user.c	2006-08-09 15:41:40.322195151 -0700
@@ -9,7 +9,7 @@
 #include <linux/string.h>
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
-#include <linux/ext4_jbd.h>
+#include <linux/ext4_jbd2.h>
 #include <linux/ext4_fs.h>
 #include "xattr.h"
 

_


