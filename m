Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316995AbSFAIle>; Sat, 1 Jun 2002 04:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316996AbSFAIk1>; Sat, 1 Jun 2002 04:40:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49674 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316993AbSFAIjU>;
	Sat, 1 Jun 2002 04:39:20 -0400
Message-ID: <3CF88903.E253A075@zip.com.au>
Date: Sat, 01 Jun 2002 01:42:43 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 9/16] direct-to-BIO writeback for writeback-mode ext3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Turn on direct-to-BIO writeback for ext3 in data=writeback mode.


=====================================

--- 2.5.19/fs/ext3/inode.c~ext3-writepages	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/fs/ext3/inode.c	Sat Jun  1 01:18:10 2002
@@ -1389,6 +1389,34 @@ struct address_space_operations ext3_aop
 	releasepage:	ext3_releasepage,	/* BKL not held.  Don't need */
 };
 
+/* For writeback mode, we can use mpage_writepages() */
+
+static int
+ext3_writepages(struct address_space *mapping, int *nr_to_write)
+{
+	int ret;
+	int err;
+
+	ret = write_mapping_buffers(mapping);
+	err = mpage_writepages(mapping, nr_to_write, ext3_get_block);
+	if (!ret)
+		ret = err;
+	return ret;
+}
+
+struct address_space_operations ext3_writeback_aops = {
+	readpage:	ext3_readpage,		/* BKL not held.  Don't need */
+	readpages:	ext3_readpages,		/* BKL not held.  Don't need */
+	writepage:	ext3_writepage,		/* BKL not held.  We take it */
+	writepages:	ext3_writepages,	/* BKL not held.  Don't need */
+	sync_page:	block_sync_page,
+	prepare_write:	ext3_prepare_write,	/* BKL not held.  We take it */
+	commit_write:	ext3_commit_write,	/* BKL not held.  We take it */
+	bmap:		ext3_bmap,		/* BKL held */
+	flushpage:	ext3_flushpage,		/* BKL not held.  Don't need */
+	releasepage:	ext3_releasepage,	/* BKL not held.  Don't need */
+};
+
 /*
  * ext3_block_truncate_page() zeroes out a mapping from file offset `from'
  * up to the end of the block which corresponds to `from'.
@@ -2159,7 +2187,10 @@ void ext3_read_inode(struct inode * inod
 	else if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext3_file_inode_operations;
 		inode->i_fop = &ext3_file_operations;
-		inode->i_mapping->a_ops = &ext3_aops;
+		if (ext3_should_writeback_data(inode))
+			inode->i_mapping->a_ops = &ext3_writeback_aops;
+		else
+			inode->i_mapping->a_ops = &ext3_aops;
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &ext3_dir_inode_operations;
 		inode->i_fop = &ext3_dir_operations;
@@ -2168,7 +2199,10 @@ void ext3_read_inode(struct inode * inod
 			inode->i_op = &ext3_fast_symlink_inode_operations;
 		else {
 			inode->i_op = &page_symlink_inode_operations;
-			inode->i_mapping->a_ops = &ext3_aops;
+			if (ext3_should_writeback_data(inode))
+				inode->i_mapping->a_ops = &ext3_writeback_aops;
+			else
+				inode->i_mapping->a_ops = &ext3_aops;
 		}
 	} else 
 		init_special_inode(inode, inode->i_mode,
--- 2.5.19/include/linux/ext3_jbd.h~ext3-writepages	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/include/linux/ext3_jbd.h	Sat Jun  1 01:18:10 2002
@@ -299,5 +299,10 @@ static inline int ext3_should_order_data
 	return (test_opt(inode->i_sb, DATA_FLAGS) == EXT3_MOUNT_ORDERED_DATA);
 }
 
+static inline int ext3_should_writeback_data(struct inode *inode)
+{
+	return !ext3_should_journal_data(inode) &&
+			!ext3_should_order_data(inode);
+}
 
 #endif	/* _LINUX_EXT3_JBD_H */
--- 2.5.19/include/linux/ext3_fs.h~ext3-writepages	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/include/linux/ext3_fs.h	Sat Jun  1 01:18:10 2002
@@ -695,6 +695,7 @@ extern struct file_operations ext3_file_
 
 /* inode.c */
 extern struct address_space_operations ext3_aops;
+extern struct address_space_operations ext3_writeback_aops;
 
 /* namei.c */
 extern struct inode_operations ext3_dir_inode_operations;
--- 2.5.19/fs/ext3/namei.c~ext3-writepages	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/fs/ext3/namei.c	Sat Jun  1 01:18:10 2002
@@ -510,7 +510,10 @@ static int ext3_create (struct inode * d
 	if (!IS_ERR(inode)) {
 		inode->i_op = &ext3_file_inode_operations;
 		inode->i_fop = &ext3_file_operations;
-		inode->i_mapping->a_ops = &ext3_aops;
+		if (ext3_should_writeback_data(inode))
+			inode->i_mapping->a_ops = &ext3_writeback_aops;
+		else
+			inode->i_mapping->a_ops = &ext3_aops;
 		ext3_mark_inode_dirty(handle, inode);
 		err = ext3_add_nondir(handle, dentry, inode);
 	}
@@ -985,7 +988,10 @@ static int ext3_symlink (struct inode * 
 
 	if (l > sizeof (EXT3_I(inode)->i_data)) {
 		inode->i_op = &page_symlink_inode_operations;
-		inode->i_mapping->a_ops = &ext3_aops;
+		if (ext3_should_writeback_data(inode))
+			inode->i_mapping->a_ops = &ext3_writeback_aops;
+		else
+			inode->i_mapping->a_ops = &ext3_aops;
 		/*
 		 * page_symlink() calls into ext3_prepare/commit_write.
 		 * We have a transaction open.  All is sweetness.  It also sets

-
