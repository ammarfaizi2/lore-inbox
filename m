Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266283AbTHZGn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 02:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbTHZGn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 02:43:26 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:52185 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264906AbTHZGnG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 02:43:06 -0400
Date: Tue, 26 Aug 2003 12:18:27 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Fw: [PATCH][2.6-mm] More AIO O_SYNC related fixes
Message-ID: <20030826064827.GA4265@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Suparna Bhattacharya <suparna@in.ibm.com> -----

Date: Tue, 26 Aug 2003 12:04:33 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org
Subject: [PATCH][2.6-mm] More AIO O_SYNC related fixes
Reply-To: suparna@in.ibm.com

The attached patch plugs some inaccuracies and associated
inefficiencies in sync_page_range handling for AIO 
O_SYNC writes.

- Correctly propagate the return value from sync_page_range
  when some but not all pages in the range have completed
  writeback (Otherwise, O_SYNC AIO writes could report
  completion before all the relevant writeouts actually 
  completed)
- Reset and check page dirty settings prior to attempting
  writeouts to avoid blocking synchronously for a writeback
  initiated otherwise.
- Disable repeated calls to writeout or generic_osync_inode
  during AIO retries for the same iocb.
- Don't block synchronously for data writeouts to complete
  when writing out inode state for generic_osync_inode in
  AIO context. The wait_on_page_range call after this will
  take care of completing the iocb only after the data has
  been written out. [TBD: Is this particular change OK for 
  data=ordered, or does it need rethinking ?]

I have run aio-stress with modifications for AIO O_SYNC 
writes on ext2, ext3, jfs, xfs and blockdev.

Regards
Suparna
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India


diff -ur -X dontdiff pure-mm3/fs/fs-writeback.c linux-2.6.0-test3-mm1/fs/fs-writeback.c
--- pure-mm3/fs/fs-writeback.c	Mon Aug 25 16:59:50 2003
+++ linux-2.6.0-test3-mm1/fs/fs-writeback.c	Mon Aug 25 20:47:34 2003
@@ -162,7 +162,7 @@
 	if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
 		write_inode(inode, wait);
 
-	if (wait)
+	if (wait && !in_aio())
 		filemap_fdatawait(mapping);
 
 	spin_lock(&inode_lock);
diff -ur -X dontdiff pure-mm3/include/linux/aio.h linux-2.6.0-test3-mm1/include/linux/aio.h
--- pure-mm3/include/linux/aio.h	Mon Aug 25 17:00:40 2003
+++ linux-2.6.0-test3-mm1/include/linux/aio.h	Wed Aug 20 16:31:53 2003
@@ -29,21 +29,26 @@
 #define KIF_LOCKED		0
 #define KIF_KICKED		1
 #define KIF_CANCELLED		2
+#define KIF_SYNCED		3
 
 #define kiocbTryLock(iocb)	test_and_set_bit(KIF_LOCKED, &(iocb)->ki_flags)
 #define kiocbTryKick(iocb)	test_and_set_bit(KIF_KICKED, &(iocb)->ki_flags)
+#define kiocbTrySync(iocb)	test_and_set_bit(KIF_SYNCED, &(iocb)->ki_flags)
 
 #define kiocbSetLocked(iocb)	set_bit(KIF_LOCKED, &(iocb)->ki_flags)
 #define kiocbSetKicked(iocb)	set_bit(KIF_KICKED, &(iocb)->ki_flags)
 #define kiocbSetCancelled(iocb)	set_bit(KIF_CANCELLED, &(iocb)->ki_flags)
+#define kiocbSetSynced(iocb)	set_bit(KIF_SYNCED, &(iocb)->ki_flags)
 
 #define kiocbClearLocked(iocb)	clear_bit(KIF_LOCKED, &(iocb)->ki_flags)
 #define kiocbClearKicked(iocb)	clear_bit(KIF_KICKED, &(iocb)->ki_flags)
 #define kiocbClearCancelled(iocb)	clear_bit(KIF_CANCELLED, &(iocb)->ki_flags)
+#define kiocbClearSynced(iocb)	clear_bit(KIF_SYNCED, &(iocb)->ki_flags)
 
 #define kiocbIsLocked(iocb)	test_bit(KIF_LOCKED, &(iocb)->ki_flags)
 #define kiocbIsKicked(iocb)	test_bit(KIF_KICKED, &(iocb)->ki_flags)
 #define kiocbIsCancelled(iocb)	test_bit(KIF_CANCELLED, &(iocb)->ki_flags)
+#define kiocbIsSynced(iocb)	test_bit(KIF_SYNCED, &(iocb)->ki_flags)
 
 struct kiocb {
 	struct list_head	ki_run_list;
diff -ur -X dontdiff pure-mm3/mm/filemap.c linux-2.6.0-test3-mm1/mm/filemap.c
--- pure-mm3/mm/filemap.c	Mon Aug 25 16:59:28 2003
+++ linux-2.6.0-test3-mm1/mm/filemap.c	Mon Aug 25 20:48:45 2003
@@ -1950,13 +1944,9 @@
 
 osync:
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
-		ssize_t err;
-
-		err = sync_page_range_nolock(inode, mapping, pos, ret);
-		if (err < 0)
-			ret = err;
-		else
-			*ppos = pos + err;
+		ret = sync_page_range_nolock(inode, mapping, pos, ret);
+		if (ret >= 0)
+			*ppos = pos + ret;
 	}
 	return ret;
 }
@@ -2020,13 +2012,9 @@
 
 osync:
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
-		ssize_t err;
-
-		err = sync_page_range(inode, mapping, pos, ret);
-		if (err < 0)
-			ret = err;
-		else
-			iocb->ki_pos = pos + err;
+		ret = sync_page_range(inode, mapping, pos, ret);
+		if (ret >= 0)
+			iocb->ki_pos = pos + ret;
 	}
 	return ret;
 }
diff -ur -X dontdiff pure-mm3/mm/page-writeback.c linux-2.6.0-test3-mm1/mm/page-writeback.c
--- pure-mm3/mm/page-writeback.c	Mon Aug 25 16:59:35 2003
+++ linux-2.6.0-test3-mm1/mm/page-writeback.c	Mon Aug 25 20:49:55 2003
@@ -641,6 +641,10 @@
 		.nr_to_write	= 1,
 	};
 
+	if (!test_clear_page_dirty(page)) {
+		unlock_page(page);
+		return 0;
+	}
 	wait_on_page_writeback(page);
 	return page->mapping->a_ops->writepage(page, &wbc);
 }
@@ -662,8 +666,13 @@
 ssize_t sync_page_range(struct inode *inode, struct address_space *mapping,
 			loff_t pos, size_t count)
 {
-	int ret;
+	int ret = 0;
 
+	if (in_aio()) {
+		/* Already issued writeouts for this iocb ? */
+		if (kiocbTrySync(io_wait_to_kiocb(current->io_wait)))
+			goto do_wait; /* just need to check if done */
+	}
 	if (!mapping->a_ops->writepage)
 		return 0;
 	if (mapping->backing_dev_info->memory_backed)
@@ -674,6 +683,7 @@
 		ret = generic_osync_inode(inode, OSYNC_METADATA);
 		up(&inode->i_sem);
 	}
+do_wait:
 	if (ret >= 0)
 		ret = wait_on_page_range(mapping, pos, count);
 	return ret;
@@ -688,8 +698,13 @@
 ssize_t sync_page_range_nolock(struct inode *inode, struct address_space
 	*mapping, loff_t pos, size_t count)
 {
-	int ret;
+	ssize_t ret = 0;
 
+	if (in_aio()) {
+		/* Already issued writeouts for this iocb ? */
+		if (kiocbTrySync(io_wait_to_kiocb(current->io_wait)))
+			goto do_wait; /* just need to check if done */
+	}
 	if (!mapping->a_ops->writepage)
 		return 0;
 	if (mapping->backing_dev_info->memory_backed)
@@ -698,6 +713,7 @@
 	if (ret >= 0) {
 		ret = generic_osync_inode(inode, OSYNC_METADATA);
 	}
+do_wait:
 	if (ret >= 0)
 		ret = wait_on_page_range(mapping, pos, count);
 	return ret;


----- End forwarded message -----

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

