Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVGQRmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVGQRmD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 13:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVGQRmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 13:42:02 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:53899 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261342AbVGQRlx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 13:41:53 -0400
Subject: [RFC] [PATCH 2/4]delayed allocation for ext3
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: ext2-devel <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Cc: Badari Pulavarty <pbadari@us.ibm.com>, suparna@in.ibm.com, tytso@mit.edu
In-Reply-To: <1110839154.24286.302.camel@dyn318077bld.beaverton.ibm.com>
References: <1110839154.24286.302.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Sun, 17 Jul 2005 10:40:41 -0700
Message-Id: <1121622041.4609.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the updated patch from Badari for delayed allocation for ext3.
Delayed allocation defers block allocation from prepare-write time to
page writeout time. 


---

 linux-2.6.12-ming/fs/buffer.c             |   13 +++++++++----
 linux-2.6.12-ming/fs/ext3/inode.c         |    6 ++++++
 linux-2.6.12-ming/fs/ext3/super.c         |   14 +++++++++++++-
 linux-2.6.12-ming/include/linux/ext3_fs.h |    1 +
 4 files changed, 29 insertions(+), 5 deletions(-)

diff -puN include/linux/ext3_fs.h~ext3-delalloc include/linux/ext3_fs.h
--- linux-2.6.12/include/linux/ext3_fs.h~ext3-delalloc	2005-07-14 23:15:34.861753240 -0700
+++ linux-2.6.12-ming/include/linux/ext3_fs.h	2005-07-14 23:15:34.881750200 -0700
@@ -373,6 +373,7 @@ struct ext3_inode {
 #define EXT3_MOUNT_BARRIER		0x20000 /* Use block barriers */
 #define EXT3_MOUNT_NOBH			0x40000 /* No bufferheads */
 #define EXT3_MOUNT_QUOTA		0x80000 /* Some quota option set */
+ #define EXT3_MOUNT_DELAYED_ALLOC	0xC0000 /* Delayed Allocation */
 
 /* Compatibility, for having both ext2_fs.h and ext3_fs.h included at once */
 #ifndef _LINUX_EXT2_FS_H
diff -puN fs/ext3/inode.c~ext3-delalloc fs/ext3/inode.c
--- linux-2.6.12/fs/ext3/inode.c~ext3-delalloc	2005-07-14 23:15:34.866752480 -0700
+++ linux-2.6.12-ming/fs/ext3/inode.c	2005-07-14 23:15:34.889748984 -0700
@@ -1340,6 +1340,9 @@ static int ext3_prepare_write(struct fil
 	handle_t *handle;
 	int retries = 0;
 
+
+	if (test_opt(inode->i_sb, DELAYED_ALLOC))
+		return __nobh_prepare_write(page, from, to, ext3_get_block, 0);
 retry:
 	handle = ext3_journal_start(inode, needed_blocks);
 	if (IS_ERR(handle)) {
@@ -1439,6 +1442,9 @@ static int ext3_writeback_commit_write(s
 	else
 		ret = generic_commit_write(file, page, from, to);
 
+	if (test_opt(inode->i_sb, DELAYED_ALLOC))
+		return ret;
+
 	ret2 = ext3_journal_stop(handle);
 	if (!ret)
 		ret = ret2;
diff -puN fs/ext3/super.c~ext3-delalloc fs/ext3/super.c
--- linux-2.6.12/fs/ext3/super.c~ext3-delalloc	2005-07-14 23:15:34.870751872 -0700
+++ linux-2.6.12-ming/fs/ext3/super.c	2005-07-14 23:15:34.896747920 -0700
@@ -585,7 +585,7 @@ enum {
 	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic, Opt_err_ro,
 	Opt_nouid32, Opt_check, Opt_nocheck, Opt_debug, Opt_oldalloc, Opt_orlov,
 	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl,
-	Opt_reservation, Opt_noreservation, Opt_noload, Opt_nobh,
+	Opt_reservation, Opt_noreservation, Opt_noload, Opt_nobh, Opt_delayed_alloc,
 	Opt_commit, Opt_journal_update, Opt_journal_inum,
 	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
 	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
@@ -621,6 +621,7 @@ static match_table_t tokens = {
 	{Opt_noreservation, "noreservation"},
 	{Opt_noload, "noload"},
 	{Opt_nobh, "nobh"},
+	{Opt_delayed_alloc, "delalloc"},
 	{Opt_commit, "commit=%u"},
 	{Opt_journal_update, "journal=update"},
 	{Opt_journal_inum, "journal=%u"},
@@ -954,6 +955,10 @@ clear_qf_name:
 		case Opt_nobh:
 			set_opt(sbi->s_mount_opt, NOBH);
 			break;
+		case Opt_delayed_alloc:
+			set_opt(sbi->s_mount_opt, NOBH);
+			set_opt(sbi->s_mount_opt, DELAYED_ALLOC);
+			break;
 		default:
 			printk (KERN_ERR
 				"EXT3-fs: Unrecognized mount option \"%s\" "
@@ -1612,6 +1617,13 @@ static int ext3_fill_super (struct super
 			clear_opt(sbi->s_mount_opt, NOBH);
 		}
 	}
+	if (test_opt(sb, DELAYED_ALLOC)) {
+		if (!(test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_WRITEBACK_DATA)) {
+			printk(KERN_WARNING "EXT3-fs: Ignoring delall option - "
+				"its supported only with writeback mode\n");
+			clear_opt(sbi->s_mount_opt, DELAYED_ALLOC);
+		}
+	}
 	/*
 	 * The journal_load will have done any necessary log recovery,
 	 * so we can safely mount the rest of the filesystem now.
diff -puN fs/buffer.c~ext3-delalloc fs/buffer.c
--- linux-2.6.12/fs/buffer.c~ext3-delalloc	2005-07-14 23:15:34.875751112 -0700
+++ linux-2.6.12-ming/fs/buffer.c	2005-07-14 23:15:34.903746856 -0700
@@ -2337,8 +2337,8 @@ static void end_buffer_read_nobh(struct 
  * On entry, the page is fully not uptodate.
  * On exit the page is fully uptodate in the areas outside (from,to)
  */
-int nobh_prepare_write(struct page *page, unsigned from, unsigned to,
-			get_block_t *get_block)
+int __nobh_prepare_write(struct page *page, unsigned from, unsigned to,
+			get_block_t *get_block, int create)
 {
 	struct inode *inode = page->mapping->host;
 	const unsigned blkbits = inode->i_blkbits;
@@ -2370,10 +2370,8 @@ int nobh_prepare_write(struct page *page
 		  block_start < PAGE_CACHE_SIZE;
 		  block_in_page++, block_start += blocksize) {
 		unsigned block_end = block_start + blocksize;
-		int create;
 
 		map_bh.b_state = 0;
-		create = 1;
 		if (block_start >= to)
 			create = 0;
 		ret = get_block(inode, block_in_file + block_in_page,
@@ -2482,6 +2480,13 @@ failed:
 	set_page_dirty(page);
 	return ret;
 }
+
+int nobh_prepare_write(struct page *page, unsigned from, unsigned to,
+			get_block_t *get_block)
+{
+	return __nobh_prepare_write(page, from, to, get_block, 1);
+}
+
 EXPORT_SYMBOL(nobh_prepare_write);
 
 int nobh_commit_write(struct file *file, struct page *page,

_


