Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266138AbUGJE7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266138AbUGJE7w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 00:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUGJE7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 00:59:52 -0400
Received: from mail-relay-3.tiscali.it ([212.123.84.93]:24522 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S266138AbUGJE7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 00:59:36 -0400
Date: Sat, 10 Jul 2004 06:59:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mason@suse.com
Subject: Re: writepage fs corruption fixes
Message-ID: <20040710045920.GY20947@dualathlon.random>
References: <20040709040151.GB20947@dualathlon.random> <20040708212923.406135f0.akpm@osdl.org> <20040709044205.GF20947@dualathlon.random> <20040708215645.16d0f227.akpm@osdl.org> <20040710001600.GT20947@dualathlon.random> <20040710010738.GX20947@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710010738.GX20947@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 03:07:38AM +0200, Andrea Arcangeli wrote:
> On Sat, Jul 10, 2004 at 02:16:00AM +0200, Andrea Arcangeli wrote:
> > I hope this time I'm done with it.
> 
> I'm not after more thinking it seems the below is not a bug.
> 
> I'm lost since I can't find bugs anymore in this function but I need to
> find something.

Ok, this is the last try (at least for this week ;), if this doesn't fix
anything too then I giveup and I will reasonably start to suspect/blame
on the compiler early next week ;).

I believe reading the i_size from memory multiple times can generate fs
corruption. The "offset" and the "end_index" were not coherent. this is
writepages and it runs w/o the i_sem, so the i_size can change from
under us anytime. If a parallel write happens while writepages run, the
i_size could advance from 4095 to 4100. With the current 2.6 code that
could translate in end_index = 0 and offset = 4. That's broken because
end_index and offset could be not coherent. Either end_index=1 and
offset =4, or end_index = 0 and offset = 4095. When they lose coherency
the memset can zeroout actual data. The below patch fixes that (it's at
least a theoretical bug).

I don't really expect this tiny race to fix the bug in practice after the
more serious bugs we covered yesterday didn't fix it (more likely the
compiler will get involved into the equation soon ;).

This is also an optimization for 32bit archs that needs special locking
to read 64bit i_size coherenty.

This also includes Chris's fix (which looks valid to me), and it
includes my yesterday's fix for the memory-pressure on the mempool bio
allocator with GFP_NOFS.

--- sles/fs/mpage.c.~1~	2004-07-09 23:48:33.233205496 +0200
+++ sles/fs/mpage.c	2004-07-10 06:32:24.784449776 +0200
@@ -404,6 +404,7 @@ mpage_writepage(struct bio *bio, struct 
 	struct block_device *boundary_bdev = NULL;
 	int length;
 	struct buffer_head map_bh;
+	loff_t i_size = i_size_read(inode);
 
 	if (page_has_buffers(page)) {
 		struct buffer_head *head = page_buffers(page);
@@ -460,7 +461,7 @@ mpage_writepage(struct bio *bio, struct 
 	 */
 	BUG_ON(!PageUptodate(page));
 	block_in_file = page->index << (PAGE_CACHE_SHIFT - blkbits);
-	last_block = (i_size_read(inode) - 1) >> blkbits;
+	last_block = (i_size - 1) >> blkbits;
 	map_bh.b_page = page;
 	for (page_block = 0; page_block < blocks_per_page; ) {
 
@@ -490,9 +491,11 @@ mpage_writepage(struct bio *bio, struct 
 
 	first_unmapped = page_block;
 
-	end_index = i_size_read(inode) >> PAGE_CACHE_SHIFT;
+page_is_mapped:
+
+	end_index = i_size >> PAGE_CACHE_SHIFT;
 	if (page->index >= end_index) {
-		unsigned offset = i_size_read(inode) & (PAGE_CACHE_SIZE - 1);
+		unsigned offset = i_size & (PAGE_CACHE_SIZE - 1);
 		char *kaddr;
 
 		if (page->index > end_index || !offset)
@@ -503,8 +506,6 @@ mpage_writepage(struct bio *bio, struct 
 		kunmap_atomic(kaddr, KM_USER0);
 	}
 
-page_is_mapped:
-
 	/*
 	 * This page will go to BIO.  Do we need to send this BIO off first?
 	 */
@@ -519,6 +520,12 @@ alloc_new:
 			goto confused;
 	}
 
+	length = first_unmapped << blkbits;
+	if (bio_add_page(bio, page, length, 0) < length) {
+		bio = mpage_bio_submit(WRITE, bio);
+		goto alloc_new;
+	}
+
 	/*
 	 * OK, we have our BIO, so we can now mark the buffers clean.  Make
 	 * sure to only clean buffers which we know we'll be writing.
@@ -539,12 +546,6 @@ alloc_new:
 			try_to_free_buffers(page);
 	}
 
-	length = first_unmapped << blkbits;
-	if (bio_add_page(bio, page, length, 0) < length) {
-		bio = mpage_bio_submit(WRITE, bio);
-		goto alloc_new;
-	}
-
 	BUG_ON(PageWriteback(page));
 	set_page_writeback(page);
 	unlock_page(page);
