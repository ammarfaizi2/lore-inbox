Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287358AbRL3IDM>; Sun, 30 Dec 2001 03:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287360AbRL3IDD>; Sun, 30 Dec 2001 03:03:03 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:51465 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287358AbRL3ICy>; Sun, 30 Dec 2001 03:02:54 -0500
Message-ID: <3C2EC95A.79868A85@zip.com.au>
Date: Sat, 29 Dec 2001 23:59:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        torrey.hoffman@myrio.com, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrdkern   
 el panic woes
In-Reply-To: <3C2EBD62.6A98F670@zip.com.au> <Pine.GSO.4.21.0112300220490.8523-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> Erm...  I don't think so.  Come on - vmtruncate() is obvious candidate
> for out-of-line.  Please, look how it was done in 2.4.9-ac*.

Yeah, I thought that was just too damn ugly to make it out of my
ethernet port.  Oh well, let's try it anyway.

> BTW, fs/buffer.c part of patch looks mangled.

Looks OK to me.

Here's the latest.  It includes the block_write_full_page()
chunk (minus the access-bh-after-submit_bh bug which was in
the original).

So we have three chunks:

generic_file_write(): truncate the blocks when prepare_write()
fails.  This is for ENOSPC on write-to-end-of-file.

block_write_full_page(): submit the blocks which we managed
to map.  To prevent exposure of old data.

__block_prepare_write(): zero out and dirty the blocks which
we managed to instantiate.  This is to prevent exposure of
stale data on ENOSPC during write() to mid-file.


Question: is the block_write_full_page() change correct?  We
mark the page not-up-to-date, but end_buffer_io_async() is
going to mark it uptodate anyway.


And what should we do with BH_New?


--- linux-2.4.18-pre1/fs/buffer.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/fs/buffer.c	Sat Dec 29 23:39:11 2001
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
+			need_unlock = 0;
+		}
+		bh = bh->b_this_page;
+	} while (bh != head);
+	do {
+		struct buffer_head *next = bh->b_this_page;
+		if (buffer_mapped(bh)) {
+			set_buffer_async_io(bh);
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
+++ linux-akpm/mm/filemap.c	Sat Dec 29 23:44:03 2001
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
