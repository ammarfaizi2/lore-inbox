Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288688AbSAELNn>; Sat, 5 Jan 2002 06:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288769AbSAELNl>; Sat, 5 Jan 2002 06:13:41 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:25617 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288688AbSAELNU>; Sat, 5 Jan 2002 06:13:20 -0500
Message-ID: <3C36DEA9.AEA2A402@zip.com.au>
Date: Sat, 05 Jan 2002 03:08:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>, Alexander Viro <viro@math.psu.edu>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] truncate fixes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the backport of the -ac truncate fixes we discussed
the other day.  All code paths have been tested and work OK.

Please review.

--- linux-2.4.18-pre1/fs/buffer.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/fs/buffer.c	Sat Jan  5 01:26:38 2002
@@ -1512,6 +1512,7 @@ static int __block_write_full_page(struc
 	int err, i;
 	unsigned long block;
 	struct buffer_head *bh, *head;
+	int need_unlock;
 
 	if (!PageLocked(page))
 		BUG();
@@ -1567,8 +1568,34 @@ static int __block_write_full_page(struc
 	return 0;
 
 out:
+	/*
+	 * ENOSPC, or some other error.  We may already have added some
+	 * blocks to the file, so we need to write these out to avoid
+	 * exposing stale data.
+	 */
 	ClearPageUptodate(page);
-	UnlockPage(page);
+	bh = head;
+	need_unlock = 1;
+	/* Recovery: lock and submit the mapped buffers */
+	do {
+		if (buffer_mapped(bh)) {
+			lock_buffer(bh);
+			set_buffer_async_io(bh);
+			need_unlock = 0;
+		}
+		bh = bh->b_this_page;
+	} while (bh != head);
+	do {
+		struct buffer_head *next = bh->b_this_page;
+		if (buffer_mapped(bh)) {
+			set_bit(BH_Uptodate, &bh->b_state);
+			clear_bit(BH_Dirty, &bh->b_state);
+			submit_bh(WRITE, bh);
+		}
+		bh = next;
+	} while (bh != head);
+	if (need_unlock)
+		UnlockPage(page);
 	return err;
 }
 
@@ -1639,6 +1666,17 @@ static int __block_prepare_write(struct 
 	}
 	return 0;
 out:
+	bh = head;
+	block_start = 0;
+	do {
+		if (buffer_new(bh) && !buffer_uptodate(bh)) {
+			memset(kaddr+block_start, 0, bh->b_size);
+			set_bit(BH_Uptodate, &bh->b_state);
+			mark_buffer_dirty(bh);
+		}
+		block_start += bh->b_size;
+		bh = bh->b_this_page;
+	} while (bh != head);
 	return err;
 }
 
--- linux-2.4.18-pre1/mm/filemap.c	Wed Dec 26 11:47:41 2001
+++ linux-akpm/mm/filemap.c	Sat Jan  5 01:26:50 2002
@@ -3004,7 +3004,7 @@ generic_file_write(struct file *file,con
 		kaddr = kmap(page);
 		status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (status)
-			goto unlock;
+			goto sync_failure;
 		page_fault = __copy_from_user(kaddr+offset, buf, bytes);
 		flush_dcache_page(page);
 		status = mapping->a_ops->commit_write(file, page, offset, offset+bytes);
@@ -3029,6 +3029,7 @@ unlock:
 		if (status < 0)
 			break;
 	} while (count);
+done:
 	*ppos = pos;
 
 	if (cached_page)
@@ -3050,6 +3051,18 @@ out:
 fail_write:
 	status = -EFAULT;
 	goto unlock;
+
+sync_failure:
+	/*
+	 * If blocksize < pagesize, prepare_write() may have instantiated a
+	 * few blocks outside i_size.  Trim these off again.
+	 */
+	kunmap(page);
+	UnlockPage(page);
+	page_cache_release(page);
+	if (pos + bytes > inode->i_size)
+		vmtruncate(inode, inode->i_size);
+	goto done;
 
 o_direct:
 	written = generic_file_direct_IO(WRITE, file, (char *) buf, count, pos);
