Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965334AbWKDL5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965334AbWKDL5S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 06:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965329AbWKDL5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 06:57:18 -0500
Received: from ns2.suse.de ([195.135.220.15]:63449 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965332AbWKDL5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 06:57:17 -0500
Date: Sat, 4 Nov 2006 12:57:05 +0100
From: Nick Piggin <npiggin@suse.de>
To: linux-fsdevel@vger.kernel.org, Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, swhiteho@redhat.com, bjornw@axis.com,
       reiserfs-dev@namesys.com, chris.mason@oracle.com
Subject: Re: [RFC] commit_write less than prepared by prepare_write
Message-ID: <20061104115705.GA27707@wotan.suse.de>
References: <20061022084020.GA23506@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061022084020.GA23506@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 10:40:20AM +0200, Nick Piggin wrote:
> For the non-uptodate page:
> We can't run a full length commit_write, because the data in the page is
> uninitialised. Can't zero out the uninitialised data, because that would
> lead to zeros temporarily appearing in the pagecache. Any other ways to
> fix it?
> 
> The problem with doing a short commit, as noted by Mark Fasheh, is that
> prepare_write might have allocated a disk mapping (eg. if we write over a
> hole), and if the commit fails and we unlock the page, then a read from
> the filesystem might think that is valid data.
> 
> Mark's idea is to loop through the page buffers and zero out the
> buffer_new ones when the caller detects a fault here. This should work
> because a hole is zeroes anyway, so we could mark the page uptodate and it
> would eventually get written back to initialise those blocks. But, is
> there any other filesystem specific state that would need to be fixed
> up? Do we need another filesystem call?
> 
> I would prefer that disk block allocation be performed at commit_write
> time. I realise that is probably a lot more rework, and there may be
> reasons why it can't be done?
> 
> Another alternative is to pre-read the page in prepare_write, which
> should always get us out of trouble. Could be a good option for
> simple filesystems. People who care about performance probably want to
> avoid this.
> 
> Any other ideas?

OK, so I was able to pretty easily reproduce the stale data problem
with CONFIG_DEBUG_VM turned on (if anyone wants a copy of the test
program, let me know privately).

The following patch attempts to implement Mark's idea, and does seem
to work for ext2 bh. nobh seem to be broken in a non-trivial way.
Because we discard the bh, we don't know that we might have just allocated
under a hole. The old "error handling" zeroed out the entire page which,
AFAIKS, could destroy existing data. My patches in -mm ripped this out
which introduces the same sort of stale data problem as when doing a
zero length commit (arguably better? probably not: one is data corruption,
the other is a data corruption + information leak).

So nobh isn't fixed, but a note is made of it. I think it was broken when
I got there, though?

Are there any other filesystems that don't mark buffer_new properly, and
also don't zero out allocated holes? If so, I think they are also broken
before I did anything (think -EFAULT case).

Nick
--
Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1951,7 +1951,7 @@ retry_noprogress:
 						bytes);
 		dec_preempt_count();
 
-		if (!PageUptodate(page)) {
+		if (unlikely(copied != bytes)) {
 			/*
 			 * If the page is not uptodate, we cannot allow a
 			 * partial commit_write because when we unlock the
@@ -1967,9 +1967,15 @@ retry_noprogress:
 			 * single-segment path below, which should get the
 			 * filesystem to bring the page uputodate for us next
 			 * time.
+			 *
+			 * Must zero out new buffers here so that we do end
+			 * up properly filling holes rather than leaving stale
+			 * data in them that might be read in future.
 			 */
-			if (unlikely(copied != bytes))
+			if (!PageUptodate(page)) {
+				page_zero_new_buffers(page);
 				copied = 0;
+			}
 		}
 
 		flush_dcache_page(page);
Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -1491,6 +1491,38 @@ out:
 }
 EXPORT_SYMBOL(block_invalidatepage);
 
+void page_zero_new_buffers(struct page *page)
+{
+	unsigned int block_start, block_end;
+	struct buffer_head *head, *bh;
+
+	BUG_ON(!PageLocked(page));
+	BUG_ON(PageUptodate(page));
+	if (!page_has_buffers(page))
+		return;
+
+	bh = head = page_buffers(page);
+	block_start = 0;
+	do {
+		block_end = block_start + bh->b_size;
+
+		if (buffer_new(bh)) {
+			void *kaddr;
+
+			kaddr = kmap_atomic(page, KM_USER0);
+			memset(kaddr+block_start, 0, bh->b_size);
+			flush_dcache_page(page);
+			kunmap_atomic(kaddr, KM_USER0);
+			clear_buffer_new(bh);
+			set_buffer_uptodate(bh);
+			mark_buffer_dirty(bh);
+		}
+
+		block_start = block_end;
+		bh = bh->b_this_page;
+	} while (bh != head);
+}
+
 /*
  * We attach and possibly dirty the buffers atomically wrt
  * __set_page_dirty_buffers() via private_lock.  try_to_free_buffers
@@ -1784,36 +1816,33 @@ static int __block_prepare_write(struct 
 			}
 			continue;
 		}
-		if (buffer_new(bh))
-			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
 			WARN_ON(bh->b_size != blocksize);
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				break;
-			if (buffer_new(bh)) {
-				unmap_underlying_metadata(bh->b_bdev,
-							bh->b_blocknr);
-				if (PageUptodate(page)) {
-					set_buffer_uptodate(bh);
-					continue;
-				}
-				if (block_end > to || block_start < from) {
-					void *kaddr;
-
-					kaddr = kmap_atomic(page, KM_USER0);
-					if (block_end > to)
-						memset(kaddr+to, 0,
-							block_end-to);
-					if (block_start < from)
-						memset(kaddr+block_start,
-							0, from-block_start);
-					flush_dcache_page(page);
-					kunmap_atomic(kaddr, KM_USER0);
-				}
+		}
+		if (buffer_new(bh)) {
+			unmap_underlying_metadata(bh->b_bdev, bh->b_blocknr);
+			if (PageUptodate(page)) {
+				set_buffer_uptodate(bh);
 				continue;
 			}
+			if (block_end > to || block_start < from) {
+				void *kaddr;
+
+				kaddr = kmap_atomic(page, KM_USER0);
+				if (block_end > to)
+					memset(kaddr+to, 0, block_end-to);
+				if (block_start < from)
+					memset(kaddr+block_start,
+							0, from-block_start);
+				flush_dcache_page(page);
+				kunmap_atomic(kaddr, KM_USER0);
+			}
+			continue;
 		}
+
 		if (PageUptodate(page)) {
 			if (!buffer_uptodate(bh))
 				set_buffer_uptodate(bh);
@@ -1833,43 +1862,10 @@ static int __block_prepare_write(struct 
 		if (!buffer_uptodate(*wait_bh))
 			err = -EIO;
 	}
-	if (!err) {
-		bh = head;
-		do {
-			if (buffer_new(bh))
-				clear_buffer_new(bh);
-		} while ((bh = bh->b_this_page) != head);
-		return 0;
-	}
-	/* Error case: */
-	/*
-	 * Zero out any newly allocated blocks to avoid exposing stale
-	 * data.  If BH_New is set, we know that the block was newly
-	 * allocated in the above loop.
-	 */
-	bh = head;
-	block_start = 0;
-	do {
-		block_end = block_start+blocksize;
-		if (block_end <= from)
-			goto next_bh;
-		if (block_start >= to)
-			break;
-		if (buffer_new(bh)) {
-			void *kaddr;
 
-			clear_buffer_new(bh);
-			kaddr = kmap_atomic(page, KM_USER0);
-			memset(kaddr+block_start, 0, bh->b_size);
-			flush_dcache_page(page);
-			kunmap_atomic(kaddr, KM_USER0);
-			set_buffer_uptodate(bh);
-			mark_buffer_dirty(bh);
-		}
-next_bh:
-		block_start = block_end;
-		bh = bh->b_this_page;
-	} while (bh != head);
+	if (err)
+		page_zero_new_buffers(page);
+
 	return err;
 }
 
@@ -2246,7 +2242,6 @@ int nobh_prepare_write(struct page *page
 	int i;
 	int ret = 0;
 	int is_mapped_to_disk = 1;
-	int dirtied_it = 0;
 
 	if (PageMappedToDisk(page))
 		return 0;
@@ -2282,15 +2277,16 @@ int nobh_prepare_write(struct page *page
 		if (PageUptodate(page))
 			continue;
 		if (buffer_new(&map_bh) || !buffer_mapped(&map_bh)) {
+			/*
+			 * XXX: stale data can be exposed as we are not zeroing
+			 * out newly allocated blocks. If a subsequent operation
+			 * fails, we'll never know about this :(
+			 */
 			kaddr = kmap_atomic(page, KM_USER0);
-			if (block_start < from) {
-				memset(kaddr+block_start, 0, from-block_start);
-				dirtied_it = 1;
-			}
-			if (block_end > to) {
+			if (block_start < from)
+				memset(kaddr+block_start, 0, block_end-block_start);
+			if (block_end > to)
 				memset(kaddr + to, 0, block_end - to);
-				dirtied_it = 1;
-			}
 			flush_dcache_page(page);
 			kunmap_atomic(kaddr, KM_USER0);
 			continue;
Index: linux-2.6/include/linux/buffer_head.h
===================================================================
--- linux-2.6.orig/include/linux/buffer_head.h
+++ linux-2.6/include/linux/buffer_head.h
@@ -151,6 +151,7 @@ struct buffer_head *alloc_page_buffers(s
 		int retry);
 void create_empty_buffers(struct page *, unsigned long,
 			unsigned long b_state);
+void page_zero_new_buffers(struct page *page);
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
 

