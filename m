Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262776AbVBYStt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbVBYStt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 13:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbVBYStt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 13:49:49 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:2530 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262776AbVBYStk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 13:49:40 -0500
Subject: [RFC][PATCH] 2.6.10 "nobh" support for ext3 writeback mode
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, sct@redhat.com
Content-Type: multipart/mixed; boundary="=-+vzWFDnspLdLPwmzTR7X"
Organization: 
Message-Id: <1109357303.16102.43.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Feb 2005 10:48:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+vzWFDnspLdLPwmzTR7X
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

As part of my buffer head cleanup attempt, I added "nobh" support
for ext3 writeback mode. I am still doing testing, so its not ready
for mainline.


How to use it ?

	mount -o data=writeback,nobh <bdev> <mntpoint>


I really don't like the way I handled ext3_block_truncate_page()
for "nobh" support. Better ideas ? calling ->prepare_write() 
to update the page doesn't seem to work due to journaling violations.

BTW, this patch depends on my earlier patch which adds
"nobh_writepage()" (currently in 2.6.11-rc4-mm1).

Thanks,
Badari



--=-+vzWFDnspLdLPwmzTR7X
Content-Disposition: attachment; filename=ext3-writeback-nobh.patch
Content-Type: text/plain; name=ext3-writeback-nobh.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
diff -Narup -Xdontdiff linux-2.6.10.org/fs/ext3/inode.c linux-2.6.10.nobh/fs/ext3/inode.c
--- linux-2.6.10.org/fs/ext3/inode.c	2004-12-24 13:35:01.000000000 -0800
+++ linux-2.6.10.nobh/fs/ext3/inode.c	2005-02-25 11:25:50.497488248 -0800
@@ -20,6 +20,7 @@
  * 	(jj@sunsite.ms.mff.cuni.cz)
  *
  *  Assorted race fixes, rewrite of ext3_get_block() by Al Viro, 2000
+ *  Added "nobh" support to ext3 writeback mode - pbadari@us.ibm.com
  */
 
 #include <linux/module.h>
@@ -1008,7 +1009,11 @@ retry:
 		ret = PTR_ERR(handle);
 		goto out;
 	}
-	ret = block_prepare_write(page, from, to, ext3_get_block);
+	if (ext3_should_writeback_data(inode) &&
+		test_opt(inode->i_sb, NOBH))
+		ret = nobh_prepare_write(page, from, to, ext3_get_block);
+	else
+		ret = block_prepare_write(page, from, to, ext3_get_block);
 	if (ret)
 		goto prepare_write_failed;
 
@@ -1092,7 +1097,12 @@ static int ext3_writeback_commit_write(s
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
@@ -1338,7 +1348,11 @@ static int ext3_writeback_writepage(stru
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
@@ -1598,13 +1612,34 @@ static int ext3_block_truncate_page(hand
 	unsigned blocksize, iblock, length, pos;
 	struct inode *inode = mapping->host;
 	struct buffer_head *bh;
-	int err;
+	int err = 0;
 	void *kaddr;
 
 	blocksize = inode->i_sb->s_blocksize;
 	length = blocksize - (offset & (blocksize - 1));
 	iblock = index << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits);
 
+	if (ext3_should_writeback_data(inode) && test_opt(inode->i_sb, NOBH)) {
+		if (!PageUptodate(page)) {
+			err = mpage_readpage(page, ext3_get_block);
+			if ((err == 0) && !PageUptodate(page))
+				wait_on_page_locked(page);
+			lock_page(page);
+		}
+		if (err == 0 && PageUptodate(page)) {
+			kaddr = kmap_atomic(page, KM_USER0);
+			memset(kaddr + offset, 0, length);
+			flush_dcache_page(page);
+			kunmap_atomic(kaddr, KM_USER0);
+			__set_page_dirty_nobuffers(page);
+			goto unlock;
+		}
+		/* 
+		 * Well, we tried to work without buffers and failed.
+		 * Fallback to creating buffers
+		 */
+	}
+	
 	if (!page_has_buffers(page))
 		create_empty_buffers(page, blocksize, 0);
 
diff -Narup -Xdontdiff linux-2.6.10.org/fs/ext3/super.c linux-2.6.10.nobh/fs/ext3/super.c
--- linux-2.6.10.org/fs/ext3/super.c	2004-12-24 13:35:28.000000000 -0800
+++ linux-2.6.10.nobh/fs/ext3/super.c	2005-02-25 10:22:58.940466184 -0800
@@ -579,7 +579,7 @@ enum {
 	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic, Opt_err_ro,
 	Opt_nouid32, Opt_check, Opt_nocheck, Opt_debug, Opt_oldalloc, Opt_orlov,
 	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl,
-	Opt_reservation, Opt_noreservation, Opt_noload,
+	Opt_reservation, Opt_noreservation, Opt_noload, Opt_nobh,
 	Opt_commit, Opt_journal_update, Opt_journal_inum,
 	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
 	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
@@ -614,6 +614,7 @@ static match_table_t tokens = {
 	{Opt_reservation, "reservation"},
 	{Opt_noreservation, "noreservation"},
 	{Opt_noload, "noload"},
+	{Opt_nobh, "nobh"},
 	{Opt_commit, "commit=%u"},
 	{Opt_journal_update, "journal=update"},
 	{Opt_journal_inum, "journal=%u"},
@@ -923,6 +924,9 @@ clear_qf_name:
 			match_int(&args[0], &option);
 			*n_blocks_count = option;
 			break;
+		case Opt_nobh:
+			set_opt (sbi->s_mount_opt, NOBH);
+			break;
 		default:
 			printk (KERN_ERR
 				"EXT3-fs: Unrecognized mount option \"%s\" "
diff -Narup -Xdontdiff linux-2.6.10.org/include/linux/ext3_fs.h linux-2.6.10.nobh/include/linux/ext3_fs.h
--- linux-2.6.10.org/include/linux/ext3_fs.h	2004-12-24 13:34:58.000000000 -0800
+++ linux-2.6.10.nobh/include/linux/ext3_fs.h	2005-02-25 11:31:31.155700328 -0800
@@ -355,6 +355,7 @@ struct ext3_inode {
 #define EXT3_MOUNT_POSIX_ACL		0x08000	/* POSIX Access Control Lists */
 #define EXT3_MOUNT_RESERVATION		0x10000	/* Preallocation */
 #define EXT3_MOUNT_BARRIER		0x20000 /* Use block barriers */
+#define EXT3_MOUNT_NOBH		0x40000 /* No bufferheads */
 
 /* Compatibility, for having both ext2_fs.h and ext3_fs.h included at once */
 #ifndef _LINUX_EXT2_FS_H

--=-+vzWFDnspLdLPwmzTR7X--

