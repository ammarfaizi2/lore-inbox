Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUGIEGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUGIEGd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 00:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUGIEGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 00:06:31 -0400
Received: from mail-relay-2.tiscali.it ([212.123.84.92]:11395 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S263802AbUGIEGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 00:06:25 -0400
Date: Fri, 9 Jul 2004 06:06:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Chris Mason <mason@suse.com>
Subject: Re: writepage fs corruption fixes
Message-ID: <20040709040611.GC20947@dualathlon.random>
References: <20040709040151.GB20947@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709040151.GB20947@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 06:01:51AM +0200, Andrea Arcangeli wrote:
> --- sles/fs/mpage.c.~1~	2004-07-05 03:08:08.000000000 +0200
> +++ sles/fs/mpage.c	2004-07-09 05:11:13.543787408 +0200
> @@ -105,7 +105,7 @@ mpage_alloc(struct block_device *bdev,
>  	bio = bio_alloc(gfp_flags, nr_vecs);
>  
>  	if (bio == NULL && (current->flags & PF_MEMALLOC)) {
> -		while (!bio && (nr_vecs /= 2))
> +		while (!bio && (nr_vecs /= 2) && nr_vecs)
>  			bio = bio_alloc(gfp_flags, nr_vecs);
>  	}
>  

the above change is a "noop", the above one wasn't really a bug (I just
misread the code), the rest of the patch is needed.  reattached after
filtering out the noop.

--- sles/fs/buffer.c.~1~	2004-07-05 03:08:09.000000000 +0200
+++ sles/fs/buffer.c	2004-07-09 05:16:47.544011656 +0200
@@ -1586,10 +1586,9 @@ __bread(struct block_device *bdev, secto
 EXPORT_SYMBOL(__bread);
 
 /*
- * invalidate_bh_lrus() is called rarely - at unmount.  Because it is only for
- * unmount it only needs to ensure that all buffers from the target device are
- * invalidated on return and it doesn't need to worry about new buffers from
- * that device being added - the unmount code has to prevent that.
+ * invalidate_bh_lrus() is called rarely - but not only at unmount.
+ * This doesn't race because it runs in each cpu either in irq
+ * or with preempt disabled.
  */
 static void invalidate_bh_lru(void *arg)
 {
@@ -1912,19 +1911,19 @@ static int __block_write_full_page(struc
 
 	BUG_ON(PageWriteback(page));
 	set_page_writeback(page);	/* Keeps try_to_free_buffers() away */
-	unlock_page(page);
-
 	/*
-	 * The page may come unlocked any time after the *first* submit_bh()
-	 * call.  Be careful with its buffers.
+	 * The page and its bh will not go away from under us
+	 * because we pinned all the bh with get_bh and we'll
+	 * release them only after we finished.
 	 */
+	unlock_page(page);
+
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
 			submit_bh(WRITE, bh);
 			nr_underway++;
 		}
-		put_bh(bh);
 		bh = next;
 	} while (bh != head);
 
@@ -1949,6 +1948,15 @@ done:
 		end_page_writeback(page);
 		wbc->pages_skipped++;	/* We didn't write this page */
 	}
+
+	/* can finally release the bh and after that the page can be freed */
+	bh = head;
+	do {
+		struct buffer_head *next = bh->b_this_page;
+		put_bh(bh);
+		bh = next;
+	} while (bh != head);
+
 	return err;
 
 recover:
@@ -1984,7 +1992,6 @@ recover:
 			submit_bh(WRITE, bh);
 			nr_underway++;
 		}
-		put_bh(bh);
 		bh = next;
 	} while (bh != head);
 	goto done;
--- sles/fs/mpage.c.~1~	2004-07-05 03:08:08.000000000 +0200
+++ sles/fs/mpage.c	2004-07-09 05:11:13.543787408 +0200
@@ -520,6 +520,17 @@ alloc_new:
 	}
 
 	/*
+	 * Must try to add the page before marking the buffer clean or
+	 * the confused fail path above (OOM) will be very confused when
+	 * it finds all bh marked clean (i.e. it will not write anything)
+	 */
+	length = first_unmapped << blkbits;
+	if (bio_add_page(bio, page, length, 0) < length) {
+		bio = mpage_bio_submit(WRITE, bio);
+		goto alloc_new;
+	}
+
+	/*
 	 * OK, we have our BIO, so we can now mark the buffers clean.  Make
 	 * sure to only clean buffers which we know we'll be writing.
 	 */
@@ -539,12 +550,6 @@ alloc_new:
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
