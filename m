Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSCHWha>; Fri, 8 Mar 2002 17:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290689AbSCHWhV>; Fri, 8 Mar 2002 17:37:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21253 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289813AbSCHWhM>;
	Fri, 8 Mar 2002 17:37:12 -0500
Message-ID: <3C893CAE.A2FCFD@zip.com.au>
Date: Fri, 08 Mar 2002 14:35:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: truncate_list_pages()  BUG and confusion
In-Reply-To: <3C880EFF.A0789715@zip.com.au>,		<3C8809BA.4070003@us.ibm.com> <3C880EFF.A0789715@zip.com.au> <17920000.1015622098@flay> <3C8932CC.761C8829@zip.com.au> <3C89379B.4020107@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> Andrew Morton wrote:
> > If the page_cache_release() in truncate_complete_page() is calling
> > __free_pages_ok() then something really horrid has happened.
> 
> Something horrid _IS_ happening:
> 
> kernel BUG at page_alloc.c:109!
> ...
>  > Is this happening with the dbench/ENOSPC/1k blocksize testcase?
> yes
> 
> For this particular one, dbench ran without failure, but while rm'ing
> the leftover directories, it BUGged.

Are you also seeing the 'VFS: free of freed buffer' message?

There were some changes made in both 2.4 and 2.5 in this area.
These were to handle the situation where block allocation fails
when we're partway through mapping a page to disk.

Here's the 2.5 diff.  A `patch -R' of this will revert those
changes.

There are three independent parts to this - generic_file_write(),
block_write_full_page() and __block_prepare_write().  If reversion
of this entire patch makes the problem go away, then would you be
able to narrow it down to one of those three functions?


--- linux-2.5.5-pre1/fs/buffer.c	Wed Feb 13 15:22:00 2002
+++ 25/fs/buffer.c	Thu Feb 14 22:43:33 2002
@@ -1431,6 +1431,7 @@ static int __block_write_full_page(struc
 	int err, i;
 	unsigned long block;
 	struct buffer_head *bh, *head;
+	int need_unlock;
 
 	if (!PageLocked(page))
 		BUG();
@@ -1486,8 +1487,34 @@ static int __block_write_full_page(struc
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
 
@@ -1518,6 +1545,7 @@ static int __block_prepare_write(struct 
 			continue;
 		if (block_start >= to)
 			break;
+		clear_bit(BH_New, &bh->b_state);
 		if (!buffer_mapped(bh)) {
 			err = get_block(inode, block, bh, 1);
 			if (err)
@@ -1552,12 +1580,35 @@ static int __block_prepare_write(struct 
 	 */
 	while(wait_bh > wait) {
 		wait_on_buffer(*--wait_bh);
-		err = -EIO;
 		if (!buffer_uptodate(*wait_bh))
-			goto out;
+			return -EIO;
 	}
 	return 0;
 out:
+	/*
+	 * Zero out any newly allocated blocks to avoid exposing stale
+	 * data.  If BH_New is set, we know that the block was newly
+	 * allocated in the above loop.
+	 */
+	bh = head;
+	block_start = 0;
+	do {
+		block_end = block_start+blocksize;
+		if (block_end <= from)
+			goto next_bh;
+		if (block_start >= to)
+			break;
+		if (buffer_new(bh)) {
+			if (buffer_uptodate(bh))
+				printk(KERN_ERR "%s: zeroing uptodate buffer!\n", __FUNCTION__);
+			memset(kaddr+block_start, 0, bh->b_size);
+			set_bit(BH_Uptodate, &bh->b_state);
+			mark_buffer_dirty(bh);
+		}
+next_bh:
+		block_start = block_end;
+		bh = bh->b_this_page;
+	} while (bh != head);
 	return err;
 }
 
--- linux-2.5.5-pre1/mm/filemap.c	Sun Feb 10 22:00:36 2002
+++ 25/mm/filemap.c	Thu Feb 14 22:42:15 2002
@@ -2999,7 +2999,7 @@ generic_file_write(struct file *file,con
 		kaddr = kmap(page);
 		status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (status)
-			goto unlock;
+			goto sync_failure;
 		page_fault = __copy_from_user(kaddr+offset, buf, bytes);
 		flush_dcache_page(page);
 		status = mapping->a_ops->commit_write(file, page, offset, offset+bytes);
@@ -3024,6 +3024,7 @@ unlock:
 		if (status < 0)
 			break;
 	} while (count);
+done:
 	*ppos = pos;
 
 	if (cached_page)
@@ -3045,6 +3046,18 @@ out:
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


-
