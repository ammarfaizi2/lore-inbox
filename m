Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262619AbREZJIF>; Sat, 26 May 2001 05:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262623AbREZJHz>; Sat, 26 May 2001 05:07:55 -0400
Received: from [209.10.41.242] ([209.10.41.242]:46286 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262619AbREZJHm>;
	Sat, 26 May 2001 05:07:42 -0400
Date: Sat, 26 May 2001 02:01:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.21.0105260101370.1901-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105260136010.2001-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 May 2001, Linus Torvalds wrote:
> 
> There's _one_ line of your patch special-cases GFP_BUFFER in page_alloc
> and protects the reserves, but the point is that they shouldn't need
> protecting: there's something else wrong that makes them be depleted in
> the first place. 

In fact, there seems to be a major confusion about the use of GFP_BUFFER
around the kernel.

The kernel uses GFP_BUFFER in a few places:

 - grow_buffers(), as called from bread() and friends.

   Here it is correct: we use GFP_BUFFER because we must not cause a
   deadlock on various filesystem datastructures, and whena filesystem
   does a bread() we'd better _never_ cause a writeout that could cause
   some nasty FS lock self-deadlock.

 - creating buffer heads on pages for the page cache uses SLAB_BUFFER.

   This is bogus. It should use SLAB_KERNEL here, because this is not
   called by low-level filesystems, it's called by the VM layer, and we
   don't hold any magic locks or anything like that.

The code actually has some comments to this effect, but is confusing the
issue of "async" and "sync", and that confusion makes the code (a) not
dare do the right thing (there's an attempt that is #ifdef'ed out), and
(b) even the right thing is kind of confused.

I'm leaving for Japan, so this is the last I'll write on this, but as a
request-for-discussion, what about this patch? Does it help? It should
decrease the GFP_BUFFER pressure noticeably (yeah, I removed too much of
the error handling code, but it shouldn't be all that noticeable when
using SLAB_KERNEL, as the allocations should succeed until the machine is
_so_ low on memory that it is truly dead).

Now, this is obviously untested and does a bit too much surgery, but I
really think that the reason for the deadlock is because buffer allocation
itself does things wrong, not so much that we should try to keep infinite
reserves. 

Anybody want to play with these kinds of approaches? Fixing the underlying
problems instead of trying to hide them with special reserve cases...

		Linus

-----
--- v2.4.5/linux/fs/buffer.c	Fri May 25 18:28:55 2001
+++ linux/fs/buffer.c	Sat May 26 01:52:43 2001
@@ -1206,7 +1206,7 @@
  * no-buffer-head deadlock.  Return NULL on failure; waiting for
  * buffer heads is now handled in create_buffers().
  */ 
-static struct buffer_head * get_unused_buffer_head(int async)
+static struct buffer_head * get_unused_buffer_head(int can_do_io)
 {
 	struct buffer_head * bh;
 
@@ -1220,46 +1220,7 @@
 	}
 	spin_unlock(&unused_list_lock);
 
-	/* This is critical.  We can't swap out pages to get
-	 * more buffer heads, because the swap-out may need
-	 * more buffer-heads itself.  Thus SLAB_BUFFER.
-	 */
-	if((bh = kmem_cache_alloc(bh_cachep, SLAB_BUFFER)) != NULL) {
-		bh->b_blocknr = -1;
-		bh->b_this_page = NULL;
-		return bh;
-	}
-
-	/*
-	 * If we need an async buffer, use the reserved buffer heads.
-	 */
-	if (async) {
-		spin_lock(&unused_list_lock);
-		if (unused_list) {
-			bh = unused_list;
-			unused_list = bh->b_next_free;
-			nr_unused_buffer_heads--;
-			spin_unlock(&unused_list_lock);
-			return bh;
-		}
-		spin_unlock(&unused_list_lock);
-	}
-#if 0
-	/*
-	 * (Pending further analysis ...)
-	 * Ordinary (non-async) requests can use a different memory priority
-	 * to free up pages. Any swapping thus generated will use async
-	 * buffer heads.
-	 */
-	if(!async &&
-	   (bh = kmem_cache_alloc(bh_cachep, SLAB_KERNEL)) != NULL) {
-		memset(bh, 0, sizeof(*bh));
-		init_waitqueue_head(&bh->b_wait);
-		return bh;
-	}
-#endif
-
-	return NULL;
+	return kmem_cache_alloc(bh_cachep, can_do_io ? SLAB_KERNEL : SLAB_BUFFER);
 }
 
 void set_bh_page (struct buffer_head *bh, struct page *page, unsigned long offset)
@@ -1285,16 +1246,16 @@
  * from ordinary buffer allocations, and only async requests are allowed
  * to sleep waiting for buffer heads. 
  */
-static struct buffer_head * create_buffers(struct page * page, unsigned long size, int async)
+static struct buffer_head * create_buffers(struct page * page, unsigned long size, int can_do_io)
 {
 	struct buffer_head *bh, *head;
 	long offset;
 
-try_again:
 	head = NULL;
 	offset = PAGE_SIZE;
 	while ((offset -= size) >= 0) {
-		bh = get_unused_buffer_head(async);
+		bh = get_unused_buffer_head(can_do_io);
+		/* Can return failure in the "!can_do_io" case */
 		if (!bh)
 			goto no_grow;
 
@@ -1331,29 +1292,7 @@
 		wake_up(&buffer_wait);
 	}
 
-	/*
-	 * Return failure for non-async IO requests.  Async IO requests
-	 * are not allowed to fail, so we have to wait until buffer heads
-	 * become available.  But we don't want tasks sleeping with 
-	 * partially complete buffers, so all were released above.
-	 */
-	if (!async)
-		return NULL;
-
-	/* We're _really_ low on memory. Now we just
-	 * wait for old buffer heads to become free due to
-	 * finishing IO.  Since this is an async request and
-	 * the reserve list is empty, we're sure there are 
-	 * async buffer heads in use.
-	 */
-	run_task_queue(&tq_disk);
-
-	/* 
-	 * Set our state for sleeping, then check again for buffer heads.
-	 * This ensures we won't miss a wake_up from an interrupt.
-	 */
-	wait_event(buffer_wait, nr_unused_buffer_heads >= MAX_BUF_PER_PAGE);
-	goto try_again;
+	return NULL;
 }
 
 static void unmap_buffer(struct buffer_head * bh)
@@ -1425,7 +1364,6 @@
 {
 	struct buffer_head *bh, *head, *tail;
 
-	/* FIXME: create_buffers should fail if there's no enough memory */
 	head = create_buffers(page, blocksize, 1);
 	if (page->buffers)
 		BUG();

