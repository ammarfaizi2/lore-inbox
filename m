Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVCNTXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVCNTXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVCNTXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:23:16 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:206 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261748AbVCNTXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:23:05 -0500
Subject: [PATCH] 2.6.11-mm3 patch for ext3 writeback "nobh" option
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-y5URZBcWc34k//Y3ke7x"
Organization: 
Message-Id: <1110827903.24286.275.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Mar 2005 11:18:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y5URZBcWc34k//Y3ke7x
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

Here is the 2.6.11-mm3 version of patch for adding "nobh"
support for ext3 writeback mode.

Can you include it in -mm ?

Thanks,
Badari



--=-y5URZBcWc34k//Y3ke7x
Content-Disposition: attachment; filename=ext3-writeback-nobh.2611mm3.patch
Content-Type: text/x-patch; name=ext3-writeback-nobh.2611mm3.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Narup -X dontdiff linux-2.6.11-mm3-org/fs/ext3/inode.c linux-2.6.11/fs/ext3/inode.c
--- linux-2.6.11-mm3-org/fs/ext3/inode.c	2005-03-14 10:52:16.231806824 -0800
+++ linux-2.6.11/fs/ext3/inode.c	2005-03-14 12:19:33.891561512 -0800
@@ -1016,7 +1016,10 @@ retry:
 		ret = PTR_ERR(handle);
 		goto out;
 	}
-	ret = block_prepare_write(page, from, to, ext3_get_block);
+	if (test_opt(inode->i_sb, NOBH))
+		ret = nobh_prepare_write(page, from, to, ext3_get_block);
+	else
+		ret = block_prepare_write(page, from, to, ext3_get_block);
 	if (ret)
 		goto prepare_write_failed;
 
@@ -1100,7 +1103,12 @@ static int ext3_writeback_commit_write(s
 	new_i_size = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
 	if (new_i_size > EXT3_I(inode)->i_disksize)
 		EXT3_I(inode)->i_disksize = new_i_size;
-	ret = generic_commit_write(file, page, from, to);
+
+	if (test_opt(inode->i_sb, NOBH))
+		ret = nobh_commit_write(file, page, from, to);
+	else
+		ret = generic_commit_write(file, page, from, to);
+
 	ret2 = ext3_journal_stop(handle);
 	if (!ret)
 		ret = ret2;
@@ -1385,7 +1393,11 @@ static int ext3_writeback_writepage(stru
 		goto out_fail;
 	}
 
-	ret = block_write_full_page(page, ext3_get_block, wbc);
+	if (test_opt(inode->i_sb, NOBH))
+		ret = nobh_writepage(page, ext3_get_block, wbc);
+	else
+		ret = block_write_full_page(page, ext3_get_block, wbc);
+
 	err = ext3_journal_stop(handle);
 	if (!ret)
 		ret = err;
@@ -1484,6 +1496,8 @@ static int ext3_releasepage(struct page 
 	journal_t *journal = EXT3_JOURNAL(page->mapping->host);
 
 	WARN_ON(PageChecked(page));
+	if (!page_has_buffers(page))	
+		return 0;
 	return journal_try_to_free_buffers(journal, page, wait);
 }
 
@@ -1646,13 +1660,28 @@ static int ext3_block_truncate_page(hand
 	unsigned blocksize, iblock, length, pos;
 	struct inode *inode = mapping->host;
 	struct buffer_head *bh;
-	int err;
+	int err = 0;
 	void *kaddr;
 
 	blocksize = inode->i_sb->s_blocksize;
 	length = blocksize - (offset & (blocksize - 1));
 	iblock = index << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits);
 
+	/*
+	 * For "nobh" option,  we can only work if we don't need to
+	 * read-in the page - otherwise we create buffers to do the IO.
+	 */
+	if (!page_has_buffers(page) && test_opt(inode->i_sb, NOBH)) {
+		if (PageUptodate(page)) {
+			kaddr = kmap_atomic(page, KM_USER0);
+			memset(kaddr + offset, 0, length);
+			flush_dcache_page(page);
+			kunmap_atomic(kaddr, KM_USER0);
+			set_page_dirty(page);
+			goto unlock;
+		}
+	}
+
 	if (!page_has_buffers(page))
 		create_empty_buffers(page, blocksize, 0);
 
diff -Narup -X dontdiff linux-2.6.11-mm3-org/fs/ext3/super.c linux-2.6.11/fs/ext3/super.c
--- linux-2.6.11-mm3-org/fs/ext3/super.c	2005-03-01 23:38:38.000000000 -0800
+++ linux-2.6.11/fs/ext3/super.c	2005-03-14 12:18:09.734355352 -0800
@@ -576,7 +576,7 @@ enum {
 	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic, Opt_err_ro,
 	Opt_nouid32, Opt_check, Opt_nocheck, Opt_debug, Opt_oldalloc, Opt_orlov,
 	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl,
-	Opt_reservation, Opt_noreservation, Opt_noload,
+	Opt_reservation, Opt_noreservation, Opt_noload, Opt_nobh,
 	Opt_commit, Opt_journal_update, Opt_journal_inum,
 	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
 	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
@@ -611,6 +611,7 @@ static match_table_t tokens = {
 	{Opt_reservation, "reservation"},
 	{Opt_noreservation, "noreservation"},
 	{Opt_noload, "noload"},
+	{Opt_nobh, "nobh"},
 	{Opt_commit, "commit=%u"},
 	{Opt_journal_update, "journal=update"},
 	{Opt_journal_inum, "journal=%u"},
@@ -924,6 +925,9 @@ clear_qf_name:
 			match_int(&args[0], &option);
 			*n_blocks_count = option;
 			break;
+		case Opt_nobh:
+			set_opt(sbi->s_mount_opt, NOBH);
+			break;
 		default:
 			printk (KERN_ERR
 				"EXT3-fs: Unrecognized mount option \"%s\" "
@@ -1563,6 +1567,19 @@ static int ext3_fill_super (struct super
 		break;
 	}
 
+	if (test_opt(sb, NOBH)) {
+		if (sb->s_blocksize_bits != PAGE_CACHE_SHIFT) {
+			printk(KERN_WARNING "EXT3-fs: Ignoring nobh option "
+				"since filesystem blocksize doesn't match "
+				"pagesize\n");
+			clear_opt(sbi->s_mount_opt, NOBH);
+		}
+		if (!(test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_WRITEBACK_DATA)) {
+			printk(KERN_WARNING "EXT3-fs: Ignoring nobh option - "
+				"its supported only with writeback mode\n");
+			clear_opt(sbi->s_mount_opt, NOBH);
+		}
+	}
 	/*
 	 * The journal_load will have done any necessary log recovery,
 	 * so we can safely mount the rest of the filesystem now.
diff -Narup -X dontdiff linux-2.6.11-mm3-org/include/linux/ext3_fs.h linux-2.6.11/include/linux/ext3_fs.h
--- linux-2.6.11-mm3-org/include/linux/ext3_fs.h	2005-03-01 23:38:10.000000000 -0800
+++ linux-2.6.11/include/linux/ext3_fs.h	2005-03-14 12:18:09.762351096 -0800
@@ -357,6 +357,7 @@ struct ext3_inode {
 #define EXT3_MOUNT_POSIX_ACL		0x08000	/* POSIX Access Control Lists */
 #define EXT3_MOUNT_RESERVATION		0x10000	/* Preallocation */
 #define EXT3_MOUNT_BARRIER		0x20000 /* Use block barriers */
+#define EXT3_MOUNT_NOBH			0x40000 /* No bufferheads */
 
 /* Compatibility, for having both ext2_fs.h and ext3_fs.h included at once */
 #ifndef _LINUX_EXT2_FS_H

--=-y5URZBcWc34k//Y3ke7x--

