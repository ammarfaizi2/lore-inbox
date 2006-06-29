Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWF2TR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWF2TR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWF2TR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:17:57 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:37598 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932264AbWF2TRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:17:55 -0400
Message-ID: <44A42767.4060200@namesys.com>
Date: Thu, 29 Jun 2006 12:17:59 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] reiser4-batch-write.patch
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030905010707090302020702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030905010707090302020702
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit




--------------030905010707090302020702
Content-Type: text/x-patch;
 name="reiser4-batch-write.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiser4-batch-write.patch"


This changes reiser4' write to go via generic_file_write and
batch_write address space operation implementation.



diff -puN fs/reiser4/plugin/file/file.c~reiser4-batch-write fs/reiser4/plugin/file/file.c
--- linux-2.6.17-mm3/fs/reiser4/plugin/file/file.c~reiser4-batch-write	2006-06-28 22:21:20.000000000 +0400
+++ linux-2.6.17-mm3-root/fs/reiser4/plugin/file/file.c	2006-06-28 22:27:27.000000000 +0400
@@ -20,6 +20,7 @@
 
 #include <linux/writeback.h>
 #include <linux/pagevec.h>
+#include <linux/uio.h>
 #include <linux/syscalls.h>
 
 
@@ -905,6 +906,199 @@ commit_write_unix_file(struct file *file
 	return result;
 }
 
+static void drop_access(unix_file_info_t *uf_info)
+{
+	if (uf_info->exclusive_use)
+		drop_exclusive_access(uf_info);
+	else
+		drop_nonexclusive_access(uf_info);
+}
+
+#define NEITHER_OBTAINED 0
+#define EA_OBTAINED 1
+#define NEA_OBTAINED 2
+
+long batch_write_unix_file(struct file *file, const write_descriptor_t *desc,
+			   struct pagevec *lru_pvec, struct page **cached_page,
+			   size_t *written)
+{
+	int result;
+	reiser4_context *ctx;
+	struct inode *inode;
+	unix_file_info_t *uf_info;
+	ssize_t written1;
+	int try_free_space;
+	int to_write = PAGE_CACHE_SIZE * WRITE_GRANULARITY;
+	size_t left;
+	ssize_t (*write_op)(struct file *, const char __user *, size_t,
+			    loff_t *pos);
+	int ea;
+	loff_t new_size;
+	loff_t pos;
+	char __user *buf;
+	
+	inode = file->f_dentry->d_inode;
+	assert("vs-947", !inode_get_flag(inode, REISER4_NO_SD));
+	assert("vs-9471", (!inode_get_flag(inode, REISER4_PART_MIXED)));
+
+	ctx = init_context(inode->i_sb);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	uf_info = unix_file_inode_data(inode);
+
+	*written = 0;
+	result = 0;
+	try_free_space = 0;
+	left = desc->count;
+	pos = desc->pos;
+	buf = desc->buf;
+	/* make sure that we are to write within one i/o vector */
+	assert("", desc->cur_iov->iov_base + desc->iov_off == buf);
+	assert("", desc->iov_off + desc->count <= desc->cur_iov->iov_len);
+
+	ea = NEITHER_OBTAINED;
+
+	new_size = i_size_read(inode);
+	if (desc->pos + desc->count > new_size)
+		new_size = desc->pos + desc->count;
+
+	while (left) {
+		if (left < to_write)
+			to_write = left;
+
+		if (uf_info->container == UF_CONTAINER_EMPTY) {
+			get_exclusive_access(uf_info);
+			ea = EA_OBTAINED;
+			if (uf_info->container != UF_CONTAINER_EMPTY) {
+				/* file is made not empty by another process */
+				drop_exclusive_access(uf_info);
+				ea = NEITHER_OBTAINED;
+				continue;
+			}
+		} else if (uf_info->container == UF_CONTAINER_UNKNOWN) {
+			/*
+			 * get exclusive access directly just to not have to
+			 * re-obtain it if file will appear empty
+			 */
+			get_exclusive_access(uf_info);
+			ea = EA_OBTAINED;
+			result = find_file_state(inode, uf_info);
+			if (result) {
+				drop_exclusive_access(uf_info);
+				ea = NEITHER_OBTAINED;
+				break;
+			}
+		} else {
+			get_nonexclusive_access(uf_info);
+			ea = NEA_OBTAINED;
+		}
+
+		/* either EA or NEA is obtained. Choose item write method */
+		if (uf_info->container == UF_CONTAINER_EXTENTS) {
+			/* file is built of extent items */
+			write_op = write_extent;
+		} else if (uf_info->container == UF_CONTAINER_EMPTY) {
+			/* file is empty */
+			if (should_have_notail(uf_info, new_size))
+				write_op = write_extent;
+			else
+				write_op = write_tail;
+		} else {
+			/* file is built of tail items */
+			if (should_have_notail(uf_info, new_size)) {
+				if (ea == NEA_OBTAINED) {
+					drop_nonexclusive_access(uf_info);
+					get_exclusive_access(uf_info);
+					ea = EA_OBTAINED;
+				}
+				if (uf_info->container == UF_CONTAINER_TAILS) {
+					/*
+					 * if file is being convered by another
+					 * process - wait until it completes
+					 */
+					while (1) {
+						if (inode_get_flag(inode, REISER4_PART_IN_CONV)) {
+							drop_exclusive_access(uf_info);
+							schedule();
+							get_exclusive_access(uf_info);
+							continue;
+						}
+						break;
+					}
+					if (uf_info->container ==  UF_CONTAINER_TAILS) {
+						result = tail2extent(uf_info);
+						if (result)
+							break;
+					}
+				}
+				drop_exclusive_access(uf_info);
+				ea = NEITHER_OBTAINED;
+				continue;
+			}
+			write_op = write_tail;
+		}
+
+		written1 = write_op(file, desc->buf, to_write, &pos);
+		if (written1 == -ENOSPC && try_free_space) {
+			drop_access(uf_info);
+			txnmgr_force_commit_all(inode->i_sb, 0);
+			try_free_space = 0;
+			continue;
+		}
+		if (written1 < 0) {
+			drop_access(uf_info);
+			result = written1;
+			break;
+		}
+		/* something is written. */
+		if (uf_info->container == UF_CONTAINER_EMPTY) {
+			assert("", ea == EA_OBTAINED);
+			uf_info->container = (write_op == write_extent) ?
+				UF_CONTAINER_EXTENTS : UF_CONTAINER_TAILS;
+		} else {
+			assert("", ergo(uf_info->container == UF_CONTAINER_EXTENTS,
+					write_op == write_extent));
+			assert("", ergo(uf_info->container == UF_CONTAINER_TAILS,
+					write_op == write_tail));
+		}
+		if (desc->pos + written1 > inode->i_size)
+			INODE_SET_FIELD(inode, i_size, desc->pos + written1);
+		file_update_time(file);
+		result = reiser4_update_sd(inode);
+		if (result) {
+			drop_access(uf_info);
+			context_set_commit_async(ctx);
+			reiser4_exit_context(ctx);
+			return result;
+		}
+		drop_access(uf_info);
+		ea = NEITHER_OBTAINED;
+		txn_restart(ctx);
+		current->journal_info = NULL;
+		/*
+		 * tell VM how many pages were dirtied. Maybe number of pages
+		 * which were dirty already should not be counted
+		 */
+		balance_dirty_pages_ratelimited_nr(inode->i_mapping,
+						   (written1 + PAGE_CACHE_SIZE - 1) / PAGE_CACHE_SIZE);
+		current->journal_info = ctx;
+
+		left -= written1;
+		buf += written1;
+		pos += written1;
+		*written += written1;
+	}
+	/*
+	 * return number of written bytes or error code if nothing is
+	 * written. Note, that it does not work correctly in case when
+	 * sync_unix_file returns error
+	 */
+	context_set_commit_async(ctx);
+	reiser4_exit_context(ctx);
+	return (*written - left) ? (*written - left) : result;
+}
+
 /*
  * Support for "anonymous" pages and jnodes.
  *
@@ -1984,21 +2178,6 @@ int open_unix_file(struct inode *inode, 
 	return result;
 }
 
-#define NEITHER_OBTAINED 0
-#define EA_OBTAINED 1
-#define NEA_OBTAINED 2
-
-static void drop_access(unix_file_info_t *uf_info)
-{
-	if (uf_info->exclusive_use)
-		drop_exclusive_access(uf_info);
-	else
-		drop_nonexclusive_access(uf_info);
-}
-
-#define debug_wuf(format, ...) printk("%s: %d: %s: " format "\n", \
-			      __FILE__, __LINE__, __FUNCTION__, ## __VA_ARGS__)
-
 /**
  * write_unix_file - write of struct file_operations
  * @file: file to write to
@@ -2012,208 +2191,7 @@ static void drop_access(unix_file_info_t
 ssize_t write_unix_file(struct file *file, const char __user *buf,
 			size_t count, loff_t *pos)
 {
-	int result;
-	reiser4_context *ctx;
-	struct inode *inode;
-	unix_file_info_t *uf_info;
-	ssize_t written;
-	int try_free_space;
-	int to_write = PAGE_CACHE_SIZE * WRITE_GRANULARITY;
-	size_t left;
-	ssize_t (*write_op)(struct file *, const char __user *, size_t,
-			    loff_t *pos);
-	int ea;
-	loff_t new_size;
-
-	inode = file->f_dentry->d_inode;
-	ctx = init_context(inode->i_sb);
-	if (IS_ERR(ctx))
-		return PTR_ERR(ctx);
-
-	mutex_lock(&inode->i_mutex);
-
-	assert("vs-947", !inode_get_flag(inode, REISER4_NO_SD));
-	assert("vs-9471", (!inode_get_flag(inode, REISER4_PART_MIXED)));
-
-	/* check amount of bytes to write and writing position */
-	result = generic_write_checks(file, pos, &count, 0);
-	if (result) {
-		mutex_unlock(&inode->i_mutex);
-		context_set_commit_async(ctx);
-		reiser4_exit_context(ctx);
-		return result;
-	}
-
-	result = remove_suid(file->f_dentry);
-	if (result) {
-		mutex_unlock(&inode->i_mutex);
-		context_set_commit_async(ctx);
-		reiser4_exit_context(ctx);
-		return result;
-	}
-
-	uf_info = unix_file_inode_data(inode);
-
-	current->backing_dev_info = inode->i_mapping->backing_dev_info;
-	written = 0;
-	try_free_space = 0;
-	left = count;
-	ea = NEITHER_OBTAINED;
-
-	new_size = i_size_read(inode);
-	if (*pos + count > new_size)
-		new_size = *pos + count;
-
-	while (left) {
-		if (left < to_write)
-			to_write = left;
-
-		if (uf_info->container == UF_CONTAINER_EMPTY) {
-			get_exclusive_access(uf_info);
-			ea = EA_OBTAINED;
-			if (uf_info->container != UF_CONTAINER_EMPTY) {
-				/* file is made not empty by another process */
-				drop_exclusive_access(uf_info);
-				ea = NEITHER_OBTAINED;
-				continue;
-			}
-		} else if (uf_info->container == UF_CONTAINER_UNKNOWN) {
-			/*
-			 * get exclusive access directly just to not have to
-			 * re-obtain it if file will appear empty
-			 */
-			get_exclusive_access(uf_info);
-			ea = EA_OBTAINED;
-			result = find_file_state(inode, uf_info);
-			if (result) {
-				drop_exclusive_access(uf_info);
-				ea = NEITHER_OBTAINED;
-				break;
-			}
-		} else {
-			get_nonexclusive_access(uf_info);
-			ea = NEA_OBTAINED;
-		}
-
-		/* either EA or NEA is obtained. Choose item write method */
-		if (uf_info->container == UF_CONTAINER_EXTENTS) {
-			/* file is built of extent items */
-			write_op = write_extent;
-		} else if (uf_info->container == UF_CONTAINER_EMPTY) {
-			/* file is empty */
-			if (should_have_notail(uf_info, new_size))
-				write_op = write_extent;
-			else
-				write_op = write_tail;
-		} else {
-			/* file is built of tail items */
-			if (should_have_notail(uf_info, new_size)) {
-				if (ea == NEA_OBTAINED) {
-					drop_nonexclusive_access(uf_info);
-					get_exclusive_access(uf_info);
-					ea = EA_OBTAINED;
-				}
-				if (uf_info->container == UF_CONTAINER_TAILS) {
-					/*
-					 * if file is being convered by another
-					 * process - wait until it completes
-					 */
-					while (1) {
-						if (inode_get_flag(inode, REISER4_PART_IN_CONV)) {
-							drop_exclusive_access(uf_info);
-							schedule();
-							get_exclusive_access(uf_info);
-							continue;
-						}
-						break;
-					}
-					if (uf_info->container ==  UF_CONTAINER_TAILS) {
-						result = tail2extent(uf_info);
-						if (result)
-							break;
-					}
-				}
-				drop_exclusive_access(uf_info);
-				ea = NEITHER_OBTAINED;
-				continue;
-			}
-			write_op = write_tail;
-		}
-
-		written = write_op(file, buf, to_write, pos);
-		if (written == -ENOSPC && try_free_space) {
-			drop_access(uf_info);
-			txnmgr_force_commit_all(inode->i_sb, 0);
-			try_free_space = 0;
-			continue;
-		}
-		if (written < 0) {
-			drop_access(uf_info);
-			result = written;
-			break;
-		}
-		/* something is written. */
-		if (uf_info->container == UF_CONTAINER_EMPTY) {
-			assert("", ea == EA_OBTAINED);
-			uf_info->container = (write_op == write_extent) ?
-				UF_CONTAINER_EXTENTS : UF_CONTAINER_TAILS;
-		} else {
-			assert("", ergo(uf_info->container == UF_CONTAINER_EXTENTS,
-					write_op == write_extent));
-			assert("", ergo(uf_info->container == UF_CONTAINER_TAILS,
-					write_op == write_tail));
-		}
-		if (*pos + written > inode->i_size)
-			INODE_SET_FIELD(inode, i_size, *pos + written);
-		file_update_time(file);
-		result = reiser4_update_sd(inode);
-		if (result) {
-			mutex_unlock(&inode->i_mutex);
-			current->backing_dev_info = NULL;
-			drop_access(uf_info);
-			context_set_commit_async(ctx);
-			reiser4_exit_context(ctx);
-			return result;
-		}
-		drop_access(uf_info);
-		ea = NEITHER_OBTAINED;
-		txn_restart(ctx);
-		current->journal_info = NULL;
-		/*
-		 * tell VM how many pages were dirtied. Maybe number of pages
-		 * which were dirty already should not be counted
-		 */
-		balance_dirty_pages_ratelimited_nr(inode->i_mapping,
-						   (written + PAGE_CACHE_SIZE - 1) / PAGE_CACHE_SIZE);
-		current->journal_info = ctx;
-
-		left -= written;
-		buf += written;
-		*pos += written;
-	}
-
-	mutex_unlock(&inode->i_mutex);
-
-	if (result == 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
-		txn_restart_current();
-		grab_space_enable();
-		result = sync_unix_file(file, file->f_dentry,
-					0 /* data and stat data */ );
-		if (result)
-			warning("reiser4-7", "failed to sync file %llu",
-				(unsigned long long)get_inode_oid(inode));
-	}
-
-	current->backing_dev_info = NULL;
-
-	reiser4_exit_context(ctx);
-
-	/*
-	 * return number of written bytes or error code if nothing is
-	 * written. Note, that it does not work correctly in case when
-	 * sync_unix_file returns error
-	 */
-	return (count - left) ? (count - left) : result;
+	return generic_file_write(file, buf, count, pos);
 }
 
 /**
diff -puN fs/reiser4/plugin/object.c~reiser4-batch-write fs/reiser4/plugin/object.c
--- linux-2.6.17-mm3/fs/reiser4/plugin/object.c~reiser4-batch-write	2006-06-28 22:21:20.000000000 +0400
+++ linux-2.6.17-mm3-root/fs/reiser4/plugin/object.c	2006-06-28 22:21:20.000000000 +0400
@@ -117,6 +117,7 @@ file_plugin file_plugins[LAST_FILE_PLUGI
 			.readpages = reiser4_readpages,
 			.prepare_write = prepare_write_unix_file,
 			.commit_write =	commit_write_unix_file,
+			.batch_write = batch_write_unix_file,
 			.bmap = bmap_unix_file,
 			.invalidatepage = reiser4_invalidatepage,
 			.releasepage = reiser4_releasepage
diff -puN fs/reiser4/plugin/file/file.h~reiser4-batch-write fs/reiser4/plugin/file/file.h
--- linux-2.6.17-mm3/fs/reiser4/plugin/file/file.h~reiser4-batch-write	2006-06-28 22:21:20.000000000 +0400
+++ linux-2.6.17-mm3-root/fs/reiser4/plugin/file/file.h	2006-06-28 22:21:20.000000000 +0400
@@ -34,6 +34,9 @@ int prepare_write_unix_file(struct file 
 			    unsigned to);
 int commit_write_unix_file(struct file *, struct page *, unsigned from,
 			   unsigned to);
+long batch_write_unix_file(struct file *, const write_descriptor_t *,
+			       struct pagevec *, struct page **,
+			       size_t *written);
 sector_t bmap_unix_file(struct address_space *, sector_t lblock);
 
 /* file plugin operations */

_


--------------030905010707090302020702--
